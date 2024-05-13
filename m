Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188ABC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 11:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7739D10E658;
	Mon, 13 May 2024 11:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtQ+/rEf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075E310E658
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 11:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fekEU1pa8VxiGgSQYbDtHF7C6/w2rZOU3EWsVRuEc68/d8JtQYXJiU7WDrhYAzWy0DcNben9hb5fgdrQEebs/1I5KLGGrIe73Y3HYfNrmvvhuvijbMOw6jVxBQ/KCC6WAKYIUNsEs9+DPQwQlOlWwSHFgtfijjpbEwKAwxG6XMDJoDHr+mdz+pl/zYdn2TYnGALnjFUSbjoCm9Mw7k34DSD74F8bX5L3Gm9OajA0Hgcee5YmmyZgGUAmTFbP8oPTBhe+BYiy2w3J4sMdYSJiWSjGgKDy+ieK7TSpjmwCRUyQ/mNr3AeIIwy0gQ2/xcfdH7ti7ld69PS4MPkGEhGZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7LKPKueA2w8RAw/qexja0Yj17UHYk50YKWFq+ImoBM=;
 b=E3P1ADonjt32QIone5zg+Crz3dtom+knhR3LykxSDiRlXJoyvIXFSF0izPNowq8XZvUXPax26Q1I2ENbHgloxCVXnwoigLOBU4Gtb4oYP+0ELyMVDqq4R0Dx736WzSNnEGAqwKAj+WQKxe6InfXxsp764l/dPzvxgS513s8xdfqmB5FawWrZs1Bcns5CvfmX7LMNid6LZDtNzE/dUmewrkm9581AtO1vBWvHtfYo6s6BxNXsrx/b95+m8OlSpXqP/u+Q8xenKV4JNydaJ5MGUKON6WZX+E9QWluNrIbxXrV/huX8J9mhFQZ2i7jum6eDHfpEvokh16euYTf3yNV2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7LKPKueA2w8RAw/qexja0Yj17UHYk50YKWFq+ImoBM=;
 b=VtQ+/rEfxsyYc2COAVtPdQ7qw7t23QkIXRanAqIe3HHZQegW23rQUBPGnQ+5lusb5rFjChIJdfnkUfYaRirEUHuwBleju2zP3AqXZwH4UuuTG2BFW51H5wUZJn2ZG/jTMDWCey3e7VpWbrLoBG6TeDDyNPOBrTHZB/JC5lHAebM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:08:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:08:25 +0000
Message-ID: <ca0dc01d-f8d3-4676-9c70-74f8262ccb8f@amd.com>
Date: Mon, 13 May 2024 16:38:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-5-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240510025038.3488381-5-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: dfde3e8f-bc33-4463-289f-08dc733d0276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmtTZFJBNlFLMVFzSzBmMWhoWUUxcDFMQng5eFR4amc1cEhWVk91VWVrRDhT?=
 =?utf-8?B?bDUyTUpSMU45MGJyd1orZG9qVkl6QURoYk5hYVgwVzJFandoU1g4T29qRFA0?=
 =?utf-8?B?S0pQM2w0TlhIaDRaYk1NMVIzN0tmRWdlQWQ3NUNOSGlkNVBZWFJHY3kwbjNQ?=
 =?utf-8?B?dVJnOHFKQVdXQUJ1aWkrMUx4UXNFdWJsN3dIbjVTa3Z5WUFqbUp0RFBVeHRl?=
 =?utf-8?B?eXhBYjhreEhCd2dZYU1TdDhJWjNqKzRIeFBlb2RUQWUxSVV2R1c2QTVNODZH?=
 =?utf-8?B?UWl1dFh3WmhLQWpkeCtoa2xZSnk2dkVTMDRFMGJEeExMM0JXZGMxUnZvYUs1?=
 =?utf-8?B?TDZ1N3NyZVJ4dUFnVk5xUWFMOWJ6RWhBUS9pa0lBRGVyM1hWbFVrN1Y5OG52?=
 =?utf-8?B?NmRvNCtNSkpQdVNzK2FpaVhGM3pzL2MwWFRVc2lsZFN1Vk9KbUNmZVNXRUpJ?=
 =?utf-8?B?QkY4SGNlWVQ5a1hiWE5heEcvbS82MHpTRmJ3bDk1RTFLblMvbThZOUhLY2pM?=
 =?utf-8?B?R0Nvc1pNY2lYclJzU2lXS3AwNThpRWphdzZkM1BkcnQ4dThDVnQwc21RcnN6?=
 =?utf-8?B?OUVWWHlRTWdBTmJYViswRmN1TWhQWXhSMFdQWTAxQk9jMnNUZm1jRmVBaWpX?=
 =?utf-8?B?Uzh3dTJZRmppYnIzdHk5a1ZkRy9mdGwyZENsbGwvY1NwZlkwMytLNDVTZzJO?=
 =?utf-8?B?RGswL0VmRlg0T1NtRk5xQWRkZEJ5K2hXSGpMNUhabHZyRE9kSDcyNS9RcUM4?=
 =?utf-8?B?VUNieTV2STBXNEtmZDJZYWZjeUVKWXkxMTF6RHBKOE5FMFIwZzFrVzFlUndT?=
 =?utf-8?B?SzlvZDBYZEc1V0ZEMndsaWlXc0pNa1dkWm9oZktBYVgrQlRpakhuNmk0RWp5?=
 =?utf-8?B?RGsyajlueTI0N2V2KzcrcTQvYkRBRDcvV0lhbEh6YjZTRE8zNk9ITEc0VTBa?=
 =?utf-8?B?MG8yZVBxV0hwU3h3VGJ4VVNBUDBXdUpEeWVNRTNLQkFoWXpLeVBqc1cvVVV4?=
 =?utf-8?B?Qk1OMnlKa3ZNMkxDT0J6VnBENWszczNjNDg3d0lXMk1LVTNBT3hIVTdCbnAz?=
 =?utf-8?B?NjNnNzRGUms3NGpTS2FOcndHK0wwb0MyOWZMUzNiT3hpN2lIS1hmVmcwRG5X?=
 =?utf-8?B?ZnE3S3hHRklvQk9xcHlibVR0WE9qN0xZSTZIQXZnZjYvaWcvQUh4L0xpUW16?=
 =?utf-8?B?NVdIcStnMGNpTnZ2b3c0TDdQWkhha1JLVXEyRk9Gcy91UTNIUlY1WTJWdHIz?=
 =?utf-8?B?a1NwR3Mza3B3VDh0RjB0bFFqQW9SY2drZFNNaUJSQlV0eEhYRVhHL2Ixa2JQ?=
 =?utf-8?B?MWE0dGN6RG04WXRTRStpWXpMRzZYYUZDOHlONW04aDdhTTRjVWQ4Wm95c1Mz?=
 =?utf-8?B?UGhvekxUcXhYZitxU3RqeFpib3hNUjQ5TEgwVlRaYzc4MlBBbnRpbU9LOTlC?=
 =?utf-8?B?a2JjdCtnR25kYnpFeEMybmJDVGJJVktKdEhoK2k0SlBldm9pcjFoVEQ0OTV5?=
 =?utf-8?B?K3J3R2R3bFVIWlkrQVBZbDJpSDk4Y2NtZmZLN0tNcjRMaThLNEFDRjE0OWY1?=
 =?utf-8?B?NkJUbDhieXZWV3dlSVJuekoyNExnd0NFVDR5TFQzN2M0U1BMS1AyZXFMcmgw?=
 =?utf-8?B?Um5JWVVKTnJ5VEZlQmU1ZThQVWZOYW1RV1RjTEhmU1FHU3F4RDdYZkwvMTR2?=
 =?utf-8?B?ZXhEbDJBc1g3NjdXOVRhVDBXQjBVaVR1ckZUdmQzTFpOd29ab0x4Z3dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJveW1adzJadVVhVDdEZXlNNHk5OVh1MmViclROU09Pdm1QUTQ0SWppZkp0?=
 =?utf-8?B?RkdPMWlIUXJnekNlczJhVE5SeWNZZlcrWUVVZFdQd0tUSjRHaGZqTUlvWDEw?=
 =?utf-8?B?NUZ0Uk5TZ1pxRVZQcWZuNlpnMkhvWWt4bDBBcGkwWm9pN1hXRFFkSTlEanJT?=
 =?utf-8?B?ektIVGVPSnRLaHVaSWFiWFo5UTBhaXVJM3lKL3lJN2pHUW0ralQ1QnB0Q2NL?=
 =?utf-8?B?YkxWMTNJL3JsMmFmOWNRSlVMd0ZWaVpid0ZnUFhkYlloTEIzb3AweTJKT25i?=
 =?utf-8?B?QnZCZHF2eEdIK3lrMFZtWU85OWRadWNrY1pPNXNCV0V0WnZGLzI0Y3pNeFNN?=
 =?utf-8?B?eWlMZVdTMjZoNXJuek9td3VEaTNhYXVrTUt5VmY1bEhDc2VZSndCdGIrbXJJ?=
 =?utf-8?B?WGJxbGtINXllNHg3a2ZqSnJqb0pzZlF5TDkvalF2b1ovc1g4TlFWRlRTeXZ3?=
 =?utf-8?B?dW9CTm1Ya0d2VFFlZ3BKUGw0NWRyVTNIUnR0SmQwZUZETjFUdVNlTnNlVmtG?=
 =?utf-8?B?RmcycXJYaEpnNW10TDBpSStIcVpSTithTkxaeFNjV3YyOCtrUGpiZWJOa1U2?=
 =?utf-8?B?dnh3N3IzZWRmM0FlelN5ZmNiTzQ4VW5UYnZla054dWJNNVQxMVorMU9VSk5Q?=
 =?utf-8?B?U0V5RkcxVUxHaUU3Y3FNVmhoSkxBVEI1WURsdmhjS05yeTlWbUZ2WThzQjM4?=
 =?utf-8?B?aktEQllhdUc3MG5xcnF6d0NRY00wSWdaMUVwVWozYzNoWEZ6dklnNzNuS1Nm?=
 =?utf-8?B?cWw3S0tYZW95YldtbUF3KzIyajNob1NvQ3EvNU91ZFBQYnB1TkxGOGMrRkRH?=
 =?utf-8?B?MkloeFZsUDV4Nkd5ekJMaGZOZjRMa3JaTkYxTGxWbDRNOEVxd1JpQk9PWW53?=
 =?utf-8?B?QXA5a0taTHNKbk1TNFlYWHIwb3Z5bWJEY3RmTHNpZTQ4UHUyRitPNWJLa3NE?=
 =?utf-8?B?aEJrcDRaK1I2allmYVh5a3ZVbVpHOXJmdDUyWVlPRlh2MkkxVkJYOExNWUxZ?=
 =?utf-8?B?SkdBeVZKMHo5NGRCemU4bXBKcUlRN0pFR1F0K0hZUG5Ra1FJTVhwZ3kwcHpq?=
 =?utf-8?B?L1lrQWxCR0FELzRFT3RvdlROUXNaVnB2TjJaVW5ITUg0ZHBOTzBWWG42cmVT?=
 =?utf-8?B?SXBac0QxWGtKQkd0WDdIZXQ3ZVBjOE12VHdERmdRaGsya1hSWDhIYjV3cU03?=
 =?utf-8?B?RVJtakVVVnBiRjYzVy9hM1BjZ1FyRVpBb2dibkxBRERLOHdJMCtPWFlERmRO?=
 =?utf-8?B?K1RqNHFzbUFPZk5YRzJPOWg3cUZST2k3MG1zOVJ4VlNsbk52N0pIaWw3em9Y?=
 =?utf-8?B?VXJSaHAxUFhpMDBYSURHSVpSNG9ZU2JCcWFsdVozQjF1UE4rRjJwUlZlVHov?=
 =?utf-8?B?aGd6OXdPUGdOSjFqVVNac1ZWSWQwVm81a0lSQkxuVFhqVmVVMHRqdmV3RTJP?=
 =?utf-8?B?YTUvM2M2QWdvSnNZRkVKbElJekorSXNrWmR1ZU5UcWdYUzlsVGQzS3BCME54?=
 =?utf-8?B?NjZkRXhTQjc2YURDQ0tjL2RxaEc3aW5JSGc4Sk1VYi9lT0t6bTVlMDBjdlJP?=
 =?utf-8?B?VDhZdHppaXpzeDA5bDNZWGt2QkR1WFFDWlErbnpjTEtmV1VPKzFkdU5VZnh3?=
 =?utf-8?B?emVLT3BERnFFb3dWYjZlcTh6Wm01cHkySXdncUJPRG1rL094TGhIeGNtSjI2?=
 =?utf-8?B?ZnJIejdZVi94Z3c4Qm1TQy9hcG0rVFh6dlZCTDJ4VlQ4cURoODBvQUg1T2Zr?=
 =?utf-8?B?UVVId3A0aGkxL1JjN2Q5UmFDM1lrU1hicVZ5QjU5SWc1bkZLK1lGT2lDQ1c5?=
 =?utf-8?B?ZTd3T3B1SjVZMUJ4L2sreEEzV29rY1hzN1FraWlqWmdId1V5MzAvamtCbENM?=
 =?utf-8?B?OFhPcFFQSzZ1a1BMRFhkbEU4SFkrUFpCUnhHWHpRNTZGRnZ2cHlQL3gwRjZE?=
 =?utf-8?B?NVY4dXhaSk9kUlFRdmZqMDJkZEJFQzZRM3RzcTRSY0hZRFJ3UVNlejFBdUN0?=
 =?utf-8?B?UkNGYy9kcmRWbWFHMTU4ZUZnOEl4VUE2bHRDa2tqU3EvU3gxTk5qckFBajMr?=
 =?utf-8?B?VnlhdnNkUEhxeGFXZWJCcDlFNk15aTlhVlNuRU9CaFlGNzg4VG5uNmpsa2pj?=
 =?utf-8?Q?ir2KwLPPUPfR0D7JWPMtl3D+j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfde3e8f-bc33-4463-289f-08dc733d0276
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:08:25.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGxpd6bS1FWTh7qCiSkUxNhnRhesuU15VfgDClxWzHITq+XoJRXjOD6EIhwExLDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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



On 5/10/2024 8:20 AM, Jesse Zhang wrote:
> Check for specific indexes that may be invalid values.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ce941fbb9cfb..a22eb6bbb05e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1886,7 +1886,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
>  
>  	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
>  						SMU_MSG_GfxDeviceDriverReset);
> -
> +	if (index < 0 )
> +		return -EINVAL;

To avoid warning problems, drop index and use PPSMC_MSG_GfxDriverReset
instead of index.

Thanks,
Lijo

>  	mutex_lock(&smu->message_lock);
>  	if (smu->smc_fw_version >= 0x00441400) {
>  		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
