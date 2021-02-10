Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF4C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 13:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA55564E77
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 13:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA55564E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFD76E2C0;
	Wed, 10 Feb 2021 13:40:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F0A6E2C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 13:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSdpR+avE2F6vg2Qk7J+1/mqp/NIAqSRnxlVmLu66rO8nzn9fGKILihj3yaB4caR5/l0syvsQT8g2Nvq/Rr43QdX9wZjvqDjWPkru6tspRYeV81NwsuoFWtGZIxAsmjlFGPDGaLdQuMcaWVv5f5YPWnP1Q/49Pmqs5c4W7Yk91K0rMa1Athv/STjWehyBSKJ/v798bQv7ybDUPECe/AnXa+OhL/V1GEKTV4l1AmGDzMNQ3PqH5sVi+OAqVj337xM2jR7PYFNgI9fyAK9MtmRzE4AzeT1QZEbh/00E46ttQ9X1/1iS8grZshavyQvjR3X0FSlTeI5EUjlaa09JWDeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbyomA6aKfoPi5bpDEbZQb1286iW1WAm3KJgiMwMY8E=;
 b=SYvN5D6E72tsnvdfsKyOz/neglYMimI5gBBwbJ4Oiqn1KaQg1rAnIma6C9a+ma17D2vzLtsIuVCYCWn8PpNqWaaqMzsHrYtSXwcrSZQMYRtde8a+Fz8pJqyeepbkzonNw1RAbsEuVNGGsSWzWBBroHxig4tw1q2jtj00+P1ejDuylmbib3mZo4eBbLvea0qQYJOYwGl3bQLU2zZ4Nk/1OaPYLYZG65ttV1plkyTu/bxmEwErJWqjcvOVXyxwQLg491PTOw1ui2FiR5+bnDCjp9R6ecJjO7ndwEBQ4zujGbCGqZYLK+ErUzeqvxKl6PGMYkU+GSzlfXLy+0AtK6UqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbyomA6aKfoPi5bpDEbZQb1286iW1WAm3KJgiMwMY8E=;
 b=aMkR18hrU811TEfPTTrgXD/TPmQWNxv1yYz6E/SnTzYrOBrkwB5kXsFvmtO+5rNNZKyrxK8xNwOMfP/Snaw5Bm/kaDxbVZRSi6C9Nf8ygOztu5fqgNLQ5GxszmtdAhNvDUKJCigRnmaxE7rIUP2SyU7NET0U5RY+qzxNIuj99t8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 10 Feb
 2021 13:40:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%8]) with mapi id 15.20.3805.038; Wed, 10 Feb 2021
 13:40:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: do not issue message while write "r" into
 pp_od_clk_voltage
Thread-Topic: [PATCH] drm/amd/pm: do not issue message while write "r" into
 pp_od_clk_voltage
Thread-Index: AQHW/2b9vLYMwZ7fREeuwm6ZtwHGfKpRZY66
Date: Wed, 10 Feb 2021 13:40:00 +0000
Message-ID: <MN2PR12MB4488799A9430A2BA408CA9BCF78D9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210210044104.3941828-1-ray.huang@amd.com>
In-Reply-To: <20210210044104.3941828-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-10T13:40:00.285Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb1c3fe7-315a-410e-1293-08d8cdc95d63
x-ms-traffictypediagnostic: MN2PR12MB4485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB448543E527833C648DBC1D67F78D9@MN2PR12MB4485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +o9MUN3NwlAV00pNxmr5GL5umdyZxQ4HIvn4JbrHoEOGs7+VLCq1yBk/V/xheBSMYUuTcAFmk4dSC6YJM5ybMbCt++8ZipBocn3rcL8auALk8UlCIj21aR2EtPvPgQOby+b97etvffgCtizjloVWV2+MkO/3HHcDMFMoIWqoiNU2xDRZdaysZT+eydc3srgIf1pK04m19nvWaA6TipED9D+CU4gmwR9pbnf31giutaE5qV3uP428Wik8OD2b+H6Me/op5xaDXHhpSPw0YJKH+miVQ6uC/GPpKmxjp9/10U2Q3iCOH9VaE/BkRUC5g/f3RX6+l2I8nOijaUjjyWbLz5s5Fn8C8diOpZJ3EpE1/1RYImpYTWD1K94u5nMPguChLxxBkswooWkGbdgs9iUyrFSMEBL5plOAi+8r2X7JFn+wpw9BUXtoVE5OY+FLkmrKnQivLLEOQpbMr/1tBO4y8SaU1aoxM1FjvLmibKCtdepxWgB2sk2IZ/FTd2+hXVjBxcLYq//3Xz3EjKUmK6RGUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(71200400001)(4326008)(8676002)(2906002)(110136005)(66446008)(64756008)(66556008)(66476007)(52536014)(6506007)(53546011)(33656002)(83380400001)(76116006)(19627405001)(478600001)(7696005)(5660300002)(26005)(86362001)(8936002)(66946007)(9686003)(15650500001)(316002)(55016002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N847TufQTKhWWWMdFhpMGbp7jMVlXV7vXrJYQqPrEZO+duTR5g+KOfHKg8Jw?=
 =?us-ascii?Q?kKLQw+4KQXcRZ+w5FdimMxHBrWzk75P0smJXhWtQ2i+VNSFq1nYPVLRewYW4?=
 =?us-ascii?Q?5xZDj5Hgz+PUXfHdZ5hJ8ObplXl72s7fSpHF4UKNZuQpbdcbwR288Vs7/Jem?=
 =?us-ascii?Q?KU1aD4kXf7cQ8Aelo1fMWA5/YxMcnUW1HddAJZSc+DiU+3WOF0kpzdASJ0C8?=
 =?us-ascii?Q?MY7USIPZtn6BIe6XJ9QBF+0JhlAIg21RxoWPsOwHp70uR4aTkdAgPI84n2Wd?=
 =?us-ascii?Q?dQ12TH0jqODhm3llp3DN9Jbe3hw8FOBD9xeYN3lXmdkxjAFyWnbtteb1Trl4?=
 =?us-ascii?Q?sDFLgk1xA2ukpVP6Jr5wrcNe+bYW0K23tTcm2MzQfAqCYbnzN+2opJuM2fZN?=
 =?us-ascii?Q?A06CtLScM+qbXHL+m2uW37NYmIobgXeHFdY4vx9kNFA2hx2QTe8x/E7G8uec?=
 =?us-ascii?Q?32mV7yoBDJhfws1SiJ2/Ml2Z81YDucIuVzo7sH3XaxBb8BnaDLyn7PE0ipZu?=
 =?us-ascii?Q?8zhG7J8g65fHDxzbXyR6zem3nk6hIS76vNs9xyJoRuoZU/NK4O/2PN+xWIAN?=
 =?us-ascii?Q?uARPnDjc6B93tuj2fiNa0muLltjb4hc3x5xMAq8oU/yN+J1ws9f4T2sevvlJ?=
 =?us-ascii?Q?wV8tw2p9V95MD6PSg9czeh+mMZ4t4TRfcusIl0FXXznJlRolIljlrKl/58I6?=
 =?us-ascii?Q?0fYkVbC6JcUaMchL0TDufR8+I9fZt3N85B5467Ioh6/O2KwRdPea9Dm9chPY?=
 =?us-ascii?Q?K4Mecs/juaK9rA4v6es/Byys7UExA6/oU5EXkISZV32eXHY28V+1kEy2/5Sj?=
 =?us-ascii?Q?1UD9evVvPdH+irwSzqmfCWKcMwW80rsh7UeHHhA8Fu1COSLk2lb3bAr7AZM3?=
 =?us-ascii?Q?bGe3fQAyrcyrAE2ETohtoBi7DaBCA4Jj3of4inm5anWrvO1rc1lhZrbDKfSw?=
 =?us-ascii?Q?uqwMzJgO/nSrzRP5htAQMdFZaHvpfLw0rGtzjW1FKZ4gsdT+sjeA/KPfLnsR?=
 =?us-ascii?Q?29hiNH3ikYgLdslHq7sdgAxnwKDccnqM1QiPbJdgfOYg6c7oUaud3fsPiju3?=
 =?us-ascii?Q?B/pMhxIufMHrNA57ZnkJowU8DOtev7ixpD6NBNaH+iJgLvm/aV/IioIWcL1r?=
 =?us-ascii?Q?Z6SlgoCwGtNLEKnB3wSfdb/0s+RPwt3gNHcZyi54k2aATp+KJgrJ7vvuK6qo?=
 =?us-ascii?Q?aVqtNyOEglMrFMslEMRX/XLG3gt3vE3Rtbv3OTfaKd64YAWP/QVVJjhmxnyR?=
 =?us-ascii?Q?Wt8uBi2N7wzVl4Gn+sHIDqbJOp3PXSFbTfpm0H4sjN2E2lFjC3ttN0WDOum8?=
 =?us-ascii?Q?0BuSrYOVyluQQiGdZOb284Jw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c3fe7-315a-410e-1293-08d8cdc95d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 13:40:01.0505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXn5vKJJzJ27hko5FZza/OOrtSy9OYveHoTOLifgaKqtF30NMB8LbTSM64qIMbJkvWrNsZU/6ujlyh0Xug5TNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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
Cc: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: multipart/mixed; boundary="===============1355221840=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1355221840==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488799A9430A2BA408CA9BCF78D9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488799A9430A2BA408CA9BCF78D9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Tuesday, February 9, 2021 11:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: do not issue message while write "r" into pp_o=
d_clk_voltage

We should commit the value after restore them back to default as well.

$ echo "r" > pp_od_clk_voltage
$ echo "c" > pp_od_clk_voltage

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 14 -------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 -------------------
 2 files changed, 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ac7769087f98 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1526,20 +1526,6 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,

                 smu10_data->gfx_actual_soft_min_freq =3D min_freq;
                 smu10_data->gfx_actual_soft_max_freq =3D max_freq;
-
-               ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
-                                       PPSMC_MSG_SetHardMinGfxClk,
-                                       min_freq,
-                                       NULL);
-               if (ret)
-                       return ret;
-
-               ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
-                                       PPSMC_MSG_SetSoftMaxGfxClk,
-                                       max_freq,
-                                       NULL);
-               if (ret)
-                       return ret;
         } else if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
                 if (size !=3D 0) {
                         pr_err("Input parameter number not correct\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f0f06ef47b9e..9315f20da67f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1451,7 +1451,6 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
                                         long input[], uint32_t size)
 {
         int ret =3D 0;
-       int i;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
@@ -1523,43 +1522,6 @@ static int vangogh_od_edit_dpm_table(struct smu_cont=
ext *smu, enum PP_OD_DPM_TAB
                         smu->gfx_actual_soft_max_freq =3D smu->gfx_default=
_soft_max_freq;
                         smu->cpu_actual_soft_min_freq =3D smu->cpu_default=
_soft_min_freq;
                         smu->cpu_actual_soft_max_freq =3D smu->cpu_default=
_soft_max_freq;
-
-                       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MS=
G_SetHardMinGfxClk,
-                                                                       smu=
->gfx_actual_hard_min_freq, NULL);
-                       if (ret) {
-                               dev_err(smu->adev->dev, "Restore the defaul=
t hard min sclk failed!");
-                               return ret;
-                       }
-
-                       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MS=
G_SetSoftMaxGfxClk,
-                                                                       smu=
->gfx_actual_soft_max_freq, NULL);
-                       if (ret) {
-                               dev_err(smu->adev->dev, "Restore the defaul=
t soft max sclk failed!");
-                               return ret;
-                       }
-
-                       if (smu->adev->pm.fw_version < 0x43f1b00) {
-                               dev_warn(smu->adev->dev, "CPUSoftMax/CPUSof=
tMin are not supported, please update SBIOS!\n");
-                               break;
-                       }
-
-                       for (i =3D 0; i < smu->cpu_core_num; i++) {
-                               ret =3D smu_cmn_send_smc_msg_with_param(smu=
, SMU_MSG_SetSoftMinCclk,
-                                                                     (i <<=
 20) | smu->cpu_actual_soft_min_freq,
-                                                                     NULL)=
;
-                               if (ret) {
-                                       dev_err(smu->adev->dev, "Set hard m=
in cclk failed!");
-                                       return ret;
-                               }
-
-                               ret =3D smu_cmn_send_smc_msg_with_param(smu=
, SMU_MSG_SetSoftMaxCclk,
-                                                                     (i <<=
 20) | smu->cpu_actual_soft_max_freq,
-                                                                     NULL)=
;
-                               if (ret) {
-                                       dev_err(smu->adev->dev, "Set soft m=
ax cclk failed!");
-                                       return ret;
-                               }
-                       }
                 }
                 break;
         case PP_OD_COMMIT_DPM_TABLE:
--
2.25.1


--_000_MN2PR12MB4488799A9430A2BA408CA9BCF78D9MN2PR12MB4488namp_
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
<b>Sent:</b> Tuesday, February 9, 2021 11:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Du, Xiaoji=
an &lt;Xiaojian.Du@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: do not issue message while write &quot;=
r&quot; into pp_od_clk_voltage</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We should commit the value after restore them back=
 to default as well.<br>
<br>
$ echo &quot;r&quot; &gt; pp_od_clk_voltage<br>
$ echo &quot;c&quot; &gt; pp_od_clk_voltage<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 14 -------<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 38 -------------=
------<br>
&nbsp;2 files changed, 52 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 88322781e447..ac7769087f98 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1526,20 +1526,6 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;gfx_actual_soft_min_freq =3D min_freq;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;gfx_actual_soft_max_freq =3D max_freq;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetHardMinGfxClk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; min_freq,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetSoftMaxGfxClk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; max_freq,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (type =3D=3D PP_=
OD_COMMIT_DPM_TABLE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (size !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_er=
r(&quot;Input parameter number not correct\n&quot;);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index f0f06ef47b9e..9315f20da67f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1451,7 +1451,6 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; long input[], uint32_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
@@ -1523,43 +1522,6 @@ static int vangogh_od_edit_dpm_table(struct smu_cont=
ext *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_max_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_min_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_max_freq;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_=
freq, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Restore=
 the default hard min sclk failed!&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_=
freq, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Restore=
 the default soft max sclk failed!&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev=
-&gt;pm.fw_version &lt; 0x43f1b00) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;CPUSof=
tMax/CPUSoftMin are not supported, please update SBIOS!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; smu-&gt;cpu_core_num; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu=
, SMU_MSG_SetSoftMinCclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i &lt;&lt; 20) | smu-&gt;cpu_actual_sof=
t_min_freq,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Set hard min cclk failed!&quot;);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu=
, SMU_MSG_SetSoftMaxCclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i &lt;&lt; 20) | smu-&gt;cpu_actual_sof=
t_max_freq,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Set soft max cclk failed!&quot;);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_COMMIT_DPM_TABL=
E:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488799A9430A2BA408CA9BCF78D9MN2PR12MB4488namp_--

--===============1355221840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1355221840==--
