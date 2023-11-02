Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C019C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 16:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D653010E0AA;
	Thu,  2 Nov 2023 16:11:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C89A10E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 16:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUsQ6sfrppnsYkInOkkdO2YHz3UXl/oXnDWK6LbFtlp1YTQBvs2YTUF/kHHXZG198QlCd69Lrs5fQFE46z1+HbaUufxJllS4VnLSCLTXFps7zw4yDmaNgU1Aic/YhD7Cw2OF7Us9XULashKMiLMHNV/paktY+UKg19/YVsAVOqEARwX7cVIW2dvfYtmowLbSBCYDVUvQaboldzbSIX+I1KU2ZzO+1RA/KJ76oq+fxcOvofRRlYoDFOMVTP9HpEFuS0vC5FKOYlIBAVMyRa4lsPF6ErFyNhiCNDVqVDbh8n0mdC+pcLSx0m0W5BZZ6dDaJAofduzaaF911RYOyytt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh0ti3He0d5/Z4T9ldcSWDKlJeKmE1tOR/VCFKx9bis=;
 b=IGnF6lN9wO6GJ27Pk2cVZVcFSM9kMb7cDtR72K0CgbPC8g5CPi+eor9iRPIf+BEoV1wppWzffot9Zmj1+efSOhX4ghTNh23fiCkwUfQtxd+mawPQLeRrDJ8hsNhaCarrcp8TCWqTNvbzyP6wDaqZQM8wzVEjmfWzZSWPtTbS8JT+d8YeTwkUw4HVowHTmfbn1dRTTSXfhx+1skAOiY6VHPDIux+4xCmiMcz1ckWgLgdyb9e572Yjyigdzil8j3ww79KRoHfRDkS+Yrv0ogjAW4vO2ZnvTFXvTaS5nY35LHJRD236ymZBTEm0OExjr95mD0cbyM+rJn29wJ6e4NSJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh0ti3He0d5/Z4T9ldcSWDKlJeKmE1tOR/VCFKx9bis=;
 b=AaXMvBZZrvIbIT8gqPIa3EAqkiI8eE8hFIT4R7saXJMt95dtEJw3/fRNpgriEgnHOl/Vc3j2hiGekrH+MMX0yCAizpgOlyHMvxm0Dmdj9ZnX6QfMvMx6tcYa1/6I6b/uDSSJMMul+IEnYmCcCBjI1PEiy0Bimab3RxG4VF32l6w=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 16:11:20 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::9193:d4d9:73fb:c301]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::9193:d4d9:73fb:c301%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 16:11:20 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kakarya, Surbhi" <Surbhi.Kakarya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm: Disable XNACK on SRIOV environment
Thread-Topic: [PATCH] drm: Disable XNACK on SRIOV environment
Thread-Index: AQHaC502TfatEjLaSU6YPcmZrGYslbBnNo0wgAAAX2A=
Date: Thu, 2 Nov 2023 16:11:20 +0000
Message-ID: <CH0PR12MB53723F53A347F5D97DAF749CF4A6A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20231031015404.14410-1-surbhi.kakarya@amd.com>
 <DM6PR12MB3929ACBF76BDA302BBFFA47A8EA6A@DM6PR12MB3929.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3929ACBF76BDA302BBFFA47A8EA6A@DM6PR12MB3929.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=306c06ff-db37-4871-ae70-eaab253e5847;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T16:09:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB5901:EE_
x-ms-office365-filtering-correlation-id: 1630415b-95bd-4ac9-b98c-08dbdbbe59e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pLSpLd1OSYGMeWcFFDjUNSiIwR2FQzY/6CBGn9CaVwWuqWNIizSb7xsfjZVo9NyhKQxel3lNhzPiXsvbFq7bL9duz8yigCtGe+Pa6z6qOcn+nDMxC36fEKTMZS//pvq/iadeo/rnBDKk46GNJ8jv2rCFjAwf0LXnQ+B6TttakEg5UujnOO8M3WsChN69/bqlINozun0P7lqVg6CQYSg2bmWk/JwoEcxisv0TtMncygNqTmT3/3VeGcajL5TGWNyKypp1gqwiRtqho7+Zd3GXjlgKEL+BYjBe9F0F4CyZ6VBbkJ0lhUsx4mJn1xEYovvhZGzL7ZL7VJv7o/wX+M0KXUS9jx1ZfgRj1bCsLr6kMHY23ziQcrjmjmp3XbAeuaCMzK294NA7NtCFmdzs1enqEEImJdMBaxR4LgAvKgCVo10Oj4RpxE6QWnc5vXwXpwoDEHm8Ohn1Q/pbUUjujYXuUod6Biyc1Ixxll+b8WGtDs01HC5azbRfctj8nilS34BfjLNpDdn3lnxNNhyG0sCiVt1+Aa9NQllEdDsJn8s+nI4KRN+qqjJu/FQ3jj3rYUBPpoTtrOB/tnSZD3HcWMEEGQH/8kOcmkI+XunIZbQQaAj6hW2E7eVhxZOPT58ia6l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(66556008)(66476007)(66446008)(2906002)(5660300002)(64756008)(6636002)(76116006)(110136005)(316002)(8936002)(52536014)(71200400001)(478600001)(41300700001)(8676002)(6506007)(55016003)(7696005)(53546011)(26005)(38070700009)(83380400001)(9686003)(33656002)(86362001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nrEsDAD3v6SFow2JrjPMfV/dZNMtlch49TcSKTPXHha5gCSkGZPlnr1j8Pqm?=
 =?us-ascii?Q?VNqFfE5r2C/yJB5h/n2fLPJAEwWU4g+u+BXhClnHB+C4aEDB6r5s+r9F04uw?=
 =?us-ascii?Q?bm9XWjRkbAE1aPGZguPcTKqem1GHKtG6Ickq+XSc/GdCmp0pXzQC8d76DZOi?=
 =?us-ascii?Q?wMUNnENAx+LnhXup666R5kzYNpQutHqUqPdZk97gbWFvk2vFFkUgmUGdJ3G3?=
 =?us-ascii?Q?9XpYd3shCdCAf/Dkl5RDixClezSz5o8uhA/LhuafpQRlD+ADm72vPfvMVJPW?=
 =?us-ascii?Q?hjZn8gbNeInR2zf4MiQ07cyOdeOSBEbobz8TktX+geO71Xan6uHryWDu5YaG?=
 =?us-ascii?Q?t2XZLO4RRZR/SYY17Rjm6UgyuYW/LKJMumHD8ePzQA4c6ne/4hdun+89g3Rv?=
 =?us-ascii?Q?trli5gWD6roUIuZ4g4IMf60ms5wPU1S2bzWZLLmymGVIyWMbi2pk/JHmC29x?=
 =?us-ascii?Q?aGJcuRW7tDDQMsBpVyIxvV9YegqvIGLMK+n6OjBqd5XlLoDJYH7tFdw0A+/5?=
 =?us-ascii?Q?IMgYCY75bf2H67Eq5RypxQkxhtqb4fyhdDK4olRDNd+jLsMcfdWdx+wXTa9G?=
 =?us-ascii?Q?p9e50KjKNWMPT/IPAk4jGyNEuVYlNDsnS/dmK5se3W474Z9KxhGlEfKrTg12?=
 =?us-ascii?Q?9/L0KFZqvMU92AO9HijiAyvJdfhx7A9hBM27PJhaZ4SR61lLNLHyBKlxSmfP?=
 =?us-ascii?Q?vLu9Q0sErUVjYl2jJpzoDOgAwLp/wiqqXNWO6A8scsqMBmYrh3n6T5tC+XHr?=
 =?us-ascii?Q?lvdHXGSj6stClkRHU9OK/z6qMrLpOeW9MS+d1ToqV7GPeKMzFN1aleaTGEOM?=
 =?us-ascii?Q?/jwFOtqZPBIX7T1pWsOvJ/6/7KxAOKBZfCU38VsQz9h1vpTqs8SKU6M9GICS?=
 =?us-ascii?Q?MabQvBcNwJGkajgqTOGiiQMlv9G6je330hB2atfFz3RCBXQUeWqHBFZGgU3H?=
 =?us-ascii?Q?YCeW8VqS941i91IDL/DJ95/PUJEpn3dXmFXdKHCLk6BzyrxMaBuVmcFpsAhD?=
 =?us-ascii?Q?LLdNCHuPzQ08nqYCLcqqsx8AjSmmJsw8rdBxoxoXSKhH60C5eIcODrUBUSNb?=
 =?us-ascii?Q?P6kue9Dd5wiF/bqRrb6vdwm+NNiuMc0FVTEBzb42ivyy4M0ZyJcWm+MEEZOV?=
 =?us-ascii?Q?x++g7uh5bKwMH1aJNfDudsO+AzmGKbCWgL7HLWFy0u1+Z9yXUrNxWvOOxUU1?=
 =?us-ascii?Q?uutxgZh+XiVPJkpOkLMy6Q1rKBDKmXK5QPMyZaKvpKFbhasnAahDe25RCP0R?=
 =?us-ascii?Q?6EBgQcoPz21ZFtqFYpYtIHSjKZvNQBPnpfQN9Hj/SiDwE5JMYhhDBF0j/G5j?=
 =?us-ascii?Q?2Ra6wH7AVR5TmkxhZg6bQtQ0/Go+EQZmXWvxE1YHystMh53qIr+QC/1o1PGa?=
 =?us-ascii?Q?izTNaTUyGYoAghRXJ3R5hRuwWFmkD1aXwfRTCLqysZReaXBdJPBKnzzjTsdy?=
 =?us-ascii?Q?dHKVdYUccDmjy+Kaqrioi9ziQHpFENUBv3tgK+MrVhMLtEMvvpVxxLGkVe+O?=
 =?us-ascii?Q?i3ceb52sbWHI+nnkAMXSNUcvHhWEP5igRDap5PKJonh6NyVoEOwO2R9yIMoa?=
 =?us-ascii?Q?6/4lnSwnF0FVSR2DpB8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1630415b-95bd-4ac9-b98c-08dbdbbe59e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 16:11:20.0871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIcCp1nQWyoGSBPE6XBLYQ/xNOaa9kNqjVIvTxlZPwWy1JTEAW70Vc8tZsZJOaEev93KhVsErNvThB4Aq/p8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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

Looks ok to me .
Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: Kakarya, Surbhi <Surbhi.Kakarya@amd.com>
Sent: Thursday, November 2, 2023 12:10 PM
To: Kakarya, Surbhi <Surbhi.Kakarya@amd.com>; amd-gfx@lists.freedesktop.org=
; Yang, Philip <Philip.Yang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm: Disable XNACK on SRIOV environment

[AMD Official Use Only - General]

Ping..

-----Original Message-----
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
Sent: Monday, October 30, 2023 9:54 PM
To: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>
Cc: Kakarya, Surbhi <Surbhi.Kakarya@amd.com>
Subject: [PATCH] drm: Disable XNACK on SRIOV environment

The purpose of this patch is to disable XNACK or set XNACK OFF mode on SRIO=
V platform which doesn't support it.

This will prevent user-space application to fail or result into unexpected =
behaviour whenever the application need to run test-case in XNACK ON mode.

Signed-off-by: Surbhi Kakarya <surbhi.kakarya@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  5 ++++-  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.c |  9 +++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.=
h |  1 +  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++++++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2dce338b0f1e..d582b240f919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -826,7 +826,10 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev=
)
                                gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
                                gc_ver >=3D IP_VERSION(10, 3, 0));

-       gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_default : amd=
gpu_noretry;
+       if (!amdgpu_sriov_xnack_support(adev))
+               gmc->norety =3D 1;
+       else
+               gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_defau=
lt :
+amdgpu_noretry;
 }

 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_typ=
e, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c
index a0aa624f5a92..41c77d5c5a79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1093,3 +1093,12 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        else
                return RREG32(offset);
 }
+bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev) {
+       bool xnack_mode =3D 1;
+
+       if (amdgpu_sriov_vf(adev) && (adev->ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(9, 4, 2)))
+               xnack_mode =3D 0;
+
+       return xnack_mode;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 858ef21ae515..935ca736300e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -365,4 +365,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,  bool=
 amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
                        uint32_t ucode_id);  void amdgpu_virt_post_reset(st=
ruct amdgpu_device *adev);
+bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index fbf053001af9..69954a2a8503 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1416,8 +1416,14 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)
                 * per-process XNACK mode selection. But let the dev->noret=
ry
                 * setting still influence the default XNACK mode.
                 */
-               if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev))
-                       continue;
+               if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev)) {
+                       if (!amdgpu_sriov_xnack_support(dev->kfd->adev)) {
+                               pr_debug("SRIOV platform xnack not supporte=
d\n");
+                               return false;
+                       }
+                       else
+                               continue;
+               }

                /* GFXv10 and later GPUs do not support shader preemption
                 * during page faults. This can lead to poor QoS for queue
--
2.25.1


