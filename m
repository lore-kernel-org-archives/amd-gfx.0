Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEAEC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 08:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1FF10E1F5;
	Wed, 20 Dec 2023 08:12:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C04410E1F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 08:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyHJaT8XJBpsdI9LHguBvBJnx0NCy+Dx7Cny4m7sogjkvJMV7RZOXtaBZJaCGha+yCidZhDX5B/GsQkspaJlhePLEDDlsspOFKKXA3S0GNemdbhpaA1JoNJL0DG2CoL3VTDdCfugqFWNZ5v2LAuh5LZusJmKWVNGSCV+KocKWANDTGTUs+FzQm9vizQdFi4EAonnNuLElPmmmYzUdzOLw/HDKG76ZiPR2aROlLGjIlBu/WmTHIO19g0/T33jMG+1cG7/yGL+3XkSS5Y42jF4x2WBLOGth5qd+tl4S0lSUg621y2dxzybEpDcH/wHoSJhay/CyqiYUEywXEdzhgxMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBdqlBjkm1uGy+8ii7cNHwSll7/Op4CRBD6D7xfvt18=;
 b=ffG2lN7kG6FtQ0CPG7Xr4aHLOwzeEHTJGvx6Mkfu4l8oJam5FsdyqJWKCLqe74YVOavOAkJwmXKpeK17ExIHdBCpAJYfL6yl0Hsi1jiPFTSL0f2LYsTN+PKnLkBlT6kGQ1PdbNc1LFtvlOsUnucdCYFdoPIBBRoV4HAm/jKJVwNzJvoFvuAuVXKvAZ93LNjb9r+WD4UPmSm30u7M9Z9Z9jhK6sjkR8ZCiPR0f0eoiru/V5EfrXmUJwsyhqaa+m84lUnZGOb81FqEl9M4JpYAkKCbBgEcxoxaukKwFIDvdQp9aF/KoIoSVhyGndGwAuzciwxCSI7w1Y6s5bCVuOeP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBdqlBjkm1uGy+8ii7cNHwSll7/Op4CRBD6D7xfvt18=;
 b=FiU/KAkVPQHfsJKL6fsyU+MWCs6vsCSzS8DbAPg6DlugMhRSOLRn3Mc1ZHPMbfAh8d83NADhjA+lg2Kjl+o+dTfiXbLke0jjcFJx0jHCF4S/ci1XJFOKSJO12e3lZVijh24/Ha0hw7MBRoUwDsMe/pVFSVXGY/r+w8Mh4kemSxQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 08:12:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 08:12:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaMnmXKvhZX9P/vECZf0lTqanu27Cx0e6Q
Date: Wed, 20 Dec 2023 08:12:09 +0000
Message-ID: <BN9PR12MB5257B7C02B9FA11BA3750ECCFC96A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231219124738.503604-1-Stanley.Yang@amd.com>
In-Reply-To: <20231219124738.503604-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30653e98-5cbb-49d6-95c2-4013bec9e363;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-20T08:06:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7022:EE_
x-ms-office365-filtering-correlation-id: 3959cfd8-cbc8-4b6a-cd76-08dc01335cfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXawhFU9dMlUyhlFobojxun9DPk5DdBF06JX7etlYiHjf0EPPrKPylI9wZBOrVde2brS/97xhKNvOi5tSsKn5PKnFxHcVdYHvG5vulx850x7zn8ITcoAUAgJTUdjDita77CH7Sgg8uu9Ripll19DjgpKwwnJFhNMyPfLRsEB5Xj7QUlJMruIyemTfpPQrZ2LYTxcJ8Ok4zOsa+c19O1sM7dYuSQd3bd/yHYiQ8WIqiVRkpHwg3KamsoDqm9NhOn/b5Ep6UsJqrB8XYsNl/WBuiIWHW6Sm2TRBxg75FgAKcR5tN0ZZqeFP8OleiJJZa2ivSxMEvv/tOFhL4Ysv9rtxdsnJdMTCcwAEEItiMJywzgTB02FO1FU3AXxlPRHp1nZvTx1eS2vDCTTI4JkKcKokcKNf9oFDUc2rVr7+WnW4d5zAVD9WWw3xDDp+NATG7QKzIlc4+4QMphe47D0DrOkd47CeAgsnLUE3taFx4Ve9KjumTT5weUFjS3pOcqES5cNOfJs2Ym+VgxGpEd1hSXUozOwY6B0mXTm8kTz4N3d719d2nIvx5LEj6XY7XxJMQbuN47czc8+oIClKPmGPjAyG5z0FyyQ2w+Nfr3+SWevyTAVzrD+cdJW76RZYbBxgLcf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(122000001)(38100700002)(71200400001)(83380400001)(26005)(86362001)(55016003)(33656002)(38070700009)(9686003)(7696005)(6506007)(478600001)(316002)(66556008)(66946007)(110136005)(66476007)(66446008)(64756008)(76116006)(8936002)(8676002)(52536014)(5660300002)(2906002)(53546011)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/rhtAOxzMoA4srAGB2VSijXooifP09E4AmLXODGK+crAu/+3UIAOj8kuTmZL?=
 =?us-ascii?Q?+jPePX0Dv5rKLskIhoIaTVv3ohiMm4GK5AMyfKa+rREN+nTfzOa6ACnAKABR?=
 =?us-ascii?Q?KvaPlOC0kbxOXn8jE0nLa24lBgCS3z2ts2hGRmZ5QVR7nQ9JAGzO5PMSZjD1?=
 =?us-ascii?Q?x4I/rVex/3fLtCFDFijjCRxvrAdEaSbdqaMPgyHE3D9nvBGldf25xCtxGgrB?=
 =?us-ascii?Q?UubyZ6LM3MScAX9jJsr97cfJJnx7B4J86H2md44qbqbo4byDQ3xK8QMKLTfZ?=
 =?us-ascii?Q?8Jf0T0hd3fm/tWXPaZagfZ8Xe2FfVXZ7XigYQ09yXaaiN7xsWZpOFas+46F5?=
 =?us-ascii?Q?RIYCDvRF5GyRnFuWevrIeNII4+nx6sgQ0A7/W/JU2PExJBFe80E/dvuKu8br?=
 =?us-ascii?Q?6grcDIwZntkc8CT8/bVYg7MiznOxzMfP33F9lNwEbVXyyOFrBfZDi8DZ7wfI?=
 =?us-ascii?Q?i7ispOrVT2wNCn3HrfLTiLVjx2t7k1OgwG1WAl8G1sU7AL9rg8CwFmFaKvbs?=
 =?us-ascii?Q?c6KmQuo+DNSvqRUUjyquls+PoC2d7vEMKBHAM0RgbO1EY09TpXSNwPmfixLX?=
 =?us-ascii?Q?uucICIIGDTwIlGS0eORLocXxbPyvETuLVkUzjKsSDYZowYg+lU4VGXf7zKCM?=
 =?us-ascii?Q?7jrqrYC1XqL6eQlHqlr7DWEnD/3CmKMvkej9pX3CPvOfuIICSOqs+u628eNx?=
 =?us-ascii?Q?+j5BjUpnNekQFeBknx3vKFQsNKrie60wA8ZZ7oyruzsy6yTm1phN4AQcMUV6?=
 =?us-ascii?Q?L9cY60i1R8r9hvNIR8rNViNss+JfXhuH+SU0fojTf2Mhlpn4fc3OzA9U7Nnq?=
 =?us-ascii?Q?5YQ+1ClfHvdJW3EqCNyKynoXAsYonObT2zykgiLhH8fEZcwdPb1vmhcewVkE?=
 =?us-ascii?Q?dO+0cYfzBAH3xDDM/1F58URoNjH9Ji6CPJPJkbVDdhsYStIGPJ88H8LhbCYv?=
 =?us-ascii?Q?YcP3ZJLblql3fUoe+0HVPaiLLm/MYSeJabMctrE0CmsD3F+c/kngipi3LMsK?=
 =?us-ascii?Q?uksy5m55x47kkAlgOxvzcVE6PCsU1BVVrT8hIy4k/yURZlojFFtMzPbzhyAI?=
 =?us-ascii?Q?aAhp3sKaJe03kLLX++L+mi/WPmUusEeVVDjae9hGcoNN0A/XRv/sPdi6053V?=
 =?us-ascii?Q?PtjAtUOG2387J88MoyCkVh8BlCRF89e4DGgM2M7W4b8EXcflInGJIZ4gWbuu?=
 =?us-ascii?Q?nrDTwhFCRwxY2sEqN3o8qV1NsTUE/wmaMnQdNS20iLWYMQHn0v3vlOFH68rl?=
 =?us-ascii?Q?67J45kF9jzofsRFVzGXOZGJW9BklbNenyaNlPP3L417tzHVu9LN1CNyvH1nx?=
 =?us-ascii?Q?ZD5KfB0C41jxbxbq23bF74V7mQSzaJv86LZK6ACVhRXZC7OAXs8oZNcqmUFP?=
 =?us-ascii?Q?g17dKV884Wqhyn6LcprYFSBocArKohcf615SMaU6e+/z6VyiANzkFBqvCW6P?=
 =?us-ascii?Q?WCi5hegP2QYY/+imOvIx3WMyVw6Lg9SFAJjXFMMKL96Ck7uZZjN3jBlJS++W?=
 =?us-ascii?Q?DSPYv+oTEzgiCb/RKYVHsoTxXpMXzacCBNVJYfclmN0j3jQonISFwPCMNS0L?=
 =?us-ascii?Q?Rl91cFqrdfeh2N2mJHgyMhYjYV7cqeOk8g0KI/QO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3959cfd8-cbc8-4b6a-cd76-08dc01335cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 08:12:09.4792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyUrY8HvDcraDrDHbtsykjzbRV8QbXzJUy9lGAjhHoD3UQkMuT2Pa1Bih+ssUY/zbx+N8YoW24ovtV27q8SlsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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

+       if (adev->gmc.ecc_irq.funcs)
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+

This doesn't match with amdgpu_irq_get call for gmc.ecc_irq, where driver c=
hecks ras cap to decide whether enabling the interrupt or not (see amdgpu_u=
mc_ras_late_init). We do the same check for amdgpu_irq_put call.

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Tuesday, December 19, 2023 20:48
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable unpai=
red

The ecc_irq is disabled while GPU mode2 reset suspending process, but not b=
e enabled during GPU mode2 reset resume process.

Changed from V1:
        only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip,
        delete amdgpu_ras_late_resume function.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +++  drivers/gpu/drm/amd/amdgpu/g=
mc_v11_0.c |  4 ++++  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 +++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 02f4c6f9d4f6..b60a3c1bd0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,  {
        struct list_head *reset_device_list =3D reset_context->reset_device=
_list;
        struct amdgpu_device *tmp_adev =3D NULL;
+       struct amdgpu_ras *con;
        int r;

        if (reset_device_list =3D=3D NULL)
@@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_=
control *reset_ctl,
                 */
                amdgpu_register_gpu_instance(tmp_adev);

-               /* Resume RAS */
+               /* Resume RAS, ecc_irq */
+               con =3D amdgpu_ras_get_context(tmp_adev);
+               if (!amdgpu_sriov_vf(tmp_adev) && con) {
+                       if (tmp_adev->sdma.ras &&
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__SDMA) &&
+                               tmp_adev->sdma.ras->ras_block.ras_late_init=
) {
+                               r =3D tmp_adev->sdma.ras->ras_block.ras_lat=
e_init(tmp_adev,
+                                               &tmp_adev->sdma.ras->ras_bl=
ock.ras_comm);
+                               if (r) {
+                                       dev_err(tmp_adev->dev, "SDMA failed=
 to execute ras_late_init! ret:%d\n", r);
+                                       goto end;
+                               }
+                       }
+
+                       if (tmp_adev->gfx.ras &&
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__GFX) &&
+                               tmp_adev->gfx.ras->ras_block.ras_late_init)=
 {
+                               r =3D tmp_adev->gfx.ras->ras_block.ras_late=
_init(tmp_adev,
+                                               &tmp_adev->gfx.ras->ras_blo=
ck.ras_comm);
+                               if (r) {
+                                       dev_err(tmp_adev->dev, "GFX failed =
to execute ras_late_init! ret:%d\n", r);
+                                       goto end;
+                               }
+                       }
+               }
+
                amdgpu_ras_resume(tmp_adev);

                /* Update PSP FW topology after reset */ diff --git a/drive=
rs/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 09cbca596bb5..b93a0baeb2d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

+       if (adev->gmc.ecc_irq.funcs)
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 416f3e4f0438..e633e60850b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
        }

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+       if (adev->gmc.ecc_irq.funcs)
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        gmc_v11_0_gart_disable(adev);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 205db28a9803..8ac4d5b7fb37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

+       if (adev->gmc.ecc_irq.funcs)
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        return 0;
 }

--
2.25.1

