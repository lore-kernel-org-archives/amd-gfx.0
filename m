Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAA606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XUfTx+tT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78C510E1AE;
	Mon, 26 Oct 2026 03:15:03 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593B110E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q266SUPPyfBc01OXQQ52dFTmVJ145Y0Q7GFQs6BKXZnco9VvW8RTCyR1+tKH2RHvXgSENmBPYvmRNRjmT0MujoS8UB9ed11EKhlVgSJD5nk49hCKBPxXATFkR+A0gsn1rxlC+q/AFBkMU7taCPJfHUVJNKf4/0LX01tZ1AL/4BYQTzPaUAfIRI9js+R7aLLbjIOJk+odiUJ3JM/0+V6PFUkRHafRccPP0Hq0oA9SKWbuMaCLkQphDx3mPpjqwU58iJVJNaOB1KGdTvcukGrNAgJhn0W4w1DcvAfYq3nPuwx/B/78O5DQQWN9vjcgVpTrizg0O3AGfmysQyQLnKbQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D5ruzHE5Bqw/6IOtoncOrig1VdV9vpZK+Uzc9O3WF0=;
 b=KKzWP1kKv8QlFDT1nxeJT4vZcSXyngnSJCOrNszUjsUA4M/bPubDVPxCzjxMsC3VulBzcUEyxXdDiSBvimROwyz2hJdJ24QrC8t3x8HowmzQVS2osoYWaUGj6GUo6lLBBOME2Y9SyEFjuIApsBui9YHF/jebUujnOgofz0PekjFNLu4v5VGFR6N8PjKGH3hGM25pOQg1Aa3LcpXWJwIB0W76aYq2zG8IaiEMRSAjD1k+uQgpc+sCEFL3PkQ/mYRsGQZ7lXGXNtOudVrLt0YO78p8hkT8TbIiqUdcB6PtcbmFH4T4TmvBmA/5fGadNmK5fAP02A2qzNwLA9Dd+luoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D5ruzHE5Bqw/6IOtoncOrig1VdV9vpZK+Uzc9O3WF0=;
 b=XUfTx+tTAiNcTy42qdDl/Bh0fZstOKiYULZv5Oj8CMj/idzg885pZpBWGGeDqMkCWfWap9+dKrSAO2JKFObeyjIYzObN+iteJEcXP/oZW5tNpXIYHnVtZw1TKOJpRT4MAMOO/IO1hv2BIwdoFc0UKuiyrY+Uo/TNQiTDnWVFK0o=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:13:59 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 03:13:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Thread-Topic: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Thread-Index: AQHdYslYDZPn0I16yECEgz4TK/lzubcK2DwAgARPazA=
Date: Mon, 26 Oct 2026 03:13:53 +0000
Message-ID: <PH7PR12MB60006DA49574AC938D7E2D1EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-2-Prike.Liang@amd.com>
 <f07784fd-26e6-44fb-8558-da0638ceb11a@amd.com>
In-Reply-To: <f07784fd-26e6-44fb-8558-da0638ceb11a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-26T03:03:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|BY5PR12MB4242:EE_
x-ms-office365-filtering-correlation-id: 52e0b462-bfeb-4d95-4ede-08df330f2a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: tpSoO5zJGnAYbxaU/vuoFe7a7LcW3invYg14dyToUrtfXD/gRqhhWNMo50R5wceCpe4gy/IZyLJH0CBktw2rOBKj2PL2dbK9dEzJZVFK6hbNOagYP5MEDEXwGTyY/r4IoQ5Z1/4q62lnNNe5/pF1MsMDz6nIY4OJe+lp+tDWNNSLjAJheeg+JN2tAc+GlvYthKrh0DuoP/LByyTtVV1BPC7Nfn2R/xWOkinh8MFcne+qPMW3bXvOfQUNUB0eAkf6RQqJT4WSoRGjShz0S9wUKwr8mIC6gWR9P9y2JGmkTWTSHIZ4J7bTcjKQ6rXkAOcFVCvAvmx+2zp5v2awmAQIyT7U2OUF3gQHip9wGIsFOXvuHYnv+ZQo0QeAOf3QE4zjvwAF46P/I6LFxxAwnPEvLLSBqhMhxKd6Mv2KJpNnbujli4l02rXQVV+Elil3yCe3YAv0kI0dRHKxbEAr8H88OrmydRKB6SN70R4iWZ0m2EHlt59bC1Ba5asdSzL3jpUn1C1zLDU5nO5fsXuNEkQWiZp3B3JWPpvDes2bTkwkdUaKAayVpN7BvNq6Tv1Pehxs4X5vBxoCYXTM430NMnoBepROpe8amIQh2vjfyCHMo09LalxizTsB4akIiiIUrAzS0OGXMJ+qG5SsEZCWiT+/mEBhW8ap/TglI/GDK96mbgPF7EbsPi+JNQEpRmBh0NWX0Ctx54sbWUWcP/jA3e5+Pmdt48XV/Rie6k2cjgcvHGw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9taDMyT1REUU01cnhxeVV6Z0l1ZVc1Mk5TWXBTdU9EZktjRW1WaXNRYlRR?=
 =?utf-8?B?Um0reXFHbFo3U2VLOWdKT0VIeG8yODUwZzVjL291YTZyMENwR3R0Wnc1c09D?=
 =?utf-8?B?eElJaHVwYytiVWp1bkcydlZxZnovNUtvSm4xRmtPM3NSUTB5b2YrOHg5cUNS?=
 =?utf-8?B?ZTNGVzNwZFZSY1VZbmsrN08vb2pseUhMRjBwTkM2L0NLUnRFQ0EvdlNNT1dT?=
 =?utf-8?B?bWhDZzJJazRtNjV3czBxMGUzbStuS29lYjRvbktrU1dkenB1UHJJK3Yzb2xk?=
 =?utf-8?B?YW5ISUlQUU5PazJaRXBlTzM5Q1drTTBNVzVyK2xjR3VXUU9XN0REemNqcFoz?=
 =?utf-8?B?L3lxZ1k0Y0V5blRmdCtiN1ZDdkRDbW4xWGd2MjVVVDVtQ29Qem53TjdiZVdm?=
 =?utf-8?B?S1VvaVd3SUdJaWJEZkw5NUtMSkxsTEVBNjljKzBNTnZMMlRGT3RncGdQQTht?=
 =?utf-8?B?LzlUN0NEY1BySnFtZlplWFA4UGJTZnpBWEVUVVkxRFhDaUpyb1dzOVBxQmNE?=
 =?utf-8?B?cUlzdWc2Z0Uwa3pLdVJYaDcrZDA2UkRoaU5QeWRUQm9EMGVjOGRZN0tPZUor?=
 =?utf-8?B?bWtzdEpiM0w3MHNsQWQ5QStFL2tVNWhWZ1lwaHVjeGNkWkw3NEc5ckkwSlVq?=
 =?utf-8?B?T3lPWSt3c2lnRnFYNUtIUlF1cmZEUnBFVEpsQ0dsN3hiQXZDRkl1K2pXU29N?=
 =?utf-8?B?ZGJtMzg0bW9HWlhuZGd0aWQ4Qnk0NkhET09YYkEyOVdiQmVVN0h4RjAwWVBK?=
 =?utf-8?B?aHVNc0lPcWtoSFc2aGJMSGkyRkZMR25meGtRUWppVlVPV2hCeUpTbmlhcndy?=
 =?utf-8?B?Ykl2QzZjdTNjRjBscWF3MVUvd2MzbjU4Rm4xL2NzaXR1ZUtpbkRTdFpybEY4?=
 =?utf-8?B?Skt0c3p5dnZ0Rk5ZN0xEK29id0xOcDBDNkU4ME5wK0lON0VyRGRWUnRzTkZB?=
 =?utf-8?B?dEs2UGhVenZ0NEpsRUJXUFVRSzJaUklGSDhUazg2dmdWOGpRaDFmdGVXUlU5?=
 =?utf-8?B?MGI4Sk04b0FJNHphUDZOd1AwekVIckpaMmZkY2RzNGpEdVJSRVU2dFhXQTFr?=
 =?utf-8?B?andaejVxdmEyRU9vMUJ6SjhzNkFZQjRHc2xMV0RlSmtmTjJidE1GTzQwRDRy?=
 =?utf-8?B?V1lEYjNIV3NDVXdiY1V1RmQ1cnRnS1l3WVVnVlFMMS92cytMMEJvVkhOWnF5?=
 =?utf-8?B?QXNOOTZqMzF5R3pNUWFNNklRWkdwOW9Va1hJNlFUWlJmWHFTeTFVSjFwSjI1?=
 =?utf-8?B?enJVNG5zVzVIY0tLK1RNZnZSU3g3QWxaUEZZVzNHR2ZlKzV3eXhNcFY3ZWJq?=
 =?utf-8?B?TE5EVGJ3Q1FoaUxnY01USG83YnVkaW5sZUFub08xb0NIV2tTdG1jZ015b3VG?=
 =?utf-8?B?RHN0R21jSk5NcGRVWER2V3lrNk5TcnhrV2tnV3JLN0hqakhOQlR5VEx5aW9q?=
 =?utf-8?B?MW9WaWpMMGpKcWFRUzVLdVdNWFl2NEN2TmRpdjJ4VjhQbE5NalNvdFlsdDl2?=
 =?utf-8?B?UlI5WjVSTC9kc3Z1L3d2amJyOE42ZmVZc09aTDJnZXFkdnhRanlqVmhxUzNt?=
 =?utf-8?B?Tk15b211T2JSZnl4ZjJUWXhUbURlcFp6Vnl4SmpYZnQ1OXIwTkhrMUVsZkZS?=
 =?utf-8?B?QS9ZZXJXR1NTUzdsa2hFZllmVS9WaEFZdVFUQ0JSUmNHaEoydFhDOUhhTGNn?=
 =?utf-8?B?NkFiK3FPK3ptNzY4UnI5MFRIdVFCbGxNRlRpNW50MGEzSVlWdzM2d0NscUJm?=
 =?utf-8?B?MzM4NzNReHpsdjNRQlpVbEgzT0xLdzNrV0RSNXhPNUJwa0s3bEdPTVlDckJB?=
 =?utf-8?B?MlA4SmdWWDE1ZlEwY3pSMnNGYjVUVXBmNkxyem5maHk0NTVvMkZKOEtESTVQ?=
 =?utf-8?B?bGdwWlZPYXNsWGhmNzVERE5tcmdVODdyczY5TDVCd2NsT1JBRGl2T1VYZm5R?=
 =?utf-8?B?eDc5cHZFbEgybHJLSFRTK2llZUhTVG9tQXBhVXRXZXJwdHVac0NFb1BTRHdv?=
 =?utf-8?B?MXpyK0Y3cFJMdzBaMUlhWTNIb2prRDhTV0UvcEhDZkx1eTFJZEp2QmVyb1k4?=
 =?utf-8?B?RVhNeUxjU0VmT1ZoVk0wb25ZcHVxeGROWFhoNDF4QVBxUGlQMlM3M0JTR1h6?=
 =?utf-8?B?RUhZNFpVMCsxZUZZNjVVOGlWdDBlZjZzMkhXNDJheTRFekJidkRQam5kRVZm?=
 =?utf-8?B?UndJUkZDbTYra2lvbC9UOWEwVkNFSVBSQTU4NjV1TzNkam5pMmZXNkZ3a0Zu?=
 =?utf-8?B?UXdJZUhsSnlEejFJWVlEVUFCeitncStpWVhlV1l3UWRkMjB4RnVJbk43ZENU?=
 =?utf-8?Q?CpR2q35LnA9E4tveTV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e0b462-bfeb-4d95-4ede-08df330f2a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 03:13:53.6984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf88mxelltYwAhmbUrp8PS/JsovsAthQRbo5WTxMgEBFDsvXSD6P4BSpWTOldQNB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4g
U2VudDogRnJpZGF5LCBPY3RvYmVyIDIzLCAyMDI2IDU6MTQgUE0NCj4gVG86IExpYW5nLCBQcmlr
ZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUHJvc3lhaywgVml0
YWx5IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvOF0g
ZHJtL2FtZGdwdTogZmluaXNoIEdQVSByZWNvdmVyeSBjYWxsYmFja3MgYmVmb3JlDQo+IHJlc3Rh
cnRpbmcgc2NoZWR1bGVycw0KPg0KPg0KPg0KPiBPbiAyMy1PY3QtMjYgMjowNCBQTSwgUHJpa2Ug
TGlhbmcgd3JvdGU6DQo+ID4gUnVuIEdQVSBwb3N0LXJlc2V0IGNhbGxiYWNrcywgaW5jbHVkaW5n
IEtGRCBhbmQgZGlzcGxheS1hdWRpbyByZXN1bWUsDQo+ID4gYmVmb3JlIHJlc3RhcnRpbmcgRFJN
IHNjaGVkdWxlciB3b3JrcXVldWVzLiBJUCBoYXJkd2FyZSBpbml0aWFsaXphdGlvbg0KPiA+IGFs
cmVhZHkgaGFwcGVucyBpbnNpZGUgQVNJQyByZWNvdmVyeTsgdGhpcyBjaGFuZ2Ugb3JkZXJzIHRo
ZSByZW1haW5pbmcNCj4gPiBjYWxsYmFja3MgYmVmb3JlIG5ldyBzY2hlZHVsZXIgc3VibWlzc2lv
bnMuIFByZXNlcnZlIHRoZQ0KPiA+IGVtZXJnZW5jeS1zdG9wIGFuZCBndWl0eSBqb2IgY29tcGxl
dGl0aW9uIHBhdGgncyBjYWxsYmFja3Mgd2l0aG91dA0KPiA+IHN0YXJ0aW5nIHNjaGVkdWxlcnMs
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDEzICsrKysrKystLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCA0MDZjNWYyZmJlZTEuLjIwZjAyZGQx
NGM0MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gPiBAQCAtNTgxNiw4ICs1ODE2LDEwIEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9y
ZWNvdmVyKHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4NCj4gPiAgICAgYW1k
Z3B1X2RldmljZV9oYWx0X2FjdGl2aXRpZXMoYWRldiwgam9iLCByZXNldF9jb250ZXh0LCAmZGV2
aWNlX2xpc3QsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhpdmUsIG5l
ZWRfZW1lcmdlbmN5X3Jlc3RhcnQpOw0KPiA+IC0gICBpZiAobmVlZF9lbWVyZ2VuY3lfcmVzdGFy
dCkNCj4gPiAtICAgICAgICAgICBnb3RvIHNraXBfc2NoZWRfcmVzdW1lOw0KPiA+ICsgICBpZiAo
bmVlZF9lbWVyZ2VuY3lfcmVzdGFydCkgew0KPiA+ICsgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vf
Z3B1X3Jlc3VtZShhZGV2LCAmZGV2aWNlX2xpc3QsDQo+IG5lZWRfZW1lcmdlbmN5X3Jlc3RhcnQp
Ow0KPiA+ICsgICAgICAgICAgIGdvdG8gcmVzZXRfdW5sb2NrOw0KPiA+ICsgICB9DQo+DQo+IERv
ZXMgdGhpcyByZW9yZGVyaW5nIGluZGlyZWN0bHkgYWZmZWN0IGFueSB0dG0gbWVtb3J5IG1hbmFn
ZW1lbnQgZnVuY3MNCj4gKHNkbWEpIHRoYXQgbWF5IGJlIHJlcXVpcmVkIGR1cmluZyBLRkQgcmVz
dW1lIHNlcXVlbmNlPw0KDQphbWRncHVfZGV2aWNlX2dwdV9yZXN1bWUoKSBkb2Vzbid0IHN1Ym1p
dCBvciB3YWl0IGZvciBhbnkgVFRNIG9yIG90aGVyIERSTQ0Kc2NoZWR1bGVyIGpvYi4gVGhpcyBj
aGFuZ2Uga2VlcHMgdGhlIERSTSBzY2hlZHVsZXJzIHN0b3BwZWQgdW50aWwgYWxsIHRoZQ0KaGFy
ZHdhcmUgaGFzIGZ1bGx5IHJlc3VtZWQsIHNpbmNlIGpvYnMgcnVubmluZyBlYXJsaWVyIGNvdWxk
IGFjY2Vzcw0KaGFyZHdhcmUgYmxvY2tzIHRoYXQgYXJlbid0IHJlYWR5IHlldCBhbmQgZmF1bHQu
DQoNClRoYW5rcywNClByaWtlDQoNCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gICAgIC8qDQo+
ID4gICAgICAqIE11c3QgY2hlY2sgZ3VpbHR5IHNpZ25hbCBoZXJlIHNpbmNlIGFmdGVyIHRoaXMg
cG9pbnQgYWxsIG9sZA0KPiA+ICAgICAgKiBIVyBmZW5jZXMgYXJlIGZvcmNlIHNpZ25hbGVkLg0K
PiA+IEBAIC01ODI3LDE4ICs1ODI5LDE3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVy
KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICBpZiAoam9iICYmIChkbWFf
ZmVuY2VfZ2V0X3N0YXR1cygmam9iLT5od19mZW5jZS0+YmFzZSkgPiAwKSkgew0KPiA+ICAgICAg
ICAgICAgIGpvYl9zaWduYWxlZCA9IHRydWU7DQo+ID4gICAgICAgICAgICAgZGV2X2luZm8oYWRl
di0+ZGV2LCAiR3VpbHR5IGpvYiBhbHJlYWR5IHNpZ25hbGVkLCBza2lwcGluZyBIVw0KPiByZXNl
dCIpOw0KPiA+IC0gICAgICAgICAgIGdvdG8gc2tpcF9od19yZXNldDsNCj4gPiArICAgICAgICAg
ICBnb3RvIHBvc3RfcmVzdW1lOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgciA9IGFtZGdwdV9k
ZXZpY2VfYXNpY19yZXNldChhZGV2LCAmZGV2aWNlX2xpc3QsIHJlc2V0X2NvbnRleHQpOw0KPiA+
ICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICBnb3RvIHJlc2V0X3VubG9jazsNCj4gPiAtc2tp
cF9od19yZXNldDoNCj4gPiArcG9zdF9yZXN1bWU6DQo+ID4gKyAgIGFtZGdwdV9kZXZpY2VfZ3B1
X3Jlc3VtZShhZGV2LCAmZGV2aWNlX2xpc3QsDQo+ID4gK25lZWRfZW1lcmdlbmN5X3Jlc3RhcnQp
Ow0KPiA+ICAgICByID0gYW1kZ3B1X2RldmljZV9zY2hlZF9yZXN1bWUoJmRldmljZV9saXN0LCBy
ZXNldF9jb250ZXh0LA0KPiBqb2Jfc2lnbmFsZWQpOw0KPiA+ICAgICBpZiAocikNCj4gPiAgICAg
ICAgICAgICBnb3RvIHJlc2V0X3VubG9jazsNCj4gPiAtc2tpcF9zY2hlZF9yZXN1bWU6DQo+ID4g
LSAgIGFtZGdwdV9kZXZpY2VfZ3B1X3Jlc3VtZShhZGV2LCAmZGV2aWNlX2xpc3QsIG5lZWRfZW1l
cmdlbmN5X3Jlc3RhcnQpOw0KPiA+ICAgcmVzZXRfdW5sb2NrOg0KPiA+ICAgICBhbWRncHVfZGV2
aWNlX3JlY292ZXJ5X3B1dF9yZXNldF9sb2NrKGFkZXYsICZkZXZpY2VfbGlzdCk7DQo+ID4gICAg
IGFtZGdwdV9yYXNfcG9zdF9yZXNldChhZGV2LCAmZGV2aWNlX2xpc3QpOw0KDQo=
