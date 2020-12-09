Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B93C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 14:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68AE23B42
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 14:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68AE23B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EBB6EA28;
	Wed,  9 Dec 2020 14:17:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160296EA28
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 14:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRPTnBrmIn3JO/fhztOPQ1sU5Pp4HrymDJee4OBz3qTDTVBn16Ze26Ztdzs5VTEoRBQ/42QmZnSBwMQ6HaxxprCam78VFF4XbN/DNLJ0ma8flaGcc89beT0ILfz4UYzWNIpClhp3QO6sTIGjykWBknrssn+xmM0FhGuo05b7qIZ/HR1l/kqhAsjiw0OYABGYR1HOwS1lCR6ZQ7m+b/mqh8JjkReR66T5FnqT74XUTlkLp70LTq63qZJ89saM5YyoRNVVsEWPTq6BgTwi+SNTOR8/uDrku85O4O2YWbBs6ndc9JgSvSra514nLdXBHO5dUpPJE2U3XRDoGE+pEQOl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiDBbIUwkEV6rOZYtlIfkIOE/KhiUOb7IW7iqBcAB+E=;
 b=N9xQ8KoOBocVq7edJxhewQGk2xRWuy3gziUJNoXScsMxXdYld6zAu5jRaLB/svSc+lmL2RL/gOne/JG1Q/7Qp8aBCBKzwOlt067Jbvbt2Qx4GdR7YskKTwFzzmBmIhGI2a03F3Yc+CvYWts01HT8Ib8bd2u9ScmxQfPUQcvlg1eW9ocSoXwx8SXr5jemc6lXQ5zW6fJSiAMN6qwHH50wu9KJj3nMqNWzxffY7LsnwWrncwIT6vSJOR/QkD4z8HbJenzkJdGlrmuwwgV5TZYSrFXyM4Yaey8pql8OK1egwfkMNTewGne3mCoEorIoMLaXu6m2w5eCHvXxWwtyig+DZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiDBbIUwkEV6rOZYtlIfkIOE/KhiUOb7IW7iqBcAB+E=;
 b=Deg2CUyQLAjfhD7xdn9HHBc6Er53TQOjk/eXiDBC20fsqZALTZEax50yflvUQKMoEqEZqB8W5OcI+I6+RhllIJe8nt219p5/Ck5E6k8yWk9ZQrYynhNa2xIlMloUOn2UIFqg4SDpzNnJKC+vbOAUAiLJcYOmitEet6svoLxL0hE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 14:17:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Wed, 9 Dec 2020
 14:17:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fulfill the sienna cichlid UMD PSTATE
 profiling clocks
Thread-Topic: [PATCH] drm/amd/pm: fulfill the sienna cichlid UMD PSTATE
 profiling clocks
Thread-Index: AQHWzfWLQH6m/yToGEWWH10XDkfdj6nu0Btq
Date: Wed, 9 Dec 2020 14:17:38 +0000
Message-ID: <MN2PR12MB44880ED6E1F7CA2B5835DEECF7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201209063527.147464-1-evan.quan@amd.com>
In-Reply-To: <20201209063527.147464-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-09T14:17:37.992Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7107496c-574e-4134-5165-08d89c4d2ef0
x-ms-traffictypediagnostic: BL0PR12MB4738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4738EBC2CF69060F5C09DB19F7CC0@BL0PR12MB4738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQlN7q4pERye24W1grXhxM8OZEn3BfObLngjuRU+g+DQwLVt7zpp4EOSx5WjQ2lhkVq3G1bSJKccR/BbF6I9NVpbIjeSH9BJEaD9ATVWEao7kQuf+h/w9ujemuTm6IjGlmK0VgGyc7zYSA9vE5uxVFA2omeYyLF31/XLznT9CwosZPGfCbsxbJ5W/u3d8QgBdHJRb66fmjnDUxXDvBQ734V2JtiVqy873FhywUlpd9YTHvaHXuwQqwKJ09NFO5ol55WMBytzOr30Momqqvhs9bdWWpJpW2+tXF3UIYUw9H7BJE3QMJsPvF6p3J8ba7lq6h9W5UzQ8kpbKjpaO14LXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(52536014)(66946007)(66476007)(66446008)(66556008)(7696005)(6506007)(508600001)(76116006)(5660300002)(64756008)(186003)(26005)(110136005)(8676002)(83380400001)(8936002)(53546011)(55016002)(9686003)(86362001)(71200400001)(33656002)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8OuS7BGbrk/4wHEruwnE9Y3e2064IUSutsNxCmMzA0w4oE7uNFyInmGjwDZY?=
 =?us-ascii?Q?pbwWjFvTl+paJvePhMvZpTaw6sH0j0kqsGny1ChQjwv2aSRRztfGTdaQjEf0?=
 =?us-ascii?Q?ilyvbzjRVrVxrUy6SB1PAmsRtBSunPqR0+bmro7hEM6TRG5wZV/7RYlkOKas?=
 =?us-ascii?Q?LMAPQSoO9/1uYYxbs5pGzkZ3Hes/ffKv1MMJHt1LQt99yYeVrxBLcT5rcUI8?=
 =?us-ascii?Q?d3FZt0jXOk/3yWuJ4RH4B1IXIF1KfgraOp/hWRwct+sdOwaIxInOQiFu2pfZ?=
 =?us-ascii?Q?sdg5EAIdp+6XSV25cfVPbM5yJULUGkH6T48b8lmRbaasrtu2GBXIGU3xhIAl?=
 =?us-ascii?Q?OMKMpxKi9kEtBw5dUNdtXukeISIRU3ad4Mr2z4hXva8RYhNahcZzKloNbfS2?=
 =?us-ascii?Q?ljKOcJ3/+adEDF6pj89lMRStsWDS9Y+ckVbE93s0IWdBimn/CXCslmHuqnsr?=
 =?us-ascii?Q?G267vyix68jug1kW/S3DhwfBpsGuEib/fROnLyOdaCNpB7Ez7IMENG9anKC8?=
 =?us-ascii?Q?cXF7IP9ryz9xfwuGqRrrEf6Z5D5OHeceXP2oIuXTE9UChaZXQ2GSNzWw/cpS?=
 =?us-ascii?Q?OObmLRlhJR90msAJY0UYT+v7lDrej/w4kjrc3jEBKgvUHhtrmFDsH4N1aMiQ?=
 =?us-ascii?Q?YnxgtH9TkOMrApAXZHIQ0qkRkzO8EB3WzVaLo/gYGnEKHz0UKdy6uDDgc2yO?=
 =?us-ascii?Q?FE0fiu2/p2ODV9YWbxwIq0AIgdgf5t2qaB3AEC91dncggpyNY16vD+fkgtR7?=
 =?us-ascii?Q?Q4HJtshGB1sFcS2n2RDxR5IEkHSKyPyZNsf6+Nqf4nngIwvBuOOcqUIQKnz4?=
 =?us-ascii?Q?vtmYJuSoeK3Xca592XDHBv2S4DUHNT553KjlP8IHj+5N/q5L4ArfY9mvRMdd?=
 =?us-ascii?Q?tPMqzZ5Mn4Gf/MXeKZ3tcdu2cwIoJA/xK5rnqtX7QO1eBFx5PysxAHUVHiAG?=
 =?us-ascii?Q?HAPDFJEsR2kM3nFfY5rOOSCm6jM3zQH49odNcKYADzk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7107496c-574e-4134-5165-08d89c4d2ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 14:17:38.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9cm2VSRjVAJMT57eG1jGzLV6K3JKq8EhxiZE5LIQmEtt/Vg2woz91dXS/iHnpx3LJUcNSA4JML/ZK2YLLPviw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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
Content-Type: multipart/mixed; boundary="===============1046793365=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1046793365==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880ED6E1F7CA2B5835DEECF7CC0MN2PR12MB4488namp_"

--_000_MN2PR12MB44880ED6E1F7CA2B5835DEECF7CC0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, December 9, 2020 1:35 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: fulfill the sienna cichlid UMD PSTATE profilin=
g clocks

Fulfill the UMD PSTATE profiling clocks of sienna cichlid.

Change-Id: Ib9078c73d3fbd786080449255645ae8b9f879092
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 74cf027e4a41..3fb70cac72ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1341,12 +1341,18 @@ static int sienna_cichlid_populate_umd_state_clk(st=
ruct smu_context *smu)

         pstate_table->gfxclk_pstate.min =3D gfx_table->min;
         pstate_table->gfxclk_pstate.peak =3D gfx_table->max;
+       if (gfx_table->max >=3D SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK)
+               pstate_table->gfxclk_pstate.standard =3D SIENNA_CICHLID_UMD=
_PSTATE_PROFILING_GFXCLK;

         pstate_table->uclk_pstate.min =3D mem_table->min;
         pstate_table->uclk_pstate.peak =3D mem_table->max;
+       if (mem_table->max >=3D SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK)
+               pstate_table->uclk_pstate.standard =3D SIENNA_CICHLID_UMD_P=
STATE_PROFILING_MEMCLK;

         pstate_table->socclk_pstate.min =3D soc_table->min;
         pstate_table->socclk_pstate.peak =3D soc_table->max;
+       if (soc_table->max >=3D SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK)
+               pstate_table->socclk_pstate.standard =3D SIENNA_CICHLID_UMD=
_PSTATE_PROFILING_SOCCLK;

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
index 57e120c440ea..38cd0ece24f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
@@ -29,6 +29,10 @@ typedef enum {
   POWER_SOURCE_COUNT,
 } POWER_SOURCE_e;

+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK    1825
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK    960
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK    1000
+
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);

 #endif
--
2.29.0


--_000_MN2PR12MB44880ED6E1F7CA2B5835DEECF7CC0MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 9, 2020 1:35 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: fulfill the sienna cichlid UMD PSTATE p=
rofiling clocks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fulfill the UMD PSTATE profiling clocks of sienna =
cichlid.<br>
<br>
Change-Id: Ib9078c73d3fbd786080449255645ae8b9f879092<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++<br=
>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h | 4 ++++<br>
&nbsp;2 files changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 74cf027e4a41..3fb70cac72ea 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -1341,12 +1341,18 @@ static int sienna_cichlid_populate_umd_state_clk(st=
ruct smu_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_ps=
tate.min =3D gfx_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_ps=
tate.peak =3D gfx_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_table-&gt;max &gt;=3D SIENNA_=
CICHLID_UMD_PSTATE_PROFILING_GFXCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pstate_table-&gt;gfxclk_pstate.standard =3D SIENNA_CICHLID_UMD_P=
STATE_PROFILING_GFXCLK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_psta=
te.min =3D mem_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_psta=
te.peak =3D mem_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem_table-&gt;max &gt;=3D SIENNA_=
CICHLID_UMD_PSTATE_PROFILING_MEMCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pstate_table-&gt;uclk_pstate.standard =3D SIENNA_CICHLID_UMD_PST=
ATE_PROFILING_MEMCLK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.min =3D soc_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.peak =3D soc_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (soc_table-&gt;max &gt;=3D SIENNA_=
CICHLID_UMD_PSTATE_PROFILING_SOCCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pstate_table-&gt;socclk_pstate.standard =3D SIENNA_CICHLID_UMD_P=
STATE_PROFILING_SOCCLK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h<br>
index 57e120c440ea..38cd0ece24f6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h<br>
@@ -29,6 +29,10 @@ typedef enum {<br>
&nbsp;&nbsp; POWER_SOURCE_COUNT,<br>
&nbsp;} POWER_SOURCE_e;<br>
&nbsp;<br>
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK&nbsp;&nbsp;&nbsp; 1825<=
br>
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK&nbsp;&nbsp;&nbsp; 960<b=
r>
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK&nbsp;&nbsp;&nbsp; 1000<=
br>
+<br>
&nbsp;extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);<br=
>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880ED6E1F7CA2B5835DEECF7CC0MN2PR12MB4488namp_--

--===============1046793365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1046793365==--
