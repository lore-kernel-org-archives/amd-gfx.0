Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F62606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ThP8LND8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAC210E7E1;
	Tue,  3 Nov 2026 11:37:11 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC01910E80E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 11:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whNvgProtcLQesLJTtjOlrWTtYMzrtk+vJnRJ/tZbcAKXANWbwUueoUIT8weSYGQBN2OeTSlnkZrHnEx2gfql/qsFeKtgb1+NFx+jAYK5JqonaxUGD5lkbK9SN5/iH0xsVgxUrz51LEa7WeoLE1DPOSc4OCKxNDOjYeBbe6s/33+AZN/t7d0F0DWJGpsCwAmSgI38cIYW6PoWvfHBT7163osuoeUFSxLRgOf0egoVbs+SHMV4nqMV5pm2J/+3xmnLNeUbXHFPqAe5555izPWi4Wf4SnGQpehBBj3cA6T2XfyRtvtdvQIgNSgw3HiZMV8JlNaXbMrJVVwOmDk1BmXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJmIUv4mBtAxIL8D8uGppA4jJKgoQBv41pQ+HIvhRGk=;
 b=ZJHiZaC4ICJYbVhQcsyHTLtkOmuymgF+dGt04IaAP/Gv4zakRXcFvTy2GPJrfaqL5viGu90oeO9o/ax71Jy+YCT7UQ+D4eYZpTD4qs8dHeMYUzaDb04giCT5lsCMXtukZNdOzYG4PqW2FplqT1Np+alTtT5gbYW3g0pfylpiItB3x3xzxX0itxULL8aGRi4/j52uoxklC4wRkCAdfQwxDl8iqZLzh+Ul1znHccxicHxIw9qxv/TbfQyVe/m7slARPG/XZbwjMdt73ZDgGqef7Ir/zY992Epw3+uAiBBanCO9RYU78r34CCf55vpZKm86ENDAiAq4MjDvCzHEZsusiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJmIUv4mBtAxIL8D8uGppA4jJKgoQBv41pQ+HIvhRGk=;
 b=ThP8LND8ek93mkcJmobF2DSGw22HfAhxvu68zS4EDypfJZCLoBxGi9TkZQyC/cmgB7g9qJmYVGlRrOLUlACT5PSXp9mfrAlzhlRZ76MTt+XBAM53MP0ME4m2/4A85AiWkzdHC/1M0CqcMd3nCdB33OjLnVzCemk2I7QUVoaYJdU=
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::12) by LV1PR12MB460855.namprd12.prod.outlook.com
 (2603:10b6:408:516::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:37:00 +0000
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926]) by PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 11:37:00 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Hosur, Priya" <Priya.Hosur@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Vishwakarma, Pratik"
 <Pratik.Vishwakarma@amd.com>
Subject: RE: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Topic: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Index: AQHda34XhJSZ7rw+S0a7RHW8AmgZXLccKMIAgAAAzQCAAA3+MA==
Date: Tue, 3 Nov 2026 11:37:00 +0000
Message-ID: <PHXPR12MB9992558B181231CF0A71FF224093692@PHXPR12MB999255.namprd12.prod.outlook.com>
References: <cover.1793689935.git.Priya.Hosur@amd.com>
 <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
 <51d3d345-e1f0-48db-af47-de488e428dcf@amd.com>
 <825f3627-cfa4-4da1-8bd5-a53997f72709@amd.com>
In-Reply-To: <825f3627-cfa4-4da1-8bd5-a53997f72709@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T11:34:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999255:EE_|LV1PR12MB460855:EE_
x-ms-office365-filtering-correlation-id: bd411ac9-16e3-4953-0b42-08df399ec63b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|4143699003|261022105027099003|261009221227099003|261021123027099003|261021121427099003|261026121527099003|261022075727099003|261009223027099003|261028144727099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: 1JwwUv3hIX/a2xeSEhkhZZOZJWS3ehVW+8P8tNGemqelySQgU+DzCcxxiUh8vH3N9zsZ/T2o7kRzFcpHnc8QWRtFqka+s8CeIqKzUc+birUg6AnqyIccf8JG34Dn4twmkhsDkHu9bZjC1GbRp4C8hwrrf9qCP/nHZ7opfcSqJcb7ion/aMMD5G7LYqxjMBStgDX20ef+yQTsl6odMse2BzexwStR2/lbOap2d+q/UQK3N6gnfFw0E6vh5vYvP6bHuX5jcpnptc3z+uiQLr6KqFod0PcATzuAffu1bf9f9i+ejDNCB2wQGp3KpGcr/wAHQ/Mae3D4+Gv7sy+QurAWBySFTE1+Ot/hxHz6L+Rsc47gdJnlkRzeNFINJyhymUrbsvBkBp/HGvbiWVqc2IznD0K9DgzoDQfaYJA7cjkfh7/v4NfrojU+BUdbURrs7oY15k4tVKZnXG39dqkrh/8Yype7UnJ37kzJtReOaSgCZJSQpS+GbzHDqBe3wvRJiwYgS6tlyh0NmCwoP5Ksy8Mg+tZhFfLIGyWqCLf0po79SvxDvH0D7UjAZbA6armjFvDZFUnJIqs1UhaEdqQkBL7t2LA8DGNdZcD7qbnmWvRRkSj4wzDMYh8fJvTKajUtJJ2s1ajBN7rpfxxh4UtjNV0jYDdYCI/hTgE6KwrnVAS3QERN2w0ax/brnli0MgN1N94FmhUkFeKm0+x8NgXjy/qHa0ZYW9zoAi6UzU8VgRAUnKRDJej1BCqIAIKSw8Atfx//
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999255.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(261022105027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5aSTdmUHc3SjV3UGpQcXEyckRvL29GTkVCV2NhaU4xQWcySUhOc3NOVnFN?=
 =?utf-8?B?MlpsZktzT2hOcFYwUWJ2c2lmV091Q0xISy9oTEg0UWw0c053YU9OSWhqSUxz?=
 =?utf-8?B?UDlIZ0N0czBlT01vQUZkbEd0MGJQbEY2dVFFYmNtSk9IK2ZaZDZsdDhMdXRm?=
 =?utf-8?B?Uk9OYTEzcC92WDZSdFIrUFdnKzQ0bGdEa3RIZGJNNCtGdjRhSHNHUm9zZHEx?=
 =?utf-8?B?N2VaSjlvNnhJQXlmaWNMamg3eWFKTGt4aFMzOXo5Wk1aZGhZeU9ZUTJuUjMx?=
 =?utf-8?B?RXloRythQ3hvVjJZWTRYL2VEdk44Ymk4RllYVXg3WTNtNGY3YmN5YnBtK2Fh?=
 =?utf-8?B?K2xIOFlVWFo0ZnJabDNCaDFuR3NXRkNwYi84Yzh0a21JejBUdG1pTHBQV2Va?=
 =?utf-8?B?aXVXSnpHdzVJTFF1dFVKd0NTd2h2bGM3ZE1pZGN3VTI0Zzk2RVE4NHFGRWdU?=
 =?utf-8?B?cXQyRGJtY1VmRDFZbVNzbGl5ZnQ1c2pMblRlNU10c1hvT3R5d1NmZlhncmFr?=
 =?utf-8?B?UGRVbFFKUDA2bnROL1hvZHJlK29xSExWdmlTRTJtcWY4VjNWMUNIaElwN2Zo?=
 =?utf-8?B?eTZRbkJyRkU5aTBHM3ppNnJjYlF5Z2ZBVWVBTk5reERVVDMrZ2JjWTczZVNS?=
 =?utf-8?B?NVVSdzJtRnEwYmJJTm0wdlFMTlN2YktWelNwcFlXUENBeGtSOXQra2FSc3NH?=
 =?utf-8?B?b0djZ3FZYXNLUDVIUHlOZUxRaGIwalBzelh6RG9EU2JidXc0QW5BbDRrQ2cv?=
 =?utf-8?B?SlpBT3VNbW83K3pRZGdsc2NqSnl5SGFEcUR2cjJhMTl0Y3pqbWtVbXpNcGVH?=
 =?utf-8?B?RkxLWjNUbWJ6VzdNdXk5RzJoRW82REJkdnhlcEl2SGZVK0lRek5nbTBsUzFz?=
 =?utf-8?B?TThiMGpCWWdtRW50Y09KTWFrVEpDU2JoK0Q1blhrdTk2eXN3RzI4K1B3cXBi?=
 =?utf-8?B?d1ZiTzFZbFl4NjdtTFhOeXBFUmJySVlVQUxnMythUnlYWmhSdlRaMWhtVjRP?=
 =?utf-8?B?SE83UHhNZG9wdHVFRThXa0dBS2I2ZTRHc0kvWHNEV3RrY202clhldFBZbnBJ?=
 =?utf-8?B?ZzFpRUE3VGdiYnRHVWk3MXdFLzFselZPQXFrVEg0ZkdHMmhaU29RaVh1OFYz?=
 =?utf-8?B?blY3NmtDODM3ZlExaG5NVlZnaERxQXRZMU05eHByNlZNUUp4bGhidVNHa1hZ?=
 =?utf-8?B?VWFZczN5OGN4WERydWdvdjdSeGJac1BiTFRMNUdxQU8rSTRWV2c3MkFIcFp6?=
 =?utf-8?B?TGlRbVVxMzd4T3MrZy9XVklYWUdPYXl2WXJXSzlsdHBoVlJFYUw5UXBHWE1k?=
 =?utf-8?B?RVYwaUFRNjI5YlNLOE9vTHY5QjM1Y0QzVGkvUWNEYmFDNkdSbEZQVTVIRFZq?=
 =?utf-8?B?MFBmTWd1OHpVeWdKejJHK3BzWCtjNXFBSWZmVjFDS1ZZTDE0SEt1aTNrNjZ2?=
 =?utf-8?B?U0Y1ZTF0ZFRlSjM2MURvOStTTWFGelg0OERjSmUyTjhLMDl0UVpSRW5lTFNw?=
 =?utf-8?B?T3cwRFovSk1LVkJPeTRyY2swblhoaHNGdUduOXJvd3ZiV1Z4Yit4ZkZOYmlZ?=
 =?utf-8?B?V3h4S0grcjBzRGZwZ2FiN0plSjk2Z2E0a0V2S21YRWQrRjVJNmNhaXY0MXc1?=
 =?utf-8?B?R0NZeDdpckxXV3pSVG9PWjUyQ1JYaG5Qcis2cnVDNGliUlZ6aXZrNTJ2d1Rh?=
 =?utf-8?B?NUJ5RjkxNU1ENFNoeFVJcExZR3dSQW9ES0RSSzFiVmU4VUFvNnZWa09GQTNj?=
 =?utf-8?B?UHgzbHMxL1JGN0dsVXJQSVRrRGZhOEF2RWpESGtXMG5IQXh6UzBoWXQxc3Fl?=
 =?utf-8?B?clBBeGkrVW96Nnd6bGtZd0dDWEJPZWZydmxiZ1FUN3ZqUnVWekxvcHp0UDJo?=
 =?utf-8?B?ZTBGa1ZQYUZiZnNCSEtvNytuazQ0b2V5cTU5YnYrNS8xL21ibVdHOEh1M0o4?=
 =?utf-8?B?NEk5M0V4andiZmpOanFXVzltc3hMcGMzbzNHdnhHeEk5ZnIzaU9VMnZIT0JQ?=
 =?utf-8?B?UDJpVjNCRUVVSDY2YjhiRW1udzRvL2tSMFJvYyticm92ZG44Vys2RFZENEIy?=
 =?utf-8?B?TjdvTHJvK1J0LzZBd1V2MmNSYjQybWZUeWpiSDJkRlhqZGUwUFYzRmN4R1lM?=
 =?utf-8?B?TjMreVhqQyszRkxyMS94TTAxTUpjQUczRVlPWFFiK3pnL2V6NTBRdFdCMFdq?=
 =?utf-8?B?OXRjM0k5STlDdFU4b3F3TENmN2g2U1RNOGtXSldqVjdDRkdteXJvWWIzSUNr?=
 =?utf-8?B?ZFFxZEtSQW91KzZZeGs5ZkQzTHVoZUtOYWY0MEtTTkZtb1phYVZpMzJ3aE5u?=
 =?utf-8?Q?lFlAj2fJid0VKKcdHB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd411ac9-16e3-4953-0b42-08df399ec63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 11:37:00.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22NTyi3p2AFwNcOmM7NWcOq4EGCdcgSaK5JGsosh8nscz03keSKoX0i/9yCW5xGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB460855
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KICBjYXNlIEFNRF9QUF9UQVNLX0NPTVBMRVRFX0lOSVQ6DQogICAgICAg
IGlmIChhbWRncHVfcmVzZXRfaW5fcmVjb3Zlcnkoc211LT5hZGV2KSkNCiAgICAgICAgICAgICAg
ICByZXQgPSBzbXVfcmVhcHBseV9wb3dlcl9zdGF0ZV9keW5hbWljKHNtdSwgbGV2ZWwpOw0KICAg
ICAgICBlbHNlDQogICAgICAgICAgICAgICAgcmV0ID0gc211X2FkanVzdF9wb3dlcl9zdGF0ZV9k
eW5hbWljKHNtdSwgbGV2ZWwsIHRydWUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKTsNCiAgICAgICAgYnJlYWs7DQoNCmhvdyBhYm91
dCB1c2UgYWJvdmUgbG9naWMgdG8gaGFuZGxlIHRoaXMgY2FzZT8gSWYgbm8gY29uY2VybiwgdGhl
IHBhdGNoIGlzDQoNClJldmlld2VkLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbi53YW5nQGFtZC5jb20+
DQoNCkJ0dywgcGxlYXNlIGFkZCAnRml4ZXMnIHRhZyBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlLg0K
DQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTm92ZW1iZXIgMywgMjAyNiA2OjQ0IFBNDQo+IFRvOiBIb3N1ciwgUHJpeWEgPFByaXlhLkhv
c3VyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2FuZywgS2V2aW4NCj4gPEtl
dmluLldhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+Ow0KPiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IENj
OiBHb3BhbGFrcmlzaG5hbiwgVmVlcmFiYWRocmFuIChWZWVyYSkNCj4gPFZlZXJhYmFkaHJhbi5H
b3BhbGFrcmlzaG5hbkBhbWQuY29tPjsgVmlzaHdha2FybWEsIFByYXRpaw0KPiA8UHJhdGlrLlZp
c2h3YWthcm1hQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8xXSBkcm0vYW1k
L3BtOiByZXN0b3JlIHRoZSBmb3JjZWQgcGVyZm9ybWFuY2UNCj4gbGV2ZWwgYWZ0ZXIgYSByZXNl
dA0KPg0KPg0KPg0KPiBPbiAwMy1Ob3YtMjYgNDoxMSBQTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+IE9uIDAzLU5vdi0yNiAzOjU4IFBNLCBQcml5YSBIb3N1ciB3cm90ZToNCj4g
Pj4gc211X2xhdGVfaW5pdCgpIHJlLWFwcGxpZXMgdGhlIERQTSBsZXZlbCB3aXRoDQo+ID4+DQo+
ID4+ICAgIHNtdV9oYW5kbGVfdGFzayhzbXUsIHNtdS0+c211X2RwbS5kcG1fbGV2ZWwsDQo+ID4+
IEFNRF9QUF9UQVNLX0NPTVBMRVRFX0lOSVQpOw0KPiA+Pg0KPiA+PiBidXQgc211X2FkanVzdF9w
b3dlcl9zdGF0ZV9keW5hbWljKCkgb25seSBwcm9ncmFtcyB0aGUgaGFyZHdhcmUNCj4gd2hlbg0K
PiA+Pg0KPiA+PiAgICBpZiAoZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwgfHwgc211X2RwbV9jdHgt
PmRwbV9sZXZlbCAhPSBsZXZlbCkNCj4gPj4NCj4gPj4gQU1EX1BQX1RBU0tfQ09NUExFVEVfSU5J
VCBwYXNzZXMgZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwgPSBmYWxzZQ0KPiBhbmQNCj4gPj4gc211
X2RwbV9jdHggaXMgJnNtdS0+c211X2RwbSwgc28gdGhlIGxldmVsIGlzIGNvbXBhcmVkIGFnYWlu
c3QgaXRzZWxmDQo+ID4+IGFuZA0KPiA+PiBzbXVfYXNpY19zZXRfcGVyZm9ybWFuY2VfbGV2ZWwo
KSBpcyBuZXZlciBjYWxsZWQuDQo+ID4+DQo+ID4+IFBNRlcgaXMgcmVpbml0aWFsaXNlZCBieSBh
IHJlc2V0IGFuZCBjb21lcyBiYWNrIG9uIGl0cyBkZWZhdWx0IGN1cnZlLA0KPiA+PiB3aGlsZSBz
bXVfZHBtLmRwbV9sZXZlbCBzdGlsbCBob2xkcyB0aGUgbGV2ZWwgdGhlIHVzZXIgZm9yY2VkLiBU
aGUNCj4gPj4gZGV2aWNlIHRoZW4gcnVucyBhdCB0aGUgZGVmYXVsdCBsZXZlbCB3aGlsZSBzeXNm
cyBrZWVwcyByZXBvcnRpbmcgdGhlDQo+ID4+IGZvcmNlZCBvbmUuDQo+ID4+IE9uIGFuDQo+ID4+
IFNNVSAxNC4wLjEgQVBVIGdmeGNsayBkcm9wcyBmcm9tIDIuOEdIeiB0byA2MDBNSHogd2hpbGUg
c3lzZnMgc3RpbGwNCj4gPj4gcmVwb3J0cyBoaWdoLiBXcml0aW5nIHRoZSBzYW1lIGxldmVsIGFn
YWluIGRvZXMgbm90IGhlbHAgZWl0aGVyLCBhcw0KPiA+PiBhbWRncHVfZHBtX2ZvcmNlX3BlcmZv
cm1hbmNlX2xldmVsKCkgcmV0dXJucyBlYXJseSB3aGVuIHRoZQ0KPiByZXF1ZXN0ZWQNCj4gPj4g
bGV2ZWwgbWF0Y2hlcyB0aGUgY2FjaGVkIG9uZS4NCj4gPj4NCj4gPj4gYW1kZ3B1X2RwbV9yZWFw
cGx5X3VtZF9wcm9maWxlKCkgcmVzdG9yZXMgdGhlIFBST0ZJTEVfKiBsZXZlbHMgYWZ0ZXINCj4g
Pj4gcmVjb3ZlcnksIGJ1dCByZXR1cm5zIGVhcmx5IGZvciBhbnkgb3RoZXIgbGV2ZWwsIHNvIGhp
Z2gsIGxvdyBhbmQNCj4gPj4gbWFudWFsIGFyZSBsZWZ0IG9uIHRoZSBQTUZXIGRlZmF1bHQuDQo+
ID4+DQo+ID4+IEZvcmNlIHRoZSBsZXZlbCB0byBiZSBwcm9ncmFtbWVkIGZvciBBTURfUFBfVEFT
S19DT01QTEVURV9JTklUDQo+IGR1cmluZw0KPiA+PiByZXNldCByZWNvdmVyeS4gVGhlIGNhY2hl
ZCBsZXZlbCBpcyBsZWZ0IHVudG91Y2hlZCwgc28gaWYgcHJvZ3JhbW1pbmcNCj4gPj4gZmFpbHMg
dGhlIGxldmVsIHRoZSB1c2VyIGFza2VkIGZvciBpcyBzdGlsbCByZXRhaW5lZCBhbmQgdGhlIGZh
aWx1cmUNCj4gPj4gaXMgbG9nZ2VkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQcml5YSBI
b3N1ciA8UHJpeWEuSG9zdXJAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCA3ICsrKysrKy0NCj4gPj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiBiL2Ry
aXZlcnMvZ3B1Lw0KPiA+PiBkcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyBpbmRleCBhOTAx
Zjg1MzU1OTguLjY1NGZmNjgyNGZkZA0KPiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPj4gQEAgLTI1NTMsNyArMjU1MywxMiBAQCBz
dGF0aWMgaW50IHNtdV9oYW5kbGVfdGFzayhzdHJ1Y3Qgc211X2NvbnRleHQNCj4gPj4gKnNtdSwN
Cj4gPj4gICAgICAgICAgIHJldCA9IHNtdV9hZGp1c3RfcG93ZXJfc3RhdGVfZHluYW1pYyhzbXUs
IGxldmVsLCBmYWxzZSwNCj4gPj4gZmFsc2UpOw0KPiA+PiAgICAgICAgICAgYnJlYWs7DQo+ID4+
ICAgICAgIGNhc2UgQU1EX1BQX1RBU0tfQ09NUExFVEVfSU5JVDoNCj4gPj4gLSAgICAgICAgcmV0
ID0gc211X2FkanVzdF9wb3dlcl9zdGF0ZV9keW5hbWljKHNtdSwgbGV2ZWwsIHRydWUsDQo+ID4+
IGZhbHNlKTsNCj4gPj4gKyAgICAgICAgLyoNCj4gPj4gKyAgICAgICAgICogUE1GVyBpcyByZWlu
aXRpYWxpc2VkIGJ5IGEgcmVzZXQsIHNvIHByb2dyYW0gdGhlIHJldGFpbmVkDQo+ID4+ICsgICAg
ICAgICAqIGxldmVsIGFnYWluIGV2ZW4gdGhvdWdoIGl0IG1hdGNoZXMgdGhlIGNhY2hlZCBvbmUu
DQo+ID4+ICsgICAgICAgICAqLw0KPiA+PiArICAgICAgICByZXQgPSBzbXVfYWRqdXN0X3Bvd2Vy
X3N0YXRlX2R5bmFtaWMoc211LCBsZXZlbCwgdHJ1ZSwNCj4gPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYW1kZ3B1X3Jlc2V0X2luX3JlY292ZXJ5KHNtdS0+YWRldikpOw0KPiA+PiAg
ICAgICAgICAgYnJlYWs7DQo+ID4NCj4gPiBUaGVyZSBpcyBhbHJlYWR5IGEgcmVhcHBseSBwcm9m
aWxlIHRvIGhhbmRsZSB0aGlzLg0KPiA+DQo+ID4gRG9lcyBpdCB3b3JrIGlmIHlvdSByZXBsYWNl
IHRoZSBjdXJyZW50DQo+ID4gc211X3JlYXBwbHlfcG93ZXJfc3RhdGVfZHluYW1pYyBieSBjYWxs
aW5nDQo+IHNtdV9hZGp1c3RfcG93ZXJfc3RhdGVfZHluYW1pYyhzbXUsIGxldmVsLCB0cnVlLCB0
cnVlKT8NCj4gPg0KPg0KPiBUbyBiZSBjbGVhciAtIHJlcGxhY2UgdGhlIGxvZ2ljIGluIHRoZSBj
dXJyZW50DQo+IHNtdV9yZWFwcGx5X3Bvd2VyX3N0YXRlX2R5bmFtaWMuDQo+DQo+IFRoYW5rcywN
Cj4gTGlqbw0KPiA+IFRoYW5rcywNCj4gPiBMaWpvDQo+ID4NCj4gPj4gICAgICAgY2FzZSBBTURf
UFBfVEFTS19SRUFESlVTVF9QT1dFUl9TVEFURToNCj4gPj4gICAgICAgICAgIHJldCA9IHNtdV9h
ZGp1c3RfcG93ZXJfc3RhdGVfZHluYW1pYyhzbXUsIGxldmVsLCB0cnVlLA0KPiA+PiBmYWxzZSk7
DQo+ID4NCg0K
