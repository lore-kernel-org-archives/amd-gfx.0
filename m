Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E55D58E6F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 07:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9398410E14E;
	Mon,  2 Mar 2026 07:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4xXgmyO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DCC10E14E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 07:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRUa/dhKRyml0ZqshTV+S2SCMrFfuE5t0MLgWD01BRvLLlz2NmAlFdhf39vNGAr7iUO6hlXgEuwB7XuE2Qx1S+FPJyngIRq+L8nPng/evvK3Bnjmp4tPzZLUvdOKI4W+8w/Qgk7+T7W3DvqoCyRU2sLd0xTvi3EZuZVVT3lrbMXDCDcSHrznmBSQU8Owj3kyBJ3wrrzEeHjR6t7HpFBgVzScjqwUb+Rzkjy5+YmK3UfaBTPyh45UIjnIkEU508OphgubPoTqEFtEtP0VB3c1eLvfdfJ3hIls0oM911sQQ7Oc0hOlC4CQStifXft1NiK2W8sIyERvjl+KVpq+aFJsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWP3viaI41LmHH3xiZzUaNPqQW/Wzl/iFhQvvKASey8=;
 b=pYyCDo7KT5MSikNA+HXREKqE10Q/5zW700uViX83TQSrBK20AM95+i5kcV+VLV3oml69oU+5JEFTBSbQGQ7x4zRd6f3tQ0dLtvbV/+i3ClXGns0/xuTqyuEjy4prwKWqt314FxNH6CFA85kADqD6TuJ18ImwjnryD8NUf7h24AZC3e0BV5MGqKhxig2cvPWPLsOS8PIZpvJxaxlg4/2v1m8NaZlwm7gEfChZwSx+bZ15tR6AEazAppS6faMGizFUYafAZlVDCzvQ9Arw0r8nd5WKZiBygojM51kKJ7HdHyqSKc4o7OCdElDPLZAVIXpEi081z0a94hwN+ny8661eHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWP3viaI41LmHH3xiZzUaNPqQW/Wzl/iFhQvvKASey8=;
 b=e4xXgmyO/M3HZI3VnPZ6jINEepI3o88wW90f8LVdvcv46hUysxB1BU1xSqizKela/ZHyJ+10A9TqNI/mx+HzXl5srNEnS4NA2zMW3Mc/ywZxFPC4KcVhZQ5KTgXgvpaPYfUTiTG3M8JfQCMqzNnSU21Ki7cMVOpAshNkziz44KQ=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 07:09:29 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 07:09:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Topic: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Index: AQHcqguvHpNHzHU9wEe5XUrqdouSibWaxhGAgAAAgRCAAAJhAIAACXDg
Date: Mon, 2 Mar 2026 07:09:29 +0000
Message-ID: <DM6PR12MB29720D0E16B78715D2C18D99827EA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260302061242.3062232-1-asad.kamal@amd.com>
 <7e5e915c-1f12-49ac-ae0e-752b5b158e52@amd.com>
 <DM6PR12MB2972453AA557B2E090281111827EA@DM6PR12MB2972.namprd12.prod.outlook.com>
 <DS7PR12MB6071B2EFF64C827309ACCD918E7EA@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6071B2EFF64C827309ACCD918E7EA@DS7PR12MB6071.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-02T06:25:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|IA0PR12MB8981:EE_
x-ms-office365-filtering-correlation-id: 7d5b9daa-1f76-4504-d76f-08de782aa5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: yv9W5/SNW+AHxp/PYtxCuCwtb3K599kAJ4DumkjmIu5141TGYXUQT/8pkZIvOzHW5Z5rbjwVqC7KoqnzrrCU2US1DqbvQCf/WZDb/cTD8pj0lLcDyOms61N6KMZ8DkQ/BdK9OzxuSV+E/Smg26IG1+terYV0zbkCphDxXgem+es1s19AXXe0y0ECQDEqtKO24PDPWFlzeN555Jzdknm/Ou0gSeZRGnpbaYaev3GYjSdmLKodOSnazyW23zZrMi5WTtItyEpD0PCRIAeQAOr8F6wgLihcUizOuWGIG6VFwJrlh73056APQ5DEmQuLXI2luDi2uVEiDiGj2GqyCSaidP2yZDId/cq1sBCdF4GEGIm0Ea2EZbJ4IT8ciCCNkklAj1rc5jxumASZZFIwmNwp/GePIprmLPldiYjXcD9c0jwi1LvfDVtTZiTt8QncJGbmFoq4+0Vp+4gSq2Vnsc24JhRd+xcVcPiz4KXq6gr0uVHKnAEQVaWu8gHsRnu4X7iTf3qI3gwMsc4yXLilRP1TNUdE1i3uZRKRGyOLANcYIJWz3fRi9A3lNq6bCZA0qeRiOVHlQrW6Z29cChWPxVGKzIvhzA5k4OeGtSK3BYPGjjW2/FewZVBS6Vowc3a9j/YUR85Z1q31OlFlShQi32hgXAidqcJWXkiT6IMfaldbpZB5v9U/2TKR3J+DfoflRPg9cQJQyzgjBEhTJwLlt1ZZjmmkKlLjYa2p7C1v6XR2N8ZcBDbvto80rmFEBtXX8hgDMuUkM5LfdqygnIK0IEN6sypChPTVyLhXwm/c1r3t7o0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTZXMXpZU2NDN0U3WHViUXlhMW0yRkZuWGYzNjJjdVc0UnhSak9QVVB3NDBh?=
 =?utf-8?B?RmJmd3ZsYzczMGVzZDB6ZXltb0NoT0xDRFd5ajJaQkladnBjTVc3KzkzVVJD?=
 =?utf-8?B?UkI3bFFUZVp4WjV6eHNoY3hOZFVvWmxRbklZV0dxZmVkNnlNaG5kOW56cXcx?=
 =?utf-8?B?WmFzOWxmNXM1VlVSZUtrblhoQUFHaW80NjZrQ2F3aEVKcEl1UGFwSS9RcHh4?=
 =?utf-8?B?WlQ0dEJsMXFYSmNScUJzTVVPaWVMcnZKRUdzQWZSbDJhSWI1VmpkZFZaamJy?=
 =?utf-8?B?Q2FMOUhXcjA5UndsMmF1OC9mdFpzOTVuYm9MZTJxWk9Vcy9WblJ6Szk5YWt5?=
 =?utf-8?B?ckc5Q3NGdURrNnRTbHRqTXkxNTkyTDhIdmpEODFQKy9GdG5FdlVJNDNVUWN0?=
 =?utf-8?B?TmU3R0RqNU55eHFCclFkMXNDejQvVGRpeU9JZ3BYZnhVS0FyalhjWW5pZ0th?=
 =?utf-8?B?TmF0N2FaY3N4MzU4TVJmSnVhK3BFb1g3OUtoMEIvYmdBYU91dmJvT2FaaDhQ?=
 =?utf-8?B?ZVZ2Wm5oOXdVbFRMVTJiUkpBQ2U4U25PZnN2WkM4cHlKcHNrcHcvWmxuL0Yw?=
 =?utf-8?B?YnRISENQdnRVZkIzM2RZQ2dxaE9ncDFSVWJQcjd3WGtma0Y3T2FlRkgwUzRU?=
 =?utf-8?B?bGhnTytDVXNEMGQ0MG5TYzZqVkVxd3czZUdQcElBeU1EN0NvTFpYaE9CcUNG?=
 =?utf-8?B?SVh4MUVUTU84OTk5RVY1TGh5TitzQ3VkSXNFbnkyaFJocEJzdzJkMGlEV3NL?=
 =?utf-8?B?OTB6QVVFc2NBeVVrdW1zMVM0UEFUY0lKR2xYa1hkbTRuL1N2cVVKaDRQcGE1?=
 =?utf-8?B?UGFHalpTTVE4dnRWLzcyalRQRkNSTGNUSzhDMzhlMXhmNVlObmYyMVl3WWsw?=
 =?utf-8?B?YUlUVXlkVFlJNm9VL0xYVGRLNWhPVEVuUi9tN0hBRjBUZ3hscTduK0dQYWVO?=
 =?utf-8?B?MHNIVHNSNTkrY2Q0KzFNNEdOaUVOOWZGYTduWnNyU1dZRnBDNm1IQ1JFdXpB?=
 =?utf-8?B?blIzbnFSeWpqRTJBY29IQUFLSnF3T1JVUzdpVmdqa3FoenRqLzhINTM3VTJo?=
 =?utf-8?B?NnBsZ0l4S09UYkZ3NU1JeGhuUmw1dGdSRHlKSGVzZU95d3gxTmRMYk52MTVn?=
 =?utf-8?B?RWhNdXRjQnl6RlNoKzdQZkpwbHJPY0VCdjhhaU16T0pkdzhnUEVMTVBSWlNj?=
 =?utf-8?B?ekxHNVI4WGNVem9oK1J2WUZPTnB1OVVXSGt1TTZVaFgxYk1aWFBlb1FGZS9O?=
 =?utf-8?B?UkVXbmFESFRoMjRRNFNuSlJ3d2dvOUdEeG1FT0xjUFhGd1UzRXJYWWt1Wjcy?=
 =?utf-8?B?MFdJQW1KSmdlUk91OHlIZkhWaUdVWDFpbnR5YWpiZnFsdGdzYThKTnVpUWxM?=
 =?utf-8?B?aDdnMmxQQUJSY2VrcHdsU3RIRFV6eFFFcUNxMG1oNXVlL1RTdEdzQ1kzZmdD?=
 =?utf-8?B?S2hwbmxIREN0ck9HdXVXZE5udWRCS0xweExBbXY2NXdRNHJwcy9aUHFmUVg2?=
 =?utf-8?B?Q1NxR0dnaWdEM1piYVBadVpKZG9LOExkTkVOdFFkOXlyR0NhaVVYWkdmVzVp?=
 =?utf-8?B?cEZya2tKTDJkTElhUXE5ZUVDM2ZPMXJmZ3J0V1BIZllSTEtCNGlvOE5XNjha?=
 =?utf-8?B?TUdldEtDZ3dIZ0piZzFRYmxudGhsNkgzdyttU0U3cDA1bUdHak1kYnR3RnZ5?=
 =?utf-8?B?WkdNMitKakEwc3MzdzZGNldKbTBZdVgzTXdZK0d2VnpTQW9sRXRSdTFvSFU4?=
 =?utf-8?B?SjZDakNiR3lqMjFScUY4K3AxVlRLcTR0U0k2WS9jMnpHWEVxdTN4Y2FjdmlX?=
 =?utf-8?B?TVBIZGlkRlJERXVpVHgrV25LQ0FwcUtMdnB3MERpNGJWdkp5NXc2NHpVZkxT?=
 =?utf-8?B?NTNvazNxNU1aYzVCUEZ5Vk9DREpEYUsvYllIT0xHbkt2ajFxY0FpUlF5RG1x?=
 =?utf-8?B?cG9malREdlg2dVpSNmtTRXZTZXlXa1VkK2xPelc3a05wTWVZaytKSmk2aktE?=
 =?utf-8?B?YTFxcHhnUUdRRWQrMi9nZEgyRnFXZ3phTEptdDJKWmd4WTJZNm9wOU9Ld2Nk?=
 =?utf-8?B?dGd1ZlB0VnFmRVdWVUhUODhSUmVmZVdOR0dCcDBjSGdncVFrSmNXMnd6WXJj?=
 =?utf-8?B?bHV4ZTJ2cmdmTi9SSWlsQ3lVc1Uxdnp2dUQ3Vk9CekZodklERkRSRFRCMkpV?=
 =?utf-8?B?SUoxMHZ1N2Ztdyt3azVZcVpKZmNOSlMrZW1GaGpsSXZZc0oxckxMd2FjSFM4?=
 =?utf-8?B?YVV2dFNEM0dBUEVkMXVkTFRVQm5CNGZCY0g1YVlQY1p6ZUJLMnJtSjh5YXZi?=
 =?utf-8?Q?kqGi42P1URj9N5l6Ud?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5b9daa-1f76-4504-d76f-08de782aa5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 07:09:29.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elM94GBuqpk6mkgoKNXX78a4zka9TION5jgr+SLheIgEK6cIAtVoh0o8xXnR9HOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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
Cg0KQmFzZWQgb24gcHJpdmF0ZSBkaXNjdXNzaW9ucywgcGxlYXNlIGNvbnRpbnVlIHRvIHN1Ym1p
dCB0aGUgY29kZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+DQpTZW50OiBN
b25kYXksIE1hcmNoIDIsIDIwMjYgMjozNCBQTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZp
bllhbmcuV2FuZ0BhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IFpoYW5nLCBNb3JyaXMgPFNo
aXd1LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL3BtOiBBdm9pZCBvdmVyZmxv
dyB3aGVuIHNvcnRpbmcgcHBfZmVhdHVyZSBsaXN0DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkg
LSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCi0xIGluIG1lbXNldCBmaWxscyBh
bGwgYnl0ZXMgd2l0aCAweEZGLiBGb3IgaW50MTZfdCwgdGhhdCBiZWNvbWVzIDB4RkZGRiwgd2hp
Y2ggaXMgLTEgaW4gdHdv4oCZc+KAkWNvbXBsZW1lbnQuIFNvIHRoZSA8IDAgY2hlY2sgc3RpbGwg
d29ya3MgYXMgaW50ZW5kZWQuDQoNClJlZ2FyZHMNCkFzYWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
Pg0KU2VudDogTW9uZGF5LCBNYXJjaCAyLCAyMDI2IDExOjU5IEFNDQpUbzogTGF6YXIsIExpam8g
PExpam8uTGF6YXJAYW1kLmNvbT47IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+OyBaaGFuZywgTW9ycmlzIDxT
aGl3dS5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9wbTogQXZvaWQgb3ZlcmZs
b3cgd2hlbiBzb3J0aW5nIHBwX2ZlYXR1cmUgbGlzdA0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+PiBtZW1zZXQoc29ydF9mZWF0
dXJlLCAtMSwgc2l6ZW9mKHNvcnRfZmVhdHVyZSkpOw0KLi4uDQo+PiBpZiAoc29ydF9mZWF0dXJl
W2ZlYXR1cmVfaW5kZXhdIDwgMCkNCiAgICAgIGNvbnRpbnVlOw0KDQpXaGVuIHRoZSBhcnJheSB0
eXBlIGlzIGNoYW5nZWQgZnJvbSBpbnQ4X3QgdG8gaW50MTZfdCwgdGhlIGNvZGUgbG9naWMgb2Yg
dGhpcyBtZW1zZXQoKSBtYXkgbm90IGNvcnJlY3RseSBpbml0aWFsaXplIGFsbCBlbGVtZW50cyB0
byAnLTEnLg0KUGxlYXNlIG1vZGlmeSB0aGlzIGNvZGUgdG9nZXRoZXIgdG8gZW5zdXJlIHRoYXQg
dGhlIHN1YnNlcXVlbnQgY29kZSBsb2dpYyBtZWV0cyBleHBlY3RhdGlvbnMuDQoNCkJlc3QgUmVn
YXJkcywNCktldmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogTW9uZGF5LCBNYXJjaCAyLCAyMDI2IDI6
MjMgUE0NClRvOiBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgWmhhbmcsIE1vcnJpcyA8U2hpd3UuWmhhbmdA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZC9wbTogQXZvaWQgb3ZlcmZsb3cgd2hlbiBzb3J0aW5nIHBwX2ZlYXR1
cmUgbGlzdA0KDQoNCg0KT24gMDItTWFyLTI2IDExOjQyIEFNLCBBc2FkIEthbWFsIHdyb3RlOg0K
PiBwcF9mZWF0dXJlcyBzb3J0aW5nIHVzZXMgaW50OF90IHNvcnRfZmVhdHVyZVtdIHRvIHN0b3Jl
IGRyaXZlciBmZWF0dXJlDQo+IGVudW0gaW5kaWNlcy4gT24gbmV3ZXIgQVNJQ3MgdGhlIGVudW0g
aW5kZXggY2FuIGV4Y2VlZCAxMjcsIGNhdXNpbmcNCj4gc2lnbmVkIG92ZXJmbG93IGFuZCBzaWxl
bnRseSBkcm9wcGluZyBlbnRyaWVzIGZyb20gdGhlIG91dHB1dC4NCj4gU3dpdGNoIHRoZSBhcnJh
eSB0byBpbnQxNl90IHNvIGFsbCBlbnVtIGluZGljZXMgYXJlIHByZXNlcnZlZC4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQXNhZCBLYW1hbCA8YXNhZC5rYW1hbEBhbWQuY29tPg0KDQpSZXZpZXdlZC1i
eTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KDQpUaGFua3MsDQpMaWpvDQoNCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+IGluZGV4IGM0NzFjMGUyY2Jk
MS4uMzI2Yzg2YjkyMGEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdV9jbW4uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9j
bW4uYw0KPiBAQCAtODgwLDcgKzg4MCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpzbXVfZ2V0X2Zl
YXR1cmVfbmFtZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICBzaXplX3Qgc211X2Ntbl9n
ZXRfcHBfZmVhdHVyZV9tYXNrKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjaGFyICpidWYpDQo+ICAgew0KPiAtICAgICBpbnQ4X3Qg
c29ydF9mZWF0dXJlW01BWChTTVVfRkVBVFVSRV9DT1VOVCwgU01VX0ZFQVRVUkVfTUFYKV07DQo+
ICsgICAgIGludDE2X3Qgc29ydF9mZWF0dXJlW01BWChTTVVfRkVBVFVSRV9DT1VOVCwgU01VX0ZF
QVRVUkVfTUFYKV07DQo+ICAgICAgIHN0cnVjdCBzbXVfZmVhdHVyZV9iaXRzIGZlYXR1cmVfbWFz
azsNCj4gICAgICAgdWludDMyX3QgZmVhdHVyZXNbMl07DQo+ICAgICAgIGludCBpLCBmZWF0dXJl
X2luZGV4Ow0KDQoNCg0K
