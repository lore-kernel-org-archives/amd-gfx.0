Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D308C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 18:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3923D20738
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+RpyJlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3923D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68516E3AE;
	Tue, 25 Aug 2020 18:53:56 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6066E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 18:53:54 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PIrjHa028261;
 Tue, 25 Aug 2020 18:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B6FbhnWnJkHzgO+K3GfU2abE43l4nQTFaiun28/rFCE=;
 b=O+RpyJlVfoVhJNg6eIW5iUhW9p+OHltQ/xqTM+HWmcBCZOW0sRMUz+brYTKvnof9Ty+T
 7chYJm24euf//eiGPBElkCzkRS9KfQ5RJIuhP2Cx25l/N1xZYgc4jhYO+dNxy0a0xNnZ
 q2ROkfIqETQ2RSsJV5zGNzPwLqMOoGpP8uWP9tID37IVZwP5dNCJkMuxzrC5ceqs4HLZ
 eNVlqKef40mCROQvrWO0MeKfE3apzkoU2pDdEfq7k/lxb6Q9j1mHHWW8ENBEv2jIyINy
 g0mR1berTkTh1vJjP801xRzn5nYzoHnQgINrEXGjpzHKjjrX0NlYl1L39rr+ErjWMg9U VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 333dbrvan0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Aug 2020 18:53:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PIkc5Q046488;
 Tue, 25 Aug 2020 18:53:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 333rty5yrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2020 18:53:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PIrcmU012013;
 Tue, 25 Aug 2020 18:53:38 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 Aug 2020 11:53:37 -0700
Date: Tue, 25 Aug 2020 21:53:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/si: Fix buffer overflow in
 si_get_register_value()
Message-ID: <20200825185324.GW5493@kadam>
References: <20200825111843.GA285523@mwanda>
 <CADnq5_O0f7NdR92PSKFS0zrN4oFb_WJXX1E_HQ9uHzM-4NL2OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_O0f7NdR92PSKFS0zrN4oFb_WJXX1E_HQ9uHzM-4NL2OQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250142
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
Cc: Alex Jivin <alex.jivin@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sonny Jiang <sonny.jiang@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 25, 2020 at 11:53:25AM -0400, Alex Deucher wrote:
> On Tue, Aug 25, 2020 at 7:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The values for "se_num" and "sh_num" come from the user in the ioctl.
> > They can be in the 0-255 range but if they're more than
> > AMDGPU_GFX_MAX_SE (4) or AMDGPU_GFX_MAX_SH_PER_SE (2) then it results in
> > an out of bounds read.
> >
> > I split this function into to two to make the error handling simpler.
> >
> > Fixes: dd5dfa61b4ff ("drm/amdgpu: refine si_read_register")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch.  This is more defensive, but It's a much simpler check to
> validate these in the caller.  See the attached patch.
> 

That works too.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
