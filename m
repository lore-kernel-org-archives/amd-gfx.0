Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 12:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9827710E27F;
	Tue, 26 Apr 2022 12:56:13 +0000 (UTC)
X-Greylist: delayed 911 seconds by postgrey-1.36 at gabe;
 Tue, 26 Apr 2022 08:30:56 UTC
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2C56710E501
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zvXbx
 c6oeTRO3XsxcHtOzBD/YFkC8b+iClv9CLrQQ6Q=; b=WiLnpn+ipULxnoqRcM543
 92S8Wh0eQUXovS5xRLlhIUPzAYhkEVfVhaI7ky0o93Mbg4zlMka/MB/i1p1Q3hng
 aMttQicmwiOXhmuHRZ7r4Sjh4pkXc70z6S4n8CGHDisBrTQ4DFtwFFzrrzIDMgh3
 SuEWOd5WdjM2DhH8J//IbU=
Received: from localhost.localdomain (unknown [116.128.244.169])
 by smtp3 (Coremail) with SMTP id G9xpCgCnApgpqmdiPhL7DA--.44213S2;
 Tue, 26 Apr 2022 16:15:39 +0800 (CST)
From: clement wei <clementwei90@163.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: fix typo
Date: Tue, 26 Apr 2022 16:15:29 +0800
Message-Id: <20220426081529.870302-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCnApgpqmdiPhL7DA--.44213S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF17Jw18WrWxCw45ZF4xWFg_yoWDuFX_C3
 WxGwnru348XFsaqa1YkrZavrWa93ykuFWrXryIqw4fAF45Cr4qq3srXr4rWr98Gry8C3Zx
 JF4rXF9xArnrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0K0P3UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbB2APua2BHKA3igwAAs9
X-Mailman-Approved-At: Tue, 26 Apr 2022 12:56:12 +0000
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
Cc: xiaolinkui@kylinos.cn, Rongguang Wei <weirongguang@kylinos.cn>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rongguang Wei <weirongguang@kylinos.cn>

Fix spelling mistake:
	"differnt" -> "different"
	"commond"  -> "common"

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/gpu/drm/amd/include/atombios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index da895d1f3b4f..1f9df4e7509b 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4665,7 +4665,7 @@ typedef  struct _ATOM_EXTERNAL_DISPLAY_CONNECTION_INFO
   UCHAR                    Reserved[3];                           // for potential expansion
 }ATOM_EXTERNAL_DISPLAY_CONNECTION_INFO;
 
-//Related definitions, all records are differnt but they have a commond header
+//Related definitions, all records are different but they have a common header
 typedef struct _ATOM_COMMON_RECORD_HEADER
 {
   UCHAR               ucRecordType;                      //An emun to indicate the record type
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

