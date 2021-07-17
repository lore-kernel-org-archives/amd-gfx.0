Return-Path: <SRS0=JwSO=MJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA33C636C9
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 05:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57FA61285
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 05:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57FA61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344BB6EA14;
	Sat, 17 Jul 2021 05:37:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F383F6EA14
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Jul 2021 05:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBsuQ4K21cuR8fCIzUIAiiG054Wlp7SiH4BkVgbNi8MkWrSrascNUmSmRw6LMfidsPi1MBPxlk7eEyu7bLGdpIoQN3px/ewe2PSvbvccmA4L3wVCWwbXi4C1vO3ewAoM/TU/D/SJzA7NAh6V3OXViWT5MspajndyYo5o5F7avIvI9gIJly2fqP0fi0AlgT+cvZ5nXI6D+VnyrutkVoW4N2FcxsgTTl8SSprFUe3y5llEE26wSUPkzDsUICU8EzloNX4mjFDOYf4F8u139dSEyIIKzpBG/WIh7CWaydQynzkvf1wy25z7R++aWQw8VCTaEkybeimWrH55X0/n6edqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8lQ66VnAYNYQGtrrPkusHzR3mHc+bCONyYf+Sib5Lw=;
 b=Jh7TbiXokGGKl7X0xZoFIrUq4u4Z9N2a4Ml5ISE7fW9GCoAWiIMlgI1qUBd7l0jNZD72SDgT3DeeBOiynrlmR0dnf4KS/jvHidoJBdxiQkD9pNMSjCQNrBEwX8M9b7QhunUEJzXZTpJxFEeuLEk7ZQSnCiAF/8JCzx568J0/HzrkGplw4hPRKFgOCGx2jwvHbndHxX9x+4vagV5mMIDfYiZGTNgxLAHpXwOmanXs8WkztT+IBpi/Caca7J+8eFthU9En+8sM2+fBVfko6FexwmB6oEkjM4OWrM2w9w02kW4fpxNtTWWheFsAmBYq32JzTbdrz7p1qjOCyVSQfFvDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8lQ66VnAYNYQGtrrPkusHzR3mHc+bCONyYf+Sib5Lw=;
 b=hxi1wR9VchO8m5IqQGZ5wg06O+91HvUJ2Fz5CZgT9DZQWFjce1SxVIXgloAoSsjTCGq1+sSLOjkT0GyWcecorYw86Aw6+QyIqh1Se6wWfvlh1qFoIjofCv+tmkQZYwyTULgcfo7REKrVAfGEICTgSJxqGDElIkxncn4sKnodASI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 17 Jul
 2021 05:37:02 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 05:37:02 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: report pcie bandwidth to the kfd
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-3-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5c495819-ee12-9267-13d3-4b07e8a27e11@amd.com>
Date: Sat, 17 Jul 2021 01:37:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210716164312.896939-3-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 05:37:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73477d08-4662-47f5-0fe0-08d948e4e753
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5337D50E1492D6EA1F22EE1892109@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV79FEJESSgg5YcWN/xgkNg7V5uKTh/UWuYKaSXHiYLwdZdW75uZnWXT78nRhD1nfBuqqOaKfk3Ey4LxdRJJ26UIE0l08Jl5fctEJSkaaMSYDYa0H5BIdjd4ycAI4tXMCxfYSlGNYrOEmRJQ3kZ0LEbFVf/epOcClNC4lwSzbMnvlhqNVmQDpRcCqlQrwdYeY7FOA1Gap1FLDDShCPuhRG1+9ahZimgXxmZ2VyNHBu+fUtZ8ca6aNAF/fGqJyTFLp77i4BQybBtSKKrLMrnngtvkYtMIjOu3PCHvch7XJO+jffo72pK9oT+g0Wgmyei0pLI0H9DGz8nBJBp/YhdGDPucTszgT4rzdTfQ+Obcb+X/dgpB8IhM7MikzcGRIwmWyYRF0/sevEdzAN2U3R1JUJKW8UV3u9bS1rO1tnZIbPe4tiv4NwVsl+tUNS2Q+zq5jKm7DMb9tQ8o5adi9JzZZIGTo+WQs8+j1JKsw/ZYcZ53bAxllNAnOXQ0/CPr4I/r+zv1TZuVhVWBHi0KmpfqDanKQeHQHxM0h4ZQUxohcHRYBbwwtc74PL4ZXuQne53TFGcnMisIjkD05FCSK9DyWxI2a4HXqQ2p6HHyIBMqhcqLOjrbw0Ww/kSm3hJwCeQ8biCmVu90jyPFu1t75OSFKAnuv/Z6maaxo6G+7XlsJlI6eLrqrrYj/bXuQ3U7v7354Ij8Fr29nvaXusAqT+BS1o7hMA4PUqMwxI9Q+OYQ08zPFTcCSXtjKIZRdcc+eiFK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(316002)(31696002)(8936002)(36756003)(16576012)(2616005)(83380400001)(2906002)(8676002)(86362001)(26005)(956004)(44832011)(6486002)(5660300002)(66946007)(478600001)(66476007)(186003)(38100700002)(66556008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhNMnNHRnZUWFlWRDJLS0cyekVBenRQSVF1ZG9Ob3duOGpZZHdZZlgrUUZS?=
 =?utf-8?B?dkJvM3N1K2JmTXdIS215Ry9lckQ3aTkwWW0zNkY2YW1HR0JWY0VNb3Z4a1Ey?=
 =?utf-8?B?d0Q5ZDBXSUZzV1VvSDJ1OUNPY1llOFh0Mk5KTTU2aDhRcVNrZm1XUDdEaU9K?=
 =?utf-8?B?cjROaHFJR3JBZitMSE1GWlBSNW1JMzhEcVBzZmQ0bmt6c3FzTjZaM3JEV2dj?=
 =?utf-8?B?ZHltcXJLSjVzbVBCcmRBK3E4R2VUZDEwdUs3elIvdGdjRlp3NXJPR2tPZ3ZL?=
 =?utf-8?B?R1B2aHJNdEFhQUt3bU9EOG11ZTdOZy9vR0I0MTY1WWtVQlBzYkJUaTNPVWJk?=
 =?utf-8?B?bVhxMXl6SGVxSExZMlEvWldyTTcxWUFQNE1KbzZHdlNjZmtnM0ViWlZ6eDB2?=
 =?utf-8?B?VGtFdHNvZlRYNlQ1TEpRSmJpcDFwTjJ3dCt1RGJkNnVNSHR1QzBCQ043N0pu?=
 =?utf-8?B?OXBXWG1zRHh0Rmd0ZnlQRmlLZmR6N1ZIYkowWFM1MXdOYWxPNXgrUG5NZTN1?=
 =?utf-8?B?RklVYU0zZGJXVW9jTzE4QkVNNm8zNTV3MTZHR0dJSlN3OU1zSXVJRVZVY3pH?=
 =?utf-8?B?OVZlSzUzb2swUWl2Rm5jYlhVVlpha0MzcVM3TjczUjl0NjNhMDVqK0s2cDVV?=
 =?utf-8?B?c0xLcnR0VlduN2lhSGZHL0gxdk9hU0w4U1V1Njl2dm14VFRiK1d6N3pHTkll?=
 =?utf-8?B?L2pnbHp6aVNXNWpzQVFDWUZ6L09rM3FuU1VsdGViRmpwSVcvMWV3dlZKVlZH?=
 =?utf-8?B?aml2SUhqQ0JNVWtBc2NRcFA4MjZBbzlsY3BBUnVmRnRGSm5iSGRrT01veDZh?=
 =?utf-8?B?MmgxdzgzRTNOSmJxb1BUelJaZzFlSjJ0eUEveHNMeFRLVjFkQzJ2bmZIUHE1?=
 =?utf-8?B?RWMwQXlHcTNTckpGNUl1cXhDelVIMGxtQ21jcHNZamgwc05kOG9DMGIyL1d0?=
 =?utf-8?B?ZkVGNHNCMXRvRmxHYUZLK1AzcVZFdmRjazVpRGFJWkE0TVlQZVl1WjRXOEdq?=
 =?utf-8?B?Qk1kbjdJQ2dDMmwvc0tXYTVoanRSaUlyNGFmWTFaczhBcTBrZERXNnZreUo3?=
 =?utf-8?B?dFRrWUVmUEg1NVNlNDlUUU1wcGhHNUVUWDJHak5tWjVFdFp1QktPam5WenlH?=
 =?utf-8?B?WUxpMEpWTExrekJabU0xWDRNTVBhQ1pYREJ4Y25tbGtEdHNqN1lqNFlXMjNC?=
 =?utf-8?B?dHFuOWRIaXhpNWtLVEJKNjJwU3BCUHI1VW9acmZTU2VzQ0JPaTk1OW1tQWc5?=
 =?utf-8?B?dXViSWh6S3V6TTUxeGJ2czV5OHNyL3FjZ3ZKN1VsYmI5QmM1OGpJdTRiYVN4?=
 =?utf-8?B?MlZkb0o3N09VM0NDS21GUStTT25PcEpuQU5PVzZxL3V4VERDUThjR2xoazVS?=
 =?utf-8?B?azdEV3ZXS0ZpNlN3cUFHR0l1bEJGN1BQb3I4VU5OK0FndHIxdFBBZXVaQkJT?=
 =?utf-8?B?TXhNL2gvUzhMTjhuRnB2NGtlc2twaDg3cndlUmRGc3R3NVk4NmZiVERqWlZK?=
 =?utf-8?B?alU1MzdHMUYvVlNVa3Z2QWk0b0xBVmxWNUtNM2FvYzRRZ1VEa1pGWEdzaDVD?=
 =?utf-8?B?QlZvT2x6eTAzT0ZHWHphYVhmR3RPT29PK2pxSG53aHpjRy9WOHhHbjB4M0NF?=
 =?utf-8?B?Uno0Yyt2bkpvUmMzR2N2VEY3eENPeFlQMmJxQW9haGJ6cFJHOFcxQ2lJNS82?=
 =?utf-8?B?dHZhVTlISFRCLzU3RjJEVDdoY1ZEczBwYWt4d2JaSDFnYWxrQmcyUHU0R0Jy?=
 =?utf-8?Q?fVCstlUObN8pGJidxaHpXqT3GMLT7qer+ZOsQNj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73477d08-4662-47f5-0fe0-08d948e4e753
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 05:37:02.2311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wXJ/dO2i6mQUb0B0T4AK9gxX/zxyuGDS9AxdlOtWrqTcf+odZD5aQvcXELANPNbp3g8BaGu2Izy/zHEf+26ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-07-16 um 12:43 p.m. schrieb Jonathan Kim:
> Similar to xGMI reporting the min/max bandwidth between direct peers, PCIe
> will report the min/max bandwidth to the KFD.
>
> v2: change to bandwidth
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 61 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  4 ++
>  3 files changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3978578a1c49..b7db52f1a9d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include "amdgpu_amdkfd.h"
> +#include "amd_pcie.h"
>  #include "amd_shared.h"
>  
>  #include "amdgpu.h"
> @@ -576,6 +577,66 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev
>  	return (num_links * 16 * 25000)/BITS_PER_BYTE;
>  }
>  
> +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
> +	int num_lanes_shift = is_min ? ffs(adev->pm.pcie_mlw_mask >>
> +					CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1 :
> +				fls(adev->pm.pcie_mlw_mask >>
> +					CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
> +	int gen_speed_shift = is_min ? ffs(adev->pm.pcie_gen_mask >>
> +					CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1 :
> +				fls(adev->pm.pcie_gen_mask >>
> +					CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1;

The shifting is not necessary because you undo it below. I think this
would do the trick and be more readable:

	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
					fls(adev->pm.pcie_mlw_mask)) - 1;
	int gen_speed_shift = (is_min ? ffs(adev->pm.pcie_gen_mask) :
					fls(adev->pm.pcie_gen_mask)) - 1;
	uint32_t num_lanes_mask = 1 << num_lanes_shift;
	uint32_t gen_speed_mask = 1 << gen_speed_shift;

With that fixed, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	uint32_t num_lanes_mask = (1UL << num_lanes_shift) << CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT;
> +	uint32_t gen_speed_mask = (1UL << gen_speed_shift) << CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;
> +	int num_lanes_factor = 0, gen_speed_mbits_factor = 0;
> +
> +	switch (num_lanes_mask) {
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X1:
> +		num_lanes_factor = 1;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X2:
> +		num_lanes_factor = 2;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X4:
> +		num_lanes_factor = 4;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X8:
> +		num_lanes_factor = 8;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X12:
> +		num_lanes_factor = 12;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X16:
> +		num_lanes_factor = 16;
> +		break;
> +	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X32:
> +		num_lanes_factor = 32;
> +		break;
> +	}
> +
> +	switch (gen_speed_mask) {
> +	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1:
> +		gen_speed_mbits_factor = 2500;
> +		break;
> +	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2:
> +		gen_speed_mbits_factor = 5000;
> +		break;
> +	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3:
> +		gen_speed_mbits_factor = 8000;
> +		break;
> +	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4:
> +		gen_speed_mbits_factor = 16000;
> +		break;
> +	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5:
> +		gen_speed_mbits_factor = 32000;
> +		break;
> +	}
> +
> +	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
> +}
> +
>  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index e12fccb2d2c4..5d73f3108d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -227,6 +227,7 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
>  int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
>  uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
>  int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
> +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min);
>  
>  /* Read user wptr from a specified user address space with page fault
>   * disabled. The memory must be pinned and mapped to the hardware when
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 40ce6239c813..eada22b9ea69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1998,6 +1998,10 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		}
>  	} else {
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
> +		sub_type_hdr->minimum_bandwidth_mbs =
> +				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, true);
> +		sub_type_hdr->maximum_bandwidth_mbs =
> +				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, false);
>  	}
>  
>  	sub_type_hdr->proximity_domain_from = proximity_domain;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
