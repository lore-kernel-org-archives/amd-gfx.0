Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C4BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDF810E8A9;
	Fri,  4 Feb 2022 19:04:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E023110E918
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFPnpJk1hyilU7afU49pHxsZd4rwpf2/EKAeWtWqGhwkCJ8mCvIIFxbKjqpzk0sAd9tYjakjXAYPwII+V1qw8YgML6wl6zqWLQKZgRlIeSUTTGiBiShMo6Unc0tfyazjJobxraeDGex1ILCgZY6vd1Thr7mxaYLqLezl5Wh2MluNG1WkFDny92g+9k/t5QVs+DJmA99CzF3F4DJgvLnvytuE/1EJb5Y0qIU0OgD0zJdKS7zYLuE4/BR/K5x7LW0HU0EVImlzkQXBJ/xfEFd2HwU/4L92VowCY5YwbT1LmejX7cXYJFMFxAtV3MBKWcj+nOszdU4jOkWhRq2iC+KSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=LG9J6tGJE4fRnXhmAq6YlIE4SrSiIX0MrXxt6R0XEvgIYAtwbGN3CD5jZYI8l8IDawjprlcvel1eUnYUGJeLAN1paDdXdnBX0DrfEhS8462qtBpoqxphhK5kAAKP7LtQ9oC4HkCbl7/htWZM5qMiDlqnwY99eltojArKM2p6VRSCg3OQWF/U7NAg+MKEbzuFqTLkuR1lZbuJOZN5JE3hWvz2VI+szibDk25WmxlGlKtQaAMWBSow3/g2LeRhlnKhYU3cwm1ydh82jVGnZueD5OaBjmimvuoytiZXIW4lIEoczGjiHgr8e9Rd8X4d6HXSsIMcE7L8D4HCyG0Nx/IGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=czv76Y/NGDRQMsrdOezehaS4U9SvaM/xIxZ0bbrlZ9GjGeuSG2lM0gD4Ad9b/Xa7v+DUErbmW9kvOu1dL/1HQyxfXwcHtegivAo8AC2ZQ3NK9gr24RvLT7mfjpl4fNsC4a+NXDL+xSa4TsVj+CFN4ITUtH7kiNqeYUW3DnX2Dd0=
Received: from MWHPR11CA0027.namprd11.prod.outlook.com (2603:10b6:300:115::13)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 19:04:21 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::8a) by MWHPR11CA0027.outlook.office365.com
 (2603:10b6:300:115::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 19:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:04:21 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 13:04:18 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: limit unbounded requesting to 5k
Date: Fri, 4 Feb 2022 14:03:47 -0500
Message-ID: <20220204190357.94538-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204190357.94538-1-jdhillon@amd.com>
References: <20220204190357.94538-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c7d7f1a-93e7-47c9-0ae9-08d9e81126f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2666:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26665DE6CC979463868599AEFB299@DM6PR12MB2666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P15LV5cREwrooGNLoSAaKwIj7WKLWFWQxKU/RXeJHkwNAfANd//4V0/8G5QSwavSefGq7nL3yWOBq+ursN8RI1UTzooDi2mgwYCYBe7BFc2E0toSw1WjQIAZnIe6gg+OaFY8EDUyJHHsMeRFY+m8v5uxq8/IuEIRBCq7V8qbrC8twfiejFc7b/Y6s/z0PcMFR1SAltTmg4gWJgucKDMNEj0pT79iSTdkk+RW5uA7CjzEc8hkX0+0fBQ+3pKKN4bLSj2r36n7fBk9+Fm0EeHM4494V7RWDSgM/23dHyXQUYNRQclJ0Oqzt4xpPyy8/JDRvoZ7z61VWuptxg0csy9RPE6ccfpyFWPdTvN7BSs/HTvGNPxxFimy7KhN4gtp6jux4T2etJfggiFoeo500bNh/GdDWernQMC2dnESUzk4QJ3O4QlUeRpYFTu/N/3lq1pf02S11MXASwexWikupL96EUFK/EOWwFJa+4DH/q3kzWFCzows4hYMMNc5cR9hUkEi42Bf82cvu9XogwE8mRiLdA5GzJnoJua8c5rO8KoUilN2EqscB1mwWatt8G9X3i1knrr1OGtAa68ISVaEbv2qfPLuvvAf0DhSPsw2SPNRGpYpm6YoqeXwSWGn1m0b8nZGih1tChq95OOpag8YkP29gTwAkCjhJbdQBHjqHCunkBMb2e6Shzh/a94azB8KaxqlwPlRI68RWrJQzZY7Ovftg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(1076003)(36756003)(2616005)(70586007)(70206006)(16526019)(8936002)(8676002)(186003)(81166007)(26005)(356005)(426003)(336012)(5660300002)(6666004)(36860700001)(6916009)(316002)(508600001)(83380400001)(54906003)(82310400004)(2906002)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:04:21.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7d7f1a-93e7-47c9-0ae9-08d9e81126f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Unbounded requesting is unsupported on pipe split modes
and this change prevents us running into such a situation
with wide modes.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7f9ceda4229b..007a7dc4f5be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1836,7 +1836,8 @@ static int dcn31_populate_dml_pipes_from_context(
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
 			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format)) {
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
-- 
2.25.1

