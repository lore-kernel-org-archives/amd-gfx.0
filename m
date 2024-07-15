Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4616C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 11:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B38810E362;
	Mon, 15 Jul 2024 11:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuk1YeLs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2393810E17A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 11:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/oeVRDzw18f1YMRT2pke97BNJ12hG4YQrGASUs6on41y62IxowuONPCDVgL2A/Bt8jQjt11JzaEgXsaI0vPShNRPUkClrkomtjHMWDOkSC0QyIn1kTKcfthFwykVDa/dwwWu24kT8bfYccemubf4shO+8/9kWC/GH4PjTZQWThWKqn/DlSQOenYIrJtfO1af9bqYlJNOhqlbTTjqf7EPk9kKwuzhWi+p4yU1b/39m/0wS7T+TFI6OzCAmEXKZ9E1Gj7Dw4FaIlffkc2U4GCIWkUcU+f8enI5n4WkwerE/lFnLwV7Ks4KYdTivrOmIwAMfg+SBUKnevt+n24dw/LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/IK7A2OUMdDqoLEPQlBPpT6YDksmE/9hUefgCmpm90=;
 b=mGtA0eyX6O+pvGekpJPvfpEgP7clTE73uIgYXYu2zoPlwOdIkIwbUE4ho/PW2IoTUL11Bmj2w28A5EPPqq5wBsRaQ4GORmbbMz+5zH5BISV4SzO7QQbgXyIqF/8KEA+ghcbsiKcDVZB6kXCs3jSwlX1UtPo8/CDNUfpfY78S6XZmVuogThslgumYfUeQHWtiIF4MJd1M/pagK+1tl0uQuxBJWOcwqHJx+CbTR99Id0Flcgt4C8+71EAZMRgacpQ3h3GUddYE8vTJB0KF5R7+7xalOYyhHxFwwr/n1cE35/q+nc14Ka6tP0ZihndBNL8KPjZunYIS/JlAhmdIzixQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/IK7A2OUMdDqoLEPQlBPpT6YDksmE/9hUefgCmpm90=;
 b=fuk1YeLsoxl1m+Fp+py3zH3V9GT0KL1O5mY6+rHjcDppcpIzKyx6YkBNcu75MFE8CkQpsNr5YKOEi/Jt6qpX5Znl/Kv3mbf+zjteA1C0JuzsI2W7BQiiTTjK5PZ0opQ9W9rR+USMINdWbcLRYaj5IzQnBPLENNIKMekKFEktdPo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Mon, 15 Jul
 2024 11:50:52 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:50:52 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
Thread-Index: AQHa0YDw8Eptnr9TlU6EO8oNLOSx3bHv+3AAgAe70GA=
Date: Mon, 15 Jul 2024 11:50:52 +0000
Message-ID: <CH0PR12MB5372C5FE8C1063823BB552F1F4A12@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240708215041.529979-1-alexander.deucher@amd.com>
 <20240708215041.529979-2-alexander.deucher@amd.com>
 <CADnq5_PqBm9Nue1Lc-wR4XmccoeDKjQcH8TKxui2BVFT+CvPSA@mail.gmail.com>
In-Reply-To: <CADnq5_PqBm9Nue1Lc-wR4XmccoeDKjQcH8TKxui2BVFT+CvPSA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b7343152-0a6e-4bf7-ada1-508155277db5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-15T11:50:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SJ0PR12MB6784:EE_
x-ms-office365-filtering-correlation-id: b7d3384f-fd6e-456e-57ef-08dca4c460f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWpSTW8xVVJ2L1BwaVNRR3ZFMmdzN0dDRG9EckNRbllEdXg2MkNLcmY0MDlm?=
 =?utf-8?B?Y2dFZ0RoMTFzOXNtVGdCNG5yZlVsRWZwODBTU1hPWDNrV2hHMElJRUYreUVn?=
 =?utf-8?B?b1E2a041Q1gvVysxZE5zTGdlTVVXWnA1ZDBMbGhLbkM4c3Y3Sk9SSGx5MWtp?=
 =?utf-8?B?cGhZd2dXR042dkU3eWhRMUxzS2Y4ZjhXNFdLWEVsUEdaU3RlelFtSTFtdzdT?=
 =?utf-8?B?ZlZPYVBnd1p4V0U4V3d5c0NpclFNNms0ZC9kYlBtV3U1NTVYc3pia1lpcEJG?=
 =?utf-8?B?T01nYWRnY09Ibm10N1d1aldpRUc0NEdzNUJTSHJaOTNiQ0RiU2RvdGFFQndQ?=
 =?utf-8?B?Y0k1RnlvWElsWWwwMHNtbEhuV3k1RFZxMi9vYzVIQmJJMS9tUmZ4Qi9TOUFn?=
 =?utf-8?B?MFpOM0k5MHJNS0FjeXZoaHBqbkxLRExVMlNLWDF3Njllb1ljVjZDY0lsMWtO?=
 =?utf-8?B?ZFZFNDBxdC9WZ1cyZmljVzFvZjNpeVVNd0NzUkJWaUd4cEx3cmc0QmVSd3U2?=
 =?utf-8?B?MTdFRnVOREk5SGFOWDlIMkhZV3paTUJwS01FSWpoQ3JUMUJONG5TL3hLWFFw?=
 =?utf-8?B?dTMxMXVxcFQwdjhIbHRkd3ZQZmRxQmw2b05aY1ZsNWF6d1BpYXk1VVE5VzVo?=
 =?utf-8?B?SSs5K3ZycmpYdTRWUVo2YW5qdStyT2dBcXFqdmpwdVFKWXJ1OVUrejJMSEcw?=
 =?utf-8?B?NktUcGtLNkJOYlRrejJVZUJWSUo2eUlqNXE0OTdVUEVuVWhFZXRwQ0hFSXVw?=
 =?utf-8?B?Q3lSQVFqYnkyN2hMNHpXWXJnYUUzR0I1VzJqdnNkNVpFd1JLZjFWelhneG4y?=
 =?utf-8?B?ZXczYWxtdkgzb21adlZ0TVpsKzVFOXIvZWthanJPWFBQVVQwdUJ4VkpyUXN5?=
 =?utf-8?B?WWMxS0lJN1lOaVJhN3p6d0ZvYUNHalVoWE9XQS9nM3crRktpOVlqV2NnOHVJ?=
 =?utf-8?B?clRHbE43eUYxMGxKNnpyTzNnRllUMkY2YWh2T2pmSk9leTdBcUp6RlBUVE53?=
 =?utf-8?B?aFo3K29WamVjN3luMFlJZW9UNjREMFE0VEtsUkY4N3NDbXQ5M2tTWVQvU0Nt?=
 =?utf-8?B?a08ycHBKK29zZ3EvK2YyUlBQY01OY2c4ZmNXQVpleU8zOE1FTlhUbDRJTnIy?=
 =?utf-8?B?Zm5TNkFJaGZrRUQyKy9pQ0NaNlBOMHNUUUJMMHF0MGgvWThiemtDbTBJZmNL?=
 =?utf-8?B?MmVSRWlnK2RTdjlTMURWRXVucFpDbGlwL0FHNHFDcnVKWUIvSHdGSGxhRm54?=
 =?utf-8?B?SWVaU1BueTYvUFE2MzhJSWZxKzVxYXZ2SkY1VFRCZWxEZFI5eUNLSE53NmdV?=
 =?utf-8?B?SzIreDNsZ1I2Ym5RSkpPYzdUYkJBY3NaWnhTSGw5Yis4UFBGdFZkYjk0U2xl?=
 =?utf-8?B?dGdMTlN0OEpHMEprbDBmc2hvbTN4bG1Nb29lWEcxN25OQTRMYjZueWF5ck1L?=
 =?utf-8?B?ekdIdm4yNldNQnhiem5aY01teWtCQW1KNkg4UnN6RFliT2VMQTc0Z2ZvY1oy?=
 =?utf-8?B?V1JoS21IOGsrcnpza0o0cXdQUWNoOTdFZlJET1VzZ0puNVpiM0VIcDBSNHdN?=
 =?utf-8?B?eUxidUUzMjFHVW1ZRFlaY3EwMVBJMnJzY3JrZ3FibFhlN2pJL0tmaGNpZTZ2?=
 =?utf-8?B?eUUwcHRYYXlYWWgyWUZFOVVCU3ZQcDVqUkNMMCt3Z1lrbXQyVlBBMWszNjhs?=
 =?utf-8?B?ODIrUktMUzFjVGI3NHFHQlpxcURsalRVYjd6NURSWmFva3hjQVBLZDVzQTdz?=
 =?utf-8?B?M1UxTjRuc2V1bm81NGpOTFZFM2NYZTVNa0FtU0cvMzFNR05SWmpZTnBrcDZL?=
 =?utf-8?B?VnJCQ29RWVFyUkZYZW5iSG55ZzlMOWNpVi9NNnI4dkRFUzNwUytMcWJaM3Yy?=
 =?utf-8?B?MWgrYkY4dnQxYmhjUVIwZFJTSUxud09VOVNFU0taZkxNWnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21QTWN2aUZ5NXdZT1R5cjJkUVIybFQzZnV2aGhtaEJJY1ROMTVKbEhpMktx?=
 =?utf-8?B?ek8xRzZuOC80Q09OK0JhL0ZVRGJ5MXpZeE1pVUJNYjM5Z0NoRnYzZUxMekxP?=
 =?utf-8?B?eUdnbEk3UHA5VGd0UnpzeHRNOHRIZWNOU0NyYWdJSlFLZEtUOTByb0oxTU9O?=
 =?utf-8?B?RjM4MXF0WlpIVmpUdTB0TzA4V0Z1cHNDaEZuS2RqUS91ek5zQVRzakxJSWEx?=
 =?utf-8?B?ZEhnRFBvUHVzcW1pY2J2Wm1LTzdHMW5HUnprbStIci9EWWgzYVhEbUgvWUtV?=
 =?utf-8?B?WDZxbVhNOUUzdUlhbnVZWlBqMWJWY2QxWXM0SXpjWVNrMlNQcng2OUFGSExB?=
 =?utf-8?B?T2NhS0dsZVREbGdlakNaejM0ZmFxOGk5NDZPemtHT3AzN1cvcWk2Q0ZnRitL?=
 =?utf-8?B?aVMxeEpYc0pSbFVXbVRBcHY3d2xycks3MUZnc1hkckpNaWxCcUVPVTNNZU1Q?=
 =?utf-8?B?L3FuMERGSE9IVXN1S2RrQkFlV1FrNmUvWFRZdC9qWHN1cGtnOHptZlcvNER2?=
 =?utf-8?B?dVJhTnMvVUQ2MG5jejNNSWk4Z3JvbjRiMUNrN0QxNGhxbzdLNW15RzU2UVhy?=
 =?utf-8?B?QnZPY3RNMDlsTzZlQm01ditZNUJCZ2lscUNicnZOTEl4cFh6SEtzTFUzWXhU?=
 =?utf-8?B?eHByME91RlJWOFh4T3kvVUpkVkhGV2xYbm81L00yMFhHbm13TXJ3SDNJNFhl?=
 =?utf-8?B?MCtHM3V0SkhmV0RRV3lEdkxtTkhENk1Uclh6Y3JEYUtBdy9HUkNhRmttcGlX?=
 =?utf-8?B?a01jbmh0MlF2Y0g5eHpPOFNQTFUyVWZlZTNvWlRMMTRKWnVMbllISnFxczY5?=
 =?utf-8?B?UTdzdWxLWFJqc0RPcW1Sc0N6NG1heWczb2xqTTJnUmI2a1JoTTA1ME1SWXRO?=
 =?utf-8?B?NzI5Wmx0RzNiR1pOSk01RWRiSGZUTXlIczNsS240b242ajdiOHQ3VFRVVDh4?=
 =?utf-8?B?M1ZEeHFKZ1F6RGtuT1JlSlBUMXl0bW5VcXZ4ZFNXRkZvR1V4aThsUzhqdG9K?=
 =?utf-8?B?b2tXakRHczZIQzZYblRRNldSNXBZcUZWQnBjVFJMM3JvUFVscnFOdkI3TW5F?=
 =?utf-8?B?KzFNc2NMK0pLcEdHSDFuZ01vWHJoMVVNTHkxMnJIN2w5Q21yTkJDbG0xaHd1?=
 =?utf-8?B?eVpwK0xDekd0UWxqWi84Qkp1eFRtNUJneVpxMXZYZnZDUzU3eFplU0pZUFRO?=
 =?utf-8?B?UGZWcXBoS09pM0xIeWUzOEhTdU5MdHlMZkxsN1dtOC91a1lnVVZxLzhJWGpE?=
 =?utf-8?B?UERaZnJjc3pHdVZLZU83VHZYL2lpWTErakJGMklxbVBHMnBoSGhLTStVamFS?=
 =?utf-8?B?SU1yNnhuZDZnbjBSNGJkR1hGaUVXczVWd1BsZXhicDQ3VzBvNDhxZU13bWwv?=
 =?utf-8?B?KzhHd0ZCbnFFMUwvcTlZaW5MZWd1QlI4RElLSVE4SkhRcFRoT05JdDRHZmJR?=
 =?utf-8?B?ejRESUgzSUtzaHRmNTZOVGEwTlZBeTdPTGNQWEJ4Nk10bnBoTjEwSHZ1cUdN?=
 =?utf-8?B?elJSckZnenR5dEUvdTZKTHQ5NGNWaGsvdHZsQWhXdm9JSnVXY29aU09EamJS?=
 =?utf-8?B?dFYyOU9Xd2xDT1pRQ1NtbVpjZC9QNnRrUXZqUWxrYVF5K0RDVEorQmN5S0pB?=
 =?utf-8?B?SFdNN2c3bGYvcnVUTjdPdVE3NFdLeTdza3MwN280N1AycWc5YlJveTN3TUxu?=
 =?utf-8?B?Ui9nODZOOTdyUyt3WHplRWZZVU1jcTg4Wkc3eElNVVc1TVA2TTcrUXFCdVli?=
 =?utf-8?B?V1hrVmdXV2luVSt4M1UyS21oL2N2M2p0OHNjMEt0dFY5UzdnZE1iNStTcFll?=
 =?utf-8?B?OUdFNGdUTmphb3ZTRUxoTVNlWTBOdmloc0tDYVJvaHh1YmtjQTBTRm5hRXl1?=
 =?utf-8?B?UWs4WU9zN1psVm1zL0d0OWkrMWVkS0hJYkNmSjRjUGxST0ZvWGE0dEVxcDJ4?=
 =?utf-8?B?dnZGQkczUStZeHNmRVYvUXFvbU5iRW1ITmhFa3RncCtIVXkweHlpNWdiTGNj?=
 =?utf-8?B?NlF4R29YL0U4L2NtT3dwK0h4SjhBdVB1eGpmMk9aSFUySHMrenNxK2pVMFRS?=
 =?utf-8?B?Ymdja3BCVDNVY0xjQVBaUFNGdzFlTHZ3K1JITzhhL0JGTTdxQnFpbFF3WEhU?=
 =?utf-8?Q?JAJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d3384f-fd6e-456e-57ef-08dca4c460f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 11:50:52.6556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PixzXBdbMxwmW3xYCSlYJaKvTgd2LYp3ywYgMm8jZBJS3/LMt1y1HgSiC3rfGJCK9QzDHAmpSM/7dKwuDVtIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
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
Cg0KUmV2aWV3ZWQtYnkgOiBzaGFveXVuLiBMaXUgPFNoYW95dW4ubGl1QGFtZC5jb20+DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBX
ZWRuZXNkYXksIEp1bHkgMTAsIDIwMjQgOTo0NCBBTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHUvbWVzMTI6IGFkZCBtaXNz
aW5nIG9wY29kZSBzdHJpbmcNCg0KUGluZyBvbiB0aGlzIHNlcmllcz8NCg0KQWxleA0KDQpPbiBN
b24sIEp1bCA4LCAyMDI0IGF0IDY6MzDigK9QTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBGaXhlcyB0aGUgaW5kZXhpbmcgb2YgdGhlIHN0cmlu
ZyBhcnJheS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTJfMC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gaW5kZXggMTA2ZWVmMWZmNWNjLi5j
OWY3NDIzMWFkNTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21l
c192MTJfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5j
DQo+IEBAIC05OSw2ICs5OSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICptZXNfdjEyXzBfb3Bjb2Rl
c1tdID0gew0KPiAgICAgICAgICJTRVRfTE9HX0JVRkZFUiIsDQo+ICAgICAgICAgIkNIQU5HRV9H
QU5HX1BST1JJVFkiLA0KPiAgICAgICAgICJRVUVSWV9TQ0hFRFVMRVJfU1RBVFVTIiwNCj4gKyAg
ICAgICAidW51c2VkIiwNCj4gICAgICAgICAiU0VUX0RFQlVHX1ZNSUQiLA0KPiAgICAgICAgICJN
SVNDIiwNCj4gICAgICAgICAiVVBEQVRFX1JPT1RfUEFHRV9UQUJMRSIsDQo+IC0tDQo+IDIuNDUu
Mg0KPg0K
