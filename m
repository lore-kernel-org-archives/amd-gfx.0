Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C441CC352A2
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96486214AF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sV922+rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96486214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5668D6E53C;
	Thu,  6 Feb 2020 15:46:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31F06E53C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 15:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G86rPocPnOJQRXiCHHdQUVHxlHcbcfqFCpCDvmP75qJAJbAA5ovCydee6gGEQjUpKUjABTJ/7/GBZVuyL3g2aWszrYYlhLr+3szOJDF6p9KNkQ93bNMslcL7jOAkjE2UxTz1JO2IO/8PGRUiRDIqb12TPbQfIbAZ8wDCqAqf4XpP3C2EAArEYIXWwDx/nKw1U4nF6+rai9nPY7dlgJ67O1Mb18iOLWZciPYxRzMmTcIsylGRJkt2dbiJGi3eop8Ok8YAfEgbKwAo7z3d08U8hzuGWz7DnzR7xcESH480yu+DyhBuAEErWosbkQ471nalrDNy93vdY6cmzSZfgXFdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKoTcym7NUGKU1XRBnySfnDczF8bSO6/q8ZuN/Y2vTo=;
 b=An6M6ItOGKV/KG3yzs+DeuFfoILFCl/6I0zq8OzgJgx8H58M3C3bI6tQ7SE1tYDFl50kyPd2aKtFXPhlpXSrw/nibBSEXRam/WLW7wm+24W6nh8TXgxzUXiQ271rAh6vVLUW6yigNhHqNucYsS6K5+r5jXo3X2fJdSKO1zsQJDgWVFIgibLoHUSHKBQf6W6M04J41ZE/7hBPnhFEVw4B1t850tfd+ho+WzOukiu8nQ2KE7jgX2xcnPHX0Tk1Z6kMMm2ObHrAqcEPRLZbil+/tBQ2OhTJSkxNn19upa+kt84YVjPVcfwfNobcIF3Up44yv9Zhp/t9p51pUajakRH8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKoTcym7NUGKU1XRBnySfnDczF8bSO6/q8ZuN/Y2vTo=;
 b=sV922+rK68ZFL4W7tReDOuI9Wrgqi47jMbDkyDYOg7nOUFYUuTaiadfUkXMkRC1926dTtPK0NY86QRLUiVdgCd7bnlpGqaWdHGD7eWHzUn9lHpwsK3mYHofp904CP8riI1yK6BRrAheJ3cmGcJqx26o9e0nbVJsdHW28nFnEgvI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0188.namprd12.prod.outlook.com (10.174.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 15:46:45 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 15:46:44 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jonathan.Kim@amd.com
References: <20200206143051.25809-1-christian.koenig@amd.com>
 <20200206143051.25809-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7aebe62e-5242-90c7-4b5b-dd2821e309ee@amd.com>
Date: Thu, 6 Feb 2020 10:46:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200206143051.25809-4-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 15:46:44 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c11f423-b2b4-44e1-7135-08d7ab1bc480
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0188:|DM5PR1201MB0188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB018890C5FAF026328DA9AB24921D0@DM5PR1201MB0188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(316002)(5660300002)(16576012)(53546011)(31686004)(66574012)(52116002)(36756003)(86362001)(8676002)(81166006)(956004)(6486002)(8936002)(66946007)(66476007)(66556008)(81156014)(44832011)(186003)(16526019)(2906002)(2616005)(31696002)(6636002)(26005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0188;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EF3lNErFsV3UNKY7Kw5qmXzYM7IyGXSLGJm2uS8n/NV1W3tCIjKs8iIb3XBi/DpM2QcS4rSRZpPMnVxNRYqyfamz0CeHeoXihdbpcj/eS8verABlQvsVHWg8ClPJe2Wv37gVmcK2sOKjGzIqKiGokeYcrpC2nBqqAyZKCpXZteh/m/hcbTOyamofZKLa4lG0JPw3pjhVsM5o1fujV1EkcvNmiUpfoja/K7kswIMjC6QcCi2x8fCEOe1vjiyJys6ha1mw/3fnthFptYbqRrkUTPN1H4+ljMWmZ0JVLJ7kQKA7U6Mg4KbhtUuVBpnbAt0GBRvjVfnWFR38JsOLEknBGruXDUHpM9dZBG+1Re8lr+LZP9Kqouu/xDRoSEePExG9gooTqbrTIU8976yzbBTEE6JcIhhfCMJ10yoQGYMrR1YE1OJilpLfsw5uqfstGVF
X-MS-Exchange-AntiSpam-MessageData: z8qCDWqVt/yqNr4TlPwMUOTsYzVEEO3D0F4KhkQKEGcD0gZfReyrRC1OV4Saz0H36ZcK+hjRtpUQAH/aJMYFNf4OY3OWgG02CV4LGzbS0M6wTFhWvq5lxp2h7O80Xqqr8+4pcnhvWY4it6SAgME+pw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c11f423-b2b4-44e1-7135-08d7ab1bc480
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 15:46:44.9231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guxTMmxFX/A0DMX+UZuviJPK2zauBQDP99BGqlD0EmffUHlR/7MvXV4ROK5ToFMbD+vxd3WOEiduQHE6MDZeVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0188
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

T24gMjAyMC0wMi0wNiA5OjMwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IE1ha2UgdXNlIG9m
IHRoZSBiZXR0ZXIgcGVyZm9ybWFuY2UgaGVyZSBhcyB3ZWxsLgo+Cj4gVGhpcyBwYXRjaCBpcyBv
bmx5IGNvbXBpbGUgdGVzdGVkIQo+Cj4gdjI6IGZpeCBjYWxjdWxhdGlvbiBidWcgcG9pbnRlZCBv
dXQgYnkgRmVsaXgKPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPiBBY2tlZC1ieTogSm9uYXRoYW4gS2ltIDxKb25hdGhhbi5LaW1A
YW1kLmNvbT4KClRoZSBzZXJpZXMgaXMKClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jIHwgMzggKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDU4ZDE0M2IyNGJhMC4uMmMxZDFl
YjFhN2UxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBA
IC0xNTY1LDcgKzE1NjUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1fYWNjZXNzX21lbW9yeShz
dHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCj4gICAJd2hpbGUgKGxlbiAmJiBwb3Mg
PCBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSB7Cj4gICAJCXVpbnQ2NF90IGFsaWduZWRfcG9zID0g
cG9zICYgfih1aW50NjRfdCkzOwo+IC0JCXVpbnQzMl90IGJ5dGVzID0gNCAtIChwb3MgJiAzKTsK
PiArCQl1aW50NjRfdCBieXRlcyA9IDQgLSAocG9zICYgMyk7Cj4gICAJCXVpbnQzMl90IHNoaWZ0
ID0gKHBvcyAmIDMpICogODsKPiAgIAkJdWludDMyX3QgbWFzayA9IDB4ZmZmZmZmZmYgPDwgc2hp
ZnQ7Cj4gICAKPiBAQCAtMTU3NCwyMCArMTU3NCwyOCBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1f
YWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCQkJYnl0ZXMg
PSBsZW47Cj4gICAJCX0KPiAgIAo+IC0JCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT5tbWlvX2lk
eF9sb2NrLCBmbGFncyk7Cj4gLQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90
KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwo+IC0JCVdSRUczMl9OT19LSVEobW1NTV9JTkRF
WF9ISSwgYWxpZ25lZF9wb3MgPj4gMzEpOwo+IC0JCWlmICghd3JpdGUgfHwgbWFzayAhPSAweGZm
ZmZmZmZmKQo+IC0JCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKPiAtCQlpZiAo
d3JpdGUpIHsKPiAtCQkJdmFsdWUgJj0gfm1hc2s7Cj4gLQkJCXZhbHVlIHw9ICgqKHVpbnQzMl90
ICopYnVmIDw8IHNoaWZ0KSAmIG1hc2s7Cj4gLQkJCVdSRUczMl9OT19LSVEobW1NTV9EQVRBLCB2
YWx1ZSk7Cj4gLQkJfQo+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1taW9faWR4
X2xvY2ssIGZsYWdzKTsKPiAtCQlpZiAoIXdyaXRlKSB7Cj4gLQkJCXZhbHVlID0gKHZhbHVlICYg
bWFzaykgPj4gc2hpZnQ7Cj4gLQkJCW1lbWNweShidWYsICZ2YWx1ZSwgYnl0ZXMpOwo+ICsJCWlm
IChtYXNrICE9IDB4ZmZmZmZmZmYpIHsKPiArCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1t
aW9faWR4X2xvY2ssIGZsYWdzKTsKPiArCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVp
bnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwo+ICsJCQlXUkVHMzJfTk9fS0lRKG1t
TU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsKPiArCQkJaWYgKCF3cml0ZSB8fCBtYXNr
ICE9IDB4ZmZmZmZmZmYpCj4gKwkJCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsK
PiArCQkJaWYgKHdyaXRlKSB7Cj4gKwkJCQl2YWx1ZSAmPSB+bWFzazsKPiArCQkJCXZhbHVlIHw9
ICgqKHVpbnQzMl90ICopYnVmIDw8IHNoaWZ0KSAmIG1hc2s7Cj4gKwkJCQlXUkVHMzJfTk9fS0lR
KG1tTU1fREFUQSwgdmFsdWUpOwo+ICsJCQl9Cj4gKwkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArCQkJaWYgKCF3cml0ZSkgewo+ICsJCQkJ
dmFsdWUgPSAodmFsdWUgJiBtYXNrKSA+PiBzaGlmdDsKPiArCQkJCW1lbWNweShidWYsICZ2YWx1
ZSwgYnl0ZXMpOwo+ICsJCQl9Cj4gKwkJfSBlbHNlIHsKPiArCQkJYnl0ZXMgPSAobm9kZXMtPnN0
YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJCWJ5dGVzID0gbWluKGJ5dGVz
IC0gcG9zLCAodWludDY0X3QpbGVuICYgfjB4M3VsbCk7Cj4gKwo+ICsJCQlhbWRncHVfZGV2aWNl
X3ZyYW1fYWNjZXNzKGFkZXYsIHBvcywgKHVpbnQzMl90ICopYnVmLAo+ICsJCQkJCQkgIGJ5dGVz
LCB3cml0ZSk7Cj4gICAJCX0KPiAgIAo+ICAgCQlyZXQgKz0gYnl0ZXM7Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
