Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18064C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 07:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B9310E7B1;
	Mon,  4 Apr 2022 07:22:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C37F10E86A
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Apr 2022 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648995708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2NzOUXV5geNPV1jFPan7KnjsKEym0Ss9ltF3bQDMSJk=;
 b=ZvVRS5LoWzzGr09uHL2xMceh2hReBOHSPJQ72BPbBiA7R9S4+K/CNBh8eA/n+zQaIVSyzo
 HnRxqlbIB87298ZVr894FDmzJ+YGmLoOtkFFvh0SaX/ghp2ymteF7LYxxJQLe3XuLUTlh/
 BeHn2jxg9QlEZjSKgbpKjr0orRB7E1U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-lcQDO907MYSp4c6EPfcimg-1; Sun, 03 Apr 2022 10:21:47 -0400
X-MC-Unique: lcQDO907MYSp4c6EPfcimg-1
Received: by mail-qk1-f197.google.com with SMTP id
 m23-20020a05620a221700b006809e1fa4fdso4832759qkh.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2NzOUXV5geNPV1jFPan7KnjsKEym0Ss9ltF3bQDMSJk=;
 b=vFybXScdD3vkRg55WcRUwsDBtsRoR3R7gurzARkZp5zhbEv4vi96nn4zG0yYYS/tH8
 Pt3yWJzrRoZF3OD7FmhAR5KTs1GMq6spClHR8916uNSVIC93wFRXXGC67Zw+L/ZgT3LS
 vkCxWlI8DxmRxmaxn5GIf4XxmBWZSDI/dua9ZZK7O/Swsg32CjSJWP3e/wISWQAowLie
 VeDWH+dlJjW+PRDXtVgPaH6KKIka7VI2o5zyl7YrGp+lol5BGbg4g4JUlo0gyNx+cGAH
 333UOSC33DJ4obRHKGxX+FvOvpReFbo61P/JQaueJQghxOE+3nYpWn7Rf3hbQGvBE8PA
 AmJA==
X-Gm-Message-State: AOAM531pA/5M3xhNFaMnDAM1ErHloKZ6QAD8S0ogoYLdEdXUtblPnPnG
 IRWKO0VxG/5W7LAbgYYt8AuTEk524XRdUP9EN4BkRxJKuXfsrpQsqfgCQcsuxuouTRaslqZKKwA
 kThkndoEZ1uPrvVaGKjzNg58Xzg==
X-Received: by 2002:a05:6214:da9:b0:441:2d37:1fdf with SMTP id
 h9-20020a0562140da900b004412d371fdfmr14150779qvh.14.1648995707227; 
 Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvPjZwizmTlC5AqPbCRYoH/kd4u1WRNzlEq/em0QPB+9sK5Zmh1lXeSdZpIFrdpTz7Zx+Gqg==
X-Received: by 2002:a05:6214:da9:b0:441:2d37:1fdf with SMTP id
 h9-20020a0562140da900b004412d371fdfmr14150757qvh.14.1648995707058; 
 Sun, 03 Apr 2022 07:21:47 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 h6-20020ac85e06000000b002e1e8a98abbsm6194271qtx.41.2022.04.03.07.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Apr 2022 07:21:46 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, wenjing.liu@amd.com, waynelin@amd.com,
 Anson.Jacob@amd.com, Yu-ting.Shen@amd.com, keescook@chromium.org,
 nicholas.kazlauskas@amd.com
Subject: [PATCH] drm/amd/display: cleanup extern usage in function definition
Date: Sun,  3 Apr 2022 10:21:37 -0400
Message-Id: <20220403142137.2234322-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 04 Apr 2022 07:22:20 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Smatch reports this issue
hdcp1_execution.c:500:29: warning: function
  'mod_hdcp_hdcp1_dp_execution' with external linkage
  has definition

The storage-class-specifier extern is not needed in a
definition, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 6ec918af3bff..1ddb4f5eac8e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -497,9 +497,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
 	return status;
 }
 
-extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
-		struct mod_hdcp_event_context *event_ctx,
-		struct mod_hdcp_transition_input_hdcp1 *input)
+enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
+						 struct mod_hdcp_event_context *event_ctx,
+						 struct mod_hdcp_transition_input_hdcp1 *input)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-- 
2.27.0

