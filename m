Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C08C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5D3215A5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D3215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD9D6E0F5;
	Fri, 29 Nov 2019 09:09:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680069.outbound.protection.outlook.com [40.107.68.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CA36E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3VINmdoom17Q5A9kPVrmYjPna/mtJcZ9L/NsR5nZS+U/gZYEHtXeRoEftFULQzVcrzm5bvA69u/mKhJKw+jB274o0IAyNaW2ub+FpuFz4W7hg1f7Eqe0HrYuUPqfZgfiJ8cCum3MeAkianEym+WOJygrNjJ7P7PohDU+stSgCoVpLbiLMQncNvRKAS0bCZvKaP8zJ8tqWHSzHz8C9BmPtlAQvLg2Dw5diwBX3LmGuiM6GghHz0PkkJPYOaDMqyEi4c7Uh4VH0j8BzB0w+GrdpIeRJudC/kC+1rdS1AAUMljDUEhvwLXOcQd1/+avx2GsZYdy0LHrBr9DIWY4Imxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQDJnGFHEMbfZ7MzeQRS/m57xfhDoiLM0painSiFKm0=;
 b=L7Ilvd4Wxh6gF97UFVvdoirwmrH1FWizeB1QZGb2o52RbYAMP2vVb0w3RxvGzenVrXlfywpsrvaM/dxqczUp1ZkCEvFnfKx3IC4NetDccXA6scauNHEb376A9uib/1Z2ZjpZHn40HxAq+TfUOvUR2lvMYiUk261uvyKwejMjVS3vfbxNkXGyu/F6sSGLwd81+KFSj5QcAsc8DbQDcAJr37zbxRyeJy6fe60l0YSE7qHF0ImcHKTdiwnLjNWFw/qIH4Wg8ILupImgdufNGvZn6UBodFcNPeJpMtE6BxjrdwrqrmYKibP6nhTfqjrwJCnX/M2zbqZJcIgacd+O+ppJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 09:09:47 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:09:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Topic: [PATCH] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Index: AQHVpo7i7ivcX5cXn0+Q82pmsVn27Keh1Yxg
Date: Fri, 29 Nov 2019 09:09:46 +0000
Message-ID: <DM5PR12MB1418A01DA8C20B50AFE7E64DFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1575016052-26775-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1575016052-26775-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T09:09:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fbbc44b8-75d4-428b-b58c-0000dc1219d7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-29T09:09:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 513d1213-d911-48f1-bd24-00009d834614
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ece8ff0-2362-4854-a01f-08d774abe196
x-ms-traffictypediagnostic: DM5PR12MB1145:|DM5PR12MB1145:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1145A73EA1439EE24833E739FC460@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(13464003)(189003)(199004)(5660300002)(256004)(71190400001)(8936002)(2501003)(66066001)(4326008)(25786009)(446003)(74316002)(7736002)(52536014)(305945005)(229853002)(71200400001)(11346002)(26005)(8676002)(6506007)(53546011)(186003)(966005)(2906002)(99286004)(316002)(3846002)(6116002)(6436002)(7696005)(76176011)(9686003)(76116006)(110136005)(478600001)(66446008)(6246003)(102836004)(6306002)(33656002)(86362001)(66946007)(81156014)(66476007)(81166006)(64756008)(66556008)(45080400002)(14454004)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9U4eSnjhKmf2DrGflUDGe6zddIe42H7PycaHHd8f+Cd6zzas3TKodcvO6iqTaH+L1pOO2ty8b9X1F2iw6ZblZaqQphpVruGme3PaxbieB7KNoMNjtNXza8OeDRCVLvwwjkLHtLodPgEA9f5U/P/WvrqmEh0GzUml/ASp31k2SllDFztTQ6J9ZChjBwoqWFjxmEDw90vPKyUcvWHIkJw3ABtv1QFZjhu9obc8aiTvhANIcAfQK6cC18MAKxTibsvgNgwzVgeU/NJfTm9cyfJwwx5fvECUmqUQdYSH9GHEsIyvQYORTniaB/B9JZBIya115sGIfgYgLyruE2n6nboOPv28jiza7c5qyH7X/jm1TsfzcmdFEmrb6+EvRX3Lf9jcVr6fD093c2+N53PHs87FQ62gNoqg3G/sLveIIRdzkzYX/Ctbjg9cat5hjOZqAhC6p63aefy+164hHM8EByGnrq/Ryr32X1xrk6DIL3nrvCY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece8ff0-2362-4854-a01f-08d774abe196
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:09:46.7989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYUTNSwn6DsJbg9AZ5APa6aHMVYVZMlRcFfApUeo8OZP6N01ilj9TRcQD6FR10oYcr/uxsJBT5RXilsDE/yTjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQDJnGFHEMbfZ7MzeQRS/m57xfhDoiLM0painSiFKm0=;
 b=ikB1WSwYrBtxqObuJyuJsL+gbHqoQ8pK+GK9gjEUmx86hxu8p+jB02nI1vO5CpAtL/J/wZBeBPYkBwOp46uME+A9z5IsvFj+vn/ss465IXjothxuaSp5PDUw0ysmWhW8eL/V/S5syq9Qv2q1Y0VwrbCxAt4eiAqY7NFjMifhJ8Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgZGVidWcgbWVzc2FnZSBhZnRlciBnZnggZGlzYWJsZW1lbnQgYWN0dWFsbHkgbWFrZXMgbWUg
Y29uZnVzaW5nLCB3b3VsZCB5b3UgbWluZCB0byBkcm9wIHRoYXQuDQpPdGhlciB0aGFuIHRoYXQs
IHRoZSBwYXRjaCBpcw0KDQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IE9uIEJlaGFsZiBPZiBNb25rIExpdQ0KU2VudDogMjAxOeW5tDEx5pyIMjnml6UgMTY6MjgNClRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExpdSwgTW9uayA8TW9uay5MaXVA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2hvdWxkIHN0b3AgR0ZYIHJp
bmcgaW4gaHdfZmluaQ0KDQpUbyBhbGlnbiB3aXRoIHRoZSBzY2hlbWUgZnJvbSBnZng5DQoNCmRp
c2FibGluZyBHRlggcmluZyBhZnRlciBWTSBzaHV0ZG93biBjb3VsZCBhdm9pZCBnYXJiYWdlIGRh
dGEgYmUgZmV0Y2hlZCB0byBHRlggUkIgd2hpY2ggbWF5IGxlYWQgdG8gdW5uZWNlc3Nhcnkgc2Ny
ZXcgdXAgb24gR0ZYDQoNClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxICsNCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMNCmluZGV4IDIzMGU4YWYuLjg4MmNmMWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0zODA5LDYgKzM4MDksNyBAQCBzdGF0aWMgaW50IGdm
eF92MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkNCiAJaWYgKGFtZGdwdV9nZnhfZGlzYWJsZV9r
Y3EoYWRldikpDQogCQlEUk1fRVJST1IoIktDUSBkaXNhYmxlIGZhaWxlZFxuIik7DQogCWlmIChh
bWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCisJCWdmeF92MTBfMF9jcF9nZnhfZW5hYmxlKGFkZXYs
IGZhbHNlKTsNCiAJCXByX2RlYnVnKCJGb3IgU1JJT1YgY2xpZW50LCBzaG91bGRuJ3QgZG8gYW55
dGhpbmcuXG4iKTsNCiAJCXJldHVybiAwOw0KIAl9DQotLQ0KMi43LjQNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0
DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdD
aGF3a2luZy56aGFuZyU0MGFtZC5jb20lN0M1YTgwOTg2ZDJhMDQ0Zjg3MGI4NzA4ZDc3NGE1ZmZi
OSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDYxMjg2
OTA1Mzg5NDgmYW1wO3NkYXRhPVZsNkF2c0JGMm5BN3NjM2VZRGowZ1Z5MkprZmhIZ1YySm83OEx3
bWdTU00lM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
