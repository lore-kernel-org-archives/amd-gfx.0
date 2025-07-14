Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDBCC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 16:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B07D10E347;
	Mon, 14 Jul 2025 16:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ElkbfSGn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0CC10E347
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 16:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDNpeI1RmTMuY2UQIBM4tk+XJni3r908FQjAtDOwI+mOsmHY8Y0u/FPbHdoAZHtLXAnc5Sr0ArK6clVOtzMBlexoL2276A/+/iBsq+7JbbBD2Xq7Ez4cVwh5ZjogCZRnGkqwKjf0fU9jnUX5Z0Yxka7MWxOXoOOwvUkn5n809TQuk/cCqtlEPpber3WwkRgEC5coVu5kXkFfM0U1gETea5Tp23cizIlgqSDf+sVFDPbeeIa05s8LAklRNNpQIqq59caAG4aBPnTIs9GvxCebtl0lWHKDC/xeKtE1sFW/PRqma6bwaCEj5BMEraKWqDeW820ZQgw0+cFX8VNRaeAPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJRAAzezxJX2N6q9cMWqSIX7yPtA4l4Evdt3vsWNat4=;
 b=DYe5bHk9qshAa3FVGZt60PK09o37RgzekHRheD2Yqnx1hbI/3xwJrA9B+hahq1T0+LT352NM23Sx56ppxJEezOsZNg5UHiYxJD6sWZPh0qhE+NpakeLQ60mmJWLy4b4dj68okyAGCQAK4gSt48hg5b+A92H6tqShODBfXNYSXyERNoNlOvVbbZ69O+G2dyH86xpGZs6Zb0BBLnXbiQtuYfwoqvmVKL6qB+2QGgyp1PBsIeuulg3CtzUMSWwaPDI10GSVY99Zw0G9S/rr0t5ILSbcB9i1nTpwtSwReyf+rIiEA4w6xCszv7ez14YGHQRWglVLlfGXCT7gKNGy2Oapfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJRAAzezxJX2N6q9cMWqSIX7yPtA4l4Evdt3vsWNat4=;
 b=ElkbfSGnR0PYSHfhHYfW4IH0l368RTFzDcn9LUcdqt5A4icCgeFW0VzwNs8Nc3pPMMTPnGAO+g+ivD3deRY4BAZ/IQh/4Y6e1b2kycn/h2OKfPoGfRKxM+wjz1Gni0Z6wNgL4doqF9KadG2PfnAih4msq6KQn2fcgAawFlrmVt0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 14 Jul
 2025 16:27:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:27:52 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Jawich, Phil" <Phil.Jawich@amd.com>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix isp_user_buffer_alloc() warnings
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix isp_user_buffer_alloc() warnings
Thread-Index: AQHb9NlKTCuk3E8InUe3Vj2X832Ip7QxzsoA
Date: Mon, 14 Jul 2025 16:27:52 +0000
Message-ID: <52bd38b1-9abd-4315-bc12-1ad10874fd9a@amd.com>
References: <20250714160623.1302980-1-pratap.nirujogi@amd.com>
In-Reply-To: <20250714160623.1302980-1-pratap.nirujogi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS4PR12MB9747:EE_
x-ms-office365-filtering-correlation-id: aafd4432-916a-49b2-4d28-08ddc2f36177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXBvWGhGSDRtbkVKdTJBdWRLRENzOWVMTDRkbitsWkpjeFpvVnFuWElWZGdt?=
 =?utf-8?B?dGxVb1Bjd2p2ZVJNUWhMMFUxMmpBZjBMK1ljNDZrVHJZdSt1QmZLWk1NUzZW?=
 =?utf-8?B?T2RDTGtkeWVvd1lYNVFXVkxOdE1IWC9pWmU1YkRNc1pYTlNEZ05YZVgyNCt2?=
 =?utf-8?B?cWl1RUR5VlpaYSt2TTdjVEtTY3YxSmdlZWJobmxnU3lwWXVyQ2Y0MWVLMEYr?=
 =?utf-8?B?MXBTNG5qblFtbGIrN2szR1NxRmI1b2pqeWF3aWxhZjJMYWVveUJLZWFLZVZv?=
 =?utf-8?B?aW1XT3hITnpuWG01ZlJvUDFNRWhQSC9rT1JuZGp4SHptRVRWSEZHSGdJVnNI?=
 =?utf-8?B?SDdvY0o3L0VwYmEydjYrc21nVzJRR3VyakVNMWZvTjBadXlDV2RNOGRFUkMx?=
 =?utf-8?B?cnhXdTBGaFE2bG5Fd3J6azdnMkNjMVlmTnU3ZGJzSCtCYko3SW8vbEwwaDRU?=
 =?utf-8?B?TEFpSVl2VnplaERrN2tLc3pnK1NMTzlBb2U5MUNWYWV6U2hSakx6bzZDK0FN?=
 =?utf-8?B?dW93V01vTnhpb2hObGJ6dHB0VmhUc01XWEZPSW5pVjBVRXo5b0JGS0xKcWtB?=
 =?utf-8?B?bzd0Ry9FVHpPRDYvdFc2YlR5eGFsRWgvMmJVQlFmeEpqSUxheHpzYWxhc3dV?=
 =?utf-8?B?SEZNdmhuY0Jid0d6TjQvTC9QNWJnRWZsZWJaZ3h4aFFtWkhPWi81MmpIeEgv?=
 =?utf-8?B?S2kzRit1WDZOSUxGSWhoZW50OVVpTStCM2IrVjMrYm05ckZOOGFvem1VT2Z0?=
 =?utf-8?B?LzIwbXlpY2djKzRNWGNySnRvTC9ENVQzTGJKQXpqWXBIUkRteXJqRUV2dTBX?=
 =?utf-8?B?MW5rY3FBYkI2K2ZBRHVNVDZIMFZaa29weTFTY2NXdTViUGJQS2pKNkxCQUJ2?=
 =?utf-8?B?bFJ6Q1ZGeVJ1bENlUzMzNVAyMDVkT25sbmNlK1NSM2gvalVoT1hjTi9raHo0?=
 =?utf-8?B?YmVEV1dlWTRRN0tnb283bVVIcXQ3V0llbVVjQWt4OGpTbTdGSmRkdm5UY0to?=
 =?utf-8?B?R0NQc2dUR3F4VUc5QVlKZWZhUndPYlpDTHEwOUVnU2s2VTJ2c1dlbjhlYVND?=
 =?utf-8?B?Tk9Od2dRbkV0ci9SdW5SZnc3eGFRVWtHNUhTWm45dFBuMEdVZE1NWWM2OVV1?=
 =?utf-8?B?YVdhVG1yWlJQT1lSVEJVRERTUy9iVWpQRm93L2hqWmZjNzhFU1pyYTZmKzkx?=
 =?utf-8?B?U3A0T0FiRWpqVWRGaTZka05oVlpMZzJtMnJwUHNIQlBQa2hRTFB1Q09aejZL?=
 =?utf-8?B?OE9Pb01RQm9UTWxFUmNuWUU4NE8xb3BUMXREQ3l5UkpZN2NUcmYxT044WVgv?=
 =?utf-8?B?dWtzbkphWlFzSlRnZDVkS0tRWU1LeDFYeWtLMWx3TVlGOHV0aFlBT0VDYTdW?=
 =?utf-8?B?ekFjNXZVaXNxMkdYYkdQakJUamJEUHZyV3pFcS9hc2VHNGgzMnVsTEMxUXRr?=
 =?utf-8?B?aU50SFRLcHJPK0JBTGh4K3RQeGZNWkRERWtsbUFvWjFFdVFVeWx2ZVNjakNy?=
 =?utf-8?B?bzNaSWRxSWh5R1F5dk5sb2VPMUlna2R0MGpsQXVMMTNqcTVoRzJtMXBrWUNK?=
 =?utf-8?B?ZnF6cHNqbStkMUYzNHA0U2p2dVh1Tmt2amc2QmpGSEM5b1NZNW4rZFdQYVRR?=
 =?utf-8?B?T04vLzRNWGlzTnhlQmNtaUdENHlkbVI1RlE3M2E5YXVpNjNyMWw4WlN1S0Na?=
 =?utf-8?B?YlVnOC9qdGNlbDRlSWV2RzgrdU9lcEJnNEswOFZlVEJQUG52RmNheVI2Nlhk?=
 =?utf-8?B?blBXaytRYXJZNWdMRW56Z1oyNFNaaWlQQ2RkdWx2TlM5VjBTbEJOamtrSWFn?=
 =?utf-8?B?SmVNRi85WXA3Z0VkQTNQWThwRSs0SUNQOWZhUFBxSGZYK1NEem43VDhiYTBR?=
 =?utf-8?B?dFd5MWZHdHpQd0U5QmRvRkMyNjFPeklCYnVMeEFoUkhVVDQ2T3ZZVWY4NUNC?=
 =?utf-8?B?VFVHNEhDb2djUFIvdlo3alhpQWxmUnN5Skw0d0Nhb0VicWRiakFIODl1ZEZX?=
 =?utf-8?Q?x7vzWAM2iIafviHdWlyIfiJEOA032c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlYxN1pNNDdxV0hEbVNTV3hNbjBMbHE5MTMzaVNHQXMxSlFNa2dXL1l3MlJx?=
 =?utf-8?B?dkIzZHpTSFVsVDY5TTh1RUdJQk1uMGl4SkFpUHBMN0dxZ2FMeTBUeG5aS3NF?=
 =?utf-8?B?bEpmTE40VXZWTVZHN2R5TEZOOFo3UGhEM01BN2Fpdlh1MkdQUmV0bUtSS0E1?=
 =?utf-8?B?Ym84WlMvbzVnNTRCREI2OXJWbHZDZmY1eE5RV2VraGdjQ3p2T29qMGY2ZTNP?=
 =?utf-8?B?eTRkMUY1UitUMmN6VUpCS0hKYXNENHVkZXg4dkNpTXltMkNJc3l5MEI3c041?=
 =?utf-8?B?cWRyMFhsRW9ZSE15WEhhamVaQk9kY0M1WHVHN09KakozdDdwR3F5TmIwRVN3?=
 =?utf-8?B?REUwYXFxKy9aZDlYK1N5cWNyUVJNeTVzQkR3NVJKQ3BxUWZOZmJ1Ly9XdDNP?=
 =?utf-8?B?b2NMYTZSdTRXTG0zUVZhNEx4UXlPdXdzNkZlZEp2a08yUDJoaDF3UVVlYXVj?=
 =?utf-8?B?STd3ak9rMzZ3YkZZTkNjL3M0cDlIVHUwTDNlSG80NVBzWkZMYWYvMlZERUN6?=
 =?utf-8?B?NWx0OHA1S1hPNVp4aHpQTERyTFBCRWZGc3JVRVRYWFlzWnEvcDlRb0U3UU5i?=
 =?utf-8?B?bmJjV3pTdm9La2l2WmM5dU5mMHk2WjJpUjFGN1F6K0ZWeUszZkVPclVDc1o1?=
 =?utf-8?B?azJZcSt4eDNWcVM4d2tLNWFwR1RSY0htYnJBR2YyZmNpVUh3WmkwZGpSQnhk?=
 =?utf-8?B?eTZjeEZsZVUwK0RETyt0Y056WlBXZTJaSFdoQlA1RXhOSC9BWlJFblFCS3Vj?=
 =?utf-8?B?L0VCdTZleVRKblo1NzhITzBIQVdYWmsvTm83ZUhsRjQ5T0lVak5mMHg4cTgx?=
 =?utf-8?B?SEFCQUR4Qm1VeVp6ZitBYVZjNkJEaXhYVWFlMjc0MmxWUXdIVDR4Ujh1dkxZ?=
 =?utf-8?B?elpXeGwxVGtTdDd6VlRSK21KNmFNR1lTdEFUWDRNclhZRFdWWnJXempuazJE?=
 =?utf-8?B?TnUwTU4zNWpHOG5MSnJ4TGVLK2haN1VjQkNZM1Jnb1lmUlJNbVpieWZ3WnR1?=
 =?utf-8?B?NmhBQjR4TmJGaTBvcXoySis0aVc2VlpGRjNSWEpuS283V3JIcWZLQjEzZGpL?=
 =?utf-8?B?ZEpFZ2FzTXZOYklpemJQOW0wTlA3UEFtakNiYlBhVm5jaFZJNHFFRnFFQ3lP?=
 =?utf-8?B?Tk16MVU0YXJxTHJ3dTErREEvcEtYdDQrVkt0VmM2dUtMUlZTQlpTVldYb096?=
 =?utf-8?B?T1YyU0lsNXNlSGxzU3d3a1d6bHJrdlBmZjd6OWFCMmkzaHN2QVRBYnQvSVRH?=
 =?utf-8?B?RHZnMVVyeWlnTlF3OXlxcUFxVEFYSXFnalhQQ2hrZVpQbVJ1Q3dIc0VMS0l3?=
 =?utf-8?B?ODBQRVR6V3RjSjdFL2hyWUhPOFNUSmVTVE0zVTV2c1Z2Q3JPU3NjN3JkSTd4?=
 =?utf-8?B?cjZCSDBJQkwxUkJyd3ljalBCb0FQM21qZWNLOEhiamdSVWgraTMvSWVlVkZV?=
 =?utf-8?B?TVJwMzI0ZThNUzJrcEdtZEtTaTc5clZNN2MzQUtmbFJIWFNPdXA1RHpubXJ0?=
 =?utf-8?B?dzRaTm5DNjVnbGV5OUNkTGN6N0hQVjc3TXVzZmJxWnRmUEcvYklHOEdZNEdR?=
 =?utf-8?B?UVRzMGgzUHU2ZEZiWURyZklWVFY2dG9RT05takExZFZiQnZ6bFJHY011ajdP?=
 =?utf-8?B?VVFidGcxa0dNbmtyTDBnK2M1QTd4ZU1TYWVkVFZieEJvYTFoVCtBa1FET3BS?=
 =?utf-8?B?ZUxYMHRnK2RIektLR09aUDJkWkRjNytZdzdwSTY0d1B6YjhuR0Y2QmZmdVVq?=
 =?utf-8?B?ZnpoMVpBY1gxNG1UOWFjNEQzb2xRUUlWTVVBWk1zM3lqSUR0clREYnJ3TnRl?=
 =?utf-8?B?S0o3czVnbFMyNGVPckFmQXhFdzY0ZTJQMDBHMFJVd1ZDeURlditEOGtsekxF?=
 =?utf-8?B?ZCs4RzZTb1lhckNOVEJiLzF2aHV0QjFDTFhBR2NJMXJrZGNaZmdDYjN6dE9z?=
 =?utf-8?B?ZjR6VFI0WmxmWkhIZTFQQ0J0bHVaVXB3UVkybmV3b3ZCZXR3MDAvUWRERnZu?=
 =?utf-8?B?K0ljOHZWUXJxSkdscnNGRzVobE9WUlFPSXI4dVNYTmUzb2RFbGxCNzkyY3A1?=
 =?utf-8?B?VURkQ1NBUVVXcXRZNmVwbGxwQTF2b1dDVVcvOFRIZmkyRTBQRTI0ckdGZkVy?=
 =?utf-8?Q?5x0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E262B60BB7AD284CA165FDADA3305398@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafd4432-916a-49b2-4d28-08ddc2f36177
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 16:27:52.4144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCC75IEirC6aM0YF1NLOWBXZJvpRk+2n+W5zClrV+eKnn6bcCR381tWOC9dWka6YHUSqmnBaRHHwpMxCtBT0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747
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

T24gNy8xNC8yNSAxMTowNSBBTSwgUHJhdGFwIE5pcnVqb2dpIHdyb3RlOg0KPiBGaXggdGhlIHdh
cm5pbmdzOg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmM6MTc0OiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1lbWJlciAnZG1hYnVmJyBub3Qg
ZGVzY3JpYmVkIGluICdpc3BfdXNlcl9idWZmZXJfYWxsb2MnDQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pc3AuYzoxNzQ6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJh
bWV0ZXIgJ2RtYV9idWYnIGRlc2NyaXB0aW9uIGluICdpc3BfdXNlcl9idWZmZXJfYWxsb2MnDQo+
IA0KPiBGaXhlczogNWNhYjhjYzM4M2E1ICgiZHJtL2FtZC9hbWRncHU6IEFkZCBoZWxwZXIgZnVu
Y3Rpb25zIGZvciBpc3AgYnVmZmVycyIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1r
YnVpbGQtYWxsLzIwMjUwNzEzMTMyNC5US2Y0aVNPbi1sa3BAaW50ZWwuY29tLw0KPiBTaWduZWQt
b2ZmLWJ5OiBQcmF0YXAgTmlydWpvZ2kgPHByYXRhcC5uaXJ1am9naUBhbWQuY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMgfCAyICstDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5jDQo+IGluZGV4IGY5Y2FiZWFlMWM3MTcu
LjljZGRiZjUwNDQyYTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pc3AuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aXNwLmMNCj4gQEAgLTE1NSw3ICsxNTUsNyBAQCBzdGF0aWMgaW50IGlzX3ZhbGlkX2lzcF9kZXZp
Y2Uoc3RydWN0IGRldmljZSAqaXNwX3BhcmVudCwgc3RydWN0IGRldmljZSAqYW1kZ3B1Xw0KPiAg
ICAqIGlzcF91c2VyX2J1ZmZlcl9hbGxvYyAtIGNyZWF0ZSB1c2VyIGJ1ZmZlciBvYmplY3QgKEJP
KSBmb3IgaXNwDQo+ICAgICoNCj4gICAgKiBAZGV2OiBpc3AgZGV2aWNlIGhhbmRsZQ0KPiAtICog
QGRtYV9idWY6IERNQUJVRiBoYW5kbGUgZm9yIGlzcCBidWZmZXIgYWxsb2NhdGVkIGluIHN5c3Rl
bSBtZW1vcnkNCj4gKyAqIEBkbWFidWY6IERNQUJVRiBoYW5kbGUgZm9yIGlzcCBidWZmZXIgYWxs
b2NhdGVkIGluIHN5c3RlbSBtZW1vcnkNCj4gICAgKiBAYnVmX29iajogR1BVIGJ1ZmZlciBvYmpl
Y3QgaGFuZGxlIHRvIGluaXRpYWxpemUNCj4gICAgKiBAYnVmX2FkZHI6IEdQVSBhZGRyIG9mIHRo
ZSBwaW5uZWQgQk8gdG8gaW5pdGlhbGl6ZQ0KPiAgICAqDQoNClJldmlld2VkLWJ5OiBNYXJpbyBM
aW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg==
