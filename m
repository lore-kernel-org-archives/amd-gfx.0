Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B58C2BD09
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jul 2024 16:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F032210E27E;
	Sat,  6 Jul 2024 16:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1LDTjzU";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A650A10E94C;
 Fri,  5 Jul 2024 09:44:59 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1faad2f1967so18112315ad.0; 
 Fri, 05 Jul 2024 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720172699; x=1720777499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
 b=M1LDTjzU6N7P5qusJm47FHLuradZR+DcjwRbXueDF4sDPmqicD3aqF10D484yNGbcT
 B77I/QEr48riukEx+djbWs0r5AClpe3E2I/mtNORpKERL6Ec90ZFEuHyuTUSK14dw6m6
 rhjsWOEn1f3djUkccVDNTt2VV0nc9/DXBHKcE7hQpk5jAfZOuSynJrTyTPc9N907rO9y
 adeKxVrE8NyufLg7BCxzWPRs1JpKut2tUgEZCxC989mYJ6mfSTntg4NCpLYHnGuxrZ3F
 gipERgtdsQbplFtkpwYo2HhdCfM4d5piJqYucQWxyVE1QH0bPq3SodlxnNxbh/oVgADw
 YxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720172699; x=1720777499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
 b=I+6cAtC93Dvd5f0Yy92xbsaBTBdbJyvgR2bFzSHrI4ukk9zyGGm0ctyd1kHHb2DNHw
 4X5Ft2XZA8YOku27YGxe1Ppn9K63EDp5p86ymFaQdtWa7qG+Iovlvsql+FwRTo0u5DHj
 C5z8fieqRjPegJ9yYk6fbUbs7KaXWivT5U0vfsyDe2J3bZxFq9XSAPAbGK3jkinz9Q08
 6hqeaYQ7yqZ9QW2+EIHkH31SzFf+Nyodn/T1JV5TSYsHl3Jh9yogQ9TojiuLRLSuB/FM
 pafqrtvoQS46VsUhVw84N46XbTfQYnNpG52lwJaBlNtd8+TE34W6n5wZQnPMa6aTSfhX
 HZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGwhy7z6rKa1XQI0j7cRrCWSyTP0guwa91LkBEe/E3mKLZPavD9IdeGUoPHsIVGU9aH9ls0B4oFmyCmexZcT+r16FaDFCPFrfPrlHHvB6ml9/T8n6juq7/a1MEwBHYZl87NIlDhqMINO4sEQuWQ==
X-Gm-Message-State: AOJu0YyBfmOZe69UMwnKV6l70ODX1MOH/U3OYji8HYx+kakE917SSYnu
 15z6IC9PO0VYgEkL5zA1Q6mXMGjGzG+j5mpHFbmZX25xYqgkcl0L
X-Google-Smtp-Source: AGHT+IFIOsO9JRujFXsVZsOxpIb8GSdE6GdOogexRlOCDz74s6RB/DEiJp4bpjlHZiMAjnGmY8T55Q==
X-Received: by 2002:a17:902:ce8a:b0:1fb:3263:2e60 with SMTP id
 d9443c01a7336-1fb37046126mr53036475ad.13.1720172698820; 
 Fri, 05 Jul 2024 02:44:58 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1cd7:818f:d731:f6bd:8194:7763])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080256df35sm13570682b3a.64.2024.07.05.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 02:44:58 -0700 (PDT)
From: Akshay Behl <akshaybehl231@gmail.com>
To: 
Cc: Akshay Behl <akshaybehl231@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Docs improvement in /dc/inc/hw/mpc.h
Date: Fri,  5 Jul 2024 15:13:44 +0530
Message-Id: <20240705094342.351894-1-akshaybehl231@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e17781fa-438d-4806-ae45-eb1239759f43@amd.com>
References: <e17781fa-438d-4806-ae45-eb1239759f43@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 06 Jul 2024 16:39:38 +0000
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

- After making the required changes

This patch fixes some of the warnings while building kernel Docs:
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'read_mpcc_state' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'mpc_init_single_inst' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'get_mpcc_for_dpp_from_secondary' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'get_mpcc_for_dpp' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'wait_for_idle' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'assert_mpcc_idle_before_connect' not described in 'mpc_funcs'

by adding descriptions to these struct members

Signed-off-by: Akshay Behl <akshaybehl231@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 84 ++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 34a398f23fc6..d2bea0a9699d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -282,6 +282,21 @@ struct mpcc_state {
  * struct mpc_funcs - funcs
  */
 struct mpc_funcs {
+	/**
+	 * @read_mpcc_state:
+	 *
+	 * Read current state of a specified MPCC instance
+	 *
+	 * Parameters:
+	 *
+	 * - [in/out] mpc  - MPC context.
+	 * - [in] mpcc_inst - integer representing specific MPC instance
+	 * - [in/out] mpcc_state - MPCC state struct where read information will be stored
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*read_mpcc_state)(
 			struct mpc *mpc,
 			int mpcc_inst,
@@ -352,6 +367,21 @@ struct mpc_funcs {
 	 * void
 	 */
 	void (*mpc_init)(struct mpc *mpc);
+
+	/**
+	 * @mpc_init_single_inst:
+	 *
+	 * Reset the MPCC HW status of a single MPCC physical instance.
+	 *
+	 * Parameters:
+	 *
+	 * - [in/out] mpc - MPC context.
+	 * - [in] mpcc_id - The MPCC physical instance to use for blending.
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*mpc_init_single_inst)(
 			struct mpc *mpc,
 			unsigned int mpcc_id);
@@ -448,17 +478,69 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			struct mpc_tree *tree,
 			struct mpcc *mpcc);
-
+	/**
+	 * @get_mpcc_for_dpp_from_secondary:
+	 *
+	 * Retrieve a specified MPCC struct from the 'secondary' MPC tree using the provided DPP id.
+	 *
+	 * Parameters:
+	 * - [in/out] tree - MPC tree structure that will be searched.
+	 * - [in]     dpp_id - DPP input for the MPCC.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that matched the input params
+	 */
 	struct mpcc* (*get_mpcc_for_dpp_from_secondary)(
 			struct mpc_tree *tree,
 			int dpp_id);
 
+	/**
+	 * @get_mpcc_for_dpp:
+	 *
+	 * Retrieve a specified MPCC struct from the MPC tree using the provided DPP id.
+	 *
+	 * Parameters:
+	 * - [in/out] tree - MPC tree structure that will be searched.
+	 * - [in]     dpp_id - DPP input for the MPCC.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that matched the input params
+	 */
+
 	struct mpcc* (*get_mpcc_for_dpp)(
 			struct mpc_tree *tree,
 			int dpp_id);
 
+	/**
+	 * @wait_for_idle:
+	 *
+	 * Wait for a specific MPCC instance to become idle
+	 *
+	 * Parameters:
+	 * - [in/out] mpc  - MPC context.
+	 * - [in]     id - ID of the MPCC instance to wait for
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*wait_for_idle)(struct mpc *mpc, int id);
 
+	/**
+	 * @assert_mpcc_idle_before_connect:
+	 *
+	 * Assert that the specific MPCC instance is ideal before attempting to connect.
+	 *
+	 * Parameters:
+	 * - [in/out] mpc  - MPC context.
+	 * - [in]     mpcc_id - ID of the MPCC instance to check for
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*assert_mpcc_idle_before_connect)(struct mpc *mpc, int mpcc_id);
 
 	void (*init_mpcc_list_from_hw)(
-- 
2.34.1

