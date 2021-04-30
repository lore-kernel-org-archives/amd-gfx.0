Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89004C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 10:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A15961450
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 10:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A15961450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE2C6E125;
	Fri, 30 Apr 2021 10:22:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1738D6E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 10:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6wMYljWae89Lb7iPYw5LfPuOOBo+kvixbiWrOHVN+0Ch0CfvzXrK3+0bzBPccPVatNcINRML/oSYSHzbul+X056+gPOuLYXjQZAr/3v8evHoH1E+BVCmR2JPqNyWza33HOsMYwrPBuGbMjWVXgRSOzeXXvbl1EMiBowoqMttLz3wFsJgi2U4fs0AVAzOSixwzdn+hx+zu3GHbkdXKdGXUuntYpDv33Qkvu97sF2kNK4rnFz48Ul2OR+kLolPUUQL74mnshUp8Q8fVH/GRQZpgmL+r2+O1oANDyJisYvW36iB7EqYUMrwehXmuO5+tkywM5oe8z1fyGM7zhTBtG9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eFxJG7F8kv9ars+QEF3yJhrRwNeDTTODETy1J3/2S8=;
 b=UFudBQ9cTQEAxZZlLJRRflpdy1XvxCJkJhIXUslMZbMLLud2oEVog5K65snMZYtUxdgLrB0g6qWulvphEJ2MYkV3URE31blnL8qi4Hznkp6NaPXeNiqJQvHlPBd+tprnOurC3tL/raZjn7CTGHg8qZ0hvOVzks7yAVnEo9UWjenM1iuNPEuFXdwFfA0mDNgNlz3kWdmHNLt3XNHMi9E+eq9fTI7DCJVFMDo836hZW7CmYdd9ZEM5IAEqj0L+1HIqkVyP12Lygv3sFlidA9g2sXDG08WKaoiobhdJZxdOyeImDOqMdPlUuhQJ7NvPitIkhyTQByIrem1CDb06Vt+wMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eFxJG7F8kv9ars+QEF3yJhrRwNeDTTODETy1J3/2S8=;
 b=RcMAFuDdis4rtahfEz/qO3GnmJGNoBzEsq0JveuMdG1YmXqWxHynUqbhrVufUtKEl33bGk0DsGwYUR8leDPKDLFLVpChnSsCE+kCXN1UoGrX/0E17tRR971y5Tgi7a0ZQGufK8Cg5Fi75FqpDzcX0lcWbTCJTZ5xN+v2KuOZh30=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 10:22:21 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 10:22:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws
Thread-Index: AQHXPY1XJr604KH6EE+nfPuxIOiNHqrM2e4g
Date: Fri, 30 Apr 2021 10:22:21 +0000
Message-ID: <BN9PR12MB5368F3B94DC194B8B6B56DE4FC5E9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210430065202.18115-1-Stanley.Yang@amd.com>
In-Reply-To: <20210430065202.18115-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-30T10:22:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c6c83e05-e7f0-4a3f-a99f-c0cecd235a4e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b08a53-a3f0-45fd-548a-08d90bc1d6fd
x-ms-traffictypediagnostic: BN9PR12MB5163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB516329D50CAD7321A01DFA5EFC5E9@BN9PR12MB5163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TX1mAYBeZlv5mtqfk8WuDMwJxNBm+0jNzSPERnGAStTuE1O4WtWyCFd70ZmP/FR/agg49XFkr7Y0jpOYcYe3fDgaMPJ1JNdCFQ9MnIMU97t3yw8A76A6GDcRXNZ9AUy7KiVI030jWsgAvFCMw1tvrvuQqBue7wJssDPX5WTIG/e/Ew1Nc/9deOjjFIcXeGJkEWL0dNQ3fvDwqvfTqHvt1hTD/0xEsMCcJ2lBttrIhyCfVjqhWwLfbH1efi5myHgk/ZMAtzBFYqGZm29fzj7xNoCm062E9x+b6P0hWEfZq/yq7dcJlZ3M80lVkhbqvVuSCbEhJfItcLB9KOl/HxsUxKrjmozLYJ8iJt3nP396k6NV792LFVJylVeyRk2uAw3vi6R8PDLbdtT6EEcmmUteC/hntz5L2zpjGSVqRmchgWmvJBe7vUVCh2K5mNZ/yDamzfn7RyGCXgvn2XF20v/1Dk669kpAlX2OksexG3Cou1KymZWYHTZ/zBKEq0HNtjdmPrzZIpuEq79cLtZ9zxe0CuJpZea5R/n2dhTvxBkaRjE1ui6Ek5LhL44BRhCs4R9g/871eUkUkVr3emkDHOwJcrc6BvMAYJwX51zPtWP6exU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(7696005)(6506007)(55016002)(53546011)(66556008)(2906002)(64756008)(38100700002)(66946007)(86362001)(83380400001)(9686003)(71200400001)(76116006)(66446008)(66476007)(8936002)(26005)(110136005)(33656002)(5660300002)(478600001)(4326008)(52536014)(122000001)(186003)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?brjapOvUfM7zQbMH0rv8SaNTOZxtRA9UjGW5Sb85TiUzuuh3U0mhmzzvlMx4?=
 =?us-ascii?Q?NQgF0MOKBAj+FSeKuRIifG6AEOQGPFDytcym4k4ZjB0zQ0Gln54q9dKKDUWF?=
 =?us-ascii?Q?Zvw6OvJOzNW0KFOjiAmGXKshkPf+HnwSL0o5Cv5GcgLJN9/pByDdB3WGWrwl?=
 =?us-ascii?Q?4YHwKbWPfI5TtX311bau8cdB+FbTIP0PmyRhOc6htCPjQiNtF4fCgMrBg+1+?=
 =?us-ascii?Q?jFWL1yjIE048Kz4XCS8tS/iyx+EMM/4eG79TO6G96bboCkShGACBztWaN2sy?=
 =?us-ascii?Q?wjF94iUKTHFqLQVZkFKy6YqR/e4nHQ8hLSkKmE1HT1+oYgVM7pNCx6psDV+E?=
 =?us-ascii?Q?izycR2EJSDiAZ3PD5IaEBGcYjab43jJMvf5FNIm4Z7NRQmdWiUuNzBHxSXE6?=
 =?us-ascii?Q?7xI8vGvA8SralA3QQT10m9Q+wpaOnaQFskCCAVpcp3KN1OiB+LNHZWhu5pXR?=
 =?us-ascii?Q?98Dm6qValrnH+J0z7QrJ8dWP7AazS6NXZHr4JFKLwWfhS/cDTG1sM/sUlq/e?=
 =?us-ascii?Q?0n1GuRGJI41++KylaSJ49CJpeBEhMNikg6CPUc3/zNPbU/3u6U0XgXPDb2ba?=
 =?us-ascii?Q?ud6OlAOmqMiSEjt3TBhwZLWSsWfvxjh+nDKv2v2aSMJhcAmaduM8Mh183XUy?=
 =?us-ascii?Q?M7gBUjOViWFH4WqzRso/fcmjIt8Uo7vFgk+vblVB0ZE1lhXD4sFL9YjnLS+v?=
 =?us-ascii?Q?J4dqvOH92tJS6qy5X59Jt8LzjIC7IC/880QwqhH18ybZl7JBzPdLSC2GJfrl?=
 =?us-ascii?Q?y4uCS9lsLzDRRzFUZlku0WpqnaV//wxHGeNeDA6t+IS8H1/54oJmg24LjO3q?=
 =?us-ascii?Q?IL6hzJ7QnDJncYCYXJV1Du0C6ivEckBbGHn4XFwhflPobdqySn4QIoLDRCH3?=
 =?us-ascii?Q?eKW5fU/LWu7fgPp7KKqXYRte/sbuGGjMnnpnQ7Z1gtNPHDUXx3qg35rHeTxC?=
 =?us-ascii?Q?IwOj1oyyczhoNA/UDhl8A7+KaWb3ju245BYcQbYItA8PfoC3vLvxRgGQ9oAb?=
 =?us-ascii?Q?gQfTDAu31BFR2FYOesonKcGwzs5yHlAFiack5hRr8ga8KY5v2SIeP7TSB2p3?=
 =?us-ascii?Q?moKlU4lqL8o4LbHN+7sDsUO/W+YVCwatj6bZ1HFSWNM8QhHcqvxtyYwaH6DC?=
 =?us-ascii?Q?HCxYXxgD9K2Ro9qOkDvbaGmYTbkY9WU9eF1DjuqurPt5IPseQE/p1lf37JK6?=
 =?us-ascii?Q?DxVTXbQn4w4EtX/EvJzeSV1kXcLWGz/8lfT5BYxQUhkvZ/o8dchgYJa6cUJ3?=
 =?us-ascii?Q?eAkzODSoM1WHeXc6mFf/8l09ihUvbZwlEnj0oPACoHc45Yvi1vDCUSG2UUuy?=
 =?us-ascii?Q?8I707gFyrrW9yi+YYCi8k6aB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b08a53-a3f0-45fd-548a-08d90bc1d6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 10:22:21.2518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tua9kKFWw4iCwJYgS35iksZcDPLXetaUbGMpph8LUuoGoX+1MbYeLyGS7se4gtHBz5Q50W4/LMyzA/e6vYYm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please remove the redundant aisc type check: adev->asic_type == CHIP_VEGA20. The board ID should be good enough for this case.

Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Friday, April 30, 2021 14:52
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index daf63a4c1fff..dfeaa57dd7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <asm/mce.h>
+#include "atom.h"
 
 static const char *RAS_FS_NAME = "ras";
 
@@ -2070,6 +2071,25 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		adev->asic_type == CHIP_SIENNA_CICHLID;  }
 
+/*
+ * this is workaround for vega20 workstation sku,
+ * force enable gfx ras, ignore vbios gfx ras flag
+ * due to GC EDC can not write
+ */
+static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
+		uint32_t *hw_supported)
+{
+	struct atom_context *ctx = adev->mode_info.atom_context;
+
+	if (!ctx)
+		return;
+
+	if (adev->asic_type == CHIP_VEGA20 &&
+			strnstr(ctx->vbios_version, "D16406",
+					sizeof(ctx->vbios_version)))
+			*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX); }
+
 /*
  * check hardware's ras ability which will be saved in hw_supported.
  * if hardware does not support ras, we can skip some ras initializtion and @@ -2112,6 +2132,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
+	amdgpu_ras_get_quirks(adev, hw_supported);
+
 	/* hw_supported needs to be aligned with RAS block mask. */
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
