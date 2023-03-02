Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9467DC678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 09:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2436B10E113;
	Thu,  2 Mar 2023 09:21:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F9210E113
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 09:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBjtbSGZMusLZ2GRuuc1GZ3VFT11rXnM6L5CeEp2iNQFm6PXrT7bX+Dm9Z2cCB1sLOkiNkb8lHFm9Kb1EoeZOEjNfbGe2gRldLjHEqg09iBm7X4CBXuoz0fBVg/ndX5nXFAK1Azmymw388x+0DY2DnYh181wi+Wyo02cezCLzF0og6+JxNHCy7AMktH5Phqym29QoTpsxCwxlQVZhOm5K6rlw221e4LXvNtx3tSEz8C5BWp+bCnXYWLIDPrIJW07022jSffhKUABdUc/CP9iLp1+USeiQlKJsAxqnoniKAAArKadvbemEhwPDVPvYfQZzMATQJrHEMJWLWZ58LmRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWnsUZTp6Hy+N4WTybqUwP1WaaVFYyQ3WGGtMVzCFt4=;
 b=lb6ZM5WInlFAVJxUKkL9nyQrg2aZjpiBvdVXguji8GrfpxJXWQ+xM99Zh6/Z4wFxAHZS15kJSVULspNLyb2jCCTSGC4lPj9VnlhXKsvUA9SXCRcK6Tx1p4Qx5gPIkLu98HMvikCzUrgR3029ayfCVRmF6jrq3a2kH7VX6V1Y8RicJzkvjPRSWR/oWe5nPikdPUSoXrOL1N5yR8f0+LSundGAOPxIHcRTZ5U9pbFTgnGDlsr8D+l1Q4Pxauo3vV789BfPwcTsR0KFfXVCEJ2l7l3rHpV3Si0C1rxqPbunKQ3ipAhMQZ6zOuHKLngb6+dH6AT/EprSItTKp19GXnhQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWnsUZTp6Hy+N4WTybqUwP1WaaVFYyQ3WGGtMVzCFt4=;
 b=tD8Ut5xMFlIgySLzGqd1NlkLdZzUoEv8SVI4s1b7HN2To9PJeqXpEzibimleYuAgzEAm3AmF3MkLf2HPkZS48dCE5OzHY6q+IagUHSkoP9C9AW1tCTfHN62AbvPMPp62iHVKQFThCXzfJvBXvvM4xpyMvJ4vCsS7Ssw3KHuDRFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Thu, 2 Mar
 2023 09:20:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 09:20:58 +0000
Message-ID: <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
Date: Thu, 2 Mar 2023 14:50:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: ce837264-047e-4b8b-3d8a-08db1aff6e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsCX2qNiXOPE4T4MnyiEwB1nsb5HXPprxtbhTmHmE2iiyP7OuDXMbdaBZUq1JaPkFBY9KxeUfd6hmq3vuk+QgsCs9+/5sJDNiD3wDkE3wr+NrODLaW6F/OqthUw6xoKOnatowkPQdB5o8zWuAmqqml+azqsJuWOaV2R4a9n7I8YsbJdm4bTRvIyG5PbtSZrrVvB3gq2YFIbbDMNrp7OYERD4/KAtg0f86Dg2kZeniUSDrPtWlIW/gIkQIHNFrtfk3EJtlFKyUTWbX44LcbqYiWqKR8riNhw2vc4EqiiFfn8CJ/GMVQU1/6nR8wsqnde0/oLEgG5BlpEC057ZgYQCPnCje4PiVWgrp0Uh7CyO9z6rhsBnmlpH4RIhUpriezW+XHoctLOvIa9FbDkJSMAiBHa8bOAmltr6sudIO62yBKNaAf9s22vWFOD1/O3FkWpolAHf1+9nL9YxgDNjZp1jKw6lwbtjDxraf1uyNUpkJBTO9a2bN/16oS3j8s8KJCZ/efRzisTOBLJF008WBLMJZiUKc+kogk68rhPi5JtZoajQGQY40C7LG0eX5H3Qut73peLT/aErUKSczExgF/tOeyx8MuFfyW0Z8b4CteN06eAFG7x6/DjkG1eQijbACXWQ4kBK0amKANUD9XX8Xo05P4ggw82ciASfVtHqobP5agR+avnvHszYTs+jkYHixzkCLk9vSGSQ+84BbkfcVc9BYWAtHVAgzceiUwVpW4RcXNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199018)(6512007)(6506007)(38100700002)(2906002)(66946007)(66476007)(478600001)(4326008)(8676002)(41300700001)(5660300002)(66556008)(53546011)(26005)(2616005)(6666004)(8936002)(31686004)(36756003)(83380400001)(31696002)(86362001)(186003)(110136005)(316002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVk2b0gvdFZYTjlhcEE0OXBQK1J6MnpmYW1kcEFJSXR2blFvNExzUG1FUktH?=
 =?utf-8?B?ZDlDd0RFMDNHR3E5NWxmM1QzSVB4WWZsSDFLc3gyNThxTjN3VUk2eXNYV1or?=
 =?utf-8?B?bXRUQ1JZdVd6RGtvaVNkbk9PeW16ZG5FWkJ2NDNIazgveEhlYXU0QlM0M2p6?=
 =?utf-8?B?ZVpRdklvdm9DT1h2N2tMYTJIUTVwU1FQbTF5aGdBTm5DMS8zQlAvQVhjN1hQ?=
 =?utf-8?B?UC9HUG9ibFQ2R0R0Vm00NDBuMlhFVDVDejlRcDc2bjdOZCtmYUVyTzhZWGd4?=
 =?utf-8?B?Z3pVUjA4SHpSZWFoYnhYSkdhcmxKTG9wTlJ4VWdYWFBEZm1ZSlBMNmo4bXNH?=
 =?utf-8?B?TW9sdEV5alZmSUQ0WVZnalFYY2R4K0dacEwzQlk3NGlicmlacThtY3pRL3lW?=
 =?utf-8?B?c3EzdE04SGovaVFqb214djFCM3A1VWVoQ2NkVEwvM0tVTWVyVkYwaTk5a1Y0?=
 =?utf-8?B?MFpFMWpvSHFaMlFjVThYYk9aU0JMcWhFM0lVckgrQnplVitVdm5rdDY1UHBM?=
 =?utf-8?B?Yjl5bjhyenF0U01xUEFnNjVPT0VXY29EQnpOTjZMaTV2YUE1RHVlN2tkS2Uv?=
 =?utf-8?B?WEZTRWl1VVpySUhXS3VTcVNYRkxRclQvK0tWZFZNcEc2dVZvQTVWdUd0c2Mw?=
 =?utf-8?B?NzRlODhuZm9UN1dOVFg2bHUyczlnT2svbWlsVnRFeHV4c0MvNlY0ZW85eEw0?=
 =?utf-8?B?eks0MjBoa3NGL0d4M0hIUHhUNE1na3hsS05yNk4vU2Nidmw5ZU1DTFR5VDdz?=
 =?utf-8?B?RnRLL2VrK1JLeHIxZW1peFQ1VHRmL3ZpU2JQMngzOVZ5Z3VmVWxWOTJxQ0tv?=
 =?utf-8?B?UEtHTmpzOHNHK1JIQW81WGJLQ2JGaklZN3JkYWJpUVpiRU9UbXNYOHpFcVdS?=
 =?utf-8?B?dEdkK2JnOEtUZEN0em14d1pOUXEzQmpPRi85TFlpajhBcEFCQ3lhaWtOR0tR?=
 =?utf-8?B?eW9pQ0g5azRnTWg2WldnNG5TemN6ZmtMM3hLR3NvMzlEb3lzamZzV3RiQ0hC?=
 =?utf-8?B?aUlWZ0hjZHV6QkFKOUo1UDh0UmFHNTVCc1owY09QMGQrb1k1c0hJT1ByVVZR?=
 =?utf-8?B?SHh0QWJISVVMMUNCTGdJT214YjBHWkE3bnJuK3ZhTU1ndXhyS1FlS1I2dWJr?=
 =?utf-8?B?czEzYUUxS2VzT2V0Q0VzQWp3cUkvMmtjUkZURTc0ZERrY1d0WGwyeGRpRE9Q?=
 =?utf-8?B?VEVOcEYzc0ViY0lGZ1lnUzBCMXBIMTd1aUwzMHlmWFlPY0dJVXdPL1c4VGR4?=
 =?utf-8?B?UGhGdDRpUHpXcWx3S2RROHZqTEMrZUlWMzZQRXU1L1pxRGN6WW5zSjhiN1F6?=
 =?utf-8?B?Z2Y5anV1L0cyeHByMjFCejN3dzAvT3hMd0VkNXF0QzE0Q0RhcEVoZzZsdEhB?=
 =?utf-8?B?NHpXWkpDb1BqUHZNSFNUTzhFMHM1UkN4QS91eFlDNGhpd0xPQTZpK2krNkQ5?=
 =?utf-8?B?ME9acjJMMGZWQTRMem1wSGp3VjFRd1hUM3JEN2g3eFFIdmR3VUFGNlFYWmdq?=
 =?utf-8?B?Qmlubk9zd21VTjFhOHl0ZWpxbjdxbFpOOWFrNTd0cWhtSE1admhhWGhMcHdC?=
 =?utf-8?B?VnRSMFlmV2dIa3FMbE9obkFKcjJQdzB6V2FDVzlaK3BubHNWNEVqVmV5dHU0?=
 =?utf-8?B?Tks3WitHSFN2aUhJZkJYOUVQOW9oOWRobFoxQnBnR0R0bEFLcDdQOTlsalR3?=
 =?utf-8?B?eEVQWC9Gb0E1UGNHRUg0K0ZIYVBONWVQUmdFeFljZ3M0dkZQQWRlVFZ2dkJ5?=
 =?utf-8?B?V3ltOW5VcTN5dXVlei9zTTZza3hHdDhUZU5peUZvUmlBbEVjOEFFUjNDMGlp?=
 =?utf-8?B?NlZTNHBPVTE2bmhab29XaFFOeWZHQzVTcTIyL3crRDY3M25XdEVQbTRGUFBr?=
 =?utf-8?B?WVFYMDRrSU1zWDNTZ2xMaU5xbm1ST3pzQWZtcGY0KytlZjlaRUJtNjluMzBx?=
 =?utf-8?B?RldHQ0tSYlFhbFdiTXJVQ3pzOTFxbitVeFRHbkYvTG13Q2ZtQ2t4OVNiTUpt?=
 =?utf-8?B?Q0dSN0l1S1cwV3hRVlRxRWpYeGxJaVl2aDVzSnJiUDUwb1pUUU81cVlVNFpk?=
 =?utf-8?B?Yk41WVBTd3hZQk9SamZNSUVvZEJkTXRZKzlvWGxBbi9zWVQxL3pkNGpSSmZN?=
 =?utf-8?Q?GyZbar86CWPhhARxgnT+uDFBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce837264-047e-4b8b-3d8a-08db1aff6e9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:20:58.2797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuVhT3YVagUxK00fMn87D1ChFW2959tbhEmW4xt+iO9fEjkf0nBIC023MqWuLyhh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/2/2023 2:43 PM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, March 2, 2023 4:28 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver
>> reloading scenario
>>
>>
>>
>> On 3/2/2023 12:28 PM, Evan Quan wrote:
>>> Gpu reset might be needed during driver reloading. To guard that(gpu
>>> reset) work, df cstate needs to be disabled properly.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I5c074c265c0b08a67b6934ae1ad9aa3fed245461
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 51bbeaa1f311..3c854461ef32 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2816,6 +2816,15 @@ static int amdgpu_device_ip_fini_early(struct
>> amdgpu_device *adev)
>>>    	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>    	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>
>>> +	/*
>>> +	 * Get df cstate disabled properly on driver unloading.
>>> +	 * Since on the succeeding driver reloading, gpu reset might
>>> +	 * be required. And cstate disabled is a prerequisite for
>>> +	 * that(gpu reset).
>>> +	 */
>>> +	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>>> +		dev_warn(adev->dev, "Failed to disallow df cstate");
>>> +
>>
>> This looks more like a firmware bug. Driver sends the Unload message to FW.
>> In that case FW should disable all features including C-state.
> Driver does not send the Unload message. We want PMFM alive and ready for handling possible gpu reset on reloading.
> 

Actually, soc21_need_reset_on_init code itself has a bug. PSP won't get 
unloaded by default on ring destruction. Even if PSP stops, it could 
just keep the heartbeat value as non-zero (just that it won't increment).

Probably, that needs to be fixed first rather than keeping PMFW alive 
for a reset.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	amdgpu_amdkfd_suspend(adev, false);
>>>
>>>    	/* Workaroud for ASICs need to disable SMC first */
