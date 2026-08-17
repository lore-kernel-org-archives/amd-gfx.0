Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82CFC5CFC1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 05:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF5B10E63D;
	Mon, 17 Aug 2026 05:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ip4QCWBJ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277B510E63D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 05:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoLtUSwZBP/vEwmRvsOFA5aHxk/BbQcFT9EFTLaAGRngvjUysjWjuzKB4WuTsELS1YrsFFPGUrZiITYNjZCmRPOpcMnH/4Iq2mHuw4cqx/KXZu4m4T2S5Owt1pYzZGk6nJwx0h/Nr7r39glv8Rgmz109qEytJNyVokR75AEgjQdsqKKDA5q2JntN4BxbOshR4Nj9h06nBFmM5AAIyGyufswV/+NbEcmv33uN7CuR7iaowQMpfSRnDAYdxTiMdtwKuh51YY3HkPPcxOIa/lKejCLiNIPRCBrqwbo8NPACLs9HWITNAqEzZW4YnYK2LjoHjdNoop/RprjoBizioq9Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx2qlfH035sxOTLdhohZQwh15gU/SCSACgYBceSrmDI=;
 b=YQgwPzZhroKLBJGgQdw9ma7Qafh/gnMUhrodiOyB4PnVibWthlS5pBIPXVg8YpG9s0XaaP3VJLEXe7iKK0UYyF2Sogt3ab/XLzyPSUnbfhYA4TjxBP4no7jmCjCF1HoJ2cJ/6j4tnR7557yz13SEX0Z83ErT6RvqfTCGdrxXvCRnXjP5WewegrQh7+DNxcJAIe8vJmAMagWh3liKbsot8/xvn0xC3RfWT+G9kwIOH3GxMPpEjigo7qMn95Wk+JEoPs0ynqd68HwpHGMNWXBsSgWNXd3XA5XxlUJz4aOKhTAtJsXeblulh+2w7drTKNAKdqcwfL4haGsWHMDIewI6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx2qlfH035sxOTLdhohZQwh15gU/SCSACgYBceSrmDI=;
 b=ip4QCWBJDEGpUzf1XLp78spfYVOC4CZ2vjGU1KfdaX0bwAl9X+a4OyH0/TBvqxecd2Gr67bX0iglGsX565J/Bb1GAfGG4fhK5uFNrFWfWdgIf4QezpuRXBpPSpySDPxW9UEuvehsnaoLzdqt6It+hLsaW+YNW+OdiZpmSNSphdY=
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:23:00 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:23:00 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Hosur, Priya" <Priya.Hosur@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Thread-Topic: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Thread-Index: AQHdKuaQL91mPPiWwUSDLepzFDHJIracVsYAgAVkTbA=
Date: Mon, 17 Aug 2026 05:23:00 +0000
Message-ID: <PH7PR12MB7794CFDCDCBDB3C253207DDB93A72@PH7PR12MB7794.namprd12.prod.outlook.com>
References: <20260813054220.450509-1-Priya.Hosur@amd.com>
 <20260813054220.450509-2-Priya.Hosur@amd.com>
 <CADnq5_Mge5MoNRyf0Nnynx5M=V2HKN8L-pFXV88GnLzAfOL5dw@mail.gmail.com>
In-Reply-To: <CADnq5_Mge5MoNRyf0Nnynx5M=V2HKN8L-pFXV88GnLzAfOL5dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-17T05:22:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7794:EE_|CH1PPF84B7B0C96:EE_
x-ms-office365-filtering-correlation-id: bacca770-6349-4166-792b-08defc1f9abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|38070700021|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: eMyRaZw2ZBPolmU/mTRlO9ksQJO6X5IAyuUc4EHQXMG2a5WMiHfbOOMKMMNekKDyaZbvKxlsn1pMwTh0IBocw6kIMBnB37km7nimZgYbKSkKbAteiEUHuy299nNFR7dGWppeoMEIY3m9+4yPorgZDUFbyIIJFdpQN/nkXk0lFgJPNbU1+3K1No0BI2yZdknby5wAj4RHdvH3YUlV5fcj5X5gDdFUi+xRRDEuZ4bxj484u0ZK/Owx2s2LeaJQA61ano5LXM2MpV6wvqT2Df6JtLLOvm4xgMIo4V9ZHjTbQwqA4w3ps+bvEeisebYkPhrm91Qi/lMw2cXBurIZxoBCzUrQQP96VjmxFJEKscoC8+SV7WBWkbYPE/9t7qAIN0+eiMzLG4FtiSD0DRj/DT0uECvwKqkLZnwNErniWSl/4ZZSVzPoAP6chOFKF+j8eWVhmMjEyN6eaa3lep8Z1g8Ko2AxLFMMfwoVGTTKWSwle1nOR8OYVeWcCyWwL6ioWOWBKh6yUHa97WR1qicj1uM2q0OGn6gKg8l8xx+y3Zfvfpr4v+BJRA8lqxjttF3aF6349aO4XsdFmXyszZl6a1Ff4Oh2zWLYRoBpKvLPr1/H1nx1Ou49Yr02w/Rj/gynlL80peP5CtXtbWaMrmHNAp8cY2DXQvKG61+uAhyJCmYzhON7Edu4rlj93lDbEYJ1vWWLiUqXDpMZ8N3ZiyN6F+KxbDTFRW8dUqBVsNZ5Wk3iO3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(38070700021)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Szc3aXM5NWN1WTVWNjFIejJQSVBXZitRN1ZYbU5Jek1Wem5sVTNrZXFqMUU2?=
 =?utf-8?B?b29VREVNT2EyT2w1b1pTOVdBZTdNbm5PYVNPd0ZIa2FlZUwzMGJZN0ZWTHFx?=
 =?utf-8?B?Y1BvUlhaejR0NGx3NUwxMytLWnlTSjd5VFpka0dnVEZHblZjc3FYU0pIcDZj?=
 =?utf-8?B?a0hHaTFyOWtWVTZOZm5mLzZreklHTmZGQUZjU0V3OGhvWm5KZEMxNDVEc011?=
 =?utf-8?B?TVB6Y0JqVXZyUVV6cFhMNGtSVS90V3k4WmJHSXFKVlZ6cUxpbG9nVHNYQTFu?=
 =?utf-8?B?MVdScEphdk9XYTNoa0R6dThlWVFranYxQUhZby9za3NtOUh0RVYwbjZ4RDla?=
 =?utf-8?B?Y2d4RXgzQWlzMFJhcGNhWmNUakxENUtDRG1nVkFIV0VWNVlvNk83b1NKTmJx?=
 =?utf-8?B?RXhNbXVRZ3gyT3ZqVFNkSDQxaHVOdGtTaFRXRmc1STVUd3RzMlRFSkNZNE81?=
 =?utf-8?B?VEJuaDVQTnJVN21TNXM5SFZOY0twY2lLQkV0SFVtR2Z0YlpZQktQRzZYQU9D?=
 =?utf-8?B?bDNGblk0SCtaS01uT1V6SjI3SWU5c3BOSU9Wc21KZkRpSWZqOU10NW42VHBl?=
 =?utf-8?B?OGlpSlZ2QjlvWWhFZ3lXRXdDQ3NOSXk0TkxjSEtyU2R5MFE5TURJZzB3U3Zs?=
 =?utf-8?B?SUN4dEc2TTFCcG45SGZPMk9vMGFUdTBUKzdXcDY1UDhLQlVnT2wxOUcyY1lq?=
 =?utf-8?B?MHNOeHdKU1hoaFR3R3hhdXNCS1NMNWV1TWZsbitwQXRLaWpWbkVieHo4MGtQ?=
 =?utf-8?B?aUFkY3RvSDR6T01ucjZRcHZtVE9GRmVQL1R1eGk2eGlNMzV1dTEyeUkyOHIv?=
 =?utf-8?B?MUdLVm1hd1lhS09QS05IcjJLd0tnbmNrbEMvWmhCbE0rS3VicHkzNWZxc2xT?=
 =?utf-8?B?blhFM3ZBaTFvdFhyRzRCTzF6UVpPcGpKTjh1RGVxUmhMTVJpMGpkT1Y5MUVh?=
 =?utf-8?B?RnNRdHM4amlPYllYZzNZR0VvQ0tyQ1o4TVlYY2NaWjJ0QWY0K0tsRzQyQnpD?=
 =?utf-8?B?ODNJZStkT1h6dENDbnREMmVHdFoyWjMyRUNTSndGRHhqQ1JCVTMxL0lyNWNX?=
 =?utf-8?B?YlZHVU13OGZFL0VmNDdKOVV1UEh4SzFwN1RlMHF3b1ZZclcyOFprdmtZZmh4?=
 =?utf-8?B?ZDdFbHY0K21QS3E3QVlwYm5xK3laSndUUnRCT0l5N2gwdXlrbFFOZHd1ZDNm?=
 =?utf-8?B?QWpudEIxaGVVVEFOcFhJcWgvemY5M2tFL3BRVnFKRUNURGo0bVBwMGdob2tr?=
 =?utf-8?B?WFRua0hHRGw0NGNiR0dYTSs0T3p5YUdUODd2MHl3dWRGL0tpNEpjSGZuYXY1?=
 =?utf-8?B?VVpmdXBmMXhHZmVXUHZDZGVFNHptYTQ2T3NqZk9YdmVoM2dqeU5SaXkzWDJF?=
 =?utf-8?B?SzFZeFBSeEJ2L1REN3dCUGZaaWpHNHNVZzRRenFDelgyK0k4elVFNGNaZ1hN?=
 =?utf-8?B?KzRwUm9BbWtEWEVKTmFQL3lvcGJ0N1FibWhMVm5TaEpaZkhvK2VFOW9QRENP?=
 =?utf-8?B?OXdpNlVtU1pqc01iZ0VOK01qZjhnSmlPWk9CQ2RUTHlPSTIyQjJlS0pHNDdw?=
 =?utf-8?B?QyszbjljSnZtSUUwQno4SzVvUi96QW5GUUJMNnI2NnR2UmRlMHJKUU5sTHND?=
 =?utf-8?B?Mml4ODBGZWJ2ckR2SGxUZVFwZ0NpbVQxaWIxZjR5NHUzMmRZSGN6clVDTnRH?=
 =?utf-8?B?RzNlenpmWlNVUjF5WGcybjNNcGpJK1cxSUZ1NHBsMFdZT3JVa1pySUkyaFdY?=
 =?utf-8?B?STBrc0hlamgvWFFmd1Uva0pSbjJ5TFUvRUhORDg1c2NUaWNWcDZ0WjQwY1hp?=
 =?utf-8?B?ZzlybHdKNyt0SFNuN2NmT251NEdxSVovZzhURUhwTGhpcUp4UXNrV3BaZkFp?=
 =?utf-8?B?WDRiaElodjRzUXV5WUIvOVhzb21KcFdMREg0L3ozaXdiUmxyYzk5UnJBZVI0?=
 =?utf-8?B?ZXRpZ2VXVlBMWU1rQTdhSUlvVDRBQUdpVHA2VHd2UFRSR1p1bEtSK0Exb3RU?=
 =?utf-8?B?aUtoVHNSTmVmTXJTbjY4NHZkR09iOGdjOGxjeFRtQjR3TTNlWnJpMG55SGRK?=
 =?utf-8?B?Q2ZkcGRYMm1DK3FqNlV1MG9UTTlvdTZMOWwrZ1hlL3hmTDRkdDNacnMzT2dz?=
 =?utf-8?B?ck5uQi80OHBzcy9YazVvNlRMdGlsVlQzVmVFWE0rY1g3WGU2UUNtSFpJUkhK?=
 =?utf-8?B?d2ZyZlhCQ3M1RStkaXQ5ZktkVlRiVUk2RjFOWjJsckF2emhwVTJBL3B4RDZH?=
 =?utf-8?B?MmZJVTFCNjR4NkZ5bTRvdTJtd0RZUXYxOVFYUEFlWWdJNCtDUzJ2ZFo1WnIr?=
 =?utf-8?Q?wubbRfpkoG8DL1EBOD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacca770-6349-4166-792b-08defc1f9abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:23:00.3082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMpwiOPLGw6pWiFZO/BkighP8zJvf2+TFPVLmqyzHeMfO6GgrBPGYytDh+WufZO8w87f58TdsVlC9AurfPnKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

QU1EIEdlbmVyYWwNCg0KU3VyZSBBbGV4LiBJIHdpbGwgY2hlY2sgb24gdGhpcy4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KU2VudDogRnJpZGF5LCBBdWd1c3QgMTQsIDIwMjYgMTI6MzMgQU0NClRvOiBIb3N1
ciwgUHJpeWEgPFByaXlhLkhvc3VyQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBTaGFv
eXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBWaXNod2FrYXJtYSwgUHJhdGlrIDxQcmF0
aWsuVmlzaHdha2FybWFAYW1kLmNvbT47IEdvcGFsYWtyaXNobmFuLCBWZWVyYWJhZGhyYW4gKFZl
ZXJhKSA8VmVlcmFiYWRocmFuLkdvcGFsYWtyaXNobmFuQGFtZC5jb20+OyBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMV0g
ZHJtL2FtZGtmZDogQWRkIFRMQiBmbHVzaCBhZnRlciBNRVMgcXVldWUgZXZpY3Rpb24vc3VzcGVu
c2lvbg0KDQorIFN1bmlsDQoNCg0KT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMTo1MOKAr0FNIFBy
aXlhIEhvc3VyIDxQcml5YS5Ib3N1ckBhbWQuY29tPiB3cm90ZToNCj4NCj4gTUVTIChNaWNybyBF
bmdpbmUgU2NoZWR1bGVyKSBkb2VzIG5vdCBwZXJmb3JtIGhlYXZ5LXdlaWdodCBUTEINCj4gaW52
YWxpZGF0aW9uIGFmdGVyIHVubWFwcGluZyBxdWV1ZXMsIHVubGlrZSBIV1Mgd2hpY2ggZG9lcyB0
aGlzDQo+IGF1dG9tYXRpY2FsbHkuIFRoaXMgY2F1c2VzIGEgcmFjZSBjb25kaXRpb24gd2hlcmUg
aW4tZmxpZ2h0IERNQQ0KPiBkZXNjcmlwdG9ycyBjYW4gYWNjZXNzIG1lbW9yeSB0aGF0IGhhcyBi
ZWVuIHVubWFwcGVkLCBsZWFkaW5nIHRvIHBhZ2UNCj4gZmF1bHRzIGFuZCBHUFUgcXVldWUgaGFu
Z3MgZHVyaW5nIFNWTSBwYWdlIG1pZ3JhdGlvbi4NCj4NCj4gVGhlIGlzc3VlIG1hbmlmZXN0cyBh
cyBLRkRTVk1SYW5nZVRlc3QuTXVsdGlUaHJlYWRNaWdyYXRpb25UZXN0LzENCj4gZmFpbHVyZXMg
b24gZ2Z4MTE1MSAoUnl6ZW4gQUkgTUFYKSB3aXRoIFhOQUNLIG1vZGUgMSBlbmFibGVkIC0gdGhl
IEdQVQ0KPiBjb21wdXRlIHF1ZXVlIGhhbmdzIHdpdGggcGFja2V0cyBzdWJtaXR0ZWQgYnV0IG5l
dmVyIGNvbnN1bWVkLg0KPg0KPiBBZGQga2ZkX2ZsdXNoX3RsYigpIHdpdGggVExCX0ZMVVNIX0hF
QVZZV0VJR0hUIGluIHR3byBNRVMgY29kZSBwYXRoczoNCj4gMS4gZXZpY3RfcHJvY2Vzc19xdWV1
ZXNfY3BzY2goKSAtIGFmdGVyIE1FUyByZW1vdmVzIHF1ZXVlcyAyLg0KPiBzdXNwZW5kX3F1ZXVl
cygpIC0gYWZ0ZXIgTUVTIHN1c3BlbmRzIHF1ZXVlcyBhbmQgbWVtX2ZlbmNlIGNvbXBsZXRlcw0K
Pg0KPiBUaGlzIGVuc3VyZXMgYWxsIGluLWZsaWdodCBtZW1vcnkgYWNjZXNzZXMgZnJvbSB1bm1h
cHBlZCBxdWV1ZXMgYXJlDQo+IGZsdXNoZWQgYmVmb3JlIG1lbW9yeSBpcyBmcmVlZCBvciBtaWdy
YXRlZC4NCg0KQ2FuIHlvdSBjaGVjayBhbWRncHVfdXNlcnEuYyBhcyB3ZWxsPyAgSSBzdXNwZWN0
IGl0IG5lZWRzIHNvbWV0aGluZyBzaW1pbGFyIHdoZW4gdW5tYXBwaW5nLg0KDQpUaGFua3MsDQoN
CkFsZXgNCg0KPg0KPiBUZXN0aW5nIG9uIGdmeDExNTEgc2hvd3MgdGhpcyByZWR1Y2VzIGZhaWx1
cmUgcmF0ZSBmcm9tIDEwMCUgdG8NCj4gYXBwcm94aW1hdGVseSA3LTEwJS4gVGhlIHJlc2lkdWFs
IGZhaWx1cmVzIHJlcXVpcmUgZnVydGhlciBpbnZlc3RpZ2F0aW9uLg0KPg0KPiBDaGFuZ2UtSWQ6
IElhODNlNmFmN2E2NmZlMmJmZjU2Y2I2MmM3NDE3MjhlOWExODg4M2U4DQo+IFNpZ25lZC1vZmYt
Ynk6IFByaXlhIEhvc3VyIDxQcml5YS5Ib3N1ckBhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogRmVs
aXggS3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgLi4uL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyAgIHwgMTMgKysrKysrKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Vf
cXVldWVfbWFuYWdlci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gaW5kZXggYTIzMzg0NTcxMTkzLi43MWM2MGE0MmM1ODEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVf
bWFuYWdlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Vf
cXVldWVfbWFuYWdlci5jDQo+IEBAIC0xNDUwLDYgKzE0NTAsMTQgQEAgc3RhdGljIGludCBldmlj
dF9wcm9jZXNzX3F1ZXVlc19jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwN
Cj4gICAgICAgICAgICAgICAgIGRxbV9ldmljdF9tcWRfYm8oZHFtLCBxKTsNCj4gICAgICAgICB9
DQo+DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBIZWF2eS13ZWlnaHQgVExCIGZsdXNoIGFm
dGVyIE1FUyByZW1vdmVzIHF1ZXVlcyB0byBlbnN1cmUNCj4gKyAgICAgICAgKiBpbi1mbGlnaHQg
bWVtb3J5IGFjY2Vzc2VzIGNvbXBsZXRlIGJlZm9yZSBtZW1vcnkgaXMgZnJlZWQvbWlncmF0ZWQu
DQo+ICsgICAgICAgICogSFdTIGRvZXMgdGhpcyBhdXRvbWF0aWNhbGx5LCBNRVMgZG9lcyBub3Qu
DQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKGRxbS0+ZGV2LT5rZmQtPnNoYXJlZF9yZXNv
dXJjZXMuZW5hYmxlX21lcykNCj4gKyAgICAgICAgICAgICAgIGtmZF9mbHVzaF90bGIocGRkLCBU
TEJfRkxVU0hfSEVBVllXRUlHSFQpOw0KPiArDQo+ICAgICAgICAgaWYgKCFkcW0tPmRldi0+a2Zk
LT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpIHsNCj4gICAgICAgICAgICAgICAgIHBkZC0+
bGFzdF9ldmljdF90aW1lc3RhbXAgPSBnZXRfamlmZmllc182NCgpOw0KPiAgICAgICAgICAgICAg
ICAgcmV0dmFsID0gZXhlY3V0ZV9xdWV1ZXNfY3BzY2goZHFtLCBAQCAtMzczNiw4ICszNzQ0LDEx
DQo+IEBAIGludCBzdXNwZW5kX3F1ZXVlcyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ICAgICAg
ICAgICAgICAgICBpZiAoIXBlcl9kZXZpY2Vfc3VzcGVuZGVkKSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGRxbV91bmxvY2soZHFtKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbXV0
ZXhfdW5sb2NrKCZwLT5ldmVudF9tdXRleCk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlm
ICh0b3RhbF9zdXNwZW5kZWQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICh0b3RhbF9z
dXNwZW5kZWQpIHsNCj4NCj4gYW1kZ3B1X2FtZGtmZF9kZWJ1Z19tZW1fZmVuY2UoZHFtLT5kZXYt
PmFkZXYpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIEhlYXZ5LXdlaWdo
dCBUTEIgZmx1c2ggYWZ0ZXIgTUVTIHN1c3BlbmRzIHF1ZXVlcyAqLw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGtmZF9mbHVzaF90bGIocGRkLCBUTEJfRkxVU0hfSEVBVllXRUlH
SFQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgICAgICAgfQ0KPg0KPiAtLQ0KPiAyLjQzLjANCj4N
Cg==
