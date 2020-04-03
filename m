Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFBAC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 13:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1012077D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="it5E3YYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1012077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4C46EB7F;
	Fri,  3 Apr 2020 13:04:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF25E6EB7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 13:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo1UjJF0WBkPOnCoAejsdyBLEY1D3ggvyGXdZiZvk0YFFu8k0fFOPM8rWDBskr46v9x8xbsWoLVmmNNMhg4qGBQsm5HRiKA18D8+SHxiJW2m5EQTebUWqNcZVEXSiUInGF6gY/QkbZQ4iSa898ikyY7KGRJzFuAHexcicT9VC3VnmHuJObdtDs4PFq90d/43ije742xL4OaLe6BObh8K0NjBzK0oiWP4tPqd+BeEuXMRsO/Dm8ekCo8Ci8UK0fvifo0yAnGl/FsvbR+KDvFi49mYAaEcSixVQPQQ9p7Qsy2/hWAYtLV0cBfVIDgI7v6R+zTXrx0lLcd/zXDRnV6lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyx4/7Twh9hbOkDlk3Hnd+04jiZumS5SPTcWdklIDVI=;
 b=UsBZomC/wj6JAsoayae2VLEHR5d+8zHkhVNGoKqPnokVklKT1FgcaQn3uXxyDpSzI92lf4zOHz2HDS+mVupLvouRjjMsyWzvRWO2imI4xKu77jjg0jKGduRehoEKC0SdpsYRmnr7X5Urq46OW/mi2oOG6RLAoq4vsdXnZOVfWodg5jHZjGHEnvXGACWdFX5f821yJqOysvf3XMxj4bA7Ja2In4T3KWaAOr7pLUcY/PupWIPzvaBgsHBI5tLA6wOtNnmeCjL5uSUnpaoDTLrfC/2K9j2nrHMcF9U2xDC8vbOmBE8/39Z6P34F8q0HqN+KJNKFxlqJ6p3Y1I5K9wPsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyx4/7Twh9hbOkDlk3Hnd+04jiZumS5SPTcWdklIDVI=;
 b=it5E3YYgAuhcWJXWKbpK1EvR+cHYDTkoklEzmHzx/qxwJ+4IyT9nOz0dU0sDTdtRUHc4jJGZL/5gWdWlEPUkyWJmsxiznZkVHMjQcOKe2gl1+5+KjoK9gkbdVy86cF2OKuB3KmIfLQH6GvViJYqIGhfDRKR3VgSR3NCBl2MTRcw=
Received: from CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16)
 by CY4PR12MB1175.namprd12.prod.outlook.com (2603:10b6:903:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 13:03:56 +0000
Received: from CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::f51e:9dd:64d3:315e]) by CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::f51e:9dd:64d3:315e%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 13:03:56 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
Thread-Topic: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
Thread-Index: AQHWCbcCvUVI5kXRK02oumYA8LMlwahnXSiA
Date: Fri, 3 Apr 2020 13:03:56 +0000
Message-ID: <CY4PR12MB1623B1FF6F67E62FB9D13514FEC70@CY4PR12MB1623.namprd12.prod.outlook.com>
References: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T13:03:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=48a8883f-f876-407d-848d-000074c16bee;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T13:03:53Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9dae602a-1541-4f09-a7ab-0000890a8cb7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7c39cf4-87e6-445c-ae5c-08d7d7cf77d5
x-ms-traffictypediagnostic: CY4PR12MB1175:|CY4PR12MB1175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1175070FAC72705CB416FCCCFEC70@CY4PR12MB1175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(316002)(966005)(52536014)(81156014)(8676002)(81166006)(55016002)(8936002)(9686003)(6506007)(110136005)(54906003)(66476007)(53546011)(76116006)(26005)(66446008)(66556008)(33656002)(7696005)(45080400002)(86362001)(186003)(64756008)(71200400001)(4326008)(5660300002)(66946007)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDLsYZqmOI/7z0lzv2WphwkiPhRDWwmAWguRRG2yS3FBLXLqI2vqtnt+f/WHcyDyuqzQJlzFCrAmPTIOC7xwN1MLV6o8bClklWzL4ADtROoKP4o5jf5evlWOHGnb1ZbPlKMvyJTvQusQ37avtsYemFZsXH/W/ausr3dIOJ+68UHnW0WUvcyg5cDv0gbt9vP+t2+toGT2wz+ydO+RAWqliVkqnbpx8irGFAqJ8+clp+jdLRklPgM3EvG+AAmT/m/QTSOB7yzkG9FIz4Bdy0KeZitzirjmT1pI/drBSNTJyCYwl/hQTC/Vz+++2iu3+LJcySUtfe2ztDpLl0NRQGNrELVwdlhGYcgbXIzeATxpLV8CcMd5Eo+KqbEGwx5nGwvldGYsSYjEEgak1EO/WVye+Hnlt/r8clL9TI4chU8j5ZE2KtQCHe12cPxO9wMSaQWMpCiVsCuvo2aQLx8lFU+WnQ8nCwJu+iI6Il/l5JuFvrQ=
x-ms-exchange-antispam-messagedata: 8u/TBd+qgUFU6LVAnxu2xwig7qF2Mn/0NOI4rp8croohOX7vWEBECv5uI7jhXx/QrGNSllRVjtZI/+eH5oFqjSp7eomAbkT+Pw0vp8PBK+zqnyYFZoY746+idHzKM7XHAUeGUL2OxJT8amcuC6Qcxw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c39cf4-87e6-445c-ae5c-08d7d7cf77d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 13:03:56.2830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQh5+MWsTqdmCeYc8jzysi3Ac06q5QGzHr4Rs65dA8JdvoCKSqSLeYr3Zhzu32Es
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>, "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSmFtZXMgWmh1DQpTZW50OiAyMDIwxOo01MIz
yNUgMjA6NTINClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExpLCBQYXVs
aW5lIDxQYXVsaW5lLkxpQGFtZC5jb20+OyBaaHUsIEphbWVzIDxKYW1lcy5aaHVAYW1kLmNvbT4N
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS92Y246IGFkZCBzaGFyZWQgbWVub3J5IHJlc3Rv
cmUgYWZ0ZXIgd2FrZSB1cCBmcm9tIHNsZWVwLg0KDQpWQ04gc2hhcmVkIG1lbW9yeSBuZWVkcyBy
ZXN0b3JlIGFmdGVyIHdha2UgdXAgZHVyaW5nIFMzIHRlc3QuDQoNClNpZ25lZC1vZmYtYnk6IEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKyAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5jDQppbmRleCBkNjUzYTE4Li41ODkxMzkwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMNCkBAIC0yMDUsNiArMjA1LDcgQEAgaW50IGFtZGdwdV92Y25fc3dfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCWlmIChhZGV2LT52Y24uaGFydmVzdF9j
b25maWcgJiAoMSA8PCBqKSkNCiAJCQljb250aW51ZTsNCiANCisJCWt2ZnJlZShhZGV2LT52Y24u
aW5zdFtqXS5zYXZlZF9zaG1fYm8pOw0KIAkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT52
Y24uaW5zdFtqXS5md19zaGFyZWRfYm8sDQogCQkJCQkgICZhZGV2LT52Y24uaW5zdFtqXS5md19z
aGFyZWRfZ3B1X2FkZHIsDQogCQkJCQkgICh2b2lkICoqKSZhZGV2LT52Y24uaW5zdFtqXS5md19z
aGFyZWRfY3B1X2FkZHIpOw0KQEAgLTI1NCw2ICsyNTUsMTggQEAgaW50IGFtZGdwdV92Y25fc3Vz
cGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCQlyZXR1cm4gLUVOT01FTTsNCiAN
CiAJCW1lbWNweV9mcm9taW8oYWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfYm8sIHB0ciwgc2l6ZSk7
DQorDQorCQlpZiAoYWRldi0+dmNuLmluc3RbaV0uZndfc2hhcmVkX2JvID09IE5VTEwpDQorCQkJ
cmV0dXJuIDA7DQorDQorCQlzaXplID0gYW1kZ3B1X2JvX3NpemUoYWRldi0+dmNuLmluc3RbaV0u
Zndfc2hhcmVkX2JvKTsNCisJCXB0ciA9IGFkZXYtPnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9jcHVf
YWRkcjsNCisNCisJCWFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibyA9IGt2bWFsbG9jKHNp
emUsIEdGUF9LRVJORUwpOw0KKwkJaWYgKCFhZGV2LT52Y24uaW5zdFtpXS5zYXZlZF9zaG1fYm8p
DQorCQkJcmV0dXJuIC1FTk9NRU07DQorDQorCQltZW1jcHlfZnJvbWlvKGFkZXYtPnZjbi5pbnN0
W2ldLnNhdmVkX3NobV9ibywgcHRyLCBzaXplKTsNCiAJfQ0KIAlyZXR1cm4gMDsNCiB9DQpAQCAt
MjkxLDYgKzMwNCwxOSBAQCBpbnQgYW1kZ3B1X3Zjbl9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQogCQkJfQ0KIAkJCW1lbXNldF9pbyhwdHIsIDAsIHNpemUpOw0KIAkJfQ0KKw0K
KwkJaWYgKGFkZXYtPnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9ibyA9PSBOVUxMKQ0KKwkJCXJldHVy
biAtRUlOVkFMOw0KKw0KKwkJc2l6ZSA9IGFtZGdwdV9ib19zaXplKGFkZXYtPnZjbi5pbnN0W2ld
LmZ3X3NoYXJlZF9ibyk7DQorCQlwdHIgPSBhZGV2LT52Y24uaW5zdFtpXS5md19zaGFyZWRfY3B1
X2FkZHI7DQorDQorCQlpZiAoYWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfc2htX2JvICE9IE5VTEwp
IHsNCisJCQltZW1jcHlfdG9pbyhwdHIsIGFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibywg
c2l6ZSk7DQorCQkJa3ZmcmVlKGFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibyk7DQorCQkJ
YWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfc2htX2JvID0gTlVMTDsNCisJCX0gZWxzZQ0KKwkJCW1l
bXNldF9pbyhwdHIsIDAsIHNpemUpOw0KIAl9DQogCXJldHVybiAwOw0KIH0NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCmluZGV4IGY3MzllMWEuLmJkNzdkYWUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaA0KQEAgLTE5NCw2ICsxOTQsNyBA
QCBzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0IHsNCiAJYXRvbWljX3QJCWRwZ19lbmNfc3VibWlzc2lv
bl9jbnQ7DQogCXZvaWQJCQkqZndfc2hhcmVkX2NwdV9hZGRyOw0KIAl1aW50NjRfdAkJZndfc2hh
cmVkX2dwdV9hZGRyOw0KKwl2b2lkCQkJKnNhdmVkX3NobV9ibzsNCiB9Ow0KIA0KIHN0cnVjdCBh
bWRncHVfdmNuIHsNCi0tDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJG
bGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NGZWlmZWkuWHUlNDBhbWQuY29t
JTdDNmRlNTUxMmNhODU3NDI1NzYxMzEwOGQ3ZDdjZGQ3ODAlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjE1MTUyNjgxNjg2NjIwJmFtcDtzZGF0YT1YMDdn
RnE3Q2Yxc3dpJTJGVnRPbDBsZHBhT3NidEMzZ081QlBVbFl3eHJhbm8lM0QmYW1wO3Jlc2VydmVk
PTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
