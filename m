Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8860C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 18:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8574910E091;
	Mon, 10 Feb 2025 18:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41FTxR38";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1168610E091
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 18:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbiZUJiCWStFV1jfnBR9A2CzapRwrKpZRzaXKH7VT1i9AdkKQwoWmEvFuNWYGKRPf9hgZQVGiCwwAM39r/I0cf1Yl289AldP6wkKa9Grxy9Exec+TJYTY73hs8/+dsAaIAu4u26ONY/CQzxFydOwkvyUwqp4ooSxvfXo3ugqth8hnz7WdHHcslDJB6zM26KjWIwhjcpPtMPtbtZ+Ynr8LAZ89vdW3S468eWsjRWeYqG36bZhA+vV/7VXQKqjhL8/15B9xVXmsBv+5XpJFms9TVU5zUxmPEr7IEkKllwjek2dXSTTXqTQWY4MxM/LQtUqsMOelkcvq4ZrBClcmF8URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psp+qlhU8kNZMg49SgEb542crlnHtXk40uCghJuFTTc=;
 b=P1KjoQwufuJsGmu1qY8d6r67SmOSA+VYIhXMz+H+qHALFIZdI/kJTqhxi0mCPb2dpTfKAw3DZlFgTRit0C9gKR4lIhiHyMhFcDrQiQDVLhE6GdDksDlNdCoV7z0sLUKOL7WwEhIA4phLsT5Jr2TecHA34DAXTaqX44ZpLBOaHuaBHq4NmO9RxjJ5/xcKgKPGFzYVRRBSQ6aNBnDPKF8LKGlFWFg+ubt+3lG86cvn3EMbcqjHfkZ4GxAjNKtciqBdrGVHPFugyYYSIROYxU292lhecfbATvUPkCBi9SYwsURdxOZyKf5hChXaVKB3t8dK9IXH/7P9qDlP7xk/r7ro/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psp+qlhU8kNZMg49SgEb542crlnHtXk40uCghJuFTTc=;
 b=41FTxR38vcH8VvyvVBxG5Iam/lR207GO0Dq3xVB6g8oWsGQxnWUv2lDn6kSbMFEVkYboc4FU/VhJcnOSKHY5mr3mvRzreDfxO+gLceNAfHLPUkKSBt2npsPoeaNywc0m9RYu0k/GjM8G3rWAWg3FE/LezYYTFOqcGO92m4mgaN8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 18:49:15 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 18:49:14 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Topic: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbe9jNK1rPdPoTmkue+fU9fDVJkLNA4Jbw
Date: Mon, 10 Feb 2025 18:49:14 +0000
Message-ID: <CH0PR12MB53728FDD4853143254B78D77F4F22@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250210162755.2488728-1-alexander.deucher@amd.com>
 <20250210162755.2488728-2-alexander.deucher@amd.com>
In-Reply-To: <20250210162755.2488728-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb33c207-beee-411d-b03e-41d60566c0bd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-10T18:46:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SJ1PR12MB6292:EE_
x-ms-office365-filtering-correlation-id: 4fc9d3dd-3053-4c64-9485-08dd4a039dca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UktOV2hVUkJCSHQzVUNmTU5UdFZMY0J4eXhqVkhOdm9WeXlnNHpNMUl6V1VM?=
 =?utf-8?B?OGM0c1k1RXphcXJ0WkF3YjV1NndIbDBINU9RSDFTaTMyNEg1ekR6L0M2L1hh?=
 =?utf-8?B?SDFoakx5cWpteVhuU21Nb2R3c1F6RnBBMThhZ2N6UlRRWkpROHh4bTlHTmQ1?=
 =?utf-8?B?L2wrcG5RRmwvUkU4bi90aFdTQzFyb2xEb3pmR3ZOc29GM2lBTjV4bUM4ZEU4?=
 =?utf-8?B?cWdBL2ptTjhicFZMaEUzejVOVkpPL3ZuTzZ2ZnpSZVNobDhqWjl1ZWxJakNz?=
 =?utf-8?B?b1d1YVhPVTROYy9zWTR1OGJMSUdiQTJsZlpPaUkvYXdqSURJbUk0aWVYc2JK?=
 =?utf-8?B?aG1sazh6Rk1iY01wWUc1K3FLdGVRTHlWL2FiK3JhOXZPSHdOVzJMc1IzQmpt?=
 =?utf-8?B?YzJtSmpaQ3VuN2UrS0k4dWIxRm5qMmt3R0p0TFNpdGhDNHFHbGlIMktnNWhZ?=
 =?utf-8?B?cjJ5OGFmbUVEUUMxQmRBcjRSTVVyQ09aRVBCYy9RYWJ2NXZ3Zlo2TUkwdUtG?=
 =?utf-8?B?OFBjYkd3eHpHcTRYTmtnTUZkcmxheUE0UzFnS3NVa2dFaUNpUzRXYXRzblFP?=
 =?utf-8?B?cFpnZ21KKzhFZlVTaVZEYmxUR3EyRXgzR1Y5ZHBBNm1RMDRwazBmRHZYbmM1?=
 =?utf-8?B?b0JLSFArRnZ4RStxRzhvdWR2MFNCZ0VuVUpna21FdndORC8rcWcyMXYrVXVa?=
 =?utf-8?B?MXd2TW1pMVZkVThDYTZybGhWbW0rMUtZd1UzbjU0dUExcGxpenZtWXh4bHNz?=
 =?utf-8?B?Q0t1SHA5cURhR1N4cmNmSXpmaEcxcHkwakxDbzd5QnRnV2lvSnpndnZ6WTFZ?=
 =?utf-8?B?NmZCUFRWNXN0ZWdhZUpQN0lYdSszZHVYU0dJNmcvYURZOW9HcE9NYWk3QUpl?=
 =?utf-8?B?Z3hZU1JJem9mRVJxSWlNYnlNVW5kaXVkM1JVOEhITW1aU01lMlFzRDMzTUR4?=
 =?utf-8?B?bkNmMXBWSHVURVBrZEkzbGxtcCtoQWN0b1RTaEFhbFNzbk5wZFkzeThWWWRm?=
 =?utf-8?B?RjdNVzZWQWR3MGF1RlpFQXJseldXTm1tLzBONkRWbWlwNElSem9sR1JRd0hC?=
 =?utf-8?B?a1MvSUYwU0VYdzlDUmdOMFRSVit1SVE2U1FlNExUZXVzSG5wOHNmZGxXdCtr?=
 =?utf-8?B?bkFTQjJFWGx5c0gvYjd2YWhRSGp0V28wL0s2TWNZMHJaZk5DU2VtS2pmdDBh?=
 =?utf-8?B?VnZ6RDZkendZK2tBcGcvaUpPQUp6eHQ2bjVhb3ZWd3V5eDl0eXk0VFZ0SlpE?=
 =?utf-8?B?L3JnZ0U5RDE5aDcyMFdJam0vTERBK29vTnBPbFRBSTA4R2U2VTBwUXJQbXBB?=
 =?utf-8?B?R1dQaElXM0tIMnlhY1ZraFp6V1ZsS3VVREk1dVBHY1NsNDRGTDVqUkpXazYx?=
 =?utf-8?B?K2FMV2RpOXlranFmWk9iNUthOG9tVzYrTzcvZ3VXQ3E4alNUeFRWMEFXUklt?=
 =?utf-8?B?dVhvbzU5eFlNUklpNXJweU9iaGlXVjdEOENIM2x0MCtUWHJyanp4SXJvZUl3?=
 =?utf-8?B?bzQ5RWRvU0JRQlZPSHI2WGhJL2gydUJWdlUvLyt1VDFDekRJOGJ0VkZNYmlU?=
 =?utf-8?B?VEhac2tDaXZBMTU5N2I4eDR4K0drT3pVY0w2MlFYT2tTelh6bTJXZVpJUmtS?=
 =?utf-8?B?b3FXbDVZOGxYL2k4aVByc0d0TEJ6R2JnaktMNUt3NzNZK3BPeVM5cS9mN0FX?=
 =?utf-8?B?SktaQ1JidjRMZmRnOFBSQTZYL0t4R1RCVUlMaThBdGFsS3NIUE8vZmMxb0hk?=
 =?utf-8?B?dnFBMU5ETGg4THh6dFRIa1UxZXNIOEYxZnBoREVVRHd5cG9WSWpyMDRJWmh4?=
 =?utf-8?B?MHUwaDI1NFJZOWo5ZWtvd2hFU2tpcmR1UjU3SXZWT3pyTGZLeUlQZUd5RGhK?=
 =?utf-8?B?WWdleDdGUXF2ZHpuVTBxejlVT3lGcXYvOC81c0ZKcjFaSXVjN2Q4Y1RvMTk2?=
 =?utf-8?Q?7ZVJaTQvViWo1NEQH23VnlhFrCtOAAd5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmRiRllmRmtad3UvVkhEc2JkaVczdUZUVEhYaVdhRGdVLy9mQUhoQkZVVld5?=
 =?utf-8?B?UXRMbk04S0lyYlk0ZWtSZ1lXUHRLanRqaHhRdUFDUUVVdExMK3p3QndjWTNR?=
 =?utf-8?B?aUlJY2YyTGJzSkZUUW52QllJSXlBdjhkVG5ZYVd6QWZPZzluY1YrNGxRNzlU?=
 =?utf-8?B?U1BpV2c0Qkc1RU4vYnZBOS9VT0YrVUh3dVVadUtYNVU2SjdiZzVmZUp5SVpk?=
 =?utf-8?B?YVZtS1Ayb2ZKMmk5M3AvcXRBamwrZmJMV2FjSDd2MEIxWUlzaVdNYmI4cFNN?=
 =?utf-8?B?aTd3WGZtWHFmc001Tm5rQlBzaWpJNHdjZmczWko5Q1Jyc3c4MUJScEFFZ1dl?=
 =?utf-8?B?MjlNR29qVnorUGRWdkJURTY5S3VMSDcrSUZKTnhYNTJKQXlaeXRTT3lkaHJS?=
 =?utf-8?B?d1dCdXNnOUVraGU3UGtCTnoxUDlpZlRTWk9UQnFwNGhmVklFdEc1aFYxZDNn?=
 =?utf-8?B?dFZoMU04T1BIOEUyTjYwVnZKdng4bzRFNmtybzhoL0ZZbHJlODRSTzVMeG13?=
 =?utf-8?B?UTZ5VE56WkM0a29ZbnZVUzNmZnRSbE1ZN0NMK0QvanRGWm94aTYyZXdHQk1S?=
 =?utf-8?B?a3JaTVNYMkJJNzdUVExUTFhFZGs1VnJBQU95UzZYcEtjQWozMDh1eW0yVkRI?=
 =?utf-8?B?YUhrUlNBbldwdFpJKzI0S2crdkc3SlBZcWJUTXJmSXkwTDQ1amh5SmZOQ0g0?=
 =?utf-8?B?d1ZtN2VLcWNoaUhTZm9ualZ2ZHhzT1YwaDVRZkMySjJOZEdnWTMydjlVUkta?=
 =?utf-8?B?WEk0WFFjOUQvZyswaURKa0RQWDJQY2U3VDByb3d5Y2tsOHNJYnNOczNDK1M5?=
 =?utf-8?B?RVNTUWVvaVc3UWtVMGp3TUhMUzFTSXFYSW5GQVlrVFkwRjl3M3YyQks1WTBQ?=
 =?utf-8?B?MDJZQnBibU01KzRoNStmQTZvRnNLa2dTVmxrQWl3QndGcFJNN2xuVitUSEVR?=
 =?utf-8?B?VGtYVFpidkgyZDd4bmRzdWtRMjZocG5veGZKWElmeGltYTlFK0VpZ1A1TmVG?=
 =?utf-8?B?RHpKOVBRN0Q0NTNQeWRlSTNhck8wRTJxbzBBbnhGdmozY2ZXYkpQdDFzS2x3?=
 =?utf-8?B?amRneXZmSGhGa0k5ZUV3ZndrV2dEREc4Q1cxUGxSV2E4SU5paThBSVNEbk5r?=
 =?utf-8?B?bHpXRjdMRldmTUsrSHI5WGxrWm42RjlSTWJpeVVsVkRpWk9zSFNBT3pSMFRY?=
 =?utf-8?B?RDBnLzY1YUhKTmN1Mm9TM0JUN1BkZUtXR2JKalViUjRucmw1N3B0bXk5R0kw?=
 =?utf-8?B?NVNHdm84N21zME1FWVY2Z2tiTTNLbFhWS3JrVm1BUFFkOEZLZXVQa2FFazZy?=
 =?utf-8?B?WHFweDRaS2pFamRFNTNBY3MxNVd5cFQ0T3lhZFVOanh2dnZHSW14L1Rya2FR?=
 =?utf-8?B?RkhrSjBpRjEyY0Rsd3hBZ2RWNy9WajkrRXNrVDR0WllwbVRUKzZmTmg0bHRn?=
 =?utf-8?B?RXVMSnNYWFdNS3hZNStSZFlnVVJ4NFZ3SWt3TDZJM0d3dW5LWUFFamM4UWtB?=
 =?utf-8?B?VzNVVnFETkhWSWgvbGcwVkU3STlwbmtXQW4rTE5LL0NZMGEyaDA1NVM0V3Vk?=
 =?utf-8?B?ZDF5T0ZZNjE2bzZDSnBvNUhkZHZreFQwQnVtcGZOS0gwMk9LNE1nUktxYm92?=
 =?utf-8?B?cnBFclRHeEVobGkyR3JsUnlOTGR4cVI5N0U1TUpIc1VScTZSVHdqNkxORTFx?=
 =?utf-8?B?TW9nNEdNU0RVdTZWeEpZeUdjUHdETXVFNUd2NjIzQlE2VEdER0FMRGVDaCtI?=
 =?utf-8?B?aDZCSFpzOEdoc0VsTmh1Y2trbE1wTnhIWWpMZjRzQmJNaFpnRFFBVk9WYkMy?=
 =?utf-8?B?ZVVOQVBNb0JKK3l1Ty9sYTVUUDZIdFRBeFUyelMwYjRETnBKc3BVNmY4MUVn?=
 =?utf-8?B?dkRxSTdQT1V3K0RRR1hUS25Ma2FuT2NlZjdxb2RtV1NKUDZ5ZjllYW50bTVs?=
 =?utf-8?B?SHpFMEM1bXl0YVFpVEttaTFCTUczbThRak04aGU0V2FRc1dsbUgvSk1QRGVr?=
 =?utf-8?B?ckhlc1p2T1RlblNER1pNR05XcEl1UEZQNHN5RFRqSXBMKzRBWE1RS1IySFNv?=
 =?utf-8?B?M1VBNHRiNDN4Q3dtMFhuRFZpYUFhbnlpRjFkWU1SNzUvSitoM3drSC9ZQzZM?=
 =?utf-8?Q?Ei8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc9d3dd-3053-4c64-9485-08dd4a039dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 18:49:14.8791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQUp73hymRZlnaHmLe6Qg58T3CitDRw5fiuhFDVLOuN0yA9c0ckmbtVfjq9hxLCTRBg+74I61lRXZYa0lg9qWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
Cg0KTWlnaHQgbmVlZCB0byB1cGRhdGUgdGhlICBjb21taXQgbWVzc2FnZSBzaW5jZSB0aGlzIGNo
YW5nZSBkb24ndCB1c2UgdGhlIHdyaXRlLWJhY2sgbWVtb3J5IGFuZCAgdGhlICBwYWNrYWdlIGlz
IHNldF9od19yZXNfMS4NCg0KT3RoZXIgdGhhbiB0aGF0ICwgaXQgbG9va3MgZ29vZCB0byBtZSAu
IEFuZCBJIHRoaW5rIHdlIG5lZWQgYSBzaW1pbGFyIGNoYW5nZSBmb3IgZ2Z4MTINCg0KUmVnYXJk
cw0KU2hhb3l1bi5saXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClNlbnQ6IE1vbmRheSwg
RmVicnVhcnkgMTAsIDIwMjUgMTE6MjggQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1k
LmNvbT47IGNhbywgbGluIDxsaW4uY2FvQGFtZC5jb20+OyBDaGVuLCBKaW5nV2VuIChXYXluZSkg
PEppbmdXZW4uQ2hlbjJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0gg
VjQgMi8yXSBkcm0vYW1kZ3B1L21lczogQWRkIGNsZWFuZXIgc2hhZGVyIGZlbmNlIGFkZHJlc3Mg
aGFuZGxpbmcgaW4gTUVTIGZvciBHRlgxMQ0KDQpGcm9tOiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8
c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCg0KVGhpcyBjb21taXQgaW50cm9kdWNlcyBl
bmhhbmNlbWVudHMgdG8gdGhlIGhhbmRsaW5nIG9mIHRoZSBjbGVhbmVyIHNoYWRlciBmZW5jZSBp
biB0aGUgQU1ER1BVIE1FUyBkcml2ZXI6DQoNCi0gVGhlIE1FUyAoTWljcm9jb2RlIEV4ZWN1dGlv
biBTY2hlZHVsZXIpIG5vdyBzZW5kcyBhIFBNNCBwYWNrZXQgdG8gdGhlDQogIEtJUSAoS2VybmVs
IEludGVyZmFjZSBRdWV1ZSkgdG8gcmVxdWVzdCB0aGUgY2xlYW5lciBzaGFkZXIsIGVuc3VyaW5n
DQogIHRoYXQgcmVxdWVzdHMgYXJlIGhhbmRsZWQgaW4gYSBjb250cm9sbGVkIG1hbm5lciBhbmQg
YXZvaWRpbmcgdGhlDQogIHJhY2UgY29uZGl0aW9ucy4NCi0gVGhlIENQIChDb21wdXRlIFByb2Nl
c3NvcikgZmlybXdhcmUgaGFzIGJlZW4gdXBkYXRlZCB0byB1c2UgYSBwcml2YXRlDQogIGJ1cyBm
b3IgYWNjZXNzaW5nIHNwZWNpZmljIHJlZ2lzdGVycywgYXZvaWRpbmcgdW5uZWNlc3Nhcnkgb3Bl
cmF0aW9ucw0KICB0aGF0IGNvdWxkIGxlYWQgdG8gaXNzdWVzIGluIFZGIChWaXJ0dWFsIEZ1bmN0
aW9uKSBtb2RlLg0KLSBUaGUgY2xlYW5lciBzaGFkZXIgZmVuY2UgbWVtb3J5IGFkZHJlc3MgaXMg
bm93IHNldCBjb3JyZWN0bHkgaW4gdGhlDQogIGBtZXNfc2V0X2h3X3Jlc19wa3RgIHN0cnVjdHVy
ZSwgYWxsb3dpbmcgZm9yIHByb3BlciBzeW5jaHJvbml6YXRpb24gb2YNCiAgdGhlIGNsZWFuZXIg
c2hhZGVyIGV4ZWN1dGlvbi4gVGhpcyBpcyBkb25lIGJ5IGNhbGN1bGF0aW5nIHRoZSBhZGRyZXNz
DQogIHVzaW5nIHRoZSB3cml0ZS1iYWNrIG1lbW9yeSBiYXNlIGFkZHJlc3MgYW5kIHRoZSBjbGVh
bmVyIGZlbmNlIG9mZnNldC4NCg0KQ2M6IGxpbiBjYW8gPGxpbi5jYW9AYW1kLmNvbT4NCkNjOiBK
aW5nd2VuIENoZW4gPEppbmd3ZW4uQ2hlbjJAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPg0KU3VnZ2VzdGVkLWJ5OiBTaGFveXVuIExpdSA8c2hhb3l1bi5saXVA
YW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2Fu
LnNoYW5tdWdhbUBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVz
X3YxMV8wLmMgfCAxNyArKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djExXzAuYw0KaW5kZXggZTg2MmEzZmViZTJiMi4uNjYxMjY4MTcyZGNmNiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KQEAgLTc1NCw3ICs3NTQsNyBAQCBzdGF0aWMg
aW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzXzEoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykN
CiAgICAgICAgbWVzX3NldF9od19yZXNfcGt0LmhlYWRlci5kd3NpemUgPSBBUElfRlJBTUVfU0la
RV9JTl9EV09SRFM7DQogICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5lbmFibGVfbWVzX2luZm9f
Y3R4ID0gMTsNCg0KLSAgICAgICByZXQgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBz
aXplLCBQQUdFX1NJWkUsDQorICAgICAgIHJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKGFk
ZXYsIHNpemUgKyBBTURHUFVfR1BVX1BBR0VfU0laRSwNCitQQUdFX1NJWkUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZtZXMtPnJlc291cmNlXzEsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZtZXMtPnJlc291cmNlXzFfZ3B1X2FkZHIsDQpAQCAtNzY1LDcgKzc2
NSwxMCBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzXzEoc3RydWN0IGFt
ZGdwdV9tZXMgKm1lcykNCiAgICAgICAgfQ0KDQogICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5t
ZXNfaW5mb19jdHhfbWNfYWRkciA9IG1lcy0+cmVzb3VyY2VfMV9ncHVfYWRkcjsNCi0gICAgICAg
bWVzX3NldF9od19yZXNfcGt0Lm1lc19pbmZvX2N0eF9zaXplID0gbWVzLT5yZXNvdXJjZV8xLT50
Ym8uYmFzZS5zaXplOw0KKyAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3QubWVzX2luZm9fY3R4X3Np
emUgPSBzaXplOw0KKyAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3QuY2xlYW5lcl9zaGFkZXJfZmVu
Y2VfbWNfYWRkciA9DQorICAgICAgICAgICAgICAgbWVzLT5yZXNvdXJjZV8xX2dwdV9hZGRyICsg
c2l6ZTsNCisNCiAgICAgICAgcmV0dXJuIG1lc192MTFfMF9zdWJtaXRfcGt0X2FuZF9wb2xsX2Nv
bXBsZXRpb24obWVzLA0KICAgICAgICAgICAgICAgICAgICAgICAgJm1lc19zZXRfaHdfcmVzX3Br
dCwgc2l6ZW9mKG1lc19zZXRfaHdfcmVzX3BrdCksDQogICAgICAgICAgICAgICAgICAgICAgICBv
ZmZzZXRvZih1bmlvbiBNRVNBUElfU0VUX0hXX1JFU09VUkNFU18xLCBhcGlfc3RhdHVzKSk7IEBA
IC0xNjMyLDcgKzE2MzUsOCBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9od19pbml0KHN0cnVjdCBh
bWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KICAgICAgICBpZiAocikNCiAgICAgICAgICAgICAg
ICBnb3RvIGZhaWx1cmU7DQoNCi0gICAgICAgaWYgKGFtZGdwdV9zcmlvdl9pc19tZXNfaW5mb19l
bmFibGUoYWRldikpIHsNCisgICAgICAgaWYgKGFtZGdwdV9zcmlvdl9pc19tZXNfaW5mb19lbmFi
bGUoYWRldikgfHwNCisgICAgICAgICAgIGFkZXYtPmdmeC5lbmFibGVfY2xlYW5lcl9zaGFkZXIp
IHsNCiAgICAgICAgICAgICAgICByID0gbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNfMSgmYWRl
di0+bWVzKTsNCiAgICAgICAgICAgICAgICBpZiAocikgew0KICAgICAgICAgICAgICAgICAgICAg
ICAgRFJNX0VSUk9SKCJmYWlsZWQgbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNfMSwgcj0lZFxu
Iiwgcik7IEBAIC0xNjY1LDEwICsxNjY5LDEzIEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX2h3X2lu
aXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spICBzdGF0aWMgaW50IG1lc192MTFf
MF9od19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKSAgew0KICAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2Ow0KLSAgICAgICBpZiAo
YW1kZ3B1X3NyaW92X2lzX21lc19pbmZvX2VuYWJsZShhZGV2KSkgew0KKw0KKyAgICAgICBpZiAo
YW1kZ3B1X3NyaW92X2lzX21lc19pbmZvX2VuYWJsZShhZGV2KSB8fA0KKyAgICAgICAgICAgYWRl
di0+Z2Z4LmVuYWJsZV9jbGVhbmVyX3NoYWRlcikgew0KICAgICAgICAgICAgICAgIGFtZGdwdV9i
b19mcmVlX2tlcm5lbCgmYWRldi0+bWVzLnJlc291cmNlXzEsICZhZGV2LT5tZXMucmVzb3VyY2Vf
MV9ncHVfYWRkciwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRl
di0+bWVzLnJlc291cmNlXzFfYWRkcik7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZhZGV2LT5tZXMucmVzb3VyY2VfMV9hZGRyKTsNCiAgICAgICAgfQ0KKw0KICAgICAg
ICByZXR1cm4gMDsNCiB9DQoNCi0tDQoyLjQ4LjENCg0K
