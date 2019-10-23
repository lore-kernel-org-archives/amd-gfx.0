Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7395BCA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C85320856
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2C26E117;
	Thu, 24 Oct 2019 07:31:06 +0000 (UTC)
X-Greylist: delayed 973 seconds by postgrey-1.36 at gabe;
 Wed, 23 Oct 2019 08:47:43 UTC
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5453A6E9EB;
 Wed, 23 Oct 2019 08:47:43 +0000 (UTC)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id B1BFDE93D3079EB8002D;
 Wed, 23 Oct 2019 16:31:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
 by mse-fl1.zte.com.cn with ESMTP id x9N8U30j081278;
 Wed, 23 Oct 2019 16:30:03 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019102316302352-91717 ;
 Wed, 23 Oct 2019 16:30:23 +0800 
From: zhongshiqi <zhong.shiqi@zte.com.cn>
To: harry.wentland@amd.com
Subject: [PATCH] dc.c:use kzalloc without test
Date: Wed, 23 Oct 2019 16:32:23 +0800
Message-Id: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-10-23 16:30:23,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-23 16:30:06, Serialize complete at 2019-10-23 16:30:06
X-MAIL: mse-fl1.zte.com.cn x9N8U30j081278
X-Mailman-Approved-At: Thu, 24 Oct 2019 07:31:04 +0000
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, Jun.Lei@amd.com,
 anthony.koo@amd.com, David1.Zhou@amd.com, David.Francis@amd.com,
 Wenjing.Liu@amd.com, amd-gfx@lists.freedesktop.org, cheng.shengyu@zte.com.cn,
 zhongshiqi <zhong.shiqi@zte.com.cn>, wang.yi59@zte.com.cn, sunpeng.li@amd.com,
 Aidan.Wood@amd.com, xue.zhihong@zte.com.cn, Bhawanpreet.Lakha@amd.com,
 Chris.Park@amd.com, Eric.Yang2@amd.com, linux-kernel@vger.kernel.org,
 christian.koenig@amd.com, Dmytro.Laktyushkin@amd.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, nicholas.kazlauskas@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023083223.8Mo069hJ1ISWjmj6HPi4qYQ_K6ed-ChpzJRzx96yh6o@z>

ZGMuYzo1ODM6bnVsbCBjaGVjayBpcyBuZWVkZWQgYWZ0ZXIgdXNpbmcga3phbGxvYyBmdW5jdGlv
bgoKU2lnbmVkLW9mZi1ieTogemhvbmdzaGlxaSA8emhvbmcuc2hpcWlAenRlLmNvbS5jbj4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjLmMKaW5kZXggNWQxYWRlZC4uNGI4ODE5YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC01ODAsNiArNTgwLDEwIEBAIHN0YXRpYyBib29sIGNv
bnN0cnVjdChzdHJ1Y3QgZGMgKmRjLAogI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTjJfMAog
CS8vIEFsbG9jYXRlIG1lbW9yeSBmb3IgdGhlIHZtX2hlbHBlcgogCWRjLT52bV9oZWxwZXIgPSBr
emFsbG9jKHNpemVvZihzdHJ1Y3Qgdm1faGVscGVyKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFkYy0+
dm1faGVscGVyKSB7CisJCWRtX2Vycm9yKCIlczogZmFpbGVkIHRvIGNyZWF0ZSBkYy0+dm1faGVs
cGVyXG4iLCBfX2Z1bmNfXyk7CisJCWdvdG8gZmFpbDsKKwl9CiAKICNlbmRpZgogCW1lbWNweSgm
ZGMtPmJiX292ZXJyaWRlcywgJmluaXRfcGFyYW1zLT5iYl9vdmVycmlkZXMsIHNpemVvZihkYy0+
YmJfb3ZlcnJpZGVzKSk7Ci0tIAoyLjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
