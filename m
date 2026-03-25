Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315F2FEA83B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 10:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B808D10E6F3;
	Wed, 25 Mar 2026 10:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0+M4fQgw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4E010E6F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 10:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtD+ZcT5TWEf/O4v7MJ+OEY8DN85zIVpM/7bCcSuHY5Zzxw3z0EPps/TgcI3qz8RvBRKmgUA53UZzqV6OINuEJQFmMqjjErQBO6+GC3aCQUN7O/M1w0VkkgdEM7FdX8f+b7qPdEqjyLyDK9C4jASkYTPhPZ3la2PyfTAX3FJ8FpBlh8EJQ3WX+cTIOJ49rIbbCSxKfXQNhBPV9jysdFvjcP3ESqajUeMtVvUwgQcqiL3Lj/T3wq1qcmetA4nhBUGqnHeenYbxXSJfIjWyim6sYXRdyY8qNeb8t2Hbmw8qV3MwKY0zMKOAjtKVXZACrcU0j/1aXd1Z1jjHgJ6sEnscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjDZ5SP2q6byDbl44F7YwbALj94IFcrZ64qBwgzNiXI=;
 b=vt7h8OMPDMGmFhOWcCZ9dQsa5q5tL73kWToMiVbOLyqJvlc974PvcufiK25jCkVX/yBdkRRhFnQ2PSCGDWlxkfMmg944Ch11VDoO0b/9Dv9NXN8bDg26aQFZoQXhyIxyvzvcU+V09yBcU9lxQY70f+qC3no0WAIeTL33zs6hb3p/c0Z/6x4W7jxXX20YBs8CxrNBRLL6rLuEfo/AZk20+uqo69x/mSYiqPWJ0mfxuJJJPNwIFxM7MU13Y+g9dOeaIu7IrK4DNAEcd/u4xxgMMSA1lYycES+w3ke0bLkFZaFz2pZ4cbUHM5rRCGfbvvD7vnScUKbtLN7VQlEYSxcQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjDZ5SP2q6byDbl44F7YwbALj94IFcrZ64qBwgzNiXI=;
 b=0+M4fQgwAW4KIueMTP+sfUCZ4aLW+TKAvxuITh/SYoul9XZ1OzTpQT4Va+hPmLYahIOHcjh3lKo2gj6HXni95DKj8tRCYaZO+FRm2XPysZdI1VdRfmyV8jp0HUpy4qfi2p5dbWcO4sImANcFfCNdRoA5qBl6+qf7Io4HL6YAb3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:10:00 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:09:59 +0000
Message-ID: <1dd19c31-66fe-4a77-bdcc-2bfce4ccf36a@amd.com>
Date: Wed, 25 Mar 2026 15:39:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Use str_enabled_disabled in amdgpu_pm sysfs
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com,
 kernel test robot <lkp@intel.com>
References: <20260325095813.3374163-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260325095813.3374163-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d7d04a-3d1b-4199-26eb-08de8a56ac2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: IrF6GOR9vaHysYKG7A90gkEYO2dKyZ7FM0GWj1iqXiUI40TcH1sf7UrlZutLzLCTjF0BT6nsUQ4FNiR6VFM5ifatSklf3fnEg4kKLQRKmzRHugLULRutIBAwJzHutKdKXc7TqYYumSPyzq/K4SS3IYZhpoOlKp0rS58RK6qnXptaIDEyukLePQstlhboVfuGD8njc5Fi3MZLPEchttnskKsajNQm5gCwXrNkgvL4qM7q9sfuv6MovmP2KftbGZ3a5SZ4YVc6SLxMx4mOqsa5y5rH0drDwbwHJ38XFtTX5fSuWlHHiKp3xfI2OjTtcgUv5J+xVSpivTaSXg7jVeuGvh58kjc0IazNquUelXAJ+H26aGx/csW/XNfVEJv7LbOECxcxAv8E8SbxNec3Fiz/v1G5osqIngY/lDNaGv0JYQaOz/GmDYjIX7gPrncEBey4LvPunGmNp6Hip5u0B81voX29PHjbmSCcHOxKN4VTlBzs/tmovjWEMHmjfn2IdLQMejsKqrTxneS812OVMQKty+sOWAC2LtCkD2a+r4vNZLDOgKo0qpfZVux/AibTKmgpVkG+4UMUCgSZCa5Cs1M+enuc2EbmqlGTJ2HUWMHl8U5OJCGPyYMYhW5O1GDmHAtd+GsgH4mgO2s63onEyKipfjo1loeb2/68F644LIvet8l/QloFZ/cM/HG1oODZCa4C77vj2T/YOyEU/6Q1kKpkMmj9tB6b6w404i0FaLxTkiX81jyk4V22o6QmFjGs9XEH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ems0OXczWWR0MXF2K1l2YmRlNmNtZUpCeHZnd2VuNjI0emFZSldvWmt5RUFL?=
 =?utf-8?B?Wk80TW1TZ2s0K1dSbU1Ea3dKc2NSNFdGdFpIMWtVUnJQUDVSeWZNUmFIYVNL?=
 =?utf-8?B?NzBFSmZYQWFaR2lXbDFtSnAyb095NlN5cFo3djR5L0JPQytybFVITGdvR2du?=
 =?utf-8?B?bENlMkM5Zk5LM1RHaGpZS0NDS041ZVdQc2plZENDMDlGTDFvVkRXSUI1MjNj?=
 =?utf-8?B?ZXFnZkdPNzNmcU5BNEU1RG9mbmoydzNpMHlXRVg5bkVlemdhTXgvSE9ITFg1?=
 =?utf-8?B?MVdTc2Z1ZFZYcDFraSt3YWRwRndkaFNBdzhsNHZ3aCtWMEpseFJxWGYyd3Iz?=
 =?utf-8?B?VExrWkZqczRzK01WYkZsb1U3WUxwTWJ1Zis5S0V4OWRuOWhqSlFCWnIrd0JE?=
 =?utf-8?B?dWhYVXRzaWtqYUR1c2FnazJSa2ZqNmdrRHZ6bEdRYWg5NXp3R0Y4dk5VcEs5?=
 =?utf-8?B?aW9pWkxkZGxpL3B1dVBLMFZveEdvWmJKb0Ryc0tnbnZJYTNvbTdqZjhWajJy?=
 =?utf-8?B?T0cyMDA2WUt2V2wxNEtKQk5NN0s4SFVaell5c0ExQ3VyVTlNZTlMMHVjWDNW?=
 =?utf-8?B?MndWc2pSY2RjQ2lEQXdzTXlUVk5DYmw1OGlOZ0JNMEszZWJHdW1rR2F4ekY5?=
 =?utf-8?B?LzNDQ2tUdS83U0RJWGxuV3lkaEJFMkpER2hxNVJkbDgvUkhscDF2andyb2g4?=
 =?utf-8?B?dHd5VHhwY1NIZU1BMHJJUG8xbXNBdmY2dEtPSDJkMTRLZ1B6L3hsRS9td1B0?=
 =?utf-8?B?T0VjZk03WlNGam1ESmRlbnVRcEdsQ3lFL1VJczJwT1o3QStCWkFpcUZWbzhE?=
 =?utf-8?B?ZjlGdmdHTG1OTWFSeTJrTFQzWFdQUWVWUkVoRDlzTm54MC8wZnJiUTJTdHFy?=
 =?utf-8?B?QlVXRlBTRXY2L3RqTXZudmJlSlFtdFlTaXJERVA0UExNR3h3UUNVUnpNRFhp?=
 =?utf-8?B?YWdkUys0NGxKV2tEcGJqSmROaSsrVWFrcGpsZllzRlpkT3Q4Ny9tWUFqK2pS?=
 =?utf-8?B?amtpQXRyZTRudzZOY0JBVEo4eXBKaEtHL28veTNia1BVY1hDYkJuU0h3czdi?=
 =?utf-8?B?TnVGOURaT2M4RmFHSWdRUjRvV05XV3lSY1l3U1phc1Bkb0x1Mms0d2huVkJE?=
 =?utf-8?B?NUZzRjJSZDRwR3NWT0QyUEtySytNb1huUUtvSjQ5QlF1SkxvZzkybjJwNXF4?=
 =?utf-8?B?RE8rU042cmNJb3NyZUxQamFCQk9QSmY4R281UHZjZzMrNlR5RHVxaU5ZT3Mz?=
 =?utf-8?B?aUZ2UjRlMHNKbFBmdWFGYXdzYk1ramNsVUcvekdPK1Z6REFZWThYMFNYeDA4?=
 =?utf-8?B?V1F5cnQ5Z0xVaTNsTWIvWTdCRUt4THBtTDd0Smw1WVhla2dWK2Z4M2pNQjMw?=
 =?utf-8?B?RlViejc2MWc2VjI2V0tIYWYzeUQvYXU1cjFiN3VqbmxDWit2LzRza0czekQ5?=
 =?utf-8?B?YzBzUFdGMWtISHVnaGEwYnNpNFI0UzloQy96WjFVRE1XbDdtL3o0OS9jc21s?=
 =?utf-8?B?alh3NXdqdzQyRGNLWTNNWC9zQXpjbkRuY1RMQUF3VHFWbFcxY1NmaFVWT3hR?=
 =?utf-8?B?Mm9VbTJoNEU1cEpjQ0wyelhGV0g5NTQvVVNYZUlPY3dZTDdLTGVYTGp4b2lF?=
 =?utf-8?B?WmdWQldrc2VsbmJydlFtclZYbE1ycXJRR3RvZ2JpRXZoMEt0SW9OQVhtcjdM?=
 =?utf-8?B?UFF3RUVQK1pjU0VsaExuWVpYTndWL1VDNzk4RFlMeEJ2cG5iZUlzTVY5V1By?=
 =?utf-8?B?cTJPbTRmR2lJbVM3MEVWN08wdnduTXZPTFpqQVBPdHkrTmtFZ0w1TEFSb05a?=
 =?utf-8?B?SjZrRHRXaWtjU3MwbUdSWERzRzNSb3VCL3kvaGFGTnh0eFBvcTJ4RHN5NlRC?=
 =?utf-8?B?WEVhcnNFeEJjSmt5ZDJpZnpHVk1DQTROUkdzSU1NWTh4c0dsQkNPNmEyY09w?=
 =?utf-8?B?NmhQVS9ZcDMrRFN4VnRjN09TaTd5R29ybjllOXZid2gvTFZHbXYrQ1JBMWo3?=
 =?utf-8?B?d29sWUZDU0VXdjRWZDd5c3IrdXVsdVAvYjNLRml0Qi83RGMyVXJQb29hRldF?=
 =?utf-8?B?Q1phZndqRFpXRWVjZ2Q1Y1Bha0RlcFZNdEFLR09IUXZ1T2JERkpkK2xwMjJv?=
 =?utf-8?B?K211a0RRSjViYVBoZ3dCdDBUTnlRU21GVkNLcEZ5TFpyUzQ3T3ltWmNUeFEv?=
 =?utf-8?B?Vml2cWR1SFFaWFFSa0JBYnNMeWt4TGZLRHdSalVLa3VhaXozbFljdTJnUXAw?=
 =?utf-8?B?cmZyYUJ6Q2xRdWRweHgrbVBqUTRtV0svcTFOc0hDSDdqZkw4cS9vK0xIZlQr?=
 =?utf-8?B?N1M3b2ZhUm9kanRRZHRYazU4TE8vUHdvK0FVYlBqZUlUWTFxdUhJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d7d04a-3d1b-4199-26eb-08de8a56ac2c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:09:59.7552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDlFa05CDizOdZlw5ttUxIPjg6JDyV8Nyhe2N3rWk4MrGkCqo8JC2rojqAo5EmV1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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



On 25-Mar-26 3:28 PM, Asad Kamal wrote:
> Coccinelle flags hand-rolled "enabled"/"disabled" strings; use the shared
> str_enabled_disabled() helper from string_choices.h for npm_status and
> thermal throttling logging sysfs text.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603251434.zIN2QYWn-lkp@intel.com/
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 6565cc3e35f2..a4d8e667eafb 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -33,6 +33,7 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/nospec.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/string_choices.h>
>   #include <asm/processor.h>
>   
>   #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
> @@ -1592,7 +1593,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
>   
>   	return sysfs_emit(buf, "%s: thermal throttling logging %s, with interval %d seconds\n",
>   			  adev_to_drm(adev)->unique,
> -			  atomic_read(&adev->throttling_logging_enabled) ? "enabled" : "disabled",
> +			  str_enabled_disabled(atomic_read(&adev->throttling_logging_enabled)),
>   			  adev->throttling_logging_rs.interval / HZ + 1);
>   }
>   
> @@ -2235,7 +2236,7 @@ static ssize_t amdgpu_show_npm_status(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return sysfs_emit(buf, "%s\n", npower ? "enabled" : "disabled");
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(npower));
>   }
>   
>   /**

