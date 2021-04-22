Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BAC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E9661439
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E9661439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5026E9B2;
	Thu, 22 Apr 2021 02:01:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570626E9B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 02:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ADSlJnl24vXcBjz4pQX4nHQlqVBw1mlGMoAdpYCChxVFEDkb5TV+K+ElBG3dZj6rGjBvWaGsx3kL3xqoBq4rndT0aZKXCgFnodB8p3ou11J3oRjFMuhvV4l2Szr4UR8YDjn3Wt0n5LJEEbU2pzgU/SmbzuC16p5Fl36h8aBxG6HXs8gepLAxgwErdr/VbTHwTosEMrtyF1gWszgIuaV+Og57HM+RaYl53M1+nSgkkBjrSKN3Dc+bdCKEryPEBJNkfUVH6aR6BN3ocKf7DGoAA4U3e9TXx6kDa213v/3Afo7l82MfYOSEzEU4/tiyf0LlCCpPDOybIn/nSwciBr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG6VyKj94erhqyK02pUAbRmsAIgl9Y01UqAC1rRykGI=;
 b=By3rTmYagioFOZZ5JX32nWRUpj/qsciAF9mVmCc6j2I5wiboWwvtgTXinWrPnm2wBmV0NZqiEF7MnrvTCggwtqHd1KMosyf8Wweq6Okut6OS/degGFmQZYJGjFCGtOlGUOByMcS/7IgGH9+60Mk3gAsJTyZ7tWssQIPX/BYkW9KT3Byvv+sD5qQUgCiYKF5YsJgT75HYdlErmpwMLJxFNe7MW7j2qbVUJOiaMHN4YrovcDfrLgu1H9/t44bqh3za5f80JQjZUWXgkEQaax2yEsllvoif4GJbB3yf6abHe9Kp9rKOgh8asCOQz+IVn7cJEcEexar0puqY+fP3MxjWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG6VyKj94erhqyK02pUAbRmsAIgl9Y01UqAC1rRykGI=;
 b=jVO/bTRlL3HoX922rbkxuJSoQ67M5BZZpeg1V+kmfnYytNsJ4DLRQfmIHFRdlEekTy5LzCWWO674RxGiMAgL7S3dc+T7Wn3opRImpNIUAs+yD4YLuv3NmZJr1jvOVQrUY3ym4EbsSUKf6xxn+Y/RNKUvloNPhM2wFHTnrX4wNU0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Thu, 22 Apr 2021 02:01:33 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 02:01:33 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Joseph.Greathouse@amd.com
Subject: [PATCH] drm/amdkfd: Add Aldebaran gws support
Date: Wed, 21 Apr 2021 22:01:17 -0400
Message-Id: <20210422020117.2095711-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 02:01:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc345f9b-03f5-4f91-b7cc-08d905328dd9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4044:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40446E25D7C6266A53A2443B8C469@DM6PR12MB4044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwQPfSVJoU6VosnXPDEHpOYegvUYMt+17u1qpZuIN74NLi7EmjTz2Up5c4rovgKGtSdkpCjL7c8hcFUJi89n6pWWSozJk5o/eP29KhF0fkzXImjCENUjFNkHif+WyxkFIqJcOEdMtTj1vfeQYcDbsjmWSPR7SqBxjPXsjdPcCMgsxv3kF8ZTqfOTPv0MtF76hBX8q5Es7Qa2wyjqomexCEyTGKUV8nmVBJIsASMSPGIS3GIDHTwoTgCHYbi2sdoPAgVZ8eEosNDpOpUxTi8vctUqtEk+Mnu/1MzQTtAHoHXoVr7Sn+b/pokxfFCMRIJIotRpq01hw74+3Kstj+oOxWfnn8kcRqHRAzp9M1+QZY2WrjYPKRYHtb4Y5E2+TxBAUDQtyFskCKYkpievV0aLaCmgNTy9jmBdgyUWiAaLp3P5xuo2NqapadFZUdCgh9n2d9jxzw1RFoQFdVGeFOAii0pcKrlHc0w3UJExak7nDhLhHn0qMplVC+CAEtRdZ4r/VINPfxOqjv6eAQV58JDZPmIKp8alqD1Qa2QXouNYomf54L775935QShNTrICfk8C0oOWtcKn0aHrGKrA2Dgr/cfcnyDnS6qV8UWhWt6VMaDsP+oeurrFKWCHf/YsA8gS3TrSzrkqoEk3yw3UIHGNpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(956004)(2616005)(316002)(52116002)(7696005)(2906002)(26005)(16526019)(186003)(8936002)(4326008)(86362001)(66946007)(38100700002)(66556008)(6636002)(6666004)(38350700002)(6486002)(36756003)(66476007)(478600001)(5660300002)(4744005)(83380400001)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cJENwZVukNEwBU/WRJRn27g7AxoGz7iEBDx+ZNJzcKK8DcNP/qwd8667oHp9?=
 =?us-ascii?Q?ekltHNKrixEoGRL/xxo95PXWsNWpRjfbwdBNdwI7x61kMmDERSrAec1eDOYh?=
 =?us-ascii?Q?Kb3/X1g40O6pheIGHWbX+Vvb1Zw7qD0FsGd7KhYr07NaTfdaCRtlnV7nNGpb?=
 =?us-ascii?Q?kf2cPZ+XMtnr57hdRZu1i/70zHvtpxbv8VMN6tgg9aRN1xz/tW34BiDxMKfM?=
 =?us-ascii?Q?1H4WW2bWNXQAjscf2ewDxYlprPCcpm3tzFWsYEhDA8TwoULPBA82NFG2v1a0?=
 =?us-ascii?Q?b11357PThNq/n6r4i8550NSwAj7f38M+QBnn2L88h7dtUpFglxyFt+I62YY2?=
 =?us-ascii?Q?oLYB2JYrkoGZKom9e78qcosPyThWvYu4/ZyI0Xp7C8gCxTjDo9KjoXWVFFR7?=
 =?us-ascii?Q?ArSYczt46BIIRNCioBieRBXvLk9n+5dDq0lSd0dc9Jc4wM+3xNMq6nkFLt2R?=
 =?us-ascii?Q?BsY/wqqGjcaaN5svsoieKgbL4pxVtBoWd6oiaOudrhSxqcELeyJ1Mxtm2k61?=
 =?us-ascii?Q?IbsOYi7vxS4BG/5FXTTHWtOK53DSvRflYAcVv+gy8fF5Zm2wS/HGSEUNXAO5?=
 =?us-ascii?Q?aegG+zeDQgr3WPJdSlz0nJjSFqWIpdkzh3dFmXDAWsYj+equ8lwwgJLZ2l/N?=
 =?us-ascii?Q?EoUT0x++Kz7zfep5Y+x+sBqLdkRL6387ZUE/S5nON1yeM6GAWO36VKbhywqu?=
 =?us-ascii?Q?RUDcNxYxiPCHDGoPzqrozznGQs9Q652CCkefTW7V5ACXSi4U5uaejTjkLDMs?=
 =?us-ascii?Q?zyXL6GVEQbd/6l9QgmRXDhVBCDu5lHeR5PvkBMKijGNfFsAP+x7Jf3rSfgBg?=
 =?us-ascii?Q?goQYyENcaWnFrV3RAOFOEfH0mBHCoszrPnNT3mBGkc7mw3g7KtWKz8dnNUrz?=
 =?us-ascii?Q?TveMD9fTL2CGnP8uU4GIDw8PZcStvSfXG0oYtx2/5gdybhyIg+ipVJUFetMe?=
 =?us-ascii?Q?PcXFktgcQe5S3Bxwx0hRyFTNZ94+nyY3oombTRGgeCq//qH++VRX5QzGuG3V?=
 =?us-ascii?Q?xHZCFgUTZFgGbdCaNUFRgYSlDWogZ/EFOUzHMFjPQt5/tRHZT3Hf7F+1oJvL?=
 =?us-ascii?Q?E1cgwY9uzo0w3ErHGGARb/nAwtZYKTMMkt7L4w04UM62ipm4yWw1bx4qbtoy?=
 =?us-ascii?Q?cLd01T+STHr/XC++rXsbhuWhgO1QMUIZp4K3B1ZUqlKozZwDT3t0ge4/oAZ6?=
 =?us-ascii?Q?NcJkjxYw24/mb7+j/j5avqC50bq4OHCqiFLGiYhi7iVkfm0FvRlIj5Qiw16U?=
 =?us-ascii?Q?i7iDw1FSG59a3pjKzGkgDXONmqWWdiFk9EvsKgBiuTKeYxuJJ6/3CMFviJaY?=
 =?us-ascii?Q?x6Jvk7yjVzE7wQi3/ttzpI9s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc345f9b-03f5-4f91-b7cc-08d905328dd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 02:01:33.8663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNCHR0k3rRmovmBdvzeRq6V37tB9QHlV2pDtbHZejSgrFUiExooToye2EV2B2jDnwsUrcS2nFPzOw3Bq8Isl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b31bae91fbd0..bc57b07523e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -698,7 +698,9 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 			&& kfd->device_info->asic_family <= CHIP_RAVEN
 			&& kfd->mec2_fw_version >= 0x1b3)
 		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
-			&& kfd->mec2_fw_version >= 0x30))
+			&& kfd->mec2_fw_version >= 0x30)
+		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
+			&& kfd->mec2_fw_version >= 0x27))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
 				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
