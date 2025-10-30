Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51761CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D6710EAC6;
	Fri, 31 Oct 2025 08:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="S22ZZovO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1C310E9C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nkks9IPPTiRjudJKz2fy8ztuwHSVrBIwR6A4uWG3RWI=;
 b=S22ZZovOv4dk2DtO7f6rbdTBTGuyF0LZ84MApUzajYKYF8+3VgcX9Rp8w1uLRptBb2JjYW
 1BnfhiPzDJCNKpttzh3fhPZVp8NUkA8MrxEe3XU+RIgeeLLDrQ/upvsjq9BjrD+oP1DEJ0
 xNyN+hJKrZJg3RNPYsiokGbnNDuzgsw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-3SfXlRV0MD-j8yUBwzTmjg-1; Thu, 30 Oct 2025 10:37:44 -0400
X-MC-Unique: 3SfXlRV0MD-j8yUBwzTmjg-1
X-Mimecast-MFC-AGG-ID: 3SfXlRV0MD-j8yUBwzTmjg_1761835063
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso1051752f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 07:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835063; x=1762439863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nkks9IPPTiRjudJKz2fy8ztuwHSVrBIwR6A4uWG3RWI=;
 b=QJt81qpLTDbV7qX7JO525Z2P/XwzYMNKPvDSS+AJEvbjmgKuua/gpPlg/IR/uF4xOz
 HtsAF89nAg03lzpEGJtHaDkwi2tpq7Cm/fG0VtZDR1HM6T9/jhqsbg6htZt4TmxXiurI
 jaotzOUeOt+EJ+pvf/Qqu1XzhhOE+zSWZreU+GsIRsc5fQsW8c3JAwt5N0/06rQq85Gz
 JJ8gD6bnianVGwPYu+GTSc1XpOjNjEahHzEt75pTLwoT0bKcz5biTyzHQTcD+R14TzNe
 S1EgxXiHB56koNgL9L6x9r/299MmqV1AdN2KDHJFTDqsCRi8ESFU3iXFOnXCLX2EWFAV
 6pWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjqvPRqgArxUbgjMKm80pUiYMbbUevaFyZbc9rrlwDBygZX97K48UHjeyn3CzFV6w4JQMLq6J@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8b8qpS/oxf6FNbNh/snNU0pG4HuaPNRyZVfxclOqzRof6ycK5
 NPQ+XWYUp3a+G8XHi/tiWEAo/Fk4eoSQefjfwt0gUUuDyDOVNixU0RYmWep4VJQuz5PuObF14UR
 2NdN/gPnDQpN+/hg+0APZRllxFSdJpIWdFbSPJFnfnuDdK43dmxOu8YYEjfZabfh3kWk=
X-Gm-Gg: ASbGnct3xhEyrKSP09ZuETIvo926C/IVOY5/+Aw2TPNFSS7EFBV08Q/Lj2mY009KSsG
 F36mZLQFdRKxjdcxK+Q2j0F/8IcrwFQUDCKWY+FPFkNipmAdxYWoKuU0tU/uM/j495JVe3RegUN
 SYTewSdQKY0wBPjLB3+tA7xs9uAMZneNuwJXVbOCvQnwov5iTCAcscLDahs/ORUp82M6IYj0+ku
 tbsWryL7W4U0idB/25LTZqAFLcvBQsr3bLOPPnppS7LYzYGsX7sn3ac/eNxpv6qIYdnYwme2IC0
 O3efnrpMWErdvB4eQQmmB9pF0UNly4CrsCybRJ/ypPPKKRj0GPOckSiwROxaWpYRZF4xRxUqcs2
 zRtuxknSq33i1591egrfQ+umfH3dHcFubccBiKdt9SX6nDU/F
X-Received: by 2002:a05:6000:1449:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-429bcccf0aamr87214f8f.5.1761835062918; 
 Thu, 30 Oct 2025 07:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Hb1Zr2+1H9F1aQQVjn8swQhMlyoOrBtrdyyo6F0SLZbU4syUP2hFz8P5UzKpetZ1C9iD6A==
X-Received: by 2002:a05:6000:1449:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-429bcccf0aamr87184f8f.5.1761835062481; 
 Thu, 30 Oct 2025 07:37:42 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb
 ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a94sm38472105f8f.5.2025.10.30.07.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 07:37:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Austin Zheng <austin.zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 waynelin <Wayne.Lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in AMD DISPLAY CORE - DML
Date: Thu, 30 Oct 2025 15:37:37 +0100
Message-ID: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wN3QyuRg2vPvnBYTu35q3uNAjQn2GtkkHup8nEXfvVo_1761835063
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 31 Oct 2025 08:12:39 +0000
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

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0 folder")
renames the directory dml2 to dml2_0 in ./drivers/gpu/drm/amd/display/dc,
but misses to adjust the file entry in AMD DISPLAY CORE - DML.

Adjust the file entry after this directory renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d739e18aab6..7031ee1e7cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,7 +1080,7 @@ M:	Austin Zheng <austin.zheng@amd.com>
 M:	Jun Lei <jun.lei@amd.com>
 S:	Supported
 F:	drivers/gpu/drm/amd/display/dc/dml/
-F:	drivers/gpu/drm/amd/display/dc/dml2/
+F:	drivers/gpu/drm/amd/display/dc/dml2_0/
 
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
-- 
2.51.0

