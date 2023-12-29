Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12153C46CD4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 09:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9E710E098;
	Fri, 29 Dec 2023 09:52:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B9110E098
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWA4IN+6bBu+SsrM7WcqC3a/+ECuECmVFL0PSkhjlrQiMRefWOb36E23ncGsWniaazV7GkdpoXaNCDeG4CYZCxvkWA3+WUreX3Xta05YIArwTyuE4mHpHiyW8m7dnDVNfsgwz2ux9TiLnIxfzEx+rjiwzgN1+xy4W2EtjceMmTgbP9cw7m5czcTC1bcqlOGKJ+G0qt6VsX5C40T2OdF2A++dA/tbKT/E3JWmXVD5/UFALbti6MTYJsKCnyL6ijV3CgS5H+llYNIJjJv5kriA9nIwnxPVGAKn/HfrSAzVnbELyJowQyrQ3qyya9rtHIlLL75upBftCKDQtAbq1Ir6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvE3TZ9ofEyOAcm+jJ6+3k2wG1W3iJLtJUppfe8a0Fc=;
 b=MHOoqQbTnAP01MPRdRLBKCTN4z76mqZu3NMxaoGuJy7v1ypDZZQYfoiLJAPLwX7Btw+xq61UtB6xO+b1ktB1yQ/tibOgYqQ74GGnIIejk/jIkgxS01NLaYGU80/8i0P6pIBQuJlstuMjtcf7/7UXOGir6JEOLrpgD0zn8RipB8+vcrt2umKNU64bV7XfUoLeE47MruzxBT5xeZ8NVMjE3wXo+wPqSkL0yd/wCWyVFKEINx2RjJz5YbpOJGGMT4sdhoK94qgdw9x3i6Vs29nUUff4ESpGUDtcN/Bom8D8WCEpB+zSo5kMLkXhvvco07Q8h49T6ZPR+dEpKW/O4k4kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvE3TZ9ofEyOAcm+jJ6+3k2wG1W3iJLtJUppfe8a0Fc=;
 b=0GngFNe+1R0mcxc2L4/jR/xX5/UB9k0OAxKE72DnHD4JHVCjxqS7NNjri9uh57lC94LWQO0+2grj05RRVMlG4Xp7he15ublc2WZrXsNMJrCEjMrndJffEMZKq7hE5QZROFpWQcrotZvR0hoygJkRiyIheFqJLJVSlQrYMssdHfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 09:52:45 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 09:52:44 +0000
Message-ID: <171ee029-8dc7-4065-a4a2-f6eeb63b5821@amd.com>
Date: Fri, 29 Dec 2023 15:22:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix type of 'dbg_flags' in 'struct
 kfd_process'
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20231221173949.1403999-1-srinivasan.shanmugam@amd.com>
 <257cfdd8-17ea-44ef-bd41-fb2f03232e76@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <257cfdd8-17ea-44ef-bd41-fb2f03232e76@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 829721d6-3611-48ab-af52-08dc0853e7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZU6U4ocyXll1kx1j324bMdSlSzr+Mn1kfia6pENY7E0qvY6UGKyjDtSpZj8IVpShtzvF4db5LMGMol63d846tf/8sMR6zmHpF71zk3NjxV4STmOdMWjsBqKmGlffQn1QPrrlLf1GMTjENqm2QnqUSM/+Nt2m4+HnRenv8V72qc8OfCthfRMgPT6uWyzhmfLlTSQNUONumMhAGbTBZ4tJMWyKEDeG7NSasiceEimDK9fDhcef+uCeGzKzkaQFS23YPHVIyqEYhumTTb5JDdlxstzgGzHqWDplqQlod6RIx7YY6t+8ZX9pn1d2M2LuTdlfk6+DxMugElkvE9aUIz1FRhnKDhUtTO4lQxOtem//gzWJVJD190d/pasuiaDWdJYIBNP5CNOkeWCJ91HZPni8EWgGXAs5bWyrbn2W1vzmVgoFzAKShxUEkeWu5F5Zj36IOjCqp0c25Cx17KMLvIbWeuXJowfi1n9r9wSzx61WOiGl0VWiI1tJyGBY4N22X3ICGlr8UnhQEbkctIqlh1L8sda7ZoI8qk5SobEzka2ONNgUR9DPwcaB1InPFAPjkX09dsDU5/04tevcSRSZfgoo6cImdj6EZ3tDSeoH4AfS7hguQgWsoEQ/JjgbTQbdXeDqfb/2903047YM9F+y+avKfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(31686004)(6512007)(53546011)(6666004)(6506007)(66556008)(66946007)(6486002)(66476007)(86362001)(31696002)(38100700002)(2616005)(26005)(83380400001)(41300700001)(5660300002)(6636002)(4001150100001)(4326008)(66574015)(478600001)(2906002)(316002)(8676002)(8936002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEd5MjFNZEZWd0hHOTBIbjBuRGVmZnhRejIzbzQxemxyZWcyNUlpK1pCNG5R?=
 =?utf-8?B?NnVPS2l6aFczcHBCc3VZd2ROSFkvVS9peHdMdzdnRjdvWG4wSHJ0OWh0ZUQ4?=
 =?utf-8?B?L0lvTWlDZk8vK0VLR0ZQSVF4UDU0dlRuM1ZWQ0JncmNRRHNZbFRqNjMrMjd1?=
 =?utf-8?B?TGdERVhncVZaVkRhVzhFV29Ja3d1Sm1mcjhJTlNiclprZ1FLL3Izb0pnWWJ3?=
 =?utf-8?B?VlIwZjFaTGZvMEdjZllRYndnR214MUl0RHZKMFhSWHJCT0FXT0hQQkxlbTB0?=
 =?utf-8?B?ak9rVEpjVitJZDB5OVVMZUhRalBuS2JieGNyL2pzamthK2FIYVBPUlgxRzky?=
 =?utf-8?B?Y2M2K1hrVjFYWUE5ZG1uMWtNejJpNTNnZTdnRkdEckdFZTBPbXIvaW9kRW83?=
 =?utf-8?B?eHF0Z1VOM2xXbzBYc2xPREFZME1FazhnWFlQa1JjSlIyWVBZOFZQenZjbm8v?=
 =?utf-8?B?SEdtY0ptMk9adkphUFdHQVlBbTdpd0tHL0Fta0kzZ053and4NHdHUTFxeUxY?=
 =?utf-8?B?dnlTWEhzaEZRVDNGTDNvSnUzV1pDQzhMOWFBQzdDb081RVVVZ2JSemVmTHo5?=
 =?utf-8?B?ZzR3b245Q2tHYjVLVVFYZzdMQnNvY3dISmx4OFg3L0E2K3dGd1dPUFY4SXZU?=
 =?utf-8?B?ODZTeER1SVUrekNKdk5qcFdjZDhnTXhwbHRtbENlNG1Sb1Y4MkFmVFFpNHZ0?=
 =?utf-8?B?Nkw3S1UyMXo3SGdneUFUcVdVWWVUSTMvUDliMUNVdTRxVnB5UVRIcW5Bcy9F?=
 =?utf-8?B?TlJ6V2prTlJZQXpnR1Vjd29IUklUMHAyNzE4WUV3MlRwZkRmM1RBTEVnUXZB?=
 =?utf-8?B?RHJnZ3QxV29rWVhMZGRUcW1NR25LeU9FN0RZS3FmUkVsdkJPTDMxb3N3ZDcz?=
 =?utf-8?B?Zm9IdXF6eDl2a1d1ZDZmK2hYRFovKy9IdWNlWGl2MDJPQldUMHFzL2pZR2hV?=
 =?utf-8?B?M200MWovb0FlUWxoRWM4WURUV09xdElBT1lmaE0zR3JzVWxJODgveXkxVVVs?=
 =?utf-8?B?MkVVUEFIalVZOFptTW5KRUZkbzN5cFFIVnZieE9vSUhtTkxkS1hCOEcyUWVp?=
 =?utf-8?B?UHBKandmYnZSMU1NeS9VK0o2TFhUTjFtc2Qrb2hhNGFJcmpnTFhLajhxbjBm?=
 =?utf-8?B?eHdUakVENDdocXZLWVdWWG9ER1FoV1puU293T2NaK0dPcjJIejJNc3VnV3Mr?=
 =?utf-8?B?cHZ0dGlBR1BWN0pxR3dXeFp6blV2VE1YY215SHBnRFhWN3BqV3dlenFtL1hL?=
 =?utf-8?B?OGpVNkdiTmJSVDg4Y3V5aE5IQlVnUExGdUJlOXYraG5IM1o2YTczTEg3MFRq?=
 =?utf-8?B?SmZMYmd0ZkY1OGhnZUNTNWw1TjgycmtETThZYTRBNjhCU1A2OE9WRTBhVWwv?=
 =?utf-8?B?L2FySm14eUlxUEl0R3BwZzdISlQ2eUd3alZWVFVzRWlhNmc3d3VTNnBUUXFr?=
 =?utf-8?B?SFRMR2YybVBHOFlLM3B3WGw2TXVFOWQ5TUZCVHdCYmFRTDA4QzU2RlpBUWJ3?=
 =?utf-8?B?bFBpUTlzQVZuUTNTYWhsZE5JSVlhUFhiWHF2RXlxOS9ncmtnRGpIdTlFSmt6?=
 =?utf-8?B?RGtVcEV4VlYzL0x5akZJcktVVVg0SEVhTVB6YTJNOW9QYUNNRXVKektCSlFv?=
 =?utf-8?B?eFYxWGhvWjlDSVpETTF4cElyaTN1T2MwdE1JRVd6ZmM1SythUFZLMXJ2TjJz?=
 =?utf-8?B?SkI0bEtreEpmMFFLeXVYZ0JhKzRmWVc0Tk1jTXUrbWFtSWw2RUZFbTVPUWs0?=
 =?utf-8?B?VFBmU3MrSnF4blJDRkppSHdJMDdOQUYrbVNoUFh6RlRFYzdFZnR6Tks0K3Zj?=
 =?utf-8?B?V0dkU3JBdFE1M2NVZXpadXJXc0FVREZUUy9paTNtSXZsMVFBY0cyYktHSCtN?=
 =?utf-8?B?ZFFNM3g0VjBOblBhbFVXcjhLRVlXSm9LRW9TNEczNWlRZi9zZ1hXZnJnUjZH?=
 =?utf-8?B?QnJCMTVKVUdsN0RkbVZEdm1PT0ZReWxZdkxXSDQwVVdmc2cvUVV4dit5d0NC?=
 =?utf-8?B?Vnh5dXpNSGJoOUJMZE9KNHBVTmVyS2t5Q2FrTlJmTUZjVHE5L2MrMDE4bU9G?=
 =?utf-8?B?S0FQYUtrcDd3dlVwTjU4WC9ORlAyUTl5SDJDSXJnZHVTY3dlem9rY1ZmcmhQ?=
 =?utf-8?Q?qGB6F+UfIXCqIrNng4kAcRlJe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829721d6-3611-48ab-af52-08dc0853e7d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:52:44.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJnp1aJwjd2X3TySaBV156qKRKAoGo3Wclk4ZfmMASbPfaZciveyEXITapEODceu2KFkjtHWJTh58TNVfGeFLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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


On 12/21/2023 11:30 PM, Felix Kuehling wrote:
> On 2023-12-21 12:39, Srinivasan Shanmugam wrote:
>> dbg_flags looks to be defined with incorrect data type; to process
>> multiple debug flag options, and hence defined dbg_flags as u32.
>>
>> Fixes the below:
>>
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 
>> pm_map_process_aldebaran() warn: maybe use && instead of &
>
> Please add a Fixes-tag:
>
> Fixes: 0de4ec9a0353 ("drm/amdgpu: prepare map process for 
> multi-process debug devices")
>
>
>>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 45366b4ca976..745024b31340 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -970,7 +970,7 @@ struct kfd_process {
>>       struct work_struct debug_event_workarea;
>>         /* Tracks debug per-vmid request for debug flags */
>> -    bool dbg_flags;
>> +    u32 dbg_flags;
>
> For consistency with the rest of this header file, I'd prefer we use 
> uint32_t here. Other than that, the patch is

Thanks for reviews & feedbacks Felix! I have proposed an another patch 
"[PATCH] drm/amdkfd: Prefer kernel data types u8, u16, u32, u64 in 
amdkfd/kfd_priv.h", where I have changed to u8, u16, u32, u64, for 
consistency, which is the preferred way as per kernel coding style.

Regards,

Srini

>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>>         atomic_t poison;
>>       /* Queues are in paused stated because we are in the process of 
>> doing a CRIU checkpoint */
