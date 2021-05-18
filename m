Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A8C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D5B6100C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5B6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEF56EB7E;
	Tue, 18 May 2021 13:29:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455EF6EB7E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE+5Bua3zABtr+KGa7pPd+1WYIpOK3dCFiXyYwS/eVh8oPYXMuzUd9hufdRDP8NDcUNrVKCPVR1V9fSGjZ11ApWPxaDsQMksiIRqssy1ZkV2qioQ7G66YDXa3k+xm63nppjFD/G+5HocTMoTKk9rgVVIpWpKmmNENSQ/7vcOEBEGYGp5GXCZV9W2u21cIGP4y6+nHGFZbt+3AHy1XBZBL3g6pIbqi7tEatFmQv+zeaDhs5fK6ogNZa9tKmv7MbBVbiinSj5UYk9Aubxf+AzqU+PjnWIzcP1Gc/puzl//buRj/iYlxKbOgq84mm2fzcnZ11UdD1oxuxpqmRUWVquzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGA9lMfdtqnnuCuduIP48awOAe8KUsNb5fbiJtmgTds=;
 b=ePxsRlXSy9ZiIpMdeYi6u6k58bpzilJE5CbFsXFrdILhV2fIhxH7FyEKbbdaImEfn4drpdcNvpjZUfRaO7YdHvgSxU4t+bR8q8b9PO96Qa3GxHMSaXgyoVzhT2pKJKgqZsACAy2jk4RnDzqw6AIUJIprtW3vnT+zcRPCThyRn9SEBqbEYhiS6MwebQpnz4/Za2M6/4g1jXjMc/Efu5xuuvoZ8SeCl/rr+3+9RlJj/HHLB8J5A0xM0wjP+3wYissqP67S6rqOH/9NXPlW9ryQ8Bn8dJKf2NEQLQu+UxwOWeb6oI9/HItOOdQuwub1ufoM2kPRug5jJwqnvO8VAFgGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGA9lMfdtqnnuCuduIP48awOAe8KUsNb5fbiJtmgTds=;
 b=mOyW0mNZ4mELv87a2txGz9jiVYVJVq8ByITLis73mk13BAuv6fYuTsGvmIv/LnFZaWWLLpiHwFYhqvJ2vtzrrFn+iZ+Y7La1Ln7LUyLleeAD9YZGJlsHh3Wnf7xuVF8s3OJd4zN0spbuPHRlv73w1QdcPvu1aEW7OW+Gdh7cBNc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 13:29:20 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 13:29:20 +0000
Subject: Re: [PATCH] drm/amdgpu: add cancel_delayed_work_sync before power gate
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621284148-24512-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <49055e2f-2d5a-86c7-1a89-3524ea7514f9@amd.com>
Date: Tue, 18 May 2021 09:29:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1621284148-24512-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:bf03:fc1b:6d6c:b08f]
X-ClientProxiedBy: YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::9) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:bf03:fc1b:6d6c:b08f]
 (2607:9880:2088:19:bf03:fc1b:6d6c:b08f) by
 YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 13:29:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a07b57-b4d6-4cb1-9f75-08d91a00f14b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB49276D7C9BDCA1B0027E3924E52C9@DM6PR12MB4927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCd+bFF46QCcDlYg2dZnJ6QCY3JdhKQzsiB4cdkHrnQgWrUBFM1xd70c+m1tabjeZC1o2M5z7vzsUqfScpe8KcUfreMfNsiDWDuPqexRtHIEeXQaLAKYm/HYfLZm8ftm/hPK0XZXKEkHsOEe7mdp7fU/Hpp1vfqn6DcCPxooFrehCc8T88++oi89Rya5z4Y7foSmgX+pbJyi/FieWVhM3x3sGGMkJ17yjzZ5id46683SMMyLrsernn+p5b6bxmUxXr1d2lyZgwMikUk6egbUPda2iWavNc2wKYA3MTQnREoO9xo/4Uyrpz/5TfuwXAglInf09u8t6WYItZxZv1ekgKci2klUTaCsUxW3JvY98F5IgM00BxD3zvBV4N0r8+6Rgv1rOXYN8CmGuocqlj0BvCPjv7KHEddHkIjpvlT3YfdY8Er4BhYy9YxDNFtxwLKgadRqNJMQOtYfT0gAwjzHS1FpW6XxxmUVbSc3IRyd1ORQwhecvpOLl1T+aeeEJT48KFXBBD3bYCbcS+jGuuOnmU5f/glXI5yvKmhObiRsjyJ2H1D6tIoFPo7VMVflQdr6xbcSpCdEnxXnDPFbnRhkTuj96e55IbF3rZ+AF5STZ/R8GKkYlhVfBKJhVBtcPdt3VyBeaN5sVK4cR1/fuC9iNwUNeN01HV911/RLTYtAapNiYTD2rr49N0UE3IAmAhGU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(44832011)(83380400001)(16526019)(8936002)(86362001)(2906002)(4326008)(38100700002)(6666004)(186003)(36756003)(2616005)(53546011)(52116002)(316002)(66946007)(5660300002)(478600001)(6486002)(31696002)(31686004)(8676002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1lTaU9xUG9wWXBncThjMUlFWHkwT1BQdG5FWmJoM2YzWmt2RDU0MWxTS1VW?=
 =?utf-8?B?eDdXWGhtaTE4N05lTjd0T28ydXZhMzkvbnJrZ2hEb0dEZ0FIRHBMZ1ZTbWs3?=
 =?utf-8?B?SzRjNVd5NXh2ZytlMU8yUDBiRGJqR0tDcWNObXdkUCtUdDhhc2dyRHdJdll3?=
 =?utf-8?B?MWZMNU1qM3BFelB1ODhRU29HNmVoS29mMmcwR2xVWGVQQXQvTU82Q3pZVlRa?=
 =?utf-8?B?N0tDcCs3M2JJSWpSZU9vaGZCUE5DK1Mvd1puL25Sek9kNHhodDRkR0RPa0x4?=
 =?utf-8?B?bG03ODRGa0NLNFpoMTVZSS91dFhhbEFVeDFQZWpnT21QMDBEc2xTWGhZazMv?=
 =?utf-8?B?eXVJaldVTmRrd1NpNzE5SnduVC80V1FKYVhVWDhVbW5pa2lENW4vcVoxQStV?=
 =?utf-8?B?QWFabXFKbEZmYk5QL1NPc0o2Q0wrZFp5U2xhdzNBbHFTdTJiUWROWVBNR2tJ?=
 =?utf-8?B?czk0azhDZnB1ZVdsZEJyeW92TXpRaWd1emJqRDJ0d0gwaXkxMy9TdDVTazEv?=
 =?utf-8?B?L3k5ZVNzZ0UyRFMrV3ovOVRXQXMwbWpPWlp5MThtaFFiRnRnaXFOZEhHZjFw?=
 =?utf-8?B?MzlhOE1jMEJ5Q0lOdXZtNHJMdmU0anowSVI0M0JzZWtLc0cxazB6UWloL2dO?=
 =?utf-8?B?UUdodEJSd3JMUFhtWmpzMjl6TFIvSkFmUUN2U2hDamk4K3FCY1BaaFVmWVJn?=
 =?utf-8?B?UmI1OHQxa2x6ZTVkeFhkK3ZGVSs2bFQzcWZxNWFINm9IRnJmSGV5T0UrbzRp?=
 =?utf-8?B?cVdoQ0FsSTJJaHAyLzhBay92VTh5TGozeGZmMXYzdDRQZjdydmRDay9ERWZG?=
 =?utf-8?B?YkpoT21URlVtdDBIZXQ5YnQ2eGtsSlRhWUpwZTY2NG43aHZpYmFLb2plYU1H?=
 =?utf-8?B?eDhVTERCZ1ZtWDlyOUVuaHIzampKSnBwaUg1enBXQ3ZYZDdFbm8wZ0U1ZXh6?=
 =?utf-8?B?VG5RQlJ2UE95MUNYUU5jL0RXYlRhaFY4dXBTc1RPRjNpeElkNkdHS1ppbmFZ?=
 =?utf-8?B?Mk12ZWxIYXZCQ2IwN1hyVHBzajhyYnRFMU5sRzgrbEJMVi8yYlh5d0p1YUds?=
 =?utf-8?B?R2w4SGt4VWVvK1dBOVVLUTZld0UzaFZwekNGTDJsU2F0bG14Y2RXZEdtRXBF?=
 =?utf-8?B?bkpwOWlYRFVqbW5IaDhnaXpVYm5FYW50cnhxM1NqTTJMbitQV2ZvdlZIOTFi?=
 =?utf-8?B?OTMvQkNiemhoeS92RTVibCtPUXczT2s1WmJyYjNWdlh1N0FxVWwzNGpWbjFu?=
 =?utf-8?B?RkNpTTV3dFR1TFVKeDBPeU04YkV1b0E3TVdJQzFla2JabUdLaG5GcjBaQ2lr?=
 =?utf-8?B?eE1NbldBb0NmSFVWazMwS0RCd2pSNWpqRElJdUZ1bm5rTjhUKzQ4NGRDWjBH?=
 =?utf-8?B?WUNXcHhtKzh0czNBb0FTQkVLSjlpblpoVXJ4VTVMaWswVGVCR2UzME5YZ0ZY?=
 =?utf-8?B?alNGTHBZMm9QQlljUGJ6bmRvLzFPcktpbXZyREJKZXNtWG9Iam9RNnNqWHRI?=
 =?utf-8?B?czNlZjI3bFF2WXVtUEVPREZDZkhNU2huSFlWNmxGMkpxUXU2Wk1UcEFicnlI?=
 =?utf-8?B?dU8rMFdYb085cUJGS3Q1NEhYdmFrTVlGVlpmTTJSdlZvQkgybERCcGFCMENk?=
 =?utf-8?B?b1ZQTlhZSWVLZWd0eEx4b0x6SlA5cnFMREJURU5tVGFhbkxnMjRlVWRhWjVH?=
 =?utf-8?B?R1RKamU4NEs5bWFUK1ZXeENEY2dkRmpOVnJpV2ZSTittZ24zRGEvWWgxSW5Y?=
 =?utf-8?B?ZHA2cWsvWVJFQkJWZDJxeC9zdWlFWnpCS3lDYWRWWlVUcUphYlEzbFZlSnVE?=
 =?utf-8?B?REpnbUc1UVk0Y0xNU3FCeUJoOTdMTkwxQ3RLZHBiYWhYcFZDL0dYeHFXUDZI?=
 =?utf-8?Q?FtNya3uW+LmUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a07b57-b4d6-4cb1-9f75-08d91a00f14b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:29:20.2152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beFfYW9ixhmCVMRkVwqs/tFCYs2Q8ZKmkl4BameEHyBBmvfrVM4xVVGpmcyoO+ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2021-05-17 4:42 p.m., James Zhu wrote:
> Add cancel_delayed_work_sync before set power gating state
> to avoid race condition issue when power gating.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 779e585..360dff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -388,6 +388,19 @@ static int vcn_v3_0_hw_fini(void *handle)
>   			continue;
>   
>   		ring = &adev->vcn.inst[i].ring_dec;
> +		ring->sched.ready = false;
> +
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			ring = &adev->vcn.inst[i].ring_enc[j];
> +			ring->sched.ready = false;
> +		}
> +	}
> +
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -396,12 +409,6 @@ static int vcn_v3_0_hw_fini(void *handle)
>   				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   			}
>   		}
> -		ring->sched.ready = false;
> -
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -			ring = &adev->vcn.inst[i].ring_enc[j];
> -			ring->sched.ready = false;
> -		}
>   	}
>   
>   	return 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
