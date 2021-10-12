Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE356101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CE356101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5696E9D2;
	Tue, 12 Oct 2021 14:39:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4AD6E9CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj3YctBhmH+t/kiQ2N0JjySupi6fosqiiMwXWNbsMCgWgWAe/uopYqiyGwE0Wgd7Hp8Nt2WWXqm1QZS/0MQOLR4FFGZbF0RgqJYV/S/F151NeOld7YTUutCp2R3zx79VO+MRoaireUshtpl+kRwJwlVzw+OPYsOOY/HReUGa8Jj3VtBB2krjh3sKeSnHtxiJXEAkVQ4mFQ6jLcBAse71NH40UF4E6bWXCoTKmD1wBcLGpq8r4T6Yw2WcAJ/urs/BJR50azlaxvIZFidm3W3SO06SD6mhUE/oWaM6KPNpTaCexncWcJ0xX68yDsoz2jIa1hggPVm2poWNQ3YFMH/ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v98Od6AUVTlnHYqr/87jR8fKqrlXsJubp2eZbz5kugU=;
 b=MIec/Jk48R0TEpKB7am89OPiMmVXchJJMEJZLyISJHd1zsv78k39xoNlMqYQUiQQAPWNBjijJraaByLtk7ixdRd3F3wZlPMTMA3L9Q6t3f8eW6Fdn0VJEP7RAoqO9ltUdaP46WTk1qIpRbCVh2JN0pI28PYgmUJicC3dH4F8mtcjnnAEPlL6GuDW2cPnNO8aTZmk+Z9tBRW1TkCgUb/LZAylOw+4o/9MG11C4sRD9NHCwSokhUCmHLWpb3etCQrGfEzaORAZcaeCDSbVFqFjsF1ffn8DYKMqFbsh05ZKqijxs5LXiTNx9rhKx5+7JSQvv1X42Utk2jdWd50KU5tDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v98Od6AUVTlnHYqr/87jR8fKqrlXsJubp2eZbz5kugU=;
 b=hYUchcMeaIXj7puZImfgYWYmn20f545Ac8rDPLJatpEdtXbUbAm5IghFlBuavq/wXucvC5SWID8AxwwUT9+5ivEij2uMDMYZjjuZN93wjxHZgzgEaA+sZ5Q1/lWrSBShYRnWUBMWlospiWm22RINn96aQKKOSUkW5oJO+OAH7Ag=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 14:39:39 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:39:39 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "youling257@gmail.com"
 <youling257@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Thread-Topic: [PATCH 1/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Thread-Index: AQHXvp+VkyV5V4HFhUyAjMMfVsMz76vPb8I0
Date: Tue, 12 Oct 2021 14:39:39 +0000
Message-ID: <DM5PR12MB18845C4917F6C7BEDD6EAE81E4B69@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20211011125701.2800114-1-yifan1.zhang@amd.com>
In-Reply-To: <20211011125701.2800114-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T14:39:38.169Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: bf89f478-059a-e9bb-2183-78db60bc853b
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af93f378-754d-4d05-3df3-08d98d8e1eee
x-ms-traffictypediagnostic: DM6PR12MB2601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB260130E767FE912E6DF3B28DE4B69@DM6PR12MB2601.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRemoRG5W4itWavQag2toEwIpg4x044plHeTSVCUf6cydLcAzerqibQIy9UzOKMxR6RN4oxGKE3UKW6zdnLthoJKOMbLvQJOFSYM02ScGWYswtn9CXhqbPavIWxpGc25hXJukKOpwjfcI8LJ0GMsqe2w7QU4X3TMVi+8R0FsJOUaJx7dDnfemK/pUGO3Mz1FIcxTZzrn65m3PEsmVUzSZ1RbRAiLz5LxQ0LDhYVBl0Eh39ISkEH+dptR6VQ3Vql908WlFWr0jxcbpOPXMKtV8yuJxPCWmbK2y1at8Hcc9NE7TBJA73rIVXSrQmS65O1lmy4igLh0ua9v6HGqcY/uVKuO6EWHO8+X3D+1dEt5+KbcqWE5YqJw9Vf4YuPpfRVp9hdw8IvrgFzsSwjmqh9E/0YFDGFiHuGy4l9MDbi+5CvAPdG862ycYzTazLIXNm/OKMQUj+z/TTKMdbh2cfxFo8khUEoz9yUjJBGWp5OPsiXTmRfDhaP3DfTgGBFsV8nIe+Y0LFWE5SJxdiXR8SgoCMldpTNM643FNXkIZtDGa34IWwCiXGprMJdgOA9AoeloQupYclEROMTLiAOc0TpP2u7ORrp1bc9h/cjzyHEOE0yHdy3epCRKqB3ac1ekMwW40oW55wegVaJwHaKY59K/OH86jsTWBueqLJQBbc6giujPzXeDIm7/jXKwd6vH+HfutMngOGGfAvVDNWj7z41CXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(8936002)(91956017)(53546011)(9686003)(5660300002)(71200400001)(52536014)(6506007)(55016002)(83380400001)(4326008)(110136005)(26005)(186003)(122000001)(66556008)(76116006)(66476007)(508600001)(66446008)(2906002)(64756008)(66946007)(19627405001)(7696005)(86362001)(38100700002)(38070700005)(8676002)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZQhmhiU/NstuY3JxUIlcc3q0yqkURjL4si1+9GIXwL4BiwbcmaNcqz7cIN?=
 =?iso-8859-1?Q?HSEe+GieRxjKbCMo4iheTUXCS3KgtVrHj7/kNIcDtO1bWXn1VwYiWI++Tb?=
 =?iso-8859-1?Q?VUQ2r83OztSE27WOjBgO1cTIH8abhJlJyF5wGExR6Gablm99eJYpVpa5Ks?=
 =?iso-8859-1?Q?XsUeGLTtwMfko04Z30qF6XBM/F9ivKuBIzeQ5nbJr+5XTlZ31qXKXMBH/L?=
 =?iso-8859-1?Q?t0Cs6nP1vccDa+X2S+nB+U44K1eBJw42U+bN9wJTMaMpF8MJ+RDRtERm8k?=
 =?iso-8859-1?Q?U1+8n5XgC726wJxSdaQMqabHd7O88d0OykOcmB8ppSlgckLLNXkEC+wA89?=
 =?iso-8859-1?Q?FyxAq/TTFvA+iZayg0WCEuF2n0OSc7yGdIrkHaH6BJfTzYsEC8HtRpWXnf?=
 =?iso-8859-1?Q?2lO1Ojf4dooarGAeph1+k/LRom6Ed/ZL/+UBrr9GtpMLEUoGPMzokq0RE7?=
 =?iso-8859-1?Q?zYX4bjmeHmPpm08g55r9uCkOdzsEKNl22XQHCSNn/DJ5lupzxPmdqzKZ5q?=
 =?iso-8859-1?Q?n/mQA+iOWwmrsjMsD0RhyH/Vj9RGWKGnM2ftPJJkmO7uffGKo1qMb1fjJ1?=
 =?iso-8859-1?Q?/A6ByEP8oZEk3w1TGVoyYHH0HoeujWpY1tMoItiKv+zNOSQ/yfYqofD2MD?=
 =?iso-8859-1?Q?VDa2MwhJTldME+BEUUfm9Vzoi9+e8UWc8tT7wZuP2xoz6OnR/3Y+vA/Tb/?=
 =?iso-8859-1?Q?colqhMnHmQlywBJLxpx4uSyHyJBUZkY+w4wWcNi0puMzfrwCPzMr400V9+?=
 =?iso-8859-1?Q?0aStVAo5er8hCOqteE1u/yvLVuRpCTVLh55qydnDUPlmXbCWORXMKrrPtC?=
 =?iso-8859-1?Q?cfqOC/0xs7D5h63ut7w4blyuSrbtFNNIwq6HlTCSLkMu8/0WOs16JLHCoP?=
 =?iso-8859-1?Q?WHa7Y0zs/RtXcYwy3LKLBIciRGUmV+yZ5l/hEg+FdWDKBaRhSwbUDUeo9H?=
 =?iso-8859-1?Q?7WOsXDIoFfYOJszDaezIHS/XqPi3mfZGC/LF/TS3M4d+BrnF/wueyPTM5D?=
 =?iso-8859-1?Q?ToU656dRDnECSf1+2C05pt1Vx3CKiA+iCbLPsnD0U7CWNZfyu3l646qzjs?=
 =?iso-8859-1?Q?IQWDCYee9a6ThRAtt/CvI2uclwujEzk2T08pRCRa0zKl88mE7WLFR11LTm?=
 =?iso-8859-1?Q?sgC8w0MGyJ/U2RYtO6WUMAe0Qgvy67oxvupJqGmmihvSYPD+Ack4DZQuKi?=
 =?iso-8859-1?Q?oQ54o88aNmMV1ORuc9eY2KixEcGwPih/l7/zZ2MjqMSEcW+oA88aKz4AW6?=
 =?iso-8859-1?Q?eitjSlG3P+ILZllUgZllxFk0haJdBmIntzYHzL/nKmKbalzfH84RR+bID6?=
 =?iso-8859-1?Q?HaOtym+KUdB3jlC1J5vE7qwm+YnB6ZQa4RprIB3W56PlnxY7fUcMGMkNVU?=
 =?iso-8859-1?Q?Dez/s+wima?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB18845C4917F6C7BEDD6EAE81E4B69DM5PR12MB1884namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af93f378-754d-4d05-3df3-08d98d8e1eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 14:39:39.1609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbzCNzNqRk6HA5+8PJvoGYkyHOApMzEGc8MGqP9tRKQKIcix18J0phP9YdtaphUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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

--_000_DM5PR12MB18845C4917F6C7BEDD6EAE81E4B69DM5PR12MB1884namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Monday, October 11, 2021 8:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, James <James.Zhu@amd.com=
>; youling257@gmail.com <youling257@gmail.com>; Zhang, Yifan <Yifan1.Zhang@=
amd.com>
Subject: [PATCH 1/2] drm/amdkfd: fix boot failure when iommu is disabled in=
 Picasso.

When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
init will fail. But this failure should not block amdgpu driver init.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index af9bdf16eefd..9dfcef2015c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2432,10 +2432,6 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
         if (!adev->gmc.xgmi.pending_reset)
                 amdgpu_amdkfd_device_init(adev);

-       r =3D amdgpu_amdkfd_resume_iommu(adev);
-       if (r)
-               goto init_failed;
-
         amdgpu_fru_get_product_info(adev);

 init_failed:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 4a416231b24c..bb652ee35c25 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -920,6 +920,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
                 goto device_iommu_error;
         }

+       if(kgd2kfd_resume_iommu(kfd))
+               goto device_iommu_error;
+
         kfd_cwsr_init(kfd);

         svm_migrate_init((struct amdgpu_device *)kfd->kgd);
[JZ] Move the above change to here, the device init sequence will be closer=
 to initial design.
--
2.25.1


--_000_DM5PR12MB18845C4917F6C7BEDD6EAE81E4B69DM5PR12MB1884namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yi=
fan1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, October 11, 2021 8:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Zhu, James &lt;J=
ames.Zhu@amd.com&gt;; youling257@gmail.com &lt;youling257@gmail.com&gt;; Zh=
ang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdkfd: fix boot failure when iommu is disa=
bled in Picasso.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">When IOMMU disabled in sbios and kfd in iommuv2 pa=
th, iommuv2<br>
init will fail. But this failure should not block amdgpu driver init.<br>
<br>
Reported-by: youling &lt;youling257@gmail.com&gt;<br>
Tested-by: youling &lt;youling257@gmail.com&gt;<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp; | 3 +++<br>
&nbsp;2 files changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index af9bdf16eefd..9dfcef2015c8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2432,10 +2432,6 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.pen=
ding_reset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto init_failed;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_inf=
o(adev);<br>
&nbsp;<br>
&nbsp;init_failed:<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index 4a416231b24c..bb652ee35c25 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -920,6 +920,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto device_iommu_error;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(kgd2kfd_resume_iommu(kfd))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto device_iommu_error;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_cwsr_init(kfd);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_init((struct a=
mdgpu_device *)kfd-&gt;kgd);</div>
<div class=3D"PlainText">[JZ] Move the above change to here, the device ini=
t sequence will be closer to initial design.<br>
</div>
<div class=3D"PlainText">-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB18845C4917F6C7BEDD6EAE81E4B69DM5PR12MB1884namp_--
