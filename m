Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1125CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8549389BEC;
	Fri,  3 Oct 2025 20:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKnzrrbj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF4889BEC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM0nh9WgbLoLrQ40rnc3wwnT2eJ9TiolIC2glMMdPUCcjunhxJxIQ1lFU8Lkr7hXzMQ+c9rrzS2xos7E5aUmFMyeRivPFIGarbxRZnVLadcIu/QmfQHSAW0mK8esKVdIcFU4GAX4bzVBwt18ijfUrJvRnuXXTTE9TC6uVI1fIjxHfYmzReJkCWm6ij5YEkg4Q48/ewIGJrhKWqw0w9BZRLCad4bR5mGdfAHQaAqNGepOyqbJqTclYqWdkJhJ75AP1R0SbI5Hk6rpRvZpJAqujh172gyWrw1Doz97aGb/uLwMxiND59E4idmJU9szBH8ZHWk1Ks95pehduGk71Ogflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tStWzRsTOJy2weah0jmI5RqSlwII3ZkN+cyhicWV/mA=;
 b=FN1HL6WqkGHY1sJJRcAXTtTDQ22LHexCgpxuuGa3ChwX+xHRINo/Z/11bLnkidUHdv79G44LmSwPw1vQS/B63bWhyWS0F9SoNvyNKQlocBsaqwq3L8d3rflSzKOjINtXOOk2Er0cUb+T8inO84eBzqH7pIz1sJo3CbRjNa9UtlxK0+JxswqeSuFQvQj5jZS0zd+zPfG1sNcL6nIDXpHhU81CRFrONTCu1iCCvQNJiMZurESGccM/+TDpALAYIB+RGp8TmiQ2sZxr+wpNH9/LkvzATnNSJoQySzlyFdX22ERfDJappVrtE7TLg78PsxfV/hEIHo9svha7Lo1xdyfvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tStWzRsTOJy2weah0jmI5RqSlwII3ZkN+cyhicWV/mA=;
 b=nKnzrrbjrQJtRU4I7NG2+M6S8aIt4QJTEhS1fQVeGj8Zl3Z0LqNNq1yNFH51+UWQfnlqWW5+O52yvXIA+agq5/qyewWsq2KCG0f/Xw4TRo5TZbtJB9/ZIIqf9mRHqH1xu+0/IUNLhl8C3e2YcGUt9bFtkLS+8ivTsGY/QyES72Y=
Received: from DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) by
 CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Fri, 3 Oct 2025 20:20:36 +0000
Received: from DM3PR12MB9288.namprd12.prod.outlook.com
 ([fe80::506c:8361:ec1d:ab80]) by DM3PR12MB9288.namprd12.prod.outlook.com
 ([fe80::506c:8361:ec1d:ab80%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 20:20:36 +0000
From: "Liu, Robert" <Robert.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix two comments in kfd_ioctl.h
Thread-Topic: [PATCH] drm/amdkfd: Fix two comments in kfd_ioctl.h
Thread-Index: AQHcNKGiZp2YjAJR5EqDottpp3jVxbSw2kiAgAACl6A=
Date: Fri, 3 Oct 2025 20:20:36 +0000
Message-ID: <DM3PR12MB9288BAB96E1277FCA5662F489FE4A@DM3PR12MB9288.namprd12.prod.outlook.com>
References: <20251003200906.2204636-1-felix.kuehling@amd.com>
 <CADnq5_PG5sFL=iJhPAcn_b=a8NyGynzH8h8_OdnicyJEk--3vA@mail.gmail.com>
In-Reply-To: <CADnq5_PG5sFL=iJhPAcn_b=a8NyGynzH8h8_OdnicyJEk--3vA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-03T20:19:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR12MB9288:EE_|CH2PR12MB4166:EE_
x-ms-office365-filtering-correlation-id: 05d8f2be-afa3-44d3-58c3-08de02ba5016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zmh5eW8zNzZtYlFGK2RzZDgxenJuYkYyRWkzRkZGV1JpNU00S01La3JnNU52?=
 =?utf-8?B?aEpUMm9QdzIzRkhwa3NQbWVKaU1GWFh2Rk5tcndEUWx2bHdZNmtrN3RkUlZj?=
 =?utf-8?B?ZkRFWUU0Qm1ra0tjalIwTFJRRE80aEE4dURUQU8wNXpucGkvVFFZVjJPeGZs?=
 =?utf-8?B?ZGZpSmdlTStRS05YdEl3NnVrNTZCME9CMWcwZURDOHM0aWdxNWg0ZkJJbzRV?=
 =?utf-8?B?TlFySGNHVWJhYzhzaVNCaDEwUkJPbDdBc3dLT3AvcVlrdUhUYlRZWTdMdlRC?=
 =?utf-8?B?VE1DTlFpdGhtL2RMWWVjOUZ0NlVmcmNOMnJmSmREM05JTGpXZSs5U3MrbjZp?=
 =?utf-8?B?N25pYUVjYmNYQ3JmcXJHSEJaQmRIbU1sY3RKaTF3bUwrV3RVOU1wQitUN3l1?=
 =?utf-8?B?NGJuYlZhYnRxeUFsN1ZIVVBZWHJzS0J0V2J0V2xMQnhuemdObGdoR0R1VlJX?=
 =?utf-8?B?Q011WlBPMDdUN0V5RUZSQjNGYnJYcit3LzdHT21vM29DcFFucTJPTkVPYVBF?=
 =?utf-8?B?dmdxRkNjQkVzeHdqZytmdkhsT0FEOWFrZnlHbm1QYjNJYW55NVlMYkUwNUJW?=
 =?utf-8?B?MlE3UlZkLzZvSm9ZcEw1WlkvQmFtYnBPZFY4TkNBV3BiY1d4dFNPZEJkejBI?=
 =?utf-8?B?OGVhV05RWS80c3RkRmJ0RVFDVWdGMnM0UGlmVjhXVXdYQVpVM1E3SVZxYnRO?=
 =?utf-8?B?dFJFNGkxTzZVZmQxdXdMTU1WcS9vSTdxQStqbEZmODJwL1FMblBVZW1OZEJZ?=
 =?utf-8?B?MmZyMjA4T1JRVitTcUdhVlNNUVYxMVdxeVNiMkhTQXRiNzVvOUFGVFM3SmxK?=
 =?utf-8?B?cC9EWDR3bXp0TitJeTFHYllUN1pNMEpJaFlXRXZQWHhMTFdnNmFibzROTVV4?=
 =?utf-8?B?bFJxaC91SU9XWXpRanRCdStucjFCclVhZkU5VytTdTRaVitvY0gycS9BN1Qw?=
 =?utf-8?B?Y01PZENJZmUyR01NYlhNS0ViWnpGN0Q0T084eVRUejlGMmRXeklQQ2NRSmlL?=
 =?utf-8?B?eEhXSUMzaHZCamd1RVFaNkdyQlhaTGZzZWtZd0o1Zm5LN0s4MC9CRlVRNHZ3?=
 =?utf-8?B?OXRzWXNNaDJvYy85cGpWc1QvMjdNTm1zL2ZxdTRsOTByaXBtMzB3bHV1WGZo?=
 =?utf-8?B?dmtFWDFjWTJQKzlpVFlvTm41ZzJpN1dON2Jpc2lQRjRBR3ZIUEFCSmk2dTFK?=
 =?utf-8?B?RmE3UjBYVDJDMXhsVTh5cGRWZE5CaUl3d29DbWNTYnVlb09vSGw2Q3RXQWky?=
 =?utf-8?B?RWRPc0xBamJuQ0o0dDJ2TXJXVmEyQjYwL3lCQUc5NDRoK0U1dm9qWXlpUkJW?=
 =?utf-8?B?SndKQXpkbk02L0Yxd3hPQWo0aHF0SGxJOEVsQThHQTRnMXEwczdyWG1KbzJ1?=
 =?utf-8?B?VmVyYnVlNnBFNitWenZTS3dlN2ovd1lCV1lkWXRlTGVOcFRyeTJUaUJDZFBo?=
 =?utf-8?B?S2psR2picVdBeU5NeG5XTWNYbGlYRHQ0cXpaNjVTU0FLYkFOcDU5Q3lPYVJl?=
 =?utf-8?B?WGtseStidzdXY1kwMmNlcWprbmpzWCtLTU51MytpQzZkSTl5MVRqNlZVcmRW?=
 =?utf-8?B?NTB1UWpObDdUQitDdDJYY3N6cFVVK21oSlhheHV5RVJReTY3dXFnekpJdWpY?=
 =?utf-8?B?SHFiUEc2T0RudGRGYnphaXF0SnJCcURUb1lObXdlQjFQN0VwTWYzVlZtZloy?=
 =?utf-8?B?eFRDOFA4bGhPSkQra0pjRS84dVYzUmFvMURHemhwemVkTGI0SnBjM29lUG05?=
 =?utf-8?B?SlZFUDg0Y213aHRET1BvVlBiUDFWZW5yN0VjQUdqWnZGbEowT1VxbUljVkhW?=
 =?utf-8?B?NlRkZ0xMa2pOVDl6OVZPVk1oaVBhaHhuc0RTYzlad1VSTnd5Nm1iNlhlY2ky?=
 =?utf-8?B?d3ZQVFk2V2hnRWQ5SXl5dVRSaTZScHlGT1pNbENpZmZSQnVjQ3BUWDZuTE1l?=
 =?utf-8?B?RzhtWVVoMGd3Uld2V1RWVTBmRjlZUTM5NDRHSHZLaFdlRmVoRGFUVktqMVd5?=
 =?utf-8?B?cmRvZUFuWFBSM0ZCY21wRFhGRjFUZUJPTFhaZHE1NjZBMHVYeEVnbzZIbXdF?=
 =?utf-8?Q?jGt+VI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9288.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ems3WGVkQ1R5RlArenhiWkdsSHI5R0ZqQXRrdVdpWlhaQVhLYjh3VjRiU1ZX?=
 =?utf-8?B?d1IwVllpWDFTTzB2UnQrbkdINnV3M0U2Uk9uVXAxOG80aG5HSXcwSDlaVFVM?=
 =?utf-8?B?NXdBeXRFWDlDWDVlOVlzd1FVT0NwNmxiVkZwS2dxQjJQRW1tckJhMW1BSFEw?=
 =?utf-8?B?NWNKYlU0OVl3YS9ybWpQdjZ1bVlZY0lFL3p6VVcxNDRPSW5SM3VFbFdEeFFI?=
 =?utf-8?B?bmV1ZVZWSlJkUnl2ZmtscEtDSHYxNFpYNm4zWXZkZVQ3eGttT0hMWFl2dCt6?=
 =?utf-8?B?U2xBZWxLOFFBR3I4azdySGswVVhzQmMzbllCSldVUVV3Y2ZyeGRUSFYzNGtx?=
 =?utf-8?B?RWJDemFrbWpKNFVQa1JzVXNnQ0lTS3VXZ2dtRzFxdVZqN1NGUEJacE1TVjJH?=
 =?utf-8?B?MUVYWTJDWjBLaDF0Q1p2WlEwNm13NjJrb1hpSHUvcmhSVThNVUZ6c1dqMDBF?=
 =?utf-8?B?NDdYb1FBWEVzZUJLaWV1TGNiN2FGbHFjRDRXK2RramVuMXcrVlVYZ3VSV3NH?=
 =?utf-8?B?ajZlWDVaaVVKbDJleDJMSG8ra2RwWVg5SFNubG8xOGR2Yi9GS1dVRDU2Ylkr?=
 =?utf-8?B?TjRtTjBFRmpRcUFtMDkrSVZ0VHZqbzhkQkhjVWtXV3ViQWUwV3ZaQ1VDTFFs?=
 =?utf-8?B?Q2pjSHJ0V0hHSG9WNGJvZmVvNEtpa204bDM3Q2NsVVRvWnBvTFJoNGprK2Vh?=
 =?utf-8?B?cVBhdklTRGZtTUN0d3FNL0ZtZ3FJUklhQjRJOFlDaUVoSi9QazN3UDNWV25S?=
 =?utf-8?B?OTJQR1ZJK09jQm4xejYxWjN4M2RqWnd0dGhDYTN6QllTNVdITlh2N3NUQlpT?=
 =?utf-8?B?T3ZJVTdrVXQzTlI0Rmk1VVZPdXpKQVNWUEJQRCtrSnFTWitVM0U0b0RWSzNF?=
 =?utf-8?B?QnlieWlMbXJCZUxxYjJTOEQ1YlgwYkVOTkMxWHZrbm40WnJ5YUVoUDY4T0Jq?=
 =?utf-8?B?QjFtKzQ1dEo0VEFNSHpmOWJwYTVaZndZaWhZQXlFUmFsUXdvQTBHZjliVHhS?=
 =?utf-8?B?NGZ1elZRZXpZQXhXMmFuRXl4MDRZeEtYRWhZR2x0ZnVrNmJsWUVPRmtwMENr?=
 =?utf-8?B?RU5IbTNaaThFZHZnOVB0cFFPZDRUdlhnS0JNUllpbkEzRU0yOElPcTFidEI4?=
 =?utf-8?B?T0wyb29nVjMwUklNenIzUldrbWszT1NPT1NCczBkaEJkQjVaT0Vsc1pXbUhi?=
 =?utf-8?B?WjNYY25PTERwazZiWjM3S29BT3RhQVE2MUpDUzIrWFIweXZkZ1c2ZUt4MlFz?=
 =?utf-8?B?cy8zM3JrdzlPWG9YalBUT2p0aHNJMDJsZml1cFZRZWJMTmpkaDhXelJpNkNX?=
 =?utf-8?B?WkdMSjlnSmlHSkNwOUs3SENsZXRDYXVaSGFvQlIyQm9aMDZHMC95d3J3OVN5?=
 =?utf-8?B?NkRlVUR6UDhBcXVlekdFVCtpMFdlSlRNVG9UZVhYZzlOOHZSV2NueHV0cmtn?=
 =?utf-8?B?YWwwdUtHVURMSExiV05IeEtaTmVFRFBKN3lxWFdENUt1endycXQyM3drbW9G?=
 =?utf-8?B?ZFJTZUdLZjkzeTlGc2p2N0VHTnQvaU9CWUovNDNTNTZ6YUxUbGw5ZVQrVkVB?=
 =?utf-8?B?MWRoaCt5b1NhMG9TekdNUE5tekFZamtKVzF6dGpuWXJjOGc4ZGJ0dW85NWxa?=
 =?utf-8?B?Zml0YWkyY2dwci9aSG9zdmwxbEFQK0d0d3BkQUpCeFhCcUtCTnh2WWdvQ1Uz?=
 =?utf-8?B?WEQwN2pMQTVlMU9YY011ekcwZHk2VXVud1c0VFpJNk5mQWF1U25VbTRFU3Jy?=
 =?utf-8?B?MFlJQXFXVTZJM1dwZGppNG9DM3E2OXA4d2srQUdLMnV5RmNYT0NoelNVaVAv?=
 =?utf-8?B?QzVEMmcySDRwL0NPYVc3eU4yVWpNNnpSbjEzbkVwSSt1R3VBc2pvei9yMzI5?=
 =?utf-8?B?SmpjQ0p0K0VpOTVnbDRMZmJoZmlETkNldXhyRHhvVFhJOFY3dVd1TTdaRk9V?=
 =?utf-8?B?V2pnOWg5VUdZOXcwZmpSTmY2WDFqWnhOS1NlTDdleGMxazk1dkJXcm5rNmov?=
 =?utf-8?B?ZVRzcnNucXdSenJZWEJkNlFJZ1NsYzU5a3hpY2pjNEwyU1lLUDVHZjB0RmRF?=
 =?utf-8?B?YzQzRkFCbGpGajQzMmo3QUtobkc5a0VPSGdhR0E2OEFiL281cnN2Vml6dzFW?=
 =?utf-8?Q?u41Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d8f2be-afa3-44d3-58c3-08de02ba5016
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 20:20:36.3487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMX8ck2k8zq88krTBTPnIEWfix58f5tRZNTAsHzGr3NeX/LYNM5dfWLkseXsSDnJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cg0KTG9va3MgZ29vZCB0byBtZS4gVGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5
OiBSb2JlcnQgTGl1IDxyb2JlcnQubGl1QGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6
IEZyaWRheSwgT2N0b2JlciAzLCAyMDI1IDQ6MTEgUE0NClRvOiBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IExpdSwgUm9iZXJ0IDxSb2JlcnQuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1ka2ZkOiBGaXggdHdvIGNvbW1lbnRzIGluIGtmZF9pb2N0bC5oDQoNCkNhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVz
cG9uZGluZy4NCg0KDQpPbiBGcmksIE9jdCAzLCAyMDI1IGF0IDQ6MDnigK9QTSBGZWxpeCBLdWVo
bGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFF1ZXVlIHJlYWQgYW5k
IHdyaXRlIHBvaW50ZXJzIGFyZSAidG8gS0ZEIiwgbm90ICJmcm9tIEtGRCIuDQo+DQo+IFN1Z2dl
c3RlZC1ieTogUm9iZXJ0IExpdSA8Um9iZXJ0LkxpdUBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGlu
Y2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaCB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaA0KPiBiL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9j
dGwuaCBpbmRleCAwNGM3ZDI4M2RjN2Q3Li41ZDE3MjdhNmQwNDA1DQo+IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgNCj4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2tmZF9pb2N0bC5oDQo+IEBAIC02Nyw4ICs2Nyw4IEBAIHN0cnVjdCBrZmRfaW9jdGxfZ2V0
X3ZlcnNpb25fYXJncyB7DQo+DQo+ICBzdHJ1Y3Qga2ZkX2lvY3RsX2NyZWF0ZV9xdWV1ZV9hcmdz
IHsNCj4gICAgICAgICBfX3U2NCByaW5nX2Jhc2VfYWRkcmVzczsgICAgICAgIC8qIHRvIEtGRCAq
Lw0KPiAtICAgICAgIF9fdTY0IHdyaXRlX3BvaW50ZXJfYWRkcmVzczsgICAgLyogZnJvbSBLRkQg
Ki8NCj4gLSAgICAgICBfX3U2NCByZWFkX3BvaW50ZXJfYWRkcmVzczsgICAgIC8qIGZyb20gS0ZE
ICovDQo+ICsgICAgICAgX191NjQgd3JpdGVfcG9pbnRlcl9hZGRyZXNzOyAgICAvKiB0byBLRkQg
Ki8NCj4gKyAgICAgICBfX3U2NCByZWFkX3BvaW50ZXJfYWRkcmVzczsgICAgIC8qIHRvIEtGRCAq
Lw0KPiAgICAgICAgIF9fdTY0IGRvb3JiZWxsX29mZnNldDsgIC8qIGZyb20gS0ZEICovDQo+DQo+
ICAgICAgICAgX191MzIgcmluZ19zaXplOyAgICAgICAgICAgICAgICAvKiB0byBLRkQgKi8NCj4g
LS0NCj4gMi4zNC4xDQo+DQo=
