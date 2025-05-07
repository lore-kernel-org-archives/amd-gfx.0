Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31561C369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 06:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA75810E079;
	Wed,  7 May 2025 06:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D++R1qyh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365F610E079
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 06:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI966clZmwaSyIzKNFYqAxT9zPEdUC54O31Ju6J0lict49gY7PiU+mCMLO9/mZzsR3Y4pjKyUtijq1+Fb12rAj/xSspABRsMX/QGbHgBnum3vAUr5lePQ2hZ++1f9jrGvEJoJFbxOyWkucnkwiCPnL78i+DF3GOSsKrnOovotPlVleMjSWsvAsp+LmbosV70w5h4HEM88uLEDUHb51DzCSM2OL4nIqwrfZ1zzzHTjh0u+hizj31ZaiYMBgU/s7Rp8HxEXb1QaoLLR6E20+2mGdHRoP0YP56aPcoevfHJgCL8opmmFrg/97xsYgNJdChQhxdmATOaKci00eRFAZpu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/0/O2aXj76K1N6kXWf/gcs1Yk3MIAP+BSOhBH7R+Wo=;
 b=FzDAGYHHcQAYLP7KvzFvMS1J4tuI3nbLxnMtL/N8RXqtFIZ31CvOSHJA+vDozKvwjKyHPeFrdflYPWfwdu+SPZXbTQHRljOdp0i9vFjBDoSzFKfCE/ktgUNAZcbl/ZW5JkUn524ThWx/pUH039p03T/xX7b4WRcyppAvtmMxGBOnKYj1reESa94aqXnEcCcRNcccSpjBkpS/tieqS3grA77SV1V4UOQXUTjPpBDINEPjZTNFCdXq2gAbT8UvEFJ/QiOEil3jtdr4VLrojhjcVA33vbWPXUNiyYzDAf1pq3ulhhj64KUXjzvQ8v1kPh25SgnG47awqp1wS8fH+9+chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/0/O2aXj76K1N6kXWf/gcs1Yk3MIAP+BSOhBH7R+Wo=;
 b=D++R1qyhHhdLQC5VJPnl8hZOje22g5Ej0HebrRkMhlzw3fbLTxzI9S4IlqB7Ijg/iUkfW4raw2bWU3WowjHBQvPV+4+ws0B4W63WYs6LRy8z6iWX6bbzhvnF4FmvR9TGn3ZALj6EL73PiHY5kD8tnSl4opM5SeJ47LJ7kcN8Qp4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:02:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:02:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
Thread-Topic: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
Thread-Index: AQHbvp/eUPchPwnOKkC+nfROwSkGBrPGrUKw
Date: Wed, 7 May 2025 06:02:40 +0000
Message-ID: <DS7PR12MB60056C245299450DC5CFE66BFB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
 <20250506155900.3866874-4-alexander.deucher@amd.com>
In-Reply-To: <20250506155900.3866874-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0c4fbf19-54a8-431a-abc8-490881c2171b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-07T06:00:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8659:EE_
x-ms-office365-filtering-correlation-id: 2fb247e9-13c6-4c10-70c3-08dd8d2cc6a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RHJEY1NReW9DVktYR0toRzQ3THVidTY1L2hHaGlyd0s4NmVScUdIUFQvTWRs?=
 =?utf-8?B?YVdsMEFEekMxbS9NdWFMRWtObzZSdzRjZnFzN0ZXdWdaMndHQjgvbzBQNVQ0?=
 =?utf-8?B?a2VOSWtIQldVb0U3WHV2Z29hbHQwYTQrMlU0MjVTRExiQ2ZyVnZ1Zk1YZGEw?=
 =?utf-8?B?a1RjdDNINktQdjRtUUN1TTZBM1BCa2ZXazg0U21ERURhcXpKVm9mOHRWcllS?=
 =?utf-8?B?OG5ESDRjNFdNSlJpbEoyS0crVUU5bWpJam0zZm9XOW0wSGJjTmxUVm5hSWpP?=
 =?utf-8?B?UERSOXhGbmlRNjFqQ0VqajQ2NjRiM0tsemlwWE1WWG1jWllqOXQraVpLRitR?=
 =?utf-8?B?a0w4NTFPSWlYeUFnWElRem5uamIyNVVsdFF5RjZPb2J3Yk9EaENHNUU0cDMy?=
 =?utf-8?B?UmoxWFc0bnJJQklJNDA2VjQwLzR2YWx2SUZMSVNsT052R3hCVERjeVUvNUVx?=
 =?utf-8?B?R2c1bHNvRzZEMGJNVnJLVDJ0MmE1S3ZjZDJ1MlN5dERIWWY5M0NqWjFzT0Rs?=
 =?utf-8?B?a0dmTHdIR25RV1R2SFRDcW5idWN0eWJxWGVXaE4zZSsyQmpTTXdHQXdHMGRp?=
 =?utf-8?B?U2dqRTFESzhYRWIreU9DWThsb05mV2VSaytGUmwySVFzbEQxcFl4N2xXMkls?=
 =?utf-8?B?U1pSS1F5U1AxbmpLZ2VqNjRqNWFOMXRSSVFpR255aE85K2JhcGlkaDlEVmpI?=
 =?utf-8?B?bFlyaU1sczl4eXhYWTVvNDFPeWk0V2RaaFl1US8rcFg3bEVkczN0MnFGT0xC?=
 =?utf-8?B?SFdIeXYxOGhJKys0NmJQRGxVbmxnSlUvaWE1Yi9ORmU1RUdhNXBaSzZ6azVi?=
 =?utf-8?B?bzZ5M29oWU9sRmtRVlVNZEh0RlM5VmQwb1hrY3QxcDgrdUdIbUdUZHVBb1Vp?=
 =?utf-8?B?VkhHSjRRb1Q0dzA1SFovWUtwRGtaWFFOSWhDM1M3ZVFBT3hhZDRDOXNaOWdo?=
 =?utf-8?B?MnpJbUJ0bFd5WUZwK0djdUZzeGV2ZEMyYm1KOXNGeE5ORDU4SGJHbjB5eFFm?=
 =?utf-8?B?QzZ6dWFqM0w5S29NZUVwaGswRVpYZGNMajU3c2MvVExsK2NMUmJPSXFZY2Ns?=
 =?utf-8?B?blBoNGNMV2ZOZ2YzelhlWEFPam03WmtrYk9kOXVaRHE4V1ZSZEttS2tQLzk1?=
 =?utf-8?B?TklzK2ZBbEkrQzJNZ2MreEdZY0xvbUtlTlNhQWl5MXdNZFBBOVpPM1pHRUMw?=
 =?utf-8?B?OHgzR1N3THd6NlRjM254VHlnL2M3cnNvNTJHOFRYcWFzMmx6UXJIOUltQ255?=
 =?utf-8?B?OWhqTTI4YmN5dmhRRFovTmdWakdsZmJWRkhlT3ZxVFZUbnpINUMzYUZNenFC?=
 =?utf-8?B?aFFCYXZ6b0hsRUhlK3ZXcVVXd3FsMU9obGQzb29wWUtkYnRHOUM1bUt4MENm?=
 =?utf-8?B?NmZOaDRXa0tNaktDNUEyUjg3Q3dFeDNsL3E3VTZGSWNLdFB2VjdrYzk4eU1O?=
 =?utf-8?B?anBCZ3E3bjhWOFFJL1F1eFZWSy9XblVlQnpNaG5pVzhyc3AyY2Z0eko1NWFv?=
 =?utf-8?B?Yk1JaVhQbGFuVDZDZFNUOW1INjhkRlV4cEFJNXRIcE1GKzc5M3dnditBMG1O?=
 =?utf-8?B?cDYyK1ZBZmdsVU5JcUc1Z0VUMHJDRE1jQjlBNmpxSmZrRGtMYUJCbkMrTmR2?=
 =?utf-8?B?UXVRTzRNTllwWE5uWkJZY3hMSVJlWGI5QlFCZ3pUZysvNm1HMkhHMnUrNGZw?=
 =?utf-8?B?S3dMM3dMMVlTYjFXZkdmTE14bHNMNzdNbXEvUkk4T2t3aSttVHMyN2FyU0dq?=
 =?utf-8?B?NytRR3hDaldHcW5CelZ1WmhLUjIxS3o1WDI3TldQL2lDbStPS3JZZk5FSXhE?=
 =?utf-8?B?T2EyWkZCUHhySVdUZEtKNU5Md2tod0VvMDBPNSthenNjcEtkV3RFemJoMzJj?=
 =?utf-8?B?QkNPOW5aZXVYZkx6akVOc2N3RC9NRk13L3hxeUljaEk2eGZGT1Zub3NpSHBF?=
 =?utf-8?B?MXhxTWY0ODRPZ21IZ0IrQ1RZd3ZSN2FFbnVKNzgyVXJCRSt1N2NYeXpZa21C?=
 =?utf-8?B?T0JVZTgzaS93PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdMeFExUjBDV0J2MmFVWm5idEpoK2tsMGlEU2VqT0xzQllqbDRicFFVdmRE?=
 =?utf-8?B?ZDY2K0lhZDQwUDRWNmkyVmxiREt6VTJ2UnlZT3ZpbTRXUDh1RWE5RFBmQTBh?=
 =?utf-8?B?Vzk4S3cveFM3dExPZEFOZittMk15b2kzYTdiR1QyN1ExWTVuV0FlZlgxVnRv?=
 =?utf-8?B?WW1xMkNlWm5SMGg4OFZaM01oQjBEZVM3R2Q3YjNKcmxmTjZHUWtsOW5ub2Fh?=
 =?utf-8?B?VWlwcEUzYjA5TnVMQXNoTzhEc3lXNW5wWC9aS0JPbWp2cWF0UlByQ2hPUmdC?=
 =?utf-8?B?Z0JTWUYzeHBMMzJKSytaSktvUEdsU2hJT0VMSHZMd1l3VjFQWVVLWVFrRk8x?=
 =?utf-8?B?NlVnRDNjeER1bzEweEU5TWZNVUFCZlRteG9BR2FhMVBOd0lOZlg1eVBrbmx5?=
 =?utf-8?B?TTdXRVpSQUIwYjhMU2FRQk16Vk54MElQNTZwbUQxMDY0eUd0ZWVXcktuNzhz?=
 =?utf-8?B?YWw0ckNSZ3A4ZSt5N3d2WlhCNnczTEo4TTJKVkRMbm9ZSFZwU2VLUlcvM2Vw?=
 =?utf-8?B?dThJdW1najJUNEhxeWN0U1N6SXhhZkxYMEVnaGJCVmgvaEVaZTRCbGoxR1pW?=
 =?utf-8?B?S2NUVkFEVmxGZ1B1R3JZNEZUMmdVaUV5UVBEM0M3cFpNUHdXaERUUVdDVzl0?=
 =?utf-8?B?T2dqaXVhanRuRWhERVRUQVR3RG1vUDF4T1BQM3hsMjcxSFAwU1JOVnIyUFNn?=
 =?utf-8?B?SkNWcTlWT2ovelBKcTZmTkRDbXluSnNjUC9oT0xZL05ZMHkzM291WGphM0tn?=
 =?utf-8?B?UWd5R3pidG1COHUzN1RXOEVMWHU5dGtHTWdNd0t0UjE3QkFxVk4vN2h3Vms1?=
 =?utf-8?B?ZmRWUFBrc3oyVlplZTZJc3NQMkc1WlVEcVBmcHk2VEhDZTI0T1lBL2J2WllQ?=
 =?utf-8?B?Vzh6WE0xWm42T2hpK0tpQUIvdUY3bUYwMUY1T0tveXZ1ZlFJU2swelZsNER6?=
 =?utf-8?B?QmwrRzFLM3FBOFg5NU9jWWJsNDlsTFUxOVBobWdKL245UEFRa1o4TXpEc3ZF?=
 =?utf-8?B?T09VRWQya0RLaEhuM054U0xKNGYzUWZCS0xpeEdua20yb2RwbDFoQlJIREdj?=
 =?utf-8?B?VzlVa3pFU1N4Y3pyQU42eXRVZ3VwbG1qcDZGdjE3TnYyZVZBd1NLTUIwQXQw?=
 =?utf-8?B?bUNUMjJUS0ZnVHRLVU1aQ3h4RkhSUzRuTGFrUzVsRzdOaWx0cFYxRmVQOUxx?=
 =?utf-8?B?LzNOWTg1czdTc1l1RVlIeXErVE9hSFdreVhMRzhCNy9KbUVCRlJSZG1pZXhx?=
 =?utf-8?B?dDNySC9QdVhyMkJjZXB4UkIwaVBVTlM3TzFoOUpBT0I4K3dEODY5OWk2TkM3?=
 =?utf-8?B?Vjg4dHVoa1ovZmpOb0E3WFlkSmNBVlE5czRUaGkwOXFydDlpWXBjcnhFNTRZ?=
 =?utf-8?B?dDJMcXBEdkhNenVqM1ljNlROQ1pSVklyZGQzNElUQ21xQkJJaFJxbzhjUE1L?=
 =?utf-8?B?eWZtWjV1UGlKODJaelcxT0xYYnJGRSt2a3QramtReVBoNjRDZ1ZXQTk0ajNR?=
 =?utf-8?B?MTZPNTRpNXY2U2pvTTRRd0dBNDhMNW1FY05UL2dpTEg5S01aUTFQb3FUUDA4?=
 =?utf-8?B?b1lJaXJwR0QrTmlSN2xuSnpxWUNrZ1NMRDgxZFhBckZpdHVFd0VIUjNkUXNk?=
 =?utf-8?B?bE85d1hkSXROU3ZsZ0tWNlJWNnNtS1Era2RYUnRQcmFRdE91WHBuSG9BT2sx?=
 =?utf-8?B?SS96TnhMWXBRbVJCVSt6S3ZHOCs3R2l1VVQwVTVRZWlmRi8vaHYwa2ZtYlZi?=
 =?utf-8?B?RmZtUFV1MUl4dGh2M1lYZDd6Q3lGMU9IRUg2am1ZQkNrQ2x2V2t2dDZUODZN?=
 =?utf-8?B?SW1QaHpQc0xiUzVmS0dZbTRHTmVubXU3dS90TXV3NGFBRWZySzYyNG9iS0RT?=
 =?utf-8?B?RWgyLy9oMHdoRDMvcVZiQ25zYW8zT2x5S2JERG9EZUdYME8xMjlJV3lRRnk3?=
 =?utf-8?B?YkxIUTIxRUNpOVh1dlpDZk9TWXhETTJIbXZXcWdPd2xPdFlYRHdPaVh2dzB1?=
 =?utf-8?B?WUZtb2FMNWZVK3JTOVpQQm9YUmZ0ZU01NEV3dms3emQvY0FyMzMzWm03dGtG?=
 =?utf-8?B?aG1CaTNUUnh2RERHZkJJNjVyRU9nUmVhNlFyZDArdFRzUmVYcEIxS2JJc2sv?=
 =?utf-8?Q?Rnjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb247e9-13c6-4c10-70c3-08dd8d2cc6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:02:40.6678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlvxX9k50am9/tD3y5tODh639KKX4dI4FrZrdD+3Jq4FVeLlNQGPFzU9RKcWkJkP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxl
eA0KPiBEZXVjaGVyDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA2LCAyMDI1IDExOjU5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggNC83XSBkcm0vYW1kZ3B1L3VzZXJxOiBhZGQgZm9yY2UgY29t
cGxldGlvbiBoZWxwZXJzDQo+DQo+IEFkZCBzdXBwb3J0IGZvciBmb3JjaW5nIGNvbXBsZXRpb24g
b2YgdXNlcnEgZmVuY2VzLg0KPiBUaGlzIGlzIG5lZWRlZCBmb3IgdXNlcnEgcmVzZXRzIGFuZCBh
c2ljIHJlc2V0cyBzbyB0aGF0IHdlIGNhbiBzZXQgdGhlIGVycm9yIG9uIHRoZQ0KPiBmZW5jZSBh
bmQgZm9yY2UgY29tcGxldGlvbi4NCj4NCj4gdjI6IGRyb3AgcmN1X2RlcmVmZXJlbmNlX3Byb3Rl
Y3RlZCAoQ2hyaXN0aWFuKQ0KPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogU3VuaWwgS2hhdHJpIDxzdW5pbC5raGF0cmlA
YW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KPiAtLS0NCj4gIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
X2ZlbmNlLmMgICB8IDQwICsrKysrKysrKysrKysrKysrKysNCj4gIC4uLi9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmggICB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
NDEgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiBpbmRleCAwMjljYjI0YzI4YjM4Li5jZTBkMDZhOGM0
OTk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnFfZmVuY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnFfZmVuY2UuYw0KPiBAQCAtNjcsNiArNjcsMTQgQEAgc3RhdGljIHU2NCBhbWRncHVfdXNlcnFf
ZmVuY2VfcmVhZChzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAqZmVuY2VfZHJ2
KQ0KPiAgICAgICByZXR1cm4gbGU2NF90b19jcHUoKmZlbmNlX2Rydi0+Y3B1X2FkZHIpOw0KPiAg
fQ0KPg0KPiArc3RhdGljIHZvaWQNCj4gK2FtZGdwdV91c2VycV9mZW5jZV93cml0ZShzdHJ1Y3Qg
YW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAqZmVuY2VfZHJ2LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgIHU2NCBzZXEpDQo+ICt7DQo+ICsgICAgIGlmIChmZW5jZV9kcnYtPmNwdV9hZGRyKQ0K
PiArICAgICAgICAgICAgICpmZW5jZV9kcnYtPmNwdV9hZGRyID0gY3B1X3RvX2xlNjQoc2VxKTsg
fQ0KPiArDQo+ICBpbnQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9hbGxvYyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJxKSAgeyBAQCAtDQo+IDQwOSw2ICs0MTcs
MzggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2NsZWFudXAoc3RydWN0IGRtYV9m
ZW5jZQ0KPiAqZmVuY2UpDQo+ICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiAgfQ0KPg0K
PiArc3RhdGljIHZvaWQNCj4gK2FtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfc2V0X2Vycm9yKHN0
cnVjdCBhbWRncHVfdXNlcnFfZmVuY2UgKmZlbmNlLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50IGVycm9yKQ0KPiArew0KPiArICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJx
X2ZlbmNlX2RyaXZlciAqZmVuY2VfZHJ2ID0gZmVuY2UtPmZlbmNlX2RydjsNCj4gKyAgICAgdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gKyAgICAgc3RydWN0IGRtYV9mZW5jZSAqZjsNCj4gKw0KPiAr
ICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmZmVuY2VfZHJ2LT5mZW5jZV9saXN0X2xvY2ssIGZsYWdz
KTsNCj4gKyAgICAgZiA9ICZmZW5jZS0+YmFzZTsNCj4gKyAgICAgaWYgKGYgJiYgIWRtYV9mZW5j
ZV9pc19zaWduYWxlZF9sb2NrZWQoZikpDQo+ICsgICAgICAgICAgICAgZG1hX2ZlbmNlX3NldF9l
cnJvcihmLCBlcnJvcik7DQo+ICsgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZlbmNlX2Ry
di0+ZmVuY2VfbGlzdF9sb2NrLCBmbGFncyk7IH0NCj4gKw0KPiArdm9pZA0KPiArYW1kZ3B1X3Vz
ZXJxX2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHN0cnVjdCBhbWRncHVfdXNlcm1vZGVf
cXVldWUNCj4gKyp1c2VycSkgew0KPiArICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmID0gdXNlcnEt
Pmxhc3RfZmVuY2U7DQo+ICsNCj4gKyAgICAgaWYgKGYpIHsNCj4gKyAgICAgICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNlICpmZW5jZSA9IHRvX2FtZGdwdV91c2VycV9mZW5jZShmKTsN
Cj4gKyAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAqZmVuY2Vf
ZHJ2ID0gZmVuY2UtPmZlbmNlX2RydjsNCj4gKyAgICAgICAgICAgICB1NjQgd3B0ciA9IGZlbmNl
LT5iYXNlLnNlcW5vOw0KPiArDQo+ICsgICAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX2Ry
aXZlcl9zZXRfZXJyb3IoZmVuY2UsIC1FQ0FOQ0VMRUQpOw0KQXMgdGhlIHVzZXIgcXVldWUgZmVu
Y2UgdGltZSBvdXQgaW4gdGhpcyBjYXNlLCBzbyB0aGUgZmVuY2UgZXJyb3IgaGVyZSBzaG91bGQg
c2V0IGFzIC1FVElNRURPVVQ/DQoNClRoYW5rcywNClByaWtlDQo+ICsgICAgICAgICAgICAgYW1k
Z3B1X3VzZXJxX2ZlbmNlX3dyaXRlKGZlbmNlX2Rydiwgd3B0cik7DQo+ICsgICAgICAgICAgICAg
YW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9wcm9jZXNzKGZlbmNlX2Rydik7DQo+ICsNCj4gKyAg
ICAgfQ0KPiArfQ0KPiArDQo+ICBpbnQgYW1kZ3B1X3VzZXJxX3NpZ25hbF9pb2N0bChzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGRybV9maWxlICpmaWxwKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmgNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuaA0KPiBpbmRleCA5N2ExMjVhYjhhNzg2
Li5kNzZhZGQyYWZjNzc0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuaA0KPiBAQCAtNjcsNiArNjcsNyBAQCBpbnQgYW1kZ3B1X3Vz
ZXJxX2ZlbmNlX2RyaXZlcl9hbGxvYyhzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVf
cXVldWUgKnVzZXJxKTsgIHZvaWQNCj4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9mcmVlKHN0
cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJxKTsgIHZvaWQNCj4gYW1kZ3B1X3VzZXJx
X2ZlbmNlX2RyaXZlcl9wcm9jZXNzKHN0cnVjdCBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyDQo+
ICpmZW5jZV9kcnYpOw0KPiArdm9pZCBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZvcmNlX2Nv
bXBsZXRpb24oc3RydWN0DQo+ICthbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJxKTsNCj4gIHZv
aWQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9kZXN0cm95KHN0cnVjdCBrcmVmICpyZWYpOyAg
aW50DQo+IGFtZGdwdV91c2VycV9zaWduYWxfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwg
dm9pZCAqZGF0YSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fZmls
ZSAqZmlscCk7DQo+IC0tDQo+IDIuNDkuMA0KDQo=
