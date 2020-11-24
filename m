Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF858C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BD520679
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KjwKiaU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BD520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEF76E480;
	Tue, 24 Nov 2020 15:32:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56C56E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 15:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Iwf8dFfSRvjsRyBsdjAr5/XPp1hDl57RoIAbA3QZkb9SI35JcUvps/7vA2sIZDpxxAC3NQEj1oa48gRjbrlikPkzsXF6muHyIkXYwDCMcobFmLQI1KAtvNOJROpNNvsgOqKXrKgMtnd8SnBpX5srQPCpag06tXhb2TG98UeF11xd9x0wxHF6FEKudfwDbjXkCzr4J45sbZKiUg0LRpFaPFlDlL/isgcgWXBnFwoNlICD+IVDqI4ybGcFIjVB8XRrXUPdN0DRB8yNEtUe2no8MyHIoxWaNpCtqrU+5UBw023fRd2tbVlzkv8YL7cr4RXZvZAkqWgc4dU+oeUT2ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo8Cq0aytBDOXlHBa5gk9FoxIS+Gf4hyrCaGZzBBEv0=;
 b=YDvb5yl+LJQezRfN2SZRJm+wAfgesXppAFKj0DhYwN19jcwqaxpg34LB6Iy+a1hHfjR9/588omNX5+63rQ2e9R0p6a/Q0ieECZWR5Ma80bqZj5FO0GKZrl2BxJnn0aVLW0yWgv7njG76VnYOOkUAk63bUpQwBixnPn77SDJ2XBnEnpCWvf48XaCAQwdkVG8AmqeGqYYljqU/qGp59XdRKEKCfHecB3lIrbFWPSMitr4o8X0MqUpszqrDRPW59hIIAjEx+74h3q0hqY929JJcHMaqy7hhmpTrvJm8YopfiI+LIm12T5C1iL0zNUEQyaRl6HSySFeA+/ZfKrE+Fs+ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo8Cq0aytBDOXlHBa5gk9FoxIS+Gf4hyrCaGZzBBEv0=;
 b=KjwKiaU5qiOYLUgtae5b0qcjIqAnTcNZnhJgnwoTg05upK0hzawdtw34FWx4s1lXPle6cFzyM2mw5iTAOorxWk6H6nmHU4ZIqMpbzmPYnjwI7JmRhVgjGHWEyVhkmSWGt57tOLRV4B47fdbWQqLrzdBgILGRe6qXa5PYJbpiG2g=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 15:32:27 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814%6]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 15:32:27 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf
Thread-Topic: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf
Thread-Index: AQHWwb3GwNUebR83VE2fgUucLpj8ZqnXahDA
Date: Tue, 24 Nov 2020 15:32:26 +0000
Message-ID: <DM6PR12MB3835E2345150FD342B5D4E76F4FB0@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20201123172455.19789-1-shaoyun.liu@amd.com>
In-Reply-To: <20201123172455.19789-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-24T15:32:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d2bcbb4-75a4-4041-9df1-00007f05b55b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-24T15:32:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 17224dff-8d0a-4221-9b58-00009e84c6cf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:79ed:a3bf:618b:1760]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7471c59f-ee0c-47e1-3e22-08d8908e2667
x-ms-traffictypediagnostic: DM6PR12MB3018:
x-microsoft-antispam-prvs: <DM6PR12MB3018F5D80AC09C047C37541EF4FB0@DM6PR12MB3018.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJ12t90vb6WbYQR7afMZBoLQn6Gy8Vr+au+hztNbpCql4b5lYFCr3/HXS43tmCf3yZgrVcnyHVSdXazj8AQ/3dMEasppzSZ4nxRS4SYqED90o2KoGUWsoMbMX2W0K9xO4mOdPGfuPXx+SiU5J8RMaK1X5CGxCUBd2iYd4fmHDO4OBSyBGqjoY6EtHTHgwxDMncmEFh94/Pin9GVkIjDnvERGi+nMiQFqJA5yOwH3IBvoUivloe+4pq4Wo7mtUmkp8HRswWC3VzEhglZnijOB6rYIfOR1JCFbb5YPCMkNSRNCCAeTKqOq5lO70frpNwUj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(83380400001)(478600001)(6916009)(71200400001)(316002)(86362001)(8936002)(52536014)(186003)(33656002)(53546011)(2906002)(9686003)(76116006)(66446008)(55016002)(66946007)(5660300002)(66476007)(7696005)(66556008)(6506007)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Cl9k059UiyNnkGpYybAUyjRYk4tbENjOAmfWbX36BNMbzRt0ocFcynhy3tsl?=
 =?us-ascii?Q?Vzqr55pNw63ba03vTKlgUuaygeE/x5dKU7sNvPQ84FiNIcXRIT4H7ES4uvUX?=
 =?us-ascii?Q?tCAIQJJp/sY60YFBTbo2ge7Wc4kVF0Ro6bNqvBt1fZzg3lEHXAGv0bW0ASyu?=
 =?us-ascii?Q?u8hubdd3+kymK9youbOR5AG9hBdlYpipoh1jYIuJlsiSmS8qE9gWUHZruHhF?=
 =?us-ascii?Q?SpNvxZLp+n5lvhLpxsV76m1OEbNkCrjDCK/xjFis1W5R/i85aL0t6XFsUnhH?=
 =?us-ascii?Q?BoISCbpDPEA64pvYnfTDBSAIkrjsi+mYVjo63CYYmwV6hOGtgbekmK5UgNJt?=
 =?us-ascii?Q?GT5cHuUh5gxkvelQ+u1wa+xWPHnfApNzQbxarMaB9FqEQZiDc55I9TRyG+4J?=
 =?us-ascii?Q?wh9jGn9e5o4eRJtgw2XoJSi0YuQMq/y1sXGHyXXlOfKL1EaVzU17A8iUTzUK?=
 =?us-ascii?Q?Tyhl3cu/D1agHFrSMzXSmBr3e2MbWmPweVyiiTfByUuYCJxU9Y66R1sgujd9?=
 =?us-ascii?Q?o8pxLSu7xMB5X14iK32tnqTjuti+4ryyfUOFNLns35T3vGb2hkOxT6GPFUoa?=
 =?us-ascii?Q?+BoL85InUmcA5KK8tbTWr7dKT5dZRAcRfwON2xwMDXUbKnOwAuX4PeJKRrM/?=
 =?us-ascii?Q?yv1j8Cr6GDVC8X/kuAuxlW9Z54L/fvJMWrKMhmDiyVoHyoNE5LxaxDQkm4fi?=
 =?us-ascii?Q?byyNVAG9/DCmeHRxS7W9m0Q4Gg5HukekeUhYLNF+v6VXKGHlHvFnI8zFq97c?=
 =?us-ascii?Q?E6AWDVR7t9AwxvWmXoYJWSR6OHVjEoWsTIAZzYGbxmFmabg2vEaufeybzciu?=
 =?us-ascii?Q?6abK3/l4YxaDtaAmTlPwJ+tQa8hkelw5fLpn3Uaw4UCci/87CRS/iz7UaP05?=
 =?us-ascii?Q?Z/dc9HaFeopPL9foDag61XReNTFwiuZsSBxaFAkIyw3jy/hU8p/PudtWHxq9?=
 =?us-ascii?Q?E/N817NQnD8iyhOrEbGVqw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7471c59f-ee0c-47e1-3e22-08d8908e2667
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 15:32:27.1634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlp5ipO0SiKoNCKxPYpyrkPgC6eOKHEWL967/D5vnwrD5WNIMtyiqrsyl+SGTPH8TN8UX9h9ScEtK8fpNDsXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Monday, November 23, 2020 12:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
