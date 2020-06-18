Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B18C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 09:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB2320884
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 09:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sIuA/5r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2320884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B9F6EB2B;
	Thu, 18 Jun 2020 09:21:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CBA6E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 09:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jocp7ZuKycEnPrDDPaiLcx9m9nNU81fxU6ZxL4o4nh/lmXqwLu4fg7rdKaI+49Xnwt8BN6qoXB3/8CqGzx7A1pSSxEY7knhbZn6tfqyhVMB9govi63BqmsDuEoP8swcEmnmnG3lcl7DsgtbC8qyR5IpR28I1JyiueDnjvvLHVbA2JiiOJZt8MGw4VVF3lcBJUs/Nz72ngart+1wyr/9qAqgzy+13fl76qPrBDeUXx4R0UNlHT43m9u7C3gZAjRFvbLTkzZeP+KK4V6/Ai9ycFnN96IMLv9nww6LsQOE2u9As/1FhNDEhDC88+H6KMOjlob+6CO6MgQVIKPm64R5lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfOtrRn31fsWr65NTW5nWV62us0OkSJVxOB7WShK7w8=;
 b=UMgp2nQwv8jleLcr/k/MgvsCDbhdQUjx+Yk18KZtimYup66kn0rWSgy+3ZGhTRgRjG5XfcJ+BZEll3VFEoPWkXkS5IeCxsVdDjn0OMaRNeqPMcp3ReVCV3OtkZJBbFPM6LtBQlDolx3LlDZAEB7yecd0he7CLUj8BSgSsBOsENMbs0MqZWsYLHUhE45yCD85ynSP9JV2YAd7FUsolwgt3J6MqH05MyPMr3OFqTLSoNg3HQty3v+KYjfp/xtm6zraHChKqH0mfLQ7YaaxOI1lPah+AvOSDbg5ZNouJEcUsgZ/4t5SwKKd9ok428uXpQehla8lQN1akHiJji6KD0TBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfOtrRn31fsWr65NTW5nWV62us0OkSJVxOB7WShK7w8=;
 b=sIuA/5r7XCwrRDGvu33DfavyQWWi6QxwIdVRErqgJAhiIR5FIuxYqPN5x1E30/0MhfAYh0KmpqxbQkmbXXwy+PT9iPbseytbYG6Mw6fgHqGCyc7xRvKM2azQmk+eGJo43Dfj+lH17Wa0Ij20o/yX/QFDXnyoeZMhjozcb+4P2Bk=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 18 Jun
 2020 09:21:18 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:21:17 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWMsrD0hnyo5UetOo3mKoC9V6jeCWoAgAAAzGCAAAWRAIAAB1oA
Date: Thu, 18 Jun 2020 09:21:17 +0000
Message-ID: <CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>,
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <CH2PR12MB4101B7B650649CADE1501E6A8C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
 <MN2PR12MB30220020DF792ED8CF72490EA29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30220020DF792ED8CF72490EA29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T08:47:55.768Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-18T09:21:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 025b57ce-a331-402f-9ada-0000c0be3f0a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 685c710c-8b7b-45e0-7a4e-08d81368f4ea
x-ms-traffictypediagnostic: CH2PR12MB4024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4024250530D0D0B47A6320038C9B0@CH2PR12MB4024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmjlLTQUVxZfI8ppryx62qP5tnKXfEEH6FhySpnVhYOOhCnvs3U3n/SX58FbyN5+kyOfEs6zju4SaCP+02TTNNS8BBN8K41JPVDnaDEAzm9oXm2uEAmXYLY7N9R279dgFVQBMLIY54I+Ccv5nIQA93idaVrhLEZJTY+jZaeHvwuTCnvTZaEKSCtDQe8ysvr9bpqaMMw1SKDu1WXhJjzFheIfQ7AFWltLSNBuB5d0gT6ot15tNU5skXn5EMjLSNwGhz9v04zdPmwPaGbwtuvSAHNgcxs30oirznrYsV55AeHPniphryfT7H29Y6tjLYHhBQ9sIW/IVabQ/Am0zG4VItBLt74ddWyQGKFSpKLQ+II=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(966005)(52536014)(9686003)(55016002)(5660300002)(26005)(83380400001)(110136005)(86362001)(316002)(33656002)(6506007)(2906002)(186003)(7696005)(53546011)(478600001)(76116006)(66446008)(66946007)(66476007)(8676002)(64756008)(71200400001)(166002)(45080400002)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WkcYky7I3T3lDbxxdupVp/J7IMUgEd+V1AIeeinVcNaCbFtYHJ2VgrgYLCGxHzCBMdbjVf63HtfNzdyJ1t8ed0bKzH7dXZVifCVmWunBJU/sD98FFODiJ/vVg0+BRnjOCCusoEGkmlwFK0sRATPfkNWncsohfy+toFrI9SvIHwzjJNlkzByPKKlkTfb6WvVaI9UgxLKn9btx0sxRnyE06JANMEL6caFN0zaGfdWu3EQ/2Jz8/4MYIUHKGk9aDH2Tbs5L2oNEVE9jXD0GexcpXaukN3nLIyRFybclCibrlNSjQW4OUc1rJxUG0UVL4S+Z/yf4twX+vcuKRvaAxcfpr16guipRLMTQhLa5KvKWdfIBhctB2kV02ZRxgsetD/h3tZnYWe3QJOiacJuzp8b40nE0JWl7QoxGxhYJ4XIlEcenzJPI/XLzMxnZ3f0+6/J7VlgzkJW93ysjY/Wn1n+EndkSXweMsL580ST+BUEJBd/adTY3zYCd3AFwH0D3BCOS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685c710c-8b7b-45e0-7a4e-08d81368f4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 09:21:17.7154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trrJBMl6a0DPjKKG+wpszIx9P3AolcDQPwCqPjbmzyVnvG2FT2RoQXeDbFMijXDyXAblBpT4DrikQHFYQ7G6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
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
Content-Type: multipart/mixed; boundary="===============1051079880=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1051079880==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0CH2PR12MB4101namp_"

--_000_CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0CH2PR12MB4101namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Hmmmm....


  1.  There are some places in amdgpu driver using release_firmware like th=
is way
  2.  This case is a little different, we use it in loop and maybe not all =
sdma instances' fw is initialized, just like we did in v5_2

Brs
Wenhui

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, June 18, 2020 4:48 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0


[AMD Official Use Only - Internal Distribution Only]

afte the API firmware_realease created, the api logic never changed. (the f=
irst commit by Linus)
and you can use below command to reference the api usage case in our drm dr=
iver.

$ grep -nR "release_firmware" -A 5 -B 5 drivers/gpu/drm/ | vim -

Best Regards,
Kevin
________________________________
From: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Sent: Thursday, June 18, 2020 4:31 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]



Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it's much more safe to add null  check =
before invoke release_firmware.





Brs

Wenhui

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>
Sent: Thursday, June 18, 2020 4:25 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



[AMD Official Use Only - Internal Distribution Only]







________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Wenhui Sheng <Wenhui.Sheng@amd.com<ma=
ilto:Wenhui.Sheng@amd.com>>
Sent: Thursday, June 18, 2020 3:53 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i;

-       for (i =3D 0; i < adev->sdma.num_instances; i++)
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               if (adev->sdma.instance[i].fw !=3D NULL)
+                       release_firmware(adev->sdma.instance[i].fw);

[kevin]:

the kernel api "release_firmware()" will check argument (is NULL pointer).

i think the patch don't need to double check it.

+
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+       }

         return 0;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637280636699912801&amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNl=
GBd0T9bMramDU1ijys%3D&amp;reserved=3D0

--_000_CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0CH2PR12MB4101namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheadera92e061b, li.xmsipheadera92e061b, div.xmsipheadera92e061b
	{mso-style-name:x_msipheadera92e061b;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1667977864;
	mso-list-type:hybrid;
	mso-list-template-ids:-1241086342 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1700667024;
	mso-list-template-ids:1886000262;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hmmmm&#8230;. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">There are some places in amdgpu driver using release_firmware like th=
is way<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0=
in;mso-list:l0 level1 lfo3">This case is a little different, we use it in l=
oop and maybe not all sdma instances&#8217; fw is initialized, just like we=
 did in v5_2<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Brs<o:p></o:p></p>
<p class=3D"MsoNormal">Wenhui<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Thursday, June 18, 2020 4:48 PM<br>
<b>To:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">afte th=
e API <b><i>firmware_realease
</i></b>created, the api logic never changed. (the first commit by Linus)<o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">and you=
 can use below command to reference the api usage case in our drm driver.<o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:12.0pt;color:black">$ gr=
ep -nR &quot;release_firmware&quot; -A 5 -B 5 drivers/gpu/drm/ | vim -</spa=
n></i><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Kevin<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Sheng, Wenhui &lt;</span><a href=3D"mailto:Wenhui.S=
heng@amd.com">Wenhui.Sheng@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 4:31 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;</span><a href=3D"mailto:Kevin1.Wang@amd.c=
om">Kevin1.Wang@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</s=
pan> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"xmsipheadera92e061b"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Inte=
rnal Distribution Only]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Although we know that release_firmware has null che=
ck, but the code is not maintained by ourselves, so I think it&#8217;s much=
 more safe to add null &nbsp;check before invoke release_firmware.<o:p></o:=
p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Brs<o:p></o:p></p>
<p class=3D"xmsonormal">Wenhui<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailt=
o:Kevin1.Wang@amd.com">Kevin1.Wang@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, June 18, 2020 4:25 PM<br>
<b>To:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0<o:=
p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounc=
es@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a><span st=
yle=3D"color:black">&gt; on behalf of Wenhui Sheng
 &lt;</span><a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sheng@amd.com</a=
><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 3:53 PM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;</span><a href=3D"mailto:Wenhui.Sheng@amd.com"=
>Wenhui.Sheng@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</span>=
 <o:p>
</o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">sdma v5_0 fw isn't released when module exit<br>
<br>
Signed-off-by: Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wen=
hui.Sheng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 &#43;&#43;&#43;&#43;&#43;-=
<br>
&nbsp;1 file changed, 5 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 58d2a80af450..6751ad69ed90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1299,8 &#43;1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdm=
a.num_instances; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;sdma.instance[i].fw !=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firm=
ware(adev-&gt;sdma.instance[i].fw);<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">[kevin=
]:</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">the ke=
rnel api &quot;release_firmware()&quot; will check argument (is NULL pointe=
r).</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">i thin=
k the patch don't need to double check it.</span><o:p></o:p></p>
</div>
<p class=3D"xmsonormal">&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAm=
RO0HKFZBRG6oWq3thNlGBd0T9bMramDU1ijys%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNlGBd0=
T9bMramDU1ijys%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0CH2PR12MB4101namp_--

--===============1051079880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1051079880==--
