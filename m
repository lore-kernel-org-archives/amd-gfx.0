Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE86EEF309
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 06:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEE110E210;
	Thu,  5 Mar 2026 06:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5VwGbGkh";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A463110E210
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 06:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fREHi9kioD3HFyAqcYX04sWL9ELFQ6AhvnSOtiAZ8Mqgvi1lCaC2AmKTH9rOpZ14Wv8J2PpkQbpvTI1OTs3dLSGE4Hw9csiR0sGd11K+mz2/dZiRVjWBp/uYnRNQyBTyyOuBteQ7bj9R3yVNHW30KnYH1s79R6Y2bQpJ54U9TjjzD+fDbuIrokCkdlt6cQi+20bB5bZdQeLjxIrc5gDoMc3NgmtC7CN5bG6DNwY4A1ttrX1pGxo7nm5MtN+JzNZ6RESyie0GgZy6l7ecOTuErpXM5xRn3X/0UvwtQdT2F6AqBk8uvkbTnd495B8RmLCzmxThsQr6wmNTd6E3HL10Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqpThfce6KNcP3ZNSmxZMEzkm0XaLs1aYmnCrr0p4Po=;
 b=GcsuFr3vuFqubeIR1j/uHklbgZaQ9W6qN+0dLGmYicakec6WVeq1IpxXjOUr2kTJxhfNQ3Ew1dXfMFkg1GCBlXxFHMd/TcvukuBpjL7LDPrnIawVSYsdciU0VIQHgmrQ/YJwCcOdGOmGmmQ9Hw2qpsbWumlC1beHRS9/P10mDibWMYr7yUm8U8v5GKUE0k8eRQ3EI0wJKlIo9XuU256u2PVGFqouZXZsyLzbLl7Y38QUxqls4uXUA4EQitsPYe4XjijB4EWeR71ncfWnxNjTsFv+Sl0nG+5BIVWXyrHtvHiaFt7HP/Cd7RX2y8RJMbq5vuqB4QYxrB4ZSn/qUcAyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqpThfce6KNcP3ZNSmxZMEzkm0XaLs1aYmnCrr0p4Po=;
 b=5VwGbGkhGHn0O/rtR3aAWPUs0eAbo1eGnukfYWUq4KVg/Veem0Lp8zx+oCCpWHnYunB5DZ2TZ9rl09Z5E3P4OVRktImTUGhwkovliAY7vnTyzHmqGRoLUQxy5n3mCRJt4bWHZT4QfD9rmyX7TAtbrQAVq+LjEW+s2vicdrG8NiI=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 06:48:26 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338%2]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 06:48:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
Thread-Topic: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
Thread-Index: AQHcq95wC0xBjhKbkkyDodOxFeg1SbWeZckAgAEYT0A=
Date: Thu, 5 Mar 2026 06:48:26 +0000
Message-ID: <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
 <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
In-Reply-To: <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-05T06:40:20.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|DM6PR12MB4484:EE_
x-ms-office365-filtering-correlation-id: 01733015-cb91-4a6b-fc27-08de7a83340f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: MddJhxXYSKodH9QBDWwJjpUty8XaGP+Rl6GZuDoWR2Se5hlZJHXVTKewS+6AI6H6YhlmoqgYQvvpKymOq+NwUWEQfp4ROBHPYY0JQBaChZsJOHVbk4xoOOkDUqSKXTFgoUf0hIFrq1wQOZhMCCq1JQwC1b6+Cn6fHXINOyRwx2nrlR9zmSvl7Br8GmTbGrG2tDgr+gKSRBHUQUd8jFTC1rlfMK1A6rj9g3l5EBkTDqAn4nYzAluJdFW7E7JwM5eOc0vmed20tBEM0v7cDEHI6ATmKfQBj55V6tqL3tS1tRJ5wVwDV1F1byLFnO9ljdYiBAQykdPmjh7LTqP5fN8TMTVyjgn5uPShUH+8wvl0wN+73c7BEXX7YjXv8dPnLnpEMY3I4f1R1o4i/h+RjzllGeI+Y3ssFBz3/h+YwYSIBD2WEO+aeH1C0ssZAQBu8eDMMB/WUDXaYGstznmx0SacpIYW6GcIBNVREcqzV9Jt1pJT/RZA+u8GUita59T4xtiffUx0lMgJOZxh5Qt4wNgvgiXlZmpgiOKpfDDCOPloqNCYAW56YlKgftomEKPsBvC7+B804VNAUDDxxEL60ZTAeOFNI0SvXizVbmSm3rCSPmZJW58yQtLSbw0P5ahH4yhF8hLPvAo2i1xnNs27WQE4rZoDfGOroBjxlTssJ29qDMmOl3rWG/B6q+crlliysaqBuBtFExbvRxwfWcyf2+I1cz1d3lK/XDTlWbPGvUwPwvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9nbnJzL3BycGY5b1NjSk1FL3VUazlqWDQxNndCQzUzbCtUWGlJWm94OGNl?=
 =?utf-8?B?cGRrZjI4dkJTUUJQVmJpeG1QcXFzUDRReTVPWU1VV2FzSU1DelR0ek5ZYjdW?=
 =?utf-8?B?V2gvYTZESTlaQU1hSkFpL0VRcGtXZzJkSWpxQ0RNMThxN2NVSms4L3plVXI5?=
 =?utf-8?B?ZXRub0s5Q1o0ZzFxWTNsRlIybHRDWTBtbkdLUGR1QmxaTGV4dE1icm5rRGJk?=
 =?utf-8?B?MnBoR2prQjJjRkRwTndPR0tpdXhsNWlHNDdrODFjT0RTZUs3V2hJNGZEWjF5?=
 =?utf-8?B?Q211dUVheW11M0ZUbW4yNmpzaFRzejZ4NGN4YTJud3hTN3YyRWgxU3ZmSG4z?=
 =?utf-8?B?KzdPdTRIaHBLeXFmM0JyQVRKQlYzNjgxb2NiZmR3QWZEMHVxTFUyRjF4bzdw?=
 =?utf-8?B?OGt0bVJHQjM3VlhoOExDemhGMHlXc2ttTTladjBla3d4bDdFRHdWNXNTaG92?=
 =?utf-8?B?STVhaXFlK3RJQnFhSmEwdjdlRDFtNndjMmpPaTVtU2RuWGN2MjQ5Nmp1UUFL?=
 =?utf-8?B?N1NaT3FGTHU2RlhMRkZ4ZW5Iamx5THNUZjZWeU9WdW5PMzQzbWc0V3FhMmxp?=
 =?utf-8?B?RjdFTlhMNFkxSldZOVJwT2VqVHBSTUljNThJZk0ybXIwR1NnNEtDWmQzNC9n?=
 =?utf-8?B?QXB4dnp3Tlk1L0RnTG90aEcxQ3UrZHdGV1Q4Mzg4QitCb0tuR05kQVRzRW80?=
 =?utf-8?B?WWcxVWtBSUpOQnF6Y251eXBXMy83SjB6NkMrNHp1bm02ZWNWY09KYU96Vm92?=
 =?utf-8?B?SU5lbFA4UzZRS1VqbDZZL21LeGFiR0hLMjVjeFhKNUZMSE1mTUxQU2ZMZmw0?=
 =?utf-8?B?MUsrOGwvSVJncTVaTk0zQkZNZVhPRVRPNjY1bzhvQmFsZmxnNzNFUUhrQWVI?=
 =?utf-8?B?VktxYktTbzVuVEFvUFdBOHdZVCtCcncyTWMvcUtxUDNiTXYzNG42NzdjaXhn?=
 =?utf-8?B?STEvRkl0NEdOYWFKRVZTTmE1eUhlNTErbGFmVmE2cCtsUFpmaWR1TnZGQ1FV?=
 =?utf-8?B?b05SZHdQTkdYbFNFOCtKaEdaZzNoblhiZ05zei9PcW1FVjBkZlpybkQzbEgw?=
 =?utf-8?B?NFhSZmV3Y2R3dXlNdjJnMzFoKy9nN3VRaGw4Nk5PT2FsanlXTGY1b2NVTGw2?=
 =?utf-8?B?cDdIUHVGQnJZYUtiY1NTamdYMU5od0MxaHpSUUwxVmhSK2twUUZNVTAwN0V5?=
 =?utf-8?B?QWZTN0xmY3lGSlZhUmNiMlluZGEvSkR2YXdsVGhhZ3dFTzdYN2FTWUtpQ1VN?=
 =?utf-8?B?UGYvQSs2ZGFtWE95K1l1SjdyUEhEV0hVZ0d6Q3NFdkJBMS9MdjlvOTBZRUdF?=
 =?utf-8?B?Ymg1c2lOeklOSlh3V254SW5wRnhPSHVlWWNZU2FBVnJURXpMTG9NS05HSHV3?=
 =?utf-8?B?bGRUclczSnJzSkdySTZoZUk4VE1xN01FMWhhTExkTVdJTktQZytUWlVVTEZm?=
 =?utf-8?B?WnRmenRMRTNpRk01WmxTM2ZkNEZ2dllldE50cnBvaHVnNlZESWZHR2M4dTRL?=
 =?utf-8?B?d21jQnFXM2huNXZIZ0Y1dWYzblczOGhVcVNRZnhvK0Uwb2RHMkxVUzk2Z2tD?=
 =?utf-8?B?dklxWnYwVGlGOW5mUUJYVUhlWkNBanl0YTVtYzRlM2I4TEhXdVZIejUwcngw?=
 =?utf-8?B?TWNMcWVrRzAwVkxYVVFHZjJYaERoaXBuckJBTWg5emNnRStRUkFZU0JNZFFO?=
 =?utf-8?B?eEJqZXl0V2NJVkJvZmpsWHpLUUlrbkJUTnlETmNHK1pPM2RaWVh0TlZVRTRT?=
 =?utf-8?B?TFNRWVVMdDZvb1BvaXpVMk1xNFRsSEZ5WG1qd2l5VkdaZTdTU2hpMmh3Tmk1?=
 =?utf-8?B?aUt6MVhhekhJKzlJU2xoQ1pjam81L2RyQ0doM3ZWNTBUMzBwdWZoak5wRHpZ?=
 =?utf-8?B?ZHdHcVFUajI4eGZrbm1Zb25DZlV3b25ubVdneUNlcHJManp4anJsT3hSMU1q?=
 =?utf-8?B?c2dOU1hGU0tpNFB4cTVMbTVaZThXODRpNERYNTRvQTVTT2RLZzl4WkJvMG15?=
 =?utf-8?B?YVhrWEdnY0QxL29zK1Zndkl0T1hFajd6aU1wVmd2eG01RTBFVm5yYWIvajR0?=
 =?utf-8?B?M2hXekZqT2FxZkNsTkN0QnZIcjdMNU4vR0JuYjVQS0ZiN2JtcGFyMUl5a3ZM?=
 =?utf-8?B?cS9PY21vb0hiaVV3WDJ5d21GMU5YSGNPdXhhczNYWWRDVGRMTmZ4KzV4MTRu?=
 =?utf-8?B?T1pJRi9ONjhOOS8weXk5S3BlRVJaMHNYYmFhWTFTTnpkSFRpMW84UXk5MjJh?=
 =?utf-8?B?bWxOK1JmRk9rbkFXek15M0E2eUN4cmhqb01uVVg0NTdJNkRodjJnc3RlZktS?=
 =?utf-8?Q?DTGF5fL7A03yBZTGF4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01733015-cb91-4a6b-fc27-08de7a83340f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 06:48:26.5423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEi1qE9DjrTKLDjzWed/dNqDQLxy2W0aUrdV21DpUn4qxbQs9+rjhzAduO3Exu4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

W1B1YmxpY10NCg0KSXTigJlzIHBvc3NpYmxlIHRoYXQgd2UgZmFpbGVkIHRvIHNhdmUgYW5kIGlu
dmFsaWRhdGUgc29tZSBhY3RpdmUgcGFnZXMgZHVyaW5nIHN1c3BlbmQsIHdoaWNoIHRoZW4gcHJl
dmVudHMgdGhvc2UgcGFnZXMgZnJvbSBiZWluZyByZXN0b3JlZCBjb3JyZWN0bHkgb24gcmVzdW1l
Lg0KDQpGb3Igbm93LCB3ZSBzdGlsbCByZWx5IG9uIHRoaXMgcGF0Y2ggdG8ga2VlcCB0aGUgdXNl
cnEgcGFnZSB0YWJsZXMgdXBkYXRlZCBhbmQgc3luY2hyb25pemVkLiBVbnRpbCB0aGUgZnVsbCBz
b2x1dGlvbiBpcyByZWFkeSwgaG93IGFib3V0IHdlIGZhbGwgYmFjayB0byB0aGUgaW5pdGlhbCBh
cHByb2FjaCBhbmQgcmVzdHJpY3QgdGhpcyBUTEIgZmx1c2ggdG8gb25seSB0aGUgdXNlcnEgcGF0
aD8NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA0LCAyMDI2IDk6NTcgUE0NCj4gVG86IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgImRybS9hbWRncHU6IGF0dGFjaCB0bGIg
ZmVuY2UgdG8gdGhlIFBUcyB1cGRhdGUiDQo+DQo+IE9uIDMvNC8yNiAxNDo1NCwgQWxleCBEZXVj
aGVyIHdyb3RlOg0KPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZjM4NTRlMDRiNzA4ZDczMjc2YzQ0
ODgyMzFhOGJkNjZkMzBiNDY3MS4NCj4gPg0KPiA+IFRoaXMgY2F1c2VzIGZyYW1lYnVmZmVyIGNv
cnJ1cHRpb24gYWZ0ZXIgc3VzcGVuZC4NCj4NCj4gQnV0IHByZXZlbnRzIG1hc3NpdmUgbWVtb3J5
IGNvcnJ1cHRpb24gd2l0aCB1c2VycXVldWVzLg0KPg0KPiBJIGhhdmUgc3Ryb25nIGRvdWJ0cyB0
aGF0IHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgRkIgY29ycnVwdGlvbiBpbiBhbnkgd2F5LCBpdCB3
aWxsIGp1c3QNCj4gY2hhbmdlIHRoZSB0aW1pbmcuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlh
bi4NCj4NCj4gPg0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9hbWQvLS9pc3N1ZXMvNDc5OA0KPiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQo+ID4gQ2M6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4g
PiBpbmRleCAwMWZlZjBlNGY0MDg1Li4yNWIxZDY3OWJhMjYyIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBAQCAtMTA3Myw3ICsxMDczLDcgQEAg
YW1kZ3B1X3ZtX3RsYl9mbHVzaChzdHJ1Y3QNCj4gYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBh
cmFtcywNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIC8qIFByZXBhcmUgYSBUTEIgZmx1c2ggZmVu
Y2UgdG8gYmUgYXR0YWNoZWQgdG8gUFRzICovDQo+ID4gLSAgIGlmICghcGFyYW1zLT51bmxvY2tl
ZCkgew0KPiA+ICsgICBpZiAoIXBhcmFtcy0+dW5sb2NrZWQgJiYgdm0tPmlzX2NvbXB1dGVfY29u
dGV4dCkgew0KPiA+ICAgICAgICAgICAgIGFtZGdwdV92bV90bGJfZmVuY2VfY3JlYXRlKHBhcmFt
cy0+YWRldiwgdm0sIGZlbmNlKTsNCj4gPg0KPiA+ICAgICAgICAgICAgIC8qIE1ha2VzIHN1cmUg
bm8gUEQvUFQgaXMgZnJlZWQgYmVmb3JlIHRoZSBmbHVzaCAqLw0KDQo=
