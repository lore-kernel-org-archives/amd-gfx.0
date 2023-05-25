Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334F3C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 07:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E8210E477;
	Thu, 25 May 2023 07:22:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8931110E12D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgWNwwljKqMzIUoHz9l56s5WF+l/iulLDktMBg3OtvG/HZYxSyzqqmykFhvHmFonu0gCrz9tT3maA/mCqL+9sDi3Gp//KrUIZPpkpK4g0TTV7QGaUig8o2KhGGpKQ+mQed7DgjTVVkT8qCYMLU7P4V11kpyslKBPz7Pfjq1Hrfbt3qFjroBW3DtDW47Ur3Kr708q8fDqFBtJaSKnjH1Vv6yVXCLHZAfgArFoVLs170Pw7yY6YI9gk4IR/1J6aVWKhlGOYevKZylSbivBrLHfvFLXeqfunzOfR92PmdX2Z8pUfcIsnob/qYGEHu2jX04MtXKI52xSv0vQl5t5PHYkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9H8kDG5ZqMxlZm7E4q7itbij2QjQfqrbRA3rqfM7kk=;
 b=I4PFhPNRcDMMP38S5a26FdKZmrQMkQsYhUUIqSTAzAe2jPpx6LyUfbBJOOFxapmbjqDNcZJXFldqZyj+U59LJn0z58RU0d//rFj6y1MiUWqk1gEDSR3jObaR5FIjzUTK+EYRXAQQ7N00ydi9aR2ubPt0+5MUhIMEIZb/lq8SMSdVLK/FWf9X52GpjEXgRG5WT6jiEjDNCJQ5w6fm7yjg4WzO7oqEZLOPgPs98KwFp1h3ZcCHr24+8IwG2AfkMNwobeEmFpwPn0c31W3MIYRQse162/3FwSXJVMZWK79c8CLPZeqER2DyBzlBlQCEO0QixOwTj8Stk8bz91MVPrOh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9H8kDG5ZqMxlZm7E4q7itbij2QjQfqrbRA3rqfM7kk=;
 b=cjG5HhcMrGbQl++i7/cEL1Qga7xWuZ232asZpgzPdK7u62Ab3ueAljNHymzooww1CvT+M4kXNskQRrVTUBC08pwfdtyb+yK9oDgTNu+jCfD4h5t9E6E40BJoO1GggyFXxTdGEXQNQyQ2UZc2pDIthpU5rOPxQtp0TqLS05Hhelo=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16; Thu, 25 May 2023 07:22:32 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::32) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 07:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 07:21:59 +0000
Received: from ikshwaku-Myrtle.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 02:21:56 -0500
From: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable tmz by default for GC 11.0.1
Date: Thu, 25 May 2023 12:46:17 +0530
Message-ID: <20230525071617.2758109-1-ikshwaku.chauhan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: b4199440-69d3-4fae-6859-08db5cf0cde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeUCx7Ra8N5J+LyHz4Xt8nvQDRQWwegvhruMFTMk6Ftyn4fZEj4dHD6MzIFH6JAgFlxQ+UGHICUf/x2ciPsVFmTquZPeCtrRGzpOoDRe+CYkF1Q6K9DJn0YY/H2xksS0KFJ6u6FUGGuCPTx1p2yzcKyYUJ+JPVvtO1XDR9/6dLn3oQzT5f4pjmTPc9hy94x/WS7tb4H/p2eVp5S+NAPJzyXAK/TZo0pFZ8ER0/uH4IWChHGEAf/55ac4nYl/t43BR8wt0Sx90xOCpQ1NfVc8JwsaNIi6kc3QdpI1Yvo/ZiEX84VQQAB9PVlkjsOZLZWimx+jIJ1ABc+pPBrOnBxNlz9LZlB7tFF2eHNK7ROdwnkCgCXDTlpDhtyrADcXSKmoL5p0bqYxOn3L9nB2tR3tLdxq4EdSmnAnXT9J1gsPhVD/tbWBp/J1PM35OlyEatZbKFjQrc/hS3yx80ps54dmn3Y7+CqJFMa0evKopKXNSboy4aoZnXuBuE8bj73P14D4e74KfdhT1IhCsuj6RkXgDlNGHS530ZWmVndv4kRT0FbNggn4jXzcsKPA6UUC4d6xOCNKKV6CnAKREj5j1tBcF1UJVn43nbn6LAX3vIIZ+2hbcwbBQcd6beKQaCYysD+P+bqYtVUAvnr3Sj3c/Z3EdS9rKZfn5Up382Ue4Njnh6AG1+1g82h62+afg2G+lpWbrxxKxVfV5Xu9at2M+qyUDVqWxY4xb8ZJR6n6MJCclMHdJkC4BZjS08ezvIi4KWuNJMT2PpG110Fkom8wjIdx1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(36756003)(40480700001)(82310400005)(86362001)(8936002)(6862004)(8676002)(41300700001)(1076003)(336012)(26005)(426003)(186003)(2616005)(44832011)(70206006)(5660300002)(16526019)(54906003)(37006003)(316002)(70586007)(6636002)(478600001)(6666004)(82740400003)(81166007)(356005)(7696005)(36860700001)(47076005)(2906002)(4744005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:21:59.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4199440-69d3-4fae-6859-08db5cf0cde9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add IP GC 11.0.1 in the list of target to have
tmz enabled by default.

Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3f5dd9e32e08..348d856626c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -591,6 +591,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 3, 0):
 	/* GC 10.3.7 */
 	case IP_VERSION(10, 3, 7):
+	/* GC 11.0.1 */
+	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -614,7 +616,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
-	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 		/* Don't enable it by default yet.
 		 */
-- 
2.25.1

