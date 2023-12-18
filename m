Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701CC35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4D210E094;
	Mon, 18 Dec 2023 18:19:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C3A10E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:19:09 +0000 (UTC)
Received: from PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 18:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVyHrLxrKMWIWiIWR0uuGRqahYKHdJlTZ4zldmtP/AmpbGh7F1dUvDrO9fiTGiseP1e2/WeebutAyfY7jxFOlpVUtc4nZJMy/yZiL+tuItbpC20JFfQd93Aq5/ALNgD1NkPnF/mQQ5ffNI3nyQin2V77Gz2TgK+4qUtRJRgs/1bvS+f3J20K2AGZCaxumX1MsTGX4Bh6EhDdzJ52g47QIHCXkDQqGj57cr4KbVVc9C/mRml/QJ2T/L/iODioiTgkOkMyMViUvVaM50SCdONBPAH/BPoCCojD0dUijU/27iSayncBNTA5Zd8CBaJlGPcv+QSEA3G6VjjlT83EnYj21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mipNWKHW9gpNm8V1OgXtbnmUMtHMQ4GqBwbdYXFIwUw=;
 b=BZxA1qmraJjmc8zRmBhdBXYboul2TnpU7eWah0rrr048O3oOir/yLxKC1FQKNBO1bFRehULPI6MGI6zExnUc/kLgvZpyvJvYwHp5jI8Zh85x7V3Ysc5mznfj3sB217ulLmyZcGaWhya4vcGH7UOnAdQrWkc5z6OFMxMFLxmWwCFfWY79WC127lbi6MrgL5rQ8d8HvVXk9dt7NTBfMAs1zXwcLfis1o7lD/zk3mDuswvOkKkgA6CcrBYflKMo7+D1a63pqjPuFjNr2aQTcVHc8Stao0HgE0YjKXQjn2fYkGhvSlNekd5U3uT1BGxoDNnDSv/91pLQFVMrMV4n/Tyd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mipNWKHW9gpNm8V1OgXtbnmUMtHMQ4GqBwbdYXFIwUw=;
 b=dl/eZT8Yuh7R8d3/G5/n6HtL6ZiqXPR/8mKl1K81nh0aumhP0Z8v1xoDA17TyaJXoZTWWlONUDTRwANLyxFV9rvMHN+bL/MiTBU5hdCQrHnJdl/UIWNCo+zsZctpg8cNTsG+ZhStVjW9dCgOv7kgCPq07THITbJWmRME9NM4yuU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:03:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 07:03:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaL3bQnlofGxcWqUO57M5Dij3/kbCuoUrw
Date: Mon, 18 Dec 2023 07:03:22 +0000
Message-ID: <BN9PR12MB525719E4C88CFB696CEC22BDFC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231215164952.449464-1-Stanley.Yang@amd.com>
In-Reply-To: <20231215164952.449464-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fda94616-97d2-4cd6-b9ee-05b1d8b817e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-18T07:02:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB9176:EE_|MW4PR12MB5668:EE_
x-ms-office365-filtering-correlation-id: cebc7b9c-32f8-464b-07d6-08dbff976c25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9MNFd6z1E5uEkVCgLAOH4tkrw18TfyN5qd6m+0vAN06dE4a07fT71lqmYKD+dJsnG72ZsLmqWhh+l2tbnePeMR8NFIVS6fXtvOHyp7dLLH/83MWnHE65dlHNVOgHburfYvSNbYzwfRS3epXOrjjSLCbP8vCmcatAK7kwXFcuT7JTvdC+mXOkL/IPkqModf3VydLMqzbSV9PN4+x8Qc/eJhKwM/WEel5mAPy2hCQt4OyNurRn15JRjyL6c3t4/02hNbCi0SpSlmAgHjRzeMyMH7wSPncEFum3GPCCqp6UlQb7EVyLhOPFK0v2Q+xAcXYBOwE8bKUkKOj87NyRQWPrpMKJgFjtizU4ICgfzh8AmDDtVtOVciAOriGQ8oQzOF8nBrkESQXWRvIlR5FkrS6/HMi/AgDqNy1Nx2loHaB/OfT0sy6mE0AorpxaHoLVpE2XmL+uUQgjE7u42/JGKUr7mfgIql5TmrWmKUjJLfUmcBHcnIFYVDFp2dN+AWeyASGZw6sG3s2PZsqE2FCdA0hAhCmYaMMYBxjncv8czL/jaBUSMGh7fNOX71k7D8eVXjPqeHHXtk+XdyuuQ6egx/tVP5WCXyIt5MLRxfDtmN9DNFKJTS6pkXg8DIKEJ1MArcy9hMA0Y5QZtsam7BtG06Qxb+UPlbRaBqSyBxlSK6mQDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(2906002)(38100700002)(122000001)(33656002)(38070700009)(41300700001)(86362001)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(110136005)(316002)(83380400001)(9686003)(478600001)(71200400001)(55016003)(26005)(6506007)(52536014)(5660300002)(53546011)(4326008)(8676002)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VX1z6dN6YvHsxUTGjv4rMUsMaHtnFWt1YTelPWy9qd8gHZFc4bDd19oT+1sy?=
 =?us-ascii?Q?OLYmouiPUkgSmX4CU7Cuz9vGsgmadKPkkNu0XkafImqrIASzvxY3k5ak4jXT?=
 =?us-ascii?Q?vuVbBA/3vkWzH4dLkR8OjlWS9hveA08qmBtAmZa4eMeY7plIKW7uWne2pQMI?=
 =?us-ascii?Q?eRrAOHtIfsUFbDQq91aZbgnvmXxSWujjBm4SvQOovZUKu41Gb6C6uwDzqOsd?=
 =?us-ascii?Q?NqHOqVH3Yft0rhqfxdvgP+t0Rf5t5Ik9c6KzbG3cc5VHSWHh+3cVWd/QSae2?=
 =?us-ascii?Q?8ewSo+XHU++7JOB1kue04bO/bEubpsP7fcl1U0aT6M9PO+jMq/GJRC5x+24Y?=
 =?us-ascii?Q?e8v75P/FWFjU4zj8Zz5U69fyY8UifnTWb24/g/MgBBwVvMvm4KC4sK1SwqNg?=
 =?us-ascii?Q?IfFfeRDLYWcDfwKRbSxYCGBsR9QvUOnUS80gViYptuX0Q0sYb7Ma1Ys+n/xm?=
 =?us-ascii?Q?Z1dNgkjr/6S0MNM60FRIo1kknciUEt0pzx7tq5Y/Q5mR7bCW6qXoGp/KHlfY?=
 =?us-ascii?Q?E0YonMnWaaG8finLYEHz5bRcFQc/T2qWuqrkxv3N24ASg1boPGf6oWZvDNt5?=
 =?us-ascii?Q?wm+CqBLj0vJfmjXliGpzc9gw5xdvaLPUp75QE832NSgV4Tc0Dot/4e49K4hr?=
 =?us-ascii?Q?zQFGcJLK+fehToqqvcVXrWiXnYSoWGNPcvo0D2bcQdQGAGsvAoyZQQs3ZSLc?=
 =?us-ascii?Q?VxunfbMJ/LBnTEv0US5Wpb0YvuXR3iPdNZi/6QqZsx6ZR1YcQk4L3p7BNw80?=
 =?us-ascii?Q?zOX81/8qe7uEtAIL8ox9BWF5rfjp21B579S7YlrGZw123olisEirrhXiypxi?=
 =?us-ascii?Q?kF6FVjasB4ctj/n2qgtN8xKdoeUcJfTGhTADLUr6WCeScgu8DQQpB2i2212o?=
 =?us-ascii?Q?ZH3BoZOqwpmFkuhr2+KoESe17rp7CDKLSKT1dnRi4wd1z6BbAjx+cHFj6uvN?=
 =?us-ascii?Q?M+UitMAaXCNtL6/kTdmsV38oFo61QLpqEFPQai406PePqcizbI+M67somPzc?=
 =?us-ascii?Q?CsuutJSlcVsodnTPL1a5+mTX4YNtxYj7ET1N3bILEFKD47UbiVaBLL4fp75r?=
 =?us-ascii?Q?BSfll+L7Dz7k2GW3Fr/PkETV/8WM4TOm3CsCbj2qoXONUWTMKUdGniu7XNJ3?=
 =?us-ascii?Q?t2Pc4Bo/0E0ziKIto/uHnIDlDEDDiJFwsGqfZikzcKm+wgW7za9sX5yFUrwY?=
 =?us-ascii?Q?P3SJMC6t/4awLrt1IpEOluRH3IbyB14YNMGKHNbQzF+PYL7+JEaxFW9sLp+a?=
 =?us-ascii?Q?iCRMHENCvCiIsZXwIEmp7DJHGVV4zSzTsODHd57SOiCOxySc7ZzT3x3bd7rI?=
 =?us-ascii?Q?/eeNxeBs31Muk5yUDUTEtn4YtooU9lVLOS48ofFCdLviBmdFmbcrsttWfFg1?=
 =?us-ascii?Q?6PW4gXNoClJ3Y+EQI0OVpYX9DTQXM5YzRAtCAOgfO1Iv9d+eTw3BGScjJCq1?=
 =?us-ascii?Q?OjX5ym7IgVCUtpCUNUJmEcvH+w1a6bGYtUxx8IOpBMOY1Rxc42TSY+cYWFnp?=
 =?us-ascii?Q?UHZZVsxC/hdfu+7m0H6EVaw2GQZJxabv5QyB0oRB2OrTtViP35avGJhlwdZ3?=
 =?us-ascii?Q?LgzwopN3f+Sm54vL7Ic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc7b9c-32f8-464b-07d6-08dbff976c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 07:03:22.2090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPS0DtrnjF7ZN4IR9g6LXzI+19vSQ1C2hI1hpa1m2Yiloow1Xlo3ZQGGCxupvVXHmntH+pa+7BI8LfF7D2CVRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
X-OriginatorOrg: amd.com
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Can we put the irq resume in amdgpu_ras_resume?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Saturday, December 16, 2023 00:50
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired

The ecc_irq is disabled while GPU mode2 reset suspending process, but not b=
e enabled during GPU mode2 reset resume process.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c  |  6 ++++  drivers/gpu/drm/amd/amd=
gpu/amdgpu_ras.c | 37 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.h |  1 +  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++  driv=
ers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 ++
 6 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 02f4c6f9d4f6..ba9238a93064 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -358,6 +358,12 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_=
control *reset_ctl,
                /* Resume RAS */
                amdgpu_ras_resume(tmp_adev);

+               r =3D amdgpu_ras_late_resume(tmp_adev);
+               if (r) {
+                       dev_err(tmp_adev->dev, "amdgpu_ras_late_resume fail=
ed %d\n", r);
+                       goto end;
+               }
+
                /* Update PSP FW topology after reset */
                if (reset_context->hive &&
                    tmp_adev->gmc.xgmi.num_physical_nodes > 1) diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_ras.c
index 8a04fb6c7c1f..318e77c493f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3164,6 +3164,43 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        return 0;
 }

+/* Handle mode 2 reset, resume ecc irq state */ int
+amdgpu_ras_late_resume(struct amdgpu_device *adev) {
+       struct amdgpu_ras_block_list *node, *tmp;
+       struct amdgpu_ras_block_object *obj;
+       int r;
+
+       /* Guest side doesn't need init ras feature */
+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
+       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+               if (!node->ras_obj) {
+                       dev_warn(adev->dev, "Warning: abnormal ras list nod=
e.\n");
+                       continue;
+               }
+
+               obj =3D node->ras_obj;
+
+               if (!(obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__SDMA ||
+                         obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__GFX)=
)
+                       continue;
+
+               if (obj->ras_late_init) {
+                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
+                       if (r) {
+                               dev_err(adev->dev, "%s failed to execute ra=
s_late_init! ret:%d\n",
+                                       obj->ras_comm.name, r);
+                               return r;
+                       }
+               } else
+                       amdgpu_ras_block_late_init_default(adev, &obj->ras_=
comm);
+       }
+
+       return 0;
+}
+
 /* do some fini work before IP fini as dependence */  int amdgpu_ras_pre_f=
ini(struct amdgpu_device *adev)  { diff --git a/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6a941eb8fb8f..5c1ffc5a6899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -693,6 +693,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error=
) {
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);  int amdgpu_ras_late_init=
(struct amdgpu_device *adev);
+int amdgpu_ras_late_resume(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);  int amdgpu_ras_pre_fini(=
struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
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

