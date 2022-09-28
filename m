Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C61DC6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B27210E9CA;
	Wed, 28 Sep 2022 19:41:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B31010E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUddNhTZzk0S3t9f1LcS0i7RVvpCgI9tsmb714T7R6RUwAP6dv7pgwZu26TbKUh9Gj8R2fOyAtiEmYsbfZbCdTvoT980IqxjbTP46MgLckF9VYxzQr0IV0yVHsbp16JZ42S3x7hvOcuFAruPktNmoCGxuQwOajlWEVDefwYM2OF9H6RgFXouqoWrtHlQiFk1eM9+eWyn+eMnSqIV/+QJ1Dth96Ys+hFk4WwC6tz2IRlQouTNj2bCoGlDNY19oNplI/CDdqAPLiGiYY9Vh/dYdY2IsD2G6IXUADGBv5LuWYVcbDqKdgoJEvWaYIs2qdiKUK4hcYIUjhyfeAb/h2iujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahfLuYrIFJIvURxKxgXBarUfCPVFDu90tc5yAna/Ffw=;
 b=FuRngP29SYpn4a42AWxjdVBfonwFk67iSSRhL7kPtoaKMmYvyOtVChXJcBnIiTQCfx7JCXATGPrg66EZgtlLgS/n0yeJG9fYXzDPHpK3lvGxuVGi+U1y02BEPpHPtvPyCH97BumL19SiCs8I1M05h9FASvtIrwcl3uehVN6Lk2wahJjt37XgrpiT+2uw4VC8PDD0QFE+BRSCJUXn+0S/CTI0kd+F71HjByEsTMLGeLUYDYxKWTkzXSyyc96D2GtCpiuknt8jAyuP5jgZ/kJ/ha4D1gdj/aOv5v/QWJzUbCmfspPrk59JqszYIXk8fr9AQoptGxBEGncsCvH29+uBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahfLuYrIFJIvURxKxgXBarUfCPVFDu90tc5yAna/Ffw=;
 b=sANiCg7o7TRE7jh5p/1LH5+gYWUtgng8nStAi/bXDQXA5WnRJKmii7jOjECJ1KsRM1dmLOPRjmL3OS0/XHkdqAzOBs5Y2HnyaTiIjIISCN59w/q5Gq5mHUDWV9vYZfRr8f2dtAYYM9U2M1BGUan46/p+7jlJaaMjwIDb9BfQrxE=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 19:41:11 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::55) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:11 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:09 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/36] drm/amd/display: Keep OTG on when Z10 is disable
Date: Wed, 28 Sep 2022 15:40:07 -0400
Message-ID: <20220928194028.144879-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc6e92b-3708-43ad-0746-08daa189657b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FO0rus5umxBHhrifIKcWFh7vyn2dSXTuaMW7zFosaIKR2odkO6qKbk+Rw7lwW8uR90FJZC7Q0jo/+6+dGjwSYiRCInql03G2qutHLaVdYQVXb2VDdudtJJfx0RNtPc/apMgqGK7mKGgLn9Aq7HmTGdCCqWG+cU1tg9SpHzWeSapFK0obiejEl16epjkLG3DytfBb3ak5fgJ0Y0oiCwn6u5gXUhP21jL+Chz9fLk6X/AvcxS98YOlhT0WSmEGQjqqv1G6xLPOq8PvC6hi0CXapj9Oa7Tf8CA4vrOmeCaIQDNyv87bAgFwm1ClmJVym6lozZ1cdP8z1wqbLY/ckclfuV20mKgXaa9lxVHLK3QzYFRAJ4nLK1Woq7t3+rUbW6WZb996ql/VfdpZJLW1pdbcEHWkGFnXoD8OYSTxfzLMhA8gCVPoDFSVhm6bLf3e7AMIAUriRUXkSRHL5RFRJbRKyqf1V/E2h2rRKKfsilpDq20e6ig9UBiClFS+xhbwi+OnrDIq+C3DJtMa846jDUQAmErzdQws5NEszM8wObqR+t5c+AjEEwuFDCrPxzyhtQiJ3DlTb0qT13/869KB3/KOuEZ2QxT/Y3/n8VwqPwqmJyvbGxniO7tZuzhrTAc250zGDchFtOo0pfpADW9VLeoi0TV2XQ3gp/a1c/YE+Paaknp5KUCXXu5OeY9hGOPXpt+DTRdGAePvoFJynCBHFYwVwP2ybscEaWNzegOrd2NFe2eZYMGNqR3vnGBCGH55wT01Ggv5nh2J0ZeDZ1LGzmtWGGQfsufSHfVPg0gA8maaqvAXa83nL4iqAUidAH60FtAf8qp7xoZR9yIIv406KXMxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(186003)(1076003)(83380400001)(16526019)(336012)(47076005)(426003)(40480700001)(36756003)(4326008)(41300700001)(70206006)(70586007)(86362001)(5660300002)(44832011)(316002)(6916009)(54906003)(356005)(36860700001)(8936002)(2616005)(26005)(7696005)(81166007)(82740400003)(2906002)(478600001)(40460700003)(8676002)(82310400005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:11.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc6e92b-3708-43ad-0746-08daa189657b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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
Cc: stylon.wang@amd.com, Lewis Huang <Lewis.Huang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Disable OTG when PSRSU with z10 even if z10 is disable

[How]
Reverse condition to keep OTG on when Z10 is disable

Reviewed-by: Robin Chen <po-tchen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cd14ec5a5c25..71cf6776998e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3378,8 +3378,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
 		case AMDGPU_FAMILY_GC_11_0_1:
-			if(!dc->debug.disable_z10)
-				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
+			if(dc->debug.disable_z10)
+				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 			break;
 		default:
 			psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
-- 
2.37.2

