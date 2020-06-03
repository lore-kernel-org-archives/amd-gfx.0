Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E358C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C78320738
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="muYqU+zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C78320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C672789B97;
	Wed,  3 Jun 2020 14:56:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFB989B60
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 14:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZp4N2NJ/iXpgaruj+aLyHq5jCekvn5nzyhXHd7S7bbcdmD9rdEKCCUx9fNlR9V8u6avxqsCao4LFHNQe3yiajLnu4bxTf1CQe4HuKYNXUcjdJO5cO7ecbXRoxyKwU5uijdcJabr1fyz8L25G2P2U4Ygm3JErbUpC6wdUQlKSzbOeYmrvrMLIjH4/j4Stold97DWFKZ+Okpz8XwPUjnO5/5e68LYmLWH+ViStw493QdQKSUyl69lvJ4Y2A67CL2Uh74XLYhomcnCvEN93wad5ek/mOmeIfvAWsdJJIC7iG2uN2qQGaxFnmparZY9C1C6jiR+xVuXNu2LzHT/B2HPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXZYqNRiiJfUez77EyyTcHr8wxA+m3mYGevvXjMeCUI=;
 b=F9Leu3cUxMO0XbT5UpQp7wIdwViDVHajogzwyGvV+VECXCjKcR49WkROz2ENoibqYXV3NTCWJUu4s1cYo7BOKCul+mssHjID/5XBaqwuHsnnBGs9HUwrehkMTF485tPRDcRYMihjDiTr5p64FoBjM6xcCA2P9QdqUsQ5dkN3+fOlMWaacCPdX2QsofOfuePVTKv3EKrcGn32Qblj3X5N/BTuHVh4b+IcL9DZD7xZkal2Ha6chCAv7a6MvKp/HpIZorLCQ+9LnMaeoli5sI3gVc5xjkc4H7kJiymu5zfhrc9/s+S3xiNZ9OHNL6erNYSXimR29/qlRZlgwQOMjYD+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXZYqNRiiJfUez77EyyTcHr8wxA+m3mYGevvXjMeCUI=;
 b=muYqU+zJhjTOGXbK4rVTvyekT/JSgKI7yilrMnAJsj8haJpXtmnb8My7YNimPikE1bbAeHfgt6tsRrGXoBFJDhIVC3isgdr9YRaZtp03+FS415MtIfla311JPwl+gph9yP6rrbGsd/HOpI6wKbi6uEyEWdyDtneH7I/xH9C0aKw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 14:56:54 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 14:56:54 +0000
Subject: Re: [PATCH] drm/amdgpu: temporarily read bounding box from gpu_info
 fw for navi12
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200603020749.27189-1-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <0c7d1a76-523f-08de-79de-25be14a8052a@amd.com>
Date: Wed, 3 Jun 2020 10:56:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603020749.27189-1-tianci.yin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN1PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:408:e0::6) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 14:56:53 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1e62b84-3ed7-4dd4-6c43-08d807ce5ace
X-MS-TrafficTypeDiagnostic: DM6PR12MB4028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4028F783F6FC157195A08B8199880@DM6PR12MB4028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMIxiuEoMorYWB9IAq6fn7jgxb6MEqPaW5EH0f/rOmAfxMcLN9nIucrxi1rwXWDImu0TGdK5m6A+JWZar2q4IJaP5SBLNZQeRbE7RKZd69IRsqcvBNdJgizs1xwJFO2C2brFpkiPoe+/Rf7vAemXj77q9BnZrwXjmH+o0deO762TJf9PKNDCjv0yaJ12bijaDWB+YV4EcXQ49vv6XNbPqyly9rhYer7FHeEJnJXWuOQelKY0N7xKi9z/YZVuLTfTM5dB92qrrCDzCS9NjwduVZCSqGIo60T5PICuGJUXA0uS/ORGwiCDwHJWD/jVN5LujfAIB+jWF10U5zM21pyVUxgEZ+ugaE3qLaas/X4fGc9h0jSdmLMSe98oAcGO8Kfr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(52116002)(5660300002)(478600001)(31686004)(2906002)(66556008)(36756003)(86362001)(66946007)(66476007)(16526019)(26005)(8676002)(316002)(186003)(6512007)(6506007)(4326008)(31696002)(44832011)(956004)(54906003)(2616005)(53546011)(8936002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VZcBuQ4dlmOr/R3W/ArXqhdPPE2p7MvvtsqTTidFPkfV+7mV2u+tiZNh7hH8CfB3bqtMhkca79M56lP6w/Ies00GSLBUn15j/nitzclsAk5RezF1/7h98mtt3rKUG/iY6uFUPEaPGW9fTk5bfgm4OqARrd4Bt6xAZneDkR7sFj3plksVve0DUW+Z5j4eJtFKOkj/HqTSIwNjvBHuRc4A2i2PY8VzBVq0yAJ0n4NSHkZ6h27xFjJOsmx2YZ+VtxWyhvodge26VGHnR9ckMmOl14iyeAjr2eLDie0zmD09vFh1BzPOxKnpG94fJF6pAlMnmYyez1IKaRm6WNZugqwR5LOD5V5z28kPr0fM4zsWQgzAOnZkP4c/idhlnYA1Cga1FvqUGCFBznApsbDlIaw8uY/ifKfv+SC0n3+zKYzGjyZmPgpm67eoRTH+ZzmYdRUi2UwBzAHZFDFn136Ybf+waWoJ53XZ5Kznp84j4QQyP88=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e62b84-3ed7-4dd4-6c43-08d807ce5ace
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:56:54.3608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V3zPHQgKNwKrSaoFK/wE2Kqx0j4/9hcNAOvtOkEa04kiqC0oBbQvhPLyoA6bf3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4028
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
Cc: Deucher Alexander <Alexander.Deucher@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Pauline Li <pauline.li@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-02 10:07 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> The bounding box is still needed by Navi12, temporarily read it from gpu_info
> firmware. Should be droped when DAL no longer needs it.
> 
> Change-Id: Ifc330ec860f9b0665134a81df2fc80ca91c41a33
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 15de344438d2..1df28b7bf22e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1537,7 +1537,14 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  
>  	if (adev->discovery_bin) {
>  		amdgpu_discovery_get_gfx_info(adev);
> -		return 0;
> +
> +		/*
> +		 * FIXME: The bounding box is still needed by Navi12, so
> +		 * temporarily read it from gpu_info firmware. Should be droped

Spelling: "dropped"

> +		 * when DAL no longer needs it.
> +		 */
> +		if (adev->asic_type != CHIP_NAVI12)
> +			return 0;
>  	}
>  
>  	switch (adev->asic_type) {
> @@ -1627,6 +1634,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  			(const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
>  								le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>  
> +		/*
> +		 * Should be droped when DAL no longer needs it.

Add "FIXME" here as well.
Spelling: "dropped".

Regards,
Luben

> +		 */
> +		if (adev->asic_type == CHIP_NAVI12)
> +			goto parse_soc_bounding_box;
> +
>  		adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
>  		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
>  		adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
> @@ -1655,6 +1668,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  				le32_to_cpu(gpu_info_fw->num_packer_per_sc);
>  		}
>  
> +parse_soc_bounding_box:
>  		/*
>  		 * soc bounding box info is not integrated in disocovery table,
>  		 * we always need to parse it from gpu info firmware if needed.
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
