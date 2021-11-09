Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D69C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFC1611BF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DFC1611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA66D89C37;
	Tue,  9 Nov 2021 04:51:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E8889C37
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 04:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnnWMdQ64gsnKZxJ+8LWFQZr7XO6ZAozWB3fxxGNRSkUuPsnfSfbcFlTlaNQo0xHIQUPWzOHOQx3rm9lHCHjo+ti+e5PoL4QowkMpPqngGHU1SDtPsT1XvzhNrN3198i3mMMMXLBcmgr3/CCmPoxPyA06aeiGGlKSbCQhaw48NJ0tLbib3rdJVPwPTlqZGuHj3AS3O+PMaYJl1vo4R+z/NVBCG7M5JkCN2WB2e9V3TYbaPhnis8gfwoH549SeS+TidH/SBJ5i2yd8ewT5s3KhMC9+T/IFSC1gqVY6igHoLI2Ge/sHnstn0FHvRnddZbHjLohIrfiLK7cmY6EpH9Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXNGZuauMwy5hlh7Aa3emrnbnBlBXNyCFa+0wt8yCGI=;
 b=gkkko1hws5ZA1djKN+50uLfVqzGbvR6TG524OITiGrLMuoBL5zd39nxP0EnSd6h50cbgAExgck5H9Ihng1YEn421Hd1mIj50zdzz2L/eXWhkQuLLiMdNv1xipdRBpoLednGehNX5fgHT2d9IiwC+bPrdetlZtCRVHzQqZZDk97e0vYM7qxPv6FtsxePFyDB0WjZ+B5wuYimpd3bLs/D+Bg0IvO2S15EzsxBOtcdUfdBWs2t8ncPVrte/NH1bKxVoLPmHV128WpiLX3oVAwp79vajzKTwOZ02unooATBSzjnHH0M4WnfOtrEuBdvPcuMxWYyk1JwbEZfmUdtsOP2jZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXNGZuauMwy5hlh7Aa3emrnbnBlBXNyCFa+0wt8yCGI=;
 b=SBswB+3fs9aW2kyrUg4kLTdtKJDrSnLOlgC1JfXrWdFdbH7sRP7wx+Ye9+5GjEksXgKIQBidMpwcArKhnaMyBmSg8b2NZCmos2ZWDMG8E0GhfPs1cRk6dIWmfHGEpJYIsUns/GRPzlLSGG5vuEBv5KEe8LF7aKx2/Wy4u9qgLho=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 04:51:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342%9]) with mapi id 15.20.4669.015; Tue, 9 Nov 2021
 04:51:09 +0000
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6fafa247-cc05-dcd9-4f52-6757f20a6941@amd.com>
Date: Mon, 8 Nov 2021 23:51:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Tue, 9 Nov 2021 04:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3212d83c-9c5d-4506-ba38-08d9a33c8bfc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5113:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5113B03A64CDCA5FFABF2E2592929@BN9PR12MB5113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEEFQqTknnw9vGu6HGVjN1is/1jEv3W6pQnxYlUjXS0SnYGAEZQJkHd58Ae6cLvbr/moQjJnLA6gseA/5TpOJdapp464mu2Z8QOWwNzCgl6bEwPNvfQsZ8Oi6UFNPVLqGeGqGgEusxYX4WW92D6XrNjZY+3f2dBnFCnuRLxaqlFiGOBn5KMhemSCeEUEMVZnJjedMT0I15thrWp8CjLmAy7N3jjlNgLu22zop9vX4yCPOXJj9C54sUN51YNxWCtYw5B5Ya0EBmRox/feB9XDMRB0X/tQeBKKcigozAuCl0pwIDuCFcujtZSgyv2Y9liVjw67sn0pwbbGyr9DeMTqpa/GJjE3VHyVo30ayr6ugG4JrTlU7/oRnmd0lZVxXcwKKofKTFqEja9bMbiAYbRfMwBlWdgmPw+ySspsW2gc5kJDQ2M1wi24FRLVONg1Hpcwzzuir+D09EzpPUzTZ1TwPaKl51f585V6JeEs1dycl875DBeaBnsuwdOfGMytUwUcaXDDJTLwjynxlFsgBsHJS5932Q85aOp6EkKVjAUF7Cwy2uRoLI2EVPGq/Fzt5CH3wyqGgsLmn/nTbSVSBzAEaWSxU7MENC5K/B0By58iWi/kZov0znj2c9hy8DQiWMzfCBIL/i3tnE5FMcBSlqrWN3eSuPdPinA7T7A3IA+Mj5NyfaOtuk2mCyZIEGiNp50HcsMwfo4FeZQNXNlA/SzXYKbpBAe5NgESLOpbcRpPeeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(86362001)(26005)(508600001)(66556008)(8936002)(66476007)(83380400001)(6862004)(31686004)(44832011)(66946007)(36756003)(186003)(8676002)(2906002)(5660300002)(37006003)(316002)(16576012)(6486002)(2616005)(6636002)(38100700002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnkxM3VlSFBVUzJzODVEVVNtdUN4dVF5QlZxbXZiajVSOWNqVlBZZnNVOEJ1?=
 =?utf-8?B?QlRwZ2NtU1hGbGJNTmZWY2pmd1VGVXhpM0JEY0JvQjN6WGVhbEVYU3QyWTZ0?=
 =?utf-8?B?M0E3QXczeUpITDQyeFNubklZNVJPYmRiejhkSk5yN3h4OEJ4WStDQzl4RVVM?=
 =?utf-8?B?WWlIR2x0SjBBemhQdmdwaUxuVTdrTTY3K0lmMFdDOEd3Ly9UeEVPcFUyOVBh?=
 =?utf-8?B?cEd0ZWlIdS93K1RiOW4yWS9QMlBVNDJNTkgxVTl1Z2V1a3hVaWhMVFAzRTk3?=
 =?utf-8?B?WUk5djRnT0Z4Y2t5NEk1UVhpQzVtOTVpYlhSTWNvZXhiOWJiSStSOGdOb2t2?=
 =?utf-8?B?MTdHRi9uR1k2cmREN2R0UjMzUUo2TG5oa0JjOTE2amlNem9GWFdEd2luaEp3?=
 =?utf-8?B?ei9BTHNkWDVTaDZKbk5vUjBUWGZWeWdRSjIreldmQVFacWJ1K25NZnJ4NWZT?=
 =?utf-8?B?N21zMUVIL1NLKzdONjZYTFBvOHV0NWI1VEJQVmNPU25aajEzQkVxUTNvc3lw?=
 =?utf-8?B?ZTIwK1kraGZpbkxZMGE0T2VOcERVZnpCZStrYVRyVEZFcmRSb08vVjNWb3Iy?=
 =?utf-8?B?ZjBtRVlVMG5ac3hQRW0xNWxSeG9QaU9IMlZMZTZyWW1ZY1pZMjhldDR5UUNh?=
 =?utf-8?B?SW13d1FMSVhvU1NoVmk5eVdUMFVkbUdJWkhlK0M5SmkvbzBpN1hIMENlWits?=
 =?utf-8?B?aWJhL2NSWURDQlNJNDlnRlFLeXJCc29rUzlDcStvZVdwUDdLZnZzU1FCeDk2?=
 =?utf-8?B?SnpmOE1UTmJUZHNlSUhLVHNxY0svcVRweTlaeWMydlltdXY0YXpqUDl4Tkpt?=
 =?utf-8?B?aVVSTDFzOSs5L0pSSnlEZllYZEVpQkpLZS9kaUI1WmRMc0lQYklZam4zVmxP?=
 =?utf-8?B?VjlwbnFKb0g0U2F0OEExRXA3cklxQysrNGhnRG50anNkYUJEQnZjSUNWc0FY?=
 =?utf-8?B?YjAvbEFjUzhzTFo2TE9SZHVteVVNcGpyeTltWjdRL2g3WW1FMmZKaFdRYXhG?=
 =?utf-8?B?U3hYZmVCU0xwSnNaQi96cGZPNDMrRWxDbVFLN3FQcEtiY05NNkp1SHJ0ZUFn?=
 =?utf-8?B?VjU3ZlBPbUxsMnA5eDlNNVM1TEEvMUhMd0c1b1Q2aTUvNmxmM2xOaytlV2lh?=
 =?utf-8?B?eEpCb1czOVhZTTYrUjBjMnFRK3ZMTTgzOW9naEIvbFJHRnFYVnVGZForS2VR?=
 =?utf-8?B?R3g3anBIUXZqaTZvTXN1Q05NZEdMZCtxVnhZeUI5WWlFZ01Tck1acUhqYjV1?=
 =?utf-8?B?ZVYzUVdBbHNtQXZuZHBKTWJwMFRJV1UrWjF6c1BsWmpLemZuZlNEQTRhVFhm?=
 =?utf-8?B?Rnk4eWg3b1VpdmRsTEJJdlpDTjcvOFJ5UWJMM2Z4Q1dLMXNnRkxWYk5YakpB?=
 =?utf-8?B?cm9heUU3WTQrVkVteCtqTWFKVHF2QXlLOHoxL3VOKzROQjZHZnVpb0h2b01O?=
 =?utf-8?B?a2JwTlgyNDIvQ09EUEZFWk1Wc2xVQThObmpYVnZzQS9uZWlER2p1Y1F6ZWV0?=
 =?utf-8?B?eDhrencxMVhMeHNiUzZCNTJ4NmY2VVpVdDZCOVhBYVEwQm9TTldYUWZGSTRD?=
 =?utf-8?B?bkVSUCs3TlF1d2JVbmRWaWFmWGVMbTB5eXNCKzFONnVocllmR1oxZUZuY3cy?=
 =?utf-8?B?Y0tjTW1mcjd6RHE1amFGOGt6dm9lMmYwTFN5a0h4dXk1TzU3K3N0L3BydjBC?=
 =?utf-8?B?bDhwbDA2endaeFA1M2EvRGNmd3VIM01RUjhJa1JoR3lZVUQvQ2cyZzhPaHBk?=
 =?utf-8?B?N0doc2JqR2FsTUJPM1FtaEEyUkdLdmFhRndkTkJ5RmVqSHpGTHMxUDBRaHQ5?=
 =?utf-8?B?ZFZkN3Urc1RENUswOTV3TkY0NHVTQ1cxR1pFc2hudUVYU3I5NmJZN3BTcVFE?=
 =?utf-8?B?VmxGMlNOY2pVV3BsL1RwSzM2S2xlVmpDeFJKd0ZoeFFmaDVpaFBVS3Q4eGRT?=
 =?utf-8?B?R2krbXBqcTdSS25zZ2hGcmRLQUVUVm1tWVVLNUlQVzZpbWtzY2VqYkxQQzl6?=
 =?utf-8?B?Z0RYa0NtYjVGWVZZaU82Y3FxSkszd1ZqanRnbkY1T3UzTW04UW9DNmVQQ3JO?=
 =?utf-8?B?Z3pTdk1qV1E2UkVVTjBOZUxXSFpKTVV0N0pwL0VZcWhSSCsxYlFCVEx1ZnlM?=
 =?utf-8?B?OTgyL3NCWml0UHlXQ1U3b1haMHJMZzEySjA4YWdzeGZDMzlCcUVwQ0Z4ajZS?=
 =?utf-8?Q?gDm5YUbmiLl8rSqPNHExigk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3212d83c-9c5d-4506-ba38-08d9a33c8bfc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 04:51:09.3617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfkPFDiyYi5pWhh9KbA6RS/RdaDsL6TBiFjqt4hf0QFvlw8ebxhuNkdSwmGjmF6l94ZjRBnHDBqE1X2Y+2Hsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
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

Am 2021-11-08 um 8:37 p.m. schrieb Ramesh Errabolu:
> MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> domain before enabling PCIe connected peer devices in accessing it

The PCIe connected peer device access isn't an issue on the upstream
branch (yet). But in general, it is a good idea to pin these SG BOs.
There is no good reason to have them on the TTM LRU list. And they do
reference fixed physical addresses.

See one more comment inline.


>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4c1d6536a7a5..d9a1cfd7876f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>  				      uint64_t va, void *drm_priv,
>  				      struct kgd_mem **mem, uint64_t *size,
>  				      uint64_t *mmap_offset);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> + * @bo: Handle of buffer object being pinned
> + * @domain: Domain into which BO should be pinned
> + *
> + *   - USERPTR BOs are UNPINNABLE and will return error
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count incremented. It is valid to PIN a BO multiple times
> + *
> + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> + * Will return -EINVAL if input BO parameter is a USERPTR type.
> + */
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
> + * @bo: Handle of buffer object being unpinned
> + *
> + *   - Is a illegal request for USERPTR BOs and is ignored
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> + */
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
> +

These declarations aren't needed here. The functions should be static
because they are only used in the same source file.


>  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
>  				struct tile_config *config);
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4fa814358552..f4ffc41873dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>  	return ret;
>  }
>  
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)

static


> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> +	if (ret)
> +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> +
> +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return ret;
> +}
> +
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)

static


> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					   struct file *filp, u32 pasid,
>  					   void **process_info,
> @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	if (offset)
>  		*offset = amdgpu_bo_mmap_offset(bo);
>  
> +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
> +		if (ret) {
> +			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;

Actually, I think this is wrong. You need a new label before
drm_vma_node_revoke to make sure the entry in the node permission
structure is not leaked.


> +		}
> +
> +		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (ret) {
> +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;

Same as above.

Regards,
  Felix


> +		}
> +		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
> +		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> +	}
> +
>  	return 0;
>  
>  allocate_init_user_pages_failed:
> @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	bool is_imported = false;
>  
>  	mutex_lock(&mem->lock);
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>  	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>  	is_imported = mem->is_imported;
>  	mutex_unlock(&mem->lock);
