Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E0CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 10:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF9D10E7F6;
	Thu, 10 Feb 2022 10:50:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E17E10E7F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 10:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPQQog7QUElo/tNL5/6z20xIMlSW5f9f6TPOWA0Ndjgso67JvHmnNUi7bmHLwozy8x2QOc5dL/5euZ2yF+yt5Xdrm1If0tIQWkLnLKhGzsr6lYZPMvGtfcVEpMj9uUXDe5U1A0gRkRDvmPVNW/VEr7ZmVi21MFK8HTev/KxOyZj3z0SxMSrHH/MHLwVxkPENerT3JjS01jnGg7oISPdaCQy+ucqDmCJxEwyTVEiB4z/FD3NV5YJizrHJP0rxj2Rzvy9S5OiobFZNXZQhyOmUDVl2DSvKURmXeet3eG+EAlOdYNqgj4AMmlhmc7F9KHKONa+ss5qZ8jH5QF+gR505rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN5zGLaeURi1htAVUUp7t7s7xzmj8B1zByt0JFhdffo=;
 b=QVAYAO1V2vX2vWUACFP6kpaTU9CkS/v37f6SQu0+6lLp1NhWnNcH2x7izvU2U1xVrNryb59L/epEzgNFul5nVpcCoHvWXkaaQwu7Ej58CM1fHYrqq9GZxuJPGgZgRywBjyLdmN9JIsyUM21lbseCxvmR9c3J1jgA9oxFwmcvX7CdxnWVU2XST0yYrS2vVJC1nGX7WMzjdoGwJX3FoRGXHxg8+g/C5JFf/0lziSjJancR2u9l8Iimoc8+ASUFbTVs1DNXtmVvtdzzspy5DuW3SWuawHWFayEh5iM//qZU8WuVy64Skttto/10KoG6iGwS4Sllb+nO6D2Rcs32kTe8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN5zGLaeURi1htAVUUp7t7s7xzmj8B1zByt0JFhdffo=;
 b=haOmbw8YYQ8Dex8sSMl5MVD79vK0Vv7dezVZoaYp0N4uExbKGLqufI3R+fkeLwB+56W64Ak1TAG2r17Cg0wnzrf7k0TnoVD6qHO2NwbHglcxAYZwxy5di/sOCUqSbjifosy1GcBrD9tJKvz3oPYfxC+IVtrbKwW8TjmH2ImgAec=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 10:50:23 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558%7]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 10:50:22 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Topic: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Index: AQHYHkksSzsmSDF0Z0edVGZcJ8dUyqyMjc2AgAAL6BA=
Date: Thu, 10 Feb 2022 10:50:22 +0000
Message-ID: <BN9PR12MB53240E14C93287D3D3AC6A438B2F9@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20220210064029.16545-1-guchun.chen@amd.com>
 <BL1PR12MB52546BEFD2C3B67857A269C5FC2F9@BL1PR12MB5254.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52546BEFD2C3B67857A269C5FC2F9@BL1PR12MB5254.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T10:01:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=81a0eb33-4cd3-4cd4-92d7-720266dc994f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-10T10:50:18Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6d2091bc-4390-4666-a9f1-370178d5527f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66eee0a2-302f-415b-84ec-08d9ec83236e
x-ms-traffictypediagnostic: DM4PR12MB5263:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52633910D102FCAA7A9D41DE8B2F9@DM4PR12MB5263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1JSOIeBOpDjyrk5iBVS7mL44HtL+SFKLCcfFytsree2Rp4QsuFuCIltxswpAKTs3rP5ngz+jprySmlrB6sWQCNptxmAchb5T54D/d5r8hSnmjWdU0zRbD9VLiSkupq+1jXpHhOnUNc9HFPut/IQhU2bWYhPSyPweEsDZsHGWPwbAFgPg5SWuoZA6cqLrb5I6yMJaSGkL3335gmFyTuWl86C5fv4syBTi57de2NtxLrJKCqSZv0cak6l4WudjIngg0GfpKeDjchB9UvoHzDB/tJaKe7b0UTtlZWvTmlfucGHStjAFZDlZsubRqkdCkAn9IRhtj13F+KDGQcYNvAgPWpdhk+WdBDnQ1/AjHzQiT7D1Dixf6oGypX7TS4c/3kwy1KxkhbOhr4BrGfc6UTCqfaWiy3IRyGgfLDGx+cSiMUtY0k76dyRGRqQAVAr3maR9K6i6YGnwCHHZOKFnkMmrLIBk5JKEtuUFtvYyOGwACU8hHJ+VZ9arxRaFvP6AX2H6JkhfEptwLlqSxQ8/eS4fshysdSTukqI8lKECUklLiwc50mqVoiAPqtDuC+mYPB1NW5o1xfcYwkHpf7FGrDZpwEOkL84dQq4TBM4gcZvkHPzp7ZZu0lgdPlOJhvp7cFEB6ejQ6kX2fyfba39xaNWxAoVuK9nmOU+QjFScv3DVwJaQsBlUjVdTYBR5m5d3rIDyFpD3S+WEXgf7kCIlUQTa6/yVYz09xPtT6Eq//khWlI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(64756008)(52536014)(5660300002)(83380400001)(71200400001)(33656002)(8936002)(186003)(8676002)(26005)(66446008)(76116006)(66946007)(66476007)(66556008)(9686003)(6506007)(6636002)(55016003)(38070700005)(110136005)(53546011)(38100700002)(508600001)(921005)(122000001)(316002)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zKXal7C67vb6ahpIGzw15dsCeZ85BIzYfqIClJkny9MAB0pUs5UWLyFko5i?=
 =?us-ascii?Q?iQoOOhBIsxHsfDPpEmuKRX16Qb+1I8rnEQdLsdGjkZWNG+nVBIR1kG71qqrV?=
 =?us-ascii?Q?bkFYyQEYIlJ2zAQDd9DHzHBvBhHfGkeUy5RbbMkfR4QYuAu6xpnal5Edgwm0?=
 =?us-ascii?Q?LntE7fQlLgyHC1POKxRGaUUUH2TbCXY7Inf8pnq6tjl4X5BExAcGS4cwmvrk?=
 =?us-ascii?Q?KwaAauz8Nje83lUsXQRop6Q8fymFSMT56LaI0qHV/fhArBROlTk6gmMPjDb2?=
 =?us-ascii?Q?tFV4Hywoc46IL2+nGfRcHgRIRxLfVXMhZGUae9PBUCev2mUhF3+vTyQs5NUM?=
 =?us-ascii?Q?3Y3bw+sQk2o034Lelb39vZEYif6KDoWOKGPTqRqkbbu78TVO1GrXsiqOjNuE?=
 =?us-ascii?Q?Z0njXF2+k22FalsNQEu6Sm/Esdp7RGYJzH8ZKf320S4gqGSPtmeWxZNUbAQk?=
 =?us-ascii?Q?2gtvHG5VxXt8Kjk6X83sNA+P/r0QguF4NJHmHidSQYDlzptqUhhYxYwb5u+H?=
 =?us-ascii?Q?tD0qH/tFrMEBlxshkouQ3VIaU8j2nUaSCK/IKVUenyvsDTJFYaU1oaYyoLGX?=
 =?us-ascii?Q?8jP28UmIj0n515mSUSPbz1unOzHH3OecS83uTLo1kD+E2fZEHojAJs4f1NJK?=
 =?us-ascii?Q?cSQI74RyGdtZsIlzBh6mPBm2W0kDJL0O8WCWAxBYuXNTeumOPLv8Qy2cZNmD?=
 =?us-ascii?Q?m2BmTNAIjGB/+1L2D8t2hSlb6tP70cnIbdWY2Cr1CZVptcG022qZ3xkiJXS0?=
 =?us-ascii?Q?E/XUFfp8apULIOXoAr+A3FnTxxuThdja7v5iUecpGxKorad3FWr8ia1e9KtX?=
 =?us-ascii?Q?Z+9a2/zaA3F0nvLAwmqkC9BFAp8R6vc44tyq4CtK4bUqBrPVNov5VjL2YqxQ?=
 =?us-ascii?Q?O6DHpva9UWijmDxv21LGde3Wwz5+TPJJqGccZx15bsI3FxkoFco7tGXIVn9b?=
 =?us-ascii?Q?2T/LZ3xDj1GYq4mD9Luy21aRvgrpJlDt/oC/6cno3FvZcLVGCINigysb7Xr/?=
 =?us-ascii?Q?4tnXiD41CYHlWy2nmVxeiBy7pkHiioBEAEznfBcro8RUrISJOPmg7iszifiU?=
 =?us-ascii?Q?wde+qpnN5N8q33ng53JsTxL3Gni/kf7drk2ztJepPdv9vcQZGw9hwV/k5ZYX?=
 =?us-ascii?Q?m9WM7z98RElRHEDmRlHHCPtSPIjFskcf3Xq+1fSpxditXtBJ/HnD5mutJ7pf?=
 =?us-ascii?Q?E4dKOx3/BYOeOf3Ver+sK6qSnr4w64rupCr7jM0OWI3+FTjoi830K3aLwoCg?=
 =?us-ascii?Q?sZLP8rhzU6nP8UHdXAr1ldgGR0xx0AE0WPQFxGWiHyfWvbq9ekB3Hh2zxS78?=
 =?us-ascii?Q?xbzcceBNBCsdIlzMrgWrtciIRvKywpdbGyvAg4FSYApi0KM66afjc/mhMDvL?=
 =?us-ascii?Q?OufHec7oyLW/F/FdeBbdHsLsKBmbfBYZ3R0Ojxzy6ztRcIjbA3KC1qT9/sRR?=
 =?us-ascii?Q?EPN8SZU9DJ9ZgskR+DJbMv4AWMsq6EWQkWCSk3UMcNqk+i6ZFPiSoRJCEsy6?=
 =?us-ascii?Q?wUxj/fEj4S4rp9siO3O7cbaxWHEI+ic9Pp7Ta0pHaCVnTkwyBiRqlxRqOlDc?=
 =?us-ascii?Q?IP/7nw1bjtF5wUX8H8ceJrLmlUwtLC9nsfXAW+BWmc0V0B0x0lucqEY3+0Sd?=
 =?us-ascii?Q?qAWykZa2Y1DUUZuku7f2aeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eee0a2-302f-415b-84ec-08d9ec83236e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 10:50:22.6753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPAx2nQbquda5KRqxjLnYcOZpQWLIVdTUmp25od4N4WA0+qcr+WjhPL0hGe6OVXkyQjorAemqbE0RwxIAu/OMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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

Hi Guchun,

RLCG read is available on Aldebaran if amdgpu_sriov_reg_indirect_gc() flag =
is set. Instead of adding a new function, I think we should simply add a ch=
eck inside amdgpu_virt_get_rlcg_reg_access_flag():


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..1ee600e90312 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -836,7 +836,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
                /* only in new version, AMDGPU_REGS_NO_KIQ and
                 * AMDGPU_REGS_RLC are enabled simultaneously */
                } else if ((acc_flags & AMDGPU_REGS_RLC) &&
-                          !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+                          !(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
                        *rlcg_flag =3D AMDGPU_RLCG_GC_WRITE_LEGACY;
                        ret =3D true;
                }

Thanks,
Victor

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, February 10, 2022 5:02 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhou=
, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx =
v9

[CAUTION: External Email]

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, February 10, 2022 14:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9

Fall back to MMIO to read registers as rlcg read is not available for gfx v=
9 in SRIOV configration. Otherwise, gmc_v9_0_flush_gpu_tlb will always comp=
lain timeout and finally breaks driver load.

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a3274fa1c7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,16 @@
                vf2pf_info->ucode_info[ucode].version =3D ver; \
        } while (0)

+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device
+*adev) {
+       /* rlcg read is not support in SRIOV with gfx v9 */
+       if ((adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(9, 0, 0)) ||
+               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)))
+               return false;
+
+       return true;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  {
        /* By now all MMIO pages except mailbox are blocked */ @@ -957,7 +9=
67,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        u32 rlcg_flag;

        if (!amdgpu_sriov_runtime(adev) &&
-           amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, fal=
se, &rlcg_flag))
+               amdgpu_virt_is_rlcg_read_supported(adev) &&
+               amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false,
+&rlcg_flag))
                return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);

        if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1
