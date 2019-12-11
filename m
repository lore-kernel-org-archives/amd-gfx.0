Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C9C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6180220718
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4EX2GyHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180220718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4516EA72;
	Wed, 11 Dec 2019 03:29:07 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690052.outbound.protection.outlook.com [40.107.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAE06EA72
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 03:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyCtkL2Yx1FuaE3QQCC8zlsseVUBo+WVA8OsU7K5yaKYEa5WM5XCzSUUsm23LbA3aW7pbTnfL81NCewimm7SpLW+G41SinoDFw+2Ve3HWEc5u14u5S1yYmD4kFy/6n8j5mdhWBcQKLht7oddyeKsRa3Mg4bTGDds+hP+BHykjpZzLdBzuBDVKvaoCYqmBpGnH3plNdw4DNP1VpfqMyQAfRVdt854909M/cxhloyqgw92MVmk8i2oPUTT/Ot1m1gmBYcrj7eYvbszzE68WY0/aO1gOz0NPo+N+NHj9Pp70X8esyxyTm9vRYfh7o1eDNDjKyXrgJtbzOTIrxX3gAhHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORB+sJ71rwqkGUeoDJeR5m14BvDKHCjn7jDIOF5/7+E=;
 b=jDBjsEpsSJyHA6WftUZgh2+58sXcD8Wki8arL9OCxrwjbMQzKtj9crBssoCGc3/3LmMcxqde930tdVc2Ama11X6GpxhWiNvKjxtvf4QEzjSxR+gYB4rmOIS4blQA/u2FDB/gwV2SvCmXocR9v+LSXAozJCUyrPoavIYXtBwsALTL8JvWdENUvwA7L6wnvsa9xg5nkdU+fBq6jxWN0tyNqjPlCjoWBiuWMZJnOkhwHkyKX5o9KGaxbfQhrb3Cef1vEbGO7EGWVYh1oQPt+/dgZY7GQ9A8vi+O12CZZ/cbtlvIaOG5dRBSxF1tGegq7a2oCHHRkoZ9gl2te6hzlQy59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORB+sJ71rwqkGUeoDJeR5m14BvDKHCjn7jDIOF5/7+E=;
 b=4EX2GyHPWMRt2nQkXdbRB8kc6InIGTWasDyREQ/koAD6xdCYAATC1xMKa2vSktmBVcj31X2Bb4v96qa9wFjIAYz09e+no83mbY0eGBpgdjl3qNJSqsJBePOleva2bHSq4y5EPvPYGFtIZIHQlBQRAmJSzHzTgJMxV7UQYI2XGus=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB3839.namprd12.prod.outlook.com (10.255.237.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 03:29:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::2:bd39:2c33:115b]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::2:bd39:2c33:115b%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 03:29:03 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Thread-Index: AQHVr9IbJGV4FDkO2U6DdgLYboADjqe0Rpig
Date: Wed, 11 Dec 2019 03:29:03 +0000
Message-ID: <MN2PR12MB377514E6DB3BAEFDFE99C7D0FE5A0@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20191211032133.7882-1-tianci.yin@amd.com>
In-Reply-To: <20191211032133.7882-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f247370-fa74-4be6-1c1a-08d77dea458a
x-ms-traffictypediagnostic: MN2PR12MB3839:|MN2PR12MB3839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB383936CC253D9A8D0729A63DFE5A0@MN2PR12MB3839.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(13464003)(478600001)(55016002)(4326008)(316002)(9686003)(26005)(7696005)(6506007)(53546011)(54906003)(2906002)(71200400001)(110136005)(76116006)(186003)(86362001)(66556008)(33656002)(66946007)(8676002)(52536014)(81156014)(15650500001)(5660300002)(64756008)(8936002)(66446008)(81166006)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3839;
 H:MN2PR12MB3775.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pM6Rz7/ZOiBvvNn6TG9NnlqbDI9zpy64Kwn3JZlZF1Z1KpXmVleWUdjQnpe4DGF5Scz/rYQaHKh2sD+fua1ph1xrfBJUhlUuHJinIB6/FB7XSY93BFO4sQs/U73iyPcOPd8NcLSIfvOoHZkWAWeq48jfMQIJ4wK3SmQ1OlihMXIyPseqY4ZclsszGdU36eiQEu0x90fID4BVeIwXe2BsEmKa7H3+l3viJZP1vcCKXNGc0Wua1x+1TJfm56Vys3DwIoHzBVHRVB1RexZFT38tobx1C9WWa3iZEQ/BY9fMU4WEnGgzGd/+KYlKYK9ubbW7OuSezpYWJPg+9o03K2D2rXyCvYoJX5dNI6Moznd+Rv7CAZdZFIMgVFneDTVbQtNqL1iwvmARKS0okQ32pxLAWeGkjJSN41aVcK9iMEBtiffumymCK+G8AThGvCJAtsx3n0OhR/RNUDHB8bMoBd9QJzGnPVtuictYNG4rbfib3wrqS+4VLwB5Rgs61WQF1oGI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f247370-fa74-4be6-1c1a-08d77dea458a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 03:29:03.6793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5njztIcAbVYWB+X9G8IZiq3hSCzt00IRa11xHervBBshKHB3147bhoZHNbFVDT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Wednesday, December 11, 2019 11:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmSPI_CONFIG_CNTL

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ed630d37c32c..f3324fa4e194 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -114,6 +114,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
