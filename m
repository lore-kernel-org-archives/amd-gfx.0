Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79FEC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F38B4BE5;
	Sat, 13 Aug 2022 02:14:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014FAB4ACA
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcOWa3lXvLwrczjjFf3WhVY3r3bht28W9mqOzRYZ4Rh0YFqEZeEw2/TaKs+DjRYLe+U7gjrz43YephiI1+DqR1HXOK+kGM+qtDCNaRvbj0m3FkqnjJ6WLUN/L5BKw7Oy3Jhiu3pyPDrRWHZzd5KkWlm3wMaYBc2eSYYuiJ51xNLMN/yfXooaPkTjSZUyIMkTKJX4i+3vBPiEB0+f8RCGfOpqhzomeet3KAMV23HAEPO78NZ7N2oKxyw3XOu9vwyGG7TJsUVNg41R6ay3P03R08+4GadD8ElmtbZGqUF+yH3Bql7A2ZG8afDDCU30aNvXdtwnBeuv7ZAL//AruOsTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RAQS8PKUzUnt3EA3M95E5Pa2czHnwyjDrwKaaPIkSs=;
 b=OtDLxayKWZQOmVnDOa1Mo3qBgE9aoDJHirH+SL4hmwXuhTvtEGMAWHhsAqvzQln+zbxH3ML2sI5djFxyFXGvEa38nb3/0uiV53TcQnCPzAy331o54boMcI38vus/bUkf9kQk9fdozTzwb1wAUycLAajEbMtKQD75ioWBkDQtkqozpvMZcwN9bUJm9ge38D1xELy9N6iwah2sKhec/rvApVlVjsLEmSKqw4D18+pYQg+EpUXVzBqX62Qxob4qJ+NCGqmfRqyNwpyScxyoNg6U/PlfnCIl9qywownnmSHxWIcYOOHp2bIqJx9k/CzELA0U9VFK8FSFfD9wrgJXa1qH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RAQS8PKUzUnt3EA3M95E5Pa2czHnwyjDrwKaaPIkSs=;
 b=nIoDIXcLmBr5/CA1lGCzUW7ei6mcZTIC8/6GyHg2YgWZehxSyGEocR9haIxZ8MfA2d0kgJpAc2cC9vJ33KEjCYo1W+vOYqjEm7VXjhviQ2195T8ZW+EmOtMxbNfyU924Nji8GPJq7r2agRYgfCBLAA4o+Sy+yp9RGX9kQp2/BVs=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Sat, 13 Aug 2022 02:13:38 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::42) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:13:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:29 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:25
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Don't set DSC for phantom pipes
Date: Sat, 13 Aug 2022 06:12:20 +0800
Message-ID: <20220812221222.1700948-13-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b567677-55ae-43b9-6611-08da7cd16f87
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAH69fUokiSTUsNNZxtnVKKX2aXSpkG0+1WznncLl+4wqlAO+AFSzvwaQv02OA0Mp6PxUs3hxb3GqDl1L4kyS5wrei1wW+hZwDXOR3jOHGUGjZmMGuq2gFJrabvHwZ4gdVehBbLa1kGLTc1zkoVVp/8W/hllDKoteognP4E0mfktrcNikTHoyReqXBS+o2+i36xS9vKbe60ywMOyWwZ5kYkJaDSzo/xIqN/q3w/ncf+ZjjUp6oXhSqbcIFvVAPLcUw9J2Mv/6byzLjtcBeDEFA0n3Esknha3Ohwma0lQgLmH372t5FgJKxSAQjJ4WHCJG/7NNShyPz5ATTgbtKX0o/EoJQ/Y8h8mC6TtvjAfNBWWJPR84scyVk3WZa00y674UAYdXnOKE9Gh/byu0xBdGHZSg2cMMEvyDT9kM6vrAfkkCA+ju37Quq+2ILoQ8Dcbrm32z174mPwFOERVqLBV6DkB9QD8jXc5SqNQj+uUAyS/B97ktuEBlQxuZAsUtjddPMrbioiqRpmZb4SgyNLBXOU3U5jBIA+pOV6hlrNZ9wCHwf8dS0kgEQqsCb2JYiDjeXZziHwTxpbySvuXL9FpVqp/4bu0krLe9SKpV6ZEDn6o8oq6sEJunUEcxbRZ51AUPQH8xvDWYpGZF+t9P9tmLoVTnwJ5HcjmoY53pZ/wIHVKbxneICmc7pSFoJDn0sz6JyZnhapYRvTLxtMPYjR18VEiV0jhtYDGdf3BHMNN9pqHIjFcQzatDlPZMFbuG2N9hS0vO7WpM91f3OW9h0yRNWFrPUYczDm0KfI3v4RodzoPvbJyedbUCXeB3rNtTuQz2Frb9EKxMWR+7Wy6YcUOv+fkvgCmNbnUhzZ+mnNZuFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(40470700004)(46966006)(47076005)(40480700001)(356005)(426003)(1076003)(336012)(186003)(8676002)(4326008)(81166007)(6666004)(41300700001)(70586007)(86362001)(7696005)(478600001)(82740400003)(26005)(6916009)(54906003)(316002)(2616005)(82310400005)(36860700001)(40460700003)(36756003)(70206006)(4744005)(8936002)(5660300002)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:38.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b567677-55ae-43b9-6611-08da7cd16f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Don't set DSC bit for phantom pipes, not
required since phantom pipe don't have
any actual output

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3316c4a64901..8118cfc5b405 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -493,6 +493,7 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 						phantom_stream->timing.v_front_porch +
 						phantom_stream->timing.v_sync_width +
 						phantom_bp;
+	phantom_stream->timing.flags.DSC = 0; // Don't need DSC for phantom timing
 }
 
 /**
-- 
2.25.1

