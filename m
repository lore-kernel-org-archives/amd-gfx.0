Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826D1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 17:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B80918B09E;
	Thu, 21 Jul 2022 17:28:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF4F18AF1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgP6xDk7yvo14+/f+49afTIufFBKguTxJqdUwJqUzoz7lPIfXloYcX8V7HEOqh5QBpjYaZ4kbcvFz4fFN2cc1W5BvkAb7yS54tXFnJCMz1w64QlEcQQoYZoK07XkcvESJtXs4xSVSMbiWqmr5oQV94REGWGpnVXoIM6cBRtTzyEF65bOy5AMrgrYuiepu5LOeFafFSPWdlTPOsn3j5jXfWrmSZkV7BRuysaFzk5RRqOlWouktukaSlxO3TYgQwAA4D+AALS27ceTIFI4GlyhgBb7MCZ8qBeKtYYeDfDW2dbjIwySk1bD9z/WI0xo1qWUiJj+rUbHUNwzJaMFZfyGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdc05R4FvSArYCqV/aJjbYd94Hb9zGKfli6BTooe9+I=;
 b=UqDeoFRXgpWFfx3jzXukmNsFifxhhnDt+BkHcl9blCQGSaTAlrCa8Y8IzjIJOrOF0AIK8V1EPmcpRMnC8puWVSDSZJTPBR+2yLWbWrMIo6TfQ3FufZlAZF3+hVhy/eRGrZMCnm+WTknQfV779p5Zq0p7zSBs3Cul6Sr6Ne0wWgdfCuJSFTq8lwkxSgAVOlWvEt/8XgyXp8MUyjYGnagrWPS8QmjblnkCIHBxWTwtRrJLFGbH30N0GUVFzRSupChrs+psFlxuaFy7Ntm8wSVkbCzN2nuOsx54CWcRIdQMpw+pAA8JOpghtG5lmS01gQGgCKe9ZDwqB/1W+wM8GnVRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdc05R4FvSArYCqV/aJjbYd94Hb9zGKfli6BTooe9+I=;
 b=UDoT95mmeyL9/8vivwX+6JnD2FYIsgorC/H330fjw7SqZVDxrrbE3TAVbFTDSZM9oZQCscCxoI1xG6isHNFz1QV2qE9mYBQp5iFm82pBBTXWTawDUzyE/oeMgtA7SnDPuH0Kvd3f7+8m0f15VabgGWlJ6/DVw9ZBfLatZyMx6YM=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 17:27:56 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::6b) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 17:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:27:55 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 12:27:54 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: enable VCN cg and JPEG cg/pg i
Date: Thu, 21 Jul 2022 13:27:12 -0400
Message-ID: <20220721172712.309984-5-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721172712.309984-1-sonny.jiang@amd.com>
References: <20220721172712.309984-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a966faa5-100d-4b76-b495-08da6b3e597d
X-MS-TrafficTypeDiagnostic: PH7PR12MB6586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXxRPsnpk4+rzM6tm/zq+kkeqF3Wnc06MmCM1h4FWWZWeFG7gogiWnfs7mjd1Id8hiU9Zd/ueKzi2VO6tbitTUzDOHUgSM8B5a/hpMRSc+j6pKhjodTFORVoaCrdzkp5sdmTiEG9hV54XRP+VWYoUsLnmEQyDjiMmVDqMRaRGeMkCoYNEwFVMc5ZgCDg2GuBYiJMLMJU4r7kVT+LkhRTHTEKyCWUl1ndWW9lycNEK1Lr+dW8ILkNYHp+VdRKEoVRkxN1bAtCHCWshIHQwADUYPWIAnsMI1LDT7quQ2jr179shpPOFK1DchTsq25yiNKqA1iLct8pg41A6BAwECpvW2PIy+GyU54PydK7lsExYQ6WnQwUYHutBFOKhm9oBXMEG+fZc67UTm3jXXH2wWniGpEHf30KSBtxLEKZF3yrjnBFnRAryd81gSZyGOIeUN7z5/L98ECK0LZJF8Ypx4StSV9qKQm511xbE0C148FF/6URci5OTf3TlzeHDUJ4HwYrbav98Il1FRc5r5JR8TNDpiWeHxB9x4kUPvjpOl14WvQmZGmGvVOUvJ62RL3n7Amq84OhyWmFeM9FtQcP571ynob9dQdLW+pCueNFbw4blnBlaDBScsoLmty6L3QnvO/8ZMRhRce/0uPKHSrW3GAgZRM/mZK/ovntPUjYeuGxYAWmF8kuaoMi4C/nHdP0FuPPFtetoql+dwNnGEIwC+WRFcx04RQ+R6XvUY6+ibxvwX28MJQvyaRx6pY0jgatKcXBQbNlZ/58ghhzl4rpiTt0AwcORNylknb9+j0gzOsg3VasmT15BsDxor7n6xVo1nZX7x0C1XVL+Ae/zqi8P4ZPShecxlsNnuv/RPaup0grzxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(40470700004)(2906002)(44832011)(478600001)(4744005)(54906003)(6916009)(2616005)(36756003)(86362001)(70586007)(316002)(8936002)(4326008)(8676002)(70206006)(5660300002)(336012)(40480700001)(81166007)(40460700003)(426003)(16526019)(82740400003)(47076005)(83380400001)(1076003)(186003)(6666004)(41300700001)(36860700001)(26005)(82310400005)(356005)(7696005)(129723003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:27:55.9120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a966faa5-100d-4b76-b495-08da6b3e597d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not enable VCN pg because encode issue

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 68e78983f956..52816de5e17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -585,8 +585,11 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
 	case IP_VERSION(11, 0, 1):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags =
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags =
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	default:
-- 
2.36.1

