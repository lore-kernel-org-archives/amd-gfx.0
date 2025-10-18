Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CBACCD195
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 20:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDA810E20F;
	Sat, 18 Oct 2025 20:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="Iq1La7HU";
	dkim-atps=neutral
X-Greylist: delayed 321 seconds by postgrey-1.36 at gabe;
 Sat, 18 Oct 2025 20:04:42 UTC
Received: from raptorengineering.com (mail.raptorengineering.com
 [23.155.224.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A6A10E20F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 20:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id E91DD8287EDA;
 Sat, 18 Oct 2025 14:59:20 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8CUMLYjfO5A4; Sat, 18 Oct 2025 14:59:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 2BAF18288F33;
 Sat, 18 Oct 2025 14:59:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 2BAF18288F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1760817560; bh=WzA4Zesp4pGpdJg8FBc35K7xyMzZgxYUp+YAbuROE6g=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Iq1La7HUR3XBERJrq3MR/XfUiBy72fC3rBS9LUPq1mp+1Lzo0Sw5zUyi6MCSpxhkc
 A0pkCwqTV3ogmP/bcffMm9ILRhsHHfz+svZ9L2JLLvWIhHlYf/rwSczKn1K6CK5cvX
 D2Fz9p+/P6p2HuwxyZdGa5src5K7/bCrNpPAEnX8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ae0EAMsYIfh6; Sat, 18 Oct 2025 14:59:20 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id EA1438287EDA;
 Sat, 18 Oct 2025 14:59:19 -0500 (CDT)
Date: Sat, 18 Oct 2025 14:59:19 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Message-ID: <786875643.1800435.1760817559796.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH] drm/amd/display: Don't blank the stream before DPMS in
 DisplayPort mode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Index: woR0bf6jOxcQPI4BlKFkGFJh0fftVw==
Thread-Topic: drm/amd/display: Don't blank the stream before DPMS in
 DisplayPort mode
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

On Polaris and Vega, when used in DisplayPort SST mode, the PHY can lock up if
the stream is blanked prior to disabling the DisplayPort link.  This lockup
then causes all subsequent AtomBIOS calls to fail, resulting in a GPU freeze
and a requirement to reset / re-POST the device to restore functionality.

Example failure:

    [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
    [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing D7B2 (len 824, WS 0, PS 0) @ 0xD901
    [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing D66C (len 326, WS 0, PS 0) @ 0xD6F7
    amdgpu 0000:01:00.0: [drm] *ERROR* dce110_link_encoder_enable_dp_output: Failed to execute VBIOS command table!
    <screeen is now offline and will not wake up until the amdgpu module is removed and reinserted>

Tested to fix the long-standing DPMS-related screen hangs on a WX4100 with
attached Samsung Odyssey G9 over DisplayPort.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=211425
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/4648
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 83419e1a9036..201894266573 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2372,7 +2372,15 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
 	update_psp_stream_config(pipe_ctx, true);
-	dc->hwss.blank_stream(pipe_ctx);
+
+	/* Attempting to blank the stream in diplay port mode prior to power
+	 * down can cause the PHY to freeze on Polaris and Vega, resulting
+	 * in all subsequent AtomBIOS calls failing and requiring a card reset
+	 * to recover.
+	 */
+	if (pipe_ctx->stream->signal != SIGNAL_TYPE_DISPLAY_PORT) {
+		dc->hwss.blank_stream(pipe_ctx);
+	}
 
 	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
 		deallocate_usb4_bandwidth(pipe_ctx->stream);
-- 
2.47.2
