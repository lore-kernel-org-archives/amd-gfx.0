Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F147DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81AA6187C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B81AA6187C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB0F6E446;
	Thu, 21 Oct 2021 16:45:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6786E446
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbVzwEdNcmtW1ccALibi70heKvOlCiVv9xr0nEgSQTS0yZLH3jo7R5wpaP9QtcK6Bitg4v0t60IHfbuq0DkxzbJO1ErAoMWPf0gFpP5illA64+bXroePx5FXZMCN/3B8SgE4IZmTIrhuQ0oolLxfh7QepouG/jHmPDp7HrGabfnI65Tf8upJRNuwTrttDihh2zkQ1BnjHR+iHHFUOoQs1PWdJj9+8RDFAs15Dx2um14DP8mStSvhS/VDgOZj7SuQJsVaZAtmfOe1VdCQuw52v45fEeyKsCpHWURzfXITIjOK8aBMcNe6LAq04bk+wwNebExT4WtOPIl5ztkbtDNj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axdfQ+W9AXh9oLwQ7OAsnkkWz2QgngbGxZBfob2QLOA=;
 b=OnCdjPzcEh02ABYeVFSZUnQ7crCecVZTK4swi6LIRypH6CzHP8FqFJRkA/NElMiWrGiQXB2ugSEILSOWDSulK/JDf4v5igDIUaDS2h67fVaUZlKJEKIpLNxD6UNthRa7j/LidEei+2dcbmyGbEQfOY+fpytr2QfpXQref8NYbl4sP8zEpDeOthwb5yep1Lw2+xo4vsCL917BxOp31GYiv3bF7qTpOUvD2Hs4fzFlVA13FnvKM8FFXeunDLf3/M5UNicImeZUDGu3WSh2IHZO5kjpfiiU9lg/YNmKs58OSsTKqmNpRbrKxyuCJV39dVNsxjBgJVRLrgRPthcgRlKjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axdfQ+W9AXh9oLwQ7OAsnkkWz2QgngbGxZBfob2QLOA=;
 b=cDpS4Ns8OHIpViW8716ZFDU0/pdYDKY+Ym8R3oykllh+oFXG/AOZn8ZnSO5nQONnQ4sCcX66387Po8FP4aANFPU5t9CWSG5HWzq4l5UWMlH3rKCeWYUktVCHKKWEfVLNFs6iYBS5LQaeLYIH/EBeIoIQnaLxaC3Yey2mUUQq748=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB3655.namprd12.prod.outlook.com (2603:10b6:610:25::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 16:44:57 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:44:57 +0000
Message-ID: <df069bd3-76cd-4662-b4c3-23e6e17c77d6@amd.com>
Date: Thu, 21 Oct 2021 12:44:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::9) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [10.254.34.99] (165.204.84.11) by
 YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 16:44:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4f9624-ca6d-4ed3-c591-08d994b21dc5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3655171CE0000538E6E2149899BF9@CH2PR12MB3655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9IVykv54Bc+eHI8qPe07LrbRDrXYrUrMRnRmOzlXcBw8bL5SZmzJVRvSoB3X5CUY8IlLNfw2MQDyThS/fQJlme4ytXoKKOs//AAmR9Hy1h6s6b52Wrm+h2KSLnMCyp1OXsNw7GjvvyU3UZGXcWLN28lyYDoRpfmTXIwh2HQeLjllRtMe32T+uvQbfo2SUvOcD2BwLWxJXS2OwjWBrWzC2wYLZ9wo639IMQjnw+tOvxTjz023ycGJqWU7weDgzzvitZkJfs1OvzFt88wvEm1I6WucA17T4dY68n76EPC0PzmjAdwVp1BoXLeJPb/+jz9jlpnEDzf4Tz3Ih6d2rqtgTgTYs+JqDfgSqhl8K/rF5ihH37y4+NoVtGJgEYC2uLjCOQN+jWjK3aFZgCO9PbLl446P9CguOIXWmps3WV6wsbkKMOWR1zjLZ3FpiKAUXVsxuOEZOBDtNjmD1o2KBmg9HsPSGu2YDIzZDZyVSg3Z1qeVQsdHX2YKEEdPv6fO5T57+6OKDekimNZPkqi7fsmL41qILrOaYd00LIirUIADTf4YKW49s3+FVYf7CovLeIRe4Xx9x3NB2mz+TQwnTLeuBzE7hhEe/TPfHUSpH6Mg+i7C5WZgRIMdx+5hnZnsZCktuu7+Rn2MQwjGPajjo3/kNTQXq2hQYnrEqDQHjkXayoqt/NizSNWYLC0tkEpSoxUgCdQw5liLm7R53VsyggzvXx0XHPrJ+TSZgwAYZZtD1jGj91mByG9hqYPvfPgWWfb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(16576012)(956004)(38100700002)(2906002)(8676002)(66556008)(2616005)(31686004)(26005)(4326008)(66946007)(44832011)(186003)(508600001)(8936002)(36756003)(86362001)(6486002)(5660300002)(316002)(53546011)(31696002)(83380400001)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpvd1pNV0ZuM2NkSGYybkNrd0Y0ZUdtOFBxZkRDSjk2aXg4UnRFN2FCVnM5?=
 =?utf-8?B?bkQ0YWRKUmZlbEtXd3J0T3JvY2xwWHpzcHJVT3FqRHEyaDVDZUxDVjRpaGdp?=
 =?utf-8?B?cXAray9KQ2gvTUlxWVNpUUhhTjdxOFBNMUdRR2Y0TFBHNE5oczlZMlB1TDcy?=
 =?utf-8?B?Q0ZtKzBkcFJjajBBMlRxYkREdzM1S09MdG9ucTB2eHJ4Nm9RQ3BoTDdCWkpu?=
 =?utf-8?B?VHVjVm1TaFYvQWtjbnA3R0tRSDNsTHhQYXhaTXdsZXhjdEJmaHYyTTlKaC9P?=
 =?utf-8?B?bitEbm5YTGFIWXp4VE1VdmxNR1hPV3pGaXdoREpsQTdwSk1vSG1KZFVNZko2?=
 =?utf-8?B?eEM3bU1lYzhnUWNmT1RKQzVRVHFFN3dZY1N1WWlBamJTMmNTR2ZNZzNVOVdx?=
 =?utf-8?B?enVkL3RoTWdKWkFMYm1mazZ0b2hTRExNUG9VcjFVQlpCSUplTnJaTUttUzJt?=
 =?utf-8?B?eXlrcFdMR2tEVnRTZHRMUnNkdjFYcncvNjJtSm0wNEs1dU9rSXM0ZHA2TGlM?=
 =?utf-8?B?MC9TcVplZ2luQ2N2a3UwQk5oSzQ4YmJXQWg5cHQxVTZRNENrQi91Vnl2S2RL?=
 =?utf-8?B?WEtJbUdkSzR2bVZwY1VXUUNaU2RLK0JjZlljVjNpc3JpSXhOQ3R1RWlRZGFj?=
 =?utf-8?B?SVptanZJZitGQXFXMnB1MDJtTXRRYVZRU0hEUm5YY3VjNGJBUkMzWG5EOE9v?=
 =?utf-8?B?YjRHZHFoazJIZlhlRmRrRCtXelg2Y2JwaGlUcG11cXQzM1hsVDFZTFc3ejBK?=
 =?utf-8?B?YTgvWGMrOHF1U3U2dlFqRHcxWFZxci9mNlBPRmNqTUQwUHd0SldrU2s0SGEz?=
 =?utf-8?B?dGpQZ1lnelYzN21Rbk96NnR0aW9EL0huZ3ZWOHFSY2Rsci9XeExtZFcwMW9w?=
 =?utf-8?B?L29ZVkRiVzkxRFd1ZU5RaittRDZXbHlBUlZSbU9yUXh2U0lkVjhUc2w2Z1NN?=
 =?utf-8?B?RUxiWTcvTGdRblA5QXlucXN5MjZPT2h2WkJISVA3REt0OFd2UmJkazJFblBn?=
 =?utf-8?B?QVJRRDlsNFF0T25zRDdkTDBHQStYM0p0enc4K0NBbWx1MEQ2cGlDeHVkTmpV?=
 =?utf-8?B?SXB1Y1JVRSt4dXB5b0czUi8rUzlIdi8vc1pUaU5OcmlyekN2aTVtVXlpVXpO?=
 =?utf-8?B?UWp2WGl4cHVabmNoYnJpbkRQZlNvbnlaYWh5cTl3UW1UYWtLS3g4YnpONm1O?=
 =?utf-8?B?WGgzNEwvN0trTUVzbXhtc3ZYdStzVUh6TnJMREdtTlFpSUh5YjFyUDc3WCtx?=
 =?utf-8?B?c2pCL1p3QVFHdXRIMytOTUQ0LzFJZXVJWFRWOE1lQU95TzVTdjB2R2RxOWVn?=
 =?utf-8?B?STlSWW5sQTMyZDZQTjd4c21lbXQ3TDdEMVVtS0dsL1JvQXZtYTBVYTV4V25o?=
 =?utf-8?B?SGdkT2sxSk5JOThBOENvYm9iQWx5d2NoanFyemc4d1BFQmRpWEdWTGxKSVQ0?=
 =?utf-8?B?UTZ6UFgwaUkwbS9wcGRVTWM5OVJLTE5pYkZKdGJMUk1tRCtPU2Nzb1RLT29q?=
 =?utf-8?B?a2sxRmxVcXpIM2d6VnRvZzFkdjNhU0FOR3drSDVSTU1yQzBBOVorK242ckFC?=
 =?utf-8?B?LzlJM0QzQWh1VHc2Z21OZG5QdnU1dENtYlNDOFZFblMvSkd0dUhNNkMxVUFx?=
 =?utf-8?B?aVR2UHJUem1SemRUZzBldTN4Ry9KWCtHZXhjcGJqTlR2M21lNFN2cU56T2ta?=
 =?utf-8?B?dVY3M2dYYk02bXp6WHlDeEV3Q09iSkxpZnFWdTByVUtGRnFwTE0vTExyVFdT?=
 =?utf-8?Q?fQQpee5TKBbPAmA07LDTZ6fXBPcdnxyCPIiiIXy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4f9624-ca6d-4ed3-c591-08d994b21dc5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:44:57.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3655
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

On 2021-10-21 12:35, Luben Tuikov wrote:
> On 2021-10-21 11:57, Kent Russell wrote:
>> dmesg doesn't warn when the number of bad pages approaches the
>> threshold for page retirement. WARN when the number of bad pages
>> is at 90% or greater for easier checks and planning, instead of waiting
>> until the GPU is full of bad pages.
>>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index f4c05ff4b26c..ce5089216474 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>>  		if (res)
>>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>  				  res);
>> +
>> +		/* Warn if we are at 90% of the threshold or above */
> The kernel uses a couple of styles, this is one of them:
>
> /* Warn ...
>  */
> if (...)
>
> Please use this style as it is used extensively in the amdgpu_ras_eeprom.c file.
>
>> +		if ((10 * control->ras_num_recs) >= (ras->bad_page_cnt_threshold * 9))
> You don't need the extra parenthesis around multiplication--it has higher precedence than relational operators--drop the extra parenthesis.
>
> Regards,
> Luben
>
>> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
>> +					control->ras_num_recs,
>> +					ras->bad_page_cnt_threshold);

One more note: The code uses "dev_err()" for this very similar message:

            dev_err(adev->dev,
                "RAS records:%d exceed threshold:%d, "
                "GPU will not be initialized. Replace this GPU or increase the threshold",
                control->ras_num_recs, ras->bad_page_cnt_threshold);

Since your message is essentially the same, sans the "90% of threshold", perhaps you want to use dev_warn(), instead of "DRM_WARN()".

Regards,
Luben

>>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>  		   amdgpu_bad_page_threshold != 0) {
>>  		res = __verify_ras_table_checksum(control);

