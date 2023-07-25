Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56BBC00528
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 07:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727E410E3A4;
	Tue, 25 Jul 2023 07:19:22 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD99B10E1DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 04:43:54 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R94DP2mkMzBRydc
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 12:43:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690260229; x=1692852230; bh=yoXvsWFvf4lKS3sGNABj8yYPLom
 //8oxSw6PzoA5XC0=; b=cfdL1uME29Wi+vu6AB8vmDcXtRTcjiQtd491WU8OtKD
 Eq4UhKsYI78gbMHXrARnLoZCBoPrwDfqXWRup6h7le1dyQ6E9lgJ02hHPDyb22no
 U5aXzR00sAWLmJPF4kAEddNaontPwdns1JtIuQmCzd3jdlk/+EKlYxKHsfVLbWK7
 myVNDmYX19MrjlY/H3ynRg7ha8NmrHk1cib7blpapztwxUXjFJHTJGh8uqvPHfBE
 SCW1C0ceXdeQKLdWXDIFUKZttdnLQa2OdvrCBPfsdNVABlWiBTD6uFCVTDO2dNr4
 QR5cjGrFFvBpWL/zxgkrwnttEY49GI34LGnrChiSACw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id sz5aZBhEo2-o for <amd-gfx@lists.freedesktop.org>;
 Tue, 25 Jul 2023 12:43:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R94DN6rDnzBRDrQ;
 Tue, 25 Jul 2023 12:43:48 +0800 (CST)
MIME-Version: 1.0
Date: Tue, 25 Jul 2023 12:43:48 +0800
From: wuyonggang001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: Fix format error
In-Reply-To: <20230725043946.33470-1-zhanglibing@cdjrlc.com>
References: <20230725043946.33470-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <6bf7217253d188c37004e8793bd58c88@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 25 Jul 2023 07:19:19 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the error(s):

ERROR: space required before the open parenthesis '('

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/gpu/drm/radeon/r300.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c 
b/drivers/gpu/drm/radeon/r300.c
index 9c1a92fa2af6..25201b9a5aae 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -249,7 +249,7 @@ void r300_ring_start(struct radeon_device *rdev, 
struct radeon_ring *ring)

  	/* Sub pixel 1/12 so we can have 4K rendering according to doc */
  	gb_tile_config = (R300_ENABLE_TILING | R300_TILE_SIZE_16);
-	switch(rdev->num_gb_pipes) {
+	switch (rdev->num_gb_pipes) {
  	case 2:
  		gb_tile_config |= R300_PIPE_COUNT_R300;
  		break;
@@ -638,7 +638,7 @@ static int r300_packet0_check(struct 
radeon_cs_parser *p,
  	track = (struct r100_cs_track *)p->track;
  	idx_value = radeon_get_ib_value(p, idx);

-	switch(reg) {
+	switch (reg) {
  	case AVIVO_D1MODE_VLINE_START_END:
  	case RADEON_CRTC_GUI_TRIG_VLINE:
  		r = r100_cs_packet_parse_vline(p);
@@ -1180,7 +1180,7 @@ static int r300_packet3_check(struct 
radeon_cs_parser *p,
  	ib = p->ib.ptr;
  	idx = pkt->idx + 1;
  	track = (struct r100_cs_track *)p->track;
-	switch(pkt->opcode) {
+	switch (pkt->opcode) {
  	case PACKET3_3D_LOAD_VBPNTR:
  		r = r100_packet3_load_vbpntr(p, pkt, idx);
  		if (r)
