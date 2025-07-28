Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7734C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 16:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC9110E541;
	Mon, 28 Jul 2025 16:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMJIxzGS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3202210E543
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 16:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjRlu9tQigdCfFSNfEI4FptIsVmk1j540RSVNi7GnAF0eKSj+u4j1I+BQup83ABS4h09/OKKZa23nVHbh5tcSLekWndURW3+9oBblhrBRVyzeB8TmfxZxPbO0YVuVZfvb2lO41WT4DFpw4Egq/mZLmHsPZu1Sm9DQEqe9wB85jFdtbrPQK5ffMN8NOk1S/epqqhOW+JAdYZaYKCQnM4jvV6PsRW2eAXFRfcy15826UUr9075diEcCmzKCtgMrxY6diLC8rZIP/zG3OChoMT7IXoANdqUM1ayosr/4TBXCcaoPAAKN0kXhUIocx3MYTxUr/mul0nkfK2nTfWhR8i5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anzRk1rimxSzufWIhV3j8hI3hwhuAA5uTjmP1V2hGi4=;
 b=qplr1EOUvvzpoL3n3AGq8JZMgm1phQbBSuVhsPPdFWtdsvjLPcb6NewahhvMY9ndtaGFYnT3S8hJy9YuBN3UXncWZjByuciytkRqnso5pGGDdTGOEyPPY4m8v74QEQbO+wHFJQZWOtp0gvMbhv6NMPrIGEjHB8xT6gpXqWejTweJQucxpkRGNTwTIcUjhWw7mXEfIMjL7niscfXO1fZrLcnJmjYQqd/xOejB2tp7cynHSJc4dGcE+G0xS3pBMBQPsFJxzvp4E/EFj2bRQWHi/jkNDB8mT4t9Q1r+ua2kjPlyUq4h0s8zUIliiEIMD1Lar8bwME65KWfmPF8qK20XTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anzRk1rimxSzufWIhV3j8hI3hwhuAA5uTjmP1V2hGi4=;
 b=zMJIxzGSqMvr3pfTFLn5/v4PLMol7A9bN/z3Rl9l56fSZMecLwbcisLiBWn1uGB2oBLFrKtE0NNhqd/giEHnLVKa9sjH/ynWPAZlkI58uaU7NXJuZaIfljJO1ODd1rS9w0/5ZuqTeiw82mNQon4V7NzBvJV+GaOt4trN2Z/oots=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 16:34:25 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 16:34:25 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Thread-Topic: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM
 mapping
Thread-Index: AQHb/KNEKKi0fpTmbkeQWpqRagoIIrRHtHqAgAAND9A=
Date: Mon, 28 Jul 2025 16:34:24 +0000
Message-ID: <BL1PR12MB5898C2EAA50714DC0CA832D0855AA@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250724135954.91568-1-kent.russell@amd.com>
 <9d629ae8-e41c-4fd7-a979-c329852a50a5@amd.com>
In-Reply-To: <9d629ae8-e41c-4fd7-a979-c329852a50a5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T16:33:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN2PR12MB4336:EE_
x-ms-office365-filtering-correlation-id: 93883fc6-fb42-44ec-4bbc-08ddcdf49d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RDdIN0pZOGQxUmJtZTFjMlBTRGJDbzlTYTVscWtBL1BmSjBSdmpGa1BtdEhE?=
 =?utf-8?B?RFlRWHB3dGpkQWVlMmluQ0JXWnpaK0ltN2R5T3cvM1YvRkRzaEZHbHI5VGpk?=
 =?utf-8?B?OFBWSzRJUlNjdTRFSUFza2tMY2ZueU91eEZJb3hRWTM4QzdpMEJPMWhtQmo5?=
 =?utf-8?B?OGxhU29SeG5Qd2xXZW1zUnRTQUhLWDRCbjJrbVplVEtDV2hQd1JuSWl0Qkdr?=
 =?utf-8?B?SmtjTENDZlVhSlBoZmdLU0ZDY2VidVp1YnlBZy9PSVRHcXo0WFR0aDIzZVph?=
 =?utf-8?B?bTlUU0IyZUtCMVRuTVZGdXc4L3ZWQTRNQmxxdVFlRkdoYkp6TEJOcFdQNGs4?=
 =?utf-8?B?RUE0QlN6eUxpZDF5bDRueXZpN0tMK0VYNVo1cmhPa2NKb1RIN2tnamFWU1lI?=
 =?utf-8?B?dk9ROXl4bHRFa2FEN2FSVnZ4YU1peklLL0QzNXZqanRjMjRVSUtNMldiOFVy?=
 =?utf-8?B?dEpUaGhlTWo3VUhzY2U3N1ovVHdXaXJFUzV6VWVnejJKbUpSUzNPRXlrbTlm?=
 =?utf-8?B?R3RLOHZPMy95QUpiSE9NTVpKLzdab0lkNVlDZWZLSkxzOTdWMGxGSzgwU2s3?=
 =?utf-8?B?cSs4OE0vWDJMd29hM0JZMEs5Nmg2T3laWTcrYVZKTEhWWDBmZkFRTlk0ZElG?=
 =?utf-8?B?Q1A4UEcrakhEVUJ6TkxmTllDblQyb3M5QzdpbHVsUzVWVktkYzJCQVJzYStN?=
 =?utf-8?B?M2M2cnBuMk55SFlyMXJHVXdrckd3S0tjMEcza1J4c1h6aUhOdVRsQzNVQnVV?=
 =?utf-8?B?OXlOVEcrai81VUsva1ZraU5KY3BNNG5ZQ2p6RFU2OFFrYmpxeno1SnVoblJV?=
 =?utf-8?B?OVZOZ3JwNVRpMU9SYm45TlRXU1VLY3JLVG1NbzNuTzduWDlIRVMxZkx0Tjly?=
 =?utf-8?B?SktaQi84dVdhem1VNk9vcE5qWjcxSTJZbS93b0dHbWlwQzBKdEhOMUVrRFVV?=
 =?utf-8?B?eUsxcmxrK2tLU21BNXBLTjhjUnZFMEQ4N0oxV2g1VnFlM2ZaOTR2eDNtcEJ2?=
 =?utf-8?B?NUd3bDdxOWtLaGJ3L1FYeVpkdURkb0FDRldram9mdjRaRGx5NFF3Qnc5dEM1?=
 =?utf-8?B?SFJoMlVSS0N6NFZCQ2dlNmJlaWRqT0EvNTFZZ3ZoV1pRWHhmR00ydVJ2M1VG?=
 =?utf-8?B?Z1RIQWlQbTZRTUxONWxaMG1EV2QrVHhiYmRBTkZWc3NnekFaRGFLTERUQU0x?=
 =?utf-8?B?U2lVUkFSRmcxUjJmOTlod0N6WlNpdmJ4cDNrNStzME5RRVh2UFNTVnFGanBX?=
 =?utf-8?B?TENyd3VGZVlmM21IL1JMUzBwZkIzY2xuOHhvdWNzTzByYVB2ZzBZV1RHbGN4?=
 =?utf-8?B?UG1GaGIwc0RLWHQwVENMbi9jK251dURBM0ZFaXJsTkdrZFFRY2JSWk9GNUR3?=
 =?utf-8?B?SkJZc2ptek9OZzRaMGZIUlhuSnpMNHY5UnlWTE9tUm1kTFY0UGMyUXZ6ZGdp?=
 =?utf-8?B?OEY1Ym1MK3pxWmJXOUp5cHlOYVJ4Q2gwTnR4RERpRFpaSjYwekh4clN0T0th?=
 =?utf-8?B?NUkxT2pWaFFOUDFVS1RrSUt0bzkydXNjZW9RTjNPaC9US1p1REQ0c2xsV2ZL?=
 =?utf-8?B?ZVVYc2xXcEpnYTlyeVpEeDRxM25OWVJLNElJMklQR0hMdGtYbEhQOGNXNzVm?=
 =?utf-8?B?dXFzQmp0WkxxbENKcjdtR0tqNWZoR3I2T01qaDNYbmQrZTJlQVBrVFlpcnZX?=
 =?utf-8?B?dGRZNDBmTHdzS083Z2EzampTN1FieFFITmRpMi9yL3JjL1JLV2kzMHdGdzNE?=
 =?utf-8?B?M0R1M0RHWmVNSUVvR0thZGlSUjhTcW5HMGxHaFpCckkrbmhtcTFWYmozL01F?=
 =?utf-8?B?ZDRZOEsyNUZPWjJNbkQzRmdjbkc3eU1TUHRNRjdKZWJZYU1UK1lLcHUxcm1i?=
 =?utf-8?B?K0Y0ZkdFbXFXSHloSzJrbllLUHhxL3V3MmJkYlVJQnFIdTdqc1l4aXRIV3dz?=
 =?utf-8?B?TDROTDlJTGJnNWFQVWM5Ny9BT1dHUVA5S3NpTzZGZkUrUVBzM3gyWkpqeTVG?=
 =?utf-8?B?ZmRDaHluV2RBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1FnK1EvdUJOcW1hcWk5V1lHNzNUdTl3eWNRWVlWK2xkU2FTR2RpNGxIM0NU?=
 =?utf-8?B?OUoxYjhwbHdSTFNjK1grTmpYSXIwMTRwejQvejNFWXJTS2tsUTRjZkVseEhT?=
 =?utf-8?B?Q2d4ZVBmaDJIZzQ3ZWNJdEttVGdscTdkVGJaTUZGVG10WlRhYlRzanhYV1NX?=
 =?utf-8?B?OGdlbk45NW5uTlhZUk5KQ2NqcFgzT1hmSWF2dk5FODQ4YUJFN3o4cnVHYmEw?=
 =?utf-8?B?YkxvcllTQXFPMmZ1dUxadEhLOUtTelUzV01PK3F6azhIcHlicVNPOXU4TGdC?=
 =?utf-8?B?L2FTL0VIcGgwdjZKM1hpVitjRVV0cVQ2TkpDa2ovd3lleUpEUTF3eXJkRWFU?=
 =?utf-8?B?ak1zVTc0c0E1bDdSVjhQaUZEKzdWcmdWU3hudVl0eVlWWDBueWtUTnBuTU1i?=
 =?utf-8?B?bW5IdG5pcm8rRHlyY0VYeUlJOWgrYTM4UWtCbCtpT3AyYmhpa2tDNXQrMS9w?=
 =?utf-8?B?djVBOEZxdXZLaE96VEYrZGsxZk10amNqTkJsNmJCT2ljaVlUZDM5V3BrSDV0?=
 =?utf-8?B?d0h3cFVxTkNBRk5ROUlrTTUzOUtaUEpXMkpJZVNKTmxhdGtucEdxWkVVb0xH?=
 =?utf-8?B?SVlvNE5HNzZvRG50VDEyUkRHSS9PUnFPdVhXeVFVYlBUYUs5UVk4a0U2UTRp?=
 =?utf-8?B?M0hidGI3TUYrL0Y1TkZHajdZM0ZsSXl6bDhabFA4RE1NOUliZWJkUnpXUUNq?=
 =?utf-8?B?d2J1VWIwclltWEZQbG9JaVpFbnl1Rllabklqbyt6S25MZFlXRitjQ0szcUh5?=
 =?utf-8?B?a0lNKzdqdmUrRW1pN2JGR210ZHZOK0daU3Z1UjlsSWgvakZtZW9XK1REY203?=
 =?utf-8?B?dXhDK2hBNWRDYnpEdGRJV3RZSUJ0dHZrb0JKMnBoUU5yNld2UEVVcXhJU2xx?=
 =?utf-8?B?UnRuNEFkNi9QRHJ5eGNlbHlhOFJYMW5TU3lJdnRNQ2VoQlZBdUxSVFJCNzAy?=
 =?utf-8?B?cExlT29nUlRRTE1MOUJFaWJwMWVTa1NiSTFsZXc0b1dNejZQYldjeDNwcUR2?=
 =?utf-8?B?ZkE1VXdqZUh6K1UvUFJuWFdYeTJPMTRzMkJXbHIvUGx0WFV4MXJ5NWtCVmQ4?=
 =?utf-8?B?aGVlZzg0cS83MStIcjlXMDBKSEpnTTRqQVJrRUlpdmg3NUtZY1V5YVBQNFJP?=
 =?utf-8?B?cE43VGI3cmwxY05JakJiU21IMDZVRFEwdGhpNDVBTFVTOWRIMlNManFHTkRK?=
 =?utf-8?B?M0Nqd2ZkWWZOaXBqazY5ei9pSi9jTjdnSEV3b2w4UHZ4a1NzWDdBdVk4WURW?=
 =?utf-8?B?V3pvdnhQZzhTbUtvejd6cmZQMDFwdkk1bU5rcHJjcGpDUFV4UVppK3lnUUJB?=
 =?utf-8?B?NGRpL2d5TnNJU2NYR1hNeC9LVm9FR3BiN1NmcU9CbnJtbVRSVzJpMENZeVpC?=
 =?utf-8?B?NWNDNTFNWHBHR0tUMjRyaEhKRjU3elJMalMvYUN6S25hd21ISVpRblB4K2Uy?=
 =?utf-8?B?S3ZzbDNqMmQ2TzNGVUxueWlaMDYwR0xsb2pCK3BRUU9BdkVhZmlRa0tLN2lS?=
 =?utf-8?B?cVU2VmxZWXJoaVBHdnRiOGl1RTJJVFFpaGJuVkJ2dnhQMForVWc3bHRXcWlp?=
 =?utf-8?B?ZjRMK0tlMkRPVWdlTDZUU2h1b2dVc0NlVTk1VExXNzBxeGl0SjZzWFBZcUNK?=
 =?utf-8?B?R0N2YzdhaVVwbEJkOURkYi9NT0NobVpUZVpMVXBYN1dPVnBOcGtkbXBaamNw?=
 =?utf-8?B?cFNNWXk3cnh6TUpYUG1LQTUrV3FSZG1HTmNIMzRLYWhYcTdKQlkrQjcyZzFy?=
 =?utf-8?B?Zlo2bkM1dld6YlM4LzB6WlFtdlMzMFhxcktVRlgydTlYQ3VvWjE1dHFQMVdw?=
 =?utf-8?B?aFVUZjlJbVhYb3l5VXE1emtxbThzdzlJQ1dzVWp1RlNMVURwN3ptbDNsWDZX?=
 =?utf-8?B?ZENzblp3elJYMWk4TEprOTIwSkJoYnFvUVFacWhHSmpZVVJmeG5yNnVlTEpy?=
 =?utf-8?B?ZUlodXVkZEdWUWlFck5mN1BsNGhnNFNlWFBWWnJadXE2RzNwb3NjVmFrcnM0?=
 =?utf-8?B?SGh3TmYyTWRrL1NUdTJOZnNITGRLRFEzTEo0RUIvcGw3bmlFK2pUZEViNjhD?=
 =?utf-8?B?TTNJSWhsaExHTkI2Q1JMUndDSnFQaXBvRENsL3VEM0Y3NTVUeWFWL0FQUEp4?=
 =?utf-8?Q?8zjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93883fc6-fb42-44ec-4bbc-08ddcdf49d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 16:34:24.9684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJ48hasxsISst+kM5VDjCUHV+WCELOpY7GdSHMFzF/uwg2P1iZW8Ber9GydGgpzNo1XRr07jNrRgf50Vkrv4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyOCwgMjAyNSAx
MTo0NyBBTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5n
LkNoZW5AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogSGFuZGxl
IGxhY2sgb2YgUkVBRCBwZXJtaXNzaW9ucyBpbiBTVk0NCj4gbWFwcGluZw0KPg0KPg0KPiBPbiAy
MDI1LTA3LTI0IDA5OjU5LCBLZW50IFJ1c3NlbGwgd3JvdGU6DQo+ID4gSE1NIGFzc3VtZXMgdGhh
dCBwYWdlcyBoYXZlIFJFQUQgcGVybWlzc2lvbnMgYnkgZGVmYXVsdC4gSW5zaWRlDQo+ID4gc3Zt
X3JhbmdlX3ZhbGlkYXRlX2FuZF9tYXAsIHdlIGFkZCBSRUFEIHBlcm1pc3Npb25zIHRoZW4gYWRk
IFdSSVRFDQo+ID4gcGVybWlzc2lvbnMgaWYgdGhlIFZNQSBpc24ndCByZWFkLW9ubHkuIFRoaXMg
d2lsbCBjb25mbGljdCB3aXRoIHJlZ2lvbnMNCj4gPiB0aGF0IG9ubHkgaGF2ZSBQUk9UX1dSSVRF
IG9yIGhhdmUgUFJPVF9OT05FLiBXaGVuIHRoYXQgaGFwcGVucywNCj4gPiBzdm1fcmFuZ2VfcmVz
dG9yZV93b3JrIHdpbGwgY29udGludWUgdG8gcmV0cnksIHNpbGVudGx5LCBnaXZpbmcgdGhlDQo+
ID4gaW1wcmVzc2lvbiBvZiBhIGhhbmcgaWYgcHJfZGVidWcgaXNuJ3QgZW5hYmxlZCB0byBzaG93
IHRoZSByZXRyaWVzLi4NCj4gPg0KPiA+IElmIHBhZ2VzIGRvbid0IGhhdmUgUkVBRCBwZXJtaXNz
aW9ucywgc2ltcGx5IHVubWFwIHRoZW0gYW5kIGNvbnRpbnVlLiBJZg0KPiA+IHRoZXkgd2VyZW4n
dCBtYXBwZWQgaW4gdGhlIGZpcnN0IHBsYWNlLCB0aGlzIHdvdWxkIGJlIGEgbm8tb3AuIFNpbmNl
IHg4Ng0KPiA+IGRvZXNuJ3Qgc3VwcG9ydCB3cml0ZS1vbmx5LCBhbmQgUFJPVF9OT05FIGRvZXNu
J3QgYWxsb3cgcmVhZHMgb3Igd3JpdGVzDQo+ID4gYW55d2F5cywgdGhpcyB3aWxsIGFsbG93IHRo
ZSBzdm0gcmFuZ2UgdmFsaWRhdGlvbiB0byBjb250aW51ZSB3aXRob3V0DQo+ID4gZ2V0dGluZyBz
dHVjayBpbiBhIGxvb3AgZm9yZXZlciBvbiBtYXBwaW5ncyB3ZSBjYW4ndCB1c2Ugd2l0aCBITU0u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5j
IHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9zdm0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+
IGluZGV4IGUyM2I1YTBmMzFmMi4uNTk3YjhhYzkyODQ4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+IEBAIC0xNzEzLDYgKzE3MTMsMjQgQEAgc3RhdGlj
IGludCBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChzdHJ1Y3QNCj4gbW1fc3RydWN0ICptbSwN
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgbmV4dCA9IG1pbih2bWEtPnZtX2VuZCwgZW5k
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIG5wYWdlcyA9IChuZXh0IC0gYWRkcikgPj4gUEFH
RV9TSElGVDsNCj4gPiArICAgICAgICAgICAgICAgICAgIC8qIEhNTSByZXF1aXJlcyBhdCBsZWFz
dCBSRUFEIHBlcm1pc3Npb25zLiBJZiBwcm92aWRlZCB3aXRoDQo+IFBST1RfTk9ORSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAqIHVubWFwIHRoZSBtZW1vcnkuIElmIGl0J3Mgbm90IGFscmVh
ZHkgbWFwcGVkLCB0aGlzIGlzIGEgbm8tDQo+IG9wDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
KiBJZiBQUk9UX1dSSVRFIGlzIHByb3ZpZGVkIHdpdGhvdXQgUkVBRCwgd2FybiBmaXJzdCB0aGVu
DQo+IHVubWFwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAg
ICAgICAgIGlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9SRUFEKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGUsIHM7DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJWTV9XUklURSB3aXRo
b3V0IFZNX1JFQUQgaXMNCj4gbm90IHN1cHBvcnRlZCIpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzID0gbWF4KHN0YXJ0LCBwcmFuZ2UtPnN0YXJ0KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZSA9IG1pbihlbmQsIHByYW5nZS0+bGFzdCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChlID49IHMpDQo+DQo+IFlvdSBuZWVkIHRvIHRha2Ug
c3ZtX3JhbmdlX2xvY2socHJhbmdlKSBhcm91bmQgc3ZtX3JhbmdlX3VubWFwX2Zyb21fZ3B1cw0K
PiB0byBiZSBzYWZlLg0KPg0KPiBJZiBzdm1fcmFuZ2VfdW5tYXBfZnJvbV9ncHVzIHJldHVybnMg
YW4gZXJyb3IsIHdlIHNob3VsZCByZXR1cm4gdGhhdCB0bw0KPiB0aGUgY2FsbGVyLiBJbiB0aGF0
IGNhc2Ugc3ZtX3JhbmdlX3Jlc3RvcmVfd29yayBzaG91bGQgcmV0cnkuDQo+DQpHb3QgaXQuIFRo
YW5rcyBmb3IgdGhhdCENCg0KIEtlbnQNCg0KPiBSZWdhcmRzLA0KPiAgICBGZWxpeA0KPg0KPg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2bV9yYW5nZV91bm1hcF9m
cm9tX2dwdXMocHJhbmdlLCBzLCBlLA0KPiA+ICsNCj4gS0ZEX1NWTV9VTk1BUF9UUklHR0VSX1VO
TUFQX0ZST01fQ1BVKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciA9IG5l
eHQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgICAgIFdSSVRFX09O
Q0UocC0+c3Ztcy5mYXVsdGluZ190YXNrLCBjdXJyZW50KTsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgIHIgPSBhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlcygmcHJhbmdlLT5ub3RpZmllciwgYWRk
ciwNCj4gbnBhZ2VzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlYWRvbmx5LCBvd25lciwgTlVMTCwNCg==
