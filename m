Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D3CA0FF2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 18:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3D910E6B3;
	Tue, 26 Aug 2025 18:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FxSdFuJa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFFB10E6B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 18:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVudzE9J5vmLh8uvFSt8UGcRtO4vJjT5+/MIJRIzkKG09aM9gFS3RsJIZiVFVwBbKWuSsmd7dcqs9euZuZu+mo+mNul3N2crnpLnVMEZbFmsgTVY45UR2w2KHfaa7mqB7hBkMyHLz6e29lHUP9NtmjVamBY3x2wLW8QkMGtvmUri6D9+LtbLh4WRtYJz5RdAzBTI7vrfFFQ5GaSM3fbSkTYxclqS5M/V2frOfXWDHqHu9UIrxiMEz4jS5JyxEmAbe2WIeJFmuMgm9ZvKu7DFRzNztnZXPnJGUlrEZd1VS7HvqR60+OvcfRQ/8gmLx6e/ojtaE/Vg3RApFBI41ykU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVB1mUWxstzopKARVDC6KsfrkxNA076SzvCbRkItebQ=;
 b=m3ooOCdEb14EnpVSwdxuduxf7Soeb/8aWCv4KOPkdXRB14ViQLJM4dA865eAEbHHejraRNKmWZaXCL17jQVcPeEYEP8Gpgj0/hHxXHMxxZrHw5ji4puuNWW8igg+LAbvK6zSMnrV21nwfyolEv+ElELlUHam+gZ2f2bwnUsXuUIQSRncYp+zPIKj4UhVjmb6f4KMqChtz6UkkRfPnpI4UHvWDzBcQDcVsxT92t82DYLl3L31JEm7fO8l+j2bvtunIMvALqYwm/0Hr7F9BF0n0jrVTDS1mvm36XeHCusQB/pg6Qmh8w5KdHKuu+FhPpScp0Mgc55u6Q8V3eOCOnr+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVB1mUWxstzopKARVDC6KsfrkxNA076SzvCbRkItebQ=;
 b=FxSdFuJa9/igtVLDyVrpqJu2D5oycMZrEsQwohUVR7s5WjxQkjJRV7GSsFvnMttVJVmJKMRkdYh1hNbwLptsVGKXY1i5yCMI5CmAGuhnZ6pITXwHNH5WH0o+8YGe5tsW7FADKFWLl+k8JHof46YPikHCQe1MkGDs24SCOXxiiK4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 18:13:24 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 18:13:24 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
Thread-Topic: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
Thread-Index: AQHcFk8aRbcbdUvoJ0q1sYT6ncoCIbR089UAgABJItA=
Date: Tue, 26 Aug 2025 18:13:24 +0000
Message-ID: <PH7PR12MB5997FCE0E22637F15A45A5818239A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
 <20250826060245.334880-2-kevinyang.wang@amd.com>
 <CADnq5_OT1dE1zUgjAuQijEOtWeOhvVOf3gDQ7Ys8qADN=dxsfA@mail.gmail.com>
In-Reply-To: <CADnq5_OT1dE1zUgjAuQijEOtWeOhvVOf3gDQ7Ys8qADN=dxsfA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-26T18:11:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV3PR12MB9330:EE_
x-ms-office365-filtering-correlation-id: e88dbb67-6781-43ab-a875-08dde4cc3f6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGxReVVIWUZrcWtTQWszOFFYaEMrVkN5cVlaZC9GSW12UmxDUUk2eE5oQWpx?=
 =?utf-8?B?MkM0aDFheFA3RmhuWlhpS2ZuUzVwLzBDUU1NeFhoOTErakgwdDRsV1ZkTTAy?=
 =?utf-8?B?NFRqbDVFSi9mdlArWDluQkozYzh6VWwvUGhSa1lsMkJDWUtoa3FjYytSVUJJ?=
 =?utf-8?B?QTNKMDl1dWRFY0Y0NDdQSUEvZmh6REtwK1dpTVNaZyt6U0V0cG1ySHo3VUJu?=
 =?utf-8?B?TGdLMXhJNGltUmJnWVF2cjZndTB4VUl5NERlZDh3bE5VSC9FL1lZWTN2UEx4?=
 =?utf-8?B?ZWhyNnpXMXJTT1VxUUtyWGI1NlhNWjJxWXJXVmNjM3MyT29OU21ibXdxaEFL?=
 =?utf-8?B?RVI1YmpjQzZad0dtSEVaOW0zRkFvdHlPY2VwakhxRXFjeWdxTkJmSGxCdit6?=
 =?utf-8?B?NUhjUGd0SFhOYWpWZTdSUkRCbG82anc2SUNUbTJqM1pFQmtNRnRQN2RZb2lL?=
 =?utf-8?B?MEpiYk5LQ0NGbmFZMGVuTWlMaVZsN1d5aXJRK0tscDBxTCtpZDFXWUl4ZXNM?=
 =?utf-8?B?V1VPbVE0QmpuZVFySjc2R3lhQWZobmhXbHovLzRxVmRWRThYTzFwRXAycHFR?=
 =?utf-8?B?eElQZzU0U3ZTS0pGSjV6ZmdCalR3RVNPKytqaTN6MXBJcWsrbEhYeWt2dlJH?=
 =?utf-8?B?eXJkMUJRYWNXKzhGMHE0UzN0cC9FcW0rVGhPVDVGVDRCU0FhbUZVbmtBVEhD?=
 =?utf-8?B?RGxQdFVxRDAzWGdxWXpwT2ZITkdaamRwSUJoYmlmc1ZSTEVKZW5pelQ2VnBr?=
 =?utf-8?B?cm9NWnZ6bW9YdzJhbTV1K00ydGNUeTlBc05NQitDek5OYVZQY1hXVy9GcE1u?=
 =?utf-8?B?bURSVnJOZWdaK1drajlSb0o4dmoyWTF3OXNHdkJTZE1lQ25Lem04YWxlbHUx?=
 =?utf-8?B?RFI2SVR1Y2ZCc1BDcm5XOGJWS2V6eXlLbGVWd1A2b0g5M2hpc1B5T0tjRElN?=
 =?utf-8?B?aVpGZUxnU2dzS1VFaUxvb2RhVDh1VDJGdnVTVnVWZzNlUERPUEt3OFJ3bW5H?=
 =?utf-8?B?dVdWdTdrYTVyWENKOTZXR25QTXpYbkNGNnRJTFc1Nm43Q0xkcWQwMjhUMWpB?=
 =?utf-8?B?eGNYU0pkQmVEcktyUElzeGZjWGYxQmRtRGVOaHlTV3hhRStoRTlZak5rK0RI?=
 =?utf-8?B?V1R3cDZYelZkNmhpT2l1eXZjMDdGRDd3L3p1Nkt6dVhrQW8vUEZBQzFUUDg2?=
 =?utf-8?B?a3ErMVFma3FZTldKM0hqc09BK1crTjhLYmJ2MC9DRU5mWGdxQXBOenVkT0t4?=
 =?utf-8?B?TEhRVEU2aVNiTjVZa21GeVhBdXdiK2ZnWE9NRUI1QUJkWXRBdkFnOU9mWHc3?=
 =?utf-8?B?MGtpcW1rc2hOUmtMZkdJL2QrRlNXeXVnVVJ2Tyt5RXlkY0NhMzJtbGFPZ2ZP?=
 =?utf-8?B?ZVhzdVBwanl2NGhaUnN4aXdhU3FYejd5dStNbE9WVzZyUUZFQkg0eXpTOTJk?=
 =?utf-8?B?dVBBTldhWno5bVBUNTc5OU91enBJZHdZNWNjT1p0dnlLUWNZV3Y3eVB1TzVw?=
 =?utf-8?B?UFNiNGJmSzFmbms0Z2JrdERaU3NDTnRNdU0zcjl2M2UyUWp1ZEVmQmpVZ3hj?=
 =?utf-8?B?bGZ0b3FQQlhCakRXQ2haUmt4Zjk0RzJENFE2Q2hPalNpSFdEKzRKNVpTN1Jp?=
 =?utf-8?B?ZFhaZXh3SWFMWDVRbUxMS0FLdFp4NkU5YVZkcXhXNUxLRm0wMzRTWFNWTDZo?=
 =?utf-8?B?dGtIOHI4S3gwZnZNdzZBTzdJR2N2YlQvUlJ4SE1HVlJKa2pDdklGSTdacXRj?=
 =?utf-8?B?ZDRLdnlSQXVEblp1aXRNNVZ4QVhEYUhFOHNpSkJKZXZWY0RYdWlidDdxeVU1?=
 =?utf-8?B?MXltNHFXY2theU5OWS9OaXNtajRjZ0JOVlBnR3dmOTQzbTJJRG1WK3hHVUZv?=
 =?utf-8?B?QmdEN3ZGNldUeERRdjZvUytyamQ5YkxQaitOTU9hY2lUNnVBUmFraUJrejRX?=
 =?utf-8?B?UzA5dldkWHJGVnhmUVBRejJ4d2tXdFdMTk02UVNOUHVjaWQzMEEwWjQwZTZz?=
 =?utf-8?B?dzNDZnZNQVZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZMRFR0d1JKTnZReGxhQzQ5OXdNaXZFVFN5bG5KQWhlNTlpTTR1UDdkamZE?=
 =?utf-8?B?UHNlczBLd0J4NUM0R3QzdjNiMmkxOENTSW9sSDhUMC9CUlMwNXVpb3lDdG0x?=
 =?utf-8?B?dkNaMWE0YkdkeTlvY2laa1QwR2ZPRDBnMDJqMDBJN04wcjlCUXYvd2p3cW1Z?=
 =?utf-8?B?bSs0bW1IRHF2UkxicGNQY01RNy81aVk5VXFDcWQ1TVh2SXZnZDk5dG12OVg0?=
 =?utf-8?B?MHlPSHFoRjMyaVFyMUI2OGN5RDNUSjJXMVVmWFh2Z00wOE5BTW41SlNuVFdi?=
 =?utf-8?B?K25uQ0pXMk9BMlRFSkIxTGc4VEVLQU8xUHh1Wk5ldm5OeStUWjkwR2c2Ylpw?=
 =?utf-8?B?NTVWUU5EbE9TMUpwbjZ5cDhTU2R6UTZHbjZhdUw4cWNVcDNrQmFoK3J0Y2ln?=
 =?utf-8?B?WFMvaW1UTG9ObnczV0QxeVRCWWJ5eklPZjYvUnlsT0NKMXJtaC9iQmRlS2tE?=
 =?utf-8?B?N1lvWmU1OXJZMHBnYWErdE5xOE5QUU9OanU2N1dtd01USXVob3pWdEphdWNa?=
 =?utf-8?B?RTJsR1FESXljb3ZOYnZEY2d2Y3pmVmluSU1ieUZsb2pZc1lyNWE3VnRQbkxD?=
 =?utf-8?B?bG9zWENUZVpkN1ZxZmxtaUhEK0h1TTNkcVZvVTgvMm9XVk5zZkE1NlBxU3RH?=
 =?utf-8?B?OVBhYmxLSnp4dFZ1ZUtubGVES2dIR2NoK1ZKKytWaHBRalhJTWMwYVE3Z1kx?=
 =?utf-8?B?Q2dvUW5SMC8wVnpqU3l5VnI3ZGZQUFpQYWRURkdzNWpLUkRzY3JOZVZPY0sv?=
 =?utf-8?B?aVgzVGRRSk5pZTk2NFJzS0hHU3ord0ZCRkpwOGlZbDVHZkgzU0V3WUdBeWYx?=
 =?utf-8?B?eGJHWHZMNzdSeGhkNW4zbG1SU2o0WTVySjI4UmV6Tmp5Q3dUeDVKT2laakk5?=
 =?utf-8?B?S1BUZGoxNlNOcWs3Y0kwMzc3ZlJtWCtkdkJyMkFEQ2lCYW54TWtLYzhxM0dw?=
 =?utf-8?B?VXQ0VnM0eGJlNEcvemtCQnRKblBBKzQ2M2pyVXN4WGNDSDRpVlBQN2V5VERP?=
 =?utf-8?B?d3lHeTkvcGN3U0pTZW9GalduSzJ3MzVPb08vZUhlZkZ5M3hiSDR4dmEvRElD?=
 =?utf-8?B?cGF4RkN2UVJzTzJPWGg1cERiREJjajBUaXUyUFVlRW8xcGtZVk05Mmd6RXdk?=
 =?utf-8?B?c0NQM0pWby83OTYzUjZOZDduV2V6ZzNPa2h0aWprNEFTa3BWalp3NVZqdThk?=
 =?utf-8?B?WHpDSXdZcEpwMCt6dmVNeGg2cWgyVEYwYmFNb0R4ajFHNjhlem9sSHhOaWdF?=
 =?utf-8?B?N0s2SnJRUzBIUnZvYm1NYXpHcUlQZmpKRk1icTErd2hYanNsc0JwaXdsbU1u?=
 =?utf-8?B?Sk9CUTdGL2o4ZzRyM3FDdWQ5c3dsWmxZcUpPYlE0YUFweUJlUmVMaFQzYmsv?=
 =?utf-8?B?OW1YT0tuRDdNL1YrL1lKNDhIclNlaitrbGdTNHhZcVUzK1RlbWcyYzBjWXpt?=
 =?utf-8?B?bTFSOHQ1TDhicUpDVG0xWU9lVEl0OUpoandvVzBPY1JQK0wrY2l1aUJLU0Jo?=
 =?utf-8?B?a3NCT2NSSVpOdVZIeXB2ZEJyZk9ISjBRd05vTWtIcGdzbHRmVFFuVWU1cGZN?=
 =?utf-8?B?KzdxY1dBUTV2YkIvNU5HYkhHVUNCK0owZXFiaXRZOWVOQlh1K2ZFaTNsNlhR?=
 =?utf-8?B?dTBGcGRCdWlGTTQwQkhDdVhXak1uRElFQ1RkZEdVamtZVjNsSWZDd2dFVUh0?=
 =?utf-8?B?KzFFcm5aL2pjZjhJVUpRbkVUVk93SGkyTXEvK0dyKzBKajhUdkZPcVZScmZI?=
 =?utf-8?B?dkQ4T3lPdEMwVHZBRGQ3QnIyYkhqY25jb3poaWo3SW85MUVxWXNQcUlOSkd2?=
 =?utf-8?B?cmF0VlppcTRaZTM4MnFUbkRWa2tGRjBtU3FOSkpSQkNpRjRsVXFzM0p6Z3pp?=
 =?utf-8?B?QXdERjR5TVkvejNIWURQTjRxdGdlSUdFenREc21sZ0FQRUF1QnZIYlh5ZE5G?=
 =?utf-8?B?SHU4QVVCV2F6N3Q4WE9RdThUd1l4Rll1dG5vTUhscGphOXlYTnozd3Q0S1l0?=
 =?utf-8?B?eXB6VG4xdFZjMnNrOHJzWjNwZXJ3VUtvbGY2SmkvV0JFV1VtWlJUZXFETHp4?=
 =?utf-8?B?U3lnQU9sMVNEa2JsMk9wYzg1R2gvemtXMXZqcWZ2cW0zTFptY04vK3pJVnJp?=
 =?utf-8?Q?fHmg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88dbb67-6781-43ab-a875-08dde4cc3f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 18:13:24.4619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deihtZ1TLDTjAcS+PFVA5RYkxluspF80HJMYAgppT2RW/hJc658KOTzQnwuSCrx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogVHVlc2RheSwgQXVndXN0IDI2LCAyMDI1IDk6NDkgUE0N
ClRvOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2FtYWwsIEFzYWQgPEFzYWQuS2FtYWxAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiB1bmlmaWVkIGFtZGdwdSBp
cCBibG9jayBuYW1lDQoNCk9uIFR1ZSwgQXVnIDI2LCAyMDI1IGF0IDI6MDPigK9BTSBZYW5nIFdh
bmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiAxLiBVbmlmaWVkIGFtZGdw
dSBpcCBibG9jayBuYW1lIHByaW50IHdpdGggZm9ybWF0DQo+ICAgIHtpcF90eXBlfV92e21ham9y
fV97bWlub3J9X3tyZXZ9DQo+DQo+IDIuIEF2b2lkIElQIGJsb2NrIG5hbWUgY29uZmxpY3RzIGZv
ciBTTVUvUFNQIGlwIGJsb2NrDQoNCldoYXQgaXMgdGhlIGNvbmZsaWN0Pw0KDQpLZXZpbjogYWxs
IFNNVS9QU1AgSVAgYmxvY2tzIHNoYXJlIHRoZSBzYW1lIG5hbWUgInNtdSIvInBzcCIgLCBhbmQg
dGhlcmUgaXMgbm8gSVAgdmVyc2lvbiBpbmZvcm1hdGlvbiBoZXJlLg0KDQpCZXN0IFJlZ2FyZHMs
DQpLZXZpbg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdA
YW1kLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAz
NQ0KPiArKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBlMTE3NDk0ZTgwNTQuLjU3NTRiMWZlNzdiZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBA
QCAtMjQ0Nyw2ICsyNDQ3LDMzIEBAIGludCBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX3ZlcnNpb25f
Y21wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICAgIHJldHVybiAxOw0KPiAg
fQ0KPg0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmlwX2Jsb2NrX25hbWVzW10gPSB7DQo+ICsgICAg
ICAgW0FNRF9JUF9CTE9DS19UWVBFX0NPTU1PTl0gPSAgImNvbW1vbiIsDQo+ICsgICAgICAgW0FN
RF9JUF9CTE9DS19UWVBFX0dNQ10gPSAiZ21jIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZ
UEVfSUhdID0gImloIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZUEVfU01DXSA9ICJzbXUi
LA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9QU1BdID0gInBzcCIsDQo+ICsgICAgICAg
W0FNRF9JUF9CTE9DS19UWVBFX0RDRV0gPSAiZGNlIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NL
X1RZUEVfR0ZYXSA9ICJnZngiLA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9TRE1BXSA9
ICJzZG1hIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZUEVfVVZEXSA9ICJ1dmQiLA0KPiAr
ICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9WQ0VdID0gInZjZSIsDQo+ICsgICAgICAgW0FNRF9J
UF9CTE9DS19UWVBFX0FDUF0gPSAiYWNwIiwNCj4gKyAgICAgICBbQU1EX0lQX0JMT0NLX1RZUEVf
VkNOXSA9ICJ2Y24iLA0KPiArICAgICAgIFtBTURfSVBfQkxPQ0tfVFlQRV9NRVNdID0gIm1lcyIs
DQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19UWVBFX0pQRUddID0gImpwZWciLA0KPiArICAgICAg
IFtBTURfSVBfQkxPQ0tfVFlQRV9WUEVdID0gInZwZSIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9D
S19UWVBFX1VNU0NIX01NXSA9ICJ1bXNjaF9tbSIsDQo+ICsgICAgICAgW0FNRF9JUF9CTE9DS19U
WVBFX0lTUF0gPSAiaXNwIiwgfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmlwX2Jsb2Nr
X25hbWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGVudW0NCj4gK2FtZF9pcF9ibG9ja190
eXBlIHR5cGUpIHsNCj4gKyAgICAgICBpbnQgaWR4ID0gKGludCl0eXBlOw0KPiArDQo+ICsgICAg
ICAgcmV0dXJuIGlkeCA8IEFSUkFZX1NJWkUoaXBfYmxvY2tfbmFtZXMpID8gaXBfYmxvY2tfbmFt
ZXNbaWR4XQ0KPiArOiAidW5rbm93biI7IH0NCj4gKw0KPiAgLyoqDQo+ICAgKiBhbWRncHVfZGV2
aWNlX2lwX2Jsb2NrX2FkZA0KPiAgICoNCj4gQEAgLTI0NzUsOCArMjUwMiwxMiBAQCBpbnQgYW1k
Z3B1X2RldmljZV9pcF9ibG9ja19hZGQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgZGV2X2luZm8o
YWRldi0+ZGV2LCAiZGV0ZWN0ZWQgaXAgYmxvY2sgbnVtYmVyICVkIDwlcz5cbiIsDQo+IC0gICAg
ICAgICAgICAgICAgYWRldi0+bnVtX2lwX2Jsb2NrcywgaXBfYmxvY2tfdmVyc2lvbi0+ZnVuY3Mt
Pm5hbWUpOw0KDQpDYW4gd2Uga2VlcCBpcF9ibG9ja192ZXJzaW9uLT5mdW5jcy0+bmFtZT8gIFRo
ZXJlIGlzIHVzZWZ1bCBpbmZvcm1hdGlvbiBlbmNvZGVkIGluIHRoYXQuICBFLmcuIGRtIHZzIGRj
ZV92Nl8wIGRlcGVuZGluZyBvbiB3aGV0aGVyIERDIGlzIGVuYWJsZWQgb3Igbm90IG9yIHBvd2Vy
cGxheSB2cyBzd3NtdSBmb3IgU01VLg0KDQpBbGV4DQoNCj4gKyAgICAgICBkZXZfaW5mbyhhZGV2
LT5kZXYsICJkZXRlY3RlZCBpcCBibG9jayBudW1iZXIgJWQgPCVzX3YlZF8lZF8lZD5cbiIsDQo+
ICsgICAgICAgICAgICAgICAgYWRldi0+bnVtX2lwX2Jsb2NrcywNCj4gKyAgICAgICAgICAgICAg
ICBpcF9ibG9ja19uYW1lKGFkZXYsIGlwX2Jsb2NrX3ZlcnNpb24tPnR5cGUpLA0KPiArICAgICAg
ICAgICAgICAgIGlwX2Jsb2NrX3ZlcnNpb24tPm1ham9yLA0KPiArICAgICAgICAgICAgICAgIGlw
X2Jsb2NrX3ZlcnNpb24tPm1pbm9yLA0KPiArICAgICAgICAgICAgICAgIGlwX2Jsb2NrX3ZlcnNp
b24tPnJldik7DQo+DQo+ICAgICAgICAgYWRldi0+aXBfYmxvY2tzW2FkZXYtPm51bV9pcF9ibG9j
a3NdLmFkZXYgPSBhZGV2Ow0KPg0KPiAtLQ0KPiAyLjM0LjENCj4NCg==
