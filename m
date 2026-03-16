Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E20AEFCBD4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 08:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C7610E250;
	Mon, 16 Mar 2026 08:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XPh9P1KC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A411510E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duonq3yCEwSH9YlxXYHuron7R+LTwXvhW2SYjgOLn6wKaVShvZvPsYk02e8AIi6j668xfuopuqXptVI81TAqhik2iX2koudVOBaKidGvS63dNlqpkpBxKo3YsJwq7QQFsqWs07cOgMrSYCQ2LDej50v9p49lYbk9Dt7DUMiariYU0zl+iMVfzIEB4rdMFrmz2CpzwmDsFC4WrGpZe4WFBabT3ZmOZsz73njPlzniqe3+v/HtezcAcY0a252ex5ZpMzwP9URtGaTv/c22/ZE5NhD08qlNAHgGX8wZbD/VgAvdspBU8Q/beC0gaXwjIgpoytNwdX7AiXFyOwCHiKEgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP3gadjAKPKcz3VeJr2gzOXSWKVinADOCqu6Br2F+oA=;
 b=dRf7ou8kR/SEMdm7wWugMxMhWt6oCVHnp9EqcilinNubiZHJbIDxGEKW5zJt79Yr1854jmPCSkVj3HWpKXHLkeudMSdHHxylHKeWxQklKG1MXYfhiOuGZ0znahoGLeuckjjqLYR2Jyj5l90XE+f5FgKtICV8k+85RpXu614Wh7aDa6xR9KURBOjBR68U6vXM5s7aA81g28Czf2W8U9BpbGN8pPwiXiJaN/egcPDYl/Skzg1QVrzpx0fjr/lo1sOjUDsybaUoH0gabwW72aFEg4CuhwVUJsCGLn0FGfd2qS9zozXavbaE7jR7xK4kISj8l1Bv29QjOAwvY3fec6ouCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP3gadjAKPKcz3VeJr2gzOXSWKVinADOCqu6Br2F+oA=;
 b=XPh9P1KCZCBXXSUvPNTXXn++LHpKRGQrfpAC1jfYzJSQBjMM/X2Ji2IsGRXbPrJlTBwBmtOZBIQytDGmkHtAGD8JC7JIERqLGepfvx6rrtCKM5QWT1sGq0kT9OA71mKQ7y/v8l8EHAHjJLseRyQX6bBETfRE3aFHKlq6GlvlUqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 08:17:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 08:17:40 +0000
Message-ID: <919077a8-7cb1-4988-a957-61c1f5a4298c@amd.com>
Date: Mon, 16 Mar 2026 09:17:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:408:ea::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8894f5-aa84-4f0e-df58-08de83347d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: m49Z1w9ANw72t3sWGBblibgACdoG0StHeE8fND/FIOhZk72E2P498AJbnanKhM+hY8aqJ7s1Dn58yA8uSAkeX0aU9/ht/CkInP8RpNkWLoOe6UPxYq9oqPcX2ISpNvwMrT3M7vk6i2PdsSSfgVEqMWS2OwNJo1H3DytWoztG4lhyv7dmPgsdkP6xA5HNY5N0wc8G+PQCDZJzXdZuMzSCpkbK21MEAnEPjW5HVyKJ3qZolqn83nN2aLvRt1I0avIvfckgcORObeHfzvYXYjyiRu3y4lC6n6qmdAw6oDsrIQWJ+MtolqM2eH9kNAtRhZPDidDofx/k4Z2IdF6jX4vkxP99uYt3yCk80UZ9E7BcrJJm1xZOMYhQkM/uA/xia4n3IDT3EmD1OLCbcev1+OFMkHXGU1pjNmJ615M8ZUmTg23G28RrD15K3AjRJk1MBRWKPJIQSvNN/f6uK3rlACMjy5v3hT6uMqV+TxF67Phwakcpz9FB4bK2IiivnbZC1s/P6wy1kaFawRv6Dogmb4VVemuGv0EA6gIQVLVj4JXaAQDXybz8ixWncqXBwL0SpSWsrjQKEpBilITDxAH6iWdtr2B4XcMLruWL9Peu3Ya3lu32ye5F8gNWHkcmT6eNFG978bz1chadPM5pkFOpubdp/qCaS4Q1fhcJzVau2oKgyhfw2d7zk1IQ20UB1H67Tj9hIiWFGS0wa6bbz5iVZ+69xzlWF+pglNDivFTUV193Gbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01nSnBEWXdoODVtWjRpUkhzWVVWZXRITDBTSHdSeDZYM3F5NHI5U21senJi?=
 =?utf-8?B?dFZ6aWFINkIwZlZGZGQ3NjU2aHpxVGRVbGRURkZaMHNwWUthdklyMmJCSENv?=
 =?utf-8?B?RnVIMDFuTXJWV0p1RWt0UUJFTVNPM3ZqVkx2RkNWNHpwZVBBa1VnbmdMRjFz?=
 =?utf-8?B?MXFiS013eEFrVEpwenVoeFYwOGVkeWl5RVhuM3VyNXpWM01CdHg2TkhXUW9t?=
 =?utf-8?B?N2E3bnNlYm1FTHIvbko5ZGc4T3VhNFphdE9JQjlLMEdjUUQ1ZU9sbTZlako2?=
 =?utf-8?B?MXdJMjJtTVRjcmhhY2l3TjdNdkVDOStmSFFyWk04RUZlR0FLejREYVdvcW9t?=
 =?utf-8?B?c3JSMWtjTGpDWFhwWGFsMlhkcXhENTlvMHFwdCtNTDJoWlcxUi9xOGxPUmFT?=
 =?utf-8?B?UUppRjhtYzA0TSs0RUE1cGFXcjZ2anFFaUg1RGd3dVlCQ3B4UEZjN3Y3K05q?=
 =?utf-8?B?d1p0dk1GemF3Vnh3RWp1Mkt3VjlRYzB5WEdJWXhVMTV3UkZ4TEVXY0xSQ2lt?=
 =?utf-8?B?cVJUT0MxSmNLWkVaSHArcDE0SXlvejk1TTB1MExQTXFwREx3Z3c5VmVYbUJl?=
 =?utf-8?B?REZkVDhMcXFRODI2aEpaWktXODBFU2QyTUZBSjRKdEpvTTRrZFhpVEZ1UTFu?=
 =?utf-8?B?cWVsLzhwMXpENVNlVUtPdysvOC9tME1qQnl1WkdTQ1BvS0dlK2FWaUozK29p?=
 =?utf-8?B?cnFoREFaUTdzdm9LNnpzMzZEWno0SHhlaUljSkhtYmtMYVh2NWs1K24yaW16?=
 =?utf-8?B?RzlRanRaQUVrMHFHRG95U0lJNkZRMlMyaWdzUUR1RU03TngxV1NqM0FMTlVj?=
 =?utf-8?B?Y3BsaGd3RWdnTXppNml5cTNta2hWWkFDZlVXTlpMczNJVVFvVU1hWEtEUW43?=
 =?utf-8?B?enJma1VYMVBZc0pFb3p3Z3I1ai8xaEFhNDdZem1tWGIwb1RPZHY2RVNNMy9Q?=
 =?utf-8?B?VzdzVTBTalAzclZKcHc5ejVuOWJ4U1ZvQnFRYllFdXVOZ29oRFR3UGFJU0ND?=
 =?utf-8?B?Nmw5ZXN2NWFDL2dNNlozL1dNdmdqRDdZTEhUWlBRemtmMFkxcW5IM2dZS1Ji?=
 =?utf-8?B?R1B4S05JOXRwUVVHeUYzRlRXUWZubE5vZGNKSlE4UllyS01KcmtNWHB2d3d5?=
 =?utf-8?B?bllFUG52R1dwcFIvZlc5S1NCMzZXT0VEOXhoTEluZEZqOEw1d3JxSG1mMHp5?=
 =?utf-8?B?RnMxbElxeWVha0dtR0NWWkUyQ25Ldlh6WHF5bjF4R1ArSlU3SDExWmN5SGNj?=
 =?utf-8?B?ZGlKeFBYd2dlcVhYa2dZamQvY2JYcDkxTFBvNE9GdDZrbmVuTEhIcWwySUVZ?=
 =?utf-8?B?VXlZN3I3S0xuc1daQnpIQmZ3L1EySXdtZ1J6bHdHR0pVZlhaUWxUb01VYjdC?=
 =?utf-8?B?dDJRbW4ya1R2RFV1bHpRNC9TV2xlR2pTYkx1UVU1T3dMNlFTN2VEcUtRc3dl?=
 =?utf-8?B?Wm92dStaUUd0VnFreEw5b2wxbjBRQk9jc21yWFNocnpuaVZUUXFnUExhemdI?=
 =?utf-8?B?eUlqUEdxYkM5eU10bmJoUHROMkJTaE9KY0xUL1VTVHNiYjY5WjVCQXdmYlh3?=
 =?utf-8?B?ZEVrRG0yTyt3N3hva1ZsQWVIQWZ6T25xdGpORTR6aXhhcGM0bWZiSDArb1Nj?=
 =?utf-8?B?VTN1K01BQmd5b1RjQnMrVHlqWXlkN2NremdJajZBOWl2NW5UTzFXV2hLbzhC?=
 =?utf-8?B?TGJSQWpzMXBDb1g2M2NtdlZieXorVkNDOHhLNHVoZ0NhVE1uSnVteE5GdENl?=
 =?utf-8?B?a3pwakJVZjBsLzg3WCtaK0xSWTJOTGovK0w2a1lyTXlXL3k0RkhveElxTU9x?=
 =?utf-8?B?anFDbU5pc2pZV1JIMk4vb092MjhuN2Y5bTNDUHpwWTFjWHRlM1ozaUJ5Wk1o?=
 =?utf-8?B?UjdhUzFPbnNla0Q5dFNzU1ZnSEVlUzBLZVg0a0p0ZmxEWngzNDM3U2dGWHBM?=
 =?utf-8?B?cHZsRUdpK3cwczdEWkhYWGs0RGVHZGxXeTgrTCtTMlJZK3NiRGVqZWhlNFZm?=
 =?utf-8?B?d0RHQ0RIYkhqUFNZU3RnNnBOK1lJY2p6WFFLb3pIZC9VNlRJeGpibHdSWGhn?=
 =?utf-8?B?SDBKcW85SUR3cWpqcWdGRUk2aGtpeDBYbVVvanNVQmFZOE5yb0kwYkhrRGxi?=
 =?utf-8?B?TjBCQldzMVBwZ2oxMDJ3aU9BSnVaSjM2dVpwWHFXSzlhRFo5OUJEOHc3Z0Vh?=
 =?utf-8?B?ZW1ndVVkMGx3Q0hkaGpveHRZTWFGRXR6Z2lLbFZRVnJKazA3ZU5zNGpuYng1?=
 =?utf-8?B?N0dlNVp5Q2MrZkRyS2V5MXh2ZHJDS05Uc2dZbm42aFdrMDU2QmNTdm1HRlVX?=
 =?utf-8?Q?XvbD0NSQxFbxpneb2v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8894f5-aa84-4f0e-df58-08de83347d4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:17:39.8971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXMHlofocEda/tjULZeF8o1d+o5nv6OHf+RgD3yvXox3xClEDoTKuKadCaKzYvKL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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

On 3/15/26 07:55, Srinivasan Shanmugam wrote:
> amdgpu_vm_flush() sends commands to the GPU to update the VM page tables
> for a job.
> 
> When a job uses a GPU virtual address space, the GPU needs to refresh
> its address translations after the driver updates the page tables.
> A VM flush tells the GPU to forget old address translations and use the
> updated page table mappings.
> 
> This flush command is not supported on all rings. Only rings that
> implement the emit_vm_flush() callback know how to emit the correct
> hardware command for this operation.
> 
> The function already gates vm_flush_needed on the presence of
> ring->funcs->emit_vm_flush earlier in the logic. However, static
> analysis tools such as Smatch may not track this relationship through
> the vm_flush_needed boolean and warn that emit_vm_flush() could be NULL
> when the VM flush command is emitted later.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush() error: we previously assumed 'ring->funcs->emit_vm_flush' could be null (see line 788)

Absolutely clear NAK.


The test on line 788 is there to not set vm_flush_needed if ring->funcs->emit_vm_flush is NULL.

So testing that again here is completely nonsense.

Regards,
Christian.

> 
> Fixes: b3cd285fa68d ("drm/amdgpu: update the PASID mapping only on demand")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..cc79cb7dd4e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -807,7 +807,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (cleaner_shader_needed)
>  		ring->funcs->emit_cleaner_shader(ring);
>  
> -	if (vm_flush_needed) {
> +	if (vm_flush_needed && ring->funcs->emit_vm_flush) {
>  		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
>  		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
>  	}

