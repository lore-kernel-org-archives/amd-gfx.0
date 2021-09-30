Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CAAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 21:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BEE615A2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 21:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05BEE615A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8264B6EC81;
	Thu, 30 Sep 2021 21:18:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 679E66EC81
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 21:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpK+a8fZM5KTUOC2FU+B6ksAeG3BSsGJ1pcTsooND+6yveR0nE4kNGeJMaEFgC6iAeyI/ytu6RvnkoM7Pp2+KE4disw0JhIdTNBaL/KrttEISz8QY62aRJTleSdkkWEsyStA6ZKiQU8qqRukf/brHEfSILaocBdNAiYyA/kFDI3kDiP+ZIQ04eAEu0CzEGwZERbfCWxQ3cLdMlwghVWwK9UzjT+WeTxjU2l48P4yqM6c+MGi4bw9FIkO5TF7xcHQVuFPlqtt31ErffdDcVIwjfiPjphXIQRQKgsBetbMxWbkP2xHrUH6T+TLk7Y+QyjsA5eU/SkpfFVxvEed1H10ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf1FjMI7Ot3A/rchXn207UOP046CFVbQqfn/hucs9kQ=;
 b=bVFuvynBwmMWcXBbAr3JbqNzjYb3k5IIV5GqIr8apGVuYkyszlxvknfBcMan1u+t3sF5p78zfFcNtGOL0YnZ3AfEjGX2LMTBf9+qNzVGI9S7pwGCAg+W9Bd1pjaCFIFz2T9PvRpClFAp2uLhNqveuE9PJ/+HQwRT2uHwy6DyG1bWkEuYkhoCAOagW+eQNf9Up3a/OMLHdGc5wbHAvZDI0j+F1I3XIjEKG8xuFcVtOCSKd1Pi9Rl9YhCrluyY20DbJzKaCt51VNZ9SdtcOxpKbeNyXFTODNRLYAu4ssW4EnaujFWLehNtqtNE0mqLGy9f1iDPjAZAiyCdYwLkNa93dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf1FjMI7Ot3A/rchXn207UOP046CFVbQqfn/hucs9kQ=;
 b=MeiqA7TuFIm7pOhawjIpU4R4aJ+IbbFQV8FO99trKkvrymXhUQA53doZCLSVcRFPbH/HadREHfK1fKJhLky6xrSn/Y6DJV5ICJC9zQFBjpud19mviObe+yslupqG7ippauzN+rc2uDYTLvyOaxuw9oBvRzVAHAXDwdzHIkP4mY4=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 21:18:44 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 21:18:44 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code
Thread-Topic: [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code
Thread-Index: AQHXtELcHFQGCvXu20SIRzrKf1Fwlau9GLfm
Date: Thu, 30 Sep 2021 21:18:44 +0000
Message-ID: <DM5PR12MB1884D648FC0046AF178BF02FE4AA9@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
In-Reply-To: <20210928082819.205231-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-30T21:18:43.563Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: a455e43c-35f0-ef94-1405-ac9ea434c83b
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87623876-3009-47a3-705f-08d98457e27e
x-ms-traffictypediagnostic: DM6PR12MB3514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3514B16D87A42CD4757E644FE4AA9@DM6PR12MB3514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHHn3x/+Pz/lcpc0JQn6PAyRQXApss3H0a2kEIfBcS93MCIPC2qR7OQTZcBMZShGgzUunLiKJ6qEYFB6F1RiPYerxG5WCyHGOxZBcSNMMVZb+oOijWjJIwlMudzWGzA9wJJK/bwaXsuc/ttHTCQJxtExbcv6mrpaeadD9I5sf6z0ygkJvPCch1J+tMw1I14XMAYEpJ5ZOIF6RbAxWcwl1rJeRG3w1zN4+a6rt6RTKzf9sHVwfXCSB1Sn2HK0iRwOR/MFPr9Nq1uI8gEfXroXZGsBkp4Uawj5fetEBHeWlmlwuvnhVQShmByba7bFB4M7XR+irxFPdx9jKz1XDbWFv/8R9OYcdoWQZughROiauc+QPJSXQx7KzHQbzCY/mFx15o3+s7GzfXQS8TaE51cSokHHvcddqqMrhuty2HHTD6jZ+VNWPVMNDUH+iXCmvzi+kb6eQRnTDpbfFb1pdxqmyLDnRHY4pu+JPfupDKcTNsSeSsuaeVaqqnCzY80P7SBM1H9GOlO85lluWKNilfoTsfkYskhmSchnbTZrBUsVIhhY6xiMs8PNExoMTavO5RuLutsNE0fUj9zae1WOH9RNVd7LnwIDlQFPoo+5ErNCxAfi7640FNklUTLQ/0G/iSi5WyE5U2XuSfMybtbkJCw30fNfSuy7IW9ZisgYBbNEYsyzNgKYVLsvCYjPGuhtkB8XdyhysCF0Iqnd6RtRxSVdxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(76116006)(7696005)(316002)(71200400001)(66476007)(66556008)(66446008)(64756008)(66946007)(4326008)(53546011)(6506007)(86362001)(33656002)(2906002)(83380400001)(38100700002)(91956017)(5660300002)(9686003)(26005)(19627405001)(8936002)(122000001)(186003)(55016002)(8676002)(52536014)(508600001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhe3Cyf2TKg6qelQbBWnsfJRAr+95I9v4xmRnRWBDrIg6cLtoIn8D3zNBKA3?=
 =?us-ascii?Q?4lqUqZg5wI2AMFn0owkuZldMjUmxR9pBr/2D2IiTVcrE1EYvo+efQL7IYAw/?=
 =?us-ascii?Q?FzAfNXZUUtuZdv8Towvoi650epA1VP9BifAdhNlOoIDVRiecIcZse0wxZ17Y?=
 =?us-ascii?Q?xrH24/hclUo/FrNMwJPPP2vya8agCOtS4xdQXAzOGI7xr8B5nICeK2AkZYOS?=
 =?us-ascii?Q?fOBx7xqBMrEiAn+5c7cGR+x818Uj7iCWG9dNOcuXqkmHRZTdKEiEnVgTgjuL?=
 =?us-ascii?Q?dTVnR36SygsDblChREA8W+QInwT2gFrgxPv0FfOe/cjuPlNkqBrKvbSuiuM/?=
 =?us-ascii?Q?MjpgIy3IVQeqDtWXCXoKeyzVa6Fk8uHL1/05ASZ6Rgl28+FauMUUXsX2O2Xk?=
 =?us-ascii?Q?1M5cNLzdd59ynGXYpIELikoSsE6FWqWotrkiSl2OPavW2ZTDT3vy9a/sjuM5?=
 =?us-ascii?Q?brEVXM3+jxYrKQs43ZSFw1ISY9Gk3O4SAvZBDWD3IchcTvsZ8zTBd0x/DUwu?=
 =?us-ascii?Q?Ut+2w3q5oVbTMdOt++xJXgkhKv0O71LMdiDN826kjau+t4t+vT6CgdTibmKP?=
 =?us-ascii?Q?Umvhugd6AU9VZovOcouunmaTT1L4NSDD+g7ew92ZuNs72fqo47vFHWjUWuVI?=
 =?us-ascii?Q?eYZ4Wo/8PhmRE39eAooYlvBWdHV5WCi+hg3oHmosjTL8Cyoew3WQaN/7nWHr?=
 =?us-ascii?Q?MbSJopvjav98QLjJQWhuwo9Ro/y7VRCZA7sPJU6j+mWbJO+S1DchnMNh8ZkI?=
 =?us-ascii?Q?6mTYph5jZGpylLcjGNRJZfQmY/58d2XRHDbVfRitAzxx2si20PwC6rd88S4Q?=
 =?us-ascii?Q?XLeZpEriAEUReL68S9fkLRbqPWaL9Prx4GO8GvQE+SZUHJU6fbqZTBUpXFVN?=
 =?us-ascii?Q?vv2MZGKutnWG+n8xziD82qaRwlp4nf7Yqz2M6gw9Uv22HPbrHPfDMvKijZk+?=
 =?us-ascii?Q?OBjI10UKvj2/YfA+HNCgZ/13eoZpCxhGTAIxldeJDffmYeVzTp9mgNlb0EkV?=
 =?us-ascii?Q?7vpi4u/stpH2JZ01sW/xBiOYoyM63luGE591OATvwyxLheDYR9CC2004/f8j?=
 =?us-ascii?Q?Y6htaN3l3AbMWxJGhFRJ99O0j+qUmBOdwtF5+Uouzein+gtQNlEh1XGx4W8b?=
 =?us-ascii?Q?mHH0GSpjDGOCCiaSzH6+F+AckOwAyLQy9v0UZq64OZmvwXL+bMl9Lzwe1DqZ?=
 =?us-ascii?Q?/w1WxTJX3/2sAAmdVKlBDejkZamnfBThc+YGH8kcEiY+gA0P8EX3Wu3AU9pM?=
 =?us-ascii?Q?IWqwjwxFci5WRbELA+jLd6uQ38AUfVIu6sY/6WAI6J3kISG7CGtBt9zvHDhe?=
 =?us-ascii?Q?XqS8+IifIXRjUwP00+rPaJ7P?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1884D648FC0046AF178BF02FE4AA9DM5PR12MB1884namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87623876-3009-47a3-705f-08d98457e27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 21:18:44.3185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBdpdwsFarsxOkzKM2+02ednRuPIlBL18DXU9EqfGjyx/XayiDVQdnTZRMn0U3jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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

--_000_DM5PR12MB1884D648FC0046AF178BF02FE4AA9DM5PR12MB1884namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


Reviewed-by: James Zhu <James.Zhu@amd.com> for the series



James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Tuesday, September 28, 2021 4:28 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code

kfd_resume doesn't involve iommu operation, remove
redundant iommu cleanup code.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index c2a4d920da40..4a416231b24c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1085,18 +1085,12 @@ static int kfd_resume(struct kfd_dev *kfd)
         int err =3D 0;

         err =3D kfd->dqm->ops.start(kfd->dqm);
-       if (err) {
+       if (err)
                 dev_err(kfd_device,
                         "Error starting queue manager for device %x:%x\n",
                         kfd->pdev->vendor, kfd->pdev->device);
-               goto dqm_start_error;
-       }

         return err;
-
-dqm_start_error:
-       kfd_iommu_suspend(kfd);
-       return err;
 }

 static inline void kfd_queue_work(struct workqueue_struct *wq,
--
2.25.1


--_000_DM5PR12MB1884D648FC0046AF178BF02FE4AA9DM5PR12MB1884namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
Reviewed-by:<span style=3D"color:#c0c0c0"> </span>James<span style=3D"color=
:#c0c0c0">
</span>Zhu<span style=3D"color:#c0c0c0"> </span>&lt;James.Zhu@amd.com&gt;<s=
pan style=3D"color:#c0c0c0">
</span><span style=3D"color:#ff9d04"></span><span style=3D"color:#c0c0c0"><=
/span>for the<span style=3D"color:#c0c0c0">
</span>series
<pre style=3D"margin-top:0px;margin-bottom:0px"><br></pre>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;"></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yifan Zhang &lt;yifan1.zhang@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 28, 2021 4:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Zhang, Yifan &lt=
;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">kfd_resume doesn't involve iommu operation, remove=
<br>
redundant iommu cleanup code.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 +-------<br>
&nbsp;1 file changed, 1 insertion(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index c2a4d920da40..4a416231b24c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -1085,18 +1085,12 @@ static int kfd_resume(struct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kfd-&gt;dqm-&gt;op=
s.start(kfd-&gt;dqm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(kfd_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Error starting queue manager for device %x:%x\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;pdev-&gt;vendor, kfd-&gt;pdev-&gt;device);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto dqm_start_error;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
-<br>
-dqm_start_error:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_iommu_suspend(kfd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline void kfd_queue_work(struct workqueue_struct *wq,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1884D648FC0046AF178BF02FE4AA9DM5PR12MB1884namp_--
