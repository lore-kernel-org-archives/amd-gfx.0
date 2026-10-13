Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A242CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D5910E73F;
	Tue, 13 Oct 2026 07:18:51 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BED10E73F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHvXX19DlHF3Kpiu7sQhflh8oai6MnIYHtmb4RPm9YxHUsBNrahSYXUXvM945iGP5evJHqXtrLMHBuYCxtmKF4oAO0qubJhqcF1peUjPYfS/J7NDMiCGzhsfL1nLwojyRkAqZRt9mum8POJ6l+TLfMQHEFJADgMcUfM5j0iI98OpjD+hz4C29dFZJYU/fBPjHjv7RmDa55tCeR0+24sBVpwPEJ5GMN9P+AaPxd0aT6EP7qOCm8RQI4qIedZoIifjizt7tvrx9cmQ3L9EIKjzPPBRA1QW6hY3GvM3hrj5sbufBPtFqHg6P1ucNz+LoJIPkPXgziXWax6mLmPnfhC3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbbr4sgG4/8x0NvhgGBTFseuW3PzK7+b8KDjZjvHgSo=;
 b=RTHl/bifDORbLdhXhdpLGNRFE0yK4H0oAf7/F9PjZNgKTxgz8XKOezvz4kWLIBGu5YKFCTgpTyuauWeRoXiibq5s6tsOBXeUv6BP/8HbkpzKAAfo1Hsyif8otkj1O+tHaqhdOUfEPMeQ+Q6eZDC1FMZqj1khu3Bzf5UHmGvCnmFmqJSjJWn2NYndLqJevGTkK9SjpcFwKT/1cs6BrrCXn9rzFORfMgh/pYlLY6WVb+j8+v5v1tavUI8nKJigR1GrBiGy58kK95PD0l+0CRPabDSH684zC4x+2ZZI7k+gcNSSDmetjxGEr7BW4MVfNak6y+KH/DVsZF6ApKHGOaMOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbbr4sgG4/8x0NvhgGBTFseuW3PzK7+b8KDjZjvHgSo=;
 b=O9OuszWwOhc0OsqhO7ryWR+3jKKXqKWH/uNcUOylJA4e5Z9VshJvJ+DluvWBePRAklSG7AL17Ht+l0n3qWuCGbv6uvDPfZT1i9i9tktjdsxAZUGiFeOpgN8nDV3HbJ7FqfyPDKrb1fhokKwKn2cJM3Jzsr2FU4Nppu3vxdNNtkI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CHBPR12MB047581.namprd12.prod.outlook.com (2603:10b6:610:369::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:18:42 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:18:42 +0000
Message-ID: <d7e487e2-2b15-4bb1-a216-f7f4a54e64ef@amd.com>
Date: Tue, 13 Oct 2026 09:18:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] drm/amdgpu: reserve SPM VMID on gfx7
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CHBPR12MB047581:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b7e5c1-f1c9-4b73-1363-08df28fa35b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cCqXdveYsYkgXzzLkDSO88acBp0ELhQMTs9Er6PLAxNLlfKJ4RvDMuUjZGtqPu8kCi0HGWrbwLyd/SOatnnIdvb4nYvDaMCUnO8NVamjFE6NqhnH08VEKbMR4T+4+NUfxgw0IyaaGmTz34AcJWoASJERozfH9O7wo0fU6EWLCu/S7Zqnd6tRGSd1Iu4yJ/DeBle1vgwG+YeissA/S+Vm56drOhrRnvh3+3AlF0s+AiIxz1Wa5J436IEWpXu00Y4wFPgxM0GeuzXqZkNkpSZ18zozaiG2O0fyD9cdIvvLkHBPbDPQ2n+5Z1cM/ByD6PEJ31WkTkN++i6hEIemIaQavysLZX0zGEKNik7Zls6I3OVP9SUvf85LygQGdzRBwTSpKKGy2/1/kOkGPQh23VR36EJfElZe1VfD5g+z8b/w2T/mxXMZI54xUwofW9NtBtktHsH0WUKj6N/LuAx4TJsqZVycN7pOS5OogIZxnupdTJr2Q8XZVSBY2+c4/cS073T0wB+C14sXIawHRP6yZmdwIF+q3cl4IsocinyaYzy6kSIeis0hwSyvh9pFumUo4YJvTtOb500ya/xNVaAmr+Q1xwMtQxW0l0V9MVNo4rPFtxFJiNCLsamv3rlbXqYpX0aG5vynfEtxfTcXY3bhjYpOErmVEvGVjgqea+OGY6OjJHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjI1ZGwrSnNHRjhWS0I4aVBXQ0FKR25lY3NuQUVZazdQWE5tSlpFQ05vaHhq?=
 =?utf-8?B?QlMwVE5JY1VGT0p5dVpLRUhSSFJha0pmaTllSjFZSVRDR1RBalBaYmxWUnc1?=
 =?utf-8?B?ZGpmU2FFZHB1TEVYR3c5d0N2WXRobVlSdFRjOERIMmhReUYrNjZWN05uWmVv?=
 =?utf-8?B?TUlBejduMjkxRFBremdrUFI3eXJJTFRkM2dBN2U2VFM2M0VsUWlQVi91aVF4?=
 =?utf-8?B?UU4vMnlJZGgwcFZqTkdOMVAwU0NVMHFxRTJrS3BXZFBsUTIzei9TUnR4a3Yx?=
 =?utf-8?B?VXhQc3I1V1QxelVxTlV0bVNNOC9uL2hhUHpyYnhsVEJJWTZSdE1XMTE4ZFd1?=
 =?utf-8?B?NXpQd3RTNnFBK1Y0YmV6NzM4WHVwWUhyMFRVRzhodklyYzN4WDdySlREZllo?=
 =?utf-8?B?M2pGOE1ZZk93akpETzVrKzJueGFFdGpXU3BpRzd4Q3dDSi9XbEhWT1BDdldV?=
 =?utf-8?B?Z0xlSzJ1L3l1RUZPM05sb3k2cklTVlU3VnZsU3ZqeEliRW5BeEtabHJYZ3Q1?=
 =?utf-8?B?VXpkMHg2bmdpbjF3NTVDOUtFN3RWWUJZNXFDVEJ6SUVhR0VOUEpwVG0zMGp4?=
 =?utf-8?B?TnF4aFJPVVk5TFM3ZktwaDJnNTZ1L0MwUHo2Y0JYRDEydnhiNXR2SE12dzRD?=
 =?utf-8?B?UFNjbVJWSUxhRWgzMHRnWUhPZVFVYkRQNlNlQ09GeGNZMlMzQ1F4RHBrdVV3?=
 =?utf-8?B?VE1ma3MxVzNuUUV2UlprcDI2bEs4ejJVNVJ0VGszS3RHeVl3ZUgyOERYYkls?=
 =?utf-8?B?Q0hQMXhNcWVWa1F5VlpJdXMzUkJiZnJBOEkvdnhCRlRMaWxaQWg3WVlHa01v?=
 =?utf-8?B?VW5LNnpnWVNubjhyY20ybGpxN0tYeXRDQ0NMZ1VvaHp4L1Z5ZmxsYkFJb0pS?=
 =?utf-8?B?NTJDNmQ1b2l6Rm1EMElYWFBMNW11L0daZWhJTE5kWGNoV2R0c1pmd01JdFpU?=
 =?utf-8?B?S2ttU0gyOVdkeStjWWpBejRxcTIxMXltODVxK1Rza2FOSlRncm9UWGlFQU1Q?=
 =?utf-8?B?d1lPUnI3WnFiUWcwQXRqQ3BQemc2cGliQmRqTjBzOVJPVHRCT1VsQVg0aFor?=
 =?utf-8?B?VmRra0VFbnBRTWx3WHZ6ZVN3cmJSOWFZcmp4SWNWK1hyM0NSSVJuWk5KMnB6?=
 =?utf-8?B?QkpCUnpkM1JvTzNFd0UyOU13R2tPSUxIVXEyNG5ZZlppMGY5Y2thcm0yOGN3?=
 =?utf-8?B?ZE5LUVRIaXB0OHhzRkpjMURkUmVWYXdlSWxWVmR4eTd6VmkzOHRmd1I1NndO?=
 =?utf-8?B?cTRDTmd3NmVPTnFtT1dTWFNBdndTQWtXMTF5KzE5VHd3QzQ5QTM3UU1qemhV?=
 =?utf-8?B?SUI5ZlZhWTUrLzU2QXJuY0NkdEoyOWVZRVdDWHJvTlhMMGdaRklYM2xwUnow?=
 =?utf-8?B?S3o4Z1hyczhyRXQ5KzJFR0J5c0dFSEU3ZWNDY1hPNUJ5cy84M1pwb0Q3OWJw?=
 =?utf-8?B?Q2VoYys4WGhkVDJpTnpCL1l3Q2Z1RmcwOWdiSyttN0JxU2tNSjZCdVYzcHRO?=
 =?utf-8?B?QzI0U0FCdFFLNmQ5RVhuWW9PUnJrUnE4bUhtcFFBcFovbFBndkZXb05XWmp4?=
 =?utf-8?B?azV5dXovN1lQZ0IxTE1DM0w0Szd3RmNpK04rVkg4c0JwS0NmSDZOd3p0L1Nl?=
 =?utf-8?B?dnkxb09VVFFyNnFRU3F1NTNaa2xncUJ1NzFZM0V5S0paYzUrOFdkUllHYUZ5?=
 =?utf-8?B?ZjdWUUZXelVqWWpmaXhOM1U2SFhyeE1XQm5pOTlrYUthWHg2TlJ1WmlBT0Fu?=
 =?utf-8?B?ZWhEZzJHcG1JVXE2Y1NkZFBPSTBlTlNLRHRIa1VCMzV0R0ExdjdHNU9qYnJi?=
 =?utf-8?B?UHQwdnlDR1FUUWo0Nzc2VFVHS3pZZ0NlVThtV1o5TXA2SVpoaDBZRVkzazQ5?=
 =?utf-8?B?NGNneEhOaWtlcEUrcjFpSmhJUVcybmVWMnQxT0czbEM1czhvdUkrN3dpMDM3?=
 =?utf-8?B?WWtDWHRaaFdZQTNBNFNPWVZBT2ZKNXg1SGFWbUF4dHQvdmhJZGpwd0tmbzMz?=
 =?utf-8?B?alExNCtXSG5WYytUc3FiRzB3VHlUeEdnakJ2eG1XM0dVNWtNMmdLVC9LcnNq?=
 =?utf-8?B?TmtDRXdtWUZZbm53b3Y4MmxlbURQUGtjWUUwNFdtN0RRa2lmNHBESWx4ck8x?=
 =?utf-8?B?ZkdXRmI5Lzc3ZW5LbjhUZmd6K2gzTjNlODZvRkRVZ1BPOGVqUDhycFA0d0JS?=
 =?utf-8?B?czJNb2VmMzBhNC9aOERJQ1hBK1hScTk3d0tDUytwSFNBREkzZnF2L2ZRYnRu?=
 =?utf-8?B?S1pqQ2dpL3h6c0tjeWR5Y1NlS1IxRHpEOUF1dm9QVnNTaGk3VndNRmloZHhS?=
 =?utf-8?Q?YCDvWqNPmeyaF1451r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b7e5c1-f1c9-4b73-1363-08df28fa35b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:18:42.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT88vf4HMaW2sXoQCLcFOrgmBF3ApmWTxlayGhMV0dpTTcjlgzJ+Vkj1DLxWkB8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB047581
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

On 10/12/26 11:24, Sunil Khatri wrote:
> Set vm_manager.spm_vmid to the top GFXHUB VMID so the SPM reservation
> path hands out a fixed, isolated VMID on gfx7 instead of borrowing one
> from the graphics pool.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Patches #4-#9 are Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 4199300eab177..c09f5153679ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1008,6 +1008,10 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
>  	vmid_mask = GENMASK(7, 1);
> +
> +	/* Reserve the last VMID for SPM */
> +	adev->vm_manager.spm_vmid = AMDGPU_NUM_VMID - 1;
> +
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  

