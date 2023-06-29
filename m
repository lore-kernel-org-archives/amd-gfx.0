Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1316AEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 08:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B345910E3BC;
	Thu, 29 Jun 2023 08:14:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BD210E3BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 08:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeNa5PQkC6sJCsCEu8ooeIVPZ0h2Fmtw75D8gxdaQpH+H7xqisRrAmMGXqLB31sW7NCcFzEDyivd732Eml4Oh1wDZoBvITycwFtE33vUHr5sKi/EaSq7Jvk2urafu6T1LA8R0ncT4NnXudpxan90dRfUaC761oMvJf62DnCSDIVgus0hnuAfq6BVTo0vaGVJIABT+V2XjWY+C/cQKBidXXgPhh7VdkUCXMEM8YJa1xXvxgIuciHY2rBpgEStJATUEZin99NbFuUIlNMtIlYcrm5nXBnrChR4F80EXkKWHc2JJZ8ZAklawVwLsl+KWFoRv+MTXnq5TMdu9ZUCUOsRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZYP2DKhl4Vd4vi6INWdBa/9DNvfXR6Fh4SI1VL8puQ=;
 b=SXImWuAzHN4W07dKxKLIzqS3+pMGrZKX0zXMNsZBzdq1Yk/b+EkaTPUZjyxo2W9RUD45KXGIgoVhNUVpvs8HeWPrWJ8h4kMGr/J8xhYpQOtTM0iEy9MGd3nVfHWZ76JE/4U8/fbZec5kB8cf0DGcDY68hSqRmbKGO6EoyoIpQQnaayyU3euiaRP+ec6Te5XsaG15WOKi1Vc2W5IV/axl+uGG1hDv5oRhgk8uJP2H3wNfzKcROk6l73VAdnDyC65e9prdzg66BW4xPkHWujPsoCzNgWS4tazhF8efyNAviO7CPmx/SSoBP47Vez51BcCgZ/1ztlycte8iH+hyFQb38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZYP2DKhl4Vd4vi6INWdBa/9DNvfXR6Fh4SI1VL8puQ=;
 b=GEbHTjD5fGK1QsjlU74RWZaRE0vMm+PS83pUPS/98epVhigaZTyNwuwuUWq5Hemt62VYkPI5+COb7GoyQVNSviQSz6+pXgJPHeJdwQckHvhu18ua+mtGwKhIu9V45zz3gIs8s8/m+FUBO/eZybcvDVHKcZI9om23llp0FgoVFeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:14:14 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 08:14:14 +0000
Date: Thu, 29 Jun 2023 16:14:07 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: extract a PSP function to execute IP FW
 loading commands
Message-ID: <ZJ09T9ftMbvvqEe+@lang-desktop>
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627044833.3668402-1-Lang.Yu@amd.com>
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e893d5-eb69-4866-fd07-08db7878d34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HDbp8HX4mEaSwQTwYxcjQI1YU4wOmBiQ+I0xIrgDiD5W9w6f/XhQRmFAmysty7ksp1qU0LK495Nhyj+gUEETrHflkxuNDYrWCXnzbsFm+EVkfi4LTIjLq/GpIu5RHGBlcnWBxheaf4GtdybpmmGlQ799//E1Enmt0yBNsfgTWy3P9kzcMIYlkReTzc6K4TJIJVvkV2+fs6WhUKVhEk5aJXJe0gdR9SACSbQL3nkMjFy6qg1HOHXXRPHa2Nx1YqTg7X2IMpXDZGsvf8VYffVVtN/ufA2Su1dmwbbO2zYnyfvvIh+TOE78KqTeQ9TeD+cQy4rglwi3xNSWVOKOhNrDRvXakcnq0j+M6LE3hSKtXrxHLJ3BgFBpjE9RpNbmgdX2bFJJxDUrhe7vuHW3dK9vncHBuBENaT0S3IZWuCCK+snvvqPNnkQNhE5GRzRQ1zJq+WhY9qu8skBkr8s4RBlUOp8vHYFyMNkvg0k8dCrVjvXexg7+KcHQMTyASNFxDxHV8Th/t7SRGj+EKxD2SZ5KjuUM4IPxo8/T+8N3elD5LRvvGSGr1T7+MN34QP4uWuG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(6512007)(38100700002)(5660300002)(86362001)(33716001)(41300700001)(6916009)(66476007)(8936002)(8676002)(316002)(66946007)(66556008)(478600001)(6486002)(6506007)(2906002)(9686003)(26005)(186003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rylR+P5L2qv59uLJQVfw2YvA6aCIgBfI6djZ46PLRBa/gz0T2nlX4+gQgRDE?=
 =?us-ascii?Q?DwTibUh9C23/ijwb9NBMVfLWECtYOuuVeaD++vRgXcDyaCaEM0wf3//rp70b?=
 =?us-ascii?Q?CCvIG5oEvbwxvrv0bEl4SqvFslt47KBdwU9XhUnaNIqtvDTN0v/dZ4N3kDoH?=
 =?us-ascii?Q?HYfHK+gtfRAaQEFzay5NZtAwREIN5UcVsWx6q8ZWOHwERHjN9KPeorfo54W5?=
 =?us-ascii?Q?hVYdmAzmepBlsuEdNYa1KA+TmocR7vlSGwVuCSyDfLFmSnCKL/xKEdKw8ZYL?=
 =?us-ascii?Q?j05nxlWEURonOKMMfIQyGNyK7gszi9JHXNYlwjhJsGrK0jmV/xH6zjts3g04?=
 =?us-ascii?Q?IN7BkL5QALpkAyc4iNU78b15Bob8OmwZY7JU6ZDYlscxIU3Xw1CdWi1srq8m?=
 =?us-ascii?Q?LnIDkF9pnZkkI9jYZgbJMlE5uV4IPquiVclJTmhv5RE1bLmiy/SMFk//9DUy?=
 =?us-ascii?Q?wL/BHaZBtrmVuENkCyJUvqCLmaXTx3U9P7tUMqq3rSN8GtA5rqeQT1BLl0jN?=
 =?us-ascii?Q?Uf69xWKDEKq1S6HwOkWRiF/7z3TfG8V54+uwRQHAyMjjZJRXYNmxwIJSaVBy?=
 =?us-ascii?Q?Pc7GZze6mi9E/fC2GW03Eq2Zw+nzMev4q23yQBkQGThH1yUq0+XDrDGoo/Hi?=
 =?us-ascii?Q?W6RcHK5km/F9Xcvs08UHiDhU6Qi0n3PVY2dGuqXfjpVpKkXOXMKh6qqyowKw?=
 =?us-ascii?Q?6Ar1e4pBiQwdCpngPsDXkF/mbY4NqC41D94e2iMwYbGt/JIam6kdssesQHtw?=
 =?us-ascii?Q?eRZL80/flhDNPNJJGttxty/e4cXpRkm4C+4xfEwQmYTUFia1czDFWi5sAlOH?=
 =?us-ascii?Q?+ADtQDGTBFMriJiD5v7HtRwitMM0DwEcjqhRRQgorgQY3kD5EERK0OHpbyWP?=
 =?us-ascii?Q?oafU77VDA/C1h+Blrx2u6Yzj7L6XkEHVXCYVK9j8eNCYkgYWnpv8mmTWxviB?=
 =?us-ascii?Q?bQ8QuVCcr/YUN0JWEyUUZQzoy2wXVklj5Ks7ZLgt1D43Gp9LuEucPZUl3plw?=
 =?us-ascii?Q?RcwwALI9BxEZUWfq+26uOA8NZC6QSvKOeJp9hFQ0taJEEKEfqD92YXguLEl4?=
 =?us-ascii?Q?x0T2Hw37EBNO0Aa6ctWaO6RZHgVbJ7re9Xi5fDmfmL3RYrIdbnkWfvtYrHqp?=
 =?us-ascii?Q?hzTiZ6i4QfXXOGNnzZDwiGGOg9RLqxNtr8KmNwtWv9L+UPo7eiKz1AVr7Lwk?=
 =?us-ascii?Q?NKu4nF1kc1sBH9UmrM46B8kCJwU8GOQ2cqLBFdlWFbH2BjVT7a5kdF+Qma4t?=
 =?us-ascii?Q?p/AXFNWmiCS1QVlGlT61+6dmGbFhfwfHgLvevwrwKdbkh18tx0gfd/qOtXAT?=
 =?us-ascii?Q?E2tfXvihS6IpB1BPVokIpicUL5iqxHE261fiaWzLn4BfQlrVcAPevdLkkg4b?=
 =?us-ascii?Q?aVm3ftdUxfzc7CVFvziVXFw5WwPgh8CVrVxqNivd1JyitDckQHRa7RiXQRRf?=
 =?us-ascii?Q?ENf2i7tkH3tnzdAkcw5d6OyITzr+xTlMu2bLP/eg8fhI7AOa3vcxk3dzt0Pi?=
 =?us-ascii?Q?S/jTBNH1YinH/QNdWqWtVTxuYrtuQgCxsxZGjXgUgp7Ut9A0fAGRe5XguKjn?=
 =?us-ascii?Q?jprVzMvNO3OGl0VRVKN2nJMEuOAd+KWeRJkGJdbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e893d5-eb69-4866-fd07-08db7878d34c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:14:14.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smoLeESwGdHDtVS4aHSrU7DrCDVIERgRwUSSaMZMmflU96pIDzcekfU2EQ7glZZuyP8//nXunrNNyJSTpMdAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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

Ping.

On 06/27/ , Lang Yu wrote:
> This function is more general and easy to use by more clients.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 29 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 +++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a33c155dddcf..a1cb541f315f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2445,6 +2445,35 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
>  	return ret;
>  }
>  
> +int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> +				   struct amdgpu_firmware_info *ucode,
> +				   uint32_t ucode_id,
> +				   uint64_t cmd_buf_gpu_addr,
> +				   int cmd_buf_size)
> +{
> +	struct amdgpu_firmware_info fw_info = {
> +		.ucode_id = ucode_id,
> +		.mc_addr = cmd_buf_gpu_addr,
> +		.ucode_size = cmd_buf_size,
> +	};
> +	struct psp_context *psp = &adev->psp;
> +	struct psp_gfx_cmd_resp *cmd =
> +		acquire_psp_cmd_buf(psp);
> +	int ret;
> +
> +	if (!ucode)
> +		ucode = &fw_info;
> +
> +	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
> +	if (!ret)
> +		ret = psp_cmd_submit_buf(psp, ucode, cmd,
> +					 psp->fence_buf_mc_addr);
> +
> +	release_psp_cmd_buf(psp);
> +
> +	return ret;
> +}
> +
>  static int psp_execute_non_psp_fw_load(struct psp_context *psp,
>  				  struct amdgpu_firmware_info *ucode)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 4847aacdf9dc..bd324fed6237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -462,6 +462,12 @@ int psp_gpu_reset(struct amdgpu_device *adev);
>  int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>  			uint64_t cmd_gpu_addr, int cmd_size);
>  
> +int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> +				   struct amdgpu_firmware_info *ucode,
> +				   uint32_t ucode_id,
> +				   uint64_t cmd_buf_gpu_addr,
> +				   int cmd_buf_size);
> +
>  int psp_ta_init_shared_buf(struct psp_context *psp,
>  				  struct ta_mem_context *mem_ctx);
>  void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx);
> -- 
> 2.25.1
> 
