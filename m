Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B2BC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 09:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142C210E55D;
	Tue, 22 Apr 2025 09:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7QTTo5Z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367EE10E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 09:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkw7OfYjwzfHHuNe34Bjynv0oy5jd0A5q2UO91q8zrPJDxsRyfkBdqDRL5nMqC3GA6VnoVSsBmZo6/ZBOmihxdku0/g6ivytzoTTTp23RnB29LFRP9HPtFHPuXtIjSxYG5xm1nPfDOoZ4iPH/Exd5WcOAqUSaoN+ngpxfFy74E48cczWSlxU8KFC+hp7tYIPk3FBX8S+FrVOpJb9F+kGetLZ0PP3cQKYAcKToGWxkdjY8ttWpIwZSTLvnWYn+hIgn8RDX3sLCw8Nu9cJSGVWC9/X95TpkKCv8cZmr1Cm/6Uz/1EYcFxw0kyR3nmP3DCVGvQwtoz1PslCe+GzXABQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3I3ywgn1xK77+lhnJtwWprzSX2UL9q3nhBXzKTTMKg=;
 b=nTG/sf2QiezQbpRPNhITMdAK+TqWAuyhKJdLB1+vkNUyWrqcAgvKfSU0Q1UcgyGZnFT6LGn/pEdQoZWUCah3kH9JzOEfFkWsXnYPQxe9v3tuibMLunpYCrIhT6hQ5d3aqB8JRka8aJCwPH7mM/qhGKus6JxKqJCby0oMafd+bXbBvnwEuzrX6gxC2BI5N/vhwdBymTfSttjwHogb3TJ6r2tbDU93gnUUptIkDocSzF+y1gPif/McqnGjicw/GVLJod8brnoOtU5evQFN7jdcPZoKZIwBgY3XLiRyaej8Ll7BFkXrdNzLPndA3LHoGMgb4qzHEs0+VpM2FkcrbM18VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3I3ywgn1xK77+lhnJtwWprzSX2UL9q3nhBXzKTTMKg=;
 b=z7QTTo5ZeILfmwfJZ1icIk42bjVJsJKiUN1IautlVeD3/6WZSM9fwParySathiROw2yQEfE8Z5e/Oj/jgwS5q8KVTT1hzO1aNMVpsQcpIrmCF5yOAhaAqlS4kS4QGXkeuF+G54ZY6BgiAzabLbORnSeAjPjwmXtPNvB6AHwN2uw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:14:55 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 09:14:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
Thread-Topic: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
Thread-Index: AQHbrqynvBiGApICUUGwgJuYG7zG37OmIhMAgAA1VWCAASMEAIAH8Gkg
Date: Tue, 22 Apr 2025 09:14:55 +0000
Message-ID: <DS7PR12MB6005329D20C8DE2367BDEC8EFBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
 <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
In-Reply-To: <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1f4ab111-e0f3-44c9-8f19-df33cd12657e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-22T08:54:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8258:EE_
x-ms-office365-filtering-correlation-id: cfb59e5d-4975-41eb-861a-08dd817e25c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NFNWTGgrUnBjbnJOTGJRUng2WTdQWmpnb0ZoaWtXUks4U200N0Q1WlBTQ2hP?=
 =?utf-8?B?TWVGR2lBWFlDSHp0MVRJWkh1UXpPd09UU0syazBTQ0RvdTByZzRlZUJJbjA3?=
 =?utf-8?B?elJWZW85Q1o2aURWM25tdUZVU0YrdGdzRnVNMVJMSldPem1xaE9KRXJHUXh3?=
 =?utf-8?B?QWc1THRxK1hiL2s5VHZXMklWUmZsSzFudFBlUjdtU1hpTjMxOVNQeWUxeFYr?=
 =?utf-8?B?N2ZFRWNDMlA2OG1mZXA3M2lIa3REbktkOHJjeUdKZU52TUY3T1dOQlVqQWRI?=
 =?utf-8?B?VnVZdGwxZis2amFXbUtyQjlZV0lsQ3dpZGRmNmxyU0s0Qmt1bUhQVmprcndU?=
 =?utf-8?B?bGYxb2lmSmVGVmtoTXVGMUc5WlNoZURVU28yejhxZi9DazhYQnJoZ2xTLzBy?=
 =?utf-8?B?c2pCdklNVkk4bkd6U3VTTjZsQzdUTERRZnd1eWRhT2p6OHRXM3EySTFOZXNV?=
 =?utf-8?B?WkhLa3oyRXk3ZzVyRXJtY0s3Q1RVaVJ4a2dLUDJmaTA3Nll2c3BBVFBjRDNM?=
 =?utf-8?B?eHJxczc3SFQxT2dtUFBjdU9LRmV1Q1JaMTloSTJnSGwrZ0pGRnpoUkEyYnNK?=
 =?utf-8?B?OTZCYmZPN2VrRm1ZTkN4Mzh4RjI2NXVVY3llVEphbnJ6akV3NTEyOHdqdnpm?=
 =?utf-8?B?WW1RbTk5Yld0YmlKSWNzRHNYcWtyVFlZWE1DWjZaVkxXSXY2TkZEU1JJN3B5?=
 =?utf-8?B?Ny8ydUpxTVY4bTFOeXRVNnV0VjNMdm9kanVGMzhNZzNhWVdVNEJCNXlocTVJ?=
 =?utf-8?B?a2JmSjhtYVAydmdubVZZd2JUM1o5dU5xOFI2c0tTMTQraHp2aGJROTdsOFVT?=
 =?utf-8?B?SEVvUzlEcVI1eUIrcTFEMTNlZDBFa2Yra1doWkhkeDVxQXlqOFRtckJ1anRv?=
 =?utf-8?B?Y0I0aWVVU3JNT2pUMWlKWEx2ZmJDWStmUk4rbVc0RlMzRW5telAyb1drYWRa?=
 =?utf-8?B?SlpGUlpibkRVZUpYcmZINHgyYjRrR0xBc3htZzlkei9zby8wVlY5dkk1ZnFo?=
 =?utf-8?B?MkpZYUoyaGhqMjgxWFdaNmNMWlR0eVBqZG93akdiWU41bXZjMTcrTlZBMjZF?=
 =?utf-8?B?N3dIS29nb25BS29PWVhMZGs4dlIrdW5mUjJ6cVJZQ3h4S2RKKzNSYnNhUHJO?=
 =?utf-8?B?WVhna1lEOWdST21DZHBFY3NORXA1aHhVZWhCNVgwUENCQ1pmZGtsckJmRjhH?=
 =?utf-8?B?ek9vdG5XTlZaVndnZ3ZRVW12eUt1c2RWL1I1enIzaDBSalV6MnE5Q3RtSFQ1?=
 =?utf-8?B?UzYvR2NzUWJrejJsUVVqWVl6U1N0SEtHSldRNytOMXYwWHdnTnU5T04vZ1Nk?=
 =?utf-8?B?blI3N0lGUEVqYVBwdWtmVTJiMnlXYjRwVDlselhZWjNuUG5JeUtHVlRNV0la?=
 =?utf-8?B?UXIyaXQ1dVpPa1FBbC9IK0VKQ1d3aEowSXE1TlNhOW5UN0hpdWN4L0NUVVlH?=
 =?utf-8?B?V0JPZWRDazB4WW5pLy9Sem9sZmlwbWhHV21zeE1aRXlNYm5WV01lc3N3SHhJ?=
 =?utf-8?B?K0h0ZGNFZnl0Z2tmM29pQTUxQmVrMmhFTmJWeFppWWg4REowdWxCWVNUSXpB?=
 =?utf-8?B?aVhtMzB2ajJuckdVd0g0MnlDeEJsUjdvVXZveUs4Vk9QSUdScjJHbjVpRkts?=
 =?utf-8?B?S3RYU05JUWxRTWtjaldLU043RGYvOGd3MmpyS1ltU2RHNEtZMjZHRHpWMHRK?=
 =?utf-8?B?bkxnN2x5RHE5OXZOeTJ4S0pRYUFiQmxMdlVIOTlINDMrL1Nab1AxVFhLSkY3?=
 =?utf-8?B?YzdRY2YxcUV2U25rbU1HV0lHOWF2dFJFOWVqRUpINVcxZWZ0ZklnejVBWnY4?=
 =?utf-8?B?OU53SE1Nc2t4YlhWbDZDKzVwZjBMMzYwWnFDTnp2RXBjZ0w4enpjZ3FvZlg0?=
 =?utf-8?B?dXRpZ09SbmI2WlBWUVFoQUlaOUFQTGIwVjNyeUd6TkZUcGtnSVBHWjgzRElj?=
 =?utf-8?B?eVdKRmJhdng4STdDYWswMU4wc3dJS0hOS1pLTHVIdDNJdlMzUlNza0xXS0Zk?=
 =?utf-8?Q?UnWIIqAPsFk7wVEOF5EKlhhEvOI5Dc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlJSWHd5eUw4MmFyckNBUDFORXdhbHllSzVFcEh1RDFYQmdDUGN0US81MnlM?=
 =?utf-8?B?eWJJUndOZll4YzVHY1dWd3JEMmdWYURCTGc1NDJkRCtPYTdXUUZ2eGVXN2d3?=
 =?utf-8?B?eUQ5R3M3L0YwZXR6dFUxWk5HeGgyNHNUUkVjRk93TmU3MG9kdW9mYjBSR21t?=
 =?utf-8?B?TlV2SWxzRmhQVEp1V3p0eU9GY2tqVktXakZUVWZHazJndGh4K3BvRVorMmdF?=
 =?utf-8?B?WWZkQmxjZ3dSWVhrdEMzd2N1SnlEWUoyRHlFbElEUUU0N29ySkNRZytSOExU?=
 =?utf-8?B?ZzlmaitjcFoxSmN2R1FSWmlKb1FqdFVZMnpWVzY3ZWtEYWRISWVRUnREWlkx?=
 =?utf-8?B?LzFuTDVkeHB1UG5RYTN4WWw2bTBWVllENTJZUWZqa29qL1JSSkc1dGYwY2gy?=
 =?utf-8?B?bXZ0NTRRbWYyMmJCbzczSFFyNmpKL3cwREZBVTJJT3BVdVRGZlhNKzB1TlRW?=
 =?utf-8?B?M1hyT1loK0ZxRkNiWWdkdGd2TDdCMFVVOHpRVzdRbnJtTjVUOElyZ1VRNmpD?=
 =?utf-8?B?VGhVdmphWnl1YTdkc2s1bVFtaHNWL0JZRTdZbElHcndEVTV3Q2pibWt4Q2Y4?=
 =?utf-8?B?ZkxqQ203VVBWU3RiYTc5MnVLZHBkcitxekZyM0s4K2VVSnFqR3RIbW15K3V3?=
 =?utf-8?B?V29mYlhVcy9IakUydE5xWDl3dkhNd3J0dDMrcWswZ2JvdDlVaDNJd0MrOHNY?=
 =?utf-8?B?UkpYRThLWGl3d1JGVkVpOTZFWTEwMXd2TVZyTGZib21lTTNlczdQNVRYeDJV?=
 =?utf-8?B?dkRnYVhmWDduRUl0ZXFpcVhXR2pyODlGUk5MQ2NQT3JwVVJuRm53NGJGUGRK?=
 =?utf-8?B?Y3hRalFYeDF2UDF4ay96UFFsYTBvYVpQNDRqUVAyS01ZdEhNMzV0bnJnbXkr?=
 =?utf-8?B?cldXQWM5MzMvd2I1cU9URnVQakF2MVhvejRWOU5SZ050ck1yMWtHQy9qODNB?=
 =?utf-8?B?OWdrU1lRbzVWN21HUXIybVIvWGIxS2g4Q3JSUnk3djZTNldJZnRldFVoa0Rp?=
 =?utf-8?B?Ry96WXBoMDJ1QTJmenU0bVB0VEsreWw0eG1CM1lYNC9jelJwR3dMNS85dGhU?=
 =?utf-8?B?WUo1KzNBMWREWis4eXNIMEgycFN2UkhGbUw4RGdQakUwOVRTR1p5Q044R0tm?=
 =?utf-8?B?NUFkU3Vlb2pNK1JTRnA4U0pSa0QzSk53QXdVVStmelJyak5EZ2ZVbWR1MXdV?=
 =?utf-8?B?b3pVNTJJZ3pjNW8wUUd6RFV0RkRPQno4WUVPakJMNktQcXBHaERHYmt5d2JB?=
 =?utf-8?B?WUFmb3hNb2xBQkxpZGZPNDZKYjZWSFpMR2Q5WnJXNUNMdEtRS2dlMGplTHB3?=
 =?utf-8?B?OUtWWlRZNW9sTzlCc09tTHJnQkk0NkdZNHllek5DYXBEenUxZzdDTTJIbUs4?=
 =?utf-8?B?ejNmaXlSZTQrZGk2UG9jRExsMUdWRlU2aktMWXQxVFFCSGpXMWtOZGNXd0lH?=
 =?utf-8?B?UlZFaGZZaVJKWS9WRm16Z2JyOVh3MlcwTGFuclFGdUhndzA1WEhvaElWTzFW?=
 =?utf-8?B?YzlWTUQvVGxMM0EvQXlHWEVQdEowTmpCT0luZjdQUXFtRVdyQ1F2YWM0QnBv?=
 =?utf-8?B?eXZQNENwN0FhYUNESjcvbFFoM094RzQ5eWNXbU16TnVCUW5sNGVQWXpVZWcx?=
 =?utf-8?B?UGdzc1RVQ3hkcHVSZ0w2bmhtZC9ycHNMdndpN3NNd0x2NmZ4YThkSkU3UFE0?=
 =?utf-8?B?MmhabkdlTXVWcFpRYmZFM0FodVV3TmZCdEYyZkpqNHdoSkkvQWRyWE0wYTlp?=
 =?utf-8?B?MjBXM3dHWEZDbFE5UU1PY0tXaHZHd0JRTHdTeC9iNTZPbGgxVkY3cjFZb2lo?=
 =?utf-8?B?VWJRU1BDQThRWlRSUGNlNUJLTTd1N1p1b0F6S1d2ZSttcUtBc0Y4K3BTRGNy?=
 =?utf-8?B?cEF2NWtURm5CL2hYNnl5Z3lkYUJyeEpxR3NBeXZlUzB4bWJLUXBURENUQk5K?=
 =?utf-8?B?U29CbU8rQ1U4eFZ6SnZNQzVuaENXd09ZRVpjbWpvbWNOaU5rT1hUU0wxY0hh?=
 =?utf-8?B?ajFmUXJyU3NXZHliY2FCL2JuekZYd3dncDBPdzUvV1JjL2tJUG9sZC9ydW9j?=
 =?utf-8?B?UVBwei9ORlVuM0lXc1MwUEZIZFhFTUdGQmRYRXVPSkxZNE1WbnVzQWFZMk9a?=
 =?utf-8?Q?rBcY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb59e5d-4975-41eb-861a-08dd817e25c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 09:14:55.5684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiLpIHAlMsNwOP1L4TI/RTby/7JonlQfYsgB46k+ZomPXEu/nWkwQEVmaecjKP4T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDE3LCAyMDI1IDM6NDAgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDQvNF0gZHJtL2FtZGdwdTogZnJlZSB0aGUgZXZmIHdoZW4gdGhlIGF0dGFjaGVkIGJvIHJlbGVh
c2UNCj4NCj4gQW0gMTYuMDQuMjUgdW0gMTY6NDcgc2NocmllYiBMaWFuZywgUHJpa2U6DQo+ID4g
W1B1YmxpY10NCj4gPg0KPiA+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDc6MDcg
UE0NCj4gPj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkcm0v
YW1kZ3B1OiBmcmVlIHRoZSBldmYgd2hlbiB0aGUgYXR0YWNoZWQNCj4gPj4gYm8gcmVsZWFzZQ0K
PiA+Pg0KPiA+PiBBbSAxNi4wNC4yNSB1bSAxMDo1MCBzY2hyaWViIFByaWtlIExpYW5nOg0KPiA+
Pj4gRnJlZSB0aGUgZXZmIHdoZW4gdGhlIGF0dGFjaGVkIGJvIHJlbGVhc2VkLiBUaGUgZXZmIHN0
aWxsIGJlDQo+ID4+PiBkZXBlbmRlbnQgb24gYW5kIHJlZmVycmVkIHRvIGJ5IHRoZSBhdHRhY2hl
ZCBibyB0aGF0IGlzIHNjaGVkdWxlZCBieQ0KPiA+Pj4gdGhlIGtlcm5lbCBxdWV1ZSBTRE1BIG9y
IGdmeCBhZnRlciB0aGUgZXZmIHNpZ25hbGxlZC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4u
Li9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYyAgICB8IDMxICsrKysrKysr
KysrKysrKystLQ0KPiAtDQo+ID4+PiAgLi4uL2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlv
bl9mZW5jZS5oICAgIHwgIDEgKw0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYyAgICB8ICAxICsNCj4gPj4+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4+PiBp
bmRleCBiMzQyMjViYmQ4NWQuLjYwYmUxYWM1MDQ3ZCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+
Pj4gQEAgLTI3LDYgKzI3LDcgQEANCj4gPj4+DQo+ID4+PiAgI2RlZmluZSB3b3JrX3RvX2V2Zl9t
Z3IodywgbmFtZSkgY29udGFpbmVyX29mKHcsIHN0cnVjdA0KPiA+Pj4gYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlX21nciwgbmFtZSkgICNkZWZpbmUgZXZmX21ncl90b19mcHJpdihlKQ0KPiA+Pj4gY29u
dGFpbmVyX29mKGUsIHN0cnVjdCBhbWRncHVfZnByaXYsIGV2Zl9tZ3IpDQo+ID4+PiArI2RlZmlu
ZSBmZW5jZV90b19ldmYoZikgIGNvbnRhaW5lcl9vZihmLCBzdHJ1Y3QNCj4gPj4+ICthbWRncHVf
ZXZpY3Rpb25fZmVuY2UsIGJhc2UpDQo+ID4+Pg0KPiA+Pj4gIHN0YXRpYyBjb25zdCBjaGFyICoN
Cj4gPj4+ICBhbWRncHVfZXZpY3Rpb25fZmVuY2VfZ2V0X2RyaXZlcl9uYW1lKHN0cnVjdCBkbWFf
ZmVuY2UgKmZlbmNlKSBAQA0KPiA+Pj4gLTQ3LDcgKzQ4LDcgQEAgaW50ICBhbWRncHVfZXZpY3Rp
b25fZmVuY2VfcmVwbGFjZV9mZW5jZShzdHJ1Y3QNCj4gPj4+IGFtZGdwdV9ldmljdGlvbl9mZW5j
ZV9tZ3IgKmV2Zl9tZ3IsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBkcm1fZXhlYyAqZXhlYykgIHsNCj4gPj4+IC0gICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlICpvbGRfZWYsICpuZXdfZWY7DQo+ID4+PiArICAgc3RydWN0IGFtZGdwdV9ldmljdGlv
bl9mZW5jZSAqbmV3X2VmOw0KPiA+Pj4gICAgIHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOw0K
PiA+Pj4gICAgIHVuc2lnbmVkIGxvbmcgaW5kZXg7DQo+ID4+PiAgICAgaW50IHJldDsNCj4gPj4+
IEBAIC03Miw3ICs3Myw2IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9yZXBsYWNlX2ZlbmNlKHN0
cnVjdA0KPiA+Pj4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21nciwNCj4gPj4+DQo+
ID4+PiAgICAgLyogVXBkYXRlIHRoZSBldmljdGlvbiBmZW5jZSBub3cgKi8NCj4gPj4+ICAgICBz
cGluX2xvY2soJmV2Zl9tZ3ItPmV2X2ZlbmNlX2xvY2spOw0KPiA+Pj4gLSAgIG9sZF9lZiA9IGV2
Zl9tZ3ItPmV2X2ZlbmNlOw0KPiA+Pj4gICAgIGV2Zl9tZ3ItPmV2X2ZlbmNlID0gbmV3X2VmOw0K
PiA+Pj4gICAgIHNwaW5fdW5sb2NrKCZldmZfbWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gPj4+DQo+
ID4+PiBAQCAtMTAyLDkgKzEwMiw2IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9yZXBsYWNlX2Zl
bmNlKHN0cnVjdA0KPiA+PiBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZfbWdyLA0KPiA+
Pj4gICAgICAgICAgICAgfQ0KPiA+Pj4gICAgIH0NCj4gPj4+DQo+ID4+PiAtICAgLyogRnJlZSBv
bGQgZmVuY2UgKi8NCj4gPj4+IC0gICBpZiAob2xkX2VmKQ0KPiA+Pj4gLSAgICAgICAgICAgZG1h
X2ZlbmNlX3B1dCgmb2xkX2VmLT5iYXNlKTsNCj4gPj4gVGhhdCBjaGFuZ2UgbG9va3MgY29tcGxl
dGVseSBpbmNvcnJlY3QgdG8gbWUsIHlvdSB3aWxsIG5vdyBsZWFrIHRoZSBvbGQgZmVuY2UuDQo+
ID4gVGhlIGV2aWN0aW9uIGZlbmNlIGlzIGF0dGFjaGVkIGFuZCBzaGFyZWQgYnkgYWxsIHRoZSBy
ZXN0b3JlZCB2YWxpZGF0ZWQgVk0gQk9zDQo+IGR1cmluZyBVUSByZXN0b3JlLCBhbmQgYXQgdGhp
cyBwbGFjZW1lbnQgdGhlIGV2aWN0aW9uIGZlbmNlIGlzIG9ubHkgZGV0YWNoZWQgZnJvbQ0KPiBv
bmUgb2YgdGhlIEJPcy4gVXNpbmcgYW1kZ3B1X3VzZXJxX3JlbW92ZV9hbGxfZXZpY3Rpb25fZmVu
Y2VzKCkgd2lsbCB3YWxrIG92ZXINCj4gdGhlIHJlc3Ygb2JqZWN0cyBhbmQgZGV0YWNoIHRoZSBm
ZW5jZSBmcm9tIHRoZSByZXN2IG9ianMgd2hlbiBmcmVlaW5nIHRoZSBCTy4NCj4NCj4gWWVhaCwg
YnV0IHRoYXQgZG9lc24ndCBqdXN0aWZ5IHRoaXMgY2hhbmdlIGhlcmUuIFNlZSB5b3UncmUgY29t
cGxldGVseSBtZXNzaW5nIHVwDQo+IHRoZSBmZW5jZSByZWZlcmVuY2UgY291bnQgd2l0aCB0aGF0
Lg0KPg0KPiA+DQo+ID4gQnV0IHRoZXJlJ3MgYSBwcm9ibGVtOiBldmVuIHRob3VnaCBkcm9wcGlu
ZyBhbGwgdGhlIGV2ZiBhdHRhY2hlZCB0byBWTSBCT3Mgd2l0aA0KPiB0aGlzIHBhdGNoLCB0aGUg
ZXZmIHN0aWxsIHJlZmVycmVkIHRvIGJ5IHRoZSBTRE1BIGFuZCBHRlgga2VybmVsIHF1ZXVlIGpv
YnMgYXQgdGhlDQo+IGNhc2Ugd2hlbiBlbmFibGluZyB0aGUga3EgYW5kIHVxIGF0IHRoZSBzYW1l
IHRpbWUuIFRob3VnaHRzPw0KPg0KPiBNaG0sIHRoZSBldmljdGlvbiBmZW5jZSBpcyBhbHdheXMg
YWRkZWQgYXMgYm9va21hcmsgaXNuJ3QgaXQ/IEFzIGxvbmcgYXMgdGhlIEdGWA0KPiBhbmQgU0RN
QSBqb2JzIGFyZSBub3QgZm9yIGV2aWN0aW5nIHNvbWV0aGluZyB0aGVuIHRoZXkgc2hvdWxkIG9u
bHkgZGVwZW5kIG9uDQo+IGZlbmNlcyB3aXRoIHVzYWdlIDwgYm9va21hcmsuDQo+DQo+IENhbiB5
b3UgZGlnIHVwIHdoZW4gdGhleSBhcmUgYWRkZWQgdG8gdGhlIGRlcGVuZGVuY2llcyBvZiB0aGUg
am9iPw0KDQpXaGVuIHRoZSBldmljdGlvbiBmZW5jZSB3YXMgYWRkZWQgdG8gdGhlIHVzZXIgcXVl
dWUgVk0gQk9zIHJlc2VydmF0aW9uIGFuZCB0aGVuIHVwZGF0ZWQgdGhlIEJPIHBhZ2UgdGFibGUs
IHdoaWNoIHdpbGwgYWRkIHRoZSBldmljdGlvbiBmZW5jZSB0byB0aGUgVk0gc3luYyBhdCBhbWRn
cHVfc3luY19yZXN2KCksIGFuZCB0aGVuIHRoZSBldmljdGlvbiBmZW5jZSB3aWxsIGJlIGFkZGVk
IGFzIGEgZGVwZW5kZW50IGZlbmNlIGJ5IHByb3BhZ2F0aW5nIHdpdGggYW1kZ3B1X3N5bmNfcHVz
aF90b19qb2IoKS4gV2l0aCByZW1vdmluZyB0aGUgZXZpY3Rpb24gZmVuY2UgZnJvbSB0aGUgVk0g
c3luYyBhdCBhbWRncHVfc3luY19yZXN2KCksIHRoZW4gdGhlIGV2aWN0aW9uIGZlbmNlIGNhbiBi
ZSByZWxlYXNlZCBwcm9wZXJseS4NCg0KVGhhbmtzLA0KUHJpa2UNCj4NCj4gVGhhbmtzLA0KPiBD
aHJpc3RpYW4uDQo+DQo+IFBTOiBQbGVhc2Ugc3RvcCBjYWxsaW5nIHRoZSBldmljdGlvbiBmZW5j
ZSBldmYuDQo+DQo+ID4NCj4gPj4+ICAgICByZXR1cm4gMDsNCj4gPj4+DQo+ID4+PiAgZnJlZV9l
cnI6DQo+ID4+PiBAQCAtMjM3LDYgKzIzNCwzMCBAQCB2b2lkIGFtZGdwdV9ldmljdGlvbl9mZW5j
ZV9kZXRhY2goc3RydWN0DQo+ID4+IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3IgKmV2Zl9tZ3Is
DQo+ID4+PiAgICAgZG1hX2ZlbmNlX3B1dChzdHViKTsNCj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4g
K3ZvaWQgYW1kZ3B1X3VzZXJxX3JlbW92ZV9hbGxfZXZpY3Rpb25fZmVuY2VzKHN0cnVjdCBhbWRn
cHVfYm8gKmJvKQ0KPiA+PiBQbGVhc2UgbmFtZSB0aGF0IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9y
ZW1vdmVfYWxsKCkuDQo+ID4gTm90ZWQuDQo+ID4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0
aWFuLg0KPiA+Pg0KPiA+Pj4gK3sNCj4gPj4+ICsgICBzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YgPSAm
Ym8tPnRiby5iYXNlLl9yZXN2Ow0KPiA+Pj4gKyAgIHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlLCAq
c3R1YjsNCj4gPj4+ICsgICBzdHJ1Y3QgZG1hX3Jlc3ZfaXRlciBjdXJzb3I7DQo+ID4+PiArDQo+
ID4+PiArICAgZG1hX3Jlc3ZfYXNzZXJ0X2hlbGQocmVzdik7DQo+ID4+PiArDQo+ID4+PiArICAg
c3R1YiA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOw0KPiA+Pj4gKyAgIGRtYV9yZXN2X2Zvcl9lYWNo
X2ZlbmNlKCZjdXJzb3IsIHJlc3YsDQo+ID4+IERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQLCBmZW5j
ZSkgew0KPiA+Pj4gKyAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZSAqZXZf
ZmVuY2U7DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAgICBldl9mZW5jZSA9IGZlbmNlX3RvX2V2
ZihmZW5jZSk7DQo+ID4+PiArICAgICAgICAgICBpZiAoIWV2X2ZlbmNlIHx8ICFkbWFfZmVuY2Vf
aXNfc2lnbmFsZWQoJmV2X2ZlbmNlLT5iYXNlKSkNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAgICBkbWFfcmVzdl9yZXBsYWNlX2Zl
bmNlcyhyZXN2LCBmZW5jZS0+Y29udGV4dCwgc3R1YiwNCj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCk7DQo+ID4+PiArDQo+ID4+PiArICAg
fQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgIGRtYV9mZW5jZV9wdXQoc3R1Yik7DQo+ID4+PiArfQ0KPiA+
Pj4gKw0KPiA+Pj4gIGludCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2V2aWN0aW9uX2ZlbmNlX21ncg0KPiA+Pj4gKmV2Zl9tZ3IpICB7DQo+ID4+PiAgICAgLyogVGhp
cyBuZWVkcyB0byBiZSBkb25lIG9uZSB0aW1lIHBlciBvcGVuICovIGRpZmYgLS1naXQNCj4gPj4+
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4g
Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgN
Cj4gPj4+IGluZGV4IGZjZDg2N2I3MTQ3ZC4uZGE5OWFjMzIyYTJlIDEwMDY0NA0KPiA+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4g
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5j
ZS5oDQo+ID4+PiBAQCAtNjYsNCArNjYsNSBAQCBhbWRncHVfZXZpY3Rpb25fZmVuY2Vfc2lnbmFs
KHN0cnVjdA0KPiA+Pj4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21nciwgIGludA0K
PiA+Pj4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX3JlcGxhY2VfZmVuY2Uoc3RydWN0IGFtZGdwdV9l
dmljdGlvbl9mZW5jZV9tZ3INCj4gPj4gKmV2Zl9tZ3IsDQo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fZXhlYyAqZXhlYyk7DQo+ID4+PiArdm9pZCBhbWRn
cHVfdXNlcnFfcmVtb3ZlX2FsbF9ldmljdGlvbl9mZW5jZXMoc3RydWN0IGFtZGdwdV9ibyAqYm8p
Ow0KPiA+Pj4gICNlbmRpZg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmMNCj4gPj4+IGluZGV4IDFlNzNjZTMwZDRkNy4uZjAwMTAxOGEwMWVi
IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMNCj4gPj4+IEBAIC0xMzkyLDYgKzEzOTIsNyBAQCB2b2lkIGFtZGdwdV9ib19yZWxlYXNl
X25vdGlmeShzdHJ1Y3QNCj4gPj4gdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+Pj4gICAgIGFt
ZGdwdV92cmFtX21ncl9zZXRfY2xlYXJlZChiby0+cmVzb3VyY2UpOw0KPiA+Pj4gICAgIGRtYV9y
ZXN2X2FkZF9mZW5jZSgmYm8tPmJhc2UuX3Jlc3YsIGZlbmNlLA0KPiA+PiBETUFfUkVTVl9VU0FH
RV9LRVJORUwpOw0KPiA+Pj4gICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiA+Pj4gKyAgIGFt
ZGdwdV91c2VycV9yZW1vdmVfYWxsX2V2aWN0aW9uX2ZlbmNlcyhhYm8pOw0KPiA+Pj4NCj4gPj4+
ICBvdXQ6DQo+ID4+PiAgICAgZG1hX3Jlc3ZfdW5sb2NrKCZiby0+YmFzZS5fcmVzdik7DQoNCg==
