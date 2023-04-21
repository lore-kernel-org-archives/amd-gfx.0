Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D29C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 21:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647EA10E335;
	Fri, 21 Apr 2023 21:05:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1BC10E335
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 21:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM/VUFzYOsa0gF9xsNweUMc1rvOtTsPOSM+Lei4DJklOrKHSl04iR4DETAwpbjWtP2qOHQ/4ZkUB0CbbK62bBvVZmQeUfe8UPBB1hgF1x1yx6fdJw0Ah7BI0DwGNrNh3MSy+GLchygBCxlDF0lQIZIXaVEslmj6SwhFepnmXI9ezXohyHnVwYXwzF73oWyAWQrG+gFrijjjoCQVEi2xGiBDZw6lsOSDI/w69MLP5+k+2dkwVVRx9aCFXoXJaA0SeJEBSSVn7Hq+tIbWd8X13bgghIo4ECLeTNUED9zyzFoBkTl6k8uVKipaGbyW/WEl0LvMh+JHVcN4vXVfyKuaWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaoLmmz2tqR2uGV5cxjuST9H9MOCj3SrIxehQUnEOGk=;
 b=W8eXAy9iQIVgoMu1+wMZu3q5ynQSVcIOxYh83PAHDBkSZvBWX6KW4Hd/2EdeKy1sQWTcWHEUEctLjCnELd+zwkT4X1nCBHSHoA7CgS82JTHyOdejNkPZjRQ26k8k24su6AUGGDwWQZu8tquHM2nHQbqopvhv8zC7DaTaoQTSe9drqjbPQYpxM8KwZmMPuHCL11d+bAGlih2WNvNEM6gAPdd5aV4hLqk7i+cWOtMp/Hy3xzkuVAlL9fqyk/e67GJ4l0venVI8M6SWOHjLKoZkbAywveo8m4yIkBH4YL6kEOzaTxIiIilDpMsidpTS33GVedBmDdYPAVDewLRh1qTcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaoLmmz2tqR2uGV5cxjuST9H9MOCj3SrIxehQUnEOGk=;
 b=FTCxhTjfJIXweMuFl57wbeRsLNbzIl9JHTvn0zkTvWJ5S4n4/6XK6GGqiIzJ46hNKDci7c5uDHtr+EVSRjk/4maY+AfwqT2fZGAl2miVA8m9dbgWKSjGrDgDRmbMiRbhK8r6/0O+g8xdOFuVm6TeQDyXaI7kwcbNq5J3rzvdJ88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 21:04:55 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad%6]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 21:04:55 +0000
Message-ID: <664fe660-a89f-a519-fd73-361d06dca725@amd.com>
Date: Fri, 21 Apr 2023 15:04:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
 <20230421203933.1085320-2-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230421203933.1085320-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:208:a8::30) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9e3ecb-a42f-40d2-303f-08db42ac0f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNTHtu5czLeWS7GPw+yRgc7Ed0yPKj5Z7LTiLlka48sge3q4DzMIZfVwTmcnzQ105JrnY/XPE8Vk8eUTkpCfQnfUe/BN9fktKQFVmpxSxzjn0q291I0hsOl1NKoQggsPCvZOesCIaZJ33ZfjsaIs/24ij4ew3/0kBqKjIrQvSGJdl62WRnpWYo8gHgx4SxneODg5L2KyROOA7l/TyvqXnaTEIhkARZj3rW2aS7QZJHU3LvNWeAVyv0WrxP1MSBlcZymUqA+RvvCDzP55eW9jXQzihKyCCQDJ9Uq+ZDkvdthx4hJG7jAhT0AdlivBfJ/nbwbGG03+Gf6g/WSzySg1Y6rOosQwSWQD2ti5AMCvCJ8GsiSyUs8oUutNlqAzZt4+uhAHvf7BGvmpAD2/lZ5VrlUh33CNvcqmdOxtYlcDz3wJsl7iB86Bu3hN4d76c1JhuP/Ety3ddZSsDSOxQi3U9rLt50h9Yk7UYRqscKx1Kfo30piC49eZ3h5Ra9y9SGXfiAFDH3w0NEo/0z385ycjmmVBfFXPR1a2fg+rruJtougNc5ZLzvGRYkJZ+zdXIkJ1efi5R5fIJblGP5Th+zYb+mTsJiQ2gxGkUOVEi2YXSvqfZRKufPdawkUvOvQSw+8BgHZ4VSO86FMgVkUbS9XUIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(83380400001)(6506007)(6512007)(86362001)(41300700001)(31686004)(186003)(53546011)(2906002)(36756003)(5660300002)(2616005)(6486002)(31696002)(38100700002)(478600001)(8676002)(8936002)(316002)(4326008)(66556008)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFgvRU9nN00ydkxzM2cvZnhVOFhuUlRxeEhINmxQbWNSTWhIK2wwOGVXb2o1?=
 =?utf-8?B?UFBqV2ZvbkFuRituK05IcEdYRlloUDZGSjlxZzI3YmpVQ0s3VGFTSHBQaHQw?=
 =?utf-8?B?VE5sVU5kQVowdThsSDlOdmN1YVpCMmpKSWpwQUQ3REhPMlZEU3k3Q05wR0Zt?=
 =?utf-8?B?c0lBeGo5dU5odHJQOFp6NHZkR09vVXcvalZyKzBndDZSeGZjR3o0TmVTNWN1?=
 =?utf-8?B?U1pDcms1bU1BdzRoUUlmbzNBRG9CZDI0VHBBQ3YrbUlPVW9ZSERmUERidVVQ?=
 =?utf-8?B?YzJYZGg4U1VVNm1QdVM3bDZsSTFmOVVKTXBVa1A4aFFmMStiSkhvYWZoa1oz?=
 =?utf-8?B?TCt3dTcxL3AwYlZvdkI2a01xbEszSVFaVVZvSE9HMklnL1R1T1RGaVBuNFU4?=
 =?utf-8?B?L1g5Mm1mQUpaL3NpQm8rRmd3VU4zbEdRMnFOaUlhcUdwVHNidzFIT1NtUG9M?=
 =?utf-8?B?aDF2MVJLQithMlNRbkxZZzdYejFRODhEWS9TVlhpekFrV2pkMkZVbUM0OXJ2?=
 =?utf-8?B?ZVAyUnN6cHhNTFliU0NxZklaMXUwcElTUGN6a1g2QnZFQk0rb2pac3Z2cVJy?=
 =?utf-8?B?ZmpkdER6cTA5Ny9hNVp2b0kyVlNrcjNub0t6bll3YWdwdHgycnY1b3NXc2U5?=
 =?utf-8?B?bDE4YitDbXBVa1dyc2k3b0R2TElpZkhvTmkwMFJYb3o1QmkzVFFVZmhuVXlI?=
 =?utf-8?B?Q3ZPVEh3T3Nqa2xULzlRQ0dJZXJqU1g0VCtQd1h5Qmo3eVBPS1FzZDdwQjll?=
 =?utf-8?B?dE5lZGRVSnVYeFFEUk5qb0x2WmczWGhDRkd0R2wwUG1sRjdJaWVvblNtR2Fu?=
 =?utf-8?B?SDRoMUg0UTdzWHlmUjRtc1ZqUlpSY1c3ZG1iWERQNVkrVzhsVCtrMFMrZ3I0?=
 =?utf-8?B?blJxTjIxbkF6THE5SjE3QWtmWEFKNEgzSkVmVDBuVnpiQjQ0K2g5U09kcW1T?=
 =?utf-8?B?cTRDMVNsYnlLRGowQzJzUU5vUnpSRmp5bmpYNUtEbHl1N2UvUEg3cFkwK2lo?=
 =?utf-8?B?elNaNVE3Vm1GRnczR2xPSko5QURsT0FwbmhhbXhVYTJUTFROUmNjOFJOS1Zw?=
 =?utf-8?B?L1lLcmNqUUc1QlRheEhkK0xaVUt1b0ErN2FBcTUwSlBJV1pNajBlckJjV2sy?=
 =?utf-8?B?by9Qd2Rmc2kyQjN2ZXV3YU85M2VmbFBjcmdjeHRZKzBPbVplSGVQYyttc3lv?=
 =?utf-8?B?elVqc09SZEtCQ0MvM1lOc0EzMm9QM2E3ZEhBYTJFSDRoaXlqNnJhYWdaQ05S?=
 =?utf-8?B?NEJtUnFpaXRna0lrNStuR210WmR6aG5KWUVDSE0vY1hSM0pLbnRBL1pqNHBV?=
 =?utf-8?B?RzEyUDFzQjF4M29ZdGFzUGM4VkV2VVlZNk1jdkVCazJzQ3oybDNDaGdDdGcw?=
 =?utf-8?B?RzZod2tpaVBnNmVNVUFpUXp5aEtlYk5VWkFBUzUxREt5d3cyeitGN2o1STJa?=
 =?utf-8?B?cjJlUGV1U054UFQxaWkrVGNJTFV2NERqYmNIV3daUWgzbVpQODlCK0J4TWd4?=
 =?utf-8?B?RWlJYlpzeU5seDFGeTBhV09DVi96ck84Q2RjbGZwUHd2UUc2SGxzaENxMjJq?=
 =?utf-8?B?R1BVWm5Ba1l1UWwwd09tVzFRdHZlajBQenRzTWFnVTk2MnEreUhxNFNhUFRO?=
 =?utf-8?B?NTlISUducDJaK3pIN2pTRitqL2U4T1V0V1dKYWFvRjVjT3lFeWFZVHlrZ3VT?=
 =?utf-8?B?NW5TUUJlUEtEQnJFbG9MM2tiR1JVK2JRd2c3bmVvS3RHZ3BSWjlyRmVwakY4?=
 =?utf-8?B?Q2ZZTGI5YjhtL3FzRTk3bjJLM05tMGxhRnZ4Ympza2paMXBEcDFQMmtPMFhI?=
 =?utf-8?B?bklWM0xmQkZOMm9OeHlTSkF0UFI5WWdCd0Q5QUZ0ZE5VRTZBL1JGbGZ4ZTlX?=
 =?utf-8?B?b0h0bFlzSU5leTNVQkt1VFdwQ1lHNXo3M0JDeldCNjVmeER3OGR5cDQ1WDJK?=
 =?utf-8?B?ZzRDUm85ZERGblk2MityRlB5cVMzL2JmeE4wZGZncmkzUytTcjNVNVQzRy81?=
 =?utf-8?B?QXlXTWpWeHZ3QXJpWUNjL0NPa1orTkVTbU9iMDBrZ3cyL3BsV01RVTNHaE81?=
 =?utf-8?B?VFM2alV4cFhGL1NXaTFFTk4ya2JuTXUxcDM0QU9jekRLWDhBcmFpNHkvemZ1?=
 =?utf-8?B?VTlCeWRiNGJVZ2U4RFhOeGs4V3ZrWVRJc0IwSEFXbEpKb1NPN1M3V0tKaTV4?=
 =?utf-8?Q?4Le2wVgjxrll1ejiiqMfo+6oK0YJpUiHYSNzvWKoIpn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9e3ecb-a42f-40d2-303f-08db42ac0f03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 21:04:55.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHJqRfTIypE7v2T7uPwHjAHMxbNSOQrU0AA7+iKWdANDRpzme3da9Gre5sSUyfe1dTrqc2XPOiN7bWtyKvNc2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/21/23 14:39, Aurabindo Pillai wrote:
> [Why&How]

Drop the above line, with that:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

> 
> OTG_V_TOTAL_MIN/MAX_SEL bits are required to be programmed to 1 if
> writes to OTG timing registers need to be honoured. This is usually
> needed only when freesync is active. However, SubVP + DRR requires that
> we're able to change timing even without freesync being active (but
> supported). By unconditionally writing this bit to 1, we remove an
> unnecessary dependency so that DMCUB can change OTG timing whenever it wants.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 2ee798965bc2..6ef56fb32131 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -245,16 +245,9 @@ static void optc32_set_drr(
>   		}
>   
>   		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
> -		optc32_setup_manual_trigger(optc);
> -	} else {
> -		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> -				OTG_SET_V_TOTAL_MIN_MASK, 0,
> -				OTG_V_TOTAL_MIN_SEL, 0,
> -				OTG_V_TOTAL_MAX_SEL, 0,
> -				OTG_FORCE_LOCK_ON_EVENT, 0);
> -
> -		optc->funcs->set_vtotal_min_max(optc, 0, 0);
>   	}
> +
> +	optc32_setup_manual_trigger(optc);
>   }
>   
>   static struct timing_generator_funcs dcn32_tg_funcs = {

