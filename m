Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB3CD343F
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 10:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7A010E15C;
	Sat,  9 May 2026 10:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pq5P0KET";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028F210E15C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 10:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2gmC0Jz5Bbqdc7Ldk7nnC9EOEHjuq/tFjdM4IKlW3vk7LQV7PMdtj2rymPK8pGxQLYqg7i6CaTfwsmOokf0Ysb7mIvYRbw8LOvMz8Y2IA+4jYcEHcxPpgwIyEJNUcuwfcwgnP7SGxCqW8oYNJjhb7UCyTZvxmO14wpgIjpQ/WoB6jQhL+eAtexf8KjTWIB/w1KOw3L9WGfWSJ6YLiOzTpriPBsd/Fem5HcGZSRxQWqWLdtKjkZWGSRyu/hcSaRt1t6lurakdmPNNgL0NWoZc+R/1w5/RE3C3tYQFS0hRLDLXvmvZZmGNb42iLT0yQ3tLcWGxMrnwkYIS/FD24ZVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2kwUfKsgiyVH0+wbKKrQVktylHDBerRRvyi7xbzIpY=;
 b=mmGSMFfUx9eRAQnn83k3gukghB5fn5NG5L2ZdOnu93zxWJpRdaMg0Uv16Ru2FlQj+NtAgUAzIXees88kyXxXPKPl4h0tnvsIvBRhA/Jj3Fa1+AVo5ak7j5BuAZbfBqgWFlzeScB6veMhS2wplp8nH/fotle1FOsz/EFj9gW8Rea9+LKZKn0saSdQAsJYXDWSiGzPHzPjxt9+naPHKeiN/fShW96dqyKQir8IDCkx9r7DO2OAhlYg4nzU8Nd7n9IwqYxwBZbEW7TbJ40s9zs3bau6slJK9XyEtWJq1errwMXoPPfIsWWY0Hs6VogvU5uC3oByqFLc5XuITBOLaE6d9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2kwUfKsgiyVH0+wbKKrQVktylHDBerRRvyi7xbzIpY=;
 b=pq5P0KETMsPy5eBA1cWfJeeDjIpiW38Xx0bC/jeIgqGOTH0nBl3lXsz/RNLLRX34G/HJs0uNKQWlM+xo55myP8ExcuEQg+Tc5i7oiVbeqMeQaf28gsORAzwj0pK51qKQSV6VC5cWJ8iqwDQ0c7A70TN0NPavZqQAHM4cQYfWJXU=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sat, 9 May
 2026 10:25:11 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:25:11 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Add guest driver CUID support
Thread-Topic: [PATCH v2] drm/amdgpu: Add guest driver CUID support
Thread-Index: AQHc35zC0AMzeXFgmkmYJRi4TbsYCbYFeoBQ
Date: Sat, 9 May 2026 10:25:11 +0000
Message-ID: <DS7PR12MB576885AC7F930CE22CAFBD019B3A2@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20260509101508.587490-1-chongli2@amd.com>
In-Reply-To: <20260509101508.587490-1-chongli2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-09T10:16:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|PH7PR12MB6738:EE_
x-ms-office365-filtering-correlation-id: 2d73900b-bc7e-4b5e-10ca-08deadb54049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: rUbmxPJscT+ZIGJejWa1wX2fY99ph9Sf6Hxs//WoD6tPg3y/htP7PNSNKpgtRg90UFaqXHebdSBfVJ5KvAlRBPvwQF2Y8nZ6rG7cERs40nbgm4fMKdyFjEeG0/9mP+6IWrQrwpzeg1SoBSDVSpvAFPitC6PPhp2ar4BByIJj0ghcyFMwxIz6UJOhZNbfJLsNKUQUBLJKDKAf/6yV0EdbL96OgL4fYM78EqyCNitmKJ462ldNI8ZwTBvw24Rla6VLLmUD/+pGAmL6+ytXM7wk2pupsJwXgnxgxZZgTevc7gH6Cwm0XmHPHOtTEYYsxnlVrmueex0ywv4FE3dC8Ux2dwlnGV8s3q83ug757bpYLHRMrsCTJclmxLom5ECm88ulXRHfR723aSSwfvqfKjEUdjU2iqPZD5xC7hIdpq/ZD1bKm27AfsNfxBW67uH8NtQMQqtc9ll6P4iUcqPlZ00Qdzd3HC0HCfU8zFVoYxBebbQl/zUE+tepd1K148GhKHSs/KbABWG11IPfhG2PjCe4r4mNbBX90WJx5YHCzz8bIBfk1DQLVY40wjT+0dpejDsD77pQrr9N1QcVxY4vMRTjMfnU/qxs+x288N3H4Z7IHCRjVRrc0lTxuFluZLrmlRsd9zmQFpX8hhXXg4LCgNf1OG6xJxxPRXvSHmJlgVCKMa2s2yL+I/o4T2GArf2JxFd4X281pG+nIY57c//flceiRIQPo2HCt+PUZxEJ2Y9H/u1IQLZaXUkv9WDifdblWV3G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NaQoWeAhuupetI1h5hTjqAlmlPWZgXWrUgUAMuiJuqIRPJwhHR3s5evXZil6?=
 =?us-ascii?Q?bpuOtQT26OxY9LO05m8wkDRMNpgDmIw51cRMuIJZs2pPsjGgSL/Ej9saz60K?=
 =?us-ascii?Q?csZ/tw16LDLgg2SvOzLqW2ORpLPMCQ7R2/DlwxIBLzqbiyQ9A2/Q5P0CXYOS?=
 =?us-ascii?Q?jDWrtr0fyW0N0SZHjx1knszvLtG4+C59kjdTpXQ1L5CN9ovMx/SJwrB1djZS?=
 =?us-ascii?Q?KNVwNhnkeI/B8TnB4v2XUwk6K+SHVEUPoxGo08BI9Llz9tF6QkQuoilWo3oi?=
 =?us-ascii?Q?dF4bvt4O5EPDBntE8c1/IPKhEcIqZRTj+aJtBXo9/wXNfJ1AonHInhTD7y4d?=
 =?us-ascii?Q?FbGB8clb2UnXN4xkppUlS9axVAi1jt+ja0+PMLJCUpO3+JFzF0amaSIZW3kW?=
 =?us-ascii?Q?X05nOOaugClu72CHruz82jasWx4BgzkQcQ2XqyjhaNp4zuev6nstcSyFNpDN?=
 =?us-ascii?Q?vUKqlf/m6GDvhaJuK+a4weRI3CzS//++NQBcMfqfmbm5hCEoZ1usD9z6Zrz2?=
 =?us-ascii?Q?r/p5aPCVPkgHcFMGeScrwC2K70GYxrxSXwjPCwPNNwn0wAC4wtqgCZHeo52c?=
 =?us-ascii?Q?Pcwy+UgyMjIG4PJcj6zugBREr+hrA0TqwsLpE4NMhH2LIEGE4tUjv7Vusz3e?=
 =?us-ascii?Q?zDEO2v5f8EQiVam103S91eBoYHXB7YhIyHCsmwZ2cyb/lBOyS772mNjB7x1+?=
 =?us-ascii?Q?KZu/WLpzLsOTGKUuNeNUKsXbQ3ZkNLOlzy4GQKAdVtS0YORUc/oPtMURRr7z?=
 =?us-ascii?Q?DNwbp2t0oDis6mj/eV3XXFlB5DqVtAAujBZhGzTsruuMiwmyObbG0Px6KpjY?=
 =?us-ascii?Q?4PP1LWpr1dHdYTyXNEmvVQisCRk3mRADHBx9i93ISs6ZLiF2RDDXo92TDDJS?=
 =?us-ascii?Q?zdJ+sJQeMOrng3+IbyrwY5hr2EgT9LQJono7z4turKg1tBFp4KfD+VPREGQb?=
 =?us-ascii?Q?a/exyWYemcdmegPc9S77ov/w7JSi33LihIUqS1pwaoaRUZa5Msw2ZTyhz4Vk?=
 =?us-ascii?Q?01v1o4MBLZumHF/YR4vfJLKg8mIJkyk0RankeUljNEGlcbAM/XJNdgMRQdh1?=
 =?us-ascii?Q?FG3cMe0AIHRw8pQvXRN19KRmyYtHVQ+f6MbWOpPEHW5Uoc4CKUFgXBv8/6aO?=
 =?us-ascii?Q?7viST9kPbAVPbiVVFZ4Ku6b8Ta9hBs7UMZfLazoD8hPtyi7dPuhiHb/j8aMc?=
 =?us-ascii?Q?i3XngV6HfmnAp1ikt3mPZ3Wbvge9QKfri1FCu85f8klXOr/WrV0qagBQ9pI5?=
 =?us-ascii?Q?mkHzd7rqiyDyEprsURxKVZHs+u1oQ0d4D5qTkVF/EGlm7xT+ulfB2V/Q821q?=
 =?us-ascii?Q?C+0WY9WAId3FPmLgsbXbIlbntQ8UuQGC+78VchVKPUGi3Vl7RlqHRj5tw8r+?=
 =?us-ascii?Q?b+Sg6Ykku8SfTg7aR0tdYnj6TGcBPKuX4Ol1jfSm5wG+ZAEKtoVoMIGPqQwb?=
 =?us-ascii?Q?PbuGqUFI4IDBMuaXtLyBOhAcXVI2u6sAo7eW6+LgX4fltmfZZhyOYEF/Ihzq?=
 =?us-ascii?Q?QuT8H4q5XP4B17tsmhCbklnlsIRIMKc+PxE4KcqrN/KhmeTlgfzC2MbenZMm?=
 =?us-ascii?Q?pXmJxVxOBlOZapyCg+O9wBgQShQp5uVnDOwZ/25F75HmrJYduKMCszP8SrkL?=
 =?us-ascii?Q?6Piv4q71gAgFYTuFvCCocKbvi5bBQbfesntVpgVso++Zp0djcP6C7d3wlmKv?=
 =?us-ascii?Q?06p46e54PgdeUZN/tBo4vMXSSP90m3aSaj2ZHnsp2aLgQzhA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d73900b-bc7e-4b5e-10ca-08deadb54049
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2026 10:25:11.2052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtbOGmjSt+9COXMRQJ+7mZFIVSyjDHU9vGQIitQHnaBt3dgFuCUR9Scb5YdD8HC72t6eVQg05Lg//+K7LqfyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

AMD General

Hi, Koenig, Christian.


The line " adev->unitid =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)=
->unitid;"
is 97 characters long, and checkpatch.pl enforces a 100-character line-leng=
th limit.


checkpatch.pl passes my patch:

        root@chonglidebug:/work/kernel/linux# ./scripts/checkpatch.pl ./000=
1-drm-amdgpu-Add-guest-driver-CUID-support.patch
        WARNING: patch prefix 'b' exists, appears to be a -p0 patch

        WARNING: patch prefix 'b' exists, appears to be a -p0 patch

        WARNING: patch prefix 'b' exists, appears to be a -p0 patch

        WARNING: patch prefix 'b' exists, appears to be a -p0 patch

        total: 0 errors, 4 warnings, 38 lines checked

        NOTE: For some of the reported defects, checkpatch may be able to
              mechanically convert to the typical style using --fix or --fi=
x-inplace.

        ./0001-drm-amdgpu-Add-guest-driver-CUID-support.patch has style pro=
blems, please review.

        NOTE: If any of the errors are false positives, please report
              them to the maintainer, see CHECKPATCH in MAINTAINERS.


Thanks,
Chong.

-----Original Message-----
From: Li, Chong(Alan) <Chong.Li@amd.com>
Sent: Saturday, May 9, 2026 6:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chang, HaiJun <HaiJun.Cha=
ng@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add guest driver CUID support

v2:
use debugfs_create_x64 and debugfs_create_x8 to create node.

v1:
1. Add guest driver CUID support
2. Do not expose vf index(variable "fcn_idx") to customers,
   replace the fcn_idx with pad.
   Only expose the unitid to customers.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 80b18bbd7f3a..98549a148695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1074,6 +1074,7 @@ struct amdgpu_device {
        long                            psp_timeout;

        uint64_t                        unique_id;
+       uint8_t                         unitid;
        uint64_t        df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMON=
S];

        /* enable runtime pm on the device */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 979032ecaf79..129ff0851738 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2126,6 +2126,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
        debugfs_create_x32("amdgpu_smu_debug", 0600, root,
                           &adev->pm.smu_debug_mask);

+       debugfs_create_x64("unique_id", 0444, root, &adev->unique_id);
+       debugfs_create_x8("unitid",    0444, root, &adev->unitid);
+
        ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
                                  &fops_ib_preempt);
        if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 6974b1c5b56c..45e89e104b5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -534,8 +534,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_d=
evice *adev)
                if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->=
virt.encode_max_dimension_pixels > 0))
                        adev->virt.is_mm_bw_enabled =3D true;

-               adev->unique_id =3D
-                       ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uu=
id;
+               adev->unique_id =3D ((struct amd_sriov_msg_pf2vf_info *)pf2=
vf_info)->uuid;
+
+               adev->unitid =3D 0;
+               if (amdgpu_sriov_is_unitid_support(adev))
+                       adev->unitid =3D ((struct amd_sriov_msg_pf2vf_info =
*)pf2vf_info)->unitid;
+
                adev->virt.ras_en_caps.all =3D ((struct amd_sriov_msg_pf2vf=
_info *)pf2vf_info)->ras_en_caps.all;
                adev->virt.ras_telemetry_en_caps.all =3D
                        ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ra=
s_telemetry_en_caps.all;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 9dcf0b07d513..d80f01c0e754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
        uint32_t vf2pf_update_interval_ms;
        /* identification in ROCm SMI */
        uint64_t uuid;
-       uint32_t fcn_idx;
+       uint32_t pad;
        /* flags to indicate which register access method VF should use */
        union amd_sriov_reg_access_flags reg_access_flags;
        /* MM BW management */
--
2.48.1

