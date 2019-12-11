Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17995C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 06:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13BE208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 06:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cW6GZ/SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13BE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FFD6E167;
	Wed, 11 Dec 2019 06:12:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702386E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 06:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX7UG6EIk/rqHAGZYAZM42HQXSub6LCvo2vm75lSvlExT3aFbD0qGU2D62ami9L1/L3csyO+sAU5zGPyzYtR9VoMVIh6F+LNJRuDfwiAeJxjtkZganIVSOUH+DfcKcHx+jrLZvDUtH08VBHV4Tj/mj3Zqot6fEqDz2EF5cT+PK6YVgM40YmLDLRCjFMwIH8IcUVoPgmkzD4Y9rl/+HKbGGx9/h0SjAkKo5TogWIMuQXK9TxJvb12Asr62ffvM7Q+jGu2i/x8JfwgCqorphWRLecKKJ/Ke1utjRrwRfd4qjwICGbH0frP+l377UxSENL4G2sinBC/3mCnjcSJQvHO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fEEFe6Edqu1iHt5bK2f2k3ATn5Jr0iuSCsf5IgAIQ8=;
 b=mHEyrZaPQGoLpzetJoaNLeliOYslc0ZoGezkncOFH4WqgNRkffTZSpA3FsQZD76VTyxdxS2rron3A37HfiFnR0N7xIC20pNHIXr8Xhw9/ewrNMo1vma2lFgaTOq60wE7nTS5DiUegXw9uTzRoASRJld737TwUKrrNyxWUoFoOerJlyDAlj7uvzqftGzNqyQ+yOcp9/BG9P/ewX+Ze9HgDQchJL8cxW8SaJi6a0EoTXmj8HRq93frWIWmjA7dzaR6vcUT8l9YdCIAeJIAo3TMrHRaD3fmR+lra35Zdo07q4z2ipVDB+YqwPgiFkCYjeNtr7xi4ldrOeo2mAeJLJU8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fEEFe6Edqu1iHt5bK2f2k3ATn5Jr0iuSCsf5IgAIQ8=;
 b=cW6GZ/SJudGVJCGOqDMzKjpibkHOJbo6ykus24StDql9CR5HaTcMErqfVfEnK0/bULqlBm18+AT0GaoEh4/k03K72okiUrnn9MDlWFz+lj7S9KWh1bzWU8/AYaT+mchPYJpyvHF1xrU/39oydX/F3yXPenccqFrSXfAzzNWwr48=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB3957.namprd12.prod.outlook.com (52.132.246.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 06:11:58 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421%5]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 06:11:57 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: update gfx golden settings for navi12
Thread-Topic: [PATCH] drm/amdgpu/gfx10: update gfx golden settings for navi12
Thread-Index: AQHVr+mTW4gjUa2j4UOxWFju0eWCAqe0c+Fw
Date: Wed, 11 Dec 2019 06:11:57 +0000
Message-ID: <CH2PR12MB3767CB23A233ECB7F5FCAE1EFE5A0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20191211060929.11648-1-tianci.yin@amd.com>
In-Reply-To: <20191211060929.11648-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85d01e0e-dada-4c0e-9044-08d77e01075c
x-ms-traffictypediagnostic: CH2PR12MB3957:|CH2PR12MB3957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB39579405DEDD9FB195F95298FE5A0@CH2PR12MB3957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(13464003)(199004)(478600001)(54906003)(52536014)(9686003)(4326008)(7696005)(86362001)(55016002)(15650500001)(2906002)(26005)(64756008)(8676002)(8936002)(71200400001)(186003)(53546011)(66556008)(66476007)(5660300002)(110136005)(66946007)(81166006)(81156014)(76116006)(316002)(33656002)(66446008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3957;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Q2UEOXOqbKq6OXIop32LCrMuE1ADYikpBg8zAgAKnYktzPGBJJPJd6hNtiCtqhPBYxUq6546YmXT90gnHyVv1bHfZKeDONuihvwhrgNt79i+rH21x0W9VOJ+8P4VQGYJyp8vjqSfY/5+3LflrrxlEHlZjvzbPlCM62I19roukJ+PfQ5MpTMaOFRkjCjvP99g/RjqqNzYmQWAp2/H9jsjEVVFMJ6NImZbzuXjfCvmeNU2fMGl2/JckC0KMvT+fqcbD+9gASFLEW7blytKIgzc4ye2c2oDCQbX8VNsU04e21dvAmDZGMfTja3xbif2u937d3LWzaa8s18+/5bkZvnvdDjOndBs5MX+sDAMx5boyRoto3v5qfuGK+f4t/EBvQSq6FkMb1lZ7PPgTZzF/LP8RmXiiIxZ2ALeR1hIa6b8k5DRN/6MpGLe+/jeisVHpsPdMImkYREbJeLNJfnyO5J6O5Fu543dKQvSkjgkShULVJKLq+lqJZJ6ySM6fvJ+o+6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d01e0e-dada-4c0e-9044-08d77e01075c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 06:11:57.7649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqZ+TF6/N7XFQ8rcbkTnUSTFcn8XYT4/KbiSPsn3cElN/4Z1QE7uaW2g57Hqyjdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3957
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



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Wednesday, December 11, 2019 2:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: update gfx golden settings for navi12

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmSPI_CONFIG_CNTL
update registers: mmDB_DEBUG4 and mmUTCL1_CTRL

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9b8bfb1c3c..557ebf317b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -185,7 +185,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG, 0xffffffff, 0x20000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xffffffff, 0x00000420),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04900000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DFSM_TILES_IN_FLIGHT, 0x0000ffff, 0x0000003f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_LAST_OF_BURST_CONFIG, 0xffffffff, 0x03860204),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff0ffff, 0x00000500), @@ -205,12 +205,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000820, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 
+0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0xffdf80ff, 0x479c0010),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
