Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B9CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 11:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF04E10E1C9;
	Wed, 13 Aug 2025 11:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HyOPh5XY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C365110E1C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 11:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHqP7d9ReouP2iXsZvSlJh5QU+rfMa85rXIsZUi5QT2Da16aABl/bz79Dv2fHW+QLd/b3sqR9QxGi/p2e7muxMN5xEJFDt+m/ICQdhti/33aPSB1rLkfWHIBP9cxZ64Z+iIUEQRoc91HxugGEm1Cv+s9IKEj6T5XuPzkFWCvX6A8cfAFg68JT81bzUWd/1Q5rox1uFzkhChen6ot76pnduF7y1MoONCSkns6BasDSEAWq+SPJe9NGy7emfXCHN7fK+cAsc1DuJSj5uDrN5tvhzTnUvt1klYzv3frPCDwwO9ukZ9kj1SFybVVXAGm+RFucZUQAlmdLkFCGnP/vxcAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZQD7dsbJBxTCklRW6yQvqM87emU3LOhOZ2drWWBMn4=;
 b=bv2gx8HYOYSeB1Aj4bgnzB56Zw56qrVa8Rzb2Q5QQy/arZrhVveMhki+gGBhIXFNmOiRFyF/RbV2TWiznIdff5oJT59Q9570TXNLFy4N74Oe/n4hp3MM454tvBnRl2KAQs8Y5si2ensY1LvzZCYEUjs8T4rU+FgKyK3dk4QnB16rcg+hWC81Byw5zgdjJR1b45F04KOnB9oZniWrmW1BNEW/9v9OyC3ppdexnw21VC7/vj9KMSr4qmVPJ3iAQwIhyTi5R7C3fdFgwxRvECYtWqyEeuz3MNMdX8v27ZDa9LWa8GHh6wvSSdEr+TFqik9PrijetJYp3N/RbHnPrObzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZQD7dsbJBxTCklRW6yQvqM87emU3LOhOZ2drWWBMn4=;
 b=HyOPh5XYNe+FElkebuGG386EathOu5bEKf8s2we0ncMZGdHDRdBX8/k1gorOeaYni7y2yaCUq+BXp2S9KzD43KM6OHcukHoTot+xcS0jRx2FVWKA5Y9pPe17+H7K2lNXzxi4RbmumOg6KvbG9SnLSDHrOuZhrZDaZBa2tY7D1vo=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 11:16:41 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%7]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 11:16:40 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swm14: Update power limit logic
Thread-Topic: [PATCH] drm/amdgpu/swm14: Update power limit logic
Thread-Index: AQHcCKMn91lmrjLJMkiyxsH1afH8RbRfTsgAgAEnPqA=
Date: Wed, 13 Aug 2025 11:16:40 +0000
Message-ID: <DM4PR12MB516550C0000B5AF6AC4D0B178E2AA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250808202912.2067194-1-alexander.deucher@amd.com>
 <CADnq5_MiUK-wPHthDU__j0e=vM7_829=CzaMXQdRHM895tzNzQ@mail.gmail.com>
In-Reply-To: <CADnq5_MiUK-wPHthDU__j0e=vM7_829=CzaMXQdRHM895tzNzQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-13T11:16:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH7PR12MB6561:EE_
x-ms-office365-filtering-correlation-id: e2cb32a0-16db-4c5e-32ad-08ddda5ae0ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?elpoOE5zcEQ2cTNsNEVmTXQzVWNsSzJRYzRYMjFORHUxd0djMWxJaWVWcWpC?=
 =?utf-8?B?SWlXV3ZZV3A2THhMRHJNNDVsVm4yNHQwV0FCVjVQWmpldytYdlNZV3VCTzh1?=
 =?utf-8?B?Y0lQdWxHbkJXSGF1dlRkUHhXeElRRmR6cFY3clRrQVZVRTRvMFZHWGd6Lzdt?=
 =?utf-8?B?bmYrNFdiK1JETFBjWks3d1UwWlo5dHM1bHJIKzN4NkZlREdnRGR5WlM2SUxH?=
 =?utf-8?B?Q1VHV3RydGt4TnVJNEFIU2lqT0NOQ3lheHBmVmw2VVBQRVQ0WXlzb1daNnM2?=
 =?utf-8?B?bDFuVklxQU13V2Vmd1VmOExXSXV0MWFTbkFaZVhvcUdwVW43eTFDNWhJdG5s?=
 =?utf-8?B?Ny9NQjdveWxTdmI3b3gxYzhhKzdmQmluY3ZBR2UzSWRZbTF5dWFGdlF2VGhY?=
 =?utf-8?B?OCs1SFhnR0FOS3JsZTgrRXlmT3pIbkZ0K0krVkIxWnU0MlljTThDSTk2eUtJ?=
 =?utf-8?B?Q2YwanlyQzF6RmZ4MWxPbnRneGVPQ1czaExiaVlicFpITzFPZmtaS3RmY1oy?=
 =?utf-8?B?aHFtUldqTkNkL0NUeE0wVDRoeUEzSTNHWGg1L3pNanBNblAvaUtjaDdEdzZo?=
 =?utf-8?B?djlpcXgzTldyTCs1S212ZG9xNkZQcWRnRXk4akMxYUQzZm9hNVQ2d3MxRUYw?=
 =?utf-8?B?bGdzY1pRNDV5L3RHTVhhcEg0MWE2SDB2MitTWWtkdkpRTWYyMU84MjlwVStG?=
 =?utf-8?B?VXlKTHpmWDlJWEdKU0ltSStLMUozNGZDanR5MTk3T0ZISzRTcVU2ZnhzODBJ?=
 =?utf-8?B?aE1uN0V5K3Y3cG1WbTlSaWZIOHo0d0p4RWVTYUQwdzdVL2ZjSUVvU1RFbUtU?=
 =?utf-8?B?UDJFSU5Pc2pxWnN0VVZTWDFTRE5EaU8yNW5kWXh2SnZYU2d4TzRoTko2UDRC?=
 =?utf-8?B?ZzI2VUJHWmdlNU5GaFJ3L1AraFpXaGt1QXYrdU1SM2tvaWpNRFZBd2lpc3ds?=
 =?utf-8?B?OXlacUUrRkwzdnd3eENlV0ZTQjVaUmdqbTlQdTJmSms1Z0h6QVF2NW5TeUJJ?=
 =?utf-8?B?amhVdHQxaGluVjhHL05BYlVuZWxCa3pRVlQ4ODR5VWVlYW5JTHJTV1UrOW9E?=
 =?utf-8?B?VEhRTjBLYStqck9UZ29YTVJTVWQ2Q08yWGt0cHZwQ2NPOWJqVXJtQlpyYUR0?=
 =?utf-8?B?L1lHWVBSdGJvZHFIVzlIYjVyNG5TNWdWeEUxNmZQejFYTk51Z1FIS1hVS3Fs?=
 =?utf-8?B?Y29yUGlBNzFFN3BEanJpNVZKY1dCcDJ3SXlZbUpPeE9Vc29UOVp3Z0JrRi9D?=
 =?utf-8?B?RGlldFE4K1c0dnJpcHdOeng0d0xkcXhFSytjbmhwQjBpemwyT2xhZjdHVE5U?=
 =?utf-8?B?RVY5THVOaXZ2M1BZN3Q1WE1UeFFuNExWUVU5TFZvN0NScHptYU81WVJMaFU4?=
 =?utf-8?B?Uk9sVkVZNE81bzJyUmZWaTlyb282NVZhNThSNDFQeGdVK3FqQlh5aHZlQjhY?=
 =?utf-8?B?TU00Mkp5RGJMeTRMNzVkRUs3RGN2T29RWmVJZGZaVDJJdVZpdWw3ajU1RFlu?=
 =?utf-8?B?aklKbElVVUNPT2xTL3hHcUZrL3ZUR01ERGFXRXN3c0dybFJ2ZGdFeldkVE1C?=
 =?utf-8?B?ejUvWkZvaEJrcjc4cHF6WnhZcFNBRm9JMEZ6cEk1L3Y4UEw1b1ZzWGVsM1RL?=
 =?utf-8?B?Myt2OEk3cnY0NWhlQ0lBMFZFR1ZKaXQzR044aU41WnlzTDVxdkRqS3ExVSt4?=
 =?utf-8?B?S0VIOUtxVzg0Z1Fza0ViVHRKTFdDY2doUHNJQnEwWVBVZXN0TWhWUVYrTzRC?=
 =?utf-8?B?cVhvdmVPZXZkU0FrdytlSDVVUUdFUXQxUDVhci9VdEdGUUpaaCtkaHBFL05N?=
 =?utf-8?B?QTlYQUVQTldOTGdma2M2RU8ySFpEQmYyNWh1Nnk1VDRuRTNRdGZGWGx0TGVz?=
 =?utf-8?B?YTVIRElldzBSSkNRMzJQYTFhd3RlRUtDQi9YejdseFY0V2RnSTUwbDR2R2Nh?=
 =?utf-8?Q?1lF8rsdOc2w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRLY3E2bDF5VUdJd3ZYemNqTzd2dTd6TnM5c3V6N3Q5WXloc2ZqODZEUGwz?=
 =?utf-8?B?SnpmNWVWQy9vKzZLMDB3WkJCS25HMTNjTUZFS1d4WG5CbzFzUnArM2pobjhy?=
 =?utf-8?B?RGN6NzhoTzJkbkMwV2ZiNU9lSUMrRkFxdkNFaUlIWVNaSjZyb2V4S3loR0ZB?=
 =?utf-8?B?c1NxYyt6cFY1azVUeHNTbmlleDllZnp4RmxsVDZraDI4OHlUQnIzUFY5STRw?=
 =?utf-8?B?SnphVkZYRzdvWjk2ZmxWc2I0NUtBS0pyNnV4aHVkNUEvbnpMemVuRDBsbFVy?=
 =?utf-8?B?WE1MeFVXbnNlSWtLajlHRHRSdjcwbllUK2xqSllPMmNXSm1RR0hVVkFpdWJx?=
 =?utf-8?B?Tmx0dUtSNFdXenN2SFY0bE1IWUpNbDdCcWJFdlVXNTR5NFU2UUVWT3hTSnl2?=
 =?utf-8?B?ZFRhUlNQL2lkMUV1ZnJBRXp0Wm9BNUQwZkwwZXZvTklEUVZqWHJnSnZRdHhZ?=
 =?utf-8?B?eXRpWGRLTDFrVE0yY1Y4NHlHR2hBN2ZDaXowZDcvRC8vUUtoUEJFS3NMMWxq?=
 =?utf-8?B?dW5xTlpxVVZud3ZObEpMUVYzKzlrL0JvcnlDc05maFhicXFyQkdUb2FlazU1?=
 =?utf-8?B?enh4MzVSL2htdGkxdi9zZVFwUXYwVEVnTTIxUDk3aG9Vemt6V0k0a2o0WVho?=
 =?utf-8?B?ZURCYTRqREF2RE16cHliYlo0NEFMaVgzMUxTZkRnOXJKNUFBa0ZyeFByNVJQ?=
 =?utf-8?B?TGNzeHM4QmNydUFlN3h5MFlHb0c5RDZocUErR2xnTThXckR0RUVuU0twWndS?=
 =?utf-8?B?WHVWZmxuZHZXb3pEdk1ERFpSQUZFS2FaRGtuZW5MblRXRFExQXRZZTh6L2xG?=
 =?utf-8?B?M2ErVTY5bGtQMFg5SWRNUnpNbWZDb251cHBPczRrVVlUUjM3NjhvQVJtY0Jk?=
 =?utf-8?B?OFJlOEliQmFOamV1WmZxSUtxK3NrbWxLUzF4c3JNenlUdjRyTjVnSUhDaThx?=
 =?utf-8?B?K1ZqOFR6Y3J6YjhqRW1CUHpkWDB1c3lCaVVNdzhuVEY0eTZDOC9WSTZaK3lh?=
 =?utf-8?B?QllNOUtZQ1pCTG5PSEU0Z1dGcFVENytYdmJ2Qy9SdkhQNVk5WXY1a3hzM0pt?=
 =?utf-8?B?bEdJckY3RlRWcDNncHhxdW1KV1BNbkpsZjk2Zk9vbUhqWHNjNE9NbUhGZk0r?=
 =?utf-8?B?ZUdsUDE5N3NPT0hpQ2M0NENlYnpzR24yVGlHYlp4QTNSZjN0aDcwV09JdVdl?=
 =?utf-8?B?KzNzdDJCT1B5S0RZTjRvU0UwOGIwNk9tcEVCOXVwc1NXWHVCWlJSR2lLN1RV?=
 =?utf-8?B?UXlXN2o1ckIwdzNldGY4YkxlMnhWQ1R0Q0JwWEo3dWp6eW1RWTh6eEJqdFJw?=
 =?utf-8?B?WThWMGtJaW54YStVdFNxQUowTlBPcU91WnVqdnpSMW92blRxNVppL2J5VEox?=
 =?utf-8?B?OC84NHdGaHpKWmpHTkRaMDgrZFJESllEalhQVHRrcjE1eHBJQ3ZuSk55Unhy?=
 =?utf-8?B?OTY5bkY4UmUyTWRmc2E4ZHp6VHBsT0RNRXUxcHNVMWlvR2RONGxVNkFzb3Va?=
 =?utf-8?B?MldBYVArVUk5WDJuSmxJdlJ2TmVrTlgwRzVZc1BoWE5yZm1QcnR3bmYva1Nq?=
 =?utf-8?B?RkRwMXMxZEU1K3dRSHhDakpmTlhjS3NJL0xDTEdpSHZRR0pZM1ZDWVlkWDE4?=
 =?utf-8?B?SmdycnRHVFAwWS9sVUJoSy9RTE1DQmFmQmNtMUxCWHBiUGluVUxCUGtqcEFq?=
 =?utf-8?B?V2NFY25aaUlRWmRTalBzQmlZeDNRV2hkY2ZYbWVtNkRrV0hkbmVIQkM2VG5n?=
 =?utf-8?B?dkpQc1VMZ2lkSjdRWEU3dlRzd3FoQzZRTklVSmduSXZiSlBXS2VBSlRDaXpC?=
 =?utf-8?B?VDk2QXZqMG9wVVZKdEpsODhkNmlyc2dVQUd2b2x5L1VPZ2pPRkhuaGQrNk41?=
 =?utf-8?B?UlRicGZ0ZWRCeVFxbnlKVjlhYzh4SnlETklxMlBMZmZUZVpEdGJkK3RYN28x?=
 =?utf-8?B?VFREckxvTzg3MVVWK2gxTnE1WGI0d1dzNjFrZVhramVKUFFveC9BSk1NYWpE?=
 =?utf-8?B?U09DWkt4Qy9veEx0MUlOVUxnUGM3VjlNbEg1RkhmZE5xUXpnQ2VjYXBWUzZQ?=
 =?utf-8?B?ajBveHFpcllHWjF3UEpkQVhia0ZUOGkrVVVoYnZhL3IxbTQrUXZBK1FUNitZ?=
 =?utf-8?Q?iG+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cb32a0-16db-4c5e-32ad-08ddda5ae0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 11:16:40.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI1k6Zf5f3WlxhKzvOk0VSbw1kuYwBpIJBDyDppTV/nAV08EMztD7OqHwa/fsqwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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
Cg0KUmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTMsIDIwMjUgMTozOSBBTQ0K
VG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEZlbmcs
IEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3N3bTE0OiBVcGRhdGUg
cG93ZXIgbGltaXQgbG9naWMNCg0KQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJv
bSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0
YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KDQoNClBpbmc/DQoNCkFs
ZXgNCg0KT24gRnJpLCBBdWcgOCwgMjAyNSBhdCA0OjI54oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4NCj4gVGFrZSBpbnRvIGFjY291bnQgdGhl
IGxpbWl0cyBmcm9tIHRoZSB2Ymlvcy4gIFBvcnRlZCBmcm9tIHRoZSBTTVUxMw0KPiBjb2RlLg0K
Pg0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNz
dWVzLzQzNTINCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KPiAtLS0NCj4gIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRf
MF8yX3BwdC5jICB8IDMwDQo+ICsrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wXzJfcHB0LmMNCj4gaW5k
ZXggM2FlYTMyYmFlYTNkYS4uZjMyNDc0YWY5MGIzNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jDQo+IEBAIC0x
Njk3LDkgKzE2OTcsMTEgQEAgc3RhdGljIGludCBzbXVfdjE0XzBfMl9nZXRfcG93ZXJfbGltaXQo
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90ICptaW5fcG93ZXJfbGltaXQpICB7DQo+ICAgICAgICAgc3RydWN0
IHNtdV90YWJsZV9jb250ZXh0ICp0YWJsZV9jb250ZXh0ID0gJnNtdS0+c211X3RhYmxlOw0KPiAr
ICAgICAgIHN0cnVjdCBzbXVfMTRfMF8yX3Bvd2VycGxheV90YWJsZSAqcG93ZXJwbGF5X3RhYmxl
ID0NCj4gKyAgICAgICAgICAgICAgIHRhYmxlX2NvbnRleHQtPnBvd2VyX3BsYXlfdGFibGU7DQo+
ICAgICAgICAgUFBUYWJsZV90ICpwcHRhYmxlID0gdGFibGVfY29udGV4dC0+ZHJpdmVyX3BwdGFi
bGU7DQo+ICAgICAgICAgQ3VzdG9tU2t1VGFibGVfdCAqc2t1dGFibGUgPSAmcHB0YWJsZS0+Q3Vz
dG9tU2t1VGFibGU7DQo+IC0gICAgICAgdWludDMyX3QgcG93ZXJfbGltaXQ7DQo+ICsgICAgICAg
dWludDMyX3QgcG93ZXJfbGltaXQsIG9kX3BlcmNlbnRfdXBwZXIgPSAwLCBvZF9wZXJjZW50X2xv
d2VyID0NCj4gKyAwOw0KPiAgICAgICAgIHVpbnQzMl90IG1zZ19saW1pdCA9DQo+IHBwdGFibGUt
PlNrdVRhYmxlLk1zZ0xpbWl0cy5Qb3dlcltQUFRfVEhST1RUTEVSX1BQVDBdW1BPV0VSX1NPVVJD
RV9BQ10NCj4gOw0KPg0KPiAgICAgICAgIGlmIChzbXVfdjE0XzBfZ2V0X2N1cnJlbnRfcG93ZXJf
bGltaXQoc211LCAmcG93ZXJfbGltaXQpKSBAQA0KPiAtMTcxMiwxMSArMTcxNCwyOSBAQCBzdGF0
aWMgaW50IHNtdV92MTRfMF8yX2dldF9wb3dlcl9saW1pdChzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwNCj4gICAgICAgICBpZiAoZGVmYXVsdF9wb3dlcl9saW1pdCkNCj4gICAgICAgICAgICAgICAg
ICpkZWZhdWx0X3Bvd2VyX2xpbWl0ID0gcG93ZXJfbGltaXQ7DQo+DQo+IC0gICAgICAgaWYgKG1h
eF9wb3dlcl9saW1pdCkNCj4gLSAgICAgICAgICAgICAgICptYXhfcG93ZXJfbGltaXQgPSBtc2df
bGltaXQ7DQo+ICsgICAgICAgaWYgKHBvd2VycGxheV90YWJsZSkgew0KPiArICAgICAgICAgICAg
ICAgaWYgKHNtdS0+b2RfZW5hYmxlZCAmJg0KPiArICAgICAgICAgICAgICAgICAgIHNtdV92MTRf
MF8yX2lzX29kX2ZlYXR1cmVfc3VwcG9ydGVkKHNtdSwgUFBfT0RfRkVBVFVSRV9QUFRfQklUKSkg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZF9wZXJjZW50X3VwcGVyID0gcHB0YWJsZS0+
U2t1VGFibGUuT3ZlckRyaXZlTGltaXRzQmFzaWNNYXguUHB0Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBvZF9wZXJjZW50X2xvd2VyID0gcHB0YWJsZS0+U2t1VGFibGUuT3ZlckRyaXZlTGlt
aXRzQmFzaWNNaW4uUHB0Ow0KPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChzbXVfdjE0XzBf
Ml9pc19vZF9mZWF0dXJlX3N1cHBvcnRlZChzbXUsIFBQX09EX0ZFQVRVUkVfUFBUX0JJVCkpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgb2RfcGVyY2VudF91cHBlciA9IDA7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIG9kX3BlcmNlbnRfbG93ZXIgPSBwcHRhYmxlLT5Ta3VUYWJsZS5P
dmVyRHJpdmVMaW1pdHNCYXNpY01pbi5QcHQ7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAg
ICAgfQ0KPiArDQo+ICsgICAgICAgZGV2X2RiZyhzbXUtPmFkZXYtPmRldiwgIm9kIHBlcmNlbnQg
dXBwZXI6JWQsIG9kIHBlcmNlbnQgbG93ZXI6JWQgKGRlZmF1bHQgcG93ZXI6ICVkKVxuIiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9kX3BlcmNlbnRfdXBwZXIs
DQo+ICsgb2RfcGVyY2VudF9sb3dlciwgcG93ZXJfbGltaXQpOw0KPiArDQo+ICsgICAgICAgaWYg
KG1heF9wb3dlcl9saW1pdCkgew0KPiArICAgICAgICAgICAgICAgKm1heF9wb3dlcl9saW1pdCA9
IG1zZ19saW1pdCAqICgxMDAgKyBvZF9wZXJjZW50X3VwcGVyKTsNCj4gKyAgICAgICAgICAgICAg
ICptYXhfcG93ZXJfbGltaXQgLz0gMTAwOw0KPiArICAgICAgIH0NCj4NCj4gLSAgICAgICBpZiAo
bWluX3Bvd2VyX2xpbWl0KQ0KPiAtICAgICAgICAgICAgICAgKm1pbl9wb3dlcl9saW1pdCA9IDA7
DQo+ICsgICAgICAgaWYgKG1pbl9wb3dlcl9saW1pdCkgew0KPiArICAgICAgICAgICAgICAgKm1p
bl9wb3dlcl9saW1pdCA9IHBvd2VyX2xpbWl0ICogKDEwMCArIG9kX3BlcmNlbnRfbG93ZXIpOw0K
PiArICAgICAgICAgICAgICAgKm1pbl9wb3dlcl9saW1pdCAvPSAxMDA7DQo+ICsgICAgICAgfQ0K
Pg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAtLQ0KPiAyLjUwLjENCj4NCg==
