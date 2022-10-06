Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABED7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32AE10E7FB;
	Thu,  6 Oct 2022 07:47:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDA310E7FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 07:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF66s4sEyN9+60xJFnZpXNx8f25c24Lky6jL3iFB31kgiFkuzsSfW9MosR7PKUc/7pC1V6RjsGEHmpzGchY5ZQeR40hS7cXA6THUYYSuhuR+yX+NkSY3Gm1h+GHAHPR7RmfnTMiigemAayq9Y4O8cr+AulM0tolk+tr3UiMpe2ujf8inqnAWHRIk6s2YRlCYaHqXiCA3QM4TfJm620iIjbLW0yDw1ft4i9RZyV3Pi4Dp+x+wa+hxpf9ylOrbRmVQt4lG6S7SCs8oBm4b2Nc5enbBBLf7FVEb4IyHwwT083Rm8s34uHxO4b8YGFwN2KWvkCmLbVAyFnhTLOL9XzJDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qd7Kx+6XKhqdU0XLBJFeK296U150Zi6EaYcYr5s1J0=;
 b=KyCMjV2SJfdpOuS81esG5bCHAW1Ep4JPPMN2y1zcCkyYfs1zg2+p0R5Cn+HQZgFXRROL7agE4h0Uy/amQubkU3oOr4BieLTh/hndQ5w35e+xnW2UqfLTklfACvDHQDQ3ywvTslobrsoWiEYAXGw1mQIe2fOqTMGngI0K6Q7gcg7j5PTEHrsLz+X+M1UbUuWV5pIeIoF6jTQv8m3BbO/g5+sOVcs05NCXJ482D6ZIvfQzqCL2cgAdjjmwSu9fi4RB1E2amUxyLSqurBBsJ9sFrGbHdqSuLIpICsj9wkifPw+1JUpUZKapAg3MB5UhTF95ySz7q40rlDQVmZ41e9h/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qd7Kx+6XKhqdU0XLBJFeK296U150Zi6EaYcYr5s1J0=;
 b=widJrD5SahI2Wwaa3/7857dHOYn9Xv6RqZrihrQIge/KV0O1xqThoh8dJzsrhOuqofLOrmSRMl27vVXU2EB3K3DgHK+OeHrAx8gGo8N3qPJ0FnFvJprDtX6sJGjfU3iRjQ6hXD0DyA70NUfpNrfiUTd9wMazJqVUA13cWCVCHo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 07:47:09 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6%8]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 07:47:09 +0000
Content-Type: multipart/alternative;
 boundary="------------p5eWAevqLZuT3Z0K0A7XYpg0"
Message-ID: <f840d24a-136a-81fb-1bd7-a0a75f6962e3@amd.com>
Date: Thu, 6 Oct 2022 13:16:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
 <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
 <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
 <8ac24a07-6255-3092-95af-40d3a0d3124f@amd.com>
 <38b74412-dc3a-37da-55dd-e2327fe59769@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <38b74412-dc3a-37da-55dd-e2327fe59769@amd.com>
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a77ef57-94fc-4142-d92b-08daa76ef8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUE8LN0FzNZwz8ZVi9qp4xQrUM8kmUjwOz/EQKmjzcPuD7EeaWmqP88OoH7QsIlAYi1KsS8i8wBPLWWyGT0mb4R6LEoLcY+gfVdNnOVSfQE5PSN61/mzIk2y2c5UysC9S31wL5rccNIYRkaMHyZmSDwenRH2WpEkK+1ccjPArH5FasAp2XnIhZrM63H5xsPR/fRHoHy3u4weJORPY8fsN6KbjdGhY1FZ8VhBZCMI0UJ7YgjVplrPSE1m9hQSQOsHmPFMRX1LieDsyaxwBaQR7QjeOlSUEERdUQkSCOEJaPgSqbrAKiLWnD1AsbO1kqF88Kp5Fl7ADeWmvs4rEnuKKseo+BDPDwUjU0A76xQNYGJoi9H6viD8vwh64520zOp5EJClCQnmOWi8W/fOapnv14nUxPfd7A/K1S2slxd4aGVKZCFmRZ7NMDEAQzBQqGFCMNugR8MqnrL5SxTRWsY06tfxtCDl9qF4eIK9rQDmoI0lBJKAHsAzG/XCeLb/yYaVKG9cp7N4Jl+A9nUrotq5XqPjc6gkIO5Hzi4a6W/LY9vpQxw+Vxzr1FZV8MyLWdjJSxHTmL8S+/j0HwAcant4s4fNkIp6tFgxQdtlPDIcChKBPLhDV5Z8VzyIkiFWqbvg/OxlsSvpNmvQsBmCFFwrUghOsvCoPyLty3qq4lH1NaJi1XANzAySJzthjyZ4Hv3716l++1oYngO0VdmZCGS4pMvwloBfA+0aE3zNBUtAiPRcfEUKNc1dK+ZmF2Zi6amrAtwr7q1UNDwCNY7vXUzBsWpFoRkrbxOMLAkuJ6iHVRVZFzrVDrikN1bmyd56k3JCxE2sp8UtoLxPbL1U96iHmA21B0w9AZkWnYem1lQQy2BllcxobnbT8xubAZMYEHBq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(36756003)(31686004)(31696002)(83380400001)(38100700002)(186003)(166002)(2616005)(6486002)(53546011)(2906002)(6512007)(26005)(6506007)(478600001)(966005)(6666004)(4326008)(110136005)(316002)(5660300002)(8936002)(41300700001)(33964004)(66556008)(66946007)(66476007)(6636002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdqWEYvODJtd0JmRHpLRzVEV0VmQ01CRGM4WFVBQ01uZ1RTdU1rMXJCbGk4?=
 =?utf-8?B?M0xZUkpKSFVkTWUvbHZuUkdYOFdDSVNKNWNGZU1BYTJIWnhvSzNUWStFNTB5?=
 =?utf-8?B?UlN6dkxZMkpmN0JtOWxqeW1CSVltdVpQYmhCL2VjYUZ6OUNNclZESm9nYjNW?=
 =?utf-8?B?Um1CYTVkUnloYm5USWM1Zk5VNW83bTkwWEoxTDBQWTIzRGF3cHl4d1RvM1Nk?=
 =?utf-8?B?VmIxQjMzam1tbW9ORFFXVUY0SzJjWU1jdmRXWFdFbUhHMVRhNmh1Y1dYVW1h?=
 =?utf-8?B?WWZqZWkvd3Zlc2lkVHpwZFBBa0N3WEZHNE4rbVl5cWgyRSsrb0I3NGdtZmhL?=
 =?utf-8?B?aHc0M0VlKzZ2Sk0yY3EyajBGa0c5NEJJczZrcERsYUdQUlZhVEFMbmJUaEtQ?=
 =?utf-8?B?ZHdEUTY0OEJ3d2xjejZQVkNUUXZWSmdoVUVGbnlGZmZyb1dPVnJUbjM2czNK?=
 =?utf-8?B?enM1VUdBRGtWZkNmc2Y5enhvQUZVck41NkNtVXNHUzVmOEc5cjFVeDV4WTc3?=
 =?utf-8?B?MzBGR08xd0lIcEJrT1dlR0lwaHplT0w0cGJ0VkU5OGJZUFFKOGRZVkprRHFm?=
 =?utf-8?B?UTlUWnRTOGhBL1FpL01jMU0yWUVGN1M1YUM3WVhXQzlUZ0V3bU9MUzNPbFZJ?=
 =?utf-8?B?UHhHN0NDQWxOcEFLUU1PV04xaUwwVkF2UXIyNFlMK1AvL3RBdy9YbUhQS1FG?=
 =?utf-8?B?RHBmdEEvbGNha1Q2bmkvV3BCZU9jMG5QSFd4YXl3Z01ZMTBFVU5VS0hQNGc5?=
 =?utf-8?B?QnNVZ0w3ZlFsRHNuemhpU044NkxZanUrK0Z5c0NsVkdnVWRNY2FGZVVOck9v?=
 =?utf-8?B?eHcvVXlGTVVTdjVTd3lFVnFadXJpcVBEbjB0eVZMTVdZdm9FUUJ4d0I5WU5o?=
 =?utf-8?B?ZklnUjJqOVFPYytCbS9ycVo3MCt4c2JHbmpzdkdhRlZvcDBHTmQyMyszeURT?=
 =?utf-8?B?RmViY3NDL1BnQTVQN2tndWFiMWFzaW83MjNiSWttaTlJNWpKRmt2Z1o4Wk9z?=
 =?utf-8?B?bVFNblJmQmZ0OTZveUVTMmFkaXV2cGFFUXVubU9DN3gyRzVCYVkrRmp6S3lG?=
 =?utf-8?B?dXBYRGtPZENuOHdxWEV1SVJEWjVseXhQV2dPbkJtRjlQbU4xSzdMTFJoQnNZ?=
 =?utf-8?B?NnJjNnRoV1JxMEJjNWNLaFIyQVBOWEhreXBqQ1hwYzZiL3FIczNtcGw1NXJt?=
 =?utf-8?B?S0puNFVQNlpXWFROWVNkckE3ZDJrbzg1UEVsZEdNcUlqSHphZFY2YnhOMHVG?=
 =?utf-8?B?b0JDQ1lmY3JuU2FyVmQ3OHdOcXFRcjVpSzdnTTEwQXJCTlpZRXZlMForcnl4?=
 =?utf-8?B?NytUMW5ZcWQrUnRlaDk1dzRKRDFaUkRGdmxENDBLOVJ4N2dWL3dOUG0yRTNK?=
 =?utf-8?B?Mkpla0FmNGdLR2JhYWN2TTFzUWk5UFluQ2puOVpPZzErZ25xNFVzcGZVbUxp?=
 =?utf-8?B?TldWYm9vRVNCUWFSaGx6bUkvTHo4K20wSEdjVHZsMm9KY0phWEhheXpjR3Q1?=
 =?utf-8?B?M0dxMXRMTG80TUZOZUlHQ3hMaG9MaXQ1a0RMTnlsLzRna1FVME5PSXV6NFhk?=
 =?utf-8?B?Nm9Cd1UxQ2pEemEzczZKbHpnRkI1Rlk1dkFSTVpoYTFBdWcvNlJZZnZlNGxY?=
 =?utf-8?B?ZisyMytoRnNveTJKTFZhM1NEQXlKa1B3WXdGbUNzWElNQ1YwU254OXR2aG50?=
 =?utf-8?B?WC9JWUM4emZkZVVFNTFOaFpkU3VnQVFtRWtjb28xaHZFOU5BVlRhSGk4QmJB?=
 =?utf-8?B?Zlh3Nko3bm5Ed2xVazFjbnZSRTlPNTRiaHovU3dZeHZpUUVLYTNWdEJtL2dp?=
 =?utf-8?B?Y1BRSE1Oek03U0laNFpDYjIzVW5iZnBNM2pzZ3g1Q2RIdVRtWHJad3F3WlRi?=
 =?utf-8?B?T3A0UW95a3lqL3E4L1B4bTRHUjVGeDZqYWlsMng1THNmN0lsZzdhSndmODAw?=
 =?utf-8?B?SFlpNjlLYmswcDBlc0ZRNVFmUGNZUzBvSGNyUTBRaDJ6ZURMRHhhNFZKeHRq?=
 =?utf-8?B?Q29PY0hOUjEreXVjMStYaHpWT0p1MS9Ka0hsZTlqSGY1WWJlQ3B5ZVZvU0E5?=
 =?utf-8?B?emNFVkFCb3p6NHpZNEtiSDRxZ3NwSUUyR1BJektqZVMydUt5OTRQRGNZRlUy?=
 =?utf-8?Q?Tq+YYAPjvn8zlbAa0u0gTCvoP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a77ef57-94fc-4142-d92b-08daa76ef8be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:47:09.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq5Pez6dW1PQStuX4s1xwXy3Kx+F10oMnkj2vjiGXs+tYSNM9Y/bQDt7rqQ9TlvXsgwv9T8UtcM+jFK1rG5pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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

--------------p5eWAevqLZuT3Z0K0A7XYpg0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/6/2022 4:33 AM, Leo Li wrote:
>
>
> On 2022-10-03 11:26, S, Shirish wrote:
>> Ping!
>>
>> Regards,
>>
>> Shirish S
>>
>> On 9/30/2022 7:17 PM, S, Shirish wrote:
>>>
>>>
>>> On 9/30/2022 6:59 PM, Harry Wentland wrote:
>>>> +Leo
>>>>
>>>> On 9/30/22 06:27, Shirish S wrote:
>>>>> [Why]
>>>>> psr feature continues to be enabled for non capable links.
>>>>>
>>>> Do you have more info on what issues you're seeing with this?
>>>
>>> Code wise without this change we end up setting 
>>> "vblank_disable_immediate" parameter to false for the failing links 
>>> also.
>>>
>>> Issue wise there is a remote chance of this leading to eDP/connected 
>>> monitor not lighting up.
>
> I'm surprised psr_settings.psr_feature_enabled can be 'true' before
> amdgpu_dm_set_psr_caps() runs. it should default to 'false', and it's
> set early on during amdgpu_dm_initialize_drm_device() before any other
> psr-related code runs.
>
> In other words, I don't expect psr_settings.psr_feature_enabled to be
> 'true' on early return of dm_set_psr_caps().
>
> What are the sequence of events that causes an issue for you?

psr_feature_enabled is set to true by default in 
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4264 
for DCN 3.0 onwards

(Also, in ChromeOS wherein KMS driver is statically built in kernel, we 
set PSR feature  as enabled as command-line argument via 
amdgpu_dc_feature_mask.)

Hence, the variable is set to true while entering amdgpu_dm_set_psr_caps().


>
>
>>>
>>>>> [How]
>>>>> disable the feature on links that are not capable of the same.
>>>>>
>>>>> Signed-off-by: Shirish S<shirish.s@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 
>>>>> ++++++++--
>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c 
>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>> index 8ca10ab3dfc1..f73af028f312 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link 
>>>>> *link)
>>>>>    */
>>>>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>>>>   {
>>>>> -    if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>>>>> +    if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>>>>> +        DRM_ERROR("Disabling PSR as connector is not eDP\n")
>>>> I don't think we should log an error here.
>>>
>>> My objective of logging an error was to inform user/developer that 
>>> this boot PSR enablement had issues.
>
> It's not really an issue, PSR simply cannot be enabled on non-eDP or
> disconnected links. 

Agree, the idea here is to avoid decisions being taken presuming 
psr_feature_enabled being set on such links, like disabling 
vblank_disable_immediate 
<https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4330>etc.,

Regards,

Shirish S

> However, it is concerning if we enter this function
> with psr_feature_enabled == true.
>
> Thanks,
> Leo
>
>>>
>>> Am fine with moving it to INFO or remove it, if you insist.
>>>
>>> Thanks for your comments.
>>>
>>> Regards,
>>>
>>> Shirish S
>>>
>>>>> + link->psr_settings.psr_feature_enabled = false;
>>>>>           return;
>>>>> +    }
>>>>>   -    if (link->type == dc_connection_none)
>>>>> +    if (link->type == dc_connection_none) {
>>>>> +        DRM_ERROR("Disabling PSR as eDP connection type is 
>>>>> invalid\n")
>>>> Same here, this doesn't warrant an error log.
>>>>
>>>> Harry
>>>>
>>>>> + link->psr_settings.psr_feature_enabled = false;
>>>>>           return;
>>>>> +    }
>>>>>         if (link->dpcd_caps.psr_info.psr_version == 0) {
>>>>>           link->psr_settings.psr_version = 
>>>>> DC_PSR_VERSION_UNSUPPORTED;
--------------p5eWAevqLZuT3Z0K0A7XYpg0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/6/2022 4:33 AM, Leo Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:38b74412-dc3a-37da-55dd-e2327fe59769@amd.com">
      <br>
      <br>
      On 2022-10-03 11:26, S, Shirish wrote:
      <br>
      <blockquote type="cite">Ping!
        <br>
        <br>
        Regards,
        <br>
        <br>
        Shirish S
        <br>
        <br>
        On 9/30/2022 7:17 PM, S, Shirish wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 9/30/2022 6:59 PM, Harry Wentland wrote:
          <br>
          <blockquote type="cite">+Leo
            <br>
            <br>
            On 9/30/22 06:27, Shirish S wrote:
            <br>
            <blockquote type="cite">[Why]
              <br>
              psr feature continues to be enabled for non capable links.
              <br>
              <br>
            </blockquote>
            Do you have more info on what issues you're seeing with
            this?
            <br>
          </blockquote>
          <br>
          Code wise without this change we end up setting
          &quot;vblank_disable_immediate&quot; parameter to false for the failing
          links also.
          <br>
          <br>
          Issue wise there is a remote chance of this leading to
          eDP/connected monitor not lighting up.
          <br>
        </blockquote>
      </blockquote>
      <br>
      I'm surprised psr_settings.psr_feature_enabled can be 'true'
      before
      <br>
      amdgpu_dm_set_psr_caps() runs. it should default to 'false', and
      it's
      <br>
      set early on during amdgpu_dm_initialize_drm_device() before any
      other
      <br>
      psr-related code runs.
      <br>
      <br>
      In other words, I don't expect psr_settings.psr_feature_enabled to
      be
      <br>
      'true' on early return of dm_set_psr_caps().
      <br>
      <br>
      What are the sequence of events that causes an issue for you?
      <br>
    </blockquote>
    <p>psr_feature_enabled is set to true by default in
<a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4264">https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4264</a>
      for DCN 3.0 onwards<br>
    </p>
    <p>(Also, in ChromeOS wherein KMS driver is statically built in
      kernel, we set PSR feature&nbsp; as enabled as command-line argument
      via amdgpu_dc_feature_mask.)<br>
    </p>
    <p>Hence, the variable is set to true while entering
      amdgpu_dm_set_psr_caps().</p>
    <br>
    <blockquote type="cite" cite="mid:38b74412-dc3a-37da-55dd-e2327fe59769@amd.com">
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          <blockquote type="cite">
            <blockquote type="cite">[How]
              <br>
              disable the feature on links that are not capable of the
              same.
              <br>
              <br>
              Signed-off-by: Shirish S<a class="moz-txt-link-rfc2396E" href="mailto:shirish.s@amd.com">&lt;shirish.s@amd.com&gt;</a>
              <br>
              ---
              <br>
              &nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |
              10 ++++++++--
              <br>
              &nbsp; 1 file changed, 8 insertions(+), 2 deletions(-)
              <br>
              <br>
              diff --git
              a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
              b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
              <br>
              index 8ca10ab3dfc1..f73af028f312 100644
              <br>
              ---
              a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
              <br>
              +++
              b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
              <br>
              @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct
              dc_link *link)
              <br>
              &nbsp;&nbsp; */
              <br>
              &nbsp; void amdgpu_dm_set_psr_caps(struct dc_link *link)
              <br>
              &nbsp; {
              <br>
              -&nbsp;&nbsp;&nbsp; if (!(link-&gt;connector_signal &amp;
              SIGNAL_TYPE_EDP))
              <br>
              +&nbsp;&nbsp;&nbsp; if (!(link-&gt;connector_signal &amp;
              SIGNAL_TYPE_EDP)) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Disabling PSR as connector is not
              eDP\n&quot;)
              <br>
            </blockquote>
            I don't think we should log an error here.
            <br>
          </blockquote>
          <br>
          My objective of logging an error was to inform user/developer
          that this boot PSR enablement had issues.
          <br>
        </blockquote>
      </blockquote>
      <br>
      It's not really an issue, PSR simply cannot be enabled on non-eDP
      or
      <br>
      disconnected links. </blockquote>
    <p>Agree, the idea here is to avoid decisions being taken presuming
      psr_feature_enabled being set on such links, like disabling <a moz-do-not-send="true" href="https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4330">vblank_disable_immediate
      </a>etc.,</p>
    <p>Regards,</p>
    <p>Shirish S<br>
    </p>
    <blockquote type="cite" cite="mid:38b74412-dc3a-37da-55dd-e2327fe59769@amd.com">However,
      it is concerning if we enter this function
      <br>
      with psr_feature_enabled == true.
      <br>
      <br>
      Thanks,
      <br>
      Leo
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          Am fine with moving it to INFO or remove it, if you insist.
          <br>
          <br>
          Thanks for your comments.
          <br>
          <br>
          Regards,
          <br>
          <br>
          Shirish S
          <br>
          <br>
          <blockquote type="cite">
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              link-&gt;psr_settings.psr_feature_enabled = false;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
              <br>
              +&nbsp;&nbsp;&nbsp; }
              <br>
              &nbsp; -&nbsp;&nbsp;&nbsp; if (link-&gt;type == dc_connection_none)
              <br>
              +&nbsp;&nbsp;&nbsp; if (link-&gt;type == dc_connection_none) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Disabling PSR as eDP connection type
              is invalid\n&quot;)
              <br>
            </blockquote>
            Same here, this doesn't warrant an error log.
            <br>
            <br>
            Harry
            <br>
            <br>
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              link-&gt;psr_settings.psr_feature_enabled = false;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
              <br>
              +&nbsp;&nbsp;&nbsp; }
              <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;dpcd_caps.psr_info.psr_version == 0)
              {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;psr_settings.psr_version =
              DC_PSR_VERSION_UNSUPPORTED;
              <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
--------------p5eWAevqLZuT3Z0K0A7XYpg0--
