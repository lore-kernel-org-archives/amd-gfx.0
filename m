Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3AFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C86B60F46
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C86B60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386D989F03;
	Mon, 25 Oct 2021 16:28:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55089F03
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 16:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGrfMUym7t31Sc9xrzhCC5QPFi5bCDHJ+inEBS+7ODcacgGxFHUC1F5EzkwgUCHKUqD6Ljm9XJbTIeE0+Jsr5yBldb9fJ7vLMuK+tnZoKEbvZeOgVOUJ65I1naWP3ZXXSxbvmBncZl8FgugzVE+bnV+q4O520jwdIANvRVO/34AvCFHlSugrzBSwZPPEOoBYZMy/5qUDJFKsp1tyx1Ne+/MerN3SzkVfcdSKP/jn02ma+fAzxpIasPv5JjYDyvF+JMzJ60j2oA4lHZe4N6LAk0Kv18Y5E+xJAUIDr527+daKugeKemD8mppTWDF2FJQDiTih85gJ4SWx5EHygR/gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2F2a+b+1C9E2g4Tl45droY4Jo3IeIYG7c4CTUrEKQE=;
 b=anGlOQ09rpE7Gcr88IXwnQ9dZ9aJwvzTYO+xZI++fGdhHp95Uh9N6iweKbROFDzFNjyZDGFEH4F+z+oFZNODX2794MfALPQWDXg+FYVymT6K6AlvmXVkIjhpAeC+wr2DbHFDG6+4/+SoPcJgx+rDa6z23F/ZgBObUHdl5PZlQQdtUqWWuo8BRKmxGU0kDBsX6LFoU0lbKeWkU356tYpC1mshdTjRfsEXwgLucBgtIiaZtHmy97MHv/614O//ixZm2yXG9p7tooiquLVjxp5Vj5P+fG7FW7KYSmCl92AIcUQNqP/IBvbosg56EEFsV+sMCfygd1i21aGLZcG1Lk9ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2F2a+b+1C9E2g4Tl45droY4Jo3IeIYG7c4CTUrEKQE=;
 b=m0/douJrUz+8v9PHZ7DsxudmKBRhFUhw5VIeLCsLPZ8mjwmBdfYqmZHxc5Xkki6PDlpdUi6sqonAhriwkaSHdjcNn4aq7lVqb1Ad34bSsPe6SPGRQFIdgOwqn7EjPpZ4cgWZDslN77YQezKBj9eY/WB7+FhHSZ/vadfZXnUfsbQ=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 16:27:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 16:27:58 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Topic: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Index: AQHXybm+VTFaZdK4CECV7Va2HooeQKvj5o0W
Date: Mon, 25 Oct 2021 16:27:58 +0000
Message-ID: <DM6PR12MB3930151B398A178428C27D5D97839@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211025160220.51401-1-luben.tuikov@amd.com>
In-Reply-To: <20211025160220.51401-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-25T16:26:12.2633033Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c585abf-9655-4208-2c44-08d997d46846
x-ms-traffictypediagnostic: DM6PR12MB3020:
x-microsoft-antispam-prvs: <DM6PR12MB30204A249AD818797931831297839@DM6PR12MB3020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKb+wxj5pbFB1lBDM9RxBxRi+KS6sq7mHqnJVrUllPn59RKF+HsdkqXda5q/up915vQsqQ3zvfx1HPZaTn/rxkUCoPZzVDmnPWuQbsPBqY91ChNiTfux4I0MZcOqktdMa8z4IiF+DxU1K7GXgEjOxZfAPBCZDkkQNlHeCzpn4pYgcA6PqKGaR/pjy4ct5i+n4Oe0gv3UEx6mTrACy4NJ5A1DBpB2Auh2xO0VTfP4Y4EHQYsEzI2fjSkMZHOLHB6xnjrePMjWLdTtNmPE1N/QITMKJ9c5VvBlKiyo6vSbe6x5cJWj1sBXzyIBzS82aqiwCWLv6Z5gfB1NNrfDs9ntJxvTS5HIJs3SqpG1cejaSCZ5LhGRiFIPkhcDQ2sFLFS9W3dmpfCU5ui9zmaEVS5pDVVhGZGMapwaL+T8OmNanDhMr9yS3/x7lkLfZ6DvPlq1QcJc3m7hkphHdNCMi4xQleDgC0m257CmuvZLs09CgU/P6S24ia8dQUKI0MA487oahboPLfvvFnvY53AP1iGiNZYsVidNz17smKRoSRgR/vb1JhrI9b2HXL8w3l0kPI44j4m64qHZgWfayNF7BtWN018BCXAkjs2pYbOAvrQbOOtGRlR/f14JhBhtRyr7iifV+ngob66lfeDFEZ9Rjo4Nw2sNEExmY2o4/fO7FP9qX+KS4rW2qpAtD6Cs8ScunDj5HVBlj7VNsD82Ro+Qullvqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(55016002)(26005)(53546011)(6506007)(66446008)(71200400001)(4326008)(186003)(2906002)(91956017)(5660300002)(9686003)(66946007)(64756008)(8676002)(54906003)(8936002)(38070700005)(122000001)(83380400001)(86362001)(33656002)(110136005)(508600001)(38100700002)(316002)(76116006)(7696005)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gG2YPzqfc4mJ/HhHsxnsVAdtf7gE7WZOiBHWBetTvNi/h1xtMphQg7bH+rBn?=
 =?us-ascii?Q?KiruPw7z7lbIj/I9NrpdZua7TXhsVDNaQISWZAdEgiDZm02jOwdleL0I9Ckz?=
 =?us-ascii?Q?c/J+cgY2GE1TeoEhhSdSWJGng8EkBhY0vo7qlHSOCTHq1uU4DxwNq5g5zCJ5?=
 =?us-ascii?Q?z7HdgLcFuNChmVjiZdoBzF5Rqp0EConE1mnw1y5pNBafGclhQzhZb41Z9/eo?=
 =?us-ascii?Q?FZsZWpUfqp5ZoCy7WqpBZeERblsRYchlHCnDGxO1aL5aUuEIB7yLpB+uqz+8?=
 =?us-ascii?Q?pxEDDsp2xG5Y2lohuKdAvCaS6wmTjyrmr4M789Svf+JkmTiEzwD5zUHGQBlD?=
 =?us-ascii?Q?jmhCw0Vt5kzzgsSKJJMfThEfcPOkrpU/DzK7wi7BAJfCbyRsGOYf5qsoDuXS?=
 =?us-ascii?Q?WUFHim6y+VFVIj86Fy3nGyIUsjap76k0UQ7+wp9n4C7hPY1qErO4RmrX6Hj5?=
 =?us-ascii?Q?ZVmcSphz3YBGAEiRkj/EhJQNRAVf3hUdg6De+7IfxZH1db4yeZccsHN1UuKA?=
 =?us-ascii?Q?RcAduJU8NX5Iur7eFMRsXvKtyjKlqb2gFLLbSIp2/+xtl1gwGAaAL1s96mYu?=
 =?us-ascii?Q?XZoUXgokTY4sxseTJtZ31WsVOwo55f/wyy9mgQIkizgr+p2+E/J5RhTE6KoX?=
 =?us-ascii?Q?1145zRlWDc/fISzgjcuz61sW9K8hIaBOur18sELVNWe0BDeiUFXznJPVkx2N?=
 =?us-ascii?Q?LTWGpsOFFCEHpKvpU+RKoWM3lJBdcYHvPWV0Hi7IMB1PItsRpclMUGdrTXVN?=
 =?us-ascii?Q?9NFc83Tb/KqZVDCWMHi+mfzofcXMCpk9e8Ym+At90unNxPVAKZPCfvZHLOO3?=
 =?us-ascii?Q?iAHnFYOfAlM5rkdCjjQSifxus7acvE3WK2BdZKFg9QggWqJYo/vDOmCXwiZ8?=
 =?us-ascii?Q?k1NhomT3xHG2Hwhd5jRFClwWp5dXdSx4q9qEFksRESrBUMqcNEQ07C+lNXdN?=
 =?us-ascii?Q?c6hVfejvt4hevOrTxJ20aQjEAA661E7IaGrhTHKU2LNhjkjXZlAnMiyFmepX?=
 =?us-ascii?Q?htmfgAp8ENILCTfwKiABklYSJruJJe8eqdhrANCRxluLZE12jfjS41C9L871?=
 =?us-ascii?Q?LuFNZ2Eb4fTlXStkEYTXbDY7g8ODNUv+m4+Zq4mbJE27XyOSr0wXI4zVLFpI?=
 =?us-ascii?Q?0FLfDXn+nVx3Qj+JigjfYi9eyD5DwM9Jk7iIy/wTVM/yYzixLbiiwbOE6pDy?=
 =?us-ascii?Q?DONsAdtcnSzFvJqy0fA6NVMPcCzBfRN2zphUJrrMz4ZfBGNcsuj0bSuj0BtP?=
 =?us-ascii?Q?Iqj2xHC2wCxrOJwJpA6Faek84udQPrsrPx5WGqgu+XnsVMxNXDZYmSJAOHir?=
 =?us-ascii?Q?RyfGapUK0a1agl0BL8bqq4BXumrHaM7di5hM1oUHQwQL+KhUzepzyM1F57Oz?=
 =?us-ascii?Q?GWXKIKq5/KaQeb0FupacbRA0Cap3jU3IJD5osGooxJRG9UqBoodQV44wOnVy?=
 =?us-ascii?Q?txyt3Bia8wGQ1ra8ijw/gGXh4bFRfBlm3PcHQzEEEXSsvlal0Q4Pl53fW9x/?=
 =?us-ascii?Q?R5KzSSu0n6wxkCiIxcFZa3yfCtVbrdtjKq6nTUli/fRMh5NbMMo88L50Seh7?=
 =?us-ascii?Q?wfqa666X/B7szCSSR1c8hCpfS8enOlBjqSw9wUXb?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930151B398A178428C27D5D97839DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c585abf-9655-4208-2c44-08d997d46846
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 16:27:58.6117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1Rjh4NbbtjZLIoTaknyL861uy9yH0cwwYUQ/Z/EuuHAw489S0t5+oNFLalF9vbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB3930151B398A178428C27D5D97839DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Does the message need a mention about the newly added option to ignore thre=
shold?

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Luben Tu=
ikov <luben.tuikov@amd.com>
Sent: Monday, October 25, 2021 9:32:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Russell, Kent <Kent.Russell@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Restore information reporting in RAS

A recent patch took away the reporting of number of RAS records and
the threshold due to the way it was edited/spliced on top of the code.
This patch restores this reporting.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 07df2fb092d09e ("drm/amdgpu: Add kernel parameter support for ignori=
ng bad page threshold")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index ae64ca02ccc4f8..05117eda105b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,
                                 res =3D 0;
                         } else {
                                 *exceed_err_limit =3D true;
-                               dev_err(adev->dev, "GPU will not be initial=
ized. Replace this GPU or increase the threshold.");
+                               dev_err(adev->dev,
+                                       "RAS records:%d exceed threshold:%d=
, "
+                                       "GPU will not be initialized. Repla=
ce this GPU or increase the threshold",
+                                       control->ras_num_recs, ras->bad_pag=
e_cnt_threshold);
                         }
                 }
         } else {

base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d
--
2.33.1.558.g2bd2f258f4


--_000_DM6PR12MB3930151B398A178428C27D5D97839DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Does the message need a mention about the newly added option to ignore thre=
shold?</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Luben Tuikov &lt;luben.tuikov=
@amd.com&gt;<br>
<b>Sent:</b> Monday, October 25, 2021 9:32:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Russell, Kent &lt;Ke=
nt.Russell@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Restore information reporting in RAS</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A recent patch took away the reporting of number o=
f RAS records and<br>
the threshold due to the way it was edited/spliced on top of the code.<br>
This patch restores this reporting.<br>
<br>
Cc: Kent Russell &lt;kent.russell@amd.com&gt;<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Fixes: 07df2fb092d09e (&quot;drm/amdgpu: Add kernel parameter support for i=
gnoring bad page threshold&quot;)<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index ae64ca02ccc4f8..05117eda105b55 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *exceed_err_limit =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GPU will not be=
 initialized. Replace this GPU or increase the threshold.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;RAS records:%d exceed threshold:%d, &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;GPU will not be initialized. Replace this GPU or increase the th=
reshold&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; control-&gt;ras_num_recs, ras-&gt;bad_page_cnt_threshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
<br>
base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d<br>
-- <br>
2.33.1.558.g2bd2f258f4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB3930151B398A178428C27D5D97839DM6PR12MB3930namp_--
