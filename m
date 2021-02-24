Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7CC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253C64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5253C64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402C66EBA7;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B996EBAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIy3KgckJPeGKDCu9EtMCM0AasN4irI6Ib8Byk+r+OVbcOkStygnuIBKq6+aB8+b9eaY6a0nxsglwed5uIK6YBOB9Vozkd9CFuhCSRqg9MfmS/pyzXgCMAJ/RAVAqUO6Oo01qlNYxje3WwW7gY9hJS5tIVecnbXaIWNKRXv8btShHkE/k82h2UDoLIIkNbOXfxbfCbFymQa3jLQK/e2dpkoTPYnPyjaBkD+aWdz1Ph74QbF3jp3WqgO7gQPLxfwJT060GZnVleYvfb2KMrGvBOQDAS+VAu0LUINW37rUNFkcLwZRQRvyv+RXCQmoFOwqUWC0NWLjKPwBj6oDdlUCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29hleP99HH0FgnGgIcfC5rgmS3qxqeQnfQmvqwXKrvQ=;
 b=QZArN+p6o6LZL6JiR4zmvxIqXTXEIaPx6S0crsIw2gVo29f6AXJsbPL0V9PSQOSAfbHQo/BBhx0C806bd/pFhSLxU+MWp9SH6kTSIpGFBsgFMy4dh1bNEt5/7166pID+gj3YeQbM+XI9kCk81xL0tBdtryF1n1o49p97AT5NvZhNmDzEjiSJuUVDqS9BPOHQyn1yF/6u03Rpq1lEqRLryq/TWsJTncEXpuAa0jJr5zsZsfzfAegvUCm4J07ZKeaDdLlNEK6FTettr2bLmGjMDRX/TXBur+CVJ7Y8YjyE+29+dJEYvdFerAkJ8nnWhr5NtARlNS8O36cB+cRv6VcSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29hleP99HH0FgnGgIcfC5rgmS3qxqeQnfQmvqwXKrvQ=;
 b=QAOoaHEGOlxTpXBtnYpVHOI/NozrpAXG7jXuJj18drwMxvvvGQJzB/yvNWYVu5otIbTW8Pw6VyDNOf7yYZjTFgy2zLYP+G5/RghNIrnr44wZ2+N1v4l0QJ43VrWYt5+PjyC5GHIs8GCg3NrRFvNBrAvV70s5kJLjbNFZAH6z8FU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 149/159] drm/amdgpu: add common gc golden settings for
 aldebaran
Date: Wed, 24 Feb 2021 17:18:49 -0500
Message-Id: <20210224221859.3068810-142-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c65ce7ee-c71f-41bf-5058-08d8d912788b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722839381D26CAF7D03919FF79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: za4CeAJikLO39AJbyEX4gnAvHkuiubqN4M3YGSafNy7Rr6pkLVYCxbZvVDsdiOUQ58jHfdUkttGCABHbtnsj929g7ja5lZkWx1XfSgbjjSLcFvU0/o7sy+BdSuxY8BElOo2d/hRktlKC+R5MW9u8CLBSN/lw9r39YnYWsRKq6sDbkKjEqe18xBAc3K0/3+fAqEoU1JsqjGF0b0Hn090uM6jQkJ46JegRx8wuANN+62TbVjbtqcdRl7jjBGhtO4C1QPCx1oaXQdDMYN6csvB3PVDpPALI/ey5Uoq9unGFNTBnaOB4xbDeJLAJXt0zOuYyM0J0AKSpoSgMhelNKYx06Cjt3+3vJjpx+3buuyjlO7uOQcQ3nIpqc/efM27lE29a7XrEIeMubSYkPBXdNorQb3mQdL7uL612UNfPWbJS5HlcRomPGGXpQWIcsWUq3OoUaDwuhFbgjdjkOHm40yNisnABk29/VNOtuTfzfRUv0GEWlqajrJ37q050V+OAdKA40yYbngMkxEVPx4qTTk4kKp9+vx+zr/p8TujpgxBT145ltsGY1UmutmMKDTbQ+hCh0YIluHbVBLpxeRdyKeu9gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8RvYcRp64CiJpqcX3iZaDjyZDKJm8wPfJkdzney9tre82CEPWfCIU/LT0Hm3?=
 =?us-ascii?Q?hFM1RfgUte4KoomEbC5bMGi+HoB76EcY9kw7/jrE2XtdbyjnKycJxvU6bND7?=
 =?us-ascii?Q?ojGYbkGyynPGNAkES73CBKN3oieEY0O8zBPIysfvZopH5dvP3Klgu6EqN5LV?=
 =?us-ascii?Q?RXqpF27zJ+DnL8OmlGicUx9T1K+jFvHc+4I9Q5TK2v//dcPATu/IrhN9iHYq?=
 =?us-ascii?Q?yMZ20IHiDw5li1MCL4q4Yt7qYQTtSjfsIxKUQj30JxTZms2yBkUqSBeSvtTu?=
 =?us-ascii?Q?9/iY9b6Qvu4qoiA4O8kFiWv+FIn8eUkLEZDzwloF5hao6Xr0gYMLu7ivnqm7?=
 =?us-ascii?Q?MVCXFa6qGo8u8fhLMryWGLIOdBEo0U5T30K/VxMUx9sdsG62BGGoZLZuzx5g?=
 =?us-ascii?Q?/bQuWR0wvhwwqEc2kvqoJ+QENUUPwXKquHHPWTsMUU6enc121PtMyHkk72fc?=
 =?us-ascii?Q?ZRW0nip/bGzadxKP6qhF/tOfqCG3nbrtYKItHGICP1qfmQX5CnLlaRsea1Z1?=
 =?us-ascii?Q?HY6Uj+/2SSIxNaewzT9hY5epxPjSfIHWtn9QIx2X/ljxqDQ3j43dCloi6jw4?=
 =?us-ascii?Q?X0BbsBIUGqBZiTC1EOIA+27c5zYYxCmXq+jh1097Yd9Z5YGgdElZPvlMtqvg?=
 =?us-ascii?Q?0X9S5ONGg553kIj5I94VAleLcm5cLAMtuC+TVJzgisAlFiYZtaGvnQILBUCD?=
 =?us-ascii?Q?PEvKzkTMOpluc/toZxPKjO1fvwmH9yumEXcBCccNZ58E+1hJcoKVxQzzpGW5?=
 =?us-ascii?Q?PKPI5QwPl5elvgCPIJv5eZpBRRr7dfGf89SNfkoBuBssCGWjdj7y5TJm7vdd?=
 =?us-ascii?Q?hhtsHozM+xLJXUanw0uEDmHrY7wG52FBbglLbY//QeFNUTQMwdUpNTWN/24t?=
 =?us-ascii?Q?yslEZsWduv0sgFyTtvcEYbc48h2A2EPRWPN6mzd4S9L4Gc7Ciapi18JApkq4?=
 =?us-ascii?Q?VEqYISHOMH9Oe5yND4tBxJZw/dixL8HcO7R558FkhUP7wQhWarxPKspzok2x?=
 =?us-ascii?Q?kcc77A43eSjZKKBjGY6cigjToHveqCi8gdlEcgGWsxpQiUDr7nLYUVdQk5ln?=
 =?us-ascii?Q?jvsEXvp4g2PyZ87l1WtFxgy3oJFcDH2E019w6uVG/UVdBG8yyOJNC78AbiNU?=
 =?us-ascii?Q?OvMCygqXZyBOEJkB3c43FJDLefOxG2YMXLuChhERjTrRk8RwlCFq1BIbV6aw?=
 =?us-ascii?Q?919rmOkF9RcbMsrwzvoD71LN6JKEKRoNG4hmOPJHMrWC4qKINI4/CxUsttKh?=
 =?us-ascii?Q?o1/D74mMPHNjjA3Ux3wbyI14eZ24gUx/gRqYwbwxVLOgRbUV1k6h6gGtkCzv?=
 =?us-ascii?Q?4hw4geRO5voFg1ItVIJrm9Lk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ce7ee-c71f-41bf-5058-08d8d912788b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:02.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfMF0vc5UkUNYAY+nJ6JLxFt4Wg4T1vzg4uare8vv90RSyB11OD193Hc98nPzBh1QUpvSQlZshMOiu/lTo0rxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

golden settings that should be applied

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 4c4549c2ecb9..80d37d227207 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -37,15 +37,18 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_0[] = {
 
 static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_1[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x2591aa38),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0xac9688B),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_2, 0x3fffffff, 0x2bc3369B),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0xac9688b),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_2, 0x3fffffff, 0x2bc3369b),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_3, 0x3fffffff, 0xfb74ee),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_4, 0x3fffffff, 0x21f0a2fe),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_5, 0x3ff, 0x49),
 };
 
 static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_UTCL1_CNTL1, 0x30000000, 0x30000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0xffff77ff, 0x2a114042),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xfffffeef, 0x10b0000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_UTCL1_CNTL1, 0xffffffff, 0x30800400),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCI_CNTL_3, 0xff, 0x20),
 };
 
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
