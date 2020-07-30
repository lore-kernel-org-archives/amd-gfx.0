Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6D2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE4A20829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wz13wkdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE4A20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7A86E1B9;
	Thu, 30 Jul 2020 11:52:47 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F036E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:52:45 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UBq1hP149260;
 Thu, 30 Jul 2020 11:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zbUphS4qE6L97k0ga9ayvUf7G7N7QVXOnuyIF7tCLn0=;
 b=wz13wkdHLr/MxWAftEFoCyTLXll6/CFtdYYvJOwUnPU2FMzraOdOOapItW92zJ6zfeAi
 JOskDgghdnXKjskCAY3HbYQXDMDeKbz9/T+eF1TFSgzr4IO2m+2TQm3kW9naxh3rmLmS
 SNHrtFOdbbZ/i0oc9CEp5xivMEZ41o+w5Jz1YCk1IFqiAsaBf2qf2Pwf7NbAtdZ1CefB
 6YVl1bw9dAbOsnIKmvQK4PdIw+oO7Hq/V3qPz8SmEcH/4EUqXQkz95yQov0IBIRaW+qp
 lPaBW0cFMCQBDqIfUSeW5GkTaqG9uVSX/5/Gs92uO33L7oKNEb+K27NsrHWazh5Bs4O0 QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 32hu1jk61h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 11:52:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UBmXEC143638;
 Thu, 30 Jul 2020 11:52:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32hu60tq2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 11:52:40 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UBqa1q019723;
 Thu, 30 Jul 2020 11:52:36 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 04:52:35 -0700
Date: Thu, 30 Jul 2020 14:52:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>, Eryk Brol <eryk.brol@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix dp_dsc_clock_en_read() debugfs
 function
Message-ID: <20200730115225.GG5493@kadam>
References: <20200730114613.GA59409@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200730114613.GA59409@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300088
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
Cc: Stylon Wang <stylon.wang@amd.com>, kernel-janitors@vger.kernel.org,
 Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The other debugfs functions should probably be updated as well...  I
just did this one as an example of how these functions are normally
implemented.

There are some other warnings we could look at as well.

regards,
dan carpenter

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:683 dp_phy_test_pattern_debugfs_write() warn: we tested 'valid_test_pattern' before and it was 'true'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1005 dp_dsc_clock_en_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1005 dp_dsc_clock_en_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1010 dp_dsc_clock_en_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1019 dp_dsc_clock_en_read() error: snprintf() is printing too much 30 vs 10
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1062 dp_dsc_slice_width_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1062 dp_dsc_slice_width_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1067 dp_dsc_slice_width_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1119 dp_dsc_slice_height_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1119 dp_dsc_slice_height_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1124 dp_dsc_slice_height_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1176 dp_dsc_bits_per_pixel_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1176 dp_dsc_bits_per_pixel_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1181 dp_dsc_bits_per_pixel_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1233 dp_dsc_pic_width_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1233 dp_dsc_pic_width_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1238 dp_dsc_pic_width_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1290 dp_dsc_pic_height_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1290 dp_dsc_pic_height_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1295 dp_dsc_pic_height_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1347 dp_dsc_chunk_size_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1347 dp_dsc_chunk_size_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1352 dp_dsc_chunk_size_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1404 dp_dsc_slice_bpg_offset_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1404 dp_dsc_slice_bpg_offset_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1409 dp_dsc_slice_bpg_offset_read() warn: address of 'aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
