Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3524C531FA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 15:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA3F10F415;
	Fri, 24 Jul 2026 15:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0v3HV1q";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D1410F415
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOBJlrvIGYFx8pP7jiwp+whkCmke/5JrBRP7J2CO5nUZAPVFlYa4R7t9ITxeEGqgQi5UuuqS4LfdTlF66CGJJSECvJNoM92dI+snYVIQe/fJEULgp2xFn82oEUqJZrgM00ox7/vV/k8Q2qeNJlg2lfilIqh5OpUDDesI8KV2jKHrND6/5vtQ5/XFDduVGwtvkLVLZL0tRo2j4UynjNKPCCh3y+HsSp8bdEZ+W1tgwkWszJKIXw/GpZKuoX4jn5RYksJWV1hRzd4Z/rD3SQ/6h9i9RO1ieT8FfW2havJMG2yuH4to946+KhuSwy4u5guVJ64pAsgnWtr4pw+I3BvQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW2KUR6T3UsHjxWZqFYNpg2TsZBMexwBcHQZP5DYFak=;
 b=pE3kWYabcUeIQXSX2YYHymmmcF2OWEiw1ROSpf/xojmu4s0XGK8a8r8vXJqdaRE7lf+F5jBxpUa/ojNLchnTScqQaFyBj4OcRKK+KQ6+ozVUcw/jVQ+qb2dOyPjPqTzD1SqhYymL/7/7LEQZHMubSGzRXKrP3N/wf8vd0bS575G6bpNujF14u7dMcOsOqDHAKe7+dwS+7IZGwOcYvU+Fcs33SAp5St1Jrq+7We1udCGLnmb6IRtthB5JGui4gW4jNuG9MjncPRRLPxDbRffQ/0lOYXNxzZ8tHTnJGfZJ38cvVSfEV6csjhu7/pqsP01U9UmHt5HfDYcSPzPfvUbpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW2KUR6T3UsHjxWZqFYNpg2TsZBMexwBcHQZP5DYFak=;
 b=R0v3HV1qlMfUBBU/Q81YPYNZtqBl+f/8VbzqwvS40nRd8yYEupLH7eTwYXVoUFjVThIt3yKpV3/uDQzcPv9ndZb2VOhT9UoEdZSGKbx84xJPCcM5vDkgmjii+c2mfMZtuEjIrcvozepfFIZVpyY9+362+WVH+HMxlBYYXcW0WD8=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by CY1PR12MB9651.namprd12.prod.outlook.com
 (2603:10b6:930:104::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 24 Jul
 2026 15:32:14 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 15:32:14 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Chen, Chen-Yu"
 <Chen-Yu.Chen@amd.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
Thread-Topic: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
Thread-Index: AQHc+L6bcKAlpqfgvE2burQMGNcjEbY33Y2AgD+c4oCAA0L5AIABIl2AgAElsBA=
Date: Fri, 24 Jul 2026 15:32:14 +0000
Message-ID: <CHXPR12MB999220FDC1942A3E16663F9029E5CF2@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
 <20260610094639.1965367-17-chen-yu.chen@amd.com>
 <nGLVvJOTS8eSI7IusBrUxw@collabora.com>
 <CY5PR12MB6132D29C644F51CD57A3B3B8D2C22@CY5PR12MB6132.namprd12.prod.outlook.com>
 <3dcc390a-716b-45bd-bd4c-6a7c90a5bd49@amd.com>
 <e9debc91-2a69-496f-9004-f05109072ee8@kernel.org>
In-Reply-To: <e9debc91-2a69-496f-9004-f05109072ee8@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T14:48:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|CY1PR12MB9651:EE_
x-ms-office365-filtering-correlation-id: d072e3a0-47ae-472c-1d0a-08dee998bcb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|6133799003|4143699003|18002099003|22082099003|11063799006|13003099007|10067099003|38070700021;
x-microsoft-antispam-message-info: jCZqFFlHU9ZJY6rdmmEtMmmvnonQLiuqYGoRabsUj5hkS3XzGNVh3uZ4FatJceABTiFcCZV2oFBg9coKtF2L8Y0k3elZcO8ZV5RvxeX83z4QvOTrKSs9n0MJlbMnCBVGCr/pMglJKY7ThS4ws7GBi4jjpkaqCJNJw79A4z6qBoUMNrrfUej5bM0dQlfLmtQ0St4sYawKG6V4nPLN04+cm8rSOa5qKnWqiN4fblJRt7r/4iiowcjIjCndnlH7b+Mut5rEauupVEwNCTk84gcE0qhUtjYVP27C+W0rT1iODtJ9HHgb8U7Gic5m3vmYP7tPRoItAGnhLDo6opYV2DoIjNfGRg0sIsZ2TvQGoJ0wyp5YcstV7n/K7Lw2lD6SKpfvus1SsneGAvAmprgec7LXiIquRnY1tOFXO9gteE1xdOPRDVcIdWXNx5zGhVng7Zj9yH+XccyCr/tvFu2qV5v81dvQEJogf+EsxuKR3FDFck6+IJyUP+nDH6NDaYVJM8mKid5LDsyV2n53yQjZRyZWdWLD+BF5gcmdPse5cxcfYd+Xrlfll2s56pUAq6FN99tjI0drpPyWezOZQbxOBXEI3j5GagoSol9DOldvYis54Jri4jXaL1Wg1GPqqDT9FE/fpnoRon58MhSRqQTVHecwUYiy13erD+YaMVsingLWZxI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(13003099007)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFFRMURJdExxTXI1dG9QRDZzMFM2bzVtL1FTK3RCVXlNYkJQM3hKenpLSEZM?=
 =?utf-8?B?T2YwZjBkZ0U5cnZJUFNob2lJZ1JPZ20xaEkwSmg5MTI4blQwMjFGYndxVWF5?=
 =?utf-8?B?VTdpb3JBMTQ1YkE3VkRWRklrZFVBWVZsd0Z0L1pobFcyTGhxd3dGVTg1L0pm?=
 =?utf-8?B?YkFvVUMwRlVyVmZ3S3AyOGNoQllKb1l3YXlwa2x6MU1WMmpiR0VrRWVSQ1pF?=
 =?utf-8?B?U1RJSm80NEwvZEZqdTRhYkFjRnBKSU1iNlpoK3JnUUt1VzZKZ0ttNmE5b3NW?=
 =?utf-8?B?UnJiZHRrd2hZS0l3M2Z0R1M1STNsM3I5OWtTc3JSSmYyOG1MYzNGVFVEZzNK?=
 =?utf-8?B?b3dYcXc4OVp3MTVjMlkxKzRIN1VYNlNCM2NJVElSVi9rVGRjWEVZM3BmbVJx?=
 =?utf-8?B?MzhUUzlvWFJXU3dUN244MGl3WHhocVgrWjQ5N3Qzc3Bnck8zRGVlaUJBVU1m?=
 =?utf-8?B?c0ZLMUhrN1RxeDAxcUFYVDI5dlVFcExXL0JCMlA2T3RSMGtDL3kvZDR0VVhw?=
 =?utf-8?B?aThlY2FFTEp0c0xVZlM3d1NaeEFDdXlMeUlsMk4yUmlxblZrNmxobVZoSFBN?=
 =?utf-8?B?ODZsSFhGUUJ2WGQzcDFUbHhpUmVHTVJJL2ZuVTNUa09KczcwNElrSUhKYUN1?=
 =?utf-8?B?N3dSblZvaWt5b0RaVTU5STNpVlRMbUF2dWtvWDdNWlc2ZHlmMTF0aXREYzAw?=
 =?utf-8?B?bVFMWTFjYWNCMklxeUtld3F4Y3ZTcCt4dE94dWxZdlQ5dm95Kzh4bjNmK0do?=
 =?utf-8?B?RG4za2tEbFkxKzhQSnlzd3lOTXc1OHdyekVPcm5GdHRwVUR6M0VJNklMUGJl?=
 =?utf-8?B?cXRkSnJPY0RqNllRWElFbjg2eGJibktJcmFreGNlazNzZVp2eDQwd3h1SndD?=
 =?utf-8?B?YmtmUUp3TlBjK0ZFNnBEekFTcFhkYkRVWmpHbTNHdnhxTTM0WTJvQ05iVmgw?=
 =?utf-8?B?ZDVrcitJYTloeFhveEJ6aW9TZUtEZlV0WW5FMkF0d3Rhci9aMjRzVU1Pc1FO?=
 =?utf-8?B?SGdualJjemkvMFdMTmVpamlwNU1CRzRSSjh4MVp4T25OQ0JnUmJQZnUyYk5C?=
 =?utf-8?B?MlRrQno4OHJ6eWtlcnJNVXlqZnlWZG83ZGllckM5cS85R2h6RldOVkFvR1FF?=
 =?utf-8?B?cDdDaHBjQkY2S2daeEJ0QjkvUmtrSWVPRzYrcC9Cci9RNU1sVVM2aVllVU9k?=
 =?utf-8?B?SGVvenN4bmsrVEZHMGpOQkltVjJEOXIvUGxCaG1OeGIvLzA2YUxqdlkrWXhY?=
 =?utf-8?B?L1ZVYWh2T080cjZGZDdhT3dlTUtXWW1hMUVyWDhSTHpMVUNveEs1c29SbmFy?=
 =?utf-8?B?NTN2TmF1dHhYRkNqOVBZZUJPdUtRNUt3QjgwQjV3V2dXOE81WTBvcTRuTUpY?=
 =?utf-8?B?Y2J5TzR0d1MwVytLSytSYkZqZnE3b3dkOUlxanZsdFRWamJESnhmbWNNRXNP?=
 =?utf-8?B?djREU0dWSWNlVThTT0pjWitIbXF3ZGVFc0phTlNKYmxQTmgzVkpBdWdldUpC?=
 =?utf-8?B?cWd3NmN4eGkwNDlVa3VTcWZDblZKMjA2R1B6MzM4cnJhUkhFcGVCdHhlTXhm?=
 =?utf-8?B?dVBqR2tlWlJyT1BVT0hoblhmajExTjZ1Z0JNcS95N0p1bm1tYm4rNXV1UEpE?=
 =?utf-8?B?WTJVdDd4TnFGUGdSZEszSW1RUnpGT1Z5ZkJzQ3ZEVm14bnIwSzRNSWl4QUtB?=
 =?utf-8?B?Y1U1ekVhM0JzUjRHd254Z3dvRVRQZU0vaGNqVC9zSzF6djJ2MHRqbVNXZWhG?=
 =?utf-8?B?TytTbCtKcDI3NmpRNHFFWGVTNksraDZ2YjRhbEMyQTlFbjgxMklGSlNHaG1h?=
 =?utf-8?B?OGVNb3lYZFFUclk1cmlmUUZTa01JMGRuYVZpa3UzeHhqWmNUeGx1SCtna2I1?=
 =?utf-8?B?V0wxRWdNSFFUWXA0QjNyc1ZpTmRTTFpWdVV1OVpGM09LeU5VSDVVUUVDNnY1?=
 =?utf-8?B?UmxGYlRQbWVzdE9EYlYxby9HUEtGcEtsMHlnRDBveWxXZnNxSkYwbkNrMmhW?=
 =?utf-8?B?N0RSMG81VW1mczA0VkRsakNKZDJNWkZzcm5ycUVPaXpoUXJOM29Ta2x0MUR5?=
 =?utf-8?B?NFBnd2VacE1TcXpkV3o3U2J6VXNuZmx2TkFHMXA2NUV3a2N6UUJ3MkQ5VnFY?=
 =?utf-8?B?SVZYMThvdkhmV0cwbWxlV3JQdFZQRndzQmpuUFJoYW1QTVphVVVWNkNUU1Nk?=
 =?utf-8?B?MWp0bGxEa1gzc0xOQ0VuR3kvU1F1eXBCVnV3VTU1ZHQzV0pIMEFDYlh2dExX?=
 =?utf-8?Q?HvuiYQd/2GgsWe2MSqd34n7M1PLcXgh10+jHJ2wP58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d072e3a0-47ae-472c-1d0a-08dee998bcb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 15:32:14.3003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+DOqbXGG92/V0RB3U81HQZQQ+2OGc+4c36jkZU33kSVPOn7P3y7GUWVMxsOWVBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDIzLCAyMDI2IDE3OjE3DQo+IFRvOiBDaGVuLCBDaGVuLVl1IDxDaGVuLVl1LkNoZW5AYW1kLmNv
bT47IE5pY29sYXMgRnJhdHRhcm9saQ0KPiA8bmljb2xhcy5mcmF0dGFyb2xpQGNvbGxhYm9yYS5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWnVvLCBKZXJyeQ0KPiA8SmVycnku
WnVvQGFtZC5jb20+OyBIdW5nLCBBbGV4IDxBbGV4Lkh1bmdAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxNi8zMl0gZHJtL2FtZC9kaXNwbGF5OiBBZGQgU3VwcG9ydCBmb3IgSERNSQ0K
PiBDb21wbGlhbmNlIEF1dG9tYXRpb24NCj4NCj4gT24gMjMvMDcvMjAyNiAwNTo1NywgQ2hlbiwg
Q2hlbi1ZdSB3cm90ZToNCj4gPiBIaSBOaWNvbGFzLA0KPiA+DQo+ID4gU29ycnkgZm9yIHRoZSB2
ZXJ5IGxhdGUgcmVwbHkuDQo+ID4NCj4gPiBJIHJlY2VudGx5IGRpc2NvdmVyZWQgdGhhdCBJIG1p
c3NlZCB0aGlzIHJldmlldyBjb21tZW50IHdoZW4gcHJvbW90aW5nDQo+IHRoZSBzZXJpZXMgdXBz
dHJlYW0uIFRoYXQgd2FzIG15IG1pc3Rha2UsIGFuZCBJIGFwb2xvZ2l6ZSBmb3Igb3Zlcmxvb2tp
bmcNCj4geW91ciBmZWVkYmFjay4NCj4gPg0KPiA+IEkgaGF2ZSBzaW5jZSByZXZpZXdlZCB0aGUg
Y29tbWVudCB3aXRoIHRoZSBvcmlnaW5hbCBhdXRob3IuIEFmdGVyIHJldmlzaXRpbmcNCj4gdGhl
IGltcGxlbWVudGF0aW9uLCB3ZSBkbyBub3QgcGxhbiB0byBtYWtlIGZ1cnRoZXIgY2hhbmdlcyB0
byB0aGlzIHBhdGNoLg0KPg0KPiBOQUssIGRyb3AgdGhlIHBhdGNoZXMgYW5kIGltcGxlbWVudCB0
aGUgcmV2aWV3Lg0KPg0KPiBZb3UgcmVjZWl2ZWQgcmV2aWV3LCB3aGljaCB5b3UgY29tcGxldGVs
eSBpZ25vcmVkIGJlY2F1c2UgeW91IGFyZSB1c2VkIHRvDQo+IGRldmVsb3AgYWxsIHRoaXMgc3R1
ZmYgYmVoaW5kIGNsb3NlZCBkb29ycyBhbmQgTEtNTCBpcyBqdXN0IGR1bXBpbmcgZ3JvdW5kDQo+
IGZvciB5b3UuIER1bXBpbmcgb2YgYWxyZWFkeSBhcHByb3ZlZCB3b3JrIHdoaWNoIHlvdSBkbyBu
b3QgZXZlbiBib3RoZXIgdG8NCj4gZGlzY3Vzcy4NCj4NCj4gRHVtcGluZyBncm91bmQgb2Ygc3Vj
aCByZXZpZXdzIGFuZCBtdWx0aXBsZSBTaWduZWQgb2ZmIGJ5Og0KPg0KPiBodHRwczovL3dlYi5n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZG9jcy9saW51eC5naXQvY29t
bWl0Lz9oDQo+ID1kb2NzLW5leHQmaWQ9YTg2NTdjODJhNmRiZGEzNGM5MThlMTNkOTNjNDAwNWEx
MDNlYjAwYg0KPg0KPiBSZWFsbHksIHdoYXQgZGlkIHlvdSByZXZpZXcgdGhlcmU/IFRoaXM6DQo+
DQo+IC0jZGVmaW5lIERDX1ZFUiAiMy4yLjM4OCINCj4gKyNkZWZpbmUgRENfVkVSICIzLjIuMzg5
Ig0KPg0KPiBUaGlzIGlzIGV2ZW4gYmV0dGVyOg0KPiBodHRwczovL3dlYi5naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZG9jcy9saW51eC5naXQvY29tbWl0Lz9oDQo+ID1k
b2NzLW5leHQmaWQ9MzEyYzI3MjliMDEzMGZjMTYyOWYxOWVjZWViYmNlNjBhYWU1YzdlYg0KPg0K
PiBCZWNhdXNlIHlvdSBldmVuIHRlc3RlZCBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPg0KPiAtI2Rl
ZmluZSBEQ19WRVIgIjMuMi4zODYiDQo+ICsjZGVmaW5lIERDX1ZFUiAiMy4yLjM4NyINCj4NCj4g
T2YgY291cnNlIHRoZXNlIGZha2UgdGVzdHMgYW5kIGZha2UgcmV2aWV3cyBiYXJlbHkgbWF0dGVy
LiBXaGF0IG1hdHRlcnMgaXMNCj4gaG93IHlvdSBhY3R1YWxseSAqaWdub3JlKiBwdWJsaWMgZGlz
Y3Vzc2lvbiAoc28geW91ciBlbWFpbCBjbGllbnQgaXMgbm90IGV2ZW4NCj4gY29uZmlndXJlZCB0
byBkaXNjdXNzIG9uIExLTUwgYW5kIGRvZXMgbm90IHdyYXAgcmVwbGllcykgYW5kIHRoZW4gY2xh
aW0gIndlDQo+IGRvIG5vdCBwbGFuIHRvIG1ha2UgZnVydGhlciBjaGFuZ2VzIi4uLg0KPg0KPiBP
dGhlcndpc2UgdGhpcyBpcyBqdXN0IGJjYWNoZWZzIHN0eWxlIG9mIHVwc3RyZWFtIGNvbGxhYm9y
YXRpb24uDQo+DQo+IFNvIHBsZWFzZSBzdGFydCBtYWtpbmcgYSBwbGFuIGFuZCBzdGFydCBkaXNj
dXNzaW5nIHlvdXIgd29yayBCRUZPUkUgeW91DQo+IG1lcmdlIHN1Y2ggcGF0Y2hlcy4gVGhhdCdz
IGhvdyB1cHN0cmVhbSBkZXZlbG9wbWVudCB3b3Jrcy4NCg0KU29ycnkgd2UgaGF2ZSByZWNlbnRs
eSBiZWVuIG92ZXJ3aGVsbWVkIGJ5IG90aGVyIHdvcmsgdGhhdCBtYWtlIHRoZSByZXZpZXcgaWdu
b3JlZC4gV2lsbCBldmFsdWF0ZSBhbmQgcHJvdmlkZSBhIHNlcGFyYXRlIGZvbGxvdy11cCBmaXgu
DQoNCj4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
