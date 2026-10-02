Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D9CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 20:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBDE10E048;
	Fri,  2 Oct 2026 20:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eoD/wapg";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DCB10E048
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 20:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfZqZAwbTKrS79K1EY6CMtZ7poBCnV9vTEtHH9lqMmiAcFPpGTcgk481GXTwJkHgTMgeTytXDPxnFRB5SSbERYNHZXI3i1juhyPANDJAv4cosnyYm6QAeTiYg1E8fvNJa2OYlxaPZ1i9EgzMSyi4keAIcHv+t8BlW9Y8rSagY8OTekBd1jNHXyfDLwZO7ZoQuDtvVlbqCDiqSokI+PN8tmJWnUG31IiTqscAwRMLLkeOM8228XGSLQ5h5jxTgq5GuZ4B/YhmqrB/OaJoFSrU6XtzWjTn0MOv2c46Gll+883LZ9jb02Z6gBOB/bXsduthhg+n10fK4nZdua6xMajhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0yK2ojn9wFGpLd6mOOiSfijpiQwXeRNGyvdYmhZltc=;
 b=Ne/TzatnYlQHI56p+qhFpJfuijjFoJ4MDOKrXhftfZnEZidPPQbJcSRvmp/i2MwJp7qUf8Fv/jNX2uIv54dBSCQ8iKOznTPBnahSxbUJ7Fh91UKDNJS6Sfe8r06hYj8qcUYSdJxFAw41Os9zze7cjbjveP+99IrQlYHCyG6OHGXYajXG18QuOd5+G1Fk8CDYhO3b9lX1ycKSH5V7DtSNrtMZhnsZvj62unpqanTUd0QELjTPTDbc/nMwUVm1bdooz92I1xnl0gC1EJTxOYubgvyCgMeV7ByElZkgljofE5Ggy4gWPUv+7hCxJEwMsGebe1ndXnfrrCxEdqSW7OgFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0yK2ojn9wFGpLd6mOOiSfijpiQwXeRNGyvdYmhZltc=;
 b=eoD/wapgZr1iVqedz1QUoyb9b4dmzSfEAFF29PaNTcndUk46UHluHvIk6HjMTgOVyyZoyL+DilWpt1yIuPX8IaE50u2lY9IX0u882oi6uWF6oL8Wg4JVXE63u4BbqCV7x4cyMp+C7ocVM3+UVEpSQsZz73QJihF5cuWX/5uiLmQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA0PR12MB8279.namprd12.prod.outlook.com
 (2603:10b6:208:40c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 20:37:33 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:37:33 +0000
Message-ID: <3490aab0-76a4-4154-92e6-a52660869d92@amd.com>
Date: Fri, 2 Oct 2026 16:37:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Flush NPA VM TLB after page table base is
 programmed
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261002155432.334448-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261002155432.334448-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0453.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::14) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b68ba1d-a67a-4025-4695-08df20c4fccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: mggSt1S+j+iOzBt+OaMHfF1RlnUuvDaTE9mTchvvACu4gESUTRyMSLwlBpWyCC0qsb6Y93z3vHOUEQj/3RdsEuDxSpXKbnSgLulLL7xDVKRUKBUQjAwqR0XJ8tVCwWSO2+ND+8odCnsiJDnLF1T/qnCguxrD08XERjQmVnXjZapEh1ffOjEJb8cKARevaBCjJQbpuOSjoeMlg7VdYp6WJDb46y9UHiUk2exgqYfZ6U9ZE3396xFpp8gP6at53m2VBuYITIsd+nT3c1ce/YkhpBOiMLOACfD5QvbhJHmHqPgzO0NAu7xXXAJv+nhY/BY4PeTsnABslXyJkoCizb+CTJeimyJf5mXgJ/mULpw1LcSbdHKOau/vBPZaqN4FM/f7Az2G1p5L0bzoeLIJbII8gcxLwCbdvPt9Oe0DDkCz6gMDC42IWjEUT8Rc3uCIKGrxquyidNwYucvDVD3Bo4SingFCrXSsmFf9W2xU2qx8yl6WoxP00OxJglAc96PRUgIi8q55h6wKy83gpgTG2q+MpxYCMWRSQCx5E1GCcOh1bORLJylyD9A9Nat8qkjjADSnt6cZkiuXjfCb+pVg/06OGZ61xsZw/dbDXSnM8kTOXDrl3hFqNfcUNFVz4ub9YS7QxTa+IuEpPfbGFqut4sa9WNQVKXdApJRsT9m7LOBDzQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEsvTERCSDNlNEc1ckJtczl6SWJHSkhQMTVITUNPTldaM0xKdlBZN25UTUQz?=
 =?utf-8?B?UExyZ1NRM3ljUmI3Mm0xazZzMG4vVno3UytPSE8rT0VZYnkxODJtaTJUQkM2?=
 =?utf-8?B?MTJEZThLRlN2TjZDSXpJNE1ZdzZIT0ZQU0pFRllWbXpmVFVEQVhqNitVdkQv?=
 =?utf-8?B?QmdWS3I3RnlXUXplTUhNS1hXUGw2Vzd4VDJiZldxMGR0dm5laDlyV3Q0ZjJH?=
 =?utf-8?B?S2kycThzWk5uSzRJZW9DYThoaThyVFFvWTJsQnpxbHNDQVNqS3JQUVhsTUFZ?=
 =?utf-8?B?SktOMG12ZDNZK0kwSTZvNlVYMmczTGo5U0FLd2F4Y2UreE90a3BoTmVkT3U2?=
 =?utf-8?B?YysvZjRiNkc4eVJiRVVSaVFqS3ZDRnE2dDZpeTE1UkUyMU8yaERxOVJkQ2Yv?=
 =?utf-8?B?MCs0djE2L3dWOXRRd2w2eHIzaWI2WUwySzI0OE9EQWFSU3MyR1V0NVBEZnpJ?=
 =?utf-8?B?bHptMVI5ZEpxdzVGRmFsZ25WWlRCbTArMzdsdUNiSW1zM0liRHU1RmdxL2w2?=
 =?utf-8?B?NkowL1YwcHlHYzh3SDdoQy9DaVc2ZDVOUW9yV1A5T3o0UGJJS0UrTjViTjd0?=
 =?utf-8?B?MGlFUEptZDl2d1dSNGFBTG56T2N2UWtITXRDMFpUNjZIMTUxVm1qSGRMaW9B?=
 =?utf-8?B?c1pWVW5BZDh0Q0pRZ1VKaHdSTjlFMmxOYXRidUNIRDN5RlhWdyt6NWpCMXp5?=
 =?utf-8?B?clJROExvNXFXd1JYRHFBTEFFZXlEQ0w5ZUxPek9PT1Q1QTNDQVc0eFBqV0lU?=
 =?utf-8?B?YkF1NlErMGxJWlJ2VW04cW1Ja2QydW9DWkRoRzVlMHM3aTJUZy9ZbE9sTmdJ?=
 =?utf-8?B?MUQyUnI5SkgvRFRuWkU4NHFUWkd3MDlQWlZYK0tUUjVreWNzMFJOREVFZUJx?=
 =?utf-8?B?RVlQMGhCMXl3Rzg0M0VhODNuS1BnWW1iTE1tRTBOY0xBeHRnaXpIUUZBZkNQ?=
 =?utf-8?B?dDdHb09LYzZHUjFKSklBUVZuRXlTOWxKTTl3c0JUQUcyVlNoMVVTL1pOZG5i?=
 =?utf-8?B?aWVkUlloREQyN3I0cXkvTWxSSm81QXhyUG04YitPM01xU3lZV2p5bVVKNGNV?=
 =?utf-8?B?bW5IUmN5eHdHYm1VNjJxakY2d2IrV3d4c2djc2RHWGJpRVFybjNpbWF1WDZ1?=
 =?utf-8?B?bWtjVmlUazNhSEJWRWRHdW1mckZ2RVY5dDFvbHhMVHRTTFJMM2FpWUxZQW1y?=
 =?utf-8?B?S01UdGFweENuV1pVVk5zOGgxeGlTYk5KbjRPbUFjbytCSEpxTnpvOUdXZTI1?=
 =?utf-8?B?Q0xLdS9tcDlsYVNmUDhOenNKa2YzcGdXQlI5Zk1SYml1RFpPRENxQ2xlak00?=
 =?utf-8?B?T3hOWGFmVWlybkhXUWdEdFJuQ1o2OUtDRTJQaFRBSUdjY1NhWVFrQko3aito?=
 =?utf-8?B?YldYNnZVTW8reU5LMXp6TGJwY05CS0Fud0lMc0lFTDRqT3YwZjgwbVQyUXk0?=
 =?utf-8?B?SWhCT2RXM1FjZVJTbHF1YmVpV2Z3QVhSNnNmSU5ZT0NuNVJyVHdZM3lXZ3RG?=
 =?utf-8?B?Slpyako5OW12VGkrbW00QkFSd2pQMFI1ZGJtTkNlR0NnQVR1eGxwQ2xOZDNs?=
 =?utf-8?B?WGpDanVabUxOTFFIY2JnMWxpT0pERG93RlRPeU1KVVBmY3ZpTE9VRjY3cVZk?=
 =?utf-8?B?aS9xMFdqU0RLSGxwQkRyQWlXNllvbURuRWpPOERxSEJTSXlNQm1yc3hoT2pR?=
 =?utf-8?B?VUJxRC9RcUdiamQ5ODlPZlVpQXluOUxCd1VyWHl2czdiZWpFU2QxUElrSENO?=
 =?utf-8?B?d2N1dEJ0SmRncEdzZDBVWTJSb0VpZXVGbnpYQUU2R3ZZZnRsYlBNQTh6SERq?=
 =?utf-8?B?YlBiVEdBSldTdHBMbGRuUlIwMlRnTVdhVUZVb3A5NG5YSzNCQWZxZFlQaWIy?=
 =?utf-8?B?N2FHMUxURlZCeU1ST3BqSDU1OE9OWlF0ZlBvZUtzTXhWYXBqbXRJbWhjQ3Y3?=
 =?utf-8?B?MkJyU2VVb2Z3Zm02Q0Z5R1lFY3did3JqbHJyOFdXUFdXZnRGWUQxK2V2eE03?=
 =?utf-8?B?U0h0dHFuN0w2WTBvMDJya2VWaFNETzN0ZlpNQXZBQThOdUZ3Ryt0U0owNnRa?=
 =?utf-8?B?YStNSG4vK0tuMUtmaURPczc3bU5BZ09xR0U5VzU3OHRFRjY1NjRIMVlibWw0?=
 =?utf-8?B?eFg3ZUt4cHlUa055VUZBSklqbVI0YUhPMXAxdkw3NE1ZajcvWm83VXk2dXc4?=
 =?utf-8?B?M3BlU2VWcG90a0Z0clMzbjVIM25kSitPTm1mYlJjUWtjNU9IYzAybFNyZHIw?=
 =?utf-8?B?MjlsdkhxdjNIZXl5bXAvNzV5eHBUNW5Eb2dOWHNSSmNyNUcwdnprRU0xT3NO?=
 =?utf-8?B?TUx1UzlVUEtzOExTMHF6RngxNGhsNTE3ZVZvUFJSZVNENTZ4MU5xdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b68ba1d-a67a-4025-4695-08df20c4fccc
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:37:33.8243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4ewKJAp/kx7mSkdY4PVW+Wc4WRMRUtzM6qFGpfeE7ZEajThFJb0ydi+WDTWDiLVZFGe8cyuKLb2oDC2Q7jlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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


On 2026-10-02 11:54, Philip Yang wrote:
> Flush the NPA VMID TLB once, right after the NPA VM page directory base
> address is programmed, so no stale translation is left behind from a
> previous page table.
>
> After that the TLB has nothing cached for the NPA VMID, so mapping a new
> NPA address doesn't need a flush. Drop the flush from the metadata NPA
> mapping and from amdgpu_ualink_map_npa_addr(), which never updates valid
> page directory entries, it only maps a newly allocated NPA address.
>
> The NPA unmap paths keep the TLB flush.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Sounds reasonable. But the removal of the TLB flush in map_npa_addr 
needs to be regression-tested before it can be submitted.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>



> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 758265670340..f49404a6dee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2148,9 +2148,6 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
>   
>   	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
>   
> -	/* TLB flush may be needed after updated page directories */
> -	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> -
>   	return 0;
>   
>   unmap_npa:
> @@ -4162,6 +4159,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
>   	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
>   			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
>   
> +	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> +
>   	xa_init(&adev->ualink.exp_xa);
>   	xa_init(&adev->ualink.imp_xa);
>   	xa_init(&adev->ualink.handle_invalid_xa);
> @@ -5056,8 +5055,6 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>   			dev_dbg(adev->dev, "failed %d to dma fence wait\n", r);
>   	}
>   
> -	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> -
>   	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
>   	return 0;
>   
