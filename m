Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B3C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCEB22CF7
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 04:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCEB22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BEB6E453;
	Mon, 21 Dec 2020 04:09:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C676E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 04:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch+R8atkZ1jhToHUWlDlrdSnRDSo0yeQ60iw1KaPLNVdHHP1C4IqLUDCYpL0gk3jembDQvrr/HWwH1u5Qj8vO8jOR/JdFNwWI3/0elRg6TCdBDHRgq+qMeMpgFRMIlmceDVYKMfsg1muudU9UiO39XDtvSS9l7loSMAfUAZ4k5VFQXe9Uq3vP6raF7T4qZel0a0Yb3NdChO4BsDRtsVwCwPwWQqjB3cidqSpu3uMpYQjVtZ1anMF+CwmDhwZxwOsfinsOnwp+SZtlG6F6jEyx0PFULm8sa1UepMgcTBtdNPHFce/7y7ZyhAbVw7m/LF9VJxezt3FaEFYVSSKFdCd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qIg4rgJd/KQUV5WG63l7XdcVYZTdPX1caCbIm5u6Jw=;
 b=EZCtCo6tBcc618zqhrfylgwp1UdztpNlvsUp1K/DdqqN5ouuiaQ3JzqdxNs0h9s2JS2rPdWgKaR+nAshUGRxwCy8XpTpMhHp6mLRRzaZx86kbllWt+5zR0KJRYpHW+RK/iLLrJysOMG9Vy1x5npnBzeo19ziJQQxHew8xu0VoxuOLIJV5d6UIE4aBhu6+zFGT60GGg4/3RQrFML04M2o5wx6RGF4Oh4YFW/djfVdNM58R8Sat3u7H8oVKZT3F7VORHhD95weqmuVojw7CHuR/vuAfmxuHU719F4SmF0MFZ4G/G3kX+DYRM1u6QFWHPrBe/CiVn69565mPEN5sC1z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qIg4rgJd/KQUV5WG63l7XdcVYZTdPX1caCbIm5u6Jw=;
 b=S1+SGgEwA8cxpG8//CyDFEmCLD+pVZXcYCejToOnxS6dVma0JCiaYssIHhfWxh8gEiIBsre5ugOaAASIas+sAe3amx04+gxHad91irYJlAtCOAXUcC5ZbqAG9WXCnHB+HeSMRuTjYiwdMOvXXOgeZrq2J8AjHnaThTtNGsAQemc=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 04:09:49 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 04:09:49 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/8] amdgpu/pm: Powerplay API for smu , added
 get_performance_level
Thread-Topic: [PATCH 1/8] amdgpu/pm: Powerplay API for smu , added
 get_performance_level
Thread-Index: AQHW1aDFevrpQB2ibkuk+HLvEF7mc6oA8DcX
Date: Mon, 21 Dec 2020 04:09:49 +0000
Message-ID: <MN2PR12MB30224CFCB8144D12EE982B76A2C00@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201219004831.13527-1-darren.powell@amd.com>,
 <20201219004831.13527-2-darren.powell@amd.com>
In-Reply-To: <20201219004831.13527-2-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T04:09:49.750Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [111.42.32.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83e00083-2981-4b13-dfe9-08d8a56642a7
x-ms-traffictypediagnostic: MN2PR12MB3535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3535B4B8A3474C5D7A45ECCFA2C00@MN2PR12MB3535.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxiNVPNAWTNb/1KVlvwDW5Ke213jiFD42KvOJIFow9F6P39h3n6a9kMKYE3MJcaGZEyAZXyxXmT8UiiTwzSHWiemiwIenbKiR8mg76ifZs1aIsNdgO2tiYK2M9g5PqOugb92PK3yRENttZAEtIczeXMcd3NwGgZAsNgXDxSewVKrVlf5YG88ezUZu0fQAtocpxa3u9cEWzNxb7TlgmnBTTM9Z+upD43Qv/vy9TI4M3cr70AJjqJh6oQedUT03/rmYCmsLxWOmJCIaE4e+yGADEbkWbYiRpw/SuOtHXBfg/cwgz/MwELA/hPhebPEEReJEH5dOzvA/2SCr3SCCMdaiy7eRYsf1gfCae/cxeivbIDK0RytbwcHFdRtmVCTFZFtEu7B2Zu9Oc0BpNCCJH9If0IyaLPj2EOC28wRQqg7SX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66946007)(166002)(33656002)(110136005)(2906002)(186003)(66556008)(71200400001)(76116006)(91956017)(66476007)(86362001)(19627405001)(83380400001)(52536014)(64756008)(45080400002)(966005)(66446008)(8676002)(5660300002)(55016002)(8936002)(478600001)(7696005)(26005)(4326008)(9686003)(6506007)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?IeWivYXkCoKlR1/W2QdIPfOHq2a10uuoPsLqyRHojODqnLUg2aj37Y+G6u?=
 =?iso-8859-1?Q?SEt5fDXsoaWPOqvkNPMgrm3JVx6arN+3BkfxbAIlU6wPkCFZlb1UsDg80p?=
 =?iso-8859-1?Q?VIShol/xDmbkPhT0K0QyAWeJqwwCJkgGolMl9p3XMTdvl7w9uKqhJbdvF+?=
 =?iso-8859-1?Q?phJBPext41d5gjzK9yK16s95ZYHKERB1elVHbZmrFa47umnqYRYXlLXtp5?=
 =?iso-8859-1?Q?TjQCn/Gs1WPm3xyTbeRgAUkgWF/H+8exwaad5CDeD3j/W6sUtu2zJ51PaN?=
 =?iso-8859-1?Q?CQG/fYrShIs+dFX0Xlr5LckiyE1+m+KvmPWLbI8M6gAt3Dl+bRfSIB/EgO?=
 =?iso-8859-1?Q?5IpBU1CBHiU2H/CndsvACjDwEw3vuT4rXwLJqs7yFlEqDtXYYI6qDrWTGs?=
 =?iso-8859-1?Q?6ar3sR0AgPAO5LJE2CKIhi6rtV5C4EPuT+I1rkLGMlg/HhX8x5AJ5qOyY2?=
 =?iso-8859-1?Q?AYlmfyrdMZFgFn6waB7t4Hx0IbnsLn25m7UpgRVIZT7qxDDm6NaeAhFyor?=
 =?iso-8859-1?Q?wqVIDOpusK4VStN2sMegZcRSbvMCJMrvZBwIYh/+z50148FofsiVtQZ+yN?=
 =?iso-8859-1?Q?6Azc0udu44qcQn6b77Luy9MK46f/puOHGtaOXidPk9tQxCkMjEdevSAGqK?=
 =?iso-8859-1?Q?quwI56Ba+IMJQCcJUrvtR/TBbL2UygxeU5CIyO8+4D3TWVQkRslnrCz6NM?=
 =?iso-8859-1?Q?3FhEq8KbugSmR5x2CgY7OvbuEzOZ9TSdxTQmGs+MObxeueASTxVUkLpwbZ?=
 =?iso-8859-1?Q?X/r2KYVImo4NHeR6UBrwN90pDqGvEymJTsnITTiWTB+MCnnFfJJez2VIGw?=
 =?iso-8859-1?Q?9jEfz8/bGbOu7q/J8rvc/upJ/c64HVxlzLOI/jhTydwuf+EWDjYmX7zZxo?=
 =?iso-8859-1?Q?u78lt+PqZcv1MymskGG9Y9r50Pw8PGrBzcqbfv6V/fC/PMLQvHzIMQewf6?=
 =?iso-8859-1?Q?uSxmIMgtkcXV6u2oByVQ7dIVZGa69wZMuul2poioMGM/i1dGCyvEVdzj3Z?=
 =?iso-8859-1?Q?d2wLDZIkS1S9QtWeY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e00083-2981-4b13-dfe9-08d8a56642a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 04:09:49.5431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CxCYJmrHzrS9SufLDkL+cMJ9zscVyu7tt7V+x5wtwYjEDR1g+7nIX007DY/usKL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Content-Type: multipart/mixed; boundary="===============1124035906=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1124035906==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30224CFCB8144D12EE982B76A2C00MN2PR12MB3022namp_"

--_000_MN2PR12MB30224CFCB8144D12EE982B76A2C00MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Darren P=
owell <darren.powell@amd.com>
Sent: Saturday, December 19, 2020 8:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 1/8] amdgpu/pm: Powerplay API for smu , added get_performan=
ce_level

Modified Functions
  smu_get_performance_level() - modifed arg0 to match Powerplay API get_per=
formance_level

Other Changes
  added a new structure swsmu_dpm_funcs to hold smu functions for Powerplay=
 API
  removed special smu handling from amdgpu_get_power_dpm_force_performance_=
level

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 +---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 7b6ef05a1d35..0008bbe971d6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -280,9 +280,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_l=
evel(struct device *dev,
                 return ret;
         }

-       if (is_support_sw_smu(adev))
-               level =3D smu_get_performance_level(&adev->smu);
-       else if (adev->powerplay.pp_funcs->get_performance_level)
+       if (adev->powerplay.pp_funcs->get_performance_level)
                 level =3D amdgpu_dpm_get_performance_level(adev);
         else
                 level =3D adev->pm.dpm.forced_level;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 89be49a43500..10914f3438ac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -743,7 +743,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enu=
m smu_clk_type clk_type,
                            uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk=
_type,
                             uint32_t min, uint32_t max);
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *sm=
u);
+enum amd_dpm_forced_level smu_get_performance_level(void *handle);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forc=
ed_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..36d18668ec99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -46,6 +46,8 @@
 #undef pr_info
 #undef pr_debug

+static const struct amd_pm_funcs swsmu_dpm_funcs;
+
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
         size_t size =3D 0;
@@ -428,6 +430,9 @@ static int smu_early_init(void *handle)
         smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
         smu->smu_baco.platform_support =3D false;

+       adev->powerplay.pp_handle =3D smu;
+       adev->powerplay.pp_funcs =3D &swsmu_dpm_funcs;
+
         return smu_set_funcs(adev);
 }

@@ -1569,8 +1574,9 @@ int smu_switch_power_profile(struct smu_context *smu,
         return 0;
 }

-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *sm=
u)
+enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
+       struct smu_context *smu =3D handle;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
         enum amd_dpm_forced_level level;

@@ -2549,3 +2555,7 @@ int smu_gfx_state_change_set(struct smu_context *smu,=
 uint32_t state)

         return ret;
 }
+
+static const struct amd_pm_funcs swsmu_dpm_funcs =3D {
+       .get_performance_level =3D smu_get_performance_level,
+};

[kevin]:
could you change this name to "smu_pm_funcs" or others,
not of all fields is DPM related functions in data structure of 'amd_pm_fun=
cs'
it will make some confused for developers.

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Ce82fe9048c4d43857c9908d8a3b7e561%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637439357533667974%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DvG=
F8e0xTEWyAqKusXbH23Ez4k5Lzz6RmORQXN6unJz8%3D&amp;reserved=3D0

--_000_MN2PR12MB30224CFCB8144D12EE982B76A2C00MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Darren Powell &lt;darren.powe=
ll@amd.com&gt;<br>
<b>Sent:</b> Saturday, December 19, 2020 8:48 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/8] amdgpu/pm: Powerplay API for smu , added get_pe=
rformance_level</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Modified Functions<br>
&nbsp; smu_get_performance_level() - modifed arg0 to match Powerplay API ge=
t_performance_level<br>
<br>
Other Changes<br>
&nbsp; added a new structure swsmu_dpm_funcs to hold smu functions for Powe=
rplay API<br>
&nbsp; removed special smu handling from amdgpu_get_power_dpm_force_perform=
ance_level<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 4 +---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++++-<br>
&nbsp;3 files changed, 13 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 7b6ef05a1d35..0008bbe971d6 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -280,9 +280,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; level =3D smu_get_performance_level(&amp;adev-&gt;smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;g=
et_performance_level)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; level =3D amdgpu_dpm_get_performance_level(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; level =3D adev-&gt;pm.dpm.forced_level;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 89be49a43500..10914f3438ac 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -743,7 +743,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enu=
m smu_clk_type clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t *min, uint32_t *max);<br>
&nbsp;int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_typ=
e clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t min, uint32_t max);<br>
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *sm=
u);<br>
+enum amd_dpm_forced_level smu_get_performance_level(void *handle);<br>
&nbsp;int smu_force_performance_level(struct smu_context *smu, enum amd_dpm=
_forced_level level);<br>
&nbsp;int smu_set_display_count(struct smu_context *smu, uint32_t count);<b=
r>
&nbsp;int smu_set_ac_dc(struct smu_context *smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index cf999b7a2164..36d18668ec99 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -46,6 +46,8 @@<br>
&nbsp;#undef pr_info<br>
&nbsp;#undef pr_debug<br>
&nbsp;<br>
+static const struct amd_pm_funcs swsmu_dpm_funcs;<br>
+<br>
&nbsp;size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
@@ -428,6 +430,9 @@ static int smu_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D=
 SMU_BACO_STATE_EXIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_=
support =3D false;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle =3D smu;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs =3D &amp;=
swsmu_dpm_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_set_funcs(adev)=
;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1569,8 +1574,9 @@ int smu_switch_power_profile(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *sm=
u)<br>
+enum amd_dpm_forced_level smu_get_performance_level(void *handle)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level;<br>
&nbsp;<br>
@@ -2549,3 +2555,7 @@ int smu_gfx_state_change_set(struct smu_context *smu,=
 uint32_t state)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
+<br>
+static const struct amd_pm_funcs swsmu_dpm_funcs =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level =3D smu_get_pe=
rformance_level,<br>
+};</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">could you change this name to &quot;smu_pm_funcs&q=
uot; or others,&nbsp;<br>
</div>
<div class=3D"PlainText">not of all fields is DPM related functions&nbsp;<s=
pan style=3D"color: rgb(0, 0, 0);">in data structure of 'amd_pm_funcs'&nbsp=
;</span><br>
</div>
<div class=3D"PlainText"><span style=3D"color: rgb(0, 0, 0);">it will make =
some confused for developers.</span></div>
<div class=3D"PlainText"><span style=3D"color:rgb(0, 0, 0);background-color=
:rgb(255, 255, 255);display:inline !important"><span><br>
</span></span></div>
<div class=3D"PlainText">-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Ce82fe9048c4d43857c9908d8a3b7e561%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637439357533667974%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DvGF8e0xTEWyAqKusXbH23Ez4k5Lzz6RmORQXN6unJz8%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Ce82fe9048c4d43857c9908d8a3b7e561%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637439357533667974%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DvGF8e0xTEWyAqKusXbH23Ez4k5Lzz6RmORQXN6unJz8%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30224CFCB8144D12EE982B76A2C00MN2PR12MB3022namp_--

--===============1124035906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1124035906==--
