Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5035EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8F810E468;
	Wed, 14 Jun 2023 17:59:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C22310E473
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irbK6BS7+VLswq/6anjxBLj+BiX+zG5ZEIi9wXMD5LXqzY7CM1sc0Typ4/tKOZSL6A1oSvNpnQiYnloO8xY0wWOG9d69YTQgG+f6S/VS8zKH7HFxoo1XhMLo3HzAnz6VCal4brIIZ+A8QJjttkpMzcuapsHwUI+Qy4KCri/Y13uQmhMCGgw2nLo/Q7GY70qtz63H6wXQ+D3woIxFyru6ilSNUK2YNANpzw4QGcas+tYLl8adQbCEIIaEk0EkZx1ekY5c0Fpaluv1ZEyRN9gVypRq1FOesmcugfvyPVpx1GFIxg85utWlZP3DHMQ6VsJfkQHE/eH9PwvrnrBwjML/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6qv/6o8IFkLozkIN7Cu7lC57aSURVeQF11BDaH94oU=;
 b=ZHSmy3IFneUijQ67ftExOp7J+bMZIpGYDbTRE3UhdIWNJSIuzgjYwZAQwx2EBVObzIG2zr8w5idVzqCPyqW6/U23kSdeouxy+eLkMS6vG674iAfabKqX/kYbzOvzOaNVoCDtG5Evlx1r3fdH3rgtByLXaAF6FMXflsi7w+0wg9LE2LmAx5hLRxLz0CvwdLs033z/A2YqQAzasLyi3bJxdD32qWeh++nTsF0TI6GVVmJiiL+slYyMjgOtzx2OO6LmtkDwa15H5pujSqF8t4E7eojpFCHLUThc5uyBq1SBUKmoS4uVBOAr22KDRVTrfEvpC9rT9TN+0RSIJHfDwCAEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6qv/6o8IFkLozkIN7Cu7lC57aSURVeQF11BDaH94oU=;
 b=BNKXzPWZbFOWCL0J/NnWYyGyIz5IM8pb5vsul29HEjhGjlzoG5adqj32hZU3eXvRD2vhZ7qaHe95MkOtZe45JtBBCzBypPeIlXk5T2fdTIEqd3/iBiGXTPNN3KWy/RAx5dpZW/ZDXpi8rrY2r1OuNt70f3d9+PpQhkItHo3VUyM=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 17:58:42 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::ef) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:41 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:38 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/17] drm/amd/display: 3.2.240
Date: Wed, 14 Jun 2023 13:57:50 -0400
Message-ID: <20230614175750.43359-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bccfa3-3d4f-401d-3d7d-08db6d00fd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUIK4KM2IuqLUvaelaRTzgIGtm3CmvzvgUqf5Rj+yie2Ube+bOAns+tx/2a2q0dBoUlBRvhPpnpWKLWJDP9suA+Px25g8LP+o7AHIs6FwyHAo3KJ4649e9sXx+wXjkg4wKijKJX/g53PL84YEEI3YgSxoNhZgJIjVp+qKhTwIPoNiVwYBChnHPCeme6yktec7qqN+6ZWNGtOcV2WBnossmhpqkbwSi1L4R74R9pVQjUnbKDdh02hA41KJrwFMAGsNqFZ/zsjntkthXQFNnsTLBFt7Wo99cMmaVgdttvmGHx6NFUaHw99but8fE67rougY4kdW3nQftWiCercCnCilq4M5+C7yp6uIi1d/VX8Es9zZOlk0TTRZCnxCaJBcOZBzU5u+BoZD82ty5neX3UfwZ0GIVHNDyvwfRIY/KN4Pvn1Do3mriR9sowL+SeBEaT0NpQSbdF90xjXCfcIgwoP8hxNUWyWUvwhEpyfwe6k4dTjYJ8PWOniTZpWE3gz9BLFiS4uCAg07mgiTbMEbsW+Avel9WjnXTXAq5XTUVztVEuNK/ainIeLGYLRkrzjDdWWzf/onya6uSyjqT4FThfqMgPCfeWE85LaWVVBicMK7yv/TFfRmTr0iEYfxeJaI/CixApkwocFFiJrle0xcPbAQtu0dQe9zVAsLRTk5LcrkShP5fsl/kdhiC8Luw2Wchag+kSsnZvUAqNl4nuV/M6LKgATsN422ftyNzyVQ2GX2rU70wqYRiHJtzQDoOHpYANFwmnyFnf2e71ECc944mazu1eEkHc+H3E5eyVlWadhMXHGX/6WZImswa0aW5sOLiIu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(2616005)(336012)(40460700003)(47076005)(426003)(83380400001)(2906002)(4744005)(86362001)(82310400005)(40480700001)(36860700001)(356005)(82740400003)(81166007)(8936002)(8676002)(41300700001)(316002)(5660300002)(478600001)(54906003)(70206006)(70586007)(6666004)(6916009)(4326008)(44832011)(1076003)(26005)(186003)(16526019)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:41.7531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bccfa3-3d4f-401d-3d7d-08db6d00fd3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DCN314 fixes
- DCN32x fixes
- New fast update sequence enablement
- DC mode clock switching enablement for DCN32x
- DP link loss fix
- New debugfs entry to set MST link settings

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 812f39223238..ea0b78ef351d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.239"
+#define DC_VER "3.2.240"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.1

