Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34798E81E1E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B1F10E55D;
	Fri,  6 Oct 2023 18:51:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E2A10E556
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bot6x0D54izHZUG2vsGPL1fPy4Z5tBV3jyKFII2UJxwJgX6oa/DJf44ixhPM1vkKOkG9J8IqdxD8FK66nxR1co8DRfbhKMwfU+gPVihF+nKgj5bNriHiu0NbvUt3NFzg6ZW08BouvyceK4N6rCbzRoCMEkSNUEwFnNF0qgaZDsll+E2YLFr7kxubs0IdEHykgNAdHYL2JSdOq+GRSTmn+IAe4kipZbRTR2kGmuHdr09mAXhNLYXQ96slP1KAjQ78aqivgDkqjQy/c5Kc+nIjloS+up9Yw/ponYCo3eJ2uzXtw5+x/zVO2eh+aBWERp4+XHqGdnYf+ey7uzCttOjAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd26FrU8wFHJC0k/LXduIGT0CiUCyt5c9/g7kfBXajQ=;
 b=JkzK1FEXLXtZQT3fGB6exQ06eu6vDsgTWJlPaXZbZvUnF9noRzSxVheE67zck42DgaY57fiPzWPue2lMxoyplqFWdic5eEmklnzY+ku7kaJsguXm3wMZ4gmxU/8HvuFGJxcT+yIJNV8leosc1NslEYyXjn+Vb/c+wyCvtXywBPkQoeTo57FWl6hcrHKGVmv5juV3fwxH1ywh51cAI6pkbl8/PbODMMm9p4mngsn3XZH/G6sCROzeL/ePSK92uqGj5wwy0rkfuqH7PdC1NSxAsGoK310FIb/Dy6n5PRyCKIfi9xxghWJWaTFNaj5rVx9VnFG9WGEIFgwutyNB0HWXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd26FrU8wFHJC0k/LXduIGT0CiUCyt5c9/g7kfBXajQ=;
 b=XQSoPL5lHg1AIUCDU1Ibzlq6/cVL2y2EiXxbKq8x2l/i+IGirrkDVeVCV3OWyfdQQOMUWyd4Hxf/kANidD8mPzI2LEiKMuhIKSzlEOeTo3oXLO7ySjY3Le84u8cHAs9qdOU0H5VIEpTFMjt5PpqWIecC3s+u/VMVnRDiJ5bCY9c=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 18:51:22 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::d9) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.17 via Frontend
 Transport; Fri, 6 Oct 2023 18:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:51:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 5/7] drm/amd/display: Catch errors from
 drm_atomic_helper_suspend()
Date: Fri, 6 Oct 2023 13:50:24 -0500
Message-ID: <20231006185026.5536-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c2147-fee9-4161-3f93-08dbc69d3c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTuR50NOyM3YQTDTSdD3RWGuwtPbPOY+zzae5TtAB8WUNNu0d4GqBws4b+/zpd18fzkEvRgG0X2wvw6CUMiqY3wOoZ4Y1kxUjdJq0IrkD+oFrWm6RLWxB1F2XgIfXPXtFu8bTXYgfFgTSchU280qXOpVcndinPD19GtCeuAOmpqx153E36crZk5q++zSxFCV6TT1xYbz2hHWMVLBcoDb/LPHCsGet2wHCH5wFEnp0jjzfXh0WIluZgAuPg/9OkZJV04wueWc9qhP3rQQ5TsgBM+onneop9m7f+nRaE5D0mmLUrFc6Jf32IvesHuMJb8HH81+iubEY3AvixPDA2BaLG01Fz1M8Hb24It2o63+Pchjzb8tSUnPNhgwAlEEHEvVoaKn2d/UZztsY0YpychGjOWt83bs/5mJ1W2jSTldSzNKAJUMEi2QLGuzudYrIibPQEsrHXxW/58YeTxkbYcxu9viqpZEzndBQUREnyMhXUZij/FNWaQd07UAxb/YyyHTD0MEeUEHLR3WNzB91/T5O6YK/scBrweypjhuhwFmYBRYI6UFtSCHkRxb/M4XrCtEFB3EItj2/xbOgBgHi3bOSs9Pe9AxiUHx+DRYJJEGylKhelOzUqbIMHt7jLC1v/VdJz2+AU72wnZW32RTHgG/hc5+tf9rskvF2GBJaawLabdX4cbBN0tXhtkcOnh5Wf9BSA+LtsHw0/As+6YLANWr1nGc+qJruY44b0A/uypNTlVhKQOSedorPggYyCeNkLUD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(336012)(4326008)(8936002)(6666004)(5660300002)(8676002)(44832011)(70206006)(54906003)(6916009)(41300700001)(316002)(70586007)(966005)(40460700003)(36860700001)(47076005)(40480700001)(2906002)(426003)(86362001)(26005)(478600001)(36756003)(16526019)(2616005)(356005)(81166007)(82740400003)(1076003)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:51:22.4377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c2147-fee9-4161-3f93-08dbc69d3c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_atomic_helper_suspend() can return PTR_ERR(), in which case the
error gets stored into `dm->cached_state`.  This can cause failures
during resume.  Catch the error during suspend and fail the suspend
instead.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * New patch
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a59a11ae42db..63944d3b9e8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2716,6 +2716,8 @@ static int dm_suspend(void *handle)
 
 	WARN_ON(adev->dm.cached_state);
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	if (IS_ERR(adev->dm.cached_state))
+		return PTR_ERR(adev->dm.cached_state);
 
 	s3_handle_mst(adev_to_drm(adev), true);
 
-- 
2.34.1

