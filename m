Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4940AC4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1502C20752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DjjoQJc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1502C20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08F56E96F;
	Wed, 18 Mar 2020 21:29:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCEA6E96F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuuc+jjPF4W1XgMcmuQIH7BxlDrQ8En8PrqGCqtgHoMG8r3u6vDjviecI2bb623cEk5rVDSE3Zd7KXXiKSYaUwjo4tyyM5YqJYvBHfqbjPiChCnoagUAaw9cwQvAVkgFwGuxNXFAv3SCoRAh+Ii+f17K42xFc1fFnCbk+H8G1f5Q06sPfCH8izWkeGvRIyQaRkhN4m8l2QApq8FoLUeafvhTebglP0oeliaZmUHGIMfztIjRmyYB36A/8nCw7m1QCMxZCNnRWk8rzO9DXAn0Ly6yiaVy9X31ow/sBjgC4X21XmirkbVDob1R4ia7RDs70p+JSxZpmDcjUv/4/o+VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OvMxIObGLcM/EaFpMV1cTSAdnE8xJMXnnnNcYgwDOs=;
 b=QYNqQSDkIO8UnnLEjasl1eqBxXLouk7tHUaLWVlcW4KbJJqSro4pfpKRIIRRAPJJhGHsXpf0BNRAqNe4JSaxptSG3bI4xSYYF8s+TeGinFBXMP7G+A50E6RljkC47UChbpTKtBy7vvennIsA7XrCAk1+L2GsV0MDy6/E+lqUYYhiOz2ccJp/cQQHaW/atte+yvvqDglJCRsyd93yAlRxm8qMVXZaXK3SusQVcX2Rxg6LOiDuTiWBqCcGZDGcsC0rrsbwtmrwo9hs0YueVmSNZ3SyyjHrbzRlxclTBgnzO8E8mqU6beBixyhwr96QqfleyVNxGTg5/nAfIenZUuKiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OvMxIObGLcM/EaFpMV1cTSAdnE8xJMXnnnNcYgwDOs=;
 b=DjjoQJc6vHNKZOcy9OFy32ot8Bp9UBKHKPUp08SrEauzNwE9rjZlpV6URS9CPUY/bcCEBlls2guF8m3avlZUvfk5ttN608pKdC1i0ta39f9m/tAIjleGRsxH/M2pP/O/b7Txsp71bR+T71CvwJz+EDb8dph31BIG1xI+T34YOag=
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 21:29:47 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 21:29:47 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
Thread-Topic: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
Thread-Index: AQHV/HzNk99nGZnTIUyUsrs0ouq+i6hO35lA
Date: Wed, 18 Mar 2020 21:29:47 +0000
Message-ID: <DM6PR12MB32412071520ABF09642DD44CF4F70@DM6PR12MB3241.namprd12.prod.outlook.com>
References: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
In-Reply-To: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-18T21:29:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b439c43c-ffe1-4619-99ed-00002838ee86;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-18T21:29:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 419d917e-5058-43b5-a611-0000ad59e548
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-originating-ip: [2607:fea8:3bc0:316:518d:1a88:20b1:e657]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c6f3777-5071-4ff6-a4cd-08d7cb837c13
x-ms-traffictypediagnostic: DM6PR12MB3307:|DM6PR12MB3307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33073670F6F8F2ABD44587EAF4F70@DM6PR12MB3307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(6636002)(33656002)(66556008)(66446008)(64756008)(71200400001)(186003)(86362001)(5660300002)(66476007)(110136005)(52536014)(7696005)(6506007)(53546011)(8676002)(55016002)(81166006)(9686003)(81156014)(66946007)(8936002)(76116006)(316002)(478600001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3307;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvyqIp8Sa4lYREGVqoJkqnOf9AUt3xzPgyuZJFN9h3gdpws9QOY5OxyTZbhE0W9clLZ0F77VY2dplRdHP7hmv/Q90XVoEx2Cw7tUVIDyt8sBvMv7Zy5xnbT0T7XHbPwDibFpInlCTnkrQRWN6AgaiivkyHlLo9jvWGnkjMFjmjyeJlpOtK+i51pUbHzq14dgmgwGP+yPiACjZ+heKId/j9wohvWyRYBfL3EphJkKNLodxN6jCb5XdcEJ0u+MuWZ3eVFZkwP+pRbQJDADHUKhnNHtY9N5hjAcY84LLu4sLrq6OVLzjOtqkCRb5alUrtQrcr6HjB34v6d/8VBz5kUKxQGZQA7cWu6MRXHJ0wWIRMS0DJzGyYYyi7aT3EnJFzpV1jgTnFp0RT5fjY3u/811yXN3/0kDI0Hd+BSBgvVT2WwfpU31AbV2AwL1adMDejI/
x-ms-exchange-antispam-messagedata: XxbhnX610f9urpe3FWwjSe23mj2Pa9ZtbXnDU7VSHYuGT5UMOMpcdeJiwf9uzhJGt6FloDio/7PeesEac//wskUvvlgpoYaFhSRGU8NI5Go8epR+cpRwgUZ8eZbRhCVQbHsQC0eG5aLnPKqkTg2NwxrabuRF/GDSJotW3AcHdosRr9BSsb5FBJ4aTu5qfqfGe2ajqd6bRTGiWs3lD6x8Cg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6f3777-5071-4ff6-a4cd-08d7cb837c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 21:29:47.7871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64ORDy7ordUkmpNyLAQVNpF6GRs8+TkLDmQoWkuxJd7lvb6gTtVR0gftxp5izXrub86eAfiHFhivI20hLEfpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
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

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Tuesday, March 17, 2020 12:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest

RLCG is enabled by host driver, no need to enable it in guest for none-PSP load path

Change-Id: I2f313743bf3d492f06aaef07224da6eda3878a28
Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d1cdcb4..e134bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1940,6 +1940,11 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
 	} else {
+		if (amdgpu_sriov_vf(adev)) {
+			gfx_v10_0_init_csb(adev);
+			return 0;
+		}
+
 		adev->gfx.rlc.funcs->stop(adev);
 
 		/* disable CG */
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
