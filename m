Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C1C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626F235F7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626F235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2476E8A5;
	Mon,  7 Dec 2020 17:54:19 +0000 (UTC)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF8E6E89C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 17:54:18 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Hr96q164205;
 Mon, 7 Dec 2020 17:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MZc6bZmSVNXBQisXo2rw7CHaaTAaWic6FHUfkraxLZ8=;
 b=XclGAefxxMJtN/aojpDXNBq6S7mCCYnwNH+vC6zmBRgIOw0E067F8U/wRdPYZfBbIwgN
 Q0zhW8SfWco0wXziymvN3G31KUNd2QfSCXij2zCNg3vXEiR5cKv0M6IwKUKwJA3QS2Z4
 9/0Cf9swY8YJxPdTuW7NTZVeSXvI+NmjaOegpv1QolnOzEceX6WfDddIEn0B+J+AqGde
 09v+4Jz7ffWemFF9kmH/dt14e6qq/Tg/futrbb7xIqdqNqjQDI1bJCNsLxgAPkScXQJL
 Ymtw2hA6WkqeVRiG+6q9xgjnAdx/u98oCEW4X2qhK74WWLSau4/PqPm8W8D1qd427a7F 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 357yqbptkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Dec 2020 17:54:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7HijlQ084001;
 Mon, 7 Dec 2020 17:52:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 358ksmgj7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Dec 2020 17:52:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B7HqDTx025928;
 Mon, 7 Dec 2020 17:52:13 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 07 Dec 2020 09:52:13 -0800
Date: Mon, 7 Dec 2020 20:51:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <20201207175157.GX2789@kadam>
References: <X85BcS43BIlg6GRx@mwanda>
 <yH-pfID7WsjnSRJLbFhmhDjbNS-jDo5oMNFmAKlbXjnrC3ySx584MAya2-VjK8jszGeglKY9pbr-M3d1j_9dTjXCG4hxRePwZc0cJ-P3am0=@emersion.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yH-pfID7WsjnSRJLbFhmhDjbNS-jDo5oMNFmAKlbXjnrC3ySx584MAya2-VjK8jszGeglKY9pbr-M3d1j_9dTjXCG4hxRePwZc0cJ-P3am0=@emersion.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070115
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

On Mon, Dec 07, 2020 at 02:53:28PM +0000, Simon Ser wrote:
> Hi,
> 
> On Monday, December 7th, 2020 at 3:51 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The patch adds some new unchecked dereferences.
> 
> The `if (!position.enable)` check above should ensure the dereference
> isn't unchecked.

Yeah.  You're correct.  Thanks, for looking into this.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
