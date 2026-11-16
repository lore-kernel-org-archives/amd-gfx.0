Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6759606A89A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OwXoCaLo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E1F10EDFC;
	Mon, 16 Nov 2026 09:45:22 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B8D10EDFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 09:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azejNQfd9Sd8VS/Uzc4yP9h15mQvyruEk96adcXM6mP+xeZSVftA3onkJZJ6s//6Tv53CvVw7QBy26GuawXpJ1OYnZETcrLhSUxOm9BtAsYITQoXE3d4NmDp566iBya56f/o759LNPZtB13eJUwVALjHvIaCqvPNSxnZhs1hERL1pR+WJmS8vCZb8wkWyUxHbZXZCC9yXS//7+7a7VHH6gC0zY9jsP7/BFeYBhpYGXcveVVmmihpfJoyie7uv/OwxpkjqNkmmAbFAqD+sv81ZWyWYiTeFK6H83K02Lw2awVJFygvLCZJ4Ut3Pcb/I8h2u7umrVDP+VfBlkQ7mrbBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVojClzVXE37p9ju8AjGa8e+OgpfnC4D2P3kF8fqla8=;
 b=oEkPm+8SKKshX4gsO13JwNH7JR2/vEG3S4SkjZU1xtD+ajjDaAl7I3HQnRC7VpKlN4n8n7XkPYExrxZuNbiKfGtr3tnuIwUx2IoOBCrbkw2wyyxrxyVpDb99M7qJbLc6JaIUTSoTUKRncJu1V/F4Z0BkgDRWri6VutrseCWVlHviGVsXcUb4trFi5xbrRc6ItKZ8Mp4kncqzrTL6qKCDlC0m0jJ0VLEKxikdUXgFMY0z1SKIehfFWdW4ZMJ0cFOKDqAyiLBGJ7KGSnfc1JimCN42eXiMOihonuNlAMShAquU3yQJ5xFHJS5B6H1E5gvTiN+D9PSKqb8yC6tXW2jcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVojClzVXE37p9ju8AjGa8e+OgpfnC4D2P3kF8fqla8=;
 b=OwXoCaLoD7WCIKUnM8jT2pzJclCAMqfw4jTycf6helF3WxtE3EYAmUWx9OzQGJpWUydEGZSP5G/bQ23dKz5Sju8io34J9Ax+dPNQY3Xgro8mNRq0zhQYL781kUuNlwciHuI6uNehygZuGj2L4o6F2EKCZ7pJi/Kp0pp4e4+XDRk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by DS0PR12MB677406.namprd12.prod.outlook.com (2603:10b6:8:4ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:43:12 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:43:12 +0000
Message-ID: <d9513d3f-ad10-4c68-8897-2411a8b3dcee@amd.com>
Date: Mon, 16 Nov 2026 10:43:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-4-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261113145702.323968-4-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR12MB5684:EE_|DS0PR12MB677406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa5b6a7-81d7-4163-525e-08df43c60734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: nqAr3uGGfFtgCOGQO3cogvSKWFjgmxsrsDwjH+VXHQxZsWGAs+naPRxotsYXrI5WNJyNMDnO4OCPWicPLzFQoTzWrnpsRqbhV4Irp52Ls/RmIeFxi6r5xNAN9yfor+dKjyIpVuW+EXCCqOheQqs0demNWmrjnqFHQbZZ5uPIIIvghjlREuDpJtlaUgdi1XgHDzkwR8I0/2lTC4wUhOLY1gA4chDL0RCG6m7guJWcuHPtvGaFZq4F89pdUjGwXRFHeV06sbBkfdlzA0fJD2B4BXaw7NuLQHeJBsgPL2twDk1lQRZ3+El2HpLQc3E19wtpNPX5HRpOoeDpP0wVVi8UgwbFkFo/T5HSltgK7uGkSVhxH7QuCJRzKYAH7Ll7lu6MQo5qnZ77iCxRSMloPeSBuduQC8vIOXBr63zoxDd33URB35A2DDpnRRoSUp9O5CpRFiadefCeIA7iwHKG2fr0RTJZTvX6FU8Y7EsjHDRZcwbYKUHdAZSgrG4OnlGfSenlhMeIcDKUbJwl0E/MYrhyq+cCGhrUyHmWEgc2p0cWLuehmFiPaLq4Qmb5bTLpudVVRDAguf+vji0JRyE0woAFypOZm5TbZYQrOT9aA3NKHuPZW+ezOY8LTqNejikb7eZ/P7hDbpWLcCDHcglt/w9rb5AwmCWckiEk/EQNoYpOt3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWlhZ0R4UVNjdld3SWwxelRicFpxWTJPa3Y3UU9yV1lHVCttQXVMN1ZKRlVr?=
 =?utf-8?B?UEh2SWphck93NjVJeVFxNkp4Ryt5NklEQ25yOVNXT3BQVi81amk0eGoyTFNK?=
 =?utf-8?B?czE2akRNUDhYcGo5NFFBK1FjRzF3U2RPcHBYMGdwMlZicG1nOXhXTkluUUFj?=
 =?utf-8?B?cEtPbHFoZkJ5elkvOVFDK1dmNlRRaHI4SmRQYXJnS0NiVTZWYmJ3K1NYNEZy?=
 =?utf-8?B?M3hRNGwyL25MWnB1N1dsNE1uRmE4VG5UNDVUWUhFdERiMnhJREwzTkh5OVR6?=
 =?utf-8?B?QVNsZElubmphUzZwakJXdHZ1OG0wQnQ0SGl3bmhQQjhTbWh1dExEN2VhNk5i?=
 =?utf-8?B?VnUxYm8rOTFqd2crYk12bXNORFJ3djBaR09tTWhpNVRLZmFCbzJGU2tPelg3?=
 =?utf-8?B?K2dOcmVhbEE5MGgvUXVmU2ZYU2x5bXBVeGVnTENERW5GQXRRTjNwNmo0NmtV?=
 =?utf-8?B?YVdrbmNId0l6dWlzakFrUnhsZWY5WnlVZi9WdVFYQUpvaTNNNHIxSFBZMzZH?=
 =?utf-8?B?QTN0TDdvTnljaUUraDc2L0dYQ2V2eWNmMGxBOStmUkpnUGdQSFdRU2JETUsy?=
 =?utf-8?B?L3RMT0RlZWVkbmFHeG9ycWdHTnY3Z2VLSHRieVFKUXFHQjdBbDB4SzFLYkh5?=
 =?utf-8?B?YTJFRm9NdGp2SzlGN0dYS0E3TzYzTHgxWVp1ZlllN0tQV3NjRlFnSzJxaWxK?=
 =?utf-8?B?SFhTN01yUDBJL2dDakJ3RjFNOEJLcDg2VHc5bkF5dm54OTU5c2VrWGZFY2Rn?=
 =?utf-8?B?RWZHdHJFMGwyTXFUY3p3OFdaTmZJL095SVMxZE1jbFZOR3J0ZnJ6K0JQODg4?=
 =?utf-8?B?NW5nZ0EzamNkdlM3bG1DTkg1MnVqSlk2RjVyeDRSeTkyK0NGSnZkUmVqZ0gy?=
 =?utf-8?B?cEJRdm1DTkNtMmNBMGpBSlI3VXFHQ0ZiR2VWZUM2WnUrZ2xvc1JsdUQ5WGtO?=
 =?utf-8?B?ekJQS2xOWmN2U25YSVl0NTJFbExHbFFTTEtRMG9HN2dXY0ZxU1g5Tnc3czVa?=
 =?utf-8?B?bFNRMHgvaEcrNElVeFpXVTZvQ3N5VG1NNGdrakwvZzFiQnJvcFpFM1JjTi9h?=
 =?utf-8?B?R21taWppUVRxd3h2dGxxeC9WWTIwRCtlSjhoTWtqRkhtZzBlcTZ6QlQ5RGh1?=
 =?utf-8?B?VGViMWlqNmNJb01nSTBCNWJkRlRmbG9TcFo3UHUxMWhyTGRzaUQvRXhIZVhL?=
 =?utf-8?B?Yk5PVGN2UVlrQ3ZLNXZ1VHAvVWptNFNWenpSZDVuUm80ckV0dk9aaFgrTXJR?=
 =?utf-8?B?TTNMdHB5cjJEQ2VibEd5bWJXMGs5azdGTmxDb0ZZSDBGYm15QUkzVEw1cm10?=
 =?utf-8?B?ckc2WXZqSUNySWJRb054enQ5bUE4UVdhUVRvdHB4L0gwcWdWZ2MxL2M1YUJE?=
 =?utf-8?B?c0ZXKy9oUTZIWUcwdThrcFl5WVlEN0pwTHIzajk0QWl1ZnAycTBjVUpRRldK?=
 =?utf-8?B?a29ialJtR2Z1ZGJyOWJFSW1yV1lIMjBnd0k2RjNHWGxueUtNL05HUjBBYkt0?=
 =?utf-8?B?VWJjQXNBV1BhbU9NQmZKU3dQencyckR4WlVsZ0RjakdwdzJiZWtpQlNpbys0?=
 =?utf-8?B?QWtsaXA5TVVyWWxGTC9UbzNlMEZJeGFmK1ZsZ0tlMDVuUnpNNzZOY3BIM0My?=
 =?utf-8?B?UzNDaHhkV1I3ZnpRUFpRbjBhK05CQmNuL1ZhNUVWZE9jYkhEUFVMOVJmekxn?=
 =?utf-8?B?ckQ0UVJHd25Rb2J0QUlQZkMvV3JLcDlXcXFZa0JkS244Y2pmRDNYcldWc0pl?=
 =?utf-8?B?KzlQN3BqaWs2eGdPLzRCdVZPN3YzeEpQc1lKRXFTZkdYVmJTdzgra01KWlhT?=
 =?utf-8?B?OUNkWVIyN09aZWo5eHpPZ09oZFZqbGdOSG5sbjlwNlFJZmVQcGNXaitOaHla?=
 =?utf-8?B?RS9veFN5c1FJTHBiTWRoaUI2TC9iUzloREEzZUNjTjJ2TUNncm5hVk4vZ3lY?=
 =?utf-8?B?ZjhWZTNQV2lzTTRpa2Y5K1U1UktGcmwxREZISXBJNTBtcFMyeGFLdEJPN1k0?=
 =?utf-8?B?MWRrRmZrSmdSU1JYeWQ0V2djeE9ubW9EUEJEdVc5R3hHQ1NaVlV4TlY0WjYv?=
 =?utf-8?B?TzZlNGpvbU8wTVQ4eXd1emM1RlYrclphdjZqZUJXREJualhoTWE1dWNTbkk4?=
 =?utf-8?B?TGIvYW1odEFsTVRhcmdVZ2hEY2U5MER6ZUpaRlJGaDh1OFdNSmhaSjhlblcz?=
 =?utf-8?B?RXZiMndpeFcxaWpSK1dVd2FEUVRaMG11UnBsY2dtSUdSMnd2WiswZnBEaVln?=
 =?utf-8?B?YWNlSEF1emVFSUFDWW9wZTlZMndWaVd6M29ieW9pUmxwK01vcURNR1NoQWVh?=
 =?utf-8?Q?f6nRuoIDGDj/s3JPJe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa5b6a7-81d7-4163-525e-08df43c60734
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:43:12.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cExbMBnY6R0iG2FN+IwjKaukxZklzVAqne0eFgNIvddciWKIbr6DhFUjK+j1abxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB677406
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/26 15:56, Zhigang Luo wrote:
> gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
> address and skips that conversion when AMDGPU_PTE_SYSTEM is already
> set. Set the bit after the translation so the address stays physical.
> 
> gmc_v12_1_get_vm_pte() sets the bit for a VRAM buffer object. SVM
> calls it with a NULL buffer object, and svm_range_get_pte_flags()
> sets the bit only for system memory, so the NULL case sets it for
> SPM VRAM. NPA mappings are left unchanged.
> 
> v2:
> - Set the bit for a VRAM BO inside if (bo), and for the SVM NULL BO
>   in the else.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 76391fca6c62..7ac0d9c6f280 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
>  		*addr = adev->vm_manager.vram_base_offset + *addr -
>  			adev->gmc.vram_start;
>  
> +	/* SPM VRAM is reached at a system physical address. Set S after the
> +	 * translation above so that translation is not skipped.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +
>  	if (*addr & ~adev->gmc.pte_addr_mask) {
>  		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
>  		*addr = 0;
> @@ -758,6 +764,10 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  
>  	if (bo) {
>  		mem = bo->tbo.resource;
> +		if (amdgpu_virt_vram_is_spm(adev) &&
> +		    mem && mem->mem_type == TTM_PL_VRAM)
> +			*flags |= AMDGPU_PTE_SYSTEM;
> +
>  		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
>  			dev_dbg(adev->dev,
>  				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
> @@ -766,6 +776,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  		} else if (*flags & AMDGPU_PTE_VALID) {
>  			gmc_v12_1_get_coherence_flags(adev, bo, flags);
>  		}
> +	} else if (amdgpu_virt_vram_is_spm(adev)) {
> +		/* SVM has no BO. System memory already has S. VRAM does not. */
> +		*flags |= AMDGPU_PTE_SYSTEM;

Both SVM and PRT doesn't use a BO, so could be that this causes problems with PRT.

Please double check the VM programming guide that this is ok, if not change the code so that PRT is excluded.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  	}
>  }
>  

