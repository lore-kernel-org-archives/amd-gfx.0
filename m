Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF747C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 14:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D7C113279;
	Wed,  7 Feb 2024 14:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7wsMouY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65B113279
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 14:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ5yQm8xK3abZwCYuF6noUL0O+o555RcMcSFxFNArwf6xYsLtPhVpgn1uzNffwKQG5pKXTm3XsRR3P7A2zJvMtRKZl94mrLhUz83XcZADo3+luEXGG/HTGgycMl9dbkTTBScpZEf9Op0xTY5hNfDFooE3RZ2/f17hDZd58fKCrbS8D9fh/8bGiHLLgPyNL6QEWZGqV6nHNW/NBmxcEqOhQA+LOGeltLEyGsPyrqu9h7MYk1JEpEerdspsJS8XyeJ8rWZVY2YCdZ0h6tQ6/FO94S7G/IcWMES/EBLntoq9ww89UK5ISGUlCgNfmLr6ziaA+/lWdSpCbnPN1CptTk6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW2k1mbEB0WO/BUmCCDN52XlnHuuZet0ujOWEiqMxCU=;
 b=fyQagFGcMvcM9AsF9dAlOw5ajoCLVf8GPAmIhcJsCO3wKKBzgKNMFmHqIZtj+I77pOQXXP6yOSJvXOM9K4+J4YsPSKoojplzBuvsjtswEKK68Rh+PUdjnBmdC/49n7+RBkvm4stafbobCJw3cyIjDBAEJ4vfFSiV2nONhjEe2iNadh4nbNgrRF96p6ZgO4BBr28FABbqm2PHCmOyplr4sgeNqDnxrbXWWzVGXIpydXaxUjv/CrTiuQkRG6kNr4Oic4YtlM3CJyoRk/wYI84wvUiF8BRJD1iaF2zVSzHSnKmQSoaMd0xqEi8/vq7jr8av0r8jdLy2ANsSP9V2/lRSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW2k1mbEB0WO/BUmCCDN52XlnHuuZet0ujOWEiqMxCU=;
 b=a7wsMouY/RS0A+oibKIoRFm/SDNXSboKYqqXnJp2AO5BYI/d3E3voWAzvq4U2h0D7C64UZvhVRb9GzuHoeQ8fsafNXU3kHip8A01t48QzLFsTcyjQ9eyRguOcVf1d/6zYQeUJnuMVrTrU4FuZZHymT20p7WTBfFlaCSHvGF0X+g=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 14:01:30 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 14:01:24 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu
 v13.0.6
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu
 v13.0.6
Thread-Index: AQHaWc1ExmqYH/SDd0GtLXKLolBfaLD+6E6AgAAAOCA=
Date: Wed, 7 Feb 2024 14:01:24 +0000
Message-ID: <PH7PR12MB599755ABD9708500B5FA749582452@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240207135418.693925-1-kevinyang.wang@amd.com>
 <BN9PR12MB5257BDED870EF9C892074F5CFC452@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257BDED870EF9C892074F5CFC452@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6378a690-95bc-4465-aca4-517c889b323c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T13:58:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB7574:EE_
x-ms-office365-filtering-correlation-id: 95e1ab2e-789f-426c-9375-08dc27e54586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmhYCEJ3aE/2e3/6oxTYCRjkHi5fPNve4OwFnoMR8+Q+9d4ov9UQ9oPTMjAvH/l9lKKtkGbtW1/RiYrErdO1VHWRy9U3HsMXIObhONPu6+b1a7fdJm0KrPkwueGIwidwIlkkQavaDfulD9Jo3TPDZ/WNOZj0ayyGkVpq8nhNim/y7Oc2TZUs1ip2PLD0ambRQlqoVby8lYaKc5sQZlxqRQlCMVkQDCMSlQBGff+Z39p6ryugplg3fB1PEB3aYd2Fw6Vtrz7V/Gj/VZ6/n47WVLA/OfagSk409gC2GMo9PzkPUkpUybwnJIZIUoBqyFS063E2D5KsDjfFsFSBIFwRaKu9DM5gRXaaTLRSzXP3jjdsEukB92QiGJYsah9LVBRGEFXfd8ORANEPppyX0G4g2PgH5CPrIQ8kVZw1P+qGzPxRnjfWTIY9dSMETxv68owkasbyoZ3Dj1rYyhzzmOGj1szUO65UL+S8Xocl6cBcv6Q+nnk24VrZKh/J7nvm/kzu26+ot1TIfMbr1cMHBW3FnyPCATIWdEuk5i7NbNvaC0E/MV28nirlHaHCNaHI7eQMXR+ZnsUJRZnUYwMdVo1QKXIwv4i1JORoVsdc3M+IRvHUse/2myX4m7Rb5QOuMEc7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(478600001)(5660300002)(122000001)(86362001)(316002)(41300700001)(6506007)(66476007)(64756008)(9686003)(38070700009)(4326008)(7696005)(110136005)(66446008)(71200400001)(8676002)(8936002)(76116006)(38100700002)(66556008)(54906003)(26005)(83380400001)(66946007)(33656002)(52536014)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?crOnr+yKfenfMcMTeALC/kvXqWCe1bMIt/C49X3kiE+9+MxzxyOvnnyOUmNa?=
 =?us-ascii?Q?XOT95nvarLI9wXriMqTnHpbf7yryiCIBOBIMHvc7cy/UNU9qWwaVmkRlpTZu?=
 =?us-ascii?Q?bi1fB2X97rJdPDt6VPpaAhImk9LqCYE5knXziSxgXaHQf79A8RBtWmkvkCZp?=
 =?us-ascii?Q?DrFy/ChQhHVf9niSuBkVxJwjylXiP9eHd8gG/ahp8E6H3WJ3sJr2JkBJ+jP6?=
 =?us-ascii?Q?ypdWQOOndllysQR+R+wSsMIY/0YqDLH+5f5lP1BvOsFuYI9BsxNa+YjfuMfW?=
 =?us-ascii?Q?EF9KLhNxJV9VVHPheopp97ySKybW6cASyWEEB+JHjfx4tmJ8Y5WRgNm6OHJa?=
 =?us-ascii?Q?XtEzuerEQrA0OT2LBGB+zw1nOfETFKbDEYFalpjE/zWcXALASkZoLu55B0+b?=
 =?us-ascii?Q?eXv3gZHpGZ8e34sXuGxgglaXrEELsMAowU3KXLwEC/TCBqcaWcM5hsk//ncy?=
 =?us-ascii?Q?Y6YNwxqPt+BnG9IdV6GlMmONBkB05C5xPef3vXITTvOGNACraClthoREBi7f?=
 =?us-ascii?Q?/x7/SwAdyv5Gq9CeH+DRV/kuMRcbEKMHSGm8cf52CaRW7l36dzRK5yusKwBl?=
 =?us-ascii?Q?DobbaAcQIQzE8UZBkRcHC4iKmTcv/YokjtYxoW3VPzE6ST4zeqiggsD3K4wH?=
 =?us-ascii?Q?GhqfCoCCoWmh8P7uXJ3ZH8HqIqZeUYm0vuCFivP8mMI/ejNZ3VX2PjINGMpS?=
 =?us-ascii?Q?yNL4qaQqVZOa+LdH44cIEy1TZz5wNhA/+BfCTVcwOLV3ehRLDSG8MPLR3ZMX?=
 =?us-ascii?Q?BKGU1tecMKmL8c0njzX/p3pmC1Uu1pBGJj8MBovLQGfZsVTA+zOVc6FIHhGv?=
 =?us-ascii?Q?Qb0zMrH9Xsi0zcZeQAe4UFcBgbiwUao+xEqcupO9QQxj3df0I9YyHzJdnZyZ?=
 =?us-ascii?Q?32EjWm+p+VM3XeRnVpJovayvjNKvDcxdA9OZJ2823SvnK0DVTmcsFW5cOi9/?=
 =?us-ascii?Q?F0z+M7VVPHQtCspGPJSQrzCjW+4/g+OE3RF4818SW1ZR/8SXRDgtUWJE1EF/?=
 =?us-ascii?Q?BFvHJ54udLb44Ekja8lxE371ELy/iGspsI0iNAauWeYKeVOkP8BPM1Xmfp4s?=
 =?us-ascii?Q?A/ceDe4Su7J5ICNkbPwjK3ryT9wVPAmMVz4iPaab/KKXEk/sfmc7NlI7V/DY?=
 =?us-ascii?Q?LWR6gySPSJdsrY2cGw9HgPhaiXTjtKveR/HdqYSwtMVec4xyWVehq8UJQw3V?=
 =?us-ascii?Q?xJQ0ukK08qP9qsZFkEbCcqEsW/kIGms9I7P2yX/ATcCNhy9ZfN5TM/6dAAfH?=
 =?us-ascii?Q?UV8+St4ly+1paAsAQH4n9Wj3jkZGErrzX3WTRK6WO9nqesVsyCFT+a6lDQNp?=
 =?us-ascii?Q?Id28xNhC+eGz3YQ9MvkG/xXj6II4tGs0aAkpMjoezgSGistKdhuo3Iz3kD4q?=
 =?us-ascii?Q?pXEfcSTeWQIuYVTKVXRf2iPe0jdBidDbeu+oTlpmamrWAOq4kebEg3PA7bLa?=
 =?us-ascii?Q?w/yRhJbFNGZWAhhZPSiRZA8tmZoN2MF/qH0rbOmcH9oQJaiWuGaDO+Uz43Pi?=
 =?us-ascii?Q?XoctuAis87kuVVFlCTeqnJbs9Kbgt9CkbXwEXyfl0I7qtp2fQl9RczvyyZOc?=
 =?us-ascii?Q?XNrYXVW3QFXKW3DfN64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1ab2e-789f-426c-9375-08dc27e54586
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 14:01:24.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu/P0ZND49lvC3GmIK6cMmpB9AtwZYhqVVmejpAyzyL4Z8NJm4UurgMhV0lzBWS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

Thanks , I will correct it before submitting.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, February 7, 2024 10:00 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for s=
mu v13.0.6

[AMD Official Use Only - General]

With a nitpick below, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

+       MSG_MAP(BadPageThreshold,                    PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),

Might be better name it to RmaDueToBadPageThreshold/SMU_MSG_ RmaDueToBadPag=
eThreshold

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, February 7, 2024 21:54
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Subject: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu v=
13.0.6

implement smu send rma reason function for smu v13.0.6

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ++++++  .../pm/swsmu/in=
c/pmfw_if/smu_v13_0_6_ppsmc.h  |  3 ++-  drivers/gpu/drm/amd/pm/swsmu/inc/s=
mu_types.h  |  3 ++-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++=
+++++++++++++++++
 7 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 6627ee07d52d..f84bfed50681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -693,6 +693,21 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu=
_device *adev, uint32_t si
        return ret;
 }

+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret;
+
+       if (!is_support_sw_smu(adev))
+               return -EOPNOTSUPP;
+
+       mutex_lock(&adev->pm.mutex);
+       ret =3D smu_send_rma_reason(smu);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
                                  enum pp_clock_type type,
                                  uint32_t *min, diff --git a/drivers/gpu/d=
rm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3047ffe7f244..621200e0823f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *a=
dev, uint32_t *smu_versio  int amdgpu_dpm_handle_passthrough_sbr(struct amd=
gpu_device *adev, bool enable);  int amdgpu_dpm_send_hbm_bad_pages_num(stru=
ct amdgpu_device *adev, uint32_t size);  int amdgpu_dpm_send_hbm_bad_channe=
l_flag(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev);
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
                                       enum pp_clock_type type,
                                       uint32_t *min, diff --git a/drivers/=
gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu=
.c
index 0ad947df777a..138dcb8724b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3669,3 +3669,13 @@ int smu_send_hbm_bad_channel_flag(struct smu_context=
 *smu, uint32_t size)

        return ret;
 }
+
+int smu_send_rma_reason(struct smu_context *smu) {
+       int ret =3D 0;
+
+       if (smu->ppt_funcs && smu->ppt_funcs->send_rma_reason)
+               ret =3D smu->ppt_funcs->send_rma_reason(smu);
+
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 66e84defd0b6..a870bdd49a4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1341,6 +1341,11 @@ struct pptable_funcs {
         */
        int (*send_hbm_bad_pages_num)(struct smu_context *smu, uint32_t siz=
e);

+       /**
+        * @send_rma_reason: message rma reason event to SMU.
+        */
+       int (*send_rma_reason)(struct smu_context *smu);
+
        /**
         * @get_ecc_table:  message SMU to get ECC INFO table.
         */
@@ -1588,5 +1593,6 @@ int smu_stb_collect_info(struct smu_context *smu, voi=
d *buff, uint32_t size);  void amdgpu_smu_stb_debug_fs_init(struct amdgpu_d=
evice *adev);  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint=
32_t size);  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uin=
t32_t size);
+int smu_send_rma_reason(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 509e3cd483fb..86758051cb93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -91,7 +91,8 @@
 #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
-#define PPSMC_Message_Count                         0x41
+#define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
+#define PPSMC_Message_Count                         0x44

 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 953a767613b1..efd97408b667 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -261,7 +261,8 @@
        __SMU_DUMMY_MAP(SetSoftMaxVpe), \
        __SMU_DUMMY_MAP(SetSoftMinVpe), \
        __SMU_DUMMY_MAP(GetMetricsVersion), \
-       __SMU_DUMMY_MAP(EnableUCLKShadow),
+       __SMU_DUMMY_MAP(EnableUCLKShadow), \
+       __SMU_DUMMY_MAP(BadPageThreshold),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type diff --git a/drivers/gpu/drm=
/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/=
smu_v13_0_6_ppt.c
index 40ce3f780847..f2311138e8fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -172,6 +172,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpD=
W,                   0),
        MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 0),
        MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMo=
de,                  0),
+       MSG_MAP(BadPageThreshold,                    PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),
 };

 // clang-format on
@@ -2381,6 +2382,24 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(str=
uct smu_context *smu,
        return ret;
 }

+static int smu_v13_0_6_send_rma_reason(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret;
+
+       /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and ab=
ove */
+       if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a00)
+               return 0;
+
+       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_BadPageThreshold, NULL);
+       if (ret)
+               dev_err(smu->adev->dev,
+                       "[%s] failed to send BadPageThreshold event to SMU\=
n",
+                       __func__);
+
+       return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)=
  {
        struct smu_context *smu =3D adev->powerplay.pp_handle; @@ -3095,6 +=
3114,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        .i2c_init =3D smu_v13_0_6_i2c_control_init,
        .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
        .send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
+       .send_rma_reason =3D smu_v13_0_6_send_rma_reason,
 };

 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.34.1


