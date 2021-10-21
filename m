Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8089C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A2A6112D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6A2A6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A3F6E457;
	Thu, 21 Oct 2021 13:56:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E956E457
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9YcvXX+9TR+5v1qP0E809k934unMbxruh4yMjRk1yl89VsVJX9S3oG1D53PWM5mob7zlBI/i+nocXBF9OPMfmrqoUtCAyuV5tgQePnQauIzvgXGBiCW5CylI2NYPBSNUX8RKIeRn8y6vyR9+Aw3MxIhWHZn5H9SPoIQ7QuFgdfMzsfmmqdxYZsyTuIw3Vx/DbhPo5HlMV6OAUhMJdvFkjSgiX8QtcJ5fI4sAsX49m2N1xpr4MjZiWyxe1wWAFZco134cJi0/BuAO9U4U0i2SmoxIF3M+W9tFkid9wqF98Obliz6SA6YnKxxhdBtalmWUj4/DQnxhoxzVOXNKIuiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxVEqLa8WLXqsL6gwE1QaCYZ41l/rAOQw0UHUTCVXr8=;
 b=XxSwvrbSeMM0jVVUXokJmYXWyzyPwZ9Oxa2CwYJcVetL4IvFeJNo3NOKhZS1mY34miUnCxlaj2/wRP7p9mOov6BfZ/+KC9AB3xOtq6waAgrXbXAuPJu0sd1mXCtOtNNA+6pUJU1GRJfSAfmMuGpaBL1mBaa87nbC7TnkZMrrjUqfVYF/5oGVvJwTlwcDd3eJK7cUX+KH7LRHuXjylC4NJodKxEM40rrvvPz1Iwdf/xBqlsLZTiAey+qT1dZNBo/yvKcpf7cFVzA4Ta+SeZ0mDsp5jJGEdzOGepV37/z6y2SIWBgrY+iDEDl0/i0OKaGw+kHvzhLIm+lQeLLUyuqVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxVEqLa8WLXqsL6gwE1QaCYZ41l/rAOQw0UHUTCVXr8=;
 b=1twbjuMB0MgpwLeYz+STYS9pG+c3XuBk+KsGHhz9RxO2qK4PMGNSMOmAVuz/d0m4AfIzHXugw9+r3DU67T62Kxx6Xgw4TAASPnHKQs7wAT9aEdEGp13SeqYCcCyHvmKVoyiPMpIfyQ7/IodXC9iyqWMgA122uxkmTyN7aKw479I=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 13:56:34 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 13:56:34 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Thread-Topic: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Thread-Index: AQHXxdCFHjJje/5lf02XLXYO+IHCm6vc7EUAgACNlnA=
Date: Thu, 21 Oct 2021 13:56:34 +0000
Message-ID: <DM6PR12MB3324757ADAEDEB293ED1A53B85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
 <edd26c75-6cac-7d5d-97b8-4fc085a76417@amd.com>
In-Reply-To: <edd26c75-6cac-7d5d-97b8-4fc085a76417@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T13:56:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b92e20f8-931d-4f8b-a03d-442b81b3b0ed;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f3132d3-e409-469d-e05a-08d9949a97c6
x-ms-traffictypediagnostic: DM6PR12MB3035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30355C8CAB43ACCBA0D17FB185BF9@DM6PR12MB3035.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFrRP9UEL0lvU0y6Rcp2YhH9NLOCbeKeSRYqLhWzs74KsJF8Rdjw0eayD24X6nnK/sJZuj10MgpWEpTCxCNAi9sFJyHP18ZRvbG3ge3FhGrFChFs2aBdPZvRfID3gU8W+zzyCqum4NDbv20CtpuwK2ZKNaKYihMILVy+CLulT5yg5jJ5Z6k5t8LGXV/Fbpz5+UW2pEcYmEjIxfMgAVAdY/McMvBG7d3ul195V8MCtN8C2f+DfFKQcWj4ZKdSUG3v9Q0N54hlE4p+eZWMHgHisRqyNvdOvJ4x8yr9VOjO9ywtGUZLEzbUESispm9RbYm4RZT8apQ7oBTu+yiDlr+odSPgGAdo3w95FZi43fEEoGJFL+RssmG0V/4m1PnbhEvtplTcCRC9jd04sN3lMCcMHiH2X9L/8JrBEr5rvXP4SPlyv0WBr8rSxidby0ZAYE9vBWWmRpLhM2PngnHuWh4kP/w/MfZzLiJb5xPuYwqwhwI1jdSF0/FofOXcaXc/egDt1869uBUB8+XYdU8AWlnRdJaG+rpJtQ3m2TiyO0lwGHpL2yTbKwZGodHWqqEIHaNAuN4ecHpNq3VB7EVDYxl6N4LvCogyDlfCaGr49Pg9MdmrbY6HFK6vAD8QNpCMTGU17Fq3EK8od6IIwFgVoPbWji2tZ8uXIEngrTGIFvAidWTtcDYg6gUNypZdNTrpCJ3BNkALj23Gpgq7+rV6crZHkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(38070700005)(33656002)(9686003)(53546011)(55016002)(64756008)(71200400001)(5660300002)(54906003)(86362001)(110136005)(316002)(2906002)(52536014)(66556008)(66476007)(76116006)(122000001)(83380400001)(186003)(4326008)(8676002)(66946007)(38100700002)(6506007)(8936002)(508600001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnRRbUNRWmRKNTlqZFg2ZjZCblJVN2ZYWS9kMGxPMHFvSXZHbnFmUWp2SEpO?=
 =?utf-8?B?STVwL3c1K1ZwbThLcE5ENWRkM09GeHN5clBFUU53bVc3YXZJc3lFYmEzbWRx?=
 =?utf-8?B?bGtDYk1FalRqMTMvbkk5cnludUYyaDlkQ2dDa2tWbEc4Zm5YemdOaTNNK1BL?=
 =?utf-8?B?YndNRmFqVzY5b205SDhUeWNjaHAwSTBaNkFON1RJTW5jTEZaT1RvaEo5ZXFN?=
 =?utf-8?B?cnVBc3hLSVNFVHNwekpOdi8xWGFVaXh0Yk9zQmFIdHpRUFhHYTZTY1BocTN0?=
 =?utf-8?B?WFFTYkR2NVdRUld3Z0tOQmZ4ZlBuZFY5N0xiMHJQcHV5SDNoMzI5U1BTZEJ6?=
 =?utf-8?B?Rkc4ajdUK2Y4bzRMZFEyY2hhaWEvaWlVL1ZjOTBGMlEvaHVNWVdXUFpDR2dR?=
 =?utf-8?B?YkdaRURucXdhOGNXR2swdStNWW1acVo3QjNwWW5jVFZTL0dYZFRWemxoRU92?=
 =?utf-8?B?ODVCSW1ENm5NNTRuUU9QT2dFTUZHcTFMTHRhVmJ0UFJuMmNXY3YwYkV1Qm5t?=
 =?utf-8?B?L01BQjZCb3VkMS9qZitVcjdJR09oK0tEakc3OTBWeGVrRFZmYTlwd3VjaHZM?=
 =?utf-8?B?bXJVZGdjbDVTMU5oSzhlQkw1VTdmYmRtazZqdTV0cmE5WFlSc0FYQ3h3QTRW?=
 =?utf-8?B?ZEtyaGp6d0NjRVU5Y3FRODR5eG1hVnczTjdncmRXeGduMzZIc1NTTFZnME9E?=
 =?utf-8?B?b0pqRmwwcExJNEg4RHBMWEdIVkZVY21kSmFaMndOZmpSM1hibDMvcUUvdW12?=
 =?utf-8?B?bU5CM05OZWtGUXdHMU5mcXJSbmxrM3AxUlBSZ1IvNnd5cDVaWnlGU2VzL3NR?=
 =?utf-8?B?NTQ3ejhkUkJ4bjVySFEzNXFoTTM1T2lHQjNqZ0p5SlgxYVMvWC9NMDI3b1Ur?=
 =?utf-8?B?b0hxc0FjSnpDQlgvQkRkeU9LWFRXTThXRDFoWExUQytqSHJSbmJFeWtQbmgx?=
 =?utf-8?B?L1JIaHdDYllhWXVJUjc2N25yUVFkME43VHlweHpqQUFuV2JKbXNZVyttb1cr?=
 =?utf-8?B?UTVvS01LQTV1Tkk5cTMwVmhxZ2U0Sk5WUmNtWFdpODcyOXlqcGZOeWdFbGp4?=
 =?utf-8?B?K1YvNjF6bzEzdkg2RDRNZGtGQUV2azM2cS8vUk8xcStBOHhJejdLTjloY2sr?=
 =?utf-8?B?K3k4L3JHc2pMWHBmMytFSENhMEl6M29UWnNBaGZzVnhNYWJkakpNMG1MeEpD?=
 =?utf-8?B?MjYveVlpUG9uQ3pnVHViU3pmOGo3Yk40QWJVYXFDTWZGbTlRNGhtZjkzaTNZ?=
 =?utf-8?B?Vi81RCtNR3ZNVzAzVy96dkZUNWtKem9VZzl2emNDQzhsNVBtTU5QaEgwUklV?=
 =?utf-8?B?MU8yVDljcG82UUVaaGNPc3E0NU54UXZCRTNaVDhwbSsyWmFLV2NFcmdkR29E?=
 =?utf-8?B?YXpPbzdIRFFjZGdMWjEvSEN0bWs2MG9oT0dvdHg5MTlDU21xSE5ZckgzZzRY?=
 =?utf-8?B?OHRobkRkOEtGbFJjQ2hoZVRiTWczUEV1ZlFOdElMODh1Z2ZFVC9OdTlTR3Jt?=
 =?utf-8?B?YlFvbHJLUFF6d2x1dVVwVnhXdUZmbWE1bVFya1pUTXhjY2dzMEorK1hZbFlF?=
 =?utf-8?B?U21SRXVpTDFMVXdhRG9DVFlOb25OYS9taHFDZ0tQRzZBNlNsU2lSWWcvTDNm?=
 =?utf-8?B?clJhaG1vNDR4Z2xDbUNJQVhIb2FqdWtET1RLNlc0Zk95L2tqUmhVbWtwSXU0?=
 =?utf-8?B?UXM1Mi82c1FnM3JFY0R3Ris5NlFxTFc4dnVTN0lJU3NGTWoyNUNuN1JaRDR1?=
 =?utf-8?B?d3lzNnM0Zy84NDMxQnlQRy9lYitJV3ZIWGwzdDJSdHh2RlVMNS92OS9rQlFS?=
 =?utf-8?B?VXJiaW40VUdwNjNZVkhka0krY0JvcGM1QUxwMk8rdHFtNlNQUC9xZThyMWl5?=
 =?utf-8?Q?UwwpvrH5NFtmM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3132d3-e409-469d-e05a-08d9949a97c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:56:34.1483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE9jdG9iZXIgMjEsIDIwMjEgMToyNSBBTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2Vu
dC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
VHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBKb3NoaSwgTXVrdWwgPE11a3Vs
Lkpvc2hpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1OiBJ
bXBsZW1lbnQgYmFkX3BhZ2VfdGhyZXNob2xkID0gLTIgY2FzZQ0KPiANCj4gDQo+IA0KPiBPbiAx
MC8yMC8yMDIxIDEwOjA1IFBNLCBLZW50IFJ1c3NlbGwgd3JvdGU6DQo+ID4gSWYgdGhlIGJhZF9w
YWdlX3RocmVzaG9sZCBrZXJuZWwgcGFyYW1ldGVyIGlzIHNldCB0byAtMiwNCj4gPiBjb250aW51
ZSB0byBwb3N0IHRoZSBHUFUuIFByaW50IGEgd2FybmluZyB0byBkbWVzZyB0aGF0IHRoaXMgYWN0
aW9uIGhhcw0KPiA+IGJlZW4gZG9uZSwgYW5kIHRoYXQgcGFnZSByZXRpcmVtZW50IHdpbGwgb2J2
aW91c2x5IG5vdCB3b3JrIGZvciBzYWlkIEdQVQ0KPiA+DQo+ID4gQ2M6IEx1YmVuIFR1aWtvdiA8
bHViZW4udHVpa292QGFtZC5jb20+DQo+ID4gQ2M6IE11a3VsIEpvc2hpIDxNdWt1bC5Kb3NoaUBh
bWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzX2VlcHJvbS5jIHwgMTMgKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiA+IGluZGV4IDFlZGUwZjBk
NmY1NS4uMzE4NTIzMzBjMWRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+ID4gQEAgLTExMTUsMTEgKzExMTUsMTYgQEAg
aW50IGFtZGdwdV9yYXNfZWVwcm9tX2luaXQoc3RydWN0DQo+IGFtZGdwdV9yYXNfZWVwcm9tX2Nv
bnRyb2wgKmNvbnRyb2wsDQo+ID4gICAJCQlyZXMgPSBhbWRncHVfcmFzX2VlcHJvbV9jb3JyZWN0
X2hlYWRlcl90YWcoY29udHJvbCwNCj4gPiAgIAkJCQkJCQkJICAgUkFTX1RBQkxFX0hEUl9WQUwp
Ow0KPiA+ICAgCQl9IGVsc2Ugew0KPiA+IC0JCQkqZXhjZWVkX2Vycl9saW1pdCA9IHRydWU7DQo+
ID4gLQkJCWRldl9lcnIoYWRldi0+ZGV2LA0KPiA+IC0JCQkJIlJBUyByZWNvcmRzOiVkIGV4Y2Vl
ZCB0aHJlc2hvbGQ6JWQsICINCj4gPiAtCQkJCSJHUFUgd2lsbCBub3QgYmUgaW5pdGlhbGl6ZWQu
IFJlcGxhY2UgdGhpcyBHUFUgb3IgaW5jcmVhc2UgdGhlDQo+IHRocmVzaG9sZCIsDQo+ID4gKwkJ
CWRldl9lcnIoYWRldi0+ZGV2LCAiUkFTIHJlY29yZHM6JWQgZXhjZWVkIHRocmVzaG9sZDolZCIs
DQo+ID4gICAJCQkJY29udHJvbC0+cmFzX251bV9yZWNzLCByYXMtPmJhZF9wYWdlX2NudF90aHJl
c2hvbGQpOw0KPiA+ICsJCQlpZiAoYW1kZ3B1X2JhZF9wYWdlX3RocmVzaG9sZCA9PSAtMikgew0K
PiA+ICsJCQkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiR1BVIHdpbGwgYmUgaW5pdGlhbGl6ZWQgZHVl
IHRvDQo+IGJhZF9wYWdlX3RocmVzaG9sZCA9IC0yLiIpOw0KPiA+ICsJCQkJZGV2X3dhcm4oYWRl
di0+ZGV2LCAiUGFnZSByZXRpcmVtZW50IHdpbGwgbm90IHdvcmsgZm9yDQo+IHRoaXMgR1BVIGlu
IHRoaXMgc3RhdGUuIik7DQo+IA0KPiBOb3csIHRoaXMgbG9va3MgYXMgZ29vZCBhcyBib290aW5n
IHdpdGggMCA9IGRpc2FibGUgYmFkIHBhZ2UgcmV0aXJlbWVudC4NCj4gSSB0aG91Z2h0IHBhZ2Ug
cmV0aXJlbWVudCB3aWxsIHdvcmsgYXMgbG9uZyBhcyBFRVBST00gaGFzIHNwYWNlLCBidXQgaXQN
Cj4gd29uJ3QgYm90aGVyIGFib3V0IHRoZSB0aHJlc2hvbGQuIElmIHRoZSBpbnRlbnQgaXMgdG8g
aWdub3JlIGJhZCBwYWdlDQo+IHJldGlyZW1lbnQsIHRoZW4gMCBpcyBnb29kIGVub3VnaCBhbmQg
LTIgaXMgbm90IHJlcXVpcmVkLg0KPiANCj4gQWxzbywgd2hlbiB1c2VyIHBhc3NlcyB0aHJlc2hv
bGQ9LTIsIHdoYXQgaXMgdGhlIHRocmVzaG9sZCBiZWluZw0KPiBjb21wYXJlZCBhZ2FpbnN0IHRv
IHNheSAqZXhjZWVkX2Vycl9saW1pdCA9IHRydWU/DQoNCk15IHRob3VnaHQgb24gaGF2aW5nIHRo
ZSAtMiBvcHRpb24gaXMgdGhhdCB3ZSdsbCBzdGlsbCBlbmFibGUgcGFnZSByZXRpcmVtZW50LCB3
ZSBqdXN0IHdvbid0IHNodXQgdGhlIEdQVSBkb3duIHdoZW4gaXQgaGl0cyB0aGUgdGhyZXNob2xk
LiBUaGUgYmFkIHBhZ2VzIHdpbGwgc3RpbGwgYmUgcmV0aXJlZCBhcyB3ZSBoaXQgdGhlbSwgaXQg
d2lsbCBqdXN0IG5ldmVyIGRpc2FibGUgdGhlIEdQVS4gVGhlIGNvbW1lbnQgYWJvdXQgcmV0aXJl
bWVudCBub3Qgd29ya2luZyBpcyBkZWZpbml0ZWx5IGluY29ycmVjdCBub3cgKGxlZnRvdmVyIGZy
b20gcHJldmlvdXMgbG9jYWwgcGF0Y2hlcyksIHNvIEknbGwgcmVtb3ZlIHRoYXQuIEluIHRoaXMg
Y2FzZSwgSSBkb24ndCB0aGluayB3ZSdkIGV2ZXIgZXhjZWVkIHRoZSBlcnJvciBsaW1pdC4gZXhj
ZWVkX2Vycl9saW1pdCBpcyBvbmx5IHJlYWxseSB1c2VkIHdoZW4gd2UgYXJlIGRpc2FibGluZyB0
aGUgR1BVLCBzbyB3ZSB3b3VsZG4ndCB3YW50IHRvIHNldCB0aGF0IHRvIHRydWUuIE90aGVyd2lz
ZSB3ZSB3b3VsZG4ndCBiZSBsb2FkaW5nIHRoZSBiYWQgcGFnZXMgaW4gZ3B1X3JlY292ZXJ5X2lu
aXQsIGFuZCB3ZSdsbCBzdGlsbCByZXR1cm4gMCBmcm9tIGdwdV9yZWNvdmVyeV9pbml0Lg0KDQog
S2VudA0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+ICsJCQkJcmVzID0gMDsNCj4gPiAr
CQkJfSBlbHNlIHsNCj4gPiArCQkJCSpleGNlZWRfZXJyX2xpbWl0ID0gdHJ1ZTsNCj4gPiArCQkJ
CWRldl9lcnIoYWRldi0+ZGV2LCAiR1BVIHdpbGwgbm90IGJlIGluaXRpYWxpemVkLiBSZXBsYWNl
IHRoaXMNCj4gR1BVIG9yIGluY3JlYXNlIHRoZSB0aHJlc2hvbGQuIik7DQo+ID4gKwkJCX0NCj4g
PiAgIAkJfQ0KPiA+ICAgCX0gZWxzZSB7DQo+ID4gICAJCURSTV9JTkZPKCJDcmVhdGluZyBhIG5l
dyBFRVBST00gdGFibGUiKTsNCj4gPg0K
