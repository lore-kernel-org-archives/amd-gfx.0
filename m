Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26524C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 11:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA32C206DD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DaWj+CjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA32C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91C86E864;
	Wed,  6 May 2020 11:33:17 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7C96E864
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 11:33:16 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046BRd1V005832;
 Wed, 6 May 2020 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Vl3W4/gpwEEPFzP4hDw+vXhzTsRhunGM8UniyIcYLCo=;
 b=DaWj+CjFmiMYnCoLt36sqvAz7Vvgy+/5eFNapUFAXwneO2Trj33ZwPrEa42KB+2mKx0+
 bL9CueZgNVWAv29XMxE5QJnxVMIGzu5KOjqPDZt6hOYX+Ym5/TZXVFfTVaUDo6gyW/6k
 ZeP4GI60ajukOS8KSvRsodEu2qLn4Q3bmkNZOTMQapujN2gUhJ5q/Z9s6S1vgtIkSNqc
 MHHW/Lrd1TxOKfBB5hwsc0syLEg2QZoOuMhhJkXK+dsx/AJRh9lz+wtv8Aqpb/bNKWYq
 WFjW8vk7lQJ1Ys8wJYfRu95VeHyIQd7fcCSmitGJnSpPRAc/TIb1b1IIZmYpb/IHYP1U /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 30s09r9u5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 11:33:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046BRQDo086595;
 Wed, 6 May 2020 11:33:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30sjnj3k2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 11:33:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046BXAdN004066;
 Wed, 6 May 2020 11:33:10 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 04:33:09 -0700
Date: Wed, 6 May 2020 14:33:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Message-ID: <20200506113303.GJ1992@kadam>
References: <20200505091239.GA117990@mwanda>
 <BYAPR12MB288896162E5761D45A5077DFB0A40@BYAPR12MB2888.namprd12.prod.outlook.com>
 <20200506091734.GH1992@kadam>
 <SN1PR12MB2558A472D85D6296CE250BBF87A40@SN1PR12MB2558.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN1PR12MB2558A472D85D6296CE250BBF87A40@SN1PR12MB2558.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060092
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 06, 2020 at 10:10:56AM +0000, Pan, Xinhui wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> no.  below function checks if block is valid or not.
> I think you need check your code_checker. or you were checking on a very old codebase?
> 
> /* check if ras is supported on block, say, sdma, gfx */
> static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
> unsigned int block)

Ah!  That's right.  Thanks.

What happens here is that Smatch thinks amdgpu_ras_is_supported() always
returns false because there is a bug in how it tracks ras->supported.
I will fix this.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
