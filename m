Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517CEC4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA022337F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA022337F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C34D6E85B;
	Mon,  7 Dec 2020 14:51:47 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5826E85B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 14:51:46 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7EnEow128697;
 Mon, 7 Dec 2020 14:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=D9LVzrbadV71WjWV5YHfyxX0JRKtmsHVMQBsS/KIcis=;
 b=kPtCfBQBt+iPxz2IHdR8neuSTPuAEZK4tg2DZRhqGYyrtwupm756QtQI5Rx3A5SgaStq
 dUDA6xvJ1MyfO2mafN2LW9il1qAXaGb9bMxdKls3EUe6dqs/jFkxQi2K4BxyIxO0x1hX
 ZSxm9rCge1ASxPkHr0R4UKe05wxoxtgqRVgo36yQZZk/JktvJL5JtE2ocajuIVEEH0FU
 ns9wuZatfx5+rlG31T8DOVpT+QLp75frTu2xaYfGPZM5/982pT8M5XxszdQaYFuFM0Oi
 kiEof07Yz5ivAxTaNUDvZoWOL/Xast8DFN+7fpULgnjgqDNBiqdys8Q5Z/HX29NKyhNr aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 35825kwncr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Dec 2020 14:51:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Eoi3l108974;
 Mon, 7 Dec 2020 14:51:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 358ksm9d15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Dec 2020 14:51:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B7EpZtt002587;
 Mon, 7 Dec 2020 14:51:35 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 07 Dec 2020 06:51:35 -0800
Date: Mon, 7 Dec 2020 17:51:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: contact@emersion.fr
Subject: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <X85BcS43BIlg6GRx@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=638
 suspectscore=3
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=652 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070096
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Simon Ser,

This is a semi-automatic email about new static checker warnings.

The patch 03a663673063: "drm/amd/display: use FB pitch to fill 
dc_cursor_attributes" from Dec 2, 2020, leads to the following Smatch 
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7438 handle_cursor_update()
    error: we previously assumed 'afb' could be null (see line 7397)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  7389  static void handle_cursor_update(struct drm_plane *plane,
  7390                                   struct drm_plane_state *old_plane_state)
  7391  {
  7392          struct amdgpu_device *adev = drm_to_adev(plane->dev);
  7393          struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If "plane->state->fb" is NULL then "afb" is NULL.


  7394          struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
                                        ^^^
Checked for NULL.

  7395          struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
  7396		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
  7397		uint64_t address = afb ? afb->address : 0;
  7398		struct dc_cursor_position position;
  7399		struct dc_cursor_attributes attributes;
  7400		int ret;
  7401	
  7402		if (!plane->state->fb && !old_plane_state->fb)
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
These aren't allow to be both NULL

  7403			return;
  7404	
  7405		DRM_DEBUG_DRIVER("%s: crtc_id=%d with size %d to %d\n",
  7406				 __func__,
  7407				 amdgpu_crtc->crtc_id,
  7408				 plane->state->crtc_w,
  7409				 plane->state->crtc_h);
  7410	
  7411		ret = get_cursor_position(plane, crtc, &position);
  7412		if (ret)
  7413			return;
  7414	
  7415		if (!position.enable) {
  7416			/* turn off cursor */
  7417			if (crtc_state && crtc_state->stream) {
  7418				mutex_lock(&adev->dm.dc_lock);
  7419				dc_stream_set_cursor_position(crtc_state->stream,
  7420							      &position);
  7421				mutex_unlock(&adev->dm.dc_lock);
  7422			}
  7423			return;
  7424		}
  7425	
  7426		amdgpu_crtc->cursor_width = plane->state->crtc_w;
  7427		amdgpu_crtc->cursor_height = plane->state->crtc_h;
  7428	
  7429		memset(&attributes, 0, sizeof(attributes));
  7430		attributes.address.high_part = upper_32_bits(address);
  7431		attributes.address.low_part  = lower_32_bits(address);
  7432		attributes.width             = plane->state->crtc_w;
  7433		attributes.height            = plane->state->crtc_h;
  7434		attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
  7435		attributes.rotation_angle    = 0;
  7436		attributes.attribute_flags.value = 0;
  7437	
  7438		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
                                   ^^^^^                  ^^^^^
The patch adds some new unchecked dereferences.

  7439	
  7440		if (crtc_state->stream) {

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
