Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F6C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5502B2072F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KZsYIk8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5502B2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFF16EA1D;
	Wed,  8 Apr 2020 10:34:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179FE6EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 10:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIwtVM+sY8Faysb7Gu1zPqbLMZQrj7tEP2HchdsjSQjqhW1ebmAnjYsrD/nB/iStNK6J/1vsX13i+qy1/bEfex3IuQRNkvTSRa0l/Xgk0GEjZSTmrGN5ERkkeMZtioCD1mG81HAGLWqJJCG6flIde5Kgr4XR+9QaKpFR+ZJibvn6ZNzBQ2wJpOixudNjuzDjay5Urp2NopkugwfS4wsw0/YwkX1HkgVK+ZVP0jpxaZzW7mzpG30DpolnsU8DmwAXwOmDjGrZinoOKahjmCMMYa4wIbmetw9AS6eSf/0d05cGsE+4RzReespRmJQESLEX4b6LEod88lcGs5frVbt3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+hk/7uQG/bLjg97H3coXQRz21hL0PatsCbQmBHSv3M=;
 b=bEK7EUU5InBRyXdOjQarAZpzuuiK4/NWcdXd+t+tMl78X1oa5/xyD1ZMhqt0fkVtRqNLa3lx304o3wVIgA0nj2eW5PqC7W6iZhY+uEPXqop7iP67QtFc383pnxH4Q9PoLaUMG793+cOwWlsCGwOsV0klLNpEwZR5u5sdSVKSbVEsoMmCoKITtxq52q72bay5eow00rYhUPatkjVafjGA7gs+y7OmseQ+ROtWsDiH+GoebLAq97h+xJg8Vvfg/CUeJehTFGgsughTsHgfrm06I7qQxG4i8sjpPl/SxDb9BsIYREB0EnnLo5gysnQkMWdoBsXq7Ck8U2h7B0W40s3YDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+hk/7uQG/bLjg97H3coXQRz21hL0PatsCbQmBHSv3M=;
 b=KZsYIk8UlAyoNMXWfo5Y4IkurVat5c5jBnRG76mpvBimIdTDnLnwJzEOH55dMi5DVN8FUynJUPJFLrpgN/0khz3SDr5+MVZJtiOozdVdeUpy2JeSVcdNeWGAKPL1+3yaNOzx1Hoq35phQ2mfD0Z5YWeUMur+yr+vyfMzrY0ztAI=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 10:34:40 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6%5]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 10:34:40 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
Thread-Topic: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
Thread-Index: AQHWDZEwkMLw9DEZf0q3eoCCfYVTX6hvB01A
Date: Wed, 8 Apr 2020 10:34:39 +0000
Message-ID: <DM5PR1201MB0204502394F9BB4F6B38FE8BBBC00@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03f33f6f-c7fd-4570-dc0a-08d7dba8717c
x-ms-traffictypediagnostic: DM5PR1201MB0252:|DM5PR1201MB0252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0252B3CF8C8336A2FA2DE321BBC00@DM5PR1201MB0252.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(186003)(316002)(6506007)(76116006)(7696005)(66556008)(66946007)(26005)(4326008)(81156014)(81166007)(8936002)(8676002)(66446008)(53546011)(71200400001)(64756008)(110136005)(66476007)(5660300002)(52536014)(33656002)(9686003)(55016002)(6636002)(478600001)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHHdclqijy5P8s74f0Is9vGbvRW4jCV9aH7JJMcvH+PS8mESTRl3NJI1hOUl1XH3WN/OgqLbEwV15mkk7kByt3dbMBfX8LGzrKfoyYdYQLMPrXc570p+/sIt6SrS/gkA2Z0xKNKuHVgo/0pWZGrNmpnuSQg9Bj3/aBeKRK8jNYXL0IJBIt3EKhmzTUda4Jo80SxBkA8xlj5zQgvRjGIYnpCfpyziIKEtS21LA2noRDEllinY7ghC2hV+ZSxiMfJs7Tet7PnIy9u731+dEF1mo1H8Gqp9ngykHY89YGJXAeQEQQMhj5FK0RvKxKXa/n9ADgScngcJTSU5Bos33mEjLq8UeQtDxcSmkomsV4r/LaqDD38h9dG0uvtOKX7UtrDzwYW1/N+N1FtJTtwB1E66uMJrzy9ahg0CEblz6dh4r5czKZ6BZVB26urN7c8WSY28
x-ms-exchange-antispam-messagedata: E4vcfz+bR9ep54jysldec+x/7EhHpQ0mSBpBlEwGZGFt4oMn+pdUXCfXSs6Gb2v3vPJvUo7lfgjLt7DgWmLM9MK1FswY2cDVVu2CG3iVbGB6jTNazTXvwrc+75F9ggbBCr1X+Ughd/82xshzfyrOLw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f33f6f-c7fd-4570-dc0a-08d7dba8717c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 10:34:39.9112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRupLyc4zcem36z7MmrZ/lgp8e1lh/8+7vKskdxDpbtNAQg5IdjPU3toEBKv0DJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Wednesday, April 8, 2020 6:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov move program of sq_config to PF

Since SQ_CONFIG will influence performance behavior, it's unsafe to program in VF. Therefore, program of SQ_CONFIG need to be moved to PF under siov. Skip it here in guest driver.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2d56b067..9bb89f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2575,7 +2575,8 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 
 	gfx_v9_0_init_compute_vmid(adev);
 	gfx_v9_0_init_gds_vmid(adev);
-	gfx_v9_0_init_sq_config(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfx_v9_0_init_sq_config(adev);
 }
 
 static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
