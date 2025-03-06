Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F264C282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 00:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1995D10E796;
	Thu,  6 Mar 2025 00:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vMddlB9W";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FB210E796
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 00:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ4U9DXQP/zvNnzmCLqGLtqk59PjbQNKgyS9bKkZJL0Hf5bMVQBwsu9vhgyIXD1feyGroe8VIZeu74OIqhu/ZutR97JVwMQVwcj6IfrRt/X17I8ZsgTN03uJv5ksdSDbY3APWtE35CKl1ZoZ1nRzltbAn+nawBFVB6Yb09VRSS8rMLepRtvpuWziyrjvbF71ubUbalu8fMJt/8I530oHTqHrd8akQzlRiWFIcB7G4LV/hNv07ep6cFLX2FPNv7odq7wJSsMVkFD2QGC3qAWBD/e+DU2JsHVbIUNuB7t2qgVZig7gWUh8axXY0QnneVV6z3w6OoDMBvead6D0brb2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tya4JrWlk5fdlrbXpcArbGB4a95AWx79rJFMdo+zPhY=;
 b=Lr/ee0C2KAornRpMkYE5lfHysL8zW5pu0LD90UnX3g0X5c1j17lgUonGrxGPCD7ArhBsCV5MAoQk7Cxb6rf9z2dzswJ9OVzjneKtUrpdli08F9ae0z2glGIXxxnW/Hs1sPXySNwAFLYyGNvWs7uqHMSyFoa93QhrJgp1R5fTLPCoYkx0CYE2rwmxENlYmt8UWgLJoUiB9wkZXSjoCUtOrjTEiVzdXxYJZ/ENh9s4uBGFVSDjgMK4J9F4ApUeeX5J9+YKXohYOOAUlzePaQ9kLN2xsDGwzKtCywV6LbK7snEr/+cga63GC2mEcicLjsbP65Lt1p+m1QgW1Gh9YD7VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tya4JrWlk5fdlrbXpcArbGB4a95AWx79rJFMdo+zPhY=;
 b=vMddlB9W/adovNt6ukg2b3Dp8LRY67OaFCpUdK1fjpgucYvzr/mwGo684rYj4ZOyzmI63pwLIrNb+SjWWE8CUsSqdhLVLj1tTao+zvcWwBR8ny7jjJQ+3vmzLYT7eViPNJybkIpZF8I8H5HgCBEmlSLtW0UO27emu0+oroi9AR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 00:23:10 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:23:10 +0000
Message-ID: <34d25887-a5ec-477e-ab4d-602458472042@amd.com>
Date: Wed, 5 Mar 2025 19:23:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Cc: haijun.chang@amd.com, Horace.Chen@amd.com, zhenguo.yin@amd.com
References: <20250305054215.566473-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250305054215.566473-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 03837a75-7151-4927-e42e-08dd5c451318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djRzRk03ZmN2YXlMYjNkVFFRZ2RzVDFkVFgzdXdNTkExdWVxa1ArNDU1bnQ0?=
 =?utf-8?B?N2dEa004TkQ5a25XbnZVcW4vc2dBTHRrcEh1cUMxblZQSEN6MXN2TitiVTh4?=
 =?utf-8?B?R3p5Yks4UXFuYk5UVjdGam1SRm1DOHRSbC9PaUpVMll4VzNkOGs2QmZIQXJN?=
 =?utf-8?B?bkdNYjh3TENEeG1EY0Z1R0s1STZOUzJKaFpmMmRYQ2xzL0xzQVgvMDVXYnYy?=
 =?utf-8?B?RTk2SHJxNWFnTjFYdFBJWmtPSExmMDE3dVZqSTVrTTBnL1JSMlN6V1pEQitS?=
 =?utf-8?B?MnIxaVNYWHhQaGRobTNadlhHRm5uVjVQd0ZibW0wcGZKVGxwVThtcm10Zkt4?=
 =?utf-8?B?NnF5bjE3VTdIYWY5YXV4NkhVVUE5ZUtjbFlaMmprYWhCcTRPcU03eHA5Uklj?=
 =?utf-8?B?VkNpSzRmTVhGNWVnTzNXRG5PUHk3UDFsZzB1L0UyeFFjazJ2ekdyTVkxb09p?=
 =?utf-8?B?MXZwRTZodklFUHU4Z0tqY2NleVF0TWlVcjY5TjJlblM4ekJzRFYxSFdnQy8v?=
 =?utf-8?B?cURLSEhvdXJQaFkzUk16T3ZIb2o1amZ3SmNXNllJWDlDWmJ2aGNQQ296V2E4?=
 =?utf-8?B?Z3BPSHdrNEJGbWVHMks5akdWemNiak53NlhBdGd3ZnpuVjJZZXFHdXZnVkJO?=
 =?utf-8?B?eWN1MVZZNUU1N1lSR0g3c2FCQnAwUE1pMnZ6Tk1tcDRwUkpLNiszWjhTL2ND?=
 =?utf-8?B?S3l5eFJFNnFEaFRYTGdHR1k1Ly9FaEhjYzVCUUhKWndBSzNqeVN5eHBUeW1t?=
 =?utf-8?B?Z0s3SXFLWEl0QkpCZW41WitGZ1AvbG9RZVpLMlhxemVXeDMrNW1FRUNwUVBq?=
 =?utf-8?B?azRNTGNpdm91QnhkemJ2S1F6ZWxTSmlkSXhsL2NTMzQ5WDdHdms2aVFaL0VU?=
 =?utf-8?B?S0NidDVFNjludUlGL3BjVVlYNkN4WXp6a3lIOVFRNi9wUXNNWkhyZ29sSWI0?=
 =?utf-8?B?aEdmUUwwTDgrc2cyVkFXcEJqdTM4Y1ZCRWUrcG9YZG1CYThpVUcwa3I0N0Ux?=
 =?utf-8?B?enV3WldiVVV4YmZDOU4wRGwyK0FrRWl1VTdlOVBKM2IraXQ2NWpRajVDNDZI?=
 =?utf-8?B?RDd2NmpCT2tBWFU2S09yT1V5bVJlYVI4dllQYzMzUCtWTWpJWVR3cGNpelE5?=
 =?utf-8?B?aWh5SkJ3VkZGaHVvT0xWV05sdUJTb2Q2WVhSd3dLemp5NUt0eUN6ZXZyZ2wy?=
 =?utf-8?B?b1VVM2JrdVZsa0hKcHg4ZUQ1OWpIVk5KRW9YTDE0TEszUkRDa0wwSSt6ZVhK?=
 =?utf-8?B?Tm85N2V3aWIwTTg5V3ZwUXRVdkhmVUZWc3FGUDViZ1U1cFY3T3pOMWU4TXhO?=
 =?utf-8?B?RDNNYnBiTGFwMkRSWGJ1OU9ZMXlSSlRnYW9zNndGVkp6RXhUM3dZNUtBWjZj?=
 =?utf-8?B?T25GbVJIUjBCTmVpeVFDMjBVVDhUbmtrQjFtbE1FS3NXYWwzd2l2dit1TjBn?=
 =?utf-8?B?VS9CT2Q5QmhhNVdjZzhBSEpFNnJxcCs1R1d5Z3NMUFRMVTRtUEFSQUJMRTBh?=
 =?utf-8?B?Q0R5V2R6VnQvUzBnZ1BvT3RoWDBWOTNzVXlGMCtUVW1oaUUvVDRiTU1mUmFo?=
 =?utf-8?B?QUNTdzFlUWJxY2JvZk1lQk96alI1MlpMSFl6TExseWV3R2doalNzVC9PYlg5?=
 =?utf-8?B?bVhrdE9vNDA2OWh0aFdLSzdYSTIxeGdyVHdjcnY2a2N6V3N5dzRRQ1BHZ2xX?=
 =?utf-8?B?K01pOGhBb3JnclJqWFNDM0JkdXhWN0h6NzE2VmNPWWFLenZrcDZLaDRhd1R2?=
 =?utf-8?B?Z0U4TzRyci9TWWNob0E4QW54SmhZQmhMMDE5WjFuQ3NvNy81bDh3cEpmTHYz?=
 =?utf-8?B?cEhRWVZCemRJWkcraktTTE9OUEQ4QTN4OXBZajlXS1pUMlErQUFuaEszQ3Jn?=
 =?utf-8?Q?kEeH9gWebQwQh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNrNTlvTjZYaGtjWFVHbytLa29pZElZeXdOcmRjNWE2RHU2OHFRaVFaUS9k?=
 =?utf-8?B?bkRPVmIwZjVkU0NpTjVMa040RmxjMXRjTHZpYXRqZWxtKzJnOVBhc2pwTWoy?=
 =?utf-8?B?YmozL1psUXAxWmRKVWlOOXRiOURuWTVMa0toRFhXYnVJUXhWdzMxZFk0dStC?=
 =?utf-8?B?R2RMUXZYaFkzMkhKZE9QQU1kcHpsWXVFRHBVWTJ1c2ttZm5WM2h5SkhLMmNy?=
 =?utf-8?B?QW16VDY0QnpVKzhZMlh5NjMzZlN5cklnZ3dqOW5FTzR5NnJoUWI4ZU5UWm0x?=
 =?utf-8?B?VE1aRit0ZUxudjk5VnhicytmV2RWenlzUk5yemQvaUtNQjZZaFM1cFJ4ME9x?=
 =?utf-8?B?K094Y1dJampFd3hieGVwRXhZN3ZvUGtUaEt0VmUxYmJQeHNTU2NmVGg1R2NY?=
 =?utf-8?B?YjFwZDZRZFFwSy9yeHlIaW1PVjc1U2Z1YkJJdmdIRUFmZnJxMGNoc1JEMGtI?=
 =?utf-8?B?NkRQZWx2MWRKbEdCQ3EzQUJPYnBtUWFoZ3BucitLK2lZYnNHemh6bUMrQ29z?=
 =?utf-8?B?b0ZSWUlOdXRud2lXNHRucU5TYmMraUg0NUJrOVVXQjgvOHcxREN5T1JyT2FY?=
 =?utf-8?B?dVRYaEhBY1d2Zlh5NWhQeU42TnlZVmsxdzZ3M0dwdkN1RFlQVVdTZ29IOU5N?=
 =?utf-8?B?R29jSHcvWEpaVEFJVjhpVlJOS3hRdzc5ZzVkcytSWjhZeTFyaVBSbnVVK2Yx?=
 =?utf-8?B?RDFXdE0vNkV5d2dIODI2NGx5Vnd0d2pJQSthZ3FKUUluNGEvRHVEeWk3T2dD?=
 =?utf-8?B?MWhxVjBsUmdJWjFOY005RmJHVDd0V3pJanhWNncvMkg0N0kzcFhiS29ZcDNI?=
 =?utf-8?B?Q2RKZ1dnMUY4ZHptQUl1MjBwRzZzUGNBd2ZqL0x2U3ZCbVdrQjVpMDlvYkFF?=
 =?utf-8?B?VlBjY2xKek4yNkYvTzhTUjFrTGNweWUzQnkvTFNSaG9xeCtRY2sxOG51SkFD?=
 =?utf-8?B?RGN2RWR5UFk0bmllUlJDY05xYmFHajlCNXc0ZnVJeFF2ZXBvd1RQaXgwdDdJ?=
 =?utf-8?B?aHlINVQvWDEwaVFraGxyMUZaZGJIcWxPYUhFN3FMakdyazFrUGk3c0ZyV3ZP?=
 =?utf-8?B?bkFJNVpueWpsZDlubEZiWXVVenYvRXNiSjFkbU1VM0xObDN5bGJGR1ZzajZp?=
 =?utf-8?B?d1BSVmdnY2hqMEJ3a0gybDlKbnVObnhYekFBRnAwRk82QmlEaWNhWVdSN0xa?=
 =?utf-8?B?a2lmNjdidlI0ajRNUUtKRE9lYU9TUmlQVEUxdW1VbG1GV0QyR2czaFhQblhD?=
 =?utf-8?B?TUNkbzFra2lRZkRwc2N1cmFwUW15SFFUWXRIS0p6R1ZRUm1la0dRRTJjRGxK?=
 =?utf-8?B?c1hObGhMc2tsWnJvVE9TZHFjRTI5VVdpQUtoakVab0V4SDRIblZFdGluYUVr?=
 =?utf-8?B?UmJ1eFVOQWp5WjNieDZtNVdOcTNQdWViWm1RZGVzU2FaaURjei9BR0FlNXg2?=
 =?utf-8?B?ZFFVelNseGRvYS84S2xnaUNsd3I0bXhvL3UwNEU0dDRzY1BseGhxNUdTSmhJ?=
 =?utf-8?B?Ti9tUm9wYnVZSFJiTUxyeWNNd1pIV2ptckl0bVZLUXkyTUsxODJFT0U0aW1I?=
 =?utf-8?B?ejFiaHltM0NlRWMvZ2NTeW1KcnNEM2RPTm9nSkRrWVo1VlhDT281aEcxMUFk?=
 =?utf-8?B?NkZNcDRzRThmdlFIWjlIeXhnSUVTdUpRa3hEVlBabURiS2tmMTEwSzI1NXY0?=
 =?utf-8?B?dWZWQ1hZVWhBZjR6NnJ1U0RnWTU0UE5JWk9NUkM0NkZTZnV0bm9RWUh0RVBv?=
 =?utf-8?B?ZzMwbkhpWE1XS05NUzgxNVpkeC9kMXFMWHhUV0M0WWVXNi9QYnNtem1FbXJj?=
 =?utf-8?B?WXU0S1J4YU5VYjRwMVU2a0h2TDh3OEJnMXp0SlZzMWh6VXpwTkZFN0RwdVhm?=
 =?utf-8?B?UjVuT0toN2RNYUVaYlZxVWIvdVM4NEE5YVJIYmpuZTdmbnJVYU1UMU9jWEFS?=
 =?utf-8?B?WHZ3Z0VmZ2t6dHN4Q2lGMkhxelQrMVlVQ0NuUkF3Rk1Vd081V0pFV0tPUTcw?=
 =?utf-8?B?UkR2ZFRHR1YyS0pva3E5Y2ZuTXMxcktIektBSlRjYnZYSnM0Uk9kYm5PaklD?=
 =?utf-8?B?ZjNlZnQ0MExJblIvNEtna2kwMUhpYnRuejhtUnhhOW9QWWpzTzcvTWdoN1VI?=
 =?utf-8?Q?75JgxoV0oSrxOIJxyPsfFj+VT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03837a75-7151-4927-e42e-08dd5c451318
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:23:10.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8AZMXpcbc/Z8l4YA1ER7CMoMXfCHHKH8nI6XzjDsP/0M7kK5DYhqLhnrIcWAgdvZYaTKZNkiASp2T6E//uwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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


On 2025-03-05 00:42, Yifan Zha wrote:
> [Why]
> If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
> Then remaining queues are not evicted and in active state.
>
> After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
> So remove queue will be failed again.
>
> [How]
> Keep removing all queues even if HWS returns failed.
> It will not affect cpsch as it checks reset_domain->sem.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f3f2fd6ee65c..b213a845bd5b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1223,7 +1223,6 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   			if (retval) {
>   				dev_err(dev, "Failed to evict queue %d\n",
>   					q->properties.queue_id);
> -				goto out;

Is every subsequent call to remove_queue_mes guaranteed to also return 
an error? If not, you need a way to make sure an error is returned if 
any queue failed to be removed even if the last queue succeeded.

Regards,
   Felix


>   			}
>   		}
>   	}
