Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19541EE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A744B10E21E;
	Thu, 14 Sep 2023 02:01:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8188710E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxFo/SvzXkbiYXdtt6/mhSi3dluZg0PQMMTkMWcxy3uZ+iSTIkbb3LsaXqzWOHbXF8LPBTs6ssTmes9W7hzDM+jxuVk+Ju7biNSZ4TdySsrHl2g7VnuGt+QOTo0sZeueKRwKEh9Ze7w5P2Y4OYTFGeThd6cBrOPK0ud4LA+VGV+0dq7/MeKAwB3/UrdFhsr/j77OaQd7i14wXLg4ZrPY2nlkEhQW4DGWEaeCzupH/08dKrw0mGkejXLMDKwg8f7R6SF4CDvkVVqnX+/R2klsIWGiV0LtsCkbyBwV8DNrJPs3Vl0Yzx/bEqdrROsj9kbXMsOl0lM1U85YWnwq4dAz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd++oqapxpU+oYS30mGO6xRqvqzYGQMArf+ecI65/oM=;
 b=VgJ/BtAHj4KKKRuQWaAZPR04mDP+TB+tsHbnIXXpxrBW82p6jpRv++/fbuPYvcbEauob+P+hHV/teVejuV30HALQG11Yj8OWETbIJYkM2Fp7RUSC62KqumdLDvXdrTLRpvuXWjeeMNK+qzVmxWwrqMkd8qVVqgtut2sAWz1qcJFoLF7WlZ9vdE1wudwSOtrr7DwmN2RZZm50bqIHNS1cSpdSj8f5KGBZmKwY0oR3d+LAxtBW4A+uieXUJqKZFjiznKQ8/+Hq3HwAgDiKzv7WI4ne4nd49oRkz8OitCwPHKFHuJ07f/tuFhd+4sPDuhbobqEhTFjueW26yuwsxsnTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd++oqapxpU+oYS30mGO6xRqvqzYGQMArf+ecI65/oM=;
 b=ZyjAohT6f+N/HQoYmI4JoPcphmmVrNaREDKfY8bMsO1qi6NWeRm38S9srXbSH10wzyJ21mXGrNmvrSs112onma6Lg2WsdHOkBgsekW7biDsyDo2wvYkR7FCzKeJv5EZxebtA7XxNgw3YdI0SnEfeGS9WsXIQaLXRGOLybv+azzc=
Received: from SN6PR05CA0012.namprd05.prod.outlook.com (2603:10b6:805:de::25)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:01:35 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::df) by SN6PR05CA0012.outlook.office365.com
 (2603:10b6:805:de::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:32 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/28] drm/amd/display: fix static screen detection setting
 for DCN35
Date: Wed, 13 Sep 2023 20:00:02 -0600
Message-ID: <20230914020021.2890026-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d779da7-e507-4f37-6f8a-08dbb4c68635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAa9hjD+ksv59+H6hZFZOd66Z+OjFG0q2u7t5UqWWqoeeipg/HoxdM0fZGfIOPuvUdZ3IWjXFQynl8ko7oJIdt4QVv6hGpPDJbeHVUKrbew3s1WIpxLU7FiThzA+P7hv65qeB76c/KEVSKbuyZUJsEDIywHoTwafjU9IXxQ+TSqHB7syO/mYkMc1KVMGY/hMqMgLKOXGkqODN8SRGwaOeBL2Dv7aZK/Aas34dqldFmu5U3hiP17jX3jkNB0w7hnNiyTCYsAHgUJ1KMfwrWHxoCrBsaLeLc+MEELz1H2u238yTbEQLM+J4MZnWpZUXQxYADBjNFLMNaKej3CT5I6wtdAJB2qbaaNcMqEIA3g9NAkQBMW7q+vf9+CRAOG2KmlRqj1R3U4pkFcjX1WjcKnEL207Vu3J3b9W60qyJMMAJo/ytRn5tpuxgpfyVkjRw6wJvH6blLs7/vMUWeA8VzvrT/sg4+e1mmXiHZXGnUsBcUe01C02DRl+fOwWsZ8qrj6OXg1jzncu18lTLPHhh0XVBHubnrNPgsaW0H5L4AUbKW76Q10RfiX+Wqg31GkHKR+y2Q8QmbASNUbxBq23O1x8lvtYvMtPP5l8v7T58VTxj3Om9u8G3Qna7Hq7nNaj9FzJ8J0ogBOV/E0KEz25zQKF+372mh23b8FEzKhy1FIuk06z6pSSdMYKUX4UKBwOYjMab1Lhc4VP6Ck+3rzvgpgLZ5jzOONGBf+lXIw7pqwaH3WV540Khf05lGg5XaQ90/ofmnM8AKWNFd3G6O6Yac7MeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(6666004)(478600001)(83380400001)(1076003)(5660300002)(2616005)(16526019)(26005)(426003)(336012)(2906002)(70586007)(6916009)(54906003)(70206006)(316002)(4326008)(8676002)(8936002)(41300700001)(47076005)(40460700003)(40480700001)(36860700001)(86362001)(36756003)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:35.0605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d779da7-e507-4f37-6f8a-08dbb4c68635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Sung-huai Wang <danny.wang@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung-huai Wang <danny.wang@amd.com>

[Why & How]
set_static_screen_control has been updated for
DCN3 series. Update it for DCN35.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung-huai Wang <danny.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index fdbc3a7854c2..d68efe5c64a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -68,7 +68,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
-- 
2.40.1

