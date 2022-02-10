Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3993C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 16:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B120310E895;
	Thu, 10 Feb 2022 16:08:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FFB89166
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 16:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW2pBk2pJ4NDT8bvfKwly6U6p94yXOKktLoyjrbzltcKj1GQHMfVXn1DfOuxT/WMdQeGWZm0UdLVD9mGrhowiLnr1DNdxAuOxpL9oNZ65CRt8UaQ1iDP3lM2xX/6RbIlIFKrXyR4uM/Jdne3EDinhlxYqO+5Qp+aGQ8isIvZwQtZ+grJiay8X5s2On8IG2S7djqoWLVjggB3LLxjcvBhVLmqJfuKSLD7WWJYlSaO2TvktValgw7FC0o0TmwiEKN24CKeMnelfAPY9Nom3W065E3wPvsK6y3UfyLVpGpLIf3l9y2etdIrsVvy9IZQJWOOfjPV6AdablOGrP3D9uvurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPo7K43JVnRkvLPAnzSa4iAza6Hdm10Xi1pqgLwjLEs=;
 b=mgFPGbjlx1NQXD2DevStxdi6ITiwfUObXO456yI26kpQ3uTDKkRvwTYVJKCQ0iUE7+7GXXskWUmp6blS5ewo2X5vE+RRpztFmPccJelHNL4jvkufkOxHOy2+mKphOQ5It+/EpoBSzM+Y8D3qTO7WmhiT2ZiimrA0ImPWqFzSsURptG1AqO2XZ/UBUJkRYJ7HRjn14FvRcW2k8bx1E7YEDrHgG3h/jwBe4/QLTqsnHVXKJ8icJ4vWaXNl3eYJy2zlkCpWg7BM+4BNRtihifm9HzDGXzE4qa8SUNgURVey6u2o7EcGF7DzIjPSh8KkixMQKQVk6E8c/Pr0H21Yv8AHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPo7K43JVnRkvLPAnzSa4iAza6Hdm10Xi1pqgLwjLEs=;
 b=riOp7woVpk7B9PscanKlFEz8PK7d2+CRAMPq+0ylFl6FLzbZDezON27W54VjaeLA2BufNBhLpnVhS3CwDzA/2ihneIMqS+n0IPmuL0gwzyneQ7CHnyul8I6gn4RqKiZN7WPPARXf1gDyq4uBDpA0q7XJBTMKNolDWTdupN9zd5g=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 16:08:53 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:08:53 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Thread-Topic: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
 S0ix.
Thread-Index: AQHYHoMU8Guv8NP4lkmx1o/laTSQ/ayM0LrggAAX4wCAAALn4IAAAn0AgAAFG4A=
Date: Thu, 10 Feb 2022 16:08:53 +0000
Message-ID: <BL1PR12MB51578A1CD77547A902BFA03BE22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
 <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_N3fpN=HammdsurdACixsDEbFZ_3P0SD-UEKZ_4gQBSYg@mail.gmail.com>
In-Reply-To: <CADnq5_N3fpN=HammdsurdACixsDEbFZ_3P0SD-UEKZ_4gQBSYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Prike.Liang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T16:08:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0fbf4ff9-c99e-4c93-856d-00692919ad53;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-10T16:08:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 90367104-37db-4ed9-b4e4-577a4de7b404
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99bffe32-119a-43e6-96d5-08d9ecafa25f
x-ms-traffictypediagnostic: BN8PR12MB3363:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3363535BFD7A0191E334607EE22F9@BN8PR12MB3363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCrZSPSlsFnuWGLKP1d6wswlKkiM6C+WokxS/UdW7a4c4l9qjCsV5o5SWOvNxv82gU+IJjTKRKyVOLzj1w1H4SdGUT6XfHmertrDUl5hV6R0LOIWIpozReZmqmCSC+mLPIc+dtF8Mra7kWXEP3azX4vprKh5JtwTDPjjQRiMCRB2nDibbkrutBBCRkqgpmZFKkwjmhvgtx02vyzmxHfpsQ7rdveeAysPsfRQzVJ5GEY+GNJ9q2wTRTfg8Jxc433pzZo9mW13KyXebrXz0LWf/y2ixdBuJpX5k2KpQnKxDE6C2eDa3rXQvRwj9RS4s7HwjFTivLpVS9yAnGJaVNECprYpJwUPRTcjlRxl5BuBtnNPMGrG+VFPOLWOGs6Q+2OEyMfwUe+1ak5B8JoHffwc9k3y5a0z+AREmtZBCmI0j/xvJ9/V7JGybrJh8YpKl990tYalbPycKLk2IEl6OlHL7Z1sjq8xiUv/ethpJBnIWem2svZLSV+MO/6tWvl2Bw8OGi3OgX5z3vTkCqLgmSH8j8+Tf5lv8y7OFPEUohs1C3lKsjuhg4ayVnvm7c487c/7vpU3IWfFLJVAuxBVHlkqI+rzDbge+OMDpMLR4+m5cyNLxLny+AI1nuqrjr4Dy8cV+jThsZgnmnHlN9JxoqjYLUT9I3XZbEcosF0iH1PEjXENDkheRNwqJV5MrDnZqzp78qi2traeYyRdgO8Hj0mPKq8uWCST734uMXEbBeWkv5A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(8936002)(66556008)(4326008)(8676002)(110136005)(54906003)(52536014)(26005)(64756008)(66446008)(66476007)(186003)(76116006)(66946007)(316002)(86362001)(38100700002)(6506007)(7696005)(9686003)(122000001)(38070700005)(71200400001)(508600001)(83380400001)(33656002)(2906002)(55016003)(5660300002)(4744005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGlVL2E1Vm9CZHpUNlhqQVJHSEpYRUM2T1dkakIxdE9kaUp5QS9ma0FKeUFX?=
 =?utf-8?B?L0txK3B3QmlyY211elgvaXVpbWZSS2VVckM4UHhHbUcxQklSclZlRGhreUhz?=
 =?utf-8?B?MXJlRlQ0dVNZRHc5SC9OTFdPT011d3c2QVFiTE9hNkp5SEJoU0kwYm9RdTVo?=
 =?utf-8?B?NFZkOExjby9ycmdaanhoMUcyaE55NnU2Qi93Wm02T2FxSStvS3puSU1Qemw4?=
 =?utf-8?B?Y3ZpUGRyaWxROURTQlRFMUNqSmpsY0RmVXpIWTFuR1BnV3ZJWGhML3NRMlZ2?=
 =?utf-8?B?MGVRV0VGWDNHWUV1Vm5ObUNqKzhLWFhOb01yYVFGWENoRmEyTEhqeUFqYnVy?=
 =?utf-8?B?SVVQd3UzSTZ5ZWhVRmNjTWVzeXd3T0RqeVJWVFhWM1hMVGM3bkVVTkkrN1I4?=
 =?utf-8?B?QnJwYXVWU2dCUThra3h5Wm5FSWNkZTJabSs3WFRDVGVBRkFsUkFHdlVJbDRa?=
 =?utf-8?B?SGpTUGFkeTlKdXQrNm42R2NkMEtlUy9NbWl4SzM3NlMraVpBRmRxektldS9B?=
 =?utf-8?B?eCtBOGhCR3BjemtzVHpXSHREaFVUMVZ3aTlRMzd6ai9pZnlMejV5Umo3QVU0?=
 =?utf-8?B?d0tlWFVON3FFbjhZMFp3dHA1UE9WQmpGRExZR1hvZkVRUlBmbnoyOWg3NHdX?=
 =?utf-8?B?cmdSSCtCdzFsaDZrQUFKWkRSTldMc0ZKWmpqcjdMcHFET2VqYk5yL2hVMVFm?=
 =?utf-8?B?cy9lTlovRXJFc2tnZGk2MWxrZGQzWjBlbmJ4ZDJmZGoxay8zMCtxYzROVlFB?=
 =?utf-8?B?dUlFVFk2OXQzUzY0QjJxb3FPQStubFExRnhWRGVKd2wvaGQvUENOWFNtano1?=
 =?utf-8?B?OCtTTUZ5Vko5RHpWT0hYZkVLMW9GVTVmN2xsekpWMWxzQndhTUlvK05ra2Nx?=
 =?utf-8?B?OEhaSG9nYzMrZHo3Vm10eWJvNlMwYXFUNXBnaUd1ZjZTYXlISUZFcVBWbzJL?=
 =?utf-8?B?cVBHdUhWOE9VTldINUd0a3lvMitOaWl3MlhBOXNCaXRlOE0rdDVNOXFKMWZ6?=
 =?utf-8?B?STljczFEbG40NVlhVC90dHZoUTNPUXYyWGVlZGVRcWtKS2JEOUw1RFVnTmJO?=
 =?utf-8?B?ak1sSUJ1YlpZcFk0djZXaVNTRzZTOVhaaDhHOW80Z0FkTElHWnNRWVBGSjZv?=
 =?utf-8?B?MlFrc2dsQnMxZjRNSmRMZzZQOW12TzNGNVNnZXlkYzhYWnF5NHBPbm9EYUVZ?=
 =?utf-8?B?MWF4czZtNVdweTdhWWVZTHE5NHNzOFpqNGJmL1dzWVNLSDBqZ2YxQmtTYXpR?=
 =?utf-8?B?RGRzUVQ5VFdrZ0pKNTFmcXlkNHVLVW5kYmFGTFNjbW1tcVJQMHpSR3N3TlEv?=
 =?utf-8?B?dkNDVkloS2M2UjVrYkhQQThINkU5UzZabGN4MjIrSTcrM2k1ak1Pc0QreDh4?=
 =?utf-8?B?UEpVUDhMdVNjRWhOdnRvNzRxRENpRjF4SjIxdkQrUjBmY0JPNXhiYlBLR1Vr?=
 =?utf-8?B?ajRwQ29IWktkOWtRWHMzVXpLZnc2YzFjUGt2R2FoTkxGS1hRWVJPcFk0SE4v?=
 =?utf-8?B?UmtjVHpNWlR1WG11elN5QTBIK3hNMHZGdlVEZ29wZ1dENW5ER21XVDRGSGRw?=
 =?utf-8?B?VlM5S29aOW1DMGNmdENGek5malI0SSt6MVVxWlc5bDZ2ZTdaTU1Hc3UxZHNZ?=
 =?utf-8?B?OXZja2RZWW00NHNKRDdWWUZMUVJESjNtdURZMUZSSENucEwxK21aU01TTlUr?=
 =?utf-8?B?bjlKZzUwRFExOENlVStucWFFMWI4S3I4akZyajd0Vm9JVitiWU1BSkVvd2hR?=
 =?utf-8?B?Qnk0WHhCMmlLVVRjYUtkTC9VdER0THdycjZoeVZWdFFEdjNjUXdHR3NoYkJK?=
 =?utf-8?B?aTdLZDNEaHZZYlFtcllDNU9QRlF6TnNPeFdhbHZ1MHUvZnBxUFlYRHM2aWNU?=
 =?utf-8?B?YjJOQllHcU11cXVtekFyb0FweVNSYTBxVndndHBkYzJJU1gyVWEycExSeW9s?=
 =?utf-8?B?L2d2ajVBUGpBb21Uc1RCYjJvUHVmQklIcUFnR1hQVzVHbjhQZ2xGbHFvaDdL?=
 =?utf-8?B?czlLMzFLaS9uQVlSYnZja1JpMkJ0aVp2M0hFZ1U5SURXdG9XQk5WSGJISG1s?=
 =?utf-8?B?bTVKWjZBRkxJbmthRzk0b29zZ3VTNUwwUlY5aDNPaUlNZ3phUWdVUks2c2ho?=
 =?utf-8?B?Rlo5NU9ZdklROTFhN0YyVW9Demd2dE1JbE5iTVRZNVRuMGpWNS9SelJvUThD?=
 =?utf-8?Q?DMj//+aD4OEBWvhrB2zjsm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bffe32-119a-43e6-96d5-08d9ecafa25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:08:53.5510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGEwmKH9/bQW0AqjLDdEjn3R46CnztMMZFmi2MBaGgy3XkTO87Gh8LI2sW0TTDpJ8heCc/1CwJXGIF/Zq3TmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiA+IFZHIGRvZXNuJ3QgZG8gczBpMyByaWdodD8NCj4gDQo+IFJpZ2h0Lg0K
PiANCj4gPiBObywgWUMgc2hvdWxkIG5vdCB0YWtlIGEgc2ltaWxhciBmaXguICAgIFlDIGhhZCBh
biBhcmNoaXRlY3R1cmFsIGNoYW5nZSBhbmQgdG8NCj4gPiBhdm9pZCBhICJzaW1pbGFyIiBwcm9i
bGVtIHRha2VzDQo+IDI2ZGI3MDZhNmQ3N2I5ZTE4NGZlYjExNzI1ZTk3ZTUzYjdhODk1MTkuDQo+
IA0KPiBJc24ndCB0aGF0IGxpa2VseSBqdXN0IGEgd29ya2Fyb3VuZCBmb3IgdGhlIHNhbWUgaXNz
dWU/ICBUaGlzIHNlZW1zIGNsZWFuZXIuDQo+IA0KDQpUaGUgU01VIGRvZXNuJ3QgaGFuZGxlIHRo
ZSByZXN0b3JlIG9mIHRoZSBTRE1BIHJlZ2lzdGVycyBmb3IgWUMgdGhvdWdoLCB0aGlzDQpleHBs
aWNpdGx5IGNoYW5nZWQuICBTbyBJIGRvbid0IGJlbGlldmUgd2UgY2FuIGRvIGFuIGlkZW50aWNh
bCBmaXggdGhlcmUuDQoNCkBMaWFuZywgUHJpa2UgY29tbWVudHM/DQo=
