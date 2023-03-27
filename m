Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC5EC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9318610E5B4;
	Mon, 27 Mar 2023 19:46:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D4910E405
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPoTQ/PW+kUzvslVBxA9lFvQaiOsTkGnyeG/SihhZsBB3+JDzjjAg9UjhgXuUlfbqkM/KJyFtVDJ30vwOtnN3HAeSuvWMztj7hUFePohkzeLnbs7CA6qa+JgDFImc7/rSwchHvgq6CrKw58BMFEFKR67C/WnIknVyzahIJ4KkKWinpZCJHcPpOoIJSVPpLzSsN3++Xt56nRmfyAxb3q5m67HNf4ArEEjpO58qH08cc4SPOY9avVMpKzXsJBzNFM3JgfnPInGL3jEGShzEr0lOziH8nPJWR9LzyFeX6XdRCcf4C1xwP6Gu7kieFDP5H90jGBTCl04loPrle0t/GVkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGMz3sxKVfEn/X77aIeG+59NkvDFV9ReKXZmsnQC8rA=;
 b=PsGV11zdt1JZ+W0TseJzSVLrQvCJa40czB7hgrREkPm9bCFVfgmhmM27ttME6j/EPtczxF98Sfaqd6Mnp21xxVvdju4k85Gl4KStQLhUy33zdAWmtOjSnnYAFUS6tBmYgQ+sgENGzQL0Nwx3YWZc0nNHs5dP1Jy47iN/7d1QiKZu5fxR/L+H7pFBL+aaq6BeZb7R7tG3GdORvj4yAlzpaF2ZDwwIGbEGMe06X71C5k7ArdPivYDenmfn8aOWtFfaBOX9mmL88XarjOWosYv0Iz5JSYklOobbl1Lki3rGQnX9yUQ0Ucsa0J4DXsohxXJAu7yS+XzoEl3CLwOZ56TEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGMz3sxKVfEn/X77aIeG+59NkvDFV9ReKXZmsnQC8rA=;
 b=cGSl2IphbdZrdm/jt4wSdjVWBlAZ8S6TIdzdqNDXbUVtaBA9gclOAtuu6DBX3h2MBUvjhOH1FS1Rln+NgKd6bUDu5PvSqWrMPc+h0WpJCeQvSKdzsOO5MZBY1r9O+dnZjMI2X1Zr2lSulo4RpXMfxudbIgvE63S7k8uR9Yq7FG8=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 19:46:37 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c1) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu: add VCN4_0_3 firmware
Date: Mon, 27 Mar 2023 15:46:13 -0400
Message-ID: <20230327194622.8109-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: a95213ee-a2e1-4b8f-091b-08db2efbf9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PQ1AxV70XNusgNZ/zUFYNJy/9znqTWXFNmfyu2e+gEeQgODAHAMwhJZoC9o1DA2CRe20tL4o+H07R3oG5n8W5k+kFBf+6/oPVUnbc4covQV9wx+bKjJun2NUS47dw0QOKlLE0yjpaPxnQOTt1Fd3au+Qr5ZfDv5LrxstlhkVuAIn0Kdbpe84XAoW4xVV7EzVvIc6bDcxKQauSOSF8GS8+LSnUPtGiMw84SN0eF+gyTHPucEFfkpnK5qcCfqCN84CxntLglU+NryOOij+bYEshiixioVoaqdFqFmBdoLjSV6OiPyjlh/GZreWPT090rSLIfr0ALpLJZRBA70E9iCaCd2P+EvekS+z0s5v0NPduNY/PYhI9IVmfpqAwdVZe6dFD5LIigRHgbE3zEiRF+JYj0/q/hanwXsFFUvvv8uu11o9xlvtVUGH3SRJgBpSV4q9bkMBeAo5pewJtBADIxIPsHRk8yFpW/3yhjhZDf0TZpyuGEOU6Lss3hzQjXhYxAqY3TvrwH8SffMMYPKEkSXNUKbdnDqzWMc/U/b3YPU+sdM9UQD/i6V+WN60nJEzVST/XwTY08S+yBtGTtxHFHxT3eFx8ib9lW/eYWd7Ofp+pstQJn3kaGSg3GSxBDx5PFY3YIUOH9OHdA0YMrPLdOwBHtOyXBWiPJTO6GCdwjxpQKuuYiRJmIrKobstnDuchrrMoYnB1JmZrML96obnJk7yUOgLhsCpC6I9uX1wNtTLV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(83380400001)(336012)(426003)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(8936002)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(70586007)(8676002)(4326008)(6916009)(70206006)(2906002)(40480700001)(82310400005)(6666004)(16526019)(1076003)(316002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:36.6743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95213ee-a2e1-4b8f-091b-08db2efbf9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add VCN4_0_3 firmware.

v2: fix fw name (Alex)

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e63fcc58e8e0..72eb12aa2e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -56,6 +56,7 @@
 #define FIRMWARE_VCN_3_1_2		"amdgpu/vcn_3_1_2.bin"
 #define FIRMWARE_VCN4_0_0		"amdgpu/vcn_4_0_0.bin"
 #define FIRMWARE_VCN4_0_2		"amdgpu/vcn_4_0_2.bin"
+#define FIRMWARE_VCN4_0_3		"amdgpu/vcn_4_0_3.bin"
 #define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -77,6 +78,7 @@ MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP);
 MODULE_FIRMWARE(FIRMWARE_VCN_3_1_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_2);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
@@ -111,9 +113,18 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
-	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-		adev->vcn.indirect_sram = true;
+	switch (adev->ip_versions[UVD_HWIP][0]) {
+	case IP_VERSION(4, 0, 3):
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = false;
+		break;
+	default:
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
+		break;
+	}
 
 	/*
 	 * Some Steam Deck's BIOS versions are incompatible with the
-- 
2.39.2

