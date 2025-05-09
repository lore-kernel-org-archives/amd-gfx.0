Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A24C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 10:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9899210EA13;
	Fri,  9 May 2025 10:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJZlbyZ2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A804D10EA13
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 10:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR5j3zQ1EHK10PsCkWHvcep2neGSJaPrsUPxOhvnXGYeRaTWOOdxjspRxLJsPR/JLNGErrUfc2L7F6okXcWGfZInmwiNj+aR0r5USuOF10HmP0PgjA+is2xJmRQmFG/+/pym9NLYIQt4hZcG0ffPB+wrHfmwp8XvZtHHoiXXjFlac9nl11V9s8dU9u/hvxVNqRnYwBCSKIEwdpAia4/cBBPjFPvHoEVePPb/QEPQqRudv4KUc+8AP+JwMq0XKSlWyqKLK0/AhfJaahcdEUmHlybegcMRL9rdxweHm5HmmKMS+A9i34jBOKIHslzEf+QzRGtO3wUaPAX5OPTcBD9Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCf2i/8eFmTDNvZ/TKSZMfFdESkquvb9BVdnQY798Qg=;
 b=F69Zf49I504kFFoUnlK4t3fs3QtW0U+qDThNn5SDpN3v9bbOXOH3kz6eTE/tZIJO38m/M6rRBrHOZGXh/C+IacjVZkVKDyylHsS7lHnXKbCKef0DWggrjsIsloJEPANBNOHZveNF0R1ZWj3RvfAzN0GU4bT0C0ergopoPGkWDvE6MU7HLDGC4b5Ovzrq4pPJ5qnAsgPPKDZPcZWbHAcZ+QuQFC3D4StV5BZ2V7IO04ykLEdetc9MQKorj0RI5/xtfWPJhJg6ARzVUQidZSDpdU69+Tt+OgXbbrafdTze26P5xS7YAiD0tG/Ki9S+P7NvGHnyB2fXXnMqeQ4tZuqBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCf2i/8eFmTDNvZ/TKSZMfFdESkquvb9BVdnQY798Qg=;
 b=ZJZlbyZ2jWv4o5M1qCr/hkqcbpVQrsSdug9ippCHUKW5Hbu/SNgCLurGlsUnumi0eBgoOMjFwdT/SfNuQKjeCLIfVt1OFZVV1rItAQI4EnBwBKWVqeJHTV4AAptWPS5IvHZ/ltu12P/25mAoH9et7ClBKThdwwzRDUUgPTf0Cd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 10:38:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 9 May 2025
 10:38:09 +0000
Message-ID: <a1e2ca07-39ff-43ac-bb76-41cbebad2a56@amd.com>
Date: Fri, 9 May 2025 12:38:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250508134428.383605-1-Prike.Liang@amd.com>
 <d7a75e46-96ee-481b-90c3-eaa514569245@amd.com>
 <DS7PR12MB60050C58880E4AE3421632C2FB8AA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60050C58880E4AE3421632C2FB8AA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c69a401-d257-47c9-7fb4-08dd8ee59741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3RCazF2VlVWK0c4bWhPd2dxdmo2ODJhbHg4YUhKako0aStxZU1xTHNwZXc0?=
 =?utf-8?B?OGJyeStsTlFjbGM2S3ZYTXJ5V3hhZzlOaEFpNzQ2Qk9HUkNPSUUyUjNZZEhE?=
 =?utf-8?B?WEo2NG5TTjd4TnVuZ2ROclVycHZyeDlteEJFWG1Lemo2R3hiRlRJZEUyNlVt?=
 =?utf-8?B?aS9pdkhsNlpXZnA4VENsc05RK0UyaHRubG5oT25Ob3lDLzF6eEh6RkZxVVF6?=
 =?utf-8?B?cFh0SUg2Q3ppM0FLZTVaYmw5WmkwbGRDeEJmTDhZV2ZDbndNeXZDbStibUF2?=
 =?utf-8?B?YlQxOTE4ekFFWTdRK1Mwdm1RdVA5aFJyaStidVJvRjkwSUxZUFltbjY4SWFX?=
 =?utf-8?B?VFpmTVBVempHcWp1eUttaXR5am5LZFh1UGw4SnF3dU80OXMyNlVTRkU3aFRR?=
 =?utf-8?B?d0ZQai9wZDZYU3I5VHhZRGtVYU9NazVHWXBsWjlGV1FPYU5kZUEzQ3hRaWdF?=
 =?utf-8?B?SEllbEhGK1dmblFTU0M3RFFaK1hjWDRpdmJvMVhPdHliTHlhaXlZRXRMS3ho?=
 =?utf-8?B?SzdOMGtndFlOaXhrS0NoY0lkVWJtV3lSZGM5aVVHL080UmFqSHdDcm5yTXEz?=
 =?utf-8?B?QkZ5dHM4czZuMzhJb0R6SG5mdU1Kam9sNzF1YlYxVWd6TDU3aGNlc0ZjWFRw?=
 =?utf-8?B?MFd6VE9nMzFQTzNRejIvUmdaTVhObEM4Zk9ubm91QzRqdUN6eUZ1dGVkdjk3?=
 =?utf-8?B?QU9JaUFOT0JDK0pGUGZtZmhFa3llT1dXU1NZWlVnL3krVWpHdGV4MmJQZ0p0?=
 =?utf-8?B?M3cxZTdCUzhLNHJTcUJLVUhpK3BBWm90bFJYQXNKYUp1dGVkUXNJVzc1RWFY?=
 =?utf-8?B?dWxOOVBvYzBGb0lYMWdwZTZaZW0zL1RKaG5FYnZDRVVYZTZqUi8ycDhjeThD?=
 =?utf-8?B?ZWdMVmNhdG84NlRMSEJrcU1JS2thMnBSLzNWZk1pd0o2a1F5WUZHelo1TFF4?=
 =?utf-8?B?amwxZStndXIxTlQrOGc3YStQZHc1WG50ejdlejZGS0Y0cTBkY3NjbTNhVGto?=
 =?utf-8?B?VTh2cVZRcUg3ejJielJBdXA1TnFOYjNQSUQ1Zi9nUUFIbG9aUVdENDh3VmJp?=
 =?utf-8?B?bHJrWXB1NHVKcGQzYitUZjY5cDhTRm5KcU9oazBET3lITGI0M3RFNWxyalhZ?=
 =?utf-8?B?VTlpWFFnbnNWRUlxQ1FGc1AzanQ3aW1jTi9SaHNyU0dCdmd4cjlYWTY3Ly9r?=
 =?utf-8?B?bVZ4K0g0L2VJNGhiZEJSZ0RKRDhIOTVINDdjS2hRSWFNTVFwaVRyTVVCblJ4?=
 =?utf-8?B?NnhwVVhCR2F1TExzdlF4UkNiaE9BS3B0OEtEdCsxN3VOc0QxWnV6T0ZZYWNJ?=
 =?utf-8?B?dTlMWnJocEtCOTlmdWRhRlZTNzNYRFZSWWZlVTFNNi83WGpOc2t6WFJvbnBw?=
 =?utf-8?B?M1orNUMrQ0Z4Rk1ORWlUZ2hyd2Z1QTQ0bWdHdFNnaGVvZ2IzT2dndk1KQnYx?=
 =?utf-8?B?NjEzdmlJM0NPaWFFazc4azVFd1FsVjFNVXl3dTVmVGExODU0UTlpOE5jK1Aw?=
 =?utf-8?B?dWNDakRnVFg3UjFzN3lKbmdYNnNod2FoQldlaWF5SkliRUpsQWJ1QzErM1BH?=
 =?utf-8?B?eEdXNFBHNUphVnZhYkZ6bE5MVktsTDBWcFEzcjROME9yWFJxSG5sT2VQSmtj?=
 =?utf-8?B?UWdnRkVlYjVxZURIRzFoc2JzVDQvNlBjTnFkYTk1REc0WDIwZjIvTmZFbDFo?=
 =?utf-8?B?NVlIZlVQUlg4Q1VIODRxK3B3UUlyM3B6cmExNXBib1VPeC9wVzBvL05rM0Zv?=
 =?utf-8?B?eVFqeWNJWXcyYmpCV3YvSEVTYkdNWXJkS1cyRzA3MS9LNjVKK1lOQzg5WjBs?=
 =?utf-8?B?Y25xajhSZXlib25PNUVTbThJeS9saTN4RkNmS3RmQjRtSGwzQ0JsbVphSTBx?=
 =?utf-8?B?QUtSWVVZdEJFMUtucitOZzJMZW5kTmI3VzZmSlVtTXJQMnJUaXBmbVRjajUr?=
 =?utf-8?Q?+G+Nqt9mqkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlVya052ZUo5NjE1czBNSWZWMGgweE15ak1SYzhlcTN1Yjd6SDNQSEowSHU1?=
 =?utf-8?B?T0kwNUg0ZldyVDhPUEFXQWRQSncxdWJYVGJ0OWI4T3dWWC85SURtWkkybXJZ?=
 =?utf-8?B?V0NBR01Ub2MvWWx1c21qQzdzVG90cHZGSkRpSDdKQlNOMWt2NmFhandMU1Ey?=
 =?utf-8?B?SlZqYWh3aENNM3BWRVJlNFZRWGk1YTA0MXhJMzQrUi9tOWQ4eVExb0dmRVZX?=
 =?utf-8?B?UVJGdW5BeFZhUmNScW9Tajc4TVREWTVLbDgyeUZRSnk2VWZrQ2NlU0JwbnVS?=
 =?utf-8?B?MVJZYVU2ZW1nSVNiam5IVlFMc1dFMFlOV3RiRmQ4VUNPK1ViN0VBSGI2d1pl?=
 =?utf-8?B?dHhENHlmOVQ0RnIxSnUrRGd3K2F5T1M3TnkyZ3BsYmZOMkQwQXd6aWl6ZXBv?=
 =?utf-8?B?LzRhTFdldXg1eC9ncHI0aU15WEpQbzJVWjZKQnd2TFFhRjRtNDA0c0xPVGdh?=
 =?utf-8?B?QzluZE8wV2ZZd0tJSHVGbmxPQTMrMGRDbDNreUpQZzR4OUFoMU12OThLNkJj?=
 =?utf-8?B?VWYyWUpzRGpsanZQcEo0d3hGR3cwZkV4RkZCcTNWcmRHV1ZWVzRRRXdkTXdt?=
 =?utf-8?B?TExsOHJGa3BXc2FoSytHVE9CeHZ4T2lYYldGU3h5cDdFd0xEbnpsVEFKRkky?=
 =?utf-8?B?bDlIcVdUZks4OFdReHBuT1VBMTdmYlUybm9TYkZuSXhzZ1hDdzh5bFVqQ1lS?=
 =?utf-8?B?RzBzZkVaZ2M5RTJmRFFzZXM1dGduR3A3RWNpRzFDREtadTZzMjQ2MlBZL0E0?=
 =?utf-8?B?cGMyMkdaNkZsNHRvbFRQd0Q4U2xFN3M4a0t5Zkl0WStJc3lEZmlwaXJsYmFy?=
 =?utf-8?B?WHBRUkNTYmtyTzk3TDF5d2pjYjExOXBxTjV4bG5lRDVYdEFPVzAwYU9mZWlz?=
 =?utf-8?B?UW4xdVB1Sy9rVjdncFBsUVZxSys2WHBueGc5L3NDNzBuSEJ4dWdFek1qTjZ4?=
 =?utf-8?B?L01HWTgwRzZNVzY0M3RleXhKQ3BFNjBnZitCRkpjK0NHaHVQY0tmSWs5NENG?=
 =?utf-8?B?Nm1OS3cyRXBOUzRoQmd1SmtGOG9ybEJIQXFGMEV6SDROaWpQS29IMnp5TDZp?=
 =?utf-8?B?RmNIdktkcXBIdlNnY1RRRTJXT3UzbUdIMGtWRmladEduSDBOVnVtaFBzYi9P?=
 =?utf-8?B?a1Izc1RjZTlSckN3MGV1TlFnK3o2Y2lUWGJTcGJqM1dzVU9yZFU3bE5WRG1n?=
 =?utf-8?B?d1JWQ2ROODRSRGFWanNGVlkvWXV6dENZa3BBU3FMc25TejhiNlQvNjlUNk9E?=
 =?utf-8?B?L3dkblRCRXhDSkF5MWhHeHR5SGZDdFhKOXdyZDJlK3N6QmhUQ25VZU1EbndC?=
 =?utf-8?B?dVg1NWEwNGxWZkdyVUFxQzNhZkVlTkNZWXBvVkpHdGRJTG9BdVhHaW5pakV2?=
 =?utf-8?B?clh4ZWxneUdoV1lXam9HQkxOWkhJa1lXSVRVTzc3UkFiU2xKSmtDMk5tdlY1?=
 =?utf-8?B?MjZKdzNZOUdMdnNjamNTZld5ZDRvY0huLzBRb1gvQW83Q0lwa05Db1FnMzFB?=
 =?utf-8?B?YlZURjdXYUlJWmJyQU9NZkc1ZzlOSldQUXN6cHcyWis0c1Q5TU02by9SWmo4?=
 =?utf-8?B?V0hKS0JwK2M1KzJtVUlRS3R1MjBKdElReEhpamxSMnlCaThrZlRPZHdTQXFB?=
 =?utf-8?B?YXkzajFzbG5YS3hJcmpKU0p6emVrYmNoUUNDQm1JS2RLcDQwM3dXeUNIRmE3?=
 =?utf-8?B?MEkrb2J4eE0wT01ua3VPYTdjbXpEY2dmbS9oa05VbWZDNDFUSUhhcDNwUzZD?=
 =?utf-8?B?N2pxeTY0cXFzYVFWQnBWQkJFaU5ZTUp5Yy9manBUM2VWMkJ5TEFIR0dJNG9V?=
 =?utf-8?B?ZzlGYnQ1ZEU5R3lSNlprSmw0SWptTnNNdHkxdlBaSlVpbHZwTkxCUEt6TXVk?=
 =?utf-8?B?Yi9oM3pQMjhyaS9ZS25FSEdHeGo3WFRtRkJFRmdxOHhTNDdmR3FhUUhZcXls?=
 =?utf-8?B?REp5R3lNc1ltb3JML0xvdVVRL09ja2F3K0hIeXlvTDdMNy9BL2t4VkkzZlBH?=
 =?utf-8?B?MnFxdHY3OXJXK3pySmR0NUFQT09zRkVkV05Pd0lwbEFRTUF2bk5DeXIyUlBF?=
 =?utf-8?B?cTdrUVZOaDVEMXJXYmw4RERUbG5HUXc1bzg3RFBtdzFKTGpEVTkwd3kya3hS?=
 =?utf-8?Q?YHZF/DS3XzMdys42E/hHYyBz1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c69a401-d257-47c9-7fb4-08dd8ee59741
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:38:09.5601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYWIk988iL+ZhHbusLzzFljeLfw1HAlajhFx6YXBhq1aI1iSYZpB1sI+EzRLNZt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

On 5/9/25 08:31, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, May 8, 2025 9:56 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
>>
>>
>>
>> On 5/8/25 15:44, Prike Liang wrote:
>>> Lock and refer to the eviction fence before trying to signal it.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index 1a7469543db5..dd272c1fcbb4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -108,13 +108,16 @@ amdgpu_eviction_fence_suspend_worker(struct
>> work_struct *work)
>>>     struct amdgpu_eviction_fence *ev_fence;
>>>
>>>     mutex_lock(&uq_mgr->userq_mutex);
>>> -   ev_fence = evf_mgr->ev_fence;
>>> +   spin_lock(&evf_mgr->ev_fence_lock);
>>> +   ev_fence = (struct amdgpu_eviction_fence *)dma_fence_get(&evf_mgr-
>>> ev_fence->base);
>>
>> That case is not a good approach, instead put the dma_fence_get on a separate
>> line.
> Thank for the suggestion, as such change can benefit on the readability?
> Do you mean something like the following change?
> 
>     struct amdgpu_eviction_fence *ev_fence;
> +       struct amdgpu_eviction_fence *ev_fence = NULL;
> +       struct dma_fence *base_fence;
> 
>         mutex_lock(&uq_mgr->userq_mutex);
> -       ev_fence = evf_mgr->ev_fence;
> +       spin_lock(&evf_mgr->ev_fence_lock);
> +       base_fence = dma_fence_get(&evf_mgr->ev_fence->base);
> +       if (base_fence)
> +               ev_fence = (struct amdgpu_eviction_fence *)base_fence;

No what I mean was this just the other way around:

ev_fence = evf_mgr->ev_fence;
if (ev_fence)
	dma_fence_get(&ev_fence->base);

E.g. try to avoid the return value of dma_fence_get(). That is only meant to be used in macros or when we pass the value to functions who take ownership of the reference.

Regards,
Christian.


> +       spin_unlock(&evf_mgr->ev_fence_lock);
>         if (!ev_fence)
>                 goto unlock;
> 
>         amdgpu_userq_evict(uq_mgr, ev_fence);
> 
>  unlock:
> +       dma_fence_put(base_fence);
> 
>> Apart from that it looks good to me.
>>
>> Christian.
>>
>>> +   spin_unlock(&evf_mgr->ev_fence_lock);
>>>     if (!ev_fence)
>>>             goto unlock;
>>>
>>>     amdgpu_userq_evict(uq_mgr, ev_fence);
>>>
>>>  unlock:
>>> +   dma_fence_put(&evf_mgr->ev_fence->base);
>>>     mutex_unlock(&uq_mgr->userq_mutex);
>>>  }
>>>
> 

