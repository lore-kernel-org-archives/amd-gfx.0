Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E6C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252B924655
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xAqtZPO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252B924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15CA6E1F9;
	Tue, 10 Mar 2020 12:27:24 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940FB6E1F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:27:23 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ACR8Rs120091;
 Tue, 10 Mar 2020 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=419/3qfNRI8VkaUuRu3FSlC0+xOR4+hyqZQGRQkdgtE=;
 b=xAqtZPO/pAc5XvFSBJtbRIt5SVFIXrBwi6XkCcXR3B3bm9y6MTF/fOeNruoPsp+Zwzf2
 VwA0Ii/+jyDpu4Dp9CAXcHbRXznI5glFQq/6xAQqXxc3HKMBJrfkDOcGnVYI+UXQXzdz
 K2StFp5CUJBHoJsMcv5Zk+Q91nCQJAKC0c/nfkskEmVXlDNUDw23Lddtq1wqTV0rq16I
 G4r3oEdPyXloNWcgb6ju2Sn4zl/9YH1kxiNMSghaRQwZJ03G0KwLhvwJwP815IEFLUbE
 d7GytZfgtfnAFPKtycykpuhi2AidscGukL45SXE85UC6gjj0ZJhU+q3F8ojjarxamWN3 Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yp7hm1jrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 12:27:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ACHhOH005221;
 Tue, 10 Mar 2020 12:23:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2yp8rhpk79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 12:23:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ACNo23011577;
 Tue, 10 Mar 2020 12:23:50 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 05:23:50 -0700
Date: Tue, 10 Mar 2020 15:23:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Tom St Denis <tom.stdenis@amd.com>
Subject: Re: [bug report] drm/amd/amdgpu: Add debugfs support for reading
 GPRs (v2)
Message-ID: <20200310122344.GA11601@kadam>
References: <20171128142919.4n4d5qfx6so6mllr@mwanda>
 <87088974-95bb-6b3c-a200-60169ec961e5@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87088974-95bb-6b3c-a200-60169ec961e5@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100083
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

On Tue, Nov 28, 2017 at 09:37:44AM -0500, Tom St Denis wrote:
> On 28/11/17 09:29 AM, Dan Carpenter wrote:
> > Hello Tom St Denis,
> > 
> > The patch c5a60ce81b49: "drm/amd/amdgpu: Add debugfs support for
> > reading GPRs (v2)" from Dec 5, 2016, leads to the following static
> > checker warning:
> > 
> > 	drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3774 amdgpu_debugfs_gpr_read()
> > 	error: buffer overflow 'data' 1024 <= 4095
> > 
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >    3731  static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
> >    3732                                          size_t size, loff_t *pos)
> >    3733  {
> >    3734          struct amdgpu_device *adev = f->f_inode->i_private;
> >    3735          int r;
> >    3736          ssize_t result = 0;
> >    3737          uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
> >    3738
> >    3739          if (size & 3 || *pos & 3)
> >    3740                  return -EINVAL;
> >    3741
> >    3742          /* decode offset */
> >    3743          offset = *pos & GENMASK_ULL(11, 0);
> >                  ^^^^^^
> > offset is set to 0-4095.
> > 
> >    3744          se = (*pos & GENMASK_ULL(19, 12)) >> 12;
> >    3745          sh = (*pos & GENMASK_ULL(27, 20)) >> 20;
> >    3746          cu = (*pos & GENMASK_ULL(35, 28)) >> 28;
> >    3747          wave = (*pos & GENMASK_ULL(43, 36)) >> 36;
> >    3748          simd = (*pos & GENMASK_ULL(51, 44)) >> 44;
> >    3749          thread = (*pos & GENMASK_ULL(59, 52)) >> 52;
> >    3750          bank = (*pos & GENMASK_ULL(61, 60)) >> 60;
> >    3751
> >    3752          data = kmalloc_array(1024, sizeof(*data), GFP_KERNEL);
> >                                       ^^^^
> > data is a 1024 element array
> > 
> >    3753          if (!data)
> >    3754                  return -ENOMEM;
> >    3755
> >    3756          /* switch to the specific se/sh/cu */
> >    3757          mutex_lock(&adev->grbm_idx_mutex);
> >    3758          amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> >    3759
> >    3760          if (bank == 0) {
> >    3761                  if (adev->gfx.funcs->read_wave_vgprs)
> >    3762                          adev->gfx.funcs->read_wave_vgprs(adev, simd, wave, thread, offset, size>>2, data);
> >    3763          } else {
> >    3764                  if (adev->gfx.funcs->read_wave_sgprs)
> >    3765                          adev->gfx.funcs->read_wave_sgprs(adev, simd, wave, offset, size>>2, data);
> >    3766          }
> >    3767
> >    3768          amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
> >    3769          mutex_unlock(&adev->grbm_idx_mutex);
> >    3770
> >    3771          while (size) {
> >    3772                  uint32_t value;
> >    3773
> >    3774                  value = data[offset++];
> >                                  ^^^^^^^^^^^^^^
> > We're possibly reading beyond the end of the array.  Maybe we are
> > supposed to divide the offset /= sizeof(*data)?
> 
> Hi Dan,
> 
> 
> umr only reads from offset zero but to be consistent I think yes the offset
> should be /= 4 first since we ensure it's 4 byte aligned it's clearly a 4
> byte offset.
> 
> Thanks for finding this, I'll craft up a patch shortly.
> 

What ever happened with this?

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
