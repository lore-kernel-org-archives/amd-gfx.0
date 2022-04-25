Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B1EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 20:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591F010E221;
	Mon, 25 Apr 2022 20:09:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6820F10E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 20:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzMHiKHxVLBqEQKw0pOanJAor2kJoUUMDa85PB/1x+xQi8epwSic5Ctwe4BZFBYDvYeHv3LWH5cmx4tDbhm2ELgR/Ryh1ILd10/zUX33JmUSFrdzu/kIC/5pFt7MsTbO3oC/Dl2+pyZnclmhDd8nuWdANIfp5lIgEwHSq6wF/HfckGNpZ78q2Aoj2i2djR+BndVQKlOHomoEKvx8YNEmLuhbozO7+/9RcuYff37QSK8eMB/ctX6KDnwVb0AY33wFyIx0+cIypZ+DhM2fgIni6qe0EjP017EalmeZdUY1dGdrf4IdT9vFBJupD42hUMjd3vjjAGzhLZbl0z+KziFsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvgB3tLTKCxwspsRETmFCeL92tV8OfttY7WZRAmvZX4=;
 b=Q5kateyLZLJ+3H1O5NoUfEha/3V0N7dESXZLarvwL3u9YLkjtk6ZJ80NbzTYeOdKImu6YfR3/OJJklStFzRyWtSBdGf1Ca7wTEqAtKZ11m049eADZ3RXAxHWbYr69yGT9P9qxWpqF62m5zGYSsteA0aysRT5mdjmFwJWll/Hx2ey4wWgnzOdw9FHBO+gwMGgsRtLl+zRIDAzXPdj3vi/Wzv+gErgbz80dxl7H9jNm20OQVoXw45nl160c69DZ2wH9SsqcOE8i+bwBC2tqlQy2lAQmZAjnLbwrcWMj/pdpEGENCwm6t4FRGDdoQAwo4Ujovvtu4m+LPPE7Agly0V+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvgB3tLTKCxwspsRETmFCeL92tV8OfttY7WZRAmvZX4=;
 b=qDt8pMjM8RzaXgYkz9fbuj2kofB+mqro87ySj88X/r8sgIz/kPX1L2zGw5/hrQfQSh2cIVKSJfBjI5o/dzK83iYxQE7vjGm0iXdrXm+ScUfJVqfBVOWYkndAvkulAMaxBBQBUa/+k48f/O8aSm4AeZReQj76YYCM06nqe7GbIq4=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 20:09:36 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::5a) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 20:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 20:09:35 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 15:09:34 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Date: Mon, 25 Apr 2022 16:09:22 -0400
Message-ID: <20220425200922.813326-1-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776dfc98-1b32-4e34-59bb-08da26f7851b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4417623230950CCCEE90FB1F8DF89@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVALel7BEcDA0KTmAKi4k2ePaWxg046+8nryWRPYbDo8dKnWFvwlO8xI0SjAQTXVNs/berKvODPrTAOLMa58wYQeV0xJYp1xadrf1tX3i7je2UGAu8L9HuVbPccOs0c8RAd1qDqVqst3BqFoSAHNkr9LuXwE6UwHHcTpi6fDlrcdlQjfAE+Xfn1uioSpeOr0jErG/XZyaNfL6ZgO77TwnBSpOqON43/Qpok6EkAFZZaZ4SMjSGT1PgTvOEKnm9O6agOlmns2wv39S6XvFZyOKo3rnLeBJ/5xm12OjVvSG1Vk8dYNP4meXsfx0r0cPUoZ4g2WxeWiZyyizHBHQ5C4DIIhc2SN/6dkamblbpRLpApG0km43H5EkOiTBPlFExRr38lwLTIgeFv5uRbGONCGQ1OyZw51AqmMsFaIuDyqwpKmwfu0JiauSc1o9SaXK3VsYlr8vx+NaNCgJmtL6ewM/vcuIRkSd3HkI+W3AG+ux1RnSD6BOTOhUANDc8uJ4qM1jrsye0xXvqBfXQwdGOaKwUQpHvhjqX7iXEAoD9cBjDzkCSCeK4XBpMiUfEE2NJX/6qiefAQVmptcd/1u7BnVJzrawmEd1ggQrX6QaVHmmzoh8y1g6wFc1owcRiT5Q1Jg7Kbh+hgSoHJItTiWLuD7yPg9dFbmdU5vBID1MDHmjl7mCYCjz7k6WjAu3nJwg86+LVUnOyuxaSdBpnT1P+GwLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(4326008)(508600001)(426003)(70206006)(1076003)(70586007)(2616005)(336012)(16526019)(186003)(54906003)(26005)(7696005)(6666004)(40460700003)(356005)(316002)(36756003)(81166007)(8676002)(36860700001)(2906002)(6916009)(82310400005)(86362001)(8936002)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:09:35.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776dfc98-1b32-4e34-59bb-08da26f7851b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow for PSR SMU optimization and PSR multiple display optimization.

[How]
Add feature flags of PSR smu optimization and PSR multiple display
optimiztaion, and set them during init sequence. By default, flags
are disabled.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 741dae17562a..06f21e9008c6 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -234,6 +234,8 @@ enum DC_FEATURE_MASK {
 	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
 	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
+	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
+	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
 };
 
 enum DC_DEBUG_MASK {
-- 
2.25.1

