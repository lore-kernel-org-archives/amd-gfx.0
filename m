Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8270EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 11:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267DC10E56D;
	Fri,  7 Jul 2023 11:38:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4EF10E567
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 11:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOietrO6FzsyuVdKjy63ygfuKtBt/lJE6sFoWsVqL4PBATID8ivlz8vsDi3V8F2d8z5X6OSEMKBCAFnY/tthwtz1TOoXXrTjmPryiBxOw12WCCQGY4+r5poD87DDnO9EJmdD2T6liirQbFFrjszMs8qRvULhHcxmw3EY2gwvC+xKi8aTkm6DpsRXdZHK3MsZMOqAqzsEUM2R54TTyfom9jyQw17t35C5+Hw8CziGhaCFfaG+ufQ+JA2Aae2HvitO59yEM6q/8YdLvncLzgGPyLIHrtxg9Ketd0AnnJjj10iVxUS7/STKZnNAPkBcejePNlmp9+4bl6THi8BLBqWRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uENB8BcapfgiNmVsbX5FxLTOwatHQWT4RqlaMo53rXM=;
 b=Os/NESwDTHbZzsKA+/RkNhBkBf7p+KkBNvjSed0CSyVPisdwbaIBUe78X3WoNdCrg4VxgkxiZ2DQIH1Zx5fyydayxCzMwPV6ZzIOwm1MDlC9qG18ZjznrBt8zSqief8ODyWrImawCot9ppmVCmGbtKqTTzIMGPGTyP8q1r8S2DctoWKrqe1f5AjxrDS8ey72Onal3DYxqE1uMPxaHjiuE9o+KvdsS/4r/P5inl8ju3YREG2od10BLbPDSBvOrZGaXu1yeMQ6KN+6qPUB1NOCSbAhb4YEN3rH9ysv2hh0JojCnA8PxpuGJEyNruAKH2FF9hF27yHmeMfsPuIrsoVuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uENB8BcapfgiNmVsbX5FxLTOwatHQWT4RqlaMo53rXM=;
 b=c5OaAKexYU1/GqhikzwqzkDTBrA7/syVEtRI0sVCi57AiP9dwTiLApaaP3m7Kq4tHx2RsTt4RmKdo2x3pwM0eTsLBpxTRsBsxRnk5FBwegHRd1/5bTvHOFNZZ6zSz/KHEeYZ0+yWRHFHwfo14vPtVn9AruZBIXdxzzcQhC5je3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:38:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 11:38:22 +0000
Message-ID: <cb85f638-50dc-e921-d7e1-726df48e5357@amd.com>
Date: Fri, 7 Jul 2023 17:08:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: correct the UCODE ID used for VCN 4.0.3 SRAM
 update
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707113144.536043-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230707113144.536043-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e93b96-c758-4893-a634-08db7edeab30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDUEer5PI5IrmCvauJTRoz3ZQpOrZliyi4aO5snUSQaPDTSW711BJGekWcZfcg21d0V7wRKgdQCzzRjusoUeZIDrVIi02AC+mP9/BodbjlX0ER2dDPC7Fn3rvLZY8+PDZ7XH21HJTVaBrGCYXBRLs61/2FoZovcINeU2CtMtzobL32jyaxpc2poybh2r0ciAM2DH4GcxSGGHnZPzO+5TnStwDiELpYur0ls+bn05Y9YDfax28P6xgWVE3a028RmPQYJXzA1FeFEViatoDdaLsS25EGH8OHNvW0FAUQkfI/EMUUHABIT/q/G6986GNUTflN8z861BOeF2LZKT8zxErBfXHXzI8SzukAerN3aGxQyU0SAEfM/95dOgg/9fuoxEvJTbk5+ougrgehj5JRlE+pz2roAW14k12Yk5OjfuQBs2G/6l8skah27MLIuc9raz/Ua1BzOTrVmM7qyus0CQt+PcPHOcNJR3+f8sHbTkjDGePvd5YQl3KgeT4F1fDt3pcdL62szdhpaxHOFncwj8vjNppvQI+lkptzVAsnGPTDO2bCl6Ze8G/9bYpybmXbg65W0Lyc0KgN230oP9nhg8DFK3o7YNyHX888Q3svLUfTT62siqySsnqfqNhz+r+cEokrR0c/7rua1q4Zufl0WAsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6486002)(6666004)(316002)(8676002)(8936002)(41300700001)(186003)(36756003)(6512007)(6506007)(53546011)(26005)(478600001)(83380400001)(38100700002)(31686004)(66946007)(66556008)(66476007)(31696002)(5660300002)(2906002)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9VdDB0dWJjdHBuS1kzN3BOaURNaFJnK0VuSFJrRjNPc0JKTnZNVTRxRVkz?=
 =?utf-8?B?S2c3Y0ZKNFF0ekppaUZpOWlCWnlEK29pY3NJUEMrZm5IL0pGSlgxZ1NYaS9C?=
 =?utf-8?B?ZUpFSzB5WFNQMWhhWXBRanJ3TGhoRmdmYys4d1krcXBSRCticG5mbDV0MzlO?=
 =?utf-8?B?YU9OY2VCcDhTWHp1V2s4bEhwZDRKT3NjWGNJTmRqeVpnc3dFUkt4WUMrd3B3?=
 =?utf-8?B?UFQyaXdYRnYwRUU1Z0plcUtXdTcyajRxT2VNNDBzN0UrSHVLMnVBQUw0aVN3?=
 =?utf-8?B?blJ5OWFhWjBBL2dsMFR0YlZMQmh3ejg0aDcwbGJobjZYNnNiVDRCZDEzdkRT?=
 =?utf-8?B?Sy9FVzl4TTFuY0gwRmlKMjNaMm5jRkZmKzdLdTk1clFXYmRwZlFYY2diYTFK?=
 =?utf-8?B?c3cySEE3cXRFUG5aMm4xTmhFRzU1RThVMk5naXNOeEsxRVBEMGN2SEsrcUFO?=
 =?utf-8?B?M3dkTXRKZmlSWEJzVTdZeU1rMG43M1pPMW05N2R4aWs4Q2dPeEp4dmRheVdi?=
 =?utf-8?B?S1ZnbE1YN2pOc0pnYlJHNFl2eTJBc1JCMzBTVG1WbG85U1B0Wlk0bkE0bDBS?=
 =?utf-8?B?My9uL1FXdVdpZlZ5K1d0T082L3JwdmNKalhFOW5MaFlzUEx3a0VMWlkrNTBu?=
 =?utf-8?B?TVJ0TTljbFJ1aHpIbTIwL0RHeXJPdTNBeEJHT3lxd2JnQWE1Y3prUW9SU3NV?=
 =?utf-8?B?UkcrTi9xM0lmU0xNeTBTdWFDMmpWRUdIY1JYZU9UN1ZKRjBGeWpvMVZQaGkv?=
 =?utf-8?B?b0paRnU4SHpodERnUzZlZk9xWWJBeGR1eHczZVZvdzM0VVpvNlRUN0JMWUhs?=
 =?utf-8?B?KzB2MVdmTkpvSllaMXFIdmFHeGU2OVl0UU1Xb0xVQnhkUkl3dnlLRHJ0djlH?=
 =?utf-8?B?U0lpNEJyaE4vMUUwSXZPdk9oejl4dXdUSlRVOVNkYXAvUGtvZHhvS3Q3TnV5?=
 =?utf-8?B?OHB6UDArcW1lYUFxeHlTRHJsOFlFRXY3TDlJQUtOTy9ZNDlmVWVZK0hsVEFG?=
 =?utf-8?B?a3VOMEJ6RnlXMGhTcEFxVFFHd0g0eVE5V05wcFpIZ0JrdmovdWJxeHg0bWY0?=
 =?utf-8?B?YzZReENZL2dCa1dLMEUxdDNPTkJReW42bXR4UGVGdmRtSXJKMGtPUHdOeGhm?=
 =?utf-8?B?dnQ0dy9kNnVBaW1SQzJvZWs1akMxZDR5QmZuWDFlcE9LL1kzNEdTSWZiQjd4?=
 =?utf-8?B?M2lOdHB2cVJIay9wWkt4d3RPb3NXUmV0N0g4ZS9QOVhpWWNsRDBDZjA4MnRQ?=
 =?utf-8?B?VmVwUnBBSmhoNlRBV3ZJTWk4OE9vK3pQY2hMSU5DdG4xejFaZWYvQ1J2T2Fy?=
 =?utf-8?B?SWFBbXhzOG1xTnlpVXZhdDBhSVIxV1VBMGZLWWljV3FZTXhxTW5nS0U5L280?=
 =?utf-8?B?M0tXVlZjQWJ3VzVIQmlaRjdKOTJzLzlYcXJEOCs4ME93UXJOMlVRcUg2UEVM?=
 =?utf-8?B?VjhMakRsVEZ4ekNtRDNUZWludXVlTzZ5MUl5TGNGSEtBM0FWZWlwUTNxZDNn?=
 =?utf-8?B?NGpFSWQ0am4rOFhRMjExZ1o2ajIxVjRsYzdFaENjNGZJdk5ndnVpaVlFOFhS?=
 =?utf-8?B?K0JPU3NPMDRrR1RzOUUxKzFMbEdlWWVpaGNmTjBWL3Bvb3g2SlVCR1F4cTVu?=
 =?utf-8?B?NURBWjc3cDJBSkxvcVZ0NVJwdGt4YWFHcXJ1Skt2b0xva3NuV3p4S3JzeTRh?=
 =?utf-8?B?M3RsUTlvM3c4YUpJai9rMERNU3crajNneXhwVUhodTNiL0JWT3RhYmpWVVpj?=
 =?utf-8?B?MHlZZGRmK1hFdFFoc01YaDk0eFQydW9TSXJKY1p0eWJCcy9UMXpvajdpdXZ1?=
 =?utf-8?B?dTk4TDZ1cEVpR2JuMGlkMkN4bHFQQjJGWUVjcVdrUEVpaU44c0U2VFdUdXRD?=
 =?utf-8?B?bnlLRy9QR0xSVDhYcVoyZVNGNHZsUllRK0s5dUJLSmR0RjUyWEhkeWhZcndF?=
 =?utf-8?B?LzFScy9UYXc3OXNyQm0zTUNjalRLTHhBMDU0Tk4rNy8xUVdqZ3JuRHk5YnNQ?=
 =?utf-8?B?QmVzeWQwWWszTk51M2J6OFFQeTQ1OEd6L05HY1NSOXVlb1lIUUtCeWxaeE1q?=
 =?utf-8?B?VzY3TFVKc2lVczEvdU1jWWc4WjE4dnM2SjVHNE4yV3gxc0poS1ZhVFpJMTNO?=
 =?utf-8?Q?MIw+QISzxEAXnhHZ1ubLUKQ6M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e93b96-c758-4893-a634-08db7edeab30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:38:22.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK0tWuIKQ/KsHGu7wIh1WVT9e8LcBrw3/O9ddHLgIlfkESoF6KNY03lc4l+Z1HEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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



On 7/7/2023 5:01 PM, Lang Yu wrote:
> It uses the same UCODE ID(VCN0_RAM) but differnet cmd buffers
> for all instances.
> 
> Fixes: e928b52c58dd ("drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead")
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index ce8c766dcc73..8ff814b6b656 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -778,7 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> +		amdgpu_vcn_psp_update_sram(adev, 0);

This doesn't work either for passing the right buffer. Could you revert 
the two patches? Not seeing any simplification with those. Previously it 
was one psp API to be called.

Thanks,
Lijo

> >   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   
