Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7FC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 14:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39556192C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 14:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39556192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BC16E426;
	Mon, 29 Mar 2021 14:40:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6736E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 14:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH2owJV960Ka3Xeieyhe0D+X5mez8+TX7dLX545V4bQ6rE5GFkZoSISlXkR9DctD+LM1rZNpWVdogZhU4CYh+hdq0kbBhETbEAmWYkyUuKKJhyeA3jjdCxA9KP5nrbdm4Rcoz4i4jPPR1afbg/Gz7QoVsIePxlSP9X4gVw51T+HxnuK4TbYJHwPQbwYhMR6ga+M49ZdiDJdY4NDcQGX9VjddFJhfbiRszaKmqlnIohyL+sC3x4VutoLGJQNAjq/BeatA40P9PZLy+z58IP6QZZBVHbmQgiHN/EJFKjKf9qbHw5rpE76IxEftvG9A5m7b1wzQL8a2CyX17g6mvjK9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PW7T4RB9/JOXqI10KSBX1/i0+7R+Hzb2PWlE4ViwDU=;
 b=dRFUa1TqIYEthi4T/vL1YxA5HBgZO7dBuWPQDy/t35PDU4DSAnRHy6rdLRgHbKp0OZVROT54kJlp4uDUGbNgGiUPMoxSF9V76D9rh37HWu4SuoRBDqWqRd/e2y70AF2ycRzAceSIGEA4f1EGmhifS6AGAzwnFl4hICgiD85qLznATDejCDrvcm96oLvjSgMBYHj7QMWcCyOa++tV2DYiHr3gMbRQQRFQhcUQxyxIhdGhHl6KjxRJAUDpzKAep9BrAulattHULWmt8C8sd9wW4wVw5a/3IaqMRLfsxYnSD1qyRnWSMjQm7jlg7/J39frDqARmB7xsegnJWVdZSQGyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PW7T4RB9/JOXqI10KSBX1/i0+7R+Hzb2PWlE4ViwDU=;
 b=45ErOc4spbbJ5PXCy8+FcZk+YNA7zq1rVXhi6YPNHtrsGq1Eyt45V8obfJ/9V00CmfWhf0GNtaiQQB+EHJ1ZRO5+a2lBLXDjS1KB7+tbdCJpO4gjIFfvHQHOty4WPLu1DP/sgr5dcdGclI18fp9JT/BGKiuCvJbQSMp7KAbWp2Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2563.namprd12.prod.outlook.com (2603:10b6:207:4b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 14:40:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 14:40:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXJHAeNtIYdlWsNUeHCO9EHvqaw6qbCVKA
Date: Mon, 29 Mar 2021 14:40:46 +0000
Message-ID: <MN2PR12MB4488F8904F0D73C01F42A0E4F77E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
 <20210329074935.10822-3-Emily.Deng@amd.com>
In-Reply-To: <20210329074935.10822-3-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T14:40:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=109c6dc9-9831-4745-9cd8-100458ff64e9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2647055b-0f30-4503-562b-08d8f2c0a3da
x-ms-traffictypediagnostic: BL0PR12MB2563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25638714004A278B0DC970EFF77E9@BL0PR12MB2563.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAoT4OuDijRePsKe1JlqLqem1uu+tS+b+AUAz2+QdgPMb4HRoD145/pgpFzGoX3xyiOjq8gQSS5vAS4NazSBIij9xnz7LJP41wnFUU3HfbVhmxVXdfbIS1GQVloB3iAJZQaTFXsq9Juz07uu9HVb7jYPIheJERT7KqxQYg2CwWOJLsYkmsWU/YrEzmKHl0Z0PQ64AtUcwse2Tf+nAIc1ZaLa5JM9ciT6QYv3lk1A6NyjeEe+trWGs1O/EHKlxEz/guib+NcT4Y7qzZ0FHbWx4WwurqsHtmrKk2cqbNzhILynS/YHPzDxK0ZjGgwyXJhVg4ok5ehfReqHc58zxpNAY+kBNzPU3Fb8u1ySgHbTStonoc9DxrKx6PsdH680ZVaDoslKdLMWnJpQVQLvnmOy8T9O/i69Nw96tnH3E8rNmeVpfAAOThTQzpsHAArwIUuDnhDhJ5UwrCoEh5Koeo4FQd4CtbLdgiVNxOp1rsUJ/crQZTUN5IYqDFbuNeyq2j7wxrOzb14yQup/yXzvxlKvIV1fqi4GsDhw2EjNz82wIQ7Rb88IXSU+mMOtARIPYJFMIJZp8G+UJ2ywApQgEmexEpuLUpKpd0qOi0Ec14lbGzqC/U1aSbgbmRXA+bUSXm1ndOiquUZnIqZkGQnfvzK9Op1iSv9zt28IEwg5UOy6jKrYqF/uept4e57Zc9Hro+5TrFj/HuaVl06RdMjvg7MFBOaRIZLyoYV0Osc0SJASCGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(38100700001)(86362001)(45080400002)(5660300002)(8936002)(2906002)(71200400001)(53546011)(8676002)(316002)(478600001)(83380400001)(4326008)(7696005)(186003)(66946007)(33656002)(55016002)(9686003)(64756008)(66446008)(66476007)(66556008)(966005)(6506007)(76116006)(52536014)(26005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BJBNZv+u8D1uiak6CJ33kq5uD1tDJEJX9Mqfi+tAsakxiCMXkxxxXt8OOzCj?=
 =?us-ascii?Q?RL0atZa8g2sB92EW53gyabjO/MvHG82TQlJRIA7GhYXZRfIxDIIYewZpYodd?=
 =?us-ascii?Q?Vvu+bxuGGpWm0/rCqml693Dbe5w18TKmlvAGDPMd9Gwmc14Ke0qIR1f28PAR?=
 =?us-ascii?Q?hH/LPjtDo/zs+/FrXJh9+qBC+93LP8SYeI2Psb5IXlzxGSlPZuJxtxcncpt+?=
 =?us-ascii?Q?By0ETBNvCJJPNd+wMk5o3s+YvYuIpXR/Xu6n8nJxZk6Tb6bF95Wq6SuwNhaY?=
 =?us-ascii?Q?G2fLq6J2zLLcq24ZTlxXMxBuhwbJYZQfDZv2j+5NM2iL0FE7i5wtnmeJRUBc?=
 =?us-ascii?Q?JTtMvunfL759SCkAqG/L6HYApRHNhC2cZPMiwwfqAd9BFKj7N0WQ7qINRFL6?=
 =?us-ascii?Q?f+PEzc9p/Syg4znacpio1ejWSIJAW0Lc2QIyUOmprmoOdXvZ2UwY5++MaggO?=
 =?us-ascii?Q?J0c8VapOpHZxqEd7OyvtopLXMeNg1QCw1r5fQNPh+q0az8TleT3kt78Pkn82?=
 =?us-ascii?Q?KUS4tPjhdhr5+XaVNGBDUgwTK+mKYwLRWQt1ebpSmukSiYcFAiGxVmbMblUw?=
 =?us-ascii?Q?G1EoK3fx7+IKJWYD0GOIt5H43iUkpQs9TpH+v6VfK31F6DfB2MOMYYOy0VEO?=
 =?us-ascii?Q?aOiSnMujI6tLTQ8JqabFRT+3yQ0HsdDr701QucgYE2DSjxd9Y9m5ySV8u3vh?=
 =?us-ascii?Q?7bIz8V0X06aTGdphnCHIdkMcOYZZ7URyd5L9Uo+ve+qBth+5fy7/HvX9Su1g?=
 =?us-ascii?Q?kwDDgguYwLNd+b6xTff834VSgsFYLrClqcWlepFMTNcaWuSQ1FRF6wBGMW0Q?=
 =?us-ascii?Q?CR7gpjs9POT/mlbqczeru5/Y+8T80q7wLnIiItt5airjvPtpi8mm7yJi4duv?=
 =?us-ascii?Q?8YOBuzjLCX7MLjBC3w1KSlRGFNmX8i1RIpYw/KY+iVSmSGbjCEphpGqVJZYB?=
 =?us-ascii?Q?Q4tuMOJgn/ZwYFFHMqpkredi8OhE3oxDxEuxV4Dpp42q5U7RQr+srbrmej3p?=
 =?us-ascii?Q?fd26N+iYmsmOZij3We+feV6DtqF4CjCOvl8Rarr1kTNIvIzdN1mCZ6hE+4lw?=
 =?us-ascii?Q?3/u4UvZCDJpK/KP/ZIf5Ma/uVnJ2WcZTwHsTtGpLtiSOFdc8bRIeXnExlKBf?=
 =?us-ascii?Q?JluQ6Xj4uIjKIrObnaYyYnmSuQ0fNKQLszbRgOR8DkIhxswtRPWwkA2jMpOa?=
 =?us-ascii?Q?F3IIn61eoJlC5rtlDAIIsAX2jy3W+0XLKG9tOVXLjKxq7so+VN1J58+RrwyG?=
 =?us-ascii?Q?J4uCCa+xB11G5IoENNFVVGSovzzloGAy3joPLe22kQVTEMcS6AfEAVwRQ8aH?=
 =?us-ascii?Q?M79D6sYd82izk1OOnlMaJ0Ep?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2647055b-0f30-4503-562b-08d8f2c0a3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 14:40:46.8069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUIkZARfp8grLVl1bE9+RTlPhyOtB4PDRwiaFyfUONxnV4gL1xh/vmcafnPmRffJSjYclrjwKElo8z/zrflk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Emily Deng
> Sent: Monday, March 29, 2021 3:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
> 
> From: "Emily.Deng" <Emily.Deng@amd.com>
> 
> After FLR, the msix will be cleared, so need to re-enable it.
> 
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 03412543427a..f24263120f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device
> *adev)
>  	return true;
>  }
> 
> +void amdgpu_restore_msix(struct amdgpu_device *adev) { #ifdef
> +PCI_IRQ_MSIX

This should be static.  Also please use the amdgpu_irq_ prefix for consistency.  Additionally, the #ifdef should be on it's own line.  Moreover, can we just drop the #ifdef?  

Alex

> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> +PCI_MSIX_FLAGS, ctrl); #endif }
>  /**
>   * amdgpu_irq_init - initialize interrupt handling
>   *
> @@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
> amdgpu_device *adev)  {
>  	int i, j, k;
> 
> +	amdgpu_restore_msix(adev);
>  	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>  		if (!adev->irq.client[i].sources)
>  			continue;
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C422d42ec3
> d004b207e5908d8f2873f6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637526009994486807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=0gZJU2qgZ1H%2F08YNVNN4RVAcgzXDbMZOw%2FuGvrimYtg%3D&a
> mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
