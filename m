Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2966C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B197461247
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B197461247
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329C46EAC4;
	Wed, 22 Sep 2021 07:54:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8556EAC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 07:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQbdvXK9ZMbavYilO8n8JoFkza1LErpgEwZrysBSixxn8L+UnnribZfIxZkF9B/NozWvCbQDe/Z7uhxmx0ulvNSGklIGwoQWpB4ZqVezWyDzUKh62CaUaVqhG9tDWo39lgwShTg5dU1Cb7S2n3aRUJQ2YWlyuLDBUyV3Hv28EIwHXEgVPkGGbqGBnjECTeYbh4TZOi/u05w0dcZPWARwN1X12kjMXzB1gdEO2M7tam2q0Eec/Kf1r2Iqipigz4o28Vy0iM0g5H3sHiVeBz66BG0IdiuWsByCDa7zMW2HEMd5lplxV/Ga3WJ1hllVFPQMCzwRgPsMktHhK2VzV7zQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5z/GByxQ4Xtl4ZrCUpC35IJBqC3iLoe4epBJaisR+uY=;
 b=hHVsxiMtAxKv8ZFi7Hran9QtkgCMKYpBLxuYFaFw+1VUA2v+STvPAtbH6tgcw5kCiEzQ0bWBqB8jREkYgxdCGFAeXPQRFpEwXd030CzdABZYA2rxH405JAzuM5ttqH5+quzYluT3c71SQ+C5s1BsH/CglzYcWcVX625YZleNuegvg7KtKFh6nX0c0gRUGdD0BnF5tX99EctY2Sh6Kt56+m6u/OX2U4wbZ/7TUgbfnKJzw9PBR9ECTrS+1Fn1BdvvGySOObg/whhnT/lI06yGDVQz5BDMU3ORRCOBWHMK1GCqRnLI1y4Ok/A0HqL9sx8h5ryXulRULt9fYcUgcq9I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z/GByxQ4Xtl4ZrCUpC35IJBqC3iLoe4epBJaisR+uY=;
 b=ulVzCkF27Yh+CxCDmmV6iNS+BCMc7ELPMOBMe7jI4P2VZZ1B1NFgh1FZsb0Jxt+9+smh4oZozYNAaCM9Cb0N0HXpfFhLsyCPU6G4YlRcj+xTlYV5kbEl5KcgPp9KADZwgEp9CYgOO1SIr8TKL4cDPBa5mRdAlA9ID5KqrJMkC+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 07:54:27 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:54:27 +0000
Subject: Re: [PATCH 33/66] drm/amdgpu: add initial IP discovery support for
 vega based parts
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-34-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <4da2f4b6-d818-5a3e-d600-f8cedb6591cc@amd.com>
Date: Wed, 22 Sep 2021 13:24:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-34-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::6) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0151.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14 via Frontend Transport; Wed, 22 Sep 2021 07:54:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74b5a5c0-daf2-4aae-2732-08d97d9e335d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31144E560A7BFB85AECCD2B697A29@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pM2DLIoiFIQLtI7FBRtlsR7xwoRvJ7C9k3KbrZNIlfS0WH2yqS7cC+HLP8nIM8hwgvfTqGTSpfwlneW5064T7Qb8/vUEaQfA+XeMUdQe2WIE9VVt2qDKOXRCtCfhjnDDtAstazkOv7ih92UCrcHypFwuu1ipJJNG9sp+1wYqkM6h7UEEkmpajd66Ky7Rvs42/Cilz2wfZzXl95rOqDhjK6uNlnptqMi28JdOP7RlDpYdBB15DHflNxiiqmYNxrgeEFiObB1/MELj1gTw3A9dPgeyG7pX1b5VcIvUQdiHGuMyqPqBl2YGb9pJWjqXPyYbJDAirManzQgkOMDih+w9/t6yYy6mlM0Bk8+7/x+B7/ZnfWGEPe2K3IbIeCYGQuxw0ipR6QQ+szuR88AtMSBJneFId0SRfsQeCJEjZ83ZTYMn7yFfA6trZdtsu6es1Jd2EKRHoHu/qXaDLnflmlyFu3DjXdMjyM9XagYAE+5IZ7OKdZGIU1MyHxIp4wZ711biOQ1oUVoGPqCR2WSkERPFYIDoqGeDyimeS46xgAnUSaIHyviC3v5N+ute2fJmm+yypDn0mt5D+QQBmrKnCb5x+TomPzOq/MFLoxdXYAaS3aVUcEnOqQO5SV+DK9Ns/JBz9vwpDE5Mz7kE/daPdwCA3IApg84zXQOelCbowz/Z6I2+8Np2D7NR/ZirnlDvxY9p28ghMbf8gjkgjwW5E+BlglUsR+/n6075LCgNXTq+88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(26005)(86362001)(508600001)(2906002)(31686004)(38100700002)(956004)(8676002)(31696002)(83380400001)(186003)(5660300002)(36756003)(16576012)(316002)(66476007)(6486002)(8936002)(53546011)(6666004)(66556008)(30864003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhIVzV0VURqdzAxTVV6eFlkYWdEcUw4R2dYc3c5UnJhWCtpODNLa21KL21h?=
 =?utf-8?B?U1ZMdG9oejBhSGNwZDA0azVWTlpRSXFsOHNSUUJoZVV2NUZMZ29lY2twMjJ4?=
 =?utf-8?B?N2VPMlNCY0JrUjdVajBmVGV2Q2F2WVZTV3VxbDR1SVFnaWxxM21hdWJIaS9Z?=
 =?utf-8?B?S0FMMGFEWElFckgydHJyWUNpY3dDRzZTS3BuakhBbldkME5vU0xCUk05MVhk?=
 =?utf-8?B?aFgvVFEzWitEdlU3Szd2Q2czT1hYQW5tcUozYm12QlhaT2s2SnREZmttYzQz?=
 =?utf-8?B?dVFEOWFnMW1CU3RhcFVxUE05a0RUckllUnJNTmoxTmREVVRYQXRwbVBnMUh1?=
 =?utf-8?B?a3JUd3hURi8xRHBkbTR5MXZodnBkRzVFV21wS0J4ODJVbnJEN3hJRnJ6UFRp?=
 =?utf-8?B?T2hiT05vNDRhRy91SldtVTZCOVlCSWxJZ0V5WnM1dW9GdDJiaDNHY1NSVlhD?=
 =?utf-8?B?R1ZGZHIxZDdoU05EOEUzZ0VvMzNyMFZHTVpmZDRXZ2xFVlRxSTA1MWRjcXZx?=
 =?utf-8?B?L2RaSDhmYlEzUzc1NUZ0Mk9EczNDYk1oL1UwM2psUldVb2R1a2J3UW1TSjE4?=
 =?utf-8?B?ZmMrR0ZBZk5DLzIzUGRkQU5WQjZOYzZTOUdoS00vRlArSndmL1lWZmlXUlBD?=
 =?utf-8?B?WlFMN0hINzFNUmgyY3BCUUlvWllnQUhJZk0xL283dlJaeWV0ZmxYTHJud3dr?=
 =?utf-8?B?cDUrMGNlMTdrTVE4ZHpsZ2FaUXp4VnNPeXFobjk2MUdRc2hZRGhmNm5SRFVC?=
 =?utf-8?B?WXppVXRjQmxuV2RLWGdLM3ZDbmE0ZUhwdEsvUGNOMEs3OGVST2p4bGNaUUtR?=
 =?utf-8?B?OWFnZ1FYazFHaHY4ZXd1UjJHZG81KzR1RlE3ZnMzU3JrZWFmaklzWkUzc1FR?=
 =?utf-8?B?UDdqVEZsVHJ0RDR3L3MvK2htU2JqOHdyblM2bityZXdlenlaM0RJRVFuRWhF?=
 =?utf-8?B?TkxBZjFYNDhpYkNJcGhONjdDb1gwc1NQREkxSjVodGMwVlkra2ZXd2Z4N1A2?=
 =?utf-8?B?RTZOZjRMYnM0K0ZCWWgxYldUaDRoY0d1eVREM3BBOXJUOE1Bc0RRbUMwY0k0?=
 =?utf-8?B?aGU5VzRUN2c2ZW1CR1d5UjM0WndRY0VhNE5McWhydGJwM3J2RWlVMWFJdDZp?=
 =?utf-8?B?L3hRYkNhUkdqeWRMRVNHbkJ5Y1V6ZnRtYWVxd2JBVDBNYjNpZW1vZjZnbFpI?=
 =?utf-8?B?WE5OYklnaTZac2pLU1Ribk5NaVZteERtVlpnYVlIVUU2ZURxcUdwWE1tblda?=
 =?utf-8?B?RVQ1em93UXNZV0VQZzc2T09BMmpGM0xJSkRTMmNzS0YrU1lBVUw1cDBmeFBn?=
 =?utf-8?B?bXV1SHpwaTgzb2FMZ1o5N1M4a3JXVDVjUXVZYWZOK2FXRmNCYy8zdWxVVjVO?=
 =?utf-8?B?RC8xMkRSVjNVT1dSQnpoWEZobmhDejlETERwbG5FakJmaHpzc2lkNU81Wmw5?=
 =?utf-8?B?NUFlZWZ0UGlOWm5pcmNHTC9VNzJCYm5BUTlvaHlrMXlhUHArSXMxUzFoNFF0?=
 =?utf-8?B?M1ovN21VWmxFbkw2WXRMY0dVOXI1ZnZaVElWbnlxSXBJWG1lcWR0dmxFcEtP?=
 =?utf-8?B?ZklELzY5aHdocGlrZzVyN2c5cGc4bW10L2dtT1V1NE1Tb1hqRjdpT1lUYXhi?=
 =?utf-8?B?ajQzOWFNM1FYOHpJQk52dVJsZ1pKUlBhTEJpQmpMMmZJMnNYQU1RRCtQUkdT?=
 =?utf-8?B?NUxGaFl1MUs0ZmpOMGNsQlkyQUtmNHdnei84a1lvNFlmdkM3YUFSVzZVUFAr?=
 =?utf-8?Q?unKERQB1cub4QD3HkTz1MjoQ1OiQ5VdX8GVfHwH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b5a5c0-daf2-4aae-2732-08d97d9e335d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:54:27.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbh+8u7MiVlybC3sbWjH2PDeGA5RvnkrkFNXIUTaenYLDAQ/+RbvVZzPdorO9IID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Hardcode the IP versions for asics without IP discovery tables
> and then enumerate the asics based on the IP versions.
> 
> TODO: fix SR-IOV support
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 417 ++++++++++++++++--
>   1 file changed, 387 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6a993043badc..e3b4578872f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -26,6 +26,26 @@
>   #include "soc15_hw_ip.h"
>   #include "discovery.h"
>   
> +#include "soc15.h"
> +#include "gfx_v9_0.h"
> +#include "gmc_v9_0.h"
> +#include "df_v1_7.h"
> +#include "df_v3_6.h"
> +#include "nbio_v6_1.h"
> +#include "nbio_v7_0.h"
> +#include "nbio_v7_4.h"
> +#include "hdp_v4_0.h"
> +#include "vega10_ih.h"
> +#include "vega20_ih.h"
> +#include "sdma_v4_0.h"
> +#include "uvd_v7_0.h"
> +#include "vce_v4_0.h"
> +#include "vcn_v1_0.h"
> +#include "vcn_v2_0.h"
> +#include "jpeg_v2_0.h"
> +#include "vcn_v2_5.h"
> +#include "jpeg_v2_5.h"
> +#include "smuio_v9_0.h"
>   #include "gmc_v10_0.h"
>   #include "gfxhub_v2_0.h"
>   #include "mmhub_v2_0.h"
> @@ -45,6 +65,7 @@
>   #include "mes_v10_1.h"
>   #include "smuio_v11_0.h"
>   #include "smuio_v11_0_6.h"
> +#include "smuio_v13_0.h"
>   
>   #define mmRCC_CONFIG_MEMSIZE	0xde3
>   #define mmMM_INDEX		0x0
> @@ -485,23 +506,166 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -
>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	r = amdgpu_discovery_reg_base_init(adev);
> -	if (r)
> -		return -EINVAL;
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA10:
> +		vega10_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 1, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 0, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 0, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 0);
> +		break;
> +	case CHIP_VEGA12:
> +		vega10_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 5, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 2, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 1);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 1);
> +		break;
> +	case CHIP_RAVEN:
> +		vega10_reg_base_init(adev);
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
> +			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
> +			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
> +			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 1);
> +			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 1);
> +			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 5, 0);
> +			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 1, 0);
> +			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 2);
> +			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 1);
> +			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 1);
> +		} else {
> +			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> +			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 0);
> +			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 0, 0);
> +			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 0);
> +			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 0);
> +		}
> +		break;
> +	case CHIP_VEGA20:
> +		vega20_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 1);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 2, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 1, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 1, 0);
> +		break;
> +	case CHIP_ARCTURUS:
> +		arct_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 1);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 1);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 1);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 2);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 4);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);

Just found that this version is shared with VG20. Since it's a soft IP 
version table anyway, any problem in changing to say 11.0.3 and avoid 
ASIC checks?

Thanks,
Lijo

> +		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 3);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 3);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 5, 0);
> +		break;
> +	case CHIP_ALDEBARAN:
> +		aldebaran_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 2);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 4);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 7, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 6, 0);
> +		adev->ip_versions[XGMI_HWIP] = IP_VERSION(6, 1, 0);
> +		break;
> +	default:
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (r)
> +			return -EINVAL;
>   
> -	amdgpu_discovery_harvest_ip(adev);
> +		amdgpu_discovery_harvest_ip(adev);
>   
> -	if (!adev->mman.discovery_bin) {
> -		DRM_ERROR("ip discovery uninitialized\n");
> -		return -EINVAL;
> +		if (!adev->mman.discovery_bin) {
> +			DRM_ERROR("ip discovery uninitialized\n");
> +			return -EINVAL;
> +		}
> +		break;
>   	}
>   
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		adev->family = AMDGPU_FAMILY_AI;
> +		break;
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +		adev->family = AMDGPU_FAMILY_RV;
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -527,6 +691,23 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	/* set NBIO version */
>   	switch (adev->ip_versions[NBIO_HWIP]) {
> +	case IP_VERSION(6, 1, 0):
> +	case IP_VERSION(6, 2, 0):
> +		adev->nbio.funcs = &nbio_v6_1_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
> +		break;
> +	case IP_VERSION(7, 0, 0):
> +	case IP_VERSION(7, 0, 1):
> +	case IP_VERSION(2, 5, 0):
> +		adev->nbio.funcs = &nbio_v7_0_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
> +		break;
> +	case IP_VERSION(7, 4, 0):
> +	case IP_VERSION(7, 4, 1):
> +	case IP_VERSION(7, 4, 4):
> +		adev->nbio.funcs = &nbio_v7_4_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
> +		break;
>   	case IP_VERSION(7, 2, 0):
>   	case IP_VERSION(7, 2, 1):
>   	case IP_VERSION(7, 5, 0):
> @@ -549,6 +730,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[HDP_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 1):
> +	case IP_VERSION(4, 4, 0):
> +		adev->hdp.funcs = &hdp_v4_0_funcs;
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -561,8 +751,34 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	switch (adev->ip_versions[DF_HWIP]) {
> +	case IP_VERSION(3, 6, 0):
> +	case IP_VERSION(3, 6, 1):
> +	case IP_VERSION(3, 6, 2):
> +		adev->df.funcs = &df_v3_6_funcs;
> +		break;
> +	case IP_VERSION(2, 1, 0):
> +	case IP_VERSION(2, 1, 1):
> +	case IP_VERSION(2, 5, 0):
> +	case IP_VERSION(3, 5, 1):
> +	case IP_VERSION(3, 5, 2):
> +		adev->df.funcs = &df_v1_7_funcs;
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	switch (adev->ip_versions[SMUIO_HWIP]) {
> +	case IP_VERSION(9, 0, 0):
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(10, 0, 0):
> +	case IP_VERSION(10, 0, 1):
> +	case IP_VERSION(10, 0, 2):
> +		adev->smuio.funcs = &smuio_v9_0_funcs;
> +		break;
>   	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
>   	case IP_VERSION(11, 0, 4):
>   	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 8):
> @@ -575,12 +791,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(13, 0, 1):
>   		adev->smuio.funcs = &smuio_v11_0_6_funcs;
>   		break;
> +	case IP_VERSION(13, 0, 2):
> +		adev->smuio.funcs = &smuio_v13_0_funcs;
> +		break;
>   	default:
>   		break;
>   	}
>   
>   	/* what IP to use for this? */
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -599,6 +828,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	/* use GC or MMHUB IP version */
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -616,6 +855,18 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[OSSSYS_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 3, 0):
> +		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +		break;
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 1):
> +	case IP_VERSION(4, 4, 0):
> +		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -630,7 +881,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   		switch (adev->ip_versions[MP0_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +			amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
> +			break;
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
> +		case IP_VERSION(11, 0, 2):
> +		case IP_VERSION(11, 0, 4):
>   		case IP_VERSION(11, 0, 5):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -643,7 +903,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 0, 8):
>   			amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
>   			break;
> +		case IP_VERSION(11, 0, 3):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
>   			break;
> @@ -654,6 +919,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   		switch (adev->ip_versions[MP1_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +		case IP_VERSION(11, 0, 2):
> +			if (adev->asic_type == CHIP_ARCTURUS)
> +				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -664,7 +938,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 5, 0):
>   			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   			break;
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   			break;
> @@ -676,10 +955,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
>   		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
>   #if defined(CONFIG_DRM_AMD_DC)
> -	} else {
> +	} else if (adev->ip_versions[DCE_HWIP]) {
>   		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(1, 0, 0):
> +		case IP_VERSION(1, 0, 1):
>   		case IP_VERSION(2, 0, 2):
>   		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 1, 0):
>   		case IP_VERSION(3, 0, 0):
>   		case IP_VERSION(3, 0, 2):
>   		case IP_VERSION(3, 0, 3):
> @@ -693,10 +975,29 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		default:
>   			return -EINVAL;
>   		}
> -
> +	} else if (adev->ip_versions[DCI_HWIP]) {
> +		switch (adev->ip_versions[DCI_HWIP]) {
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(12, 1, 0):
> +			amdgpu_device_ip_block_add(adev, &dm_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>   	}
>   #endif
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 2):
>   	case IP_VERSION(10, 1, 1):
> @@ -714,6 +1015,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[SDMA0_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 1, 2):
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 2):
> +	case IP_VERSION(4, 4, 0):
> +		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -734,6 +1045,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>   		switch (adev->ip_versions[MP1_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +		case IP_VERSION(11, 0, 2):
> +			if (adev->asic_type == CHIP_ARCTURUS)
> +				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -744,7 +1064,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 5, 0):
>   			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   			break;
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   			break;
> @@ -753,26 +1078,58 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	switch (adev->ip_versions[UVD_HWIP]) {
> -	case IP_VERSION(2, 0, 0):
> -	case IP_VERSION(2, 0, 2):
> -		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> -		break;
> -	case IP_VERSION(2, 0, 3):
> -		break;
> -	case IP_VERSION(3, 0, 0):
> -	case IP_VERSION(3, 0, 16):
> -	case IP_VERSION(3, 1, 1):
> -	case IP_VERSION(3, 0, 2):
> -		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> -		break;
> -	case IP_VERSION(3, 0, 33):
> -		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> -		break;
> -	default:
> -		return -EINVAL;
> +	if (adev->ip_versions[VCE_HWIP]) {
> +		switch (adev->ip_versions[UVD_HWIP]) {
> +		case IP_VERSION(7, 0, 0):
> +		case IP_VERSION(7, 2, 0):
> +			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		switch (adev->ip_versions[VCE_HWIP]) {
> +		case IP_VERSION(4, 0, 0):
> +		case IP_VERSION(4, 1, 0):
> +			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		switch (adev->ip_versions[UVD_HWIP]) {
> +		case IP_VERSION(1, 0, 0):
> +		case IP_VERSION(1, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
> +			break;
> +		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 0, 2):
> +		case IP_VERSION(2, 2, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> +			break;
> +		case IP_VERSION(2, 0, 3):
> +			break;
> +		case IP_VERSION(2, 5, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
> +			break;
> +		case IP_VERSION(2, 6, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
> +			break;
> +		case IP_VERSION(3, 0, 0):
> +		case IP_VERSION(3, 0, 16):
> +		case IP_VERSION(3, 1, 1):
> +		case IP_VERSION(3, 0, 2):
> +			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> +			break;
> +		case IP_VERSION(3, 0, 33):
> +			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>   	}
>   
>   	if (adev->enable_mes) {
> 
