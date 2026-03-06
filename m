Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F897FCC062
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 20:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B09F10E162;
	Fri,  6 Mar 2026 20:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HotZaTv/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FE110E162
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 20:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAPpoO/YZ4hR/wk1czjBznw+rWbwScS1wuqi4TnK5u5U7B7fdq2JihChW91P656ticFdfOfoku1Kexjb+2GexVNMWq32a7WGaLhiRvM3mI3VJCZChnvrI2/tZ6zVhsHGvIQkXUZRom4Xfr6IiT/LRixs+qrS24NUtpkxgGIBz7pYagogHxKruQxFBDlkdT8zR69eFS8t9AA3o5sbX2gt3awYKkCdJrECl63yzVIx0QJseGRE6yIkAlujf+8zwWWyPz0A+859bw0u/nvBj7bzj5lDarkaMok0R/gQk58dnptZdg/51o7OLDYVy6hjjbu4e/+SA6LKhy2pl8KTlnvaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdN2mIgJPY0HifQqRgiJd1GaJSxbtDLnsNZAd8ZwdpI=;
 b=HaoCp+9+3yVLJxv58m9HrpPniH9JBm+6L1MC8UHQqVGkRPLJQL0ViRDPeKr+TL5GPSPYpHvDZls07IjUy3BHmR95PNP4g0p2s/GDQxlBMqJqRU39e/K8ivYZvCkKyxn0T4kBpbahFk4uIS5xqu+htjQIPxFu0Lw9pQ5uI6Scp+NrqjVWY+LjKW8IemtwniDeq9xFceg7PDSpufGHbqkvLNcvc7cQ4w1sojnIcqVPVjYsxT1sej0qGlDEH4oJABPgkpuFQKCxMpzFL28FpV2ABNZP+6zX6fuU7jj3Zd+HzoEqHR9LK8a9UR7J7ba7j6qHJ8VoYe02KjN1KN2eKxlT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdN2mIgJPY0HifQqRgiJd1GaJSxbtDLnsNZAd8ZwdpI=;
 b=HotZaTv/j6S/VOINJL740oK8006fv9kRY91MQqpumJnlIf8d3BrIOs1s5v70YMLCE2dKh09AiAcd6aaAguC5+Tg16paJcyuUAGOwoSAgp7fbjzVxX65lZGLotUVuQf4WH5UVokiWWj7HzjTzp5iViqv6W5bLc4xem4MW0mk8OmQ=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 20:26:42 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 20:26:42 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chan,
 Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3
Thread-Index: AQHcqymFaz9nggN0iEiEJBN/VIYHfrWhszoAgAAxNKA=
Date: Fri, 6 Mar 2026 20:26:42 +0000
Message-ID: <SJ1PR12MB61217A1E333E25490C325B8B807AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20260303161921.435188-1-Chenglei.Xie@amd.com>
 <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
In-Reply-To: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-06T19:13:55.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|MN0PR12MB6200:EE_
x-ms-office365-filtering-correlation-id: ca561d3e-b47e-415e-032e-08de7bbeadbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: ygvUDl40QD/mDCuwGGDVuTxc2ER10LmtRDW4C5ZNL6ukS1QxpcAi3T3GJu/0V/lbcrtlXhuIIlUqKVOrPJPcAHs7SPYw7ZHI5FvqTeKvCu4+MbMKM/hijfp/pobB9Vt5648mUp2SaX460F6AVTEE6opw51SH6mb22lKCDxeM8J9hhLS5aJiwS/GMo27VakkesDp3zuSz2UvWXIOiZ+hejSfTCCO5EqRjW7TD3HqaAPotFYVKwXLgxTHXATgbCw9TgB0KRPclZDRlpamr2lIKvSvz8sGRqu1MOhIcEl+4pAN4XzhBhM9rFUYiLTJzNoMfBXPz0AIRMbrqmOSV+bvzGIJAuGnT2XX5fUfcmOkE24hzJic/haR63A2SkyJwaX9rUjSeY0eDoYTUeYGJD3gAyC/f6MCvmeMoWGmGcOieXgKhU+9oG4MvOx3cnXOMhQib5xXC8a6W+MtLJuSLqXbciqA7J6lSp7SwTVf1ffIPjp9j3gdrV6kP5QW4HO65XAjJZtLNSRLJ+I1PL0yxUNy+RS+fTDFpGOpbDa/dRTxHdtjHTcQpmIymVODYwu655vu9lZmXfvdvubJ7ghyuXqZi+ua0Nfr63L4M9pvwzYuI0xUODL6cS5rExLxTblEQ1kOHpinn1OedYlI0zX0c9eNQtYgXBHJMQ1BZKye6/yy+bWGlGH5Vv8PCLyV8gc+kIWYwK7OHu9gEGfCKhm0PgZPHWqfPGBkO7Jnq2nBnnMuFoPCcd0DbrAIGu43cOQY5yhZhh5O9Bf8vdKR0O2s6Onyopas7tahNQtqZ6lDuxZ96qSI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmF5U2tQVEdpUTVURDltYkF2MEk0ZENWRXFmeWEwWEtlSHdaSkJja3dONXU5?=
 =?utf-8?B?b1hDQ2d3NXcyRFpxQlVFd3dHZ1AyV3BjSWpGWldmWFlYajVxTjJiU2N6SDFz?=
 =?utf-8?B?QTRra3BOOGN1Qk1yTUdBVHBERlBjVzgrdjFhUFJOVHpmWXpudEtxQ1hvQzlX?=
 =?utf-8?B?ZkZaRmMzcDVvUmgranZzRll5ZnV3bHp4dnF4dXdVRFZBT1R1YkVPZ3N1VTEy?=
 =?utf-8?B?L3VrZEd1Zm9pcm93bFpMUVpTYlNUbS9sd04zQXNmdDBQdnJaV2tGdG9sekVB?=
 =?utf-8?B?Qi9leXA2Q3VqaWJEZ3pWQ0RGRWg1SFV5cDltNGJLRGttOWdmbFc2MGlMaDk2?=
 =?utf-8?B?M2hjNUJIajJEOFF0R1hwekpyUHFWV1FVSDFNTWs4b3lHcjNIWFB0R2RJcWJD?=
 =?utf-8?B?NzJBTmxTb2MwZjJEa0J4cURXTlhmSWxCVjdlUHJSOFdiWVFVamo1bVcycHVD?=
 =?utf-8?B?MWljcno1VWNkcW5JbWU5YUhWalFMNXl1T3JLSnVjWG1TcE5sSDNYbkpkeFp3?=
 =?utf-8?B?NTFzaWZqYVRTaHo4Q3B5TmxjSkRDYkV5dExzMjR6dFcxbnFmVTlEWmJTN2Nh?=
 =?utf-8?B?S1dVN21DNlZvbWVwQlM5b1ZRb1NQaDNVNlJqNEsyMHNmbHUyV1pQbnFuUkZU?=
 =?utf-8?B?WXV5a3d3YjVUd05QUFRYMFdxNEhOanE5ejRNZHFlZzR5dXIzeVNQTlZEVmRL?=
 =?utf-8?B?R1M5U01lVDlqQ0hxZnp2cXlzc3lyRVcyUjYvTjhZcmJlR3pmcDJmMHZvdlRm?=
 =?utf-8?B?N2xDNW90Z3ppZXhBVjg5SGhtZnYwQU85ZkU2ZmxKTU5wZXhZdk92cXcvK3l3?=
 =?utf-8?B?cnFJNDl5czVsQVRNWnBKMzMwUkZjaE9EdmZXSVNEMlEydFREZEpEWHVpc3RN?=
 =?utf-8?B?ZmRWNzduV0VSS1Y3aEVyU0ptSktVSTA3Qmt2aHloMjRYZWdMQlVqR25DUE9V?=
 =?utf-8?B?UzUyTk5OcjlOWXBjWWFiWXFqSjAxUWtnM1ZKV3EvL2VGTHBEUU50K2VJZmlS?=
 =?utf-8?B?NTNTV00wK0JCVTQ0MjlUeU1jR1Y1NW12MytYTEdFckVuQUFzVk9Od2hta3VZ?=
 =?utf-8?B?b1RHdTE3eDVldlpLbC9WQ1hMU0tuUXh5VlFTc0FmajZGa1dJaVlEaytnK29N?=
 =?utf-8?B?WVVUdkxROXdJaFJKMDkrRkZ1SWRiVlJ3ZEhtbS9FTjRCS2xWUFdsRk9kRnRw?=
 =?utf-8?B?TXBGWGMwM3NnWmZUVjc2cm9XR0Nhdk1HWjM3ZnIya2tpUnBjUUVEWFRTWU5q?=
 =?utf-8?B?d3BsU3VzNUQ3YkMzcDJOWFNHeTFBRkJneXF2L21lelo1ekorR2tnWjQybzhw?=
 =?utf-8?B?cjNkWTVObVVpdjZyc0JJbk9JbHlJT25KZ0pEcXlKVTNJMnhHbURqQTdyTlBN?=
 =?utf-8?B?amZ1QlpXWE0vRXdkejBLMzRMeWY0QjRsQUxYWWVQVmNQSUxCRkFnbUhDZ1Vt?=
 =?utf-8?B?aVJHRXRWbnJqNnJaSStkUXB6TzV6bTl5SmZudDFsWUJOSGNadzIwSVpmRkx4?=
 =?utf-8?B?YkZnaDFBVW5ybUpBT0o0WHRRdnJTY1VaYXQ2L2ZIbHlhUE5QR1liSjJSam5G?=
 =?utf-8?B?TUlWVjFobjgyTFF2a3ZuN3ZMeVlSTDBxZTVsMW9CMjJJUU0wbWFBd014RDBV?=
 =?utf-8?B?L2psSlh3VkhjRTFxM1BLNThTOXJpTkJsZVJmNG1TK3YwbWNVbTNWczVEYjlw?=
 =?utf-8?B?RGxoTHlmbFBoL044dXRiTlYvblJpMC9wZU9Na1RQeFV2cDZJemNDRDBiSThW?=
 =?utf-8?B?Q2hQVEdEcDgwd3BPYnpTWVRNdFhyRGMxa1FocGdoYXN5amxmakErN0w4cXYx?=
 =?utf-8?B?UmlqdHUzRUswcldJQjlnNWc4c3NpWTZLbHMvNURXa1JIaGc5UlN4TXNCQ0tz?=
 =?utf-8?B?VU9kWmxRN2YreTFCc3E4TUdaM1J0cW5lR0hnb2M4LzluNWx4cUpOSGN5Z0J6?=
 =?utf-8?B?U2RDclFEUGFyUU1sNkxiL08zOEtIN21EWDJHTyt2MU9WZXVLNnVZQ1UzYmVO?=
 =?utf-8?B?L1pNUUxsanphOURvUWNoZDZYdEZ0UGJWRlU0c3RMQW1nV3dod1hSdVp4UUpl?=
 =?utf-8?B?RW0waDNtVWhHeldaYnZLTWxqTTNxMUswNEo1RVNad1djZXVNWjU1c2xyUzJk?=
 =?utf-8?B?c2lrdWJCdGpxZjF5MHpzQ1krZGh1S2kyUzByc0RUaHMyL3FlNFM5UzBHR0NW?=
 =?utf-8?B?NFNIRTVSNUxNQmltcG1wNU90S09lOFcrVUc3SEFWL2NSekZRZWpEQTdpZ0hF?=
 =?utf-8?B?dFR3MWJBYU95UWdFaFR2dzlRQVlCbXhLZ0dkMVhmeGVhMTZ0dXduMGZ2SDY5?=
 =?utf-8?Q?tsYunXLQkjBqebU3lg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca561d3e-b47e-415e-032e-08de7bbeadbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 20:26:42.1939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5GQZqQWpEpYucwT8qmXEExTxkfMXN70/oIfU6uV5CIEMcUbC9sybAGdydPCf8ns4CipXjEnX1l1HQTTrJU43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
Cg0KSGkgQWxleCwNCg0KYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKCkgaXMg
d29ya2luZyBidXQgaXQgd2FzIGNhbGxlZCBwcmlvciB0byBHUFUgcmVzZXQuDQoNCkhvd2V2ZXIs
IGluIHRoaXMgZmFpbGluZyBjYXNlLCBkdXJpbmcgYSBHUFUgcmVzZXQsIHRoZSBLSVEgcmluZyBp
cyBzdGlsbCB1c2VkIChlLmcuIGZvciBIRFAgZmx1c2ggaW4gYW1kZ3B1X2tpcV9oZHBfZmx1c2go
KSkuIEVhY2ggb2YgdGhvc2Ugc3VibWlzc2lvbnMgZW1pdHMgYSBmZW5jZSBhbmQgaW5jcmVtZW50
cyBzeW5jX3NlcS4gVGhlIGhhcmR3YXJlIHF1ZXVlIGlzIGxhdGVyIGNsZWFyZWQgYnkgdGhlIHJl
c2V0IGFuZCBuZXZlciBydW5zIHRob3NlIGNvbW1hbmRzLCBzbyBpdCBuZXZlciB1cGRhdGVzIHRo
ZSBmZW5jZSB3cml0ZWJhY2sgbG9jYXRpb24uIEFmdGVyIHJlc2V0LCB0aGUgd3JpdGViYWNrIG1l
bW9yeSBzdGlsbCBob2xkcyB0aGUgbGFzdCB2YWx1ZSB3cml0dGVuIGJlZm9yZSByZXNldCB3aGls
ZSBzeW5jX3NlcSBoYXMgbW92ZWQgZmFyIGFoZWFkLg0KDQpCZWZvcmUgZW1pdHRpbmcgYSBuZXcg
ZmVuY2UsIGFtZGdwdV9mZW5jZV9lbWl0X3BvbGxpbmcoKSB3YWl0cyB1bnRpbCB0aGUgb2xkZXN0
IGluLWZsaWdodCBmZW5jZSBpcyBkb25lOiBpdCBjYWxscyBhbWRncHVfZmVuY2Vfd2FpdF9wb2xs
aW5nKHJpbmcsIHNlcSAtIHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2ssIHRpbWVvdXQp
LCB3aGljaCBidXN5IHdhaXRzIHVudGlsIHRoZSB3cml0ZWJhY2sgdmFsdWUgaXMgYXQgbGVhc3Qg
dGhhdCBzZXF1ZW5jZS4gQmVjYXVzZSB0aGUgd3JpdGViYWNrIHZhbHVlIGlzIHN0aWxsIG5lYXIg
dGhlIHByZS1yZXNldCB2YWx1ZSBhbmQgc3luY19zZXEgaGFzIGdyb3duLCB0aGUgcmVxdWlyZWQg
c2VxdWVuY2UgKHN5bmNfc2VxIC0gbnVtX2ZlbmNlc19tYXNrKSBpcyBtdWNoIGxhcmdlciB0aGFu
IHRoZSB3cml0ZWJhY2sgdmFsdWUuIFRoZSBkcml2ZXIgdGhlcmVmb3JlIHdhaXRzIGZvciBjb21w
bGV0aW9uIG9mIGZlbmNlcyB0aGF0IHdlcmUgbG9zdCBpbiB0aGUgcmVzZXQgYW5kIHdpbGwgbmV2
ZXIgY29tcGxldGUsIHRoZSB3YWl0IGhpdHMgdGhlIHRpbWVvdXQsIGFuZCBhbWRncHVfZmVuY2Vf
ZW1pdF9wb2xsaW5nKCkgcmV0dXJucyAtRVRJTUVET1VULiBUaGUgZHJpdmVyIHRoZW4gcmVmdXNl
cyB0byBlbWl0IG5ldyBLSVEgZmVuY2VzLCBhc3N1bWluZyB0aGUgcmluZyBpcyBmdWxsLCBhbmQg
S0lRIHN1Ym1pc3Npb25zIGVmZmVjdGl2ZWx5IHN0YWxsLg0KDQpUbyBmaXggdGhpcywgd2hlbiBy
ZS1pbml0aWFsaXppbmcgdGhlIEtJUSBhZnRlciBhIHJlc2V0LCB0aGUgY29kZSBub3cgc2V0cyB0
aGUgZmVuY2Ugd3JpdGViYWNrIG1lbW9yeSB0byBzeW5jX3NlcS4gU28gaXQgbm8gbG9uZ2VyIHdh
aXRzIGZvciB0aG9zZSBsb3N0IGZlbmNlcy4gYW1kZ3B1X2ZlbmNlX2VtaXRfcG9sbGluZygpIGNh
biB0aGVuIGVtaXQgbmV3IGZlbmNlcyB3aXRob3V0IHRpbWluZyBvdXQsIGFuZCBLSVEgdXNhZ2Ug
cmVzdW1lcyBhZnRlciByZXNldC4NCg0KUmVnYXJkcywNCkNoZW5nbGVpDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQpTZW50OiBGcmlkYXksIE1hcmNoIDYsIDIwMjYgMTE6MTggQU0NClRvOiBYaWUsIENoZW5nbGVp
IDxDaGVuZ2xlaS5YaWVAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgQ2hhbiwgSGluZyBQb25nIDxKZWZmcmV5LkNoYW5AYW1kLmNvbT47IEx1bywgWmhpZ2FuZyA8
WmhpZ2FuZy5MdW9AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggS0lRIGZlbmNlIHRpbWVv
dXQgYWZ0ZXIgR1BVIHJlc2V0IG9uIEdGWCB2OS40LjMNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQg
ZW1haWwgZnJvbSBhbGV4ZGV1Y2hlckBnbWFpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
DQpPbiBUdWUsIE1hciAzLCAyMDI2IGF0IDExOjI54oCvQU0gQ2hlbmdsZWkgWGllIDxDaGVuZ2xl
aS5YaWVAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IEFmdGVyIEdQVSByZXNldCwgdGhlIGhhcmR3YXJl
IHF1ZXVlIGlzIGNsZWFyZWQgYW5kIGFsbCBwZW5kaW5nIGZlbmNlcw0KPiBhcmUgbG9zdC4gSG93
ZXZlciwgdGhlIGZlbmNlIHdyaXRlYmFjayBtZW1vcnkgcmVtYWlucyBzdGFsZSBmcm9tDQo+IGJl
Zm9yZSByZXNldCwgd2hpbGUgc29mdHdhcmUgY29udGludWVzIGVtaXR0aW5nIGZlbmNlcyBhbmQg
c3luY19zZXENCj4ga2VlcHMgaW5jcmVtZW50aW5nLiBUaGlzIGNhdXNlcyBhbWRncHVfZmVuY2Vf
ZW1pdF9wb2xsaW5nKCkgdG8gd2FpdA0KPiBmb3IgZmVuY2VzIHRoYXQgd2VyZSBsb3N0IGR1cmlu
ZyByZXNldCwgcmVzdWx0aW5nIGluIC1FVElNRURPVVQgZXJyb3JzLg0KPg0KPiBGaXggdGhpcyBi
eSB1cGRhdGluZyB0aGUgZmVuY2Ugd3JpdGViYWNrIG1lbW9yeSB0byBtYXRjaCBzeW5jX3NlcQ0K
PiBhZnRlciBHUFUgcmVzZXQgaW4gZ2Z4X3Y5XzRfM194Y2Nfa2lxX2luaXRfcXVldWUoKS4gVGhp
cyBhbGlnbnMgdGhlDQo+IGhhcmR3YXJlJ3MgdmlldyBvZiBjb21wbGV0ZWQgZmVuY2VzIHdpdGgg
c29mdHdhcmUncyB2aWV3IG9mIGVtaXR0ZWQNCj4gZmVuY2VzLCBwcmV2ZW50aW5nIHRpbWVvdXRz
IHdoZW4gd2FpdGluZyBmb3IgZmVuY2VzIHRoYXQgbm8gbG9uZ2VyIGV4aXN0Lg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaGVuZ2xlaSBYaWUgPENoZW5nbGVpLlhpZUBhbWQuY29tPg0KPiBDaGFuZ2Ut
SWQ6IEk3MTdkZjUyZWQwZWYwYmI1MWE2OTAxZjIxODE5MWQ5ODM3YTc3ZjZmDQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jIHwgOSArKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiBpbmRleCBhZDRkNDQyZTczNDVlLi42YjVmY2RkOTg3
NjkzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8z
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jDQo+IEBA
IC0yMTM1LDYgKzIxMzUsMTUgQEAgc3RhdGljIGludCBnZnhfdjlfNF8zX3hjY19raXFfaW5pdF9x
dWV1ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGludCB4Y2NfaWQpDQo+ICAgICAgICAgICAg
ICAgICBnZnhfdjlfNF8zX3hjY19raXFfaW5pdF9yZWdpc3RlcihyaW5nLCB4Y2NfaWQpOw0KPiAg
ICAgICAgICAgICAgICAgc29jMTVfZ3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwgMCwgR0VUX0lO
U1QoR0MsIHhjY19pZCkpOw0KPiAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5z
cmJtX211dGV4KTsNCj4gKw0KPiArICAgICAgICAgICAgICAgLyogVXBkYXRlIGZlbmNlIHdyaXRl
YmFjayBtZW1vcnkgdG8gYWxpZ24gd2l0aCBzb2Z0d2FyZSBzdGF0ZSBhZnRlciByZXNldC4NCj4g
KyAgICAgICAgICAgICAgICAqIEFmdGVyIEdQVSByZXNldCwgdGhlIGhhcmR3YXJlIHF1ZXVlIGlz
IGNsZWFyZWQgYW5kIGFsbCBwZW5kaW5nIGZlbmNlcw0KPiArICAgICAgICAgICAgICAgICogYXJl
IGxvc3QuIFRoZSBmZW5jZSB3cml0ZWJhY2sgbWVtb3J5IG1heSBiZSBzdGFsZSBmcm9tIGJlZm9y
ZSByZXNldC4gVG8gcHJldmVudA0KPiArICAgICAgICAgICAgICAgICogd2FpdGluZyBmb3IgbG9z
dCBmZW5jZXMsIHVwZGF0ZSB3cml0ZWJhY2sgbWVtb3J5IHRvIG1hdGNoIHN5bmNfc2VxLg0KPiAr
ICAgICAgICAgICAgICAgICogVGhpcyBhdm9pZHMgd2FpdGluZyBmb3IgbG9zdCBmZW5jZXMgYW5k
IHByZXZlbnRzIHRpbWVvdXRzLg0KPiArICAgICAgICAgICAgICAgICovDQoNClRoaXMgZG9lc24n
dCBtYWtlIHNlbnNlLiAgTm8gb3RoZXIga2lxX2luaXRfcXVldWUoKSBmdW5jdGlvbiBkb2VzIHRo
aXMuICBXaGVuIHRoZSBHUFUgaXMgcmVzZXQsIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29t
cGxldGlvbigpDQpzaG91bGQgZ2V0IGNhbGxlZCBmb3IgZWFjaCByaW5nLiAgVGhhdCB3aWxsIHNl
dCBhbiBlcnJvciBvbiB0aGUgZmVuY2UgYW5kIHVwZGF0ZSB0aGUgZmVuY2Ugc2VxdWVuY2UuICBX
aHkgaXMgdGhhdCBub3Qgd29ya2luZz8NCg0KQWxleA0KDQo+ICsgICAgICAgICAgICAgICAgaWYg
KHJpbmctPmZlbmNlX2Rydi5jcHVfYWRkcikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKnJp
bmctPmZlbmNlX2Rydi5jcHVfYWRkciA9DQo+ICsgY3B1X3RvX2xlMzIocmluZy0+ZmVuY2VfZHJ2
LnN5bmNfc2VxKTsNCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgbWVtc2V0
KCh2b2lkICopbXFkLCAwLCBzaXplb2Yoc3RydWN0IHY5X21xZF9hbGxvY2F0aW9uKSk7DQo+ICAg
ICAgICAgICAgICAgICAoKHN0cnVjdCB2OV9tcWRfYWxsb2NhdGlvbiAqKW1xZCktPmR5bmFtaWNf
Y3VfbWFzayA9DQo+IDB4RkZGRkZGRkY7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
