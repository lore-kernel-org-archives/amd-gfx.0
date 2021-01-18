Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF35C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A963522AAA
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A963522AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3602B6E2F2;
	Mon, 18 Jan 2021 15:50:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD2989FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 15:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9zx+z3dr6Fzd5Z9fEHk+PxmWa7bBPaUX71DsaRIAdd/w+iq8Ve2ULK17Qx40ThYR4vNx7E9sHWzVupq6aCF9HTGSW9RolbOn0eOnsbLa9z06+l/doxnNvwooPU1JtZqRES9hZ9w8DiUFah+K/7N19u8JXDhtavtq12ENsL2mF8vDgDcNiO2O6mWQ96f9lXkxNcQ19koGzmpyOsH8Wsbb8cY6sXy5EvZKMiV2WXK3muJ/Bcom8zXMtbF4TbzvpWbKizfVybeQQIL+GLIDL1AblII2qXGQprHLa8rizrrxo6k939SGqrPzeCWvJ28qB/cAcV00n508s73i4PrOCo9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBUUpFA2bqES/KD7WxvKmRlzNQ439Bnqdc/Vq40WmMU=;
 b=YpaHjiJ+Ij9S8AELzbN8CdrSbBdBuwh/zVKHZCTCCXzQeAhjx15xht/saDcJwpzaw5les9Iz3ecQgXfReJjIRqYm+y3mQXG/+v9rLpzuRDpW/lr/11FwTLKkZqrsuxruz+CCzJRr893sx1VTK0Px2bKQ3yB8R3/wJdV2PtfE5ndHffqhxOjezvBesBP7gyCBQjDu/UzbnEJEOLKe37WQ9KayrvBQQjWAbnM95gvC74AGIjT16ppzuANGY9FH85W3ZOfZF0Um/o32HHyrRHqTT/EV4RvLDjzBxWa9sCywq303qI7gxIqaFBJClX75eNHG2gngNUWmZ0pGFhcOvkzUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBUUpFA2bqES/KD7WxvKmRlzNQ439Bnqdc/Vq40WmMU=;
 b=A4ey9z6nCnDQ3bJCPc5OE2eS2R3whlITbEqUeC7IR0Wbqy6MmI4wtPc28W7FaSUTSF0CrtvKLd+itQ2nd8qFnD3cfg/LAoH2ZFLIrkKYGvXSJjWa1NPgoCxBh3p91vei0tJ8nfbWIS95IHJ+/db3Ck3JXYAcrbc1wf+DuAHakR8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3984.namprd12.prod.outlook.com (2603:10b6:208:16f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 15:50:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 15:50:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix build error without x86 kconfig (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: fix build error without x86 kconfig (v2)
Thread-Index: AQHW7ZYVe/WspVxcmE6i+Y9/RHhQgKoth+R5
Date: Mon, 18 Jan 2021 15:50:20 +0000
Message-ID: <MN2PR12MB44887CBDD43B3F3D3B869A67F7A40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210118123248.22570-1-ray.huang@amd.com>
In-Reply-To: <20210118123248.22570-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-18T15:50:20.460Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 373d26c5-b22d-44a8-4261-08d8bbc8c2f5
x-ms-traffictypediagnostic: MN2PR12MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3984E4004F46332ACA9CAF37F7A40@MN2PR12MB3984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlCiWe3WYXPjVgr8PL4MlHTQT3vEQpn4KF7uP/k2Rmk4esaBMQKVTpypU6QPS/GNAqJfRSvLINpyFzjUkhUwNi7+2RK3D4SHO71+aVDZdxyXyLZbnjLpuhrl//gnfyU9Qjy3h5YivNcDieIuAML+GkubCXCgF5lUBDnYElKgqnIs9XVgsmSIaCKev73TE0u0qjk812CVb2faq/A7jw7W79yYqwLKwHMqJam9wI/+wcQipputFjQ9uZJaRxH6+r02JfT4IK4CCg8m7uudPOyo8CjDey9j8LaZhmjeMiQQDBPmXq1PSuOd0XijjX5AM+Kk0xIClWtjOPHiHZ+NACgtQk5gbsnUDG7IVI67WF/jj62mB5ULPB3RPlD4HMXomMAmdrZ4GbKz3IFXT5oK/R2Svg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(66476007)(66946007)(66446008)(66556008)(33656002)(64756008)(76116006)(8936002)(71200400001)(26005)(8676002)(83380400001)(478600001)(316002)(2906002)(110136005)(7696005)(6506007)(186003)(5660300002)(86362001)(9686003)(4326008)(19627405001)(55016002)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2QZY3uJCGSwa91Pw0hSRFDOejrvk7Rtjl1QedGVWNoDTBVPvEGMGZx28vWTg?=
 =?us-ascii?Q?ztEp9do+F9/uhZ0NFBP+kQN4K6CnKJK86omrxD3ZrOJ33rB2SeFTs6xQ4P5/?=
 =?us-ascii?Q?N1JOjxVYuyoq1eLx6LFfpWRbb0wySo/EYd/h2AJYhZW2bcvGjGNjbtxkKqs/?=
 =?us-ascii?Q?a0VkeQV6PXobyDMHOwvEpZmkJtgyTPMann1wQDOEEvmcwBH+lxUrIw1SCXIX?=
 =?us-ascii?Q?dG+m4XKqXOeZ5SqQ1UV+05sMYoNoOmxwmfIPr+Y5Yy9kvVDcyovM6cB7qAWp?=
 =?us-ascii?Q?FbrChajiY1Lvvz1ycjbbOB63r+Dqzt7r/OfdpTYXaMv+Hi0KhtE53VSi1Dul?=
 =?us-ascii?Q?dIXFjGg4indlGr8U1XTl//DncZpLelc6GILbi+j+uNVJEyp9R6kRTMEg04H8?=
 =?us-ascii?Q?pNoo2gRK5ApiqEFwsMYaO79A96SxRh5wXVCG0JnmKvJ0j/97mQ7RNlyACMX/?=
 =?us-ascii?Q?XoysuAGV44LUjwNcXErE2Q8vCICiDLE1UtyypIrnPfryTYybsez0eA5lPKvQ?=
 =?us-ascii?Q?EzS/SgG+mjnQPoJNHnUZwb2ztlVY4TYUIeVZ3PAvT1+SiYUNp5faQ02tyzBz?=
 =?us-ascii?Q?diZPZLWX5w/mfHyJYCNApPbI4qF1z6cTSzhsr1IRhIXIAxen/G1i1Ql2R+wN?=
 =?us-ascii?Q?JlJAV0xRuWJD1V+yJ23QteZPB++QhOFogz+4HDa/sHFWrNljVR6NYaCQ+YoE?=
 =?us-ascii?Q?bMhDqLsBuYMw5q1Iuol/rQjxk/w7pgXEk6CAAX1eQRDjxCMtE0ejlktgB8hR?=
 =?us-ascii?Q?hSuqPkL/ssqpMdENTlGfH5xieo3kdFp7Hqg/zQ7uaVMvvy+VhUdaENDt50dT?=
 =?us-ascii?Q?BkDhkV+GCHDonxOXDmfJnhapsgmrwLB4JPQXgv7BtMWtK4xli3ue720HfRQ8?=
 =?us-ascii?Q?E6Mz4SXCivNMUC+/6nTBubQuCFFpody3dWk+4BTwT+gGNZy6Uir+lwUMVcs3?=
 =?us-ascii?Q?OpHMzqlhivCnlAubMBsuPEq5Cuu0LaKcCCXS4LeLh9o=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373d26c5-b22d-44a8-4261-08d8bbc8c2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 15:50:20.9998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dbl3AMH3wgen4ZETj6gJOofB3XiqIFYsJfF6Jf5tWiHIelb84KuI/CV7GvHoA93HxXJwU0lj4su8FB/5hne+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3984
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: multipart/mixed; boundary="===============0446535696=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0446535696==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887CBDD43B3F3D3B869A67F7A40MN2PR12MB4488namp_"

--_000_MN2PR12MB44887CBDD43B3F3D3B869A67F7A40MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Monday, January 18, 2021 7:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] drm/amdgpu: fix build error without x86 kconfig (v2)

This patch is to fix below build error while we are using the kconfig
without x86.

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_get_smu_metrics_data':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:300:10:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
  300 |          boot_cpu_data.x86_max_cores * sizeof(uint16_t));
      |          ^~~~~~~~~~~~~
      |          boot_cpuid
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_read_sensor':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1320:11:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
 1320 |   *size =3D boot_cpu_data.x86_max_cores * sizeof(uint16_t);
      |           ^~~~~~~~~~~~~
      |           boot_cpuid
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_od_edit_dpm_table':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1460:19:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
 1460 |   if (input[0] >=3D boot_cpu_data.x86_max_cores) {
      |                   ^~~~~~~~~~~~~
      |                   boot_cpuid

v2: fix #ifdef and add comment for APU only

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              |  4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++++++++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 80d6298912aa..e9b569b76716 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3633,12 +3633,12 @@ static void amdgpu_debugfs_prints_cpu_info(struct s=
eq_file *m,
         int i;

         if (is_support_cclk_dpm(adev)) {
-               p_val =3D kcalloc(boot_cpu_data.x86_max_cores, sizeof(uint1=
6_t),
+               p_val =3D kcalloc(adev->smu.cpu_core_num, sizeof(uint16_t),
                                 GFP_KERNEL);

                 if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CPU_CLK=
,
                                             (void *)p_val, &size)) {
-                       for (i =3D 0; i < boot_cpu_data.x86_max_cores; i++)
+                       for (i =3D 0; i < adev->smu.cpu_core_num; i++)
                                 seq_printf(m, "\t%u MHz (CPU%d)\n",
                                            *(p_val + i), i);
                 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 25ee9f51813b..a087e00382e6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -466,11 +466,13 @@ struct smu_context
         uint32_t gfx_actual_hard_min_freq;
         uint32_t gfx_actual_soft_max_freq;

+       /* APU only */
         uint32_t cpu_default_soft_min_freq;
         uint32_t cpu_default_soft_max_freq;
         uint32_t cpu_actual_soft_min_freq;
         uint32_t cpu_actual_soft_max_freq;
         uint32_t cpu_core_id_select;
+       uint16_t cpu_core_num;
 };

 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f0cb0ea243b..dc41abe7b1d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -297,7 +297,7 @@ static int vangogh_get_smu_metrics_data(struct smu_cont=
ext *smu,
                 break;
         case METRICS_AVERAGE_CPUCLK:
                 memcpy(value, &metrics->CoreFrequency[0],
-                      boot_cpu_data.x86_max_cores * sizeof(uint16_t));
+                      smu->cpu_core_num * sizeof(uint16_t));
                 break;
         default:
                 *value =3D UINT_MAX;
@@ -335,6 +335,13 @@ static int vangogh_init_smc_tables(struct smu_context =
*smu)
         if (ret)
                 return ret;

+#ifdef CONFIG_X86
+       /* AMD x86 APU only */
+       smu->cpu_core_num =3D boot_cpu_data.x86_max_cores;
+#else
+       smu->cpu_core_num =3D 4;
+#endif
+
         return smu_v11_0_init_smc_tables(smu);
 }

@@ -1317,7 +1324,7 @@ static int vangogh_read_sensor(struct smu_context *sm=
u,
                 ret =3D vangogh_get_smu_metrics_data(smu,
                                                    METRICS_AVERAGE_CPUCLK,
                                                    (uint32_t *)data);
-               *size =3D boot_cpu_data.x86_max_cores * sizeof(uint16_t);
+               *size =3D smu->cpu_core_num * sizeof(uint16_t);
                 break;
         default:
                 ret =3D -EOPNOTSUPP;
@@ -1457,9 +1464,9 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
                         dev_err(smu->adev->dev, "Input parameter number no=
t correct (should be 4 for processor)\n");
                         return -EINVAL;
                 }
-               if (input[0] >=3D boot_cpu_data.x86_max_cores) {
+               if (input[0] >=3D smu->cpu_core_num) {
                         dev_err(smu->adev->dev, "core index is overflow, s=
hould be less than %d\n",
-                               boot_cpu_data.x86_max_cores);
+                               smu->cpu_core_num);
                 }
                 smu->cpu_core_id_select =3D input[0];
                 if (input[1] =3D=3D 0) {
@@ -1535,7 +1542,7 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
                                 break;
                         }

-                       for (i =3D 0; i < boot_cpu_data.x86_max_cores; i++)=
 {
+                       for (i =3D 0; i < smu->cpu_core_num; i++) {
                                 ret =3D smu_cmn_send_smc_msg_with_param(sm=
u, SMU_MSG_SetSoftMinCclk,
                                                                       (i <=
< 20) | smu->cpu_actual_soft_min_freq,
                                                                       NULL=
);
--
2.25.1


--_000_MN2PR12MB44887CBDD43B3F3D3B869A67F7A40MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Monday, January 18, 2021 7:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;<b=
r>
<b>Subject:</b> [PATCH v2] drm/amdgpu: fix build error without x86 kconfig =
(v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to fix below build error while we ar=
e using the kconfig<br>
without x86.<br>
<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function<br>
'vangogh_get_smu_metrics_data':<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:300:10:<br>
error: 'boot_cpu_data' undeclared (first use in this function); did you<br>
mean 'boot_cpuid'?<br>
&nbsp; 300 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_cpu=
_data.x86_max_cores * sizeof(uint16_t));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ^~~~~~~~~~~~~<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; boot_cpuid<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function<br>
'vangogh_read_sensor':<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1320:11:<br>
error: 'boot_cpu_data' undeclared (first use in this function); did you<br>
mean 'boot_cpuid'?<br>
&nbsp;1320 |&nbsp;&nbsp; *size =3D boot_cpu_data.x86_max_cores * sizeof(uin=
t16_t);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~~<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; boot_cpuid<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function<br>
'vangogh_od_edit_dpm_table':<br>
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1460:19:<br>
error: 'boot_cpu_data' undeclared (first use in this function); did you<br>
mean 'boot_cpuid'?<br>
&nbsp;1460 |&nbsp;&nbsp; if (input[0] &gt;=3D boot_cpu_data.x86_max_cores) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~=
~~~~<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_cpui=
d<br>
<br>
v2: fix #ifdef and add comment for APU only<br>
<br>
Reported-by: Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp;&nbsp; | 17 +=
+++++++++++-----<br>
&nbsp;3 files changed, 16 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 80d6298912aa..e9b569b76716 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -3633,12 +3633,12 @@ static void amdgpu_debugfs_prints_cpu_info(struct s=
eq_file *m,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_cclk_dpm(ad=
ev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p_val =3D kcalloc(boot_cpu_data.x86_max_cores, sizeof(uint16_t),=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p_val =3D kcalloc(adev-&gt;smu.cpu_core_num, sizeof(uint16_t),<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CP=
U_CLK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)p_val, &amp;size)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; boot_cpu_data.x86_max_cores; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; adev-&gt;smu.cpu_core_num; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u MHz (CP=
U%d)\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(p_val + i), i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 25ee9f51813b..a087e00382e6 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -466,11 +466,13 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_actual_hard_m=
in_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_actual_soft_m=
ax_freq;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APU only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_default_soft_=
min_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_default_soft_=
max_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_actual_soft_m=
in_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_actual_soft_m=
ax_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_core_id_selec=
t;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t cpu_core_num;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct i2c_adapter;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 2f0cb0ea243b..dc41abe7b1d3 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -297,7 +297,7 @@ static int vangogh_get_smu_metrics_data(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_CPUCL=
K:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(value, &amp;metrics-&gt;CoreFrequency[0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_cpu_data.x86_max_=
cores * sizeof(uint16_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;cpu_core_num *=
 sizeof(uint16_t));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D UINT_MAX;<br>
@@ -335,6 +335,13 @@ static int vangogh_init_smc_tables(struct smu_context =
*smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
+#ifdef CONFIG_X86<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMD x86 APU only */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;cpu_core_num =3D boot_cpu_dat=
a.x86_max_cores;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;cpu_core_num =3D 4;<br>
+#endif<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v11_0_init_smc_=
tables(smu);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1317,7 +1324,7 @@ static int vangogh_read_sensor(struct smu_context *sm=
u,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vangogh_get_smu_metrics_data(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; METRICS_AVERAGE_CPUCLK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (uint32_t *)data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *size =3D boot_cpu_data.x86_max_cores * sizeof(uint16_t);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *size =3D smu-&gt;cpu_core_num * sizeof(uint16_t);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D -EOPNOTSUPP;<br>
@@ -1457,9 +1464,9 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(smu-&gt;adev-&gt;dev, &quot;Input parameter number not correct (should b=
e 4 for processor)\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input[0] &gt;=3D boot_cpu_data.x86_max_cores) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input[0] &gt;=3D smu-&gt;cpu_core_num) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(smu-&gt;adev-&gt;dev, &quot;core index is overflow, should be less than =
%d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_cpu_data.x86_max_cores);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;cpu_core_num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;cpu_core_id_select =3D input[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (input[1] =3D=3D 0) {<br>
@@ -1535,7 +1542,7 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; boot_cpu_data.x86_max_cores; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; smu-&gt;cpu_core_num; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_wit=
h_param(smu, SMU_MSG_SetSoftMinCclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i &lt;&lt; 20) | smu-&gt;cpu=
_actual_soft_min_freq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887CBDD43B3F3D3B869A67F7A40MN2PR12MB4488namp_--

--===============0446535696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0446535696==--
