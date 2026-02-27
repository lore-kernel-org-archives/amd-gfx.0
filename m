Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EBFFEFB42
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 12:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE4C10EB23;
	Fri, 27 Feb 2026 12:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dq0pkpy2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20AD10EB23
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 12:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ly6njJZiXVF2EIHvWK4sNQhnJHGxHrnVJW8qCMQmswYFyO3BKn2HNwvlUtJrV0BPnn+LpIYnitRC/JtH3i/inxNHvJVbWv0JWaic5jFDhHxF3msuQ/pO3AU9L6U1x9mc0qFSsydmHsxH9YNqnLg4YAZJfA8UGjTnncF0q1j1jdSsRmOg1t9nEtnNoS73Qng3TSmVFKmzSZu3km0YPASJMpJDC/bLvpc8S+KnAt92eUxgNVmQSP3Yr+dXeKpSOXVgV4AkOY9RuIIKr24dTaHJ16sLpinpy+VW1W7t1/QBmSTBUuA6IWt6KMesZMBmzN/4j85QphwqlRlvFOkyZzX7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qFEaJ8oUBVa/b4wZWX5csZjCfO6smG7jzai9+VecWQ=;
 b=qyxEQ06gXntSNrHewl5HBOzMQeTKkSbi7m/NLfymlOFjMkfH38+5xHR50YuSwZahVsZHavHAelzd/PnEZ/0qP+Rob6xYVl2OstS4h3aFXY/C2gZLOMR0V37vce6ESG4SUoCExOnF9IJSm+1vdQ1+pe1whQXD6CzDgwk4lO/zM4t8UdCctw6rHxwYquDXCIBfrMsQ959j+z85XGJx8Fzwq93tpZCl1Kvjdb2sC+HyNDVn8k4N/2X3pvwgKktTpVKv0auNQ3FTBDJHeGn4kpOxYfGUWhPCZOdWZb8A4XYnvHCZn0SK/m+EbuXeTScALYx1xAqB9VN4kgBvpG8B4owIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qFEaJ8oUBVa/b4wZWX5csZjCfO6smG7jzai9+VecWQ=;
 b=Dq0pkpy2XXWujYouvMaJLLCRJI6hn3QJ27k22DG4PvljrJpzq30l6O5GtuW0zNJcRueDEZ5r5ecyUoOVnECigghXDiE3il3jDOeOSiwVnMaq4B1LJZI8MUDglKTjyQP8fw+izjV7R0aORBke6ClgNMCCRy/QZ/9ELe9+n2kanVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 12:15:35 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:15:34 +0000
Message-ID: <2de62d5a-e03b-4486-b622-ddd14c888fee@amd.com>
Date: Fri, 27 Feb 2026 17:45:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
 <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
 <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
 <6e1ec357-6858-48ae-9447-e915fc946417@amd.com>
 <41773dd1-0929-4c5e-9c67-07262ee299b2@amd.com>
 <ae213ed7-ba5e-4e9b-81ac-95e20abd8b1d@igalia.com>
 <1b52d686-5083-439d-a8d5-518d6683e0f5@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <1b52d686-5083-439d-a8d5-518d6683e0f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: d2df52b5-6121-46e9-b05a-08de75f9e8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: WkGBSrVecOWEU3WvOENlYqyVJQgaJDF5sH7/2x6B1xDFD6zU3THOwvLp0VEpbrHu9DcPGJMfdO1kmD7F8aFXLYiHJRVVoRrpGage8Z3JjLS9uOrrRqff5m5hIAvo6ndfovlnFocjolwL2XpDBFQ6X8A+Vh0/JSTi3vGxghNgQM2EB6Dn1k/lhJNpDm50EnSEA3L7x3izL9rIP0VmYhdg/tfe0BCOcHD4GLDLwU9HBH3ND79SCodjmCq8aSAwESScNuwrpEDoXVrbQiCpRSJbU0ZPbckrDT+lWcpplGlGLRiXRIYm/cEW/5mGY/B8s6u07VRjyZYkKxZD0h4Dhzu4GSRUGycUe47F2tv4lQuRloaCIM6rcmr1MhbkCLvSXacrh2Pf9eH7M5iQ33iSuwDD9f7ZuVxFayyTL1IyLQZaBYgZFbp36K4p5OG0hW0Ikg74mM895hQ3yPDCPSGIGi3EaR1SQjo/JFSb/Abnwhx76oA3V8CXx40Q+DDrrTvPO7y1RKPSMusM5HAXW/fsVclYsdned/XwUIxq1672fdLHqaZzXKqrnIDXzWiL7ggL0VVA3tKvgU89IIYBW7xQzZTzy8hEajSgQUIGnlHNdVY3JbtLwD7pmj0aXEWkgExz/8WTpa8S/DevDM7UTCDIXLv6DiXdO1Lp8sUFwRGi6FxxF68gi6C7JUHQ45Qr+ZvHFp1H6l+qM1ZS1U7lMJMUVF9rPIsq6EYGjxhAyKfVKYs4cSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lNZDBmQnA2bGtMb1ZDa0VqN3k2ZHlQZ2E5RlkwSUZVTlVSN0VwOEtQM25O?=
 =?utf-8?B?SitjRUF1VEYyUm5VKzhUTTVscVduWE1ma2p3cWpMVElLSDA2blpxUjhTL0dq?=
 =?utf-8?B?eVVPMlRIUHlMd2ErNkI0aTgrOUdJcUc5MGxXQUlFYnJtcDBydW1XNkRqZjhh?=
 =?utf-8?B?bGpZN3FwNVlxYjlaR2JJaER3aEdBMlBLMnFaQWFJV0JCU3ZxUDQ4MTJmc0ZE?=
 =?utf-8?B?bElsemdFVjc2U0tEZGRVbENhWmxsVFVNQnRwWjNOR0xkTFdMNHBIL1VlUlhS?=
 =?utf-8?B?VGFxNnlLT3RYb2RuMXUzTWxreThOMmJXMTVXRXBuc21RRmdGMUljck1pbkVW?=
 =?utf-8?B?UytnTWVSVkhlQThzUHhjNXhSOHl1SmIzNmlWQnlZY1BwK0tuaVVpNHlUOXUx?=
 =?utf-8?B?KzRMOGd0aHpSSU9haUFqejFiVldKSlNhd2J5MGdPdWJhbTA2cVMwZ056ZlA1?=
 =?utf-8?B?S2t5MFJSYkozdnNIaHJ4aExCR0NHU2pSOU5KNHMvN2ZUOWFTbU9hcmN1djc2?=
 =?utf-8?B?NmM4U00wazBZZWZ1VlArNG9JOFVhOEVTUVlsczF0cFBGQTI0cWRpVmduak85?=
 =?utf-8?B?TGV0SXdZendwWWFEMUxUdzR5MFRZTGVKSnVxaSsvdXloWmYwK3Ztb2tQU3k5?=
 =?utf-8?B?MjY3NlJLUXBkZnpPZit2TUlhenZhS0pQQUxvRTIvVUh0cGpuazVUQTI4SjJl?=
 =?utf-8?B?M0JvRHlIc3VGNlJWNDJxSWwvT1BGTXhzYUlMcHd5dnljWkpaaWZLMEdjMHA3?=
 =?utf-8?B?V0c4UWN2S2plbUljTzhvajhCZVlOL3V5OWl5aittNVVocUUrNFNNZ2FmRktI?=
 =?utf-8?B?ZFhLM0d6SXJLb0NXU2xKUkxBcmt1bmdVSlZoRVZ5N1FZQWhBRXVyNWRhQUEr?=
 =?utf-8?B?Y1FBZTg4Q0UrVVptUjA1aWxSZ1FMN1NGajJyM1piZkRsTTFFYjJydi96aXJE?=
 =?utf-8?B?UTJBM0VzTitCc1Z6NUNGVVQwOVR4RU5USTBBd1d5Z3lwcW5jcWFRMlZmajB1?=
 =?utf-8?B?eGxRWjl3VXJ2K1d5Kzc0eDhkY1dkUWFUMDM1ajJVaTNuYUZ6UlBLU0FoSTNp?=
 =?utf-8?B?N2JHMFRXUXhGR2tkZVBjekhMcVQ1ZG5zS3R1THNtK1I1RnVJZzcraVYrTldI?=
 =?utf-8?B?Uzh4VlBtRzNaM1NWc0xLdy9SSE1zN2craWpWb2pvWHV2VFF1aE8xek44dTAr?=
 =?utf-8?B?eW9nOWxmNDBpSUN2emRCZEpYcDl1cGo3RTlSazZUaXlVMkhCK3Fsa2xTaGJS?=
 =?utf-8?B?NUQxeHNmRGVVYnRYYjZKcGFkbnI0NTlIT0pPSDJuM003WEFSVW9zcXJKU2NV?=
 =?utf-8?B?NHp3MDhMR2lRSTBrK2RuVEExSjQ5amhEOFE5WVQ1citDZjZ6RnRQRjZuVW9j?=
 =?utf-8?B?cCtPRFd5NW5iaVhWYWpLTVk1Nk5aZnhHMHhRUDU2eUloWEg5TUd5SzJhOE5B?=
 =?utf-8?B?S3h1KzcyVkhNTFRBRndzeUxQY1dmK0Y0eU13c0JMSTJBZkUxMVJLRnpQME5U?=
 =?utf-8?B?N01ZSTNYdlQ1OXRreDhRWmZTTTE4bHpqbGNEalhZZjQyV0ozaXh3ZCtoWkdP?=
 =?utf-8?B?Rm55b2loOUlQQ01SRDROdkNOWlRqekprNnFmcTVLWDVqNWRVWC9DQWQrN254?=
 =?utf-8?B?aXZ3NjVtOG9tUU8xR3hLd0pZNFg0RS9lQkRIU09EK0VGUm9QQ2k5dEhDcng0?=
 =?utf-8?B?bkdVV3dqemtYVS8wOWtCZjdySkh0Q0FmZ25IUG5pMUlvOHlEbThKTGZjOWt6?=
 =?utf-8?B?NEpIVForcjFUM1hyQ3p5WWpDTllITlJPT01ySGtXRFBJZUxXaGQ4ZHBsRGVq?=
 =?utf-8?B?cjRSUk0wY2xmS1ZxSVBrc28vOXlWZzRBSzRoek82U1hpUDBkd0o4Q0dVbGN6?=
 =?utf-8?B?L1VzUWUzNHk0K2d0OXl1SlFYNjRyTXZQdW5WMnd0QzlmaGpXKysrcFA0RjJR?=
 =?utf-8?B?ZEZIcHBSUTY2d0tkRlh2a2ppZElyVVk4TThvZ2FoRzFEVHVyOXpybEZWdVVZ?=
 =?utf-8?B?TmJlMXZDZDNrblpGQkdIbVgvUk9yU3lLeFp6VjFZS2pBNG96WVR5b1FpRS8w?=
 =?utf-8?B?aU9YUUE3N2d2Q1o3RlFlK1IvWDdtbjBRTVlQYm1NcGZQTWRId2RReDRNcVR4?=
 =?utf-8?B?WWZ5VlRGdmNUeWN5S09BLy9INlVEQi9DRzRKNGJYYStkTjVjWnkvamRJUTlP?=
 =?utf-8?B?ZmovS2VpQXByWXJJZEVxa21HOFJ3V3ViNlkvNFNsQXZXUk5jREFIaFh5MnJt?=
 =?utf-8?B?c3l0UkxkWmtUSXhRRFpNY3pHdSswaE85a045azRRNG9pSDNDT1FoUy9XWkxZ?=
 =?utf-8?B?bFVTenA1WFRmZjdlSk9SMnA3NEtEZEtHS2NZOEF6NjFkVFVqUHRudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2df52b5-6121-46e9-b05a-08de75f9e8ed
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:15:34.9403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S7G7L5pgAZxxeeGwHIZ03plBH6kCZBoOIvcGVaXUtdY5uW75UbUNWYwtHD+9++HKgcIirdhwciP4VKKJfjLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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


On 27-02-2026 05:42 pm, Christian König wrote:
> On 2/27/26 11:41, Tvrtko Ursulin wrote:
>> On 27/02/2026 10:32, Christian König wrote:
>>> On 2/27/26 10:22, Khatri, Sunil wrote:
>>>> On 27-02-2026 02:43 pm, Michel Dänzer wrote:
>>>>> On 2/26/26 17:05, Tvrtko Ursulin wrote:
>>>>>> On 26/02/2026 15:51, Sunil Khatri wrote:
>>>>>>> update the type for num_syncobj_handles from __u64 to _u16 with
>>>>>>> required padding.
>>>>>>>
>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>> ---
>>>>>>>      include/uapi/drm/amdgpu_drm.h | 4 +++-
>>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>>> index 33e8738ce91f..42b4c0f6746b 100644
>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>>>>>>>           * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>>>>>>           * @syncobj_handles.
>>>>>>>           */
>>>>>>> -    __u64    num_syncobj_handles;
>>>>>>> +    __u16    num_syncobj_handles;
>>>>>> Could probably cause build warnings/errors for something which builds fine today. Hm on big endian it actually breaks completely.
>>>>> Yeah this is a clear UAPI break, no go.
>>>> Yeah i am holding on this change for a cleaner solution. I acknowledge the UAPI breaking here.
>>> This uAPI break was intentional. The functionality is used only as experimental feature behind module parameter and new FW anyway.
>>>
>>> But we didn't wanted to break existing Mesa binaries for easier testing and so kept the ABI for x86 intact with the padding.
>> Ack, I wasn't aware, sorry for the noise!
> No, perfectly ok that you mentioned this.
>
> Alex, Sunil and I synced up on this yesterday in a personal call and we agreed that breaking the uAPI this way is still ok at this point since userqueues are still beta feature etc...
>
> Everybody else obviously can't know that, so we need to include this info the commit message.
>
> @Sunil: Can you add something like "Breaks the uAPI on big endian but userqueues is still a beta feature and only enabled by a module parameter/updating FW.".

Sure christian, will do that.

Regards

Sunil Khatri

>
> With that Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.
>
> Thanks,
> Christian.
>
>> Regards,
>>
>> Tvrtko
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards
>>>>
>>>> Sunil khatri
>>>>
>>>>>
>>>>>>> +    __u16    pad0;
>>>>>>> +    __u32    pad1;
>>>>>>>          /**
>>>>>>>           * @bo_read_handles: The list of BO handles that the submitted user queue job
>>>>>>>           * is using for read only. This will update BO fences in the kernel.
