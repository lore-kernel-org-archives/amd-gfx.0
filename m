Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC3C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 15:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0148C6192E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0148C6192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887466E4F1;
	Mon, 22 Mar 2021 15:34:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA7B6E4F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 15:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQmecoInT3qTzGFFPt2ySKL9GYaV7v1tN+P7RIFRBqsftQAr016XFkzkNfENPsZk5GTYOuhIslx9nXXab6rDSqLKlg2QW/E+YZYL3v5B1YFzbVKGVadGwdJRj1PjJuhy7dWLDwgBOQTBtcomOCG52p/rxApezB5OACymDm3JvY+hy4UrNLppmYo4/BW7fK/uXBw0oAYXm9N2CXu9Pk+QUASMQgKDiSRCI4Pb2vMGMLNwYN0oByZsWifBxEHrLbiqX4NwN/TNzrmpUkmN3ZNJah7Tdg2tuFXtD418OFr14suf17fkzs+JeQzYtSwQpE7GxmLb5DxW1B0BQ6INCNNmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ/iH9UoAd0oH1EJ0KbAMLU4ppnUSumDxgUSopElRJM=;
 b=c3LgrcESrQAJK9zG7gpR+VEjZQ+V+QNfC5J3YlCHBRBzYu8NY/n5OciMgQCoHEC3+q3Xf4qLPgkMzppJnJ90r5XDfChX3dJOBW2GLT+igEYGSQHLjEakph3WbqSV+WpnuQxhs42mq9wYpDjHD41tiHZlkCmMSdwu6GlcpjMdNK1U1m9cNWGzpUr7Novf2ajQbFZezWAVhRfcdWWuPij8Drt8xxcF+wX0AqoXzaoVgl87ymkEh/zw3+I3ty5R+CE7P90jPP/lSkS0IE83pGFnR45xtOIaHb1PFYemmBWSzvbKgW2B9hJDDEC1zarCD5V+RBWPOt0Yah/d8ngVk2xGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ/iH9UoAd0oH1EJ0KbAMLU4ppnUSumDxgUSopElRJM=;
 b=S/fT0ThSfzp7r2qeODd2qb4SmkwePmlLYFqNLOmJx3FfpmEEG8KqC0X60w9iMCqNLcMuAkYROwTlYBvTG201nseaClaaY6vqA+0oDmxXr75NrCQmNOS9SwvCl342Exo5mwwPbWQgELiuEndky2ayFdH6O+EpNSUg886Vhl/MrJk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 15:34:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 15:34:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: drop redundant and unneeded BACO APIs V2
Thread-Topic: [PATCH] drm/amd/pm: drop redundant and unneeded BACO APIs V2
Thread-Index: AQHXHuI30aOBlpqKLEC0FuyRW19HfqqQI9Av
Date: Mon, 22 Mar 2021 15:34:19 +0000
Message-ID: <MN2PR12MB44889002E50E9FCAA68054E4F7659@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210322061110.594178-1-evan.quan@amd.com>
In-Reply-To: <20210322061110.594178-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-22T15:34:18.668Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a073daff-aaaa-47b7-5068-08d8ed47f5ac
x-ms-traffictypediagnostic: BL0PR12MB4865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB48656B9AF842FB5038902C2EF7659@BL0PR12MB4865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wR9PlivkbYIgFmt3UB48NgSKcc7bTEjcGppGpAHmv61QTs+lyuzJQSQh5j24WKGe98gTJwOIgtMnTkDr6Qkn+Vr2V9QNgZnt2cMIFAUk0QcgQvfgYeuJ5aYcwrS7xke026z/7hOxj7oTTkaJTdAJankpfm8XrhUx/WVqjjXjXqKLEoxFw+6Ros9lSHDatLz9ceOUeoarM2HAsinXZUKQSF27AT73xB+CFQbXsSmO02JMAL2rI+c3euTttNSTC50NxQEdCOMCY5WbCR3DBn6g/iQjc8MO9LflN6wD6FJ6/JQsmm2KHhjl/nkf+b5pKCQ4qw2N1+86qZWpz1znFAtKHT2bCo1uxa2VUyz18qB20kvpjs7mXfWoMHRCQTMyB81+YgcQSkVvDLrj3ydpaMyPJ/525orWsfRtHIdiWD/g1gh48OxeMzq3zblAnXFquz1HCSqV9pRnKJBf9edYLIY+Gy85jRTmZaeEFSqmIGjeNe/BRwi7hsuEupq89tArbtSSxQV6b+fFauyadzGnqJwWLE/d0eXlP5JhxJ7c96/RE8HBpZCmHzA8yi55qsiGqZtdCbMkw2f9QZ3msGIDMpfdDnE1sePDyieYbpnKxBhsKu3NzlSoiutMKV6czly5MN+kJb8vZHjH0ytrNenu9wm72xnN3jtRRS7kLSyr5DnD8c7YVgqBEmFpAyBCEkkX8+94g6cp8Ov5DSbCG7WTY3EBYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(966005)(71200400001)(66946007)(19627405001)(64756008)(76116006)(66476007)(5660300002)(66556008)(478600001)(8936002)(8676002)(33656002)(66446008)(26005)(166002)(2906002)(38100700001)(55016002)(110136005)(9686003)(52536014)(6506007)(86362001)(186003)(45080400002)(53546011)(7696005)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Gg6lfbr+zEXj2UMkJLafZkHiueSAYmrm/ZfHkJA//2wbsdx8RrXJ2vGMZhzV?=
 =?us-ascii?Q?PSCdE6PqK2aune6j+7X/tHRfOU+2qJhLw+K9ZKJsSx+FQOTocnPg8SiGTjud?=
 =?us-ascii?Q?WKoCByQA7o7U+b/PWWnPBqHr6vDuGsVwEusNY1mMOv6L6Uzs/k+irp2m272w?=
 =?us-ascii?Q?9NBTE+FlahsN1YaU9i9ptWYmqBB+8OWcr1+CIyju7P3U+OzoAppP6CLMDAAS?=
 =?us-ascii?Q?QGFY6iaRwylecphJ+0avQME8o5u4t9d0c4ObdeEiWOoL/rk9xYEgWY24JUWa?=
 =?us-ascii?Q?XmP1KxHfH+sq/p+04MC/LaEpfaClLEQ66MfsbD8UtfNC7UPSZXBQ6T9lYVSO?=
 =?us-ascii?Q?3AIrCL5kFSO5QapFx3DHAzjIGxlshbhBCcl9LedNtf0heq8VGM4IaKvPYvPX?=
 =?us-ascii?Q?adnvf/kvet9yJ6pwNwKMKJ0ml/sbhK7QcZOqyC+Qm7Kc1Iw2RdExa51oMH7S?=
 =?us-ascii?Q?aa/2g4UkPhIC26ERCwvb8aBYOvmP7e4qSkqdTQZ+yh6O0h80dAOzJ6haH9Od?=
 =?us-ascii?Q?BFh+ggaYjROmtl4TA0Hknpp4JC+rWTdNYLVCJG2qtkviOnd8tko0mG+kwyyj?=
 =?us-ascii?Q?leUEmsoSqc4SqzdQgccaMSb3rnoENE7Xx9C66fIWnQmfguxYGblxHcM4GDKz?=
 =?us-ascii?Q?ji6J2kuho0lsXFVkLsazish63cdd0fLUPBtwu0HbICENm4T1lVLssoanu1VZ?=
 =?us-ascii?Q?z7n+W6IxY3yVlwOYhxKCfP0cCN/C0+Ephc8pf+Dtpqaa4k9yXzYbKCjnhY6L?=
 =?us-ascii?Q?3erxCa/rwuTxkYtAvHSiefooo9al0Agl5JCYHpdXRR3we0IEWDoPRDiu+D/E?=
 =?us-ascii?Q?mwsmL1OzOr9Cwf61dLa6lF8cHs+KT3y/jrywG+sklGg4o9/cF76pvxDLGs0x?=
 =?us-ascii?Q?4gJNWmM/Mr29sVrvjJA1Ci7ogoByPm6AxK7sEHyHsGOBwx7e+6555bLzf+lj?=
 =?us-ascii?Q?k0rb0+iGTq6BpNiOd66VqsoGUmA61w7cA0Si1ve5WdMvP0Y7pvIsXwDHllQc?=
 =?us-ascii?Q?7EE4E7eOlFquv1yGZrkz6QzGUnb9iM6MvZ27S/dcqXYfVKuk86qf2tTkkPoT?=
 =?us-ascii?Q?X8cLP+Ev9/+0J6t5fzMA7bOEfU8fqNHg1lRHkVf0cwxf0olP/C6M8sjvo9+1?=
 =?us-ascii?Q?BNId5XhawB+0491mmO55y5uoJZ3eizxweXJrNN1BontDXrtW0zvD0q+Xp2Tu?=
 =?us-ascii?Q?7TfPos83Yl2JnpdP2+D026PsCPJxTvXazZEaFJLmX7to9WgXPkVo5omaHgx9?=
 =?us-ascii?Q?7tIFvQM8/wmq2YbE2zInjGIP3d0IP4KYvGAcETSW3eAoE/mvK/JZvKnDZNYQ?=
 =?us-ascii?Q?0uD+odpV1rMADcO0TbURMgZB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a073daff-aaaa-47b7-5068-08d8ed47f5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 15:34:19.1284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUoJXQf7EPfVaJQa8rQObdh+6LI4SFjP/81HlHEysc6cmc6/EEFkR/HCcOutB0B+y5ezkgBCJTZFR/CQi5VNXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Content-Type: multipart/mixed; boundary="===============0152889646=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0152889646==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889002E50E9FCAA68054E4F7659MN2PR12MB4488namp_"

--_000_MN2PR12MB44889002E50E9FCAA68054E4F7659MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Monday, March 22, 2021 2:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: drop redundant and unneeded BACO APIs V2

Use other APIs which are with the same functionality but much
more clean.

V2: drop mediate unneeded interface

Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 25 +-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 -----------------------
 3 files changed, 3 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index e9cc3201054f..46d4bbabce75 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -515,21 +515,9 @@ static int nv_asic_mode2_reset(struct amdgpu_device *a=
dev)
         return ret;
 }

-static bool nv_asic_supports_baco(struct amdgpu_device *adev)
-{
-       struct smu_context *smu =3D &adev->smu;
-
-       if (smu_baco_is_support(smu))
-               return true;
-       else
-               return false;
-}
-
 static enum amd_reset_method
 nv_asic_reset_method(struct amdgpu_device *adev)
 {
-       struct smu_context *smu =3D &adev->smu;
-
         if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE1 ||
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2 ||
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO ||
@@ -548,7 +536,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
         case CHIP_DIMGREY_CAVEFISH:
                 return AMD_RESET_METHOD_MODE1;
         default:
-               if (smu_baco_is_support(smu))
+               if (amdgpu_dpm_is_baco_supported(adev))
                         return AMD_RESET_METHOD_BACO;
                 else
                         return AMD_RESET_METHOD_MODE1;
@@ -558,7 +546,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
         int ret =3D 0;
-       struct smu_context *smu =3D &adev->smu;

         switch (nv_asic_reset_method(adev)) {
         case AMD_RESET_METHOD_PCI:
@@ -567,13 +554,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
                 break;
         case AMD_RESET_METHOD_BACO:
                 dev_info(adev->dev, "BACO reset\n");
-
-               ret =3D smu_baco_enter(smu);
-               if (ret)
-                       return ret;
-               ret =3D smu_baco_exit(smu);
-               if (ret)
-                       return ret;
+               ret =3D amdgpu_dpm_baco_reset(adev);
                 break;
         case AMD_RESET_METHOD_MODE2:
                 dev_info(adev->dev, "MODE2 reset\n");
@@ -981,7 +962,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =3D
         .need_full_reset =3D &nv_need_full_reset,
         .need_reset_on_init =3D &nv_need_reset_on_init,
         .get_pcie_replay_count =3D &nv_get_pcie_replay_count,
-       .supports_baco =3D &nv_asic_supports_baco,
+       .supports_baco =3D &amdgpu_dpm_is_baco_supported,
         .pre_asic_init =3D &nv_pre_asic_init,
         .update_umd_stable_pstate =3D &nv_update_umd_stable_pstate,
         .query_video_codecs =3D &nv_query_video_codecs,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 517f333fbc4b..02675155028d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1285,15 +1285,6 @@ int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
                         enum smu_ppt_limit_level limit_level);

-int smu_set_azalia_d3_pme(struct smu_context *smu);
-
-bool smu_baco_is_support(struct smu_context *smu);
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state=
);
-
-int smu_baco_enter(struct smu_context *smu);
-int smu_baco_exit(struct smu_context *smu);
-
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 4120d28f782b..1bb0c0966e3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2682,48 +2682,6 @@ static int smu_set_xgmi_pstate(void *handle,
         return ret;
 }

-int smu_set_azalia_d3_pme(struct smu_context *smu)
-{
-       int ret =3D 0;
-
-       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-               return -EOPNOTSUPP;
-
-       mutex_lock(&smu->mutex);
-
-       if (smu->ppt_funcs->set_azalia_d3_pme)
-               ret =3D smu->ppt_funcs->set_azalia_d3_pme(smu);
-
-       mutex_unlock(&smu->mutex);
-
-       return ret;
-}
-
-/*
- * On system suspending or resetting, the dpm_enabled
- * flag will be cleared. So that those SMU services which
- * are not supported will be gated.
- *
- * However, the baco/mode1 reset should still be granted
- * as they are still supported and necessary.
- */
-bool smu_baco_is_support(struct smu_context *smu)
-{
-       bool ret =3D false;
-
-       if (!smu->pm_enabled)
-               return false;
-
-       mutex_lock(&smu->mutex);
-
-       if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-               ret =3D smu->ppt_funcs->baco_is_support(smu);
-
-       mutex_unlock(&smu->mutex);
-
-       return ret;
-}
-
 static int smu_get_baco_capability(void *handle, bool *cap)
 {
         struct smu_context *smu =3D handle;
@@ -2744,59 +2702,6 @@ static int smu_get_baco_capability(void *handle, boo=
l *cap)
         return ret;
 }

-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state=
)
-{
-       if (smu->ppt_funcs->baco_get_state)
-               return -EINVAL;
-
-       mutex_lock(&smu->mutex);
-       *state =3D smu->ppt_funcs->baco_get_state(smu);
-       mutex_unlock(&smu->mutex);
-
-       return 0;
-}
-
-int smu_baco_enter(struct smu_context *smu)
-{
-       int ret =3D 0;
-
-       if (!smu->pm_enabled)
-               return -EOPNOTSUPP;
-
-       mutex_lock(&smu->mutex);
-
-       if (smu->ppt_funcs->baco_enter)
-               ret =3D smu->ppt_funcs->baco_enter(smu);
-
-       mutex_unlock(&smu->mutex);
-
-       if (ret)
-               dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
-
-       return ret;
-}
-
-int smu_baco_exit(struct smu_context *smu)
-{
-       int ret =3D 0;
-
-       if (!smu->pm_enabled)
-               return -EOPNOTSUPP;
-
-       mutex_lock(&smu->mutex);
-
-       if (smu->ppt_funcs->baco_exit)
-               ret =3D smu->ppt_funcs->baco_exit(smu);
-
-       mutex_unlock(&smu->mutex);
-
-       if (ret)
-               dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
-
-       return ret;
-}
-
 static int smu_baco_set_state(void *handle, int state)
 {
         struct smu_context *smu =3D handle;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cda2f33ff4e934846b74508d8ecf9584a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637519902972470482%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DA5gcNSzu1elCbA8Xc6UB3wbKI0a1cIOvedgAzpVlMQs%3D&amp;reserved=3D0

--_000_MN2PR12MB44889002E50E9FCAA68054E4F7659MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, March 22, 2021 2:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: drop redundant and unneeded BACO APIs V=
2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use other APIs which are with the same functionali=
ty but much<br>
more clean.<br>
<br>
V2: drop mediate unneeded interface<br>
<br>
Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 25 +-----<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; |&nbsp; 9 ---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 ----------------------=
-<br>
&nbsp;3 files changed, 3 insertions(+), 126 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index e9cc3201054f..46d4bbabce75 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -515,21 +515,9 @@ static int nv_asic_mode2_reset(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static bool nv_asic_supports_baco(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev=
-&gt;smu;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(smu))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-}<br>
-<br>
&nbsp;static enum amd_reset_method<br>
&nbsp;nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev=
-&gt;smu;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method =
=3D=3D AMD_RESET_METHOD_MODE1 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO ||<br>
@@ -548,7 +536,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu_baco_is_support(smu))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_dpm_is_baco_supported(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n AMD_RESET_METHOD_BACO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n AMD_RESET_METHOD_MODE1;<br>
@@ -558,7 +546,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;static int nv_asic_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev=
-&gt;smu;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (nv_asic_reset_meth=
od(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_RESET_METHOD_PCI:=
<br>
@@ -567,13 +554,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_RESET_METHOD_BACO=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;BACO reset\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_baco_enter(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_baco_exit(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_dpm_baco_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_RESET_METHOD_MODE=
2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;MODE2 reset\n&quot;);<br=
>
@@ -981,7 +962,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =3D=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_full_reset =3D &amp;=
nv_need_full_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_reset_on_init =3D &a=
mp;nv_need_reset_on_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_replay_count =3D=
 &amp;nv_get_pcie_replay_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .supports_baco =3D &amp;nv_asic_suppo=
rts_baco,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .supports_baco =3D &amp;amdgpu_dpm_is=
_baco_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pre_asic_init =3D &amp;nv=
_pre_asic_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_umd_stable_pstate =
=3D &amp;nv_update_umd_stable_pstate,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_video_codecs =3D &a=
mp;nv_query_video_codecs,<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 517f333fbc4b..02675155028d 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -1285,15 +1285,6 @@ int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
smu_ppt_limit_level limit_level);<br>
&nbsp;<br>
-int smu_set_azalia_d3_pme(struct smu_context *smu);<br>
-<br>
-bool smu_baco_is_support(struct smu_context *smu);<br>
-<br>
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state=
);<br>
-<br>
-int smu_baco_enter(struct smu_context *smu);<br>
-int smu_baco_exit(struct smu_context *smu);<br>
-<br>
&nbsp;bool smu_mode1_reset_is_support(struct smu_context *smu);<br>
&nbsp;bool smu_mode2_reset_is_support(struct smu_context *smu);<br>
&nbsp;int smu_mode1_reset(struct smu_context *smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 4120d28f782b..1bb0c0966e3d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -2682,48 +2682,6 @@ static int smu_set_xgmi_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_azalia_d3_pme(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&gt;a=
dev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;set_azalia_=
d3_pme)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;set_azalia_d3_pme(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-/*<br>
- * On system suspending or resetting, the dpm_enabled<br>
- * flag will be cleared. So that those SMU services which<br>
- * are not supported will be gated.<br>
- *<br>
- * However, the baco/mode1 reset should still be granted<br>
- * as they are still supported and necessary.<br>
- */<br>
-bool smu_baco_is_support(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs &amp;&amp; smu-=
&gt;ppt_funcs-&gt;baco_is_support)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;baco_is_support(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int smu_get_baco_capability(void *handle, bool *cap)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
@@ -2744,59 +2702,6 @@ static int smu_get_baco_capability(void *handle, boo=
l *cap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;baco_get_st=
ate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state =3D smu-&gt;ppt_funcs-&gt;baco=
_get_state(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int smu_baco_enter(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;baco_enter)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;baco_enter(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to enter BACO state!\=
n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int smu_baco_exit(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;baco_exit)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;baco_exit(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to exit BACO state!\n=
&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int smu_baco_set_state(void *handle, int state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
-- <br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cda2f33ff4e934846b74508d8ecf9584a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637519902972470482%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DA5gcNSzu1elCbA8Xc6UB3wbKI0a1cIOvedgAzpVlMQs%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Cda2f33ff4e934846b74508d8ecf9584a=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637519902972470482%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DA5gcNSzu1elCbA8Xc6UB3wbKI0a1cIOvedgAzpVlMQs%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889002E50E9FCAA68054E4F7659MN2PR12MB4488namp_--

--===============0152889646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0152889646==--
