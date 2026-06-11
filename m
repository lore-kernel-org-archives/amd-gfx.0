Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD6CD98CE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 16:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D03B10E0A3;
	Thu, 11 Jun 2026 16:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zqwsyGp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C3510E0A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 16:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRPoCahBqHS4Bvmk5DzVfmO+V9CAM6tH/bBK42CKy9sZMMVtCSEZhCAPuCAaIh8t0xP9XoRtbzYttBp6CHVDwgr2YKEMtdve1Q7YXIk99k7jjrHgYAaiOHrWYhW27No1uGDppXLMfY7JCgeWm9ncvjAE0Y8iSkhTOKvBdgYYKCZDMAccYAyLoQtNN8cEoUHC4kvlm4yK+gf1AjckWNoNOs/uYdydCXN20BKROhLKE0Z3nFKNd/VPFiFQxMSScrnxjfXOFLjLaCNURzNeL/3XC4LMy1c8qB9/6gLRSHbBWNjtfHS+NYUAMk8l8p8+CEdbhlEX0MticZv+O0jErUc3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buEOz1W5kZ/hZ5O08ONk0uPZvFQhUMqX9gas4Y33exA=;
 b=folhj5NtP6Dj+r6jCJ7XaZ9h3Py6igQR+uYtLtG4OrWYmOJLriopwR8UeptrRFuq6juj28m7IxkaZQ2/RpzxAYnhOGUsHhAUo5yO2HIFj4uh6mN/F96bWfzcODpXfj1pgmUx6oChpQPc6hDiBrZ23TlztmAWVh7s3XPCgYzKddmSzijMPKUyVl/9J3wa+XgfsN5EmEgDSIMxfqVnHa8ANGiG7+2sfdePuitYxFuaNxy2tFwkXywSoG3Z36/VHMZTkW1xqpUWkSzT5Bw6b4s5RY1BQ3gumwSDe10kn+6wBQkACxLWrhj9cWjPwB5aoD2Oj2/x6FyZDz/GkZNKS7UitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buEOz1W5kZ/hZ5O08ONk0uPZvFQhUMqX9gas4Y33exA=;
 b=3zqwsyGp7Da4HCxwoRT+5y9oUfRdFqH4hpiKvEqRWVMS0IP5bXauhIX1aDO3JPZvhZJ6iAK1/oUL+A7pqJTjOBmDG7utufhVy9eJ6AUeg6gQIw6GTfgacWHouOBdDX/m+uoteEq/h6EMZ+9I2a11iTT3zoNLZTcsKa9BIi+YFDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:53:20 +0000
Received: from PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16]) by PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16%3]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 16:53:20 +0000
Message-ID: <09f81871-aa4f-40b7-905f-8e5b6d704a4f@amd.com>
Date: Thu, 11 Jun 2026 12:53:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix NULL deref during sysfs teardown
To: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::22) To PH8PR12MB8432.namprd12.prod.outlook.com
 (2603:10b6:510:25b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB8432:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: f1056267-d30b-450f-aaff-08dec7d9f120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZUSGdioCmGiO7fgCYt8W78mwfa0gi0uOsCQ34vMIAn/zPgVFICktNfarAeOw3ueuFmBPkfgkGHMPN8dpqtZ/8/GxaUUD3HYkrue6v5gsOvWbLQ7d/AoLymUZ7z6mjQXEpcjAjSeDE7h5/BJ3OQN2HNifgfY+eRqZ933FWq7S9wOeUEzV/5LlgphAMi488dbZDLLaZLdSY0JWIVDqQcbXzE6n2TKtsMdbdpTP7KCa8nQJN33ulFv0jrR/ySVnT5mPVYofOLe1FI18Mx+/22xrxjKJlP5vUVQPhKDk9CBwNDLdtqu799IHQZc8vNTCdno9IiZNtUnZYJMTKBnomrYkHPM3yGQ8QxksmgOgY3JMgMs0S9Tuno+4TtDWaqdp/9dRsOYBd27VhyUPx8/wcrqUf9IYS7IeVgZ1/bOeOQshd/6UWIXiWBmTJoeI5R/ckxCwo00zcTwhhkenHbEFdcFoRywAoohhjNV7oQpGI4/QBIuNDFrgWIh34D/XwxTZR4Q51SjWEcU6z4u/PPQyzq1LPNx7fJ0jMbHT2gdHl/yKeFZ+d80paXxRt+HehZBqB0oB+Q/1Em/Mj+0N3kFmFy0b6RMVf4QyzFBpzPBmtjqh4Nt/BckxkUBbI0qwNcnc4HErLYKH/2PUdoNtZvYts7ByO3wII+niONantwOb787N53D6m3OsaT6roNk2p24gfYE6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB8432.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhwTFY3Qjl5KzkrY3J4R2FMZ3hFbGRNTm83T0NlZ0U2Y0hzZ1FmK3FxbG9o?=
 =?utf-8?B?Nm5nL1RmT3lEOUp6bU9YMnFMbHhLQW83eVRZV05vbU9lOXk4Ry9CU2d1bEVl?=
 =?utf-8?B?WWxKaENHWWJSVFc3OTBZbGs4LzNUWTRlaTViM1BaZ0VvZ3Rzalc0TmY3S0to?=
 =?utf-8?B?aVVKODV6akM0dnQ1alFYdjFFN2FPaWJCY20xZ1FBWlpxdFpYOVNmODhHRG5y?=
 =?utf-8?B?NUdZTytiRTVvbzk3SUZEM0Y0QkNseU41SkZ2dStkZmE1aTQwN09nYmNPckE2?=
 =?utf-8?B?b3Zkb0VWRlJzN1dkbzNjSUxVMFBRS1ZTY0RqdG80Nm50WVdTRW5zV1V2MTJY?=
 =?utf-8?B?YlZyQTNqaktSTnloVm92RFBwR3c5cnFHVnJZQnlLbVlxSXBzTmRsY2JxRkU2?=
 =?utf-8?B?RnJPNGFCMHJwTWg4aFJOSStsendZdHBNdFBDK1dRMWNFakJiUVZXQUwrTjRU?=
 =?utf-8?B?NWw4YUEySkVsRTY5c0lGUzBrNnpiZlVGMzVUVUJiTFZwMVpUZmlzUlJYSHZs?=
 =?utf-8?B?bEt2Qkhkc1d5V0s2cDY0V1duc2UvaERPZjRZdE0wRmsvZC8xWm51Q21FR2px?=
 =?utf-8?B?VXBXak85K3V5SjcwS2RrUTJzL2FFb3pXUnl6UkpCazNScWhtZ081ajVLMy9q?=
 =?utf-8?B?bVc1V3hLbzBJaFNHazhYVm41NDJNUXU5UWhCcEZEOWtyNjhvaHJaRURHMm1M?=
 =?utf-8?B?aXh1VC9sZi9YV3BOTVF5eG9NS2dIVFZlSC92QlRCOFAzd1A2MVhNR2FVeThz?=
 =?utf-8?B?YkZjMTF4ZXVNWlIzMFR1Q1FCWHZKaVNPWkFmVnU0Zm00WUZWY1BnOTZnU0FX?=
 =?utf-8?B?Y1UwR2tDQUJPYkxKb1hTSWRFOHFMb2R6STQ4YmhBWlU2eDB2cEc0YkdrY0hr?=
 =?utf-8?B?VHRaL0Y1WGZ5Q3NZbHBMdHRMakplZUtESkhsN2VrWVBBaTFDeXRRYXZMUUtq?=
 =?utf-8?B?bms1NmRVblhSNmtITlR1QkppTHlsTFZlT2hONy9QTGhhdzVydER6SVMzWHFX?=
 =?utf-8?B?SGhCbkZvUklXUmJYNDgzNTROTmE4ZTdxMW1VZTZ2d3VQNDhsMU0wd3h0TStQ?=
 =?utf-8?B?ODlQWlVZUnNxbGowOG5peW5NTTF0YjZwcDYxdndPUVBKYUg5WUV6Q2lyditH?=
 =?utf-8?B?OUVTQ3V2QUFJdnloOTY5eTdBb1NWd2FMR2VPQ3NIeS8rdHU3ZnExRDVzT1M2?=
 =?utf-8?B?eWQ4K0pkUFJHQnpOcUpKTnVNY3IyQ2w5K1h3SVlqeXMzbXVKd2VSMG5MK3Ax?=
 =?utf-8?B?U1VNaE9lMnJtWWNFME8wREVGWWxILytGRm5HcHNOUkZQSTR0dXB2OERTSFVM?=
 =?utf-8?B?ZFRnMjMrcWV1SFlHQThDZnlQZm05KytTbDJpQjE3ZCtzOUpJY2hZLzM1VllZ?=
 =?utf-8?B?bVpqcFExOEF0TDg2bmtRNzNxcktpZE5JSUxIU3YvYlA5cmpPS1hLSW1iVGFU?=
 =?utf-8?B?M0FhL3YySHpZNEtHMXdQRWEvcmkwN0E4YmxOME1keWRzdmUyaWVpOEszK3da?=
 =?utf-8?B?RkFzVlJWRisza2V1UTRCaXhVRTVQZFNlWkMxYmJQN1NTQWJjWjRISnMrQk5h?=
 =?utf-8?B?amE1ZjBXM2xzOXVkZTRsS0NlYW0xSmdYcTdSUnhxK3ROaUY2RCtLOFRkWndV?=
 =?utf-8?B?YUpLVjQyTFgvU0RUMkk4a0tqZWozWThWUzIyOC9MOGtKN3JjNUJ2d1kwT3cw?=
 =?utf-8?B?cWsvenVINzY1dHhMS0RwVEdRKy90cHhEQnYvblhEbi91UTdPN3pXVW55RHgz?=
 =?utf-8?B?VVNTakQ1VUR2QVdpeHh6WFR4bk51Z1YxdmwyRDA1a2h0aGtvdkFqRUVaaCs3?=
 =?utf-8?B?am1XYTdxa1JVcHNYRUV5Nm1SVDJBVFJFS0F1OURtNnhhcUY3RjQyTzJHZDMr?=
 =?utf-8?B?d1pER1hoNzh4L09uVlc5U01NUkpueGlGTWQ1amk0Y25USCt3V2FEK1pPMmo3?=
 =?utf-8?B?RWorN1FuMUhYd2dRY2UxZk56cmYwZkRJWFdLUDNySmJGVzdqdnM5NW9lYUxm?=
 =?utf-8?B?MGdBak1INkVWSnJpMmFscitYSDNvN1hLLyt5aTBPbFYzZHJuODRMQS9TTHpo?=
 =?utf-8?B?bVJ1aWpQcXpCR3dsTHgyZTlVQktOSFRHZVczYjhXZWVuQklOa2k0bi9qZ1ZM?=
 =?utf-8?B?QjJsYjByZjBBY1hRcEVIL05ubkxwRWxMOG9HcEdVenEvU0IzRGVhcld0dXQr?=
 =?utf-8?B?RmxhT01KaUw3eDR5V2ovTG8zbDZXY1k2cnNzeURrVTFaVXN4aENQVElkbG80?=
 =?utf-8?B?T21kZnp6N3g3azV0NHlYVzlDMEJsQWVqRWZhbUZKWlFCSGdMV3Z2OXFubXUz?=
 =?utf-8?B?UDgrQjdyaWswNzYrSDk4cjFuSE1vaVoweHBqZzVGWStqTEdEbktyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1056267-d30b-450f-aaff-08dec7d9f120
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:53:20.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHW8CdhvZOSGH2mXrnux5J4ggvRVXAgtgWLTQ3qcpfge+sbEhCjBn2HL/jkZwk1xokXjUu39XrFkePGgLLPNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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

On 2026-06-10 23:01, Geoffrey McRae wrote:
> Move kfd_process_remove_sysfs() earlier in
> kfd_process_wq_release() so that all sysfs/procfs entries are
> removed before tearing down PDDs and dropping lead_thread.
> The per-process sysfs attributes are backed by struct
> kfd_process_device, and their show/store callbacks dereference
> PDD fields. Since sysfs removal waits for active callbacks to
> complete, removing these entries first closes a race where
> userspace reads sdma_* and stats_* files after PDD teardown.
>
> This race caused NULL pointer dereferences observed in
> kfd_sdma_activity_worker and kfd_procfs_stats_show.
>
> Also harden kfd_process_remove_sysfs() against partially
> initialized or already-freed objects:
> - Check kobj_queues before removing PASID and deleting it
> - Skip NULL pdd entries
> - Guard kobj_stats and kobj_counters before use
>
> These checks prevent invalid dereferences during cleanup.
>
> Fixes: NULL pointer dereference in KFD sysfs/procfs stats paths
> Change-Id: I405b8fb95d3c5e163dfc45928da54f31546d92cc
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 44 +++++++++++++++---------
>   1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d28ca581cad0..b47e7dac8b2d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1160,28 +1160,36 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>          if (!p->kobj)
>                  return;
>
> -       sysfs_remove_file(p->kobj, &p->attr_pasid);
> -       kobject_del(p->kobj_queues);
> -       kobject_put(p->kobj_queues);
> -       p->kobj_queues = NULL;
> +       if (p->kobj_queues) {
> +               sysfs_remove_file(p->kobj, &p->attr_pasid);
> +               kobject_del(p->kobj_queues);
> +               kobject_put(p->kobj_queues);
> +               p->kobj_queues = NULL;
> +       }
>
>          for (i = 0; i < p->n_pdds; i++) {
>                  pdd = p->pdds[i];
> +               if (!pdd)
> +                       continue;

I agree with Kent that this is probably overly paranoid since you are 
fixing the sequence. kfd_create_process_device_data initializes the pdds 
in such a way that it should be impossible to find a NULL-pointer in 
this array.


>
>                  sysfs_remove_file(p->kobj, &pdd->attr_vram);
>                  sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>
> -               sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
> -               if (pdd->dev->kfd2kgd->get_cu_occupancy)
> -                       sysfs_remove_file(pdd->kobj_stats,
> -                                         &pdd->attr_cu_occupancy);
> -               kobject_del(pdd->kobj_stats);
> -               kobject_put(pdd->kobj_stats);
> -               pdd->kobj_stats = NULL;
> +               if (pdd->kobj_stats) {
> +                       sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
> +                       if (pdd->dev->kfd2kgd->get_cu_occupancy)
> +                               sysfs_remove_file(pdd->kobj_stats,
> +                                                 &pdd->attr_cu_occupancy);
> +                       kobject_del(pdd->kobj_stats);
> +                       kobject_put(pdd->kobj_stats);
> +                       pdd->kobj_stats = NULL;
> +               }
>          }
>
>          for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
>                  pdd = p->pdds[i];
> +               if (!pdd || !pdd->kobj_counters)
> +                       continue;

Same here. pdd cannot be NULL. Checking pdd->kobj_counters is necessary, 
though.


>
>                  sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
>                  sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
> @@ -1239,6 +1247,15 @@ static void kfd_process_wq_release(struct work_struct *work)
>
>          kfd_debugfs_remove_process(p);
>
> +       /*
> +       * Remove proc/sysfs entries before tearing down PDDs or dropping
> +       * lead_thread. The per-process sysfs attributes are embedded in
> +       * struct kfd_process_device and the show callbacks dereference PDD
> +       * fields. sysfs removal waits for active show/store callbacks, so this
> +       * closes a race with userspace reading sdma_*/stats_* files.

It's actually worse because kfd_process_remove_sysfs itself is 
dereferencing pdd pointers. I guess the only reason that doesn't blow up 
is because kfd_process_destroy_pdds also sets p->n_pdds = 0. So the 
sysfs cleanup never worked as intended. You may want to update the patch 
description and this commend with that in mind. Anyway, the patch looks 
good. With the two nit-picks above fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +       */
> +       kfd_process_remove_sysfs(p);
> +
>          kfd_process_kunmap_signal_bo(p);
>          kfd_process_free_outstanding_kfd_bos(p);
>          svm_range_list_fini(p);
> @@ -1252,11 +1269,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>
>          put_task_struct(p->lead_thread);
>
> -       /* the last step is removing process entries under /sys
> -        * to indicate the process has been terminated.
> -        */
> -       kfd_process_remove_sysfs(p);
> -
>          kfree(p);
>   }
>
> --
> 2.43.0
>
