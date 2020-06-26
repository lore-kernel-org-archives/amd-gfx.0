Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEF7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7D1206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oktm5rHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7D1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A126EC5C;
	Fri, 26 Jun 2020 10:06:25 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249666EC5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 10:06:22 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05Q9wN2P157861;
 Fri, 26 Jun 2020 10:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=fE/gRD8+bs7URvUBvjDrHYAfZZUfoD4e2fi/7it14Uw=;
 b=oktm5rHcVFMfeTHm9Kyv6wkagdeOnagfkuVqbulSEZ2AbFMZ9Hx+khVRzltmI86CbZpG
 Ts8mAlgyb04grSpWl0UqCLAoNzPKRxNhMbHdTMvtzBocTbWxtiWbtuPi/7j3tH5LEiC3
 T0wOPg/mo6e0KFkUsRRdEIu08AdnB+hNZl/XgGFWDhyomPkr2A9jDeOmbZUqA0JQcHtB
 pVFOFxb4s7gbgc0hOzVYebufaMilcKLImdyxVb08CnOvNaDUkBLjmUAYePwEYA8nSaP2
 VJd0XP/Um7vWFcqooU4Ua4A3PeW7ON7bOEKZgbt9wk+HYAGgZsxGpzCbTlCZ4RjQYofd GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 31uustw8y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 26 Jun 2020 10:06:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05Q9wKYw059795;
 Fri, 26 Jun 2020 10:06:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 31uurbv15x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 10:06:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05QA6IAk015217;
 Fri, 26 Jun 2020 10:06:18 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 26 Jun 2020 10:06:17 +0000
Date: Fri, 26 Jun 2020 13:06:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wyatt.wood@amd.com
Subject: [bug report] drm/amd/display: Use dmub fw to lock pipe, cursor, dig
Message-ID: <20200626100612.GA306909@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=773 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=770
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=3 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260072
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

Hello Wyatt Wood,

This is a semi-automatic email about new static checker warnings.

The patch 4dc079787b23: "drm/amd/display: Use dmub fw to lock pipe,
cursor, dig" from May 27, 2020, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4091 dc_link_dp_set_test_pattern()
    warn: variable dereferenced before check 'pipe_ctx->stream' (see line 4068)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c
  4067					color_space,
  4068					pipe_ctx->stream->use_vsc_sdp_for_colorimetry,
  4069					link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
  4070	
  4071			if (pipe_ctx->stream->use_vsc_sdp_for_colorimetry) {
                            ^^^^^^^^^^^^^^^^^^
This is dereferenced in the original code.

  4072				if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
  4073					pipe_ctx->stream->vsc_infopacket.sb[17] |= (1 << 7); // sb17 bit 7 Dynamic Range: 0 = VESA range, 1 = CTA range
  4074				else
  4075					pipe_ctx->stream->vsc_infopacket.sb[17] &= ~(1 << 7);
  4076				resource_build_info_frame(pipe_ctx);
  4077				link->dc->hwss.update_info_frame(pipe_ctx);
  4078			}
  4079	
  4080			/* CRTC Patterns */
  4081			set_crtc_test_pattern(link, pipe_ctx, test_pattern, test_pattern_color_space);
  4082			pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
  4083			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
  4084					CRTC_STATE_VACTIVE);
  4085			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
  4086					CRTC_STATE_VBLANK);
  4087			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
  4088					CRTC_STATE_VACTIVE);
  4089	
  4090			if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable) {
  4091				if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
                                    ^^^^^^^^^^^^^^^^
The patch adds a new dereference, is it really required?

  4092					union dmub_hw_lock_flags hw_locks = { 0 };
  4093					struct dmub_hw_lock_inst_flags inst_flags = { 0 };

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
