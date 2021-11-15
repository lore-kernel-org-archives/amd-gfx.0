Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139AFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 02:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6DB611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 02:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE6DB611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4538189BFD;
	Mon, 15 Nov 2021 02:45:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7DB89BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 02:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN6fVcCKRb7ITG2ru5gOusdtrHnL8d8Fb8ZNx/CCBtTLKC4hiegHfVtUl1k4pIxmcVygYRRMhn+p9ZIsAvJZWCbQY2Eftm/sIc9MrJEkhJOocYNuC6WdlvMec98yJyq486V3/Ot+Q1UYqnSAODiaKwOc2Lm9KJoJBSVS7JOy1d5Ys8Ccp3dHw6M9duZ6qNMs7DwdvNqYwfojrOGKDiFJyPwAOkB0yJjGlE7YU50NYeR354aS9hhQlDNSSyKIRPA8o92DezT7bfpVUs9iJfkALNAKxaHFF1JD3hbh0uSTUp3ywl7BGfpNNWl5I3Oawhkc/qGFxwJBurJgPU98jgzSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EcuEqdFbFvH25rPjoRJ2iGmCPGZyrflLw2WGFjACWU=;
 b=Y5nZV49WVd8eatMSTG2/02thq0zaANMI1O6IfgzqwwUjkm6NsdGnchqA0GpWQ2yI5EipcM5lDBVDakl10POpiosKCp1lHiqO48sV/fErHlPKzdMidmvqj5qiRnV1UpcOko/jmL4xXsexgDXUf5brnDhFokbmasyEBOkvxbqfssXkVhzonDJIGwoBz++r/S7/OOacZ2FPWJRW56qu5Y9hX4uCNKkc6tMgM51rpESTdRRAeVlfxLeZjIKfywNMb1o3O64PswExftJrEveXPx9xUIWjlBqa7lbZRvYXp4d1EpEsbC9MjDLmQUegWT4Hl6n72eEfXtZqEqz80M8zYSp9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EcuEqdFbFvH25rPjoRJ2iGmCPGZyrflLw2WGFjACWU=;
 b=qNPKb/m7tWBrs8a8LF1zDa/9gDrlUqCmNxozyMaoJ5OFKgRbKnueON9SGbYczZAn1wbn47uj7FHNEno7otS6FJl9kXhHdtDhEgGFGmm3K5LvUbeDqgWuTYVKWZ7aMLtrhhBOgYbZ48FCfO1pZsh/3WiXe/k9DxY8CiJz+8KnMzQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Mon, 15 Nov 2021 02:45:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 02:45:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Topic: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Index: AQHX1tHVcWr7YKXPLEWAFliPTXpFHqv/lcqAgARRjqA=
Date: Mon, 15 Nov 2021 02:45:10 +0000
Message-ID: <DM6PR12MB2619BEB43A37AD5E1601B044E4989@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211111075730.184218-1-evan.quan@amd.com>
 <c06186fb-6718-aa3a-8402-d4dea52f6fa1@amd.com>
In-Reply-To: <c06186fb-6718-aa3a-8402-d4dea52f6fa1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T02:45:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ae20bcfa-25ec-465e-b062-c51e854c3c7e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20162698-cb0f-425c-3424-08d9a7e1f18d
x-ms-traffictypediagnostic: DM6PR12MB4043:
x-microsoft-antispam-prvs: <DM6PR12MB4043590455B76453CFD71A3DE4989@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IertQln2dxErgwXirmsrrj6maHK50WbjE357z2mCl5NiV3UEAvzgN3C2GpZdwheTNEDFkpqDgQf2oS2hSpRKiglVBFqOka2ReCTSUV0ZlPLQgjQJ9roo1nKF2ztu2VRI01CsIbkkKiIeKzLsHNT7sFcA66cTduL38M6NwbrARecwSrOg0aLWWxPh+wowq7JTSf0UwZaRhthT9lhMhHO5gL3Rckld7Q8MJQsvPDd63zIBLF1t2EPnimLzFHrqW3/wio4+wyS+iWjUowhdfhK723YUP+cCZsfmMjRtnWO9ZiC3VZXImUF7joHBEtpxc1uLz/aieaEvsZZHngpNfRNfl6Iwx5XB5Orwd3fbph38z8MrhxhazErq5SWdCswQuM9j5QrLv9i5l8angEPfXoXGlNGwN1j0yKI2lpOJuahPJ1qFlsr4aExkPL7y2nyB5nx0gbDwIJKHpimNMKqQYoX2BERWpi/dVp5ra7kvyLA6yUjS6/Ke9pucpP/0o/HFfkkLsX8eEW39V3KaIvMlEXAbwnjht1y4K779AYv2+zdZ7mV4d86XFItP3gjFKh/L8hsI3+e46Ki6B8K99gG0nefdHemVnOTEEVFLqcg04rrSElAsD+frNx5917rEC5bXLwEP7kurTYnnIMPr0M51RMfxsCddR6kTx5YdmkQ0AOijii+yFcVGNCHwDSoAPS/mmYGHpGNb1aAH5du930378TJS4XbGs3r6awQ98fvuV2SDHFRYU2aOoHcHDLDFYky24A8naI0aUChmIJwgDc0pTl8TgOQjPyYFkBP5AAhPfIU8OcE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(86362001)(26005)(33656002)(186003)(122000001)(8936002)(316002)(6506007)(8676002)(508600001)(4326008)(83380400001)(966005)(110136005)(54906003)(9686003)(7696005)(55016002)(71200400001)(66946007)(76116006)(66446008)(66476007)(64756008)(38070700005)(52536014)(66556008)(5660300002)(38100700002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3BRTEFudHlmQ2o3cWk4NlJsc0xXYktrTnlTL0w1N1RzQlNJVm1GYy91aURo?=
 =?utf-8?B?emxWS1JLa3gwQ3B3TFVQUm1nN3FzTGFQQkRUSVpQNDU1cjNpQVVjWTVoTkFP?=
 =?utf-8?B?aVhUSE9WK01HTDJoQ0VKT29UQ3EyOXY1Y3EzeXZFNkNqNE1wbGVSRWtENlUx?=
 =?utf-8?B?dzV1cVZXa0hBaTBIUVIyT2tXNHpyR2Z6UFJVbHVtUVIxQkI2dFZzOW52d0tW?=
 =?utf-8?B?V3J5RXAwOURvZ2VXcDV5T1NFa0hDZ2M1MFArVGcrcU5ydG5INzlhTnREOTNo?=
 =?utf-8?B?eTdHRk5tMlhYVEVjS1RrVVJxQ0RvMklhT1pSeW9TY0Q2Y3pKWTFDa0wvelF0?=
 =?utf-8?B?Nk9aalhnUmJMSGFJRlh3clZodFF6M1lJTWZoOWdaMnAyOEZLNDZ5L0g1RlVF?=
 =?utf-8?B?THpZWHVyeCt0dHE5N0JsVnVSeDZDYkdtV0Mzd09kRDBhT1ZPeXZzQ1RhZmZU?=
 =?utf-8?B?ZnhRZEVwM1E5RlVodUo2QkpoSUl0SjFDbW4wQmQ2VUZOU3dzeHp0ZE1SZFRK?=
 =?utf-8?B?Wko4ZERtanpMMkZ3VEhndDZnY0xCR2d4bUswY2JENVRIcHF0ZGlIS3lQemI0?=
 =?utf-8?B?UXdNN1oyVC9qS3NIZVNYRXBOUHFwR2JaZkRjQXUrN1Rpb0FQaERyczR3elo0?=
 =?utf-8?B?T3VDQ0tuVUFzWWRLb25aTU5ObC9WbWtaY1BscnBNVDkvVUVaSVJxSHdkQlJS?=
 =?utf-8?B?TWIrYzM3cDRJWXUwTkNwb2NqM04vb0FUTTdaOU51NjVkQ1FSQk8raG9uRUtO?=
 =?utf-8?B?aDc2RXUwcXhjWkV3aFQ5RmtVVVlNWUtlUC9UTUszWGNTWE5HWCtJaG9La25E?=
 =?utf-8?B?YlY1cmVWWmZjaGdBaUczeHBaZU4xNm1heWtqUVpqanVFaFVrdjJwYllPNE1p?=
 =?utf-8?B?NHBQVFR3ckNnTGtVcFBjWVFBMmN3aXVPUlRkV2ZLU3N5V0hJVVB1TEcyS2RJ?=
 =?utf-8?B?ZmFSUDNrYzkwYWdrTjhSTEEveHFjSFJqR3BSUm5YQWFYcmNxeUdpekJ2QXJP?=
 =?utf-8?B?RzlLVDNNemVJMk94NlNzNGN0elFHaU9aa3VTMnhPN1M5R2dVbnlsWm5ZdVFB?=
 =?utf-8?B?Rlo0dnk0eVlKWlZwMEtMeW52aVlraFl6K3JMTDM5RFR0MGRHYmJhMEdlbGUy?=
 =?utf-8?B?YS9CbUhtc056bENLMTNscENqcVhiRVBHZXFUdlM5Vzlkbk01aUIxMGdIb3I5?=
 =?utf-8?B?Q2Y5SzJrbldxelRUTGJ4YTUyOEVNRFFRT3FIbktRUmZBd2JRNzkvQlRNMFAw?=
 =?utf-8?B?VXZhSHh3TnRXalRmOGVJcENwN21oWDROcU5SVWY0b3hRaS9rR0FyVHdZUkYv?=
 =?utf-8?B?MFVjS1hUNWQ5eVdWRFpZRm9JTzZjaUN1U1BmRVY0RndQUjRYMVNKemt6TXZO?=
 =?utf-8?B?SStjdi9kN2VNTUlmZ3VVbk1nKzl0bk8wa2gvbEtGYmhveTBUcDRVNTc5MTg2?=
 =?utf-8?B?dDMrdXBrQ3ZuSVladWVzNDdkRmlnWnYzVjVjNDREQVdLenp0MW5FRzloYTNi?=
 =?utf-8?B?eVVpZUQ3cXY2bDVPeSs0UGdObnFGWHNUa0NjYVRIMnpTWTZWNEZtZ2ZlbVEw?=
 =?utf-8?B?SlBSTlpaNFMzYkJlMGNsZkVQWkVMNFZnSjJiZDFYWlVyY1lQWW51VzVoWjZu?=
 =?utf-8?B?QllGZnd6QXNZZXljTGxLc0ZlSWR4YnJLWXpwR3Z6VU02Sjdrd2YzL05GbVht?=
 =?utf-8?B?R1RBOFVwNmdrYk1ZR1dJckRVR0IxbVU1ZUFpZk9WVGx5RndOUVYwUDhLQlRt?=
 =?utf-8?B?d0FOeC9pRlFuZmsyUUhsY05LQVlkTjcxNUs0Z2p0MjEvbm8wWlJ1eFZWZGNl?=
 =?utf-8?B?VGJoZVlYZlB1UEZUVGxZUkI3aGxBdmJSdDNmUG1FWXlya0thcjk4M3lKM2F3?=
 =?utf-8?B?M29HenBiTGYwWEFLc25jWk5ZeXdGMUhIUHliMTdwdm1lcDR6Rkd6dDlON1du?=
 =?utf-8?B?aHpKYzdNMW9RQ2Y1R2FzLzdLU3k0RVhWcGZWTXpuVW4yaXlxeXhlbkljZU9N?=
 =?utf-8?B?UExkNlk1Y09aQXJaQzNXQ3pPbkttSG5jQlpPTHNISTZBR3RLdEt3RlhlYU9B?=
 =?utf-8?B?eU01SUJ4YThqV3F5bVBBVlpXZmwxTVdsQU42ejFCU0I3djNrS01YdVliV3cr?=
 =?utf-8?Q?7/sY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20162698-cb0f-425c-3424-08d9a7e1f18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 02:45:11.0309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2mXbF32HYvL7vI6bYJg9VQyyqtKdCD2OYk6Q6TfugRfH9jOPNMY6bo+PKCNCb6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMiwgMjAyMSA0OjQ2IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YN
Cj4gPGJwQHN1c2UuZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IGF2b2lk
IGR1cGxpY2F0ZSBwb3dlcmdhdGUvdW5nYXRlDQo+IHNldHRpbmcNCj4gDQo+IA0KPiANCj4gT24g
MTEvMTEvMjAyMSAxOjI3IFBNLCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4gSnVzdCBiYWlsIG91dCBp
ZiB0aGUgdGFyZ2V0IElQIGJsb2NrIGlzIGFscmVhZHkgaW4gdGhlIGRlc2lyZWQNCj4gPiBwb3dl
cmdhdGUvdW5nYXRlIHN0YXRlLiBUaGlzIGNhbiBhdm9pZCBzb21lIGR1cGxpY2F0ZSBzZXR0aW5n
cyB3aGljaA0KPiA+IHNvbWV0aW1lcyBtYXkgY2F1c2UgdW5leHBlY3RlZCBpc3N1ZXMuDQo+ID4N
Cj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWVY4MXZpZFdRTFd2QVRNTUB6
bi50bmljLw0KPiA+DQo+ID4gQ2hhbmdlLUlkOiBJNjYzNDZjNjlmMTIxZGYwZjVlZTIwMTgyNDUx
MzEzYWU0ZmRhMmQwNA0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFt
ZC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+ID4g
LS0NCj4gPiB2MS0+djI6DQo+ID4gICAgLSB0eXBvIGZpeCBhbmQgYWRkIGxpbmsgZm9yIHRoZSBp
c3N1ZSByZWZlcnJlZCBpbiBjb21taXQNCj4gPiAgICAgIG1lc3NhZ2UoUGF1bC9Cb3JpcykNCj4g
PiAgICAtIHVwZGF0ZSB0aGUgZGF0YSB0eXBlIHRvIHVpbnQzMl90KFBhdWwpDQo+ID4gICAgLSBi
ZXR0ZXIgTWFjcm8gbmFtaW5nKExpam8pDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgMyArKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggICB8ICAzICsrLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgICAgICAgIHwgMTIgKysrKysrKysrKystDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmggICAgfCAgOCArKysrKysrKw0K
PiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4gaW5kZXggMGJkOTBlYzllNDNlLi5mY2E1OTIzOTRmYTEgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gQEAgLTM1MDgsNiAr
MzUwOCw5IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4g
KmFkZXYsDQo+ID4gICAJCWFkZXYtPnJtbWlvX3NpemUgPSBwY2lfcmVzb3VyY2VfbGVuKGFkZXYt
PnBkZXYsIDIpOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJZm9yIChpID0gMDsgaSA8IEFNRF9JUF9C
TE9DS19UWVBFX05VTTsgaSsrKQ0KPiA+ICsJCWF0b21pY19zZXQoJmFkZXYtPnBtLnB3cl9zdGF0
ZVtpXSwNCj4gUE9XRVJfU1RBVEVfVU5LTk9XTik7DQo+ID4gKw0KPiA+ICAgCWFkZXYtPnJtbWlv
ID0gaW9yZW1hcChhZGV2LT5ybW1pb19iYXNlLCBhZGV2LT5ybW1pb19zaXplKTsNCj4gPiAgIAlp
ZiAoYWRldi0+cm1taW8gPT0gTlVMTCkgew0KPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaA0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaA0KPiA+IGluZGV4IGYx
YTQ2ZDE2ZjdlYS4uNGI5ZTY4YTc5ZjA2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvYW1kX3NoYXJlZC5oDQo+ID4gQEAgLTk4LDcgKzk4LDggQEAgZW51bSBhbWRfaXBf
YmxvY2tfdHlwZSB7DQo+ID4gICAJQU1EX0lQX0JMT0NLX1RZUEVfQUNQLA0KPiA+ICAgCUFNRF9J
UF9CTE9DS19UWVBFX1ZDTiwNCj4gPiAgIAlBTURfSVBfQkxPQ0tfVFlQRV9NRVMsDQo+ID4gLQlB
TURfSVBfQkxPQ0tfVFlQRV9KUEVHDQo+ID4gKwlBTURfSVBfQkxPQ0tfVFlQRV9KUEVHLA0KPiA+
ICsJQU1EX0lQX0JMT0NLX1RZUEVfTlVNLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgZW51bSBhbWRf
Y2xvY2tnYXRpbmdfc3RhdGUgew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2FtZGdwdV9kcG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBt
LmMNCj4gPiBpbmRleCAwMzU4MWQ1YjE4MzYuLjQwZmRhMTk5YTg2ZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gQEAgLTkyNyw2ICs5MjcsMTMgQEAgaW50
DQo+IGFtZGdwdV9kcG1fc2V0X3Bvd2VyZ2F0aW5nX2J5X3NtdShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4gdWludDMyX3QgYmxvY2sNCj4gPiAgIHsNCj4gPiAgIAlpbnQgcmV0ID0gMDsN
Cj4gPiAgIAljb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBvd2Vy
cGxheS5wcF9mdW5jczsNCj4gPiArCWVudW0gaXBfcG93ZXJfc3RhdGUgcHdyX3N0YXRlID0gZ2F0
ZSA/IFBPV0VSX1NUQVRFX09GRiA6DQo+ID4gK1BPV0VSX1NUQVRFX09OOw0KPiA+ICsNCj4gPiAr
CWlmIChhdG9taWNfcmVhZCgmYWRldi0+cG0ucHdyX3N0YXRlW2Jsb2NrX3R5cGVdKSA9PSBwd3Jf
c3RhdGUpIHsNCj4gPiArCQlkZXZfZGJnKGFkZXYtPmRldiwgIklQIGJsb2NrJWQgYWxyZWFkeSBp
biB0aGUgdGFyZ2V0ICVzDQo+IHN0YXRlISIsDQo+ID4gKwkJCQlibG9ja190eXBlLCBnYXRlID8g
ImdhdGUiIDogInVuZ2F0ZSIpOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfQ0KPiA+DQo+ID4g
ICAJc3dpdGNoIChibG9ja190eXBlKSB7DQo+ID4gICAJY2FzZSBBTURfSVBfQkxPQ0tfVFlQRV9V
VkQ6DQo+ID4gQEAgLTk3Niw5ICs5ODMsMTIgQEAgaW50DQo+IGFtZGdwdV9kcG1fc2V0X3Bvd2Vy
Z2F0aW5nX2J5X3NtdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gdWludDMyX3QgYmxv
Y2sNCj4gPiAgIAkJfQ0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAlkZWZhdWx0Og0KPiA+IC0JCWJy
ZWFrOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gSVAgYmxvY2tzIHdoaWNoIHdlcmUg
bm90IGhhbmRsZWQgYnkgUE1GVyB3ZXJlIGRlZmF1bHQgcGFzcyBiZWZvcmUuIFdpbGwNCj4gdGhp
cyBiZSBhIHByb2JsZW0gb3IgcmV0dXJuIDAgaGVyZSB0byBrZWVwIHRoZSBsZWdhY3kgYmVoYXZp
b3I/DQpbUXVhbiwgRXZhbl0gQWx0aG91Z2ggSSBkbyBub3QgdGhpbmsgdGhlcmUgd2lsbCBiZSBh
IHByb2JsZW0gd2l0aCBzdWNoIGNoYW5nZShjb25zaWRlcmluZyB0aGVyZSBpcyBubyBzdWNoIElQ
IGJsb2NrKS4gSSB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2gNCnRvIHN0aWNrIHRvIGl0cyBvcmlnaW5h
bCBsb2dpYy4NCg0KVGhhbmtzLA0KRXZhbg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+
ICAgCX0NCj4gPg0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJYXRvbWljX3NldCgmYWRldi0+cG0u
cHdyX3N0YXRlW2Jsb2NrX3R5cGVdLCBwd3Jfc3RhdGUpOw0KPiA+ICsNCj4gPiAgIAlyZXR1cm4g
cmV0Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vaW5jL2FtZGdwdV9kcG0uaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1k
Z3B1X2RwbS5oDQo+ID4gaW5kZXggOThmMWIzZDhjMWQ1Li4xNmUzZjcyZDMxYjkgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oDQo+ID4gQEAgLTQxNyw2
ICs0MTcsMTIgQEAgc3RydWN0IGFtZGdwdV9kcG0gew0KPiA+ICAgCWVudW0gYW1kX2RwbV9mb3Jj
ZWRfbGV2ZWwgZm9yY2VkX2xldmVsOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICtlbnVtIGlwX3Bvd2Vy
X3N0YXRlIHsNCj4gPiArCVBPV0VSX1NUQVRFX1VOS05PV04sDQo+ID4gKwlQT1dFUl9TVEFURV9P
TiwNCj4gPiArCVBPV0VSX1NUQVRFX09GRiwNCj4gPiArfTsNCj4gPiArDQo+ID4gICBzdHJ1Y3Qg
YW1kZ3B1X3BtIHsNCj4gPiAgIAlzdHJ1Y3QgbXV0ZXgJCW11dGV4Ow0KPiA+ICAgCXUzMiAgICAg
ICAgICAgICAgICAgICAgIGN1cnJlbnRfc2NsazsNCj4gPiBAQCAtNDUyLDYgKzQ1OCw4IEBAIHN0
cnVjdCBhbWRncHVfcG0gew0KPiA+ICAgCXN0cnVjdCBpMmNfYWRhcHRlciBzbXVfaTJjOw0KPiA+
ICAgCXN0cnVjdCBtdXRleAkJc211X2kyY19tdXRleDsNCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFk
CXBtX2F0dHJfbGlzdDsNCj4gPiArDQo+ID4gKwlhdG9taWNfdAkJcHdyX3N0YXRlW0FNRF9JUF9C
TE9DS19UWVBFX05VTV07DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZGVmaW5lIFI2MDBfU1NUVV9E
RkxUICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCj4gPg0K
