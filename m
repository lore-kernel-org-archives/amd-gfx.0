Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D0FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 04:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00C710E91A;
	Fri,  7 Oct 2022 04:31:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3593E10E6E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 04:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAGekAcq3ADKbJ+o6QPo3WtqY6k5cPPqbOGt01MZ4wlkTn3kucZyWP1KbqajgGig9hH3HtaBkeE5qpfTx+t49zkf0j+HbFzg/t9jF4zQ5eKUbsIOpOTeZOxo5wHN8hALl6GVfDGdKTsXuEKW+BXer93UJk+2qoaYyqnRjCDj+DjiTz4dHb2CI0WuP3VSECF4dwalPgr7dYl4lB5udbJoq4K4+E5RQNta3z9faFGQp4w7MHcWPJinio9bqLrQ5XbaNLHLCdm7RXVxx1gu4WEOrzwY6NO9Fkjx60BjAvg4lWtuna4dla5NWCwN5qbPFCu/Ru9lX3lxe/KieyOz4s0e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVPAqqtucFfKgH0LpTjeBa8y6qX0lizxEohUgRRcX2Y=;
 b=d93BUZwaSwzLxPHK4sllsqMm5dFoQ8SxRuAyGPrsUskpv1HhPy9P1lu/h3ZypnsiVzvpLyf0IZiH0wp1VCfc4k3rHkcT7KEY/ISW2mugyprmi/mqL4AKTxj1fzmOaVQBGu1SZc8n4Pi3B4a4la7u5HP769s5dIVSB38etT2/Eafawg48b0bCTAzBQH2grY6RgwTe9epJRHPpPdjILTvEm4wcgPm9BCyje0dhqlJd0e5kr7p0dc/dX84Q6fkruNL8a3OmUSQVwKeosCqTNWhjIKllBaviOkc1lOisEdNbwW7WwPJ/34eMofoFKeP5kJJKvwHhzbxdmPe9B4QnhvfC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVPAqqtucFfKgH0LpTjeBa8y6qX0lizxEohUgRRcX2Y=;
 b=WYIC+Ul613TpNfMLzEgLMhApaycW00Sk6F1XTamvif1WjYumpefUo+N68AGVzw7e9XUhd7FOLeJYpZ1QHUZhVqV+OzPfe0nTi8j9oVPwNfQvlpRpmhP8z5jwpn+jsARVEnUpgHR+IGSgUi0cskoJ0vbB+Y3qvuMVhNQeOlNKN+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 04:31:05 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6%8]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 04:31:04 +0000
Message-ID: <512777f7-260a-0a64-bda1-350e89a94433@amd.com>
Date: Fri, 7 Oct 2022 10:00:51 +0530
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
 <f840d24a-136a-81fb-1bd7-a0a75f6962e3@amd.com>
 <dd02285a-8fc6-7951-30f8-1300ff3149f1@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <dd02285a-8fc6-7951-30f8-1300ff3149f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5c2e71-664e-4b73-ed79-08daa81cbe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLhneecszWCPbjxaSZMMTH3g+sbWhmBN1AQEkDzRQFKk3oIPButjtvsqTndOV+W8GJZnZm4k9+8q+/OR/SXOPl/ZscGTKaw6/fqdcZsRo+Id0VOovqbXwMfFBudpUGp6NjvQte6uf92Fw7qzf6xJ2CyJ9jSVvsVj3PYhn7Z7Tea4rLWrJ7h1Pir1DZPr+JG/siI4cy6rDxXuqxbNux08sJclFvBiOFu634e5ESJYRm/n+vfkiAmXTzwZTF5GPrY7bPvuJn41/XQEDIWtH8KcAL5Ylx7hkhm35yQ9SC+nEuxbGux3xUpsGqPpsYkUqs9meuoouxhmX+Zh49WAeNSexr9loo3Ua2tws5Gelpdtr043xeE+qiIviupxveKfdz1VCgZfWJ3cO3an26HUL5rWbz2E+norO/z412MKy0RKWMcwS5o6TVOuVApu9NEpJE5iTIP7pQXkBG/tT4pk0pUiJNeAUnrjZpwnDxOX4e4twf/GAmcBEv3UqbtT9dBSZ6ineYZK2hXXGjyy0p8RK1x03fhDVB0a9iIuiRwHRkVvv6RK7YcCOp5Nj7bF0MWG0O7rQdahYbRgZydKGhG9Vkm8Yec8Y9Q/iAVRIYw0j60qOKpf/rnZs0o1ueASDi4x4KrJrgwY9PW7vu+jDUPScILbKa9bXKWBstsFO6ADk/e9tM1fp8SiC4MrLvOn3WLnIqf2WQBBFhMEjywSGaa82dhlZxQ99x4s1DeN5Q9iZIr6nJintrnNaNgF0/v1ym0T8FM4DGrDh27uD2QYTVVSPbCp0SlS002de+rDkpPYVDZ04rieblu4zNv2Ehra+xAV1O6k5w3DDKgCO0mrBfq2zfX/pR04w3TAxzI4eUavqNpiFzuwCMhKVGAa46ZcbXZkawci
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(478600001)(31696002)(31686004)(36756003)(2616005)(8936002)(38100700002)(2906002)(26005)(186003)(6506007)(110136005)(6512007)(5660300002)(6486002)(53546011)(66556008)(966005)(6636002)(316002)(8676002)(66476007)(66946007)(83380400001)(4326008)(41300700001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhTQkk4MWtrdFAxdVk4L1kvTjYrLzVHK1hGTm5JY0hlZU5TY2NOaTNNYmFU?=
 =?utf-8?B?SDhiME4zM3Z6dFJ0dGRZRnFPNkRVcnBKN1dZeVhpUmIrUDl6SFB1ODlLeTFM?=
 =?utf-8?B?c01KS3l5UGR5dm5wcTZJa0pnNzJNWFdmTCtna25rRWs5aVhjMEhBWGNXemVF?=
 =?utf-8?B?cnNKQVJRdjdLYVVaS0NVTUl4YzZiTmRtMmdyMWx3L0JjY2ZoWlRFYUJoNjk4?=
 =?utf-8?B?alJGRjFERnZJY1lwakVTTFpKRlVtWE16V3JIaUo1amg1NVhNekhIRWw4QnQy?=
 =?utf-8?B?SXM5ZEcreUEza1pJUXA5S0JqTHZtSDlldmRITlc4NGQ2V21qbGFycUlOY2Ez?=
 =?utf-8?B?N1NlREVlLzQ4Umt6YWM4M09SWnhDWlJnUGJBR1FJRVR5cW9GTENZRUp2YUtm?=
 =?utf-8?B?dUlBUmE1TVRMVXVFaG5mV3h2QVlrVWF6SGVWa0xaQkppaFBnYlR1ZXEwanJ6?=
 =?utf-8?B?bXlkZU9kaklVem11R1VKci91dFBFWlJydS8rWVNreTNaOFlXUUk0Zklsdi9X?=
 =?utf-8?B?Q2hySlVJNGVqM1c5V3JEYU5XRlhPRXJJLysyR1N1MTg0Yk56RUh6eWNrS0gz?=
 =?utf-8?B?eFBqd1hvOU5hNCtqcXZLZi8zaDNucWR2UlJERHZJZnZrMm9rWW0wNHp2NXRZ?=
 =?utf-8?B?eEFlUmxVaUFhRjhGU3Z6dkJkS1plb2d3cXNvZXo4bVFORW0xVjNac3RzRE5Z?=
 =?utf-8?B?eEtEZHZjd09ZZEVXbFRZTU1UeDRFNlpvd1YzV2lxOVpMRGxWS3dUNC9zenZB?=
 =?utf-8?B?dlViVkhRQ0orK3oxMzdCOGMzamdoYTk3aVNIVzYvaEZ6cGpPUVhIdkh0NUxN?=
 =?utf-8?B?SUYxOTdRWFNydWE3dmlkV0ptb2sxYVlsa3lwS0Z4OWVZcHVHcktTRWtVaDZ0?=
 =?utf-8?B?dzZlVjJTQWNQQ05QM0Vxa0NtcEJhNEVPREErRkwvVlAzNHBJVjV5UERVb0Mr?=
 =?utf-8?B?SFltd1JGMk5xYXcxVU55SjI3UGlYOUgreHpVRXpZclNidnplWHVVQ0Nxem1O?=
 =?utf-8?B?N0h0Qk1tNXZTV3V4UHY1RVZ6bFhabkt3WHBFaXorUVFEUldkWi9qYldZNmo1?=
 =?utf-8?B?YjE0bm0xYnA0TkZrM0tYdXBPK0czU3diQ25GMEZ5SGsrT2dvbTJpT3pKVmp1?=
 =?utf-8?B?dVcyRmo4SkJsS0t2ZFFFaHEraE9XYzdBRTRjSlEvRTkxTW5BaTRpSjAwZUNZ?=
 =?utf-8?B?ampmMWdQYnV1endxMlZOazQ3OUp0ZUxQLzVzazhCOVh0S0ovV1JhOW9XT1Vn?=
 =?utf-8?B?dTVYSGlDbVpDbTNkZ21aQ0hISHdqalRmRkFXRDFYekxkeFJTMnh0dG10T3Jn?=
 =?utf-8?B?OEl4cTBLK3Nub1BXZEJSVmhlMjUwUWl1VXpIOXh4RnhPOWZNZWx1ZmFEMEhU?=
 =?utf-8?B?a2dtajlucXIreVhQS2xsSG1aTUltWFQreXdxNFhnaGVJRUU0Z3pZWWhsQTJj?=
 =?utf-8?B?WE9MMWxPemVQenpoMnl0SytPS1pOQ0Y1RGdzMFdJajdxVjVkaFU2ZEJVSU5t?=
 =?utf-8?B?RXkrVlExQm5MSDBkODdPbm0wMTZ4Ykx6d1JTeE54b0pFa3Fna0lDL2htSzha?=
 =?utf-8?B?ZHkzZVFFSUFTenZjWHIvcExjT21PL2lUemg2MjFlTzF6cGF0UXY4MmtLZDZC?=
 =?utf-8?B?NnRXYk0xdFBtQVZWZS9SRWNOSDVRb1cyTDJPK0x6SVlOdUtVeXRZNDUwYzhu?=
 =?utf-8?B?LzNOQXI5WnJtZzJVQjBjNnlKbHhLaU81UVlRcXkrdWRKZ09PZHo4MUlWQnUw?=
 =?utf-8?B?WHRsRUd6ZXNXVmd3Nmh5UEpZWmk1cWpnVlZOMWhyeDFhbHQ5Wlg0YXFFN1du?=
 =?utf-8?B?ZG5FUXplVjMvZDF1MGttMlpyTlAvR2oyTGtmOUEvdDdIU2FncG1NU2xraTBH?=
 =?utf-8?B?aENoN1o4R3FaTm5wVitMeWhMSWQxTzFSbzRPOVNxVzMzRTdaYTJmcHRzM2pk?=
 =?utf-8?B?Q01ad2tSWmFaRnkvR3lkMytzeWIzcytTcWxqd2cvSUduRnNUTUY1dXcwSzhH?=
 =?utf-8?B?TW11b3VvZTlScHF1NitaemxrbnFSWWRTT3ZOL0QxSXhuNzJZQ2hVU1RxRU5G?=
 =?utf-8?B?cC9uWTFVeEZnZ21iN0ovVWxGR1RMMWhla3hIR3o3TGpBQTB3WUlDQmFYSDND?=
 =?utf-8?Q?bDXZh/bApAbaLIZ2H4lVPs4kV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5c2e71-664e-4b73-ed79-08daa81cbe94
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 04:31:03.9765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrmgm4WV57kuBCx+hqxDVxlwrsbkoQSfhXvG8+IIhc/lGVzqIfGhxNqXZ6W1jVbQY2EA1jLbLvgwpr1mKbhFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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


On 10/6/2022 10:51 PM, Leo Li wrote:
>
>
>
> On 2022-10-06 03:46, S, Shirish wrote:
>>
>> On 10/6/2022 4:33 AM, Leo Li wrote:
>>>
>>>
>>> On 2022-10-03 11:26, S, Shirish wrote:
>>>> Ping!
>>>>
>>>> Regards,
>>>>
>>>> Shirish S
>>>>
>>>> On 9/30/2022 7:17 PM, S, Shirish wrote:
>>>>>
>>>>>
>>>>> On 9/30/2022 6:59 PM, Harry Wentland wrote:
>>>>>> +Leo
>>>>>>
>>>>>> On 9/30/22 06:27, Shirish S wrote:
>>>>>>> [Why]
>>>>>>> psr feature continues to be enabled for non capable links.
>>>>>>>
>>>>>> Do you have more info on what issues you're seeing with this?
>>>>>
>>>>> Code wise without this change we end up setting 
>>>>> "vblank_disable_immediate" parameter to false for the failing 
>>>>> links also.
>>>>>
>>>>> Issue wise there is a remote chance of this leading to 
>>>>> eDP/connected monitor not lighting up.
>>>
>>> I'm surprised psr_settings.psr_feature_enabled can be 'true' before
>>> amdgpu_dm_set_psr_caps() runs. it should default to 'false', and it's
>>> set early on during amdgpu_dm_initialize_drm_device() before any other
>>> psr-related code runs.
>>>
>>> In other words, I don't expect psr_settings.psr_feature_enabled to be
>>> 'true' on early return of dm_set_psr_caps().
>>>
>>> What are the sequence of events that causes an issue for you?
>>
>> psr_feature_enabled is set to true by default in 
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4264 
>> for DCN 3.0 onwards
>>
>> (Also, in ChromeOS wherein KMS driver is statically built in kernel, 
>> we set PSR feature  as enabled as command-line argument via 
>> amdgpu_dc_feature_mask.)
>>
>> Hence, the variable is set to true while entering 
>> amdgpu_dm_set_psr_caps().
>
> Hmm, that is a local variable in the function, not the same as
> link->psr_settings.psr_feature_enabled. Unless I'm missing something, it
> looks like link->psr_settings.psr_feature_enabled is never set to true.
>
> More below,
>
>>
>>
>>>
>>>
>>>>>
>>>>>>> [How]
>>>>>>> disable the feature on links that are not capable of the same.
>>>>>>>
>>>>>>> Signed-off-by: Shirish S<shirish.s@amd.com>
>>>>>>> ---
>>>>>>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 
>>>>>>> ++++++++--
>>>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git 
>>>>>>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c 
>>>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>>> index 8ca10ab3dfc1..f73af028f312 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>>>>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct 
>>>>>>> dc_link *link)
>>>>>>>    */
>>>>>>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>>>>>>   {
>>>>>>> -    if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>>>>>>> +    if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>>>>>>> +        DRM_ERROR("Disabling PSR as connector is not eDP\n")
>>>>>> I don't think we should log an error here.
>>>>>
>>>>> My objective of logging an error was to inform user/developer that 
>>>>> this boot PSR enablement had issues.
>>>
>>> It's not really an issue, PSR simply cannot be enabled on non-eDP or
>>> disconnected links. 
>>
>> Agree, the idea here is to avoid decisions being taken presuming 
>> psr_feature_enabled being set on such links, like disabling 
>> vblank_disable_immediate 
>> <https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L4330>etc.,
>>
>> Regards,
>>
>> Shirish S
>>
>>> However, it is concerning if we enter this function
>>> with psr_feature_enabled == true.
>>>
>>> Thanks,
>>> Leo
>>>
>>>>>
>>>>> Am fine with moving it to INFO or remove it, if you insist.
>>>>>
>>>>> Thanks for your comments.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Shirish S
>>>>>
>>>>>>> + link->psr_settings.psr_feature_enabled = false;
>
> Never the less, explicitly setting to false rather than leaving it as
> default sounds like a good idea to me.
>
> But I don't see how this fixes an issue.
>
> If this is a readability fix, I suggest changing commit title and
> description to reflect that.

Done.

Patch here: https://patchwork.freedesktop.org/patch/506242/

Regards,

Shirish S

>
> Thanks,
> Leo
>
>>>>>>>           return;
>>>>>>> +    }
>>>>>>>   -    if (link->type == dc_connection_none)
>>>>>>> +    if (link->type == dc_connection_none) {
>>>>>>> +        DRM_ERROR("Disabling PSR as eDP connection type is 
>>>>>>> invalid\n")
>>>>>> Same here, this doesn't warrant an error log.
>>>>>>
>>>>>> Harry
>>>>>>
>>>>>>> + link->psr_settings.psr_feature_enabled = false;
>>>>>>>           return;
>>>>>>> +    }
>>>>>>>         if (link->dpcd_caps.psr_info.psr_version == 0) {
>>>>>>>           link->psr_settings.psr_version = 
>>>>>>> DC_PSR_VERSION_UNSUPPORTED;
