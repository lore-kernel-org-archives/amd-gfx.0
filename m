Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 03:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE4560F38
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 03:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EE4560F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D87A89F63;
	Tue, 12 Oct 2021 03:55:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4265289F08
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 03:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVgXkrgn5s22DTboSaVMMbhxw/xMAgsMHNL7QmFuvF4RqeEpIfineLMgSPFN6Akno8nVVncddyQQ8Dd8gqmXElpRenDJ7SE5vid6glca6lyqfzCmccSHZ9XRn1oMUUM+luZKN83X1NZW9peSSDF2e5ztKv/w/sYUzbkiGYqZ0amFYwFhfCvgEAhjr/FWxD3YCp8mrHsdOgQdlPOfGcbyFX4V3IvVQWMWUrGjVr9jcyAvY/9UTOAvsS5rZmtNsaYYClxD2bNo1MCMXcRqh9QRYZCz/ZQ5wwCm+n2ZErOG+tEoIcQEtWZAeAV9Idx/FI3Q7MC5ZWnrnPx7OFGOkh+tYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQAm5uvwMKIFYMj47Suo0yKUpbL3oWE06lDLDmBIvdQ=;
 b=kNxRLGgT3imOPxsxseLWVNXbTcU99lK+nGCf3evr63fFlOkYyWyGgfT9zZHPMu6vIf/7odXeRAiHIBvO7p0FSUgdQtmhqLyZeDN+joQJxGVf5Ae/0w06xnZ0/5zroxYVkmOiYP25Oh0CmLgkGBgcV2PThz6ZFYvSWhCoO3qtgc4OTkPJFR2a/q6LPycQBOUvsSueXw8gig9ZtN7MvvIF6HQGKgnfrJVY0OBp/cGt+CVBMMqE1TAsE+skvUPSOPXoytQJ4I9k0hNo/EO8YAMLCzZPO8sEd8huS1hHmHD5a9+CigknZVQqG2nvLPXJSu7xzHueV7+IUR4KlABjH+yYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQAm5uvwMKIFYMj47Suo0yKUpbL3oWE06lDLDmBIvdQ=;
 b=wkMNfaDjuhOljU2uPU1dnERdakOzL8wPYqO8/4F9Cki/F6LJ2o8wwlcY/iGJqJmS+K3tDv1ujjgjLtJCy+3tizxP176jGNBBlxcLLUFvWiS4Fp+NYs3fq5C3i/AD5u3qMuRNsH2KZxrYd2jGS2V6dGSlBKcL4dsfEVxB6k66Q+w=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 03:55:16 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 03:55:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset
 on Aldebaran
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset
 on Aldebaran
Thread-Index: AQHXvxGddjQ8Quy0dESCfzkvEaC16qvOtz4R
Date: Tue, 12 Oct 2021 03:55:16 +0000
Message-ID: <DM6PR12MB465071A7F950599FA16CDA6EB0B69@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211012023343.23935-1-mukul.joshi@amd.com>
 <20211012023343.23935-2-mukul.joshi@amd.com>
In-Reply-To: <20211012023343.23935-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T03:55:15.873Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 7fafe93b-720f-7dae-d96b-7ae0df34a542
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1644815-c3ae-49f1-7753-08d98d341a22
x-ms-traffictypediagnostic: DM5PR12MB1803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18030696B64BB59B925CAE75B0B69@DM5PR12MB1803.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tVvnmrqlAC6JMoZg1pLSxmzHvJjTTSsip59+8qc7Yg+sCDY1qCRUg2ACd1SywOyNW+NbBYdTR4oEaadFcMZpMY2Lzae0K+8gfAtQIR10QVe4Z230N9cE429nbA/k6bBtt2oALfr7qJe6Yacy0yIcdoBrGARSdaa+LhMOWaI3ZQzdy5wq/+SOsurUm9erWOUUGKzb7iI6NrY0jJiu3UFub9G6UuBawkzaRp/y+FfZ31RTbpPosbVMK6a9ItJtySk8VBPz6SmRpL74DMV9TzjOcelVaF1K5jLdE46EAgDQOiveTTWPH/M0pwdsxwLzBoWznJyuJ4ymu31rtLSmaY6S/NvQG4R9zF9Obyr7xDXSWg4wcCx3W/lEG9l1fa6gk3js430/u3DAsuyldRMNHaSh/n2q59kRKUKxTD+77E57oHQ8nw21s7pRu3LxhB6t2ea+YIK6mAHLfdoFRRTB3o/ne5Ne0Uv7o5MMQlc9S4M8T4kwywhH/yT6m+MDsAoaYrtcYmNeL2RYBn2PFpoWPYIkMpQXCOBOINCnm4CYNG7uzkVfDsLOSQYZITH2CDr/8El10WxkhM1/4t9YhTFDCZWpeNMclsIeI/2+TqF+yJ9jsQpGOilZm26etnnMwutVxfRR33jUb5a5QVA19DCTAbjcVaWszugHTkQdYbDJnSRzOLoug+S+hNWKQYRpbqQ2EOeaBtwZ8+8/VqzpIjRywzghLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66556008)(66446008)(2906002)(38070700005)(316002)(4326008)(53546011)(26005)(110136005)(186003)(19627405001)(76116006)(6506007)(91956017)(66476007)(66946007)(9686003)(7696005)(71200400001)(86362001)(8676002)(52536014)(55016002)(5660300002)(508600001)(122000001)(83380400001)(33656002)(8936002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OLOvytBmvk82k3flMIS+Nb6Mb+I8rcpcpKl6WuH/E1JeR+hSaKOlNmvs1n?=
 =?iso-8859-1?Q?KPqnoUtCp09lY6r/8absxXer6yQTf+kNo/aAJ5opWf0Q1QKm0pooQpxGEt?=
 =?iso-8859-1?Q?9scrVU0Y2lzH1LrhXihPfznUawsNWyl6vj73D1ou5Ai+vzdTk5Z4GNzHy5?=
 =?iso-8859-1?Q?ma6vhaEVF/aq3hiJZAlPCt+vSWz6ZIrFN5Eh7ZC6ku67p3RvnyfxSU/qTy?=
 =?iso-8859-1?Q?nL6cVL28rrIPUlKQcrK7p5V+/mNytKGkGGtNYWYqlrMG54BpG07jSgysR0?=
 =?iso-8859-1?Q?edeo8AkyIJ2kMalllBLSNRq1Qs8M9qsFsQhVoFubuZcqZBiTGxbmaKlD8K?=
 =?iso-8859-1?Q?xs/4cFEMTOsRHePPwHnt+VQ8YF4LRzXZNa7d6HVo804X5Ve17wD8atucdY?=
 =?iso-8859-1?Q?SwA3FdFEjiRXPDOLXxF6tbY2B0FM38UMW8NdGnXpbVtrowzLLMgUL6/Wtv?=
 =?iso-8859-1?Q?y2ep/xytGCzUOzOUJu7HLS0XDVvoK/DTQ6nQFNiEOkPzwDFdoWGf5ZwSf2?=
 =?iso-8859-1?Q?Y5QaOx9M2ofiVxsnV2f8Ltg4ijhWybTsWc9b+lVQAk6GufnAd2LsmOIjmV?=
 =?iso-8859-1?Q?KMwbchhl4oucKOt3c5grr09OZxdM54X9v9PQS+lpoT8W07yn2PVL2/8FhM?=
 =?iso-8859-1?Q?Vl698Hr9InX3Up/Evb242ivp5abe41yqQVESUDJz2lCvTDK206WUu5afZD?=
 =?iso-8859-1?Q?c2NFPYg7a7utzOTEbO3FpB9iyX92afCE9i5dGrTCZp+UU9unEp7Yx9TWD9?=
 =?iso-8859-1?Q?9KlI20CMXBTWLA+LlVH9oG+hueNJeSDQohdCjGeKsQvTDQXRlAZoWXcBmn?=
 =?iso-8859-1?Q?yVaomOF+OxxcYkR5u1PTGwewmorFkGwkl1RG3AahGTIQekTjTfxnAWIzUt?=
 =?iso-8859-1?Q?mlDv3dSuAHR6kDzhySHhF3p4fXhMw4jrop8BikfYViRW7lAtKISkGNkTT9?=
 =?iso-8859-1?Q?HUy2GZEnD4ibJ08QjkeVSjLr4TL8c0tO8F8ScJMNukTUegEDdZj3bqK+WO?=
 =?iso-8859-1?Q?hJpW9HyB/xU8mfzRGcYVDx+2IY1PSYTXxxDrQ84cwHxwejiz7Ob9x8SR8p?=
 =?iso-8859-1?Q?XQtw4jnAEIvOaKON4FhWmOT1WlRefu3nt5kr3iBInbzmf3pGtILVCi998A?=
 =?iso-8859-1?Q?SC89zd9Q6QqcFbCt8Np/c0RkrOLxUxb2Z/EQycDlSit9/H6w2077Uh42d9?=
 =?iso-8859-1?Q?EN1lm/Ijv1kSsrEU5E+w647D8Bcn7njXV4/rPIX9X6oBpVEH3Q753fdVt2?=
 =?iso-8859-1?Q?FQKdvHK9Y53TSe750p48CEpEkMPhbqS98GBHXiN60TsKNQtChKFcQlFXqZ?=
 =?iso-8859-1?Q?mx+6T4yr74abrLGrsWlPHPlFwzr3jNNJk3Su9pTeqBT4mDyqf/gKTaUaT/?=
 =?iso-8859-1?Q?UuD1V/lDka?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB465071A7F950599FA16CDA6EB0B69DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1644815-c3ae-49f1-7753-08d98d341a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 03:55:16.4218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ4MmG5XY7E42vCyIKrxQsJDUvVmK3pIzyGDKKgzqYAzfiYCJ6iZJ6V+mpkCHffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
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

--_000_DM6PR12MB465071A7F950599FA16CDA6EB0B69DM6PR12MB4650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

The patch looks good for me, but it's better to add comment in amdgpu_regis=
ter_bad_pages_mca_notifier to explain why we need to reserve GPU info inste=
ad of using mgpu_info list, with this addressed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>

________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Tuesday, October 12, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>;=
 Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset o=
n Aldebaran

During mode2 reset, the GPU is temporarily removed from the
mgpu_info list. As a result, page retirement fails because it
cannot find the GPU in the GPU list.
To fix this, create our own list of GPUs that support MCE notifier
based page retirement and use that list to check if the UMC error
occurred on a GPU that supports MCE notifier based page retirement.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e8875351967e..e8d88c77eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -112,7 +112,12 @@ static bool amdgpu_ras_check_bad_page_unlock(struct am=
dgpu_ras *con,
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
                                 uint64_t addr);
 #ifdef CONFIG_X86_MCE_AMD
-static void amdgpu_register_bad_pages_mca_notifier(void);
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev);
+struct mce_notifier_adev_list {
+       struct amdgpu_device *devs[MAX_GPU_INSTANCE];
+       int num_gpu;
+};
+static struct mce_notifier_adev_list mce_adev_list;
 #endif

 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool rea=
dy)
@@ -2108,7 +2113,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)
 #ifdef CONFIG_X86_MCE_AMD
         if ((adev->asic_type =3D=3D CHIP_ALDEBARAN) &&
             (adev->gmc.xgmi.connected_to_cpu))
-               amdgpu_register_bad_pages_mca_notifier();
+               amdgpu_register_bad_pages_mca_notifier(adev);
 #endif
         return 0;

@@ -2605,24 +2610,18 @@ void amdgpu_release_ras_context(struct amdgpu_devic=
e *adev)
 #ifdef CONFIG_X86_MCE_AMD
 static struct amdgpu_device *find_adev(uint32_t node_id)
 {
-       struct amdgpu_gpu_instance *gpu_instance;
         int i;
         struct amdgpu_device *adev =3D NULL;

-       mutex_lock(&mgpu_info.mutex);
-
-       for (i =3D 0; i < mgpu_info.num_gpu; i++) {
-               gpu_instance =3D &(mgpu_info.gpu_ins[i]);
-               adev =3D gpu_instance->adev;
+       for (i =3D 0; i < mce_adev_list.num_gpu; i++) {
+               adev =3D mce_adev_list.devs[i];

-               if (adev->gmc.xgmi.connected_to_cpu &&
+               if (adev && adev->gmc.xgmi.connected_to_cpu &&
                     adev->gmc.xgmi.physical_node_id =3D=3D node_id)
                         break;
                 adev =3D NULL;
         }

-       mutex_unlock(&mgpu_info.mutex);
-
         return adev;
 }

@@ -2718,8 +2717,9 @@ static struct notifier_block amdgpu_bad_page_nb =3D {
         .priority       =3D MCE_PRIO_UC,
 };

-static void amdgpu_register_bad_pages_mca_notifier(void)
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev)
 {
+       mce_adev_list.devs[mce_adev_list.num_gpu++] =3D adev;
         /*
          * Register the x86 notifier only once
          * with MCE subsystem.
--
2.33.0


--_000_DM6PR12MB465071A7F950599FA16CDA6EB0B69DM6PR12MB4650namp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The patch looks good for me, but it's better to add comment in&nbsp;amdgpu_=
register_bad_pages_mca_notifier to explain why we need to reserve GPU info =
instead of using mgpu_info list, with this addressed, the patch is:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:=
white">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com=
" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable"=
 data-linkindex=3D"0" style=3D"margin:0px;font-family:Calibri, sans-serif;b=
ackground-color:white">tao.zhou1@amd.com</a><span style=3D"margin:0px;font-=
family:Calibri, sans-serif;background-color:white">&gt;</span><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Joshi, Mukul &lt;Muku=
l.Joshi@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 12, 2021 10:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Clements, John &lt;John.Cl=
ements@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 =
reset on Aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">During mode2 reset, the GPU is temporarily removed=
 from the<br>
mgpu_info list. As a result, page retirement fails because it<br>
cannot find the GPU in the GPU list.<br>
To fix this, create our own list of GPUs that support MCE notifier<br>
based page retirement and use that list to check if the UMC error<br>
occurred on a GPU that supports MCE notifier based page retirement.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++------------=
<br>
&nbsp;1 file changed, 12 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index e8875351967e..e8d88c77eb46 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -112,7 +112,12 @@ static bool amdgpu_ras_check_bad_page_unlock(struct am=
dgpu_ras *con,<br>
&nbsp;static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr);<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
-static void amdgpu_register_bad_pages_mca_notifier(void);<br>
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev);<br>
+struct mce_notifier_adev_list {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *devs[MAX_GPU_IN=
STANCE];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_gpu;<br>
+};<br>
+static struct mce_notifier_adev_list mce_adev_list;<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, boo=
l ready)<br>
@@ -2108,7 +2113,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =
=3D=3D CHIP_ALDEBARAN) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;gmc.xgmi.connected_to_cpu))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_register_bad_pages_mca_notifier();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_register_bad_pages_mca_notifier(adev);<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
@@ -2605,24 +2610,18 @@ void amdgpu_release_ras_context(struct amdgpu_devic=
e *adev)<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
&nbsp;static struct amdgpu_device *find_adev(uint32_t node_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gpu_instance *gpu_insta=
nce;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; mgpu_info.num_gp=
u; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_instance =3D &amp;(mgpu_info.gpu_ins[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev =3D gpu_instance-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; mce_adev_list.nu=
m_gpu; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev =3D mce_adev_list.devs[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev &amp;&amp; adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_no=
de_id =3D=3D node_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgpu_info.mutex);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2718,8 +2717,9 @@ static struct notifier_block amdgpu_bad_page_nb =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .priority&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =3D MCE_PRIO_UC,<br>
&nbsp;};<br>
&nbsp;<br>
-static void amdgpu_register_bad_pages_mca_notifier(void)<br>
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mce_adev_list.devs[mce_adev_list.num_=
gpu++] =3D adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Register the x86 n=
otifier only once<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with MCE subsystem=
.<br>
-- <br>
2.33.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB465071A7F950599FA16CDA6EB0B69DM6PR12MB4650namp_--
