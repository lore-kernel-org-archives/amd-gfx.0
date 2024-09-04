Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B84CA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 08:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E9310E6B4;
	Wed,  4 Sep 2024 08:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqQOecxn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C364810E6B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv0SrHVcZVXa/51uXw0Hfd65cYrvqEtLzC3PdyIALdP0lRHmj5k2QXDogkd5BUqpPJb9U/NUD1HHa9+rNJNtpVPYLlV0tY9Ec3YVX1F/MtAw+uv2sdZI6ck+JOjhjjpqLkL6rF1Rp/KhetI18UDfnyWKrbzjY+8GSCaIMnOZMS8SzEHjUDnADZvF49QAIvyGSoDYE2VouofpBZW3mlZL4YaQ0S7b/PI6j6XrwN1pSgj//NiRJPJ78MocXb4jP0Hf81EqkB5GJeMpKNZWbcQeWRRr3hXK9arpmX7cg6BXqrBQ+zrWVieEyiIB+NBu8nHIoMcNXKMa+cccTrxj8oYBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKUckcORFIJaEN0TiuilB4BXHa1Z0IMV3ZfpOdQUzRY=;
 b=NzGuddjTJNiROpg/egjIQ069mDeHiB9kCt5q9Q9KIg/e7qcaB7obgRBYyn1gVd7aAh7GoRPrWGtTOYmTc9II7aWfyB+HZRICvYHlH5PGF/xk/OpRUTbYouv2bOWtXqZVU6q1+7lL/QD5VARWlUJAXRd50TivIAO0qSA0T9gE7SSW1cw4jm7VQJ4k5ltF+EWZ2CuzCLDuFL8Jmu2gOm2HUk6dRTTshcjicMbLIcCwfFZ7TP2cKFkZHmPL+/MSVHxenTG7aZ1ZQBbqoJNPd2TqixHDHXUlUG1S0Y46vEV662kBzceTV8PURh63oHdIXVicXqt1Ep1z/28F6TaA6W+ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKUckcORFIJaEN0TiuilB4BXHa1Z0IMV3ZfpOdQUzRY=;
 b=sqQOecxnjnBn693Wsfufgvc+sq/pk6wMdbyrcEcnv2lY9Tp08jTCacxXGZ3HlASrbykXR9omFhgKWUfXIueKAJ8CnFOgVCpUj8B7BFk93cJLtG0S6kJHXZ+lBrtPCmGuW3SnQ40scrnz3bVl6e7dNGpvxl1gP7lZh61akq70Ghc=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 08:02:36 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:02:36 +0000
From: "Song, Asher" <Asher.Song@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
CC: "Zhou, Bob" <Bob.Zhou@amd.com>, "Song, Asher" <Asher.Song@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a call trace when unload amdgpu driver
Thread-Topic: [PATCH] drm/amdgpu: fix a call trace when unload amdgpu driver
Thread-Index: AQHa/f1JLtf+k5hSXkyCv3jEVyS9SbJGDokAgAExq5A=
Date: Wed, 4 Sep 2024 08:02:36 +0000
Message-ID: <DM4PR12MB5136BF4DA54A0C6FF60B27DF8B9C2@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20240903123136.555278-1-Asher.Song@amd.com>
 <5e54cb90-c896-43cc-b0c9-0a0bc9d75a99@amd.com>
In-Reply-To: <5e54cb90-c896-43cc-b0c9-0a0bc9d75a99@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b9f3b8da-30e5-4c62-9c68-eddfec1a3752;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T07:43:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: 28b8ebdb-3ee8-4c3d-b63c-08dcccb7f042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YkVPQ1lpbXhXNzc5S0cvTjVHNkRJTXNodWNsRzk3NE1vK09pNVpyMFRRNlhT?=
 =?utf-8?B?QmpBTlQwczFtM0dWdHQrdEJvZVNJb05PK1N0ZkJWTStZdElqdVNYaEp2Ulo0?=
 =?utf-8?B?cDVFU09IVGNLaEQ5U3h2ZDl0TzUwTEdMUUpXdEgwNldQZFN1ay9aYzNJd09S?=
 =?utf-8?B?QXRiS2NGUk9sSmNtSGxNYWJud2VDaDJENGF3RVVtamxsMVE4RTljMWFKL2pn?=
 =?utf-8?B?N3NqU0REUlV2UzIxYWZ2SUtFcmpUb0QwUjhXR2d4UXp2c0Q2cThKVXZ2cjlW?=
 =?utf-8?B?MnQ3Vlova0VHYjg3U3RPd3YvcDZyYWEwZnlzdzBidm1DSG4yMU4xMjlBdWIy?=
 =?utf-8?B?Zm5vK1pGcjBweU1rb1ZyTUNQOGVQNjZXYVBaOEZqZzZBMDhqb1pTczNSaFlC?=
 =?utf-8?B?ZDhlUkpWcFc5RStYSFBjOU5tNzhZSjJtdnIxUzkweCszTk9PZzhQanJrdXF5?=
 =?utf-8?B?N0tuQ0VNT2VzTmliNHpXbFZWQ2ZWc1RBL1pLVFF6ZVNqVXdtajd3Um5WODVZ?=
 =?utf-8?B?U3htQzBkL0tMSTdUWWpHRzM3R1luUkJKTjJZWHM3eEJQZ2xBakFvSVFRUW5p?=
 =?utf-8?B?blNHL2JRNkVpRUFyWVVLNEpiYU1NQnBsKzdiVUo3NGJoWXpWSUxEbVJFYjE2?=
 =?utf-8?B?WGQxc1RqT3VPOUVlSlQva1F1MGJ4M0Z6cFhUSzdoOFovblVnNVlLVDRjWTNU?=
 =?utf-8?B?bG4zQUNKV0hnUTlOSFpTZGt2WFpwMkFBTXdKNExSSFV0VzlVRE1BUFB1QnF2?=
 =?utf-8?B?cmxQeEpzRDhuL20yZ0J6WnU1Tnh4V0RKaXo4MVV6WjZucDRmZVFrcmRZOFQx?=
 =?utf-8?B?QTFjQUczVHVLQ2oxYmczZlU2MHhnYndVYSs2VGVrRzY2Z1cxVCtDd2lxZkZM?=
 =?utf-8?B?WFB2Wm40TmFscEI0OERNRUZYbnBTNnZWTS9mMG56QzVRWGcwYTVwYXE4ekcy?=
 =?utf-8?B?dCs2VmdaM1dNM0lCN1dWaVVGd3dHai9jdWdmRVkzWWRYQ1hFRFFVMkozcjZi?=
 =?utf-8?B?cVRnNlFSY01zZWZlWm5BZG5IcmR3UlgyMndKMEgzTnhndWQxcWt0R3IvRjlV?=
 =?utf-8?B?R1kzbzZoalVCVFBBV0ZKYmRIc1pKUDJreWlJbEhuYys4d0xVdHlvczFyeFZ6?=
 =?utf-8?B?L1dad3drTGhOaVljNnBqL1AwSGdZZ1JWNW11VEpHaFExT0hMaE9QSkxpQVYx?=
 =?utf-8?B?eE9XOWhmZ2VsaU1ZcmM3QWhFOEowc0xVcjBqZk01Y0d1OEJHMUljR2hxQ2N1?=
 =?utf-8?B?aHNJRTlEVUd6NUJVZHhyRXhyU0EwN2NWazNWRC8vYlhlZFM5eTlDQmZTeVlq?=
 =?utf-8?B?MjdUREtiUDQ5eWd4T0ZJQUlQWENxNmxqVGZUZGEvWnJ3WmM3OTNoVHJTaERl?=
 =?utf-8?B?SUVoR2FSRnZ1cVYrWGtxU1VHblA5YkhlMEhLbFI0M0c1cmVpcEZWODJhamxk?=
 =?utf-8?B?ZG1yRkJiTXdTbTRLS2F4U0k3c0tGNllsZEI3M29jMWZwTWpwNkpLTXFOMlYy?=
 =?utf-8?B?cE91eHlRZXRzRFRiZmtQREJ6SXVzUy8vam85K3RyUVhKREJBVFJGbEhUZERv?=
 =?utf-8?B?cHRhNGRzbHR6RlFuNXpiOFI3cEJndzdFelhoUUMyU3NwR0ZVN0Z5bjlZbm9R?=
 =?utf-8?B?Ty94RWo4cnJ0a0h1OVdteHIrKzBWck80bDJNeE1DZkxzM2MvbytmbUptRXZS?=
 =?utf-8?B?WkJnQVhRTE5MQ2JGbzgwOXduVWZmZkIrOE5leVozeW5lOG1nQnkxUEZxZml0?=
 =?utf-8?B?ZkpuWHRhL0FXMUFiU0JPSkVMM0JOdzIrcWpiMWNoUUs4a05hdUVWREdIMnYr?=
 =?utf-8?B?VnppbTZaM3BzOXRKUWZyT1lwTmI4R3RTMWxDb3V5clIzTUV3bTlVQXRjVWpR?=
 =?utf-8?B?cmY4SS9NVUpRK096UWc4UjJUWlA2am5EU291RTc4NTN5RkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNGUGtRTVJDOVBGMFZJeDhpY3RYSmxUSTJOV0FVd3dCQWZ3YTlXTjZJUW5o?=
 =?utf-8?B?dnpscnNEU3c0SVBmSHhZVU13VVMyQzE5RGNFWS9DUkp5UGU3Z01HUzJNNmpE?=
 =?utf-8?B?Mi92VE1VUkQxWEwrU00wbjc2KzhhbE1IUDhXY2tpeUdHZktnQzQ1Y29lL0sv?=
 =?utf-8?B?OXNzM0VmMngwS3VaYjRqNGpzQzluTy8wc1U1RWVJaXN6WVpkU3N5NmJLYndQ?=
 =?utf-8?B?NEpDemhWazJKYlVSL0xYdjBCZkRSaFNSQ243YVprelBXeTZTc080U2hicWMr?=
 =?utf-8?B?QWtuMXRoZTlWK01xYlJycFp5c2g3SFJOT21vN3ZyeUR6ZHFlemFsajNYUU9O?=
 =?utf-8?B?d3JrRURTa0VlRHNoRjZ0WjlWUnRWOVdRQ3Iwa3dLYTcwbFgwdDVQbHhPRjc5?=
 =?utf-8?B?RGpmazJWb0dwYW1qRFlIUzRGQW96VUpMWlRSK3poRUVKK2IrUG1OcG1qcU5Y?=
 =?utf-8?B?Mmwrc0d3SmlqTDBnWlkwNmVXSGFGTGVPTHphRDR5MzZvWXNkMi9uS1RhWnU5?=
 =?utf-8?B?SWk1c1V6R3N4NXRBb01IU3NWOHpqcjJGcVBiOFljMGtwcFo2d1JpMW5tRDF4?=
 =?utf-8?B?anFCYkdWeHc0bVlPMldzUEM3OStsNWlMRW5DMDh2YmhMbVdIZkU0L09wVTI0?=
 =?utf-8?B?eVlsNWovd3VHMWdhMFZjOG82aFRtSEZHRjBjRVVaN1BZMGo3QnJVU2FIRkQ5?=
 =?utf-8?B?V242SnViOUNPK2NRb3liQlhzcjB1Y1RrNHFQK3RZL0lWaVNBb0VwN3lTVXVw?=
 =?utf-8?B?SHdjOHZVM09mQ09CUFZGeldXRDhoeC9nSFM1TkcxQVk1ME9IZFJRR3pzNGVh?=
 =?utf-8?B?bC9mRmxjN2hMVStEUFkvTGxMaG9lUWNhZytTUlRrQTVReVVUYlFaSENZRm53?=
 =?utf-8?B?c2lkOWo5NXFFems4dWc4MkVVOTdyRkVBSzlXc1ZQdThPMnZ2UVRsZUZTZGFX?=
 =?utf-8?B?WFc3RWtCTWdnN1lka2NhdE91aUFNTGRkSWxlMkZIcFcrelVaYlo4NStLSVhv?=
 =?utf-8?B?aW5mWmtCZTNCVVB6ZlAyZ2ZnSFpsOGJhWWQ4MTY0NTBMbmJxL25SaGlETFNP?=
 =?utf-8?B?ZS9Ec1pvblFiMmNqcWUrMnBHT2lQbEcvTmcvR2hnVEd2NXB1YzJxaVRScDJp?=
 =?utf-8?B?L0hjWlZ6SGkra01Db2JZZHl6czJmQXRHdGpoQ1pJV1JZallyUEg1QmxCeTUz?=
 =?utf-8?B?S0Zaemd4K0xSM05PNWdvRXdmMjFDK3JhRFZkMi9LUFJ0djBRVlJrNE5DSVRT?=
 =?utf-8?B?UC80dXVGTFB6N0NROVBxVmI0NDc0NXVjbnZqcjV5dUY2Zlp6cDFvM0VQOFpI?=
 =?utf-8?B?Q05nOTRlaGRKTkQ1NitEVmlzMkJLa0U3dDQyaGoxdmwxVWxTeUw4NkRQdWE0?=
 =?utf-8?B?dy81Y2pZUFp1ZVd5cXNGbW9PaG5aNTRmUWZnNG1lRGhHcGlnRzlvWmhnaEdE?=
 =?utf-8?B?bFkwcjZnMlhUc242UndNVEhVZk1QbGw1bEdqNHBiQUxZVnp6UVhzS2t6bXIz?=
 =?utf-8?B?emhBbU50WWtvNGtEM3gwUmRuOWNJSndxVVJzL3ZGUkxRbmFSUGNieHlrQ01L?=
 =?utf-8?B?aTdEdVpvOVR3UHNlK0dJSENGallsTGpxQmdRcnliRFRPK2c2c0NMblpVck5z?=
 =?utf-8?B?SnZJdGE4RDc1TnVURW5kSWpxeXA5cFVXR0pFL2M3TVdENVQ1Y2JuS2FsTFpF?=
 =?utf-8?B?b0djVjZDcXNyWklybHBiSzkyY2EyQk9KdXhxM3JPR3FXT3piVjMxdUJraGxj?=
 =?utf-8?B?Snhpb2hCQ0NQNVJueGNhT0M4RGNDZzBuS1doSm1oTDB5ZmgyYlZkZzFNU3R3?=
 =?utf-8?B?TkEyL2dIdW5vZjFSNkFLYTNHa2sxYVlEYWFvcnZnMFBYa1Vnc2JIMzNzd1h6?=
 =?utf-8?B?RnJ1NGNGVkl5M0lwZnl3OXFYLzdoWkg5RmNCK2hJTTdGNzRuUzlRV3gxY3p5?=
 =?utf-8?B?VFpLQThiVW90SGpWeml2OXY2M2c1S1RNQmh0VUUrYzVGYTZBU001bTFIVGNI?=
 =?utf-8?B?QnBxeUFaMjBsdEgxcmhnTHhERVB2VjRrZ0FZbzNCTU1janJicTNNNmtpUDhZ?=
 =?utf-8?B?V1dsTFJxdHNLMHVRZWpHNVVlTmUzMUNhN1crNGEwTVU5YlRkcVFqem92N0J3?=
 =?utf-8?Q?mV1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8ebdb-3ee8-4c3d-b63c-08dcccb7f042
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:02:36.1532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yC63tkSSic/5tm4XVJqqYfTmyGJDItkLjJo+2D02tB0tiU3BeMr3yYz9jeDTYqmybhFGTKWUzlUK/Qsjht4/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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
Cg0KT24gVHVlc2RheSwgU2VwdGVtYmVyIDMsIDIwMjQgOToyOSBQTSB3cm90ZSBieSBLb2VuaWcs
IENocmlzdGlhbg0KPiBBbSAwMy4wOS4yNCB1bSAxNDozMSBzY2hyaWViIEFzaGVyIFNvbmc6DQo+
ID4gSW4gc29tZSBBUFVzLCB0aGUgYm8gdHlwZSBvZiBHQVJUIHBhZ2UgdGFibGUgaXMgdHRtX2Jv
X3R5cGVfc2cuDQo+ID4gVGhvc2UgdHlwZSBCT3MgaXMgcmVsZWFzZWQgYnkgYm8tPmRlbGF5ZWRf
ZGVsZXRlIHdoaWNoIGlzIGFkZGVkIGluDQo+ID4gdHRtX2RldmljZS0+d3EsIG5vdCByZWxlYXNl
ZCBpbW1lZGlhdGVseS4NCj4gPg0KPiA+IFRvIG1ha2Ugc3VyZSBhbGwgdGhlIHR0bV9yZXNvdXJj
ZSBpcyByZWxlYXNlZCBiZWZvcmUNCj4gPiB0dG1fcmVzb3VyY2VfbWFuYWdlciBpcyBmaW5pbGl6
ZWQsIGRyYWluIHRoZSB3b3JrcXVldWUgaW4gdHRtX2RldmljZS4NCj4gPg0KPiA+IEZpeGVzOmQ5
OWZiZDlhYWI2MiAoImRybS90dG06IEFsd2F5cyB0YWtlIHRoZSBibyBkZWxheWVkIGNsZWFudXAg
cGF0aA0KPiA+IGZvciBpbXBvcnRlZCBib3MiKQ0KPiA+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+DQo+IFRoZSBjb3JyZWN0IHRhZyBpcyBT
dWdnZXN0ZWQtYnkuDQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXNoZXIgU29uZyA8QXNoZXIuU29u
Z0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyB8IDEgKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiA+IGluZGV4IDBh
NWM4ZDk3Nzg3YS4uOTkwMTdlNDI2NjE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jDQo+ID4gQEAgLTIyMTYsNiArMjIxNiw3IEBAIHN0YXRpYyBpbnQgZ21j
X3Y5XzBfc3dfZmluaSh2b2lkICpoYW5kbGUpDQo+ID4gICAgIGlmICghYWRldi0+Z21jLnJlYWxf
dnJhbV9zaXplKSB7DQo+ID4gICAgICAgICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiUHV0IEdB
UlQgaW4gc3lzdGVtIG1lbW9yeSBmb3IgQVBVDQo+IGZyZWVcbiIpOw0KPiA+ICAgICAgICAgICAg
IGFtZGdwdV9nYXJ0X3RhYmxlX3JhbV9mcmVlKGFkZXYpOw0KPiA+ICsgICAgICAgICAgIGRyYWlu
X3dvcmtxdWV1ZShhZGV2LT5tbWFuLmJkZXYud3EpOw0KPg0KPiBUaGF0IGlzIGNlcnRhaW5seSBp
bmNvcnJlY3RseSBwbGFjZWQgaW4gdGhlIGdtY192OV8wX3N3X2ZpbmkoKS4gVGhhdCBzaG91bGQg
YmUNCj4gc29tZXdoZXJlIGluIGFtZGdwdV90dG0uYw0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3Rp
YW4uDQo+DQoNClRoYW5rIHlvdS4gV2lsbCBzZW5kIHYyIHRvIHBsYWNlIGRyYWluX3dvcmtxdWV1
ZSBpbiBhbWRncHVfdHRtLmMNCg0KQmVzdCBSZWdhcmRzLA0KQXNoZXINCj4gPiAgICAgfSBlbHNl
IHsNCj4gPiAgICAgICAgICAgICBhbWRncHVfZ2FydF90YWJsZV92cmFtX2ZyZWUoYWRldik7DQo+
ID4gICAgIH0NCg0K
