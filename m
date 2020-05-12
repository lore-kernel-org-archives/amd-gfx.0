Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F3C54E94
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB02214DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CLBPuhz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB02214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1204C6E8AE;
	Tue, 12 May 2020 09:00:04 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0778A6E89F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 09:00:01 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g14so8825323wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZNungkfzjrpX3wvUKHqphES4AQA2BjvgdkrK2cjuiE=;
 b=CLBPuhz5g03xplqY3Lp/3c6jCI7cBpGlK2yI20bsQjZlk+Y0DSRAAzM7Uk0yJ/74fT
 qODjSJnOacCEhx0BQuKhrp9xCJljtl7WlTp/enOv9Yf5zmkcwWAQwPHdsOTS6iInjswc
 E2mZfpyZhXG3pjjGV03WLfeasYqdUTvXYUfyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZNungkfzjrpX3wvUKHqphES4AQA2BjvgdkrK2cjuiE=;
 b=fXG1GtGF8rz7YAS5bef/H4hpKLToWviEWrgRCc7JedNBQhra76m+F1wkTXVU/rziyv
 dwbISZm1ojfzQxVtjBLafLc2udrrfmGIfzBQRy/ggfaB5GrzKmbXs6A52L2wNrX2C0mu
 Qfutu6lW/87563N4bt6Q6eR6kGxDFoRdafj+GnyWBfAFHoBzv3nlXNCbzqE6eTGE00gw
 qPDN6cRLs4lac2Np+VMPYeEBF8VzWgEUHm+Kw1WcP9jA7spteekqjGOXmjNxPXH3ZqxV
 JtDNbWyYanitey/TZldm+KR2/eq6b7Mbro/rCDzVHlKsyvK1824ScXKiKj6g8WaMDnct
 WM0A==
X-Gm-Message-State: AGi0PuYu4lA9izl2O5YIqzaOeWSKhEPH8JcpTX6LDab/RFpjihC9TYgn
 SorQEZCQmdmgnK53tY6i7KKIyA==
X-Google-Smtp-Source: APiQypKft08OoGrIYtbiSYRYQwvgFtVy2fvk5tEE2SUvyg8qKyVKerp+e40UsbcgCmUWXpSeXbccUQ==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr13223418wmg.127.1589273999661; 
 Tue, 12 May 2020 01:59:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.01.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 01:59:59 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [RFC 03/17] dma-fence: prime lockdep annotations
Date: Tue, 12 May 2020 10:59:30 +0200
Message-Id: <20200512085944.222637-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VHdvIGluIG9uZSBnbzoKLSBpdCBpcyBhbGxvd2VkIHRvIGNhbGwgZG1hX2ZlbmNlX3dhaXQoKSB3
aGlsZSBob2xkaW5nIGEKICBkbWFfcmVzdl9sb2NrKCkuIFRoaXMgaXMgZnVuZGFtZW50YWwgdG8g
aG93IGV2aWN0aW9uIHdvcmtzIHdpdGggdHRtLAogIHNvIHJlcXVpcmVkLgoKLSBpdCBpcyBhbGxv
d2VkIHRvIGNhbGwgZG1hX2ZlbmNlX3dhaXQoKSBmcm9tIG1lbW9yeSByZWNsYWltIGNvbnRleHRz
LAogIHNwZWNpZmljYWxseSBmcm9tIHNocmlua2VyIGNhbGxiYWNrcyAod2hpY2ggaTkxNSBkb2Vz
KSwgYW5kIGZyb20gbW11CiAgbm90aWZpZXIgY2FsbGJhY2tzICh3aGljaCBhbWRncHUgZG9lcywg
YW5kIHdoaWNoIGk5MTUgc29tZXRpbWVzIGFsc28KICBkb2VzLCBhbmQgcHJvYmFibHkgYWx3YXlz
IHNob3VsZCwgYnV0IHRoYXQncyBraW5kYSBhIGRlYmF0ZSkuIEFsc28KICBmb3Igc3R1ZmYgbGlr
ZSBITU0gd2UgcmVhbGx5IG5lZWQgdG8gYmUgYWJsZSB0byBkbyB0aGlzLCBvciB0aGluZ3MKICBn
ZXQgcmVhbCBkaWNleS4KCkNvbnNlcXVlbmNlIGlzIHRoYXQgYW55IGNyaXRpY2FsIHBhdGggbmVj
ZXNzYXJ5IHRvIGdldCB0byBhCmRtYV9mZW5jZV9zaWduYWwgZm9yIGEgZmVuY2UgbXVzdCBuZXZl
ciBhKSBjYWxsIGRtYV9yZXN2X2xvY2sgbm9yIGIpCmFsbG9jYXRlIG1lbW9yeSB3aXRoIEdGUF9L
RVJORUwuIEFsc28gYnkgaW1wbGljYXRpb24gb2YKZG1hX3Jlc3ZfbG9jaygpLCBubyB1c2Vyc3Bh
Y2UgZmF1bHRpbmcgYWxsb3dlZC4gVGhhdCdzIHNvbWUgc3VwcmVtZWx5Cm9ibm94aW91cyBsaW1p
dGF0aW9ucywgd2hpY2ggaXMgd2h5IHdlIG5lZWQgdG8gc3ByaW5rbGUgdGhlIHJpZ2h0CmFubm90
YXRpb25zIHRvIGFsbCByZWxldmFudCBwYXRocy4KClRoZSBvbmUgYmlnIGxvY2tpbmcgY29udGV4
dCB3ZSdyZSBsZWF2aW5nIG91dCBoZXJlIGlzIG1tdSBub3RpZmllcnMsCmFkZGVkIGluCgpjb21t
aXQgMjNiNjgzOTVjN2M3OGE3NjRlODk2M2ZjMTVhN2NmZDMxOGJmMTg3ZgpBdXRob3I6IERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+CkRhdGU6ICAgTW9uIEF1ZyAyNiAyMjox
NDoyMSAyMDE5ICswMjAwCgogICAgbW0vbW11X25vdGlmaWVyczogYWRkIGEgbG9ja2RlcCBtYXAg
Zm9yIGludmFsaWRhdGVfcmFuZ2Vfc3RhcnQvZW5kCgp0aGF0IG9uZSBjb3ZlcnMgYSBsb3Qgb2Yg
b3RoZXIgY2FsbHNpdGVzLCBhbmQgaXQncyBhbHNvIGFsbG93ZWQgdG8Kd2FpdCBvbiBkbWEtZmVu
Y2VzIGZyb20gbW11IG5vdGlmaWVycy4gQnV0IHRoZXJlJ3Mgbm8gcmVhZHktbWFkZQpmdW5jdGlv
bnMgZXhwb3NlZCB0byBwcmltZSB0aGlzLCBzbyBJJ3ZlIGxlZnQgaXQgb3V0IGZvciBub3cuCgpD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
Q2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+CkNjOiBNYWFydGVuIExhbmto
b3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgpDYzogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2RtYS1idWYvZG1hLXJl
c3YuYyB8IDEgKwogaW5jbHVkZS9saW51eC9kbWEtZmVuY2UuaCAgfCAxICsKIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1y
ZXN2LmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYwppbmRleCA5OWMwYTMzYzkxOGQuLjM5
MmMzMzZmMDczMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKKysrIGIv
ZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKQEAgLTExNSw2ICsxMTUsNyBAQCBzdGF0aWMgaW50
IF9faW5pdCBkbWFfcmVzdl9sb2NrZGVwKHZvaWQpCiAJaWYgKHJldCA9PSAtRURFQURMSykKIAkJ
ZG1hX3Jlc3ZfbG9ja19zbG93KCZvYmosICZjdHgpOwogCWZzX3JlY2xhaW1fYWNxdWlyZShHRlBf
S0VSTkVMKTsKKwlfX2RtYV9mZW5jZV9taWdodF93YWl0KCk7CiAJZnNfcmVjbGFpbV9yZWxlYXNl
KEdGUF9LRVJORUwpOwogCXd3X211dGV4X3VubG9jaygmb2JqLmxvY2spOwogCXd3X2FjcXVpcmVf
ZmluaSgmY3R4KTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLmggYi9pbmNs
dWRlL2xpbnV4L2RtYS1mZW5jZS5oCmluZGV4IDNmMjg4ZjdkYjJlZi4uMDllMjNhZGIzNTFkIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS5oCisrKyBiL2luY2x1ZGUvbGludXgv
ZG1hLWZlbmNlLmgKQEAgLTM2MCw2ICszNjAsNyBAQCBkbWFfZmVuY2VfZ2V0X3JjdV9zYWZlKHN0
cnVjdCBkbWFfZmVuY2UgX19yY3UgKipmZW5jZXApCiAjaWZkZWYgQ09ORklHX0xPQ0tERVAKIGJv
b2wgZG1hX2ZlbmNlX2JlZ2luX3NpZ25hbGxpbmcodm9pZCk7CiB2b2lkIGRtYV9mZW5jZV9lbmRf
c2lnbmFsbGluZyhib29sIGNvb2tpZSk7Cit2b2lkIF9fZG1hX2ZlbmNlX21pZ2h0X3dhaXQodm9p
ZCk7CiAjZWxzZQogc3RhdGljIGlubGluZSBib29sIGRtYV9mZW5jZV9iZWdpbl9zaWduYWxsaW5n
KHZvaWQpCiB7Ci0tIAoyLjI2LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
