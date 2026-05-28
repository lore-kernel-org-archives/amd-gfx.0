Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF981CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C92110EBE1;
	Thu, 28 May 2026 04:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R4ltL04w";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8CC10EBE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFjxiOzE+h412ZKXfeMCJwksRcKFVQiixBMjCfU1ngQ2c0fUpfARowUKJrmJ52Iykq6oI4s5EbHfJKWFQumPZnfnRKfzXnELRrN/bzN2niPMHH8sI45bApWWrTbozjTkPGq4lWRVujUvC4F/cu6gJiHJIyqR6kxY0SkQFCzXc4O5Cw8SuMvjJWEY36GaCSMdXAkIq8Q9tLoNR0vCz281+4LyFWGqBlsqB27SW9eCEauMTY4k1MtbRS77B/54nYZbe1orBmNrf5tDMam2hnZSi5olJanxUBIl/RHh0YqxKEUZtvR6OEHKdeTVFPC9iJo+2l5nrrO8VgDThJCkuWreZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au6EjIjdXuwPLGWRKE8PTKDcF3ba74tFmx01yktTzuI=;
 b=PQEl7SXf2SxrLDq2db+UPF953Heb/L7YiGcveoG/EXJXGlLQ+kn9Kzi4Bt1m+sZFsMLdmkH9KFlDvMxaL3D3t224O862dvSj3m/nEMeR+XjL2SYM2mZgCMiRaMQ+0W+/yAeE+HX7OoAaGR/5DNUMhW2qxjxwqaC8sEHEfZrsu5OmSb+enCamNLCPNiW7GVwqk9Mwhtjiymr0IzCM+8NcoJ8EpK8N1TuOuGj1MyhQOM1gVYGDWn5CADmmvwoJBup1DLZOW6TLjpJIliCX5CpZKBVhQv/rG5wH5WsTUP2b55f+NGqrme3lpq2oupQII+9ZB3FptgFVsWQG5dEle74KoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au6EjIjdXuwPLGWRKE8PTKDcF3ba74tFmx01yktTzuI=;
 b=R4ltL04wioQaajXutSqa7zsb4Gl0bIXI4OLC44NSKdH9q1JDjF70qlI+ssTyPjv6QwesK4JMGJwfyFh9a61kTGrIlfLe+6BoHJ4JJMqKfLDgeMEcme3o3uBN/gbeY0hoCbKgCyZJaJ7MuLFIIEcRkSUtykGJ1Gh/MbQ6H0GI4w0=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 04:34:52 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8e) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 04:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:52 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 7/8] drm/amd/pm: bound OD parameter parsing to stack array size
Date: Thu, 28 May 2026 12:34:07 +0800
Message-ID: <20260528043408.237209-7-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: fd459a92-2614-470f-1bdd-08debc7275c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nVI7woO501CxCNoIu5upuisNg3oX0yFyFmLUjuNgokv+C5+eaJB7vCWNVJ2juK/4PxyZcqaN8czMmyi21w6SS4oLCjJB81p9o7knxLG0h8wN4bKZrUqs4JwZkKWULPxMD3KgYhQmX2D1YidhL8JA6RLSA9EKjXFP/dWIV8B8/edev+grJeNwYfpWPqskM6k1TamA8n2Px4L52daYO4seKtCd+urcKfWShFJF5wzFbLVScPP3j8Yz6crtJ3MBMygLuUwzpzW5vagzKgmvOG3Xm2PB3dL8dAd9IN4XHGNTeBqUE9eh+sEzcqZIZ+RMFLMhpzEyDaqTU6SQy9DKAgwg2i3pvSohyMQzlYOF0xswIY+JiXs16F7l/0+NT7A7+CEovYwWJb4/LtaCeiY74xh16bc/5fCswY6vkQ6lEBXnSe/hUf0CTBPvxnr2QEQLfNMjQJf/uticNQ8/lmmg61xY+xN22CB84sJQaVlCHnRQkPS0+2n40fOwXJGRpjvjq1lHXTXiITKUQie0xtPxpyDUZsE+rgvPpFSau4wEDUUhxQz4ZxzNa7g/Su3pO1QXF2DZY9kaQHQ6VxW5KEHd3vXD2iAcqzVvtaqljGC8wwW3e7hoWuPxE5aaO3LdgQF760CpOh8TJ0PdnA7QhjjqUN1AYVMFIkvUDwchex8VI9HzX2xeBYzaCsWom2CjlLR9TjZS6Z3DlHjYaHXUWPY2arlbRHa4FgQrYMWg6w0i3I3uGJ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cJzjYS8E2FfQWKboW9cDGmn91r1NdlBpTQA10HOST6ECoBcF6g3fS3qupKigsq3eZCTwoqxjXVC44DRvkb3QPKSfrXlw9FAv8m/T0vsLSyCdIWunGnpqGLECXIT5Cm9xiTLaM3+nv9JwvnFP8UQSCj/Z4QD1pZ4kFId8N8CCU7N3202ZiJpALg2+sdIoK6ozyahn+i+RXVDTyGvnDgLrhwSY3kHZ+Mth1o3dp0M+HN9xB9gkpApQ7gIi1yIX7yQwZXiPAOCUU/WznOTH+p9u7Ag34l0/fHm8cmcd008e/jPzsISu65X18SW7m57CWYJdM2PunpSpmNOlHKDaRvKBCGDC2jT0lepl1PQJCNmdv7pP2ZAqyBZ+v8nmvNu8tFZ9EWufOT4wwtG2DzXwWPAJjjv70KwkgKQIhYakEUzYDSfsGLmkLAXg4NCiW1Oh/ZGN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:52.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd459a92-2614-470f-1bdd-08debc7275c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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

Reject inputs once parameter_size reaches the array limit, and pass
ARRAY_SIZE(parameter) into parse_input_od_command_lines() for defense in
depth.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8140bc77591c3e..60db9b66d08c20 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -798,6 +798,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
 		if (strlen(sub_str) == 0)
 			continue;
+		if (parameter_size >= ARRAY_SIZE(parameter))
+			return -EINVAL;
 		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 		if (ret)
 			return -EINVAL;
@@ -3931,6 +3933,7 @@ static int parse_input_od_command_lines(const char *buf,
 					size_t count,
 					u32 *type,
 					long *params,
+					size_t params_max,
 					uint32_t *num_of_params)
 {
 	const char delimiter[3] = {' ', '\n', '\0'};
@@ -3966,6 +3969,9 @@ static int parse_input_od_command_lines(const char *buf,
 		if (strlen(sub_str) == 0)
 			continue;
 
+		if (parameter_size >= params_max)
+			return -EINVAL;
+
 		ret = kstrtol(sub_str, 0, &params[parameter_size]);
 		if (ret)
 			return -EINVAL;
@@ -3997,6 +4003,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 					   count,
 					   &cmd_type,
 					   parameter,
+					   ARRAY_SIZE(parameter),
 					   &parameter_size);
 	if (ret)
 		return ret;
-- 
2.25.1

