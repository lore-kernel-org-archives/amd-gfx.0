Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C82C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 14:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0892222201
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iE+3w64A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0892222201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453B16EAA4;
	Wed, 14 Oct 2020 14:18:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750EA6EAA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 14:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLPCJAgvgB2wqsZQFoUuBOxwtIgaiP3iQ6vkKhmHyKRnvltOtCtiR/Yli8DQOjfoz16hjM/R7OjW45+DWDqDSe0QJ5bcimbSoq+qo/8VksoRwHwalocANBDjr7N+PFQukere8izLcAJzFSXwlILXjhZS75JmB9dE3JQSf6ECjn8c1EP1li9D7R6WClc9YwwwpJxhQtV25Owqfy6Rx2xP9nKnwM3bexfvpqmWOo+ESlLsMe9BGRDgRwR/U0MsiCFqitCCxuDx49tbtWL+nrPAZlr5vkZVwW2+KQO/iC4TOBNN2+K1dj2smsm5iHIIM2hvdpYG08hwSwWd4zXs3ftFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP9xrecOHcIE8xoo4ehTHWoS4XICw0o56X3ljXlA6Fg=;
 b=H1rq9m/uPfEN97RvBhMpi/7yR8fMoGREpZ6bm1kiRl5bkHSLsOKkyI/UPtaIWgPwMUnKzhP5XxBjLaP5tzBMMizAGVJVT6uAc/cYRlGfQkG89OCnJzxAnRghKeu1fQCZOLPKiEjkuTzuLhQx+zYoEtlIZAYCWmNMAIzqvrnNLNs3Lv7iIaNMGlJG+PL8wnJ+Y6yONYKUkDf8TO9K67KPU7dfUPA4Ykw9sh0tZ7Ieq4hYOYfGvP3eidIyZCa4vuEIQ5Velohia446TtF/ZSTpbfXlAngZCZ+WhZwuwDVCR+IwqAM47jPoQAhHHhrHesqLWmqrh9iGlCNNI1xBVaYIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP9xrecOHcIE8xoo4ehTHWoS4XICw0o56X3ljXlA6Fg=;
 b=iE+3w64AbY5PLsql8nR8hXxux8cso3HPLuEcM5Mf4uD3dx3fudDP+CgD/P7LzGm5TKRRuCvYayY28LaVtao3JgmLjY/Aq9+ULamowXtrzLFHBDKLx/78BNF7drXaWlgGdBupIGFrRRegXCTYxTa99Z62ALoKlJfCPsZyy4wlXWk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 14:18:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 14:18:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Use kvfree in destroy_crat_image
Thread-Topic: [PATCH] drm/amdkfd: Use kvfree in destroy_crat_image
Thread-Index: AQHWoiBpyzJ/WA2vgkaWz/u/3myimKmXJTsc
Date: Wed, 14 Oct 2020 14:18:02 +0000
Message-ID: <MN2PR12MB44881822C9705C3B9D3A5F1BF7050@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201014115131.6367-1-kent.russell@amd.com>
In-Reply-To: <20201014115131.6367-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-14T14:18:01.687Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d920caa-d699-4747-49c2-08d8704bf608
x-ms-traffictypediagnostic: MN2PR12MB4032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4032B3EE3B8A1323D9F5760FF7050@MN2PR12MB4032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFPNYim0fDR4VCTlpGF60aFEeefLrGpS/1co2BxKSnU9kx4fGh3NR31lzWIN0tgxTkPxYA/qAQNPT8FgHovNju3rp+VjPjloGYMvyLNv/9qSOAH8Puq2dnyBGCmeHhSV3QRWF8UihMTv+0dC4n9aKg4Tk55ZSAKf4i7sJElmIP1TU/JRRq5AHCL7sKAEJVpcbxdmYLkjP/5Wvz00MiaptdBUgxfprbuACiQCK937aAxp0DOUWHBjXo0O1RF2xeim6spSG+6DQKkyK3P9YLxfzEaPYdTcUtqshlyy4t0CAm+zubCSPCXdK85h8YUwstcaHcmEwWjtGYZ6U9chtDVYPLrL98qGuEEu4mfXsOSJMDE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(55016002)(166002)(110136005)(45080400002)(8936002)(83380400001)(478600001)(86362001)(7696005)(8676002)(9686003)(2906002)(316002)(71200400001)(53546011)(6506007)(19627405001)(5660300002)(52536014)(966005)(76116006)(26005)(64756008)(66446008)(66476007)(66556008)(186003)(66946007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: w9Zn1GFB8FAUus0/fpjim+J90TDQ9fLYK1ozEeFlJvi5HPwkEJKX3xWnkB1/okGsPWnS0NIsYijKpw7yH3D1WRr3NG0PTUnaRUd4wnqsQY6iCfmJsFalf7fXYjLUJvdl9UTdIWLHlJdoW26vKP5EaKDpqahBr0Go2J07cs2T8+6CFjFLmacqziENVTRAMpN93JnJ4i6bIMJWpxlHlQYv+oz1W+UaknRv03y7j+4/Rl7tlipZZknWzmN4KO4PonFk6WI9aZUtRbPUrR7XButi1j/QDY9bvRc3UN+3jBw7tDbrUEbW81jf5mzCmdvdLtZLazRC0/iV0aZIVW6b8SwFZirnWMfAVi28JMH3pJgwiFWYTliht1Uxp0deLUM+c4XweUEFD01joIQop3bjdSmV8SBFe1W91AGQwOM2oUmgsyDHITVHasVQ3kvbIeVfoidwDs7iLsBhTzNsMVJOuMXL0digC292nlf6JFfNph+PuLm+P1r0SNi8rgiMCqeSxpPJhzhdvn4xfgnZCcQo5T7NzZZqmB7qJ0yi0aiDSvGD86NGwZpS5QR5LSY+yQi1lGOkgeOJX2tAGRn0+5jk0QNsFi6E9/nJA6KULiDgJyhsAr6pQKhX8Rz/IHr8GnralxFyi2qLiJolFS4VtyVfdbNDng==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d920caa-d699-4747-49c2-08d8704bf608
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 14:18:02.3689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV+bQ//r7JMWu8jjNhVTksudEgUegvR0T3UFHf9lfD2QbxRgrcrYPblVAnujsZW/9khOAD60jDoRQBxwQlXROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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
Content-Type: multipart/mixed; boundary="===============1730698755=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1730698755==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881822C9705C3B9D3A5F1BF7050MN2PR12MB4488namp_"

--_000_MN2PR12MB44881822C9705C3B9D3A5F1BF7050MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Wednesday, October 14, 2020 7:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Use kvfree in destroy_crat_image

Now that we use kvmalloc for the crat_image, we need to use kvfree when
we destroy this.

Fixes: a522a06f8044 ("drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT=
")

Reported-by: Morris Zhang <shiwu.zhang@amd.clm>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 7a071b4f76a7..cdd5032d5c0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1432,5 +1432,5 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,
  */
 void kfd_destroy_crat_image(void *crat_image)
 {
-       kfree(crat_image);
+       kvfree(crat_image);
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cf0637add750e4736c8ec08d87037885d%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637382731137392526&amp;sdata=3DoIKYRCK86ld1JxjEsd1=
EyGsSlskNVyQogIO3spENv0M%3D&amp;reserved=3D0

--_000_MN2PR12MB44881822C9705C3B9D3A5F1BF7050MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
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
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 14, 2020 7:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Use kvfree in destroy_crat_image</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Now that we use kvmalloc for the crat_image, we ne=
ed to use kvfree when<br>
we destroy this.<br>
<br>
Fixes: a522a06f8044 (&quot;drm/amdkfd: Use kvmalloc instead of kmalloc for =
VCRAT&quot;)<br>
<br>
Reported-by: Morris Zhang &lt;shiwu.zhang@amd.clm&gt;<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 7a071b4f76a7..cdd5032d5c0e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1432,5 +1432,5 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,<br>
&nbsp; */<br>
&nbsp;void kfd_destroy_crat_image(void *crat_image)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(crat_image);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(crat_image);<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cf0637add750e4736c8ec08d87037885d%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637382731137392526&amp;amp;sdata=3D=
oIKYRCK86ld1JxjEsd1EyGsSlskNVyQogIO3spENv0M%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7Cf0637add750e4736c8ec08d87037885d%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637382731137392526&amp;amp;sdata=3DoIKYRCK86ld1JxjEs=
d1EyGsSlskNVyQogIO3spENv0M%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881822C9705C3B9D3A5F1BF7050MN2PR12MB4488namp_--

--===============1730698755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1730698755==--
