Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6733C27C43
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73AB10E8FF;
	Wed, 29 May 2024 13:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RVwg7ihT";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E610110E570
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 13:11:38 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-6f8e9870e72so602958b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1716901898; x=1717506698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoaTOCmlXkenptztn+mDC2rLsS4IERfQPTeSACgx6t4=;
 b=RVwg7ihTEw9z4dvaRXMgla7IIp3H4X6rq/TENhjsL0Dc05Y1FZGmWCPQFAAGTMRFFB
 XY6XnSYpySkgvaQjP17UeCtLwBdkRI6XkoaQK11qNvc9gXJ5x45SMl8IplfT+dfTyxyC
 Ktl0QdZTWuARcVPc+BZox9jP402bvygqed/BvwB9HOX8SQmoTUXlqDh6eg0vFEKSalTY
 5uTBYWhw+HP0BbbR9O9eTKgKIGsMZIT4vETQqWGDbWOChOQ5SHs7TjWcnh8m+rQTDIBe
 3s5jy5xSBBko34yu5rKf2/1qsHpw53WvosIlwk+HeAMz+D1Z9VGUuPgM8Qi8PPpTOs+R
 SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716901898; x=1717506698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoaTOCmlXkenptztn+mDC2rLsS4IERfQPTeSACgx6t4=;
 b=h9lX6czcKxxFyrCXvE94pXVBEcL6EXS/MJ2tx209P8JLgXvca+ny2CJZN5mDBhTnb8
 KDtx51QxIo6V42fi+t7wJ0Sw3ASS22gxymPpG5d0tkyMk7FbPDLv5t/AanJbqd0/2gDx
 OS5XMFZZ2NJzdwFaQ2knOummwjqtPkI1MIIfL+A+BSvwO3ymc3khPTsCAQUf1EMHyEwg
 4jpwcQs36GtXVdupK8RiUfulKOhckEC2K9j4RJ4f9VL3K8Pvb7d1LxYb6L5koBKIM0Vo
 /C/n5uqEAZOr4M4O3s6m40mdSiHGmJo2rOE8lUErKjlJ0YRJdkP2cCNz29W6dPjNKFUl
 SOBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWof/pI1lvv3rJNnUdo8mF3UKwOdej3BedaYn5YXLkHZVo4NlAOymlmjrD5b/fVlMsCQeGJDO0nWPHf7+YIYcbhQjNt598zVxaJkDTZiQ==
X-Gm-Message-State: AOJu0YwU7Q+dr98ZmofjBuvlpKJEkkOPVp2ylT/mn0n/Pio5AcQ0aJ5a
 yO2yKn3uQa27cYbUooKgfbsYl3qD2wpDTof3bpB3GtKYANvRNweGcFqTH1Yd1zc=
X-Google-Smtp-Source: AGHT+IHPZoHe+5AtTnRZyrDiZBI1RraIlifONBLBScJQgU8Dwsc/BwuyckzD6ggcJxPHoRaMZ0SMIw==
X-Received: by 2002:a05:6a20:5b03:b0:1af:881c:e924 with SMTP id
 adf61e73a8af0-1b212e91384mr11340139637.62.1716901898281; 
 Tue, 28 May 2024 06:11:38 -0700 (PDT)
Received: from ccsl-Inspiron-7472.semfio.usp.br ([143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682226fc4dcsm7507164a12.42.2024.05.28.06.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 06:11:37 -0700 (PDT)
From: Bruno Rocha Levi <brunolevilevi@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Bruno Rocha Levi <brunolevilevi@usp.br>,
 Lucas Antonio <lucasantonio.santos@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drivers/gpu: Fix misalignment in comment block
Date: Tue, 28 May 2024 10:08:04 -0300
Message-ID: <20240528131026.214773-3-brunolevilevi@usp.br>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528131026.214773-1-brunolevilevi@usp.br>
References: <20240528131026.214773-1-brunolevilevi@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 13:24:11 +0000
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

This patch fixes a warning from checkpatch by ensuring the trailing */ is
aligned with the rest of the *, improving readability.

Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Bruno Rocha Levi <brunolevilevi@usp.br>
---
 drivers/gpu/drm/amd/acp/include/acp_gfx_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/acp/include/acp_gfx_if.h b/drivers/gpu/drm/amd/acp/include/acp_gfx_if.h
index feab8eb7f..b26710cae 100644
--- a/drivers/gpu/drm/amd/acp/include/acp_gfx_if.h
+++ b/drivers/gpu/drm/amd/acp/include/acp_gfx_if.h
@@ -19,7 +19,7 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
-*/
+ */
 
 #ifndef _ACP_GFX_IF_H
 #define _ACP_GFX_IF_H
-- 
2.45.1

