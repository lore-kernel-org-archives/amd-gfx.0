Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D95C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2540210EB5D;
	Fri,  7 Feb 2025 15:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pIhqXbtq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C19110EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjvxjruCLgxt15/2pjU2dij3XMJ5KTFRKhGqpkEABmxqKxyKYP5yhGyYG+hXD/Zkhuu/82DEm4Trpw/FLXIYxTu7aq07s2P+gR+2uLTGDI5l4Xn6NH8A6jEk7kFsO0nb+oAzKNLFTGNBZQgQkDRXFBF26Ps9EqEWCfTpFnv+azW/S5iVW0cVeURC5MVgo5Lm4u3mbMfhDynULlsmy1NhcpJv+0SAjcjToo4NQoDXlbbUbFiisyGIqBhTSa4YAFus5ZGW8GaddBWvHhyuXrR2n2T+7OgB51Kk7zOE79MUmiEGm4K8OFiQcO3SQy6MLBgboeq4tFwH4Mfb+4J6mI1Q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe/3aineZIKoEz0RqFQdKiEQh//kVYeN3Xah/ZRHr9o=;
 b=TJ6FA27NpOM+CFMrcDI74lS0+9VECbHwlUQZs5XRHwIst8ujC87oUohMPUau9IyA7i/30VZXOY+ZRA3sCE5hNCAn0QsgPtF0+MuKY+Ft3EtJMLB4xD5JXtBdLonZcfxVHa5pO7m6ZClLOIYwt60jVQM/uO1+VonFbj3o5dq/50gDP4xkj1gLvtZggb1u9U6h2d0AAefotkoI4jCPQUFQjPFS8eBzy7h0PQLeHSQCF0OeP8/57Vy0YAqyUL+L1YC7Z37aGw3Dyvdhgg7qbaCbWch5VwaKjiULXkECzmN3NjucSpk15VGTrC5XpLf9Q2RdmdbKlb/NLZRxYd6Y5/zqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe/3aineZIKoEz0RqFQdKiEQh//kVYeN3Xah/ZRHr9o=;
 b=pIhqXbtqZ8FtfVWOFfmb/F8IS/mSD6XfErW8JPa3I7RJdti6kesdVNFckWOOUgbxwzIHIW9ZReTsKX7v3HGCh+4a1UPh6rBvjNB6/f4Ea0wF3lCuNKaoLWniX1Y1di/N6vaHzwqpWavu6S9d0yR9Q+VzvLcSDuCRRHxRH+W4TaQ=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 15:56:28 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:56:28 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQgABLTACAAKRScIAACgyAgAAAHPCAABAFgIAABqQA
Date: Fri, 7 Feb 2025 15:56:28 +0000
Message-ID: <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
In-Reply-To: <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fddba0da-68aa-4eb6-a52e-e5b892ab8713;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T15:54:59Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS7PR12MB6189:EE_
x-ms-office365-filtering-correlation-id: b74568d8-26dc-4b0f-f50d-08dd478ffb89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MW9jaHZ4OEhEaG9TR290NUlONnRJYUF0TkIxTCtIaW0yU1RtMzB0WHFJS0Fl?=
 =?utf-8?B?SzBpVnVMRWNPTGo4eVo1UkNldThBbEhIYjhpMy82TWlyZit1Qm95NlJZMUEz?=
 =?utf-8?B?TFBEalNqVlVhY0tRaGtDRGxPQzU3STg2czI3NjNGU3JwcVdZeTZFVlVEbW03?=
 =?utf-8?B?cmpLWnhyVnN3UzAvUlZTYVkzNlF0WHZZOG56L0dNZDFldVJGdkptNzNaSEdT?=
 =?utf-8?B?U3MxWFM4RzZXN1ZLTk9sSURidEd1TkIyRWJwb2lqZ2dJMm92bzFLLzFSVmd4?=
 =?utf-8?B?UnVhZ2F6S2ZWUzdhbUtMR1FqOWQ3cVBaRVB6ZUZiWmdudHRBVGRTZlpXZm5T?=
 =?utf-8?B?eGtTd3VlMEhVTXZtOWRHYndndjZpSXN4RGdqenpxWjlleEVKZThRaFBGVmJj?=
 =?utf-8?B?dlJoR1ZxN2xpQ2FPZ2xHQXVnNjZTS2xBbmt2SThPUXAvWHNSdGNzR0tuczNj?=
 =?utf-8?B?WTU3UEwvdzhwbURpaXpyYTFCOVorcWRDbC9lTzRoalBjdWxnUE9PcEl3VmF0?=
 =?utf-8?B?Z0FLMWUremR6VlJTWllMZ2Urb0hYMEc0WktIa3BNaTFQK1BGQm5YSVFXVTRK?=
 =?utf-8?B?V2hrYmtwRmNSQlEzWWVxY3VwV0prL1prK0tNbzhsUHlIajVNZU04djc4Qzdo?=
 =?utf-8?B?Y2VZQVVVUzRzUkxjSmtoVE8rS0FBbGJWS21HeUhIWGoxZE1nS2RIenh3VmxO?=
 =?utf-8?B?Z1NMU2lZSDJvbTFZUDM2V3ZBUk9BVnRkZXUwaGdWUHBVaDJIR0daMzdxbTZF?=
 =?utf-8?B?Z1ZWQTV5UnhqM1FlTlkyNXUxWnFFem4zL2FYMTdiUkg2Y2c4VTVMMk5TeENM?=
 =?utf-8?B?UjUranFxWUY0cTRpMlFmTHladWJjeXFyVi9JQXdUZ3BzR3F3MWNXbHc5clZL?=
 =?utf-8?B?UGZqWjBxWnN3ZWQ2TUIwM3MxaXNLN1B6Y3RTN0tUblRVcHp5Ym5vUTFLalRH?=
 =?utf-8?B?RGRSMUxqS3g2ZjhQamx5NmZ5L2tIVVhzTURFS2NORzRzSHhGcHVlZHB2MUZ3?=
 =?utf-8?B?MEdyMTg2MG95WnVEYnhqWDNXUUwySUpVUlIrWjBpVW1sckMyOUNjSFNiVU9z?=
 =?utf-8?B?V0c5Rnp6Y3I4OTlWSFJoeVorZDRsbUdrMi9BYXNJZDg5MHM5QncyRm1MdkZn?=
 =?utf-8?B?b0xpQlBEWjBrbHNjYlJPWnduQ2liUE03dG9qOHFFTmJMdE80ejN0V1BtQXhV?=
 =?utf-8?B?QnZnNjB1K1FScm85b1JkSnRubzJzWUdwNndBR1NPajF6Z0QwNDRmQk1nU2xj?=
 =?utf-8?B?NjQ2YlR4K2t0UUNsYTBmc3lMM1pQamlGUVdnS3NGRkJyTHYvc0dYODlrNWNI?=
 =?utf-8?B?NzlKUFFJMmNwT05YeWJ4dHVscUV2T01sTXBFM09LSGF4THZaVzRXb3dTa1Fa?=
 =?utf-8?B?OFB4VGFHSTJiOCtENE9nOXpoWHJ5YkU0TGpFM25abzIrVGJlOG5HRkFzYktG?=
 =?utf-8?B?NmtHZGZKbmZmeEdGSXhuc3lLWHVlbXg5cnZYTU91QUxXL0NSSVVpUk1teWhZ?=
 =?utf-8?B?c1VxVlo5YlVWamJEK3RsZ3dHRG5FUzZuMmJTM2h2bW55RGRla2pZcnlLZ3Zs?=
 =?utf-8?B?amI3QnNJNm5jZEZZV2x6Rjc0SzNrY1RKOFJiNWROY09lNkJHTUozeWFlWHFw?=
 =?utf-8?B?eWI1WFVoS1RpQkRRdE5lQ2VPNHJxSlk4WVFaL0VnazA0bWJBeG13RnZMZ2tR?=
 =?utf-8?B?VHlYMWZoSUxLVmxtWnluV2xiODNodWlYYnJFd2ZsNzdhN0FBUFVwcVV2VWc1?=
 =?utf-8?B?S1NrbmhZeWZrY2FwZm9vY3pLV1A5Y1ZYaEcwREZDT3Vsc1lNcjhaWHptQ05D?=
 =?utf-8?B?QnRadEZheDVoNHJJYXA2ZWZSRzR3UjBqZ1FqT285a1VUWU9ZRVIvM3k4UkZi?=
 =?utf-8?B?OWVoZUF2SXYrb041VWhQbWN0VUlnMW5OcHNIdFRPc1VZVXB4YkNaZjFvNHhh?=
 =?utf-8?Q?uuyWwBky0qTzp2EHkPQ8XzWDDk9Ixviy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFB5UFhYdGVjNXUvbWdmc0NBb2JQZlUvaVNZNUV1RjFZdUxYMjh1amcxcm5S?=
 =?utf-8?B?SHdZSGpIVndGUUhOWjB6ZWFDTHFhTmxkdVRPU0VyaE5mT2lPVk4relpob0pQ?=
 =?utf-8?B?UEkvc0FWT2xKSzJkRmR3OTBXTmpiQXl1RDEyZGJ0VVl0bjFTYWZVaGNSZk02?=
 =?utf-8?B?dHJVZU9Hd2FyUHc4MzZkOWJNMUhlejdpcWZ5RVNLd21RMk1YdThzeGNDL1ll?=
 =?utf-8?B?Y1RaMDBLOTZrM3ZZZ09nMDRBNGRrWExCQU5jeTNHZXI4Y3BQc2dFS3JWSDNN?=
 =?utf-8?B?RDQvYmFzUFE3ZmdIVlRzRThaVW56REd5Y21xeW8yb0VLWEpUQVhmWUx3Uy9J?=
 =?utf-8?B?cjdKa2RJd2tFelFISldkc3VMOFhCMG5qTjM1SjhxN3BPMmxiWFlBS1ZGVFNT?=
 =?utf-8?B?aVlEUjNFNk5mWFNZZlo4ckEwbndWNWY1c3NJMjVxWnl5V2d6OVp5N09BRVJQ?=
 =?utf-8?B?akU3WHRMc28vZlJWTHl3NlMxY2dsSnAySHhmZmZQTWpzNTBqL051ZGZTSXdS?=
 =?utf-8?B?SWo1aDNEMytQRmcvWjBqeVFDMVBDS3lWU1NhbXBXMUNQSkM3bVZheUpkb0hQ?=
 =?utf-8?B?VWNyeFZOR3pQdHQvbkZTZHRKUmtURzE1Ti9xWEg3NitDWVgvSmRaUGFaT29K?=
 =?utf-8?B?bWh4cFFTTWNOTHNtbnhYTVYrblppTTJLeEVyd2VJVHBQZjkyV0xiVU0vSmlm?=
 =?utf-8?B?cnRvbm5nVXJYK1lES3ZwbWFtV2MwaTZPK0NFMlpHZ01rU3hHRUNTN2FNd3Vv?=
 =?utf-8?B?eWsybnJib0owNm5UWjdFVlVQMEFIRFhUdDd1aTR1M2FJYWFic1Z1bkgra3RF?=
 =?utf-8?B?WUxtVWkvVEZFMHpWKzNqdUxIMk14Q25Ub0xLd201Yk8ybURLNC9VVGRWelZQ?=
 =?utf-8?B?dDlJczE2dlhZbG16SjRWTHgyOVloZDdOUHFuR0lxS2d1MkpBcFpxM1NSRWx2?=
 =?utf-8?B?clFvTkJON3U3cHkxS2xXNEFFU2JNNXJPS1dPQ0ZEdFc2OC8vRjl4VXQ4bU9L?=
 =?utf-8?B?Zks0dEJCczdwMUtOZUlHWDNGczZ5QTZsZmd3bElBSE41ZDFneUV1QTd6Z3dV?=
 =?utf-8?B?RE9pQkRzM0pEa2V2QklieVAxYzByWHl4c2g0MVB5K2dseGFBeC94VG84b1BE?=
 =?utf-8?B?T3lyNW5aYWIwbDRJZDRkQmdabU5VVUIyOUJERmpEQnBRWDVLQWEvbThxTmY1?=
 =?utf-8?B?MEZoT0pVVmxMdlBqMG9PTEtQQ1N5NFZKbTFkRGJmZDcrYzJkbGtNSUNWbXAz?=
 =?utf-8?B?RWRYMmZGMExnLytGV3ZGNW9YZW9SV29DVzJpU3h4OVF2MmNHaDhhU1JJb1pK?=
 =?utf-8?B?TzVlUmdsNHBwbHFMT0Q5UlZIYkFzUXpWR3ptYjFySjcrUlN3V1Jvc0N1Rk1T?=
 =?utf-8?B?QXZPWjFib3lkMnI3YUpCVXNTVWdYczk5MHpUTm1iRXAwTno2ZVdmMWlPblIw?=
 =?utf-8?B?S0xhVHZSZFhlSm5TaTFoYVB4amhTS3RXa2tmdFhWc1lSaG9PaFdxd2lVWlFY?=
 =?utf-8?B?dU1HUHIwOHJzZ3U3SEYvUVpqZG8yVGg1UlQ1VjAyVy84RlBkcnpsRXFSYVJY?=
 =?utf-8?B?WTgvQWtlOEw5MjlxZWx4RktGb0xnemdBL0ZPZFB1OXlxNG9qZWxweURuWXFo?=
 =?utf-8?B?TDM1SkpoZFdmY2Jsb2ZEMUxlbEcyWldRL1J6azNnaUZ5ZDlIKytrZUpVc1J2?=
 =?utf-8?B?cm5adEo3Vnl4dE9CSVN6RmdrL0RQYWVNRG1aVkZwRUVzMGZpaWI0YytodDFK?=
 =?utf-8?B?bWlIUDdsMjMvTTBMVFdvUDBKV2crQXhlVHpkL1FJMU50UU83V01hOEcyb2Nu?=
 =?utf-8?B?aU5SekF3RGxleFo5OXliRTdLS0pCTlFYR2YrM045SnNLV0sxa0laUWE5Vy9Z?=
 =?utf-8?B?TjdXWUMrQk1MWERXY3c4K1lnL2lIWUJiVGZEUWsvUGl6dkhXMlR5MmJ5YVht?=
 =?utf-8?B?U3J4SjFFMTN3YlJRYlNQVWFCZTg0UUhJdlZGaGpuMXdDb0RoWkIrSDZUeEJa?=
 =?utf-8?B?RWlobVVlV0RYVWlJOVRVd1FNbk5UMVpkMnFJekpmVGJkaS8rcWJlREVIQi96?=
 =?utf-8?B?dDlleDQwZHlmbjNQbGI0cEV3WFhIV1Q3SVJCQUdnQlp5aXJIRzlRRGEwcElD?=
 =?utf-8?Q?B+8Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74568d8-26dc-4b0f-f50d-08dd478ffb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 15:56:28.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5vx67uitt/zLq3xIWCxPmQ3yJXj1nGMjKQcy9CbmjXGan2t1S3TD+xYDX463b92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDcsIDIw
MjUgMTA6MTggQU0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkcm0vYW1kZ3B1
OiBJbml0aWFsaXplIHhnbWkgaW5mbyBkdXJpbmcgZGlzY292ZXJ5DQo+DQo+DQo+DQo+IE9uIDIv
Ny8yMDI1IDg6MDYgUE0sIEtpbSwgSm9uYXRoYW4gd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMYXphciwgTGlqbyA8
TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDcsIDIwMjUg
OToyMCBBTQ0KPiA+PiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGRybS9h
bWRncHU6IEluaXRpYWxpemUgeGdtaSBpbmZvIGR1cmluZyBkaXNjb3ZlcnkNCj4gPj4NCj4gPj4N
Cj4gPj4NCj4gPj4gT24gMi83LzIwMjUgNzoyOSBQTSwgS2ltLCBKb25hdGhhbiB3cm90ZToNCj4g
Pj4+IFtQdWJsaWNdDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPj4+PiBTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgNiwgMjAyNSAxMDo1NiBQTQ0KPiA+Pj4+IFRvOiBLaW0sIEpv
bmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+ID4+Pj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+
ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6IEluaXRpYWxpemUgeGdt
aSBpbmZvIGR1cmluZyBkaXNjb3ZlcnkNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBP
biAyLzcvMjAyNSA1OjAzIEFNLCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+Pj4+PiBbUHVibGlj
XQ0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+Pj4+
IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+Pj4+PiBTZW50OiBU
aHVyc2RheSwgRmVicnVhcnkgNiwgMjAyNSA4OjEzIEFNDQo+ID4+Pj4+PiBUbzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
ID4+Pj4+PiBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEtpbSwg
Sm9uYXRoYW4NCj4gPj4+Pj4+IDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4gPj4+Pj4+IFN1Ympl
Y3Q6IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6IEluaXRpYWxpemUgeGdtaSBpbmZvIGR1cmluZyBk
aXNjb3ZlcnkNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJbml0aWFsaXplIHhnbWkgcmVsYXRlZCBzdGF0
aWMgaW5mb3JtYXRpb24gZHVyaW5nIGRpc2NvdmVyeS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+ID4+Pj4+PiAtLS0N
Cj4gPj4+Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMg
fCAyMCArKysrKysrKysrKysrLS0NCj4gLS0tLQ0KPiA+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4g
Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+
ID4+Pj4+PiBpbmRleCBlY2E0MzFlNTIwMzguLmQ0ZWFkZTJiZDRkMyAxMDA2NDQNCj4gPj4+Pj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+
Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5j
DQo+ID4+Pj4+PiBAQCAtMjUwMiw2ICsyNTAyLDE5IEBAIHN0YXRpYyBpbnQNCj4gPj4+PiBhbWRn
cHVfZGlzY292ZXJ5X3NldF9pc3BfaXBfYmxvY2tzKHN0cnVjdA0KPiA+Pj4+Pj4gYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gPj4+Pj4+ICAgICAgIHJldHVybiAwOw0KPiA+Pj4+Pj4gIH0NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiArc3RhdGljIHZvaWQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfeGdtaV9pbmZv
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4+Pj4gK3sNCj4gPj4+Pj4+ICsgICAg
IGlmIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBYR01JX0hXSVAsIDApID09IElQX1ZFUlNJT04o
NCwgOCwgMCkpDQo+ID4+Pj4+PiArICAgICAgICAgICAgIGFkZXYtPmdtYy54Z21pLnN1cHBvcnRl
ZCA9IHRydWU7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNp
b24oYWRldiwgR0NfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTig5LCA0LCAzKSB8fA0KPiA+Pj4+Pj4g
KyAgICAgICAgIGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApID09IElQX1ZFUlNJ
T04oOSwgNCwgNCkpDQo+ID4+Pj4+PiArICAgICAgICAgICAgIGFkZXYtPmlwX3ZlcnNpb25zW1hH
TUlfSFdJUF1bMF0gPSBJUF9WRVJTSU9OKDYsIDQsIDApOw0KPiA+Pj4+Pg0KPiA+Pj4+PiBDYW4g
dGhpcyBzdHVmZiBnZXQgcm9sbGVkIGludG8geGdtX2luaXRfaW5mbyBhbmQgY2FsbGVkIGRpcmVj
dGx5IGludG8NCj4gPj4+PiBhbWRncHVfZGlzY292ZXJ5X3NldF9pcF9ibG9ja3M/DQo+ID4+Pj4+
IEJyZWFraW5nIHVwIGRpc2NvdmVyeV9zZXRfeGdtaV9pbmZvIGFuZCB4Z21pX2luaXRfaW5mbyBh
cyAyIHNlcGFyYXRlIHRoaW5ncw0KPiA+Pj4+IHNlZW1zIGEgbGl0dGxlIGNvbmZ1c2luZy4NCj4g
Pj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEludGVudCBpcyBsaWtlIHRoaXMgLQ0KPiA+Pj4+ICAgICAg
IFNldCBJUCB2ZXJzaW9uIGluZm8uIFRoaXMgaXMgdGhlIGpvYiBvZiBkaXNjb3ZlcnkgYW5kIGtl
cHQgaW5zaWRlDQo+ID4+Pj4gYW1kZ3B1X2Rpc2NvdmVyeS4NCj4gPj4+PiAgICAgICBTZXQgYW55
IHN0YXRpYyBpbmZvcm1hdGlvbiBkZXJpdmVkIG91dCBvZiBJUCB2ZXJzaW9ucyBhbmQgbm90IGF2
YWlsYWJsZQ0KPiA+Pj4+IGluIGRpc2NvdmVyeSB0YWJsZXMuIFRoaXMgaXMga2VwdCBvdXRzaWRl
IG9mIGRpc2NvdmVyeSBmaWxlLg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBUaGVuIHdoeSBhcmUgeW91
IHByb3Bvc2luZyB0byBzZXQgdXAgc3RhdGljIGluZm9ybWF0aW9uIGluIHRoZSBkaXNjb3Zlcnkg
ZmlsZSBpbg0KPiB0aGUNCj4gPj4gZmlyc3QgcGxhY2U/DQo+ID4+DQo+ID4+IEkgZGlkbid0IHVu
ZGVyc3RhbmQgdGhhdCBzdGF0ZW1lbnQuIFRoZSBmdW5jdGlvbiAtIGFtZGdwdV94Z21pX2luaXRf
aW5mbw0KPiA+PiAtIGNhbGxlZCBmcm9tIGRpc2NvdmVyeSBzZXRzIHVwIHRoZSBkZXJpdmVkIGlu
Zm9ybWF0aW9uLiBPbmx5IElQIHZlcnNpb24NCj4gPj4gaW5mbyBpcyBzZXQgaW5zaWRlIGRpc2Nv
dmVyeS4NCj4gPg0KPiA+IFNuaXAgZnJvbSB5b3UncmUgbGFzdCByZXNwb25zZToNCj4gPj4+PiAg
ICAgICBTZXQgYW55IHN0YXRpYyBpbmZvcm1hdGlvbiBkZXJpdmVkIG91dCBvZiBJUCB2ZXJzaW9u
cyBhbmQgbm90IGF2YWlsYWJsZQ0KPiA+Pj4+IGluIGRpc2NvdmVyeSB0YWJsZXMuIFRoaXMgaXMg
a2VwdCBvdXRzaWRlIG9mIGRpc2NvdmVyeSBmaWxlLg0KPiA+IFlvdSdyZSBjYWxsaW5nIGFtZGdw
dV9kaXNjb3Zlcnlfc2V0X3hnbWlfaW5mbyB3aGljaCBjYWxscw0KPiBhbWRncHVfeGdtaV9pbml0
X2luZm8gd2hpY2ggaXMgc2V0dGluZyBzdGF0aWMgZGVyaXZlZCBpbmZvcm1hdGlvbiBpbiB0aGUg
ZGlzY292ZXJ5DQo+IGZpbGUuDQo+ID4gQSB3cmFwcGVyIGNhbGxlZCBpbiBhIHdyYXBwZXIgaXMg
c3RpbGwgZG9pbmcgdGhlIG9wcG9zaXRlIG9mIHdoYXQgeW91J3JlIHNheWluZyBpbnQNCj4gdGhl
IHNuaXAgYWJvdmUuDQo+ID4gSWYgeW91J3JlIHRyeWluZyB0byBhdm9pZCB0aGlzIGFuZCBrZWVw
IGRpc2NvdmVyeSBjbGVhbiwgY2FsbCB4Z21pX2luaXRfaW5mbyBpbg0KPiBhbWRncHVfZGV2aWNl
LmMgc29tZXdoZXJlIGFmdGVyIHRoZSBJUCBibG9ja3MgYXJlIHNldC4NCj4gPiBBbmQgcHV0IHhn
bWlfc3VwcG9ydGVkIGRlZmluaXRpb25zIGluIHhnbWlfaW5pdF9pbmZvIHNpbmNlIHRoYXQgZG9l
c24ndCBjb3VudCBhcyBJUA0KPiB2ZXJzaW9uIHNldHRpbmcuDQo+ID4NCj4NCj4gVGhpcyBpcyBv
bmx5IGFib3V0IHN0cnVjdHVyYWwgc2VncmVnYXRpb24gLSBsaWtlIHRoZSBwbGFjZSB3aGVyZSB3
ZSB3YW50DQo+IHRvIG1haW50YWluIHhnbWkgcmVsYXRlZCBkYXRhLiBGdW5jdGlvbnMgc2V0dGlu
ZyBJUCB2ZXJzaW9ucyBhbmQNCj4gaW5mb3JtYXRpb24gZnJvbSBkaXNjb3ZlcnkgdGFibGUgaXMg
a2VwdCBpbnNpZGUgZGlzY292ZXJ5LiBBbnkgZnVuY3Rpb24NCj4gd2hpY2ggYWRkcyBmdXJ0aGVy
IHN0YXRpYyBkYXRhIG91dCBvZiB0aGUgSVAgdmVyc2lvbiBpcyBrZXB0IGluIHRoZSBJUA0KPiBy
ZWxhdGVkIGZpbGUuDQo+DQo+IFRoaXMgaXMgbm90IGFib3V0IGEgbG9naWNhbCBzZXBhcmF0aW9u
IGxpa2UgeGdtaSByZWxhdGVkIGluZm9ybWF0aW9uDQo+IGRlcml2ZWQgZnJvbSBhbiBJUCB2ZXJz
aW9uIHNob3VsZG4ndCBiZSBzZXQgYXQgZGlzY292ZXJ5IHBoYXNlLg0KDQpZZWFoIEkgZ2V0IGl0
LCB0aGVyZSdzIGZ1bmN0aW9uIGluIGxhbmd1YWdlIHN0cnVjdHVyZSBidXQgSSBjb3VsZCBhbHNv
IGFyZ3VlIHRoYXQgbGFuZ3VhZ2Ugc3RydWN0dXJlcyBzaG91bGQgcG9pbnQgdG8gZnVuY3Rpb24u
DQpPdGhlcndpc2UsIHdlIGNvdWxkIGVuZCB1cCB3aXRoIGEgYnVuY2ggb2Ygd29yZCBzYWxhZC4N
Ckkgd29uZGVyIGlmIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gcm9sbCB1cCBzcGVlZCBhbmQgd2lk
dGggaW5mbyBzb21ld2hlcmUgaW4gR0ZYSFVCIGluaXRpYWxpemF0aW9uLg0KVGhlIHhHTUkgaW5m
b3JtYXRpb24gaXMgR01DIGJhc2VkIGFuZCB4Z21pX3N1cHBvcnRlZCBkb2Vzbid0IHJlbHkgb24g
SVAgdmVyc2lvbmluZyBJSVJDIGJ1dCByYXRoZXIgdGhlIG51bWJlciBvZiBwaHlzaWNhbCBub2Rl
cyBkZXRlcm1pbmVkIGJ5IHRoZSBtZW1vcnkgY29udHJvbGxlci4NCmUuZy4gZ2Z4aHViX3YyXzFf
Z2V0X3hnbWlfaW5mby4NClRoZW4gdGhhdCB3b3VsZCB0YWtlIHRoZSBwcmVzc3VyZSBvZmYgYWxs
IHRoaXMgZmlsZSByZWZlcmVuY2UganVtcGluZyBhbmQgdmVyc2lvbiBjaGVja2luZy4NCg0KSm9u
DQoNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gSm9uDQo+ID4NCj4gPj4NCj4gPj4gVGhh
bmtzLA0KPiA+PiBMaWpvDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gSm9uDQo+ID4+Pg0KPiA+Pj4+DQo+
ID4+Pj4gVGhhbmtzLA0KPiA+Pj4+IExpam8NCj4gPj4+Pg0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4g
KyAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhHTUlfSFdJUCwgMCkpDQo+ID4+Pj4+
DQo+ID4+Pj4+IE1heWJlIHJvbGwgdGhpcyBjaGVjayBpbnRvIHhnbWlfaW5pdF9pbmZvIGkuZS4g
dm9pZCBlYXJseSByZXR1cm4gaWYgbnVsbC4NCj4gPj4+Pj4NCj4gPj4+Pj4+ICsgICAgICAgICAg
ICAgYW1kZ3B1X3hnbWlfaW5pdF9pbmZvKGFkZXYpOw0KPiA+Pj4+Pj4gK30NCj4gPj4+Pj4+ICsN
Cj4gPj4+Pj4+ICBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4+Pj4gIHsNCj4gPj4+Pj4+ICAgICAgIGludCByOw0KPiA+
Pj4+Pj4gQEAgLTI3NjksMTIgKzI3ODIsNyBAQCBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfaXBf
YmxvY2tzKHN0cnVjdA0KPiA+Pj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+Pj4+ICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4+PiAgICAgICB9DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
LSAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhHTUlfSFdJUCwgMCkgPT0gSVBfVkVS
U0lPTig0LCA4LCAwKSkNCj4gPj4+Pj4+IC0gICAgICAgICAgICAgYWRldi0+Z21jLnhnbWkuc3Vw
cG9ydGVkID0gdHJ1ZTsNCj4gPj4+Pj4+IC0NCj4gPj4+Pj4+IC0gICAgIGlmIChhbWRncHVfaXBf
dmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDksIDQsIDMpIHx8DQo+ID4+
Pj4+PiAtICAgICAgICAgYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwgMCkgPT0gSVBf
VkVSU0lPTig5LCA0LCA0KSkNCj4gPj4+Pj4+IC0gICAgICAgICAgICAgYWRldi0+aXBfdmVyc2lv
bnNbWEdNSV9IV0lQXVswXSA9IElQX1ZFUlNJT04oNiwgNCwgMCk7DQo+ID4+Pj4+PiArICAgICBh
bWRncHVfZGlzY292ZXJ5X3NldF94Z21pX2luZm8oYWRldik7DQo+ID4+Pj4+DQo+ID4+Pj4+IElm
IHlvdSBkbyB0aGUgc3VnZ2VzdGlvbnMgYWJvdmUsIHlvdSBjYW4ganVzdCBjYWxsIGFtZGdwdV94
Z21pX2luaXRfaW5mbw0KPiA+Pj4+IHVuY29uZGl0aW9uYWxseS4NCj4gPj4+Pj4NCj4gPj4+Pj4g
Sm9uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgLyogc2V0IE5CSU8gdmVyc2lvbiAqLw0KPiA+
Pj4+Pj4gICAgICAgc3dpdGNoIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBOQklPX0hXSVAsIDAp
KSB7DQo+ID4+Pj4+PiAtLQ0KPiA+Pj4+Pj4gMi4yNS4xDQo+ID4+Pj4+DQo+ID4+Pg0KPiA+DQoN
Cg==
