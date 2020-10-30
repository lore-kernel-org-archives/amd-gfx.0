Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE936C00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 17:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9052075E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WcZxlFy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9052075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6C96E9E0;
	Fri, 30 Oct 2020 17:14:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDBD6E9E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 17:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzds9BaN2y1WN1EGlMSkS0v7mlUaADV+5yUJhOt0iHQkOXYi2XshWjVxn1fRaeiVIozX6mfxBkY0C7qOfG3rBCKsN1k5UfOAwTH4ul27pCVf+mvuaa+PCccgADeyiR0JRjIGkXq8TBQfGycF2rzjFITh0NCLoT8N7s1gUmOz/NTI0ZLCeKhvujYSi0viEf9rMJYpki8H3Djb1ReG3Z5odWJ5aXeRTuI10vZGQkvlD966S0pt6r4svUUvxjy49QqgQVvr+1UDq2CgM41akenYrOIH9wRdAoaeUIyzZAIn+Pm3lRzFkKdzt2/LehKtxFgU3vS0zviMu9puTloKBgPBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQwNgf9Vw7NJd/wR05tRULXidFqzXiep8U/EwebszK4=;
 b=FV5G/Uuv5zCCE76OuAQ5niehgW4utZY/MdQ5iow0UqQ54rXWu/HWnDyXVXSl2mqyda6E2PYL05sO7IlOAtZLBWm84vl8oZWvkl4/Z7HJ+sC3LS4ll7kdMFKbDP2dVKGiklFdm/46IV6KFQNtSjQ3Iydv5DK+E+JyF+75GksUaNM1hDaEiQmySH4TfHbhQ03npmZd7bAL4i4kx9Ah9wOHbpy9EtJbDVRm9i2vh9HmpcDuc8yeV+vHmYoDprX7qiug+v4KfEqfdzLXVNlNkBpzVqOsKZLVrZAXJMBTWwDXwSSvLIosNEOUtQ2OseSV7Ud77GkkNCQsiWT8p/TU8TQx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQwNgf9Vw7NJd/wR05tRULXidFqzXiep8U/EwebszK4=;
 b=WcZxlFy4q1DV+ZpwgkNfCgtwdqBr6qBaAU//KjzJuHZS3qWhb1JZ/gD29w+VTHnyXgKplHKs08cLDVn748Cg7ZySDzcV3b3iPeThhMynUQkeLf0wgs2zLHoIzvBa4S+g/KG/jsgyMSWZ+r8+i7/xFxQf+W6tFx7DoaGRx+Jg5bE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 30 Oct
 2020 17:14:02 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::80dc:cc94:5241:e454]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::80dc:cc94:5241:e454%6]) with mapi id 15.20.3455.040; Fri, 30 Oct 2020
 17:14:02 +0000
Subject: Re: [PATCH] amd/amdgpu: Disable VCN DPG mode for Picasso
To: veerabadhran.gopalakrishnan@amd.com, amd-gfx@lists.freedesktop.org
References: <20201030171003.458965-1-veerabadhran.gopalakrishnan@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <b897332b-53b6-c03b-1ab4-82f0a9d9e5d5@amd.com>
Date: Fri, 30 Oct 2020 13:14:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201030171003.458965-1-veerabadhran.gopalakrishnan@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:a3c0:342c:712b:83c3:d1b6:9fe9]
X-ClientProxiedBy: BN4PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:403:2::31) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a3c0:342c:712b:83c3:d1b6:9fe9]
 (2607:fea8:a3c0:342c:712b:83c3:d1b6:9fe9) by
 BN4PR12CA0021.namprd12.prod.outlook.com (2603:10b6:403:2::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 17:14:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1800e883-c75f-4d35-30aa-08d87cf73292
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2841B4CDC8736B4858EA5A81E5150@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7hC2zW08Wwgv8m07L+s0ZnNS48jy50gnTlbuce9YNVlubWvM7mBfs3RR9HUPZC6YvjR6ZSF0A9LDwTRtdYrH9vXmnUiFomHIqJVG+p9CRnkColPjK0grg7KRVHl6RSf2+Sgen6T9A2FP4qDSInyA4O32wlAfhFCehUMy1wBC06Ab/iN459FIqjLjEUYdN2nJ+hK0mBWurPZ8lnXy74sb6HUFPtJd5qe/Nk7+pYsX7f99a31SQdpEmkc6zjxxxL6Bsd7NXg4jFLkUNDkXNOSoSIvZy+cf33bsm82Aanj050mnmR0wDTP1dK3EJN2ldgvzknchT89uxYzpXk0C7nMX226aN+l2YnE4P1ZuUPPuFcR7dPXe8KQhC4k2eyvuXQp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(31696002)(5660300002)(316002)(2616005)(8676002)(186003)(16526019)(36756003)(6486002)(44832011)(66946007)(66476007)(66556008)(478600001)(53546011)(52116002)(31686004)(4744005)(4326008)(4001150100001)(2906002)(83380400001)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uyERhoBpsQsusKXdZLpYsHWNAYt4dODaN6OwpAoj4lCqsNJ2842qD6MijqPzYwp7JJan5yF6G9iEuXRhwkxBIkAQc0YftJPLnyCpNnJYd2J0ml/R5gRyXXAW5vp10gaPD8sF7grj1P89/H+RhdfDqB3+7DGmeviPIyMzKotkMh5syK8gxQ9LpqpTTEnXq6XQCMbi+KPVllKqKQ0mkgjopk8Md88mg+ma0lUPWkRm1VKfbEuK5i0JNTniWFPZtzwSEtX+qfO7mLbO0frK1Ux22l08L8LLzH+PSjgyBRYvA/Kmv2jG0GTDRh2p+oYamXS4XWAzt4BCL3TmSGy+LOKevfTIKVnI3ZdlMmeMZE4gpQyXawUGlqZEWKKLIaXkzaIR9SGgZEw0byW0XferSzZnyPztbFW9fOaYYlZnQHZg8HlFNFzbqwK7jaOCucgo/cMG7FhnQIWzsEwDrh3uDYBeeY+WmEFBXBiXMQnHJ3wA/GJJlv9bdwp7RXpXoCoC8dGXxO7xCHht12c2VOirNTRgWchtggl2oGfm3oK1HwXmcqbRRMQnYeFnPCMcSZaX/PAVHTNmzmYrsbybGedL6bJRqq75/MLte6dVLMIownIWbYJyPtd+iN9UG66Rmyas70C7F9mSYRvnIZqHRyuXXcMWT5GBEPG2CISzFENY8QDP8oSOYHab//iii4acYSjwer2ij4t9UbzW9WZtm9HvmWyPzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800e883-c75f-4d35-30aa-08d87cf73292
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 17:14:02.1682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/Zu6R9UOJ4m0FT3voknXKYIAsg0LtouhC38xC4YpAWdhcRYOBWKPoS+YOqM8feL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-10-30 1:10 p.m., veerabadhran.gopalakrishnan@amd.com wrote:
> From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
>
> Concurrent operation of VCN and JPEG decoder in DPG mode is
> causing ring timeout due to power state.
>
> Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index ed7342bbf801..f57c5f57efa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1195,8 +1195,7 @@ static int soc15_common_early_init(void *handle)
>   
>   			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
>   				AMD_PG_SUPPORT_MMHUB |
> -				AMD_PG_SUPPORT_VCN |
> -				AMD_PG_SUPPORT_VCN_DPG;
> +				AMD_PG_SUPPORT_VCN;
>   		} else {
>   			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   				AMD_CG_SUPPORT_GFX_MGLS |
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
