Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D5FED2F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAD410E198;
	Thu, 12 Mar 2026 09:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DfbeYtJz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8080D10E198
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SizQRe38cCmhuXEFu3PH4rhP22lhHaV+nlYUdydwTjGouLxT3nPN7yQR9uqr4Ll7TEVavyMghJq6cGAAS8r8J8rtsnK2vzpdHc+o07nvR0hvaaClHL2ZB7rOuDOclh34c06enxeWhVdtjwcQgytXWZDy7J7tpciY06wlTzEzDMnY0zK3zGBecgILMVTOsJB5j8Xof2mYDL9Uv5EXHryyXGRRlk0oJ6O8f8pGgYs431KVu61lUBGfObVaFdM2GIQYh5FJdS7msmK5NuVtfeTU6jhMVcMtHMltIkDkSXGjfrusUshonofd1KYvGekOcEYS4ZIBo+ezbZbVFTfY4NbnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqMCoHtUvwWeooa6l076/2MzAIR/e+YZJQ2l00Mn4NM=;
 b=gyoMqQh1jcYqJmlPFVJK4ISQiC5q9zAytbyeDdOp+OIxwsD2bQ8ncdPdSPJ6kcwooJ9VjVTgKEm1mRSW/bNRGaiMO1x1kNGYuWA6QxXAqOm8YkAbdmgTxpm89fX1tlzYdzr9HxgSvIJwo5SGFHLUXAl6WBmXa3LPRYrTTR73SmMhimPAnKToWMWQDDhyxldAu2YGKBW8JOFrj5dE3nw7RSEAKA0UamSORPiIKfTrzZvp0wzBXzLj+lSPcCWq9SNlwIKbmDvTZ71tm3oxU91lIUPMXDaWyIDG799a/WdIja2USNa02AXk0FREbKj/F+jGA0OW4/RAKRMBXNIXRd7x3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqMCoHtUvwWeooa6l076/2MzAIR/e+YZJQ2l00Mn4NM=;
 b=DfbeYtJzDi1eLB4dsKkArIsMyYEIemepV4SDRuJKQayBLdUFJ9Y1sn6jCUbRSWgBZN63S3MA+Yx+COOGxwHGIazyNlGyfEPZH3fodUvYkSqdzdwgXv5zasGEcHZYQ4nrPJYSvPVD5SqvVsylTifyH4aAU2jVtMTOz/hHD5C1YnI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 09:48:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 09:48:14 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Topic: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Index: AQHcsfjR6VM9S6ppOE6vIukI9J/9krWqjuGAgAABrQCAAA2egIAAAobggAABQwCAAAIL8A==
Date: Thu, 12 Mar 2026 09:48:14 +0000
Message-ID: <BL1PR12MB5144221F15AC59541C403161E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
 <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
 <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <893e3235-b291-45c7-8644-913e22b432ce@amd.com>
 <BL1PR12MB51440DF0B4763FACFFFE9045E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0c94049a-1743-4e93-831a-5bcb5b43aa89@amd.com>
In-Reply-To: <0c94049a-1743-4e93-831a-5bcb5b43aa89@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T09:38:24.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6114:EE_
x-ms-office365-filtering-correlation-id: 598596d3-ede0-427a-b0d8-08de801c7adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003|7053199007;
x-microsoft-antispam-message-info: NKUe//jGSGgIdttl555l52cV7kj2lhm7aygcDk1ZHzjs6StrZLS/3QSecscznUJ/Cud0697sNwpPe7DhDquFP0scn8PNklcZ+gU/+0cPGQ3Q8Gi5fhas2Vi5KqOEVE3DumJIKZ8CH1oWn+VcofUNgT6noAM18LD8dBRW2oldl/PNgebxP4qAerbGYtLhMFipCGB9VyRsubnGPcpcBRcTncw9evk7juWA2rD3VXtPQ8Jvib/RZihLVeaq8Y83FE2mLBwsEs3kDEA3yhyroewT48McKmHRktU5kHay9oH7/oMWvLmev1fn1P5aJ0Cdw9H2SmIRZIFfT9AdxoBCPfQbrbrdOh/l1QuEyWIUj7gEYDq7F0nixv7ZrNBaCcJK/HW3au200+2Xor7SF2JY1GAxm7xiigBqMRXpiyFTiPzzzlaoawJvRbadtsCfjyKVW2seFYrXW9d5PKtCSeVscFCrrVol8zNpF28nPOlTaHwHCFkEKXme7ChK+PO99tK6dhbBNUzJN3zvfvCYMxfQVl3ZFVvQJ6EGEgbY2Vt5sOnymg8M8+2yxkI8jM2r/kl76WZ+bwAh3qUUxjiYG1/oxLj6ZALkR7sTIv5Ovc0pJskIVbhN9rLaagnprTaQ1cr89klVSwaSQKqUVgMn9Qa08L8kp4IAxpAE4d9a/nSPExoDGgRTmhUQF++3bwyInuCifdVS5CKMZl5qtzchPsbKN0HyOsjlwKTEs3rFickeHXWvJZUFTFQm3Lrga3WaRpIVOHL6KxR6hVm8ivL7qSwRbF+JXtXfHF1qFkpwo+1e8GY+boU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzA3aGxoSU1NN1BRVzB1OXFpbnQyL3NVdmtKNVcyTzRhNlJQMnpmSnhjU0Ev?=
 =?utf-8?B?R2h3UjdCV09zaVR1UCtReDBNT29rajJKOVczellaNXRwbXc4YmVSdWFBTlF2?=
 =?utf-8?B?dkw4QnJCTFp6dG5EckJVOU5hR3BGWDBmM2ZNN1ZEVm85TklZZ21uM2szSWJn?=
 =?utf-8?B?dVhLeS9oR000aVNjV1ovNzdwbjdFaytCcHo3dmVNdllVdWtub1dPWWJYUTRS?=
 =?utf-8?B?cEt2SUJiMlQ1SkE5NjIvbUJHRVpXakFEalJneGRzZGovc21IbXgwRTJwU282?=
 =?utf-8?B?bXFPeDVNQnJ1UnlHQlFYWFVLZ1orNGEvaXh3OFJWMklnVGhjQlJTWXpKT25V?=
 =?utf-8?B?eXY5VmZMb0RHZTNEWk51cW1HV2JVU3YrOGlLcEdubVRHR01aZmI5Qk84ejBQ?=
 =?utf-8?B?cGRITTIvZnJZWjJ2M1djRkVZd0RtbDhCR0RSUityUWJMbHZab3hiajlEcXlD?=
 =?utf-8?B?b0hRODBOUDlGUGpjMjZ1V0lHTVBCVUZHVExiWmo1bUZYYXV1R1dGL092TUY1?=
 =?utf-8?B?UW1VYUlnMFhvNDJQWWZaSTk1endnVDFmTUJzdERyVTYrLzU1TXFtN04wblVu?=
 =?utf-8?B?VVVYRC83NlFUNllLL2dLYitjM3dmVGp0S2RKNDdTMkNVOGVhcU5CYXFUdUVM?=
 =?utf-8?B?TUFocmRVU0NuRWZneTBIRWZiZGVuUDd1QStuMEFWN1BBTWZGV2xrZyszaTJ6?=
 =?utf-8?B?WXRsdTM4K0ZuYUdrN1FhMXg4WGNYZFkxRUhzMkV2UDVHQTc0Rm1OaFFHd2xs?=
 =?utf-8?B?eHJJbzlmVFdoQ2M3ckpvWUNUdE9EaHlWcldrWWNYNXBnRjd1K3JWL1ppR3N4?=
 =?utf-8?B?WTlLN2lZd0k1Z1oyODgrV2xpbHhwUXFiVlRSNEhScUpKQ1VleWhadko1cWJC?=
 =?utf-8?B?bkJxd2JQVGFoaEJKbmplU1ZldUYydGk0Z0FCdkFtVEd4czFMNUkwUmpyS2Ir?=
 =?utf-8?B?dHd6UWdZUUhJajdFZGd5M0w1VVk3alhtQ3A3dlBBVnBLb1FvZlR0MkhsZ2xF?=
 =?utf-8?B?QUJPR0hhTEVKa1JuTVN6L1dLcFJQTkYvTmNjTTU2U1NXY3Q2TGdKTk81WUhS?=
 =?utf-8?B?NndDTFVqcXFwUnJyUGxZdVJZTWJlVjg4Nmo5eEpHOHUvaEY3VHJLNDBkSktO?=
 =?utf-8?B?eGo0cHI4L0Z5TnRhRE92TGtPMXVJVHpsUDhPR2swaC9PQyt1eENabFoyaUdS?=
 =?utf-8?B?M1ZjaHhVTDVRWVFyMDJCR0s5bHBEQ3lRZmE1eTNpRHhiQXU3cGlsR1dYQWlk?=
 =?utf-8?B?NXlHQUJuTlZMclk3T2lDZnJ2cEoyS1RrY1lpdWFvbDVlWlpBNEhlMUN1a1JI?=
 =?utf-8?B?RWZqZFB2eG9rNldodmhGVXVvcDRDczh4eDZkRUZFWFZjbHh2UHRUQWdnSTZV?=
 =?utf-8?B?TGdxYzB0c3VaZVQ5QkUvVWpxUXZGNyt1Ym5IQ1VrNERYNzZPUElPZ1prcG5R?=
 =?utf-8?B?dzE5T3ZyV05nUEhaRnRIaVVLU1BENWdENWZHc2F4T0swOGlqNzE2TXZyd1VP?=
 =?utf-8?B?RENuVXNxVCtmbFp5QmFxNVM5WHBGWVBDRFZvZEpJYXdpeU9XSHl3S1RhUUlG?=
 =?utf-8?B?TVc1bG1VNXVjdFJHZ2Raci9WZWpHUXlwTFJFV00xQ2ZpSCtsQXdHK1BPL2Nm?=
 =?utf-8?B?MU83TGw3NG9VSVBKV0YxZ3c5b1dqalFtSEdkVGUwNmxSYVNkWHMzamlEVnZN?=
 =?utf-8?B?MnUySGQrRmlLdjdQMGFWNEpPOW5tZ1BjbzRnbzVicXNHbXpvOHVSR3lmc05J?=
 =?utf-8?B?UUhZTGoxOWlzZSt6bjJEVzZBWTNyeFVZSlJ3WHNrWUQ5WUZqcExXVHVrR3pO?=
 =?utf-8?B?UG1yT3RuU3dZdDM2K2ltc2EvMXVCVVBlcWhtMjBSazBKWDU4OUNFZWxSUWRV?=
 =?utf-8?B?dDdXL2VVNHN4Z3NjUnJEZkN0MWIvM3VWUE1BSGJxaFlkVEQvM3RYS2pPYzJK?=
 =?utf-8?B?TzdIU3hSMUM5aEtWUnhpUEJrNVBnNGlrUXVodmZtR2tEcW9qYlg0Z1NsbzRT?=
 =?utf-8?B?MW1NOERHV3p5bm5uSlhwSWFCTFNKVlptYkNXQU5yY08wcjJEa293clI0WkhL?=
 =?utf-8?B?aFM5RXRidjZaVEdQTjg3V09PWHQ3UUNoQmNFKzJ0ZU5ZR3ZMSC9qUmJYTTVV?=
 =?utf-8?B?RzhRSksxY3ltR0pyQ3ErbE9nczlVUWh5eWplZkdXT0ZWSFpIRlpDWjQ1WkIv?=
 =?utf-8?B?ajJESGp0YzNpQ3hZU2RiOW9GWU9LUFpKbUxScDlpR2R2MUMzNXJYQzVFSG0x?=
 =?utf-8?B?V3pPNHVQa0RjOXJYS0RiZ2Vna1U3R0dlN3ZDZE1rdVJSWTFXRVNkeGh1akc0?=
 =?utf-8?Q?S02+W5QJWIthlfv2DW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598596d3-ede0-427a-b0d8-08de801c7adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 09:48:14.1443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mh1epkWHcHemygxxsDgvrczlP6M4RG80ARQ3/ff+JnGQ19eQ2HQ1s3xd/HjccMPp1UOs9/cN4BQ/MMckg+puwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIs
IDIwMjYgNTozMSBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgb3ZlcmZsb3cgY2hlY2sgZm9yIEJPIGxpc3QgYXJyYXkgYWxsb2NhdGlv
bg0KPg0KPiBPbiAzLzEyLzI2IDEwOjI3LCBaaGFuZywgSmVzc2UoSmllKSB3cm90ZToNCj4gPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAxMiwgMjAyNiA1OjE4IFBNDQo+ID4+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVz
c2UuWmhhbmdAYW1kLmNvbT47DQo+ID4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBvdmVyZmxvdyBjaGVjayBm
b3IgQk8gbGlzdCBhcnJheQ0KPiA+PiBhbGxvY2F0aW9uDQo+ID4+DQo+ID4+IE9uIDMvMTIvMjYg
MDk6MzMsIFpoYW5nLCBKZXNzZShKaWUpIHdyb3RlOg0KPiA+Pj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPj4+DQo+ID4+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAx
MiwgMjAyNiA0OjIzIFBNDQo+ID4+Pj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFu
Z0BhbWQuY29tPjsNCj4gPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+Pj4+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIG92ZXJmbG93IGNoZWNrIGZv
ciBCTyBsaXN0DQo+ID4+Pj4gYXJyYXkgYWxsb2NhdGlvbg0KPiA+Pj4+DQo+ID4+Pj4gT24gMy8x
Mi8yNiAwOToxOCwgSmVzc2UuWmhhbmcgd3JvdGU6DQo+ID4+Pj4+IFdoZW4gYWxsb2NhdGluZyBt
ZW1vcnkgZm9yIGEgQk8gbGlzdCBhcnJheSwgdGhlIG11bHRpcGxpY2F0aW9uDQo+ID4+Pj4+IGJv
X251bWJlciAqIGluZm9fc2l6ZSBtYXkgb3ZlcmZsb3cgb24gMzItYml0IHN5c3RlbXMgaWYgdXNl
cnNwYWNlDQo+ID4+Pj4+IHN1cHBsaWVzIGxhcmdlIHZhbHVlcy4gVGhpcyBjb3VsZCBsZWFkIHRv
IGFsbG9jYXRpbmcgYSBzbWFsbGVyDQo+ID4+Pj4+IGJ1ZmZlciB0aGFuIGV4cGVjdGVkLCBmb2xs
b3dlZCBieSBhIG1lbXNldCBvciBjb3B5X2Zyb21fdXNlciB0aGF0DQo+ID4+Pj4+IHdyaXRlcyBi
ZXlvbmQgdGhlIGFsbG9jYXRlZCBtZW1vcnksIHBvdGVudGlhbGx5IGNhdXNpbmcgbWVtb3J5DQo+
ID4+Pj4+IGNvcnJ1cHRpb24gb3IgaW5mb3JtYXRpb24gZGlzY2xvc3VyZS4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gQWRkIGFuIG92ZXJmbG93IGNoZWNrIHVzaW5nIGNoZWNrX211bF9vdmVyZmxvdyB0byBk
ZXRlY3Qgc3VjaCBjYXNlcy4NCj4gPj4+Pj4gQWxzbyBlbnN1cmUgdGhlIHJlc3VsdGluZyBhbGxv
Y2F0aW9uIHNpemUgZG9lcyBub3QgZXhjZWVkIElOVF9NQVgsDQo+ID4+Pj4+IGFzIHRoZSBzdWJz
ZXF1ZW50IHVzZXIgY29weSBvcGVyYXRpb25zIG1heSByZWx5IG9uIHRoaXMgbGltaXQuDQo+ID4+
Pj4+IFJldHVybiAtRUlOVkFMIGlmIGVpdGhlciBjb25kaXRpb24gZmFpbHMuDQo+ID4+Pj4NCj4g
Pj4+PiBUaGF0IGlzIGNvbXBsZXRlbHkgdW5uZWNlc3NhcnksIHZtZW1kdXBfYXJyYXlfdXNlcigp
IGFscmVhZHkgZG9lcw0KPiA+Pj4+IHRoYXQNCj4gPj4gY2hlY2suDQo+ID4+Pj4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gQSBjcmFzaCBsb2cgaWxsdXN0cmF0aW5nIHRoZSBpc3N1ZToNCj4gPj4+Pj4NCj4g
Pj4+Pj4gWyAyOTQzLjA1MzcwNl0gUklQOiAwMDEwOl9fa3ZtYWxsb2Nfbm9kZV9ub3Byb2YrMHg1
YmUvMHg4YTANCj4gPj4+Pj4gLi4uDQo+ID4+Pj4+IFsgMjk0My4wNTM3MjVdIENhbGwgVHJhY2U6
DQo+ID4+Pj4+IFsgMjk0My4wNTM3MjhdIGFtZGdwdV9ib19jcmVhdGVfbGlzdF9lbnRyeV9hcnJh
eSsweDQyLzB4MTMwDQo+ID4+Pj4+IFthbWRncHVdIFsgMjk0My4wNTM5NDddIGFtZGdwdV9ib19s
aXN0X2lvY3RsKzB4NTEvMHgzMDAgW2FtZGdwdV0gWw0KPiA+Pj4+PiAyOTQzLjA1NDI3N10NCj4g
Pj4+Pj4gZHJtX2lvY3RsKzB4MmNiLzB4NWEwIFtkcm1dIFsgMjk0My4wNTQzNzldDQo+ID4+Pj4+
IF9feDY0X3N5c19pb2N0bCsweDllLzB4ZjANCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIG92ZXJmbG93
IG9jY3VycyBpbiB0aGUgYWxsb2NhdGlvbiBpbnNpZGUNCj4gPj4+Pj4gYW1kZ3B1X2JvX2NyZWF0
ZV9saXN0X2VudHJ5X2FycmF5LCBsZWFkaW5nIHRvIGEgY3Jhc2ggaW4NCj4gPj4+Pj4gdm1lbWR1
cF91c2VyICh2aWEgX19rdm1hbGxvY19ub2RlX25vcHJvZikuDQo+ID4+Pj4NCj4gPj4+PiBIb3cg
YW5kIG9uIHdoaWNoIGtlcm5lbCBjYW4geW91IHJlcHJvZHVjZSB0aGF0Pw0KPiA+Pj4gV2UgYXJl
IGRldmVsb3Bpbmcgc29tZSBmdXp6IHRlc3RzIGZvciB0aGUgdW5pZmllZCBwcm9qZWN0Lg0KPiA+
Pj4gVGhlIHRlc3RzIGludm9sdmUgcGFzc2luZyBkaWZmZXJlbnQgbGV2ZWxzIG9mIGdhcmJhZ2Ug
ZGF0YSBhbmQNCj4gPj4+IGVuc3VyaW5nIHRoZSBrZXJuZWwNCj4gPj4gY2FuIGhhbmRsZSB0aGlz
IGRhdGEgY29ycmVjdGx5Lg0KPiA+Pj4gVGhpcyBpc3N1ZSBjYW4gYmUgcmVwcm9kdWNlZCBvbiB0
aGUgYW1kLXN0YWdpbmctZHJtLW5leHQgYnJhbmNoLg0KPiA+Pg0KPiA+PiBEbyB5b3UgaGF2ZSB0
aGUgZnVsbCBiYWNrdHJhY2U/DQo+ID4gWWVzLA0KPiA+IFsgMjk0My4wNTM2NDldIFdBUk5JTkc6
IG1tL3NsdWIuYzo3MTUyIGF0DQo+ID4gX19rdm1hbGxvY19ub2RlX25vcHJvZisweDViZS8weDhh
MCwgQ1BVIzEzOiBhbWRfZnV6emluZy8yNzY1DQo+DQo+IEFoLCB5ZXMuIFRoYXQgcHJvYmxlbSBj
YW1lIHVwIGJlZm9yZS4NCj4NCj4gVGhlIG1heGltdW0gbnVtYmVyIG9mIEJPcyBpbiBhIEJPIGxp
c3Qgc2hvdWxkIGJlIGxpbWl0ZWQgYW5kIG5vdCB0aGUgcmVzdWx0IG9mIHRoZQ0KPiBtdWx0aXBs
aWNhdGlvbiBjaGVja2VkLg0KPg0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGNvdWxkbid0IGdp
dmUgYSBnb29kIG51bWJlciBvbiB0aGUgbWF4aW11bSBCT3Mgd2UgY2FuDQo+IGhhdmUgaW4gYSBC
TyBsaXN0Lg0KVGhhbmtzIENocml0aWFuLCBhZ3JlZWQuIHYyIHN3aXRjaGVzIGZyb20gcHVyZSBt
dWx0aXBsaWNhdGlvbi1vdmVyZmxvdyB3b3JkaW5nIHRvIGEgQk8tY291bnQgbGltaXQuIFdlIG5v
dyBib3VuZCBib19udW1iZXIgYnkgSU5UX01BWCAvIHNpemVvZihkcm1fYW1kZ3B1X2JvX2xpc3Rf
ZW50cnkpIGJlZm9yZSBhbGxvY2F0aW9uL2NvcHkuIFRoaXMga2VlcHMgYmVoYXZpb3IgZGV0ZXJt
aW5pc3RpYyBmb3IgZnV6emVkIGlucHV0IGFuZCBhdm9pZHMgd2FybmluZy1wcm9uZSBodWdlIGFs
bG9jYXRpb24gcGF0aHMNCg0KVGhhbmtzDQpKZXNzZQ0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCg==
