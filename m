Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9EF01807
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C28210E3A1;
	Fri,  6 Mar 2026 08:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTDWXei9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D6910E3A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 08:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGEphEXGtyXBRLhi1CmnJ4EOdS60AKteuoaRaBvnLo5aMC/8j7LvSU8z8ePbX74sMPkWGAFaQWXOdY3C3YQzYtsJBptm2P6wO6aVIfp2bmXP9XrhGJQ7kE5AOWsov2cbNuHpbcn9DiRgO43efoE4SDXCLMiRu2Ax2QnZb6VsAVMYLebel67x5oDA1aHx9GW33thqOzs8c/CEURB4oeBc2MZWOHxUPVEO3aD5eCkzhWP+hKSlHg1T3/3xvl04VfAVpyhM4+6WPp8bOhKyv9FWi/57VbMX5CAdaHqO5bIfdqRT6UbK83+xKFbtHwrWxDHS65JKsDjoYrwCb3oDf2uf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgK7BYIPhpV47MvWZ2py5Rs2MGyF9oIT9h6HaaDktGU=;
 b=XY6G1IOHdJy+MSoj2YKv87tmg2UXRLrD5d39vD+29Tds6E2TAeKgVXlwFgQG0dkwet8cKzeiApV6EDXIH1lrtXWGIHwhckwhTR/lh4UPuMGyQskOYUzj+RuQLt+4qK76o7QFSJx6RjFPOeB9h8gz3+WEvNHS3U4Hp25nzdYstN8WlsamJB5qAQr+OLxreS848X5lziOTFgt6uqd5n3uG3u1Jcg9OKy8A5Tuj1v5uZqXaPtzIlRKJt6xmnyyH1dLe8u+K+ri1GBO0u21wOMf3JUJLjGZqsmTaz+SnmaQazqhs9UK5pYVHPGaL0TppZp2LF0NxqSjGT01jvMZ2YqYXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgK7BYIPhpV47MvWZ2py5Rs2MGyF9oIT9h6HaaDktGU=;
 b=gTDWXei9AhIudFtNO1IC7zjx7z9H7Dpg3WiaPw06xXH7EpudJuNiIm5x0E8NNMD7lXnJYl9NPhRFMp8T6zLdwYC2Nqy6Y4YI4c26BhY8NIZ7qhT2wAyayuT6W1t8tKjdJzCUlv05XQ8iueb8Owjby0daeP6MPeIG6QT3gWNx83M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 08:10:31 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 08:10:31 +0000
Message-ID: <e4207e46-adc4-4b35-b9c3-24d07d976fda@amd.com>
Date: Fri, 6 Mar 2026 13:40:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdkd: fix the warning for potential insecure
 string
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <philip.yang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260306080636.1810291-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260306080636.1810291-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf89739-abee-48b7-a5bf-08de7b57d56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: /pnTc4o35p5R8b3dSubscClADn0ImfCGmlOMlphi1Nl7WcDk4FSMomi6cV0j4cnxfEk+8oBHRNpqh4Xe/DJcaFsxD7WleAlHHqH+DUVANDEtcyoJzBGzhHgrzk8gO0kd0LE0vfPBrXmdGoTo12z3CUGFTxqE8X383jT3nskn2ET0RXTi2snWUpb5jnW7vJnLXjBLkZc1FueVyEekOMkZpzf8/z7/cPmy6Mm0ykxIneiF3s8rGNmRqKpM+aeMFLyug74r0Jy7shVRqGedNi3F41bM9qtUgcazeI3AhWHANtK1MBA/hZYh47u/w50Pk+oB9nYxIe+r40gwDjFhNg56wTJYydvSuTmfgSbXnJ218DmwyhSPdim21qDlpFN4ln/947oeI5p7VXCYIXzunK0+SQMuVtvN+a7rBnDto88tKKIwlUiDrd4i60Ar6Bc4x09ywkCBcwJC4hxPJB1Bf+XhOJQ8R3lmgZ56tA2YxUP5CGFHw8lG4vNAK+Emd8ZMs6dNr4a1esC+GTwTlswwfLU1vrkU9Zhen8BcO07Qn9xI3/Ayd0uAh9+Py2XGnF25OB8WzxrRpYV/Ci7jZ/NJqS6BYWvCbmntKCN7sOIMRLz9vrJHO+Tn4c3FLjeUO3IQBQYxGXH50PLZ/7ONUqmj8q42RrrFpVJxYO37diCMCLLbltYkM6+r4QAl2+q3FrgUSb1f9xUSxBY2aOHLik6nFK4kQ/Z5mjDZkZ7XcDbi/sHSEjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxsRVlDaTFGL3E1bU9vUnllczYvSlVSZkNIeW83dWNVRXUyaXJYREpJZHdw?=
 =?utf-8?B?STNxVzZOUjZxZEdOWWY1Tk85WWRUMVl3R0dxL0paNVpBemlKWm9Gcit5a2cv?=
 =?utf-8?B?Z1lxSlErd21tcGlPUVFIMEZrSlcranpwMXhocU5NeVZiNTlUSHNBUnlnRmNu?=
 =?utf-8?B?VGpOVmtQYTRxajIyT1VlWHN4WTR6VEpGSkV5T1BTUWcwNHpBZjdNWVg1SlVM?=
 =?utf-8?B?TURMeThrS3BKNHJkd0RFcERaRlBkU1IzZnlJU1BhaGVnbk04Z0xXTWdtTTZW?=
 =?utf-8?B?ZVZPV0Zxdk1wVFBnU1AzTWo2b1BQWmIxMVExV2xwdXB4YU8zODZUdm8yL0hN?=
 =?utf-8?B?dlRSUDhxVnc3TGplL2Q4d200RHNKS2dyY0E3OXVqMGxCNTJaQmJ3VXE3alkv?=
 =?utf-8?B?d3draGo0emkxNSsxdXVoaEkzbGo4QStBWm5xaEsxem5pOHdzTGhDUXF1QUZK?=
 =?utf-8?B?NmZ3Y0VmK0J2MWdCN2UrbnZ4a0c2cGxDN1E3ZU9RWmMrL0g4NitIdUt3Um82?=
 =?utf-8?B?OUZQamxTQ1lsbWV3MEh3eVVJOU0zb3orU0pIQ1RySjdVYnBBQ2dreDF3bTBY?=
 =?utf-8?B?eWZ1cTRwa2ROWFRqWFErVUY2S3p0aXJXU0doUVV3emQyYjhLNTFIcUhwY0tM?=
 =?utf-8?B?bEIxTEFwS29TdERBWjBXQ0wyRjFzald1ZUtuTSswYlVLY25wK0h1dUVxK0Np?=
 =?utf-8?B?RnlFc2phaFZEM0NndG1XWEV3bW80SHpJK0VXZXBoSDhTN25OazJhd3orckRj?=
 =?utf-8?B?M3hWTzl2bC8xQkZnV1h3ZGRYbDR1U0FORzJ6UnRtQlNTNm1Zdm1zVFRZOW0r?=
 =?utf-8?B?UjVjdFdqOUNxWjl1NWJ4WDNDZGk3NE9YMTRiV2tCdU1CbEhCV2cwd2laRXJi?=
 =?utf-8?B?U3hidUN2b3F4U0FyeE1nOEJjSkZaMEJHZ041RCsyTEpwcFFkaG1EaE16TWRq?=
 =?utf-8?B?dVJEMm1WUEpkYUx3ZG5BcmhTVGJ4QTlRV3F0VGxyb0J6R1YxTGc0Sll5MVB6?=
 =?utf-8?B?WWNaWGZxRE9zdmRhZFNXWHI1bjhXNzlJcHpsVGxCbVduODgxbFo2bnpxNzlz?=
 =?utf-8?B?SnIyUS9kQU43ZHV0ZFlYU0Z2dFNVdG04V1ZLTmVoakZjTXNSSmJXOGtlTnRm?=
 =?utf-8?B?K3dBRm5TWTRvM2o2Tjl2clVpS0hmTmkwNUFJNkpDQW1YMGUzMk9sekhoVWU1?=
 =?utf-8?B?UlNGMzBwOWhZZEUxdjNqMG4raXJORXRNaFM4ckl6cU1laW5wTUxjYU1TaXFE?=
 =?utf-8?B?b2dOdHI2WWZmRUFiemFLaWtmcEpMRThRY0t6a1g5OXduUUVrWUNQOWJwMUQx?=
 =?utf-8?B?Y2JvR2NYM3pPYWxIYkJXT2JsSTZWQ2psZFpXY3V4ZFVjcUdtakRxVFk5TlB4?=
 =?utf-8?B?VWZEKzFSakxtN0NhamlzdFU1S3daYXpzL2tRVy9JamEwRVhaTG5tMnlkVEdI?=
 =?utf-8?B?UTZ2SXdwdDlRc0l5R0hJWU5IMzR0a0p2YkxXMEVDZG1zVzR1WlpPSm93dklF?=
 =?utf-8?B?R29qTThodzQrTTR3SjJFeHJKSzU4QjZDSUxoaFlhVVh4RjlJSDJPcWd2amxY?=
 =?utf-8?B?cnQvM0Y3VXR1eDc2VVhMNDVHczkzZFBWYVZ1Q3hNZnllZFM2M2QweHFRR1A5?=
 =?utf-8?B?TGFUT2xpL0xVd2I0Z3Q3RkF4ckpvTytscE1JMEh6cHBUbUpMQ1ZIcTRQQTEx?=
 =?utf-8?B?K1ZYQjlhRm1qQlMxMUJxVEhXZXN1L2QyQjlIUjZCd1dNS0lIRDhwQ2ZGR0NM?=
 =?utf-8?B?NVQ3TXhjS0c0WCtvVDVRcDBsUEhNaDB0TFVvYVl6bEpVY1Vxc05NdkMvb3I5?=
 =?utf-8?B?R2hqM3ExOElac0hTK1Fkc2l3b2FsYlcyaVZ6ZCtFZUpYakcxeHZqUW9mclg0?=
 =?utf-8?B?ZkdBNE4zdHZFYUVKNWtORGM3L1lRbUJlNUhUekt0aHU3SWRnaUsxc3VmVjRl?=
 =?utf-8?B?MHppRHR1NEMwZFN0a1A2eHlsWWwxTEdFbnBPK2lzRUJjd0xQbi92SWFLMzkw?=
 =?utf-8?B?dFFZSHBjdXVwbkdiM0Q2bGlQc0Z5Zi9ibU9hVlVZK1YzQUZDZytpYm0wYVZX?=
 =?utf-8?B?Umc2L2JRRnVWUUtVUzh1VDhQLzNuS1dMREFiNmZXTnVyUWlsYjBtZS92Z1hH?=
 =?utf-8?B?bEZEdDJLTFB5Qkc5Z0d0TFJNdlRTMUZMckZ6UTM2V053Z1ZHVUU2dlBCdkFF?=
 =?utf-8?B?T0l5RnRJOUUxQWxFNjlYdGtWcEJNZFNEME9iQVYwd0piaEY5YWVreEFLUVRC?=
 =?utf-8?B?SDV6SVZhdlpsditQZTl3M3k5OS9CV014b3JVbUNpcVk5QkRPRmhmOXVJK1ls?=
 =?utf-8?B?Qzk2WTN3K3JEV29qeTBHVWxEK0FkNjZVKzh3bm8xSk5QcHRoV0NWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf89739-abee-48b7-a5bf-08de7b57d56b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:10:30.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj/uhAhyccUMDLrG1FLyqDfj4kk3Yq1FyiAV1sGvAdPSqxTmDyuTEyXX0ZI/1YjO55EQ53DVvP/n1r1M+VoH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

Sending again since patch 2 did not get delivered some how...

On 06-03-2026 01:36 pm, Sunil Khatri wrote:
> Below is the warning thrown by the clang compiler:
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>                                             stats_dir_filename);
>                                             ^~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: note: treat the string as an argument to avoid this
>                                             stats_dir_filename);
>                                             ^
>                                             "%s",
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>                                             p->kobj, counters_dir_filename);
>                                                      ^~~~~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: note: treat the string as an argument to avoid this
>                                             p->kobj, counters_dir_filename);
>                                                      ^
>                                                      "%s",
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> CC: Philip Yang <philip.yang@amd.com>
> CC: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0b3b0c26e05c..d202827df66e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -585,7 +585,7 @@ static void kfd_procfs_add_sysfs_stats(struct kfd_process *p)
>   		ret = kobject_init_and_add(pdd->kobj_stats,
>   					   &procfs_stats_type,
>   					   p->kobj,
> -					   stats_dir_filename);
> +					   "%s", stats_dir_filename);
>   
>   		if (ret) {
>   			pr_warn("Creating KFD proc/stats_%s folder failed",
> @@ -632,7 +632,7 @@ static void kfd_procfs_add_sysfs_counters(struct kfd_process *p)
>   			return;
>   
>   		ret = kobject_init_and_add(kobj_counters, &sysfs_counters_type,
> -					   p->kobj, counters_dir_filename);
> +					   p->kobj, "%s", counters_dir_filename);
>   		if (ret) {
>   			pr_warn("Creating KFD proc/%s folder failed",
>   				counters_dir_filename);
