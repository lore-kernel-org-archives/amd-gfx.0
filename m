Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F9C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3471C65017
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471C65017
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9533A6E1D8;
	Fri,  5 Mar 2021 11:25:26 +0000 (UTC)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08DB6E1D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 11:25:24 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125BPDnf176841;
 Fri, 5 Mar 2021 11:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=a4KjNgiHknJvdg6KSTpkuBSi/W+Ai4DDdG7ksL9TDK4=;
 b=ipP3F/tdhtWFv3DPNeyHzTuDAQKHFTM0HNnwPyfzCBOKwPeYY4bko1CBGJhgPQGpFo+u
 cbYTvN4waOyoahEEIu27yP6QOGZBbukZz3A+zd3z/3/CMIo1VcEao/wHpb0UIrSLdPwq
 HSCCo3aK1L4/nLviEbgafICPwcUWinLDe5v29Dn9jqLIEJ2RlgzFrgp/xbHFN8EmrD5D
 fvQrzdS2VKObG84720rbeV8MrdD1r4KIvvQ7exdrsD6AEPvmORT2iXLg6BohC1sGgjzv
 Myxqwt50esGrNrWHZFVRE1vH+lsYoWHshF1nYGuJaMCE7Ea8EquxrZEKd3MxB2xgsEJ2 Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 36ybkbj92s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Mar 2021 11:25:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125BP8Sg126242;
 Fri, 5 Mar 2021 11:25:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 3700124bmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Mar 2021 11:25:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 125BPEIQ008076;
 Fri, 5 Mar 2021 11:25:15 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Mar 2021 11:25:13 +0000
Date: Fri, 5 Mar 2021 14:25:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: yongqiang.sun@amd.com
Subject: [bug report] drm/amd/display: Implement dmub trace event
Message-ID: <YEIVE6HhVJAYRTgY@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050057
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

Hello Yongqiang Sun,

This is a semi-automatic email about new static checker warnings.

The patch 70732504c53b: "drm/amd/display: Implement dmub trace event" 
from Feb 19, 2021, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv.c:520 dmub_srv_hw_init()
    error: we previously assumed 'tracebuff_fb' could be null (see line 447)

drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv.c
   446	
   447		if (inst_fb && data_fb && bios_fb && mail_fb && tracebuff_fb &&
                                                                ^^^^^^^^^^^^
This old code assumes "tracebuff_fb" can be NULL.

   448		    fw_state_fb && scratch_mem_fb) {
   449			cw2.offset.quad_part = data_fb->gpu_addr;
   450			cw2.region.base = DMUB_CW0_BASE + inst_fb->size;
   451			cw2.region.top = cw2.region.base + data_fb->size;
   452	
   453			cw3.offset.quad_part = bios_fb->gpu_addr;
   454			cw3.region.base = DMUB_CW3_BASE;
   455			cw3.region.top = cw3.region.base + bios_fb->size;
   456	
   457			cw4.offset.quad_part = mail_fb->gpu_addr;
   458			cw4.region.base = DMUB_CW4_BASE;
   459			cw4.region.top = cw4.region.base + mail_fb->size;
   460	
   461			/**
   462			 * Doubled the mailbox region to accomodate inbox and outbox.
   463			 * Note: Currently, currently total mailbox size is 16KB. It is split
   464			 * equally into 8KB between inbox and outbox. If this config is
   465			 * changed, then uncached base address configuration of outbox1
   466			 * has to be updated in funcs->setup_out_mailbox.
   467			 */
   468			inbox1.base = cw4.region.base;
   469			inbox1.top = cw4.region.base + DMUB_RB_SIZE;
   470			outbox1.base = inbox1.top;
   471			outbox1.top = cw4.region.top;
   472	
   473			cw5.offset.quad_part = tracebuff_fb->gpu_addr;
   474			cw5.region.base = DMUB_CW5_BASE;
   475			cw5.region.top = cw5.region.base + tracebuff_fb->size;
   476	
   477			outbox0.base = DMUB_REGION5_BASE + TRACE_BUFFER_ENTRY_OFFSET;
   478			outbox0.top = outbox0.base + sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
   479	
   480	
   481			cw6.offset.quad_part = fw_state_fb->gpu_addr;
   482			cw6.region.base = DMUB_CW6_BASE;
   483			cw6.region.top = cw6.region.base + fw_state_fb->size;
   484	
   485			dmub->fw_state = fw_state_fb->cpu_addr;
   486	
   487			dmub->scratch_mem_fb = *scratch_mem_fb;
   488	
   489			if (dmub->hw_funcs.setup_windows)
   490				dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4,
   491							     &cw5, &cw6);
   492	
   493			if (dmub->hw_funcs.setup_outbox0)
   494				dmub->hw_funcs.setup_outbox0(dmub, &outbox0);
   495	
   496			if (dmub->hw_funcs.setup_mailbox)
   497				dmub->hw_funcs.setup_mailbox(dmub, &inbox1);
   498			if (dmub->hw_funcs.setup_out_mailbox)
   499				dmub->hw_funcs.setup_out_mailbox(dmub, &outbox1);
   500		}
   501	
   502		if (mail_fb) {
   503			dmub_memset(&rb_params, 0, sizeof(rb_params));
   504			rb_params.ctx = dmub;
   505			rb_params.base_address = mail_fb->cpu_addr;
   506			rb_params.capacity = DMUB_RB_SIZE;
   507	
   508			dmub_rb_init(&dmub->inbox1_rb, &rb_params);
   509	
   510			// Initialize outbox1 ring buffer
   511			rb_params.ctx = dmub;
   512			rb_params.base_address = (void *) ((uint64_t) (mail_fb->cpu_addr) + DMUB_RB_SIZE);
   513			rb_params.capacity = DMUB_RB_SIZE;
   514			dmub_rb_init(&dmub->outbox1_rb, &rb_params);
   515	
   516		}
   517	
   518		dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
   519		outbox0_rb_params.ctx = dmub;
   520		outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
                                                                     ^^^^^^^^^^^^^^^^^^^^^^
This new code just dereferences "tracebuff_fb" without checking.

   521		outbox0_rb_params.capacity = sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
   522		dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
