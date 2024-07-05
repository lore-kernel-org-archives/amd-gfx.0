Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB08FC3DA41
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jul 2024 16:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C48B10E292;
	Sat,  6 Jul 2024 16:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wjep+ywC";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D5C10E94C;
 Fri,  5 Jul 2024 09:49:26 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-3d91a2c95b2so361425b6e.3; 
 Fri, 05 Jul 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720172966; x=1720777766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
 b=Wjep+ywC3r4E643oigKKlV6oqOuITN6YN2hybTIUUhlCTPuqmyvQulNUgvDhs3ibbX
 QWU8xsDc9XOb2OUmKXNgnrFidcieSm6KgTHXi0/GoLVPBV8mKp6aPsIJ2y/wDJAJ3U2D
 iuDtI4cfXxE7FuxVzFpJp6YBhe1Y4zv/85nrZiFX7mtAghgsReJS7I+GbdRi+Tznq20T
 1/P1x7ZtFP5Aa6d34sUaeQ5Wls+moHJZKq75IOR0mcG6bB24lvW10+fc3d8UDbyQtAxK
 eD9rRzGwu7d8FUFQEzRRM3+Q3jVhiG6lBpDp8L25AraBRg5gEEPI9NqHDwRb31RKTRMT
 dJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720172966; x=1720777766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
 b=IrE73NPOc1CfMwLcv96o6K3eDoaufxLffGOJYoo+rxgmWZI9qh9VebgpfOaOClRF2G
 jKAP9uQfa/dPl1Bm2rC/ZK/jlXYwjdo59ef5kGZPFr5FaKsXHuwXh/3iLg9apfJsoq/9
 VTJKdysoXU4bt0q8bLSqCrb0XONbUk2x5lFDKdKraROxBiSegz9ZcAWMMalWK+229+X+
 OrC2TzogUYmnvk0ZWDikOgMMWpxa3vWqeGDUUl9qNfGawIzUNBodpH0NbrkVUV4SIIG7
 9xKI/M453KqcJcz+Jv8fiellKmf1yQnZSkeV72Pf5QB/c7gSteeRJa71KNNprIawI+8L
 v4Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/u+2RGukkcY8+rl+9uA2kwMzZQaf+AEfc0ZIxuWG4HSIzCx1x+ZuAU1WdSjSjUSLBRfPat+55s9cEXOdkKxwVDxcA8sk3P/AebnbisTc50NxCkiv5F7xNF2Ykzqe1bdCl7RWA3xS61hIiez39Ew==
X-Gm-Message-State: AOJu0YzvSWrUzcQ3DRnpTnvFuPMP5KI/tYEnNZJIjMoTJy4I2OiXnYxs
 y2fj14p141HxuuXkyW/XTaMBou2rD0Uf+EghJ0m8/qHfragJBp/d
X-Google-Smtp-Source: AGHT+IFN9rzfbXK0Hc+NZ/fUS4V4FYR9VVi4H2M9XrZqKKDeZJ2LhGYv5DE6m7N7j5k2QDzd/2OZ3w==
X-Received: by 2002:a05:6808:1902:b0:3d6:2bb8:82ab with SMTP id
 5614622812f47-3d914da9af7mr5291414b6e.36.1720172965642; 
 Fri, 05 Jul 2024 02:49:25 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1cd7:818f:d731:f6bd:8194:7763])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b143b9409sm107313b3a.124.2024.07.05.02.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 02:49:25 -0700 (PDT)
From: Akshay Behl <akshaybehl231@gmail.com>
To: 
Cc: Akshay Behl <akshaybehl231@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Docs improvement in /dc/inc/hw/mpc.h
Date: Fri,  5 Jul 2024 15:18:58 +0530
Message-Id: <20240705094857.352270-1-akshaybehl231@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704092039.31264-1-akshaybehl231@gmail.com>
References: <20240704092039.31264-1-akshaybehl231@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 06 Jul 2024 16:39:39 +0000
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

