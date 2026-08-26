Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B6C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 02:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DB210E247;
	Wed, 26 Aug 2026 02:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybhNBOO9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D027310E247
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 02:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRSB4G6cRoPQnMwJCL0yJAxCPPMvjyHV99TM9M+NnwmKjJbnovO1nyGowd8LCXkxZ6QhxuC32LgDHc9XEnx6g0MKNiBhy+VBg3PjMljSvNeV77cARQaV13fdnDCpEDb9Lbvm97zKhSqTTvFM2WHSeQPqG+npva8TJhkk+DCgi1KmVNatK+dpXiI83hSQRbZO8+wv6rsIall3ZVZUq9zE6xbbe1EWHV5g2ZfmkkUmJ9lOiYm+2HfyKFiGC73MO2JMOCiYdFip3eeVmOoltCEzutL7CiZxdNqcun12ggm3SOpvZvZ7rvjcRGixaZ1XYhxlnI80tNOAoMj6IWT7+ayj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apWkduKgdPg2CWOmygkwpgk62jNPlna0JsyJI9OMOE8=;
 b=R1siV3K1KPDxRRLle97mJJwkyOsQx260ServAmksbQDxUW/oY6oPvSJSHOdt41U0Q9JvAlDKXKNU5CPfTHXVXY0NTM6ykkudYYsLLKsIDp5ot2g1x4acefwX2ajYadxOYQfUyHeiL2GW4B9lyI6WUHpGB0vuDrCHgtrYaKVk4BJJ67+wi5xBzMqma/GRshEWszxtPrWi2aBmyFoG9ESuuFysdLoN3MTGMw/4FXB5Y3rKmZcl++PTweHL7ABa5Ie6aY6GItR3/7+5pThNWH3mJXAhQEiyvau/SpJDbiQOsrZUw6TqZpw8s3pxkgF7shSmaboAs2RVVzDQr4jx6BCS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apWkduKgdPg2CWOmygkwpgk62jNPlna0JsyJI9OMOE8=;
 b=ybhNBOO9/R2jnatNszHfbKg6yGGnRVzc3DVJrNvgMzWRR5Mr8AUtYKWBgWJAH4EUBDUsw/eIhOuEE/4On7jSIB3Xx46+/iujv2oz7dyf/bOTV9Gm90Tpa4JnL9s0IOKO5FrsppM0Ck0qB8ClrZOIt4lGjmexli+SEzgco88J+lE=
Received: from LV8SPRMB0072.namprd12.prod.outlook.com (2603:10b6:408:242::9)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:47:45 +0000
Received: from LV8SPRMB0072.namprd12.prod.outlook.com
 ([fe80::1224:b767:ad34:cb0a]) by LV8SPRMB0072.namprd12.prod.outlook.com
 ([fe80::1224:b767:ad34:cb0a%6]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 02:47:45 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Arif, Maisam" <Maisam.Arif@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix gpu metrics energy accumulator for smu
 13.0.0/13.0.7
Thread-Topic: [PATCH] drm/amd/pm: fix gpu metrics energy accumulator for smu
 13.0.0/13.0.7
Thread-Index: AQHdNP7OviWJW56XG06oAUV6mPO9xbavoGEA
Date: Wed, 26 Aug 2026 02:47:45 +0000
Message-ID: <LV8SPRMB0072B912A7913313BDC688C38EAE2@LV8SPRMB0072.namprd12.prod.outlook.com>
References: <20260826020106.1346230-1-kevin.wang@amd.com>
In-Reply-To: <20260826020106.1346230-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-26T02:47:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8SPRMB0072:EE_|PH0PR12MB5677:EE_
x-ms-office365-filtering-correlation-id: ac20d4ef-9214-4b64-f1e4-08df031c681a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: z+xrT+nbp6eb2uBDhxXN6xvkBN/Bm4+wr2ikyVu0NJ+8+esWnADsT2+5ew5aN124oqMFcNmMExSegKChJwDxJ1vu4ZhygdmIMTw4KaqFNhRoIj05sW7Xwry/0YFFrwDHhR1wgRqO5sy6xDnc2bIh8Uo91hlzNpnVknGEc/1XYOgxOjiDTDmKB4/O6JT92pD9f7Lrzhq1SbpHHYYVUO+RGD5LoF5t3454yuKQVjw5c458/eQDLrbptkjM+b0pc7MpnfcyvQ/D10YKUVx1vKZScXvVCjCA7YboMgofanEqjTaYU3PK8dVQXpBPH1eXvCfMNvJI3Zf6KzHZ1/jNJI3LKZljzLB8wGGVvqwmbIuYIk+ArkJR4XoTVCuhMaI6HFM457/tNOSM5PGF+Ob2+iuIf7M/8ktSWxqJplT5uUdriurQzmdfogMY4CreWNWcae8AXuCs0aPtrKtuZNK6nvrgcj1I37xjnQnVsWfdKs6jV5EXzBGpYKTyyGnd14IgIOi8gT2TWrKzxAsrXU+R2o+CDwqw4x448TXP4I+c/RiXmfPNP7jpGYogrpF7UNixw9+RIw+nEfjeUtEscNgT/HQKBrpTZ4hCBr5YwF2/X3aeSbTm/MYFpV8GDNQfl7Myqsl+Sd5ZEUdVTHHlCW4AVDUn+z/fO1GUiQLsJzqPiTjG54vp/QmYENVPxNfcFCs0uy8cru7z6HNOmqcAEPCOnWjVRgla9DWkchguhNe69ayRsTk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHZMMEJSaVhGOGVHNFg2UHAwTWpmMUNnSUxFYTVIQ2NGWmFpa1hpbDZTUkEz?=
 =?utf-8?B?OVdaQTlGdit5RVBhWVB5S1JwVnMyTDh4dU1LSDMwd1UxV2t4TmthZWlHbFQ0?=
 =?utf-8?B?VlJnOVFDZlVmcmhNVUhrRXJuYVJLQ3JsMW96NDNEcGFQVEdkMEJYWEhBL3Y3?=
 =?utf-8?B?cGtlS2p5WFVnZFlQeGMyMkd2UGIxeDMweEoxYWo4UWRFZStsUG1pbExKRTh1?=
 =?utf-8?B?NVNWMjY1NzN2MjJJMzlNQnRMZlduZjBUWVVvWEw1dGoxSExFdGJDZVdsTjdz?=
 =?utf-8?B?VVZPVVFWSytJQTduc2szY2xNQUdDWFB2NUxybGdrNXFkOFlDaTFsZWpwQmN0?=
 =?utf-8?B?WTg5K3MveEV2Nm9LWHBZaXZlSlYrZzViTHlsVUhwUHoyZlh5R3ZPR1d1Z3l0?=
 =?utf-8?B?VEIvQy84NjlrRklDQ0ZJeUtFbzdNanJYaWh0Mks3NU8zUXZHa3VtczU0ZkZm?=
 =?utf-8?B?NFZxem56T3FjeXBGcCtQT0pSWHpkWXpSVjl3S0dFeFl5eHNQSkdMKzlqNzRm?=
 =?utf-8?B?RW9CdzhvSkRtT1F3TXFSV1pQc3NyZ0h4UnlyTTZ2YmF6a2d6QkdRSERGL3pP?=
 =?utf-8?B?WU5GTDVFUGI4eEt1b1prQmsvZUtqVXV2OWhQM0dYWDNoaWFzaGJGSlZmaWd2?=
 =?utf-8?B?STBnY3dMRzQzR2FvUnA3cXN2VkVwUXhSUGNTMFFaSjFWVnRoaDJlNTBJUVFv?=
 =?utf-8?B?YWhZUGpHMjYxVk5JZmhMbVlOVVkwbkVoRFc5d2lKbUp4SE5qNk5DOTVBdWJx?=
 =?utf-8?B?OUxFQ0k3OGxCdDV2aXJrY0lmREExQWZyMmIxbi9CWGZZNVZma3haYk1Oamwv?=
 =?utf-8?B?N1FqN3dYdmRlWnk2Rm9Ta0ZKOGNiZkRRYVduUk9QYzBpalZmMkZzUlNDT1ZN?=
 =?utf-8?B?c1BvQU9jd0ZDL0lPc0xpNVdIYnVpYWZyTGhjL0toYWNIL3FtL3h5bklmWW9R?=
 =?utf-8?B?a1p1SnlxTHlWamxWZGl6OXZMOTY3SW5JMmFINHNMYlduUCtyWGJLMjk0TDNQ?=
 =?utf-8?B?ZVRSR2pWQlkycWw5SzFtZDdvMmNiak51aTVoY2RwRVNRM3B6Z1dEVUZVYVI5?=
 =?utf-8?B?MFM3MjBLTjlCUDVTcllUeEJ6MkhGaVBDaFBHMms5VDJTcFZVclFjSlQxUEFF?=
 =?utf-8?B?czMrTFZuMHQ0STdwblZJZDVOWlpTNDk3Y2xjZlJrdW9SS0d2VFdVYm1TRXRp?=
 =?utf-8?B?WmdraW40T01xWk5TU0lvNnBMQTVNY0xtaVo4YUxXLzRXNWI5UW5CYllwM2oy?=
 =?utf-8?B?bEIzdTRNYWgyNG5UQk5jbmdWOVNUQ3FtRG9XQ1FxRmVoVEZWMTdDZWZUQkpj?=
 =?utf-8?B?TG9HSUwwdHZ3dnB0Q1VPTXlBTGJqQ3NlWVVleDFKYS9XSm5rQmVGSVpuN0gw?=
 =?utf-8?B?Ym0xcWpjUW9TeklPZkRaWUZmTmRYbXl3bXlsYVNQemdUY1JMTFZKTkFaYlNO?=
 =?utf-8?B?WWo2STF5dGFuNjZWWktNdHZaeG81UnV0MmMzU0NmWGtWWjg0NUxDU3VXMkxh?=
 =?utf-8?B?VDd6bzdQVGRNUjBUS2VGc3RVOTE2dmtyWVNRZW5zRjJPQWcyT0VJbUE5R2Fh?=
 =?utf-8?B?R2xuUjRFOHl6eTNacExjenJ6UCtFV3psQkVsVFNUUmFuTU1yWU1maHljOTIy?=
 =?utf-8?B?b2ZpSGdudjF3clFvSEgvYitPTEFLSGh4T3RXWEtZREZ3Zi9UelMwMCtzRTdX?=
 =?utf-8?B?d2lpcFNwYXluYytxU0Z1czV1R1Rud0d3c21iL0loNDFDc1cwaDZiUGtvVkVk?=
 =?utf-8?B?Zjgwbm5BWTZ0RzlQNjd1d091THZZWVhyc2lvNHpoN0RzQWgzWklhb01ENW9h?=
 =?utf-8?B?QlRraTFGRjRUUkxaZGdvd09lUTBaL1V2Syt6VVZTTGROWWsrMTkyNkl0RzNN?=
 =?utf-8?B?aUhGVG5DNzN0OWhqb0VCWFVLc21jUXFBRHh6WHhkY2JvU2VPNUNZdFZSam91?=
 =?utf-8?B?VE1XWVUyR1BuUXpBM0lQQUpuaStRejFOOEZ1V21CcFBramZkY3BOdEVpZVp1?=
 =?utf-8?B?WGdNK1JXZGpleVBJWGNJWGN6WnJIaGtXVzlzM0FWWVllVVhRTS9SZGZPbzNo?=
 =?utf-8?B?R1hVKytPVmx1ZmZzZEN6UTc2Q2l4eGlzWGMxSXpTWWUzV2c0Zm1GS1ZWbzd0?=
 =?utf-8?B?UGF2aUh2QmdIVmlEQS9Sd28zb1gwRXdWUXUyWUpWZEdTMXVSRnFjY0E5bVhK?=
 =?utf-8?B?UmVCZ1lQZmlOZFgxbG14b0NGc1dMQkR4Sm1lUlNhejVWM2FsSUw1dGNKL2cv?=
 =?utf-8?B?WkFIVnNWczhyYzFxcDlNOFFHMCtVMzZRSkJVOHZ4QXFDc2hJeTRCWERkNVls?=
 =?utf-8?Q?BsGYVkqn32ZKq+7FJU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac20d4ef-9214-4b64-f1e4-08df031c681a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 02:47:45.0380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zwcU/xTMm4XMSeD+sQqvKMJWFCuCK7hkAyLMP31xkyoHiolS922TN2NrsDNBY0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFt
ZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXYW5nLCBLZXZpbiA8
S2V2aW4uV2FuZ0BhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjYsIDIwMjYgMTA6
MDEgQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47
IEFyaWYsIE1haXNhbSA8TWFpc2FtLkFyaWZAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZC9wbTogZml4IGdwdSBtZXRyaWNzIGVuZXJneSBhY2N1bXVsYXRvciBmb3Igc211IDEzLjAu
MC8xMy4wLjcNCg0KR1BVIG1ldHJpY3MgdjEuMyBkZWZpbmVzIGVuZXJneV9hY2N1bXVsYXRvciBh
cyBhIDY04oCRYml0IGZpZWxkLg0KVGhlIHVuc3VwcG9ydGVk4oCRZmlybXdhcmUgY29kZSBwYXRo
IGFzc2lnbnMgVUlOVF9NQVgsIHdoaWNoIGlzIG5laXRoZXIgdGhlIGZ1bGzigJF3aWR0aCBpbnZh
bGlkIHZhbHVlIGZvciB0aGlzIGZpZWxkIG5vciBpdHMgZGVmYXVsdCB2YWx1ZS4NCg0KRml4ZXM6
IDhkZTllZGIzNTk3NiAoImRybS9hbWQvcG06IHJlbW92ZSBpbnZhbGlkIGdwdV9tZXRyaWNzLmVu
ZXJneV9hY2N1bXVsYXRvciBvbiBzbXUgdjEzLjAueCIpDQoNClNpZ25lZC1vZmYtYnk6IEtldmlu
IFdhbmcgPGtldmluLndhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMgfCAyIC0tICBkcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jIHwgNCArKy0tDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KaW5kZXggODFi
N2MyZGU0NWFlLi4xNmE2YjhmZDgzMmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQpAQCAtMjA5NSw4ICsyMDk1LDYg
QEAgc3RhdGljIHNzaXplX3Qgc211X3YxM18wXzBfZ2V0X2dwdV9tZXRyaWNzKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LA0KICAgICAgICBpZiAoKG1wMV92ZXIgPT0gSVBfVkVSU0lPTigxMywgMCwg
MCkgJiYgc211LT5zbWNfZndfdmVyc2lvbiA8PSAweDAwNGUxZTAwKSB8fA0KICAgICAgICAgICAg
KG1wMV92ZXIgPT0gSVBfVkVSU0lPTigxMywgMCwgMTApICYmIHNtdS0+c21jX2Z3X3ZlcnNpb24g
PD0gMHgwMDUwMDgwMCkpDQogICAgICAgICAgICAgICAgZ3B1X21ldHJpY3MtPmVuZXJneV9hY2N1
bXVsYXRvciA9IG1ldHJpY3MtPkVuZXJneUFjY3VtdWxhdG9yOw0KLSAgICAgICBlbHNlDQotICAg
ICAgICAgICAgICAgZ3B1X21ldHJpY3MtPmVuZXJneV9hY2N1bXVsYXRvciA9IFVJTlRfTUFYOw0K
DQogICAgICAgIGlmIChtZXRyaWNzLT5BdmVyYWdlR2Z4QWN0aXZpdHkgPD0gU01VXzEzXzBfMF9C
VVNZX1RIUkVTSE9MRCkNCiAgICAgICAgICAgICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV9nZnhj
bGtfZnJlcXVlbmN5ID0gbWV0cmljcy0+QXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeVBvc3REczsNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83
X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19w
cHQuYw0KaW5kZXggYjk0YWU0MzU4NmRmLi41ZmU0MDlhMjM3NzIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQpAQCAt
MjA5Nyw4ICsyMDk3LDggQEAgc3RhdGljIHNzaXplX3Qgc211X3YxM18wXzdfZ2V0X2dwdV9tZXRy
aWNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtZXRyaWNzLT5WY24xQWN0aXZpdHlQZXJjZW50YWdlKTsNCg0K
ICAgICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV9zb2NrZXRfcG93ZXIgPSBtZXRyaWNzLT5BdmVy
YWdlU29ja2V0UG93ZXI7DQotICAgICAgIGdwdV9tZXRyaWNzLT5lbmVyZ3lfYWNjdW11bGF0b3Ig
PSBzbXUtPnNtY19md192ZXJzaW9uIDw9IDB4MDA1MjE0MDAgPw0KLSAgICAgICAgICAgICAgIG1l
dHJpY3MtPkVuZXJneUFjY3VtdWxhdG9yIDogVUlOVF9NQVg7DQorICAgICAgIGlmIChzbXUtPnNt
Y19md192ZXJzaW9uIDw9IDB4MDA1MjE0MDApDQorICAgICAgICAgICAgICAgZ3B1X21ldHJpY3Mt
PmVuZXJneV9hY2N1bXVsYXRvciA9IG1ldHJpY3MtPkVuZXJneUFjY3VtdWxhdG9yOw0KDQogICAg
ICAgIGlmIChtZXRyaWNzLT5BdmVyYWdlR2Z4QWN0aXZpdHkgPD0gU01VXzEzXzBfN19CVVNZX1RI
UkVTSE9MRCkNCiAgICAgICAgICAgICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV9nZnhjbGtfZnJl
cXVlbmN5ID0gbWV0cmljcy0+QXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeVBvc3REczsNCi0tDQoyLjU0
LjANCg0K
