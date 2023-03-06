Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0890BC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 05:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11B310E0A4;
	Mon,  6 Mar 2023 05:42:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAF310E0C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 05:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbkaNeVRT2dM1ph9qagolxYsPuCBoXqpYFjUOilGFeIF7N66z2WUqNRO12mWDwA2VBECcY4u/vrO64/2dYdJ4roe3FyrKfTn3qEn3DHJE1wOfIMt16lWCVnUnDUPdWoJvDTLNhIFSmsbztV9/jnRl99uV2lFs7mxOdv0QoX7LlB/EQIRIpXRl278FWWyBphMABmHUEDfW0so11yf5nFugg/wi7/O1PwcdKYAWUogd8T92d0g3bWCD7mauuhHVGDd9Ux+J0dxIBVQwPY2vZMu2lee26RRtHTfUoU3lKNdD9jYCb9bavsoLMS9cVEpEP3O1uugoOaBOjuIB5fuYjCigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIqT6jXehDTEvUMmdgqqtD4KFQctBSz0VifIDwbiTI4=;
 b=OJMD7NERm97KZFnSe0EWdtNiKf9rjk7cnIWM4bL5HVHY1nH5YpXFtIBYJe1iYgcpo7LtIk7lldwPEMCaCeKJD869vJNa4iJk/h5heHzXKfg3kW+LOBvbz7bLMgZ5Gqv5xgoSYyOBUiooqIg3aLoBBGhkOTC0Ug0O/hXY5zGr+9+WcvLHZRtcyuTBtyB/eKdngYhhFU5q8e+tquZbC18U4WRDw4EMAeJgtGAqt/kMtUSQcVEDX/mgU/JD+tFCIcOmFJ66LkNVWVzG9805FRuYK8YWUIuE8nPs4AxiXAv/s4k7oi47ACspW/TPjdRF82d3MLaLtOvr639LsrJci4LHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIqT6jXehDTEvUMmdgqqtD4KFQctBSz0VifIDwbiTI4=;
 b=T4k/iBbPSmtHgQeALixrmHxnSY/UlNkmPGMv/qRLvNCkcYHRKFBySzOHLTDff6XOx4UOHB9tGWcVNHwLSPGvI2LT319IIol7eQCGG5+jeUNsNW+KvP19tcbvo4Fb0ukq6UeBHsoJ6DNgvd+0sJNIj+fP3VUaJ9gGGlczstXxAdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Mon, 6 Mar
 2023 05:42:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 05:42:37 +0000
Message-ID: <924b9a34-2df9-f94a-16ab-d171b03fe9dd@amd.com>
Date: Mon, 6 Mar 2023 11:12:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
 <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51446EF4033480FC8BB6F82BF7B29@BL1PR12MB5144.namprd12.prod.outlook.com>
 <ea9fdc41-f61f-35da-b35e-e710fb621b1e@amd.com>
In-Reply-To: <ea9fdc41-f61f-35da-b35e-e710fb621b1e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 535c08fc-9fb8-4eb9-686a-08db1e0597af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: is2DaaFrGXEcJPm4wCqevefOqR3L5uAgI26Ee3ELZsGXDm3X+iCgad+qO3emM6d1l2ZOYhTW/NIoADbbXvQ5LqYAdKU/Hq2kiFhuih0DRSwc48udBHstB7q7Lv0fw92oMHPyxmk3rN9wMZNKarhiEbkyFW0KvylSWKWHj6FSOXPIMHQd0tiZAglFcFViyZ5Wf+NOA3r+6tESV5Jk97uP9qyvxc1TA6kFFv1Oo5hLxT8kXN9zwjGp2LL5qtK2FnAPEUQ3oPjzuyFZiQUlO45IjAK0qlOjkr0cuMQ14ZXYW2c2vqLZLJrJjGNlyJdECW/RQaDQ8UenD5XSTVjP50mdttse+ln8BaNlYC1cppZS/fyyhTn25CEZMtxh7a3j+LhkN49frqgGiTDBHhCeuwEggLaPqw+k9Kpf/WgCWhcCQl0Mipnq5X0EP+ix2okYsVrHWgx1+5jPYzz/iA/P3VwBiLmCjkEhsNj/5P+s4k8rxYcrW1CqX9AGHJg7YVegQis8TdsFLvzoBANPDbeK71/BFy/ikioNjIIGzgg/9eCt26OQppprLKjwCkHDpzF6Lsfiec7wPs5+nXxSlt0WCP4QWNPlyvg0+X/xPofDmnpXBPfRghKS/MhaNtbXCe3ES0ax+Yz4cIqco2LjFAuuEL3zt0Q/ZRnTJwyNsLGGeDh7ZXhjJGIc5kTvKNCuxOwOQ+gfud0eo00Uo8eD/exGqE4zhIPte2KbQYP/IyBesmnPb8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(36756003)(83380400001)(6666004)(110136005)(41300700001)(53546011)(6512007)(6506007)(26005)(2616005)(6486002)(5660300002)(66476007)(66946007)(8936002)(8676002)(2906002)(31696002)(86362001)(66556008)(186003)(316002)(38100700002)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0FRSDNmMHVwVjMxQ3JsNjA1SDl1Y1k5ZlRZT2drWWFtSlJqdWhNSkdEMUZn?=
 =?utf-8?B?Q0tXV0J6bHJUQ3o0NEpHKzdYcTJsdHZDVzNkL2lNTStockxxcmZyTXdmd1Yx?=
 =?utf-8?B?WmdibWlqdjVFSzhvNWFQRTF2VWZsRWFEYmptRjlwbm5COU1pSVQxOEFsbnNo?=
 =?utf-8?B?VlM1RTVVZTMzTFlFUHNXQjhsYThXYXM3R1p1TjNiMU1YdHhsS1h4djd1Z25Q?=
 =?utf-8?B?MnlUam1Wb2UzdWhtR2RoQ2F0OHA2b3FPS3pMYmQ5NGZwZ0o1bk4xU1l6OGpN?=
 =?utf-8?B?d1dGa0JaTXpaQ2lnOXNkOW1OVkFKTkhtNmpDWWprdkk1RzVRZXp2QVJNRlBX?=
 =?utf-8?B?WmxNZ2wycHJxMWJ4R2hGRVZBZDJxU0RCdmNnL0FTR09OZG5pQ1FCNjZQR3Bs?=
 =?utf-8?B?eUlJZ3FwQlhoTFBTUFlIYVFsYUpkYlBkWVpyODRwTkdYTjllVlRqdGR2K3B5?=
 =?utf-8?B?aUNaRlMyTlJXdXJlazIvdWU5TjJCWlFnRTRHUjRDS3IzNTVjTnNuams0TTNR?=
 =?utf-8?B?cWJzc3Q0ZHRBeU1pN2FIT2ZkMjAxNXpLdjhPTVBEM0NQeXJlTWVDaVNacVVB?=
 =?utf-8?B?czRra2crdk54NFJoc2dPeHJ2anhCU2xDY2JTQkQwQ0lLSDMzR3diemMyN0ZT?=
 =?utf-8?B?V3V2Y2pUczJpY3FXbEdvUVhXZ1pDdjZaY3lkTzhBMVBVK3I0Wk5ZZm5MS3Jw?=
 =?utf-8?B?V1czU0FnUWc1ekFDWXc1a1VUY05sdHJ4ZExiVEFaRVpBS3NxdFRVOXNhSmZW?=
 =?utf-8?B?T0xPb2w4RUQ0allFSXA1dEx0ZXZCeHRMVVhRVi9RRi9LeGR2UzJYSmxwSWVh?=
 =?utf-8?B?QXczNUVDMFJQRVVwd04zQXFTeGtWU29nK2ZyL0tWMThHZnBWZW5DMUR5L2VC?=
 =?utf-8?B?aXh1ZUhhQWRLNHNOeTM4bWhRdXF0YTc0UFp3TWp4VXAxN1BhOWt4MG1TYlRr?=
 =?utf-8?B?UzZZVWNRSTBHVVArOWw1QkRRa2hldG9vekFSS2lROEFUN1ZZTEtTcGcvUlUr?=
 =?utf-8?B?bm0xQStaZTQ5SWtycXZ4bEROUlFwTisxM1JtMldmY0dDbGIzNUtyOGNYRmpo?=
 =?utf-8?B?dnA4elptMllNcmpES1g1UHVuSENkUjNhM0g2TCtuYmlDRngrYUl3L2FaVWtY?=
 =?utf-8?B?YzZNaEE0YUZMZ3pqOFhKR3lUelBSbU5ZWmlPRkRGV2M4YW1Lenl3NVhjWmEw?=
 =?utf-8?B?MDNENnY1UkIxTEs2VEl4QlR5T28xdTMydTZRN1B2YitaMW5Ua2JCQXdaZ3pl?=
 =?utf-8?B?WnVPM2lmTCsvTzBHZjcwamtzN1ZzcVk0R0ZRdEh1MGZZRkdyNW5PVWUrRHh5?=
 =?utf-8?B?Z3NlWEpGYmkwUlFmZUp3YXowb2NycTVCK3VHc25HMWJTUEVrV3l2T0hPd1hi?=
 =?utf-8?B?NlVTc1lkVWgrcFpSb2FWQ3BxNllvdStxN0I3K0svSmtZN1JkOWR3NTFsdC9s?=
 =?utf-8?B?TUZUZnFUZjBZMER1Zmx2UkFxQnBFejJVM2d6ditHWkRZdlB6RVcxdjhjK0J2?=
 =?utf-8?B?UVAwR3Fjbkg0dERFc1VJcHBMSmkrRkdMU2hMd01TSzZxUmEvOHJrUWhkOFNB?=
 =?utf-8?B?K1JxVTNRU1ZYaU5ZWTd6WnE5dnEyR3l1RTZtemUvcnFlM0FGaW03MWRTSzdO?=
 =?utf-8?B?UEdQZS9TUVAvUUd0QlkrelNzTU5ZM3NLT2VkcUpGQ3lSOGEzTlYxc0g4NFNi?=
 =?utf-8?B?OFc0QktlVWwycXBSN2RScUF4V2VZRnFVRXZFWkh5eC82MGtmM25EYVIvcnNr?=
 =?utf-8?B?SDExZXllb2FWNWRVY0t0a2Q1TXp4emU3QTF0SjNTTVJRbEozN1JBTXBVMmd0?=
 =?utf-8?B?NENMalF2ZVdxNENNOXF4VVBSZWRTbnJQQjFQWXd4SkcvTzUzUElRUDRYeklW?=
 =?utf-8?B?RzBram83TU1iaW1YTlR3SkxoZzlwWkkzNDBtTUNZZHIzQWhHcEloWVZPVWc2?=
 =?utf-8?B?Mll0Y3E0S1BjVkNmRnJ0a2xqdHpNak5IMTMyVTNiWUFQNjQrQUtHRzJvT0JJ?=
 =?utf-8?B?TSs1QnZWQTBsa0tYK1RMb1BtY2ZZbGtCMnpQbHRUU0lZR1ZHUlVabFVyL212?=
 =?utf-8?B?bWVvMXhmTmlyUHJTVWQrd3hXTHUyL2VEYWV2SGNVanhzbW1XS0Mrc0JKeXc2?=
 =?utf-8?Q?OGZtTTSATRHufo3iktl9DPnNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535c08fc-9fb8-4eb9-686a-08db1e0597af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 05:42:37.6269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7N3DT/jJHh/ZV1r4Npd7ahHnyrc8MvtyOviDqdok8UHRhkmZI0GU9WTQetgEC67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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



On 3/2/2023 9:05 PM, Lazar, Lijo wrote:
> 
> 
> On 3/2/2023 8:56 PM, Deucher, Alexander wrote:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Quan, Evan <Evan.Quan@amd.com>
>>> Sent: Thursday, March 2, 2023 4:31 AM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver
>>> reloading scenario
>>>
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, March 2, 2023 5:21 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver
>>>> reloading scenario
>>>>
>>>>
>>>>
>>>> On 3/2/2023 2:43 PM, Quan, Evan wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, March 2, 2023 4:28 PM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver
>>>>>> reloading scenario
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 3/2/2023 12:28 PM, Evan Quan wrote:
>>>>>>> Gpu reset might be needed during driver reloading. To guard
>>>>>>> that(gpu
>>>>>>> reset) work, df cstate needs to be disabled properly.
>>>>>>>
>>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>>> Change-Id: I5c074c265c0b08a67b6934ae1ad9aa3fed245461
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>>>>>>>     1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 51bbeaa1f311..3c854461ef32 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -2816,6 +2816,15 @@ static int
>>>>>>> amdgpu_device_ip_fini_early(struct
>>>>>> amdgpu_device *adev)
>>>>>>>         amdgpu_device_set_pg_state(adev,
>>> AMD_PG_STATE_UNGATE);
>>>>>>>         amdgpu_device_set_cg_state(adev,
>>> AMD_CG_STATE_UNGATE);
>>>>>>>
>>>>>>> +    /*
>>>>>>> +     * Get df cstate disabled properly on driver unloading.
>>>>>>> +     * Since on the succeeding driver reloading, gpu reset might
>>>>>>> +     * be required. And cstate disabled is a prerequisite for
>>>>>>> +     * that(gpu reset).
>>>>>>> +     */
>>>>>>> +    if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>>>>>>> +        dev_warn(adev->dev, "Failed to disallow df cstate");
>>>>>>> +
>>>>>>
>>>>>> This looks more like a firmware bug. Driver sends the Unload
>>>>>> message to
>>>> FW.
>>>>>> In that case FW should disable all features including C-state.
>>>>> Driver does not send the Unload message. We want PMFM alive and
>>>>> ready
>>>> for handling possible gpu reset on reloading.
>>>>>
>>>>
>>>> Actually, soc21_need_reset_on_init code itself has a bug. PSP won't
>>>> get unloaded by default on ring destruction. Even if PSP stops, it
>>>> could just keep the heartbeat value as non-zero (just that it won't
>>> increment).
>>>>
>>>> Probably, that needs to be fixed first rather than keeping PMFW alive
>>>> for a reset.
>>> As I remembered, the change(asic reset during reloading) seemed
>>> introduced to address some sriov issues.
>>> @Deucher, Alexander might share more backgrounds about this.
>>> To be honest, I'm not a fan of this(perform asic reset during 
>>> reloading).
>>
>> I'm open to doing it a better way.  We did it for two reasons:
>> 1. often times the device was left in a weird state after the driver 
>> unload/VM killed. Etc.  We needed a way to put the device into a known 
>> good state so the driver could re-initialize it.  Plus, IIRC, on some 
>> of the older ASICS, once the SMU or PSP firmware was loaded, there was 
>> no way to reload it without a reset so you needed one anyway.  This is 
>> largely why we have to reset for S4 as well.
>> 2. Some large servers didn't power off PCI devices on reboots to save 
>> time.  This left the devices with whatever state they had before the 
>> system was rebooted which led to driver initialization problems on 
>> subsequent boots because the device was in an unknown state.
>>
>> If there is a better way to handle these situations, I'm all for it.

Hi Alex,

There is a part of FW running to handle generic reset requests on SOC21 
SOCs. Can we remove the reset-on-reload for soc21 SOCs, unload PMFW as 
usual and see how it goes?

Thanks,
Lijo

>>
> 
> Are those cases valid still? We have this for GFX9 - reset done only for 
> pass through. And some of the GFX9 ASICs are used in large servers.
> 
>          /* Just return false for soc15 GPUs.  Reset does not seem to
>           * be necessary.
>           */
>          if (!amdgpu_passthrough(adev))
>                  return false;
> 
> Thanks,
> Lijo
> 
>> Alex
>>
>>
>>>
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> BR
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>         amdgpu_amdkfd_suspend(adev, false);
>>>>>>>
>>>>>>>         /* Workaroud for ASICs need to disable SMC first */
