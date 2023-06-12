Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED2C7EE43
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 23:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1EC10E2CA;
	Mon, 12 Jun 2023 23:20:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A1D10E2CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 23:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfSyPkLzg9VAW6KJ20n/gkETJqDeFrM7+YHpCoFogcsijNTt/urkWQ8wdqARrljo+ItGg/jdfHi0/jJc5+BEOKO8HqKuriZY3Rzcbj02FPKTPkjm0AtXOcfMvYXMLw461hDLmpHVgGGWhoTFuDmZPxwrgiHe1WBu3+3wZGXAPQ3riYe9BMW7MH4eB/cJVzuc/6/3fSAI9yqPVYMuNBCilrX5/Nbuv7+WM8GOrfVfJpCj00Z4zCZWQ7mYaD2NmSls+Lhi+Psp4xgimA0732SC3hJw9X9xSz+mPQ6YAXzmYQjKyFGQX5voN6xX7MncvgykC8/CfEfTaYdYh7myOiuomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju1NM1C0WlmPg+lCRQ2r1UWzKE++DNK63xISdsQfFrE=;
 b=jVh2cpUTGUqpKRFrteLRD1oFdOHdFJQ2pi/+wn5LECyF/PYtfxcSexQ/Ge/ZOrzj6W0ol2SWhxpex+e8i6MCKXY4ihirLxto+JJhNM/DZlBr5Zvd+xFg56QDsaTwzGdHpgOz/ICsMfK1lhEeWXZmKEM1OhJAfGX8a4ORpT1vUq6jfbhP2K21urzbIcWHKxiEYEYomhc0ZC2dO89UnMViy9fZ+9adM4KWcwE958Ge3TwZTqksi0ypiKHhMgVr/UxgJERpz5tpDqH0q3nh+onzNgj1xlj1vm4F3qEggh7YC2nZL9F+8nL9Lp4TpdHQco6A/+nXwzlYeOU2C39jzWwJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju1NM1C0WlmPg+lCRQ2r1UWzKE++DNK63xISdsQfFrE=;
 b=o8nZsMXlSPfFcA3jsg2cm1Zg0v3YXYslWbJZkrh16ht8bqghIWVR/ujcmsknYAaty6abOUOvA96vjVOAaUROTiu+cf5NHz4M5t7NxW9RB/Yb4z9wRspHUcDscTh+g7HFkcZ6fmUzMeVOJl7XphufjC7agyCXHZ9QEUbWKBD0+wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 23:20:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 23:20:28 +0000
Message-ID: <55e96231-c7f3-a7b7-2131-9c26048bffcc@amd.com>
Date: Mon, 12 Jun 2023 19:20:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu/sdma4: set align mask to 255
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607163136.958994-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230607163136.958994-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: d9756be5-80e7-4877-0b57-08db6b9b9bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMkCKtTktEdG4prQGg+zEtsPuwDVxfO/YhQqytnUyenUrIx7fNbuzrDgdERfkFfz28rHcGa5k2CGIVPvr4HYkbD+i00uFk6ixsl9BTXy1Yu+NRpiIlFvcwTSwIq1ycD7rjn42yyznZ/WHvYWUVwPIWxMzTx+08qABac42PU8eYOCCaSbKsBlBKo2s+SwRVIdG82KT24wvQyjuQEwrEWELuqEUnzdJf1N6lJn1dPHu+dEXmLhBkVIUMrGG+2TWEJUuoDrO3qJMdnGhoXk4Qyv6lXwHtlEDwn0+IuOMNc63BLdXdXBKE2JF4OEIZVvvL1p7pwLBwassrHGdrsAm3AXj0RxNe0g/L6KACKpkGh5RtBo6lOOyfaAmDHtCaWPK4NJefk7wECf9DegCeu/3sI8cF14G0JSnm5iwkVaFG3Z3VD783ZSdQfUaLb6Aj/DxgG51yyI2FQt5C0u4UF3HSKQ4jCktVbVDav4lSpTh+LoTmBrtzL6TdUiMtAP7AU7xtHv0xZ66+i5eyh/Icmki2QWhsbMUtlGtjS8+K7iReWniTVP56aedICMQxKEVi/qLKgToW+h5mKhNHH4H+ArpZUokKvPbnH2bZ0bZ3UH418GLBN2ZQmlTlGnZLzC65sGe7stkcM6ZmayfCn9Xa6HC22+nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(6486002)(6666004)(36756003)(83380400001)(2616005)(31696002)(38100700002)(86362001)(6506007)(6512007)(26005)(186003)(2906002)(316002)(44832011)(66476007)(31686004)(41300700001)(5660300002)(478600001)(66556008)(8936002)(8676002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExjMlFoMDE4ZG02andNRHk1OWJFSTlGRlRWYXZPbnNhRXFPaGV5T0poUCtw?=
 =?utf-8?B?V0t0WHlINjZvV1ZTanN4bDFwWWJEcmVhNkpMUjNZZ2k1VHJDWEwzWm5mY1hN?=
 =?utf-8?B?Yi9KdHFPcTJJTk5WSDVJaTlrY1ZJdVgycVNHNDl1N1p0MVZvV01EaHhiT0sw?=
 =?utf-8?B?RE50SVY4cEVSUDE1S3RnbDFZU2dtOUdvNWhlVHpsUU5oSVlScy9JQnpidk4w?=
 =?utf-8?B?MkVWT2pYZ1RILzcvRFlMckI3SDhVaENCQUFlcXBueTZpNWVDcmhjMWo5M3dC?=
 =?utf-8?B?WmxrcXdlbEJDN0luQ0JyUkdOUkppcFp0Szg1b0lMOG9CMThvY1UvSFVUM3pE?=
 =?utf-8?B?bDBqWitBejc3ZlB3RTYyOGJuaG5PVDV6ZXJKaG9hNkRzWGhGaVRkeFVIZGJv?=
 =?utf-8?B?dHFUZnRRSTN6Y1FpalpwdW1tRXJaelc4aXViaFFwYUJzQUhvdkZxZERwY0Yx?=
 =?utf-8?B?aFlQbEllV3FQMWZOTFJqb0xjekY5dmkwcTE2YzFuN2ZLQnk3RVFLT1hyaGhG?=
 =?utf-8?B?SnFoNmh1UzRtUFNZZ2Qxbi9yT1J0SlV0S3RDYjRKZEN1aW1oaCt6NDJqaUVT?=
 =?utf-8?B?LzVZOVZYM0RsWFFkMTI0MHhGNjdoV3ZHOERyMWRBUXNaTXU5TzFFUmw4Mm9u?=
 =?utf-8?B?ZkJOZ3dXZzZOUTFqdDBYaVV3VkRMVEpwcFI3bS9xeDBoczYyRmxyRjl2N1hi?=
 =?utf-8?B?SDYwWUh2Z0YwSEhwbllvblFFWnFEVENSMHpUVzdLUFE4RWlRQktmV3VxYXRI?=
 =?utf-8?B?VGRuSDJCZVFBcXRBTjZYenlidm9UYTcwNEZ3ZGNaTmhXQ2JUQWJDSUZmejhw?=
 =?utf-8?B?ZGFhWlFiYi9hR0ZoL3NnSnJhdDFjQm5xaE8yUGpGZDZYK2R4T1pTT0RLaDQr?=
 =?utf-8?B?MWVySlFzSUk3UzI1aU5aZWtHdlFHbmRrNXJlTHdqZzg1UTU2M0RYUXBLYWVa?=
 =?utf-8?B?c1RhS3RlQVNQclFmd3BZK0IwYm52SmtwWUlmSllQWGxEb2t3bVVhS3dyaFgw?=
 =?utf-8?B?b2VzZ3VNQ2toYzhESTVOWlcvcE52VlZYdmErUXovcG8weHZvMWQ1b0c5WFJz?=
 =?utf-8?B?TUxRMU1PYUZpMy9GSHVBeW1WT1JqazRRYTd4K3UzMXZZbE9HbCtFeXVYMmVR?=
 =?utf-8?B?VzBhS0MvMStBNVd5ZnVYc1dVaFBPSEhkMDBqMGtHNUNWR3JPRmZQeGRGaEdO?=
 =?utf-8?B?RFkzc2xkM0thQWFSWWRZNWRMNk5QR05heXg2TnlkWE8ySk9qV1ZOb2puS2hU?=
 =?utf-8?B?Y054TldUempqb0R1Qnc3QWVnWkdUdjk1OTluL1NZUXoremhkNDlaU3pkK2Yz?=
 =?utf-8?B?b3MwMW9OVlZVK2ZwazlpaTN6RWV2c3VobDlrUnU0ZlBzSENOa3Vaa2dLMExu?=
 =?utf-8?B?LytiNjViRmFpTWFpUUNtR3JRWXFFYit1T0RMbmNRTnE3bXQ3UHpEb3YwcW5V?=
 =?utf-8?B?RTBBNDhQakVjOVRRYkZaUVZxOWdYRzA2MmlkclVPTWlXaW9wTE9kMGU5RUpK?=
 =?utf-8?B?VXpCQ1pkajJhU01yL1k3RGJ1ZUVlTHZMSkVHRVV3WmExZVUyVXdpSXNEOERS?=
 =?utf-8?B?VnoxZG1kOHJDTFFVZm9QeEF1S29tT2JCOGovb2tFczNnNnhoUmhhd01LWWpR?=
 =?utf-8?B?ekhMbnJuSkU0NGZJd3ZTNG9PUG9VclNTTFVqQ2xSOGtEUmVFT1lTc2tkT1hk?=
 =?utf-8?B?NTdOMnkyT1RBNm5aVUp0MFIrZTYycGkyV3AzMGRLRUFyakpWdnM4bXhiVmR5?=
 =?utf-8?B?MEZwNWlVY1ZRakR5WEZiQ2ZLdjJmYWRxdEl0Si9wcE1jMlpjOXNyUUlwZU9x?=
 =?utf-8?B?RTFBa0g2OXF2eWt0MUV0bVBhU0dxOWRyTkwyVEt3V0pEQTF5ZHF1bWJVWXVU?=
 =?utf-8?B?ZmxlVWZnN1RVcW1CQlN0VnFnNVJLZDViMnd6UkNBZGp2OEFIK1dub3RDcHdm?=
 =?utf-8?B?Mno3N2hJR3EyTE8yVlRlRDZsbGFhTVlVUXhPMGJxeDhDbWt4ZDNJSHc4dFdM?=
 =?utf-8?B?QmtFVGgrUTI4R082Mi8vOWMzbnhTZHRiUW5LMUJEdHF6Mkdia2NWSXV4bnFK?=
 =?utf-8?B?cnNaWW9iSzBNKzZTN2Vqd2VnUE5uMGpLOGovV21xVDB1Mk1vUmNHcmlXUWhM?=
 =?utf-8?Q?jXRKJEf/+np1xxxOvtfcmeinr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9756be5-80e7-4877-0b57-08db6b9b9bbe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 23:20:28.1345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hONUELynboA8qHjHboUy1NRpPgI0aAdEdxLwvxdB0zJYVcHKiYiPTZYF9bZFTv414KFwa9faLQrFBHphEXZk7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

Am 2023-06-07 um 12:31 schrieb Alex Deucher:
> The wptr needs to be incremented at at least 64 dword intervals,
> use 256 to align with windows.  This should fix potential hangs
> with unaligned updates.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 1f83eebfc8a7..cd37f45e01a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2312,7 +2312,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
>   
>   static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>   	.type = AMDGPU_RING_TYPE_SDMA,
> -	.align_mask = 0xf,
> +	.align_mask = 0xff,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
>   	.secure_submission_supported = true,
> @@ -2344,7 +2344,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>   
>   static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
>   	.type = AMDGPU_RING_TYPE_SDMA,
> -	.align_mask = 0xf,
> +	.align_mask = 0xff,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
>   	.secure_submission_supported = true,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 8eebf9c2bbcd..05bb0691ee0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1823,7 +1823,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
>   
>   static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>   	.type = AMDGPU_RING_TYPE_SDMA,
> -	.align_mask = 0xf,
> +	.align_mask = 0xff,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
>   	.get_rptr = sdma_v4_4_2_ring_get_rptr,
> @@ -1854,7 +1854,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>   
>   static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>   	.type = AMDGPU_RING_TYPE_SDMA,
> -	.align_mask = 0xf,
> +	.align_mask = 0xff,
>   	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>   	.support_64bit_ptrs = true,
>   	.get_rptr = sdma_v4_4_2_ring_get_rptr,
