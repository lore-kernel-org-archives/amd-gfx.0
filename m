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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7EC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 07:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4530A61019
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 07:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4530A61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1E66E027;
	Thu, 12 Aug 2021 07:38:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3F66E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 07:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUHoPk2R0jf+bSwx2w8kNiKWV4E0t3aJeImRkWvazIqN8PJyZU8dlgVXib98SsoMWwi7E8ceZlsl9qUeLp04fFOkTQ9WZXtdeTINtMowcp1EQ8GBkChgjRO/BWPv18KBApR9Z2GUr44lHjVNfNb5jn/f4mOZyi1Vw7pJ+2jjiOP5bCJs9Yjrn/C5dupek6zZMeXZekD1CVN67Jwfem39bp0XrGXtcgHHVGUVpELSx0ta+P1VT+zos+kp+H///PBGsYEjMKgeQUp3ruPguOP90rlFO9GXa6CVjOJHHqY0xq8iuRBNgPcX2VwMWOkHzPbO0DL9ERnZxFkr/kloQiIaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frk2HyKBmp1NczBbjbk8ofa1SNXxaQBMd6mM3WjZhA0=;
 b=GPW8sdWHNg4pPB1qESbjg8UnFr5cU/m6ElEFtoNopkwa1v3EukRGn0x1AVpPak4j39gnPZzaTWkAJUsoYmAWlSW49tRTgVeHnxTwAQfxDNYAe+Zgb9M3EY1/6mV7s1YEKsxhAGPc2Ln/0fQlZIRs52FF2tEslqw3pjg9vQUvIHAa3Y3+aiSTytYDNXeJ/k8Dzk4zDp6/ah6h7ER/hWfmEy1M97e6f/z6kv2ebfsuOxrAuXN0TRZy92F9IhM8yHi5iNcDmABF4x2OoWL623bXBv+YfV3p3r6xmg6O0ueebYGU9J8aAypssYdaf9vTiq0szOhFXoeITlmgwAtTXg51JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frk2HyKBmp1NczBbjbk8ofa1SNXxaQBMd6mM3WjZhA0=;
 b=4aBkACUDWun+M39MNpqciUb86s2VVqD/I1teY9tOf8SomjrUNMD8ThrNJQIOF+8NGIHK9Ny4lDDspXoMUP3ZL6p++mTn9eZxV8C7eMPFG+Yo7AEFcE1U7XNi4lKNmGzF2nuQt1BJFfSyzKU0m228DaB3x5R5RkHunIkj5ve/4v0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 12 Aug
 2021 07:38:38 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 07:38:38 +0000
Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-6-evan.quan@amd.com>
 <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
 <DM6PR12MB2619197EFEF711E675799ED7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <1e7ac50e-0ba7-2a1f-8085-122de2fa99bd@amd.com>
Date: Thu, 12 Aug 2021 13:08:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM6PR12MB2619197EFEF711E675799ED7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::17) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 07:38:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b95989-3515-4ee5-5e79-08d95d643326
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196E1D2C38ED889D0B1A6CF97F99@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zn+F54CHuozuH8HJhvUs2NKNg675IbrXAxU4wE/SVyt+dGi9OkHXkHCVkDXuDxii8q02H4vRad4Ix87MN2sJYKt6xel0PJUR2G0WHtcRlZcqvvFl0beAYH+dj7mYrV1v7wAsLCg6mzJmwNRehAswqgH1BKBUTEkeg01lV3jZDno4jR2Yki+PjoDPc5n3DYEpAhsVjOPQbeLNlhTBu0xFjj7IXl6EVMIdh9cVwnn6GOJEMbqUJbQWkU23T25LVjILJhRlBFpgr55d8iNFCDO3/kJ+W64KDoXyXBJ2CYXAjHm1jHY77JjoIdkQQC/mE6r/WPxtRQtwpa30t4i0yZn0BlJ1J2gVvgW5abkZaWZoLtikOOvtxsyrBEd9kvfryiSq44QOnEb5h8qxWcmG9pABS2VqfFtnh15PvjSHsuBliN1X3Mw008hS6CrS74yH/97RxvFC74QvaUlXkJvh4E3uMLM5FTOdYRMORjo9MCdm9jwkCLseJYuK3sGEUDAhcho+4MA0QL5g9pupHyMkoI0cmUiZEfXBpAtSgHbXuBQkIHHGAT6jQcoK1suHYy67aMXOsvbhvzF2umWCEB8gGrqzoGTRRdJ6WVBpJxfva9pZZsMRTagxB514MU+sh8/FV2VD+XE4JlkFijWefdpLfX7dcjzrhHZdmt+IY9/k95UOvEv5Ua7qbYzjZYGdzSLNsKQl9XRfin62g8eFULZz/ICx0kSx56BCNpTILaN6Eh7duEyZFu7eHPiNXh9tqEu/gtGL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(66476007)(316002)(6486002)(36756003)(31686004)(66946007)(66556008)(16576012)(8936002)(8676002)(83380400001)(4326008)(86362001)(54906003)(478600001)(2616005)(26005)(956004)(31696002)(6666004)(186003)(2906002)(38100700002)(5660300002)(53546011)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlDQ0FkZzZTa01ybVkzT28yeUxOR2gwN2c4cTI0bEZYK251QUFGU2M4enZp?=
 =?utf-8?B?YUp1VEE0M2plSnRQMTlXN2ZlWWtsOWpDR0p2Q2RteDMxR3Uyd0FUK0xGSCtZ?=
 =?utf-8?B?L21xMEtTb0VCRWZVRVJYazMvVmV0T0s3UFBmQ0VocUQrcXp0MzlvSXNyZEkx?=
 =?utf-8?B?YjdXSGNUNmQxSHhyMjlwKytYWTRZMUpQUEFZeGJmajlnU0ViL2pWTW5XdVZN?=
 =?utf-8?B?K2RPTU9DL2pwb2JaM3A1aXZNMWxXUFhwaVRKUzBpVExNRTFBN1daVGl4RlIx?=
 =?utf-8?B?WjltMHRYZmhzRXI5V2lXN2d5elUyZGxZc09JOTZFUHpZM2FpRmJ2ZEVJeFNp?=
 =?utf-8?B?VU1SMFRSRGZxN3ZJSndkYnJ4Uks2SnpQNENPZHhHa2p0bHkrSUVWMkxZMCtG?=
 =?utf-8?B?WGo5L3NKZUxDSmZVOXJkdUdEdnZQYndRdkxLRUYzK3pldlcrYjA5RXBqenhH?=
 =?utf-8?B?Y1JHUk9uMmxRWmJxMWZTbjFuNVlHUzdtRmRkUHlmUXVjbW5CWU5PQ0VIRkpI?=
 =?utf-8?B?b2FIeTVTK1hEa1FrMm9QN0pNV1VHSmhkazdxbmxCVXNmdW5lVVE3VjFQaER3?=
 =?utf-8?B?ZFNWOGdyVElldG9lZS9yOVJ2ZzBQOFJZdkh6U2ZWTjhTUFI2bkVBVTJRNWxz?=
 =?utf-8?B?bnpCZ3lETFpEZXhWQUdlRXI5cGlBeUp1M2ZrdWxReE5sN3pBLzEvUmxUbkVU?=
 =?utf-8?B?OUo0c01iaEgzcmxZQ2s4OUd6eEwzNGlIU0xqeERBdEg1UWY1RFdReC9aL2Nl?=
 =?utf-8?B?VllnSGpId2Ewbjl2dVl3aEFTZVBVM3lJRFdROHB4NHMwa2p1ajQvQkE1S3I5?=
 =?utf-8?B?RFhnN1lGVGJLSnJubDZnMjJUTG95S3hTNit0UXYwaVo0ck80V1NpMTB2OG1B?=
 =?utf-8?B?eGxEVDIraERRbW5laTBrYmIvNnIyVmNYMkdZWjY0WEs5b3BQUHQ3dHJPRHZT?=
 =?utf-8?B?TFlSZm9lUUFTeUJyWktmaFEyU29PZklyYS9aUUhSNHQvV2tBYllwVzJXRFpi?=
 =?utf-8?B?UHVrbFFOSS9aSVpwcUpWL3lMQnZWOGZ6bnkvMjRxZUpYQVZZL0ZGNjROZHpw?=
 =?utf-8?B?aDVaZkhneTR3SXFKdUtpTDVWb2YwN2x0MkZELzN1UmJGU3N1VWNIZE5RSkV1?=
 =?utf-8?B?MmxiOURLZmk1dkVOTVJOeVdNNVR4c1VqSmhVeWtrMkxtNUg2d2RmREk1bElD?=
 =?utf-8?B?Yi9MNkZPKzAvNDY5VzJuZWJYc2pITm5jeFlBTGN5MkVBMTdVUkY1R3FhOCts?=
 =?utf-8?B?T2lpalg2a1ViSHFTVEpOSjBoMHFXaXFEaHlMZHRiZXBsTXJmSXVBdk11aGJv?=
 =?utf-8?B?UVFncFYzajFJakZQL1hFN0IzUlF5aHMxVFM4Ums4aFNyUWVUVitqb205RDdE?=
 =?utf-8?B?YUJjQXllNW1yZEdiQXY3V05CbFgzN2pBR29XMlZYTGlLUmxQWGVjWnVNcWVE?=
 =?utf-8?B?L01JK1Q1Q2Ryby9iaVBhTElod1dhUytnZktXQkZYeDlQVkl5RWJhTjliSTZE?=
 =?utf-8?B?NVgwRlBOTzMwQ0xQN3kwcVZCQ0ZUZHBhMFBLTWFURmVhSzN2ejk5QmoxMDhJ?=
 =?utf-8?B?eUpxQS9Ddzg4WXcyTVc0d2U4ZXRSZWR5d01wbGczYkQ3TzFhVWZuVXk0Vi96?=
 =?utf-8?B?RWZ0OHQyWXNQTVdQUG1wbmlrTzcyRzZGVXpjVE1DSm05VmNXcE5pVDk5QTNY?=
 =?utf-8?B?Z2VHemhPdDlxV0RaN2lsK1p1SFZIdVA3akp1a1QvTm1LeHVPTEs1S2JoZ2dz?=
 =?utf-8?Q?BJDSUex5WoTXxAkBb1+FA3FEK+sHctouzpbXxHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b95989-3515-4ee5-5e79-08d95d643326
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 07:38:38.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlDtPmEBzCBMmTcKyocLxa+rmU9P5CFvWUHYdFhQlO5ukySibjphiNYRMDFQtB2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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



On 8/12/2021 12:16 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 12, 2021 2:16 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode
>> check
>>
>>
>>
>> On 8/12/2021 9:31 AM, Evan Quan wrote:
>>> As the fan control was guarded under manual mode before fan speed
>>> RPM/PWM setting. Thus the extra check is totally redundant.
>>>
>>> Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 +-----------
>>>    1 file changed, 1 insertion(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index 9001952442ba..20ece0963f51 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -1208,9 +1208,6 @@ smu_v11_0_set_fan_speed_pwm(struct
>> smu_context
>>> *smu, uint32_t speed)
>>>
>>>    	speed = MIN(speed, 255);
>>>
>>> -	if (smu_v11_0_auto_fan_control(smu, 0))
>>> -		return -EINVAL;
>>> -
>>
>> There is a FAN_CONTROL_NONE mode where it is set to full speed. Is that
>> affected by this change?
> [Quan, Evan] This check was designed to block "auto" mode(like If it was under auto mode, these manual settings will be not permitted).
> The FAN_CONTROL_NONE mode is not affected with and without this check.
> 

To set FAN_CONTROL_NONE, basically also need to turn off auto mode and 
manually set to 100% speed. If we take out turning off auto mode here, 
probably that part needs to be handled elsewhere.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0,
>> mmCG_FDO_CTRL1),
>>>    				CG_FDO_CTRL1, FMAX_DUTY100);
>>>    	if (!duty100)
>>> @@ -1237,11 +1234,6 @@ int smu_v11_0_set_fan_speed_rpm(struct
>> smu_context *smu,
>>>    	 */
>>>    	uint32_t crystal_clock_freq = 2500;
>>>    	uint32_t tach_period;
>>> -	int ret;
>>> -
>>> -	ret = smu_v11_0_auto_fan_control(smu, 0);
>>> -	if (ret)
>>> -		return ret;
>>>
>>>    	/*
>>>    	 * To prevent from possible overheat, some ASICs may have
>>> requirement @@ -1257,9 +1249,7 @@ int
>> smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>>>    				   CG_TACH_CTRL, TARGET_PERIOD,
>>>    				   tach_period));
>>>
>>> -	ret = smu_v11_0_set_fan_static_mode(smu,
>> FDO_PWM_MODE_STATIC_RPM);
>>> -
>>> -	return ret;
>>> +	return smu_v11_0_set_fan_static_mode(smu,
>> FDO_PWM_MODE_STATIC_RPM);
>>>    }
>>>
>>>    int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
>>>
