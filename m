Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C51C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C9C10E561;
	Tue, 27 Sep 2022 06:08:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6091B10E561
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb7KrKfGiB7brlDuQFuvNB4y0GJ4K+kHNZrg7pJK0EHnq3dvM1HxcNvUAPn1kGj7Rbq6Vp7Vul4HtoBFeevwQ/UMGUFzb/WLmW3IbzosbYNCXe9aiimxQ7XBlH3k14IzyGgdcH+eLJcKjos1JKRU89PeEz3X1ejRnG/QHOgsP+2A9W2iuYiDxXIoLKXPlTY2QkZVRGzVp0+ks2ZMXBBrYkPMRBB53sajbsLQRedx0HzvF0G1Klff1SmdDn8BsfBkYpjcE/QVMdoZYhPNsXQC7TJYGuvS63yeeHxCCh5KTkPOriV4D+GPko3U4/p+YdnnBYpn/VjjuGjcxNF1wLB5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxsb5vgJJs0efl127GVYILLDZhcZYm/i9EqXMsdt1vE=;
 b=ZfVzlyPCZqi9EvELnDSYmwyTNQfqhtfW4YMc6gddMTJET5qTDVA1wHNIaNVfJS/V3IGOM3kkGIknuRd0q2xIchSq/SsQaCjfgqBEjC+6xvgU0ThluqXUzjeMS+HbeilypQmrBh3EZUi02h+I1CHsjBk4WjUfoYIRVnTqD++168ixctigKRCXoXpsrEpdOEbkpngW23+t0MPBv5QsvXk4gkYO+HjBk43R5ACWbWvi/hEgI69bhLtDj1pbL4GkoWopJjSQYCtPvUu/8BAajc9tciF6/ezgZsNTiSfhM1zgllfATJElgDI8KB/XD+zYWEr2RDLQZS4qmeEI4WQv3NqqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxsb5vgJJs0efl127GVYILLDZhcZYm/i9EqXMsdt1vE=;
 b=It7z6Vc7M5eJ+aqeA6bgIAs7ny0yT5/W3+ukMvBoLR3izvjA9HdYoGcwF38Ig9/prENbgKLCEOqmuCRzUesH2+FOQjuwv1s+ZvYv0uLzMpe81zpSYJNqiuGRY6LF8ta9ga92TnD3QOklFZutJ2ENgTT2NIIzfLk+JDVnuiGcqbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:07:51 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:07:50 +0000
Message-ID: <e1d1d15a-6d16-8e17-7b61-3b73ca98edf8@amd.com>
Date: Tue, 27 Sep 2022 08:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926214014.5450-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::19) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0854ef-0567-4ba4-56d1-08daa04e9bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFDELtUlDwHItkdeOdITC2jhvUbGQ45zDMBBYxdJJQSyykUdfe4I9/mDjrJOWcFGB8ZZLh6Jnbx54mchcH5I14Ws/wCIW/AneuHegqFrC/OygWm+gx5QoU3TjvymwTJbT7LQxNcsPSTStL6SxjbZFMx5wrjS8W72U4+cSCQjnxVWRBqHa+X/1//2Tf9MMKqrV0E/nYph0Fx8gSSSORW2A/PTPh6D1sIRQhYSd4w4f5BT5GmcPmLUMiPorpIisQe34jZ4R9ncbHJ6etEUZQDRHsohI1oOHXkoT1HxxkCpBHN35YjqS8PfnEd2x2b+Ow4Wh0VruAZpzYLMRojC7B4sStdgibNpBLpC/NLpUv7FrENvO8csP2nejN/AfDsN11rIWglou24dovylvxnwYbWS49m06+KDR5ytlMDmsAVDaazWOcfvAzh4DK5T9/nuGFdZAtdXojDz5n9a/4RT7PEM1fi3XscrlxdYQSPm3dJ/7NBI9WmePl3Ua/ZGC8ij+AbNTs9XnZyqdcz2LyPcYGoyDKiPLLyPOvLvw2XPxac4F4c/0oUz5MbAxFeQUPyFQWWvUwnAZG7EPpJwGvKTVtxD2PlPJ3bKtKzGa6iYl4y3IBwUfkiMIvz/XeQyRAn1CqYB9M9i+Sb1K5/wh7D5c4x1hY2VrkHdr6lpByoKmcOiuMwQQq3NZwsp6MLlBZAnRvWJ068THRb9j9ZIqwafyCFUuu+aRLAmw1Wxrbx1g+Rre5DT2kloqj7JLxXrVso7CR/7rLnZyCguQsw+jDUJtR66fqO1Kr4aZXM89Sogpj3xYOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(6506007)(4326008)(6666004)(478600001)(41300700001)(6486002)(66946007)(8676002)(66556008)(66476007)(316002)(36756003)(38100700002)(186003)(26005)(2616005)(6512007)(86362001)(31696002)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0c1VmYxTVZPV3pLbFBhTm5VNTRWOWx4SmxJQ2N3ZXZRL1BTV013SjNoWlN1?=
 =?utf-8?B?MXY3ZCt2OFkvdjVsdzFiU2l4Z216NGtaWWZIRkFIV0UwYkxzTWRLa1JWYm9k?=
 =?utf-8?B?OUxNZDdHZ1pOaXQxeTQ5MEhCdHJDQjh2bU9LcEdUeFlpQzhTcWZZRFZzamF5?=
 =?utf-8?B?VytjRXVEOGRiZ3R5UDhIckQzR3laVXlwL0Y3M0ZNQkEzWUl1VUJFRmFIMFZw?=
 =?utf-8?B?K3dJWUR1S2dDODlzVDBaRTNjTFdsN3lsK0JJM29aYXRPZmVPV3pKYllpZkha?=
 =?utf-8?B?blM5Z3NxMmdzNVBpeC94d2VJWElPMm1uZkVOWmt2RFdxYU02NVRRVkxFTk5K?=
 =?utf-8?B?MU5KVHlHTmhiL2FsMGZZN05ha3JFR0ZaYndZQnlIRWNBMUUzVGx0SUFSRjVW?=
 =?utf-8?B?aWpxTDNXTWU4cXoyeFBEQ0tqMXZUaVN0Y3E3cHZBdlRQNjA4V1lITUdkOWRu?=
 =?utf-8?B?NWdEWlMzZEtndkUyWDZCUHo3N3BlNzNTQUJWcjNZZFp5bk42OGNrcGYxTTFz?=
 =?utf-8?B?NmZ5bmlCMUh2L2VSVFlvOHduRnViWjdGTExvOUlTdU5CM3A0cW10MkxIVWZj?=
 =?utf-8?B?aWs2aFNxSW14eXA1US8vTWNKK0w0Z3FUUE4yclZ2RExrdVVEeVlOYnVCdnlh?=
 =?utf-8?B?b0g5a0xFWVZENUlwdjFmNVhtS0ZuSEsrc2o3TWxQVGw0dHVlNEl1S3YxWDFR?=
 =?utf-8?B?UE44S24xaW0wcHN6Nkx6bCtDR2tVVDhCTExjU2wxMmtWaDdqbHF0TWlQVmxI?=
 =?utf-8?B?MEZCRFBXV1BaeFVrcUFMMHRHNEkzTjd4d3N1MHZYR0srKzJscjRhbzJiV05G?=
 =?utf-8?B?Ti92NHptZGREU3BEb2txbUc1cG5LUUJiYk9tOS95ZHZwT1ZzOFpCaEx2SVJh?=
 =?utf-8?B?eWExeHRDVkFVRFNPUWRubXJhMTZydEMxb0h0bkp3YTkrWi9jM1pPY24wUFZ3?=
 =?utf-8?B?NmFKN0FuVStvKzFodkRjSlprWG9jQ09lMkc2MGl6MkRTL0dMM2wzRVFCSzhD?=
 =?utf-8?B?azJWWXRrV0FrUzljK3FPTlVsZ0VZQmxoM01ZNWFrV0s2bEw4TFN0MENVTVBl?=
 =?utf-8?B?bHJRWVJUTnFJV3ZmdlRKazkwZkJ6VTB5bGY4QjlMVjBlSjI1TVgzREFrbHRK?=
 =?utf-8?B?Nk1pU1VCTGZBUlNoQ2tKdWptTlowbXh0SmpmNUpDSjNlalRXR3hhTDFRRGU5?=
 =?utf-8?B?L2N0T0x6YlQ0bkhIUEFheDV5OURSZmhoczlvR3Jib2NmdGs0UittZ3BQNlBz?=
 =?utf-8?B?ZlFDbVV4SzFyRG16NFVNTjNGTTgyS2EzbkdSaGpRTUhRVmF1ZGtGTmFWYjhX?=
 =?utf-8?B?dm9UNXMxYkp2MFI4cWdJbmMrR29KYmNvWTBCQ0RHSFRjZDkzcElFamtNaDN0?=
 =?utf-8?B?NW1JVXhaMGIxSDc2K3lhYzVrRHVQN05SNm90elQ2eTYvY1NwNXBBVCs3TmNH?=
 =?utf-8?B?cGd6NTJmS3R1b1NGSHpBNGpkWG9mK2JSV2Q2UFlUWllIZjBKbi9RNDVEWDd0?=
 =?utf-8?B?T1NRN0piaGZGT2xqMlM2a0xaK2pabEdPNzQwNWtzN1oxbU41NXZQSE54djhJ?=
 =?utf-8?B?VW51dURtZVFnYUxsM0RTNngzeDl4OVROaWxvVEtRdjQyUnU3b3FDM0I0cW1t?=
 =?utf-8?B?RDliUDA0QjRMMms0QVl6OHBiSXBudmdCMlNzOEJaSHBTS2dNd0ExejBLaTdL?=
 =?utf-8?B?VVNBci9VM01aVFgrZnMxdGlLTU9qSzcyM3VidldwUk0xcXZPWGF1QmNyb0k0?=
 =?utf-8?B?cnkyTnBRQzkwYjJQamVpNmVTQW9zQ1lZbTlxWk12Z1U3a29ocnlpWVVvRUJN?=
 =?utf-8?B?dTl2ZDBHeTdJaVhEQWRCOGd3V0JkOTZlR0w2enNYR1RtRENlSHpLTlNKUEVD?=
 =?utf-8?B?YjA1bnlOL3l3aXhUcnVwVlV2cDl1cHN2VHI3VjFwYVhZSTRlUEo5M29zeHl0?=
 =?utf-8?B?N2lIeVViODRFMHBveWJzaUFyRW9KQ1VrSCtzOEZjdkowV1FReHZKMkJLSGN3?=
 =?utf-8?B?S3kwQnNVM0Jvd0Z5TlJueUViZ1RtQlVVUXVvWkg4bGpUQk1DbExoREU1WnFi?=
 =?utf-8?B?WktDODBuTXdOeU1aa280V0ZIZmVFT3BZOWliZjg3OE9xdnZ3akJYSkFyb0hj?=
 =?utf-8?Q?pl+m+zYF2FLauYV+8FelezM70?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0854ef-0567-4ba4-56d1-08daa04e9bb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:07:50.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N42i8MAigS0PgrfFOR6egkuZoFiBjoT/01zC0efbGCTc134MyXBRtQgkJXvX/hp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> Allow the user to specify a workload hint to the kernel.
> We can use these to tweak the dpm heuristics to better match
> the workload for improved performance.
>
> V3: Create only set() workload UAPI (Christian)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c2c9c674a223..23d354242699 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_OP_QUERY_STATE2	4
>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	7
>   
>   /* GPU reset status */
>   #define AMDGPU_CTX_NO_RESET		0
> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>   
> +/* GPU workload hints, flag bits 8-15 */
> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX	   AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)	   (n >> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +
>   struct drm_amdgpu_ctx_in {
>   	/** AMDGPU_CTX_OP_* */
>   	__u32	op;
> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>   			__u32	flags;
>   			__u32	_pad;
>   		} pstate;
> +
> +		struct {
> +			__u32	flags;
> +			__u32	_pad;
> +		} workload;
>   };
>   
>   union drm_amdgpu_ctx {

