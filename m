Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E234C001B5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3774910E786;
	Wed,  1 Nov 2023 20:09:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0A710E783
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGyI4Ijf8i0CiQmrLwXttPZbIYHVzyJxPu51revyEhMdnAlwVyFwbeVCEgpCm3gw1afZ3lgnYxUEckbg4cQHfzi7Ybu0hCZCki5us2sNd7N4zJ+bwRAHIdLw7Lrcvh9o6nkbJQuyVdem3pZa3azDZOBTjcmy+YuZK98kdJhDDuwuJ4x5RyVQ3D1+trPB655LXFwQ6YMH5/3vDixCgR5IbnY607sl8myhfmX31ZncFi3p2wWFl/ByxXgPY3cnH0rnwlsoc+tyqXGg9AyTXq317+B9gnmpuHwIULj3XbcLg44wPZ+EfUUAS/ZVuc91lsbgypyTYC+McxNQ73FRaH03jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7zJ0EPxuuPHyQ0JnbjujmwXrb+vYbi4t9sWxF6s8eA=;
 b=ebBnJ9uGtKD+bAVonGUcF7WARvdIjvX9TH+tyO2ljIxo4C3dk2uq5DKdf4EJB7XeVy2SNG13Hxcj4UgmuqtrANuernmIAcmiXHXSZWuo+vvrA+JAU41KITf9JDTkFTr0mvvv/V3ShGdUzRx8levgJNLoqOeElAEYuhsu8QaFkOgpd89X4Pyn7VutcvfDw4zRj/KPOPN8WvyC4iMNNdb5MaRfceyVFWPvtUw+its7k0yHqPOqIYRxsXQhGrSe6eaS5J0NxiVQmvhV+9PfnKH8LjgYf0kMJlR+lFfbgSsvKnL9SuFkfkxB96Gg6G9VCClFvec6QGwGzS8ScmjNC0BqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7zJ0EPxuuPHyQ0JnbjujmwXrb+vYbi4t9sWxF6s8eA=;
 b=C3Hvqi/11obFhpQq+q2Cw9gRztdeSs85swZKMOk/V0oPRaJhiXi5QRH+Mie8Yxzf21SeXZHInTgvlPbTGWWQGdGBl+xMX3COLwdw87YslSiHjZDWhyurJ8N3TI04uYVat9wrJkXGXjy6PitkF0gBl+LzSbbxkH+b3/cfwneiQsc=
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 20:09:09 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::5b) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:09:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 13:09:08 -0700
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:09:07 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: Promote DAL to 3.2.259
Date: Wed, 1 Nov 2023 16:08:32 -0400
Message-ID: <20231101200832.995436-13-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 73773e7c-36bc-42fc-2808-08dbdb166887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5hFTGJzWTTyMtxlc3e7CeKnPIwGKgvW00uNP7h1lffZmy+EUs5e3MJoopgalyEZJJisgzfEtnAdd2sWhNxZ48mN6b3sNqSbyYV74uOGLZh8PvmJcyISDC+T9p6bkEFED8l6fNrFThu9km8PALYi3ub5flQy2cDuqgwYjV1E1bppJZ2DBIg4uwPMV3hLYdi5GxfLqX7NTTABTo6m5uAqMUDqrfZHKd4AMq07HX0ziSJbgZfJNfMXEhFT0QgCyT0+ZlQBIK8EW4J0JSpuHBL+OrFP0C9axqxPVYmxxLmUG8xd9KziZQS+51Cl/Y+Rl0TPhey6rILmNrR8QYXaavfHxOl9GtNLv3WlRF3h7pavSfx2a9MCfCij79g7EPUkf90MBg9rLuzKINGoj8qNbW+Wiq1e4DXBN/tkElM0xzAubtrD6qC9jQYVir/YGJ33GFQFpEVhfKck5Tv3TtKYBv6sDDgTG4zlCTN/Y4p5OXIC9jyvQqU2gBxKY93zTNm8w3OpQPU/1y6y6VWHZU9q4p9+EvaMu2TzTfoK9eJlzEOlmbozMwbINbOj6n6U7gYLTpnLkP6Gfv0R5MaRlMoOcLe+zzho1DQWDcX7VcbKeGbQ3FZvdC3A4Tcg3gTjoHUamSi81ZHjN193RT9W0+fIsOeCYYp6+EyYHhEuHSK858saxCIBYSKdCb8koSyMmx6NQW/ZNdpaLWzYI6m2zjRoWhM6gygiQMDdzTnMuj2UnZZ8k8FdUkBcZ0Smbbvbel0soZCIrgiSIQLfiSpxWWYr3I2QUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(47076005)(336012)(426003)(40460700003)(70206006)(54906003)(6916009)(316002)(26005)(40480700001)(8676002)(4326008)(8936002)(83380400001)(5660300002)(478600001)(36756003)(82740400003)(81166007)(7696005)(2906002)(356005)(4744005)(86362001)(6666004)(2616005)(41300700001)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:09.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73773e7c-36bc-42fc-2808-08dbdb166887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>

Summary:

- Enable DCN35 physymclk root clock gating
- Fix DP automation test pattern bug
- Disable OTG for mode switch from TMDS to FRL
- Refactor DML2
- Revert Fix handling duplicate planes on one stream
- Revert Enable DCN clock gating
- Implement cursor P-State allow for SubVP
- Optimize pipe otg allocation
- Save and restore mall state while switching from ODM to Subvp
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 09328f1670aa..c5e7da302acb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.258"
+#define DC_VER "3.2.259"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

