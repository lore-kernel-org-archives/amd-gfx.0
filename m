Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D13C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 15:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C341129AE;
	Mon, 29 Jan 2024 15:50:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B081129AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 15:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUN1cgJdowhhVj6dMD9N9J2hMbo/ApNskmXvReUqQAyfSB43DkX23i0yspRZ0Rllg8p7Bn64Y9u59iOE8f/92v1xxTYPuup/AR/HM5NQZYwKgVI6Y7hYQL4yZMMYiX6hfJoFsJg9PEi8q5C131g+/BVH6PlByR6bNXREyGcHTsphSlJU03+UDh5gsZrb0A31TKuLNPGREa7/xGwG2OLoHW7/cMjSKljtV1KNVPs3VSMaDWzsXq9nwo4MVZ3saNLCksTObPmPZsP22BzcFakYzKL1+c7N0AZUgmjUi7tCeSJ7hA8e8UDK8x/A6rGUysUt9A1ODYEPzFpvKgO8c5pgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kh6nbq86ICUwOgyYVbNyrWnS5yyTYoJDJAXB0mysBk=;
 b=h6s1nq7kVOsZmYv5J1r/zeKJTtSQ9xxaz7HQNiNqz4OLpo2l4XLOxoJhN9LbReT4KJUwAlbGE5Qh8wk6TeYYWWnKZ26mRemPS+SF3O1E1qQElZdjxFaHtzezSIz/fmnPaUW6iXe/pwGto6RYmjNXGeEKhILsSc9JOPbA0zIj1IbnUI6aHG4ZjQZBrVpSqfQ+9BbMOL69TwqPnIHdvWiPLTN9QXtraOkmwkw4w1UUyO702CV2M8erjx4iO8dtT5hg14pb5BjdZo6MzK3S10g7vr5YyS4sZTjH7Dy3ccQNYFiPA9FQaN2p/OneeeHpGuzs5ktd4/R55ou+/24TfeipPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kh6nbq86ICUwOgyYVbNyrWnS5yyTYoJDJAXB0mysBk=;
 b=3Hya3FMNiqE92NiXaBzqdEfnz8ql7Q30IXrwrmZLQkb/yYGhWwfHKh8tEmIAdnwNozlP7bbkWCm7WHkNIUqeVZ5SzMXKQa0HE36RmRMxjahJzlNaqdnTjA7kMQJ+9q2D8BXC16QepINX+Lj9a4KwQpZUN2jW7fE/eUgLUuLCppo=
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 15:50:12 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::90) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 15:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 15:50:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 09:50:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix buffer overflow in
 'get_host_router_total_dp_tunnel_bw()'
Date: Mon, 29 Jan 2024 21:19:50 +0530
Message-ID: <20240129154950.131007-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 179bd98a-504e-420d-c1db-08dc20e1fa64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsOydOZ8f33C5MtUUBOOKId42YexXgOUGpxP6utwuifhZIMvgtgWGdwHozKbDc+FcRu9mdMvEas7G8NY6dx1iEij/PsR1oA/sI5tPgD1YKZdEsTqPy6y+Hs0R5rGV09qx65OSt82cbMKtAWU7AWRETWOD7VBZ+wmKzzU/FqP8rMIvBdJQn0OYllv97DPkm+xgMXAiAk9s8hRoFB0Myz3UgV68V+1vVsD069JrCRq6a/B31DOC9lQ0ymegAz5h6dg1Lh+OVaEdCAq+sY2JcJCljS6B7KRk3YlGWAsExTTugcHm4jlr4mMStPuLWp/YaVYRDfEixZtpKaMyP88R6r1hiWRbAMbipvKUs37on4Spcvd0b5VjdwbogtZMuBX+52PrD7l9vDWjcvLsBHQFmAhUYx4GwkK1SA6UJqm6Z01bUsGWS5FQjmrej3o8vqEubhS/SP0mM3joW2H4ejN2mIee9z8fmeKcvhj5LiFR4C9RsH/1hyo0CcR1wXXtdi0g/j2XelfOraGeBzPr5udzGdsH0JszK/SrRIfDn5r30r8h8ijZ+K5556YCtdYwONCRwedAdluRyVauoSjnWX1AJmmaCy+2/bv59ScHtWZ0rE4GLi2Wy9ikRUOnqE0xaoscKlkBsBGqE91GmmeWDfvuErxNYsCQiCtonuIBgWwgp2iz2A5PRnmGPiHayfu/J2kxkEcUhYvLNEbvHUsMRXJU5JR7MG3yaGxtzqHceuA9SCRfs+dnMo6uq3tQ4nylHQpunDTYEQkpR3xrOHKaVhYczeB+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(356005)(81166007)(82740400003)(110136005)(86362001)(36860700001)(47076005)(1076003)(66574015)(83380400001)(336012)(426003)(16526019)(26005)(2616005)(6666004)(478600001)(7696005)(70206006)(44832011)(316002)(70586007)(6636002)(54906003)(5660300002)(8936002)(4326008)(8676002)(2906002)(36756003)(40480700001)(40460700003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:50:11.9467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179bd98a-504e-420d-c1db-08dc20e1fa64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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
Cc: Aric
 Cyr <aric.cyr@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 PeiChen Huang <peichen.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The error message buffer overflow 'dc->links' 12 <= 12 suggests that the
code is trying to access an element of the dc->links array that is
beyond its bounds. In C, arrays are zero-indexed, so an array with 12
elements has valid indices from 0 to 11. Trying to access dc->links[12]
would be an attempt to access the 13th element of a 12-element array,
which is a buffer overflow.

To fix this, ensure that the loop does not go beyond the last valid
index when accessing dc->links[i + 1] by subtracting 1 from the loop
condition.

This would ensure that i + 1 is always a valid index in the array.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c:208 get_host_router_total_dp_tunnel_bw() error: buffer overflow 'dc->links' 12 <= 12

Fixes: 9ed0893b7c58 ("drm/amd/display: Add dpia display mode validation logic")
Cc: PeiChen Huang <peichen.huang@amd.com>
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index dd0d2b206462..5491b707cec8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -196,7 +196,7 @@ static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_in
 	struct dc_link *link_dpia_primary, *link_dpia_secondary;
 	int total_bw = 0;
 
-	for (uint8_t i = 0; i < MAX_PIPES * 2; ++i) {
+	for (uint8_t i = 0; i < (MAX_PIPES * 2) - 1; ++i) {
 
 		if (!dc->links[i] || dc->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
-- 
2.34.1

