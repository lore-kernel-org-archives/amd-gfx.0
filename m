Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FBC4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 06:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7094D22574
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 06:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKLxiYs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7094D22574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF89389EB7;
	Tue, 22 Sep 2020 06:45:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510E689E26
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 06:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrVpU1IJvMiPndaKOJkl0syHo9bLnvdSmlnI4d5f0udyfq5dJr1XoR/CF6JpHqfkcNOgHOKj505AfnpDDrNeDlVDCf3Qo52UD1XuEZNcWLgK8fGRlKIiIjBa+/ZUB1DxYEHzP8KLSwbVldnn0JciipWNllwWuNDIRtNiB4vZfTSDJXp2pY4VOIG6TYnepzsrlKzT34p88MbTNQ2Ce5Sk1izbTm9V27qNA9yavnX8WUjY1XycfXW4OKoiU5vNgO+H5oLtLxLnRxrgRzu3pBXWEG5cIf3GDYSCnxUACRUOCFuKvcGMxQPeCzAiAqHIY4D4McVwewlYwevoTPuZMQuXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlD6PRl295OtRvtCK2Cy2K4LOgvPWsR6rzIpRkdzBc=;
 b=daDKV7UKYk5UxXBtlk1kGxLqrC1ojYgrDcNpw1duPfzTDQFo213Qy8H8dV/Q5VsrwwZOHPOhSOazJZZHiLnqg906cMS0fsGwyrmR13bM+UoehHK6RJvBJ769MncKFrqqbPnL4QwCfH1Uei8yY5CIeaZ+YJoN8aewlyfs+32i8btgvv62ra5leoPYW/5lgf2FI9lW+z2+H2jvPqQnYOTo3uwLmhcET7UR8lXVO1iWZfNYuxyLDdU6eAK3fx/1B0HqxWHxlEaMif/1Ag7lk5mPox4RDnQMFBE4UK1UyD1TuR2orTW9fhWFmVdV0/P+8v7r059gJHH0jR6jDEoXgziYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlD6PRl295OtRvtCK2Cy2K4LOgvPWsR6rzIpRkdzBc=;
 b=rKLxiYs7d2OVAAK9h9QIQSd3qMVHdea+9FxURaHU9mue5N45evu+kAE9u5rCoz1sxLNriaIEGx7N4rsS2UrfN8zfXDpIzIq8lJLScTbljiyup3j3MZGYgrY1X+W5jYeZUq55HhrLqmK6DRSOUJ9tLoXnTQ5/1wllgF/trXeT3os=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 06:44:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3391.026; Tue, 22 Sep 2020
 06:44:55 +0000
Subject: Re: [PATCH] drm/amdgpu: Add uid info to process BO list
To: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200921191803.18549-1-madhav.chauhan@amd.com>
 <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
 <BL0PR12MB2433A91BE80EF2D8DFAB85E09C3A0@BL0PR12MB2433.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9ebed42d-06f2-bbd6-f702-8e707ea1ac84@amd.com>
Date: Tue, 22 Sep 2020 08:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BL0PR12MB2433A91BE80EF2D8DFAB85E09C3A0@BL0PR12MB2433.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.8 via Frontend Transport; Tue, 22 Sep 2020 06:44:54 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a81d0e8b-fa43-4c63-905a-08d85ec30403
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2482C9E1295CA87573492F85833B0@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHGRTzJ4pmAouxMflfXXz8St5MNeLF7UsO2IUVt/b8E8M1PngivdQH1QsYnS86yAJA8Mqm9I9iii64ToVbfIvMUTn7GdJoGSrVUf4tSVD79jnr4FFrJmhR97QAXXFcM1ctLQQtuNJByYBwEqZNRh4VDb2e4vEtnnilJtvefb7QpDeKFvhlXrdZo1b3ju/+HDbyl1Wd+5JdQIQFZRjhUyTfIfEjhm6FGtfQUFuhVwOUPtqHcoFVTouhBK6JeiB0YjiwX5ufg1sYyS8vyrKiNU0vJ+mz4YtkPB+wOtAsxstg1U6bcTy80nH1zj+c3jD1tA/mzM5RY77ImtxHNy/g5ogH7zloYCLucRWq/WHSvfY4N3kEP/Y+fQ2QrDNj0S403Sxbg0/tG9EGPX5eg4jIUzXkNDsy/t72CVk4oUfKWh2vy/4ZFK9aCHCeNijFjfiRNQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(2906002)(16526019)(66556008)(54906003)(316002)(83380400001)(36756003)(8936002)(66476007)(110136005)(66574015)(66946007)(53546011)(8676002)(478600001)(6486002)(52116002)(6666004)(2616005)(186003)(31686004)(86362001)(4326008)(5660300002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xi+VznO+P7aDiGJ6p5NUywQ+bswJNdjOUKx7J03SWuEgXOJu1+hBVo2xgi4/fP3dG/EDrV5gCUSJo7hbLSnTueJXl1wafSzb7pD/P1aBzFPFYoPeSCyMFNil68q9JE4xdBVDA3FYQLm4OlKXFR4nSQ4KjQlxDEvcyDnRYbrfFV3qhHv4Qm0yf0OVmvMhviyx0sPUJOtJEKaEfwcRpyXioI7IOMa+Pjk8G4Go5S2WfolirqusuHOX3Lv9DWs+8DCaVDHQKq1zHuPveFFexgjS7reUSNs5OcK13+FGt1a+LBKvlV/YCUAPknLlefPyaeg/8keWDFfg5ZbH5hO1X488T3eOgTpj2Xt4Mg1oRIkOX/NQdDhrZ+DkgZ5K4VNnQShJpN7mNIoLv3Kviw2cEvtTNSREe+kNP2FYZXF661ftQko182pbBCOTqcMqXWpCetK+DhnvkZV0QQyC1zkZknSjX6iy+DfcCc9paKyEiwYFtbWQIFMHXR7jPWrS0WTKqQhkAws5d+uY792y0pFtlQoZio6zTnNXk7iYzy68gRRpkRVVjI27Pwd2+1H5ujKL7ZzprlFKD3fVm3t1gxeQTfH1eM3qGgBk1xkxxMTb9vNpU3byxZ+VtuWX6zRpnbGWh1ULTqLMJeIhJYk5cO142mXc0ACC+qQ1gY9F/3gMT1l8PO7QGErUC6O0MXjgjZ2OkboRiAOkojkQqyva5GbqFKEuWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d0e8b-fa43-4c63-905a-08d85ec30403
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 06:44:55.4140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kq6Zj6u/8JsRPP9i3h+RemH2q90TiA33Qr7aD3d/7utdUTcJMflgfMvCQm8oMiQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>, "Patel, Mihir" <Mihir.Patel@amd.com>,
 "Saleem, Athar" <Athar.Saleem@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDkuMjAgdW0gMjE6NTUgc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6Cj4gW0FNRCBQdWJs
aWMgVXNlXQo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMjIsIDIwMjAgMTI6NTQgQU0KPiBUbzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRo
YXYuQ2hhdWhhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzog
U3VyYW1wYWxsaSwgS2lzaG9yZSA8S2lzaG9yZS5TdXJhbXBhbGxpQGFtZC5jb20+OyBQYXRlbCwg
TWloaXIgPE1paGlyLlBhdGVsQGFtZC5jb20+OyBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5T
aGFybWFAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IFNhbGVlbSwgQXRoYXIgPEF0aGFyLlNhbGVlbUBhbWQuY29tPgo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IEFkZCB1aWQgaW5mbyB0byBwcm9jZXNzIEJPIGxpc3QKPgo+
IEFtIDIxLjA5LjIwIHVtIDIxOjE4IHNjaHJpZWIgTWFkaGF2IENoYXVoYW46Cj4+IFVJRCBpcyBo
ZWxwZnVsIHdoaWxlIGRvaW5nIGFuYWx5c2lzIG9mIEJPIGFsbG9jYXRlZCBieSBhIHByb2Nlc3Mu
Cj4gTG9va3MgbGlrZSBhIGJpdCBvdmVya2lsbCB0byBtZSwgd2h5IG5vdCBnZXQgdGhlIHVpZCBm
cm9tIHRoZSBwcm9jZXNzIGluZm8/Cj4KPiBOb3Qgc3VyZSBpZiBJIGdvdCB5b3VyIHBvaW50ICwg
YnV0IHVzZWQgdGhlIHNpbWlsYXIgbWV0aG9kIGltcGxlbWVudGVkIGF0IGRybSBsZXZlbCBpbnNp
ZGUgZHJtX2RlYnVnZnMuYy4gVGhhbmtzCgpHb29kIGFyZ3VtZW50LCBidXQgSSdtIG5vdCBzdXJl
IGlmIHdlIHNob3VsZCBkdXBsaWNhdGUgdGhhdCBoZXJlLiBXaGF0IApkbyB5b3UgbmVlZCB0aGlz
IGZvcj8KCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IE1hZGhhdgo+Cj4gQ2hyaXN0aWFuLgo+
Cj4+IFNpZ25lZC1vZmYtYnk6IE1hZGhhdiBDaGF1aGFuIDxtYWRoYXYuY2hhdWhhbkBhbWQuY29t
Pgo+PiAtLS0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwg
NiArKysrKy0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IGlu
ZGV4IGY0YzJlMmU3NWI4Zi4uYzE5ODIzNDllYzdiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IEBAIC04OTIsNiArODkyLDcgQEAgc3RhdGljIGludCBh
bWRncHVfZGVidWdmc19nZW1faW5mbyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpCj4+
ICAgIAlzdHJ1Y3QgZHJtX2luZm9fbm9kZSAqbm9kZSA9IChzdHJ1Y3QgZHJtX2luZm9fbm9kZSAq
KW0tPnByaXZhdGU7Cj4+ICAgIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gbm9kZS0+bWlub3It
PmRldjsKPj4gICAgCXN0cnVjdCBkcm1fZmlsZSAqZmlsZTsKPj4gKwlrdWlkX3QgdWlkOwo+PiAg
ICAJaW50IHI7Cj4+ICAgIAo+PiAgICAJciA9IG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgmZGV2
LT5maWxlbGlzdF9tdXRleCk7Cj4+IEBAIC05MDksNyArOTEwLDEwIEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2RlYnVnZnNfZ2VtX2luZm8oc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQo+PiAg
ICAJCSAqLwo+PiAgICAJCXJjdV9yZWFkX2xvY2soKTsKPj4gICAgCQl0YXNrID0gcGlkX3Rhc2so
ZmlsZS0+cGlkLCBQSURUWVBFX1BJRCk7Cj4+IC0JCXNlcV9wcmludGYobSwgInBpZCAlOGQgY29t
bWFuZCAlczpcbiIsIHBpZF9ucihmaWxlLT5waWQpLAo+PiArCQl1aWQgPSB0YXNrID8gX190YXNr
X2NyZWQodGFzayktPmV1aWQgOiBHTE9CQUxfUk9PVF9VSUQ7Cj4+ICsJCXNlcV9wcmludGYobSwg
InBpZCAlOGQgdWlkICU1ZCBjb21tYW5kICVzOlxuIiwKPj4gKwkJCSAgIHBpZF9ucihmaWxlLT5w
aWQpLAo+PiArCQkJICAgZnJvbV9rdWlkX211bmdlZChzZXFfdXNlcl9ucyhtKSwgdWlkKSwKPj4g
ICAgCQkJICAgdGFzayA/IHRhc2stPmNvbW0gOiAiPHVua25vd24+Iik7Cj4+ICAgIAkJcmN1X3Jl
YWRfdW5sb2NrKCk7Cj4+ICAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
