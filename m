Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F1606AAC6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MphlBWTY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C351122F5;
	Thu, 29 Oct 2026 13:38:07 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44881122DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnR72UjvA8vM6qHbKXduakhqo9jYDFPASQTrQ212cchych+T5bIUBBPUADOAo/7Vsf5e+5WmRPTnmRGYDV9vlA7B7s7SLFAg1fNztBcnFpuoaakdX4i8T3dwp8RX3WMUHmlkXphTS6JaCpaHls1k5LnFoJPKtNiCK69bFBYBy17DCNUB2vVvsPPvcUxBBBOsbD2gazfsVjvgFILZHaXvZz8cGyBOnB+uJWAxigYxpmk4vyCrP320FigNZUmk53E/QvSLDhsdAP4jz2/zTiW5dAizZtMhyvotk5cieAF9B+N0EgnJYKeWbSUeokEMjE2Ks/kdhiVEEu0iaBHipl75Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtaErBb4lRoVyvGuMh5yXaN5ti1L9gFMUA0IVlesA+w=;
 b=hHGWlosGoSWsGcSXYy/5/U38EjLWWvIhOVXneAz83OXoYL9DVN4VGz95MEk565Nto0Zc6pUdz98b8JU5OWjmz9UycRZF8HMuw673hXmCsyuEHwp/WK2bODGjxdy9a3KIvEM54rZ/mCJ4Cq+F6nOvqKaW62pcKsjhjv3BhZ3/M5cHEHtSAM2XPQHRvWegB2Rww3dfl2QPiaeFPOyfJe0GGx8yqku0QfaoTmSJ3Yl/1luNWFkMrJ3EMFeQdju90/yBKcnn3/zNxNbGb9nVT6sr00AgDXl8aQPapbWfhQH+N0xvPt11PAWZabZlUlFA1vTLwuRfrr38oQ/lBjVqUDFM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtaErBb4lRoVyvGuMh5yXaN5ti1L9gFMUA0IVlesA+w=;
 b=MphlBWTYGLN2nJS9uNapG+hlQ5UI3/dgD0qSk2VJel6pqlKADU5VeMftJBQOtDsLOIz1P3imTbmZheoM31kWCU6c1lyBVoKIeu7BVj5yCRL9VyEBtVAq8MjeJJDbxAbdxQ2WCHEtm+BTuVHZKVw2NISd99bidiG6dh3UCW3MWXw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:37:36 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:37:36 +0000
Content-Type: multipart/alternative;
 boundary="------------nfWTKlW0g5XsLq20sJDG1Bhs"
Message-ID: <2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com>
Date: Thu, 29 Oct 2026 09:37:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
 <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
 <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
 <DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com>
 <f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com>
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c74e8a4-9e89-4ffc-fdea-08df35c1cae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261019132127099003|261019125427099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: j6ABF/YFXIvF2GNTQaXRY2UFY06+BokG1sgmIhglXgLnavsNJDZ041EOnQhEi7mPMYb41KVGQQGFswJrCwUo10kcemCMuo8LUeAPWHni+GxAHbdHwqkIqS1+3nPYLC9TXy/NN3Xf12zdE/wMKrDLqWiRdqyAUatob02LupjluRXL2pUAy+t1YUkEknATEXQhQyRQOctspalpRK/actOJW3O3Te3TlNRbmIQ55ilY8wCx0+ghK+8hkuDMoWI3A9hukZuoid2hj8v85uBfoCUMeFA/c/oaJuxKoz0PNV9t/ib6gkIm9oAcik/sAguaqR9xNozmUkBDpjWKcssfrgDM9/TiFPyjVjjYOeabNcI59kn7aMekQxkqVBFvfdXyYsbDhzILFHhGjsX7sqOtO5irAn0dRz+2Wm7fc9b7RAi+Jlcr1p2Tmwd80iUAXZL2nMA1iXejZB1OsbRG5T5BtoF5rk31p+/N/xiWzypMq8AXRO0bTbp75KP0G37ckMHVAC3idiEi68an8CP1hZap0rWpfhiPtHiO/E+Br9Xks67nRTt5ncNlrGVjDPjdql3TeoXzTxyKfEDXjOS9fWd0sqTTYzY/Gfl/RhGenw12HVYruukDP38VTXLj/rHSFHRUgoZTpCKg/Y7gxUPeuHVh5ykE9FUPXGymswVpazwupRfk5pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261019132127099003)(261019125427099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1U0NmszVVgybTJIK1MvVFFiMWZ4ajljNFQ4VS9tejNBMDl6b0VNUEVwRlg0?=
 =?utf-8?B?cUlZN0FCdTZ0U2FrWE8vb0JKUG5pSkhpUGdiUUVnVmFUampjcHZuekhnUU1Y?=
 =?utf-8?B?TjUzR2FIeTJwNHh1QUw3SzNpQzNVUlhuT043ZzNLMkhxakRwZVQ2SkZiOWFJ?=
 =?utf-8?B?c0lvenVxNjY5dzI0NUNMRjRkQWZIV1ZGWGNJdlpuSGZWUURLWHdVVG9mT2Jy?=
 =?utf-8?B?NG9zcUpIcExMMk5WSk5oeWRqRjc0YUVUaDJOQzQ0blROWENtUXlGTXhqQ0JU?=
 =?utf-8?B?RVphSGpYUFpLeW8yOVZzaWQ5M3lLUGMwM1ROS3d4U001NXhYNUZtRW5NcVlI?=
 =?utf-8?B?SDZ5U2d0TEM1K25WTWtZNW9FYTVaL3pLaTZxMElCVmJLSFdqOVFFeUMwU3VW?=
 =?utf-8?B?aTlDclVodFhjN2pRV012Q0cyVU5TaHhqZVlPbGE1N3FVS1pUSDh2NE4rMHdN?=
 =?utf-8?B?K2tVcXhtSWVBVjZNc1IxVFFYU3grKytRbmlhb1FVSVZpWTR6bmFnVWx5ZW91?=
 =?utf-8?B?QVdIalZlNk9PeDk4Wm90RXlIWnVJcDBHbGx0L1RyblBqWnY2RWxuNkEwU1dk?=
 =?utf-8?B?L1FCcTgrZkh0MDEzZDRnUi9ZMG9sVXU0MjY2dEdTUytDRTRzaVBBWml5OElH?=
 =?utf-8?B?ZVBvbkZmbjA4THdEVzY0SzdPQWEwUHNyL3FoR1Z2VGs4bG10dWVwZXhNemJw?=
 =?utf-8?B?aEUybjdWMmwzWExJOEFPWmlYbzlBeTlZTzRya2l6Ukd4M21xZmttNlJSclBT?=
 =?utf-8?B?L1Z1YzBsRUhadjdZVWlaeHMyZko3d3dUaUExWitESnh3OGNXY0MvYmpIeVZi?=
 =?utf-8?B?bWtJZ3NsOEE5UFBleElVYnNDeEVoVUo5aXRqUFhOb0c1eTNkdDMwUGF2K2tP?=
 =?utf-8?B?ejRVQ24vWnNCcWw4aWhUOGFxWTUxeUU4UDVxaVA3dGtJeFlNOEJOSStGcXhP?=
 =?utf-8?B?OVloMXRwV3pMZTZ2cUE2eDU1SE1vUitKbElQUzJFZ2xKTGxqOXZZd09mdUhJ?=
 =?utf-8?B?WlN2cnFwenE2bWlZYUQzNlJ0N1NuS242WFdEOG9PaTlkdzBtZDZKaHp4Sm1O?=
 =?utf-8?B?dExub0hJTjF6YUliTG5Da2xmL3daZFFUaHFaa0UybXcvSnZjaUZCaW1FNDRX?=
 =?utf-8?B?VFJWTUdKN3NPWlVSTzA5WFBZd2hldzFrY2RCeUsxd3J5RXZuenFLa1lENGE1?=
 =?utf-8?B?akd2TDlkS2xEaUk4VUJyYnBzWUliaGZSV0huL09CWkJoQVB5TzhGUlR6ZDZZ?=
 =?utf-8?B?aVFvckJuNnV3ckx6c00zR1ZSVU5BZzFINFZ4VlpSRWVDL3FjMERaV3lueVVo?=
 =?utf-8?B?NExIR2RrbkJoSXZzZU90U1A1Q1lMUmI5UFVlL1NRZ0Z3Tm9aUlloUjJZbFBj?=
 =?utf-8?B?d1QxS0d0MllkMWQ1WVRtZHYvSHNjZEFFKzBGa3o0a0FOK3ZaY3hIaTY1OVpB?=
 =?utf-8?B?Z2FYK1dKeWJoTkdwSGN4NkFnYjU3djRKSWw1UURvRVFOYjBKbU9MS2x2bndo?=
 =?utf-8?B?cnZIOHF2aVNUYVpWeHRDdnV4U0ZkUG96dktaTlhWVG9ZMWltQ2dTTUdIVFB5?=
 =?utf-8?B?ZXRoSUhoa3lqVFY2emlDUkdkQ1hGek5WcmMrcFJjQnBqQ3owRXhOYXlLcWxm?=
 =?utf-8?B?cTRSZTA4OG5zTnZ6a3FEWXo4aUYzMnZkeTllN2U3dFBwWkF1TzB4SUNxTExH?=
 =?utf-8?B?dW1ja1ZhQTRFOVg5RDdWOWo5clBxWFY0Q2YzQVlrSFp0S0U4SFRubVB4aWxl?=
 =?utf-8?B?Qjdkcm9KNUhqWnFUL3h5Vms3dlhqcGNueVpkK1cyRnYzMlA3ZlFZZ0VhQ01C?=
 =?utf-8?B?dVh5bnhhSlBPRzkxcEpqTzI3akllem02QW4xWGtpWlhjcUE1S3hWRitYSEcv?=
 =?utf-8?B?eXc5a0laQkUvcW9uWHFhWnk0dFpzNmFKT0VUWFIyMmlFQVg5UmsybWlKcGg3?=
 =?utf-8?B?Nms0VkQzK1kwOTdHRVlqRXNFTi94MTdjV1ZHZ1NhSlBVQXcyenJmNW1lMWRX?=
 =?utf-8?B?Y2ZzTlpHSXFCTFNUZkRXS2pUZVhDR3g1bGdFekJVVFlDM2lvRlFwcnJ5Nito?=
 =?utf-8?B?SFhoZlhocG1Fd0xIMGtXZm95c0ZRcWlPQ2swaEZYSDZmd1RNMTVDdUhTeHVl?=
 =?utf-8?B?dU1jTGxmWENzVjRNOHorRzZNOFMreEF4cXJsSlljQy9LeVNYT0YvMzlFMzk3?=
 =?utf-8?B?NWJkcWZ4Wm00QlZ4Ym9kYmJNTHRtYm1tMUY3ZEhlTDJ0a0lHaUxraUlWbHdM?=
 =?utf-8?B?VEQ3UjhSRFJmbGZ0RUZpWVZMcWNkMTVaY1JnRmFsc2ZqYXhlZlB1bjF5ZWFF?=
 =?utf-8?Q?IGqgK7+fcoC2T6JM2s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c74e8a4-9e89-4ffc-fdea-08df35c1cae0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:37:36.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1dFOS93qQke3FbF3MilhA32JP3fsUYpYmggQIAabseFJWYWrpg+RqUbvdeRmMUQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------nfWTKlW0g5XsLq20sJDG1Bhs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-28 23:13, Zhu, Lingshan wrote:
> On 10/28/2026 8:53 PM, Zhu, James wrote:
>> AMD General
>>
>> Hi, Lingshan,
>>
>> Sorry to reply later! Just be back from vacation.
>>
>> Yes, there is only one set of PMC registers on the device.
>> But the minimum control scope is XCC. So, I think we should design PMC based on
>> Node instead of device. We need not enable the PMC on XCCs which have no PMC
>> data collection request.
>> Since the request is based on render node.
> They are per-device registers, so the scope should be the device, not XCC.
[JZ] where did you get this information? From what I know, Compute / 
Shader PMCs / RLC & SPM Control / //  /  / / PC Sampling are all XCC 
based.  a are all  are
>
> Another reason is, I assume we don't want one user to sniff another through PMC.
[JZ] if it is true, is it more easy to sniffer  for per device design. 
the other nodes within the same device will enable PMC unexpectedly.
>
> Thanks
> Lingshan
>> Thanks & Best Regards!
>>
>> James Zhu
>>
>> --------------------------------------------------------------------------------
>> *From:* Zhu, Lingshan<Lingshan.Zhu@amd.com>
>> *Sent:* Thursday, October 8, 2026 3:50 AM
>> *To:* Zhu, James<James.Zhu@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kuehling, Felix<Felix.Kuehling@amd.com>
>> *Cc:* Huang, Ray<Ray.Huang@amd.com>;amd-gfx@lists.freedesktop.org <amd- gfx@lists.freedesktop.org>
>> *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
>>
>> On 9/24/2026 11:40 PM, James Zhu wrote:
>>
>>> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>>>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>>>> This commit implements a device-wide PMC config
>>>>>> for amdgpu, which including the profiling owner,
>>>>>> and the profiling enablement indicator.
>>>>> [JZ] I think it should be render-node wide, not device-wide
>>>> Hi James,
>>>>
>>>> It could be, but we don't have a requirement document defines the scope.
>>>>
>>>> But normally a profiler is a device scope,
>>>> I see KFD profiler operates on all queues under the device queue manager
>>> [JZ] One device could be split into multiple nodes with different processes
>>> running.
>>>
>>> I am wondering if this is really we want.  Ben may comment on it.
>> Hello James,
>>
>> Sorry for the late reply, it was mid-autumn festival and national holidays.
>>
>> In my understanding, there is only one set of PMC registers on the device, so it should
>> be device scope.
>>
>> Thanks
>> Lingshan
>>
>>>> Thanks
>>>> Lingshan
>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com> 
>>>>>> <mailto:lingshan.zhu@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>>    2 files changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/
>>>>>> amdgpu/amdgpu.h
>>>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>>>        AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>>>    };
>>>>>>    +struct amdgpu_pmc_profiler {
>>>>>> +    struct mutex        lock;
>>>>>> +    struct drm_file        *owner;
>>>>>> +    bool            enable;
>>>>>> +};
>>>>>> +
>>>>>>    struct amdgpu_device {
>>>>>>        struct device            *dev;
>>>>>>        struct pci_dev            *pdev;
>>>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>>>         */
>>>>>>        struct xarray userq_doorbell_xa;
>>>>>>    +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>>>> +
>>>>>>        /* df */
>>>>>>        struct amdgpu_df                df;
>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>> index c924a55fd16f..74ed42e53264 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>>>        mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>        mutex_init(&adev->benchmark_mutex);
>>>>>>        mutex_init(&adev->gfx.reset_sem_mutex);
>>>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>>>          /* Associate locks with lockdep classes for ordering validation */
>>>>>>        amdgpu_lockdep_set_class(adev);
>>>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>>        kfree(adev->pci_state);
>>>>>>        kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>>>        kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>>>> +
>>>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>>>    }
>>>>>>      /**
--------------nfWTKlW0g5XsLq20sJDG1Bhs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-28 23:13, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com">
      
      <pre>On 10/28/2026 8:53 PM, Zhu, James wrote:</pre>
      <blockquote type="cite" cite="mid:DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com">
        <pre wrap="" class="moz-quote-pre">AMD General

Hi, Lingshan,

Sorry to reply later! Just be back from vacation.

Yes, there is only one set of PMC registers on the device.
But the minimum control scope is XCC. So, I think we should design PMC based on
Node instead of device. We need not enable the PMC on XCCs which have no PMC 
data collection request.
Since the request is based on render node.</pre>
      </blockquote>
      <pre>They are per-device registers, so the scope should be the device, not XCC.</pre>
    </blockquote>
    [JZ] where did you get this information? From what I know,&nbsp;<span data-renderer-mark="true" style="scrollbar-color: rgb(126, 129, 136) rgb(31, 31, 33); box-sizing: border-box; color: rgb(206, 207, 210); font-family: &quot;Atlassian Sans&quot;, ui-sans-serif, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Ubuntu, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(31, 31, 33); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Compute / Shader PMCs / </span><span data-renderer-mark="true" style="scrollbar-color: rgb(126, 129, 136) rgb(31, 31, 33); box-sizing: border-box; color: rgb(206, 207, 210); font-family: &quot;Atlassian Sans&quot;, 
 ui-sans-serif, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Ubuntu, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(31, 31, 33); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">RLC &amp; SPM Control</span><span data-rovo-chat-copy-id="4fe0b2be-ffd0-46d4-9a13-8fa868866b6a" style="font-size:0;display:inline-block;width:0;height:0;overflow:hidden">&nbsp;</span><span data-rovo-chat-copy-id="1fc68f57-5051-45f0-9fe7-819f3a42fae8" style="font-size:0;display:inline-block;width:0;height:0;overflow:hidden">&nbsp;/
      //&nbsp; /&nbsp; /&nbsp;</span><span data-renderer-mark="true" style="scrollbar-color: rgb(126, 129, 136) rgb(31, 31, 33); box-sizing: border-box; color: rgb(206, 207, 210); font-family: &quot;Atlassian Sans&quot;, ui-sans-serif, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Ubuntu, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(31, 31, 33); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">/ PC Sampling are all XCC based. </span><span data-rovo-chat-copy-id="571b43b6-9869-403d-a631-bef4e4d01c3d" style="font-size:0;display:inline-block;width:0;height:0;overflow:hidden">&nbsp;a
      are all&nbsp; are</span>
    <blockquote type="cite" cite="mid:f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com">
      <pre>

Another reason is, I assume we don't want one user to sniff another through PMC.</pre>
    </blockquote>
    [JZ] if it is true, is it more easy to sniffer&nbsp; for per device
    design. the other nodes within the same device will enable PMC
    unexpectedly.
    <blockquote type="cite" cite="mid:f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com">
      <pre>

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com">
        <pre wrap="" class="moz-quote-pre">Thanks &amp; Best Regards!

James Zhu

--------------------------------------------------------------------------------
*From:* Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
*Sent:* Thursday, October 8, 2026 3:50 AM
*To:* Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>; Deucher, Alexander 
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
*Cc:* Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd- 
gfx@lists.freedesktop.org&gt;</a>
*Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config

On 9/24/2026 11:40 PM, James Zhu wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 2026-09-23 23:23, Zhu, Lingshan wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 9/23/2026 10:13 PM, James Zhu wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On 2026-09-22 05:34, Zhu Lingshan wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">[JZ] I think it should be render-node wide, not device-wide
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">[JZ] One device could be split into multiple nodes with different processes 
running.

I am wondering if this is really we want.  Ben may comment on it.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, so it should
be device scope.

Thanks
Lingshan

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Thanks
Lingshan
</pre>
            <blockquote type="cite">
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a> 
<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;mailto:lingshan.zhu@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
  2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/ 
amdgpu/amdgpu.h
index 8eff6b9ebe81..45897dca802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
      AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
  };
  +struct amdgpu_pmc_profiler {
+    struct mutex        lock;
+    struct drm_file        *owner;
+    bool            enable;
+};
+
  struct amdgpu_device {
      struct device            *dev;
      struct pci_dev            *pdev;
@@ -818,6 +824,8 @@ struct amdgpu_device {
       */
      struct xarray userq_doorbell_xa;
  +    struct amdgpu_pmc_profiler    pmc_profiler;
+
      /* df */
      struct amdgpu_df                df;
  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
drm/amd/amdgpu/amdgpu_device.c
index c924a55fd16f..74ed42e53264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
      mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
      mutex_init(&amp;adev-&gt;benchmark_mutex);
      mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex);
+    mutex_init(&amp;adev-&gt;pmc_profiler.lock);
        /* Associate locks with lockdep classes for ordering validation */
      amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
      kfree(adev-&gt;pci_state);
      kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
      kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
+
+    mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
  }
    /**
</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------nfWTKlW0g5XsLq20sJDG1Bhs--
