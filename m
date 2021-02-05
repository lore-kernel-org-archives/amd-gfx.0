Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DDEC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269A964FB3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269A964FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF656F3B3;
	Fri,  5 Feb 2021 02:20:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259D66F3B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 02:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIHoEGFZTATUG2of+/POVW8VexK956KlqI9n2VSa9s/7OCmgNxV+hthzsDqbiwauFha0QXjZaEqWSP9Z6KUWF1vkiKZ7KP9Hcps/1WlARYhiSTlEoYoVyQ8HAXQG/oYAWmcY2uSaFtbNwHYhXLmgMpoyjwFedwZnzFUMuWxRJ+PjqFSgowMdcYSckQVZVEC19ylqu9C23yYmy+l6sCaK9ZGRSGi4OGlfIA5Wr2ziGN26t4bGOmyIizhPIP9Ot7hzMRG/bICSZCZ7utAQUXsjyiaof/Ul/TKkQS7qzELbeggO/3HccceJd3t8DZooEFfPM2SuynPBpoOGRxs0cuSH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVWFZch/+ETsmdSNy6uiZBXOZUv9h1OKOG5RGfxPiU=;
 b=Tcwf12RN3gyUPHFS7YUrxo0jVwRHA49bYZnx5voJZXokM8duVcqa7fv3WnuG4sOIM6r2CAMBhQb2+ofJkza650WZZtkoJ+j18eNjRwh5NDoc1TO7y3eJUNpEroi7EaDVmLgUfhPvE5wYtu6km5QmtlnvxawywUNXZBOxNkNusJoFG8I7O9oAODM1UhavlR4KvsU8k5Fvpvwivjc27H/msKgeigP7BVq2au9hc33dd21k9I1efzL/2AR6UxrfXasX3f7UwRqid80oMNN+UfzNKH8AJO8y8yve7V/7OEXf0RH0b277n2J60TaZDC+V92ru0A8r76rnNpNnO2Kua5CscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVWFZch/+ETsmdSNy6uiZBXOZUv9h1OKOG5RGfxPiU=;
 b=OZATcVYDib12oj6hUxDTbp2ORlFihciiqGz99uxlIMOqM5ahU4m9uiqmkk1LX5WYeClgOKDFkCsdM0Kuy+06Zk5fDwlbiASxolSLZ60XXdvYTCzOKiMxMH+D5ZRNDYAuWAaJlbtSS5juzfoG03Z6jdH6InuafOahXXZmDn3D1jM=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 5 Feb
 2021 02:20:36 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3805.027; Fri, 5 Feb 2021
 02:20:36 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
Thread-Topic: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
Thread-Index: AQHW+zEHFrt8Pj5SXkGT6Q/rDVoqy6pI1DcR
Date: Fri, 5 Feb 2021 02:20:36 +0000
Message-ID: <MN2PR12MB4549BB8EC131A991E38ABF6897B29@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210204200450.1900-1-alexander.deucher@amd.com>
In-Reply-To: <20210204200450.1900-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-05T02:19:15.3619872Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.186.107.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6864930b-b39a-4db5-2c9e-08d8c97c9fb2
x-ms-traffictypediagnostic: MN2PR12MB4303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB430354564168F35B2285D39D97B29@MN2PR12MB4303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKkHYaq33t6H68x3g16+XpJoVWREndiqMIwFuL7/UwNBZ69rUMsYCNuizNf322EOJ5M94GWc3PVJUIFUlKDoOWifdaGsTnQvdT/Wgj+p4xIEfey8Mh41xDNPLQvDJXsh3NM6UDfx2A8eekzoxiK2KSm8RiOByxwKuejDpKeKVTs0viFLY+7PbYDbGR5/sRkpH5ijGZKztPWoyPKS6SzLT87HRYjBRIINBzIqwHnLhmwD7KgUznhGlNmQhI069NR9Eqi8tflZXQaiAj0upGvVq/8EgRdRwHARRRFK9diDMUqTYGqaSr6yxiXzhtPTpmX5eFwVviH3Ne5NWlKOLZ5FbfYm1oSd29vI1TX0O3VpB512N4fBocAgR0QX8eEGZQo2AJ4NQc4lrtnQ1uvaEmUVjRelA5IfJabDo4Qj1ki8DS9MbJ907YMdz7y1f62KAOr8cDsOZqQ/ntHHlyqEr9jbf5bhv+11BYUKDmWxqEjhHdxPe+lg64IcJldgBQAGvMzgkrLzuQMVC6NIkdPRtsIQpspen/MXiFF9grdkPH3EoqKIx2IIg4b2vI/SVqmUdo1P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(53546011)(6506007)(91956017)(2906002)(66476007)(166002)(7696005)(110136005)(26005)(316002)(966005)(76116006)(66946007)(83380400001)(45080400002)(4326008)(8936002)(55016002)(186003)(8676002)(66556008)(478600001)(64756008)(33656002)(86362001)(66446008)(52536014)(71200400001)(9686003)(5660300002)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ESG2eXmm87voREdVUndVdm5wGtj6hgVlvl5rms0GhdLv+a0LDkrmrgFVzuJ5?=
 =?us-ascii?Q?ts4gNpHsnH0tA98Tr+qVOaw1+dsxO1J4Gxa1mgPhL3K1xpnX4yQyq3m0/N+b?=
 =?us-ascii?Q?vbEX3t880c/NbnqNM5GC3Pr5mh77NtvMf3ZXAwT07SCDkJND01LOZm5Sq1tQ?=
 =?us-ascii?Q?kjv5lkO87GGPmOX4w7Wehg9vAPZ2j3TbY4/aAhANssQ4o8f/0rxQIPCs7zvF?=
 =?us-ascii?Q?LqeRgQKy3fOhX4xXjSYmfvOCYvRITMJiWlXda6oVDBTionscazM0zBbw4DNG?=
 =?us-ascii?Q?qnn025vHsdU+USmmDIBwAbZAAu9whJ5X5pvBrV5MlaVMTBDF77TWduZZzMMR?=
 =?us-ascii?Q?WHuzJJ7LDNoLiIy1DtDKw98kDdu2FmACfg8st6MPJQIck2JvJi0YVh5ucAib?=
 =?us-ascii?Q?auawaZ1OJXMbkDDc/PgnyUh0EWybh58qGUC8C2/UARh0bFbYipczh9WALFLE?=
 =?us-ascii?Q?BQWjeUfXz0l+3Z3YELe652NDIx114s2HcMdx0bAdYwVZnjwQ6J/iJzlo9Uqk?=
 =?us-ascii?Q?80O1PjshA8Jin2j7rKJo1rhT/uWzd2sd+fPxArmlsWgxTkmYeJ2KHs2KeIcJ?=
 =?us-ascii?Q?lN5brqDX8vUzVzRc74nLLk/5AhMDqQt20JVCaO/zWtnruVqrLAdErwnZ/ShV?=
 =?us-ascii?Q?5IwrVdeDc2DLei0p7jPGwMJ+agTY/03Eo1BIOTWq3J91F3i5R2U2Pqs60XYQ?=
 =?us-ascii?Q?w/L8C2eLw43Q/L/y0UDqtalQjsWLvgbuwNt2SWnVGV2SbSTNeEb/kh+XNAa+?=
 =?us-ascii?Q?5X0n3x8G2mJjgLqI9SFA3MJUJu6BR+OTlziyFplcsP+MVdQ3HNTAyGt/+1HF?=
 =?us-ascii?Q?aI1m1S9ybI25HaXJu7eeH+nB1zZZzFVR0ocBrNC+eEmusla/XvcQlpQkwPfS?=
 =?us-ascii?Q?2MC1jzYZ7st/gLw/lgwJV26XpXI8wHnN5QGQ7EcdDDiZUFbALumV8j44MCWQ?=
 =?us-ascii?Q?9Q8iPvN1E1bRTnCSavUYBmfUazYtlZr2S7sXdpf8x1HrfqeyjqQCX2yRGANL?=
 =?us-ascii?Q?5p8X2qAial0lm1wBu9td5XWti8tSRxG+u+GGa0Ah61gFdHIc5MWq6n+xjfKl?=
 =?us-ascii?Q?6JN1iIGO1k9arN7rG4Z+Zymi3Sy9Sanr8OdGlmk8O26BvE2yicjfCNMQhxls?=
 =?us-ascii?Q?O06qet4fZOlLtKtCmTkYknC0V+bL92nIMFv41y7txwyytgd9hkgx+fxzh+ht?=
 =?us-ascii?Q?Ekhc6A+LoeOoWc9P63r5D2CJ6EY80iZ7F5oI8nkHbBvWKG1qCIilAyM7wjua?=
 =?us-ascii?Q?UQkoC3pSeRch7hFuIgySQDJCmXnF4AQGosro2ZoUj4s0zfe4IIZg9QAaKkYU?=
 =?us-ascii?Q?0HIH1Ihwul9vpOylzW7QLBO01NDGKXGRl9dJubA8ezPKNg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6864930b-b39a-4db5-2c9e-08d8c97c9fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 02:20:36.3913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8a95MBUptcL2xfWjmAbpNAz8TzGAO4tlRqsqUnl/g+fnN9RCg8KmQb/au1k4n0dh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============2115618558=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2115618558==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549BB8EC131A991E38ABF6897B29MN2PR12MB4549namp_"

--_000_MN2PR12MB4549BB8EC131A991E38ABF6897B29MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

If it's part of adev, does it need an arg? Can't kfd check it directly?

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Friday, February 5, 2021 1:34:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd r=
untime suspend (v2)

the flag used by kfd is not actually related to fbcon, it just happens
to align.  Use the runpm flag instead so that we can decouple it from
the fbcon flag.

v2: fix resume as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0ee6514ee55c..b7ebd424bbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3734,7 +3734,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)

         r =3D amdgpu_device_ip_suspend_phase1(adev);

-       amdgpu_amdkfd_suspend(adev, !fbcon);
+       amdgpu_amdkfd_suspend(adev, adev->in_runpm);

         /* evict vram memory */
         amdgpu_bo_evict_vram(adev);
@@ -3818,7 +3818,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)
                         }
                 }
         }
-       r =3D amdgpu_amdkfd_resume(adev, !fbcon);
+       r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
         if (r)
                 return r;

--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7C9c0a731196964976779a08d8c9482859%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637480659051377089%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DHZn=
iciTDOipp%2FQvNqdbKUERQUSciId5HmhQYviQfxaw%3D&amp;reserved=3D0

--_000_MN2PR12MB4549BB8EC131A991E38ABF6897B29MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
If it's part of adev, does it need an arg? Can't kfd check it directly?</di=
v>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Friday, February 5, 2021 1:34:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon fo=
r kfd runtime suspend (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">the flag used by kfd is not actually related to fb=
con, it just happens<br>
to align.&nbsp; Use the runpm flag instead so that we can decouple it from<=
br>
the fbcon flag.<br>
<br>
v2: fix resume as well<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 0ee6514ee55c..b7ebd424bbc7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3734,7 +3734,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_sus=
pend_phase1(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, !fbcon);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, adev-&gt;=
in_runpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* evict vram memory */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_evict_vram(adev)=
;<br>
@@ -3818,7 +3818,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume(adev, !fbc=
on);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume(adev, adev=
-&gt;in_runpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-- <br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7C9c0a731196964976779a08d8c9482859%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637480659051377089%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3DHZniciTDOipp%2FQvNqdbKUERQUSciId5HmhQYviQfxaw%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7C9c0a731196964976779a08d8c9482859%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637480659051377089%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DHZniciTDOipp%2FQvNqdbKUERQUSciId5HmhQYviQfxaw%3D&amp;amp;r=
eserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4549BB8EC131A991E38ABF6897B29MN2PR12MB4549namp_--

--===============2115618558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2115618558==--
