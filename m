Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE37C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 14:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4FE207B1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 14:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4FE207B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B14C6EA6E;
	Wed,  9 Dec 2020 14:26:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61C16EA6E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 14:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8wxVyYV0GRIQCUQX3fOmV55hRT2+OGtyEkrl/ZydiS1LquRmCwASituRpUZ8jyAs82BlgJczwTAUMwlSiS2na8MOC0/9leiCD8E8hBp3txGydeyGumKvk6kJq961Ahl1wcuHQfbvuMlGyKW+6iE4prSE72se+4tcfu9Le7TfanmB5fcPR/t7hmQGElPb1Vai0TzHrW68Xa9mBg/5SoII3Wb88bZxoXos/nP//hHMlHlPRsznk3+ub/IGkyhCFbyqT5WvRHYvrC1oRu5JUseR9I+XBpuK5I9BoLHxDa+vRdz8dpqtCujERA3WMzQkX+XjqffEbAB6I4qROPSVjsdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS71j6hBGjJ9F2rYCfPtWcXQzNfeiRkAhTTkKZriFwc=;
 b=ktXehQK2oM3/xpfdFBCfqQ73saCGYm8fti4mHoIFr9Zi/CeAdecXmTSYle/u4iAf1541NCqTyjY+Ek4Nk3Np8SYIQO5pNR3CNHHfrwnvThq80HtQcTUubJXhzQr/ck8r8aruOmzXZSDFO5y4+XMD7wHHCFjiOZFTGaG31cY8Iq1+nghgx+kRNUsUrmMgFaYUmY6m+FV92fiOvUwk9mE5Mi5FxnoDdU8tVbYC2jYFHZKPVmSoFCdOvPuK+tNhsvLAJ5fKZtQbMQcIF880RUNORPscoLcb2YJqpUmMVUi9dJOstC57nveCCQXjyxBF9f6vq7L7d5kzMOaYhHDEv2TlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS71j6hBGjJ9F2rYCfPtWcXQzNfeiRkAhTTkKZriFwc=;
 b=NwLqAihzli4Je2WW0jySw5tG986viN02HDdZG7mojGdEW/8NqeoV0DvmxMoFGP7b8iKYR59v+t7y8JB2xbs98SetpnFgdRqd54bdYI3DxJr7/OXHqhvoIWz3mT8TM8dAi4EuvwsLGSSR8vFG16s/cR6dZoJsAeW1P+EB0kgpzv4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 14:25:57 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Wed, 9 Dec 2020
 14:25:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: typo fix (CUSTOM -> COMPUTE)
Thread-Topic: [PATCH] drm/amd/pm: typo fix (CUSTOM -> COMPUTE)
Thread-Index: AQHWzgaFgKio2alLOEKMZqFVBkiPOanu0kpD
Date: Wed, 9 Dec 2020 14:25:57 +0000
Message-ID: <MN2PR12MB448802439D276DC0DF74432BF7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201209083702.149435-1-evan.quan@amd.com>
In-Reply-To: <20201209083702.149435-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-09T14:25:57.032Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65d5e102-5585-4ff6-fb9c-08d89c4e5865
x-ms-traffictypediagnostic: MN2PR12MB4469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44696DDF5597944AEF9F9D4BF7CC0@MN2PR12MB4469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:220;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LveXBy1FF0fyHgYwcHHIKYXJmk6ScieN4w1QBzeJ6n+ZX4krpRrNwRNSDgzpxZczkUe0ik0OhXbH6nfSMrL5apaetJej/H7AZuZPjgaTS//59JlwN/3tuc/vD6n6a/KW8twNO05UxCaSNNXVIn0GkmbXfVVEj4FsSU5rZqxUj2pbVRypM3K7S9CXbGiVxvCDpM2PKR9r3hBi72P9q/RXQoBH/PLzWf0ri60rwW2JymUCvd7gDXlydorNObNINCTHR0M2Nx8n5o+DS7oZYeLO/sqEM5S0lYgB06wYqAyJzPXFVoJD6p4Ha0ZZeKa9dpqkY+FpPovJAADB1Rb4EOO6OQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(8676002)(8936002)(6506007)(66476007)(64756008)(508600001)(53546011)(55016002)(110136005)(7696005)(66446008)(19627405001)(66946007)(9686003)(5660300002)(186003)(2906002)(66556008)(52536014)(71200400001)(83380400001)(86362001)(26005)(76116006)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PW3G3xxAu/LIZuLcxu04LG5CwuBSOdnl3uWYTSFNt5IVF7084wo6W80iN426?=
 =?us-ascii?Q?aF9HLJSweTtr84GKt8KIImW5fXirZybkHEMAuCKLQumdlEoe6yjeLvA/Do0o?=
 =?us-ascii?Q?1ahICIvoCEKE5j1uGpA4XPlb6PieFMDh83NjdHB+lenAk7KjS7vMXyi3qfaa?=
 =?us-ascii?Q?rcmh+ohrPS9n3L4dyVkqHTsAq0GJ9RCymiHQe4Ru5Q8cEyTyJd2JFhidQftT?=
 =?us-ascii?Q?1FtPdrQYMQt6cyEqNMPHX00YuYFaqi6n9ruU8d59cjshitdKdQQ5lA8bQNTh?=
 =?us-ascii?Q?PSB7m9bQA10sO8eGxLEvncZPCulYSU3RnCRbCRoleOs6qVK3h/+8AvRG7NlF?=
 =?us-ascii?Q?ZRzfUTruIwl3eLTJLg9MSsM1FDFN1CzwFtkuUkb/pR4Zt8WHNBsMxaFRREKL?=
 =?us-ascii?Q?qaqos5FDLEvuL3/51RG2ytaESGStvyaI0EUBqtMG55wUuRNeOSIYW8jkajYe?=
 =?us-ascii?Q?VKtF+daxuRcII8bJlNrLVjqCN4fhehxDdddW2Mptv4UPX1oKFBSD4xm5Pk8q?=
 =?us-ascii?Q?5xx37Qy/Bl9K3PELfKM7jQes83opTq/v2XpeB3MCBHjA1CF5FtwY60FDg/wG?=
 =?us-ascii?Q?9E2o60hXOvl9DuLjtKuHII4q2gi7OK06n3YUzzs1qFp5ij7Q/dneeWkh1HZ5?=
 =?us-ascii?Q?nMHLZKG2H4RZLeAa2s0VdU9PwehBkbotM+3C9vaJlLx6UPpcatNUldn3mfkV?=
 =?us-ascii?Q?RLO9cJQlDPfKeeHLqrQ3Xp6XqqA6koS+iG1PMrKKc1RSsPCi98fGN3awz0uF?=
 =?us-ascii?Q?+ucCD5LSVCMeBz7cTcG34rvpOTiMikq173nhoQwe69VGEiTkUvw3jy1UO0/L?=
 =?us-ascii?Q?0CZ3mY7Zw/e5t9XCVlnXe14KQVjkAYn1+VTUL3XgspjfW3rhun8OfUTn0wTN?=
 =?us-ascii?Q?P2xWLzwxb29A/BahfkeKggB403RKeYJDok+b+mZxDpM2LTAhyVujoEVehAYJ?=
 =?us-ascii?Q?J31FYTJiZ4JdGCaPh4wEw9Us4S+sBxjN16nz4RvkjvY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d5e102-5585-4ff6-fb9c-08d89c4e5865
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 14:25:57.6240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o98+HdXWQOdvcDkzk6Ixx0WWG0NX7RnaGYwehuJiOvlpuuqPLKtfkopMx2/1P18tlqugTUTmHwZSG8+HfBk7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Content-Type: multipart/mixed; boundary="===============1449626210=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1449626210==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448802439D276DC0DF74432BF7CC0MN2PR12MB4488namp_"

--_000_MN2PR12MB448802439D276DC0DF74432BF7CC0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, December 9, 2020 3:37 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: typo fix (CUSTOM -> COMPUTE)

The "COMPUTE" was wrongly spelled as "CUSTOM".

Change-Id: I44a6c93ea8badec2af883eb5b39261789baba036
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3fb70cac72ea..23d0dc31789f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -220,7 +220,7 @@ static struct cmn2asic_mapping sienna_cichlid_workload_=
map[PP_SMC_POWER_PROFILE_
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,          WORKLOAD_P=
PLIB_POWER_SAVING_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_P=
PLIB_VIDEO_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_P=
PLIB_VR_BIT),
-       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PP=
LIB_CUSTOM_BIT),
+       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PP=
LIB_COMPUTE_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_P=
PLIB_CUSTOM_BIT),
 };

--
2.29.0


--_000_MN2PR12MB448802439D276DC0DF74432BF7CC0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
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
<b>Sent:</b> Wednesday, December 9, 2020 3:37 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: typo fix (CUSTOM -&gt; COMPUTE)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The &quot;COMPUTE&quot; was wrongly spelled as &qu=
ot;CUSTOM&quot;.<br>
<br>
Change-Id: I44a6c93ea8badec2af883eb5b39261789baba036<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 3fb70cac72ea..23d0dc31789f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -220,7 +220,7 @@ static struct cmn2asic_mapping sienna_cichlid_workload_=
map[PP_SMC_POWER_PROFILE_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_=
PROFILE_POWERSAVING,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
WORKLOAD_PPLIB_POWER_SAVING_BIT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_=
PROFILE_VIDEO,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_VIDEO_BIT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_=
PROFILE_VR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_VR_BIT),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COM=
PUTE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; WORKLOAD_PPLIB_CUSTOM_BIT),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COM=
PUTE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; WORKLOAD_PPLIB_COMPUTE_BIT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_MAP(PP_SMC_POWER_=
PROFILE_CUSTOM,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_CUSTOM_BIT),<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448802439D276DC0DF74432BF7CC0MN2PR12MB4488namp_--

--===============1449626210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1449626210==--
