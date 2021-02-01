Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C5564E31
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5564E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88A66E46B;
	Mon,  1 Feb 2021 08:50:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A396E46B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 08:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bari7g20jvAi6W3gbcNuUh/H8r2oSDertq0AT64u0a975Ids215yLBNkwZqi1dB6TK5TGLSEo6vmTRGeaz6/5opmyCQtUFca2grOkNIX4tllneeQw/A7FsNqp+wUrkX57iDYZiP7ztQXnD8t10/lSUUfja1bqaTtttPk2jRi8j0BiwLiMa4JBKaa2JimZBa+LAqY9r4GrjxvzMNB4rjnsH/n+2Q7o577VS0CzbFZxVFJ9mMidw1ei4wiwtkdK6sm99oa089HXvGqB4/PmmqtAN7Yc/HENRqRnojU3/+s6fshcTvubdkUntfD7jSNzr2tlsmx/PndOfnAJzWwOMkGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/CJBWAvCSnWKvUF4akQ1o8JWs9BYUZ9Wd6BHFOAn1I=;
 b=bBUnPNAsrzWZOLKoLku6D7K0Gc1bx5ir1bInLWlrkrrw0RBCYNawobEV3b9m86+siJYAt0qtRUQNIiJTl5ghOKzoTflz+nIdee38A/7/D3fkXvgXRXipjT6sJ94w1lh36S3J6Y88OrXBpVKr7kD/QUWqMxlT2NZ7zen9weIU57X/By2e0I2o+PlpkvxDa55X7M56mhJumGKH8/AZfTG7vbJJhc4+SocUzdTpxVHMkfPKD6ynXWxlGCsNgJsQIUGS2J606h4mvkLDSTmH9PzdG3f4unxaQHOWq3KvRN82mJkNOkVoUHSJi/Y0VGfexc+lMJos9o3nI7SmrobAqgG3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/CJBWAvCSnWKvUF4akQ1o8JWs9BYUZ9Wd6BHFOAn1I=;
 b=QExlbXiD4JRH7zZtowj6HpgMNgQlXmZ4PQfYRy56VSSK4pfk6v8HxXHocPOFQFMvbykHnCeNzY2a6ACSg9B47f1w1RP/AQzSUI33arng5UrNnlSASEi1V/T3aatk60kGWKTNdrIiL0QolPONxtkSM7PmVxSiVUSrs5F3AWgBYkY=
Received: from DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 1 Feb
 2021 08:50:53 +0000
Received: from DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::95c7:6e7d:17d2:ff99]) by DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::95c7:6e7d:17d2:ff99%7]) with mapi id 15.20.3784.017; Mon, 1 Feb 2021
 08:50:53 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: remove some useless code for vangogh
Thread-Topic: [PATCH] drm/amd/pm: remove some useless code for vangogh
Thread-Index: AQHW+Ha3BV6YBTmDbUuxJu7GdSJ/kapC/W0Y
Date: Mon, 1 Feb 2021 08:50:53 +0000
Message-ID: <DM6PR12MB30186F69E5E0EDBD2E90E1A9A2B69@DM6PR12MB3018.namprd12.prod.outlook.com>
References: <20210201084558.21708-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210201084558.21708-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-01T08:50:52.433Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49c10a21-a6af-43b6-bf8e-08d8c68e7b76
x-ms-traffictypediagnostic: DM6PR12MB3515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3515B9B59925014605CBEC9AA2B69@DM6PR12MB3515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjcgAegtASqj84/u4sU9XE/hkIe/FJNs4kbg1aSP7uAKCG1X7aX3XaXOcMGxgu2HI+E/i5B12KlUQ+IGk/Lal+uZtfUUs/1p3RGj9Rm8ejc0dqomRmEbGX1w6oL13lDHUPLzHNVkimsrZ5YYxXK446xVjQ2RIBCJEUBKLOYRFHnnSMYQ0hle/bcx1+OnCaKmgod8ci3hmj7toENTw8wmQmIRtiNk60YU4Zbp3Q9zGszQgTKgkXvD1XLYzmEgB6TpKJDheQzKI4gb80W9mn7xJktRIfACQ55VmnhJJmSPmlrbW8nEuJ/+UzaLwnExNqXHMR3kRtye4IaKTKnpk71MjryBKjYKb4rRRArt+gWfbyb9r6vDoczXeA7Ft4v9Pe0JixIJoXFVoVgoexmv5xQer+z+iafoYxNdXQUvhK8Dd8kCafPdlXbvG+CpwPy/VuGe9pBxQhLp92nBFgxubB5PDaIFZi+0KKDxQTvxgf8SBahSPYuSn67yGM8pzH98Q4dAWRR7ecYOwi8+ZjuEvNkW8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(7696005)(9686003)(19627405001)(55016002)(83380400001)(71200400001)(2906002)(8936002)(6506007)(53546011)(316002)(26005)(33656002)(54906003)(110136005)(8676002)(66946007)(52536014)(66476007)(478600001)(186003)(66556008)(64756008)(66446008)(4326008)(5660300002)(76116006)(91956017)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9AgyynELR2auwpn7/nORZm3JU3oH+TlQtBEq0T5rFO0G7ONyGqpM6KEoV3?=
 =?iso-8859-1?Q?aEWl5Nx+aPQUcxTOWugTXnSc6oegwbE40OUp9xpTSPi2nU/CEMlE4cc/qr?=
 =?iso-8859-1?Q?yHS7qFd9yV0Pj5O/Lu7x0bLeSnHXBgCTqYKGnjI3xY349tA0HpI2btIE5C?=
 =?iso-8859-1?Q?NXL5qM7gQ9xL4mVUX34+LI8hkX0+gNAqDmuJR9/j97lbIrV1tQlM1phFlX?=
 =?iso-8859-1?Q?IwTiq9L2Ru8s3jRM/UtVfYiuuCFJoZHpB6Lq0bUYPlku62h6ddRbvN0+c2?=
 =?iso-8859-1?Q?IAZygvhjnpYhKXILdjDu+iJRokq6ERlA8KFqm3TiOj+dTyS9IUKbVtvBMK?=
 =?iso-8859-1?Q?J7s1OxeZxX52N/teqL2HdBz2btFL25OzDmp/D2YzKSQZoqe9A5zWQUUyKQ?=
 =?iso-8859-1?Q?oKWK3imtIj8Db+SqF1jEJTAbVXvr4t0Pb6I7VeF5iQIa1DOGmQ4EzObaOd?=
 =?iso-8859-1?Q?8ZnrnoDiXm3KR/cK2s6/7uwsEkSyFZXN4hapDr5zRmQ2yE9op6a6iptue/?=
 =?iso-8859-1?Q?WSmjR4h48QSzpym8ubse/X2BfIvg/J3812gDjbiI5xBqH9YMJXozwlMh8h?=
 =?iso-8859-1?Q?gQjWwF43+ouou5Zvl56BH4pF05AA5BdRy7nrGIy81NhXQ1pDRLU0qZPhHD?=
 =?iso-8859-1?Q?/mPUqSLCDQW2dioZE4yiO58KoV6SGEdTOr/jBVI5UR+pkQavV9QB2RFnI/?=
 =?iso-8859-1?Q?BwiKIH2QxzlVxhcrES4nF3momnEGpK5iUk7YW7/OWybGgDoIKgUrFYA2RT?=
 =?iso-8859-1?Q?kOFRb30y1F4KIcOFkBfRsJ0GSBVd5JVj+gL4rrGs+zFMMazlO8PQVgicMV?=
 =?iso-8859-1?Q?PDVfNL3nnVdP1DpH8scOP6Amx/gIDdxMDDsGvbiYSlO5rOTik9vbZH7kGC?=
 =?iso-8859-1?Q?EocDRkP2DKx85qO0C2cNebix75ZxFVI05WMNvJDkwhgt8q//G4ClpTLSV3?=
 =?iso-8859-1?Q?hSICaO/56ed+aaoOyq+1V1BHewr4+VQZcAK5ojqhv5FwYfAL1kiuphVw6J?=
 =?iso-8859-1?Q?ss51UgvkWv4UhmPuoWnml04An5lAfpYnJcD2JSoI889iBYZ6Rl2RzMXkC2?=
 =?iso-8859-1?Q?ZDLd8jVCv7iaBUoXuIoKP0WUDRIwHhYQERJL816VbTe/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c10a21-a6af-43b6-bf8e-08d8c68e7b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 08:50:53.0921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMnzxOoRr8gIPXdn+/Yxeb9i+mAutrFjCTDyRooQuz154JgjPJ8y32vOpSDnSubx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============2106360871=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2106360871==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB30186F69E5E0EDBD2E90E1A9A2B69DM6PR12MB3018namp_"

--_000_DM6PR12MB30186F69E5E0EDBD2E90E1A9A2B69DM6PR12MB3018namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Notes:
we'd better to avoid adding ASIC type check in common file...

Best Regards,
Kevin

________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Monday, February 1, 2021 4:45 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, K=
evin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: remove some useless code for vangogh

This patch is to remove some useless code for vangogh.
In the earlier code, vangogh can't finish all the sequence of
smu late init. But now vangogh has one stable work state,so
remove the useless code.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index f958b02f9317..30e2a0ac3279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,9 +612,6 @@ static int smu_late_init(void *handle)
                 return ret;
         }

-       if (adev->asic_type =3D=3D CHIP_VANGOGH)
-               return 0;
-
         ret =3D smu_set_default_od_settings(smu);
         if (ret) {
                 dev_err(adev->dev, "Failed to setup default OD settings!\n=
");
--
2.17.1


--_000_DM6PR12MB30186F69E5E0EDBD2E90E1A9A2B69DM6PR12MB3018namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Notes:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
we'd better to avoid adding ASIC type check in common file...</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Monday, February 1, 2021 4:45 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Du, Xiaojian &lt=
;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: remove some useless code for vangogh</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch is to remove some useless code for vang=
ogh.<br>
In the earlier code, vangogh can't finish all the sequence of<br>
smu late init. But now vangogh has one stable work state,so<br>
remove the useless code.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index f958b02f9317..30e2a0ac3279 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -612,9 +612,6 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VA=
NGOGH)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_default_od=
_settings(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to setup default O=
D settings!\n&quot;);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB30186F69E5E0EDBD2E90E1A9A2B69DM6PR12MB3018namp_--

--===============2106360871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2106360871==--
