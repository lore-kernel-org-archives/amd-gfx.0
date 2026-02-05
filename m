Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E01EC1EB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C5810E8C3;
	Thu,  5 Feb 2026 14:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6jXj2F4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBA210E8C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G71nJML6dmrbrfViEFrXHOcJ8ySonO5Wmf4ALe4llB/8Gk9Ox1vMVnEebkqkbmxAlH7n1YRLc4Jcm/jU5i0ticM7n8SWSFemToRtNI2+I/+brPmyLK+TNy8i2+TOEH11RudJffkYZgWIyW6BuzgCxmmtA96vUGlxgrniEFE1PGoEDDQjk5hkmpem0oBfPgPJlrcfWql0GQ/mhr4lh/LRD9xkCJZ/qqcrOA3o022aVzT5DRz53kk9puT3MO0nmXIHGrGmT0Vh3LrMO5yrLRR+qZ4Z4SDUf9pAG6/nI2IWEja6MLL6sWDYJbXYZC0szsXtdMzCqpHFkuykNOXHrDGT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwiG9/JTY35NOov4R2A+3Wkps55q7HtTh9E/mMMa+WI=;
 b=rwB2MWvxy2PMnDIgpS2lAispYYUk/qKnoANarU1L9ffIMK18Uz1UkAbKxvs6mGC2+v9Y8rAI/fu++QaH3Wh9QAkvUNChMnTOrKIFyu0wfZ6n/JlQo9jqavVFnGxZLUqt05xEwT+g5H3fGcKiNv1dUx0SRfWHAfGcodeGlwsqenuirYnyDZutwvqpGiZP1mfGWHC6hZ6Insh1RtSFUMZUdhVqard30U46MtzIftyWiu9w4Nfk8z1WQSoMAuveR2p/P/NizHSA7Zwfi0RfpgkNqFAIETOKFE2mJLDfP6+a1FOQNDAxb1EH4tRTTmy7XrfKkEcgmdSP4o7dVcZLuLXcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwiG9/JTY35NOov4R2A+3Wkps55q7HtTh9E/mMMa+WI=;
 b=H6jXj2F44FNV8UmwsReeHDTCRNIA0yvvwAlY38o45z1XxXoOStI8rnAQDYG7GKkMG56cKW3aGHlvjMGRTTf1BoftILFk7USsO3+0EJcRusStrgYGShqaorEkbC5X9eeq2PXuFwDjRUfMpNyrb3ncXTXYPauvGvoCx6pz0dVNUxY=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:01:28 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 14:01:28 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure
Thread-Topic: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure
Thread-Index: AQHclpjVFfQ+mUxwxkmbbgSABTGDRbV0EjsAgAAMuzA=
Date: Thu, 5 Feb 2026 14:01:28 +0000
Message-ID: <IA0PR12MB82082717FF7C510104C7BAEE9099A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
 <c6744661-1e2b-4e28-9418-6e10acf8e367@ursulin.net>
In-Reply-To: <c6744661-1e2b-4e28-9418-6e10acf8e367@ursulin.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-05T13:48:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DM4PR12MB6664:EE_
x-ms-office365-filtering-correlation-id: cd5a94f2-44fe-4aef-742d-08de64bf0efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?a1ZFZEMzMjJwUlRycWlXa21VQVhvMkNVRXZtOUJCQWd4QmNweG9CVmxMWE4w?=
 =?utf-8?B?ZzV0emtFWHl0a3JXOVVleHZEaEZsZ0NOTE9UZXh2ODJ1MENhS2R6N3l5N3U3?=
 =?utf-8?B?cEJDNGhGemZlcnJtWXZhRDZDQ3NNWVZDVXJYWlN3bldtUlJWRzhWd0NqNGZz?=
 =?utf-8?B?VU1IM0poUm00ZkFGYlBaeWZwbGJrcFAvQmdFK3h4UlRUdnZVKzYzV1o5TldZ?=
 =?utf-8?B?ZlJwcGJ4cEk4dUEwQkE4cHpQQUdKWm9XdEZtM2NIKzNIbVNiUWxHdW9wditE?=
 =?utf-8?B?cVlaRjIwVndMNHVaS1U3dzZ6NE42MUNhVVdnWk5aUGxjMXY5UGtZd1Fyc1dt?=
 =?utf-8?B?ZHQrY0wvcStGbHVYZko1L25LZUdRZW0xZUdiamlQTE4xSE03cjJzdkcwcGV4?=
 =?utf-8?B?eDgwQkl2K1ZuYzZ4OHZJVCtST01FLzBXek9RanRzbDM1NWpSVUtKYTViNGla?=
 =?utf-8?B?UVI1RFZNdXVLMUgzdjZHeEdGSkthOFF1eEp3WGFXcTJPcnYvV0xDRTRxcjEx?=
 =?utf-8?B?eCt6QVBtMUtBQjk0MmpJNDZobDliN3JsVThqOVBnTmRhMU9EUTVMNjMzMDl4?=
 =?utf-8?B?QldhcHp6N2dJY2xJb3M3Y3BvVlAyY3ZxNmNWNXMxRHBMNTJTWUVtUHNNV2Vz?=
 =?utf-8?B?eFJGMHlWd1RSajBneXZoeVlLRk5HMUc5MTJvY3Nwemg3YlNYRHlIZ3NDeG9y?=
 =?utf-8?B?aUpRZGh6cDdSSzBkZEhHVHNEbzVlc1Q2ZStZbDErOXRPVWV2akFwcDdpeVRl?=
 =?utf-8?B?VzlQeU9IVXFMVnBUUjRaVXdyeFV5RkU2REVsZENMYlcwNVljRTNzd0x2b0Fz?=
 =?utf-8?B?dTZkZW94QmJhdnRPai9kNkd0UkxieFRERHFsNnRPaUxVU0JJM0pZZWJHOGVU?=
 =?utf-8?B?MzhkN1RjQjJ0YldDTVF3b2JGazNRdHFiV0t0YTF5Wk1ZdE9Ield3NGlxNmhX?=
 =?utf-8?B?Tkx6SVVEeDhPaFFOcjVwMGNyS2VwbTJIN2ViOVZoaXR6NmN3dldhcmxxVVM2?=
 =?utf-8?B?V1FmaG0wRS9TSHhzZk9uaW1EeFBYR1VrTVNzR2I0UEJsK3RYa09rTHhyb1BB?=
 =?utf-8?B?bytjR0RDdG9PbmU1R0FyUkhwSmx4bFY5OTF4dyswWWYvSE96VXQ3RnZIOHVQ?=
 =?utf-8?B?cnlNRC9qT29uNFlJbzJ6U0RsanVVbGQ1dEx6aDRYOURjNFlVTEZUWTMzSHlv?=
 =?utf-8?B?NWxyUXdwMWRDeVluc2o0TFZhL1NKRVY4cnZYUXZlc0tkSXlmYzk4WitLWUlG?=
 =?utf-8?B?Q0d2bzdtZXhvMWhXNFk4MHY4amE0TlZQcTRKdXE5UEVYL0lxRVFEZEcvY0Zk?=
 =?utf-8?B?bG1IZnFFR0oycjB6WS93dmdGemJhVUxmd0E4eDdCd1M4bWt6LzBzbGxKejBT?=
 =?utf-8?B?OW1HK1NxOVRKdGFpcFVaWWY2WEZVK2xvZThNdXdYVURvc2k1RllzWmRMOThN?=
 =?utf-8?B?UGwybzJ5QkM2ZnZmbGx3d2puQnBvY1pIUElESlZaVEhsb1NwUURQL0VxWVFq?=
 =?utf-8?B?SVB6NVFlanh1Y1hGcTY2azVYZGlDWnhhYzVNeDNDZHE5aWY3emVhWGdhR3JI?=
 =?utf-8?B?UjFDc1JXb3RMUWIrUC94TUxORVdkcmZLL3BVNHlZajhIZ3NXRU1xbElaYWNs?=
 =?utf-8?B?K3JKNGVJWFpHdHYyTnVCbnBuOWlUSHR6azBTd0M1SDFZaDZOeU9reFJFNEw4?=
 =?utf-8?B?K21FOFVoN21lRGxhTVJqV2RyZFJIVGQrS0JCUnppYlZUc3JpOTVYbU40N0N0?=
 =?utf-8?B?RUE2anMyTis4b0tPZk14NjlsT0JvMjEzT0tVN1VqdmxjVzc1Zk5qTGd4Nlo0?=
 =?utf-8?B?Y1NCUURlenBQWmdzRXY5bnhTek5IaHBWNGUxcVB4QUpaRHhPNGxOZEhjNFhk?=
 =?utf-8?B?RXhtWjVkaC94bUFvRzBkSGEwdTlRSlp3OHRWejA4MUN4bGNSTHVGVXlTRkpV?=
 =?utf-8?B?eDFMYlFVUnFYUGlSZjF5eHkvMUdNU1N2Y0JmYURXTVZyQm1OVzcxbGRNWVBu?=
 =?utf-8?B?Tk1MeVdERFJpTittQnpOb3UvNVZDajgweWtVVTBVTm5WM2pDMlNWdndHcnF6?=
 =?utf-8?B?U0Q3eXArYVBnQ09reXh3TlRkMFFRdmxPQ0ttYkhoK1k2RkZnUU9tR3BmNC9p?=
 =?utf-8?B?OEc4aW1YeUZqN1hyNTRFVXdTUmtMeW5mczUxV08vZW1BZHNBUXlYQ0hCZHZs?=
 =?utf-8?Q?0CfLVvJXRqpWaILA1J8OkIE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WElDWVBta0ltWHQ0ZVRlSEdKaGZhTjFSd2piL2p5c3J0c1dMMGQ1OUl3M293?=
 =?utf-8?B?aUpMTWU0ZlhWZVdXbWExSzFCM3VtRWJMMGZ6Q0UxY2h5OGRHS2dCcGs1SzUz?=
 =?utf-8?B?K0ZRMjcvSi9hQk9YNkEvNW1oOG9SRHRiWm8xYlhTbVQ3bGo0ZSt6Z09ndGlG?=
 =?utf-8?B?dlNtdkRNWDRJWUwvbjE4TUZQMTkzeUdVL1hUNzRNa204dzdiWWRIMlZ4cjRX?=
 =?utf-8?B?alNXM1YvTDRiYVg5OEZScmpwRyt4SXA0VE5ueWJ5R2lBNktNR3V2UFBrUGlt?=
 =?utf-8?B?SHVpNGNKUWRwbjY2dC81VEJtRFR6QTlRQTJwaDZMdDl3OVF1SE4wRUo2U1Ix?=
 =?utf-8?B?N00wVVQzYUxvSUZyb3VlNGV4ejlNWWQ0cHBWUVFjQnErS28rOWpwSzlwNkFE?=
 =?utf-8?B?WWJwY0NQWnZIckt3aUcyWnlRdkQyTURqMVFkL3A2aVpIeHk5anhQQkdRV204?=
 =?utf-8?B?bmtTQ0pzRTQ4OWwvRVR3UGF3dnhZUHVCTFF6UFp4VjRIb1BLSE1DVTJVQ1A2?=
 =?utf-8?B?R3VHL2k1anVOZldSVzRWRExJbHl5cU9xN3JUTkVvcHh3bG5XZ1M2UmNtaDdZ?=
 =?utf-8?B?eWRLZkc4alV4L3NYakxleE9WVml5YWY3aWdLa2t3NEFJMlVUbXo0ZEFGZVh5?=
 =?utf-8?B?Y2xFY3FnODdlemZnY0dPeWhyemNsOWJtcWYzWlR6MW4zakw4MDE3MEM4WkZS?=
 =?utf-8?B?YXkrVG9VNVBLVXlvR2trWERCU1RSbFV2SVFEWWVzbWhYK0FwemJWS2U3RG0z?=
 =?utf-8?B?bW52QzZJelNzSlF3SnFqTTB1M01TWlgxMWQ5T0dRUVFsNnQ1N29TSGd6MDd6?=
 =?utf-8?B?eHQ1Y093NzFhdEx5L1V0Mnc1YTdzbU9PRTRmLzczQ3ZFK291MFRrZUs3N003?=
 =?utf-8?B?SlJNTGoyUE8zcE1xK0haeGJVM3huL1dDcWI1eUFLaWVHNlZ6cHc2ZDYxY3lK?=
 =?utf-8?B?OU5EN2JwRDE3NXArY3FXTzh0Z2FBWi9pNXFFVFpqRjdwUGhqK2JWV0VKQ0Zx?=
 =?utf-8?B?Z013em9jWXdweGdPdnlOb3Jwb04xQUNlZ1RKRDVpWkxpMU5yZ3lHMFNSdFlT?=
 =?utf-8?B?UC9PSlJzcEVkUGFUZ0xwVExQd1JsVXU5SlpZOC9ZUk9GclI0bnAzbEhhSjZQ?=
 =?utf-8?B?RFVvTzE3bHc4TXozVXVlcXlHTTRueFJWOFh3cUsyUXZMMWlQbjJIZlNUZm9D?=
 =?utf-8?B?Y21vT2xKUWdsaGtQUElJc0dQNHR2TDVnQVFyUDFQWmtRM3JqdG9ZY3Q0cU9q?=
 =?utf-8?B?cUhBZEkwU0p0K3p5WXE0MHF6SThWeUN3a2V3SVQ5NC9iaDRaYU9MdEhwQmds?=
 =?utf-8?B?ZUE5YWRsQ2NqR3JhT3VMZWFwbFo2KzAvdDV1TS9Jckp0N2VsS0tGazNNTmd5?=
 =?utf-8?B?NTIzcjdMQ1E5bXFSVDdmT3dWbXdlT1BNOVdKckN4ejB1U01mMWVxTnR4UkRi?=
 =?utf-8?B?M2ZXN3lTMEZxbjdEaTVhMmNuQ1pMSCtMWmNzYWprc0hNZ081czBld29wWmlR?=
 =?utf-8?B?Z1R2NHRKM2o5cVVndTV2WXJsU3VRVlc5a2JOcEZvbVVBNlROV05JNjh2S1ZP?=
 =?utf-8?B?Z01QeFhUQzFsdVJLQzFHTFdwZDhpVzdneDZEY3MvNkNyUDRLMjVCelBKT2I3?=
 =?utf-8?B?ZllKUTd3T2xwbVRiNThYbVNIUENYUnBYeW5iU3haWDRaeTlLMDM3MDFCK3BS?=
 =?utf-8?B?UW4ra2RqTk5kODJlc3hpVzNWS2hsUlMwZ1V6TTZSUzI0ZkNXd0l2MWRRYUls?=
 =?utf-8?B?RDgwUlM4dzd4TXROK3F0UksrWkVyc1BIaE5MOGx5YkJ4OEkxd0crWDVZQmYr?=
 =?utf-8?B?UGFpUXlmOVR6T2xmMFZFMTQ5MDNyejdCNnhieEFLL1RlOHNSMGxLTzlvblNV?=
 =?utf-8?B?MlFOc0JkaFJkbmNmL3daUkhpTW50eFQwTzVKYXFlbkR1OXpxdmI2RVFkZHNK?=
 =?utf-8?B?SVF1S0NvcGduQUtnYjVac3FhYUd3UDRpeWY4blNQWGVmLzhFUVlmZlI4c0xr?=
 =?utf-8?B?dU82aWMrdVFxbGhBQUhTVitXajZTQVYvcnEweUFMS0FhdW5rZFV6QmFibllu?=
 =?utf-8?B?dDdyUE0wTUJLSTlpSU9XYklKVmZQQWJiWHk0aVdrOWR4c2lWWTBtL05XZlUw?=
 =?utf-8?B?UXVwNnh3RmsvcFdJMHpQMFR5Vm4yTytHRDI5T1krUmYvWFprdUhhcTZleEVU?=
 =?utf-8?B?OU5VZ2VxcmVvV3Jib3c3R1greWxYcDdpN0xYYmowcU9nZ3RaYk9NMUdjakh5?=
 =?utf-8?B?OS9IWHZZYXdyaUFrQUMwSEQ4dDEyL3psc2thUzE4U1ZSYURRMkxkekpBZTFG?=
 =?utf-8?Q?15R/PoJy+SIOKmG8OE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5a94f2-44fe-4aef-742d-08de64bf0efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 14:01:28.5808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbuAJXDyruXNWqyCCKEmZDwTGI46guOega//pQ4Z8HnTT0sXHwhj0uxjHP2Qf5aQK332TDxtjcDirHsu0AfJRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdnJ0a28gVXJzdWxpbiA8
dHVyc3VsaW5AdXJzdWxpbi5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA1LCAyMDI2
IDY6MzMgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVH
QU1AYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBkcm0vZ2VtOiBNYWtlIGRybV9nZW1fb2JqZWN0c19sb29rdXAoKSBzZWxmLWNsZWFuaW5n
DQo+IG9uIGZhaWx1cmUNCj4NCj4NCj4gT24gMDUvMDIvMjAyNiAxMjoxMywgU3Jpbml2YXNhbiBT
aGFubXVnYW0gd3JvdGU6DQo+ID4gZHJtX2dlbV9vYmplY3RzX2xvb2t1cCgpIGNhbiBhbGxvY2F0
ZSB0aGUgb3V0cHV0IGFycmF5IGFuZCB0YWtlDQo+ID4gcmVmZXJlbmNlcyBvbiBHRU0gb2JqZWN0
cyBiZWZvcmUgaXQgZmFpbHMuDQo+ID4NCj4gPiBJZiBhbiBlcnJvciBoYXBwZW5zIHBhcnQtd2F5
IHRocm91Z2gsIGNhbGxlcnMgcHJldmlvdXNseSBoYWQgdG8gY2xlYW4NCj4gPiB1cCBwYXJ0aWFs
bHkgY3JlYXRlZCByZXN1bHRzIHRoZW1zZWx2ZXMuIFRoaXMgcmVsaWVkIG9uIHN1YnRsZSBhbmQN
Cj4gPiB1bmRvY3VtZW50ZWQgYmVoYXZpb3IgYW5kIHdhcyBlYXN5IHRvIGdldCB3cm9uZy4NCj4g
Pg0KPiA+IE1ha2UgZHJtX2dlbV9vYmplY3RzX2xvb2t1cCgpIGNsZWFuIHVwIG9uIGZhaWx1cmUu
IFRoZSBmdW5jdGlvbiBub3cNCj4gPiBkcm9wcyBhbnkgcmVmZXJlbmNlcyBpdCBhbHJlYWR5IHRv
b2ssIGZyZWVzIHRoZSBhcnJheSwgYW5kIHNldHMNCj4gPiAqb2Jqc19vdXQgdG8gTlVMTCBiZWZv
cmUgcmV0dXJuaW5nIGFuIGVycm9yLg0KPiA+DQo+ID4gT24gc3VjY2VzcywgYmVoYXZpb3IgaXMg
dW5jaGFuZ2VkLiBFeGlzdGluZyBjYWxsZXJzIHJlbWFpbiBjb3JyZWN0IGFuZA0KPiA+IHRoZWly
IGVycm9yIGNsZWFudXAgcGF0aHMgc2ltcGx5IGRvIG5vdGhpbmcgd2hlbiAqb2Jqc19vdXQgaXMg
TlVMTC4NCj4gPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBUdnJ0a28gVXJzdWxpbiA8dHVyc3VsaW5AdXJz
dWxpbi5uZXQ+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5p
dmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbS5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZ2VtLmMNCj4gPiBpbmRleCBhMWE5YzgyODkzOGIuLjg2MmM5YjJiOWMwYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9nZW0uYw0KPiA+IEBAIC03NzUsMTkgKzc3NSwyMSBAQCBzdGF0aWMgaW50IG9i
amVjdHNfbG9va3VwKHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgdTMyDQo+ICpoYW5kbGUsIGludCBj
b3VudCwNCj4gPiAgICAqIEZvciBhIHNpbmdsZSBoYW5kbGUgbG9va3VwLCB1c2UgZHJtX2dlbV9v
YmplY3RfbG9va3VwKCkuDQo+ID4gICAgKg0KPiA+ICAgICogUmV0dXJuczoNCj4gPiAtICogQG9i
anMgZmlsbGVkIGluIHdpdGggR0VNIG9iamVjdCBwb2ludGVycy4gUmV0dXJuZWQgR0VNIG9iamVj
dHMNCj4gPiBuZWVkIHRvIGJlDQo+ID4gLSAqIHJlbGVhc2VkIHdpdGggZHJtX2dlbV9vYmplY3Rf
cHV0KCkuIC1FTk9FTlQgaXMgcmV0dXJuZWQgb24gYQ0KPiA+IGxvb2t1cA0KPiA+IC0gKiBmYWls
dXJlLiAwIGlzIHJldHVybmVkIG9uIHN1Y2Nlc3MuDQo+ID4gKyAqIE9uIHN1Y2Nlc3MsICpAb2Jq
c19vdXQgaXMgc2V0IHRvIGFuIGFsbG9jYXRlZCBhcnJheSBvZiBAY291bnQNCj4gPiArIHBvaW50
ZXJzDQo+ID4gKyAqIGNvbnRhaW5pbmcgR0VNIG9iamVjdHMuIFRoZSBjYWxsZXIgbXVzdCBkcm9w
IHRoZSByZWZlcmVuY2VzIHdpdGgNCj4gPiArICogZHJtX2dlbV9vYmplY3RfcHV0KCkgYW5kIGZy
ZWUgdGhlIGFycmF5IHdpdGgga3ZmcmVlKCkuDQo+ID4gICAgKg0KPiA+ICsgKiBPbiBmYWlsdXJl
LCAqQG9ianNfb3V0IGlzIHNldCB0byBOVUxMIGFuZCBubyBmdXJ0aGVyIGFjdGlvbiBpcyByZXF1
aXJlZC4NCj4gPiAgICAqLw0KPiA+ICAgaW50IGRybV9nZW1fb2JqZWN0c19sb29rdXAoc3RydWN0
IGRybV9maWxlICpmaWxwLCB2b2lkIF9fdXNlciAqYm9faGFuZGxlcywNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBjb3VudCwgc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqKm9ianNfb3V0
KQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gZmlscC0+bWlub3It
PmRldjsNCj4gPiAgICAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqb2JqczsNCj4gPiAtICAgdTMy
ICpoYW5kbGVzOw0KPiA+IC0gICBpbnQgcmV0Ow0KPiA+ICsgICB1MzIgKmhhbmRsZXMgPSBOVUxM
Ow0KPiA+ICsgICBpbnQgcmV0LCBpOw0KPiA+DQo+ID4gKyAgICpvYmpzX291dCA9IE5VTEw7DQo+
ID4gICAgIGlmICghY291bnQpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBA
QCAtNzk2LDI1ICs3OTgsMzQgQEAgaW50IGRybV9nZW1fb2JqZWN0c19sb29rdXAoc3RydWN0IGRy
bV9maWxlICpmaWxwLCB2b2lkDQo+IF9fdXNlciAqYm9faGFuZGxlcywNCj4gPiAgICAgaWYgKCFv
YmpzKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gLSAgICpvYmpz
X291dCA9IG9ianM7DQo+ID4gLQ0KPiA+ICAgICBoYW5kbGVzID0ga3ZtYWxsb2NfYXJyYXkoY291
bnQsIHNpemVvZih1MzIpLCBHRlBfS0VSTkVMKTsNCj4gPiAgICAgaWYgKCFoYW5kbGVzKSB7DQo+
ID4gICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4gPiAtICAgICAgICAgICBnb3RvIG91dDsN
Cj4gPiArICAgICAgICAgICBnb3RvIGVycl9wdXRfZnJlZTsNCj4gPiAgICAgfQ0KPiA+DQo+ID4g
ICAgIGlmIChjb3B5X2Zyb21fdXNlcihoYW5kbGVzLCBib19oYW5kbGVzLCBjb3VudCAqIHNpemVv
Zih1MzIpKSkgew0KPiA+ICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7DQo+ID4gICAgICAgICAg
ICAgZHJtX2RiZ19jb3JlKGRldiwgIkZhaWxlZCB0byBjb3B5IGluIEdFTSBoYW5kbGVzXG4iKTsN
Cj4NCj4gSSB0aGluayB0aGlzIHBhdGNoIGlzIHBvc3NpYmx5IGFnYWluc3QgdGhlIEFNRCBzdGFn
aW5nIGJyYW5jaD8NCg0KWWVzLg0KDQpZb3Ugd2lsbCBlaXRoZXIgbmVlZCB0bw0KPiByZWJhc2Ug
b24gdG9wIG9mIGRybS10aXAsIG9yIEFNRCBzdGFnaW5nIG5lZWRzIHRvIGNhdGNoIHVwIHdpdGgg
Ni4xOS1yYzEuIEJlY2F1c2UNCj4gaW4gdGhlcmUgSSBoYXZlIHJlcGxhY2VkIHRoZSBhYm92ZSB3
aXRoIHZtZW1kdXBfYXJyYXlfdXNlcigpLg0KPg0KPiBPdGhlcndpc2UgSSBhZ3JlZSB3aXRoIHdo
YXQgQ2hyaXN0aWFuIHNhaWQsIHRoYXQgaXQgd291bGQgYmUgbmljZSB0byBnZXQgcmlkIG9mIHRo
ZQ0KPiBfX0dGUF9aRVJPIHJlcXVpcmVtZW50IGFuZCBoYW5kbGUgaXQgaW4gb2JqZWN0c19sb29r
dXAoKS4NCg0KSSBoYXZlIHByb3Bvc2VkIHYzLCBiYXNlZCBvbiB0aGlzICwgd2lsbCBjaGVjayB3
aXRoIEFsZXggb3IgQ2hyaXN0aWFuIHJlZ2FyZGluZyB0aGUgcmViYXNpbmcgcGFydA0KDQo+DQo+
IEluIHRoZSBtZWFudGltZSBJIGhhdmUgYWdhaW4gd2VudCB0aHJvdWdoIGFsbCB0aGUgY2FsbGVy
cyBhbmQgaXQgc2VlbXMgdGhleSB3aWxsIGFsbA0KPiBoYW5kbGUgbm90IGhhdmluZyB0byBkbyB0
aGUgY2xlYW51cCBqdXN0IGZpbmUuDQo+DQo+IEhtLCBhbm90aGVyIGludGVyZXN0aW5nIHF1ZXN0
aW9uIGlmIHdlIG1heWJlIHdhbnQgdG8gYWRkIGEgY2xlYW51cCBoZWxwZXIgc28gdGhlDQo+IGNh
bGxlcnMgZG8gbm90IGhhdmUgdG8ga25vdyB0aGF0IHRoZXkgaGF2ZSB0byB1c2Uga3ZmcmVlPw0K
PiBBbGwgb2YgdGhlbSBoYXZlIHRoZWlyIG93biBsb29wcyBzbyB0aGF0IHdvdWxkIGFsc28gbmlj
ZWx5IGNvbnNvbGlkYXRlLg0KDQoNClRvIGtlZXAgdGhpcyBjaGFuZ2UgZm9jdXNlZCwgSSBzdWdn
ZXN0IHdlIGZpcnN0IGxhbmQgdGhlIHNlbGYtY2xlYW5pbmcgYmVoYXZpb3IgYW5kIHRoZW4gdGFr
ZSB1cCB0aGUgaGVscGVyIGFzIGEgc2VwYXJhdGUgZm9sbG93LXVwIHBhdGNoLiBJ4oCZbSBoYXBw
eSB0byBhbGlnbiB0aGlzIHdpdGggQ2hyaXN0aWFu4oCZcyBwcmVmZXJlbmNlIGFzIHdlbGwuDQoN
ClRoYW5rcywNClNyaW5pDQoNCj4NCj4gdm9pZCBkcm1fZ2VtX29iamVjdHNfY2xlYW51cChzdHJ1
Y3QgZHJtX2dlbV9vYmplY3QgKipvYmpzX291dCwgaW50DQo+IGNvdW50KSA/IGRybV9nZW1fb2Jq
ZWN0c19sb29rdXBfZnJlZT8gZHJtX2dlbV9vYmplY3RzX2xvb2t1cF9jbGVhbnVwICghKT8NCj4N
Cj4gUmVnYXJkcywNCj4NCj4gVHZydGtvDQo=
