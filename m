Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C517C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 15:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0838820757
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HOTrdjE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0838820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DCD6ECCE;
	Tue,  3 Nov 2020 15:33:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A8C6ECCE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 15:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDCiIHDDyuutzyNrV8LsV9EuDpaNe/Z2fXSsrutBd3b+x7j4gdWAsC4PbipoAAWCPy83pTFQA2Bzm3pnvRO8uFvouPwBW8T2mUdZ7VmQEz0PuQGB2aoBtboUJhRyb1Xse3fx+kpnS1DYNV+z1IuEa5XkkzrYGCyebtu06lQsoYHmTPHCjxq8E0HYrahnayISwFBE+oF1E9UZwRtANoJdh/iiDUJARnGZle5W5tt3AD2oq4lcq7s6laa5J04E0TYqY4NoHLdVttuffs+NJNxY2HZUuorxDJJpPxJgpReOppgLKCg7jIGKRksmrhBs5ynCQsI0l5XmhiNQDBlNSJkAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qrwBJ4vmHuDrdf/uQgka5Ubi8fpwONVFBEMEooP3Mk=;
 b=OkuBfs/uh10QciHVCSqs12xsUA5IInDbehn7aF9mF9EOveWPpUWyo4lG9aBw/RJtEpd2UyCdX718RbflAkJDbSuWTtHiGmIzFMtoXlmJTcH/ygi8R/TmnZUfdzByfISQtSezC698U941OMIVzQudOBRxLrQ80HPX4iXAA31WF2Z0TPaP63UFzowxdQABA49F5EvHPaqRPbq0FkaNwDMDV2d2mL1WdSQidxTR4BSnWGlfL1Zi9Gonzw5MtpWobTclyRsTw6mq8SYgEYlvnlD/pyo3617NvlBBaMxHKNFQVwgg6iQi0Q3XqwGsIez4RsDI/Q9KnRG+I8CgHsuBfVfl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qrwBJ4vmHuDrdf/uQgka5Ubi8fpwONVFBEMEooP3Mk=;
 b=HOTrdjE5iZtDuAfM6zuaJeHfyuR5NEkoKt7UwK6C46strnbJQ1nqzXRMZ/Z0/7zGOfCBYX3x9k9BTZ5aAGnroPreGP2my5qRRktJIeceY+bSVu3EXfP8EO1Gp6dKnMPK0VBVYNOhTR76ysyuFYUNVskOFv2zpAQVVf3gOhChNCM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 15:33:19 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 15:33:19 +0000
Subject: Re: [PATCH] drm/amdgpu: Change the way to determine framebuffer type
To: Gang Ba <gaba@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201008171557.29071-1-gaba@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <405a609e-4d1e-4ad0-5998-c00a0acf138b@amd.com>
Date: Tue, 3 Nov 2020 10:33:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201008171557.29071-1-gaba@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::48) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 15:33:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0952820-f62b-4cc4-16d0-08d8800dca40
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41910A6C4B087AA0BCD916A992110@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAu4uS14hslUg/KutK7xhBu2IBGoCooIjtKAlUscVTmp+TI0HITZ/vDUIL2qsmFLR2Iia6t9nk+kT+lRU5g4OamYPbc7XB4uMAZCqUyC57DCaIl8yZN2LPlleF6jW/mXNZtJYC8eOr+nDFPha7IMpuBR5oYkK4juOSuov3Xho6pCpoh1MeKGyPnEEgFUwaROmFRXqlE4J5QwImp5hX/w5dApfRoEg9y0SdSd7StGZZsoEPFzYTVwwQglFSstz76GGauWolfJkStmFXyXEom9SPkUIQGw1+rzAt/1ifiEMXL9kY7cJXjgLcDYMA7PmV1MkzmMwA2RxpHeqEn1LFfvwkZ/UeCorS3nCwfsce82hUe4FaW0q5Y+BhPyX4fsYfBdoh71aRCiwiAe6hzK1f0XuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(36756003)(86362001)(44832011)(83380400001)(2616005)(52116002)(31696002)(26005)(956004)(186003)(6486002)(316002)(16526019)(478600001)(66476007)(8676002)(31686004)(66946007)(8936002)(16576012)(5660300002)(2906002)(66556008)(43043002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Fawz/wyl+0rnbGYkzki7NM2xYrm/9V767yKqAKLyiHHnDba5wWj6APJzCq76CG1plvr29b6ND+GYfrTMNQ16r/dRJTU0nfV7989+Cks5iqwLlZIxrpTv8hsyU6wWEjsa8mbpL0cIEIe3HXbg3i3co4ER7oOPyy0xo2RTfLwzUN/bGvfoXa1uRlWmvDXostfbUCQlS+WEB3feN1JZu2hK5E+nBgAZx6PCGsvppUjqIrjqiwzWA2AUxdwsW/qBlOEjZemuFUsmaEQHCvqb7DE1D4GlNXzDublT5owlj+0UG/YSPH1qvlWkoLl0zUml5dogqVbUJSNrcFp8EuJUNzfRRA5Z/f3S4k7un+iIKb8KoZaGXJpjIcDTutFzsYO/g0KTvvR/hNF/f1HjjGjEZJcuG4Pfb9jouRJWYR/EFkaI8X29iM0wNDwfmb0WFJV5PP1Pycfy3th9aHpnZAoiRWYY2VikSMVXNGmemGEg8Qmig2xNS10HNbCXtoZ5pra9/xDFSDLeyC7gR4UqFMTO1CMBKE5fRRBCYLptlqUETKX1/WRmMmAywwHh1AKQ1o01ZuWWSmfMgn4UQkkmTHMeODtq1axqSL4jo4fxohdpCcyUJRTIEIkEMSLH5nIFiPP0RMnkzFQEkTEjA+1/1cABsH3X4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0952820-f62b-4cc4-16d0-08d8800dca40
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 15:33:19.1880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAmYOgXCYTT6FMe2D2fJJa366nkGeCdzbXiQv5+uDGBkye/UZ/0ei4tcxswGol19Cn0v4N/i9JC//G2DgUzOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-10-08 um 1:15 p.m. schrieb Gang Ba:
> Determine FRAMEBUFFER_PUBLIC/PRIVATE only based host-accessibility,
> not peer-accesssibility
>
> Signed-off-by: Gang Ba <gaba@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 5aa7dbaf6e76..f066696338d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -390,23 +390,17 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
>  				      struct kfd_local_mem_info *mem_info)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	uint64_t address_mask = adev->dev->dma_mask ? ~*adev->dev->dma_mask :
> -					     ~((1ULL << 32) - 1);
> -	resource_size_t aper_limit = adev->gmc.aper_base + adev->gmc.aper_size;
>  
>  	memset(mem_info, 0, sizeof(*mem_info));
> -	if (!(adev->gmc.aper_base & address_mask || aper_limit & address_mask)) {
> -		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
> -		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
> -				adev->gmc.visible_vram_size;
> -	} else {
> -		mem_info->local_mem_size_public = 0;
> -		mem_info->local_mem_size_private = adev->gmc.real_vram_size;
> -	}
> +
> +	mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
> +	mem_info->local_mem_size_private = adev->gmc.real_vram_size -
> +						adev->gmc.visible_vram_size;
> +
>  	mem_info->vram_width = adev->gmc.vram_width;
>  
> -	pr_debug("Address base: %pap limit %pap public 0x%llx private 0x%llx\n",
> -			&adev->gmc.aper_base, &aper_limit,
> +	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
> +			&adev->gmc.aper_base,
>  			mem_info->local_mem_size_public,
>  			mem_info->local_mem_size_private);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
