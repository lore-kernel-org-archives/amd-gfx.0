Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE1C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F89B613AA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F89B613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CBF6F60A;
	Fri,  4 Jun 2021 14:56:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DAF6E9F8
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 14:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9kBh+YENPhmqkFKyYuqjvSBqCqbnHdMZrTpb1cHtNQ6SOFmdd1wyrB9TpuK8BSoKqkR0cLf0bVSZ8WrF4VnpvOeqlnBTLMXqpl6rpvIQpAjN7eHFgN8Z1rqvEAI6YkpeBYZkrRDPzSOaelTzSdyKxyDOtpJ+KVwtOOMCVlKEAAvXWBqOx7Ad89M4HwlKYn9sJu7HAWB3N4cqTlUn+pJiqsyXIy6GrNEzFuFWW8F79vvI41NyDe/0o3iV7Wf4C92dbhcD1YqXYEPhRGk6GZOXaDP8eyqWD3iUuo5G9bun7hzs6yMoOpmlIL+6SLXKmQ3m1hhCsFQ7znxmwe4vziXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/pmv7KoiiWE1jtKbxmFkxDvNT0k61ZSk/fWkEenJwE=;
 b=KdAaySgaQxskF7eBKGo7lh7izSvEI0RT7U4sysNRbyQXBGfKY/wW3xrhbmN6Gx7U4XZ8TaG/p6PRG1wShkPHF+opnWFgf29op4MkDMdAmBZ3K8083X34oXhpbYf/z8eINkboeITv8R3p0/Omh4N+uvqQ7mijRHfFo0QiPHVO6SuqiVm4wzrvZB2+gfdhfpEwdj52OAfEoviey0qyzmVsFHAuq8Kn1f9Lod60e90z+cRq1V1vjnrq+esz8SmSEJDfsJ732damzoFLYYyxRfCVI6FcUaPEV5XII1IOOGEhWOibldhUctjI5qeLSB/Udw7YCw3xuw5IgqMyKSnwig6fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/pmv7KoiiWE1jtKbxmFkxDvNT0k61ZSk/fWkEenJwE=;
 b=YO0v52jh0lTs7pPhnSnJHJ+ax2rPGTz2tuLSWE40hGgVePTECMWG85CNjmaQEH1Y4kY8wk3aEFJCkW4p3f1CQREH0azOo1LZNbxyJBQvr/ccY+0Hh7yNrukmR2DYutiDTfb8QEtLpDITDh//rI7d118KbfYcrpCN55zHFqRhh2U=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 14:56:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:56:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhou,
 Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna
 Cichlid
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna
 Cichlid
Thread-Index: AQHXWVDsoiagklZ7ZUmAgchpqKB3C6sD8JyQ
Date: Fri, 4 Jun 2021 14:56:25 +0000
Message-ID: <MN2PR12MB44881B6C3797944D77FC30E6F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210604144921.14764-1-rohit.khaire@amd.com>
In-Reply-To: <20210604144921.14764-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T14:56:24.976Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ebcaa82-33ff-4dfd-6e6d-08d92768ed2e
x-ms-traffictypediagnostic: MN2PR12MB4472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44726587AAFB65F0FFBB5E99F73B9@MN2PR12MB4472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftfUA4zd1uwfEIHDpE4dkfFLLvaVGwnLh1bod6penWQc4eglI3tYQXsWxYO5GSexFdQir5L594Mk+p2IDoizV8PJcdozwDxDzTjSJ8lF++05Lpp1RkSqPh6UQvmn4O1LyADCm8/rKhfR6jb54Wt2LxBnG5jbSdfaglbU2l0veTvhODax937St4yCcUuvBpl04IWlqJovIMgUMo7DBqHIaQgBvR9kqQ8ihboIfMxxxJoy1QnzwY2pnuyx0VZ3w/T7dNao9muwCe/WDB50hkM9sJ/S9uBMycdd4rdgcvjYkKsMRfeyTG8VrDZVP9cFLbjeX9NEtsOC1qVnhM5aQC1ei1ovvBvJqypEPmad0KuHqG7tHQ8tpmyJryWsieHpnm0kZ+x6ftMdyz3a31Py30Ox/XSKcNaxH/esI0l0swu+qXbXOQNrSkKIgFKsPxqiN+/omiePuI0oTkqGATmDMwq8id5W+4llJn86S6XbmU0Lhce5x3HP8gK+6cZTksFlTZFDbZAy8Vlfh604KB41t9x1mScurLK0qP9gI0lBDUGvGQWdiA+a5bZ/B4A76Zv2A7ndOr8S6MEf9UaBKR7Ya6urU0Un+nrp5cc1BPm5RVzC18AidzKJtcE2/TNjt//ftqFDZOCYJvl98zDBoUR3CXGRcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(7696005)(9686003)(6636002)(4326008)(19627405001)(2906002)(86362001)(55016002)(5660300002)(921005)(52536014)(71200400001)(76116006)(8936002)(66556008)(64756008)(66476007)(66946007)(66446008)(26005)(33656002)(186003)(6506007)(53546011)(122000001)(38100700002)(83380400001)(478600001)(54906003)(8676002)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gr5IupImBkpNdDE/GPBmMI/urqcVNIYTfjSG+oVkArgIPp7oKYBtRgtVZi?=
 =?iso-8859-1?Q?lG7j3szj8xODyj1IkrLdnDYozytHRKOGj0h3+auUk++PslaoUyoJGgnbky?=
 =?iso-8859-1?Q?xBIiiY/98o9rXK4eSdn7WE63xS2FevnEU1euZxMAcR1QuBFHC/AefO+OYi?=
 =?iso-8859-1?Q?QD/4PXh2dqavDdFCKgQ/sKitl1b4WWPaKmG1Z/q2Fk+LmxwIv9ENp1/uMt?=
 =?iso-8859-1?Q?nWolWF8f9WI+geueR0pcV1h/pWUNVT04buPghl1nruS5Lct/IGz/E7L1us?=
 =?iso-8859-1?Q?yg0/TKot550rYjdDwZGGC+whlqZfKrJcXKWKazyg5FgjsIu68NgS85qilZ?=
 =?iso-8859-1?Q?NiRoV6Lj/brRsXrkfBIiLtjqJhT1PKOSx5ZYmkgGqbyNHBnhSSCedTq9nY?=
 =?iso-8859-1?Q?9v7CYyLIrAdrvO1u3wh7irc15qf21sQzijCvnNn5YB9JBPb+rXTNyPuu0r?=
 =?iso-8859-1?Q?UmengsQwINmFxz3QesN5sHJG0dteiE4luZ7vwyWDQvYq31QOdMf6dBu6fB?=
 =?iso-8859-1?Q?ifUxUGmoaxrYNi/jMEjI/+LyQi6CHxAd4HZ1VtAasg79J5Iyy3jKD2HbBW?=
 =?iso-8859-1?Q?RBDAEXB547LymDpFZy2T2YVP4EnN8bDROjcbmRxigzdJ6HsIY+JRoO5hyP?=
 =?iso-8859-1?Q?G9hHsyB4PMHDcy8gLmzyLCimrxXE900wW9cFke0AvKJPLN/oLzZmKZAZMl?=
 =?iso-8859-1?Q?KfrMzMd6vU/pQNF7kdrCVzGvmsxXtrQGRjqq9HXgLYLoRaXIYWz0LoZt27?=
 =?iso-8859-1?Q?xVnXoatBKb19jW9rFIcpS3di+5Q+0WgK/EA6QkgPqWK+rUcj7BM7PFv8BE?=
 =?iso-8859-1?Q?icikz7QzSlTwPQb6YX/d+7whA9jHAP5CdWsHSf2f4WA8/jSlxYNacnPOnG?=
 =?iso-8859-1?Q?IMCaQCmQRs8elNt5vNCXeavo+tujm7pem6NRLCli1SZhp+xdCedKms6oYg?=
 =?iso-8859-1?Q?Bc8DHrW+nu6f5MEHloLqdsQNwonsRzvey4Oue20Ln0DkvkElzsKb7vQ1+l?=
 =?iso-8859-1?Q?g8a7c3lGiN95DKqZIrDxzlNqx1XWAqZvHmSbWsbk6BteMUJtEnZdO9hr4R?=
 =?iso-8859-1?Q?iuYpvNXgiVTY8CE0xvTwNbrtBpw2WpeXNaaau0ijRgEei120pK+99+6y6Z?=
 =?iso-8859-1?Q?rCSmMc1L/1GubKf24hJj07Ne2KBLCpP9eu4gSyhBaduehlHLEXvKbSe0M4?=
 =?iso-8859-1?Q?/Ilt+FSLrpeS+AQaRo4tcdLKSXJLsdiUx9WPFQO40RWkmZbFu0NMg12eeU?=
 =?iso-8859-1?Q?HlUla1KoK8BYUvOVgo2yZgGumwnVOeB3hepqwK6r+OtXD0Who96E2XcVeq?=
 =?iso-8859-1?Q?x40cCrCPkgbAASYyzo1DKnGa8IaQYpvTPAgNrYBNoXrLveYNPHirzM8lLB?=
 =?iso-8859-1?Q?tg4Wb5WjXl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebcaa82-33ff-4dfd-6e6d-08d92768ed2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:56:25.7009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvBC9o3IRZLRtr1VI3aUcU5sFUOw1euNfWA1+2zwGv4HRowWMENxQwKCA+Z2pWsde7y7sDqRCpb5GBY8KI4FBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1936630013=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1936630013==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881B6C3797944D77FC30E6F73B9MN2PR12MB4488namp_"

--_000_MN2PR12MB44881B6C3797944D77FC30E6F73B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

checks should be adev->asic_type >=3D CHIP_SIENNA_CICHLID so we cover other=
 gfx10.3 asics as well.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: Khaire, Rohit <Rohit.Khaire@amd.com>
Sent: Friday, June 4, 2021 10:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, =
Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>; Khaire, Rohit <Rohit.Khaire@amd.com>;=
 Koenig, Christian <Christian.Koenig@amd.com>; Khaire, Rohit <Rohit.Khaire@=
amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna Cich=
lid

RLC_CP_SCHEDULERS and RLC_SPARE_INT0 have different
offsets for Sienna Cichlid

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 11a64ca8a5ec..1e1ce1e49c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -177,6 +177,9 @@
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0

+#define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
+
 #define GFX_RLCG_GC_WRITE_OLD   (0x8 << 28)
 #define GFX_RLCG_GC_WRITE       (0x0 << 28)
 #define GFX_RLCG_GC_READ        (0x1 << 28)
@@ -1489,8 +1492,15 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, uint32
                        (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_I=
DX] + mmSCRATCH_REG2) * 4;
         scratch_reg3 =3D adev->rmmio +
                        (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_I=
DX] + mmSCRATCH_REG3) * 4;
-       spare_int =3D adev->rmmio +
-                   (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX]=
 + mmRLC_SPARE_INT) * 4;
+
+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
+               spare_int =3D adev->rmmio +
+                           (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0=
_Sienna_Cichlid_BASE_IDX]
+                            + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;
+       } else {
+               spare_int =3D adev->rmmio +
+                           (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_B=
ASE_IDX] + mmRLC_SPARE_INT) * 4;
+       }

         grbm_cntl =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_ID=
X] + mmGRBM_GFX_CNTL;
         grbm_idx =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_ID=
X] + mmGRBM_GFX_INDEX;
@@ -7410,9 +7420,15 @@ static int gfx_v10_0_hw_fini(void *handle)
         if (amdgpu_sriov_vf(adev)) {
                 gfx_v10_0_cp_gfx_enable(adev, false);
                 /* Program KIQ position of RLC_CP_SCHEDULERS during destro=
y */
-               tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-               tmp &=3D 0xffffff00;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
+                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sie=
nna_Cichlid);
+                       tmp &=3D 0xffffff00;
+                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cich=
lid, tmp);
+               } else {
+                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+                       tmp &=3D 0xffffff00;
+                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               }

                 return 0;
         }
--
2.17.1


--_000_MN2PR12MB44881B6C3797944D77FC30E6F73B9MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
checks should be <font size=3D"2"><span style=3D"font-size:11pt">adev-&gt;a=
sic_type &gt;=3D CHIP_SIENNA_CICHLID so we cover other gfx10.3 asics as wel=
l.&nbsp; With that fixed:</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: Alex Deucher &=
lt;alexander.deucher@amd.com&gt;</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Khaire, Rohit &lt;R=
ohit.Khaire@amd.com&gt;<br>
<b>Sent:</b> Friday, June 4, 2021 10:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, =
Monk &lt;Monk.Liu@amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;;
 Chen, Horace &lt;Horace.Chen@amd.com&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;; Khaire, Rohit &lt;Rohit.=
Khaire@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kha=
ire, Rohit &lt;Rohit.Khaire@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix incorrect register offsets for Sien=
na Cichlid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">RLC_CP_SCHEDULERS and RLC_SPARE_INT0 have differen=
t<br>
offsets for Sienna Cichlid<br>
<br>
Signed-off-by: Rohit Khaire &lt;rohit.khaire@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++++----=
-<br>
&nbsp;1 file changed, 21 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 11a64ca8a5ec..1e1ce1e49c70 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -177,6 +177,9 @@<br>
&nbsp;#define mmGC_THROTTLE_CTRL_Sienna_Cichlid&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2030<br>
&nbsp;#define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX&nbsp;&nbsp;&nbsp;&=
nbsp; 0<br>
&nbsp;<br>
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4ca5<br>
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 1<br>
+<br>
&nbsp;#define GFX_RLCG_GC_WRITE_OLD&nbsp;&nbsp; (0x8 &lt;&lt; 28)<br>
&nbsp;#define GFX_RLCG_GC_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x0 &l=
t;&lt; 28)<br>
&nbsp;#define GFX_RLCG_GC_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
x1 &lt;&lt; 28)<br>
@@ -1489,8 +1492,15 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, uint32<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;r=
eg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG2) * 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;=
rmmio +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;r=
eg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3) * 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_S=
PARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0_Sienna_Cichlid_B=
ASE_IDX]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_=
SPARE_INT) * 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg=
_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_idx =3D adev-&gt;reg_=
offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;<br>
@@ -7410,9 +7420,15 @@ static int gfx_v10_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_cp_gfx_enable(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Program KIQ position of RLC_CP_SCHEDULERS during d=
estroy */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_S=
OC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xf=
fffff00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_S=
OC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xf=
fffff00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881B6C3797944D77FC30E6F73B9MN2PR12MB4488namp_--

--===============1936630013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1936630013==--
