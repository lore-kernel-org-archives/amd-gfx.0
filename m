Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F0C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E4661952
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4661952
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAC26E4C9;
	Tue,  6 Jul 2021 14:14:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660A86E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 14:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCHzSOsIe6RKJ/wLqUBqzLD3JmJUTbdLYpqVon7MAoHTgOhNBaplrCf2bq2ozxLYQrukvMI2WhcW5hLuS2FuFgD1eA789yC3GjeXz14lqtFmZonAo1B2ZdhvJDeJ2myCDpKaKnC92VICAO2iGQ4ZtkfSX3waQtG52bLAYSuUG+mqpDtkkDd3BZHCaaxJQhy9NZ8+dODSRjCN3ntR66LLQ7iMV3gPszmDU9E1tl52Wg2cCy2eq2t6fmbLRiQRkUwzqSyIl0Q9ghvN+j1aub5yqV5seymrrkAg362wBk9k1xeS4KIaKz+qAQixaInuIt3AkHom+7wL6hKaxitfP+yXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dypp6htzoZbbQTtQzldfaAxjGBnC370V0HuRsmbzTnQ=;
 b=N2zYg8dZzuSHA8+AQsDwGQWmx/umf5eG6d+CGCfbGZNbGkBk4TEy3oUo82lqS6UiXVwMKFgbzPHkfCYDVTN+qJfpr6cKlrBI110alZjHis/6Fa4ICut1O8hlmsg1Au7Bsk7twiQJAL7GM6BYQ9z9MkXwMgOHkWUWz18XN2NTRW/YxBBud5SlWBWuDun50Cead60Rli5xyg38rTZH7OX/QvFRbd+h9Brqw81H+G/6WtogpT96SxD8viqmujcLOe2R0d9VpmKTIW8abTNgINPSkloX3AX8PfhjaoycU/Io9W9RzOWmjWo7P8xTxAllN5jxfuq6wGsD7fjnPATomnvnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dypp6htzoZbbQTtQzldfaAxjGBnC370V0HuRsmbzTnQ=;
 b=AFL/Efd3An3rYnzpqB/cuufREQckFxtvC/6pCMkk6ZJlgJIeFX3NtWI/UMxfHm0uYmlVRq5ikSXUjVPrauUzaTempT5wHGiz5J3R+t4leUQlJidOvS9GLokVsrjmO2i2UttDSiXdv2pdLCpZM5ITM4aVZS+F0K4pP7dB2+DhNTo=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 6 Jul
 2021 14:14:10 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12%7]) with mapi id 15.20.4308.020; Tue, 6 Jul 2021
 14:14:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXckAsJfODAGuJKky1EyJ3vlpow6s195AAgAAGQPA=
Date: Tue, 6 Jul 2021 14:14:09 +0000
Message-ID: <PH0PR12MB54171381CE986D1B254C098B8F1B9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210706082312.71013-1-Emily.Deng@amd.com>
 <CY4PR12MB12879CF8864C4F50059C0058F11B9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12879CF8864C4F50059C0058F11B9@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-06T13:51:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e4cd5145-7076-45bf-b189-39a79a7c42ab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee47c76b-6b8c-47a8-9070-08d9408852f7
x-ms-traffictypediagnostic: PH0PR12MB5435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5435E854DAE24007A4DA386E8F1B9@PH0PR12MB5435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2SCPKdCszPo1Pwn5ZZwhcNM+j6EM9IhzSxzKNv7W7AH6ZILdrzUSKFGdSKutw04eBe3WomystJfWYif3zvJBQLHWIZyFLaA6wBstDXU7BnO7x+ReHm7wxFPcRE5aZPiyOU0ps+tRq5IRYdbZhw6bGAuo/zsmZMA0T/ScH2m+hOjN73EzU9qUcXKUOKnG/UmGqcDhm/tTQzHNL9/f30wWawIRXtTui/op8TlrgQ3zKTG+s21tU8noCjuQS1y9M38jj0e2V1faE4MbGdXBplAkUElRysJwmZiSPxaDo1r3VfDe9CTRgx6bQXrd51aYVBbHPl9Rq5QqX7J5s9ZRDg2MAi0nowmc8q7Oj9H+Kml844TVS3t1RTbBs3amkkeJETaKcvfBIJKMCPzJp6Be62V3gUOhbhyQUfka36sK76HL4Sfx0bx46UCUF1B34t7mm8E9GzZ0YVZr6B3btq6prfT9AU91q4/b5E3QHONeGadbWEEAKrs3KNAqyEq+CyHTCfuhySbKM/8Hu9epqKs/Vdv8z0UrDeFYorAplJ/DkNW9ApEhlv8UvbzVDtLdnpI25Sh0g7f2kfglSRAwep+8gXe2SB4d3JJDPSRnhg7xPC9wkM5o1EGxIj7xF+BxFKV73WuvJTb5Dc+8Ybawx2QvaTMKPVnWzTyOVe/2QQq8vUs6PDg3j6Ohr9E2XRkKSGHJ25dKFWWiUfMRAJATDWK1JrIHjHoBhcsxtqjPN6+A3HBwQk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(76116006)(55016002)(186003)(8676002)(9686003)(52536014)(66446008)(6506007)(316002)(66946007)(122000001)(38100700002)(86362001)(8936002)(2906002)(26005)(5660300002)(71200400001)(64756008)(33656002)(110136005)(83380400001)(478600001)(66476007)(66556008)(45080400002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DBAFVJB/wWFP7AykteGmaOiGppF5PrBQnXxT/L0AHKti6fKwjUlcRbwOOns1?=
 =?us-ascii?Q?JvGp9Cecne4WSAR17su0WRfy4xmR9i/ZS6zKCzALu+4KyQJ6ihneKsyh5886?=
 =?us-ascii?Q?znfdKBjHPZgcRl9m3/fD7rqws8d4VUWVIzhin1DlZxjGV2mh/VIqjKSP0/Dy?=
 =?us-ascii?Q?tTB+7luzReQksmoG+l9vq7gdowAxxDH2C/J6UhtuoUmSDEvOcttKUs1e3SdJ?=
 =?us-ascii?Q?CpYNDmRJXIIRIpIkKTJIgbbkm6vjdou8zD7PilnPMIw1z2HBHgzCgE/31bo0?=
 =?us-ascii?Q?eOCxnOlNiMuz9eGhLqXK9N149MSH7c2bGG1lOuztjh88qQiF9m9f/N1lURL1?=
 =?us-ascii?Q?AF66JxAB5bVk9CFPwXqKSDRSwJfP0JIzNZhu2eWMK4ccjCLWQVxVr2W9FmOe?=
 =?us-ascii?Q?Ut/w+hEompKly+EWrnUDpdRdbU7DeBjPvqKaYIPCXxmCF5QwQRBlpDTpaCBI?=
 =?us-ascii?Q?mC2oxZdm2d3HVpJsbE8l/4jPmzv7HMkx2qKZMYUOm/LpoTgVfW7wl/9aGuud?=
 =?us-ascii?Q?/zMO2TNotX4v8OFW8c4M8+coJ9taGMlHYdkA+lXeVXcvICTPgKANk5AkwGtW?=
 =?us-ascii?Q?43y0fvKehMUpMQ5XkR5geIwmvXrfIR6xvyeQw/emS86ekgZqqNJfRvxsXmI4?=
 =?us-ascii?Q?Nbcp1hkO3UTSeStFHNsqpI/hhdO/jDUDu1G9LRtV/5kFt5AhWxWbjaUrIpMi?=
 =?us-ascii?Q?RZQhK58od6GwEJb+NtPdvZPZ9kN3pgWDLfl5La7uTaQg7gVKK3oYRx5EsV/Z?=
 =?us-ascii?Q?lUzokw9+83i1UIA6EdNSOsROyanAuMck6OMwJslUhqv4LFtNUKd1pvBzgFb0?=
 =?us-ascii?Q?InliZKLU0RI1uu2RhfecW2SlhW5aappFG9+WtqmkaUPlRxIZksOMbO+mBEWg?=
 =?us-ascii?Q?j1jjr7ueM1P8+17NMVCjmTOVOonXnmPw8TvNRn7upvHTsKCwuOk9AM1xiW6k?=
 =?us-ascii?Q?jpVLjL6EQPCx5/jMt3nIiS6DN1hM22Vdp9/GECeR3mBi65ilFtfqn0vcDjGA?=
 =?us-ascii?Q?mD9vZv9vpj3ZmEMBhO3+cYnR/u9Zp90CL040M9djg0O6qujYGlQt8wNmuOhZ?=
 =?us-ascii?Q?SRzTsZoJW/AsuLqTpHQjH/5PjwyXtOodcMtLvXan4WTIRTZcq1dbaP/SK853?=
 =?us-ascii?Q?gImh/ZOG10YkIPnutz2zKirfcoq9bjDgWociHOHwgfbEfWlceckHriD4n/cv?=
 =?us-ascii?Q?hg/RZKIGPYLvkuMzTcG6yi128BlNEHP0YbRKisPXcbiDZUaq34U3FcnADG2E?=
 =?us-ascii?Q?zNLB7xqUXjxkKjSfKNYHSK7DdsX3ig1J5GIT9kKMLr/fSxuzElKCx6wCg4Fx?=
 =?us-ascii?Q?UK+dAakB7Ua8YGEZxJEcl1Rk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee47c76b-6b8c-47a8-9070-08d9408852f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 14:14:10.0415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tt7OWK7xJ5Sve5kvY+E3HxOhGzbccseRLPaCTueXrF7N9z+JbUyWMqYHrlL0P81F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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

Thanks, corrected.

Best wishes
Emily Deng



>-----Original Message-----
>From: Chen, Guchun <Guchun.Chen@amd.com>
>Sent: Tuesday, July 6, 2021 9:52 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>[Public]
>
>A spelling typo in subject.
>
>s/ctrc/crtc
>
>Regards,
>Guchun
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
>Sent: Tuesday, July 6, 2021 4:23 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>The irq number should be decided by num_crtc, and the num_crtc could change
>by parameter.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 33324427b555..7e0d8c092c7e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs
>dce_virtual_crtc_irq_funcs = {
>
> static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
>-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
> 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
>
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ca4ebf76a046d421cf
>07c08d94057515e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37611566042100458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=k
>h2vwkTyod4ajvt03GB6%2F%2B4FYc%2BwZLCC%2FusgWuijPCU%3D&amp;reser
>ved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
