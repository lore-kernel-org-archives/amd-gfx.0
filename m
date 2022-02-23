Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 07:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF6310E7DA;
	Wed, 23 Feb 2022 07:14:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2EB892A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 07:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/+XT4WFWsJgpQYV7im87QPsRvczTBFqDtovRTnz/CjoW1O8qxetbOxF+rJ2rQMoyLz260tVVTI2cGjEC9yY8jJ6XBhU2c+xU8f0XA/OuF5kE8GFj0XBRGCEr9ag5XqNy69rVUXKX8HVI26xJ2gKnut7zSGvZJQVdcHc4ZGzynRxbrLICUanmfyuYrQQHRB2aOmxt+Gzxv3bNk/XubLRp0WZTXY/pcR5cGbKMT1InhSJrEirDpKTlWJbPtJKtz7J9gXGB9CNX7u7/NiYIJW+ukPae6H4RwDPqC7T2glrmRiWCLGBzwUVAOH3WhNYIWbGR1URmK3ayDMg1UTsrnY+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=FPh/xedEgS/WcqydwnOBYB2tP8Hm4UmNpXlGJxS/7YfUTy6waDEkWvTdiMqLaoSVkhU74RwKeJO/JJ2P9n8u2XbWAIIlIjLiy6nB5B2dLGireS2QgESyeo5kY/VRrxpaiKkVE8b3cPwOU6HlXJEEkq5ZrOU2t+c0TSH5VpR6vyFM8OTWpgVqj+mmiE8ceh2UYNzPljbtV18H6RNsIEGCFa59jvKSz2/fCQ0JRGzew4GAUNgqhp0Xzo7Nnl9w7Ks0HTvtIgn9AWcX4+XONfb4McW6YH2rCJTU3D7Ejhw0zFMFFPpyRymTyJNWNcZs/iNLZyQ4wJiA/GzDUmPizwZq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=jlB0lyq2VQaXkMiVpeb0xD9QdBAUU4AQzidXzsBhtFaXYrSc4s7eI+g+X5BCkgRQ7E8itGPTcNjltkeXf5ZaiHUkcrg6gwVjWSY+5mnjF6KkUVW/+AXCH9huvKE88yk/+WBrS1vRqD+SBVzJxRYocQDSx7C80sgsrimhmZRbuns=
Received: from BN6PR14CA0022.namprd14.prod.outlook.com (2603:10b6:404:79::32)
 by BN6PR1201MB0257.namprd12.prod.outlook.com (2603:10b6:405:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:13:56 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::96) by BN6PR14CA0022.outlook.office365.com
 (2603:10b6:404:79::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Wed, 23 Feb 2022 07:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:13:55 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 01:13:53 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v13 2/2] drm/amdgpu: add reset register dump trace on GPU
Date: Wed, 23 Feb 2022 12:43:13 +0530
Message-ID: <20220223071313.3757-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223071313.3757-1-Amaranath.Somalapuram@amd.com>
References: <20220223071313.3757-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa93d060-faea-4e10-6cb3-08d9f69c0df7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0257:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0257EC3C5949DCC5949FE4AEF83C9@BN6PR1201MB0257.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO5Xl5V0UY+wCFzNI9V2LVZJPvk/ZHvSwRlKT2rueiQ+iL//Fgm9fahR0F4ch7oavBRNOUmw/IN5je1ZN+AKvSZrfUmS111FSOkWmt39vtfefywKad406uT/TLF2WU5lVCHiGXvBzDraPZmSCaV+QBlK9gLFOe5ZDSjUbIM1FoqkAOo8TEiFR90UeHEQ7pIBCx1Gk0ymqwnAnsox3NShAz4GRYXC8jTU6uQIQv7Dx6q9vFvsLBGl0QOU57rsBfB6gbN1wTL1kPvCUSUd7PLgeNfKNbfElEUCFB/5CIvH5lXBfx+HR6S8VQpWFdh2OJLCPJAmGF0AxQL5lqrFk6MJY9rsIfIDYag8P77DB1n77gkrDQNNxbCQ0onxzRI0LKPOI9JgVmtgy0tzPzy2MSUNqcsCGOoGRnSbs1j/d0vER/EGIvlIZaRGwn97ne0u9eFf8GlFXmv0BomWvQQ8GJ7MAwslARUUjH3HjvbqtTkcluobchXVeOWuh0D/S2/HQG6gQq7aFYIx+gUJ8HVT44VeSsKid9F5qKbZM9KsjDfxXzkLV5JCMNkcVP2i6Af2kAG1m3eFyu4KwOXrsVTm5GW9iW+Y/TnZrAFrWHzJfkF6qM1Ygclc3NVGDgrp7Ar7uBXaSM9ZbkjsneCbLJXEPA0g45NxMp5fAra4qWn2SfU/gHAar1PpskXmQFTR6YNwigKuauazzag0no2y8msq8xB+EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(16526019)(83380400001)(186003)(1076003)(508600001)(2906002)(8676002)(4326008)(70206006)(70586007)(40460700003)(36756003)(2616005)(426003)(336012)(36860700001)(47076005)(5660300002)(356005)(54906003)(6916009)(8936002)(316002)(82310400004)(6666004)(7696005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:13:55.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa93d060-faea-4e10-6cb3-08d9f69c0df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0257
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

