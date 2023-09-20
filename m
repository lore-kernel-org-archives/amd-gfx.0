Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCE5CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DA410E42C;
	Wed, 20 Sep 2023 03:20:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8490B10E42C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA5G6wNeOn5szeKG0mNRiG+89tP88kEkWfkskgL2NRNsr/ouEhLIe+hoA4yerYqbl9bS15yClhMJSQUqI0AiLS9lDql2qXd3e4hNNItwxTErAV8hYkiYOIQXnner4vZm/GNvvNqr6sh6v1LSVn91KyLaapz/MZY7QcnW3DYOBAb5tD7PGLUP1n98TMazP/71pHWZ0dLJE890K9JYvtDGeUIsalS46TCxVOmrFGE7UnLer6KzV2VS6+Vel8dEEUB6fYxFBFrCN39gLs66Lpe14uvJv8jsrb1zhuS8Z9gigaogYDZoZelkUHV8mP+ckASm1JcAQO2iabp+avsBdczkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEh859fNUeCBqHYtR+unr4zf5raEDvUjCbkG3ev4Tlk=;
 b=C6rJC/iAdnynmC/ZcICDHiJS6oip0qZN2X9MwQPzQCwe2t5ZkcVBSnm0jerbvCOuwbiOTQLxXuNkUigcKOoh/surCeOOmqQOwzpOg47OjTKZPbnsH1rogCymnDRz9P2ginY7L/Ipuf4s8ebUU9o/LN+KpR6wWDGukpapx9jvkhtsXkc5wBlPA59PmvM4CkSa6Yv9e9mCoD80yTdXTg9kHXoTRFidx5eIuQ/V2SX8w3866nr3I20/qr6EE/pxasTkT2vAbf7sd0VBsvstsB3OuKlMZAf6jBW/k/WDVL41YX6UW48JNDxQAYhZuQ1FFrCMfVax4mzaAXcHCnovJPxhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEh859fNUeCBqHYtR+unr4zf5raEDvUjCbkG3ev4Tlk=;
 b=BFQA6us+Wmiv9qjKndiOVyaMfKxUlePxNh0RUuxXx8Zgm2u3v22UQiqRP2OWSYfW5l2tpSnpKW3aJT/vIQa3pEwT73CDdniumy1sJaaJwllvwrDGIgGKn6yC1JpPc/gm6K62hjadb+4QEVTWSMqUP+lwUfw/CRDr+u/y1HLp7+U=
Received: from BLAPR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:335::11)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 03:19:55 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::ee) by BLAPR05CA0030.outlook.office365.com
 (2603:10b6:208:335::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:19:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:19:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:19:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: skip audio config for virtual signal
Date: Wed, 20 Sep 2023 11:16:14 +0800
Message-ID: <20230920031624.3129206-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: ab14803e-6396-4a13-fc7e-08dbb9887604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+utBnhthVHfPdKNe3WJCkuOs+Fc3XypF/d1b9qa65iMff8CNvZ1va7HkqgWzJcTBeAyJ7uvfSYjjGFFPljqUk2QysFagjOFnTsiCfrtHxXLpZ69JZH2HOi4if4bcVW+gziPIYIwpbF0GTHRH3vxkFJBWP13xYitn/xhEb+NTgaLEqNzbwHeH4b57UHmPY7EoLwtJ3/UbvKbKFp9w3aN1nCiPWiJkZ7HiJLWL1on694W/Wy1aUw+ZPTizOd58OHL4xlT09ziBvt5HSjvIxF8jfrgCJhTFJyxmHFoEKkD9BEKcRwkaBNTcxKBbnrDpqDMMXgF5km3xCM4p/OMk+qnn8cMsgAFzDv2RVjzo3k7I5kviloZYGPSMwHBpbGzRRpRuoRv5hO7sy2O+OPGUO8JD8X1P2/vQ+b0k9ZyvCJlR5a7K0Pqg2tXqjWyz2BffLhGXUFufyTvrxVImLZe0DujiCHtl4fTs9z+m83EOPuw4OR0gbU5PrIAgsCnDttNs+yGAGB2GGxF4AHxbhCQ6ick4zmPwlpYFk/gq30Af9zQsbjKRsA9zQp4Mre44JuaH0QBqwZSpkcIeCTAHG8kPZ5NF5ywWdqXB1JiLDzTF0R5XuNPLLTR3gv9YVtsH4nvJ3qSDLJu57IIeeJfv3SvJa4C1VH1L2lnEe0QCyNPwHfFNYoJGfqD+vPO9z8fzzwVnu79FWdCD0yg8xSMNT0zUIoSddreqbrVcWa4jK5nAWoiJbQIi2n2Hj9gfDpxX/6BhnXiEijzpE2IHhEELT3WxC0KGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(82740400003)(6666004)(7696005)(83380400001)(478600001)(2906002)(426003)(47076005)(336012)(54906003)(70206006)(4326008)(316002)(5660300002)(6916009)(8936002)(41300700001)(2616005)(70586007)(40460700003)(8676002)(40480700001)(1076003)(36860700001)(26005)(86362001)(356005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:19:54.9317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab14803e-6396-4a13-fc7e-08dbb9887604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
IGT's kms_hdmi_inject (subtest inject_audio) triggers a warning message
from dce_aud_az_configure. This can be fixed by checking Virtual signal
that does not need to configure AZ audio since it does not have any.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index c94a966c6612..140598f18bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -407,6 +407,10 @@ void dce_aud_az_configure(
 	bool is_ac3_supported = false;
 	union audio_sample_rates sample_rate;
 	uint32_t strlen = 0;
+
+	if (signal == SIGNAL_TYPE_VIRTUAL)
+		return;
+
 	value = AZ_REG_READ(AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL);
 	set_reg_field_value(value, 1,
 			AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL,
-- 
2.37.3

