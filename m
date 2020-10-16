Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A250BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E52D20829
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T6fffM68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52D20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6852F6EDDA;
	Fri, 16 Oct 2020 15:11:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8786EDDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 15:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxgCNJbIlBt1VGJXFCiwAqjMWUFPCwxSPwM+mdBGRJIUiMC1TPvK+FAMon8dSJn3cDBnPf1MD85wquwoBDtj8epOY0a8veISOMvKHQ3AC307kkaUSkTATwPhntqPCn0cMmmJLdKAHFVMZPcFENkvyCtiEPAFAenTVSJZmBtNCRr8/IVBFilMRPo2Fwx/STyXOdpDZLidGJCyN13h8reBZ1vXElEFJ8tDF9hEuU6ekD/puyYMNAvorfq5cb3nk0P5eMK6YYD2qYKOSh1MOazqPZ2fC1u/S4MR0jS0u7ckZdErePnpNaSZmf8Pwegc0XP84walkgX825dYRb3QclPH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vhuS+zm2H7PhPnySI1zZvVi2VFNFOgaAIXJdrdEyhk=;
 b=BzjzsiHyOpQu/OTu5u1pM5TYBwakvjSsgdmKlVE5BCvBP+Mogtc+SfBIrsKEgFgXvzOzjXhIyL2IJmof6m5BCdkR5kliLf8hrP7fho/DJyYOk1a7qSHglRLfjdLWbUjdl+N/vqeWKk1l3zHDK34TVGYBNSnknp2WrYRitoXWrLCjrPgQcXa60CwgD+GfcR9ZjJ0asOU/UdIzkH+8YSmXS7ng57MEQ6sqZc8KbAryuoUg3Ar6P6o1d7YfTHbBYfjrF9MNozdVIA8HkAGlClVuUzLuy8qpd0Qj4lZXQWWTQZprpdPdm5t4Ygw59x0jxcyt/RqWCnc+U5FfMfK94yOfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vhuS+zm2H7PhPnySI1zZvVi2VFNFOgaAIXJdrdEyhk=;
 b=T6fffM68LvvYD4NWPIMN5XfhTRNCkKTIGu3I14z8M5JCNTetmNFnrwS1fUoV4+u8SDyY+84VgSfX+XO8K/rshPg3/VwpIMwfoenI/Q82QxgAm+/G0gXN7cVmK2CMZ3Pu14Z0idTloEQLA2oNbunDt9IVtTxbS+0N1P+2oCcZhFI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 16 Oct
 2020 15:11:54 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 15:11:54 +0000
Subject: Re: [PATCH] drm/amdgpu: move amdgpu_num_kcq handling to a helper
To: amd-gfx@lists.freedesktop.org
References: <20201016142003.1095354-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3cc01b29-5498-0761-df58-391b3467bb90@amd.com>
Date: Fri, 16 Oct 2020 17:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201016142003.1095354-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:408:e7::31) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.17] (165.204.84.11) by
 BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24 via Frontend Transport; Fri, 16 Oct 2020 15:11:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb1860f4-b6c3-43a3-c624-08d871e5d101
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:
X-Microsoft-Antispam-PRVS: <DM6PR12MB487920034FC89599552D212E8B030@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBXZP6egfNR1a0o7fsObhe9jGVk+A+OIRL38KUVS82HcFj9Mt7M8WoNTu2p4n+TiH8Sm2Rh0iLA1CRX89QaGBMFXdLkSHL7FJQxpN24aJiDyPhN41gqLn44n3yE3At0Hz2Qcdb3MwMWd5g+H6f7c0QG8q8XoemjWkLID4uTIYN7qxCyv1e9h84hdj8Kj8sD9bPiJFDb2o40ZaNyw5zed4y7hOj6dnaJWlK1fDHwAZbwTRitqFptYeSLtWO1UAlvicfUWCRkwWi+PjthH3EaZ+DMMIvDcfJqYTZDyYGBegrYqrIOw9k41K4S15QCGTexH2jcsvB6UetH2RULPQuLAVUybUpw2Bzb2ENl/F/HLmpA6s85mKf6yy3SAiJs3Z+Go2YJa90+ga2e3f4nbGyz/iRxWrLbaHCFDV7Eu4NGaGLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(6916009)(2906002)(316002)(16576012)(36756003)(5660300002)(83380400001)(6486002)(31686004)(66946007)(26005)(66556008)(66476007)(34490700002)(478600001)(31696002)(52116002)(53546011)(8936002)(956004)(2616005)(16526019)(186003)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8jQBu3dgpihfPzyuupD6B6Y5brHIiZlD75YK4seQ0UrtIjCc03HDaAZaD0j03vfuvskudRqh6U0gIC8v0o+weFXYUHD32YFtad5D3zNoag/Kz442VA9vAwIRaAyYD/xPYZzMmFA3O/pJxlZRvpr9MibyeNXQJqFnYw0I6aUgfCmP0tsRoLqv8bcpk9XF4AhFzCUs7CHKKl2m36pib+Qpdtf65u7OU+YBuJ4/PaYKopu9jEuUK0PPllZBKhWjJpD3DFecoB896hL3r93N8tzaiO3pRzM1UI+2Q+3CGkzLcApqXYcgcMbPG0dlIKqwuRCZiE8FQq4jn287l8Vj5hbvCf3tQFRk+yUa7bhh6ZNv8L3lR/fhgabxtfghW+Hz16pPTtGROelzg7+47ZuhL9Q9kwcSxI5BWDeFZtAwudn23K6k9exQFLqAtBhOJ2iNciPEtsxfnnza9FKX+xYiUv24rwns9bH/X96f078i3AjNMLtiXC9T9BgUR6xxWd67YtQcMiwmtu5bHMPZ1xT+nN8yNt8zkRTfIUxbEo9PegKBR8oIRtbHhDWqKxoEfBRsiROMa1pdS8ASkmLEOINEavnq0eDMQiUM9squRSVI2aYECgXPvtQQMQ7K7ufSZVDn03ALokjbaVVSYayI0kgywex8ng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1860f4-b6c3-43a3-c624-08d871e5d101
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 15:11:54.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLf3RsB9NwFsWpt3KQCmOAcEeJSlURH9yeVDrrUmcZB5l7KftqmQOMU6cqD5df4M7Ea7t0+RTvjQppxBPKMgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 10/16/20 4:20 PM, Alex Deucher wrote:
> Add a helper so we can set per asic default values. Also,
> the module parameter is currently clamped to 8, but clamp it
> per asic just in case some asics have different limits in the
> future. Enable the option on gfx6,7 as well for consistency.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 -------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  3 ++-
>   8 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index abddcd9dab3d..fb9e61f861e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1374,13 +1374,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   
>   	amdgpu_gmc_tmz_set(adev);
>   
> -	if (amdgpu_num_kcq == -1) {
> -		amdgpu_num_kcq = 8;
> -	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> -		amdgpu_num_kcq = 8;
> -		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
> -	}
> -
>   	amdgpu_gmc_noretry_set(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8c9bacfdbc30..e584f48f3b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -804,3 +804,14 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   failed_kiq_write:
>   	dev_err(adev->dev, "failed to write reg:%x\n", reg);
>   }
> +
> +int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_num_kcq == -1) {
> +		return 8;
> +	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
> +		return 8;
> +	}
> +	return amdgpu_num_kcq;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 190753930b11..786eb4aa7314 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -393,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry);
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 669c352c27af..b4df472194af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7406,7 +7406,8 @@ static int gfx_v10_0_early_init(void *handle)
>   		break;
>   	}
>   
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>   
>   	gfx_v10_0_set_kiq_pm4_funcs(adev);
>   	gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 79c52c7a02e3..671c46ebeced 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3064,7 +3064,8 @@ static int gfx_v6_0_early_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	adev->gfx.num_gfx_rings = GFX6_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = GFX6_NUM_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  GFX6_NUM_COMPUTE_RINGS);
>   	adev->gfx.funcs = &gfx_v6_0_gfx_funcs;
>   	adev->gfx.rlc.funcs = &gfx_v6_0_rlc_funcs;
>   	gfx_v6_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 04eaf3a8fddb..cb07bc21dcbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4238,7 +4238,8 @@ static int gfx_v7_0_early_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	adev->gfx.num_gfx_rings = GFX7_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>   	adev->gfx.funcs = &gfx_v7_0_gfx_funcs;
>   	adev->gfx.rlc.funcs = &gfx_v7_0_rlc_funcs;
>   	gfx_v7_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 94b7e0531d09..6487ea3cfdd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5295,7 +5295,8 @@ static int gfx_v8_0_early_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>   	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>   	gfx_v8_0_set_ring_funcs(adev);
>   	gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2c3224948ea5..d3df4c0441a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4635,7 +4635,8 @@ static int gfx_v9_0_early_init(void *handle)
>   		adev->gfx.num_gfx_rings = 0;
>   	else
>   		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
>   	gfx_v9_0_set_ring_funcs(adev);
>   	gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
