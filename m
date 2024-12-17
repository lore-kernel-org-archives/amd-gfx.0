Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F837E7716A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 09:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60F510E8C8;
	Tue, 17 Dec 2024 09:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ruQucVO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3656A10E8C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 09:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sogi0haRCAJGnWJ+XcWU/tqtebAJka82dIirnwreSmxjx4KJxFts15AXvHFhh4JMhZ64TdCFGAeCYUU7bBlGlWnYBvXKnqJazqOATAiIOBYFbKPeWyxa0HpAbDOie5rIQC7qYPwh02SV0+4FNtQaDobUgY+23bVNFQi42/G05Q0Hh48JzNdvDyyMACxjLFirQbkYzUQ14YZEhhUDtOedx7Z18U2iRIHeCex/Mr3hG0HIzSjMkcOGdNcvwq+k8w1zpl1IaJ+36IlPPFTzFmGlKI/DbIk5tWgmuKquxBmilkp4bZ0HQRPtRRR9OlR+MTBHnoca8wt5pSQ/Hhg1i4Qjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdTyD3ePOmZ8pzbdUWy1N3olFU6v6AgtZavyHNhfOwo=;
 b=H4RlqW+VMs9dgUlZu+G+7+wdUA0w5qMWPz9q1rklRNm91kCvIZUbBDUc5eG6NZchzo/ydyWJUPN9Sk1TWKTf+WJesNtqjA5Bt7B/AcdL8ZIlZCuQWIJquazTZwh8YXAQzrdiiish5j1sBi9dYBQpUA2zW9Wo9Y8uElU+t0LzZNfpTF8RvpSKiAfWLhIrwWQ6k9JIIMMup3+Cq1sT+WrmsPIDwpN/MYOY3wvurrHxP/Fh4gjWfPzswnKLJ1gV+Pn3korWbDM+njxg7/GGTrV6vnT4T0gsWV2ZnVJ+2nJWofnWs9w+5fk4F4C7tMEiqE1Y3/ujs7EpA/pTZzKrC0v3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdTyD3ePOmZ8pzbdUWy1N3olFU6v6AgtZavyHNhfOwo=;
 b=3ruQucVOI4Ur+2xbfnjSbQN5dvZ5GL0lYuSZLNjdtEfWmdW6ne4whQp0GVzH7s9aj8WCaqAZ47G26YzgQsUpdoXFMVROMC/l0q8oHJdflJrZRQSRlC5qzWu2GY/kdLaFp4OyRt3+UjlQPV2i/WsOoKd6FG2bB1KR7i5Pa2ejX8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:46:41 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:46:40 +0000
Message-ID: <c5f8cc28-9cde-4341-b552-6366ba9b4b00@amd.com>
Date: Tue, 17 Dec 2024 10:46:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
 <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
 <e4766f68-a377-42f5-a166-50493bcccd83@amd.com>
 <c4af4333-c310-4557-b081-fc4e1d3a47d3@amd.com>
 <e55d609e-0719-4719-b66a-4772cc55dc4a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e55d609e-0719-4719-b66a-4772cc55dc4a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::19) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f6e187-b1e4-4463-ddfa-08dd1e7fb530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEpCcTljTTdHcXVkNEFCd0R1L3orTmptRml6TElxWEVqNXpzZS9EbnBjUTNn?=
 =?utf-8?B?SWl0VTh5RTNRY0hWTW9vTUplbFJGOVlJVWhoSERKM2ErYzNaTXY4QTJUU0Nx?=
 =?utf-8?B?SC9wV0pkZ1ZzUlRvdkVCMUMwdDYrT1JicUVIS2MzYlZyOVo5djVrZGZMYWoz?=
 =?utf-8?B?V0Ixb1BtRy9ReTR4OVA2Vk11VkJEcmtBc2s2NzNLclVwOFdJNHZ1TFlnd254?=
 =?utf-8?B?dyt6MGkraXQ5amRNUzRBWW90alE5Y2VkcExoWXJCV3UvZExUQVdyWEhBcElY?=
 =?utf-8?B?NTc0cnViNW9wa0w4RUswUjhUYVdPaE1KVi96d1BjTld2K2JhSDd3eXdwV3h5?=
 =?utf-8?B?ZTArS2dMSGJ1eXVYTEZWdldLS2VYMHFtOVFYWDB5Lyt4ak54dHd0Qzk5OGV3?=
 =?utf-8?B?eThnZUVlUHNmcGpWYlpiQWZBSFpUdDlPMzVWMTFFQ09UZ0UwQytiRUREdDVY?=
 =?utf-8?B?ZlkvaGRkZnhZMEp2Y3IraTQvRUNRSERVMEtDYVBac1E2WkU1TlN4Ni9zZlNJ?=
 =?utf-8?B?aURFRWQyYW9NeU1UanRxMmhDTDU1djZ5dU1vakF2RUhyVUx2SkxXR0Y0T01U?=
 =?utf-8?B?dml6Q3hsRGI3ZkRuZ3doMnIxVTNncGpkMFc3S2U5RklkNUk0aVM5NVoxVE5h?=
 =?utf-8?B?dy9LWm5qa0t3WmJQbU91SzRkYW5JRXVSSXhCcGlPRk4zazJ0MWtkL3Vodi9v?=
 =?utf-8?B?L1RYcVByTUlHOWpPNHR5T3dXb0wvbllzOW5hRXIvYkhibTVXZmR4S1h2STJ0?=
 =?utf-8?B?Qi9HcVBGMHpKOGM2cGxQdVpsejNSMExCenQvTVNrTlBLUWVxYlFLL3V5eVBW?=
 =?utf-8?B?bHhCQ1poRjNqVGVnbHRqemJ3NkQxN1lFZzdPUUwyOW5qRmJKZGRHNlNURlJB?=
 =?utf-8?B?cUxkL0xvUklkRmVTVFV1NlhKSTBROFhSMHlHOTZsc1ZPVkhheHQ1dHJyZWdC?=
 =?utf-8?B?SHUxbjJvSGMzTVNacFpmTEhHZk5JNi82MEtucFdaRTZIQ1MwbHFuY3hWODNJ?=
 =?utf-8?B?d2RZUit1OUpFRnBJQjRvMWs0TkVkdE9yM1g4VFovMGZibHA4aHFaMWpqeDdq?=
 =?utf-8?B?MXVRNmtiV3oyeU9hRzd3Q3EzSG9hK2tiY1dDQ3JTZzZIeW53cW5oUDRkVEpS?=
 =?utf-8?B?aG8wV3lmczJVWlFWak5xckRGOTNOUm0yZ1pZc2VNSmdiR2VyVFRDQ1Z0bklJ?=
 =?utf-8?B?bmRRVFZ0WEs5Q0haSlcvcDFBaGo0ZVBwTm1kS003ZDQ0QUV3N2hSQklobndF?=
 =?utf-8?B?eHRDYW9JSlVsdzJHN3FXU2h2MUVLa2ZKV3EyZjljUGZtdWI4ajZHaHhtZHhl?=
 =?utf-8?B?QjE5S1VrR3VVcDNWT2YwK3N5OTlMN2o0N0F4b2ZQeVlRSncwRlJLVkRCbXg5?=
 =?utf-8?B?dk0wc25zY080djlJaGMrZmUrN1prMzNIdmp5cnl5c3c0eWlUcFN6S3FpZW1n?=
 =?utf-8?B?eGdNNVdWQVh5TzdLdEpJa3g2WWF1NW1wVXV1RExkVmJpZE9Yb1N5S3ZpbXZZ?=
 =?utf-8?B?cWd2VXZ2R2hBUWR1R3JoUFREZURsZDkyQmNYN2Y5cTlUNWpiekxHenhlbFpj?=
 =?utf-8?B?U1Q0SUFvNkxxVm16angxSEY5WjVNU1FhaWZjeWJ2eGVtTEp2WFpQRkhXU3dJ?=
 =?utf-8?B?MEV3QVFqNWVFVjBVMHFsTWFEMDFkYkNWby9TR1J1MDhadVlSQVFiVWk3dEla?=
 =?utf-8?B?SDBrRXB6OWp1TVRsVnFIbkJsaWcya3loSS9hclhYeE1PekJvazBLekc5YVV2?=
 =?utf-8?B?RDIxU2JYWUFUNFBzME1XNmdlT0FDZEoxWkxVa1Zvb1plNDhhamxFd3FTRVpI?=
 =?utf-8?B?L2RKVlFJMkV4ZEhmTDJ3eEROb2xvZUJUMHc4T2RkZ1F6TXExWXJBZnYrMGNT?=
 =?utf-8?Q?6wjLG3+PWz7eZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekUwR0ZkVk8ybjREczVWUGxGRk9hVDAwK1BWaE1Ld2hhTzM1RDJraFJxMHh1?=
 =?utf-8?B?NlErOEhKam42TEFwdC84ZnlQOXU1enpFVjIwd2l6MnhTY0JmWm80NG9RWlVQ?=
 =?utf-8?B?VXJIVFZYN25ubFU2T1pBSjgzVnlyTmJXa3o1b0JnTHFleFBmUE12allzeXA0?=
 =?utf-8?B?SDhTSDRMK3Z3aTMrdFk0c3U3a3U5L0VURlJOVTdzRnRiUDROOXExZlNuVHlq?=
 =?utf-8?B?MUk0czdJL2tmU1hORVZrby92VHQrYTZxcmoyNXBqaGY0a1VWcWtkODBoOFpQ?=
 =?utf-8?B?Z2k1TWJxU2NPSWt6UFo1bzBvN3J1bEtkbEo0T1hDcFNYZnh2QmhIby91TVlj?=
 =?utf-8?B?aTZUWm1yU3hkVWo2alJBY242bVg5UWorZmkvR2w5MmdtZkZUMHlNeFFoK0dT?=
 =?utf-8?B?TGIvUE9KOW96c3JuUVYrUGQ5ZGFGVXY3TjcwSVhvM2xXQ2JMaGN4b3NkZm4w?=
 =?utf-8?B?M3BVOCtLcDh4QnUzQUtLY0pJeXJWK2ZIOG9OeGlKUjgvTDNlSUZzUHNHUTFx?=
 =?utf-8?B?bmpkYWdYYjBOTTNDUFBiNk1LRnIzakJURStsaXF1QStZRUt1Y3JWTDdpNUN5?=
 =?utf-8?B?eXJlQlQ1NXdrdjVvbG11ekprSGE0TE9YQ3dIaHN0WERHVTM5N0dzYVJTZnFW?=
 =?utf-8?B?WXB0b2w4eWwyazJSWFlPZEJJVzd2Vy91RzE5Y2t1Nk8zVlJocUN1aDZ1UVZM?=
 =?utf-8?B?SytYOE1temptT1ZPYndIZVF6dC90M3lNQjlvdjFDa1RsN2ZhTW11THhqRFVz?=
 =?utf-8?B?YmhmSGpDc25OWWNiYWExSEFqcVVrNGZBSVllYkRpWFdwdmxOQmRDNkZXSzNl?=
 =?utf-8?B?TU5XQ0t3aWVZaU9ic25vVXNGZzFzVzhKZDNOZ1lkMytLa2ViN0pLNEJRbVht?=
 =?utf-8?B?cG10VEw2UmthVXVrWldITGtvSk5PN0tNRTZkcEsxMEt3a0J3azAwT0J2NkdL?=
 =?utf-8?B?bTZ3dmQ3QmIvQTZONXY5a09yS29NbmN3RjJOVWVwQkVDZUZKdG1zd2RuMVBY?=
 =?utf-8?B?cjJ4cTR5VnVCUEdQVC9HdEtwZ0h3d253ME9heFQva2M4SDNPMmZaeEJUUjBI?=
 =?utf-8?B?c0g4WVptRDdpUjhjckhjYmVNM3BIT29BK3FlY0ZMNUs4Nm54TXpkMjBQZlZz?=
 =?utf-8?B?RU5ZTjJUbk5UME1ienZZUFR4Y0pHM0VIZDFmREFVZU5FdThVQVhtb1pEdlBm?=
 =?utf-8?B?SEUva1I2alFXS3NLdDIrVjNjM2pFRmliUDE0UFRLYmpGSWo2R0RqVDgvZHdH?=
 =?utf-8?B?Z2wxYURJN0VoanpERUFySGliUlNUcFE1czNBWlJVaVlLMmdRWksrWklhcmg1?=
 =?utf-8?B?NWJaMkkvb1FTUndOYnNyWFd3cm9TenFnRERSZ3dNUERDOXJueHgvNmdyek4x?=
 =?utf-8?B?U1hqeEhFd2FPRVVPVkMxR05Zc2dvYW1ZMXMvdjJsY3l4cGtUbytmTnl4ME5u?=
 =?utf-8?B?TFlpcWZvUFgyclBGQjl2akJmazg4RkFobXAxb2hpNnJXQVBXeVFFRWU3eHhO?=
 =?utf-8?B?ZXR5SzNCbUM1Mk1pR3dRT3FyNDJDMitQK2FPRFNKNVVzWnhWMlZzd3R2eFdC?=
 =?utf-8?B?MzlCTmkxU0E4OHRjdUZlZzJCeXRsMnJ0ZjdybE9wUk05ZVpHc1NNVENwYi91?=
 =?utf-8?B?c2VUNWZ4UTVVRzNXamdTVXhkZ3g0UUhNMzV2OWpwaEtVVVhPbDJBN01USSt3?=
 =?utf-8?B?WFBxM040SnI1Wk1Db1o1c28rdncvUkpsOVhHU0NMQm5IY1IzakdUWTZTMXMr?=
 =?utf-8?B?ZUNPMW83YmgwOGFoaXhINGJtWW5pcFdKNmFQMkNhTGRuZWdURVRZNGc0U3Rl?=
 =?utf-8?B?eHJUcWZtRXdVNXhxNTl0QlA1RkliSE0yNFlZVS9IRjd6Wk50aHRQczZZTTZU?=
 =?utf-8?B?ejRCdmdOdlAyNW5XSE9WcjVQTnNoMTVXNHlCcUxxcU5sZTBhRmlWOFJVdFpD?=
 =?utf-8?B?NVpINW5WcDg4NEVnNE1QdlRQK0J6WUxGdDFXL1RJWFppbWJyZENVUXVlaWFa?=
 =?utf-8?B?ZERYSVpqems5OVdsRG5sWFl3YWhLVUNlNmZNcjhlemM5UzU3RXdoMFRDSWRO?=
 =?utf-8?B?UGhmUlRla2JPWjFwY2ZhdmFpMjM5a1p3ZzdiZk9zZkxsSjJhK1U3QnZnVlQx?=
 =?utf-8?Q?mQiDlbIiZ4FhQHak18p1QDqkV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f6e187-b1e4-4463-ddfa-08dd1e7fb530
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:46:40.8402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UkxEETXqMzxcacm880mCqbpqWhke4uoumGFD9AI2CddKutC9m46988ey3n/xVQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Hi Arun,

Am 17.12.24 um 07:20 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
>
> On 12/13/2024 6:29 PM, Christian König wrote:
>> Am 13.12.24 um 12:24 schrieb Paneer Selvam, Arunpravin:
>>> Hi Christian,
>>>
>>>
>>> On 12/13/2024 4:13 PM, Christian König wrote:
>>>> Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
>>>>> Fix out-of-bounds issue in userq fence create when
>>>>> accessing the userq xa structure. Added a lock to
>>>>> protect the race condition.
>>>>>
>>>>> BUG: KASAN: slab-out-of-bounds in 
>>>>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>>> [  +0.000006] Call Trace:
>>>>> [  +0.000005]  <TASK>
>>>>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>>>>> [  +0.000011]  print_report+0xc4/0x5e0
>>>>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>>>>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>>> [  +0.000405]  kasan_report+0xdf/0x120
>>>>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>>>>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>>>>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>>>>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>>>>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>>>>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>>>>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>>>>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>>>>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>>>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>>>>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>>>>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>>>>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>>>>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>>>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>>>>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>>>>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>>>>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>>>>> [  +0.000007]  do_syscall_64+0x4d/0x120
>>>>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>>>>
>>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 3a88f754a395..49dc78c2f0d7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct 
>>>>> amdgpu_usermode_queue *userq,
>>>>>           unsigned long index, count = 0;
>>>>>           int i = 0;
>>>>>   +        xa_lock(&userq->fence_drv_xa);
>>>>
>>>> Don't you allocate the userq->fence_drv_xa after counting the 
>>>> number of objects?
>>>>
>>>> If yes then you need to drop the lock again for that.
>>> We are allocating  memory for userq_fence->fence_drv_array using the 
>>> kvmalloc_array(),
>>> should we drop the lock for this memory allocation and again acquire 
>>> the lock for
>>> moving the fence_drv references from userq->fence_drv_xa to 
>>> userq_fence->fence_drv_array
>>> code block. Is this correct?
>>
>> Yes, that should probably do it.
> I tried to acquire lock only for the xa_for_each() blocks and not for 
> the memory allocation, but if we
> dont aquire lock for the kvmalloc_array() memory allocation part, I 
> see the kasan out of bounds
> BUG again. Can we acquire the lock for the kvmalloc_array() part as well?

Then we would need to allocate that one with GFP_ATOMIC which we should 
really try to avoid.

For now I think you should just use GFP_ATOMIC and we add a big TODO 
that we need to fix that as soon as everything is working.

Regards,
Christian.

>
> Thanks,
> Arun
>>
>> Regards,
>> Christian.
>>
>>>>
>>>>> xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>>>>               count++;
>>>>>   @@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct 
>>>>> amdgpu_usermode_queue *userq,
>>>>>           if (userq_fence->fence_drv_array) {
>>>>>               xa_for_each(&userq->fence_drv_xa, index, 
>>>>> stored_fence_drv) {
>>>>>                   userq_fence->fence_drv_array[i] = stored_fence_drv;
>>>>> -                xa_erase(&userq->fence_drv_xa, index);
>>>>> +                __xa_erase(&userq->fence_drv_xa, index);
>>>>
>>>> It's *much* more efficient to release all entries at once by 
>>>> calling xa_destroy() after the loop I think.
>>> sure, I will try with xa_destroy().
>>>
>>> Thanks,
>>> Arun.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>                   i++;
>>>>>               }
>>>>>           }
>>>>>             userq_fence->fence_drv_array_count = i;
>>>>> +        xa_unlock(&userq->fence_drv_xa);
>>>>>       } else {
>>>>>           userq_fence->fence_drv_array = NULL;
>>>>>           userq_fence->fence_drv_array_count = 0;
>>>>
>>>
>>
>

