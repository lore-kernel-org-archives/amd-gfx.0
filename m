Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9829FCD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BCF10E87C;
	Tue, 16 Jun 2026 09:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3azFOny";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4A210E87C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikJVdrHkJAoJJDlKmPRhSfUVM/DkZDoAqcboyoBVFc8tRwaXz5VhmJ2k+/gOGUhssh2ptqP+NO0/RT58SmEitxojeGi9h3RdQz7/BfgQeA6XlmQqviw3+SvL6qA+SAPRGzI1DXyn+er7ri4yvWG7XTxiChOW6r47R+xFtJNrh+u7xyn0LzPAxxe/qYPFJNCA0FhRHIwLQq8SQyGaa3h3Z1VFFIXDCB1ni5m5/ktxOnTNUsPNlk0MMB0OjqSXhqvcysMModAfi89a9tHhhb0CLCjjbBlz0IiRsoWOz+uQQKrj8BxkQ3p6oX8xt9k82x+esOQL35nIFwGmRzZP7iiSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUJvdkfPunVHCgVtDRTInarrj617IoJLVrVU/fIUy/4=;
 b=v5ELyFe8WlJKnUKZcB7Vdj01pDbwAlxbo9FiAtbaX9eBjMkwqRduxnEYIEUw0PoxT1E64cmsNIbIy412YAIxJVpO1LmBAwakv8XwWbB5Lwz0ADgkMyIym1bM38kDmKWUvXluyvl3GcBHzizvxAQsxa/fMCyBt6WM952aVIaEOJEMdgf/Udd/nHVX4SLDqLmf6DPRoNyj2UdhbF1Xs/gB9wnBdw99Z7xZ4aZE6mlx8FtN17N5ebATlo/lnQYYNc8IC2qXmEMGNizqmTDStiRYcDctWk0ACUzMLxM8VJygPdhKGtr4UynL2nS4qZuUQ+8rYMlIwpejBnDfhWx/lpe7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUJvdkfPunVHCgVtDRTInarrj617IoJLVrVU/fIUy/4=;
 b=j3azFOnyIfcaiT1Ywvq3p3maoHQoTJC/4Xp3M81RQZpoIrhBnbRjDQ4Fa5D8AHQrf8LzsgCytL5wUqeS+zohrNl+i/UnFnKL5FjrGeFRVHML2Lu4kAR06UFELedBdgwjKtN5nEYyzK/I3OGyMkLC6nk7DyamaOJNFCDVV7AVpag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:51:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 09:51:37 +0000
Message-ID: <630ec47b-ba04-411d-bde0-4fea6d40a508@amd.com>
Date: Tue, 16 Jun 2026 11:51:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clean up discovery and preempt sysfs
 entries on shutdown
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
 <20260616091444.25605-1-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260616091444.25605-1-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:208:32d::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8ac4e1-4456-4d3b-1a53-08decb8cdbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L2eV+4OIHyV7vW7xewUSPoGyF358kC6c2BEqI6WzJ4v+D58GLfA7eO5cpDSRWLTlOTL8D04+ysc/X6t3qZ5HTGKs4K4EnWaavsB3UI7Hi9bgBPK1kwAVysd257E79eSReFV9WKSfQ4xoHrw2j42M/OjvYlu2ntuDzRD23oSiVBMsxl0YSPgcbg669DKQ6Qrg2wsodJiOMjVxaczIt70zu1j21eJVHB+acIxyOw9xBUUjGaiyh6q/cLOm1OpOdtcC9Bq3DKa6zRCe29MDxEKzzQ0e7bem1Psd0proK/do7G+gBax+jACXRCT4WyLE3pRJTFly+8I4LWZqUzD//Qg56tgXIHvpgFsSfMP7i5w0icG7Vc5DOF1fwvIyuyaZmkLVzwUG8cYDjLX8Y3XVf5WLu0yky5rS+3Kp1dzei4tHbhpoyOVQBmd1YzwsPAfBIXL6+9gQbEA5h8YktzB2Tn+S5RmGL33W2Lxty9CYfA9iP9S1w0tpsB2BbxoUu8YapBNk/XYYB960IeAqrGLOaSy+a7RbNTpbF5dD4JxryFc4jm9NoD4DZ0E4BTuskrxlcjlg4KesImCMlo8hTgiu8C9UYEdK7QRpBVpjKGqqj3Ng0WhllWTeTrcdlT5cEW1r+46SqQbOj66NhihUw1CtddezkeYVGtD0KpJserGK2rRUDLx45qA/mNRZMhn5y8t5Vpbo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW54THkzaDZLNkwwUFNlNnVlMlQ2eG1MM2VFWHJpb1poZzNTZG0xTXU3SjJO?=
 =?utf-8?B?a2d2UlJXNUMrYWQ1blczNlFxUm5SMGNqdE9yazhqM2IvaWNBa3lLbkhQUER1?=
 =?utf-8?B?c2VKSmFNZnN2aEtqZFVMcUJoQWxUeVlnL2x4MHZBM0lnV0ttVXNyZ3dna3Zx?=
 =?utf-8?B?SGwzMjNDVHpYSTVNaVhRem9xNklXb0FSVTJjc0pkUXAvSzVMQ0grZWlsbG9R?=
 =?utf-8?B?bDNyWjd2cktBSnB0TlhxWGxET04xZjRpR01Tci91OHVjZi9LNzJNMUVUTUpG?=
 =?utf-8?B?bVF3QmxZMVNtMzlUeFpRc1VhNTNmT0tiVGRoNUN4T2FtZDVTV0dReFd2Qk1o?=
 =?utf-8?B?dWZNYUR0alJkcnhHaS9HczM1bVBFZ2hSTVFOYlIvQ2NLaGxma2dpcDJYQW91?=
 =?utf-8?B?ZWo4dk8zUXRPSU0xNHcrQ2JQL3dJOXJnZ1dYV2Y3UkQ2RDZXMlgwc3R0Z2JY?=
 =?utf-8?B?bXVtd285YXBtYTVYZ3BWVlNQQm1NVmE5b0hZWXZRbE1SUTB5K2x6Znk2RGVO?=
 =?utf-8?B?YVM1Q1Nvb2NkeVltbHpiQVY0Ykt2S1JOeWxCemRMUzEvZDJPSmZnc0NRemV5?=
 =?utf-8?B?RlBrVDd3ZDJSZUhPd0oxTm9SWVJpU09wMFVKTXlwaXVBNzB4OFoxc0d0Njlz?=
 =?utf-8?B?U2orc2lrMzUva1dMNVNLV3h5UjVDZ3lNNzR1a2dlamVHT1VzNFNlVUpobXNM?=
 =?utf-8?B?bFc5OFNxVzJYVlRzOU40SjZsTlBiaFpyVUw2amVJdktXQklLVExxOUpnTWZI?=
 =?utf-8?B?ZitGUE5aNjJoSjB4Ym1GZGxwZ253WjVXblIxb1BIZjl3RG1adnFqNHBtNjlV?=
 =?utf-8?B?eEFKcTNOb3hNTDNTbjFTYUtpMlFXUTBleTBRY0pGZU16cXcySkZwckxmWXlS?=
 =?utf-8?B?b2xEZGFKdjFMRjFNMXpoSUF1UTEvOWxHL04zRFQ1bDBnbGMvSXljUUFsL3ZH?=
 =?utf-8?B?VDFwdWJ5QldaU1N4L0FiN2E2SlZIUVBJVG9kVUE3ekpXREd1bzd6TEZyVDZX?=
 =?utf-8?B?UmFNV3VsaGZudmpvb1lLTTRGdGZhUE5uQkhNR2JYODFicTBUSHB4YUh2ZS96?=
 =?utf-8?B?V0lURGFpcU42aXFCN0VQVFEyNlVDejkvUkNHR0xNZFE3K05IeUw0bEpvcGxq?=
 =?utf-8?B?VnFaZk00RzVVbVRDWVpjakRtUFVFV0lvUTNnVlhpZUJiaXdhc0hSZXRmYVJF?=
 =?utf-8?B?VEdtK2lUU3BuSDlyNXJMK2FCQUtTVHl1SWNSMytsN3BGeXhaMUs4SkJMNlJT?=
 =?utf-8?B?RUxSaHFqL1AvNHJXaXdTVVJlem10M21QaFdEZCtrV09nM09yQW8rUFU2NHd1?=
 =?utf-8?B?b3dma0NLdm14WDJlSEJ2Z3ZEL1BqUUtVbGdrVmpKQXV0cG84YlVWcWluRlg4?=
 =?utf-8?B?U3crUnFuNVJKdnVzWGRsYklhWEFyT3JtRURuOGhpVzhpV2FNUVRMMlBkdHRW?=
 =?utf-8?B?WFJkaCtIaEJOdXBMS21iSm5MZytyREluZlM5MDUzMm5HUlhWbDNHRE5lVUxl?=
 =?utf-8?B?V0hBYnFGdEJmWmQ2bzFrajlrSUUrUENNbFMzd0hoaFp2eXdIQU5xbVhTRkdi?=
 =?utf-8?B?a21pQ0dqdmR0Zmd4cnIwQ21BamtQTjRYWktqUFV3UElJQXd5SS8ybXA5ME93?=
 =?utf-8?B?NkNZTDFzTG56am90U2tmejVYSFZsOWZEcnRoeVpKalNzTEw1dHRRVmJIZ3Ix?=
 =?utf-8?B?cVdKbldhaFhZWWZBQzR0M09NWmd5SDE1YzRhOGh4bmNvTFdLeGt3eFM1Yzdo?=
 =?utf-8?B?MVdJMXFWYnRVYmNBd3ZLOGlsY2RlN1RGMkc1bUZ0SGVsa0RmYkF1d3Vyd2to?=
 =?utf-8?B?Q3luKzZtQld4QXBjek52ak5ZNWpoMmNMbUMvQ0ZDbGw0MCtYd25VdVE1bmlm?=
 =?utf-8?B?UTNEajFDTk9mWWNLRy9UY3I0NU1LOHpGTDZXdEMzQnprOFg5cnl4ejdNN1Zy?=
 =?utf-8?B?b2Yvb1BybUxYVDRRRE9sVEVpNVFWV2JBSmE0dGRqYi9JRG04cWRmUlBGZjBJ?=
 =?utf-8?B?YXdlK0ZKTmRhYlNURVFwMEdPM3ZDa0trS2hkKy9JSXVxTnJKWkxocW5hWmEw?=
 =?utf-8?B?bmVZdFN3cFNGemJVVW1LR3doMXNjYzM5RmZDZ09xWjgrV2RnS3NSYWI3Z2tV?=
 =?utf-8?B?ZzR6RVZzYXNKcVppcjRUNXdUeU9FaTdxRGZ6Qk9SNEZMdnIrM1JRMGxZQjFF?=
 =?utf-8?B?ZmdNUExDU3FSczVuaFB1YXNoMzJWZjF6d1J4eXdIOXF4eElJVCtZQnpkbFYw?=
 =?utf-8?B?QktVRGhqRWorVGxYUzhuUDRKYUhRdWtMQWhsSzJuSS9ZQzVHbHFtbFNaQU9m?=
 =?utf-8?Q?kMebKSOPciQ8G9PkjX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8ac4e1-4456-4d3b-1a53-08decb8cdbcd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:51:37.8724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S8pTfZyxjW6+91AXSMiYsn2YCgSTGfoOhqIb/rCzD0Z7Oa13FqC9+XJRTZzcMCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

On 6/16/26 11:14, Geoffrey McRae wrote:
> From: geomcrae_amdeng <geoffrey.mcrae@amd.com>
> 
> Fix a sysfs duplication error when reinitializing the device:
> 
>   sysfs: cannot create duplicate filename '.../ip_discovery'
>   kobject_add_internal failed for ip_discovery with -EEXIST
>   ...
>   Failed to create device file mem_info_preempt_used (-17)
> 
> The failure is caused by stale sysfs entries not being removed during
> device teardown, leading to -EEXIST when the driver is reprobed. In
> particular:
> 
> - amdgpu_discovery sysfs kobjects were not fully torn down early enough,
>   and ip_top remained non-NULL after cleanup
> - the preempt manager sysfs attribute was removed only conditionally
>   and not during the common hw fini path
> 
> Fix this by:
> - making amdgpu_discovery_sysfs_fini() externally visible and clearing
>   adev->discovery.ip_top to prevent reuse
> - calling amdgpu_discovery_sysfs_fini() and
>   amdgpu_preempt_mgr_sysfs_fini() from
>   amdgpu_device_sys_interface_fini()
> 
> This ensures sysfs state is fully cleaned up before reprobe and avoids
> duplicate kobject/file creation.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: geomcrae_amdeng <geoffrey.mcrae@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c   |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 14 +++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 +
>  5 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 91f2506b9529..e72924976994 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3678,6 +3678,10 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
>  		amdgpu_pm_sysfs_fini(adev);
>  	if (adev->ucode_sysfs_en)
>  		amdgpu_ucode_sysfs_fini(adev);
> +
> +	amdgpu_discovery_sysfs_fini(adev);
> +	amdgpu_preempt_mgr_sysfs_fini(adev);
> +
>  	amdgpu_device_attr_sysfs_fini(adev);
>  	amdgpu_fru_sysfs_fini(adev);
>  
> @@ -4211,6 +4215,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  
>  	if (adev->mman.initialized)
>  		drain_workqueue(adev->mman.bdev.wq);
> +
>  	adev->shutdown = true;
>  
>  	unregister_pm_notifier(&adev->pm_nb);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 0c51e0fead40..a229fe9d043b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -759,8 +759,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
> -
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>  	if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone_mode)
> @@ -1483,7 +1481,7 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
>  	kobject_put(&ip_die_entry->ip_kset.kobj);
>  }
>  
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  {
>  	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
>  	struct list_head *el, *tmp;
> @@ -1492,6 +1490,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  	if (!ip_top)
>  		return;
>  
> +	adev->discovery.ip_top = NULL;
>  	die_kset = &ip_top->die_kset;
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index edc78184e0f3..5b2b16f68576 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -41,6 +41,7 @@ struct amdgpu_discovery_info {
>  	bool reserve_tmr;
>  };
>  
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 34b5e22b44e5..37ef5b9eb1cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -46,6 +46,17 @@ static ssize_t mem_info_preempt_used_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(mem_info_preempt_used);
>  
> +/**
> + * amdgpu_preempt_mgr_sysfs_fini - remove PREEMPT manager sysfs attributes
> + *
> + * @adev: amdgpu_device pointer
> + */
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	if (adev->dev->kobj.sd)
> +		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +}
> +
>  /**
>   * amdgpu_preempt_mgr_new - allocate a new node
>   *
> @@ -137,9 +148,6 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>  	if (ret)
>  		return;
>  
> -	if (adev->dev->kobj.sd)
> -		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> -
>  	ttm_resource_manager_cleanup(man);
>  	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2d72fa217274..00acec7226f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,6 +140,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);
>  void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
>  int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev);
>  int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  

