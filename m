Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C7C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 11:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EC7217F4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 11:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X0HGeKWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC7217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69336E5C8;
	Fri, 14 Feb 2020 11:50:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BAF6E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 11:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+PCSoPoFuAlsV+ZGzFb3DtzEfxlKhTNnvc6ARF/CU2xyk3oGuu1h5eAKCP4WrEWV0qnS2uNDl+5GyH7p4Ip+xI4cx2+AuTL5XV5xeA5ICk+SfOWKXwcS+dTaCDANLi0uJVxmofLBgyBie3jPMeY+ZMXCOsxlnWoU5o1oIU2hc5o3U+DKCs5uUJmHHD8th0hu7E/1++SBSZIlwF6utYHTtmyn3vGkViYY/sgx2hhdVY8dm2F0PpGLoLjDaH1S61ZoKS1Czc4hUs+I6rn10pUMRCGtWGafP6RDZHmGbc9dFR+vjQa6NYg8u4XYvqWwY9AmKWcClBO32BUBppsWew+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFwGk6/TxqaSGpcGDeUMKftsBe0ddXe+R2MWMKKvr+A=;
 b=KJuZg0z4cC3qG26j4jVUJJ5UneNrzX2pFv1chZLFlgnBjLuUTS1X7uED0TAb5faPHU5qkwBjWAWtvJfxwWJxelLacWIMh12SAc8GYnS6YkD429wtKa0FsJHoceELtQrwJSjEXq3Adjv5SWaP2/DPp8rrG26iEJ9x6Ux8CXU1SijoYoGBZsMC0ttWCAn61Gghvm8OUF59ol0u4Xof/1L3S8jZzWDtlB06s0FmuKaaIvhkP1t307NzXlsAzekHkpz+J36i0XHqczJ+jqG9d964V0ebaPQI4HyjNjctpNC8hX/1PrjxBiFsMpPp34WLuZEnMukANzVlWe6Fz0dfFWPj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFwGk6/TxqaSGpcGDeUMKftsBe0ddXe+R2MWMKKvr+A=;
 b=X0HGeKWYka49F9s5ce8tvZjPs+ZhUH/LQtvQ8qbpDLTKaii2HncezgdSIfmdprpAH7C5MpWA7F+iO8ca/PRSFiPXF/OwWbdLpoG07f+9cuvoV5tn9+ft9CLer+DHnoagAkvSSiRKetTuEl/TWPbbub8NwW7aZHqxli/z137cS1U=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB4279.namprd12.prod.outlook.com (20.180.16.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 11:50:32 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 11:50:31 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add sysfs interface to set arbitrary sclk
 value for navi14
Thread-Topic: [PATCH] drm/amdgpu: add sysfs interface to set arbitrary sclk
 value for navi14
Thread-Index: AQHV4yqBXPardEetukO5wnzUG+wzhqgak22Q
Date: Fri, 14 Feb 2020 11:50:31 +0000
Message-ID: <CH2PR12MB376793705D7EE5D0EAF3CBDEFE150@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <1581679952-16214-1-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1581679952-16214-1-git-send-email-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-14T11:50:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=38c3993c-436e-4b23-ad2c-00003e43386e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-14T11:50:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ee3e2a8b-f16b-45ce-820e-000071e88799
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0acdad23-54f9-4267-369d-08d7b144184f
x-ms-traffictypediagnostic: CH2PR12MB4279:|CH2PR12MB4279:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB427991A9DA00EEE6BD76A7EDFE150@CH2PR12MB4279.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(33656002)(4326008)(53546011)(81166006)(81156014)(2906002)(8676002)(8936002)(186003)(6506007)(7696005)(71200400001)(26005)(86362001)(478600001)(55016002)(110136005)(316002)(9686003)(54906003)(52536014)(66446008)(66946007)(66476007)(64756008)(66556008)(76116006)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4279;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RlcLHOS7kqQ90h5hEk8u0k7Rwe5OnUja7WKyXm5/gay9HgHn+YuGuXUlE5CEfJDb9a/3DIZlFdIQ6lketpeLy4yRv+JD90/v1LQe22CySC9AlJ3tSflOgrwqlZRTsrblwghiFRAuMIgpjgFkn83RA9aBnnj4U1d3HVNXqqTTkgPObJtvzYtU50/jjQGFtOVPrDN51pXsjoTKhcbsrrmhA/KgsKEQi2aEU80MHkxGa+LwG5IjX87KN314auCeadvTLt95FtJtlqFEYFDloKtPpwcOLwZtI4FFCSYXUn5+xG5V69lC8mPR2hG9hJZgGw5+ZmJzElQLrWdqdXUK7LbeIlnjrq+cCmt2BwkfDg9xtmoigbwWxXStDZFdcgCX7Y8rKo1+R9z1+48A/xMM5WfISAPvMtJrEDCwMCAx2n9zmA2jmu8yhabOkRfKKIbyzZb
x-ms-exchange-antispam-messagedata: tC5vMoq1/9G3Qz3k4+OnLVa2oYYxHzlver1lE8gh4etfF9lSYLUgCvjGySMqaeluAvloKvanEJ9XQvwd5eiTL5pzAjtgkmsSRtHds0fF8VMvhY+T793mbHYsxVcSq2KLDh37NGDovCtSGUbCt9B7aw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acdad23-54f9-4267-369d-08d7b144184f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:50:31.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0dSGwgf0yLm1+m21hv2bSvOo5vjlMvYrN0THg5+/NVIj9gg0qmvCYcLNOOzQZ6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGVuZ21pbmcgR3VpIDxKYWNrLkd1aUBhbWQuY29t
PiANClNlbnQ6IDIwMjDE6jLUwjE0yNUgMTk6MzMNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KQ2M6IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgRmVuZywgS2VubmV0
aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47
IEd1aSwgSmFjayA8SmFjay5HdWlAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogYWRkIHN5c2ZzIGludGVyZmFjZSB0byBzZXQgYXJiaXRyYXJ5IHNjbGsgdmFsdWUgZm9yIG5h
dmkxNA0KDQpBZGQgc3lzZnMgaW50ZXJmYWNlIGZvciBhcmJpdHJhcnkgY2xvY2sgc2V0dGluZyBw
cF9zY2xrIC0gYW1kZ3B1X3NldF9wcF9zY2xrDQoNClNpZ25lZC1vZmYtYnk6IENoZW5nbWluZyBH
dWkgPEphY2suR3VpQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYyAgICB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8ICA5ICsrKysrLS0NCiAyIGZp
bGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQppbmRleCBiMDNiMWViLi5lMzJhMWUxIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQpAQCAtMTAzNiw2ICsxMDM2LDQw
IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9yZWFkX21hc2soY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QgY291bnQsIHVpbnQzMl90ICptYXNrKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIHNz
aXplX3QgYW1kZ3B1X3NldF9wcF9zY2xrKHN0cnVjdCBkZXZpY2UgKmRldiwNCisJCXN0cnVjdCBk
ZXZpY2VfYXR0cmlidXRlICphdHRyLA0KKwkJY29uc3QgY2hhciAqYnVmLA0KKwkJc2l6ZV90IGNv
dW50KQ0KK3sNCisJc3RydWN0IGRybV9kZXZpY2UgKmRkZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZGV2LT5kZXZfcHJpdmF0ZTsNCisJ
aW50IHJldDsNCisJdWludDMyX3QgdmFsdWU7DQorDQorCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikgJiYgIWFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikpDQorCQlyZXR1cm4gLUVJTlZB
TDsNCisNCisJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhkZGV2LT5kZXYpOw0KKwlpZiAocmV0
IDwgMCkNCisJCXJldHVybiByZXQ7DQorDQorCXJldCA9IGtzdHJ0b3UzMihidWYsIDAsICZ2YWx1
ZSk7DQorCWlmIChyZXQgPCAwKQ0KKwkJcmV0dXJuIHJldDsNCisJaWYgKGlzX3N1cHBvcnRfc3df
c211KGFkZXYpKQ0KKwkJcmV0ID0gc211X3NldF9zb2Z0X2ZyZXFfcmFuZ2UoJmFkZXYtPnNtdSwg
U01VX1NDTEssIHZhbHVlLCB2YWx1ZSk7DQorCWVsc2UNCisJCXJldHVybiAwOw0KKw0KKwlwbV9y
dW50aW1lX21hcmtfbGFzdF9idXN5KGRkZXYtPmRldik7DQorCXBtX3J1bnRpbWVfcHV0X2F1dG9z
dXNwZW5kKGRkZXYtPmRldik7DQorDQorCWlmIChyZXQpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisN
CisJcmV0dXJuIGNvdW50Ow0KK30NCisNCiBzdGF0aWMgc3NpemVfdCBhbWRncHVfc2V0X3BwX2Rw
bV9zY2xrKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLA0KIAkJY29uc3QgY2hhciAqYnVmLA0KQEAgLTE3OTcsNiArMTgzMSw4IEBAIHN0YXRpYyBE
RVZJQ0VfQVRUUihwcF9mb3JjZV9zdGF0ZSwgU19JUlVHTyB8IFNfSVdVU1IsICBzdGF0aWMgREVW
SUNFX0FUVFIocHBfdGFibGUsIFNfSVJVR08gfCBTX0lXVVNSLA0KIAkJYW1kZ3B1X2dldF9wcF90
YWJsZSwNCiAJCWFtZGdwdV9zZXRfcHBfdGFibGUpOw0KK3N0YXRpYyBERVZJQ0VfQVRUUihwcF9z
Y2xrLCBTX0lXVVNSLA0KKwkJTlVMTCwgYW1kZ3B1X3NldF9wcF9zY2xrKTsNCiBzdGF0aWMgREVW
SUNFX0FUVFIocHBfZHBtX3NjbGssIFNfSVJVR08gfCBTX0lXVVNSLA0KIAkJYW1kZ3B1X2dldF9w
cF9kcG1fc2NsaywNCiAJCWFtZGdwdV9zZXRfcHBfZHBtX3NjbGspOw0KQEAgLTMyODgsNiArMzMy
NCwxMiBAQCBpbnQgYW1kZ3B1X3BtX3N5c2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQorCXJldCA9IGRldmljZV9jcmVhdGVfZmlsZShh
ZGV2LT5kZXYsICZkZXZfYXR0cl9wcF9zY2xrKTsNCisJaWYgKHJldCkgew0KKwkJRFJNX0VSUk9S
KCJmYWlsZWQgdG8gY3JlYXRlIGRldmljZSBmaWxlIHBwX3NjbGtcbiIpOw0KKwkJcmV0dXJuIHJl
dDsNCisJfQ0KKw0KIAlyZXQgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0
dHJfcHBfZHBtX3NjbGspOw0KIAlpZiAocmV0KSB7DQogCQlEUk1fRVJST1IoImZhaWxlZCB0byBj
cmVhdGUgZGV2aWNlIGZpbGUgcHBfZHBtX3NjbGtcbiIpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVfdjExXzAuYw0KaW5kZXggYjA2YzA1Ny4uOWQxNWFjZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KQEAgLTE3OTksMTIgKzE3OTksMTcg
QEAgaW50IHNtdV92MTFfMF9zZXRfc29mdF9mcmVxX2xpbWl0ZWRfcmFuZ2Uoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsIGVudW0gc211X2Nsa18gIHsNCiAJaW50IHJldCA9IDAsIGNsa19pZCA9IDA7
DQogCXVpbnQzMl90IHBhcmFtOw0KKwl1aW50MzJfdCBtaW5fZnJlcSwgbWF4X2ZyZXE7DQogDQog
CWNsa19pZCA9IHNtdV9jbGtfZ2V0X2luZGV4KHNtdSwgY2xrX3R5cGUpOw0KIAlpZiAoY2xrX2lk
IDwgMCkNCiAJCXJldHVybiBjbGtfaWQ7DQogDQotCWlmIChtYXggPiAwKSB7DQorCXJldCA9IHNt
dV9nZXRfZHBtX2ZyZXFfcmFuZ2Uoc211LCBjbGtfdHlwZSwgJm1pbl9mcmVxLCAmbWF4X2ZyZXEs
IHRydWUpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJaWYgKG1heCA+IDAgJiYg
bWF4IDw9ICBtYXhfZnJlcSkgew0KIAkJcGFyYW0gPSAodWludDMyX3QpKChjbGtfaWQgPDwgMTYp
IHwgKG1heCAmIDB4ZmZmZikpOw0KIAkJcmV0ID0gc211X3NlbmRfc21jX21zZ193aXRoX3BhcmFt
KHNtdSwgU01VX01TR19TZXRTb2Z0TWF4QnlGcmVxLA0KIAkJCQkJCSAgcGFyYW0pOw0KQEAgLTE4
MTIsNyArMTgxNyw3IEBAIGludCBzbXVfdjExXzBfc2V0X3NvZnRfZnJlcV9saW1pdGVkX3Jhbmdl
KHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9jbGtfDQogCQkJcmV0dXJuIHJldDsN
CiAJfQ0KIA0KLQlpZiAobWluID4gMCkgew0KKwlpZiAobWluID4gMCAmJiBtaW4gPj0gbWluX2Zy
ZXEpIHsNCiAJCXBhcmFtID0gKHVpbnQzMl90KSgoY2xrX2lkIDw8IDE2KSB8IChtaW4gJiAweGZm
ZmYpKTsNCiAJCXJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0df
U2V0U29mdE1pbkJ5RnJlcSwNCiAJCQkJCQkgIHBhcmFtKTsNCi0tDQoyLjcuNA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
