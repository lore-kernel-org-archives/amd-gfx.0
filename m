Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DEEC7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 07:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450E410EAFB;
	Thu,  6 Apr 2023 07:45:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C0310EAFB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 07:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpk6QMfYT3V+02rJ7emKru4P5/QGCCw+w2eBcx9JTw6ei6ljVsAJ/x16APRP48sClIS4ULAfPac6fVR4hXfRlXvwawRTpPxmMFVNt0j1Je3AacBZvUroWQmVKlwamiW5Q2tqKNTO4jdBognXRYKYVWB3NbzupLgd5zLBcRTZA8FXJBTbpz+ZJCLnMJFSPuiGbpN7I2/howEk4NrA0IW+WuZkJ7aSOVsYclD4TbVEsykkiOQHfugRUjncVTs25qJS/Mohv5EElIVSA4GWX206uJNj6JAa9YRGl6ZCFZYauGOL302BS6hog54yj41pE2yIL0FwguL66+zmL+X5MH3xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzL/owYmcLvyG/wg+95lmNY+C1MhbFCx7GDwn6QXgVU=;
 b=Q12FJ4/NH3HrBDM+Z8r5wOl1dzZFqS/7QY1J1+Ebkhs2Yqos4IaiFobHemMG0dy3ApFRr3Az1lI7plwEtW7uZ9tYlfTcwblsfRvSzCMM24YdOQ16nTXagjea24WKwm2mBfQdNv/uSLDrHcqubfSnKaqcGbRpv+KCVbCe/5ueFbR+vQ9OZeP9/ccfcTKtF58fGPcmEM8U58wwkgheOR4rb81z38TZZB/3/GqANdQmiFPkfkEzphhFI36C8nAuyGdbAMfBVQQJTg3w9EtXAFjF09pMRMAn+9Eo5gJ2RDSIVnMIh6QxH9JWgDFIVlGJ6kezj29Y5TRtDoNp4nWL+tIYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzL/owYmcLvyG/wg+95lmNY+C1MhbFCx7GDwn6QXgVU=;
 b=f+VNQNTnKTAibjGfuTOK0A627PUI4K4xQt/afQgupdkiCHFTZh8sJkPGIe2niGNwC6PTWYIHxg1joc52ulcRuszKNdvLoVkyEJT4kNBapheDnEjMPMqeN60ZpzlfXk2WOmTQhHgbosLaJbCcrjyu2HNFx+lJqW+6knpnj5F7JuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 07:45:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 07:45:10 +0000
Message-ID: <f4f3f3dd-f8a2-6bbf-b241-ed29aa95bed4@amd.com>
Date: Thu, 6 Apr 2023 09:45:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
 <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
 <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
 <bfbfab82-ca0b-d70a-86a6-6a72301beaa2@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <bfbfab82-ca0b-d70a-86a6-6a72301beaa2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: cd75f668-17fb-4ee9-8eb7-08db3672d93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvLhU/+ICGoNxhRyQQGQ1D6KkKkgcK90ATqbW3ymKtSL/Gh/U8/tdEos2IjKF6/u57jkjqx6egZLtkJyVI+GOa1Bi2m2srVHyKC4NDxSpf3A5JQFO+aQ6In9dNpAOuvk9Z4AQvSbPtV/7RJvAajEqu79NQNPO3UfQ5+fcWHLKXMOqJwqDZ4CC3BqR2jic4Vh3kzeKYv7+f0WDamfwwK2BnKN29JNP4aS4SyH3CzEXarZuoZHtZWvWLdKAH5IBMACXB71fcpUu/lJ/CrCeQmHDx25nsPro8lhPXWVy3vTmA2xbE8tDQXhIU+rkiggo1TuVpshmNaYD6QqzUwpVvxtCXnk8C0RTU+fGtrgrywo2LJ6GQn9fczROTvwdPRm5aPSlTSRFvwlQiS5syzhd3msRKQUkub58tBqqaTDXM/vHRZuPbjFr6iy0AVYgcvkolZ2uz0jGi84AnWCZMd3fYtKYkcCl/Wn5s+RX1c3Khlnt1fP1p0HT6W0pa5+ayxyhN2WfkD7VkSUKkljfQrYTHPDCjI4IuGBDR7C8YomKzfweG7oLv9XPkFsNdbH7RJCSlvFrdpb4PdgwSsJJsjM3yu5PNlW13+tVJRTJnV9bNLqltvwqlWXoOWdTAf3yT7FeoUxeMtMtqntU1PGARWZQjmTvTWpjkCDuglwtMoDBDbOvC1we/+1uGQbrgdNBPFDE689
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(30864003)(44832011)(54906003)(36756003)(8936002)(5660300002)(38100700002)(2616005)(6512007)(6506007)(53546011)(66946007)(4326008)(2906002)(186003)(31696002)(8676002)(66556008)(86362001)(66476007)(966005)(6486002)(83380400001)(66574015)(6666004)(31686004)(41300700001)(26005)(316002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9iZVQ3TEY4cER5clVlbHBIWUcxdEg1dXM4K1U1cSsxSVV0anBhS08yVHVW?=
 =?utf-8?B?dDlMMU5PMkVzNVhhOGcrK3hvOWdxV3lySHRtSTBkdm8zdDNYZWlVUU1VRHc1?=
 =?utf-8?B?K0NzZUhlMGYyUXpoaVV1aEVlVkE5LzJNRW5pazF6Z3laQjlpL3FFR2VPdVBp?=
 =?utf-8?B?UjhBZG5kM3l4Q2R2b0pTTTVvYVdkSVo5czBiMC9Bd3dqUHJQRFh6aXMrcWZx?=
 =?utf-8?B?MEVsTEcwNmhkOG5IODk5V3FDM0NDOGg5MVlqSUdYSVpQakVGZlEvYXRmMHhs?=
 =?utf-8?B?cS94VVE4M2E4V3d1dVQ1ak5uRVlWVko3dWs0UVlXSytFWEJpQVBwNWFwelpj?=
 =?utf-8?B?OGhQS1ZjTFErei9HOEdqMmdQaEhSWG1JL1F0eWxMdUpQODhMaXYyS1lyTGcw?=
 =?utf-8?B?c29pM25NNGw3eEg0RkUyMXQ5Zm40R2ZYL3F5YnBpVnZYbjRjbFVRUGw0L1VV?=
 =?utf-8?B?SVZGL25TcWcyaTc5NHJaMFJDSld6REIzMU9QMzBIOXFSelRab0c5VGFkbWxL?=
 =?utf-8?B?by9CTEFWcGtraFZPakR4RGtqOG5BdlFRalcyb09QVEFiNCtiSUR3eFdpQTZa?=
 =?utf-8?B?ZnF1VFo1TCtGUEM4NUh3bDFyc09TRm1NeEo4dGtaTUp4Z1Y5NmlmQ2lMdGxK?=
 =?utf-8?B?Y1hsNE9UWEJyZTBOOGloVVVKdzIxd0xNUzBBM0tYVGI3MHRtNUt3SjgraE1K?=
 =?utf-8?B?T3N6TDdRNVYrdThreWNYdlliWURIOHE3ZzVrekJYYXQvalNoUmlocEVaY2pS?=
 =?utf-8?B?UVNUU2tOMHlIbHdQdEdlSEs1SVIxaTFpbjR5SHI2dmovMmVZSUVmemFtTEpQ?=
 =?utf-8?B?SWVpdVZWalQrZFFvOEJHVURCNlBPNmhxazFKWTlpbmdxemZLcm9WNWFnVlZQ?=
 =?utf-8?B?WHY5anRUSDVpbmF5UWFSQkY2bUcxcFQ3cTI2Y1kyenVyaUpSQmRYeHRvRFFv?=
 =?utf-8?B?Q2hQR1c1U0EzWGZwSU9LeGp0ZHFaRm9NVUJQdTRYRjl1bEtPU2ZvQjVkZVk5?=
 =?utf-8?B?RlBIdVZYK2F3aVFrMzk4RTRVTWY4RkZNSW9BdHhiNGhTRHdsY1RLc0UzWmIw?=
 =?utf-8?B?NWZNbHNEeThLUFJvZHh6WVhQcWhoeElBSnBhdUpLUUJtZnhxQnVYT3pnSHJk?=
 =?utf-8?B?a2V1eDc5WG5sUTBSSXJhYndyNGdrU1FycjQweGFIbmMzRGdURTliR05jQk1y?=
 =?utf-8?B?WWp2andaM2hVbTBUYUFBT2FrM2cvRDI0eExKV3NGVkdOYjhBUTNQQVhjdVJ2?=
 =?utf-8?B?eExyenE4MFdrdnRKdURVMlBsYkM2NHR4WDkwOG1JSVhVSDRSdm8zUDNEaGRF?=
 =?utf-8?B?QmR4T3JqQndxUEswMWJkeG1xZitwNEFwY0hFbENEMyt6ZGNlcHFIVERSNlYz?=
 =?utf-8?B?bWV5R3lvMFMrSkRybFpidS8rSldxWnFIQ3M5c2d2UTV2S2luNUpIRDhOVU85?=
 =?utf-8?B?UTJMaXZxMS9QOUJtRXdJTVFWZ05mb0gvQmFWR05Nd2hRcVg4USs5VUtnWDVJ?=
 =?utf-8?B?QlBHOUcxbVM5SXBXMVNmd0hLV3FXNGNaV2M4WEFnck53ZGlMdm14NTZuRVF1?=
 =?utf-8?B?QUNKMC92clNrdFR0THdCMDBjdXJRcU01WXZqTHZocUIzQm9JQmh3V2tNWExG?=
 =?utf-8?B?Y0lqbGxleFp6VHJ4dUIwZ2tqVk83aEQrWnZJY2tRZUV2MGd2VSs4M1M1QmV1?=
 =?utf-8?B?OE56V0c3L2FyR1VGQ1JEODVYd2hlUTViMGthRUJtRlZHYW1jdWFzaEVwRW45?=
 =?utf-8?B?ZFExWHhsUTFGOXBRZ1BWZVNLLzFGOWMvQTIwdVVvMUhpVFdvQllxNklHUGxD?=
 =?utf-8?B?bTBXTTJQdlQ1MEVUdTFpeC80Qis2ZXBsb21aRkc3Sno1K3BMNFhnZjF5MEd3?=
 =?utf-8?B?bjUzbENkVENnMFhzK2UvZStDT0dpdGg0YVh1aEVSN1l5RXFEN3lUUmcyUHc0?=
 =?utf-8?B?dGEzTWdEZHh2eElQaXJnRS9wWThHa2lqRzFnNmZLU0tVTStzQVhGTHhqWDgr?=
 =?utf-8?B?N2poZW5IWCtDR05XSjFBMGU2a1NhYXRuYjhjc3crdWtHMHREcFFyUDV6TnFl?=
 =?utf-8?B?NDRvMXBJV00vQUpBeFFYYXFLazdDQ1RmZUYyWDBYdUJIek9Pa1pSbXNONllr?=
 =?utf-8?Q?RomAjJMXGR2CA00u2pep0qwi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd75f668-17fb-4ee9-8eb7-08db3672d93b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 07:45:10.4669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEgsw6vDhza3SZVMZbaMatPQS59M5aWH4XmCb17ikt/2RnBe6y7VJ2s3rcJOaXKXCwP0HwwEYDVc/2iEMpT29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 05/04/2023 23:18, Luben Tuikov wrote:
> On 2023-04-05 06:06, Shashank Sharma wrote:
>> On 04/04/2023 22:58, Luben Tuikov wrote:
>>> On 2023-04-04 12:36, Shashank Sharma wrote:
>>>> On 04/04/2023 18:30, Luben Tuikov wrote:
>>>>> On 2023-03-29 12:04, Shashank Sharma wrote:
>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>
>>>>>> This patch adds new functions to map/unmap a usermode queue into
>>>>>> the FW, using the MES ring. As soon as this mapping is done, the
>>>>>> queue would  be considered ready to accept the workload.
>>>>>>
>>>>>> V1: Addressed review comments from Alex on the RFC patch series
>>>>>>        - Map/Unmap should be IP specific.
>>>>>> V2:
>>>>>>        Addressed review comments from Christian:
>>>>>>        - Fix the wptr_mc_addr calculation (moved into another patch)
>>>>>>        Addressed review comments from Alex:
>>>>>>        - Do not add fptrs for map/unmap
>>>>>>
>>>>>> V3: Integration with doorbell manager
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>> Just add all your Cc right here, and let git-send-email figure it out.
>>>>> Between the Cc tags and the SMTP CC list, Felix is the only one missing.
>>>> No, that's not how it is.
>>>>
>>>> You keep people cc'ed in the cover letter so that they get informed
>>>> every time this patch is pushed/used on any opensource branch.
>>> The cover letter is optional, and you can add Cc tags
>>> into the cover letter and then git-send-email would extract those
>>> (any and all) tags from the cover letter too.
>>>
>>> When you pick and choose whom to add in the Cc tags, and whom to
>>> add to the SMTP CC list, it creates division.
>>
>> Exactly my point, there is no guideline on whom to add in Cc
>> cover-letter and whom to add manually, its all preference.
>>
>> Now different people can have different preference, and a review comment
>> on what is your preference of what to
>>
>> keep on cover letter does seem like a nitpick.
> I am describing consensus. Take a look at DRM commits to see what
> people do. It'd be nice if you followed that
No, not every DRM patch needs to be like that. I have added some 
examples below.
>>>> People who are added manually in cc are required for this code review
>>>> session.
>>> No such rule exists. It is best to add all the Cc into the commit message,
>>> so that it is preserved in Git history.
>> I believe this is also not a rule, we are discussing preferences only.
>> It is my preference that I want to keep only Alex and Christian in Cc.
>>> For instance, I just randomly did "git log drivers/gpu/drm/*.[hc]" in
>>> amd-staging-drm-next, and this is the first commit which came up,
>>>
>>> commit 097ee58f3ddf7d
>>> Author: Harry Wentland <harry.wentland@amd.com>
>>> Date:   Fri Jan 13 11:24:09 2023 -0500
>>>
>>>       drm/connector: print max_requested_bpc in state debugfs
>>>       
>>>       This is useful to understand the bpc defaults and
>>>       support of a driver.
>>>       
>>>       Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>>       Cc: Pekka Paalanen <ppaalanen@gmail.com>
>>>       Cc: Sebastian Wick <sebastian.wick@redhat.com>
>>>       Cc: Vitaly.Prosyak@amd.com
>>>       Cc: Uma Shankar <uma.shankar@intel.com>
>>>       Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>>       Cc: Joshua Ashton <joshua@froggi.es>
>>>       Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>>       Cc: dri-devel@lists.freedesktop.org
>>>       Cc: amd-gfx@lists.freedesktop.org
>>>       Reviewed-By: Joshua Ashton <joshua@froggi.es>
>>>       Link: https://patchwork.freedesktop.org/patch/msgid/20230113162428.33874-3-harry.wentland@amd.com
>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> As you can see the whole Cc list and the MLs are part of the Cc tags.
>>> And the rest of the commits are also good examples of how to do it.
>>> (Don't worry about the Link tag--it is automatically added by tools
>>> maintainers use, although some use Lore.)
>>> This preserves things in Git history, and it's a good thing if we need
>>> to data mine and brainstorm later on on patches, design, and so on.
>> No, this is not random, this is actually well planned. All of these
> I never said it is "random"--it is not, it is well planned because
> everyone submitting to DRM does this--it's common practice.
>> people here in Cc are either the maintainers or respective domain experts or
>>
>> contributors of color management feature and keeping them in CC is about
>> how this color management feature is being carried forward, so this is
>>
>> exactly aligned with my point. Do note that this is a DRM level change
>> (not AMDGPU level).
> So, then why isn't Felix in the Cc tags? Doorbell changes touch that area too.
> He's actually the only one you left out, other than the MLs emails.
> Either add everyone to the Cc tags in the commit message, or only add
> your Sob line and leave everyone to a --cc= on the command line. Both are
> common practice and acceptable.

This code touches KFD code, and that's why Felix needs to be involved in 
the code-review process. But

once code review is done, I don't want to spam his email every time this 
patch is pushed into some branch,

so he is not in cover-letter CC. This is how I prefer to drive the code 
review of this patch, and I don't see a problem here.


>> Also, I would like to express that in my opinion we are spending way too
>> much time in discussing the 'preferences' around cover letter,
> I agree. But those aren't "preferences," they are common practices,

This is not a common practice, its your interpretation of it.

I also picked a few examples:


https://patchwork.freedesktop.org/patch/531143/?series=116163&rev=1

This patch has multiple communities in Cc, none in cover-letter (also 
R-B'ed by you).


https://patchwork.freedesktop.org/patch/505571/

https://patchwork.freedesktop.org/patch/442410/

These are some of patches which has multiple people missing in the 
cover-letter CC than email-CC.


https://patchwork.freedesktop.org/patch/530652/?series=116055&rev=1

This patch has multiple people in email-cc but none in cover-letter CC.


There could be tons of such examples for both, and the maintainers do 
not have any problem with that,

So I don't consider this as common practice in DRM community, its just a 
preference, and hence it consumed

a lot more time and efforts in this discussion than what it should have.

- Shashank

> like for instance not separating the Cc tags and the Sob tags with
> an empty line, or shifting struct member names to the same column
> for readability, and so on. Use "git log -- drivers/gpu/drm".
>
> Regards,
> Luben
>
>> words, comments and variable names. No cover letter is perfect, no
>> commit message is good enough to explain what is happening in code,
>>
>> no variable name is flawless and no comment explains what is going on in
>> code which is clear to everyone. These are very subjective to the
>>
>> author and the reader. The only deciding factor is if there is a
>> community rule/guideline on that.
>>
>>
>> I appreciate your time and suggestions but I also certainly do not want
>> to spend this much time to discuss how should we add people in Cc.
>>
>> Let's keep preferences separate from code review process.
>>
>> - Shashank
>>
>>> A good tool to use is "scripts/get_maintainer.pl" which works
>>> on a file, directory and even patch files.
>>>
>>> I usually include everyone get_maintainer.pl prints, and on subsequent patch
>>> revisions, also people who have previously commented on the patchset, as they
>>> might be interested to follow up. It's a good thing to do.
>>>
>>> Here are a couple of resources, in addition to DRM commits in the tree,
>>> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
>>> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format
>>> (The second link includes links to more resources on good patch writing.)
>>>
>>> Hope this helps.
>>>
>>> Regards,
>>> Luben
>>>
>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>>     .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>>>>>>     1 file changed, 70 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>> index 39e90ea32fcb..1627641a4a4e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>> @@ -23,12 +23,73 @@
>>>>>>     #include "amdgpu.h"
>>>>>>     #include "amdgpu_userqueue.h"
>>>>>>     #include "v11_structs.h"
>>>>>> +#include "amdgpu_mes.h"
>>>>>>     
>>>>>>     #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>>>>     #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>>>>     #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>>>     #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>>>>     
>>>>>> +static int
>>>>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>>>>> +                         struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    struct mes_add_queue_input queue_input;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>>>> +
>>>>>> +    queue_input.process_va_start = 0;
>>>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>>>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>>>> +    queue_input.paging = false;
>>>>>> +
>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>>>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>> +
>>>>>> +    queue_input.process_id = queue->vm->pasid;
>>>>>> +    queue_input.queue_type = queue->queue_type;
>>>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>>>> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>>>> +
>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>>>> +                           struct amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>> +    struct mes_remove_queue_input queue_input;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>> +
>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>> +    if (r)
>>>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>>>> +}
>>>>>> +
>>>>>>     static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>                                                      struct amdgpu_usermode_queue *queue)
>>>>>>     {
>>>>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>>>>     
>>>>>>         amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>>>>         amdgpu_bo_unreserve(mqd->obj);
>>>>>> +
>>>>>> +    /* Map the queue in HW using MES ring */
>>>>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>>>> +        goto free_ctx;
>>>>>> +    }
>>>>>> +
>>>>>>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>>>>         return 0;
>>>>>>     
>>>>>> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>>>     {
>>>>>>         struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>>>     
>>>>>> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>>>>         amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>>>>         amdgpu_bo_free_kernel(&mqd->obj,
>>>>>>     			   &mqd->gpu_addr,
