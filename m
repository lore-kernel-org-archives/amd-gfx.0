Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBAC43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 14:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C1A208C3
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 14:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DMraTgkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C1A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CD26ED0F;
	Fri, 18 Sep 2020 14:30:52 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BC76E182
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 14:30:50 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IET1dB081756;
 Fri, 18 Sep 2020 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XE65HqHsTddKC28oj6Z2Gckj8COXzcW6Lt+F/itSNec=;
 b=DMraTgknu9PCw/HhP7YeChKlUoaBZV3+8JPb8opRamHvy9ylX3/jjnFSDxcT7DpqzjEs
 KZAprIAaoPI3+Jsuz6zy8F1KkIeZMvxyhJgv82meqyLGqEM7EqoH/kc/sbCCriU4Sv5H
 CWdAMDHz07pDvLqo9bWFESp2cWVgw+Hy9ppq/1sawZgnUGqy1D0P/7d/lcuSqyqRwXdD
 TXry66L3+kGlxpbYCUh945gGZmLwTQYzbsPZxNW7KF2bbT6qqCVMvFES2T1RzbcDQdL0
 ETw2kA/TA4LUb4Iv2mOdpQowmjhIqZHnfCflZM7SI1wS1GMkkvLW4dB1jo+s8g2LlzEH sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33gp9mqfsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Sep 2020 14:30:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IEPcuZ102426;
 Fri, 18 Sep 2020 14:28:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33h88enya9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2020 14:28:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08IESkj7029485;
 Fri, 18 Sep 2020 14:28:47 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 18 Sep 2020 14:28:46 +0000
Date: Fri, 18 Sep 2020 17:28:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: eryk.brol@amd.com
Subject: [bug report] drm/amd/display: Add connector to the state if DSC
 debugfs is set
Message-ID: <20200918142841.GC909725@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 suspectscore=3 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=954
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=964
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=3 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180118
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

The patch c44a22b3128d: "drm/amd/display: Add connector to the state
if DSC debugfs is set" from Aug 27, 2020, leads to the following
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:917 amdgpu_check_debugfs_connector_property_change()
	error: 'crtc_state' dereferencing possible ERR_PTR()

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
   883  static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device *adev,
   884                                                             struct drm_atomic_state *state)
   885  {
   886          struct drm_connector *connector;
   887          struct drm_crtc *crtc;
   888          struct amdgpu_dm_connector *amdgpu_dm_connector;
   889          struct drm_connector_state *conn_state;
   890          struct dm_crtc_state *acrtc_state;
   891          struct drm_crtc_state *crtc_state;
   892          struct dc_stream_state *stream;
   893          struct drm_device *dev = adev_to_drm(adev);
   894  
   895          list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
   896  
   897                  amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
   898                  conn_state = connector->state;
   899  
   900                  if (!(conn_state && conn_state->crtc))
   901                          continue;
   902  
   903                  crtc = conn_state->crtc;
   904                  acrtc_state = to_dm_crtc_state(crtc->state);
   905  
   906                  if (!(acrtc_state && acrtc_state->stream))
   907                          continue;
   908  
   909                  stream = acrtc_state->stream;
   910  
   911                  if (amdgpu_dm_connector->dsc_settings.dsc_force_enable ||
   912                      amdgpu_dm_connector->dsc_settings.dsc_num_slices_v ||
   913                      amdgpu_dm_connector->dsc_settings.dsc_num_slices_h ||
   914                      amdgpu_dm_connector->dsc_settings.dsc_bits_per_pixel) {
   915                          conn_state = drm_atomic_get_connector_state(state, connector);
   916                          crtc_state = drm_atomic_get_crtc_state(state, crtc);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Check for errors?

   917                          crtc_state->mode_changed = true;
   918                  }
   919          }
   920  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
