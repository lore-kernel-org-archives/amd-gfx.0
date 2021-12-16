Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0696C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 16:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5C510ED82;
	Thu, 16 Dec 2021 16:29:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8777310ED81
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 16:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI1JbEYEejpmqa0GTEAMimcbaB5x3Lk3NxYSH9M48SGGMyHCZLFxCd9cyG2elp9Pfjc9KQ30obEYhphRXKjXehDHYJwmCClv1ZMPqh0Cu2PpAKMQbO3nUPCJfukgw7rLQHgs5bA7OuZXsi/vRWoIV/SaJzDoC2W+usOk+DXtynpp5akQtSUZ2xPAawXWIyaB4ot0H3rWAkk0BhjUIifEIfdmucNZ6hDKmmAt3cuCZYf5SkRKNcjn3m4ieF6ZwYhs7s3EPyHykZhj+mw/MTJF9DLUmuTv0vEKcPeb25a4EbL2bQK6ShQSb3lK3XE92bk6N9np1R4uj++8fFYxAks17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLN9T60B4ZQzQ/Y2tYW6N1gdj7Vr3BTzulkr8xFTZxY=;
 b=RyemokN4UMuwg2/quJ6BP5x/Gofpk9ZWcdLR9+YTVUFqpqPNBafFH1GerlYcy0iow2F0IO4xOpeB+6YwISQDGFlWr+6woARqmGevnZ7+VR1UtR6xrOPEMp5fcEM4VGHyxgG/2Ra615jgC3zxiTgUQcoxp539VbA9L+7tvSbzz7w3A7cLapukLbug+cA0BFRebtQNUWWy57smJ5aCkXWaW7M3q+XaMCQwxmAC0OCoK13Ptdf7UpiBA7qAFjB5mkHSOmCnkJrFJ1wyvdrJtIgoU0GQFdqjqKC2aOJwmitwfkZaXUL2sU5C+q5cSlPHDFVszf0JBnUxbYQkQ/iY0ztPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLN9T60B4ZQzQ/Y2tYW6N1gdj7Vr3BTzulkr8xFTZxY=;
 b=fBx28s4F3dv8vwRfsr0maZLLWF+XJjIRUzwOJV65ehC0b8Je97BM9Nmm05EzoL+4gc2Tbo9OkPHSPKV8acM+ZqmLsKbJT/yQSBtpZgjcKaEMG51cJi0o+O3W7iekNQcTvF7ZRxwxmI4t6edAWxBTO1Rt3O41E6KHviaIHhckCIE=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 16 Dec
 2021 16:29:35 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Thu, 16 Dec 2021
 16:29:35 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Separate vf2pf work item init from virt
 data exchange
Thread-Topic: [PATCH v2] drm/amdgpu: Separate vf2pf work item init from virt
 data exchange
Thread-Index: AQHX8pMYh1+uFVcF4k+9Kcd2tlzp7qw1TrFw
Date: Thu, 16 Dec 2021 16:29:35 +0000
Message-ID: <CH0PR12MB5372F3A4755B28C954345FB6F4779@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211216153901.17820-1-victor.skvortsov@amd.com>
In-Reply-To: <20211216153901.17820-1-victor.skvortsov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T16:28:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a4f2df64-4125-4a11-aebe-65c84fc4d2b9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-16T16:29:32Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 19c10454-b08e-4ebf-b2e1-7294a591cb1c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cdc47a-1a7d-409f-ee0e-08d9c0b13f7d
x-ms-traffictypediagnostic: CH0PR12MB5156:EE_
x-microsoft-antispam-prvs: <CH0PR12MB51562ED0F69E63F31D31BFDAF4779@CH0PR12MB5156.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dg42V0pqLlNOPhkfEW/jpYQC9aGUMEAORDes0q9BNgwhHPKcrNkXbJSlazxQjKdrV/TKf04FfIrv4DhPS6eeR60wv0RPluAVAGfAEKUmN6Ssnuh8pljEJnxUiS9PFh1MIIuXW5cEmRIV1KcsA7j/M1L6QiT3bfFVYUSBSI3qu1+W5Qh5Q7PGAx6o8T4DVGWR51dHAZcMsJ6w1vBkd47T8+meE5zEY0fcPN081O0Uukrrji77S9T7h6OJ1bHQ4cuMdrUW5fF3JYOx/EYXEHdaELWd7EAl++HASsD3HcjROIfMMjyfT9BrHWY2DA2bYHmRczLQZc468DkGJUIYioAdOeB/PNY/Z+NgonHpaIZBfSasXVrmzZ6wcQcc3yw5Qu3m4PhkiinxVzeCnzu2NlwyHEgkg+erI5H6sOjlLxSQROFfzeg9OEy+7NWpMB4PJmqJ7fIM4dm1AJhowoL9TMrcDWjToAK7r/ztok96GBGvXNL0aDWcqb8y08IPb9vC1YBbINDBaydZZULP8daMDGaHx7v91zzWFkvCkswD9ddS0A0RehcSvS5yn7SthmsAB0LMaN0KRYcCnjjE40Py1HKDOeRi6PRC7oZlL2JkUf73HmRPBx21Oq3RATiDyaBFjY19CdVe1ig/NhbGU2YdDIoQfnCv8B7WBr4GlkcUGHmGRmPbRzkgyRWiIpIgtejVjxbna6QNweagUGbvVVbzS57BDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(52536014)(64756008)(6636002)(122000001)(66446008)(2906002)(508600001)(66946007)(86362001)(66476007)(53546011)(66556008)(76116006)(5660300002)(186003)(110136005)(83380400001)(9686003)(55016003)(6506007)(33656002)(38070700005)(8936002)(7696005)(71200400001)(8676002)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mcvVjNQupGk1M2sqYP2+NRtF6Pf1ZJUHTyxxgaolUPGT0pEzFAFVTgIs7yqp?=
 =?us-ascii?Q?jZn4TaL815HtQlXlQRLRF/3d8SL6G9cn98agq92icJ5Ln/vQwWXv4KJk73+L?=
 =?us-ascii?Q?9j/tkNM4cvmaL6upyHjIax+miBuhK1KwUUiGADZG2tBMZjWaW+fbc8CYCkqg?=
 =?us-ascii?Q?p831wtCBdB8iKHF4K7TfPSYW+IQnqHzUzWees23HXhABDbsGIvuEoYDmSYD4?=
 =?us-ascii?Q?PSNAX4zFZkO0Tdryf9VV9ZQjSMhECtetJdlyBzngQllJOIdnBFC0i5eldHnR?=
 =?us-ascii?Q?1NSh/iBD0Ea1tpyEuR5ZNxoan2vDi6dhPEpvEp7c1776f1cT7CmrqG/TQA4/?=
 =?us-ascii?Q?+PRdIgCIjX1uvhF3UfcBWfoaaIx9UyOoJreNFebApFsRGd7QkLtKksrBZxKb?=
 =?us-ascii?Q?FlRn4PmOXutRTzYcjKBXUeoQaGyfYkOJ64nqZK6kKsnhj35YnUWpu1uoI+oC?=
 =?us-ascii?Q?XiGaXPXBjKatyrPhgHMN+wzmbvcy42zGdxsmza956qDgRKEZ2+vFIlH0LE1m?=
 =?us-ascii?Q?IeEfywMWqhGOWoAz44J6PVWi1FYesa1kEUaujVYWlHi6Q50JgI+vzoYxMt2X?=
 =?us-ascii?Q?df7B5G/P5vi17A+m3PQEnKZNvWPUqWiYvjcvMWdyGrRklEkZ6oh8uHMm6Ieg?=
 =?us-ascii?Q?zLKGrfYxPBJKzuezKFZZSTAslgsuuRUYvEZtgI0DQeX83hOspoGx+nLwmqji?=
 =?us-ascii?Q?uMWV/uaOoirLS9mxFPnuIg07DJPISQO4w8WYaCsVlm9fR4J4r58afPxDcnjU?=
 =?us-ascii?Q?G2XtOG+jcg1UiuLWdMyzMKFTi35IGbn29HFkaurtRh5HrgUC0AQOsIQjop9V?=
 =?us-ascii?Q?fCjzcPeGLJBQj+DWx1g2FptcG7Ydab1D/d+Fuvms0MnwS4j9FZkLsnVMK9wm?=
 =?us-ascii?Q?7JVyp8SNZrLs8D4FVmNcHD4PEQbSIONvcmRcNqilBz794Bd7aFz9oXJXxAlQ?=
 =?us-ascii?Q?2j7jHL7aLxjfZa9GEGRGO/tQNiGd72LX+LXS+EWUGxxHDW0mpW+euMkbw9h4?=
 =?us-ascii?Q?E2Fxf6zK9qmC6JlWlZGUdSToh4KUQhtLwwf/0oqalLqV8mCNP3HAl4QUR6Bu?=
 =?us-ascii?Q?Gp0Nx1Ubi1porETG5kkQeZ6VhwJAcpgR4b6Xn/H+Goq7Oj6dHIseu2CbAj+M?=
 =?us-ascii?Q?OhCfgXJ45sg350UGJQxgKB0+ZjWhmbkFEmQzJhKxacCpPQF79aQ4zkorVHYP?=
 =?us-ascii?Q?+yKVPc6E9wf6WVXIsWbmum1oJlnlLuzLKE/S41HAGIPVtWgUmQdXllkUNRYQ?=
 =?us-ascii?Q?lQUEPim4MnrCeLXxXj3em7pK3EuySDeM7hSawnVFYQ/zEl6HN3K7X1LtTudQ?=
 =?us-ascii?Q?JoyJFzjiBg/xMp17OitqUi8xz1exugKOFthbqC+XZBEzTYnsNmZz0BQNu7bM?=
 =?us-ascii?Q?10edzjDIxzTpX9oMCyx246BqigrPDIseuIjy7hACTSaUHOH22PH+7Ivid3q+?=
 =?us-ascii?Q?jWwteEDvyCeeyafwO1bd8aBhxKZFA+c8LYtpNG6Xst+jnWMtQCbwQTVZTu1i?=
 =?us-ascii?Q?wwlO3qsd+lz6dbSmG7ywYGhLjdTBgf1yCMsa0AZBS1WzSQni3i5AKmzmzjoI?=
 =?us-ascii?Q?Zh+lzpf9YI4/GAakSTn39N77PG13UFZECI2u2EQIjn3PJTiOW3vC6iYSDklh?=
 =?us-ascii?Q?Z6qhXPXDBH3cYdEIcWiGBpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cdc47a-1a7d-409f-ee0e-08d9c0b13f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 16:29:35.4088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3M6Y4bVW9au4RPDFjFCWCJvg5DNaNyVmjM638h+3M19M8t6Czkt37R3wQIytaV16RS7pJMWexJd6vznwWtkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This one  looks better and  more logical .=20

Reviewed By :Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>=20
Sent: Thursday, December 16, 2021 10:39 AM
To: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Niet=
o, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Separate vf2pf work item init from virt dat=
a exchange

We want to be able to call virt data exchange conditionally after gmc sw in=
it to reserve bad pages as early as possible.
Since this is a conditional call, we will need to call it again uncondition=
ally later in the init sequence.

Refactor the data exchange function so it can be called multiple times with=
out re-initializing the work item.

v2: Cleaned up the code. Kept the original call to init_exchange_data() ins=
ide early init to initialize the work item, afterwards call
exchange_data() when needed.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 36 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 48aeca3b8f16..ddc67b900587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2316,6 +2316,10 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
=20
 		/* need to do gmc hw init early so we can allocate gpu mem */
 		if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_GMC) {
+			/* Try to reserve bad pages early */
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_virt_exchange_data(adev);
+
 			r =3D amdgpu_device_vram_scratch_init(adev);
 			if (r) {
 				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r); @@ -2347,7 +2351=
,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
=20
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_exchange_data(adev);
=20
 	r =3D amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 3fc49823f527..f8e574cc0e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -622,17 +622,35 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_dev=
ice *adev)
=20
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {
-	uint64_t bp_block_offset =3D 0;
-	uint32_t bp_block_size =3D 0;
-	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;
-
 	adev->virt.fw_reserve.p_pf2vf =3D NULL;
 	adev->virt.fw_reserve.p_vf2pf =3D NULL;
 	adev->virt.vf2pf_update_interval_ms =3D 0;
=20
-	if (adev->mman.fw_vram_usage_va !=3D NULL) {
+	if (adev->bios !=3D NULL) {
 		adev->virt.vf2pf_update_interval_ms =3D 2000;
=20
+		adev->virt.fw_reserve.p_pf2vf =3D
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+
+		amdgpu_virt_read_pf2vf_data(adev);
+	}
+
+	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_=
item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->v=
irt.vf2pf_update_interval_ms));
+	}
+}
+
+
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev) {
+	uint64_t bp_block_offset =3D 0;
+	uint32_t bp_block_size =3D 0;
+	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;
+
+	if (adev->mman.fw_vram_usage_va !=3D NULL) {
+
 		adev->virt.fw_reserve.p_pf2vf =3D
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10)); =
@@ -663,16 +681,10 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
 			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
=20
 		amdgpu_virt_read_pf2vf_data(adev);
-
-		return;
-	}
-
-	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_=
item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_=
interval_ms);
 	}
 }
=20
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)  {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 8d4c20bb71c5..9adfb8d63280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -308,6 +308,7 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *ad=
ev);  void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);  void amd=
gpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);  void am=
dgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);  void amd=
gpu_detect_virtualization(struct amdgpu_device *adev);
=20
--
2.25.1
