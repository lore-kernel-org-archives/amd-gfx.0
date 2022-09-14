Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DB7C6FA89
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CED10E842;
	Wed, 14 Sep 2022 05:16:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A9210E83D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oaf9fErkBS494kjE5rJ4oyoUeeHPzioqKGSJxblzYSmEilLoNF3qn4scbVC3r3irGyG6hq/ZadhHaGNMBdjFdR7Sl86zqyz3RJdfyGbg1xcSHHOmxcudHSPgyRQIB22seY5i5097JBQqQAGsfwmsl68GRzEx9o2oVm0YGqdbf6T++2J2VeTku2QivYl13dBFlNuKbDs8MvZF3j2FSzXafgZ0k0QjgOUZ+yAWomQFvueaUryRUt9eEFjmlUwwQgLD8/VbIiUL6uZhee1lrfagljDtzIgKGnxA4ccM+jmSSdgNvifX8eNpDQngJ6TD72sKfBwbYBPfG4Fs0awReloxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=YIa/1sowvdhzH3GuOQt5rbTSlh/MYh0CzMiHLeWtu8E1EkXx4m40RpBMYFgD+YqoxfjDVqGF0qXgMkMbtysuzqT7hCQu2/KcNPIttRiaWM5YIF5pBRKngyPKO8bIa6hMdB+2x7ZiMImzKHQvNncTHn6fkHz3ErhWvpErDiLDkTCTn8g6xoi9t0/qEsusBjWNyx4YX6jJ+7s0czc1O9vh5kv9TKfKDZtQc3WZocnCwa07sTY31d/4Fb4BfH9QrLQzBxORXgavtjVfu6KGLRkCd2zAKAGLTy657KjCgQFecomNBwhrzffxKcxtSkf2iKZb7/ZHcXg+5WWQ2yt2EXIung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=eEAZmQAzvhweHSoiGY8snFnHkF5Y3feqm5LvOuVTA2wNgYbNg2zkshVgwvO3LI54mQ6GI8KXTQu04c4hkrPYOdcbI5ZUoyOkPVGEkm9iDybIndA8sltZzYkAWmhsMgsxBt3PXMLQafXSe5tKZMSrO3ih/Gq+syXTdWPEhwwhrqY=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:49 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::af) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:21 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 25/47] drm/amd/display: Added new DCN301 Asic Id
Date: Wed, 14 Sep 2022 13:10:24 +0800
Message-ID: <20220914051046.1131186-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fa0769-56b3-47f6-24ae-08da96102fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ul25datnH8kLiKqICWNlammhNmQVtZV2u2N4aMM2RgBP0k9XWWmD2e4V426kBmV3+DeIz2v8hXvHSX1/5N4znaHqu7Grqp1x+4m1Yar/7FM+UtCFQmGCHqYoy+OdaxQeDbwM7UdAzG55PDJKxMg+KG3FO9YYtaeDY25e+G8vKrb8JUrwgtSlxJxB5Sdn0yC4t4lnRIoKUuoVFG+ktW8lKxN0LlYU6QTCl2CHXJadKIjKh+0o6EoFbj60aBXpD5MIk8kcnHVCK79WYdktmawyqNHPls/KpucVJ8OFQWtqy/WbE2xe0swVWV/d/uFYeem3NOgXMImqK7ak59JixMU9gsIJutQJXnrXRyh3aIDQCTSEV/9z/D6sADi4i/uiK23zg2W3aNZfSvfYeYu9BF0N8+FiWvRQ0G7fNw/37ClYKbckJyz32iRGstAiPN13u4H3V9awgEdl5jOt29nvhV6ox705V2xnR0I3MMBVXu5lXvukkxGnRP6dGIo/OA8paXPSiNgWiTou0dLv6IiFmaxC1FXtAarfuhZsBWi1fS6Ydm62LZsXjsfB3PzsEVWquaYiUnR2muvxQ1DbEnd5hBfVSs1JEhEurNyzhjyUNXpMVaZhtPbb/XOaB4l49vFvVHihhb1xkKaBqjE8W3FngoFMP1gaY3GiGLyfVy+4cKPgTkQS799l5TGszQfFj1EAvBnAvI5+wACmzgUf2n6KoNcSb6A7bKjjfYS1TQU8hLxoshacN+qiO6a8DFUIPeffQDEIkrTu2Joja5LZKRMmNhaucnfReivWcQoPzGjKYxFDFyYEDX0MCJSuDdmL6hcsZ8JY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(316002)(82310400005)(41300700001)(54906003)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(478600001)(186003)(70206006)(2906002)(6666004)(426003)(8936002)(356005)(5660300002)(86362001)(4744005)(82740400003)(47076005)(1076003)(26005)(8676002)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:49.1242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fa0769-56b3-47f6-24ae-08da96102fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
Adding new asic id for dcn301

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 9f3558c0ef11..c3089c673975 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -215,6 +215,7 @@ enum {
 #define DEVICE_ID_NV_143F 0x143F
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
+#define DEVICE_ID_VGH_1435 0x1435
 #define VANGOGH_A0 0x01
 #define VANGOGH_UNKNOWN 0xFF
 
-- 
2.37.3

