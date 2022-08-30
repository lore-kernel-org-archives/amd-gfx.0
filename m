Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50851ECAAD4
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 21:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D81010E1F8;
	Tue, 30 Aug 2022 21:58:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5826610E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 21:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGsmNeDSbdJbbKXdQ7CDo6gImipd8EMkr6i1yv5ErdzLRFRMa1NoBA0GKThogLmlEp2XRITH8ugxCrEmAhcVj2+l1FN5sQqtGiZdvP6rkF6/SuO3DZJ+Q6mcy+FTqpUICcQYGeFm3rBA08LYD4X1bgLGxk+69u300Y4mHd+y6s6p6TqjurFi8z1cfYomEw9s1FIR+uyl/c7W4gvZmdrBv3QHpZX3feUX5ukEGI82+PK6jsM6K7E2mP0zdseW1wiBHpbbQoBRnICC/U8ei1h/jMBi/EO3+n24Cyr3iEoktxgTT37hqTO+hgrVi9hUcyIjuzgRlreklpuFkKJrHkjAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHOgf8W6BueJ2nQ5LdYoojwv17lT7a9cn1664wOFaJY=;
 b=QmjQdTSanJOcdf9qCJAc49H7VVJmO54r4daatpLn1tcpmOIsj5DTdRX9lInk2vPRdq33HXP6t/mRTxOc8kG1EVx4gjDmshA1oJFDrHO8rZCGOltzenfXrqdp+NjhbR2EK57IpS5sbyCOqcWw8StU3V0mNemBZIIvJ3Rt5rGpKp7MR6mTNX0sFtZtigi8ryb2PlQ5jlvexzdXNWz1FJbdYSielaO2VZX4moPW3c3alfb0dV5/f/C+q2YHrieHjGPjAOotwcYXJYSFqKTFi8/0mTz8vU8dZzBaXNikomSWk2q9rYHODPDV5jpErnwyzmWUx8c3JZo7MFKUjTFmaS0J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHOgf8W6BueJ2nQ5LdYoojwv17lT7a9cn1664wOFaJY=;
 b=5dwWlCkB17qHJu7vWGblJa2T8HYpqljt1p8dx0U38qhVa8vvWbAZ+ThGI7IKkwSxHsmjk6TO+Jz3XhecfMU7sTFCDRORBVD5yBHSXuz5q5BDI1NEs6WIltbqBSgAlrz0luLOhg1NEEA8j3wauDSV220gqdqBnDAsOUA429igW88=
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 21:58:10 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::89) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 21:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 21:58:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 16:58:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix documentation for
 amdgpu_dm_update_freesync_caps()
Date: Tue, 30 Aug 2022 17:57:52 -0400
Message-ID: <20220830215752.26536-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c3ddac-aabb-4bfe-758d-08da8ad2ba2a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB+WbqyUI0N1VgYhcI2egRUG2mB5Ez+xU5iSRtSbWwkyHdxWwZo0Xgdrlw28W3Gn6bXbhUi2UqC+hky2LDDaPs7da+cmLOJROQMiTWx8YBSzuCzR/tZRYL0DZ+VE6E13EjquOBzSV8f0dAO3raXzL+don6svS4LafwMcFg7UzYeGIkRkeRoGQslh1SD2qk9DdS448qclM/YhBKSi7nGd7zU09p7tusmiwveh8fuHK+u/c1NJ+Qo7ZgzL27lAooP7OBNaRjKcj19hBkBh84DLXg3vhnigHgtJMi6XbMgKuCGOKDUWvxlAS3IeFZXlvggfnOcVnCZFZAbwHpatOO7HRVfewu4xw9llScLwazUzBCgt00ytIEaqcrO4hoGiOYHaD0hzL/1vajFf6HOQTBXx8gEPkhJGoT1hTjA24H3LerjLp7PbrRycP3BSxb96uALApKlJAH9SAOfSRkL7GxmzAqrZgTB5dk55izpm0z1v0IJUTutQxQFgIlQh/K275kINh0xQTVeg13FL8KDnrtgdga5SUWX483IGswClI3ToYbxkLim5ZYNIn20JEN6U2tY60oFOwUOJVRUPaD4ynRVhT5rY3I7qw8Xwm4OM47hRU1MRmflH2mbeKSCSwRSwRkfRKoAUXhbhHrXHcTiyj0N07KRPmNnAF203NRGuAMYmxMG+momsxqx0TtppR54jAK14iSiyiEmYb0X5pMdhOjusuK6uKBmhqu6TcMa2HD/zvnSEfI44ZnInihZLSuQZ71co4nhjcY8YNEPnUVX1E0kCaq7zPAt7YTO9bbjIUThZ96M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(40480700001)(82310400005)(7696005)(2906002)(6666004)(2616005)(82740400003)(336012)(186003)(83380400001)(26005)(426003)(36860700001)(47076005)(16526019)(4326008)(8676002)(70206006)(86362001)(40460700003)(70586007)(1076003)(54906003)(81166007)(6916009)(478600001)(41300700001)(356005)(316002)(8936002)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:58:09.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c3ddac-aabb-4bfe-758d-08da8ad2ba2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Harry
 Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Document missing parameter.

Fixes: 8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgpu_dm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---

v2: fix aconnector too.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9d5ec1ea23a6..b053c13a81a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9936,7 +9936,8 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
- * @aconnector: Connector to query.
+ * @connector: Connector to query.
+ * @edid: EDID from monitor
  *
  * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
  * track of some of the display information in the internal data struct used by
-- 
2.37.1

