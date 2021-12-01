Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1751C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 02:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680446E0F0;
	Wed,  1 Dec 2021 02:48:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCAE56E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 02:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpiUeloLGWDz8tsPUdvKc9eKGZOiRJEPsM4CGpxkDji/4+ZZha64xO8o08cK0MxAp51IqLwCt28o2PZTVgMAqG/gD983BhozwTYSZswEjyVgVmcKcsiebUJeA1MjTD5BOZtReXPEKjyvG39OJ2XihJI878CYU4cOchH4vuSngvci9iInNERS3dnemCVzKCuJgzGGZMlp4DttjU/LTJs+sWTlG5+I7so3kPBcHN9Ncdg3GXo7Y8XEdx8fBfh4I3GVOxmmk3nW6yRI2CJV+Xy2sJwnf/GyKPwQORvlvzSOseMKA9655UeKgkEs0S2oGvi5DqSpFLjDet4EPU6pFhdMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo9GFyxh9i2z4jqhcGUTJwwSf1isyty4bgWS6XZWe8Y=;
 b=EVDHjww55ha8HkXiaGVu9rRs+7Y77hXJx4yTFHSgEomjS1JMiif3sIHYbL8EN8aleVxE6rBq46AxFnOfph0buTx+zj71raG6jEhnGydtn6mBULmvBiWvlvrll1e89gJphIgOhxgBfjmyENuYeHQ+vVwTBmfIqvuQxk9ygRh2UbRd9OdujA6IdAf2IGjoacZXfmLmQ4QD3dIwsqMTMN+ZD/mv3gOHqRe8UCy3NO+8lranSlpusC1fE/83peIWbn0bZ7vqJgXVBAF601TEV0Q+oguHLqfNk9Wn70gDXCuFasRkc9uBbxffVxQDM2Hovqq2q395pjvQqqb4vr0he4AT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo9GFyxh9i2z4jqhcGUTJwwSf1isyty4bgWS6XZWe8Y=;
 b=gYzj8r5D62Sq8/MNFCbnEnNtkoaONpTIqbxVUB0MTmfe0aWe7yIs/CM6pNa+nHyS0otVopRwXCi40L70TKl6LXd26ewBi3if+BO+iXDVNUgdr8+0kCCaAWjB/LNjhnKA0BFF8+2pCV7tUV8aQt6lfoBOAZeqaMdiB5qSO0jiPR4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Wed, 1 Dec 2021 02:47:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.011; Wed, 1 Dec 2021
 02:47:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 06/17] drm/amd/pm: do not expose the API used
 internally only in kv_dpm.c
Thread-Topic: [PATCH V2 06/17] drm/amd/pm: do not expose the API used
 internally only in kv_dpm.c
Thread-Index: AQHX5b38eZKdV+MKeEeCK35x/bGyGawb/90AgADv0RA=
Date: Wed, 1 Dec 2021 02:47:58 +0000
Message-ID: <DM6PR12MB261919478DDB2219CFED15D2E4689@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-7-evan.quan@amd.com>
 <4a7fecc8-5c09-b0cd-ffee-2141aef9df05@amd.com>
In-Reply-To: <4a7fecc8-5c09-b0cd-ffee-2141aef9df05@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T02:47:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=13e1f7f7-cf35-4bce-b943-d4caecc0e7e7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f255a94f-2445-41bc-bc2b-08d9b474fc25
x-ms-traffictypediagnostic: DM6PR12MB4337:
x-microsoft-antispam-prvs: <DM6PR12MB4337D0A8D559DF4B4ECC0737E4689@DM6PR12MB4337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzNYfa7BTb+osyS8Q8NG1+gS9Js07u3HVnIxWZwElJ1sB+NNaVu0hw+dgib4dFE2JBAQNxyiOghpKHwegZVDfaJMqGTiIdpD+Wa/cHj4//fwLKApAtcejA9QiXwhEF64jVfPDmSOSatUTevizOv5jBtuK5PAL0kpKnV0sGNK9y7QFKaemaddy5VlTufN6CofiHgByLVbxrtUFNMhLb+/Y4te68S9+o4/GWXWVxsYJdFBOy3NQ8nYLKyavSlobKTzo0VP0oSroOVf39xNB7AHPMrlJfJE2ebCXz9nSEs2anP2dBo++4lVomk/Gum790unAGWkH+F3uf59gUBa92PeozeoqznDdZQSxa8z6UbAnZCtsOZtT6DaalyQHVCa8Ykmf8vmitY+MddXDqFCAsQgHRHIW+vWP8OVkA4JMCVz0aApcIh0etintlAxTGYDcOZhYEdzB2hgk6JkxVLxMe0ToDUv/y8sSjfk5nwWMn7+b/iKlFpAqfmOll9T3RCb6QbW+L3cwU5UFVVYJvk+fbgU5PWcEo4bvT1o1NggeoS574gpU0+/ZnieDQ5BJRZ9MDjEkKfr04JEbmDS7k+Psq7GXa66YreR7MHglAGxjqS2MdJw/figAm92L+6noO+Hvh8XFhoEj07xWlRCCdiFUTEjBPi9wEGRkBxyO4LnkKAKt3olDotVJcHjDaxGpP9exVBsRv+eg2YaV0wWdrc8x5XUsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66946007)(54906003)(86362001)(110136005)(66446008)(76116006)(66556008)(122000001)(64756008)(38100700002)(186003)(316002)(53546011)(71200400001)(6506007)(2906002)(7696005)(5660300002)(83380400001)(38070700005)(33656002)(8936002)(55016003)(9686003)(26005)(52536014)(508600001)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THR4MC8wd3d6cVFFbGt0NWx0T245N2FuTFF1eE5BZ3U0akxZWmtZcmRVM1dq?=
 =?utf-8?B?dGNhMTN3Q0tONDF3WFN3R3NFakRlRnUvZ2JweWF0TStPY2JySndnUmk2eHhE?=
 =?utf-8?B?OEhOcmdxeW9rK2tuOFBOeVpwU2RDYlJaUVgwUlpnbDRJck9vY3YrSDdLbzVl?=
 =?utf-8?B?dHhxVTBWWXRqQUlJTGQ1Y29RMzJOT3kvUTNWM0VwNS9WV0tlTkNXWXdTRHMr?=
 =?utf-8?B?ZnRzc1czdWs0Wjh3ZGYxSFcwTE4zNXdGSEFVbDBSRmRENTd6djZuOW9TOEdK?=
 =?utf-8?B?aXhLNllvUERTYktlY3pZUTJkUzF0ZGVUNk1zUEdYTmJObklEaFVWMHNjNGp2?=
 =?utf-8?B?V0RHMkc5NG9zZHM0cG5EMkdUeWluNDZHNS9wTEFvNXh0WFhVc3kvOUNWdXlx?=
 =?utf-8?B?K3lmOGpTOTJYQ3BIWFBlUlRVaXhMR1NjQVRjREFwN2RHUkpWWUFGUE1sRjND?=
 =?utf-8?B?aUJQdDFUMmdvU2hsNkZ6TklqSnVNR1RZdGJRc1ZjMTFkNXZ1Z2Z2QWZ6Vm1W?=
 =?utf-8?B?OW5YbWdmYWZkUnRSdHRzU2ZWSEduY1JKdFlqVVIzdmEvb0t0NG5KSEd2QmFj?=
 =?utf-8?B?SFR0NEQxTDhXaTV2dVdLTUtxZHcrK3UxYXovS3VQMGpmWVNBQ1UzcXRMUGRL?=
 =?utf-8?B?a1IycGllU3h3SVRhNUR3MVdSNEZlVnJtTm1XT2JMUnE2dXJLSjNzem9QbnJX?=
 =?utf-8?B?VzVVY1YrNkY3Z1BsTlB3dldVUEZ1aG5ISXFzZFpwcHNobmt5OSsyOFNiNVB6?=
 =?utf-8?B?alFDU0p4cU5DdlZUMFRYd0JYS20ybmt3a0JleWRYMVYyWStTSHR6MjdkVk5N?=
 =?utf-8?B?c29LQzVOc1U5cDlncThPMlB3MDl1SFdjL2o2NmNwV1NBT2JPWU5XOFgwQ2lp?=
 =?utf-8?B?d2N6VFp5QmtFdVJldE5sdzdEanRqaEREQ3Y4ZUVxVUk1KzNxWTFmM0hqNkty?=
 =?utf-8?B?U0s2RzVzT1U0aVRrcW5pTzgreFJ5YXJPUTBFdVhZQy9FdzYreWh4NGgwazFO?=
 =?utf-8?B?dTdOaC9tUGRIRmNjbFNXN0kzN3ZJYzU2MVpoM2dRSmRsYks2MEZQQjFNQ3Nr?=
 =?utf-8?B?K1RZSTRmZmlPYW5XbWRraUtoc1JLUGxmUXAvaGM5dnp3eFVEcmdvNWpXUnJR?=
 =?utf-8?B?QXFPdE1jcjFnRVRiNWFkVjJ1WWVoZ0lDVGRxUStrS1BsVndOamgvRDBwM0RN?=
 =?utf-8?B?YjRVMFpxNzNmZnk5ak9UeE9WSjVCZDVZS2RZbDJCUkRRblpiM04wZjlOWVdp?=
 =?utf-8?B?ckNnMjlsRm0ybkl4bXdQUS8yREtPTUIyaGRnM1p6RHRvSFhSMjBOK2lNbzAv?=
 =?utf-8?B?bGlHeE5oUGVkZkltbThlRXhSb0NDZmFWTHQvY1BsWU44ZkxJYzNWQlk1Mks0?=
 =?utf-8?B?SjR2WDBHOHEySllsQUFlc2hlczNSWmJqaFkyb1BWMkx0dDhUbHdCbHdWMDlM?=
 =?utf-8?B?eEVkcXg2US85ODdDdUpVVmVaMmV2V3dvWktNT0tJZHRFVnZrUUJpRGFScGVu?=
 =?utf-8?B?clRsYnV4U2pmOTNibFZ4VUhqRC9GanJlVjA2NmVGQ0tXZUdKTVRVVWhFK3or?=
 =?utf-8?B?Tkw5bmZMK1pFM3U5c1NlQnhVTXZIR3ZaYkIycUpiZk1EM0JtdURTOXFaTURE?=
 =?utf-8?B?Z0hHdWo0TE9PSHhLZ0tXZmMvYjFVdUVES2NJRGRIQUFXNks5dlBiTE9YZlJj?=
 =?utf-8?B?UlA4Tjk1a3JVS0hPOEZkOUtGdDE4WW9TaU9ROGljdzZocm9telRMbC8rRnhX?=
 =?utf-8?B?ZCtXb1ViczZkYmZvUHBTZDVZaWE4VFFoTkhnVjlTeEZhZ25iY3NnUEN4OWRh?=
 =?utf-8?B?V0lveEpZVmV6QXZLTFRWVTJ6MlFBSTJCVjhwMHQ5N1FPdWYySUFpRmdjOHR6?=
 =?utf-8?B?TFl0YVFoRGhWOENVOU1hUCtzSkg4R0NIa0pxdFhLTUlDN3pyT1JrSEI5cVp1?=
 =?utf-8?B?WDhoZlErc1k1T0NwU3NYM0VLeFlaSjkxUWpHa0Rrc2hWcW04RWZvOENpR2c4?=
 =?utf-8?B?WjNTMUR0S2F6V2hTWHFGWVlpNUZLdkMrR2RJV3hIL0pZSlp3MGZqdUZkbVhV?=
 =?utf-8?B?dzJJanR3RE54TFBxeXZOZGdoUkZYYk1FQkd5WWFsOTl1MGlnbFdMdWhHU0xV?=
 =?utf-8?Q?N5+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f255a94f-2445-41bc-bc2b-08d9b474fc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:47:58.7814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBknQgb/u2ypnLPwtQj74Q9b+1IEIMNHyF+bNws5zu4v3UOMzMKdJmaex41dEQZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mDQo+IExhemFyLCBMaWpvDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDMwLCAyMDIxIDg6MjggUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGgNCj4gPEtlbm5ldGguRmVu
Z0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAwNi8xN10gZHJtL2FtZC9wbTogZG8gbm90IGV4cG9z
ZSB0aGUgQVBJIHVzZWQNCj4gaW50ZXJuYWxseSBvbmx5IGluIGt2X2RwbS5jDQo+IA0KPiANCj4g
DQo+IE9uIDExLzMwLzIwMjEgMToxMiBQTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IE1vdmUgaXQg
dG8ga3ZfZHBtLmMgaW5zdGVhZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8
ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJNTU0MzMyYjM4NjQ5MWE3OWI3OTEz
ZjcyNzg2ZjFlMmNiMWY4MTY1Yg0KPiA+IC0tDQo+ID4gdjEtPnYyOg0KPiA+ICAgIC0gcmVuYW1l
IHRoZSBBUEkgd2l0aCAia3ZfIiBwcmVmaXgoQWxleCkNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jICAgICAgIHwgMjMgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmggICB8ICAy
IC0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9rdl9kcG0uYyB8IDI1
DQo+ICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2FtZGdwdV9kcG0uYw0KPiA+IGluZGV4IGZiZmMwN2E4MzEyMi4uZWNhZjAwODFiYzMxIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4gPiBAQCAtMjA5LDI5
ICsyMDksNiBAQCBzdGF0aWMgdTMyIGFtZGdwdV9kcG1fZ2V0X3ZyZWZyZXNoKHN0cnVjdA0KPiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgCXJldHVybiB2cmVmcmVzaDsNCj4gPiAgIH0NCj4g
Pg0KPiA+IC1ib29sIGFtZGdwdV9pc19pbnRlcm5hbF90aGVybWFsX3NlbnNvcihlbnVtDQo+IGFt
ZGdwdV9pbnRfdGhlcm1hbF90eXBlDQo+ID4gc2Vuc29yKSAtew0KPiA+IC0Jc3dpdGNoIChzZW5z
b3IpIHsNCj4gPiAtCWNhc2UgVEhFUk1BTF9UWVBFX1JWNlhYOg0KPiA+IC0JY2FzZSBUSEVSTUFM
X1RZUEVfUlY3NzA6DQo+ID4gLQljYXNlIFRIRVJNQUxfVFlQRV9FVkVSR1JFRU46DQo+ID4gLQlj
YXNlIFRIRVJNQUxfVFlQRV9TVU1POg0KPiA+IC0JY2FzZSBUSEVSTUFMX1RZUEVfTkk6DQo+ID4g
LQljYXNlIFRIRVJNQUxfVFlQRV9TSToNCj4gPiAtCWNhc2UgVEhFUk1BTF9UWVBFX0NJOg0KPiA+
IC0JY2FzZSBUSEVSTUFMX1RZUEVfS1Y6DQo+ID4gLQkJcmV0dXJuIHRydWU7DQo+ID4gLQljYXNl
IFRIRVJNQUxfVFlQRV9BRFQ3NDczX1dJVEhfSU5URVJOQUw6DQo+ID4gLQljYXNlIFRIRVJNQUxf
VFlQRV9FTUMyMTAzX1dJVEhfSU5URVJOQUw6DQo+ID4gLQkJcmV0dXJuIGZhbHNlOyAvKiBuZWVk
IHNwZWNpYWwgaGFuZGxpbmcgKi8NCj4gPiAtCWNhc2UgVEhFUk1BTF9UWVBFX05PTkU6DQo+ID4g
LQljYXNlIFRIRVJNQUxfVFlQRV9FWFRFUk5BTDoNCj4gPiAtCWNhc2UgVEhFUk1BTF9UWVBFX0VY
VEVSTkFMX0dQSU86DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCXJldHVybiBmYWxzZTsNCj4gPiAt
CX0NCj4gPiAtfQ0KPiA+IC0NCj4gPiAgIHVuaW9uIHBvd2VyX2luZm8gew0KPiA+ICAgCXN0cnVj
dCBfQVRPTV9QT1dFUlBMQVlfSU5GTyBpbmZvOw0KPiA+ICAgCXN0cnVjdCBfQVRPTV9QT1dFUlBM
QVlfSU5GT19WMiBpbmZvXzI7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vaW5jL2FtZGdwdV9kcG0uaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1k
Z3B1X2RwbS5oDQo+ID4gaW5kZXggZjQzYjk2ZGZlOWQ4Li4wMTEyMGIzMDI1OTAgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oDQo+ID4gQEAgLTM3NCw4
ICszNzQsNiBAQCB1MzIgYW1kZ3B1X2RwbV9nZXRfdmJsYW5rX3RpbWUoc3RydWN0DQo+IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOw0KPiA+ICAgaW50IGFtZGdwdV9kcG1fcmVhZF9zZW5zb3Ioc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGVudW0NCj4gYW1kX3BwX3NlbnNvcnMgc2Vuc29yLA0KPiA+
ICAgCQkJICAgdm9pZCAqZGF0YSwgdWludDMyX3QgKnNpemUpOw0KPiA+DQo+ID4gLWJvb2wgYW1k
Z3B1X2lzX2ludGVybmFsX3RoZXJtYWxfc2Vuc29yKGVudW0NCj4gYW1kZ3B1X2ludF90aGVybWFs
X3R5cGUNCj4gPiBzZW5zb3IpOw0KPiA+IC0NCj4gPiAgIGludCBhbWRncHVfZ2V0X3BsYXRmb3Jt
X2NhcHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiA+DQo+ID4gICBpbnQgYW1kZ3B1
X3BhcnNlX2V4dGVuZGVkX3Bvd2VyX3RhYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBt
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2t2X2RwbS5jDQo+ID4g
aW5kZXggYmNhZTQyY2VmMzc0Li4zODBhNTMzNmM3NGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9rdl9kcG0uYw0KPiA+IEBAIC0xMjU2LDYgKzEyNTYsMjkg
QEAgc3RhdGljIHZvaWQga3ZfZHBtX2VuYWJsZV9iYXBtKHZvaWQgKmhhbmRsZSwNCj4gYm9vbCBl
bmFibGUpDQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIGt2X2lzX2lu
dGVybmFsX3RoZXJtYWxfc2Vuc29yKGVudW0NCj4gPiArYW1kZ3B1X2ludF90aGVybWFsX3R5cGUg
c2Vuc29yKSB7DQo+ID4gKwlzd2l0Y2ggKHNlbnNvcikgew0KPiA+ICsJY2FzZSBUSEVSTUFMX1RZ
UEVfUlY2WFg6DQo+ID4gKwljYXNlIFRIRVJNQUxfVFlQRV9SVjc3MDoNCj4gPiArCWNhc2UgVEhF
Uk1BTF9UWVBFX0VWRVJHUkVFTjoNCj4gPiArCWNhc2UgVEhFUk1BTF9UWVBFX1NVTU86DQo+ID4g
KwljYXNlIFRIRVJNQUxfVFlQRV9OSToNCj4gPiArCWNhc2UgVEhFUk1BTF9UWVBFX1NJOg0KPiA+
ICsJY2FzZSBUSEVSTUFMX1RZUEVfQ0k6DQo+ID4gKwljYXNlIFRIRVJNQUxfVFlQRV9LVjoNCj4g
PiArCQlyZXR1cm4gdHJ1ZTsNCj4gPiArCWNhc2UgVEhFUk1BTF9UWVBFX0FEVDc0NzNfV0lUSF9J
TlRFUk5BTDoNCj4gPiArCWNhc2UgVEhFUk1BTF9UWVBFX0VNQzIxMDNfV0lUSF9JTlRFUk5BTDoN
Cj4gPiArCQlyZXR1cm4gZmFsc2U7IC8qIG5lZWQgc3BlY2lhbCBoYW5kbGluZyAqLw0KPiA+ICsJ
Y2FzZSBUSEVSTUFMX1RZUEVfTk9ORToNCj4gPiArCWNhc2UgVEhFUk1BTF9UWVBFX0VYVEVSTkFM
Og0KPiA+ICsJY2FzZSBUSEVSTUFMX1RZUEVfRVhURVJOQUxfR1BJTzoNCj4gPiArCWRlZmF1bHQ6
DQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJfQ0KPiA+ICt9DQo+IA0KPiBBbGwgdGhlc2Ug
bmFtZXMgZG9uJ3QgbG9vayBsaWtlIEtWIHNwZWNpZmljLiBSZW1vdmUgdGhlIGZhbWlseSBzcGVj
aWZjIG9uZXMNCj4gbGlrZSBSViwgU0ksIE5JLCBDSSBldGMuLCBhbmQga2VlcCBLViBhbmQgdGhl
IGdlbmVyaWMgb25lcyBsaWtlDQo+IEdQSU8vRVhURVJOQUwvTk9ORS4gRG9uJ3Qgc2VlIGEgY2hh
bmNlIG9mIGV4dGVybmFsIGRpb2RlcyBiZWluZyB1c2VkIGZvcg0KPiBLVi4NCltRdWFuLCBFdmFu
XSBNYWtlIHNlbnNlLiBJIHdpbGwgY3JlYXRlIGFub3RoZXIgcGF0Y2ggdG8gZm9sbG93IHRoaXMu
DQpMZXQncyBrZWVwIG1pbmltdW0gY2hhbmdlIGhlcmUuDQoNClRoYW5rcywNCkV2YW4NCj4gDQo+
IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGt2X2RwbV9lbmFi
bGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGt2
X3Bvd2VyX2luZm8gKnBpID0ga3ZfZ2V0X3BpKGFkZXYpOyBAQCAtMTM1Miw3ICsxMzc1LDcNCj4g
QEANCj4gPiBzdGF0aWMgaW50IGt2X2RwbV9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ID4gICAJfQ0KPiA+DQo+ID4gICAJaWYgKGFkZXYtPmlycS5pbnN0YWxsZWQgJiYNCj4g
PiAtCSAgICBhbWRncHVfaXNfaW50ZXJuYWxfdGhlcm1hbF9zZW5zb3IoYWRldi0NCj4gPnBtLmlu
dF90aGVybWFsX3R5cGUpKSB7DQo+ID4gKwkgICAga3ZfaXNfaW50ZXJuYWxfdGhlcm1hbF9zZW5z
b3IoYWRldi0+cG0uaW50X3RoZXJtYWxfdHlwZSkpIHsNCj4gPiAgIAkJcmV0ID0ga3Zfc2V0X3Ro
ZXJtYWxfdGVtcGVyYXR1cmVfcmFuZ2UoYWRldiwNCj4gS1ZfVEVNUF9SQU5HRV9NSU4sIEtWX1RF
TVBfUkFOR0VfTUFYKTsNCj4gPiAgIAkJaWYgKHJldCkgew0KPiA+ICAgCQkJRFJNX0VSUk9SKCJr
dl9zZXRfdGhlcm1hbF90ZW1wZXJhdHVyZV9yYW5nZQ0KPiBmYWlsZWRcbiIpOw0KPiA+DQo=
