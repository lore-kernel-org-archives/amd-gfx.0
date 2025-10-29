Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1ABCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 19:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE9810E82A;
	Wed, 29 Oct 2025 19:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ZhZgjeR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DB010E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 19:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiXzkkXB2BZFErmmWEoMmxCbeGufRWyGcmpuRml6g1P/BT6jDQ2wTJOx+u+/wyrCJy1VEqdHcEOR0U2HdkO1drj9NvoRK3jePytnwqg0eKUHNsTijgR+lNJcGOZepSuXrxADH1o5dg3IIH1ffIsKsCsBz1ZWmykYoKLlMT+VF3a4/NEaZvr3bssYVZh5KOoq6inTQvneECWF4+R4C3jB4mp4ytXPWMEz2wm+mtAMIg6koAy7mHZJAluut/UbO3qrrE1WMH+2OZFXnDvBSX+gHONj7lwlXHCC+PqxM+AYLJrJE5LQWEVdOjWIRp8WeAwwqFGmAVCbcismObIkaFOH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg8BrtLrnBpzdj8k9ItM6GfOj+4CwvaiV6ziTfqKP+s=;
 b=sFAuSfvsuOfz61sud4jVMGN7/NSJHvWvfgnW/TFqGqgrFBGRNNi/L00G70xk8L8IMpzE8BkHnVpU1JWbTheiRwbXVtWiHMgc5QF06vherKsDwRW74FRWO14gcOEfb/fEXyUfugnn1wQQrkRO1d1Qyqlh08BcaDkoxF57cCzC/vef6DWpSWR7kFotOeXpUzv6RSCiG/hQAaYE0GMMoMXD5cmZSk9hp9EnyWJDQN1GnYVb00jtyf1ZHgHEtW4A/6q5uRGC8LsWplgGyHgJcVfuj4wSHQgWfSKcGuVkdA1IIQyLVdAuCBtt0oqDQQHG42TqgLleRPOS01aru8t605KiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg8BrtLrnBpzdj8k9ItM6GfOj+4CwvaiV6ziTfqKP+s=;
 b=2ZhZgjeRUikhEbQ1IhlgH+q3OHqnP/o/NTB7KiUobsqjc1910kssC33pmWjruYLpWs+DjQbeMrglsBTKrJEVApK6Yjg/+OvNnlcJ1f+4LToqC1B1QqLni2oVXkjPur208zx3MOHZ7ne3aC2+h/Xw3uo5WciPAfC9eI++7cCKjO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 19:40:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 19:40:04 +0000
Message-ID: <28fa6220-dbc4-0825-ca93-18fe45359c5a@amd.com>
Date: Wed, 29 Oct 2025 15:40:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix GPU mappings for APU after prefetch
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251029013104.4034287-1-Harish.Kasiviswanathan@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251029013104.4034287-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 902ac314-3485-4d46-29ee-08de1722f4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJrd1VTYW5ud2ljaTRQazRxYWM3QnFMWVNPZldZcEpiaHlaZ3pZbzRLd2Nl?=
 =?utf-8?B?Nkl1cE9hZ3FsNjlzMS9JTmZzVm1qUytJa2pTeHFya1hNcU5qeHZheWhwc2xn?=
 =?utf-8?B?d2F1MGp5ZFNla0ZkeXBpK2FRWExnbTIzT2pxNGxaODQ0VW9ncmc4eUZoNzZX?=
 =?utf-8?B?UVo2eHYvcTdiRnlnWHZ0ZUpqTjJNbjR3akJaZFdsa0g1enJ4RzhlNFZjTFdM?=
 =?utf-8?B?dmtZVGJKRy9xRjBDNFZPb1g0cDRJd2dhcW04UHFoZnF4SXBtaFB5TVNIc3ds?=
 =?utf-8?B?VlZaOW8vUHNZZ3hkcURRT1ZOY0Z2QzdGQmFaU2dLMkkzRlFEa0RYTisvWG56?=
 =?utf-8?B?T1RTTDJLci9XL3lHd20yUVZPd05aMHRMeXBYaEVHSTJWL0cyQUVsL3VnOFVY?=
 =?utf-8?B?UUVOK3Rzang5NzhabDJ5RGJGOGhOZnJ2U1R0b3lkY3lHYVcvbG9FbG14MVJu?=
 =?utf-8?B?TVoyTEl5TUFHcnRSVlY5RjlNei9mSWN3YU9rKzdmK2M3WG81YmN4MVZRZkFa?=
 =?utf-8?B?V3l0TGRCK3lYNVVzQ3Q4NERoSDU2eFBIT1l3KzZ3NVhtZlJPdmFsM21hbXZP?=
 =?utf-8?B?VVFqYWUrdHBqQmZTNjUweU5FRWdyTFMzZDNKVFFrTzVlbmN3cjdjU0NtTWVu?=
 =?utf-8?B?YmdoNVpzbkxSSFlXQkhSV0NxRlBHdW4rMlNHbmpPZDdZMUdTQUgvbVdKZG9r?=
 =?utf-8?B?WGhTOWVXT0NsVXdqT3ZGN0wwYW0xYzhtR094MUoveEhzd2tpWi9wR1ZIOERG?=
 =?utf-8?B?OFNhMk1nR0tYY0MxNW9XUTdnTFJYNGMzSy82cHdnUWF5OTFmR0ZhUXJMMUxx?=
 =?utf-8?B?SjdaSFhiQWRvajU5MlFnUkdlZFdvVzN1aGhZc3lIY1hvSmI3U3M5UGRpYXk5?=
 =?utf-8?B?TFVRWEpwZXpiNVk2S3Vxb0NVbXZHbzkvUklJb215ak5DSkFhYTJya09XckhG?=
 =?utf-8?B?cjF4aFZZbVdWZkhiQTkxTEZlR2NpWEdkcnN6TThrblV4ZnhhbFpkOUVnYm03?=
 =?utf-8?B?T2c1YnRoSThNV0JhbWhwZnBTUXRKL1pqSUt4SktIaEpEWDJjZnU1ZFkvY3Y5?=
 =?utf-8?B?Qlh4c2dSQUlUVTJaRjI3Q0tkamY4SjhWREZrMUtBWkpGYWlLcGszQXFVbFBV?=
 =?utf-8?B?ckZ3dTFnY3c4NWRvVis5bmJoQ000OEk3ZWI4QXZoTjZubkgreW1ENHo4MEJu?=
 =?utf-8?B?amdaU0Q0ZXpjRkhpUmNKYlJxbkwzZzFheE4xeFFlazJKSHcrYWVtQnJPdjNi?=
 =?utf-8?B?Y3dLYXZwaXhLYkNIQWlSb0R2TnhNSmhXTW01UFh2SFR6eEdOL2VnL2EvdDIw?=
 =?utf-8?B?TW1yejBBWUxqaDZScU9NeG9jT3JoSHI5eEY2OGZCeVRkL1dLdnhta3I4amtV?=
 =?utf-8?B?VXZTK3dUbkdEc3lUWmlLNHQ5b2xVOStZQTJhNkg1UW80VVlIMm1YcGx1Tldp?=
 =?utf-8?B?YmlhT1NTQTlva05RbkVKeGRQZU1RdjRjWVNqWkxoWkdEcUNCNkNFK1RVT2VG?=
 =?utf-8?B?STZxRy8xUWlTMWQ1OVZnclhld3RLQTlMNGlId1ZYNjMyQzlOcTN6WXVwaEsy?=
 =?utf-8?B?bFNyUVdNdGkzWlY2TU9wZzRvNGRWeFYxTU1RZkRlOGdzb0Nodzg2c2lUYUNX?=
 =?utf-8?B?bzFwd1FidzBNSkRXZkNGeDBnellUUlVSQ3psdlpiT282bHlva25lM0FaQTZN?=
 =?utf-8?B?aXgrTk1EcmpLY0J6TUtrdGFYcGtKaDNrcEdGSk5GT2txUTRUQURFVWlldVpk?=
 =?utf-8?B?UnhjeDM4d2o2aCtjem5Sak9YcmNlTVkxa1RCLy9OMnBBWEo0aTYxSzJvR0E4?=
 =?utf-8?B?V2w1K1I2cnFoTGFyZmtoZFJCa0t3UHJRdUtpM3FuUjdiOHo2ZEJZWllzbzlM?=
 =?utf-8?B?ZUNGZlNzS3gwenBEWWNPcitXcm5YUU9UWVlJZER3TDExaytoYThOY2t2RmV0?=
 =?utf-8?Q?RAJnU7nXxzL9l2hBgkEFpFk0dnWggqlZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBrWTFmcHN5MllGTHBvTUxkU0ZQTjZsV0JuYU1xNnVXcm1yK1hCRWlOamk4?=
 =?utf-8?B?SzRZcnlHQ21LWXFxNmR1bTVzUDVOMUc1OWo3N3RDS2Y3c3UvYzRVYW9yc3JT?=
 =?utf-8?B?azAxRnRPQlVWc0s1bHNwOEp2eFB5RndUbTRReXNIRnFha1h2dmlKWG5aaDY5?=
 =?utf-8?B?Z01qOXRjZHBqaFFBNUxZWVdEOVJ3cUhRYVRYdWZ1RGsvT0ZzQlBObXNwYVNz?=
 =?utf-8?B?TzV6UDZqYVJ4TjNyZnhYSkRkR2U4eDhnUXNkajUrb2lpQlZaR2FSM012d1JF?=
 =?utf-8?B?bVk3QTlOY0x0QVlLTU5kVFJ1U0FQZWFKNmRMTDF4dU0vTm9HY1FQb1k3MTdJ?=
 =?utf-8?B?dEg2Y01TbXpGd3o2MHZ1SUdja0YzeFFmZ2QyUUdzLzZrdWltclIrODdhellm?=
 =?utf-8?B?VXU4eVVjb3EvcHV1VHJXcDRmdThLVndWQXVUK2Fld0wyL3VMWEwzOVNEKzZP?=
 =?utf-8?B?Q0k3dnZ2MWZTdzdxSXhXSm13Mk5XcVBseDRKQlpMTk5sVXZ4VkFBYnNzYll0?=
 =?utf-8?B?aFBEanM1My9VOUZvREFBdXVyaDFVZC9iNTQ4NFdTTXhtM1RrcmtYZ29yTTMw?=
 =?utf-8?B?L0JacEhjUy9xcFVHMTFqT0dwd3lFaWF3TUhLQlFid0tMekc4TFRDTWcvWGNh?=
 =?utf-8?B?ZVE2SHYyWktadUJ2YVY0TWU2eXhmV3VSVWVONlRJN0krR1M3VklpU1BUWmc2?=
 =?utf-8?B?YVlWcFRjcVhZSm5Pczd1TXBaWGhoQnU2ZFBybnRpa3RxZ0lRc1RzYUdCVG1m?=
 =?utf-8?B?QXI0SVl5c1RsNFBOekh6M2UxTE9hNm1EOGphV0pQMTJ0cy9xWVRmbE5PWm5Q?=
 =?utf-8?B?SGNFSXJ5c2ZKVUVpQ04zMW1yTzBibXc5Ui80Zk83eHV3NWZ1YWpsRStNVlVW?=
 =?utf-8?B?VlpLUno0YWszQlI0R2hIRkl2UTl2TThGaFVTc0VWVWFqUE9MY01PNmhxbGd5?=
 =?utf-8?B?ZjZQc1htbUlqeExsSzF4ZFBYNnBjTWxCeUJDOFZPU0QrdEwreGE1MVlTd0dW?=
 =?utf-8?B?M3BwcFRWTFZqaThXaHhDalliVHVPU1dUUW8rSWE1dnFweW9nc3NLU1Y5MTgz?=
 =?utf-8?B?VGtEVk5WVXBEc3cvK2lHZWU3andSVGYxcVU1UWZoMjlNMktDWFFHOVRwcitZ?=
 =?utf-8?B?Ry9ZQ1VCNDZRNWIzSjlRdzBaaW1JOERMZTEyVmlaNlpERUpPRnNmVzAvRnJH?=
 =?utf-8?B?ZTRIZHh1QVByTy92SGhsYkpvSm9FM09idktuZVg2Yk9pRW1WejludG5pY3RB?=
 =?utf-8?B?YnIvMWtpZ0tLWklXVFIwSmRkTjFuSDEzVW9IeXZrVHFNSjhMdUExY0FtSTF4?=
 =?utf-8?B?d3o3WFJvU1AzZUZIOWVGandwbUFHbklvVDRrQ0prb0xiYTlXNE44dDBySUFH?=
 =?utf-8?B?eU5NWG53VkVoYVBrL2FkMkZsOE52aisyblRRNHpKZzAvdE1KQmpaQzlzNi90?=
 =?utf-8?B?ODFpVFhqUGdLaXVQYnc3dlo4YlBaRE5NVUtyb2lMZFpTdCtRV0wwbmxsdDJZ?=
 =?utf-8?B?MzhvN3FPbUlLRllLYjVnejhKc1pJZ0JVTUZGVXF1NGlKTVZ0dVVDaDF2NS9h?=
 =?utf-8?B?dnU0Si9kMEZYeUlLVU14MU1nanN6endxckowb0NKUGNnV3J6NWduZEJTRW13?=
 =?utf-8?B?Wkd0UXF3Y2F1ZWFjbnZSS2tVTTBnQWtqSzRiNkhERG5sZFNlOUVFV2ZSU21Z?=
 =?utf-8?B?ZXFTZHZDZ3U0MXlXVi9RVUhhUFRDTkNaNGVkVng4QzNOb3JRTlRHbDFWcS85?=
 =?utf-8?B?ekluRFZyd1owY2RDb1phQ2k4RXJQWUZLMU9pbDNJNUdjb3RPb3V0aFBnVFcw?=
 =?utf-8?B?VmQyQUVBSUFnR3N6blFmOXowNDJXQmgvNlA1dWFkY05CWWw3M0lOUW40L3Qr?=
 =?utf-8?B?NVhjV1EwVjN1cTZFb3UvbmRHcmliemRiN3VKbjk2YVY4VTg3OHFEUzFqcmk4?=
 =?utf-8?B?RkhsN3RmRlFPS1o1eVplSTlRaGlRNnNQZXRtdlliZC9mM1RBZ3ZyMzJnSVdo?=
 =?utf-8?B?QXVvMkR3L25NUDFlT1JQaVVidXZmTkY2aEZPampVK3RpajZzSHNxSll3WFFH?=
 =?utf-8?B?TVdsMzUwbG8yYVZtNzkvQnA5dnA5RXlNdE1ENkNnMExnMnpodGtVMURFekxX?=
 =?utf-8?Q?Mlbs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902ac314-3485-4d46-29ee-08de1722f4ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:40:04.0025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b65wTckobiR/t8tUzkAv6807AuND8zl/I1Kzynq53Uwx6BTtL8FIPIrH5KAtfGmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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


On 2025-10-28 21:31, Harish Kasiviswanathan wrote:
> Fix the following corner case:-
>   Consider a 2M huge page SVM allocation, followed by prefetch call for
> the first 4K page. The whole range is initially mapped with single PTE.
> After the prefetch, this range gets split to first page + rest of the
> pages. Currently, the first page mapping is not updated on MI300A (APU)
> since page hasn't migrated. However, after range split PTE mapping it not
> valid.
>
> Fix this by forcing page table update for the whole range when prefetch
> is called.  Calling prefetch on APU doesn't improve performance. If all
> it deteriotes. However, functionality has to be supported.
>
> Suggested-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c30dfb8ec236..d3d4f0d01653 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   {
>   	uint32_t i;
>   	int gpuidx;
> +	struct kfd_node *node;
>   
>   	for (i = 0; i < nattr; i++) {
>   		switch (attrs[i].type) {
>   		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>   			prange->preferred_loc = attrs[i].value;
> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
> +			if (node && node->adev->flags & AMD_IS_APU && !p->xnack_enabled)

Maybe check adev->apu_prefer_gtt, seems specific for MI300A? adev->flags 
& AMD_IS_APU includes MI300A and system with caved out VRAM, on which 
prefetch will trigger migration.

Regards,

Philip

> +				*update_mapping = true;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>   			prange->prefetch_loc = attrs[i].value;
> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
> +			if (node && node->adev->flags & AMD_IS_APU && !p->xnack_enabled)
> +				*update_mapping = true;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
