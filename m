Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75112C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 07:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D666A10F895;
	Sun, 28 Apr 2024 07:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47DUBdtF";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0644210F895
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK5OOok/12vCnxZoqSRD4IP85czWBHhCq9dJb3KPKzGqWR7xGxQf73WgCWtgQ327T6/8VF/s+Lcf64Zft1peNijx6v0+LIFYF+D/qNgxpMGljpJMtBOKKtOu2jzgaKwu2aGmSLu/2y7n53Qy3hO5uNbcdexFESPIsWrxeQP5HivHc5xYIThq5fToTFuaV8qL6snuEu+eFjFK28B8i1Pmq1yGCeYu2+Vdxipl41QpffPol/SJacHb08lb/GMA9mXT9S6Yen9bkMBE0ghfSrahvW0LwuAaKPDkKukSYUps0Zrsc66O1UqwFAYEwy+uswtqTNyhtjlPUxxIu/8XFqormw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eXXguv0dTCzZqquelmCILpVxJ4fbsGc1Hb032WbZBE=;
 b=Gt5GpJzliKJp+dmRLpvLa8/GSLI/piW68yp1e4BTdk6KMf2GjsedFRDd3rx98VrM/UK6Qb0elkL2POLzrlJc6OBXOuWwUFeGuqpKo3aHtsFtnrpocQHMUJPzW3YWYnbanTM3WUFMWmi2/rTeSoh/+7CtU7Lhdu1eFwliRh3A1SL48Rs+Iw3GfDGtnDymvcYM7wPAgBAnHBsAzxZxhwmDYZlKnxjheoIsiYqIdJcC0DPX4Ivc/jJVoTm3hGKQcDvPhYh0kjICT1V0beLhuB6liSFIYtEn+sfkuOkbmdXNIWOp+kWMLajVDeJe4ACSm879bH5f753HDU+X785N49N0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eXXguv0dTCzZqquelmCILpVxJ4fbsGc1Hb032WbZBE=;
 b=47DUBdtFNx5YBbjifXScV8rLkkArSUrxh4SEEvirKKIGbwD3qttrKJc34aBcljWy3Y3fvIyEVcO9t666j2wE3YtvbRtx8TyW9z//gf3TXUMSgSsNs73Oh1G4oQLQOxQaptiIi31/kwyhgRO3pd8ID75jE8Oks//XVH/0LCWr4M8=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:16:23 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 07:16:23 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
Thread-Topic: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
Thread-Index: AQHamAdu+//gUZu11EOnV0p9sD5OarF9R9uQ
Date: Sun, 28 Apr 2024 07:16:23 +0000
Message-ID: <PH0PR12MB54170CEECD476894E25F05458F142@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240426035742.90560-2-Yunxiang.Li@amd.com>
 <20240426182705.98131-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240426182705.98131-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1c8104e2-3fea-4997-b8a4-3c793cc111cf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T07:16:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB6841:EE_
x-ms-office365-filtering-correlation-id: 67c19a12-8f60-4d63-c91a-08dc67531c0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Dhqsm8yr7vZRv3fAvqIng2q8KrXBDUY2O4MuMbcP4MraJ5hCkzIa75gNA8uq?=
 =?us-ascii?Q?fdGTsko7VPY2dtZ7VdxUcXlfAyeKaONu/VsQtx48DAqSyELD0mN7yHlc2ol4?=
 =?us-ascii?Q?az/SK12rvuMsouW+TQ8ahWIjyrP9RMWHCqWPnj9h8QGEt/c16aohVwjU7ixE?=
 =?us-ascii?Q?oL9jpVt8JC+fhj7dyOpeJSrHNscI8soDiUPK7I9hRz1mJaei6APq0PHj0W2L?=
 =?us-ascii?Q?fz3Rh6OQDQpMlMyo6CRvh3wjhZS4VB0UOTpHzSil+esKv0glqqWQqAeDOswz?=
 =?us-ascii?Q?DNgjAfZUlPVXHG5PyT144KCmx1KJJxV4/HYe4qix+M0d8Ih8hqen+vyvyMbV?=
 =?us-ascii?Q?TJPt6Ef/gX0aBLuT4z0CLtblKyAeY5hR8IkZm1EbrBWOvpcGB9I5SJjCfr8g?=
 =?us-ascii?Q?p3pNM8RcLS3gq6nMGWP8HmKPB1DVNP4qGGThyxv51b91fkm2xYXun/PrZbfp?=
 =?us-ascii?Q?dFgYUQf0l/prLQAmOcUnLo1lap7efKLp4v1/0Gh2aGEIDpOm+rZsFHr85Iyv?=
 =?us-ascii?Q?wmngSCySQ5Fv4oev+O1k6Aiv+gsk6dJxuYFUYOWizsebrRn2QVfYAfJz/fpw?=
 =?us-ascii?Q?EWp2n0qBSFKA3jDyxwjPfTaJ1SbYZgYDAuLl1wHfdxKBIutF5Dpz8CV1IeY+?=
 =?us-ascii?Q?ul51cD2ueosBMPyfm0lu7P5DuDQPK++q9PKgqkTAEM8H5IScMSGGKu7OHvq0?=
 =?us-ascii?Q?qzrNQKMi2eEECgfvRk/wB/CcCSoCGclgGmi3+19dfddG4wBwNr5xxcPWtPna?=
 =?us-ascii?Q?p8T6wPSNXRIhDM0yHGtVbrWyA2xDkMET+suExiujKe9HNflK8HoL1bRhZ5EV?=
 =?us-ascii?Q?soVeoirq95zgL7BBywhzZPHyxkmngSDMDqJdm+1bA5W2hkc7ta3ZZIjJepHv?=
 =?us-ascii?Q?LXD/sfeWrPys8utmXazwWRaqEZksIhFdAC8nkJg03MPHAmkd1kxZ4Blv6mUZ?=
 =?us-ascii?Q?2mMCOW7rMghkR62DBm0LmAPlZUwAHdpdh4ALCRiIN/mk2RcfeFfCJ9hcE0Az?=
 =?us-ascii?Q?g+tlOygaDDh1wQJ+cqhG4OlgqdgxtUK5WWD8PQqWqVFHTRcK+XqJS060BEiJ?=
 =?us-ascii?Q?Ul5Kk1/XyyYhY9V/yLTESyASXVnVPjBh01TgCzO9GI6BSRCV9mPxG/F3lbCl?=
 =?us-ascii?Q?A4D6NUyAAuH9tLt2hcEeF9160ojEAY5BXayZcOdGYePCk8g0u9Sd/3s0kWZ8?=
 =?us-ascii?Q?tYN3Rg8FoWDOZ/tD3jsevNReQkU0cNqQwFXaRntWzLOqCkWfXx9xPIf+yH+H?=
 =?us-ascii?Q?nsbxxtqdadsrPkpQnc3nHy1wjByt+mzkHvpcDTQ5Js7ujAABNNy0Nv8fx3V6?=
 =?us-ascii?Q?Wr+iA/IaEWHlb0AF4myTZ7dpQh7fwqITqa86wJZokv+Jdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OLYfmoQOWlWLlBKBsOkXEXZ+NiZ0jbib45WYTAolf9MOPAPrBa6nsequYdUa?=
 =?us-ascii?Q?AnFrZY/B3W2kD9pvdtBc7X2lVFSwynLTe5ot5VMiLhf58bXEHUKAUU49w0Qn?=
 =?us-ascii?Q?nmWZE4BC1+DHMp9KZeGUvxoZEKil50vfwVKDP7wZtCH+FAD2LU76MT5Kb8vE?=
 =?us-ascii?Q?CTOkrmpJMmUJsy2txSgMXNiEY2dV62uflZw7ZH3NqPpkw8gcxKB2TPqV5wpw?=
 =?us-ascii?Q?6oAZAexkuNU+TvYYi4PAmXOoGI8c5sAyaIqAOXC8sw1ArzIMaPaAQM+oYtQo?=
 =?us-ascii?Q?rHoS+2QJ3wbxXPNaGdlBgyKBVH3wuqY5tVWY6Ji1Xojom7xZ1Ollee6NPE0F?=
 =?us-ascii?Q?xi7MZw48hI8V7Pkl92oDE9Jtba1FRtdJ0VZLAs6kCKNtdlD+d9YyQKm8wGHp?=
 =?us-ascii?Q?9SN0htIX59Emwx7dwCWiPDNNFbX047qhwDyfDdljSQ5zDFdmnZC+wutPyCwu?=
 =?us-ascii?Q?sXQgG77NUfUkd5xw6HJvHAHi3HZptQv3NM8yjO9hIPEOofajG9X0UV+TcE9M?=
 =?us-ascii?Q?ivqkaaOWl31Jlc+w6Hvkcs5/eoDowJZF5O8wTt9WLHghwAn95HllIcE9LPgc?=
 =?us-ascii?Q?/7BzB9wL5a0x6ukuXKn8bjjmrfaUvPl1RVwbhOIX23AVAN2vub5up7GudNdO?=
 =?us-ascii?Q?6wjuVzMFcPUakzCUM3nnAWKvObxbtbShkgzNknNu3fFw5T3Lb47tCNig8M+1?=
 =?us-ascii?Q?TpawCghfjY6unV42s948JYjxsN+TBtSqagXFA1o9JB2ef9bSHRpkcAW81Yr7?=
 =?us-ascii?Q?3mnNPXpYkpAPFLypIA2RaN6Etla5RPao1Bbq67JEn3vKF1JeWpXUNb6loyWI?=
 =?us-ascii?Q?lXrWket5pztMQqM2qII6xDa2NlcF19bDldWx5eTpaYs+toD8ZmKR92nEtAn8?=
 =?us-ascii?Q?LNsCXKZ+Ull+VsxoOjMQmJB/e7vDS+oFd2TassBV552AUzbQ5LuoHm5k9M9m?=
 =?us-ascii?Q?/O4BrXT1m7cEpZOAG74vOWt1Zpm/pXCCz8P/bSXs+QCGicJ8hy96AJ3LI3/j?=
 =?us-ascii?Q?/WkYDtvSOLi8ntUroTySg+O2YjdnlBZtG7X7bAfbENK94ruSOHMa+nlzgYG4?=
 =?us-ascii?Q?bVoJzkAtGICrnWLdtXSHeLqKFvWA52m0k7vII9MR8nXcN0yArVFh1ZNHH/VC?=
 =?us-ascii?Q?UtYc6vQGvqv1vGpEw3VPoXZ9WuV+TjHS9KA5aFx5qQTNK8Lvj1mIL1GN9ylM?=
 =?us-ascii?Q?NYbji1hZt/pl8Wz5fuu5vICkaXrWWC9IJe/qxUa+8ZWVFKo56ucS8u2gw980?=
 =?us-ascii?Q?3Zp5bx5K83uK1cMNtSLygkq9Sv7Li1t+L7OOsZI7ddE1g3CFpdCoFigh/x+d?=
 =?us-ascii?Q?0qLPvVPy1WbGXALvvMlmGAuOntwoDH97KSD476Z4UcHGRLcBKBGebCw+4MsN?=
 =?us-ascii?Q?xJXnuva95wsPOMxExWaQ16EqdKs4dUQKD4mehBEdwyPij6szPWCm5E9Zi/v/?=
 =?us-ascii?Q?5iZP+NxzCyi4NZtbn2Bt9Jc/rnS/s33DCuSMrxRbybN+JjCA5mRw3cxEyWzZ?=
 =?us-ascii?Q?rkKL/Lf3HW7zzeH0d8b9KDtWQeMXLaPpa0JnHs3D6HgNagl/G4ZLwZvlaG3G?=
 =?us-ascii?Q?K+lursl9lKqJSObEUPY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c19a12-8f60-4d63-c91a-08dc67531c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 07:16:23.0310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfLr114vt3fA4NOTTGZrmNWvW2yRj0d85IsGcOvQgdZGAf4DrWH0NIrUIUf6AI7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Sent: Saturday, April 27, 2024 2:27 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling,
>Felix <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li,
>Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Subject: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
>
>There are other reset sources that pass NULL as the job pointer, such as
>amdgpu_amdkfd_reset_work. Therefore, using the job pointer to check if the
>FLR comes from the host does not work.
>
>Add a flag in reset_context to explicitly mark host triggered reset, and s=
et
>this flag when we receive host reset notification.
>
>Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>---
>v2: fix typo
>v3: pass reset_context directly
>v4: clear the flag in case we retry
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++-----
>drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  1 +
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  1 +
> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  1 +
> 5 files changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 8befd10bf007..33c889c027a5 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5055,13 +5055,13 @@ static int amdgpu_device_recover_vram(struct
>amdgpu_device *adev)
>  * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
>  *
>  * @adev: amdgpu_device pointer
>- * @from_hypervisor: request from hypervisor
>+ * @reset_context: amdgpu reset context pointer
>  *
>  * do VF FLR and reinitialize Asic
>  * return 0 means succeeded otherwise failed
>  */
> static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>-                                   bool from_hypervisor)
>+                                   struct amdgpu_reset_context
>*reset_context)
> {
>       int r;
>       struct amdgpu_hive_info *hive =3D NULL;
>@@ -5070,12 +5070,15 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
> retry:
>       amdgpu_amdkfd_pre_reset(adev);
>
>-      if (from_hypervisor)
>+      if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
>+              clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>-      else
>+      } else {
>               r =3D amdgpu_virt_reset_gpu(adev);
>+      }
>       if (r)
>               return r;
>+
>       amdgpu_ras_set_fed(adev, false);
>       amdgpu_irq_gpu_reset_resume_helper(adev);
>
>@@ -5826,7 +5829,7 @@ int amdgpu_device_gpu_recover(struct
>amdgpu_device *adev,
>       /* Actual ASIC resets if needed.*/
>       /* Host driver will handle XGMI hive reset for SRIOV */
>       if (amdgpu_sriov_vf(adev)) {
>-              r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
>+              r =3D amdgpu_device_reset_sriov(adev, reset_context);
>               if (r)
>                       adev->asic_reset_res =3D r;
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>index b11d190ece53..5a9cc043b858 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>@@ -33,6 +33,7 @@ enum AMDGPU_RESET_FLAGS {
>       AMDGPU_NEED_FULL_RESET =3D 0,
>       AMDGPU_SKIP_HW_RESET =3D 1,
>       AMDGPU_SKIP_COREDUMP =3D 2,
>+      AMDGPU_HOST_FLR =3D 3,
> };
>
> struct amdgpu_reset_context {
>diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>index c5ba9c4757a8..f4c47492e0cd 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>@@ -292,6 +292,7 @@ static void xgpu_ai_mailbox_flr_work(struct
>work_struct *work)
>               reset_context.method =3D AMD_RESET_METHOD_NONE;
>               reset_context.reset_req_dev =3D adev;
>               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>+              set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>
>               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>       }
>diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>index fa9d1b02f391..14cc7910e5cf 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>@@ -328,6 +328,7 @@ static void xgpu_nv_mailbox_flr_work(struct
>work_struct *work)
>               reset_context.method =3D AMD_RESET_METHOD_NONE;
>               reset_context.reset_req_dev =3D adev;
>               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>+              set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>
>               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>       }
>diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>index 14a065516ae4..78cd07744ebe 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct
>work_struct *work)
>               reset_context.method =3D AMD_RESET_METHOD_NONE;
>               reset_context.reset_req_dev =3D adev;
>               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>+              set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>
>               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>       }
>--
>2.34.1

