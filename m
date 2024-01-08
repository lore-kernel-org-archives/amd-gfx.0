Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF9C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 17:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1E010E298;
	Mon,  8 Jan 2024 17:32:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA4010E2A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 17:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b87Hod+oPQI2kIDjbezTVymQKjERH4yAlrFQCnw7hXM5Qcylaz1ltl4yq7MEYgO6FbQBEiUmRaC15mRixHpvcdSLKd84G2wS+9XqZB15eUA4Jmif6/d+Hbau2JVjPaGqcngoOqddKnE4QqIPp7jIqwXVGv/JEQ5muehhOE1HFneR2/d34U0/g3qmGEWyfSpLJ8juElP8EiIb94fWt4/mcFhsI5ZZ32pKSgUCPz8TXA36r+MRq5JDSVGrJm7NchnIMNEPNXrwT/V0qrYXc6bsG84VXurQj4K9+msgqaXYVKUsmGhPVZkT8gEi7BluwWlAfy8HgZQiaNLlCeojIvoQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crwJ00VM8XGiywudUunNJd552UozBoXRXgEHO5d3i1Q=;
 b=dMRzWqpsvSvnpo/3j4sWv7LQosKiYl41by4t4zeXGhradvHqsNvIu5LLzlMTcPw/nSwS/eQ+K0le/BAoeNJ/xHky1KLz97JmTHMsn7o2Nw3cCy6LR77BK8VSvU5csHX8jnEEqGqKw1ZS1hu/7EO1EhTKYrPF1QANrDZvAHGGjcCleblRbmrJGoLP777oaHdVJUkUBzRmZr5Bw+zqqnyHMwBS9B2u+qG/X4UlPvOIGGpmPRy3mgTmNEgxbqeTJXimUE81/AWcxWgKkx89d2b33ZFD2+qeDhDpvYGryAo3dQRu9FPp2KNggk/wwXUPfNfpWOsbd//HVHqf4UV3sFp+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crwJ00VM8XGiywudUunNJd552UozBoXRXgEHO5d3i1Q=;
 b=4bV9WMMvPkNw1JyTtxK8PNfycU9MhpADGc7PQgzYfL5IfoKItLBUv0O0eM8LFGtut1BqHbDQobG1msAoqjfTOTYB4bVjF2EevfTmpOFdpjyIC2YEe4ENg9sNxZflmVrvkeAhRbksUHGW1wbtXRzm3toxhX7LABYbA7OhSO5kth0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 17:32:23 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::cfe7:79d1:ca37:b74f]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::cfe7:79d1:ca37:b74f%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:32:23 +0000
Message-ID: <616c1d57-27cc-4561-9436-31b23c07456e@amd.com>
Date: Mon, 8 Jan 2024 10:32:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation
 failure on DCN 2.1"
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
References: <20240106004050.1506869-1-ivlipski@amd.com>
 <PH7PR12MB793974E3D84089FD35D19E25E7652@PH7PR12MB7939.namprd12.prod.outlook.com>
 <ryht25fuarcj5yl4g6fp4cafx4btwvfjchep6nujlaq6omgvu5@p6tnynn2umjz>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <ryht25fuarcj5yl4g6fp4cafx4btwvfjchep6nujlaq6omgvu5@p6tnynn2umjz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:408:e5::6) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: a8170a91-1934-4bfd-4cd7-08dc106fc64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nQj9N62zKMhHPhEZj/03MHUY82ymSFHOZyujRBzfufGZwebQfmbD3XMuUQatsRkqEDicM1KcPRic1Qd7jWbrWKt5ydhcVqamtnN+oeddrZzCzdYjl/T5wwI6B/9HPVrQSX/o1mJCERW/6o0+kPZsmlsO4H7HKIGCLd7iLu5YzA+jOq7R0Ok+l++K3/SuIZRelhSkLuTlwD0kGHg3ONLTYHRgG/i07znviKHBHTuJKknxQVK8MdAhB8r202++3duH0oez19gm6KeWq2oPH0nnyQ2B89TAzOBftxxPsZ6LzzIFLZZO82WQhwgxcFFfnr9J6gg8qJwcOFT+wr08D+ElcbsH6MRe1x5l7bdZop3qCkmn2rj+TUM3WB0DWvPzp/xFbL3ccGP3NhceQ4xneCcG4I+m2rNROgp5oX6F1vEhFt9C60HPtFFqIqF1gqSwf6tr2T6OCb31urTyKPEgFiKFmGGfrhbxSkvGKtk1Kz0G/StttW1fl6H61ZuUiPQzVkE2bUeAyOKLJYZafGHZwjcbZuHYqcUqZ6YdqmgZ7EOUSr9aCvqWY1oUfzMc4ASnbix4wmSRnaSUWyY+f+OiD8m2ORlEMqIvfY+Ujfi11nD4BCLEZZceN0WvUP7kvixxIIjwzarQvsTVtDHQ8h0CbhwjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(6486002)(53546011)(2616005)(478600001)(26005)(6512007)(6666004)(5660300002)(66476007)(83380400001)(2906002)(41300700001)(66946007)(54906003)(316002)(6636002)(4326008)(110136005)(8676002)(66556008)(8936002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUp5RGdpMkw2TzZmUkFYT3RBY0hTSHRtL3pENTlWSXU3am5iUTR4OTRCbHo5?=
 =?utf-8?B?Zm52UmZ0Tm02OTBrdlVFTW12VUJHdmV1eDlzck1WbzFheU5nNmQ4WDB1a1Aw?=
 =?utf-8?B?TElGM1pJL1hCK3VadEJFcysvTDUzdVlOT3ZVK24vTWZaaTZtNUNyR3JjdmdT?=
 =?utf-8?B?M0NXSzgrOVM2aWJDb0x0Nzl6cGgvbTlVNTB6KzRjVnpwQnlzQzgrUThJcFkx?=
 =?utf-8?B?M0d1ajFDTjVneG8xekhPMHNzNlI4d0lYd3ErZUJUQkR1YWRma2FCMVBxaXYz?=
 =?utf-8?B?M1MrM2JtSGI0MUpZbTY3a0svdmRXanJyc2IySGhrQWl6RndzbUh6TDVOY1hw?=
 =?utf-8?B?Y0tadjBKMGlPWWQ5Uko4dWZSbE01SVBLM29adVo3QUx1ODgzbUsvdy9icTBP?=
 =?utf-8?B?TmdkaWdhOCtERjhZQkthc2tNVGNQbW9md05DOWpMRmpweWRkdWIrRWh4ajd2?=
 =?utf-8?B?NTZKSXdPSmZLWVY4K3gwdVVXcEJoM2czaVE4OUlsNUpoUUc3ZE5MYnBVYndT?=
 =?utf-8?B?S0ZVeDFJOEYwaENYQkZCU0FMWlI0aWFSaGRSLzhTZ0txRnBjK2FlcGRvUW8x?=
 =?utf-8?B?Tzh4dS8xUisxVk1HQkVqQWNvSlNIWk5scHFVb3BWUisyQ0ZITDhnVTJVakxu?=
 =?utf-8?B?VTRHOVdoT3RiOERhVHYzMElzT0FsbVJMR3IrbUl0OHg3L2JoeEV2RlM2Y2VN?=
 =?utf-8?B?K3lLS1IzakwzZVAvQ3ZUV25iTldVbGZRdUtMZzhLL3czclRYT3pzb0RkUHpB?=
 =?utf-8?B?ZGI5OXdGcGZPcW5IVlNVWFBuKzlGZ2EzTnF4OUhQRkx0WkJ3b1VmbHBTQTVE?=
 =?utf-8?B?UWF1Sng5VG9mdEJSaVdadW9FcGRnOVN5bWVNQUFnNW14L2tBVnZ4V3lETmhu?=
 =?utf-8?B?Q1lnVEpKNUF5bEgwSGVZQlJqYk9NNTdseEFEVmFUN1B3VHlLQUJRMGlhWlJH?=
 =?utf-8?B?dC9oZVNYbjF5MC9mMWNUdVVhK1NJc09vRVpaMGxHdDhnUDdVMlJLSnp0Ympm?=
 =?utf-8?B?VzVvMFFkK24yaUpYUFp1NE1VdGJNQm42SWl4VHhURGJXQ1haTUhRUGo1YnBv?=
 =?utf-8?B?QUtTTllkL0t6UlhEZ3hrYUV6NEh1bDQ0U2kyQnFYZEtsVDlPa0V4UjBmekRp?=
 =?utf-8?B?UUxzTFNpUmdUbnc0NGNqd05MS2QxWGg0QlB6Y3ZWejBJay9NbFFKQ05qU25h?=
 =?utf-8?B?ejN5MHZMWnIrV3ZKOElCcmtWcXBCcXVFZXprOTFUeWpqd05wa2RNaXEwc0lS?=
 =?utf-8?B?bDh5NGxocFV2QTMyT2dBTHM1YjNhZmNQaSt4SGRIMzgzWlIrTlFLY3J1aVJV?=
 =?utf-8?B?L1A5OXFqK3RTd255NHZkNGErK1NSOGhTQ2RaZDNvSmNoVHZ0REU2c0NOTDU1?=
 =?utf-8?B?YmFZZjZmQkxLTjRBWVMrY09kbk1Hamp1b05OY0dFbTM1a09GaVRReWhQYjZs?=
 =?utf-8?B?TWgvVnBjSVAyL2NodGg0REM5Q3ZaU3FodEl5Z0xpMmNFTXlyZ01CN1hVdGor?=
 =?utf-8?B?S3NiN3lTZ0xQM1Zvb080UER3bkJyd09ndG9TZ3hsNGs5ek42Y1UrVVlTOTFY?=
 =?utf-8?B?UDJZVjZsK2YyZ1VsZ0hURWthamFaT1RwUjdoRVhwR2tocC9TRCsrZHBuZlho?=
 =?utf-8?B?TlBsRkhCcTk3bnBWSlJRVmdLNHRINXZ6Vit5eEx6MmZJbk5MYkgySkJBaGxl?=
 =?utf-8?B?Mk1MeWpBV29vaWtocTJPcXF4TUpHck85dG9zMVRnVkF5ZzkzTzZEWm56eFhU?=
 =?utf-8?B?ZElqTG1MeTZ3M2NiSm5MT1VOd3VhblUxWFRnYUR4WHVKdHV6U1ZMcmZ5bVcr?=
 =?utf-8?B?cHh6Wm0wOVFJM2JRTVBsbFRJQUVOcFpKd1ZnUmw5QkdFMEQ4KzIzZTU2aWRI?=
 =?utf-8?B?cER0ZkJIamNHcDZaSWxiUzdmbTlIb0ozY0t0ZVdQV2JsZ1FXb0ZobWhIWEx2?=
 =?utf-8?B?R2VRRzVpWllsL1VHbm1nMzUvWGZOMkdadEdsbGhsQjNGVXN1a3g2TlVEbGMx?=
 =?utf-8?B?bWhsQ1kwT3NZT0h4b2s0SjN0UURsbkNPZ2t5MGFOc2JnTC9qZVE0V0x4YmQw?=
 =?utf-8?B?Y2ZCcTBzdHBnMkN3aUFWa3J1dzJpYmgzV3dHVGNwZUFoZFl3L2lSbnA4UGdn?=
 =?utf-8?Q?lZsT9jNTLw93EdyvS68NQ+Dy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8170a91-1934-4bfd-4cd7-08dc106fc64c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:32:23.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idPjslHujEqZZTBLksFcmvPhmbOlOUStwXp4mOYtBtGkQ0XzzOpD+bCHO3Vh+6dIiJ0QQlE4z3HPi5nsTpv90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Choi,
 Nicholas" <Nicholas.Choi@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/7/24 11:51, Melissa Wen wrote:
> On 01/06, LIPSKI, IVAN wrote:
>> [AMD Official Use Only - General]
>>
>> @Siqueira, Rodrigo<mailto:Rodrigo.Siqueira@amd.com>
>> ________________________________
>> From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> Sent: January 5, 2024 7:40 PM
>> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> Cc: rodrigo.siquiera@amd.com <rodrigo.siquiera@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Melissa Wen <mwen@igalia.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
>> Subject: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation failure on DCN 2.1"
>>
>> From: Ivan Lipski <ivlipski@amd.com>
>>
>> This commit causes dmesg-warn on several IGT tests on DCN 3.1.6:
>> *ERROR* link_enc_cfg_validate: Invalid link encoder assignments - 0x1c
>>
>> Affected IGT tests include:
>> amdgpu/[amd_assr|amd_plane|amd_hotplug]
>> kms_atomic
>> kms_color
>> kms_flip
>> kms_properties
>> kms_universal_plane
>>
>> and some other tests
>>
>> This reverts commit b7ebd39e2922f642c7ee63ade4a4a5a1ef675d84.
> 
> I'm not opposed to reverting this in the short term, but I don't see the
> connection between doing a full validation and link encoder assignment
> errors. It seems more like the change unveiled an underlying issue
> rather than causing the error. I don't see those errors on DCN 2.1 and
> 3.0.1.

Yeah... I totally agree with you. I'll try to get one DCN 316 device to 
validate this issue. For now, let's revert this change since it causes a 
large regression in our CI.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Also applied to asdn.

Thanks
Siqueira

> 
> Unfortunately, I don't have a DCN 3.1.6 for debugging :( It'd deserve
> further investigation.
> 
> Melissa
> 
>>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>
>> Signed-off-by: Ivan Lipski <ivlipski@amd.com>
>>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index d77fc79f3542..111c6f51f0ae 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10752,7 +10752,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>                           DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
>>                           goto fail;
>>                   }
>> -               status = dc_validate_global_state(dc, dm_state->context, false);
>> +               status = dc_validate_global_state(dc, dm_state->context, true);
>>                   if (status != DC_OK) {
>>                           DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
>>                                          dc_status_to_str(status), status);
>> --
>> 2.34.1
>>

