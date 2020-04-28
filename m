Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F902C83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 11:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE7920661
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 11:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4qvhWFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B0589DFA;
	Tue, 28 Apr 2020 11:01:49 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697A589E11
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 11:01:47 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SAsiDt156404;
 Tue, 28 Apr 2020 11:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=u19+5+4O4HYadoT/OyaWt9RVROMxCSyX8vTo3OaEPAM=;
 b=F4qvhWFwP2EczHv9E4nbHuBwNxIM275saZA2y16XVqXiLXNMsMzsN856v3i8eFKAU5OV
 DtGlF2FzolX0xXZO5IYpgZWnzlA0f/tW4ukc54/2aCclvX6tHdhDJWQ5hd6NZ+HTvEQz
 /cWEXAIg2vs39puFU30N6S6WAu1LqWBjloXAMLsrASqTWEMNPzFRO6cP2M5+Bkhgnw0y
 7+Y4SD+YcMoCnr8kMDm/IVKcCDIp/jCVGpoax1lQwneVZHe/JVDF72bnnv8r6Yjd88cY
 6TOeRAQVUAXdJI+ir6EPaoya5w2RzUMA/+1ZA3ZYZ4vFNCNBs+SnkonjrnmU3mUyC1FA Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 30p2p04exk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 11:01:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SApr3G165619;
 Tue, 28 Apr 2020 11:01:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 30mxwyfyey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 11:01:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SB1g0q019121;
 Tue, 28 Apr 2020 11:01:42 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 04:01:41 -0700
Date: Tue, 28 Apr 2020 14:01:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: address the static checker warnings
Message-ID: <20200428110135.GA1992@kadam>
References: <20200424104115.28738-1-evan.quan@amd.com>
 <20200424110214.GR2682@kadam>
 <DM6PR12MB2619DD18E7E97E62291C1585E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB261984ABA35E54EBFE1CA521E4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR12MB261984ABA35E54EBFE1CA521E4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=816 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=865 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280090
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 28, 2020 at 02:31:12AM +0000, Quan, Evan wrote:
> Ping..

Are you asking me?  It's really hard for me to read your emails.
Normally email clients put "> " in front of the quoted parts of the
email.  Your email client doesn't line wrap at 72 characters either.  :(

> [Evan] No, that's true for SGPU setup only. For XGMI setup(multiple dgpus interconnected with bridges), the "hive" here is not NULL.

Presumably you are talking about out of tree code so I can't comment
on this.  In the current linux-next we know that amdgpu_device_lock_adev()
will only return false when "hive" is NULL.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
