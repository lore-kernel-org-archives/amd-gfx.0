Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06752C2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 13:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D6361628
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 13:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D6361628
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C0C6EDC6;
	Fri, 25 Jun 2021 13:29:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7330B6EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 13:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agEZW3pXgfhU/ywYorvSIPJjZrLhPOtqJG0yLS508y09tDNNULz4aTnYPn5docFnaS4QstSL6UCXnAY2yzUZyqy1yI+o1+xV2PGAcPMojhsEu+2ZLltMLoO9K0FQZyzZpK1N85ZJ0Zso1IWXFw+Fjlw9Ayqeb2ZP9ZLGw52jbP58tJwnvSDjFaykF4KEjyJTppZ3QQO5MhGDCiPLarmG3F3LsplnmkQQnvD3890zSeBb8TTJPxr9OW4X+ZwD7h6iDRmsty3nZWGwrUYNgP0Hzp/AjQi793aYrwqjxslewV7Tya+UK3deG6yhyYmZMI6ymwCKbElECL+/G0f4AfVh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfNDT0+ufVGs1PmMuApu7FhwLZnw8ihjGaWNWjyfAqs=;
 b=GMlym6qSHmIELKmp21XtDTd+Gf4xD1WbP9H05epYigi1SLKAiZi7qQgqy3xhQk4zg5Pzqk6ACc4UNbuSkRFNfPcswSxPFaQJ7cIbcY5tBXTk+KCc9z8R7JlMmS7oReThvUtxbmXMtrYKjGBH21MxoyxvvKUf1DobNaIvOxc1wNmhwK3u6tfgJxhKxnyQ4h7xmJW1VMh8z2j+GNG7iWrgn3o4rtA82mb3ta3e8fJ+7egv4EDXVHBpEF9An8Mmie8/neaTO98BNu+vgGQzAbhP9MpdWErIuUCwA90ehVnzmgSLrNekveRlHSHq/UVobKLtqrd07naA0gx4Kpg71SGmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfNDT0+ufVGs1PmMuApu7FhwLZnw8ihjGaWNWjyfAqs=;
 b=kcbc8tutzuS3bKjz2jtEAK6nSUK/BxYlbJUJ7zyQptvy7ouFFQ5Yg+Nn7/YjOJt9PLJWUujnP1PpR7F3M3GzuaXjuAAkPYVCs+UFj5o3OgYIljl05zzobxrL/AOwR6gDrvyYGfEm51oTYIG5MXIpq6YgMUoGmX3CailLco3gWL8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 13:29:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%6]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 13:29:06 +0000
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210625032409.15715-1-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <86c67f76-da5c-471e-16dd-03c434adac3a@amd.com>
Date: Fri, 25 Jun 2021 18:58:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625032409.15715-1-kevin1.wang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KU1PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:802:19::31) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.66.238] (165.204.80.7) by
 KU1PR03CA0043.apcprd03.prod.outlook.com (2603:1096:802:19::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.14 via Frontend Transport; Fri, 25 Jun 2021 13:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768d49a4-5e8c-4ba0-a558-08d937dd34ff
X-MS-TrafficTypeDiagnostic: CH0PR12MB5201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB520151A9890A9DA4B6C9E81497069@CH0PR12MB5201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTTWNMdp9NRfZCW/UUtO93QWracL+5L2ImEd9E8BHj9h+f4431O20v1niFwSqU4DdZiLptF8haCpYObsA1QZbvdH8ps6r39dImMp5IOfy1Wgz1DOVjbgU0FuMWxX/dAlytpODYDDABfIGEFSqFHJQ1bkpxDo3ZrB76PGhE9xnyP2jm+siDtznpJSni1bnLUikYlt808/U9rA6IwBbO0QtXIidM0s5Qik3SU8Di4u5ZpqiSJ25zF4RtEevLvdDgvgfnIHmTup8/lj4VpVsAgpK5Yg2UL0owe3ZI5UZr7kom5xgU0n5ZcDR0QBd+038XYtf1IOZWeEovtJp7GZ8PUZBiJLWeuGn1qG7QW21LllWnzSSSVFezBzEb65/p6HyFINFeVfmbxgePEGB1wx/aIiFtf1kSS8+1Lxb4cIrCWiPcjX4pTsmo+Ri0vjgYU37VN2nxUafNDkVMtDP27ywMNtX7h2PdKhg9Bx/elsg3TCaeTFNyhOh5nfQZglfeK+BJykvltuj16ZXTJc3kz8tOWNLndOjXWZQSPn5LQPcKDKCB2coUIo3CmG4sqkaKKjzGzlLfI5Q7y6oTquhpT8YJ/uqXxTNVTqJZcWmeiEHfq4cmL30FXjUv5TRBCLUKu2vCJZIsokungg9ucqsHpQ/NZl5h1xGoBrX3DqxhUbnOXr8hZFaWHnD2T8luHj5ZJlxfWVEkb5EChhgX4FlEyeluepxIuponfMOR1eamcHIgPLOSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(186003)(31696002)(83380400001)(66556008)(36756003)(66946007)(66476007)(16526019)(16576012)(26005)(6486002)(38100700002)(53546011)(316002)(2616005)(8936002)(8676002)(4326008)(2906002)(5660300002)(478600001)(956004)(6666004)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NmUGJiVHc1SXVQVzdIMEt0bXh5dlYzNksvMDhPRlQ2a3hjN1RJNlJKc0lp?=
 =?utf-8?B?RE9BajAvcmpSV21Md3VmR0RpK3VuOEN1Vmd0eHNRQjY5ay83RTU3OUlFa05l?=
 =?utf-8?B?NHgySnlKRkpCM2V5RFNUSW1xVGYzcVJCVzNKdE91eXF5TU01a2F6alNnV3Qx?=
 =?utf-8?B?bFE0MC85OHpFRjRIQndxQjdqMmF6TjN4akJMTVcwWDBIM2QvMFBEK0l2dXVU?=
 =?utf-8?B?QmNLaHNXS1dFNitrY3BlSnNySU9TeGtvWFBQdW9NYnlUOTVtTzRHWGxYUWVX?=
 =?utf-8?B?S0piVjZaZjV2eU9kYXR6RjFBVWZUSzQ3blZqYmZ5WnQwSUVRRjVZemFlU0tG?=
 =?utf-8?B?YUE1K1Ryb2NtTk5kV2pEbW0xZ2lvdk81bDlLZi95c1NOZ2FObXM1QTZjQ2Nh?=
 =?utf-8?B?a3JncnBNcjRRN0ZNNTRham5mNEljcloxZVc0dkZiekpvVDJnRXhMV2pkZnhQ?=
 =?utf-8?B?cFJUV3FoUGo2RHU5cXk2djVYMTFJTm9rZFdqRExqL2g0US9TdTUzTFY3a3Y0?=
 =?utf-8?B?MDZ3ckdOL3NQUXVRMzdyL2o3NkF0YkQwS1liVlNORnVzWnF4ck81V3Q4Zlkz?=
 =?utf-8?B?a010UHhJbWVWZFNJL0Q1TmdiNXlOZlhDbk51R2lEUjBWWFpYdnF5VW9wK1Va?=
 =?utf-8?B?UExOOXpoeVJMTlV1RXBJK2JkVGZyV3RiZFVHS1BWSEg0a3IrU2E2N1VSS1Uy?=
 =?utf-8?B?WlR6WnhIQzc1UGFMa2xGVldvSk84alloRXBEbGxUUWkxaGdGQWVGQzQzc1FN?=
 =?utf-8?B?bGFxeWZ3UWQvcUdlMmg1QTdJWDFZN2t5NHZibGh0bHVXbko0bTlKMVJkUkNI?=
 =?utf-8?B?aWQ2OC9TWDIwK2xISzA0MlhoakFpaHUwS0RKMzJMRUhWMG5SZnlaaGE2T3Vp?=
 =?utf-8?B?Y25vUS9KTGVwbGppNWJna2loUkxKRXR1YmhzUWQ1SzNZQnBlbTRrbHUyUDVS?=
 =?utf-8?B?aXgrK2pxcTQyazY5YzRUZkJkZzBoWUM1ZVFSTkM2Nnc0T3VJRTNQZnVFNTlr?=
 =?utf-8?B?cVU4SWV4dGsyclpaU25CS25UT3pMR2gwYmU2ZHUxVUV2NHVQdVU1QUgyVU9a?=
 =?utf-8?B?OVZWUTVLM25XQnBvVEJSeFVVOGphbUJVTkNpdWVhb3JaVDFFYmFqVm1HNFlo?=
 =?utf-8?B?QnlUbStHOUVWdTFXNnpCWkxZeVJsZkczU3Rjd2wzSGdIR0pwNnlvTlJTUC9o?=
 =?utf-8?B?QnhzQ1lEMWRIZkI1Y2d4TTlBSGNwckJlS2pSdEwzM3VERmQ1RThka0xEV2RM?=
 =?utf-8?B?ZG5HeWRyM3ptL1hDak9QeXdyVkd0M1o2RGZZd0YwcnQ3UVFhdXhxa0tDK2lj?=
 =?utf-8?B?bFRVWXBKOVgvNGNqVkNyaE9YOEpMUm9tL3JvYUtVSmVrMHdmRVFnWkwrSmp0?=
 =?utf-8?B?Sm9aZ2pmRzEwbDhvQWxxUHA3N2JUajIwVFk5STdDMER0NEhZd2RjQXJUZ0hL?=
 =?utf-8?B?SlJTVXZDY21NM1ArK3RUcU5ENFEyTHkyQ0E2OG5kMEhMem80eTFzaGRiSUhy?=
 =?utf-8?B?MGtObDh4ZjZKTmxtUnk2eU4vcVhHQkRLTlJ3QWUySXBYU1ZkTy9WUUhnNWNB?=
 =?utf-8?B?WEFnQkJnWG1iTGN1OUNkWjR1aGhTdCt3bldib3NUU2prZUxTczlERzZlNWJa?=
 =?utf-8?B?bC9NZzV3OGt6MlNCRS9kYlEra3JLcndiaG8yamxMRWRTUEJ6SEVPb3IzeDRE?=
 =?utf-8?B?NWN0ekFPdU5VSnpLMHNHMFp6MXNwa1Z3SzZKSjNjMlhHZ001UXBHRVlpZEVW?=
 =?utf-8?Q?PT7NHQLFrgg+vT08ZnqTkEvgWXzk4aL2F7GO3gz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768d49a4-5e8c-4ba0-a558-08d937dd34ff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 13:29:06.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+b1+Ifue/G1GCjz3/3wyNlMEjkWN6oiOk25bCkXs9iVpsU3UTZWFIEz4w09faPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/25/2021 8:54 AM, Kevin Wang wrote:
> 1. add non-aligned address support in amdgpu_device_vram_access()
> 2. reduce duplicate code in amdgpu_ttm_access_memory()
> 
> because the MM_INDEX{HI}/DATA are protected register, it is not working
> in sriov environment when mmio protect feature is enabled (in some asics),
> and the old function amdgpu_ttm_access_memory() will force using MM_INDEX/DATA
> to handle non-aligned address by default, it will cause the register(MM_DATA)
> is always return 0.
> 
> with the patch, the memory will be accessed in the aper way first.
> (in visible memory or enable pcie large-bar feature), then using
> MM_INDEX{HI}/MM_DATA to access rest vram memroy.
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
>   3 files changed, 58 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d14b4968a026..8095d9a9c857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev);
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>   
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write);
> +			       void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e6702d136a6d..2047e3c2b365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>   		amdgpu_acpi_is_power_shift_control_supported());
>   }
>   
> +static inline void amdgpu_device_vram_mmio_align_access_locked(struct amdgpu_device *adev, loff_t pos,
> +							       uint32_t *value, bool write)
> +{
> +	BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +	WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +	if (write)
> +		WREG32_NO_KIQ(mmMM_DATA, *value);
> +	else
> +		*value = RREG32_NO_KIQ(mmMM_DATA);
> +}
> +
> +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *adev, loff_t pos,
> +						  void *buf, size_t size, bool write)
> +{
> +	while (size) {
> +		uint64_t aligned_pos = ALIGN_DOWN(pos, 4);
> +		uint64_t bytes = 4 - (pos & 0x3);
> +		uint32_t shift = (pos & 0x3) * 8;
> +		uint32_t mask = 0xffffffff << shift;
> +		uint32_t value = 0;
> +
> +		if (size < bytes) {
> +			mask &= 0xffffffff >> (bytes - size) * 8;
> +			bytes = size;
> +		}
> +
> +		if (mask != 0xffffffff) {
> +			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, false);
> +			if (write) {
> +				value &= ~mask;
> +				value |= (*(uint32_t *)buf << shift) & mask;
> +				amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, true);
> +			} else {
> +				value = (value & mask) >> shift;
> +				memcpy(buf, &value, bytes);
> +			}
> +		} else {
> +			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, buf, write);
> +		}
> +
> +		pos += bytes;
> +		buf += bytes;
> +		size -= bytes;
> +	}
> +}
> +
>   /*
>    * VRAM access helper functions
>    */
> @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>    * @write: true - write to vram, otherwise - read from vram
>    */
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write)
> +			       void *buf, size_t size, bool write)
>   {
>   	unsigned long flags;
> -	uint32_t hi = ~0;
>   	uint64_t last;
>   
> -
>   #ifdef CONFIG_64BIT
>   	last = min(pos + size, adev->gmc.visible_vram_size);
>   	if (last > pos) {
> @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   			return;
>   
>   		pos += count;
> -		buf += count / 4;
> +		buf += count;
>   		size -= count;
>   	}
>   #endif
> -
>   	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -	for (last = pos + size; pos < last; pos += 4) {
> -		uint32_t tmp = pos >> 31;
> -
> -		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -		if (tmp != hi) {
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -			hi = tmp;
> -		}
> -		if (write)
> -			WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -		else
> -			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
> -	}
> +	amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
>   	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6297363ab740..cf5b8bdc2dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>   	struct amdgpu_res_cursor cursor;
> -	unsigned long flags;
> -	uint32_t value = 0;
>   	int ret = 0;
>   
>   	if (bo->mem.mem_type != TTM_PL_VRAM)
> @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   
>   	amdgpu_res_first(&bo->mem, offset, len, &cursor);
>   	while (cursor.remaining) {
> -		uint64_t aligned_pos = cursor.start & ~(uint64_t)3;
> -		uint64_t bytes = 4 - (cursor.start & 3);
> -		uint32_t shift = (cursor.start & 3) * 8;
> -		uint32_t mask = 0xffffffff << shift;
> -
> -		if (cursor.size < bytes) {
> -			mask &= 0xffffffff >> (bytes - cursor.size) * 8;
> -			bytes = cursor.size;
> -		}
> +		amdgpu_device_vram_access(adev, cursor.start,
> +					  buf, cursor.size,
> +					  write);
>   
> -		if (mask != 0xffffffff) {
> -			spin_lock_irqsave(&adev->mmio_idx_lock, flags);

The new logic seems to skip this mmio_idx_lock for accessing index/data 
pair ragisters. BTW, where is the visible memory aperture check?

Thanks
Lijo

> -			WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) | 0x80000000);
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> -			value = RREG32_NO_KIQ(mmMM_DATA);
> -			if (write) {
> -				value &= ~mask;
> -				value |= (*(uint32_t *)buf << shift) & mask;
> -				WREG32_NO_KIQ(mmMM_DATA, value);
> -			}
> -			spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -			if (!write) {
> -				value = (value & mask) >> shift;
> -				memcpy(buf, &value, bytes);
> -			}
> -		} else {
> -			bytes = cursor.size & ~0x3ULL;
> -			amdgpu_device_vram_access(adev, cursor.start,
> -						  (uint32_t *)buf, bytes,
> -						  write);
> -		}
> -
> -		ret += bytes;
> -		buf = (uint8_t *)buf + bytes;
> -		amdgpu_res_next(&cursor, bytes);
> +		ret += cursor.size;
> +		buf += cursor.size;
> +		amdgpu_res_next(&cursor, cursor.size);
>   	}
>   
>   	return ret;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
