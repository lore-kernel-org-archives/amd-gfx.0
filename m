Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F9CC4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 22:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB71B10E90C;
	Fri,  2 Feb 2024 22:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVGb18Oo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D395510E90C
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 22:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEpjekiWsbA2CERmBc/J/n2YKFNhJq9APbDVZ2fCWGNxpqw0yC8XywC02/7wPf5gFAfJLzA76Z43i9tQWOHxeqV9y9xDd+UEmUy2upUL/TSBWZ9zlBISHt4v15rPMsANat6v3P9nm7Fs/+IGafjsjRAr53Vz1OIrnXE5QKtw36XSd/DwxAorICPTVq61rJX8yicHGwHsm5pJqj0xzejvVkINXcBn1sE6r+g9RIEQ6rGyGNuTGWHxu4aKCaCIBYfoO5sn+DygY+bxt9/rluaLjut59GMRsM9MPKx1qbO+CmbNqX54egf307SL6e8NrDOLao1hnyrNgPutj8pNuJ6Oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPS6lsCU28KBwL6YourKIh29Pgw8hbWZZ5k1TRECjRM=;
 b=F3pmlby6NkeMZxZepoW4+lAVphyC1Pr+NLKeYoqW1QhFsohWtlZjN0NIcl4HMCVGKdRfaSUfp6ug6AiehJhwv8rdcHdMqFdrhuwr2ctpTyaWioP3dKPD2+gWLlLwL0zMbTdxgIew37g8qZWb5+0kD33LrTF/3oq24o1gd8x7ZT1aY0YWXhZ+ACyu6ucgkMH/VwcPDivGDA1tQA3mLmfq2LHAWTgikU2SWN4X+4U3FGLsqslNCkBeXjYvr2WNq6BoyStwkeO2jmnRyYG1OhMWm5l1Tpzb0jly/3dpBeKvlq9NItXaiIinAETAuBz43vvJA0GVXwVkqtnPerOzvkCObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPS6lsCU28KBwL6YourKIh29Pgw8hbWZZ5k1TRECjRM=;
 b=bVGb18Oo/VxgeE44SbznJ4aqFJfkgQym/ZiChP6aSUEnk6Y6Po4rqJBPU9tyPXDDPl2KyQfJ8CbGCEaFYxZVnxosZmxYk+x3fzt66wMc7IxZ3o0IrqVY/sq8DV1C825igyKrwdYrMiTxAsELFKWGljPDlooBYGSDp7Ks59X6VGk=
Received: from MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 22:24:34 +0000
Received: from MW3PR12MB4489.namprd12.prod.outlook.com
 ([fe80::d54a:71fb:c9bd:708e]) by MW3PR12MB4489.namprd12.prod.outlook.com
 ([fe80::d54a:71fb:c9bd:708e%5]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 22:24:34 +0000
From: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Bhardwaj, Rajneesh"
 <Rajneesh.Bhardwaj@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Thread-Topic: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Thread-Index: AQHaVUAr34TyxkvKtU6ms+PxOHDwz7D3PRCAgAANcpA=
Date: Fri, 2 Feb 2024 22:24:33 +0000
Message-ID: <MW3PR12MB4489A4FEFAD589AC27354C9BF9422@MW3PR12MB4489.namprd12.prod.outlook.com>
References: <20240201185445.1461461-1-rajneesh.bhardwaj@amd.com>
 <89049091-fcc2-4d9f-929c-108af7941f49@amd.com>
In-Reply-To: <89049091-fcc2-4d9f-929c-108af7941f49@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2a9948ec-e612-4e89-9bff-d4549a76ad6c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T17:08:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4489:EE_|CH3PR12MB7620:EE_
x-ms-office365-filtering-correlation-id: 327de93e-7918-484a-96b7-08dc243dbbb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fxte+qIApkzPItQDm4n0P0u3SMYZHtq7yJQtcbtCxMOowtMbyEmwMZRLCEHCIBSWBFz2dapJhKXK0y156xFiqrT16KhBLDIeNZMKG2D613wh7Su10DxZEDI5/stuhPCu3QkmhVl/IZzwpnyC3zCjMmvstC1PnZkT29tqnZzuRWZYMpAHqIOhYRrrMciUe82XtkUaXyEWv9JRESvLcPiyRneL+XF6R22vK5MdkWOCuoZjFKdMKonoZVo/P0aQLqvqpIDzAqyCO3f3gNPF/KF12emHdqpVHu/yPBLGGNHZYaadIfv6eUNx+jja9nXTijmzkfVv/6P7JDYsrOCfkWK/ZhjOudDvu8tdG0iSW8Bow72rLxx2JmdciLH1zAo1fOa4UTD5tmiXttXFqKZOIs0z1/stxaYk9AUHSqllSoI4ZneBVNWSz8MKiztHEjoPuL0tj9CiJIW493Y58tw2IzOw4VzCLi23ySzaBKmqecnyKLbgNnqwHtR7/srhP7MA8l/RHpQ+v79nj2opKygmFxZxTCKRIJubEbf5viIWQseg8k633CE50D7uzvOGUDAE1DoO3if5Ypj+LhdOrBGPCj14sYyGyyLgasY11Py3780II8c9dkJPBjgHxwo9IC7ULblq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(41300700001)(26005)(38100700002)(478600001)(64756008)(38070700009)(316002)(83380400001)(9686003)(53546011)(6506007)(7696005)(71200400001)(122000001)(86362001)(66476007)(2906002)(33656002)(110136005)(66946007)(66556008)(66446008)(15650500001)(52536014)(8676002)(76116006)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3hzd1FxRzRiTjNtb1hwekZDV3FJbThsTUxRVkVJOGZySEZsSW1acWxwRUZy?=
 =?utf-8?B?VTlUd3I1dTRvMG9SelREaGFVYk1mTzUrcWlKVlpBVjc3a0d3cHpiSlpBMWdP?=
 =?utf-8?B?eTd3QUc2QVA2akMzQmw4T085cVRVREUwSFRZVFBmQVl4MGV1VElkQ1hkVU5i?=
 =?utf-8?B?aHRwQTJXOUs1NkNiUjg3b2pvTk9EZzdKajlRMnB6QndhUDNPRmJodEloZ0VM?=
 =?utf-8?B?eVZibTQ4VzVLVUZtVlZPN0Q3UG9hakZ1UnRUVmQ3aGVESnFLOUlTcXBhWEgr?=
 =?utf-8?B?clB5NWxhUlJybjdCeWVoOVNzQXBUY3hBT3lKaWdwa2hjWWhrOS81Vml1T2Zm?=
 =?utf-8?B?bk9ZR2o5QmxRMmZJd1dNSm9hMi83SFY0ZVl6Qm9QS2dkMVVGc0NLMy9lSGto?=
 =?utf-8?B?dzEzZ1MvLzZvQ05wcFJyWitPNE1kZnl4dVEvc2JpMGR4eXBNNlM0NUlFdTda?=
 =?utf-8?B?MGU1SHFqQ3lqNEFSNm1OVnJPYW4rSHFleDV0NWZFZVJVMGlEaCtFVVJOWWsy?=
 =?utf-8?B?dVdKbnlEZEloMkZUSnJSTHJ1Yk5Yd1ROejJrV01scy9xV0RZOEl3MTYyVTRu?=
 =?utf-8?B?ODVTUGNjMmx0bXZyYW04SmR0Rmk5WEx2TkQ3U2ZJM2lPOG00d1MzOE1EMjMr?=
 =?utf-8?B?RW5hcVFPZ3pwRkdPV0c0eXVTTHpnY3k2d1E1MXRwT0hDMUxieFBDSS9FcHRX?=
 =?utf-8?B?Q0xiSmlUak5hNDcrQWFpMkF6ZGxiNlBQbmdDSWZIczRqdzE4VTJBVUVCU0Z5?=
 =?utf-8?B?TGxpOUNKQTh4dmJ1aFVZSlYrYm9QMkkrZE5WbUErcGNhNWJkYVVsZGJ2eTBX?=
 =?utf-8?B?YzZHZFplUDRPZUFHd0R6M1dpSktSS2hwSVFheVdwemxlS0pTRWQxcDFxQjdm?=
 =?utf-8?B?Q3FqSkxjTndLL3VSeUoxRVlIQUIvb2lWdmlWU3RrTlJMcVNpd0lkeUdwdWtu?=
 =?utf-8?B?SEVQcjd4R3ZGRGl5ZW9lL3VwYWJmbHZ5YWNpVGc4SXpaZGtkZCtRR1psRzFM?=
 =?utf-8?B?dkF2UjFkaTVhdGhET1BmSkxDTmYxUVA1ZVhsNkZPT0Z5N1RrUzJJaUNDTXNv?=
 =?utf-8?B?VUNWY2ZPb2UrRTdQcjlEK1dYWld2UHhWWUdPcEZEWFp3ZzhjdGhDRm5kNEVu?=
 =?utf-8?B?MXNPbGlyMjhWUGs0cWZLNUF1OHdaNitJS29oV0QveU5CRWpKTnJiK2szWnlj?=
 =?utf-8?B?ME0wTDZOcVB4TFo3N3FKamE0WlVZeHg2eldCdC82cFA1K3JkQmNYQlNFcFZo?=
 =?utf-8?B?MDdGTlBNZTB4cjYzdHJ1UzhpZE1OSStrdUhURHVMVlBUTyt4TGNDUm9wUDFt?=
 =?utf-8?B?RkR1N1ZOK3lmMWxKTFBsUjNXZzBHMWRqc0o1eEhSQmVJWjBIOHhYWmJ3OUQw?=
 =?utf-8?B?V1YrcjQrMXN2R2NRY0t1ZytGM29yczd4UjRweVlOY3hSYTg1bExaY1Y4Qk9S?=
 =?utf-8?B?bUsxT2NlcW9WNEk0dExQZjFGdGdIam9DL252eWVkMERSLzMrTWp6bCtnUnRk?=
 =?utf-8?B?UEZ0aTNibU5YZUh6M3Erd05iQ0ZrcXJrU2J3WC9vOG1UaXFmb2YwMFhYVzIr?=
 =?utf-8?B?NjlBS1VGaTY5N1lkKzJxeGpxenlLV0ZCYzZ6YmtLTjZxOUl3K1V4REdGN3hI?=
 =?utf-8?B?YW9HdHJyYWtvNU1UeWxMWGxTdDI3VVVVeTdOZTgyaFVibkJXVVh5UWs0bmlz?=
 =?utf-8?B?QXFDTjg1QWs4c3pvVi9EUE1rTGpCaUFtTDhVbGY1b2hBdXJIZ2xUY2xtcmZh?=
 =?utf-8?B?Q01BOHZ5b052SmxtclRLUUxIbXMxNkRocEExSXBZckh5SjFRQVBkMUhUU0lq?=
 =?utf-8?B?VmhtUkpqa3F2TXFrYmNycDQ5VHFHRkU4clJQaXR4RWoyUlB2WHJ1WE80SnZ1?=
 =?utf-8?B?eFlMckdHSkVQbDBHRkRVUXVHNmhUUWJ6SDFDTzcvY3BCTS9Mb01CUEFxQzJG?=
 =?utf-8?B?YWdXeFllWU4yS2VLeTgwb2NUYXUzVEZKTVhZc1liem9Ic3FoM094bXQ2bEsr?=
 =?utf-8?B?RFRmcmc3aW9QVHppb2l3MUZ6bWRseWRHMUVOU0ZIZHUxbUZ3WUNpMHVYVG9m?=
 =?utf-8?B?QWxDOHNTL29RVkZqNmlFUzVsSlBRMGNiZktLR2pXZHpXbkl6NkZkNG5WQlNM?=
 =?utf-8?Q?L4Zo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327de93e-7918-484a-96b7-08dc243dbbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 22:24:34.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntl4nc12m19apSgQz6V75f5l/dRA5BJlDMpGVgAsZ/ABZTJu4dcuoQpsHV6ikmzntFu2AXJTip0HshLz1U1MYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIsIDIwMjQgMTA6MjEgQU0NCj4gVG86IEJoYXJk
d2FqLCBSYWpuZWVzaCA8UmFqbmVlc2guQmhhcmR3YWpAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBHcmVhdGhvdXNlLCBKb3NlcGggPEpvc2VwaC5HcmVhdGhv
dXNlQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IHVwZGF0ZSBT
SU1EIGRpc3RyaWJ1dGlvbiBhbGdvIGZvciBHRlhJUCA5LjQuMiBvbndhcmRzDQo+DQo+DQo+IE9u
IDIwMjQtMDItMDEgMTM6NTQsIFJham5lZXNoIEJoYXJkd2FqIHdyb3RlOg0KPiA+IEluIGNlcnRh
aW4gY29vcGVyYXRpdmUgZ3JvdXAgZGlzcGF0Y2ggc2NlbmFyaW9zIHRoZSBkZWZhdWx0IFNQSQ0K
PiA+IHJlc291cmNlIGFsbG9jYXRpb24gbWF5IGNhdXNlIHJlZHVjZWQgcGVyLUNVIHdvcmtncm91
cCBvY2N1cGFuY3kuIFNldA0KPiA+IENPTVBVVEVfUkVTT1VSQ0VfTElNSVRTLkZPUkNFX1NJTURf
RElTVD0xIHRvIG1pdGlnYXRlIHNvZnQgaGFuZw0KPiA+IHNjZW5hcmlvbnMuDQo+ID4NCj4gPiBT
dWdnZXN0ZWQtYnk6IEpvc2VwaCBHcmVhdGhvdXNlIDxKb3NlcGguR3JlYXRob3VzZUBhbWQuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJham5lZXNoIEJoYXJkd2FqIDxyYWpuZWVzaC5iaGFyZHdh
akBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X21xZF9tYW5hZ2VyX3Y5LmMgfCA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX21xZF9tYW5hZ2VyX3Y5LmMNCj4gPiBpbmRleCA0MmQ4ODE4MDlkYzcuLjRiMjhlN2RjYjYy
ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdjkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92OS5jDQo+ID4gQEAgLTMwMyw2ICszMDMsMTAgQEAgc3RhdGljIHZvaWQgdXBkYXRl
X21xZChzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lkICptcWQsDQo+ID4gICAgICAgICAgICAg
dXBkYXRlX2N1X21hc2sobW0sIG1xZCwgbWluZm8sIDApOw0KPiA+ICAgICBzZXRfcHJpb3JpdHko
bSwgcSk7DQo+ID4NCj4gPiArICAgaWYgKEtGRF9HQ19WRVJTSU9OKG1tLT5kZXYpID49IElQX1ZF
UlNJT04oOSwgNCwgMikpDQo+DQo+IEFyZSB3ZSBzdXJlIHRoaXMgaXMgb25seSBuZWVkZWQgb24g
R0ZYIDkuNC4yIGFuZCBsYXRlciBHUFVzPyBEb2VzIGl0IGFmZmVjdCBvbGRlciBHRlggOS54IEdQ
VXMgYXMgd2VsbD8gV2hhdCBhYm91dCBHRlggMTAgYW5kIDExPyBJdA0KPiBzZWVtcyB0aGUgcmVn
aXN0ZXIgYml0IGV4aXN0cyBmb3IgYWxsIHRob3NlIEdQVXM/DQoNCk9uIGdmeDkgZGV2aWNlcywg
aXQgaXMgb25seSBuZWNlc3NhcnkgZm9yIEdGWCA5LjQuMiBhbmQgYmV5b25kLiBUaGlzIHdhcyBh
IHNpZGUgZWZmZWN0IG9mIHRoZSBtb3ZlIGZyb20gMTAgd2F2ZS1zbG90cyBwZXIgU0lNRCB0byA4
IHdhdmUtc2xvdHMgcGVyIFNJTUQuDQoNCkNoZWNraW5nIHdpdGggdGhlIGhhcmR3YXJlIGdyb3Vw
IChhbmQgcnVubmluZyBzb21lIGJhc2ljIHRlc3RzIGFnYWluc3QgdGhlIHByb2JsZW0gd2Ugc2F3
IG9uIGdmeDkgcGFydHMpLCB0aGlzIHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IGZvciBnZngxMCBw
YXJ0cywgZWl0aGVyIHRob3NlIHdpdGggMjAgd2F2ZS1zbG90cyBwZXIgU0lNRCBvciAxNi4NCg0K
VGhhbmtzLA0KLUpvZQ0KDQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZlbGl4DQo+DQo+DQo+ID4gKyAg
ICAgICAgICAgbS0+Y29tcHV0ZV9yZXNvdXJjZV9saW1pdHMgPSBxLT5pc19nd3MgPw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgQ09NUFVURV9SRVNPVVJDRV9MSU1JVFNfX0ZPUkNFX1NJTURfRElT
VF9NQVNLIDogMDsNCj4gPiArDQo+ID4gICAgIHEtPmlzX2FjdGl2ZSA9IFFVRVVFX0lTX0FDVElW
RSgqcSk7DQo+ID4gICB9DQo+ID4NCg==
