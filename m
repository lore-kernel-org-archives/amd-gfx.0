Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2DC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4473E207FD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Il3Krl2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4473E207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2AD88C90;
	Tue, 18 Feb 2020 11:48:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDFF88C90
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 11:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRjUOhafwIVwtrgGBjMoC7ysW1RYL/BgT6MY48lkDuLiLsPor1vhqCL6eiwMQ0zU/OpYTmqg1L82Wc6DwLaq0PpzqghEi2ego0rYVwuOf9XAflC2QC8+rhnf7PIAx4psViIGSHGzis+k/BPqOoVTTc64Ok8lAz3KZY2yrwC6VMo7AQVjdVY4IpZ1b70qiegjU3fmBGZaVkVCjJ6bJK6xa3Qg9rh4MFHtrWomxI2HyAa9P5sBHQBY0ZPzyEiF88K3K+dKnRX+PP5pZqA3ulWlRdbwdzc7PR1ye7v+lURFOmQlIoQp6fSBpTyN+INZ7lMM2/fSFzQn6FP/8s95sOZbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it+dbCg8qe0hq5zZitNkmbPgl1Nfx8eIy0gw+qlbFgE=;
 b=mWGQuvS92kcndiIibW/imBQ3daMnnz4V+f1fBBuDQ31bOcQLavHJaVYqCmt803+ODpwwnUcF0hRTRrY0YA+PZDMwvH25R4geqJ+wjH0fGsjBBeInYKrsRgtdNA5I2n7mprNWAWIegbitEx6Q6ts4wJYmcA9CP7q16jhKG9Uj991Y2OpqL+Mrfm4c80G00yKxx6iwOBPAyvou4c/tSKnX6dCqCxTwk22fSFl0sHm41uK+VNCtcXv3jrWB9k6z4lhPZPsSCE3fw+TrT+ZYjJ92cECuftpWDUDxjoUpqPHY0YILfESKQlamL+y77ZYx+ml9vfKRALnBP/lhlPimxTZrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it+dbCg8qe0hq5zZitNkmbPgl1Nfx8eIy0gw+qlbFgE=;
 b=Il3Krl2Xn6rgVKhHGupVQnyd+KsNRAAYZQ4WnQEZPh4vYGHvZAlDy4QCfEKl8CybpsKh2VYFExQLsUk/WMO8je+kojUC4Nxmdk60aI8AzraNO0gaHnmjC9nof77S2sBHjWndJ7hFCO4IxgXtDRdrzj7/Itp8CJkwyGAfk0bOb7Y=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1595.namprd12.prod.outlook.com (10.172.33.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 11:48:05 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:48:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: fix colliding of preemption
Thread-Topic: [PATCH 3/3] drm/amdgpu: fix colliding of preemption
Thread-Index: AQHV5ga+qm/dxZgP5kiIBw2U7aP4iKggzT0AgAAIv2A=
Date: Tue, 18 Feb 2020 11:48:05 +0000
Message-ID: <DM5PR12MB1418D0DB790F1CE215545BBDFC110@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
 <1581994453-5498-3-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418C6AC8DAC7F035AC2DCEBFC110@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418C6AC8DAC7F035AC2DCEBFC110@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T11:31:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39b9d887-b8d7-489b-af40-000004217956;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-18T11:48:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 138aa132-0bf7-4cbd-8efb-000031c17d5f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c00bb956-e924-463f-9d5d-08d7b4686aa7
x-ms-traffictypediagnostic: DM5PR12MB1595:|DM5PR12MB1595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15958BC29AF8A64555C491AFFC110@DM5PR12MB1595.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(2940100002)(966005)(6506007)(186003)(53546011)(66946007)(2906002)(66476007)(33656002)(66446008)(76116006)(8936002)(86362001)(81166006)(8676002)(81156014)(45080400002)(478600001)(7696005)(66556008)(52536014)(71200400001)(26005)(9686003)(316002)(110136005)(5660300002)(64756008)(55016002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1595;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxF70+s7HdIuDImR9UuO2rGJZwLfRXTKaZpvzfyzafEl6C+XoHMOjwJ1AWqaqbd5UyXHQ40xVhTEEJS9SRmIfABU0jo8JYGkmu2lqRvhnWI3+2zsHSfEKK+LQvjXsmB1xweh6IMHAcDb+Nao096gmxmw/fakm60MV3ZHZfKBf05LJqCxUcItF+W4mm8zijT0o2YTIaEaUIf8sXJ4+2120sKfhU4GmEmvC/77yKZIXh/TYg/+Aqnhz0/pyLpOSytPDelD17/KhtM28CrnanFTJR3+yDvVB2MAnhaf3UM+J7ikAI1WDeftEmjZNIe+YpJi2MhCkQAsQbNa+8WUNPKnPINjkqr96JCna8fr/TM2OCqjoXEpHXDc3SAxiEpd8kuBvZs9eAGPAGHdk0xw3IHymXcZXMv/v56fBzOiLRDnHU3/6WsVcPw32/WG4iAYAxMnZmZnBNl5TU9SIipbREhAVbhQvckwx02JoD3DC09nnR4At3dBuT6ieW6gneyksPq6ChWGNkd26d3kTeOkrRBuuQ==
x-ms-exchange-antispam-messagedata: Z8DOE8omWFmN+CwhwIubpgiP+d0l7TUpicS0XLGl8rgbhIdhd78Nlzjzc1kbQ2DD5lPSRsSwXGQduNEaJl6Hrh7BAKOkPhQCwg0+LYv1VqQwCRuwc/fvHoZym1dzqsFTvfb/gI6oZF5ciTimHjmvrg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00bb956-e924-463f-9d5d-08d7b4686aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 11:48:05.4822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJpb4ZAmdIwU5xCq8f7y8XoPS7VTsyxfthruFpb88rgSwniavdAL25yrGPv3ertSf/CHDfxDuEKK5xZt5xeRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ahhh.... Send it too quickly. Of course, we still need to apply vf check for ce/de-meta, but I think in such way, we can dramatically reduce the amdgpu_sirov_vf check in every mcbp code path.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Tuesday, February 18, 2020 19:32
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: fix colliding of preemption

[AMD Official Use Only - Internal Distribution Only]

It's some kind of annoying to check vf in every place that is required for mcbp until amdgpu_mcbp is enabled by default. What's more, when amdgpu_mcbp is enabled by default, there will be many unnecessary vf check that can be removed as most of mcbp function actually can be shared between world switch preemption and os preemption.

I'd prefer to enable amdgpu_mcbp for sriov in amdgpu_device_check_arguments to reduce the vf specific check everywhere.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Tuesday, February 18, 2020 10:54
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix colliding of preemption

what:
some os preemption path is messed up with world switch preemption

fix:
cleanup those logics so os preemption not mixed with world switch

this patch is a general fix for issues comes from SRIOV MCBP, but there is still UMD side issues not resovlved yet, so this patch cannot fix all world switch bug.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index a2ee30b..7854c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -70,7 +70,8 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 	uint32_t index = 0;
 	int r;
 
-	if (vmid == 0 || !amdgpu_mcbp)
+	/* don't enable OS preemption on SDMA under SRIOV */
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
 		return 0;
 
 	r = amdgpu_sdma_get_index_from_ring(ring, &index); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e9fb09..7b61583 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4413,7 +4413,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & 
+AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
@@ -4421,7 +4421,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
 			gfx_v10_0_ring_emit_de_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? 
+true : false);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -4569,9 +4569,9 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,  {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_mcbp)
+	if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
 		gfx_v10_0_ring_emit_ce_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? 
+true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Ca7e465ef5e31462f53bb08d7b4663103%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176223323017983&amp;sdata=wE%2FWt31a6tCmc9Tt0uHMC1S5XePnAgUFNSlXRDP1oSE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Ca7e465ef5e31462f53bb08d7b4663103%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176223323017983&amp;sdata=wE%2FWt31a6tCmc9Tt0uHMC1S5XePnAgUFNSlXRDP1oSE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
