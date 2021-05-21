Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F07C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3137F6101B
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3137F6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEA46E4F3;
	Fri, 21 May 2021 12:58:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB3A6E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTISXRVoYnrXYPC0ZWRsEH0OuSKLbxdsBXpsDPOWGUgLMa51Zhj+Wea6K9x4STAq0bfhqFkvCLWbD1iBBXg+vQC3cdVx/DKBsokSyuH03NSsGWZScfdon7b2O3DcTxlX9969nm2aNts0OAdok2JtCLtAysQMPgQRk4nXeHR2F5JzjJqr/jKNk507hk4QTdASdKPj9jJNaY2MX8T6JSMYTRQXR6Q0ezGP6vv21oB7KG16Vsb/osWtWzLz0K5JBajZv9ZvVFb7Sn2LFSQ07JsKiVfosFBkBpcY+hoj17Qu2AwIC3lMSjGUPbqP/sn/0ZjtzkJVYj4DV0u4nqqnpD0VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCTt6UmjXBXqJv7mBMHnfVpaeKad20OmoldC3553CWs=;
 b=CyJ2DodHbxT6MDYOxDF/cywvucvC3hE4Frczi1AWDb3A5sKbw+QGRQBZUG2+VlLFtDL3igDwtFm9FEa16h0VC4FqrquHlYjXRKK4SJG655NMzDt9aVDmUZLc8nXkA6cTUlka5bOb/AHRJxr08VyU9HPqC3iFEPE5d/WbQWteRddoHaWYdcx0GqG9Y7vxx1MSmpPYHFpObvPWlVRelOtkSoKjuH3GC4ei9nlN/YLKlKHoYiQb9Um5/mLJrYsgNx/+hJu1NMmy83DC3yCu+qYrWLXhJezBBAR+fVRirUkOxQV2zg9G5UaAS1l6BTTcM6sglfcJG1A7GcxbK9IekgHXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCTt6UmjXBXqJv7mBMHnfVpaeKad20OmoldC3553CWs=;
 b=KjaBXL6+kRBiXeHfbQ8+TdOanzzu5vM+oOYHegWk24mmnGwiiouHnkQvQ+czgSdbCKP2auDY7PvRHMAHnldh0uceky2XB1ovKVSu8h1VrkMQgqjnO2djTYYVvIDu2ylReRN9tBfVHWOF6FnR7ZQi52tKLFoKAvdAGbTxpZUmInc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 12:58:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:58:35 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: add a new identifier for amdgpu_bo
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521124533.4380-1-nirmoy.das@amd.com>
 <20210521124533.4380-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <38fd15b4-aacc-9be6-deaf-9fcd61d59477@amd.com>
Date: Fri, 21 May 2021 14:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210521124533.4380-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d]
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d]
 (2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d) by
 FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.12 via Frontend Transport; Fri, 21 May 2021 12:58:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18eb7de-9e42-441a-25ba-08d91c582495
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB415916BB9E2A1AC045D6659883299@MN2PR12MB4159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DX8WkI4HZHjJiANkOEtN0BVsq8+VF5Y0pJYMlu/CsNd6homh3mpAsYDQ7zhC8jGrC/WU4R8SB4iC6MnQOBN7Fc7tQcUeSmpF+JTCCnY7ntBTwItHIMatE+fdJucJCVD5ybSAEWB7sZjAKKRXjO+MSZ0Eu2i54+CKDvZrS8nJ/uHXvZQbnDZJJXZipMpejCX4hJMOaBwZDVxL0vA2FY7pG22DxHQMEHG4B0z4/iMv/KtuF86m4cKnhRDJwPEaEPegt/G1evSX5BSUvIGrKl3zsMqJ4zP5d1FlvhtWeIHZN9CyIFFxKwekm1D7cVn93ohzKp5MiebqXnbXjVvOINye8CjAXo0+i2excsJBbXM1IUI1ylcAr0setCHpnPCGVDJTiV7xGSjg7qSUo1o1lBl1kQ/U8djKGcKY7j9YGr1M814sqalmNCAOI0FxfvTGTHm4/RL9i5SqsjNKREY5Uwb9lMA2tBQ8I/iPyky/Sxw606s9/qf6u6/KXSHs0BSr9qn9XHGaAq7fjz8J+Vy3NrAVf4BzWK2+PRILkPUnuIOlV9CVTuxOWe1FKNrVDJxUFtSV61t22HQnHtZbut21UHk3SAhJrLWOKTC6BvFtikRutUXlw5+nOV740LzKa1zB2QcvsK5GuD0dn5B6/yfTU9zByiMgk4EwphlQ3FO60lNCE7G8U1ASj/Eps2J1BOlRlDL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(4326008)(31686004)(186003)(16526019)(66946007)(2616005)(83380400001)(316002)(66476007)(66556008)(52116002)(86362001)(38100700002)(36756003)(6486002)(31696002)(6666004)(2906002)(478600001)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0tKK3laUWYxRTQ4cVpROFdRM0ZPMDBCYUNWblpQQkpPQjNMaTk2eExhZnF2?=
 =?utf-8?B?eUhWNmZDYzJleGwvam8rR1RJeTFGQkdDd0V4K3IxZFJMcW9OdVNkQU1Kamxl?=
 =?utf-8?B?clp2aDJrRm1EcnVyTCthV3FZVXF3bGtJdzBvSi84d09mQkxzdTZIMkJuMXhw?=
 =?utf-8?B?SHI4UEs2TGs1RldvWjdoUlZRNzhkcEFpNEJyZjVFODViZmJMTFpRYVJNYmhs?=
 =?utf-8?B?KzR4TURnYzB6WEFaNFQzQU1xNi84YzVzT0xXMEUxVEd6bWR3NjE1Y0lsb0Uz?=
 =?utf-8?B?OWhvc2ZyUmhwNWxDWFI5RHVpRkFyZVMzUDJqOXhkZVJoLzdQY21sa1dNaWsr?=
 =?utf-8?B?dkhtcVRYZXhDVzJOaGduc3RJUkFlWW1nNWZZUkkwWDJHNkM1enBJVCtwOEFK?=
 =?utf-8?B?Mkl6OVlZcG9vWWtDSGQ1eUtvS1dkS3JHcEtDdkZqd0E4QXYyUzV6QzBDbEJs?=
 =?utf-8?B?aE5MT1BaTHBhQm9ZR2l1empCbm9keVNTQ1phSS9LZVpZZUFETjYxbklrbnhz?=
 =?utf-8?B?Tmt5aWVmS2VhTXRlWC9mZ3hpRkkzbDBYV2xUV0JPb3lWZWw0eUNhNDRLWEgy?=
 =?utf-8?B?MkVRMHBYQXZ1U0I4TDFNNUZqTUt3MkNZT1dpZjZYNzR2OGdBS016RSt1dVVu?=
 =?utf-8?B?RTAzRGlyME92TlFuNVQrSHcreVdoUk9xaDZ0eWZUWE1TUEZzeTE5eVhVMDhm?=
 =?utf-8?B?QmlzNnNmTi9Qb1RSL3BNQyt6b3dhNVBUL2s3bzFCTTBjQkhyS2pKb1hhdmFt?=
 =?utf-8?B?YVN0amlISVlYeFdRSW9Ibm9nQmo5ZjNiQ3dhWml3KzJZMll4aGhwb0Q3MnJH?=
 =?utf-8?B?QjhYYi9oK2FwQTNGYjVZenJZZ1dVOU45SlRBcFREcWExLzhScngrMFdRV2Vo?=
 =?utf-8?B?TkhnaEMrb0NwQWxJK3BYc080K2MzYTg2UmRsbS9lUUJWTXhpTG9YbE5Rb3Bu?=
 =?utf-8?B?TmNHSkFhTmpJMTExQVJsM2FGSnhXVk04aldka2wzTTRNd3RvTGc1ZHRGb1Bv?=
 =?utf-8?B?dGJPRitNN3hDY1VzSlcySEY3N05wSUdUbUpvdG9MdFJVUDlTbmdUS3VOL3Bs?=
 =?utf-8?B?WXBsUHF1Y1cySkZNMEJFWFl5bjRjTWMzMkcza2Y1amlYWDk1ZDhzSGY3TUo3?=
 =?utf-8?B?RTk4dUVqaGVQTWlsZlhCaGtBZFRtS3ZYVnZqdzJqTUhLVmpzL1diaWlYOFd1?=
 =?utf-8?B?dmdrWWV1MVV5QkZiQnBIdnZIR0FKZ05BMlhjcVZVTjcxNmg3b3Z0NmlHNWdq?=
 =?utf-8?B?bG5hZmlSUzZzOHlwVFpXaFRQSCszZ3kwbXdDMzNvS0FYV3lSanovMXk5V1pp?=
 =?utf-8?B?c3Bvb1g2UHY4MUUzM3JDMTJNMFh3RFJRcW5ZbEJyNTZRUkR1TGRxTTI1ZjdR?=
 =?utf-8?B?NVpTS0dQTzN6MlAzMlZoRi9kaS9aemVtOHBiVXUxVStKSGFWRmZtREdMbTBQ?=
 =?utf-8?B?VWZBMHZ2Z2g2OUYrNkJLY1E2VFkvemhkZ2o5ZlJPMGhEajRhTkkvTzBRVlJJ?=
 =?utf-8?B?cHpZS2JBc1crcGNCREpNSGg2YXM2aWZqZ2Nob2JQdUVoQ2hNWGRQQVBLMDFM?=
 =?utf-8?B?bVBvQURiajlBRWdjWHhKd0xnRzB6RWZlRC9TMXFqbkI2LzQ5VlhMdGhIeUI3?=
 =?utf-8?B?MVpZM1dVS1duaXVGVnUzZ0RiR0VOWjFzSmx6ODd3V0JUVUFCNkFTd21NdlFs?=
 =?utf-8?B?MFlvUVlTOHVYSENzOWtXcTllSm41eSt1aEFMWm9lSG5lbXgxM3JUOVhxMC9l?=
 =?utf-8?B?MG5XS1RVS1RlNEthRHNPb1lma0dzU3lIR0t3Y0FiNWpwWE9vbnJJRCt2OEpQ?=
 =?utf-8?B?Z2NiaTJCTmd6T1hBUEdicy9VRkF0WFowL2I4NVM3VGx5Q3orM1dlNFN2akpW?=
 =?utf-8?Q?CfqYdQuuDSGrk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18eb7de-9e42-441a-25ba-08d91c582495
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:58:35.1197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZNulDrQE5uwj3JNks4HD9bg5S+FX4inVhkKYTujG84w6e+wfoeTcGl3nA9ASsNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.05.21 um 14:45 schrieb Nirmoy Das:
> Add has_shadow to identify if a BO is shadowed.

Ok that is not going into the right direction.

Instead of identifying which BOs have a shadow we need to identify if 
this is a VM BO or not.

I think the first think you need to do is to move the shadow handling 
from amdgpu_cs_validate() into amdgpu_vm_validate_pt_bos().

And then do it only for ttm_bo_type_kernel BOs, cause those are the 
PD/PT BOs.

Regards,
Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 5 ++---
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 61b1edcb490a..eb3ce33cbfff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -619,6 +619,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	}
>   	if (!bp->resv)
>   		amdgpu_bo_unreserve(bo);
> +	bo->has_shadow = false;
>   	*bo_ptr = bo;
>   
>   	trace_amdgpu_bo_create(bo);
> @@ -657,6 +658,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>   	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
>   	if (!r) {
>   		bo->shadow->parent = amdgpu_bo_ref(bo);
> +		bo->has_shadow = true;
>   		mutex_lock(&adev->shadow_list_lock);
>   		list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list);
>   		mutex_unlock(&adev->shadow_list_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index a7fbf5f7051e..3a0e6ca88563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -104,9 +104,8 @@ struct amdgpu_bo {
>   	struct amdgpu_vm_bo_base	*vm_bo;
>   	/* Constant after initialization */
>   	struct amdgpu_bo		*parent;
> -	struct amdgpu_bo		*shadow;
> -
> -
> +	struct amdgpu_bo                *shadow;
> +	bool				has_shadow;
>   
>   #ifdef CONFIG_MMU_NOTIFIER
>   	struct mmu_interval_notifier	notifier;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
