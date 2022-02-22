Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4549DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E4F10E756;
	Tue, 22 Feb 2022 15:36:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D070B10E731
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1lmIsCMWreMt+c0sMEtEVvIvensy8Ucx4XP3TWsdr5IGwtOtHcaPkIoyPtZFi3dQaF1l3fLc6v2LXz72vI21jyTlML1QGVtDzY8CNNbyIF/MpgzNVy8xbn30IAbYC7exfVBeEQhi4ygd2BofP+81iFJuRbZlCwZUoqEXZ5cfVq6JeJ6mW9EaldwnJ1FoLYJkC9W+mbI2JK867eRpGAPt1og4ay9u3U6qF8iyw4vkaYSuApFjmwxGWO5Zjvcgsx9lL1W3LDE8SSk/wd20LBGCW+0LaXlrcNnUuHbSueQoQ6vV98Iamqz0LZEcaaUGj4W1evFM7nv+kE/6PE3OJ8aMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=EwfuidDBQbxLcYtbXPg3DKKSKfNAAyD9VFXdfh/BWmGujCVuMl9T8iQg4Q8ZDQdz+FZDzb6MDNI7cWEYLOueMOXSVPT+LSh8OGQ2w0pq6bsMbyJuuTY1EDuKcnaawE7zt3utcl9lQwrIaARlfR5V16AWPaRs8gI07Sgrph30Hr5EQKZXyR+dttfmrxDk51HkxIdPmJIJofQ25nI8ZDydHB75mE1aMkFhRuBe/N1JeA66ANmfQyYZBGuS99CJwb90yYbqYyG1dHnuha306zfJMY2/xvVF2D/CxXKDtOXLCriEwe8CUK13Cp5CLTS4T6g2/zOsssAdKqZhD5qvzmKEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQQQ/EGxZzf0GAYUvHXpHnyq3fTN9g6vtYIs4j3WN+o=;
 b=MgtElAiqqnOZbGzBjbx/5tChjeuuUZLpPG1BDSaP0p9t/XJCQMoXt3Hl0DaMtfQRfxrHFaDaFtWgj4nm7NjT9UiR1W3ZOZtsxOUnJ3cRN+r/dKXTp2QDgTB+wbRo0pQJRe1eGUduzZ3rM30qwKBquU3WVDpjMu2H9rhnsu1Ln2M=
Received: from DM5PR19CA0048.namprd19.prod.outlook.com (2603:10b6:3:9a::34) by
 MWHPR1201MB0077.namprd12.prod.outlook.com (2603:10b6:301:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 15:35:57 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::a1) by DM5PR19CA0048.outlook.office365.com
 (2603:10b6:3:9a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:56 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 09:35:53 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v12 2/2] drm/amdgpu: add reset register dump trace on GPU
Date: Tue, 22 Feb 2022 21:04:33 +0530
Message-ID: <20220222153433.11464-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
References: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c34c2ac-0611-4fa9-828d-08d9f6190517
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0077C368906CCA65748C258DF83B9@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoEfXworpRuGV13bi3BtuHFG4RU5QlxJi7lvU5KOJ8nN3pehxhn99BKe1xMvhq7IrLiH+B9nPJImOGNFPEXUKoBmH0VPOdk8M9A1BXMpHILs3tQkL2/8OBVFeAMD+8K41uoFeWU4XjmJk2Voet0ifKgJD7QyXk96bU+lK3jD9ZO5DdBV6SoXYPrvFhe1eEE3ieoIwxh4CWrFBEf4grGPx99ObufPf2fw4HLmJmilWnMMMmPsubAllLc3FzLGceeXLfhx3rAvvpvJmpJczvbcOMFodO5uEafhiN1Qc4ZQF/Muk91D78zJXR1AzGXYJqneS3SiG12h7hFt5z3EhzM1wyuxhHSAzd4S4rtELldbdKmyov5Cp79XWumVtoSVh/QL/WevddK/fwl3NcR5vs5amh3nGkVtKqfvFu7EHRjk7eoCfCLxqhh4udANVgxhxoe6MP4PvKes6Tyh9WSZDfNPG1xRrLyJrZ/TMHeAIS79Yf99h/1j8vh7DIskJvdeDCmiZgRKKZEPI6oKXLMfJRn1bbgRAEwYAFcVKfg0qALBlAPevARIb40wCaQsVz+J2SWG4f5zMQQJVu8WZUcoGTe0tPyFta02Vn/WpSnt+XmpaB6UCNPRwbSnx1L0kjnFwa2TsST1L29HC6vTDbb3OBMCq3+25X7H9nMAwpajYkNqtDwUJZxK5fKzA3zsw33z8b901i6jj9ShbtydBGIXUIjroA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(36860700001)(16526019)(70586007)(70206006)(2616005)(26005)(7696005)(1076003)(6916009)(508600001)(316002)(6666004)(86362001)(82310400004)(356005)(81166007)(8676002)(54906003)(336012)(83380400001)(4326008)(47076005)(426003)(5660300002)(8936002)(2906002)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:56.8584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c34c2ac-0611-4fa9-828d-08d9f6190517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
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

