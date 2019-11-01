Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8144CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 17:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E6220862
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 17:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E6220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AED86E288;
	Fri,  1 Nov 2019 17:39:24 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB796E02E;
 Fri,  1 Nov 2019 16:03:20 +0000 (UTC)
Received: by mail-pf1-x442.google.com with SMTP id r4so7365725pfl.7;
 Fri, 01 Nov 2019 09:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=i2tLZxbCCHmnoEpOsO7B5VVDeMXO3toEiyrLWd0A38o=;
 b=CEwgcCfulGye4k/cjpc/EkSzxkT+Pul6xIEHK2YLkXH+E0RqhF7OGnJkwVdOOV0N4S
 fQxfpQO5uvD9uqvm6rFzBp7sTyPDJKT46Fw3YWk3cjMW4hMPQo97cI6vp9RexLUEfGZK
 zoW5XYNqHnhqo9LpkR1frrK5XO6cTkZ0hl0zCOFwfEzqDV8icFcRSwd8iSeI9sJKJzNs
 uZAfui2MoJ2CmKuqTxjPFB+5e9bl9KUHWcpRc4mtSVbSTQzsKvLI3Dgp7+6PN4VQ+03d
 hBFULtf0eOi3G6FLYNHrl3E6mTifbs4oL92Lal8wGvOxXfQ6deEHEdMgv7waAucWLzdu
 Rcmw==
X-Gm-Message-State: APjAAAUsgSqu51G9uw6qfpPSX3eLIGqU1s1k5dwWSZWnw1NXdB18Jwnh
 EWEu4/Py+1Xm0TWV21oMr2o=
X-Google-Smtp-Source: APXvYqzp2gT3KgISCliS31Ttoh4B4VoKcz1N1xyVB98zOypkWYgNP6dKvs8v8O5KoOoq5K1+ysCY+A==
X-Received: by 2002:a17:90a:62cc:: with SMTP id
 k12mr651068pjs.142.1572624199710; 
 Fri, 01 Nov 2019 09:03:19 -0700 (PDT)
Received: from localhost ([2402:3a80:1386:1fa1:cbdc:7851:d398:f27c])
 by smtp.gmail.com with ESMTPSA id n3sm7541205pff.102.2019.11.01.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 09:03:18 -0700 (PDT)
Date: Fri, 1 Nov 2019 21:33:12 +0530
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: gpu: amdgpu: Remove @dev from
 amdgpu_gem_prime_export documentation
Message-ID: <20191101160312.GA11047@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Mailman-Approved-At: Fri, 01 Nov 2019 17:39:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent;
 bh=i2tLZxbCCHmnoEpOsO7B5VVDeMXO3toEiyrLWd0A38o=;
 b=ZgoTtfkjNDBbZRIaUX+TdhUiwPA47BigCQVQqtPPwfqU3QeSY1JuDiW/UVtHyZ1Gzr
 cF/ZdGJxwN7J0e5aa+eX5J5fTTL0x8NA+b6Y17qMp58DZd6jH6MzvqXNxVqqg6r+LDOL
 Ne1kQ+1HkcxuS4XQDr7NyJt9V/GbYc+DGDuKBYiXzDUQiOqBnwQXzADqxhtToL1zBiUI
 uaFsm1UrMoebyLrf88ZR6S5vpaC2bnyfrxGaFmC9NmKYkgCuKfKWlpH5lh05WBxbu8+2
 FKVSQ7guXRZ0DrghNiUHXzJIRnhrKUepXvlV0eH1nn/fHnGqud4OAFBFujvakMak/IMH
 kWcg==
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
Cc: David1.Zhou@amd.com, dri-devel@lists.freedesktop.org, airlied@linux.ie,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 chris@chris-wilson.co.uk, kraxel@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 emil.velikov@collabora.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101160312.fzKNVlV0SJTSQt0-XxbJQGzFWqjMDvZj04r8MEi3qNc@z>

VGhlIGZ1bmN0aW9uIGRvZXMgbm90IGhhdmUgYSAiZGV2IiBhcmd1bWVudCwgc28gcmVtb3ZlIGl0
IGZyb20KdGhlIGRvY3VtZW50YXRpb24uIFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyBkb2N1bWVu
dGF0aW9uCmJ1aWxkIHdhcm5pbmc6CgouL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kbWFfYnVmLmM6MzM1OgoJd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZGV2
JyBkZXNjcmlwdGlvbiBpbgoJJ2FtZGdwdV9nZW1fcHJpbWVfZXhwb3J0JwoKU2lnbmVkLW9mZi1i
eTogSmFza2FyYW4gU2luZ2ggPGphc2thcmFuc2luZ2g3NjU0MzIxQGdtYWlsLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jIHwgMSAtCiAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZG1hX2J1Zi5jCmluZGV4IDYxZjEwOGVjMmI1Yy4uNDkxN2I1NDhiN2YyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKQEAgLTMyMSw3ICszMjEsNiBA
QCBjb25zdCBzdHJ1Y3QgZG1hX2J1Zl9vcHMgYW1kZ3B1X2RtYWJ1Zl9vcHMgPSB7CiAKIC8qKgog
ICogYW1kZ3B1X2dlbV9wcmltZV9leHBvcnQgLSAmZHJtX2RyaXZlci5nZW1fcHJpbWVfZXhwb3J0
IGltcGxlbWVudGF0aW9uCi0gKiBAZGV2OiBEUk0gZGV2aWNlCiAgKiBAZ29iajogR0VNIEJPCiAg
KiBAZmxhZ3M6IEZsYWdzIHN1Y2ggYXMgRFJNX0NMT0VYRUMgYW5kIERSTV9SRFdSLgogICoKLS0g
CjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
