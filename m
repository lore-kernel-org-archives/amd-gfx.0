Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70CD3515C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 09:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DD810E342;
	Wed,  1 Apr 2026 09:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s69xmHiv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5101010E332
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 09:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrLakriXQZ4tNOv0C3aKOwCr326czq2JRRNjcVaCDNVgAVv1dQZMhtd1vPKiAvhjxpLRPA8hUFcGjpjlwG8VxGRTaR/BTzbjvzwXt1nUlIQHhGNy+p/8ww+8a25JLhYOC8wgyOgEUJRPFzhEYeOsNJpXtomsdWXHsyJv3qUE0DmZIe8jlFd8BYA1kToajw+k3Cf5UNE+7CqMKlUpEfKy7POuIhELM5NMGETSMLTOZrfIaUxIO4B/O1FbslNyXxZDwZQuMOOJMKV887SXZA2znMSmAoE7gPNGe7vGuQHCKiaGlZ+QM2l3CnMebcvpvzBVBbA1g2Mxb/FFWJtj8X3YuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYO3qE3mVl4+Q7aUlpRda9pXeuvQfXpZ2Gm5fJ9XjU4=;
 b=VtsQ8ck4w9Fzg2R6CARygQIeL+cZz0ttMSPY/VXu+yHn9l/cy0Kxo1vG2o56ZmTupvbA9N/UgdRw2Nf6nk0NMrGoLzxPxuK7xc85jkvuIsPuHkFhiQwcmZnhmtSRMD2y/4EGgFopGXxOFtyPurnXa5rjZDF3pP4Jhz+lLeSindjdM0vG5kazO2+RHqfGMAmtctrdW3j6h8galhDzFjMoPGqU1P440sFu/FqvjYaVigvu+dYbekBkv7u8IE8dnfXHIIBWF2UtshWAQ9WC5vnX1KywWmDy6Z/BYw8+Qwoi8N4hmHaAbLdbieRCS5ma+JkMGbY8JVQXLJSBMBDPK6XNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYO3qE3mVl4+Q7aUlpRda9pXeuvQfXpZ2Gm5fJ9XjU4=;
 b=s69xmHivKcR8dxzh2buS5yCm+bSgBhqCu0vwvrGCF1cH2+v7m8mbLQx2Juh8fY8nCw0j9m7iY3hQSXgyAMsaWLReg8QfLM6ycVVnnG/w5feAQ8h22j/Xgv1FHyOBEVgrY0z1QXCBRAcjl8zAp+Y7rpct4/lg3S8YNWIWRPBpYh8=
Received: from CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) by
 SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 09:56:16 +0000
Received: from CO6PR12MB5409.namprd12.prod.outlook.com
 ([fe80::653:a9b4:ba49:49c9]) by CO6PR12MB5409.namprd12.prod.outlook.com
 ([fe80::653:a9b4:ba49:49c9%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:56:15 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
Thread-Topic: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
Thread-Index: AQHcvQyJBMZqBIzLOkOVScnH2Sj5TrXIiemAgAF3MfA=
Date: Wed, 1 Apr 2026 09:56:15 +0000
Message-ID: <CO6PR12MB540914C9DBA3511BFD2B7513E050A@CO6PR12MB5409.namprd12.prod.outlook.com>
References: <20260326103656.487304-1-YuanShang.Mao@amd.com>
 <20e41c6f-811e-459e-aa33-2e864f04ab87@amd.com>
In-Reply-To: <20e41c6f-811e-459e-aa33-2e864f04ab87@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Philip.Yang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T09:54:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5409:EE_|SA3PR12MB8803:EE_
x-ms-office365-filtering-correlation-id: fc0bf1d9-ddd9-4262-c4bc-08de8fd4ea1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: A0gyRGBEDHto51w0Wg+MLtR8dVjppjk3bDb9jCJpElG/H5kNJUJy4tpdruoPRbCncFQfuBpP5/NGFtuJUoV8Me4Ww9naHDScGhaxrQrPw7W1aAny0SlnqTzFSzLhY5qum571O2oDioF8skPqTHqVXWlqw4eeY63JGveEtozT8Zj6qb73FrFQHXdmLzbkopIdJvkQWN3+7pbJDFAC1K/kAxuptTaRezivLmAkGeRQEllKaJM3bhRjD+x/+eXcoqveod0Tx/PcA2YRIuddht2DwZaOf0X6PMncr9XsV/rMP+7f73JSe5hDJ0/Qty8mtheOyBUkTbnMNQvIZEPHvf2/BcwqWM/FbUoRSvDwgqHLxViCZg2fBHtnxTQg37vbZE4TPfoMVF+z/AF9vRNH46TAFwPBDMWMeQeHQUMuvfw2LCb+PCtUFP0Ph+6DkQQKfrvGdNsgb0UR81ndgRGK2M8ijLJgbBYunx4foOHS8IiD/ieZzm3Cr5hfLee/PiGPfdYUEpIh4yAwbJ8WEhvWJkU75F62FZrGBZmuasEkF5n88fKCqW/Z29mLuZ1rUb4Saz+ptdhQEUlIuxO/ifjZqBjh5N17HD3QR96kNyLNimjXpsNWQl/KgTB2dc9XgF2COVWk5auLs0u5wJRm5vim5rFCG8AflFdfgpc5Xn/tsne2sAnaDcYSBSer49nT4P+LDxcJflrbLIoO9WdwCBXmo5+y8UMugIs6Rvzq0FAQxBnWy3LiGTnF9QPj6JsZJd52ZC0AX85wN/qOXlzOakBh6/0BpeRQ0ueypNrmHjhLkVEhSDw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlRTDZPM0N5Wkx2c0V1QTk3c21uWjNJaWNhbS9QOGVUN2N5QWJKK282b05H?=
 =?utf-8?B?azV5cWc5MzNIWEtnS3prK09nblVkekZzSGFaTzBHVFd0Q0Z5WW5NZXV1cVI3?=
 =?utf-8?B?cVIvMjZXUlRKTmFUcHNHZ1p1SFE1MVkrLzVBM0RIMGJyVGZnbDVRbXZLN0Vh?=
 =?utf-8?B?Z2E5bStSMHZQbFhUQWJjbXFlcmFFODNUa05GSVllRG93SGVaOWdxSHc4RXdY?=
 =?utf-8?B?aDVEd3J6ajRZdjMzRk1xK3pPdmt6N2g0NGVBdis2aG8xajlhVGp4eFh4V29S?=
 =?utf-8?B?eElsTnRmYTg1dUEzZjVGSkRqemREalVRN1ArWThWcUNvN2haSGR0Wkg5dHBC?=
 =?utf-8?B?dXNvdUkvSFArWkl1RFhNWHN6NEtLdERidTF3UHVNc3dvT2JCS3lJUTd6Vk5k?=
 =?utf-8?B?LzZkU2JLMFRmNHpEdDRJbnd0WDQ2YnFJVVRGZkpmYU5DU0c2eTNnZ29KTStx?=
 =?utf-8?B?aVRzcEhuY3RhVUZUbllGbmgrL2xRMXZ6QkFLaUJZSm1DTUJBTXRFdXdCVzZH?=
 =?utf-8?B?dHJNOWdGK1FjSzQ0dndSbDljNjR0U2VuMU1qWitwRUIzNlRjQjBGemYvTld4?=
 =?utf-8?B?dTRHV0FHZVpqN1dWWTFPYnhabnRsR1VNQkxmRlRBaHE2RW1vMVJ5YkZ1ZXZV?=
 =?utf-8?B?Z0EvUmdROXdRMmpqUytMazJzZDd3RFgrOXBRWkc4R3R1cjZRMVhUZ29SSUhE?=
 =?utf-8?B?T20vNTZGa2xKOGcxREVnaDMxR283ellFVlJxdk5GdFUvV3lUVkNmS01oOWlB?=
 =?utf-8?B?KytiZENWVTRXZGhyRHROTlY0WEJZVlVPSE5LUitPT0E1M3laUlJBc01TcUxK?=
 =?utf-8?B?b0E2Ylg0czhudGlTeXZFNUFBRHBYWVJTK3pMTHh4L0hqTG5NQVdiQVdqVkVH?=
 =?utf-8?B?MmUwcUJDRmJXYVN2Z05tdW53Q3Z0MmNPZzJSdWlST2VFWksxVmZRa2lkUWVJ?=
 =?utf-8?B?c241ajdsenY5YnkybCtyQ3kxNUNDaUovOTdEMTBiOWx1NFJubWd5dk9SbTN3?=
 =?utf-8?B?NnBoTm4rdDh5ZlhvTWFDdWRJMFljeWlnNER4TkM3ek1ZemU4UjE5blhvdU8v?=
 =?utf-8?B?cDR2SDRIQVlNTEV3TTc1TWttK1RRZUlQZkhVVEVjSlhYRE1HbTh6dzRqU0NN?=
 =?utf-8?B?VkxXOE1HaWt2aTZQRWRwVGlFTHBRc3A1OUp0MlNLMndZUVF0TVFsNmIxSFRP?=
 =?utf-8?B?UlArelRITzMrS2NhOXQrQXl2S084NGo4SzRycUNpVGxTSFZyczg3ZnhhY3Ns?=
 =?utf-8?B?bTlBakc2WjJnNXYxdTYwcUJNWVJvZE5Ea0Faa2UraUgwQU16UW5zZnB4R2V3?=
 =?utf-8?B?RitoeWNNUUQwbEY0cGpQeHJKamQzRnYzWSt5YkdSVUlRZ241MlRtVTVuZDRh?=
 =?utf-8?B?RmY5cXpqZFZSZlU2UTNBT1IySkYxZmVOeExIZEllNVpORThwWElOM3FLTXBw?=
 =?utf-8?B?T0pqQnpIaTFxdGlkUUExdVZ4YzkzNFdFL2p0SmJUWEw0V3pVWmJ4Snh4MWFX?=
 =?utf-8?B?b2dWcFAyM2U1QXNWdXdGMDBnMkpBZ29ZSlViUk4zS2ZsYjVZa003Nm13RXYw?=
 =?utf-8?B?Q2Rjenlvd0E0LzByZGlmZ1ZNMWNrMEM4bC8rdjN6akRVR2xxeE9NUGVwOXBZ?=
 =?utf-8?B?RTBHNkxHU2ZTajBFaDBvajFwK2NEVVNTYVZQQndOWDBwcERvdFAzMnNkbENY?=
 =?utf-8?B?YmJMSG5ROVdIYUpPOXcrbFVFU3o5OFR0cE85eUZrUVc3Z3hydlhUT3dIYXBE?=
 =?utf-8?B?WlNURU5ma3k5NXVxZG8vd1RnZUkxR1hyOW5EZWNhWEtPMUpndVp3UFJRY1ZK?=
 =?utf-8?B?SjJOcXgwTkdZbTg2MXhuLzZYZ25SM0tvcG1qQ2RQRXVFV2pHSVZUeG9ENkdE?=
 =?utf-8?B?MEF0dDVTQjVQWnV4UmhFYVJLekgvc0N4eURXSU1LMTF5V25FVlNJNVZabCtG?=
 =?utf-8?B?cGJCVzd2aklKbE9lL1F0MWpqdkNiR1NORHJPcE0zY0d2K0UxRUJuMUNhK3ZY?=
 =?utf-8?B?TTViditZRmpPZC80OWRma1BLK0Q3bEZxRUMwSUtCaTN5aVhaL2UrNGVXNENi?=
 =?utf-8?B?TTA2TUpBZjBzV2hxYUZtTW93Z1VQRDErR1ROYllRVUlyQk93Y1BYYzR3VmpE?=
 =?utf-8?B?Wk80aGw5aFhMalh4cmM3cWpiSHFKcUhNK0NsZnk1MnpaK1BpOGl5MDVXbWFs?=
 =?utf-8?B?TFNFeFordzhYM2pZd1l6UmtFZ2pBcXdFYzdGQWE3amNDeW9nakxuc1RNWWlN?=
 =?utf-8?B?ckNNekVsaURaa2NCbmk5M1pXS29lQVdjaTVZT3d1c0x5eGFRS0FVUXZTVUlI?=
 =?utf-8?Q?xh6Dm7A8U/s/wsT5Wp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0bf1d9-ddd9-4262-c4bc-08de8fd4ea1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:56:15.6612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXrQYTjqClS8ySdhtdo8ySI805muNt3iE421TlTbiD70d5FhECTsgYrJg9BDB+ATnW5KKJdKvaN5JeVCIVjV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQFlhbmcsIFBoaWxpcA0KQ291bGQgaGVscCByZXZpZXcgdGhpcyBwYXRjaD8NCg0KVGhh
bmtzDQpSaXZlcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE1hcmNo
IDMxLCAyMDI2IDc6MzIgUE0NClRvOiBZdWFuU2hhbmcgTWFvIChSaXZlcikgPFl1YW5TaGFuZy5N
YW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBj
aGVjayBpZiB2bSByZWFkeSBpbiBzdm0gbWFwIGFuZCB1bm1hcCB0byBncHUNCg0KT24gMy8yNi8y
NiAxMTozNiwgWXVhblNoYW5nIHdyb3RlOg0KPiBEb24ndCBtYXAgb3IgdW5tYXAgc3ZtIHJhbmdl
IHRvIGdwdSBpZiB2bSBpcyBub3QgcmVhZHkgZm9yIHVwZGF0ZXMuDQo+DQo+IFdoeTogRFJNIGVu
dGl0eSBtYXkgYWxyZWFkeSBiZSBraWxsZWQgd2hlbiB0aGUgc3ZtIHdvcmtlciB0cnkgdG8NCj4g
dXBkYXRlIGdwdSB2bS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWXVhblNoYW5nIDxZdWFuU2hhbmcu
TWFvQGFtZC5jb20+DQoNCkxvb2tzIGNvcnJlY3QgdG8gbWUsIGJ1dCBJIHRoaW5rIHNvbWVib2R5
IGVsc2UgYWxyZWFkeSBhZGRlZCB0aG9zZSBjaGVja3MuDQoNCkBQaGlsaXAgaXMgdGhhdCBjb3Jy
ZWN0PyBJZiBub3QgcGxlYXNlIGhlbHAgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KVGhhbmtzLA0K
Q2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2
bS5jIHwgMTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gaW5kZXggODE2N2Zl
NjQyMzQxLi43ZjkwNWE3ODA1ZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
c3ZtLmMNCj4gQEAgLTEzNjYsNiArMTM2NiwxMiBAQCBzdm1fcmFuZ2VfdW5tYXBfZnJvbV9ncHUo
c3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPg0K
PiAgICAgICBwcl9kZWJ1ZygiQ1BVWzB4JWxseCAweCVsbHhdIC0+IEdQVVsweCVsbHggMHglbGx4
XVxuIiwgc3RhcnQsIGxhc3QsDQo+ICAgICAgICAgICAgICAgZ3B1X3N0YXJ0LCBncHVfZW5kKTsN
Cj4gKw0KPiArICAgICBpZiAoIWFtZGdwdV92bV9yZWFkeSh2bSkpIHsNCj4gKyAgICAgICAgICAg
ICBwcl9kZWJ1ZygiVk0gbm90IHJlYWR5LCBjYW5jZWxpbmcgdW5tYXBcbiIpOw0KPiArICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICB9DQo+ICsNCj4gICAgICAgcmV0dXJuIGFt
ZGdwdV92bV91cGRhdGVfcmFuZ2UoYWRldiwgdm0sIGZhbHNlLCB0cnVlLCB0cnVlLCBmYWxzZSwg
TlVMTCwgZ3B1X3N0YXJ0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
cHVfZW5kLCBpbml0X3B0ZV92YWx1ZSwgMCwgMCwgTlVMTCwgTlVMTCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmVuY2UpOw0KPiBAQCAtMTQ0Myw2ICsxNDQ5LDExIEBA
IHN2bV9yYW5nZV9tYXBfdG9fZ3B1KHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCwgc3Ry
dWN0IHN2bV9yYW5nZSAqcHJhbmdlLA0KPiAgICAgICBwcl9kZWJ1Zygic3ZtcyAweCVwIFsweCVs
eCAweCVseF0gcmVhZG9ubHkgJWRcbiIsIHByYW5nZS0+c3ZtcywNCj4gICAgICAgICAgICAgICAg
bGFzdF9zdGFydCwgbGFzdF9zdGFydCArIG5wYWdlcyAtIDEsIHJlYWRvbmx5KTsNCj4NCj4gKyAg
ICAgaWYgKCFhbWRncHVfdm1fcmVhZHkodm0pKSB7DQo+ICsgICAgICAgICAgICAgcHJfZGVidWco
IlZNIG5vdCByZWFkeSwgY2FuY2VsaW5nIG1hcFxuIik7DQo+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ICsgICAgIH0NCj4gKw0KPiAgICAgICBmb3IgKGkgPSBvZmZzZXQ7IGkgPCBv
ZmZzZXQgKyBucGFnZXM7IGkrKykgew0KPiAgICAgICAgICAgICAgIHVpbnQ2NF90IGdwdV9zdGFy
dDsNCj4gICAgICAgICAgICAgICB1aW50NjRfdCBncHVfZW5kOw0KDQo=
