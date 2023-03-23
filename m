Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0678CC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EACE10EB54;
	Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D4810EB32
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3VHdruK3w1aGvOocTO1waZM8lUchA/v92b4ElFCWDqF+Bc2KSzL0588I/yIbj9b2TyCwAOFbRlui1LbCIjcdhoUD3CkcR+ZH7/6kKOWQ/eFbaDBDJazxUsV89qutIdpGy6saByBzmvELe96oC5q0O6bsb6vEQZHvwOH2PoVtZRhaBiFcShDLbPJKpSNZeZYJcU4rITafEqZsduOPmyuEWRshhJgiz0W+UW5LDcmliwvcAbPbqv/cTUnRHZRfX4atM+A7B77T1UyNNrU1oU/1Vy7OqPC9aLNp5cPF6g4FbUlrRic0ZIuxI2LWmy/LKxN/VfVIgmXZt6uyIdb6t7p7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hLMtGowbb8uRR0t/vYCF4NCCxECZSVs8T0+zC0Pzo8=;
 b=euaoH3UUdLCvtQEe/qJaZnOcL6vbkjQXewmBpuktNlkp+wRgwVpn9LagDWjkSuWaLmxB7OTEf7k7nNOkOIpbEqbfuwVPOfHprwOS9GWQesnA9Hb4zrLxK5MIuDtPLeyx3JBi1BFN/+t2+qytOKrVuxKT+vd/WMNTJ43hJpPlLVE1Gz8I1JVB56maEgFGvI8A0R/DagWD7S/px3fO5nY+ovxnVp+djRwcE2vxHMuLzOs1mocN0Nmv6wkcBpDX0winoPaSGvV05Sg3uYDEt5Om1sVQgi90Bua+TFmAXOLlqxRTgq52vmiyT5blD7bm4ou3Js/d1h7q1X59Unmg+abZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hLMtGowbb8uRR0t/vYCF4NCCxECZSVs8T0+zC0Pzo8=;
 b=FKMM3/0Auwmx8Lbz+utConchpQb27f6ZJYJ88+EqMfh0+mbC1gAg3sk/I7scWJ5epHF6FaM4oWukcvpSOmBZew4tl4epb7Ja3Y1M/5RZKz8fV0yfIULtNg/RXAllqMQSMCxMY5LbqcukYNC3PQj2JwfBq+IxjiFym/szHnXJbog=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:50 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::a6) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
Date: Thu, 23 Mar 2023 17:40:24 -0400
Message-ID: <20230323214034.1169310-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 5196d21c-f09f-467a-576f-08db2be74577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XmcJPll0WPKheuR4rDmhvQjvD8XHnOII4QWvl0BiLR3PkFBXNWlkAE9mvhq0de8XNxOGJWvywnJNNsyxRRnQqZomBeOnDPBgfQ48wJ9QoDnGlxWO6YGEi1UZXYUvQRYkBF4cEqRI8UfBnGvvSx7xRXU2K0PfDAqy8nZbPutKT4a1j18/tdlmpUvcDtCW5R24wLLBrwmVvptRiCTNZL4f0FxUINmMS+G/OqO02FXxC38/14HMAXlFwLPllNR9n2B/PWUzzrczIGcYU4UFB4BBPZ/VS0atDDdF+cfd/uHsRKJPYnHr728WYG5WRJdMhQxFgduLRRWUnN1+8BeEEvf4jXSxx3lw95QhD5C5OIxd1MNgHLmbC/2/u+160Sxz6thN4vplioE2ENMZXWhxiVkwaXbUaZGbXt880VRFkqOnMcxqg2TPwoASvSoV1YGMd40suu4dJ+a4fk3n7aULpDD8Q3VtGJ/C42AFzLEfv6v07bIJ7jHoKPE9xKPieGHUB3+2mQu5LMeEwpXLDY1gxRIxLs7/xE6b39qHgSSSrH3vJIlUPED8KEcymp9paGI70pkz6JLa1G87R3u/NJE5moO2moRvfJPxsecE7NS2S7ODF4N9KF5ws4P+j+XLOnArMgeb1a3OD8oCAxC/pJQk4ja+lBaZoS44DtwUIC2KQC1GMDvyfBliA1HlPwGFsjp2Hf0t8AB39i5RU6dgsn5DtpDct9bHunqo00YtRC81VNcbJo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(8936002)(4326008)(6916009)(8676002)(86362001)(70206006)(70586007)(41300700001)(478600001)(316002)(7696005)(2906002)(5660300002)(82740400003)(40480700001)(26005)(81166007)(356005)(1076003)(16526019)(36860700001)(82310400005)(2616005)(336012)(47076005)(426003)(6666004)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:50.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5196d21c-f09f-467a-576f-08db2be74577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX11, the UMD needs to allocate some shadow buffers
to be used for preemption.  The UMD allocates the buffers
and passes the GPU virtual address to the kernel since the
kernel will program the packet that specified these
addresses as part of its IB submission frame.

v2: UMD passes shadow init to tell kernel when to initialize
    the shadow

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..3d9474af6566 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
+#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
+
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
+	__u64 shadow_va;
+	__u64 csa_va;
+	__u64 gds_va;
+	__u64 flags;
+};
+
 /*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
-- 
2.39.2

