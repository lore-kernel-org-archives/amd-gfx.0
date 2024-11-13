Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3740D597C7
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 02:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6DD10E327;
	Wed, 13 Nov 2024 02:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g7hseZMZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E2310E327
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 02:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bunA5//X6Mbfm7I2rK5/JtneadCnI2QACW0SulEn1GF8C5hyrGy+VRSb9+nVUNzolFP26BI4gM9d9rfBnB9v/zo6dBrTJCO7r3zLtDD8varJM8ulVMNZ5chVTwS7jWFX7eOebH9men8tvrQ/dh0QymAZ3QSPUXNw94eEiGUxG+IZRsHfnpz7FT6RmgkgNNIoQQ0SiMknLVYcI3gX+8i/okQfhaRZbLQHeO3fUAw4w9Z+XVqpPe4KbIklURnTyhAYv+sy66oUStTAKxXEGdXkKOl3ml75koxv2mQ6SLjyUTIVZyc3t2CAKEhfqvx6jCqLAblZC4Nl2wGaEJf8iucEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDY9F3RBTvB+uKSb9DYy+iqTZU1MeF+vlhudd5cEykA=;
 b=QbzunkRncBcN4JCfFMe+fUcoZax5fVx1INnOl+DGgvrs+xhCFB20GEztFef3Qwx29yf2/NGITYv0wmVvc5bsNzsQUxwVPBvMHGKh2Rqs5vsIRgJOXG1tAgFyj714kNc6cTEbE08+xsDqfQNK3tKtVtb9TkiDbUG1tfOxnE4RUmk8Fil/t/zDPmI7fUMMN2/g07cyB/VVQiBBfjjK5yZpU26hWXk875YX/nU96M3aRRYTjA4/ns9aOJT+lE/uE5DrG6u6zSaBPm5ofb+bEY2vMZNjDrKK3woIOqrF89xjEFkVl8SeHpKmYH2PBfLVX/RDkXpCnYDG8KGRzIxDYVuREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDY9F3RBTvB+uKSb9DYy+iqTZU1MeF+vlhudd5cEykA=;
 b=g7hseZMZsQ9biJyqBxl4vvIGPgFQrqANYfUrVBG4oH6uowpp2+tqyM0AbJnHvp1xwUBbWVlLMPHl2nmIJfWvtBkrEC8P/8O6vAczaFKk15saVmyCr4c0O/+fraYy/1t0+SbppWGFT/H3oNKfM33+TnJHtI2lbUD20JWPlHYXSjE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 02:28:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 02:28:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
Thread-Index: AQHbNQ99LrE8j9qFyUWjXx01qON3ZLKzu1iAgADAVEA=
Date: Wed, 13 Nov 2024 02:28:25 +0000
Message-ID: <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
In-Reply-To: <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5102c2a4-530d-4752-a817-6f7f1c2556fe;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T02:22:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BN5PR12MB9461:EE_
x-ms-office365-filtering-correlation-id: ea29c7a6-195c-459d-4e48-08dd038ada35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUJ5aDRIUEViVUY5L0pBOHNybE1jQ1JVQjBFZlZZQnVjWVR6Q0IwcnRTaDFk?=
 =?utf-8?B?V2RRVzdHTGsrTElrdzVzWU1oZVd3VzIyRTBtWVN5VUlHK2VwUExyM0h3c3lP?=
 =?utf-8?B?MzdoZU4rZXVZa1pqd3lxTGx4Vlp1SUUyOGtZYmp1NzIzUnJjR0ovdmN4K0l4?=
 =?utf-8?B?M0pJRVNsaUlBbFRobFpveHhwY25hMFUzY3N5Sk9INUF6cEptWVlqRFVrMm1u?=
 =?utf-8?B?bVB5NDhFM1k0MTFlR01KZEpoUFRudE1IK0Ztb3RkNDNhYjY0WGZjWmo1aUhy?=
 =?utf-8?B?NWtoY3NWbUtXZlZxeFVNdEdxRTBYUk4vYWdpUHVuajVTWmJuVWo4YmdHVmc3?=
 =?utf-8?B?aXo5eUVkMXIrYkwyVVAvTFVGdFdpSDBBN0ExbDB2Sld3bTFFVXJ5ck9vSFZH?=
 =?utf-8?B?djBBbGZXTGJ3dGJLL3Y2WERIelhMV0JZMUU3WTFidm85NlpTWUUzbXU1eGlQ?=
 =?utf-8?B?SlNJVEwvQmlsRVlzRW1NcWYrOEpneGd6aCs1cGhyaUlWRkZOWFZSWkY2azV3?=
 =?utf-8?B?bWtoZjFZbXQ1cHVqQ3ZINlBERGk5enFUc0Y2R2F2KytOWEhwbHNaS0RFYXJE?=
 =?utf-8?B?ZmVjOEg1VzNLR2lHSkozUjBEdWxIVHJaNm5WdWpvWjlaUFlERlJMMXFpbFNi?=
 =?utf-8?B?eDE2QlArQWYrODQ5VmdGUkVEdWg3eTVrS0hzS3JlRlJleU9iZFp4bWJscmpN?=
 =?utf-8?B?RjU1R2FuVDk1YnNZQmIvejl2VVhVREhMcEM3MnFyRGFHMnZSZmRjVXVKNkdm?=
 =?utf-8?B?ZDFKVVJKaG1FRXJDbkxkY2RjQUFKSjZiUnBwNVJJMmtweUc2bHVtOUdrUE1o?=
 =?utf-8?B?K1BKZm43dGRvdDNCVmtRUkZmMldVQUpzNVVaeS9MZm1mazBJS0U3NDY3NjBu?=
 =?utf-8?B?M3h1U0kvME5OaWRPRVFvdVZrNUNnM1h3STUxWVF3NXdGeVowbU0zS1AxQVdK?=
 =?utf-8?B?TFR2c0VEVUVqTVNad3MvVkx3L1dCd3VKS0haOFZFTVVXUHJGMi9vZ3Q5UHlE?=
 =?utf-8?B?RzRrUWViUHhDWUs2OXpXUnZHMjhEYy93TXNXdG01Q1Z5ZVB4NjVjM3QrLzU0?=
 =?utf-8?B?M29vZ1BmV1A1MUQ3T2tVcS80QVBWYTYwMm93dWNUdkp0Q3gxMFJIeWQ2RTZt?=
 =?utf-8?B?akF5dy9XbTFYNjZKK05McE9iWDdLUzZjbzNwZkk2TVlrYnFRRDJmc2wzeXBU?=
 =?utf-8?B?ZVJNR1VYbm40Rnl0QTBLVGxZM2I1Mnc0Y3dzUkVweVM4ZGUyeC8vYlpsMHZI?=
 =?utf-8?B?NlM1cm9oTzM3UzNiVUpTQ0NoVVBjSHRIcVhRc3VmRTRmNVNabXE5aGpGaWVW?=
 =?utf-8?B?SzB5eGlLZUVzWm42UnZWOEs2TW9nREpZMnU2NnpWemgwUU84RkdjNWVKQXFU?=
 =?utf-8?B?Wm1ITlpyZ054TVU5Z3FUOFFPK29SNVQ4YTh6TktrUDRuN1FYTEVsNG13NkVT?=
 =?utf-8?B?SG9rYmhLNXdEWndPVTJFb29GWmpOZlJ1aCtSLzcrZ2NtbnJNUEVPVlVOYnRU?=
 =?utf-8?B?b1UxVkJUOHp2WW1qdlgyMjJsdWpBaGoyU3VCQXZHZTZoWXdOS09QdmNERUNx?=
 =?utf-8?B?b2VsRm9JOFllWlg0NGdWKzRoQzBUaXdkSnZSQ0owSXlCUEs5Z2kzb2ROOXhY?=
 =?utf-8?B?RHNCNzdud0ZRdFJ0NGtxMnFRQlF5R1lmZUVCdmJPaVdxSVNjbmo0NDdtcXNK?=
 =?utf-8?B?NUlwSll6M2dwMDg1NFh0dUlVSzNGbkFIL042ZVE3c0Z1K2diOUt3Y0V3Zm45?=
 =?utf-8?B?bW5pbUxRMjVLdDhHZUl4N3V5V2hkY3kweWIvYThiT0RzVWVkZTFSUTlpVmdE?=
 =?utf-8?Q?zn6xHX58V12P3XXrmBoeFT1PuQPh6B58y/CIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzZnYmJoMFlvaEYrUStXT2lqMFRjVUpkcnovdEx3V09vUE96M0RVR3NjVXN1?=
 =?utf-8?B?TGIxTXJCSmt0NzJYTFR5Um9YaVRDcERMSTVQTFlQUDlKeXZRcjkzYlAwd2to?=
 =?utf-8?B?em1vU3kwNjQ2REw5RWJoRyt3OEo1SXNtOGZkaFlScWFEOE9obnJ1aU16aVJU?=
 =?utf-8?B?VjRHcG5CUzhkOUpHMDlwaGtOaE1kZTlscE9vVE1YdEwvdXhUU2NPeTFYVng0?=
 =?utf-8?B?UzZNNHgrUXVWWUlMV0RNM0VYcGpGVGgzb29VV2UzU3pEaEdLZU1SeFBQeFRu?=
 =?utf-8?B?eEVpTTh0d2lhaXNnVjNxRDdFZXg0RXd1SXJmeWQ1OE54ZzdBVkVJc0pDanNK?=
 =?utf-8?B?MmZUZUxLdjM4ZWplOHdqOU16UDBZV1NxaHdjMU5HZ2RIdU0vWTNZN3VPT21J?=
 =?utf-8?B?RUNES0J4Uk1GTDFKNnFydnZTa2grSzNVUnVPODlUVEdyV0pXTjZ3Z0N1anJK?=
 =?utf-8?B?Rlg2SWFDYk9vU2x6djFyRllacDNLRGtrdU0wcTJsRVVSTXJpZHdnNmdSS0NT?=
 =?utf-8?B?ZXdtc3JTcXl1azNUb3F1OHEvdUhNNE9YcCtEa1M4bVdreS9LTUJZdm1MVytS?=
 =?utf-8?B?Ni9hMW5hQURpVytwMDJMbzhIY0NSaHdkWHI1Um4xYWRhNHdkTUVUQzd2cUdL?=
 =?utf-8?B?bDVscDZDQzBUSGRmYnlVcTZwYVY3dXZPeCtaR09kOTJaOHB6Q1dORE9LVzE0?=
 =?utf-8?B?WjlNeEp2YVNYcHliQnRnQWlzYzAvOVVvL0YvQXJ4VGRFSUduaEo5elBsRkFl?=
 =?utf-8?B?ZmtDMUEwU1FCQU5IYjNIQ2wrU3dMamlxWTRKOWJ0UXQ0VmdXOXhqb09saUFR?=
 =?utf-8?B?N0ZsS2kzdWgvbmZTT1BvajhLTU1sR2tRQWxFd1V5NUppVjZ6bFl6WDBpaW0z?=
 =?utf-8?B?eVh4TmlCSElZTzJJRHo0a2kva2trRzY3Y24yM29pM29PRnRjTldqMGVkcWJM?=
 =?utf-8?B?WG5OV1luY2svM0JjaVF2am1wUXJVeEQ4MytkOHlFNlVxc2hYbk5OSStpNTRW?=
 =?utf-8?B?SUdKU0NoejZCQ3QrVEpNSlV6ZnBzQmVNUlBQYjg3enpMbFI2Q0hqbWdkRnR3?=
 =?utf-8?B?b2gybUhwcERLanpIMW1xdnlyZE1aLzc1NVY4akdlMjdmSEdXemx4MWZMeWMx?=
 =?utf-8?B?M3QzTGFhbGtEMWl2MGNiME53N0JaTjVvQUJERjBaYW5xMnc2b0dwbDVsYnlC?=
 =?utf-8?B?M2FGVGQrWTJwT2x3U2xLaUw5d0krV3hPWG15ajNQNHJTbFZBSVlWaDRJbHB3?=
 =?utf-8?B?d1M3OEJtSlZOL0ppZGdlRUdmVEVRQVlGZHpXT1NRbVp2U1RSR21iOWNUK0hp?=
 =?utf-8?B?V1Z4VSszdTdLaGcyNUdYK0Z1MDZLeGZ3Sm1UYWtlM0hKa2ZYUlY4V3lyY1pJ?=
 =?utf-8?B?dmhEd3V1T0xDelJQeVhJUnZOOGNqdHViK0NFeEkyeU1Hb0I2OWZKd1pOdy9m?=
 =?utf-8?B?VlNuYjNGQ3ZFdXhrMWZBTGNCMnF2VFJaOXY5WXdxREd0TmIrSENFb3A1WmVC?=
 =?utf-8?B?L3orS0M4WUZ4RkJuOWdVOFhVa2gxaERIWlRPakJBUy9rckhubFE2NXlZTzVY?=
 =?utf-8?B?S3kyTDJkZU1EK0t6TGM5VWxtOEVsbkhubGVqMjVwU2cyQTJFOTB6UE9PTnZu?=
 =?utf-8?B?RFNuaE04a3BRRUFCaTBXRWhjWUtOekZWYkhiVzIzanUwd0RrcVIyUnNrZkln?=
 =?utf-8?B?eVZFT3VrOHJhU3NsMVhlelJ2SmF6VFFqYWcwdlNkMlQ4d1RraHJodUp2eHRu?=
 =?utf-8?B?Ky9YYWxlTnpEWlo5VnJtUXRSM2VpaUoweHo3UXNjQW8wS3V6NENWY2xTNS9s?=
 =?utf-8?B?WUxBMTRFWFI4bmNnR2h1RVpGNG5nbDhBTHYzNU13TjM4RzhyWWt2YitGTjlu?=
 =?utf-8?B?WFE1aE1kVW83SWNOYlM1KzkyMXFzSUpnQXR3TFYrN2p5YVMrMFNhbms4N25s?=
 =?utf-8?B?bENLV2tXQWplSEtZWVNwNlF5K0l2OFVST3ZZSmtCRng2eWFVVDNRWUdNdzIv?=
 =?utf-8?B?NFFSS0JXSGUxNUJVcTA5cXpacC9PUUhYVjVUYjZCRlVMa1VhV2RITStUWERk?=
 =?utf-8?B?cVoxVktzVG9RNVUrMzZnUnE4TTA1bGFlekFBLzg0bU03Sys3V1VuQi9YRlFG?=
 =?utf-8?Q?eXc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea29c7a6-195c-459d-4e48-08dd038ada35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 02:28:25.7314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zp7UoC43EGW4E6azQgBAOpw+emTaK2X5DLFfl6qkX5kAg1p72aK/qkpVHv/Ex8G1MYmPaHE6lfhXEgVRR+0CoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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
Cg0KSGksIExpam8sDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIw
MjQgMTA6NTQgUE0NClRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IFByb3N5YWssIFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT47
IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IGRybS9hbWRncHU6IGZpeCB2Y24gc3cgaW5pdCBmYWlsZWQNCg0KDQoNCk9uIDExLzEyLzIwMjQg
ODowMCBQTSwgSmVzc2UuemhhbmdAYW1kLmNvbSB3cm90ZToNCj4gWyAyODc1Ljg3MDI3N10gW2Ry
bTphbWRncHVfZGV2aWNlX2luaXQgW2FtZGdwdV1dICpFUlJPUiogc3dfaW5pdCBvZiBJUA0KPiBi
bG9jayA8dmNuX3Y0XzBfMz4gZmFpbGVkIC0yMiBbIDI4NzUuODgwNDk0XSBhbWRncHUgMDAwMDow
MTowMC4wOg0KPiBhbWRncHU6IGFtZGdwdV9kZXZpY2VfaXBfaW5pdCBmYWlsZWQgWyAyODc1Ljg4
NzY4OV0gYW1kZ3B1DQo+IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBGYXRhbCBlcnJvciBkdXJpbmcg
R1BVIGluaXQgWyAyODc1Ljg5NDc5MV0gYW1kZ3B1IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBhbWRn
cHU6IGZpbmlzaGluZyBkZXZpY2UuDQo+DQo+IEFkZCBpcnFzIHdpdGggZGlmZmVyZW50IElSUSBz
b3VyY2UgcG9pbnRlciBmb3IgdmNuMCBhbmQgdmNuMS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSmVz
c2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF8zLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF8zLmMNCj4gaW5kZXggZWYzZGZkNDRhMDIy
Li44MmI5MGYxZTZmMzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92NF8wXzMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRf
MF8zLmMNCj4gQEAgLTgzLDYgKzgzLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2h3
aXBfcmVnX2VudHJ5DQo+IHZjbl9yZWdfbGlzdF80XzBfM1tdID0gew0KPg0KPiAgI2RlZmluZSBO
T1JNQUxJWkVfVkNOX1JFR19PRkZTRVQob2Zmc2V0KSBcDQo+ICAgICAgICAgICAgICAgKG9mZnNl
dCAmIDB4MUZGRkYpDQo+ICtzdGF0aWMgaW50IGFtZGdwdV9paF9jbGllbnRpZF92Y25zW10gPSB7
DQo+ICsgICAgIFNPQzE1X0lIX0NMSUVOVElEX1ZDTiwNCj4gKyAgICAgU09DMTVfSUhfQ0xJRU5U
SURfVkNOMQ0KDQpUaGlzIGlzIG5vdCB2YWxpZCBmb3IgNC4wLjMuIEl0IHVzZXMgb25seSB0aGUg
c2FtZSBjbGllbnQgaWQsIGRpZmZlcmVudCBub2RlX2lkIHRvIGRpc3Rpbmd1aXNoLiBBbHNvLCB0
aGVyZSBhcmUgbWF4IG9mIDQgaW5zdGFuY2VzLg0KDQpJIHdvdWxkIHNheSB0aGF0IGVudGlyZSBJ
UCBpbnN0YW5jZSBzZXJpZXMgd2FzIGRvbmUgaW4gYSBoYXN0ZSB3aXRob3V0IGFwcGx5aW5nIHRo
b3VnaHQgYW5kIGJyZWFrcyBvdGhlciB0aGluZ3MgaW5jbHVkaW5nIGlwIGJsb2NrIG1hc2suDQoN
CklmIHRoZSBzYW1lIGNsaWVudCBpZCBpcyB1c2VkLCBpdCByZXR1cm5zIC1FSU5WQUwgKGJlY2F1
c2Ugb2YgdGhlIGZvbGxvd2luZyBjaGVjaykgYW5kIHN3IGluaXQgZmFpbHMgYXQgc3RlcCB2Y25f
djRfMF8zX3N3X2luaXQgLyBhbWRncHVfaXJxX2FkZF9pZC4NCg0KYW1kZ3B1X2lycV9hZGRfaWQ6
DQppZiAoYWRldi0+aXJxLmNsaWVudFtjbGllbnRfaWRdLnNvdXJjZXNbc3JjX2lkXSAhPSBOVUxM
KQ0KICAgICAgICByZXR1cm4gLUVJTlZBTDsNCg0KUmVnYXJkcw0KSmVzc2UNCg0KDQpUaGFua3Ms
DQpMaWpvDQoNCj4gK307DQo+DQo+ICBzdGF0aWMgaW50IHZjbl92NF8wXzNfc3RhcnRfc3Jpb3Yo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiBzdGF0aWMgdm9pZCB2Y25fdjRfMF8zX3Nl
dF91bmlmaWVkX3JpbmdfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIGludCBp
bnN0KTsgQEAgLTE1MCw5ICsxNTQsOSBAQCBzdGF0aWMgaW50IHZjbl92NF8wXzNfc3dfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgaWYgKHIpDQo+ICAgICAg
ICAgICAgICAgcmV0dXJuIHI7DQo+DQo+IC0gICAgIC8qIFZDTiBERUMgVFJBUCAqLw0KPiAtICAg
ICByID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfVkNOLA0KPiAt
ICAgICAgICAgICAgIFZDTl80XzBfX1NSQ0lEX19VVkRfRU5DX0dFTkVSQUxfUFVSUE9TRSwgJmFk
ZXYtPnZjbi5pbnN0LT5pcnEpOw0KPiArICAgICAvKiBWQ04gVU5JRklFRCBUUkFQICovDQo+ICsg
ICAgIHIgPSBhbWRncHVfaXJxX2FkZF9pZChhZGV2LCBhbWRncHVfaWhfY2xpZW50aWRfdmNuc1tp
bnN0XSwNCj4gKyAgICAgICAgICAgICAgICAgICAgIFZDTl80XzBfX1NSQ0lEX19VVkRfRU5DX0dF
TkVSQUxfUFVSUE9TRSwNCj4gKyZhZGV2LT52Y24uaW5zdFtpbnN0XS5pcnEpOw0KPiAgICAgICBp
ZiAocikNCj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4NCj4gQEAgLTE3NCw3ICsxNzgsNyBA
QCBzdGF0aWMgaW50IHZjbl92NF8wXzNfc3dfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2lwX2Jsb2Nr
ICppcF9ibG9jaykNCj4NCj4gICAgICAgcmluZy0+dm1faHViID0gQU1ER1BVX01NSFVCMChhZGV2
LT52Y24uaW5zdFtpbnN0XS5haWRfaWQpOw0KPiAgICAgICBzcHJpbnRmKHJpbmctPm5hbWUsICJ2
Y25fdW5pZmllZF8lZCIsIGFkZXYtPnZjbi5pbnN0W2luc3RdLmFpZF9pZCk7DQo+IC0gICAgIHIg
PSBhbWRncHVfcmluZ19pbml0KGFkZXYsIHJpbmcsIDUxMiwgJmFkZXYtPnZjbi5pbnN0LT5pcnEs
IDAsDQo+ICsgICAgIHIgPSBhbWRncHVfcmluZ19pbml0KGFkZXYsIHJpbmcsIDUxMiwgJmFkZXYt
PnZjbi5pbnN0W2luc3RdLmlycSwgMCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEFNREdQVV9SSU5HX1BSSU9fREVGQVVMVCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZhZGV2LT52Y24uaW5zdFtpbnN0XS5zY2hlZF9zY29yZSk7DQo+ICAgICAgIGlmIChyKQ0K
PiBAQCAtMTczNCw5ICsxNzM4LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lycV9z
cmNfZnVuY3MgdmNuX3Y0XzBfM19pcnFfZnVuY3MgPSB7DQo+ICAgKi8NCj4gIHN0YXRpYyB2b2lk
IHZjbl92NF8wXzNfc2V0X2lycV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50
DQo+IGluc3QpICB7DQo+IC0gICAgIGFkZXYtPnZjbi5pbnN0LT5pcnEubnVtX3R5cGVzKys7DQo+
ICsgICAgIGlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBpbnN0KSkNCj4gKyAg
ICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAgICAgYWRldi0+dmNuLmluc3RbaW5zdF0uaXJx
Lm51bV90eXBlcyA9IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzICsgMTsNCj4NCj4gLSAgICAgYWRl
di0+dmNuLmluc3QtPmlycS5mdW5jcyA9ICZ2Y25fdjRfMF8zX2lycV9mdW5jczsNCj4gKyAgICAg
YWRldi0+dmNuLmluc3RbaW5zdF0uaXJxLmZ1bmNzID0gJnZjbl92NF8wXzNfaXJxX2Z1bmNzOw0K
PiAgfQ0KPg0KPiAgc3RhdGljIHZvaWQgdmNuX3Y0XzBfM19wcmludF9pcF9zdGF0ZShzdHJ1Y3Qg
YW1kZ3B1X2lwX2Jsb2NrDQo+ICppcF9ibG9jaywgc3RydWN0IGRybV9wcmludGVyICpwKQ0K
