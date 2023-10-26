Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE332C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 07:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385E610E070;
	Thu, 26 Oct 2023 07:27:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FAB10E070
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 07:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEKKcVU29wfrGPJf0uygBhsuk9+9ym96hPQj4dDkQK4wL/vxaTyAKv+qEqPCkPeqjAPmA8p1HF7sG1vnwB01l3cRjo3UxDbv/S79oVHobZQRhPW3h7ZRq4sQD6M/C2sQ7v9pEDefl0DAhZu0PV1b8D/PB3OoKmzyZyB9HnO3GCcZbTngWQwmJsmnZwMGr35tY2ZlFWGc92rdPIhCi7s55z7Jdm6NgtIZhZdJf2OCFtG5cogsGN3pONc3Y1PXqt0NVEfpWxw9em9iOBXyp8RFCe1Hiw1wLx/QhhNvijRa/f7uu+zgZ9II3caBhyKKMiv4nd3lE5zS2O7qWsI5M3dypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+kt7PSQcHThsojLLU8GHWDoDDFeg9vymAikZOqVIyM=;
 b=ofUAj3SFolk4Iw6m5m5SIi86vUzfSwA1rj40zJPhgnXydfQO0tvk95pxjtbfye7GPhLcy50qXyvajymyn3lT91/wJgFERwz+v1DsapUBO5ylIJW30tcS0kMdiDaVM3bhE9rwwtBc/El71X+5QKspaLoNqaVQfV62dgz87kF74vDnDgNC200u2yZGUcIo+MKCu1TkdKw31pyh4fUyzrULxArmRCnai+q9Ff2PcU7kLylTNRj1UM9FxWijqZtbBbyBqFhpIe8vmYtxKIu8S/dPE9A8FdLnJV8PzmIYUa8QrdL7SoIldfDDm1MBj2kMPgSOX+bLXju69l9hKEW0evswQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+kt7PSQcHThsojLLU8GHWDoDDFeg9vymAikZOqVIyM=;
 b=HHTWXxBHHwtV6t964kYtKi05ooBCZif9cxPn4SNNNDF7L4wTC2NxnEDiIjC4gIOk05MlqvaqApLmJSHT15eh8nV9kQwY06cztLPFkdw5xcGXR86yAKu8GFi4NKfOjKXPe40HKgG7VeEACVX7rTGQXYES5LT1L1F8S/Sc/3bX3I8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 07:27:16 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 07:27:16 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v2 3/3] drm/amdgpu: optimize RLC powerdown notification on
 Vangogh
Thread-Topic: [PATCH v2 3/3] drm/amdgpu: optimize RLC powerdown notification
 on Vangogh
Thread-Index: AQHaBolX0qGbz3P8s0WylecAkp007bBbrnoQ
Date: Thu, 26 Oct 2023 07:27:16 +0000
Message-ID: <CY5PR12MB6369179ED4810CA54AAEC962C1DDA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
 <22f555d910959a9eacc915afbb1c8201c564fc35.1698158958.git.perry.yuan@amd.com>
In-Reply-To: <22f555d910959a9eacc915afbb1c8201c564fc35.1698158958.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=086c40a0-ea97-4cd3-9d67-f52a3d79bf79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T07:26:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW6PR12MB8916:EE_
x-ms-office365-filtering-correlation-id: 373a84a7-2ed6-4548-5647-08dbd5f4fb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oM8CH7WO0pD7MahqxDt4zK1N/kFU0HRRqfJMWHOVjbu2Uny4qOQ/JX1imBebQXB1ZrAa66fnVgAJEd4AG9yjpgFIisziBKebEI1rdcdVeUXWN+RFfvaMZp/VRnu+b04DGbzM2IZHSUJQf5q0SANvh12tTuOIY242JVKI+qqE3hM4pQZE91Qk3BVHXP4C2dDhnj8Av2svusUDoLgS0tZb4LVdYMCE04MEfjwG0B6d92h0qRJJ3fE8dc7ws/HZR7mASVC53500Dq8UFWvn0IPsULCQhW17HYwDyQDxkbNIKWRpFOco73n6uKfyx2FnplQ6qtF2yDdZsukiV2+tShDSTBHZQvgtmOkl/3hJSkP259i2U7V62eTfgNtD6UoHaZ9s5qrlYLy34GrAOj6tuIQm+KDX6g/A1Is/OhOZ7+oHHObKn7ze4KcFtkyMEttCTQ7lPu3LBUostbGjYuIxxj3zscNHjXqzuds2EwxJRhY4mjYRr8XPyY2EjSRAQBD5IZCFLaQ309mkJhE9z7DV7DaAj97Mxbyl/WdcBBXb6OqzRgWHHnig1XjcTshydeMzITC2MaeMNma8F8tKL95hfee4xYSdB9Eku09rmi1tP2C+ZxIdFP6B9Lq64XUJG1UxTbmd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(26005)(38100700002)(55016003)(122000001)(2906002)(6636002)(86362001)(15650500001)(4326008)(76116006)(8936002)(8676002)(33656002)(54906003)(110136005)(71200400001)(66446008)(478600001)(64756008)(7696005)(6506007)(52536014)(66556008)(41300700001)(66476007)(66946007)(316002)(83380400001)(5660300002)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gtapIuNjeb+nEyoRNEuzRpYYrejZUx2SeY0r7MLv+/7DKFV3Lb41RCTVUVRu?=
 =?us-ascii?Q?yfCWmPSFSmnBC28p1BtchyB3rBYxquxpmOEZIzBcLb0FRPaDax4CCvFwyVC4?=
 =?us-ascii?Q?QQ8vs0EujqY/C8qPQCViaLQQqd/5B1U8a0EEDFP1vdAn+yG4r6sV7PvVbZPN?=
 =?us-ascii?Q?9NGOC3c3ArOoBEQI5DOLvseRxSNZrzJk30+2x6H3u3jIJYzmJ84XFaTNGDpe?=
 =?us-ascii?Q?hKxP/8+0OubGCunIQHubxUH88A+FGVPa4qt5N+mnRk/RTX/QCzz755fdu25t?=
 =?us-ascii?Q?LN95PA3m9JlSU1sbXXSjz39+ChhnXGONzOIPBLfh0BsjNWT47qa9VutHGPPR?=
 =?us-ascii?Q?3AA3OnrNII2xtTgwQXs39Ds1A6jHrAlR4ij8xL2Zq1RQgF5492M2Vw+/HxHv?=
 =?us-ascii?Q?eOboSHFatdd6bNB8w/DjYa23/BwdbJl8BuKIr8T8Skg4udctllr+Hv56df3M?=
 =?us-ascii?Q?/Y6ny29DQcAjArABS198ca1h0d/K2grjbGG4LoXgs6ebvucuvUvnuTxZNKq9?=
 =?us-ascii?Q?FqMm4cC+zVzvOvRFYWZxxWlltv87R0yI4230OSTTd8qCZv2N4gxbkf+rkBPS?=
 =?us-ascii?Q?RvpJfUr2oqwIG5KfDNTsl/Y63OKZv6I1CfRY6TIVcIeAf6NKgfMmd2QJMybr?=
 =?us-ascii?Q?Cx1XM5/TKMIlnjNLPZDhLWtW/jpaHA7GSWWby1FZyvWNDqapXSp8hgdikNN8?=
 =?us-ascii?Q?X1hq/59Co6VxBBPbuy7bJB41o8iS4nKx83mzzUOs4whs0wAub+rWzo5Ro9lf?=
 =?us-ascii?Q?5ytbT4sIV0W4xZ8e2pSPrgD+ooxHzyDv0cI5euFU/c/YzlSJ3zHLbrKL5JlK?=
 =?us-ascii?Q?K6C4y4XyIcMHXaP2iSzZPUOik4PXT6jXsuT84CVh1GjtxATePYICM40056qh?=
 =?us-ascii?Q?wTCAZQ72ry3axMXoNyjucauHslNdx/MwODZ1AvtJnmrzz3ouY17jl+C3soEL?=
 =?us-ascii?Q?rUfLXo/TmKK20bE4GMNpxxGnqpePx3ufGi6CqydanEzk/uXYXb1z5R8iOqd3?=
 =?us-ascii?Q?bz/4XJP+zQpc87PP0LJasGoFlPcNakV5EsM+CYAKC3/0IaK2ytd+kYgIjxuR?=
 =?us-ascii?Q?iVeZyrkYeeL+bVLSIhtTM7SpByxvvshuTD73y5CyYE+hHmQYxRJJcrvauaTu?=
 =?us-ascii?Q?dMH1zRunHmXQR6XmdnjqQERI1VCviS0mbeGLtIJxcdbhtRoH+XuSDgLqmUTd?=
 =?us-ascii?Q?zwSvjoVTJu6NLXf67zegA5o45RMxkbQmDIbHqD3EsZU6ep5qSOJSBjOZM9bi?=
 =?us-ascii?Q?mjO9NKOW1lpG5uGMBb9/BfEF+9DGsIcABAuhYx64T6wkQB6X6B+EWVM2pzxy?=
 =?us-ascii?Q?MHzPX1r9KvRGw/CudCFOu/4rNGyae/8dtjHUuD/IadXV63iF0R9lXIYjio1n?=
 =?us-ascii?Q?Es6SYxtthmlIEzuF4itRklpwrlSfuTba37hEw7ZDITZzkhuQVKCA94f+7yLL?=
 =?us-ascii?Q?eyUkpIKsYaAEdScVkt4vAimNOFwsfGZ2/lAT+vFUJJr3Wblc5L4KfVIWJaRL?=
 =?us-ascii?Q?36/T+z1rmH9P0/DsuVvMxo14K6Z38xu0Vpj16Vti/i8uVgUWuGO+fxWfsC0I?=
 =?us-ascii?Q?ThghTrXxLquGeeRusBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373a84a7-2ed6-4548-5647-08dbd5f4fb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 07:27:16.4709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VW6IT+oidl34bfn1DkqgX4e8ASFZGlVZ39vVWkhA6OCCoYwdy2+k+7DiSsrR8+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, October 24, 2023 10:50 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/amdgpu: optimize RLC powerdown notification on =
Vangogh

The smu needs to get the rlc power down message to sync the rlc state with =
smu, the rlc state updating message need to be sent at while smu begin susp=
end sequence , otherwise SMU will crash while RLC state is not notified by =
driver, and rlc state probally changed after that notification, so it needs=
 to notify rlc state to smu at the end of the suspend sequence in amdgpu_de=
vice_suspend() that can make sure the rlc state  is correctly set to SMU.

[  101.000590] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your pre=
vious command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000 [  101.000=
598] amdgpu 0000:03:00.0: amdgpu: Failed to disable gfxoff!
[  110.838026] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your pre=
vious command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000 [  110.838=
035] amdgpu 0000:03:00.0: amdgpu: Failed to disable smu features.
[  110.838039] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  110.838040] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspe=
nd of IP block <smu> failed -62 [  110.884394] PM: suspend of devices abort=
ed after 21213.620 msecs [  110.884402] PM: start suspend of devices aborte=
d after 21213.882 msecs [  110.884405] PM: Some devices failed to suspend, =
or early wake event detected

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  4 ++++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h    |  1 +
 8 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cc047fe0b7ee..be08ffc69231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4428,6 +4428,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol fbcon)
        if (amdgpu_sriov_vf(adev))
                amdgpu_virt_release_full_gpu(adev, false);

+       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
+       if (r)
+               return r;
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..4eacfdfcfd4b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -444,6 +444,7 @@ struct amd_pm_funcs {
                                   struct dpm_clocks *clock_table);
        int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *s=
ize);
        void (*pm_compute_clocks)(void *handle);
+       int (*notify_rlc_state)(void *handle, bool en);
 };

 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index acf3527fff2d..ed7237bb64c8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -181,6 +181,24 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *ade=
v,
        return ret;
 }

+int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en) {
+       int ret =3D 0;
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+
+       if (pp_funcs && pp_funcs->notify_rlc_state) {
+               mutex_lock(&adev->pm.mutex);
+
+               ret =3D pp_funcs->notify_rlc_state(
+                               adev->powerplay.pp_handle,
+                               en);
+
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)  {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs; d=
iff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_dpm.h
index feccd2a7120d..482ea30147ab 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -415,6 +415,8 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);=
  int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
                             enum pp_mp1_state mp1_state);

+int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
+
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);

 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev); diff --git a/drivers=
/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_sm=
u.c
index a0b8d5d78beb..a8fb914f746b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1710,6 +1710,16 @@ static int smu_disable_dpms(struct smu_context *smu)
                }
        }

+       /* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
+        * otherwise SMU will hang while interacting with RLC if RLC is hal=
ted
+        * this is a WA for Vangogh asic which fix the SMU hang issue.
+        */
+       ret =3D smu_notify_rlc_state(smu, false);
+       if (ret) {
+               dev_err(adev->dev, "Fail to notify rlc status!\n");
+               return ret;
+       }
+
        if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2) &&
            !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
                adev->gfx.rlc.funcs->stop(adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 839553a86aa2..7778a98f192c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1359,6 +1359,11 @@ struct pptable_funcs {
         *                       management.
         */
        int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enable=
);
+
+       /**
+        * @notify_rlc_state: Notify RLC power state to SMU.
+        */
+       int (*notify_rlc_state)(struct smu_context *smu, bool en);
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3efc6aed28f1..b42771471416 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2202,8 +2202,7 @@ static int vangogh_get_dpm_clock_table(struct smu_con=
text *smu, struct dpm_clock
        return 0;
 }

-
-static int vangogh_system_features_control(struct smu_context *smu, bool e=
n)
+static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
 {
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
@@ -2532,7 +2531,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =
=3D {
        .print_clk_levels =3D vangogh_common_print_clk_levels,
        .set_default_dpm_table =3D vangogh_set_default_dpm_tables,
        .set_fine_grain_gfx_freq_parameters =3D vangogh_set_fine_grain_gfx_=
freq_parameters,
-       .system_features_control =3D vangogh_system_features_control,
+       .notify_rlc_state =3D vangogh_notify_rlc_state,
        .feature_is_enabled =3D smu_cmn_feature_is_enabled,
        .set_power_profile_mode =3D vangogh_set_power_profile_mode,
        .get_power_profile_mode =3D vangogh_get_power_profile_mode, diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/=
swsmu/smu_internal.h
index 80b3c3efc006..64766ac69c53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -97,6 +97,7 @@
 #define smu_get_default_config_table_settings(smu, config_table)       smu=
_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_tabl=
e)
 #define smu_set_config_table(smu, config_table)                           =
     smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)                                   =
     smu_ppt_funcs(init_pptable_microcode, 0, smu)
+#define smu_notify_rlc_state(smu, en)                                  smu=
_ppt_funcs(notify_rlc_state, 0, smu, en)

 #endif
 #endif
--
2.34.1

