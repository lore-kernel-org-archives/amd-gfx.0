Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA9EA4E21
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 15:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EF010E521;
	Mon,  2 Mar 2026 15:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzaUGTVH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2767510E522
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 15:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMbhrgvTSv5QK0TrjuC2v3I/l1add40KLHe5ZwqAxuCE1kl+kuj6Qqt1xm5r1GYmbVvwW6rnoxjLKVKXesrPHx+5Weg5sWqG0DwddYuDUVurCy5X4Dk4VfiAVIB19sCr0mklf5BmX5rb2dINv7z8WR0OezkOzrXQvX95Tdm0d6eUGwjYBkCgB64S3RP+p0gJa0JhQN0cY6F3wycLDyBZJ3GLfv5YNiuwtWkihs8JtEryU7jX6WZNVemh4mjl3fXVlM9TvleHIkiTQDwJwgUcuzPK8MWUy76MxTyHBqXHLD9P/ZGkt7ANk9i9YbnX3pJC/Ezf4AQfFeiE/cl/cg5G9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJw0xqurefSGQMoxIRDx6aX+4/QDPW0bSa9aC8r0c9M=;
 b=HBtzQWP746j7nm245d+uEdWPpoUc2K2FEH80bNEi6W3X2yqddHoyjPEANgCHIyHIf5a9xxKn0VkchE88uRomoifPVBXzKzZa1pQ3PwvYIPnubpuadDYZSDcO9HA0mE5agxSThHOEIc+FsCiYID3WY0ss7R64VBVItcHngDlLdBwcb1dakquuyVvWBx4m5kqIdS42A1SnXW8mpbBGySuDHrAxRzP7V4XKoNd1TKIpMfIiL2U3bpAqKwELdpSPHK22O9Q32LWrW75KSkiOgMIeOq+5HS0M3CtK8n6KcWWPwI8SFpnpwAjqseDytd7UG8wuT4JQWndG73Fc30Z20qFWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJw0xqurefSGQMoxIRDx6aX+4/QDPW0bSa9aC8r0c9M=;
 b=zzaUGTVH7fA9VzHgfSHI71QsOjVWJDj/RhciZA4wfGuWSAtciWvHSWPiazRxYORku6wsee/h1HGrkNJvpCG3wdLFIXYTfy9gJyBpWwFCM5qbXuODnqLpg+5vO3k/qd5b9RGiXurfhNOhpVhwai1pRmYQstwQvi0G02LAmIM/BTQ=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 15:18:21 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 15:18:21 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix mutex handling in
 amdgpu_benchmark_do_move()
Thread-Topic: [PATCH] drm/amdgpu: Fix mutex handling in
 amdgpu_benchmark_do_move()
Thread-Index: AQHcqM8S/QPhonncSEKYB2MuZxUZpLWa7mcAgABvXCA=
Date: Mon, 2 Mar 2026 15:18:20 +0000
Message-ID: <IA0PR12MB82084F58871DD50063FF7989907EA@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260228162640.1697925-1-srinivasan.shanmugam@amd.com>
 <810028fa-332e-4b62-8792-747d39ca0516@damsy.net>
In-Reply-To: <810028fa-332e-4b62-8792-747d39ca0516@damsy.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-02T15:17:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH8PR12MB6890:EE_
x-ms-office365-filtering-correlation-id: fda74573-809b-4652-dd24-08de786ef0a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: CsVcT9PTHstBwsgMpE3MgJuPOrJLlHyvuKw82uw70m5xhmVrm6wGli7L245KpTd5usuQQPn9/rgXSd4yvcAwF3jVRI9fi/Fvm20st6vsuXgu3Fm2V3JNjZnyGryLdhJI/2bavtmaWsU5JmiZqz6T2sCJloSu9lpFSKxAdtXsOnGQ7ezedfdgQ8Bi6iT4wF9PemJKzYB4l8gHvtWeJx9m6PaE9zNuF5syDZD3CqueZZnVKQO6lk/9zG1X204LfMgzjoKfGvZPEfBqzLX8mXSokJO70SdNREtvKSFT6pWlB0j6y2rbHA/iWzR1UKKU6BW3ErJz8qpKbtBRc6bPhFccGHRVjEd2XbdXucp8tydaa8boaIo0+hBG4wbiRoutYHcjz4aoWVOf8B1hqIyn84vCVFK3ZNqSj9XsWmxM5lI7GyTjwqHU86dygFOj0BXpY5+F99EhxwP6NGkKdHGG/e0sqR7Gn/epAAZwrzUWK6fAZML+gTTeZ6Ntwa8AN6qc0ZGdkl91sVYWKX7KGUDcHAIUevx/bRNcHDj4ssIPYYh/X3I/o0+rAYsrV+TfmaO63oU0k+8voUpbWqvYrMJKwO3mWLLwUbws22OsAAD86Q0hXs6xpc6HdLKjE8d7WF+rmaPsHW4Mlae64eV9Ja2jUoL47b4wePHp+uth1zPEYibKm/zCaB/2qypEVS2+QpHAvH8teI0RplT6gFLXLTjGbXJeOriZOyskiIFIJZ1l7r2vSQzkc7WI0dl0hsUrtHZb2TKZ99rrYhPHkgLvlgM6NWSixgrIue8FT4APZu8lFTx1XbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxuRGlDZ29KM2N0Z2MrUlhCMjNPNGlXckwrRW93Vmt5V0tMQk9SSS9RSVFY?=
 =?utf-8?B?RENDQURpSndOTXJnSHk5UlRGSXl3T2VjV1ZtVFl1TEo0NCthMEpoc3UyUkVk?=
 =?utf-8?B?b1BrK0hhN1VYek91K1pSbVZ6ZUpvVS9HcjNuZWJiZUplWDkrVW1lK08xK3NU?=
 =?utf-8?B?L3A3WXFrTTNkdFZwUnZMQUxOdWpybmxJeTBGeUQ3VGovdjRPYWRhTjVKNnh0?=
 =?utf-8?B?eUc0ZXRZY2FPeStPNWh5L25pcXBDY0M1UEJJQ3o3ZU1ublBybWdhT09xM3k5?=
 =?utf-8?B?c0FEejBpczZrcGNZRmc1cEZ2VUxKc245am1zWDdDa0FNeWJNRThQMjBzc05r?=
 =?utf-8?B?SWhvanZmdEEyYU55ZVBFZHR0RDB2RDRlZzZieXhNQ0xCdU5rVkwxTmdtc3JS?=
 =?utf-8?B?QjdIS043S0pYblI2aEE1UGVUaDhjcEY1ZzF2T0l4ckcyM1ZrMzN3RkhFa1lx?=
 =?utf-8?B?ZmR5ZnlNbTFPY2lkaWFLckNYN0I2MFpSQUhlM0t6MU5UcUxzNUdqSWtUWlJv?=
 =?utf-8?B?VGdUN0hjdTFaWXM4ZG9DVVlsZmZFRU9ybDNMVnZoSVc2enJ4bzFnQTFOM3JH?=
 =?utf-8?B?bUo4UktDU0F4dnF5V3BnSW1nT0JGbDV0eTVmZVA4Y1dqV0RFdUYxbXU0aVlI?=
 =?utf-8?B?bFdCaVdKQVlFWGpyWjBTQnAxK0JQSUxDMHhTV3lub3pmb29pczMzRXUxQUIy?=
 =?utf-8?B?MFk3MTRvcHpHbnZ2VWxXcW1NTWpXejl4SnFrM2tXeFZBQjA4UGoyVnZhZ1Yz?=
 =?utf-8?B?TmJ3V0p6T0RZRXJjTzN5Qm9tczkrL2ZwS0pLZGR0Z2pUbHV5YmtGa0dHblRo?=
 =?utf-8?B?Slc4eGx3cDVMUGRRT05MNzhjcEhkeVdoUXRtUy9iWlVMS21pS1JvM014cE5R?=
 =?utf-8?B?Njc1U1VHajkzRkhHaFhlcUFWbS9sdWM4VmtzTTl3LytnTlpKamlrNThsOSsv?=
 =?utf-8?B?RWhNL1F2WG9Ba3hhZGN4WUFBbFh2Y0xGMjRiaXlaUXNmd1I0ZVR6VHZRSnBR?=
 =?utf-8?B?TkgrNWx3cW1HczArMlJTcTRTNXB1V0wvS0ZlUENqeTYvVzl1WndXWFBzTklZ?=
 =?utf-8?B?endRNlQ2QVhIdUxJZ0dOS2V5Q3FIaUNkaWRYNTZpTUF1bjJLOTdBcEFqMDFr?=
 =?utf-8?B?eWVKVjJsaHQveVNQcER6ZkpsbTk4aFFNaEw4L3FLckJUUTlCZE41bXI5MTZh?=
 =?utf-8?B?amhQdGQ1SklaWFpycmNPVy9sdVpqNk9qSGZtWjByZjh6ZGtJMnQwRWhKajVs?=
 =?utf-8?B?bm1ORWVjNFlLeUJ6Uk90ZVUxc1FlaTJZMzZLVTE5ejJCS3p4TUpFWG9VZ0RU?=
 =?utf-8?B?aXg4NkxIUDJvVnhEWldkT09jTkN5aW50VHd2TnZ3cnVUOWtkUzNERm9Qek55?=
 =?utf-8?B?MENOMUZyS2laMWhFTFJ2Zm5hUDF4QVpXNGN0REN5S2YxMGFYY3NRaDBLT2s0?=
 =?utf-8?B?aFBTMlFoeDA1NGE5TFNib3dpaGlzQnV6c0pkRmEyQWtla0ZtOU5WWVkxLzNM?=
 =?utf-8?B?WmFEREZDYS9lc2kzMkF2L2RlQ0IrWmhSbFI3ZHN4cVc1SlFMd29wUzNpUnFX?=
 =?utf-8?B?bHVPQWN1cUJtNEV2aGdreXRGQlVRdWVFVEFZMG1PeURKbUM2alNub21hM25X?=
 =?utf-8?B?MUlmOEZqMnIwK2dob3ZuY2NIZFdDNlo0NzIzV05EZlJVNjUwOEdTcHJhWWsz?=
 =?utf-8?B?eHYrVVBydmVzOHNxakNwMXpNZGppWmw3ZzlQRzUwMWNXcisrYXc5aitpajlw?=
 =?utf-8?B?RUtNY3VQMWt6SnFEblp0Rmc3UGVNY1FBQmJncitPOTJpUW1mUFVMQzE0UGwy?=
 =?utf-8?B?dURQVHhuUERnMU8xZ3VQNWs4ejJQZXd3R1VOMHVZSHBtazY0QTNiN2Naamlj?=
 =?utf-8?B?L3dGV3VER3FtajA2ditob0taRGRmQVk2V3ZGb3JtSzM5eUxhOTNYMTBWR1Ex?=
 =?utf-8?B?T29aVnpIRm1saDdNYXFCazVUU1VOQkp2SXpwQ21OR2tJY0M4NDY1L3Q3K2lk?=
 =?utf-8?B?dU5rZ1BUWExieXhpRkZPbGxJSzNLWE1PRkRFanFMWjNnY0haRTdPaG1WL21q?=
 =?utf-8?B?MXlkMTgvL3hDeTVxenpLMzRWSUVLd3BKcWRsQW9jK2NZRDBtekFMWnFZTDNS?=
 =?utf-8?B?Slh5U2hiYThRZk5PWWtJQmxmenZWSUVyeXpoeDU4cm1Pc0FVRFowVXZ0eWFQ?=
 =?utf-8?B?ZUJ5UlVvOWhsTE5IWWpvbEYxY1JtK2ErTFIvMnNkSFIxYnc2bzNkRE5ySEtX?=
 =?utf-8?B?bjdKaWJPS0ZVZVprMDFNOCtmNlIxTHFKZUFUaE52OFpUUmhVVCtRRHcrN3ZL?=
 =?utf-8?Q?aEOgnJHpj/b2HlgVhM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda74573-809b-4652-dd24-08de786ef0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 15:18:21.1452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5B1mBXTx6416WwgEtjLi0NXc6lpwxofVGP0UKPDDQ6uPhFyZdYN1ZXOomzidfZbQNVEJwIxC4nJsHLRbZTdWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaWVycmUtRXJpYyBQZWxs
b3V4LVByYXllciA8cGllcnJlLWVyaWNAZGFtc3kubmV0Pg0KPiBTZW50OiBNb25kYXksIE1hcmNo
IDIsIDIwMjYgMjowOSBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FO
LlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+Ow0KPiBQZWxsb3V4LVByYXllciwgUGllcnJlLUVy
aWMgPFBpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IEZpeCBtdXRleCBoYW5kbGluZyBpbg0KPiBhbWRncHVfYmVuY2ht
YXJrX2RvX21vdmUoKQ0KPg0KPg0KPg0KPiBMZSAyOC8wMi8yMDI2IMOgIDE3OjI2LCBTcmluaXZh
c2FuIFNoYW5tdWdhbSBhIMOpY3JpdCA6DQo+ID4gYW1kZ3B1X2JlbmNobWFya19kb19tb3ZlKCkg
Y2FuIGV4aXQgdGhlIGxvb3AgZWFybHkgaWYNCj4gPiBhbWRncHVfY29weV9idWZmZXIoKSBvciBk
bWFfZmVuY2Vfd2FpdCgpIGZhaWxzLg0KPiA+DQo+ID4gSW4gdGhlIGVycm9yIHBhdGgsIHRoZSBm
dW5jdGlvbiBqdW1wcyB0byB0aGUgZXhpdCBsYWJlbCB3aXRob3V0DQo+ID4gcmVsZWFzaW5nIGFk
ZXYtPm1tYW4uZGVmYXVsdF9lbnRpdHkubG9jaywgd2hpY2ggbGVhdmVzIHRoZSBtdXRleCBoZWxk
DQo+ID4gYW5kIHJlc3VsdHMgaW4gYSBsb2NrIGltYmFsYW5jZS4NCj4gPg0KPiA+IFRoaXMgY2Fu
IGJsb2NrIHN1YnNlcXVlbnQgdXNlcnMgb2YgZGVmYXVsdF9lbnRpdHkgYW5kIHBvdGVudGlhbGx5
DQo+ID4gY2F1c2UgZGVhZGxvY2tzLg0KPiA+DQo+ID4gTW92ZSB0aGUgbXV0ZXhfdW5sb2NrKCkg
dG8gdGhlIGNvbW1vbiBleGl0IHBhdGggc28gdGhlIGxvY2sgaXMNCj4gPiByZWxlYXNlZCBvbiBi
b3RoIHN1Y2Nlc3MgYW5kIGVycm9yIHJldHVybnMuDQo+ID4NCj4gPiBUaGlzIGZpeGVzOg0KPiA+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYzo1Nw0KPiA+IGFt
ZGdwdV9iZW5jaG1hcmtfZG9fbW92ZSgpDQo+ID4gd2FybjogaW5jb25zaXN0ZW50IHJldHVybnMg
JyZhZGV2LT5tbWFuLmRlZmF1bHRfZW50aXR5LmxvY2snLg0KPiA+DQo+ID4gRml4ZXM6IDY0Yzll
NWVjMTZmYSAoImRybS9hbWRncHU6IGFkZCBtaXNzaW5nIGxvY2sgaW4NCj4gPiBhbWRncHVfYmVu
Y2htYXJrX2RvX21vdmUiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQGxpbmFyby5vcmc+DQo+ID4gQ2M6IFBpZXJyZS1FcmljIFBlbGxvdXgtUHJheWVyIDxw
aWVycmUtZXJpYy5wZWxsb3V4LXByYXllckBhbWQuY29tPg0KPiA+IENjOiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNo
YW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYyB8IDUgKysrLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNo
bWFyay5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJr
LmMNCj4gPiBpbmRleCA5OGNjZDdhYjllOWEuLjAyNGQxZmUzNjcxNiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMNCj4gPiBAQCAt
MzMsNyArMzMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9iZW5jaG1hcmtfZG9fbW92ZShzdHJ1Y3QN
Cj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgc2l6ZSwNCj4gPiAgIHsNCj4gPiAgICAg
a3RpbWVfdCBzdGltZSwgZXRpbWU7DQo+ID4gICAgIHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOw0K
PiA+IC0gICBpbnQgaSwgcjsNCj4gPiArICAgaW50IGksIHIgPSAwOw0KPiA+DQo+DQo+IFRoaXMg
Y2hhbmdlIGlzIHVucmVsYXRlZC4gT3RoZXIgdGhhbiB0aGF0IHRoZSBjb21taXQgbG9va3MgZ29v
ZCwgdGhhbmtzIQ0KDQpUaGFua3MgUGllcnJlIQ0KSSBhZGRlZCByID0gMCB0byBhdm9pZCByZXR1
cm5pbmcgYW4gdW5pbml0aWFsaXplZCB2YWx1ZSB3aGVuIG4gPT0gMCwgYnV0IGFncmVlIGl04oCZ
cyBvcnRob2dvbmFsIHRvIHRoZSBtdXRleCBmaXguDQpJ4oCZbGwgcmVzcGluOiBkcm9wIHRoYXQg
aW5pdCBmb3IgYSBtaW5pbWFsIG11dGV4LW9ubHkgZml4Lg0KDQpTcmluaQ0KDQo+DQo+IFBpZXJy
ZS1FcmljDQo=
