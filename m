Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EEC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 19:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1860710E1D4;
	Mon,  6 Jul 2026 19:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IqO50V0b";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2406F10E1D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 19:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pubhfUp1mV9TLb1+3e/Hny8zUqE2WXTCgxAXwfyAApQJwurUatIoCJFGJOWgLNNUvew7pUNxQQe0fZoILTl//tDWpXcWWVmiHTlqmQomUXDVSLpFD3eT/sz4n5GCil+2eGD4XhUSy5GtopGsCxsHpKGh8cUoj3o/s8Zzcy7uyPqWPBQXIiPN35C8jDr0qtU9Pdmw2BoyT0F5Rdznch9WnvwqZmxd31ZWaju/UIeqtgi8c31PIb39wrnp1RmGJut8krc50iIt0WUp5BtwT7FZ6iUjpAELzBiUwfcNhHo6Irwk9WMzH6uK3t5MRHmeVN7cYgXZmlKmxOGsRgXVgFB4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke3sl3h72MeS9O52kRAmglwYUtVx/wfCyuohRmWH4dQ=;
 b=UimsXHZAx00gtYqylbC0mNonONvoNJ0FXBuQZi1Via9Xm9GhoRf5I2w71b9Vq3TDNE90lYsMP8CuDYlOJcDJ2EE66WgDf4I/wGzPmlgiwOKnpRKgBEKgCYJR11dyIWorj3X5uj/ngQQ4e0l0VR8Uw7WgEpLF6v5KQj3RTacuHuPw3kOkFuCocLeWOX8M5Y/M+1VpPQN39RKzSKmPfMrrov/MgsVrjlBOCbJ+Wm65Z0lkZE7kcsQW9YEQQxpZjpffdUijfLiNnt83bKszewm5pIeoHJZmEaP3DWQQtpTIIZkZuIQZq9jEm85yHz+DRsqPUIvTulUiQvVKWfC/7jSwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke3sl3h72MeS9O52kRAmglwYUtVx/wfCyuohRmWH4dQ=;
 b=IqO50V0bxPO1czV+nGbImrJkzi6GE0a3J+C1V7ExJJEzD62uk0C1Oimo/xfR/kQdwThBjO6E+Mxb6vTDIGLR9GuOCcEPcOfXoAzAlP7sOJMt4wztn9FzXlsfOSn77PI2t3Fbdux8IK1vmzw4lIv/paRfvtRkZi0C0+OdFWy1evU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 19:04:10 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 19:04:09 +0000
Content-Type: multipart/alternative;
 boundary="------------q0cNfPU6F1UOWSoJy5e6bKpH"
Message-ID: <b71aed1c-27c9-436f-be89-05e21c9878f2@amd.com>
Date: Mon, 6 Jul 2026 15:03:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
From: Mukul Joshi <mukul.joshi@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-13-timur.kristof@gmail.com>
 <BL3PR12MB64256E6E84188CD2CCAB6C09EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
 <5742390.E0xQCEvomI@timur-max>
 <BL3PR12MB64257E98740CDB903C4B2BE1EEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Language: en-CA
In-Reply-To: <BL3PR12MB64257E98740CDB903C4B2BE1EEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::9) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdbe0df-99db-4569-10f5-08dedb915bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|8096899003|921020;
X-Microsoft-Antispam-Message-Info: 0eCfg45FvXEsjtnUIZ1tDyZbNHDs8aoHG6RsG7jmdL5w6RGNi+zamLFSlrOfDhRoxqv2n5hz1LS5/NCfN0KxhtvDUkoqS4Shkk/1MLV4IWuloqEWyMGE38V+IcDSJCBsVbT9YZSPAuvhEeiYOKGbQsxGv7l83xwWtlgDUJgZFiMbhaBNtUBTtiUIgA74eiURJXakaUbQfcISw68fzAXHK6CO5YaqS7GsHJuuIEJWYiBktGscnNYkLcF3PN48T2I8LQXaKX3DCXz76a4zycQBL+qCEJ4szE3MBqGpB1A7G1zR9IPxzz5d0wCuxA98wu7HqbNht8Dt7mWWTkVyazeyr0QqiOfDxknxU+2t+SasWPZUHbw2CSv5j6H8W2IXfaDsm8H7hlVox+BfX0GdbR+ZfNhdz8G8Pa5lDq3N/xqelWTMI7DIeLqbv+J+/kSQDguu7EYZTfJGfkPmm0frUDK3sTF/aIYfLWtF/+Fdp8ReqiT0ZOahkkhZ30CgZNBAwGROO4zp0GuMZi7sk0Z2GmXIw/t+EX++ZHLSEFDLPxhK6FaJpsQoEOpzrsJ0oH0i0eo8n3pG4tBc/iX5bn/swY7z60lADLgT+77oWazFfnuq5WON+qazWK1xk0u8qUAOJDRHszzvzTsjFPvary8Ftspk10k0c4xkCd3DA0Sv/unlQka+YfHiAz4YAqqStK/hdfb3Da+jiBMsBnJA8wzNdeDddg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(8096899003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZOenFEMVJuS1g1elcrUEI1Y2ZGS1ZnUDF5c0RpNlhKWkZqT295emNRYUo1?=
 =?utf-8?B?ekRCbUluaVpDSGVrdnBlaEg5TnpOTlltTWJMK21BZU0yd1hhcHlZYUFEamFv?=
 =?utf-8?B?bFpMVXVJU2ZrR1dVbUZzWG9odC9NNUNQblR2OTljWHcwc2lRUUY0dGRMUmZj?=
 =?utf-8?B?WGp5ellxOHV1ZXlOc2tGZGhtOFhOZjBMeVpLSjRNcXViai85NzZiMWtEbDZV?=
 =?utf-8?B?OWQ2TGZucS9VQzJITVRtaEpUL3puT21JNjI1YnErQjRBL0ZyMWcvMEVNYjlm?=
 =?utf-8?B?RUJ4c0VDZGZOTWtQYTRLSHZsZTVNeDNFcWpKZyt1ZnhCZ1MrRG9UR0p2bkVG?=
 =?utf-8?B?a2krRW5mS1BsdFB4VnE0eURFWTZNM1d3c3VyMmRWRGIxVW5INVZwNzdQNVE0?=
 =?utf-8?B?QWZTbE9jUktmMUVXNm5Uc3hSWXp3RkhJTlltV1JnMFp3SHlBTWh5N0hEU01F?=
 =?utf-8?B?Z0JrbWJHQlNoaXE4UGxUQjRmdVZGUUJyVmdJTVh4TEE3NmtrcGVodmYyRzZI?=
 =?utf-8?B?OGEzKzdIajhNWk9NcVZqcFFjdlk2M1RLWUdCQ1lIY3hUbTM0dk9kZ1hSTERh?=
 =?utf-8?B?L3pwRm5VNXJvelpRWnBiU1JvL0Y5UllWRW5WYTdndlQ5NTE1WlhYQzFab0Fp?=
 =?utf-8?B?QkZLWU9ORldKTzdHZVB5Nno0cC8zb2ZsTmFFMW03VFVWRFFDbWlpZ1ZKNkQ3?=
 =?utf-8?B?UVJZSW5iTkJGcWJRZG5sY01XRFJpa3RIYlloUFk3QlJycmc1OUJ5SEVqbE9K?=
 =?utf-8?B?REo4aHJPekI3M2M2YmhTQno1SDFHU2RGckJaU1BUSEhQSElEL25nK3JZeW1r?=
 =?utf-8?B?WkFaQTRBbEt0Uk1PUU1HMDM2d20ya2VOc0J2OEI3bW1RL3FKbHdvTWF0VUN1?=
 =?utf-8?B?aFBBa25RSld3N0dEODdwck1BNFFzMmloVndENnQxMUhROVdyWG9FQVM2c1Qz?=
 =?utf-8?B?dVZRYkRibVhMVmlkdXUvdTVadmFwbXBEL0ZvZy9BZThkRzc1MHUrR0V1L2dx?=
 =?utf-8?B?aUM1VnhTR0FLdjE5V3I5MDQ2WVlQVEd0Zk1vSnkyNHE4Q055UHRNZ2o5aVNx?=
 =?utf-8?B?TDJDQlByYkZsd0dQM2pLNk5TQTJtOXZMaXZmU2ZHckNNK2pxNDh3dTlTd3FC?=
 =?utf-8?B?ZUVyOGorV1ZEeEhYYSs0M1hDemtXOFdnZUxhd2RncmNxSS9PWDJwZGFVYWcw?=
 =?utf-8?B?d1FxcE4xNE1nOWZvSHE0Vkt1MTZtWjJUaERsUGh3YXQ0Wm5ZMDBYTFlIOHJv?=
 =?utf-8?B?ZDloWm5DNjRRL3dLLzlGYkh3ellaTDBLa2NxTHhCQTRCWVlwRGtjUWUvRndC?=
 =?utf-8?B?R0t5N0d5WVRpNnRPeU5seUdPYUN4UEhiWGVGdWp1WVFLSFdzZ1E3UUVOV1BE?=
 =?utf-8?B?SDc1UVVIMkR0cy9GdWx2WHlQUStwcFlMTnhkUVpxemtEV05XRVRzbUI3bVUx?=
 =?utf-8?B?ZTlmV09MUDBKcERlVUVnMFhDa3lNTFUzNjFSWitsTzJBSzEvM1NnYVNYTHFn?=
 =?utf-8?B?SXowN3JLUXZnQndOaDRRY0tWOStlNE9KcEx1cGZZOWo4RkhzVThrWldkZ2Ro?=
 =?utf-8?B?S05QeldNemFRZ2x5MXNQQkpJSmdNY1YrVG96bDFuT2hzcTZPODViZkh2QVVs?=
 =?utf-8?B?SWpkQmtvTUJaQ2U4bFJjWlc4S1QzdWY3c3oxdlE3R1hOcndJdWJpNXNoN09L?=
 =?utf-8?B?Qm9Ydk9jaVJnMFk5Y2hzdEoxVjYweEpkRFhqeVhtaWt0aGFtSit6Q3llTVhs?=
 =?utf-8?B?QllGWjhTTjMwcTZMWEJFK1R0Q2dEUkpsYjBWNEo4Nk02VWtJeklFSUNCZG5z?=
 =?utf-8?B?Z3BFOUdvT2lUL3NCRUtqUzBkakRLVGRIZXBPMGtyQzRSQ1hrUG1qM0x2cm1m?=
 =?utf-8?B?NytlTS9EV0VDbis1Vms4cVZrRDNxRmoyTkw3ZUE2Sjd3YXI1WFJlV0hWQVdl?=
 =?utf-8?B?YnN1M3luQm45eXc0c0xnYUxDSU9OZnltMm9zY1loek5JckpaeWROWVVjY1pt?=
 =?utf-8?B?TC9uU3hJMnZ0cjFTNVB6czNUb3k2N1ZuSnRTZU9kaHowbVZDZHZOd2VUbFdy?=
 =?utf-8?B?SnNhZkZoejByaUwvd1hnZXMvQXIxcURneWQ4b3BaczQycnp2d05ubjVidnlj?=
 =?utf-8?B?TFRvUW8zWDRUZ3NYc3NXTTVJamFoRHg2dysxK0hkSGhMOVF4MGlITmZ6cndX?=
 =?utf-8?B?aC8yQWR1WGdCVGVyRU9uZStURjUwakZsSjdVN0Urc0RkRnZlZkFzbWlBV1pn?=
 =?utf-8?B?QVFjdnkwU0Uwd0NFQVZObjBBS3pzTGdSUHlTZ3V2RHNVcXFLVHVGYVFDdmRr?=
 =?utf-8?Q?+fz+uD1H6ObosrY92V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdbe0df-99db-4569-10f5-08dedb915bec
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:04:09.8239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUhbWqeBWOcsP0CXtuaXMI8Pq16Fb0zvpZRF2wpH1hv2rEUQFm51Xed4WnDL3XSym5wCz1huVXSO3PfokEVR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

--------------q0cNfPU6F1UOWSoJy5e6bKpH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Timur,
For Navi4x, can you please give this change to enable the doorbell path 
a try in
addition to your changes and use doorbells then to clear the CAM entries:


diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c 
b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index b6f832c53860..8aefe64fcd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -251,7 +251,7 @@ static void nbif_v6_3_1_ih_doorbell_range(struct 
amdgpu_device *adev,
                 ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
S2A_DOORBELL_PORT1_RANGE_SIZE,
-                                                 2);
+                                                 8);


Please let us know how it goes.


Thanks and regards,
Mukul

On 7/6/2026 1:48 PM, Joshi, Mukul wrote:
> AMD General
>
>> -----Original Message-----
>> From: Timur Kristóf<timur.kristof@gmail.com>
>> Sent: Friday, July 3, 2026 2:41 PM
>> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>; Shetaia,
>> Amir<Amir.Shetaia@amd.com>; Marek Olšák<maraeo@gmail.com>;
>> Limonciello, Mario<Mario.Limonciello@amd.com>; Tvrtko Ursulin
>> <tursulin@ursulin.net>; Kuehling, Felix<Felix.Kuehling@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of
>> doorbell for retry CAM on IH 7.0
>>
>> On 2026. július 3., péntek 18:31:12 közép-európai nyári idő Joshi, Mukul
>> wrote:
>>> AMD General
>>>
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Timur Kristóf
>>>> Sent: Wednesday, July 1, 2026 12:17 PM
>>>> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>;
>>>> Shetaia, Amir<Amir.Shetaia@amd.com>; Marek Olšák
>>>> <maraeo@gmail.com>; Limonciello, Mario<Mario.Limonciello@amd.com>;
>>>> Tvrtko Ursulin<tursulin@ursulin.net>; Kuehling, Felix
>>>> <Felix.Kuehling@amd.com>; Lazar, Lijo
>>   <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
>>>> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
>>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>>> Subject: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of
>>>> doorbell for retry CAM on IH 7.0
>>>>
>>>>
>>>>
>>>> The doorbell is not working on Navi 48.
>>>> Use the IH_RETRY_CAM_ACK register just like on Navi 3x.
>>>>
>>>>
>>>>
>>>> Signed-off-by: Timur Kristóf<timur.kristof@gmail.com>
>>>> ---
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 17 +----------------
>>>>   1 file changed, 1 insertion(+), 16 deletions(-)
>>>>
>>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>>> index f1de6450a31d..291326d2ee8b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>>> @@ -279,19 +279,9 @@ static int ih_v7_0_enable_ring(struct
>>>> amdgpu_device *adev,
>>>>
>>>>        return 0;
>>>>
>>>>   }
>>>>
>>>>
>>>>
>>>> -static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index) -{
>>>> -     u32 val = 0;
>>>> -
>>>> -     val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET,
>>>> doorbell_index);
>>>> -     val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
>>>> -
>>>> -     return val;
>>>> -}
>>>> -
>>>>
>>>>   static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32
>>>>
>>>> cam_index)  {
>>>> -     WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
>>>> +     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
>>>>
>>>>   }
>>>>
>>>>
>>>>
>>>>   #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
>>>>
>>>> @@ -401,11 +391,6 @@ static int ih_v7_0_irq_init(struct
>>>> amdgpu_device
>>>> *adev)
>>>>
>>>>        pci_set_master(adev->pdev);
>>>>
>>>>
>>>>
>>>>        if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7,
>>>> 1, 0))
>>>>
>>>> {
>>>
>>> We are re-purposing the IH 7.0 file for IH v7.1 since most of it is same.
>>> The code being removed below is for IH 7.1 and not 7.0.
>>> Using doorbells for acking INT CAM works completely fine for GFX 12.1
>>> and IH 7.1.
>>> I would recommend to drop this patch.
>>>
>> Hello Mukul,
>>
>> Unfortunately I couldn't figure out how to get the doorbell working on Navi 48
>> and in the previous thread Amir said that it also didn't work for him, and that's
>> why I decided to try the MMIO register.
>>
>> If you have an idea how to get the doorbell to work on Navi 48, I'm happy to
>> try your suggestion.
>>
>> Ideally I'd prefer a solution here that works on both Navi 48 and GFX12.1 to
>> keep the code maintainable. If it's not possible then we can also have a slightly
>> different code path for the two different IH versions here.
>>
> Hi Timur,
>
> As I had mentioned on the other patch, we need to enable the NBIO path to route
> the doorbell correctly. That’s the reason wy your doorbells are not working on
> Navi3x and Navi4x.
>
> I am working on the change for Navi4x first and will send it out to you soon one I have verified it on
> my end.
>
> Regards,
> Mukul
>
>
>> Thanks & best regards,
>> Timur
>>
>>>
>>>> -             /* Allocate the doorbell for IH Retry CAM */
>>>> -             adev->irq.retry_cam_doorbell_index = (adev-
>>>>
>>>>> doorbell_index.ih + 2) << 1;
>>>> -             WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
>>>> -                             ih_v7_0_setup_retry_doorbell(adev-
>>>>
>>>>> irq.retry_cam_doorbell_index));
>>>> -
>>>>
>>>>                /* Enable IH Retry CAM */
>>>>                tmp = RREG32_SOC15(OSSSYS, 0,
>>>>
>>>> regIH_RETRY_INT_CAM_CNTL);
>>>>
>>>>                tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL,
>>>>
>>>> ENABLE, 1);
>>>> --
>>>> 2.54.0
>>>
>>
>>
--------------q0cNfPU6F1UOWSoJy5e6bKpH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="monospace">Hi Timur,</font><br>
    <font face="monospace">For Navi4x, can you please give this change
      to enable the doorbell path a try in&nbsp;</font><br>
    <font face="monospace">addition to your changes and use doorbells
      then to&nbsp;</font><font face="monospace">clear the CAM entries:</font>
    <p><font face="monospace"><br>
      </font></p>
    <font face="monospace">diff --git
      a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
      b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c<br>
      index b6f832c53860..8aefe64fcd41 100644<br>
      --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c<br>
      +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c<br>
      @@ -251,7 +251,7 @@ static void
      nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ih_doorbell_range =
      REG_SET_FIELD(ih_doorbell_range,<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      S2A_DOORBELL_PORT1_RANGE_SIZE,<br>
      -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2);<br>
      +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;8);</font><br>
    <font face="monospace"><br>
    </font><br>
    <font face="monospace">Please let us know how it goes.</font><br>
    <font face="monospace"><br>
    </font><br>
    <font face="monospace">Thanks and regards,</font><br>
    <font face="monospace">Mukul</font><br>
    <br>
    <div class="moz-cite-prefix">On 7/6/2026 1:48 PM, Joshi, Mukul
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL3PR12MB64257E98740CDB903C4B2BE1EEF12@BL3PR12MB6425.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Sent: Friday, July 3, 2026 2:41 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>; Shetaia,
Amir <a class="moz-txt-link-rfc2396E" href="mailto:Amir.Shetaia@amd.com">&lt;Amir.Shetaia@amd.com&gt;</a>; Marek Olšák <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>;
Limonciello, Mario <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>; Tvrtko Ursulin
<a class="moz-txt-link-rfc2396E" href="mailto:tursulin@ursulin.net">&lt;tursulin@ursulin.net&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Lazar, Lijo
<a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; He, Siwei <a class="moz-txt-link-rfc2396E" href="mailto:Siwei.He@amd.com">&lt;Siwei.He@amd.com&gt;</a>; Yang, Philip
<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Subject: Re: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of
doorbell for retry CAM on IH 7.0

On 2026. július 3., péntek 18:31:12 közép-európai nyári idő Joshi, Mukul
wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">AMD General


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of
Timur Kristóf
Sent: Wednesday, July 1, 2026 12:17 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>;
Shetaia, Amir <a class="moz-txt-link-rfc2396E" href="mailto:Amir.Shetaia@amd.com">&lt;Amir.Shetaia@amd.com&gt;</a>; Marek Olšák
<a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>; Limonciello, Mario <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>;
Tvrtko Ursulin <a class="moz-txt-link-rfc2396E" href="mailto:tursulin@ursulin.net">&lt;tursulin@ursulin.net&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Lazar, Lijo
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre"> <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; He, Siwei <a class="moz-txt-link-rfc2396E" href="mailto:Siwei.He@amd.com">&lt;Siwei.He@amd.com&gt;</a>; Yang, Philip
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre"><a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Cc: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Subject: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of
doorbell for retry CAM on IH 7.0



The doorbell is not working on Navi 48.
Use the IH_RETRY_CAM_ACK register just like on Navi 3x.



Signed-off-by: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
---

 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index f1de6450a31d..291326d2ee8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -279,19 +279,9 @@ static int ih_v7_0_enable_ring(struct
amdgpu_device *adev,

      return 0;

 }



-static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index) -{
-     u32 val = 0;
-
-     val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET,
doorbell_index);
-     val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
-
-     return val;
-}
-

 static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32

cam_index)  {
-     WDOORBELL32(adev-&gt;irq.retry_cam_doorbell_index, cam_index);
+     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);

 }



 #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122

@@ -401,11 +391,6 @@ static int ih_v7_0_irq_init(struct
amdgpu_device
*adev)

      pci_set_master(adev-&gt;pdev);



      if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7,
1, 0))

{
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">

We are re-purposing the IH 7.0 file for IH v7.1 since most of it is same.
The code being removed below is for IH 7.1 and not 7.0.
Using doorbells for acking INT CAM works completely fine for GFX 12.1
and IH 7.1.
I would recommend to drop this patch.

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Hello Mukul,

Unfortunately I couldn't figure out how to get the doorbell working on Navi 48
and in the previous thread Amir said that it also didn't work for him, and that's
why I decided to try the MMIO register.

If you have an idea how to get the doorbell to work on Navi 48, I'm happy to
try your suggestion.

Ideally I'd prefer a solution here that works on both Navi 48 and GFX12.1 to
keep the code maintainable. If it's not possible then we can also have a slightly
different code path for the two different IH versions here.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi Timur,

As I had mentioned on the other patch, we need to enable the NBIO path to route
the doorbell correctly. That’s the reason wy your doorbells are not working on
Navi3x and Navi4x.

I am working on the change for Navi4x first and will send it out to you soon one I have verified it on
my end.

Regards,
Mukul


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Thanks &amp; best regards,
Timur

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">-             /* Allocate the doorbell for IH Retry CAM */
-             adev-&gt;irq.retry_cam_doorbell_index = (adev-

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">doorbell_index.ih + 2) &lt;&lt; 1;
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
-             WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
-                             ih_v7_0_setup_retry_doorbell(adev-

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">irq.retry_cam_doorbell_index));
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
-

              /* Enable IH Retry CAM */
              tmp = RREG32_SOC15(OSSSYS, 0,

regIH_RETRY_INT_CAM_CNTL);

              tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL,

ENABLE, 1);
--
2.54.0
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">


</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------q0cNfPU6F1UOWSoJy5e6bKpH--
