Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D1C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72576207FD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vG9k11pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72576207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6406E069;
	Thu,  5 Mar 2020 06:31:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16596E069
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 06:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQaQj33MHZu5GKKwATq8l+YQVkipiDENTcPpFSuP8qq3MoeYNVcYvCXEzb7pyBCq3yP/BLfBa9s/jCADrdAwig45fzgBBbU+AAd7szM3Q1VkNYOiv6N7dpmSf38nq6G2e8k0j6CFIGkbMoVpNhm/M3nwFUw0QNKS7iPCQHmuNcA6bBrNYzu2vZtj4myhVUICe12RVq2R2HirLIYMb7YoXPruqfcmNm6OE0BHYEWPZSeki4HzyTIPy3pf5vY6hLcsOML9GPlUBH78US3SEBpv/URsyfsAFM7qDsbx9lsDmR2vSqbmwCzXsXl83JftTQ4W1zj2fZbtZdgkgZamLRO0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp8MWWO6tKthIsl4DoqeBeIGKZGKqq7EYbGUhLG+inY=;
 b=jlVetVsSo6CPBCeF8YapYQmPrzNrxV7V6EPlyNxfef6NnFHo5XABZLGZj+dsilXnfXb+SxFOnRssMIEO0JfPVHhKtjF33xIJ18mWyX+9VBnni+l+QJEj96d+FRYYpuXRi6s8/HmRFSupfzbGaoZklTVlyZorzpeX9fakPJK+7XAJC7INmujOF5pirsPNncwBpUUrswNYLcXghcd4rAZF29bk5s12821BFWj1QHP7VA9MNZwqeVXfv8BXHcN1d6zXIfKhSG0xRONMPM/HYKjEri2F323eDZpYrDNuwJ5IEREMAfKxKUrBT/tg/yj+1lQUtEZiqw95qLFsWRMSSruX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp8MWWO6tKthIsl4DoqeBeIGKZGKqq7EYbGUhLG+inY=;
 b=vG9k11pQ43TTd++JkRUZ2SXm9V19b7ltx5+CVGyuN+q10kHEm3ze3jL0TeI2eWp+Oqmqv3f5aitcCh0732vbgSV6reuf7VQbWGX8+16kO1bIgSCR4917MgTNT6TEQevi5JF6cbBAhSde0QMZ7/zTLNF3a6N4LPzlvUmq5+b8tvc=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by MN2PR12MB2864.namprd12.prod.outlook.com (2603:10b6:208:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 5 Mar
 2020 06:31:49 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 06:31:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras error
 related registers
Thread-Topic: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras
 error related registers
Thread-Index: AQHV8jPHEPyLHy0TrUCXM13StelskKg5iRAA
Date: Thu, 5 Mar 2020 06:31:48 +0000
Message-ID: <MN2PR12MB3054940E9DDCA94D3A2DF219B0E20@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20200304144643.24892-1-guchun.chen@amd.com>
In-Reply-To: <20200304144643.24892-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T06:31:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6f78830c-bff6-4258-84f7-0000dacfc7a3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T06:31:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b607d815-952f-456d-a050-000057af84e8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [101.69.200.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc710e20-0284-4013-8aca-08d7c0cee28b
x-ms-traffictypediagnostic: MN2PR12MB2864:|MN2PR12MB2864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2864F4DA6B382F4D39F7D49CB0E20@MN2PR12MB2864.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:119;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(9686003)(186003)(81166006)(110136005)(5660300002)(52536014)(26005)(81156014)(478600001)(71200400001)(316002)(55016002)(66446008)(2906002)(64756008)(6636002)(6506007)(76116006)(53546011)(66476007)(8936002)(66946007)(8676002)(7696005)(66556008)(86362001)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2864;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HqAiCAp1pk+HO2p667hMCV7AxXR/f2VHYiCNeDkCExMgcRrKr4Wcq87vGG7MQToF2ymuE67LRM7sp596HwDBClrNoktDUp7yAqT1X56Iko/OPTB2Pxh30MN3pSswRFhIKViuswvSGuePUfk7HN3cR3jjPDnAj862dTmA0Xs1CjQzTURrl7ksDHF/o9om2ta9S3AmMY7kdmnMyACDaiwsj4nCuySoC7hO4djzcJ4hrMF0gPVyhlt3WJEYYAbMhr4M0OoiW7m+bPzzDnYgE61oQoWR139uibIxUMq5iRtoF8VB/679Nghkjr7z9KS3LZ+w98nkqy+xGO1zOqEenFTpDSnurUbmT7mG+wvLljyIYdMubTLRQ6pyke1iBK4wgFoL/yn1BN796m0Po40jIfs4908Ts8/2bBA1Wy8T5BSMr4dVnzFDETlN4UWaRZ5aKS5i
x-ms-exchange-antispam-messagedata: j1R9dW1OyMNSs9BlEeLNETghoojeGwpBRAFE3Ke8RgJvWwm/58dNLh37LOFMr/mQGohCTj4JyswHg55zmNUeSVN7TJKNoiNmSOARlLeSiyzMCpXUbdrrdDcNEoYe6VgkfNoMqBspHYvWXcgB0tgFcQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc710e20-0284-4013-8aca-08d7c0cee28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 06:31:48.8568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyhOQr0GIgiKLtmRQ1Ri+vDM8RaUxQyzEz/Tkj4diJ0op0F9yl2q/X8nyaQIQ6MA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2864
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpX
ZSBjYW4gYWxzbyBkZWZpbmUgYSBtYWNybyB0byByZXBsYWNlIHRoZSBjb2RlLCBhbmQgb25seSB0
aGUgbWFjcm8gc2hvdWxkIGJlIHVwZGF0ZWQgZm9yIG5ldyBBU0lDcyBpbiB0aGUgZnV0dXJlLg0K
QnV0IGVpdGhlciB3YXkgaXMgZmluZSBmb3IgbWUgY3VycmVudGx5LCB0aGUgcGF0Y2ggaXM6DQoN
ClJldmlld2VkLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQu
Y29tPg0KPiBTZW50OiAyMDIwxOoz1MI0yNUgMjI6NDcNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsg
TGksIERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBaaG91MSwgVGFvDQo+IDxUYW8uWmhvdTFA
YW1kLmNvbT47IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+DQo+IENjOiBD
aGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGdwdTogdG9nZ2xlIERGLUNzdGF0ZSB3aGVuIGFjY2Vzc2luZyBVTUMgcmFzDQo+IGVycm9y
IHJlbGF0ZWQgcmVnaXN0ZXJzDQo+IA0KPiBPbiBhcmN0dXJ1cywgREYtQ3N0YXRlIG5lZWRzIHRv
IGJlIHRvZ2dsZWQgb2ZmL29uIGJlZm9yZSBhbmQgYWZ0ZXIgYWNjZXNzaW5nDQo+IFVNQyBlcnJv
ciBjb3VudGVyIGFuZCBlcnJvciBhZGRyZXNzIHJlZ2lzdGVycywgb3RoZXJ3aXNlLCBjbGVhcmlu
ZyBzdWNoDQo+IHJlZ2lzdGVycyBtYXkgZmFpbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1
biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3VtY192Nl8xLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
bWNfdjZfMS5jDQo+IGluZGV4IGU2ODY2ZjAzODIwOS4uNzcxMjJhNzI4MmU3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMNCj4gQEAgLTE4Niw2ICsxODYsMTAgQEAg
c3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2NvdW50KHN0cnVjdA0KPiBhbWRn
cHVfZGV2aWNlICphZGV2LA0KPiAgCWlmIChyc211X3VtY19pbmRleF9zdGF0ZSkNCj4gIAkJdW1j
X3Y2XzFfZGlzYWJsZV91bWNfaW5kZXhfbW9kZShhZGV2KTsNCj4gDQo+ICsJaWYgKChhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgJiYNCj4gKwkJYW1kZ3B1X2RwbV9zZXRfZGZfY3N0
YXRlKGFkZXYsIERGX0NTVEFURV9ESVNBTExPVykpDQo+ICsJCURSTV9XQVJOKCJGYWlsIHRvIGRp
c2FibGUgREYtQ3N0YXRlLlxuIik7DQo+ICsNCj4gIAlMT09QX1VNQ19JTlNUX0FORF9DSCh1bWNf
aW5zdCwgY2hfaW5zdCkgew0KPiAgCQl1bWNfcmVnX29mZnNldCA9IGdldF91bWNfNl9yZWdfb2Zm
c2V0KGFkZXYsDQo+ICAJCQkJCQkgICAgICB1bWNfaW5zdCwNCj4gQEAgLTE5OSw2ICsyMDMsMTAg
QEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2NvdW50KHN0cnVjdA0KPiBh
bWRncHVfZGV2aWNlICphZGV2LA0KPiAgCQkJCQkJCSAgJihlcnJfZGF0YS0NCj4gPnVlX2NvdW50
KSk7DQo+ICAJfQ0KPiANCj4gKwlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVT
KSAmJg0KPiArCQlhbWRncHVfZHBtX3NldF9kZl9jc3RhdGUoYWRldiwgREZfQ1NUQVRFX0FMTE9X
KSkNCj4gKwkJRFJNX1dBUk4oIkZhaWwgdG8gZW5hYmxlIERGLUNzdGF0ZVxuIik7DQo+ICsNCj4g
IAlpZiAocnNtdV91bWNfaW5kZXhfc3RhdGUpDQo+ICAJCXVtY192Nl8xX2VuYWJsZV91bWNfaW5k
ZXhfbW9kZShhZGV2KTsNCj4gIH0NCj4gQEAgLTI4OCw2ICsyOTYsMTAgQEAgc3RhdGljIHZvaWQN
Cj4gdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAJaWYgKHJzbXVfdW1jX2luZGV4X3N0YXRlKQ0KPiAgCQl1bWNfdjZfMV9kaXNh
YmxlX3VtY19pbmRleF9tb2RlKGFkZXYpOw0KPiANCj4gKwlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0FSQ1RVUlVTKSAmJg0KPiArCQlhbWRncHVfZHBtX3NldF9kZl9jc3RhdGUoYWRldiwg
REZfQ1NUQVRFX0RJU0FMTE9XKSkNCj4gKwkJRFJNX1dBUk4oIkZhaWwgdG8gZGlzYWJsZSBERi1D
c3RhdGUuXG4iKTsNCj4gKw0KPiAgCUxPT1BfVU1DX0lOU1RfQU5EX0NIKHVtY19pbnN0LCBjaF9p
bnN0KSB7DQo+ICAJCXVtY19yZWdfb2Zmc2V0ID0gZ2V0X3VtY182X3JlZ19vZmZzZXQoYWRldiwN
Cj4gIAkJCQkJCSAgICAgIHVtY19pbnN0LA0KPiBAQCAtMzAwLDYgKzMxMiwxMCBAQCBzdGF0aWMg
dm9pZA0KPiB1bWNfdjZfMV9xdWVyeV9yYXNfZXJyb3JfYWRkcmVzcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4gIAkJCQkJICAgICB1bWNfaW5zdCk7DQo+ICAJfQ0KPiANCj4gKwlpZiAo
KGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSAmJg0KPiArCQlhbWRncHVfZHBtX3Nl
dF9kZl9jc3RhdGUoYWRldiwgREZfQ1NUQVRFX0FMTE9XKSkNCj4gKwkJRFJNX1dBUk4oIkZhaWwg
dG8gZW5hYmxlIERGLUNzdGF0ZVxuIik7DQo+ICsNCj4gIAlpZiAocnNtdV91bWNfaW5kZXhfc3Rh
dGUpDQo+ICAJCXVtY192Nl8xX2VuYWJsZV91bWNfaW5kZXhfbW9kZShhZGV2KTsNCj4gIH0NCj4g
LS0NCj4gMi4xNy4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
