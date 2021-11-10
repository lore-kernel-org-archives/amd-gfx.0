Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD32C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 09:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E055961027
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 09:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E055961027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C506E040;
	Wed, 10 Nov 2021 09:14:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B7A6E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 09:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wag3I+Uq3E0PihuZObf8RPQZxDFr2SF1gQbm9pIKmQ9RJ4IqOpgOUMZKWQ53helJU1qBkX2fEyHgF2n+IHsguAvhby30yGoJ0nZ+8xrhesYm41kY6aeoO9Wsgfn7pdfDAhlswcWJsNSvd7zDP2k3JLCQV8E2VaUHUAufluXNqu3non1h/eGlGTIdBmVOyHTVd3Cl1lhIefXAHR2lAFSXwI9ejIjGZL971ss3JgbowDS07n3HWd7LUEpdmJxo1l+7i9JbPgKnoTUAt5XLSwaDPAehs6xBa5A+x4Sjbb1Aic9ZNQ/ygKUcVNtLs51AyeYVrJHer0nhxK+d+MhL0G6BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS/qBo3uCZpOOZWDdAT40o39/4hzIovNcRxU2zdDtHU=;
 b=Ff5eTgqUXhMTMq3bGLPQYtOxIKfJFWAMpBR7bKE2f5UpwtkHtBORb3i/jc/YIHt/9ysWoOR/qf8+cUxf0lDBpWOaqW/E3vsf8QXEc9c2qbXhP8xyjtigPE00PxeQNltwmvvM0UpnBJG3I5cVsmqik9Sf0QhqgpATLoSgNkqg8XBZP481lO3Vk8yeo1beufIsGpye5oDMB4TbHExIoeEOpI/elUn5s8BRUjHtZnEkBp3/wzJFKEdT0JZc0sxTo6OAYw9J7tLlW4pg0Kr3lTtbsXZ9w5OEkukUgn5+YCGLTVpa+CiXqnu21ZNYTH1+oO6eIGekLxUjMdoMjmML59sA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS/qBo3uCZpOOZWDdAT40o39/4hzIovNcRxU2zdDtHU=;
 b=PbYMgF2QpSshDnqN5ucLVHVRRI7ZzIpFUMmuPx5+0m523X8Lbly6BUFnp+3JYnfL8QfWWW7OLFLpCimPugOGVoixQK6SCLeVXxObwcEfSz58R/eUWW7QW+sb0Z0rnPS4LkPWj4FtXFX3kyktEh8Yc+z1eufsVH2+R/sM4YD51lc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 09:14:22 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:14:22 +0000
Message-ID: <48473282-292c-508a-1a4e-42359c421f01@amd.com>
Date: Wed, 10 Nov 2021 14:44:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::26) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0021.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 09:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75ed4bd6-6ddb-42d3-5cad-08d9a42a7ba4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737D01FC2453DD3154FF3C797939@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXp1O+7Jf0YifZOl/nKrWtDTFJ1HVvL8+n2MkqvaciiiTPOzC1dsW55PkJhQFZi2lzPSwG7Q0eQaZ476lexWaWtv3MsNm0P+gj8f/hpz7vLuwu/uOyiON8VDRvTGEY8J3eflSekkSgrvSfOTDyfU0RuQ08s/vYfpCjENLzszhzvzkkERw0jsUSpOed0Ss8gmxa9lSHXCaTyPjg8qfZtlef9d/X/rOh5+TebYqZDaTNaMamQdzGa/W7Vq8SzcyfVMmcsNSUftFcSu7BGHhGZZgdqWdgNMtOKXJggiEl2XnePTbx2H8EAiOKeWErqi9A9XdXcmJUa3s1DKZ1PKp00PxH/+/nYDqzCEML1A6Rd3vPC4llVHijgbtrYGTjeZo3BALGFZ99a3u3DY2OvG9iZ7AoaGCA2QqIQBjTq6QUL1kKrbUZZmKcZKq7gvN73ZQM3odTIqkN35a/+8r33r7rHy1uQVChGOwSeZcbQQFGLUzs28WhFxaj9BbfDqYPdCRsCfI2LrNo2Cu3WtXupZDA6MjpN4XDS0Z9X7z7Wl2QIyUaBFX/bQbHeN+LH6vqkjPMV2TgyijZUCp9zpBQRxm1BTMBPyOaJTquIicMNw/xEC0RWT7yfggnYRXYBzsLQLOQJl+nXxhQ4sI9bUoWuVczLwQWN5IIsqCiBIZr6GPXMoMwffxJ+MpyaVVAI0EJPN1HsUqbvxNCzeB+WK2N0kyEXPUI4NSEq340DYsSS0xuHLahc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66556008)(31686004)(316002)(36756003)(2906002)(66946007)(38100700002)(31696002)(66476007)(6666004)(8676002)(83380400001)(16576012)(4326008)(2616005)(956004)(508600001)(26005)(186003)(86362001)(5660300002)(53546011)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVSR1pUb3hFajdXcjRrSGdxUlpkTmpnRHBGank4aG0yWCsvR0N1T25KaDVn?=
 =?utf-8?B?aXJLVjNSdll4UUlBN3ZOQ1pYVGJkTmpiVEI0T3hEcEw5VFNLVUVPOE1saFNa?=
 =?utf-8?B?Mkp5aHFJU2E4ZWhJdGNuNHdCZ0UwbEtqU0xaSzU3bHdYYnZST3AzcnJOQ05u?=
 =?utf-8?B?bWtENkpGMS9sQU5oQW1wVnJyWWtvS0t6SWIzNGdKRnV0U29FL2FzQzRVK1RZ?=
 =?utf-8?B?dGx5U3BCRWR1ZUgyeW1FQ2l4dm9QL1ptczJkRzZLNmZJQVZUOGxpRldjRjV2?=
 =?utf-8?B?eG9JcUgvWEdMc1ovd2F1MkU3cEYwVkM1WG9pQjRpY3VqU2c1UGFTUktKeGVE?=
 =?utf-8?B?alBRalMwak9jV0xodVNvdGwxaVJyQlpYNXJPY1dlUlorYnRPWmplbXFpMmFV?=
 =?utf-8?B?bTFRaUZuMWtsQTd6bW1wQVJHSXRxU09LVmRKL2kzNWYwZENiemQzSXZVc3dP?=
 =?utf-8?B?L24zS1R1dWpudFRzdmFJdWs0bG02TDFLMnVKZ202WXZBWHdKc2wwbXY5bCsz?=
 =?utf-8?B?Vi8yUngvVzFTOFMwcEg2TzRodVJGWjFWcnZvSHUyUEk4SDdtVVhoREttLzc2?=
 =?utf-8?B?V2Q5VitSZVhET0FqUE9xcVNJaTBuaFFGR21VNHZTWkc1U3NHc2s2VzhHYkxF?=
 =?utf-8?B?NXBNbHVsSS9ybS8ra21IUDd0K3V2aDJuVzNuNHFYcGdBZ0dRVzVzejlWamM3?=
 =?utf-8?B?U2VYREMwZjBURi9udFpUT21Xcy9PVkJUcWFLZkNCTkp0aG9yTjQrYW5zdUpI?=
 =?utf-8?B?bTcxV1dPR2FZSnNrSmdIc1I4K04xNlJRQ2Eva2MveEMydTlKQkkvZUpzaUJr?=
 =?utf-8?B?YlRkODlzMGRRTi8xQ0ZhVVduZXd5OGt2OFZjbHlVa3Z6U05ZN0t2b0czVVJj?=
 =?utf-8?B?VW8rbWlVbm40dzFKbktWQ1A0S1dad2o2d2k5bDNBVjVIZmRscHFtbGtkRTBL?=
 =?utf-8?B?UmFUNUZwMnhsQVVUaUxPM042VVk5c3hJR29pdmRhWWp2a1ZPMFI3MWsxWmkr?=
 =?utf-8?B?dG5WdGx1ZmJjQTNKN1N2SFQ3cHZCWEVUaHFvdXlSRHR5WnpPdkh5M1FJbnUr?=
 =?utf-8?B?U2xHQkxseTlTaVh5cFAyWHdlZlNkY0tyWXFxQzN6NEhkZEZoK3I0NlF3NzVq?=
 =?utf-8?B?L0xiNU9iN0Z2eWxrYWp5R1p1bWVQYjhFYjhuL29oYXE1K3lMTjBxRkk2OGZW?=
 =?utf-8?B?TVZWTG55ZHg3UjJOQ3dDQ1NTVU1ockE5MFBMeTZIemF5U0I2ZWdTd1NWTk5I?=
 =?utf-8?B?TmFYUWFvSWVTRDQ0UDVlTUlreFhYTitxaWZzUUJ1WGpVSW1la3B1NllPWkEw?=
 =?utf-8?B?WEhEVTY0ZTIvTE40VlVteVZSTFZCaTNaa1hVMzlLMUkreFo4UnhzU2lKUFJp?=
 =?utf-8?B?U09tanZrbzZVdmwwUE9NNWlXaTBtWnd1OEFuSHJVMHlRZ2RpZWxXL3M1V0gw?=
 =?utf-8?B?U0FDWTh0c21DL3U0UVpLVVlDZlBnWEdzdWhwZXRUUzZkK0QzVzBvZWkvMEpx?=
 =?utf-8?B?blRkQ3VvazF4bDRyZUowbm8wNmdpeUtWOExKclowVkswaHBiTHpFcXZ4NVRX?=
 =?utf-8?B?bk1IdDlSYVZ1UUxxaWt2QVdoYXJkV0VGQUVpSk11S3I0WjR1SFZwRkF0cStu?=
 =?utf-8?B?QUpNSmhYNGQ4UG9sdEloUldEU1kzaHBMQWpFcnY1V29hblN2SEkxSnFXNmxh?=
 =?utf-8?B?d08wc21ySUNOUVpmYkpEYVNlbmZDM1oxeStjd216ZUJtZ1lJLzcxWWhKL0FT?=
 =?utf-8?B?ZmNINk94SVNqYkR0WVoxSlo4TGVKOWJ5M3FyTmZ3LzBuTmNHTm5TVDhlVnY4?=
 =?utf-8?B?c0NqdVFOYXFOaUs5Vy9EUzhFOWtqam1NSlhmK3h1TytOSGtrVzJoeTFyOHl5?=
 =?utf-8?B?ZzJmY1R0UDVsdXp5QW96RnBGUG02eEgrdWFvWjJveW8rU2RFcXdEUEg3YWFE?=
 =?utf-8?B?bFZNdGl2WmVLMndvTmtGaVl1dFUwelh6ZlBKVjBXVkNwRFJIRVR0NVZGTzRZ?=
 =?utf-8?B?OGVIckwzSnVxZ0MxT3M3K005R1RJaGRDTnNZazdKWC9pbkd3b2ZtRytzYkpn?=
 =?utf-8?B?WkVVbkpPM3RtOTB4bER0YXRMc3NnZ0MxVEdtSGh5aXRJa3pTWmczS1FFRXhh?=
 =?utf-8?Q?GtCM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ed4bd6-6ddb-42d3-5cad-08d9a42a7ba4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 09:14:22.2994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoLZUIXH1AsmriZ/nNFtu6ZV5kdGjW8sWKZgFQcre6A1nlx01e3O/5D7VtMXiEOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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
Cc: bokun.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/10/2021 8:00 AM, Felix Kuehling wrote:
> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
> to the fixed address of the VF register for hdp_v*_flush_hdp.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
>   7 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 4ecd2b5808ce..ee7cab37dfd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
>   
>   	if (def != data)
>   		WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
> +
> +	if (amdgpu_sriov_vf(adev))
> +		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> +			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;

Wouldn't it be better to do this assignment inside 
remap_hdp_registers()? Return with a comment saying no remap is done for 
VFs. That looks easier to manage per IP version.

Thanks,
Lijo

>   }
>   
>   #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> index 0d2d629e2d6a..4bbacf1be25a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
>   
>   	if (def != data)
>   		WREG32_PCIE(smnPCIE_CI_CNTL, data);
> +
> +	if (amdgpu_sriov_vf(adev))
> +		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> +			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>   }
>   
>   static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> index 3c00666a13e1..37a4039fdfc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
>   
>   static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>   {
> -
> +	if (amdgpu_sriov_vf(adev))
> +		adev->rmmio_remap.reg_offset =
> +			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>   }
>   
>   const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 8f2a315e7c73..3444332ea110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>   		if (def != data)
>   			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
>   	}
> +
> +	if (amdgpu_sriov_vf(adev))
> +		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> +			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>   }
>   
>   const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index b8bd03d16dba..e96516d3fd45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
>   
>   static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
>   {
> -
> +	if (amdgpu_sriov_vf(adev))
> +		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> +			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>   }
>   
>   static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index febc903adf58..7088528079c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> -	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> +		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
> +	}
>   	adev->smc_rreg = NULL;
>   	adev->smc_wreg = NULL;
>   	adev->pcie_rreg = &nv_pcie_rreg;
> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
>   	 * for the purpose of expose those registers
>   	 * to process space
>   	 */
> -	if (adev->nbio.funcs->remap_hdp_registers)
> +	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
>   	nv_enable_doorbell_aperture(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 0c316a2d42ed..de9b55383e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> -	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> +		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
> +	}
>   	adev->smc_rreg = NULL;
>   	adev->smc_wreg = NULL;
>   	adev->pcie_rreg = &soc15_pcie_rreg;
> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
>   	 * for the purpose of expose those registers
>   	 * to process space
>   	 */
> -	if (adev->nbio.funcs->remap_hdp_registers)
> +	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   
>   	/* enable the doorbell aperture */
> 
