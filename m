Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB7C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8804510EDDA;
	Fri, 14 Apr 2023 15:54:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DC510EDD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfvHd7ilJQdeswRL8tIZg+6gDtStLiJzXMeraWtjWszEx+6ryoYzXrB3AOIAC4DRpc/SAAxP9Q5qOitSL0lq5kwY9udB4dRuPADHbKm+o27XM3IAv6VARegg9EPMWtVzPIYOhg9cgQN8CwE8jPEpHGFnfmeyb3gBzQROwPos/r5pifLk6S9999tDUsFrT3TKfzWUV1+/gAJfHTfJlvp6zkTov4kerdtCnFPH8qP32sRntECiUO2c4ggMImknLS/czSdvE/I367K2DR2sbCCnAGEaTQG4F02pD6gIRECP2R0CvtAr1JZ269cng5FlA/bbZMmG2Fi4guC8AdKIIMDiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP/STfTykI2agbyCGjPcFI4GcRyzBJVc4p0gqshYi8A=;
 b=F3WYTpGjY3kNxwNdBkaR+EF/IXu5OjXao7/hTqn+/jdtrUm6HW/TUbEIhm/0ln53zNbnWd50MZ9Qtg0mtjivkp+0qDQ+BoHaPCz4mqHcp7afIMALlRnn/0SZyn1V3+LjhfrI+Gi6KKLqXLA8TL9OhPU8hQEFeL9H8NSCQusdYN46ufD/fHS1Cbt1UZJpg2kAvAorZ1Nwnvj+ggv379HShr4IRgU/jAs2Wji3zvYt5YFU07MEcIrppsA3FFlKQckdRC8mZogIYQMIKnnrBl22IHdoWDT6C6mv9Iv3Wp+UjnPYNvLzvSPYXKDuXS6wp8M5zVFQtdpWgy/EvMVlamYg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP/STfTykI2agbyCGjPcFI4GcRyzBJVc4p0gqshYi8A=;
 b=RUr5awI7c4ijWiO2/HemcuBx1IG0oKE7tP2F2Uv6U/7c/TtuoodRMqJWkUY2kZRjq/qXhmoBpxWyuu/H+WZRnnFQgA/FjEX55WDDd4bfqgFUZo5Mt5kfeANwdbyQ0uE4mLsyy0qVIw67ahMttj1aIyLLw2X9tVls4iBMgZqFYP8=
Received: from BN0PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:143::35)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:33 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::5c) by BN0PR10CA0003.outlook.office365.com
 (2603:10b6:408:143::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.39 via Frontend Transport; Fri, 14 Apr 2023 15:54:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:31 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/66] drm/amd/display: fix a divided-by-zero error
Date: Fri, 14 Apr 2023 11:52:55 -0400
Message-ID: <20230414155330.5215-32-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 511d140b-4839-4aca-4f2b-08db3d008a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPb4uGQmqX2G/BOlfMLa2cwOHqPuu/y4MkvJ1praYVLS0c9sT24evc4A+/mB/iKYbm25a2H1OGKP5ugLIoDOyfIthIHO/nSCuAru8XmePkLROGtKoSo2qiYEHQ/IxV2QoTayCNBqdEx5aAViVC7Co6Pm634qwDCkpXxP1R1WcsfM4Y0/VZJHqRwmdK1VtpXXDJhB+Q9dyhohV5GbPjdxtpX88Qpt74Cql/4+dpZv8U5eXlpo/TD0fyQ9awye/VyckbIRqReaAJn1vfZxPk+7OmScy15csbfmQ8/LlojhnVlO0q51eGHG3qXan3pPZSSD3i1tmopkVJy2S+yKxJ3KnfTGQ+wFxsg3rZ9u4ji2Uyvw3nVfHMYh6dh8BAB52HCY5jMwbsEtasJpdG6ZVqLzJawGBe2jirTA2eKfgzJrv3C9eBUqYMYr2BKD/FzKkYN+5bBiSK65WG6cZPs8jIrQ4iLfvppwMGz0XSOdW75UUtnZS8cgyUnLLx/4JG7G2dVJb2hVybumofZDdKY4NVRyG3UYZYPsCwuSS8iQFy50N/njXWUhgXThvfjdEHfNuiCDUSwCYidga/KNeiXtCpg07XwBKfrRb13L+R98JaLsMX87D/WfjPRKRBe1xIQOTC51RGYCExYxQHoEvt35RqMFDj2dIv+ngOcZZcncrsB25gqeZlnpXgmCmFjQUemCvPFmOnTgQelK6+xPr1fIOslPT1mW/1pgGqFc1n0oFNwvfXw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(4326008)(70206006)(316002)(6916009)(70586007)(54906003)(1076003)(186003)(40460700003)(2616005)(16526019)(336012)(426003)(26005)(47076005)(83380400001)(8936002)(40480700001)(82310400005)(8676002)(41300700001)(5660300002)(6666004)(478600001)(356005)(86362001)(36756003)(36860700001)(81166007)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:33.2754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511d140b-4839-4aca-4f2b-08db3d008a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]

timing.dsc_cfg.num_slices_v can be zero and it is necessary to check
before using it.

This fixes the error "divide error: 0000 [#1] PREEMPT SMP NOPTI".

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 0d3a983cb9ec..51e76bce92ea 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -927,6 +927,10 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 	pic_height = stream->timing.v_addressable +
 		stream->timing.v_border_top + stream->timing.v_border_bottom;
+
+	if (stream->timing.dsc_cfg.num_slices_v == 0)
+		return false;
+
 	slice_height = pic_height / stream->timing.dsc_cfg.num_slices_v;
 	config->dsc_slice_height = slice_height;
 
-- 
2.34.1

