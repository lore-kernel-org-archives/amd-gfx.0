Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02F5C27C65
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 15:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C21810E37E;
	Mon, 10 Jun 2024 15:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGYKrDmb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BD410E37E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 15:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XztaooNUnvs75tT3mKQMGzsJe1joFbcAPNoBNT0dpOAnOnhkme8LJK3oJHHwSN5nHbu30GBEmFNoI0YEEsLdJrkAqbqwUu2PIPrnVXjux+kN9tF2NCSA8aikaCNdtsUbJqqC50zfZgrZXdOOA77ZOukcL+uM9D4i7WzXgMMyp9NFhTxQprBBfHSc/t02lt4Nxyq8aGZgJgLv/0qeikgJQJYRKPcj1cXayds1/IohwN7XFK93NgQ7KI6NWDu+5wdajaCxgLy4M8R0xHTZx7DfI+ASgzU2nAG4GGOpTDCbVO2PhxXbBTmcVNWG1tfCB8nVKr7Cx80AhfgF/4iocvFAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HassLtvn8eRR/UaLzHJhSaeWT9W/9r0HyJcgQ+YvlFs=;
 b=H83XEBIQZSc9QgJsQjFGk7Dejt0NjRzgVLfvSfXj3UEh509Eg6MSGvdzJLzGHQKTDGykIvfbHiHHCTyUb6IGQHEjo+xF3Fjtg/y9eGTEmtDkXOlyigpA6vZiUTJ0EsvAcv3CIQDKxtpyQMx8V0HXKBz7YmgggWDwN66eq2wnoEUB1RmDD4qxc48ORlqtaElpMhjbpw88iGGs8xiFIGiyvaFAsSnXU3L8LDNqzcIV8k0vXDJU2tHAfP8hTkloapboZGSzdo68R2IT6NMRn0aHKlysBVJhf5X/cqsZZVlwASZIL6Gy95dvaCptV5aKrMYfcq8WZHkjRFUkQs2EBuZkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HassLtvn8eRR/UaLzHJhSaeWT9W/9r0HyJcgQ+YvlFs=;
 b=EGYKrDmb0RzNAkXWhuZ7oDUcNJlt38KiFbWYBj3srBQPFZLqu7lFuqXAshMZs2dZIKQ2EHrgUyk7IPdAUUPrZ5fu2FlNjEG13B755i8OxmT88PT/fPjqL8yZICrUzSJyKZ8PTWDLqTru+tH0jmtRhHnq3eiKTzGM56Xv+LRWMo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 15:32:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 15:32:10 +0000
Message-ID: <5268367a-3e90-4ad4-a3f0-079eb9634226@amd.com>
Date: Mon, 10 Jun 2024 10:32:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Guard ACPI calls with CONFIG_ACPI
To: sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 alexdeucher@gmail.com
References: <20240610145559.66546-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240610145559.66546-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:5:40::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c25bce5-a657-4117-d291-08dc89627e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkdkM1F2Sy9IeE45REFNeVNCMHBQRnJRNGdIKzRXSVJrRU9VK2dYWU02R00x?=
 =?utf-8?B?cGxERjBsdE00ZXhXQmh2VXJUcjhBQnJPNk1HRnV6d2luNDZ5SWxyZURnVGpy?=
 =?utf-8?B?dHFBeER2c0cvNkdEN1NSSDZZTDNGY3VnZlFnWTJ1b21qRDFqbWtaaVZCMUhR?=
 =?utf-8?B?c3VhTVBoYmVVV3pKTWI1bnJxZnNXWDV3ZlFRaXpTcGt3YVFEL1drcjBCaHVR?=
 =?utf-8?B?MG1pNWFpUUI1dE9zNGw5blNXS2ZEZmZqamEzUlliT0Jtdy9ucnJ4QWRFM0pM?=
 =?utf-8?B?aEJuSzVReXErSHgzZzNGckVvYUxxWk1FT1FscUFRb1diZnV3VHFOYytxMUth?=
 =?utf-8?B?OE9GK1lkTWhNbys5SDROR3lieFV2YzhVL05PQVg2MW9OZllrU1dDSTZaeVdj?=
 =?utf-8?B?cVdvMWFHYWFnSkV3alhNeCthRVBzRG9PU1Y0bGp6TjgxZjcyR3hsK1ppa3dj?=
 =?utf-8?B?NmN0U0NRSFJSSmQ5N3JseHJDcS8rVVFaOTREb2ZEVDIycWZSNHZraXhwQzJI?=
 =?utf-8?B?VnozcHFwbTBDaXZpdW9wM0ppN1hveExLMGJwd0RCNTNMZ3NZZGl6c0VGZm5N?=
 =?utf-8?B?WUxPbG5PMmI1akNtZlJUWDVVeDcrSGloUE1EK1R2MFJIWUVwRXczYkIrQWdy?=
 =?utf-8?B?ZkJEUmFEd1NOTXFVSFRFM2pXOFNRUThIVVdnN2lHMm5tNXZRZ3BrMXNGdlFo?=
 =?utf-8?B?cjZrVGFVUTNkRW5RbkhhSXp4NGdzbDZlWmZxTnRhdWZneHIyWm1wK2NxYmV3?=
 =?utf-8?B?cS91QjdnVDVjWkI0SVc2M1RkWEsrOC9XeVJWV21USmxxQmorM0MyL0NhQkJk?=
 =?utf-8?B?cXZ4R3g3bEwxaGVUcmZqTi9ocHlQTW1sNzFDVXc4VUdhMGZvV3JScFdrd1FN?=
 =?utf-8?B?SUlzQ2hGazlDZlR3dVdiYlR0YkRNUmFHS3c2Rzc0NzV0YTRrNDlEZlV0MFk1?=
 =?utf-8?B?NmlaV3hTeWM1NG1mNURZdGxsTEpveHgwTWJwRDR5SmR2Zjh4YXRTQ1FGUGF0?=
 =?utf-8?B?cTdydmM2ZDNraEVkYmlHSDl6SEdhUkp1c0tqS1piVzJra3FCVUhMTFNqTDlN?=
 =?utf-8?B?UjlRTnpTOWgxODg0NkdOOS9TNmJCMld2NWpJMFozd1lPUXhxNmp4aFFyUWJN?=
 =?utf-8?B?N1pGQkhTM0F0S3Y2ZmZ3QTZxQ1h0NlRJNk1ORVV0NlpCNHJzYlRWTjVlbnRK?=
 =?utf-8?B?Y1lmSmhkaHFqRDFqcXJKOGtLRy83U3N5WHZwenorTFkrTmNjN1RFc21iNUwr?=
 =?utf-8?B?OHZCTVJTYWNQVjV6aVB4c3dINTNUYWZOUjN2VXNEUFJiK21WSWZBRkF0ckYw?=
 =?utf-8?B?Z2VCd3B2VGp2dDhEM2NhTm5vNkpuNEpMZjNUMko5citnMlE2ZER3bDROMDQ5?=
 =?utf-8?B?M05XVklTWG5zaXNIRjVLWVdmVnJGMjBIU1VVQ3Y1Tm9tWXNaSzU3T2J6cjRC?=
 =?utf-8?B?L3ROZHlvb1NxOFVPM0FFUGdDRHVsemtBZG9JdU1rdC9lTDFvcjVUUjFOK2Ri?=
 =?utf-8?B?emRqTEJYRURINFVhTjhMZUVKd1g3dXUwWEl2bG9FL0ljSGRkRDNlUnhIczN5?=
 =?utf-8?B?SjZLb2loNmpqLzJwN1ZYaVFXWUZLaUY1NmxqM1g2eHd2NzVpZDVpelVDSkYv?=
 =?utf-8?B?Q0t0Ymh3bTVJcmZNdzdDendCTlQxUGNTVkJMdWgvbFZrbGFYSFhLbEVoSU5z?=
 =?utf-8?B?a2V5b05kQlNXOHhyMnk3dHQ4dmhuNitkYW8rVXhxYlpjRXV4TG9MelRjeVcr?=
 =?utf-8?Q?vE0chcAGsolM5LFo/cXMOOMljkdHwYcgMDkOXzt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZyaE1oMkhXclUrWHBkaFpTd3hTVlNGdW9PNlZqZ0hja0hxU0lseGpVUkc3?=
 =?utf-8?B?QXZINGcyWEJsemhyWnMxMHR0UzBGOU83OVlQT3ZpZ1R3T2NEd2pZdkd5bC9z?=
 =?utf-8?B?dWE4eTdYNkNiUDJ1REUvdHlmeUR2enFXREFTVGFFQXZjT2h3TWJiUElmVWl1?=
 =?utf-8?B?STJLR2dDWm5MZ2NmSUZtSktPVGtaOVdjTGZCMnh2RWxuTGZEVEtyVUhzSk5o?=
 =?utf-8?B?eUlpV3JnKy84NDBENXdrdWgvQlpoTFN4RDQwbWRqL0J3azkxdEZCY2hWN01M?=
 =?utf-8?B?UThIZW8zbVBHSFVvN1BKT3BiSFA5UWZxY1ovM2JVZ1VFbkNseThlc0dNc2RD?=
 =?utf-8?B?d3RSS3JoN0Y0WW10cDJBQnE1anJ6YWcyRnJIT21xdW82QzBHYTFqVFdZZkVM?=
 =?utf-8?B?dS9IWTdKT2ZQdnRGQTcyWjBnRFArOXJxeStrS0krQlM5Uk1HSmJ3RmYzQmtx?=
 =?utf-8?B?SmdMVXJ1NWhOU1l6RmFjdzNjeG9tNjF3QkZlNFZPeVFlelZQU1VKK3lMQklM?=
 =?utf-8?B?ZHF2UzVkUVNpNHFtc2xHQ1JOZEtQbGl2M0IzbUVHUFpLay9EcWs4UTd2dGx6?=
 =?utf-8?B?akc5cStEUm5OTnV4SzRFbFF4eWtXemU3SGZraXFHcVV2WlI3M28yemFndmMw?=
 =?utf-8?B?TmNsdHlNeEZ5dXFRN2JybXo3cnJES055enlac3RuVGxLOXhYajJVZjNISnd1?=
 =?utf-8?B?eGdKL04xNkVtQngzejIyamx4U3A2Y09SVVoreng0ZklzZUZBTzBEeE9objhM?=
 =?utf-8?B?aTQwanQ4LzB0VmxLdkpHM3JiMmFDcUdwTkNtdUtVdFF1dEFNNFo0cHEzcVZV?=
 =?utf-8?B?ZkpuWnp3UXdhUU5aTVRsZW5zVjZCWG1XemN5ck9od3dGa1BIOG1oSnRTOHZE?=
 =?utf-8?B?M2NKK1ZiSnJYRU1lVFBaNThsRGRDcER3eEJjVnVadTArOUR4SVZoMVF5alFP?=
 =?utf-8?B?TEVhejVOdU4vUDkrd1MxZGt0bUlzS0NCa2NseVRCdzVZVDlNT1lDZUViVmZa?=
 =?utf-8?B?UnkwY1ZNcWFKRksrdDdad09KOXpudS9LWm0rbDFnczNoWUNBMG55VnVRZldZ?=
 =?utf-8?B?Y3ZlYysrUWZuMGJSYWxhL0k3d0o1SHR2R2pnVFYxS1JyZ0pUY3ZaQkF0NUZV?=
 =?utf-8?B?dE1EZzFIdytNSXR3aXlPNyszNTZLaWczRDdaRGlkWk1PV3N3SHAzM0ttT0xH?=
 =?utf-8?B?elRzai8yaFhOcHJMS1RGZmtqUlZUNVVHZUJvN1ovZU1QTk9TOXpjTXBLdlFU?=
 =?utf-8?B?TnVqckN5bENKSVFnYU04VWdLbnpKSHloUW1HRXhJa3Nmdmg0NXE1ZmhlRWZj?=
 =?utf-8?B?eHVIdTcxeVk1ZHVxNkU0SStwQUxLQzdGempOWG1peVM4QlM4ZmE2R0V0NzFs?=
 =?utf-8?B?dnBycmExaHN6ZzF3alNQTHJJSmgyQjNucmRHT09GY2d5YmZvcUIzZEVMZXN1?=
 =?utf-8?B?eGVXV3U5V0VoOXJ1RmJiZlBRZFU3L2hPSS9qNW1pOG1uakxEMWoyMGlaVTlV?=
 =?utf-8?B?UDBwU1Q4SWVIZ1BiV2hDVEE2T2VmOWxvVVVmN3N6RTB6WUVpNUpqQnBqUmJO?=
 =?utf-8?B?Mld1c1BvWjVHaERSWEVCK24ydFIrUDQ3QjhOS2F2MFA0aTlobmUzbUw0M29o?=
 =?utf-8?B?VkxMVUJQSEpDcnJaLzFIbXRqS0Q3UTNJbnFNeEtiaDV4Vlk3TzNRdXl0N0tC?=
 =?utf-8?B?ZHZwRVlXMk1RNXVLMVZBUXRHK2Vvc1lteHhJT3J3OEZXZHpQMDNBYVJ1TEU5?=
 =?utf-8?B?U3Ewa0YvYTFlWDFyUUQ2UTFUd3cyRGpKSlJWUlNHZDBlR2ZVN1hoU0lJdUpO?=
 =?utf-8?B?czV1cVZDK3Y1MGR2Uzc3UlZDeHBHelB1UG92c0RoemQ0WHZTaEZ2cVJSTlFH?=
 =?utf-8?B?OW1sRDdrN1U3OWFneEVCV0syckNUVUl4SWFFYk1VY3ZtNmlsOTZhUHlVaVFY?=
 =?utf-8?B?RTdKeHptQXIxaW5XYVFiMHZlaStOS1djVW9LWUM1OGFuS0ZvcVNERWMzKzhE?=
 =?utf-8?B?U3RyZUszblU4Vk15RWF0Ym5hWXdUTEI0T1dEWU5VTS9UeVA4em1ER0cwczlT?=
 =?utf-8?B?YkNrSTNJY2VLVE0yV1Y1UlZCRi9NTE1XbUFsRGxNeXorY2RhbXlqNFUvYmFq?=
 =?utf-8?Q?HbEDS93CM73c1bDTSSXkNWQ1Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c25bce5-a657-4117-d291-08dc89627e7e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 15:32:10.3003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8JU3mxmn19V6oG8Es6fGU4MkLFUWW4KikbJO269r8xRCdVrOOd8fUvL0DW/G5I7dAclvCNdggoc/NCw0aXBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

On 6/10/2024 09:55, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> To fix CONFIG_ACPI disabled build error.
> 
> Fixes: ec6f30c776ad ("drm/amd/display: Set default brightness according to ACPI")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a2c098f1b07c..6b3634db4c15 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4572,7 +4572,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   	struct drm_device *drm = aconnector->base.dev;
>   	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
>   	struct backlight_properties props = { 0 };
> +#if defined(CONFIG_ACPI)
>   	struct amdgpu_dm_backlight_caps caps = { 0 };
> +#endif
>   	char bl_name[16];
>   
>   	if (aconnector->bl_idx == -1)
> @@ -4585,6 +4587,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   		return;
>   	}
>   
> +#if defined(CONFIG_ACPI)
>   	amdgpu_acpi_get_backlight_caps(&caps);
>   	if (caps.caps_valid) {
>   		if (power_supply_is_system_supplied() > 0)
> @@ -4593,6 +4596,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   			props.brightness = caps.dc_level;
>   	} else
>   		props.brightness = AMDGPU_MAX_BL_LEVEL;
> +#else
> +	props.brightness = AMDGPU_MAX_BL_LEVEL;
> +#endif

Hey Leo,

Thanks for the patch!

As caps is initialized to {0} caps.caps_valid will be invalid.  So I see 
two other ways to solve this that are a little cleaner (IMO):

1)  Just block the one call:

#if defined(CONFIG_ACPI)
	amdgpu_acpi_get_backlight_caps(&caps);
#endif

2) Add a stub inline no-op function for amdgpu_acpi_get_backlight_caps() 
to the header.

I personally think #2 is cleaner (less ifdef makes a lot more readable 
code).

>   
>   	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>   	props.type = BACKLIGHT_RAW;
