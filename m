Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 06:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7B3611B0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 06:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A7B3611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79236EA2D;
	Wed, 22 Sep 2021 06:08:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF966EA2D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 06:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVPhsTkgxTaTrAMYTO/AFvJhGy9qeLsLbLtTfuGoKNkRMxbbL7XeV2D3Y6nsPYcXD+fO9OHCBiXNqYjhVMoqawAU5ZWqj3pZn7SWW8j5LeGYkyE5RjPsjvCRAunjcYx0prB91AaGTOQWSasPr7xAoAlPyaxEZ5cM8adebSLmgRh5fl1GH3xrDZIevHzyJirQPtZJ30AWRkg9TVH9AsDRkbE5PTrG71vgJna3OQYghE52sn7dfTvOgusIJ5dyDcl0oP3M8xZYIhpGgZzWXvbDOAQvY1+/gP/RuSVMq1vgowxKo7UTsU0StNAEBlAnxPvG/zJW54YTEO9rnX6Vc1TGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8bDY9eGSQzALNt6RZwQsXe9y4Ew3hBMCulx7IyDtvOg=;
 b=Vrtyws2lEbH6lytJElR9A01rYCRMEeVWYb6TO6DYN+3xA2osgzqfXobSXJ1WLyqyreUxOdd7yNtDNmQk1XuewrWnVJ9SaW/Fd76ZFaWQFJxeXNnpIyRVNDWxeXSom9rj2NN64XkM2U7TCyacCRWDX/fz0iUyclc0StRIJ7j/DaLegNOv1t7tWsSQpsXUi8uVr71T6yEhgnHVQ0w7XVpl+Wdy1sTFL1XmR9fbAxoaD6tTpXXdorw7+N82aptEVPgIUia0Jzsv6PHfHX/vVoix8eImVbF/S4DuXtdYzev47C/+KUz4SUGKi4XUKChDOC05FWA4vpoIzgnRoiJA+zAWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bDY9eGSQzALNt6RZwQsXe9y4Ew3hBMCulx7IyDtvOg=;
 b=thl+i910s1J7cJraD+alEzKrx8i9Yd61VYHdpiqOBamZJS7hohjn3S+OglX7mY5SoHDNXVV2bBmQRDHJP8pTjW7akolJzyFCiHiRhQT5hPbdf/PaT59m9fdaFk+RQmEDjtTrbJJ/AHuxUwQy+7Qpb1J3XZrtSMbe0KoBh2FCBcQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.15; Wed, 22 Sep 2021 06:08:52 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9%3]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 06:08:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
Thread-Topic: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
Thread-Index: AQHXrxOYPtRAe+2cVU2oXvujjE4hKquvjtqAgAADVyA=
Date: Wed, 22 Sep 2021 06:08:51 +0000
Message-ID: <DM5PR12MB24697A6907D44E8EEB3343C9F1A29@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-10-alexander.deucher@amd.com>
 <54ac4a03-2858-6289-6b32-128f65334073@amd.com>
In-Reply-To: <54ac4a03-2858-6289-6b32-128f65334073@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-22T06:08:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2442c12b-51cc-4296-8f13-ebc2af5e7e3d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76e3626b-360b-4dbe-c762-08d97d8f7368
x-ms-traffictypediagnostic: DM6PR12MB3371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3371FC9163306D54FEDA043FF1A29@DM6PR12MB3371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4A1f4h8XUqvyGp5au+Kv6pq7iZYXGyFmrA6+fpFTnmkmFCojOjfOlTuI47/Y94m41mSc3Rg1+MjQOeW9M5KvZ2WEXfMfmkNLUZyqtzqa9JybycZz8em4MGIEP9Qa0/dIZIPjnBAWQGsW/AbpS/J+3NH3yZQGSk3a6IBeBOiH7Z51AiDrWt5QxiqVUlJDNArwtSHtOWmRT6GJdWveVE2c5jBGEt0Fwd9s1w8EN+YxcuZbs5FdE4nNtl4reNLSTtseJJ0CDyGZV8JJnZ501th+jp4UXE2IkNMFCsBbEjKlmnzAsL475xrLmoplWXE9JJFd5pkoJcqVqLljp6mDoHgbDa6we346IzsVar0iiwAKka7m164O4WNXFSwyNSm0Z5WQwM2L27gcWGIviA1nz3zB0JZ8m/Dkr2UA0ktnjEbNMn0KG4vaZ/ueIqdo9l7DPux3OF/IlWJKrB5HsRn9B7Jc4fPlI9fueIRBRVSkqAbl1hPUTe3q597Smw0RwAJHIWVKne3RD6nQKXsLq9vzupt1dCvB+B1JHLTkyvpANhqWEot2KBba5XJVswzx0TejpWJRIoR2JS6wMHjM1nrS1p4YvsYoWJD1R1YCNE5uLz9pHlu94TCYymdGk6tmBeZAJXbiPNist8FumVd34fGA0rmonj4brUaUc/HWtlSqbvKVEB0ZBXzkjCsx1h/rCzF7UKs79V+FkxDDt7lqbhxPXR9Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6506007)(76116006)(66556008)(38100700002)(186003)(2906002)(83380400001)(64756008)(66446008)(53546011)(122000001)(66476007)(9686003)(52536014)(7696005)(55016002)(316002)(38070700005)(508600001)(8936002)(8676002)(71200400001)(110136005)(66946007)(86362001)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXgxc2MwczdxaG5PaWdQM2hqeDcyWUk1SHllK1hnTXdjTXp0QlNCVmlKZjMy?=
 =?utf-8?B?QUdqRy8ybm5VWXQvQXZHSkFMekZPMGJNb05VNDBzVjVaRXFTUlpmQlpjT3Ji?=
 =?utf-8?B?d3NRcmdCOWdrUnA1emtCWUVGZnh0OGI3cjdPRE83VmUyVll3dWxLdjFMRHV4?=
 =?utf-8?B?TUppNTZWWmxqdXMweXFMMVdQNmFVOWpGZlJYVEVMN1YyR0owYndyV3lVK0o1?=
 =?utf-8?B?d21VYVowM29sOUxjNzNCWDRMK3ozR3BOaHovWDJRaWJtSTYzUHZXY2NNM2tP?=
 =?utf-8?B?a1JvT01RNUtWUFZyODNoUGQrQzlzSGVGOVVFdFhSbi8vUEJUMU5Wa0JOakpV?=
 =?utf-8?B?aWZlOE1SdHJOcU1nTTRMRW9MSzVweGZ4eTdZZzRVc1licUVQU052dEYxYXl5?=
 =?utf-8?B?bmlZdlRLNmJaa3FHcWtRbWlXd1RLK3NEQVhKVGtZOTVmaFBSV3BzUTRsQVpC?=
 =?utf-8?B?ckEzMUo0Yk1XY2NzbnZWMWNSL01CcHZaL1ZVaVM2SXNPdmQ1WjVpWXpsd0to?=
 =?utf-8?B?VFZTdmpjeWUwRnZVS3M2L2JGSUlzWTJqSm9mMHVFU254d1lXUU1rZXVXTkZ1?=
 =?utf-8?B?ZDEyWE9xUk9EYWN1TXg0dTdKUURCSUFDNEFOTDFYYTB2K3lwMktEZHAzVzdR?=
 =?utf-8?B?dXdTTDdzYUpFNWpvekFDOS9KWDVTYU8xa21IUVlkaUFBUjdOenJUNnlzRlli?=
 =?utf-8?B?TW1FZjhuMDNjL0pmVTZlSFNQZ084WWRpQ1duNnUvTW84UmxOUzMyZ2E0WlVV?=
 =?utf-8?B?Y0paN2pxQnBkRmh2cHAzQ3hZWUkybFordFl2eTBPZitFSXROcE8rb2NHYmxY?=
 =?utf-8?B?QzNIeiswd0IzcW9ZOGdvQm5SOFJ1WFNNZWZxVmVWNHIvVGlmS2pJZU5lQzZK?=
 =?utf-8?B?N3VGWDJZQ2I3VVZSdHpac1ZKNVRnWVh4Y1ZtTTVSZ1NwLzc1clMzeHpRLzNY?=
 =?utf-8?B?dDdCRDd2dFBCK0RRL0JCTXk2L0Y4dng2OEpmUzJiTXFmWWJRYUJ3ejlIU2hS?=
 =?utf-8?B?bjJvYURSOW9aVng4aGV6cTNCeCtveHcrSXp3TVRaU0xTc0d2RWJFM1djQndp?=
 =?utf-8?B?QSs2NDF5Vmg1V1hPZENuM2VoRWtadXZkK0NWYUdEVk5BTTF6ZnV4Zm44U0NM?=
 =?utf-8?B?MkYybkk0Y0hkTmU1MjRkaWxKVUhLODkzeHNDSkNMOG5tWWhoVjZiR2RBQUVC?=
 =?utf-8?B?YlNpcGNmazFHcU42Vnp4RmFiQmYvZjJOaXpyNG5XaXpZaUllQW5yQTUvY0dP?=
 =?utf-8?B?RlkwRTk4ZEo3ZVdnaUlNZWlrQ01IWG5WUGh2ejc0aHYvZ3BCVFJJNXhQMi9Q?=
 =?utf-8?B?ajFEQm5SUlk4Rm9oelYvbUhmT0RBMU0rNmtJZEtOU3VIUlZXY2hxeFkwQjY2?=
 =?utf-8?B?K2xrMHBiUGFkTVZNSGJlK0hEUUFPbk5MTVhOWC9Kc3JBcmtIZjVrWkVLamtz?=
 =?utf-8?B?cW15RGs5USs4WHdNekhQV0UvUDBBSkU0K1Z5TWt0Yi80RDZUVExEZGF2RDJX?=
 =?utf-8?B?MTc1Zm40VzRCVUZLK0VvN1FOUWNWSGNPSDgvNHR5OEhia0lBb2pHNjZPK1Ew?=
 =?utf-8?B?cG5RRUxkdFgyeWUyTlpFQU55SzJhY2tnYTlkdUFUdDBJeU5oekkzb2xzbW1W?=
 =?utf-8?B?NEFiVzJsd1hXdGl6b1k0TXVUODc3SlNseTBMcWhnakEwSTRHbkVvdFZoaGNS?=
 =?utf-8?B?S3VDY2lKekJKNDM3bkordU5VcUVDaG9CNnpyQ2ZHWjROaFVtcm95Rk9EbHF3?=
 =?utf-8?Q?cwMD/wHm5+J8xINJ3NDQOqCUX9rKE2NTrk1sUqi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e3626b-360b-4dbe-c762-08d97d8f7368
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 06:08:51.7728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKGLXnJCtlyFtJaB3/iATmsFqAVnpwHuwrZaZ56fi9LArzoEzqOcSeXQNgPcs2U8VNK6vG6h0TAlqgDDkMAx/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
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

W1B1YmxpY10NCg0KPiArCXN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbU0RNQTBfSFdJUF0pIHsN
Cj4gKwljYXNlIElQX1ZFUlNJT04oNSwgMiwgMCk6DQo+ICAgCQlhZGV2LT5zZG1hLm51bV9pbnN0
YW5jZXMgPSA0Ow0KPiAgIAkJYnJlYWs7DQpJc24ndCB0aGUgaW5zdGFuY2UgY291bnQgYWxzbyBl
eHBlY3RlZCBmcm9tIGRpc2NvdmVyeSB0YWJsZT8NCg0KVGhpcyB3aWxsIGJlIGFkZHJlc3NlZCBp
biBwYXRjaCA1NCBvZiB0aGUgc2VyaWVzLg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6YXIsIExpam8NClNlbnQ6IFdlZG5lc2Rh
eSwgU2VwdGVtYmVyIDIyLCAyMDIxIDE6NTYgUE0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
U3ViamVjdDogUmU6IFtQQVRDSCAwOS82Nl0gZHJtL2FtZGdwdS9zZG1hNS4yOiBjb252ZXJ0IHRv
IElQIHZlcnNpb24gY2hlY2tpbmcNCg0KDQoNCk9uIDkvMjEvMjAyMSAxMTozNiBQTSwgQWxleCBE
ZXVjaGVyIHdyb3RlOg0KPiBVc2UgSVAgdmVyc2lvbnMgcmF0aGVyIHRoYW4gYXNpY190eXBlIHRv
IGRpZmZlcmVudGlhdGUgSVAgdmVyc2lvbiANCj4gc3BlY2lmaWMgZmVhdHVyZXMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIHwgNDggKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9u
cygrKSwgMjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8yLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NV8yLmMNCj4gaW5kZXggZTRhOTZlN2UzODZkLi5jNTI1MmYxMmVlZTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jDQo+IEBAIC0xMzYsMjMgKzEzNiwy
MyBAQCBzdGF0aWMgaW50IHNkbWFfdjVfMl9pbml0X21pY3JvY29kZShzdHJ1Y3QgDQo+IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ICAgDQo+ICAgCURSTV9ERUJVRygiXG4iKTsNCj4gICANCj4gLQlz
d2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgew0KPiAtCWNhc2UgQ0hJUF9TSUVOTkFfQ0lDSExJRDoN
Cj4gKwlzd2l0Y2ggKGFkZXYtPmlwX3ZlcnNpb25zW1NETUEwX0hXSVBdKSB7DQo+ICsJY2FzZSBJ
UF9WRVJTSU9OKDUsIDIsIDApOg0KPiAgIAkJY2hpcF9uYW1lID0gInNpZW5uYV9jaWNobGlkIjsN
Cj4gICAJCWJyZWFrOw0KPiAtCWNhc2UgQ0hJUF9OQVZZX0ZMT1VOREVSOg0KPiArCWNhc2UgSVBf
VkVSU0lPTig1LCAyLCAyKToNCj4gICAJCWNoaXBfbmFtZSA9ICJuYXZ5X2Zsb3VuZGVyIjsNCj4g
ICAJCWJyZWFrOw0KPiAtCWNhc2UgQ0hJUF9WQU5HT0dIOg0KPiArCWNhc2UgSVBfVkVSU0lPTig1
LCAyLCAxKToNCj4gICAJCWNoaXBfbmFtZSA9ICJ2YW5nb2doIjsNCj4gICAJCWJyZWFrOw0KPiAt
CWNhc2UgQ0hJUF9ESU1HUkVZX0NBVkVGSVNIOg0KPiArCWNhc2UgSVBfVkVSU0lPTig1LCAyLCA0
KToNCj4gICAJCWNoaXBfbmFtZSA9ICJkaW1ncmV5X2NhdmVmaXNoIjsNCj4gICAJCWJyZWFrOw0K
PiAtCWNhc2UgQ0hJUF9CRUlHRV9HT0JZOg0KPiArCWNhc2UgSVBfVkVSU0lPTig1LCAyLCA1KToN
Cj4gICAJCWNoaXBfbmFtZSA9ICJiZWlnZV9nb2J5IjsNCj4gICAJCWJyZWFrOw0KPiAtCWNhc2Ug
Q0hJUF9ZRUxMT1dfQ0FSUDoNCj4gKwljYXNlIElQX1ZFUlNJT04oNSwgMiwgMyk6DQo+ICAgCQlj
aGlwX25hbWUgPSAieWVsbG93X2NhcnAiOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6DQo+
IEBAIC0xNzQsNyArMTc0LDcgQEAgc3RhdGljIGludCBzZG1hX3Y1XzJfaW5pdF9taWNyb2NvZGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCQkgICAgICAgKHZvaWQgKikmYWRldi0+
c2RtYS5pbnN0YW5jZVswXSwNCj4gICAJCSAgICAgICBzaXplb2Yoc3RydWN0IGFtZGdwdV9zZG1h
X2luc3RhbmNlKSk7DQo+ICAgDQo+IC0JaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAoYWRl
di0+YXNpY190eXBlID09IENISVBfU0lFTk5BX0NJQ0hMSUQpKQ0KPiArCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikgJiYgKGFkZXYtPmlwX3ZlcnNpb25zW1NETUEwX0hXSVBdID09IA0KPiArSVBf
VkVSU0lPTig1LCAyLCAwKSkpDQo+ICAgCQlyZXR1cm4gMDsNCj4gICANCj4gICAJRFJNX0RFQlVH
KCJwc3BfbG9hZCA9PSAnJXMnXG4iLA0KPiBAQCAtMTIwOSwxNyArMTIwOSwxNyBAQCBzdGF0aWMg
aW50IHNkbWFfdjVfMl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICB7DQo+ICAgCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
PiAgIA0KPiAtCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQo+IC0JY2FzZSBDSElQX1NJRU5O
QV9DSUNITElEOg0KPiArCXN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbU0RNQTBfSFdJUF0pIHsN
Cj4gKwljYXNlIElQX1ZFUlNJT04oNSwgMiwgMCk6DQo+ICAgCQlhZGV2LT5zZG1hLm51bV9pbnN0
YW5jZXMgPSA0Ow0KPiAgIAkJYnJlYWs7DQpJc24ndCB0aGUgaW5zdGFuY2UgY291bnQgYWxzbyBl
eHBlY3RlZCBmcm9tIGRpc2NvdmVyeSB0YWJsZT8NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IC0JY2Fz
ZSBDSElQX05BVllfRkxPVU5ERVI6DQo+IC0JY2FzZSBDSElQX0RJTUdSRVlfQ0FWRUZJU0g6DQo+
ICsJY2FzZSBJUF9WRVJTSU9OKDUsIDIsIDIpOg0KPiArCWNhc2UgSVBfVkVSU0lPTig1LCAyLCA0
KToNCj4gICAJCWFkZXYtPnNkbWEubnVtX2luc3RhbmNlcyA9IDI7DQo+ICAgCQlicmVhazsNCj4g
LQljYXNlIENISVBfVkFOR09HSDoNCj4gLQljYXNlIENISVBfQkVJR0VfR09CWToNCj4gLQljYXNl
IENISVBfWUVMTE9XX0NBUlA6DQo+ICsJY2FzZSBJUF9WRVJTSU9OKDUsIDIsIDEpOg0KPiArCWNh
c2UgSVBfVkVSU0lPTig1LCAyLCA1KToNCj4gKwljYXNlIElQX1ZFUlNJT04oNSwgMiwgMyk6DQo+
ICAgCQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMgPSAxOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWRl
ZmF1bHQ6DQo+IEBAIC0xNTQ3LDcgKzE1NDcsNyBAQCBzdGF0aWMgdm9pZCANCj4gc2RtYV92NV8y
X3VwZGF0ZV9tZWRpdW1fZ3JhaW5fY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGUNCj4gICANCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsg
aSsrKSB7DQo+ICAgDQo+IC0JCWlmIChhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3X3ZlcnNpb24g
PCA3MCAmJiBhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9WQU5HT0dIKQ0KPiArCQlpZiAoYWRldi0+
c2RtYS5pbnN0YW5jZVtpXS5md192ZXJzaW9uIDwgNzAgJiYgDQo+ICthZGV2LT5pcF92ZXJzaW9u
c1tTRE1BMF9IV0lQXSA9PSBJUF9WRVJTSU9OKDUsIDIsIDEpKQ0KPiAgIAkJCWFkZXYtPmNnX2Zs
YWdzICY9IH5BTURfQ0dfU1VQUE9SVF9TRE1BX01HQ0c7DQo+ICAgDQo+ICAgCQlpZiAoZW5hYmxl
ICYmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX1NETUFfTUdDRykpIHsgQEAgDQo+
IC0xNTg0LDcgKzE1ODQsNyBAQCBzdGF0aWMgdm9pZCANCj4gc2RtYV92NV8yX3VwZGF0ZV9tZWRp
dW1fZ3JhaW5fbGlnaHRfc2xlZXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYNCj4gICANCj4g
ICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsgaSsrKSB7DQo+ICAg
DQo+IC0JCWlmIChhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3X3ZlcnNpb24gPCA3MCAmJiBhZGV2
LT5hc2ljX3R5cGUgPT0gQ0hJUF9WQU5HT0dIKQ0KPiArCQlpZiAoYWRldi0+c2RtYS5pbnN0YW5j
ZVtpXS5md192ZXJzaW9uIDwgNzAgJiYgDQo+ICthZGV2LT5pcF92ZXJzaW9uc1tTRE1BMF9IV0lQ
XSA9PSBJUF9WRVJTSU9OKDUsIDIsIDEpKQ0KPiAgIAkJCWFkZXYtPmNnX2ZsYWdzICY9IH5BTURf
Q0dfU1VQUE9SVF9TRE1BX0xTOw0KPiAgIA0KPiAgIAkJaWYgKGVuYWJsZSAmJiAoYWRldi0+Y2df
ZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9TRE1BX0xTKSkgeyBAQCANCj4gLTE2MTMsMTMgKzE2MTMs
MTMgQEAgc3RhdGljIGludCBzZG1hX3Y1XzJfc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhh
bmRsZSwNCj4gICAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gICAJCXJldHVybiAwOw0K
PiAgIA0KPiAtCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQo+IC0JY2FzZSBDSElQX1NJRU5O
QV9DSUNITElEOg0KPiAtCWNhc2UgQ0hJUF9OQVZZX0ZMT1VOREVSOg0KPiAtCWNhc2UgQ0hJUF9W
QU5HT0dIOg0KPiAtCWNhc2UgQ0hJUF9ESU1HUkVZX0NBVkVGSVNIOg0KPiAtCWNhc2UgQ0hJUF9C
RUlHRV9HT0JZOg0KPiAtCWNhc2UgQ0hJUF9ZRUxMT1dfQ0FSUDoNCj4gKwlzd2l0Y2ggKGFkZXYt
PmlwX3ZlcnNpb25zW1NETUEwX0hXSVBdKSB7DQo+ICsJY2FzZSBJUF9WRVJTSU9OKDUsIDIsIDAp
Og0KPiArCWNhc2UgSVBfVkVSU0lPTig1LCAyLCAyKToNCj4gKwljYXNlIElQX1ZFUlNJT04oNSwg
MiwgMSk6DQo+ICsJY2FzZSBJUF9WRVJTSU9OKDUsIDIsIDQpOg0KPiArCWNhc2UgSVBfVkVSU0lP
Tig1LCAyLCA1KToNCj4gKwljYXNlIElQX1ZFUlNJT04oNSwgMiwgMyk6DQo+ICAgCQlzZG1hX3Y1
XzJfdXBkYXRlX21lZGl1bV9ncmFpbl9jbG9ja19nYXRpbmcoYWRldiwNCj4gICAJCQkJc3RhdGUg
PT0gQU1EX0NHX1NUQVRFX0dBVEUpOw0KPiAgIAkJc2RtYV92NV8yX3VwZGF0ZV9tZWRpdW1fZ3Jh
aW5fbGlnaHRfc2xlZXAoYWRldiwNCj4gDQo=
