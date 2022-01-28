Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C28C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4E710F2EF;
	Fri, 28 Jan 2022 14:55:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6544C10F2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9Q57BuZJfIk8yabWQoTcSyYUM4bQ/Xnh7/YV4TH/BFLY0Ejy8ZpS9GAQO1O3WPvTpAYqpsuudyLgcO+rO3+fOl2G2gXReoP9Oat/joYOdIG6wdSTpFLrAJ1g/JAvXj2q6rpmSbP60IVcsYmJ2KUmEJ9XCG9NPwBvtFUzEvh47dbFQCS8bNpm5VOAzaK+oCRlkr4pgZpNSBHtvhVUW8qmDdNeCp25sDOEnvJmmEVcSCYPjbhVa4G0XL4aZHkkLaBfIJPGH5CLGvQNkZyRt7+5s/da8D2kDyZXg/QC5SpmWz6UbLXVUw6gY2hoaTo6Yl+pDTNZx46MBO0DwLktYqFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3E6ZokHnk8SHViwRA/SY5QQ5sFLFfsZEF+J/ZzaUk=;
 b=PlcdUWXWrllpehTdL29YiX2WkIbOXnSSZP04iQmGKlBRo6IWZgPUrR0/STomeXED+VW4ljPvzhVHiP8niE3MxIJAzvJ+mPkGhDDuRbg+sNzA0q0CzC9MoZMQ+ZJ+386oYCgY91vlkVcoxlkOgEb6TDtQ8gBxt+lQAg7/vuLkpIUMCWFBuORJVVzE7ex62MSYFgXz34UomI0NpcyqUHURrs8xGgQqraLiSGnNsZPQQ0qIUSvK5MusIIQI631hLI4pFPcd4XFXp/uNxmr0HgPEBlPHii/mMTlXZZpnGiUrk95GbX6sZ9USG1ZrKaQVwezWexE1NT4y+vu8iH1I+WaqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3E6ZokHnk8SHViwRA/SY5QQ5sFLFfsZEF+J/ZzaUk=;
 b=HaCRetk/pJjQ4kqfE0aZZn6EUgmVELB2Ta939i4sBR0OGzVKtAJ8ED8WOjWfADW1PhdRPaXeqwXLucfiTGAc2vHn9CzCdySeNj6HRdI30Wr3X5pUWNGIne1oGXnK9cVObn8OfP9GNLc9qD6JNNj7HSD5rg6lq0T4i/wA5ogpEbk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 14:55:45 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:55:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 5/7] drm/amd/pm: drop the cache for enabled ppfeatures
Thread-Topic: [PATCH V3 5/7] drm/amd/pm: drop the cache for enabled ppfeatures
Thread-Index: AQHYFBVzeqpDTc7Aq063zHBO0YNO+6x4hg2Z
Date: Fri, 28 Jan 2022 14:55:44 +0000
Message-ID: <BL1PR12MB514458F2B062047C23E80BCFF7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-5-evan.quan@amd.com>
In-Reply-To: <20220128070455.202014-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T14:55:44.185Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 12e9f7d9-404f-4bca-845c-7109ba1c64bb
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 531dfd06-9200-42da-86d1-08d9e26e4318
x-ms-traffictypediagnostic: BN7PR12MB2689:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2689915C163845EB5A6A16AEF7229@BN7PR12MB2689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMSCFE//g885QaJ1v9lYWGNjNwakV/9B+47R7YrGkyPrwARcKOfGavVtYEQqFodAz9Fua9pydvsb+wlOheg6khkgxLx0UmfzzuaU/maLMwqgdlBk7xUrx43mm0lm0LJyW0Mhwd7BJiOX7yFOhKCTAMkCfrHG95bmdjgauGzBsG3zn4SjWEI/ukXbM05LvK53hSgUKBz6nYMNQF/Tla7dvo2lkCat6+3TrGwxgWow6kdAKJ+ct4KNOBnVYwaz3pkcAm4AnPu6o5ASHXvU/PV4l/86Yh36lWi/EAE0otr0kIbl/9bjKzqJg7NbiP5tUEpYq+Bse365EyoBVTjMZXFJ+sHFr3+/SdNMMFcp/jephRy5mFk3rttAoRpRMTnuSiGkRx43K1L22gsOw22OdkDSTZCrIBMS23uM6epSkaEUnBPsCZpBqOwFWrcb16oFxMgSNH878esWHad2A8Axtqd5+C8pUw+XZHEC8uyPz+iu0wYUtShh7fK0iTFkI4B9JF7y2ZUPuK8+yuEF2tzxIytQVj7lwswKrNvn20mL33DRk7ZKcwooPOMSfLRI3gsfStzU1rtOCwAjijO+Wr+ZyG253p+qigS6cLq+u4oEkxen2AfGgoXFk0s8BAJv5xHYr1LooyZ9g8L0dC1U3AYMTsEc9MJ6+xQhq0wuy/1g/HKspG2GNgKme80dSlQumMoVJVYCLyXWSIHOfvPzFLc0qiEkcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(9686003)(2906002)(6506007)(53546011)(26005)(186003)(86362001)(55016003)(508600001)(83380400001)(38070700005)(76116006)(38100700002)(19627405001)(66476007)(30864003)(66556008)(8676002)(66446008)(8936002)(66946007)(52536014)(64756008)(5660300002)(122000001)(33656002)(316002)(110136005)(4326008)(71200400001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?La7YhM+PVy5F03Crjm461xjYsjC+HKAtiP94H9cJcXiWfd/fIFbP7Is/o2oi?=
 =?us-ascii?Q?qRYIdB22xaii4Cvb1/qf5DtvPZNaArbqQWftYltQPKI6te/Sr9JHKpj/WWfD?=
 =?us-ascii?Q?NuhwO8JTmdaGVxgrzm/StKDRKF7K7kJNHFGyEUgxPDFs3b/DJg9ZOYDkcl7x?=
 =?us-ascii?Q?yToSPIRHRA53KAN6JVzB1b4j1VLsx9UyG+F7oJVVH+mMHP5gGvbL3fOVb3yO?=
 =?us-ascii?Q?UKx9RMzGPypwjFQDNaPKVBU8BM1Wty0OMsle0TA4lLCfc4vl2igMsR4wc7qL?=
 =?us-ascii?Q?pbGNQBjMnenndexYlO2X7OKfbQ6ck9OqGU9375I1dz/nvdp033M8qSAvH4Of?=
 =?us-ascii?Q?7qRaSiXCKJU+VMAlPRsCaRLJ9vIOANprCSExsmKqQyCYXMJuxykrBpHkMpRu?=
 =?us-ascii?Q?wmOZWSJNWxIMgYD9YtCgpI2Ok3WzsyEpswey2EBMrs5a27tTr0yd+GN9G8qu?=
 =?us-ascii?Q?3s/T52IwcadASGDTsUoSxcgHBe8GRlyvbAr+ystGDZAYEyTpaIsDOh5rjx6A?=
 =?us-ascii?Q?ihVJDK0lx+cHWMxEennpYjLNa5qRgEAaHgviph6mXIrqAVriXI2W4lEY3XTR?=
 =?us-ascii?Q?JPcm0h6wtv1tuwH6PW9t82vmh48OwT3Pjv+Ylue5eryo6hdouIAMG5xQjQha?=
 =?us-ascii?Q?U3hT3lpC7tnxcjNnTOPMCI4fJ50BipB4j7qOGBCees+QAf8snExJbhn1KimK?=
 =?us-ascii?Q?JEV6b7qPWMbaKu7E5Ys7vpQUOIiLTShrVN47SR//VYjEswDdU1GGw3BVNGFT?=
 =?us-ascii?Q?sy+e+EqDZtW7LuYoo8C87CbydLvWf2sEGLVQPainQxhlbVcZH+vMKNVlUypF?=
 =?us-ascii?Q?odvibaxSSew2q7snyrPeHMF6FoxTsx9UrDscZfvZzCyGS9eqtPGpCkuVevUz?=
 =?us-ascii?Q?WDznTot1gbkdlwdM9GygE8hHA2HZdpAg91CPhCHNYSQyZiQxLxySKfotH3kv?=
 =?us-ascii?Q?nsenDwhB6vBiEdGR7Ja3UwjYBeIo+YDNfL9mNObKMFAUcjoZcYEiB7p1/+j2?=
 =?us-ascii?Q?rXLiQ9NHJniTNIQdogyBGL1kvFyXiQA5EcMHY+VySkXjUGwfcg+5vbL0qTfC?=
 =?us-ascii?Q?Dsj88Kt2L1mkt2+8QeBiHtOyZg8N7U5frXF8Lo7gdSf+vIbp3i31gApIzDAI?=
 =?us-ascii?Q?QQWORQvBB/us121rs43S6h6DoLDFGFEruAu9BfH5vafaAINYLk3Mlp+LMkMI?=
 =?us-ascii?Q?jL/Mkj7ebR1h50vSJElw81OL5qPKstCHA5aTs8H/PsJuc/+02HTAVetdPm/r?=
 =?us-ascii?Q?qQgLe1zffUpt6dy5UrRuG7CoBf58PI/QNDsQbUBDIc1/1fP0CBhI2nhM6puM?=
 =?us-ascii?Q?u3lYgTQtjzmURlYVQ3PU89+6NefkOwR4Vs9R2IZzvJCmcdCi84eNuT11vUpo?=
 =?us-ascii?Q?8ZJv82yf63Poq9FgdGb6+UkiIg4yZdZBTABFWMUbdnxWGEGVTHCzqlyZTRHX?=
 =?us-ascii?Q?KwUlhPBpUSkoCzii2PJPO3H9GSyhPdKpeZOqbuHcIB7esupTUZyCflrgkhmQ?=
 =?us-ascii?Q?cp8wd8tZP0mVO1udWnJeIta1kStec3VgyVPWT4RGiwjrMdQ5cTUJmZmld7Yi?=
 =?us-ascii?Q?alDXPmfsfpDWYEiFXE1uZFZ3V+8/AH+atDqQPlgZC8XuyMgWYs5vN9qjJ636?=
 =?us-ascii?Q?l2Dp44bWaEyp+Y2Nmm0FSBQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514458F2B062047C23E80BCFF7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531dfd06-9200-42da-86d1-08d9e26e4318
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:55:44.8346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1bqHO1iLWh9DjB6TpEpl51kSH30uR3i8UPOp5/0sdPnGisjZRg10T7oDVAQmbtb1Q3yPNvT74+z8pzqOVxhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2689
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

--_000_BL1PR12MB514458F2B062047C23E80BCFF7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, January 28, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V3 5/7] drm/amd/pm: drop the cache for enabled ppfeatures

The following scenarios make the driver cache for enabled ppfeatures
outdated and invalid:
  - Other tools interact with PMFW to change the enabled ppfeatures.
  - PMFW may enable/disable some features behind driver's back. E.g.
    for sienna_cichild, on gfxoff entering, PMFW will disable gfx
    related DPM features. All those are performed without driver's
    notice.
Also considering driver does not actually interact with PMFW such
frequently, the benefit brought by such cache is very limited.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I20ed58ab216e930c7a5d223be1eb99146889f2b3
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 +---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 +------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 23 +---------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 16 +------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 46 +++++--------------
 7 files changed, 17 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 803068cb5079..59be1c822b2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -950,7 +950,6 @@ static int smu_sw_init(void *handle)
         smu->pool_size =3D adev->pm.smu_prv_buffer_size;
         smu->smu_feature.feature_num =3D SMU_FEATURE_MAX;
         bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
-       bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
         bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);

         mutex_init(&smu->message_lock);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 8cd1c3bb595a..721b4080d3e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -390,7 +390,6 @@ struct smu_feature
         uint32_t feature_num;
         DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
         DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
-       DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
 };

 struct smu_clocks {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index d36b64371492..d71155a66f97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -798,27 +798,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu=
)
 int smu_v11_0_system_features_control(struct smu_context *smu,
                                              bool en)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
-       uint64_t feature_mask;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeature=
s :
-                                    SMU_MSG_DisableAllSmuFeatures), NULL);
-       if (ret)
-               return ret;
-
-       bitmap_zero(feature->enabled, feature->feature_num);
-
-       if (en) {
-               ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
-               if (ret)
-                       return ret;
-
-               bitmap_copy(feature->enabled, (unsigned long *)&feature_mas=
k,
-                           feature->feature_num);
-       }
-
-       return ret;
+       return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures=
 :
+                                         SMU_MSG_DisableAllSmuFeatures), N=
ULL);
 }

 int smu_v11_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 478151e72889..96a5b31f708d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1947,27 +1947,13 @@ static int vangogh_get_dpm_clock_table(struct smu_c=
ontext *smu, struct dpm_clock
 static int vangogh_system_features_control(struct smu_context *smu, bool e=
n)
 {
         struct amdgpu_device *adev =3D smu->adev;
-       struct smu_feature *feature =3D &smu->smu_feature;
-       uint64_t feature_mask;
         int ret =3D 0;

         if (adev->pm.fw_version >=3D 0x43f1700 && !en)
                 ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPo=
werNotify,
                                                       RLC_STATUS_OFF, NULL=
);

-       bitmap_zero(feature->enabled, feature->feature_num);
-
-       if (!en)
-               return ret;
-
-       ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
-       if (ret)
-               return ret;
-
-       bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-                   feature->feature_num);
-
-       return 0;
+       return ret;
 }

 static int vangogh_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 92b5c1108a2e..f0ab1dc3ca59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -764,27 +764,8 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu,=
 bool enable)
 int smu_v13_0_system_features_control(struct smu_context *smu,
                                       bool en)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
-       uint64_t feature_mask;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeature=
s :
-                                        SMU_MSG_DisableAllSmuFeatures), NU=
LL);
-       if (ret)
-               return ret;
-
-       bitmap_zero(feature->enabled, feature->feature_num);
-
-       if (en) {
-               ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
-               if (ret)
-                       return ret;
-
-               bitmap_copy(feature->enabled, (unsigned long *)&feature_mas=
k,
-                           feature->feature_num);
-       }
-
-       return ret;
+       return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures=
 :
+                                         SMU_MSG_DisableAllSmuFeatures), N=
ULL);
 }

 int smu_v13_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d89e8a03651b..e90387a84cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -195,27 +195,13 @@ static int yellow_carp_fini_smc_tables(struct smu_con=
text *smu)

 static int yellow_carp_system_features_control(struct smu_context *smu, bo=
ol en)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         struct amdgpu_device *adev =3D smu->adev;
-       uint64_t feature_mask;
         int ret =3D 0;

         if (!en && !adev->in_s0ix)
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnl=
oad, NULL);

-       bitmap_zero(feature->enabled, feature->feature_num);
-
-       if (!en)
-               return ret;
-
-       ret =3D smu_cmn_get_enabled_mask(smu, &feature_mask);
-       if (ret)
-               return ret;
-
-       bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-                   feature->feature_num);
-
-       return 0;
+       return ret;
 }

 static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool en=
able)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index aae08ce62b80..3d263b27b6c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -496,8 +496,8 @@ int smu_cmn_feature_is_supported(struct smu_context *sm=
u,
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
                                enum smu_feature_mask mask)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         struct amdgpu_device *adev =3D smu->adev;
+       uint64_t enabled_features;
         int feature_id;

         if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
@@ -509,9 +509,12 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu=
,
         if (feature_id < 0)
                 return 0;

-       WARN_ON(feature_id > feature->feature_num);
+       if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+               dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\=
n");
+               return 0;
+       }

-       return test_bit(feature_id, feature->enabled);
+       return test_bit(feature_id, (unsigned long *)&enabled_features);
 }

 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -544,7 +547,6 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu=
,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
                              uint64_t *feature_mask)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t *feature_mask_high;
         uint32_t *feature_mask_low;
@@ -553,13 +555,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
         if (!feature_mask)
                 return -EINVAL;

-       if (!bitmap_empty(feature->enabled, feature->feature_num)) {
-               bitmap_copy((unsigned long *)feature_mask,
-                            feature->enabled,
-                            feature->feature_num);
-               return 0;
-       }
-
         feature_mask_low =3D &((uint32_t *)feature_mask)[0];
         feature_mask_high =3D &((uint32_t *)feature_mask)[1];

@@ -616,7 +611,6 @@ int smu_cmn_feature_update_enable_state(struct smu_cont=
ext *smu,
                                         uint64_t feature_mask,
                                         bool enabled)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         int ret =3D 0;

         if (enabled) {
@@ -630,8 +624,6 @@ int smu_cmn_feature_update_enable_state(struct smu_cont=
ext *smu,
                                                   SMU_MSG_EnableSmuFeature=
sHigh,
                                                   upper_32_bits(feature_ma=
sk),
                                                   NULL);
-               if (ret)
-                       return ret;
         } else {
                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                   SMU_MSG_DisableSmuFeatur=
esLow,
@@ -643,17 +635,8 @@ int smu_cmn_feature_update_enable_state(struct smu_con=
text *smu,
                                                   SMU_MSG_DisableSmuFeatur=
esHigh,
                                                   upper_32_bits(feature_ma=
sk),
                                                   NULL);
-               if (ret)
-                       return ret;
         }

-       if (enabled)
-               bitmap_or(feature->enabled, feature->enabled,
-                               (unsigned long *)(&feature_mask), SMU_FEATU=
RE_MAX);
-       else
-               bitmap_andnot(feature->enabled, feature->enabled,
-                               (unsigned long *)(&feature_mask), SMU_FEATU=
RE_MAX);
-
         return ret;
 }

@@ -661,7 +644,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu=
,
                                 enum smu_feature_mask mask,
                                 bool enable)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         int feature_id;

         feature_id =3D smu_cmn_to_asic_specific_index(smu,
@@ -670,8 +652,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu=
,
         if (feature_id < 0)
                 return -EINVAL;

-       WARN_ON(feature_id > feature->feature_num);
-
         return smu_cmn_feature_update_enable_state(smu,
                                                1ULL << feature_id,
                                                enable);
@@ -793,7 +773,6 @@ int smu_cmn_disable_all_features_with_exception(struct =
smu_context *smu,
                                                 bool no_hw_disablement,
                                                 enum smu_feature_mask mask=
)
 {
-       struct smu_feature *feature =3D &smu->smu_feature;
         uint64_t features_to_disable =3D U64_MAX;
         int skipped_feature_id;

@@ -807,15 +786,12 @@ int smu_cmn_disable_all_features_with_exception(struc=
t smu_context *smu,
                 features_to_disable &=3D ~(1ULL << skipped_feature_id);
         }

-       if (no_hw_disablement) {
-               bitmap_andnot(feature->enabled, feature->enabled,
-                               (unsigned long *)(&features_to_disable), SM=
U_FEATURE_MAX);
+       if (no_hw_disablement)
                 return 0;
-       } else {
-               return smu_cmn_feature_update_enable_state(smu,
-                                                          features_to_disa=
ble,
-                                                          0);
-       }
+
+       return smu_cmn_feature_update_enable_state(smu,
+                                                  features_to_disable,
+                                                  0);
 }

 int smu_cmn_get_smc_version(struct smu_context *smu,
--
2.29.0


--_000_BL1PR12MB514458F2B062047C23E80BCFF7229BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 2:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH V3 5/7] drm/amd/pm: drop the cache for enabled ppfea=
tures</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The following scenarios make the driver cache for =
enabled ppfeatures<br>
outdated and invalid:<br>
&nbsp; - Other tools interact with PMFW to change the enabled ppfeatures.<b=
r>
&nbsp; - PMFW may enable/disable some features behind driver's back. E.g.<b=
r>
&nbsp;&nbsp;&nbsp; for sienna_cichild, on gfxoff entering, PMFW will disabl=
e gfx<br>
&nbsp;&nbsp;&nbsp; related DPM features. All those are performed without dr=
iver's<br>
&nbsp;&nbsp;&nbsp; notice.<br>
Also considering driver does not actually interact with PMFW such<br>
frequently, the benefit brought by such cache is very limited.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I20ed58ab216e930c7a5d223be1eb99146889f2b3<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 1 -<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp; | 23 +--=
-------<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 16 +------<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 23 +--=
-------<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; | 16 +------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 46 +++++--------------<br>
&nbsp;7 files changed, 17 insertions(+), 109 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 803068cb5079..59be1c822b2c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -950,7 +950,6 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pool_size =3D adev=
-&gt;pm.smu_prv_buffer_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_feature.featur=
e_num =3D SMU_FEATURE_MAX;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.supported, SMU_FEATURE_MAX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_feature.enabl=
ed, SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.allowed, SMU_FEATURE_MAX);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;me=
ssage_lock);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index 8cd1c3bb595a..721b4080d3e6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -390,7 +390,6 @@ struct smu_feature<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_num;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(supported, =
SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(allowed, SM=
U_FEATURE_MAX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(enabled, SMU_FEATURE_M=
AX);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct smu_clocks {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index d36b64371492..d71155a66f97 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -798,27 +798,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu=
)<br>
&nbsp;int smu_v11_0_system_features_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, (en=
 ? SMU_MSG_EnableAllSmuFeatures :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_Disab=
leAllSmuFeatures), NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;enabled, feat=
ure-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (en) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu, &amp;feature_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy(feature-&gt;enabled, (unsigned long *)&amp;feature_m=
ask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, (en =
? SMU_MSG_EnableAllSmuFeatures :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; SMU_MSG_DisableAllSmuFeatures), NULL);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v11_0_notify_display_change(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 478151e72889..96a5b31f708d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1947,27 +1947,13 @@ static int vangogh_get_dpm_clock_table(struct smu_c=
ontext *smu, struct dpm_clock<br>
&nbsp;static int vangogh_system_features_control(struct smu_context *smu, b=
ool en)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.fw_version=
 &gt;=3D 0x43f1700 &amp;&amp; !en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
RlcPowerNotify,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RLC_STATUS_OFF, NULL);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;enabled, feat=
ure-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 &amp;feature_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;enabled, (uns=
igned long *)&amp;feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vangogh_post_smu_init(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 92b5c1108a2e..f0ab1dc3ca59 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -764,27 +764,8 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu,=
 bool enable)<br>
&nbsp;int smu_v13_0_system_features_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool en)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, (en=
 ? SMU_MSG_EnableAllSmuFeatures :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU_MSG_DisableAllSmuFeatures), NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;enabled, feat=
ure-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (en) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu, &amp;feature_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy(feature-&gt;enabled, (unsigned long *)&amp;feature_m=
ask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, (en =
? SMU_MSG_EnableAllSmuFeatures :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; SMU_MSG_DisableAllSmuFeatures), NULL);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v13_0_notify_display_change(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index d89e8a03651b..e90387a84cbb 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -195,27 +195,13 @@ static int yellow_carp_fini_smc_tables(struct smu_con=
text *smu)<br>
&nbsp;<br>
&nbsp;static int yellow_carp_system_features_control(struct smu_context *sm=
u, bool en)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en &amp;&amp; !adev-&=
gt;in_s0ix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1F=
orUnload, NULL);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;enabled, feat=
ure-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 &amp;feature_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;enabled, (uns=
igned long *)&amp;feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bo=
ol enable)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index aae08ce62b80..3d263b27b6c2 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -496,8 +496,8 @@ int smu_cmn_feature_is_supported(struct smu_context *sm=
u,<br>
&nbsp;int smu_cmn_feature_is_enabled(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_feature_mask mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t enabled_features;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu &amp;&a=
mp; adev-&gt;family &lt; AMDGPU_FAMILY_VGH)<br>
@@ -509,9 +509,12 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(feature_id &gt; feature-&gt;f=
eature_num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_get_enabled_mask(smu, &am=
p;enabled_features)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to retrieve enabled ppfeature=
s!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_bit(feature_id, feature-&=
gt;enabled);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_bit(feature_id, (unsigned=
 long *)&amp;enabled_features);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,<br>
@@ -544,7 +547,6 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu=
,<br>
&nbsp;int smu_cmn_get_enabled_mask(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *feature_mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_low=
;<br>
@@ -553,13 +555,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bitmap_empty(feature-&gt;enabled=
, feature-&gt;feature_num)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy((unsigned long *)feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; feature-&gt;enabled,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_low =3D &amp;=
((uint32_t *)feature_mask)[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_high =3D &amp=
;((uint32_t *)feature_mask)[1];<br>
&nbsp;<br>
@@ -616,7 +611,6 @@ int smu_cmn_feature_update_enable_state(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_t feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bool enabled)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
@@ -630,8 +624,6 @@ int smu_cmn_feature_update_enable_state(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_MSG_EnableSmuFeaturesHigh,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 upper_32_bits(feature_mask),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_MSG_DisableSmuFeaturesLow,<br>
@@ -643,17 +635,8 @@ int smu_cmn_feature_update_enable_state(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_MSG_DisableSmuFeaturesHigh,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 upper_32_bits(feature_mask),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_or(feature-&gt;enabled, feature-&gt;enabled,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)(&amp;feature_mask), SMU_F=
EATURE_MAX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_andnot(feature-&gt;enabled, feature-&gt;enabled,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)(&amp;feature_mask), SMU_F=
EATURE_MAX);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -661,7 +644,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_feature_mask mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_id =3D smu_cmn_to_=
asic_specific_index(smu,<br>
@@ -670,8 +652,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(feature_id &gt; feature-&gt;f=
eature_num);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_feature_upd=
ate_enable_state(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1ULL &lt;&lt; fea=
ture_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable);<br>
@@ -793,7 +773,6 @@ int smu_cmn_disable_all_features_with_exception(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool no_hw_=
disablement,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_fe=
ature_mask mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_disab=
le =3D U64_MAX;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int skipped_feature_id;<br=
>
&nbsp;<br>
@@ -807,15 +786,12 @@ int smu_cmn_disable_all_features_with_exception(struc=
t smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; features_to_disable &amp;=3D ~(1ULL &lt;&lt; skipped_=
feature_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (no_hw_disablement) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_andnot(feature-&gt;enabled, feature-&gt;enabled,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)(&amp;features_to_disable)=
, SMU_FEATURE_MAX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (no_hw_disablement)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_cmn_feature_update_enable_state(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_to_disable,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_feature_update_enable_=
state(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feat=
ures_to_disable,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_cmn_get_smc_version(struct smu_context *smu,<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514458F2B062047C23E80BCFF7229BL1PR12MB5144namp_--
