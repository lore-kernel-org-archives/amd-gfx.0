Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343FEFD530C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 08:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03D310E15B;
	Fri, 27 Feb 2026 08:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sabWI6Uu";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5D910E15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0AQqM8qln+YrZtgWhlOu3BpZtc8CYtCi62nCVcciG6Tl96AzQwiX0EAHc2Q1d2zrVgn3p0xOykQJLsZW1aYqKjp82LjIvpCgOLeTnMwtaZHvA2VUeBzOFg4/DVOFrtOcOp0lQq4TK+B+PbvwPu/EeutvH59s1G6vGdzZO7AeVElDP+cOBgd2MvzU0ZO7L4/VRKHDTbG0XapKxw5BgTWEVlqbxxyPBV9JatihtK2WvIfqcKYHkoP9+Ac7AN6Kso8aVDHeEL9omopFlpIazRppMhs1qCfx7X82FTswbYQ1rLDjvbz6edZ/ZW4yd7TUYdlRGrMmz5xaLyGeJDBQO042w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZul1sVKP20f4EMiEXKPVVDeBX8nqoveRrorPRk9Bdk=;
 b=PCup7Apg78FEA3eSQLbIdnftwujT5CM5n1Ms5HLOodjws2AFkxQzmnl8n61GAhdI44eaD/OYaNhjqVQOUIo5HFrg2ov/u1OUOn2n3EdgH3K5bpTc+qxRQ8Y5eK80o4ACuaJQYDo3uRePkzF9kFWgDjZPT7/yGu4nyPu8imF4J8umKE5tazomf3Q8LwW4tbo9dlPIW0X1SuUsBl9SNn0L+FVRBsNWa1AMaoO8IU3X0f1K7hD1mcGFtHVRp9/QynKNaOq5xfJccRSaZ6lLNSDlJ9mowaVwbFv/TIY/NrJ09/+6mVpjcqnCjviELtXX9fF0UUfzoJP+MFLJf5fHS41WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZul1sVKP20f4EMiEXKPVVDeBX8nqoveRrorPRk9Bdk=;
 b=sabWI6UuUgvmlwoKJl9HdkqViO2+MCnF2oYI2B4yFlQRxWar+1cVq1A/xZDlQGdCl820G1WNabR3jJHGvucrieSh17pEgRgsTU+LO/2jxEytIxqY4GQ4n7RMkUMbZC8l4G7SA8LXr+GkALzKM4C/dMyvkTRQp3bNzGLyIm2kVKQ=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 08:06:12 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 08:06:12 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Topic: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Index: AQHcpjny217/7Nl9CES1HXuG3NSqnLWTUUCAgAAnDYCAAoKpoIAAD6yAgAAgqwCAAAT1gIAAARUg
Date: Fri, 27 Feb 2026 08:06:12 +0000
Message-ID: <DM6PR12MB2972B553D5C65B858CFC24018273A@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
 <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
 <DM6PR12MB29725599B2FE50BD48D442238273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5e1692a3-40f1-4adb-9a7f-7db064a0b11c@amd.com>
In-Reply-To: <5e1692a3-40f1-4adb-9a7f-7db064a0b11c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T07:58:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN0PR12MB6149:EE_
x-ms-office365-filtering-correlation-id: 39dd14c3-3f19-4af7-0351-08de75d712b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: RRuzp7hnh2Wh5mjCIIY34nQQYVaU7BJOG8haJbW7GSudxJwePAp78X0XYiZcYf3fEBsBiuPSCU/NTn1Mj4JOOyxAI+FK/5Ki8oGG0KWtgpVY+i8hTmvFPREykbegQ4r3ziIOChXi7LGAAR8AoKUncG5gEoPanHL5MhIzzWc8b/cBFbRY2dUNc1+I061j8Cs5th/W9WtF9DLcAhCHhvZmUfvOjSRKBEhEQ11lCBoQKZel+yw+iDd/KhXfd+WchQ0b25ML1X/y/6IKkT0v2K0AqoZ7LEjBgBuZoPxGMRYfg3HDEiFnw3i9f1mZJo2MGRLjB+79pBpKCt78fQ7/THoC3KeRCL2bqZ7eOBoBQ8VuMbAjvpfQSMcVJYfS+Jvzf+eFSlVzs3/U1lqgzh0NI1Y4bX2R7X8dnqe1ix6xkSFYOqLq//lANayK/UYL5iIMazQ1IDLjKIAaNgq/Oa0wyXx/nvfDWWFeg7CD/hD9Q0qBN1u5YT5TT7DYqZkgQ6hR7/xiOHgVy64G8U/QFRw6ZarfMBOcIqLuk1frk7Y9Y4WMe33OYkvYGIrL4Nz89uj1ScN6CuwfScjU883pUmWG1tEuZjXtgZOJCeBNCinfwFDxLFQ034CYW5h13CMQ/B7M8m1DK6uTHekGQfENqKemIvRJUEQywDWsz6EtUTy+B2VhUzqWOMXodO5oh7Y7AM54XQUXnkFTXcysmN+rv4HhSClo7Hla3YDJzXaa2/PkB99BrdB2M4MsopQg/O6vmrIq1jhF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzlLTWxjTGpaR3pGZGMwL1cvUEM0enkvcHA2L04wbVROMDJrK1UvM1lKcTMy?=
 =?utf-8?B?VjBSZXg4Z1hpT0N1T3FLMjRxNERReGxXWVBIemFLc2lZWm1RVGp6SlB4c1gz?=
 =?utf-8?B?SVlaM2ZjL04rWlVQY01xc3ZIV2ZrQWtRNms3VU1XK295U2FRV2xFdXFITnJw?=
 =?utf-8?B?U28yRkQ0WklSQ2kxRmhJblhFRDFaMFF5YjU2U0ZlYkR6SmFjamNjWUd2ZU9S?=
 =?utf-8?B?eU5KZmxMUHdyOFpKZVhNZDF5NDVRVlA1UnI1OVNFWDEvYmxlNHB3UUNMczFr?=
 =?utf-8?B?R2NhTkFDZ1YyVG0xTWgvOG1aZzRJbW5ReXZFUjNZTXUyQklMcUx3Qk0wZjM3?=
 =?utf-8?B?ZWQ2R1pWUk5kYWRSUDEvSU5PRmtKVHFHYmxoNEF1cS9Cb2ZUSERGZGRjaHZ5?=
 =?utf-8?B?U0Z0Rmo4ZlM4eE0ySWJWbTIvTkZTUHorN0NiTWljNTlrc0VZTFdoWXg3U1dU?=
 =?utf-8?B?SzZGVWdRVXNZUGxCYzB1am5FSWFGOXRoV3laYThBWnBVQmMrN0RnS1hEZS8x?=
 =?utf-8?B?a0hLSXRmMGF1VW1SdlJDZENCR091RWMwdU1NYk1YWlRTazREQnpOZUY2VXlW?=
 =?utf-8?B?VXFjWkt3Y3IrWnlIeTBicmVvVVY1OWpuUkt0c1Bwbzh6TUMyNGFUbVAyd1Z0?=
 =?utf-8?B?TjgvcjdpeXA5K25RZEJueXo5MEJPMzFhVDNKV1gvNVg0OXBHWHBkeVNicDFa?=
 =?utf-8?B?UlR5ak12aU0rck9QZkVjakF4bFhzK09JRjFmZXpad3lGN0ZKZkd5UURYTnNo?=
 =?utf-8?B?bHQ5MG1tQjlRdzhQUlJqOS9QRnJnNm9xTVlWVFU4azByWU02OHpYNU5lY3Rl?=
 =?utf-8?B?QzdNOW41UE9PMi9NQUhzYjdqbDllMUlZRTlxL29kUXFGMm9PNXU0VmlkZjY1?=
 =?utf-8?B?MUVvbHNXNEFpZWx0R2R0WjJIYjNFZEZuNWdaQ2k1aXo4UnZZRmdLcklFNWdD?=
 =?utf-8?B?b3ludWt2RTZkblBEa3R0VmdxanhCTjdOWERFWTliZ1lPTUJDNEZ2TUJUeEVL?=
 =?utf-8?B?TzZGVndsbGhmc3dsVmlsblBYMXNxWGV3UEFWbHd1NW4vRXEyWjcvWWIvTDZT?=
 =?utf-8?B?QUJxSStWcWlLZGNSbVJYekcwYUx6dGl5SGFYZEJDM2RIT1BrbmNjVUxjZGl1?=
 =?utf-8?B?VmNoMnhWdldKaTJjMGRmSFVjSGlJM21CL1MrMmFrMzk1NFljQjlXSzJYNVha?=
 =?utf-8?B?K2pLdld1VkdxaEorU3VuSVdycklLb3A4UGVUZWlibTJwZUpRaWhhd2hjd2pr?=
 =?utf-8?B?Qy9IZkdjNjlQVkt2a3ZmWi9yc0tJa3BXWiszNzd4NWpDWVlCUHd3NjZaV3ND?=
 =?utf-8?B?UlN1SGlLTTd5STlWNFBGQzhneFZueERTeEFDNlhNYXdXM083NTdBOFVIZFdz?=
 =?utf-8?B?ODZKUTViWmtxVk54YXhHUGYySTRGdEZocVNBRGJrUkh0UXNPM211TG5GOFhl?=
 =?utf-8?B?LzlWM3lkTExpdXBKdWdac1NtNXl3SmVScC9ldlVxTktxUVAwL0J5VlpWUUsw?=
 =?utf-8?B?SUVCN3N0UHFmbE83TUh2S1ZrdmFvT0sxUFJ5RHRrbWVHM21aWVZPNGpDVHZS?=
 =?utf-8?B?WGZyOHpkaFg2eDlUVkppbThmQWFTRVAzMHRMTkwxWmRPcW53NGlUL1dla3BB?=
 =?utf-8?B?Q2RsTVZVS29SVlVEZGsvM3VCWjlwYkVwMG45RERCWGhSOUFuVHV3UlUwK0hD?=
 =?utf-8?B?WVZaOFZyM3BtMXp2UEVPNzdEWkVSc0hFUFBWNTNGeEVkR2VVelVvTnRYb1No?=
 =?utf-8?B?L1QxVHZrWE5FVGtucDJWcGo1SzZqdUQvbHdyOVhIeU1POVZRWjk5VkZQVG5M?=
 =?utf-8?B?clNGM2xoVndqUXlkN1hsUFRWeGxPbjNXcEZSMDg2QndySnNQaWUyT25OY1Bp?=
 =?utf-8?B?Y0tEWFRsLzFWTGxWcVFsVlYzY1BMVjdOYktRV1hIMEtuMDE0SDlkYzZGVTRy?=
 =?utf-8?B?cjVUa3pPc0gxdkR4RzMvamVIZ0xiM2NYSk9iZXArV0tUTU03eDR3c2kzZFRK?=
 =?utf-8?B?dWJYelcxQmdobklTdjhERG5lRzk0K0FadFRMelR5ZVVTc3JIS3NnWXBuRE9z?=
 =?utf-8?B?M2VEb21CZ2NPdHhhV29hNGNaWDdiVklwcFJGcmYzeVg5NS9YenJTY3RWRnRt?=
 =?utf-8?B?cjBBN3dXRzdmQVp5ZmpDOENSaTljZjVVZzJBdDl3eWlNZmRFcUtwU2Q2eDhq?=
 =?utf-8?B?UmlvSnA1ZFdpbXRsQ3hpWnZzSzdXdW9kNm1VckJhWW43eUo3U0ZnSm51QmRz?=
 =?utf-8?B?NmJCTEU5Z05TdkFRWVRNUjdPbDJOMUNoRU9mMGZveG1ET2NrTE1waDFPclUv?=
 =?utf-8?Q?NFDLv6ypBiFYy3OGJN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dd14c3-3f19-4af7-0351-08de75d712b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 08:06:12.5328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOJFD4fbbNFyBgxflapUSQdVm0tG3DqMMVcPhBCns9joVEBCJtxB7j5jGrtpYNht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
Cg0KVGhlIEtNRCBzaG91bGQgYmUgcmVzcG9uc2libGUoZS5nIHVzZXIgbW9kZSBhcHBsaWNhdGlv
bikgZm9yIHRoZSByZXR1cm5lZCByZXN1bHRzIHJhdGhlciB0aGFuIHNpbXBseSBmb3J3YXJkaW5n
IGZpcm13YXJlIHZhbHVlcy4NClNvLCBJIHRvdGFsbHkgZGlzYWdyZWUgd2l0aCB5b3VyIHBvaW50
LCBhbmQgd2UgbmVlZCB0byByaWdodCBwZXJzb24gdG8gcmV2aWV3IHRoaXMsIG5vIGZ1cnRoZXIg
ZGlzY3Vzc2lvbiBpcyBuZWVkZWQgd2l0aCB5b3UuDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJA
YW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjcsIDIwMjYgMTU6NTUNClRvOiBXYW5n
LCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3
a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5n
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiByZXN0cmljdCBzZW5z
b3IgbG9hZCB2YWx1ZXMgdG8gMC0xMDANCg0KDQoNCk9uIDI3LUZlYi0yNiAxOjE1IFBNLCBXYW5n
LCBZYW5nKEtldmluKSB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gVGhpcyBpcyBub3QgYSB3b3JrYXJvdW5kOyB5
b3UgaGF2ZSBtaXN1bmRlcnN0b29kIHRoZSBpbnRlbnQgb2YgdGhpcyBwYXRjaC4NCj4gQWxsIEFT
SUMgbG9hZCBzZW5zb3JzIG11c3QgYmUgY29uc3RyYWluZWQgdG8gdGhlIDDigJMxMDAgcmFuZ2Uu
DQo+IEluIG90aGVyIHdvcmRzLCB0aGUgS01EIGRyaXZlciBtdXN0IG5vdCBibGluZGx5IHRydXN0
IHRoZSB2YWx1ZSByZXR1cm5lZCBieSB0aGUgZmlybXdhcmUgd2l0aG91dCB2YWxpZGF0aW9uLg0K
PiBGb3IgZXhhbXBsZSwgaW52YWxpZCB2YWx1ZXMgbWF5IGFyaXNlIGZyb20gaXNzdWVzIHN1Y2gg
YXMgbWVtb3J5IGNvcnJ1cHRpb24uDQo+DQoNCldlIGhhdmUgbWFueSB1c2VycyB3aG8gcmVhbGx5
IGNhcmUgYWJvdXQgdGhlIHZhbGlkaXR5IG9mIHRoZSB1dGlsaXphdGlvbiB2YWx1ZXMuIElmIGZp
cm13YXJlIHJldHVybnMgYW55IGdhcmJhZ2UgbGlrZSA2NTUzNSBhbmQgZHJpdmVyIGNsYW1waW5n
IHRvIHNob3cgYXMgMTAwJSB1dGlsaXphdGlvbiBpcyBub3QgdGhlIHZhbHVlLiBXZSBkb24ndCB3
YW50IHRvIGNoYXNlIGdob3N0IHV0aWxpemF0aW9uIGJ1Z3Mgd2l0aCB0aGlzLiBJZiB0aGVyZSBh
cmUgaXNzdWVzIHdpdGggY29ycnVwdGlvbiwgZml4IGl0IGluIHRoZSByaWdodCBwbGFjZSwgYnV0
IGtlZXAgdGhlIGludGVncml0eSBvZiB1dGlsaXphdGlvbiB2YWx1ZXMuDQoNClRoYW5rcywNCkxp
am8NCg0KPiBCZXN0IFJlZ2FyZHMsDQo+IEtldmluDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgRmVicnVhcnkgMjcsIDIwMjYgMTM6NDANCj4gVG86IFdhbmcsIFlhbmcoS2V2aW4p
IDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgQWxleCBEZXVjaGVyDQo+IDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47DQo+IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiByZXN0cmljdCBzZW5z
b3IgbG9hZCB2YWx1ZXMgdG8gMC0xMDANCj4NCj4NCj4gT24gMjctRmViLTI2IDEwOjE0IEFNLCBX
YW5nLCBZYW5nKEtldmluKSB3cm90ZToNCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQg
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+Pg0KPj4gUGluZy4uLg0KPj4NCj4NCj4gUGxl
YXNlIHJlc3RyaWN0IHRoaXMgd29ya2Fyb3VuZCB0byB0aGUgYWZmZWN0ZWQgU09DLiBPdGhlcndp
c2UsIGlmIHRoZXJlIGFyZSBib2d1cyB2YWx1ZXMsIHdlIHdpbGwgZml4IGl0IGF0IHRoZSByaWdo
dCBwbGFjZS4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+PiBL
ZXZpbg0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgMjUsIDIwMjYgMTA6MjQgUE0NCj4+IFRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPg0KPj4gQ2M6IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsN
Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4+
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47DQo+PiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IHJlc3RyaWN0IHNlbnNvciBsb2FkIHZh
bHVlcyB0byAwLTEwMA0KPj4NCj4+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDc6MTTigK9BTSBM
YXphciwgTGlqbyA8bGlqby5sYXphckBhbWQuY29tPiB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4NCj4+
PiBPbiAyNS1GZWItMjYgMzowNCBQTSwgWWFuZyBXYW5nIHdyb3RlOg0KPj4+PiBMaW1pdCBHUFUv
TUVNL1ZDTiBsb2FkIHNlbnNvciB2YWx1ZXMgdG8gMC0xMDAgcmFuZ2UgdmlhIGNsYW1wX3QgdG8N
Cj4+Pj4gZW5zdXJlIHZhbGlkaXR5Lg0KPj4+Pg0KPj4+DQo+Pj4gSXMgdGhpcyBhIHdvcmthcm91
bmQ/IElmIGl0J3Mgbm90IHdpdGhpbiByYW5nZSwgaXQgaW5kaWNhdGVzIHNvbWUNCj4+PiB1bmRl
cmx5aW5nIGlzc3VlLg0KPj4NCj4+IExpa2VseSBmb3I6DQo+PiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80OTA1DQo+Pg0KPj4gQWxleA0KPj4NCj4+Pg0K
Pj4+IFRoYW5rcywNCj4+PiBMaWpvDQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBXYW5n
IDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0N
Cj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVf
cG0uYw0KPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4+Pj4gaW5k
ZXggOTM4MzYxZWNhZTA1Li44NmVmMWZmYmYxZGQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9hbWRncHVfcG0uYw0KPj4+PiBAQCAtMTQxNCwyMCArMTQxNCwzOSBAQCBzdGF0aWMgc3Np
emVfdA0KPj4+PiBhbWRncHVfc2V0X3BwX3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+Pj4+DQo+Pj4+ICAgICBzdGF0aWMgaW50IGFtZGdwdV9wbV9nZXRfc2Vuc29yX2dl
bmVyaWMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGFtZF9wcF9zZW5zb3JzIHNlbnNvciwNCj4+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpxdWVyeSkNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqdmFsKQ0KPj4+
PiAgICAgew0KPj4+PiAtICAgICBpbnQgciwgc2l6ZSA9IHNpemVvZih1aW50MzJfdCk7DQo+Pj4+
ICsgICAgIHVpbnQzMl90IHRtcCA9IFVJTlRfTUFYLCBzaXplID0gc2l6ZW9mKHRtcCk7DQo+Pj4+
ICsgICAgIGludCByOw0KPj4+PiArDQo+Pj4+ICsgICAgIGlmICghdmFsKQ0KPj4+PiArICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+Pg0KPj4+PiAgICAgICAgIHIgPSBhbWRncHVfcG1f
Z2V0X2FjY2Vzc19pZl9hY3RpdmUoYWRldik7DQo+Pj4+ICAgICAgICAgaWYgKHIpDQo+Pj4+ICAg
ICAgICAgICAgICAgICByZXR1cm4gcjsNCj4+Pj4NCj4+Pj4gICAgICAgICAvKiBnZXQgdGhlIHNl
bnNvciB2YWx1ZSAqLw0KPj4+PiAtICAgICByID0gYW1kZ3B1X2RwbV9yZWFkX3NlbnNvcihhZGV2
LCBzZW5zb3IsIHF1ZXJ5LCAmc2l6ZSk7DQo+Pj4+ICsgICAgIHIgPSBhbWRncHVfZHBtX3JlYWRf
c2Vuc29yKGFkZXYsIHNlbnNvciwgKHZvaWQgKikmdG1wLA0KPj4+PiArICZzaXplKTsNCj4+Pj4N
Cj4+Pj4gICAgICAgICBhbWRncHVfcG1fcHV0X2FjY2VzcyhhZGV2KTsNCj4+Pj4NCj4+Pj4gLSAg
ICAgcmV0dXJuIHI7DQo+Pj4+ICsgICAgIGlmIChyKQ0KPj4+PiArICAgICAgICAgICAgIHJldHVy
biByOw0KPj4+PiArDQo+Pj4+ICsgICAgIHN3aXRjaCAoc2Vuc29yKSB7DQo+Pj4+ICsgICAgIGNh
c2UgQU1ER1BVX1BQX1NFTlNPUl9HUFVfTE9BRDoNCj4+Pj4gKyAgICAgY2FzZSBBTURHUFVfUFBf
U0VOU09SX01FTV9MT0FEOg0KPj4+PiArICAgICBjYXNlIEFNREdQVV9QUF9TRU5TT1JfVkNOX0xP
QUQ6DQo+Pj4+ICsgICAgICAgICAgICAgdG1wID0gY2xhbXBfdCh1aW50MzJfdCwgdG1wLCAwLCAx
MDApOw0KPj4+PiArICAgICAgICAgICAgIGJyZWFrOw0KPj4+PiArICAgICBkZWZhdWx0Og0KPj4+
PiArICAgICAgICAgICAgIGJyZWFrOw0KPj4+PiArICAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICAg
KnZhbCA9IHRtcDsNCj4+Pj4gKw0KPj4+PiArICAgICByZXR1cm4gMDsNCj4+Pj4gICAgIH0NCj4+
Pj4NCj4+Pj4gICAgIC8qKg0KPj4+DQo+DQoNCg==
