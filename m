Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D10C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC05410E08D;
	Tue, 14 Jul 2026 14:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JrUjbrXK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E1610E08D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyypLyQGLuaRs36YArrhCdy1QD63UXnFq9GR/dHwaZ32+SGVG8n8gHPzONwF3GqPU5EqfHDveoxDBoZzCRFUcavZerBMof4lHtM1OXojo55/h6czc2S9rq6FkaoM6uOMFtgd1gVbrAfK+MwvSc8oGNU/98tspeo6zCFfpBBHKwbrAoMtOVjrAmDp/QiP5y/fSRQ/t7x4WMxCVC0nUXHbyTT/SJTRqUUSnMJMv8u7XQk4egrWFMecdCQymF4pC9tUVs1pdnqOJkiakN6Xu8d8UtStZ6FPy6JGLoeYWt8yvBDS1Z+/ZHVQILEVtuqXB85mC4BB/mQRk/eOsJk6YtTWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU0hHnD6xA3YqZDb2asfMRI0KhiwORdKk0OEhdgdtzk=;
 b=bDCu8UXUSIY8svTvk9ZawLvNjk1mnABM3qPeQcgIaAFo+CvUtt5ZiGkrssuHVel7w0YNnWcB1RnTVX/Ww+FQMD0SxIRNLe+gWb09rDIVv8S/LG1eElnrxqdeQKBuvGUOTJ2Czr51uwY55PA2/VNxCatEh4QOnO5jn7OWFAL/aF2KsIH6Y71zsB2vjpvTpmtshBSA5BN7flN2iuxIZcgJCtnFex3GXmI44xKBXCp9iD2rpobTuDcEvtAClmuiJooAl9Mz5G5l2srMgeDK7e2GT/0zh0LHcZvFocWretiJys5NRlGV39/gnkob99wX5j1/JvS3JHsqHbZHVcP5EU3Bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU0hHnD6xA3YqZDb2asfMRI0KhiwORdKk0OEhdgdtzk=;
 b=JrUjbrXKY4jvKpvQAKLRtfij8EuRtdRoOpSSDespBswJaRK4f3YdjJlDn/hsXCWy8OMX/FzkAs1nwWdERsooEH15Qgw8qaMldGNF4Q5zbBYJB2rPUpvYA2TJulokO/zngdsNgIdBwAJ4+IqvbVuDJ0Nl2Y6BKUeWMwtG4o+eaeE=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 14:12:41 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:12:33 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Thread-Topic: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Thread-Index: AQHdE2hGKLmWWW8ZeEmIau/OWo7rHrZs/BeAgAAOouA=
Date: Tue, 14 Jul 2026 14:12:33 +0000
Message-ID: <IA0PR12MB8208D744889CEED95FB6DB0E90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
 <b40ff22e-2d09-4644-a4d3-a9cffcdaec6d@amd.com>
In-Reply-To: <b40ff22e-2d09-4644-a4d3-a9cffcdaec6d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:57:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB8814:EE_
x-ms-office365-filtering-correlation-id: 5e454e0b-2d1d-4d90-951b-08dee1b1f2c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: uXAtB+81eJLPiv6kXTNvJhg2zMA4NRSHMeV1dF7MWq+KBRGisoNwO+Qn5/UGtVsy7I6ZFNDQdgfszPy47yd2NShrqY4KKGX+a5HqI7tc1dTNvAu5OhY22ghgMegIy87KwSLk6w9knMm7gb3noJ2K9Qk4gRYVh727Cu9Tx0zQhST5XNce74+bjzgBv9f4/yO2d/u0UGrZXP7p8HidmHa0f5yYmZnD45KllCarmesRhUuoDO+E6POD5S05g6H93p4fY9mAeIB2ANYQgyXqsC6gbbc8eDx0GOTChPWWFG2te2nwHaal73hC9m5yC948q7qA+Yvx9WQVWMDYyFtasr5FYxpu9sPHGgybSHSLkBoYKdwe9CCTpkfEW87RSv85Jda74L6/emetqS4AGk0ez8UmbY0kqNDFjrL42RXM/uwZGFi/WTo6kZlWoA7IJKS1WsJgZ6OxEzd0tyd6XwBdUP0Vudh+PcBS51rTVQOTNWJOr0KKocuY2USO0aj3BSAJw/hlNLWeKW5ftlrqh1gDdY0CbLm6LfLVcdO8f++xG7MaQ0UrB1yEv5LIP82XIiQXSa+BMnI6X9jZ1x7pT31vCwreWTnE3kSOdeOaAWVpGxnU4GhrVXHMFHWBTEEHRjUGJdu/XwWiN2SAuG6lELLsf801+b8PBonre7PKY4m8QtZESWqVnZSxj5g+GzCWt3JB5lTv3FY/qKTH8FXv4ySgwE4cwHY2OgykgpgNzQhcMlVT3fM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE5aY2pWTWJoUXZmNzJLMkhRYXFHWm9CWlhMM2NkY3cvSEZ0cElMWG5DZHgy?=
 =?utf-8?B?cmZpL1FRWS85aW44QUx0dW1KTXJ2cXZkY2xIWVVqOGJzZU9jVGI5Z0ZXRlRu?=
 =?utf-8?B?dVE1WTZxd0JZbnZjK1ZrckdrdWdpYWsxeDM1Vjh6eHJLWVc0M3FiRDM2YkZB?=
 =?utf-8?B?TmQ3czlaZzEvWWRNRURyZ1lwZmRRRndjM3M1RXpUYlFoSlE4RW9ZTzVTY3FF?=
 =?utf-8?B?SkRtdjFzdHhvOGJZcXRVVG8wZlJPNzRCQ3NFTy9SZ250WVJ4QTJOQ3o2K3hW?=
 =?utf-8?B?anVEZ3ZPQkNyandhLzdIaVdBQ1g2bFJrS0tzdWgxUDFMTkJhQS9wTmdzWmN1?=
 =?utf-8?B?Q01ORmxQZXU3aC9wNmZkVDd5UTBKRkltclVMY084Tnl4TW5RZlcxa1UzbXdL?=
 =?utf-8?B?QU5zMzEwbm5WRVV3MmhsQU9FNi9QUlcxNE5qQU85SlpmenkzcS9QRTNkWGhD?=
 =?utf-8?B?R2VsUnhHVkNtWDN0d24rSFVtVjJmNVcybG9xdnl6d29GQW5BbHc0QnZRMjFO?=
 =?utf-8?B?bWQ4b0ZCRGl2MmhxR2JwOUdiRmhpQnpkZXZTZXBTTTE1VVgyYU5kNUVQSWUx?=
 =?utf-8?B?UDhWQi82RUhadGF3b3FyZmxpRmM3Y3hFdWRzR3BKUlFtaGhiZ3gzY1JGU3A3?=
 =?utf-8?B?cEFpOVRlZ2RYbE5vQnpObW8yVVRwM0laQkRqZjlJVS9maHhMbEVKaE1sS1Jl?=
 =?utf-8?B?aVM1QkFWWEY5NzlIRFArRmxUR2JlMjhXNzdvVTlNcnhxZkFNMDdRNjBWaXZD?=
 =?utf-8?B?RWo5Si9SWGNUbFlCNHl5K0J3VmVhOU9WNFJvNnR1eEN1M0dnSDJQa0ZTUUUw?=
 =?utf-8?B?U243WFJGN3ZuSGVDYjMwVk5lNWYvMjUyK1NrVzVST3BJdmJUUnIyNUdRZVh5?=
 =?utf-8?B?WmEySkE5MzVPZTc2YWhPWk13WE0rRlVlWTV3ZGdpdFc0cERpTjdNTkVXc1Uy?=
 =?utf-8?B?cUZQd1BDV0JzaVFiUUhlMlFhRmpIVGJZOTVrcm1aazZSUm44VG1yZlZ4SWpN?=
 =?utf-8?B?RFlXRXhnYy8rcnFWQUpHd0gvKy9RZGE2S3p1aVFUWnhUNlYxdjlobFBkcVlU?=
 =?utf-8?B?eDM1emZ1TjF6dU5YTWlzWEx2eFZKeTZHNUN4MXdNK0txanlZUkQzTHNvY2lZ?=
 =?utf-8?B?cEhuN1J2NStET0duM3A4THBCSzg3bmlmc0QycERtYlFPb3hZTVNrU1BpWUVj?=
 =?utf-8?B?ODRJczNGTVQ2STlRNkdicWphemc5UHRPMURrNmFTcjJaYTJyK09ZV3k4Rkll?=
 =?utf-8?B?dTdLd2lGb3dxSFlFMU8weis4dmIyUXNNbUJUeFh3QVVjVHRqQURuUXNrWEJ6?=
 =?utf-8?B?SWxxYjFQZTRiUmdEWVF6YmhpRmhXNmdCSzlqOXBVVUNXSnZoKzdZNi9LbXh6?=
 =?utf-8?B?R1RtcGs5OVRUVHJBQWVOaERSVkh2MmFHaGpjUS9uYlBzTWFSMG1URTc0Zkw3?=
 =?utf-8?B?SVo5L0d5SnJ6alRvVWg4Sm9MZVZGRGJuKzIxVGRoUnppY0Z0L0paSi83NndG?=
 =?utf-8?B?S2ZxM3ZCYmYwNnI2T3ZlWURIcjgwTVJPakFVRE94eTJXQmZGN0FtM0lkeGtu?=
 =?utf-8?B?blJHc3BhMEVPamowV2t5bjJvQ1NUYUs3bmd2WjdNQmFGei8zcHd0aFhFb1Bo?=
 =?utf-8?B?L3pjNmRoOXRKZGtlV2ExL0gzeEJ4bHdJbmtVMWJ2Q1ZnMFZwN2tXbklGTFVz?=
 =?utf-8?B?UzIydzkvUm8zckw1ZXlQeVJEL0Z6bU5QbWVoQWVMa1pUK2RYNVlLbEdiRHNE?=
 =?utf-8?B?bnNMVzZLVExFSmtpSXlyY0N0djhRbG04dlNOM2pVMUlqcVlFQ25HaHlla0d0?=
 =?utf-8?B?WWZYdk5URFcyUmJ0SiswZG1BZ0hKb1Q0OWhrOHhmNHdHbU5wVFF4Q0FKcFd2?=
 =?utf-8?B?eGduUEJ6TWp1SFhnV3dnalBHOUt3bkR1ckJyZG8xMEJpY2tyemNTblpFMUh2?=
 =?utf-8?B?RFhkWWd2b1l0cmxBV0V1N0gzamRHYi9nVUdCSVFKUWN4bTdFSE9IbnNveGNM?=
 =?utf-8?B?YnNsYkVnWXpzQmtEcHF0RFlWLzgyamc4d0RYZVZUMkZvUDFvNEhHUHQ3VTVn?=
 =?utf-8?B?S1VKOEFZMm5TU0t5OWVpaWNNZW5SM01NVlo5cEMvYXU1MXZTS2pvSGhxR0s2?=
 =?utf-8?B?Zy91Vm10dHB1U3ErQmlVbWEweldrc1dkVFFPbytjVlNiNFpRdHgzelBPRWhC?=
 =?utf-8?B?UVVVMTBueXcwRytCZkZNckFkRDZ0TUkzRFFUZVB4eU9HcnBFaGRwdU50L0No?=
 =?utf-8?B?WnFIa0dxbjhTelZkMlZ5dWxyT1ZCS1daSHNNcURVd1pYWE1wZnFxcnVlQy9B?=
 =?utf-8?Q?9TcyjVPWfJaCnixENy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e454e0b-2d1d-4d90-951b-08dee1b1f2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 14:12:33.1260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfUGve3YTTeltARnMf7P1+whKAmPp4RjKUiWjeiiISmdAjHzm+NIaBMsV26QNsxDijyOnkQ6wCJjeHNP6HrTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDE0LCAyMDI2IDY6MzYgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJ
TklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNS81XSBkcm0vYW1kZ3B1OiBSZWNvcmQgUVVFVUVf
UkVTRVQgV0FJVF9FVkVOVA0KPiBub3RpZmljYXRpb25zDQo+DQo+IE9uIDcvMTQvMjYgMTA6MTAs
IFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+IFRoZSBxdWV1ZSByZXNldCBwYXRoIGFs
cmVhZHkgcmVzb2x2ZXMgdGhlIGFmZmVjdGVkIHF1ZXVlIGRpcmVjdGx5IGZyb20NCj4gPiB0aGUg
ZG9vcmJlbGwgYW5kIGZ1bm5lbHMgc3VjY2Vzc2Z1bCByZXNldCBoYW5kbGluZyB0aHJvdWdoDQo+
ID4gYW1kZ3B1X3VzZXJxX2hhbmRsZV9odW5nX3F1ZXVlKCkuIFJldXNlIHRoYXQgY29tbW9uIGhh
bmRsaW5nIHBvaW50IHRvDQo+ID4gY3JlYXRlIHRoZSBjb3JyZXNwb25kaW5nIFdBSVRfRVZFTlQg
cmVjb3JkLg0KPiA+DQo+ID4gS2VlcGluZyB0aGUgbm90aWZpY2F0aW9uIGluIHRoZSBjb21tb24g
aGVscGVyIGVuc3VyZXMgdGhhdCBxdWV1ZSBzdGF0ZQ0KPiA+IGlzIHVwZGF0ZWQgYmVmb3JlIHVz
ZXJzcGFjZSBpcyBub3RpZmllZCBhbmQgdGhhdCBib3RoIEVWRU5URkQgYW5kDQo+ID4gV0FJVF9F
VkVOVCBvYnNlcnZlIHRoZSBzYW1lIHJlc2V0LiBJdCBhbHNvIGF2b2lkcyBkdXBsaWNhdGluZyB0
aGUNCj4gPiBkb29yYmVsbCBsb29rdXAgb3IgYWRkaW5nIGEgcXVldWUgc2NhbiBpbiB0aGUgTUVT
IHJlc2V0IHBhdGguDQo+ID4NCj4gPiBObyBNRVMgb3IgR0ZYIGludGVycnVwdCBjaGFuZ2VzIGFy
ZSBuZWVkZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8
c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBpbmRleCAyOGY5ZDNmZTBlODAuLjllMWQwM2Vi
MzFkNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cS5jDQo+ID4gQEAgLTE2Niw2ICsxNjYsNyBAQCB2b2lkIGFtZGdwdV91c2VycV9oYW5kbGVfaHVu
Z19xdWV1ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSAg
ew0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2V2ZW50ZmRfbWdyICpldmVudGZkX21ncjsNCj4gPiAr
ICAgc3RydWN0IGFtZGdwdV93YWl0X2V2ZW50X21nciAqd2FpdF9ldmVudF9tZ3I7DQo+ID4NCj4g
PiAgICAgcXVldWUtPnN0YXRlID0gQU1ER1BVX1VTRVJRX1NUQVRFX0hVTkc7DQo+ID4gICAgIGF0
b21pY19pbmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4gPiBAQCAtMTc2LDYgKzE3Nywx
MSBAQCB2b2lkIGFtZGdwdV91c2VycV9oYW5kbGVfaHVuZ19xdWV1ZShzdHJ1Y3QNCj4gYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gPiAgICAgYW1kZ3B1X2V2ZW50ZmRfc2lnbmFsKGV2ZW50ZmRfbWdy
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0FNREdQVV9FVkVOVF9UWVBFX1FV
RVVFX1JFU0VULA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcXVldWUpOw0KPiA+ICsN
Cj4gPiArICAgd2FpdF9ldmVudF9tZ3IgPSBhbWRncHVfdXNlcnFfd2FpdF9ldmVudF9tZ3IocXVl
dWUtPnVzZXJxX21ncik7DQo+ID4gKyAgIGFtZGdwdV93YWl0X2V2ZW50X2FkZCh3YWl0X2V2ZW50
X21nciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIERSTV9BTURHUFVfRVZFTlRfVFlQ
RV9RVUVVRV9SRVNFVCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIHF1ZXVlKTsNCj4N
Cj4gSG93IGFyZSB3ZSBtYWtpbmcgc3VyZSBoZXJlIHRoYXQgdGhpcyB3YWl0X2V2ZW50X21nciBk
b2Vzbid0IGdvIG91dCBvZiBzY29wZT8NCg0KR29vZCBwb2ludC4gd2FpdF9ldmVudF9tZ3IgaXMg
cGFydCBvZiB0aGUgb3duaW5nIGFtZGdwdV9mcHJpdiwgbm90IHRoZSBxdWV1ZSBpdHNlbGYuIElu
IHRoZSByZXNldCBwYXRoLA0Kd2UgY3VycmVudGx5IHRha2UgYSByZWZlcmVuY2UgdG8gdGhlIHF1
ZXVlLCB3aGljaCBndWFyYW50ZWVzIHRoYXQgdGhlIHF1ZXVlIHJlbWFpbnMgdmFsaWQgd2hpbGUg
d2UgaGFuZGxlIHRoZSByZXNldC4NCkhvd2V2ZXIsIHRoYXQgcmVmZXJlbmNlIGRvZXMgbm90IGV4
cGxpY2l0bHkgZ3VhcmFudGVlIHRoYXQgdGhlIG93bmluZyBhbWRncHVfZnByaXYgKGFuZCB0aGVy
ZWZvcmUgd2FpdF9ldmVudF9tZ3IpIGlzIHN0aWxsIGFsaXZlLg0KSSdsbCByZXZpZXcgdGhlIGxp
ZmV0aW1lIHJ1bGVzIGFuZCB0ZWFyZG93biBzZXF1ZW5jZSB0byBtYWtlIHN1cmUgdGhlIG1hbmFn
ZXIgY2Fubm90IGJlIGZyZWVkIHdoaWxlIGEgcmVzZXQgbm90aWZpY2F0aW9uIGlzIHN0aWxsIGlu
IHByb2dyZXNzLg0KSWYgYWRkaXRpb25hbCBzeW5jaHJvbml6YXRpb24gb3IgYSByZWZlcmVuY2Ug
aXMgbmVlZGVkLCBJJ2xsIGluY2x1ZGUgdGhhdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCg0KVGhh
bmtzLA0KU3JpbmkNCg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo=
