Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EC110E84E;
	Tue, 22 Feb 2022 14:38:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5E810E84E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxBm2JzsRgJUzPdmlDpppUkEbMUr3O0+HPQOlKevjwDc5uQCdYolXLGE3cYZ66aCDhm9JcOlUQVoGQRpSIpkinyeEg6KSdVnQ9M78D5A67QTBzJnT/LGNz2wbIhC67L9WfZuTpPmniimcaeSFD8cXOWfkvgH+E0a1lziL+IrHSFMgyRpXLflbUAOu7pgnoAmmQmWJJOjtE0XQVUk70z6HBMKbwsTmAzXacDc6XhnTqDqyjmOeKEmV7tIbuj9mdy4n+nyxeLOwOBBbcr2khH+o7pVpfOb2wdEcbEspnvke4z1eZ1ObpFvEC75IE6eJjRiRv72JrMh+QrBFcbHHu4TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=bZWa1fOvvkXTUMdYX4b7F/dJwjrmOvJWxKBmMOsDKa1ORb8D5Bz5NptQp8FAEKOIWVr4ZwYb3AuwNzZNt1NI+ZP1BcnJetpuslxKE5XE5Vc4ZAjbdOWA1TtxM8H/iamiEf0DGzejP9fdBCmJCkL83GIqFzS1vbmV/zv+85GI1bcbj+3D4t8+DrtOQ6bM1NZdum87tF9v+CZLf+aCSldQBznpei7E8R1xR/4h0motk1D8QoBBi/djWUeVBQMM96pMvrmxPC4gcmRXPbQt5Yjfor9GwkuJ+V2Ohjlm6wd0NV1t7cHttBqSDGlrZz7g/2HbHtGk3m9cqkE/sOVa1es25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=BX1laWJ9n6w9Yg1ggOCLXarEVYZmo+1jkGLkslRyfba1uVK9M/TmDKWyoWstcQxLV82ttCQZrwkH48EmUwD5oUWVuXKxkm13xoIXgmAa7/a4SQ/DzkYN20hTlXQLbqbwTI8w4QcuAC/wP8Ar3eeH3MpZQYOwBvftiem0vETtYxE=
Received: from CO1PR15CA0070.namprd15.prod.outlook.com (2603:10b6:101:20::14)
 by MWHPR12MB1789.namprd12.prod.outlook.com (2603:10b6:300:112::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 14:38:10 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::25) by CO1PR15CA0070.outlook.office365.com
 (2603:10b6:101:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 22 Feb 2022 14:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 14:38:09 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 08:38:07 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v11 2/2] drm/amdgpu: add reset register dump trace on GPU
Date: Tue, 22 Feb 2022 20:07:42 +0530
Message-ID: <20220222143742.2575-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
References: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64489b48-26cb-4e62-9368-08d9f610f2ad
X-MS-TrafficTypeDiagnostic: MWHPR12MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17891680A24783B165B4CA59F83B9@MWHPR12MB1789.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9xkM3CrzwZIY9zE2aFRwdwvVK07mBdMTiSbZFJbG/SL/GK3JYqb0UsbkG64SUZnauqTT6Xth3st+CbwaaEhHVY43NVDhzQFylTecWQC8Ud6UJTYXu09x7xql5G+s+JS9gNafJFbloSC94Rc0nzXzmc6Rz1rnPRmUpeNLlhvWSih+LZURmJhO5cHDKhBoMAm104Azm43CkV/ZSGil1E+rsvHCUWE6y0Ra6WEr9kYiQLnkk7xlv5hzGQfW/Cd/xMHEL/jlF7VF3I4WaMTznRbTlv2+jh7GSXyUfWwFRLSIFDT+bH8lfsNlKbXPhIZubpTHftH4QKv6p1vwAn3/3iD0ThHMsHxi3zeSSm7M2ztvGWMu7gLQYK4C0037O8VxvVI62hs0pY+Zcq6W9XH12VA8T7MrPHofvgv/gxtOU00ICcFTiI1wOCi757kfElaRTOyHFpNi3l29tBbNuT9fQ+/od737QInhwyBtP56VA37f+VFCT7dTqq6E5Zcg68cK5NslH0904pgLHOO3TmcGUgyUE7OvSTsWvN+U4y+KJ4vjRp+lzXfss4eNSJbU50JruELsU8IZieSVyWZtht8LvkGJH4kqpK7XlJJJpLmbEsIOqkuCWfbfhzsMFHAdZFeEZ0WOnWf/mlO423SM2vUuzV2qQTBKCuE6LAF+1OAzsOXH+bvuZFvnfJ22WOAiqa28dkjNyK1NrmCUTfsR7dUa/rIqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(40460700003)(47076005)(426003)(83380400001)(336012)(36756003)(5660300002)(8936002)(2906002)(7696005)(16526019)(186003)(26005)(70206006)(70586007)(2616005)(81166007)(356005)(6916009)(8676002)(54906003)(508600001)(6666004)(86362001)(1076003)(316002)(82310400004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 14:38:09.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64489b48-26cb-4e62-9368-08d9f610f2ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1789
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dump the list of register values to trace event on GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..7c48fd716adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,22 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	uint32_t reg_value;
+	int i;
+
+	lockdep_assert_held(&adev->reset_sem);
+	dump_stack();
+
+	for (i = 0; i < adev->num_regs; i++) {
+		reg_value = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+	}
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4544,6 +4560,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
+	amdgpu_reset_reg_dumps(tmp_adev);
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..b9637925e85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(uint32_t address, uint32_t value),
+	    TP_ARGS(address, value),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, address)
+			     __field(uint32_t, value)
+			     ),
+	    TP_fast_assign(
+			   __entry->address = address;
+			   __entry->value = value;
+			   ),
+	    TP_printk("amdgpu register dump 0x%x: 0x%x",
+		      __entry->address,
+		      __entry->value)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1

