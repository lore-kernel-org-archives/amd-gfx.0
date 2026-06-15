Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0F5CD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 03:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F346C10E15F;
	Mon, 15 Jun 2026 03:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/wGQGiS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39A110E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 03:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnEZRuBH5khrkJy7FP1WForK5Q+pmt+QXk5tohGgk7w+hYrDVmyLISEZCAHidR+F57/vw/irvibA4Tz9fFdx4EY79DI7nC/kfo4ubuLIaE5MvBrNLjh5oAaeP3ZlR1g1AMFuvQ3nqRBKZnnGsT9CsxNKQVxAEWob3ePqUH7tkL9aIaXMHJvtb4ukmHijtng2yKBwZMy0xp7ral1HdrQanv303lfcDzxOH359NT6EJV5xygkntamZtve0UX8aDzlVI7rZPafsjXJGGabnRKmf4DzleD5MGhteM/MN88pOycKOCEBGF2EN8x3VFoHCIcvbiMw0PwAMYW67JF8ofUWkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54YeMVMcfWuku1qXHCLqTzvWKUIV97t6cXjsU1JIGJI=;
 b=DA1uE9GJ86mMzQtj7D8+xOeYZ/QhFHzAobPJanyeF06niR76SeH76Ygr1sJn45LTtDpS2/FlbgXRLki6VCNS3pNXDwNj5A4WUQYx6COJf37pykpBjgbmV6CBecUJgBguGglXRYE5/ZDThxVYjITBb64hM82Oj8QzBkxZKb7hz5a1GyBnzP23ZU1gplmTbStBbUDinXzgBiAr4x0j/Elim7PmzljZa+M6o3htNerOsCRdEuMV6W39Q1ifDNYGe4U3Zg76fJVecq5D2JklLsiqH0/lVvrWMslIjuHxi5ZEXH59mkrgX9ZIstDXyO/22zR6Rw5+cmX5OR5Zl2Ulhp4EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54YeMVMcfWuku1qXHCLqTzvWKUIV97t6cXjsU1JIGJI=;
 b=a/wGQGiSxPKLYcm/TX8SQ1NmYaUuKdsqnDKaftiwhXToEZovvOCmCREzgzmy7a5t9AV0lHqDyHsc31mPWgSeX8nAyAYH6zq8JUBujeUrysuGIH0rZHKPQauPT69MKGZISXbL8t2lREE15XHdjrr4QRt/QPbzrEGkKFYHQFayfCE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 03:30:56 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 03:30:56 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Samuel Pitoiset <samuel.pitoiset@gmail.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Huang, Ray" <Ray.Huang@amd.com>, 
 "Huang, Trigger" <Trigger.Huang@amd.com>
Subject: Re: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Topic: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Index: AQHc+k2q9b5w7Gm1S0ehEOsc6P5NrLY67KOAgASTYYA=
Date: Mon, 15 Jun 2026 03:30:56 +0000
Message-ID: <BL1PR12MB584949DEE49487857338AD59E7E62@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
 <4951358.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <4951358.vXUDI8C0e8@timur-hyperion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.21.0113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB6606:EE_
x-ms-office365-filtering-correlation-id: db5fc7b7-b3fb-4b92-9196-08deca8e82eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: oJaKVBL9Fk/RagKPPmlGMDZcio9wVBq62hB6q2COocMFYgrZFDeg4riY7n3YI6H+JOHb255HbTsU00ZNWldCSvIOCizzxlAqTZS8EM0fJHpthK7uxM8Q5Tjw6CxaqtQQ/31+8Dh/QjrsLyEzNGTF8w/4BE0PfYbZF+7gl0OeCB5dWbCDmgJh1tQ0LHql2ITd8TdisU0buxjVMwlJsRkPRlgXDEUbvdYLjtKyBF+oBGksiKbhZNbwhC7YjnNP0JZSMnlMbmdlwjkD3u+8zavQIkhvmVHG9lGCtl34k5KkktEcJHm5N2/TyV3QXhJOr2JMPDFJzPHHt67EOwkqEMMrgO93axPCVKtY91dHmItOcsU+jWsX4iYebBq95boA6o/CLqQPt3YtOt+eQCHQKANPQ7TrnwqFUli0RrF0B26BHPVwm5RhSdAw6zhkMKN/iMnLbvOZRDQc/ubqMGLwmL2KSdV30/cKx69z4YSnA3bFXlQS5ghxr2BQaAfRHc6qX9XUyh06tbRXj5oMCVKKQPNN6xtijy+5u0jLbcaFhmdbpdnPLTxhcz0Rnub2gfQ9WgJEmMCkyX7DYAOVbXAesT4736fgVfqjp8vUf3qwVFrvjZd9fAeO0GGamD+8ekq7PREu+byFzOlw2ERT3izQDmuO9rmMr2ZHHVEjtzv5yTfFHe0yYXbzMcNP6WSBmyHZ1HN3Bsg2e7Xp/PQ9YZPlkLRA9PVBcjkFSix8VWdziOZLb/jCRtsWxA1c8bdpbELR9beM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFNETUN4alcvL00yTkNFdHErNlFvRHA0ZVdSbytQc2FpY251ekFRa2xDVE0z?=
 =?utf-8?B?QnQzclNGWDBKTWh4RnQ4c3pDUW5oY0tiS3BzQ2M3Snp1VFdKRXd6TmN4dGdi?=
 =?utf-8?B?SUxTbm9ndGVFZlVTTGx5c2VPeVNlQW5KdlhwQ3ZHbXpxQWkxc2s5NmFoUWUz?=
 =?utf-8?B?WlQxbDJ5VXByaEJGRXlqNmhUZmZVdU1CSGVZWG5mTmdPNmFnaXhucUZNMXN1?=
 =?utf-8?B?dXZWQkJZcmpIVmdrMjYzSkh0c1pTVkJhNjh0dnpQOFlycmdla3dZanRROVNh?=
 =?utf-8?B?R3k0WVl5MHhmTmxwNGJIakRoVFJrOEJHaWUrVG96dXUwbS9Dc0RndTA3bGZ6?=
 =?utf-8?B?dEk2TUNOVEhQbGN4OGYwdjcxbG14M2Vza3B3UEJDNytQM0tRTzd4bVNkUTlN?=
 =?utf-8?B?ZkwxR3F3VnRoc2tWSWZwNkZGZ0VjYUJjajhjdTY0U25KZGtmWlQ5alJHeWU1?=
 =?utf-8?B?Q3E4cjZ5ay9LVzdQcFE3dm81bmtlT2FDT3J2c0N0Vmd3YjhkdkhiSGtTQVJM?=
 =?utf-8?B?WGdmUitqYVhuRnQvNnFXb3oyS1dIVDA5NU4yRDNJbjVsQkJZRU84R01rcnlo?=
 =?utf-8?B?T0haU0x2TUFGM1ZIbmJadWJ6MWdLZGROckZ0U1NvY2lMU3dSRFpXaTJlWUR6?=
 =?utf-8?B?dVNGa2RmOGUwMkNyYi9uSGJMWkFzdU1vSmxaSGRNQW1HdUJ3V3JLSjk4ZnNn?=
 =?utf-8?B?dmdxR0Y1amhMZlFTZE4zSDBsZ3gwaVAvdmk3TXVhUlRxVXQ3OVRwT2ExdmVI?=
 =?utf-8?B?cncvMU56eldjeHR4VTZLa1EyTmEwamIwa2pHbktWT2t3ZU11R1Bmbjc5V29a?=
 =?utf-8?B?U1crcTR6SUZsSW1DcjRYK3ZDK2F0NE9XZ29reGl4cjZsQVgyUE5oVXpwb01J?=
 =?utf-8?B?MHg5dHA1c09LMkY3ZGp1L01rTmhpQUd5bklTM1pMWnFZU3lvM3pZU05hQkZG?=
 =?utf-8?B?Y1VhVHpqcFRtL3RmZHl4K1dKMTBGN2VJTm5XWm9FUkZKZjNjQTZCSHpsa2tm?=
 =?utf-8?B?U2M4M1cxR2tlRW1mTXgxMWdLenR2OFcxSTkvNE4xemtpSGV4aVVScnhrcWl5?=
 =?utf-8?B?dUt4SFpySmxRa2ozWC92ZUluRWpDN3U0WW15SnlBb2Y5K2pWSk5zQ3h6RU9i?=
 =?utf-8?B?K2pDZ2lGdUpjWGExZDhLVmVVMHN5WFk4ZWNwYWxISmdEeTQycGJBelRqV2ZU?=
 =?utf-8?B?Zkl3bmlVWENjUktYb25vMEY5Rk10UWI5U0JsL2djdE0xYm1BVkEwYm5XZTdY?=
 =?utf-8?B?ZnZ1MWdrbk5nTitxRC8vSVA1b2pQUGlSdjJmS0lFYm5CcEN3L09vdU5rdy8x?=
 =?utf-8?B?bWRGVGltUzRIdkhQVndOMGdhMWo4MTVJeXVlSStqUlJZK1d2b0Q4WGw5QklD?=
 =?utf-8?B?UlA2YWhwcEFyVnJlWm1WKzFYdGxwSTM2QVN5ajZaaFgwS3RkajQ3KzR3ZUJ4?=
 =?utf-8?B?RUl1YW1yNG5SV3I4WEZJZGR2RmlNWjNzV09DVWd4cGNtbVRUYVZMZThJZFhG?=
 =?utf-8?B?RVJWZ0R3M3ZGVUNmNnFPVWJMNU0yMDJ6a01QVFJKQkpSNEF5cUgzYUNpTFha?=
 =?utf-8?B?NHV6ZVpyVEF6WmpxanMwTERWaGtZYUpadUhtQVU0VEg2T2xRdm41OEp0WDdI?=
 =?utf-8?B?UHNYT1lDQldETXdnbWo2VTBLREkvQ3A4WVhtRmd5MEMzRy9Nd3VFOExBZHBy?=
 =?utf-8?B?VmVrZHpGaFhwalJyNklsQ29iN3loUEJEUGIwNDJNMndrUnRrdmlSOVZucEtj?=
 =?utf-8?B?K0ZiVzYrUHJ5RmxWVFlpOWhvV0xyYjR2TU44ZXZyeVJIbHVMemdiSDVmdnF0?=
 =?utf-8?B?dStBZkU3L3JjT01JdGF6NFZCNFJEY1ZBKzRxdVNwS2tZdUxuUXlrTFFNMk85?=
 =?utf-8?B?WVAwUDR0OUxMLzczcE91bGN1TGUyRUVIRDdOQ05QQnFXL3p3b3M2WFR1NDVs?=
 =?utf-8?B?Z2JGaXBnL1pBTHluY1p0Q0ttbVFpZG9GMElvRXROcFhFT0t3MmQrM1hyZlV4?=
 =?utf-8?B?cWRVbWJrRHJNZFQzMHJUUG0vajc3SmRxSC94ZGF4QkY5YnRoNFJmdDk5Mzcy?=
 =?utf-8?B?NUFOWTI1enh4SmxiWTJIOUxLNFJyZlR5OUpCalV6UkEySStPak9OYVhOOWgz?=
 =?utf-8?B?VnJieXhoTXlQNFFQcE9TNE5FdVI4MWNjODUvKzF5UlRjb2JYQXpYcHNmZlk1?=
 =?utf-8?B?Unp1SlpYTFJSSTUyZVIycVp4UGZDRTQwN0ZPTzdkZW80WkdlejhYMjhEMjEy?=
 =?utf-8?B?Yy9HeTVsOHNkOTZnZ1NuM0p6K0xZZ0M4ZHhzV0dBWkpZbHNwaDUzRjlST0Vv?=
 =?utf-8?Q?D+gYu8DHiO3v550OHu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30421A0395B2FF408FD11B08FE6FA925@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5fc7b7-b3fb-4b92-9196-08deca8e82eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 03:30:56.3277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZsXa5jQZZeCkYBiBWGg4I06JeeWqvlToZzUVOIZMETkV1lDI0ZCygccgzHUnHam4xd32zGKyUOOmWO2G8k4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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

T24gNi8xMi8yNiAyMTozNywgVGltdXIgS3Jpc3TDs2Ygd3JvdGU6DQo+IE9uIEZyaWRheSwgSnVu
ZSAxMiwgMjAyNiAxMToyNjo1NOKAr0FNIENlbnRyYWwgRXVyb3BlYW4gU3VtbWVyIFRpbWUgSmlx
aWFuIENoZW4gDQo+IHdyb3RlOg0KPj4gRm9yIFJlbmlvciBBUFUgd2l0aCBnZng5LCBpbiBzb21l
IHRlc3Qgc2NlbmFyaW9zIHdpdGggZGlzYWJsaW5nDQo+PiByaW5nX3Jlc2V0LCBsaWtlIGFjY2Vz
c2luZyBhbiB1bm1hcHBlZCBpbnZhbGlkIGFkZHJlc3MsIGl0IGNhbg0KPj4gdHJpZ2dlciBhIGdw
dSBqb2IgdGltZW91dCBldmVudCwgdGhlbiBkcml2ZXIgdXNlcyBNb2RlMiByZXNldA0KPj4gdG8g
cmVzZXQgR1BVLCBidXQgYWZ0ZXIgTW9kZTIgY29tcHV0ZSBSaW5nIHRlc3QgYW5kIElCIHRlc3Qg
ZmFpbA0KPj4gcmFuZG9tbHkuIEl0IGJlY2F1c2UgdGhlIEhRRHMgb2YgTUVDcyBhcmUgYWx3YXlz
IGFjdGl2ZSBiZWZvcmUgb3INCj4+IGFmdGVyIE1vZGUyLCB0aGF0IGNhdXNlcyBNRUNzIHVzZSBz
dGFsZSBIUURzIHdoZW4gTUVDcyBhcmUgdW5oYWx0ZWQNCj4+IGJlZm9yZSBkcml2ZXIgcmVzdG9y
ZSBNUURzLCBhbmQgY2F1c2VzIENQQyBhbmQgQ1BGIGFyZSBzdGlsbCBzdHVjaw0KPj4gYWZ0ZXIg
TW9kZTIsIHRoZW4gY2F1c2VzIGNvbXB1dGUgUmluZyBhbmQgSUIgdGVzdHMgZmFpbC4NCj4+DQo+
PiBTbywgYWRkIHNlcXVlbmNlcyB0byBkZWFjdGl2YXRlIEhRRHMgb2YgTUVDcyBpbiBzdXNwZW5k
IElQIGZ1bmN0aW9uDQo+PiBvZiB0aGUgcmVzZXR0aW5nIHByb2Nlc3MuDQo+Pg0KPj4gdjI6IE1v
dmUgYWxsIHNlcXVlbmNlcyBpbnRvIGEgbmV3IGZ1bmN0aW9uIGdmeF92OV8wX2NwX21vZGUyX2Ns
ZWFyX3N0YXRlDQo+PiAoUmF5IEh1YW5nKSBUbyBjaGVjayByZXNldCBNb2RlMiBtZXRob2QgaW4g
dGhlIGlmIGNvbmRpdGlvbiAoUmF5IEh1YW5nKQ0KPj4gdjM6IE1vdmUgYWxsIHNlcXVlbmNlcyBi
ZWZvcmUgTW9kZTIgaW5zdGVhZCBvZiBhZnRlciBNb2RlMiAoVGltdXIgS3Jpc3TDs2YpDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IA0K
PiBMb29rcyBnb29kLCB0aGFuayB5b3UhDQo+IA0KPiBSZXZpZXdlZC1ieTogVGltdXIgS3Jpc3TD
s2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KVGhhbmsgeW91IHZlcnkgbXVjaCENCg0KPiAN
Cj4+IC0tLQ0KPj4gdjItPnYzIGNoYW5nZXM6DQo+PiAqIE1vdmUgYWxsIHNlcXVlbmNlc3MgYmVm
b3JlIE1vZGUyIGluc3RlYWQgb2YgYWZ0ZXIgTW9kZTIsIGFuZCBhZGQgYSBuZXcNCj4+ICAgZnVu
Y3Rpb24gZ2Z4X3Y5XzBfZGVhY3RpdmF0ZV9rY3FfaHFkIHRvIGRvIHRoZSBkaXNhYmxlIGNvbXB1
dGUgSFFEcw0KPj4gICBzZXF1ZW5jZXMuDQo+PiAgIFRoZW4gdGhlIHJlc2V0dGluZyBDUEMgYW5k
IENQRiBhcmUgbm90IG5lZWRlZCBzaW5jZSB3ZSBoYXZlIGFscmVhZHkNCj4+ICAgbW92ZSBhbGwg
c2VxdWVuY2VzIGJlZm9yZSBNb2RlMiBhbmQgdGhleSBhcmUgbm90IHN0dWNrDQo+Pg0KPj4gdjEt
PnYyIGNoYW5nZXM6DQo+PiAqIE1vdmUgbXkgc2VxdWVuY2VzIGludG8gYSBuZXcgZnVuY3Rpb24g
Z2Z4X3Y5XzBfY3BfbW9kZTJfY2xlYXJfc3RhdGUNCj4+ICogQWRkIHJlc2V0IE1vZGUyIG1ldGhv
ZCBjaGVjayB0byB0aGUgaWYgY29uZGl0aW9uIHRoYXQgY2FsbCBteSBzZXF1ZW5jZXMNCj4+DQo+
PiB2MToNCj4+IEhpIGFsbCwNCj4+DQo+PiBNeSBib2FyZCBpcyBSZW5pb3IgQVBVIHdpdGggZ2Z4
OSwgc211MTIuIEkgcnVuIGEgdGVzdGNhc2UgdGhhdA0KPj4gYWNjZXNzZXMgYW4gaW52YWxpZCBh
ZGRyZXNzIHRvIHRyaWdnZXIgYSBhbWRncHVfam9iX3RpbWVkb3V0KCkNCj4+IHdpdGggZGlzYWJs
aW5nIHJpbmdfcmVzZXQsIHNvIHRoYXQgZHJpdmVyIHdpbGwgY2FsbCBtb2RlMiByZXNldA0KPj4g
ZGlyZWN0bHkuIEFmdGVyIG1vZGUyIHJlc2V0IEkgZm91bmQgY29tcHV0ZSBSaW5nIHRlc3RzIGFu
ZCBjb21wdXRlDQo+PiBJQiB0ZXN0cyBmYWlsIHJhbmRvbWx5IG9uIHJhbmRvbSBjb21wdXRlIHJp
bmcuDQo+Pg0KPj4gV2UgY2hlY2tlZCB0aGUgc2NhbiBkdW1wIG9mIEdQVSwgd2UgY2FuIHNlZSB0
aGUgQ1BDIGFuZCBDUEYgYXJlDQo+PiBzdGlsbCBzdHVjaywgdGhhdCBjYXVzZWQgQ29tcHV0ZSBS
aW5nIHRlc3RzIGZhaWwuDQo+Pg0KPj4gSSBhZGRlZCBwcmludGluZ3MgaW4gZHJpdmVyIGNvZGVz
IChnZnhfdjlfMF9jcF9yZXN1bWUpLCBhbmQgZm91bmQNCj4+IHRoZSBIUURzIG9mIE1FQ3MgYXJl
IHN0aWxsIGFjdGl2ZSwgdGhhdCBtYXkgY2F1c2UgTUVDcyB1c2Ugc3RhbGUNCj4+IEhRRHMgd2hl
biBNRUNzIGFyZSB1bmhhbHRlZCBiZWZvcmUgbWFwcGluZyBjb21wdXRlIHF1ZXVlcyAocmVzdG9y
aW5nDQo+PiBNUURzIHRvIEhRRHMpLg0KPj4NCj4+IFNvLCBJIHNlbmQgdGhpcyBwYXRjaCB0byBm
aXggYWJvdmUgcHJvYmxlbXMuDQo+PiBUaGVyZSBhcmUgdHdvIG1haW4gY2hhbmdlcyBvZiBteSBw
YXRjaDoNCj4+IE9uZSBpcyB0byByZXNldCBDUEMgYW5kIENQRiBiZWZvcmUgcmVzdW1pbmcgS0NR
Lg0KPj4gQW5vdGhlciBpcyB0byBkaXNhYmxlIEhRRHMgYmVvZnJlIHVuaGFsdGluZyBNRUNzLg0K
Pj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDM3ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBpbmRl
eCA5MGJiZGRiNDU3MzAuLjBjMDE3MDE0ODhlNw0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiBAQCAtNDA3MSw2ICs0MDcxLDM5IEBAIHN0YXRpYyBp
bnQgZ2Z4X3Y5XzBfaHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrDQo+PiAqaXBfYmxvY2sp
IHJldHVybiByOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfZGVhY3RpdmF0
ZV9rY3FfaHFkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gK3sNCj4+ICsJZm9yIChp
bnQgaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3M7IGkrKykgew0KPj4gKwkJ
dTMyIHRtcDsNCj4+ICsJCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5nZnguY29t
cHV0ZV9yaW5nW2ldOw0KPj4gKw0KPj4gKwkJbXV0ZXhfbG9jaygmYWRldi0+c3JibV9tdXRleCk7
DQo+PiArCQlzb2MxNV9ncmJtX3NlbGVjdChhZGV2LCByaW5nLT5tZSwgcmluZy0+cGlwZSwgcmlu
Zy0NCj4+IHF1ZXVlLCAwLCAwKTsNCj4+ICsJCXRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1D
UF9IUURfQUNUSVZFKTsNCj4+ICsJCS8qIGRpc2FibGUgdGhlIHF1ZXVlIGlmIGl0J3MgYWN0aXZl
ICovDQo+PiArCQlpZiAodG1wICYgQ1BfSFFEX0FDVElWRV9fQUNUSVZFX01BU0spIHsNCj4+ICsJ
CQlpbnQgajsNCj4+ICsNCj4+ICsJCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfSFFEX0RFUVVF
VUVfUkVRVUVTVCwgDQo+IDEpOw0KPj4gKwkJCWZvciAoaiA9IDA7IGogPCBhZGV2LT51c2VjX3Rp
bWVvdXQ7IGorKykgew0KPj4gKwkJCQl0bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAsIA0KPiBtbUNQ
X0hRRF9BQ1RJVkUpOw0KPj4gKwkJCQlpZiAoISh0bXAgJiANCj4gQ1BfSFFEX0FDVElWRV9fQUNU
SVZFX01BU0spKQ0KPj4gKwkJCQkJYnJlYWs7DQo+PiArCQkJCXVkZWxheSgxKTsNCj4+ICsJCQl9
DQo+PiArCQkJaWYgKGogPT0gQU1ER1BVX01BWF9VU0VDX1RJTUVPVVQpIHsNCj4+ICsJCQkJRFJN
X0RFQlVHKCJjb21wXyV1XyV1XyV1IGRlcXVldWUgDQo+IHJlcXVlc3QgZmFpbGVkLlxuIiwNCj4+
ICsJCQkJCQkJDQo+IHJpbmctPm1lLCByaW5nLT5waXBlLCByaW5nLT5xdWV1ZSk7DQo+PiArCQkJ
CS8qIE1hbnVhbCBkaXNhYmxlIGlmIGRlcXVldWUgDQo+IHJlcXVlc3QgdGltZXMgb3V0ICovDQo+
PiArCQkJCVdSRUczMl9TT0MxNShHQywgMCwgDQo+IG1tQ1BfSFFEX0FDVElWRSwgMCk7DQo+PiAr
CQkJfQ0KPj4gKwkJCVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9IUURfREVRVUVVRV9SRVFVRVNU
LCANCj4gMCk7DQo+PiArCQl9DQo+PiArCQlzb2MxNV9ncmJtX3NlbGVjdChhZGV2LCAwLCAwLCAw
LCAwLCAwKTsNCj4+ICsJCW11dGV4X3VubG9jaygmYWRldi0+c3JibV9tdXRleCk7DQo+PiArCX0N
Cj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIGludCBnZnhfdjlfMF9od19maW5pKHN0cnVjdCBhbWRn
cHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPj4gIHsNCj4+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBpcF9ibG9jay0+YWRldjsNCj4+IEBAIC00MDk1LDYgKzQxMjgsMTAgQEAgc3RhdGlj
IGludCBnZnhfdjlfMF9od19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sNCj4+ICppcF9ibG9j
aykgcmV0dXJuIDA7DQo+PiAgCX0NCj4+DQo+PiArCWlmICgoYWRldi0+ZmxhZ3MgJiBBTURfSVNf
QVBVKSAmJiBhbWRncHVfaW5fcmVzZXQoYWRldikgJiYNCj4+ICsJCWFtZGdwdV9hc2ljX3Jlc2V0
X21ldGhvZChhZGV2KSA9PSANCj4gQU1EX1JFU0VUX01FVEhPRF9NT0RFMikNCj4+ICsJCWdmeF92
OV8wX2RlYWN0aXZhdGVfa2NxX2hxZChhZGV2KTsNCj4+ICsNCj4+ICAJLyogVXNlIGRlaW5pdGlh
bGl6ZSBzZXF1ZW5jZSBmcm9tIENBSUwgd2hlbiB1bmJpbmRpbmcgZGV2aWNlIGZyb20gDQo+IGRy
aXZlciwNCj4+ICAJICogb3RoZXJ3aXNlIEtJUSBpcyBoYW5naW5nIHdoZW4gYmluZGluZyBiYWNr
DQo+PiAgCSAqLw0KPiANCj4gDQo+IA0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4g
Q2hlbi4NCg0K
