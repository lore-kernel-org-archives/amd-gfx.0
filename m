Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358EAC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 08:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A7F10E15A;
	Mon, 21 Nov 2022 08:14:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AF410E176
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 08:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ZPXK5jgTpcuTd8nZO5qwPHmmskCtOdLCkFKzqdFhbzWpsEn7a9MGwqr0TdOpwrX77Arj4W7+BOH+oc7GNSLA1pRD4gQobthtf9dK2saUKgJ7Ji2clRrae95TiP2913CdjruxPFdEGmJuOfw5iQOkvfjEfVkeV3WloYt7BbrsBw28YtSbAO8eoemqvJvQ0YET2cRk8or5znkfEPBeFap9zHd5ymxhXCnbbksPFVjPFSh0uCkVCVH5nBO+UEQ1zrMJcA/g83jPhh5uHncACrts2JAhq28T9xWjTeeMiV1DmC9khL8EWn9rkRo4DzANaNsSj3R330o27iZUSTKkYXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhY/fLJvz4sDLg4J1p/D6WtpWaI+L9KnKeBIjNrZ6G0=;
 b=bEZMOc8oc3wnXnVhBHCv7xBPHr+aT0Q/uloAu+P0Vh9RI6RzGn/NUKX7BDdaEMSYEPISutPuzg1J82pho6M4Xf/tQpk8Y6ln6VBkPomHgMX2XG/xLcUJdbc0gbZhhyDzSyLXWoTO95IU/fN3nJ4mhwOZh+zISf0e24vpqE7Ce143t3pAH65OqSZuTeLgvZKtE2FHls2pxYhMKwXQD/FBbIL45GtFt3Ma3Da35A3pSybHDYpxiuAXtpsMKtuGXqyCBwIgnwbGRyKxFHWVtzWsngLeW6GS6GawuNkoNa2nOzpmmoLQzu6TvwToO/wz+PENIQqDS8Zq287c0pARWu58PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhY/fLJvz4sDLg4J1p/D6WtpWaI+L9KnKeBIjNrZ6G0=;
 b=ciQKujdVG7sGsPx+J5m8Gv0HiEc+kQicMFdFsiRHTVCEm93Pf/+2F7zr9L3/hQ+cMstAGvMd0CkkYynBT3zFasknQPgcTN0XUNN65sVKa0k15QU/gf1oQNlHFcmHGvBPZ61fEcTXNnUJS29cHpAjEc7iV3ldwsrtD4VrUD6BXOM=
Received: from DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) by
 DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Mon, 21 Nov 2022 08:14:04 +0000
Received: from DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::6e3e:b414:a2f9:5b7]) by DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::6e3e:b414:a2f9:5b7%8]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 08:14:03 +0000
From: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Thread-Topic: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Thread-Index: AQHY+vl8+j448UFqtkOdMwt7bidWcq5JDDaA
Date: Mon, 21 Nov 2022 08:14:03 +0000
Message-ID: <DM4PR12MB61345E3384A80B9BEF5F79DB900A9@DM4PR12MB6134.namprd12.prod.outlook.com>
References: <20221118025608.612986-1-Tong.Liu01@amd.com>
In-Reply-To: <20221118025608.612986-1-Tong.Liu01@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T08:14:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33412d33-8a7c-4dae-846c-9c83055ef347;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-21T08:14:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 09777fe1-e5a9-40c4-9c7f-3877ebbad142
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6134:EE_|DM4PR12MB6231:EE_
x-ms-office365-filtering-correlation-id: b27470de-41a3-46fe-ebc3-08dacb985a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZ3KALPTc4j4Hv4M7veUDim7wATeuvZhoxKitSEjUNrmFfWE5KQRYPZQrY3yNsxoB3TdBmTPsu840DDVxzxFBBzjoIDY37ZteM9KCk246/kpCJOxOBNvKjPYgKhGQGWAr2FXGEMytm+lEnXD+2SbxnxLBnzpVE7zUjbDJSrm83evIVdQ0F22YmqmmRoEqUqX6oxmLEsoK6nYwvCTWCLR/S4ycR9W738EvceHArsWMpEVNCcWaCHs83pYIcRpGPOqAmFGlRtkEnWgipoKg7H9hpemL+e3mLsx1rKrVw1wg6sanBUn15DxE/SQ9tqIJIXjrZ7MtJN/ekUBfhhgBMLJCMhb8BvUa0SeEqWQ88LrwFyyPhpEMiMBiPZU8zRSMCObx+yYJgw8+JXtOSVirX8lnZrDlT341dSzGRvVXn9tiwYyfmfpEPW7Mtg7txXDo8oSM+iS0s4M6GutnFVh1q2BiSF9GEHeum4guNxLU20+SFy69GBmiGztLFK9z9U56/dnV1R3ULzLB+dsToAFabgiCLYsh5JOX7GIXvKVEoAH2pD5dEZwpCyzxTAjTqMA0XLtLGx+6270qLd3yz1WG+G6Y44uzpP660xXMT/LgwrTPAoSB/8s6X5CzInbsYEfbxp+Egbuv4tS2WoMKspNxe+mpWbQgKxUMMusWPp36EW728M8jfd9e9IGCnlN2IxcIxAIOGYFgEj89QSP9NDYiauOEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6134.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(33656002)(38070700005)(86362001)(66556008)(122000001)(7696005)(38100700002)(186003)(55016003)(5660300002)(2906002)(26005)(53546011)(9686003)(54906003)(66446008)(110136005)(83380400001)(71200400001)(64756008)(76116006)(52536014)(478600001)(6506007)(66476007)(41300700001)(66946007)(4326008)(316002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?emZ5N2drNk1WTXRWYk9LM2ZjN2JCamx2aS9tcEZTazZTdFJsVzRZTDlp?=
 =?iso-2022-jp?B?eGdSbWdyMWJYb1Y0cG5ucWtnWnplZjhSVzY1cnNwMm4xOVBTcVg3M2Qr?=
 =?iso-2022-jp?B?ZkNjdlVOdHJUNk1ybHBhYnJEQkdMTmJrTDJVZXhFUE1GKzdOK2IzMDRV?=
 =?iso-2022-jp?B?SXBhWXZoNXdSc1Npak1mV2VmZHRKS2JtQVpPLzllKzhNVjY0aHM4dFY4?=
 =?iso-2022-jp?B?elZjcXh3czh0K2dIV3lPcDBnZThwYnBJdzNBdFJraUQ2SzBobHg4M1hO?=
 =?iso-2022-jp?B?SWFTUzVEY0NSSThacFNkLzhTZDB1cGhQOGJlcGlQOFVLcFgxMHJiRUFQ?=
 =?iso-2022-jp?B?QXJxMHR5dldINlc1azhiK2xPQUs5dGVKTThFQllVTVZpNFFnSTFoVkNO?=
 =?iso-2022-jp?B?S0NIS3YrdFlVVTBmTVlxWkNURWNwN25kdTcrQnRhVElKUGJGOXVCTjVu?=
 =?iso-2022-jp?B?K1F3SnFuZGhoSjVYQ2JiajhQZEM1ZG5aeVdQSXBjc1FnL2JqQWZqb1dR?=
 =?iso-2022-jp?B?TFlwWHljYmIyenBoa2h2QVk2d2MxUmVGRjVQbDFXWk9ZSzdsQnZwYWZJ?=
 =?iso-2022-jp?B?Yy9HWUI4NGpxZmVoMU9iL3JZY1JpQWVsOXR4U3hVa3Zncmdmdk4vTmw3?=
 =?iso-2022-jp?B?YkhBd0t5RitraWdLM0lnM3RvKzBjNzYwNjZYM0p6UnpUSEprK1JHTE81?=
 =?iso-2022-jp?B?d2RrNEc5TkR2d1c1bHdRV3lMYkZBZlY3MnFtNGhraVU5b08rMC9Yd0ph?=
 =?iso-2022-jp?B?T2xaRjRoZUg3WElZQ3BISWRCVUljOWJnR1RKMDNlSlVOK21nZnBwTnJE?=
 =?iso-2022-jp?B?U3VkV1Ivdk5PczhjRG9XYXlxMGpsUWhndVBSUE0rdTFiOFZXUExUVUtG?=
 =?iso-2022-jp?B?ZlZUVm1veEJUamM2NFg4eFl6aDN5aHBES2dHVm5VUUtScDJub285bzUx?=
 =?iso-2022-jp?B?NXlpZTFGL1VzUVlKd0ZPS2oxK0dOVldLTm9PaXk5ekJWSDRlSnZnQng3?=
 =?iso-2022-jp?B?blFONmkxTVV3cnlLMEVmMVhvcjNNZjRENzNNODB2V1NwUnROSmppVlJR?=
 =?iso-2022-jp?B?WEFRWnV5a2tHMVFtVGFkTmVGU2tGQnU3TWNVazR2WTNxb2V4QU1vcFlC?=
 =?iso-2022-jp?B?dzBzNHBGeFN6amIvbml0QnA0RVNVMFFDMjgyVFlMWTg1Y3pyVlF5UkVn?=
 =?iso-2022-jp?B?NFN3STdtemYrQjV6N2NraDNGeTJGNWQ3RlZpTnhXQkNueWN2VHFJRXJQ?=
 =?iso-2022-jp?B?RmhXR3d1eFV1TE9FQ1pNdE42cHJsUEZrQS9Dakloek02ODdyMVZQNFVK?=
 =?iso-2022-jp?B?UFVzamRGUU9VWGtZNnIyZ2xPSldDSFh2bUNsaCtLSk9OQ3RFT3lRQTV0?=
 =?iso-2022-jp?B?cGJaRHBmZm5jRDh0VENUaG01VjBrUHZXV3IwYUhib1BYU2xlZXQvNkIx?=
 =?iso-2022-jp?B?dWtEMEE4d0hrQVNVMlArUGxnSExRNFpFTGpHbVRRLy8vVDJhYWVwa1Zw?=
 =?iso-2022-jp?B?dEZYWU1WM1dxSU1SeW8rNnFicURwZ0lNeXAyQVdPSzdoQ2k1QUpNclhp?=
 =?iso-2022-jp?B?R2piOERGTmZsMUlwQWw4R1BWVmpNbXZiSzNVWUdaNzVsR3NweW5USEFQ?=
 =?iso-2022-jp?B?YmRJcDY0RUY3dTkrcjlRdFpIKytxWi91ZUJVYU9hZHdnZGdqSWlpY3lD?=
 =?iso-2022-jp?B?N2tQTkNTazdyRXpVU0lPV09YeHZWN1NvbUtxd0R5bnIxYVJHUUlaRk8x?=
 =?iso-2022-jp?B?MTlnQWg2K2hoSEVMTmVPeHdZNExOZzA3WHZRWUxCeko4WEc2ZHU5UzF4?=
 =?iso-2022-jp?B?WGF0ME5ESGxvNjdQV3RaWmdZYWFvMXlmVmZQNk41dmprWHMxVWdHdjhK?=
 =?iso-2022-jp?B?ZE9zVE9CbzlUVzQrZG1pbkk5TUxKeVpmejhLMEhiSTd6ZXppQ01jU1ZE?=
 =?iso-2022-jp?B?WWQxeHpwc0tXUGhiSW5vVnB2eldTMEZsV21VaDF2WGlWNkUrTVluTmxC?=
 =?iso-2022-jp?B?QzczWEdud01veUQ5OEMyUlFZaWpSNFUwRnd2WjFaQmFPeVFtTDhlL2Zo?=
 =?iso-2022-jp?B?YzJyd0hzK255NGFGVDFIQ2phcno0L2VGTFdDSjFzTkFlaDR5WjdNY1Bo?=
 =?iso-2022-jp?B?cmlvSkQ1M1QyQVplQWg0ditBdUpHTXJwVlV1Slp1V1pWWlBjQWxTZGxu?=
 =?iso-2022-jp?B?NjNaN1piQWNYaHg0bWtpb25qZGxBVGFQcHZvbVhqdEFyNHNVSjF1bDdp?=
 =?iso-2022-jp?B?Z05uVTBqMGY1Q01UNXczU3FyZkJqbWNIU1YyM0EvdDk5ZTJpaXdidVV3?=
 =?iso-2022-jp?B?ckdTRQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27470de-41a3-46fe-ebc3-08dacb985a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 08:14:03.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlqTYBdKoRMhTAdVbbXcHl2zFoncgXF95iKmnmNxjbcQMKQhl2EDy1oloBEAVse5FHKbCaQsQJZ2l7deICPFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zha,
 YiFan\(Even\)" <Yifan.Zha@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi,

Please review, thanks

Kind regards,
Esther

-----Original Message-----
From: Tong Liu01 <Tong.Liu01@amd.com>=20
Sent: 2022=1B$BG/=1B(B11=1B$B7n=1B(B18=1B$BF|@14|8^=1B(B =1B$B>e8a=1B(B10:5=
6
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>; Zha, YiFan(Even) <Yifan.Z=
ha@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
Subject: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange

For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So fw_vram_usag=
e_va is NULL, and cannot do virt data exchange anymore. Should add drv_vram=
_usage_va to do virt data exchange in vram_usagebyfirmware_v2_2 case. And r=
efine some code style checks in pre add vram reservation logic patch

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 59 +++++++++++++------
 4 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 9b97fa39d47a..e40df72c138a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgp=
u_device *adev)  static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amd=
gpu_device *adev,
 	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)  {
-	uint32_t start_addr, fw_size, drv_size;
+	u32 start_addr, fw_size, drv_size;
=20
 	start_addr =3D le32_to_cpu(fw_usage->start_address_in_kb);
 	fw_size =3D le16_to_cpu(fw_usage->used_by_firmware_in_kb);
@@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct =
amdgpu_device *adev,
 			  drv_size);
=20
 	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) =3D=3D
-		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 		/* Firmware request VRAM reservation for SR-IOV */
 		adev->mman.fw_vram_usage_start_offset =3D (start_addr & @@ -133,7 +133,7=
 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *a=
dev,  static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device =
*adev,
 		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)  {
-	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
+	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
=20
 	fw_start_addr =3D le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
 	fw_size =3D le16_to_cpu(fw_usage->used_by_firmware_in_kb);
@@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struc=
t amdgpu_device *adev,
 			  drv_start_addr,
 			  drv_size);
=20
-	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) =3D=3D=
 0) {
+	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =3D=3D 0) {
 		/* Firmware request VRAM reservation for SR-IOV */
 		adev->mman.fw_vram_usage_start_offset =3D (fw_start_addr &
 			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
 		adev->mman.fw_vram_usage_size =3D fw_size << 10;
 	}
=20
-	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) =3D=
=3D 0) {
+	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =3D=3D 0) {
 		/* driver request VRAM reservation for SR-IOV */
 		adev->mman.drv_vram_usage_start_offset =3D (drv_start_addr &
 			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10; @@ -172,8 +174,8 @@ int amdgp=
u_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 						vram_usagebyfirmware);
 	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
 	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
-	uint16_t data_offset;
-	uint8_t frev, crev;
+	u16 data_offset;
+	u8 frev, crev;
 	int usage_bytes =3D 0;
=20
 	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_o=
ffset)) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_ttm.c
index 52f2282411cb..dd8b6a11db9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1570,7 +1570,7 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct a=
mdgpu_device *adev)  {
 	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
 						  NULL,
-						  NULL);
+						  &adev->mman.drv_vram_usage_va);
 }
=20
 /**
@@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amd=
gpu_device *adev)
  */
 static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)  {
-	uint64_t vram_size =3D adev->gmc.visible_vram_size;
+	u64 vram_size =3D adev->gmc.visible_vram_size;
=20
+	adev->mman.drv_vram_usage_va =3D NULL;
 	adev->mman.drv_vram_usage_reserved_bo =3D NULL;
=20
 	if (adev->mman.drv_vram_usage_size =3D=3D 0 || @@ -1621,7 +1622,7 @@ stat=
ic int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 					  adev->mman.drv_vram_usage_size,
 					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
-					  NULL);
+					  &adev->mman.drv_vram_usage_va);
 }
=20
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index b391c8d076ff..b4d8ba2789f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -90,6 +90,7 @@ struct amdgpu_mman {
 	u64		drv_vram_usage_start_offset;
 	u64		drv_vram_usage_size;
 	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
+	void		*drv_vram_usage_va;
=20
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index a226a6c48fb7..e80033e24d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -428,11 +428,18 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_de=
vice *adev,
 	struct eeprom_table_record bp;
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
+	void *vram_usage_va =3D NULL;
+
+	if (adev->mman.fw_vram_usage_va !=3D NULL) {
+		vram_usage_va =3D adev->mman.fw_vram_usage_va;
+	} else {
+		vram_usage_va =3D adev->mman.drv_vram_usage_va;
+	}
=20
 	if (bp_block_size) {
 		bp_cnt =3D bp_block_size / sizeof(uint64_t);
 		for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page =3D *(uint64_t *)(adev->mman.fw_vram_usage_va +
+			retired_page =3D *(uint64_t *)(vram_usage_va +
 					bp_block_offset + bp_idx * sizeof(uint64_t));
 			bp.retired_page =3D retired_page;
=20
@@ -643,7 +650,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_devi=
ce *adev)
 	adev->virt.fw_reserve.p_vf2pf =3D NULL;
 	adev->virt.vf2pf_update_interval_ms =3D 0;
=20
-	if (adev->mman.fw_vram_usage_va !=3D NULL) {
+	if (adev->mman.fw_vram_usage_va !=3D NULL &&
+		adev->mman.drv_vram_usage_va !=3D NULL) {
+		DRM_WARN("Currently fw_vram and drv_vram should not have values at the s=
ame time!");
+	} else if (adev->mman.fw_vram_usage_va !=3D NULL ||
+		adev->mman.drv_vram_usage_va !=3D NULL) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
=20
@@ -666,32 +677,42 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *=
adev)
 	uint32_t bp_block_size =3D 0;
 	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;
=20
-	if (adev->mman.fw_vram_usage_va !=3D NULL) {
-
-		adev->virt.fw_reserve.p_pf2vf =3D
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-		adev->virt.fw_reserve.p_vf2pf =3D
-			(struct amd_sriov_msg_vf2pf_info_header *)
-			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+	if (adev->mman.fw_vram_usage_va !=3D NULL ||
+		adev->mman.drv_vram_usage_va !=3D NULL) {
+
+		if (adev->mman.fw_vram_usage_va !=3D NULL) {
+			adev->virt.fw_reserve.p_pf2vf =3D
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.p_vf2pf =3D
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+		} else if (adev->mman.drv_vram_usage_va !=3D NULL) {
+			adev->virt.fw_reserve.p_pf2vf =3D
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10))=
;
+			adev->virt.fw_reserve.p_vf2pf =3D
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10))=
;
+		}
=20
 		amdgpu_virt_read_pf2vf_data(adev);
 		amdgpu_virt_write_vf2pf_data(adev);
=20
 		/* bad page handling for version 2 */
 		if (adev->virt.fw_reserve.p_pf2vf->version =3D=3D 2) {
-				pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.=
p_pf2vf;
+			pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info=20
+*)adev->virt.fw_reserve.p_pf2vf;
=20
-				bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFF=
FFF) |
-						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF0000=
0000);
-				bp_block_size =3D pf2vf_v2->bp_block_size;
+			bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFF=
FF) |
+				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF000000=
00);
+			bp_block_size =3D pf2vf_v2->bp_block_size;
=20
-				if (bp_block_size && !adev->virt.ras_init_done)
-					amdgpu_virt_init_ras_err_handler_data(adev);
+			if (bp_block_size && !adev->virt.ras_init_done)
+				amdgpu_virt_init_ras_err_handler_data(adev);
=20
-				if (adev->virt.ras_init_done)
-					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
-			}
+			if (adev->virt.ras_init_done)
+				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+		}
 	}
 }
=20
--
2.25.1
