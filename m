Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB740C54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DA720719
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QD4NY9FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DA720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2A889F53;
	Wed, 25 Mar 2020 03:12:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7258C89F53
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/sD1UXF7JQlV6EDRsu+lT6W0qH7W3sz0FwyfW5sTJG3abvHFFItC7DDwjdvrNu23Xwlw38DmHUx6ie7IQZP3rtiOJG47GAREeDtixiDlz57ojV6gxzohv2GV5/LuvTb/b0/mKdiHxYufme1qas5qHfSx7eYo+1BmQoeXpLvK2hQVdv73MEvKB2raSilWscZFwptJnVyeaqECcV+2oN7vdHbw4ssMBMVI1JjLd71v7HbbDt3NQPYiuMSuxwBypwGGk/ZvJ1IuoHvXKeRp6j4T2enukcjMvH3K358kOAhBRRO71ehY/Knjp7Dyu/TTLRWtkbONEAgFsz9eiYpolUYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwcpZTsWNPOFuNEM+h7z03+R/RgoSJB6fdiNfqPa0L8=;
 b=XztH6DO6IGD4QXgUPhA/omnfZAWTR/dWhIq5cPIrq5z+wLWBZcEk9hPC+G5HEkhEvqyjFT868eFEuy2nuBiCALupXHySrhm3ztWBP2pLOiWegvzivhm7YwdrJhYDX8rZxuWLdl3hXLC2wO/F6OO5mjQvc05npqX8UUZkmseJ8wcl8/yp61WtcIydmOO76GtFsE7XwqikuMyNhyRVbACEI8BNMLfvAPgr+zM/yrEdONUfzXBOjgMVp2EBc1jOPseSscCo2sqhb1BvLpKDgIH6+nOsHHKHAFtYrLn8T764MOCt6hzwcVJ0YlkV/lQJ05wa/EVTWVhiDm71raVwkwI5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwcpZTsWNPOFuNEM+h7z03+R/RgoSJB6fdiNfqPa0L8=;
 b=QD4NY9FN0AF0JMvuMxWXfj1YP4YhSgxPW0JsA1OXjivtJ4MsK5VmJOCSU4i807zCRi0IB5aL/77DHtNWzpul41jz3v1P/P0wbkkIxe2qa+gFdxaW86bc2w5fNyamQjakNKQsORY/HUyjqOvZCMeJGHHv6rHyN/9aEU+O9LzqT9k=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 03:12:06 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028%3]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 03:12:06 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: cleanup all virtualization detection
 routine
Thread-Topic: [PATCH 4/4] drm/amdgpu: cleanup all virtualization detection
 routine
Thread-Index: AQHWAcs/0cl2ccG4tUu/Ba48oDV2Z6hYopTA
Date: Wed, 25 Mar 2020 03:12:06 +0000
Message-ID: <MN2PR12MB29754BAD15039EF64C43CF658FCE0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
 <1585047533-10966-4-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1585047533-10966-4-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T03:12:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dfe622f5-0564-4297-9a2e-00000faefee5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T03:12:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f1b41ebd-443f-4521-abb9-0000d8e535cc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5980ac3-8fa2-4ded-c14e-08d7d06a4c78
x-ms-traffictypediagnostic: MN2PR12MB4408:|MN2PR12MB4408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4408ACFB043CCAA61ECAD3738FCE0@MN2PR12MB4408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(33656002)(6506007)(81166006)(26005)(5660300002)(81156014)(52536014)(71200400001)(86362001)(8676002)(8936002)(9686003)(7696005)(55016002)(76116006)(66446008)(186003)(66946007)(4326008)(2906002)(45080400002)(110136005)(66556008)(478600001)(64756008)(30864003)(316002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4408;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lM+KDNal569iOdlsbD/iwVhvlJyecuJo7I7rrJf+SeBR/qmw6NQRdGrN7uhSqHDtwCwkkCcv/+tFvkQRoYIS4G1KCsOCyFqIjyUv5vpKa7ycq2+tg1hO6aMo/QMaIw3pAY0UDNqf6INHtnM7lazrTBCd7XzyK/vCZCIv/v/XVlzvb78gb9YDzuGBYS862Jl+1+OG/upKM6lBesFhiODJNoIddoSj22l6VQvvjlrpGiGTW/KGbcA/9FALP8w6lbytBm8g6RFad4zTR7AC8GClaz/8VtHDXja1yvr0lUPtBJwpOqm2hp6CJdNWXXzIjP7Bjjc1hhrT4H4T3BDgN1qovHdXB611C5+MNhdn8OamnrDfDOY6J6z0fXR7IO3PKfYx47Snm8rWP9N0FrbLLKvR9oDLyAuHjXcUZGKUad0WgNLqdratH8xaMIjneP1kruWUoaVerVMVGyHaUbCvht4bkZ9kcGHJs5t7kwQqku4bTvY=
x-ms-exchange-antispam-messagedata: HTRt5FVE1x3AcaAaJfX6zVsQPDwXiFy1QUm4TCpzoBFZ2ybrlBx9lxR0SaqG2G8elA7dw6HHQCdGcnDfLbRBtb2QagEkQAM6epZRuKijZsAcAaoaDzjsugwCD1ryTDNItSIYMB7UAscslUH3wpW2bQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5980ac3-8fa2-4ded-c14e-08d7d06a4c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 03:12:06.1739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JarGLdDE413L/UjAmKxCSda7wZ8mNPRzH+dYst6O0yYhsIXcSJliuHF2Vd5V7lZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Series Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
>Sent: Tuesday, March 24, 2020 6:59 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH 4/4] drm/amdgpu: cleanup all virtualization detection routine
>
>we need to move virt detection much earlier because:
>1) HW team confirms us that RCC_IOV_FUNC_IDENTIFIER will always be at DE5
>(dw) mmio offset from vega10, this way there is no need to implement
>detect_hw_virt() routine in each nbio/chip file.
>for VI SRIOV chip (tonga & fiji), the BIF_IOV_FUNC_IDENTIFIER is at
>0x1503
>
>2) we need to acknowledged we are SRIOV VF before we do IP discovery because
>the IP discovery content will be updated by host everytime after it recieved a
>new coming "REQ_GPU_INIT_DATA" request from guest (there will be patches
>for this new handshake soon).
>
>Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |  1 -
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           | 33
>++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |  6 ++++
> drivers/gpu/drm/amd/amdgpu/cik.c                   |  8 ------
> drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             | 18 ------------
> drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             | 18 ------------
> drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |  7 -----
> drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             | 18 ------------
> drivers/gpu/drm/amd/amdgpu/nv.c                    |  2 --
> drivers/gpu/drm/amd/amdgpu/si.c                    |  8 ------
> drivers/gpu/drm/amd/amdgpu/soc15.c                 |  1 -
> drivers/gpu/drm/amd/amdgpu/vi.c                    | 24 ----------------
> .../amd/include/asic_reg/nbif/nbif_6_1_offset.h    |  2 ++
> .../amd/include/asic_reg/nbio/nbio_7_0_offset.h    |  2 ++
> .../amd/include/asic_reg/nbio/nbio_7_4_offset.h    |  2 ++
> 16 files changed, 48 insertions(+), 105 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index e55dbcd..ca609b6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3057,6 +3057,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> 	if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
> 		adev->enable_mes = true;
>
>+	/* detect hw virtualization here */
>+	amdgpu_detect_virtualization(adev);
>+
> 	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> 		r = amdgpu_discovery_init(adev);
> 		if (r) {
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>index 919bd56..edaac24 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
>@@ -77,7 +77,6 @@ struct amdgpu_nbio_funcs {
> 				      u32 *flags);
> 	void (*ih_control)(struct amdgpu_device *adev);
> 	void (*init_registers)(struct amdgpu_device *adev);
>-	void (*detect_hw_virt)(struct amdgpu_device *adev);
> 	void (*remap_hdp_registers)(struct amdgpu_device *adev);
> 	void (*handle_ras_controller_intr_no_bifring)(struct amdgpu_device
>*adev);
> 	void (*handle_ras_err_event_athub_intr_no_bifring)(struct
>amdgpu_device *adev); diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index adc813c..43a1ee3 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -287,3 +287,36 @@ void amdgpu_virt_init_data_exchange(struct
>amdgpu_device *adev)
> 		}
> 	}
> }
>+
>+void amdgpu_detect_virtualization(struct amdgpu_device *adev) {
>+	uint32_t reg;
>+
>+	switch (adev->asic_type) {
>+	case CHIP_TONGA:
>+	case CHIP_FIJI:
>+		reg = RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
>+		break;
>+	case CHIP_VEGA10:
>+	case CHIP_VEGA20:
>+	case CHIP_NAVI10:
>+	case CHIP_NAVI12:
>+	case CHIP_ARCTURUS:
>+		reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
>+		break;
>+	default: /* other chip doesn't support SRIOV */
>+		reg = 0;
>+		break;
>+	}
>+
>+	if (reg & 1)
>+		adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
>+
>+	if (reg & 0x80000000)
>+		adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
>+
>+	if (!reg) {
>+		if (is_virtual_machine())	/* passthrough mode exclus sriov mod
>*/
>+			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>+	}
>+}
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 0a95b13..74f9843 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -30,6 +30,11 @@
> #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass
>through for VM */
> #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access
>mode */
>
>+/* all asic after AI use this offset */ #define
>+mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
>+/* tonga/fiji use this offset */
>+#define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
>+
> struct amdgpu_mm_table {
> 	struct amdgpu_bo	*bo;
> 	uint32_t		*cpu_addr;
>@@ -305,4 +310,5 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
>unsigned long obj_size,
> 					unsigned int key,
> 					unsigned int chksum);
> void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
>+void amdgpu_detect_virtualization(struct amdgpu_device *adev);
> #endif
>diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
>b/drivers/gpu/drm/amd/amdgpu/cik.c
>index 006f21e..db68ffa 100644
>--- a/drivers/gpu/drm/amd/amdgpu/cik.c
>+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>@@ -1811,12 +1811,6 @@ static uint32_t cik_get_rev_id(struct amdgpu_device
>*adev)
> 		>> CC_DRM_ID_STRAPS__ATI_REV_ID__SHIFT;
> }
>
>-static void cik_detect_hw_virtualization(struct amdgpu_device *adev) -{
>-	if (is_virtual_machine()) /* passthrough mode */
>-		adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-}
>-
> static void cik_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring
>*ring)  {
> 	if (!ring || !ring->funcs->emit_wreg) { @@ -2179,8 +2173,6 @@ static
>const struct amdgpu_ip_block_version cik_common_ip_block =
>
> int cik_set_ip_blocks(struct amdgpu_device *adev)  {
>-	cik_detect_hw_virtualization(adev);
>-
> 	switch (adev->asic_type) {
> 	case CHIP_BONAIRE:
> 		amdgpu_device_ip_block_add(adev, &cik_common_ip_block);
>diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>index f3a3fe7..cbcf045 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>@@ -290,23 +290,6 @@ const struct nbio_hdp_flush_reg
>nbio_v2_3_hdp_flush_reg = {
> 	.ref_and_mask_sdma1 =
>BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
> };
>
>-static void nbio_v2_3_detect_hw_virt(struct amdgpu_device *adev) -{
>-	uint32_t reg;
>-
>-	reg = RREG32_SOC15(NBIO, 0,
>mmRCC_DEV0_EPF0_RCC_IOV_FUNC_IDENTIFIER);
>-	if (reg & 1)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
>-
>-	if (reg & 0x80000000)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
>-
>-	if (!reg) {
>-		if (is_virtual_machine())	/* passthrough mode exclus sriov mod
>*/
>-			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-	}
>-}
>-
> static void nbio_v2_3_init_registers(struct amdgpu_device *adev)  {
> 	uint32_t def, data;
>@@ -338,6 +321,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
> 	.get_clockgating_state = nbio_v2_3_get_clockgating_state,
> 	.ih_control = nbio_v2_3_ih_control,
> 	.init_registers = nbio_v2_3_init_registers,
>-	.detect_hw_virt = nbio_v2_3_detect_hw_virt,
> 	.remap_hdp_registers = nbio_v2_3_remap_hdp_registers,  }; diff --git
>a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>index 635d9e1..7b2fb05 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>@@ -241,23 +241,6 @@ const struct nbio_hdp_flush_reg
>nbio_v6_1_hdp_flush_reg = {
> 	.ref_and_mask_sdma1 =
>BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK
> };
>
>-static void nbio_v6_1_detect_hw_virt(struct amdgpu_device *adev) -{
>-	uint32_t reg;
>-
>-	reg = RREG32_SOC15(NBIO, 0,
>mmRCC_PF_0_0_RCC_IOV_FUNC_IDENTIFIER);
>-	if (reg & 1)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
>-
>-	if (reg & 0x80000000)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
>-
>-	if (!reg) {
>-		if (is_virtual_machine())	/* passthrough mode exclus sriov mod
>*/
>-			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-	}
>-}
>-
> static void nbio_v6_1_init_registers(struct amdgpu_device *adev)  {
> 	uint32_t def, data;
>@@ -294,5 +277,4 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
> 	.get_clockgating_state = nbio_v6_1_get_clockgating_state,
> 	.ih_control = nbio_v6_1_ih_control,
> 	.init_registers = nbio_v6_1_init_registers,
>-	.detect_hw_virt = nbio_v6_1_detect_hw_virt,
> };
>diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>index d6cbf26..d34628e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>@@ -280,12 +280,6 @@ const struct nbio_hdp_flush_reg
>nbio_v7_0_hdp_flush_reg = {
> 	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,  };
>
>-static void nbio_v7_0_detect_hw_virt(struct amdgpu_device *adev) -{
>-	if (is_virtual_machine())	/* passthrough mode exclus sriov mod */
>-		adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-}
>-
> static void nbio_v7_0_init_registers(struct amdgpu_device *adev)  {
>
>@@ -310,6 +304,5 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
> 	.get_clockgating_state = nbio_v7_0_get_clockgating_state,
> 	.ih_control = nbio_v7_0_ih_control,
> 	.init_registers = nbio_v7_0_init_registers,
>-	.detect_hw_virt = nbio_v7_0_detect_hw_virt,
> 	.remap_hdp_registers = nbio_v7_0_remap_hdp_registers,  }; diff --git
>a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>index 149d386..41c53c1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>@@ -292,23 +292,6 @@ const struct nbio_hdp_flush_reg
>nbio_v7_4_hdp_flush_reg = {
> 	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
> };
>
>-static void nbio_v7_4_detect_hw_virt(struct amdgpu_device *adev) -{
>-	uint32_t reg;
>-
>-	reg = RREG32_SOC15(NBIO, 0, mmRCC_IOV_FUNC_IDENTIFIER);
>-	if (reg & 1)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
>-
>-	if (reg & 0x80000000)
>-		adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
>-
>-	if (!reg) {
>-		if (is_virtual_machine())	/* passthrough mode exclus sriov mod
>*/
>-			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-	}
>-}
>-
> static void nbio_v7_4_init_registers(struct amdgpu_device *adev)  {
>
>@@ -561,7 +544,6 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
> 	.get_clockgating_state = nbio_v7_4_get_clockgating_state,
> 	.ih_control = nbio_v7_4_ih_control,
> 	.init_registers = nbio_v7_4_init_registers,
>-	.detect_hw_virt = nbio_v7_4_detect_hw_virt,
> 	.remap_hdp_registers = nbio_v7_4_remap_hdp_registers,
> 	.handle_ras_controller_intr_no_bifring =
>nbio_v7_4_handle_ras_controller_intr_no_bifring,
> 	.handle_ras_err_event_athub_intr_no_bifring =
>nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
>diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>b/drivers/gpu/drm/amd/amdgpu/nv.c index 033cbbc..a67d78d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>@@ -465,8 +465,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> 	adev->nbio.funcs = &nbio_v2_3_funcs;
> 	adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
>
>-	adev->nbio.funcs->detect_hw_virt(adev);
>-
> 	if (amdgpu_sriov_vf(adev))
> 		adev->virt.ops = &xgpu_nv_virt_ops;
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
>b/drivers/gpu/drm/amd/amdgpu/si.c index 4d415bf..153db3f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/si.c
>+++ b/drivers/gpu/drm/amd/amdgpu/si.c
>@@ -1249,12 +1249,6 @@ static int si_set_uvd_clocks(struct amdgpu_device
>*adev, u32 vclk, u32 dclk)
> 	return 0;
> }
>
>-static void si_detect_hw_virtualization(struct amdgpu_device *adev) -{
>-	if (is_virtual_machine()) /* passthrough mode */
>-		adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-}
>-
> static void si_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>{
> 	if (!ring || !ring->funcs->emit_wreg) { @@ -2165,8 +2159,6 @@ static
>const struct amdgpu_ip_block_version si_common_ip_block =
>
> int si_set_ip_blocks(struct amdgpu_device *adev)  {
>-	si_detect_hw_virtualization(adev);
>-
> 	switch (adev->asic_type) {
> 	case CHIP_VERDE:
> 	case CHIP_TAHITI:
>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>b/drivers/gpu/drm/amd/amdgpu/soc15.c
>index a40499d..a8c90d8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>@@ -712,7 +712,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
> 		adev->df.funcs = &df_v1_7_funcs;
>
> 	adev->rev_id = soc15_get_rev_id(adev);
>-	adev->nbio.funcs->detect_hw_virt(adev);
>
> 	if (amdgpu_sriov_vf(adev))
> 		adev->virt.ops = &xgpu_ai_virt_ops;
>diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
>b/drivers/gpu/drm/amd/amdgpu/vi.c index 78b3590..0a90c29 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vi.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>@@ -448,27 +448,6 @@ static bool vi_read_bios_from_rom(struct
>amdgpu_device *adev,
> 	return true;
> }
>
>-static void vi_detect_hw_virtualization(struct amdgpu_device *adev) -{
>-	uint32_t reg = 0;
>-
>-	if (adev->asic_type == CHIP_TONGA ||
>-	    adev->asic_type == CHIP_FIJI) {
>-	       reg = RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
>-	       /* bit0: 0 means pf and 1 means vf */
>-	       if (REG_GET_FIELD(reg, BIF_IOV_FUNC_IDENTIFIER,
>FUNC_IDENTIFIER))
>-		       adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
>-	       /* bit31: 0 means disable IOV and 1 means enable */
>-	       if (REG_GET_FIELD(reg, BIF_IOV_FUNC_IDENTIFIER, IOV_ENABLE))
>-		       adev->virt.caps |= AMDGPU_SRIOV_CAPS_ENABLE_IOV;
>-	}
>-
>-	if (reg == 0) {
>-		if (is_virtual_machine()) /* passthrough mode exclus sr-iov
>mode */
>-			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>-	}
>-}
>-
> static const struct amdgpu_allowed_register_entry vi_allowed_read_registers[]
>= {
> 	{mmGRBM_STATUS},
> 	{mmGRBM_STATUS2},
>@@ -1730,9 +1709,6 @@ static const struct amdgpu_ip_block_version
>vi_common_ip_block =
>
> int vi_set_ip_blocks(struct amdgpu_device *adev)  {
>-	/* in early init stage, vbios code won't work */
>-	vi_detect_hw_virtualization(adev);
>-
> 	if (amdgpu_sriov_vf(adev))
> 		adev->virt.ops = &xgpu_vi_virt_ops;
>
>diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_offset.h
>b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_offset.h
>index 68d0ffa..92fd27c 100644
>--- a/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_offset.h
>+++ b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_offset.h
>@@ -1162,8 +1162,10 @@
> #define mmRCC_CONFIG_MEMSIZE_BASE_IDX
>0
> #define mmRCC_CONFIG_RESERVED
>0x0de4 // duplicate
> #define mmRCC_CONFIG_RESERVED_BASE_IDX
>0
>+#ifndef mmRCC_IOV_FUNC_IDENTIFIER
> #define mmRCC_IOV_FUNC_IDENTIFIER
>0x0de5 // duplicate
> #define mmRCC_IOV_FUNC_IDENTIFIER_BASE_IDX
>0
>+#endif
>
>
> // addressBlock: syshub_mmreg_ind_syshubdec diff --git
>a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_offset.h
>b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_offset.h
>index 4354622..a7cd760 100644
>--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_offset.h
>+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_offset.h
>@@ -4251,8 +4251,10 @@
> #define mmRCC_CONFIG_MEMSIZE_BASE_IDX
>2
> #define mmRCC_CONFIG_RESERVED
>0x00c4
> #define mmRCC_CONFIG_RESERVED_BASE_IDX
>2
>+#ifndef mmRCC_IOV_FUNC_IDENTIFIER
> #define mmRCC_IOV_FUNC_IDENTIFIER
>0x00c5
> #define mmRCC_IOV_FUNC_IDENTIFIER_BASE_IDX
>2
>+#endif
>
>
> // addressBlock: nbio_nbif0_rcc_dev0_BIFDEC1 diff --git
>a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_offset.h
>b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_offset.h
>index ce5830e..0c5a08b 100644
>--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_offset.h
>+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_offset.h
>@@ -2687,8 +2687,10 @@
> #define mmRCC_CONFIG_MEMSIZE_BASE_IDX
>2
> #define mmRCC_CONFIG_RESERVED
>0x00c4
> #define mmRCC_CONFIG_RESERVED_BASE_IDX
>2
>+#ifndef mmRCC_IOV_FUNC_IDENTIFIER
> #define mmRCC_IOV_FUNC_IDENTIFIER
>0x00c5
> #define mmRCC_IOV_FUNC_IDENTIFIER_BASE_IDX
>2
>+#endif
>
>
> // addressBlock: nbio_nbif0_rcc_dev0_BIFDEC1
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C64add81ea4424478f6
>9c08d7cfe2600a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
>206443506465121&amp;sdata=b6lgg%2FYLEShzYGiCxvHzS2%2FhBBsggfvYo1LoI
>H7IOIk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
