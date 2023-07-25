Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E79C00528
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 20:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE23810E17B;
	Tue, 25 Jul 2023 20:04:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270C110E17B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 20:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZJzhlhLiuCdAOU7Mx2OevCBQ2FB1HjX479dH784/mk6zhkj33jlXG/k+jKDvL5g/wwjvf8+C/31UQSj56Zgi6Ubwxhj9eVFs4/jyM9C7B7ao6ubsVprF59vWj1+fQcQWsjjaBiJz2yxBmn43oCwwOQtryM6REVbGZOAbwUAbhXuJzwKIVSADxeDrtr8Figrp0a+lftz8CewHwa39dQYqLgeUfp9cR88PI8namRH2pWC/uaCDkUF7rEC9WyvdRgYMhr2LMaZIOsv6fJEI/73XFAn0sKD8ir2xu2WcSEC439TYaWc+p61kZ3jXrToa3cwFe92XgpLUYDv6g/BCiMh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgO8duMUgdECOZE0dVnzlubOiia1+RhitI37XVA4yoI=;
 b=EpRQ5VtWZBcHTLRJyvFALhEaO07ClAiluLEBwhu+7tzzHZ4jQYwk2g/8BkOn45/MybGoI1ySo03jreCIY4FhYSFSCcIkGcj4U9wU9ut2d0w9eDaMD3sOYefAM/76V2vjMMKZDesC6OSc/ftjgKqU2wo+P+/Ix01/TVqkYeWFy2rEITMRU7nXawQ2i8IvtMAB+XSKQQQagTmJPD0kVkRCd8gA4ekB6RqjLxfTBM1E1tYXFQpMf08ubCvGQrXrssL1rg9LiBSkey19qPq/M02LjTKWryts3UYG+AtFEIMtr/4wvkHAhCPXi3P3+WrklFvrZHTd548oRmKwwIZBt83Afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgO8duMUgdECOZE0dVnzlubOiia1+RhitI37XVA4yoI=;
 b=VD1ci3dQOfwoNFZGQESw7tMrJsj7fxV4Fj2hZUkS5T7tzMFajIMjQKBlaFioTnA+EkmNIOxn/0QfgvnfjdeXfZbT0p59U3B5ShtEvbDMYAbO+nC8cXxUOfvIAZfl7V09e/LttkPXVLRES06PrqAjZnZ1cjeZQDqDHDTzrUJWBz8=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:04:15 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::805c:7020:217d:6a8d]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::805c:7020:217d:6a8d%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:04:15 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Thread-Topic: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Thread-Index: AQHZvkebCvSis6lZtEKpSsrbHH/5Xq/JU84AgAF/CyA=
Date: Tue, 25 Jul 2023 20:04:15 +0000
Message-ID: <SN1PR12MB257513927F7396C5E57E7136E303A@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20230724155721.1974726-1-Ramesh.Errabolu@amd.com>
 <7d3bdae7-817b-79e0-a404-096ab089400e@amd.com>
In-Reply-To: <7d3bdae7-817b-79e0-a404-096ab089400e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=25a26016-ab52-435e-ad0c-c68d835aaac6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-25T18:42:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2575:EE_|CH2PR12MB4906:EE_
x-ms-office365-filtering-correlation-id: 46d40780-ec4c-4b57-ad1c-08db8d4a527d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziCSr33z04A7tF0w2CaOLwkt4PXIUZ6v+RdjlIpnT/7a98n0oq8XzJVCegpfOWzDHdENU7WsnmCYAh7kKOB+Y53tIglKJHeHX+sfe0OyJjN8UrY7sstLdBGdifgnST0NoE2KdkG1WsNEWxFJuE+Z3t6plgXG+HS1yaHDbWT4X7upOam6+DHwIAxY+w450rtJAt68PKFMqL+xCKjmhlZShZScF0fa1tzyQP+epihdnjqa+/DJl5neLOlvSwLCmELlvoNm6K9G362H4d7vM4hlqZArdDcDVCcnltRvhIuMWQ4oBOzd+RPdheNlAGJm9Bw4skntrfJk3hpjSfQE8/cXGdUtbgav248z8R1MVVHT3nYd8ZBdz5UWnQO0IjyVZLORSY5lwtC6GwfNNRmex9vycsGR6OH0whlQOEobwX7U2dTvxasdpDcimkVMOKoMCxR6SVqmmuG9hZ7DWxddcDhyePFTsuKqXs6ga5BQEKaxrEIZnf7ARW8SKb1i09Zx9QgnsaaQrhi/+1cfpTBll/gzGAYCf3prTiUrv8B5o8mgQizX9gKbbdu5HtayhhELV/qOnTteJrP96V7IlBy1Xho15nRaOaKdBrCTG1HIcnbzjvnce+oSRwGAUknERZOnTY+Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(122000001)(7696005)(478600001)(83380400001)(71200400001)(53546011)(26005)(9686003)(6506007)(64756008)(76116006)(110136005)(186003)(66476007)(66446008)(66946007)(66556008)(38100700002)(52536014)(8936002)(38070700005)(8676002)(2906002)(41300700001)(316002)(86362001)(55016003)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVBuK3pNVFZ4djVJRTd3S3BhS3FmUm5OMlhCenB1d2Y3cU0ydjNlaEFGU09I?=
 =?utf-8?B?ZkcvRnN2aUdwNWk1UGVwc1hMODF1WkNiYUxqM3VzQWFxUG10UzBpaXhlOVpD?=
 =?utf-8?B?SmtmK3RmeEdnL2QvQUl3N0JWMWU3UVpRM0VlL1NpZ05JejNDeEc4RXVNRFFu?=
 =?utf-8?B?WDBTTXo3d0YyTllxemprY1RFNmRZZjJITTBWeXhaWlh1MnpuakVvb1lUTkxY?=
 =?utf-8?B?Y1d4RXFEK2ZXdWNMYnQycVI0ZFpIbDVSQStNSDBVQkhuUWh5aXE3ZXZKTDZt?=
 =?utf-8?B?TzBaL3hRNkFQT0Z0ZTVOQzlpQnU4T2dMWS9iWEp3N2lBVWtZWk1RQTJiTldN?=
 =?utf-8?B?a3RkdjZ1WU9JMmhiWkVoUDI5RVpMdCt4L3RwQXN6ZmcwbFJVUWUxTHJZUnJW?=
 =?utf-8?B?NEh1SGs4MjMwbk9jM2l5eGdJbkFNcmFDV3ZZSEViZ1R2Yjd3TVVFb1daYWVp?=
 =?utf-8?B?eWozaWFoMjBOMFNsNHQ4RmE4UnV6dnNwdVJKcHVVTFpCV2MyUitFSEVDZ3Jq?=
 =?utf-8?B?ekZrVlczU1NmaDRSSXErY3RLMkRSWTNMS25qR3ZmMFBKRy9Ba0NkSnpOZ2pJ?=
 =?utf-8?B?ZGVibTJxL3JXampQQnZpQWl0aDh4Y1RFSldvNGZhTkRFdDNYUy9YS3RwN2Jj?=
 =?utf-8?B?anF0M2t1K29FQjNqM29oSFlPdzRTbSs5MGlKL3V3MDM3cDZkejZEclRJRi9t?=
 =?utf-8?B?SmhZSldhYzgzU0RYdEp6RFpkWUYwSGQrbkNTdUdxSGU3cjIzNGdLZjBiWjVp?=
 =?utf-8?B?R0d0ZkQ4czNCa3pZZjlRUG1rUEJyZlNSZ1A2dzZTU1QrcSsybXRuS1N5RTRJ?=
 =?utf-8?B?WXByREFJVUx1KzhmNEQxK0hTbG1FSEtLZnMyZFV6UkV1S0Z6N0tVdytlM2NI?=
 =?utf-8?B?QWU4MnloVmFvMUYrUnFmMFM3S2tXQVBndTFjOEJENGdncWNZcWJNWHVEQThi?=
 =?utf-8?B?am9BOFA2SHpwWFArZUg1VERsMWh3Nmo0OUZmeXNFUm9YbzJ2d0x6WlcrNzNu?=
 =?utf-8?B?Qmh1YW9UM3ZINmM2UXRBSkZUcjYzNC96L3FDc1dRR2dKdzNDbUQ0eXZQYWNC?=
 =?utf-8?B?dnJ4eVdmYStRRGdHUlcyNTRmMkhLOENNY0xZNWVjVUdXV1l3NGo5NlQyd1hs?=
 =?utf-8?B?blRLSGoxVStBWlV2OTNMWVZBRjFPc0hDejJkYkZRRUdDT21sTkExZk5BYUwr?=
 =?utf-8?B?T3BubmIxbzFTWndJem9PTHBJUVpia1JrTmh2S2xJajZmZXhWQ0lNVjlZQWJW?=
 =?utf-8?B?YzhHRG1GMGo2Y1JMcDdhVmdiZHRSVmtUdWw2cXB0RFdmWk1UUHU4U0hQYzJt?=
 =?utf-8?B?VXRUQ1l6ZmY3SXlZRWIwVWZjVSt1UWVnMHZyZGMwZUVlMndHR080My9SNGhL?=
 =?utf-8?B?VnpldVY3OEZIcTRHMUNKWUpTb3RZTE9SNFk5THEvUFhYNXc5ZWdpcEpTVXFs?=
 =?utf-8?B?ZEhRZU95eDFrZWZUeVNWa3h3S3BuSGFEbnJSbkc3MThhdGE0UWJYcnB1R3ps?=
 =?utf-8?B?ZE9BZVkvRDYrVXZlNFdFVFM1V0FWcHFDdi9xL2ZjVVJZbHFLRHA4bUxqUmxk?=
 =?utf-8?B?Y0ZMRFlMY21FRk0xSEpkWllDbDFRZU1FQ254QmZ2aGJPbVBSUVoyZU02VWpV?=
 =?utf-8?B?dlorYVBtV0RXbmx2MHVxTHVGdFJydGxNSi9MYU1JU2Y3aTNBVkpQSmR6bzFm?=
 =?utf-8?B?dzBWc0tpY3ZneERlUjlxbm5UQTMya2wrZm8rTXk2aWlYZnp0UmR6T3dQNTNI?=
 =?utf-8?B?d1Y1R1FlaEpLbU11Y1I4MHRxYjNVdGhCZWY0VDFtT3hsM1hncEI2Y0hTaU41?=
 =?utf-8?B?TE1oR0FQUnRKeS9ldnFHeFc2OWVIRmRwbjE3L3ZjN0VSTCtHN095TU9Da2dK?=
 =?utf-8?B?RVlrUHd1ckxCTitpb3BLb1ZjOEtDT3E2NGErKzd1ejYyZlhZVmpNZ3FnM2pF?=
 =?utf-8?B?ZGl3dldiNUs1VmNPZFNUWDBPdEtiMGhETE9vREJpRllCalBuTW96S0N1UzJN?=
 =?utf-8?B?NVdqZ0FsTDZMZ1M5eWxpRkJTYzByZnhFWFpNK3g5ejV6dkJ4ZHZNaHJsSmlB?=
 =?utf-8?B?dGVxNHZBUlQ1WG1FdlBIN3VXc3V0SkE1emhvVHcvanl1eTBack0wazlIeDQy?=
 =?utf-8?Q?j7Pc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d40780-ec4c-4b57-ad1c-08db8d4a527d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 20:04:15.3816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxUT5jNO5BUSTFveOirV8pfe71CxH8n2vRBqcZdwuQcg1ArK1EbFYcdR5ACdIoKWENiHsW0KEWiZXvMvgCUa0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJlc3BvbnNlcyBpbmxpbmUuDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEp1bHkgMjQsIDIwMjMgMjo1MSBQTQ0K
VG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBFcnJhYm9sdSwgUmFtZXNoIDxSYW1l
c2guRXJyYWJvbHVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IENo
ZWNrcG9pbnQgYW5kIFJlc3RvcmUgVlJBTSBCT3Mgd2l0aG91dCBWQQ0KDQoNCk9uIDIwMjMtMDct
MjQgMTE6NTcsIFJhbWVzaCBFcnJhYm9sdSB3cm90ZToNCj4gRXh0ZW5kIGNoZWNrcG9pbnQgbG9n
aWMgdG8gYWxsb3cgaW5jbHVzaW9uIG9mIFZSQU0gQk9zIHRoYXQgZG8gbm90DQo+IGhhdmUgYSBW
QSBhdHRhY2hlZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2ggRXJyYWJvbHUgPFJhbWVzaC5F
cnJhYm9sdUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfY2hhcmRldi5jIHwgNiArKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9jaGFyZGV2LmMNCj4gaW5kZXggNDBhYzA5M2I1MDM1Li41Y2MwMGZmNGI2MzUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiBAQCAtMTg0NSw3ICsx
ODQ1LDggQEAgc3RhdGljIHVpbnQzMl90IGdldF9wcm9jZXNzX251bV9ib3Moc3RydWN0IGtmZF9w
cm9jZXNzICpwKQ0KPiAgICAgICAgICAgICAgIGlkcl9mb3JfZWFjaF9lbnRyeSgmcGRkLT5hbGxv
Y19pZHIsIG1lbSwgaWQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZ2RfbWVt
ICprZ2RfbWVtID0gKHN0cnVjdCBrZ2RfbWVtICopbWVtOw0KPg0KPiAtICAgICAgICAgICAgICAg
ICAgICAgaWYgKCh1aW50NjRfdClrZ2RfbWVtLT52YSA+IHBkZC0+Z3B1dm1fYmFzZSkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgIGlmICgoKHVpbnQ2NF90KWtnZF9tZW0tPnZhID4gcGRkLT5ncHV2
bV9iYXNlKSB8fA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIChrZ2RfbWVtLT52YSA9PSAw
KSkNCg0KSSdtIHRyeWluZyB0byByZW1lbWJlciB3aGF0IHRoaXMgY29uZGl0aW9uIGlzIHRoZXJl
IHRvIHByb3RlY3QgYWdhaW5zdCwgYmVjYXVzZSBpdCBhbG1vc3QgbG9va3MgbGlrZSB3ZSBjb3Vs
ZCBkcm9wIHRoZSBlbnRpcmUgY29uZGl0aW9uLiBJIHRoaW5rIGl0J3MgdGhlcmUgdG8gYXZvaWQg
Y2hlY2twb2ludGluZyB0aGUgVE1BL1RCQSBCT3MgYWxsb2NhdGVkIGJ5IEtGRCBpdHNlbGYuDQoN
ClJhbWVzaDogSSBhbSB1bnN1cmUgYXMgdG8gaG93IHdlIGNhbiBkZXRlY3QgVE1BL1RCQSBCT3Mg
aWYgd2UgZG9uJ3Qgd2FudCB0aGVtIGNoZWNrcG9pbnRlZC4gQWx0ZXJuYXRpdmVseSB3ZSBjYW4g
Y2hlY2twb2ludCBhbmQgcmVzdG9yZSBUTUEvVEJBIEJPcyB3aXRob3V0IGxvc3Mgb2YgZnVuY3Rp
b24uIElmIHRoaXMgby5rLiB3ZSBjYW4gZHJvcCB0aGUgY2hlY2sgdGhhdCBkZXRlcm1pbmVzIEJP
IHF1YWxpZmljYXRpb24uDQoNClRoYXQgc2FpZCwgeW91IGhhdmUgc29tZSB1bm5lY2Vzc2FyeSBw
YXJlbnRoZXNlcyBpbiB0aGlzIGV4cHJlc3Npb24uIEFuZCBqdXN0IHVzaW5nICF4IHRvIGNoZWNr
IGZvciAwIGlzIHVzdWFsbHkgcHJlZmVycmVkIGluIHRoZSBrZXJuZWwuIFRoaXMgc2hvdWxkIHdv
cmsgYW5kIGlzIG1vcmUgcmVhZGFibGUgSU1POg0KDQorICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoKHVpbnQ2NF90KWtnZF9tZW0tPnZhID4gcGRkLT5ncHV2bV9iYXNlIHx8ICFrZ2RfbWVtLT52
YSkNCg0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV9vZl9ib3MrKzsNCj4g
ICAgICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gQEAgLTE5MTcsNyArMTkxOCw4IEBAIHN0YXRp
YyBpbnQgY3JpdV9jaGVja3BvaW50X2JvcyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICBrZ2RfbWVtID0gKHN0cnVjdCBrZ2RfbWVtICopbWVtOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgZHVtcGVyX2JvID0ga2dkX21lbS0+Ym87DQo+DQo+IC0gICAgICAg
ICAgICAgICAgICAgICBpZiAoKHVpbnQ2NF90KWtnZF9tZW0tPnZhIDw9IHBkZC0+Z3B1dm1fYmFz
ZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICgoKHVpbnQ2NF90KWtnZF9tZW0tPnZhIDw9
IHBkZC0+Z3B1dm1fYmFzZSkgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIShr
Z2RfbWVtLT52YSA9PSAwKSkNCg0KU2ltaWxhciB0byBhYm92ZToNCg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGtnZF9tZW0tPnZhICYmICh1aW50NjRfdClrZ2RfbWVtLT52YSA8PSBwZGQt
PmdwdXZtX2Jhc2UpDQoNClJlZ2FyZHMsDQogICBGZWxpeA0KDQoNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICBib19i
dWNrZXQgPSAmYm9fYnVja2V0c1tib19pbmRleF07DQo=
