Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B2C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 06:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EAA2064C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 06:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H/oANzhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAA2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8360189854;
	Tue, 10 Nov 2020 06:32:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CB689854
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 06:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdDPfKGfDTYEalDrjPl+0m8k+PoPOJBXEAJLeY8WabM/WYsySwmXr2nA2K3RH1TgOy2ZEkNueBK2BClfDX9ypTLxYNmnv/cpWi1h3rC4dW7KsEB+pj/r8cEfqWcfBJ4Xymf029TXvjVC/LRnViMHrkbVPMrrMy3wiGJk257n+IG9NdwBF4+kd8Mw2JCqCd67F2D7c5+J6/vBrUbDjv4ab/+d5P1myJ0fLCTZ+m0sDqemmqDeQy6dd4EmD1mBDWPYXFSFUM05g7sNuA1EIBcfb/ZfsNugFRPP5Vn1mYTT8h04L3nZp9YIUvKJ5KPeE6ItQipe6o6GdfjR/7ap/qfsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8dB30+9gcrJoByGn3NrDF+lky3AiKIrJifvVyX9oEQ=;
 b=cBs59LnFL1wzqjNWTY4GFy8miajqSUHbpLWUPpN3c1FEaGm2KhYVnFD94D6lFVmijF19P7B5EElDT/yoUQlWkAfd55f3RYctkmWcETfaqOc2bqHDnGDrv+q9+iIQiHzN5fAf0rbo6qo20bVilDCVTlWvDF2QgDmgk4DDwaqRHfll2y8LhobkIt2Ihdj1dxzYFFKg9lCSDm32S0zcD0bUdj2EXVdW+HQqjwPscw0EVPp2A+pTADWnU5zhaoDAR5IiJ8bIFeybpjD0DJY8hrZ3mmR9Tvxyb1RlX194+GoVPb9O+rhA+z0aSlbIaRvS9wyo4vSkSMpQEOYnnAN8fkKjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8dB30+9gcrJoByGn3NrDF+lky3AiKIrJifvVyX9oEQ=;
 b=H/oANzhNDLXnoyKt8juWbMTT+XNftTtn7SCb6kGkbliSh4j0stbfCCGEFX7kpNFiVPLR1XRAshxW7AK4Y3+MCjbSg1JSagnzJUXd4RuhZuye0MZpasiUZLATjur2Rexg5ERvgeNV25nfZHNHeJ78FTVkUd33br+RW0LQxgUP5Fo=
Received: from CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Tue, 10 Nov
 2020 06:32:40 +0000
Received: from CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::5595:b2e7:9b05:c828]) by CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::5595:b2e7:9b05:c828%4]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 06:32:40 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update gfx golden setting for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: update gfx golden setting for
 dimgrey_cavefish
Thread-Index: AQHWtyr70DH5+Ylj4EiBviSuOCP3canA6CiA
Date: Tue, 10 Nov 2020 06:32:40 +0000
Message-ID: <CH2PR12MB4890C81A00F658FC326EA069EAE90@CH2PR12MB4890.namprd12.prod.outlook.com>
References: <20201110063012.22549-1-tao.zhou1@amd.com>
In-Reply-To: <20201110063012.22549-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0851bdc2-3594-4a70-87bf-9c4269579898;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-10T06:32:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d3b768f-8e61-47f3-25f9-08d885426c6b
x-ms-traffictypediagnostic: CH2PR12MB4024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4024D0EB69C8549C4D0743DEEAE90@CH2PR12MB4024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeywSJp5GBnTkSlVzdX7V0rVWVY5rkqRCE8AM58zh5HD7br1bWHYmCbNplcJ+/e6s21I0OQnAi9/AtPTxBexJQw/KJbSGAopOIaxUquIdYnDqUwkksLFE0OjPTpE4kZfFEINv1G9uSW1twoyj7YSAfvJGaR3+byAtxfz1Kz0szR5hZJK7HceNUUq3wGSEgKBq+TNj/bnDTVxWJCRoesI+6oQiONfSXdlH0/8os7U8w1LEY4ANm0O/4ZO15Ry325noz+e6uehAYVW9Jh4coxRKDxMOn5rWH7vayzWpi3OCTB/bl/IJmHUzMyk5T2P0lW8iZqQxO9fc9SGMVLQV0M9fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4890.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(53546011)(71200400001)(86362001)(6506007)(186003)(26005)(55016002)(66946007)(64756008)(66446008)(316002)(66476007)(66556008)(15650500001)(478600001)(76116006)(52536014)(5660300002)(2906002)(33656002)(83380400001)(8676002)(9686003)(7696005)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: e3sAB4SKMLUTCIidlWc/AynK0O8h7aPhCddzY76lnHHbmjgn1rMP3xhO+gf2wY+5n9Jd9DlZYBDw+afMm+oWhrr4VONvO99z6dTqBv/ZJrxZn4q7DHgk8RSx40NFKNs0ZbBSLxLta/NTybtLdNY1NJ/R3a0lXuuZS+7WBEbehq/5GJ3CUmR6htxSbbfkzZ5xSleEAlfuAsS+j81Xx6n/un1DxlAu8gAL5+RWTVp1vOJPcG0x8ciHk9PMUdpvLBMbNbYx6kiTv8n01AHiyYXsg8Lahov2ahEvNzAnXdq0mA4Z57tUMWMkt/2QEQ9r5/sjitC7UZHC3oE+0Wui9LzEgxPm5tNdNqCdQBbxp0qEhl+XdAcfO9elATxroQJtTP6nmQ/I4jEg0eSP5jR2c46SKrSsweqosW2Sr5rZk0MlQdxNLqWedsVlckHYrGBMBTTPOoTQJ8ttQIl1LQ+FVweJ9hD/fkQkEAUhHLRfjbJVODhXT7eO4cv/Rc14nKBKOrgPP6WBz6hf9ffVVQR/9eclCPXUWY/XicTn2TJoIrSlvdkXWPO88wiUocFoSY2AHa+4NdwVtRFq5XfWMyAY3N+vvWW3neE2aPsODjpBPE2KriKzBSXf00xIfOzdS0/MSgFApGVY1ffAfzifXu7go+AAhw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4890.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3b768f-8e61-47f3-25f9-08d885426c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 06:32:40.5087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RUSNnPrbeiWOOO2HXCK2pRrAba3VhBc7V/3SYauVkfSuGCv6XyM/OJPctwGxy5M0ibMZVJvAUyTZ0K5up/n7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
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

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, November 10, 2020 2:30 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update gfx golden setting for dimgrey_cavefish

Set LDS_CONFIG to 0x20 on dimgrey_cavefish to fix GPU hang.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8c3bad3dfc01..e068133aec71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3286,7 +3286,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
-SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000)
+SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000),
+SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
 };

 #define DEFAULT_SH_MEM_CONFIG \
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
