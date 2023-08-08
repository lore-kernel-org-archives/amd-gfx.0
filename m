Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A11C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 10:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB03310E0A8;
	Tue,  8 Aug 2023 10:52:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8E310E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 10:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9HKuSkq3fmc+AOELsVcvKA9ZCbk5iKziMrSHdI1f2eGHJHU+bjY6u8TVr8s3hNkwG6wrq2BbF9uGVdPOOzmkjL0kejIDPss5ptPG60+fsWwDcg2CfVQg+x/VntO+i8wgNwCF40Ki1Bar1Gzb2Df8T8V3zlfvEQ5GZ3L1Yps85pEtlV9xbKjyB+0d2ebAHiTyFJhZ++N7BM/d6MflPsFnrFDMjWBRta+2cY5bLRMfkM0c+zBUIU3EunJ4iwAtyMrOnwQBSigO+bO9LPUXbj/Up9jMRj81PgsUW5E1MUAr0tvgUnRMI0zqU7D8qyoeoVvRzvybzY53mAe0A0DvBQBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjH+hicxNxoip/M+5H1Gc4urWCtSVxWYaVSdoOebSug=;
 b=i5rjKaebkM+Ax54wmxvUbIZIA6n3Goo4mvJlQ3be70ZoPFq/FJpbfTcJGgidUF0ZNcq64lkdEHH/cu/QqRBqQi4te4Sa8KgdFJVof0Ze5Ldl10/U5vfKxXBag44BV4Uc/mWenrLwu5p/cil/3IvijgT+VZp87nSKwgVXtzsWGujPmpn2tSezeIXygr0cFvjVbMSrVW+DpTVU2Fhp26+6LedwENP/ZUQeZaYm6RmOHFJ+QitsE7gO4xKifuLpav9UYMVYbuj+/+V2fN1Eb2m1e9Ozoy1F/LEZGiXJOp9TnvWq/FL3Ktq9stj/9aM7YO8yxVhi24ywQSeNjpJSzOdpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjH+hicxNxoip/M+5H1Gc4urWCtSVxWYaVSdoOebSug=;
 b=zQWOL5V3V6CieAe71HCdyd09MD7FCKA7t5QGugFanLA9ddB56QoFokkUyN81aAC8Lwm+3mnKaVDZseisP+Haka8OjDwa/i48Sb7w8eEL+/UwmsPW1vajoefEKbpmbCyF6zqv/NNn62KbhOUpm+9FP+JL28Xz63/r6ynvC3E+fMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:52:54 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:52:53 +0000
Message-ID: <5c867303-5d03-ebed-533d-d418ea920694@amd.com>
Date: Tue, 8 Aug 2023 16:22:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan
 on smu13
Content-Language: en-US
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230808075150.227155-1-kenneth.feng@amd.com>
 <16b7e768-dbb6-9e6b-e6a4-80c683a11461@amd.com>
 <DM4PR12MB516542C45FA8B45093D22C468E0DA@DM4PR12MB5165.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB516542C45FA8B45093D22C468E0DA@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 9836e684-443e-4b90-7559-08db97fd9dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rEcx2XlOM0DGdO6ak6a+0SoQDY8A6LYdAtXXH4v8l1QCC+Mk7CTGdKrn7E60UotiPBhHAITflQ+1qFI29viA3A1uaN7i3mxbG1G+FoJwYG0RlhahzJp4ujOf/XIYKsjxKMKJhjh7blJUeSCDjVPr6I4EOoHOYasGN+X7yOHFD0iFklzgXh/LOx5x2XFYj74m/PSgLv8SSXT7DHdrqFIKrxaNsCWFUTNWuLIfHdUUFJA1aRo3t7xAO8qi1cXx5kVJTWc3q21FW46p3rmUbmxswbfMJBM/k6rCax2ZfbmaEtIn4mjxqmjPrNUcSgekriQ2x4ptFvB4HM25+uoGR8scNew6BDNhgYrKHkcfdENAok+QA8Rs3KRNQvTMgTYVRYvyZ+7XumliklRJZQHFV6N5VD/ZzMk1I1n2cMMu78bVjhZyYNn/+ycNx0ynkZvdwomDawzO7VmmTnKMu/nQfJ1ecY7g9WFAo/8D8c3LCvK4KlDo6t6vvNwR0ymMZvFhFgSVQPwoIbIS51V/ql1bo3Ejhfg5g3qR+LZZwpUCy7NGTjyQorxKv7IJTKm9bfNWz33ZpSdi/iKsR2mqUBRvC6h2JXBEmBBUm2WOtgf0VfADOKVAk6658V5+lAEKpBRVjtxKDUif3/ZcSdfR64R4Xaaug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(186006)(1800799003)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6512007)(6666004)(966005)(6486002)(2616005)(26005)(6506007)(53546011)(36756003)(66556008)(66946007)(66476007)(478600001)(31686004)(110136005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STE0SUhFRVg2L2p3TG16TVVHN0ZTM1cvQVNsdkttYU5GYldNMWdMWFF4V05h?=
 =?utf-8?B?WUhIZDZieUNmTlA2YW4vai9BRDNJeG5KZlhXdnpmT25LQjVUS0xlWnpXcTJn?=
 =?utf-8?B?WGVIVEJqYk1NOGx5b3RsR1JnbXduVmpWd2JYdnQ2eGg1UzZXY2tZbGUyWWIz?=
 =?utf-8?B?TlhObjJMSG5MOURWRldmNVA2ZEprRjNRdzYwU0U0b3VOZmx1K0toUnM5bzZU?=
 =?utf-8?B?dFNtTy9xUENrUmYrd0k5UWpKS29QaHRHN2RkT1Y1cVFYOFp6UWxDVUx6VVJW?=
 =?utf-8?B?bUZZSHpKL2dqMmh6TExaMjFmallwRVMwNWI0K0V5K1I3QzVpWDJmM3ZnTGJV?=
 =?utf-8?B?SG81NGJUSzIvekVKWGJOSVpBTkQ5UFhzL1FtU1VCUXhZUnBmcmhUVU5BV3dk?=
 =?utf-8?B?MjBWR0dHbnI1RlFBYXZoRE1iVWxUSkpyOHFlVHdtUkVXREMyRUxma2ZDdEgw?=
 =?utf-8?B?M2dCRnZ3cVlNZXVLWlU1clFhM0h1WjFMUUUyeGs4ZUlCc3h3ZlNTSzRnK00v?=
 =?utf-8?B?UVFZOVppSEpja3VaVitMU3BYbVpZSGxuVkttVE9DVnhNbDc4UDZ0SWF0aHRX?=
 =?utf-8?B?d0tyVDRFUDhoTjh0Z1VBVnFXNGxkeTdkaXZlQWw0OUQ3dFE1ZzFuWmdybi9I?=
 =?utf-8?B?dGRrckRycm1LenhZdUFLUnM1V3F5WS9zNVhScG9pRnhBQkFqNzdyVEVvcGtp?=
 =?utf-8?B?U2QvQ1I4TlA2RWpmWlpVQkJOKzY4NHdyR2NSQ0NnUkZiRk1GNWdqK2ZlMHpx?=
 =?utf-8?B?Wm5za2tCUFJTcEpKc3oraDRvWUV0Mis4RnpxV2t6bWFFcVJqdTNNRjYwT3pN?=
 =?utf-8?B?dHBMNkNSUy9LZmtJVGhXRDJsYVZ4Nmd2U2hTb0lQVWpjQldieDltbGVtcy9x?=
 =?utf-8?B?WnRoMjQyMmZ3dnl6VDNnRkVjbnk4aFBFYm53NGtBNVNZcloxZXJpQ2x3SGJs?=
 =?utf-8?B?ZElpOWVuM0taSXJkeUhCd01lRmNubmcydWczUjdlOXd3SUlDMkMyU1FJRmNz?=
 =?utf-8?B?RENYRWN3QVRsaHI3Z0pZY3psSVRPYWx4cHVoVjc2UEFWSVZWZ1JQZDN4RWpZ?=
 =?utf-8?B?R3lwNVpyWHFyQ1QrZ0d5Tk1VY0ZsejhwWjZZUnNPNGtTTVVzNjNORU1hMm0z?=
 =?utf-8?B?RzJnMGJVU1dHS2sxZnFkdmNzOTRJekFYcTBlTTVMTC83d3hKRlhYb0JCdFd5?=
 =?utf-8?B?YURNWDl1ZXN5VWN5WGRjK3VtQzFCSmJMOFREYXN5ejg2cUdmRnRsQTZvU29i?=
 =?utf-8?B?bnNlVGtONzRyTElybzFtZ3Z6UjNYS1BtYzhEK1JCRDQ1bHUydlpDZGZPVXNm?=
 =?utf-8?B?ODQyY1RNcVVaRmNtY2xsTTJRMEUwQ0xMUVo5R2dlckxCRGc1VGE1M1dseXgz?=
 =?utf-8?B?UG9oSzNGeTFsT3BMZXVBSDFwa3RETlVKYXdjVEoyUVdMa0NmQlVoTDhsdVYy?=
 =?utf-8?B?dFYyd1N4MnJNajRtdnZnUTJhKzNVcjdKTk1VaHVZWUxERzMxRDZqbGQzdlI3?=
 =?utf-8?B?OStEUERYeEZ3RVo4dFRsbGNQZm1CQkRnZG9tSnBvQkFCejNzT3FkTFB6d0tB?=
 =?utf-8?B?NnJiQ1V0NTgwOGptNHk0OVZRamN5b2Vyam9FaCt3MEZyNFZmWlBkWGM1RUFp?=
 =?utf-8?B?KzZmcDhiTTlCbVprZkZ5UytzQVdSaFJianpUZkNEV0I3OGVlcEEvSW5tVnVh?=
 =?utf-8?B?dUJ3RVJUUVIwcnFZVUxwUkZIWlVWM0M2ZFZoTVJIenZDdHRzRG4yZ0NFRVlo?=
 =?utf-8?B?N3hpeGJQWjNteVI4bkEvTmJRODB4TGU0b3FEM1h0d1AzNzBFaHFnZ21HNDJ1?=
 =?utf-8?B?aEpoZmtCNzZpMGx1eFpFeTgzOFdVczJDV3BSNWkreFQ3b0kvdW4vTGRhUEhJ?=
 =?utf-8?B?OGF3bXVENWdRb3h4ZzJzMGJtbmxVbCtRelRqQWtaRHF1RzIzSTVYeFhtRVpC?=
 =?utf-8?B?dGhXOC83QWtDQnZxdC9XaTJRS2FOYW8wMWpJN3ZTTDlJZEozY0poSDJ3NzRZ?=
 =?utf-8?B?UnJHRmc0MXFkdHBzaVZzMGdMU05OeHJYVVM3cmtMSGE5NWdBRmx1bWZSbHRj?=
 =?utf-8?B?TjdxYnJ1eExJOEppZTdHaEhUeElkTnhvWWtYVWhUemkwdDBoK1hmRE1vVFEv?=
 =?utf-8?Q?CI55Tno1/YPeYM+XUNJc+uaEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9836e684-443e-4b90-7559-08db97fd9dd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:52:53.7842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uukk7Oka9fPdcFFqZqyvQ2EAOrClQDuIqY7m5k6pR6CqunQSzdQxTx8HK+PNIxCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426
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
Cc: "Arif, Maisam" <Maisam.Arif@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/8/2023 3:56 PM, Feng, Kenneth wrote:
> [AMD Official Use Only - General]
> 
> Currently no_fan is determined in sw init.
>      if (!smu->ppt_funcs->get_fan_control_mode)
>          smu->adev->pm.no_fan = true;
> 
> This is the case that some boards have fans and some don't have.
> smu->ppt_funcs->get_fan_control_mode still need to be defined.
> !smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT) is enough to get the fan capability.
> Not sure if it's better to depend on pm.no_fan.

What I meant is, based on fan control feature bit you could set 
pm.no_fan flag.

When pm.no_fan is set, we won't create hwmon fan attributes for 
get/set[1]. That way you could avoid the other checks also. Also when 
PMFW is not controlling, it's not guaranteed that the fan controller is 
initialized correctly for get to return correct speed/pwm.

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/amdgpu_pm.c#L3338

Thanks,
Lijo

> Thanks.
> 
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, August 8, 2023 6:12 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Arif, Maisam <Maisam.Arif@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan on smu13
> 
> 
> 
> On 8/8/2023 1:21 PM, Kenneth Feng wrote:
>> disallow the fan setting if there is no fan on smu13
>>
>> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index 9b62b45ebb7f..09ef0a7e7679 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -1131,7 +1131,9 @@ smu_v13_0_display_clock_voltage_request(struct smu_context *smu,
>>
>>    uint32_t smu_v13_0_get_fan_control_mode(struct smu_context *smu)
>>    {
>> -     if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>> +     if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>> +             return AMD_FAN_CTRL_NONE;
> 
> If there is no PMFW fan control, isn't it better to set pm.no_fan?
> 
> Thanks,
> Lijo
> 
>> +     else if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>>                return AMD_FAN_CTRL_MANUAL;
>>        else
>>                return AMD_FAN_CTRL_AUTO;
>> @@ -1143,7 +1145,7 @@ smu_v13_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
>>        int ret = 0;
>>
>>        if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>> -             return 0;
>> +             return -EINVAL;
>>
>>        ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
>>        if (ret)
>> @@ -1204,7 +1206,8 @@ smu_v13_0_set_fan_control_mode(struct smu_context *smu,
>>
>>        switch (mode) {
>>        case AMD_FAN_CTRL_NONE:
>> -             ret = smu_v13_0_set_fan_speed_pwm(smu, 255);
>> +             if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>> +                     ret = -EINVAL;
>>                break;
>>        case AMD_FAN_CTRL_MANUAL:
>>                ret = smu_v13_0_auto_fan_control(smu, 0);
