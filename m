Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772A3C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 14:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD17B10E45B;
	Tue, 20 Feb 2024 14:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SonjbePe";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C1210E45B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 14:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m48OXwvs84Rb+VluG2WtUBPKzWNtiIUGeN5gurVQ8/oDOmQW3H2GCTgwy3Na0tGc1PJ/xfyecbKu2OM6M3+YK2USGSUkrh4IvJ9DSET6xL/bGM64blsu2vbduvhoNlU9iL5Njy7dM1548F3tEyu787GocOTPWkGIXXp2QC4eiOkH5cuXM65VZaAcmoXhz1mQABm2ngFTri2IRI2FYDmM9uitUkb70d4l+u/i4zbHwBt7bOuqnMRvURsv2pk63qBemjYIiAx8U8/HoaF7YgltrCNVLFKj5aU0yTXuG9bogtCGhPRykNY4cgnCNZCX6xsp58A54FNb0Ce6db1SU8CkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnoHD3HOyqQc47VX75kk3yZK7tiQLqAKGzJxFMa38Nk=;
 b=ZGk48zyACM+339jac70+1cw3bTgRtvdEbmg1gQsSBeYMrSWNOIpdeHq3A+iRlDABqNijBwZmddXnsvUmLrhCNW7iuFYD4+bWMHLeeR7YBSZtRsPZwRAMLONnuIIeAh/F00YkxbmrH0OzvYTHg20xdR+41jv34esaY5XIp8wjoIF9D3WM6F5CWgunhF1KAYw0QWG4Tnz7T5/F3UQIrS7/oTQWaXnznKDCTwvBn8w9YlZHUt9Jo/vxxd3CCAIeanm1mdFTTULhH+Ybi/5ND4SlZyTYr8/53wGagQ82+7YdX0uuzMiS2wEwOSTad5gdNPoqVyzX0ANts7FdYI6mrPND7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnoHD3HOyqQc47VX75kk3yZK7tiQLqAKGzJxFMa38Nk=;
 b=SonjbePeAHSYz71TkPeROMnp6A4PWI6q3a30Ak6UM9ieG5T8kcXXOyqtKLoxFdf82t2W1RlGWqrUSQZEab7fv258oIkiSpC1lYJFKXGYsI3Zg9obMkWcwWuiPXiHF7VHJHJgceqNgzdGQAd3IgmdO8OJOWOd+rTZh256+sHmqzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 14:20:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 14:20:37 +0000
Message-ID: <03fb3aa9-e0dc-4e2d-a16d-3a6b8398c945@amd.com>
Date: Tue, 20 Feb 2024 15:20:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240219081520.316064-1-tao.zhou1@amd.com>
 <20240219081520.316064-5-tao.zhou1@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240219081520.316064-5-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f943bf-21f8-4a12-ca08-08dc321f1bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irlq+XLwIU9Ms3v+3ZRWWuG7zU0UmrVOenIP2Id755k3yupIb3dEm4KzNzYj51VKpxGXyK57rTk9tQGpydhOPxfnyMjICTdxVvGzB9Mx0LnMtwhEa+vf1Y3vF9WMH4oedm6AfhtmbD398vONfTnESY6mp7o/cBtJeQlym4yN6VQO+BQ93CyFpY6ckIHyp237oePqc6rc6HI7r4nxTf2htlL9Sragx4jcx9OeCSr4lc9K+qVZnPAMX/fScXTBgeu7co6SZaYqQecTh6263ZP/f3v0GTCAqXAXUUX1KPba78zB4gtj7gxP/J8L9ZqOWlz2ENmqg7TxjQqYzxz6jsHW390BQ8PGKlYH9UDPm9DFYOzxYb0jFvhJ9vxpvAtAdGjv1qfN056zd/LVCrBt2YoCcE+60EVso4VGhiG7lwDQUDeKZvE2trjG34nptqI7aZuxDqL4CvhbWAntlBbH66rZkR1bGZTn25xADgFrZgPanIXCpFAn3OLUqXup+uofTwNQH7y0/AyPls55NXt74A9TeyGqIXF60CjT+6+Qoe3YdcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXowZUtkZ3o0ekRiS29JbEUwYk92RU1ONkovemRNbXNPSjg3SEhYSTNIN29W?=
 =?utf-8?B?ems2bER6THBlSU56RG9xOGtaUEI2NUREUllnNDVCL3FxQzkySGN6Z1RrTlp4?=
 =?utf-8?B?bGZHNW0rYXFxbzFIaEU3UDE5dFhYMW0veTlKM0tuUCt5azdzbTFMRjFLSVpw?=
 =?utf-8?B?S0VXNXlxNzdFUWk3K1B5N1NxenpoQUREQXFCbjRDVEhTZkJqazBYemU1Vmp5?=
 =?utf-8?B?NitXbldyV054SnFzdEhUeXpLQU1DM05GdG9FVTRLSG1LeDZ0bjlyejJqL3FI?=
 =?utf-8?B?UjJsbVpLY2YvWGJhK1pLWlZlbVovdlFaYWZjVmdNZmV5V2pFSGk3OFBVV3F6?=
 =?utf-8?B?dmMvQmNUM085TGtvcnlCV2llRXphYWZrNzJ5OHV5a0FZYjNuYW44QktISWp4?=
 =?utf-8?B?b3daa1B4Q2pCbGE4V2lNVzN6UzRvdjBlWG53UXBteDNIWTZrR0VEQ3hSbzBK?=
 =?utf-8?B?MlM0VHRZRmkxZ2N4bk5GSUMwdUI2TEI4ZENMNnRKYWlZd3cvSmtIMGplZ3lx?=
 =?utf-8?B?eHJ6K2V0Z3JrVnR1RGQyUi9sbmh5OFptc1hId284cjIrbHB5K3pHYklHczNX?=
 =?utf-8?B?cm16Z1VLZ3Bheko2MVN4aVBCM3NhOU00c0pwOUxMSXFiZ3BwZFByaFU4VWtl?=
 =?utf-8?B?eDg0cFQvYnI1aEI2QVBOQzhmQ1dIVk1LL2RITDQxd2NGbDROTDU3U3V4MnRW?=
 =?utf-8?B?dkpsOUMwd2Z6czJzaFdHWktQdVBmMDJiQXhxTVJjUFpabGVYRzZ0TmR4Zkl3?=
 =?utf-8?B?UlNCWWNNZzdDd0hSWFc3d1duLzNiaFRXYUpMd25Vckp0QWw1dEg4Z2ZDOEls?=
 =?utf-8?B?QmpDeElQSHVTaHhJTXY5VUozbVROdWEvSTlqdXFJNXhZNHJGU3VURk9YL08r?=
 =?utf-8?B?S3VVWGo0LzJVTjU4VEljS3NwUURSUnhaVmRwbkFOQk9TdE8zM0hzWlMyRFh0?=
 =?utf-8?B?WUszWUJSdXZUb09PSDFzRkgycTRsakZSaE1UMXJzaXhoK3FzKzQ1NzJtNEx2?=
 =?utf-8?B?S25OL0NMdU1hN0RnVzVFQzZmSWlRYXU5UWtubXk3QzRBa3U5Zm1JWDY3YWh4?=
 =?utf-8?B?SnozUkhvSjlMT1RMWmdSdmV4L1NydW5pR3dxUWYxaDhkaEhhazc3MlRydURI?=
 =?utf-8?B?YlY2V1BFWUNZeFFaOEk0VFpyZERTL2JZbjJRRWpFU21UTnZnQW1XNG5wNjhy?=
 =?utf-8?B?bWVGNWtlUnBWUUhVNm91Z2ZCYUwrck40ZVVENTVucXFYN3h4ZDY1VTkydUJB?=
 =?utf-8?B?R0puVlEzU1lUZ1JyRFErMEtQOWV5YlpaMFlLTi9kTG5pcE5KZkMrb251bDJy?=
 =?utf-8?B?Q3FVVzV5ZmlUMEdtNzd4WGRvWVhseURBWnE2UkoxR3JoMjMwZkQ5c1pKdWlO?=
 =?utf-8?B?c1pGaFg4MGRqbHI0dFZDaWIrT3dFRTlqbS82bnpleFF3alBlb3huTmdLUUJz?=
 =?utf-8?B?ZUQwTzV0NG1oWFdyRE9MSGpzeUFhcjJDVHk5Mm5TUlVaWVF6OHpNM0NxdzI1?=
 =?utf-8?B?Sm8vRjlSN2U1NHJNY0NmRmpXcC82YlJtZ0xxdTRySVlxek41MEFvMEFZSzZu?=
 =?utf-8?B?bFhnRXIyalQyUDlyWEtTQTEveUNKdG9lb3pyWW1wV044MVU4SnZxZU5MSjRz?=
 =?utf-8?B?RHZQOTd4WnFDWTdKRFFkTW1HNnJjZkkwWmpseEtvaXBtZHRhQ2FyZVZXSDhz?=
 =?utf-8?B?R0VLRVc5LzJTeFJobndwVjFCVndTZHgwbVQ5dW5yd3FaWjFrdVA5WExBc00r?=
 =?utf-8?B?QW0rVENadFZSNzJtdm03cTMxa3U4eUVpM3NxZjRzb1lBbnBLZWM1dzY1MUM1?=
 =?utf-8?B?aXB6UGM0TTJkcDNHeDdTYm5VVGNqTUZCNGk5bExZQUZ0bEtteUs5a2t0NzU0?=
 =?utf-8?B?NWFxOVVNMC8zZS83MGswYkMzMjR1ZVVxUVlDZ0JraStxOFJKeUZwSjA0N0Z5?=
 =?utf-8?B?ZkJsdm5xZHl2OFNHTmorenJSSzQxZ01rKzJlZitXKzBKUUN6aEF2UVVEcUdU?=
 =?utf-8?B?Q0dWSDhsSXJLekdtMm9jK2lzSlk4R1VqeDZNejk3M3JmcGxQQ3dobFRLMk5x?=
 =?utf-8?B?dFlONXVxTFB5QmxBN2JYem5nNlYvdllnajJTWk5yTTIvZStZQzYxM01lVUJC?=
 =?utf-8?Q?ezcTIDPL8w5SKJp4QP/+JALit?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f943bf-21f8-4a12-ca08-08dc321f1bd6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:20:37.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTDOP8uJ4DKBsueAuCdWI7Uk+1wJkY9MPNlfkI/FHcCJuW2a7fl/hQqaXpiNP8Fd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

Am 19.02.24 um 09:15 schrieb Tao Zhou:
> Let kfd interrupt handler process it.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 773725a92cf1..70defc394b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -552,7 +552,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   {
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
> -	uint32_t status = 0, cid = 0, rw = 0;
> +	uint32_t status = 0, cid = 0, rw = 0, fed = 0;
>   	struct amdgpu_task_info task_info;
>   	struct amdgpu_vmhub *hub;
>   	const char *mmhub_cid;
> @@ -663,6 +663,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	status = RREG32(hub->vm_l2_pro_fault_status);
>   	cid = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, CID);
>   	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
> +	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
> +
> +	/* for gfx fed error, kfd will handle it, return directly */
> +	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
> +	    !strcmp(hub_name, "gfxhub0"))

Please never ever use strcmp() to make a decision like that, 
*especially* not in an interrupt handler.

Regards,
Christian.

> +		return 1;
> +
>   	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>   #ifdef HAVE_STRUCT_XARRAY
>   	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);

