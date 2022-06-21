Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F90C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 01:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FAB10FF82;
	Tue, 21 Jun 2022 01:17:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEAA10FF7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 01:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uow0sL/wlEquit5itnPljPZcy9j9RZJbN6EN/sbYlnT7kPcEd8Ei1LLAZw97WIXlt5Ycn9o8PkUJmzekxEmTPbHFKjlLiRhBWP/Qr9RRW5XqC9zqVH4qtK2uSILCMFLZgG+fpCPzL+Aq0gvMWb7JA/3hWAP1Pe6+9NFbY4G48Zaaz9iT5TN69cZVzYSj9xxnQlhLk1PPDLWKXR0e2eQDqRFpIg8HSWq1q/OstEv64/qO0mJpG5BxfzDF4QkDFkPevcYbn+HoKgA9soei4krylqNM3e09GH3L5Zd05QJpbxiLTaWNNbPMdyzBl14Q1mumOlhiIbw83A+QK4yBsITuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAYatgcGVFT8ma58+GgTfJXTKr9ZekXCuXtRZax6jnk=;
 b=L57n3JMn1qM7S4ie+NKnmt5dWwAXxdWJOT9Hkpz5ub0qa0T+og3cpF9lLkMbAynwolcOt5q5y1pqP4jvYTCRBWtPv4GtdXP9HjArrRwlu9/D6AojsI6bMbipaCMKxnIZ4hnqK12bz5C1B2ivl2YLjscWz9k4mCSME3maugnCE4SkqR/SZ/N7e6qyFRYMK21F+ALdtjkpfk7jl4cKfrnePa+EEH1wAm7cuE1LnXFauIoAkKvLJT/96unYLtKsRQXNG1HgVQHRsJaRtOau6yAVw3bmCxvNqDvphukL/WsesQuYpfokmu1GdAiK4cf3x4uVQE2u2lCzRDHwN+IGSWXP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAYatgcGVFT8ma58+GgTfJXTKr9ZekXCuXtRZax6jnk=;
 b=rhHe+r71CGTlDh5WM9pLkKXD0merZjaC+YWbvu7h5ZSSDELs+nHpQOWirlcjvBNkb8pMtaRz+pL4ZTzWnaOKKiOHkKnrc97aBMKbO7TjRNtTUWERusNT6GRCZJXSeGy5qS15fAxvCPpUTR79EAi0fbQfHQKxn2k8CKThh3avR10=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL0PR12MB4737.namprd12.prod.outlook.com (2603:10b6:208:8d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Tue, 21 Jun 2022 01:17:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:17:09 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix adev variable used in
 amdgpu_device_gpu_recover()
Thread-Topic: [PATCH] drm/amdgpu: fix adev variable used in
 amdgpu_device_gpu_recover()
Thread-Index: AQHYgcXcghjJpfxpfUKxFVddVBCqla1YZ4kAgACuD6A=
Date: Tue, 21 Jun 2022 01:17:09 +0000
Message-ID: <DM5PR12MB2469AC55569552732317C361F1B39@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220616211238.669152-1-alexander.deucher@amd.com>
 <CADnq5_MEwLZEw8MAYyrGvQyBvPRRu50bNWTSSyiUExSvpp7hyw@mail.gmail.com>
In-Reply-To: <CADnq5_MEwLZEw8MAYyrGvQyBvPRRu50bNWTSSyiUExSvpp7hyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5bf363-4121-43ea-925c-08da5323c350
x-ms-traffictypediagnostic: BL0PR12MB4737:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4737B18B8ABD518344B89A61F1B39@BL0PR12MB4737.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsSND+lH22efeFNnvd1fnh3hvyB//tGElF9ASF0uC7udAlpNnjol8FuScU3cqWcQI6PJm/PpqAca9fH/K6+1S6OXUvKiT4683aX7lrhO8FAacUQnh9uZfOIlJE0vgW0AL3UAwnp1z1Aqg5Z/j8WscWzv3qXf8hxjrcC9SZYHaS8fSGsC50NmFWgtLFXRdjBxP5bvnpM50eJ4UD8xcIcyES8WPywvlthD6vvW62G2B1R1MkrlP2cNzyIZUSBrz0l2XDP6R/KVNwkJiPMfW8lJQ0F/I0sVyH/UfqYzEb3PZqgVyxblLtlot4B40E973WPCUXBU4Rkd+0aorrbxQNlkHE+OcYKtoO8kt4x62C2DeKEtlCg2sVXVmNtWv8q4A4yscAOkfnYPvUlzy5a5YphQg5eDfqt0djtAFRgJu8f4gyPYnqNoR5H+akOOQkfVPG3gFNVYpKgZwXUU/qUW0baoJ40rzRA98VSTvyNPJELQMUK7zJRDe8mz6VBPbRKeZyTuG6V2Q2cpAuVOMbw42XgMRHV7UY+eSki5ivJxbUJ3ppL6WVoSoHZN5Vipu1xWvIMK7dXcpZkspnB9wUfFX2nAuNfH4leJ0FXOxYxmwC5c9vyev6OIG4VC3IbUqO8VHJOVfZGEPy1VNdj5+HNYvhyK/WamvRKqNThSLBVMicFJQnLPBIiQi8RR7BhdeE5EXX47DoRB+rAlXrSnK1igzrKNyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(9686003)(41300700001)(38100700002)(33656002)(6636002)(122000001)(5660300002)(86362001)(7696005)(6506007)(53546011)(26005)(4326008)(2906002)(38070700005)(83380400001)(55016003)(66946007)(76116006)(66476007)(66446008)(66556008)(52536014)(71200400001)(8936002)(478600001)(110136005)(186003)(316002)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTNVTUlndUxrTGljWTVXTjlRMmc3endwTXdZWENTMU5Qb0Z2ZmY2ellKZklB?=
 =?utf-8?B?UjNnc2M4Uklpa0RxMGdaT3V2UXJJWGVVVk1Fb2JMc01CakZlL3VhZGZ0ZUk3?=
 =?utf-8?B?WWRJL0JhTml4YUx1aDRtS1Ezb3NjMTZQVzJWaW9QR3ZpVHhESmYwc2huODgr?=
 =?utf-8?B?TkNMU2F3bnVSTHZ4amx0R1d3QVVwL1NkbGpGRVJIWGhVcm80VnNyb1RVNzVC?=
 =?utf-8?B?eVdkM0VWeDZJM1M4UWU4UDlXM1JXYTdLY3lsZG11anc5ZnIyUlJyYUhTamRJ?=
 =?utf-8?B?SFBXSCtaWlU0SXNpckxZc284YXp5RFdoTGtkWFk3bk8vQXRHaWV4VDVPeFdI?=
 =?utf-8?B?Q21zTjNiakI2Y3dTbGJCNDNERk9EMnJVVG5melJNMkxtRnNzSlRpUTY1Tnd1?=
 =?utf-8?B?SmtJRUlvUHBBbWt5U3ZnVk5OWGExMG1Kak5xYkNNSVZ3UVQ0UStKaGdad1BQ?=
 =?utf-8?B?aCt2VTJleEdqM2RWVjZjUU9FWTVIb1BlWHJPK2hpdndsQzNDWDd6SFFyeENU?=
 =?utf-8?B?dG04Z2RFNzJ5N3EvN05QUTFXOGg1STZEdVNBWjkyNTlBeTNtTGRTQlB1bTJj?=
 =?utf-8?B?M3p3OG5RV3U5VVNTSUljcXFRdzI5QXArcjFEZlZURmp4bDdMeHJPMjhlSk10?=
 =?utf-8?B?SlBUZktubllLSlliWExBU21MNktDTENES3V2UTFOV1J2b0hpdllkQVl3Z04w?=
 =?utf-8?B?T0VKaDJwclR1S0phcUs2emtXVjlqemxRbEQxQUQxMEtuWUZoZ3pyNWxQeDFE?=
 =?utf-8?B?Y2FNM3habnBCVmFrb1ZXNFVvcXNmdlVtRDIzYUUwaXluZVU5WUM3TmtZeEVC?=
 =?utf-8?B?SGZUeW5KY09vUGdNSyszcHBxeWV0bmNQY1hneSttR1VPODhBQldQa2FXZDdR?=
 =?utf-8?B?THpmN3p0M2Z3eXRGK0h2dkNDdTlUUjFITVhmVC9zQmU1dmZNMHMweUxnSUtL?=
 =?utf-8?B?dGJjVEpQT1ZKdFl1QVhnWkZtc2Z1N0RHZ0dGYkpZN2doQXk4SG0wa0dtR1lZ?=
 =?utf-8?B?czJYUHVWRjVtOGZsVlE1UFh3eXZBbmdNNWxlNlJ0NEp2VTZnQmJ1bTZ6dFQy?=
 =?utf-8?B?c05HRGlweDVSWGdCd3B0RlpXY0FJaTN0QnprNXY0S2R6TERDNHB6ajdueHFG?=
 =?utf-8?B?YTJVM3RiR0lJTnE5TVc1a0dmVjZIT0FESmZsOURUYmRYTDd3d1dlR2ZlWE1v?=
 =?utf-8?B?VWkweTZUUHNmYk5zZzUrMmVBNFZadDN5ZDdBRm1uV05waWRBbU9Sc2dsV0Vi?=
 =?utf-8?B?TWx1cnhnSGR1SkVjbW92RU9KWVJ0dzE2QUppdWVoSGdUS2dJUGIxczJPc0t2?=
 =?utf-8?B?OUFYWVFia2JPcTRVNm5nd1dpZzJqd1p1andHaUZqSnM1cnh5YmFNaEtZbHdu?=
 =?utf-8?B?YW9CSG9tVGlKcGEyNVVjMnFFSGFwRU9nZGxCTmFQS1c2b2RuK1g4VnVQUUxG?=
 =?utf-8?B?Nmt5a1FYNXZMRGt0T0IvMUpYTDdJRmgwTThrV2FLdDlaVnJMNWhaN3NtQzRy?=
 =?utf-8?B?dFFaQm5UZkJRMlJBbWk4UlZGRDRHQUxIRmJnSXlORmN1NVRqdVVkVGM1aEla?=
 =?utf-8?B?cFZPTEdlQ3R5eWxvUXBmK2lGL2Y1NHgvREFjbG9yTDgzNG5UNmRTMGRHcGR4?=
 =?utf-8?B?SnJOYzVFOUtnNXg4OTNUbDAybnUxditpcUZnRGhVMnV0dFhydFgrb1VQL2Fl?=
 =?utf-8?B?Z2RSdDVtdnBlbG9sOTUvdUU0WGprQjNRSGFHaEhNcysxZG1pQzUzQVFnbkQz?=
 =?utf-8?B?TGJ6T29RdjJBamVIejRwTC9NWS82ZkEvcWZMMm85VFF2bHNmOVRmL0pKUlZX?=
 =?utf-8?B?dXJtR1dhR1ZpVDJDaldvMVBSbVdGbHRFcFlBUmNyRjFibHRJU2ExU29wZGhO?=
 =?utf-8?B?Tm0vOVJEZlVZbUlOditmb2dxSFo2MFBxVEVaWHlQVEdHU29Hemt2Mi9Uc21Y?=
 =?utf-8?B?UVk4TFM4VDJuU0xkM2M0SThZM1kxMVd4TG5OUzI1Tlh1Nlk5Sm5RZXpSc3FH?=
 =?utf-8?B?cFNVS2dlbmlmdmNZT2g5aC9pN0Y3QlVPOC85cDlLVE5FRTBEdUZZYkl1dEZ6?=
 =?utf-8?B?eWNWMWZCRVMvTzhvamxCR1BRYXMyTzgrQTFBT2tpNnQ4OGhIZGF4ckozNkJM?=
 =?utf-8?B?SWRSU21xWmVCbFV1RzVjSWRWUjRMSDJyZHFobzIzSUhiOFpWOUVhczI2c1BW?=
 =?utf-8?B?YzBIMFVhY1E3ajZnL05KVU9WZGQzT2k1R01WbUI5aHpXUVE2V1MxTG9nSFM3?=
 =?utf-8?B?b1RNK21GUkxlTkFyODd3WXJOc0EyUGJRVXQrSVFBQTJJNTNhZXYvMUhkczlT?=
 =?utf-8?B?VEwxUmdqOGRMQ21hMXU1VUpVSTZwKzl2NVZ0SWF0cmVMOFRkMkJHQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5bf363-4121-43ea-925c-08da5323c350
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 01:17:09.1519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRxMSx0GiQ9XHxR420kPXKgGOw14ORAldud+K9fyPrDTnWHwgTk/WGWlLQwnOY05Wn0QW5ho8RYleT2KrFfTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBE
ZXVjaGVyDQpTZW50OiBNb25kYXksIEp1bmUgMjAsIDIwMjIgMTA6NTQgUE0NClRvOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0
IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGZpeCBhZGV2IHZhcmlhYmxlIHVzZWQgaW4gYW1kZ3B1X2RldmljZV9ncHVfcmVj
b3ZlcigpDQoNClBpbmc/DQoNCkFsZXgNCg0KT24gVGh1LCBKdW4gMTYsIDIwMjIgYXQgNToxMiBQ
TSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBV
c2UgdGhlIGNvcnJlY3QgYWRldiB2YXJpYWJsZSBmb3IgdGhlIGRybV9mYl9oZWxwZXIgaW4gDQo+
IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoKS4gIE5vdGljZWQgYnkgaW5zcGVjdGlvbi4NCj4N
Cj4gRml4ZXM6IDA4NzQ1MWYzNzJiZiAoImRybS9hbWRncHU6IHVzZSBnZW5lcmljIGZiIGhlbHBl
cnMgaW5zdGVhZCBvZiANCj4gc2V0dGluZyB1cCBBTUQgb3duJ3MuIikNCj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCAyYjkyMjgxZGQw
YzEuLmVhY2VjYzY3MmE0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPiBAQCAtNTE4Niw3ICs1MTg2LDcgQEAgaW50IGFtZGdwdV9kZXZpY2Vf
Z3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAg
ICAgKi8NCj4gICAgICAgICAgICAgICAgIGFtZGdwdV91bnJlZ2lzdGVyX2dwdV9pbnN0YW5jZSh0
bXBfYWRldik7DQo+DQo+IC0gICAgICAgICAgICAgICBkcm1fZmJfaGVscGVyX3NldF9zdXNwZW5k
X3VubG9ja2VkKGFkZXZfdG9fZHJtKGFkZXYpLT5mYl9oZWxwZXIsIHRydWUpOw0KPiArICAgICAg
ICAgICAgICAgDQo+ICsgZHJtX2ZiX2hlbHBlcl9zZXRfc3VzcGVuZF91bmxvY2tlZChhZGV2X3Rv
X2RybSh0bXBfYWRldiktPmZiX2hlbHBlciwgDQo+ICsgdHJ1ZSk7DQo+DQo+ICAgICAgICAgICAg
ICAgICAvKiBkaXNhYmxlIHJhcyBvbiBBTEwgSVBzICovDQo+ICAgICAgICAgICAgICAgICBpZiAo
IW5lZWRfZW1lcmdlbmN5X3Jlc3RhcnQgJiYNCj4gLS0NCj4gMi4zNS4zDQo+DQo=
