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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE1C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C56260C3F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C56260C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC7E6E33F;
	Thu, 12 Aug 2021 09:09:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334686E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGUUv/c/g+yS6iy8i4KJvhDs57jt5L7yMGlvDKOMR6oOMYXvCL4FVC1WBo5e1d96KJOef5xb7Opd8gvLH3seysiuli4KYg8HlyhCxsPQ1YjW+1slqbbA5XsKNgYo+wwhkDhAHCQHqxnHtljz8D7zzb98HxBHK0Yfh07UBLdCNSdP1V8nhSRJqH0zuVzlESUekbjN7tJHhzW8d4MKu6X4irS6L+vxxbdytul4q1SaAg1ASXPC/A+Z9ZbbDXhG3JznQMdopnNqihiEYbAz1D0noA6YFP48LP2Vd/qtO/wIPsUUXX6Dl5s2SaTqXyJKSe2IZ8rjGAWSk4ig/Sbw1UJXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odIrMDs5WaEC+GWBPpoyyEm6sJM6d9p4Grvp8UdMvEU=;
 b=EmU0zfxgalWOR4gtl4/6PU4Xye0dyRcpcfgC6Tdt/PLPCFh3giXvszwKytDnKBDMuyxjXsIVIzg2dpiC9cLk1odbhWiw6In3gm+brjzzshbhSMYUX4XUzd+nNDmR7w/49A8DHXR90dRdlB33Cgmt9HUrtJ3Ag6uWdDp5K8fhDSIu0VRJqtpJf0zaixpkSKZ4rUYasCob3CR6XGu+5NQ8xQVLP4+Et3XfyOAmAVX0wyY8m3UKFPQwF8fddpXH/9XBYoq1uBLzRFxFGslewwUXCuUxwZD29zkih4Gpd8dvxE7acbFVytkvPgOi01bTKqOWZqqh/wGG5sCMX8ZpsGz2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odIrMDs5WaEC+GWBPpoyyEm6sJM6d9p4Grvp8UdMvEU=;
 b=ToQA3AuA8qGTA3hV8PxavQEozmpp+KQXaHaiXMCmUnipXBhaPXvVllMdhn7nidRkSlSKbItEOQdEVd2+qfXf4h15PDKgTo3cyc2f70o1X5D0NxXdPgoeeQ57P09qf6WLfl9yBF/kgVu3NWTK6moHXY8UQQFGldC5ffXakQAMCgA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 09:09:46 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 09:09:46 +0000
Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-6-evan.quan@amd.com>
 <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
 <DM6PR12MB2619197EFEF711E675799ED7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <1e7ac50e-0ba7-2a1f-8085-122de2fa99bd@amd.com>
 <DM6PR12MB261966A80354E978DA926CF1E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <0d72759a-975c-f0ea-49d8-eac32f8035ef@amd.com>
Date: Thu, 12 Aug 2021 14:39:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB261966A80354E978DA926CF1E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 09:09:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9564f5a5-bd84-4267-0709-08d95d70ede0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB517760AC9B417E1D48E14A9497F99@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6ukyJapAYIS6LgdIDizaVYyEsz1yds7S8hUv1nYrA/2vBZh2vqnlvJppc95siWxbJ+/Tqgs34z4SNWPPNmuAUvQMRrR87TSC1jByeyLLnADto5SiYI4CCu9AgX7wwIklFBPWJiQKEd4OdWyAkg7gGxSCCUh5VBzfKQtiIGm/cvMAnm0lN+WgS/OBg2dkGJwwqeLg5SxG1ycAD0fgZVpms05EpnHBpucBlkqrTOpdgxdWOBPY/BpQsDGD46RL4nMfNeBsg/ylcyQLk/PKht6PaW6UjjKzs228s28GsmHJ8eLiQCQngQaUCI/VaN8sWUFq2yFLl9vd/2uiELB/4CMC2byTVZg6zhQ4B4xxpaLcqyziqEIatz3NZ/3eNZ62EbnmfodcTE9IOY8r0nN9OxWytLT4EBwgSIgY67EQwSg9eRajw8JI+hfFykBMqh0OCcwYY5B2AmF++ACwdHiSXdLC4sNtr1k1hMSeAVoDcdVXtYATOb2zULuoOlyfqEH2EOL/bHhj7Vx2u19c3DIT7+LgVZNzPD2ok7jYGJBd6KkP3sIKjGw4JAwFYj4VjC7gD+njHafqERyHApeFl8aSuowkLIlDsGpzNy86kLpxVxebT6QbIz0dDla4xuH/xRw6rImCD9GAobtKNpFa9nc+QwX6UIRiPRGPNSZofZKbXP/hEF0eg2Tx8O/3t3MZLSzdovaqU/x9QTCmI2OaNWpp9G3G/uzYAPueAZQ/FSQDzdSmwRvFvdtsSQUis7LrBQGH5WT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(53546011)(478600001)(26005)(8936002)(8676002)(6486002)(5660300002)(31696002)(110136005)(66946007)(16576012)(86362001)(66556008)(66476007)(54906003)(316002)(2616005)(956004)(186003)(38100700002)(31686004)(6666004)(4326008)(83380400001)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFxa3gwVERvYldGYjBKSXlYWEJ3VUJmclFJYTZrTi9WVGh4Y2ZnMDN2bzd5?=
 =?utf-8?B?NjhwU2FtVWhneDUxOWV6Wk8rSU90VDFQQ0Zwd2JWb2RiblFTdkNGRFFxd3B1?=
 =?utf-8?B?L1dWQ0U4MERsTTZOZVN4dWhpQkoxSUlOejZReWZ5V2FwazgwRUZwVm9OZWFa?=
 =?utf-8?B?VHdKSW9YQ3RCd21mOU1wclpDeUJyTkJqQWtFSFZkZ3JXamNsQTc2bi9kbVhv?=
 =?utf-8?B?clhNc2o5RDJGd2VMOEF1NHFrK3ZhcmRINXdhZHJicXoxZ3c0dE9sdHg3Vm1k?=
 =?utf-8?B?ZDFOY2FWbVZMb3dXMjZSeUI0NCtPc1pYSVk5cXdTWkhWR0RoRmc1ZENSQTk4?=
 =?utf-8?B?cEl5Zisxc2xPOFNJWWpsWFRaM1ZGR0pVaXN2dWVZb0JYTk8vemJzRmFrSlgr?=
 =?utf-8?B?ems5TDlTSUp3SFY2UlhOdVNRaUd1anBYNW9KSjNsYjlCZUZaMWZ5Q2Q0bDlT?=
 =?utf-8?B?THI2azRBeVZlVzdONDBkODlOMk51MHNLR3NRN2lJSG1lclRMOWpFNnBIZXRR?=
 =?utf-8?B?aFkzMVlLYzhqTnJYbXRZVko5aitKWEtCcUVxZ2s5WHZOYnJmUC8zOE41SVVS?=
 =?utf-8?B?ZjZUQmo4dGlVcG5MTjlyYytmSVpWcUR4b0FWaGhQRHFTRStVZzE4TCtxMVpw?=
 =?utf-8?B?UGJsN0l2WndrL2JlUnNSTVl2UHRXTlJpcXNQNXl2b1Q4WnVkWHZRbk5RQWh4?=
 =?utf-8?B?ZDhRV0hHbEt5em80NXRaWll5U1pwTG1IR0o2L3I3SGJoTVRYQ084dVE0Nm5M?=
 =?utf-8?B?V2FJSHNjWnhvQ1FaSzlZWjBzRjZxdUZoQ0Vielk3b0pKeGxDbzZyOVlaSVA2?=
 =?utf-8?B?UVBvTC8xUTBrSGNVYVBLNng1YlNqdVdJcGlDZi9DbVlqc21KSWtzMDV6TFN1?=
 =?utf-8?B?MzhMczU2a0lyY2Z2UTlqcThnazZuR3VTVUtUb1RlMlJVcHNBK1RnUVVLYzZK?=
 =?utf-8?B?ak1vZE82R3luM1VHak92NDNaT0lDb0NUNm9GMTJCbCtxaCszODgyM29ubFFn?=
 =?utf-8?B?VHRyUDFpM3c0bEszc1ZCeERoWkJYN3lwdndyREJqL2dMSzBGZyt4R3piU2Zm?=
 =?utf-8?B?VmhGUDVGTVc2MnBYVUJpVjFkay9ndHVPV1VvVTgxcHpTdnFlOXIwMXlpMHBL?=
 =?utf-8?B?TjFtbFVITHpqYXhWU0M0TVMxSklxd3ZhQngxSCtheTd1bnczWkUycnR5bk9Z?=
 =?utf-8?B?L2FsbFBZSmpQeU5rSUJlUy9IR0pvOUYzb1BNQzhROFA0aW43TGtkcFk5cGtN?=
 =?utf-8?B?MWNrRmZwR28wSjJOdjA5ZGk3YXNWVUNJQ3lwK09LbXZKZERMMmovY295NUlo?=
 =?utf-8?B?ZkQ0RU1XN0JMcUNJWm9yRGxyUmw4czVQd0pvUEppS0NyVWtzUDhIdjF6T2tx?=
 =?utf-8?B?cU96cHFNNjNoeDhxT0dNNExWQktobVF3TjByeWdOZG5YNGxRMkdJclhCUUxo?=
 =?utf-8?B?aHhWbngyb29DWEU4QXIyZDBxRkRleENPb241WWpWODVKeVlhcUFFRE9Ya1J2?=
 =?utf-8?B?WE1Uc1BoMWVmeDZ3N3U0b2NyNTVnMXRoWnRGRnlCczdiL3VsSG5aQkphVkFp?=
 =?utf-8?B?dkJZOHcyaVQ4WjR0Vkg1RFhjS0doM0Z5c3ZMLytYZGt0aCtjRVpUcTM0NlNL?=
 =?utf-8?B?MGZ0ZWdXSnkvOUxITEFXODltTE8zNEdNdHhSK1RnRHAyZEMvaHlLMElJbzVC?=
 =?utf-8?B?VjRBVU1UZU13QlVTWW9nM2hLa0Zjd3N2MjgzRExacjlmK0lVbDV3QTgvT25x?=
 =?utf-8?Q?4PyBRfv/yTkjqy6Yn84X4WLHDPwspcRalkdwyn7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9564f5a5-bd84-4267-0709-08d95d70ede0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:09:45.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+bWYhVW8MGs2pTHfK2g6MBGS+ABrFt+LhsY0re0RciV5EWGUMmUjpHRdDmHeiPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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



On 8/12/2021 1:49 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 12, 2021 3:38 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode
>> check
>>
>>
>>
>> On 8/12/2021 12:16 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, August 12, 2021 2:16 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>>>> Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual
>> mode
>>>> check
>>>>
>>>>
>>>>
>>>> On 8/12/2021 9:31 AM, Evan Quan wrote:
>>>>> As the fan control was guarded under manual mode before fan speed
>>>>> RPM/PWM setting. Thus the extra check is totally redundant.
>>>>>
>>>>> Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 +----------
>> -
>>>>>     1 file changed, 1 insertion(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> index 9001952442ba..20ece0963f51 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> @@ -1208,9 +1208,6 @@ smu_v11_0_set_fan_speed_pwm(struct
>>>> smu_context
>>>>> *smu, uint32_t speed)
>>>>>
>>>>>     	speed = MIN(speed, 255);
>>>>>
>>>>> -	if (smu_v11_0_auto_fan_control(smu, 0))
>>>>> -		return -EINVAL;
>>>>> -
>>>>
>>>> There is a FAN_CONTROL_NONE mode where it is set to full speed. Is
>>>> that affected by this change?
>>> [Quan, Evan] This check was designed to block "auto" mode(like If it was
>> under auto mode, these manual settings will be not permitted).
>>> The FAN_CONTROL_NONE mode is not affected with and without this
>> check.
>>>
>>
>> To set FAN_CONTROL_NONE, basically also need to turn off auto mode and
>> manually set to 100% speed. If we take out turning off auto mode here,
>> probably that part needs to be handled elsewhere.
> [Quan, Evan] OK, I see.  Will add that for AMD_FAN_CTRL_NONE in smu_v11_0_set_fan_control_mode(). That's the right place for mode switching.
> 
Yes, that is the right place.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0,
>>>> mmCG_FDO_CTRL1),
>>>>>     				CG_FDO_CTRL1, FMAX_DUTY100);
>>>>>     	if (!duty100)
>>>>> @@ -1237,11 +1234,6 @@ int smu_v11_0_set_fan_speed_rpm(struct
>>>> smu_context *smu,
>>>>>     	 */
>>>>>     	uint32_t crystal_clock_freq = 2500;
>>>>>     	uint32_t tach_period;
>>>>> -	int ret;
>>>>> -
>>>>> -	ret = smu_v11_0_auto_fan_control(smu, 0);
>>>>> -	if (ret)
>>>>> -		return ret;
>>>>>
>>>>>     	/*
>>>>>     	 * To prevent from possible overheat, some ASICs may have
>>>>> requirement @@ -1257,9 +1249,7 @@ int
>>>> smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>>>>>     				   CG_TACH_CTRL, TARGET_PERIOD,
>>>>>     				   tach_period));
>>>>>
>>>>> -	ret = smu_v11_0_set_fan_static_mode(smu,
>>>> FDO_PWM_MODE_STATIC_RPM);
>>>>> -
>>>>> -	return ret;
>>>>> +	return smu_v11_0_set_fan_static_mode(smu,
>>>> FDO_PWM_MODE_STATIC_RPM);
>>>>>     }
>>>>>
>>>>>     int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
>>>>>
