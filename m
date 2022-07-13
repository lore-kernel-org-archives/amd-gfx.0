Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FF1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 15:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A5D9B71A;
	Wed, 13 Jul 2022 15:22:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6455E9B723
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 15:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W97EWsX6HDdaxW2opJL6c4f1DZN5gTuAo0RoMdHaJg/f0Tv/mzm+9SxBEFhcMzi2f0GLPi/2VTiMmQtgTC1lxH6HNNYB2hStQM4aXjx5GvzJl5p5uyOGwvyeHXYM1quQH1Lg/E5G6esC/bEkUBBglAAdYm3+NVUKcJNYxGQW9vBsTAzsYODUBm7sgc73+eOBU5QV9Irjix9Axq8rwCA/JpIJZMhPw4/ytpiESDpIqp/spjq7PLt7RI0NAyhpYR1DpjmUDEUJpqYkpHjd/TUJnupHtV0QmI/8m+ZixNshmAjefAbLPRTXpxYUMvrcnA4Sl1pwhXeITCmZPcO7tW2kRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs3eVALn4ZZut8kn/FIod1MS44hwd7iNzXcKG59nv/E=;
 b=oJqRKmElUpU7EBwsTs/eK1pbk7+V91IhDUyfPqDlLpKC41xGPlDKL4BMJmmwWCVjJBlbBR0Lbj42RhIYCXMlAkhAp60nQl+v3NJp6blrAHkDmBLnhbe1Zd/MXsDWjf/xUB5P3ht6PGti0jFgTpwGICmqSG5v8bG7sC0knvF9Cj41lDOWJEK9fKEzLaKDobh4L6DgOcCoVwnP8eafa0mW0zqLsQy1aX9yE4VHUDnTbn2s1oezkyNZTnAMHre/Few8U5isxCnj9ppT2crsyIDYOBzsRmztHMXrZv/u/DlreRCAlAQHOQLopuYLodg8HD1+ohHwPiGckm7Y/hjZjhG/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs3eVALn4ZZut8kn/FIod1MS44hwd7iNzXcKG59nv/E=;
 b=2AOS/VDWVLV0fSecZj3rMgsVGBZ+s2wrJlPzx0hPGb8Ez4tPBAiJPc3Q2ZfuPveP//0M00lYqIW9UsvLUwRNfjBYHMTLIA872GrdfzJcEhMK8Y0oEKDeH1piwrbPyPuWRHp6D1BDgkoHNHMu+wQiyGiWTRS9y1McXRwwCbTzqZc=
Received: from DM6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:5:bc::46) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:2f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Wed, 13 Jul 2022 15:21:37 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ee) by DM6PR13CA0033.outlook.office365.com
 (2603:10b6:5:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Wed, 13 Jul 2022 15:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 15:21:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 10:21:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: make retrieve_dmi_info() static
Date: Wed, 13 Jul 2022 11:21:24 -0400
Message-ID: <20220713152124.623903-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45962a70-34b0-49c1-5db9-08da64e360cd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoBowHMX9Ns5zdOfkIYKgyC9oiDYlB0dQ8sIiOSWus98ejTwUHlv9w5F0oCNiuFQIBI5StEIPMtAGNn6RwofCu6h2V9ItdLZrRwwcoFoEeAVzEfnHfmpaH0Vqr09a8HnwkdU1YiIZ7k/uDMT1fZq//mUECfPvBJmU97hOKh9mdHDK17HWX0U9W0EKJqWTL3jqJQdroxVizFFyV6lR4rv1MBu0+zVavq5QYefMIXBQcMh51dg+nDeVhbOGY+8ubOAuwZVElEJzsKXqvw/CVnvL6woUcvrQ5SAfvVRlO0hnEN3eNLBJuhQM06LgBExu4ovWSX1Szy/bFkiDx9tuliESGP51sQw//Likr7wzlZxyadFQh4YAEv7f57JZEqtBIV0IZFtXHw/ic3iQ7MTNlCqECMUbRVRiCiIIDhHr9MzuY0vglw6RS89onxK3Q7Mhw8zlvhbYjIUPswVJ5ccdqZllSJLaia29xsULkOi4w6+U82lBoIq21GxfPqlsFaT8E/2Lsyh+3jXsWzGZITQjx1dM6JuzN73ofeoRr6odXUKaWR79muHPsdKHEFamSPFttnZufqdS6tq68dMQQrtsZ/GBD5BkmXYSSUYhm92tarhPvD8Xkpc+ig2+eRixnGXsOjXxAiGrrtlBldZKRR1e1KGUFZDic+B0FtZg2nFYZ/FNrHP7om1/e4Yv6VP/t5UWtNJ73aJWmQJMkwomHl8+Gu/BkB8oucCIYXyADWHvDIRKeqeNcyIrc9y7gnesOH53jx4/GLP0EtoLuMOfSBxSWoH2hl4AdUGOkseWI0wOJN3OW4GziaQNPYbguP8az9LRDqe5kbnFvBjmbCYEuNA9JSsvOE590jU6ie0dbfIC18LJkY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(40470700004)(36840700001)(46966006)(2906002)(26005)(16526019)(356005)(40460700003)(82740400003)(36756003)(1076003)(336012)(81166007)(426003)(70586007)(70206006)(186003)(82310400005)(47076005)(83380400001)(40480700001)(6916009)(2616005)(8676002)(36860700001)(7696005)(478600001)(54906003)(41300700001)(5660300002)(4744005)(8936002)(6666004)(86362001)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:21:36.9678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45962a70-34b0-49c1-5db9-08da64e360cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of amdgpu_dm.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 21aec55abd1a..c03f300851fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1446,7 +1446,7 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 	{}
 };
 
-void retrieve_dmi_info(struct amdgpu_display_manager *dm)
+static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 {
 	const struct dmi_system_id *dmi_id;
 
-- 
2.35.3

