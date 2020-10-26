Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB144C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CAD20759
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SX03gzLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CAD20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B0C6EA83;
	Mon, 26 Oct 2020 23:12:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5FD6EA83
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 23:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ0p0rSBSyE8saZvE6xVe59BS7AS3jXy1A5ULXKwIVI6Wp4UtHApjLdR1y6lSvdSVYi/4bozhcAlzXj8PVEY1UFvGrmUsR2GB3fzT09Euj3JdNK3uOAFAPCWZQcvVR/yQ1pOxloLJqinlDbSpFxzPSFKLovJOFyB80GiRvS3lv46aPGs7XIs0kujuoysDaHaLOTlyRDhQ8sRLjCJV8s683eqgTEv6NNMbMiJnRBDq8+zv7bikZs9C36fRt7xVp8uEOiLAH7rxe62Q6gwDtBYU4CPdPLOgLA2Gx8niCqhRYDHLKX0xP2f6QtxN2Ny0qQ0AkxcmWQD2ToCXBh++xCXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBIk9MsmuchqiAPK4KyyaAfE5a6C5SJMskWvCsOSEj8=;
 b=c+xF4sMiqj/kpWInpS/H9OzCjKcYosNPDfTLrZjDFC8EfnN/5ZwedO0yvg4lWYAEqUElGOnox3FK1cW55j0XSbdhWCLw5k9N8udKTfIW46zbsJtojFMUjRX1A/1bPyRB80OdqkJu7yVL+q3TKVeYATEGwikZ2aMZ6x3aIorPubY7JLKQqDUdHAajoHuXlwjEdb3HOcRWVLIgJZMpeDmTsWdZIQRQVj7oDPu3ksG5kc+8Pgv/vWBFHe3+Q5SkuG2RqKalHr69BKxilMiGDS1RAyjhdtkRGQMD1o9puwUfkjXLYD8AIe53afe+hfw3emmWk9htzqk/YwMofHfab8u8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBIk9MsmuchqiAPK4KyyaAfE5a6C5SJMskWvCsOSEj8=;
 b=SX03gzLlEybY7q9gNmBXFfCexcn/zVwbv4YV45tXD2XW6DraTgMN/9JkfpsHX0EC7IQqRrO/GIH2rWzKfYWNtevwi0mZ8sR9pu8YCIBKasLYUtVcyatGNRhggiw3SGU8fX7abngd3KFg/eR49TjKgqsvC1dYrR/QWZvYjoNn0Yk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 23:11:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 23:11:58 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: add support to configure MALL for
 sienna_cichlid (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201020202617.2465215-1-alexander.deucher@amd.com>
 <20201020202617.2465215-2-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <dd82220b-e76e-b143-611d-5ef9ec4e9fd7@amd.com>
Date: Mon, 26 Oct 2020 19:11:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201020202617.2465215-2-alexander.deucher@amd.com>
Content-Language: en-GB
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 23:11:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72a7d819-da10-40c7-0a2c-08d87a048991
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31780B8364AA1F19740E729999190@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBV033tCUQ9briq3Hyi3i7v7x1xqAlsZ9qQmFZm9cHo3eV+/js8I5PxRAYsD8dpuzscX1ebEvLANcVSHAcnYQyW0gQARwv8g9u3PfPdGNSmJCpdI7HehybEZJt+WaHoYYh0G2OvpE6YoHok04mutX+moA+H66lDTCSUpD+dQ31DNJ+iP6JHG8l7fe2O5R5jBR4dGn/bIxdtHxw1erLv1GetKH92JBUQ93ubbmCQNr1s8akUI3Oorac+83Q1sU8DHVuPH4QF5hsmNhzBsLYaHzWSmz0XMuAVhCf95/sWfQleQKcStcz27BzCoAe889Vly4xucIGCEmJYwhSBCC/7lt1TufkdY5V6S6Ga2CpIgkpZwpq2wDo/UZIobXvlGfmBc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(4001150100001)(54906003)(86362001)(31686004)(5660300002)(316002)(478600001)(6486002)(4326008)(956004)(16526019)(186003)(44832011)(53546011)(66556008)(83380400001)(2616005)(6506007)(66476007)(66946007)(26005)(8676002)(2906002)(31696002)(8936002)(52116002)(6512007)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EDDN3eyUub68yamNOniMM/jkaD3+JhscsEUaX7yRpmNy8VOLSxmH+GKegkVKIcCZeiLpHImNugJUDuSEZjrTzPLDW4TlTS7iRd2z9Dotb/r34U+nK4SUi79DdF+7pn1uqQHfcx+Lh2EToSDiAQrmFNFx1++Fy/zoltY/E9kOWTgT/T+enpUunbZ0YhEa7RMXozaYOHJz3c6yFOQMTnpdBRavRM9yXRdRKhmKQWFEz95vir486k5VfVshMdw9SyduZEVP1b2IsOQ1MHxNFH4qz8qqje30o0kWnvDLXLyRx6y18IrJ35RhmkxyDt2y7DfCBE0Eb7itUPGW4fu7L5Qdx5jZoQmHj2OpiRruRekdxNgCgj19o9EMJLEfESkLPEVuekDoTbeO527Mhs7/Potm82pfF1hOsOVG58zNOVzDncLVovHeNOZZHSyfa8Veu5kDK8COxcLV76vW6iZDMV6FX+KokTl3feHZUa4v9xv/dFFjUf/Te+xSM94Nuu/9JEoHcSx/GWw82nZ7IMN240VD5AFt+9K4dX+ybYYV5IZ9q/INaEpdxnXZ6lQQkix0B6kwyL4Jbq3urucHlInMmQ7RIUXEZy4meMrDlmSNH3+X2AQHWcZNCxgtPFcm0KBIJxlIsGSXBlE8A0SqldMiOCLJXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7d819-da10-40c7-0a2c-08d87a048991
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 23:11:58.1135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+xEBYNneLztxam3Zctrs8Cw+DNpAdZZCYiXnUXq5szuIoZxvfetZ6HzzddX6EfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-20 4:26 p.m., Alex Deucher wrote:
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Enable Memory Access at Last Level (MALL) feature for sienna_cichlid.
> 
> v2: drop module option.  We need to add UAPI so userspace can
> request MALL per buffer.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ffea3b89b9da..929d7cb92dc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -76,6 +76,9 @@ struct amdgpu_bo_list_entry;
>  /* PTE is handled as PDE for VEGA10 (Translate Further) */
>  #define AMDGPU_PTE_TF		(1ULL << 56)
>  
> +/* MALL noalloc for sienna_cichlid, reserved for older ASICs  */
> +#define AMDGPU_PTE_NOALLOC	(1ULL << 58)
> +

Would've been good to define "MALL", as it is being
done in the message of this commit above, here
in this comment to the macro.

Else, what "MALL" means is lost, unless
one does git-blame and finds the commit which
introduced it.

Regards,
Luben

>  /* PDE Block Fragment Size for VEGA10 */
>  #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 40af17610207..ef385a529013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -486,7 +486,8 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
>  /*
>   * PTE format on NAVI 10:
>   * 63:59 reserved
> - * 58:57 reserved
> + * 58 reserved and for sienna_cichlid is used for MALL noalloc
> + * 57 reserved
>   * 56 F
>   * 55 L
>   * 54 reserved
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 18eca0d4dbcc..ae6158456094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -707,7 +707,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>  		temp &= 0xFF0FFF;
>  		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
>  			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
> -			 0x01000000);
> +			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
>  		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
