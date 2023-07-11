Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373CBEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 18:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F63510E423;
	Tue, 11 Jul 2023 18:15:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544BD10E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 18:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNDPFKydnq9xg9906Zx1QsdKir8cAHCz0uZSTjxP01GO8kscOZK3jh7C6/oQe3EvvsMl74NIzY5RzJ20jCWBhFa6w8Hb/WRvEAtny8GSVhlMuB+a7KkKEczpCpE2Em+7k6lAUKPkZjB936ZFtj637HTt3AwX4Zx9ItzyLJV8a2A3WD2zJk4Y0XQY22aDROE2xOVjiw//yGqyRwVvYy2+OKHpuwn2C5EuZD6Vn1zdusvi6N7RGKJYIKaec2tGzGmV3HRvNXWb50b31GBnJ8ZwBX0PehxUMNK2zs7ZmDajb9qIeC9PtKPQ0U3w7JM0kwZ1a0tf1nO7d4B9EP18efGCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/EHHybeOnHLQdYhZGI779PASorU6f3gv9amKpWvCUg=;
 b=hH4U++s2hLJPxcDzrsJgcjHikQhxjUZBniO/guFGh0UyaHgfir8q7zoNGR3PUAgSD7NU4DYgsKQRGhIi8st8vVhCWM0bin79OGjj+oV0VeHZjX0JK/7axTR5Y39KnRbo0NkkY9F+U5IVBSMB9QzAaHt2Ws76dLo294Ad6jdjKgpWG8m1WvPWIhBgsT6bhHTnJ2v+j4XuZAlOMkmB4CBiPFjLgMx1ERs3EcB4uSijaAIjdCHRlOSVV6BHkStqBnhYGeeQFxPOB/oXi6CvUT1icgUCQZ6OnIkGup+qhdQ56CNGmHe59XS3YLl54puzuYKBXjTFwLEM1arhV4uVSssKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/EHHybeOnHLQdYhZGI779PASorU6f3gv9amKpWvCUg=;
 b=Kz9lWxkBCp0Mosh1z0rqu/Fjf22df6V1dzELxlyNo2hvNfWyVW8FWKVcTsejCAgEABHyfQKoeoXRL7YS2K11FPuhEH2k3DhgctI/yGXO9+oSXhCihiNU6tb5/6sAbegd1T/LYJEsivEQZHjhY0I08NadTBfbOakbfcVXINI/gP8=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 18:15:24 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::3e3c:cefb:f6a8:c1d5]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::3e3c:cefb:f6a8:c1d5%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:15:24 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Add RLCG interface driver implementation
 for gfx v9.4.3 (v3)
Thread-Topic: [PATCH v3] drm/amdgpu: Add RLCG interface driver implementation
 for gfx v9.4.3 (v3)
Thread-Index: AQHZtAKzX2TcXmBWiUKtzE1vPDbnza+03lPQ
Date: Tue, 11 Jul 2023 18:15:24 +0000
Message-ID: <BL1PR12MB5317497CDD15DDB4D7174C49F131A@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20230711141734.2033-1-victorchengchi.lu@amd.com>
In-Reply-To: <20230711141734.2033-1-victorchengchi.lu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ac72c20f-18a5-4bdc-b010-ff4472be67dc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-11T18:11:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|IA0PR12MB8327:EE_
x-ms-office365-filtering-correlation-id: 79b071c0-de42-4baf-0406-08db823acbcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqHnR/DikJSoVuc8HK6pYw+VwOl7vtMJh6I9bM6dLHjuQX2finz+MwSKlMlwvar5HY4KJjiPcd6nR0ej+/J8v/NAcfF0yjuf1LFW0uA/YyLnk4FHtWiIS36IvaxGai9zQ+qFViThvLzB+zvf5nIUW8MKKgp8+8ftA97+5kLjmCU5Tv5S2QuKodsZGpmF+R13D3jvzTWVrXjWNn+15aIjfzKqah2gfuHODyZ6q5RBrsMwcfL+E5DvSzu+tpzyepctZC4uYU+LqYLfOSLSxYI3tBxPrUbHTjPLTRjBCK6o02Y9suUXZ1bF5uMTdir81R5a2jbmjzO/sNW6Of2RdH9Ob/gQNrNLAq1cvCrX/JY5X/EAlcXIPCoUBsh6lad1jMHw0rFueVE8nX+a+zMuvmB3GucraN5ofA65POH8asFkNqDplJPKK2AcjlPZ9wK5lIJ8fnyLLR2Ft9TiSolghz45iUvbJDM6sbMvlmb1iA3M1uTnH8vlcYwlGgXYLO+UcrlyHw/wFTvAqpp2k05yqjOYkx3JXBTIqIgbwq+ncPxbN/Q74JeiRHV1GNIAKGmQoiH0YVEr6aeFf5Tnq90IrmgIiTYB7x6Ymhr4J44qWYGbJMKqf6dJJQXBs2yXmq+DzUMH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(76116006)(4326008)(478600001)(54906003)(110136005)(7696005)(71200400001)(83380400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(30864003)(186003)(53546011)(6506007)(9686003)(26005)(38100700002)(122000001)(316002)(64756008)(66446008)(66476007)(8936002)(8676002)(41300700001)(66556008)(52536014)(66946007)(5660300002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?unplWtBiDmQbG4hGHhImc885VjJwk/kQln6FiYsM8rxfIifCCJALWS6v+HDX?=
 =?us-ascii?Q?SCfzI3XRlf/t5kYRvnFStEKpKBVMdRLnJK7KgWHVLkLHpRhL/dij6zztQX8q?=
 =?us-ascii?Q?tT4KDn1+S+MRDwi2N2JCbC/xug/0jZcV+FlyAzeLZpQ0WzzCkLd4rjBBTYhG?=
 =?us-ascii?Q?FgQDDyV3z1e4ksVBcQd2Gd6Qi1+SvfslS30JHVbJ4xQq7XfGyRqxmdOl2T9p?=
 =?us-ascii?Q?FOKkVYBrtsWj4geMRFp8JefabiFgB8qs+luAWXjuSiNJ56wvuGbo4hVC5btN?=
 =?us-ascii?Q?pLDX//OoORm5maTEr7aFW7wbD1ZPz+BWF54FYnRQFubEHhc+PTYMHmhTZwde?=
 =?us-ascii?Q?84IhYSrhLwiY5w6g5HGmXnqM5HrWzkfwUh1du1GA6aaNKkgTRmnUzOWTLldY?=
 =?us-ascii?Q?GQV/gTFGkwUJMULdLLQUDfJfi2mPyX+0AYAWIyDfqHQSl48mXnUHP2t9opzy?=
 =?us-ascii?Q?uql+n/x9AI/BHI+GUBqxtqzHDpcvQoIuZQwevwuoc4DeafRdnQIWefxhdxBl?=
 =?us-ascii?Q?mQ0KxLbifjCYRAnndf6H0z3W+6sGhlTVNMnfym+DZ94PfXypPn6aUfoxgpK1?=
 =?us-ascii?Q?n3PefmgC38Yv6Pxwgru7Ep+wFIgjh5Y9TNjbtEHZpvKoe3sJVPyYtegnolu8?=
 =?us-ascii?Q?4TwDdnjNu+GVXlBfLTcYyUiYE1b4oN/4UfNjMK2Aa0QhBom0sB4vxK6x+x28?=
 =?us-ascii?Q?aAMTpS5BCyvxceMPyaXu+HXH9DXgomrQNuzJDFPPvhrNIjTkbFf9+4VPqCfu?=
 =?us-ascii?Q?v8F4OHQdhPRqISBkn6CGbbtHNQv4nutAKEEu4ohNuTOkTnyTzVGXKVb2eZKF?=
 =?us-ascii?Q?t56FwJBfx+Q1XcJIQJUZMVG8to2MJkec/Zxt4Gr0qys/cFessQB8eqDpu7sl?=
 =?us-ascii?Q?Nz0+713QSMPJNt1PlpR2pvVhcr4Mxz2srmSauyOyBoJnxRJj3kW4ux5AyeIE?=
 =?us-ascii?Q?L8l9oA4ENMSmDcBohNMLMFgJbW5nJIe7m6o7dlQwQGm6AIocrRQlWMdxLSSZ?=
 =?us-ascii?Q?XE9QMgtt8dxxGMhG8L55eRb+Rt+p68h+P6TvI7L2e+/f7vY+TyRArsApMoJ/?=
 =?us-ascii?Q?gfdxBjORWX/3zQmMD7YqU3K5czdWFWvdVt/zHTK3cxwOvcyE+PKeUP84m02W?=
 =?us-ascii?Q?4Lw3ezGOxZuW9QKiyw6fPuR2oLihKD4U8bZxgYlPNswHX0oKMMwU2wBSxjqO?=
 =?us-ascii?Q?/Kob9BBc9rNI2fG1WUCZpbmg8N68E4kS69+jSMaOWxZHQtmJueRiU4NtKoKh?=
 =?us-ascii?Q?DZhlA26zS4PSVRUuJDCCj62CIFYrGRkYQyMGUKJ/DQSxGFTUi2DjPHA/Q6Iy?=
 =?us-ascii?Q?erxbRfh2NEcdh5EQC3sIQlUuv6Yf6Rj24mDManxPcT9w6NAg1r3cFW4jixL7?=
 =?us-ascii?Q?wj15n3n705At9Egph1jE898DDmFFOHN0sEPplGxlhITnLZD3AVWrnwnQGJqi?=
 =?us-ascii?Q?1Rjx94hScvVslW12p2V9ZObi2NBaQ5OSkyg0wIf3/XO4P4QNjvgN9U/zo8rL?=
 =?us-ascii?Q?soRcAgDZF73JNXkxZjBrKSHxgDuHM6Yx6zSATNXYNVpSKZtllACU9EDI8EWr?=
 =?us-ascii?Q?WbdfOPDI82mfo2MvG64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b071c0-de42-4baf-0406-08db823acbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 18:15:24.1902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku2p1LFK9BKwIqGc5x7+mUZjr5/k0D1lRqtcLs0SiwPqPGESrrK/vVBMbh+qCMfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Ming,
 Davis" <Davis.Ming@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Tuesday, July 11, 2023 10:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Ming, Davis <Davis.Ming@a=
md.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Lu, Victor Cheng Chi (Victor) =
<VictorChengChi.Lu@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add RLCG interface driver implementation fo=
r gfx v9.4.3 (v3)

Add RLCG interface support for gfx v9.4.3 and multiple XCCs.
Do not enable it yet.

v2: Fix amdgpu_rlcg_reg_access_ctrl init, add support for multiple XCCs
    in amdgpu_mm_wreg_mmio_rlc

v3: Use GET_INST() when indexing amdgpu_rlcg_reg_access_ctrl

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c  |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h     |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 17 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 22 +++++++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h   | 66 ++++++++++-----------
 11 files changed, 81 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index c578e07fd90a..a6647a1d13e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1182,7 +1182,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_de=
vice *adev,
                                 u32 pcie_index, u32 pcie_index_hi,
                                 u32 pcie_data, u64 reg_addr, u32 reg_data)=
;  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-                            uint32_t reg, uint32_t v);
+                            uint32_t reg, uint32_t v, uint32_t xcc_id);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t =
value);  uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offse=
t);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 241d8c5da273..fc77bea72db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -173,7 +173,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, st=
ruct file *f,
                } else {
                        r =3D get_user(value, (uint32_t *)buf);
                        if (!r)
-                               amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, va=
lue);
+                               amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, va=
lue, 0);
                }
                if (r) {
                        result =3D r;
@@ -301,7 +301,7 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, =
char __user *buf, u32 off
                } else {
                        r =3D get_user(value, (uint32_t *)buf);
                        if (!r)
-                               amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value);
+                               amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value, rd->id.xcc_id);
                }
                if (r) {
                        result =3D r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 45b335c766fd..abc56085b136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -586,7 +586,8 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
  * this function is invoked only for the debugfs register access
  */
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-                            uint32_t reg, uint32_t v)
+                            uint32_t reg, uint32_t v,
+                            uint32_t xcc_id)
 {
        if (amdgpu_device_skip_hw_access(adev))
                return;
@@ -595,7 +596,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev=
,
            adev->gfx.rlc.funcs &&
            adev->gfx.rlc.funcs->is_rlcg_access_range) {
                if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-                       return amdgpu_sriov_wreg(adev, reg, v, 0, 0);
+                       return amdgpu_sriov_wreg(adev, reg, v, 0, 0, xcc_id=
);
        } else if ((reg * 4) >=3D adev->rmmio_size) {
                adev->pcie_wreg(adev, reg * 4, v);
        } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.h
index 80b263646966..b591d33af264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -26,6 +26,8 @@

 #include "clearstate_defs.h"

+#define AMDGPU_MAX_RLC_INSTANCES       8
+
 /* firmware ID used in rlc toc */
 typedef enum _FIRMWARE_ID_ {
        FIRMWARE_ID_INVALID                                     =3D 0,
@@ -201,7 +203,7 @@ struct amdgpu_rlc {
        u32                     cp_table_size;

        /* safe mode for updating CG/PG state */
-       bool in_safe_mode[8];
+       bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
        const struct amdgpu_rlc_funcs *funcs;

        /* for firmware data */
@@ -257,7 +259,7 @@ struct amdgpu_rlc {

        bool rlcg_reg_access_supported;
        /* registers for rlcg indirect reg access */
-       struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl;
+       struct amdgpu_rlcg_reg_access_ctrl
+reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
 };

 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id=
); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c
index 5731829964c2..b5c6c7435551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -960,7 +960,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
        return ret;
 }

-static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset,=
 u32 v, u32 flag)
+static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32
+offset, u32 v, u32 flag, u32 xcc_id)
 {
        struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
        uint32_t timeout =3D 50000;
@@ -978,7 +978,12 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_devic=
e *adev, u32 offset, u32 v
                return 0;
        }

-       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
+       if (adev->gfx.xcc_mask && (((1 << xcc_id) & adev->gfx.xcc_mask) =3D=
=3D 0)) {
+               dev_err(adev->dev, "invalid xcc\n");
+               return 0;
+       }
+
+       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl[xcc_id];
        scratch_reg0 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg0;
        scratch_reg1 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg1;
        scratch_reg2 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg2; @@ -1043,13 +1048,13 @@ static u32 amdgpu_virt_rlcg_reg_rw(s=
truct amdgpu_device *adev, u32 offset, u32 v

 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
                       u32 offset, u32 value,
-                      u32 acc_flags, u32 hwip)
+                      u32 acc_flags, u32 hwip, u32 xcc_id)
 {
        u32 rlcg_flag;

        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 true, &rlcg_flag)) {
-               amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
+               amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc=
_id);
                return;
        }

@@ -1060,13 +1065,13 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev, =
 }

 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-                     u32 offset, u32 acc_flags, u32 hwip)
+                     u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id)
 {
        u32 rlcg_flag;

        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false, &rlcg_flag))
-               return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
+               return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, =
xcc_id);

        if (acc_flags & AMDGPU_REGS_NO_KIQ)
                return RREG32_NO_KIQ(offset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 4f7bab52282a..d1f7509a44cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -355,9 +355,9 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu=
_device *adev,
                        struct amdgpu_video_codec_info *decode, uint32_t de=
code_array_size);  void amdgpu_sriov_wreg(struct amdgpu_device *adev,
                       u32 offset, u32 value,
-                      u32 acc_flags, u32 hwip);
+                      u32 acc_flags, u32 hwip, u32 xcc_id);
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-                     u32 offset, u32 acc_flags, u32 hwip);
+                     u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
                        uint32_t ucode_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index c8291711dba3..7a1e7e3db2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4151,7 +4151,7 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struc=
t amdgpu_device *adev)  {
        struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;

-       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
+       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl[0];
        reg_access_ctrl->scratch_reg0 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG0);
        reg_access_ctrl->scratch_reg1 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG1);
        reg_access_ctrl->scratch_reg2 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG2); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v11_0.c
index a9f008d0d5ab..f5b52d239eb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -645,7 +645,7 @@ static void gfx_v11_0_init_rlcg_reg_access_ctrl(struct =
amdgpu_device *adev)  {
        struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;

-       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
+       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl[0];
        reg_access_ctrl->scratch_reg0 =3D SOC15_REG_OFFSET(GC, 0, regSCRATC=
H_REG0);
        reg_access_ctrl->scratch_reg1 =3D SOC15_REG_OFFSET(GC, 0, regSCRATC=
H_REG1);
        reg_access_ctrl->scratch_reg2 =3D SOC15_REG_OFFSET(GC, 0, regSCRATC=
H_REG2); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v9_0.c
index de9a5c67e241..ebdc0f9200f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1636,7 +1636,7 @@ static void gfx_v9_0_init_rlcg_reg_access_ctrl(struct=
 amdgpu_device *adev)  {
        struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;

-       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
+       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl[0];
        reg_access_ctrl->scratch_reg0 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG0);
        reg_access_ctrl->scratch_reg1 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG1);
        reg_access_ctrl->scratch_reg2 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH=
_REG2); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v9_4_3.c
index b41d6ae35c8a..1cd417034860 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1126,6 +1126,25 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct am=
dgpu_device *adev,
        WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE, data);  }

+static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device
+*adev) {
+       int xcc_id;
+       struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+
+       for (xcc_id =3D 0; xcc_id < AMDGPU_MAX_RLC_INSTANCES; xcc_id++) {
+               if (((1 << xcc_id) & adev->gfx.xcc_mask) =3D=3D 0)
+                       continue;
+               reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl[GET_INST=
(GC, xcc_id)];
+               reg_access_ctrl->scratch_reg0 =3D SOC15_REG_OFFSET(GC, GET_=
INST(GC, xcc_id), regSCRATCH_REG0);
+               reg_access_ctrl->scratch_reg1 =3D SOC15_REG_OFFSET(GC, GET_=
INST(GC, xcc_id), regSCRATCH_REG1);
+               reg_access_ctrl->scratch_reg2 =3D SOC15_REG_OFFSET(GC, GET_=
INST(GC, xcc_id), regSCRATCH_REG2);
+               reg_access_ctrl->scratch_reg3 =3D SOC15_REG_OFFSET(GC, GET_=
INST(GC, xcc_id), regSCRATCH_REG3);
+               reg_access_ctrl->grbm_cntl =3D SOC15_REG_OFFSET(GC, GET_INS=
T(GC, xcc_id), regGRBM_GFX_CNTL);
+               reg_access_ctrl->grbm_idx =3D SOC15_REG_OFFSET(GC, GET_INST=
(GC, xcc_id), regGRBM_GFX_INDEX);
+               reg_access_ctrl->spare_int =3D SOC15_REG_OFFSET(GC, GET_INS=
T(GC, xcc_id), regRLC_SPARE_INT);
+       }
+}
+
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)  {
        /* init spm vmid with 0xf */
@@ -2319,6 +2338,9 @@ static int gfx_v9_4_3_early_init(void *handle)
                        gfx_v9_4_3_xcc_rlc_smu_handshake_cntl(adev, false, =
i);
        }

+       /* init rlcg reg access ctrl */
+       gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
+
        return gfx_v9_4_3_init_microcode(adev);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h
index 96948a59f8dd..da683afa0222 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -37,65 +37,65 @@
 #define SOC15_REG_OFFSET1(ip, inst, reg, offset) \
        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset)=
)

-#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
+#define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
        ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlc=
g_reg_access_supported) ? \
-        amdgpu_sriov_wreg(adev, reg, value, flag, hwip) : \
+        amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
         WREG32(reg, value))

-#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
+#define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
        ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlc=
g_reg_access_supported) ? \
-        amdgpu_sriov_rreg(adev, reg, flag, hwip) : \
+        amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
         RREG32(reg))

 #define WREG32_FIELD15(ip, idx, reg, field, val)       \
         __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BA=
SE_IDX] + mm##reg,   \
                                (__RREG32_SOC15_RLC__( \
                                        adev->reg_offset[ip##_HWIP][idx][mm=
##reg##_BASE_IDX] + mm##reg, \
-                                       0, ip##_HWIP) & \
+                                       0, ip##_HWIP, idx) & \
                                ~REG_FIELD_MASK(reg, field)) | (val) << REG=
_FIELD_SHIFT(reg, field), \
-                             0, ip##_HWIP)
+                             0, ip##_HWIP, idx)

 #define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val)        \
        __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][reg##reg_name=
##_BASE_IDX] + reg##reg_name,   \
                        (__RREG32_SOC15_RLC__( \
                                        adev->reg_offset[ip##_HWIP][idx][re=
g##reg_name##_BASE_IDX] + reg##reg_name, \
-                                       0, ip##_HWIP) & \
+                                       0, ip##_HWIP, idx) & \
                                        ~REG_FIELD_MASK(reg_name, field)) |=
 (val) << REG_FIELD_SHIFT(reg_name, field), \
-                       0, ip##_HWIP)
+                       0, ip##_HWIP, idx)

 #define RREG32_SOC15(ip, inst, reg) \
        __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_I=
DX] + reg, \
-                        0, ip##_HWIP)
+                        0, ip##_HWIP, inst)

-#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0,
+ip##_HWIP, 0)

-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_R=
EGS_NO_KIQ, ip##_HWIP)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg,
+AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)

 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
        __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_I=
DX] + reg, \
-                        AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+                        AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)

 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
         __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE=
_IDX] + (reg)) + \
-                        (offset), 0, ip##_HWIP)
+                        (offset), 0, ip##_HWIP, inst)

 #define WREG32_SOC15(ip, inst, reg, value) \
         __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE=
_IDX] + reg), \
-                         value, 0, ip##_HWIP)
+                         value, 0, ip##_HWIP, inst)

 #define WREG32_SOC15_IP(ip, reg, value) \
-        __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
+        __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)

 #define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-        __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+        __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)

 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
        __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_I=
DX] + reg, \
-                            value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+                            value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)

 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
         __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE=
_IDX] + reg) + offset, \
-                         value, 0, ip##_HWIP)
+                         value, 0, ip##_HWIP, inst)

 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask)      \
        amdgpu_device_wait_on_rreg(adev, inst,                       \
@@ -108,16 +108,16 @@
        #reg, expected_value, mask)

 #define WREG32_RLC(reg, value) \
-       __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
+       __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)

-#define WREG32_RLC_EX(prefix, reg, value) \
+#define WREG32_RLC_EX(prefix, reg, value, inst) \
        do {                                                    \
                if (amdgpu_sriov_fullaccess(adev)) {    \
                        uint32_t i =3D 0; \
                        uint32_t retries =3D 50000;       \
-                       uint32_t r0 =3D adev->reg_offset[GC_HWIP][0][prefix=
##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;       \
-                       uint32_t r1 =3D adev->reg_offset[GC_HWIP][0][prefix=
##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;       \
-                       uint32_t spare_int =3D adev->reg_offset[GC_HWIP][0]=
[prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;      \
+                       uint32_t r0 =3D adev->reg_offset[GC_HWIP][inst][pre=
fix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;    \
+                       uint32_t r1 =3D adev->reg_offset[GC_HWIP][inst][pre=
fix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;    \
+                       uint32_t spare_int =3D adev->reg_offset[GC_HWIP][in=
st][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;   \
                        WREG32(r0, value);      \
                        WREG32(r1, (reg | 0x80000000)); \
                        WREG32(spare_int, 0x1); \
@@ -136,17 +136,17 @@

 /* shadow the registers in the callback function */  #define WREG32_SOC15_=
RLC_SHADOW(ip, inst, reg, value) \
-       __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_=
IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP)
+
+__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
++ reg), value, AMDGPU_REGS_RLC, GC_HWIP, inst)

 /* for GC only */
 #define RREG32_RLC(reg) \
        __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)

 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
-       __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_R=
LC, hwip)
+       __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_R=
LC,
+hwip, 0)

 #define RREG32_RLC_NO_KIQ(reg, hwip) \
-       __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwi=
p)
+       __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwi=
p,
+0)

 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
        do {                                                    \
@@ -167,32 +167,32 @@
        } while (0)

 #define RREG32_SOC15_RLC(ip, inst, reg) \
-       __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_I=
DX] + reg, AMDGPU_REGS_RLC, ip##_HWIP)
+       __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_I=
DX]
++ reg, AMDGPU_REGS_RLC, ip##_HWIP, inst)

 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
        do {                                                    \
                uint32_t target_reg =3D adev->reg_offset[ip##_HWIP][inst][r=
eg##_BASE_IDX] + reg;\
-               __WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip=
##_HWIP); \
+               __WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip=
##_HWIP,
+inst); \
        } while (0)

 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
        do {                                                    \
                        uint32_t target_reg =3D adev->reg_offset[GC_HWIP][i=
nst][reg##_BASE_IDX] + reg;\
-                       WREG32_RLC_EX(prefix, target_reg, value); \
+                       WREG32_RLC_EX(prefix, target_reg, value, inst); \
        } while (0)

 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
        __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BA=
SE_IDX] + mm##reg), \
                             (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HW=
IP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-                                                  AMDGPU_REGS_RLC, ip##_HW=
IP) & \
+                                                  AMDGPU_REGS_RLC, ip##_HW=
IP, idx) & \
                              ~REG_FIELD_MASK(reg, field)) | (val) << REG_F=
IELD_SHIFT(reg, field), \
-                            AMDGPU_REGS_RLC, ip##_HWIP)
+                            AMDGPU_REGS_RLC, ip##_HWIP, idx)

 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-       __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_=
IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
+
+__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
++ reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP, inst)

 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-       __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_=
IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
+
+__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
++ reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP, inst)

 /* inst equals to ext for some IPs */
 #define RREG32_SOC15_EXT(ip, inst, reg, ext) \
--
2.34.1

