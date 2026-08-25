Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92BEC5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 05:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7F510E07C;
	Tue, 25 Aug 2026 05:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zH7P9WrE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6549910E07C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 05:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIngkUaG2VAYiHomgSZhumafCJ17Ha9P7Tw8BEQje1XJyA7aVzpn5PP5ygWrrOtfDu/qiZIxO4EV+U6zmARLhx751WbWVXNyoWfQne6gCE9IzRyQ1CUJoeky/uEquXD/7xet6ZNiEm2KnvOzpya7GMlZlTdqxBgaUuwP481M85aw/vxRhDpPe9j1f0SJVcZvi+l36WZLCZDjWPu9YcZYYeD7UCaEHjs4R8rC4JzgV879HHgQfVbKSNA5GBbwTrGmZTZpQHY/3B5K1oAQ1KVmBDG1B5dIdBU7gkyVs7PnuH4R/Ps9Jq2uwXdDeRPGbTcSNSTEayysKpAsUKYcNnfzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRM2V3pGhjF+MrJ+sv9WrBJ/DT4xaMFguTBKIT+Zcu0=;
 b=qoAjHkIobiO9vLLUb78b/7zJSrnspdEORiamHu+ZXjYTjXYbXFUc8pD/9TpMY0/Jf/JdEOv6M40Hjd2DMQm7Cav+miDXGuQL5PgTpJnQNzG7wdH5GnPLQ9zzzsE95lozP2VTYuHXtKSOussa0fjTht+Bklwyn+Ai0SGWQktBMSiE2Q0XaGzrQ1gteKsRmNflA5Itxn35mkSb7Jsn6mUmXhVgqfaF+kjEEda2FdeFfEmZxVn298NE01cGXZRha8pNk2VJ3L9O7Rs2FM0TBf9xJWYvPK8gOsFzPjC3WRqr/QvGM+L6rglOAmF/5I51uliOL0k+Yvtqh8JolStQ69PAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRM2V3pGhjF+MrJ+sv9WrBJ/DT4xaMFguTBKIT+Zcu0=;
 b=zH7P9WrEQCzNf3Hu8AEv/gCOW/Ztr6/F1SaEBNqe3JcKDyiRKaIKpIVcsNSvPuLi/1mVY5yOdpI38QIhB+hWqZ+LcUX09e10tTzn4KRXJWVslp97/DfX8oPHuG1KBE9xO5Ou4MkBj4Q+jbOnhxRtoLJp+KXPFnnyWL+czEpn9gU=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 25 Aug
 2026 05:12:06 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 05:12:05 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Natalie Vock <nat@pixelcluster.dev>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: RE: [RFC PATCH 2/3] drm/amdgpu: Add VM ioctl handlers for
 second-level trap handler
Thread-Topic: [RFC PATCH 2/3] drm/amdgpu: Add VM ioctl handlers for
 second-level trap handler
Thread-Index: AQHdMHHYhMK5VX/rlkO2JOOlvY5EK7amvw0AgAd/A/A=
Date: Tue, 25 Aug 2026 05:12:05 +0000
Message-ID: <IA0PR12MB820867831DA522D93AF0D77A90AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-3-srinivasan.shanmugam@amd.com>
 <973ba6d1-17c8-4b4d-8507-a27045eb7e95@pixelcluster.dev>
In-Reply-To: <973ba6d1-17c8-4b4d-8507-a27045eb7e95@pixelcluster.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T05:06:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|MW4PR12MB6849:EE_
x-ms-office365-filtering-correlation-id: 7626cb98-833c-46ef-a5a8-08df026767ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: TWazTqX+TOtif5uyqycEIEAl8m2GxJ+LA3/OBjHZwm0rTsMdxQq8aEVVoGtqfGteYlZLmBc7edqq+ahsKFBLzVDesMI767+web3oooayhm3y300T06i5hwIpOWRrVFpmhy1b201kT+XatoY1ORDHmfNnw5SlyCuFeFEwKi4fzqRPFvuZD+eeZrUz8mseHGWmr6oK6E2bBaxZhcRQs2enIUdDhYdQyo3KHRb3ux1VgBNYrIcM2ZM8p3J6uabxSTn6zpDyjReZ5+jIVbOrhTS6kv8MDZUNGt2lRLfd+ytxQkqpX5+rNTls/uMI8Qr+eAHU5+Lh3lvnP9ByWtpXYBG5wxgxInnJRbpOv0/wvV/T+lyFUX7+A3wghFL0QGh1sfSEr69P+QCtcT+cSmtfhcyZDlpPMVzfdpw3SCOTeE4b5Z06S106UYa69416hNdNRVpRRNFsRD2yAh7bxF1Ci7+vVTqReOEYMVc4N7BZehxDap7heocnPhFYN0d4oENbJo4nECSco6LDaEXgW+EaasVacWG1ib4nwJAeFezbGRU//xreYDCq6Re32/8/Z/27K7qYdQ8JbnbZkobG1ES/DZYq9kkWqKxyi/+4B+siu/4HRomBcHoUHrKrTjXLKauz5tsOprddYw75v8lCBaYjmrxabPYNsZE9YE2euRAWFt1dgjQgNSBFxuExkiTEq8Ozl4akCAD86FBWc6glgGpgzNAofUPShM4HrXLb/0lTDJl/j40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhRRVU4YmhmWDZRRUJ6NmRxajlFVnAvOENRKzJoQm1oU2dxTlFDRkJIRWxI?=
 =?utf-8?B?QldRekl1TTd1R0l4NzM1TWhRTDk0akFPKythdEkzYWo5TUpGVHdlZHYxUExP?=
 =?utf-8?B?Y3VTenlHUHQ0QUJ6QmJTOG03enFiL0lONUxZbjBTZmpDMVBZWUtPTmVsaS93?=
 =?utf-8?B?OTQxOW8xejdUK2tGSFFwUGxRdUdTQ1BRRTI3YURIOXgxNjJ1S3poWlBJeGFt?=
 =?utf-8?B?R0V1Mk9vWGRJNnIwYk1qYS9pc1A3TXo2VUpSU1g0eVcySVhNb2t3YU0ydXA5?=
 =?utf-8?B?SVgzT2p3WnhCOHh6VENlY0U4c09lbGdrK0FmamhKYzJDclRjdEZTM2UwYkpu?=
 =?utf-8?B?cEFSQ1ZXZTZwcFQrYzQ5L1FYMHR6dVczVmphdXptOGgyOXZXSVljS0Q3SjR4?=
 =?utf-8?B?clk2MEc0QkNzd2dhUnBDaTFLQ2dFbTFsNHYyZ3g1QXFSOWd6TnRjWXlkcXA2?=
 =?utf-8?B?c294N3BWYTRnTHJYb0wzUm5UZW9maXRGMmJRRXlSK05MR09hK0RlVVJVbThS?=
 =?utf-8?B?cEFQQ0h1NDB6bTFTMXdIUXNOSkppODlwNWllVUI3cWZuL1FFc1lYMDFHUnRq?=
 =?utf-8?B?cGp2L1RqdE1vWTMremNiMXVQU1pxckVZVnJZR1lvZGl0VWhqQ2dPaUs2UzY2?=
 =?utf-8?B?SktJNDBySFBFWDB2Slh4cXFkVUJTWW1sdGRMWUhQN2F0SlhIWWpwNytFT05H?=
 =?utf-8?B?VXQ3a0VIK3JocU1MTWVtWDhIVkw0ZnNERU9zeFRvUkQxWHFMRURNM2JXaTRr?=
 =?utf-8?B?dzNySHNPd2NOY1FGd2FmVUJJUGdTaHNLUXpvNmxMVUJMR2F4bVJ3R3B0SkQy?=
 =?utf-8?B?Zitxa3RocVBlbk95QlorL2NkRjFCRzAvdG91UmRIT0RJZ3BYOWlTQ0hPUFk4?=
 =?utf-8?B?dUthMzg2cktaTEdOdDY4eExyai9GT0hrQ2wwYjRFSDBHVUNWMnNpNGlVaitG?=
 =?utf-8?B?aGhtNGg2NHgvS0t5NEJySmh1T3J5UlIzZ2tzRVo3MTJCcnVEemtQdEJ5YlZK?=
 =?utf-8?B?cFc3THRiTUZxZDRnY3FJRnJ6Mzc5VGNKbmlKYVJPM01PdFpaTFlxVTgyV25J?=
 =?utf-8?B?dU9SbUU4OG1FWnJyajYwSHkxOS9KYXBTVXd4Rk5HUkJ3YVdIRERJQnBvTHpy?=
 =?utf-8?B?K2ZUVjlNaW9zRkd6ek9jRTQ4b0dIWWpMK0tPY05uZ0IxSlFaSlpQWDFIaG1i?=
 =?utf-8?B?ODNjOG9CMFNIZGp1NU1RL2J6RHJ1MnErQU5oWGZ4Wnl6MEVydXB4L3c4MDQ2?=
 =?utf-8?B?V1RhUXJUNUpaZ2JiU3h4eng2VDI2QjA3ZUtIb1hYbGg2K2o0NTNXS3hyK0ww?=
 =?utf-8?B?WlpwZUU5MHFoSUxJWUxnWkJMamhIL2x3azNwSFhwVXpMMUtoeDVsYnV4N1dY?=
 =?utf-8?B?dEpqMFhEbm9YYk9NcjRwcVZIZHlZZDF4bjNtSWdJS01nb25EZTh1eExpa0Q4?=
 =?utf-8?B?d2NsZzlFZ3RVdTNVbnlZMG9PQVRHTVhKcnZ4aEN3U2FuQ05OenprMFNyRkRk?=
 =?utf-8?B?UStnODg2Z2NVM05zQ0N3ZE9KRW1waE1kQjJwaUU3TVdXalUrWGdmbnRlcnBr?=
 =?utf-8?B?WE1ZNCt4bmpSeFVXS0JrVXY3UlFvNUVBWE84WTNRTmw5OWsyTU84Vks3OE52?=
 =?utf-8?B?Y0dtOFVjT3BqMGpQOUVxQVJSLy8vZVF5b2FPd1h3TVFpbmhvM2szczRpREhO?=
 =?utf-8?B?UFZVaDJpU2dHMVE4dkZDWVVVUXg0bkFOZjlzeGZXdXpldVphSjFmbU9uN1FB?=
 =?utf-8?B?Y2dneDZBbStoSXhXTTRjR24xbzJsU0VLUjJKZ2VtdU56TTVlRHN3WFd3dUVt?=
 =?utf-8?B?RS9jRWM0UFA4QTk5OFdITGxwdTMzMFY1dGYwYmVNMkxIV3hTR1NYa0VjbWFN?=
 =?utf-8?B?RHNDMUtVWmdTUXdyNUNXUXBsQ09KaXVXYnV2UUk2cVpTSElhUnltSVFaQ3VI?=
 =?utf-8?B?ZjdXZWdJT2xxV3FabnlTbHQ3WkJkQVNwOFF2dkcyN3hQcW41WmsrMCsxT2t1?=
 =?utf-8?B?UnVsVkNldytkQmtwVm9OaEw0NlVkS0loYmJ3YlNpNERDTmtpOE03eFFvc29j?=
 =?utf-8?B?Umw3b0prVEhxNUNuMHVGSGh2OGYvRU5TZTE3T0kzZWlSalNJN2ZHYURudmdB?=
 =?utf-8?B?WHMwUUY0ZDYySmhZZy9KVjZLanFXdGJqYXZmc3NKSnNhUGJSeDl4Z2tzaldO?=
 =?utf-8?B?K3dKcjkyWXlKcWhwVW5SVkM5S2t1aEdWVFlzc1lsOENqbmpieWJxRkp4UEpn?=
 =?utf-8?B?TEpWalgzczRjcjdVOE5SNEJUME8rSXNyZXVkOWwxVU1QZmFQUGlTMk0xbVF3?=
 =?utf-8?Q?RuMkY5e4eItwAHNgav?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7626cb98-833c-46ef-a5a8-08df026767ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 05:12:05.8273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDSA44tHNA/iUviso6+7z/KamLK1V4d+F9PK6W0bAVmN3e0L6c4MNmGr+F7IX2cNZKUiCSNYM5ocA70Fipn8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYXRh
bGllIFZvY2sgPG5hdEBwaXhlbGNsdXN0ZXIuZGV2Pg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0
IDIwLCAyMDI2IDQ6MDggUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNB
Ti5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZl
bGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsNCj4gWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFt
ZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgU2l4LA0KPiBMYW5jZWxv
dCA8TGFuY2Vsb3QuU2l4QGFtZC5jb20+OyBQZWxsb3V4LVByYXllciwgUGllcnJlLUVyaWMgPFBp
ZXJyZS0NCj4gZXJpYy5QZWxsb3V4LXByYXllckBhbWQuY29tPjsgVGltdXIgS3Jpc3TDs2YgPHRp
bXVyLmtyaXN0b2ZAZ21haWwuY29tPjsgU2FtdWVsDQo+IFBpdG9pc2V0IDxoYWt6c2FtQGdtYWls
LmNvbT47IE5hdGFsaWUgVm9jayA8bmF0YWxpZS52b2NrQGdteC5kZT4NCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiBBZGQgVk0gaW9jdGwgaGFuZGxlcnMgZm9yIHNl
Y29uZC1sZXZlbA0KPiB0cmFwIGhhbmRsZXINCj4NCj4gT24gOC8yMC8yNiAwOTowMSwgU3Jpbml2
YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gUmVuZGVyLW5vZGUgdXNlciBxdWV1ZXMgaGFkIG5v
IG1lY2hhbmlzbSB0byBpbnN0YWxsIGEgdXNlcnNwYWNlDQo+ID4gc2Vjb25kLWxldmVsIHRyYXAg
aGFuZGxlciBlcXVpdmFsZW50IHRvIHdoYXQgS0ZEIHByb3ZpZGVzIGZvciBjb21wdXRlLg0KPiA+
IEFkZCBpdCB2aWEgdGhlIFZNIGlvY3RsIGFuZCBmaXggc2V2ZXJhbCBjb3JyZWN0bmVzcyBpc3N1
ZXMgaW4gdGhlIENXU1INCj4gPiBUTUEgYWNjZXNzIHBhdGguDQo+ID4NCj4gPiBPbiBkR1BVcyB0
aGUgQ1dTUiBUTUEgYnVmZmVyIGlzIHBsYWNlZCBpbiBWUkFNIGFuZCBhY2Nlc3NlZCB2aWEgTU1J
Tw0KPiA+IChQQ0kgQkFSKS4gUmF3IENQVSBwb2ludGVyIGRlcmVmZXJlbmNlcyBhcmUgdW5zYWZl
IG9uIHBsYXRmb3JtcyB0aGF0DQo+ID4gbGFjayBmdWxsIGxvYWQvc3RvcmUgc3VwcG9ydCBmb3Ig
TU1JTy4gUmVwbGFjZSB2b2lkICp0bWFfY3B1X2FkZHIgd2l0aA0KPiA+IHN0cnVjdCBpb3N5c19t
YXAgdG1hX21hcCBhbmQgdXNlIGlvc3lzX21hcF93cigpIGZvciBhbGwgVE1BIHdyaXRlcy4NCj4g
Pg0KPiA+IFdyaXRpbmcgVEJBIGFuZCBUTUEgYXMgdHdvIHNlcGFyYXRlIHN0b3JlcyBjcmVhdGVz
IGEgcmFjZSB3aGVyZSBhDQo+ID4gdHJhcHBpbmcgd2F2ZSBjYW4gb2JzZXJ2ZSBhIG1pc21hdGNo
ZWQgcGFpci4gRXZpY3QgYWxsIHVzZXIgcXVldWVzIGFuZA0KPiA+IGZsdXNoIHRoZSBHUFUgVExC
IGJlZm9yZSB3cml0aW5nLCB0aGVuIHJlc3RvcmUgcXVldWVzIGFmdGVyLiBVc2UNCj4gPiBhbWRn
cHVfdm1fd2FpdF9pZGxlKCkgb24gdGhlIENMRUFSX0wyX1RSQVAgcGF0aCB0byBhbHNvIGRyYWlu
IGtlcm5lbA0KPiA+IHF1ZXVlIFZNIG9wZXJhdGlvbnMgYmVmb3JlIHplcm9pbmcgVEJBL1RNQS4N
Cj4NCj4gT25jZSB5b3UgcHJvcGVybHkgdHJhY2sgdGhlIFRCQS9UTUEgYnVmZmVycyBhcyB1c2Vk
IGxpa2UgSSBzdWdnZXN0ZWQgaW4gbXkNCj4gcHJldmlvdXMgZW1haWwsIHRoaXMgZGFuY2UgYmVj
b21lcyB1bm5lY2Vzc2FyeS4gWW91IHNob3VsZCB0aGVuIGJlIGFibGUgdG8gcmV1c2UNCj4gaG93
IFZNIHVubWFwIG9wZXJhdGlvbnMgc3luYyB0byBldmVyeXRoaW5nIHRoYXQgbWF5IHVzZSB0aGUg
Qk8uDQoNCkhpIE5hdGFsaWUsDQoNClRoYW5rcyDigJQgbm90ZWQuIE9uY2UgdGhlIEJPIGhhbmRs
ZXMgYXJlIHByb3Blcmx5IHRyYWNrZWQsIHRoZSBldmljdC9yZXN0b3JlDQpkYW5jZSBpbiBTRVRf
TDJfVFJBUCBhbmQgQ0xFQVJfTDJfVFJBUCB3aWxsIGFsc28gYmUgcmVtb3ZlZA0KYW5kIHJlcGxh
Y2VkIHdpdGggcHJvcGVyIEJPIGZlbmNlIHRyYWNraW5nIGFzIHlvdSBzdWdnZXN0ZWQNCmluIHlv
dXIgcHJldmlvdXMgZW1haWwuDQoNClRoYW5rcywNClNyaW5pDQoNCj4NCj4gVGhpcyBhbHNvIHRh
a2VzIGNhcmUgb2YgdGhlIGNvbmNlcm4gVGltdXIgYnJvdWdodCB1cCBhYm91dCBoYW5kbGluZyBr
ZXJuZWwgcXVldWVzDQo+IHByb3Blcmx5Lg0KPg0KPiBUaGFua3MsDQo+IE5hdGFsaWUNCg==
