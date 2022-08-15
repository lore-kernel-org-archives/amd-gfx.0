Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20812C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 11:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9792A328;
	Mon, 15 Aug 2022 11:12:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8D4A9E3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 11:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuccloP6Yz7WJUFxpcDQSnVRPpMUmkUYTKLeGAbj3kPejBAxstfdItgV4HMX/+ETVcVIIiw9QBlMYOpyHNq+I7V/u6v0SBPSjOYdGOD+MGEm2YiWNm9etAgDSKcJ+6fIKnseytlMLTaKn+BkgtCS1ZSnsakB1JpXX5/iq+Ig9gdWVtSEA14TgJqKC0YKxWLlJAqbzwM1sNEfmXVyfHUnLig9oKRCnRdHvbUj5R+gNoYupnNKq6P4mtEYZOGd6Z0awqQy+HUNNmpN93I7Q8teHLOVDkjTA+0p7Q8rk4+PGex25eIikS3TqS0rEI8lgIZ32OjYAgIm+WJoYzG5i/sGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srjw+YuiW3DH+TjgPTJuLNMumUyEWsXzO/QeBWNzYxc=;
 b=hj45m4XlTLnzD58OjBy+dTxnuCGQbVLKjHgN4Y2P9PfNe9CZC3rPdXBMhcT5bWctBHcHQgSTqykSd5+6cuHd2lL+SBPLvtCwkvHcpg4MUtrZXE98l9hHFumGHoknZxp0WceHIdZbwcYUxGoQpkkR80RW+4XxWBIt7sxZCJZ/pXMYlsxhLEV0qtDQaMknjfPFrqY9wEmiNEW0yxk3j0jHCkbZkkWsdionYb+mGml8NgM2h3BXHYCpcicL1mPElybz0Etosz8MW6B4xwITyFBr+2/japeMfP7cCa9vLurBdEdATMCfOt89V7BjFebrGwdwzEBleOffjFUP42HuzXx8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srjw+YuiW3DH+TjgPTJuLNMumUyEWsXzO/QeBWNzYxc=;
 b=dP/26qCqsCnBSTfeFUosVhJ8dTxFDmbge6uLgGdEsWRUiZv6tEo8TIsP6/X62vzpBye20Vc+2wccjY51+nETao7ht6J59GrEiM8qHcRv7D7hj+G2WwCLIwTj1CjzxmNfShNdzpTtMa4uLlAqQFSfv9A5UXQK4EqQyAteaNh8C2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Mon, 15 Aug
 2022 11:11:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Mon, 15 Aug 2022
 11:11:46 +0000
Message-ID: <bf9c0d82-3ad8-3dbd-08fe-00cea08f0d12@amd.com>
Date: Mon, 15 Aug 2022 13:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix UBSAN shift-out-of-bounds for gfx v9_0
Content-Language: en-US
To: Candice Li <candice.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220815110813.11391-1-candice.li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220815110813.11391-1-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0021.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::31) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb03e3f-0359-41b7-35a5-08da7eaef126
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnN+aJP/o2YHhBoHrENRuX7MS3EJTeb0Mx7zF18h3Rvc2aqIndhmCcgELKYPukaAbNrSIgERO6ClgCWoTZkkzB6ZAw/h0PXjFu2o1Lfq/14sJSEa5Xc2PTdD3RR+A1nr1QuJM3xo9IIbXDckjmVgfW8ic/uekRLyN0zAv7eL+FkmYwTpIs3FMmGrh5jiQ80OKI8Rss6GChi7hETiwYSXUrzx8JnrkFKDYXv1arOjaqfsRLuhRIrnSjAAMW31EGAInlXnOhceCZ0g8aD+0Me2oknXaHvzio4h5locH8rfRhUt8CEol1Z3oFg7gKjz8bDSTWNe9slx5XJOZOoQDh59BspHD9ZxF5/g5e2YfC0NuYNh03ALoknLpTadkGlLXIhkPPTM7EHR9wDPw3w4B3ClMBYBn4Dm8SO15YTA3Rh895+gkieQQZmtBXyxNPFxCEwK8H6bZmT8vJLWFg89f0HpAhhtzNf8zhW3AwTi2icsDRUspGsSEOxGcoCsRbXjn2eOk9Wor7CcRpvYAdYoigXUrMVoCx3a5F1PDGMcPigGi2wT7c+xTmOuMDGs0HXOKEpHOtt80vbKRaY28P4rlE/6V8dTXvPNk1YKgRS/6zh9BB/sBgXsEnD4+Im0ouRatiPe8LREx+jBnOUPrmn+1eNQNuRk2Yrw7zF2u4lStVoK3f17MeYVC3Pxz93YFrQRSIbLGHhiFzwW/p627kMJjZpgaFdT8G6EjPk2D7L1yyXnqxmrRsQmDTilZv8MN7bMg7KTdRE5RQgawaVoPN42StdfStapWOmf4fxGmkaTnQV1f1JPyGC+oddGeN/GDCVnx4f1zSjoA9k+jgwaHQSIrwjcmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8676002)(6486002)(6666004)(36756003)(2906002)(5660300002)(41300700001)(186003)(31686004)(6512007)(6506007)(2616005)(31696002)(86362001)(83380400001)(8936002)(66556008)(66476007)(478600001)(316002)(66946007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJMZllGRUpRMkFDWmxYVTdKZGkramRrUzJLYjQ0Q0NIM1pyQmgwejVEQ0ky?=
 =?utf-8?B?bU4zY08yVmVueTdsZFJGK0ZFQjdTeENEcTZrU2NTZzlwRlduOGdPN0RhQkVt?=
 =?utf-8?B?UmdLUnFjK3JDY1UyRjNVQkRMUEFoNXFpTm4xMlFCeU85dVIwTWRiYjZBd3k5?=
 =?utf-8?B?aDUrUTVmaUE4M0VkWUVta3M1L29mM3BZOThlRXJ2VW43dVhjTitaaER0c3pT?=
 =?utf-8?B?WW0xcE9uN09jcFpTTkxnN3JHam5wWFNjT2ZNbU5zOXhaVVliU0RyRDBySW1y?=
 =?utf-8?B?MWszdjdxQytBaVFYRGlUWmVIK2hnY2szTVRaMnhWdmF1T000QUdBVTZSQmkv?=
 =?utf-8?B?VVdHK2R2cjZqNHBNN2hMdTd2U0V3SllHdDNoRzlYRXltdmRISEZPZGV2WHIr?=
 =?utf-8?B?YmdFcnJZb0pha0lybnBLcklvcmFwbFRmQ3BnUDc2VDJHSnNWeFBFOEJXU2NP?=
 =?utf-8?B?TDJwUEdHQTRzZlF2ZEVRN3phbWkzb0RwV2ptN0tYeXhzRGpTSWhvTDlWM25N?=
 =?utf-8?B?T3NhYlJlZ1d5anIzWXl3MmtSTzd0UkdGSUFXSzVWZ2xyTnpnQjk4b2ZXdFJu?=
 =?utf-8?B?L2s4RjhJT0gwekVUeUtMMk5uemM4Y1A3QVhqNDV3M09tN2VkM2RJem9aaGRo?=
 =?utf-8?B?NVNqVmY5WDRwa1d1UmVoZDc3WjJDMFpVSlJ6WlZyWXJlbERQVzY1MFdrSzJH?=
 =?utf-8?B?UFZUQ2gwTnBDdzNOK28xd3pOOWk5K1d6TURmQzZySS9FM2pyNzgrSDc1VEN2?=
 =?utf-8?B?bW5pdkhWZHBQelpqb2hiYTllNVlac3haUXlmaFJ4eVgxTmlaV29EY1ZjbVpD?=
 =?utf-8?B?V2N2aFExS3lIQmdnMGFqK0w2M2RLdXZ5amY5MXlENmh6dkEvcFg5UE5BYlQ4?=
 =?utf-8?B?b1dUTWFKN3BZM3ptejJoVVE4UE5DVDNQVFNZS1I1eTZOVGFFV3VNZEpLbTQ4?=
 =?utf-8?B?YXhUNitVQUxTR3FpVEU2SnF6azRGN2VaMTdjbnBFK1Y2TDI2dHkva1hBd0l1?=
 =?utf-8?B?a1pYYkRKS09KVTk2V250VllmaSt6bDF3MVAyeXozNFc3anR5TkNCc2FnSlky?=
 =?utf-8?B?NVQ5QnpDUi9yRHF5bTJ5T1NhRjZCNjlPWHQrYWU4MWRhTXhoZVNvV09VZHE0?=
 =?utf-8?B?QXl1ek95Q3AvM0pKaytFWlF2MDdhVHNTWEtZR2xRVHU5OFhVcXdabjQrcTZT?=
 =?utf-8?B?QTRZcUlaR3dITi9BT2ZGS2xESkZVWTFMdHNLYTZaeDRuVnNvaitWUXcvSDZN?=
 =?utf-8?B?Z3BLcE91SHg3YnBJZWxwR01vNURMVVhOODVGT0JJV3QwTjZVWXF2WTNPRWFB?=
 =?utf-8?B?cEVEK01VRjZOZDJSWCsrYURHaE1ob0VWOXpnZHR2ODVhM2xubW8xM0xLNHpt?=
 =?utf-8?B?eEZzK2w2dTRZcnNYVERjRHZKbGVKNEdOZ3JHcUladlRjY2RFRjJrMi92SkxN?=
 =?utf-8?B?b1NtR3Z6RXVRc2RqYXJaMW5FSTBIYjZTVkxIbEJOdDRNY2NRalc1Yi9hSkJH?=
 =?utf-8?B?L2l5ZGlFdzcwVHhDTE1CT1RjV3J5RnVrUzg5N1JZQTl6VllsSFFaenNwK2xu?=
 =?utf-8?B?ejZlK0poWGZhZjdyd0xCbmlocFRJZzFGOGpxM091OWtnSHZLTmtuWnpaSFlX?=
 =?utf-8?B?T1NhVUhEWmhHSWRudXVHOTB6UE15YkdMZkgxRzc0RXBsZ2hHa0VUZ2VmYzRo?=
 =?utf-8?B?ZHVReWhrbkNBajhOalNxeEIyQW8rU2RFWVN1M2MrbFVtbXJWaktEU1dtdWZB?=
 =?utf-8?B?bGF1L012K1l5c3pwYm04QXJzOG15aVhQTGQ5aVppdW15NzFIRkQ5MVBEbXJI?=
 =?utf-8?B?ZWw1d010d2tsOFN6QWtVVEFkTmRVSGNvOUZvVVdoYzB0QmhTRHVFRUlvWXkx?=
 =?utf-8?B?aHY4czB1cHljenpIMTBWNFR6TUk4dFoxZXpZNE1meDhidVlacUZvMFoycjkx?=
 =?utf-8?B?M2t4QWZkSEh5R0FYTkJyNGJYMjRQYmpseFRzUDhkOURra1JXRE9QSDUrN3Ro?=
 =?utf-8?B?U3lmV3JkQjhLZTY0MEsyOXkvK1dVa2svbWx0RGVzMWwreEtGZnVBMFNoOWpj?=
 =?utf-8?B?R2ZXWGxGUkJNb0NnZ0paL3ppTUdDb25hT1orTXJyeUdZNVB5T0ZHUzkrZVBW?=
 =?utf-8?B?dTloWEZvTDdwbVMxWWpXWWN6SElhKzI4UWMvLzh6dlgrRHpMdDlJcDQyY1Bt?=
 =?utf-8?Q?3WwIkKAu2nL3yvqugDCkfWHqCwcvnnPCwk9joOqFJLh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb03e3f-0359-41b7-35a5-08da7eaef126
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 11:11:46.5787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh0TNiubgXiQDjxJa6fsgf3c6imrfD051lr/ujVzc5RCp0zHfuctfYWF3M7IL8Dv
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

Am 15.08.22 um 13:08 schrieb Candice Li:
> Check shift number to avoid doing a shift operation when the number
> of bits shifted equal to or greater than number of bits in the operand.
>
> v2: Only calculate shift number for non-zero data and fix build warning.

Well that doesn't sounds like a good idea to me because we just ignore 
illegal data here.

Regards,
Christian.

>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7f187558220e9a..c398c21d906069 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2495,6 +2495,7 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>   {
>   	int i, j;
>   	u32 data;
> +	int shift_num = 0;
>   	u32 active_rbs = 0;
>   	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
>   					adev->gfx.config.max_sh_per_se;
> @@ -2504,8 +2505,11 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>   		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
>   			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
>   			data = gfx_v9_0_get_rb_active_bitmap(adev);
> -			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
> -					       rb_bitmap_width_per_sh);
> +			if (data) {
> +				shift_num = MIN(((i * adev->gfx.config.max_sh_per_se + j) *
> +						  rb_bitmap_width_per_sh), __builtin_clz(data));
> +				active_rbs |= data << shift_num;
> +			}
>   		}
>   	}
>   	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);

