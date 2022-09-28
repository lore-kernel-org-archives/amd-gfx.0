Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30EC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 07:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CA910E29D;
	Wed, 28 Sep 2022 07:05:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418AD10E29D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 07:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKv8Wl9dwZOcjiK1HdtukCSvABOsJxE02SGhek6d8gxk3rp5wzIaH7ipC/20EYuW4FgunCe6vb0BPqIgo9mRCV/qYRHKXyVwuOWKPPK3r8FMnSGTf0x8EhbPbK5QHOzPCaro6A3nds2FH7daLcP5eZI9LCrbZ6MG5vQ2VG8A9p36HHBDv7poZuW/tSoO2YUU8dLxnssyxN1xX3HEvF5pM3NbiTO0OGA59203hJK8HK4WuStzdOOiL5y9rsMqsCA2CbDJmYxil8nuUUEuWmFN5TfQ/PnzjKqO6+5i+JfCfuBifWfxcMzK2141fckNMJYEdxqzQDs4Vs/W2bAAs8VNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTw3tcJk4Z7MC3X6dgMB6mXjvv67v1er1SfQE7+QTY8=;
 b=kC7JhmXHbIjN4JQPqI1VR+cSt2QokWHrRDNxaxUfxtfaaDKbfjVXs66QniiZ4uOjxBsWgg/rZg7rVxlu98PtnB8sOuRZdH+rHHUkTxLPM4ZEeaSF3gdJ620A4kjYew+4Q3s6VrlYuMlcTtJPZ7V74GBaopDEYAtfm0IuyDwgNkkKXIoDXYYLeX6Yo7c7NyriHUGaSvryvuR85b0tceKS3o4Jz2I/+qtvkxbgaQfXo6ohUUrzO8d7T+Uhns1/pmTcZOKKB9h3gqb2Tb+aOPRyakeoFIJ2du2PXv3vGROjoUbg7O9lCo2iyYeuaWgeCmZWFlt6pIRcOTbJIzqakUCg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTw3tcJk4Z7MC3X6dgMB6mXjvv67v1er1SfQE7+QTY8=;
 b=kald8YFuJYLHHmCaHg8hSDu1dSVffqzl6HHqpFoCdDIe4r2X5o7/vfH3q28iJrryJ5Q9UGGKok39Uq/o6diFL7Frs8AIMHEYfacpQOhc0wuYYZuciqiv0PB1fUceoF2WN9G02mUY29bOp9/7jkj8X0eqdUiKEoeyjlHWQIsAA54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:05:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 07:05:43 +0000
Message-ID: <10fa89dd-9ea6-5eee-20c8-f85c538762da@amd.com>
Date: Wed, 28 Sep 2022 12:35:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ab14a1-627e-414c-6184-08daa11fdb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbABJxBWTGX01OEBn6XvDP8eGFb+MpMBwONGXZaEho41fsjn1uslM9wZ3I04Bmc/YCdy9pGrrR7XNuhf2u7caRD2Ma7yPtd09F+accM3ybicsYw9USfIoKnbh8PbQZ2o/e1xe4cV8cP3S1v566Oe+cJ4oLMkbmX9lIrIW3ddfrsWcfMJ/AVEBXnIrBdg9wS/50qI7Lhpt0iZA5kKchUm43h0i6+Ehbfj8MieV8lP6aUxOzOWZIkwj0+NqmNlGn5iwnEHHUkD2z31+YQH8zpvxv4Hj52Dd4Cw3i2Goh+FdQsptS5vA1bia49QZB+BsmNMY+zNgeBVqWUF05wrQQVmxWU3yX7NNLWbJHGX9tbN3sz9nstoPRmMuglkCFbJPCYELBIql0jhHr41gxFy6rFz9RC2nDzfbHxyVWYe3UVZT+g7hC6IqTo4v4PbdVdoRraubL+lAccU1nWhsj/dJpfQ+T9qUq6xGgu8mw3wZzyjZxORCZqL/GfvvEC873wFQxZdebKdsVj5ZizgSqJBoXZKrlQXzxnFBlE8TlLVOl4Og1gBsVAOQG8dQ1Axe9GqedlVdwhhhbrKwe1xgLJFbDqCpIMcWPCHr/eDLljvi4Mbc2OtGle2Wfojb+EzIBs9Y6nwVaHwz621dJqXTmHFQZVwm91UXgCU3JaC1FzYubMxT6gRBJ2xXveOA41ndCjFWFmSv5wlXks6tWe0Ygt0D1S8fURq0xVYUgQtSpfR7BUOZqXdPFMH2nP940lt8d6pMr/SvwWeFhN/O4v6fnjBsHOZn3uWwwkJrVkqtZKieiDgRCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(38100700002)(86362001)(36756003)(31686004)(31696002)(2906002)(186003)(6512007)(26005)(6506007)(5660300002)(53546011)(6486002)(66574015)(41300700001)(83380400001)(478600001)(6666004)(316002)(110136005)(4326008)(2616005)(66556008)(54906003)(8936002)(8676002)(6636002)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2Zlcm5uV0FDUFp2Y1hkSDhyVU1Eb1hBdzhxNm43S1huQzlqKytwaE85b1Er?=
 =?utf-8?B?bE1CU2pnMThUOWNxZ09wMnNRK3Y0MWViOTNiWXNFbWF1cnI5S2NRMkhGc1pI?=
 =?utf-8?B?d2xXMlR1TEpvY2w2ZlJQUDRFSld1MDVRUytUVzgyMGNDdFNLU0ZyYldxVWo0?=
 =?utf-8?B?dy82QTRwTTA1cmgwYTYzdEhZOUJQSmZlMVRnS25YTnZKaUdsQndvclV6cC9t?=
 =?utf-8?B?MDNoelJZTFVzOXpGeVdsaXRJZlVoRGhyU2Y1eU93cXVhc3JvSU1wSzk4SDlQ?=
 =?utf-8?B?RGdwSmRSQ0FpN2Nhejl5aTZEVHBsd3JXRjJrMElMWEZMS0lHNm9YRWNoWHFP?=
 =?utf-8?B?NWxkLytMTXVYNmI1cXNkYWtLL1dibThjQU1RcWNENVl5NFV4dXBSWjRrUWFE?=
 =?utf-8?B?RTNnL2Nxb2FSMmxqSjYva0R4K1RjclJJTnR4ajB3ZStBZDlNSEhaT1gvRkZa?=
 =?utf-8?B?RVVSSVorUXBCMmlWN3BOb2JJSmVPOU1pOGtEM0VnaW1lL28xd3pSOXlqb2dW?=
 =?utf-8?B?UXdPQ2Fqd3I0Rm9tazlWQ2FVaFBtdFUwTG5OQTVPemZmbyt0TERndFA3cXdm?=
 =?utf-8?B?S2hNbzJuSHFQZWc1VFVWOHRydjRQeGFMNTJoViszbzY0L01IYllvRnBxbWQw?=
 =?utf-8?B?Sno3cFhLS1ZIYUhXSVlhZXViOW1aQjU4ZlJxK29SSEJhZ25WSDRDRWw5ZFZC?=
 =?utf-8?B?S0RwVTZnTHBjQUo0OERMTlhsRTNyUzhMZU9FVU4yOTVsdGdoR3JxUHI5T0t1?=
 =?utf-8?B?SC9EZldBQXM4NzErS2gzWDJPYUNjNmhMdm1sMlg0TEVjdTVLVU1xcXdZSFFs?=
 =?utf-8?B?TzN1cWpWWXpCSGw2aW9tVEVpUVhYZlBHZ2pIWkdEQVQzM1ZWNHdKRVJQaS9U?=
 =?utf-8?B?Z2x2eVhUNkE5WnROR09OTmJOdkRNM2JSbzZPNE5LY0poWS9KbEhrNVg1dVMv?=
 =?utf-8?B?ejNrbkpob0FObzBmWS81QmQ3aDNxcnh1TmcvNkcwS3d5aVZiMnNMektUU3dO?=
 =?utf-8?B?blg2NVhDYnBrbTJ5SVY2SklLaCtoYVlXVkpTeTducEVSdGx1SGVMcmZyNHpQ?=
 =?utf-8?B?eGxnS1h4NmFXNDd0S091dWZaakoxZUJZaUY2QXJwWXRYVXFjdjBnSjgySXFX?=
 =?utf-8?B?RU1qN3pPQitZNXFCekZaeGY3Y0FXdHpLc1U4UXVSczdFb04yMmRtTC91cEd4?=
 =?utf-8?B?dG5KYmd0STZvZXFiTEV4Y2VWdk1iV0w1bkdmS21tNmM4ZUVkaWdqN20xNWEw?=
 =?utf-8?B?bElvWDlpTDFzMmUyU0xkNU5FTUR0WEhqVHFtamlwWGVsWktWTkJBZTRJc2pp?=
 =?utf-8?B?dG5xYlpPVUFJaVNqam93QlJDQzZUdnpRanNQUlNuSUJ0aVB6bnFJZmUrMlFC?=
 =?utf-8?B?Rk1naVY4YnoyZHpTRU5Kdmxmb3hzcXl6YWhDdndRckVPb2NtcDRJNnF2a1ZI?=
 =?utf-8?B?ekRGSzJKenVGbGlpeFZlQmR5WkVETEF3Zlg3SVBXakNGb2p2Q2FmM3pyd3V0?=
 =?utf-8?B?UjcreW0wVVY3WmJocGpmeWlTZmIxMW5FUXRjYmdlL2drMGt2ZmRDdnlLczJO?=
 =?utf-8?B?QmRHZUdkS1RWNTJSL0Q4Q0orSENmb1VnMW82a1NXS3ZHMVBlK2Q1QmxUdjR0?=
 =?utf-8?B?V3lJdjlPVjl2QVNRMHFxK2kzalFJWElFZTY5ZnVkRitqN01lNy9LRUJaTlM5?=
 =?utf-8?B?aVMwOU91a1d6Z1VTTWpFY2pyc2FreDg2MFpFNXlpeUhZTG9pZnovZUw0cW5B?=
 =?utf-8?B?VDZVMmFHL1owUkZUdTFwNHBsMVlnbkFxK1ZodkJER3NVRllYL09aWm9lb3E5?=
 =?utf-8?B?QTB1NU90UlVqVmVZRHNaS0NqSTh2QXVZMVhPaDFwMnpFV3l6QUprSVExby93?=
 =?utf-8?B?aE1URzZOK1JCQjhTTXF3ckdpSDlzeUJjOTJFUmFkdlhNbkJWcld3bHhpMlNr?=
 =?utf-8?B?dUdXV2d0RVIyUkFReWNUNVFtd0lsZnZQNWtqaVJ6R2NuOE0vc0FIL1ZrM3Rl?=
 =?utf-8?B?N2tyTnZzb0NHV0NiSExnMUJER3VlMlBoNkNHU2l3U1k1aDFlZDNvcENPa2hR?=
 =?utf-8?B?aFlXWGhwNkh0Qzh6dW5JVElUYmFrZWZCS3NHZTZGZjZ1S0Mya3RuTlNCa3dN?=
 =?utf-8?Q?2xJ/QeCg/pdJpsNuyQSNBB4z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ab14a1-627e-414c-6184-08daa11fdb85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 07:05:42.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGPy4CEwMSHjbYEZaoG6AtmWZK3ddOe4Qz9mubnSIEfT2XGUHpSJfxcsEpqcp0Hm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/28/2022 2:10 AM, Alex Deucher wrote:
> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
> <shashank.sharma@amd.com> wrote:
>>
>>
>>
>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>> Hello Felix,
>>>>
>>>> Thank for the review comments.
>>>>
>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>> compute mode, while submitting compute workload.
>>>>>>>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>
>>>>>> Feel free to add my acked-by, but Felix should probably take a look
>>>>>> as well.
>>>>>
>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>> about the interaction of compute with graphics or multiple graphics
>>>>> contexts submitting work concurrently. They would constantly override
>>>>> or disable each other's workload hints.
>>>>>
>>>>> For example, you have an amdgpu_ctx with
>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>> process that also wants the compute profile. Those could be different
>>>>> processes belonging to different users. Say, KFD enables the compute
>>>>> profile first. Then the graphics context submits a job. At the start
>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>> disables the compute profile for everyone, including KFD. That's
>>>>> unexpected.
>>>>>
>>>>
>>>> In this case, it will not disable the compute profile, as the
>>>> reference counter will not be zero. The reset_profile() will only act
>>>> if the reference counter is 0.
>>>
>>> OK, I missed the reference counter.
>>>
>>>
>>>>
>>>> But I would be happy to get any inputs about a policy which can be
>>>> more sustainable and gets better outputs, for example:
>>>> - should we not allow a profile change, if a PP mode is already
>>>> applied and keep it Early bird basis ?
>>>>
>>>> For example: Policy A
>>>> - Job A sets the profile to compute
>>>> - Job B tries to set profile to 3D, but we do not allow it as job A is
>>>> not finished it yet.
>>>>
>>>> Or Policy B: Current one
>>>> - Job A sets the profile to compute
>>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
>>>> in PP 3D
>>>> - Job B finishes, but does not reset PP as reference count is not zero
>>>> due to compute
>>>> - Job  A finishes, profile reset to NONE
>>>
>>> I think this won't work. As I understand it, the
>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>> profiles. Disabling the 3D profile doesn't disable the compute profile
>>> at the same time. I think you'll need one refcount per profile.
>>>
>>> Regards,
>>>     Felix
>>
>> Thanks, This is exactly what I was looking for, I think Alex's initial
>> idea was around it, but I was under the assumption that there is only
>> one HW profile in SMU which keeps on getting overwritten. This can solve
>> our problems, as I can create an array of reference counters, and will
>> disable only the profile whose reference counter goes 0.
> 
> It's been a while since I paged any of this code into my head, but I
> believe the actual workload message in the SMU is a mask where you can
> specify multiple workload types at the same time and the SMU will
> arbitrate between them internally.  E.g., the most aggressive one will
> be selected out of the ones specified.  I think in the driver we just
> set one bit at a time using the current interface.

Yes, this is how it works today. Only one profile is set at a time and 
so setting another one will overwrite the current driver preference.

I think the current expectation of usage is from a system settings 
perspective like Gaming Mode (Full screen 3D) or Cinematic mode (Video) 
etc. This is also set through sysfs and there is also a Custom mode. 
It's not used in the sense of a per-job setting.

   It might be better
> to change the interface and just ref count the hint types and then
> when we call the set function look at the ref counts for each hint
> type and set the mask as appropriate.
> 
This means a pm subsytem level change and the ref counts need to be kept 
in pm layer to account for changes through sysfs or APIs.

Thanks,
Lijo

> Alex
> 
> 
>>
>> - Shashank
>>
>>>
>>>
>>>>
>>>>
>>>> Or anything else ?
>>>>
>>>> REgards
>>>> Shashank
>>>>
>>>>
>>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
>>>>> disables the VIDEO profile. But context2 still has a job on the other
>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>
>>>>> Regards,
>>>>>     Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>    #include "amdgpu_umc.h"
>>>>>>>    #include "amdgpu_reset.h"
>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>      /* Total memory size in system memory and all GPU VRAM. Used to
>>>>>>>     * estimate worst case amount of memory to reserve for page tables
>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>      void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev,
>>>>>>> bool idle)
>>>>>>>    {
>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>> -                    !idle);
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    if (idle)
>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>> +    else
>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>> +
>>>>>>> +    if (ret)
>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>> compute mode\n",
>>>>>>> +             idle ? "reset" : "set");
>>>>>>>    }
>>>>>>>      bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
>>>>>>> vmid)
>>>>>>
