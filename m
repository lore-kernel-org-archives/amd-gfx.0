Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DAC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95BA60F00
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B95BA60F00
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1C76E364;
	Thu, 12 Aug 2021 09:11:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB2F6E364
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw+NaufBoqH93lHK07Qj2SkbbH2HTF31vj2MfJ6zr4qpot33CBiYbj33PL/lq3Ka/HPSpTmHz0cDOlgVF7nxp+mhlE5CBnpcnaKerG5R651+iuNkSEPR9prCuvxJPL/HUbpm1XCFc3R1HFtVUt0shpsmhgV6BON26nd1WEeahWJYp426gkiOS5aKIVX08E/7FCuaGkRSJm2xIV8xrjcdzhX4mrY8f9SIflMcEJaRm3n8iS6nMMP8bIWbwSZFh+oMcd6PDaVSkfGunjg1sLQ/RwXoP3IhMafKvHHlmiKqQA1+euBSwSosSFM5lJwjQCkDU486Tdf8IR0fV7QQS2xZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWI7knZQXaLNnNo9nrtICT7XkUMvkxGUMArr3AuH6d8=;
 b=dRoG2t/eBePOwC3YEDfrGVOnmo7fP58MZXOk1nu3pNFqgWMe/lZYPkxXiwmQolrOJK2Xqe+Uv9XPjeE6Ox/N/bKjoM7qduFVU2h5KdpeXgQK1uCfmX8ew31dyUsHUHghr0cGcVf6NefS0n9S/71dy6UJwx9nK66supck52rH7K1jx5gKWYswG/0oS4aOPDrMxuwhvPy3jnruJ4VrzAzyhBjzeW0B91CrIUB1p54SmMcIccBbP+BaMrThQHZl5mVAQQTmuf0LRnc9lssXOTvM0cagBBhfU7cCMxqqR/I2E4P8RQQ4YdnpNo9rzR6vjtXLyOxzfPpAD4MF2BtUd7L8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWI7knZQXaLNnNo9nrtICT7XkUMvkxGUMArr3AuH6d8=;
 b=b+cKyndgvhsEhyZULVnuytUGkoKeykZa3u5/JFPpGLGJtNppfA83KgLASQSgxrLyb5jJWhyy481u+oD3tYtTkmhAamCUzTrjXJT6hNrLN1dnRhD3iIYdEXz5Pgiy8288hPZ8FFajmVn1AM/U3iZ697/pXvHAStp084sgSYNKdHs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 09:11:35 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 09:11:35 +0000
Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-2-evan.quan@amd.com>
 <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
 <DM6PR12MB26190C2DBBCBDE6AF4835F7FE4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <3285485e-2beb-4147-fa68-e0fc6636e158@amd.com>
 <DM6PR12MB2619A7E4EDC9872AEB8D50D7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <aeae3a70-7855-cbd3-8e05-5a07607bc5d8@amd.com>
Date: Thu, 12 Aug 2021 14:41:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB2619A7E4EDC9872AEB8D50D7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::13) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 09:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247cbbaa-c608-4257-5aeb-08d95d712ee9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB529006B666FE8564ECD19F3797F99@BN9PR12MB5290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI7pUtA0w1SYC3ao/EPdEUO2kX/K5z9TS6/569IQXMB1WvRpiV3s5yFKapn9ezv7YtmXkRsiUu3wHK5jIKYMDmKXjrfJwBSoE2KXEcDaueDKeBkuF3EYMWDYt628mO/DDeXAYb8NoQfoQ4UpKfHLmfwnkL7ezZv4JD2B8gYJ344zbZ9KOInmP01X0oRSpPAYR3fJNpLYzI5fbIPAup1mumIPPUiJ/pqrdLbsxdHyqA3rNfh0Pj1Pf53QR6YaWzWPcv8XqxPE78ucPJzakdxLk8D3KlD/Rqs5Bhqpon1Tzwx9SpY0Gh59wcSPHLj6NwE+MdpGgGuKpTPWriGtCEpUgFPYaX1/JglIC0YFpn6mY+qybFxIZ8Yr6fXzeRUs2EDDSCD9mUWtm4hIDgnD+XcNHjbnvRpSVsPqPNMTyVaMxlFRNikltnyTL+ugVVtQHNU0O+U2rIx0RfBrjyXxp2wSpwU/xhGeCBoaVI/V7ETieWJRSIlXau8lzU2bch4m5d6fK9Td1y/ogwz7/gURr7rsKHEvuiNoByV75LjAkS/dhx8OFPLY1WGhW/vql/iMQzjE6E/43E4m/gXQ+jcWPMJUYXxDI1Qx8vQHC9gmXfWbp62OKB1sFUz5aF7Kh9J0gPnAObHwfiRXpwtIJJCXV1bKm39lF+I/lEBUqjX7aMBSsNFm1jOegbJ2yih5GBaXXhfD4i9LIWXgkNceoSc7CpcIDGA15ellgNaFyDSX1TsWlDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(16576012)(8936002)(478600001)(316002)(38100700002)(2616005)(54906003)(2906002)(956004)(53546011)(5660300002)(110136005)(26005)(6666004)(8676002)(186003)(31686004)(83380400001)(36756003)(66556008)(66476007)(31696002)(66946007)(86362001)(6486002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRHb0liZGNiMEFzY0thNFZMWGUrTFkvMHVqWTNJUmR4L2JSYmlzcTd1aE1L?=
 =?utf-8?B?M3BzQUJDWml6dzBjQXlkMjhTL0dkb294UFEwWWE5RlUxci9ibnlZalhkSWFa?=
 =?utf-8?B?L3dHQlJhWFBuYlJEUkd2T284MHk0Uk5NODNWVXM1eURiaWFNR1FZaVFEa1Z5?=
 =?utf-8?B?eWlLcUhZVWxiYlc5VGVoYjZDR3NEaEZIZnNYdEZDK2ZZbHJpOG9hMERSRTZv?=
 =?utf-8?B?S2JZNGtWY1ptNXoydWUrM2RBR0tIdU10aEFvcUxrczVDdUNhSlJsbEJXWUVB?=
 =?utf-8?B?SUxDTFJLUmU2MnJHdXgrZnZkbGplUGxiQVJnOUZ0c2FKL25YWVdnZzlBcXJQ?=
 =?utf-8?B?akVBZVdOdi9EdXBmSmc3Zk43STltVm5UWjc0a21vUnF3UndYbUZ6Z1N2M2gv?=
 =?utf-8?B?VU96MlVlN24yY0QyOGE5NHNvWDllMm5CaEozK1VJdlRSS1VKelBZYzJNY1U3?=
 =?utf-8?B?MjlPOEJHN2pGZ0ZyakFReUp1V21kWGU1YjRqenRuZ0ZCaFRTbFVhVXlEci9q?=
 =?utf-8?B?dE1hcEVOUGI1Y1R4bkZrUkNPQU1sUmMxS2dFQkpUWjRxWjIzbHVrMGtNL1Zs?=
 =?utf-8?B?TUwvTXQ3aTd0cmdIM24rS1VqRHlwdkdybEVqUE1hc1ViK1NzRGlod293S1JW?=
 =?utf-8?B?aDdhSXN5S1VUdlBYWGlZcFNueTI4ZEI0c3BvNEJiWno5cFQ3YUhWN1FNc0hq?=
 =?utf-8?B?UmhxSWdoVEd1NTVCeWJZMWtLYk92NDdZbWhEai9RSlhBUklOVGJ3Vi8rZGdh?=
 =?utf-8?B?c0lUaHoxeTA3QjFMRkJ4aDFlbk8zblovRFF6TERwS00vcmFua1k3L2lyVFFG?=
 =?utf-8?B?eWd2Y3M4dkJHYTVuK3JPbExKaWF6TXBCb1NXRHdOZmlTZWVIaGNGTDdRVVI1?=
 =?utf-8?B?bWFNd1g0YXlDNXpFbkVEejlGQnFwdzRDMWorTzlobTFvaysyM3pSZmdxSEJk?=
 =?utf-8?B?MTA1b2JnYm1wT2pTdm9OTVQvVnJDQk5FNmZXZW8xcTRIbFdZd1BSRDU5TDB0?=
 =?utf-8?B?Nzd1ekNWM3BYbFFLSGxaSWNzWWNOelRRQnIvTFJLQjJUb1VtSVdTWkxtb1R3?=
 =?utf-8?B?Rmg3UEdaS0Z2VldJQzgzbjlQcm44UDA5cHg1OUE5dXhyNlhzZURLaGNwWTBF?=
 =?utf-8?B?TVdaOUp3K0JqKzdseWNkM2VGZ0k3amR3cnpxSDBvR3RubElueHZ5MG10UENR?=
 =?utf-8?B?c1dpWkNaaUc0ME5JeEwrcmpKUkYzdk9OVzBaRGVTVjREL0JDSndQaCthMGZ4?=
 =?utf-8?B?T0x4VDFuY2pSVUVUTldqUUNoZlNtanlvUHFMaHRveFh6VmhoakFQalhOWFBX?=
 =?utf-8?B?b0RjQmh0L3hkL3VJbTFFTGl5U0dNMkdocUw3NFBvK0FGVTMzZUpUYm5HNnJO?=
 =?utf-8?B?eEpoR1gxY1h4dGs5NXV1UGxkMkNsM2VTVHkxTHcyQ1crTDlEcERHYTdEUlhL?=
 =?utf-8?B?dVVobjNmazhpa3FxUkRCK0NWUDU3bW1PSjJwcW0vTUttcnlScmVaSERvRjZo?=
 =?utf-8?B?TFFxNVdQT2lIcDJXSFVTTXBkbExIbTR4RUpGNENEamg1aThDUG9haU9kcXky?=
 =?utf-8?B?OTQ5ZGIwOHQ2K1pZUVdPMnpBWUZwUXhveDUySm9zTFNFTVBLbWVNeFF0Nndp?=
 =?utf-8?B?dUV5cnhRQVJGYUdEdkpLUDc3SXBDRGxrTm4wSUIzNGxIb0g0L0FZTWhRUmRo?=
 =?utf-8?B?RGZMZ0xnaWEvdjZtRkZEN1RER0wwcEVUS2U1VnBXRlM3TVNKYzdkOWw1MlJV?=
 =?utf-8?Q?v0VDnVl33MN/Jp8B8qhrF+Ey08JwAjxmXvGDpWL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247cbbaa-c608-4257-5aeb-08d95d712ee9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:11:35.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkGQVzIa2ZEaVLE4BNWrBF9vTMz/Pfr0s/ZSRURZ3kqvlLu5LT23XxyDsxyqeqbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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



On 8/12/2021 2:19 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 12, 2021 3:53 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based
>> fan speed settings
>>
>>
>>
>> On 8/12/2021 12:21 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, August 12, 2021 2:05 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>>>> Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM
>> based
>>>> fan speed settings
>>>>
>>>>
>>>>
>>>> On 8/12/2021 9:31 AM, Evan Quan wrote:
>>>>> As the relationship "PWM = RPM / smu->fan_max_rpm" between fan
>>>> speed
>>>>> PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
>>>>> settings need to be saved.
>>>>>
>>>>> Change-Id: I318c134d442273d518b805339cdf383e151b935d
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> --
>>>>> v1->v2:
>>>>>      - coding style and logging prints optimization (Guchun)
>>>>>      - reuse existing flags (Lijo)
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22
>>>> ++++++++++++++++------
>>>>>     2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> index 183654f8b564..29934a5af44e 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> @@ -34,6 +34,8 @@
>>>>>     #define SMU_FW_NAME_LEN			0x24
>>>>>
>>>>>     #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
>>>>> +#define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
>>>>> +#define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
>>>>>
>>>>>     // Power Throttlers
>>>>>     #define SMU_THROTTLER_PPT0_BIT			0
>>>>> @@ -230,6 +232,7 @@ struct smu_user_dpm_profile {
>>>>>     	uint32_t fan_mode;
>>>>>     	uint32_t power_limit;
>>>>>     	uint32_t fan_speed_percent;
>>>>> +	uint32_t fan_speed_rpm;
>>>>>     	uint32_t flags;
>>>>>     	uint32_t user_od;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index e33e67310030..131ad0dfefbe 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -413,7 +413,13 @@ static void
>> smu_restore_dpm_user_profile(struct
>>>> smu_context *smu)
>>>>>     		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
>>>>>     			ret = smu_set_fan_speed_percent(smu, smu-
>>>>> user_dpm_profile.fan_speed_percent);
>>>>>     			if (ret)
>>>>> -				dev_err(smu->adev->dev, "Failed to set
>>>> manual fan speed\n");
>>>>> +				dev_err(smu->adev->dev, "Failed to set
>>>> manual fan speed in percent\n");
>>>>> +		}
>>>>> +
>>>>> +		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
>>>>> +			ret = smu_set_fan_speed_rpm(smu, smu-
>>>>> user_dpm_profile.fan_speed_rpm);
>>>>> +			if (ret)
>>>>> +				dev_err(smu->adev->dev, "Failed to set
>>>> manual fan speed in
>>>>> +rpm\n");
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> @@ -2179,7 +2185,6 @@ static int smu_set_gfx_cgpg(struct
>> smu_context
>>>> *smu, bool enabled)
>>>>>     static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>>>>>     {
>>>>>     	struct smu_context *smu = handle;
>>>>> -	u32 percent;
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) @@ -
>>>> 2190,8
>>>>> +2195,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t
>>>> speed)
>>>>>     	if (smu->ppt_funcs->set_fan_speed_rpm) {
>>>>>     		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>>>>     		if (!ret && smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE) {
>>>>> -			percent = speed * 100 / smu->fan_max_rpm;
>>>>> -			smu->user_dpm_profile.fan_speed_percent =
>>>> percent;
>>>>> +			smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_RPM;
>>>>> +			smu->user_dpm_profile.fan_speed_rpm = speed;
>>>>
>>>> Sorry, missed this when you posted v1. Either RPM or PWM mode is
>>>> allowed at a time, is that right? If so, shall we make the pwm to 0
>>>> and reset PWM flag when RPM is set and vice versa? This helps during
>>>> restore where one is not overwritten with the other.
>>> [Quan, Evan] Sounds reasonable to me. But I suppose we also need to
>> prompt some warnings when user trying to set these two modes at the same
>> time.
>>> Instead of performing these silently. Right?
>>
>> Not sure on the warnings part. For ex: user may set the manual mode,
>> choose a pwm based fan speed and may later switch to a precise rpm based
>> speed. Since it's driven by user, we may not need to warn.
> [Quan, Evan] Hmm. How about the followings? A notice in the description part for related APIs?
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 04c7d82f8b89..112ee5f5d855 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3174,6 +3174,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>    *
>    * - fan[1-\*]_enable: Enable or disable the sensors.1: Enable 0: Disable
>    *
> + * NOTE: DO NOT set the fan speed via "pwm1" and "fan[1-\*]_target" interfaces at the same time.
> + *       That will get the former one overridden.
> + *
>    * hwmon interfaces for GPU clocks:
>    *
>    * - freq1_input: the gfx/compute clock in hertz

Looks fine.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> @@ -2552,8 +2557,11 @@ static int smu_set_fan_control_mode(struct
>>>>> smu_context *smu, int value)
>>>>>
>>>>>     	/* reset user dpm fan speed */
>>>>>     	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
>>>>> -			!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE))
>>>>> +			!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>>     		smu->user_dpm_profile.fan_speed_percent = 0;
>>>>> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>> +		smu->user_dpm_profile.flags &=
>>>> ~(SMU_CUSTOM_FAN_SPEED_RPM |
>> SMU_CUSTOM_FAN_SPEED_PWM);
>>>>> +	}
>>>>>
>>>>>     	return ret;
>>>>>     }
>>>>> @@ -2604,8 +2612,10 @@ static int smu_set_fan_speed_percent(void
>>>> *handle, u32 speed)
>>>>>     		if (speed > 100)
>>>>>     			speed = 100;
>>>>>     		ret = smu->ppt_funcs->set_fan_speed_percent(smu,
>>>> speed);
>>>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE))
>>>>> +		if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> +			smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_PWM;
>>>>>     			smu->user_dpm_profile.fan_speed_percent =
>>>> speed;
>>>>> +		}
>>>>>     	}
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>>
