Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A160EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 04:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C916210E4D8;
	Thu, 27 Jul 2023 04:41:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D984B10E4D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 04:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbol3Mvu3Y4CI7WEUFJrKUeUoHDkYTNL4gYqerw4nOE8PfxbXZ03x0do25dHBGN5rso1iypaWaTnB71JXCReCGU8hiemmyneTm4qok1j2mDuUbUKkj4Kcu0s5Se+K/k2jU0wLX6PRaNUFwfvm+FEEkbV5EIm668h1W5KUeeovGdWJhQAMPHAzRF4D9AGdXkNFR0In1WDIkdg9l2uXhNNr2X8dOLwOK2nwOQs0cwQ3t6W6YwXtFA93V7r66eHzGPDTHAZ15WTEg0SXPQyttI4i+4Krrka/tqHDgOwrRkSi/TemxD7xdyyizT6oprIerEV3edpfIfmpYwPNWcptJplBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYCAmhvUMXcwP92VUTX/V7BBHmPf0SV3jaKMfjZ1M0Y=;
 b=lLZK7/zo4vRBUhzT0Gp1nTn2hEm+a5kQgJRPDNmokj1+0L/36ghOgkt0av/WaC0KfJ+Vpdl8hlI6bAdFQipltaoIrcXRTJizQA1l9s0CVD09gX8ssR++LlYJrNYcpCXQGBni4sJw8Zd1/dgFl5cy9JFuzzItc+uoSjUjvqTEYlaHy7Oobp54/WQEQFImuk3/P45NezjD/S7cw+pYFgs/9FVhSujHSYl1mbsDwNz6NQB/zz5Q21A0klwtbLIz5nPvBu3oijDmHxtzp8bcOE7a+Rz/cVcv/3KVnYor/CYFhnrq4v86kY1ODxYbpuZUooRW0BdJ2Ix2MqKMU/MhiaMn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYCAmhvUMXcwP92VUTX/V7BBHmPf0SV3jaKMfjZ1M0Y=;
 b=pLRLqi9CENqHwldzWYrPXX4YMoyh3jnKHrk+WQ7MtkHXM80+kFNwm/n7hzRZCQCrEeEBAuOGZFAMJainK4lezwEqAKow7EarhrjqREyENb1xfVCKuAiMwmcgyYBazPKjjWiFb7RWcuCc2e9f1zDG14p/v7Gh7brKaRIuNo5f4FQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 04:41:03 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 04:41:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Swarnakar, Praful" <Praful.Swarnakar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix style issues in amdgpu_psp.c
Thread-Topic: [PATCH] drm/amdgpu: Fix style issues in amdgpu_psp.c
Thread-Index: AQHZwD3qPQuI7VnAg0q1V54PZH+4a6/NCISQ
Date: Thu, 27 Jul 2023 04:41:02 +0000
Message-ID: <DM5PR12MB2469FF180E3DE858376E95B4F101A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230727034725.2323611-1-Praful.Swarnakar@amd.com>
In-Reply-To: <20230727034725.2323611-1-Praful.Swarnakar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1af74873-8c5f-42f0-bc81-21f154905aa0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-27T04:40:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MW6PR12MB8897:EE_
x-ms-office365-filtering-correlation-id: 4fe3d04f-8f7e-475b-3c7e-08db8e5baede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrJfY/MIEJUvHxLagjAO3vqV4Pnz1nGuOiZwXKXFJlZMdGVAi2TpicONvjF1Nx+fPsFer8VsU3MPsrDmo4x4VE8sOs/x9MMXxyYqyEoqtsAx8elCRw/6I0nyhIYHrO+v3zI+8QOZ4PZOg37ikUd9ivpyAoWUGZhdUhC/xyzknrnFFRyKUpAHtKmilrvH6lyPUE/HRRppciQc5RWTT+4bFG1xrPO1SdhULyU9aAT+Rejd5Q9DtJC+YUtrYFYFXa2d714cOgbgeyOZr89pDZdesuilL3n9/gjrVouso2ohjerLadNX21hfcO9MNZs08tt1lS6eCmvFe+RH4gRf4spcORlm07fQknuFFYXXQ0yf5Fj4o+Rn4sATGwR6nb7Me/WGprCucKeFNCInL6YTYoBz1uvlSYAdHsULG23+ng8pH9OivbLWlQdK68Cv5aYqu0m226oLRCJmlFvAc/zTgW661y+CvFoDbFM8pMaw6V7h5j+MlBQBPSHX3+c27yjySNKslq/8vH2yZqnqsrRhbHkMBgMCEzawhQlhlew1FxiwLNWZ8XLUzweOJLW9mOmVomLJKq2pMou3rEqm5Rd6rwCr0vuxJAKPAYb37J1MbmQdWXyjcajTWFFXERp1EWDVaOlI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(2906002)(122000001)(478600001)(7696005)(76116006)(71200400001)(66476007)(4326008)(66446008)(38070700005)(66556008)(66946007)(64756008)(6636002)(110136005)(316002)(55016003)(38100700002)(8676002)(33656002)(5660300002)(86362001)(186003)(83380400001)(53546011)(26005)(6506007)(52536014)(8936002)(66574015)(41300700001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpSZGw5UWtsSXRJU1BwUGR2YkVHN1VQdzczVnVXeEY0ZXh5VGFxZXNDQndx?=
 =?utf-8?B?am1YNUVwaElxTDMyd2t6bVVmbW5DRFBDazJMblZYeW9hSmJoVHpmaXExeFVn?=
 =?utf-8?B?cWE4RldKbFVjNjN2Vm14dTQ0emczQWNrVVNaM1VUaVkvUFJHZEI5bCtMRnRB?=
 =?utf-8?B?eHNzZFFvZTFvSnQyUWMzMG5IcDNGUm4zYklZbEFiRzZJVHlxbk9LRVIrdXJq?=
 =?utf-8?B?WFRJVG1TREZvNDdVNkQ3Y2tPd1h5M1V0M3plOFBsZHpML0xiMkJGSFMyTmVj?=
 =?utf-8?B?OG5EbGs4RHlINUl2c0JSVjAwV2JrL05GN0lwMkVPblo0YkZJNDNRVElSRnIv?=
 =?utf-8?B?WExZMk1UaEtxVkVEdE1INmwrQmNhZDJZU2hsZ28wRkQ0MHU1OC9YY3hsNit2?=
 =?utf-8?B?RU04RFdQblVJdElCRUFBZTAyT1lKU3JSWUpUWjg2TWUvL1lHdk92S3pqVmF2?=
 =?utf-8?B?NHhWc1d4aW4yWDVUNkVvV0NDSU1CdkhVVFlTbXQ2MlJ5Y0Y1SjNhQWxmeTY1?=
 =?utf-8?B?ZXRKOTBXMGpkcGNNWmFXQUwrbGtxdGpkUkVaOEI0QTEwN3RCMFR2M1lFWVZN?=
 =?utf-8?B?NDRyZ2ZXRnpuN2NOTCtlZjlMSEpvaDc2YUpoMVVtU21mYVFZVko0SmJBdFFT?=
 =?utf-8?B?VThWMUtXZkZ3SHV1ckIrbHdEalVGbUlPSi9NNXhWNmdHMkVYRVJ6aEc2K0dL?=
 =?utf-8?B?eUlzYVVGUlNiTlpXcXRiYXdvOXIvN25manhSRFVUVUNEV1RvVkdnMnVsNUx0?=
 =?utf-8?B?UDkxR3RSTEJOZ0R6dzZlTFAzMTgzcUR1aFBDblZleWtLTGdaZkZnU1FyZGVO?=
 =?utf-8?B?cEhIQjR3YkFWb2F1WlJBZWVTaUlsRGE2cUlHZnpUOW5SVFdlRlM5K1lhZlRX?=
 =?utf-8?B?QkZNVkdQZUo3aFdtTWsyYWdWQ0NzVDVWbHZOZzFYcGpMY1U3dWhwWG04Qk9T?=
 =?utf-8?B?N1k0ZTg2c0g3cEFVTVI3RnRNTnFLckxnWW94eU8za1dvWUdhWE9CWGpyWXFG?=
 =?utf-8?B?L0NVaDROcjl3TlJxYU5lcEZxQytsRFdjUTREOWdpYlpMdnkxNnRVRUtBUHpk?=
 =?utf-8?B?NUlHVXVxaXdDN1ozdWx1TjhvWUVNV2MvVHBGM2Jxdmx1M1FVSHVIRTdvYkxw?=
 =?utf-8?B?WjJSNzhTNDdPMVRkTlliZFVGOUY2N21mVmhOSjFNZlZlRnNjeTVBVFNJaHYv?=
 =?utf-8?B?ejBtSCt4REFMWUFGUzFvNmNGZmxYY2c5RFNSandDM1hGS2lFZTM1Nk5XWDdK?=
 =?utf-8?B?cGp0QUtPb3lKaVRGaW9JMmdaTEVEOHk4dzNuZUNTcFBxcVlUZldsdHcvb1po?=
 =?utf-8?B?eFRXMnYwYjBTNmlPeGE3SWVjMXl5a051WExJQmlIZUVsNXJ4UXNPcU95dTVT?=
 =?utf-8?B?ZHlRbitNNnc4UWE2SzIrQ0diNlVCNjE4VnQ1SHI3WTFVeFNmTzRXYm5PcWhP?=
 =?utf-8?B?T1o5emZiMjZzblpQcnRkMzhmYUFXZldodFJPa2doR3paWG5nL25nREtFZFhO?=
 =?utf-8?B?RUJFallxdEpLTEtwY1hGREl2b3lKMzkrNzE2bkNvWitxeExCczRRbm92WHJY?=
 =?utf-8?B?S3FzNkc2YklmcEMzN05QTDdtK3Q1VmJQZ2hYWm55Vm9sM3lkMlNPbEtqd1dM?=
 =?utf-8?B?TVJ3NVZWd1BhQ3R2TkxCTUR0eWo0THNHMzNVOG9kWXIrQTR4b1RiRlMybmt6?=
 =?utf-8?B?dmNDSk1JcGg0UnJYTnJnb05lbkIzK1RPTThQYVhGUWFQckh3UVF0OG5OYW9a?=
 =?utf-8?B?VzV5RUZjSnp3ZmVWbllMMVVXWC9kSEdZemRGRUVWN0xPZFIzRkE0WmMwZTBV?=
 =?utf-8?B?VUZScU1yNGV2MjZqK2c1Y2NBdHQzNnBLQmlyS2JFbjcwYml1THZBSmZLL2ZE?=
 =?utf-8?B?b2w4TEZoOTQ3Rno5b0lYRjZ6Tm5sa2dEbHd3Q3RUTmJLUy9VcUgyYWE4dFhC?=
 =?utf-8?B?N3NKdFdVYzB2aTF5bzFtaUh4M0RqSkIvNEp5eWRDb0MwZ3dSbEhtRExuVzk3?=
 =?utf-8?B?blBpKy9rdWlqM0ZPZ2Z3ODBnZXFvOWZyYjVPckFicHRvMzd5U3RTaytsQzBl?=
 =?utf-8?B?Sytyb2taNEQwcThDbjFONXdmZVpZcTZrWko2Zmo4Z0lsTUdNTUgxbThEVW5l?=
 =?utf-8?Q?Tdig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe3d04f-8f7e-475b-3c7e-08db8e5baede
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 04:41:02.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAsuNye9/ZpFpQ7Ar4LfjiMIzIXn7VxK8W7kmuehUA/KNhSeQEEzoND7VdiMeYiIXZaOF84vUjSKeYOd67Stbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU3dhcm5ha2FyLCBQcmFmdWwgPFByYWZ1bC5Td2FybmFrYXJAYW1kLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEp1bHkgMjcsIDIwMjMgMTE6NDcgQU0NCj4gVG86IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU3dhcm5ha2FyLCBQcmFm
dWwNCj4gPFByYWZ1bC5Td2FybmFrYXJAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kZ3B1OiBGaXggc3R5bGUgaXNzdWVzIGluIGFtZGdwdV9wc3AuYw0KPg0KPiBGaXhlcyB0aGUg
Zm9sbG93aW5nIHRvIGFsaWduIHRvIGxpbnV4IGNvZGluZyBzdHlsZToNCj4NCj4gV0FSTklORzog
QmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcgKi8gb24gYSBzZXBhcmF0ZSBsaW5lDQo+IFdB
Uk5JTkc6IEJsb2NrIGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxpbmUNCj4N
Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IEd1Y2h1biBD
aGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFmdWwgU3dhcm5h
a2FyIDxQcmFmdWwuU3dhcm5ha2FyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0NCj4g
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBpbmRleCA0
ZTQyODA2MGExZmEuLjFkMDUxNmU5MDRiMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYw0KPiBAQCAtNDM4LDE0ICs0MzgsMTUgQEAgc3RhdGljIGludCBwc3Bf
c3dfaW5pdCh2b2lkICpoYW5kbGUpDQo+ICAgICAgICAgICAgICAgICAgICAgICAvKiBJZiBwc3Ag
cnVudGltZSBkYXRhYmFzZSBleGlzdHMsIHRoZW4NCj4gICAgICAgICAgICAgICAgICAgICAgICAq
IG9ubHkgZW5hYmxlIHR3byBzdGFnZSBtZW1vcnkgdHJhaW5pbmcNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAqIHdoZW4gVFdPX1NUQUdFX0RSQU1fVFJBSU5JTkcgYml0IGlzIHNldA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICogaW4gcnVudGltZSBkYXRhYmFzZSAqLw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICogaW4gcnVudGltZSBkYXRhYmFzZQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICovDQo+ICAgICAgICAgICAgICAgICAgICAgICBtZW1fdHJhaW5pbmdfY3R4LT5lbmFibGVf
bWVtX3RyYWluaW5nID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICB9DQo+DQo+ICAgICAgIH0gZWxz
ZSB7DQo+IC0gICAgICAgICAgICAgLyogSWYgcHNwIHJ1bnRpbWUgZGF0YWJhc2UgZG9lc24ndCBl
eGlzdCBvcg0KPiAtICAgICAgICAgICAgICAqIGlzIGludmFsaWQsIGZvcmNlIGVuYWJsZSB0d28g
c3RhZ2UgbWVtb3J5DQo+IC0gICAgICAgICAgICAgICogdHJhaW5pbmcgKi8NCj4gKyAgICAgICAg
ICAgICAvKiBJZiBwc3AgcnVudGltZSBkYXRhYmFzZSBkb2Vzbid0IGV4aXN0IG9yIGlzDQo+ICsg
ICAgICAgICAgICAgICogaW52YWxpZCwgZm9yY2UgZW5hYmxlIHR3byBzdGFnZSBtZW1vcnkgdHJh
aW5pbmcNCj4gKyAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICBtZW1fdHJhaW5pbmdf
Y3R4LT5lbmFibGVfbWVtX3RyYWluaW5nID0gdHJ1ZTsNCj4gICAgICAgfQ0KPg0KPiBAQCAtNzk3
LDcgKzc5OCw4IEBAIHN0YXRpYyBpbnQgcHNwX3Rtcl9pbml0KHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQ0KPiAgICAgICB0bXJfc2l6ZSA9IFBTUF9UTVJfU0laRShwc3AtPmFkZXYpOw0KPg0KPiAg
ICAgICAvKiBGb3IgQVNJQ3Mgc3VwcG9ydCBSTEMgYXV0b2xvYWQsIHBzcCB3aWxsIHBhcnNlIHRo
ZSB0b2MNCj4gLSAgICAgICogYW5kIGNhbGN1bGF0ZSB0aGUgdG90YWwgc2l6ZSBvZiBUTVIgbmVl
ZGVkICovDQo+ICsgICAgICAqIGFuZCBjYWxjdWxhdGUgdGhlIHRvdGFsIHNpemUgb2YgVE1SIG5l
ZWRlZA0KPiArICAgICAgKi8NCj4gICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2
KSAmJg0KPiAgICAgICAgICAgcHNwLT50b2Muc3RhcnRfYWRkciAmJg0KPiAgICAgICAgICAgcHNw
LT50b2Muc2l6ZV9ieXRlcyAmJg0KPiBAQCAtMTEzNyw5ICsxMTM5LDkgQEAgaW50IHBzcF90YV9p
bml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0DQo+ICpwc3AsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHRhX21lbV9jb250ZXh0ICptZW1fY3R4KQ0KPiAg
ew0KPiAgICAgICAvKg0KPiAtICAgICAqIEFsbG9jYXRlIDE2ayBtZW1vcnkgYWxpZ25lZCB0byA0
ayBmcm9tIEZyYW1lIEJ1ZmZlciAobG9jYWwNCj4gLSAgICAgKiBwaHlzaWNhbCkgZm9yIHRhIHRv
IGhvc3QgbWVtb3J5DQo+IC0gICAgICovDQo+ICsgICAgICAqIEFsbG9jYXRlIDE2ayBtZW1vcnkg
YWxpZ25lZCB0byA0ayBmcm9tIEZyYW1lIEJ1ZmZlciAobG9jYWwNCj4gKyAgICAgICogcGh5c2lj
YWwpIGZvciB0YSB0byBob3N0IG1lbW9yeQ0KPiArICAgICAgKi8NCj4gICAgICAgcmV0dXJuIGFt
ZGdwdV9ib19jcmVhdGVfa2VybmVsKHBzcC0+YWRldiwgbWVtX2N0eC0NCj4gPnNoYXJlZF9tZW1f
c2l6ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpFLA0K
PiBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fR1RULA0KPiBAQCAtMTcyOCw3ICsxNzMwLDggQEAg
aW50IHBzcF9yYXNfdHJpZ2dlcl9lcnJvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwNCj4gICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4NCj4gICAgICAgLyogSWYgZXJyX2V2ZW50X2F0
aHViIG9jY3VycyBlcnJvciBpbmplY3Qgd2FzIHN1Y2Nlc3NmdWwsIGhvd2V2ZXINCj4gLSAgICAg
ICAgcmV0dXJuIHN0YXR1cyBmcm9tIFRBIGlzIG5vIGxvbmcgcmVsaWFibGUgKi8NCj4gKyAgICAg
ICogIHJldHVybiBzdGF0dXMgZnJvbSBUQSBpcyBubyBsb25nIHJlbGlhYmxlDQo+ICsgICAgICAq
Lw0KPiAgICAgICBpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQ0KPiAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPg0KPiBAQCAtMjU3Nyw3ICsyNTgwLDggQEAgc3RhdGljIGludCBwc3Bf
bG9hZF9ub25fcHNwX2Z3KHN0cnVjdA0KPiBwc3BfY29udGV4dCAqcHNwKQ0KPiAgICAgICAgICAg
ICAgICAgICAgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BMiB8fA0KPiAg
ICAgICAgICAgICAgICAgICAgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1B
MykpDQo+ICAgICAgICAgICAgICAgICAgICAgICAvKiBQU1Agb25seSByZWNlaXZlIG9uZSBTRE1B
IGZ3IGZvciBzaWVubmFfY2ljaGxpZCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAqIGFzIGFs
bCBmb3VyIHNkbWEgZncgYXJlIHNhbWUgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAqIGFz
IGFsbCBmb3VyIHNkbWEgZncgYXJlIHNhbWUNCj4gKyAgICAgICAgICAgICAgICAgICAgICAqLw0K
PiAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+DQo+ICAgICAgICAgICAgICAgcHNw
X3ByaW50X2Z3X2hkcihwc3AsIHVjb2RlKTsNCj4gQEAgLTI2NDIsOCArMjY0Niw4IEBAIHN0YXRp
YyBpbnQgcHNwX2xvYWRfZncoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ICAgICAg
ICAgICAgICAgaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHBzcF94Z21pX2luaXRpYWxpemUocHNwLCBmYWxz
ZSwgdHJ1ZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAvKiBXYXJuaW5nIHRoZSBYR01JIHNl
ZXNpb24gaW5pdGlhbGl6ZSBmYWlsdXJlDQo+IC0gICAgICAgICAgICAgICAgICAgICAqIEluc3Rl
YWQgb2Ygc3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRpb24NCj4gLSAgICAgICAgICAgICAgICAgICAg
ICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGlu
aXRpYWxpemF0aW9uDQo+ICsgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAg
ICAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9l
cnIocHNwLT5hZGV2LT5kZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIlhHTUk6IEZhaWxlZCB0byBpbml0aWFsaXplIFhHTUkNCj4gc2Vzc2lvblxuIik7DQo+IC0t
DQo+IDIuMjUuMQ0KDQo=
