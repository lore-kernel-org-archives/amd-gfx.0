Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4484C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94163611CA
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94163611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A799893BC;
	Mon, 31 May 2021 09:04:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C213893BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 09:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXqO77ybLNeUlKOglaYRG7j7PxXE42dkKnGSz6kKMYWXTEbXqeiTzdc6I22Nx0E2nSwX8vk+4SyuDU9f7ltB9yzArnjUe7ppYLJEs5ZZthXKQK62WswxTHH2lKQHqjgRsNmKdQi1qlGZxrVM3FNRnqCG0NmCBiUSz3dwFQ29H94TkvR+L7acVPQn2mlDuRaZX7S60L5KPOAz4NQT33toUYQw1Frdk7MlWV4nMjoNFgabyi5FMWM4ejOcIIFHd7KfXMEVQ0M0RSgiI5wOaml8B7LKsOpUEo3X2B/rNZo0wjds1yDg33UTv2GoHDYdgyaYFmz0usW95QH/+RIApqt5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCrtY2Gd9b6XpQl6yQPu423yysLr4M7uH0Be+C63nYc=;
 b=fYoLkcf/B2+zjoPfrmla8ZED4V2a4WYo2mugg10JIYo/VKjdOEs0OqWcF6r7XibWrFWA6GxfjSRzHtsYhueecHjzpehGOcZl4Q08E4KxdyZ/ZVnspOSUmJqJ72eCXrfLjn3HJtcgxDXMHJrRTC0c+klkPtvJ+Zb424ciScSDKNJ8fCn14rWJIHRGcCz8JsTdkdXjmcv28vad16HHT1RctseQl/0lUlmXBro8UjJbv1otmJwUH3Q8qbgvcQjSZjI9dpjtNSxkTK73/aWpObkVETzn1qUZ1hUbjpJUaK53Ll2UC2ZTTV26ohCu9utwuRBxhVCNYWYL60BvNIbArRf2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCrtY2Gd9b6XpQl6yQPu423yysLr4M7uH0Be+C63nYc=;
 b=v9EzUvWVsYtMMbNGiA/l3zrSDvcsad+eQNhou1n7MAeEKmIYxxIwR98B52oES2Q0A9Me7NDciS1Ca7fvqQi1BWlLF/J1LtjWGsemU+U9CrzotJGe6Nf3wLV3nhiVU/Ar2b+ZnY8mWbjfXgHn37GO/ajaAdAllC5/gQXbl0mWs+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Mon, 31 May
 2021 09:03:55 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:03:55 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: optimize code about format string in
 gfx_v10_0_init_microcode()
Date: Mon, 31 May 2021 17:03:37 +0800
Message-Id: <20210531090337.35153-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2PR04CA0068.apcprd04.prod.outlook.com (2603:1096:202:15::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:03:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2273f01c-8414-4ce6-6487-08d9241304b9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5441465C930380C2F686310DA23F9@CO6PR12MB5441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NR2KtlA39/dOgUmZztWT2OFseBMk8k5H342UFyoJhPHBe117ZaLk4vyq/PMQB39Y65K2nXU4qWRT9FJ1ixhNZgDdO/hJAxHdPayFS3FPYWa6a5qB6TC7rekD8f07QJ4unryS22aJ2eFksePAEMF+FotBiB9iVk+6XeTy0FOJR8F4TnBDhxfZLy5PPK2rlhgdvWhR5FbZHggv5IC2Z1fvt7Nm1bgT73BzRxgWe33lxdYN28fkrZcbAwWvfui+jOjUdmP0z1FaqKmD+smQDZP3dYFhJqbBvCBvDqjpIdl0vs6NXF9TMaQq7xCeAY4cGvStjJ9N7Rk5A3r6FFzlTLQNhf9CTdfudfC6WgXP8jpWmsRlWfW6diDx2L6kFYY6SC+kB29o+4l3Uj1BKoRKd9Uq519fect53S/2WglyDmAZiapatB9AtFcwuWDWYv8U79KCqyxz1dRPRw53QrhjX4Lo5s4QfbJOnvn6QnoNwdWPSgu+SIX32VTAL8bS0hkdrhlr9ol3Yza64cdkgZs62SSIUQP09W3nKoUr7HKTyCCb5J6b0A8hXPyfm9qEtDsVq5O4fn3h8lXzgCzfMn8zP+LN8/JJrtWFvien7ngOHBXKdo5kZwZe5glR5X7/ZTSWPvjM/8ruuVZ8QKU8dKorLBGNE674dnnZuC7I18f4PLlqsZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(186003)(16526019)(8936002)(6666004)(26005)(8676002)(38100700002)(86362001)(36756003)(6486002)(83380400001)(6916009)(5660300002)(2906002)(956004)(66946007)(2616005)(66476007)(66556008)(316002)(4326008)(38350700002)(478600001)(52116002)(1076003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q3EIXeq0uyuoH/uiLOEUE4MFkbIKUUFMb7IiMSiK8AIiqpJ2X91YzpyI1aCa?=
 =?us-ascii?Q?mw1Tctbr2FLA5Sc2paSBAsLsVDH7UAuCPOZydWOpfQBeU3bZcURBRWHIEgvc?=
 =?us-ascii?Q?C3SWRFL0mcmQQmqVcb1JyHNfdrlCvIXqu9eoqqnpjizAgEQ7SZTxeskSYmVG?=
 =?us-ascii?Q?+ucT5HO3b8Lr3Lb4J3awlQNboXkwynoB5FYxclk694EF4JCVwOyzIPMZkCnS?=
 =?us-ascii?Q?NNAaaQRC2R/7Q9vb9+puOH8LKtYO+a8gkoV9GGuZPDh0hfOQNqFug+GjjayA?=
 =?us-ascii?Q?tN7ouh3c0ONZhel34o9dAjO3d4b9KEwEz/zuhSuYDdcdh6ISzPG8AnTZi34f?=
 =?us-ascii?Q?xSwY9wnjyBdCUNioHea+hOG9UsIqhc1rp1oh9GAf5AwvbgugO0fdDQr3dTRw?=
 =?us-ascii?Q?TprTQ7BwkMzayXIoUTd92IHYVxWvvQlOrvO9cK0pNUzeEqKjYeJgE3HKvkvO?=
 =?us-ascii?Q?ZOmzthWkzbhg27WGI4DyzlG+Cv4ivSWlE9snuj+D0Rd2DleOM5U8zRAja/PL?=
 =?us-ascii?Q?mVcV7jk2iWK/OBPX7Wn/i07WHtZze+eLb/RO96i5A6NLkA0iDPEAqpUbXfoK?=
 =?us-ascii?Q?zdpmqN1argVLoyHMhzaaScF2zis+5CpJO4DBbOfVHOXeXqhgxZNBdvOuFOdU?=
 =?us-ascii?Q?H5+UkeNDyhYuZf1pBiT9tKa4HvhQsS3DYI/TnJ4u6yxON9TJ51yWXTpEuO55?=
 =?us-ascii?Q?nXyRKk76DBPRFe5qwFoBtUg+6N71rb3jGPyclbaH6BBBx76d3jBgoVGcv2eK?=
 =?us-ascii?Q?iwn4nmYVBBXXVoEus/E3FmQHM8I/SPA+BRm1MhDg9xIMakZPFeITbJ5EQQzU?=
 =?us-ascii?Q?My72zuBc/nMU+HHuT4ZnTWx/Galyc0VsOcP+2yjd81oG80Zp+DYnCZgH1Xh2?=
 =?us-ascii?Q?OEopFsguq5K+IangVZnlumMhKEp0w8OJXnB9N7I+4kF+csCgsSbMCHArVcp4?=
 =?us-ascii?Q?p0BxaZFpEzEU4W/I4IYfQAv8vyAAELgyHg1XQAAFDsWf7rTL6Z4LAPQyTUlT?=
 =?us-ascii?Q?TeZnARra5hyvdHpS5Ghikxn0V6sGnqqCIXPZR5Ril93z+lie0PkECIgOyw9f?=
 =?us-ascii?Q?bp85w389qlaRJrYSyLvt1x8ZxfNbaGMDndDJ0yzPslnJLrCb6lbCIQ3tTjWe?=
 =?us-ascii?Q?KUZ1WtAIXtfWl2M/JN1ATPiMr1kja5D16km8tK3CAjc3q5NclyMajttKaecd?=
 =?us-ascii?Q?i+MQYyyVKx4Adjaa/tOIOHuhjgb9nWwjqP0IE9kbhHSqtwSmdlvSAZj7ZetG?=
 =?us-ascii?Q?ZDdvRDmypwB6ET3yjzkiyVkvNNsNbPZ0/QoWfXQIMTe9bioVGAi8K3A+Xlug?=
 =?us-ascii?Q?4AKFMoQ+ynp+ZxW+jQYkmxrK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2273f01c-8414-4ce6-6487-08d9241304b9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:03:55.3545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHKnYSSwlCL+dKJFICO4njLoVf/G8O7KR83jiHB9g9FxrNERuLblasjT146PUS58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: tianci.yin@amd.com, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the memset() and snprintf() is not necessary.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 80729ea8416a..11a64ca8a5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3935,7 +3935,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
 	char fw_name[40];
-	char wks[10];
+	char *wks = "";
 	int err;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -3948,7 +3948,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	memset(wks, 0, sizeof(wks));
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 		chip_name = "navi10";
@@ -3957,7 +3956,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "navi14";
 		if (!(adev->pdev->device == 0x7340 &&
 		      adev->pdev->revision != 0x00))
-			snprintf(wks, sizeof(wks), "_wks");
+			wks = "_wks";
 		break;
 	case CHIP_NAVI12:
 		chip_name = "navi12";
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
