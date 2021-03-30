Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F0C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADC66190A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADC66190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A956E896;
	Tue, 30 Mar 2021 10:02:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFF06E896
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 10:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkEill2FmZn9JXh5IWSQyVpjMxPJodVWP0JyUuU3a4aqrBuuKWvhz+VugHwjvhWNS+8kSqC9IsKlE6ETorTRq/RB1/Etj4i3TmuWmArBFM7myQy7/9IapfrUsIShiozegrnV7nENZfHMaXt4pLnop0nqmWenh/8yKEPkEdbDmBybpRpePYKTwq+F/dZWOZlHfkw2bLwLZUkxV2/3HKfoIZ5q0rz8CobVxfo/xHKSB/Gb1D2AMcBry+QkuMNBmiaGGQ/N2gVdTTBVs5ULzGYDR71DgYTWkiwkfygKMe+T2jz29JLnBPzrAABRn148u6tu7tDyNn9gpzWs0rBD9aJnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNF4hcgWWEOkLdfYYKnImh9omlSzjh1X7LzzAJrSMeo=;
 b=KEm79B/S0ZAzH8tjNZ7eeZ7Zcz/vHz70XTnIzNSIspaMMYYY4FkSr7/E2BF3lghUqiQeEoDzyigywVuLacVW5F6zwgk3uPn+3wVdyZBT3jdXXYtu06ugeduJiKAQjaVr8OIuF73pb+UFtmboORlBstVaWOgw1/p/tJKVGJgYX1vqHKbVtpnwZZbdndvYmAuX97V+SY184kXLnfuHleALf/os8DsejA9GSKhU6K7zSVH0szZjX/msyQxjj9qKdSWMedGRIQTxqFpiwaqtgrCOi9/x0z0Gace0fpbWtnzX3syE/dX+bCu6m9iYv5wJRdTr8zgznfCa/qYMOSPtufKwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNF4hcgWWEOkLdfYYKnImh9omlSzjh1X7LzzAJrSMeo=;
 b=tKkl/XMq+F32pHirkhcTvNeCICLwFyBkBMbKNnZLbul539tjgmJrhX9f/xzvFZi8YyFNSD0s013pO0YPCs8L/fbdPPhC6kvS9lGiJrijfp2A1qWcy30rH7Feq+9LE+kXDR6yowmZVkDdN2eo9nqTRYlfpsp3k5FMfhe5KQYSeKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 10:02:55 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 10:02:55 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Subject: [PATCH 1/2] drm/amdgpu: fix NULL pointer dereference
Date: Tue, 30 Mar 2021 18:02:28 +0800
Message-Id: <20210330100229.26435-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 10:02:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42bd9b38-4b46-425d-37ed-08d8f362fd67
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1159373E84383DF45EFA168FF17D9@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+4EKbqwjowZ23B/9B1jn0fm84my2+xRL5Z0v42VkGRfuNYNWEig1tZfxYTLzeu05IRXEHKAhe7JzexIoeWseqWILVNo+A+ppp7/+dfVT/gtigM2jPv58Hxz4JIDwq7gDwhs+XNy+i5MfkR7O9b6PiEkSlm9h1m/1akF0kqAdooLVGnY1b6cUrYM+D4PotkURR42TFAxklUdwRv66Ij4EOpMXFAu5GFbh7Ps+eZPZ/kI/Jn9sMYmbEc7tdF/Y9ASRi/Tn4IIvlCtSUeSxH/8Sqt7lIcnfP76CGFxRLCBqypgOMVTv9WDzuSy0fzuqEX4bdU1bA0N36m5GBWo5DMuqalynERGI3l+EeJW9h/MKy04CXDzCX6c0pez3/uYsW2G+JZiZQVxiFHfdlzVsgIjVDm+F0lDEmd9LQlHZ7RyL0yvd3LNqdlsP3iMJ0uCIqd1/T2S4X0v2wGxd1IPmoixqym8IPbo4YdhErxCRwEPGitegNweanApV8C5raCo+hfs5AbpEJbU4JPV0IF/zYBVQes0Xv47EwMoZTkpvNOAcLNZ+hsJgZBgp3Aff7FMDUT7C6hV86IPRZrjlVD5sF65RpxzWyZTdGoPX756RXd0TXHMBir5vTAokEGRuOk5U38aOjYJqbFQhhXYyluluGbV/MjU83HEmzuBe9n8BcygFKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(16526019)(186003)(8676002)(2906002)(83380400001)(36756003)(1076003)(26005)(7696005)(52116002)(2616005)(478600001)(86362001)(6486002)(316002)(8936002)(44832011)(66946007)(66556008)(66476007)(5660300002)(38100700001)(956004)(6636002)(6666004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S3PAlN5xE6LI4L5/4YybL/nycbdoPN7rqkthP3Xm+WUrA8zFXXwPuP0kHjM6?=
 =?us-ascii?Q?p2MjAmfjS4mkfHLL2vrnvN0Cuol5kvYuPbILlOdHFCTVgA7tqghcsFxAZ4wF?=
 =?us-ascii?Q?YO1fpTDUDskT1oDwPL01/91OOjPNyGyMgzKBPh9KJ7dAXbniaV47dAey5Ptn?=
 =?us-ascii?Q?/XMAgDPUU3HiuDsy9agGrpxDQAbM5iQFrp2VSeZbf2BX7GJbgctL36eVbikJ?=
 =?us-ascii?Q?o0SHwwSrXuZHwWmRF6QOJrp+qfdXEFg6CeIH8YXvAbW/ZQLOgMVuYSSBg6Xq?=
 =?us-ascii?Q?V0+oKGzF07d023/8SM2yfKbuPxv7uEHEuniyO2XTnu6DZHWuyU6owrTKmMMX?=
 =?us-ascii?Q?9kgNexuV7v6I8MYFtnTeW3kcGHLoVi9lMMkug120+7Eo0PKSdHZ44vlvLg75?=
 =?us-ascii?Q?Be8UOPbZiDl94R9Hce/jMn55bssJsZh7CaUFoFVufIbxdXtoi4KM0FsFjMDC?=
 =?us-ascii?Q?JYVUt/VGllhpXKeKqGLNaXaIIttypE82qXgSGDcW8UvsK7/UgrMsynLT5nwj?=
 =?us-ascii?Q?NjIXgBb3qxF4bQP1nGB3/Rg8l4x8YW/AYMPZfcKfqS4hBpXID3gSAUGrub5d?=
 =?us-ascii?Q?Yx0sFsT78FOe9vWaQCCPWVpNqhye9pHk/OknEInoEN4JF61GD7Rk3GvIbpbF?=
 =?us-ascii?Q?1gPe3Ml1+nVXlPfannajXJ3L3U+UcXxQOgDXKIb1QTefMe56zEL4AFiFb3BW?=
 =?us-ascii?Q?rToFZXvxxvWeH2IG7kHOLA8VSOZ0V1XrD9qkQPbQyTZya43n4IevVrUPSJjm?=
 =?us-ascii?Q?Oa7G/KXL7Zw+abO5bCwUS7CauZudi/MRyvdEAePefKcMZio2crLqBPirizC6?=
 =?us-ascii?Q?150Sv1X3cYSK9P99mZ4JWONzi3dgsL44k0am1fINckeD+UewK+l1PD5Sw8PI?=
 =?us-ascii?Q?Jy4MFXCddln3aV2ly2tALq9Sp4TOwVyKzhQvHIbYVo0qn3gyh6vAXTPMCWq5?=
 =?us-ascii?Q?eXS9RVZsZ8TALLWcozwVVowVEWv5oYCCtEeX2331WBeivU3TbpvTvOYKMccz?=
 =?us-ascii?Q?wKQ//eT4lLtHByM5G8pW/nxK10KT52unnKkphJen4CGoMemh14Nsst8LMrEx?=
 =?us-ascii?Q?nKdUfRwSuQz6EUfxZEHg15TT1muGso5BZ8vbW7fJHTAHq+ou53LRVwBHsJWX?=
 =?us-ascii?Q?L2MpHK5PjVrg75n5OpxeqhJ6qrbtbWSHgwxrXfAbG0Om0ip2uSNdnMhteHcR?=
 =?us-ascii?Q?aXF1fkEud2iE7Alns9CCr16Cn6J5S4Ks8VTVOc8Js4oXZaWuqHe0EofcZDe5?=
 =?us-ascii?Q?lNu8YcPZ3JbWX2NWzCjLKMHDZQbnsxIiuK6vdDLRib+KEQ7ZMGS4/nT2/+8O?=
 =?us-ascii?Q?VOvvFt1V67xOTmI6MWnZlwA2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd9b38-4b46-425d-37ed-08d8f362fd67
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 10:02:55.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38CJ1lNENlDrwWsH2CmFj3Jv3V7r42Z1tHve6JMkNsrDgjd5AYR62YD0dMMddes9RcwmmpbAI9nEsq7WstTjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm->sg needs to be checked before accessing its child member.

Call Trace:
 amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
 ttm_bo_cleanup_memtype_use+0x3a/0x60 [ttm]
 ttm_bo_release+0x17d/0x300 [ttm]
 amdgpu_bo_unref+0x1a/0x30 [amdgpu]
 amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x78b/0x8b0 [amdgpu]
 kfd_ioctl_alloc_memory_of_gpu+0x118/0x220 [amdgpu]
 kfd_ioctl+0x222/0x400 [amdgpu]
 ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
 __x64_sys_ioctl+0x8e/0xd0
 ? __context_tracking_exit+0x52/0x90
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f97f264d317
Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdb402c338 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f97f3cc63a0 RCX: 00007f97f264d317
RDX: 00007ffdb402c380 RSI: 00000000c0284b16 RDI: 0000000000000003
RBP: 00007ffdb402c380 R08: 00007ffdb402c428 R09: 00000000c4000004
R10: 00000000c4000004 R11: 0000000000000246 R12: 00000000c0284b16
R13: 0000000000000003 R14: 00007f97f3cc63a0 R15: 00007f8836200000

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e00263bcc88b..722efd86718e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -867,7 +867,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
 	/* double check that we don't free the table twice */
-	if (!ttm->sg->sgl)
+	if (!ttm->sg || !ttm->sg->sgl)
 		return;
 
 	/* unmap the pages mapped to the device */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
