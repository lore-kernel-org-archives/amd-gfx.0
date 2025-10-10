Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE4CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794FB10EC72;
	Fri, 10 Oct 2025 18:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JrLW1cCT";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A2D10EC72
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu4oEijj2yH9SQC2pjgu0yneJF24UTW12yxgnh4JMYbI2mcjSVY0FwGVS/g3Un7WB2NkgoZrns/MZcM7ad1ztYxMdNXMsjleH+zakifSWuFlX/kXEYj6NayjZwnkcr2jolXMZs8NoggIT5yxCiZh0bxqOtiTWRA8cl7KDkRmGGGTL2i+OMJ73dhZUevi8R+YdL3WA2dUQktXXfeGs+jBExh+JhYRpXscjCGMzWQUkA1e026USJIsvf9R+ebKCH4dimHHluowMp5A0iHdemSGWGFLefRQ3U7uQpdiXH/3H1LUHeCA+OxWskM0kUZiO0ik5OXqtdt7IkRTqJScEt26gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqXA/kxJzOcETqMXY+02IRgGeTeUX9JrWPuHm8UAxeg=;
 b=AWVw2FHxreRmF1x+PkZFb7TQoMNhPW48+hfv8uAoIvgQ2GH8nUlc6rPyHOGVvdSuoc8vpfmVyF0Vjqd2/OhNYKFC/oBRUtk93utWky2WSlzbAAm6vCQYfkaghmTb2cq/ninjmqy+f2zMZLZk4i+P3IWebKgThLCHF6kvX2tS5tPXaIEdaDY0mFnmeuXR/ahg6RJAVOskrYnvzvB549MybpT+Va/ZWPopkPsst+buxBUrH0vSGQAhLhIC20rf9IHCGa3CjQ8/J5vmxjlVmJ6x4cSEs5zQHVSv6do4dNLzMV9UsPuO287+uUYgR3hYthLfiQ1R21Vj172EGKlieQ6mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqXA/kxJzOcETqMXY+02IRgGeTeUX9JrWPuHm8UAxeg=;
 b=JrLW1cCT4E0WRm2quofL9OpvBm5ugTaS9G529BVRudPPXAGyeXQZsUjYDCSOp4NezTis2OctN0cy49vHtg6uwFXzmnD5K59MWDEk4YteXAMNJ4O6HLjC34O+Mxyo500JNY2Y12aF8GmtbP1WUGFMI9kQ8Fs230DnSFw9E4ybWqY=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 18:30:36 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 18:30:36 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix bit shift logic
Thread-Topic: [PATCH] drm/amdgpu: fix bit shift logic
Thread-Index: AQHcOhMrFIEqeaDplE6Y5m5yem2x6rS7s6rw
Date: Fri, 10 Oct 2025 18:30:36 +0000
Message-ID: <DM8PR12MB53990D4331D93FA2D12DA0C3E5EFA@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20251010182418.648766-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20251010182418.648766-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-10T18:30:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS0PR12MB7704:EE_
x-ms-office365-filtering-correlation-id: da7639bb-523a-4fdd-775d-08de082b1b25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|42112799006|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N2FaUkFLZGZVT3A3ZEloYmkzbytGMlpWcWhLb3RVQUVEOVpqV0swaDFkMnQ2?=
 =?utf-8?B?NUxKSEZXL2NkdnpZa3RERC9qT1BFdlB0YUhPUVVXVncrQ2dLMml1VjNzMlNa?=
 =?utf-8?B?NDVJVXlOV3M4d2daQ0djTnVGRnpMek02RUtMMzNZQlJmc3E4VmlXcXphWjJ4?=
 =?utf-8?B?WEdRZ1V3dHJuUExGdG5lYVhSMys3elhqMEVKcjh1ZUIybkRlb0Nha1NaUThm?=
 =?utf-8?B?RzBuenBzUWhoQ25vRzVaMGlLeWw3RTVHYXlkbGpCbXIvaWRETU5rdVN5Rkp0?=
 =?utf-8?B?SEo2WUxtR0oycThFeHFRQk5UWmVGZFlwSWdWSnl5NENyc21BdDVpZHh5dEVM?=
 =?utf-8?B?bkorVjFzeXhSRi9lYlNpTHRwTVBlM2RVUndSVmRDVThsOC9mSjRyaFp6cG41?=
 =?utf-8?B?Ly8rRDExTGNIc1RQUlozTzliaURUMDFTY3d4ejVqWHNUZENMcmk0cmVIQkxt?=
 =?utf-8?B?ZW1OZzVXdTVmNzNYb3EwYkFjQnFPcEJYTWJISXNmdXFlZmM3dDdHeVdHZkFO?=
 =?utf-8?B?ajY1b0d1QytEcFI2VGJsSzRNQ1oyRVBWRVYxSVBmTk43V2hZZHY4ZWh5Uzd2?=
 =?utf-8?B?WUcxTTlKemdORUpLVEZCbWxnR0lsYU5rYzZ0dzJOT2grRERDbkpIekk3QmxG?=
 =?utf-8?B?MElqVjFmS3h6VVF6dWdpaTFzV3lJT0JjaXBGcW1Jam41SmMybEhpYzJmRWhk?=
 =?utf-8?B?N1NsUXkxTWtUYTllY3pzeWdTbnd2RnN2Wm4wZi8wYkpWU3NhVUNXWVNBdlVD?=
 =?utf-8?B?VHRFNTRxZVArOTJWdVdVb3k2WTkyRWF2N1A5S25udWhUQjgwVERtZ0w0d0No?=
 =?utf-8?B?TVQwbmRxSDNJb3J3Qko3R0dmUnJxL0tCa3NCOUNMNUNVUVpRN0U5MnlJT2FK?=
 =?utf-8?B?UXJBcEZiemdUSnRkNk4ySkU4dDhQRllwZzNjNllLOEZvb1NpVEJiRlA1Mjcr?=
 =?utf-8?B?b2ljYzc1bDFGUmc3aENzUzdiS1NWZFM5NDJGbUxqcHdmc0xHMzJHWGphNTE3?=
 =?utf-8?B?VlhCejlKUEpZNUgxYVpmZG8rOWtTeHZjRnZqWkRaMmlaR1FJd1p0aitBcFlJ?=
 =?utf-8?B?N1FtcWdLRTRJd01ic08rQUN6Q0FqUHRJQVkxVEFYdi9vU2twNW9sZ3JHaE1H?=
 =?utf-8?B?TFJkZVhYRG9FTmdCWEhpK2JqMmoxckRyRFV5YTJ3YVpCK0lTQWJYTWQ5S3po?=
 =?utf-8?B?VDVRcUFtY1Izc0hCajA5S2FCTUxVVnBoYWpjQ3NYbnZ0Q3NkN1VtME8rQkkr?=
 =?utf-8?B?MEVueHNWa29qWityb2xKcjJRdUdaNzEwTEFsNytWRGRvajdhdFRMUHhoeWJY?=
 =?utf-8?B?akczcGxVTytJZ2QybWFpSWQ2VWI2bFU2dU0zeXpYYWptTnd0U3ZqR3AxaTNB?=
 =?utf-8?B?ZFNPSWhDRGZjZEd0QnVvazJkZDNFVmhGd1h6Q3JtR1NIVWtiL2JITlpZZVB3?=
 =?utf-8?B?N3l0U1p1Q1czbU5aYnppUmVRUjFqRzJrbXRGd090VXMxMlZYSjg5SEEyYzFM?=
 =?utf-8?B?UU13blhjbDE0Und4NWdJcmExRWlCNnZNMUFsL2FrT1dKMGVmZUN0L0d5alli?=
 =?utf-8?B?bzZYYVoxelJia2ttQnM5L2hQNmEzWldVZFFaSDlBczZpVXl2bWhWTXp4aHNG?=
 =?utf-8?B?Q29ibmp0NHdQTGxBelNvMWs1cSs2VmVFU2xSVDExUkp2RVBvTU9ONGRONHJP?=
 =?utf-8?B?UjAxTzZ6SHJOUjV5WGpsbHVmQURGS0lwZlh3aVQ0K2hudTJNeExCcWxUQnVP?=
 =?utf-8?B?TEREQW45M0gyWDBEV1hsZjYxZkJrVmlWR3F3MjN4OVgxSFdkdjc3emptejdp?=
 =?utf-8?B?aTJhR1Q4TjBWZ1lSL1dieGkwQ3piVXlpZVN2YzNzZkF3WGVUcHBqV0xpNHpo?=
 =?utf-8?B?RVpxR2V0WUM1RXdldjNiSWI5bmlUaXEzcHg5Q0pWV3pZdW83dE5EdkdCLzBt?=
 =?utf-8?B?MldjTkdEeWpHaVA0ZUtqZk1KUHJ5WWw5MXNHcjNwbTkrby9jWFduRlcwTnI3?=
 =?utf-8?B?YWRHLzFibEI5d0lyK3ZPSnMwK1FKUzZVYVVkdzBLRjZLY2xzZ3lWVE10TDJX?=
 =?utf-8?Q?TtyD+y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(42112799006)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGVTUm1nam1NNEdJcjZWWkhHN20reDdoRDhneUwvY1VhVTdYVVFKQ2NIQUJ2?=
 =?utf-8?B?eEdTOCtnekhKa2UzaHhwVXlta2k0VFo2Zzl2SW02cTdBaDB6K3AvR3pXY2JY?=
 =?utf-8?B?Uk9lSHVYeGVDMDVTZSsxK21UdjBORDVma3g2czREbGpCQzRWM1ZZWjVVMWww?=
 =?utf-8?B?UXJkeTZScVBqS2ROdTZrdGovTnp5ZlpYZVJ5UXhRM0RnWEttUVFNb3VRRFpu?=
 =?utf-8?B?QXc1ZWNoQS9mbmJYZ0E5WkkrU0lodFJOZ0pla3VGMStaSlA1azA2RC9KckZQ?=
 =?utf-8?B?VVN0VCs1K2JaUjNXWGNiS2FuUFE3NlVFbXNOR05PZmR0aWIyMnFJTE9teno5?=
 =?utf-8?B?NUpTWlNyQkU2ZXlQUlhLVWFwTlhJWmJQV3VVRlZzYjlZN2tBdjJsQ0ZNSWJO?=
 =?utf-8?B?MytuZkRXQjVIWnIzejhmQXRJZVROdjVTc0UzYUpkMG9jdW0vTzVpS2VPRDVM?=
 =?utf-8?B?a1h4bm5qMXVzMjVWcHl4K1l2LzBpTmp5VjNWaFZPRk9YMU95U1Z2azdpRXZt?=
 =?utf-8?B?Q25hdC9MVk44OWo1UkdRUkFia1JBNVNoVm9UY0Fua1hqdE53WXNiWkpmeFFT?=
 =?utf-8?B?WFY4VEpBKzJNUWZ1cFBLYzFFZHVxSzVaRlZpSHFhTDF2THFSUzJoV2toaGlw?=
 =?utf-8?B?N3NTZ2tGbXNJcWZXdzdxWWpraTFUZUtjMmFxMkZ3NDhTTzBBNmlLVGwzWFJO?=
 =?utf-8?B?Ty9QOGFPNXF5MGhFUndhdy9jUENSTzI1bTAwN0ZHOGZ3OGJNWU9Xd29QeVZi?=
 =?utf-8?B?WEJnR3NhbVM0Q0oycm8vNWN3QysxVDBHcVgwQmFBeDhlZDlkOFVFalBtbzA3?=
 =?utf-8?B?SWpjbkVXSStEa24yN3RaWDdmSkpVL1lXK1UxR2MvK3dYQ2lpeWhOWlpLb1Qv?=
 =?utf-8?B?dnRtTHBjN3pkYUJWck9OTEJSaHdJZVIwRGhNRlRCRFFqVHFCY0lrd2lwakk5?=
 =?utf-8?B?Z3o5Y2d1S1FUNlJNR3M1RHhLTVdWOTgvMm4yNzUrcmFXelRsMnlkdm5aVE84?=
 =?utf-8?B?b0EvVXFjM2NOSEpuTHExNzFGSDhnMGJiRW9NSm0ydW1sTHI3dVF1T2pRN0FZ?=
 =?utf-8?B?eTlEWjlsbFh3bGh3dmJnZDlxMjErK1RNNlkwY3diVklTWFQrZDl0VW1IS1FV?=
 =?utf-8?B?UUQyalJtQ1JuZGY3UVBkMFc1SGVOOUZ5bUlYV1NZdk9GMnJpSm96UnpNcjNn?=
 =?utf-8?B?YWpvbnIvUld4VTVSODd3WnRYRHJYZWxVcjBaZHdjZithMk1YNldIV3puT050?=
 =?utf-8?B?emF2NmowbWQzdkluQ2lqR1l0ME5lUzZwZWJ6TDJDL0xqdXMyK2N3V0FVQk12?=
 =?utf-8?B?N1RDOWc3WUlOK2xUVWRYS0RRWkdYV0piZ01vYnY2UjdXY01LcDBpbm5YdURs?=
 =?utf-8?B?b3pBUmYvUUdQdjEvVEtJeTNobnNBemFET3kxRy9jc2g2VVZUT0tJZ2kyQjJG?=
 =?utf-8?B?bWNCb2M0UWRwTEF5eVpHZWw3amtvUEN5ejAwMEZJWTgvU2xOMm1HN2ZMTldH?=
 =?utf-8?B?NUdzeW42QzVkcTV6NFRia1UzTmlicjU5dUdvaXdLanVEbjJ0cldCdjlndDIv?=
 =?utf-8?B?N0JOR2Irb2NHcVhNbXpmd2g4T0hwUExGdm5qdXpTb0NCcGVQTit3NkkybW91?=
 =?utf-8?B?WWd2bjdweEw4VE9XL0FWSFBOYjhjWlRaR3ZhNFQvMkNZY1ZEeGdDM1hUNmJO?=
 =?utf-8?B?WWtuQytEUFdhOGZYME5KN1hHVUo0Y29QZkc3RXAvSGtCSEJkeTEwa3RXd0Q2?=
 =?utf-8?B?M0p6Zy9hdFBleWVaRllxS0tDVlBvY1p5N1huaExFUS9WckM0bG1tb3piUHJ5?=
 =?utf-8?B?TXByZlh2Zkh5cEkzWktlMkUwd2dJQ2JRZmtKMjZySnFRanBDelpUVUdkN0Z2?=
 =?utf-8?B?cE0yb1pTazZjU0lxbGhmdFVVWHE4cFB1V1BnUHYxZ3FSM0ZVK3ZJaEZmRnpP?=
 =?utf-8?B?eng4Rzl6SkU1U08zRXIzZ0h1eHZDQ2hpdzQ3L01ZUFNHOTFRVzVGTTVpUElw?=
 =?utf-8?B?SkJHcmJIV2NlQ250NkpzVHBmc2pSYnJBa1FoNEpCSFpWZW5Ea0NNajI4RGd2?=
 =?utf-8?B?dEVBK09YeUgyTWE5M0tqY3JvMkUvblZxRjM1cmhrZ2d2L1lFWnIrZmRnRmox?=
 =?utf-8?Q?kLeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7639bb-523a-4fdd-775d-08de082b1b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 18:30:36.4987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axlnwCwGB3yRPBVAHTyYSi2/2lpO18ukVpeAayUCx1xrFBd7/mgFGWKRhAn+Nz0S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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
Cg0KUmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU2VudDogT2N0b2JlciAxMCwgMjAyNSAy
OjI0IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1LCBM
ZW8gPExlby5MaXVAYW1kLmNvbT47IFpoYW5nLCBKZXNzZShKaWUpDQo+IDxKZXNzZS5aaGFuZ0Bh
bWQuY29tPjsgU3VuZGFyYXJhanUsIFNhdGhpc2hrdW1hcg0KPiA8U2F0aGlzaGt1bWFyLlN1bmRh
cmFyYWp1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGJpdCBz
aGlmdCBsb2dpYw0KPg0KPiBCSVRfVUxMKG4pIHNldHMgbnRoIGJpdCwgcmVtb3ZlIGV4cGxpY2l0
IHNoaWZ0IGFuZCBzZXQgdGhlIHBvc2l0aW9uDQo+DQo+IEZpeGVzOiBlMzAzODNmY2U0Y2IgKCJk
cm0vYW1kZ3B1OiBmaXggc2hpZnQtb3V0LW9mLWJvdW5kcyBpbg0KPiBhbWRncHVfZGVidWdmc19q
cGVnX3NjaGVkX21hc2tfc2V0IikNCj4gU2lnbmVkLW9mZi1ieTogU2F0aGlzaGt1bWFyIFMgPHNh
dGhpc2hrdW1hci5zdW5kYXJhcmFqdUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfanBlZy5jDQo+IGluZGV4IGU3YjRiNzY4ZjdkMi4uOTE2Nzg2MjFmMWZmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gQEAgLTM3
MCw3ICszNzAsNyBAQCBzdGF0aWMgaW50DQo+IGFtZGdwdV9kZWJ1Z2ZzX2pwZWdfc2NoZWRfbWFz
a19zZXQodm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4gICAgICAgZm9yIChpID0gMDsgaSA8IGFkZXYt
PmpwZWcubnVtX2pwZWdfaW5zdDsgKytpKSB7DQo+ICAgICAgICAgICAgICAgZm9yIChqID0gMDsg
aiA8IGFkZXYtPmpwZWcubnVtX2pwZWdfcmluZ3M7ICsraikgew0KPiAgICAgICAgICAgICAgICAg
ICAgICAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3RbaV0ucmluZ19kZWNbal07DQo+IC0gICAgICAg
ICAgICAgICAgICAgICBpZiAodmFsICYgKEJJVF9VTEwoMSkgPDwgKChpICogYWRldi0NCj4gPmpw
ZWcubnVtX2pwZWdfcmluZ3MpICsgaikpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgaWYgKHZh
bCAmIChCSVRfVUxMKChpICogYWRldi0+anBlZy5udW1fanBlZ19yaW5ncykgKw0KPiBqKSkpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPnNjaGVkLnJlYWR5ID0gdHJ1ZTsN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsNCj4gLS0NCj4gMi40OC4xDQoNCg==
