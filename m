Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1DCC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 03:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCBE10E16F;
	Wed, 16 Aug 2023 03:02:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B90710E16F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 03:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu+JUGQAcOcJJ86dgN53wR6ehoTBkM613Mmfb2z350QxyeubTOfdjX4mHlZAF6IHQSZda0Av4PYsVVIMGWYx8xNGrzt6Z480UA/yqQeRPR4U+rVN5FjqmIPaXld3iPsAdFmduRse4jXVILnKQsMvsCnnSHZXOLGAaFlu742vMSDvjQ1bDyxqtKvKJAJAMVqKYaLDZFUFmdbu8SdgGst0vtYp3TqeJ1A7MuKXRY0eMwmKrap3+Nsmb+y/ZMiaqUbgnSGc962y+q+OoKOSMEL3NRwSIlXpSkV8qIUz9dSUDOEEmSj/930iInQ6HYqKxgYHDPJ/KrClpeCNwb0naoMvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjUxqdLDNKajUI+6x0x9hPfpE1OLPTgJt2UutAutz6o=;
 b=VOyzzX80JPt+ZQ+av1Xdl4mRb/S44c71ZqqNLqnyKVmRK749vnqwE66CM/yWLagKWyUKtwh9my5wI6uzo/41mCwvZVHhWlG6o8EjlSxgFkeaDPlyfSswELzSghOoK9mCf7XCipjcNB0i2vZOpT/aSef6To5YxDO0zk51bsqMwYcZzc4RLlIgya1cRpJaMeCgE3Vid/9nlTd5tE3MBMCZbypcIR2/f1dLRTv+/BnnKN49ZUORA8j8EfhDLL4X5ObFTUeXhBbUJ2hkSt4aHAGBHvuKA6DHQifehScNGhSmKuHUNH7xlOCZMpo40w5UM2UwiBIp35/bi8I+Xl23EZPsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjUxqdLDNKajUI+6x0x9hPfpE1OLPTgJt2UutAutz6o=;
 b=vmr85RlhtCcaWgiTv6Rk/j8y8dvW5mQQefw4hA+WikMu/vNGe1EIcekt7SoBAW7w1XwuxKLNOzxvf/QJFr0P6pCKcRZF62WIg3/Z9wqJ69Tr7tk3FPOIxVGCWLYj6ceEj0bdtz5DniVVXVBFFzhSSKgAcFMIQqxZ03TeY7KDASw=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 03:02:20 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ac8f:19d4:21ba:17d0]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ac8f:19d4:21ba:17d0%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 03:02:20 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable ras for mp0 v13_0_6 sriov
Thread-Topic: [PATCH] drm/amdgpu: Enable ras for mp0 v13_0_6 sriov
Thread-Index: AQHZz+kUuf2N5taMZ0OaR225IyLGD6/sPD4g
Date: Wed, 16 Aug 2023 03:02:20 +0000
Message-ID: <BL1PR12MB5334F590E7E62352F6D4E3E19A15A@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230816022544.1371378-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230816022544.1371378-1-YiPeng.Chai@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=521641ff-9779-47f1-b320-46565ca479ff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T03:02:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|BL0PR12MB5506:EE_
x-ms-office365-filtering-correlation-id: b6608d1a-1cb1-4f4e-249b-08db9e053501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znJ7YY7RSumgbwDT6A3WzDYYPp/HLek+TjUcwfuTfmIVs15Gzj+OE404P7MFlphWM7MeAobuWL2CBLO6KeWNa+odG2NpPbbBuUpixySDZXGO+/YQ820bWSJknPrDZjdQrfB4NELA/7JImqukDe5LQw5mPdGshNkqArOhBgyziLLRqiM7OMKzkDaJl1HyWITuVfQLEZ01Hm8pkTeCz4H1wypRqEP6vrSgu0ZgOr4wBA5u0WWpZnyckO8Y54vr7tBaxJphROUPi+IESSi0T/6oFJWv3jTx8Y/BMvZrxO+0Cc2XszdFHhbgGuXUWDQYOQ0WG2H6EbyVw5yHl1XTtbTaYskTAimYcryOWy46U7x4qNp8LruFcT1VOrLcfgUBvmNHHBP1o4oL0HLq3EnYiXBpRmFC+QBSnFeUKhUmDJ0ePl1aCfxwZ1i4Vx5uf3XWK9gPmpyWnN7+clvCiyDR9k3dfOCa7A37CXoKm1yHuZPaC2Wut7JarFIYXtD0bbB3n4OQSMPK2f0ewZ4WOrC5L0f7MIzV9AuhwAUJyzvzmNPf/Ifkm8h0DY2iE72oYisfEEC4dcTmSH9JsBWnrY6rVsjWm32oVca6A8YU0WW27wGs1zXzpRbJJEoIoQ/hsM83jcQN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(7696005)(6506007)(2906002)(478600001)(9686003)(110136005)(5660300002)(83380400001)(52536014)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(122000001)(38100700002)(38070700005)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NutrbX5thV4NNBnuuJiTstCJlzC7BuQ2FdMqsWNj7qA2UqOSCLc3ftc0vH9Y?=
 =?us-ascii?Q?KG5cAOfkD7hXNUZDQqLtcZCwy+P4WCF+0JWFCG9kliT4mUwMyB/AFLpqJprZ?=
 =?us-ascii?Q?wKVDsJT6I4Yu+yvqfiKZ6ADsRQXFkKQlZ1lpP7pklMInp8Ht+dZW4noZ1QHj?=
 =?us-ascii?Q?IH6IPi0oMrB0s8VUfxB09da5R0vgz9luNFTJLhRwa8GNmbxfY58qLPo3i/eD?=
 =?us-ascii?Q?hEutgd78cIxOzf0+6I1uHLw/tuSkWAdoQN4Y1SZgc8U0vXG0Pcq3orP7IXUK?=
 =?us-ascii?Q?5aEhQfrkiaPPXI/RIYHzYlccFDpUD/jrfHCxGzvTRv/1mizXVOrVgRrkUTfj?=
 =?us-ascii?Q?AgYHuOwsH2OrWkqN4865EKx2Lc5dS8LUmfMK57OkqO6w/fZxuOgUSZk5dSXH?=
 =?us-ascii?Q?Sa3Lhv0Y6K9tTjv/z4qh0rd5drrs9WBz5xg7UIJSNPJUawUM6355BIJcNAmo?=
 =?us-ascii?Q?hdGkG2+7CcN71hjc/3FL0ftmyIMY6TBM0FqnFshEddax+juO7AsyuisOe7bN?=
 =?us-ascii?Q?dAtzQzE1WsrGKhyxj+zFDYLBOKgLrVVNhtTqjfIuybe9kV6/luR8006HrELX?=
 =?us-ascii?Q?mY31WGAWpE72ElKtF/uZyvC1d0UddPHnjt7nw1cHBhBWfohGhOqx7Ggtq5JJ?=
 =?us-ascii?Q?AiaQrsYQhaNvlcDaiiCmzbAEfxSU+mGHPXfkL4YI80SiNDk9cVDwyIKEEqxs?=
 =?us-ascii?Q?4zPdN8aaprVG9lFaj+cd8NRsQ4XT+m33GNyvzr7Cv72oP4iPEQScNsJnPht+?=
 =?us-ascii?Q?Pb4KEIwNm7B5btKoly6SoJlIToDyNAIi+1aOttUgHqocicDmBt9xdHBPcuMg?=
 =?us-ascii?Q?B3z16C1T1es8Y4OknYcn21XAES0oTXBPGK6Yfrf8amL3U+d61XUZjOvc07xi?=
 =?us-ascii?Q?eZsryfqzfB7237S0EsP366FjiRXCPOGR2UFWXnScB1Fe0dqLr0mgPIcTF7w8?=
 =?us-ascii?Q?uPSO4c1vOwmO645i8bVqzu4d3en3BIzOcdP1wHaaL9RScPvqzSmOt8ICRCio?=
 =?us-ascii?Q?2AF9OTMicCagVeIIQCq+eYxOZb9McS3nvR+3NBp4yPlU4gPVLn5EOQjerQm4?=
 =?us-ascii?Q?ihgTwlj5ZeN8zoN7RgXVWjPPK/1wioIHlrKanywq2xq4zmcd9mOEFEPx8tQ9?=
 =?us-ascii?Q?vfbNbWhg2XCngbLZMzZaxCM8sOF7jwzkewMJWupCmj1JLRdkw7mHr3yN/0tJ?=
 =?us-ascii?Q?ExPH/BLjoLQBjhDUAKOw/SRXnXMF6XVPp6ChH33IlB5zgMYwNRe3OToaD0+l?=
 =?us-ascii?Q?0cgXpMcaPXyNAvsv3ntB0hYl4sJT01tuQjc4hkWMn7b7JRtuTjWwWHDttiyW?=
 =?us-ascii?Q?X7jZFa1WhfGRNvjwlOQ62rh7uESRopMysfkMTbw2ptfoxOoRH9d5nTt1w8Qq?=
 =?us-ascii?Q?OgqoxxnIStBOA7IIRf1YF6rwqdzY4r5biqj3EdacwDbDPq6XluyEo8iJJu2Q?=
 =?us-ascii?Q?j0hoaWb7/O7AWS+X6GyABeS3z+RXD4LlADsoMHd0H+l70bMhNKzuc1WoF4t7?=
 =?us-ascii?Q?Qpn0gcdxMJ91knkUfYf2togfCZ/Ru0KiNDv7+yw8+zAiEooCs3JlHjJFgg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6608d1a-1cb1-4f4e-249b-08db9e053501
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 03:02:20.3955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGzUgDJqEcAt5mgwBLx+svnStkY1310dgnLQrrA7jmpHY5B/eeOWuEXI0ay1GsAzA18Xhec3o9jbjIM3JB8K/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, August 16, 2023 10:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Enable ras for mp0 v13_0_6 sriov
>
> Enable ras for mp0 v13_0_6 sriov
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7689395e44fd..378478cf9c21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2399,6 +2399,7 @@ static bool amdgpu_ras_asic_supported(struct
> amdgpu_device *adev)
>       if (amdgpu_sriov_vf(adev)) {
>               switch (adev->ip_versions[MP0_HWIP][0]) {
>               case IP_VERSION(13, 0, 2):
> +             case IP_VERSION(13, 0, 6):
>                       return true;
>               default:
>                       return false;
> --
> 2.34.1

