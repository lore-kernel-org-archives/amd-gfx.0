Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A123C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 14:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6232210E720;
	Fri, 18 Nov 2022 14:52:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0C910E720
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 14:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb1WJLrxGQfUMKqf+26WEIKLrgT3qSLRrbodCeWNUEniqVwwJtYucgqbjy1UVxs1LCBA2NgnvOwAPVCCrSu3BGEQrdDYvq31neaC+kdk5iE4w0uqEZWAoT6UpTguNd+LDplQt1GM/en3gk0ZYnV/8nCFuFY2kTlLSAm49Hz4ZrhT3GONJNb/4oqO5h/0OcJ8zaT3PJefUQFemZ/kj5DY/kOaR/pdZ4DnRqhz+nd995KznU/qlWpDbL/Rntk2q0Hld3jqFzlZgSTMUy2/mvfWLqrPQOM2jH+wME28JTwfrNZr61IFFuccFjfHPlPhrwsH22IiXQNLqhKjhN9qlxCo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYXuta5x5Cy0tZ+uxHmtayScAEHP5doQN5wz6yJJiCY=;
 b=SVNNFg1NYokMRu3c2f6mT8zoy2/VPGuXBfwXS8cbE0gHiPfBjmh9rt24iYpIr1RGi6DNyNJg4doRyXK4p1pdMbt9rS84hHD/8FTN8aRNDW17faMCVUuR38hioM28yDJbawkFSVrTxec6x0DxWOfXrUcF2VijveVc4x7oMQGHmQOplDV2fWmJJXxX40DACbLNch6W83pyUt310n81O/eAqBJI+5dDg3eKDOlAffiMiG6iKiXSdQVYmBYsnSKmY+SdbqEgucuG1BlIfUjB8FriDCJ3aO3V+HGtQPNM2zRNsUGEIQ13HLUrFVmX+7JcFaryygkzhtV8uZ5e5WiPt3ij1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYXuta5x5Cy0tZ+uxHmtayScAEHP5doQN5wz6yJJiCY=;
 b=t4pdQ1O9YJxNeonVNgmzLDO+cSk3DVps01OWopWxsM6C34IEAc7NLBC0LWtZpXi7UsUSGvCs3Fev+W/xj2ny09ghB6PtJ5G5DIWA/isWer9PaWbJI0EqLmfmGaLSWTY/m8swBrVUn6QHVD0FY5ZT2D2aes108R32fpeHlvQbTKQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 14:52:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%4]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 14:52:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update documentation of parameter
 amdgpu_gtt_size
Thread-Topic: [PATCH] drm/amdgpu: update documentation of parameter
 amdgpu_gtt_size
Thread-Index: AQHY+yrVI6fwZ0FhmUmZ2h0ddtMtpa5ExFlj
Date: Fri, 18 Nov 2022 14:52:27 +0000
Message-ID: <BL1PR12MB514403BB9F01744715E75F06F7099@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221118084931.1381499-1-zhenguo.yin@amd.com>
In-Reply-To: <20221118084931.1381499-1-zhenguo.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-18T14:52:27.246Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4251:EE_
x-ms-office365-filtering-correlation-id: 73f1c3f3-4420-4a45-9046-08dac974831e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjrWTKu7mIA6wkoI9WTzn+aX0eNp6bpBmnikenkJJT42fXQkhGlTHmavEr/xAgKAY+hd3JyJ9VNQsgqV06sOxYiUJLcuNOeSduR3pgi6FcPBWQs9bA2rXjrn0p1I0FOykuYhqJlaIPwXVfmoZIKvPGZkgVfC063/PM+LK1ik0e1iRo09vVsG3rPkoBfvL8FRfJ2NGbFHjCKfRLDxkvWJ0QlkFhHrP0Dr1GxYcJG0STNBCyE/OWIO3aZDN+CrA0A8Zr3xhCs+ssanbA44QS3stm/ZKwmhV6Y1fRVllQHfzaCa+vZ9VN2xVdnp4gz1pyoK2xLKLcgcHyXh1YWIvTwRpe1NWF42j1DEwvWl4DRpDAOV6wQpQ5vtVHciQxd6KYT+UvpBOo/hw6EV82pG5tnXvX9lEY+0SclQFojbK9yIq+yvnoAuznqpNi+TmTlH78mQJnVC7ZjLZ20iiZfFH6ODTTayC+KBI1lSHF2HB33AjBUPtbXStnxKxIBgIMU2ozwmoeNPQzHpi0SJMp9nX1ofwslRMKFBc2xunDIM0athwsEHPydSgvgVvMB4UY35u9VvRaHAehqdMgVYWCVD7aXgQkjA4LNyahY+gYcsvS1rcshRTPiC/cOwRc0zAoWpPlhDyPaw9MlbqhmNYijHY1cFfGSWd/o9+RpGBc6mXKLYQF8R2pwBvcVtnW92w8nemVLSWiDYg3DS1tXPx4QH+0KldQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(19627405001)(2906002)(33656002)(66446008)(5660300002)(64756008)(52536014)(41300700001)(8936002)(66556008)(83380400001)(66476007)(86362001)(66946007)(76116006)(8676002)(4326008)(38070700005)(316002)(71200400001)(122000001)(186003)(15650500001)(9686003)(26005)(6506007)(38100700002)(55016003)(478600001)(110136005)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ogALiypwjILPxtEWPvnihwxvLwmaIUIsifN4rKoJ7pRkthOazyAJiHpmuZG?=
 =?us-ascii?Q?ZdiVLrfTE9RpzJrsFiKSPSdD7ooY09B5brVswqsSZJLBLWClkmtXW4ycHK+6?=
 =?us-ascii?Q?/kHyXz66qmyZcpAs0ZbKCUZ2uKGFd+Nx1RnfBLSQzqvaGcslyUNbqHZ65dtw?=
 =?us-ascii?Q?TIG2s3ZTBTEtBNb2tOpkc2XCs3IxRs5wgwM3Ed8j6T7+CN9BA1YR8w4dJIj4?=
 =?us-ascii?Q?AjUjc7SWTSfqFSH1RJcD4mkePgKTj56wk8OWPIB6qWJg3epEL8C2c9bkhAC3?=
 =?us-ascii?Q?A30s/s2iRjZtSu0tx3xPCvNa8PmTs0R+uzGQrlREKfTCXaXOzm2q8fx9QXAE?=
 =?us-ascii?Q?3P12yu+Khc+c93IMKCuc6Jql3dr1Y8x2C+awHIwMvf5hZiq7lok+OijgtEfk?=
 =?us-ascii?Q?BE552h+xVwC9HDPShz2Y/+Qpw0fSmxv/Zln6pjza8tlkxzwo+5fmO0jdfTaA?=
 =?us-ascii?Q?7sQ9pucKaE4HNgB6etcKfTC6dGlvvCYZ4u19idwgAe2RdiqCstPm/Wgbj3TR?=
 =?us-ascii?Q?6Ent5KB5WXJL3k1/gg/YCjoRWHHkXsp22hOd2DtJ9gb3/nDp3oJk5jKBk6YT?=
 =?us-ascii?Q?pMrDHUwPVASUf9l1Z6XKAsnd5sOC7g4atFlFk19eONV5yJKD4UBZD/c2QEzg?=
 =?us-ascii?Q?H7PA47RZWt5mg5j+kGK3rPuqEN44nffDlxZTGbH6DpBBSiIt13y2AHwTxj3P?=
 =?us-ascii?Q?9oEe11EbuqvfKyZP12WIa1i8q/HmHox1qdwh6xxSv4AHkQ1xQbJNNOd2IndS?=
 =?us-ascii?Q?fj1eNeFZtrvBrWZv+dQLHCZe9grYbI89aLmi7XCxfnkMdpJKhPsyf2ijFstS?=
 =?us-ascii?Q?qpP73wspFbT/jqVDLA4KgZVfUFmdTH+yHCNCcDb1nEPrJH63EMzVgSn3+uqO?=
 =?us-ascii?Q?OD7w6l8rFi6D0+L6f/TnJhJCpxKsBKpW7QnDv8scE3hkRiDBeyRCiFu8Tjl5?=
 =?us-ascii?Q?7jag/+GxM06vqCmRMuQTt5s5dMGp2dBMpG5VRfsKnJnszc9QTb6tYnlcklGp?=
 =?us-ascii?Q?sWddzciGZgowMDgtg9k/UMnv+lkr3djjkueHZ1+As1mdyaWvRIZ7E90lP4+P?=
 =?us-ascii?Q?Rc8WRdPhwDAD/2aIMq6shg1l4LFUQwDFA3T23l/aIED+xZy5j7YKU9MgqVRi?=
 =?us-ascii?Q?42Pv8CWWjLuX7Q+yvhs7YBFjWjnVGmYhdl5RqO9YIm+RGGmG7LHmHoxK7lt8?=
 =?us-ascii?Q?GPu/V1eIDPre33PH3Fxq6LNc0sa1QK9Rzf5ILmf8h7ysjnAOt0cPer7x3EsU?=
 =?us-ascii?Q?uxImeqctUSYQ8HBH8qNRw2PtndQML+v0rOGYWQKDCq2O+mkZmeXm93oHgrRU?=
 =?us-ascii?Q?jQGinu4SRb+d0P8raAkjP0g/FJJ7xa5RVGpvm0+HxhEdDKz4jaPQAAo2KPOu?=
 =?us-ascii?Q?PkLULPxgzvxjIAd1Us6FxJHAdtO8AGslmj1FMOUkL7VHsQZsRlAC/VKvTbxP?=
 =?us-ascii?Q?ctYMAA7Nql66yHawmSvn46hS6DdQNf1dgTFf8K2f7Ax4Ti4EKtQ4cJiappEP?=
 =?us-ascii?Q?7dlq28TRIKI2O+XKgfmziVpbCpgtlLBNaU9zpG/kQWT5D3bAI72P0TpLewBE?=
 =?us-ascii?Q?dhQ2gWMzqMx6V7AwYxI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514403BB9F01744715E75F06F7099BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1c3f3-4420-4a45-9046-08dac974831e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 14:52:27.9554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZZ2NrMBOheAxO7rz9LhfHyj03LjVO9RCTf8S2KJblVQeS2lt+7Rv8OVIQjAizna4l7ekS2+UwVUk6v1JQ/0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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
Cc: "Chen, Jingwen" <Jingwen.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514403BB9F01744715E75F06F7099BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Sent: Friday, November 18, 2022 3:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Jingwen <Jingwen.=
Chen@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: update documentation of parameter amdgpu_gtt_s=
ize

Fixes: f7ba887f606b ("drm/amdgpu: Adjust logic around GTT size (v3)")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 72b77b3ac4fb..987914532104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,8 +237,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 06=
00);

 /**
  * DOC: gttsize (int)
- * Restrict the size of GTT domain in MiB for testing. The default is -1 (=
It's VRAM size if 3GB < VRAM < 3/4 RAM,
- * otherwise 3/4 RAM size).
+ * Restrict the size of GTT domain in MiB for testing. The default is -1 (=
Use 1/2 RAM, minimum value is 3GB).
  */
 MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 =3D aut=
o)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
--
2.35.1


--_000_BL1PR12MB514403BB9F01744715E75F06F7099BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yin, ZhenGuo (Chris) =
&lt;ZhenGuo.Yin@amd.com&gt;<br>
<b>Sent:</b> Friday, November 18, 2022 3:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Jing=
wen &lt;Jingwen.Chen@amd.com&gt;; Yin, ZhenGuo (Chris) &lt;ZhenGuo.Yin@amd.=
com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update documentation of parameter amdgp=
u_gtt_size</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: f7ba887f606b (&quot;drm/amdgpu: Adjust logi=
c around GTT size (v3)&quot;)<br>
Signed-off-by: ZhenGuo Yin &lt;zhenguo.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 72b77b3ac4fb..987914532104 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -237,8 +237,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 06=
00);<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * DOC: gttsize (int)<br>
- * Restrict the size of GTT domain in MiB for testing. The default is -1 (=
It's VRAM size if 3GB &lt; VRAM &lt; 3/4 RAM,<br>
- * otherwise 3/4 RAM size).<br>
+ * Restrict the size of GTT domain in MiB for testing. The default is -1 (=
Use 1/2 RAM, minimum value is 3GB).<br>
&nbsp; */<br>
&nbsp;MODULE_PARM_DESC(gttsize, &quot;Size of the GTT domain in megabytes (=
-1 =3D auto)&quot;);<br>
&nbsp;module_param_named(gttsize, amdgpu_gtt_size, int, 0600);<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514403BB9F01744715E75F06F7099BL1PR12MB5144namp_--
