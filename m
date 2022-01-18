Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DA0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 14:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3DA10E23F;
	Tue, 18 Jan 2022 14:53:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FBB10E23F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 14:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWea1m6M3j/64cbeZ6OOrKpZ3GUU/s8UylZoO8cebeg82um1L2pAIwCLeQOCDdNfy2ATN6RkaCFgY/PLraYQ1pD9BO+EnSZavyltwL8aTSUyVxzvXQ/fSArUWZJU+Jos5CJtuH4cxCe2UNzON1Avapaib4kcjx2WvcFod51f7w7ccuxfozZdnsGFKkSR9vC1JuMfCrmWlG1wspEdqwanit7NsDChKu56ZhZtFfnQ1I4XKcRDak2L22mkwJKrxzRpb+1fxiKl6msyhlDdqnT7uD+Z7gWcF1NShTEgD6YzphzitsdUJj3M3bXcbh/Krqc3vq3hmAI0yliLo/lOPi9EDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAk4tj54iwrhqR8U5wJOVK6jT1/f8dIO/2WQOdZIke4=;
 b=ipLDQU3KvksAPfr0iQ7rsZy1LyIplGVE7KxuX/ct4aUiiGWMnO/Mtseh6xC0U3fBLOO5lb8r62JnY2seOiTBUPl2H27c5p5P/4nQbcqfZJD8o/YrDvz3Tztuu5CehFUdrFaaWDmExnP6oKFG3frhPF0Kjqrh/ArxWJ/3FxSVahuTn8hUz1PfXuAAy7JWRo46Nq37aEOaAab1nXIojOmf4T3JieCZdRgtqsaSY4C8uvw/Cxnv0p0M1W3lDbfZOPAG4lFC0zQqEui2NKwzZ82+DNfPAn2IRiCuJ42UQO6IIhcgFLhG3+Ykn+tlJrvev12hnlr/CRMeL12gaQ7n89Pewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAk4tj54iwrhqR8U5wJOVK6jT1/f8dIO/2WQOdZIke4=;
 b=43YXqn8OfQwX+2bKcNxHPPAyxHuxrPPfo/SEho2IBiLZLpDMTOHKoPJUPx60QU32SJySdR6tlzD/wRx6B3pIh3F+gMkQpZjQOP6M5wjWmwPKiJDnbp53zyTg4q9s3VQ3I8fkIbBjH3C3EkNmL0mHWy6BHqWH9DL0wfEAJe3YTgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 14:53:29 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 14:53:29 +0000
Date: Tue, 18 Jan 2022 22:53:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amdgpu: modify a pair of functions for the pcie port
 wreg/rreg
Message-ID: <YebUVSayvw315S52@amd.com>
References: <20220118112618.16000-1-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118112618.16000-1-Xiaojian.Du@amd.com>
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1419aae7-703a-4d17-9903-08d9da9249f1
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5486:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB548681B97AAAB68D664FC1A7EC589@SJ0PR12MB5486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHgnnlWGt2IWfv9UJ+4nlxEij3S87vPFG9u4rAHxqCAHudeT9Zmy876X0/HEzBdGSpr4sINQR4YS14kZeVqLNRewcbjHKQCU0Th8OvPTFB8wwwdrlMj7BPZ36mMa6yuZ9I2FpdJqgqIefsxpHDgr+IuzWJnRZtJxvKFpID8HBeZ6opcuPgrrm58aT9FwjuAoSTg129SWJNl6F1Hfx+zydtjI8LadYXNpheDcifitmvBH/ccJxQCDDtVdbhNdO8dkOLBbs0EfHuVKWojWemM9b1iQZ205mh6JEbC1EMwXD2jkCDUFXwMXNYMDE6bYFZ5rQwDDarrI6EdzcniJexYNkjOSlPozIJa9NMIbx0QS14HgFy8aNVc47fQpP0OULqYbiZ9r6VYo6q6+V3R3dhHCis2Fk99flpREqVKAn8AN9VvM8JrOGWhc2f6BwtQXEGDNadoanIqnIreHdeHCzPexNDkZioWEyBQOqU1A5A/DuFuhNX8Oetn5ZDCO5t9wf+rKBojXkpV28oVKk8I4TubYj3xuC2lgIDlrwEEhXYeH4y003cOJ6EyjKMpfh1P7zaxdFmMyuDPxbOdQRoqJQ9MMX2ndGqWPH/+FwvfvmuAvy7odw0aDAs/uPLYKR1SSSWI123hWCpSdIFjZr+B0h32Yrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(316002)(4326008)(36756003)(186003)(54906003)(37006003)(2906002)(86362001)(8676002)(8936002)(6486002)(508600001)(6636002)(6512007)(2616005)(6862004)(26005)(5660300002)(6506007)(38100700002)(66476007)(66556008)(6666004)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeZ/K2HKBSLkkD+NV35i3GaEaCsNNGPaa+RUWERdOKV4lGkRwq47xAHXmGZR?=
 =?us-ascii?Q?ujsMW+aR2tD84Lf2GgwKj3DQYqyo4WTK8N7eDmPKqqthfTdmWmucXtoOGnOI?=
 =?us-ascii?Q?dEod4yG330NC5mdWbkAwcpvvAz6DgspmshQVIMa64TDPJrQjhEJ7c1PFEFyO?=
 =?us-ascii?Q?BHG4XL85TxsvFui0n+PfGpc6eyjJ7Sl1RqIK7T0+kS6vcL4f5Sr8CVLKVkXd?=
 =?us-ascii?Q?Ex3TjZvb3COBXnQZiABZqBSARz9ySUnRagrbrZ3G7BLbYgEzD/nP9EcLunq/?=
 =?us-ascii?Q?8zf9GItwzK4FqebR9npSQRoFuNLiwSEbaxegZ3bvovWcPTubetyB2pbQ9Vzg?=
 =?us-ascii?Q?/hmUN+PLtrbMZFVN9wS5/of+jS0pyn2iETUArwcw5hhpjbQ30f5v7wDGfmhn?=
 =?us-ascii?Q?gk+f8nVEEosKeN3imn4TSoxHoTHvZd3xbqRTVVN0P6HnWC7e9KUn0/18f7A2?=
 =?us-ascii?Q?d657M5SScQSrZRiExTRThZUSf5+yKdw1FnyTWsG1ZmrL9tnsRRoXA4u2nEZZ?=
 =?us-ascii?Q?NoKFFhDMf8a41+wgwsV+fQM+FjOLOe0N9SgSkCpMsdk+KAjYUHJ4LGEh6382?=
 =?us-ascii?Q?7SMbhaPLQKZbeYd9XC/oN7d512ueKAY5iJk5aAGNweA5cGGM3onZOJ48TF62?=
 =?us-ascii?Q?kgIJQ1llQoz75Z/R9sr8IUWfma9FNcnvpbxD6RS1cwOgbHW0/pGIdsOzgtfr?=
 =?us-ascii?Q?FqH4Jma47+TLTxqH31Y38LeoLq+mhjMe0DJukQOyC8ksQ9Uq6tHyfitnMzwH?=
 =?us-ascii?Q?2SvfupF6NtVY4q9xqXnaV2SxvyCh0fI2oAkF2r52h7GEWTGtScOszcVOvJF/?=
 =?us-ascii?Q?RJD5OZ89i0WAsYZcbkRnXiiU6zI08n6gE8dY3ldmNsQWF56szxYzpWGt0CLe?=
 =?us-ascii?Q?PeFuYuqbSeLMmm/34bKreqrsK4qeAoo1QqsN0aBE2ubZk5bfdFe1rSIuMV3u?=
 =?us-ascii?Q?aPooHBpwvvJzf0uXDbUO3dmZOI8mYjVI2QD0JuVBFeYngHQ+cgWdpIzCpx4w?=
 =?us-ascii?Q?1ixkeXwmFfE/jX0hiRniLm/VB1ZCDglfxL/fwXyYqSGiByKTBSzh89NFBw9I?=
 =?us-ascii?Q?icjXXvO8BZuu/inFGLyrme2QPvjPnBKpz3wsIw/Sh6LxqIcVIVgMFrKhY4Rh?=
 =?us-ascii?Q?Hi4tLC1WCfnIo9wxSPZ9D6kgbzs0u2q4l9Eo3Ief4cZN+C6IHqWZdcxWjPvI?=
 =?us-ascii?Q?Ip54QD5OqUEIqq+mXxIMQl427F3TfrzwGczYA59osM8m5CZ4jayRnvnpdbzr?=
 =?us-ascii?Q?D4Wx+htuaOZkgEqOirauCSts9YpXL4bDqCI4BPu2yOjliKa5XVshmGpNOEdx?=
 =?us-ascii?Q?PR/lkT36uRaohv8NyPY7a5/jje4mO6mGKAOU3dFQGaNestqJuIo16J7HujxK?=
 =?us-ascii?Q?aoRwgCF6PD40TlgZ/K4OoDDqUxR3luixcmHcA2BKW8c8cP5Txbx4xXCu88rX?=
 =?us-ascii?Q?xWdFaKWrvP0XMi5M1FsyasCj3ou3qmLDBhgfXax82fV5QXyk1xGykIktv3vz?=
 =?us-ascii?Q?QI/ni25BkxOdJK6I2KWi0Lk+IcjkBwz8h7R33ZoNAFk1AE7Pr1akr3hwTH1R?=
 =?us-ascii?Q?KudNt5Rnhsg2K8CbyGcImPSFHWNHTT7lDdRpdiD5FV/2/Vq2a9BdDCBKBMXa?=
 =?us-ascii?Q?YFaM6cy0C+U1FjzJ19wXndA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1419aae7-703a-4d17-9903-08d9da9249f1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:53:29.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmfjuqO9SiaFnJeRwo7AlwbzRXRh47txjm0hRKLASbbJf8yXQmglAf4RQkVj2EmtXQfYvtP1n5VbWI0DMlUbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 18, 2022 at 07:26:18PM +0800, Du, Xiaojian wrote:
> This patch will modify a pair of functions for pcie port wreg/rreg.
> AMD GPU have had an independent NBIO block from SOC15 arch.
> If the dirver wants to read/write the address space of the pcie devices,
> it has to go through the NBIO block.
> This patch will move the pcie port wreg/rreg functions to
> "amdgpu_device.c", so that to make the functions can be used on the
> future GPU ASICs.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c            | 34 ++--------------------
>  3 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b2da840f4718..691d7868d64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1421,6 +1421,10 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>  		struct amdgpu_ring *ring);
>  
>  void amdgpu_device_halt(struct amdgpu_device *adev);
> +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> +				u32 reg);
> +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> +				u32 reg, u32 v);
>  
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ff4cf0e2a01f..10f2b7cbb49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6023,3 +6023,36 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>  	pci_disable_device(pdev);
>  	pci_wait_for_pending_transaction(pdev);
>  }
> +
> +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> +				u32 reg)
> +{
> +	unsigned long flags, address, data;
> +	u32 r;
> +
> +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> +
> +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> +	WREG32(address, reg * 4);
> +	(void)RREG32(address);
> +	r = RREG32(data);
> +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +	return r;
> +}
> +
> +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> +				u32 reg, u32 v)
> +{
> +	unsigned long flags, address, data;
> +
> +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> +
> +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> +	WREG32(address, reg * 4);
> +	(void)RREG32(address);
> +	WREG32(data, v);
> +	(void)RREG32(data);
> +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index e52d1114501c..17480c1eeae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -256,21 +256,6 @@ static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
>  	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
>  }
>  
> -static u32 nv_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long flags, address, data;
> -	u32 r;
> -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> -
> -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> -	WREG32(address, reg * 4);
> -	(void)RREG32(address);
> -	r = RREG32(data);
> -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> -	return r;
> -}
> -
>  static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
>  {
>  	unsigned long address, data;
> @@ -281,21 +266,6 @@ static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
>  	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
>  }
>  
> -static void nv_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> -{
> -	unsigned long flags, address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> -
> -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> -	WREG32(address, reg * 4);
> -	(void)RREG32(address);
> -	WREG32(data, v);
> -	(void)RREG32(data);
> -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> -}
> -
>  static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
>  {
>  	unsigned long flags, address, data;
> @@ -709,8 +679,8 @@ static int nv_common_early_init(void *handle)
>  	adev->pcie_wreg = &nv_pcie_wreg;
>  	adev->pcie_rreg64 = &nv_pcie_rreg64;
>  	adev->pcie_wreg64 = &nv_pcie_wreg64;
> -	adev->pciep_rreg = &nv_pcie_port_rreg;
> -	adev->pciep_wreg = &nv_pcie_port_wreg;
> +	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
> +	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
>  
>  	/* TODO: will add them during VCN v2 implementation */
>  	adev->uvd_ctx_rreg = NULL;
> -- 
> 2.25.1
> 
