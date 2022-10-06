Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DE1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 17:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C1510E844;
	Thu,  6 Oct 2022 17:21:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFE210E844
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 17:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjceg5B44lnmpqRiPEfqLa0BCkzBK6ZM1yFCtFhvhSc37EZX43CqJIvYFXfLlcwh4TNCQU0KppsEziXLa2ARw+gf/EOscvnLh9YjmKvCj1l5IpwSqn3IfPnTKtpLpuYO2aix9/haT3hW/cO6Ely5sEK8UC35nch1a8FM3JQYQfS8PBUY/8u1//mwR7NOOPry4mQyJc20KeDdM0oiw06J0TfSvnLILel6HsGRwowHf5TYdjwmuB0suIi13s5AVWvYavnPi7Aj65xxe8g3WTEhmOxqxepzeVMmpoqJMViQpDimoRG8nvd4mQ727LkdfMMP7MbFCviU228Q1E4BxaIdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOoOlGQRFXJ0Bw26oo2p1p8lsf6dXE6pHFWhz5VqZq0=;
 b=Xallb29hVeWQWau8uoe3IVahC8KUVNpPgokaf0ssihxr4BpzA4MoD4O5662LTL+1yvGkPQNOKyM58CpjpDo6YHGGWwIvFdT87mHB+tq6HRAOUyXPodvzb1pHU/bp4PSLY8DMv/Zhe9wCQwj92qVca0gO8YC6QNXWgQ6oAEG5PdbwS+tlofOgfcg5W3TkdoGU9hymwVbPPMet2WWJARhliLm+ImX2M01//rvnh/tYmZ0nazJ5Sz3lYOtuSAVYtxHMftSQq+1RnbMcmuCNOqEzquqAPKrMNPuQW64xhL3ApdHAKqCBaroQk+mGZ7XDW+w908vGca2daNCMZK57Ccysew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOoOlGQRFXJ0Bw26oo2p1p8lsf6dXE6pHFWhz5VqZq0=;
 b=L04OPCrgxHVYJXEDos2w6NE2w8/QjKO+p/A3k7wuQlqhHn8jGUez/TMsG+hHk1CB/pqTEa9U4FrbqqxabVQfgQmVPr8i2dohRNl4BZuMkRU4L1RHb1a/WwO2bTOqgINd/CdJMvDJnJZO1QWM4TY9bthP/iFe0qydS+15vxeXjl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 17:21:43 +0000
Received: from CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::d1e5:46f4:b532:aa7a]) by CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::d1e5:46f4:b532:aa7a%9]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 17:21:43 +0000
Message-ID: <dd02285a-8fc6-7951-30f8-1300ff3149f1@amd.com>
Date: Thu, 6 Oct 2022 13:21:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
To: "S, Shirish" <sshankar@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
 <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
 <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
 <8ac24a07-6255-3092-95af-40d3a0d3124f@amd.com>
 <38b74412-dc3a-37da-55dd-e2327fe59769@amd.com>
 <f840d24a-136a-81fb-1bd7-a0a75f6962e3@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <f840d24a-136a-81fb-1bd7-a0a75f6962e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::24) To CH0PR12MB5300.namprd12.prod.outlook.com
 (2603:10b6:610:d7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5300:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d2ca69-f341-459b-fd1b-08daa7bf3d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JARHSZyn/QvPMRszR/Elsh9inBt/3rwvVByVHmkEhjaqVQowkNacy3spoiVCqpugIqGvEuZwJ42z0Y8tqtmo/5wYpz1GW6hJAHzEpVT7iHLUyOM1UuYIzcph44aeuPwQoZN2FYv9mGPbZI/GBQXpZQvSYzxBOC+Pha6sEzFBr8NT6sLxMhfZJREFLOna7ll2AiV0jE00bLXVKa5kmRkUBjCUwjCn4N4LAsOiSU7gufFfPwW/g+IIJtQuj8+S5P1EYQwvwca3Jz9xxcVyvv+SKnFL9UPqKmDTlw+MQLQUyjo1v2SbdVTbOtpD8b/l2/zv80WmYiAxjvMPmcrcH4UYgTg1mQedVn53n0ZJDC39LF6lZZDaU2OuqhNGnagQH1pl2DpD3O9gWVghYMXfd4IWPc/QL5KLIvzi/qA7r9O9FsG50bsWM13H98cXjf0wjaNXKKhJJ9zVOsGJ+x7AHBOtvjUgY2TJM+HyVZQCcp7bSiVBjZ+g1DRM3XQXda7EX511mnslokix/bPp3NMN/pzNX9A7/eqWDPQqkIhTJTmL/PSCQ8+WlGKlZn9m/bQ4Tb5+m2oPIfIYGp+vqrVmzTgQXdWf0NGK73NVTDCqiheXcWpu03KKecBY3GQIJAHr9w+Ov6CDHQvHtfnFC/kjZkR/ACN6fR9KoFMDGpEZtjcS9Vjmg4zAL2KD2kCmP10BMzLcjelz4+BxJRvx46n/ZBXmMNSwS2Xxnmb0fy2wrRFwp+byrpdcd7TW+dCjd8J43n1oqKCamawGz5oxe4sKJENexJtbGe1HY9XJ2ezuG96lL4+wZKRWCZ+4m7lCCCSrBmBXTQsHvWktrcXK4R8Wy1Al1iUeZX/kx/eeMMFlzGly9Rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(66556008)(6636002)(4326008)(31686004)(8676002)(110136005)(66946007)(66476007)(966005)(36756003)(6486002)(31696002)(38100700002)(6512007)(53546011)(6506007)(2906002)(26005)(41300700001)(8936002)(83380400001)(2616005)(478600001)(5660300002)(86362001)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVXNzJZMmhreWNjODlvandkYnFtS2t5eHJDYTV6MGZYaW94eklQZDBONkJq?=
 =?utf-8?B?OUdHRHhvU0ZHcFV2QUJqTUFaYWFkRXFjdEZCbE8vSDNYTTNBUURmOTRxZ2Rz?=
 =?utf-8?B?aVlCaDFIT2dxY0tHVXBmRVpyZks1Ykcvc0pBSUlCU1ZFeHp1VzZIbEo4L2Nr?=
 =?utf-8?B?dk9UZTYyMEtKbTh5QkwvVUpxd2ZIRGFQZmF2elh1VGZiNnJSMEFlZURMckpu?=
 =?utf-8?B?RVdwS0pJRDA3ZzFMVHQ1ekwwR0U4d3RDZXM1RkMrZzhkWDU3cE1YdEo1cTlr?=
 =?utf-8?B?NWdNSVRyWFhtY094Q1l0SG9XTXdyL2JCQWpTSXU2dEs5QVZTTUMxaklwbnhl?=
 =?utf-8?B?SXZQaDEva1VIcUpnZDFxMTJ3NVBabTQ0SlE4NUJ1bW53WHZOQktFWDl1a0R0?=
 =?utf-8?B?OGpFclp5c0pvM0tmeEhsSUtKU2ZzQjduYnY4cGg0N2pHVFUzZTVyM29YT3pH?=
 =?utf-8?B?U3lHbUxvbk40TmtBOVVDd0hTVnBPc0QzRzluNEp0c1hCU1ZmYzJ3TUVkV3gr?=
 =?utf-8?B?UEdYOUlPaXpqSU0yeHJRV3N1RllqL1dnVFdQUG4vUzRZMnM1YTRsMVRqdUpT?=
 =?utf-8?B?RmVvaGZSVS9VVzd6RUpUa1hpYW1rbmtZU0xTaTM1UDJnclJUS3czOGcwOS9a?=
 =?utf-8?B?YW5mcUlYaWNuT01QeitwWUs5VGhGZXhGZUFXVE5lZFpQelBSVUJwUGwvcVR1?=
 =?utf-8?B?NXNaY0t6dG1ueEtzdS9zUmozSFZIbGRyUmVOQ21nWW1NemtRVXRBM0ZtMUhT?=
 =?utf-8?B?L1c4cmhSQWJmU1d4T2dkUHhnTVk3b2hIdWExelpVV2dySzZsK0lDZ0hzcjlH?=
 =?utf-8?B?d1JnQUVRZTZrQVhhY3ZOM21QeEdFZ2RzdGFGZUpqTlQxdzNrV0NYSEdCVW5X?=
 =?utf-8?B?UmxhNlMvMWxMWDJxR0IrOGd3WHVYbUhmY05qZmE0dWg4b3JNSUU4T3BHdk5j?=
 =?utf-8?B?Qkw3cElNUDFFeXJ6Sy82T3BqZVp6RHU1TWFEcVRyNlZuS3p0bk1ReWhIOStN?=
 =?utf-8?B?Nlh1bkg0V0RGckN2YUE1TzhaU3VYYmYrdkpSSEJ0dHI5b3FSL3lmWE53Q0J3?=
 =?utf-8?B?cERwNUFYc2hxQjdBeVd0VTNaZk9LUDlTUDVnUTRDcEtucW83UCtVeVdMOEpP?=
 =?utf-8?B?SC9YQnJON1pHNjNhamF3TjVUZFlIeUJ4YjdhTWZnUXJDWXFwbTRUdVZKUUpv?=
 =?utf-8?B?S2kwR0x5TVdOUzArMkswVk95c2plek52RWZvZzhEVWQ0ZlIyckdPVXU3c0xq?=
 =?utf-8?B?QVJBM0JVRm9vK0JkQzRUVFU5QUtmNGZVWDhrRG44bkNvSDJIVTdVUVF0UnNq?=
 =?utf-8?B?WDJweGNhLy9kUEpjc2xTUlRtTm9YbGl0c2NmOGgyZzVkQ2JtejZBcTl3TEdF?=
 =?utf-8?B?NCtzMmoraXhhaHVXUDJDZFBsQlBEVkpzS0c5YTFTbkZaWk5OdzNHMURqQ09E?=
 =?utf-8?B?bE1YVzNWa21RWDkyb1JQYUFTTjNEWWlZNUJEd25RTVZobkpvaVBGYXFQQVFQ?=
 =?utf-8?B?SXdYend5dGV3QTY2US9YUVBVaE5OSVJ0UjZxb3VDeGoreVlBQzE1WXhPMW1u?=
 =?utf-8?B?azE3U2hheitrbmdweE1pWDhrWjA2N3oxdTM2L0lYVXVraHlDckc5c3p4V1hW?=
 =?utf-8?B?aEl2VHRxS0pvdllGV2J4YnlJZmo4M2ZQZzRaUUxPeFhKSFBtcHBxV0xJS3NE?=
 =?utf-8?B?Q2thUHN4VVo4REowckxmVit4UEQvUW1JZzZRaG9KenQwMlB4aHFmVUh0TktD?=
 =?utf-8?B?MGZDYkdjclVXem1OZk1jTWFDc2N4eGQvSTZ3aXNzTkZ3SWhwQWoyZmxnK09S?=
 =?utf-8?B?UmZWS05JZEh4Vk1nWnhHM3BwODUvaVpBenZBWGNhYzZWdVFmZTZTTnh3emNC?=
 =?utf-8?B?L2xUQ0t4YTdaN0U3TFZMUm9BeFJldUdPUkNBZ3NuZlZnenh3Z0hjUGdaQmxQ?=
 =?utf-8?B?c0VmaTdPaEJtbmFnQ09pMTJBYlRwQ1VkQmtCM1lDSEJVVTZvMkFBZWdsNGlQ?=
 =?utf-8?B?UUhiNkdSRG5DbnIyQVJhWmhxNGtHSVJiVDNTRGVEVkpsWENnVWl1R0NsaUp2?=
 =?utf-8?B?YUJ2YWdHT0FQZklrdGkrS2dIK1V3NU5uSFZtQWNxQzFWT01zMXd4MXQ0WUVZ?=
 =?utf-8?Q?UCiw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d2ca69-f341-459b-fd1b-08daa7bf3d00
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 17:21:43.1507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LrvcQ1jLjo/dbYNlcbnwiMDqU2Mr66wVNO7qUjqPV6W0i8+lWEX3SyFmsyDX68u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>




On 2022-10-06 03:46, S, Shirish wrote:
> 
> On 10/6/2022 4:33 AM, Leo Li wrote:
>>
>>
>> On 2022-10-03 11:26, S, Shirish wrote:
>>> Ping!
>>>
>>> Regards,
>>>
>>> Shirish S
>>>
>>> On 9/30/2022 7:17 PM, S, Shirish wrote:
>>>>
>>>>
>>>> On 9/30/2022 6:59 PM, Harry Wentland wrote:
>>>>> +Leo
>>>>>
>>>>> On 9/30/22 06:27, Shirish S wrote:
>>>>>> [Why]
>>>>>> psr feature continues to be enabled for non capable links.
>>>>>>
>>>>> Do you have more info on what issues you're seeing with this?
>>>>
>>>> Code wise without this change we end up setting 
>>>> "vblank_disable_immediate" parameter to false for the failing links 
>>>> also.
>>>>
>>>> Issue wise there is a remote chance of this leading to eDP/connected 
>>>> monitor not lighting up.
>>
>> I'm surprised psr_settings.psr_feature_enabled can be 'true' before
>> amdgpu_dm_set_psr_caps() runs. it should default to 'false', and it's
>> set early on during amdgpu_dm_initialize_drm_device() before any other
>> psr-related code runs.
>>
>> In other words, I don't expect psr_settings.psr_feature_enabled to be
>> 'true' on early return of dm_set_psr_caps().
>>
>> What are the sequence of events that causes an issue for you?
> 
> psr_feature_enabled is set to true by default in 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4264 for DCN 3.0 onwards
> 
> (Also, in ChromeOS wherein KMS driver is statically built in kernel, we 
> set PSR feature  as enabled as command-line argument via 
> amdgpu_dc_feature_mask.)
> 
> Hence, the variable is set to true while entering amdgpu_dm_set_psr_caps().

Hmm, that is a local variable in the function, not the same as
link->psr_settings.psr_feature_enabled. Unless I'm missing something, it
looks like link->psr_settings.psr_feature_enabled is never set to true.

More below,

> 
> 
>>
>>
>>>>
>>>>>> [How]
>>>>>> disable the feature on links that are not capable of the same.
>>>>>>
>>>>>> Signed-off-by: Shirish S<shirish.s@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 
>>>>>> ++++++++--
>>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c 
>>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>> index 8ca10ab3dfc1..f73af028f312 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link 
>>>>>> *link)
>>>>>>    */
>>>>>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>>>>>   {
>>>>>> -    if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>>>>>> +    if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>>>>>> +        DRM_ERROR("Disabling PSR as connector is not eDP\n")
>>>>> I don't think we should log an error here.
>>>>
>>>> My objective of logging an error was to inform user/developer that 
>>>> this boot PSR enablement had issues.
>>
>> It's not really an issue, PSR simply cannot be enabled on non-eDP or
>> disconnected links. 
> 
> Agree, the idea here is to avoid decisions being taken presuming 
> psr_feature_enabled being set on such links, like disabling 
> vblank_disable_immediate 
> <https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4330>etc.,
> 
> Regards,
> 
> Shirish S
> 
>> However, it is concerning if we enter this function
>> with psr_feature_enabled == true.
>>
>> Thanks,
>> Leo
>>
>>>>
>>>> Am fine with moving it to INFO or remove it, if you insist.
>>>>
>>>> Thanks for your comments.
>>>>
>>>> Regards,
>>>>
>>>> Shirish S
>>>>
>>>>>> + link->psr_settings.psr_feature_enabled = false;

Never the less, explicitly setting to false rather than leaving it as
default sounds like a good idea to me.

But I don't see how this fixes an issue.

If this is a readability fix, I suggest changing commit title and
description to reflect that.

Thanks,
Leo

>>>>>>           return;
>>>>>> +    }
>>>>>>   -    if (link->type == dc_connection_none)
>>>>>> +    if (link->type == dc_connection_none) {
>>>>>> +        DRM_ERROR("Disabling PSR as eDP connection type is 
>>>>>> invalid\n")
>>>>> Same here, this doesn't warrant an error log.
>>>>>
>>>>> Harry
>>>>>
>>>>>> + link->psr_settings.psr_feature_enabled = false;
>>>>>>           return;
>>>>>> +    }
>>>>>>         if (link->dpcd_caps.psr_info.psr_version == 0) {
>>>>>>           link->psr_settings.psr_version = 
>>>>>> DC_PSR_VERSION_UNSUPPORTED;
