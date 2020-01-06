Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB692C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1AB2075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvo4NLOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1AB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A206E47B;
	Mon,  6 Jan 2020 15:03:44 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236DC6E47B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t14so15573040wmi.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eK/FJQfBFlfIRF/wX4plAt7mH1fh8KvtHeYZ4a7rESE=;
 b=Mvo4NLOTsuzl8EO+zy1JAtuyi+Fh9349MjRGFmmVBFBWypSOuxGaicE1qn/1884y4N
 LcGzFWFpPZ4vluOL44u2/A2T5xVkjN26jcasC2NbEpZX4lg5M3FKxyEPM/F7FnHw0BQa
 fVbFvguYe0ZSlBcgmtTW8raPmsRizaoPIbz9EWHV7UX9KQGhsYwqQAuJVUcCBkJ5rZdL
 p5aNEHtpFAVBXJtZjj0WI9LPGWmmI8uq010F+txQW7ovBeBZM+mecrnygu49a8R964+I
 MBC2Ys36Va7P/syWe7OWvyjU2h3HaXPgwVl26lTdfwDbGaWK2bNzwsToeXE5VexmXNev
 rOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eK/FJQfBFlfIRF/wX4plAt7mH1fh8KvtHeYZ4a7rESE=;
 b=lXnws93YRwGjBaG9xkwXxcn6xPYlS6kDHzISBkrEyCVKrJ94u+OCQeZ6q5593orpnU
 YtQMvGTG7OzH1UShg7ZBJMXVkg5X6OcHDTBijcF49Bt3YQAPXZEQjpi4TOp5N5j9Bbdj
 TXzc7Pq9BlJTWKMyHWYrY5YJ96xo/G4vBHOqF+biEnYeENwyeH3R0ddGr7D/GuQg2xl8
 fFMVY16wR/fIq7U1jV2DQzoyIwRnyqGYvb5iK1Buzw0wbnmYmSEZv0JNjXprKjnnwS+T
 kxfx+PBYmpF+vo1lWtkQxMp6TKDgv26Hqp5504Zmv8e3PI55Xx2qathIs4MvQGLocjRi
 FkGA==
X-Gm-Message-State: APjAAAUTljsEDe7wwPoH6fOIORHv8WZPSirAD98Nd6MYgOr3W1wUvNIf
 8IruwLBOJevZTd0kmbgBhYM=
X-Google-Smtp-Source: APXvYqz1orkZbb/FDSlK7zyJpSKF6oC6MaQEkS21+2oW62r90WApov3+PtQQRKEz9Yc8KhcviJQGOg==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr34264705wmh.94.1578323021848; 
 Mon, 06 Jan 2020 07:03:41 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:41 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/12] drm/amdgpu: add VM eviction lock v3
Date: Mon,  6 Jan 2020 16:03:26 +0100
Message-Id: <20200106150335.1738-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBhbGxvd3MgdG8gaW52YWxpZGF0ZSBWTSBlbnRyaWVzIHdpdGhvdXQgdGFraW5nIHRoZSBy
ZXNlcnZhdGlvbiBsb2NrLgoKdjM6IHVzZSAtRUJVU1kKClNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDQgKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDM2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwppbmRleCAwZDcwMGU4MTU0YzQuLjU0NDMwYzlmN2EyNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTY1Niw3ICs2NTYsNyBAQCBpbnQg
YW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGFtZGdwdV92bSAqdm0sCiAJCQkgICAgICB2b2lkICpwYXJhbSkKIHsKIAlzdHJ1Y3QgYW1k
Z3B1X3ZtX2JvX2Jhc2UgKmJvX2Jhc2UsICp0bXA7Ci0JaW50IHIgPSAwOworCWludCByOwogCiAJ
dm0tPmJ1bGtfbW92ZWFibGUgJj0gbGlzdF9lbXB0eSgmdm0tPmV2aWN0ZWQpOwogCkBAIC02NjUs
NyArNjY1LDcgQEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCiAJCXIgPSB2YWxpZGF0ZShwYXJh
bSwgYm8pOwogCQlpZiAocikKLQkJCWJyZWFrOworCQkJcmV0dXJuIHI7CiAKIAkJaWYgKGJvLT50
Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKIAkJCWFtZGdwdV92bV9ib19tb3ZlZChi
b19iYXNlKTsKQEAgLTY3OCw3ICs2NzgsMTEgQEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9i
b3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCQl9
CiAJfQogCi0JcmV0dXJuIHI7CisJbXV0ZXhfbG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOworCXZt
LT5ldmljdGluZyA9IGZhbHNlOworCW11dGV4X3VubG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOwor
CisJcmV0dXJuIDA7CiB9CiAKIC8qKgpAQCAtMTU1NSwxNSArMTU1OSwyNSBAQCBzdGF0aWMgaW50
IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
IAlpZiAoIShmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpKQogCQlvd25lciA9IEFNREdQVV9GRU5D
RV9PV05FUl9LRkQ7CiAKKwltdXRleF9sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7CisJaWYgKHZt
LT5ldmljdGluZykgeworCQlyID0gLUVCVVNZOworCQlnb3RvIGVycm9yX3VubG9jazsKKwl9CisK
IAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZl
KTsKIAlpZiAocikKLQkJcmV0dXJuIHI7CisJCWdvdG8gZXJyb3JfdW5sb2NrOwogCiAJciA9IGFt
ZGdwdV92bV91cGRhdGVfcHRlcygmcGFyYW1zLCBzdGFydCwgbGFzdCArIDEsIGFkZHIsIGZsYWdz
KTsKIAlpZiAocikKLQkJcmV0dXJuIHI7CisJCWdvdG8gZXJyb3JfdW5sb2NrOwogCi0JcmV0dXJu
IHZtLT51cGRhdGVfZnVuY3MtPmNvbW1pdCgmcGFyYW1zLCBmZW5jZSk7CisJciA9IHZtLT51cGRh
dGVfZnVuY3MtPmNvbW1pdCgmcGFyYW1zLCBmZW5jZSk7CisKK2Vycm9yX3VubG9jazoKKwltdXRl
eF91bmxvY2soJnZtLT5ldmljdGlvbl9sb2NrKTsKKwlyZXR1cm4gcjsKIH0KIAogLyoqCkBAIC0y
NTIyLDExICsyNTM2LDE5IEBAIGJvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1
X2JvICpibykKIAlpZiAoIWRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWRfcmN1KGJvLT50Ym8uYmFzZS5y
ZXN2LCB0cnVlKSkKIAkJcmV0dXJuIGZhbHNlOwogCisJLyogVHJ5IHRvIGJsb2NrIG9uZ29pbmcg
dXBkYXRlcyAqLworCWlmICghbXV0ZXhfdHJ5bG9jaygmYm9fYmFzZS0+dm0tPmV2aWN0aW9uX2xv
Y2spKQorCQlyZXR1cm4gZmFsc2U7CisKIAkvKiBEb24ndCBldmljdCBWTSBwYWdlIHRhYmxlcyB3
aGlsZSB0aGV5IGFyZSB1cGRhdGVkICovCiAJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoYm9f
YmFzZS0+dm0tPmxhc3RfZGlyZWN0KSB8fAotCSAgICAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGJv
X2Jhc2UtPnZtLT5sYXN0X2RlbGF5ZWQpKQorCSAgICAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGJv
X2Jhc2UtPnZtLT5sYXN0X2RlbGF5ZWQpKSB7CisJCW11dGV4X3VubG9jaygmYm9fYmFzZS0+dm0t
PmV2aWN0aW9uX2xvY2spOwogCQlyZXR1cm4gZmFsc2U7CisJfQogCisJYm9fYmFzZS0+dm0tPmV2
aWN0aW5nID0gdHJ1ZTsKKwltdXRleF91bmxvY2soJmJvX2Jhc2UtPnZtLT5ldmljdGlvbl9sb2Nr
KTsKIAlyZXR1cm4gdHJ1ZTsKIH0KIApAQCAtMjc3Myw2ICsyNzk1LDkgQEAgaW50IGFtZGdwdV92
bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwK
IAl2bS0+bGFzdF9kaXJlY3QgPSBkbWFfZmVuY2VfZ2V0X3N0dWIoKTsKIAl2bS0+bGFzdF9kZWxh
eWVkID0gZG1hX2ZlbmNlX2dldF9zdHViKCk7CiAKKwltdXRleF9pbml0KCZ2bS0+ZXZpY3Rpb25f
bG9jayk7CisJdm0tPmV2aWN0aW5nID0gZmFsc2U7CisKIAlhbWRncHVfdm1fYm9fcGFyYW0oYWRl
diwgdm0sIGFkZXYtPnZtX21hbmFnZXIucm9vdF9sZXZlbCwgZmFsc2UsICZicCk7CiAJaWYgKHZt
X2NvbnRleHQgPT0gQU1ER1BVX1ZNX0NPTlRFWFRfQ09NUFVURSkKIAkJYnAuZmxhZ3MgJj0gfkFN
REdQVV9HRU1fQ1JFQVRFX1NIQURPVzsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmgKaW5kZXggZDkzZWE5YWQ4NzllLi5kNTYxM2QxODRlOTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0yNDIsNiArMjQyLDEwIEBAIHN0cnVjdCBhbWRncHVfdm0g
ewogCS8qIHRyZWUgb2YgdmlydHVhbCBhZGRyZXNzZXMgbWFwcGVkICovCiAJc3RydWN0IHJiX3Jv
b3RfY2FjaGVkCXZhOwogCisJLyogTG9jayB0byBwcmV2ZW50IGV2aWN0aW9uIHdoaWxlIHdlIGFy
ZSB1cGRhdGluZyBwYWdlIHRhYmxlcyAqLworCXN0cnVjdCBtdXRleAkJZXZpY3Rpb25fbG9jazsK
Kwlib29sCQkJZXZpY3Rpbmc7CisKIAkvKiBCT3Mgd2hvIG5lZWRzIGEgdmFsaWRhdGlvbiAqLwog
CXN0cnVjdCBsaXN0X2hlYWQJZXZpY3RlZDsKIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
