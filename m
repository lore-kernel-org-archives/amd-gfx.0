Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4599FC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E4861966
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E4861966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6189DD2;
	Mon, 22 Mar 2021 05:57:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B466F89DD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU8UXxrGAJr9HLEfzFuvH53VGByuFm+3zk4YnCExQUvrp8501oErQOzZ/HnsJFpzJLKOyNxtkekg6pK/bZLB2tBMZjGmTDzedftUwRxWnk03ylP5k2KLw80l+zl2Txp6IijhWILybULIEVW6vZfpXUH3sFcL72DRo9OM6MNW+Mx7OW2qHxDX6cMYTi1wH7fY7SycPC9JDoJ4bzfOA81EuaolVrPEw1riWdc8SG+7yj9biY/Zt/GP0gBtRg/q5x2g9lk11ISL6w8YKvqijzu7dg23MXE6cwL4QLft/BBLPk9MNlI7QV720b0m/LCMYVOYO5poSAFNiTFc7F+2ZS9+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTo/8xqkxneo+GL+lgHEKpX+mUTsvU/6q71kVsGJejU=;
 b=BHfO+OdYruBHk0LHDeVui/4gQedbID5A/8LaNkXRB/bpGMQ+2ESoTL/nNalZ82oRDqQjSgzzuLUj7+7NrzBBO4nO9jPMFAdyB3SPH6OJ4W2rxV7gMJpGOqVoLsDBvvtLw98DIzp6ReyyLvH/2nupylmmHMq0Mij+uQpe7OieDZ4Xbiy6+t3NPMi7YyWdCTea644+46LyMpxb2Ux3OS3Yv36Kg8Wj1Bqsa+jVsjSy5croVAZ3oH7WIz9Fvt3kpdihO2yf57kQLv8KHPgJKKArsvh+eeTo6upv+pSt13Gt7aPKDnoIx8ny93tLGsdf3o4YQyLbrL3Tk2Xpb38RPBqWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTo/8xqkxneo+GL+lgHEKpX+mUTsvU/6q71kVsGJejU=;
 b=PnLuDNSsp9T4z8geCcxDzhAu0H75ZmQKS+Uu6UKjC75uPZOC676hkcvKNzPk7/3FRixeSU8DGokLJVgmAgIDxLqNO8EeYjFn/oVla1/KPb0f8fMDaeMYPW1eKATT+da2ODp1lQn51IW2Q22Tri5/pv1wxAcwiXSL7Rhcm0lOLxw=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:23 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:23 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/8] drm/amd/pm: Add function to wait for smu events
Thread-Topic: [PATCH v2 2/8] drm/amd/pm: Add function to wait for smu events
Thread-Index: Adce3xJpkcVxz2fxRwutJOlCTIpbcw==
Date: Mon, 22 Mar 2021 05:57:22 +0000
Message-ID: <MN2PR12MB454944663D604AAE6FFDAB9D97659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=91ae6c24-0a86-4096-be34-aea3a1fefd05;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 438093fb-5648-4096-4d52-08d8ecf75ccb
x-ms-traffictypediagnostic: MN2PR12MB4302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB430256B9862FE295871657AB97659@MN2PR12MB4302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:422;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsn3pjkTO3v/UZmaVQi/GQcSDNsTvkqeIp8z/C7xszyYIc8KblDxxtVbfUSP1wuuCphCaaajIToibYYtIadYBdgy5V8KiLcoQwyyQqb8kfkfSnagqUU67Jo6prN39ETP8oqfhCGXJZtrx35NC3xLikvuohAoQGxZLtCPaF5qsXwfy9FlDgryRmM8j9V4rN0YApFuvuSKaoEnqgHX22DXgDICVsEEzuxCJ3mjJz6dE46bX1+nkopIDoHzKZdlo8xvgWzN0KfakKLSNTgmh59V+kqb2UhVxU+HfxaUa26SSobLtxMG4ElnkBbL+pDjXBVogbl4lPnQqUdtqtM/vJ3xAo4j2WUK+BGZU6YrZotq6rjvSooWvo3AXJg/iltEM4uP85SffTKPZHb8u0HzDJzKzWyI4pX2IzBABkISkG+kEDoh+u83Qm8H8oCS6N1n/tCkpBcgCXF7ApsPclOc7a1IqsNdSXWt/mv6useRRwRA1kB1dwPW/qBxu0dnnW1D5RpsQ9VjLPiGZZJc8a+2VVC0TKZw0KFqxf+yEYFGB2T5nm0RvHSgWG+eKgpZUjCv+Knfowil2xxr1kwF8uT7ic7loRJeG6P/2I7fbqOYKd/pR11wTElUvgk7jta9KQBLgPBS0IkxZPmefjVIMqokigUJC4BvTcTwQrzpT1lgYWIHK1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(64756008)(66476007)(55236004)(33656002)(66946007)(38100700001)(6506007)(8936002)(5660300002)(4326008)(54906003)(186003)(76116006)(83380400001)(7696005)(66446008)(66556008)(8676002)(71200400001)(2906002)(52536014)(55016002)(26005)(478600001)(316002)(6916009)(86362001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?00Ehg8R3kal+7lrWpPKaIPpnAfJHi6ElMQ/2qG1pWE3PBPAnOSM2eikjFl1i?=
 =?us-ascii?Q?3jhAnSCIp8Edl9yIlZ401HCZDSkO3hCrcF4weFrDWrSK8bN+oe7tPsu8/00m?=
 =?us-ascii?Q?UnBTXRxoixs2+CPUk/yGsKsWDXx90PWv4RpiGXNiehc7JO0N2T2IvzSNfvYB?=
 =?us-ascii?Q?fiCjilagDX3okD3gzkL8fY2L/Ly0/iSnXMkO7z9q15OqYXWzTL1BDWi+erA7?=
 =?us-ascii?Q?xSytjVgQCghXwg5tVDskjR8Cp6fLGfebRZzU9/2rQjkfKe+MhkWCKdQpyVFw?=
 =?us-ascii?Q?abJXPM1DRkExSFk7o/yST7ZIQA5VSL2ELA4ItIbS6Skj8dfnZJk44lonV4wr?=
 =?us-ascii?Q?VYWkPySjkTnwL0Q/vQdmYmIRFy6JPNxrED8W+jDWOn9NY0Nytkpub5Q6tgwZ?=
 =?us-ascii?Q?ljDjXCci8LW6bj9jN+FjExMxO8nJmtcVaD/JzAg7uqRzOHHqsO7pvrSCCIw6?=
 =?us-ascii?Q?tHI0JA2MblB+wT9BXHjNGoc5OSssusNiPrOvM/qGIMrtrmrP0AJZ4nRBekf9?=
 =?us-ascii?Q?Anrz1VqMreRmYTCN3Y0n95mYK4XUKMD+Nk2XTyx3Uh9wFensu9pAblG98ozu?=
 =?us-ascii?Q?x3nC7IY7IZj0ldKstYhqVWIxJCUkoPToI/CirBPoWZf0/iEaTmB2UCP2K4LL?=
 =?us-ascii?Q?xL2fypUgpCZEkBImD4eEJyj1tUe41ajz3Pp8yS+KJs/2ZiauHc5GCpcPCV/3?=
 =?us-ascii?Q?0SMKFZV0mK4SHbkerxyNIyiTMKwTdJBtcfOdQUO+W4tcFapIDsZwJRSacClf?=
 =?us-ascii?Q?OWJ6xK8gjaxI6QjmyluxkSfgaIETPnY20VVR6EoPmRMHjia+GXjF1em9GD6F?=
 =?us-ascii?Q?J06ZvRN8o5yDwGfA4QhA4HhYCD9hOPDAmIpPjU7yz87h0zeXOvvcj8DcuKJC?=
 =?us-ascii?Q?Rd1LiepBUNSyjBcRrflVmvE4aJ2Wi9Y2lkCfWoUXQGjZbTPudDNxIRrnpvNv?=
 =?us-ascii?Q?xv9jlvA7vY7HZGPzt5Q5Z2PA00NsZn/TmxAzdFKe5qt3ms6qwgBw9nBllfhQ?=
 =?us-ascii?Q?fp4Ck+PH8H2qUILDG5PwrsOXoGCqo+Ikl7b9XSC3E9OZhLThp7S7wpQnreYy?=
 =?us-ascii?Q?3/ze5p1Prwfz13gzQRczT5JbtSABkt58nkWd8d8MN0SN2EPT0lQ+UYsO1Sz2?=
 =?us-ascii?Q?TZrsX1w8jIOEmEUMRpV04cSlP3JuFnQD21tJDNQOEQ79dexoz1ggT/L+lI3f?=
 =?us-ascii?Q?iDTAtZTv2RDk9WrVyIAewsiwnm+Z9rEhKi/ETU04fTr4vQXs2smQnWulzLGo?=
 =?us-ascii?Q?1S07YXjDqKBcHD8MDryr0W8X/C/Phj0m3fPtbjAbI+pTUNqodBKuzBqo3ZeD?=
 =?us-ascii?Q?ktw0PLlAIvMICYByFG1bq0wW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438093fb-5648-4096-4d52-08d8ecf75ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:22.9236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQd9xaMiSmLrCWhIPBvhYPrPedceAr6gzgeGvBgwS7Zjoz9pk0SdwPOhf6mXoAZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0304558379=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0304558379==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB454944663D604AAE6FFDAB9D97659MN2PR12MB4549namp_"

--_000_MN2PR12MB454944663D604AAE6FFDAB9D97659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: Add function to wait for specific event/states from PMFW

v2: Add mutex lock, simplify sequence

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 15 ++++++++++++++-
drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++++++++
2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 2edb634bc1c6..5bd16d4fb00d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -195,6 +195,11 @@ struct smu_user_dpm_profile {
               uint32_t clk_dependency;
};
+enum smu_event_type {
+
+             SMU_EVENT_RESET_COMPLETE =3D 0,
+};
+
#define SMU_TABLE_INIT(tables, table_id, s, a, d)            \
               do {                                                        =
                                \
                               tables[table_id].size =3D s;                =
\
@@ -338,7 +343,6 @@ struct smu_power_context {
               struct smu_power_gate power_gate;
};
-
#define SMU_FEATURE_MAX    (64)
struct smu_feature
{
@@ -1167,6 +1171,12 @@ struct pptable_funcs {
                * @set_light_sbr:  Set light sbr mode for the SMU.
                */
               int (*set_light_sbr)(struct smu_context *smu, bool enable);
+
+             /**
+             * @wait_for_event:  Wait for events from SMU.
+             */
+             int (*wait_for_event)(struct smu_context *smu,
+                                                   enum smu_event_type eve=
nt, uint64_t event_arg);
};
 typedef enum {
@@ -1372,5 +1382,8 @@ int smu_gfx_state_change_set(struct smu_context *smu,=
 uint32_t state);
 int smu_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
+                                    uint64_t event_arg);
+
#endif
#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 05f00900d10c..3d504038d101 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3008,3 +3008,18 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D =
{
               .force_clock_level       =3D smu_force_ppclk_levels,
               .print_clock_levels      =3D smu_print_ppclk_levels,
};
+
+int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
+                                    uint64_t event_arg)
+{
+             int ret =3D -EINVAL;
+             struct smu_context *smu =3D &adev->smu;
+
+             if (smu->ppt_funcs->wait_for_event) {
+                             mutex_lock(&smu->mutex);
+                             ret =3D smu->ppt_funcs->wait_for_event(smu, e=
vent, event_arg);
+                             mutex_unlock(&smu->mutex);
+             }
+
+             return ret;
+}
--
2.17.1


--_000_MN2PR12MB454944663D604AAE6FFDAB9D97659MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">v1: Add function to wait for specific event/states f=
rom PMFW<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Add mutex lock, simplify sequence<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; =
| 15 ++++++++++++++-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++=
++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 29 insertions(+), 1 deletion(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h=
 b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 2edb634bc1c6..5bd16d4fb00d 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -195,6 +195,11 @@ struct smu_user_dpm_profile {<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_dependency;<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+enum smu_event_type {<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_EVENT_RESET_COMPLETE =3D 0,<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">#define SMU_TABLE_INIT(tables, table_id, s, a, d)&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables[table_id].size=
 =3D s;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -338,7 +343,6 @@ struct smu_power_context {<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_power_gate power_gate;<o:p></o:=
p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">#define SMU_FEATURE_MAX&nbsp;&nbsp;&nbsp; (64)<o:p><=
/o:p></p>
<p class=3D"MsoNormal">struct smu_feature<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1167,6 +1171,12 @@ struct pptable_funcs {<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* @set_light_sbr:&nbsp; Set light sb=
r mode for the SMU.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_light_sbr)(struct smu_context *s=
mu, bool enable);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /**<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * @wait_for_event:&nbsp; Wait for events from SMU.<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*wait_for_event)(struct smu_context *smu,<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; enum smu_event_type event, uint64_t event_arg);<o:p></o=
:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;typedef enum {<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1372,5 +1382,8 @@ int smu_gfx_state_change_set(s=
truct smu_context *smu, uint32_t state);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;int smu_set_light_sbr(struct smu_context *smu,=
 bool enable);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_wait_for_event(struct amdgpu_device *adev, =
enum smu_event_type event,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint64_t event_arg);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu=
.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 05f00900d10c..3d504038d101 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -3008,3 +3008,18 @@ static const struct amd_pm_fu=
ncs swsmu_pm_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D smu_force_ppclk_levels,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_levels&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D smu_print_ppclk_levels,<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_wait_for_event(struct amdgpu_device *adev, =
enum smu_event_type event,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint64_t event_arg)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev-&gt;smu;<o:p></=
o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;wait_for_event) {<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;wa=
it_for_event(smu, event, event_arg);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB454944663D604AAE6FFDAB9D97659MN2PR12MB4549namp_--

--===============0304558379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0304558379==--
