Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D6CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C84B10E16D;
	Thu, 15 Oct 2026 06:38:44 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181B910E16D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 06:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=howWhcKU9mAyeqLNgS7hMpQD/QCDle7OcywHRaAY4hdEUEPpZVEYlXPt4xvlTAVVtqAIMzIG7e17O9tIh0jSjhUEzTThrI24ansjvZknWMziH+IRI3nxu+z/2mU9hKFPBmHcwWQicuMhkekXG00f0LQgVeKHjNCL9PABmoJI1jQ5UsXgr/DIV5Yozxo6+VUOMoVvr3MHjObZetBPbfSll7fKgKd1Iy4fnYNjsfhwCc1LIlKXmwi4WgGV9faldOxjRqi10xMPtUdczQr/UniAlTnCItGbQPst99OfPHlgKYpnSDq9Zq9EMII2/aTxfA7hIxpVP8aj2yWcElAVj0iVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDMOe/bO4lEXv4gG5BOglQXhcd/NVuVtbZQBkwvJl9A=;
 b=D7Lnr96W0c1AiZ7eeEzK3u1JFbp61RPc3Bq/9ung7XpFFq8Bb3XPiLRYnNGLMZlH3/G6Ztj+8U61GKjYlx0/6gHoqbbCB2pxA92XKcnK7d9rFaWN2Bs/rEexOHFeAV5q8V+3Pb8Y8NaspmJf4i8aMpmcoDbeZUi2SmksdzdmOn0dHyyIjPMNx0BBtLJAUecSosoDDKUVlKMf3UTAtgfKw/fvurW5fzBnAQM+bSMH5Bvrii1+G6TZbv5vDLTnIN3PLcB3WadLLaQ93QqhyGWAvca81prKJX3OOkHsdA1kh9/tPlwFCg8z7h6DOT7ai6ZiyZ17s1vdztO8y7lmKCX9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDMOe/bO4lEXv4gG5BOglQXhcd/NVuVtbZQBkwvJl9A=;
 b=fG9YjM7UWythTu5mKyWvPQskvlF1sIcrB8LVxkUEPM9oGE2SFlNwTYqU9vpLQPG/e/XEAJtkB6mQHyo5cbx0qNQ/6Bh/1CAkNv/t5959ykncHekWrf2o6pCOR60JGmmRl8B1bqpO/ZyIklGsGchYF9NZWkWnhjgGWDixPnJg3YU=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 06:38:32 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 06:38:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 7/9] drm/amdgpu/userq: take reset_domain->sem before
 userq_mutex in destroy
Thread-Topic: [PATCH 7/9] drm/amdgpu/userq: take reset_domain->sem before
 userq_mutex in destroy
Thread-Index: AQHdWuxq7d9vNo7bNE+Ek4cnptx4jbb7NTqAgALm57A=
Date: Thu, 15 Oct 2026 06:38:32 +0000
Message-ID: <PH7PR12MB60009AC215A10A213733F7F2FB9C2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-7-Prike.Liang@amd.com>
 <5d41fc4b-ca95-4cb2-b0a4-649614548882@amd.com>
In-Reply-To: <5d41fc4b-ca95-4cb2-b0a4-649614548882@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T05:49:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: a61afe7c-d974-4c04-030f-08df2a86ee48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|4143699003|11063799006|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: YIMVnl+0GOUW4fvz8TeSvlospVQMIeN7gea7YYHAkMJRXSYUTyZPznsZVkYPbfq+NlES3jn4obbnG7pVGG7/Ai5wZXi24w0MF9gdbO/lkCf1+Y5KJZsj+P+VxCz16SZdvknRITN1qUDkGYPFhAtLNkduQmSdwWnmJeA1sHyYL3trfTrd+q10eAGNOzJ2knD/g+gwX2OaubSjrWf2pRJ6fxPsePpBPCjF91z3Ckl7dTjit0/Qo+GqRxu1P5F4+fSzIJ1qPZ30HUmEzKvNDK9mywqEB3nNfHiWAboSak8ov44jFxgi43OPm2/fLK/iwsSCG/vcN7eFE6DC27MAkgRijw+ir6yziUmyPQklSSH9Hh+zsRUS3lTilx1RDKwZ7V0sBAdmk3S5KQDB+ToPCtbt5uUle7mhSW5Tol3tb2NM+3ggh/CnauAcAdHFKqOQVJ8ktwJdQfvrqIAtSQ2VgCd5jckPgna90wsbzTp3LcgA72kXlBd3DaOY4EzFeqvpV/nxEG3vE7aBYwC9cmI2tIgUPmM2Xo19bkAVbRpdXZS+QdQV3j6ZZjuy5uRNeV11mwQIRdWCjBidjXdaYT40Czar0lDIBVsjVhVQZGHmyqnLpALQXykuMOpAWK+DLOrf0fbO86iqqzb26yzMPTfbkp8Ub6THMfl6ybNDRHKbliourK82LHgMFlXWxyXoeZCUVGTcBVruhQ2vpY//gKJIx3TrLzQ85iWvUpDA2nafLKeZjj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG9kcE9ndkd1bW1DY0Y5YUticlFucnMxOXFzaGdBRlZrV1RnUk1vbjJ1bDBN?=
 =?utf-8?B?M3laajB3aTY1M1h3b3QvWUJSYVc5aFBScFMzbU0xc0hWRzdMV1Uvd1VCU0V3?=
 =?utf-8?B?YytEaTY1cGZyY1lCaHo1S1RSc3M3WHpteGpaN3lFNmxGWHB0dFNPUklONnNh?=
 =?utf-8?B?RkR0eXdoQmEwMlRvSlJRZnlnWkk3eFVWVVBZSDM2TzJGbzhKdnJiTlJ6STI2?=
 =?utf-8?B?aEpiOXZKMVVaN243a1B6K2U4SDNuN1FJd0pHU0RLQjhwLzhSMTBkVnV0THpp?=
 =?utf-8?B?QjVzZTZXNWcrby9wejFJWHpqVWFRWTJBTWczMkpPanZ6UUdXODhoN2gwZUp6?=
 =?utf-8?B?SnFpOFk0bjVBTUFOdzI4c3RKWjh4bmI5aUJRSDdURHk4LzZZcm1KT0J1UzFu?=
 =?utf-8?B?V3hkbUVOeElaL3VMa3EzYXFMcFlySnFGT0d4d1Z6a2ovRkNRV1ZGZ3dLUGl4?=
 =?utf-8?B?eU1ZcG0wQjNFKzRHWi9XaEk0K2RWdEtnY1FDV2I5RnhXbERaZWpiSnhZc2hl?=
 =?utf-8?B?eW5xMjJjOUpUanhpZDBNM1lWd0lzbUVQYytPcm5pR1dIOXNaZ1ZkZzAvRmNT?=
 =?utf-8?B?d2txWUdaZCthZC9CZGxpVForQ3hJcFE1bGdMa01OVVp4SnpCeHRwMzc0cUVE?=
 =?utf-8?B?R2R3S09PbWI3QTU4eU11aVQ5RWhUcG9oeTZnbEdrblJLSFF3Z3lkWlpaZUV5?=
 =?utf-8?B?NmNVTElnbzBRcE93SDM3cExnMW5TdnBHdkY2bUJwRzZuV0tiSWNPVmp5S3RQ?=
 =?utf-8?B?K3hCanZMWGh6SXpmTWViME9NMmtodTFsUllEMHlLdDJPa3l6T3JsNFU0eENO?=
 =?utf-8?B?NVZBZTVQa2tQR25kM2pEdUEvWmxIQlhZR1hJa0ZYSnZzdWwyUzM4NDU1RnQ5?=
 =?utf-8?B?em9SZzM3Nk5Ua2pPZ3ozZUNOQnNBbzhDRVNVQVZoM3Nzcng0OTJZbGpyN3ov?=
 =?utf-8?B?VGdMK2tXOVRWbDJtd1pod2twdEFJTWtvQ2Y1dUpyeUpZYjlXRGVWazN6M04x?=
 =?utf-8?B?WWY2UHpOOWtPVlVscWdtQktnVW1WKzRVaExiOGFzOUtDUTdESW5TZDFLVFpw?=
 =?utf-8?B?ZEI2YzVmVlZZMDRCbXExYnE3OW5rc3VvZC9DNU1YSXAvM1QvVlVkREZwWFd4?=
 =?utf-8?B?c09BWWZ2YWp1bTN1QThhSTBxZDM4NmllV2Z4ZUlPSnpxS0FzT01manN2Tzdv?=
 =?utf-8?B?YW1ORUI0d3hEQWNZYXVDSk9kR09PcFVUcHNZSCtoQ1FJL0hEaFl4SlpDRGVW?=
 =?utf-8?B?aDlrR0szeVA2RmV5Vk5SWEc3QjlrM0hBT2tzTElSQ1J5OGZaa1FiRGRYRURN?=
 =?utf-8?B?dWVxYkl2TzhjR2ZWOEoxWnhpemlPVlZiSnFZdXl2NXVRNktBKzdhZC80c2pT?=
 =?utf-8?B?d05YWjQ3enorRlgvcmRDL1BEeUpDcG5OQVd3d2VDK3ZuVWx0eHF2eW10SEFk?=
 =?utf-8?B?VU00ellWYSt5VlZFajJHV0lKZlFEeC9OTXM0bWNMWklkYk0rblQ3ZXlQd3hn?=
 =?utf-8?B?eGNWZnZqYTQ2U2xEdk9PWk0vTWtEMHpXV3RWSmc5ZkVSem5JQnU5ZnpCaWRi?=
 =?utf-8?B?U2o3SG1kbkZpTjhvckMzRHRTbmhZdlRoTjZubGxxOHdzanI2Nkxsc2w1dXU1?=
 =?utf-8?B?ZTI1dVZuRXh4V00vNkhDUWd2bWlNOTZhdFAyTTlqMERmdlBFU0Y1azZuNTlF?=
 =?utf-8?B?T3p2Yysra0c4MnJUUTF0NXBybjd6YVVEUUp3SEtxUVlDSDQ4Z1lwMEtSQWhH?=
 =?utf-8?B?Y1poU0xGTkRHcktITG5DUy9BRzJxUWpaRjhqK0NPK2c0S3IweU40V01tTUEx?=
 =?utf-8?B?MzlOc3c5QitWT1FvNGtCK1NwWVRuMUQ0Y1NhWWV4OXNkOG02Wk5ldlBGRkhm?=
 =?utf-8?B?cGN5UTBZOFR2emF4cE9kVzlTa1JucTVxNjQwMUNxM0JIZnp3ZWJVd2lwUE5n?=
 =?utf-8?B?a1BHaEtZZWpLQ0tMRFRuMWpEQTNJNWhYcXRZWHZ4aWJYcUtiRkR6MHA4dGMz?=
 =?utf-8?B?YWtBa3hZdDAyNWdtMDB3elprTC9rK0FTRWd6SzZzKzFtcE5RNWo3OUlUWnQz?=
 =?utf-8?B?SHcyRFRDdlVXT2xhSjFyRXY1ZzFjWVVJSlQwOTRwYkV3dnRERTE2dkJBQjVX?=
 =?utf-8?B?cEdrRWFSdVV1TTQvUzRNWXZTclRscnV6SVIvdVNJVGlJRnQ3MDBnTkVHajQ2?=
 =?utf-8?B?eC9WcENPVWZwMVFKWU1YWHA5VnV1UWEvcW9GUzgzVFhWMHYrMmxSbVlvd2Qy?=
 =?utf-8?B?K0l1cFpRVDVSQUNESVpiUjBXcTZnclg2S2sxSGxIM0xzRWdwUVlHbkZydnZs?=
 =?utf-8?Q?vJsyYlQhpYxb6KC7Aw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61afe7c-d974-4c04-030f-08df2a86ee48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:38:32.1537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxKgM/zNrCvd3S0rLfy8l6Bco8QNaR0089FglC1miwg+2Dlq+MkV6rzoYUQe2J6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMywgMjAyNiA1OjMxIFBNDQo+IFRv
OiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IFByb3N5YWssIFZp
dGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA3Lzld
IGRybS9hbWRncHUvdXNlcnE6IHRha2UgcmVzZXRfZG9tYWluLT5zZW0gYmVmb3JlDQo+IHVzZXJx
X211dGV4IGluIGRlc3Ryb3kNCj4NCj4gT24gMTAvMTMvMjYgMTA6MjQsIFByaWtlIExpYW5nIHdy
b3RlOg0KPiA+IGFtZGdwdV91c2VycV9kZXN0cm95KCkgdGFrZXMgcmVzZXRfZG9tYWluLT5zZW0g
Zm9yIHJlYWQgaW4NCj4gPiBhbWRncHVfdXNlcnFfZGV0YWNoX2Rvb3JiZWxsKCkgd2hpbGUgaG9s
ZGluZyB1c2VycV9tdXRleC4NCj4NCj4gWWVhaCB0aGF0IGlzIGNvcnJlY3QgYmVoYXZpb3IuDQo+
DQo+ID4gR1BVIHJlY292ZXJ5DQo+ID4gaG9sZHMgcmVzZXRfZG9tYWluLT5zZW0gZm9yIHdyaXRl
IGFuZCB0aGVuIHRha2VzIGNsaWVudGxpc3RfbXV0ZXggaW4NCj4gPiBkcm1fY2xpZW50X2Rldl9z
dXNwZW5kKCksDQo+DQo+IFRoYXQgaXMgY29tcGxldGVseSBicm9rZW4gYmVoYXZpb3IgYW5kIG5l
ZWQgdG8gYmUgZml4ZWQuDQo+DQo+IFRoZSBHUFUgcmVzZXQgY2FuICpORVZFUiogY2FsbCBkcm1f
Y2xpZW50X2Rldl9zdXNwZW5kKCksIHdobyBjYW1lIHVwIHdpdGgNCj4gdGhhdCBub25zZW5zZT8N
Cg0KVGhlIGNhbGwgdG8gZHJtX2NsaWVudF9kZXZfc3VzcGVuZCgpIGhhdmUgYmVlbiBpbiB0aGUg
R1BVIHJlY292ZXJ5IHBhdGggZm9yIHNvbWUgdGltZSwgcG9zc2libHkgbGV2ZXJhZ2VkIGluY29y
cmVjdGx5IGZyb20gdGhlIHN5c3RlbSBzdXNwZW5kIHBhdGguIEnigJlsbCBjbGVhbiBpdCB1cCBp
biB0aGUgR1BVIHJlY292ZXJ5IHBhdGguDQoNClJlZ2FyZHMsDQpQcmlrZQ0KDQo+IFJlZ2FyZHMs
DQo+IENocmlzdGlhbi4NCj4NCj4gPiB3aGljaCBhbHJlYWR5IGRlcGVuZHMgb24gdXNlcnFfbXV0
ZXggdGhyb3VnaCB0aGUgZmJkZXYgcmVzZXJ2YXRpb24gYW5kDQo+ID4gdXNlcnEgcmVzdG9yZSBw
YXRocy4gTG9ja2RlcCByZXBvcnRzOg0KPiA+DQo+ID4gICBDaGFpbiBleGlzdHMgb2Y6DQo+ID4g
ICAgICZkZXYtPmNsaWVudGxpc3RfbXV0ZXggLS0+ICZ1c2VycV9tZ3ItPnVzZXJxX211dGV4IC0t
Pg0KPiA+ICZyZXNldF9kb21haW4tPnNlbQ0KPiA+DQo+ID4gS2VlcCB3YWl0aW5nIGZvciB0aGUg
bGFzdCBmZW5jZSB1bmRlciB1c2VycV9tdXRleCBvbmx5LCBhcyB0aGUgZmVuY2UNCj4gPiBvZiBh
IGh1bmcgcXVldWUgaXMgb25seSBmb3JjZS1jb21wbGV0ZWQgYnkgdGhlIHJlc2V0LCB0aGVuIHRh
a2UNCj4gPiByZXNldF9kb21haW4tPnNlbSBiZWZvcmUgcmUtYWNxdWlyaW5nIHVzZXJxX211dGV4
IGZvciB0aGUgZG9vcmJlbGwNCj4gPiBkZXRhY2gsIHVubWFwIGFuZCBmZW5jZSBkcml2ZXIgdGVh
cmRvd24uIFRoaXMgYWxzbyBrZWVwcyB0aGUgTUVTIHVubWFwDQo+ID4gZnJvbSByYWNpbmcgd2l0
aCBhbiBpbi1wcm9ncmVzcyBHUFUgcmVzZXQuDQo+ID4NCj4gPiBGaXhlczogZjE4NzE5ZWY0YmI3
ICgiZHJtL2FtZGdwdTogQ29udmVydCBhbWRncHUgdXNlcnF1ZXVlIG1hbmFnZW1lbnQNCj4gPiBm
cm9tIElEUiB0byBYQXJyYXkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnEuYyB8IDE2ICsrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5kZXggNWZlZjBjYzc3
MDNjLi5hMzRlYThlY2Q3MDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC00MTUsMTUgKzQxNSw2IEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2ZlbmNlKHN0cnVjdA0KPiBhbWRncHVfdXNlcm1vZGVf
cXVldWUgKnF1ZXVlDQo+ID4gICAgIGRtYV9mZW5jZV93YWl0KGYsIGZhbHNlKTsNCj4gPiAgfQ0K
PiA+DQo+ID4gLXN0YXRpYyB2b2lkIGFtZGdwdV91c2VycV9kZXRhY2hfZG9vcmJlbGwoc3RydWN0
IGFtZGdwdV91c2VybW9kZV9xdWV1ZQ0KPiA+ICpxdWV1ZSkgLXsNCj4gPiAtICAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBxdWV1ZS0+dXNlcnFfbWdyLT5hZGV2Ow0KPiA+IC0NCj4gPiAt
ICAgZG93bl9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7DQo+ID4gLSAgIHhhX2VyYXNl
X2lycSgmYWRldi0+dXNlcnFfZG9vcmJlbGxfeGEsIHF1ZXVlLT5kb29yYmVsbF9pbmRleCk7DQo+
ID4gLSAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiAtfQ0KPiA+IC0N
Cj4gPiAgLyoqDQo+ID4gICAqIGFtZGdwdV91c2VycV9lbnN1cmVfZXZfZmVuY2UgLSBlbnN1cmUg
YSB2YWxpZCwgdW5zaWduYWxlZCBldmljdGlvbiBmZW5jZQ0KPiBleGlzdHMNCj4gPiAgICogQHVx
X21ncjogdGhlIHVzZXJtb2RlIHF1ZXVlIG1hbmFnZXIgZm9yIHRoaXMgcHJvY2VzcyBAQCAtNTQ3
LDgNCj4gPiArNTM4LDEyIEBAIGFtZGdwdV91c2VycV9kZXN0cm95KHN0cnVjdCBhbWRncHVfdXNl
cnFfbWdyICp1cV9tZ3IsDQo+ID4gc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWUNCj4gPg0KPiA+
ICAgICBtdXRleF9sb2NrKCZ1cV9tZ3ItPnVzZXJxX211dGV4KTsNCj4gPiAgICAgYW1kZ3B1X3Vz
ZXJxX3dhaXRfZm9yX2xhc3RfZmVuY2UocXVldWUpOw0KPiA+ICsgICBtdXRleF91bmxvY2soJnVx
X21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+DQo+ID4gLSAgIGFtZGdwdV91c2VycV9kZXRhY2hfZG9v
cmJlbGwocXVldWUpOw0KPiA+ICsgICAvKiBHUFUgcmVjb3ZlcnkgdGFrZXMgdXNlcnFfbXV0ZXgg
dW5kZXIgcmVzZXRfZG9tYWluLT5zZW0sIGtlZXAgdGhhdA0KPiBvcmRlciAqLw0KPiA+ICsgICBk
b3duX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiArICAgbXV0ZXhfbG9jaygm
dXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4gKyAgIHhhX2VyYXNlX2lycSgmYWRldi0+dXNlcnFf
ZG9vcmJlbGxfeGEsIHF1ZXVlLT5kb29yYmVsbF9pbmRleCk7DQo+ID4NCj4gPiAgI2lmIGRlZmlu
ZWQoQ09ORklHX0RFQlVHX0ZTKQ0KPiA+ICAgICBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUocXVl
dWUtPmRlYnVnZnNfcXVldWUpOw0KPiA+IEBAIC01NTgsNiArNTUzLDcgQEAgYW1kZ3B1X3VzZXJx
X2Rlc3Ryb3koc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21nciwgc3RydWN0IGFtZGdw
dV91c2VybW9kZV9xdWUNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9mcmVlKHF1
ZXVlKTsNCj4gPiAgICAgcXVldWUtPmZlbmNlX2RydiA9IE5VTEw7DQo+ID4gICAgIG11dGV4X3Vu
bG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4gKyAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0
X2RvbWFpbi0+c2VtKTsNCj4gPg0KPiA+ICAgICAvKg0KPiA+ICAgICAgKiBBIGZhaWxlZCB1bm1h
cCBtZWFucyBNRVMgY291bGQgbm90IHJlbW92ZSB0aGUgaHVuZyBxdWV1ZSBhbmQgaXMNCj4gPiBu
b3cNCg0K
