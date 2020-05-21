Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B37C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 04:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5787120678
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 04:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yvOzoAdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5787120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C53C6E0BA;
	Thu, 21 May 2020 04:11:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06A16E0BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 04:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AorlbbYZpa2cCNs0T9Yn1SLnaUvl2JewqGYOt9tEd4w3ncl9QaS5iLjr3YliIYroweKLjsmjV5PhbsI3dctxR3EGeFO/z4GMq8VmnCyrWVef5SbDFdNQfZlUtEaJDJvIrpC+mengsXjIYWqbPDG2rYTVh9N8iY+o/3f0qzUg9/I+JP9LPhqGHb4H1vqYxQTAi47M7WeXsJjq116XX61/TZqr4RCzrpIDdSQK5ojQ7T2IGi//RFLkx0r0tfDEK4Yhh6+mgCXDUObaJVWfJGHGofC26ubKBaElVG0DXCflLkt/ziWvaCnhZPdz1ZrXO6Q+A0cgSDAqMvjtK/8VkcZBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xti5VoIyGqKOfcbFNLDJrNQkkbqVuqJYk7LeDBLio/g=;
 b=HIwHJ0aIs6tcha6UsdpHpg0bBz55hi5ELEt0fEMwksHzYgtPGYAMxWqvoDdwLrJQZMP5KLZCEQfObWdIphGlqQqzoS5PPONx5WgeENZMzY0sAkgqSM8rr2rpkNVUxNAdQb/GMOCaOZi9e2Wh3yLplfh5HM4i3qkEOxorXqqfoiPsdf10NbF94apcjMeEJdEzw+gytKA4rP5768UKb9CrFAGvLpTZqUVffdQIsVy5sU4MyM1JqLCogmvfC5JRWjf3K1cA6xfmPTIyn/WwOZamY1aMIDQfXwG38+EQcKLv0vqHfRUMrA1BnmR60ubsDqwWcjH2PT0ykYCkAkuda7TF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xti5VoIyGqKOfcbFNLDJrNQkkbqVuqJYk7LeDBLio/g=;
 b=yvOzoAdB+VNHXQvB9/WUnEgvjOebPww1fdcvlX/bqANIqi2kHmzgStiaaF+OSXZNcB1GBhOtxO4BDTvME5lXERvN4trFcd9cFUwjOycKwVeaL8/qZy/LyfUYXDhKRX1xmLBF1QTOoToVkJLTIui9lZEpOgwl3wmO7eSbiJQzReY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Thu, 21 May
 2020 04:11:53 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 04:11:53 +0000
Subject: Re: [PATCH] drm/amdkfd: report the real PCI bus number
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200521033414.15111-1-evan.quan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a9af867e-4345-ab80-7524-e72456107bcd@amd.com>
Date: Thu, 21 May 2020 00:11:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200521033414.15111-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 04:11:53 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae57c8ff-55b9-4de6-7cf5-08d7fd3d17ed
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25121E6CC4CB50CCB4480AD992B70@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49PUwx29juSs/YlRINYXRm6z9N2oZRUsKY3CqKKfSSm8JaCY53m2orEVZqQun4ZPcmrvYEBzCKuu7jpwGmSw+etwjXNDBdUAlp3/bWT9xD/TTdMh5Pd/6eafnktYKqZBLooEFQDISIm2tdnv4kI1CaRbO4hukqOfagU2eoiEbW7hn2bBHX2WY5JQIp9TH1JWCTID8bO254RVF/HeRBoZ9AqKJixEZZP5037S3zbtCTN2Ll4PxTPKe9S86YGeyNYvvgKPy7my7Wu/WoI+t1KRmvbjClBM9TqIDC4FyoKZaerORoW49kzas9pEiadW60mjlH6J8HI2KgPk5RQUrKDq82vjUGW+VeTZpSNSKIGku9RFe+joeJOvKrk8HtvSLfOXDZaUPSYJ9tcKMrmL7eOWJ8h9AMkEFvKU9pVJhiDkIQ3j1Vsm+VO6HY5+s0xZKMauYtTdbx9PivWoNeCm+xdbbWk50G28HsaBv8MpfZYDI4bo9c1aJtrU2CDwGcZNaOL5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(86362001)(316002)(16576012)(31686004)(186003)(478600001)(52116002)(36756003)(26005)(2906002)(16526019)(5660300002)(2616005)(6486002)(956004)(4744005)(8676002)(44832011)(31696002)(66556008)(66946007)(8936002)(4326008)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CHkofo36RdfFbwSv0JSJTND4jEGDwITX7aCoNnxu92EvvHHd96iXV52z13VCkaVji9HXdEGESaQyRmD//d7QSE0zHId8sVU8ugVcnbh8ae0/yiX5UMbu31ehnQirwVEd8MumsdsN48kVcr2uRcBFXviJLExVHOUlLdGBZKG7LX3wF/POTTNdV1oPGTyktpxTQu0ehBO0YTONGYfxHGXBnoZ7CCjGtQJcBrCRGgBZqNeDp888kc8Q0j36Byo1G/JicBPGhC01ntHQgpVvclZ4l7aymGPoOI+4GgAUnMTGmnXip6IZy99Ez9HIAns583jvoqMSj1f5ztw6grOooi2cuObktLR5yazTEOu2e3u/1RsyjatSdlePvh8FY1/OScvVVc78UZIp00o4wkyE6ZNm1VChv6doEYYKDdifiaygbb+vgy6IfN7/gTmP5Jzcjy2RPr0SIU5XrVhem8f4pob94MJkYULm0e6pZ/OKrSNEutULUex+ypHuHeYN9prsmrVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae57c8ff-55b9-4de6-7cf5-08d7fd3d17ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 04:11:53.4255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46PcyoHZ3Ee8Rh49Y+Gm9HNDxsmJDYLn38WMEB9/x4AVixC4n2ivAUP1hEiqyoUSvNcGFNZ5S/7uxaamSb46oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-05-20 um 11:34 p.m. schrieb Evan Quan:
> Since the PCI bus number retrieved by PCI_BUS_NUM(pdev->devfn)
> is wrong.
>
> Change-Id: I882a8531a65cdf91be20e34a034aca1f43f658b4
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 8d871514671e..7c8786b9eb0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -192,7 +192,7 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
>  
>  	dev_warn_ratelimited(kfd_device,
>  			"Invalid PPR device %x:%x.%x pasid 0x%x address 0x%lX flags 0x%X",
> -			PCI_BUS_NUM(pdev->devfn),
> +			pdev->bus->number,
>  			PCI_SLOT(pdev->devfn),
>  			PCI_FUNC(pdev->devfn),
>  			pasid,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
