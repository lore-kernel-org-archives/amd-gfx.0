Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832AFC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DFB2082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSOYQRtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DFB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBAB6E1CD;
	Thu, 30 Jul 2020 11:46:37 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4E96E1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:46:35 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UBgteV194717;
 Thu, 30 Jul 2020 11:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2q/ZlP1lhhy/+PVdT8tXC55z1/KqViF5q4rdKGdUfUA=;
 b=YSOYQRtjp6e1GzpeDud0IcHKO4lMRHju9BXYQpcsE7xIb0P7MyGy+IIqkr3S+mIXTXmD
 7+N/C/EQdWBUtb0xiLgbwciR5LU2au4PqIp13UCeQLTu/rZHQyMg0ppGz1H2oR9T5ih7
 07C8EmzUgMLh5rnHpDydyu8ZZ+JLQfei8rQ66W2uzAnrc3tKwmh5ikQe2FaRDtcWQt2q
 V1tPCy1rQLKuBioaTljgOKH1nrjFnaSVcB+n6TiZu2uTNS12v/Vh0zM9G316CNnEFGjV
 uGpTa7qb6CZB3oCL88Ga3Fj4RgNp/zi7/GMYysk5ThixOQnoRtb3Q6b+Mo87M6eKE5qw qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jk6e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 11:46:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UBgof8145151;
 Thu, 30 Jul 2020 11:46:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 32hu5x9g01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 11:46:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UBkNUW016639;
 Thu, 30 Jul 2020 11:46:23 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 04:46:22 -0700
Date: Thu, 30 Jul 2020 14:46:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>, Eryk Brol <eryk.brol@amd.com>
Subject: [PATCH] drm/amd/display: fix dp_dsc_clock_en_read() debugfs function
Message-ID: <20200730114613.GA59409@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300087
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

There are problems with the dp_dsc_clock_en_read() function.  Only one
of the memory leak is a runtime bug.

1)  It leaks memory on the -ENXIO and -EFAULT error paths.
2)  There is a discrepency between rd_buf_size (10) and str_len (30).
    Static analysis complain that this could lead to a buffer overflow,
    but actually the buffer overflow is prevented by other factors.
3)  The "rd_buf_ptr" is assigned "+= str_len" but the result is not used.
    This leads to static checker warnings as well.  Also the "str_len"
    is misleading because it's not the strlen() and in fact is beyond
    the end of the buffer.
4)  This code re-implements the simple_read_from_buffer() function.

This code can be cleaned up by removing the allocation and using the
simple_read_from_buffer() function.

Fixes: c06e09b76639 ("drm/amd/display: Add DSC parameters logging to debugfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 38 +++----------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index e5a6d9115949..114962922ff3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -983,22 +983,13 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
-	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
-	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
-	ssize_t result = 0;
-	int i, r, str_len = 30;
-
-	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!rd_buf)
-		return -ENOMEM;
-
-	rd_buf_ptr = rd_buf;
+	char rd_buf[10];
+	int len;
+	int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -1014,27 +1005,8 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
-		"%d\n",
-		dsc_state.dsc_clock_en);
-	rd_buf_ptr += str_len;
-
-	while (size) {
-		if (*pos >= rd_buf_size)
-			break;
-
-		r = put_user(*(rd_buf + result), buf);
-		if (r)
-			return r; /* r = -EFAULT */
-
-		buf += 1;
-		size -= 1;
-		*pos += 1;
-		result += 1;
-	}
-
-	kfree(rd_buf);
-	return result;
+	len = snprintf(rd_buf, sizeof(rd_buf), "%d\n", dsc_state.dsc_clock_en);
+	return simple_read_from_buffer(buf, size, pos, rd_buf, len);
 }
 
 static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
