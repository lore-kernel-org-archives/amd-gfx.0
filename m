Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B770C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 22:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3773F601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 22:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3773F601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE99D6E9EC;
	Tue, 27 Apr 2021 22:17:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE296E9EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 22:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzi683LUT7Z5MXdqTrUTGcjZDOzLpSqVZoU1mKj133kZCezkKTeNNnB9bpa5mSWVv0GXqG1cKS0sHd5eMiWQvO1qK/D1m9PgXA3jPhsqHDZkgj2M6a/xAu8T4yMnqbKiKcofYBg8dqkYxmbPeAFdo71L5vFOfmXon4JD9APIBnOLT5G6YNjykUTvvbPpGsxe3txR5cwSnFrkcKmpGVYcA0u0uBcqKfYICVHZC+pTtf+QDOh/MF4z0T5kUOZ0/1BNGbtCQI8hFWuOjyL9D4KhbSIf0I8S/gNtnTf9GYAVnntZWHHRwhdKE3Ar1NBLumgdt6JfUX+BipvOkg/dEsXHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGLEY/KihGjlGbhgR3fP3gSOidCsZTVmRVTWTJw9s+4=;
 b=VhnEqNyRO3ayqGm+14NWCnASJXww1TmgjA21Xd6dEIsuFzFOwwx66WKNLSoAq26UYm1HXdeNJP+3V1R8jFFJ3L57NVQtOhZkbYwuul+JjDDMaS83RpPdTFXSEgvlTUKGXJLPHVT2kKAFtWwapUs19xtsz61PEBEaxKkUsBFLpp0rjZviI62szjGd7y4nFnW9rgZgSelun6ie8LRNNSWnip3w5grl7/i5vazsZjdGgkj0q7AgxlowejuJdyfsEvhMrfxQH6PuNwd2LJvLPCQAI1fY9CP/eINZJjxLWt0ATlZ50+HgJ3TfXYkVUkKNjZNW1dahpiTqmSiHSDchR/844Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGLEY/KihGjlGbhgR3fP3gSOidCsZTVmRVTWTJw9s+4=;
 b=UupZcLBWyJ7RCLeSeN3JzFySsGn+mprCpyAkRQRxTDh8806x9gYpf1rQHq4UPOIYDfFqnHV9viutQurTPctlACqgQSr962EVPIxggbEu9FAx5upQP9nICJmhDD7tUJ9D8AjiS7abp9jWX315ECqt6uF6B4mTvr7apoKRSJU7ibw=
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 22:17:49 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::f9a9:4adc:42d0:fda1]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::f9a9:4adc:42d0:fda1%7]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 22:17:49 +0000
From: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Add Aldebaran gws support
Thread-Topic: [PATCH] drm/amdkfd: Add Aldebaran gws support
Thread-Index: AQHXO599S2YNjlNB+k+QZO4qrof8OKrI7EoA
Date: Tue, 27 Apr 2021 22:17:49 +0000
Message-ID: <SN1PR12MB23824BFFAD356C491C63F430F9419@SN1PR12MB2382.namprd12.prod.outlook.com>
References: <20210427195647.2212603-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20210427195647.2212603-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2603:8081:7640:b7:fd5f:9842:d346:ac2f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: add62d98-c935-41cd-58c6-08d909ca4b06
x-ms-traffictypediagnostic: SN6PR12MB4704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB4704C91E6511747168095AF9F9419@SN6PR12MB4704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9GnW6fTxoRAcQ1B3+uTP4OXzzDQ5pncOFkPO/s2IdM6jE4Jji62B7uG5K5ZvCmDtRlMiUG1WGNzbRlEgbJWgHK1O9/YdVOWBwk8zO+l3gJXX1gPRWbrUS2WCGWn5fxwZkKxToZzGkdIgMZ93+QKsBrTtRtJOSJ/ZPWpLRAY4207K+Vy55pKVAgiKqhYNbsbsw9paTpdc/PS0BP8AZpzDl3CCuBMQhiRYOrPBa6SEy7YHadEHliRwZlSAaaADr+CFm3VfVJZ9KxlSXcuqBD1kV6LSuvSFfHsD4DUOGX7UVML4yA6yWE7QMsGYBVc9qqdorS6ZAGLNk2cHtuOnryLUi5S4ZITmjs/T6TAV3iFBtknNRFCkkcmj3dzIJPX1weHbpUVEkmmWxUYTjJcouHVwGJ+eiMu9bE8OM8QATQq9M02XbpP7tIB5/TeakkjETvnFqJfCd+x41ntY2WDIyjM0GKkwYXQMOUJfMuWTK57emJa/3fWrpeZqthI36S7NItua+ihVp7/QbTDxDBn9Mb8MVMBdipkALBLL2Putq3D/wmog08pe0wJsJ7i6en+iZeNvYn0tnU0ckn36WapS+N8tAk3QB6BBuxNHw1OjqJiWOI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39850400004)(136003)(52536014)(86362001)(76116006)(64756008)(186003)(66476007)(2906002)(7696005)(66556008)(478600001)(53546011)(6506007)(122000001)(5660300002)(316002)(83380400001)(33656002)(66446008)(38100700002)(9686003)(8936002)(66946007)(110136005)(8676002)(55016002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v0358FxAnX5mEhlqrPi/m10XDoK9QRxbDOEbB3rlSu5Bgvkb8CSFcZTbC4Ro?=
 =?us-ascii?Q?1NDX1Zu2y3MawUqqytAHsibz4krD+gAOZUssoDtGf6L/DfF9j/M0X8A5gq5A?=
 =?us-ascii?Q?3V0mgRKhbZ8v6HpTO44HwG+a4o0f003IOkt7cbOMOHU4ORzRm7vklu8noAX4?=
 =?us-ascii?Q?cdoVxpnICvdmKV9r6KLsSUpONZDcx4MMKtAA2Vzp8oJgeZVvfafH7HJI6m8w?=
 =?us-ascii?Q?zYnpFW2ar1cH75t4kXq/DBcR/Lk6CbGAqOJoGK7ElzAQLGtjaCfbnaqn2SMu?=
 =?us-ascii?Q?hJEUhYvwhpcF2k7haIhr/2tkBpJIDxMV9ZlX9jb4R1223/Cw6ZWFZaLzNJ5i?=
 =?us-ascii?Q?DISaETjMWFhP8WgOvRxxqVZH4ZZ8X7isSzmhje1eX9ACyMfaR+raSaR6PaRE?=
 =?us-ascii?Q?RIxwO71JBYokVZXQ+bcxebIqCHAVDqLrHT58lN7RHAMam6zOGJqBw7HaSddg?=
 =?us-ascii?Q?eYNExbrdTLa51Lw12dNVXtuCqc5eWS1i0IXBpRz3cvhfE9TGinsmvZ3rVCD+?=
 =?us-ascii?Q?Y4lfhCSTVSWOZjDij0b6gMmQ4t30A6t+Hz1TDvHXZhq1HWM8zd1ZQvoxWnQn?=
 =?us-ascii?Q?dr6/QA5GNurAXa/fnJBgXuMMMiVT5ry2e2hHZHo4s4XrIG4ISdVVKXPvbqhS?=
 =?us-ascii?Q?TjfJYRx6/pFc79W1qgIINB8v+nI5wZKqwuOnQoFGWaTTlxAAp9G+iol4dd+b?=
 =?us-ascii?Q?Xv833Pwq8lEE/LoW6cy7A1d/kW8pE36NV3AebS3fHKdMpLSWlId/pYG0AGec?=
 =?us-ascii?Q?BTXFKbWLy74rc27gKnAnbZoG/0VX2xVMXlWhDSATzEUfqfI6bD9pLSjKTfnT?=
 =?us-ascii?Q?S6K6mudNky1cuOh6g//0e1dNv3cYvlmlm64z823r+R6b1bvNSW1Ic/Tqs06R?=
 =?us-ascii?Q?8J5y+HTM+norVOQgfSg3SYzHYoXk83gvz9Aflep0I0dYsGxpaoAcxsmGGxVX?=
 =?us-ascii?Q?kSSqYdYvnKkMfzmZYYtzrKXZfDYiVtc+AVHRgX/BMcpMAsio15WaaciA3VGx?=
 =?us-ascii?Q?3XyihNrEMH89cE5zZ/4Am3tH53Y72UutWrx1TscMbtSniY/k00rCWyWxrtOl?=
 =?us-ascii?Q?LwwYoTMB1qvmY1ujlRTW/UgsOyLY433ZVaxfq9gaCxHHOPnuwbG/wAUIOIcC?=
 =?us-ascii?Q?znFv/mcdV8/j54WH2PzKHsCfXpJM0cy4ZFSd6DXESc8Ab28Jn/fG4InbMMfJ?=
 =?us-ascii?Q?UyByPFn9M1pRv/6TmD38PFdX6aQi+9rIIr3t6ePXuf9xDQlEnU7j+lJV77rK?=
 =?us-ascii?Q?kYKipQsB2w8rnpfdNtBwqW76DTfvl3Ybz664TrZjFje3RJdCyiWp2Psc9KN7?=
 =?us-ascii?Q?ai9488ZJ8FGmUKhrYJ1hTo0ahuTy+808C3LqO7S1SMbxO0/SfvWNEAE07LIG?=
 =?us-ascii?Q?QwLPEnI95V3XQg8xY5vqq+SOQh1J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add62d98-c935-41cd-58c6-08d909ca4b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 22:17:49.6006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9pzcEnM7EG7m0Cq1omvhHAn0uFDyXJ6Xg9XuRfUr1M9sGqF+xjNC+reKQfTpBcelApZ6IEHw/EkWsQ7dOUG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, April 27, 2021 2:57 PM
> To: amd-gfx@lists.freedesktop.org; Greathouse, Joseph <Joseph.Greathouse@amd.com>
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdkfd: Add Aldebaran gws support
> 
> v2: updated MEC FW version after validating gws with debugger
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 348fd3e49017..ae3cabb47a26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -699,7 +699,9 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  			&& kfd->device_info->asic_family <= CHIP_RAVEN
>  			&& kfd->mec2_fw_version >= 0x1b3)
>  		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> -			&& kfd->mec2_fw_version >= 0x30))
> +			&& kfd->mec2_fw_version >= 0x30)
> +		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
> +			&& kfd->mec2_fw_version >= 0x28))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
>  				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
> 
> --
> 2.25.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
