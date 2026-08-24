Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A13C5DF97
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 01:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66F210E08D;
	Mon, 24 Aug 2026 01:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJgqLwUa";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8859410E08D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 01:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deYcj8hr37OqX/p3LOZyXj0RbAqL7s6HPc3IuxTqQhIwkOhyepvm2DxFUZp3pkIwOVoVoL6ByjX0LiYP60rVGl6Q4kaFsGr2Lnc8CsW/X6kWdCrVsDmwQYg48rR1xG5d+RUseB+hj43ExPCEpTN0nymHz+f/a9rqzk2du4I4iVUd1Vy3c96gupIHe+6t/F4+rlwyyN2sqShgUVKQx0zjzb7Nt13AcCjzBw+0ig3AVIsry1Qrn6BP0R/tXuQXAGFkXpzsIVrE9ADbyA+u+z0Mi/UiPZ5QDDw2+9aaIMGHl0c6M9zwZdZowGkdrATiR346DLEmrrsM8p6U/Ha3z7ARFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scweXlkpyRNuWHM1MCR52dZ2w5V8Lb0MgOj/LKdk6jM=;
 b=vAKFPm92dzzvWJvZQ6gzjrmE2x+oG/zU/eYX9p6WEa6yZvGXLdHqb8CSNdjvL6Hlb4I+18OHst7e+oHbSgKisDiwk6YZ2SvTn+qvDMBR1oS/yxBRU27McwEK31W0Br30am7WEkiI8YeoZOz04R2jeNTCqZhlbrvvvTUNSUbqkUdc20C2r0rk6KcxPTpvCiFCZWv4j3K0GG3SdXr+2G7w8y8zcTsxLd0O2VPZN8b4AVaA7AIuZ8njtVwQc7E2JlallxLumFDTtbuPNDxcxFPB9R6eNSmXTLrYmiv+IP4T1CFXWEjUTp+aIZLM65pz5/NlqWiffx0aby4hv58JfQ30Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scweXlkpyRNuWHM1MCR52dZ2w5V8Lb0MgOj/LKdk6jM=;
 b=rJgqLwUaq6y2hPHwvEtRiceQO8OrmCSB0QDexCAXedamIdy2+IxsycsTyaKt4Hq5oFFBDnX9eQSPGT8HPHOiabuo4JdoesvJaiNPavavusGMiHu5Hz/1PiVGQcIiNz9uNoKycsHE+cxUjGTaL/dsQQAeNX0flJS8TpPlBxcUM5A=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 01:46:47 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 01:46:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Topic: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Index: AQHdK52lu6cNuxwavE+gPq8QvqJlL7aljgqAgAKyOaCAAELfAIAD+isw
Date: Mon, 24 Aug 2026 01:46:46 +0000
Message-ID: <DS7PR12MB60052939CFB0BEE47F443194FBA02@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260814033302.406402-1-Prike.Liang@amd.com>
 <CADnq5_OMJpBgYYev6nBf7BJD-+WxPc5YS-42vHkxQH_udD5hCQ@mail.gmail.com>
 <DS7PR12MB60058101B79694CFFE687FC8FBA32@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_OOdb2z_Di1GMNFrJVe2ML7v829rQsd_UKiTqtLJp6tGQ@mail.gmail.com>
In-Reply-To: <CADnq5_OOdb2z_Di1GMNFrJVe2ML7v829rQsd_UKiTqtLJp6tGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T01:45:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB7642:EE_
x-ms-office365-filtering-correlation-id: beb68a5f-ec7b-4453-4b08-08df01818edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|4143699003|5023799004|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: JfJcyn0w8ZTCd1EmOMGdNRtpn0Q8mFJk9ul+AQoMJA1QhL7z5bCzCF/568ouIwFNoAIxy9YZnPiNFZ46P2qcpTwpmeq0nlbgDb/y1G5EO/nwzroTgC0tfVFFE+vOXXapg9vcqdfeF/CsbiLCZW0bfYmJVBS2GpxKMj1UunkRSR2N7ISxybZAk/BRWW5Fk3xYtETLgvZBRNeeHYK95IGrRxvVL7mSNtvkQYR5Kz6K2tmRfDjQrtRs0Su6N2wXSShCJ1IcCn6vQ0gQzi15YTP4iz9DADfDafNfHysb7AWchNr4b1qcsjNrUacIIdE06PhCRraW22WPZXmQybHRFiF49pee4EIlolIfwxbwYIFhsAHuxkdClTNzhBe1m5lFkDs7Oy0z25te31BkFKEa4+EebrdUOC3Ws5DhzCf3NUKFIEoQsz/Us6yRVYTZuydLgRwXG8CMbbNFHCXGcAjarb4sPS3lnR/t8gSWMC5sDe+JaMTuvwLf5zN2RUx1Z0fosna20K9E2wSqdp0FcRjRSzzNuwqkFNPj2x6FBl4zLYKCL4dMEEDhZ3Y9FXRKAVTMjZ6T4IWiRYXlPUmu88CnTDM5A1qTGznD+Cud5XynZlEGdwzsiKDSDDMi0wKWhUA4tmWp+VV3vS/N7L2kUGQQHLip9BJrMnC6yB1IAhbUXGXJqHkSNMwiiRb3QraQzh8ChP+/CM8yCVawEYoaD+4zQ+VIp6lKL0C2/BsvHT12kTxlXAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1xQmxaMHJ6STYvQTY0RyswbDFQcDJuYUxhL0ZDamRxSHFYY1ZyY2E4OUtG?=
 =?utf-8?B?blZlUi9jWTRITDEvU2hFRGhjUU05V1JVY3JDeW5BOG5mMDVka3BrVUQ0VDQ4?=
 =?utf-8?B?TVlLc05SSFlBbVNWSTBvdEgwdEk0ck1JVlFKVWNtcVE3bzJ4OEJHeUdIUnVE?=
 =?utf-8?B?ejF0YkVUQ2hxM0VZcWMzTk5EUUNnZlBUSlkyZlYzSHZaMUxEYUExbHdoclVF?=
 =?utf-8?B?NW1pTkYzR0pmbWtWQThERE5mOG15Sm9iNXA5V3ZxWURFaERJYkZIY0hiRDJl?=
 =?utf-8?B?ODFSQnRZZTAzWmZBRGg2d2V2ZmRMZE93dnJLbWt3YnBhTXJyOFhJSlhVTzRK?=
 =?utf-8?B?dFd1aERtcFRoZkt3RHFmaTcrRklaOWw4WnFzSlh0SWZXYWZISWs0ZDJ2Q1Nj?=
 =?utf-8?B?QWhDRDh1cVMySWxNY2RjeU9jYjA5UVhETXJvb0ZadGs2T3RDbFFvY2dGR0pD?=
 =?utf-8?B?SmwwbDQ1ZTh3OE94V1ptU2xaYlV0bi8yZnIyZlVXUkJNUGx1WkhtcHBBa1JF?=
 =?utf-8?B?a2Ywang0L3FsNEoyd3h4Vlc1ZTQxdnBOMS9RSmk4YjJMMityTFp3QjltbURX?=
 =?utf-8?B?NDU5cFJWRTkzbWs5V0ZWNC8yeFpWaUhIYU01em5GWEVFOHREQVhjOEg4YmRy?=
 =?utf-8?B?amVTclRhVWRIY3ZWSzQwUE1yU29pdXZ6b2EvcFZUWjBjSk1KSEFLYUx6eCtU?=
 =?utf-8?B?dzBJcDNxalZGUXRnYnNqVnlMeStVOVZHT2VVMTJzcHZkajRWeGpHbURkYWEy?=
 =?utf-8?B?ZnpPTG1Ka0paREdJS3oxWWhZcWJtakc0UlZrbExXU2o0UUJMcnlpWWxsQnF5?=
 =?utf-8?B?MUYvanRrV2MzdUdlSGhydXZSamlackZuRWNYZzNTUC9JTWI3ZjlONGdNSWRi?=
 =?utf-8?B?RVNSbm1PeFZWdnZiSXh6dXFJYVpiNHZ2TG1OdWNMVWIxZ0UzcllFNm1odG5G?=
 =?utf-8?B?SEVtV3BQQ1dNOGhCZzF5aEQ1N0FMMmJ4Y0tnODhPRzVOR29uSDBXOHdORllJ?=
 =?utf-8?B?OWZCdXhrSlhCNjlWWVRLK011Kys4ZGQ3TXpiTW1UZlA4U1BNcVBPbXpWRGpn?=
 =?utf-8?B?NE9MRm12SFNmQnl3NFpaNjEzMVFLZDB2bXQ4RWI1MG52LzRlS2JJZG9wdmtj?=
 =?utf-8?B?UU40NDVUTU96dEpiRmlMeE9RRkVKdFU5NkJ1NlY5SFZrM0hOWXNCM09MME5z?=
 =?utf-8?B?OUQ3N1l6Vy9WWDNSK0pzcG9OdmZxTUVzZ3pMRW5URXZpVXNmWDJZY3dYVlht?=
 =?utf-8?B?UTNQcE16VURhT2lYYSs4cjZha01oUWFGblMraG0rdWQxclN1UXQwcHJuUmZQ?=
 =?utf-8?B?TVhNdjY5L2d5dW8vSy93QzdyU0cyR09PMXVndGo3MUNwallKWm1PaUYrK0x2?=
 =?utf-8?B?OHVGUlVhc2Uybzkzdld3ckNVT2ZlM1o0bWJvOFJ4dHkvcG9zSkNlYXZwT3R0?=
 =?utf-8?B?RmFycXcramRlWnFkaHJDbzVvTkw0N1IzOGxaVC83RkJmRTJvMmFPc1JocUpV?=
 =?utf-8?B?b04rVlcxYVNvUFZ1SXBkQnU2dFZ6cEIwbTVnSTRNM0R6UGhsa2JzQWZwWmx3?=
 =?utf-8?B?QTVyenpFNkxocDlTdnlRcDQ4eER6cTh3MHZwT1J1all4QnpMKzdqV1NlZkM3?=
 =?utf-8?B?aWs4SjVUNk1zbTBtMVRIRUJtTTZQNjlrL3NQbzFUd1NJOEFwczBuUHlSQmRy?=
 =?utf-8?B?MVVCaFV3TCtkRVJvUXRjVEE3N1FVSjNNSHkxbVFXb2pnN0tUa0RLcjNtbFdi?=
 =?utf-8?B?cUhFUkxORnBZL2FqTysxWEx2NHZadFJZTnVwazF1WXJYOElHdzFpUEMrdDRo?=
 =?utf-8?B?eHFQS1UvNDFDRnpDa3VtOVpjUXhuY2MvU1BIZ3J5UWxxaS9RVkNKenpyVW9s?=
 =?utf-8?B?UnBWT3RGMldVUmJsNHF3VlIvZDlhYjkwRTJYMEtia1U2c2xrR2pCaUd2QUhW?=
 =?utf-8?B?TDY2VDNmL2tZWHRPdkdyODNMNWZTSjVkY2tzU00xMnVpdEdLaVpYMGZwT2RD?=
 =?utf-8?B?OWY1ZzREN0FwN08zdEczMDg4L1ZsdEVLSHJPRlhKRlI0MEM1bWNpemRoVFVn?=
 =?utf-8?B?S25SZGVLeFFZWW5sWHdkTklTQXBXOCt5a3B2SlB4NmtkZnNsOU05RHRuM3Zm?=
 =?utf-8?B?cGpEODMzbTNqeWxTV01JTGRJcnE3RmNmREJQRSs2YlBMYXoxb3lhV2p5eC8x?=
 =?utf-8?B?Mm9BOW4zVGtZVWZYWUxtY00wd3QyckYzUjNQSkNhNm1oM1Y5cEZzdTZPQ1Rz?=
 =?utf-8?B?VEtqckdHdXZMR3dUeTVCbGU2dWFwMENpYUNGQXZBV2NZa3REMGpYdjNlc3dn?=
 =?utf-8?Q?2LxqfErMoMOqaZCMWJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb68a5f-ec7b-4453-4b08-08df01818edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 01:46:46.9091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLsCQ8MV2pErbBuDpMIxTKT2sfCwgQlRsR8oweITexBtaH+9o4hbin4NMq2OUDuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2IDk6MDIgUE0NCj4gVG86IExpYW5nLCBQ
cmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1L3VzZXJxOiBmaXggbG9jayBtaXNzaW5nIGZvciB1
c2VycSBmZW5jZSBlcnJvcg0KPiBzZXQNCj4NCj4gT24gRnJpLCBBdWcgMjEsIDIwMjYgYXQgNTow
OeKAr0FNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAx
OSwgMjAyNiAxMTo1MiBQTQ0KPiA+ID4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1k
LmNvbT4NCj4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuDQo+ID4gPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdS91c2VycTogZml4IGxvY2sgbWlzc2luZyBmb3IgdXNl
cnENCj4gPiA+IGZlbmNlIGVycm9yIHNldA0KPiA+ID4NCj4gPiA+IE9uIFRodSwgQXVnIDEzLCAy
MDI2IGF0IDExOjUw4oCvUE0gUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyKCkgYW5kDQo+ID4g
PiA+IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZGVzdHJveSgpDQo+ID4gPiA+IGRvbid0IGFj
cXVpcmUgdGhlIGRtYV9mZW5jZSBzcGlubG9jaywgc28gbG9ja2luZyB0aGUgZG1hX2ZlbmNlDQo+
ID4gPiA+IGxvY2sgYmVmb3JlIHRlc3QgdGhlIHNpZ25hbGVkIHN0YXRlIGFuZCBzZXQgZXJyb3Ig
c3RhdGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgICB8IDIwICsrKysrKysrKysrKy0tLS0tLS0NCj4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+ID4gPiBpbmRleCAxOWFmMWFkYzI5MjEuLjA5ZTIw
NzljZmRiZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiA+ID4gQEAgLTE5MSwxNCArMTkxLDE1IEBA
IHZvaWQNCj4gPiA+ID4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9kZXN0cm95KHN0cnVjdCBr
cmVmDQo+ID4gPiAqcmVmKQ0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKmY7DQo+
ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmZlbmNlX2Rydi0+ZmVu
Y2VfbGlzdF9sb2NrLCBmbGFncyk7DQo+ID4gPiA+ICsgICAgICAgbG9ja2RlcF9hc3NlcnRfaGVs
ZCgmZmVuY2VfZHJ2LT5mZW5jZV9saXN0X2xvY2spOw0KPiA+ID4gPiAgICAgICAgIGxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZShmZW5jZSwgdG1wLCAmZmVuY2VfZHJ2LT5mZW5jZXMsIGxpbmspIHsN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgIGYgPSAmZmVuY2UtPmJhc2U7DQo+ID4gPiA+IC0NCj4g
PiA+ID4gLSAgICAgICAgICAgICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGYpKSB7DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICBzcGluX2xvY2soZG1hX2ZlbmNlX3NwaW5sb2NrKGYpKTsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tl
ZChmKSkgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2V0X2Vy
cm9yKGYsIC1FQ0FOQ0VMRUQpOw0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBkbWFf
ZmVuY2Vfc2lnbmFsKGYpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVu
Y2Vfc2lnbmFsX2xvY2tlZChmKTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4g
LQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soZG1hX2ZlbmNlX3NwaW5sb2Nr
KGYpKTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGxpc3RfZGVsKCZmZW5jZS0+bGluayk7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGYpOw0KPiA+ID4gPiAgICAgICAg
IH0NCj4gPiA+ID4gQEAgLTQyMywxMSArNDI0LDE2IEBAIGFtZGdwdV91c2VycV9mZW5jZV9kcml2
ZXJfc2V0X2Vycm9yKHN0cnVjdA0KPiA+ID4gYW1kZ3B1X3VzZXJxX2ZlbmNlICpmZW5jZSwNCj4g
PiA+ID4gICAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAg
ICAgIHNwaW5fbG9ja19pcnFzYXZlKCZmZW5jZV9kcnYtPmZlbmNlX2xpc3RfbG9jaywgZmxhZ3Mp
Ow0KPiA+ID4gPiAtDQo+ID4gPiA+ICsgICAgICAgbG9ja2RlcF9hc3NlcnRfaGVsZCgmZmVuY2Vf
ZHJ2LT5mZW5jZV9saXN0X2xvY2spOw0KPiA+ID4gPiAgICAgICAgIGYgPSByY3VfZGVyZWZlcmVu
Y2VfcHJvdGVjdGVkKCZmZW5jZS0+YmFzZSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBsb2NrZGVwX2lzX2hlbGQoJmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9s
b2NrKSk7DQo+ID4gPiA+IC0gICAgICAgaWYgKGYgJiYgIWRtYV9mZW5jZV9pc19zaWduYWxlZF9s
b2NrZWQoZikpDQo+ID4gPiA+IC0gICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2V0X2Vycm9yKGYs
IGVycm9yKTsNCj4gPiA+ID4gKyAgICAgICBpZiAoZikgew0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgLyogbmVzdCBmLT5sb2NrIGluc2lkZSBmZW5jZV9saXN0X2xvY2sgKi8NCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHNwaW5fbG9jayhkbWFfZmVuY2Vfc3BpbmxvY2soZikpOw0KPiA+ID4NCj4g
PiA+IFdoeSBkbyB3ZSBuZWVkIHRvIHRha2UgdGhlIGZlbmNlIHNwaW5sb2NrIGZvciB1c2VycXMs
IGJ1dCBub3QgZm9yIGtlcm5lbA0KPiBxdWV1ZXM/DQo+ID4gPiBTZWUgYW1kZ3B1X2ZlbmNlLmMN
Cj4gPg0KPiA+IEZvciB0aGUga2VybmVsIHF1ZXVlIHJpbmcgZmVuY2UsIHdlIGFsc28gbmVlZCB0
byBob2xkIHRoZSBkbWFfZmVuY2UgbG9jayB3aGVuDQo+IGNhbGxpbmcgZG1hX2ZlbmNlX2lzX3Np
Z25hbGVkX2xvY2tlZCgpLiBUaGUgcmVhc29uIHRoYXQgZG9lcyBub3QgYXNzZXJ0IHRoZSBsb2Nr
DQo+IG1pc3NpbmcgZm9yIHRoZSBrZXJuZWwgcmluZyBmZW5jZSBpcyB0aGUgLnNpZ25hbGVkKCkg
Y2FsbGJhY2sgaXMgbm90IGltcGxlbWVudGVkLCBzbw0KPiBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tl
ZCgpIHdpbGwgbmV2ZXIgYmUgaW52b2tlZC4NCj4gPg0KPg0KPiBTb3VuZHMgbGlrZSB3ZSBuZWVk
IHRvIGZpeCB1cCB0aGUga2VybmVsIHF1ZXVlIGZlbmNlcyBhcyB3ZWxsLg0KPg0KPiBBY2tlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpZZWFoLCBJIHdp
bGwgaGFuZGxlIHRoZSBrZXJuZWwgcXVldWUgZmVuY2VzIGxvY2sgc2VwYXJhdGVseS4NCg0KPg0K
PiA+IFRoYW5rcywNCj4gPiBQcmlrZQ0KPiA+DQo+ID4gPiBBbGV4DQo+ID4gPg0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWRfbG9ja2VkKGYpKQ0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2V0X2Vycm9yKGYsIGVycm9y
KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKGRtYV9mZW5jZV9zcGlubG9j
ayhmKSk7DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiAgICAgICAgIHNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9sb2NrLA0KPiA+ID4gPiBmbGFncyk7ICB9
DQo+ID4gPiA+DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzQuMQ0KPiA+ID4gPg0K
