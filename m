Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16C606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=huzJR6pb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC63510E6D1;
	Mon,  9 Nov 2026 07:32:06 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E55E10E6D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 07:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q989TDsokIwAoyCLt03Vrd3zVNeI6Yk0BG0KoIizTje1nrc2vPDqMZpsAYeq+FRvZjAbJA8+U9NItP+AfyNn8ZPzEaQHcMCAvmsIuZI9hNhD1IRFLGU0iAx6IRCy/oldLQ92lnjbUov8uDry3c1hwn1iaOKk516KFzIDgW+6pbMh6FglpmBKIvjH2dAaQG20pyp5jZRXieLn7IrO8WTza0Ud5cKjqdOmrOZk6VIu2XwtBGBM6M7uEp/KHUAkkdlWVNLuWHnp0lDp0JFZZr3+ShP/Y8RyN38f9w3ZdyODqpzAbGAPvf5lzAsYmecS8edo7DQGMBhsx+g5qjWrtM31+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmG2OxNNxCZIyHu5juHN1CImln9XfVDE6rtz9EsNIYk=;
 b=YrF7B25+lZ8NYHnpYPFDw7cFhlIXd/UmK/r14/OeMp74uaIiPN2v6urThWnYGKGbZvghJ1Cv0LOc1g7pHO6kT6Z0+AmR3mddLMYrMdb6BeEa6xeasbcc58rGV1RVW4xYrHthm7q6lBZfYZzZiYA1Tug2v/bSOLtlOU3WyJ5A1kJ15o2kxU7uOVlPTE2HeSatSn9qh4HvoEjBBVgNtCOeUMSam/N8KTAROW6FaJp5I9RJ4PpbO5cbeoAVcPbac334FZb9sijAI0QLtb6f7qGNDsOm/nBqE7j6YCgVDlR4bpUn6J6OuqroTvB2Mg+eNRbR1ITf1ydl4WnWBdPaS5xLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmG2OxNNxCZIyHu5juHN1CImln9XfVDE6rtz9EsNIYk=;
 b=huzJR6pbyw6/iHmrfHUIKBMZgRAIbihovG7aldNF8fBfNTCNC+h9UWc77dDknnu8X9m9L5zd3vP6P6grXNQIyWpYsCiC4vCrxG/mrf2TV1H/MiFO7eO3P65U1OcZ09VqMwCuoBMjfl968SHnlAZVZscEynltVLxW+nm/aZBwuiY=
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by DM6PR12MB4419.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 07:31:57 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 07:31:57 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: Jiaming Fan <fan.jiaming@hotmail.com>, "Chengjun.Yao@amd.com"
 <Chengjun.Yao@amd.com>, "Su, Yang" <Yang.Su2@amd.com>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkcl: use DMA iterator in PRIME address fallback
Thread-Topic: [PATCH] drm/amdkcl: use DMA iterator in PRIME address fallback
Thread-Index: AQHdbTnL4nL/o6ni90yH/2poNTkoBbclXeGw
Date: Mon, 9 Nov 2026 07:31:57 +0000
Message-ID: <DS5PPF18A985A10B615386A0A4487AE37CA94732@DS5PPF18A985A10.namprd12.prod.outlook.com>
References: <OS3PR01MB102518A543E274E19D5FC0000E7772@OS3PR01MB10251.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB102518A543E274E19D5FC0000E7772@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-09T07:30:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF18A985A10:EE_|DM6PR12MB4419:EE_
x-ms-office365-filtering-correlation-id: 073c60ee-18aa-4a5d-49a3-08df3e3388f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|38070700021|5023799004|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info: 6EOGWlhbnN02wPI1w1Jq/1AQOG3bkVBsQxIOTTZF6RPIqDNc4q6tbUMY6k3zenoyRSV7wonuiMLBuAqFjwrc/xTLiyrqeLPwTQkspj1LZtM7FEZtDTUxjZr4aC1N+7LSQtJZ4Kbh+Xtrci6NUYK/00KZd0Rm3GErkRBMNzoGcEJxVo676x9FzBkSyVrN4viGTWnbLwBY45VkL+3z9CWVpagU5kmoi0d4InrWevFQMvOYzzrjMPUcqN6L0qRCpJgdlG2aJKhiru/IflHSL+KMs1Aa1uTMNHmgDmXEj5i89ji27FkcoUFQHNYOzz/Iv0oWf965pDhzzhWMBeOdrsbZDzlRO35xUrQF6LfUXNBB3pAvLvTN4D7alWizcQOGGtIDqdnooqAEWR7BkHxSerHcj6lYuWnTLGu0hqLTUjqhL8cTh39qup0mJ8awDAMmuK+nfAZ67TrPDsx3BSOBVaofZdhnPQtEtTNoWISPhL8Sx42gGLo29+ntbSSdtVQajckcYtiJYUwPEaO1vQfBMTK/eUXjOCEWOFJzENxZIS5ezTGtLob4LdBKaO/64MB6Que9/nML9UjdGAPr3wEr9vYMwrk7KLNIQHUsxxsrDV0QTDlMsO23GaOS+2OUWlUsK1GE364JKav6H1svN7o1bZUBorYfcJHvpJVJDU4T46DaErMhYhebES27+loXrXPMJ2a6UcE7SEUX0RhAeulWTDh14Ek9puxUWrpn3kZZj7eJIBQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzdHd1dFVW5uNWNlSm5ra3IrbEt3T2k0RWdLQ01oOWIzZVJaVkF4WENQbXhL?=
 =?utf-8?B?QVA3SGxUNzI4azZwQklsTFA3YlFtV08zVTY4RG9ScmNxQkNmSytNYmdQNEZz?=
 =?utf-8?B?b0NTUzQ4dnVZSzRxamFzdytzOFhsNlZEUitoQkxZTmJ0MGFRUy9ET2tmek91?=
 =?utf-8?B?czlHbUxjN2VwVmFqQTZZRVpMa0ZiMjdYNWI4V01WYnFuWXRQSUFNdE14WVZ2?=
 =?utf-8?B?b01vM2FoSEVsVU9Kb2VuTGNERGxjeElKaVRsUWJadWRxZGxZQTBWU093YUZp?=
 =?utf-8?B?N3paRVNJMXBJMWN4WlZ0cm9PbEJiYVhsYm1CREcxN2FqNklRNDBzdnJpSjJW?=
 =?utf-8?B?MTU1L0pLU2hBNFBHK3lsVERCaWRVbVd3U3lwdFpjdXZzTHdWRG1KWjBnaFVn?=
 =?utf-8?B?S01EZGVVRmh3NTFnVzE4WDZrRWFKWjU5OW52NDJ1VnovdGRvc2hnUU91dWcz?=
 =?utf-8?B?OWdoYkNXOFhMVlFhaWVwNC94Z3FBUHZDdi9WMVFMbWxNU3NFR0YvUmQ5cXhr?=
 =?utf-8?B?NS91U2ZkejlHV3FVOEhtT3RnN0J2UHJLWlRJdDdJeXBGUVhHTXgxWUVGUUhO?=
 =?utf-8?B?T1FVOXlWRGdDdkVhdUp5aHdna3VZQTlFYXEvMGpRR2hBbFZaTGs5a2w5Sm1P?=
 =?utf-8?B?WHZ4akhKM1VRbnBySkVvNEdaTVduUDR6VGNIQkVESnlrYnZGTUF1KzBGV1pZ?=
 =?utf-8?B?ejFVU0pLaElkcmVoOTY5ckdQVW1PaFZia1NkamJqNXIyUTZOcFJUZ2RFNldv?=
 =?utf-8?B?bFEzL21yc25KMWR6UjdWckJza1FYNmRJalRYdTVPWjdqTnhZaHF2NHZDeHJS?=
 =?utf-8?B?WGRDOVh3V0ZVSXpSUGlBcjd5eDNHTEZPUWljUzVXU0doY2tLQWt4QWpWbHlW?=
 =?utf-8?B?MjRGQUZzUUkyeXBrcW9OSkJkZGNwMnBYMmlOK0xoTnJoM0YreUg0L2k5MW83?=
 =?utf-8?B?V2lpbWpFZDJhelJxamcyelZyejlqZnExaVRZNFdtSENFWktnU1lsN1d5em45?=
 =?utf-8?B?dkNXRk5Gc3NmM1N3ZHM1TDJCZCtWNnNIUW5wbW41bWNaTXdDWlBJdDFJcVZR?=
 =?utf-8?B?cUgrVXNYV0JWYllrWFcrUjBWSGNwMHM3Qm43MjhSeWxobVk3TENmTDJqTFA1?=
 =?utf-8?B?SFg2cmliZkhldTV0WlJiZDkxS0tLRkFsRVhzYWNINWg5MXZaSFd0VTR2S2Qz?=
 =?utf-8?B?NGFQK3dtT0JObXNCZVRxenR0dVRWaWhZbmFDdThob2ttY2dvZUJJOWY5cnJo?=
 =?utf-8?B?cytYSHlxUnhLNm80TzZyamt5VlJrUVJWZjhZV3JrRUFETVE5aEpHY2hSQW1a?=
 =?utf-8?B?VzU1Qmg3bFl5T044anlhZlBxOWJoaEc2UWxuQWt4c2kvNXErblB6cXdhbWVL?=
 =?utf-8?B?NDFhR3owV1NzS1lVS2NIYkw4NTRDdnl6REJiMGdtQ21OVCtRRld1T1NxS05j?=
 =?utf-8?B?SXBKbitxY1doNU0zb3plMGVSWlIyNWE2U3NOL1RuaTg4NUgzQ1lvQ2s0SUVp?=
 =?utf-8?B?ZVpCTHBCeHNvZHU5WjhuRmd2dVFEbFlIRnMzVWJIWXVKVWdoT253c2lmd3Zt?=
 =?utf-8?B?a0ZmSzF5NGxYbXNCVzY4R3hvcTBTQ1ZGd3hhMXdOaHhSakxpdUtyNERVbXly?=
 =?utf-8?B?OHN5cUNiblF5TEVZV1dWdTVOM3BDMXR6Sm05MzlVWWEvWTc1WjJ6dDVmdTdr?=
 =?utf-8?B?R3grUXRFRVdJN1ZOeU1yYkMxbCt5QnFrZ1dXakljMkJrVTMxNVFhV0lQWnBC?=
 =?utf-8?B?MVR4bVNQMHJ5Y1Rza3poWHQ3S3ErN0tJZkF0WGFwdDd5SEloMGozV0s4UlFr?=
 =?utf-8?B?emtpaEYwdzdaUW1ITDNzRFZTSFRVMnlFWUNrRFppZjRwZEpoVDVZYldQdE9B?=
 =?utf-8?B?UUVjajhPRlh0Mko5V1k0OGx3MHk1SzhJdjdETFB1SXAxWHozemZaS293R3I1?=
 =?utf-8?B?a2Joa2dmZDVNUTh3NHR5VnBXSGdlQ09id29LWUpkWVVLY0EyTEVDbjBUQW1s?=
 =?utf-8?B?TGFPOUhRQ3REVllsb2dGbloxbTREZ25kUklQeno1TFBwenIvNVBSOW5aczh6?=
 =?utf-8?B?Mk91dkZMRmVuZ253RFpFeGkvNDJ1eFpZSjJEMXdEVVFQOHNocHJOL3BzT3g5?=
 =?utf-8?B?VDBlRGlINkJMa3VvT0VvN1NBNjJlNXQwZFpiWmM3V1NXRHNTYzdBVTNHRTla?=
 =?utf-8?B?eXdKYWNmTytTTXJMMVBWL1lrQmFNdEgzWWhuTSs1bmNUME92dUhGREZyWjJQ?=
 =?utf-8?B?Tll1aWpnRnE2a09hdUxwckJNa0lNK2ljemZJeXZaTHAwOVpXQnZjalRGMktj?=
 =?utf-8?Q?DRQpDwyG+nK0TFlYOZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c60ee-18aa-4a5d-49a3-08df3e3388f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 07:31:57.1491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/k1pYmxE2HnupEpHPPfWVM9JgzbQA2cH2ilczzYOH90Wxlbh4T+n1rKytYZ3cXfqLGx149et++hfu6C28j1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgamlhbWluZywNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2ggYW5kIHRo
ZSBmaXguIFdlJ2xsIGFwcGx5IHlvdXIgZml4Lg0KDQpSZWdhcmRzLA0KQm9iDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKaWFtaW5nIEZhbiA8ZmFuLmppYW1pbmdAaG90bWFp
bC5jb20+DQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNSwgMjAyNiAxMToyNSBQTQ0KVG86IENo
ZW5nanVuLllhb0BhbWQuY29tOyBaaG91LCBCb2IgPEJvYi5aaG91QGFtZC5jb20+OyBTdSwgWWFu
ZyA8WWFuZy5TdTJAYW1kLmNvbT4NCkNjOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRrY2w6IHVzZSBETUEgaXRlcmF0b3IgaW4gUFJJTUUgYWRkcmVzcyBmYWxsYmFjaw0KDQpb
U29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1h
aWwgZnJvbSBmYW4uamlhbWluZ0Bob3RtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoN
ClRoZSBLQ0wgZmFsbGJhY2sgZm9yIGRybV9wcmltZV9zZ190b19kbWFfYWRkcl9hcnJheSgpIGNh
bGxzDQpkcm1fcHJpbWVfc2dfdG9fcGFnZV9hZGRyX2FycmF5cygpIHRvIGV4dHJhY3QgRE1BIGFk
ZHJlc3Nlcy4NCg0KT2xkZXIgaW1wbGVtZW50YXRpb25zIG9mIGRybV9wcmltZV9zZ190b19wYWdl
X2FkZHJfYXJyYXlzKCkgd2FsayBlYWNoIERNQSBhZGRyZXNzIHJhbmdlIHVzaW5nIHNnLT5sZW5n
dGguIFRoaXMgYXNzdW1lcyB0aGF0IHRoZSBwaHlzaWNhbCBhbmQgRE1BIHZpZXdzIG9mIGEgc2Nh
dHRlcmxpc3QgaGF2ZSBpZGVudGljYWwgbGF5b3V0cy4gVGhhdCBhc3N1bXB0aW9uIGRvZXMgbm90
IGhvbGQgd2hlbiBETUEgbWFwcGluZyBtZXJnZXMgZW50cmllcyBvciB3aGVuIG9ubHkgdGhlIERN
QSB2aWV3IGlzIHZhbGlkLiBJbiBzdWNoIGNhc2VzIHRoZSBmYWxsYmFjayBjYW4gbGVhdmUgRE1B
IGFkZHJlc3MgZW50cmllcyB1bnBvcHVsYXRlZCB3aGlsZSBzdGlsbCByZXR1cm5pbmcgc3VjY2Vz
cy4NCg0KVXNlIGZvcl9lYWNoX3NnX2RtYV9wYWdlKCkgdG8gd2FsayB0aGUgbWFwcGVkIGVudHJp
ZXMgZGlyZWN0bHkuIFRoaXMgdXNlcyBzZ3QtPm5lbnRzIGFuZCB0aGUgRE1BIGxlbmd0aCBvZiBl
YWNoIGVudHJ5LCBtYXRjaGluZyB0aGUgc2VtYW50aWNzIG9mIHRoZSB1cHN0cmVhbSBkcm1fcHJp
bWVfc2dfdG9fZG1hX2FkZHJfYXJyYXkoKSBpbXBsZW1lbnRhdGlvbi4NCg0KVGVzdGVkIG9uIExp
bnV4IDUuNC4xOCB3aXRoIGFuIGltcG9ydGVkIERNQS1CVUYgd2hvc2UgbWFwcGVkIHNjYXR0ZXJs
aXN0IHByb3ZpZGVzIHRoZSBETUEgdmlldyByZXF1aXJlZCBieSB0aGUgaW1wb3J0ZXIuDQoNCkZp
eGVzOiBmYWFiOTYzZDQwMzUgKCJkcm0vYW1ka2NsOiBmYWtlIHRoZSBkcm1fcHJpbWVfc2dfdG9f
ZG1hX2FkZHJfYXJyYXkiKQ0KU2lnbmVkLW9mZi1ieTogSmlhbWluZyBGYW4gPGZhbi5qaWFtaW5n
QGhvdG1haWwuY29tPg0KLS0tDQpIaSwNCg0KVGhpcyBpcyBhIEtDTC1vbmx5IGZpeDsgdGhlIHVw
c3RyZWFtIGhlbHBlciBpcyBhbHJlYWR5IGNvcnJlY3QsIHNvIHRoZXJlIGlzIG5vdGhpbmcgdG8g
c2VuZCBhZ2FpbnN0IGFtZC1zdGFnaW5nLWRybS1uZXh0LiBJIGZpcnN0IG9wZW5lZCBpdCBhcyBS
T0NtL2FtZGdwdSBQUiAjMjMxLCBidXQgdGhhdCByZXBvIGlzIGEgbWlycm9yLCBzbyBJIGFtIHNl
bmRpbmcgaXQgdG8geW91IGRpcmVjdGx5IGFzIHRoZSBjb21taXQgaGlzdG9yeSBzaG93cyB5b3Ug
bWFpbnRhaW4gS0NMLiBLZW50LCBDQ2luZyB5b3UgYXMgdGhlIGNvbnRhY3Qgb24gdGhhdCBQUi4N
Cg0KS2VybmVscyB3aXRob3V0IHVwc3RyZWFtIGMwZjgzZDE2NGZiOCAoImRybS9wcmltZTogZml4
IGV4dHJhY3Rpbmcgb2YgdGhlIERNQSBhZGRyZXNzZXMgZnJvbSBhIHNjYXR0ZXJsaXN0IikgYXJl
IGFmZmVjdGVkLCBhbmQgNS40Lnkgc3RpbGwgaGFzIHRoZSBvbGQgY29kZSBhcyBvZiA1LjQuMzAy
LiBJIGhpdCB0aGlzIG9uIGEgY3VzdG9tZXItcGlubmVkIDUuNC4xOCBrZXJuZWwsIGltcG9ydGlu
ZyBhIERNQS1CVUYgZnJvbSBhbiBvdXQtb2YtdHJlZSBQb3dlclZSIGRyaXZlcjogdGhlIGltcG9y
dCBmYWlscyB3aXRob3V0IHRoaXMgcGF0Y2ggYW5kIHN1Y2NlZWRzIHdpdGggaXQuDQoNCkFzIGZh
ciBhcyBJIGNhbiB0ZWxsLCBST0NtLXN1cHBvcnRlZCBrZXJuZWxzIGRvIG5vdCBidWlsZCB0aGlz
IGZhbGxiYWNrLCBzbyB0aGlzIGlzIG5vdCB1cmdlbnQuIElmIEtDTCByZXZpZXcgaXMgbm90IHRo
ZSByaWdodCBwbGFjZSBmb3IgaXQsIG9yIHRoZXNlIGtlcm5lbHMgYXJlIG91dCBvZiBzY29wZSwg
cGxlYXNlIGxldCBtZSBrbm93Lg0KDQpJIHVzZWQgYW4gTExNIHRvIGhlbHAgaW52ZXN0aWdhdGUg
dGhpcyBhbmQgdG8gZHJhZnQgdGhlIHBhdGNoIGFuZCB0aGlzIG5vdGUuIEkgcmV2aWV3ZWQgdGhl
IHJlc3VsdCBhbmQgdGVzdGVkIGl0IG15c2VsZiBvbiA1LjQuMTguDQoNClBSOiBodHRwczovL2dp
dGh1Yi5jb20vUk9DbS9hbWRncHUvcHVsbC8yMzENCg0KIGluY2x1ZGUva2NsL2tjbF9kcm1fcHJp
bWUuaCB8IDEyICsrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2tjbC9rY2xfZHJtX3ByaW1l
LmggYi9pbmNsdWRlL2tjbC9rY2xfZHJtX3ByaW1lLmggaW5kZXggYzU1ZThkMDVjMDMxLi41ZWZm
OTEwMmFhMTggMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2tjbC9rY2xfZHJtX3ByaW1lLmgNCisrKyBi
L2luY2x1ZGUva2NsL2tjbF9kcm1fcHJpbWUuaA0KQEAgLTEyLDcgKzEyLDE3IEBAIHN0YXRpYyBp
bmxpbmUNCiBpbnQgZHJtX3ByaW1lX3NnX3RvX2RtYV9hZGRyX2FycmF5KHN0cnVjdCBzZ190YWJs
ZSAqc2d0LCBkbWFfYWRkcl90ICphZGRycywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IG1heF9lbnRyaWVzKSAgew0KLSAgICAgICByZXR1cm4gZHJtX3ByaW1lX3NnX3Rv
X3BhZ2VfYWRkcl9hcnJheXMoc2d0LCBOVUxMLCBhZGRycywgbWF4X2VudHJpZXMpOw0KKyAgICAg
ICBzdHJ1Y3Qgc2dfZG1hX3BhZ2VfaXRlciBkbWFfaXRlcjsNCisgICAgICAgZG1hX2FkZHJfdCAq
YSA9IGFkZHJzOw0KKw0KKyAgICAgICBmb3JfZWFjaF9zZ19kbWFfcGFnZShzZ3QtPnNnbCwgJmRt
YV9pdGVyLCBzZ3QtPm5lbnRzLCAwKSB7DQorICAgICAgICAgICAgICAgaWYgKFdBUk5fT04oYSAt
IGFkZHJzID49IG1heF9lbnRyaWVzKSkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
MTsNCisNCisgICAgICAgICAgICAgICAqYSsrID0gc2dfcGFnZV9pdGVyX2RtYV9hZGRyZXNzKCZk
bWFfaXRlcik7DQorICAgICAgIH0NCisNCisgICAgICAgcmV0dXJuIDA7DQogfQ0KICNlbmRpZiAv
KiBIQVZFX0RSTV9QUklNRV9TR19UT19ETUFfQUREUl9BUlJBWSAqLyAgI2VuZGlmDQoNCmJhc2Ut
Y29tbWl0OiA4MjAyMTI3OTRkMTg0NzEwMjk4ZWZjZWNjZTQyYzAyMTViZmM5YzZhDQotLQ0KMi41
Ni4wDQoNCg0K
