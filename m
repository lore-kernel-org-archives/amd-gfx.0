Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03968C27C4F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 08:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B32689D5C;
	Thu, 13 Jun 2024 08:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kktgJV76";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9AB89D5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 08:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGCmwNNbBTt8T3Wibnq+sBu6djm09wBbMr6nOX2OSJXdgrRY6lcIFhIuf/SSS7nPpTSPzkDUfo/ximAn0YNwrEybHTm956bEYgqlct14ULCnh6WkBcy1xXsdy5JEM+cfpsGr4ld28phF04f5jsqqW3y+dAIkTLiy6LSveUmPQT9nE2xfpDXvDPW+ST3fN1JgZFDxho77aA4gaEl9OaMkedSzev99JIbvKLBAMFoZHWJQl+e+yU5dPR9M2wdI+AsC6eLUQlhrDsXnIaCgVyCprUQmd2Ks4/TeKoKeWlGn10zJ9eIzfYsw2FdLAtGN5NGQ0Npk54+MIdy6+1jZMgIb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L25o5y6Gi0BOWLb9Ri2tEbrakIG9fpiUqo3B079HZ1g=;
 b=kIvbHx31uk0SPZlojAlgRHjqRxGYMXmy7CNpGNsH/EIMAEg2t9OLLr9oVZpPvK4YjuZrApJUo7zq2JfrEmcy4jwITOsBhsodFAJNmndpe3abiFCOAEhwZSoA0a/vqfLKmiO2nGF+xxIGN10gyqtTt3+MeWSsus2O9ogwhugP/ggzv9iYJ6qCFk5Xl6bU+VgMj5m+vXLMv+1o8lw+Ieht7zIPVB52ymWgPyD1D1xMdY53UUjWsf/EZrUTi5n+8ZkFwh86DnHw9bK8lZ+wGdGumVFJfxmn7YSLwKhnbMWelNhFcx9//GlKI7LNdE574w0O6CvqOVIcOCcTLlG91j6Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L25o5y6Gi0BOWLb9Ri2tEbrakIG9fpiUqo3B079HZ1g=;
 b=kktgJV76FcfEApSzCf0spCN7uEiowXDxp3+W/TpvprJZRoYKuYdc6s6MY9QSOFVMZQEOLS+Sme/X9rfsBXEVYpGkj3a/f8AfdFch5rG4dO34hq6iTQqxVYv7Whd68NWvQd/Qei98UodhHisAgTbVi+pQpBE0NnQ38yl69+u9rqI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 08:19:33 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 08:19:33 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
Thread-Topic: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
Thread-Index: AQHavV78Ywu/j4z2p0WcVWMkiHz/t7HFVnmAgAAC/9A=
Date: Thu, 13 Jun 2024 08:19:32 +0000
Message-ID: <PH7PR12MB8796E2B895289071413D6BE2B0C12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240613065726.30129-1-tao.zhou1@amd.com>
 <cc2e1263-d8e5-479e-b5fc-38d09ec200ed@amd.com>
In-Reply-To: <cc2e1263-d8e5-479e-b5fc-38d09ec200ed@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=65d13dd3-df1c-463e-a1c8-016429791f34;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T08:17:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: 5527c3ee-c83d-4504-cb32-08dc8b818e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?MGdKaGNUYTJWVGpLSHVkT0tCWUxDVDEwYWpUNk1aN1ZGZzJtaDUvcHVVeHQ3?=
 =?utf-8?B?VzdoMyt1TmlCT1pYTmx0Tm00V2hjZWZVMEdsbkg0NWhUbVE5RXYwWUozN2E4?=
 =?utf-8?B?aXoxR1J4Y2lhTThya2RSRzNLWEtaYk56S2FJdkkxTVVubmJvTnBXbzBnaFpT?=
 =?utf-8?B?ZHJIaDVZYkFOQXMrbEZOa0F6dmxqZmZBSE5sOTI1eCtuQ28vVitpeEduYm1w?=
 =?utf-8?B?dWE5UC9RK0pveGg3WGVNVTRaNVh2Y2g0emJFUDRxRGFyd1VXU0pzbS91OXZ0?=
 =?utf-8?B?RmwySithajMvVG9lRUFoWlFQUERLSXhSWnJyTjJvUjVzZkhvNkdNcDlHTjRJ?=
 =?utf-8?B?VG5Hdkw2S3BoUjNrYnZhVzhVaGw4a001aUNOT3JiZ0lTcEJySUZqRHdLS2pq?=
 =?utf-8?B?UWVGTExuTjRlL1ViNm9OM3VxcXFpS0tibDljU3NBLzVDZldMS084bEN1N3p6?=
 =?utf-8?B?UlgvQnZ4RGgwcVRrZSthdzQ2YXdqZTJrc0lmKy9YTCswUWdOaVBJdFJmYnll?=
 =?utf-8?B?V3VhbVRTNG5tcTU3N2tqOHJiK3dTdTArVUZuYW9iWWVJQ2ExMlhlNWVTSnov?=
 =?utf-8?B?SU5aRUIrYUZ6NXpab1FEdHhHdG1RVHpsS0pET1NtQW1ud0VJZGp1UHJKSzh6?=
 =?utf-8?B?SnFHR3JWZnRYSjBNaHNrZnplQU5yVDVMc1pzbEhySXJnNFNITHc4TTVISVhv?=
 =?utf-8?B?RjR5d3FXTCtpSWJRSFowS1hoTlBuWlVUdlQ2OGpNck9HWEVzNnlQMnd1M3BW?=
 =?utf-8?B?RFFGc21zaDFZQm8vaTV3V2g0RkdpaDRZdjNBUWZ6RHN5OWUxS0lGK0FJaUlh?=
 =?utf-8?B?NHRwU1FVMzRicnNlaFhGM01ITG9ka3ozT1g4SHJvU3V3SUNyTEcxbHBEYmx1?=
 =?utf-8?B?ZkFJOWIvdzdYV2JlMkZYMjg3a2h0OXNtaVd2SEhhUUxldFBCNTVhQ3JYTUFE?=
 =?utf-8?B?amRXYXQvK2hnTldRdDZaNVJGOTN3bVY5Mm56M0xZa0FnSVptTU1mUVlHK1dB?=
 =?utf-8?B?YW9jZG9obDZXMHVrSVFtQmdScnhjMEJkVGFlSHE0V3cxWGRabEJsMStVbU5J?=
 =?utf-8?B?TkhyQWo4bXlleG9FYll6cE9XeUxkelU5T1ZJMGZrc055N0FCOXdxREl4Z3V5?=
 =?utf-8?B?T3UvWHVtbm0wTGJIM3pUN3krbzR1OFppSS9TMVJjWXZQYlc5dUs3TW9XcFps?=
 =?utf-8?B?dVVBd0xVby8xdzY4WW4rLzJnL1U3emxmMkg4WnF6SmVFN0FQV2EyczRhT2JO?=
 =?utf-8?B?aUM3YVJtcElvb0xtWUJzUytscFg2MEVnSU91ZFhQdnRTYkJOQVM5OUY2d3VW?=
 =?utf-8?B?cE5RbjJvVjZsNGtGdjFRZFNNcnZTL2dtMHFLUnUzQzVOTUtuWTNpMld2VndG?=
 =?utf-8?B?VHI3dEYxaWdtUWFXK0VnbDVQTTJYeEJkclVQV25iODR3SUMzakplMFpDWVpR?=
 =?utf-8?B?ZW1sYVkvckM3cGhMNmJYSU1tU1lkczFPUEFoemlUWFJIWWx2bTNmc1Y3VllM?=
 =?utf-8?B?dnRaM2NZdmhJZEVrZlhZZUp3WGlLOEQwc1JwTndjYnAvVjFOd3h2a3pqbFZq?=
 =?utf-8?B?bW9FelZiOUxhWEpnSkt0VG1oZmpOc2pWQW1LSlZ2ZDh3b1RGd1k2U3AzYzBr?=
 =?utf-8?B?MUMrcFl6ODVzdUxtTFlZeTMxeHV4VDJhL1N3MWJaRVh3RmxyWk9YNWxLVWpK?=
 =?utf-8?B?dVFpakdQT0tKdXVWd2VhNmtFVlFsVHIwNkJEK01rTDh4MkZ0TjFvOFdhYm05?=
 =?utf-8?B?ZXRVZFpvcjFlMUo0cE90SFpDSDI2eEVRTWdtSnBpRkxiY0JWM0tUOG1EMGta?=
 =?utf-8?Q?mgHbRtSOu06InDTsMUkfcLaOOtkqpZlPTpI0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVNzR05CTzQvSTN1S1gyck9QMGd3ZEptTEk0SEsxVjdVZmp3Y01McGhjemwy?=
 =?utf-8?B?MXpCTElZcnJIbVBhdnpCT1JzTmxaYXdzS3NoMXVSdWJncm5McEVTcERrdm5Y?=
 =?utf-8?B?RHZDUWxTQmE1RFJqMzl0aWZVcXRKRGprcDZsUEk2cjhIUi9JcWR6TXJFcEVJ?=
 =?utf-8?B?Nkdpak1aSTZFMmhHaFBlZkhvNGlDVEl3dTVPZFpOM2k5VHM4L09rdnoyZnJ2?=
 =?utf-8?B?SERuZER1QVdIQ2Vxd2dmbG1NZzZ6UWtuVFJYeW5wV3AzQnlPUHpYRzJoR29Q?=
 =?utf-8?B?UXUzNkhLU1BOc3ZBTVZkb25FNjRabndHN2xEbmx5QytBMWFsSE5jd1N6UXdl?=
 =?utf-8?B?UUFQaHhJMXlmWWx0d2NlbklpUFN6Y3YwZFFFV2NmL2xFNXB0dkN6MmVFQnJ2?=
 =?utf-8?B?cE9tZ0pIQUM2c2UzcnNaTHhQd0wwZ3NlMEV3OGwxamlPN0pBVlVvM1lySHFw?=
 =?utf-8?B?TjdGTWwzNTJhazk3TGUxSmViOHBlRWdwaEFrOEFXT2pOdEcvWEpFREsxc1Br?=
 =?utf-8?B?M3IyQUtMdXZwSmh6R0xYdU1PZUNBb01OTmVTUGc1amRyenE5OEZqTCtWekY0?=
 =?utf-8?B?ZHB0dHZETGdySzdVNHczanNaMnVLWGxJb3haelIxUnBUak04SUZMU3hRYTli?=
 =?utf-8?B?ZVp3cDJhV3E2NzUyT0NQQjR6aGJJR0tvdWdwbjNBZVVETXByWmg5VFB4VUN2?=
 =?utf-8?B?NDZ4RkoyZCtEeDFXcVdBeUhGeC95NGR4dTA4a0pqYTBkTXBVZkpNYllZdUlR?=
 =?utf-8?B?ZGNnajM4M1VrWm51Z0NCUHJiWFBsRnczUU4rdnpHWm5XUDFybTlSSGZoOUdS?=
 =?utf-8?B?VE1sLzhycG5ubXpVVTdGaEE1SXJ0azYrN0t4enBpN1dmVnRLaFdRMnBxcnV6?=
 =?utf-8?B?aEhoNWY2UnNwTFVRcGVremV5alJvbTFaVkxQR29pYjhZeTBtL2dhd0lqcTdZ?=
 =?utf-8?B?NENqV2plczBmSWR2WlBDNmxDcTh1UDF2aXFveFdMTGJTM205S1psbmkxd3pv?=
 =?utf-8?B?RWJyTzdkRDE1SXAyVXNlYzFPRnVYd2tXaVhLd2ljdlBZVmU4Wms2TXExdUpN?=
 =?utf-8?B?ZGdodXRDOHJsYWhzV3RJR3l6NTZ1MzJtb3BTRlBuZ3c3cjVSQ2syMTdlYVBS?=
 =?utf-8?B?RWZqVDRHbnp3REdhR0s0TU9MRmRFaHNFZ1BaclNwTTBTOFhkVitwVXFOaSs2?=
 =?utf-8?B?ZlJUc1dERWZ6MGxPSUJaWmNkbDNOcHA1bmkva1J2Tk1NeERvQzhZNXF3Kzhs?=
 =?utf-8?B?Y1dMQ3pjcGtrWDVNdi94TkxzdGpkc3R2UDFhcVJadkwrKy91VHYrbHN6YVRQ?=
 =?utf-8?B?RVZZLzExb0tNWFJSSGNMamo1QUVFQUJ6Sy91RGIyRE13bWhDeVRJNlQ0cWtz?=
 =?utf-8?B?RzFUT3N3WUhWZDc4bkdZZGduL0tTNzRlRU9DOVdjZjl4R3dudmRKci8vOWtr?=
 =?utf-8?B?N0dSV2tGbjdHTDdSWEZYK1BONjE0NEdBN0hHVHdnRjdZczdVWGd5SWJ1eXJk?=
 =?utf-8?B?UDJNcExGWTdwUFRvSmgvdFlaVjFCQTVHcW1pU0pZQ2piZWRUL01QQW9aajJM?=
 =?utf-8?B?Mi85ZjZqMEJqR0RwN1k2QUhCTDdqUnNOYnY2WGpUQzUyL3NQRW1jUEhFcW9N?=
 =?utf-8?B?cTYya0U1b3diZ0J2OGR2UWZqTnFjS2huZUtFOVJlV0Q3QmN3VmcreUFKSzZa?=
 =?utf-8?B?TTRRMmtKbVVuRVFybEs1Q0YwM1F2b3NIMmNkK0U4V1E3aU5hWjRxUzFuZEY5?=
 =?utf-8?B?ZC92c0tYajVGbGdrTVMxU3JSMVNaYThCejFob2ZSYm9LQW8wVDhBMHFmeFhO?=
 =?utf-8?B?MGt3M1hJTVpkMTU3eGJMbEx1ZXZqWUdBaHBvQVpsaCtGeHc2bCtRaU5laHUz?=
 =?utf-8?B?MjhDMDRUZHpxVDF0K0hyVFFYclY4OUtMQVpoY1JNYWFJbWFjNWVSbnFiNkNV?=
 =?utf-8?B?RklzTWNqUXQvemRjeWxvODB5VTJiSFpvT3NRamx3c0l0QnZReXVtRkhiT1Vh?=
 =?utf-8?B?QWdSVUJKV3U0NmVicVkzb1R1KzRxZk5ydmh1SU5uYzlPNlM5dTdtTGlJNHlH?=
 =?utf-8?B?Nyt0VVkzSGdlMFgvQkRGNjB6STBKMGtxUWlZd0ZaRlQySFAvYkcwYVdzTVNQ?=
 =?utf-8?Q?XVy8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5527c3ee-c83d-4504-cb32-08dc8b818e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:19:32.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOjNWU6z36JD3A6m6EN4rJ5vUYAgVnnqVwpkmybCGxNMGHAY7UB3733k1vh5p9dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMywgMjAyNCA0OjA3IFBN
DQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IHVzZSBtb2Rl
MSByZXNldCBmb3IgUkFTIHBvaXNvbiBjb25zdW1wdGlvbg0KPg0KPg0KPg0KPiBPbiA2LzEzLzIw
MjQgMTI6MjcgUE0sIFRhbyBaaG91IHdyb3RlOg0KPiA+IFBlciBGVyByZXF1aXJlbWVudCwgcmVw
bGFjZSBtb2RlMiB3aXRoIG1vZGUxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3Ug
PHRhby56aG91MUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBpbmRleCBlMWMy
MWQyNTA2MTEuLjc4ZGRlNjJmYjA0YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gQEAgLTE2NCw3ICsxNjQsNyBA
QCBzdGF0aWMgdm9pZA0KPiBldmVudF9pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uX3Y5KHN0
cnVjdCBrZmRfbm9kZSAqZGV2LA0KPiA+ICAgICBjYXNlIFNPQzE1X0lIX0NMSUVOVElEX1NFM1NI
Og0KPiA+ICAgICBjYXNlIFNPQzE1X0lIX0NMSUVOVElEX1VUQ0wyOg0KPiA+ICAgICAgICAgICAg
IGJsb2NrID0gQU1ER1BVX1JBU19CTE9DS19fR0ZYOw0KPiA+IC0gICAgICAgICAgIHJlc2V0ID0g
QU1ER1BVX1JBU19HUFVfUkVTRVRfTU9ERTJfUkVTRVQ7DQo+ID4gKyAgICAgICAgICAgcmVzZXQg
PSBBTURHUFVfUkFTX0dQVV9SRVNFVF9NT0RFMV9SRVNFVDsNCj4gPiAgICAgICAgICAgICBicmVh
azsNCj4gPiAgICAgY2FzZSBTT0MxNV9JSF9DTElFTlRJRF9WTUM6DQo+ID4gICAgIGNhc2UgU09D
MTVfSUhfQ0xJRU5USURfVk1DMToNCj4gPiBAQCAtMTc3LDcgKzE3Nyw3IEBAIHN0YXRpYyB2b2lk
DQo+IGV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb25fdjkoc3RydWN0IGtmZF9ub2Rl
ICpkZXYsDQo+ID4gICAgIGNhc2UgU09DMTVfSUhfQ0xJRU5USURfU0RNQTM6DQo+ID4gICAgIGNh
c2UgU09DMTVfSUhfQ0xJRU5USURfU0RNQTQ6DQo+ID4gICAgICAgICAgICAgYmxvY2sgPSBBTURH
UFVfUkFTX0JMT0NLX19TRE1BOw0KPiA+IC0gICAgICAgICAgIHJlc2V0ID0gQU1ER1BVX1JBU19H
UFVfUkVTRVRfTU9ERTJfUkVTRVQ7DQo+ID4gKyAgICAgICAgICAgcmVzZXQgPSBBTURHUFVfUkFT
X0dQVV9SRVNFVF9NT0RFMV9SRVNFVDsNCj4gPiAgICAgICAgICAgICBicmVhazsNCj4NCj4gRG9l
cyB0aGlzIG5lZWQgOS40LjMgSVAgdmVyc2lvbiBjaGVjaz8NCg0KW1Rhb10gSXQncyBhcHBsaWNh
YmxlIHRvIGFsbCBnZng5IEFTSUNzLg0KDQo+DQo+IFRoYW5rcywNCj4gTGlqbw0KPiA+ICAgICBk
ZWZhdWx0Og0KPiA+ICAgICAgICAgICAgIGRldl93YXJuKGRldi0+YWRldi0+ZGV2LA0K
