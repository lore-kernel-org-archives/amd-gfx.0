Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E896C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B83610EFFF;
	Thu, 30 Mar 2023 19:46:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85A510EFD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2XIk9JKjTXvJVts3TLyeQbuhiJtpBldnCy0ib/F8O+ix/UUzGOb++2huTPwp9VGO9YKO3nguSXTjtmBV44ECyah8ZMwUR7ClnBtD81LHKEcMJxaQZQJV6ct7KXrmrLtpockStpj0vrtwKruw3bHunjFrYn2E/7mAcKQCvlbC1zeowv6DLcQ5Ja50NHa/zplHGrEjLEdr8I04aI+XHQp2e3BUfV5G8Ry87PIT/bIFr5Bt6XXi2QIJdt1V/5yGA153sYnssXByTFBaFzn4nvINVg08VFYF8C0wzUoOjJIGqbbwBzZoEBiHouW0/GNMZG6ekYyom8SxYqoPfXCPHMHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLoYM0h8U4st/WcB2ovI74nAuapbgKtvtgP0kAAXmIs=;
 b=CTIZ8bz+Hdgmnv1r1Xaj2qbw4ISmCyTZ9/oHUchICbitEvuCgWocKD8YKSCUThahtJHoEONGbN8zK8FL3DHJed1QYAQVXwF9k1/Fx4DABas9ELgfgkoF59uE3VrZTd3NadoDmMcBx2tcm8cxzumq2fIrqC4U9QnliqAlm+Uvk5538t7AI3wRlHzuNhyDE/GhS85Xg26hkWWiMOEtBG5lKWdLgfoewiNPspeRx6bd1DaR8g7r1H1bwdr2+woQs5BaL2zv5ObRtbeeTtK47Hg4vxeyf1wHGv6Kg+g+2MZF+ehTznuGlEHyMdU2giAgKIDjPjdzcjK9jerFeShGtTM1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLoYM0h8U4st/WcB2ovI74nAuapbgKtvtgP0kAAXmIs=;
 b=x5T6MB/adInzJqC6Ihx0cFWfEYyJxYKMT/jg4EQ4KXzH/Fwqx/eeAy2XXabG1KvTv1bDr96WIQfWkCI7W8LgiW29eL3feeQLAFhVst8wXc0reHUiP+kqMiVqi3ObY1D2aGltOEVFdW4KA57xKraI4RxdlzRt2vK44c5CJD2DSQ0=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 19:46:01 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::7) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: enable indirect_sram mode on vcn_v4_0_3
Date: Thu, 30 Mar 2023 15:45:42 -0400
Message-ID: <20230330194547.1135862-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: bfea939a-c62a-4832-955a-08db31576443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC16nVs1fwRLiNAFWs9r8t8ns2i2lQkxP/nVoe7QdqjoMkWJ5N8BRAAZF6IliBBZuOTTx+vAV3N1D2qVVsMkba00MPnLVnTJn65XOi2TwayiW+n8ASB4lyMujCHUYNoWk69697zG117IYz9/vXmMaTtwDI4rb3/Wlbs0oZQA08s2DyswhxLPz4krWMXZjiYUD8PJWEERJXOmdaYT91rl2z72iwahp8dqsr1eyraEpCacLAmx4FueByfzf8hP3Okz2huGbDxbj6w890Q2Wp2mBGvCEKT3To12VWE5LZvvmm38JcxNNP3gK537bORLsJZxwF/rikHVyvEZIFL5dirKln1QCTYILbs2gYG5AVqmEYqYrh9xikk9UZRxsvd4VS8gsBO0n92JFJSubV2FoYtkCfO94HauyO0UGfgkg9gLsPTVeVLdsqi0PONfMoScNWz1j645U4NV3I24Tm7G9NoX4TE3u7lD0ch43UB2KPYu96kd2vajJ5ZcNDWhPeHR5ky8mQ4SJtX6CO0FL/I5a+k5qVOL2ktFlqm8LtCWE48FsE6PC1aN4gRhb2K1qyRLiHzyafTODNOjs+d7MmFruK2/7ouiHE4+8zWqTnODxnn8LMhsgt43eaXon5+viRxH7slf9DddjtK28FlfqfslGjYE3QZiErsacVCcp+SdqciHuOe1XpwhlwHE9ObAs3YzYkSVbPPwXzA68lu1aCMf4n2KlfPSqnqdn8QO4Ipgoonh3TI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(1076003)(81166007)(478600001)(26005)(356005)(70586007)(316002)(54906003)(8676002)(82310400005)(7696005)(36756003)(40480700001)(70206006)(4326008)(6916009)(6666004)(41300700001)(86362001)(47076005)(2906002)(82740400003)(16526019)(5660300002)(426003)(336012)(8936002)(40460700003)(36860700001)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:01.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea939a-c62a-4832-955a-08db31576443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable indirect_sram mode on vcn_v4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2e28b19e741e..daa69ae766d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -113,18 +113,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
-	switch (adev->ip_versions[UVD_HWIP][0]) {
-	case IP_VERSION(4, 0, 3):
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = false;
-		break;
-	default:
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = true;
-		break;
-	}
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+		adev->vcn.indirect_sram = true;
 
 	/*
 	 * Some Steam Deck's BIOS versions are incompatible with the
-- 
2.39.2

