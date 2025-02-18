Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C1AC02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 03:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB82010E379;
	Tue, 18 Feb 2025 03:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OvRACN9H";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BE510E379
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 03:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBoumIfntSzV0VzI+lKlQi03xReWmrOowAZx+4vmrYlHhpASuHb8Ad6MM4yywKS6boHD68mrGVT3ahHTirP29cQnKHnhhK4kzsdJkCyxQqlUCFJV7bUWF/65BHpnQtpURjTofTRiz+J1yZjDEySOapsMRmdfrR87QW1rpoAQXQqkJVgwdRVKg2lLuObdeWrtYsbhWNFyiPXnuK9xJe8kR1t+kjMmtxrTTSgKNAS3ajI2u3spdUvxexTc6UPPiYUxAFxzLSUYo+JACX+pYZF0lWRzjV5rFiqJqgHAytXOiPdwH1hOjhOsOKh8cNkWDzssMscHjos7DrERMHtOPug2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbox2xa8MA7v1ZquL8Inyjva2qIcu8oowJQ5gg8hCHc=;
 b=mn5AiLJJWYtmBSNHnXgW4w2MRIedsJCZcuseS1eljD6iz+yaJObwZgyL6U7ALz5ahyH91X7p1Qt/EOjknFHqrWiODt88ZsUKmn3B0W98/bvJvk7BvL6Z8Qs8I8Vuk0WnSmxo01ENTgkHF27r1NZXQcqR97DSLBPqK4joRromuyo7qMSp2eqf4CMufU/Dcl0T6BtVceU/QoaCgLJYniR3XeF7Bm16JElQaXlAY3AHqfYfC7a2zMT0K37ppMuji8MRT9D6HaDMfK2iztLrw481RqYjxip+e37Y9w5kKQwZIA9zezbFTq2ZLGyORkpDak8ybGojoj3DilCI+1jpkDVdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbox2xa8MA7v1ZquL8Inyjva2qIcu8oowJQ5gg8hCHc=;
 b=OvRACN9HTGHxU/wD3HQgfxms9lMnHslr28YveQvhb2MRSmInA9AOf/D8xFdQLhaxymabYhKSgqtoGN86/aclslh39zZPAooH1Bz1471zOhic+VATKI6IP2VFHnSk2aTKK+tu4RUhwKqt/PjWqmSG0oGdfrGqASDrM9Nac9RVQOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Tue, 18 Feb 2025 03:42:21 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:42:21 +0000
Message-ID: <0a216481-726d-4aa3-99f9-7a81b5e8feba@amd.com>
Date: Tue, 18 Feb 2025 09:12:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "chr[]" <chris@rudorff.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <20250217152638.672864-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250217152638.672864-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::45) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f3f92e-887d-4746-623f-08dd4fce3fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MS8wb1g5dGk2NHp0UlJDdnZPV2x4RXZYZHdtOTFZZE5YTnBHSHVEUDZZcjJP?=
 =?utf-8?B?RFRtZWxzakFRU0JveUJ1YmxoUUQwMEgvVkV1NnNvVm8xZldmamdtazZ5L2JY?=
 =?utf-8?B?SkdOR2hEUmNwWlYvcUxDT3FKS1pxSmZSUnpKUDVzdjhYZUt0ZHZ6anRLK2hI?=
 =?utf-8?B?NC9uTlQrSDA3TndaRnlsZzd5NXhQd2V5R0JiWklkTmEwZWRMd0gyNE1Uc0VH?=
 =?utf-8?B?cTYrUUpWclgvUVI3Vm9RQkUvZVJkejhjWkdBOFFuc3JXOHpKeGhyNVp2azF6?=
 =?utf-8?B?VFJ6dHN0QVhQLzBQMUo5bVJnS1ZCZGZsWHZoaXhqd1RJMmxXejgxK1FxWkor?=
 =?utf-8?B?TGhwUmxpa2lGRGpJN1NkWVhYclljQlREeFpPWlJwTG1DZnlUMHpYenFGZm1V?=
 =?utf-8?B?Q2MxZ3dBL2VVTjVuSm53MUduL05jWEZCNU5vK2FBOTVWc2JDdExqODlENVIv?=
 =?utf-8?B?UG0yWDIxTWlWREVBYlMwL2cxU0JhOHJxbGVEdUFJMmU0ZFdGWCtMUnJMNDVk?=
 =?utf-8?B?SkpVY2VLWG1tWVpHWTRkTnFXV3JRcEZrdTBoak85OFJoZ0lCTGVkZDUzZzI5?=
 =?utf-8?B?clB4OGtacEU5ZW82dERSUE1xeGhGYk1EaW5NMXdoQ3gxZjV3TytQUExDR3ls?=
 =?utf-8?B?YnZ6NXM0SGVGQlpIcmFXUERIbGtnOXBmVTc1RmpjZzdZYXlvNEprVnFBY3JF?=
 =?utf-8?B?KzlqS2dnWUFQcHJyMWJZN2t3dEJXS1Zkc1JTWG1CaW0xZkhpck9nb3o5L1Bq?=
 =?utf-8?B?L3J6blJtR0doQWxTTWRWN01MaG9HVitXZEpmR256WnZBQ1B4V3k0SEM3b3pk?=
 =?utf-8?B?cmZoNEM5R09DQWdZSjB0VlppNUdOazB2cEpQVzJWdERtY09XZG9pUkNyTFds?=
 =?utf-8?B?YjhTc1daMXdURWx0TUNyZ1R5Rzdkb1hVTllOeU9GT3pwY2hNaW9ObmJGUC83?=
 =?utf-8?B?ZmRkREpaa0w0UTZ5UkxMOE5hTTBUbXlTSTdHU05WZytvdW01U25MRC9MSm9E?=
 =?utf-8?B?UGJQNnRmOE16WkRFeXBJZGxmdktsUG9sQVIzeUdMbDlIci8wSVpqTHJTMFQ4?=
 =?utf-8?B?RzRMTzlWRHRlRnBLZTVmTjd6N09TRGtwSXJLUnVvRGd1VXVWOFhFYk05U0wz?=
 =?utf-8?B?MlhWeStoQk9YV25VdmVyeHdka2pUSDVIVTNYQStwQlJFb29tVUdnOFBtN3pH?=
 =?utf-8?B?dCt4RHJqb2ZLRmZPUWh1cjVBOXJaOGxaR3F0dkE4UGQ5SndjeDZ2ekdLTVdW?=
 =?utf-8?B?c2k5U0JrZDRPK2FxclorbGRUY0YvWnRUNXNUOXRDNTVyTW45OHlqcnlzeFlN?=
 =?utf-8?B?NHNubUFmQUZJckd5eDE5TnNzZm1ibVFsT0FHQjAxSXZ4SDhVRFYwSjlmYXZI?=
 =?utf-8?B?ajFzWVlxZlp5elpFTU1DYkFoMHp1U0FJOURmVi9CcE1hM3dXbWZWMUVPMm5p?=
 =?utf-8?B?ckRRS0tkclYzWjl2dWhCblJZN0F4WFZ0cEVzU0pZNWljK3VCTUpOa3RkZ0dL?=
 =?utf-8?B?Y1l3OVFkRzhLSXF0SEg4M05pVk4wdGNUbU5KTnJsY1BwR0swRnIwaHJ6eDVQ?=
 =?utf-8?B?TkowbXAvcUZlMnpCRW11dTNKMmRnQXMrMEkwK0JILzhJMEx2ZXpTWnB0Nmtp?=
 =?utf-8?B?aW1WdWR2TXJtenZhaStMKzZjdWdsOVNPajd2LzFtWjEyRnVKNUpHYXFjMEhi?=
 =?utf-8?B?cVpoTGluZURBemVVTjhYdkozQTFFOTZYM0lPQVN6SmpoTGxJSFV1a1BkUWJN?=
 =?utf-8?B?WHkveFNYM2Z4NVpWWXVSN0Y3QlFnaUlqVXp0anBSeGdTZHpFM3BQQ3BqY0o3?=
 =?utf-8?B?ZUdCRkNrVjM5SkVMVUpZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L29zL2JYK2doWVZoSUdOaitPdkYvWTRjeWdYRmNrT0RONDUrMFRVelFrNEdl?=
 =?utf-8?B?blZvWEVXVkx4UmJhQndHS0w0TXRpdHlRQ0hoTi84UUlkbngwQTBkL29wQi96?=
 =?utf-8?B?b29nNDZsaE1OSGltUHNkdXRONHBwTHdoWUhGMHZkRkl4dEp4Q2p4dzVvelRV?=
 =?utf-8?B?T0dLLy9TTENDWXJYTGE0aTRDOWxnb1VtalNUOEl1VjN0Z00vblhCRGVNdFll?=
 =?utf-8?B?TDFhb05ZNmRQM0dZN0ZSRU5FRHh3S25RK2UyNnh5TlVUdkN6b3Z2UjRSd21P?=
 =?utf-8?B?c1ZzcmQ4QUI1cy9LZFhzNGV1cDBWNFNKWjBGYllNZkFlY3lFc0RqbVh4Wkow?=
 =?utf-8?B?cEZRanJSanY5Ylp5NCsrVXYwdVBDT3hQelFyNXFMZTdtc25OMnFuMVFRWEk5?=
 =?utf-8?B?NmtCVE9FRlh3VlVueFVIbVc2ZFVFTDRpZjRHYjhiL2FDcFE2RXFjK0JZQzRj?=
 =?utf-8?B?ZERna0hZR3ozQy9mM2lJYmgvQm0vQXBOLzl3UHB4RDlyaE1qRFhuV1RBREJD?=
 =?utf-8?B?eGFwd0RSM2xxNHNvTDZVRHMvU0tmcEZMVWJTeGJFR2ZzcnNGVHkxbFNxcDR4?=
 =?utf-8?B?UndJVlRucENKd0Z4eDYzbUljQVU1NmxJNUpmVC9LaVFuYlJFWURMTVhsL05O?=
 =?utf-8?B?QXJUdnFGdklCdW51Z1Bib21LU3k5Y1RNaUhBOEFSR1JIUncrQnRQNHE4dzRO?=
 =?utf-8?B?aWJsMndOTHZnWDZRUC9GbXBETVlsR0JaTmRJTFZIbnkrSlJuNGsvakY0Sjdi?=
 =?utf-8?B?Q1hTVmkzN2p2MTh5RmthRmpzUnE4bW9LY2Vic3V2QmpXWUUwdFJGSG4wRklz?=
 =?utf-8?B?aEZ6bnJCTjN4aVovYks1NGtLYXZXNWViNGJYZHQrYmRDL3M4V1BJQzF5RE1M?=
 =?utf-8?B?d0NucGEwdFhicUVKQnhTTnc1VGpFLzd2V3VXNDZ0WEVjdkdJUWVIcmI0bGlk?=
 =?utf-8?B?dmxsblJBS2c1S1ZEOVJTc29WdkZWb0VkTjdneisxVWxiR1l3QlNQcXBuNndC?=
 =?utf-8?B?TWc1d0F1Ly83RC85RDBtQy9vSHo0M056Q0t2emtXYXJZZFNVWlB4UzJtSDVi?=
 =?utf-8?B?bG8zL0FKSjZITzN5VStESkJ3TnF2dWl3NmpxT1c0UitCMll1MGpqQmdHZmd5?=
 =?utf-8?B?cVg4WUVrR1hxbEVvbHdpMUJSVi9yVVVmRU1xNjRVMjA0UXI2cnVlQjFOVHgz?=
 =?utf-8?B?aDljUVZ0N1ZtQ2VCN2dwQzk2RmtIdk9CdkxlUzVvZUUrNURObHhzV1ErWHVL?=
 =?utf-8?B?ZWtHT0JxWGp5MXJhMkFFOEZsU3RXRXFrcE5QQlg1UUlHZUE5SC9wcEo1QkFm?=
 =?utf-8?B?VlQyRDRoT0tpZ0ltcGszWmRFVDRsbFNWZGRrTWZVUk8wK0V2bzQxVGxCK1FX?=
 =?utf-8?B?TzNnbmxidWxaTUxqMGk2N08rWDZjdlI1UFZwRFdIcGw1K0dtNE5GZXR2WE0r?=
 =?utf-8?B?SFIwNTBKYXBadHBrV2d2Rzk2ZkNsRFNGdGxteThCODhtRTloTFNYbDZRU0k1?=
 =?utf-8?B?Vkh2dWhlRERMSENENm15dmxhUFJrK210NE9vUE43Q0FieDBGamg0bG5XNDFO?=
 =?utf-8?B?ZXlKQWJ1ZytNR0txS1ZvdCtNbXJmaXVwZkhkVGJQU0EzZG8xaUdOcTFObzdL?=
 =?utf-8?B?c3dWT1hubU1tanlqMzZLV0x6VjExQVJOc0FEeWUvY1JnZzNlWGRRZ1AwcWRh?=
 =?utf-8?B?clZwTk83VGZkeUpIT1pGdkYzQ1FWdGFWQVkrOGZpcDN2MkdBSHEySU4wWkVw?=
 =?utf-8?B?SVhKV2pHdUplTlptOE43ZVZYMVRlRWphNWFwOUZaQ1BkV09EdmpjRER2QXY1?=
 =?utf-8?B?cFFVamFyT1ZhdnhTa2o5YzBvaVV5TEVsQjB5c21OVzVKQkExUCtMZW9xam5N?=
 =?utf-8?B?RHJpT3hlVkN2bFBJN2Q4ZUJ5aVNHemVUWFo3Q0trM0swNlNwd200Z0FDN2lN?=
 =?utf-8?B?TXlhRnZEbUM1dHdvYStSQlV4L3FTZ3VkdDVnM1dLRGY4SE9tU0FETTc3amZE?=
 =?utf-8?B?NEkwZGFSc3EvUGlETFI2YmJVNlFsYnI0c0N6dUJyZG5vU3oxbVF6S2FyQTlM?=
 =?utf-8?B?Wkp3Zm5SVXVxRlFSRUpMeWt3dzkvdzFKYWNSUS8ydUxLS0t3QVZ2ZEJBRGJV?=
 =?utf-8?Q?WmPkRABzTW1FEaCmB7NGtIUKd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f3f92e-887d-4746-623f-08dd4fce3fb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:42:21.0149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/R5db/4a28lAmsK/XRUhVh0GMKy90FYY8xTwhoaG17HGQOU+qRdVOR2wck3dHYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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



On 2/17/2025 8:56 PM, Alex Deucher wrote:
> From: "chr[]" <chris@rudorff.com>
> 
> resume and irq handler happily races in set_power_state()
> 
> * amdgpu_legacy_dpm_compute_clocks() needs lock
> * protect irq work handler
> * fix dpm_enabled usage
> 
> v2: fix clang build, integrate Lijo's comments (Alex)
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO
> Signed-off-by: chr[] <chris@rudorff.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 25 +++++++++++++-----
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  8 ++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 26 ++++++++++++++-----
>  3 files changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 67a8e22b1126d..e237ea1185a71 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_dpm)
>  		return 0;
>  
> +	mutex_lock(&adev->pm.mutex);
>  	kv_dpm_setup_asic(adev);
>  	ret = kv_dpm_enable(adev);
>  	if (ret)
> @@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	else
>  		adev->pm.dpm_enabled = true;
>  	amdgpu_legacy_dpm_compute_clocks(adev);
> +	mutex_unlock(&adev->pm.mutex);
> +
>  	return ret;
>  }
>  
> @@ -3066,32 +3069,42 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> +	cancel_work_sync(&adev->pm.dpm.thermal.work);
> +
>  	if (adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
> +		adev->pm.dpm_enabled = false;
>  		/* disable dpm */
>  		kv_dpm_disable(adev);
>  		/* reset the power state */
>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
> +		mutex_unlock(&adev->pm.mutex);
>  	}
>  	return 0;
>  }
>  
>  static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (adev->pm.dpm_enabled) {
> +	if (!amdgpu_dpm)
> +		return 0;
> +
> +	if (!adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
>  		/* asic init will reset to the boot state */
>  		kv_dpm_setup_asic(adev);
>  		ret = kv_dpm_enable(adev);
> -		if (ret)
> +		if (ret) {
>  			adev->pm.dpm_enabled = false;
> -		else
> +		} else {
>  			adev->pm.dpm_enabled = true;
> -		if (adev->pm.dpm_enabled)
>  			amdgpu_legacy_dpm_compute_clocks(adev);
> +		}
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  static bool kv_dpm_is_idle(void *handle)
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index e861355ebd75b..c7518b13e7879 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1009,9 +1009,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>  	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
>  	int temp, size = sizeof(temp);
>  
> -	if (!adev->pm.dpm_enabled)
> -		return;
> +	mutex_lock(&adev->pm.mutex);
>  
> +	if (!adev->pm.dpm_enabled) {
> +		mutex_unlock(&adev->pm.mutex);
> +		return;
> +	}
>  	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
>  				   AMDGPU_PP_SENSOR_GPU_TEMP,
>  				   (void *)&temp,
> @@ -1033,4 +1036,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>  	adev->pm.dpm.state = dpm_state;
>  
>  	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
> +	mutex_unlock(&adev->pm.mutex);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index a87dcf0974bc1..d6dfe2599ebea 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_dpm)
>  		return 0;
>  
> +	mutex_lock(&adev->pm.mutex);
>  	si_dpm_setup_asic(adev);
>  	ret = si_dpm_enable(adev);
>  	if (ret)
> @@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	else
>  		adev->pm.dpm_enabled = true;
>  	amdgpu_legacy_dpm_compute_clocks(adev);
> +	mutex_unlock(&adev->pm.mutex);
>  	return ret;
>  }
>  
> @@ -7810,32 +7812,44 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> +	cancel_work_sync(&adev->pm.dpm.thermal.work);
> +
>  	if (adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
> +		adev->pm.dpm_enabled = false;
>  		/* disable dpm */
>  		si_dpm_disable(adev);
>  		/* reset the power state */
>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> +
>  	return 0;
>  }
>  
>  static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (adev->pm.dpm_enabled) {
> +	if (!amdgpu_dpm)
> +		return 0;
> +
> +	if (!adev->pm.dpm_enabled) {
>  		/* asic init will reset to the boot state */
> +		mutex_lock(&adev->pm.mutex);
>  		si_dpm_setup_asic(adev);
>  		ret = si_dpm_enable(adev);
> -		if (ret)
> +		if (ret) {
>  			adev->pm.dpm_enabled = false;
> -		else
> +		} else {
>  			adev->pm.dpm_enabled = true;
> -		if (adev->pm.dpm_enabled)
>  			amdgpu_legacy_dpm_compute_clocks(adev);
> +		}
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> -	return 0;
> +
> +	return ret;
>  }
>  
>  static bool si_dpm_is_idle(void *handle)

