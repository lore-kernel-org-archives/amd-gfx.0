Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78223E67493
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 02:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31F310E068;
	Fri,  1 Nov 2024 02:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nlmobhvT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0187010E068
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 02:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSJB1m/NYvJpuW6lHIFY72FmTQViElraM06YjDll48/ZSvn4Ye5ZnLjndRRGnkPOPHxbV3D1B8yYvaWIQNglnJ0NePnU68KvUAI3hkaimWCMs7f3kzPvweDqDed16sh8d/dVhEGBh4EEtS2ba+8MO6sEDEx3ozIIk/8jgT05ZdQL18PhsyHVfTCyQivjNUP4KctZZTuVLzdnckwq3gJPOILK1//IL8SCGhLSgA8gTVkdpNgF6TYyQh25NoJvqeIQukX/6IaUeaZZ+xgnKl91YwTUkz2LOPwYk/dxkK8P02/iDAiMqj6oiNrxYaKaD1b6iL4d66uFdXk3aJD6p8vV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WwEvMddbRh3Bm+eU/7CkpkGzi4tJAai/BQzZDRNTw8=;
 b=sY44I+RLDV+t2CkSjclFA3k9N3JKxAGAI+7VxPRavOThuL9APKCKbyrS9VjxBJbj0AFQESN+KFYINo5SNbwJJwzWCtcWrxj1i4PnGp9/DOoH3VrFXpmxKHfg8H7IAzLbkxQs0uIaqic4aEjkwFOs+2d1EHFo0uFNgzSOvuIXjqqBmp1ghVCTuZIp54V5k+Kl2yTKkqIOnpgdMRteCEt4Td9wMls+WFgzCx0F0Dy7qnJqmHsVzhprz7/0YCi54e5+AN2SHaKWMyfFSXkMkwnEx2BzWtyfTaDg5RtBPgLDhQi0CJNxd6Hv70jNtXRaoF5Rj/EGucpKbT4IU4WRpdp1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WwEvMddbRh3Bm+eU/7CkpkGzi4tJAai/BQzZDRNTw8=;
 b=nlmobhvTKwbIaylX7I29D9plv1qZDzQw7hp7ZE8uy1GHf2Mhd6grEbVbIilhNTjt0+UgQWcMuCX6S6s/9Vqj1yOLX4vBlOi4HETVJ+lrSaQW6QDreU7EYGEWgHYvoeNB3vCS/rpi6W9BZQYz/FkajPpZuQZPXfRZIRu3i2ukHGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.35; Fri, 1 Nov
 2024 02:35:31 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 02:35:24 +0000
Message-ID: <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
Date: Fri, 1 Nov 2024 10:35:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ac3796-6165-41d9-6fd9-08dcfa1dd6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVdJRmh4d01iRi9xOUovNSsxcGtTRWZuS3RuN0xsREJ1bEdYeUJKaTRoUVRG?=
 =?utf-8?B?TkRWVDNWVU5JTlcveTdPb1NmZXN3VmZLc0dnN0tKUmpkMkZVMkRLTmhRc3JR?=
 =?utf-8?B?Q0xOdERJYk9Vb0NIREhHblgrR3dWVC91Q3ppckkrUDRvRC9tMGlWcHFKa1lr?=
 =?utf-8?B?NVFZWHUvakg4QkhTTHlpVFREQUFlSFVlZmtpNHBGdWRxSWZzMnB6Mm1iaWgv?=
 =?utf-8?B?RFFXclRXV2Jkb1F1SHR0TFlXYWlobi9hMVM4U0U5cXNicWFWSkJBY0doenJU?=
 =?utf-8?B?YTFkZ1lteVk0RkFkVzhwazJwRWtvSS9CVWM0azVRYlc1Q2NHeVJYNzYwWTkw?=
 =?utf-8?B?M283ZHRrZ1E1a2QxcXR6RTliQjhtTFhsSmZEODl5YjdUdVVQMVBmbWZGd09X?=
 =?utf-8?B?USt2RGdlMFBxZG1RS1QyL1ZHSVl4SGFwYnJTOTBYLzlyYW12NXZBOU5UcnNz?=
 =?utf-8?B?aUUrRSthbUIxY1hxRTdUK0g3U29TMWs5ZmF0MVV2cGNaQjhIYnVubU8rRVRK?=
 =?utf-8?B?Z2xsdjNIMkRMeXhCemsvWGRjd3VOeFpMQlBrVytyZlBhcHY5V3Z4R2l4WWky?=
 =?utf-8?B?eGREaXVlem1Yb2hwZHZZWE1LZG84ZnJlU2xHZUVVdUdkSkhvbGZtZFBRczJT?=
 =?utf-8?B?dk90MXluMWlwYTQxeFpQeWVNRmJDWnV2OFpreUZGUXZIcnAxVVFqcXhFWWhW?=
 =?utf-8?B?OWNKT1Z5U1huaFZ0N2xKcElTNWdBVEIxSkt2MHRQMy82Y2w4ZDFvbFR6cU1N?=
 =?utf-8?B?R1hZVHQ0RXN4NUljMEZpZzRmbFVRcjlVMVRKMEtRZUhpb1VqdkRTMGdBc3Jy?=
 =?utf-8?B?KytUTVRpdDVZeW8xV2FKeDQ0OVFIeEUxdkdrTEVOdnRka0tEWU00ZkR6UkM4?=
 =?utf-8?B?YnJicjZOeG0rRkNxTENCTHhDNjRBSVJmVTdwcHZFMkVjakNSQVhFREZycENJ?=
 =?utf-8?B?UzRUNnZOc3doU0svZno4NWhRVGsxbUxLeU1FSHpiSFBiK2hOUkYvTGROM3Zn?=
 =?utf-8?B?QzZoWldheFpLNW1FNnVreXhMMGZndmZ3bytLcHZwcEhLdEdKYXVZQlhOQ0Uy?=
 =?utf-8?B?b0xvMGQ4enVJTEhCZTVrZmpvR0NROVRsdE5SYVNaMDl3a2p3ckhVWE1ad1gv?=
 =?utf-8?B?bWMrTFlHZkNrVVNmc0lvUlgxVU9UamJtRHRTTGJYQnVuK0Mwc3RBekQrZlJQ?=
 =?utf-8?B?RERlUmFWZzh6dEZpclJvUmVENDgvdkwzRDBGRGF2cXVnY3ZXVllDRlVJM1RK?=
 =?utf-8?B?allBTFRXcklYNjZoZ1FWSEhteGxrUUFQajJVQ0p1cmFBNGhXUUlVU2NlbzZC?=
 =?utf-8?B?aUtsZ0E1bXlBSUFZZGxhR1J1TVNwMjIwTlRVNms3ZEJrMnVGcHlrV1MyQ3h6?=
 =?utf-8?B?NUQ5dk1oSTZLbEJGbDRXSW5lWTR4TmNtRHdONkFMVDRwRWFydzVKRGM0QkJI?=
 =?utf-8?B?V2hGRFk5VCtHOVo5SlhPUVhIOXFNL3hob0cvYWU1SmQ5d1g5cVlwVzNKcHNq?=
 =?utf-8?B?a05mWjJGRnE0cFozdW1ueUY2d2xKaHVQV0R0cEwzV3Zzd2NVNlF4ejlyMStF?=
 =?utf-8?B?dkhPdjZTTmdDR241S2IwUytaWUltUjJsczNPNHN1aVhYZDRoOVZLbjhNNXpw?=
 =?utf-8?B?SVVYeTlHcjFCQ3JtalNHRkFvNUpXK0czL3k4eTkzQ0tLYytjTzd6QlhuaU80?=
 =?utf-8?B?czlBZ0htZnRleTBCYUZ2ZWNObGJqaFdZVVppdmpXZGNNNjI2OXpmc0o2WDRS?=
 =?utf-8?Q?aZB3OZofrPj3O5wcI+GsG+6LCQn9JAcVHvFw1a9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRUQUcvVlQwMWZlQ1ArUWJzOWc4ZHk1N3BPRFBLZ3YwbEFQNW5DWmtBTkpy?=
 =?utf-8?B?a0RPMzJBTFJYUFJUVStTblFxY2NJVzcrL2VLWGZpdUxlZEpFaldWTWZYQlJB?=
 =?utf-8?B?dVRZalE2dlczdUQzclF0cDIrb3kxQ0lvdUw5SE1QN21ZdmFuNDNSYXc4cFNG?=
 =?utf-8?B?aEhva1JKSjl4VlNCNmlDdVJnak9Ib05IczBnbTdGZ2UvL0F0S3F6UUZnNERu?=
 =?utf-8?B?Sko0Zk9IOHB2dTdxcFlxOGNvdXVBMFBUUFhmRThMeWFpNXZWUXBROE01V3Nk?=
 =?utf-8?B?N2ZrLzFqWm1ldjRTN2tHMElhK0xGTjhSOXdBRGZxdjl5L0ZUR1REc0dQU201?=
 =?utf-8?B?MVpMMnJKTDVDenIrUlR6TDNGZzF6TVVSa1ZWRnhMTlFxN1ZDMHQ3Q0lPVVVJ?=
 =?utf-8?B?bjZoejk3QkZ4Z1krSFhFN09HWVJwdm5NVmx1cHdUT3FJbHkyampFRnVkRGtU?=
 =?utf-8?B?NERVRXRndTF3a1YxeHZRMXF3aS8rM1NvaktuY21CMjRKRDNLTGRibDhIN3pw?=
 =?utf-8?B?ZSs4OU03MC9JTmUxMGRDekxLRkR1SVdoMFN3NTZEeS9kMW1LQ3BLNnJjaEU1?=
 =?utf-8?B?S1M2aHNoSjc5MGYwSjc4VUtyY1F0ZVQ3L2JuUWhyT2pLQXA2a1ExNTlDMFBx?=
 =?utf-8?B?bjBqWUVlbEdwNFFuMUtxM1hLbTJ5N09laWc0UmpWZTMvdmpadExNN3BMYTUw?=
 =?utf-8?B?WWZ3eEpYVGozNkxkQVF1RVE4Ujh6WDZyQjlGeW5valhNM3paYXYvNWdqMERw?=
 =?utf-8?B?L0dnVzQ0Z0tOSXdHcTBwTXQ0UTdERkdFSUVXNkZRZ0MwaUhnOUxjYy9JeG5Z?=
 =?utf-8?B?N3NxK2dLeDBHOHgwTGtRSzRZV0JtZ21xdVNUeFZVanZwcXRPVk1ZKzV3bFBt?=
 =?utf-8?B?NCtpS3JZbzhMcGRyckJ2WDlwa2xuNmQ0YjBCWGYySkpNc25oWkdvMm5leUJy?=
 =?utf-8?B?WkZ3ck15VnBVTDJQRGYvNm9FcjVxR050cm5LNHQ3cjNickhaTERJYlVDQjNF?=
 =?utf-8?B?cHpUTnY0T2tpbDN4ek51eVdoS2lHTUlBaGFvaFNXWENYWkt4cmVtTjNORnBk?=
 =?utf-8?B?WVBsRWhQdk85a1U4dzQrbk90TjIveVp2MGg4K05FMGt3cXJSQ2NOZzJYRUVD?=
 =?utf-8?B?U1JYVWJMMllXNFQ3VW92V3FaUVJsYUdHYTBUZkhoLzBhSFVBbS91bEVCTmpR?=
 =?utf-8?B?RzNqL3ZieTRsdmxLdXpPK2F3ZFdPeElQN0ZoUmZhQTlQZFptMkNFSThNbFpq?=
 =?utf-8?B?T3p2eVJoOFB2c3BZbTA1bHBTcXpEcHVJc1EwMldIUHlqMkZMU1dYWXNLNHBG?=
 =?utf-8?B?NGxVNjR4ck9ReSsveGVsNk1lVEdxQ0RCekZNaUhReXpkMzlkYkdPNk1uZW55?=
 =?utf-8?B?ZS8vSEU1UjQycThVRUhkaEkrY3NUMmwwc0NYQ20yQXAyeFNHSjlkVEdUMkc1?=
 =?utf-8?B?TEladE9PdVgxdDZrdktRcnd4ZEkvOW1weXVoL3JjU2NGVHZOM3FaMGx2d0Fu?=
 =?utf-8?B?aHRXcHRQcUtqT29IWTd6Z0JXM2ZTNkNZTEttV1JaTzdTT3RIMURhUlp0U29E?=
 =?utf-8?B?QmtVQisvd09LdFJ5Mko4enk3T1JKREptRXlsM1J6Z2FEdEl2cFhLUFUybE1q?=
 =?utf-8?B?cFZSdXpjQVBUVHpkdXVtZkY0Q25oc1JxWnViK2xUMWRnVzZtZVNxbm9HSTNm?=
 =?utf-8?B?eDJoVVRLRlNJMTFJcDBjaWRrNmVXTnJid2ovVDhVcVJOTmdTUXZra2sva3Nx?=
 =?utf-8?B?aXFubHBrdWVTL3dKQ2xnUnk0aXpMMmphSlBVWjZKYWtjUWJwNnRUSmlPSDRP?=
 =?utf-8?B?Vko1NkozMjNFSmxGN2dTREFnQ0lRZCtYUTM0dEtmbkYvVHBLUy9jWlBCWjNn?=
 =?utf-8?B?MlJleEhEKzVBUFp5YTkrWmNRV1FIZVUrUWY3cFRvSHdFQzNHN0JBQkFoZTI3?=
 =?utf-8?B?UDY3akhYdURPblBDM0tnYVdWM3dLOSszYnprNHFCYlJYTHBvcDNaakJuRFdR?=
 =?utf-8?B?ckpRbk5OZi93cjJnNVQrTXJXVC9YN3pGcWZLVHhUVnhoWVhUSEtJUUlUa0dV?=
 =?utf-8?B?cnFLT3Y4bDRkQWlQTnRBMCtPc254QjRmcFFnLzJwSDZSWm92cmtVbkI5elBj?=
 =?utf-8?Q?N9zkotKl1rcdJ+R69dgfAlIuv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac3796-6165-41d9-6fd9-08dcfa1dd6cb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:35:24.7266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81H1I2efN4/Kn72wJlxersVd3o7fIPPWISswlm9T2YkZUWxUF0vCf0jkmg2zuhO1wcX+5WJGdkLZh5BmDQO4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
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

On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>
> On 2024-10-31 6:50, Zhu Lingshan wrote:
>> The ioctl functions may fail, causing the args unreliable.
>> Therefore, the args should not be copied to user space.
>>
>> The return code provides enough information for
>> error handling in user space.
>>
>> This commit checks the return code of the ioctl functions
>> and handles errors appropriately when they fail.
> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.

what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.

usually the return code provides enough information for the user space programs.

Thanks
Lingshan
>
> Regards,
>   Felix
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 3e6b4736a7fe..a184ca0023b5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>  	}
>>  
>>  	retcode = func(filep, process, kdata);
>> +	if (retcode)
>> +		goto err_retcode;
>>  
>>  	if (cmd & IOC_OUT)
>>  		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>  	if (kdata != stack_kdata)
>>  		kfree(kdata);
>>  
>> +err_retcode:
>>  	if (retcode)
>>  		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>  				nr, arg, retcode);

