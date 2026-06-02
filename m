Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D24CD6E60
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 12:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151F210F098;
	Tue,  2 Jun 2026 12:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHIUO4M5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDCE10F098
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 12:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+Hrzk1Stxhk5GG5wKGwzauKz3QC/dziOIhCeQ/DXIBegfttW0gaTyvIhRneZsNegwGMajv2Qs9uSKYaRDb5zZKQBeoeMDttcUUCxjrQ4GWAIgfc4SHPt43bvD/F5DOElsOB4OtZi6LflMZyBABygkpSFuwstVpq69gzCmHj4nCy9u0Qxgzv8qFFtpb3Zld/KcyzqJWfGJkxw0mxBkb2GB7MCpr0NMoS5iGpjAUk9Qd3AkArmUTUHReKft3JYVQoDdyS9oMkn7vrkex+TRPFU7GCckt2qZlKH9Ry9AK2FzyD/JhX1goTI7rdxUWNzCTLvpJWVH+KIys2iCgkCoAREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WqQKMLMisWq4a8/1ChRqTBgk9MMRlJhSwQTcUQTiZo=;
 b=lu1qii0pbzIgVsu6dzYMJwml8vahBKYZwIyJyrn+h/Ok3rsWZaa1CJaEpfipyQLloXDPlU//fmZOVa3md7bc+hNd2SCpE8BqOk7Tsawk1h0l9moBMGcdB7d9Zy+rMKJjw+3okFRKxOxJFEFfxC+u9x8UuUlYfjzZncXg4JFpZyMLQ9ULx5zSfOaLc41jlrPAp8FQ424YE5jX7UjbRjk37Qoc1LRrIOeFq4jHO5wb6zQkM7hL6x7qrmuIXBIw9YBkBzKi+WfKh+1/lp8C4C6JxiP+A2jtk9UpY1N9oD6eJKe/4yaMOPAyXbRkWS9wptJmxfNoMkOeo+wCwv2gT8vRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WqQKMLMisWq4a8/1ChRqTBgk9MMRlJhSwQTcUQTiZo=;
 b=pHIUO4M5dLYYnkV6xvy1I24LpvxskUVV2NhC4Z21qcQtz4NEAjyI6ioUwltGjPjpK6LBEq+zghHzMZ0lyR92xs/NjKmHZxl/B7ObxPOGxbhg52FvlMkPfxq3xa861bsX2zKAAtvmwsD6CrgsMaAR6KqdoUd5AbRctZffn2WgD7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:58:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 12:58:55 +0000
Message-ID: <27c01d6b-b54a-431b-845f-7ec17be4730b@amd.com>
Date: Tue, 2 Jun 2026 18:28:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
To: "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20260529061607.356352-1-asad.kamal@amd.com>
 <DM4PR12MB503864C2971265F7305041058E122@DM4PR12MB5038.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB503864C2971265F7305041058E122@DM4PR12MB5038.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7f519e-200c-40dd-f5a5-08dec0a6b3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1ph5pAAKOAiDRayvBRT7PLT7tgStE1wnBIEHUKC9NkSjMzulVqWv9wVWrPxS0c8Y4em88x7nUWiQtMR89iPjP/o44FbaKa2LP2OXiHJAw0ATRVPh6XdsMAl9dHHEiLzwgXxNLu/aoBI5luO9gjD/BaI//JPsjlqIKvG6oyG3Ls5G3DuyJZLobv/vFzQYPoCvwgVSJaaU1P7NC2C6nmV2pRv+apszaSIM9+2JVQSlF/ZGAzB6hRAre/4GtqeLMoYYzt8y5nTYa7me/PPm4g2EKCdSWUelcbFxilZF2eYqCz/+mp/N5c5C94b5mwuo8UySvn9pXYleosuuce9HQIyhMD4u/wsQXcVcVpJh1nEUS8IUxZPv0p9MHkzRDH8apktL59V0nSDPYjCL0/KrAasBaUCXlfZwWUFTLC3dW5Gi9FV/zdcgH+laBkYbAMvhehDCZt5Hi9Iobn2Z6GGljkpNiPj9qMOcPoNHsP/y/Sv+EWVaRA2yw61gQ0X2cQ1tJeDO6oRtmR0BOZeQXHz7gsfIjoeTWH3czqUcaoOYNBzDy4N7V7P86CJkj9MxPD+iiZ29lOeqvHXyPH0/j65Tiyp8G0N4fDlIGigCPZpoLNmnizId+AyQzOjdL/YHcfRwmjHtN0J2a3i+BolYTkfGD2epAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdlZXozbmJUZTgxOVNUbHJWQ0duQXd5ODFTMDZ4UFFndHJtNFlXRFMzVDR0?=
 =?utf-8?B?cHdNQXUvY0doTUhrVXhpbkgvVjFMcVdLeWxEbWVvZERwZHBKS0Zia09GdDE3?=
 =?utf-8?B?TWxKRUtNbGhnRmtidno4L2ZkZ3M5cHlTQ1BHU2Q2bE5NZEt2ZFdzUGc3ci9z?=
 =?utf-8?B?bmN4bDdneXl6emVTYjFQdDZyTVpaVDVZODY2c1VxdE5jbjF0RDZmM3VoUVRo?=
 =?utf-8?B?NDRQQytkWGtuK2Z3T1Npams0ajE2S0I5KzJ3SE9UMTVqM1Z3ZngrMy9rOEk0?=
 =?utf-8?B?VEhVQUgvYWh4eHpaaHhyK0RZaHdBUlRLUkx1dElFUjVYc0ZLSDc5K0tCUXRp?=
 =?utf-8?B?SFpMOUNVdWR2cnFBOU5TVjdmV0xmR3Q0cU1KVGFPVjBDZ015WjRmUC9QYTBp?=
 =?utf-8?B?SzVyNVBHY1BlbWc2dC9HbERsaUtXVUViNnNYZDdGcTQzQklkMlBlUnBLRDN6?=
 =?utf-8?B?elVCOTNlNFdGRjZZNEVmSjE2bjhLUHR4Z1pvZTRYMDBVcEtQalNMQnd4Qjho?=
 =?utf-8?B?eTlsbXZlN3Y4UHlieWxXMHMzamNPMzEyQlhOTURIa3BCUmFlQzBlMVQ4WUcz?=
 =?utf-8?B?WWt2RXBmN1BVVGN5V2xJL3BCMUtHdlpRQmVYSlRqamFPanVLNVF4aVpZVEFp?=
 =?utf-8?B?NmNpTCtPTjJNRy8xR2VzYXp5SUgvZ1lmalBLZ3pBQThmcHhSNGtEaGFseDM4?=
 =?utf-8?B?M2RrWkFsVzBVWm5nMHB6dk1XV3RPaC90RzhpeXhPVnVHSjZrakhPejREYmIz?=
 =?utf-8?B?WFYvaTRYU21FRkVjY1Z0UGRubzdnY3lvZjNDODJ4Z1UzYm9aUHBLVUJhQmdI?=
 =?utf-8?B?bElsNHl4VU1uVFJSaEsydU1rYW10cGNzRWNwVGZpR0lyTWg2Q25oU0hUYlEz?=
 =?utf-8?B?WFpEbDhmRXRydFJBRTlxeitSeHlCR1MyTy9CdVB1WS9Hb080YjB3Umh3eUc4?=
 =?utf-8?B?bEI1Q2JIdnZ6TlF2N0pPbCswejc1WmFFTlRqWmpNQ3FxcTc4UHZqVW9wcVEz?=
 =?utf-8?B?QkZiNXVDZ1NTT0t6YkNFV2ZzMjViSnZybjRjcGFWZUV2QVBqSjA5L1JwcFhW?=
 =?utf-8?B?S3dYNEo0Y1JRZXhRcGhnQ3NVQlF6WWUwVDZCbHBzZDgzc3g5RGNIdDh2a0lQ?=
 =?utf-8?B?YVpBaTB6NWluTEtHMU5SUEtadU9YMWxSY1VOVmtlejlhOEVpUFZqYlVpcUJ2?=
 =?utf-8?B?OVR3SzRZdE04U2hYNTk1Vm9xOXhoc3MvMCsyWURVd3VjaGxjYmMzNVQwQkt6?=
 =?utf-8?B?YnBlc1YzRTgzYmgyUGwvN1grOXdMTEY3M2NPUy9FNkN5SmxVOUU3N0gxdHJZ?=
 =?utf-8?B?UWZZam5seEJneU1tb2VGM1JSVFo5TlZWWlNvcENXclBYOHVjdlVGQkFCdXQ1?=
 =?utf-8?B?K3VpZERQV1lNakN4cmpjalFRZG9Rc3YvTjhmbExEalNKcHQzWm1YcVdYTEVN?=
 =?utf-8?B?UlB5U3V6UDdEV1FaT1BweEwxQWtPdkRRK3NOS1dCcFRGVnlTQ1JETnRmZkRX?=
 =?utf-8?B?bWtnSThqMitTd1IxUEZkRjRPa2E5dTRjOEc5UlNzYWJmY3JwQ0wrQUhCd1Uz?=
 =?utf-8?B?bE9BeVh4cU8zaUxTU3ZqZE5STXVTTGkxVE0xNEtHeHJXaUJHUmc2bEVnckhD?=
 =?utf-8?B?aS9mak1zeHV3MlJ5ZWhPbTJmMDNVcW9UOEhReHAyODRYcjVVejUvejJSMGgw?=
 =?utf-8?B?cU5OclFaY0ZBWldmVlUrdDl0U1VrMW1VOFVudmlwYktHeDByVWJtL3c5SHVC?=
 =?utf-8?B?c1hQeVNNREpFRCtqMFl4YU8zRm9SNEEvbDZaVUpaUVdVbjg2M2dyckE4ZWlW?=
 =?utf-8?B?U2tlL3JldXlzMzhoQTIydjRaK2d4K1c5RUtXMXVHWUo4UUs3eitkOUVVTFZq?=
 =?utf-8?B?UjFYck1EMGZwQ0o0dm5SQ3lKK1NZU1JrMFc3cjV1THhLc2RGZXFaRnJ0bVhT?=
 =?utf-8?B?MjAyV0Z3Wis2TG5lQWoxUk5FZCtSeEh1ZTlEM1ZzZ0lQNVl0SzZnRllUY3Jq?=
 =?utf-8?B?MjJFSFVjVkpKUVhzeWFveUM1N2pEa1VwaTBEa2cvWlN3WTFuMmpmSUJoYUky?=
 =?utf-8?B?UDh0ZC9hRlExazlYcFpneGp6UU1NOUpHakVtTGgySU4rT0hHL0NMZHNzSDRy?=
 =?utf-8?B?ZzRWRzJ1SzRua0wxRG5MSFJ6VVFMeURXZ0ZoejV0d3V5RVA2MlhxTnZ3bFEw?=
 =?utf-8?B?U0V0SWZCS1plQXJSNFBscnFETlpneVNPbFFiS2RXVEIyRDJBUTJEM0lLMVhH?=
 =?utf-8?B?RDFjVnpJOVo0YnhIamprcWRlOXZFY2swcWNKRFVTeFY2Z05SdEpkeTNJZHgr?=
 =?utf-8?Q?inzTV7VYRwewfuKNAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7f519e-200c-40dd-f5a5-08dec0a6b3ff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:58:55.4019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAwm4qYKVaHCHm3wKYPf98BHkiH7EzkWZAQqPmNxoMrFYx+qaf1gmGpPsdZBzJZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

Should the check be consistent?  -

https://patchwork.freedesktop.org/patch/728769/?series=167435&rev=1

Thanks,
Lijo

On 02-Jun-26 5:32 PM, Kamal, Asad wrote:
> AMD General
> 
> ping
> 
> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 11:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
> 
> amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary MMIO read/write via RREG32/WREG32 without checking security_locked_down().
> On kernel_lockdown=integrity systems this bypasses the same restrictions as /dev/mem and PCI config space sysfs.
> 
> Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every debugfs handler that performs direct register access.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 58 +++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0ce6e2e4342c..c1f22b0985d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -25,6 +25,7 @@
> 
>   #include <linux/kthread.h>
>   #include <linux/pci.h>
> +#include <linux/security.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> 
> @@ -43,6 +44,11 @@
> 
>   #if defined(CONFIG_DEBUG_FS)
> 
> +static int amdgpu_debugfs_lockdown_mmio(void)
> +{
> +       return security_locked_down(LOCKDOWN_PCI_ACCESS);
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -86,6 +92,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>                          ((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          /* are we reading registers for which a PG lock is necessary? */
>          pm_pg_lock = (*pos >> 23) & 1;
> 
> @@ -237,6 +247,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>          if (size & 0x3 || offset & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -402,6 +416,10 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
>          if (size > 4096 || size & 0x3 || *pos & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -521,6 +539,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>          if (size & 0x3 || *pos & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -580,6 +602,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>          if (size & 0x3 || *pos & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -635,6 +661,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
>          if (size & 0x7 || *pos & 0x7)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -687,6 +717,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __use
>          if (size & 0x7 || *pos & 0x7)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -746,6 +780,10 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>          if (!adev->reg.didt.rreg)
>                  return -EOPNOTSUPP;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -804,6 +842,10 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>          if (!adev->reg.didt.wreg)
>                  return -EOPNOTSUPP;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -863,6 +905,10 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>          if (size & 0x3 || *pos & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -921,6 +967,10 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>          if (size & 0x3 || *pos & 0x3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>          if (r < 0) {
>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -1156,6 +1206,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>          if (size & 3 || *pos & 3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          /* decode offset */
>          offset = (*pos & GENMASK_ULL(6, 0));
>          se = (*pos & GENMASK_ULL(14, 7)) >> 7; @@ -1247,6 +1301,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>          if (size > 4096 || size & 3 || *pos & 3)
>                  return -EINVAL;
> 
> +       r = amdgpu_debugfs_lockdown_mmio();
> +       if (r)
> +               return r;
> +
>          /* decode offset */
>          offset = (*pos & GENMASK_ULL(11, 0)) >> 2;
>          se = (*pos & GENMASK_ULL(19, 12)) >> 12;
> --
> 2.46.0
> 

