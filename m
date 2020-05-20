Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 00:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A774207C4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 00:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gMpSbVek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A774207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58776E06B;
	Wed, 20 May 2020 00:14:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C3C6E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 00:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBj8QXJsagJA07frKtvzaH3XE2FXm7aB9IWwRvNjkf1Pz2ltqCpo0wSnFdsEgTS3bjwvFhXk5Ok/O2DSPnCw2j+O/eCEDGE9gMqCDQ34tmJBNiVKAr6K16z5x9XNhgNIxNmI1Kyzwd/dsa/GuGKEYLLs/3dajRCF7AINDBDRwL8sSwwxzIOTgekTDf1GwYelfBpByfKlEuS8PUbHoKaLzhk1yty094Q6I4ab8aFaDl3UHeOwRnsAGSZaKqYRwDbZ9/v/GmvS/feCoW8m5ZlKh2nxi+GNzDGfylvTy9hEfbV6uOR4ZsC0s0PhBhkbMrgVx2jXawSSZLjMpGX3kcVc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My6OVCAFakKpumUF4EYWIsyiVWYiwDQPBH0FkG15rlo=;
 b=RHrk4H6R4YhIaJovG5jfSSMSnRCdAhXixYfyaRa4O8aIzKk1m+/MvnqY52o8ILZjtPvbBkTtZQ1K2PwV8+8KPFG2yMCDZbebAkBf70m3EMZrofWBmByZoHMT1J4o4zrKDcVT421OlAgbT8K3hKZclFOMIVbmNXRk8gnYzuoUcxjP7Ggm+QegYjTy0O7Vzdqpf298+f7gXFw9kYNY88hRjV330xfZ6+QrASAwzE+dleE2WgRL52NOdxe6wbJomLXElAI63w2tCd7pauvwtnvSQOD8MncTdBXQPt5Pl6noqoqVp7GSnjneE0XYtQbkEennadNTqaLUxSQUoP1w/UvCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My6OVCAFakKpumUF4EYWIsyiVWYiwDQPBH0FkG15rlo=;
 b=gMpSbVekb5ZS0DLM2UNjLxRfTN9D1YrHx8iOqJCSY+1eH6l1aZQmNrUjjIiw6UoB4pebVPaYktiYr5J3c5si+UxSMhpf4lTp3fK9iU/j4K+ttGRIWZ4p7wnMh3RXhxW0s6OjiVkXdCjz8oHuzix4+LYYhU/9ZSXK6khUWDqctFw=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 00:14:13 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::151:afe4:587f:3a86]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::151:afe4:587f:3a86%9]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 00:14:13 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Topic: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Index: AQHWLPLqvQTd3jSgtkOrLSClRe4bxaiwHTvF
Date: Wed, 20 May 2020 00:14:13 +0000
Message-ID: <DM5PR1201MB02048EE6C1CB0A03088D910FBBB60@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1589792453-10553-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1589792453-10553-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T00:14:01.8317726Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.13.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cf1930b-b637-46a2-cf46-08d7fc52ba3b
x-ms-traffictypediagnostic: DM5PR1201MB0220:
x-microsoft-antispam-prvs: <DM5PR1201MB0220E9B7A5B68471B091F4CFBBB60@DM5PR1201MB0220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0Kw8WY+jsD+x6jDeyErxu0ADzcQQbIcj0wkw+pmzTzGrh62qAI7Cmh/skXG/XW7bsb2ywCWj9gBXxX2gphJ/XRAP+m5i1eva9Iau8qdXjh+5EK85xJG2YeRn84M4F1Glj/1YE28Wqg/8EbkHqsbvhzgHIUpg1fCALi5HyERsy/lxZVHxNSuI9xCG8ofSyeGcbZa4RAOCUqltuv91kiekyURwyB7ys7Q7K2ORsK78Q6clwPhMfRD+0j5HFdrqn+aQ74SSlCowambBCvEAXy341eFjOVV2thbwjhNIZmTjA1QnU01q16rnG+1yOdkh92EUTQ1w8lyEY1rtNBpnAJgm4kPx0UWMnkS3U90E/Y43KqJ+vVYR/4UaPErMi+srsFw513s3crr1zFmCOzlOMczAFy9HoWHq/WyJxJMSG+4yFv8FALQjrErwKQ2BOITtfJovc8PH7Ic3npy1JZVG41BpBYad+lX5Wzy+/ALqgnVPzS0yFuGzZjl9K1kJ0Uc3OWLoFJ6aeq1C2Bp9WtVL/D/Tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(45080400002)(186003)(316002)(86362001)(166002)(478600001)(66946007)(6916009)(91956017)(66476007)(5660300002)(64756008)(66556008)(76116006)(66446008)(26005)(9686003)(8676002)(33656002)(8936002)(52536014)(55016002)(2906002)(71200400001)(53546011)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IFuHY9tMcpLRoqNOAHWp0eaqgRcYQHxEwnMQpq5MUNFCjAgwRYaAIGp+6DURZ2SwnIWRP11ZAc93PXZu1OQL5QnMMBQu+x63CaYBDWOkPuixbuV49TiKMxJlq/QKRL470PyPj+JODODEtrGYQc/HpRf063hA/vfxeZ+BiCR/IqVFH/fxFgeOytEnLt3KjnMGBK4Ej5AwYviPuID9Enc6a3FrcINR9lyd8yH88MiaOdMPQWubw244A1+RzvFh3R1W30c5UXp0xJCWW/kqMlpja7DcN9kgS8wMtIN+zf6Tpw0UeuNV0Xg7iyCDH8hTgiQVwrYWvQmTkkGJHGHZS70mC75K6AgJ6Sb1KCFJbuAYDgdGY93MN0Rj9FS5EV7yRIp7PMbqZgqeSvyC5kX3Nd5FMhVvvemtHxRktFDwoUvL/DxWWA1THdg92D8JqObyMhWAIGvgcYMkBSLIQQS9hrUDlf0Zywu1kE76jILtvdv1vs4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf1930b-b637-46a2-cf46-08d7fc52ba3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 00:14:13.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xFt8PaV7X9cqlLTXdBIFVyzHAwGSmPxU2HSb3+TDshjCVT6OTOJnB22LxeFoVyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Content-Type: multipart/mixed; boundary="===============1462281301=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1462281301==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB02048EE6C1CB0A03088D910FBBB60DM5PR1201MB0204_"

--_000_DM5PR1201MB02048EE6C1CB0A03088D910FBBB60DM5PR1201MB0204_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

ping

 Outlook for Android<https://aka.ms/ghei36>
________________________________
From: Jack Zhang <Jack.Zhang1@amd.com>
Sent: Monday, May 18, 2020 5:00:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
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

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
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


--_000_DM5PR1201MB02048EE6C1CB0A03088D910FBBB60DM5PR1201MB0204_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
ping</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
&nbsp;<a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jack Zhang &lt;Jack.Z=
hang1@amd.com&gt;<br>
<b>Sent:</b> Monday, May 18, 2020 5:00:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for =
xgmi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Under xgmi setup,some sysfs fail to create for the=
 second time of kmd<br>
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
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
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
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR1201MB02048EE6C1CB0A03088D910FBBB60DM5PR1201MB0204_--

--===============1462281301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1462281301==--
