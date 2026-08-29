Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC4DC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B312A10E6BC;
	Mon, 31 Aug 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fsr7UE9O";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97DD10E069
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2026 07:53:08 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so13748995e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2026 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787989987; x=1788594787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+jbQ6QwM5+BlZ7cOazrDoJ7hDb3esvgCSdcu8xIlmJE=;
 b=Fsr7UE9OtYUa/89XmYk97KMYit3PQtnKZa9GI2tiw3of/QJL410qn6qfQ5uqPmmlEb
 ZU0amsM0vFzaFM62xzw1d0+7dSD+g0z1J2hewBQMgDSa+ZUq5IQR9LPtsrCkY6NNQpdN
 j/bp2NHzgXwUduD8ZCV3b6wL/ahq3UtBgGv92PhtlkNH2iQ4WWI8Ol7/++N6UEnRhBFt
 1mjli0GMNUg4qvqwsf2/YWBBSry/fP6FzD7lFFUI51iVcSvNkzDNU4iszAGB/WwbWBSI
 Jj4DeIDiclEEcVof6A6f4qtYlQECZD5vj36GDrXW6TaN3JfJwvHgg1g1yMLnO0anJeSV
 Khog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787989987; x=1788594787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+jbQ6QwM5+BlZ7cOazrDoJ7hDb3esvgCSdcu8xIlmJE=;
 b=hgwmTB8yMESoxuU2vqZICTOw0IGMuqtkeQk5s9C/y0pEXvducqEcobgrurfLXDtjH+
 1huL7+/D+XZL92eVBU1G/lJVf0LxLnM95lHCox0JN1f9kckE1jD6xn/6M/aySWfsJMsw
 3I1BTi+OEDjaojCXjThZ3MdUfeMyllceO1/cD8pwgCc/kkdpXvPH0P+/CJpO+ftcK/8Q
 k0nYBCPWsmJCoQDQlUT3GA7FwPsuxBnsapUDEdJGg9/8IX1KenaWz4QOzGoUMJAPAX3v
 jTQHUFsnfaWP8UtxQKAmuO2WU3dKgQHHoM2ja63tRZjErW7UgoOdCIW47AAFtbxXY1Hx
 h0aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoolB4lsWbf2EipZx7cOFcmUyuSE6T4GwnD8ZG9snkMjNBWXaQtZRtDR/D05xjgLqHQoc3dkk96@lists.freedesktop.org
X-Gm-Message-State: AFuF++kiirkDC4RVvesoNKOWV0glEvzhU8gjdREQHFPGuY+72XxY8k5E
 kpD/3xbJZBnmsRpOWWqTfJ3YlRrTzB3Gypilb5axnjbfHuyq0WitdEGY
X-Gm-Gg: AR+sD12G5RrCrtdobMWhnr9lzAtqxcTEODTSFBT9BCY3tQ8/mJ6RBlx5ebGSVxAapg5
 5emQu7NBW8FerVAzd2I81eaaj67nQ1leC7ydZ9qu/DzWZu1GjUJPjPos/I25ggXSBuXJVyfzXPQ
 D44kBljdhz/ik5TXGNgkjbrUF7vDXyHX8PYU1hAnyFDjDSqqHfbIGXOcs3o5el3bAWj+b/yLMqL
 AGxnHFS7UuI9zHXqxGvJyRtHwtYJg6xS/xURwjVSNzMIGCI9umwFxUTeSZeJdWuZ8MyQF0hekRu
 bP/wbyNPiMWiZXnRCqfXCtOPeOAp3NQ10hGwIK6X1TZSrPdF+KRCUfCNl6UQVKVuU+Y2WjQsPsD
 pSMPBAzoF/yqLw4wW4f+PwLn/bl4fms2fGbZ2cZ7hj1VbAZ8OYqFuLTO7KINnGdoKBufOH9glK4
 MP+hl/hZy2GQPcdbZKBgs2exPE9KcWL4Tz2W6yJ4/FVCidjwr1SUD5EzWgmeOcoGnp7nFFIz2Se
 4FjFptSf684x1Y80bIVsimhBBI4etHrO9QtZ3DwkwWZ0YJIioAxKruAbATkbg==
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr191294575e9.6.1787989986916; 
 Sat, 29 Aug 2026 00:53:06 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:e90c:f900:e29d:3a79:ac40:9edd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm9017193f8f.25.2026.08.29.00.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 00:53:06 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH v2] accel/amdxdna: fix race condition in mailbox send path
Date: Sat, 29 Aug 2026 10:53:03 +0300
Message-ID: <20260829075303.7457-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828221641.10034-1-denizaydogan1902@gmail.com>
References: <20260828221641.10034-1-denizaydogan1902@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mailbox_send_msg() reads and updates x2i_tail without any
synchronization. The DRM scheduler and ioctl paths can call
xdna_mailbox_send_msg() concurrently on the same channel, which
allows two threads to read the same tail value and corrupt the
hardware ring buffer.

Add a mutex to serialize the entire send path. A mutex is used
rather than a spinlock because the existing code calls
read_poll_timeout() with a non-zero sleep, which can reschedule.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 271617347..8338f03bd 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 
@@ -60,6 +61,7 @@ struct mailbox_channel {
 	struct xarray			chan_xa;
 	u32				next_msgid;
 	u32				x2i_tail;
+	struct mutex			lock;
 
 	/* Received msg related fields */
 	struct workqueue_struct		*work_q;
@@ -205,6 +207,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 	u32 tmp_tail;
 	int ret;
 
+	mutex_lock(&mb_chann->lock);
 	head = mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
 	tail = mb_chann->x2i_tail;
 	ringbuf_size = mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I) - sizeof(u32);
@@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 		ret = read_poll_timeout(mailbox_get_headptr, head,
 					tmp_tail < head || tail >= head,
 					1, 100, false, mb_chann, CHAN_RES_X2I);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&mb_chann->lock);
 			return ret;
+		}
 
 		if (tail >= head)
 			goto check_again;
@@ -240,6 +245,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 			    mb_msg->pkg.header.opcode,
 			    mb_msg->pkg.header.id);
 
+	mutex_unlock(&mb_chann->lock);
 	return 0;
 }
 
@@ -487,6 +493,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 		goto free_chann;
 	}
 	mb_chann->mb = mb;
+	mutex_init(&mb_chann->lock);
 
 	return mb_chann;
 
-- 
2.55.0

