Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3712C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 05:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CC02075C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 05:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291E96E1BB;
	Fri,  6 Dec 2019 05:27:18 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680054.outbound.protection.outlook.com [40.107.68.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C636E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 05:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp+BG0HmCcwWdkLpvlRurrBg8MGkFgsnXyvFswZiLA1UPs9KPqjxtLufr/GE5BiZhhDSei5XF9khN/0EPAxSgnaxodkzJBq733otNvaUeChCXz54VWPL6QP24+sKzA8ay9TaUF1y36/q/0OXanO1kQkC0vZ/VKMmDGWZqq4F93Dm/dHqciGq74Na1F53iHK6baoszx0+LRM5k30zi5xGjzMgE5E7r5zNVcXJ+YChjW/CACT5qeeB25IHXRQ6P/TBwUTHlyurd7YZVVm1zSTVaZFFB/uUrFPN29PaRvy6zFMjsnOnM3Rxy4YA7jORhlySoN4epNvhJXqH8a2MvqSDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBwoSUfR2ELiasGett8/oN1G9UsFJRysRpJ9k0h3KD4=;
 b=LnE2VA5JV3O2duDz+dt0vHNUT+Ag/E0KS/ieYK9ptI24Fng9VnjMuiRcewO2Ug87qvwoeSH/lVOamozH+vLEWQs3A9PeONa1Hc8sd/ElhXoaYk26vrHM+dDwPRVEFRUzGDloXcuVQwHyEUl7EB6LKyJEBiTsD666RqI62EAaFH6bDuGSoaFUmeKThuIIDX0P8xQcDWb8eLMup0irwmRsgPLfZKe+yYYjQZ0aXdjWmLkLcL8262H+tbHIn0rwimPEARCEvmo86+NW5J82ERcQzCspW7lg+n3oklsjD1eMei43b++fLaIa+EqOkG5SyPGRCEqW6ir7nAeLN1P0dzo59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3534.namprd12.prod.outlook.com (20.179.84.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 05:27:14 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 05:27:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Topic: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Index: AQHVq+ZJE1hWgUWOaEOP8kMPy7HFC6esgQcAgAAP6JA=
Date: Fri, 6 Dec 2019 05:27:14 +0000
Message-ID: <MN2PR12MB334455F883AD2A8F4DD09AD7E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191206033543.3131-1-evan.quan@amd.com>
 <BB0A14B8-3288-4EE0-8352-162F81477E1A@amd.com>
In-Reply-To: <BB0A14B8-3288-4EE0-8352-162F81477E1A@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Zhigang.Luo@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=74d7fe04-4d38-4c0d-98d9-0000961feb3b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T05:16:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f46c4997-b05a-4b7d-dd4d-08d77a0cf3ad
x-ms-traffictypediagnostic: MN2PR12MB3534:|MN2PR12MB3534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35349D05797951730D996CC9E45F0@MN2PR12MB3534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(13464003)(6636002)(4326008)(25786009)(14454004)(966005)(478600001)(2906002)(14444005)(229853002)(9686003)(86362001)(45080400002)(305945005)(7696005)(76176011)(55016002)(74316002)(66446008)(26005)(186003)(102836004)(52536014)(33656002)(81166006)(81156014)(316002)(8676002)(8936002)(11346002)(76116006)(66476007)(5660300002)(66946007)(71190400001)(64756008)(71200400001)(66556008)(99286004)(6506007)(110136005)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3534;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQFedpGlrKDZ0dvAnzBCJWRGz0qvdXic9m5MHdHepAd0XtJhcr8MUcGIrY7bZ2x936yzU/w+GfQ2fqHaQtJK48eZnEudSZe9zyi3OMgb/tDx5yIGG9Oyhmi/6/VPf/gCO8HNNyE6Sb0DM82zC0rIuEP/B1eQqCe00WvDcHV/PmK8YQVEt1dQZnl/JYt/mwaWDhRYTSxglkdFEcZNIywYpeQ1xTjZFxUIA1YWc8vnxl0DUurGPt7shWEbYCnQD7mk1por+q1zZwsjv0RHG0yYrtM1yRmCscKpn+EzrWocZOE1HZnhPzKTod/h3OjDeK9t5DhUlNQKSEaavBbS4cgi0BIFHAwthhi3IwuXLtxJqnwhwhT1drr2MBMNwFglamRMVmQxNjMKZyMdXNJp551pFEvQBcMPO+qTgSwiDisWRs+9jywsMqdgYrF3EHcf43x7FANxxV8b0HtxW7FcDqvCk3nJLdNRBSX48nZ7ayQS1Fp6DLZd0xmSMMuS3J1MGrvsVKWOsxv2SsAneS3kSRjRpFBRWzkZ3t+WFvafn0iOfu4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46c4997-b05a-4b7d-dd4d-08d77a0cf3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 05:27:14.1319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGZrQn9lgHlgxejtvRptOhbPVgB+MRMtTyEU2+iVc4MYGA1TOnv8lgdazca7hX38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBwoSUfR2ELiasGett8/oN1G9UsFJRysRpJ9k0h3KD4=;
 b=Wj74PaxCFjf8+FbM5e+EN/CoTY8s01DyBpa2p0l4/iNm5wofcD7YtpZhcodXN8Sni9aGOp0zSHmbjguylf1cwRabFoLoZ6LkNN7ciSzy42priD1gvC2whSzGw5ylkcD3lpPz7Yupqgr5PYvK/cuy5RI33vnil+nUByjan3rYvkU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgWGlhb2ppZSwKClRoaXMgd2FzIHJlcG9ydGVkIGJ5IFpoaWdhbmcgdGVhbS4gIFVuZGVyIHRo
ZWlyIHNwZWNpYWwgdXNlIGNhc2UsIHNjcmF0Y2ggcmVnaXN0ZXIgNyBoYXMgYmUgdG8gMCB0byBw
ZXJmb3JtIGFzaWMgaW5pdChATHVvLCBaaGlnYW5nIHJpZ2h0PykuCkFuZCBjb25zaWRlcmluZyBv
bGQgYXNpY3ModmVnYTIwLzEwKSBhbHNvIGFwcGxpZWQgdGhpcyBjaGFuZ2UuClNvLCBJIHRoaW5r
IGl0J3MgcmVhc29uYWJsZShhbmQgcmVjb21tZW5kIGJ5IFNNVSBmdyB0ZWFtKSB0byBhcHBseSB0
aGlzIG9uIHRoZSBuZXcgQVNJQ3MgYWxzby4KClJlZ2FyZHMsCkV2YW4KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+IEZyb206IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29t
Pgo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNiwgMjAxOSAxMjoyMCBQTQo+IFRvOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IEx1bywgWmhpZ2FuZyA8WmhpZ2FuZy5MdW9AYW1kLmNvbT4KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kL3Bvd2VycGxheTogY2xlYXIgVkJJT1Mgc2NyYXRjaHMgb24gYmFjbyBleGl0
Cj4gCj4gSGkgRXZhbiwKPiAKPiBKdXN0IG91dCBvZiBjdXJpb3NpdHksIG1heSBJIGtub3cgd2hh
dCBpc3N1ZSBhcmUgeW91IHRyeWluZyB0byBmaXg/Cj4gSSB1c2VkIHRvIHNlZSB2YmlvcyBwb3N0
IGZhaWx1cmUgKGhhbmdzIGluIGF0b21iaW9zIGluaXQgdGFibGUpIGFmdGVyIGJhY28gZXhpdAo+
IG9jY2FzaW9uYWxseSBvbiBuYXZpLgo+IAo+IEJSLAo+IFhpYW9qaWUKPiAKPiA+IE9uIERlYyA2
LCAyMDE5LCBhdCAxMTozNyBBTSwgRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gd3JvdGU6
Cj4gPgo+ID4gVGhpcyBpcyBuZWVkZWQgZm9yIGNvbWluZyBhc2ljIGluaXQgb24gcGVyZm9ybWlu
ZyBncHUgcmVzZXQuCj4gPgo+ID4gQ2hhbmdlLUlkOiBJZjM2NzFhMjRkMjM5ZTNkMjg4NjY1ZmFk
YWEyYzQwYzg3ZDVkYTQwYgo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5A
YW1kLmNvbT4KPiA+IC0tLQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3Yx
MV8wLmMgfCA2ICsrKysrKwo+ID4gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
Ywo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiA+IGluZGV4
IDM5ZWMwNmFlZTgwOS4uYWI4MDlkZjdiYzM1IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCj4gPiBAQCAtMTY1OSw2ICsxNjU5LDEyIEBAIGludCBz
bXVfdjExXzBfYmFjb19zZXRfc3RhdGUoc3RydWN0Cj4gc211X2NvbnRleHQgKnNtdSwgZW51bSBz
bXVfYmFjb19zdGF0ZSBzdGF0ZSkKPiA+ICAgICAgICB9Cj4gPiAgICB9IGVsc2Ugewo+ID4gICAg
ICAgIHJldCA9IHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX0V4aXRCYWNvKTsKPiA+ICsg
ICAgICAgIGlmIChyZXQpCj4gPiArICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiArCj4gPiArICAg
ICAgICBXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSU9TX1NDUkFUQ0hfNiwgMCk7Cj4gPiArICAg
ICAgICBXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSU9TX1NDUkFUQ0hfNywgMCk7Cj4gPiArCj4g
PiAgICAgICAgYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJFR19TRVRfRklFTEQoYmlmX2Rvb3Ji
ZWxsX2ludHJfY250bCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgQklGX0RPT1JCRUxMX0lO
VF9DTlRMLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICBET09SQkVMTF9JTlRFUlJVUFRfRElT
QUJMRSwgMCk7Cj4gPiAtLQo+ID4gMi4yNC4wCj4gPgo+ID4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4KPiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlCj4g
ZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtCj4gZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NYaWFvamllLll1YW4lNDBhbWQuY29tJTdDNjgyYzE0MmVmMzA3NDhiYmQKPiAwMDUw
OGQ3NzlmZDZmODIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdD
NjM3Cj4gMTEyMDAyMjA4OTI3NzMzJmFtcDtzZGF0YT1iYWphYWozQ3cySXhXNW5SdWNnM0ZYVWpj
eUlpNTBrQ1NQUTdla25xawo+IDRvJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
