Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA59BC388F2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C46F22277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="37ldjHCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C46F22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EC16E027;
	Tue,  3 Nov 2020 05:57:21 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161276E027
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkiZ6rtUF4ua8EnTGZ8CIEDB8Q12SkoK+pR65CpT7nPx2fRMQzZr7i0zaec/Ys5gWsIupr+C26Uk3h1pikdLp7VLL6U+FvCpcvBKIlWDRv0357bRUwjjQCIUhZ5S/LvQMLaaSWHQecXzWDSiglbvrKxdG5XqLgGR3doXEkUawWnGq7qPonAUX6Zt9OsvEgfjcqIe8lTo8Adro4M8VBKg4E29OGWLLCQzjUuu9YXoApOE79UrZYQYDTXMkW1JQfSD8Djcjpip02lymmYVE+D9ktlUg5vRg3MoAW4OElFetAQZvqoPOwMmItH5M/ruQ1TBdBi3kOLJTeuxr2wK4Am9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2xxjzAs6/otsFUeT/BZPl5+tYoxiu1U5Xt1RcmasQU=;
 b=cKUiXKBajY7GpSWB3XpDkKUwOcF6OXeb1ZdUqGOYu8QTL90CRmdL+lCXaF2EiOZOBD19gJAMEywqyh4+eW5/wTU1lUa9IOxSPGwM/54FyuqWZvrk1115lM3SdbcLYiSPf65UelbEARJAr3NczbF7vve7TEgxPdxzK+zINwLBKfZc1oSF0cvxzZL5YfQ/5wNf62ImYuE2aU4uDOrWgyFqCm7QujCvR8nnCRc3AvVA6yei9p2u90op9w/2nOZVwDXjMyJnGitpB4vKCz94x2x4CjLrHOnVDzWd8qs8M8u3wb10E+ZS2FwPnfb8QMlILJOD0OpTCmIqYuIC6Ao5156Hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2xxjzAs6/otsFUeT/BZPl5+tYoxiu1U5Xt1RcmasQU=;
 b=37ldjHCT1IHFxJifMV0vDmTPkpAhrEALjfZDrntt2JSZatEQJuoMe4AlBhaxI7RYSkKKqM1ghIN3mGedo8vBAVV+A/AeDgpl4nfVrdCMUL6BJS0K2xi/ttyHdPT7lhObRX7XTTWR1rfF9gbMog3xIcXCtXLtrCn4VIxBE0gSwNo=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 05:57:18 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 05:57:18 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Thread-Topic: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Thread-Index: AQHWsaXTAWngEe1Q3EuqAV3PPFo2b6m16N43
Date: Tue, 3 Nov 2020 05:57:18 +0000
Message-ID: <MN2PR12MB3022F96D0A98E371923A99EAA2110@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201103055412.19169-1-kevin1.wang@amd.com>,
 <20201103055412.19169-2-kevin1.wang@amd.com>
In-Reply-To: <20201103055412.19169-2-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa9916e3-503f-49a1-528a-08d87fbd52a9
x-ms-traffictypediagnostic: MN2PR12MB3293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB329393018A0144770FD464C5A2110@MN2PR12MB3293.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjZdOGVesFHp0dG8CJl3ouWIGFjPtmxls7wnzF9g1l0GSdkSpyK3XZCc567RtRgeR/pNm3HFAwVk88Xw7GGRczVc63k4P6rmevAcVjXSewtvLInaoJlmGVpEaOWYHz+KpKmiP/pYjFkKZMF7/cQtAjWAqD/D2RlfjOiaFaSFQpBU/ZrYlnAgzpQBXF3/1bjH32jVr/H31SaNv2/8o8w7kxqs8L+FN+DKuRDpwYPMH7B8jpS/E7rXMJ2HA3XqMfN6eTv7tPWldzSGYBL2VEKmus3CfSPgur8T/iMnun6tgY4fmuo20d63YtCKPNYyu+0cQ4/fsJ0pD5xALRIq5WdTw8bNU30ye5pdM0HkaX51SkKty9LZg5MsT2071D15sQ5w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66946007)(478600001)(91956017)(186003)(33656002)(8936002)(9686003)(55016002)(64756008)(66476007)(76116006)(316002)(26005)(71200400001)(6916009)(5660300002)(66446008)(66556008)(52536014)(4326008)(2906002)(6506007)(7696005)(53546011)(83380400001)(8676002)(19627405001)(86362001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BeDuBPmKWyKfuNZhd2ZHlu3oI6vk/Dr9RR+U3wOYZp7Ci+BhDwZE8XjJkxxbp0Nc0BL6h8asOxo+TWQ3xsHPlib1VmSKVOF4itmn7MwIIoBArLGxB0JSm2rzwtw4W9M0R/EkmMpqIl3pRTA8LxFwUAM85suw0z3APowlgE5N7ejZuT1xn4JJ3/4jSk2OxqkE4do5xPz2GLzl2SRLQ5bdnxwQlix0BW7rpc3IGgBxJnYH/gusvU7oYZjQmoAVgEeDUelxYGBa40hqVYrBEwIELZpfbv0UEHH9CxhWJuW44s8iHxBiz03XqwotGIhREAf2cURTVHZ1n5PhHO/ww3rZ2hiYrTpyXojCMywMckCF732dTzld0a8j1fkVj4I/4S1hE74xj7JCJ8uCLJmaPmUK645vk8nPRf1PNOn9b76mAtRp/swTlaIpa5i57s01L3zONlFXVO4tYAePgFXklQhjHtEdjXjLUN0O569JMKYomBaCf+xM1omMslRs8k3hQosT3vwHa47/5tm12EwvI8e988zXVejjCChb56CMCaCQhBn5cafFV4X63RhEavgmQGA/ZPKOY9aDS9TRXbzjiZSpIR0QHchdWssuYXMmG/ppg7rYWs4km4ipTsVnJqSD54+h5Tz2o4i5ZNHV5wa0hqy7WQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9916e3-503f-49a1-528a-08d87fbd52a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 05:57:18.4440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+Il63N2YM/M+iLRk/M1ilEeemfDVMk1a9A19NtAstkDdzaSqRiKPD281kvBYBf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0480095637=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0480095637==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022F96D0A98E371923A99EAA2110MN2PR12MB3022namp_"

--_000_MN2PR12MB3022F96D0A98E371923A99EAA2110MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

sorry, please ignore this patch, the patch has been merged.

Best Regards,
Kevin
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, November 3, 2020 1:54 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@am=
d.com>
Subject: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping

1.
when smc feature bit isn't mapped,
the feature state isn't showed on sysfs node of pp_features.
2.
add pp_features table title

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index c30d3338825f..92b2ea4c197b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -431,10 +431,9 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context =
*smu,
                                    char *buf)
 {
         uint32_t feature_mask[2] =3D { 0 };
-       int32_t feature_index =3D 0;
+       int feature_index =3D 0;
         uint32_t count =3D 0;
-       uint32_t sort_feature[SMU_FEATURE_COUNT];
-       uint64_t hw_feature_count =3D 0;
+       int8_t sort_feature[SMU_FEATURE_COUNT];
         size_t size =3D 0;
         int ret =3D 0, i;

@@ -447,23 +446,31 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,
         size =3D  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n=
",
                         feature_mask[1], feature_mask[0]);

+       memset(sort_feature, -1, sizeof(sort_feature));
+
         for (i =3D 0; i < SMU_FEATURE_COUNT; i++) {
                 feature_index =3D smu_cmn_to_asic_specific_index(smu,
                                                                CMN2ASIC_MA=
PPING_FEATURE,
                                                                i);
                 if (feature_index < 0)
                         continue;
+
                 sort_feature[feature_index] =3D i;
-               hw_feature_count++;
         }

-       for (i =3D 0; i < hw_feature_count; i++) {
+       size +=3D sprintf(buf + size, "%-2s. %-20s  %-3s : %-s\n",
+                       "No", "Feature", "Bit", "State");
+
+       for (i =3D 0; i < SMU_FEATURE_COUNT; i++) {
+               if (sort_feature[i] < 0)
+                       continue;
+
                 size +=3D sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
-                              count++,
-                              smu_get_feature_name(smu, sort_feature[i]),
-                              i,
-                              !!smu_cmn_feature_is_enabled(smu, sort_featu=
re[i]) ?
-                              "enabled" : "disabled");
+                               count++,
+                               smu_get_feature_name(smu, sort_feature[i]),
+                               i,
+                               !!smu_cmn_feature_is_enabled(smu, sort_feat=
ure[i]) ?
+                               "enabled" : "disabled");
         }

         return size;
--
2.17.1


--_000_MN2PR12MB3022F96D0A98E371923A99EAA2110MN2PR12MB3022namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">sorry, please ignore this patch, the patch h=
as been merged.</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 1:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &l=
t;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/swsmu: correct wrong feature bit mapping</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">1.<br>
when smc feature bit isn't mapped,<br>
the feature state isn't showed on sysfs node of pp_features.<br>
2.<br>
add pp_features table title<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 27 ++++++++++++++++---------=
-<br>
&nbsp;1 file changed, 17 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index c30d3338825f..92b2ea4c197b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -431,10 +431,9 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2] =
=3D { 0 };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t feature_index =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_index =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sort_feature[SMU_FEATURE_COU=
NT];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t hw_feature_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int8_t sort_feature[SMU_FEATURE_COUNT=
];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i;<br>
&nbsp;<br>
@@ -447,23 +446,31 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D&nbsp; sprintf(buf=
 + size, &quot;features high: 0x%08x low: 0x%08x\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featu=
re_mask[1], feature_mask[0]);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(sort_feature, -1, sizeof(sort_=
feature));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_F=
EATURE_COUNT; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; feature_index =3D smu_cmn_to_asic_specific_index(smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; CMN2ASIC_MAPPING_FEATURE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (feature_index &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sort_feature[feature_index] =3D i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_feature_count++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; hw_feature_count=
; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprintf(buf + size, &quot;%=
-2s. %-20s&nbsp; %-3s : %-s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;No&quot;, =
&quot;Feature&quot;, &quot;Bit&quot;, &quot;State&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_FEATURE_COUN=
T; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (sort_feature[i] &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sprintf(buf + size, &quot;%02d. %-20s (%2d)=
 : %s\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; count++,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_feature_name(smu, sort_feature[i]),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; i,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; !!smu_cmn_feature_is_enabled(smu, sort_feature[i]=
) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enabled&quot; : &quot;disabled&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_feature_name(smu, sort_feature[i]),=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!smu_cmn_feature_is_enabled(smu, sort_feat=
ure[i]) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enabled&quot; : &quot;disabled&quot;)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3022F96D0A98E371923A99EAA2110MN2PR12MB3022namp_--

--===============0480095637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0480095637==--
