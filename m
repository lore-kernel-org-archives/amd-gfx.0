Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A4C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D03420658
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mygBl9yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D03420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF8D6E216;
	Thu, 26 Mar 2020 23:09:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F0E6E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 23:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEd7t58and9yXV8sQE5IabkyRY8GeIHZoarPTeLZHAU4qYF40pGkJkAvn25tT1bVVh8EoZP1XMzPhiY95chAh2aj52hQ331aBBdQ44BXLuYWgWIp0RCrnZCrIPKq9YB/GY+idJskU/8JNyhPVHI6jHlJi/tk1k7xctUzNJwpiXVVseCPANYMU4BX/qKtjccb2rjsDVP74ouRIGpDR/wo1ozSNW1tIY7wK0Vn9NBUX/TNj3d2FXAi4uux86DhzOYtxbUSPGDqD8N+Ge9xuWknQy2wfPUemeRuj8gmjYuLtnZeXt1c4zTH4Zi+2kiFoQkW9rFTR2wCPR9EFLA7n3LdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzYNc9ZLpNoyc2cuHdOd8EGpCtHfPQurj7OMVfbm0T8=;
 b=MGAgor3tp0WFHuQ7EuEphHAc5o7o227ttrSgCQgDumNOv4DTExQo9BPraE+WEk3N+ng/ONxfDgwVvYpKXWH8eJeHmac3ixVVgpUdGvD2fAn61Ct6OqmNmGakgjbauy4mMkvjpgsqiGnVZ0vOS2vu++9yDuyzp73KAAx831NkUVerpKXSxGPVh5O9lvnqfVyots1gpX4m9PEBxPKDuvm+inBY9LRjmto1lvtPLxUKY+Jw/sZVBMPslegeDJKJXt45SQlFiU9E1QfpGgyPJj4yON0OwfhUoq/5Nv1naHnH3m+DA70XyTcy3bDNwRrlDllL1+7O2bvXzo2xvbY5MuXNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzYNc9ZLpNoyc2cuHdOd8EGpCtHfPQurj7OMVfbm0T8=;
 b=mygBl9yGnLLO+67MH9OVAERIAxOqZzcvke6aTXIWhtRXC3D4ZqT9MF4U3L71A0IZnH/tUJ5/Afvh9UKWMbxwOr0Sj6aZKZjdtnxe8PhMc/9jmM6lM5SepREwmCOTdw9sFynQqwCdbgU5Jg4AZv++w7uuTud2WWWEv7N4B25y8sc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Thu, 26 Mar
 2020 23:09:18 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 23:09:17 +0000
Subject: Re: [PATCH v2 2/4] drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585252968-1218-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <d651b941-da97-fdf0-cfc9-37195612ec56@amd.com>
Date: Thu, 26 Mar 2020 19:09:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <1585252968-1218-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Thu, 26 Mar 2020 23:09:16 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 698e42ed-e923-4787-9ef3-08d7d1dab573
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:|DM6PR12MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33691768195AE99A4AFA13D599CF0@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:312;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(478600001)(66946007)(26005)(8676002)(31696002)(52116002)(6486002)(956004)(81166006)(66556008)(2616005)(31686004)(4326008)(81156014)(316002)(36756003)(16576012)(66476007)(8936002)(2906002)(86362001)(55236004)(44832011)(5660300002)(53546011)(186003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3369;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyMdBmcvlJ3T7UFnjOQcG0qYigZbRcyKjLNhn0dZSd+/lMLGCd0ix4lYo7gm+xeix2D0VMPJDniywiRTm1QzQ3iu7XfUCd1u33VAHFDGsy+W9huueZmMmr7OHuK0a2fdDpQrjtG4yb1nDBgxH+3QuJReOTqFwF2vrRRqHqcvtmpiBIB05Axsy3xPJ3F4yNoQEhtcbJe/49exweSmjljPgL08PtmevLetuobUY+KTnvl/PGXRrqezlM+NPw53Pv3mmogTC6OA/UbZezhHqfBJjj4N47q2JKucUt4a59WNfWrkawKWeQ/wESjdEeYJFq/PXy3hSyH4W6YhdaUmSnhZWa1W6KmMKeiT+Y3+72UuPBF9MFBCxZF22A72kXtmsmLBgUtS3IH2t+GxF3tnrFupDxcKKGDMnYxUZ2K4tBzNOib21ZsM979GTO506fEYdk27
X-MS-Exchange-AntiSpam-MessageData: ioaSSlTrAReuG/EAm9vJKSOvypnsWN8A97fXKVEF759h44hvyxFloA9QHhqqkxTHUk3u3AGiikS5W8CAhZeWeijVfxlMOr33o8zk3g3y3oC3NRiloPurYI2wjXOW3rfSG3UFjO219qScz7RDogJs5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698e42ed-e923-4787-9ef3-08d7d1dab573
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 23:09:17.5482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e2tv8UG6deGJdWZePg4qBOZ/fiwDTXFF0p6utPthm8PAZHppwtUnz1GqWAxorkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: alexdeucher@gmail.com, Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That looks so much better--thank you! Excellent!

Regards,
Luben

On 2020-03-26 16:02, Andrey Grodzovsky wrote:
> Add this for gfx10 and gfx9.
> 
> v2: Fix identation
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nvd.h    | 48 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc15d.h | 25 ++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
> index f3d8771..fd6b582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -256,6 +256,54 @@
>  #define	PACKET3_BLK_CNTX_UPDATE				0x53
>  #define	PACKET3_INCR_UPDT_STATE				0x55
>  #define	PACKET3_ACQUIRE_MEM				0x58
> +/* 1.  HEADER
> + * 2.  COHER_CNTL [30:0]
> + * 2.1 ENGINE_SEL [31:31]
> + * 2.  COHER_SIZE [31:0]
> + * 3.  COHER_SIZE_HI [7:0]
> + * 4.  COHER_BASE_LO [31:0]
> + * 5.  COHER_BASE_HI [23:0]
> + * 7.  POLL_INTERVAL [15:0]
> + * 8.  GCR_CNTL [18:0]
> + */
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
> +		/*
> +		 * 0:NOP
> +		 * 1:ALL
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
> +		/*
> +		 * 0:ALL
> +		 * 1:reserved
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(x) ((x) << 4)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(x) ((x) << 5)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_WB(x) ((x) << 6)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(x) ((x) << 9)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
> +		/*
> +		 * 0:ALL
> +		 * 1:VOL
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
> +#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
> +		/*
> +		 * 0: PARALLEL
> +		 * 1: FORWARD
> +		 * 2: REVERSE
> +		 */
> +#define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
>  #define	PACKET3_REWIND					0x59
>  #define	PACKET3_INTERRUPT				0x5A
>  #define	PACKET3_GEN_PDEPTE				0x5B
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 295d68c..799925d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -253,7 +253,30 @@
>  #              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
>  #              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
>  #              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
> -#define	PACKET3_AQUIRE_MEM				0x58
> +#define	PACKET3_ACQUIRE_MEM				0x58
> +/* 1.  HEADER
> + * 2.  COHER_CNTL [30:0]
> + * 2.1 ENGINE_SEL [31:31]
> + * 3.  COHER_SIZE [31:0]
> + * 4.  COHER_SIZE_HI [7:0]
> + * 5.  COHER_BASE_LO [31:0]
> + * 6.  COHER_BASE_HI [23:0]
> + * 7.  POLL_INTERVAL [15:0]
> + */
> +/* COHER_CNTL fields for CP_COHER_CNTL */
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_NC_ACTION_ENA(x) ((x) << 3)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WC_ACTION_ENA(x) ((x) << 4)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_INV_METADATA_ACTION_ENA(x) ((x) << 5)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_VOL_ACTION_ENA(x) ((x) << 15)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(x) ((x) << 18)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(x) ((x) << 22)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(x) ((x) << 23)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_CB_ACTION_ENA(x) ((x) << 25)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_DB_ACTION_ENA(x) ((x) << 26)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(x) ((x) << 27)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_VOL_ACTION_ENA(x) ((x) << 28)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
> +#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)
>  #define	PACKET3_REWIND					0x59
>  #define	PACKET3_LOAD_UCONFIG_REG			0x5E
>  #define	PACKET3_LOAD_SH_REG				0x5F
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
