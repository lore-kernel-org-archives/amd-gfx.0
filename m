Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA64EE021B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951EA10E226;
	Thu, 14 Sep 2023 02:01:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6190689DD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVLu3lsfwB8frdXspWMvHNmzyar5CdfDRS7wQDyQBwswmx7V5I2VX3zYDatEVjRlInWRdCbyFtIRGFpuagk9QN/xjZHCRjHKgd0VtvhZvAXpbd7ck6c+5rF84aRDWYiGryTMxlaytL4+FqGoF6XQlG/CFy56MO/5m0FzQ67jIyOmP/9VVKeNVpOrD3fOE/hX2A5sgcuQC3+v84b95A1DkGsTowCvpH4Mz88aAQjHd3flBlu3iwjxg9bLkw2atwpC1CWUblV+ft+NLp6lYQSKWxzbhO7TTkzFtq36nvSawRd3SYL5Kb7b/zxXKcDfxz7Z8nlbSANs/OSXSknoKWlpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVj3YyUNs1w84LhMR0uSy5AEnqoEohE5dcHovE7gm+s=;
 b=kIJJB1/oEkTQW19gcDxyI3C/Vkvswir92QK2FvrbaIA07OiVn6DvL6ieq/yqoyIV9f4kaWl0I7b3zKFbXygLXO/bE5C8b1+8cWRbZ09b7rf23gv93XWis4YD87dWn4tqCEb4/T4DKe0V2fve6tjWtzm1JLS2UpfE/7qQHzsXzkq42w3rruCtJZS0JK53r71T3TtuKQ2Oly5Vr5g0qZibCT/FF46ehUVJmPv3jDuKZTihmrK59xN1c7utwgTWUr+1G91AfQjgertiSHeqddZFKJpSb1aTWcxrk7KupAxlxJ8l2TTQNruAQsWEQeIM94SRzqvom6L9WtiQMXF9GVCmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVj3YyUNs1w84LhMR0uSy5AEnqoEohE5dcHovE7gm+s=;
 b=HAvWlCyArTa/iKOOD3jUZ73LPXt3fZhpcP6EyUsdq87JgWMby8PWHL81xgN0FJ5SAqCi4IkFSRMPhEzdgjBFwLpjisAEnSj6ApnyZNFsjLFuSU2rsldEyGmBvQ7BO1gkM5TgnEYxls/M6oon2gMr+o2uVVN+xJIlmlu+UChkFZo=
Received: from PA7P264CA0153.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::6)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:01:45 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::60) by PA7P264CA0153.outlook.office365.com
 (2603:10a6:102:36c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/28] drm/amd/display: STREAM_MAPPER_CONTROL register offset
 on DCN35
Date: Wed, 13 Sep 2023 20:00:05 -0600
Message-ID: <20230914020021.2890026-13-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfd2251-78ae-4ea3-f962-08dbb4c68bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZITI1/6WRC60BOTeLwXxj/qAEU65xIZCsmibIJ1Bh/1YVfvufmMkBqHqxd3Ays+fGNAZmOgjBezfr7r7SoOCwrTDsVGTz7Oo8s+sdxLLg6p8JsPy/NX6FdeTi8UuMFNcWx9rTh4gxfwz7taF+5xpc4IZi1ABkLIb6xm2ZAK/cg00W/okgr1tMxzK31cl7NRrHPp7O7RUxvWXvh5eKKrSkz7mPz/Vo97jehsuS1a3QYGl27IrPr7t4gkk6UXX8THj9/CzDOw3LtARBYmFQGVKi9dDd4yPZhr0FqXf7RT/8jiCSrPeAfrRyyeC+Rqtbv3YU2QTFbm1ZGu7uIH0bXnYbmQyXq4w6yvamGP/gxGBV6y+NVNpFO/LGpic/FMZ+bGY6O3w4b7hQmOtArDGkV+M3ig42cjeCyDUHDTp3Xmjy7QaieAlQC4SVeAfE2TzuX0vDhXGW3Pj1KPQfAspwAuNqSqWARUqS0ETBoRdnLubR72F9jGJqzK5Z4sQEDu6PyY0hvrwrGjtBAIc+KxlQU0D5bt8vObpudTZijUmCpZg7Bf5UKJPj9ERZrbmBmFnkbJnx+xFWGgtrowT1oeslSUmJStYrOf7SfeazCBzSgiuaPP4rWeGkfZSw6K+n74tueQ9772NNWVQSydWmfO52EYdeodY3fXTh2ucQdTOsIoytVXfbxEuFF9b6zjb1s+AHXiMIFIzsq6CubWHgmpTILp/3AqiJ2Btwjbdu3CFmYTVbmf27WmHs6GykmN5D13BGy28WLi6pGeR4F9cWneWWibOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(54906003)(426003)(1076003)(36756003)(83380400001)(6666004)(336012)(70206006)(70586007)(316002)(6916009)(47076005)(81166007)(2616005)(478600001)(26005)(356005)(41300700001)(16526019)(82740400003)(5660300002)(8676002)(4326008)(8936002)(40460700003)(86362001)(40480700001)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:44.3242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfd2251-78ae-4ea3-f962-08dbb4c68bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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
Cc: stylon.wang@amd.com, Artem Grishin <artem.grishin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Artem Grishin <artem.grishin@amd.com>

[Why]
The STREAM_MAPPER_CONTROL register offset was left uninitialized,
causing warning in the driver log at runtime

[How]
A temporary solution to add it into dcn35_create_resource_pool.

[TODO]
Remove duplication between SE_DCN35_REG_LIST_RI in dcn35_resource.h
and SE_DCN35_REG_LIST in dcn35_dio_stream_encoder.h

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Artem Grishin <artem.grishin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
index 00e2216b6205..5ec70d46a38f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
@@ -137,7 +137,8 @@ struct resource_pool *dcn35_create_resource_pool(
 	SRI_ARR(DIG_FE_EN_CNTL, DIG, id), \
 	SRI_ARR(DIG_FE_CLK_CNTL, DIG, id), \
 	SRI_ARR(DIG_CLOCK_PATTERN, DIG, id), \
-	SRI_ARR(DIG_FIFO_CTRL0, DIG, id)
+	SRI_ARR(DIG_FIFO_CTRL0, DIG, id), \
+	SRI_ARR(STREAM_MAPPER_CONTROL, DIG, id)
 
 #define LE_DCN35_REG_LIST_RI(id)\
 	LE_DCN3_REG_LIST_RI(id),\
-- 
2.40.1

