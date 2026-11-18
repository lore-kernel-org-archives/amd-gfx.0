Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D5606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zF5iQhIh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF0C10FC94;
	Wed, 18 Nov 2026 13:57:48 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CE910E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 13:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7yHE+nNKnOs033WBQmPyQHfRa+9U5MD9kDBuSAxC5cfZXRiv6Q8xXQMMsN88gG4JGZ+Zl0qIl1lFB3NSiW38gCu0OYEbOndZbqmEW75aBce/pZVraSuQoQt9S1mdm+fgE2w4B8OInO5DuB/okGnTG6OmtxnAgElcJnevMgYlvmEXq+yji9a+zeXjfYf5h+pVebJu18MUPlmgRf+RDZIIPiU2YY9iNbERBnrFTYbPnWzrpViajME9scEtl8KkTZEKW8sUx2FqSPYKO9j/zTlFIbbNOXYnqfs6smHj7c1f8VGjow9ASWmsB8GDqQF8qbn93VEfbWhTmEUmNDwC7eWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFog7mFrjt10WHnQLVsiNtQipNyGxKDB5mgyq2MbiOA=;
 b=XC8bN1/tPLcIT+5NSuBUl/swopFR0dGptVZ1sa2pwgmqmb7/+gKnwoTvCGW9QvyNFMshw7GmLihdEY2pJh9X6puAqYI0ciRtvlLI8pyRZwEcQY0uJRE/NH6ffbGM2NwOMuwOGSM0Ydki1DOYfI8rDH7CUMJCXtUYzg/P0oo+DYyvgs1PaeSrqt+fztTqf3UWqlmx5GPPJvjiTApE0AluG25Hz9LcI8nRp77/SRHzWlpgQzkCU/kKZsvLRXgifqEXfxKkkjDWo+vIYtkMpgrOjf5+Fs7B3AmaCihcyPiPK2KPGD/CXBZFTzRF13tyJ26/lnJ/85OL7I5fRAnMV2BDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFog7mFrjt10WHnQLVsiNtQipNyGxKDB5mgyq2MbiOA=;
 b=zF5iQhIhsV/Q0fDfnDhTxlKQPLdwN0gNCe0NiHFvpiobEGG3/2aJpRv/QYF2dsESnYyA7r1cFc2xzmYsuF9NbaDU3mli5phLxD96FEEwUc9JNw/kEbMhMR1OzD6JF+d+1Vh+plcGHYZe2A0wMrwCMySXv22yeZ00nWYdXVNXZ7I=
Received: from DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:57:26 +0000
Received: from DM4PR12MB7719.namprd12.prod.outlook.com
 ([fe80::6be3:f1a7:5d85:cc4d]) by DM4PR12MB7719.namprd12.prod.outlook.com
 ([fe80::6be3:f1a7:5d85:cc4d%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:57:26 +0000
From: "Guttula, Suresh" <Suresh.Guttula@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Thread-Topic: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Thread-Index: AQHdd2AZocFgjCaXP0SfgJ1IZx2am7cz1wGAgAABTwCAAAH9gIAAACkw
Date: Wed, 18 Nov 2026 13:57:25 +0000
Message-ID: <DM4PR12MB7719FDA9358F77F1CFA35DC0937A2@DM4PR12MB7719.namprd12.prod.outlook.com>
References: <20261118132348.4101528-1-suresh.guttula@amd.com>
 <b7863c55-dacc-4519-97e8-a9cc6b07ffea@amd.com>
 <DM4PR12MB7719CCEBF0DDECF8CE99D732937A2@DM4PR12MB7719.namprd12.prod.outlook.com>
 <c14edcc8-3bbf-497d-8e8d-c0a766eaae3b@amd.com>
In-Reply-To: <c14edcc8-3bbf-497d-8e8d-c0a766eaae3b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-18T13:56:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7719:EE_|IA0PPF4D923B935:EE_
x-ms-office365-filtering-correlation-id: 319f6327-3dd7-4034-f408-08df457be07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|261026121527099003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003|261009223027099003|261022075727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: JevJPc62wiQ29CbdC0zAUvWb8Ot5wI+B0OAzn8QlB3HbiM7pQfgIkhe7HpTwaZ43HE/JDuP8wT9RRMXWmylX1xgskHGc/f7fComPPnpnZy/c1f1/ZuUrzRe2/fYrON6M+Z56TeuitvFAoPCkKEvfcFR1numOqyxSbCNEkrz0F9JZt+3+QBdZbmoN2vnufm4y3GVn0BiDtZ2rVZqA2M2uzLdvjPGAhGajSlau8DN6icIg/T9os2fVlLpVs+5rMi+LCnyMgqwjiFW559Rv7ORVDjJN+4KLOL5UD+LvJxpBodP31IqAKtv8cZMF4hi+BZkxRKLzMR+dh896BdTjDP+RYqvTkx1rllF+jzy6PN26sP6syfiAUg18MPenxWRVzOOFn6yL8bra5/cMco+p2UA1+L5tgvOyW1D6RxLj6eIghAnrTbEV89n+uGfDnaO7SrG+1aYFFl/BHZEHtZzb8vIA33PrAOzrrRAZrt8GwlXKihfyMA3XG13K3CYc+vTorW8E/0Ymlfp5Bgt/ztksIeoFj0F4P42P/8Ufw9KAtUgzrJAR2qBIZHgkWkkx4D1M//IlvbqW/xczT1QcHxz1BwtFGDz7SJ0Gutq/sa8hMMblSm8y0FPCKgKm80s9w44DEaXbDs1NZSidEpaGHBsnLRUZvMcBdZ7MeZH6Qa1lsKMV0wwS380zWeOpbIT+K1iTbQq7j099urnJSrFdMTTLstQdxDxHwc1fd70lSL4GH1jovwc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7719.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejVtd2ZkT21Qd2lwdHdaQWdOeGxHYWNXL01GNDRpMnE3ckdTcDlTK0E3OGcy?=
 =?utf-8?B?cjhSS1cyM0kxREtLNmpsTnIvR3JZakZidFRUaXBLeEdvc3hJR3FKUHJyd2oz?=
 =?utf-8?B?Yk9QY0c3eVJ3NTB2QU9BcTZmUSt0UUhsRUxXTHVLcVBRYXcyVHZTWENONXhp?=
 =?utf-8?B?eDFzME1iZ2U1ZHZad2JqVHRRTGpYb2ZUUE9KRmhMMVVRWHkzYWJBdHhyQ1Ni?=
 =?utf-8?B?Zk5XbmZzbUl6dHRFa3hYNG8zKzdjL1J1bHA4VjJuR0R2NWJzM2JXaWV1RklS?=
 =?utf-8?B?OG96RXdDSG9DNmFub1h5a3NNTmZPbU43TDRvcTVhYVptYStrUUxycVEwM3pM?=
 =?utf-8?B?MlZ3M2FGZWU0dk93NzJtOVRJTU5hR2JoQU1nYWdHbmVTZStRNTFuOVROcS9m?=
 =?utf-8?B?MnF6dWgzdkRqbDNoOWM5cWFzQ3J1SkxtcGwrNjNqNEhKWThreVpoaldEMDJy?=
 =?utf-8?B?bnNkZjBlczhKSW13TVFBbjNUTUFydGRMVDlqaXBxOElkb1doZ1llTkF2QkEx?=
 =?utf-8?B?ZDErcXhTQ3VYNGh0enlqTWFNZ0VQZVNXMFRvbjRaejAxdGozZ1FuSjhPSWpZ?=
 =?utf-8?B?WGZ2eHN6eWFiNVE1Y0cwQzBESEFHK1QxRlVUUk9XYnIwRGpaeXZFNGV5WDAz?=
 =?utf-8?B?ejY0R25tbDZJNUIxRU9QanZpKzBRcjVlZ1Rrd0hXQ2lYcHZISVA0Ky9VODcw?=
 =?utf-8?B?aUt3VUs1YnBHTGVjbXZ1ZDlCazlENDdlSWdCTDd2YS9sdVh1VDZ3M3BBS2R6?=
 =?utf-8?B?S0JvVkNMemdPZXh6cFJ5RzZQSnRBN0FJejFuQ0ZxaFBDSTZXV1pRMnpwRTZi?=
 =?utf-8?B?MVdIU3hyTEVmNGhPb3k1VE9EQXE4bWFFMFpnL1BUK3BEbUNJQTNEV2pXdk11?=
 =?utf-8?B?Ullwa3J2cTNmUWJkYmE0b0pKdjRuc29iSFFpYU41S3B3TUFsdWZ0NFhDMnBi?=
 =?utf-8?B?NzVzRXlRMlJCMXlIb0FtU0ZyQ2Y1dTBnbGVBMFE3MDZvMVRPRFIvWmdka2Zx?=
 =?utf-8?B?d0NTbHNZUjB5aXh6ajFZcXBzNm9ueWMwZzNRVlZUUkJLY3JKK0hyNEFXT0pz?=
 =?utf-8?B?cjU4Nk5XY1g3Y0p0NUJFZndRaDhtRkltTnE4RTFLTUVrY05qR2FJcnJNakU0?=
 =?utf-8?B?SmlLUS81TUVEYUM1aVRqQjBOY3ZpaTVJZFRqUW51eGdGdUxGQzBXd3dlbGtk?=
 =?utf-8?B?Z1c1QjY0aGJBM0hCRnVPeStJWmxoRDNMV0RlVm5XeE94Mlp6WWlBendhT3Ny?=
 =?utf-8?B?NzUrcUs1Vnhlc1BqcEU5ZzE2L1JZOWhTQmw1NkNkUkJiS2p0Ukhac3pPVDdq?=
 =?utf-8?B?RlIwcG82OGtneUpIRkw3bjJwVTZJYXdEeVNLdDBpQ1ZPOGxLalNHYjdsdTg1?=
 =?utf-8?B?cVJmTWxDQk9nSXB1YnNIeElqeGROZHoyaURRU0NIeGZsSFpXQlpNSE42WjZU?=
 =?utf-8?B?WmZrNm40dmRkNFpYOE9GN2trM0FUUjhDNjJsNjAwWjE3ZnRxOXhWWlJ6SHRw?=
 =?utf-8?B?TGlTazN0bytlNkJWSEgrWHF3TjROTEtER004MDJtNjd5aFkwdW5xUFhlL0ov?=
 =?utf-8?B?N25ybU5PZnh3TlNQbGpBWXI0QW00Y2FFaXZ6NEIrQjkvQ3EwRVlVMDJoUlRO?=
 =?utf-8?B?eVZta2lUQ08rVTl4Rk54Wi9pNEplV09hVTl3MWVPN1cwemN4ZnRkdXI0MSsy?=
 =?utf-8?B?ZVpmTnFMOHRER3NTdnpnRWRGbDRsR2dSblA2RENNSVdkZmdIZVQ2QUhoQ0pP?=
 =?utf-8?B?UWxMcHE1T2xzQVp5eVJCU3RsSXJNMjkxanV3elhlalprWk5kOGxuK1QvRW5h?=
 =?utf-8?B?Znoxd0dweVNiTnBSQnN2MFNkeFA2dStsN3hDQWpoNzNxQXpLR3FxRGJqWnQ1?=
 =?utf-8?B?N2p1WENCVjF6QjU2N1pJV1h6dXVWbUNiNmZyZndGRWR1N1gwOGhNdFl0SWFE?=
 =?utf-8?B?ZUpZL0J4eVR2eWl0VVBXV1pSZW9ldFRyWFBjWHdEeTZkUnAzb3g4OGlsbTJl?=
 =?utf-8?B?dHN3RjhtR3F0ZUhPcWxjV0tTUUUwQWlCNG50QWsyR01xaTIxcURBcml0akQ1?=
 =?utf-8?B?OVNFd3pNWStST2VsN1hCYXhXSGZvQlIwZHRiWWRxSzJzcUMxR0QwWDNiRWV0?=
 =?utf-8?B?dWZ3dDE4Q2oxU2xtL1I1VGdTZy95Q25WT3hmSUtuTFNUcEhqWkY3K1NMSWZq?=
 =?utf-8?B?c3VKOFhlYSt2U2RQWFBDK0hscWp4UVc2bStBTkV6R2hyY0RmUWhxcTI4UFVD?=
 =?utf-8?B?TmNmUENMcklMMHUxMzZxWnB1Nm1NbHZ6QWNFcVRIZkJlOG00Y2ovaU5USkVz?=
 =?utf-8?Q?8HwysaVfBLRDS09BSp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319f6327-3dd7-4034-f408-08df457be07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 13:57:25.9417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3GFBQ+kffYosSE3BnEFeCMpPw2AFmkIct1dE73dFCXH26e6ltQNAuUKRtltVrQDU5F67n1VMRaJ2XXNVj1WJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
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

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiAxOCBOb3ZlbWJlciAyMDI2IDE5OjI2DQpU
bzogR3V0dHVsYSwgU3VyZXNoIDxTdXJlc2guR3V0dHVsYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBFbmFibGUgSU1V
X0kvRFJBTSBGV19MT0FEIENNRA0KDQoNCg0KT24gMTgtTm92LTI2IDc6MjEgUE0sIEd1dHR1bGEs
IFN1cmVzaCB3cm90ZToNCj4gQU1EIEdlbmVyYWwNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDog
MTggTm92ZW1iZXIgMjAyNiAxOToxNA0KPiBUbzogR3V0dHVsYSwgU3VyZXNoIDxTdXJlc2guR3V0
dHVsYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZC9hbWRncHU6IEVuYWJsZSBJTVVfSS9EUkFNIEZXX0xPQUQgQ01EDQo+DQo+
DQo+DQo+IE9uIDE4LU5vdi0yNiA2OjUzIFBNLCBTdXJlc2ggR3V0dHVsYSB3cm90ZToNCj4+IEZv
ciBHQyAxMSwgRXZlbnRob3VnaCBJTVUgdWNvZGUgbG9hZCBmcm9tIEJJT1MvSUZXSSwgUFNQIGV4
ZXBjdCBMb2FkDQo+PiBjb21tYW5kIGZyb20gR0ZYIHRvIGxvYWQgSU1VIHVjb2RlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFN1cmVzaCBHdXR0dWxhIDxzdXJlc2guZ3V0dHVsYUBhbWQuY29tPg0K
Pj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAg
OSArKysrKysrLS0NCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ltdV92MTFfMC5j
ICB8IDE0ICsrKysrKysrKysrKystDQo+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMNCj4+IGluZGV4IDdhOGNjMDQzZGY1ZS4uOWQ2YzE5MmRiMzQ4IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4+IEBAIC00MDkx
LDggKzQwOTEsMTMgQEAgc3RhdGljIGludCBwc3BfbG9hZF9ub25fcHNwX2Z3KHN0cnVjdCBwc3Bf
Y29udGV4dCAqcHNwKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICAg
ICAgICAgICAgICAgIH0NCj4+DQo+PiAtICAgICAgICAgICAgIGlmIChmd19sb2FkX3NraXBfY2hl
Y2socHNwLCB1Y29kZSkpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAr
ICAgICAgICAgICAgIGlmIChmd19sb2FkX3NraXBfY2hlY2socHNwLCB1Y29kZSkpIHsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAoIXVjb2RlLT5mdyAmJiAodWNvZGUtPnVjb2RlX2lkID09
IEFNREdQVV9VQ09ERV9JRF9JTVVfSSB8fA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICB1
Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX0lNVV9EKSkNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9kYmcocHNwLT5hZGV2LT5kZXYsICJkb24ndCBza2lwIElN
VSBmdyBsb2FkIVxuIik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+DQo+IEtlZXBpbmcgdGhpcyBpbiBj
b21tb24gY29kZSBjYXVzZXMgc2lkZSBlZmZlY3Qgb24gb3RoZXIgU09Dcy4gQmV0dGVyIGFkZCBh
IGNoZWNrIGluc2lkZSBmd19sb2FkX3NraXBfY2hlY2soKSBzdWNoIHRoYXQgaXQgcmV0dXJucyBm
YWxzZSBmb3IgdGhlIHBhcnRpY3VsYXIgR0MgSVAgdmVyc2lvbi4NCj4NCj4gVGhhbmtzLA0KPiBM
aWpvDQo+DQo+IFRoaXMgaXMgc3BlY2lmaWMgdG8gQVBVcywgTGV0IG1lIGFkZCBBUFUgY2hlY2sg
YWxzby4uIExpa2UgYWRkZWQgaW4gaW11djExX2luaXRfbWljcm9jb2RlKCksIHRoYXQgd2lsbCBk
aWZmZXJlbnRpYXRlLg0KDQpJZiBpdCdzIGFwcGxpY2FibGUgZm9yIGFsbCBBUFVzIGluY2x1ZGlu
ZyBhbnkgdXBjb21pbmcgb25lcywgdGhlbiB0aGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkbid0IHNw
ZWNpZnkgIkZvciBHQyB2MTEiLg0KDQpUaGFua3MsDQpMaWpvDQoNCkFzIG9mIG5vdywgdGhpcyBp
cyBzcGVjaWZpYyB0byBHQzExIG9ubHkuLiBJIHdpbGwgdXBkYXRlLg0KDQo+IFRoYW5rcy4NCj4N
Cj4+ICsgICAgICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgICAgICAgIGlmIChwc3AtPmF1dG9s
b2FkX3N1cHBvcnRlZCAmJg0KPj4gICAgICAgICAgICAgICAgICAgIChhbWRncHVfaXBfdmVyc2lv
bihhZGV2LCBNUDBfSFdJUCwgMCkgPT0gZGlmZg0KPj4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9pbXVfdjExXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9p
bXVfdjExXzAuYw0KPj4gaW5kZXggYjZjNGFlMzVjYTAzLi4zYWVmNjhjOTg5MWEgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjExXzAuYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3YxMV8wLmMNCj4+IEBAIC0zMSw2ICszMSw4
IEBADQo+PiAgICAjaW5jbHVkZSAiZ2MvZ2NfMTFfMF8wX29mZnNldC5oIg0KPj4gICAgI2luY2x1
ZGUgImdjL2djXzExXzBfMF9zaF9tYXNrLmgiDQo+Pg0KPj4gKyNkZWZpbmUgSU1VX0RBVEFfU0la
RV9CWVRFUyAgNjYzMDQNCj4+ICsNCj4+ICAgIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L2djXzEx
XzBfMF9pbXUuYmluIik7DQo+PiAgICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9nY18xMV8wXzBf
aW11X2tpY2tlci5iaW4iKTsNCj4+ICAgIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L2djXzExXzBf
MV9pbXUuYmluIik7DQo+PiBAQCAtNzMsOCArNzUsMTggQEAgc3RhdGljIGludCBpbXVfdjExXzBf
aW5pdF9taWNyb2NvZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAgICAgZWxz
ZQ0KPj4gICAgICAgICAgICAgICAgZXJyID0gYW1kZ3B1X3Vjb2RlX3JlcXVlc3QoYWRldiwgJmFk
ZXYtPmdmeC5pbXVfZncsIHJlcXVpcmVkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImFtZGdwdS8lc19pbXUuYmluIiwgdWNvZGVfcHJlZml4KTsNCj4+IC0g
ICAgIGlmIChlcnIgPT0gLUVOT0RFViAmJiBpbXVfaW5faWZ3aSkNCj4+ICsgICAgIGlmIChlcnIg
PT0gLUVOT0RFViAmJiBpbXVfaW5faWZ3aSkgew0KPj4gKyAgICAgICAgICAgICBpbmZvID0gJmFk
ZXYtPmZpcm13YXJlLnVjb2RlW0FNREdQVV9VQ09ERV9JRF9JTVVfSV07DQo+PiArICAgICAgICAg
ICAgIGluZm8tPnVjb2RlX2lkID0gQU1ER1BVX1VDT0RFX0lEX0lNVV9JOw0KPj4gKyAgICAgICAg
ICAgICBpbmZvLT5mdyA9IGFkZXYtPmdmeC5pbXVfZnc7DQo+PiArICAgICAgICAgICAgIGluZm8t
PnVjb2RlX3NpemUgPSBJTVVfREFUQV9TSVpFX0JZVEVTOw0KPj4gKw0KPj4gKyAgICAgICAgICAg
ICBpbmZvID0gJmFkZXYtPmZpcm13YXJlLnVjb2RlW0FNREdQVV9VQ09ERV9JRF9JTVVfRF07DQo+
PiArICAgICAgICAgICAgIGluZm8tPnVjb2RlX2lkID0gQU1ER1BVX1VDT0RFX0lEX0lNVV9EOw0K
Pj4gKyAgICAgICAgICAgICBpbmZvLT5mdyA9IGFkZXYtPmdmeC5pbXVfZnc7DQo+PiArICAgICAg
ICAgICAgIGluZm8tPnVjb2RlX3NpemUgPSBJTVVfREFUQV9TSVpFX0JZVEVTOw0KPj4gICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+PiArICAgICB9DQo+PiAgICAgICAgaWYgKGVycikNCj4+ICAg
ICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4NCj4NCg0K
