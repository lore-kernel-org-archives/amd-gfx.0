Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6C6D41C35
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 17:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6929310E13E;
	Wed, 13 Nov 2024 17:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Apxzmhjo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5670410E13E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 17:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juR7kQjJ2gx4ZerdjaB7yQ73AJ/qiCarkDEx0ebOXDIdFJ5p53SHllTDsZOVPz8VyT9oqWzEVNVlguWgLpefnC5yJHFiV+zvQtMQhOMJlt+MHqIgpcxptYUzsoQ0GKZ4cONlqEtHdspdKMe3XySvND/+DHc/iNOvnuKWDyn8hE2qEIvNmazMAJA+BAcGoRglWqfrs2lNpfyfrB5AD7fR3s+DlhmtRuaAM31wIDJi0JlLEdymQYfSHL+Q2n7c3TKZ/ryhr1bl6JHVOTav6ZONSAfPjBVrOOc/ONh5QzzXjyApWGSOaU9RdwYXT4LT89aQVCR+skRIxEqXU3XyKIaTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUY9bSuW+gL4BnYRjUgMvvIZNMX8520kKUfL4HD+PhQ=;
 b=Dtq1u7P4hz2aIN6GIxI9zYhST47Us2vIyJANc6OsS4WfJzqjYqF6CmiH36C5VlWjRMSCCrMaEmhOCCxhmnzIc1DnZH0f/uSN04OgV7xKGqOnO7Femqp7aEJtRoV5Tqwu3WCFUmr6pbZLTamnA3xvGzB8NtRQ5kd3+GbXp2/dYa446M6i5ijDxpXNH0HR6neTpwMya5jZZab7Z0F+vDZ5qYgPMSF1j1hdrCFKKHaG5TtZwVsRu9kGDELeEy4NTx3JeOvz0T3GYCQiWNllXB12AjdmgdSQJuCVZo+D1F9+gMhhduFrZePgcE0I4ZElQv9fcjNQpEFju3YNlMWv2zjfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUY9bSuW+gL4BnYRjUgMvvIZNMX8520kKUfL4HD+PhQ=;
 b=ApxzmhjoUA7qm+DuH2k/GYX4067Id4GPdITYy3JBO7Mjep7yrUvgEXaJMTzUPAbfjG5BwacZxaeYYh8KDwbHi9vZjuu9P1pCDxO9w6PRqfRC6jdQ2BfzH2rNgy4zt4r2Lt/u9Jl/SylPMSgFnP43B5ZusKDqxoqxT2l0/37Gmso=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 17:01:56 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:01:56 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHbM4cm2Qy9C3gimkGj8UdltocsKLKze08AgABz2+CAAPuMgIAAGtOAgAAUi4CAABqaAIAAEzMAgAAoT9A=
Date: Wed, 13 Nov 2024 17:01:55 +0000
Message-ID: <SA1PR12MB859954E2004C03CAAF764812ED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
 <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
 <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <76af3cc6-5535-47ca-9473-792f3e9c2d13@amd.com>
In-Reply-To: <76af3cc6-5535-47ca-9473-792f3e9c2d13@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1522ea3e-bbdd-40c6-9c1e-3da7ab87821e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-13T16:47:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|SJ1PR12MB6219:EE_
x-ms-office365-filtering-correlation-id: 00edd8a7-0047-4c58-a470-08dd0404e11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zk0xbVFjZjJmWWJOYWYzTVV1Y1dCMjAzRzUyWXZUMmwrb2lrb05OS1FhejZM?=
 =?utf-8?B?VS9VT2dVK1VoQnNQalpEOWhOWWZ0eElNUVF1YkRjemYrSS9KV0FsQWQyQzFa?=
 =?utf-8?B?WXZyWDlyVDlhbVBlVWJqK01Ea2V5UGd2MThwZjRIRStTa2ZoN0cwSjBYUk5q?=
 =?utf-8?B?aEJna1NoNk03TW5pbWpGa0d6d09HaVg4UkNKUlpFWmRvZ0owcnZOQUUvb2p4?=
 =?utf-8?B?SElEMjF6ZWN6MjhJL0E0RmhyVm5TUkxvZGZkWjE2Q0ZmdmQwenljVDBZVWd1?=
 =?utf-8?B?TVJWS3NMb0xzTkphSDJOWm02ZkhWZ3YrR0Z0VUpEdDVFSjc5RmNBVERGaGJ1?=
 =?utf-8?B?YldoRkpMMlBFWlIzY1JsWUhlcmRDSHFMczRBR0M3NUZPalUvWTBCRExMS3Rx?=
 =?utf-8?B?NGxzY0MxMlA3b0RMWXVGb3JJSGNVbFpxZnIyTW1qQ3crZmZsVEFzZW9XanNE?=
 =?utf-8?B?WXYxdEdVWjNGK1Q2Y1UzTmVHaWFwSFRxV0NKWjIveUJCNEt0TzZhUWpFaTZs?=
 =?utf-8?B?cGtWaUtUTjM2V3VLZ2xpZlhlWCtnRUhJaEppTG81ejlZK2dqMDlGMmk1UXVM?=
 =?utf-8?B?MndIdUQzNUtxWWZocHRmV1lxRWN4N3F4d1hsYXBMelNpRUlpL29SRUQrdE5K?=
 =?utf-8?B?U2ZsZTlscXorbk1QWlY0enlLaFhZSGJtdG9lcnhIK3RWMWZReHJyemkrN0ls?=
 =?utf-8?B?aDZ0YXhtYmpva3dpV09oV1NnSmhwNTRsQ2FpQmxCQ2R0N25lU2g4cEN1M255?=
 =?utf-8?B?SW5abWUwQktrc0N6TDJIK1k1Y054Z1ptOXczTUJsMGxtMU8xOFliVGNNdEZT?=
 =?utf-8?B?SWp1ZkJVdk5xd2l3V2xRM2grK0tPRFJTVXZ0U1lobjZSUGpxcEZIQW43THlx?=
 =?utf-8?B?TEJKeEN5Q1RKL1dTSGJ4T09qcHZYN3lpSXVnR1hoajJGYVhvS2ZUVUVjdDRQ?=
 =?utf-8?B?RFp5cmFPMjBXdXRKTzRpZ3N0S1p1L0dWSDYvY1V1bWJDd0paSVRkTk1DaHFO?=
 =?utf-8?B?aTNZNVdrZjB1TzZQaUtDZXVpRitZc0FpcDZPdVFWY29kUlZGU1pXN0ZqSit4?=
 =?utf-8?B?L2xPdUlFeStMbHY0TUZpSFdGTllZYWZXc3VMNlZZeTQwa2J2K0lwdk9NNHVY?=
 =?utf-8?B?UFY2eis4NndaNTdod2Y1akp1cnJzVktpTzl6Ny9GMDl2SHNYQlNZcnRGdnhI?=
 =?utf-8?B?VUtSZ1dGSThWSVBBM1UxYTkvcmhMUU5vMkwzaGVRRFNXeVpaZHZHQzdHRXVC?=
 =?utf-8?B?UDEram9CR25Sa2tUdVZEWmhEV2hDMkhKSE9MMS93REhSc0gvRXpiakFRVEJ6?=
 =?utf-8?B?WHNBc25nNXhkaDlrSjdiaS9RaFc2aW80dlA5NHN1WWhtdzdTcU8xQWFLT0pk?=
 =?utf-8?B?MEYzRlJtNExkZ0RtQitRYTkxTDF4elFrU3VzbmlTdkhZTEJhZlp3TEsvcmoz?=
 =?utf-8?B?R3Fmemhkd1NURmdzVzZQeUZxQ0dQeDVuUGh1YTVVbnUwZU1ZWXR5blhtMmJN?=
 =?utf-8?B?NW5yY1ZWM09MUVlGeDAra2lTTytCUW1VZDE3QUJQS1RqZENrNU02QzhnUHc4?=
 =?utf-8?B?ZVFocE1ibHdESjVSSlZna0hLb3pGejFwNUdQNTdKR1hsRElPcm8wL3pud3Vz?=
 =?utf-8?B?VmQ3QXo5SHVqYTZtK3NvaW9FSy9lKzZUZW9XVXhvdXVwRW9vT3lYOXVPS1oz?=
 =?utf-8?B?amoyTk5EdDBTS1d1MlR6bjYyZ2gwQTVxZVRENWlmVUkxM29ieDZxemRyUHM0?=
 =?utf-8?B?M1dld253QnFtbnY3WXpHOU9EMFZreWJna1ZXYjgzWlZ2elNNWUFHTVBsVDhN?=
 =?utf-8?Q?NJ4A9KYmehQCFtBSjGC1qdJnRKUgkPCpeWZT8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzVQaGlac0pGTTZkanNTeFYwamdZdUF0SmFSeXJQclFKbnZtSFNLTXE1cysw?=
 =?utf-8?B?c2pUQ2hnaWdMTGxFL0xlVngxRVY0NXNzYkpnTGtDd2gxUFZrK1JTNndQQWJJ?=
 =?utf-8?B?SHNrbmdvOENKZmJrTmNLeGZSbHVkanRkeWZWaXk2NjkwUkdmallJdzlvQWlh?=
 =?utf-8?B?UVA1d2ZKWjdWUWhKSGk3VGxmSmlFWWM4SEZuMkNzSWtPTXczVzZIa20zZmE0?=
 =?utf-8?B?a054cnpSckwwU21MNU5lU3IxR21YSTFEZGJUcDMyakNkdkE2UW1ZTmJ0Rjh1?=
 =?utf-8?B?M3FQN0lKVTBNd0wyd01peVZ5WnZsaWx5VWxML0MxcjJRM0xWK1YyS2R0UGZh?=
 =?utf-8?B?V0ZqbStUZEw5Y0VDYkQvOGhQNHVmR2hxQjBiUWEwczRTYURmaFR3S0NGQlMx?=
 =?utf-8?B?LzF2a1VObHdhUG9WRWxsNk1HZi9PMnE2Y0VFc2JmS2RHdmpNMjlDL0tUb1Za?=
 =?utf-8?B?QjdST2ZvTnFzcThQekJCczN2UThhUjBEaENnNHN1S1Jock43UGRocWRxbnI0?=
 =?utf-8?B?c0pGVE9UTTJxaW9kK2V4UjMyb1ViQldkaDhLUWJZWkJKWFV3OENId2pMMkc1?=
 =?utf-8?B?T09HSWpYcDRPMlRod3p6b2ZUZm1VU0NUWHJzcXNhQkxhK0pIcFNLR3BXU0Fm?=
 =?utf-8?B?UmZTT0xmNzZsS3ptSFlnS3BuOU9pM3ZtVThieHR2R1RCOXFqU3RKY0xwYytK?=
 =?utf-8?B?d2tLMytVUlhnRFZEcG9UcmR5UENuOGJKOVphOEVwOTVtcDE3UTdnTDhxNGVQ?=
 =?utf-8?B?eEN6ZWxIMDcvTkxQVjJvNWM3eUljWDh5S0NHSm9uMkVBTXJ0UCsyMHBYK2Zs?=
 =?utf-8?B?TkQ3R1REaitncXhyNzRrNUlTcHlaUFpaWU4zZ0RHdDkzOFJiNFB2YTV3Sm5m?=
 =?utf-8?B?UVJsYUxEZzBrRzdMckxUMjU0eFBQZkl3NlpUMkRLWG0rd2x6aVRzRjRaL2RK?=
 =?utf-8?B?KzR5ZjV4N2JMUnRGMjV1WVMyOEdzajYwUWdDakFuK0NBOXByM3dWc2V5Vkl4?=
 =?utf-8?B?cmpFVllCcHdzbFlISDNUck9IaWVQU2k1WWJ2UlZIWmFIWmlQb2llZW9rdEt1?=
 =?utf-8?B?QWpTSFVIUmhCSlpMNVgySHRmbytSZ1RMeUpGaUh3Y1lUaThZM0lJU1h0Z1FU?=
 =?utf-8?B?TEZSWXFINFBhMTRiQWMwTS9CQzQ3K0twWXdQdmVBdkRicGtjdGU0T1YyY0ov?=
 =?utf-8?B?amV6TXVBWUlNZnVoSHpoZGxnVjExTHNnVkVhMlY3QTZOOW1RVkNYRGJtOWJ4?=
 =?utf-8?B?K3BYOTV1YTFaVXRSZWU5M2tDSFhqMmRnMGlqMHJLaURCQjBaUW9VM2xyR082?=
 =?utf-8?B?cGZRNUE3cHJpUWNCWHFDZkNKdXFjMGt5dUNuUDVBSFJVK3g5L0xEZVJZcHpK?=
 =?utf-8?B?cWlKVTA3OEFKejJkekxTdlFySS8xcHhsTWNuaG9nay9aNXVaODIzQ1l1NWpR?=
 =?utf-8?B?UXpkTnhZL09IaU1vQWd1V0VBSnlOUVpWNWpaWnFVcXp6RGo5VTkvMDF2ZlBZ?=
 =?utf-8?B?UWFhVmNCNVNoU2t5NTRMQnF5RDF1SVVTT25oZzZqbmdqc1ErZFBwQTNIZ1Na?=
 =?utf-8?B?Q1R0S0czaCtNdi9OajVDMTJjTG5HekN4cERLYk1yNyt4UDFIWVJ5MmNzSHJk?=
 =?utf-8?B?MjlzS0NRNkFuV2NhVUJzRTZEUnNxNVBzcWRrUWRMMmRDRlJSMy9GMnZyS29R?=
 =?utf-8?B?NnJ2TmI0T0VzRjFwc3pWbWJuOHBsOUNZSGVQUDFDdkR2RkorSTlMamo0YTVF?=
 =?utf-8?B?Y2R6WEhIZE9iQ0cwcyszdDQ4RDMwd3lFWlVWelRUYzBhb0tHa3JaRXo1WTNU?=
 =?utf-8?B?WmtuUVAydGZGS1Y3Z3h3YlhTbmpqM05wbWszWU1MbHR1azd5aTIvU3laZ08x?=
 =?utf-8?B?c1NqWXNFbkw2RE5pejB6MXliWi9VSVRiaEtoS0FGenhZK2JUWTZIRE5RbldC?=
 =?utf-8?B?SDdlaVNjeUNzdWRwek5zQmpxeWkwSUZpcyttbDJTY0NTY3l1QVl6bGRoQS9R?=
 =?utf-8?B?ZHJocjJGRDAybHEvT2hXWHNhbXBpNjlvaWhIRzlGRHZ5dUZma0ozZzVyUjlu?=
 =?utf-8?B?by8rbUxxMXlmOGRqMGxDcm9hd282ZTZzVjF1emFSSW5VZkNrZEZPNXI0Rklq?=
 =?utf-8?Q?B6C0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00edd8a7-0047-4c58-a470-08dd0404e11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 17:01:55.9175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTwESWej41w2oq3TRwnmNg14yoIhF6CDu6PFSd3Am72nHinYtWpGPNUuYYybaIGZeTPUUEqrE2pEdBcQcLYhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDk6MjINCj4gQW0g
MTMuMTEuMjQgdW0gMTQ6NTMgc2NocmllYiBMaSwgWXVueGlhbmcgKFRlZGR5KToNCj4gPiBbUHVi
bGljXQ0KPiA+DQo+ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQgNjozOSBB
bSAxMy4xMS4yNCB1bSAxMToyNSBzY2hyaWViDQo+ID4+IFR2cnRrbyBVcnN1bGluOg0KPiA+Pj4g
T24gMTMvMTEvMjAyNCAwODo0OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPj4+PiBBbSAx
Mi4xMS4yNCB1bSAxOToxNiBzY2hyaWViIExpLCBZdW54aWFuZyAoVGVkZHkpOg0KPiA+Pj4+PiBb
U05JUF0NCj4gPj4+Pj4+PiArICAgc2l6ZSA9IHNpZ24gKiBhbWRncHVfYm9fc2l6ZShibyk7DQo+
ID4+Pj4+Pj4gKyAgIHJlcyA9IGJvLT50Ym8ucmVzb3VyY2U7DQo+ID4+Pj4+Pj4gKyAgIHR5cGUg
PSByZXMgPyByZXMtPm1lbV90eXBlIDoNCj4gPj4+Pj4+PiBhbWRncHVfYm9fZ2V0X3ByZWZlcnJl
ZF9wbGFjZW1lbnQoYm8pOw0KPiA+Pj4+Pj4gQWdhaW4sIGl0J3MgYSBjbGVhciBOQUsgZnJvbSBt
eSBzaWRlIHRvIGRvIHN0dWZmIGxpa2UgdGhhdC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBXaGVuIHRo
ZXJlIGlzbid0IGFueSBiYWNraW5nIHN0b3JlIHRoZSBCTyBzaG91bGQgKm5vdCogYmUNCj4gPj4+
Pj4+IGFjY291bnRlZCB0byBhbnl0aGluZy4NCj4gPj4+Pj4gSSBkb24ndCBoYXZlIGEgcHJlZmVy
ZW5jZSBlaXRoZXIgd2F5LCBidXQgSSB0aGluayBpdCBzaG91bGQgYmUgYQ0KPiA+Pj4+PiBzZXBh
cmF0ZSBkaXNjdXNzaW9uIHRvIHByb3Blcmx5IGRlZmluZSB3aGF0IGRybS10b3RhbC0gbWVhbnMu
DQo+ID4+PiBUb3RhbCBtdXN0IHNob3cgdGhlIHRvdGFsIHNpemUgb2YgYWxsIEJPcyB3aGljaCBl
eGlzdCBldmVuIGlmIHRoZXkNCj4gPj4+IGRvbid0IGN1cnJlbnRseSBoYXZlIGEgYmFja2luZyBz
dG9yZS4gVGhhdCdzIGhvdyBkcm0tdXNhZ2Utc3RhdHMucnN0DQo+ID4+PiBkZWZpbmVzIHRoZSBm
aWVsZCBhbmQgdGhhdCBpcyBob3cgYWxsIHRoZSBvdGhlciBkcml2ZXJzIHdvcmsuDQo+ID4+IElu
IHRoYXQgY2FzZSB3ZSBzaG91bGQgb25seSBsb29rIGF0IHRoZSBwcmVmZXJyZWQgcGxhY2VtZW50
IGFuZCBub3QNCj4gPj4gdGhlIGJhY2tpbmcgc3RvcmUgYXQgYWxsLg0KPiA+Pg0KPiA+PiBCdXQg
dGhhdCBtYWtlcyB0aGUgdG90YWwgaWRlbnRpY2FsIHRvIHRoZSByZXF1ZXN0ZWQgdmFsdWUsIGRv
ZXNuJ3QgaXQ/DQo+ID4gWWVzLCB0aGUgaXNzdWUgaXMgbm90IHdoaWNoIEJPIG5lZWRzIHRvIGJl
IGNvdW50ZWQgYnV0IHdoZXJlIHRoZXkgc2hvdWxkIGJlDQo+IGNvdW50ZWQuIFRoaXMgZ2V0cyBt
b3JlIGNvbXBsaWNhdGVkIGlmIHdlIGNvbnNpZGVyIEJPcyB0byBwcmVmZXIgbXVsdGlwbGUNCj4g
cGxhY2VtZW50cy4NCj4gPg0KPiA+IElNTyBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIGRybS10b3Rh
bC0gdG8gd29yayBsaWtlIHRoZSBsZWdhY3kgYW1kLXJlcXVlc3RlZC0NCj4gd2hlcmUgd2UgbG9v
ayBhdCBCTydzIHByZWZlcnJlZCBwbGFjZW1lbnQuIEZvciBtdWx0aXBsZSBwcmVmZXJyZWQgcGxh
Y2VtZW50cyB3ZQ0KPiBzYXkgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gbmVlZHMgdG8gcGljayBv
bmUgb2YgdGhlbSB0byBhdm9pZCBkb3VibGUgY291bnRpbmcsIGJ1dA0KPiB3aGljaCBvbmUgaXMg
dXAgdG8gdGhlIGltcGxlbWVudGF0aW9uIGFzIGxvbmcgYXMgaXQncyBkb25lIGluIGEgY29uc2lz
dGVudCBtYW5uZXIuDQo+IERvZXMgdGhhdCBzb3VuZCByZWFzb25hYmxlPw0KPg0KPiBZZWFoIHRo
YXQgd29ya3MgZm9yIG1lLiBKdXN0IGRvbid0IGxvb2sgYXQgYm90aCBiby0+cHJlZmVycmVkX3Bs
YWNlbWVudCBhbmQgYm8tDQo+ID50Ym8ucmVzb3VyY2UgYmVjYXVzZSB0aGF0IHdpbGwgY2VydGFp
bmx5IGJlIGluY29uc2lzdGVudCBpbiBzb21lIHVzZSBjYXNlcy4NCg0Kb29mLCBmcm9tIHRoZSBj
b21taXQgbWVzc2FnZSBpOTE1L3hlIGlzIGRvaW5nIHRoZSBleGFjdCBvcHBvc2l0ZSwgQk8gZ2V0
cyBjb3VudGVkIGluIHRoZSB0b3RhbHMgZm9yIGFsbCB0aGUgcG9zc2libGUocHJlZmVycmVkPykg
cmVnaW9ucy4NCg0KVGVkZHkNCg==
