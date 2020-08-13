Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B74C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EF920675
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LT1h/TvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EF920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385876E965;
	Thu, 13 Aug 2020 02:07:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B79E6E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 02:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O18qOsKyJuYtbC3BTAf8s8cXMqpRMxmwhWObo35xjX5k0JqdmXfN1b+Egcuq0Vdr848bz6iSDa4bNq9G3lx7JJGaF/hW0SOnJbyt3dNAvGjjPSPJ+tiIs3IB+7EOALi1IEJRxev4QL/dof/r05+PVeD5okA6Ln/18q7D9/SnMct1EPayIgO9QsuwG0rKnH6QPQPcecRXm83eP4Srr+GHsCd3D7Eqf15+BamHQFetNLpo2gnwuzgkthUSWA5IN/WypcIsYe6TWzCEqdmENQkuV3PnAHSrgGt8CCtHgdh76bbhA/qP0sZvRBaD4QOxlNY6V2HG7OtjjNIfOLvAsfogIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsJ2XC19D/qBb/dkrXgELNJmZorWHKhlyhwNqMq7Pv8=;
 b=ZEaSGGlPrElHctOKHiah0wrHiJVpPsdlVakT2lC4KB+s9LTZVOq4vQcpanQsxLKzpT1pVGNNglSWFwJHbhURXnWk/e0wFIUml3PKm+JSyRm87o9nZdGhNYjq8DB39IOl8VzN3rnsliHeSUTfFnaUSufrysyQoVQ91jwo5Q9TM2lpeZxVtGni0Eu/tOA9n+q+p+42YGOYK0s7Jw6vaCAQo8+jUPYvTIHrTXYBowdIHZCMrucrKEd+csHM4jROYdrNgFXTnNWx3D21wp5oI+2IdIUTpnzgrJeq/aH6DatSiq7964Yfm0bUTxyrySJ+ExlJmpeIJ3S7kjMUb3Fuktr/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsJ2XC19D/qBb/dkrXgELNJmZorWHKhlyhwNqMq7Pv8=;
 b=LT1h/TvLWptySAcvUQXVDPg1kxPux270Ykef9AoDn6FEGxxuUzx49NKt4oW8fwz4yYKuHi3+oj8AuB/F9PNAdSVy1ygwt5tLMF5HRE/yOM0uqx9MVvAGTdjazSvLsqEjjvUWOXlbaqppwmtl5k0m7ADh+WFlK46DdIbMJNUQBJA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Thu, 13 Aug 2020 02:07:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 02:07:53 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Topic: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Index: AQHWcKMG5zS07pNhF0G0RPbkF5vNcak1SmIw
Date: Thu, 13 Aug 2020 02:07:53 +0000
Message-ID: <DM6PR12MB2619E6D6AD9439DDA1FB72B6E4430@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200812122030.215907-1-tom.stdenis@amd.com>
In-Reply-To: <20200812122030.215907-1-tom.stdenis@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=20975483-779f-4971-a84d-658f09b80863;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-13T02:02:42Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08b640a9-ba89-43cb-fabe-08d83f2db06a
x-ms-traffictypediagnostic: DM5PR12MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2470DDEF3E75BA790539C11FE4430@DM5PR12MB2470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:215;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSQmzXmqsUnMdMx+Bs8Eo7ISofWiNfeFwD2qUN8/oigVFSD5jF2qQnU/bWlILbodF/vEtwVrtroYubIAXiTC3X8NLc4pwnEeJlUv7jXuPcDOfcNMd8++bca+DKoPglowpVuzPTt6+mEr/X6V21VqiW0rq/Iv87o1QxS+9S3ldS/im5ml0qk0YxOXZ7jn3gnNctzLqNwd73K+tewVgceb2fUyLHZPNp1JhgfoTjJrvLn5VXXpbYvwc+CaLl3sBn1bvq5+7zVhYovPsg25fCeEAvYHYAKVQEQtd2D6wqjzYy9YdeE7I/EKPah7qtMZgR8mcyiupRBfaFStCGYCd03QcZ2jtnBbwOzkyo/5H0cXmIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(71200400001)(86362001)(66446008)(66556008)(66476007)(83380400001)(76116006)(66946007)(110136005)(52536014)(8676002)(26005)(64756008)(55016002)(7696005)(33656002)(8936002)(478600001)(53546011)(9686003)(316002)(6506007)(5660300002)(2906002)(186003)(966005)(45080400002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5A+ldD0iyRQ7RYa3NgxIevebm12UCYu/OcXS7S0/aXwHdZ62k7HIi1cod94dgvuuZ/3ErOs9xlmEcYYapL6PxTT8RaMgp/WgGAKd0FBiOI84sJu0qNMwvbU0Pz1HTcYyEh1jx/MRrIooAFu6rJTAtNVMTg8W8TLynea3c/82NV5MK3/TUisP6keKFK2zptsXEKAk5nUuHLhIPrOFlEGRgzLhS5f8+uK89lcqnY5XR6a2fL58siyx4VZfRivLmOCBVJoHAHzdphQZeIQ8Y5LYyC4Eud1KWPprcWTVUYA6PArkOP93Q0qsHon6LHHOvIEUKinW4XngnMLnL3fMUQYBvqaGvZyWpe4mKMRJixu3eyHyc41wN5qXXB+IsOOqmHygiIz0H/1D1zE8836ikJYG7ntpd3OL+GqnO0ZqAmjgaN0YIbgzY7/ktbXiXhTDSdwOBBW1jEclrZfgC9JfPZZW0DOlUrho63qdJ6U+f9+Fozjkgvl7279LXKFI6TxerRbAmZ3uogTFFjmXDiYnUPhq8ZromvoKMC/4HVrEULcJgHkJXxFxVB/yknK4a7mu/aYAglqm0OQQTnWY07AHWnhKgzzTCanR9Gm+fZnV3G0xrZvuR3FkKVtSkZi/HI5IxeN4dEk+v0a6m6mm/C+AL7vYGQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b640a9-ba89-43cb-fabe-08d83f2db06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:07:53.7055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U47ZOL45lVg849jhtM6tEcgdcorrE9+n7grL7oFE1CphwZT4r7tAQ6HHgwIANPsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpZ
b3VyIGNoYW5nZSBiZWxvdyBzaG91bGQgYmUgYWJsZSB0byBzdXBwcmVzcyB0aGUgY29tcGlsZSB3
YXJuaW5nLg0KLWFyY3R1cnVzX2dldF9zbXVfbWV0cmljc19kYXRhKHNtdSwNCityZXQgPSBhcmN0
dXJ1c19nZXRfc211X21ldHJpY3NfZGF0YShzbXUsDQogICAgICAgTUVUUklDU19USFJPVFRMRVJf
U1RBVFVTLA0KICAgICAgICZ0aHJvdHRsZXJfc3RhdHVzKTsNCg0KK2lmIChyZXQpIHsNCitkZXZf
ZXJyKGFkZXYtPmRldiwgIkNvdWxkIG5vdCByZWFkIGZyb20gYXJjdHVydXNfZ2V0X3NtdV9tZXRy
aWNzX2RhdGEoKVxuIik7DQorcmV0dXJuOw0KK30NCisNClNldHRpbmcgKnZhbHVlIGFzIDAgbWF5
IGJlIHVubmVjZXNzYXJ5LiAgSG93ZXZlciBhbnl3YXkgdGhpcyBwYXRjaCBpcyByZXZpZXdlZC1i
eTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCg0KQlINCkV2YW4NCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgVG9tIFN0IERlbmlzDQpTZW50OiBXZWRuZXNkYXks
IEF1Z3VzdCAxMiwgMjAyMCA4OjIxIFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBTdERlbmlzLCBUb20gPFRvbS5TdERlbmlzQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG93ZXJwbGF5OiBGaXggdW5pbml0aWFsaXplZCB3YXJuaW5nIGluIGFyY3R1
cnVzIHBwdCBkcml2ZXINCg0KRml4ZXM6DQoNCiAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLm8NCmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYzogSW4gZnVu
Y3Rpb24g4oCYYXJjdHVydXNfbG9nX3RoZXJtYWxfdGhyb3R0bGluZ19ldmVudOKAmToNCmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYzoyMjIzOjI0
OiB3YXJuaW5nOiDigJh0aHJvdHRsZXJfc3RhdHVz4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6
ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQ0KIDIyMjMgfCAgIGlm
ICh0aHJvdHRsZXJfc3RhdHVzICYgbG9nZ2luZ19sYWJlbFt0aHJvdHRsZXJfaWR4XS5mZWF0dXJl
X21hc2spIHsNCg0KYnkgbWFraW5nIGFyY3R1cnVzX2dldF9zbXVfbWV0cmljc19kYXRhKCkgYXNz
aWduIGEgZGVmYXVsdCB2YWx1ZSAob2YgemVybykgYmVmb3JlIGFueSBwb3NzaWJsZSByZXR1cm4g
cG9pbnQgYXMgd2VsbCBhcyBzaW1wbHkgZXJyb3Igb3V0IG9mIGFyY3R1cnVzX2xvZ190aGVybWFs
X3Rocm90dGxpbmdfZXZlbnQoKSBpZiBpdCBmYWlscy4NCg0KU2lnbmVkLW9mZi1ieTogVG9tIFN0
IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCAxMiArKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMNCmluZGV4IDhiMTAyNWRjNTRmZC4uNzhmN2Vj
OTVlNGY1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVy
dXNfcHB0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3Bw
dC5jDQpAQCAtNTUxLDYgKzU1MSw5IEBAIHN0YXRpYyBpbnQgYXJjdHVydXNfZ2V0X3NtdV9tZXRy
aWNzX2RhdGEoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQoNCiBtdXRleF9sb2NrKCZzbXUtPm1l
dHJpY3NfbG9jayk7DQoNCisvLyBhc3NpZ24gZGVmYXVsdCB2YWx1ZQ0KKyp2YWx1ZSA9IDA7DQor
DQogcmV0ID0gc211X2Ntbl9nZXRfbWV0cmljc190YWJsZV9sb2NrZWQoc211LA0KICAgICAgICBO
VUxMLA0KICAgICAgICBmYWxzZSk7DQpAQCAtMjIwOCwxNSArMjIxMSwyMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHRocm90dGxpbmdfbG9nZ2luZ19sYWJlbCB7ICB9OyAgc3RhdGljIHZvaWQgYXJj
dHVydXNfbG9nX3RoZXJtYWxfdGhyb3R0bGluZ19ldmVudChzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSkgIHsNCi1pbnQgdGhyb3R0bGVyX2lkeCwgdGhyb3R0aW5nX2V2ZW50cyA9IDAsIGJ1Zl9pZHgg
PSAwOw0KK2ludCB0aHJvdHRsZXJfaWR4LCB0aHJvdHRpbmdfZXZlbnRzID0gMCwgYnVmX2lkeCA9
IDAsIHJldDsNCiBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsNCiB1aW50
MzJfdCB0aHJvdHRsZXJfc3RhdHVzOw0KIGNoYXIgbG9nX2J1ZlsyNTZdOw0KDQotYXJjdHVydXNf
Z2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LA0KK3JldCA9IGFyY3R1cnVzX2dldF9zbXVfbWV0cmlj
c19kYXRhKHNtdSwNCiAgICAgICBNRVRSSUNTX1RIUk9UVExFUl9TVEFUVVMsDQogICAgICAgJnRo
cm90dGxlcl9zdGF0dXMpOw0KDQoraWYgKHJldCkgew0KK2Rldl9lcnIoYWRldi0+ZGV2LCAiQ291
bGQgbm90IHJlYWQgZnJvbSBhcmN0dXJ1c19nZXRfc211X21ldHJpY3NfZGF0YSgpXG4iKTsNCity
ZXR1cm47DQorfQ0KKw0KIG1lbXNldChsb2dfYnVmLCAwLCBzaXplb2YobG9nX2J1ZikpOw0KIGZv
ciAodGhyb3R0bGVyX2lkeCA9IDA7IHRocm90dGxlcl9pZHggPCBBUlJBWV9TSVpFKGxvZ2dpbmdf
bGFiZWwpOw0KICAgICAgdGhyb3R0bGVyX2lkeCsrKSB7DQotLQ0KMi4yNi4yDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcg
bGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2V2YW4ucXVhbiU0MGFtZC5jb20lN0MzM2NiYTcwNmRkYmI0MWI2ZjAxNTA4ZDgzZWJhMjZi
ZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczMjgzMTY1
NDkwNDEwOTImYW1wO3NkYXRhPTdCY1VtbVRoYlpVOHF1UDBnNHQzYWpTWWUzc2NDT2FoaWdPJTJC
eWUyR0hhdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
