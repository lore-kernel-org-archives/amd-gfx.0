Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AAAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 20:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C1310E26B;
	Thu, 14 Dec 2023 20:04:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1E10E26B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 20:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYKd8n/0SKybYSMRVODtElbKPifzh7bl9FVIwAKnP2ZccJJuxqkGWC8hgHH5fcyTXLyQOy+N9b16vJ34bUS1lI9LISmAab4qGO5kBmdbD+9CjlkvmM87kmTo3SL7lOyqadi+ReUb1n6dP9NUWHnAmPNtM7tPohIRdDsq7xAgiqMWreYi5cVcXVKy7S5jgvk5A6B1FuMEgHip2hzilfmx6KJQnrtnOOkrFpr+9vnh2BTcshk28/CI5HoI+MK/yzbFF2qBF4BsN8I9dgx6H7Re/6Duz5FjYUOkf/I3qcVQXktau8a3SlHB+oKcQP6fLk/FypawUzJYL0OnPI1mZyVVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz2dEJ7WuD/nYZE9T3gw+GfGbIye+fq89U6H9o1IMH0=;
 b=KDoi2HQ2gtAKdNrNw/3bTSHCQ+YBjjEQyFfcNt30REsRjBxMuObLuIqmbV33V6+cP0JiobnMlz1wJ1X3yNdYdShutBH7IVEaRIriwX6mCcKlOxGL5Rsi326K6PFALhZsWEighR+fVbhDUzZmtzPe9tyiyu1Y9WATm9xCPqssq8iszLpSt/MMU6Gg1K9rRAGLPrvlir0jy/p1jsr5u1AvGIMebVR1iV8ltCJjfytRyAU4xHmC10thNhqhT9zyl8BKbs3SMPTtXpIlZcFXBvPxOISifQuIQ535aIta270BH/z7jJBJLoSVV4O2m8+WeDtymIIjObdm5IZ+JHl+hRcWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz2dEJ7WuD/nYZE9T3gw+GfGbIye+fq89U6H9o1IMH0=;
 b=1ylq8koey/Yj0ysCzmgWw/vS9KbjiD0/hgmLgTsNfvhNA5xLzeTgGwgQQgn1KB38p6589+RYA2sdz6jphUYZdudSTt3H3JGiSStTuhsXfQjDO8kRbCHodEVhkDM6Qo8viBd6SuIhXSDdwFh/K6s3po1CnUIpmEtae0HKPpA1vOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 20:04:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 20:04:03 +0000
Message-ID: <bf428c35-52df-47d6-9486-a44d3202d269@amd.com>
Date: Thu, 14 Dec 2023 15:04:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
 <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
 <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
 <aacee34d-a62a-4af6-8fb8-de981e1dfc9c@gmail.com>
 <CH0PR12MB537285E50B5A53BA1048FCD0F48CA@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_OW=aAHrhi6Zwc4OGtLthYh3NKw2Gq-CppBtYJUE-ybEA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CADnq5_OW=aAHrhi6Zwc4OGtLthYh3NKw2Gq-CppBtYJUE-ybEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: a85c95ab-3162-4af7-7437-08dbfcdfd1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Onn0EKW6+YB1sHyUW29ADP0GDo9Xxu6BgxuirS5u6FA+bmXKCJVD7xogoRf6eCiFnCTK6YY8fjv5wTH/gFUhrzHXKXlzcJO9Fvq9g0is+7V8W8mKupBXu8vEBOKIjAE2vWDsKvK2ZdTROlFwiKzsCg7rxpAAxl+j58rav+5DUlx9gjClibtn15U5ae3dYhbTH7DKfXgIz9kyQonQf3XRlr4sN0kHuHizt7Bl8rYLLD8c17RzRrJ/pq3SR8ARvu53DmB+V9NVJWY+1XF5xQstRC/Q6U5leZ0Wcm+M11H0DgpTu1bjYtL5KNbrVP2B6UoWvbbbdvlN+lQY5rD7z9dO7oDndZZrvpaXDM3m7cbzH9ELmA3hp7zas/9Tscnt4Wg8UqESXZMgSfEgqXMg9ffcZxJP/+1wtKAyt3nxQo0mrqBXNkjfMbxq9d/t+WJjreW4w7ITZJrPdmPM7rVn8DwBsLGSPRWahsl3FLGRFQYNFdfUiNm4LxlmFsTOSzocac1DyF19k6zYwF9MejcQxj9zVbrfVludFamVDU6i3HgucV5pAzDAfyQqid+QyUdjyKzVL5m4YwBO0cUUY8D9jD1Gc0dyKSBbmIDSwDcL86S4FLiCSL7MxQC5crPIRNABugN4WC8gJZS+/bdrENgBUo8zhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(26005)(36916002)(66574015)(6506007)(2616005)(36756003)(31696002)(86362001)(38100700002)(5660300002)(83380400001)(44832011)(6512007)(53546011)(316002)(66946007)(6916009)(8676002)(6486002)(8936002)(66556008)(66476007)(4001150100001)(30864003)(41300700001)(2906002)(966005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2s4RGpHYUY0TzQ0YlNGaUFBblNyOGZVK21kQjJmeFB1cXRscGZhNWVOUng5?=
 =?utf-8?B?SWFxeFNPZlloY3A0bjlSNlhkV2tQTUYwR0lrOTUrQ3JWRjF2MGIvSlY3SWRY?=
 =?utf-8?B?Y0Rubks3bzNnbTY4UHlpejF0ZGw1K1Y3RWtjcVFZUmlUUVJCUk40RGVrSlNF?=
 =?utf-8?B?QWtwZXpzbXFXN0VSczY3ZmtZcVhBS3RpTmpUajhTalpEdVpTaTJnQ3hKaCt3?=
 =?utf-8?B?QW9ZNEpicDJ6dVVzcnhLNDRVaytKYjg4S1BUTHd1cDBIQXgrQ043eFN4UEk4?=
 =?utf-8?B?M1V4YmRia3pLQjZlaDJjbCtycjR0MjQ1UDlHWHkwZTk1SUpTZ3Q5bVl6eXRk?=
 =?utf-8?B?SVM3aXBkc1VlNU1IZC83bnFNUTFEOTdQWjlVSm9vcFAydERvcHk5eHZhSnRJ?=
 =?utf-8?B?SUlOSlo1Y2xrLzVhSlVSL0FIeWRXUklYRWhlUmJuN2pGYnlFQlR1T2VOajdP?=
 =?utf-8?B?bVFHck1rWU0zNk9VbGRyWiswVWdvek5Ea3JOOW9Tajc3NWR3T2NrakVaZjVx?=
 =?utf-8?B?Sk9xUDBWc0h2dEVsRnI4ZzNsTHdDcWNsZ3V0YUE3M0xIaXFEZitobzdzWHA1?=
 =?utf-8?B?YkUyRUQ3bTBGUFRSZ0tDK0dnd2FLeHNSNVhkSzgvakFFOXRxdGJkSkdFTWs1?=
 =?utf-8?B?Q1d6WStWblNHZ0I4YnhlTU9BRExINDMyemdqZFhpTnlyeVF3a3lBVHBweStW?=
 =?utf-8?B?bFJwZVZjWklCdDM4NVFlcGF4c3JvdHNsRENMek1BckdTU0t4QUpJa2RLcm93?=
 =?utf-8?B?dTd3NERSbTArVmIrTWthNllic1JLelRvWmtubHBIODVoTElaZGEwMWUyK3hm?=
 =?utf-8?B?NWpHc3BHODh5SExaeW9MZUd0ZHJlS244QkVJQ0kvd3l5Y3JpRThRZlpwUkpa?=
 =?utf-8?B?SUs1V0pxWEJoYTkwMDlTdkgyZlBCQzNWKzVTNjVkUENFdjNtN1c3N3NNYVc1?=
 =?utf-8?B?NnJHVG1iVjYzVEdQNEcvWUdTMThBYTN6ZVNMTnZDdmJLaWpRR055d21GbEFH?=
 =?utf-8?B?VW9zeDZPR2FRWHUxWGI4d2hYK2c3eVJZbU9QOUZBVGp2bkNXZUNXQ0ZwN1VO?=
 =?utf-8?B?SXlkMmxlUU9jQiswazV0T0g1c3Vob2lJdFBHcnJveXJ5aHFxdXhOQXVaMXA0?=
 =?utf-8?B?am9qcjkxVDlIUGZhdjFiMWozOGlNZnJQREpXN2pxVXpwSkF3Vi9SKzJYYzQx?=
 =?utf-8?B?YkUvaFlsdmVLeWlvV0pldStIclZaUVZWV1I5TDZMVDJlUm5qamwwempta2VO?=
 =?utf-8?B?amw4VVJ3YWFaVjc2ZEV1TVYvckQ1YW5FYmpWOGhTUE5uSXVDNk5tNzIwT2xm?=
 =?utf-8?B?QmhmbU96ZVJvSGhLdHFPTWVZMStFMzRLZGc5a0w2ZUFyRmpSMUx1bWpsSERK?=
 =?utf-8?B?RlV3L1RFS3ViYVNKSjdQbExtSWx5Z2diWXptVFVGK1B0LzhCaGhody8wM2xU?=
 =?utf-8?B?bUw1TTY0ODNydTYwUGNXWVBNQnNwV2JZMmNXUHdYN0syekNZZlkyRktxb2l1?=
 =?utf-8?B?Mnp5eXFZc1l5c3kvVldPREk2Rm9kdy96Nk42UEhUMERlRFN4L0lqM0JKdUsx?=
 =?utf-8?B?dTFBODVOREdpdDFVb0NIYzhaUXBTRVl0MlYrL1BCZlQ2NjJMZytRS3RGRkZE?=
 =?utf-8?B?QWlsRzdvV24xR2EzSWJEOGNCVFFHOUJIV3pGSm9BMFhDTnZ5MXNLd0UxcEpD?=
 =?utf-8?B?dWVtaWZTeXVDNW5QM0FEQnljMGZGcGZ5WG9kcVhobmkzbFdpQzdwKzV3anA4?=
 =?utf-8?B?dlJYOVpKTTIwT2NoSHNKZWROK0ZqR3dacytKZ3g0Y2lxQ20xSkVmZkwxVFZz?=
 =?utf-8?B?cWtrSERzK0NmMDdvOEsycVp6OEtWVk1UZFhSeG9FbVNMWFJxSE9RVVMxVms5?=
 =?utf-8?B?Rk4zZ3pOZk5pZCtFMytTMnQzVGVaZXloS05RYWRJcUk2amlGMjdDaWUzVXl1?=
 =?utf-8?B?RVJZNkluazg5S0RkWHd4T1FZTkRENHZNV0I0L3hmK3MyNnU5K0ExWFczdHJm?=
 =?utf-8?B?L0hya2lvcjRUN2JPajA4WUQvbFp4R1A4K1FNYkZoZEFLVUl1RmRvSUFWMmZD?=
 =?utf-8?B?SVhBOWQvR0lGVUthY3UxQjdncHFsTHJrcjBkNDd1QWNXbU9NM1lpY1lsTERo?=
 =?utf-8?Q?ePNZLA66oKEZbxaUMUzv9dSkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85c95ab-3162-4af7-7437-08dbfcdfd1c6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 20:04:03.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyVGxNbxm6Z/SkYruYo2hhiZefqo70uyU4Mn26398H8XKh8c77TnNvRYsTUJ2apmsl/cWos1nmKZlEoyGFdAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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


On 2023-12-14 10:06, Alex Deucher wrote:
> On Thu, Dec 14, 2023 at 9:24 AM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> The gmc flush tlb function is used on both  baremetal and sriov.   But the  function  amdgpu_virt_kiq_reg_write_reg_wait is defined in amdgpu_virt.c with  name  'virt'  make it appear as a SRIOV only function, this sounds confusion . Will it make more sense to move the function out of amdgpu_virt.c file and  rename it as amdgpu_kig_reg_write_reg_wait ?
>>
>> Another thing I'm not sure is inside amdgpu_virt_kiq_reg_write_reg_wait , has below logic :
>>          if (adev->mes.ring.sched.ready) {
>>                  amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
>>                                                ref, mask);
>>                  return;
>>          }
>> On MES enabled situation , it will always call to mes queue to do the register write and  wait .  Shouldn't this OP been directly send to kiq itself ?  The ring for kiq and  mes is different ,  driver should use kiq(adev->gfx.kiq[0].ring) for these register read/write or wait operation  and  mes ( adev->mes.ring) for add/remove queues  etc.
>>
> I understand why it is needed for SR-IOV.  Is there a reason to use
> the MES or KIQ for TLB invalidation rather than the register method on
> bare metal?  It looks like the register method is never used anymore.
>   Seems like we should either, make the KIQ/MES method SR-IOV only, or
> drop the register method and just always use KIQ/MES.

It can be useful as a fallback or workaround for FW issues. We also use 
it when running without HWS (amdgpu.sched_policy=2). This is not the 
production code path, but can be useful for triaging on GPUs without MES.

Regards,
   Felix


>
> Alex
>
>
>> Regards
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
>> Sent: Thursday, December 14, 2023 4:22 AM
>> To: Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; stable@vger.kernel.org
>> Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to flush TLB
>>
>> Am 13.12.23 um 20:44 schrieb Alex Deucher:
>>> On Wed, Dec 13, 2023 at 2:32 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> On 12/13/2023 13:12, Mario Limonciello wrote:
>>>>> On 12/13/2023 13:07, Alex Deucher wrote:
>>>>>> On Wed, Dec 13, 2023 at 1:00 PM Mario Limonciello
>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
>>>>>>> causes the first MES packet after resume to fail. This packet is
>>>>>>> used to flush the TLB when GART is enabled.
>>>>>>>
>>>>>>> This issue is fixed in newer firmware, but as OEMs may not roll
>>>>>>> this out to the field, introduce a workaround that will retry the
>>>>>>> flush when detecting running on an older firmware and decrease
>>>>>>> relevant error messages to debug while workaround is in use.
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>>>> Cc: Tim Huang <Tim.Huang@amd.com>
>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>>>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>>>>>>>     4 files changed, 32 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>>> index 9ddbf1494326..6ce3f6e6b6de 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            }
>>>>>>>
>>>>>>>            r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>>>>>>> -       if (r)
>>>>>>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
>>>>>>> +       if (r) {
>>>>>>> +               const char *msg = "failed to
>>>>>>> + reg_write_reg_wait\n";
>>>>>>> +
>>>>>>> +               if (adev->mes.suspend_workaround)
>>>>>>> +                       DRM_DEBUG(msg);
>>>>>>> +               else
>>>>>>> +                       DRM_ERROR(msg);
>>>>>>> +       }
>>>>>>>
>>>>>>>     error:
>>>>>>>            return r;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>>> index a27b424ffe00..90f2bba3b12b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>>>>>>>
>>>>>>>            /* ip specific functions */
>>>>>>>            const struct amdgpu_mes_funcs   *funcs;
>>>>>>> +
>>>>>>> +       bool                            suspend_workaround;
>>>>>>>     };
>>>>>>>
>>>>>>>     struct amdgpu_mes_process {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>>> index 23d7b548d13f..e810c7bb3156 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct
>>>>>>> amdgpu_device *adev)
>>>>>>>                    false : true;
>>>>>>>
>>>>>>>            adev->mmhub.funcs->set_fault_enable_default(adev, value);
>>>>>>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>>>> +
>>>>>>> +       do {
>>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>>>> +               adev->mes.suspend_workaround = false;
>>>>>>> +       } while (adev->mes.suspend_workaround);
>>>>>> Shouldn't this be something like:
>>>>>>
>>>>>>> +       do {
>>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>>>> +               adev->mes.suspend_workaround = false;
>>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>>>> +       } while (adev->mes.suspend_workaround);
>>>>>> If we actually need the flush.  Maybe a better approach would be to
>>>>>> check if we are in s0ix in
>>>>> Ah you're right; I had shifted this around to keep less stateful
>>>>> variables and push them up the stack from when I first made it and
>>>>> that logic is wrong now.
>>>>>
>>>>> I don't think the one you suggested is right either; it's going to
>>>>> apply twice on ASICs that only need it once.
>>>>>
>>>>> I guess pending on what Christian comments on below I'll respin to
>>>>> logic that only calls twice on resume for these ASICs.
>>>> One more comment.  Tim and I both did an experiment for this
>>>> (skipping the flush) separately.  The problem isn't the flush itself,
>>>> rather it's the first MES packet after exiting GFXOFF.
>> Well that's an ugly one. Can that happen every time GFXOFF kicks in?
>>
>>>> So it seems that it pushes off the issue to the next thing which is a
>>>> ring buffer test:
>>>>
>>>> [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on
>>>> comp_1.0.0 (-110).
>>>> [drm:process_one_work] *ERROR* ib ring test failed (-110).
>>>>
>>>> So maybe a better workaround is a "dummy" command that is only sent
>>>> for the broken firmware that we don't care about the outcome and discard errors.
>>>>
>>>> Then the workaround doesn't need to get as entangled with correct flow.
>>> Yeah. Something like that seems cleaner.  Just a question of where to
>>> put it since we skip GC and MES for s0ix.  Probably somewhere in
>>> gmc_v11_0_resume() before gmc_v11_0_gart_enable().  Maybe add a new
>>> mes callback.
>> Please try to keep it completely outside of the TLB invalidation and VM flush handling.
>>
>> Regards,
>> Christian.
>>
>>> Alex
>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
>>>>>> index 23d7b548d13f..bd6d9953a80e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
>>>>>> amdgpu_device *adev, uint32_t vmid,
>>>>>>             * Directly use kiq to do the vm invalidation instead
>>>>>>             */
>>>>>>            if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>>>> adev->mes.ring.sched.ready) &&
>>>>>> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>>>>> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
>>>>>> +           !adev->in_s0ix) {
>>>>>>                    amdgpu_virt_kiq_reg_write_reg_wait(adev, req,
>>>>>> ack, inv_req,
>>>>>>                                    1 << vmid, GET_INST(GC, 0));
>>>>>>                    return;
>>>>>>
>>>>>> @Christian Koenig is this logic correct?
>>>>>>
>>>>>>            /* For SRIOV run time, driver shouldn't access the
>>>>>> register through MMIO
>>>>>>             * Directly use kiq to do the vm invalidation instead
>>>>>>             */
>>>>>>            if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>>>> adev->mes.ring.sched.ready) &&
>>>>>>                (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>>>>>                    amdgpu_virt_kiq_reg_write_reg_wait(adev, req,
>>>>>> ack, inv_req,
>>>>>>                                    1 << vmid, GET_INST(GC, 0));
>>>>>>                    return;
>>>>>>            }
>>>>>>
>>>>>> We basically always use the MES with that logic.  If that is the
>>>>>> case, we should just drop the rest of that function.  Shouldn't we
>>>>>> only use KIQ or MES for SR-IOV?  gmc v10 has similar logic which
>>>>>> also seems wrong.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>>>>            DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>>>                     (unsigned int)(adev->gmc.gart_size >> 20), @@
>>>>>>> -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>>>>>>>            int r;
>>>>>>>            struct amdgpu_device *adev = (struct amdgpu_device
>>>>>>> *)handle;
>>>>>>>
>>>>>>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>>>>>> +       case IP_VERSION(13, 0, 4):
>>>>>>> +       case IP_VERSION(13, 0, 11):
>>>>>>> +               /* avoid problems with first TLB flush after resume */
>>>>>>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
>>>>>>> +                       adev->mes.suspend_workaround = adev->in_s0ix;
>>>>>>> +               break;
>>>>>>> +       default:
>>>>>>> +               break;
>>>>>>> +       }
>>>>>>> +
>>>>>>>            r = gmc_v11_0_hw_init(adev);
>>>>>>>            if (r)
>>>>>>>                    return r;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>>> index 4dfec56e1b7f..84ab8c611e5e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>>> @@ -137,8 +137,12 @@ static int
>>>>>>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>>>>>            r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>>>>>>                          timeout);
>>>>>>>            if (r < 1) {
>>>>>>> -               DRM_ERROR("MES failed to response msg=%d\n",
>>>>>>> -                         x_pkt->header.opcode);
>>>>>>> +               if (mes->suspend_workaround)
>>>>>>> +                       DRM_DEBUG("MES failed to response msg=%d\n",
>>>>>>> +                                 x_pkt->header.opcode);
>>>>>>> +               else
>>>>>>> +                       DRM_ERROR("MES failed to response msg=%d\n",
>>>>>>> +                                 x_pkt->header.opcode);
>>>>>>>
>>>>>>>                    while (halt_if_hws_hang)
>>>>>>>                            schedule();
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
