Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42910C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 12:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B8910E2DA;
	Mon, 21 Mar 2022 12:49:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F53310E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 12:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXuxAdeZqgtpYLibqidNoaL6CyfxElIlbIrI66IDBIGyZgXEgPBSFwuREpIWziaexBrxfmT/0HNtfha90bnUXCMyPrHPrCijLbPqe0ZzHbUbHU07JtHK1tKH873rf87SP8D4dTQq5+9JBIvlD472F7k163isnfu9+ds3a+JRBESUiS4msHy3mV7KqGDGxrdif1TUV3rY77p4L8GHZ9mgJ5umlHVdtsmHa2Io2uM0LOqghLNQK7CgIGLrvEdCj6UxFop744aq7LgkEHliEuAlyUg0Qw4sPZJ4kLDkIJDxt2Fhrga706aD4okvIalecO7CLKKLtG2UeoJ6dQzpyzgUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8vnlLjIdhj8iS7a7RfA19ar/ggKr+EEdB0xBMFYcEs=;
 b=mKY3BP7kAROjKIx3+Ky6DShxte+SaxPz0Nn9REghSZLYh1ZAZc7fq3sk6WjXbvTZXL5vF6Q67+fXeJZFoeR2+fO33yljdDd0EVyXL/K6PmA4+8jdLpxd8Bqc5+uZMTGP+chwlPgJfy76CF1xC8zhftSDkNGPzLgXrtM3VjlXqJ+N7OEMQ1sjaFkB3G5ZqCgcOiXdW08NfzdWm2jCg5Yf8oWd/UwV7RpRPgOa0SSS59QQzy/uXf1DYodQO8OyfmnIW1PPlajYNuabOEB9oBIBoawooCzb5+b60/CYLF6l2lyKOp8N8RVSjACGRQSB4EAQFj3q12PvoqWjPYz1uZDZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8vnlLjIdhj8iS7a7RfA19ar/ggKr+EEdB0xBMFYcEs=;
 b=TzM31Cphf/rPLYfTF8xV6GUE1fTeTBDmh9Um1i3FPSef/PHr6qNERP5uIbpiXi6AMGCKC1LtfFpFV3sXWJ6VCCQ33P1lWqzCcjQlGVGJ47YTPx4gJ6vo/bhPlgw1WrZlFz0yJ1YyDedDM4NoFdjcLtB8fy8Jp+fm3XQ866lUz6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by CY4PR12MB1896.namprd12.prod.outlook.com (2603:10b6:903:124::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Mon, 21 Mar
 2022 12:48:58 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5081.023; Mon, 21 Mar
 2022 12:48:58 +0000
Content-Type: multipart/alternative;
 boundary="------------YFbFd22cnkhH8kWy6uteAV0K"
Message-ID: <b5e5c198-5ebe-b436-8514-84ce51bf9d02@amd.com>
Date: Mon, 21 Mar 2022 08:48:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/vcn: Correct the register setting for vcn1
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20220321082636.4993-1-Emily.Deng@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20220321082636.4993-1-Emily.Deng@amd.com>
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18cc7304-cb7c-491f-ab88-08da0b392a85
X-MS-TrafficTypeDiagnostic: CY4PR12MB1896:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18960C64138CE7FF45B7DB7EE4169@CY4PR12MB1896.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/JjPN8Hq3Q/z3If0zUlvXUmf/ZAsucqhTnVdPABTI6RN2Uxk9KAIiSLVff4WxutcklBb5gyl67Fgq++DpqzkagFj1iSzwZ5LI3s6H5UMgHx4YigcbNeiYsdFzx1jajEjPOiufzboWO/SuWCApZRAi2PiyPs5wrIXE/bq37hMedUm0HsNjiFEYCPc5QPR6DfyK659enmgVIzU7yvt1ykIUYHF4f91sRgRuoQmszkcWB9Xrq2z0cwW2/2UlteegX+FR3m1lR/fnEkGtf6NTdadK9Fblhxzd0RiHUFoamFWvpr6pcEnq2gP2PySaeU+FU9GUXghNjKaNLw3dMq7XxWsOwxdKej/WIOMWfN4PuvroTl3UtZsZPdTEeEiWShew9qGunYLD3Mj+LJrTagmgXRLxzpMokVb9EWxdNFlIFaua7NXR+xhitEnUjXGs47R5PNYCzHKsFpLQQIlDp9p+xtKreYZYWKL7r4ztzwq3M2lTRmzt3xaxCcSYyuwMNXgFTaFtbWGReLXTNk0ngBJQphrOIVTEj2dt40AeLq4VW1FO10Q6VNLzfIGKT7+YP/EigtHb6hLA3G+60SlP5K05RA+6gJiEZjDd3Yps3kGygRasoSOfXi7ueSesYqyYwzX6jkTOGpD0S7HjDTVywXGGyuKY7nbTvXFJszKsSW5usc6m9+DEvpqa2lPOjbLv/1vfnMk1IldlfdOK5ne+AfWQclYcDohKSXWpRJZM4K5ZyeW4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(8936002)(5660300002)(33964004)(53546011)(6512007)(31686004)(36756003)(6506007)(26005)(186003)(83380400001)(508600001)(6486002)(31696002)(2906002)(316002)(6916009)(66476007)(66556008)(8676002)(66946007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtGTmphQ1J4NlZYWUEwaWNPTSthVzR0dmlCazRHYjEzc2xjSWY1VVZMS0k3?=
 =?utf-8?B?OVJCYWI0dWZheUZ3cld2WXFJbDVBN3NxQjIxOVI5K0ZrSTBLOTZnYm1WclFt?=
 =?utf-8?B?NWdZQlh5WmV0RDd2VTFDZVV0N3A3R1BqWG00bDM3TTl1ZDl0VlBTYkpwL2RC?=
 =?utf-8?B?dTZLU3VhM2ZRSHk2b01aREdlNy82c0hHYWgveUhFTEd4MXRZVWxGWVIzUnF1?=
 =?utf-8?B?M3pEWHRKSWJ1cXdQRG9tbXBaWVkyeTlWZDhERXZ6VXNJdzZ2Rk1GM0FNZC9o?=
 =?utf-8?B?cWJWeGU2V3FBS1hkNkxqNTNiVEgwZ2FYYTVNdTVDVnFGUnRqVUJJRmVUbTJi?=
 =?utf-8?B?dmdlWEFIbWFsSzkzb0dTMExIV2czUDc5ZjRMZTBpamE1dndpWVBsUFozZVRu?=
 =?utf-8?B?ZDQvdjR2aktZbUhaWmhBZHpBOFdXREhzYmk3TG1ldWIzTlBCWTZFOHBLRDJF?=
 =?utf-8?B?ZTQyK0ZIcEdpeXZTV0hNaE1VRHBsczRJNTJBK1FYcmFCYWljeVd1OEIvV09m?=
 =?utf-8?B?MlNONS9Qeng5aHlSQkdOTkR4YXBmSVc3b2FOMUdLMHhUdDBsYzF3aW5pdU9Y?=
 =?utf-8?B?a29rUThGTkdiWXllYWI1b0RaK2V6YVYzSldvN0UzRmxmdnEwaS83UWxxc2lB?=
 =?utf-8?B?RUhSWENxalRlREVIcVk5NytRbllGMkF6Zml3aTZaMUpNT3BVV2plWHN4ZTFu?=
 =?utf-8?B?dzZFb2NpdDRnZVcwS2krRWs3WkNDWXNuK3dybkpQbGpqRkdGRVNkUEhtT2lP?=
 =?utf-8?B?UHRwdFNlc1JYMktmcEExTm02TWgxenlGSGhqL084ek5oWkg3bUNTYU5ZMWpR?=
 =?utf-8?B?bWJKWTJ2cWVjWkExRHdZMHNIRk9idE01Q1dUdVBJeEszSEpkRXQxZlZYNjZK?=
 =?utf-8?B?V3czUTRGbzlVZEVhd0dpNVBwVnoxMW9kTWsxbkRNZ3ZkdzhZSldWWVp6RUlo?=
 =?utf-8?B?bnJHYWdLa2F6Z1dJSWRJb0RpU3lTWk8wNGtGQitSbmZnNFlUTXdHVUF3YTBj?=
 =?utf-8?B?OU5kUDZOTmlXOUQ0RHlvN1lxd1VHbERJK1JtVDFrWGJhVkdhc1dCd2UzWkdr?=
 =?utf-8?B?RUh3M2JzVFd6dWRnemVsY1IrYWIvVmJpVVhoWlVZeUZuaFNFdlptc0YzZFdG?=
 =?utf-8?B?WWdmS1psaFBvdVM3RjQydWpuZnlzeUh4L01aUmFOL3VRYldCOXQ2OTJDYlZX?=
 =?utf-8?B?NlBlaGxQSEhCRmFXY1RKVWRQeWc3cGYxWHBPWkJ0dUYxZytuL05Xc3NWVUUw?=
 =?utf-8?B?dTdkQ0hPNEthV0NaYWdpREF5SFZZSE5rL0twRkd2VDFYZkNlMVI2bjNOb0FQ?=
 =?utf-8?B?R01oRUx0NTdxc3NPMjA1VGJ1dXBDRzRGQnhnenY2Sm1lMlYrcER5aE1PZFk3?=
 =?utf-8?B?dWNETVB0dXhwZ2lia3RDSm5uOXduTDBCYmtwZ3RxOUYydjFQa3NlKzJkdHJG?=
 =?utf-8?B?dnhQOWowbThNYnc3NjJNSGQ5US8zYzVRNEFvNzljV0JlTFNNc3Q1d2I0SnZ2?=
 =?utf-8?B?OEJNRDM3YzlvdUFJTTdrK2dGbjFQcnpOZDZ5bkorZUJabXMxaklTcjl1dnJk?=
 =?utf-8?B?UDlRaTBHNXVlZEZ5RmN4U3BTdDNrZlpXUS9aNE9ISkZHZmJ6a01yd09DUW8y?=
 =?utf-8?B?L0RPSmdINUFtN3dWclZpSDdibEIzVVE0MWJHMGhGTm1CaTVYc0lMMEtpRlBK?=
 =?utf-8?B?ek1tcU1iQ2ZmK3psNnJ1YnBDbHYyZUFSeHN4MU9hRFJFenc0ZHdYcU1VUXBL?=
 =?utf-8?B?RlJZZ0ZZZzBNVFh2aG9HRXhpZEtLQXl0TkhzZFllQWZ0VnlIeVpVMlo0Z254?=
 =?utf-8?B?VTdnRTE4YVJ1T2NTQWoyUzQ2a2lEUUdtYVF2Y29XZ3creGw4RTJacm9rQ3RV?=
 =?utf-8?B?OUh1Z2FsRXBqbFR3Q2VmeFUzeWVWTmVHdndZd0x2empMU01SMUQ2bmVOaHk1?=
 =?utf-8?Q?2THXXz/7qLDIDYEimXv7YdPTIyXu4dwV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cc7304-cb7c-491f-ab88-08da0b392a85
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:48:58.3447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa0GrFP9250ojZEFzbfzQlU0VmfxmnPDqOpsVOYccl5y5tFoJFGW46r6NRnBb7NM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1896
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

--------------YFbFd22cnkhH8kWy6uteAV0K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2022-03-21 4:26 a.m., Emily Deng wrote:
> Correct the code error for setting register UVD_GFX10_ADDR_CONFIG.
> Need to use inst_idx, or it only will set VCN0.
>
> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c87263ed20ec..b16c56aa2d22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -575,8 +575,8 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
>   
>   	/* VCN global tiling registers */
> -	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
> -		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
> +	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> +		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
>   static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
--------------YFbFd22cnkhH8kWy6uteAV0K
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2022-03-21 4:26 a.m., Emily Deng
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220321082636.4993-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">Correct the code error for setting register UVD_GFX10_ADDR_CONFIG.
Need to use inst_idx, or it only will set VCN0.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c87263ed20ec..b16c56aa2d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -575,8 +575,8 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
-		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev-&gt;gfx.config.gb_addr_config, 0, indirect);
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
+		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev-&gt;gfx.config.gb_addr_config, 0, indirect);
 }
 
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
</pre>
    </blockquote>
  </body>
</html>

--------------YFbFd22cnkhH8kWy6uteAV0K--
