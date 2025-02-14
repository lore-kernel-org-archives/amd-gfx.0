Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB2DC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 07:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C70910E25A;
	Fri, 14 Feb 2025 07:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvOVAAPW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3515710E25A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 07:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSorkeVGL1oZycg5HxnCfE2ijxLkHaQt6ouq0GrpKKr6JzeN3/5ukWVNRmY0TvvQvVrQjp/WOMA9b5RwUImRMlirXQ3p04L+THFMOHeDvz9srbT7U5btc61d+2MnUptiy6RCJhHkOm8qBffbqyQnhdvlAu0KKj7Ow+PnF6WuejB3Y+WB5wRkIrV6Y3LMltnKJ3i8CwTIDpiVOQ+b3vAtLGhe+wJmlHSmh9+c7swAR3+9awV/zqhMUoortybQ/0eoawoNXLmjruUHUulTI3j141PWvyqCIwxooo9gYzwKkB3vUxWcuStgXoKXJ3B8A3o9c8UBTXlEr04n3dWO9xbMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcan4OVV7xz2UL6B1MZQ+D6AS5pfcOiL+5IdVmIinSY=;
 b=M40ECYBoa2kE4lHKkJ/3FZ3MLBU/wdr/58OXC+dSDc3MerXf1d2ZKBESjAT/ODWn6WX/z+EONQnBKGlPVPM2ObDOvg9m7gtr9aaxzabao2V2zugWiBn4TxxXj/SdgrKMAZmS6t67uFD7f5oXU9akfP/UbocHoqKsA4YBsAPIBJSGlfD0XihJtfn+EJfC4/kOf6/YlWCRaIkkQQvXq8nGviUTJvETmd20yj4YirqZMA/PHr87mKbrsnzjApGgpBP+TCREkrbHlxWAqu4MPID/a9gVaiXiKFPe8AQEBbXXny6jwMhYipRuQ1fFdIS44BJIUzLOurSdcTyPRflB9ZrqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcan4OVV7xz2UL6B1MZQ+D6AS5pfcOiL+5IdVmIinSY=;
 b=xvOVAAPW5xvBI51o7tkjX9LrewbhW/q48hwc2BzezYGxLCV8skYIydRuO+X9AHKPXRW961J5OUEDJBG0D1HmPhPquT+nz4xrA+3joOxVB8rduAgTwtCG6+FCuTkA39K/PdNkYIM6/mbuRTvysePQQRGS9WSUj8eAQt4NM4/IPZw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 07:13:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 07:13:36 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbfqUgpac7AJfeDkyfVOHaip6rBLNGUNqAgAAJVVCAAALwAIAABO3Q
Date: Fri, 14 Feb 2025 07:13:36 +0000
Message-ID: <BL1PR12MB5144F189182A042A78904EA9E3FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
 <989be73f-bc25-46a6-bd28-3a2576fdc73f@amd.com>
 <BL1PR12MB51446E8E4C516978889145F0E3FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <6c3c7cc5-c08d-4b17-95d1-43b926944713@amd.com>
In-Reply-To: <6c3c7cc5-c08d-4b17-95d1-43b926944713@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3e343bde-0197-4811-961d-6d358bb0b25f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T07:11:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8713:EE_
x-ms-office365-filtering-correlation-id: 2de71968-f25c-4ddc-5d69-08dd4cc71944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZFNoNGtiY1M1eXNwdHc5YWhaTjhOUnFtQU01S3RQeVluZUVRQmp1cWs0S0Vu?=
 =?utf-8?B?TmtEc25xRTBjK2ZyalZLd2tCUXpLTlhzT0dsMGtmMGlrUUx5VFBzcGJHdDdq?=
 =?utf-8?B?RFU2Ni9HVzc1dWpFUVkrNzlHaUMrdzVFRVYzalBiaTBhQnpFUlRQZDBDTmN4?=
 =?utf-8?B?SDNYek9lVkcvR1Q5UVJ6WVVnTmhPOWoySzNtZHlvY2JDcVZBVnRmeDlvSUdn?=
 =?utf-8?B?dVNkTkVtc0FYQ3k4QjhoSHRzQ3U0TEFyQVQrNUJaTGxIV1Awd3ZOdFRudXRL?=
 =?utf-8?B?aWJJVThiQXFkUWhoYW4rQmNEMW1QOGhKMDE5ZklJZUFwL09GOFRzcDRhTzhF?=
 =?utf-8?B?TVNkK21SczNudXptdU9oRWt1NmJXcjMrYSsrYnZ0Ym56alY3TDc0amR0UWhm?=
 =?utf-8?B?eEs4TEJDSE5JYlM4M2FBQjA2NUtkUDZucVlGR3h2aTgzVWxPaHN0MUlmRHVN?=
 =?utf-8?B?VU5kd1Zhak1ZTnBSMEpHZGdDZGNBWlVsOURXN1FGdDZkOFIzaWdWazhUbkxD?=
 =?utf-8?B?YU5JOWNZZStPRUd5RTVTV2pWVFR0S0Y1UG5ZZFZJdXZnRnRkZ3BFcTE0L3ov?=
 =?utf-8?B?dDJWM01SRmhPTDc5ZjVxK0RzaStpTytmMnExTXRXSHAzNm5xdHFGNTVVdGlx?=
 =?utf-8?B?SUhLSUdXWEIrc0lwdmlJeXZSTnIyUXEvdHA0cUthM2ZvaW1nSEd1WVlVdlpN?=
 =?utf-8?B?Ky9TRmlrczl1SEl3aG1Qb1p3RkFIQzRCZmw5TUN4dFZjTUZaOXRZaTM1cGdS?=
 =?utf-8?B?QXJtOTZ4blZFVVJNN0lwMGVTSzc3ak1ucTh4L1FDL1lVQmFoRjZTckt4ZnZT?=
 =?utf-8?B?RUdXSWxuVzREVnFaS3B5R0c5N2g5N01RWnJnb002YnBSMUZuaVJhZTJpMkIr?=
 =?utf-8?B?eW1GQ3dDTkxWNnZVcFFwQS9GUVM1MUxaTDUvdTNRUmZKbHdBaGkybWZ3eTBs?=
 =?utf-8?B?UXE5Q0FOeFhoY29udEtJSElUenluL2p0ZmVrWHpGY0c4NmQrK0xKeUFicUFP?=
 =?utf-8?B?Zyt2VGxseFh3dFBhZEJ3SDlsVEV2RU5DNkl6d0NlS3VHOGZWbExBY0RBeWRX?=
 =?utf-8?B?eGFuWFZWNUh3UVJnRVpqTE0zY1VNWCtGVitPUGN3NGZNUDdCWTdBNHBqSENB?=
 =?utf-8?B?aER6SXR6UUtmeTVOcVdPUkxKTm1iL0tJSmRKa0NSM0JPZ3puT2tsb0JiS3Ez?=
 =?utf-8?B?SERMK0o1WXUybVp0YVNBMzNJKzU4MCt0ODJHdEJkQmNyUWc1ckpPdVQ3WkZY?=
 =?utf-8?B?UndiRmh3aGtKZW9Fc25UQVVCK0h4dkl1TkYxcCt3ODFPQnV4K0MzWlN2QU9H?=
 =?utf-8?B?MHN3VkVKbFJxUlZ0ZGFpSWlFWjJubW5CUnM3MmJKdzBlM3lPSmtiaUZwY1R1?=
 =?utf-8?B?Q3F0TFYvejRXSFIxTzVNcDNwVW45R1NnQjN4dkJXU0tvKzZJTko4S2hPaWJx?=
 =?utf-8?B?M3JPY1B5WjNhRVZ5YkV3U0VocFY3U0JpUm9uTVh0clR3UlpNcEt4TUdhZnRC?=
 =?utf-8?B?SDdJY2JnR3BFNnVUa0ZFM3BPZkVaR3NiUC9uMmlzNW81K2NIRjVmdGxsZEYy?=
 =?utf-8?B?RGpNZUgrZHV2WE00eGNnOW5wUWpmQnFLL3BINW1MVm1VUTFwUFZheVIxTWx2?=
 =?utf-8?B?UkhKTGhpdmFCZWFEWEtvaVgwR3psYlg1SnBKbHplRG5nQmdYcE5pS0pGTEpl?=
 =?utf-8?B?UjExaGFoaVQ4L3BYWkJNb2lQdWtpNUxNMHVSdEIrNFRLR1kvVU1BM1NWZFhv?=
 =?utf-8?B?eUkzZFdFMWFPSUM1aWxrMk4zNGxET01tUjJYcUo1YXBGbXNaTS9jd0JMSFpj?=
 =?utf-8?B?NzBWb2NjUmVzbU9pdDVtYUN2cDJuQ0JtdW1aNmZTSWJnalJ5WDFpUUZJSDVD?=
 =?utf-8?B?dy91TmZoN2IrOUEyVXJJT1ZobHJXY3YvV09CTTM3allQWkZEZmlhNm1nM0hP?=
 =?utf-8?Q?k8QCVkl9cUoMCxm+TRCvoX5dF7JVsuU9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUhxMXhhMmVxNlVGckYySk1jTHlJaHR2OG5CUStVMDBNL0tRQWM3ZkFBdDRI?=
 =?utf-8?B?WjE1NUpIeUJUSmhLUEhPMExUaW9UOHZGT1hFSC84ajgxNTYxRjBBYmUvSXVO?=
 =?utf-8?B?Zk4yN0owbWMwOW9MUHRuTVNGV3FOdmw0Ym92MDA4NzIvSGhLNW8xTFhFYnBX?=
 =?utf-8?B?WnIyc0lBaVVkYmkremhlV0pYZ0U5cmFlaHJhNG01WWpqMWxLOXl6SnpXY29s?=
 =?utf-8?B?dWxGaWdFTUZGNS9JNXFCYUNFVXU3blJTZUwweDdzS01ZVlJlNlU5NXNYMysx?=
 =?utf-8?B?YkhCUzNqaFVwSTRDaTdRTW9pNnFwTGJFeTNBbUNjTUlVVFdYSHVtNHI3ZUxp?=
 =?utf-8?B?QUlXRTgzZFBKRHNQSkpMbCsrN1lZOG5xV1Rod3dacWpIYm9nb3ZPcXRjWUJz?=
 =?utf-8?B?cm1LNFVRRmh5cGlPeWIyTHFHZTZwdFppNDYvcW1Uekg5aFY4alBLdkk3Yzg2?=
 =?utf-8?B?OE9BYXgxenFaVVgzbmF3MnNua1phRFYwUHM2alNQWktIODUyd1hpMmoyVGY3?=
 =?utf-8?B?Z0ljR2p5U2ZYWm5TSVMwRklja1JsNmtGaWErOC9kVU1VakpyZmw1TVhNZVYx?=
 =?utf-8?B?WGZFQld5dzVBdVBpY3J0SHozVUxXVVlBMzNmTytzTE5vbmRPVGh3aEpwS2tV?=
 =?utf-8?B?dlNrQ0J2TFFvdXhhOFh2Y09PTXRvNHhmNmFBbmtuYS9DV2Z4c05YQkF5T2xJ?=
 =?utf-8?B?NWdDSk1WdXlYV2lQbmMrTklEemVjaVh1RUxzUUw1ZnY0SWRvbzRwT0FoakZO?=
 =?utf-8?B?eXZSekNnTkQxVlRReU9oM3NPbTVRcmgwUTIvRFZpejNuK0x3VjJ2YytXTE00?=
 =?utf-8?B?Sm9CbUNTOTkwZG5KNytWOXdzTE9oSkZIL3Q4WG8vdVlxYlpSQ1RBUS9QNjJo?=
 =?utf-8?B?TWZHb2c5OTkxNkYvRE0yMHpLek5lQlBDRGJYOGlZREY0MjBLa3UyaHdiMk9U?=
 =?utf-8?B?dStWSVlGRUNldks0aE9seFcvMXhEeWhadlUxRlVKQnFOM1JZOTJ6OXNlWCtv?=
 =?utf-8?B?aWpZWUJ4RGJDRldoQ3ZNZUhVczZsNm8wT0xGOE5SQ21DVU9Eci9XaEl1bGdx?=
 =?utf-8?B?cmFIZzg4MHJXVFpxenFwWFZNampLTUdvTTMyWjlNUzZZd3pQUE1SaHdJOFUv?=
 =?utf-8?B?dnhTejFBUTZyR3hhSUsxR29WOTlBNEwyenZSdFY4VjRJVFNMR2RUcUlQS0Qx?=
 =?utf-8?B?ZGt6STVhcDk4UXVpY05ydDU2MHNsaEVQdHRFeGlqRmNkSDZsNUFWWHNsTWJB?=
 =?utf-8?B?RzRpRnc4T05SdFFiVmJFbWtMb3FZejVkMWdYYXhpanFPejlSdDd6d0hkZWdQ?=
 =?utf-8?B?RklsUDBMN1NBSmxGVGE5dCtndjdJdG1leEFycVVENjRwd0RyaWUyc0phUTZy?=
 =?utf-8?B?U0ZVZWJwbTBtQWVabVEwQlJYUEI2UDFyRDNHY0U4Si9BTHhkRC80RmtFQ0Ju?=
 =?utf-8?B?bkV4a3g5cTBUaVpUdGU2d2lSNjBhMi9YUHFDRk1MNkJDZGJNYnVEbW9KeE5S?=
 =?utf-8?B?cHlFVVdLNy9DZDJYd2NyNzBlTVRpTGhTb1dZQkpCVUEza1FhL1lOc2RqUjZH?=
 =?utf-8?B?L3NlZDdwUmtzdHg1cEdmTkl3SEUyS1NpaE1MVFVjdm9tYXFDaFlVYTlGMmw2?=
 =?utf-8?B?azk2NGYzOGtJNzdpVUIra3l4N1o4M2MrejJXQzZFYjRtOUgrN2NoSGhoYUZN?=
 =?utf-8?B?NHVxbWNUWU0rMU9wZWE0U25YcVJabHhyRVR1cTQxRlFid21JZ2FaYWhmZ2NM?=
 =?utf-8?B?UThZSzJEaDJxMElTYWJrN3h3VTJrVnp1MGlDWkhxcW1tQVhmZGJnS2Q0bktw?=
 =?utf-8?B?Q1JnQW9YWnhSUk1VcjJsRG16MkdpTnZub1NWRjJrenVBbnF5Z2ZkZUttZHYx?=
 =?utf-8?B?ZllZakh2c2lSbnV1bmZ0Z2lDTklJWDl5bkxKMC9NRGVTU2NyOENFUStPSFp2?=
 =?utf-8?B?dnB1dDNsTVVKZ0hTQ2NvMzNGUEFBeU1rQWFmS3I1T1VyNG00alRRWXk3a1BL?=
 =?utf-8?B?dkZjNFllQUxBd1FPUHdKSGMxK3ZyTVZ2RzNhZVFZZG52cFdMNFF0ekJGRG1h?=
 =?utf-8?B?bkUzd0w2WWxMWURndW0yUzh4R0YzZUVReWZ5VVUxSkpFT1Z4Tm1xV1daQUwx?=
 =?utf-8?Q?TdVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de71968-f25c-4ddc-5d69-08dd4cc71944
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 07:13:36.1965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnKiJ6l/wUu1dLzRVLUQ4DfxwRmCKZyj3IyJRMd/WoNy8oVcpP5tVRppKYnLHLktTLS0TpDLtiYMFLAedwn7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE0LCAyMDI1IDI6NTQgUE0NClRv
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBaaHUsIEpp
YWRvbmcgPEppYWRvbmcuWmh1QGFtZC5jb20+OyBQcm9zeWFrLCBWaXRhbHkgPFZpdGFseS5Qcm9z
eWFrQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogRW5hYmxl
IHBlci1xdWV1ZSByZXNldCBzdXBwb3J0DQoNCg0KDQpPbiAyLzE0LzIwMjUgMTI6MTQgUE0sIFpo
YW5nLCBKZXNzZShKaWUpIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBIaSBMaWpvLA0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0K
PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE0LCAyMDI1IDI6MTAgUE0NCj4gVG86IFpoYW5nLCBK
ZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEtpbSwgSm9uYXRoYW4NCj4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgWmh1LCBKaWFk
b25nIDxKaWFkb25nLlpodUBhbWQuY29tPjsgUHJvc3lhaywNCj4gVml0YWx5IDxWaXRhbHkuUHJv
c3lha0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogRW5h
YmxlIHBlci1xdWV1ZSByZXNldCBzdXBwb3J0DQo+DQo+DQo+DQo+IE9uIDIvMTQvMjAyNSAxMToy
NSBBTSwgamVzc2UuemhhbmdAYW1kLmNvbSB3cm90ZToNCj4+IEZyb206ICJKZXNzZS56aGFuZ0Bh
bWQuY29tIiA8SmVzc2UuemhhbmdAYW1kLmNvbT4NCj4+DQo+PiBUaGlzIHBhdGNoIHVwZGF0ZXMg
dGhlIFNETUEgdjQuNC4yIHNvZnR3YXJlIGluaXRpYWxpemF0aW9uIHRvIGVuYWJsZQ0KPj4gcGVy
LXF1ZXVlIHJlc2V0IHN1cHBvcnQgd2hlbiB0aGUgTUVDIGZpcm13YXJlIHZlcnNpb24gaXMgMHhi
MCBvcg0KPj4gaGlnaGVyIGFuZCB0aGUgUE1GVyBzdXBwb3J0cyBTRE1BIHJlc2V0Lg0KPj4NCj4+
IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBhcmUgaW5jbHVkZWQ6DQo+PiAtIEFkZGVkIGEgY29uZGl0
aW9uIHRvIGNoZWNrIGlmIHRoZSBNRUMgZmlybXdhcmUgdmVyc2lvbiBpcyBhdCBsZWFzdCAweGIw
IGFuZCBpZg0KPj4gICB0aGUgUE1GVyBzdXBwb3J0cyBTRE1BIHJlc2V0IHVzaW5nIGBhbWRncHVf
ZHBtX3Jlc2V0X3NkbWFfaXNfc3VwcG9ydGVkYC4NCj4+IC0gSWYgYm90aCBjb25kaXRpb25zIGFy
ZSBtZXQsIHRoZSBgQU1ER1BVX1JFU0VUX1RZUEVfUEVSX1FVRVVFYCBmbGFnIGlzIHNldCBpbg0K
Pj4gICBgYWRldi0+c2RtYS5zdXBwb3J0ZWRfcmVzZXRgLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTog
Sm9uYXRoYW4gS2ltIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFZp
dGFseSBQcm9zeWFrIDx2aXRhbHkucHJvc3lha0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
SmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jIHwgMyArKy0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPj4gaW5kZXggYjI0YTFmZjVkNzQzLi5lMDFk
OTdiOTY2NTUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y0XzRfMi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRf
Mi5jDQo+PiBAQCAtMTQ4MSw5ICsxNDgxLDEwIEBAIHN0YXRpYyBpbnQgc2RtYV92NF80XzJfc3df
aW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4+ICAgICAgICAgICAgICAg
fQ0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgIC8qIFRPRE86IEFkZCBxdWV1ZSByZXNldCBtYXNr
IHdoZW4gRlcgZnVsbHkgc3VwcG9ydHMgaXQgKi8NCj4+ICAgICAgIGFkZXYtPnNkbWEuc3VwcG9y
dGVkX3Jlc2V0ID0NCj4+DQo+PiBhbWRncHVfZ2V0X3NvZnRfZnVsbF9yZXNldF9tYXNrKCZhZGV2
LT5zZG1hLmluc3RhbmNlWzBdLnJpbmcpOw0KPj4gKyAgICAgaWYgKGFkZXYtPmdmeC5tZWNfZndf
dmVyc2lvbiA+PSAweGIwICYmIGFtZGdwdV9kcG1fcmVzZXRfc2RtYV9pc19zdXBwb3J0ZWQoYWRl
dikpDQo+PiArICAgICAgICAgICAgIGFkZXYtPnNkbWEuc3VwcG9ydGVkX3Jlc2V0IHw9DQo+PiAr
IEFNREdQVV9SRVNFVF9UWVBFX1BFUl9RVUVVRTsNCj4NCj4gVGhpcyBmdW5jdGlvbiBpcyByZXVz
ZWQgYWNyb3NzIG11bHRpcGxlIElQIHZlcnNpb25zLiBNRUMgZncgdmVyc2lvbnMgYXJlbid0IHRo
ZSBzYW1lIGFjcm9zcyB0aG9zZSBJUCB2ZXJzaW9ucy4NCj4NCj4gSW4gZmFjdCwgdGhlIHVzZXIg
cXVldWUgcmVsaWVzIG9uIE1FQyBmdyBhbmQgcG1mdyB3aGVuIHRoZSBzZG1hIHF1ZXVlIGRvIHJl
c2V0Lg0KPiBTbyB3ZSBuZWVkIHRvIGNoZWNrIGJvdGggb2YgdGhlbSBhdCBoZXJlICB0byBza2lw
IG9sZCBtZWMgYW5kIHBtZncuDQo+DQoNClRvIG1ha2UgaXQgY2xlYXIgLQ0KTUVDIEZXID49IDB4
YjAgaXMgaGF2aW5nIHJlc2V0IHN1cHBvcnQgZm9yIHNheSBHQyA5LjQuMy4gV2l0aCBHQyA5LjUu
MCwgTUVDIEZXIDB4MjAgbWF5IGhhdmUgdGhlIHNhbWUgc3VwcG9ydC4NCiBUaGFua3MgTGlqby4g
V2lsbCBkb3VibGUgY2hlY2sgd2l0aCBNRUMgZncgdGVhbSBhYm91dCBHQzkuNS4wDQoNClRoYW5r
cywNCkxpam8NCg0KPiBUaGFua3MNCj4gSmVzc2UNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+
Pg0KPj4gICAgICAgaWYgKGFtZGdwdV9zZG1hX3Jhc19zd19pbml0KGFkZXYpKSB7DQo+PiAgICAg
ICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbCB0byBpbml0aWFsaXplIHNkbWEgcmFz
DQo+PiBibG9ja1xuIik7DQo+DQoNCg==
