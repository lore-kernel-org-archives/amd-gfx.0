Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4610CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE51611F2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EE51611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921A66E479;
	Thu, 21 Oct 2021 17:40:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D256E479
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7DivaxRGxNjoPTVdV/I587zR0CsqpmNFVaUIx+Zo4YUy3Isxj6y9Ji32Yi7fYUqcr7Sx4SamlLo+/fmCbK1puWvQ62Y7+BF4n9+cNi8mJs6HMmARdoPYMsJw4+jnENjiuevAmMCruzSiLireqMNBarK6Uark3j2T7Bch3z5lUogKcBelKkj17V/onxiS7F9+VqjrLo2B7+sNAzxAdyy+bLatl6B+tFygCtKZAZn2OJnPFGSa3IFwqum43ptFbtJFouRzgMG32Gw1euyE73e2PASSF/nYBV+0yQAGAh1p/DqGRedTtQXHwgeicSPeQ6E/xxCTM7LA/CQ/7uAll+vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrglOWpaPZz0MI3kgDhZS2BLWA61rF725YJpf2DqOC8=;
 b=XWe8ehpldIqFi7R9ffLJ4ZufobnamD/2yPyZwf2//9z3Bca7hJF0Zv+j8fdLieTLtoiWkWOcVtUrcKJ/ipmSC//OSXyCfhfe/gOBb0E8zOMm/pT3yZ6Alvouj0T5cu9KRptzvYfKChq3OfKKbSRhDOYOCWbCeETYF2EMX3KKcTVjF1ZtTIEpmpC3mrLWzDJo1cRxO68YG/CzjQ6IzX8HSJvZXdm1eJVtnBFkVdjfLKG2a1d/lnDXNDw3Ccy3lnqnGyTbhxPa83u160pONYHfWvNpc67svZoY7PDldfR5aV2O/8n8yTZ34Ur4tHIIAXfeEAUzMut2SlWUoJHVoACPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrglOWpaPZz0MI3kgDhZS2BLWA61rF725YJpf2DqOC8=;
 b=y7B6no0r3p2rT97A15/a/iP/f3mnPj7q8NNmlLcxpMCW/x+qD0ud6liH7ev2Nhzzjzkg74GSI9B6lT097xTw3kGgnHu5mAr75eH3J+gSrYCIlIRi0vysbP4zLda6Pg/i/KOYmrppQuvxMd0TbzgZIBS9Up/Wkgi9f6APt8pBMcM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 17:40:20 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 17:40:20 +0000
Message-ID: <599813d1-9f25-1d17-4042-0375792902c5@amd.com>
Date: Thu, 21 Oct 2021 13:40:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20211021172628.1294703-1-kent.russell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211021172628.1294703-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [10.254.34.99] (165.204.84.11) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 17:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43914f8-2570-4f0e-7120-08d994b9da2e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4972B2AD897959881916AE0499BF9@CH2PR12MB4972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKCNNEy+6GAvgaChRppIizpM1w+itWBybuyvpxJr33ho5UiGiW8fTZLzXXQCIvTdP0aNOGggOq7Lt2kR4fBq3OlLqYnP8la6v0cwDLXpq4Zs8GWRC8joM0yWSQyVGYYSi0g5/fJYrdx5VULMxWUcdO4EnMUpOz0B71yHyJ0oGpaotL050m6oS3Gz9DdBJQ1IHS/pZQ3A1lmAMJJUss3z2AxaOdipR2y0lsgFm0yGyIdfBgBVqUe6wlLu6ibznniHLsQsmYppwJFZzyTban3BUvv6HCjIqJJio4wqo7wZLSzZXHP9q1Np+6ZtyFi/CIzojLeijshX6Bk1ovnhivcNcB/QpLdVS/2pPoO+Uhyuk1jYbOoZUQJcHrsXodyqqGXJvuoltG1MWZyuqjR8I0sHtOcL0L7SbUgJ0IOJaMhthjgHq8F+if1k6VIGWXLiwf/K4+avzZbgXLKEsxWB5USg8naEFI01LwM3M0e/9FDgJoNYA98j5ih9SmW/RRqhsnZYbADqC28yeGfET/RHFJOKcyMwncG+067yA15kzs/mSjGk0rRWHEF6Zauuat5KP+XHMJ7HPI5exwQmcwXk46rc5+HXi7dngFAiATlczosuFbyUaQoCVacey32vYwZaPy0iCKiUs6NGOKS1oqC5s4SUJ2jHqp1wSPwg2320OT0Q4h9tsEZVTslR7DRNnyxCPy3qy5fmxCjHBy4U6w7/mr3njc5t8mjFZvDYHSesyl8Jbk6his4TVqlW6Odu8KzNwY+t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(8676002)(4001150100001)(26005)(8936002)(44832011)(316002)(956004)(186003)(83380400001)(38100700002)(508600001)(54906003)(53546011)(31686004)(6666004)(5660300002)(31696002)(66946007)(36756003)(66476007)(2906002)(66556008)(2616005)(6486002)(4326008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmRSOTBkL3lNRlJaNElnQ203TWNjdFpqL29nTUdyTEdmdllLZWJ0RGRsRlVO?=
 =?utf-8?B?Z1I1RG5aa2thZjBqYjFMU2F2S0R0UnptOXB6ODRJbDhiaUFYZUplN0FiZUFm?=
 =?utf-8?B?K0orMy84bW4rVXVXV0pwZko0YWg2UWFoWjQvaUQzRVhoM2N5TVFqSTlrbVU5?=
 =?utf-8?B?VkRORDdPMTNLTWZobGYrK2tTaFlnc2RheUN4dVloY25ZTVI4M2wrd254cHIz?=
 =?utf-8?B?TmhIbzczKzAxTDQrSFQwTzNqbkFmN3JkWVd2QVhrYmZGdEdlSzZySENRKzcw?=
 =?utf-8?B?YW0yS0haWVhOMVM3MFNRN1JlNEJRU0FnNTk4dzd6eFV0U3JpMmwvSFdXc1l1?=
 =?utf-8?B?UzR6dlpSb1hpQUFWeGp3ZFVqb3dqcWVTbTBxTG95ejh2aTg2ODBOSkJaZkxX?=
 =?utf-8?B?Y2g0Y2syUnZaS0xlUFJOdVhhVzEzWEE0YUFaNitYa0JiUkxTRE1VNWh6UVpP?=
 =?utf-8?B?MlFXTVUrZkIzTjhlSWhqK09naWlBSThTYnZaUlhvdE16K0ZsUGlYTGxPeEFs?=
 =?utf-8?B?TUlKRno2OWswV2JHMElybGFhSDlUQ3NWc2E5S28rdDUxMk1EVWk0MEl6NFJ2?=
 =?utf-8?B?dHlHWm1wOW1PV3lXbEZxWEZXd2syUzg5YVV5VmNSZEJ4Mmk5cksydXpDRkhP?=
 =?utf-8?B?VnF3cU9rSDlRZXhWVzhHRUZVZnI0R3NCSWZmcEtYSW9HWUtEa0FHZndpd3pS?=
 =?utf-8?B?YS93WTdCcGN4U0FMSEFlSjdrZWc5TUN5YmFyOUlQdmYyV2VOS0lvS0Z2VVl6?=
 =?utf-8?B?cmFodXdPNVdwc29peHBDcDczYVhKZTZHNFEyeGNKcEQwaXllR0VFbm5TckNB?=
 =?utf-8?B?TUFrWUlnMkRWT2w4OGdHOURQN3BQSDhWVzFWcENCYzBzUXBjNFcrVEU4WlhN?=
 =?utf-8?B?bDIyYWpmSVpvdndEUEFBTms3MENhZ1ZuVWZLclZjNkdmbVhBZkJpYkRYT0pa?=
 =?utf-8?B?MUFUVUN5cklHUnZSeDFVV2p1OXd6c2FEUDhkZkQzckRUa2FKSHdlTy9KK2tu?=
 =?utf-8?B?Q1pTRnVadEFHeVQ2YVJFSlFjWlB1QldJblNLTng5eXJsY0Q4endBdXMvUlZz?=
 =?utf-8?B?VVMvdURQUGd4WDRKSDhCNUlsN2wwZ1pWbW5nelRaU1Bkak5oVFMyNzBaM2xw?=
 =?utf-8?B?cy9lR3ZYYWxmR2ZaWERBV1k5bXJLYjNJM2lSVk9CR2o0bm42eURZdW1BSFAy?=
 =?utf-8?B?VURBUXc4d3U3b2lFU3krbERpSlNxSU5OZUVmcmRSdlpmbEMzV1dua1NvRG9R?=
 =?utf-8?B?TEVUMVM5Zk0rZ0JmUjY2d2NjZExKRnpZdHlBVFdhQnE5RjdZSU8rODNCbFdu?=
 =?utf-8?B?d2FtVFZhN0JCTDR6Ky9RV01WRFdxcHVmWTNkQmJ2NzBiTW12WDd3L0dtS0dk?=
 =?utf-8?B?eXBzcUhQRWZ4UjZWTm9JWGJtNVoxTjZiTk5QazluMERhcmF2anZ0elcydWlo?=
 =?utf-8?B?cnRPVlpRVVBTeEtOM045a1Z0UHl6T2FrZHc0cDhHVXd0aWtNS21PRlFmMzBw?=
 =?utf-8?B?UXBUZEJMOFg5eUVoR2V0Qlk1dHhpR2ZERUNEVmRJQzlTdGlmNDBFSlQzZ21N?=
 =?utf-8?B?QzZ0UE5IWnRqazdWa042aFA1bzIweDh3R2xHekVsejRPWEw1bjZFQXptMkM1?=
 =?utf-8?B?a1U2MmdRdEVhN2RzWmNiSUhuVUJZdHdaS1NuUnhjenBidzUxdFNMb1lNUE4x?=
 =?utf-8?B?cXFydFlzU1dUdzN4QjM1ZXhMZEpySFB3WTVqdTR1VERpQWgzM1lHRnN2RE9E?=
 =?utf-8?Q?5+tprsDeSgxJ3039EXPC6Ub2QO4B2uCi7x8L9gy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43914f8-2570-4f0e-7120-08d994b9da2e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:40:20.2061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
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

On 2021-10-21 13:26, Kent Russell wrote:
> dmesg doesn't warn when the number of bad pages approaches the
> threshold for page retirement. WARN when the number of bad pages
> is at 90% or greater for easier checks and planning, instead of waiting
> until the GPU is full of bad pages.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index f4c05ff4b26c..8309eea09df3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1077,6 +1077,13 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  		if (res)
>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>  				  res);
> +
> +		/* Warn if we are at 90% of the threshold or above
> +		 */
> +		if (10 * control->ras_num_recs >= ras->bad_page_cnt_threshold * 9)

Change this to " >= 9 * ras->bad_page_cnt_threshold ". With that fixed, this patch is:

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> +			dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
> +					control->ras_num_recs,
> +					ras->bad_page_cnt_threshold);
>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>  		   amdgpu_bad_page_threshold != 0) {
>  		res = __verify_ras_table_checksum(control);

