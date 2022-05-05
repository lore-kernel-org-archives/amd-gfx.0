Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B930C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 09:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C2010E04E;
	Thu,  5 May 2022 09:33:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532CF10E04E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 09:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcNSLjXGXcEoFdgQ+krJhAVG+Lr7TmEHhVKBkJTVOSgWUWaaeDnYTugX/9AjO7o5jUPnDRrCEZn+Ct4+h8bXDS3+/OnuNkBnd3jUy3S+kyi/0ldNsD6iXrSX5T1XXB5gSp6gpPBfwQ+faNQcrOH1CT9kdWEkWM5fbnxvyllyMUECeZACVgF194lk9Lxrr5p1jIuTtWCZtHfXdlurDjt5dswk1CZC6eSYbTX7U/F1rgQlfeVrek2EXJjy/KO2LBlQWwoZT6Hgeml2qAT40hr7sDHe8Io9dVykwpcIoNs0H7iezkAMGwQHMrwGEYB07eWr9nRQ5Wko1T8iqcVsT9AAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWKxw15+z9B/pSDjN5tcsm0nlDMCx2vz0kIyT0Zmi2o=;
 b=ixZVGE3+p20s1+lexfoT6hYuM8zeWSO/yvs8dst3RcsjYz89PVVpXDDnKSupKrR+vwvnhoQyqGXhZ/PwNpiqSw8je30MLS6iRrG3RR5QDj++IlsRFOj0ineh5RyVMNKLWmvC9nfwKmzF1mXUbKSa5+oTwaaiJjDqSWau4pN19u1aEx3nfCl8DeVWwCJnL+fONeZA27ZEOstWpQL3Ab0V98vnfeOWISlMphrc48yZcUFGD3IbW7kSLSpjh7gMNvM5Xcwibwx772WjUPjqPJw8SYOXIdxx7kx7f49LW7ACgQy3DS9LAr46XyVuAZg7Tv3+Jl3D1VHNZoumRurcQAOlpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWKxw15+z9B/pSDjN5tcsm0nlDMCx2vz0kIyT0Zmi2o=;
 b=4sPUvvA4WJIDuEEQJ9nPhX51vXEVcTogTGKHvD1Q0he4/qkyd6vd0u5Dwc0LyY2nFlimtOkc2zNfywW9BcyXZpSj26Y1YnMfnmxdJOh67YcavUwjwTzK0Vwd68Cm46BXKS55HZ70lK/DIXNCdl5ucEvQgNZZRMu00Fksa7/1XRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.28; Thu, 5 May 2022 09:33:33 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 09:33:33 +0000
Date: Thu, 5 May 2022 17:33:25 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: nuke dynamic gfx scratch reg allocation
Message-ID: <YnOZ5Wucvz10uce0@lang-desktop>
References: <20220505090619.171744-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505090619.171744-1-christian.koenig@amd.com>
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6ef9161-ce95-4729-2546-08da2e7a5267
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB64246E88FA1188334C3C7CF5FBC29@DM4PR12MB6424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpi7byguqMqVmU+/3krIRD8SZRmd9R2M6N+D8d0qmqHjdMoJ6VdXe7Q9hggUIscREs4CwlHnU9QQirdnvR6Vg0yQPHw8An8IYWMghxkpp/44XPFkMB+7cDf4lHc0BZLV6v9ch6aSv4+cuKt+9V5pNsYTrJGNtauWJ28Pu2cHOHwhLaOZMOVULZKrjgsRvUljdQ4u/kxDpfTW4xoesJeFKID1u7lxMazp46tV0jc5tUn2gNl88IkAY4obs15C/iEzvWC0HyfbXyxUGTrOlGcyAktH1xsBbUMKZF4ixPX7LfqrshIMWRx6Y7EpAwcpq7IqgchFCJKbYLl+7X61LrSj8tdJbGU7CasqkRVXGZ6fEIIY2klDLN6kG+Fr2LlZXZUIm0f7J+JMlyWkTMEzyjqUoas2KoeYQbmiLKxVnVfXSQsjGiPTLdhvt9XEzWRnMSWxFxlzjzQV60265ZKJrZbbDsFquMTBjn6somTBuq3R77wWqXwagokLRhtMA7bgwl+mMD+y8K3avFN/btqrp59dSQ5T8UqdNKNba3NRajI15+DmQ7ZJ1H5sfmt1yr/QonNqJqZoB7MCCfEavRbnUMyyvPBxET/KVXxkr/9/NsxJXLQVOtn21FgEOd5YXC7Qc/yhS/3Hel6Wb8gzA6BiMMgEVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(6486002)(66556008)(66476007)(6666004)(5660300002)(508600001)(6512007)(9686003)(8936002)(86362001)(6506007)(30864003)(316002)(66574015)(8676002)(4326008)(66946007)(186003)(6916009)(26005)(38100700002)(2906002)(83380400001)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LpDjYS6oTEAmRB9YTlmT3foouiG71QfiIH1LeaFQOrZjADP7Oo9cgYzCpt?=
 =?iso-8859-1?Q?5fLJB/vb8nx2gmUfzrcZjxqgy2mte67Y/THUCsyQn9WC1Xk6sYTB1jjvT2?=
 =?iso-8859-1?Q?VlS24TYeCBgCm05B/uFAKM1WHghDom8BpNKJDQwRTKBAClCEiAkdPN/bwp?=
 =?iso-8859-1?Q?iL+1h6jfcWTc7duZewB57YW/7vRCDoYh11yjBBYWK6TenwdXTZQp50enpw?=
 =?iso-8859-1?Q?cejaxqnq52UOOfTzWAN6JXdWg42qWLZm1wvdlUBeSBzomIhh2Z+ogbLCeq?=
 =?iso-8859-1?Q?AAHBFDW5pq9sCCZmkGHQsekWURez8C8IEPL6gP4yph1W2ybbxw/1/VSDL8?=
 =?iso-8859-1?Q?lREkfVDHEwp3aywW0AfU2Zy8PamXGkfAcU7VGOOlWl3d4kWfpnq3RkvsFF?=
 =?iso-8859-1?Q?aLLaMe1KZKIvc1h2ziPkwTt3nW6fj42U4mJO9Huz5Z7k06g+2kypTX5++L?=
 =?iso-8859-1?Q?SpoBMNoVW3cFCVR01SQGoZiVPWiqKatnitwQjKt8F4Ad32ZKkHsgtzNcSR?=
 =?iso-8859-1?Q?NAt73w3xqDU6TSn+M0kjNa4lvWH8YCDzd3grnfEQ8jdL/piqfq+IGHbXIC?=
 =?iso-8859-1?Q?N0DBt4xvgQdNKTaTV9xrgZuUAJhrM+qLGOftyICU9gkZ5gCb4At5NqZcvW?=
 =?iso-8859-1?Q?fNJUmvpGLPyRmgj0rKx8uH56+L/G54JT9XRdtnuvcyosbjamkK3wXmsNdr?=
 =?iso-8859-1?Q?dJEw1yGrehBlaRWRKpOMh86P+lfwCHEsOu3AnBCsVR1zfOfuMiPKbHp09y?=
 =?iso-8859-1?Q?IRlNIjR5gxygnggJGqow/rz8ey6HsFFHx9eHQGYBrNjLACSVBdDVY8OpFK?=
 =?iso-8859-1?Q?7MzfOxTUnrrtbDQC0hlzjOgZYs+G/2/PfjF0x8ScRpnicTK9dXTFIC9gts?=
 =?iso-8859-1?Q?bxT7duW9//XJcK4/110e3tEfPnDwnbAYl2ADIJQiGpz+X8oxEm7il+1yBm?=
 =?iso-8859-1?Q?fsKMSsWLNiui82cbFmraVgbT/V7aZOF7BNcdvR7DH3fQ6fzgS4BsnyfpNK?=
 =?iso-8859-1?Q?NVUuE5pugTzQopLwcKwfGxyuFA+cTkjxWFwBVUurAKb720JnsmvDawOGIF?=
 =?iso-8859-1?Q?9pYfmOabOpkEM7fXL8I7BLOJf2IH+wDgvvupkZ8RDAt2J112DnGxLFOoOE?=
 =?iso-8859-1?Q?Qn6o6fnR6B40dXbSTwb5ueoM9H4IBaGm95oZ8ujuDO3nC2S+8dCOjfK90A?=
 =?iso-8859-1?Q?TgYv8sbawzDzrpsZRIxKVisvuWpF3VaQsUl+aNrvY6r7Cmp9b4xsAlNbxY?=
 =?iso-8859-1?Q?Mu47Ul/L0adLzikKR/qcLmR8ad8f/KymWG8VLMrMqm2qD3yHiMPu2K+NZd?=
 =?iso-8859-1?Q?yAZcmqFOvo69lkSHmmSF0AUk16OXTuo7sL3yY/ta3o5LHlO91w8DtNgY4P?=
 =?iso-8859-1?Q?c45N9B5ZuAGGllxqWh084Bo/OQkalFn/tZ5XNkxL5Rj6TB6ohprz8mP4s8?=
 =?iso-8859-1?Q?YhsQBiBnfMg5Ec6djOi6y9NOhBWD0AuL/cjWKAoktTJCtCfJFY9200Ust8?=
 =?iso-8859-1?Q?qYQOkpgp3v/TW8QEKjayi74zBhKoo3YOuz1xzdqfRgBZ8tPo1y3FmRYkUm?=
 =?iso-8859-1?Q?PbzobTQF0DN1uMAe7FDXsaySAnyG3RqKW3NcnmnzhFeiYWm3md+39Hp84h?=
 =?iso-8859-1?Q?eCto3Hm5H5idtP/aYU92Qrk1IC49tDcvunjDNsvuxfcebMqYMHYJgPl5Y8?=
 =?iso-8859-1?Q?qP+VDCxDvqYj5HME4XC2bqFtGPSZZWFeogK5NmoyXAkzBC77WM0sXpslFs?=
 =?iso-8859-1?Q?iTDgAHKLR1g/CrWL1pxLPCJEdM3k8fnYrYIEfIFkt3Uwmwahv/QghJN+Ef?=
 =?iso-8859-1?Q?2XSAwHqbKQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ef9161-ce95-4729-2546-08da2e7a5267
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 09:33:33.3174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8foOoZj8OZ5M8XmM2M62alrV9cnwIKduHnGR6QGxRKdYZSCQYNZmZiKPRnDjJ60Zds/VzEcd7mPHNyuXyzTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 05/05/ , Christian König wrote:
> It's over a decade ago that this was actually used for more than ring and
> IB tests. Just use the static register directly where needed and nuke the
> now useless infrastructure.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Lang Yu <Lang.Yu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 --------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 13 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 27 ++---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 25 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 54 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 64 +++++--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 24 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 26 ++--------
>  8 files changed, 43 insertions(+), 226 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 5d6b04fc6206..ede2fa56f6c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -98,42 +98,6 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
>  			adev->gfx.me.queue_bitmap);
>  }
>  
> -/**
> - * amdgpu_gfx_scratch_get - Allocate a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Allocate a CP scratch register for use by the driver (all asics).
> - * Returns 0 on success or -EINVAL on failure.
> - */
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg)
> -{
> -	int i;
> -
> -	i = ffs(adev->gfx.scratch.free_mask);
> -	if (i != 0 && i <= adev->gfx.scratch.num_reg) {
> -		i--;
> -		adev->gfx.scratch.free_mask &= ~(1u << i);
> -		*reg = adev->gfx.scratch.reg_base + i;
> -		return 0;
> -	}
> -	return -EINVAL;
> -}
> -
> -/**
> - * amdgpu_gfx_scratch_free - Free a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Free a CP scratch register allocated for use by the driver (all asics)
> - */
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg)
> -{
> -	adev->gfx.scratch.free_mask |= 1u << (reg - adev->gfx.scratch.reg_base);
> -}
> -
>  /**
>   * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 45522609d4b4..53526ffb2ce1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -110,15 +110,6 @@ struct amdgpu_kiq {
>  	const struct kiq_pm4_funcs *pmf;
>  };
>  
> -/*
> - * GPU scratch registers structures, functions & helpers
> - */
> -struct amdgpu_scratch {
> -	unsigned		num_reg;
> -	uint32_t                reg_base;
> -	uint32_t		free_mask;
> -};
> -
>  /*
>   * GFX configurations
>   */
> @@ -288,7 +279,6 @@ struct amdgpu_gfx {
>  	struct amdgpu_mec		mec;
>  	struct amdgpu_kiq		kiq;
>  	struct amdgpu_imu		imu;
> -	struct amdgpu_scratch		scratch;
>  	bool				rs64_enable; /* firmware format */
>  	const struct firmware		*me_fw;	/* ME firmware */
>  	uint32_t			me_fw_version;
> @@ -376,9 +366,6 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>  	return (u32)((1ULL << bit_width) - 1);
>  }
>  
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg);
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
> -
>  void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>  				 unsigned max_sh);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 64d36622ee23..4b66b9c93754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3744,13 +3744,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  	gfx_v10_0_init_spm_golden_registers(adev);
>  }
>  
> -static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  static void gfx_v10_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>  				       bool wc, uint32_t reg, uint32_t val)
>  {
> @@ -3787,34 +3780,26 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r) {
> -		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
> -		return r;
> -	}
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> -
> +	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
>  	r = amdgpu_ring_alloc(ring, 3);
>  	if (r) {
>  		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>  			  ring->idx, r);
> -		amdgpu_gfx_scratch_free(adev, scratch);
>  		return r;
>  	}
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -	amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START));
> +	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> +			  PACKET3_SET_UCONFIG_REG_START);
>  	amdgpu_ring_write(ring, 0xDEADBEEF);
>  	amdgpu_ring_commit(ring);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32(scratch);
> +		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
>  		if (tmp == 0xDEADBEEF)
>  			break;
>  		if (amdgpu_emu_mode == 1)
> @@ -3826,8 +3811,6 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
>  
> -	amdgpu_gfx_scratch_free(adev, scratch);
> -
>  	return r;
>  }
>  
> @@ -4852,8 +4835,6 @@ static int gfx_v10_0_sw_init(void *handle)
>  
>  	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
>  
> -	gfx_v10_0_scratch_init(adev);
> -
>  	r = gfx_v10_0_me_init(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f0f13eeb4b71..7bf09eeaced0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -297,13 +297,6 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
>  	gfx_v11_0_init_spm_golden_registers(adev);
>  }
>  
> -static void gfx_v11_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>  				       bool wc, uint32_t reg, uint32_t val)
>  {
> @@ -340,24 +333,16 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
> +	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r) {
> -		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
> -		return r;
> -	}
> -
>  	WREG32(scratch, 0xCAFEDEAD);
> -
>  	r = amdgpu_ring_alloc(ring, 5);
>  	if (r) {
>  		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>  			  ring->idx, r);
> -		amdgpu_gfx_scratch_free(adev, scratch);
>  		return r;
>  	}
>  
> @@ -365,7 +350,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  		gfx_v11_0_ring_emit_wreg(ring, scratch, 0xDEADBEEF);
>  	} else {
>  		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -		amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START));
> +		amdgpu_ring_write(ring, scratch -
> +				  PACKET3_SET_UCONFIG_REG_START);
>  		amdgpu_ring_write(ring, 0xDEADBEEF);
>  	}
>  	amdgpu_ring_commit(ring);
> @@ -382,9 +368,6 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
> -
> -	amdgpu_gfx_scratch_free(adev, scratch);
> -
>  	return r;
>  }
>  
> @@ -1631,8 +1614,6 @@ static int gfx_v11_0_sw_init(void *handle)
>  
>  	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
>  
> -	gfx_v11_0_scratch_init(adev);
> -
>  	if (adev->gfx.imu.funcs) {
>  		if (adev->gfx.imu.funcs->init_microcode) {
>  			r = adev->gfx.imu.funcs->init_microcode(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 29a91b320d4f..204b246f0e3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1778,39 +1778,26 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
>  	udelay(50);
>  }
>  
> -
> -static void gfx_v6_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = mmSCRATCH_REG0;
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>  
>  	r = amdgpu_ring_alloc(ring, 3);
>  	if (r)
> -		goto error_free_scratch;
> +		return r;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
> -	amdgpu_ring_write(ring, (scratch - PACKET3_SET_CONFIG_REG_START));
> +	amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START);
>  	amdgpu_ring_write(ring, 0xDEADBEEF);
>  	amdgpu_ring_commit(ring);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32(scratch);
> +		tmp = RREG32(mmSCRATCH_REG0);
>  		if (tmp == 0xDEADBEEF)
>  			break;
>  		udelay(1);
> @@ -1818,9 +1805,6 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>  
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
> -
> -error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -1903,50 +1887,42 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>  static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
>  	struct dma_fence *f = NULL;
> -	uint32_t scratch;
> +	struct amdgpu_ib ib;
>  	uint32_t tmp = 0;
>  	long r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>  	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>  	if (r)
> -		goto err1;
> +		return r;
>  
>  	ib.ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
> -	ib.ptr[1] = ((scratch - PACKET3_SET_CONFIG_REG_START));
> +	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
>  	ib.ptr[2] = 0xDEADBEEF;
>  	ib.length_dw = 3;
>  
>  	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>  	if (r)
> -		goto err2;
> +		goto error;
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
>  		r = -ETIMEDOUT;
> -		goto err2;
> +		goto error;
>  	} else if (r < 0) {
> -		goto err2;
> +		goto error;
>  	}
> -	tmp = RREG32(scratch);
> +	tmp = RREG32(mmSCRATCH_REG0);
>  	if (tmp == 0xDEADBEEF)
>  		r = 0;
>  	else
>  		r = -EINVAL;
>  
> -err2:
> +error:
>  	amdgpu_ib_free(adev, &ib, NULL);
>  	dma_fence_put(f);
> -err1:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -3094,8 +3070,6 @@ static int gfx_v6_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>  
> -	gfx_v6_0_scratch_init(adev);
> -
>  	r = gfx_v6_0_init_microcode(adev);
>  	if (r) {
>  		DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index ac3f2dbba726..0f2976507e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2049,26 +2049,6 @@ static void gfx_v7_0_constants_init(struct amdgpu_device *adev)
>  	udelay(50);
>  }
>  
> -/*
> - * GPU scratch registers helpers function.
> - */
> -/**
> - * gfx_v7_0_scratch_init - setup driver info for CP scratch regs
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Set up the number and offset of the CP scratch registers.
> - * NOTE: use of CP scratch registers is a legacy interface and
> - * is not used by default on newer asics (r6xx+).  On newer asics,
> - * memory buffers are used for fences rather than scratch regs.
> - */
> -static void gfx_v7_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = mmSCRATCH_REG0;
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  /**
>   * gfx_v7_0_ring_test_ring - basic gfx ring test
>   *
> @@ -2082,36 +2062,28 @@ static void gfx_v7_0_scratch_init(struct amdgpu_device *adev)
>  static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>  	r = amdgpu_ring_alloc(ring, 3);
>  	if (r)
> -		goto error_free_scratch;
> +		return r;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -	amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START));
> +	amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START);
>  	amdgpu_ring_write(ring, 0xDEADBEEF);
>  	amdgpu_ring_commit(ring);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32(scratch);
> +		tmp = RREG32(mmSCRATCH_REG0);
>  		if (tmp == 0xDEADBEEF)
>  			break;
>  		udelay(1);
>  	}
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
> -
> -error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -2355,48 +2327,40 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_ib ib;
>  	struct dma_fence *f = NULL;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	long r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>  	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>  	if (r)
> -		goto err1;
> +		return r;
>  
>  	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> -	ib.ptr[1] = ((scratch - PACKET3_SET_UCONFIG_REG_START));
> +	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
>  	ib.ptr[2] = 0xDEADBEEF;
>  	ib.length_dw = 3;
>  
>  	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>  	if (r)
> -		goto err2;
> +		goto error;
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
>  		r = -ETIMEDOUT;
> -		goto err2;
> +		goto error;
>  	} else if (r < 0) {
> -		goto err2;
> +		goto error;
>  	}
> -	tmp = RREG32(scratch);
> +	tmp = RREG32(mmSCRATCH_REG0);
>  	if (tmp == 0xDEADBEEF)
>  		r = 0;
>  	else
>  		r = -EINVAL;
>  
> -err2:
> +error:
>  	amdgpu_ib_free(adev, &ib, NULL);
>  	dma_fence_put(f);
> -err1:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -4489,8 +4453,6 @@ static int gfx_v7_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>  
> -	gfx_v7_0_scratch_init(adev);
> -
>  	r = gfx_v7_0_init_microcode(adev);
>  	if (r) {
>  		DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index e4e779a19c20..90f64219d291 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -835,37 +835,25 @@ static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
>  	}
>  }
>  
> -static void gfx_v8_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = mmSCRATCH_REG0;
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>  	r = amdgpu_ring_alloc(ring, 3);
>  	if (r)
> -		goto error_free_scratch;
> +		return r;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -	amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START));
> +	amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START);
>  	amdgpu_ring_write(ring, 0xDEADBEEF);
>  	amdgpu_ring_commit(ring);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32(scratch);
> +		tmp = RREG32(mmSCRATCH_REG0);
>  		if (tmp == 0xDEADBEEF)
>  			break;
>  		udelay(1);
> @@ -874,8 +862,6 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
>  
> -error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -2000,8 +1986,6 @@ static int gfx_v8_0_sw_init(void *handle)
>  
>  	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
>  
> -	gfx_v8_0_scratch_init(adev);
> -
>  	r = gfx_v8_0_init_microcode(adev);
>  	if (r) {
>  		DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 06182b7e4351..83639b5ea6a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -950,13 +950,6 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
>  						(const u32)ARRAY_SIZE(golden_settings_gc_9_x_common));
>  }
>  
> -static void gfx_v9_0_scratch_init(struct amdgpu_device *adev)
> -{
> -	adev->gfx.scratch.num_reg = 8;
> -	adev->gfx.scratch.reg_base = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
> -	adev->gfx.scratch.free_mask = (1u << adev->gfx.scratch.num_reg) - 1;
> -}
> -
>  static void gfx_v9_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>  				       bool wc, uint32_t reg, uint32_t val)
>  {
> @@ -994,27 +987,23 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	uint32_t scratch;
>  	uint32_t tmp = 0;
>  	unsigned i;
>  	int r;
>  
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> -	if (r)
> -		return r;
> -
> -	WREG32(scratch, 0xCAFEDEAD);
> +	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
>  	r = amdgpu_ring_alloc(ring, 3);
>  	if (r)
> -		goto error_free_scratch;
> +		return r;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -	amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START));
> +	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> +			  PACKET3_SET_UCONFIG_REG_START);
>  	amdgpu_ring_write(ring, 0xDEADBEEF);
>  	amdgpu_ring_commit(ring);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32(scratch);
> +		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
>  		if (tmp == 0xDEADBEEF)
>  			break;
>  		udelay(1);
> @@ -1022,9 +1011,6 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>  
>  	if (i >= adev->usec_timeout)
>  		r = -ETIMEDOUT;
> -
> -error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
>  	return r;
>  }
>  
> @@ -2338,8 +2324,6 @@ static int gfx_v9_0_sw_init(void *handle)
>  
>  	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
>  
> -	gfx_v9_0_scratch_init(adev);
> -
>  	r = gfx_v9_0_init_microcode(adev);
>  	if (r) {
>  		DRM_ERROR("Failed to load gfx firmware!\n");
> -- 
> 2.25.1
> 
