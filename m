Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93218C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A6710E4AE;
	Wed, 26 Jul 2023 19:32:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2718F10E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an9CiDguZaPc2MWMqm7Ovx/964wowXx2DkTnvS5Ng+EnTgQcCLIfzQmhDqWBH1eLZfmnJc+SyALzsUtXDvewgmUmsRHbiLiAQ48ZNdM6b1IlEfxEfP5MSWVo8S7O4t75WyjLPPTj7Yz6eDYArNDz/mA/4Iy1sVA+UFG7KMyD7h1k0h9YtWFNRJpz+l2RpZHNB38oXzKngk4vTsnlKF5MN1FUGTYk/fAFUcUuVEiUJTQSHVZA8gEMTfyOSsQaKUrusICfXnske7NLcZcYtIIJy8TrfZakx7WFBtEGZWvDK4G1SphjIObXNfxSzuDIXL0fjuT749J/bV2H0JgIGacqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh3K7yeUCLAFap/z/rMixsvPEeuR1G/ZJ2OdR32e0f0=;
 b=b7h1nnN7fsZI3MR4BeZnq+aV6P8VT2mjS+om+YgcaSvm0dZd4Z/WRNabGyesAlijDASKqKDAEsEimi5tLQ5e3i2GxDaUOTJ0ax14mon0VbBQFAaITmraHykXhqsKishyzaylabJMt6fvDAEDuIx2kHKCNt+jDGMrkXbzSsVP5E9QY4luFtWg9vi/sIZTvJLhu7WesBSPUw3zols9D4vz5AuU2imUSVS26HZ7RvhtX5ZSjj4qbu5lkAzGq+MUmFXS+F1LFk0mLsRaKeQT+mW6+v4108Ag1SYDNIbdZv8YCJwFRz+nIvVPengQx4qp6hFENVLQGmV8r8+tHzUrS1a96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh3K7yeUCLAFap/z/rMixsvPEeuR1G/ZJ2OdR32e0f0=;
 b=e7z5XNtnnrbUmwD3yDrB6cprEym2Ah/02/kF5isETp/mSCUHwjFjOe7h3avSV9HMnVJtueUvXsh7h61BjsaD/iN5UJa3x1UzHibv7kAHBwjhzdwdZXnUIk+rJ1Q1Hd3CkCdOQsp3HmwC78Mjpopc0iqKFLVfZoh2ATFdC8eq76g=
Received: from BN9PR03CA0155.namprd03.prod.outlook.com (2603:10b6:408:f4::10)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 19:32:19 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::60) by BN9PR03CA0155.outlook.office365.com
 (2603:10b6:408:f4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:32:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:32:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:32:18 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:32:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] Revert "drm/amd/display: Implement zpos property"
Date: Wed, 26 Jul 2023 15:27:45 -0400
Message-ID: <20230726193155.2525270-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4f1d41-d436-48e9-dd8d-08db8e0f06e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Bzw37RRveeN36F5BdLDKWSQ50YhpQMkS6EJOEoziJ8IAAOYSZgbGoVZ2WUfGRAqkK0Lcxv+P20aw3cOgTA/QF9SFlO6XbWBF+urOWMGzVNJwAWpqHWIAT4tIK1BjqN3M9EnN8OCfEX+5dwjzdpjSShgDZPUs391fP8Q/R1YKslUnvhIZGtCBV1JKsHwYXGC55IApBvuIKVDvFm4d7mePd/AE2Kp7Nwdtc8RwA3enG+7C0ONHiBNjg2zVi236CoxzObyHZy1c6+xg0PGhmHu6OWRtQajYxyp/zfZemgBHIOPhFTP4ohgBYfcIHCKbkWLZiOvtuLzXKtMYWElc/flNz6kiXgkvf3nlDzlc9ah3FxiDXsIFvIrt3oHdTIFVpDdXXprH+pO4g5PF4ViNbBONbLSW/AP+E6SQz39ZUfGacq3rXqCibWd6lUJYcBTL4UyIXUEX90YztGxJagG6Zv5FR5BNOuev1VN9M2pCoWscLii1+a5yCNQYgZCWtgJswJFS9SwkSyuPUQ/WTce1fZly45tVQFM8HzmdGsLPWXExraQxuDBTAqhyXInr98+UinNGCcMfHSioKx2VzMu2nxdfr+SsV/uPC5OMQe/oZJvzbJiW9Z6t+7M0EuGZ1+SVYhLMTrx+bNijGxCtXmSLehCqPGWu4vakIQziZeQ0+BzJqiMSVyv7yTJPFU+ygJytqKn6ObXUN3pI93W8pm1VLpSeXchMshSBqAbf8By4te4hWoyJGUbLp73hW6SD21mSrXYxdFSeCa+bsOcknyVBMJLxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(336012)(186003)(47076005)(26005)(2616005)(36860700001)(6916009)(83380400001)(6666004)(70586007)(4326008)(316002)(426003)(5660300002)(8676002)(41300700001)(8936002)(7696005)(70206006)(44832011)(478600001)(2906002)(40480700001)(54906003)(81166007)(356005)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:32:19.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4f1d41-d436-48e9-dd8d-08db8e0f06e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>, Joshua Ashton <joshua@froggi.es>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 6c8ff1683d30024c8cff137d30b740a405cc084e.

This patch causes IGT test case 'kms_atomic@plane-immutable-zpos' to
fail on AMDGPU hardware.

Cc: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Nicholas Choi <Nicholas.Choi@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 2198df96ed6f..8eeca160d434 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1468,15 +1468,6 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_blend_mode_property(plane, blend_caps);
 	}
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-		drm_plane_create_zpos_immutable_property(plane, 0);
-	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
-		unsigned int zpos = 1 + drm_plane_index(plane);
-		drm_plane_create_zpos_property(plane, zpos, 1, 254);
-	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
-		drm_plane_create_zpos_immutable_property(plane, 255);
-	}
-
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    plane_cap &&
 	    (plane_cap->pixel_format_support.nv12 ||
-- 
2.41.0

