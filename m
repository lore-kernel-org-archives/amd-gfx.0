Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDAC36011
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CEE10E709;
	Wed, 26 Mar 2025 15:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZB1Zp5d/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8331610E70C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTngSRndIGOYuZn28gzsDlabZiH2lmnbfIb5sMmK4jXWP8KptOblj33Td4uGNpwKHGHVcRgbF5QNsurcmk7iiaUzeez8GV0U6UxQkxYr9hkOGl7mJ7OU2SrxDpGd2QYXcJJJkbPDqoXUnk7cP70a+SvEm0wB8WA0Sx5l+Uqb4n+wIRPjMZ1wr6QSQycyVlj+0Im2HzKIU0tK8bTnptUB3BbQgO5NeTvrdl1EAvdg75s0Q5qjwnfcxY40YY2IbAcNIYATFnFtQGxbBe0EIVwkW8euJAHWTAumBTj6wdWg097Uf52ovvS6KLSN4KOn1spOF+bH8fM9UdrwDHwLsCVYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFiH13xkT0whA978Rg2P8UUPDPTvWyKM9nFbMNpMMco=;
 b=qyTdXuPzyVvnD1QNgJOpkD0E9XCBReB+feo0CvTv/q7ltJa0rYES1pEsegNCAO82kY2ABzw1w/ifCM3fSvq4pePoLml1fZEL3pdmJnY7445ZR9AI7oyR6nv6PXoRvQnBFEDXQLl/ef4Ez+Wiaa7FtR/Nm/KJeAARGMzaymNrIr3nWgvzb3/pKmfY7OdGEXa4GUlwjCuJkGppT0PQ1dGhgccH/oVDYn7YPm68XtLFObiqb7m5sv7bsU1vNrczDHuVuZM+c7YLf+oo0chke8lidkQHemFmnq4DrwFhRTV/M+GIohx0OswZzppFNPQzj+f7egVaCa2VmZocjEC6iLShqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFiH13xkT0whA978Rg2P8UUPDPTvWyKM9nFbMNpMMco=;
 b=ZB1Zp5d/BGmm/N+Dh/ti7ywb7OuiH6D2nx5q2Z4sBDbRVYVkxUd/iKJ0e42jk42O+SHJH55lUgPFSBjcQ9BvEAM+GTn8UgT4H9iEhOiyTy36g2XWD4GplMbMTyosQPKEESd/e1VvlMlyYg9QevcTN4CsMIJfrSI73R1rZUuQSXo=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:37:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:37:28 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/gfx: make amdgpu_gfx_me_queue_to_bit()
 static
Thread-Topic: [PATCH 1/3] drm/amdgpu/gfx: make amdgpu_gfx_me_queue_to_bit()
 static
Thread-Index: AQHbmdfDiTXqb/DEKEGZkFbBoH+jR7OCt62AgALC5YCAABmDUA==
Date: Wed, 26 Mar 2025 15:37:28 +0000
Message-ID: <BL1PR12MB57530C3ECAF031A2F6FD6C2F93A62@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250320203549.1345822-1-alexander.deucher@amd.com>
 <CADnq5_O_hotchYfpWvcatLTL6_s1YJD2qBwL5yqvXkhDQ2+swg@mail.gmail.com>
 <CADnq5_OO98WVP2Nbo=WBayd4q6b=OL_9QpFycd0vK3wiomNFCA@mail.gmail.com>
In-Reply-To: <CADnq5_OO98WVP2Nbo=WBayd4q6b=OL_9QpFycd0vK3wiomNFCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=65d0dd98-6a0e-488e-b779-3141b61ecf83;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T15:29:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|IA0PR12MB8088:EE_
x-ms-office365-filtering-correlation-id: 93c8c4a6-879f-4dec-f469-08dd6c7c1d98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1lLRDFPdjVPQVJPMUV3WFhmQ0g3ZUplT29vMzhHOWo4em9JdHNNZ3BLTVhl?=
 =?utf-8?B?TC9HdUtVTmQ2T3RlS0ZGMTZRQXdjeDA0N0FVdThsb0NYc1hCblJIK2lvdm1Q?=
 =?utf-8?B?OGpJbmQ2MnZvQVFpYnQrTCs0L1EySUo3aktjMStJbkJJWjYvazlFMnZRQVRv?=
 =?utf-8?B?S1p6czNzZ215RWpoTnFtRVhqV1g3cGlBcHVwb2F4MVF2Q00xdm4zVTNFTzVm?=
 =?utf-8?B?SXBOMDVHOVdTNkxEVTBlY29YdUsrUFlCUXd5cVNUdi91bjhWN2N6QW03TTBK?=
 =?utf-8?B?b3lrUENaSTZzRkE2c0lqNzVJMTN6WEg0b1AvWUlOSzZmRU5IMUNWcEgwL0U3?=
 =?utf-8?B?UDBqTTQwR1NVb055UXJhaDl6UGN6K1dXb3JEcEZkaXdpcmtsaHpEMEpDY3kr?=
 =?utf-8?B?YURqYjFaWmpKYWtBbjZRQnFSRFFmSTlyaCtJRGs1OUVEWnZ4VUFNVi92OXda?=
 =?utf-8?B?QVg5NlJidlY4Zm9BdUlHcDJJeUtsT0p0MVhFYzhWNmVBeWh2NDZySXZGcHU1?=
 =?utf-8?B?UnlvaVNCakZpN2JKV0lNN2UvWW04RzQ3S1VYbmdldmNQcW91aHdkeStrOHJC?=
 =?utf-8?B?YnRPYkYrOU9sdUNTQnhHaVR0Z2FETGdyVE9KVnJkMTBZcTBJallTR3pWUzQw?=
 =?utf-8?B?QkErT0NGSkxYM0lWY2lYV0g1N2laaVA2NWoyazRJQUh2dmF2RmRkaFFpUkhm?=
 =?utf-8?B?S09hRkRIeTh3aE1FY0xPTHZaT1Q0MzJqSmFNYWl6TFArNHVKcDZlQ1djSHMz?=
 =?utf-8?B?MnlRVVd2OEhKYWQ5azNtcXh6NTVvZW1BQ0RZVENSY1VrN0NyYjVRZ3pYSmdD?=
 =?utf-8?B?SkRwUUJrbHcyMkVlTjJpUHNhY1RMZVhYRnlMRjJnTGhTWURSamFjVExoZVpQ?=
 =?utf-8?B?bDRScmNoWkxWQXR4M2VIUWlESm5aVHFBRmIyckl6eEpFWjM4UHNKREJyTU1x?=
 =?utf-8?B?eU5ZTWNUSlJIa25nZThhd092ZEtkTEJMNWFNSG9NbFZKZ0tsODU2NHJwdHJR?=
 =?utf-8?B?a0J3WU9XOVlFbHhNVTgxM1F3ZHZFQ1Q2UlVFdjc5WFZXSUU3WDBCWUpGRDVs?=
 =?utf-8?B?NHJiQWdBVGhlZDR2TkMzMGxmQ3Jud0RmRDlpQlBYMjhWb0FtNG4wUFN1TDh1?=
 =?utf-8?B?QmYyMm9Nd1ZLRnFHSEd0WFZacndmb1lmRzhMZzl0enRHSGxzendzSk0zcTlF?=
 =?utf-8?B?ZWlHOUZmbks5MCthb0RpS0l1dG1DZHVGckVlb05sdHN6UW5NenVYZ3o0VUl1?=
 =?utf-8?B?di82RGZmd2VuWGpZR1hvUllOQUpaU0JuWVh1WVQ2Um44c2s2Z1pKclVrUDVn?=
 =?utf-8?B?aTJKTnJra0F2dE8randuMlltR0kvZXkweHd2aHYyTTgreTJUN1VzZ2xzQ3Z1?=
 =?utf-8?B?WCtJNExERi9OVEN0dFNxbU5OOEsrd3I5UG1xczIxVmxQdWhlcENhN0VUTXJB?=
 =?utf-8?B?ek5xSUZzTHJ4VEp6NUI5QXBHeGVXdXFNUzE2WDlQZXpOeW9LdzVXVVE2N3Ex?=
 =?utf-8?B?ZU5aSW1PdGxTYk9NdjFHODcrY0tDZTJRWXlxN3R2WkpZVXM0WVRzRTNmOWNw?=
 =?utf-8?B?QTJ6RWhSZW9yQXQ2NDhmZ3EwRVd6ajE3aUtUUDgvc1g2VWRkbElUV3lKMlNF?=
 =?utf-8?B?bTFTdGIvYkJ4VXN4cFJsajBpRW9YeUE3K0pVMDA5UHJuN3Z2NU13SDdlYnNH?=
 =?utf-8?B?N2kvMDlWNUpkeTZYalM5d3dHUVNwRWt1RklXeTdQMVQ1R25ESXFJSlVUd3Zy?=
 =?utf-8?B?ckdiQUtHSDdlYzBZY3lPNzU5THE4QWlsMHk4eTRiTlNXemNqY014TU91cUdB?=
 =?utf-8?B?bGRBOXpJWDkwSmhYUGxUVWpSUnZRL3RLeW9DVjV0ckd5QnhXNWU1RFd3VWlt?=
 =?utf-8?B?b3VsVFNUODRiZFJzWWRjaXNNRE1BN3phR0c3TktLSUJmdGFKTmpvQ2RzUGRH?=
 =?utf-8?B?L2tiaC9JSjdadTdMOEV5RmVnLzdJSGNTaTQ2bFpoSXpsS3p5ZlVGYWhndlQw?=
 =?utf-8?B?d0JuU2pXZzlnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0JUcDQ5MjQvc2F3RW1YbEhxdEZ6RnZkbTNhbytKK3Q4ZTR1OXlDNS9MSFJt?=
 =?utf-8?B?aEpBZkhZTEliR2lZZDAxQnpmT3I2ZnZFTVhrL3ZPUW1FOGxWdTIwVmMvZGpn?=
 =?utf-8?B?c3lVWUx3aHdwdmF3clFPRGtRa0NDWUtlN3NZaDhnelNnejdmWGkvWXJtZW9D?=
 =?utf-8?B?MkJ0MWUzOW9LSzFEZlRqUnJZTlZ1VFUxUUtEeWlza1J3MlJzMlVOVXdkdnhJ?=
 =?utf-8?B?MS9zRG5mSGpiNHJvdHZ1YTY1a2RMMHhuMTBRV1psaCtaeEpLNE4rdkdkZDU1?=
 =?utf-8?B?N2RzM0h1aUVLRTVMcDVuSUcrdG5JYlB0dnNMeXFnNlM2OFB2SXlWMU5SUVA5?=
 =?utf-8?B?cGQ1MUF1bTZKWXp0M204T3I5UEFtSTh1U1dzalQ5eEJqQWE3bXdqV3MwMzd4?=
 =?utf-8?B?QThTcGFsOVZVTUd2V0VVQS90OHdoY21mN1lvM1krM242OEVud0dkRlJVenh6?=
 =?utf-8?B?VkFqZzZVKytqK3c4TURWdFpPMWhML2czNmg3eEJUaUllTU5SWjZaQ0J0b0kw?=
 =?utf-8?B?MlplbjN1dFFwcHRINkpvRVpLc3psMW9LcCtESWgyRDliR283bjhKeUp3UGtj?=
 =?utf-8?B?TEFMWitBeWRUdC9mRnVsbk5KZXN1TEVTUDUybmJxUkwzaXdUaEF6SHMvY3hu?=
 =?utf-8?B?QUR2QUxiUnFGRUd0a1BERGpFMWt2blpySXg3ZGFjbkdpL25Mcy9iTGlTY3dr?=
 =?utf-8?B?ZTMrd291WGdYVWIzUjdDT0VoN001cnZ1NHNEeEJ1YmVsdkJENTYzZk8zVDZK?=
 =?utf-8?B?dEtzM3ZScHdTTXVKY2VlYXdSNy8zRE13U1E4WDBhU2dJR0JNcW9MT05MNkRV?=
 =?utf-8?B?MXNDMmdEL21Dc1c0UW5iMThzejkwMitvaW1ORFJ0ZFpRQ21vN3hzRVo3amFD?=
 =?utf-8?B?RG90Qk92MmpDNWQ0aHkrM3g1U3RUNGg1ZFlXVldNWU9WckFzYkpGTDVFQzZp?=
 =?utf-8?B?T0JVYjVtU1B0eDhKZTJjN0ZETGorQ25YQkY5M1lra3dLdDFSbHBLNEpxVzRz?=
 =?utf-8?B?TFRWaG1rNkx2d21IUnIxN09HazJDaHhoRDc3SkNtekxSeHNlbHh5VHJaTGlH?=
 =?utf-8?B?aEpQVjBjRHZNWmpTa3RZZVJMT3BDdThxWHBTMU5ZcU1kMDVkbTBEWVBOb21x?=
 =?utf-8?B?cHJDWmgrTUhHcjFtQUhRSXdUK29tM1VlcVF1aTBSTDMrN25xdFRlS3dFLzF5?=
 =?utf-8?B?ekRQU0xWRHJET1JOeXIxa1FpWU4xN1dUK1ZacTQwYzFnZy9BQVVLUjFSYVlZ?=
 =?utf-8?B?akoxMlhpRVh1QnpJVXpUMEV1TXNEUEk5M1JIVlYzdkhzeThzNStCTTRJQ2di?=
 =?utf-8?B?c1BJTDMzdG84UnRXbUJ4RGtNeDUvQk1QWU5EbVQwM1pIbk51WUJoSDNIVWxI?=
 =?utf-8?B?NjFNWTQzajE0RkFMQVdibklwWHFwMThmZ3U0dUE5N3FtVEtEa3dHbFA3eG04?=
 =?utf-8?B?c1c2RTBOcE1NRGMrZkRQNGpPWkJFdTJ6djdnWGNQc25Ed21pN2xlUVA3TjB6?=
 =?utf-8?B?NWlGRGxmUGUzZXBxdlNjK3pMcDR4MFJzSElFQnFTaEZqNmYveXR2WXBaWGh3?=
 =?utf-8?B?aDBkaVNRZFh3K1J1bW5Ub0V0dnp5K1E2S1ZCVWgxUE0yWW9kazVOUGRVMnBl?=
 =?utf-8?B?VVJYODhHZGUvSEtuTzFLZ1ViZ2RSNHBEaFNpcmhBdVJ1SWZLWnFJd0JzTkRR?=
 =?utf-8?B?Yjh2NzZLUlBPVWlMTlVCbko2enJTWG9jL09leG1nU0VHZ0lTSFNHald6UGx2?=
 =?utf-8?B?amNKaWY1UG1tTlQrNFNyT1RaWlNqTlBzS2ZKUHVSVVpiZHpMaUx0b2NtcE5i?=
 =?utf-8?B?Y3h6U0xXVmwrWFJTenZndzhSVTJIZzRjcCtQOFBhUk5keTAyTU5LN29lZ3BX?=
 =?utf-8?B?VFdnRVozS0dMLzFOMnRpNzFtRlpVcWVtdGdMYWpSMHJLb1R4Vk5uNjNza2Y1?=
 =?utf-8?B?WnViMFVEemt4dGE3d1daRGhJR1BpOG0rSSsyaXo4RVduNWxqYUdwOVNHRVNO?=
 =?utf-8?B?UW5yQUNYbWl0RTA4RXpvV201ZFFYSyszS1hGRWRValFuT1dvMURLdVdpQzZo?=
 =?utf-8?B?UGljd3lnTWs4dXY1em56TDdlb2c0SWF1YUxxQW5vRmRTNm82K2FIdWRBTzFl?=
 =?utf-8?Q?mXzQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c8c4a6-879f-4dec-f469-08dd6c7c1d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:37:28.4473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQbQqlhNEuoKIJ3/YzKcXU3/vJCWn4fx6aSnNVF6tRzmeWyrJIhaKpN2lkkiUvpmHsR23vIm5d58xpMkceBuDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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
Cg0KU2VyaWVzIExHVE0sIGlmIG51bV9tZWMgdmFsdWUgaXMgY29ycmVjdCBhcyBwZXIgdGhlIGh3
IGRvY3VtZW50cy4NCg0KV2l0aCB0aGUgbWlub3IgY2hhbmdlcyBJIHN1Z2dlc3QgaW4gcGF0Y2gg
MSBzZXJpZXMgaXMNClJldmlld2VkLWJ5OiBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQu
Y29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI2LCAyMDI1IDc6
MjggUE0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHUvZ2Z4
OiBtYWtlIGFtZGdwdV9nZnhfbWVfcXVldWVfdG9fYml0KCkgc3RhdGljDQoNCisgU3VuaWwgdG8g
cmV2aWV3IHRoaXMgc2VyaWVzDQoNCg0KT24gTW9uLCBNYXIgMjQsIDIwMjUgYXQgMzo04oCvUE0g
QWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBwaW5nIG9u
IHRoaXMgc2VyaWVzPw0KPg0KPiBPbiBUaHUsIE1hciAyMCwgMjAyNSBhdCA0OjM24oCvUE0gQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEl0
J3Mgbm90IHVzZWQgb3V0c2lkZSBvZiBhbWRncHVfZ2Z4LmMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyB8IDQgKystLQ0KPiA+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaCB8IDIgLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiBpbmRleCA3MmFm
NWU1YTg5NGEyLi4wNDk4MmI3ZjMzYThhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguYw0KPiA+IEBAIC03NCw4ICs3NCw4IEBAIGJvb2wgYW1kZ3B1X2dm
eF9pc19tZWNfcXVldWVfZW5hYmxlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngubWVjX2JpdG1hcFt4Y2NfaWRdLnF1ZXVl
X2JpdG1hcCk7DQo+ID4gIH0NCj4gPg0KPiA+IC1pbnQgYW1kZ3B1X2dmeF9tZV9xdWV1ZV90b19i
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCBtZSwgaW50IHBpcGUsIGludCBxdWV1ZSkNCj4gPiArc3RhdGljIGludCBh
bWRncHVfZ2Z4X21lX3F1ZXVlX3RvX2JpdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBtZSwgaW50IHBpcGUs
IGludCBxdWV1ZSkNCj4gPiAgew0KPiA+ICAgICAgICAgaW50IGJpdCA9IDA7DQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgNCj4gPiBpbmRleCA3NWFm
NGYyNWExMzNiLi4zMTllNmU1NDdjNzM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+IEBAIC01NTEsOCArNTUxLDYgQEAgYm9vbCBhbWRncHVf
Z2Z4X2lzX2hpZ2hfcHJpb3JpdHlfY29tcHV0ZV9xdWV1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBhbWRncHVfcmluZw0KPiA+ICpyaW5nKTsgIGJvb2wgYW1kZ3B1X2dmeF9pc19oaWdo
X3ByaW9yaXR5X2dyYXBoaWNzX3F1ZXVlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBh
bWRncHVfcmluZw0KPiA+ICpyaW5nKTsgLWludCBhbWRncHVfZ2Z4X21lX3F1ZXVlX3RvX2JpdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IG1lLA0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgcGlwZSwgaW50IHF1ZXVlKTsNCj4gPiAgYm9vbCBhbWRncHVfZ2Z4
X2lzX21lX3F1ZXVlX2VuYWJsZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBtZSwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcGlwZSwgaW50IHF1
ZXVlKTsgIHZvaWQNCj4gPiBhbWRncHVfZ2Z4X29mZl9jdHJsKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBib29sIGVuYWJsZSk7DQo+ID4gLS0NCj4gPiAyLjQ5LjANCj4gPg0K
