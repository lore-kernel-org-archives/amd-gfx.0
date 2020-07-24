Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE62DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 08:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9062A20674
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 08:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r3VHXP5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9062A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1C16E029;
	Fri, 24 Jul 2020 08:43:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77676E93F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 08:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEg1+8S65WzyU/xE8z5PjI2U0UWCmQC4AXV99SqwtVlHTO89Z71LUCnKl29/2dd4SPcPBWGdityNgNqKf8FaCozB49iL4ADraBJdD2IIqBi4sLIheC2ZYdF+J9JZY/mBh+uRX/61ECZb1kI4VthBfAPehnwaDC5HQMNtx/W3gJUXqnkRSCh9xyCbsOMWp1HMppewAQg6SlJa2PoXMQYAjpMF/bFxQ6/UkJd/njYg+lz6S4I0Z3WWe4qG5riyLk4l4PtZkODlRvwDIZMXVudT+geq1zb5M7FZJ+s2wBOty89wDuaGGWpR1BYGExwszCXwBCJcAx/zGtokSAJiTW5SaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzmSImH4bGX3MEU8aNDQS6I5vOnIa86iPtqq7dvTrps=;
 b=eyOlO0MWa9ra6yUk42EEG328OWhNvTsrdShAFh8pEb5d9YRnSy8yICG+SyIFZfNxEGQ7dpEmXt3QbqGN3QdcwbaG2uCStkHK6lN8+aWcoSUdvImWZTcnvGD9YyTD5J7fCVXaEkFdg8mZTylOvbUYyT75ZJkSbBksQzhwdYkHUdKuTTvHqYx1Yd6algL+jJcWwDMLQqba0R+4kE10Z6d+A4L+VmjvQJWoEF+BfPmDcpw6h1ryFDbQwV/kKQg0z5ixIR9W+cYXspOkrMk/yG+aqVk8NZiD1gjj8YTsAsXlsggCjTefJP7cPjd6AyGcywR+Md2nAVJLbq2V9t314AJDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzmSImH4bGX3MEU8aNDQS6I5vOnIa86iPtqq7dvTrps=;
 b=r3VHXP5h9L5C1pfrTuCcZ0Sl2ZaHkr0B8tPnkTLFVGsvewR3UKpJMSwxvgCw3EcgljngAF5DvazGSYGNz85ETFh1iJtvXB9hSW/jhpe7I4U7gFiftjRrG+JOypTs/kcTC+rDYXBt0Ai8LjPoEuXzeM6OwNHLSWrABP2JHZ5HNNA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Fri, 24 Jul 2020 08:43:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Fri, 24 Jul 2020
 08:43:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: revise the outputs layout of
 amdgpu_pm_info debugfs
Thread-Topic: [PATCH] drm/amd/powerplay: revise the outputs layout of
 amdgpu_pm_info debugfs
Thread-Index: AQHWWbA8Qi1BOm9WCUWvnzxzBAnEs6kWeVxw
Date: Fri, 24 Jul 2020 08:43:00 +0000
Message-ID: <DM6PR12MB26194D468B2F6CD43C2C0866E4770@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200714072703.4122-1-evan.quan@amd.com>
In-Reply-To: <20200714072703.4122-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dd3eeff9-6996-4871-9a73-b5c2831421d2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-24T08:42:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbc33fca-eebb-4e8d-18c5-08d82fad926a
x-ms-traffictypediagnostic: DM6PR12MB2780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2780831E7AB0C6BA4D6C382DE4770@DM6PR12MB2780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4Y1GCvC4/f/5M3dlZLvF5pVJs1b4koSLLv8jmQSNgCH3M70byyEgjxGm3leC9C/0YWDCTCruJbAMvJGd7HBAhldRtrndvAZOkOUUF44OzVs4fcmC9PiN3Tsf2iUoqQgDbcA0QqMruqOTmC0DarTvLDsNo/yg1fH3Oj+RWp1TPZkJqHPGYKnLRU+rDiCO0WOe9Uy3CGnmWD9Xr1Y09BxRmxmny55fMRZmgvU/YjfqZ+nWytBQ7Y33J+FxYWpXVJLcSi2jIw0VpqAEKl3kOt52Ey46K1RPaJ36nAr7HINIWtUSuAZpfTV5ER0oVgkZVQkizsMsZRyDsK9lnSFYFCFDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8936002)(55016002)(52536014)(2906002)(8676002)(5660300002)(66946007)(76116006)(33656002)(316002)(6916009)(4326008)(86362001)(9686003)(53546011)(6506007)(26005)(7696005)(478600001)(71200400001)(66476007)(66446008)(66556008)(64756008)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EiUrwbmLQWVhIo9k0GALNIw9AbanReIiodgVLWgbwEw0CDP91DJ1j31G3FsQ1MoGjQomGzNL9jx+jAs+jC7KUFkbSbfuuweDRR//RdN1IaUjNDdWqtY8iBsUimluRXgclro/3hYHNjRB9qoiqiava5oa4WkMJuGJaQEttJHoFow+7ugGwD3PZM25Yxd4wd9Qid/dABvzlYnd+ywUx/b++HIkCckbTD5p+Q8E2OQjbDXAvMMbHeyq/iHbYlXT1Wf7uB1wbtFYxNsKckOiSjoz8s2byuIZEdp4vLdPoVu097oRnznydK1+0uIQj+paxLzIP4aJAjuqA783ctaFIVMpPp6N9NXGAPqusQc2tFQcjcf08LTc9fWG+s0Y//5GVpRjz38+V34J+SSkZ1Dmmlh9449Vi1w759TIdeYbbUrYZYSamxJPggXUi9Fs8MydldrxTv02DnNRJWrQ1/4gSLLdtYqfrPI29ExVkSaGkLew02GTM8haOGKJz6kjrmArVYjd
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc33fca-eebb-4e8d-18c5-08d82fad926a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 08:43:00.4140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mSjvMd7PSHIgnR943J2XJd6XfGZVvO4Wg/svZcz2T8IXprV6uPJC6SNeVGYv995
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, July 14, 2020 3:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: revise the outputs layout of amdgpu_pm_info debugfs

The current outputs of amdgpu_pm_info debugfs come with clock gating
status and followed by current clock/power information. However the
clock gating status retrieving may pull GFX out of CG status. That
will make the succeeding clock/power information retrieving inaccurate.

To overcome this and be with minimum impact, the outputs are updated
to show current clock/power information first.

Change-Id: Iff762d47ef0cc9ed309e805b1709ec8cb293d21f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 20f39aa04fb9..2d379c00c138 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3879,11 +3879,6 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 return r;
 }

-amdgpu_device_ip_get_clockgating_state(adev, &flags);
-seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
-amdgpu_parse_cg_state(m, flags);
-seq_printf(m, "\n");
-
 if (!adev->pm.dpm_enabled) {
 seq_printf(m, "dpm not enabled\n");
 pm_runtime_mark_last_busy(dev->dev);
@@ -3903,7 +3898,15 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 } else {
 r = amdgpu_debugfs_pm_info_pp(m, adev);
 }
+if (r)
+goto out;
+
+amdgpu_device_ip_get_clockgating_state(adev, &flags);
+seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
+amdgpu_parse_cg_state(m, flags);
+seq_printf(m, "\n");

+out:
 pm_runtime_mark_last_busy(dev->dev);
 pm_runtime_put_autosuspend(dev->dev);

--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
