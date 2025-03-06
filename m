Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7533C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 02:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ED910E00F;
	Thu,  6 Mar 2025 02:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAQNsPCR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132BE10E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 02:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV80LlOGMIwbzqHSh2vcXwAyFVR26KIZtSMeCAgaSRBa1fucGwd77hdn3TmRhZvgqxt0qR5a9DOHtjOHUwjvsz7SHvF1rXETuEB/K34pUYgE/hSKrFlitEMpgqmkvS9TQU7vqA8/EtV6hKf0O27NpGPiUL5QvyKsDYnwjbFP4wCzRwNSUuAnh5zqiump4RG6//e0Hauu3hd0SE2NO5IFIgrnXq2TUKFQNvaGQXn8cja2UilsrlHpTrbkvp0lnch82G9xoaVey/+LJZmSs5tMquPw5FuhJTE2X2+RqEG7g50hvuWUviZSlfmsZAbCUichLy7p4PbmGAlJBoHGDWY24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y8UT1OIqkJ8WMaTRcfWfkssw6f3XrxsPkX0PP6GZOI=;
 b=VP6UsLBDAjoKmiLZlgwZIhwJmbc84uK28wkx9q3jKpySu+XcsO4YOWBKkWV4WMuu6raF09lrUFWqwIDrSXrZHz5TtJtDIHiV8cuBK+6gEzsTMy8no4C8AFwzcR6k6tAsZzMSan8eYo+H2J3zOOB5tBHUljEFXsK0e28A/pmfnvvqtQ5HeUegZhN1e7yt/h3uHk/lKyJBmhxj4X81ixo4npZ2jpPQgqI0YcNq4vk0msRy6ywPhMy6zj+/vZbx3R2FtyntmsGkAN6IEIvPk5AAzYCI0IIM+o0n2h5HNsivVEBzls6yfYWzZOyCFUZeW18T2VbMw3n90x0IpIT0GhhFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y8UT1OIqkJ8WMaTRcfWfkssw6f3XrxsPkX0PP6GZOI=;
 b=EAQNsPCRWEvCgTPIJh+CKctCAG/+IJLqgi4UuZbNg3LeG5CvknzHGJ55QDQz0C6b0knLFbSLcsvpUHO0+8faVvemozXCxyB9ZU0q1PchtGMbEOfZJfIUlondDuK3WUArPgTB6Shm7UCZTKI7xQAnf2xAszoVBVmcmgUdqpqSusg=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 02:27:56 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:27:56 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Topic: [PATCH v2] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Index: AQHbjjSN4V/uEv2bgkG6uYMNRwSb8bNlUKsAgAARijA=
Date: Thu, 6 Mar 2025 02:27:56 +0000
Message-ID: <PH0PR12MB541728E70DC875F9B57619708FCA2@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250306011023.3220173-1-Emily.Deng@amd.com>
 <6e6192a0-5772-4aae-b22f-5a34b07809b9@amd.com>
In-Reply-To: <6e6192a0-5772-4aae-b22f-5a34b07809b9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f71af820-017e-4c3c-b41e-dc02ee22f243;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T02:27:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB7447:EE_
x-ms-office365-filtering-correlation-id: 30b9c336-6b8f-471b-9a50-08dd5c568198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Tm5WOWQ4NTlabjVURXhuK1l5K2JSOFdSM1VYMDBIWnVSb1ZjMi9nd3l1NnhB?=
 =?utf-8?B?akVxVVFreTdjYkx4ZjdIQ3VGK0lqVk9peVNoMWE2b2l2cjFjalZNQlhHa1pB?=
 =?utf-8?B?NCt3M0JkaHE2SU9YZExiL3VWZkhjNVh2VlE1OUxldnVQUzRmMkxaRzZTRGNj?=
 =?utf-8?B?SWpRNkNkZnJsK3A2eEtRSHhQeFlvd0syaUVtaGVxMWNnTmdhNGlWOHNKdXBB?=
 =?utf-8?B?Q1hYZGV3ci9TMHdsa1YvRVR6WFZLcUEwVkJsOXlxU2hIR3pWZmZEVFZtVXlD?=
 =?utf-8?B?amZMSkpnUS80Nk9ibU5WU3psYzFQUnZCQXdhM2xqZUNwWE9OekMxUnBOUHNL?=
 =?utf-8?B?Y0VhbHBZUlBTWnNpQXlDQmZOTW9UQzlodUZOTjVOUk1rcCtORkdnN09yeTNr?=
 =?utf-8?B?Z1RyVGxtcXpIWThmV0FpbUROajdzNnlyTkwzMnVDK2hyWE8xU0lIaDhJcUVh?=
 =?utf-8?B?WWdmNGJ4QUFocS9rRGg4ZmlaLzVPbXJmaDVVOUsyRVJWYURsbnhwYzhsL1ls?=
 =?utf-8?B?aGFaK0RrUURzT2lTVlZSVWswblhqR0JpY054bDh0ZUh1NU1Qa25RNU85eG8y?=
 =?utf-8?B?eFl2bXZ5L3A2OVJQYU1Zb1pjTytJNFdTNFo1SG1rZmFyZlJ2MDlSdVd3V1Uy?=
 =?utf-8?B?UEhodUJXRkIvN1lEdjB1SGdnYjRDeEtOWUJYUmlZWDFoUmhQMks4a1lEMC9r?=
 =?utf-8?B?aUdjamx1RG5rRm5WWlIzZWpaSGNGV0pzWW4xMVMrY3BoTEhZblhkQ2d2RWpX?=
 =?utf-8?B?Mm9vV29ZdVhWaGI0QmJqdTNEMWVnVm50cUpGK0lkMDh1dEI2dzdsWmZVeHRn?=
 =?utf-8?B?VnNIVElZUkdzM1FLN2xZMDY2cmtYWHBtdmlOVHhOb1Job21WalZiZGJEQlFI?=
 =?utf-8?B?S2Z3cjZJbzVwZG9KWVhhSSttRDBaYUlUaUcwR0JwT0d0TjVPNTBieElCamxE?=
 =?utf-8?B?Z2JFN0NpMytBOS9QQjBTcHdsSXliUW9LajJ6OGlIODdLY05FTWFzemcrZWUz?=
 =?utf-8?B?RFFPY2ZFQ3BDM01QKzlGaFZrUTU3SURaZXRIQXJYY0cwc1VuNHUxSS9udDB3?=
 =?utf-8?B?R2VlQ09Ya0NBOVJaLzMyVVpBZUVzSCtoWmNYNzNUei9weWpaY05JLzdVbm1h?=
 =?utf-8?B?S3llVWkrTVhlL0Q0Si9vQzErTFZYeFEzenV1bU9EdndnY3h2aEZlbVU0WS9P?=
 =?utf-8?B?czE5RHZMa3NPUHAyeVdDa014bTJ4bHpkWkRONitnSEV4bjNWWHNHdWJacS9M?=
 =?utf-8?B?V3B3bEV6SVJkUERFcCsxUkw2WjJ1RDlnY1lNK2liNXoyQmhxRTRnQmhoRFlx?=
 =?utf-8?B?b1VES01sUHFsMWxuR29BR1puQzFWTmZrTUU0R1VjMDZrWWRDRVdGb2liQkpE?=
 =?utf-8?B?OExXY3pIWk96clFrbFBsdjcwQTlhWjlmdDlYU1VlTGJiRitaUWJVd2dqbzlD?=
 =?utf-8?B?Wk5nV0g2TWtLZ1QyaWs1Qnh0U2RFbHJvbWNJT1dRZGVZeDh5RFBCdTNjQXc1?=
 =?utf-8?B?Q2p1eGl2N2dWYUwwTnVJZzlZQVd5SUE2dStVUWxKazl1amFOOEc2WW9mdC82?=
 =?utf-8?B?S3Zwb1Q1RnlkblZQQ2dqbUhPdnBhajkyS3ZsdlhUOUtWWHNNN1oxSnUrVGRL?=
 =?utf-8?B?Qk8wZnFnNGFqSk1KMkVSTXhiK2ZVYjJZRFlvN1AwZjN2YjVEV1hZREhDcWYr?=
 =?utf-8?B?YzB0R1FnRHBxWFdDenB2bXdYb1BPN3pld2VuVkh5M1QvTForWkVQMTBWYW9y?=
 =?utf-8?B?WFVRSGJuVzdxbzE2MjYxR1NINERVeHpKNDJzL20rMHZmTmFGYUNjT1o0QW1N?=
 =?utf-8?B?eVJQbGxVTUZwMERXQ2xIaStaWUh6dnVwSE04VE1Jd3A1d3FDUHRaQU1haHZX?=
 =?utf-8?B?Rmd6ZlQvclRKK2o0R2t6TW9Ma3JmQnVWOXVSa2ljaWxVdDdvSEpWTHMrWlJI?=
 =?utf-8?Q?UdxLu/bVZMGVMIrqPnRWR326W2TMNAYM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGxZMkpnQkVqUnROa2hZKzJJUU9rMFQweTM3K1M5Zi9hcGJhVEVUZ2RSdGsr?=
 =?utf-8?B?Z3Z2eGNucTNnZWFJdVFGR0QzMWtNTFk2WG8rczNOWjVhZUU1V3l5SWJIbjR2?=
 =?utf-8?B?eXVONjN6bVdxSzdxaDl1RWpNL3FIMW1rQmNyUjNxUlZKUUtzckJPVHdxN24v?=
 =?utf-8?B?NWdqRUE5VU1UT0hjekcxSlZXczQyWHNSRi8xeTlEdHRTUnFFTytneDVQbzNW?=
 =?utf-8?B?c1JqODM4c2QxVTBmTUk2RytWKytDSnZtZ3hwcFRnNVJRN00xcEpLTEpaMjI4?=
 =?utf-8?B?K2JWdE5SYTIyTm9tM1g3dUhmZEI3dEhsUUhyRzRaV0ZhSit6ekFZYXBvbEFr?=
 =?utf-8?B?ejhBUk42aVJrMFdCWmxESW8vdWl1THArWGlsUytwVkx3VW5SU0dHRUFrKys4?=
 =?utf-8?B?NTlITW9iTmQxQk5odkVzVkNoTFQxSllVMmdzdks5MS9tU3U5UUxyNjVCQUdv?=
 =?utf-8?B?dW81SnB4dkQrNFBCVElUaWFHL0FSMXVwU0pkUFBFeS9uN25GNnhMdVlGVDIz?=
 =?utf-8?B?T2tyZ09TRW1XOUNoaTVUblJhcE1wMTRNRmNVTVJKWVVEVlM4VUd1cEV0MXZZ?=
 =?utf-8?B?cDFYQXB1bW1aME1XUXBTSGJaem1EdGVTM3B0ZDBpSUMwTk5RMWFwdTgyemtx?=
 =?utf-8?B?ODJFQnJFWXlISGdsMWZaVmNSdC94T2tDVS8yYUVobWtrVnFwa3FSZitQV3E0?=
 =?utf-8?B?c0xzS2dxVk54Yi8yZ2xkK1JBUU5VYkZ6Nm5pcWJxTXArMGEybTdPeGQrdDdM?=
 =?utf-8?B?SXN1anBLaEQrTURoRTd1OG1KTVgvVUY1VE56eXBJZ3R0NlZjN2c5ZW9HUjRC?=
 =?utf-8?B?WjZRdWdEODMxbzc4QUpYcmt6NFhSVmJkNEhJZ25ZUWZSdVplcVhoaEtNS0Nz?=
 =?utf-8?B?NWhsWXVWenUzR3I4d2dqZFJvc3RtKzVCSWxtMFZyVk10MlZoczVGMlVoZWlB?=
 =?utf-8?B?c1hHVWVtdDhOeFMxWU5QUnd4U2Q0WjJSa1VvMlFvWjlGUDc0WTlwV21vOU9K?=
 =?utf-8?B?QWRQc1NnTVhTU1M0SmJ4Y1RhWHYzYTFNOE9QRCtCeW43N0o1Wjh2Qm1YQ0dG?=
 =?utf-8?B?MXRTRDFQVGx4VzI3dHYzWWI4a2laMEE3bHBMSlUrMUx4dUtMTk1xcE8zRHNF?=
 =?utf-8?B?K1hETnF5eVR0SmRVSER0NVRCMzJsTVFKdDZNdE9GN1FWNkY3M0lJVjBtWU5K?=
 =?utf-8?B?bDF6d3FLSHhNUXlPSk1peFNrdmlkc1F6c01ZR1loNWgxQVluRHAzMnF2Si9P?=
 =?utf-8?B?QjhyZlBQNktIUHpYUW8xL2NHQS9BaTZQNVR6OWtKSVhpVmZDZk04T1BXamZh?=
 =?utf-8?B?cER4VFFYeUlYRVR5YWdIUGxtRzN5MjVvSTFtVndhOHZxVERLbmM5VE1OQmFG?=
 =?utf-8?B?M1V2dVVlalRaZWVrREM3YnYwcm5ReEVzM0w1Rk45bVdBSlc2Y09DNVkvZTB6?=
 =?utf-8?B?OXlGbWJTZ2pzSjZjTEVEQUxrNFRhWTVib1U4Tzg5NzVTTkorcHdsMG91YW84?=
 =?utf-8?B?WnUzOFM4b3UwSEs0NjRwZGhWRG9zL2JsYmZIRC81QUs1T1RWVHd2cjc5SGxx?=
 =?utf-8?B?SlhrVUpXOUwxYXV6dTg2b1Rwa1JuVmovUzNLQ2NLSEpuZXMvK1hQRDBaS29v?=
 =?utf-8?B?M0dzYk1PZlhBUitVbkxTY2dCNW1jSW82SzRUWEwwU2U5QjJJWlZJSDJjSUI1?=
 =?utf-8?B?WUlsSllXTHUzeTVQSFpQSmlwL3N3Z0J4dXBaam9za2VRQmx4QVdPaVFzYVd6?=
 =?utf-8?B?dXQwWU0zOUREcm13R0JvVkM3RU9icTNORktGQVZMSUgzT1BJQ052b05SeVF1?=
 =?utf-8?B?QmFpT3VnUlpOVVFDQ1JKeWRyRVYwb0RFdEtXNGY4bUs0dENtWjRDRWt6cnVr?=
 =?utf-8?B?eHVnc0IyZVlyZWZiVkx2R3VTcCtYQm9SQTVaclp2TVFPYVRUcU1KTkJwdE9I?=
 =?utf-8?B?M3BpWE1mLzJsOEhLVG90ZFpOQXZxRStPOFZQc3AzcUZDbWM1ak51N2hhYnp5?=
 =?utf-8?B?ZWpCK1hkTUtKc09VTVlIbUJDOWt1WVA4TVhJQlhXZEJwbUZYMjF5OUJuY3BS?=
 =?utf-8?B?a2F1VjNXRWpLTjZDVFJEMThzN1ZHN0Vtd1QzVzFUUmd6eFIwQmdZVzllVDdh?=
 =?utf-8?Q?dEOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9c336-6b8f-471b-9a50-08dd5c568198
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 02:27:56.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMLjRvJZHdk28ZVjw8lqB0p2FVRoTxG4d39NcwIn+KunF72yhZK7PQx+9IrHdGzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBNYXJjaCA2LCAyMDI1IDk6
MjUgQU0NCj5UbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTog
Rml4IHRoZSByYWNlIGNvbmRpdGlvbiBmb3IgZHJhaW5pbmcgcmV0cnkgZmF1bHQNCj4NCj4NCj5P
biAyMDI1LTAzLTA1IDIwOjEwLCBFbWlseSBEZW5nIHdyb3RlOg0KPj4gSXNzdWU6DQo+PiBJbiB0
aGUgc2NlbmFyaW8gd2hlcmUgc3ZtX3JhbmdlX3Jlc3RvcmVfcGFnZXMgaXMgY2FsbGVkLCBidXQg
c3ZtLQ0KPj5jaGVja3BvaW50X3RzDQo+PiAgIGhhcyBub3QgYmVlbiBzZXQgYW5kIHRoZSByZXRy
eSBmYXVsdCBoYXMgbm90IGJlZW4gZHJhaW5lZCwNCj4+IHN2bV9yYW5nZV91bm1hcF9mcm9tX2Nw
dSBpcyB0cmlnZ2VyZWQgYW5kIGNhbGxzIHN2bV9yYW5nZV9mcmVlLg0KPj4gTWVhbndoaWxlLCBz
dm1fcmFuZ2VfcmVzdG9yZV9wYWdlcyBjb250aW51ZXMgZXhlY3V0aW9uIGFuZCByZWFjaGVzDQo+
PiBzdm1fcmFuZ2VfZnJvbV9hZGRyLiBUaGlzIHJlc3VsdHMgaW4gYSAiZmFpbGVkIHRvIGZpbmQg
cHJhbmdlLi4uIiBlcnJvciwgY2F1c2luZyB0aGUNCj5wYWdlIHJlY292ZXJ5IHRvIGZhaWwuDQo+
Pg0KPj4gSG93IHRvIGZpeDoNCj4+IE1vdmUgdGhlIHRpbWVzdGFtcCBjaGVjayBjb2RlIHVuZGVy
IHRoZSBwcm90ZWN0aW9uIG9mIHN2bS0+bG9jay4NCj4+DQo+PiB2MjoNCj4+IE1ha2Ugc3VyZSBh
bGwgcmlnaHQgbG9ja3MgYXJlIHJlbGVhc2VkIGJlZm9yZSBnbyBvdXQuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyB8IDMwICsrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEzIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfc3ZtLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+
PiBpbmRleCBkMDQ3MjU1ODNmMTkuLmRiODk4NzU3ZjkyZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+PiBAQCAtMzAwOCwxOSArMzAwOCw2IEBAIHN2bV9yYW5n
ZV9yZXN0b3JlX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+KmFkZXYsIHVuc2lnbmVkIGlu
dCBwYXNpZCwNCj4+ICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAgfQ0KPj4NCj4+IC0g
ICAgLyogY2hlY2sgaWYgdGhpcyBwYWdlIGZhdWx0IHRpbWUgc3RhbXAgaXMgYmVmb3JlIHN2bXMt
PmNoZWNrcG9pbnRfdHMgKi8NCj4+IC0gICAgaWYgKHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4
XSAhPSAwKSB7DQo+PiAtICAgICAgICAgICAgaWYgKGFtZGdwdV9paF90c19hZnRlcl9vcl9lcXVh
bCh0cywgIHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4XSkpIHsNCj4+IC0gICAgICAgICAgICAg
ICAgICAgIHByX2RlYnVnKCJkcmFpbmluZyByZXRyeSBmYXVsdCwgZHJvcCBmYXVsdCAweCVsbHhc
biIsIGFkZHIpOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgciA9IDA7DQo+PiAtICAgICAgICAg
ICAgICAgICAgICBnb3RvIG91dDsNCj4+IC0gICAgICAgICAgICB9IGVsc2UNCj4+IC0gICAgICAg
ICAgICAgICAgICAgIC8qIHRzIGlzIGFmdGVyIHN2bXMtPmNoZWNrcG9pbnRfdHMgbm93LCByZXNl
dCBzdm1zLQ0KPj5jaGVja3BvaW50X3RzDQo+PiAtICAgICAgICAgICAgICAgICAgICAgKiB0byB6
ZXJvIHRvIGF2b2lkIGZvbGxvd2luZyB0cyB3cmFwIGFyb3VuZCBnaXZlIHdyb25nDQo+Y29tcGFy
aW5nDQo+PiAtICAgICAgICAgICAgICAgICAgICAgKi8NCj4+IC0gICAgICAgICAgICAgICAgICAg
IHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4XSA9IDA7DQo+PiAtICAgIH0NCj4+IC0NCj4+ICAg
ICAgaWYgKCFwLT54bmFja19lbmFibGVkKSB7DQo+PiAgICAgICAgICAgICAgcHJfZGVidWcoIlhO
QUNLIG5vdCBlbmFibGVkIGZvciBwYXNpZCAweCV4XG4iLCBwYXNpZCk7DQo+PiAgICAgICAgICAg
ICAgciA9IC1FRkFVTFQ7DQo+PiBAQCAtMzA0MCw2ICszMDI3LDIzIEBAIHN2bV9yYW5nZV9yZXN0
b3JlX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+KmFkZXYsIHVuc2lnbmVkIGludCBwYXNp
ZCwNCj4+ICAgICAgbW1hcF9yZWFkX2xvY2sobW0pOw0KPj4gICByZXRyeV93cml0ZV9sb2NrZWQ6
DQo+PiAgICAgIG11dGV4X2xvY2soJnN2bXMtPmxvY2spOw0KPj4gKw0KPj4gKyAgICAvKiBjaGVj
ayBpZiB0aGlzIHBhZ2UgZmF1bHQgdGltZSBzdGFtcCBpcyBiZWZvcmUgc3Ztcy0+Y2hlY2twb2lu
dF90cyAqLw0KPj4gKyAgICBpZiAoc3Ztcy0+Y2hlY2twb2ludF90c1tncHVpZHhdICE9IDApIHsN
Cj4+ICsgICAgICAgICAgICBpZiAoYW1kZ3B1X2loX3RzX2FmdGVyX29yX2VxdWFsKHRzLCAgc3Zt
cy0+Y2hlY2twb2ludF90c1tncHVpZHhdKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgcHJf
ZGVidWcoImRyYWluaW5nIHJldHJ5IGZhdWx0LCBkcm9wIGZhdWx0IDB4JWxseFxuIiwgYWRkcik7
DQo+PiArICAgICAgICAgICAgICAgICAgICByID0gMDsNCj4+ICsgICAgICAgICAgICAgICAgICAg
IG11dGV4X3VubG9jaygmc3Ztcy0+bG9jayk7DQo+PiArICAgICAgICAgICAgICAgICAgICBtbWFw
X3JlYWRfdW5sb2NrKG1tKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgIG1tcHV0KG1tKTsNCj4+
ICsgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPg0KPkknZCBwcmVmZXIgZ290byBvdXRf
dW5sb2NrX3N2bS4gVGhhdCB3YXkgaWYgdGhlIGxvY2tpbmcgbG9naWMgY2hhbmdlcywgd2Ugb25s
eSBuZWVkDQo+dG8gdXBkYXRlIG9uZSBwbGFjZSB0aGF0IHJlbGVhc2VzIGFsbCB0aGUgcmlnaHQg
bG9ja3MgaW4gdGhlIHJpZ2h0IG9yZGVyLg0KPg0KPklmIHlvdSdyZSB3b3JyaWVkIGFib3V0IGNv
dW50aW5nIHRoZSBmYXVsdCB3aXRoIHN2bV9yYW5nZV9jb3VudF9mYXVsdCwgSSByZWNvbW1lbmQN
Cj5zZXR0aW5nIHIgPSAtRUFHQUlOIGFuZCBvbmx5IGNvdW50aW5nIGZhdWx0cyB3aGVuIHIgIT0g
LUVBR0FJTi4gVGhhdCB3YXkgeW91IG9ubHkNCj5jb3VudCBzdWNjZXNzZnVsIGFuZCBmYWlsZWQg
ZmF1bHRzIGJ1dCBub3QgcmV0cmllZCBvbmVzLg0KPg0KPlJlZ2FyZHMsDQo+ICAgRmVsaXgNClRo
YW5rcywgbW9kaWZpZWQgaW4gdjMsIHBsZWFzZSBoZWxwIHJldmlldyBhZ2Fpbi4NCg0KRW1pbHkg
RGVuZw0KQmVzdCBXaXNoZXMNCg0KDQo+DQo+DQo+PiArICAgICAgICAgICAgfSBlbHNlDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAvKiB0cyBpcyBhZnRlciBzdm1zLT5jaGVja3BvaW50X3RzIG5v
dywgcmVzZXQgc3Ztcy0NCj4+Y2hlY2twb2ludF90cw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICogdG8gemVybyB0byBhdm9pZCBmb2xsb3dpbmcgdHMgd3JhcCBhcm91bmQgZ2l2ZSB3cm9uZw0K
PmNvbXBhcmluZw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICovDQo+PiArICAgICAgICAgICAg
ICAgICAgICBzdm1zLT5jaGVja3BvaW50X3RzW2dwdWlkeF0gPSAwOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiAgICAgIHByYW5nZSA9IHN2bV9yYW5nZV9mcm9tX2FkZHIoc3ZtcywgYWRkciwgTlVMTCk7
DQo+PiAgICAgIGlmICghcHJhbmdlKSB7DQo+PiAgICAgICAgICAgICAgcHJfZGVidWcoImZhaWxl
ZCB0byBmaW5kIHByYW5nZSBzdm1zIDB4JXAgYWRkcmVzcyBbMHglbGx4XVxuIiwNCg==
