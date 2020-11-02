Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63247C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8C322268
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ojs+XP4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C322268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884126E505;
	Mon,  2 Nov 2020 16:38:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCD86E505
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 16:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOQvLhjLfBnmERdNVy2geqRmZ0tg9nWTWWP1QtDKt9i+74ILuFgASIrauEPTazYPWRMBETmr5Ku90W1H9N00aNmbJnMoaJMceF7zQxej37prwR1N04m6kqJY6jXKRD0ZRSaSATkUjq4K5MaJc57zDkCyxginOUEANlDx86K9vF7QRP+JEH1lkPNPC/fDQJx47oEmV/9K3NQUkNFOqbHozFga96zAn7dvnyW6BQxizPK5zwUwjphv+GbqBoRTrNjmopUiUeLp0GafGpb+sYNUkumfO2ILQeigF8cvtOiE7JAHt50kCKd28xxaHlLwdZMeGbAhQB1catK/NPDk3TiNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXIvTEZZZBCqHS8xlM15i1+sH96rEeav1/8BAis6UZM=;
 b=n41ioX2twEK78gKNfwupK3vxjPDzc5pvYDGJ7sqcznYoG9p7KlzEtV0W47s2FtI9ApYdtdXQJjKfnF3RL8KucmyXkZHeslkA+0j7SFJsz83U8xxLbMitU2xL1WfrhlbNCOXuJ7SASMY0TMidzcoy/HXF7yW93ZJWSnU63yD85FguZaylT72zT+i3iRFIE6gD95yRX+Wse0dkfInHVp9FTmJFSaGKGUsYUsAlnY4R/763E+w7vjRJDCYi34PI9Ma3fe5AY3rp3fH6HKGcM1qgSiLQ2Hl1Pv4QOOXm4r4b3Eo/aKIrAm9WIWW5naRN2xXM4CW0Xu2txjch1PcpQJtfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXIvTEZZZBCqHS8xlM15i1+sH96rEeav1/8BAis6UZM=;
 b=ojs+XP4jld+ErupO3kx1XLh9BJ7V/rjWP/aQDYwwZOHrf3jLr4zLSMFhQijERf5/NFOOU2YH0vfMSq5McZSRN5mCEynycpUBFLqADmy5u6Q2NcmhCOOBaQcDCXFFa5ash362Cprd+M0vX/jFprvAlIM6pxH2g7174rEDWgfrwTU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 16:38:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:38:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdkfd: Check kvmalloc return before memcpy
Thread-Topic: [PATCH] amdkfd: Check kvmalloc return before memcpy
Thread-Index: AQHWsTUXoF5pBWKLW0+Be7fjSGl2o6m1CscK
Date: Mon, 2 Nov 2020 16:38:48 +0000
Message-ID: <MN2PR12MB4488C45F1DF8865727A357A3F7100@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201102162724.14396-1-kent.russell@amd.com>
In-Reply-To: <20201102162724.14396-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-02T16:38:46.846Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ec8d879-a095-4092-5d72-08d87f4dc5d9
x-ms-traffictypediagnostic: MN2PR12MB3759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3759D3A7E4340DB149E239C0F7100@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jW6AnxjuxzSITeOlxxWD/6DhFnT8dQ1co+5iHhPaDDssdJ7nMy8AwKB+cTtKLj+/W2D8I9d+nb0EL8qAUSuEgbFzkINhK3fm93iRIdpoHBogqCe0OpVcm3BBsLy3oqWnu2C4Le8SL+agnEk+tMYlB3bLBzNZ8+h48OjA4pJqopRwvAmSeZaxJD4P3lQutg7UvEpNtZ8SUs9MaQJoDzS/iFpBxFmbmDKrhW66hJuBlSwNDp2FjLfUjXhgtu1oFKK+RTSZxgLYagPUQoQd9boS3z6EFhjjV8R2GcDvTlN008yy8dBDbYjkNpBLDz4ljaBfJJmw4Y8qyX77q6YnOW2Wm8wPvvF/9Lr62WICcwMZX6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(5660300002)(110136005)(55016002)(66446008)(66556008)(8936002)(8676002)(316002)(52536014)(9686003)(83380400001)(64756008)(166002)(66476007)(66946007)(71200400001)(7696005)(86362001)(76116006)(966005)(33656002)(6506007)(53546011)(2906002)(45080400002)(19627405001)(26005)(478600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oUdR9P0WL/5Pp5TUuQY0Lx0S3WZBLXPzWX4e4vXowTjY6Ja2TznvyItUcFQbIrvcAZwPHt4C1fRaHfO9A9o7+lugzdrxuorSiXHld5SRmph8M35lwgqM7utaCGoIAHlX3kNKpAmo57LW4jqLQ+DeojMmiVbnhi3wf2VqkWJEpCsXHrQVKMdK3Eb9j91xvd8xyAGCp9yj3WAvJ4JPnYkM64L3qNh9++mlezIH8W+4UIZ8UGJ+3VrKIE74YNaY1CcJgpJ+b28ICdpou/F4921D0Uz2GsIMsINeTPv39lC/aauEgpMgRjTTOAU+qnjpkTi4B1c+2pG0m8NRrre2SfFzA1RyHH1JTJu+kZm5/bh9nNZfCT181VLQsKYCsfytnQAOmbzK8nlr5Scar79w8GLe8GztHZ11rlwS+z/AkAsdNtLRnQe3Yw2UjLmYjnNYkLlKIIWwOwVsWBnrXzykGKt5LucbQ0Tgz7DLCfw9ipZ7IgucP1EIjCq7jZKP0IJVDocQvhFkouqKffTCpw3/dXXpAIIT4nWmqAMUzLU1EbJ0OTz77rt6m60oOZE2xMTy/h7NwUqjfxjpk+LUzntJxdfMUBNkUG6ZSwnUpy0PJnzGaPwYaT4ltXHVKY1vmyyhswDrwnCLBsb7Qy3sSc+B267pjw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec8d879-a095-4092-5d72-08d87f4dc5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:38:48.0306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCfo7dpu+N9kyXYzk5ECXzb9TZsePMmY+/SIiFY6/whZwvM1phSJndWteFCki4eIHdWhaG2/DGMJWfe96PpzSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Content-Type: multipart/mixed; boundary="===============1838318433=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1838318433==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C45F1DF8865727A357A3F7100MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C45F1DF8865727A357A3F7100MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Monday, November 2, 2020 11:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] amdkfd: Check kvmalloc return before memcpy

If we can't kvmalloc the pcrat_image, then we shouldn't memcpy

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index cdd5032d5c0e..a0acf2310357 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -804,10 +804,10 @@ int kfd_create_crat_image_acpi(void **crat_image, siz=
e_t *size)
         }

         pcrat_image =3D kvmalloc(crat_table->length, GFP_KERNEL);
-       memcpy(pcrat_image, crat_table, crat_table->length);
         if (!pcrat_image)
                 return -ENOMEM;

+       memcpy(pcrat_image, crat_table, crat_table->length);
         *crat_image =3D pcrat_image;
         *size =3D crat_table->length;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C20c8797c2a6d4fb8bf5a08d87f4c3732%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637399312636837144%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat=
a=3D84VCnd9ugeRKlAyqOYpXHm2PvPXUhM0gQjJd9AR95mA%3D&amp;reserved=3D0

--_000_MN2PR12MB4488C45F1DF8865727A357A3F7100MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Monday, November 2, 2020 11:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdkfd: Check kvmalloc return before memcpy</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If we can't kvmalloc the pcrat_image, then we shou=
ldn't memcpy<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index cdd5032d5c0e..a0acf2310357 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -804,10 +804,10 @@ int kfd_create_crat_image_acpi(void **crat_image, siz=
e_t *size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcrat_image =3D kvmalloc(c=
rat_table-&gt;length, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(pcrat_image, crat_table, crat_=
table-&gt;length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pcrat_image)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(pcrat_image, crat_table, crat_=
table-&gt;length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *crat_image =3D pcrat_imag=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size =3D crat_table-&gt;l=
ength;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C20c8797c2a6d4fb8bf5a08d87f4c3732%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399312636837144%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;amp;sdata=3D84VCnd9ugeRKlAyqOYpXHm2PvPXUhM0gQjJd9AR95mA%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C20c8797c2a6d4fb8bf5a08d87f4c3732=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399312636837144%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000&amp;amp;sdata=3D84VCnd9ugeRKlAyqOYpXHm2PvPXUhM0gQjJd9AR95mA%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C45F1DF8865727A357A3F7100MN2PR12MB4488namp_--

--===============1838318433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1838318433==--
