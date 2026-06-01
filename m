Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3322ACD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 20:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36CD10E91B;
	Mon,  1 Jun 2026 20:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMV1DrKq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C1010E91B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 20:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLoIMQ66/pP9H4C0RgzkCw7BooLgCbhOQEny2x/97NrWMFj2UpFZZXUAcbYnVG1S3KXljdRvVDT+q6Ph3XQBAPzt2vmg5jDl1ABTcSSwyp4xSvxjXhSBHpvZmRPlzdmbPrnUHvPq35Ga3sHGhZsPnsJwAIxqYJAOXptIzYulGvXrzLjYXpCjTNgNWxrRRRqUWa1dAq88Aj0GxUCZ+SJmK8pm3bquo+baYCrv8I3bZgrGts+2QKJwH4cHFnD7Pa2tcmRFXGlW+fyTyxUG7IYFikJk8NcEj+sWOk2VCH5nCB0MDXJ5hfzD5PI9qA8LuTNrrKAjuvHs8/Fg//f6zmq71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mePPQ5nL7ECrLp1u4EIeo0Pi5M9VO4mWVYEH5CDw/jU=;
 b=DSDS8i3MtGQdYdy2bTDzlA4Y5MCwAq8R9EGKSaKL8AJDnKOlZ6BfbJQKvLR9hdYNCcUS6u43bSugMIwFFxb8VckYDM9ZjngxHlRpEBpTEmfeeV5uJrWRJACzf9G9vujCss2Z6274O9eT76p/GOKQrqASYsbw8/Im5SdAFe/XyVQQVs+gJoupP+ZN+PfcizDCGSUSwfhIoeuCPsYDBZkCJU5vMqpIb6cm0h0VP1OsMdu5S7PgzsfOOzSm6jjtDvxJbAcZ1PkTOu9Z3B0IORmFXGjyC5iv3MYCIfdPQRIxsD5azsYN1oKbFXyrFuO17kbLoyxIZE6A4bNOlvhdrKiOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mePPQ5nL7ECrLp1u4EIeo0Pi5M9VO4mWVYEH5CDw/jU=;
 b=CMV1DrKqiHsw6FT3bBRZDg65O0sjMceoYGrHP09loHiSBqYjekaNdSajTYR2mL6YPXSvznWPeSdq+oatcYTVSQv3PD4zEBujmXJyHJFVc66QmIONQE224AE1D+fpIaLYhilRkktRzXXNzMueBGFVtSdjVfExFeJGGzZcsb2972c=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 20:08:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 20:08:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?utf-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, Alex Deucher <alexdeucher@gmail.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, Natalie Vock <natalie.vock@gmx.de>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on
 all SI
Thread-Topic: [PATCH] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on
 all SI
Thread-Index: AQHc7Di7Q6+WHoDhT0qoNKIzSMs5FrYgZ2cAgAnEWQCAAABgUA==
Date: Mon, 1 Jun 2026 20:08:44 +0000
Message-ID: <BL1PR12MB514407AB6734BF1F51A04A09F7152@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260525112204.12604-1-timur.kristof@gmail.com>
 <CADnq5_PJNnBeADEJStb9ypvZSxU7SdviJEDf9DW0H+YBf7PT8w@mail.gmail.com>
 <409fcda6-feeb-4fba-95bb-085dc4493e46@freenet.de>
In-Reply-To: <409fcda6-feeb-4fba-95bb-085dc4493e46@freenet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-01T20:07:40.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8483:EE_
x-ms-office365-filtering-correlation-id: 847a1e19-4822-40df-4184-08dec019951f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799006|22082099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info: lVEqfMGuC/qzEln/ZzHEhl495xL7ehYvx2fXGQhExyi4i6eSKXAdsymDhEhAJkSNSdL5CSBnBAKSURbh5TaSbY88LvC0L0lKIUJ6VRv0FV/N/4MVfVzeytgSvs+TEHebf10dmjD6ckJ34dnbcntE03KW5OZH9NibscFQSMCbvRMWX7nZ3Hy0dLkI/tY2rEPefsXXDeJBUH8XZlVZvZA6mAakGO5cv2nxffHIb/mOoaWslU9p8eg1f7Zgh1DJExYrEHpuZX65dyaOWXZqOPBT2FwiofQmTc+uR2gzViXN4vdIEYcLUXyg1d596mM8+QFGZl+fHRMPkbY6OLl2w5G6vBaB8DD4lj7WoInZNmrML/o1eQAu+wbReSp7TujiFWAssgEUNgsc3n4jep7Gs6m1sro5zeYlWC+rjkIIcx/tNp4FBQlZjovWIp8PgZFRqp+1vJmFdK+tMz90ddk3GTeh+LBRnggyOorkJ2v5J9B/lvBOn5K7Aepc/E2WIZ8uSReZv1xVWrxzV38m0pcGAr33NBzsOUKai5wu4PIZI1Q5iIFgwuWEsizviPBpdnu07AMI+ni9DIH3jDKkUICTKYK0JzWHxhUhd8Khd3Dx2uoWPcpc1lhxSrOkFiV93mVnreCTpVsY8do1ooR+DmlhpX2I5peGPBdaXQ0hS4oRyhzQA9ocI1WuWLvdRmdy5dEzHR9yJ1sKYNhBgaCZ9Rc+jMn2EqGV5SKrf9lLxKQkPo5pQOClkEAEwP/mlmGcQuKJEHQ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1pEUnFGQVFPMFZBZ1dHUEszMzFzR2Jjb2lFZTlzZ0FHd3BWdHJUSjNlcFI4?=
 =?utf-8?B?NzhOTnJ5QVdMMlQxR3B1U1lHNlZFRkx3T2l6UkVQSXNSd2xrUmIzN004LzZu?=
 =?utf-8?B?V2lWL2xVUkY5ak9hdEJHYktTN2RHRXVmbFJ1TUpodW90THVLYmZKODNwbUNh?=
 =?utf-8?B?L3p6WC9VcUsrMzFqMGhDNXlFSlRqUDFDRHNWU29WNWtYamZ0NGhxRGxkd1Vv?=
 =?utf-8?B?Q1p1Z2FBZitwZGw2MTFmU0VzWlJQWllwaU5VNSsxWGdLb3JFYlp1d3lZbnVi?=
 =?utf-8?B?bVNlQXBlc3hxNlcwME83OWV5UGVuVFZMaUtIL1FCNGhjbUZwaFQybndzVkVy?=
 =?utf-8?B?ejR3M0hnYmI5L1l6ZjVxak5ZWkZ6YzlBckZGU2Z4cUtLZUgvT2dTRjdXek9i?=
 =?utf-8?B?NWFOQldzQzZPaWJMU2Q2eE9JeXVBODQyR2ZPTmRFZ1lmbTNsRDhMNDVyM2Nr?=
 =?utf-8?B?Y2pMZncvYmVBK3I1bDl3VE41NEtxbmtmek0rV0JvbWliWDlwTk9qTWgzWEJt?=
 =?utf-8?B?VTk1bkdxeUpuZGhaYTFZcmh3SjRWeENEVWQ3OXpyNlJlcSt1OEpLT3dmQVlL?=
 =?utf-8?B?N09Fa1d6RlFYTWxKNzhuTC8yREpoamI3VVc4bkRXK2pDaHEwak5LaXl0cnQy?=
 =?utf-8?B?bnB5LzJ0Y0VYYzkxdnFURWl3eVM0dmY3NTUyZlJwSzlmZy9tRVV3TzE3SGtW?=
 =?utf-8?B?UHdDZE5EV095dmZ4YlNjY1FEWDRsYzJOU0tnYnpXdk5CRjBFZGloYnVMaWt1?=
 =?utf-8?B?cW5jbGpNc0c5RVExUzE2SGs2Z1VXOFdub3JSS3lHQzdNaDg3d3FOd1FBVTFJ?=
 =?utf-8?B?RGxqRnhWaER1VG5zbWd2VWthRzZGMWs0MWozK0EwYzdmSUdvUjJDbWFDR2pL?=
 =?utf-8?B?WnBENVREMURIY1FhNVpBcExqbDJvRmZlK0M1K2RyeTFudmdvOU9XaEpVYkxr?=
 =?utf-8?B?bzEvQittUkdMWi9kYUVSeno0OWZjVTBrOWVXNUFGQW9UcEx0aWVYSEpidUxM?=
 =?utf-8?B?Zi94cEU4NGFsbjlQbDZDdEhDa2F0eURQeHYvd2E2SHJ2SDlJNG1RWURlekNp?=
 =?utf-8?B?SU0wT2F6MjZWTGVYT3djVTJubmZzZTlHWUpBeWxEUHdPOFVWVjBqdFNTRmVK?=
 =?utf-8?B?RkxPTS9CdjhPei9seWVWT1o1b0dMYjY3dmtJUitERGhmTENkSk9qSG5hNW9i?=
 =?utf-8?B?dm1vaHZtNjRrODdyeHY3dDNtZ3VKNDhEazl6NjhtNHF6Rk44UFE5cHRPNHAw?=
 =?utf-8?B?eG5wSDBicWE3TmxBajQzSTN3c2tKb0puSjlOTDVKMTIzMzQwVEx3cXdHTW5w?=
 =?utf-8?B?NDZaTG9ZaW1jU0w5UUxDNlN4M3RxUmhtTG9ZWkZFUFlVL1lIR2xlNjBML3B0?=
 =?utf-8?B?WlIzNE85UXFXaTlhWEFyK0twNHhMVkpjdTFqanpzVzR6cXlVOEZsSGdYSlZr?=
 =?utf-8?B?REJsUHUzQnhmODBiNXJKWVZKZ2dlSmZVYWJmcmpqeVZ0dWUyTm5XRkZTRjVM?=
 =?utf-8?B?Mi9zZHBVVW1XTE1IYlN6UmNSNmZPNlN3L0Vmb01tM0dSRnRkR2ZlTVR3dFQw?=
 =?utf-8?B?WC9YTCtBakFCZ2dXT3lETmpWdkh1UlMwRXlWQmlGVlFKK0F0NzE3SjBqSHRy?=
 =?utf-8?B?aDdlb1BNR0N6N2VkY1NNR1ZTK0UvcTBLeDVQOTd3TWdoWlpycDY2OFdzNnNl?=
 =?utf-8?B?SzV4TGtDc3JzVnFzcXA1bFFZM2oxWlJ4RHVISXlFWkM2TGJ0blB1UjY3ekRO?=
 =?utf-8?B?Qzd2R2QvQ2lpcjEzVlcvUTdYL3ZZcVVoZ2drbnp6RlpISnI3Zk1MVFhwbmxw?=
 =?utf-8?B?UmRLNVQzWTE0azc0ak9zNHBhZDJDN3V5TEhSbzlmUWpaVWhKeEVibkllbHJo?=
 =?utf-8?B?K2M4VGNuZ3UyU3JoTDlIbHg5bG9NZDR6Y0VwWmFWN1FnZ1ltZ2ExT015ckFC?=
 =?utf-8?B?b3pmSXRGcm84SVNHbTJybkxNTXVHam16TlB6cDNQc25NblJmOXlmQlQzaUZY?=
 =?utf-8?B?MUpqZkZZWU9vT0N6RkN1ZU9xdGlZTlR2QTJhRFNwcUZZUWVTZ0I3bjNnckVz?=
 =?utf-8?B?T0U5UkluNTA1czR6bk1TTkZsTnZpQVRQQk8rWFM2cDNRZjFBNTE2Qk9NOTQ3?=
 =?utf-8?B?QklwZWEzNFRzUkxYbENCZFp6M2g1SXJSRXN6WlUzaFIyZFlPL21UM2VqaXBN?=
 =?utf-8?B?cXQ0Z25KMDBCVDVOR3Qxa0ZSRWtnQ2hFSmJtUzloWC9FMzMrcWRoQXNtUzRL?=
 =?utf-8?B?YUhxKy9nY0pLc0YvTm5zTDFmU05PRCtwMjZMb2Npd0N2end3Yngrblp0Vmdo?=
 =?utf-8?Q?V/FD/NtVfJD0B/e8/X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847a1e19-4822-40df-4184-08dec019951f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 20:08:44.1725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nFU8iX+qVIdmBMpRIO8XmnRktRAkYRU8X9B3mE+QBlOXZSfEZDUJ8bvjhfaoxRTWv/jfUvnEdEXlHeu4r5lKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlrdG9yIErD
pGdlcnNrw7xwcGVyIDx2aWt0b3JfamFlZ2Vyc2t1ZXBwZXJAZnJlZW5ldC5kZT4NCj4gU2VudDog
TW9uZGF5LCBKdW5lIDEsIDIwMjYgNDowNiBQTQ0KPiBUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+OyBUaW11ciBLcmlzdMOzZg0KPiA8dGltdXIua3Jpc3RvZkBnbWFpbC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFu
ZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IE5hdGFsaWUgVm9jayA8bmF0YWxpZS52b2NrQGdt
eC5kZT47DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogQWxpZ24gYW1kZ3B1X2d0dF9tZ3Ig
ZW50cmllcyB0byBUTEIgc2l6ZQ0KPiBvbiBhbGwgU0kNCj4NCj4gT24gNS8yNi8yNiAxNjo1Nywg
QWxleCBEZXVjaGVyIHdyb3RlOg0KPiA+IEFwcGxpZWQuICBUaGFua3MhDQo+ID4NCj4gPiBPbiBN
b24sIE1heSAyNSwgMjAyNiBhdCA3OjM54oCvQU0gVGltdXIgS3Jpc3TDs2YNCj4gPHRpbXVyLmty
aXN0b2ZAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gSXQgc2VlbXMgdGhhdCBQaXRjYWly
biBoYXMgdGhlIHNhbWUgaXNzdWVzIGFzIFRhaGl0aSB3aXRoIHJlZ2FyZHMgdG8NCj4gPj4gdGhl
IFRMQiBzaXplLiBUaGlzIGNvbW1pdCBmaXhlcyBhDQo+ID4+IFZDRTEgRlcgdmFsaWRhdGlvbiB0
aW1lb3V0IG9uIHN1c3BlbmQvcmVzdW1lIG9uIFBpdGNhaXJuLg0KPiA+Pg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyB8IDIg
Ky0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2d0dF9tZ3IuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRf
bWdyLmMNCj4gPj4gaW5kZXggMDJmODU4MDJmNTc5Li5jZDBmZDc3NTc4ZDEgMTAwNjQ0DQo+ID4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMNCj4gPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYw0KPiA+PiBA
QCAtMjAzLDcgKzIwMyw3IEBAIGludCBhbWRncHVfZ3R0X21ncl9hbGxvY19lbnRyaWVzKHN0cnVj
dA0KPiBhbWRncHVfZ3R0X21nciAqbWdyLA0KPiA+PiAgICAgICAgIGludCByOw0KPiA+Pg0KPiA+
PiAgICAgICAgIC8qIEFsaWduIHRvIFRMQiBMMiBjYWNoZSBlbnRyeSBzaXplIHRvIHdvcmsgYXJv
dW5kICJWIGJpdCBIVyBidWciICovDQo+ID4+IC0gICAgICAgaWYgKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX1RBSElUSSkgew0KPiA+PiArICAgICAgIGlmIChhZGV2LT5mYW1pbHkgPT0gQU1ER1BV
X0ZBTUlMWV9TSSkgew0KPiA+PiAgICAgICAgICAgICAgICAgYWxpZ25tZW50ID0gMzIgKiAxMDI0
IC8gQU1ER1BVX0dQVV9QQUdFX1NJWkU7DQo+ID4+ICAgICAgICAgICAgICAgICBudW1fcGFnZXMg
PSBBTElHTihudW1fcGFnZXMsIGFsaWdubWVudCk7DQo+ID4+ICAgICAgICAgfQ0KPiA+PiAtLQ0K
PiA+PiAyLjU0LjANCj4gPj4NCj4gPg0KPg0KPg0KPiBIaSBBbGV4LA0KPg0KPiBJIGNhbid0IGZp
bmQgdGhpcyBwYXRjaCBpbiB0aGUgYW1kLXN0YWdpbmctZHJtLW5leHQgYnJhbmNoIG9yIGFueSBv
dGhlciByZWNlbnQNCj4gYnJhbmNoIGluIHlvdXIgR2l0bGFiIHJlcG8gb24gZnJlZWRlc2t0b3Au
b3JnLiBJIGhvcGUgaXQgZGlkbid0IGdldCBsb3N0PyBJIHRoaW5rDQo+IHRoaXMgc2hvdWxkIGxh
bmQgaW4ga2VybmVsIDcuMSBiZWZvcmUgdGhlIHJlbGVhc2UuDQo+DQoNCkl0IGRpZCBub3QgZ2V0
IGxvc3QuICBXZSBoYWQgc29tZSBpbmZyYXN0cnVjdHVyZSBpc3N1ZXMgbGFzdCB3ZWVrIGFmdGVy
IHRoZSBob2xpZGF5IHNvIHRoaW5ncyBhcmUgYSBiaXQgc2xvdyB0byBnZXQgY2F1Z2h0IHVwLg0K
DQpBbGV4DQoNCg==
