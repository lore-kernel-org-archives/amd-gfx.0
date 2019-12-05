Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F5C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C74120707
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C74120707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69436F910;
	Thu,  5 Dec 2019 22:10:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DA06F910
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 22:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN/y0w5RBEISxH7qUJMx2IuIyAnzeZBCq0Btc8SxgjIHx/CD7tlgjvfjwTl2FZ1TjHgcc7uqca4vhHrCvfR93YQl4rLbx65AyTqt4nUFZKxA8i7s+NwRX62DxwUPuR7Om5ZjmiLq9Fft0l7UaeDdaaR2FrkjriTKjh6opTqgKL4ZwFIZhN342pA2GISCT4d6oNIGMC/fGM8CDj6B8T53RunFomVyuPV7nbkIz2lZLdCGMpK4I9wpDEPmkePSyKwvmYL8DzczpPQZV0VzaqrqIYhXKht37ZqDoex6JRu39STw9jADVbu4tsGc0IO87EAAmJspt6cZg9yIjPWZGZVssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F8/HE7aPAOz/252Utkl5+jvHzL7Tz0JmfifNql6+lM=;
 b=UQSKR30J1/t/sjVZdMxvRrYxod8dTV/MlNelOOlCbX20hMMMpOBlRTuo4SOiBrMvu0/Ov+wxDTvsU64ngpBv+Q8+UCijigNU+PyacSgn2a/V3QhHIurI4cgnaYy2g1hNSRJ+p/yrKAH1TNNPMaOUIO3mRE8RLuuz/CLVz8+UjCOAtZMB+Kw+fapWQAhWtpnz+XBYnNrvjo79S/hv6qn+i3k5a61I5Qdt0OVfQiPu1a3UMNnTSsTtegcJfGgIuvkcqt7eRoI5J/wD5AkrvL0AMEvczERAY2fIzJn8rqQkbM7x8GkSz3x6YOKx6vdmN4Zk6/dGYaEAVcYsrW+O3wJlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4281.namprd12.prod.outlook.com (10.141.187.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 22:10:09 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 22:10:09 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: add fallthrough comment
Thread-Topic: [PATCH] drm/amdgpu/display: add fallthrough comment
Thread-Index: AQHVq7SYFVeUqb3bUEqWQOVaRjBN26esGcQg
Date: Thu, 5 Dec 2019 22:10:09 +0000
Message-ID: <DM6PR12MB3466EA1AD3EB09CE509900B19E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191205213904.278244-1-alexander.deucher@amd.com>
In-Reply-To: <20191205213904.278244-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eb79f17-22ea-44e6-06c5-08d779cfe4ab
x-ms-traffictypediagnostic: DM6PR12MB4281:|DM6PR12MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42811C22C8394839906AF9869E5C0@DM6PR12MB4281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(13464003)(189003)(199004)(316002)(102836004)(76176011)(86362001)(110136005)(7696005)(81166006)(81156014)(55016002)(8676002)(8936002)(6506007)(25786009)(99286004)(33656002)(305945005)(53546011)(14444005)(11346002)(74316002)(76116006)(4326008)(9686003)(26005)(2906002)(45080400002)(66556008)(52536014)(478600001)(186003)(14454004)(5660300002)(966005)(66446008)(66476007)(64756008)(71200400001)(229853002)(66946007)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4281;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: neASKyAMRs4/X3sMiKj7tUDkKdmzQ3J8JdmbaUlD2U02/KuK4faOAgaeX6eMEN6tBcJ1RdQO5pridTB2JOgSTnJZ3pTKrS85GXGyxTFRH+QW9GzoZLM+Iyg7q5LV5t02DVIoZYnFqld++jNbgNeSbr85tWZbUQMODQhgeRo/LbWhY0q1V1C+rhKl5iVrYQQ2nhSzO/EKa8eH072o0bX9OSTbf/NZa9KSngKg7L0c9a7qLeWwxl8M9/bhZS+WXyCrUjLqEUcy9Vypb+EhpSt4A4qSPdJ+YhRS9YyNlJbcewiCWgzAGnSORtu1Ib3LLsvmgHGtr5WJ2zBe+3Nbr55x/A6Ls0extcPqg6gd6qKOqUBJYSs1o0SR1tXWsPKWn+JMOg7SJmbZqctbrPDJdN3bmod6mRNcnkJWbNvyRo1jYDkejYpYX2f06QBYnOlX1+6X880mV+zQ3ZJtfybv/GrAw/Tn1u0eIZPNJVidG/0Tl3XHvE61r+cqMulewLInlBKN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb79f17-22ea-44e6-06c5-08d779cfe4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 22:10:09.6929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cdi5/lekwwnVfomlVhP00/u50n1FMuAw3dT+wmOcfjA0KhQlGHiS22rSO2XzrCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F8/HE7aPAOz/252Utkl5+jvHzL7Tz0JmfifNql6+lM=;
 b=m+xC8wEeDIz/VbuPGCqPzeTm4AuTQlogBTBF0NfYsB00ebSdWU/JwbwDH/5pPA/ZmbsBf3aLFPH1B/VHjLAGQCETJ0IGtJmJ+muyrICRW9eHrIUdHQ7LJ4AigyEzDNZzSFjx0Q9JBoO4ZHFnL3idJdA9fqfJMMHN3ybER991Zr8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1
Y2hlcg0KPiBTZW50OiAyMDE5L0RlY2VtYmVyLzA1LCBUaHVyc2RheSA0OjM5IFBNDQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUv
ZGlzcGxheTogYWRkIGZhbGx0aHJvdWdoIGNvbW1lbnQNCj4gDQo+IFRvIGF2b2lkIGEgY29tcGls
ZXIgd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9hdXguYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfYXV4LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXgu
Yw0KPiBpbmRleCAxOTFiNjhiODE2M2EuLmYxYTVkMmM2YWEzNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMNCj4gQEAgLTY0NSw2ICs2NDUs
NyBAQCBib29sIGRjZV9hdXhfdHJhbnNmZXJfd2l0aF9yZXRyaWVzKHN0cnVjdA0KPiBkZGNfc2Vy
dmljZSAqZGRjLA0KPiAgCQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfQVVYX0RFRkVSOg0K
PiAgCQkJY2FzZQ0KPiBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfSTJDX09WRVJfQVVYX0RFRkVSOg0K
PiAgCQkJCXJldHJ5X29uX2RlZmVyID0gdHJ1ZTsNCj4gKwkJCQkvKiBmYWxsIHRocm91Z2ggKi8N
Cg0KSSBhbSBhIGJpdCBjb25mdXNpbmcgaGVyZS4gV2h5IGEgY29tbWVudCBjYW4gYXZvaWQgYSBj
b21waWxlciB3YXJuaW5nPw0KDQo+ICAJCQljYXNlDQo+IEFVWF9UUkFOU0FDVElPTl9SRVBMWV9J
MkNfT1ZFUl9BVVhfTkFDSzoNCj4gIAkJCQlpZiAoKythdXhfZGVmZXJfcmV0cmllcyA+PQ0KPiBB
VVhfTUFYX0RFRkVSX1JFVFJJRVMpIHsNCj4gIAkJCQkJZ290byBmYWlsOw0KPiAtLQ0KPiAyLjIz
LjANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLg0KPiBmcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDemhhbi5saXUlNDBhbWQuY29tJTdD
NzdkODVhMDI3NWFhNGMwYTc4DQo+IDJmMDhkNzc5Y2I5NzE2JTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYNCj4gMzcxMTE3ODgyMDg3MDIzNDAmYW1wO3NkYXRh
PTNtJTJGdU51TklncTgyeiUyQkFlWEo5eTd3bjgxa1YlDQo+IDJGaUR0M0F5QzNDRGlUUnJjJTNE
JmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
