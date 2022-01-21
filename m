Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E346C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF50210E8F1;
	Fri, 21 Jan 2022 07:16:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E4810E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIeRJ1gz/yZfo6OIedTVkB8n88BhteTpcuAShpPYJcmIwRJWcQd3bVLwrjDcYXtag2VWpvd7b9f7gjetfjnQC2VBjjBy6Nii0DR80cyzrOhorrBczUdzaLj//Y3RQIhSQRXSP1Cdjq9N7IYpz9w6EHBOtleoeRzSz9Q1IXITHLB+1bXyncmFGKitUcKSRsMjMeW6cPM6TPmvJAsbQbNkO7B9LTCpb1R0nBcyIDDe5fsIoFY4SiPx1qJaL0QTJlao/XAchuz3gzw6TnlLfmvstGnlbfaU+d3Mg28Cd9CGG+pzg9d2BptLViXWW3n1uGtz6B48sizpGs5TBhL9pAjq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frKR7J93eKaG5kCM1o6hsbeGRpKOzCR2V5ZXSxd0E9c=;
 b=ibjMzSsdDq5HVzZQ2X57SzxfqC83LeqBEQC6uHm511Ts//8596c+yd2I+YvkSv4zHR2ylkFMr7ZIlH8LGXlC5+oDy4CKnktNP/dNb+VvJLmGwQslTT6MKib0Rd1I4yr5+M712kRpTQGHdNX8zGMVKquUhzvvaJUif7n9jp2S8xCMab84NZAlKCrSbPjXllKMaK6lzJ+JcU1FdVDCBe+Hroft7TAmkT8m+xBfMtDoBXak2TL3G6k/lGVXDT9gRK9HB74a5skoojIewHefiBAaMYPGIkKrQ6Fix2MLtZIHoqt4F9tO9sxQ+Izj9CmR+qOr58gZILchaHxLSEHoxX0lEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frKR7J93eKaG5kCM1o6hsbeGRpKOzCR2V5ZXSxd0E9c=;
 b=Bb3LUToyWhkCiS9Mc+zL678PZmQ3aU/AD0qqn9GCPtSyK22oOq+iaPlepZzIruuYwyZEV3Kx+kRc8ZP+YNhTuwvD3EcOAh+omrwcfLntuR3Bk8w4v8KfktbRqjaVMr1kdldxSagP1n0fjK9IP9PlrIgaXv3eZEwy4NV1gPBEmPA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Fri, 21 Jan 2022 07:16:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:16:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 1/7] drm/amd/pm: drop unneeded lock protection
 smu->mutex
Thread-Topic: [PATCH V3 1/7] drm/amd/pm: drop unneeded lock protection
 smu->mutex
Thread-Index: AQHYDpV9Iy5i1haJ/E+gypUMJAp/f6xtECqQ
Date: Fri, 21 Jan 2022 07:16:05 +0000
Message-ID: <DM5PR12MB2469E6853D2751FFDE814FC8F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220121070635.638212-1-evan.quan@amd.com>
In-Reply-To: <20220121070635.638212-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T07:15:31Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f7a2b6cc-71d4-44ca-b1fb-9cc051488113;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T07:16:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4c0a918a-abec-4f6e-a1c0-65f3f80e3724
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 461415ae-27f1-4bd5-a8ed-08d9dcade3a4
x-ms-traffictypediagnostic: DM6PR12MB4862:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4862E27BB5B340830847D72FF15B9@DM6PR12MB4862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GoK6WcTkz0M4LIA5v8R6K4d0Di2RGOQWdGKl/DYiZekL6caO+tfPo9UyNkWw5Uf6f4nsQpswTDMqdm3op9lYnU+qgxM2aVq3nuaSGKRRnVpe0Sc/7NDtSN3QOBObHpXa+QU54hpiKF4oSO9baaVS4cx4g9GIjm3bYmmYAjrg9B6U0wxZ8BbPoElPDSk+e2hTRQAbNPegc2pQxoNd7rWHKMnHH33Tpkhg4ZdiMyogHOkyj8VYvQn4TqHlThJcxXDnlV6jVf+JjBtVYyof8vrgyt1VMR3jWyvpLzAiHhpgEJ8U/7E6jxsW+LqDWzdSp7PoWOHjWOlB4BvRmw67g74sYUozQdVEqmNWoGa7B2K/+vlqN+ESaeAJ6sMqMEdPvSjHX7g6cXgpznDaoPkqof370SaR9a+VVpO3HBiNxaHBnZgNpfwuPD90ThcWLhOpRV12h8B08Gd9ro5cVCxwhSU2dkGNekLov/kZDivTU7L085B8M7H7G+HtuRjBo9KAiPlbDNwYw/VWxUrBhPhJPPoxL5HG1HoTHEh1jpbdl2eX6TBJsgQZBwf44Wr1pRYsUU8z77rZfXrWlotlEV9GrlydLKRpjqru7BVubnRmqPL3Kd3QzNQgxoAfw56k4QHVNWPWOEePW6mjiefvcYj1nfrOX0/lY2Q3SDCxyj9XVdand3J0XrwibwI9zFXzd4gP6Lef+DXQFatdTlBqrzNS7V+hFN+D5d9xK/9DofYPM/1r/s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(86362001)(38070700005)(66446008)(7696005)(54906003)(8676002)(53546011)(38100700002)(64756008)(66476007)(2906002)(186003)(66946007)(76116006)(6506007)(26005)(508600001)(9686003)(52536014)(8936002)(110136005)(66556008)(71200400001)(5660300002)(4326008)(55016003)(83380400001)(30864003)(33656002)(316002)(579004)(559001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1UG8rbbbVm0FAodvOgG8vvFD2V3H1eMTfLXL+Ve2ggcDUhRBoLf3CtbnrjL?=
 =?us-ascii?Q?RqQQC644ZPRZUAy0ttRfMqCcl4yUbA/88XjvSwhgSz1yxXRGsjUmzh/Yijl+?=
 =?us-ascii?Q?EhHmLxdAFvkYADZo4My+K9d8r7ri16roMIeyQfFvW3F//TL0NZTq4XXJlupd?=
 =?us-ascii?Q?71Os2oKx/BQJAa+AjjpKdRcHVD9AlXMurIoj1o9hAtsppLozRBw1vzO76KFE?=
 =?us-ascii?Q?yECBgVORN7xvUvnHe+ibTgvys4pcvA5AvA73TxKWcaIBrQjagRR2SW8nEL7K?=
 =?us-ascii?Q?6HcOMQsLeBL6oZQ1PlW4kuZT2kpU1EIXdMy9ac3+s29NDcjIWvTInAAvHML5?=
 =?us-ascii?Q?z8Y+ZrPRo7cT6VwyxSxVHdGtX7w9Yq8V5Nw3rBiybX8PQc6OPA0KU+h3Wtb9?=
 =?us-ascii?Q?iBmbj3tDyGs6mhftUTqSZe6t3QTBWxaGvLAcoAlYmH289UwXEojFCs4ZgSZh?=
 =?us-ascii?Q?PqgS3P+buN0a2T81Sw6COCFzoMKZxVSDLQLpW64kzz39wgkSiCrQUmENPhDD?=
 =?us-ascii?Q?74t/qm3SmZkPFJcQQwodxubUXMTM9IIJfFHKG800HAy98TIhHn05UmWrkNEH?=
 =?us-ascii?Q?gquV0qL++4mnae96W9I3jyPQfKDGIlIUlT5Vg5kSpQ5ND/zZDV1EieKYyBvv?=
 =?us-ascii?Q?AtEJhGuYnSdfV601QZyrocMACmGm6Ii83ASc3TSxYFzF44I5LHdgch6v9o3q?=
 =?us-ascii?Q?IFETdqRMiRPeGXDgpgWpNGEiyfzodQh/sQGA2FMfFv7uxi5neADWbhCf1+Ox?=
 =?us-ascii?Q?dRZ1SM/AKekio5QPhwwVOzCRgmVWimqI7IrgTXbqGuqIhBT+wK3xJKGHBRc7?=
 =?us-ascii?Q?MG88VyxOA/2FsxVnxhcxBoAGfWw1RLP8KrzyaanaCCYRzhhZq+u22AJGZsWR?=
 =?us-ascii?Q?uHUhpxoBL+p+Z7/vLGeKU0MBmdjd9RN+xE9UQLorv7dMHDPfu78wfR3EWjvh?=
 =?us-ascii?Q?q3Trds1n7dceXDb7WTry/OsqUDDlFUXlfXBMaPRDo2tHJ79GXD10zewfh1H/?=
 =?us-ascii?Q?f97Adw5NOKh6WVpiL+TF58asSyvg+edorNXXRAbJ3qebNdfkodPDXPnodLMp?=
 =?us-ascii?Q?FeNB0X/W5I7e7O0wiVaYYkpAdTphhlc/QhbDnKK6EuTnhxs6wE4gLvXI7LOq?=
 =?us-ascii?Q?+t0GKlMWdDFuWCvT3p7kGuPPFb9We+GMJLHAl6gPM6tnMhL9+YetuaNJ4qvR?=
 =?us-ascii?Q?5TP0NMzHfzhO/quY9kgiha4aBsKtuWOqxIGSVTfDE5WUG6BptV1J+mlBtfOM?=
 =?us-ascii?Q?J83LAzZA9IslI4q6+tbDAUMtUSX9oN3KIFGBEdRx0HxemgTYpgcJzw9fv0oS?=
 =?us-ascii?Q?fKoRZ/tiUcg7cToAwE8D6ePdryoZJvPJNum4sFAaIHkiUYq11UmqGjxWe6Wc?=
 =?us-ascii?Q?DnxMLX+W93TQF8ZA5G5yHLpZOODu6y59FjSo41IknIjrfGjqqDk91KeNknPS?=
 =?us-ascii?Q?kNHno8X6I9MP16i2SzagXeK25GMlK+SUPrcqzW75nCS7+jhF/pH7nvq4F9Ln?=
 =?us-ascii?Q?HHz2jSoZ7ub1eE6fsCxXd3cUSflbUDYsnQLnyOrFKhr9WvJLEZ73uOpd7Ium?=
 =?us-ascii?Q?Qwm01/5dqF4N9jHA7knJZYxP/4eh9bk2GPmncWede/3pDzQh3h6cp3+ZFHEe?=
 =?us-ascii?Q?hNGsgX+TulNmUsg/E09eX9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461415ae-27f1-4bd5-a8ed-08d9dcade3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 07:16:05.4745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyNto0kz9BRogs+i177ieXpMqJ4cI1HIMBufaBywF3dM8HaSYIaNJWbywsYADZUt5UolA/kA0r8gknY4dBTj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Friday, January 21, 2022 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.co=
m>
Subject: [PATCH V3 1/7] drm/amd/pm: drop unneeded lock protection smu->mute=
x

As all those APIs are already protected either by adev->pm.mutex or smu->me=
ssage_lock.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1db751fba9caabc5ca1314992961d3674212f9b0
--
v1->v2:
  - optimize the "!smu_table->hardcode_pptable" check(Guchun)
  - add the lock protection(adev->pm.mutex) for i2c transfer(Lijo)
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 316 ++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   4 +-
 6 files changed, 34 insertions(+), 299 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 828cb932f6a9..eaaa5b033d46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -55,8 +55,7 @@ static int smu_force_smuclk_levels(struct smu_context *sm=
u,
 				   uint32_t mask);
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
-			   enum amd_pp_task task_id,
-			   bool lock_needed);
+			   enum amd_pp_task task_id);
 static int smu_reset(struct smu_context *smu);  static int smu_set_fan_spe=
ed_pwm(void *handle, u32 speed);  static int smu_set_fan_control_mode(void =
*handle, u32 value); @@ -68,36 +67,22 @@ static int smu_sys_get_pp_feature_=
mask(void *handle,
 				       char *buf)
 {
 	struct smu_context *smu =3D handle;
-	int size =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	size =3D smu_get_pp_feature_mask(smu, buf);
-
-	mutex_unlock(&smu->mutex);
-
-	return size;
+	return smu_get_pp_feature_mask(smu, buf);
 }
=20
 static int smu_sys_set_pp_feature_mask(void *handle,
 				       uint64_t new_mask)
 {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	ret =3D smu_set_pp_feature_mask(smu, new_mask);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_pp_feature_mask(smu, new_mask);
 }
=20
 int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value) @@ -11=
7,16 +102,12 @@ int smu_set_soft_freq_range(struct smu_context *smu,  {
 	int ret =3D 0;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_soft_freq_limited_range)
 		ret =3D smu->ppt_funcs->set_soft_freq_limited_range(smu,
 								  clk_type,
 								  min,
 								  max);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -140,16 +121,12 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	if (!min && !max)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_dpm_ultimate_freq)
 		ret =3D smu->ppt_funcs->get_dpm_ultimate_freq(smu,
 							    clk_type,
 							    min,
 							    max);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -482,7 +459,6 @@ static int smu_sys_get_pp_table(void *handle,  {
 	struct smu_context *smu =3D handle;
 	struct smu_table_context *smu_table =3D &smu->smu_table;
-	uint32_t powerplay_table_size;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -490,18 +466,12 @@ static int smu_sys_get_pp_table(void *handle,
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu_table->hardcode_pptable)
 		*table =3D smu_table->hardcode_pptable;
 	else
 		*table =3D smu_table->power_play_table;
=20
-	powerplay_table_size =3D smu_table->power_play_table_size;
-
-	mutex_unlock(&smu->mutex);
-
-	return powerplay_table_size;
+	return smu_table->power_play_table_size;
 }
=20
 static int smu_sys_set_pp_table(void *handle, @@ -521,12 +491,10 @@ static=
 int smu_sys_set_pp_table(void *handle,
 		return -EIO;
 	}
=20
-	mutex_lock(&smu->mutex);
-	if (!smu_table->hardcode_pptable)
-		smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
 	if (!smu_table->hardcode_pptable) {
-		ret =3D -ENOMEM;
-		goto failed;
+		smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
+		if (!smu_table->hardcode_pptable)
+			return -ENOMEM;
 	}
=20
 	memcpy(smu_table->hardcode_pptable, buf, size); @@ -545,8 +513,6 @@ stati=
c int smu_sys_set_pp_table(void *handle,
=20
 	smu->uploading_custom_pp_table =3D false;
=20
-failed:
-	mutex_unlock(&smu->mutex);
 	return ret;
 }
=20
@@ -633,7 +599,6 @@ static int smu_early_init(void *handle)
 	smu->adev =3D adev;
 	smu->pm_enabled =3D !!amdgpu_dpm;
 	smu->is_apu =3D false;
-	mutex_init(&smu->mutex);
 	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support =3D false; @@ -736,8 +701,7 @@ static int =
smu_late_init(void *handle)
=20
 	smu_handle_task(smu,
 			smu->smu_dpm.dpm_level,
-			AMD_PP_TASK_COMPLETE_INIT,
-			false);
+			AMD_PP_TASK_COMPLETE_INIT);
=20
 	smu_restore_dpm_user_profile(smu);
=20
@@ -1013,12 +977,8 @@ static void smu_interrupt_work_fn(struct work_struct =
*work)
 	struct smu_context *smu =3D container_of(work, struct smu_context,
 					       interrupt_work);
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->interrupt_work)
 		smu->ppt_funcs->interrupt_work(smu);
-
-	mutex_unlock(&smu->mutex);
 }
=20
 static int smu_sw_init(void *handle)
@@ -1632,8 +1592,6 @@ static int smu_display_configuration_change(void *han=
dle,
 	if (!display_config)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
=20
@@ -1642,8 +1600,6 @@ static int smu_display_configuration_change(void *han=
dle,
 			num_of_active_display++;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
=20
@@ -1766,22 +1722,18 @@ static int smu_adjust_power_state_dynamic(struct sm=
u_context *smu,
=20
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
-			   enum amd_pp_task task_id,
-			   bool lock_needed)
+			   enum amd_pp_task task_id)
 {
 	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
-
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
 		ret =3D smu_pre_display_config_changed(smu);
 		if (ret)
-			goto out;
+			return ret;
 		ret =3D smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
@@ -1792,10 +1744,6 @@ static int smu_handle_task(struct smu_context *smu,
 		break;
 	}
=20
-out:
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -1806,7 +1754,7 @@ static int smu_handle_dpm_task(void *handle,
 	struct smu_context *smu =3D handle;
 	struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
=20
-	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id);
=20
 }
=20
@@ -1825,8 +1773,6 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	if (!en) {
 		smu->workload_mask &=3D ~(1 << smu->workload_prority[type]);
 		index =3D fls(smu->workload_mask);
@@ -1843,8 +1789,6 @@ static int smu_switch_power_profile(void *handle,
 		smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, &workload, 0);
=20
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
=20
@@ -1852,7 +1796,6 @@ static enum amd_dpm_forced_level smu_get_performance_=
level(void *handle)  {
 	struct smu_context *smu =3D handle;
 	struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-	enum amd_dpm_forced_level level;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1860,11 +1803,7 @@ static enum amd_dpm_forced_level smu_get_performance=
_level(void *handle)
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
=20
-	mutex_lock(&(smu->mutex));
-	level =3D smu_dpm_ctx->dpm_level;
-	mutex_unlock(&(smu->mutex));
-
-	return level;
+	return smu_dpm_ctx->dpm_level;
 }
=20
 static int smu_force_performance_level(void *handle, @@ -1880,19 +1819,12 =
@@ static int smu_force_performance_level(void *handle,
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu_enable_umd_pstate(smu, &level);
-	if (ret) {
-		mutex_unlock(&smu->mutex);
+	if (ret)
 		return ret;
-	}
=20
 	ret =3D smu_handle_task(smu, level,
-			      AMD_PP_TASK_READJUST_POWER_STATE,
-			      false);
-
-	mutex_unlock(&smu->mutex);
+			      AMD_PP_TASK_READJUST_POWER_STATE);
=20
 	/* reset user dpm clock state */
 	if (!ret && smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) { @@=
 -1906,16 +1838,11 @@ static int smu_force_performance_level(void *handle, =
 static int smu_set_display_count(void *handle, uint32_t count)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-	ret =3D smu_init_display_count(smu, count);
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_init_display_count(smu, count);
 }
=20
 static int smu_force_smuclk_levels(struct smu_context *smu, @@ -1933,8 +18=
60,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret =3D smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE=
)) { @@ -1943,8 +1868,6 @@ static int smu_force_smuclk_levels(struct smu_co=
ntext *smu,
 		}
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2003,14 +1926,10 @@ static int smu_set_mp1_state(void *handle,
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs &&
 	    smu->ppt_funcs->set_mp1_state)
 		ret =3D smu->ppt_funcs->set_mp1_state(smu, mp1_state);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2026,14 +1945,10 @@ static int smu_set_df_cstate(void *handle,
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
 		return 0;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->set_df_cstate(smu, state);
 	if (ret)
 		dev_err(smu->adev->dev, "[SetDfCstate] failed!\n");
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2047,38 +1962,25 @@ int smu_allow_xgmi_power_down(struct smu_context *s=
mu, bool en)
 	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
 		return 0;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->allow_xgmi_power_down(smu, en);
 	if (ret)
 		dev_err(smu->adev->dev, "[AllowXgmiPowerDown] failed!\n");
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
 int smu_write_watermarks_table(struct smu_context *smu)  {
-	int ret =3D 0;
-
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	ret =3D smu_set_watermarks_table(smu, NULL);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_watermarks_table(smu, NULL);
 }
=20
 static int smu_set_watermarks_for_clock_ranges(void *handle,
 					       struct pp_smu_wm_range_sets *clock_ranges)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2086,13 +1988,7 @@ static int smu_set_watermarks_for_clock_ranges(void =
*handle,
 	if (smu->disable_watermark)
 		return 0;
=20
-	mutex_lock(&smu->mutex);
-
-	ret =3D smu_set_watermarks_table(smu, clock_ranges);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_watermarks_table(smu, clock_ranges);
 }
=20
 int smu_set_ac_dc(struct smu_context *smu) @@ -2106,14 +2002,12 @@ int smu=
_set_ac_dc(struct smu_context *smu)
 	if (smu->dc_controlled_by_gpio)
 		return 0;
=20
-	mutex_lock(&smu->mutex);
 	ret =3D smu_set_power_source(smu,
 				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
 				   SMU_POWER_SOURCE_DC);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
 		       smu->adev->pm.ac_power ? "AC" : "DC");
-	mutex_unlock(&smu->mutex);
=20
 	return ret;
 }
@@ -2200,13 +2094,9 @@ static int smu_set_gfx_cgpg(struct smu_context *smu,=
 bool enabled)  {
 	int ret =3D 0;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_gfx_cgpg)
 		ret =3D smu->ppt_funcs->set_gfx_cgpg(smu, enabled);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2224,8 +2114,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32=
_t speed)
 	if (speed =3D=3D U32_MAX)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)=
) {
 		smu->user_dpm_profile.flags |=3D SMU_CUSTOM_FAN_SPEED_RPM; @@ -2236,8 +2=
124,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 		smu->user_dpm_profile.fan_speed_pwm =3D 0;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2293,8 +2179,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	}
=20
-	mutex_lock(&smu->mutex);
-
 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret =3D smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_lev=
el); @@ -2328,8 +2212,6 @@ int smu_get_power_limit(void *handle,
 		}
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2342,21 +2224,16 @@ static int smu_set_power_limit(void *handle, uint32=
_t limit)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	limit &=3D (1<<24)-1;
 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
-		if (smu->ppt_funcs->set_power_limit) {
-			ret =3D smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-			goto out;
-		}
+		if (smu->ppt_funcs->set_power_limit)
+			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
=20
 	if (limit > smu->max_power_limit) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is over the max allowed %d\n",
 			limit, smu->max_power_limit);
-		ret =3D -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
=20
 	if (!limit)
@@ -2368,9 +2245,6 @@ static int smu_set_power_limit(void *handle, uint32_t=
 limit)
 			smu->user_dpm_profile.power_limit =3D limit;
 	}
=20
-out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2381,13 +2255,9 @@ static int smu_print_smuclk_levels(struct smu_contex=
t *smu, enum smu_clk_type cl
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->print_clk_levels)
 		ret =3D smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2444,14 +2314,10 @@ static int smu_od_edit_dpm_table(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret =3D smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2475,8 +2341,6 @@ static int smu_read_sensor(void *handle,
 	size_val =3D *size_arg;
 	size =3D &size_val;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->read_sensor)
 		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
 			goto unlock;
@@ -2517,8 +2381,6 @@ static int smu_read_sensor(void *handle,
 	}
=20
 unlock:
-	mutex_unlock(&smu->mutex);
-
 	// assign uint32_t to int
 	*size_arg =3D size_val;
=20
@@ -2528,7 +2390,6 @@ static int smu_read_sensor(void *handle,  static int =
smu_get_power_profile_mode(void *handle, char *buf)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->get_power_profile_mode)
@@ -2536,13 +2397,7 @@ static int smu_get_power_profile_mode(void *handle, =
char *buf)
 	if (!buf)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
-	ret =3D smu->ppt_funcs->get_power_profile_mode(smu, buf);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu->ppt_funcs->get_power_profile_mode(smu, buf);
 }
=20
 static int smu_set_power_profile_mode(void *handle, @@ -2550,19 +2405,12 @=
@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	smu_bump_power_profile_mode(smu, param, param_size);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_bump_power_profile_mode(smu, param, param_size);
 }
=20
=20
@@ -2579,12 +2427,8 @@ static int smu_get_fan_control_mode(void *handle, u3=
2 *fan_mode)
 	if (!fan_mode)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	*fan_mode =3D smu->ppt_funcs->get_fan_control_mode(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
=20
@@ -2602,8 +2446,6 @@ static int smu_set_fan_control_mode(void *handle, u32=
 value)
 	if (value =3D=3D U32_MAX)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->set_fan_control_mode(smu, value);
 	if (ret)
 		goto out;
@@ -2620,8 +2462,6 @@ static int smu_set_fan_control_mode(void *handle, u32=
 value)
 	}
=20
 out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2639,12 +2479,8 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *=
speed)
 	if (!speed)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2662,8 +2498,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 sp=
eed)
 	if (speed =3D=3D U32_MAX)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
 	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)=
) {
 		smu->user_dpm_profile.flags |=3D SMU_CUSTOM_FAN_SPEED_PWM; @@ -2674,8 +2=
508,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 		smu->user_dpm_profile.fan_speed_rpm =3D 0;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2693,30 +2525,19 @@ static int smu_get_fan_speed_rpm(void *handle, uint=
32_t *speed)
 	if (!speed)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
 static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	ret =3D smu_set_min_dcef_deep_sleep(smu, clk);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_min_dcef_deep_sleep(smu, clk);
 }
=20
 static int smu_get_clock_by_type_with_latency(void *handle, @@ -2730,8 +25=
51,6 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
 		switch (type) {
 		case amd_pp_sys_clock:
@@ -2748,15 +2567,12 @@ static int smu_get_clock_by_type_with_latency(void =
*handle,
 			break;
 		default:
 			dev_err(smu->adev->dev, "Invalid clock type!\n");
-			mutex_unlock(&smu->mutex);
 			return -EINVAL;
 		}
=20
 		ret =3D smu->ppt_funcs->get_clock_by_type_with_latency(smu, clk_type, cl=
ocks);
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2769,13 +2585,9 @@ static int smu_display_clock_voltage_request(void *h=
andle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->display_clock_voltage_request)
 		ret =3D smu->ppt_funcs->display_clock_voltage_request(smu, clock_req);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2789,13 +2601,9 @@ static int smu_display_disable_memory_clock_switch(v=
oid *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->display_disable_memory_clock_switch)
 		ret =3D smu->ppt_funcs->display_disable_memory_clock_switch(smu, disable=
_memory_clock_switch);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2808,13 +2616,9 @@ static int smu_set_xgmi_pstate(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_xgmi_pstate)
 		ret =3D smu->ppt_funcs->set_xgmi_pstate(smu, pstate);
=20
-	mutex_unlock(&smu->mutex);
-
 	if(ret)
 		dev_err(smu->adev->dev, "Failed to set XGMI pstate!\n");
=20
@@ -2824,21 +2628,16 @@ static int smu_set_xgmi_pstate(void *handle,  stati=
c int smu_get_baco_capability(void *handle, bool *cap)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	*cap =3D false;
=20
 	if (!smu->pm_enabled)
 		return 0;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
 		*cap =3D smu->ppt_funcs->baco_is_support(smu);
=20
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return 0;
 }
=20
 static int smu_baco_set_state(void *handle, int state) @@ -2850,20 +2649,1=
1 @@ static int smu_baco_set_state(void *handle, int state)
 		return -EOPNOTSUPP;
=20
 	if (state =3D=3D 0) {
-		mutex_lock(&smu->mutex);
-
 		if (smu->ppt_funcs->baco_exit)
 			ret =3D smu->ppt_funcs->baco_exit(smu);
-
-		mutex_unlock(&smu->mutex);
 	} else if (state =3D=3D 1) {
-		mutex_lock(&smu->mutex);
-
 		if (smu->ppt_funcs->baco_enter)
 			ret =3D smu->ppt_funcs->baco_enter(smu);
-
-		mutex_unlock(&smu->mutex);
-
 	} else {
 		return -EINVAL;
 	}
@@ -2882,13 +2672,9 @@ bool smu_mode1_reset_is_support(struct smu_context *=
smu)
 	if (!smu->pm_enabled)
 		return false;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
 		ret =3D smu->ppt_funcs->mode1_reset_is_support(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2899,13 +2685,9 @@ bool smu_mode2_reset_is_support(struct smu_context *=
smu)
 	if (!smu->pm_enabled)
 		return false;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
 		ret =3D smu->ppt_funcs->mode2_reset_is_support(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2916,13 +2698,9 @@ int smu_mode1_reset(struct smu_context *smu)
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->mode1_reset)
 		ret =3D smu->ppt_funcs->mode1_reset(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2934,13 +2712,9 @@ static int smu_mode2_reset(void *handle)
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->mode2_reset)
 		ret =3D smu->ppt_funcs->mode2_reset(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	if (ret)
 		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
=20
@@ -2956,13 +2730,9 @@ static int smu_get_max_sustainable_clocks_by_dc(void=
 *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
 		ret =3D smu->ppt_funcs->get_max_sustainable_clocks_by_dc(smu, max_clocks=
);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2976,13 +2746,9 @@ static int smu_get_uclk_dpm_states(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_uclk_dpm_states)
 		ret =3D smu->ppt_funcs->get_uclk_dpm_states(smu, clock_values_in_khz, nu=
m_states);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2994,13 +2760,9 @@ static enum amd_pm_state_type smu_get_current_power_=
state(void *handle)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_current_power_state)
 		pm_state =3D smu->ppt_funcs->get_current_power_state(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return pm_state;
 }
=20
@@ -3013,20 +2775,15 @@ static int smu_get_dpm_clock_table(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_dpm_clock_table)
 		ret =3D smu->ppt_funcs->get_dpm_clock_table(smu, clock_table);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
 static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)  {
 	struct smu_context *smu =3D handle;
-	ssize_t size;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -3034,13 +2791,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle,=
 void **table)
 	if (!smu->ppt_funcs->get_gpu_metrics)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
-	size =3D smu->ppt_funcs->get_gpu_metrics(smu, table);
-
-	mutex_unlock(&smu->mutex);
-
-	return size;
+	return smu->ppt_funcs->get_gpu_metrics(smu, table);
 }
=20
 static int smu_enable_mgpu_fan_boost(void *handle) @@ -3051,13 +2802,9 @@ =
static int smu_enable_mgpu_fan_boost(void *handle)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->enable_mgpu_fan_boost)
 		ret =3D smu->ppt_funcs->enable_mgpu_fan_boost(smu);
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -3067,10 +2814,8 @@ static int smu_gfx_state_change_set(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->gfx_state_change_set)
 		ret =3D smu->ppt_funcs->gfx_state_change_set(smu, state);
-	mutex_unlock(&smu->mutex);
=20
 	return ret;
 }
@@ -3079,10 +2824,8 @@ int smu_handle_passthrough_sbr(struct smu_context *s=
mu, bool enable)  {
 	int ret =3D 0;
=20
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
 		ret =3D smu->ppt_funcs->smu_handle_passthrough_sbr(smu, enable);
-	mutex_unlock(&smu->mutex);
=20
 	return ret;
 }
@@ -3091,11 +2834,9 @@ int smu_get_ecc_info(struct smu_context *smu, void *=
umc_ecc)  {
 	int ret =3D -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs &&
 		smu->ppt_funcs->get_ecc_info)
 		ret =3D smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
-	mutex_unlock(&smu->mutex);
=20
 	return ret;
=20
@@ -3112,12 +2853,10 @@ static int smu_get_prv_buffer_details(void *handle,=
 void **addr, size_t *size)
=20
 	*addr =3D NULL;
 	*size =3D 0;
-	mutex_lock(&smu->mutex);
 	if (memory_pool->bo) {
 		*addr =3D memory_pool->cpu_addr;
 		*size =3D memory_pool->size;
 	}
-	mutex_unlock(&smu->mutex);
=20
 	return 0;
 }
@@ -3181,11 +2920,8 @@ int smu_wait_for_event(struct smu_context *smu, enum=
 smu_event_type event,  {
 	int ret =3D -EINVAL;
=20
-	if (smu->ppt_funcs->wait_for_event) {
-		mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs->wait_for_event)
 		ret =3D smu->ppt_funcs->wait_for_event(smu, event, event_arg);
-		mutex_unlock(&smu->mutex);
-	}
=20
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 3fdab6a44901..00760f3c6da5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -488,7 +488,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
 	struct mutex			message_lock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d3963bfe5c89..1b265b8c7996 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2118,9 +2118,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_=
adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
+	mutex_lock(&adev->pm.mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
+	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 37e11716e919..5cdf88f3bb6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2826,9 +2826,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_ad=
ap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
+	mutex_lock(&adev->pm.mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
+	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c29353e05fd2..5c0ad4dd6543 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3497,9 +3497,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter=
 *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
+	mutex_lock(&adev->pm.mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
+	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ac8ba5e0e697..3085a07e70d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1521,9 +1521,9 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c=
_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
+	mutex_lock(&adev->pm.mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
+	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
=20
--
2.29.0
