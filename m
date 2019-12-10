Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B6C2D0CB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13B214D8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ZnHv878"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADC26E97B;
	Tue, 10 Dec 2019 21:17:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1116E969
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23E67246A9;
 Tue, 10 Dec 2019 21:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012166;
 bh=g4bCn+xYFLaXqyDO1JtEXbFTEVIZV6mXkDG/EmNFlH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2ZnHv878HS79+Zy+2Cesskbxim/UGqcwBIIg8ZAYwwdwOmqWQPJ/OCMyBiJ3tIXfA
 tSjn4OzLjBT+DSlUqDWgQTESN3nhltObKm3LzOiLWoP/ToOIzMF9AczsgEZsasRzj4
 tw+DfPxNMMN4rTH7IU/ONcgkTY6H9z+Gzt0CQpmg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 126/350] drm/amd/display: fix header for RN clk mgr
Date: Tue, 10 Dec 2019 16:03:51 -0500
Message-Id: <20191210210735.9077-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, joseph gravenor <joseph.gravenor@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogam9zZXBoIGdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KClsgVXBzdHJl
YW0gY29tbWl0IGNkODNmYTFlYTliOTQzMWNmMWQ1N2FjNDE3OWExMWJjNDM5M2E1YjYgXQoKW3do
eV0KU2hvdWxkIGFsd2F5cyBNUDBfQkFTRSBmb3IgYW55IHJlZ2lzdGVyIGRlZmluaXRpb24gZnJv
bSBNUCBwZXItSVAgaGVhZGVyIGZpbGVzLgpJIGJlbGl2ZSB0aGUgcmVhc29uIHRoZSBsaW51eCB2
ZXJzaW9uIG9mIE1QMV9CQVNFIHdvcmtzIGlzIFRoZSAwdGjCoGVsZW1lbnQgb2YgdGhlIDB0aMKg
dGFibGUKb2YgdGhhdCBpcyBpZGVudGljYWwgdG8gdGhlIGNvcnJpc3BvbmRpbmcgdmFsdWUgb2Yg
TVAwX0JBU0UgaW4gdGhlIHJlbm9pciBvZmZzZXQgaGVhZGVyIGZpbGUuClRoZSByZWFzb24gd2Ug
c2hvdWxkIG9ubHkgdXNlIE1QMF9CQVNFIGlzIFRoZXJlIGlzIG9ubHkgb25lIHNldCBvZiBwZXIt
SVAgaGVhZGVycyBNUAp0aGF0IGluY2x1ZGVzIGFsbCByZWdpc3RlciBkZWZpbml0aW9ucyByZWxh
dGVkIHRvIFNNVSBJUCBibG9jay4gVGhpcyBJUCBpbmNsdWRlcyBNUDAsIE1QMSwgTVAyCmFuZCAg
YW4gZWNyeXB0aW9uIGVuZ2luZSB0aGF0IGNhbiBiZSB1c2VkIG9ubHkgYnkgTVAwLiBBcyBhIHJl
c3VsdCBhbGwgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgZnJvbQpNUCBmaWxlIHNob3VsZCBiZSBiYXNl
ZCBvbmx5IG9uIE1QMF9CQVNFIGRhdGEuCgpbSG93XQpDaGFuZ2UgTVAxX0JBU0UgdG8gTVAwX0JB
U0UKClNpZ25lZC1vZmYtYnk6IGpvc2VwaCBncmF2ZW5vciA8am9zZXBoLmdyYXZlbm9yQGFtZC5j
b20+CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IFJvbWFuIExpIDxSb21hbi5MaUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3JfdmJpb3Nfc211LmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyX3Zi
aW9zX3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEv
cm5fY2xrX21ncl92Ymlvc19zbXUuYwppbmRleCA1MDk4NGMxODExYmIyLi40NjhjNmJiMGUzMTE5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24y
MS9ybl9jbGtfbWdyX3ZiaW9zX3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3JfdmJpb3Nfc211LmMKQEAgLTMzLDcgKzMzLDcg
QEAKICNpbmNsdWRlICJtcC9tcF8xMl8wXzBfc2hfbWFzay5oIgogCiAjZGVmaW5lIFJFRyhyZWdf
bmFtZSkgXAotCShNUDFfQkFTRS5pbnN0YW5jZVswXS5zZWdtZW50W21tICMjIHJlZ19uYW1lICMj
IF9CQVNFX0lEWF0gKyBtbSAjIyByZWdfbmFtZSkKKwkoTVAwX0JBU0UuaW5zdGFuY2VbMF0uc2Vn
bWVudFttbSAjIyByZWdfbmFtZSAjIyBfQkFTRV9JRFhdICsgbW0gIyMgcmVnX25hbWUpCiAKICNk
ZWZpbmUgRk4ocmVnX25hbWUsIGZpZWxkKSBcCiAJRkQocmVnX25hbWUjI19fIyNmaWVsZCkKLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
