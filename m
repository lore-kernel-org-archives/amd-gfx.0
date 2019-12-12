Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D37C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 00:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B0720637
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 00:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WTB1OzF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0720637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91B96EC1F;
	Thu, 12 Dec 2019 00:20:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305CC6EC1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHbcYZiOLT3/Axx7AKF/Z8qcr1m6w4FzFnrbEiM80feLfe5YQgXe5bdSoxdan1BGQlswzzbrdIDdYVynBLDdiId9+eRhcwlCUHbcvQKaJSy8VEjXMsX23Agz5vua1ZOp/Vtfkl7up1luF15KNn3/2QeSS+LtFW8BuaC2MGvpVuGahcCxpftkV8h9c5LtZNlG9T0gXCWi7IY8k2P5GYtbFz1xcD+6o7Pj8JND0b4XIeuqcUbUJhCIxrX/2B7GklIdjyA+S9eovGt0HjHw/VFhmcjfkV5ytq9i5IAQ/ii9pNvM+7sh+rnbzId3cr/W/+dEJqeHWoczKtBGC3WzBNFCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGnN4hIDO3Pdl0CF8001OeF4EZ3C+DwPdm8h3lahJrk=;
 b=H5Dk2D9MWqaOIiEDoPzr/+UDi6EfI+1Ecxph3OXOoVm8D/3Z4/EJkBJLqjtKafrKokdyMIIqyNBGW/8m9UGqDBG7qc/wlh6VnHFl4oFd9Sn/V/f+EDPKwTX6Yyuidr6ixYysV8H5/MW4Fd4nO9C+JB0JWLfPQI0Culm/p/kgdAI/h8zF0/YHIH+0rskpVbvTDEiVVqPrOnnW0cL0sg7jv8dqK+0QFDIGrUPVIuIfauvWXXY2xZzWz0fMWEgWXc2lZ8nqzfa4wsfU3ZkFnL/J1xUt3bz8VoJcqq2RuMf13Keuu+7glmw+jl60G4fMrEjjLOQoTsMe8MpNz1x9g/9Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGnN4hIDO3Pdl0CF8001OeF4EZ3C+DwPdm8h3lahJrk=;
 b=WTB1OzF5uAFAk/bol08xpZ2OWArnULG1OIenH229YUKLaOMFtQosn4Ewmmy+w3dFeliHvdDU2nuWhNqvYH1LmbvBVgJo1/b0Ty6b6WD9/8Jm1kA/xTNw+iF0Y9Y1x2UQ/AoBGHRW2YYoLusd9Cg01T1b9U0AiVD+siJpOswbF1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3417.namprd12.prod.outlook.com (20.178.30.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 00:20:36 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 00:20:36 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
Date: Wed, 11 Dec 2019 16:20:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191205133940.3865-5-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.53.104]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f56dab97-5386-449d-2e1b-08d77e991bc4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3417:|DM6PR12MB3417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34176EBFDCEF6D531B18C67092550@DM6PR12MB3417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(66574012)(8936002)(478600001)(66556008)(316002)(36756003)(31686004)(66476007)(66946007)(8676002)(26005)(53546011)(44832011)(6506007)(2906002)(6486002)(52116002)(6636002)(2616005)(31696002)(6666004)(81166006)(86362001)(5660300002)(6512007)(81156014)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3417;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utpZFrnGj/uxwSha7f8187eG4kgYufti3HEeL4ht6cwZicev/sTkR32RmSRk2634m8ELzF0AypEyMnA13hr2ylXm8p7cPGD/BWjufJOjWgtpX9hLngbNzwqtWl4OkChN4gszxTR9ajzVnLLc0JSOWowUE4dqJGqfi7f1Ze7J/X2wPhXusMVH5DNuS/CAppp0TCeScvxfIW9rypST/nyAyj5G7G95BeZwKnX5CNv9RUHWf2VL3EC+uR7Kfbc+CzLNe44/LoeC0tD+FpSAu5dpTbAMTK1D2ZiT+x2udS18i1o53oBuzCGxtQRVkUpw5otTwHuEEA8sMKZPcAmugb7S6KjX5YXvROSFv3ewNNCG0eVN9Mseidt8VPdQU3FzZjzCTL+xOIuPoysOduIYCbMNsaW+qr1eCXymrzI6NYztk7Ew8xI40CZ5AUXJvsLPGKt0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56dab97-5386-449d-2e1b-08d77e991bc4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 00:20:36.0950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5RkUler6IC4JsD1/i2d7CSQwR9Mb5WvZo+R5aKuAC5lzK3Bgr687pye/tNDKfTGYI/CiUG6dkwaIZZARNA+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3417
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKQWxleCBzdGFydGVkIHRyeWluZyB0byBpbnZhbGlkYXRlIFBURXMgaW4g
dGhlIE1NVSBub3RpZmllcnMgYW5kIHdlJ3JlIApmaW5kaW5nIHRoYXQgd2Ugc3RpbGwgbmVlZCB0
byByZXNlcnZlIHRoZSBWTSByZXNlcnZhdGlvbiBmb3IgCmFtZGdwdV9zeW5jX3Jlc3YgaW4gYW1k
Z3B1X3ZtX3NkbWFfcHJlcGFyZS4gSXMgdGhhdCBzeW5jX3Jlc3Ygc3RpbGwgCm5lZWRlZCBub3cs
IGdpdmVuIHRoYXQgVk0gZmVuY2VzIGFyZW4ndCBpbiB0aGF0IHJlc2VydmF0aW9uIG9iamVjdCBh
bnkgbW9yZT8KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAxOS0xMi0wNSA1OjM5LCBDaHJpc3Rp
YW4gS8O2bmlnIHdyb3RlOgo+IFdoZW4gYSBCTyBpcyBldmljdGVkIGltbWVkaWFsbHkgaW52YWxp
ZGF0ZSB0aGUgbWFwcGVkIFBURXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3ICsrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA4MzlkNmRmMzk0ZmMuLmU1NzgxMTNiZmQ1NSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTI1NjUsNiAr
MjU2NSw3IEBAIHZvaWQgYW1kZ3B1X3ZtX2JvX2ludmFsaWRhdGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4gICAJCQkgICAgIHN0cnVjdCBhbWRncHVfYm8gKmJvLCBib29sIGV2aWN0ZWQp
Cj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICpib19iYXNlOwo+ICsJaW50IHI7
Cj4gICAKPiAgIAkvKiBzaGFkb3cgYm8gZG9lc24ndCBoYXZlIGJvIGJhc2UsIGl0cyB2YWxpZGF0
aW9uIG5lZWRzIGl0cyBwYXJlbnQgKi8KPiAgIAlpZiAoYm8tPnBhcmVudCAmJiBiby0+cGFyZW50
LT5zaGFkb3cgPT0gYm8pCj4gQEAgLTI1NzIsOCArMjU3MywyMiBAQCB2b2lkIGFtZGdwdV92bV9i
b19pbnZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCj4gICAJZm9yIChi
b19iYXNlID0gYm8tPnZtX2JvOyBib19iYXNlOyBib19iYXNlID0gYm9fYmFzZS0+bmV4dCkgewo+
ICAgCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9IGJvX2Jhc2UtPnZtOwo+ICsJCXN0cnVjdCBkbWFf
cmVzdiAqcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4gKwo+ICsJCWlm
IChiby0+dGJvLnR5cGUgIT0gdHRtX2JvX3R5cGVfa2VybmVsKSB7Cj4gKwkJCXN0cnVjdCBhbWRn
cHVfYm9fdmEgKmJvX3ZhOwo+ICsKPiArCQkJYm9fdmEgPSBjb250YWluZXJfb2YoYm9fYmFzZSwg
c3RydWN0IGFtZGdwdV9ib192YSwKPiArCQkJCQkgICAgIGJhc2UpOwo+ICsJCQlyID0gYW1kZ3B1
X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192YSwKPiArCQkJCQkJYm8tPnRiby5iYXNlLnJlc3YgIT0g
cmVzdik7Cj4gKwkJCWlmICghcikgewo+ICsJCQkJYW1kZ3B1X3ZtX2JvX2lkbGUoYm9fYmFzZSk7
Cj4gKwkJCQljb250aW51ZTsKPiArCQkJfQo+ICsJCX0KPiAgIAo+IC0JCWlmIChldmljdGVkICYm
IGJvLT50Ym8uYmFzZS5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpIHsK
PiArCQlpZiAoZXZpY3RlZCAmJiBiby0+dGJvLmJhc2UucmVzdiA9PSByZXN2KSB7Cj4gICAJCQlh
bWRncHVfdm1fYm9fZXZpY3RlZChib19iYXNlKTsKPiAgIAkJCWNvbnRpbnVlOwo+ICAgCQl9Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
