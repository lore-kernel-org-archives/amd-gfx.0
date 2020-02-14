Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D2C3B19F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F8A24719
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHybGuO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F8A24719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EBF6FB0B;
	Fri, 14 Feb 2020 16:22:11 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0764A6FB0B;
 Fri, 14 Feb 2020 16:22:09 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8324A246DD;
 Fri, 14 Feb 2020 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581697328;
 bh=Zis/2J4cNpsMZcqwf9Osp3kP0K7LypCRbA1/0sjuczk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sHybGuO1Emu90VfjTC9MuxvWIQaiC+RVMowqH9uRtHUAmRDla6rZucp8+TDctWRQD
 2J8KULF9FX5vMzw7Gkbtl4VWXjc+2P5EuSWNBLCrgVGt6/OcfcpVXNjY4t8HfeM92Y
 OuwcqmGGlnlm47tQ3ThLq3LkiUPrePdxaMek7wCQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 036/141] drm/amdgpu: remove set but not used
 variable 'mc_shared_chmap'
Date: Fri, 14 Feb 2020 11:19:36 -0500
Message-Id: <20200214162122.19794-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yu kuai <yukuai3@huawei.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgZTk4
MDQyZGIyY2I4ZDBiNzI4Y2Q3NmUwNWI5YzJlMWM4NGI3ZjcyYiBdCgpGaXhlcyBnY2MgJy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjhfMC5jOiBJbiBmdW5jdGlvbgrigJhnZnhfdjhfMF9ncHVfZWFybHlfaW5pdOKAmToK
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYzoxNzEzOjY6IHdhcm5pbmc6IHZh
cmlhYmxlCuKAmG1jX3NoYXJlZF9jaG1hcOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQoKRml4ZXM6IDBiZGUzYTk1ZWFhOSAoImRybS9hbWRncHU6IHNwbGl0
IGdmeDggZ3B1IGluaXQgaW50byBzdyBhbmQgaHcgcGFydHMiKQpTaWduZWQtb2ZmLWJ5OiB5dSBr
dWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hh
bEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMg
fCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IGM4YTVjZjUzNjVhOTQuLmRh
MzJjN2U0OWJlMGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtMTcz
OSw3ICsxNzM5LDcgQEAgc3RhdGljIGludCBnZnhfdjhfMF9kb19lZGNfZ3ByX3dvcmthcm91bmRz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogc3RhdGljIGludCBnZnhfdjhfMF9ncHVfZWFy
bHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAl1MzIgZ2JfYWRkcl9jb25m
aWc7Ci0JdTMyIG1jX3NoYXJlZF9jaG1hcCwgbWNfYXJiX3JhbWNmZzsKKwl1MzIgbWNfYXJiX3Jh
bWNmZzsKIAl1MzIgZGltbTAwX2FkZHJfbWFwLCBkaW1tMDFfYWRkcl9tYXAsIGRpbW0xMF9hZGRy
X21hcCwgZGltbTExX2FkZHJfbWFwOwogCXUzMiB0bXA7CiAJaW50IHJldDsKQEAgLTE5MzIsNyAr
MTkzMiw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfZ3B1X2Vhcmx5X2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJCWJyZWFrOwogCX0KIAotCW1jX3NoYXJlZF9jaG1hcCA9IFJSRUcz
MihtbU1DX1NIQVJFRF9DSE1BUCk7CiAJYWRldi0+Z2Z4LmNvbmZpZy5tY19hcmJfcmFtY2ZnID0g
UlJFRzMyKG1tTUNfQVJCX1JBTUNGRyk7CiAJbWNfYXJiX3JhbWNmZyA9IGFkZXYtPmdmeC5jb25m
aWcubWNfYXJiX3JhbWNmZzsKIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
