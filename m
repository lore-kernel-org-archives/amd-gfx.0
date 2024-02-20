Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF8C48BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 07:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B15610E172;
	Tue, 20 Feb 2024 07:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnDsMS/3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C1810E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 07:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAxt8JjDpZOifSNFYdYnDuEfckGiM3dEWMZvJxNOl3CzpmolcWQDgvZJTUQIhXaGvUli9V2jY5e6QzDz25ZuPhXd/d1tW8plULvrQHl5b8rz76sTAXGsqgN9HiTLJEZODSEBzhtVMDu7torxlyh84eTNK4amol0gt7SXsBJuCtQQntEml5ryJQXHo97pN/AckyDfI6nLWXttdBRMuPjUGgaYZXL3tJsN62d64TgJZRvG6XmYPVixWVlkUgxFT3zwSpmmm34gV9+PC6c0aEsd2fknhruCDWt+JuRUEc8OiVe5EVuii13U1t8RtX6e5cZOcQdVu+uQMXYg2ACKDsNKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL+Png3WwA2olgolssxvFIy0nQnmZWDlTdmf9F+pCm0=;
 b=GQzCpM7fIvmTybOUTQuXH6MsppvjjD538xitfvkEPKSpSYASRR1cY1Q9j1ERYZrWlX3u6Cd6yhPZtyKxbAiV4WejddopklSazsazxbpZtOB5d0iOKY4z6wsABM3COSHkMoAEXE97zcJ0WSKwo1JdrnNy8fd+Qr+EWn54FiU5r7xGZVgRfoRxfI5RDHDODKo6hACDe/bllsNWJtrfjRitk0v3TZ0g/6w7s8E2ToOsgwofZWJN5rGrsen4OgB4asG5qKKmCLf6NeqRCVcXoj3kT2Vms+CzRh8YsmvWbikiJH0r6b5ogdqqWnbfQZEqAz1L8yZdxbAlHrao+/dW6k+qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL+Png3WwA2olgolssxvFIy0nQnmZWDlTdmf9F+pCm0=;
 b=jnDsMS/3HqMFdf+847MSxPGtkuoD9Vw6EAoLPTSNOgMupxzdLREgf6nN0yJz3TxbReQJfrpPxaIUDFN/JjCfthTo6FKXaoI7TqE67tz/Jx2DHRETmOd1Wh8O6PGi4gk2FSfbWsENhKcEzRx2mE9NDPoHb/tU57ayKV+Z+hDUkDg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 07:10:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8718:1bb2:17d:6e27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8718:1bb2:17d:6e27%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 07:10:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Remove pcie bw sys entry
Thread-Topic: [PATCH 3/3] drm/amdgpu: Remove pcie bw sys entry
Thread-Index: AQHaYNgFMYJsQt2nrUqW4YUiR+BdzLES1iGw
Date: Tue, 20 Feb 2024 07:10:58 +0000
Message-ID: <BN9PR12MB5257989A2EBD74413C604547FC502@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240216125927.1821169-1-asad.kamal@amd.com>
 <20240216125927.1821169-3-asad.kamal@amd.com>
In-Reply-To: <20240216125927.1821169-3-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c84aca36-4ecd-4b48-9bde-42219b1be139;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-20T07:10:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9393:EE_
x-ms-office365-filtering-correlation-id: 0bc4682d-fbd9-4b4e-230d-08dc31e316a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeHCuJZKNE0KIFae5dHXD6PE4gBcTkltYJdS2Zdl84R5lX/ksW4bEMqNrllt1RjukoGlQQRuyWvWwBxnyoR9XEMC14sU6MyGO7ofDUcjoIUSYgpX/33FzuI3QxYZwBQYWeCF5YLmlrhm7iJ/AUW3ElLyJTC6iUYJ4hhaWqgfM/V9maG4EPvapwBJ7GuphK5o3YgrMq8RcyNM/QPfCSNukbVGdw7trsw1WixvKF8N2F9WgQtlfzDO2EuzpEP6DRt6Pt9xGo8AC0KjEXD0QfbT9Vdun97O29g8EdK3hmTUesvbqSRX2nag0eTOZZGWNJ4WubPSm95LNB4kURBaa4v6YN8uiqpNXUhcnNt0EfWfSONRGYu46MScEcNy+L6pu18LJuoAIqsVMV28G9m736im2O1q6UfI3uJcZ1xcloFb2CMtOZouwU8unNkU4j2EqybXF7iZpew6gkjJecBwXdk2zJiKzK0addhAs/E91QhTG0UTurLW1xKcXug2VQo3+zYa0wZSrvpyeGSX5FchDtToXYFPfRDqqX6s2wECHtezOggyiMblHrPJk1pVX6lXPZcMtCyMeCZJ73d91NxmpVTcg2txxH4rpxjgIATliGIB9dhs6uNFriGgT+yb3HEbwkS3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PH0oMnr0tBRNlq0/xEY1R6ldWAS7d5hoRv5Kz67tW+EiiCw5u9O9fyqcw90K?=
 =?us-ascii?Q?ab9p32eWvr89mudkyHqUI5E0o16thByPaSn6YCD/8D15Zuf535by83IfxuVf?=
 =?us-ascii?Q?dPXLm5x0ozqgrydryp4Vv8x7EqOOVMDosEeVKoveXVApCuYOenLGPXr6PePU?=
 =?us-ascii?Q?5oJupLXp5H1MseZCxKZPIosmA1W8UFuD8fLmyrEJIFnCUwazNUoTFVzKMuqK?=
 =?us-ascii?Q?grEHb9NdNSz5+mUauoeMsJRHl0eeAIUvbpiO19oko9kU4lzFazOyscE6iyYc?=
 =?us-ascii?Q?wYqrw30x7USjzUobdRqbdUIyifPU/7pO3btA7qOGqGdJuesyL3B3ERnTDFae?=
 =?us-ascii?Q?jX9VJKslqrpffF/Zmze3TTurTl4NpVnWvWdqLVnu6Y/wLRTPet2GbRZ2gHu0?=
 =?us-ascii?Q?5mjzXYYRNKrdrLR0K998FOgDV3uE3YSEQgI7GaaeLOM7xc5yNFGNN++NDGVO?=
 =?us-ascii?Q?lfWOLDQT+s1lb+ddf/wQgZmOqb6abhB1yRLwzjw1/FBdYZJd5r5p9v7zeWYN?=
 =?us-ascii?Q?5lJOwP7BPnc+aFzbelvC+bPIs9ogJHMsYid0kL+VCz4nqF8GlByLu5jfrsqS?=
 =?us-ascii?Q?jX5eKRFaKPDv7N5+37rhX5LvO/kdtSwWTOgk2E1H73RqcLKOU9Wek8dw7AiQ?=
 =?us-ascii?Q?JzCgHOBUOYQMwtT5IuNt6Joi+4ymZrYNrKx2WyeTlGeKPU2ec55Uvm41NK5F?=
 =?us-ascii?Q?sFALvkw4mM1axG+i0pXez1YragZOKgA0QdCQw0d9I6ezTCr+zAdXJrY4YPC2?=
 =?us-ascii?Q?jynHw6wHBgK+DD886r6uqURl5Eqg9EpIi9A2O+flQ6r44jTpa8rS4VY6kDTL?=
 =?us-ascii?Q?Jb+MVlfqRMyYAIQdi9ZN8hWgmerDIPPzc14VVTeiFaCQoh3lC2jxzRMgFfKc?=
 =?us-ascii?Q?SvGgZGtSVmQKttOo/ckXdjZlVro0atBQghRabEqsUP6vXQbBs5li5zOq2LHf?=
 =?us-ascii?Q?KsXadWxYs5goqTlhV+43mTDTSSLuWE+Ihp+v5LB/lfo2TV8wDM88hI9LrRsH?=
 =?us-ascii?Q?oItk9XneGq07OpBGcqB20vkeM9mNRMq4DFyOwZEL1kTQiMmygstjgDroSaVO?=
 =?us-ascii?Q?pnuCglojvTOj2EJYizuATvLVhyGR2nkTbLrYai44ci+uzA8zPfgAmjam24PM?=
 =?us-ascii?Q?g5siyHm16aish3mHgl6vM+wc/y8oT+Kv/myTL40Y6ftDMbou8Bex7BHRWw3Z?=
 =?us-ascii?Q?vOe9kJdLvlWFyIBuMSHhxLksE4bEyh8iWloIJkYEWaO6JxXCQrArC20RADYJ?=
 =?us-ascii?Q?uwps40bkKz2bqRXyxxlxL++fzTgotipTdDbMUuzqRHBCT+dWMh1QVXE4251o?=
 =?us-ascii?Q?tjLIsbzNseal/o8nX/J8gLSYTYT//F/3WOWZFFmAKwdPz7NSVHmT9P6nWcxj?=
 =?us-ascii?Q?YSmoIJ863GSmvg6kGrwM12m3rpspO7GeJoScx37RSH44pSXm4hQiZEAGs2+f?=
 =?us-ascii?Q?mqqR3sTjkOZPbyd095Oj9ERrx6TB+HgjTEhHeSlqQWBih54W0+1Jd+WHu6qB?=
 =?us-ascii?Q?GcPG0jcv/fNb43/CDnlV2JrrXCJkiK2J1auMd0+eaU9/vPnfpix+05odMf/q?=
 =?us-ascii?Q?CLQO8DsEUHLtquBWQzA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc4682d-fbd9-4b4e-230d-08dc31e316a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 07:10:58.6460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFFYg0m4RTg7an1pyXPzLd/IJHcxI/mj0NNNo3kbMwCq0ordGf18pRBY6MqsqH+Znd0CxzC4S5AId0hAIt5p4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, February 16, 2024 20:59
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Kamal, Asad=
 <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove pcie bw sys entry

Remove pcie bw sys entry for asics not supporting such function

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 -  drivers/gpu/drm/amd/pm/amdgpu_pm=
.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 7fc55e3262eb..20a4582885cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -895,7 +895,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asi=
c_funcs =3D
        .get_config_memsize =3D &soc15_get_config_memsize,
        .need_full_reset =3D &soc15_need_full_reset,
        .init_doorbell_index =3D &aqua_vanjaram_doorbell_index_init,
-       .get_pcie_usage =3D &vega20_get_pcie_usage,
        .need_reset_on_init =3D &soc15_need_reset_on_init,
        .get_pcie_replay_count =3D &amdgpu_nbio_get_pcie_replay_count,
        .supports_baco =3D &soc15_supports_baco, diff --git a/drivers/gpu/d=
rm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 087d57850304..1ff7fc821871 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2174,7 +2174,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pcie_bw)) {
                /* PCIe Perf counters won't work on APU nodes */
-               if (adev->flags & AMD_IS_APU)
+               if (adev->flags & AMD_IS_APU ||
+                   !adev->asic_funcs->get_pcie_usage)
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(unique_id)) {
                switch (gc_ver) {
--
2.42.0

