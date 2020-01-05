Return-Path: <SRS0=TBsq=22=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AFAC00523
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2020 06:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD410206F0
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2020 06:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jhqHT69B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD410206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FBA6E0AA;
	Sun,  5 Jan 2020 06:11:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58536E09E
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2020 06:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WslsUJAAmz0YiwcRWOHPHVp+7Ihb0Cxm2Zpmm0xpp4OmyfE01W7bQrjKoX6C4p7+cNmLeN4I9M3nrAaFeK1Ij1GgYFG6L0kaVM//2M1x52fn2K6UOqL3IoALjjX1suf48/debkN7ReHt7aRsQF+ATcBW/BQA6JLNk9p7PS3z7PSWJG7d9WK1Pq3iHSdcrC92SmR7l/C0+L+uz4cNWVfCM6tUh3XfDbcQwdfqnMUhr5E3t7qaHJHz0sxDvTuNtfAi7OWk/FJg7xrXBADeKGLtIsMIBbK19ApRdnuGR7rUJSTP8Hi3ZNJsQNgTkB7d8joacSuTacTfA47sMDbmUg9x7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP6vHcUCK2Xfsv8dkZbfJNdHh5SoyOF9x30Y2P98TjQ=;
 b=LL6WjeADIWEksv0S2Ywt8u8wsx/XpWqQ9+nldhgnUn7Q3Yd9dT9l6gAGp/8I0fbtl6KO5tyW5DwVWw+sqzX6O2LCCTt3RvbzQ/8ZvndhA5M2K8HJ9r/jRrr1rcjKzcDzY9rgOAKCVY0RaX694uN5S8LBKj/q2oaMP/8Aa7DFkW+PvA+PxlfSj5/1G0IenpZWOUuFPXClKtA6TI7AgRYSKSPdCZECRFSDCXFW6LimzbPr7u8anBfwmvjCNpQYWsOFA5DAEmV1Kk/0kTT02J54uxFLozvS3c4fNbBFY6yQd05dhwjdyKVSz67dyqmnEj77kxMhfqW2PTbboEyEyNm8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP6vHcUCK2Xfsv8dkZbfJNdHh5SoyOF9x30Y2P98TjQ=;
 b=jhqHT69B1OgARmDWMVcjwi1CcT8aD4DOi2j69pK30jEIbkGxMIqtu1fdTZuRLnlraPDRG1yVwJ7HJIwpqD3kkZmMf1HwFdZo/SmTJfLn8levWPSs99a8uM1vTyeJnAhn7wyfMnlPEyOJoalM1BEsKiynSK+NDNloIuwZ6hcXpqw=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3072.namprd12.prod.outlook.com (20.178.241.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Sun, 5 Jan 2020 06:11:14 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::90a0:8353:690c:1751]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::90a0:8353:690c:1751%7]) with mapi id 15.20.2602.015; Sun, 5 Jan 2020
 06:11:14 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: unified VRAM address for driver table
 interaction with SMU V2
Thread-Topic: [PATCH] drm/amd/powerplay: unified VRAM address for driver table
 interaction with SMU V2
Thread-Index: AQHVwRX3rRvfG/jgBU2Cojv+RQzaK6fbmeUO
Date: Sun, 5 Jan 2020 06:11:14 +0000
Message-ID: <MN2PR12MB3296B389D332B3E147AA4D4CA23D0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20200102023943.11555-1-evan.quan@amd.com>
In-Reply-To: <20200102023943.11555-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-05T06:11:12.696Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [58.246.141.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66b78a90-21b3-4a77-054d-08d791a61195
x-ms-traffictypediagnostic: MN2PR12MB3072:|MN2PR12MB3072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB307286D5937FE0ECDAC24BA2A23D0@MN2PR12MB3072.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 027367F73D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(30864003)(7696005)(316002)(2906002)(66556008)(64756008)(66946007)(66446008)(26005)(66476007)(6506007)(53546011)(33656002)(110136005)(5660300002)(19627405001)(186003)(86362001)(9686003)(81166006)(81156014)(8936002)(8676002)(19627235002)(55016002)(52536014)(4326008)(71200400001)(478600001)(76116006)(966005)(91956017)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3072;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HN0QPVhC87A8GR2Nh1azkvLM+NaMMZJHWbi4tY061fRtyWVrKvM6bIa9gY+8Os5E4EGE0RO9yt+0TFsz64ihyCldUT2EilIjv/SqI2Q5HhI0O/3WNHi40ks0iyG5VeaXa4SpGDq09YVlEt3BVQ6liHWgVwySr/bGxZ++LyiZ6b3P6LYVHcAzOqQmJzlLGKQgbCvNIxsmPpcMDzRHJB5c7JE5luXxe2HPeT8levh8NURgz5MJjVEPmNuxNW0E9xKn8NdTFd/vDO7YZwpIePoSBVJa7jmof6QGkPiD2qmVJf9mrWBXCcnB9n7kw+hDC969nrFhqCMCPT7OkeVa9PZaRLWwJGr3nOrVreaVm2QChvCk1WNoRvpaEvtyJoO48Xy7VKvPEFaiZ0KQ2JUSIZU5Jq7ZcQGvIc0nNAVSHPvovqIhKFSqp1u3dQcbShX3l1g2Yi3NLsBMcrdI++flxn/NdtLKWeYooBYoGE5QRDSNMfA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b78a90-21b3-4a77-054d-08d791a61195
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2020 06:11:14.0212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaUdLIjzEN9S0FvRbKQN3HzIIuhtdaOBWGs5Bltxi9QZPIIN27Jl7DEospG0px/d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Content-Type: multipart/mixed; boundary="===============0575002589=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0575002589==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296B389D332B3E147AA4D4CA23D0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296B389D332B3E147AA4D4CA23D0MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Thursday, January 2, 2020 10:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/powerplay: unified VRAM address for driver table i=
nteraction with SMU V2

By this, we can avoid to pass in the VRAM address on every table
transferring. That puts extra unnecessary traffics on SMU on
some cases(e.g. polling the amdgpu_pm_info sysfs interface).

V2: document what the driver table is for and how it works

Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 98 ++++++++++++-------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  3 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    | 10 ++
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 26 +++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
 11 files changed, 117 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 95238ad38de8..beea4d9e82d4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -519,26 +519,19 @@ int smu_update_table(struct smu_context *smu, enum sm=
u_table_id table_index, int
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
         struct amdgpu_device *adev =3D smu->adev;
-       struct smu_table *table =3D NULL;
-       int ret =3D 0;
+       struct smu_table *table =3D &smu_table->driver_table;
         int table_id =3D smu_table_get_index(smu, table_index);
+       uint32_t table_size;
+       int ret =3D 0;

         if (!table_data || table_id >=3D SMU_TABLE_COUNT || table_id < 0)
                 return -EINVAL;

-       table =3D &smu_table->tables[table_index];
+       table_size =3D smu_table->tables[table_index].size;

         if (drv2smu)
-               memcpy(table->cpu_addr, table_data, table->size);
+               memcpy(table->cpu_addr, table_data, table_size);

-       ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrH=
igh,
-                                         upper_32_bits(table->mc_address))=
;
-       if (ret)
-               return ret;
-       ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrL=
ow,
-                                         lower_32_bits(table->mc_address))=
;
-       if (ret)
-               return ret;
         ret =3D smu_send_smc_msg_with_param(smu, drv2smu ?
                                           SMU_MSG_TransferTableDram2Smu :
                                           SMU_MSG_TransferTableSmu2Dram,
@@ -550,7 +543,7 @@ int smu_update_table(struct smu_context *smu, enum smu_=
table_id table_index, int
         adev->nbio.funcs->hdp_flush(adev, NULL);

         if (!drv2smu)
-               memcpy(table_data, table->cpu_addr, table->size);
+               memcpy(table_data, table->cpu_addr, table_size);

         return ret;
 }
@@ -976,32 +969,56 @@ static int smu_init_fb_allocations(struct smu_context=
 *smu)
         struct amdgpu_device *adev =3D smu->adev;
         struct smu_table_context *smu_table =3D &smu->smu_table;
         struct smu_table *tables =3D smu_table->tables;
+       struct smu_table *driver_table =3D &(smu_table->driver_table);
+       uint32_t max_table_size =3D 0;
         int ret, i;

-       for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
-               if (tables[i].size =3D=3D 0)
-                       continue;
+       /* VRAM allocation for tool table */
+       if (tables[SMU_TABLE_PMSTATUSLOG].size) {
                 ret =3D amdgpu_bo_create_kernel(adev,
-                                             tables[i].size,
-                                             tables[i].align,
-                                             tables[i].domain,
-                                             &tables[i].bo,
-                                             &tables[i].mc_address,
-                                             &tables[i].cpu_addr);
-               if (ret)
-                       goto failed;
+                                             tables[SMU_TABLE_PMSTATUSLOG]=
.size,
+                                             tables[SMU_TABLE_PMSTATUSLOG]=
.align,
+                                             tables[SMU_TABLE_PMSTATUSLOG]=
.domain,
+                                             &tables[SMU_TABLE_PMSTATUSLOG=
].bo,
+                                             &tables[SMU_TABLE_PMSTATUSLOG=
].mc_address,
+                                             &tables[SMU_TABLE_PMSTATUSLOG=
].cpu_addr);
+               if (ret) {
+                       pr_err("VRAM allocation for tool table failed!\n");
+                       return ret;
+               }
         }

-       return 0;
-failed:
-       while (--i >=3D 0) {
+       /* VRAM allocation for driver table */
+       for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
                 if (tables[i].size =3D=3D 0)
                         continue;
-               amdgpu_bo_free_kernel(&tables[i].bo,
-                                     &tables[i].mc_address,
-                                     &tables[i].cpu_addr);

+               if (i =3D=3D SMU_TABLE_PMSTATUSLOG)
+                       continue;
+
+               if (max_table_size < tables[i].size)
+                       max_table_size =3D tables[i].size;
+       }
+
+       driver_table->size =3D max_table_size;
+       driver_table->align =3D PAGE_SIZE;
+       driver_table->domain =3D AMDGPU_GEM_DOMAIN_VRAM;
+
+       ret =3D amdgpu_bo_create_kernel(adev,
+                                     driver_table->size,
+                                     driver_table->align,
+                                     driver_table->domain,
+                                     &driver_table->bo,
+                                     &driver_table->mc_address,
+                                     &driver_table->cpu_addr);
+       if (ret) {
+               pr_err("VRAM allocation for driver table failed!\n");
+               if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+                       amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG=
].bo,
+                                             &tables[SMU_TABLE_PMSTATUSLOG=
].mc_address,
+                                             &tables[SMU_TABLE_PMSTATUSLOG=
].cpu_addr);
         }
+
         return ret;
 }

@@ -1009,18 +1026,19 @@ static int smu_fini_fb_allocations(struct smu_conte=
xt *smu)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
         struct smu_table *tables =3D smu_table->tables;
-       uint32_t i =3D 0;
+       struct smu_table *driver_table =3D &(smu_table->driver_table);

         if (!tables)
                 return 0;

-       for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
-               if (tables[i].size =3D=3D 0)
-                       continue;
-               amdgpu_bo_free_kernel(&tables[i].bo,
-                                     &tables[i].mc_address,
-                                     &tables[i].cpu_addr);
-       }
+       if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+               amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
+                                     &tables[SMU_TABLE_PMSTATUSLOG].mc_add=
ress,
+                                     &tables[SMU_TABLE_PMSTATUSLOG].cpu_ad=
dr);
+
+       amdgpu_bo_free_kernel(&driver_table->bo,
+                             &driver_table->mc_address,
+                             &driver_table->cpu_addr);

         return 0;
 }
@@ -1091,6 +1109,10 @@ static int smu_smc_table_hw_init(struct smu_context =
*smu,

         /* smu_dump_pptable(smu); */

+       ret =3D smu_set_driver_table_location(smu);
+       if (ret)
+               return ret;
+
         /*
          * Copy pptable bo in the vram to smc with SMU MSGs such as
          * SetDriverDramAddr and TransferTableDram2Smu.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 50b317f4b1e6..064b5201a8a7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2022,7 +2022,7 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_a=
dapter *control,
         SwI2cRequest_t req;
         struct amdgpu_device *adev =3D to_amdgpu_device(control);
         struct smu_table_context *smu_table =3D &adev->smu.smu_table;
-       struct smu_table *table =3D &smu_table->tables[SMU_TABLE_I2C_COMMAN=
DS];
+       struct smu_table *table =3D &smu_table->driver_table;

         memset(&req, 0, sizeof(req));
         arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data)=
;
@@ -2261,6 +2261,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         .check_fw_version =3D smu_v11_0_check_fw_version,
         .write_pptable =3D smu_v11_0_write_pptable,
         .set_min_dcef_deep_sleep =3D smu_v11_0_set_min_dcef_deep_sleep,
+       .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 02d33b50e735..b0591a8dda41 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -260,6 +260,15 @@ struct smu_table_context
         struct smu_bios_boot_up_values  boot_values;
         void                            *driver_pptable;
         struct smu_table                *tables;
+       /*
+        * The driver table is just a staging buffer for
+        * uploading/downloading content from the SMU.
+        *
+        * And the table_id for SMU_MSG_TransferTableSmu2Dram/
+        * SMU_MSG_TransferTableDram2Smu instructs SMU
+        * which content driver is interested.
+        */
+       struct smu_table                driver_table;
         struct smu_table                memory_pool;
         uint8_t                         thermal_controller_type;

@@ -498,6 +507,7 @@ struct pptable_funcs {
         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
         int (*write_pptable)(struct smu_context *smu);
         int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
+       int (*set_driver_table_location)(struct smu_context *smu);
         int (*set_tool_table_location)(struct smu_context *smu);
         int (*notify_memory_pool_location)(struct smu_context *smu);
         int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index db3f78676aeb..662989296174 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -170,6 +170,8 @@ int smu_v11_0_write_pptable(struct smu_context *smu);

 int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);

+int smu_v11_0_set_driver_table_location(struct smu_context *smu);
+
 int smu_v11_0_set_tool_table_location(struct smu_context *smu);

 int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h
index 3f1cd06e273c..d79e54b5ebf6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -90,4 +90,6 @@ int smu_v12_0_mode2_reset(struct smu_context *smu);
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
                             uint32_t min, uint32_t max);

+int smu_v12_0_set_driver_table_location(struct smu_context *smu);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index bb0915a6388e..a16af3a3843c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2112,6 +2112,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .check_fw_version =3D smu_v11_0_check_fw_version,
         .write_pptable =3D smu_v11_0_write_pptable,
         .set_min_dcef_deep_sleep =3D smu_v11_0_set_min_dcef_deep_sleep,
+       .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 506cc6bf4bc0..861e6410363b 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -920,6 +920,7 @@ static const struct pptable_funcs renoir_ppt_funcs =3D =
{
         .get_dpm_ultimate_freq =3D smu_v12_0_get_dpm_ultimate_freq,
         .mode2_reset =3D smu_v12_0_mode2_reset,
         .set_soft_freq_limited_range =3D smu_v12_0_set_soft_freq_limited_r=
ange,
+       .set_driver_table_location =3D smu_v12_0_set_driver_table_location,
 };

 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h
index 77864e4236c4..783319ec8bf9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -61,6 +61,8 @@
         ((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable=
((smu)) : 0)
 #define smu_set_min_dcef_deep_sleep(smu) \
         ((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set=
_min_dcef_deep_sleep((smu)) : 0)
+#define smu_set_driver_table_location(smu) \
+       ((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->se=
t_driver_table_location((smu)) : 0)
 #define smu_set_tool_table_location(smu) \
         ((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set=
_tool_table_location((smu)) : 0)
 #define smu_notify_memory_pool_location(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 6fb93eb6ab39..e804f9854027 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -776,6 +776,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_conte=
xt *smu)
         return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_v=
alues.dcefclk / 100);
 }

+int smu_v11_0_set_driver_table_location(struct smu_context *smu)
+{
+       struct smu_table *driver_table =3D &smu->smu_table.driver_table;
+       int ret =3D 0;
+
+       if (driver_table->mc_address) {
+               ret =3D smu_send_smc_msg_with_param(smu,
+                               SMU_MSG_SetDriverDramAddrHigh,
+                               upper_32_bits(driver_table->mc_address));
+               if (!ret)
+                       ret =3D smu_send_smc_msg_with_param(smu,
+                               SMU_MSG_SetDriverDramAddrLow,
+                               lower_32_bits(driver_table->mc_address));
+       }
+
+       return ret;
+}
+
 int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 {
         int ret =3D 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c
index 9e27462d0f4e..870e6db2907e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -318,14 +318,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 int smu_v12_0_populate_smc_tables(struct smu_context *smu)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct smu_table *table =3D NULL;
-
-       table =3D &smu_table->tables[SMU_TABLE_DPMCLOCKS];
-       if (!table)
-               return -EINVAL;
-
-       if (!table->cpu_addr)
-               return -EINVAL;

         return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->cl=
ocks_table, false);
 }
@@ -514,3 +506,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_c=
ontext *smu, enum smu_clk_

         return ret;
 }
+
+int smu_v12_0_set_driver_table_location(struct smu_context *smu)
+{
+       struct smu_table *driver_table =3D &smu->smu_table.driver_table;
+       int ret =3D 0;
+
+       if (driver_table->mc_address) {
+               ret =3D smu_send_smc_msg_with_param(smu,
+                               SMU_MSG_SetDriverDramAddrHigh,
+                               upper_32_bits(driver_table->mc_address));
+               if (!ret)
+                       ret =3D smu_send_smc_msg_with_param(smu,
+                               SMU_MSG_SetDriverDramAddrLow,
+                               lower_32_bits(driver_table->mc_address));
+       }
[kevin]:
for these paris of message, the smu driver should be better to add lock to =
protect bellow case on multi thread case (eg: cat sysfs)
High A + Low B
High B + Low A
+
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 27bdcdeb08d9..38febd5ca4da 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3236,6 +3236,7 @@ static const struct pptable_funcs vega20_ppt_funcs =
=3D {
         .check_fw_version =3D smu_v11_0_check_fw_version,
         .write_pptable =3D smu_v11_0_write_pptable,
         .set_min_dcef_deep_sleep =3D smu_v11_0_set_min_dcef_deep_sleep,
+       .set_driver_table_location =3D smu_v11_0_set_driver_table_location,
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cf88b8d717d4745f7521308d78f2d1824%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637135296167400253&amp;sdata=3DnHLXbyqZO2YNTyE4nTw4SP9ld=
cZqXijxZuGMSDWPxHM%3D&amp;reserved=3D0

--_000_MN2PR12MB3296B389D332B3E147AA4D4CA23D0MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, January 2, 2020 10:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: unified VRAM address for driver =
table interaction with SMU V2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">By this, we can avoid to pass in the VRAM address =
on every table<br>
transferring. That puts extra unnecessary traffics on SMU on<br>
some cases(e.g. polling the amdgpu_pm_info sysfs interface).<br>
<br>
V2: document what the driver table is for and how it works<br>
<br>
Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 98 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp; |&nbsp; 3 &#43;-<b=
r>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; | 10 &#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |&nbsp; 2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_internal.h&nbsp; |&nbsp; 2 &#43;<br=
>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 1=
8 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
6 &#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;11 files changed, 117 insertions(&#43;), 47 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 95238ad38de8..beea4d9e82d4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -519,26 &#43;519,19 @@ int smu_update_table(struct smu_context *smu, enu=
m smu_table_id table_index, int<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D &amp;=
smu_table-&gt;driver_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_id =3D smu_table=
_get_index(smu, table_index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table_data || table_i=
d &gt;=3D SMU_TABLE_COUNT || table_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table =3D &amp;smu_table-&gt;tables[t=
able_index];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_size =3D smu_table-&gt;tabl=
es[table_index].size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drv2smu)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy(table-&gt;cpu_addr, table_data, table-&gt;size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memcpy(table-&gt;cpu_addr, table_data, table_size);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(s=
mu, SMU_MSG_SetDriverDramAddrHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; upper_32_bits(table-&gt;mc_address));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(s=
mu, SMU_MSG_SetDriverDramAddrLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; lower_32_bits(table-&gt;mc_address));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_w=
ith_param(smu, drv2smu ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_TransferTableDram2Smu :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_TransferTableSmu2Dram,<br>
@@ -550,7 &#43;543,7 @@ int smu_update_table(struct smu_context *smu, enum =
smu_table_id table_index, int<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;hd=
p_flush(adev, NULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drv2smu)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy(table_data, table-&gt;cpu_addr, table-&gt;size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memcpy(table_data, table-&gt;cpu_addr, table_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -976,32 &#43;969,56 @@ static int smu_init_fb_allocations(struct smu_con=
text *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =
=3D smu_table-&gt;tables;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =
=3D &amp;(smu_table-&gt;driver_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_table_size =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_TABLE_COUNT;=
 i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM allocation for tool table=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tables[SMU_TABLE_PMSTATUSLOG]=
.size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[i].size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[i].align,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[i].domain,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[i].bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[i].mc_address,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[i].cpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[SMU_TABLE_PMSTATUSLOG].=
size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[SMU_TABLE_PMSTATUSLOG].=
align,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[SMU_TABLE_PMSTATUSLOG].=
domain,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[SMU_TABLE_PMSTATUS=
LOG].bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[SMU_TABLE_PMSTATUS=
LOG].mc_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[SMU_TABLE_PMSTATUS=
LOG].cpu_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot=
;VRAM allocation for tool table failed!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-failed:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (--i &gt;=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM allocation for driver tab=
le */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_TABLE_CO=
UNT; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;tables[i].bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta=
bles[i].mc_address,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta=
bles[i].cpu_addr);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (i =3D=3D SMU_TABLE_PMSTATUSLOG)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (max_table_size &lt; tables[i].size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_table_si=
ze =3D tables[i].size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_table-&gt;size =3D max_tab=
le_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_table-&gt;align =3D PAGE_S=
IZE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_table-&gt;domain =3D AMDGP=
U_GEM_DOMAIN_VRAM;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(a=
dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri=
ver_table-&gt;size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri=
ver_table-&gt;align,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri=
ver_table-&gt;domain,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &am=
p;driver_table-&gt;bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &am=
p;driver_table-&gt;mc_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &am=
p;driver_table-&gt;cpu_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;VRAM allocation for driver table failed!\n&quot=
;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_fr=
ee_kernel(&amp;tables[SMU_TABLE_PMSTATUSLOG].bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[SMU_TABLE_PMSTATUS=
LOG].mc_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tables[SMU_TABLE_PMSTATUS=
LOG].cpu_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1009,18 &#43;1026,19 @@ static int smu_fini_fb_allocations(struct smu_c=
ontext *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =
=3D smu_table-&gt;tables;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =
=3D &amp;(smu_table-&gt;driver_table);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tables)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_TABLE_COUNT;=
 i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;tables[i].bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta=
bles[i].mc_address,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta=
bles[i].cpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tables[SMU_TABLE_PMSTATUSLOG]=
.mc_address)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;tables[SMU_TABLE_PMSTATUSLOG].bo,=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &am=
p;tables[SMU_TABLE_PMSTATUSLOG].mc_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &am=
p;tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;driver=
_table-&gt;bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &amp;driver_table-&gt;mc_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &amp;driver_table-&gt;cpu_addr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1091,6 &#43;1109,10 @@ static int smu_smc_table_hw_init(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu_dump_pptable(smu); =
*/<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_driver_table_loca=
tion(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Copy pptable bo in=
 the vram to smc with SMU MSGs such as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SetDriverDramAddr =
and TransferTableDram2Smu.<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 50b317f4b1e6..064b5201a8a7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -2022,7 &#43;2022,7 @@ static int arcturus_i2c_eeprom_read_data(struct i=
2c_adapter *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SwI2cRequest_t req;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D to_amdgpu_device(control);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;adev-&gt;smu.smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D &amp;smu_=
table-&gt;tables[SMU_TABLE_I2C_COMMANDS];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D &amp;=
smu_table-&gt;driver_table;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;req, 0, sizeof=
(req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arcturus_fill_eeprom_i2c_r=
eq(&amp;req, false, address, numbytes, data);<br>
@@ -2261,6 &#43;2261,7 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_=
v11_0_check_fw_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pptable =3D smu_v11=
_0_write_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_dcef_deep_sleep =
=3D smu_v11_0_set_min_dcef_deep_sleep,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D sm=
u_v11_0_set_driver_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 02d33b50e735..b0591a8dda41 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -260,6 &#43;260,15 @@ struct smu_table_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_bios_boot_up_va=
lues&nbsp; boot_values;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_p=
ptable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *tables;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The driver table is just =
a staging buffer for<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * uploading/downloading con=
tent from the SMU.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * And the table_id for SMU_=
MSG_TransferTableSmu2Dram/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SMU_MSG_TransferTableDram=
2Smu instructs SMU<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which content driver is i=
nterested.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
river_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; memory_pool;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal_controller_type;=
<br>
&nbsp;<br>
@@ -498,6 &#43;507,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_gfx_cgpg)(struct=
 smu_context *smu, bool enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*write_pptable)(struc=
t smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_min_dcef_deep_sl=
eep)(struct smu_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_driver_table_location)(=
struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_tool_table_locat=
ion)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_memory_pool_l=
ocation)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_last_dcef_min_de=
ep_sleep_clk)(struct smu_context *smu);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index db3f78676aeb..662989296174 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -170,6 &#43;170,8 @@ int smu_v11_0_write_pptable(struct smu_context *smu=
);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);<br>
&nbsp;<br>
&#43;int smu_v11_0_set_driver_table_location(struct smu_context *smu);<br>
&#43;<br>
&nbsp;int smu_v11_0_set_tool_table_location(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);<b=
r>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h<br>
index 3f1cd06e273c..d79e54b5ebf6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
@@ -90,4 &#43;90,6 @@ int smu_v12_0_mode2_reset(struct smu_context *smu);<b=
r>
&nbsp;int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, en=
um smu_clk_type clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t min, uint32_t max);<br>
&nbsp;<br>
&#43;int smu_v12_0_set_driver_table_location(struct smu_context *smu);<br>
&#43;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index bb0915a6388e..a16af3a3843c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -2112,6 &#43;2112,7 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_=
v11_0_check_fw_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pptable =3D smu_v11=
_0_write_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_dcef_deep_sleep =
=3D smu_v11_0_set_min_dcef_deep_sleep,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D sm=
u_v11_0_set_driver_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 506cc6bf4bc0..861e6410363b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -920,6 &#43;920,7 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dpm_ultimate_freq =3D=
 smu_v12_0_get_dpm_ultimate_freq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D smu_v12_0=
_mode2_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_soft_freq_limited_ran=
ge =3D smu_v12_0_set_soft_freq_limited_range,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D sm=
u_v12_0_set_driver_table_location,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void renoir_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h<br>
index 77864e4236c4..783319ec8bf9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
@@ -61,6 &#43;61,8 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;w=
rite_pptable ? (smu)-&gt;ppt_funcs-&gt;write_pptable((smu)) : 0)<br>
&nbsp;#define smu_set_min_dcef_deep_sleep(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
et_min_dcef_deep_sleep ? (smu)-&gt;ppt_funcs-&gt;set_min_dcef_deep_sleep((s=
mu)) : 0)<br>
&#43;#define smu_set_driver_table_location(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_driv=
er_table_location ? (smu)-&gt;ppt_funcs-&gt;set_driver_table_location((smu)=
) : 0)<br>
&nbsp;#define smu_set_tool_table_location(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
et_tool_table_location ? (smu)-&gt;ppt_funcs-&gt;set_tool_table_location((s=
mu)) : 0)<br>
&nbsp;#define smu_notify_memory_pool_location(smu) \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 6fb93eb6ab39..e804f9854027 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -776,6 &#43;776,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_c=
ontext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v11_0_set_deep_=
sleep_dcefclk(smu, table_context-&gt;boot_values.dcefclk / 100);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int smu_v11_0_set_driver_table_location(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =
=3D &amp;smu-&gt;smu_table.driver_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (driver_table-&gt;mc_address) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDriverDramAddrHigh,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(driver_table-&gt;mc_addre=
ss));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_=
send_smc_msg_with_param(smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDriverDramAddrLow,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(driver_table-&gt;mc_addre=
ss));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;int smu_v11_0_set_tool_table_location(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c<br>
index 9e27462d0f4e..870e6db2907e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
@@ -318,14 &#43;318,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context *=
smu)<br>
&nbsp;int smu_v12_0_populate_smc_tables(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table =3D &amp;smu_table-&gt;tables[S=
MU_TABLE_DPMCLOCKS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table-&gt;cpu_addr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_update_table(sm=
u, SMU_TABLE_DPMCLOCKS, 0, smu_table-&gt;clocks_table, false);<br>
&nbsp;}<br>
@@ -514,3 &#43;506,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct s=
mu_context *smu, enum smu_clk_<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&#43;<br>
&#43;int smu_v12_0_set_driver_table_location(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =
=3D &amp;smu-&gt;smu_table.driver_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (driver_table-&gt;mc_address) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDriverDramAddrHigh,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(driver_table-&gt;mc_addre=
ss));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_=
send_smc_msg_with_param(smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDriverDramAddrLow,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(driver_table-&gt;mc_addre=
ss));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">for these paris of message, the smu driver should =
be better to add lock to protect bellow case on multi thread case (eg: cat =
sysfs)</div>
<div class=3D"PlainText">High A &#43; Low B</div>
<div class=3D"PlainText">High B &#43; Low A</div>
<div class=3D"PlainText">&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 27bdcdeb08d9..38febd5ca4da 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3236,6 &#43;3236,7 @@ static const struct pptable_funcs vega20_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_=
v11_0_check_fw_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pptable =3D smu_v11=
_0_write_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_dcef_deep_sleep =
=3D smu_v11_0_set_min_dcef_deep_sleep,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D sm=
u_v11_0_set_driver_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
-- <br>
2.24.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cf88b8d717d4745f7521308d78f2d1824%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637135296167400253&amp;amp;sdata=3DnHLXby=
qZO2YNTyE4nTw4SP9ldcZqXijxZuGMSDWPxHM%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7Cf88b8d717d4745f7521308d78f2d1824%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637135296167400253&amp;amp;sdata=3DnHLXbyqZO2YNTyE4nTw4SP9ldcZqX=
ijxZuGMSDWPxHM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296B389D332B3E147AA4D4CA23D0MN2PR12MB3296namp_--

--===============0575002589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0575002589==--
