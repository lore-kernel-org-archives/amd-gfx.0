Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04F7C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 09:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FAA10E8F0;
	Fri,  8 Aug 2025 09:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2jC0zi6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CDD10E8EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 09:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d29TgvS8a+d4Krg5eGilIhI6y0YUSHBWpIP/9Z5tmXKdT6Z+qc42dUS3EhqM2UpT6dwsVxE5pxi8Q34m0S3ni5MuoZzcFBYqPHTBiP1h4+0igQk1uo+5liPz67bKu3LF0uYs2xFLAKfmbocrRNv2CtJBz6jzkrrUUdLV98zsm4nyOdAueG24xr+2D4Kz0ofmW5Z8afqrTSIJvd/7i2KCsIKM38e83z127mhOM6Fo16mnLexUB+E8anATwrSWz85Mz5EK1S6mR7DYHer4HQT9SXwVmD0ULK3h9NRZr7akyBQq+yooRSX+9/u8mXOxiNTX3Ij0KwEKwm2uk7h5O+7Zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXWEjKx2D5Z7wQRSNzuKUl9Plc+CguYp3hmmu9GlCng=;
 b=iE8zb+/IzUcqi/TfVq6w/yphcsf6i/0YlmFz80rMrkb2qVRWdyrIlzd8/zezUk+vpmkWabLnD2hSw63iY4lwij/jcBEOnfJn9CZjVUBCQkzuRUHDOv+51ctApagevHTF0UeESdS+YH9qFUz/ZZDKwul2voyFzphsOBouUdzPm3ipk8qnJj4aHCfpGdtG+FbEhA1TRg+lNCrpt72u9p+hkmSH79BLeBHKGcJ8/mbv+Zadl9Voazce0samGUnEmx+ESsKekJeBqEzpN3gDF6Kzp8eUhos0fJuBlRTcNrulQWiSshg8Yzz3lE0RfEKf0TFNJl8zpyFDEcEYF5ZiUCY1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXWEjKx2D5Z7wQRSNzuKUl9Plc+CguYp3hmmu9GlCng=;
 b=t2jC0zi6A87CEcoYGLAKSieU9REvL+YliPBH5z2eTMUsjasAlOYm6AjeTMIUAEsSC6KaGmCaeARXbVhcmfFklym8F+fdtV82zC8Zkk6zsiuzaM19JWdAuGy4T9TMy7x20BcI6oMRpl5Oo3hu7WAtbj1DEifUFy/DXNW7FvePF1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 09:21:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 09:21:28 +0000
Message-ID: <de752482-b57a-42c8-9ab2-6d60ba7c9498@amd.com>
Date: Fri, 8 Aug 2025 11:21:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com
References: <20250808031427.3131402-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250808031427.3131402-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6d3aa1-bba4-4022-6747-08ddd65cf48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S01SQ1BVdHVmUnFuM1pHeEQ5eTgzK0Y5UDhCSmdYeWJpd1FyT3pERUpjNC9z?=
 =?utf-8?B?aURtRmhrclNJM0tWWWdXYk95b1J0OFVMOHlQbVB5VUlWeDZrZlpJeFRhc0Vk?=
 =?utf-8?B?TTJveGhyUlhyYTVEdkQ1MWxtcDhQZEdybGtqQ01Mb3ErNDlWT25FWXFkVk9q?=
 =?utf-8?B?cERHdEM1b1RzYjh6dlloZTlBcmpCSjkzRysrR2N3YVJnWDF2OS9sTjB2V3Ru?=
 =?utf-8?B?R1BMUEJPZytpZmtVRDVGTlA3YjVQaVJhZjFYcU1hV1loaTRzSVN3SDV3d2Zx?=
 =?utf-8?B?R3o1VERJWmM0aW1GTE8yME9BeEV3ajRxU2pZRzFlV0NTWjdZZGJDLysrYmN6?=
 =?utf-8?B?Sko5Z0EwbVA3aHBOT2lkaTFxU3FIaENKTmRVWHpQRStReXYwakhCYlBZN2Vm?=
 =?utf-8?B?Z3ZTenVQUWw0SVNxd1d0Yk9FdVVMOExGdUFaUkVZTEVsYjQzVFZYdDVtcnUx?=
 =?utf-8?B?SG5nZGw0SnBoNnY0SHA4NWU2b3VKbFRzMUs2Q0VlQWpaQUozczBPUFhYUDFk?=
 =?utf-8?B?Q0lMeSt0S282bmlZa3ZyOUE5SnB2TThyZXpoME1KenZPNlBqN2VRNmhkTVBK?=
 =?utf-8?B?QVg1VXpXSTlZQVQ0MGdIWlR1M3JnZEVpc3lPSklvRW9uSTNYd0thbkc5VVNF?=
 =?utf-8?B?OUV6RXVlR05RZ2VNZEYreENHaXdwK2ZkZ0N3RHZBSlFlU1A1d0FkTDQ1akNZ?=
 =?utf-8?B?bHFZUXpPc1gwd0o4SjJDcjBpMldLOEptQlBwMk1ERHpxY0xHQkcrL3hTU1pG?=
 =?utf-8?B?N0NiMnlabi9ZV2gxSjVIbjJOYkYrS2VLTHhXbFI5R2l3MXVyd0cySnB5dlFN?=
 =?utf-8?B?QVhnY1hSNjR3cjNhNzRnS3hrSDlPWkE5Vm9KbUNhdjdOV2FwcWhtZ0UvSzQv?=
 =?utf-8?B?cVFGU3FFb0NGakxsblQveEJ1QVN5TmF4bG0wYlhuTlVxcG8xRTZ5THM1cGJh?=
 =?utf-8?B?dVpYZkcxUGtPS21BS2l0dHRvSm1kL0FPczZvREJlWHozVHBqbDQrbU1MOU5j?=
 =?utf-8?B?KzdRNEtyRmhoanNmb2dWSGxiZ0QxRUtqZVljbWxETjgrTE1pa0Rkc0JIaUpm?=
 =?utf-8?B?Q3Z3VHZ1V3RjbStTYnVxaW1OdU5FWHdYeG50eGdObXBsL2VVYjVLT2trQTA3?=
 =?utf-8?B?eURVRnppNUQzaGlVM0FmL0JpMXluS2NIZGtrWVR5UHpQVkNhTU80cWxDaW9E?=
 =?utf-8?B?azE5N3huMWhwMGFnZTIrM252UzVHZHQ1T0ZaMktRYzhGNkQwVE1kT1hjQU4z?=
 =?utf-8?B?QUh2VDdiWlZYbVlIaHpLTytLNTY5dzNCV2FDNjBha1JzL1pxb1U5TVRqaGRB?=
 =?utf-8?B?cTh6SkxrbVlabE9kR004V1FEdTJHTWYzb2c0dEp3ekNLRWRiekdPdmJNeWFF?=
 =?utf-8?B?UWNNVi9FdWpJeHQyaG5pZk5EUFVRT0tlb0xxbGw1Rk5MZy9JY3BXL3lxRm1Y?=
 =?utf-8?B?RjB4aTIyekpjYzB2VWlWUVVGeWxtZlYzbW1lbitNMDB6UXhjQzlBSGpsZjRn?=
 =?utf-8?B?dzhEbmx2bFdudUIrOXlmTG43ZWxPL3pwQmh3eFpkOXhienpGaDdSU2JmSXQz?=
 =?utf-8?B?K0gyVjA1RjJYeDNURlpYZlNsWFcxMDFkaEI0ei9LQ0oybjA0d3RuMlJ2Y0Ni?=
 =?utf-8?B?d3YzOG5WSmlnaFJONUxTRDdrV3dnR3ltd2wrNWZqd3JOSExVSjU1eW1sNDNV?=
 =?utf-8?B?Q2ljdUJkSmQxeEJMZ0p4Z0JYSFpjNlo4U2tlVGxVR2pndkVXS015by9CK29h?=
 =?utf-8?B?ZE1IRE1RSCtTNjM1T00vSkNXWENla0RYRWJhN0RZTkRSUnJzYmJzaW81SC9l?=
 =?utf-8?B?ZmZMd2c1Q21odVF5SXVQeE9TTnVjeHRDYmdiM2w0RHlWTS9IZTJGRnZhOVc4?=
 =?utf-8?B?LzdxSU13T1pSVDBBZ0NYSHExNWM5ODJZdnpqMkpsU01hUWY5RWMzUWhwY3F1?=
 =?utf-8?Q?ZoAsZCHzsHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGxVZGNpS1RVQ1JYNEJmZ2p5OEFyeTJWLytSWWdaYTduVUNzTjlMMUF4NXU0?=
 =?utf-8?B?SkxRbHhHenRGZUNnRFJydGxpQTlXR3NUOTNYTjZJTnd2TUhEOFdIRWNuYWNP?=
 =?utf-8?B?K29KNVFhQWxhdkQrNnE3RlF2NjVVMzExUEVUZTA0YkJHMkQyKzZaR1hQRkxV?=
 =?utf-8?B?VEVZa0tLRVNiTGVjSHFvNEc4NkZKdjR6dzNlbEVGZ0Y1b3VSQmxXd3IyT2Ns?=
 =?utf-8?B?TlgrR1VUeExYRW9GUCtMcS9FY1VSekNUWTc0VTN6NW5lckx0c01qR0RROEZE?=
 =?utf-8?B?U0FjZDdJU2tMNFhEcVZIS3BYS3JJMURYdTZEZEUzSEt0Y2o4TjBEY2R6QTIw?=
 =?utf-8?B?YXlHa1huN055L0JnZlEzdktqWHY5cUZLbi9CNU1QSlVwN1BHWFlVYXpNZWJz?=
 =?utf-8?B?aWVkT05CR1QvVUNXOU44cGQyeUlFY1B3c3p1dGl1bUtYd3F0L2JueW1vMTNy?=
 =?utf-8?B?QzJHNUpIR1FRSXhLTDFNNXJNV0U2UTdFTTNBWElLdjhqYTJkV0xEMmh5bkJy?=
 =?utf-8?B?b1NOZ3ZSYTA0QkY5YmpiQTN6NzZRdTB2d3JIWE03UFRmWEZGNTVadVl5MzhO?=
 =?utf-8?B?OEszVkJxTlEyd045YnorLzBYNEdkTHZFRkN3cGl3WGRRTXFrQUpQSXI4R1Jm?=
 =?utf-8?B?bDRnam5Ea3FmOVdYZ1FHT3JYbVg3Zk5CdnU5ZnlMNHhFT21FWExTWFFHN3dv?=
 =?utf-8?B?L1hDMW53OEd4KzNCSjVFU1Vtbkg3aHZhRWI2UFhraTZpSTcvR3d3KzFKSEVB?=
 =?utf-8?B?RHY2dWUza3piTEVaUWFSODl0Znhwdk43dEJjK2FhRXFrMVBhL0d1RldFSVIr?=
 =?utf-8?B?d0RVTWFWaWtISURnQnlnUG0wTXMzSGh0SGp3OFdmQzR0TEdrZUI4LzBTT3N6?=
 =?utf-8?B?YXdSYXllb1J0N1ByMGlZMThQNEFZQnBQTHJzblo0aHluOTVwNHBKdUZ5VHdJ?=
 =?utf-8?B?VHY0VUxmVnZxdm5PVHlvYmdCOEY1enk2N0JZU0RsMWZiVlJBR2E2Y3pXbURm?=
 =?utf-8?B?YzFrdHFIeHlpMGtmanFXM0xiTk1LSWZydkhVSS9KdmlOVUZoUUdONmEyWWdm?=
 =?utf-8?B?N1hvcUFvMUUzSU5vdklLL2hlempYaGxPSlFvOWVRVXhVWU5ENkhmcUlyUDNT?=
 =?utf-8?B?Uld2bTlvaTFoQVFnWHpxcGpTTkNDUGtuekF0YXpiOHlZWFJxdG90UHFocGhK?=
 =?utf-8?B?anIvVTB1OGw0UWdpS0g0eUpCdFpFMnE2WUdTOU0vVU5YU0ZqSC8rY3NVaGR3?=
 =?utf-8?B?UE1ZcjZmcWlUZDB0bVdXODlKeHc1ZmxHRkNxemlWY1ZRVW1KQnpDZmNLQ0xG?=
 =?utf-8?B?dGJlbG16aUZ1S3EvT2FickZJVnBSc0tRSWJKVDk5UmNiZlVHTG56REM5c1VT?=
 =?utf-8?B?Yk1ET2szRFNwOEM5K25kUmdvOG9qdjZsOHYrQ3ZxTTdoelVLekNJdzBqVXM2?=
 =?utf-8?B?VjFEL3YvdHFCMjRFMjRwSWFXU05Gb1JpNVZ5YXd5QU05eDEyYXNwczd5OVlL?=
 =?utf-8?B?ZDdURXRtbTdyY1RhSXZjbHhtRnY1QXZ3Qm83UHgwbjJ5Z24zZUswRFduMzEy?=
 =?utf-8?B?Z2NFZUVqZ25qaFZ5c3M4YmRRSlRISGExOFpGcUtqTExWWmNaSHpFaVhJWDNX?=
 =?utf-8?B?K2MwMFB0TmlTQis2aEhjUC9IQjhyRjRNKzBpTm5ZUjZaYU1HSnA0RFdJSlBr?=
 =?utf-8?B?T3phSFBoamtweTMzb1dQeHRLcTYzMFQ5bzgxcGRvRldpMmhkSjlBakVEaldM?=
 =?utf-8?B?Y2VCMWp4ZkpOcDA5REhXSzJkczRPOUR4bnBhZVNsbm1JYllnRWN2dDlsMXN3?=
 =?utf-8?B?YmdocFAreS8vL2RBbWJtNDFSZTY4MDhPQUh1ajIrYVcwVmZzZm44QlRBWnE4?=
 =?utf-8?B?a3lOSlpUZ005NmlxSnlOZ0JZc0dmdXlRdWhMOHcvRkFTRnRVZ3k0V1NSZmNU?=
 =?utf-8?B?QmRza0JIdGNyTDdMUHlKTGdDNm9Uckdqa1o0bGxYeFN3RFBmdXBvR2xyUG15?=
 =?utf-8?B?OFo3cXZUSmNLMTNOdUxtYk9rRks2ZnBhOTJXdkdGY0VrSzdGUVlSZngweE1Z?=
 =?utf-8?B?dGdpMnFKYS9rRmRSU1pnWk9SUEhKcFJ0NHp0Q0dQNVFzb1VQMTVQc1F2UXpU?=
 =?utf-8?Q?z0EqPKpUwZMlXzuRzMl3FQf8W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6d3aa1-bba4-4022-6747-08ddd65cf48f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:21:28.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Eo9WnKBVWwmFLtVpn68zMi7qAEp5fHPS38OZUK+8puayFeBVNfxcEtDj2hsystn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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



On 08.08.25 05:14, Heng Zhou wrote:
> If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
> So, such kind of amdgpu_bo_va should be updated separately before
> amdgpu_vm_handle_moved.
> 
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 37d8a7034a7e..e795b2970620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2970,6 +2970,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  		struct amdgpu_device *adev = amdgpu_ttm_adev(
>  			peer_vm->root.bo->tbo.bdev);
>  
> +		ret = amdgpu_vm_handle_prt_moved(adev,peer_vm);
> +		if (ret) {
> +			pr_debug("Memory eviction: handle PRT moved failed. Try again\n");
> +			goto validate_map_fail;
> +		}
> +
>  		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
>  		if (ret) {
>  			pr_debug("Memory eviction: handle moved failed. Try again\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..2c2a93f22ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1569,6 +1569,14 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  
>  }
>  
> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +
> +	fpriv = container_of(vm, struct amdgpu_fpriv, vm);

That's an absolute no-go from inside the VM code.

You could maybe do that in the KFD code, but Felix and Philip need to decide that.

Regards,
Christian.

> +	return amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
> +}
> +
>  /**
>   * amdgpu_vm_handle_moved - handle moved BOs in the PT
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..853a66f9fd2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -504,6 +504,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm,
>  			  struct dma_fence **fence);
> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  			   struct amdgpu_vm *vm,
>  			   struct ww_acquire_ctx *ticket);

