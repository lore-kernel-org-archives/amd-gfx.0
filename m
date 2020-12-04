Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BA2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 15:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52C022B3F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 15:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C022B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549B56E190;
	Fri,  4 Dec 2020 15:18:44 +0000 (UTC)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBFC6E190
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 15:18:43 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4FF6uu175525;
 Fri, 4 Dec 2020 15:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/tjoqp/bsw8GSxfpUh6YNA7BwVdDOrfZmO+ccnF7Quo=;
 b=eSvZIVyjLF8FDKe9/FLtDWwJ2I5OGCqcULQlwdHeELZjrMU4gLe3UTFePIsIJwiU9NiD
 whnavRmA5KZhyQfEePVxI/Jl0l6XjShU+OzvLi4gPKI8qXwzlM7MRwGbcmqvOfadVVji
 5WjA2rbJEhzO5dqdXCg4IzQzkmb3ITKfO+yL9CLn/ypp0RCfPKEJd7JtRM4jwSVknDx/
 +Bs0NZOE+KbjhOf4efoPLkqeF3ej4rgnM1yfnPlf/rb6IprsswC8tl0sA9mEemhZSuj2
 JVpLSrN8okevyLt17wH+SPXETGRrfxXE+PnOR5qFFoDLFPoO6pxkCVlJiG4UzELpyd+p Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 353c2bbq46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 04 Dec 2020 15:18:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4FGSvE101013;
 Fri, 4 Dec 2020 15:18:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 3540ay71p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Dec 2020 15:18:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B4FIbtg010124;
 Fri, 4 Dec 2020 15:18:38 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 04 Dec 2020 07:18:37 -0800
Date: Fri, 4 Dec 2020 18:18:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: eryk.brol@amd.com
Subject: [bug report] drm/amd/display: Do full modeset when DSC debugfs is
 changed
Message-ID: <X8pTRcVIEnhyFFoX@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=910
 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=900 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012040089
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

Hello Eryk Brol,

This is a semi-automatic email about new static checker warnings.

The patch 115a385c08d8: "drm/amd/display: Do full modeset when DSC
debugfs is changed" from Nov 19, 2020, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9335 amdgpu_dm_atomic_check()
    warn: variable dereferenced before check 'new_crtc_state' (see line 9318)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  9317	
  9318			if (!drm_atomic_crtc_needs_modeset(new_crtc_state) &&
  9319			    !new_crtc_state->color_mgmt_changed &&
  9320			    old_crtc_state->vrr_enabled == new_crtc_state->vrr_enabled &&
  9321				dm_old_crtc_state->dsc_force_changed == false)
  9322				continue;
  9323	
  9324			if (!new_crtc_state->enable)
                             ^^^^^^^^^^^^^^^^^^^^^^
This is already dereferenced

  9325				continue;
  9326	
  9327			ret = drm_atomic_add_affected_connectors(state, crtc);
  9328			if (ret)
  9329				return ret;
  9330	
  9331			ret = drm_atomic_add_affected_planes(state, crtc);
  9332			if (ret)
  9333				goto fail;
  9334	
  9335			if (dm_old_crtc_state->dsc_force_changed && new_crtc_state)
                                                                    ^^^^^^^^^^^^^^
So hopefully this NULL check can be removed?

  9336				new_crtc_state->mode_changed = true;
  9337		}

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
