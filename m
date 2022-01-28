Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D539C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E637410EADE;
	Fri, 28 Jan 2022 14:54:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EFD10E9F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx97LfnY7Et/N1+7Y7b+tNKJ66x1rn7oby7ulv6VZ4ebXcaJAGE5MQeLzLhFH7utYsBSA65AOjSm56INFemHZIlrQoRQ28dl8g7RfoRnkv7kngt8u+k0ciOEwSFXD5uul9Ax9muqmPRCrINtZ1Jy1eLjouUG/U+VZi/NpfHi7FVd3MgGBvDEXMFmzExEmG8eZRFU6ayr/6d9fQKVLqof0aBx60TCMARoqXVAfAyXvhn1n3jMV84T0ahKWAs+hG4XQKhitwP7mzuVtxDD5p2W6iindieT3c6jPkKD9S0Ju2JO3XYO82O4lU4AVjEvu16p3/hIbRsKI78s1VWGoxm03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2nfd4Rb+mIbklmpsviteB6qg56uWo35dS1lifNEIvQ=;
 b=nz5RDDZQu8j8lfTz18yeyJFkRblYWR1ei2ZEqP4kjzuw8beGXJsQWr6xWvJsrNqZbyxn1F46mbs+FYcx7eLVqfko32QMP0XS1HMUAkRsr6E8w7G5SFzlH6JlKUo9lzCpDL5IuxIYesSS17HK4rlZvIClICzOzEEGrersDQuoD5oz/slfb9636499dNpBOOHimcg27wSU9nHrB7TRTCxXBAqNNqsMbnGJks4KcqHV5Dz+lzaxejyr03Ebk8+HOYJ3cYbHJo/QhtCYEj6E7fsdY68lZr+PWTi7NCQuNTyGjPxKKEW1Ba0i4pwV3xlddwr2MtntMYV0/6vkxeYuTl9vYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2nfd4Rb+mIbklmpsviteB6qg56uWo35dS1lifNEIvQ=;
 b=kClJ99e/sXHtCLNjGZ6wmnbwzpJOw+iquY7G6MofAQb5sXUf6H+ZBSff2fxhoeLiSVRTeseg+QV1TvChL/wHz+uf0eXCwOf0jumNcdK0llJUtrNjGtIC6yXPDnNRyT9CcEXUxHM5yDl25wHeYNr5UmlQeL2RYv+DJsi4Tq9XfBQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:54:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:54:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 4/7] drm/amd/pm: correct the usage for 'supported'
 member of smu_feature structure
Thread-Topic: [PATCH V3 4/7] drm/amd/pm: correct the usage for 'supported'
 member of smu_feature structure
Thread-Index: AQHYFBVy7fxWyO+XIEG1H812vrESHax4hc47
Date: Fri, 28 Jan 2022 14:54:48 +0000
Message-ID: <BL1PR12MB5144146584DDA9CF1D6F1BADF7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-4-evan.quan@amd.com>
In-Reply-To: <20220128070455.202014-4-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-28T14:54:48.174Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c0a0adff-f409-3eaf-f71d-f9a3612553b6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02b30898-c296-4b35-bf7f-08d9e26e21a3
x-ms-traffictypediagnostic: DM6PR12MB3467:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3467EF26830C2D36CC73CCDEF7229@DM6PR12MB3467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eONOIfHtYeVCtVTcM8kvGj2uK1a/R/6/N4aewI3ZucZmIdX52R+/CCQXQHAEOxywZmwWP4KApwC4cKrQm8kcl8kmKONpieF0Vqt9gNrRq1If9j6/4qr+8hpD3fzk+SKldVvYREZo9KMu1g/Svta6LF4rGlXFwrICj74u2qoPIpyjqGQIna09HF0N8Nzu9lhRkozBJnSgoQmMWYrlXO7tzQyfbfu5uwxqjbKDxnjyAs6A45YBUlIHOUQyo5FHsZOzJ0EQC6JXVD3EXuK52HDYQwTQ0//9eevNaS4PUBrfaKzadRspXP7QpIv7Cj5BpJaP9aYsDeVYI7OoOHhmPPSm9o6Cz1/KUhzHuqAkeBbLAo2FwDuooXdAmvEgPIhCPTpQckvBwNND+3ripWHYqK8Oj46uqbUXET/C52CA2crSz0oPv8P4AGjWgdRrPP8G+xL2jWA6n9JndOC6/5EhYaI1BTTI8hhKITylfegsIkKsGqRuW5SyQbxrGlT4dGJhHAYT2iz6xAlpUuBP4KJ/WjXOX6AlzWhvyIhFCxk+jNuCbdYk9h9Gh5MYUyj3xci5nqQ4Q44N2K0wVedRzJiteWokShI/6Cm4BwqHBM0IPrRnVmNLqmcZor6OigcBTHebuGYtTKoorTbXPHfD3A5o267dsnOWlSu82FYf0zdgqnnUg47qvSS0wKri5PZaisrSOTi0WY/in/6iqA55OoqPFd0V6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(19627405001)(71200400001)(52536014)(7696005)(110136005)(186003)(53546011)(26005)(6506007)(9686003)(508600001)(316002)(33656002)(66556008)(66476007)(66446008)(55016003)(86362001)(83380400001)(38070700005)(66946007)(64756008)(76116006)(4326008)(8676002)(8936002)(5660300002)(38100700002)(122000001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sLoOziKQvBs7V9o41KcdLMzt11EbvRrR7E+gjRBAGntTzfhZNcEPDcMTrZed?=
 =?us-ascii?Q?DgaihKBQ3BHLd8gVTK2wKKtSPoVdlvSlvF9rz5Vlh23MzNmJ3eoCUd29xEvw?=
 =?us-ascii?Q?dfzHm70gJpxGoOdq7ElU5URqX1fxbFLlzPy+9lEFPJgCI0B+vyMJEe61k4co?=
 =?us-ascii?Q?Sd4yKWk22yytPwl7XmMYztlrbZ3qxMafUiRG44SxUiYuBR6IFXnb+GkbEWGg?=
 =?us-ascii?Q?68Q7wXUAzs+dNutJsxw6pff6FTxkbtaMy+9uXKqae7AuB+NhZl80WYVn+/fV?=
 =?us-ascii?Q?uCrRtUIGvwM5/n/2GAeLsZym1+xHBFuro+JggztPL4ZgeOyk1pmsrnOSoOiv?=
 =?us-ascii?Q?GXepX/+AgqXSPUU81YAlcUM6Nxn25WsqON8BLRpyNVFQvtU9VzF/PN2mBfPY?=
 =?us-ascii?Q?A1ok64nlWBOcBpfoxpYK/zBCvwMzBjQKpabdZz1JCOyFzZyKJ7GxcNg/j46o?=
 =?us-ascii?Q?p5U5njCGqKKnVyrRW311rrotzJUN75RFOXCaQSBA9vg9B2iTZyA21O/g8Bot?=
 =?us-ascii?Q?ddMG0+YdNudXwNE64wS12n8N/wVGEx/Y5JReBW8xcmh5IS4h20P2f1EuurDD?=
 =?us-ascii?Q?ccWfDzx4lEBh8K/HQ2EuKMeQRJvnr68V84T7uzaxBH9UiHMzvkj+uWKpSF14?=
 =?us-ascii?Q?WqNM4Ie8etXyozKe6G4HkKFuPtiFvkIPhFqdXDr3bNzWTFlbDz5Y/Z8O7Ul9?=
 =?us-ascii?Q?wFL7Ulnw3yWHQjMQiybFQdfPsLpFcBqFhEj7+MhdSToGy353aD0P2VH1t166?=
 =?us-ascii?Q?txJviie44w7fCxl05gpzKmmkEsKZdbJGylZ3XX7ql2fSGB2LWvSbN/M6sZMn?=
 =?us-ascii?Q?/mX+qDpbJTfG6idoIlzXz+LpVa/MdG60Q1xmAIztJbU40UR2ziRaG2wWvMP9?=
 =?us-ascii?Q?VzcyJxZ1rt/XoxNL8Z76jCUfDE4B91Ch3pv1K51d33yqIEHt/KpsGFueCA3z?=
 =?us-ascii?Q?IFKDwvJyQ2DjygOGqAalqiMf9YysWryLAc7OZQSh9/uRYhzM/8XdcKVdKx9O?=
 =?us-ascii?Q?iXExVupMGLlZjeN9ZGKpWwt08wnDZhB6M3h6nfME1Y06+2PWq/VnM8OmGZm1?=
 =?us-ascii?Q?ETXG/fBJCYaYDdc0A76IIKjF649BZn70vIjlto9GfEuO2w5tguNtzLAZWGdD?=
 =?us-ascii?Q?htw96QBvbm6j0OmF8fpw6Yc25/S6PZM135F1JXDTHfOaulegZMSWPDfUbFNr?=
 =?us-ascii?Q?w6ki4wA2vrhEmmDRtvyw5vJ4ggcnpQgaR0v7nZq+oSRUDmCTI7g/O5YyRTwD?=
 =?us-ascii?Q?I1LyA6fsLW7B9KE6NTGdcHRQpvGYcbKkieiSQMqHQkvkQTH2S35BdexXqcb8?=
 =?us-ascii?Q?HL225w709sefwwa8o3Q66moJyyWFHsaaoGLuOofCBW0QH6jdZQ5VWOR1IgNU?=
 =?us-ascii?Q?9hiU2KVwz53qAZ1kiYm/DTwz9mO2P6Byq2/c9wM+LD/8MsIU07jXu7h/kZrp?=
 =?us-ascii?Q?usmfRjV0zm9Xi9w+9kH39zSLJ89PqQ+DvRxXVv/sAxvSN22jS/B30cDm2oUe?=
 =?us-ascii?Q?QziuoypPJ8cf2OazlP+9v8e8yEz7XZ+yXCcz50qUyKW+4qjlIX7SNx3T1i+Q?=
 =?us-ascii?Q?VD7eItOWM55ijm1vFeijnpBvoPI1Miu/uxvrmQekui/JbfqloabwAYZDHdd+?=
 =?us-ascii?Q?g1k3auzyR8eVPFq69/0tJEM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144146584DDA9CF1D6F1BADF7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b30898-c296-4b35-bf7f-08d9e26e21a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:54:48.7357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpZ3W45jJ2xCFsmZlnBuekhA/2MGwV5Cfo0nfoz9HactobJJJnKr07rydgXZJN2jBVCDhbmhNBJODjcYhptWkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144146584DDA9CF1D6F1BADF7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, January 28, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V3 4/7] drm/amd/pm: correct the usage for 'supported' membe=
r of smu_feature structure

The supported features should be retrieved just after EnableAllDpmFeatures =
message
complete. And the check(whether some dpm feature is supported) is only need=
ed when we
decide to enable or disable it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c       |  8 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c      |  5 +----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c        |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ae48cc5aa567..803068cb5079 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1057,8 +1057,10 @@ static int smu_get_thermal_temperature_range(struct =
smu_context *smu)

 static int smu_smc_hw_setup(struct smu_context *smu)
 {
+       struct smu_feature *feature =3D &smu->smu_feature;
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t pcie_gen =3D 0, pcie_width =3D 0;
+       uint64_t features_supported;
         int ret =3D 0;

         if (adev->in_suspend && smu_is_dpm_running(smu)) {
@@ -1138,6 +1140,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
                 return ret;
         }

+       ret =3D smu_feature_get_enabled_mask(smu, &features_supported);
+       if (ret) {
+               dev_err(adev->dev, "Failed to retrieve supported dpm featur=
es!\n");
+               return ret;
+       }
+       bitmap_copy(feature->supported,
+                   (unsigned long *)&features_supported,
+                   feature->feature_num);
+
         if (!smu_is_dpm_running(smu))
                 dev_info(adev->dev, "dpm has been disabled\n");

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 84cbde3f913d..f55ead5f9aba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1624,8 +1624,8 @@ static int navi10_display_config_changed(struct smu_c=
ontext *smu)
         int ret =3D 0;

         if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-           smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) =
&&
-           smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) =
{
+           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
                 ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOf=
Displays,
                                                   smu->display_config->num=
_display,
                                                   NULL);
@@ -1860,13 +1860,13 @@ static int navi10_notify_smc_display_config(struct =
smu_context *smu)
         min_clocks.dcef_clock_in_sr =3D smu->display_config->min_dcef_deep=
_sleep_set_clk;
         min_clocks.memory_clock =3D smu->display_config->min_mem_set_clock=
;

-       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT))=
 {
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
                 clock_req.clock_type =3D amd_pp_dcef_clock;
                 clock_req.clock_freq_in_khz =3D min_clocks.dcef_clock * 10=
;

                 ret =3D smu_v11_0_display_clock_voltage_request(smu, &cloc=
k_req);
                 if (!ret) {
-                       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_D=
S_DCEFCLK_BIT)) {
+                       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_=
DCEFCLK_BIT)) {
                                 ret =3D smu_cmn_send_smc_msg_with_param(sm=
u,
                                                                   SMU_MSG_=
SetMinDeepSleepDcefclk,
                                                                   min_cloc=
ks.dcef_clock_in_sr/100,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b6759f8b5167..804e1c98238d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1280,8 +1280,8 @@ static int sienna_cichlid_display_config_changed(stru=
ct smu_context *smu)
         int ret =3D 0;

         if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-           smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) =
&&
-           smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) =
{
+           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
                 ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOf=
Displays,
                                                   smu->display_config->num=
_display,
@@ -1517,13 +1517,13 @@ static int sienna_cichlid_notify_smc_display_config=
(struct smu_context *smu)
         min_clocks.dcef_clock_in_sr =3D smu->display_config->min_dcef_deep=
_sleep_set_clk;
         min_clocks.memory_clock =3D smu->display_config->min_mem_set_clock=
;

-       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT))=
 {
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
                 clock_req.clock_type =3D amd_pp_dcef_clock;
                 clock_req.clock_freq_in_khz =3D min_clocks.dcef_clock * 10=
;

                 ret =3D smu_v11_0_display_clock_voltage_request(smu, &cloc=
k_req);
                 if (!ret) {
-                       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_D=
S_DCEFCLK_BIT)) {
+                       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_=
DCEFCLK_BIT)) {
                                 ret =3D smu_cmn_send_smc_msg_with_param(sm=
u,
                                                                   SMU_MSG_=
SetMinDeepSleepDcefclk,
                                                                   min_cloc=
ks.dcef_clock_in_sr/100,
@@ -3785,7 +3785,7 @@ static int sienna_cichlid_gpo_control(struct smu_cont=
ext *smu,
         int ret =3D 0;


-       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT))=
 {
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
                 ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
                 if (ret)
                         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index b34d3a416939..d36b64371492 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,
                 return ret;

         bitmap_zero(feature->enabled, feature->feature_num);
-       bitmap_zero(feature->supported, feature->feature_num);

         if (en) {
                 ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
@@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,

                 bitmap_copy(feature->enabled, (unsigned long *)&feature_ma=
sk,
                             feature->feature_num);
-               bitmap_copy(feature->supported, (unsigned long *)&feature_m=
ask,
-                           feature->feature_num);
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 65f30cdafc8f..478151e72889 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1956,7 +1956,6 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)
                                                       RLC_STATUS_OFF, NULL=
);

         bitmap_zero(feature->enabled, feature->feature_num);
-       bitmap_zero(feature->supported, feature->feature_num);

         if (!en)
                 return ret;
@@ -1967,8 +1966,6 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)

         bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
                     feature->feature_num);
-       bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-                   feature->feature_num);

         return 0;
 }
@@ -1985,7 +1982,7 @@ static int vangogh_post_smu_init(struct smu_context *=
smu)
                 adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shad=
er_engines;

         /* allow message will be sent after enable message on Vangogh*/
-       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &=
&
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
                         (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NU=
LL);
                 if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6b77fc4b4698..92b5c1108a2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_contex=
t *smu,
                 return ret;

         bitmap_zero(feature->enabled, feature->feature_num);
-       bitmap_zero(feature->supported, feature->feature_num);

         if (en) {
                 ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
@@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_contex=
t *smu,

                 bitmap_copy(feature->enabled, (unsigned long *)&feature_ma=
sk,
                             feature->feature_num);
-               bitmap_copy(feature->supported, (unsigned long *)&feature_m=
ask,
-                           feature->feature_num);
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a7aabb8079ed..d89e8a03651b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnl=
oad, NULL);

         bitmap_zero(feature->enabled, feature->feature_num);
-       bitmap_zero(feature->supported, feature->feature_num);

         if (!en)
                 return ret;
@@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)

         bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
                     feature->feature_num);
-       bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-                   feature->feature_num);

         return 0;
 }
--
2.29.0


--_000_BL1PR12MB5144146584DDA9CF1D6F1BADF7229BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 2:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH V3 4/7] drm/amd/pm: correct the usage for 'supported=
' member of smu_feature structure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The supported features should be retrieved just af=
ter EnableAllDpmFeatures message<br>
complete. And the check(whether some dpm feature is supported) is only need=
ed when we<br>
decide to enable or disable it.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 +++++++++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 8 ++++----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; | 10 =
+++++-----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 5 +----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; |&nbsp; 3 =
---<br>
&nbsp;7 files changed, 21 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index ae48cc5aa567..803068cb5079 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1057,8 +1057,10 @@ static int smu_get_thermal_temperature_range(struct =
smu_context *smu)<br>
&nbsp;<br>
&nbsp;static int smu_smc_hw_setup(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_gen =3D 0, p=
cie_width =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_supported;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &a=
mp;&amp; smu_is_dpm_running(smu)) {<br>
@@ -1138,6 +1140,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(=
smu, &amp;features_supported);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to retrieve supported dpm fea=
tures!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;supported,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)&amp;features_supported=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_is_dpm_running(sm=
u))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been disabled\n&=
quot;);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 84cbde3f913d..f55ead5f9aba 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -1624,8 +1624,8 @@ static int navi10_display_config_changed(struct smu_c=
ontext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;watermarks_bi=
tmap &amp; WATERMARKS_EXIST) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
NumOfDisplays,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu-&gt;display_config-&gt;num_display,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 NULL);<br>
@@ -1860,13 +1860,13 @@ static int navi10_notify_smc_display_config(struct =
smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clocks.dcef_clock_in_s=
r =3D smu-&gt;display_config-&gt;min_dcef_deep_sleep_set_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clocks.memory_clock =
=3D smu-&gt;display_config-&gt;min_mem_set_clock;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DPM_DCEFCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_enabled(smu, S=
MU_FEATURE_DPM_DCEFCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clock_req.clock_type =3D amd_pp_dcef_clock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clock_req.clock_freq_in_khz =3D min_clocks.dcef_clock=
 * 10;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_display_clock_voltage_request(smu, =
&amp;clock_req);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feat=
ure_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feat=
ure_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_wit=
h_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetMinDeepSleepDcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; min_clocks.dcef_clock_in_sr/100,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index b6759f8b5167..804e1c98238d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -1280,8 +1280,8 @@ static int sienna_cichlid_display_config_changed(stru=
ct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;watermarks_bi=
tmap &amp; WATERMARKS_EXIST) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
&nbsp;#if 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
NumOfDisplays,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu-&gt;display_config-&gt;num_display,<br>
@@ -1517,13 +1517,13 @@ static int sienna_cichlid_notify_smc_display_config=
(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clocks.dcef_clock_in_s=
r =3D smu-&gt;display_config-&gt;min_dcef_deep_sleep_set_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clocks.memory_clock =
=3D smu-&gt;display_config-&gt;min_mem_set_clock;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DPM_DCEFCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_enabled(smu, S=
MU_FEATURE_DPM_DCEFCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clock_req.clock_type =3D amd_pp_dcef_clock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clock_req.clock_freq_in_khz =3D min_clocks.dcef_clock=
 * 10;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_display_clock_voltage_request(smu, =
&amp;clock_req);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feat=
ure_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feat=
ure_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_wit=
h_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetMinDeepSleepDcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; min_clocks.dcef_clock_in_sr/100,<br>
@@ -3785,7 +3785,7 @@ static int sienna_cichlid_gpo_control(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DPM_GFX_GPO_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_enabled(smu, S=
MU_FEATURE_DPM_GFX_GPO_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_smc_version(smu, NULL, &amp;smu_v=
ersion);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index b34d3a416939..d36b64371492 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;en=
abled, feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;supported, fe=
ature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (en) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu, &amp;feature_ma=
sk);<br>
@@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;enabled, (unsigned long *)&am=
p;feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy(feature-&gt;supported, (unsigned long *)&amp;feature=
_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; feature-&gt;feature_num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 65f30cdafc8f..478151e72889 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1956,7 +1956,6 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RLC_STATUS_OFF, NULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;en=
abled, feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;supported, fe=
ature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1967,8 +1966,6 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;en=
abled, (unsigned long *)&amp;feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;supported, (u=
nsigned long *)&amp;feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1985,7 +1982,7 @@ static int vangogh_post_smu_init(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_sh_per_se * adev-&gt;gfx.conf=
ig.max_shader_engines;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allow message will be s=
ent after enable message on Vangogh*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DPM_GFXCLK_BIT) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_enabled(smu, S=
MU_FEATURE_DPM_GFXCLK_BIT) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
-&gt;pg_flags &amp; AMD_PG_SUPPORT_GFX_PG)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOf=
f, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 6b77fc4b4698..92b5c1108a2e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;en=
abled, feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;supported, fe=
ature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (en) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu, &amp;feature_ma=
sk);<br>
@@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_contex=
t *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;enabled, (unsigned long *)&am=
p;feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy(feature-&gt;supported, (unsigned long *)&amp;feature=
_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; feature-&gt;feature_num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index a7aabb8079ed..d89e8a03651b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1F=
orUnload, NULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;en=
abled, feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;supported, fe=
ature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;en=
abled, (unsigned long *)&amp;feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;supported, (u=
nsigned long *)&amp;feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144146584DDA9CF1D6F1BADF7229BL1PR12MB5144namp_--
