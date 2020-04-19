Return-Path: <SRS0=s+k6=6D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E1DC38A30
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 21:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55382137B
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 21:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55382137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE5789BCD;
	Sun, 19 Apr 2020 21:12:17 +0000 (UTC)
X-Greylist: delayed 490 seconds by postgrey-1.36 at gabe;
 Sun, 19 Apr 2020 02:38:06 UTC
Received: from mail-m127107.qiye.163.com (mail-m127107.qiye.163.com
 [115.236.127.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212796E42F
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 02:38:06 +0000 (UTC)
Received: from vivo.com (wm-12.qy.internal [127.0.0.1])
 by mail-m127107.qiye.163.com (Hmail) with ESMTP id AB45B81818;
 Sun, 19 Apr 2020 10:29:17 +0800 (CST)
Message-ID: <ALkAhAAeCMuv1EhLduXMcKoR.3.1587263357615.Hmail.bernard@vivo.com>
To: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVtb3ZlIGFuIHVubmVjZXNzYXJ5IGNvbmRpdGlvbiBjaGVjayBpbiByZXNlcnZlX2JvX2FuZF9jb25kX3Ztcygp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 117.89.196.49
In-Reply-To: <3dedf704-896c-b1c1-2609-066522f89274@web.de>
MIME-Version: 1.0
Received: from bernard@vivo.com( [117.89.196.49) ] by ajax-webmail (
 [127.0.0.1] ) ; Sun, 19 Apr 2020 10:29:17 +0800 (GMT+08:00)
From: =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date: Sun, 19 Apr 2020 10:29:17 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVITk5CQkJCT01OQk9JT1lXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSUJDTk5DSU5DN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6NxA6Ezo6Hjg2Dg1KPhM3Hw4jNhgwFClVSFVKTkNMSU1ISE1LTExPVTMWGhIXVRkeCRUaCR87
 DRINFFUYFBZFWVdZEgtZQVlKSkxVQ0JVSkJNVU9CWVdZCAFZQU9OSUg3Bg++
X-HM-Tid: 0a719044c30e986bkuuuab45b81818
X-Mailman-Approved-At: Sun, 19 Apr 2020 21:12:16 +0000
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
Cc: opensource.kernel@vivo.com, Chunming Zhou <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Felix_K=C3=BChling?= <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgoKCuWPkeS7tuS6uu+8mk1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+CuWP
kemAgeaXpeacn++8mjIwMjAtMDQtMTkgMDI6MTg6MDYK5pS25Lu25Lq677yaQmVybmFyZCBaaGFv
IDxiZXJuYXJkQHZpdm8uY29tPixBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+LCJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPixhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCuaK
hOmAgeS6uu+8miJGZWxpeCBLw7xobGluZyIgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+LGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20sQ2h1bm1p
bmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4sRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CuS4u+mimO+8mlJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IFJlbW92ZSBhbiB1bm5lY2Vzc2FyeSBjb25kaXRpb24gY2hlY2sgaW4gcmVz
ZXJ2ZV9ib19hbmRfY29uZF92bXMoKT4+IFRoZXJlIGlzIG5vIG5lZWQgdG8gaWYgY2hlY2sgYWdh
aW4sCj4KPlRoYW5rcyBmb3IgdGhpcyBpbmZvcm1hdGlvbi4KPgo+KiBTaG91bGQgdGhlIGZ1bmN0
aW9uIG5hbWUgYmUgbWVudGlvbmVkIGluIHRoaXMgY2hhbmdlIGRlc2NyaXB0aW9uPwo+Cj4qIFdv
dWxkIHlvdSBsaWtlIHRvIGFkanVzdCB0aGUgcGF0Y2ggc3ViamVjdD8KPgo+Cj4+IG1heWJlIHdl
IGNvdWxkIG1lcmdlIGludG8gdGhlIGFib3ZlIGVsc2UgYnJhbmNoLgo+Cj5JIHN1Z2dlc3QgdG8g
cmVjb25zaWRlciB0aGlzIHdvcmRpbmcuCj4KPgo+4oCmCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+PiBAQCAtNzM1LDEwICs3MzUsOCBA
QCBzdGF0aWMgaW50IHJlc2VydmVfYm9fYW5kX2NvbmRfdm1zKHN0cnVjdCBrZ2RfbWVtICptZW0s
Cj7igKYKPgo+SSBwcm9wb3NlIHRvIHRha2UgZnVydGhlciBjb2Rpbmcgc3R5bGUgYXNwZWN0cyBp
bnRvIGFjY291bnQuCj5odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5n
LXN0eWxlLnJzdD9pZD05MDI4MGVhYTg4YWMxYTkxNDBkYzc1OTk0MTEyMzUzMGQ1NTQ1YmI2I24x
OTEKPgo+UG9zc2libGUgcmVmYWN0b3Jpbmc6Cj4JaWYgKHJldCkgewo+CQlwcl9lcnIo4oCmKTsK
PgkJ4oCmCj4JfSBlbHNlIHsKPgkJY3R4LT5yZXNlcnZlZCA9IHRydWU7Cj4JfQo+Cj4KPkhvdyBk
byB5b3UgdGhpbmsgYWJvdXQgdG8gYWRkIHRoZSB0YWcg4oCcRml4ZXPigJ0/Cj4KClN1cmUsIEkg
d2lsbCBtb2RpZnkgdGhlIGNvZGUgYW5kIGFkanVzdCB0aGlzIHBhdGNoIHN1YmplY3QuIEkgd2ls
bCBzdWJtaXQgaXQgYWdhaW4uCgo+UmVnYXJkcywKPk1hcmt1cwoNCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
