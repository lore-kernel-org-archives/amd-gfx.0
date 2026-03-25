Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9730FFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D3910E7B1;
	Wed, 25 Mar 2026 07:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kq7k5ycQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6C010E7B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWbTKUEgz4bbXG0KjHcoF+uZ9MHtiDpQ+uuDsm7DkGIi9XXsP4zVeTXpPEQrsw7xIsMYotY5lmui8yYUNn98wPf43pIX17GNcD000nyiUDpn2EamJtkvXUteYRiML7lQuCZa3h6lSaUTbMpTCLi5WG0a1fnZ/rTjBtn/8jj5CYJbKwu5t4VIerjc0NAFiBYF2CfHPWVJFHM5RVkAmHk4DioIBX/xSkPaz2O4Pk25rPKkuSuWWYe1EVLZZpa6iaMzYfTY4QZZKXvtGLHol0OLQXY3WJqr+TKPcuURvDXxPBB9ZKqowkmCd+N5ScHnwCe6nQ7k+cmpbivueZedAHBj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hajlKTjqs9j8bZ47/7IMr7nEmDdUMpDk61Py+WNLzV0=;
 b=h1n9Vtr9g63k1MNI865tbDmiB+/x6zJ0Y+PhdobjsEi9VlFR67r8jnUnIBaqIdO2XMLwnsOMj0qfR8TmYT90FYzhbnZYDPVpCtmMjdeTk1mZuRZ5MfjTOM+CqXf6RiQrA38LbdcghX1GxTIvd0CeDuCnZKQ7UsrqOKtbrx3qGuyMf4mXGdHDZO7RSfqjI7C+oijCz4ndW+Pxs5TaU8V6dL5mSZtV2V2shBhjyus9pPscB4Xo6c1NrAzTKuLRKGcsQBrUDJe/e5ZjoacQlAx3VDOI/oaSkN3AejFnYTOxrwwBq8qA47BzlpLaNzmw5JcGzpsuXJukgR1z0zWl2wNt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hajlKTjqs9j8bZ47/7IMr7nEmDdUMpDk61Py+WNLzV0=;
 b=Kq7k5ycQnQl6rZd96sm66k6acjIj7WrWCieDxSweahZD8O8EiEbKbFDB3frVEOUjyN/SwFriQsK+J/EzVnscTmz7QJZ4tmqoWZQDj+wLggxS1Tdrr/nxw5hXi7YiXwtshs90JuIFxMqs7/6AkWF2qynJ1ug8ylhzEWwhuLYCSNQ=
Received: from MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20)
 by DS3PR12MB999241.namprd12.prod.outlook.com (2603:10b6:8:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 07:10:48 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e6) by MN2PR07CA0010.outlook.office365.com
 (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:10:47 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:43 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Aric
 Cyr" <aric.cyr@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 26/29] drm/amd/display: Fix Compiler warnings in dmub
Date: Wed, 25 Mar 2026 15:06:32 +0800
Message-ID: <20260325071003.4022594-27-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS3PR12MB999241:EE_
X-MS-Office365-Filtering-Correlation-Id: 037aaa72-c622-4bae-ad30-08de8a3da3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zTaX/hCKf8OK2eoI+nvfbyBLhTfGPhq/9Xd2Ug1liiRqRSiA2N7nTZcrCSjQ3xVKPU/PetB+lPk+993rN5NFJO8C+OfxizVYrAg3/GrEw/9lRP07VHhUDYmGOKne4/q9cURj2WbBUB2ktEQnBeC7UJDK8eWxyOHvDwedtK6m15/um0HwYq1npbuYf8G/BNuZc4RwgUggoB5hsUonQbQNvK8OcBTm1kf+NAAksZuXeqCGlZOcMup+KLhKjE3JFB6NYEilGV7SAdTcNwX+UuhWpGfixXzWNfcangyc4xfBs5EmWSvBmGgOC1cSsCgN6D3DFU3MDdYxdw0sIuVXe/TPXnmm7DeiclWfezF4rqqMxF7CDtRe1YK4iC70uqtSkAE8unSCMCgY1kmQk8Gn+8sbJytWukyyNXyAcRy2ULRXg5aIUReFPwKCurkPytNFyi4e+eogWkn21+lHjzb6FdXL0pPzxXijgV/ahukihG2QmYxlyl9ssfqhPP7+t38D5fk5jeKT5LOvTFO+csmQDz1MUnSmC+VQTwzw+uGMVPy39Qb4k1boPyAx1nPxBznQ3u7whaxSlNUlySiBj4EVe2UGj0i2S5VkRmYxdLXmvGI1NqOAGb9hD23frhRivWT5TOSkIsRPe9dSZW5HDYg13hOXvBTOCgXwuqHVW2BEYpzdUfTayqFL7+u/W1Q0pXsMycmXvPgHPS+Y0AW0CyaWZ59txp73f7MP9p01jNGkoMaZcCt08r7X208TUQ36jsaXc9pHluXj56QD7rnJhgNOqR/JhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSyFRdghMJBlgYPaE0+QBGVpvEgoRN7EVzHLmEbNiLamJpr2jVYP4qELRut4cxPKpkeE8MGCC+ryRrXroNlgX1H767EUbbsdILWXjcSijW9bQzSVIpHW1xbUiq7qkpx7hVttKkI7N2Wg/MUCn3gU6VVaxqxENLwlsOP3KHEeoFF0rNVinIhOfvxSff1dQ3f/K/0WHObhVx5T3YE1xTL3/PsoLejdaBimlpa7deWYwpUKWbAh6nkXFskwlwcZgSipVpdcczgmQXYEChmjwOD1EGCW1xWrH7mfXbQ9pjHAYSHdftZJ0a6Bq1mN9vvsLDcCh7AecXjz1m8VjisQHZrLCjAYcuCGtnEeIikCl1Rro9vdO+/LiasTHpyATNL8z+t40aOIPwTT1lecjXyyYaJZCefnwRaaobM7Iw8syj1OvLoFdhhrUPahwyUbeSpjBSjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:47.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037aaa72-c622-4bae-ad30-08de8a3da3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999241
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Resolve compiler warnings by marking unused parameters explicitly.

[How]
In .c and .h files, keep parameter names in signatures and add a
line with`(void)param;`  inside the function body

Preserved function signatures and avoids breaking code paths that
may reference the parameter under conditional compilation.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    | 1 +
 8 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 73221ca53b7d..0b152926f75b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -194,6 +194,7 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)region6;
 	union dmub_addr offset;
 	uint64_t fb_base, fb_offset;
 
@@ -396,6 +397,7 @@ union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
 
 void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
+	(void)params;
 	union dmub_fw_boot_options boot_options = {0};
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index 84a6eb3f677d..23a33db07edc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -127,6 +127,7 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)region6;
 	union dmub_addr offset;
 
 	/* sienna_cichlid  has hardwired virtual addressing for CW2-CW7 */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 244244f3df80..478d79a6e246 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -195,6 +195,8 @@ void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
+	(void)region6;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 5d86f649db4b..3f9fb9e05b79 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -237,6 +237,8 @@ void dmub_dcn32_setup_windows(struct dmub_srv *dmub,
 		const struct dmub_window *cw6,
 		const struct dmub_window *region6)
 {
+	(void)cw2;
+	(void)region6;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index f9b16eb8ef8e..69fb6084232e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -222,6 +222,7 @@ void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 3d2307d0ce49..e5a78df80d72 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -213,6 +213,7 @@ void dmub_dcn401_setup_windows(struct dmub_srv *dmub,
 		const struct dmub_window *cw6,
 		const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 7b870b831199..a09aa19ad379 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -229,6 +229,7 @@ void dmub_dcn42_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index 94f4931d3d44..b5566ef8d4f3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -45,6 +45,7 @@ static void set_reg_field_values(struct dmub_reg_value_masks *field_value_mask,
 				 uint32_t mask1, uint32_t field_value1,
 				 va_list ap)
 {
+	(void)addr;
 	uint32_t shift, mask, field_value;
 	int i = 1;
 
-- 
2.43.0

