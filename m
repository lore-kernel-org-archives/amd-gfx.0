Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33162C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE87F60724
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE87F60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6D66E450;
	Thu,  9 Sep 2021 07:16:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82356E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCjROknmqn3/qGMkneiGCMlinntMROZ88s2qloMt6MmY/mZa3YihlVEWqR6mPEqMYeKczXcQm79jYla87O8/tXPJy/2kNiQxpWwoYamrosyQljSr6tFZUWpem2FZs+FNpF92M1yPzpswXXwg6BnbtHhYpdHu9eE1P3McegZTBNCP+VRrrAv/TcTuE86KpFKP+fdUHITotzav7kZr5SHPSLLB0NsS3zywLuenv8mGUKfUe922TmOAl0PlU1iCFMn6lWH5gFTy/an/46ms1azbjDmHzzyRAAXKF1wxHyDU3qhhg4PIkf42X2ndOZeE25G3UHXWsIhwPcpkS7cbk9CNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IxZURREdhztg+dnFeZFul7Sf1gcKCpSRwjcMmadTvE0=;
 b=cUOtzNghEoSnk1i2fEvYvfIriaUNHvgTekGarEmqYyX4sOtzVjDCf4pFItP0kx6kQ6O4+/n4PqNfzCJ5+Pz139kObQXN3TlFAPUiYJ6GcctENF/wLp3wlSia/s6w2DbWcnz1p3pUBfJNAjKPtfhKMwUCuYRQCwnS6fDaxLIqpFm7p6axYWUkdrvF7aUa78ZyA/r3fdpit/ZnBT/K6pcwHpd7KzX1dJNOgHTN/cPkSXsubKWgq1d9o3HOkU9AaQMvrRsCaUgF4QrZHdIZh8KEnAQo4wqk9JXuIFJgvyiJ8HMOP1j6u7a7IytKP8KaH9gncoDuHiLn4fcQJSRm+573gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxZURREdhztg+dnFeZFul7Sf1gcKCpSRwjcMmadTvE0=;
 b=e217oqLXe21DJBnGbxuZaDNt54g0Kq4kmHLtwePQgJbuVKJpoy2wQF/Z7rOv89p2bQLc/Ad7kXmwQqyAIZAz9BG56LkFUG6T3JtU7Zd3Q2YHp9B+fqSC+m5Ijhq05JYPKS3yPUGsnQKGVisosSUqlz88OLGC6CFvshntHLShX8E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Thu, 9 Sep
 2021 07:16:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Thu, 9 Sep 2021
 07:16:55 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: alloc IB extra msg from IB pool
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165E6211939B36FD10BF65C87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <33e834d0-b1d7-16ed-4be4-ec6dd485b5a0@amd.com>
Date: Thu, 9 Sep 2021 09:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165E6211939B36FD10BF65C87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:327b:a453:3daa:de36]
 (2a02:908:1252:fb60:327b:a453:3daa:de36) by
 AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 07:16:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7970744f-bc4b-49d7-2c39-08d97361cdab
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47403EEDA9832A8D0EA441A583D59@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm2IB5fUTyDKQiVSNpyPIv3YbrAzkOrmAtxhZhzYmMBYn/UaYmmG02VboH/OS8eYVuoahGvAIzYsQXBZSA68oa0bVXB5dg5ei9dEFHZpVCZ7ubIsirxlCgexF6uQ/+nq2UgjC4xw2jH8VW4bwlUj/fcC7fWXSZ7ol+hGyS7ha7p6zpnQnT0b/8ON+nI6ICMJKkgr1TWtgXwZjznzmkx1ry5poQarUi3jNaF+iom9TvukocEDM2yaUlhMEV0omtcadVAM32oKDappKjF403maiRjN8Dn2r6vWxQsFuemMnNc5U3VhqDfKOaf2a1LKY6dKKFEtdT5t2bXipxvMCrYlWcuFCjIBwzHCNvhbVKzgpJZh1rDwJZcqvlT9NWFezbblVsx7FFYFIqlr4WGDOuxuGoMXokviDAkohhoFkivElc9anw6yPe82QApUvttRobA/LTsBShgVAj+jx1z+m2SnBGhu51YO9BgRYGf1se/g4UfaLIlaMW6nG5S5Ou0nZPxfBBBb8nUyM2K1F9HVXnWOOIJO1TvyNrEFwP9Tq1rkGqq8ppf/buwh0y65Yjl2JxtgoZgDV6uKdisCtks6YEXJ/Ez/jyNUXnk0ixiSsvvvqflDDS4QQ2orf33GwnwgBNFMbPnoq4xrZJr+WrRHWsVXIqJXOhZHqteBOEP+PvtCnEB9JWO2t2yhUFzUBRZnO1cvolCktWRskWgOdDRcgiAytcbqjns0oUO63W+v9jiAjwvOXn1Rbiht/hGqbWgXMBLS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(66476007)(86362001)(2616005)(66946007)(4326008)(5660300002)(186003)(66556008)(478600001)(83380400001)(30864003)(316002)(110136005)(6486002)(2906002)(38100700002)(31696002)(31686004)(6666004)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?VTRQNyt3L1pra05hcXVVNUNyZ3lndHVhdEhBNFIrb3pNa09QLzlNU2NkemJv?=
 =?gb2312?B?U3FlT3VZUHRmZVZIZUxabldEOThiNWhxbm1aVlNNa1l0bFdPaVJWN1AwYVNG?=
 =?gb2312?B?bU1UUnMvSEhJeGVHbkRabzBTaVg1TitQd1Q0bk1PYThMek5kT09QRXdGYzBI?=
 =?gb2312?B?TG9XZWhhVFF4TEhKc3hGMGQzaGt3eEVBWk5VeCtYN2pTQnV5cXBsL0EyQjlX?=
 =?gb2312?B?bTdKNmJ3d2l2dERpUHdrOWUySVhGazFxTmpYS3FJZGtoVkx1Y2pQQ0ZZSU9t?=
 =?gb2312?B?QnlNZ0ZVd0hxNk5VVHh0Tk5QeVkySGcrTTZHa1NZNmQ4bEZkRDYrbE9LcmxU?=
 =?gb2312?B?bHNsNVNnZjREUU5FQ0pWT2JjUmJCNzZ6b3lqbXdDeWdwLzZBYXBQN2tOWDhF?=
 =?gb2312?B?MHBxUVZYR3NiTmZNWEliZ0VBZ2FhOWxmU280eGZCTDF6WFdnemlwYnFHS0pP?=
 =?gb2312?B?dDJwRDRXNHlzdVpKT2VuTzdId0NNT2ZmK3drWDBDZlVDTWhBbVJyTUd5dzRa?=
 =?gb2312?B?OFJ2YUNvaWlFTXkrWHJVamtDYUlBdGx5MitlMklDSzhGMittNnZSMmN4bHlB?=
 =?gb2312?B?SHlGZkhHR1dMR0JERzErT2JPaU8vOFgzNGkwNWtkOXo2TTJzcTRZZjR2T29B?=
 =?gb2312?B?UjcvUG5NMU1OQXo3d1dpdWllR0RQM1lreDN2aTR0SEgrRG5HYm5reVNER0VM?=
 =?gb2312?B?UDRHUDVmVkFBeVorYzZFOE9JUk1LYWxmaDY4N3E2NDcva1g0SjFGZ3htaWlH?=
 =?gb2312?B?dVE3WkJ5b1RoMDVuQnFkYnhRV2lIaXVSY0pNQWVSYm9LRW9UR3dQSXNhZXVm?=
 =?gb2312?B?TS9ORVQxdjM0UkJIa3R3My9qZjcyOFNyNVRqb2VhY2dnVXhvTjFIZFRpTmFJ?=
 =?gb2312?B?NUM0MHZtNGp6b3hTeGR1ckJ0NnIwQW9RbzVWWEhmMHg1bFQya0tJeUEvSE1G?=
 =?gb2312?B?dlFpejQvbkxzVjloNHBFN2oxWlIxeDJpaVlOa3BwVDFaYWFKcXg5M3g5bC9t?=
 =?gb2312?B?dkROTWIzcFI3ZjE5R3lsWTJkdFNuYVJqUlVZQ092aXFCcDdnMExkR3d1YTY1?=
 =?gb2312?B?UmErUXJBN0dHMlc3Z0xUcWNrWmorV0d6bW0vc0FGVEFoYk1xV0s3QUlBK2Jo?=
 =?gb2312?B?dVg4NEsyVUY2MGJ2L21rOGoyN2tvQ09TVnpIUTJhbW9uZ3hPR2QzaXFvSUtP?=
 =?gb2312?B?RS80cENUTG5JYjliZXdReEFyVk84NEx0cjdUSmp5NUJxdUkxN0VLMEJza3U3?=
 =?gb2312?B?TlZIeVhPbmZ1UENvY2dUVHRXZUcrL0pQWlAwN2Z0QnNmY3ZiT0JLZnBuWU1x?=
 =?gb2312?B?WlgvaG94U3NmcEVWNEpxaWFIeG9kNVk5VGZ2Z0REcmFVSzZZQWFXUDRCK2NZ?=
 =?gb2312?B?eDg5SjBDLzZEVFdQSzZ6RU9RTy85dGoxVmg4azBlb3VhOGRuR0FPUUNJRlo2?=
 =?gb2312?B?aHFpSTErSGlTS1RBNTF3Z1pXWEZERlpCODJ6WjVQRFJOZDVUTTRIU05Yb2k4?=
 =?gb2312?B?RU1uRDJLSzZ6aVhSaTJTbGNPZzhlU3dNK1pkbUpQd3Q4SGNQRSsyK09YdThW?=
 =?gb2312?B?UkxvSXhnZnc5NDZyUFk1dFJTc0dEb1ZKclBxcXRJRnhkUnN1Nk9oM3J3UFB4?=
 =?gb2312?B?N20vdUM3cnFGUXNQTWQ4b1VHN1ppLzdiZEd6K1ZWUFA0S05nNm8vSUhPMytI?=
 =?gb2312?B?VzNRUERBa2daN0Vtc1NVOFVOK3Z3MkNzS254ZkNDNVRUVmpVZDU4ZDN1RGEw?=
 =?gb2312?B?NVlLOFE5MktpTXh4cHB5czJ4MkNtZFcxSTYrOEJBTGVKQndLenNBbHgzVmFL?=
 =?gb2312?B?bkRrbWdKQ2hER1FVblV6WklTZW5PQ21sSW9RZzN2Zk9CWFl5QkI0RUhrMmU4?=
 =?gb2312?Q?vSjC5cr9uJBFO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7970744f-bc4b-49d7-2c39-08d97361cdab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 07:16:55.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCknCiy+oT/x7Q6kWqPIUKq+vlbvtxqzSfsQPScyQBCwsJERzw543iHSRpzI/OxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
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

Am 09.09.21 um 07:55 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> There is one dedicated IB pool for IB test. So lets use it for extra msg
> too.
>
> For UVD on older HW, use one reserved BO at specific range.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  18 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  99 ++++++--------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  28 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  28 ++--
>   6 files changed, 185 insertions(+), 162 deletions(-)

Please split that up into one patch for UVD, one for VCE and a third for 
VCN.

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..733cfc848c6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -299,8 +299,36 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>          }
>
>          /* from uvd v5.0 HW addressing capacity increased to 64 bits */
> -       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
> +       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>                  adev->uvd.address_64_bit = true;

Yeah, that's exactly what I'm trying to avoid.

We should use the BO approach both for old and new UVD blocks, just 
making sure that we place it correctly for the old ones.

This way we have much lower chance of breaking the old stuff.

Thanks,
Christian.

> +       } else {
> +               struct amdgpu_bo *bo = NULL;
> +               void *addr;
> +
> +               r = amdgpu_bo_create_reserved(adev, PAGE_SIZE, PAGE_SIZE,
> +                               AMDGPU_GEM_DOMAIN_VRAM,
> +                               &bo, NULL, &addr);
> +               if (r)
> +                       return r;
> +               amdgpu_bo_kunmap(bo);
> +               amdgpu_bo_unpin(bo);
> +               r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
> +                               0, 256 << 20);
> +               if (r) {
> +                       amdgpu_bo_unreserve(bo);
> +                       amdgpu_bo_unref(&bo);
> +                       return r;
> +               }
> +               r = amdgpu_bo_kmap(bo, &addr);
> +               if (r) {
> +                       amdgpu_bo_unpin(bo);
> +                       amdgpu_bo_unreserve(bo);
> +                       amdgpu_bo_unref(&bo);
> +                       return r;
> +               }
> +               adev->uvd.ib_bo = bo;
> +               amdgpu_bo_unreserve(bo);
> +       }
>
>          switch (adev->asic_type) {
>          case CHIP_TONGA:
> @@ -342,6 +370,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>                  for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>                          amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>          }
> +       amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>          release_firmware(adev->uvd.fw);
>
>          return 0;
> @@ -1066,7 +1095,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>          return 0;
>   }
>
> -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
>                                 bool direct, struct dma_fence **fence)
>   {
>          struct amdgpu_device *adev = ring->adev;
> @@ -1074,29 +1103,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
>          uint32_t data[4];
> -       uint64_t addr;
>          long r;
>          int i;
>          unsigned offset_idx = 0;
>          unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>
> -       amdgpu_bo_kunmap(bo);
> -       amdgpu_bo_unpin(bo);
> -
> -       if (!ring->adev->uvd.address_64_bit) {
> -               struct ttm_operation_ctx ctx = { true, false };
> -
> -               amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -               amdgpu_uvd_force_into_uvd_segment(bo);
> -               r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -               if (r)
> -                       goto err;
> -       }
> -
>          r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>                                       AMDGPU_IB_POOL_DELAYED, &job);
>          if (r)
> -               goto err;
> +               return r;
>
>          if (adev->asic_type >= CHIP_VEGA10) {
>                  offset_idx = 1 + ring->me;
> @@ -1110,7 +1125,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>          data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>          ib->ptr[0] = data[0];
>          ib->ptr[1] = addr;
>          ib->ptr[2] = data[1];
> @@ -1123,33 +1137,13 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>          }
>          ib->length_dw = 16;
>
> -       if (direct) {
> -               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> -                                         msecs_to_jiffies(10));
> -               if (r == 0)
> -                       r = -ETIMEDOUT;
> -               if (r < 0)
> -                       goto err_free;
> -
> +       if (direct)
>                  r = amdgpu_job_submit_direct(job, ring, &f);
> -               if (r)
> -                       goto err_free;
> -       } else {
> -               r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
> -                                    AMDGPU_SYNC_ALWAYS,
> -                                    AMDGPU_FENCE_OWNER_UNDEFINED);
> -               if (r)
> -                       goto err_free;
> -
> +       else
>                  r = amdgpu_job_submit(job, &adev->uvd.entity,
> -                                     AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> -               if (r)
> -                       goto err_free;
> -       }
> -
> -       amdgpu_bo_fence(bo, f, false);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
> +                               AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> +       if (r)
> +               goto err_free;
>
>          if (fence)
>                  *fence = dma_fence_get(f);
> @@ -1159,10 +1153,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>
>   err_free:
>          amdgpu_job_free(job);
> -
> -err:
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
>          return r;
>   }
>
> @@ -1173,16 +1163,31 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>                                struct dma_fence **fence)
>   {
>          struct amdgpu_device *adev = ring->adev;
> -       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_bo *bo = adev->uvd.ib_bo;
> +       struct dma_fence *f = NULL;
> +       struct amdgpu_ib ib;
>          uint32_t *msg;
>          int r, i;
>
> -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_GTT,
> -                                     &bo, NULL, (void **)&msg);
> -       if (r)
> -               return r;
> -
> +       if (bo) {
> +               r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
> +               if (r)
> +                       return r;
> +               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> +                               msecs_to_jiffies(10));
> +               if (r == 0)
> +                       r = -ETIMEDOUT;
> +               if (r < 0)
> +                       goto err;
> +               ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> +               msg = amdgpu_bo_kptr(bo);
> +       } else {
> +               memset(&ib, 0, sizeof(ib));
> +               r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +                               AMDGPU_IB_POOL_DIRECT,
> +                               &ib);
> +               msg = ib.ptr;
> +       }
>          /* stitch together an UVD create msg */
>          msg[0] = cpu_to_le32(0x00000de4);
>          msg[1] = cpu_to_le32(0x00000000);
> @@ -1198,23 +1203,52 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>          for (i = 11; i < 1024; ++i)
>                  msg[i] = cpu_to_le32(0x0);
>
> -       return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> +       if (r)
> +               goto err;
> +       if (bo)
> +               amdgpu_bo_fence(bo, f, false);
> +       if (fence)
> +               *fence = dma_fence_get(f);
> +err:
> +       if (bo)
> +               amdgpu_bo_unreserve(bo);
> +       else
> +               amdgpu_ib_free(adev, &ib, f);
> +       dma_fence_put(f);
> +       return r;
>   }
>
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>                                 bool direct, struct dma_fence **fence)
>   {
>          struct amdgpu_device *adev = ring->adev;
> -       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_bo *bo = adev->uvd.ib_bo;
> +       struct dma_fence *f = NULL;
> +       struct amdgpu_ib ib;
>          uint32_t *msg;
>          int r, i;
>
> -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_GTT,
> -                                     &bo, NULL, (void **)&msg);
> -       if (r)
> -               return r;
> -
> +       if (bo) {
> +               r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
> +               if (r)
> +                       return r;
> +               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> +                               msecs_to_jiffies(10));
> +               if (r == 0)
> +                       r = -ETIMEDOUT;
> +               if (r < 0)
> +                       goto err;
> +               ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> +               msg = amdgpu_bo_kptr(bo);
> +       } else {
> +               memset(&ib, 0, sizeof(ib));
> +               r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +                               direct ?
> +                               AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
> +                               &ib);
> +               msg = ib.ptr;
> +       }
>          /* stitch together an UVD destroy msg */
>          msg[0] = cpu_to_le32(0x00000de4);
>          msg[1] = cpu_to_le32(0x00000002);
> @@ -1223,7 +1257,20 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>          for (i = 4; i < 1024; ++i)
>                  msg[i] = cpu_to_le32(0x0);
>
> -       return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> +       if (r)
> +               goto err;
> +       if (bo)
> +               amdgpu_bo_fence(bo, f, false);
> +       if (fence)
> +               *fence = dma_fence_get(f);
> +err:
> +       if (bo)
> +               amdgpu_bo_unreserve(bo);
> +       else
> +               amdgpu_ib_free(adev, &ib, f);
> +       dma_fence_put(f);
> +       return r;
>   }
>
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index edbb8194ee81..76ac9699885d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>          /* store image width to adjust nb memory state */
>          unsigned                decode_image_width;
>          uint32_t                keyselect;
> +       struct amdgpu_bo        *ib_bo;
>   };
>
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index e9fdf49d69e8..45d98694db18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
>
>   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                    struct amdgpu_bo *bo,
>                                       struct dma_fence **fence);
>   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>                                        bool direct, struct dma_fence **fence);
> @@ -441,7 +440,6 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>    * Open up a stream for HW test
>    */
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                    struct amdgpu_bo *bo,
>                                       struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 1024;
> @@ -451,14 +449,13 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>          uint64_t addr;
>          int i, r;
>
> -       r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> +       r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4 + PAGE_SIZE,
>                                       AMDGPU_IB_POOL_DIRECT, &job);
>          if (r)
>                  return r;
>
>          ib = &job->ibs[0];
> -
> -       addr = amdgpu_bo_gpu_offset(bo);
> +       addr = ib->gpu_addr + ib_size_dw * 4;
>
>          /* stitch together an VCE create msg */
>          ib->length_dw = 0;
> @@ -1134,20 +1131,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo = NULL;
>          long r;
>
>          /* skip vce ring1/2 ib test for now, since it's not reliable */
>          if (ring != &ring->adev->vce.ring[0])
>                  return 0;
>
> -       r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &bo, NULL, NULL);
> -       if (r)
> -               return r;
> -
> -       r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
> +       r = amdgpu_vce_get_create_msg(ring, 1, NULL);
>          if (r)
>                  goto error;
>
> @@ -1163,8 +1153,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>
>   error:
>          dma_fence_put(fence);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>          return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 561296a85b43..b60d5f01fdae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>   }
>
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> -                                  struct amdgpu_bo *bo,
> -                                  struct dma_fence **fence)
> +               struct amdgpu_ib *ib_msg,
> +               struct dma_fence **fence)
>   {
>          struct amdgpu_device *adev = ring->adev;
>          struct dma_fence *f = NULL;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
> -       uint64_t addr;
> -       void *msg = NULL;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(adev, 64,
> @@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>                  goto err;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
> -       msg = amdgpu_bo_kptr(bo);
>          ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>          ib->ptr[1] = addr;
>          ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> @@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>          if (r)
>                  goto err_free;
>
> -       amdgpu_bo_fence(bo, f, false);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +       amdgpu_ib_free(adev, ib_msg, f);
>
>          if (fence)
>                  *fence = dma_fence_get(f);
> @@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>
>   err_free:
>          amdgpu_job_free(job);
> -
>   err:
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +       amdgpu_ib_free(adev, ib_msg, f);
>          return r;
>   }
>
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                        struct amdgpu_bo **bo)
> +               struct amdgpu_ib *ib)
>   {
>          struct amdgpu_device *adev = ring->adev;
>          uint32_t *msg;
>          int r, i;
>
> -       *bo = NULL;
> -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     bo, NULL, (void **)&msg);
> +       memset(ib, 0, sizeof(*ib));
> +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +                       AMDGPU_IB_POOL_DIRECT,
> +                       ib);
>          if (r)
>                  return r;
>
> +       msg = ib->ptr;
>          msg[0] = cpu_to_le32(0x00000028);
>          msg[1] = cpu_to_le32(0x00000038);
>          msg[2] = cpu_to_le32(0x00000001);
> @@ -630,19 +624,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                         struct amdgpu_bo **bo)
> +                                         struct amdgpu_ib *ib)
>   {
>          struct amdgpu_device *adev = ring->adev;
>          uint32_t *msg;
>          int r, i;
>
> -       *bo = NULL;
> -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     bo, NULL, (void **)&msg);
> +       memset(ib, 0, sizeof(*ib));
> +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +                       AMDGPU_IB_POOL_DIRECT,
> +                       ib);
>          if (r)
>                  return r;
>
> +       msg = ib->ptr;
>          msg[0] = cpu_to_le32(0x00000028);
>          msg[1] = cpu_to_le32(0x00000018);
>          msg[2] = cpu_to_le32(0x00000000);
> @@ -658,21 +653,21 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo;
> +       struct amdgpu_ib ib;
>          long r;
>
> -       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>          if (r)
>                  goto error;
>
> -       r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
> +       r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
>          if (r)
>                  goto error;
> -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>          if (r)
>                  goto error;
>
> -       r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
> +       r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
>          if (r)
>                  goto error;
>
> @@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   }
>
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> -                                  struct amdgpu_bo *bo,
> -                                  struct dma_fence **fence)
> +               struct amdgpu_ib *ib_msg,
> +               struct dma_fence **fence)
>   {
>          struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
>          const unsigned int ib_size_dw = 64;
> @@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>          struct dma_fence *f = NULL;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
> -       uint64_t addr;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
> @@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>                  goto err;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>          ib->length_dw = 0;
>
>          ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> @@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>          if (r)
>                  goto err_free;
>
> -       amdgpu_bo_fence(bo, f, false);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
> +       amdgpu_ib_free(adev, ib_msg, f);
>
>          if (fence)
>                  *fence = dma_fence_get(f);
> @@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>
>   err_free:
>          amdgpu_job_free(job);
> -
>   err:
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
> +       amdgpu_ib_free(adev, ib_msg, f);
>          return r;
>   }
>
>   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo;
> +       struct amdgpu_ib ib;
>          long r;
>
> -       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>          if (r)
>                  goto error;
>
> -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
> +       r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
>          if (r)
>                  goto error;
> -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>          if (r)
>                  goto error;
>
> -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
> +       r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
>          if (r)
>                  goto error;
>
> @@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>   }
>
>   static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                        struct amdgpu_bo *bo,
> +                                        struct amdgpu_ib *ib_msg,
>                                           struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
> @@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
> +       addr = ib_msg->gpu_addr;
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>
>   static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                         struct amdgpu_bo *bo,
> +                                         struct amdgpu_ib *ib_msg,
>                                            struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
> @@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
> +       addr = ib_msg->gpu_addr;
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -918,21 +908,23 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +       struct amdgpu_device *adev = ring->adev;
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_ib ib;
>          long r;
>
> -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &bo, NULL, NULL);
> +       memset(&ib, 0, sizeof(ib));
> +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> +                       AMDGPU_IB_POOL_DIRECT,
> +                       &ib);
>          if (r)
>                  return r;
>
> -       r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
> +       r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>          if (r)
>                  goto error;
>
> -       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
> +       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>          if (r)
>                  goto error;
>
> @@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>                  r = 0;
>
>   error:
> +       amdgpu_ib_free(adev, &ib, fence);
>          dma_fence_put(fence);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>
>          return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index bc571833632e..98442462135c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -206,14 +206,14 @@ static int uvd_v6_0_enc_ring_test_ring(struct amdgpu_ring *ring)
>    * Open up a stream for HW test
>    */
>   static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                      struct amdgpu_bo *bo,
> +                                      struct amdgpu_ib *ib_msg,
>                                         struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
>          struct dma_fence *f = NULL;
> -       uint64_t addr;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> @@ -222,7 +222,6 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -270,14 +269,14 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
>    */
>   static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>                                          uint32_t handle,
> -                                       struct amdgpu_bo *bo,
> +                                       struct amdgpu_ib *ib_msg,
>                                          struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
>          struct dma_fence *f = NULL;
> -       uint64_t addr;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> @@ -286,7 +285,6 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -331,21 +329,23 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>    */
>   static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +       struct amdgpu_device *adev = ring->adev;
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_ib ib;
>          long r;
>
> -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &bo, NULL, NULL);
> +       memset(&ib, 0, sizeof(ib));
> +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> +                       AMDGPU_IB_POOL_DIRECT,
> +                       &ib);
>          if (r)
>                  return r;
>
> -       r = uvd_v6_0_enc_get_create_msg(ring, 1, bo, NULL);
> +       r = uvd_v6_0_enc_get_create_msg(ring, 1, &ib, NULL);
>          if (r)
>                  goto error;
>
> -       r = uvd_v6_0_enc_get_destroy_msg(ring, 1, bo, &fence);
> +       r = uvd_v6_0_enc_get_destroy_msg(ring, 1, &ib, &fence);
>          if (r)
>                  goto error;
>
> @@ -356,10 +356,8 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>                  r = 0;
>
>   error:
> +       amdgpu_ib_free(adev, &ib, fence);
>          dma_fence_put(fence);
> -       amdgpu_bo_unpin(bo);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
>          return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b6e82d75561f..3440ef554f99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -213,14 +213,14 @@ static int uvd_v7_0_enc_ring_test_ring(struct amdgpu_ring *ring)
>    * Open up a stream for HW test
>    */
>   static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                      struct amdgpu_bo *bo,
> +                                      struct amdgpu_ib *ib_msg,
>                                         struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
>          struct dma_fence *f = NULL;
> -       uint64_t addr;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> @@ -229,7 +229,6 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -276,14 +275,14 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
>    * Close up a stream for HW test or if userspace failed to do so
>    */
>   static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -                                       struct amdgpu_bo *bo,
> +                                       struct amdgpu_ib *ib_msg,
>                                          struct dma_fence **fence)
>   {
>          const unsigned ib_size_dw = 16;
>          struct amdgpu_job *job;
>          struct amdgpu_ib *ib;
>          struct dma_fence *f = NULL;
> -       uint64_t addr;
> +       uint64_t addr = ib_msg->gpu_addr;
>          int i, r;
>
>          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> @@ -292,7 +291,6 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>                  return r;
>
>          ib = &job->ibs[0];
> -       addr = amdgpu_bo_gpu_offset(bo);
>
>          ib->length_dw = 0;
>          ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -337,21 +335,23 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>    */
>   static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +       struct amdgpu_device *adev = ring->adev;
>          struct dma_fence *fence = NULL;
> -       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_ib ib;
>          long r;
>
> -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &bo, NULL, NULL);
> +       memset(&ib, 0, sizeof(ib));
> +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> +                       AMDGPU_IB_POOL_DIRECT,
> +                       &ib);
>          if (r)
>                  return r;
>
> -       r = uvd_v7_0_enc_get_create_msg(ring, 1, bo, NULL);
> +       r = uvd_v7_0_enc_get_create_msg(ring, 1, &ib, NULL);
>          if (r)
>                  goto error;
>
> -       r = uvd_v7_0_enc_get_destroy_msg(ring, 1, bo, &fence);
> +       r = uvd_v7_0_enc_get_destroy_msg(ring, 1, &ib, &fence);
>          if (r)
>                  goto error;
>
> @@ -362,10 +362,8 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>                  r = 0;
>
>   error:
> +       amdgpu_ib_free(adev, &ib, fence);
>          dma_fence_put(fence);
> -       amdgpu_bo_unpin(bo);
> -       amdgpu_bo_unreserve(bo);
> -       amdgpu_bo_unref(&bo);
>          return r;
>   }
>
> --
> 2.25.1
>

