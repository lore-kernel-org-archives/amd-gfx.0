Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 13:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171B210E1E3;
	Thu, 20 Jan 2022 13:37:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2992B10E1BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 13:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maVNBDI9Fl5ahTL6TGVz2raqafETAW+/lcdJKp0TTy1YRerKXIf/ctyc+IJc/xHXcjmS6d5cNVYBe3mFwdDJNh14JBr4cAZ9jbnwFJwX8hz8cUTjY6osT00i9E5jvQUPRSwABPOCk1/s1gLYbS38FYG76/tBAROwLDXfSQKh4uDqpiKO2ko5iUQ3q8MrTEzyjlYuKjYiBKuz8niDMeiKNyUexvj/OHBYYnhYLBWHotNKDekeLSwmHusMWlAkQ89XdIQ+B7FuV6CueK4QRcob9pva07yz+MRL+Trr8/8oIYBiwlqStnVu+DpL7NmIsCwiloSbXG2Uyd+jAamYgIhRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ea4RhR5ffk5sd50XeZDX+2H4q3ldFDroJ7EwclVZ0gQ=;
 b=c8MTwto+8x+NWweKjM87DP1whqoMoOQSqU9Fwm15F/OdKBC0J6Qq4nOfTxCLBK2Te/GPdt6Tq49F9o6UYZG43tYAUqTnnBoH1LN9IQGNJUEStYj2Tt2hzuFp3Th58YuLlZLuFn9L8wxhACMv1YT0V5sX9TG2VFKfzhC+Tm7jQ9cdGtPkrJjDALluF9PAq30OC9zhze4wgbjnIwgIAWNw+8eAK1E3M84jmiR3y/71xmlNCrJ05Ig1HJMy6Ez1srqg3sZsCOks2HK25l3fg2Wn6omykt0eVm3Y2I2R1CX0AWxsgIXW9K2omVHjfXcJcM/NZpc9ZlBFSzkTE3wJTDflSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea4RhR5ffk5sd50XeZDX+2H4q3ldFDroJ7EwclVZ0gQ=;
 b=kwEK9cMK5orziK+v0cJmV3o02rXCfwGocWU0Fz0HbjEGNQTmUvf9GHNqHbVEktKQL8WOyjh5L/LSRQ/oA6wCySKvy7FMWqGBaqa09AfHxFkTfTo9XVVdvQgVm9QGdtggG/3wMJLAFMiDGlygwdSyKOiSyOswnQpmwd25pyqQfZ8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Thu, 20 Jan 2022 13:37:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 13:37:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/7] drm/amd/pm: drop unneeded lock protection
 smu->mutex
Thread-Topic: [PATCH V2 1/7] drm/amd/pm: drop unneeded lock protection
 smu->mutex
Thread-Index: AQHYC2T9lq0PMcsDc06NFBpIX9dCdaxr7lcw
Date: Thu, 20 Jan 2022 13:37:39 +0000
Message-ID: <DM5PR12MB2469529EEF35A5313E3DD3D9F15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
In-Reply-To: <20220117054151.124838-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T13:37:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5c4cdd9a-04ad-4f7c-a2c3-95df6445abb4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-20T13:37:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 43b94e60-54c8-4ff4-b5da-0541821b0d5b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cebd864-9ce7-4b5a-a642-08d9dc1a0722
x-ms-traffictypediagnostic: DM6PR12MB3753:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3753967B2C42A2B38741204EF15A9@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkMdNvPPYQuzN9z1tqxUyqyxouh0EQ2stUVu4n6n5goiuajgNui01jq1UHCowc2Jb24dQBEyTf3i7YdnfBMgfPTsIBUQvzYwm9eK160kxYsrD27qXAPypMj951v5CMB0CT/OKQX9Rv+owX4qNPa9jm0QFdWaxQTT6IY7qSbs+hKOlDV07WlBxzbzIQmLxSBiuf+nFt+M+KKXoD1hjld+FScFqo9GBe4Is6ZTwos5OOPLRtL29tYysWqGyuEFb111VphTmaDUwfShEAlgov1nQa5SqTjHpkG7GaysY7vPcRF3dwXiacBjjOysnAs7VWjWZnN17LIua2Uzot1xP9jlG/LB2ae/7JMP36U+io9DWadQK+46E1vNGjruQBmOWlZkzTqmg8Xw0TsPsQXHf3dQCSfthhlU1rr9RICQN/hNDAd5zeosa+xJ4VNzTRLFUQpaV1EeAWkbJvXPyVADSPd6yWA6drX5qSwByky6hUhaw0F7VnpOz/aJO1GGWgeBRanT6kKvTezOuCcvuIy7be4v14E77WHU8dzY520Q/MTXw8IqcBE1viHwY2yEMEAiZc0w6a1X8o2ANkYOkVwk49lqxdXirNTOLWmkoq+tIFB0Mbrwt0HsjszNE2r4sjcwQqE3okbp0F+fb/ZL62JuM+x4mLIwCf1D+7XRZbZ7XQyCEE/kHtEcN/RskD9Tq0M/+/hETzE66iLy3j5/EkS3boFCjfBompHMhQ05zpeeCWwa3XQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(7696005)(508600001)(2906002)(66946007)(30864003)(66476007)(66446008)(66556008)(64756008)(86362001)(52536014)(186003)(76116006)(5660300002)(8936002)(38100700002)(122000001)(9686003)(53546011)(4326008)(33656002)(8676002)(110136005)(54906003)(71200400001)(38070700005)(83380400001)(316002)(55016003)(6506007)(559001)(579004)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgcDt6mNzXPUJcbhaoJ58GE8a4WjFaw9AXtpwIIcLXts657ekdQrDpQPqWPD?=
 =?us-ascii?Q?wNlrTq+Fntl6wc/I28Ml9Iq3wb3sG3+QBPAh4j4YdT/h4BZn03st7Y8zjD/y?=
 =?us-ascii?Q?rJijVSJKNfNyintoTS3aeLgR8iH1X3z4jB57LNjevLUxLLrsSkGw0GX97yP1?=
 =?us-ascii?Q?4eSb4Cqg2JQaioeWopIHavWvodmGUaezfdNIvf0GIZ3Thh3om1lwCvo7GMec?=
 =?us-ascii?Q?JzS+9O1epP3fd9+1kWOIEb1HoDeAniBhWbXlsGDnU0lucHBDQm7+Kc35F8eg?=
 =?us-ascii?Q?ZJP5aQ4DqYMaAGMeVIS8okfmMiYcAu8IxBSi6Qel+0ezycE8lq74zLdc0ucF?=
 =?us-ascii?Q?g84cAikgywZqAJuff22m9CHWfY3pzXiCuHjwmJ06FkqL6xI/wxwp/SGEZ80A?=
 =?us-ascii?Q?ynPlL5Hh5qyciFuxHt5LTE/kOGgn9x0i7Nf58j7Ue5PwocVs62WZwgAAWdDX?=
 =?us-ascii?Q?QKBM6NbEC0NaL/dYJtA/KbYwePtGYq6czdz7FVM3EiS5m0TuFu8sAPCCRqVe?=
 =?us-ascii?Q?WGVHO0k7vZiwk9RamUJgqOj8jiP2CDu39Dr2sp0ROHUOk9S3Bpoqu3h1g4Qc?=
 =?us-ascii?Q?APlmqE9rPJf7Ty+zkoLE7pu7JIb/O4QiRaqW0plEAeMudRVFvupmnTVZoy7a?=
 =?us-ascii?Q?BJDNRztUTvYPwP8Bd9gBNm+kS6ezFPL1Z8vp52Nas+Cls+QAmfF+KNf4/3mJ?=
 =?us-ascii?Q?f7zadwySpXVBJqvCRP6NBBe3T1OSwe+0IC4hxRAtP5nWF9IOYCeE3O9vdHKX?=
 =?us-ascii?Q?RIrW965KORb9vha9I5xikfGhVWdNvllIt406B5rM5fjqKI3eGI9nDX5te9N6?=
 =?us-ascii?Q?BfFBkHFkIkldQipWyYQSgwLjr4K2f29RWvMdnJKHk1xUx/LmNfKSVyidAkJ/?=
 =?us-ascii?Q?ESgoc7/a6exb4yNsaMovi67u65M3jPCUpZCemGwxBuk4zvUwnKAAklIrEJQV?=
 =?us-ascii?Q?6lBbYZxPTs4RpWQ3i7ao/O5N7p2JLg19DYCdK3NecyAHlQthZuuE1z6jnFeB?=
 =?us-ascii?Q?uYoFET6WAXfvoQgwownXW5LmWVnxSXev9DPSEKMr9Di6NWtVt1GHjT1UTngd?=
 =?us-ascii?Q?tbZWPLhy0HidrxVYtQbOw9TjsSEk1VqUO2sBjuhhUeHPr+EhpD1tLBg2ZBPk?=
 =?us-ascii?Q?qrHL1522eIyW1vU7MW3DkVLOkhS50x+oPFuORIizNwoRzg3UJl4qFrqvYcKH?=
 =?us-ascii?Q?P2k7yB7Wcxva0PB48r/onR+6qmUq/79Y2bO78F0+CnAPZH6p5kXRS1Wcj4dA?=
 =?us-ascii?Q?RfXxmh8IdLq/BNXrs1e029iFbEGyrrw0XExl7C8jnZLysM432/3LTcDlk3n8?=
 =?us-ascii?Q?mj8kbmFDPRk0qJ+4fJ5n8pZ28CXW9luYiGkd4SoEr2T8jp+UPxMYki/LxTJ8?=
 =?us-ascii?Q?uXhi+IJzQYCLJy/cYtcbx8mGkD63U5h8fB4FJcTIfvHYHiu8vO9bdBnasZlG?=
 =?us-ascii?Q?528XIddtX3ahb/Tqq1DTDAeqaLq/3eWd9LNQvj5JNTt7coHWSSgGIE1960GW?=
 =?us-ascii?Q?peI8femzPbD62T2K4z7In2h5PaYP2hjr8yx9XPkQuTMOLwgxcY4ZkpkRMVvj?=
 =?us-ascii?Q?xWp//hS82e1UC4i0EyKsdmNT2KeSu46ASRM/XgWXsg3Zjfst24y/FmWLW4aL?=
 =?us-ascii?Q?U6wOF7PZnwtiOgtJMlQPw44=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cebd864-9ce7-4b5a-a642-08d9dc1a0722
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 13:37:39.5513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqd6/DK7ya81S15oFDDlWMYG7DSwIaYKKv4PJ/PYAwPGTKgWGPmkPwWmyfU3BiKVZ2zT1G7ei+9IC8HtacLlNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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

	if (!smu_table->hardcode_pptable)
 		smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
-	if (!smu_table->hardcode_pptable) {
-		ret =3D -ENOMEM;
-		goto failed;
-	}
+	if (!smu_table->hardcode_pptable)
+		return -ENOMEM;

I guess it's better to put the second check of hardcode_pptable into first =
if condition section like:
if (!smu_table->hardcode_pptable) {
	smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
	if (!smu_table->hardcode_pptable)
		return -ENOMEM;
}


Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Monday, January 17, 2022 1:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.co=
m>
Subject: [PATCH V2 1/7] drm/amd/pm: drop unneeded lock protection smu->mute=
x

As all those APIs are already protected either by adev->pm.mutex or smu->me=
ssage_lock.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1db751fba9caabc5ca1314992961d3674212f9b0
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 315 ++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   2 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   2 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   2 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   2 -
 6 files changed, 25 insertions(+), 299 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 828cb932f6a9..411f03eb4523 100644
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
 static int smu_sys_set_pp_table(void *handle, @@ -521,13 +491,10 @@ static=
 int smu_sys_set_pp_table(void *handle,
 		return -EIO;
 	}
=20
-	mutex_lock(&smu->mutex);
 	if (!smu_table->hardcode_pptable)
 		smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
-	if (!smu_table->hardcode_pptable) {
-		ret =3D -ENOMEM;
-		goto failed;
-	}
+	if (!smu_table->hardcode_pptable)
+		return -ENOMEM;
=20
 	memcpy(smu_table->hardcode_pptable, buf, size);
 	smu_table->power_play_table =3D smu_table->hardcode_pptable; @@ -545,8 +5=
12,6 @@ static int smu_sys_set_pp_table(void *handle,
=20
 	smu->uploading_custom_pp_table =3D false;
=20
-failed:
-	mutex_unlock(&smu->mutex);
 	return ret;
 }
=20
@@ -633,7 +598,6 @@ static int smu_early_init(void *handle)
 	smu->adev =3D adev;
 	smu->pm_enabled =3D !!amdgpu_dpm;
 	smu->is_apu =3D false;
-	mutex_init(&smu->mutex);
 	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support =3D false; @@ -736,8 +700,7 @@ static int =
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
@@ -1013,12 +976,8 @@ static void smu_interrupt_work_fn(struct work_struct =
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
@@ -1632,8 +1591,6 @@ static int smu_display_configuration_change(void *han=
dle,
 	if (!display_config)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
=20
@@ -1642,8 +1599,6 @@ static int smu_display_configuration_change(void *han=
dle,
 			num_of_active_display++;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
=20
@@ -1766,22 +1721,18 @@ static int smu_adjust_power_state_dynamic(struct sm=
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
@@ -1792,10 +1743,6 @@ static int smu_handle_task(struct smu_context *smu,
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
@@ -1806,7 +1753,7 @@ static int smu_handle_dpm_task(void *handle,
 	struct smu_context *smu =3D handle;
 	struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
=20
-	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id);
=20
 }
=20
@@ -1825,8 +1772,6 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	if (!en) {
 		smu->workload_mask &=3D ~(1 << smu->workload_prority[type]);
 		index =3D fls(smu->workload_mask);
@@ -1843,8 +1788,6 @@ static int smu_switch_power_profile(void *handle,
 		smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, &workload, 0);
=20
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
=20
@@ -1852,7 +1795,6 @@ static enum amd_dpm_forced_level smu_get_performance_=
level(void *handle)  {
 	struct smu_context *smu =3D handle;
 	struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-	enum amd_dpm_forced_level level;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1860,11 +1802,7 @@ static enum amd_dpm_forced_level smu_get_performance=
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
 static int smu_force_performance_level(void *handle, @@ -1880,19 +1818,12 =
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
 -1906,16 +1837,11 @@ static int smu_force_performance_level(void *handle, =
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
59,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret =3D smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE=
)) { @@ -1943,8 +1867,6 @@ static int smu_force_smuclk_levels(struct smu_co=
ntext *smu,
 		}
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2003,14 +1925,10 @@ static int smu_set_mp1_state(void *handle,
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
@@ -2026,14 +1944,10 @@ static int smu_set_df_cstate(void *handle,
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
@@ -2047,38 +1961,25 @@ int smu_allow_xgmi_power_down(struct smu_context *s=
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
@@ -2086,13 +1987,7 @@ static int smu_set_watermarks_for_clock_ranges(void =
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
 int smu_set_ac_dc(struct smu_context *smu) @@ -2106,14 +2001,12 @@ int smu=
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
@@ -2200,13 +2093,9 @@ static int smu_set_gfx_cgpg(struct smu_context *smu,=
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
@@ -2224,8 +2113,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32=
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
123,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 		smu->user_dpm_profile.fan_speed_pwm =3D 0;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2293,8 +2178,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	}
=20
-	mutex_lock(&smu->mutex);
-
 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret =3D smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_lev=
el); @@ -2328,8 +2211,6 @@ int smu_get_power_limit(void *handle,
 		}
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2342,21 +2223,16 @@ static int smu_set_power_limit(void *handle, uint32=
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
@@ -2368,9 +2244,6 @@ static int smu_set_power_limit(void *handle, uint32_t=
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
@@ -2381,13 +2254,9 @@ static int smu_print_smuclk_levels(struct smu_contex=
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
@@ -2444,14 +2313,10 @@ static int smu_od_edit_dpm_table(void *handle,
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
@@ -2475,8 +2340,6 @@ static int smu_read_sensor(void *handle,
 	size_val =3D *size_arg;
 	size =3D &size_val;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->read_sensor)
 		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
 			goto unlock;
@@ -2517,8 +2380,6 @@ static int smu_read_sensor(void *handle,
 	}
=20
 unlock:
-	mutex_unlock(&smu->mutex);
-
 	// assign uint32_t to int
 	*size_arg =3D size_val;
=20
@@ -2528,7 +2389,6 @@ static int smu_read_sensor(void *handle,  static int =
smu_get_power_profile_mode(void *handle, char *buf)  {
 	struct smu_context *smu =3D handle;
-	int ret =3D 0;
=20
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->get_power_profile_mode)
@@ -2536,13 +2396,7 @@ static int smu_get_power_profile_mode(void *handle, =
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
 static int smu_set_power_profile_mode(void *handle, @@ -2550,19 +2404,12 @=
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
@@ -2579,12 +2426,8 @@ static int smu_get_fan_control_mode(void *handle, u3=
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
@@ -2602,8 +2445,6 @@ static int smu_set_fan_control_mode(void *handle, u32=
 value)
 	if (value =3D=3D U32_MAX)
 		return -EINVAL;
=20
-	mutex_lock(&smu->mutex);
-
 	ret =3D smu->ppt_funcs->set_fan_control_mode(smu, value);
 	if (ret)
 		goto out;
@@ -2620,8 +2461,6 @@ static int smu_set_fan_control_mode(void *handle, u32=
 value)
 	}
=20
 out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2639,12 +2478,8 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *=
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
@@ -2662,8 +2497,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 sp=
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
507,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 		smu->user_dpm_profile.fan_speed_rpm =3D 0;
 	}
=20
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
=20
@@ -2693,30 +2524,19 @@ static int smu_get_fan_speed_rpm(void *handle, uint=
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
50,6 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
=20
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
 		switch (type) {
 		case amd_pp_sys_clock:
@@ -2748,15 +2566,12 @@ static int smu_get_clock_by_type_with_latency(void =
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
@@ -2769,13 +2584,9 @@ static int smu_display_clock_voltage_request(void *h=
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
@@ -2789,13 +2600,9 @@ static int smu_display_disable_memory_clock_switch(v=
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
@@ -2808,13 +2615,9 @@ static int smu_set_xgmi_pstate(void *handle,
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
@@ -2824,21 +2627,16 @@ static int smu_set_xgmi_pstate(void *handle,  stati=
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
 static int smu_baco_set_state(void *handle, int state) @@ -2850,20 +2648,1=
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
@@ -2882,13 +2671,9 @@ bool smu_mode1_reset_is_support(struct smu_context *=
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
@@ -2899,13 +2684,9 @@ bool smu_mode2_reset_is_support(struct smu_context *=
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
@@ -2916,13 +2697,9 @@ int smu_mode1_reset(struct smu_context *smu)
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
@@ -2934,13 +2711,9 @@ static int smu_mode2_reset(void *handle)
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
@@ -2956,13 +2729,9 @@ static int smu_get_max_sustainable_clocks_by_dc(void=
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
@@ -2976,13 +2745,9 @@ static int smu_get_uclk_dpm_states(void *handle,
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
@@ -2994,13 +2759,9 @@ static enum amd_pm_state_type smu_get_current_power_=
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
@@ -3013,20 +2774,15 @@ static int smu_get_dpm_clock_table(void *handle,
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
@@ -3034,13 +2790,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle,=
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
 static int smu_enable_mgpu_fan_boost(void *handle) @@ -3051,13 +2801,9 @@ =
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
@@ -3067,10 +2813,8 @@ static int smu_gfx_state_change_set(void *handle,
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
@@ -3079,10 +2823,8 @@ int smu_handle_passthrough_sbr(struct smu_context *s=
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
@@ -3091,11 +2833,9 @@ int smu_get_ecc_info(struct smu_context *smu, void *=
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
@@ -3112,12 +2852,10 @@ static int smu_get_prv_buffer_details(void *handle,=
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
@@ -3181,11 +2919,8 @@ int smu_wait_for_event(struct smu_context *smu, enum=
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
index d3963bfe5c89..addb0472d040 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2118,9 +2118,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_=
adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 37e11716e919..fe17b3c1ece7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2826,9 +2826,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_ad=
ap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9766870987db..93caaf45a2db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3483,9 +3483,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter=
 *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ac8ba5e0e697..2546f79c8511 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1521,9 +1521,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c=
_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
=20
--
2.29.0
