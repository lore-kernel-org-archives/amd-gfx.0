Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E9D25030
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 01:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099D710E069;
	Mon, 12 Jan 2026 01:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qn1Sujyl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AC010E069
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 01:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgaQtknDsNTR3rRaHWaLRXDb5kftLYoHEsMn8oLx2eHGoOMIzaP8w1UZa4rGFeE/OeL6p+VrP4ZJczStyj3ZX/nsyvkQJjP7KkWbp45z85BQiNIxwRmaPeLbsPUHQ8lxRW1NV4YgQ0tdGnd7d6ta7Eti9MgQZM6Cip6HHtRJxK7eVe/njIwMih6RigNLtNVkXAJXbfxJi3j7ezBEkvMv6uKiBXcigjjC5cMNg0m6xSiM2njFjG+fbXddtju6DBTo32YCHCOcMgAXrDEJ5+KNYJXRE+BKz9/ETZwkCw6cnHPSJnm/shTsKqIteboEHfadH21PtIEJwXa1RGYQ9R8LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36/V8/L8D3CYFuj35k7vGbt4yJRnwmCfnVKD+2tv66s=;
 b=EpSdPWYv+nhKU1vLAn786NoOTKJYvHcDj3f+RXkxi1Qcg330uDE2MmNtA+yYJw6fyJJ7yVcFl1tiCoBpNkaWsRJERCHSnpQjNEdqtT0CS6spbEdMo3a16EXtlLF/VibwIXBXjthqB0to+2r2MtDVTGBFD+s3ZwKM6vzjZ+WFI0p6LHjEGVMA2Wu3ZROWad00uob4S2dYxcw3JCxubsvsrP2lAQkKaf4gVNE4OItoBA2TgjkAbTmmKttr3U47F6HBGM5ic5BoHIipTdHbGpix0YtiOMq/tZ6sIMfpi/BCuBaoSWIyMjG3EcLhp7YeAsG6l6CjNpniuGhmCfmxqaK8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36/V8/L8D3CYFuj35k7vGbt4yJRnwmCfnVKD+2tv66s=;
 b=Qn1SujylW5XvrY7oBw4uQbh2bjp9Hrqdr0Z7LmmMcNdI9YmVdZevg4/2lC3WAnkfRsybdfOYt6n9uGiAhxw6gG5xsbzZ3wpd5mfGw1EdvjEhvFVdpn4TibvVr39gcb3QfeS4CxU9VakPFEBoL3llQpwAhAZ09iFMFUosrA/4vRo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 01:56:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 01:56:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "phil@jpmr.org"
 <phil@jpmr.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Topic: [PATCH 2/2] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Index: AQHcgUGMTXjMa01VM0e6lQVbMTu0YrVJjMYAgAQ9CeA=
Date: Mon, 12 Jan 2026 01:56:07 +0000
Message-ID: <DS7PR12MB60054C693874AC734D1EB47BFB81A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260109082523.889564-1-Prike.Liang@amd.com>
 <20260109082523.889564-2-Prike.Liang@amd.com>
 <2e383ce6-9cbd-4fd3-97ff-75c5c8cd89e1@amd.com>
In-Reply-To: <2e383ce6-9cbd-4fd3-97ff-75c5c8cd89e1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-12T01:52:57.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ0PR12MB6784:EE_
x-ms-office365-filtering-correlation-id: 214205ad-5c63-4bcf-5817-08de517dc07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MGYzU3hvN1FJRjRFNlVBV25IbUFyU2UxN09zZzV0dVRPTUltYmNZTFROVnpC?=
 =?utf-8?B?aWo3a2ErVjJOeG9Tcm1TZkw0R2JoalkzS0l5Wm5HL1VwUkNZY25VS2RJY3Ey?=
 =?utf-8?B?WlQ2ZE9nOE4wOE9EelVGL3lIenRtZnVSZTJiVE15ZXdpN1FrS2VnczlTeTN1?=
 =?utf-8?B?ZlRNbFYra2YrclhaWGJtMVhzNUYrbDRvSmZFVHpzbE5UQ2NWUkl5YTdRV3Z3?=
 =?utf-8?B?TWJ2YUZGWDZXbWNrTmJiUHdESks4V1Q1TmdHVEN2WE14SU9BcFhZQVYzR0xs?=
 =?utf-8?B?MkhjVGN2aGJPaHRGWDVQRS9ZM2wvSU9zcUFFblRzUHZWVWZ6VnhWS0V3d3Qz?=
 =?utf-8?B?bnlmbXA5cUl2aCt3MXRVcXRQVDIzYk90TWp2dFpBbEw3b0pKRTJWODNEQTI0?=
 =?utf-8?B?RHF5VmlvTmoyM2w3dVlUUHErekdjY0RMMDhrL045NDFIRkZYN25FYzFMMnB3?=
 =?utf-8?B?RkRjbGd0SXhaTmoxelBkZU5EbVh2ZzhqMlJUanM3bnM5WXdsSUhsK2hCcTRF?=
 =?utf-8?B?NDV5cjRJbm41dHhUZjI0QzAwY2lwZTNKbUplWXY5bGVZVlRiT0dwU1hzYnFo?=
 =?utf-8?B?WUpSV2JFWnEzaFBHZ2tZd1B5cjV4YlpueDNaK1JMbWpjUisvUDlOeUVHQy9O?=
 =?utf-8?B?UjlFQkZKOUlaNng0aTNsekN2bVBWN2lleUxuU0ErR2xpVW44ZFBkSkpDcmtZ?=
 =?utf-8?B?blQ2dE9ackU5WGhTSnlWVU9QU0t4cGUvTWFSQ3gxMVhGdVpHLzZsTVJiQUpq?=
 =?utf-8?B?RU9adnh5ZUp1UzZIOXZ1QXRKMXhWV3Q2NXFyT2pwUEwzU0JzM0dUNDROSFNy?=
 =?utf-8?B?WlJQQWRuQ3ZXYk9nR0UyTnpMZkFIWVpUejFiWmVIUVBES0w3SUlFMk5TcjdK?=
 =?utf-8?B?dTM4YzVNU0N5M1NNMW1ZTC9YeU40cE8xUVFFRTBVMUw3VFVSM0h6WUpLRGcw?=
 =?utf-8?B?ZHJhcGxXSis2QWNaK2lsYzQwYXEyZkJwZ2o2cjZuMVNZOXVxMU1aZU1Udis3?=
 =?utf-8?B?c1Z6OURxN2RUa25pdGpBdjM2ZGYzRCtScmI2SytXaHJUNXllZnp2aGlIbW92?=
 =?utf-8?B?bmdJbWtITzJXTXdyV2hzeUN3QVlFcVRwdW9wQ1AxSURsdzhYck1RTmltbk5o?=
 =?utf-8?B?QVRVZTFqaFNRYjlkbnZ5V3hIOVl6SlNIV2lrczkxN3REZFlRL3JuMDdFRUJM?=
 =?utf-8?B?Y2lXQzc4OVRrTVhhVGh6WXVrQjFjbG1ra3g0MmhyejdLYlBYOUI5dVBvS2k3?=
 =?utf-8?B?MjZSV3BXQUh5WWRNSHhFNFBRaEdvMmp5cUNKVk5IRVhyRjl2cml6VVBiSi9y?=
 =?utf-8?B?bjh4YmZ3cXZ6QW9MMkJTekZWN09RSW9WWnZVM2N6YnFCelRVdmE4bXNqMmZn?=
 =?utf-8?B?WkZtNFFhRkl4SDRNak1xemNQM3hFVTRpRUlDV0dIaVRGTHNYOWlCaGRXZE5o?=
 =?utf-8?B?VlRiVDZpN2IyMmZHcTlVYmljZEdmdDNPSmJFd0ZlYkJHc2V1bFU1cmJnaitV?=
 =?utf-8?B?N08xWWZURlVBSVMvMXVtaDJKL0ZFcHNEL214elFaNEtZK05EcDBJY1VNUU9P?=
 =?utf-8?B?bFdJTjk4QW9PZVBleG5vTVd0dnlpc0h6MVRTZDgvK2hJeGMzY05rYVlrRk5V?=
 =?utf-8?B?N3BGUEZ3d0pVQ1V0Y2o2b2lQbGdJRXc1K2tKMGxvN2ozdHc2eVI1RDdqZFBC?=
 =?utf-8?B?cm5TcGRjQXR5bW43RHBHbVc3QzNsRFQ4WTUxUGtOZmkvMUNSeDFwbXhUTXg5?=
 =?utf-8?B?VmZCalh3WGpjOWlETCtlRWx0T2YwUE9sTEVpaU5JdVBPMUdkRHp6VVBZTXR3?=
 =?utf-8?B?Vk1QaisweTJDc1ZxUkpJZ0dLa0FEUHh3RGlxQm85eGtCUFJLNW0vTEZLR0tN?=
 =?utf-8?B?MmJDL0loTVMyaFFRNXhpMGN4M2g1YmkxUlZHSkphcmxjc1dUZEk3Z3VPc1dN?=
 =?utf-8?B?b3UrTTBxQnZQM3AwQXpLdThKKzd6K054bERjL3BVY1NMK09lclBtcmo2ZUdD?=
 =?utf-8?B?M2s1M2FLMUFxNjJoL011K09adzA1dmFkYVhaUHB0ZDRDL21QWTFJRkxTYmhV?=
 =?utf-8?Q?g+FWuk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dEWFovdnRHZkk4S0dEWTFYR0FQeUtmcDZWTEdta2Yvd0VPNmR2TEVFMmRq?=
 =?utf-8?B?VVM2dnRSZ25jc1Z5S21TTHFRUnVMcVBaVVRlQXNkR01uMFBxNkJNdS9NTVpt?=
 =?utf-8?B?ZjFqU3F0WlBhTVNraUZMRThOdlNZNU5hVmhxc0tkUW4vMDVEaG5ObDFaVHpk?=
 =?utf-8?B?L1AvdHJxUVNKdGFnQ0krZGJtekhRT2tKR1h3MW5LNmRibnJTbndDMUdIM0Y4?=
 =?utf-8?B?RUxSbzEvNGZPck52RndSQURLZ3pNaEpxdkYwR2Y5TjZLeDZxR1VLblVveitt?=
 =?utf-8?B?WTVIWVRHVDFybnduK2xyelRGcmVKVXdkWnp4a1J3TXhqajgxRFlDNWZycmk1?=
 =?utf-8?B?ZzB4UmZHOXQ5cEpiQzA4SUpscTNrOHlUVXQ3cEUrVVcwUWNERk8xTVVKeHhE?=
 =?utf-8?B?U0NMUHV2eTVMOXRYNGw3Q1B3YlZXKzBwNTltS05yNEtUM2NkUWpWZ2o0cGdX?=
 =?utf-8?B?NE5aOU0wSzh0c3BacTFLSURjUWs5b2lmN3Rrek9rQk9UZ3F5RnB3RVJ6Vlcv?=
 =?utf-8?B?R1NUb21WN25LZ0JQUmUxVGtIQ05MM2FiZXR4QmYxWnBDMWtkVk9iVHNBWEd2?=
 =?utf-8?B?ODJlOU94cWFBWk1KRytMa1krSk93aC8xeE4xMU9EajkwbytLcHhFRHZhYWlh?=
 =?utf-8?B?aFVvSmgwbjgxZXJwL0p0Vm43V2NPMzZCUmdreHNlL1AxZXh1M2ZtN0hjcjhO?=
 =?utf-8?B?MmVtZDBSb1lnN2FjQlJwMjhUcjRKbW9tVmtVbU1OZG9RR09ZeXhXaFViVXZD?=
 =?utf-8?B?aGZkcldhTTlOZUgvNjhQL2ZTdXVQZngwL1gzZUVOVXhWbGdoQmJyN1I1bXNp?=
 =?utf-8?B?b1NwQzdrKzhqSk5oelFSeHVCWkh6c1RzZEpLaHl2TmhzTlJvSGRPSlc2bkVv?=
 =?utf-8?B?dXNucHZ1SlA0QzJ0VC8vNDdJaHdJVDIraVU4S3lDTnp3RC9wekRVTXo3blNa?=
 =?utf-8?B?K1dXTUsxTVhnLzE5Uk9wVGFmQXVNYW5FejRpVDhORFBsSjZWTFJNZEZIUW92?=
 =?utf-8?B?L0JMcW5WSHN0bHgzelQzRkFleHllSFp5ajhOOHJ1KzdiUjRweTBjYmxWZkdF?=
 =?utf-8?B?Z0x6WWZVVHVxR3BYNEdWOSt3M2JUSmQrQ0FnQ1F6SWx6QWd5V1BCcFp1V1Vp?=
 =?utf-8?B?cnNKRjB2ck5oU1Q1U2U2ajFiUWpUY0oyd3E5RFN3TVlRR0ZXU2dXc3VnQlND?=
 =?utf-8?B?RGZKaG1yRVA0L3Ryd3pFREcvdTJLOEI1TkgrNXhzQXNUaG5RRmFJcEtJUEpC?=
 =?utf-8?B?ZlgyeXlaN2dhQ2tXOW5JQWhOUXRUa29Na2xwdDE3alYvUUdGeWNyZllkM0d2?=
 =?utf-8?B?Skh4eFNKZGVET0FkcnlIK3B5YUVtV3dLaW1MQ2E1ZElKbDlvL2hEaEo3bXRx?=
 =?utf-8?B?T0dtMUVQNlZjbWZ4VWthNEZPMVVVV3licEtKYUFJbmw3TG9LcUd5VEN2ZFAx?=
 =?utf-8?B?N1FFV2VVbzZaMFhqaFpHU1ZKM3h0eGtSQUVJZFBla0luejg3alFwaUNUeUZq?=
 =?utf-8?B?K0h5Q3VxZDM5SFNtNnJzd1JaUnN1UndxSDFxVDZ4aG5rZlV1RUpraWtVWUxR?=
 =?utf-8?B?Q0pzME1DL0NZZ28wSTYwUG5iTDJzN0JtbWpkNWJya1RnM2VxTGVSZGMwbmJO?=
 =?utf-8?B?bFdESFZxYmdVcUJSQnhKS2ZSSEZZaWRjbFprRkVSVzVYNWhSRUQ3VUVqTlZs?=
 =?utf-8?B?VlM5ajJ1cW5MSytwc2J0UU5mczZNdVRoaUhNMGRicjZJZW15RXpHMkE1ZGF4?=
 =?utf-8?B?WGlhMU5VV2lVS1FUQWdZcG9vd3hrTW81T3NIbUllMGJSSmU1dEo5V0YycGZj?=
 =?utf-8?B?NkorMHRzWTRSZnBNcXdIeEdyVmZLOE94MXpDcDRMRXhnUVUxODlXM2Z3dGdm?=
 =?utf-8?B?YUM3TjZLL0toZml1czdEYnVZMjMveGFwY05qc0NWM1FVeEdlSDFOM2kzcUpV?=
 =?utf-8?B?UHRvM2JsNVo4d3FUeWV0UTZiREdVZnJIN3h0UlZPWk9nTTJ1U1o5MUxQQ2Vx?=
 =?utf-8?B?WUg2WG4yWkVRWFlUSVRBb0tQVjRXdGl3TWZTSEVIMG9sOXBYUEtqeVBOYkVG?=
 =?utf-8?B?eUk3QmJnOEVWTGE4L0NHbWVVVG5sLzJvOWhZMStoZUZ3UTUwUWxoOWt5ZkN1?=
 =?utf-8?B?eTdQaUFXTnNsRTF0dkF1QWJKWDFOd0tXMEdrNEJObHJHK2dBbStGUndRbXpk?=
 =?utf-8?B?c0VWSWwxUGpjUXZ2YlNxSjVDRVRyWXRTVlVmUy9wTWV0ZEs3WXhZVVpiY2U0?=
 =?utf-8?B?Nm5sTldkaFVhaUFIaFFMN1VnR2cxVSsyaWJnTlJNUXlSOVN3QmJBWXF5RUNt?=
 =?utf-8?Q?aEpWTRq681uIKBW7Bl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214205ad-5c63-4bcf-5817-08de517dc07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 01:56:07.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcfRd2+yQifJ34s41OVTI7zV+oqomuBpLo+/8Qa20s3DTZThyQFRZldHerkisdwS
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

W1B1YmxpY10NCg0KWWVzLCBJIG1pc3NlZCB0aGF0IHRoZXkgY2FuIGJlIG1lcmdlZCBzZXBhcmF0
ZWx5LiBJ4oCZbGwgcmVvcmRlciB0aGUgcGF0Y2ggbGlzdCB3aGVuIG1lcmdpbmcgdGhlbS4NCg0K
UmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDksIDIwMjYgNTowOSBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IHBoaWxAanBt
ci5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHZhbGlkYXRlIHRo
ZSBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkNCj4NCj4gT24gMS85LzI2IDA5OjI1LCBQcmlrZSBMaWFu
ZyB3cm90ZToNCj4gPiBWYWxpZGF0ZSBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkgYXZhaWxhYmlsaXR5
IGJlZm9yZSBmbHVzaGluZyB0bGIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFu
ZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPg0KPiBUaGlzIHBhdGNoIHNldCBuZWVkcyB0
byBiZSByZS1vcmRlcmVkLCBlLmcuIHRoaXMgcGF0Y2ggaGVyZSBmaXJzdCBhbmQgdGhlbiB0aGUg
b3RoZXINCj4gb25lLg0KPg0KPiBPdGhlcndpc2UgeW91IGhhdmUgYSBzdGF0ZSBpbiBiZXR3ZWVu
IHdoZXJlIGl0IGlzIGJyb2tlbiBhZ2Fpbi4NCj4NCj4gQXBhcnQgZnJvbSB0aGF0IGxvb2tzIGdv
b2QgdG8gbWUuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgNCArKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPiBpbmRleCA2ZDdiOGJiOTUzYWUuLjBlNjdmYTQz
MzhmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMN
Cj4gPiBAQCAtNzgwLDYgKzc4MCwxMCBAQCBpbnQgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bh
c2lkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MTZfdCBwYXNpZCwNCj4gPiAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICAgICBpZiAoIWFkZXYtPmdtYy5mbHVzaF9w
YXNpZF91c2VzX2tpcSB8fCAhcmluZy0+c2NoZWQucmVhZHkpIHsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgaWYgKCFhZGV2LT5nbWMuZ21jX2Z1bmNzLT5mbHVzaF9ncHVfdGxiX3Bhc2lkKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgIGlm
IChhZGV2LT5nbWMuZmx1c2hfdGxiX25lZWRzX2V4dHJhX3R5cGVfMikNCj4gPiAgICAgICAgICAg
ICAgICAgICAgIGFkZXYtPmdtYy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwg
cGFzaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDIsIGFsbF9odWIsDQoNCg==
