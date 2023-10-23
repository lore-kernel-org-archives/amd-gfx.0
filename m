Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE030C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 16:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B98510E107;
	Mon, 23 Oct 2023 16:17:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A791210E21C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 16:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5HuHppzTWrZETfckvCkXpwazU3sr+57fmVnFtiovB+om7sVfhkRlIUnuKJffpAN3yP82zQtmScoHiUlVrA4DJfmuJUzYBON0p7/msK8Cm11yVZM5d8HMoAJ9NkYTmBeMpz8qx92tNol9UYvzR4VOrDEhYFVrduBzRthnbwDemcpYM/xdUHCpqc3SG4z8Va2T1E61h5+hT4ZuBoy2aD+L9VPkKHnDbMd/rI+MOKAeST63muaj878b1NzwhBMZHMf5nKjakDrJw6RYRP0bKrUtwMtnwsJgboUR4EUFxw/lFPN1YTzM+6zzXCevmo7TyNIXdSyfKTeL/YDp1jUJik39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhb9jL6RdMo1EzN3VpcDy9pjsJKTGNHeIKfDx/S68hE=;
 b=nywPa/o8zSV9+JlKENOI2DCsgiAo8rXiwuUrlJRBjxVIdDVe02buWrB2jzllHmN1Yi508Bo2uHJ6Kf1FK66ASJ0EsCmc8cjfDG8EcZBdlenHhMiP6Y6HnAg9eDB+v/vCrwSwRFujgPr42vRuHjHAK0FY3hyqNYhW8SYOpjypiCDNAHtqIGJ0Fechd2IP7FStJJjL7ZNjbUjdp+0H2oHv7hLE4myKcPLPhpUrIT7hvsSvTAnJ9V5SXJoLi9mPQg3FCArD5cwTFgejG+/LDgqrgg8Le9Ukwwgv7J+c4fdmLeciXlCobgw/TZV4Fa5QbSK5q1z6ZRkEfhfZMopxIoDEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhb9jL6RdMo1EzN3VpcDy9pjsJKTGNHeIKfDx/S68hE=;
 b=2jHi6GaDYt3cLfgWJuHCDAVEBGO1QUallZDCNaWlmWdh0ycTE2WOep60Yy5qdtjPEn48RDjeteclSvaby+LosBzf6pg8QjSXXKJ8K2RDXuN8BWJV6cetuDhUVGxgAvvJdfu/1MBJDb5lGW0l1VCYQ20uAlvNg3IPZYwUTMEfY6Y=
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 16:17:01 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::5a16:16a9:ab23:64]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::5a16:16a9:ab23:64%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 16:17:01 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely
Thread-Topic: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely
Thread-Index: AQHZ4ZlaSDmp+Y/AVUy9uNTV92zdsrBX1W+z
Date: Mon, 23 Oct 2023 16:17:01 +0000
Message-ID: <SJ0PR12MB6760336A8CE9F024A8F05FCDE4D8A@SJ0PR12MB6760.namprd12.prod.outlook.com>
References: <20230907144100.81325-1-James.Zhu@amd.com>
In-Reply-To: <20230907144100.81325-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-23T16:17:00.707Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6760:EE_|BL3PR12MB6643:EE_
x-ms-office365-filtering-correlation-id: f6bfe853-34fc-4ff7-6056-08dbd3e37d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mVA4m6kU4hestDbWuYuqSEiuaEIqU9Is11YjsBrAShjnVK1ENAQUmjWBmOzbpZ7CXWi+DETF3dJzcCBuX6053ulB7Utjloi3/v3NG9nL9y56+vO6iLA9T/Dvxe0CE8siwXoCMVtFu/GLbBcA8jpTwHKJK7wn/3S4jip0ZLTR9myG3yoAv3irhSovOON70CS4Ha4SyXINHPCgEAbrpR2EfDLC8vRleYy7XoRY9DF7L0C7xe1/7qPmdFICuKrDGr7A5BrLiQBfPRzlUaRCu3rSNwvNAEG/mxTE6eipnyBFQU3KuCLCpALcOLkdcoRdICtgvDmNS72bfQHPUG94EYoCDlkToCAw8vE6sSToW0nTp5q93yMOZz3EbJNJDnJY7H15Uc2BRRwRFSBsFLBs8G3S5o5OPqerX5GjwcsopdEQc2enIa9gPOvIO5YQQbZRTLP0Lrh0vkuVa8QSfMBLhinwZ+RTv2JHoWrySg7bpOt2c2AhJnK5hjvCfodm8HNcnBPOZXX+IuV1jc/OgKZO86L7qEGwX+IMyAEyScidWr8E66iO+8ITHLsWpp6YM2Pj6NUiphfWxS09SpWdSItBa4Q7wPm0szAxVSITgFXfaL+NRU+PeiW5YBHmhjpLdvTjzzUK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(19627405001)(38100700002)(2906002)(55016003)(41300700001)(52536014)(5660300002)(86362001)(4326008)(8676002)(8936002)(33656002)(6506007)(478600001)(7696005)(26005)(71200400001)(91956017)(54906003)(122000001)(66476007)(64756008)(6916009)(76116006)(316002)(66946007)(66556008)(9686003)(66446008)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IBbavBDXFyoH4Q/10YfRA+nB7PShcKM5IKPYtNNFsjNJs8MOinXFghBTl7ij?=
 =?us-ascii?Q?PukslTc6zlGaRoU6gix4DgiS2slgiKq0K4M6wSUHsWbzR2tn/Km/UV1X2tKq?=
 =?us-ascii?Q?h+tvZehzUI0cUPv3eeFi6VppvzApodqG+x6KNHy6ycvsURi5PAd+kBruVIO6?=
 =?us-ascii?Q?P7sJCzAkXOuLzjoIAuIxnrKgXwEmpaOvEr/x2pZsTcD4uaCZSmjHkWZ6Gy7I?=
 =?us-ascii?Q?PO8oN//XG2n8cGVV65gfwzTlmIFp9oE+vmsD3WPqIXhP04nY4Z6fVTCvWgeJ?=
 =?us-ascii?Q?7xl+anvb1VH2/L0CJ5duGkRrHRFACgGKALU04oaavDq9SEFk//x1drNqkdvT?=
 =?us-ascii?Q?o8YtVPl89i/3rbMSQH+6FK6gbZsJhzVFcSkjOx6/Pr4AqztvuhO/6CemBtX8?=
 =?us-ascii?Q?XzUj6CIlvsucYVl0Y13MI3ySPFwNLOfW3CFOqDVG9ZsGxdZDQmHAftu2oZrg?=
 =?us-ascii?Q?Fu0LcN4ZqbIMo+Dcv9MEM5PpfFOnTsLl0raek5nXBzyOCRTrydQtB9Fm4+Yo?=
 =?us-ascii?Q?zKopDa+npZDinWb72VCKUHnjvKCB7805lKBgKL2aX7K2LrIEL2lOWbfsxzfv?=
 =?us-ascii?Q?hUCyG1Qy+JtuJRnsWNkdOT0UaNPeV7UTynCX8me2aoLloQ4XW/a71tCWBsCg?=
 =?us-ascii?Q?P16Ksh9O+UfucXd6rW+jXDfHDWs+VqITxrdMHjFqqI5e0WOfHW1xiYiDaNqY?=
 =?us-ascii?Q?KdjON4voTQbCy1WOrk1/R8HHJdgIVhM+3Nrv4lpwLPO0KcXEy/zmZ94Dybgy?=
 =?us-ascii?Q?lAhxvYVIPeXFGWrNzznQ7epMxP3+Y5QrXRI6n6TV/h4ka4lxn/AtXwiCrxpN?=
 =?us-ascii?Q?l5mOZ4RMGclpvmyGgHGVm/vEEMTtbRCyPELT9LWFKN+vzQgkhVrAFFf8iy/h?=
 =?us-ascii?Q?lbNApH0xy7URSrl2qBch4IJL5kAWV1LU1IbqTr7Mpglyt8IILJsEv0OkVPo3?=
 =?us-ascii?Q?RRLxN3H6cVYYkeZKxGqJQ9MkrgXQsUjSqSi/Bbw+VnODElBeN6zKyrdTYRau?=
 =?us-ascii?Q?rwURWnf1Dkw6Wj9DVFtOq9j0fb0i2IQEOnSiQbVWz04V0iTJdCxX4pkxxo1b?=
 =?us-ascii?Q?qr59Gz162CufRyJ1aabGk1DAFPjjLMNIPPDu6pJZw0iKD2b4ioROOWKueVM3?=
 =?us-ascii?Q?ToslZDAeJQ5Vs6A3PkEG8y8x+M5EtmRTuyvwK9i8Dl69gMx04b/H1D+ng64z?=
 =?us-ascii?Q?T3AlVgS76nj3cLkOLLNwjoRPunwR9zYl+Bzklm9btAcNwRC5jMDn6/OEVMBy?=
 =?us-ascii?Q?8AGqKozZiJjSilPMakphy1piT4T2h7RChbl7H6IdaCh7/sBV69gUv61coBtZ?=
 =?us-ascii?Q?4Ko8M9+vq4l+6Ue8UACYIEqr+UeVolHBaNUKfCjynKGdUNchU+2YDY1F3rR9?=
 =?us-ascii?Q?463nVxc90PsQMx4VpU2ze3xuT/EWveW5IG5tb0cmpnb3E/yboaJjGa5ELXFC?=
 =?us-ascii?Q?kg1VWQi3qXUc2jiphDdHDms+H5iTpgk/6XKoi9SlTGi6PhwDlqCQQV/BI5yO?=
 =?us-ascii?Q?cyJx2HAfv47XZHAE2Uyo3ACZ7JrE/lmI6VQ1K/DG/C758ERTF8X2kZjQt9f7?=
 =?us-ascii?Q?RzRwAEjMVlV2nB4NPrw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6760336A8CE9F024A8F05FCDE4D8ASJ0PR12MB6760namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bfe853-34fc-4ff7-6056-08dbd3e37d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:17:01.6002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+9XAtS5V5Zh6PUWwF4UmwxbyFB9qNYLFAnj9BdID0UPAiQRjZo0qB6/91Z3UYz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ0PR12MB6760336A8CE9F024A8F05FCDE4D8ASJ0PR12MB6760namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

ping ...


Thanks & Best Regards!


James Zhu

________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Thursday, September 7, 2023 10:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kamal, Asad <Asad.Kamal@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Zhu, =
James <James.Zhu@amd.com>
Subject: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely

amdxcp unloads incompletely, and below error will be seen during load/unloa=
d,
sysfs: cannot create duplicate filename '/devices/platform/amdgpu_xcp.0'

devres_release_group will free xcp device at first, platform device will be
unregistered later in platform_device_unregister.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index 353597fc908d..90ddd8371176 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -89,9 +89,10 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 void amdgpu_xcp_drv_release(void)
 {
         for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
-               devres_release_group(&xcp_dev[pdev_num]->pdev->dev, NULL);
-               platform_device_unregister(xcp_dev[pdev_num]->pdev);
-               xcp_dev[pdev_num]->pdev =3D NULL;
+               struct platform_device *pdev =3D xcp_dev[pdev_num]->pdev;
+
+               devres_release_group(&pdev->dev, NULL);
+               platform_device_unregister(pdev);
                 xcp_dev[pdev_num] =3D NULL;
         }
         pdev_num =3D 0;
--
2.34.1


--_000_SJ0PR12MB6760336A8CE9F024A8F05FCDE4D8ASJ0PR12MB6760namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
ping ...</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; font=
-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);">
<p>Thanks &amp; Best Regards!</p>
<p><br>
</p>
<p>James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, James &lt;James.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 7, 2023 10:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Lin, Amber &lt;Amber.Lin=
@amd.com&gt;; Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdxcp: fix amdxcp unloads incompletely</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amdxcp unloads incompletely, and below error will =
be seen during load/unload,<br>
sysfs: cannot create duplicate filename '/devices/platform/amdgpu_xcp.0'<br=
>
<br>
devres_release_group will free xcp device at first, platform device will be=
<br>
unregistered later in platform_device_unregister.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 7 ++++---<br>
&nbsp;1 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c<br>
index 353597fc908d..90ddd8371176 100644<br>
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br>
@@ -89,9 +89,10 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);<br>
&nbsp;void amdgpu_xcp_drv_release(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (--pdev_num; pdev_num =
&gt;=3D 0; --pdev_num) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; devres_release_group(&amp;xcp_dev[pdev_num]-&gt;pdev-&gt;dev, NU=
LL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; platform_device_unregister(xcp_dev[pdev_num]-&gt;pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; xcp_dev[pdev_num]-&gt;pdev =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct platform_device *pdev =3D xcp_dev[pdev_num]-&gt;pdev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; devres_release_group(&amp;pdev-&gt;dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; platform_device_unregister(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xcp_dev[pdev_num] =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev_num =3D 0;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6760336A8CE9F024A8F05FCDE4D8ASJ0PR12MB6760namp_--
