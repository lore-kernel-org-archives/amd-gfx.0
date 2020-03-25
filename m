Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360DC18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A44206F8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PqpayXrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A44206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4490089359;
	Wed, 25 Mar 2020 08:50:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2F98931F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqVYPcU4VG81OxKsg42TfjcMs1amNridbN7fW8dkuyLe36T44CSNi1bQ5n2L7N9RJTrfQ8NEOqSpB3+IHgfz/7bQ5LVMszZljjloLjpEvfPhH6vaXGo+bhCroD6vlOAmFcmP9Zfn+pVcry5fd4poABl+02Mu4WocJAPreFogW46aMLrBJRj3+A3D+g8mapSxsAiZLjUxZqzq2UTFA633GecDeSop9mCYlz989D/Vi+DRHaHcm+fNz6+TVMUrxL+9ABVCsxiOgmIQ7Bc6BEpdZuX9oEb9RD38CR/WOp1T08OmtZG+U7tpMgWkVJs+diaHGTFwswAwv2QojTOyqTe7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7AptoMDYwSW/O/f6O87Pfwuz+gxllnV37JSQPhqDgk=;
 b=R5/RtWUx80l5A2KCs1sYkHi+Hf3DAQDdqFJcMTSiUTAAQlJCwbHEXnN6OpvCBnqp5T4jDCpsPq+6TUShnPuPYE1zebY3cEpuF/u5DAR0XR2Vo/+Ix+n/tlpmqKY1k9kFDiOmk/sHfrKQxI9hzLaoW6gvRk1eY6O3EL/3KbCqla9i+NSUuHp8DRcwcQloH4a5CtteZHJwU/N8jStgoJsI20nJK1TQE5jEpjJ2ux0IAtI5KHoPzAR0yL1A+tjcuTL9g2nLLhICrQ8T0w0Tyq2olzsSawJGuNbtR0cHSLhdMkCHzgrLFLYi0yhX2C8RmnsHTbO9Y43ydXh8ubQksVSeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7AptoMDYwSW/O/f6O87Pfwuz+gxllnV37JSQPhqDgk=;
 b=PqpayXrcy9TuO3nvUvccQyiopgpNTEKe0zfl8SdxMXC8DzGjeeS5E7UL3FVryjWixJ8pep87eXvepYZrdsqovGmVhKBYkISWoc9G/7dboBTAOe5oeo7y53SiXRRz3uQDA67lFj0+WC8eHpJ3NlV+4Ri2FdNdYjSU/At25K9MZXg=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 by CH2PR12MB3863.namprd12.prod.outlook.com (2603:10b6:610:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 08:50:06 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::10fb:4a8b:7913:5a97]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::10fb:4a8b:7913:5a97%5]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 08:50:06 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
Thread-Topic: [PATCH] drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
Thread-Index: AQHWAn2bPNMlRD50nkGjdomSsHm+e6hY/72A
Date: Wed, 25 Mar 2020 08:50:06 +0000
Message-ID: <CH2PR12MB3767F023D0887801D32190E7FECE0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20200325081208.10110-1-evan.quan@amd.com>
In-Reply-To: <20200325081208.10110-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T08:50:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9c3fe2b9-6ee7-4bb0-820a-00007d899a00;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T08:50:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dca2b604-fe93-4bb8-9baa-0000d16fd954
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75f71afc-5ad6-470f-540d-08d7d0998439
x-ms-traffictypediagnostic: CH2PR12MB3863:|CH2PR12MB3863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3863264813374150D65AE9D5FECE0@CH2PR12MB3863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(2906002)(53546011)(110136005)(6506007)(45080400002)(33656002)(7696005)(66946007)(71200400001)(5660300002)(81156014)(8676002)(316002)(81166006)(4326008)(186003)(966005)(8936002)(86362001)(55016002)(66446008)(66476007)(66556008)(26005)(76116006)(52536014)(64756008)(9686003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3863;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huAKaLbrJ6sSuNWNzjyVxFs1OGYt9NUs9gNQhvAmVa+/D7VCuM3YDxBCYRMOhCn4cXKLwO52p9hgSANMtxXV1HyxoVTCDpY26W2oBbbvN+0ry+sKYLjVYv8dh0fBBJQKRf4+OQ+JP45Lk0hBwGQT6fByRpXDSnZk4XzvIKWsTmmA/ngiGpRpsLAugCrLutett7piipUd4bBTsb7jx4ZkOrbEh5D4KEsTptRwtmufADh57DqD/2rdzt7jHFnU64RpD6uSX2brMBci506cVOui4uPL9I5iw+EVom7OPA03ks9MPH/s8GwkP9y8XmbH/knpUa6y2bGeOJmsPPe7riXLPaSZ8EAzEA4FdSz6X5++Yi1njqh+oFBzJZHCRZNU0SHns64Damj/YUnj3OvTFCvC7kT5n91xabMjQyksl628QEAKJj9ak90laOLKn34aVFqtHku7J8OsZJOxYBcspVRqdUgwa3hwL00umJoowq1RZ+Q=
x-ms-exchange-antispam-messagedata: 9wQP9coES4gbt/c7BHsvTmJ5XX9+wn5dPxlP0VnwD9S0UVLKXMiUX5Mvgf3jyHe146jq25swVEyKI76UsbxiBTbRomxWj9m0SfLADDTJzyVFZqglmKG9CdF4gPXSaZxUd+lyIzXCqcavwuppuCQTCA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f71afc-5ad6-470f-540d-08d7d0998439
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:50:06.1768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrzMi4+sZ0a/cCkrnb95tiw0TB5lQke/Trp+4Yhl3QlYbKEeFJ3/c6MEjrUB1nHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3863
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRXZhbiBRdWFuDQpTZW50OiAyMDIwxOoz1MIy
NcjVIDE2OjEyDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wb3dlcnBs
YXk6IHVubG9hZCBtcDEgZm9yIEFyY3R1cnVzIFJBUyBiYWNvIHJlc2V0DQoNClRoaXMgc2VxdWVu
Y2UgaXMgcmVjb21tZW5kZWQgYnkgUE1GVyB0ZWFtIGZvciB0aGUgYmFjbyByZXNldCB3aXRoIFBN
RlcgcmVsb2FkZWQuIEFuZCBpdCBzZWVtcyBhYmxlIHRvIGFkZHJlc3MgdGhlIHJhbmRvbSBmYWls
dXJlIHNlZW4gb24gQXJjdHVydXMuDQoNCkNoYW5nZS1JZDogSWM1YTgzYWQ0NjQ2NmExMjUzM2U5
ZjcwNGFkMDYzNDg4NTIxNTZlNzgNClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFu
QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
YyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KaW5kZXggNGZkNzdjN2NmYzgwLi45
MTRjOTQ0ZDkwMWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVfdjExXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMNCkBAIC0xNzE5LDYgKzE3MTksMTIgQEAgaW50IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXVfYmFjb19zdGF0ZSBzdGF0ZSkNCiAJCWlm
IChyZXQpDQogCQkJZ290byBvdXQ7DQogDQorCQlpZiAocmFzICYmIHJhcy0+c3VwcG9ydGVkKSB7
DQorCQkJcmV0ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUHJlcGFyZU1wMUZvclVu
bG9hZCwgTlVMTCk7DQorCQkJaWYgKHJldCkNCisJCQkJZ290byBvdXQ7DQorCQl9DQorDQogCQli
aWZfZG9vcmJlbGxfaW50cl9jbnRsID0gUkVHX1NFVF9GSUVMRChiaWZfZG9vcmJlbGxfaW50cl9j
bnRsLA0KIAkJCQkJCUJJRl9ET09SQkVMTF9JTlRfQ05UTCwNCiAJCQkJCQlET09SQkVMTF9JTlRF
UlJVUFRfRElTQUJMRSwgMCk7DQotLQ0KMi4yNi4wDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0ZlaWZlaS5YdSU0
MGFtZC5jb20lN0M4MzdkNmVjY2UzMGE0ZTJkYzNmYjA4ZDdkMDk0OTc3NCU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcyMDcyMDk1NDg3MzI4MzgmYW1wO3Nk
YXRhPWtiSzU3N3ZLcUVhUWZWaURvYVA3ZWxPb1Q1cWdPa2hkViUyQjNZbjNKU2kybyUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
