Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBE6FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317EC10E6CB;
	Thu, 27 Oct 2022 18:40:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670E610E6CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYrGZfrt4AU9HUPdGZh+lplB1IBnMdDOvr1dpO+O39EfHtiJwEM5ZhHu3aJ2xXCFZgQZTHcMpRkH2OAaW2LorZwHzXgM4mpiMpD5LThGd60bTYQGjjxPK3McGdIdVLiuTGe0Rc6ceesALZKW/lIj3rsZmLFAv3a5XdESPQgct63nPqB8nqjdWB2QkaWx85Dcs3/gjVdGrUSRHX0QIkO3cabV/75aeeMNf2Z1LMQslhtOBEvuUtPGwxX7y1JOnKI0c4gzL2r28fa371+qIMCgPU3HzCAoTg4cJlShxMLu4To5dh6N23RlrBts4nqyN8Fis00Y6y0+E6zz60TVpdzCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLWAyygt/AQUu6z5WAitXTaZhvz5JjQH5CagTsqtoOU=;
 b=R5FjKVbtVH0Pvv0uSbDqhGpJmlFo/xj2CtH4DA3WzWVPf81a+k75xQ+Fnv1Dk8y2LH7o5R4hMZ7Hv4qfNbko9mjVm5/jCe5A0GBzP2xBIj84ger1Ps6UeWW5ue/icdDcWXb5N6AcRumTJNX7whZEdmPTzY1vDF3YJLeliZPy6kSHT9tHHhA0OY6mI+bSUaeWoM/gkAU3qsPRiDxGwPAqqKCJp3qKTwic6nOTEA2ZdYZsPwfSgknQrxAd/HxlRfLDa26M95YIk/Q5nsCGFz2IWso2gh1nfDMFTvkkoL2HdYhrrnx2HPdg64GFa+z033WwDSUqiVMWDq8dyVa9M65U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLWAyygt/AQUu6z5WAitXTaZhvz5JjQH5CagTsqtoOU=;
 b=N798Fx221tXK7FoAGWI/HpwTcHjI7Vrt7nvqq5nGu+KePBn5DU6w5zbhfn1wE/Ski3LvAKRcojR3qM9CuaCj5iuyQrzjhciX4ANsq4prLdGwjw5a6X3JuS+ixXCjQaHJLQIKCVZdLU8U50EyQqpH5FRlZd0+DpVa+hIncgX9xmU=
Received: from BN9PR03CA0412.namprd03.prod.outlook.com (2603:10b6:408:111::27)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:40:04 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::5f) by BN9PR03CA0412.outlook.office365.com
 (2603:10b6:408:111::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:40:04 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:40:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/18] drm/amd/display: Remove rate check from pixel rate
 divider update
Date: Thu, 27 Oct 2022 12:35:31 -0600
Message-ID: <20221027183543.1117976-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c8c6eb-ab5f-4d67-8ca9-08dab84aa9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAf6u4fJRfg72nAns1wfLNyJ4Z2DH6RHn9vEBc0J9PLJOv2/ArkOyuJpQg1OZVC1pERnnLuujnHmdmk3weE9DaHe+V79fqpCk/jF5/lgmRzLUFW6jp8PsLU98l4m0eYpW5Cswl07RKFrFotL885jBSl0bnMSYCxBJrsvKcFXdmL9FpjEnQpFeHcguS1eZ5VEjbhblcKwAKsOIZdk27eh7/XeG88cABS2+1dGJFpwU3BpaY7FNaQKlz6+NlFe73kyr1Q0C4L2l8wYbptWbHvtEWmFiz3ZRAArHPUnm8lOTJ+E4hGKFh3jbciiISIYc3K9f1/dM9Z666KVVIm/tV/cWoLdSi/9At6OOWwZtUVhmYVmLsSgyBt7Vu12cQU28nxhgI68RzhIruao9Bg3bJ/J7IbvJtrGW1UB3FhXJL4u34tfeUgJ/rZDnirg0/zhcbBdQcztCpfsKrXgDEMo+bqhjc3qFpYXqLUoO0ztxK7HS/O2w30fzBz9Qnik264gAyRGkM/n0SR57WfossYocVWkSP4v+fV06ic6RXtG7GwN1Ikw0tU4QPSD7NOAa24mTu78xa5ZrZyMFJ1T/fLFqosdxsE+Om5kWVA37V4x3pvMoQL5R9YEEYFZ63zHkFQI0AiQTNX0Z5jNGZHzX5sY+MLLTkEFr5FES4nol7vy29aKrRgA0lrZHT/ZqgR8xH/M6fJNORnsIxp6GJsdNNvFfTwHZzZ8nOikiby0o6aAs6xmfI5Tw5oiEd9O1F4RXH08KCuMXJsx3P0bnSIriSNwRtkPiLad+U7mnddaIZD/0XHnmRPz3DTjTzPz5hqA1yIJx3mm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(2616005)(16526019)(44832011)(1076003)(54906003)(5660300002)(336012)(186003)(6666004)(15650500001)(70586007)(83380400001)(478600001)(26005)(36756003)(86362001)(426003)(47076005)(40480700001)(41300700001)(36860700001)(6916009)(8936002)(316002)(7696005)(82310400005)(70206006)(356005)(40460700003)(4326008)(82740400003)(81166007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:40:04.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c8c6eb-ab5f-4d67-8ca9-08dab84aa9c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
This check is not needed, and can cause CRC mismatch.

[How]
Remove check and early exit from divider update.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 1bd7e0f327d8..367cb6e6d074 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -97,7 +97,7 @@ static void dccg314_set_pixel_rate_div(
 	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
 
 	dccg314_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
-	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA || (k1 == cur_k1 && k2 == cur_k2))
+	if (k1 == cur_k1 && k2 == cur_k2)
 		return;
 
 	switch (otg_inst) {
-- 
2.38.1

