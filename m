Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DCFC624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1345F10F3C2;
	Thu,  3 Sep 2026 07:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="toboF3DS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D65910F3C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 07:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPy4vnUiaXyOC2H6HI9H48gh0v1YHwbBt4EV8Dle3WNO4dmqI/qoy3OAi0HSC0NTejd5cIi471YBtusuEh9UMncTjCn/eS0K6FNMOivrZRvFagNfwu+cBYXr7ScjDfQPpIFcXr/Vjez4/dtKonzRQSEPqBOWSW61ErnHmWSmcrHjQBJoprdxOpgwsD9OG3EKE3zGeA8AkyQd+wESPdvIkCco4AhU+Pd56HCSVa5RIp7eJZxMdehkACMUOVrYXyTj5ZLP7bZCA3s9RJ4Pm2zd2ywD5SzSl8e5kt/vdc1ww4kQw5zjk+WYkoD5FqvHGydhZtsKwsSRHJZjaHfF3Z0ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvpzdQAahUNw9AfzmjLiM+5ZJisfbpPEw62HY6vO4Ao=;
 b=WX4AW7U7G2NPml6Kc/Oc9xpautI43+pJdAywJi7eerB0r9p8bZrCCroAdAyy23vXG6rCElByZflQqqHJtvY+qmZVCejHfoOc1UqB+Lo7bZ0vifVG9I9dOIhcSpHpv1nEgN01/FZaLERtIA50JgYE9OBBEzsxbVI3P5qw+hy2bi7bZ4Uq9YpSe5vcvLQeiIir5roVPQHuncvLnKRJJ5Tvee7xDHapZmUybRyjLi72JTK3+isZbnwW2y/4ziWYjUZp6h/636FDV24sun2L4Yzba/Z+2Is8V5gZ0qzVr+Fw/MlMe0Fh805xS+dhZnSAAhTANuiCObFEwCKZmras3ysiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvpzdQAahUNw9AfzmjLiM+5ZJisfbpPEw62HY6vO4Ao=;
 b=toboF3DSB+wpOjHBfQyDqKXlzqGeEZ8LofpTaY4vJNO5f5M4DGGU3l/kNvpuqG9+dNlfj02uKcenr8wsmeYilGpi6HTZvzx+nx7pYX+iChDD2ebvrTF2ZO+nZOqkQ9YKiNRW78NQBVPRGSeFexbo8i9aX+0tutYLASCKuLfv1m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:09:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 3 Sep 2026
 07:09:05 +0000
Message-ID: <325f20ff-7944-4295-8d69-ad7f14c69c33@amd.com>
Date: Thu, 3 Sep 2026 09:09:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
 <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
 <IA0PR12MB8208E904460F474C4975950690B72@IA0PR12MB8208.namprd12.prod.outlook.com>
 <SA0PR12MB70916914036CA157754EAAC497B72@SA0PR12MB7091.namprd12.prod.outlook.com>
 <BN9PR12MB514657D40AC8B41594720A93F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
 <f2755b35-ef95-4067-b5bd-0a37ee1df457@amd.com>
 <de1313dc-62bb-42b6-a22e-4775260fd680@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <de1313dc-62bb-42b6-a22e-4775260fd680@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 501e8ccf-8a3f-4496-db21-08df098a3d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: liDgqFs/Uz7JSICiJR/fRvpZsUYwzyDSiMv8nxsJuj6xREJbI/r5PMg3zuSeMcx73FlwW3sGGK3MPqgOaWtRuev0RxCL84XVkDeUiL/mUyB68GoYN5FFdW6xpjX9scP16+eHpLXa0YeavylJMB9T2Dos6oFeA9VMiMsII03FSgYcFi9y6m1HxpNooV8+aoTtdkkk0eRGEENE0AZ31CL3AX7RzETHr6obQf3CiISJKhh6VyELAd8CsBeUh/gd6m6FJvxCXt9skRhmuHKi2wWFMjO5aN6ITzNql+gN84b1Ed4mS4r80ksUPFkrLrwVq+UrGb+7jY+U4IwyWAH5eRb3CXb6HmDqnpqx0wbojxpXGfBkms+azASa+EBw12S/MJW3w6agyJElX1gAfrwi5SZftHjdquITGAEvRzePGtQcacDbuYujxQE5enMa74msXM0Yge5wA0X3z+o8RbwzkS+WBtVuU2eemNaa+qKhvG/MQc+lW/gFgsKvJqROzEfEaEQfrBO7M/3htuuSXoRjyQzxOhEJJyZViy8pVBlSBe6wSBXW6hxPbvdhUEaL4K9eew9uGJ8Z93QiKchjt7Q7yyxDYKbDfDwRzuuKURN6hQOPMWF0It5XKc+O18+x8xiRVKBDvluG2RPmi6+oaQsJv7taUcojODP42NezarGQPX2n5Rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJiQ2oxb1V5N0M3WEw3d0VQcmZKektaNS9hNUVoczU1ajloOTVlWlBGbS9Y?=
 =?utf-8?B?RVZuUnVsYkhJTnl2SVUxOGtYSkJJL1QxQzFkVUFuSlJ0TVhWRTlXbUk4QVd0?=
 =?utf-8?B?S0pSZ3JBZUlhTHg0eC85dFlVSnlkSzhpdkFvaDRTbXRTQzBSMm1OeXM0c2Ey?=
 =?utf-8?B?aTVlSHlVSC96a3JHT0pmTHhURWk1eWEzdjVIRUNNNjNCa3NtMlhTK2QyNnFk?=
 =?utf-8?B?WWNsSjBYK3B3UWRkSlBQUHA4aGIzUVR4eDlSM1pBV09JL3hnQUxvbzBkVTJr?=
 =?utf-8?B?K2lMRG5zSERRcEZhM3BBYW93dTRRSjAzVlQ4c3dseDc5azVzazdTMUVoRnZz?=
 =?utf-8?B?c0pJWWZ3TmVCcURNbXZNUDFIMTVTZVlYTjJMS1U5cEZpSmF6ckhsVnBoQngw?=
 =?utf-8?B?a1RPVVdxWjdubGZGc1ZZYnBMNnFVMnE3a1MyWi81QTRkKzNIT1FxeTdwQ1J2?=
 =?utf-8?B?TTUydWtqZDNMTjlGc29Ubmw0eDE4WDVZVFdOekNDcEIrRnp5eHFxTmV0NEw3?=
 =?utf-8?B?K2dLRE9yRGl4KzZkWmI5YXh5WUxzYnNkQjVybkllMEV5VFVaYmZDZ1orMzJJ?=
 =?utf-8?B?V1o3UHE1V1U0VURuRklOZ1pTcklBY0VFSWRIckhYQ29uQTA1R2pvM09IeUJi?=
 =?utf-8?B?NkpPei9GMWpzNFFQSXJZUkY5dkNkS2RRaXY1NGJwRGgrRlJjNXBTWC8zMkUy?=
 =?utf-8?B?NGhSNDBzWVZxTXhBZVNXcnkxWEtsQ0paTW9OSnR4TGVVNHVtSEFCMlpIRUJT?=
 =?utf-8?B?QVVvdWJWOGZQSU9XNWRlTnQ0aTkwM1ZacXJOMHFlQ2ZVRDVWazZWNDB1VXRE?=
 =?utf-8?B?anFnVW9UR3FQYzBKWHA0SEd5ZjJ0V0w5QnFkRjA5SU04alJ4MmRRNmp0Q2ly?=
 =?utf-8?B?WXhtT1F3ZDFNVUc5Uy95WEVkQmFkQm00dkhiV2xodnQwRFBSWXZZVE9EQWk3?=
 =?utf-8?B?VllBUFg1bytZbXd5TUlrRkdPeW1MYk1XUlAyMnh3cldrbFJRVFpZZjlaNldO?=
 =?utf-8?B?K25KT0JkSjJSd012MTZiNDBEczI1VTRETmxNbDllQ21Td1RnME40aksxQmZD?=
 =?utf-8?B?RzRudWVtQ0Y0bTg5TGhnWWtvOWZkbXZDNlFiQXhGSDBMeU1VWjh1dFhQZ1pm?=
 =?utf-8?B?WktqdTJZYjFCS2hGZTZoV1MreHNBVDQ4bS9GR2o4R1diY21RQ0pqZ3N3RFBY?=
 =?utf-8?B?Y0R0WmFXMG1hWjVhb2JRQ2h0MGhuSFNhclkzNzdVVFovYWxUQklxUURTa2lU?=
 =?utf-8?B?Y0w4YVZDZGZKdVkwaHR0QWcwZzREWWJZR3ExRWt0ZEh0eTNkZHV1SG9GVWkw?=
 =?utf-8?B?YXBwV204ZzF2MUhvcDdOMnpyQXdWQmp6N1VBMDQ3ak9Lb1RxQkNNdHBkYzZa?=
 =?utf-8?B?M095WHUxL29OblYvV21sNm9WTlQ3L3BWZmpZdUw4MEY1TnNFQ1BXTlhRZ2pm?=
 =?utf-8?B?RHlrUXdWVnp5L3YxMmdPZEpma0JKekk3bFZvL3FkdTZFa2s2RXZhUGlDY2RT?=
 =?utf-8?B?ZjlOOVZFSjJyL1gxdk9nWUwwN2g5UGRCNXVvSFJQR3d1MUl2dnpSbUgyWWRv?=
 =?utf-8?B?SHdXSFh5akYrdWRKZXRra20vaFhCSG0xVEdwK0RCek81aHZ0bTdWVkNtenhE?=
 =?utf-8?B?SlpZQzROdEV5cTI1Vjk4K0ZVeHZGeGVoR2tuSllER0Jja004SlhLQmpFMys3?=
 =?utf-8?B?ZmdVc0JULytHMlIvcmNKclgzM3RmaG84R1R5VCtxaGhieHF5a1lJRDIzNXgx?=
 =?utf-8?B?RnE3aTRWdnRURmRZcUpObHFyYlk0dTlybUxKVTZMTjdKYVNqUjVRZnphTmw1?=
 =?utf-8?B?SmZ2WktjYSt5NWE4VThtTUljTFRNYjF4a1B6SWN1Mm5tMFkyQjZ5ZE1NNHdu?=
 =?utf-8?B?bTFHcUkrRkpURmo0Z01aSFVSTW5NaXpucnhheVR3OExyTHlPVDBONGFaWUsv?=
 =?utf-8?B?R09DWkpWRUdudlRqNFNKUHJNYlhuZk54OTF0cDJsZVhuVGRYWm9oUHRKL3h0?=
 =?utf-8?B?Y0dyTVgrZHVuREIwSVJnMHM0akRLODROTFduUXdOa1ltTU5ZYktmWXNwWkhx?=
 =?utf-8?B?OTgvL0V6ZS9PSU1RUmZpNk85QVpkaVNwQlY3N2pKYnNMQmNPa0hsVDRkUFIw?=
 =?utf-8?B?bEoxZGJLN0swNEJnWkFWbGtjeVNLNFBTdXBjWldsWUNyUERHbnNQcGxyMUt0?=
 =?utf-8?B?S0c3dGFBckhTc1ZWdTdxd1EvMit5TENJeGRPOEkzOGZyTWtOUnNubmVtSTVB?=
 =?utf-8?B?dExpNnhncUdhcHM3aDdaY2dnaU55VTBDRHBBUWR4UXVubkJraFdIYkxzM2JV?=
 =?utf-8?Q?DOPCvHWxii61DU03SS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e8ccf-8a3f-4496-db21-08df098a3d5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:09:05.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10sylmoExfL+LvrVYorw4VPKCARJQ9eR0zjxMarG82ObOLUC4PvC/oTk/upZ35g/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

On 9/3/26 06:03, Lazar, Lijo wrote:
> 
> 
> On 03-Sep-26 9:32 AM, Lazar, Lijo wrote:
>>
>>
>> On 02-Sep-26 10:25 PM, Deucher, Alexander wrote:
>>> Public
>>>
>>>
>>> For kernel queues each IB executes with a kernel provided vmid assigned dynamically by the kernel driver.
>>>
>>
>> In this case, it's a device level TMA 'kq_tma_bo' for first level. That address is programmed in SQ registers. When a job is submitted, the second level handler is picked from what is programmed in kq_tma_bo. Do you mean to say that driver will change that value dynamically based on what is provided by user?
> 
> Do you mean to say that driver will change that value dynamically based on what is provided by user for each job submission?

Yeah I agree with Lijo, something doesn't adds up here.

As far as I know the same register value is used for both graphics and all compute queues at the same time, so changing this dynamically on each submission won't work (at unless we complete isolate the applications).

If I'm not completely mistaken we either need allocate a BO per VM and always map it at the same location or give the location to userspace so that userspace so that the UMD can map it.

I don't think we have discussed what the actual plan for that would be.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>>
>> Thanks,
>> Lijo
>>
>>   > Alex
>>>
>>> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
>>> *Sent:* Wednesday, September 2, 2026 12:12 PM
>>> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>>> *Cc:* amd-gfx@lists.freedesktop.org
>>> *Subject:* Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler infrastructure
>>>
>>> Public
>>>
>>> I'm not sure how this works, I thought the TMA mapping is per VMID and kernel queues have static VMIDs.
>>>
>>> Thanks,
>>>
>>> Lijo
>>>
>>> ------------------------------------------------------------------------
>>>
>>> *From:*SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com <mailto:SRINIVASAN.SHANMUGAM@amd.com>>
>>> *Sent:* Wednesday, 02 September 2026 21:29:38
>>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Koenig, Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>>> *Cc:* amd-gfx@lists.freedesktop.org <mailto:amd- gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org <mailto:amd- gfx@lists.freedesktop.org>>
>>> *Subject:* RE: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler infrastructure
>>>
>>> Public
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>>>> Sent: Wednesday, September 2, 2026 8:59 PM
>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com <mailto:SRINIVASAN.SHANMUGAM@amd.com>>;
>>>> Koenig, Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; Deucher, 
>>> Alexander
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>>>> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>>> Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
>>>> infrastructure
>>>>
>>>>
>>>>
>>>> On 02-Sep-26 8:36 PM, Srinivasan Shanmugam wrote:
>>>> > MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>>>> > SQ_SHADER_TBA/TMA registers for them. Add infrastructure to let the
>>>> > driver program the first-level CWSR trap handler for these VMIDs
>>>> > directly via SRBM select.
>>>> >
>>>> > Add kq_tma_bo — a pinned GTT BO used as device-level TMA scratch for
>>>> > kernel queue VMIDs. Unlike per-process TMA (created in
>>>> > amdgpu_trap_alloc), this is device-level and lives for the lifetime of
>>>> > the device. It is zero-initialized by the OS: the second-level handler
>>>> > address is 0 until userspace calls SET_L2_TRAP.
>>>> >
>>>> > Add amdgpu_trap_program_kernel_vmids() which dispatches to a per-HW
>>>> > vmhub callback, and a new program_kernel_trap_vmids hook in
>>>> > amdgpu_vmhub_funcs for per-GFX-generation register writes.
>>>> >
>>>> > Required for:
>>>> >    - RADV graphics debugging on Vega/Navi/Steam Deck (Valve request)
>>>> >    - Consistent trap handler behavior when switching between kernel
>>>> >      queues and user queues
>>>> >
>>>> > Suggested-by: Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>> > Cc: Alexander Deucher <alexander.deucher@amd.com <mailto:alexander.deucher@amd.com>>
>>>> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com <mailto:srinivasan.shanmugam@amd.com>>
>>>> > Change-Id: I0709e788835b69d3d492864de8d5c2d36d0f08c8
>>>> > ---
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 37
>>>> ++++++++++++++++++++++++
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 ++
>>>> >   3 files changed, 40 insertions(+)
>>>> >
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> > index 3ca187f5ade8..5624a5ab5c62 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> > @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>> >     void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>>>> >                                              uint32_t status);
>>>> >     uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t
>>>> > flush_type);
>>>> > +   void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>>> >   };
>>>> >
>>>> >   struct amdgpu_vmhub {
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> > index 31f653ec3fb1..0e0aeea0aa2d 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> > @@ -256,8 +256,23 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>> >
>>>> >     memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>>>> >
>>>> > +   /*
>>>> > +    * Device-level TMA for kernel queue VMIDs. Pinned GTT — not subject
>>>> > +    * to eviction. Zero-initialized by OS: second-level handler address
>>>> > +    * is 0 until userspace calls SET_L2_TRAP.
>>>>
>>>> How is the exclusivity maintained as a user app doesn't 'own' kernel queue? How is
>>>> the conflict of different user apps trying to install their own second level handler on a
>>>> kernel queue handled?
>>>
>>> As pointed out by Alex:
>>>
>>>    - Each process gets its own per-VM TMA buffer for kernel queues
>>>    - It is allocated and mapped at a fixed VA in the process's GPUVM
>>>      when the device is opened, similar to amdgpu_map_static_csa()
>>>    - Before each job is dispatched to a kernel queue VMID, the driver
>>>      programs SQ_SHADER_TMA to that process's own TMA VA
>>>
>>> This way:
>>>    - App A submits job → TMA = App A's TMA → job runs
>>>    - App B submits job → TMA = App B's TMA → job runs
>>>    - No conflict — each process has its own TMA buffer
>>>
>>> Note: SET_L2_TRAP for kernel queue VMIDs is not part of this series.
>>> This series only installs the first-level trap handler.
>>>
>>> For second-level handler support on kernel queues, I think since:
>>>
>>>    - Each process has its own per-VM TMA buffer (allocated at device
>>>      open, mapped at a fixed VA in the process's GPUVM)
>>>    - User calls SET_L2_TRAP → writes second-level handler address
>>>      into that process's own TMA buffer
>>>    - When shader crashes → first-level handler reads from that
>>>      process's TMA → jumps to that process's second-level handler
>>>    - No conflict — each process has its own TMA with its own
>>>      second-level handler address
>>>
>>> The per-VM TMA design is the foundation for this future series.
>>> The device-level kq_tma_bo will be removed in v2.
>>>
>>> For long term — kernel queues are replaced by user queues entirely
>>> , where MES already handles this correctly via ADD_QUEUE.
>>>
>>> Thanks,
>>> Srini
>>>
>>
> 

