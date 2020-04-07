Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E981C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69F6206F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIkq/B29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69F6206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBA26E86B;
	Tue,  7 Apr 2020 12:58:30 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739426E86B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 12:58:29 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037Cr0Mm039208;
 Tue, 7 Apr 2020 12:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=stU0+IAV2TxjYDDMATzEC8yBulBD+LtP7WhaGZNmbVI=;
 b=aIkq/B29kFzCHEEIjhD3hEp9m0336YGTcW856z9NDM0WIh2s9nW4FoD0Fv5mWmBetkcB
 TPzVv4XktDIaBUrqjKcFEe68B8wi9mGbs6XHQSglY1YUsTmE60Wcti90ze1oVL5GOEJB
 m/xWLormUxFIBDoOxZoIx3n6WCpqkKzR/1bT6izKQXxq3M9n5/4JJoxTLq8iXCIKdcao
 AJnHn/e+G70K5PCn3BnBJWma2ImDaaiygjZp2ifOoGxVLXva1c5BEGhaZSCboJceYA4G
 hUp5BoghkW0GsxzKrKIRZRatFfzMT+84kjTWooIkAuUkAz4DaRSyNWPPZzFqVNVxIVWx oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 306jvn4nvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 12:58:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037CpSvZ160018;
 Tue, 7 Apr 2020 12:58:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30741e6edb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 12:58:23 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037CwFlY022226;
 Tue, 7 Apr 2020 12:58:15 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 07 Apr 2020 05:58:14 -0700
Date: Tue, 7 Apr 2020 15:58:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH net-next] drm/amd/display: Fix link_detect_sink()
Message-ID: <20200407125802.GK2001@kadam>
References: <20200406091910.GA5405@mwanda>
 <7ab9e9de-8d78-7f63-f2b3-c1e9669faa6d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ab9e9de-8d78-7f63-f2b3-c1e9669faa6d@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070112
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Chris Park <Chris.Park@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Zhan Liu <Zhan.Liu@amd.com>, kernel-janitors@vger.kernel.org,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Wenjing Liu <Wenjing.Liu@amd.com>, Melissa Wen <melissa.srw@gmail.com>,
 David Airlie <airlied@linux.ie>, Nikola Cornij <nikola.cornij@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Lucy Li <lucy.li@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Galiffi <David.Galiffi@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 06, 2020 at 12:22:51PM -0400, Kazlauskas, Nicholas wrote:
> On 2020-04-06 5:19 a.m., Dan Carpenter wrote:
> > This TODO stub originally had curly braces but we deleted them as part
> > of a clean up.  Unfortunately that changes the behavior of the code
> > because now the switch statement is part of the if statement.  Smatch
> > complains that the indenting doesn't make sense.
> > 
> >      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:425
> >      link_detect_sink() warn: if statement not indented
> > 
> > Also I changed "ZAZTODO" to just "TODO".  The ZAZ isn't used anywhere
> > else.
> > 
> > Fixes: 621514aa4140 ("drm/amd/display: codestyle cleanup on dc_link file until detect_dp func")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I'd prefer just dropping the block, but either method is:
> 
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> Since that previous patch broke most sink detection...
> 

Sorry for the net-next in the subject.  Anyway, this was fixed in
commit 50dc581a8f43 ("drm/amd/display: fix the broken logic in dc_link.c")
so no need for me to resend.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
