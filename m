Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD3C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 08:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2183A20721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tJy7NmSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183A20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3DC6E0FC;
	Thu, 21 May 2020 08:51:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1776E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 08:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLq1b3FkULD0kLPSgzyxX3+tPjBtft8JfZ1CwyCXKKY1mQBxxK9CsQ4JTl6bdWX8lu0E8tZ5h2AiMWQMBB4bhIAdURCokKVMATA3NBz/Z933aGVOTJURm7MZU6loJkPrp76G1JjCsY2ZsRuY/17K7Ogna9CxvCRWuptr+5FC4teOgodn4FiV1KDBF69ByL6aTLY20FRsA2RCGx1LCmcUGxju2hSGO+G6ipqUqVNxikt6yycTFzfiOu9eTx19AlhibiO+4djifRRLWjJfgtwa87mDIu08/sKuM+sDmjCJhP8GJpx3E772LHUmhEyIz5Xb6F8T3sxTTf8msp8TM2LfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pMctFYHgvHEjx7KPFEXZP9gnDhrE+JIrb6f79Nd9QA=;
 b=nDIXqi1jkcydV1xlRPYyoJyBj4tX9NhxReW5maKsgHlq4DVama+gdZSHZe74lvsvxuDh/Z0c2bQK1yuYaREOk/0QWqARgDYekGrMoVDUkp+PgY/h5kNi1GuD2Sr7QT0pVUhc/2be4+ch4Wyug7afmretc5R8l4gjAt29hiHdgdNDGIk/ElKMbeOTM1svP43fSiTB3a/DJ1YSuKOeMyJgRawXT5OXoWLCC2r9Xolb3wAZTgTEwSv6pz30TaXFANCuMHey5x7g/cSk7xQqEHcQeApB+DrvQFPn4y28pDy6UlivK6SjE8ejMccK8VfccI9EpoOG57yQFXDUUkLI0nhzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pMctFYHgvHEjx7KPFEXZP9gnDhrE+JIrb6f79Nd9QA=;
 b=tJy7NmSLav0Tkf7GtCQDxcSyM9IAvw9Q7BXSiUwpewQSLnaNzW+HNHUd52DlJDOctQdE10kBr+R5SQoPSmfQcHeoWh2Y1sn2bQvCk7MTVIWrJCNMi/0bFULJS1V7Y3GDxo4IaYlnJo49T/wgonLW+XquB4Sl/P8FsujY0Zh8Oi0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Thu, 21 May 2020 08:50:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 08:50:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Topic: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Index: AQHWLPMIBGNvm2z4ykOubI1NQ8Swx6iwHUiAgAIhw+A=
Date: Thu, 21 May 2020 08:50:59 +0000
Message-ID: <DM6PR12MB4075692390B58655C983AF81FCB70@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1589792453-10553-1-git-send-email-Jack.Zhang1@amd.com>
 <DM5PR1201MB02048EE6C1CB0A03088D910FBBB60@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB02048EE6C1CB0A03088D910FBBB60@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T00:14:01.8317726Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-21T08:50:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Privileged
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8cdee65b-3364-4bfd-8a40-00007d85c140
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43b41ca6-d3be-4405-5e45-08d7fd641592
x-ms-traffictypediagnostic: DM6PR12MB2825:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2825359C1A3A0A6EE686DC74FCB70@DM6PR12MB2825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rh6nCsNYTN3gGOyLmMOXpmPRRTZp/r13O9Fm27KyaccqsWjg5Gft80NwjSpIIOjvpTlzXxJO/SMcLeNucjoUvmP5a9WnygPl8x5kOH416Pcd4rMnmGmoY9D+7v3ELyDch3fZe0nqFM6cETgRz00kL6KR8O7IirV8IrsylsfjdEj5OQSzl6tZTkgt2+zpkUlMwWrKpgy6m70bMjIZT9F/EkFz+ww8vq+MQPs7BpOK+9FJhrLoCCST1tECNIvhZpzz4M0VfM5CLFS4c+aaEsfPVbmNImxITq3Gi/w5tpyaAoQR1Fj6Ct1YPKGCKgfnp1G8UcXClHAECoMLAtLyaPCkSsXJAQGstlMF900/AbUwy/2CxphzKR4WXkdRsw5gf2JkNmmhaSIugNWdvG+RUbgIsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(7696005)(5660300002)(316002)(53546011)(86362001)(52536014)(26005)(6506007)(33656002)(110136005)(166002)(478600001)(2906002)(9686003)(55016002)(45080400002)(71200400001)(8936002)(66446008)(66476007)(64756008)(76116006)(8676002)(186003)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AhqXDxSNqHH65ZWcnoS27xZddhgGz910VNoLS9leFAfedORxMoV2m86nenv7JIquJeDNA6/0bicDu2UJlL2dVd5CJ7SLB58G/3j1cRg88fl323tVf/hRQ2/dLdFAKPoJptjgk6SYAC8jJmRtlC9RPB2lTPayB34sIhh2gmMtB6Qg1uJnw9dhFQ6PbjXZTYoF/bLrdO54c2L32EZ8UMlotDKkCo7BwYrtp6ir95kIuVHTSCB4ozRy++YRQoH/7wjztahvZr0kxaXHNDtB0rKSBRE8iRFuErVuJTl6Dcv10hGZ/cfQPmKuvtIXYj8mVKUYPORK6CHbz6e73tltiK0F39uV5koUvbKFZZ3rsVbhbMiKqIbpovcDaTjynLXw6cNS4Wxt+irRTD8QxwkoMgXhMmPWS9E6tcg08LvcqbH7y3lisSAFYUu69kpVSjcDN87xLhI6anPle7xEXjWojniG3fzK52al5srPXsFN/a6mO6x+ifhMaC84Y0Zkw3BEetCc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b41ca6-d3be-4405-5e45-08d7fd641592
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 08:50:59.5779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9OjeDewLru/Ac6yJCad2q1Zfmu+UsN6fbvnKuJqQAFswBD4JP5+sNBDzy6+PmVva86SXB1Az913krDy0KAoZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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
Content-Type: multipart/mixed; boundary="===============1386381189=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1386381189==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075692390B58655C983AF81FCB70DM6PR12MB4075namp_"

--_000_DM6PR12MB4075692390B58655C983AF81FCB70DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

+       if (adev !=3D hive->adev) {
+               sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
+       }

Please drop the braces in above code segment. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, J=
ack (Jian)
Sent: Wednesday, May 20, 2020 08:14
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgm=
i


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

ping

 Outlook for Android<https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Faka.ms%2Fghei36&data=3D02%7C01%7Chawking.zhang%40amd.com%7Cae=
55d8dca7cb42c5a77408d7fc52bde4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637255306473528001&sdata=3DJjFZsnqaTYv1ShkWrIpTi0QW500U0mNYolWfI1a6lX0%3D&=
reserved=3D0>
________________________________
From: Jack Zhang <Jack.Zhang1@amd.com<mailto:Jack.Zhang1@amd.com>>
Sent: Monday, May 18, 2020 5:00:53 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com<mailto:Jack.Zhang1@amd.com>>
Subject: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi

Under xgmi setup,some sysfs fail to create for the second time of kmd
driver loading. It's due to sysfs nodes are not removed appropriately
in the last unlod time.

Changes of this patch:
1. remove sysfs for dev_attr_xgmi_error
2. remove sysfs_link adev->dev->kobj with target name.
   And it only needs to be removed once for a xgmi setup
3. remove sysfs_link hive->kobj with target name

In amdgpu_xgmi_remove_device:
1. amdgpu_xgmi_sysfs_rem_dev_info needs to be run per device
2. amdgpu_xgmi_sysfs_destroy needs to be run on the last node of
device.

v2: initialize array with memset

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com<mailto:Jack.Zhang1@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index e9e59bc..3b46ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,9 +325,19 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgp=
u_device *adev,
 static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
                                           struct amdgpu_hive_info *hive)
 {
+       char node[10];
+       memset(node, 0, sizeof(node));
+
         device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
-       sysfs_remove_link(&adev->dev->kobj, adev->ddev->unique);
-       sysfs_remove_link(hive->kobj, adev->ddev->unique);
+       device_remove_file(adev->dev, &dev_attr_xgmi_error);
+
+       if (adev !=3D hive->adev) {
+               sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
+       }
+
+       sprintf(node, "node%d", hive->number_devices);
+       sysfs_remove_link(hive->kobj, node);
+
 }


@@ -583,14 +593,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *a=
dev)
         if (!hive)
                 return -EINVAL;

-       if (!(hive->number_devices--)) {
+       task_barrier_rem_task(&hive->tb);
+       amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+       mutex_unlock(&hive->hive_lock);
+
+       if(!(--hive->number_devices)){
                 amdgpu_xgmi_sysfs_destroy(adev, hive);
                 mutex_destroy(&hive->hive_lock);
                 mutex_destroy(&hive->reset_lock);
-       } else {
-               task_barrier_rem_task(&hive->tb);
-               amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
-               mutex_unlock(&hive->hive_lock);
         }

         return psp_xgmi_terminate(&adev->psp);
--
2.7.4

--_000_DM6PR12MB4075692390B58655C983AF81FCB70DM6PR12MB4075namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev !=
=3D hive-&gt;adev) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sysfs_remove_link(&amp;adev-&gt;dev-&gt;kobj,&quot;xgmi_hive=
_info&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please drop the braces in above code segment. Other =
than that, the patch is<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhang, Jack (Jian)<br>
<b>Sent:</b> Wednesday, May 20, 2020 08:14<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior =
for xgmi<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">ping<o:p></o:p></span></p>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">&nbsp;<a href=3D"https://nam11.safelinks.protection.=
outlook.com/?url=3Dhttps%3A%2F%2Faka.ms%2Fghei36&amp;data=3D02%7C01%7Chawki=
ng.zhang%40amd.com%7Cae55d8dca7cb42c5a77408d7fc52bde4%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637255306473528001&amp;sdata=3DJjFZsnqaTYv1ShkWrIpT=
i0QW500U0mNYolWfI1a6lX0%3D&amp;reserved=3D0">Outlook
 for Android</a><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jack Zhang &lt;<a href=3D"mailto:Jack.Zhang1@amd.co=
m">Jack.Zhang1@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, May 18, 2020 5:00:53 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;<a href=3D"mailto:Jack.Zhang1@amd.com">Ja=
ck.Zhang1@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for =
xgmi</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Under xgmi setup,some=
 sysfs fail to create for the second time of kmd<br>
driver loading. It's due to sysfs nodes are not removed appropriately<br>
in the last unlod time.<br>
<br>
Changes of this patch:<br>
1. remove sysfs for dev_attr_xgmi_error<br>
2. remove sysfs_link adev-&gt;dev-&gt;kobj with target name.<br>
&nbsp;&nbsp; And it only needs to be removed once for a xgmi setup<br>
3. remove sysfs_link hive-&gt;kobj with target name<br>
<br>
In amdgpu_xgmi_remove_device:<br>
1. amdgpu_xgmi_sysfs_rem_dev_info needs to be run per device<br>
2. amdgpu_xgmi_sysfs_destroy needs to be run on the last node of<br>
device.<br>
<br>
v2: initialize array with memset<br>
<br>
Signed-off-by: Jack Zhang &lt;<a href=3D"mailto:Jack.Zhang1@amd.com">Jack.Z=
hang1@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;1 file changed, 17 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index e9e59bc..3b46ea8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -325,9 &#43;325,19 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct a=
mdgpu_device *adev,<br>
&nbsp;static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char node[10];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(node, 0, sizeof(node));<br=
>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&g=
t;dev, &amp;dev_attr_xgmi_device_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_link(&amp;adev-&gt;dev-&=
gt;kobj, adev-&gt;ddev-&gt;unique);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_link(hive-&gt;kobj, adev=
-&gt;ddev-&gt;unique);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, =
&amp;dev_attr_xgmi_error);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev !=3D hive-&gt;adev) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sysfs_remove_link(&amp;adev-&gt;dev-&gt;kobj,&quot;xgmi_hive=
_info&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(node, &quot;node%d&quot;,=
 hive-&gt;number_devices);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_link(hive-&gt;kobj, =
node);<br>
&#43;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
@@ -583,14 &#43;593,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(hive-&gt;number_devices--)) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_barrier_rem_task(&amp;hive-&=
gt;tb);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_sysfs_rem_dev_info(ad=
ev, hive);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!(--hive-&gt;number_devices)){=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_sysfs_destroy(adev, hive);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;hive-&gt;hive_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;hive-&gt;reset_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; task_barrier_rem_task(&amp;hive-&gt;tb);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_xgmi_terminate(=
&amp;adev-&gt;psp);<br>
-- <br>
2.7.4<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4075692390B58655C983AF81FCB70DM6PR12MB4075namp_--

--===============1386381189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1386381189==--
