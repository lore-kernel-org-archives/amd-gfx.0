Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111CC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 12:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F79361074
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 12:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79361074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B536E90A;
	Wed,  7 Apr 2021 12:00:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB146E906
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 12:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRg1dP8+lJqstFW//R+Wj+/1sk41zrZ7P9GyEtnKImbZ8rMhVsm1tYwROnFjkDdGh9OhR5kvNHYztZBDDDMqnx5bZSw+HiFuKhI6ts88k4dShHmJEY/RdKj+R8iJO0toPPMxOb9s3ukkQRqYolhPdzNaHHw91Idiy9/kvIi98WIFJVFSHHUriTL8nAvJIBKwcae1xCl5JU5Sd99zaOKxBmQmNPHbzpSIqbOQQf33oeyxjBMofZcK3fAyfDoRLN1YJxQORa+ij7tnHt8N4ibYR9yLJbJR4JcUuY+uafdq9RUeovVkw65TdqrOfUWapvG7hnHPI+eLoMZgZU6OLANsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hEIo238Ly7RDx9DZb7DB7eHHYzgZInI7ng/tiTfDDo=;
 b=ULP+itkCcMMsuOcTrxfU2aVsBrmateMNWagHossY3mRZxRaM3SzSp5rHBCo8KR7iCFCWeVPQrJHU6eBYhH+nDA6yd0lp7UvLtaCPc/dZ0iN82lD/SBlb53Rux/jlT680M6XquEb4FzpUWkNx7M2+oebWWb73TyEHlEqJ/BvMhvRrp4v7iI2MhKgNBdo/K8ZxpUbVoiSeH9ZDdwVQYYWvwCNbcfxxoE5QMZigHyGszKSUez+WfkfJeKjcAqTeOoU7Rt77031jFDH8cwHMbIXEzSF+EtBbCm3+8/UPKCaLbm+8ROe5bB0wm2EeXOku8WaimM/M5JgiLQ8SBtlPXaIW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hEIo238Ly7RDx9DZb7DB7eHHYzgZInI7ng/tiTfDDo=;
 b=cGEH1ox9tKX+RCfdyGP/4FVSm6QKtsYsTsZxVkRLO8lWGhz4jjX69WnfNDigWRJtfrBurFUY6ERBSCfMEVu5OXJ9+40SYmhDPRzAqe4BuIIHZ0nJ0U/7Cb32Qvet3XAbh99S7sVNRYNAADUY+no5oVJl3DdzXovdVQY3TvTQilo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 7 Apr
 2021 12:00:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Wed, 7 Apr 2021
 12:00:22 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix size overflow
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210407113547.1746-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <85d99871-564f-b22a-766f-78d0f2b6ac50@amd.com>
Date: Wed, 7 Apr 2021 14:00:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210407113547.1746-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c8cb:bea6:b85a:47d0]
X-ClientProxiedBy: ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0]
 (2a02:908:1252:fb60:c8cb:bea6:b85a:47d0) by
 ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 12:00:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e782567-14f7-451e-fe31-08d8f9bcb90f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048B99EC06FDDB808D8903883759@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHd5DvTNqRjgDmgTKXP7dK9TuHfRcYqqPFmoB47dATyQ+umUVEe2LptaCW0ck9opSp9CBGO7BIu9Oe0h+3+0yaQiFs02TnTlul4QgCvM9EI+ZJkSbXBi2VyuBgevYiDMAhlBUbCfc7SPc+llteIe8729FjWFDyGhBruOEGtej1C2aGdcI4DK96Fv70N3BPzHX0NoEJ7WcSyQCipHUCsC4mDfFFZhstamEI/vpI/mRnNII0YhSZA+9U8CBB8uaanTuCStPEqXuBohcqKU59qKy4FLfQumCtJ9E2dSl8uZBBXppAXJCLKAKMrn4NmIqey+0N1F40l57eNBe2u4SjKOgq+8kJes3I7DpIXBXeq2mEyTAYbjfvwbt6NT8McW27mD3FdNg5cqj/eRGVplwPnLLasEj7hrIy0RdemwQZqjL/sXNhcaHQ2j/96MGvlqddq8/k0xp5SahyTMriSOGoZir/CQw06NZFGV9R5n9FXI1h/3AtDoKudn4+R9ES3qHbV9A5h6+/5zI0OVEqVRqcX8JrUg2+xUcn5HMCcb+jzsNd8sB511aL2yfF7hQVHqQXlKf6Qa/cvNi3gwvrm250XHMMC2oCEHRagL8I1O7MKugSxFSJKe1TNtz4zhSPwVXV1PvPBi6KMaoZ5VuWjkXzyzJcjDdY3nHlibuWM2WutFNlgzj9JrtWRqV+fbdNKaJZKRDqnsgRlwGU36uuVZLIIxEc+l3QrwYblG5TxDgc+cO7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(8676002)(83380400001)(31686004)(66946007)(66476007)(66556008)(31696002)(2906002)(38100700001)(6666004)(86362001)(4326008)(186003)(5660300002)(16526019)(6486002)(2616005)(316002)(36756003)(8936002)(478600001)(4744005)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWpIV1VCZWk2a2d6LzB4YVdETzkrS0d2L0JJOXMxdUUyTnBQc2Zzb09WRGV4?=
 =?utf-8?B?M1g2eTdkeTlCRUFvU3JMY2MyL1Q4NXI0dEYrcTZmUnBVRmdNcUUzOXNMWmQ5?=
 =?utf-8?B?amREQnc3OTFJZFBKUXN0bDYrZW1hZ0lxU3FzaFZ3bVBVazFqSUE0VnJGSWR2?=
 =?utf-8?B?cTFYb0JuT3VhTFUrTndXOTFSSkFDYW1pZGJtZjN0cUJVNVAvL1V2Q0NtUllh?=
 =?utf-8?B?V1Q5U3phSGVabHNHQ215SGVXVHRCTU5GbS9tV0lha2hkU1JmUWZuYnRpQ0xT?=
 =?utf-8?B?ckIzMjFEZllvYk5HdEdnM0FKSFZRVDExTlV0ZFZrRDVyTUwyYUlBZ0trMy9z?=
 =?utf-8?B?ekg2NmV2YndxUncvbFRjcnVJZDR2YUJNVzVkQmRZdWdNZGVwcndvVXBOWEpk?=
 =?utf-8?B?NmVRTzVJMTBCc1YyNzU5dkttQTVtQXJqejhLM3laZDVFMmZ1UGM0SXFsNE5o?=
 =?utf-8?B?T0JCTUR4MHVYZFNnMGtBNlNMZDI4aGhDWUYzcjMvSzdDNlZCQ2RWZXlZM1hE?=
 =?utf-8?B?SlRGU3BGQ0xUUzRlRzc1R0pEelY3Q3NuR3FkL1FIYmQ1VHlWWlkrNkxRRFNF?=
 =?utf-8?B?V1dvVjJpekUvR1h1Q3dnZFkzdzJOdVhvYVNWQWFXMFQ2SDNoS1U2bmRGUVBp?=
 =?utf-8?B?RFBIZGtPWGh2NzlpajJwcEZzbE5rNFlmeXorajlNS01Fd0trUDUwZlNETkNw?=
 =?utf-8?B?TUVDVXZkeWxLb3lTdFAxUDNMLzQxR0hVcTRTRndDUm9yOHNGNGNOZ2tNV0d0?=
 =?utf-8?B?YzBGWXJGMlY5cWw1c0VmNWE1OVl6SjRHb1FkRW12ZXI1N0tuQ1pCS2hyZUF6?=
 =?utf-8?B?VUZLMFhRaUU3akxxZUFXdHVBb1dDam1XWk9iVlNIR1BNYzJkR0Jnai92N2p2?=
 =?utf-8?B?QXRpTVJQSjRoZ1hnVkJMQjlUOTdURGdoem5sb2JxdnhndlJHR3hybUhQaSt1?=
 =?utf-8?B?ZTlWemt4cW9FQXJSWUxpN2crWS9xK3JNZFhHMzJ2S0JOS1JvcEt4UXdPakpj?=
 =?utf-8?B?TURLRzJicnZmdmZaa0lxMnM1RzhVZ2pXMU5tMTZOTyt1Qlp4dVpPOGJ5Rzln?=
 =?utf-8?B?Y2N0ZFZiRnZud1lnMDZlZ2YrbytjMHJYUkp3eDdaN01sdC9LWndxZG1qQlZZ?=
 =?utf-8?B?M2toV0d5Z1JMWlIxSjdhaDEycExad0s5R2Q3UGNkclpCWW5QanlTcVc0dWFv?=
 =?utf-8?B?S2ZJWitvOVowRklVU3RLdCtKSDVPNllQTWozTVNQdTRreHNqZVZLNU5LY29Z?=
 =?utf-8?B?aEF1RTJkYTVZUG1IMW5QTTBIbjJaNW9vTytncE8yWVVqNnhXanVPUUs5ZFdl?=
 =?utf-8?B?clhMeTN6K3owaC8zR002Nmg0cUtsNHB3ZjFyb0ZEUGFRZXlzTzBnZWVSZnM4?=
 =?utf-8?B?blNFMk1ldmtGSGdzQU9PQTg2dWlreFBiU051TGRXSDRiekwzVUlVc1RpNUFn?=
 =?utf-8?B?ZVR2c0FKdTdGQWpYTWxHTHZFelA0UGtHTm5BTFUwTWFPVzdNSTR4bFB2VURO?=
 =?utf-8?B?MEVMWkpCbUFLT3d3Q3RuaVJaR29IT2Y2SUpoUEwwRTB0dm9EbVRpS3hlTDVo?=
 =?utf-8?B?b0piQXR3cmR1VUU2K2l4VmhmWmtkNlVpRkplcDNRaUxid2RkTFZNeGF2VGFl?=
 =?utf-8?B?Y014WkZTSkdTSlZicHBreFdRdmJ2RHdoakllMzN2b0crQjRXOWMwWlRvVWh4?=
 =?utf-8?B?TkJiRjBJNDRPcnRBRjdEK0t4eG1WQmZBdUtZL3JicWJWb2p6WWhMNThJYjRy?=
 =?utf-8?B?R3Y0V0tXN0dkNkptbGZtL2I0RjlJZzVJVHFGdi9uZCtnNGNVNHdwWGJqRzNV?=
 =?utf-8?B?Zm1SZUx3amZiSzhMUnNpOWdaQ0pDbSsyTy9URURneFJTenBMTHJ4SXlTQklE?=
 =?utf-8?Q?vDGGtOgNgrqAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e782567-14f7-451e-fe31-08d8f9bcb90f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 12:00:22.8185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdei2OQ/mGEnaI3DR55UANWJqpu0/yuXpGjs39xy8zNkGR5kQ4e0sc2kMDFVEeRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.04.21 um 13:35 schrieb xinhui pan:
> ttm->num_pages is uint32. Hit overflow when << PAGE_SHIFT directly
>
> Fix: 230c079fd (drm/ttm: make num_pages uint32_t)
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index fbaa4c148cca..01a5c487505c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -830,7 +830,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   
>   	/* Allocate an SG array and squash pages into it */
>   	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
> -				      ttm->num_pages << PAGE_SHIFT,
> +				      ttm->num_pages * (1ULL << PAGE_SHIFT),

Good catch, but please make this ((u64)ttm->num_pages) << PAGE_SHIFT

Christian.

>   				      GFP_KERNEL);
>   	if (r)
>   		goto release_sg;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
