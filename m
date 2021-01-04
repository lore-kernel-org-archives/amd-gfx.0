Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFEAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 09:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE5620643
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE5620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F07489A77;
	Mon,  4 Jan 2021 09:39:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A76A89A77
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 09:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUJ36nIyF3aUAX34nWDOeA1Ast8TZmxrXMhpVUPM08i1QxEPE1LGqcHPg1g+FNWRp/tNDWF2Yv3BHGV3wpfYqVrPXIAa2tUiBXUgeD4yI0gKK3Xe1sF82s8RMRMyFMi4VbnMJdjbw9IegZhhygDWq6o9+QVG22+WKfpRWw4n1IpWDflNLtcjGvWMJoMkDJtfKET4j1DAtyJZuGb+kstdRouwEdQ5hAoZsyML4Jhlqz5tlSLlRniYE3ojX7UoWD2BNoORx4BAlEWhpkrac1xKCKL6SFSxYjfUkIC8ofCtOxJjMs8c3zU2H2GIaFr5BqP7madZGD0fNtdHnU6QYJbpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3L4cNph29oHgg3LJLVYcfVSB0MN8ltxzZlEQPZYrQw=;
 b=b3k4iLns7AKnODgHLJG/dUOpEuNBrhjlKbvK0MtMTeOliZsTj02oFdOLL+NuC7tUgA4WbNnPT4vU+4cgsKlFbNCTNyg550Lrcd6V1kmHUOfDVXYa0FBg9CigVUm/bMWiWuPxCs8iYZSk6EahYKlhB2l49mgpmuLDPtfD4DxiLXCNpBuuujgYlByebjUTU60vhSCQ8uyXH2J+6VvuGtfZydinMecN1iuqsTv9JWZPR5PyGsEKoTdMyQkOa0Gjfr6CdlykI+ZsPkoLxs7JvJTaCQO/T3/cMp0T+eTBYNB4pPojr2NYzh8R2yhynjOc+iKf64pYpC61+inCMyuXsqNwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3L4cNph29oHgg3LJLVYcfVSB0MN8ltxzZlEQPZYrQw=;
 b=qlfYVtgC8gThN0ep9wkbpx0yRafYUJLaLB+8H34XzHmpX8AZgie5XoGZi5TchNKmEe83tzQiOfpxcKYul/5QQJ+pDicchIFb4ATU/axdXMpjKkIRYDIfxyXc583UC0+EVJjJkbbB6WgATstI3w4B6iNPKZybyf4N7s4lzaKQDTw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.19; Mon, 4 Jan 2021 09:39:54 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:39:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove redundant include of navi10_enum
Thread-Topic: [PATCH] drm/amdgpu: remove redundant include of navi10_enum
Thread-Index: AQHW4ny8Jj+6e5M5AkOZSrfLPwsS56oXNggg
Date: Mon, 4 Jan 2021 09:39:54 +0000
Message-ID: <DM6PR12MB407503D765E6FA50CA3B0364FCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210104093328.113944-1-likun.gao@amd.com>
In-Reply-To: <20210104093328.113944-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T09:39:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9a7ae97a-c91f-4276-ace7-0ffe696f3485;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49f4c40d-af9d-45dd-8eac-08d8b094b136
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1707A3A8D951C3F810F1B126FCD20@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rm0h6LfbTEyVXvVvGMhHrduF8UNuL1IyNdGIK6Oo950Q0naJKWKe89YVoa7vVpOsjMoHQuM8Q02jOGwiMhurzYtHBVWB5YMjrUVk/UX/gEqynDT78o0GlWFVTGTNFHKTjWj1gnNbX3iUhSwX6uPm0QoGbyQjWVq2NRhv20r0gvgDpWUu3uSpN+dasUJjyuEgS3s3wxuISXFmlMVyTUuUpBjjnCcnaiwvIMb2y4Jq4T+kZ6/IHFeWK8I6Q5RLMHrWvg1+AnTKBGknaI0Wh+3MeQ0c795GgwUpb584aDvver1/fsgutPq2bnaQVQaUcGWlwGOPL7wWiSf4uF/Cc+bZbmHgqNVY0pQUVjxClWAcJDhOOBMZYEDfib2/x7M2hbtK4Fp1k+y730DEwJNucwSNGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(478600001)(53546011)(5660300002)(6506007)(8676002)(52536014)(66946007)(76116006)(64756008)(66446008)(71200400001)(66476007)(86362001)(66556008)(186003)(33656002)(26005)(8936002)(7696005)(2906002)(110136005)(83380400001)(55016002)(9686003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ocDxHTXxLKEzEBr5cKhEZ+ADGWQIoH9QF8A+oOlNpYyzKmgejhQ3MdLTOr7W?=
 =?us-ascii?Q?pzclwZXul05Jyb75x4o8+NUK6IxhVzlvM8L4CujGyYecnwpapFO6XT3gLoUk?=
 =?us-ascii?Q?z+xLiikaz+JMi0aTis6+6QRjz3Nkhbg0VUq9mYOtueMmEt5gw+zozQOC8xUo?=
 =?us-ascii?Q?t9hKt08GsETHUKchtdPhT/6xbOq7ufJhbu60NdUOz3SDJ8gH/oR9P/smgAm1?=
 =?us-ascii?Q?NsTC9hKgf01mLp4t/k/ppE2+FVGeTNwUvmWwg3roYK5sHm2ydBYjdsN3f+dU?=
 =?us-ascii?Q?ZDrIgdIBaVZ7Qcat1p0dBCc6tAy4OwuZjcliAm/rSp1YzoyhwJPpKcDgSHni?=
 =?us-ascii?Q?z14fyVFpUj2KQn4T7BwC0k3KDlAemGdOFfOsIk1WoySPkVtAyE7upnz4xBB2?=
 =?us-ascii?Q?AMrVXGVrEt8IWJ2kfQiRtBvoQuh30htTtp5Htb7LSHvfX5sDyeILg5qWxeoh?=
 =?us-ascii?Q?7nmHnrB8x9Zn5AWaI7+qrZ1gLPrMp+LG3fYL/x1ruIVAN12rAhg0KxGE0xcq?=
 =?us-ascii?Q?X6fsyk85IOKH3LOutgpwbrgUHA6BZfI1vSMppyN+5NQb8reiyDAskIPQHArP?=
 =?us-ascii?Q?+DmXMpjIjv2m6k7+bpK7y+fpFnUwiXvROo2D/qtmozbN9Vt93WPW0NZax6CL?=
 =?us-ascii?Q?BhmTz8Dv3ojKbfUkg9lna3Od+G+PCcN+18gAeJ+xcd2ASBE4GwlXFsKcuBfj?=
 =?us-ascii?Q?rO2bQ9JhyHNy/kVANI8gCa+2FD8Aoig4zbOxcEMnP7dGzvS9mJLurlI/g/IP?=
 =?us-ascii?Q?8FwLw90d7Cd95bUsdwHjIcWe/WJukNT8SVMFDivZljoqXw6jrSaP4JtpkaF0?=
 =?us-ascii?Q?oqWRawMOt798X9XK04LUv8dK06hKuKT+7EtF8/caMVeIfUhbn2ml8PrBbMJi?=
 =?us-ascii?Q?WJ4ALRXp4nbQ4LVUzCw8ZNnLcPGaskp3ayNRZgW48TSUWQPk6ag1N0p2UMxt?=
 =?us-ascii?Q?uux8bKS9hfGHjNtrPXQMCdGwn4wNV6Sj2cki7n/uQHuoylGbFa6UVz5Okl8N?=
 =?us-ascii?Q?I6HQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f4c40d-af9d-45dd-8eac-08d8b094b136
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 09:39:54.7168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZADTBo5MwuLja/ZisBEuRjYoAAxrMNLhbWeUSBjJrq+RyUmNEWXVLR9/Q+xanG2gC54RYxsM9XC+lTX1OXGetg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, January 4, 2021 17:33
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: remove redundant include of navi10_enum

From: Likun Gao <Likun.Gao@amd.com>

Remove unnecessary include of navi10_enum header file.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Id9697d0cf68339b3005b634ab5cf2f7bc39e47ef
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 1 -
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c              | 1 -
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c              | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 1529815838f7..fa7e8ff72dfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -23,7 +23,6 @@
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "navi10_enum.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 50016bf9c427..fad3b91f74f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -24,7 +24,6 @@
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_10_3_0_offset.h"
 #include "gc/gc_10_3_0_sh_mask.h"
-#include "navi10_enum.h"
 #include "oss/osssys_5_0_0_offset.h"
 #include "oss/osssys_5_0_0_sh_mask.h"
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index 921a69abda55..5b90efd6f6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -27,7 +27,6 @@
 #include "athub/athub_2_0_0_offset.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_default.h"
-#include "navi10_enum.h"
 
 #include "soc15_common.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index 66c183ddd43e..7b1b18350bf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -26,7 +26,6 @@
 
 #include "athub/athub_2_1_0_offset.h"
 #include "athub/athub_2_1_0_sh_mask.h"
-#include "navi10_enum.h"
 
 #include "soc15_common.h"
 
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
