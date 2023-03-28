Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382BAC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 10:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DF610E83F;
	Tue, 28 Mar 2023 10:52:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EF510E83F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 10:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWcOkydaQG2Fv5udAP0ijxHz+/0AMPwf5WsnGRiU70eZceSo6mKyBvRsLAcNoNEljdMD23GJ0sBa/lA6VuBg1Yao67hpz7HdtvhkqJMDNRiroOktQDJPKA7fpZZ+RkoCwdMJLZz8Ytb85r14bG5uoDKWN3i43DXJWxMlC+8py04m5d/W9MZ11Qu112XkGcQ2iW/aiopAJVXWwwQJorqCN6xYMzHYSiv2wLFplgzkRo24C9HaEgu3tCPXQ6+eP6Ute0AjUj0AoJXf3rYCder0PSlFVaBC2IBLHrQyckL77fcp0+weqLPvGMXBQKGajBvd4stZKFnbiuYU6YV1ZvTXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1qRy9wWOzTT11+kr6xHKrqp9b+2cuELlhy6L6MGkTU=;
 b=V7aAdlKy1C/il/mcEYnjrj/Wq1lV8ZX2+m3VysB30ECVxzWL6+gI2aJBnLHK7RqYxlQ6fOucpmOba4C2KZx11XbbLFfEytRr+SrEjb8HcVxjUxbDq29uCFeYMRzDh6Z/tu2z9rUFCMNNhoAqfWmjAletIlmcZXR5SZTtZ0BMLl+xDDCPvidGaGboJyUW/aCD/2qnWcI1QGTUxRvsUN/gkwBo5wLgphKDDYbBcNuUMMCL8UJZohxQwRM2ZkWNEjwe/9/Ha2uV6L/IzNYf7nrpKYHJyg02H1zofDWCqsWGAj+DPrI4r0ymZgEjjPzz5xVZaZAiAk867hznloEbd6HmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1qRy9wWOzTT11+kr6xHKrqp9b+2cuELlhy6L6MGkTU=;
 b=ozrlylgIrbVzEdyAiDaHH8nNoRPO0qAz+LJCEMQAr1e6197Of06RSLhC2Ho4Pc52ofMeoKWi6CJAeyKHuEQ+/W8krc15ZMjVLH1PO9qTqWPw0qXkRIPOzybH8GegAPCAAyaf/3ga75vZwLG0q7w/OffpwxlQrFhAFXPVj9BuXMg=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 10:52:39 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 10:52:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct xgmi_wafl block name
Thread-Topic: [PATCH] drm/amdgpu: correct xgmi_wafl block name
Thread-Index: AQHZYWM3btMiIBG4HEqA5ScaaRPjYK8QA/TA
Date: Tue, 28 Mar 2023 10:52:39 +0000
Message-ID: <DM5PR12MB1770376AF77CFD9229BA817FB0889@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230328105025.17511-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230328105025.17511-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T10:52:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=71e888ed-2d07-4a50-9e93-b833800c198b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-28T10:52:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4942085d-661c-4d2c-a929-e7fb32b29ae9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DM4PR12MB6400:EE_
x-ms-office365-filtering-correlation-id: da5c03f3-9113-44eb-4854-08db2f7a8ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRCBM1fd/P6oRpYCPs62xMJ0Up59ZdlkJI99zogFp4eoyajZ8bOzb5Vf4P1/BJ3Z0nh38dtT8Z6uFIJmy4+er/zRZmvzM+zeHMWIva+DtU5NhYSbcG08kXQVZG5XoMKlSxAa4lzUurkZ5uFYxJQf8v9e8uWI6WxH/nvcwHxqtH/a36Bv6FWbP1QT07FElFGzrWNNOhwrBke+8BcpOuxcxhxMg/3UYiYBPdKWUCozcoatqa6RRmqj5/ZYA3ujeSx42HvB4xNeR82w4atkiCPA6WxnXfOly7q2h3fbc3AGL5QaCxDzcDR3rUdthGLnd3lYilvgZKe7rnqqkong47W4Cd0l/anTCUn9Ij05WsLaEWm1r80/IcOILT4r+G9ftlTomxYSoxllVtMp2UXFElsb9XymIF24tXV4PJxJjUD0CLCnJWfUsFZBz77Cel/NNpJPiI31KpuxxfjuJ43alBwM51OAPt9Cm+HK1moaw3rZdRgxXyAomK/nx8sN5kzROXXCT3i2FBJ4OW9wCffo7DeN/RT1Ulskjhqi2M/I2MnYj+O6mtLISlY1+4PliNoYJpZ59OwHItRmqSpJopsqvQyvXBqM0XOfp6tCYIThZMkweqbGB//ILVf07TKD/WtfI+v0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(2906002)(38100700002)(41300700001)(122000001)(8936002)(5660300002)(52536014)(86362001)(55016003)(33656002)(38070700005)(478600001)(110136005)(316002)(7696005)(71200400001)(53546011)(6506007)(9686003)(83380400001)(76116006)(64756008)(8676002)(66446008)(66556008)(66476007)(66946007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yn1dfHJIkP1jFgr0AEghc3H7hxv2eSsA+O9M+wLwSLyVcy1OCnvzB8OYUZIq?=
 =?us-ascii?Q?mCbfJmv6zWRPFP/LRs1cDqd+xkcTtjA3TqN+2oKgPISVjQgxkLs6mH9fFzMp?=
 =?us-ascii?Q?oqS665IntrUaGiZ86IkhKEqbrD1kdCjSf6wUZ3xbQ5ur/PoQ4p6Y2qWMRUym?=
 =?us-ascii?Q?OwFHiBmIDzkI+nqdj3HFxODyswnvm/LmQjUdv/oAycvvcHtS+TZdBBQIQQN2?=
 =?us-ascii?Q?Y2wX4/oZB69KeucRz/njxqdsFvKGmr8x5weVgNUepSUP58BsmWZw22R/HMN8?=
 =?us-ascii?Q?93kB4yyR07fN4e6SpB/pP98gG9gPObyzodZUmBGCYSBwRfdAoepZdR6EK70u?=
 =?us-ascii?Q?5WMgohL5A3HhpKKLtUmaSX5BEWoP/hfTgG76gaT19vguncK1nw+XkXoizm5Q?=
 =?us-ascii?Q?uumkUBvwLj0XtBYDn4JIQF64XHwgTP+ko3vFzyB76cJykB4u71q03Uy0ePHn?=
 =?us-ascii?Q?Cw3tygW0S50aNgoCZ4/eEfXpzOcDJfF38G/kj7NH+rJhpEI1li1LT04G4ZJ6?=
 =?us-ascii?Q?gwZoFnMH0GazFUKImpXTkNq1lL5pYnEUXO44Hyf5fmXd0H9dCjEtL3/MnShf?=
 =?us-ascii?Q?TKnJoggMuP0GW6LtX0Dc6aPaYVBceX3QbleiLzr19LjC6WeV4ibUaHkK9YL3?=
 =?us-ascii?Q?qAuRfNx6VihwD4Gt+zrpnRXB9IiBmg6eko4RozMWP4Craldr9m37ggDaHxgT?=
 =?us-ascii?Q?ht5/Jq2SWBLubzRSiug6KmTdWq6cILR6tZY3dESoH5eYP14th01wkAuIUAgx?=
 =?us-ascii?Q?sMRV3bVCfgQo45N+G5kCSQZjBe8pvdjEiwEPFenyHORlKziMD6vpAYoASl6j?=
 =?us-ascii?Q?YIWSwMEMhYjSvwQiyTHTi/MbkAGZO8nOcbDjdDcXCQUQGX9rAe8OS4s8OBiD?=
 =?us-ascii?Q?sb0VVBjAHkltxPKjWRsemF5RsGdwCzKfbZYNPdpA1hh0J3ExHnM5ZX4JytdA?=
 =?us-ascii?Q?wiwD9f1PxQtoVzK5vOwPxcFAIJL+Cf3X+NrUQzzrVBIzn4BHsVDGGGtA60Gs?=
 =?us-ascii?Q?q/nwienJxe58q3BzhviP8WXeskX6WSjY1tX1E0ILfnivh0CPL/ym1rwZJL8i?=
 =?us-ascii?Q?iYWZZH2PLFAWsjZsVvkWmPEsvf5Ff6Cp1CCkHMkaq0Mrpw3mxYInS4OLlWFb?=
 =?us-ascii?Q?xLu8pv1SxwqtIx9bo+Vzr5UnvtNUIEw6lrWQ2lrV9Gjb0J9a17A2wCIkmdjW?=
 =?us-ascii?Q?jIC/NwUg68FunjYfA/DdofCF9dzkw8dzPrke+Uc1BhLuh2HsofBBtAaVLTsJ?=
 =?us-ascii?Q?F209faDFFm+0xm7SnDEVU047PwHJFPBAVTt0i7f/6icDFaA8rZbMNJYl/B/W?=
 =?us-ascii?Q?8D/GvClyPQHGSQ5qZ2tFGpomEA8awUsiqWQDLUx3Jo+Ccr37nUBhYJcwXYeC?=
 =?us-ascii?Q?RCN9g/r/X/NVWViVVVDOXdZsknvUDgvKsolD9sPj5kz45whJdpz86rtSIFbu?=
 =?us-ascii?Q?1RZQzrMC2WXUBiz8MxPNnR7mZjYF5OcbpxfhrBFoZuHDANaPwLsJEnouWheI?=
 =?us-ascii?Q?6fJfOpzuI5Gp9eEalrJdqmhv4uFxMpmhDvns77nAZHFXkF6TvSMaSYoclQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5c03f3-9113-44eb-4854-08db2f7a8ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 10:52:39.7222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcZtbxPD0ei05clvx/aNa3lcDKyl6ERbKMYjbNaCyz/L8yXdXyquaecxEoifePqe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, March 28, 2023 6:50 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: correct xgmi_wafl block name
>=20
> fix backward compatibility issue to stay with the old name of xgmi_wafl n=
ode.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 3fe24348d199..439925477fb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1068,7 +1068,7 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device
> *adev)
>  		return err;
>  	}
>=20
> -	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl_pcs");
> +	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
>  	ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__XGMI_WAFL;
>  	ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>  	adev->gmc.xgmi.ras_if =3D &ras->ras_block.ras_comm;
> --
> 2.17.1
