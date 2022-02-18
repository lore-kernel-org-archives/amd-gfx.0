Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B0DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B41810E19A;
	Fri, 18 Feb 2022 14:44:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1CE10E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOGCsWPOpuVxXsJebmOLyTSNf/ulmSCGFWOrMxUexI4BITVcmYoL06/t3P2oBB02j2YaPrPhLcbW3YsQSVxIt7rlOKmA+5t2NZQr3FD/mMVvdjfNUKhOoCc7yqQAl1jInFD6z/MMjZ7+wLC+9xezKOqNXaGFKzUp30oeX+3ZHVBOW67TDzqelsZbs0PHiLMl8fx4Cl1G0KREWpXny0JOAJL8p515mOf02IEg3at7UTwlgROsNopDoYLuXVsxGMKQnd7uzyrfz6VzcCu4LF6JPr0Fob8j+t3yLC/hL5E4ptXqFAuMW//N68K+frtnKAoWyHeUX3dnnmIXkaFWWDhItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePwkVGRbpYVI+feFk2F0Pa53r0o9sA4OvgmVTedv2w0=;
 b=KPvvQOdDF11ohwTkDEvRFMhWT2ZLAU77e9C/e+jeqklb+TSDBQxdKLaFY+YxDSM8rycjow/wdQRDZPCz1DLxiBWujoYxR+Y8L4CI7oSMwx0+omn/VYLaubTQal0UFtDgBsi1j55vvhSu+eCqtuPxjCo7prPcoJj+p7ayQ7hZZbcemeGsiK0cms0ok8vGw/YM9w7Tk9NkvNXQHYHr/UWq/mnnkg0aYZ27FEL0276MuehUX/vzt242sujg4Y99L+yt0uuO4U8SE/HNxFX77NXsmGsOgSaRSh7RWNnwqrhXAhuJljhNUpaqtsYnW5ebX3otSbSc8GhrHyn1WAoQYcRFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePwkVGRbpYVI+feFk2F0Pa53r0o9sA4OvgmVTedv2w0=;
 b=hDRlY2e+tGpQaFrQZoyJ1XcH2ykVE/P2iIG4zFsz/eht7uAwP3xhbbj8ycDS75o6bSUUyk/WFbfJXEeqcT1kbuISVXah7AN8w+6sXwYSBhbkLLhwMvmMzIfh0Er6A3ZvYR0UBrgoK3bReURVtv37DXmXI96N386EB7q5jt13+vg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB2633.namprd12.prod.outlook.com (2603:10b6:5:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23; Fri, 18 Feb
 2022 14:44:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 14:44:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Topic: [PATCH v2] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Index: AQHYJJYsIipxEOl2dUC1gkZEM62nxKyZYrJB
Date: Fri, 18 Feb 2022 14:44:06 +0000
Message-ID: <BL1PR12MB5144F5F37836F9629FE59BDEF7379@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1645167889-18759-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1645167889-18759-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T14:44:05.814Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 1a642342-532a-6a71-4576-0a9ac885e804
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27927bfb-93c8-4e43-f7cb-08d9f2ed1d80
x-ms-traffictypediagnostic: DM6PR12MB2633:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2633EF5BEF560304DAA2CE15F7379@DM6PR12MB2633.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOSWWjk0ErC/JwLnIvuVk9fOaioQ5wNHkVvapxtPaLnC1b3i1/MqqHkyhI5T2bJ7VgTExTEIMkGjwe5GykTVVZdMo/G8cUxGW+5CzEmD3Y7uaGbyo1V/S6GAJHqoaKGSKjhwKxVatUVpVdCc5jC88CcnYYVmvQIJmQMCoySTXkh8B5Rx99tCAvyfr8jHdHrpGFgBtYHyxQBLcd5UW/CC2OyZGya+tAYmFc19S398kU9aIN55FN/CG0xCDbLZ/ujofBQ3oCDB5kbmdhgkLGsEyH7hue8X8NRFdY688D/BLNwmhtenFzztcHP6EfG919ihd4Ix/NCiY7RYVqj9HYO/OmcxfRH1oudYvwYh7NJCoE47xsCJJJkpuoYYQox0m08kSxWZVa8JZqRoj2VGv9X4dIhN1ZAXCDtByiJ+0yv1Vvob7F3Olbc4TBEDoVk3uf71gXCw2TLzVr6yUHPjBHCVrPOpHb7/qQbI6L8sDO0B68ORIuPVfAs2C++oSHc4DEqNx5P/ge+quQ9Nf4Xn+Zns5jXsTnTgyS2zUvQxbbR6/2jUTnY4w4CunhWhdQyMK8ixoXrF3NmRjd1j72imq26AvbvrQSdnjHFw6O5O0Lemj8RUccHtDO4E5xrTuwPbIuOmVniR7uS3iPvVLBQob0WjpieOet4qFeC6SJFuC4qw9iRKgCIst41rxC68Gzn439+7DZzyjNZDSjhOx5ILs/Ebpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(52536014)(15650500001)(8936002)(83380400001)(5660300002)(86362001)(508600001)(6506007)(33656002)(55016003)(7696005)(9686003)(316002)(2906002)(38100700002)(71200400001)(186003)(110136005)(26005)(8676002)(66476007)(66556008)(64756008)(76116006)(53546011)(54906003)(66946007)(19627405001)(66446008)(122000001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ES2JT2rVYZO8hBeSEUdo4vz0irpgS9TUbz/gsmh6t9V7tF/lHpmuDL4Y9D4y?=
 =?us-ascii?Q?1YmA7b2F+WXe1JLuX6Yg/GpQm6f9kNAntbvSY1/JDcuMgFeppRmMWKFiLIr2?=
 =?us-ascii?Q?/aGoNiVkFqA+IyNxKZgXc2Y+MF+gw0t51huOayUSWJB4YrMs6e84fgCNffyg?=
 =?us-ascii?Q?cM74XTPw1yF6/rk6K1GcmdirZhf9J1u8ATfwEq7Lsiu+9FVUqP9pPQn59lfC?=
 =?us-ascii?Q?+51nvvAU9R3QfDFwOWCqVOUTYlxthZFOZQgjM9fA187fPfVk6coRIVhwnXmx?=
 =?us-ascii?Q?0wejPTHLD76KeLUkG+EoNgN5XsFfJ4RNz0ad4tnm49QJSEUvzWtbEN2ymFHh?=
 =?us-ascii?Q?F37fStshIe8IZqsOc3VZVDoM94d8O4VvB6F/3N1HGaOwX/J0cOT3AEtMs2lP?=
 =?us-ascii?Q?LCFjl+JeUk6M4jvaL+/BP9DtGtPX0AdkQ16uakCGjp+yEyuk+4v7AwSu91MT?=
 =?us-ascii?Q?fTvchmkVO0ahWDzGc8YlxHS4bKCcTiKSkzHXoO+gHyJGzH6iOXiHpiSs5Sfp?=
 =?us-ascii?Q?+jmQYqo9KEVCXdEH9Q214J6rnz13m5g1WjQmDYO/3SHN6iFQjRptoAEi5HT6?=
 =?us-ascii?Q?7xxmS5ZyNDfBb3ZD6hGuSkOneOT33gFFZZxjWwbzFM/o5B698+ysyMYRhyf6?=
 =?us-ascii?Q?PRz0WehnazojE6fZmqcUx5wb2SGY0g7sKxNGY562+WmpfW++kPwBOza6js9e?=
 =?us-ascii?Q?mY+PNzucGvYx4fcsnK6Gt5T26ZRO4cF5ZUCyCVoNo7wCJqs8GIm2OIfRoV7C?=
 =?us-ascii?Q?WsmSntWzudXf15nG/oPYFAmMK0fltl8QV01Q1tQRxn5GQi0ZtuJ2wYbQAeje?=
 =?us-ascii?Q?RPuL60XILx/QgTTDMrKVUNTaAbVnnI46ZuLmAKrBqFd2TNfaFbnrZlY4o1Tr?=
 =?us-ascii?Q?rxCJ3MbOIkOQ2zR9dCAqOhS+UjcrdxkPkUcNx4ed464qKe/yT1M/PJ1UGaum?=
 =?us-ascii?Q?EvqqaXb4H1E241Gy8dAK1zsP3eheRpY+sBdQohGvVuGh5WMBN64UkiZ8CjLu?=
 =?us-ascii?Q?kdZvVP7sjuCKJ5x+Ni+iHbxnQtUMmIEDSC7Qqv+27hM9nCZzkFCWRLV0pNWg?=
 =?us-ascii?Q?PXcR4THbpjGMD+XFGiAJFYyD0HA+LrS7MmDJyLzjdKc+YASCnWmEJpoXynNZ?=
 =?us-ascii?Q?cMu92ZIun38DF55uVPbA2nXqn48W2PXrJ7euDmzOJOB8r0+jfzohBaxQ7Jpp?=
 =?us-ascii?Q?zIuD8r3ZwPU7F8+L2sOR1KKSOXs1Neeh84qaI9ytBCQIbsJTboBhMBAkXCfp?=
 =?us-ascii?Q?TlPmXdohVOHJ93NixTXWOlrwbVmvTgNi7QfApQyJOrCja4ctQtAuwZw9yneZ?=
 =?us-ascii?Q?/d2zwXUr4STwBB69p+HV/WCXGfvzYUGdif2Msev6Dt8ainWfdPFvG0fNF8BY?=
 =?us-ascii?Q?gebqkVlZ3CqTxkyMcO2ojvKLihDTrGLrBqtV87CKYlpA3i+6v/f1+kATZJaJ?=
 =?us-ascii?Q?lvKFmiXcuHXtmQ8kqt+I27j7A5Cexc33J/oarwYua2uTsIKXhhyiszB6ybeQ?=
 =?us-ascii?Q?+opdu8IETM4tiuWb8yNd5VyrTdSma5V1671GLPV/2v4jPid9r48iwhMvzgW8?=
 =?us-ascii?Q?u33JV8u58QTXkXABfJv8bAf+qPhzEXQAmBQBrPSknZ57s8Ig6OSVVt7FLzXQ?=
 =?us-ascii?Q?vr4/Hu5c/0+7rczMYo6Xfc8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F5F37836F9629FE59BDEF7379BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27927bfb-93c8-4e43-f7cb-08d9f2ed1d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:44:06.4861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpXvd8i7Rq2r0xfF/mmPx5E9J5NgQgIYbgptEDyufCxUnJBs1rX5WTnxG0dxS9YvBevhh452xfgDc+X2NtPdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2633
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F5F37836F9629FE59BDEF7379BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Prike Li=
ang <Prike.Liang@amd.com>
Sent: Friday, February 18, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.co=
m>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH v2] drm/amd/pm: validate SMU feature enable message for get=
ting feature enabled mask

There's always miss the SMU feature enabled checked in the NPI phase,
so let validate the SMU feature enable message directly rather than
add more and more MP1 version check.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 12 ++++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 12 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 48 ++++++++-----------
 3 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index b3a0f3fb3e65..f1a4a720d426 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -552,6 +552,16 @@ static int cyan_skillfish_get_dpm_ultimate_freq(struct=
 smu_context *smu,
         return 0;
 }

+static int cyan_skillfish_get_enabled_mask(struct smu_context *smu,
+                                          uint64_t *feature_mask)
+{
+       if (!feature_mask)
+               return -EINVAL;
+       memset(feature_mask, 0xff, sizeof(*feature_mask));
+
+       return 0;
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs =3D {

         .check_fw_status =3D smu_v11_0_check_fw_status,
@@ -562,7 +572,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_fu=
ncs =3D {
         .fini_smc_tables =3D smu_v11_0_fini_smc_tables,
         .read_sensor =3D cyan_skillfish_read_sensor,
         .print_clk_levels =3D cyan_skillfish_print_clk_levels,
-       .get_enabled_mask =3D smu_cmn_get_enabled_mask,
+       .get_enabled_mask =3D cyan_skillfish_get_enabled_mask,
         .is_dpm_running =3D cyan_skillfish_is_dpm_running,
         .get_gpu_metrics =3D cyan_skillfish_get_gpu_metrics,
         .od_edit_dpm_table =3D cyan_skillfish_od_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index e99e7b2bf25b..fd6c44ece168 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1366,6 +1366,16 @@ static int renoir_gfx_state_change_set(struct smu_co=
ntext *smu, uint32_t state)
         return 0;
 }

+static int renoir_get_enabled_mask(struct smu_context *smu,
+                                  uint64_t *feature_mask)
+{
+       if (!feature_mask)
+               return -EINVAL;
+       memset(feature_mask, 0xff, sizeof(*feature_mask));
+
+       return 0;
+}
+
 static const struct pptable_funcs renoir_ppt_funcs =3D {
         .set_power_state =3D NULL,
         .print_clk_levels =3D renoir_print_clk_levels,
@@ -1390,7 +1400,7 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {
         .init_smc_tables =3D renoir_init_smc_tables,
         .fini_smc_tables =3D smu_v12_0_fini_smc_tables,
         .set_default_dpm_table =3D smu_v12_0_set_default_dpm_tables,
-       .get_enabled_mask =3D smu_cmn_get_enabled_mask,
+       .get_enabled_mask =3D renoir_get_enabled_mask,
         .feature_is_enabled =3D smu_cmn_feature_is_enabled,
         .disable_all_features_with_exception =3D smu_cmn_disable_all_featu=
res_with_exception,
         .get_dpm_ultimate_freq =3D renoir_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index f24111d28290..33151983d9ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -59,6 +59,12 @@ static const char * const __smu_message_names[] =3D {
         SMU_MESSAGE_TYPES
 };

+#define smu_cmn_call_asic_func(intf, smu, args...)                        =
     \
+       ((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ?                      =
    \
+                                    (smu)->ppt_funcs->intf(smu, ##args) : =
    \
+                                    -ENOTSUPP) :                          =
    \
+                           -EINVAL)
+
 static const char *smu_get_message_name(struct smu_context *smu,
                                         enum smu_message_type type)
 {
@@ -493,6 +499,12 @@ int smu_cmn_feature_is_supported(struct smu_context *s=
mu,
         return test_bit(feature_id, feature->supported);
 }

+int __smu_get_enabled_features(struct smu_context *smu,
+                              uint64_t *enabled_features)
+{
+       return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_featur=
es);
+}
+
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
                                enum smu_feature_mask mask)
 {
@@ -500,7 +512,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
         uint64_t enabled_features;
         int feature_id;

-       if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+       if (__smu_get_enabled_features(smu, &enabled_features)) {
                 dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!=
\n");
                 return 0;
         }
@@ -552,10 +564,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *sm=
u,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
                              uint64_t *feature_mask)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         uint32_t *feature_mask_high;
         uint32_t *feature_mask_low;
-       int ret =3D 0;
+       int ret =3D 0, index =3D 0;

         if (!feature_mask)
                 return -EINVAL;
@@ -563,12 +574,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
         feature_mask_low =3D &((uint32_t *)feature_mask)[0];
         feature_mask_high =3D &((uint32_t *)feature_mask)[1];

-       switch (adev->ip_versions[MP1_HWIP][0]) {
-       /* For Vangogh and Yellow Carp */
-       case IP_VERSION(11, 5, 0):
-       case IP_VERSION(13, 0, 1):
-       case IP_VERSION(13, 0, 3):
-       case IP_VERSION(13, 0, 8):
+       index =3D smu_cmn_to_asic_specific_index(smu,
+                                               CMN2ASIC_MAPPING_MSG,
+                                               SMU_MSG_GetEnabledSmuFeatur=
es);
+       if (index > 0) {
                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                       SMU_MSG_GetEnabledSm=
uFeatures,
                                                       0,
@@ -580,19 +589,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
                                                       SMU_MSG_GetEnabledSm=
uFeatures,
                                                       1,
                                                       feature_mask_high);
-               break;
-       /*
-        * For Cyan Skillfish and Renoir, there is no interface provided by=
 PMFW
-        * to retrieve the enabled features. So, we assume all features are=
 enabled.
-        * TODO: add other APU ASICs which suffer from the same issue here
-        */
-       case IP_VERSION(11, 0, 8):
-       case IP_VERSION(12, 0, 0):
-       case IP_VERSION(12, 0, 1):
-               memset(feature_mask, 0xff, sizeof(*feature_mask));
-               break;
-       /* other dGPU ASICs */
-       default:
+       } else {
                 ret =3D smu_cmn_send_smc_msg(smu,
                                            SMU_MSG_GetEnabledSmuFeaturesHi=
gh,
                                            feature_mask_high);
@@ -602,7 +599,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
                 ret =3D smu_cmn_send_smc_msg(smu,
                                            SMU_MSG_GetEnabledSmuFeaturesLo=
w,
                                            feature_mask_low);
-               break;
         }

         return ret;
@@ -696,8 +692,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *=
smu,
         int ret =3D 0, i;
         int feature_id;

-       ret =3D smu_cmn_get_enabled_mask(smu,
-                                      &feature_mask);
+       ret =3D __smu_get_enabled_features(smu, &feature_mask);
         if (ret)
                 return 0;

@@ -749,8 +744,7 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,
         uint64_t feature_2_enabled =3D 0;
         uint64_t feature_2_disabled =3D 0;

-       ret =3D smu_cmn_get_enabled_mask(smu,
-                                      &feature_mask);
+       ret =3D __smu_get_enabled_features(smu, &feature_mask);
         if (ret)
                 return ret;

--
2.17.1


--_000_BL1PR12MB5144F5F37836F9629FE59BDEF7379BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Prike Liang &lt;Prike.Liang@a=
md.com&gt;<br>
<b>Sent:</b> Friday, February 18, 2022 2:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liang, Pri=
ke &lt;Prike.Liang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Hua=
ng, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: validate SMU feature enable message =
for getting feature enabled mask</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There's always miss the SMU feature enabled checke=
d in the NPI phase,<br>
so let validate the SMU feature enable message directly rather than<br>
add more and more MP1 version check.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Signed-off-by: Lijo Lazar &lt;Lijo.Lazar@amd.com&gt;<br>
---<br>
&nbsp;.../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c&nbsp;&nbsp; | 12 ++++-<br=
>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp; | 12 ++++-<br=
>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 48 ++++++++-----------<br>
&nbsp;3 files changed, 43 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
index b3a0f3fb3e65..f1a4a720d426 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
@@ -552,6 +552,16 @@ static int cyan_skillfish_get_dpm_ultimate_freq(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int cyan_skillfish_get_enabled_mask(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; uint64_t *feature_mask)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(feature_mask, 0xff, sizeof(*fe=
ature_mask));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs cyan_skillfish_ppt_funcs =3D {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v=
11_0_check_fw_status,<br>
@@ -562,7 +572,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D smu_v=
11_0_fini_smc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D cyan_skil=
lfish_read_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D cyan=
_skillfish_print_clk_levels,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D cyan_skillfish_=
get_enabled_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D cyan_s=
killfish_is_dpm_running,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D cyan_=
skillfish_get_gpu_metrics,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .od_edit_dpm_table =3D cya=
n_skillfish_od_edit_dpm_table,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index e99e7b2bf25b..fd6c44ece168 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -1366,6 +1366,16 @@ static int renoir_gfx_state_change_set(struct smu_co=
ntext *smu, uint32_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int renoir_get_enabled_mask(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *feature_mask)<b=
r>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(feature_mask, 0xff, sizeof(*fe=
ature_mask));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs renoir_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_state =3D NULL,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D reno=
ir_print_clk_levels,<br>
@@ -1390,7 +1400,7 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_smc_tables =3D renoi=
r_init_smc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D smu_v=
12_0_fini_smc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 smu_v12_0_set_default_dpm_tables,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D renoir_get_enab=
led_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .feature_is_enabled =3D sm=
u_cmn_feature_is_enabled,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_all_features_with=
_exception =3D smu_cmn_disable_all_features_with_exception,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dpm_ultimate_freq =3D=
 renoir_get_dpm_ultimate_freq,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index f24111d28290..33151983d9ea 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -59,6 +59,12 @@ static const char * const __smu_message_names[] =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MESSAGE_TYPES<br>
&nbsp;};<br>
&nbsp;<br>
+#define smu_cmn_call_asic_func(intf, smu, args...)&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs ? ((smu)-&gt;ppt=
_funcs-&gt;intf ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu)-&gt;ppt=
_funcs-&gt;intf(smu, ##args) :&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -ENOTSUPP) :&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; -EINVAL)<br>
+<br>
&nbsp;static const char *smu_get_message_name(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum smu_message_type type)<br>
&nbsp;{<br>
@@ -493,6 +499,12 @@ int smu_cmn_feature_is_supported(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_bit(feature_id=
, feature-&gt;supported);<br>
&nbsp;}<br>
&nbsp;<br>
+int __smu_get_enabled_features(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *enabled_features)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_call_asic_func(get_ena=
bled_mask, smu, enabled_features);<br>
+}<br>
+<br>
&nbsp;int smu_cmn_feature_is_enabled(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_feature_mask mask)<br>
&nbsp;{<br>
@@ -500,7 +512,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t enabled_features;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_get_enabled_mask(smu, &am=
p;enabled_features)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (__smu_get_enabled_features(smu, &=
amp;enabled_features)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to retrieve enable=
d ppfeatures!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -552,10 +564,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *sm=
u,<br>
&nbsp;int smu_cmn_get_enabled_mask(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *feature_mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_low=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -563,12 +574,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_low =3D &amp;=
((uint32_t *)feature_mask)[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_high =3D &amp=
;((uint32_t *)feature_mask)[1];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Vangogh and Yellow Carp */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 8):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D smu_cmn_to_asic_specific_in=
dex(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMN2ASIC_MAPPING_MSG,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuF=
eatures);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeatures,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
@@ -580,19 +589,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeatures,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_high);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Cyan Skillfish and Renoir=
, there is no interface provided by PMFW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to retrieve the enabled featu=
res. So, we assume all features are enabled.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: add other APU ASICs whi=
ch suffer from the same issue here<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(feature_mask, 0xff, sizeof(*feature_mask));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* other dGPU ASICs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeaturesHigh,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_high);<br>
@@ -602,7 +599,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeaturesLow,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_low);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -696,8 +692,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;feature_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D __smu_get_enabled_features(sm=
u, &amp;feature_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
@@ -749,8 +744,7 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_enabled=
 =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_disable=
d =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;feature_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D __smu_get_enabled_features(sm=
u, &amp;feature_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F5F37836F9629FE59BDEF7379BL1PR12MB5144namp_--
