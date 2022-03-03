Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 14:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC7110E4A2;
	Thu,  3 Mar 2022 14:39:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E61610E4A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 14:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4ebrcFY78SN27nd4RiADx+XbC+CYv9Gmdv34RQEnt/EnXBQnuDvm+ESM+cXpfYxqH8gROViTA8gYsv08CZF1Ak7x3QofEj63F3D5KqOKfIY1aEVHvqXd2wd/poUgGh6pR3ui1ufijaRi53bk4veQgKs8Ryv1Bvi0kkk1Biwh3fCM7GN1b/aayxdn1+XzUajZt+ZAts7SvQSMMPV3Y1YT9vLvcnWlsy/gbcz7hJMDyMmLwBCv5ZYgGyaMI4zw/5MkbgzwdvOzyiafXGg+QTVvTU0mMV3k+oXR1RQR3II4ztohyWLN9O5wOjR+vDAfGAH/tU2urBcvx3Z2VnCGtgaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzSgpfBXR4vt/oqdJ1cVTU8NJHmMnEEWCr4eBvIvvoo=;
 b=fO0BdX7nC2WbkgC48xe7XsBLjQ0fp8ljSuRRGlQT73GGNHjru4USxQbQ+b23bLxl+TMkcDP6FKj4+nQWJG2NopXiQKkE1MhLEZYAg354wMkFnYmRq9WPVhe3J4C4VQ1cHaPhziSICDVbfEamg/7k3rYguYnDOhUm6GiK9RY5xP4QS0OrFTMpYWpO1KnU2IhYpXEkTUYYKe5RIUu790J38sSrOv4qF5DdmicTglOyNwG+MYnR2cd1myYVXBaR8vnU0qbUm1gxjZt9Lmfq9nh/7XQGMnwgoAUwYOpAkIl7C+pINts7atIZOI7KcHso3T/qLbJXyLGrP1j7dU5QIHSM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzSgpfBXR4vt/oqdJ1cVTU8NJHmMnEEWCr4eBvIvvoo=;
 b=pDOecG1cpo8rCD/Zn5cne00lLyPU0wxPA3epL0qjF+FKvnyiCiwn+fNeo5PKkA6HSvRFVoJhOIKdnkQPknz1TJmNtkrjUKiYt1Hzg6Q4122+805vhdXVWBQPvD3HyH//KNzP2mFEXQdGLItfJ2Ga8ox1BXp8U3HryzHVi5e0QGY=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY4PR12MB1365.namprd12.prod.outlook.com (2603:10b6:903:43::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Thu, 3 Mar 2022 14:39:26 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb%8]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 14:39:26 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/vcn: Update fw shared data structure
Thread-Topic: [PATCH 1/2] drm/amdgpu/vcn: Update fw shared data structure
Thread-Index: AQHYLnwYZiedP8BGgk645AAwWjOlIKytu93w
Date: Thu, 3 Mar 2022 14:39:26 +0000
Message-ID: <DM8PR12MB5399F52AE52DB3000EB65E47E5049@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20220302212510.1743386-1-ruijing.dong@amd.com>
In-Reply-To: <20220302212510.1743386-1-ruijing.dong@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=aa8a41f4-6a3b-42a3-850f-ab2a5dba40f6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-03T14:38:58Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e0524d8-99a2-4f5b-e394-08d9fd239e0a
x-ms-traffictypediagnostic: CY4PR12MB1365:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1365779FDD14C3D9544B538DE5049@CY4PR12MB1365.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8XOq+Dmnzkf96zTi5WsBfx1YjPyvdN94kAnvpPaPCujMJheAR2ulCu4JS0HaArsbtm22zuyZ0+tcXF1jzEXJ+numea4Z4ML2FT8rjOCsH6LsnMT6KiQs4gppXcvO/BUgSnEw9YCguOI/iKv5okEU/FM1EZaHFrngO/B+EHbqnosvnbHcLish8jTSW0HeXgI2XDI8VQKm3EVEXSzItMNcKBacoVc4VeqD9uEtcQ8Hfcbnr/2Nl1nw/Xopq0O3XWIJJ6oKiBIWEXb+k3/fmsh9zFMZg7sfA4jbbQ06tZPdELfkPjngPPnGw+rRLs0aB1DJ2J2kV1bK4RZ9tJTH5ITSVRVAOjP5eQnRbztWu2i5zOexWpuRLz3WrQRULH7qZ/mAn7BIag0fdnVXL/bbD83QgMhNFZPUetbUymjVfeKkGSKCGAWLSHoXTLoVuFNOQzTD//vBRBqHzM5KiAI37nWhQpTrrGI+H4mtxUSI8mg48qEmSzp4H3hQe/uTStnwMbXIjew178MdkWKbHZUCHPwAX9002nzP+spR28EFs0vOlGjtLhZtSdz7Yxu5+BTDNNp5HrUJOv4RH7xjRoTU65pbxB02dJscosXH95iUFMA6KOoTPORO1dSlC6Xik0EltCRBO1Rw/yhyhsVhK4KxLYwkDwakiDMXqkkMTT/2KzOvrgERZXr+uucg8VZVXNGbbkxQqq2O874jp1mnMolF4Krxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(71200400001)(6506007)(7696005)(64756008)(508600001)(33656002)(26005)(186003)(9686003)(53546011)(83380400001)(66446008)(66476007)(66556008)(66946007)(38100700002)(8676002)(76116006)(55016003)(2906002)(122000001)(52536014)(86362001)(15650500001)(8936002)(30864003)(38070700005)(4326008)(5660300002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hE+QspUjFNgjMHFylgKBbI/qoiYVhnMXJc3MZHeUpO9AF5v2j6NFtzSmMqPt?=
 =?us-ascii?Q?1sdQAkTpDhGr97FgINUxQ72r1I6MkRzy/5zHLydZ0zImiRnTV6LbOquzrfNn?=
 =?us-ascii?Q?McPhHKPzLpAde2u564cy+a1Hgi6zHwprc5t5asxFaUXyTXr9ozm2O34jKs5F?=
 =?us-ascii?Q?6KOmr4BBGsdelmBwiKlF5vA4BcRTXbkLkWeci5hErnzDyu9vRPM/05AMrpDZ?=
 =?us-ascii?Q?/yhVb7fK+k454lSCqhe4n8zRJJYI4yi4SC1vonn8tKWaKazzqo23znq1PlJb?=
 =?us-ascii?Q?MKZb9DW13ztuwhHuSxyHVCPkXJoMaVkUZJlrHDFkAzD3eoqFjQGzxh/kdNW5?=
 =?us-ascii?Q?A6tfFRVuDagUKVSOIGROiEnT5/xauE+xvepEHBlSKuB7weD2xdD7e4AdFxjE?=
 =?us-ascii?Q?6oWMjCm+eUMJ08QSiX2j9LowXd8k4m/ZeCP2OFVLhkI0SjKaPf1DGsEAvylP?=
 =?us-ascii?Q?fUuKU7vbx0IbaI2lnO1ccDEb67nubhXLW7uzPHLvDIm+0hDj4yu+8NfihALf?=
 =?us-ascii?Q?tSB8+zJkWe6g67JTuKnRM+xV7Esrf84pWiwFsy7UvkVagbHy/yVkk+YvmQqz?=
 =?us-ascii?Q?3Qm5fUYGD6TdYJYxXOuRMZ0kqE1B2PJCs52M4yYh4879S7t+oz66D3sfDABF?=
 =?us-ascii?Q?HOEDwXviJ87xQi+jQFprJbBv2h5rY3FLKUzTgISJFWTUJ+t/Gj/Kzc/gQGD6?=
 =?us-ascii?Q?zT8dcfOOyac8K65184eVWrA8MBafSQ0Lc2sh0WvyJdhav4mpO351CZPqeFna?=
 =?us-ascii?Q?M0NvavKPR7H5AT6sLQI4zUnQJIRrZy2JShQW5zQQGYNaJr5IWQjkJ1F1Ngkn?=
 =?us-ascii?Q?tbCJbHG9f1xYrHJB33SRF9GcE0gprYcTDL4MqmMTABOtqCImXM6ErqBTA9mf?=
 =?us-ascii?Q?X1ALsvSVhrl3+3X8EPM/00OC2bAaZ7PKJYVTfwEMbi3mKWqVcdItuwnzkX35?=
 =?us-ascii?Q?lvkxpegs40C2EZZurCgcNmC5YuUb1LW+s3oD2ZiQvNSQ6Wd5t1YP971avEon?=
 =?us-ascii?Q?0l9KFIKHYaEVhGme7GMTJ8qpdte3h6PElzEaXfnYfVxS2RTSJk7PWr2HR2hn?=
 =?us-ascii?Q?iv4mmSJEQ3E+PV7fgkzekQyVrVsl2Wp04DVgxXVC94IXUVuzI/iwtY94s0PT?=
 =?us-ascii?Q?4z7jGiK+wasqHHfa67o+vcqYGkBmtJW0vKSckIvTUk5EG4QvpjKGr5gBT08L?=
 =?us-ascii?Q?EJKWoV20vMc8/2e9lI6EwEpzzkLicSAIZxEjXczUlB1Q4AW6gM+u7FyjEDTt?=
 =?us-ascii?Q?Uq7f02HtGNWHSyzpA3roxB5ts1qDSj3nlgYphn3fzdZLjekhdEIBzB83jJLx?=
 =?us-ascii?Q?McRjCHwoJl9l2DuVlKYHIgU2lcZRJcymA1VCRMjRcMek6UjD85DY+caYukd6?=
 =?us-ascii?Q?5oKQuS+XVFsq5DIKnwB9tUZmSHJV8IvMGAlSYrkn1ub93lp87vOeLKLnpRpD?=
 =?us-ascii?Q?L4gOu5W9HZz4Diy9ITHkE3h9EhJua07W9apIjmj4mpXVg7+dKVW5qNjGxDMo?=
 =?us-ascii?Q?fFtp/1UGYVjGnHxfTasrpVipylJd+vcXrpP6pcDzziYJncH1aFOfGhb/oQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0524d8-99a2-4f5b-e394-08d9fd239e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 14:39:26.5895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uqeln+fq0PXuZrz5ZQAIq3j2PrZXW+fMY8m6hEFj+GWp53KrRkkbcCqRTfBVl4kP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1365
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The series are:
Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: Dong, Ruijing <Ruijing.Dong@amd.com>
Sent: March 2, 2022 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Leo <Leo.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>
Subject: [PATCH 1/2] drm/amdgpu/vcn: Update fw shared data structure

Add fw log in fw shared data structure.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++-----  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vcn.h | 26 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++++----------
 5 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 5e0dbf54d561..6f3f55e39ab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -79,6 +79,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
        const char *fw_name;
        const struct common_firmware_header *hdr;
        unsigned char fw_check;
+       unsigned int fw_shared_size;
        int i, r;

        INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handle=
r); @@ -226,7 +227,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
        bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
                bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_s=
ize_bytes) + 8);
-       bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared))=
;
+       fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_sh=
ared));
+       bo_size +=3D fw_shared_size;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
                if (adev->vcn.harvest_config & (1 << i)) @@ -240,10 +242,12=
 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                        return r;
                }

-               adev->vcn.inst[i].fw_shared_cpu_addr =3D adev->vcn.inst[i].=
cpu_addr +
-                               bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(stru=
ct amdgpu_fw_shared));
-               adev->vcn.inst[i].fw_shared_gpu_addr =3D adev->vcn.inst[i].=
gpu_addr +
-                               bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(stru=
ct amdgpu_fw_shared));
+               adev->vcn.inst[i].fw_shared.cpu_addr =3D adev->vcn.inst[i].=
cpu_addr +
+                               bo_size - fw_shared_size;
+               adev->vcn.inst[i].fw_shared.gpu_addr =3D adev->vcn.inst[i].=
gpu_addr +
+                               bo_size - fw_shared_size;
+
+               adev->vcn.inst[i].fw_shared.mem_size =3D fw_shared_size;

                if (adev->vcn.indirect_sram) {
                        r =3D amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAG=
E_SIZE, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vcn.h
index 5d3728b027d3..f6569a7d6fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -205,6 +205,13 @@ struct amdgpu_vcn_reg{
        unsigned        scratch9;
 };

+struct amdgpu_vcn_fw_shared {
+       void        *cpu_addr;
+       uint64_t    gpu_addr;
+       uint32_t    mem_size;
+       uint32_t    log_offset;
+};
+
 struct amdgpu_vcn_inst {
        struct amdgpu_bo        *vcpu_bo;
        void                    *cpu_addr;
@@ -221,8 +228,7 @@ struct amdgpu_vcn_inst {
        uint64_t                dpg_sram_gpu_addr;
        uint32_t                *dpg_sram_curr_addr;
        atomic_t                dpg_enc_submission_cnt;
-       void                    *fw_shared_cpu_addr;
-       uint64_t                fw_shared_gpu_addr;
+       struct amdgpu_vcn_fw_shared fw_shared;
 };

 struct amdgpu_vcn {
@@ -265,6 +271,13 @@ struct amdgpu_fw_shared_sw_ring {
        uint8_t padding[3];
 };

+struct amdgpu_fw_shared_fw_logging {
+       uint8_t is_enabled;
+       uint32_t addr_lo;
+       uint32_t addr_hi;
+       uint32_t size;
+};
+
 struct amdgpu_fw_shared {
        uint32_t present_flag_0;
        uint8_t pad[44];
@@ -272,6 +285,15 @@ struct amdgpu_fw_shared {
        uint8_t pad1[1];
        struct amdgpu_fw_shared_multi_queue multi_queue;
        struct amdgpu_fw_shared_sw_ring sw_ring;
+       struct amdgpu_fw_shared_fw_logging fw_log; };
+
+struct amdgpu_vcn_fwlog {
+       uint32_t rptr;
+       uint32_t wptr;
+       uint32_t buffer_size;
+       uint32_t header_size;
+       uint8_t wrapped;
 };

 struct amdgpu_vcn_decode_buffer {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index 313fc1b53999..36ec877a2a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -172,7 +172,7 @@ static int vcn_v2_0_sw_init(void *handle)
        if (r)
                return r;

-       fw_shared =3D adev->vcn.inst->fw_shared_cpu_addr;
+       fw_shared =3D adev->vcn.inst->fw_shared.cpu_addr;
        fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FL=
AG);
        return 0;
 }
@@ -188,7 +188,7 @@ static int vcn_v2_0_sw_fini(void *handle)  {
        int r, idx;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
-       volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst->fw_=
shared_cpu_addr;
+       volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst->fw_shared.cpu_addr;

        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
                fw_shared->present_flag_0 =3D 0;
@@ -364,9 +364,9 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *ad=
ev)

        /* non-cache window */
        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-               lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+               lower_32_bits(adev->vcn.inst->fw_shared.gpu_addr));
        WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-               upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+               upper_32_bits(adev->vcn.inst->fw_shared.gpu_addr));
        WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
        WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0,
                AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared))); @@=
 -455,10 +455,10 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_d=
evice *adev, bool indirec
        /* non-cache window */
        WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
                UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-               lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indir=
ect);
+               lower_32_bits(adev->vcn.inst->fw_shared.gpu_addr), 0, indir=
ect);
        WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
                UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-               upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indir=
ect);
+               upper_32_bits(adev->vcn.inst->fw_shared.gpu_addr), 0, indir=
ect);
        WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
                UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
        WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET( @@ -784,7 +784,7 @@=
 static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev=
)

 static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indire=
ct)  {
-       volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst->fw_=
shared_cpu_addr;
+       volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst->fw_shared.cpu_addr;
        struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
        uint32_t rb_bufsz, tmp;

@@ -921,7 +921,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device=
 *adev, bool indirect)

 static int vcn_v2_0_start(struct amdgpu_device *adev)  {
-       volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst->fw_=
shared_cpu_addr;
+       volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst->fw_shared.cpu_addr;
        struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
        uint32_t rb_bufsz, tmp;
        uint32_t lmi_swap_cntl;
@@ -1207,7 +1207,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_devi=
ce *adev,
                                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

                        if (!ret_code) {
-                               volatile struct amdgpu_fw_shared *fw_shared=
 =3D adev->vcn.inst->fw_shared_cpu_addr;
+                               volatile struct amdgpu_fw_shared *fw_shared=
 =3D
+adev->vcn.inst->fw_shared.cpu_addr;
                                /* pause DPG */
                                reg_data |=3D UVD_DPG_PAUSE__NJ_PAUSE_DPG_R=
EQ_MASK;
                                WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_d=
ata); diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v2_5.c
index 44fc4c218433..e656a6747f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -196,7 +196,7 @@ static int vcn_v2_5_sw_init(void *handle)
                                return r;
                }

-               fw_shared =3D adev->vcn.inst[j].fw_shared_cpu_addr;
+               fw_shared =3D adev->vcn.inst[j].fw_shared.cpu_addr;
                fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_VCN_MULTI_=
QUEUE_FLAG);
        }

@@ -229,7 +229,7 @@ static int vcn_v2_5_sw_fini(void *handle)
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
                        if (adev->vcn.harvest_config & (1 << i))
                                continue;
-                       fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
+                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
                        fw_shared->present_flag_0 =3D 0;
                }
                drm_dev_exit(idx);
@@ -423,9 +423,9 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *ad=
ev)

                /* non-cache window */
                WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-                       lower_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr)=
);
+                       lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr)=
);
                WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-                       upper_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr)=
);
+                       upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr)=
);
                WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
                WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
                        AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_share=
d))); @@ -513,10 +513,10 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct =
amdgpu_device *adev, int inst_idx
        /* non-cache window */
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-               lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr),=
 0, indirect);
+               lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr),=
 0,
+indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-               upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr),=
 0, indirect);
+               upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr),=
 0,
+indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                VCN, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET( @@ -757,7 +7=
57,7 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev=
)

 static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_id=
x, bool indirect)  {
-       volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst[inst=
_idx].fw_shared_cpu_addr;
+       volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
        struct amdgpu_ring *ring;
        uint32_t rb_bufsz, tmp;

@@ -981,7 +981,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
        vcn_v2_5_mc_resume(adev);

        for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
-               volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.i=
nst[i].fw_shared_cpu_addr;
+               volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst[i].fw_shared.cpu_addr;
                if (adev->vcn.harvest_config & (1 << i))
                        continue;
                /* VCN global tiling registers */
@@ -1403,7 +1403,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_devi=
ce *adev,
                                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

                        if (!ret_code) {
-                               volatile struct amdgpu_fw_shared *fw_shared=
 =3D adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+                               volatile struct amdgpu_fw_shared *fw_shared=
 =3D
+adev->vcn.inst[inst_idx].fw_shared.cpu_addr;

                                /* pause DPG */
                                reg_data |=3D UVD_DPG_PAUSE__NJ_PAUSE_DPG_R=
EQ_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index da11ceba0698..ae9dfb29621f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -213,7 +213,7 @@ static int vcn_v3_0_sw_init(void *handle)
                                return r;
                }

-               fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
+               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
                fw_shared->present_flag_0 |=3D cpu_to_le32(AMDGPU_VCN_SW_RI=
NG_FLAG) |
                                             cpu_to_le32(AMDGPU_VCN_MULTI_Q=
UEUE_FLAG) |
                                             cpu_to_le32(AMDGPU_VCN_FW_SHAR=
ED_FLAG_0_RB);
@@ -249,7 +249,7 @@ static int vcn_v3_0_sw_fini(void *handle)

                        if (adev->vcn.harvest_config & (1 << i))
                                continue;
-                       fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
+                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
                        fw_shared->present_flag_0 =3D 0;
                        fw_shared->sw_ring.is_enabled =3D false;
                }
@@ -469,9 +469,9 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *ad=
ev, int inst)

        /* non-cache window */
        WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-               lower_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+               lower_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
        WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-               upper_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+               upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
        WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
        WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_SIZE0,
                AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared))); @@=
 -558,10 +558,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_d=
evice *adev, int inst_idx
        /* non-cache window */
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                        VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
-                       lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gp=
u_addr), 0, indirect);
+                       lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gp=
u_addr), 0,
+indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                        VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
-                       upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gp=
u_addr), 0, indirect);
+                       upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gp=
u_addr), 0,
+indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
                        VCN, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, =
indirect);
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET( @@ -923,7 +9=
23,7 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev=
, int inst)

 static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_id=
x, bool indirect)  {
-       volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst[inst=
_idx].fw_shared_cpu_addr;
+       volatile struct amdgpu_fw_shared *fw_shared =3D
+adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
        struct amdgpu_ring *ring;
        uint32_t rb_bufsz, tmp;

@@ -1220,7 +1220,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
                tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, =
1);
                WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);

-               fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
+               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
                fw_shared->multi_queue.decode_queue_mode |=3D cpu_to_le32(F=
W_QUEUE_RING_RESET);

                /* programm the RB_BASE for ring buffer */ @@ -1611,7 +1611=
,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,

                                if (adev->ip_versions[UVD_HWIP][0] !=3D IP_=
VERSION(3, 0, 33)) {
                                        /* Restore */
-                                       fw_shared =3D adev->vcn.inst[inst_i=
dx].fw_shared_cpu_addr;
+                                       fw_shared =3D adev->vcn.inst[inst_i=
dx].fw_shared.cpu_addr;
                                        fw_shared->multi_queue.encode_gener=
alpurpose_queue_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);
                                        ring =3D &adev->vcn.inst[inst_idx].=
ring_enc[0];
                                        ring->wptr =3D 0;
@@ -1700,7 +1700,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_=
ring *ring)

        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
                /*whenever update RBC_RB_WPTR, we save the wptr in shared r=
b.wptr and scratch2 */
-               fw_shared =3D adev->vcn.inst[ring->me].fw_shared_cpu_addr;
+               fw_shared =3D adev->vcn.inst[ring->me].fw_shared.cpu_addr;
                fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
                WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
                        lower_32_bits(ring->wptr));
--
2.25.1

