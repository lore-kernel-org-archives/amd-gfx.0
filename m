Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28876D3B7E2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 02:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D03C10E463;
	Tue,  9 Dec 2025 02:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Fxwo0PV";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833DD10E463
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 02:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGv5EgM6bW9S0sNEC15Fo5gqAZewRClZwZb/POcvILElaZZ9bDKU683KEx+CLol2J9fpPq2a66+8t2VCfJ+IOj8QeaRVA4MLpurEYlzvlZRAdMA4em+hJdijKRyAxs7OBBrfMCvAOqYYsrYu+BwJF0gNILrhR1dyNkp7mdkGKsSDSfsBydadXLUkHBFYFSoXAW5nMD8vBjm0NIKxtk+V6rkRdQXzmmLKJd/JukNxrRZ8GbYSOMMhPQTg2gyCS5iRceKfJ69hXdezjeHt4r07qi+hXpv4EJ90EhYRX0Jw3q2RnefRgbd0lW2i5HRFenaVj2uUAQ08yjB+nQT+AKYbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoED+rlXxspHW9DNwHLoOGG0s02eunemZFzCPch8lnM=;
 b=cxzZvSnWF1Y9r3Yn1+Q4JR15/yOnGjQohnwFKZqYgRvDWJ0b43wBjslhNWj5C//nLaxR7sEC3dw65ZE2T17xF9ZXHR4+bzjHMEqaf1qO+oxnHend62ztTvkHWkD1cMCkpnDU2khgm/VhmlhbGKEudLlHgK/aWlhiNyCGa3tgBYcrn+hJEbemKU8ZTKb71pvHClJ9y6nZeImgaLXUb6NodNB0sWK4RRNf+yX0hbY9Ij5em+qqojfCsjgimVICnWi6zkOa4RtgJgVYTC+boL0RhVoNYyDrSKzdY2ZpBOr6NJlJjmMrhiTDQ1QCG5PQ4sfyfz1Wm+nk1yHmWHiY+OfWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoED+rlXxspHW9DNwHLoOGG0s02eunemZFzCPch8lnM=;
 b=5Fxwo0PV1nqJ+6M3kNHL9AwPjRyUSbaSlpG5H43w39wUFMTQ4JB837OtjrK0CYmhfKubCb2poEHTCY3reVLT0JQiMamVNDkgplldWnnqvFva32Y6XMBBSgiV1ifBpCqA4uJR+bLMWQ+wtVSzf6ztlicjkrZ06cxnR97qz5VU+tQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:03:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:03:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "M, Mythila" <Mythila.M@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amd/pm: restore SCLK settings after S0ix resume
Thread-Topic: [PATCH v1] drm/amd/pm: restore SCLK settings after S0ix resume
Thread-Index: AQHcZRcK2kjOIODj5kKnCPK3/zFRQ7UYWTMAgAA7QZA=
Date: Tue, 9 Dec 2025 02:03:30 +0000
Message-ID: <PH7PR12MB5997EBA0FA825F4AA1AC7A6582A3A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251204121035.504066-1-mythilam@amd.com>
 <CADnq5_OUx1ivUWznzHK_9n2+7uCrpGmuvEkaSReCD6SUAQLo7w@mail.gmail.com>
In-Reply-To: <CADnq5_OUx1ivUWznzHK_9n2+7uCrpGmuvEkaSReCD6SUAQLo7w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T01:58:30.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7732:EE_
x-ms-office365-filtering-correlation-id: bf1c3eaa-1053-4e5e-75e8-08de36c726ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K21QZ04zNDdPeStmMlBTdjkyWVZXVGlNTmp6L3hhWkJJVi9kVytac21LbkVC?=
 =?utf-8?B?Y3RsS2x1V1Y0NGNtWFpSQW02T3h3V0Y0bTd1V0NzNXdLQlNwa0lTb0lucHdn?=
 =?utf-8?B?YVJvSHBFNERlYVR6ZFV3dUpMclFqSFpsSGY4Zlc1S3hEbG5COHU2VmZ6SlNU?=
 =?utf-8?B?OFFzZ3V0NU1vQS9tRDhBRTllS08zeU1CQjhwT0ZQOGtubUJralR5MCswK3F2?=
 =?utf-8?B?Tm9JdlkvWUtVTjYzMGpVSkt6cWFReDJLRWJ4cUhhTjdwTC9vN01tTEN0TVFt?=
 =?utf-8?B?Tkt0c1EwUFp5TkhBTkNKQ1pSY0kxeHJ5ZmxqbmgxZmpuWE5LTlkzSU9NNTJN?=
 =?utf-8?B?UE4wazgrRHRMMTVLT3dEeE9kSjJzdWQvQlVYQ3pqbkkrQndJbWczSEJHZ00x?=
 =?utf-8?B?UXpXYm82bVY2ZTg5cFNqeTEyM0pmY21hVTRRQWlucUw0eURra0xJOTFNSkhP?=
 =?utf-8?B?R3FwcXFWU2YycGNacmZCSUxLbXpwWjFlTFdhekNkUEJSeG02Z3JETU1HaVFO?=
 =?utf-8?B?Yy9SZzBvZEg2MThzTklYOVZNMXNWMUlEVnFMU2FESjhvRk9BSFlzbEhUbHJ5?=
 =?utf-8?B?c2wwbHhXNnphYnpJeWdNQVhDOXMyN3FrczMwL1VUVVdtTXFyK2dLdXE5TnQ1?=
 =?utf-8?B?R0JtN1UrTCsvcGZPaUgvSjhJWUxtR01XU3ZEZmhjQjBFaXJHbUQwTlJ0K05W?=
 =?utf-8?B?cGtkV1E3MklNUmhNK3lOV1c0eUROUWpSUVpDdEZJbE1vMXJrVnVwZTZTZ0pI?=
 =?utf-8?B?djNDN3lsTzRIcWxYNmtUOXZibm8vNVJLcGEvdXlISDUwSzQ5MFhwZVFVNVNh?=
 =?utf-8?B?OW5aTHlhSjAxUUduZkNqMzdmME54aWYyYWVRQzZBbXhBTEVLMHlsUE0vdTBt?=
 =?utf-8?B?UUdxRW1rVUwrblh0OW5XZ1V4SDdrOGFQeGFDRVlzeWFKcHlPKy9jR2lwZ3dl?=
 =?utf-8?B?VkhJamdqbjJWUEI1a3FYYWVTUkVQa1BGd3Fibzc3SG1EZUVScDdldGJ0eHhS?=
 =?utf-8?B?dVQ5SzBSNEhMVHhpU1pXVTN5Z3BIODlPSC85NEdsMytrc2lSVExxQ0pXZ2xR?=
 =?utf-8?B?QVNJYnAwN29YaEN5Wnp2K3ZnSXNDQ1hhMmMvSDFUei9UK3pyVDZDbWphMmZY?=
 =?utf-8?B?U2JKc0xmT1NSOTBvbEVCZ003aWJkVXlOSmNCanNjNkFkcjlSYURoRnl1aDJh?=
 =?utf-8?B?Ylc4V0tMT3p5d3o4cWlqbFFSMnh2Zi96QjVIcHBUL0tyNndlZ09scTYxeU9h?=
 =?utf-8?B?TUVpbkdNZDYwMTdnYUhiWUw3SHNSRGNFVitndkFhZG5ZeFJiQXNGdFQxRXJT?=
 =?utf-8?B?dXp4a0tVcytuTHBUb1JxdW5yV2xyN2hYenR6c0o0OFF0T0hLRFdlYkpMcUlT?=
 =?utf-8?B?dTRna0Fwc1FDM25vZWJwa0VMUmZKWmpPMmFGam9XVWl1cGt6emFpV25ZcTJy?=
 =?utf-8?B?NW5LMzNkZzVpOWVNWm11TzU3OTVjYmQ1elRJWXNOaGpaQTAzWTdhcjJ0cEhl?=
 =?utf-8?B?Q002Ylk5Y1gvNGpEeXVtSWh3TGRxQWJDM21HRUl3cWhqZnM4aHg4RzNkV3Q5?=
 =?utf-8?B?SXNyVEFTbDZzbjBHZDBYdlFITXRjeGcydGVjcm9EWnZjRjFBZ3ZPamhFUytn?=
 =?utf-8?B?ZUljTkFLOE5jb3owWmdUZmdOeDB2K2FRd0hmaFAyeE9NTWNUYWQzY000WDl5?=
 =?utf-8?B?QytZRkFIenJDLzI2ZHd6bU5pLzRVOWVrampzUDZjTG1QN2VnQUw3VVN4N05K?=
 =?utf-8?B?eFF5WjE2alpHTlQrTnVSS29nY0h5RnNqSTJsT3FGTEJpQzN1dEZCeHBMRlRa?=
 =?utf-8?B?OUVic3RBTFllOUVPSllmc0VLYjdxOUhPVm5YZjdUUEVVQXFqRjcrUWZTcUox?=
 =?utf-8?B?b3IwRE5UWkQyczdOVmJsVWovdU1FSGQ1V1RpeTBHSDJYMGRYZHBOOHNEUzF3?=
 =?utf-8?B?NEg2Z0orN2tKaGk5bEFFT01ZN2kwbzk1a2pSdmNZMVVmNEtGQ2JlZ042V3RC?=
 =?utf-8?B?QWxmN1cwWVlrVmpVODQrRldWYm55NHFvaE5aWmMwd3FSd1hWRGE4a3U5KytK?=
 =?utf-8?Q?3SF4uK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDVnUURucG5pWTJ4S3l6OWlEQnRuQ0ZpOTRoSUtNZHJIcVNneFdMWGJTVnR0?=
 =?utf-8?B?eDJQcWkxbkg4b3h5TWdJMHpZQTA2WU5QNUI0dU5QVmZjTGw3dVd2WElPek5P?=
 =?utf-8?B?MzlwL0hRdHh5Y2huVWdRVy9vWThqRmFyY2JqMlB0U0JZbitYeiszTzVrSTNs?=
 =?utf-8?B?d3N4TllKc3g5YU9ISW9EWUZKMnBzOVUrSmY5Ri9BMlNGK3F3b2RqOWRKakFD?=
 =?utf-8?B?MEVFSlpSYWZ2OWxWbWxETE8rQ2tBUzFSRC9VcHpqQkZKL21vQnc2TDhLaHNq?=
 =?utf-8?B?MHFnT3QvWnRTWlNaUTIwM0xWcmdqNDlQWXpTUXB0UzdYS1pJSVJBV28yYWU0?=
 =?utf-8?B?YWFuS1ZpNjArdWQ1b0RQSjlRdmN2TUZmUVI5QW9lQW1sZDJiVEEzMDMrZ1kx?=
 =?utf-8?B?eWNha3BiaTRtemFRS2FoVWpKTE8ycU44UVF1VituTDhPY2RIVHhIdFAvK3A0?=
 =?utf-8?B?dHpGZ1BhRmdzOUNoaGU0YXFLVURPWlRWRjB5VW02TUFNWVhrc3ZGbTZwK2Fy?=
 =?utf-8?B?WEdQZHVJUytWb2ZldDBIc0lxQVhNc3BjMjhXQUY3NjhjeUJvT3pyTldRcnND?=
 =?utf-8?B?MjFSbXNrVHJJb1dMaEdkclRKSkRqRFZoTmVNY0RNcnEzdlNRdUZVVlIzQmR4?=
 =?utf-8?B?R1RmRlF2WFFZZFp3MXdDalVuUEIxNWtCYVFjOU05aVFKbUIzU3VHaVArVEhN?=
 =?utf-8?B?aW8vOUNZN3lGY1hlVkE4Q21RRHErYWhQaXBNT3pTOWVyc1NlMVRmMm1xbDV5?=
 =?utf-8?B?a042K0dqYlFIZ2JoV1FmeUl5TkVVT1pvdE5mK3ZTaklkL3p0NmtlVjB4bVVE?=
 =?utf-8?B?QmVyeURpVE9jdlF6YmlVbmhmODhqbDhsY1J3NlRkS1NRQ2g1VUYxTzZWbVNn?=
 =?utf-8?B?SVJmSEtSdmdGRjZjTktrM21GNG04bFVobTY5TXcwQ0EyeWhpeTRSNzNMNVFp?=
 =?utf-8?B?ZVRBdUtSUmg0dG4yS2RROHRZMm4rWVpja2xVWndERnA1QTQxdWtBZzlkRkNs?=
 =?utf-8?B?M1BnV1h5b3BCbzBOUGttdzZ2bWd6c3hNMUplZmJmQWJEUXhuL3kwNHFZa0Zj?=
 =?utf-8?B?dVRWWDdFakxVK2E2OGRVL0V2OEFOQ2NQNk9XT0dwM2MvZGRwbGloVjFjNnhm?=
 =?utf-8?B?SEhyeHRxeDJPMy9GSGUxTVRBNEw5NWthU245MnFHbFRqWWJYWG9CazVIeVFJ?=
 =?utf-8?B?K3VIbHlPTXZJYmJlNXBPclg1WVBvMUdpN29IUlVtcjltSGZOR2FLbzdadkZk?=
 =?utf-8?B?YzNPV3Z2Rmt5MEdZVzNxTlliVFg0TWo1S0dpWHlzdnNZY2IwdlEvQXdFTVIx?=
 =?utf-8?B?TWUzL3E1VExianRSWDlBd2NHWkpUT3IwWUZzZ3FBSkNJNmZTaEVua05WaWIy?=
 =?utf-8?B?alFFTEVHODZ1SHJkOCtzbzNrRS8wSm02STJjSzFZZFdQMlkyZEpPY3JBc0RL?=
 =?utf-8?B?WFBMQ2lpUXQ0dDZpbEJMVnZHQ2RPanE0bzFrWmhMODJhOEkzd0MwWm85WnZQ?=
 =?utf-8?B?WVlKM1RhMGl4TFBNbHpuekhyNngwSWxQUGhpYmJnVC9JYkthTmpVempVSG1R?=
 =?utf-8?B?WEtHcHNKcVJhVHFmRDRUTUNIWEJ1UDZuMFd2MHpwbmVZc1lKUmJPOE5iSk1E?=
 =?utf-8?B?WkRESXhxaFNkMC9uMEpYTnNZMFVzMmNzMlc2em1mTmpiejJvN0s4M0VXbDhQ?=
 =?utf-8?B?UEFiWjU3ZWd3RlZQLzlWQUJPb3pqOUI2T2wzYzV5SFFCa2RhWk5xc0ZlSngr?=
 =?utf-8?B?MGhxbXVBOUEyVDFLUW1nQU8wejFlUVJINWNuRHRGQk52aWw2ejVZS1lDVXFJ?=
 =?utf-8?B?ck15YjhFNDErUlpCeGJSdnhNaHUzTTZZdGFYQ1VFUmh6bUVXWTN1ajRxZjFS?=
 =?utf-8?B?VVVuYWVJTW9PaDFWd3NrTU1BQ2lmTWF3TURkMStMODJhYTdJdHJFYlRwaTUw?=
 =?utf-8?B?WFlxQjJQaUo4WHpXUlIyYmVWM0lvVXZ2WHJ6NU9IWGNwOVBydEdtQURveWFy?=
 =?utf-8?B?anBBVXJVbG5RZUtBdEpFd1RqU2E1Y0s4ekhweDNzcnhPRlJpTXd6anFwakY0?=
 =?utf-8?B?Z1Z6cG5RaytWN3hKQ3h6Rkt6QjEvSHVBQjZhcTBRN0UvVjVITlo5V0ZYQ3Vr?=
 =?utf-8?Q?J1fo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1c3eaa-1053-4e5e-75e8-08de36c726ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 02:03:30.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPx7279fUYHv1DGaTYZQb3mHBf52EfNM98DBxMSBnm6KaKe5wknVW/pG7AJLBH0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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
Cg0KPiArICAgICAgICAgICAgICAgZGV2X2VycihzbXUtPmFkZXYtPmRldiwgIkZhaWxlZCB0byBy
ZXN0b3JlIGhhcmQgbWluIHNjbGsgb24gcmVzdW1lIVxuIik7DQo+ICsgICAgICAgICAgICAgICBk
ZXZfZXJyKHNtdS0+YWRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlc3RvcmUgc29mdCBtYXggc2NsayBv
biByZXN1bWUhXG4iKTsNCg0KVGhlIE9EIHJlc3RvcmUgb3BlcmF0aW9uIG1heSBiZSBjYWxsZWQg
aW4gZGlmZmVyZW50IHNjZW5hcmlvcywgYW5kIHRoZSB3b3JkIG9mICdvbiByZXN1bWUnIHdpbGwg
bWFrZSB1c2VyIGNvbmZ1c2UsIHBsZWFzZSByZW1vdmUgaXQuDQoNCldpdGggdGhhdCBmaXhlZCwg
dGhlIHBhdGNoIGlzDQpSZXZpZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQu
Y29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUdWVz
ZGF5LCBEZWNlbWJlciA5LCAyMDI1IDA2OjI2DQpUbzogTSwgTXl0aGlsYSA8TXl0aGlsYS5NQGFt
ZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZHJt
L2FtZC9wbTogcmVzdG9yZSBTQ0xLIHNldHRpbmdzIGFmdGVyIFMwaXggcmVzdW1lDQoNCisgS2V2
aW4NCg0KT24gVGh1LCBEZWMgNCwgMjAyNSBhdCA3OjE54oCvQU0gbXl0aGlsYW0gPG15dGhpbGFt
QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBVc2VyLWNvbmZpZ3VyZWQgU0NMSyhHUFUgY29yZSBjbG9j
aykgZnJlcXVlbmN5IGFyZSBub3QgcGVyc2lzdGluZw0KPiBhY3Jvc3MgUzBpeCBzdXNwZW5kL3Jl
c3VtZSBjeWNsZXMgb24gc211IHYxNCBoYXJkd2FyZS4gVGhlIGlzc3VlIGlzDQo+IGJlY2F1c2Ug
b2YgdGhlIGNvZGUgdXBkYXRpbmcgdGhlIGNsb2NrIGZyZXF1ZW5jeSBkdXJpbmcgcmVzdW1lLg0K
Pg0KPiBUaGlzIHBhdGNoIHJlc29sdmVzIHRoZSBpc3N1ZSBieToNCj4gLSBQcmVzZXJ2aW5nIHVz
ZXItY29uZmlndXJlZCB2YWx1ZXMgaW4gZHJpdmVyIGFuZCBzZXRzIHRoZSBjbG9jaw0KPiAgIGZy
ZXF1ZW5jeSBkdXJpbmcgcmVzdW1lDQo+IC0gUHJlc2VydmVkIHNldHRpbmdzIGFyZSBzZW50IHRv
IHRoZSBzbXUgaGFyZHdhcmUNCj4NCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCg0KTG9va3MgZ29vZCB0byBtZSwgYnV0IHdvdWxkIGJlIGdvb2Qg
dG8gZ2V0IGFuIGFjayBmcm9tIEtldmluIGFzIHdlbGwuDQoNClRoYW5rcywNCg0KQWxleA0KDQoN
Cj4gU2lnbmVkLW9mZi1ieTogbXl0aGlsYW0gPG15dGhpbGFtQGFtZC5jb20+DQo+IC0tLQ0KPiAg
Li4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMC5jICAgIHwgIDUgKysrDQo+
ICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMF9wcHQuYyAgfCAzNw0KPiAr
KysrKysrKysrKysrKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxNC9zbXVfdjE0XzAuYw0KPiBpbmRleCBmOWIwOTM4YzU3ZWEuLmYyYTE2ZGZlZTU5OSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0
XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRf
MC5jDQo+IEBAIC0xOTM5LDYgKzE5MzksMTEgQEAgaW50IHNtdV92MTRfMF9vZF9lZGl0X2RwbV90
YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihzbXUtPmFkZXYtPmRldiwgIlNldCBzb2Z0IG1heCBzY2xrIGZhaWxlZCEiKTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICAgICAgICAgIH0N
Cj4gKyAgICAgICAgICAgICAgIGlmIChzbXUtPmdmeF9hY3R1YWxfaGFyZF9taW5fZnJlcSAhPSBz
bXUtPmdmeF9kZWZhdWx0X2hhcmRfbWluX2ZyZXEgfHwNCj4gKyAgICAgICAgICAgICAgICAgICBz
bXUtPmdmeF9hY3R1YWxfc29mdF9tYXhfZnJlcSAhPSBzbXUtPmdmeF9kZWZhdWx0X3NvZnRfbWF4
X2ZyZXEpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNtdS0+dXNlcl9kcG1fcHJvZmlsZS51
c2VyX29kID0gdHJ1ZTsNCj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgc211LT51c2VyX2RwbV9wcm9maWxlLnVzZXJfb2QgPSBmYWxzZTsNCj4gICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT1NZUzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+IGluZGV4IGZlMDBjODRiMWNjNi4uOGQ3MmE5
NjJhZWY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0
L3NtdV92MTRfMF8wX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gQEAgLTE1MTMsOSArMTUxMywxMCBAQCBzdGF0aWMg
aW50DQo+IHNtdV92MTRfMF8xX3NldF9maW5lX2dyYWluX2dmeF9mcmVxX3BhcmFtZXRlcnMoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbQ0KPg0KPiAgICAgICAgIHNtdS0+Z2Z4X2RlZmF1bHRfaGFyZF9t
aW5fZnJlcSA9IGNsa190YWJsZS0+TWluR2Z4Q2xrOw0KPiAgICAgICAgIHNtdS0+Z2Z4X2RlZmF1
bHRfc29mdF9tYXhfZnJlcSA9IGNsa190YWJsZS0+TWF4R2Z4Q2xrOw0KPiAtICAgICAgIHNtdS0+
Z2Z4X2FjdHVhbF9oYXJkX21pbl9mcmVxID0gMDsNCj4gLSAgICAgICBzbXUtPmdmeF9hY3R1YWxf
c29mdF9tYXhfZnJlcSA9IDA7DQo+IC0NCj4gKyAgICAgICBpZiAoc211LT5nZnhfYWN0dWFsX2hh
cmRfbWluX2ZyZXEgPT0gMCkNCj4gKyAgICAgICAgICAgICAgIHNtdS0+Z2Z4X2FjdHVhbF9oYXJk
X21pbl9mcmVxID0gc211LT5nZnhfZGVmYXVsdF9oYXJkX21pbl9mcmVxOw0KPiArICAgICAgIGlm
IChzbXUtPmdmeF9hY3R1YWxfc29mdF9tYXhfZnJlcSA9PSAwKQ0KPiArICAgICAgICAgICAgICAg
c211LT5nZnhfYWN0dWFsX3NvZnRfbWF4X2ZyZXEgPQ0KPiArIHNtdS0+Z2Z4X2RlZmF1bHRfc29m
dF9tYXhfZnJlcTsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gQEAgLTE1MjUsOCAr
MTUyNiwxMCBAQCBzdGF0aWMgaW50DQo+IHNtdV92MTRfMF8wX3NldF9maW5lX2dyYWluX2dmeF9m
cmVxX3BhcmFtZXRlcnMoc3RydWN0IHNtdV9jb250ZXh0ICpzbQ0KPg0KPiAgICAgICAgIHNtdS0+
Z2Z4X2RlZmF1bHRfaGFyZF9taW5fZnJlcSA9IGNsa190YWJsZS0+TWluR2Z4Q2xrOw0KPiAgICAg
ICAgIHNtdS0+Z2Z4X2RlZmF1bHRfc29mdF9tYXhfZnJlcSA9IGNsa190YWJsZS0+TWF4R2Z4Q2xr
Ow0KPiAtICAgICAgIHNtdS0+Z2Z4X2FjdHVhbF9oYXJkX21pbl9mcmVxID0gMDsNCj4gLSAgICAg
ICBzbXUtPmdmeF9hY3R1YWxfc29mdF9tYXhfZnJlcSA9IDA7DQo+ICsgICAgICAgaWYgKHNtdS0+
Z2Z4X2FjdHVhbF9oYXJkX21pbl9mcmVxID09IDApDQo+ICsgICAgICAgICAgICAgICBzbXUtPmdm
eF9hY3R1YWxfaGFyZF9taW5fZnJlcSA9IHNtdS0+Z2Z4X2RlZmF1bHRfaGFyZF9taW5fZnJlcTsN
Cj4gKyAgICAgICBpZiAoc211LT5nZnhfYWN0dWFsX3NvZnRfbWF4X2ZyZXEgPT0gMCkNCj4gKyAg
ICAgICAgICAgICAgIHNtdS0+Z2Z4X2FjdHVhbF9zb2Z0X21heF9mcmVxID0NCj4gKyBzbXUtPmdm
eF9kZWZhdWx0X3NvZnRfbWF4X2ZyZXE7DQo+DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+
IEBAIC0xNjY0LDYgKzE2NjcsMjkgQEAgc3RhdGljIGludCBzbXVfdjE0XzBfY29tbW9uX3NldF9t
YWxsX2VuYWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICByZXR1cm4gcmV0
Ow0KPiAgfQ0KPg0KPiArc3RhdGljIGludCBzbXVfdjE0XzBfMF9yZXN0b3JlX3VzZXJfb2Rfc2V0
dGluZ3Moc3RydWN0IHNtdV9jb250ZXh0DQo+ICsqc211KSB7DQo+ICsgICAgICAgaW50IHJldDsN
Cj4gKw0KPiArICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211
LCBTTVVfTVNHX1NldEhhcmRNaW5HZnhDbGssDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzbXUtPmdmeF9hY3R1YWxfaGFyZF9taW5fZnJlcSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KPiArICAg
ICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoc211LT5hZGV2LT5kZXYs
ICJGYWlsZWQgdG8gcmVzdG9yZSBoYXJkIG1pbiBzY2xrIG9uIHJlc3VtZSFcbiIpOw0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByZXQg
PSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwgU01VX01TR19TZXRTb2Z0TWF4
R2Z4Q2xrLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c211LT5nZnhfYWN0dWFsX3NvZnRfbWF4X2ZyZXEsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsg
ICAgICAgICAgICAgICBkZXZfZXJyKHNtdS0+YWRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlc3RvcmUg
c29mdCBtYXggc2NsayBvbiByZXN1bWUhXG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyBzbXVfdjE0XzBfMF9wcHRfZnVuY3Mg
PSB7DQo+ICAgICAgICAgLmNoZWNrX2Z3X3N0YXR1cyA9IHNtdV92MTRfMF9jaGVja19md19zdGF0
dXMsDQo+ICAgICAgICAgLmNoZWNrX2Z3X3ZlcnNpb24gPSBzbXVfdjE0XzBfY2hlY2tfZndfdmVy
c2lvbiwgQEAgLTE2ODcsNg0KPiArMTcxMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJs
ZV9mdW5jcyBzbXVfdjE0XzBfMF9wcHRfZnVuY3MgPSB7DQo+ICAgICAgICAgLm1vZGUyX3Jlc2V0
ID0gc211X3YxNF8wXzBfbW9kZTJfcmVzZXQsDQo+ICAgICAgICAgLmdldF9kcG1fdWx0aW1hdGVf
ZnJlcSA9IHNtdV92MTRfMF9jb21tb25fZ2V0X2RwbV91bHRpbWF0ZV9mcmVxLA0KPiAgICAgICAg
IC5zZXRfc29mdF9mcmVxX2xpbWl0ZWRfcmFuZ2UgPQ0KPiBzbXVfdjE0XzBfMF9zZXRfc29mdF9m
cmVxX2xpbWl0ZWRfcmFuZ2UsDQo+ICsgICAgICAgLnJlc3RvcmVfdXNlcl9vZF9zZXR0aW5ncyA9
DQo+ICsgc211X3YxNF8wXzBfcmVzdG9yZV91c2VyX29kX3NldHRpbmdzLA0KPiAgICAgICAgIC5v
ZF9lZGl0X2RwbV90YWJsZSA9IHNtdV92MTRfMF9vZF9lZGl0X2RwbV90YWJsZSwNCj4gICAgICAg
ICAucHJpbnRfY2xrX2xldmVscyA9IHNtdV92MTRfMF8wX3ByaW50X2Nsa19sZXZlbHMsDQo+ICAg
ICAgICAgLmZvcmNlX2Nsa19sZXZlbHMgPSBzbXVfdjE0XzBfMF9mb3JjZV9jbGtfbGV2ZWxzLA0K
PiAtLQ0KPiAyLjE3LjENCj4NCg==
