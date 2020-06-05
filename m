Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25EFC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7175D20663
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFbfFfU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7175D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2823B6E8D6;
	Fri,  5 Jun 2020 13:28:06 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D7D6E8D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 13:28:05 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055DMCXB008869;
 Fri, 5 Jun 2020 13:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DTeqG7kYnMHBl/dz5MtjpSMlXHJcuSOuhUYfvH6sfQw=;
 b=jFbfFfU0PtD+woSKDNkrbWdCz4xWtsLvBpLALEOxyqyOkZBD0wbLZKu+W5cVcAQu3Vef
 E4yr+4Cnr/QAMZZ7DznBQbhdf6oTmxbx0TiLX4WkHJcJic4EeYMv82RM7GunUrLQthu2
 GeoV+5C3XsnPnzfwEseb1aNlO87nZ7DngOoqHvE2sKj9ABkiqaRnstN8kgi10RBN2n4d
 4q/oTW5/NvLWJzw2/xL9yyRVrr9/Xxt7quEwPr+vpRDu/WQL/qUn52JkcZJTQNrJIBkx
 tR8Gw4Ux6+WrjD4MnoliNMp8dDNdovCdht/YnBiniY/kHuptSosMYeaRWuK8smZY7zE7 MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 31f9262uak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 05 Jun 2020 13:28:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055DRQp2135096;
 Fri, 5 Jun 2020 13:28:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 31f92ssqwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jun 2020 13:28:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055DS0Zs001746;
 Fri, 5 Jun 2020 13:28:00 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jun 2020 06:27:59 -0700
Date: Fri, 5 Jun 2020 16:27:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bhawanpreet.Lakha@amd.com
Subject: [bug report] drm/amd/display: Add DCN3 HWSEQ
Message-ID: <20200605132754.GA996387@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=3 mlxlogscore=646 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=3 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=645
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050100
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

Hello Bhawanpreet Lakha,

This is a semi-automatic email about new static checker warnings.

The patch 581b9589487e: "drm/amd/display: Add DCN3 HWSEQ" from May 
21, 2020, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:463 dcn30_init_hw()
    warn: variable dereferenced before check 'res_pool->dccg' (see line 437)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c
   436		// Initialize the dccg
   437		if (res_pool->dccg->funcs->dccg_init)
                    ^^^^^^^^^^^^^^
The patch adds a dereference.

   438			res_pool->dccg->funcs->dccg_init(res_pool->dccg);
   439	
   440		//Enable ability to power gate / don't force power on permanently
   441		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
   442	
   443		if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
   444			REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
   445			REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
   446	
   447			hws->funcs.dccg_init(hws);
   448	
   449			REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
   450			REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
   451			REG_WRITE(REFCLK_CNTL, 0);
   452		} else {
   453			if (!dcb->funcs->is_accelerated_mode(dcb)) {
   454				hws->funcs.bios_golden_init(dc);
   455				hws->funcs.disable_vga(dc->hwseq);
   456			}
   457	
   458			if (dc->ctx->dc_bios->fw_info_valid) {
   459				res_pool->ref_clocks.xtalin_clock_inKhz =
   460						dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
   461	
   462				if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
   463					if (res_pool->dccg && res_pool->hubbub) {
                                            ^^^^^^^^^^^^^^
This check is too late.

   464	
   465						(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
