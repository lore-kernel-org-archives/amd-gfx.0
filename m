Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4865AC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 05:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9975710E120;
	Thu,  7 Dec 2023 05:54:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D594810E120
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 05:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN7fFg0es0v5jks7qvzpDpT0eDZ4nNS/lqGQj2fTSd4NnzI76fhFpusiVkIBdAitDN8+yV+gs8Qro+FP5gtvfiCcyd6erHOqnu+WXR0zrjaJ+xcMovqg8rh8rU/s0bYPNTHpDrMQn8CsX2q+uOYg+k400U2ZZddPgCDdxsJP0ogEHnZDxnBxXtZm9HbnDWU+mmfZYIXyqCx/ULWBg9kgp9weMrbWYH+Ql1B1zvTISeYuPYaQD9XoX4NzFajfkQvcqA061fpdZxz+YWUGnsMG9QiEm7N7fXJOWCKNdkQFoKAlclPSztmUF85+mQdm1IMViCts0al8U/dNpqJuWLDuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6PGQMhfCPITkk+FL+bR6uOFX4/eRlRpG2vfy+mHXv0=;
 b=JAe6dPFCYxhVajiFv+Sxknqw36l1bRjpmURUCABajEQGSwkaGZvjKZKLM/FNaMZzcTNV5O5rZNtplsWzlCvGOFWVsp85QPTIvzqcU/gmrzMDXTKgbjUQyNe/Pp9TR+NIJgWkMiMHydZCs4zn8ai5YCPm7iB43DzUCALnQuCiokJqEh/2vdT3AUogLkybDWTP/EkrRbxUkNI/nFnRxunxwjXwn/Sp7lV+CbrU7CjL5jme5uS/7ITOW2ea74M6rgA/NRMn1fZEQA9hSPdKTmr5jt6dKJFPSsVq89+LLc2QB7sNs0w4ZMPk0qNIClgtA8Sbi5kkc/iwz1qNFq5Sj+fw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6PGQMhfCPITkk+FL+bR6uOFX4/eRlRpG2vfy+mHXv0=;
 b=HT9T5+0c4dS9z8BhQwxLKdvo4ZFMmNq0WRD65xB5iGWsA7X7o7KMZe7rnMAar/atA/0Bj4QXZE/LnK+PuDyKXpJbYCeoiyOGRIBevWGvokWCTfHPr7OI/tbX1a+v4txnz+ao+oLFwxbnlbp3xMzl+TD8e5Pd5t6maZ0QCxwl3Wc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 05:54:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 05:54:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Use the right method to get IP version
Thread-Topic: [PATCH v2] drm/amdgpu: Use the right method to get IP version
Thread-Index: AQHaKMUbinvsJiOzTUeKDDE+/o9CobCdUfbA
Date: Thu, 7 Dec 2023 05:54:14 +0000
Message-ID: <BN9PR12MB5257EED53C80FCF61D5CDC54FC8BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231207042257.1468251-1-lijo.lazar@amd.com>
In-Reply-To: <20231207042257.1468251-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=93a5109c-1ce3-43d2-959b-bc99fa7754f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-07T05:53:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8404:EE_
x-ms-office365-filtering-correlation-id: 1abeccc9-5f95-48bd-1506-08dbf6e8f153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WLkXt1rpnExP8YZ/H9dl6nAD2/cDjuTMJgtbX3PLSHq5Ltw6ZxMa2K2Q4rw7yvaPd9HuOo5XXAaJQM8PpkfemXud/yjponWpti10D5CNy4zhL5TraqN6b7UOcZo2W4h4TcRQp7nA+pem2nNGyIY83S8eYiXoPJKYdhfLz4lVMKR76GickWafoC4td2LU3mDnug05bl5rFqZ+EFgD59VdVI5D0a7kwPUE9546NdusFcUoiKhf0dIrlMeZrmF5iZw8jE+fABMOh4TCmZPpEbbBJwqua3WgmHV3EpjKLMPJ/CAC8q6DUskdkMlLPQ/0mlwKqjUDm+isctaBP9zpYVrpDnQrKLYX9u83pd7VdlMIXFOD8aV+G5/CSpUFah5n7n/7e6A6HuryB0Cgd7PZwYPqoPyVqN+W6hTZjcgiOSkIfOeanHmcjEQizeqjC6aSdL32MXW6iwELP74+d8KiuOJYsexcRiAecRjD/wie9B///P+P6VRLM5XkwroWkBMSsbR1z+niZTOn+wE3tL+yAZcbmSYaslOcMQ0vXv3dOCzMDbCH7EFFOLaHffgDlma+fKtw2BNoIEYPBieCS/Y4H4v83CCkpSWLNBhJFGQROcHs2ZDrEIxr5pdM4Lo3X972cJA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(7696005)(83380400001)(71200400001)(9686003)(53546011)(26005)(6506007)(316002)(110136005)(76116006)(66556008)(66476007)(66946007)(66446008)(64756008)(38070700009)(5660300002)(33656002)(2906002)(4326008)(86362001)(8936002)(122000001)(38100700002)(8676002)(52536014)(41300700001)(55016003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znbhDIGPjUwPTJ6N0/x2rKWBjb9ZAKLWXlqPByXPV8ZT8CRJ4gSH9LVA/I1e?=
 =?us-ascii?Q?5KoHZwB5ZHCRlA83wSY3D0D0316FQwAOEokwmBrL4jcjmTkb5JE0+Jl9Jev6?=
 =?us-ascii?Q?XkciCv9N9i5pnPHRWVHJKtn05NWPlKITJEIZf3cNb3t7+1XekX+KbG5tWGLA?=
 =?us-ascii?Q?48n1BX7Tx0/rFmjMv1KA26AdEKRa+cmlmEoEo0bL7wwLxNdpC1N5mtJqYrXK?=
 =?us-ascii?Q?j/EsMJcSHorXy8UHKlMQliv6DVDtngVxG+o2mPcZmRCkZDwu+32nvOGT5Rkc?=
 =?us-ascii?Q?LL3BYerB260B1K+p+E/pmEiS9aaMPtZB2kYesYhrj9o1qe/5iAWvp88QAano?=
 =?us-ascii?Q?+BVr9Ls0P8FHHQRcxzNjjCinrlCd4bzZq0nLjN2TGhsIMt4TJbCIbVg2cUmE?=
 =?us-ascii?Q?mofb/nXrwogCqVKN4gue3aNulF+L4llWLGUuOpcUMr+wGewGwZVutoLiNwph?=
 =?us-ascii?Q?mXuaN5aH3n3nc4ybIRmWzNmW0k0UkdcoG/KJ8ohgZoY51IWTqMjqBSP0MLaM?=
 =?us-ascii?Q?FYv5neu+VrIo230fOQwQI+VP5t6tup8QDQ+LTJTgdeFjPdr5W1+QcvdovxlG?=
 =?us-ascii?Q?Srtcs+scUgqkD104Ff5o+X9iBNptRWAY/dyYS1L6iX5/OsmHXuJGqAp5apWF?=
 =?us-ascii?Q?6VWPQvB5W7JyMe+dYzWcPe97APizx9TeYvh9tG1DvnoWwtHryZvS+JhtBbIp?=
 =?us-ascii?Q?RtxwFzbIXzPm0003dFnHfKAQR6I4SV4JxHYeaNE22XRWit+ZPI41nLtGHdXU?=
 =?us-ascii?Q?bHYToncJEBP5UWPdCRm60TRR1ZCsNe1vjMD6AfQ+7zNWvjNHHqsJqBuLHRVf?=
 =?us-ascii?Q?y2U2BDVnCI+bpQAjW8ThJbeOO0aWw09HsLkhEQhATkhaqLhe4N1vAoZMc8QV?=
 =?us-ascii?Q?eDY+g7Qp/637GRihSJ6Ir8QmI89aigxuvGrsbrp067a7wlecYXZ0JUXTkp3e?=
 =?us-ascii?Q?bNSQ1IQpRwX3Ukp0WkvB4Ud89+MVUyxoSpriFdwfEFrAA1un33dv1voCtOzI?=
 =?us-ascii?Q?ukmbKS6EC8LZ0fwhNyvUWamowtSOEbLWC282bCaFczU3HI4ChSuoovj5dtg4?=
 =?us-ascii?Q?QOdXJbySuKwQ7RRXPV6G8DXR9i3XZo8IhfDcjzSEIw5vNl6fNqKNB6Ch2K6p?=
 =?us-ascii?Q?3RpVewYzlYEp4z44seIXIuvIs0+7GiDYnc11k4OLnsltP3f8frt2rz/sedrN?=
 =?us-ascii?Q?//ZJculCyYUwCVHwwgbnc19Kl56ZahCmji3MtgiEELObXh2YUFjxXFdT5YxA?=
 =?us-ascii?Q?Cwg6w2iBGxP0dCVigykY/1D4cPOzAKyRu6kYaCdfdsYk/tQY83/RDbPsF/lm?=
 =?us-ascii?Q?zJ0U5eudhJq8Eyqj9UVSd6QukEdDVywY49GVKi7DryQjWZx2L4jEvH8Bd63H?=
 =?us-ascii?Q?hPKJGuSK9HoIMEXp44AyAnVcceQPWXdrxHCyW+3w4kRr4W7Ss4P02gn85xh2?=
 =?us-ascii?Q?+NeJoC6qydrd632X64b9iVRQOneBpF+d5L6PJGbH0a98FhqhzBQdsrXRrEBn?=
 =?us-ascii?Q?GTegp2JZzRegevrcCRqrIsESJsos1Dh4qxn5olXkxNr4aPnvSGtyPKJwufvF?=
 =?us-ascii?Q?GRJ5wBLR0yTLvVb1tgphRweew4Up5QiJt3VK+1TU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abeccc9-5f95-48bd-1506-08dbf6e8f153
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 05:54:14.4089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sm/+IBrQWn5e7BYWVgmuxu9ZPYQp6Q/7mlFTmsisA7FzVUwtqxVRkY3TuCQnyRBY+wLZgAn9YdGS9Cj9+HovCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, December 7, 2023 12:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use the right method to get IP version

Replace direct usage of adev->ip_versions with amdgpu_ip_version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
        Fix two more instances in amdgpu_dm.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1b73f519cfb8..f9e8341d9449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1599,7 +1599,7 @@ bool amdgpu_device_seamless_boot_supported(struct amd=
gpu_device *adev)
        if (adev->mman.keep_stolen_vga_memory)
                return false;

-       return adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0);
+       return amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0, 0=
);
 }

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 3a632c3b1a2c..0dcff2889e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1099,7 +1099,8 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device =
*adev)  {
        bool xnack_mode =3D true;

-       if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =3D=3D I=
P_VERSION(9, 4, 2))
+       if (amdgpu_sriov_vf(adev) &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                xnack_mode =3D false;

        return xnack_mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2ac5820e9c92..473a774294ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -883,7 +883,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
         * GRBM interface.
         */
        if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
-           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
                RREG32_NO_KIQ(req);

        for (j =3D 0; j < adev->usec_timeout; j++) { diff --git a/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdg=
pu_dm/amdgpu_dm.c
index c146dc9cba92..3fd01b7b7766 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1710,7 +1710,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
        init_data.clk_reg_offsets =3D adev->reg_offset[CLK_HWIP][0];

        /* Enable DWB for tested platforms only */
-       if (adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0))
+       if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0, 0))
                init_data.num_virtual_links =3D 1;

        INIT_LIST_HEAD(&adev->dm.da_list);
@@ -8908,7 +8908,7 @@ static void dm_set_writeback(struct amdgpu_display_ma=
nager *dm,
        }

        wb_info->mcif_buf_params.p_vmid =3D 1;
-       if (adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0)) {
+       if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0, 0)) =
{
                wb_info->mcif_warmup_params.start_address.quad_part =3D afb=
->address;
                wb_info->mcif_warmup_params.region_size =3D
                        wb_info->mcif_buf_params.luma_pitch * wb_info->dwb_=
params.dest_height; @@ -9860,7 +9860,8 @@ static bool should_reset_plane(st=
ruct drm_atomic_state *state,
         * TODO: Remove this hack for all asics once it proves that the
         * fast updates works fine on DCN3.2+.
         */
-       if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->=
allow_modeset)
+       if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 2, 0) &&
+           state->allow_modeset)
                return true;

        /* Exit early if we know that we're adding or removing the plane. *=
/ diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index d8f8ad0e7137..4894f7ee737b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -224,7 +224,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
        if (smu->is_apu)
                adev->pm.fw_version =3D smu_version;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_2;
                break;
@@ -235,7 +235,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
                break;
        default:
                dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-                       adev->ip_versions[MP1_HWIP][0]);
+                       amdgpu_ip_version(adev, MP1_HWIP, 0));
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_INV;
                break;
        }
@@ -733,7 +733,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, =
bool enable)
        int ret =3D 0;
        struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
        case IP_VERSION(14, 0, 0):
                if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
--
2.25.1

