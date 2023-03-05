Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00E6C678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73F510E181;
	Mon,  6 Mar 2023 08:28:15 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3AB10E013
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Mar 2023 21:24:44 +0000 (UTC)
Date: Sun, 05 Mar 2023 21:24:22 +0000
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=alshehhi.io header.i=@alshehhi.io
 header.b="EpyuNiAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alshehhi.io;
 s=protonmail2; t=1678051477; x=1678310677;
 bh=963jAu3q+hN/mhIrEkuTDfHfmGad9Bx1Amr9B/r2pqE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EpyuNiAL6Nn9Dbvoo8S15v1cX/km+KXIVe6VZ9/olGfbW/bT5r3NynEae/Eex3204
 M3OUtTid0dN1wGa/LqaA1oGgbX+mc/G0IKXY+elhMsGuCkPqq/YDVBXD4uCXPecWwL
 DhwT4QSISpGA26k32AHw+X/Qo0j4XnqxMzpY3U5++J8b6GY0RnfHDt2Ut2DlcA36oN
 r6Lah5KcNRomytPG90kiNOOysjkHjuM5vCRHXzqPUEHIBLVAL44yhZu4rFGiEcY1iJ
 PRUhFSoV/C07Mkw5P/30u9wruAH3Y2DXkNwboLZotvAvB2w9aSCyhUE8BFjkS0/Mg/
 4X68HRqwAj+sQ==
To: harry.wentland@amd.com
From: Husain Alshehhi <husain@alshehhi.io>
Subject: [PATCH] drivers/gpu: fix typo in comment
Message-ID: <20230305212411.25727-1-husain@alshehhi.io>
Feedback-ID: 31127354:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 06 Mar 2023 08:28:13 +0000
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
Cc: Husain Alshehhi <husain@alshehhi.io>, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace "isntance" with "instance".

Signed-off-by: Husain Alshehhi <husain@alshehhi.io>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/=
drm/amd/display/dmub/inc/dmub_cmd.h
index 007d6bdc3e39..734b34902fa7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1971,7 +1971,7 @@ struct dmub_cmd_psr_copy_settings_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2029,7 +2029,7 @@ struct dmub_cmd_psr_set_level_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2056,7 +2056,7 @@ struct dmub_rb_cmd_psr_enable_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2100,7 +2100,7 @@ struct dmub_cmd_psr_set_version_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2131,7 +2131,7 @@ struct dmub_cmd_psr_force_static_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2206,7 +2206,7 @@ struct dmub_cmd_update_dirty_rect_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2344,7 +2344,7 @@ struct dmub_cmd_update_cursor_payload0 {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2391,7 +2391,7 @@ struct dmub_cmd_psr_set_vtotal_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2429,7 +2429,7 @@ struct dmub_cmd_psr_set_power_opt_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
--
2.39.2


