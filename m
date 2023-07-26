Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E60EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 02:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D8810E0CC;
	Wed, 26 Jul 2023 02:25:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3534E10E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 02:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjMPg4JwHLFY8NKZM9J1AqhdBY0o1pdE0rQlNJuOjERiqMLE1/czLLyjp0HgQDgf421Dvgs/qmyhpfVkGicAojUPXuMIn4m1eB+m9NaTvUInDjyL7pGjZA/a2+RoL87cS42keCszfXPDxNMUrO9TMycb9uAnRetp7nLhmfhI+3UN+YqP3yj0iwXSSAV9vkUTyrFcvZkc3jOIduWTXX16WaQH8p4I+nYve3iHZZABiwvtguEKOEq9/y7HVXRRtLY+MjQm79JLL+fUPazqU5G882sr/TSPH5JSoX9E9IcXETl/AgTXWHuHFT1flttmi4TpTFCXAtwnoIAX765D5slRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5OMoWXJFEb7HDGchj8NeapdV/ALVWLS4jsbUOWwNVQ=;
 b=aQIWNxLicZtlY/1jEiXyT2kmXi4T9IY6I2p/6hoVLlyQdVUEaMHN2jDZjej037Sdv1iulP13AabrytUQT6iNxqzoU0yrND05EnNF37BO8pAodBuu6sRA06CuFujrahPwKFufodjRcFVIhhjEwmXlHcg2OeFzzZwDJTrv8XQ4R1QYn+fUqnS8xkstKdvjl8l9OT5OzuFAaC+xw2FLPoYUpy6KQ5fkfy2A5KKCPpNarE0F+qmEF/lSbftUsPasigK2mj2a7TXggRndeXbUzJPrLMiughDLJeiAJ9D0uuxa168AD8LwVbHB1lf6ruVUUiNVutvpXFYsF5UZ7fkMkXa85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5OMoWXJFEb7HDGchj8NeapdV/ALVWLS4jsbUOWwNVQ=;
 b=vZU092fCGAOsVoGnLRoHfpF2PkAnkeXBWxwWTszOZcKBf3o7Vbmp8yGn0ydVgDeOZHQxlaDPNRv8QLrBOPn/lOBTv190yVnO1o6UKl18C+/CIR3npBOn9+NlsVITaAASvrvexDV911mpxKxiq05gEVfkPt+xtkMZkaw4KPauSgQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 02:25:11 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::133d:2795:5cb8:204b]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::133d:2795:5cb8:204b%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:25:11 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Thread-Topic: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Thread-Index: AQHZvtlD0kn0a7WVGEWmjHcAnrX+76/Kdo2AgADb3/A=
Date: Wed, 26 Jul 2023 02:25:11 +0000
Message-ID: <DS7PR12MB60058BD7E3B8A6FF441D1141FB00A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20230725092020.3777355-1-Prike.Liang@amd.com>
 <CADnq5_Pj9XqiggwpD2uA_rP0sEbV6JMYCh1hOWjG1L6MACdGzw@mail.gmail.com>
In-Reply-To: <CADnq5_Pj9XqiggwpD2uA_rP0sEbV6JMYCh1hOWjG1L6MACdGzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=25f3ba74-1310-42bb-b1b2-370888857d1b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-26T02:22:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL1PR12MB5270:EE_
x-ms-office365-filtering-correlation-id: 92c8c7cb-c9d5-4126-d31c-08db8d7f89c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wObcGdvzQx0tnGw3KUrCfLVI0QKvYTSnGl3OsPRuq11OGmLwb3/fCs/EJfZqVrMgJnEa+1iGNKpuddpgThHdVwt2URDlUJnqwX005ii0n6uxBmwmocXXhk7xY2v+xNUPjQgE92EMBcmpjZ41zWlHUIJeHimIheqXuSgxRP6bejirEOcnJKCtc0CSeMINL6clMTV4WfCEZoxVw2TWlEKeBOGbBDlijgb1yi4IqUGKrQqTHO141Ki8ievOmY69PreL3o2Zsu5MW8hPRcfmL0JivmJkXPG8znl7WwzPEWErwJpv1qNTceFBxt+o4TbAEao6axE6AqN4pZRhnBy6kNDNF+D4er/KZlLIjfT0XgEkI9dyT16i6sGP1NeRjcn3Vd0h+TQxd4ixO8HPYatXHk6WE2oxRgi3P3zArTvOLFMsEXdAhw1F74VnBel0+0/cVv4YDfxA9KFpCsgILfp//0XWpvZlpEJKoLzCYi3m1UCYZlkOwxouI18ygexJfe03NvasoP4YuV/HG2HOMay6kutfiQuQ7EBE6D4tQDlCTs4Jk1ECPQDzGc6m8y/GmaIFMNG7Iu1ebpW9IhKmUu4z25yOegZwJHqo+HBaO3fz41mwSitn0/x2xRIgM+Khtqd6EvY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(2906002)(41300700001)(316002)(38070700005)(52536014)(5660300002)(8676002)(8936002)(33656002)(55016003)(86362001)(9686003)(26005)(6506007)(53546011)(478600001)(7696005)(71200400001)(83380400001)(186003)(38100700002)(6916009)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(122000001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVlILy9zcUtIcVBMRUUwdnZidkkzSklGWDFTZVlwVE1taWRxaVd1MUZJZmxW?=
 =?utf-8?B?ditldnlmRjk0QlVaUlAwRjFlTHRJcjlTekt5citEcTNBSmliTGN5bmFsWXRH?=
 =?utf-8?B?ZmFkMmcyMzdHa2dkanUvMHdCK0hFaHZxZjJxOUlpcHZEazFuWVF0UW04S0pr?=
 =?utf-8?B?QU00Q2VBNFhMWm11NERXSE1vcU9BNVBSWDNEQmNNbTNXOTRLL3NIUkIwL3FM?=
 =?utf-8?B?cHhLaDRCdWJoWnF3UmIrTWtseFYzZkJMNFVEdzdhTHl1RzlZU3NWcFFQSFl4?=
 =?utf-8?B?cDZ2RFM5NnlBU0dOeVo3d1BMVlBzUjUzUmhnSDdXcnoxdXdnLzRBSHJaV2lP?=
 =?utf-8?B?d1crY0ZCZzlvcG00OUlmNk82UE5QTVJ1NFRGZFpqK1RpTGhpRURoNTc4RVlL?=
 =?utf-8?B?N3l2UnBlVVZqMk80cjZYVkNaTDB6ZkRjeG5jeVMvUjJuTmo1UWc5dWVuMkJ3?=
 =?utf-8?B?aVR1a1NpNml6RkdNc3E4QWl4RU1LU3FPNHMwK1FjWVIvS1B0dXZtQytNQllG?=
 =?utf-8?B?Qys5NS9UTUlQVWVDSFVQSzgrRzRJRVlRWjN3cXMvYTZhYXpoeWhjVmtDbTZ2?=
 =?utf-8?B?M3VyQ3Fqcm1ZRi91UEo3NENzSzBpTCsxVm9ZSnZ1Y2hvOVVCYnJFdVJEbXVm?=
 =?utf-8?B?V2tlYldITWhlcXhPUzJjY0NubEhiMnpkL1Z6aW5TVi9qY0FveXBFNDlJVkZV?=
 =?utf-8?B?UWFPMFptWWNIbUdWZHlrcGhKb0hwc1BET1hYVlJoaDVvWmc0ZjFBSVMxTGQv?=
 =?utf-8?B?N1QyOFlQSTlHUG04UmNxcVA0WDJqN2JQSzNkOHVVMHFRcUt2VXY2amJaSlNQ?=
 =?utf-8?B?aks3Sm0rMmV1ajFzR2R6enVWVER2dUZBM2JBWDdpQmM0czd2cXFtOVhrbVBK?=
 =?utf-8?B?RnlMMnQzdVpEZUl3d2FSUlRPTlk5S3ZzMWJYSHplTHpjK0V2Q0dlMzYzcTZJ?=
 =?utf-8?B?aHZqQWJiYks4cTN6WmZTQ1RWTGdFR1ErdFB4ZEhrNW5JcmJLaDlrRkg4MGtU?=
 =?utf-8?B?aUlaWkhpUVRPcVV0aTM5ZDJHaEVUNWRHQnl2RE5vNGs0bnkxdFVCZmhsUWls?=
 =?utf-8?B?c2o2RHNBVHJHK1BWRUN2eFJhTlNOei8yaXZkSE5BcHZEOGtCdmdRb2V4OTRW?=
 =?utf-8?B?UVN6cE9LTGhvM3pyTHhHNmlIYUs5YVdZT3FNaUgwZkZtL3QvaFVBUXhSWGZt?=
 =?utf-8?B?UCt2WnpxOHl1M1BrZFJOVHUvazRBdlR4cWNxdnUvTmkrUld1VFN6YnJSU2pM?=
 =?utf-8?B?a1M5N0lFN3JNQmIrN3BNR0ZuWTJrdkxYU1l5Q0RpU1pLTEVRemt5SE1BTTgw?=
 =?utf-8?B?MTZ5SW9kYTVET2tzL3hncjdwdm03YUthRDFjNFpDOHB4T1lmNXVJTytRMStJ?=
 =?utf-8?B?VXA2cEFxbWZBVGJWSEVQL2JYeXZDNTVDcm5YeU90SUJwc0YxSDAxZm5RWTBh?=
 =?utf-8?B?RnJJK2t3QU0zZnArQnRoTU80MmhPRHF3TFg5YlNJakRKNnV2TU9jYml4SjBE?=
 =?utf-8?B?bndPNkJZNXVuTWFweDNCVWRiYVI0UGFncGRVSEFrOWxzdHk0UEluV3pJRWZZ?=
 =?utf-8?B?K0xEWjN1bHIxUHh6TTl1UEVqRGtZWHFpQWlzd1ZXaklDc0pRclRqQjV1TFlN?=
 =?utf-8?B?RG9oQkgzeCtFRkl1ZWVDbFlRNU9SdTdtTENhSkJmM01CNGt3b0c1aG90V1BJ?=
 =?utf-8?B?bnpTc2xpMEtYNGI1TU5YVTJTRVpNTXdZaUVjamlDVlBBRUptelppb29PKzQ5?=
 =?utf-8?B?a3lNWTlWK0JIRWlURG1HSTltL1ZGT0lNZU1aN2haaXFGRHR0NmxyWWJtcGV4?=
 =?utf-8?B?L3MrUER0WU5HemZ3NHhSM0pGV0thLzYyS2pJbk80WUN3QnlsZXRnQVozN0ZV?=
 =?utf-8?B?Z0JmQ3lzanVVOWRjc09OV2VpOWNEK3BUdXV2T1VQQ3JCa0Nnbm5SbmZaUkVE?=
 =?utf-8?B?a3NyUUpyWFZrNVlsdjBINnBWNHdOUS9Md1dVelhwWnpMcEZvbWtjNzVKMjlW?=
 =?utf-8?B?K3ZJYlh5cVVpbzVpN1NkZFlLdnBhTC9lMHg5dkVZQ3JGbG9qNENBcENxUnVj?=
 =?utf-8?B?d2s5YXZwa3JVcEVjYmx1dXZWUXRmTFh0ZVZrc1dMRVdpS0thMmlnTHFhNVRo?=
 =?utf-8?Q?oWy8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c8c7cb-c9d5-4126-d31c-08db8d7f89c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:25:11.4326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suZCeaRmQ211Bh8QtnoRBjBRrOBE6fQyl/lCCSejhh7KaAI/lMXOlMGmZoq2qhu1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBBbGV4IGZvciB0aGUg
aW5wdXQsIHllYWggaXQgcmVxdWlyZXMgY2hlY2sgdGhlIFNETUEgZmlybXdhcmUgdmVyc2lvbiB0
byByZXNvbHZlIHRoZSB3aWxkIHJlbGVhc2UgcGFja2FnZSBkcml2ZXIgYW5kIEkgd2lsbCB1cGRh
dGUgaXQgaW4gYSBuZXcgcGF0Y2guDQoNClJlZ2FyZHMsDQotLVByaWtlDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjUsIDIwMjMgOToxNiBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEd1bywgU2hpa2FpIDxTaGlrYWkuR3VvQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGVuYWJsZSBTRE1BIE1HQ0cgZm9yIFNETUEgNS4yLngNCj4NCj4g
T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNToyMOKAr0FNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE5vdyB0aGUgU0RNQSBmaXJtd2FyZSBzdXBwb3J0
IFNETUEgTUdDRyBwcm9wZXJseSwgc28gbGV0J3MgZW5hYmxlIGl0DQo+ID4gZnJvbSB0aGUgZHJp
dmVyIHNpZGUuDQo+DQo+IElmIHRoaXMgaXMgb25seSBzdXBwb3J0ZWQgb24gY2VydGFpbiBmaXJt
d2FyZSB2ZXJzaW9ucywgZG8gd2UgbmVlZCBhIHZlcnNpb24NCj4gY2hlY2s/DQo+DQo+IEFsZXgN
Cj4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jICAg
ICAgICB8IDYgKysrKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVf
Mi5jIHwgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L252LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgaW5kZXggNjg1M2I5
M2FjODJlLi45YmY3ODcyZTI2MGQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9udi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bnYuYw0KPiA+IEBAIC05MDEsNyArOTAxLDggQEAgc3RhdGljIGludCBudl9jb21tb25fZWFybHlf
aW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NV
UFBPUlRfQVRIVUJfTFMgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQ
T1JUX0lIX0NHIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9W
Q05fTUdDRyB8DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfSlBF
R19NR0NHOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX0pQRUdf
TUdDRyB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfU0RNQV9N
R0NHOw0KPiA+ICAgICAgICAgICAgICAgICBhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JU
X0dGWF9QRyB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NVUFBPUlRfVkNO
IHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9WQ05fRFBHIHwg
QEAgLTk2Miw3ICs5NjMsOCBAQA0KPiA+IHN0YXRpYyBpbnQgbnZfY29tbW9uX2Vhcmx5X2luaXQo
dm9pZCAqaGFuZGxlKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JU
X0FUSFVCX0xTIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9J
SF9DRyB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfVkNOX01H
Q0cgfA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX0pQRUdfTUdD
RzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9KUEVHX01HQ0cg
fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX1NETUFfTUdDRzsN
Cj4gPiAgICAgICAgICAgICAgICAgYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9WQ04g
fA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcgfA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX0pQRUcgfCBkaWZmIC0t
Z2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMNCj4gPiBpbmRleCA4MDllY2E1
NGZjNjEuLmY4YjZhMjYzN2QxZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMi5jDQo+ID4gQEAgLTE2NTMsNiArMTY1Myw3IEBAIHN0YXRpYyBpbnQgc2RtYV92
NV8yX3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkDQo+ICpoYW5kbGUsDQo+ID4gICAgICAgICBj
YXNlIElQX1ZFUlNJT04oNSwgMiwgNSk6DQo+ID4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oNSwg
MiwgNik6DQo+ID4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oNSwgMiwgMyk6DQo+ID4gKyAgICAg
ICBjYXNlIElQX1ZFUlNJT04oNSwgMiwgNyk6DQo+ID4gICAgICAgICAgICAgICAgIHNkbWFfdjVf
Ml91cGRhdGVfbWVkaXVtX2dyYWluX2Nsb2NrX2dhdGluZyhhZGV2LA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RhdGUgPT0gQU1EX0NHX1NUQVRFX0dBVEUpOw0KPiA+ICAg
ICAgICAgICAgICAgICBzZG1hX3Y1XzJfdXBkYXRlX21lZGl1bV9ncmFpbl9saWdodF9zbGVlcChh
ZGV2LA0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
