Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA49C433E9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 15:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA16464E20
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 15:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA16464E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337BD6E511;
	Mon, 22 Feb 2021 15:36:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A636E511
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 15:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp6s2OnPhLLVIX1J2UvlP+ELY+gSWASln3IDt0x6rMJBPd/AYyWeN+7Sq1mdcbZ+rHsgeiZBJ/5xBGsmEJk1p7IsmW9b/FqzNVdmqysD448BwXGKjVR6hoZlPZUFFbdq/D1zHaWDrbT06Ubu+pzg4e3uP8lQ8nHPZ128Ogxzi52sm+sG0NmgyO+PxnUNBsgCZ41q3L/hJ1I4cg7nIWV+t5L/ll6nyR9LM6bj4Rpq5uqxTjptMmKc1yJpSJEr821pynr2HjpY0tFZkeXBi1OV7GYrzY4J7206TRQjsej9+7wzFdclFhEXszd5G9JZU3O4ujBqRlKtV1KW/lq1NNciRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caoaFcmI7WP42JrpCCoiimrCupa5tWMxr9xwq8zSnIA=;
 b=GL6wRFNfOAynGilO2hlJSFRS7tdt69QyBO6PC6T+XTQ2i1E+wgZYp0QrLX7VM5PWImgyFvGljXb7dA1Z0Q4j6K7jhsjE6N4m4mvV02wA+OSBkOQYslmVPysHxJ4br+zDOiNJzP382H9amk8TNJmsoC2jzXuoxEEnp1wghBmXrU8ShzhppYlAiUUAcODdq3Fr9gZlk20lgcY66SWZiE71S9TnuO3qCwxDjCx33/rAyqUws700b46Wsygku22MYZPGzoMiZblfFij6kuSAEQvDKD8+75H+1NMRMcqZd2twy2SB3gR9+HzD6m486pTL0pnuQ7J2Srnw10CCIiiGscyvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caoaFcmI7WP42JrpCCoiimrCupa5tWMxr9xwq8zSnIA=;
 b=Vq7oK8/EjyKuu1hg7ZOjyf1VjCUs0nEi0yxoWGJFecQX8zPaPQJMlRbhFBDcq6a3cSDpFbssQaonzuVxTeh2drO/H8vlDaGdOtGGWB8sMP/aox/5co8ICLRkaa2ypyqAVb8bKUu0gJdyhMHw0I/8PhqXS4w8NQf2+GkJuuqi+YU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:3f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Mon, 22 Feb
 2021 15:36:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 15:36:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "wangming01@loongson.cn"
 <wangming01@loongson.cn>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen,
 Jiansong (Simon)" <Jiansong.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix wrong executable setting for
 dimgrey_cavefish_reg_init.c
Thread-Topic: [PATCH] drm/amdgpu: fix wrong executable setting for
 dimgrey_cavefish_reg_init.c
Thread-Index: AQHXCPbsyeE9EMNou0qJ/IZ1bgvUvqpkTt3t
Date: Mon, 22 Feb 2021 15:36:02 +0000
Message-ID: <MN2PR12MB4488C9482DF76DD4AA344E0DF7819@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210222084403.32486-1-tao.zhou1@amd.com>
In-Reply-To: <20210222084403.32486-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T15:36:01.872Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2d87a65-bc0b-4de9-80df-08d8d7478fad
x-ms-traffictypediagnostic: BL0PR12MB2531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB253180F22724533886D05500F7819@BL0PR12MB2531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+1G3yQkNgE8r3fhaFWFIQH7+Qz6hrELz2x1fCKFS1rpQ8g8ip1IkWUeuR6NAYZ3LfCMHo/1BFoJnsV23zJZb0/hrk0uWHYg13Q4RoQwhxXbMm1n+WRGiXsLIkKWyQkPpic3RjAyV+V6vp9k7F2GV+//sIK8W9EeiIN7i38hwqvEdj0S0bGL4CRljJYQjjqrNo4pPzRrmuEGEsu3Cf0q2ruY352wKARaa/VyG4Hqt3JmX6G2CRZMYz/A10vHkYmJF7YOeMb1o4YPNBlk028kWV0QeqbpGqQ18Sa09CocZF3bSlLABvLeW4XcxJljVb/EFWtbCMI4V0S2QaPblALeDhB+pqjPTasvUzOQ0WvHqTK9FH0VYSV3s6QEs3DHrEp57VckwsB4tqBEKxqMBApgR0me5/CeBMRZcs3QAH3GZBquz6qEszoOJDPKAQ598OxBI+VH44vYKVSkjRFO7NyrNXPjCETYsL8ok+NeMWJPpw3xCasvxHU0Kvg5cmASObFhSdyVyRSDlW2SzF+xYCgTPizi8Fg/31NfrxVCKlPEI2/l84cubBJI75pDzrf3cDtU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(83380400001)(5660300002)(8676002)(64756008)(71200400001)(19627405001)(66476007)(86362001)(66556008)(186003)(8936002)(2906002)(53546011)(45080400002)(6506007)(7696005)(166002)(966005)(52536014)(33656002)(66946007)(478600001)(9686003)(76116006)(110136005)(66446008)(316002)(55016002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rHLAAF+N3y77TLLEFDBubYgF4qAoRgxCwvweI9kbu3rrT2Mm7BEq9H2Lzcq0?=
 =?us-ascii?Q?zaMVSnPsxCyFRo15XsEBytMZbFnFmRfMQMsVjDxGFwunQ0yDypiJJ+XH5PSZ?=
 =?us-ascii?Q?+xyT7AdoLbeE1cvaezuvbnjdrDczABzL/5+DUGK4phLw2F0pa2lyTiGD9FIK?=
 =?us-ascii?Q?Vod2BTFEuDnzo9eShCFycTQ1owjzdSaV+UkiE5R5YIqtl1gc/e813lFZhlP/?=
 =?us-ascii?Q?17pukAgUc2f91sLdC+bRECqMONcNtTCvvphMdy+jpdBEcElMe/Xhf89UMj9v?=
 =?us-ascii?Q?dKkJoU1Hf2MdDB3KAMsd0NixrtekYe82AjNNRFMbOBUvrZaorqCp7INhs1Xc?=
 =?us-ascii?Q?Vci9m5jP+5BE5t+Fl314aM7LG5fsbs6LPHc1HDNChVnhRvoxr9xXZ2rZ76uW?=
 =?us-ascii?Q?DGcHoyXPdJGN2TOXjBSKun9/Ien7jihghgrzN9MXL6hxAagNV3oBn9qta0Vb?=
 =?us-ascii?Q?fYuHjrIwMdpyvPJ54M2zuH/ulnx9jDrWYlAeRThRPiC2GVW6ROrPcGt1VcMJ?=
 =?us-ascii?Q?bBBHKyRU2sR5H8cr0jZbOXXePeZiz26AdsyKvqWtVWefiNFo1j0CeBQ6GC0q?=
 =?us-ascii?Q?9WHRVURTtabx4t6GXKInXpcJImbvqfrtmwUWmrsNQ9d5koTw/eqeagFGpQFz?=
 =?us-ascii?Q?sUm0WfYhFHaOaNa48mYxoTUf6MdJhJdlo7BfTTU6nuBURDKZPQQuUO+kiUtD?=
 =?us-ascii?Q?BTZKWcEa6wbmk8hgmfrAYQ6FTVQ+dYGGSttEvLY3QLett16xprF/pz+J7it8?=
 =?us-ascii?Q?NemM0LaVMJhrgKiZfVBiBakj6gTLxSw6VMSEFmxwDxudqg3jiyiV8TuIelov?=
 =?us-ascii?Q?k7Q7OeEldy8gVn0spYHmYV8twsCxZ5ys7UnE/6WATWzMbKnwWAbORJrYQ9F4?=
 =?us-ascii?Q?dJaU4W0zpp0PoRmRJ11m2+qIMBHMNdSlcuMkVuHFp+MyfkhYg1eAo+luWF5N?=
 =?us-ascii?Q?WOXMPY9W5X0GuQH9SmUleb8q3gmIBV/V2zqIvyLPQaC116tKOUo3+K5d3qSx?=
 =?us-ascii?Q?yB+OeFaTa+W4kduXN7HFHx50+EOAsiV+t61GayQ6J9xOxW5gVZ6tT6vnxYC3?=
 =?us-ascii?Q?EumzxrheJ9bB75uu3BFxsbGCLDQKybN4okl0rpopy+mAahKjX4aQkC8bCGLs?=
 =?us-ascii?Q?Fl9Q+asZJw+CWe5ZlzCWzMQg84N4YNIZFWRAZuXGfv+7oWjNhiSdtJIjZO5m?=
 =?us-ascii?Q?KBPRMgeLXQ2NUXckw/E4H4HZB2+pdSyGRYRvA6TVL3GrP65fVnhPswiDV4zH?=
 =?us-ascii?Q?0omzI6gopWa7WczxKSSikZNYADpXwynNA9MAu5WIqezWmZ/4iGLoyIpIxHDi?=
 =?us-ascii?Q?lxH+K+j1wW8NHtuvNGIq95H6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d87a65-bc0b-4de9-80df-08d8d7478fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 15:36:02.5739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeAoZA5JuvbJyV9ZHy0OEgoMjMFbg7VRrm9keXzhRWiD86OzX3OtEtGJAytwF/EKxfl+Xk9/J/cuImwP2+PLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
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
Content-Type: multipart/mixed; boundary="===============0710748983=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0710748983==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C9482DF76DD4AA344E0DF7819MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C9482DF76DD4AA344E0DF7819MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Monday, February 22, 2021 3:44 AM
To: wangming01@loongson.cn <wangming01@loongson.cn>; Zhang, Hawking <Hawkin=
g.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@l=
ists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: fix wrong executable setting for dimgrey_cavef=
ish_reg_init.c

Remove executable configuration for the file.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish=
_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c b/drive=
rs/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c
old mode 100755
new mode 100644
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C0991ab6c194e4e74ea6a08d8d70e0dd9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637495802656051024%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DY9nCpsewHAPf%2FSqhq7ATTqTC1peQhUX%2FrqdqLv%2BBp7A%3D&amp;reserved=3D0

--_000_MN2PR12MB4488C9482DF76DD4AA344E0DF7819MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Monday, February 22, 2021 3:44 AM<br>
<b>To:</b> wangming01@loongson.cn &lt;wangming01@loongson.cn&gt;; Zhang, Ha=
wking &lt;Hawking.Zhang@amd.com&gt;; Chen, Jiansong (Simon) &lt;Jiansong.Ch=
en@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix wrong executable setting for dimgre=
y_cavefish_reg_init.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove executable configuration for the file.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c | 0<br>
&nbsp;1 file changed, 0 insertions(+), 0 deletions(-)<br>
&nbsp;mode change 100755 =3D&gt; 100644 drivers/gpu/drm/amd/amdgpu/dimgrey_=
cavefish_reg_init.c<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c b/drive=
rs/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c<br>
old mode 100755<br>
new mode 100644<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C0991ab6c194e4e74ea6a08d8d70e0dd9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637495802656051024%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DY9nCpsewHAPf%2FSqhq7ATTqTC1peQhUX%2FrqdqLv%2BBp7A%3D=
&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C0991ab6c194e4e74ea6a08d8d=
70e0dd9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637495802656051024%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DY9nCpsewHAPf%2FSqhq7ATTqTC1peQhUX%2Frqd=
qLv%2BBp7A%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C9482DF76DD4AA344E0DF7819MN2PR12MB4488namp_--

--===============0710748983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0710748983==--
