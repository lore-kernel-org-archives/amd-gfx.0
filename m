Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8772BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 15:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBC310E841;
	Tue, 11 Oct 2022 15:11:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038BF10E841
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 15:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNyfBCTxYtCePWsAMOwHSCpVol8iPPVPp4iet+SlAgby0iJ4pTjlBhSSj9R+vc4Mfm/sTGcLHJwWy91++X7l9KbvWSo1qe2YaU0yOSlPBTpTExlMk2LQNqG/6xwjEWteZmkQZuEXmWzIvOmxFl3ZoOPLFeqLoavmHtL2TsRbRcwtCmaUV90eTdhzRFZTNI4RSogaxuBHxrN+QtKl+MUhA2DDZiR/tm/aHne0IZodhFemyab3qaoPOG7tuGurGhHJyjr0K9h2IVsp/RGHHa06h0PgJWRn84NrNrLMszJewHHm//rNtxCuuO6okdHrgQkWfO0cZex9BuUnnyd3z5+vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYunmet7McMQm14hYRm0b1bkMMOCQ5Ctu3hKjfa4Lnw=;
 b=M7IaEwgWwypiplloOyg0Y6ojgipQ1eimKuEXjrnfWlvCZY4I6bEQvSGBlCAuWUCdz0SyzpS1c3286wqL6ghOztL2Htze6GCbBRY+VZVd2E/IrhF1JLxa86vwgCBy7XZEu6BZTzUKMqej8vThD+REyc4OAW02uB5qXHX+QsAWipDNSoIxlicAJMGBQtkWIXbJ45nwG282+UwRDQAlC3m39hWOlUPwbNfomQ3MdSY8SW3kcSxvRcs7jZ7n6jaErjDFYqX3NrpfngdGF42fkzegJfOhcu6VtSYEGCRPlsWquSHD3W1hUdoqxUoU1o5cePoXOcrjgip3F/e13eGcKzUAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYunmet7McMQm14hYRm0b1bkMMOCQ5Ctu3hKjfa4Lnw=;
 b=5KtoLVVMwZQVb8uRK0WaustrCGWD6sS4elSYBR500JHLzf6wMPS1vdID2Hf2eJki4tCngOGhsKTwdE9LmNCwol7FrYHfhv6WoDXQUA0hwq8oc7jHzKiP9ixEOyMCzXXsXGTrQZwOV8sMBHGXgF8Pkmw4kOIrqj66g8G6kIx+pO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 15:10:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 15:10:56 +0000
Message-ID: <76fc22b8-56a0-35c9-aef3-d3f9891bd58b@amd.com>
Date: Tue, 11 Oct 2022 11:10:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amd/display: fix indentation in dc.c
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221006153215.450989-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221006153215.450989-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bd38ed-e6e6-48fa-f0f9-08daab9acc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16IwRVBRJXTj3LM0QDock8oAfpgde14PKqOH6sGWz/axUpkKTCgB9wfSbd1yLl3YBIiWBILJ0UN/fHO49eNUA/+hn0sBqKHO+E57R0+X3Csiq6Cxf3qKEM6DghnHuUhM4kzdBsohkW5Er07WWfTiBRKjEfoLpmy4uyelqiT0aUcM1rSsycASB4ZXdSNFqOyzNkU/yLJbA3afjDUrrrHwK2Pp+fK9Tev7BGu/PEcoUKLIoS648j9vfpLLArsk9YXZ+mji3lzFklVVx98r1ZwZy6Bw00YCLJW3GReIoYBIS+NMOGGFryHczF9Qb4YgJCbjxbF5cE172EBWtlxdeZdVBOHnAcg3ziD61VXEACtgWA3UE6rHe4JGTRuBu3VDoXHW/Bw7RIXD6Sl1qkignusEvkohJ6mX7Co0Ygmu8nwcwD9mF6qLIiKDhXPv5VNd2dzPKXe+7kIBB8nKmt+xMvtFTMPwkbHy3XJ0LVIUESZ5XEREyoEtzZVtD2I4MnOOcGjdXQoA1HAP6JPiDo47HsYkTeEst9LR3ZK6bBGv8v8i8o+oAnTFy10CakLkkbJ8rzjYUF/D423GWwo5dmry5j5085IamHe6aEEyzU+PPYR2ECLa3A07QQDoYwICMe1wkBWDCH9WLx1ZpSzQQm+p2IHsVH0CkGP2K+AIut878NsosrOwS7OsCyV9aDI4uePPPh8K+wkwS8tCDjIidvESauizWKkNjykXCmQBorgqayFWbvYmKoSIlAbPy5h+g5OCMQAbMXTgIX0xs5pASHppXU4wqedTCGie70fDSvsfFephIQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(2906002)(31686004)(316002)(186003)(6486002)(41300700001)(2616005)(6666004)(66946007)(83380400001)(66476007)(66556008)(8936002)(8676002)(5660300002)(53546011)(26005)(31696002)(44832011)(6512007)(6506007)(86362001)(478600001)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStaL0IwK1E2QmQyMmphbUhnNHZXY3d0Z0daUFNlTnBrVXlFcldrZ3F6MjYr?=
 =?utf-8?B?bVgybXp2WGRQRGhrMVdFZGtFNld6d2FiYnRiSFhrVmNTYzdXbTRpbERpaEZP?=
 =?utf-8?B?dnM0WEpQTEUwYlBWc0YzekE2enRROVFRYUo0dzQvV2tYc2RHLy9zYjlncXZE?=
 =?utf-8?B?dUY3OG9yUWEwT2NDYis0YVRZQWtnbnIrU0k0Y290RVQwM1lzZEVURWxIeXd4?=
 =?utf-8?B?eEtWcFdXSHI4SFlRQnBhNW1iSG15UHhqcXA1SzBJQUxZZDFQRjMvMmJvSDRM?=
 =?utf-8?B?S0lTUnJuWXBVb3hNN3ZlNzhhT1JkTExGQm8vTkdzZnpJcUQyOGFpMFRRNFl3?=
 =?utf-8?B?cHVUNjJ2SWpxR1JWYXhjR0xvRkNPUXpINmo2RTBwNG5ZWCtjTGRzbXpUYS9I?=
 =?utf-8?B?MlB3L1RMbW42T3NBdVRLeklzbHZIamp4QkdlWlAwbVN1ZzV5b3FuL240ekQ5?=
 =?utf-8?B?MXJIY2F1Qm9MQjJ1cnpSR1gvNVVBaEFIVW1XckRJcDQxSExiT1lSS3VtbmF5?=
 =?utf-8?B?dFFVL0dzRUo3VG52V0pCRlkxazUrSjNObzZiWktOZmUyT2lPdkFvTVh0Y1Qy?=
 =?utf-8?B?aWFRMTNNQlk5bDEvWXQxbGtJSC83aDU0WDNJM2FYZ2ZyM1ZTTXJkanZtU0JE?=
 =?utf-8?B?SUg3Z3I2N0VzUjVxbDNJM2xVVFg3TTQzWHdMQkpTd2RWaWtlNGE0eXhSUVdN?=
 =?utf-8?B?MVMxUU8zR1NianhtUEM0N1FRNFNFMnlQVjRMNmhWRWM0NHhQMEkxT0V4R3Vt?=
 =?utf-8?B?S1ZoRHd6U2g2WE82OVZwZUZPZnBaaXR6MHNOWTl5Y0VvdE5PdmxqSGdhUlA1?=
 =?utf-8?B?OGdBL0czRGkzOUZVZGgzWWI3bDFTN21wbjZsY0NKRTBqdVJXeHZZU0d5czdm?=
 =?utf-8?B?OUtldkIrQUxzT2p2N0FEZUlLbFNRWE1UQ1hpTnRKOElCSnpRdkt4Y1FzN0xG?=
 =?utf-8?B?RWlMQnI1Q3hqSHMzM05Id1pvbk1YSk5YS0txSWxBclhueHlMeUJYVCtuSHYy?=
 =?utf-8?B?Ti9vWnNubVlscWh4WjhndFg1YmFrVFJnM0kyanNzRnMwNzU5TFpiMXdDMGNy?=
 =?utf-8?B?dHVyOUZBZk9zU3NYRm1LM3lKMUVtL0hYeE8rOGZEQ0RlWWlMZjB4WU0yRWE2?=
 =?utf-8?B?UUtBaEFQTnFZZGtjbjZraVEwZm1jNlhZK1Y0RkFzeStXcUJkZjVRNkVFNUZ1?=
 =?utf-8?B?VXJYcnc5UlZ5NWUzNE1SdUVNMG0zQm94Lzk1clNCKzA3VjBsWUVEdUFqb3ZD?=
 =?utf-8?B?OVBvQ3R4NldoOCtVTTJ2YnlhcmM5SUt0UGN5M3ZJVVhiL21CM3N6NGx3MFVZ?=
 =?utf-8?B?ODJVY1pleWE5UHpQVk4zLzl6dEdvbXpjV2phNW82SmNvMmhmQXF1NGl2bUtw?=
 =?utf-8?B?ZDQ0d3pBU1dXRE1uTFJCQU8vM0pldFdwL2g3VzBjOGVKM1J4NlcyRllyZ0ZF?=
 =?utf-8?B?WFFlc0tNVStCaVRtbkg3cmh2bWNSNG8vU1BqOGVCNE1TYit3a1ZDMVJhSUZ6?=
 =?utf-8?B?UFdFTWxBWnJSSW9uMktDa1FDQXdMSkhSeE5wcXdZVlNWTEZGMDBidGRkVEln?=
 =?utf-8?B?RVU1SHhOUGNLaWlWT3NpMVA0YmExR3JQSHpkR2hLbHRxY0Z4MzlhbTN5NDFD?=
 =?utf-8?B?bjYvNTd4anJXWUVFejBoall5UDVKSXEyRStNUldpZDgxSmk1WjNtZ1FaMHN0?=
 =?utf-8?B?MGZneU9NSkVwYWxzcUhnSzUrZGlocTliQ0hndXRkVWx4ZkhvK0owOHVOM1dZ?=
 =?utf-8?B?UmRGTjZYenc1UG1yOUxkYU4wZlR2NWQ1TmRHcFJGRzJldzlXSHBVN0czVFBC?=
 =?utf-8?B?M0pKL2JrMmtPWGlTcy9oTUV0cDZaUHk0NGZtL0pTd0czcm1TZnJGWTE2TG4v?=
 =?utf-8?B?ek9JcmZRbHpiK280NllEM0FXOEZOSWJ6cFZSVlMwUW5MUWtCK1libEQ5NGRH?=
 =?utf-8?B?RGxQYVhFSEV6c2pnVDdBanZiZTA1OE14WTdaVXdOeld5RmhXTmVDRjVrYkw5?=
 =?utf-8?B?TSt0VE1Vd013aXJEbWtPTzcwQVpKQVpjMVQwbzlvV0RKZDBBOTh4VjgrSmt6?=
 =?utf-8?B?c1lxM3FRSHRHL2k2RVUzZWhpQmg3Y0x5VE41dndQazQ3OW1qaEE0cmlYZHk5?=
 =?utf-8?Q?EGpoMvxB9k2kFzECO+xaI77Qc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bd38ed-e6e6-48fa-f0f9-08daab9acc0f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:10:56.5287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSAz2zjj1dCpieEljbotC5nusInFW064hPqEhZp+8H0VhyQCiXEcXx1fL9+ReUuiDjSsJ0uydw8xoSo1BROBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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

On 2022-10-06 11:32, Alex Deucher wrote:
> Fixes a warning in dc.c.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 40a34b600c8e..96bba1c8246f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3526,9 +3526,9 @@ static void commit_planes_for_stream(struct dc *dc,
>  
>  	if (update_type != UPDATE_TYPE_FAST)
>  		dc->hwss.post_unlock_program_front_end(dc, context);
> -		if (update_type != UPDATE_TYPE_FAST)
> -			if (dc->hwss.commit_subvp_config)
> -				dc->hwss.commit_subvp_config(dc, context);
> +	if (update_type != UPDATE_TYPE_FAST)
> +		if (dc->hwss.commit_subvp_config)
> +			dc->hwss.commit_subvp_config(dc, context);
>  
>  	if (update_type != UPDATE_TYPE_FAST)
>  		if (dc->hwss.commit_subvp_config)

