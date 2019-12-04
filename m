Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4A8C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 16:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C47206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 16:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C47206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E1E6E929;
	Wed,  4 Dec 2019 16:23:45 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763056E929
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 16:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARBS9nuSEVsIWS4aI2YrwOHInV1PlyVmSwoskVYanSLLJs9bxvvLK+dhaK0R28+kZ0v6TMui3kHdZ3YQQVM36r94uWeiYywTEHNTYedS5Zpej4F8iz7P2WCY/f4142lLH6dugHDOoi2QhtVN3tyaJdhHjBFccWvAvYYUBkehfC8UIeDhTCwHvUMW8j7WfLagc2pOkof6jJt86xLBFAt6CoI29ABqqHWiRRo9fKbFWDVEmiuu57WbyySJZxQ7YUXqa/gWbAZFftADxqZD30S4qOYzZImwZbLH9+21L+KKxitB0MXjx4I16vgWC4kghg1rPAf0k29ENSoQ1EzEUWBI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfCP/77tfI7Ax0tdRfGv9XkcbX1ULniYQZTUkHJmfS0=;
 b=SOxS0ygf5uOXjgrf62+BS0nnBa7Um/anoscYeS+meqAdYWfO29bSko9RxiIZa0z+6VBrr545DQA3UUEUbn5/X1iamBmCLcr7S3KY6IiDjOyknRP1de90CvRWODN8QPRuuf7+lDRR8PPPByJuWb7k4QDuHH9tkOsrN/stX6GmHN8H3nYEtduvH9wpJzYoDT+eHShuY0qSskCNMUs2vHkssHjfCwiTgPuYLhSrmhSFfUMOF38U5eLckOtxJU6CeOpCUNKJhlquT3NWtmpS4bdzhTl23ivd9c+45pP6fiKJeKIwqJIxvfBJVd2z1XeXPHv+rmq6n/6rfTWi/qVdnns8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2354.namprd12.prod.outlook.com (52.132.30.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Wed, 4 Dec 2019 16:23:41 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 16:23:41 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: explicitely sync to VM updates
Thread-Topic: [PATCH 2/3] drm/amdgpu: explicitely sync to VM updates
Thread-Index: AQHVqrjmJ0iJTbNxREybxDT7xEXv1aeqJ8Ng
Date: Wed, 4 Dec 2019 16:23:40 +0000
Message-ID: <BL0PR12MB2580AB6E2C0353693A1DD08A805D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191204153822.2199-1-christian.koenig@amd.com>
 <20191204153822.2199-2-christian.koenig@amd.com>
In-Reply-To: <20191204153822.2199-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-04T16:23:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ba9db1d3-efb7-46bb-9911-0000ff563e66;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-04T16:23:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 942efcd7-924f-4603-be32-00000f60991a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d149583-5dff-401d-43ea-08d778d65372
x-ms-traffictypediagnostic: BL0PR12MB2354:|BL0PR12MB2354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2354CD7E99CD43735512D0CA805D0@BL0PR12MB2354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(13464003)(189003)(199004)(14454004)(2906002)(76176011)(7696005)(966005)(74316002)(186003)(478600001)(26005)(229853002)(6436002)(55016002)(53546011)(6506007)(9686003)(6246003)(6306002)(102836004)(14444005)(3846002)(6116002)(316002)(110136005)(99286004)(86362001)(2501003)(45080400002)(25786009)(66574012)(33656002)(81156014)(8676002)(6636002)(7736002)(15650500001)(8936002)(64756008)(66476007)(66446008)(5660300002)(66556008)(66946007)(52536014)(11346002)(305945005)(76116006)(71200400001)(71190400001)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2354;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /AUi0pR9xtdwg7AqKw1wAkABQmhyyQOuIAwnjo03+sVr5I4d/eawyFiYF6I/ejeGwcd0gsvz21NcAk7g1zLEP2/6Gi4r3nmJsniNtfn5w28kF7pgqtZGOTwbWqGr7vMINeuiNMvy4KUy11ugJAHzdNMU85sRhA3BHImft+Ehsuy1DOr49p+7DNeKhsR8T7HRsXxajCOdHp8aQcgOq715Ue/n+i4xAP9JXt3sIB2W3XhCufnMG3qpYHHY6OOfGxTwI5PsIRcQmPAuXf5iD1NU5WOvh1qFGigVOzuHefKRAuI3E2PABSMgn9K3lwdKl6gwF9ORBxJtZpQpENKnOMfUI2Z2xDWb6zesxy9IkMki1HS6sBvDn2M6g91Q2Zwt41c8EG/rSXdcwPvoVRU/KuVSoTT5yQEU25Jgxk2KKYh0YCXyvyE4eZ2OhJlfoAFbNgtaZ+O4SABKdkL9sZxU6+RQumweVCUxpR96JFM4vxjUxiYqh3HH3W2BodtNxKNSG6Pnu+vxd/vTtQSfOoAIcyb3s3kEKmrQliZXsAuhz5Mf98I=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d149583-5dff-401d-43ea-08d778d65372
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 16:23:41.1768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cc//n22O1IX90BS4FVRh9QUQg0h9VdyYp5wGzZSTQLCrN/ARv3jx8nbjpzvoj6Uw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfCP/77tfI7Ax0tdRfGv9XkcbX1ULniYQZTUkHJmfS0=;
 b=cBwzSCL14JkTxzRb3MuUtBN3CFLR9BwMchm9YQ2nQWWb+8547SU98FOd4n0P75pI4XmGTGrMnHIJ00szWNV+6IlgRwuUM0enRlRR0bcKbgV2lAfIxupe2Kx58VmZYKlT8U/LtlhEJN4JbNYPqYROn/dJYr3N5dxN1S2eu9A1PRE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmVnYXJkcywNCk9haw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgNCwgMjAxOSAxMDoz
OCBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5j
b20+DQpTdWJqZWN0OiBbUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiBleHBsaWNpdGVseSBzeW5jIHRv
IFZNIHVwZGF0ZXMNCg0KQWxsb3dzIHVzIHRvIHJlZHVjZSB0aGUgb3ZlcmhlYWQgd2hpbGUgc3lu
Y2luZyB0byBmZW5jZXMgYSBiaXQuDQoNClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jcy5jICAgfCAxOCArKysrKysrLS0tLS0tLS0tLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLSAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuaCB8ICAyICsrDQogMyBmaWxl
cyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCmluZGV4IDllMGM5OTc2MDM2Ny4uZjIxNDc1MzUy
Yjg4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQpAQCAtNzk5LDI5
ICs3OTksMjUgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfdm1faGFuZGxpbmcoc3RydWN0IGFtZGdw
dV9jc19wYXJzZXIgKnApDQogCWlmIChyKQ0KIAkJcmV0dXJuIHI7DQogDQotCXIgPSBhbWRncHVf
c3luY19mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLA0KLQkJCSAgICAgIGZwcml2LT5wcnRfdmEt
Pmxhc3RfcHRfdXBkYXRlLCBmYWxzZSk7DQorCXIgPSBhbWRncHVfc3luY192bV9mZW5jZShhZGV2
LCAmcC0+am9iLT5zeW5jLA0KKwkJCQkgZnByaXYtPnBydF92YS0+bGFzdF9wdF91cGRhdGUpOw0K
IAlpZiAocikNCiAJCXJldHVybiByOw0KIA0KIAlpZiAoYW1kZ3B1X21jYnAgfHwgYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKSB7DQotCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmOw0KLQ0KIAkJYm9fdmEgPSBm
cHJpdi0+Y3NhX3ZhOw0KIAkJQlVHX09OKCFib192YSk7DQogCQlyID0gYW1kZ3B1X3ZtX2JvX3Vw
ZGF0ZShhZGV2LCBib192YSwgZmFsc2UpOw0KIAkJaWYgKHIpDQogCQkJcmV0dXJuIHI7DQogDQot
CQlmID0gYm9fdmEtPmxhc3RfcHRfdXBkYXRlOw0KLQkJciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFk
ZXYsICZwLT5qb2ItPnN5bmMsIGYsIGZhbHNlKTsNCisJCXIgPSBhbWRncHVfc3luY192bV9mZW5j
ZShhZGV2LCAmcC0+am9iLT5zeW5jLA0KKwkJCQkJIGJvX3ZhLT5sYXN0X3B0X3VwZGF0ZSk7DQog
CQlpZiAocikNCiAJCQlyZXR1cm4gcjsNCiAJfQ0KIA0KIAlhbWRncHVfYm9fbGlzdF9mb3JfZWFj
aF9lbnRyeShlLCBwLT5ib19saXN0KSB7DQotCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmOw0KLQ0KIAkJ
LyogaWdub3JlIGR1cGxpY2F0ZXMgKi8NCiAJCWJvID0gdHRtX3RvX2FtZGdwdV9ibyhlLT50di5i
byk7DQogCQlpZiAoIWJvKQ0KQEAgLTgzNSw4ICs4MzEsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9j
c192bV9oYW5kbGluZyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCkNCiAJCWlmIChyKQ0KIAkJ
CXJldHVybiByOw0KIA0KLQkJZiA9IGJvX3ZhLT5sYXN0X3B0X3VwZGF0ZTsNCi0JCXIgPSBhbWRn
cHVfc3luY19mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLCBmLCBmYWxzZSk7DQorCQlyID0gYW1k
Z3B1X3N5bmNfdm1fZmVuY2UoYWRldiwgJnAtPmpvYi0+c3luYywNCisJCQkJCSBib192YS0+bGFz
dF9wdF91cGRhdGUpOw0KIAkJaWYgKHIpDQogCQkJcmV0dXJuIHI7DQogCX0NCkBAIC04NDksNyAr
ODQ1LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfdm1faGFuZGxpbmcoc3RydWN0IGFtZGdwdV9j
c19wYXJzZXIgKnApDQogCWlmIChyKQ0KIAkJcmV0dXJuIHI7DQogDQotCXIgPSBhbWRncHVfc3lu
Y19mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLCB2bS0+bGFzdF91cGRhdGUsIGZhbHNlKTsNCisJ
ciA9IGFtZGdwdV9zeW5jX3ZtX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMsIHZtLT5sYXN0X3Vw
ZGF0ZSk7DQogCWlmIChyKQ0KIAkJcmV0dXJuIHI7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9zeW5jLmMNCmluZGV4IDk1ZTVlOTNlZGQxOC4uOWIyOGMxZWI1ZjQ5IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KQEAgLTE2MSw5ICsxNjEs
NiBAQCBpbnQgYW1kZ3B1X3N5bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0
cnVjdCBhbWRncHVfc3luYyAqc3luYywNCiANCiAJaWYgKCFmKQ0KIAkJcmV0dXJuIDA7DQotCWlm
IChhbWRncHVfc3luY19zYW1lX2RldihhZGV2LCBmKSAmJg0KLQkgICAgYW1kZ3B1X3N5bmNfZ2V0
X293bmVyKGYpID09IEFNREdQVV9GRU5DRV9PV05FUl9WTSkNCi0JCWFtZGdwdV9zeW5jX2tlZXBf
bGF0ZXIoJnN5bmMtPmxhc3Rfdm1fdXBkYXRlLCBmKTsNCiANCiAJaWYgKGFtZGdwdV9zeW5jX2Fk
ZF9sYXRlcihzeW5jLCBmLCBleHBsaWNpdCkpDQogCQlyZXR1cm4gMDsNCkBAIC0xNzksNiArMTc2
LDI1IEBAIGludCBhbWRncHVfc3luY19mZW5jZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
c3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLA0KIAlyZXR1cm4gMDsNCiB9DQogDQorLyoqDQorICog
YW1kZ3B1X3N5bmNfdm1fZmVuY2UgLSByZW1lbWJlciB0byBzeW5jIHRvIHRoaXMgVk0gZmVuY2UN
CisgKg0KKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlDQorICogQHN5bmM6IHN5bmMgb2JqZWN0IHRv
IGFkZCBmZW5jZSB0bw0KKyAqIEBmZW5jZTogdGhlIFZNIGZlbmNlIHRvIGFkZA0KKyAqDQorICog
QWRkIHRoZSBmZW5jZSB0byB0aGUgc3luYyBvYmplY3QgYW5kIHJlbWVtYmVyIGl0IGFzIFZNIHVw
ZGF0ZS4NCisgKi8NCitpbnQgYW1kZ3B1X3N5bmNfdm1fZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCisJCQkgc3RydWN0IGRtYV9mZW5j
ZSAqZmVuY2UpDQorew0KKwlpZiAoIWZlbmNlKQ0KKwkJcmV0dXJuIDA7DQorDQorCWFtZGdwdV9z
eW5jX2tlZXBfbGF0ZXIoJnN5bmMtPmxhc3Rfdm1fdXBkYXRlLCBmZW5jZSk7DQorCXJldHVybiBh
bWRncHVfc3luY19mZW5jZShhZGV2LCBzeW5jLCBmZW5jZSwgZmFsc2UpOyB9DQpJcyB0aGVyZSBh
Y3R1YWwgZnVuY3Rpb25hbCBjaGFuZ2U/IEkgc2F3IHlvdSByZS1vcmdhbml6ZWQgdGhlIGNvZGVz
IGEgbGl0dGxlIGJ5IGludHJvZHVjaW5nICB0aGUgYW1kZ3B1X3N5bmNfdm1fZmVuY2UgZnVuY3Rp
b24uIEJ1dCB3aGVuIHlvdSBhZGQgZmVuY2UgdG8gc3luYyBvYmosIHRoZSBleHBsaWNpdCBwYXJh
bWV0ZXIgaXMgc3RpbGwgZmFsc2UsIGp1c3QgdGhlIHNhbWUgYXMgYmVmb3JlLiBGcm9tIHRoZSB0
aXRsZSBvZiB0aGUgY2hhbmdlLCB5b3Ugc2FpZCBleHBsaWNpdGx5IHN5bmMgdG8gdm0gdXBkYXRl
IC0gZGlkIHlvdSBtZWFuICJ0cnVlIiBoZXJlIGZvciB0aGUgbGFzdCBwYXJhbWV0ZXI/DQorDQog
LyoqDQogICogYW1kZ3B1X3N5bmNfcmVzdiAtIHN5bmMgdG8gYSByZXNlcnZhdGlvbiBvYmplY3QN
CiAgKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5j
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5oDQppbmRleCBiNWYx
Nzc4YTIzMTkuLmFjMjEwZGQzNDM3MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zeW5jLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9zeW5jLmgNCkBAIC00Miw2ICs0Miw4IEBAIHN0cnVjdCBhbWRncHVfc3luYyB7DQogdm9p
ZCBhbWRncHVfc3luY19jcmVhdGUoc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jKTsgIGludCBhbWRn
cHVfc3luY19mZW5jZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9z
eW5jICpzeW5jLA0KIAkJICAgICAgc3RydWN0IGRtYV9mZW5jZSAqZiwgYm9vbCBleHBsaWNpdCk7
DQoraW50IGFtZGdwdV9zeW5jX3ZtX2ZlbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsDQorCQkJIHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlKTsN
CiBpbnQgYW1kZ3B1X3N5bmNfcmVzdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCSAg
ICAgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLA0KIAkJICAgICBzdHJ1Y3QgZG1hX3Jlc3YgKnJl
c3YsDQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q29hay56ZW5nJTQwYW1kLmNvbSU3QzI1NTFk
MTJiMjg1OTRmZTU3ZWNjMDhkNzc4ZDAwNTA4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzExMDcwNzE4OTQyODI3MCZhbXA7c2RhdGE9cXElMkJja2hKdlll
TTN5JTJGR3VSV3hpUkowUGZsamR6UFdvaWVxbWQzY0FwMTQlM0QmYW1wO3Jlc2VydmVkPTANCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
