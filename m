Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15FC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A5321739
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ykH6Sox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A5321739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9016E968;
	Tue,  3 Mar 2020 03:02:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05886E968
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 03:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmQsLUYsKNVI9GpYliy5Ad39rkq0P0C50baNuXAt/S7EOGYQyoo2DNS2Mtq8LDeoi3pUiRxCiiwi9XDaLCEFKDX2TDMG6DlsOlySd3CZxxADd7D3c/JOeHz9bTVpTDaIm+NQWuiQweQQYow0XFPh6os+WQFcKqCMR2JprpvUrSUtR4dzN904Ei2RtRcAblNEqkf4kgdxoE7xyq1DAB3plFqD+cBIeVO7b/nrLFeltwJgj0zOAneXxD0rqRa15Eg2IZW2G/stbBRxU2yFd5xa60FDTpStXV4SXpNLc5EgNw8oMmFMjagLWRumQBXYkLlxvXTWcjCnrBXxZhnvTxbAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=indzXQxWrJIgYmNkmlRDSzywmc2Zw7KZ3KDYjDhFkwQ=;
 b=CxlFv44O4u4Edl2p73AfN5+oxkAR52StEAS1pCzQn0bRE1hXtZmz0f1KyX6j/T2VvBf+ZsVKeOl2UlkXHSVsDQpCiRMLBX0IRuMCoAfDc9FxUQoWpiBHtDqvZcHHU1WpwsMKkpNiiGayK7KnjhsFZJIu3933iwrIu03jTRZGFHMVXXCV67UKSVFERHPZy9VYHQfWWa9+0uyZe72iiwgh0xEWVkrH+PlE4g9giK6biszxmZYP95pG4zwSKoys793k4weUxagpV8Wheu+oa3XY0aL/UGsLNNB8gKFQzA4veFVZEOsswyxftApqHmbHjR5p8nj24E0onoHCAEdldNRK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=indzXQxWrJIgYmNkmlRDSzywmc2Zw7KZ3KDYjDhFkwQ=;
 b=1ykH6SoxL9a+tgWIHe2NPXPylonh8qf3KIAm32Yy3bBSRj/scJ5mT1MPPDyBtoOp+el3QCF0SejQIzSCDmXorI6ftSauHVMdA1XLmUGxiE+SGaWDfVysqCRI3E6jxW5DxtZqpjVBZW8dszvPLCV0xgPu/coizID+eRCy+VKSZoI=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 03:02:35 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 03:02:35 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Li, Dennis" <Dennis.Li@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP
Thread-Topic: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for
 HDP
Thread-Index: AQHV8H4u4ZUsDpJY6EGf6ZXUdK6kqag2LxRw
Date: Tue, 3 Mar 2020 03:02:35 +0000
Message-ID: <MN2PR12MB3054DE4692B4D06A61182C12B0E40@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
 <20200302103339.31723-5-Hawking.Zhang@amd.com>
In-Reply-To: <20200302103339.31723-5-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T03:02:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8b11680a-c9bb-4414-92ae-00008612413b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-03T03:02:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 293ee557-f8ec-494e-93c7-000090ba9253
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [183.232.44.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 677446fc-7bf5-418c-9c09-08d7bf1f5346
x-ms-traffictypediagnostic: MN2PR12MB3118:|MN2PR12MB3118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3118E3C028E4926E92C3F5DAB0E40@MN2PR12MB3118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(110136005)(33656002)(71200400001)(86362001)(52536014)(5660300002)(6636002)(4326008)(6506007)(316002)(7696005)(9686003)(55016002)(53546011)(66476007)(8676002)(76116006)(66556008)(64756008)(66946007)(8936002)(66446008)(26005)(186003)(478600001)(81156014)(2906002)(81166006)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3118;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/M+FjB9IulB7Cnvq0IklDifh7Z1TrBmRR1RlGd285jKa2S2fuV1yb7N2yqfYoI4Rqes0kcCSVlHaLskRYbMAJPT5U6Kb1617VCjTKi2GrqXfpRIx3NqUtYtLMYrTGX0bDnTwuz6Mw5xcez/e1kICMrcofSiRfMRSbYCXPpQ0rUQRPCaMZC5BeKWaW0bJmvi38OTmJW0CpMTzKxuuZAc+GuNOVqCIJ8SnRIAs4ipzthL2ySKVr9DQgGYHv8nSibqgCgQubghdMN8oxDOreFrevmhuq4arMTIRDZyN4yYaB+JRhFNCh0U/sAF+DSFtYjcuhk7mBtZbbEBoW+LPtFjeKD8XY8pTIJMo0vnkgaWvGvbsCY8vtRTfgrll3MNcakkTxteNEitmRFN4U6NZNYkW/odFhy6sSrgU5mKOn1GRy/FXYUuLx8EQNaL8ujZrC0LGk9wHtJ7o6npIZwyV6TRVvKSDnI4wxbQszrO2q+EderBPvtWJ/ZZdVsRKJyMHIg/
x-ms-exchange-antispam-messagedata: 1N1DJIQ7Gp4yM6DywB+910TVOsjUb9+nqVQRNQ2kYjblRpX/rcdttE+9qT8Kc2UjYs8cdxglc5jh+2O9ELUSb9S4hs3E9E+WgpZHtL4Rj9LPq70h9O+S/52jrul2PIwaQLUNa0H9LKBtCYJKnisj4g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677446fc-7bf5-418c-9c09-08d7bf1f5346
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 03:02:35.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS/eSr1j9qqZk4NtT2WwTz7OlkPcglLMoEatmYfIRmMs9AQspXTAo0EYTCOVzX2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgc2VyaWVzIGlzOg0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhd2tpbmcgWmhhbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU2VudDogMjAyMMTqM9TCMsjVIDE4OjM0DQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgQ2xlbWVudHMsIEpvaG4NCj4gPEpvaG4u
Q2xlbWVudHNAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPjsgQ2hlbiwN
Cj4gR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFt
ZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQo+IENjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1OiBhZGQgcmVzZXRfcmFzX2Vycm9yX2NvdW50IGZ1bmN0
aW9uIGZvcg0KPiBIRFANCj4gDQo+IEhEUCByYXMgZXJyb3IgY291bnRlcnMgYXJlIGRpcnR5IG9u
ZXMgYWZ0ZXIgY29sZCByZWJvb3QgUmVhZCBvcGVyYXRpb24gaXMNCj4gbmVlZGVkIHRvIHJlc2V0
IHRoZW0gdG8gMA0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwg
IDEgLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICB8IDE0ICsrKysr
KysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IGluZGV4IGE1
OGIwY2Y5ZGE1MS4uYjczNWUyMDg4OGE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaA0KPiBAQCAtNTk1LDYgKzU5NSw3IEBAIHN0cnVjdCBhbWRncHVfYXNpY19mdW5jcyB7
DQo+ICAJLyogaW52YWxpZGF0ZSBoZHAgcmVhZCBjYWNoZSAqLw0KPiAgCXZvaWQgKCppbnZhbGlk
YXRlX2hkcCkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAJCQkgICAgICAgc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKTsNCj4gKwl2b2lkICgqcmVzZXRfaGRwX3Jhc19lcnJvcl9jb3Vu
dCkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiAgCS8qIGNoZWNrIGlmIHRoZSBhc2lj
IG5lZWRzIGEgZnVsbCByZXNldCBvZiBpZiBzb2Z0IHJlc2V0IHdpbGwgd29yayAqLw0KPiAgCWJv
b2wgKCpuZWVkX2Z1bGxfcmVzZXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gIAkv
KiBpbml0aWFsaXplIGRvb3JiZWxsIGxheW91dCBmb3Igc3BlY2lmaWMgYXNpYyovIGRpZmYgLS1n
aXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiBpbmRleCBiNzQ2ZjI2ZjkzM2MuLmVm
ZDUyYmNmODc4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+
IEBAIC00MTQ5LDcgKzQxNDksNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19lbnRy
eQ0KPiBnZnhfdjlfMF9lZGNfY291bnRlcl9yZWdzW10gPSB7DQo+ICAgICB7IFNPQzE1X1JFR19F
TlRSWShHQywgMCwgbW1UQ0NfRURDX0NOVDIpLCAwLCAxLCAxNn0sDQo+ICAgICB7IFNPQzE1X1JF
R19FTlRSWShHQywgMCwgbW1UQ0FfRURDX0NOVCksIDAsIDEsIDJ9LA0KPiAgICAgeyBTT0MxNV9S
RUdfRU5UUlkoR0MsIDAsIG1tU1FDX0VEQ19DTlQzKSwgMCwgNCwgNn0sDQo+IC0gICB7IFNPQzE1
X1JFR19FTlRSWShIRFAsIDAsIG1tSERQX0VEQ19DTlQpLCAwLCAxLCAxfSwNCj4gIH07DQo+IA0K
PiAgc3RhdGljIGludCBnZnhfdjlfMF9kb19lZGNfZ2RzX3dvcmthcm91bmRzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gaW5k
ZXggNGFhNWI5YzhlNDNiLi42YjcxNzY5MWQ1NTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiBAQCAtODI3LDYgKzgyNywxNSBAQCBzdGF0aWMgYm9vbCBzb2MxNV9uZWVk
X2Z1bGxfcmVzZXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAJLyogY2hhbmdl
IHRoaXMgd2hlbiB3ZSBpbXBsZW1lbnQgc29mdCByZXNldCAqLw0KPiAgCXJldHVybiB0cnVlOw0K
PiAgfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB2ZWdhMjBfcmVzZXRfaGRwX3Jhc19lcnJvcl9jb3Vu
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiArKmFkZXYpIHsNCj4gKwlpZiAoIWFtZGdwdV9yYXNf
aXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX0hEUCkpDQo+ICsJCXJldHVybjsN
Cj4gKwkvKnJlYWQgYmFjayBoZHAgcmFzIGNvdW50ZXIgdG8gcmVzZXQgaXQgdG8gMCAqLw0KPiAr
CVJSRUczMl9TT0MxNShIRFAsIDAsIG1tSERQX0VEQ19DTlQpOw0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgdm9pZCBzb2MxNV9nZXRfcGNpZV91c2FnZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
dWludDY0X3QNCj4gKmNvdW50MCwNCj4gIAkJCQkgdWludDY0X3QgKmNvdW50MSkNCj4gIHsNCj4g
QEAgLTk5NCw2ICsxMDAzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfYXNpY19mdW5j
cw0KPiB2ZWdhMjBfYXNpY19mdW5jcyA9DQo+ICAJLmdldF9jb25maWdfbWVtc2l6ZSA9ICZzb2Mx
NV9nZXRfY29uZmlnX21lbXNpemUsDQo+ICAJLmZsdXNoX2hkcCA9ICZzb2MxNV9mbHVzaF9oZHAs
DQo+ICAJLmludmFsaWRhdGVfaGRwID0gJnNvYzE1X2ludmFsaWRhdGVfaGRwLA0KPiArCS5yZXNl
dF9oZHBfcmFzX2Vycm9yX2NvdW50ID0gJnZlZ2EyMF9yZXNldF9oZHBfcmFzX2Vycm9yX2NvdW50
LA0KPiAgCS5uZWVkX2Z1bGxfcmVzZXQgPSAmc29jMTVfbmVlZF9mdWxsX3Jlc2V0LA0KPiAgCS5p
bml0X2Rvb3JiZWxsX2luZGV4ID0gJnZlZ2EyMF9kb29yYmVsbF9pbmRleF9pbml0LA0KPiAgCS5n
ZXRfcGNpZV91c2FnZSA9ICZ2ZWdhMjBfZ2V0X3BjaWVfdXNhZ2UsIEBAIC0xMjM5LDYgKzEyNDks
MTANCj4gQEAgc3RhdGljIGludCBzb2MxNV9jb21tb25fbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkN
Cj4gIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiAgCQl4Z3B1X2FpX21haWxib3hfZ2V0
X2lycShhZGV2KTsNCj4gDQo+ICsJaWYgKGFkZXYtPmFzaWNfZnVuY3MgJiYNCj4gKwkgICAgYWRl
di0+YXNpY19mdW5jcy0+cmVzZXRfaGRwX3Jhc19lcnJvcl9jb3VudCkNCj4gKwkJYWRldi0+YXNp
Y19mdW5jcy0+cmVzZXRfaGRwX3Jhc19lcnJvcl9jb3VudChhZGV2KTsNCj4gKw0KPiAgCWlmIChh
ZGV2LT5uYmlvLmZ1bmNzLT5yYXNfbGF0ZV9pbml0KQ0KPiAgCQlyID0gYWRldi0+bmJpby5mdW5j
cy0+cmFzX2xhdGVfaW5pdChhZGV2KTsNCj4gDQo+IC0tDQo+IDIuMTcuMQ0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
