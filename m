Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6FAC61DBE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 15:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7735410E1EA;
	Tue, 25 Aug 2026 15:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BiC+mYX3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C4410E1EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 15:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP3Ekww5SePW0r6s1+x0A20RcyFqDdKOL8ph/p8nRsRHSbmfKR1ZTjfhFQgvWt7F77karX84N1UulGAEuXyN5VfWddG82eCRpyD/NsVuiVp25R0+9voD+5rE53Nm8/wJniwwKt6h8yHRA3g/UVXceVGPx9ww1fviy48jH4VB1eLQrTx+FE6p+oxrmMBZ18ZZgoMQLQyPIlkgn75Y5TlT0Ic53lz3KCDKsac9+DeSgJjAN55yTI9fSNOOYGZpLVdOSdtezjctv7jm5GuC/1Rxil05zdp3F8kJZdBqM+JQxaMoOI4ax3aPi+yyUCkKjC4F22IxllXbYqw6Q55vSHjIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OY6rfQdp40Qx9+KRr+XckJXx1xuCv1g7vxbXYTSqSA=;
 b=ZQ2u5R0s8KshbbF3mA2+jMXovSC+fUxc8E6kYdagQjb7M9ZM4Q1pJFw/qP0goukFCoK9Q8oZvH6o0D1rUlWXTMdgTA0u4UEkHSlPs6NxygliLkuuNljv8VeENT2NCFeqS1ubScWJg/X13lenma5p5u3/n0G/6nzI+C1oniDnu7TkDRW0OI9XkuirKVbF2ZBkQjo7VkLLvDkXUhtbgqSWIxxx3t5pif9RGSeroqCbsz5zvyacywpwGT2SGnQ36kcFfHh9LCM9+CDtHolJx0UpaO1KRvq4E15UKTpLpGCqofGZyXG1dDan4LR3ahvhVNAchzPDxQX18xgakeBe/RqDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OY6rfQdp40Qx9+KRr+XckJXx1xuCv1g7vxbXYTSqSA=;
 b=BiC+mYX34/WK6Raf7Dm6AIeakl+8BuCPrP3yLXDNKQhsRo+q2a3NDKTudPNMQidqu7jjnY8g3ANtkxCmcot27cyHUYsPJgq4feJUJSHa+mL1gUIn/Dyd51kkxOp8/Yi/ES3od2e2zUcGIaPQV2jlWuc2ZVlrtLxn+6v58Kc8wiY=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 15:25:00 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 15:24:58 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
Thread-Topic: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
Thread-Index: AQHdMKzpm4hur7ZBW0+/TyAsXcBBU7atvE0AgACVioCAAJiOsA==
Date: Tue, 25 Aug 2026 15:24:58 +0000
Message-ID: <BL1PR12MB5898E8E3E83554AEE8368EA385AF2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260820140433.2875442-1-alexander.deucher@amd.com>
 <CADnq5_PoahpM1GB-fum5rYgzrS2sA=bfpdWjb3m=iutxtX9J3A@mail.gmail.com>
 <DM4PR12MB5152CFFC0ABBB5BE8F99A624E3AF2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152CFFC0ABBB5BE8F99A624E3AF2@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T01:35:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: 4b48749c-7a8a-4049-b913-08df02bd062d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: 4l/WeUWy03OSb6KQbgxU+ws1ie7Wupu99bc0EQfrXR/f9X56cqvCNF1D5WxwfWzAWxqagXX/idJdSBg0ed+4YU+lMYr44RGGdAiVTxUwamULnN9BpSRM6FizCRUqVOxBm+c5Y0hG3UqlGyctsFLrFsIR8ZejoomGtgWxPxyGCyvzzayrdW0fN15fM1GuP18bAmld6+nAsTK8MznPJcF+sm1gDQhU8GTtRpiQA1Sygr5UomG5HkjEYIOBBplAczpIVXb55tvNoFy7huQmW9T6FI/7S5wyWp4u1N40ca/XqeDuAE6fH/5nuPG1ws8JtSH+JTgUH6eNr5UNe4P/aZ9kgxOxKHNq9vKaFDkz59H0f7WQIbZCNMnVUAt0R4Bp1MpCchS2oOKmlulcbSllhIbx1yfmgJnJ3/2ldhQZfB4+BLe7W6qvNKQzjL2sU9KvZ5IItZ3YCqtEOcbFJbjvvy1itlVZHBjv/uMA5hu8fVcdZObIQanJgztB2YeL+9HijfXaOhkioJnong0Rp0EFvUCyQDHIj9OHpTpp2e+Qa6Ji/m2l01oBK4yxWOAJ15LL4nT2k3ligM5uwJd5OnHDmMggLcN9OjA9mFhH/9SNocUxVyFA+drGm+1ZGUC4QKxD1H+EZuh961swaVDOgm9o6+VX0qOQPE8aUbYtK6VkDe/MxOk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDhBUWpYbGJ5MlprTlFVWW5SR0xkUzI3dDdneTJGTjRZeTd0YldYK1lmMkV3?=
 =?utf-8?B?dllhQmtncjVUL2Jrc1ZzK3NsdXI0ZG14NytaTmoyT01tNkl2UmVHU2x4L1dt?=
 =?utf-8?B?NS9MU1dDT2lKRW5uTksrdE9WM2JQY3dYZVVNOGpDaExCVnlZMU9JU3FSRmpt?=
 =?utf-8?B?ako5K1dJckV1K0VOeEVieEh2aUdNSk5XaGIzTnRMbEhvaG5yMm5PM01Obyt2?=
 =?utf-8?B?ZCtIa0E2QlBUNE5RcFhydVNKUGk5OUtYeHJzc01aMGNyYTlxdHZiVHVxNFFW?=
 =?utf-8?B?cjZnVGZFbEpCZ2hpOFJxRk5mNUdRRUhaS1E3UWZaUXhpUW9EZ1l4eXlYTzB6?=
 =?utf-8?B?Q0ZLWlZnZHRobjhHMS9YVStpMkpYSW9Vc0xzRGNIc3I0NUk4UkxTcGlTWXRo?=
 =?utf-8?B?aVZGOTQ0VFFQSVoxVUpYZjRBdkJOTkplN0dsd2lpd1VONlp3QTNZckFUS252?=
 =?utf-8?B?TDN0dlVEMFkxZWp6b29QSnpML3c2ejdYZnNMOTdNQUFjS0sxOCtLdW5rakFP?=
 =?utf-8?B?TlVoM01lV3JCRVpCZWIzOUNmV25hU0FNajIyaEdLME9wTUpLa0tKNlJuMWkr?=
 =?utf-8?B?ZmYzdWlLNkdOWG9samIwTlJVcVpEbnp4VXN3d21nNyt4dWV0bTIyVXlaWlBF?=
 =?utf-8?B?eVBjL0tJZnRCc3QvWFN2b0FvQ2d5L3ZtSGl0S0g0bnppYjZNVFUzOExMQjhH?=
 =?utf-8?B?WUdvSVV5QXE4TUswY2VBNzVuL1RYN0Y3eE5jTDdFdXdtdnh6aStYby9HZytG?=
 =?utf-8?B?NUVrL2FmL2IyVk1SazdqUXhBYkIzeWkyL2w2UHNKcnNkSFBBYnRXNDJkMUpl?=
 =?utf-8?B?ejBGUFNzajJqSTZwNWFLZ2J2Tlpmb2F2YTZZbytMS2poRzhtQTJuVElHSkRl?=
 =?utf-8?B?T2NkVlR3QTJXQkpiOXRRUG1oUmRqRGFHWnlPK3FBdGtZS3hLVnhUbU5oT2U3?=
 =?utf-8?B?SUtVdmszc2k0M3d1RERpZE83NEUrbzdwMUs4ZFMzS20zdG8zVElnMlFDNEdp?=
 =?utf-8?B?c0Nhakg1NFFZZ2tnL3UrODFhb0pjR1JHVVdrejNqU3FlWGU0c2lMQUk2RVF5?=
 =?utf-8?B?SDdQVS9FelZwbWxWUTBteUx1TVk2VkthVEREcGZ0Y0hiclNYMFIyMkwwYnRs?=
 =?utf-8?B?NXdKcmdQMXlPaTZlWDNuWlNxMGJUT0FQT05uOFNEWHhiaVAycnIwRlhSeU1o?=
 =?utf-8?B?MVFCdkhJUE5WYktqb3kyU3puLzlqdUJVSnRncVZlQklYU0drYlhwMHpVNTlE?=
 =?utf-8?B?ZGRmR1QxS3lFdXlmbWlvTHRzU0dIR3Vpa08vd1k1L2h1enhza2tKL3BqNEZ3?=
 =?utf-8?B?TXVyZFZXUTkvTUYxcTlpV1E3T0ZjYlN2UWw0OFZ0emRvd1BVS0FyRVpqY0FK?=
 =?utf-8?B?VG9LSzVrbFRpZHRDVzdUYnAxcmRYM0JFVzVjZktkWk5kMXFPaTNvRXlLVXZa?=
 =?utf-8?B?QTF3d3hmZSsxVUJpZ3J1S0llNTNqN29vUGE1NDFMR2cyRktKSzhJb2ZrSncy?=
 =?utf-8?B?OWh3QVdQV0g4NEdkRFFoS242OHBqTVZwejRmTVdxWTdSTVZvUHFsbGxITVlq?=
 =?utf-8?B?NkQwaUxrWWIvZnlFeW4xbWZHMms4NW56c2JxWkF2bUVnWnFmQlQwL0gxN1Ra?=
 =?utf-8?B?ZzdzemJ5MGxrMlVyY1lIeTZPSEgwTlVDMTZ1ZUVjYVJWV3pWejlxRG5UQyty?=
 =?utf-8?B?ZjVTNytsZnR4U1JDdndCeEkxKzIwQ1ZmM2lGNkhKSGNPZWF2ZWVMaldodDE4?=
 =?utf-8?B?S3RrUzUvWnBTb01vcDB5SnhHYjZhK3RZZWsxT25UbWM0Q0V1ZFFVZXErTjc1?=
 =?utf-8?B?djl0SldCV1BFUkRUVHI3R3ZTcGpObUZmSjNqUm1paWFLV2MyVDhVWTJnaXNo?=
 =?utf-8?B?NHdiNmE1RkNINUNOTVFEMWVvUFREQlR0MFVUUFZ0TnBMaUIxWmUwNlZPbmhj?=
 =?utf-8?B?NU44S1VxSXBqVnBmTmdDTVhNRjhRVVJvZ0JJeEFWTCtmYWM5VUl5T0UwMG9C?=
 =?utf-8?B?R2oyOWR1Q0NGN1RqbWFUZnZFeUQ2N25zVEZoM2FReU41U1NhSExvbTV0emhW?=
 =?utf-8?B?RFIrSmVSNDVIOU14VVpjYkRNR3ZzZ1hia2t6eXgzQ0VZQ1pLRVJmYnRaQjdI?=
 =?utf-8?B?VFlVQ3lxcGt5dFlmNmVNN0VaTWd1L3lVSklIZ1BkQ2xNQ2xlVGtEZWx2MXJw?=
 =?utf-8?B?MDAvVnVGaU1QMGR0bGQvQUNRVTBzR3dxMjc0bEJNbDZWdndNNWZ0SlExeHpy?=
 =?utf-8?B?RVhCSXo0WjE2eGJ5SmI2S004M0xxOUZTR1V2NnN6VWNHWkNKR3RLZ2VwMzdX?=
 =?utf-8?Q?vWn9qP2P3qlM6fa6C+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b48749c-7a8a-4049-b913-08df02bd062d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 15:24:58.5365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygaifdGHINXlwxkvibP5ZTG1dUMn5TyfiSJEfUHoVTTNRzVoyy+Oqqmvj79YGjgdrEV6F7KuL9X0cH5aXgtsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBa
aGFuZywNCj4gSmVzc2UoSmllKQ0KPiBTZW50OiBBdWd1c3QgMjUsIDIwMjYgMjoxOSBBTQ0KPiBU
bzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1L2dmeDg6IG9u
bHkgYXBwbHkgY29tcHV0ZSBxdWFudHVtcyB0byBLQ1FzDQo+DQo+IEFNRCBHZW5lcmFsDQo+DQo+
IFJldmlldy1ieTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+DQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiA+IERldWNoZXIN
Cj4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjUsIDIwMjYgNToyNCBBTQ0KPiA+IFRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdS9nZng4OiBvbmx5IGFwcGx5IGNvbXB1dGUgcXVhbnR1bXMgdG8gS0NRcw0KPiA+DQo+ID4g
UGluZz8NCj4gPg0KPiA+IE9uIFRodSwgQXVnIDIwLCAyMDI2IGF0IDEwOjEw4oCvQU0gQWxleCBE
ZXVjaGVyDQo+IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IERvbid0IGFwcGx5IHRvIEtJUS4gIFNlZW1zIHRvIGNhdXNlIHByb2JsZW1zIG9uIEtJ
USBvbiBzb21lIEFSTQ0KPiA+ID4gcGxhdGZvcm1zLg0KPiA+ID4NCj4gPiA+IENsb3NlczogaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zLzU2NTgNCj4g
PiA+IEZpeGVzOiA5MWNmMzRiYzVhNTUgKCJkcm0vYW1kZ3B1L2dmeDg6IGFsaWduIG1xZCBzZXR0
aW5ncyB3aXRoIEtGRCIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgOCArKysrKy0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCj4gPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPiA+ID4gaW5kZXggZjdjMmIxNDlhY2Qw
YS4uNDI0MTQ1M2UwZWM4YiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OF8wLmMNCj4gPiA+IEBAIC00NTQ2LDkgKzQ1NDYsMTEgQEAgc3RhdGljIGludCBnZnhf
djhfMF9tcWRfaW5pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcNCj4gPiAqcmluZykNCj4gPiA+ICAgICAg
ICAgLyogc2V0IHN0YXRpYyBwcmlvcml0eSBmb3IgYSBxdWV1ZS9yaW5nICovDQo+ID4gPiAgICAg
ICAgIGdmeF92OF8wX21xZF9zZXRfcHJpb3JpdHkocmluZywgbXFkKTsNCj4gPiA+ICAgICAgICAg
dG1wID0gUlJFRzMyKG1tQ1BfSFFEX1FVQU5UVU0pOw0KPiA+ID4gLSAgICAgICB0bXAgPSBSRUdf
U0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5UVU0sIFFVQU5UVU1fRU4sIDEpOw0KPiA+ID4gLSAg
ICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5UVU0sIFFVQU5UVU1fU0NB
TEUsDQo+ID4gMSk7DQo+ID4gPiAtICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9I
UURfUVVBTlRVTSwNCj4gPiBRVUFOVFVNX0RVUkFUSU9OLCAxMCk7DQo+ID4gPiArICAgICAgIGlm
IChyaW5nICE9ICZhZGV2LT5nZngua2lxWzBdLnJpbmcpIHsNCj4gPiA+ICsgICAgICAgICAgICAg
ICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5UVU0sDQo+ID4gUVVBTlRVTV9F
TiwgMSk7DQo+ID4gPiArICAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQ
X0hRRF9RVUFOVFVNLA0KPiA+IFFVQU5UVU1fU0NBTEUsIDEpOw0KPiA+ID4gKyAgICAgICAgICAg
ICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUVVBTlRVTSwNCj4gPiBRVUFOVFVN
X0RVUkFUSU9OLCAxMCk7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICAgICAgICAgbXFkLT5jcF9o
cWRfcXVhbnR1bSA9IHRtcDsNCj4gPiA+DQo+ID4gPiAgICAgICAgIC8qIG1hcF9xdWV1ZXMgcGFj
a2V0IGRvZXNuJ3QgbmVlZCBhY3RpdmF0ZSB0aGUgcXVldWUsDQo+ID4gPiAtLQ0KPiA+ID4gMi41
NS4wDQo+ID4gPg0K
