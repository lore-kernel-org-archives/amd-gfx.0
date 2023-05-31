Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E7DC7EE2E
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4006610E1D0;
	Wed, 31 May 2023 14:09:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2AD10E1D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwHww/TFtfPz84bzcimCibwZ8oF4cJgToEEP61PB+tEtCytICrd2ZzYtwhu4v86OtdklSmRD0T2oMgu/4fVgbhOL7sOlhrUK4l6eJDc3Pj8duG3XqKKU+c9lwjRyr28zch8m1aCuKxDhNfQ2nTIrw9VtqL0fclWU4+xB2XmDNwdQTFLbHfo7L9AfbWLZoFwZk/LOO7EpplvkUsY9XcVTofJCnOFR2qzp8GM2Qj9qI5YR6aAaFCFjZxZ0UKA2lxZRGxa4p4TNJLO8jhp/BVMa2DOazTytAb4z85SEzpc5I4mmeeeQw86puq7n7cKxUaJcAKcZxbkd/D0MJJhhD6zgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMvazOZEiji10YzcousacK8m9xpqbZFbBKsc2tNwtDk=;
 b=PDxJn8q0jYHIghvF9aCvJ6pFDDi5zbe+REWmJVj+0Tr6zr03b/irfvSLfki1F2y4aJGSz1aV1tNuJJCuFukmt6Ggy1v2HzTbhr8AjvYk3hBX6S5NUWrPrRUZYArjH8fG5XsaxyTmGtQGaTymCbCfthCiiRFjFjyajSpqSBVDpiGpTESYSZNUCKojph20v4pgTUhl1hJe7LhGCyQ6cfdXRD6upn5wy39SbGxdCVqkztGkrxOO6dwY/jukgF96Dy1zSp3zk9KP1Mi1IO4GB8JWGHrRwBvrBd+Yt2gQyiHdDsii4vFMSGQmnciBJ9KowJn97/Ds/2095lFRDQlIyH8TGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMvazOZEiji10YzcousacK8m9xpqbZFbBKsc2tNwtDk=;
 b=4Hj5fu+V76qVhu4Da6T04Y1WvQWLp/GYvBX349X4BJxf+tRaJIygJIAJ2YtVa+yw1Ie4VUkELOlaQvFBEwm3TQJKsbVrg1yj0ikeabvp6uaYQuUMoHTfwprARIhr473ujZsj0AR0eCtakhvoxtG9vnKATQVGVFVgjDtiGgDcF2A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:09:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:09:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amd: SVM flag error added at svm_range flags
Thread-Topic: [PATCH] drm/amd: SVM flag error added at svm_range flags
Thread-Index: AQHZkmmT0lK/SXbFLk6e+BRSXPQW4690be/l
Date: Wed, 31 May 2023 14:09:02 +0000
Message-ID: <BL1PR12MB5144D0EDD13421B5AC70F327F7489@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230529200946.11492-1-alex.sierra@amd.com>
In-Reply-To: <20230529200946.11492-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-31T14:09:01.902Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY5PR12MB6453:EE_
x-ms-office365-filtering-correlation-id: 8759e21d-dbe7-4a0e-61d1-08db61e0963a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCTi8RUXm6nD+lLg7MnyOdWF8xpTyaH7/n9Io7MuxSftJfi/8dawuy00gLfHRztCzrju2eanxO0M+S7l94EX+TmCShLZv5FgaYnTF5RDQXn4IamiPqvLB0ZWvWUvkR/hSJaJAA4K4Fo21G4JUyhCaV9XWxkphj1Bd8uXsyEZ8YuaSt+L57HA2vnfQcVAUuZzj7HyFxPizSG53KZ15GyGMGTwTzcCURRVJhlDjxLm80h3NqA76GLv4GfTCmScTWgBK0+MobBiMYF5TL7ialsMKvvfVGnwtUR4vlVzLWiYhV+P4BijswZZZJw7BUItG3LVxGBBs2gmwLcNTleb0+8MCwCq/g0qBcfCX0yxjwLJ7JVVRPJlO3IOMLeuMqjEtGEDWjb7IU58/1hHHRcBippQfN80njAxqY8CKkZstKvX2tMbLqO7tzS0ysh48CtTEkNAffUPQSxAVWR2DiziGAlgmhjXF1787l3YCgLfaLH1tnzG4T8COHB3hEwVeY8ZS4oPK0+Y+0PNjAHf2uwtf3ofZvJu3lnqil0HBEJvWt0KM5Idr5vE8zcftaz84UfYCIEkQZNsxmJ1hdTxHT7BiBHJJYYTYzFjzJA/i6FJyq8MA3B8c91x5/1ao96RT+UydxgO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(33656002)(86362001)(38070700005)(6636002)(110136005)(4326008)(316002)(66476007)(66556008)(76116006)(66446008)(64756008)(478600001)(66946007)(71200400001)(55016003)(7696005)(52536014)(8936002)(8676002)(41300700001)(2906002)(122000001)(5660300002)(38100700002)(186003)(53546011)(6506007)(83380400001)(9686003)(26005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HAcsW4E1nD5NcQBSRNr7iHT3eiWJx+zkZJZhYE182JubW20YgBjkV2bXxGh5?=
 =?us-ascii?Q?IglBGgRThLPcY0u+QVWm8w69R0cXQYJqrWZtVoNNOD/TEg+uSgGAuz6zd3NZ?=
 =?us-ascii?Q?VLZOf7IS6CxqY9KDpxhSTCsNpWbYv9b/DJNBv/lnBlvFPBhOkzo5R/ujprCM?=
 =?us-ascii?Q?r5zojeTfknvzslPgFviRmaDftMiwlS/5QSbvkbRQUdUbgTICsTCI/KsqkDKI?=
 =?us-ascii?Q?calW9Pk6iBjDHF1xPXywR7DcazngG3pVYP/B+lrSHKSUd3Qzte6B0UDPtG6d?=
 =?us-ascii?Q?9UduE+gjh/wtvTttIBRK5du6RZdzzpZvj/bkTdn7UBiJq8NkQQavVXGYUrxg?=
 =?us-ascii?Q?XtBmmTi5jTuMA7y6AADZYqaYkZRQi98VwEctLz/OJnmJWutmDyx++Ax/kiEV?=
 =?us-ascii?Q?3Wje0tnCzItSZkb3ONmB5QbdYmm0NWVtpKHrFCMQQZw0EPTL/99w7NDJOtTt?=
 =?us-ascii?Q?/b2KypnHAb+1Q/rh+4Ea5vIXJEnxFhCOM/FDSFpp8S2ORM125i5a0KaVpb6J?=
 =?us-ascii?Q?kk/hG2+yI81uXRe2gss406xA4CA8T8e/+h4iupid8C58Kw8O47aoxAyPCUup?=
 =?us-ascii?Q?YwcYO2xAXwtbUc9h+fAG5tJSum93jh9nNvt/wZrZU2LAohfCiehrrhOqScu6?=
 =?us-ascii?Q?ZqJhUfgQC9NJ2H6LAQLLbQXf3to95HwWrIV+F5ZJj5NRW3E3gway4KkIwI0b?=
 =?us-ascii?Q?v/hOqqopZAe/U9L+ozOBo6gwdt8J7pYHDlxMraq0Q4uwy0B2ityUoxKSCpAh?=
 =?us-ascii?Q?RZGQqFrHcEL78SFGOWm2uK7zm39ppOkBfb+STKv+Ut8bkHS11gozQF0PVtRB?=
 =?us-ascii?Q?ZSeY9I2R9NuckL+Y2O0iAn+01T/l8In8u6fzEDouOYbdvh2rfkjvRm9CbZjw?=
 =?us-ascii?Q?snEqQQhZpsU1PjgBMJlmWp9G3z5U9cqQCtRZEcWu9p7pqoiBhqy06tZAfwED?=
 =?us-ascii?Q?+kDEuQVqcZ/MkS19O68zozOBavXIF1sq0/njxKY/RVixcgiV/FWhF0k4LtCn?=
 =?us-ascii?Q?EqJAe/aGUEpHXZJ8+GedbfUK3NaXe2UvVv3W1+Y19s7HwPHkNaJ2ERTMV4t3?=
 =?us-ascii?Q?nFuiFcAfy4x4FRoqzmpo1Xl4mbAtZ1MXOmJJoc5djf5aAXniOrwRdejN4QYV?=
 =?us-ascii?Q?1APXhin1AuC+fmc3H9/ECtLtAzfS7yQg8QA0ZWduwU5/LuIo/Xygn0HVGdFJ?=
 =?us-ascii?Q?pBMLD2ExmOul1BUXiJJsMEa/CvOPX6EsZ3n7LG3GlNAiOLlkOd8xNjkHbGkd?=
 =?us-ascii?Q?BKTqB6OPwzwbH8bZwJKcCSJ7rVEGJhDWeJe0Vzb0OpEEnj1dNt0FxWyWC+hA?=
 =?us-ascii?Q?zlcY2T+xlpHZH+zirXRyxWtgPKN5X71tsI710BA5j14yNxSVzr3DpLDaYDIU?=
 =?us-ascii?Q?TvnAllrfIwyKUf2oUepAxO7arDqhSENE7IzwGlN4vUCpA+lvvZ66vnunHUSj?=
 =?us-ascii?Q?xBOLt3zj5utjOm7wKVbF9jHGk5ZpsH9RPOBbmYrRYGtrXNItCU8vMpUG0j/y?=
 =?us-ascii?Q?xc9VKWv40EOq/H2pKTZPfGRYssA9tWknWO6s9V4SEWAzFtVEw48J7ft/5jV2?=
 =?us-ascii?Q?32zVXcoQU8AKOyqXhkY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D0EDD13421B5AC70F327F7489BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8759e21d-dbe7-4a0e-61d1-08db61e0963a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 14:09:02.3767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO0MYofXqSEURKlb3K3IgA6MwDR9Q52Fc8dMlMuGz6wV7ut33vHOWnFU4P7EO4X+v1XXfrQX20EeqmV5/wIWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144D0EDD13421B5AC70F327F7489BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Where is the userspace code which uses this new interface?  Can you add a l=
ink to the relevant branch to the commit message?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Sie=
rra <alex.sierra@amd.com>
Sent: Monday, May 29, 2023 4:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Kuehling=
, Felix <Felix.Kuehling@amd.com>
Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Yang, Philip <Phi=
lip.Yang@amd.com>
Subject: [PATCH] drm/amd: SVM flag error added at svm_range flags

If a return error is raised during validation and mapping of a
prange, this flag is set. It is a rare occurrence, but it could happen
when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,
the caller should retry. However, it is important to ensure that the
prange is updated correctly during the retry.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
 include/uapi/linux/kfd_ioctl.h       |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index fcfde9140bce..96abae515bcf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -756,10 +756,12 @@ svm_range_apply_attrs(struct kfd_process *p, struct s=
vm_range *prange,
                         break;
                 case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
                         *update_mapping =3D true;
+                       attrs[i].value &=3D ~KFD_IOCTL_SVM_FLAG_ERROR;
                         prange->flags |=3D attrs[i].value;
                         break;
                 case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
                         *update_mapping =3D true;
+                       attrs[i].value &=3D ~KFD_IOCTL_SVM_FLAG_ERROR;
                         prange->flags &=3D ~attrs[i].value;
                         break;
                 case KFD_IOCTL_SVM_ATTR_GRANULARITY:
@@ -778,6 +780,9 @@ svm_range_is_same_attrs(struct kfd_process *p, struct s=
vm_range *prange,
         uint32_t i;
         int gpuidx;

+       if (prange->flags & KFD_IOCTL_SVM_FLAG_ERROR)
+               return false;
+
         for (i =3D 0; i < nattr; i++) {
                 switch (attrs[i].type) {
                 case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
@@ -1657,8 +1662,11 @@ static int svm_range_validate_and_map(struct mm_stru=
ct *mm,
 unreserve_out:
         svm_range_unreserve_bos(&ctx);

-       if (!r)
+       prange->flags |=3D KFD_IOCTL_SVM_FLAG_ERROR;
+       if (!r) {
+               prange->flags &=3D ~KFD_IOCTL_SVM_FLAG_ERROR;
                 prange->validate_timestamp =3D ktime_get_boottime();
+       }

         return r;
 }
@@ -3674,9 +3682,11 @@ svm_range_get_attr(struct kfd_process *p, struct mm_=
struct *mm,
                         break;
                 case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
                         attrs[i].value =3D flags_and;
+                       attrs[i].value &=3D ~KFD_IOCTL_SVM_FLAG_ERROR;
                         break;
                 case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
                         attrs[i].value =3D ~flags_or;
+                       attrs[i].value &=3D ~KFD_IOCTL_SVM_FLAG_ERROR;
                         break;
                 case KFD_IOCTL_SVM_ATTR_GRANULARITY:
                         attrs[i].value =3D (uint32_t)granularity;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 7e19a2d1e907..2b6f68bd06da 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1125,6 +1125,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Set during svm validation and map error */
+#define KFD_IOCTL_SVM_FLAG_ERROR       0x80000000

 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
--
2.32.0


--_000_BL1PR12MB5144D0EDD13421B5AC70F327F7489BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Where is the userspace code which uses this new interface?&nbsp; Can you ad=
d a link to the relevant branch to the commit message?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Sierra &lt;alex.sierra@a=
md.com&gt;<br>
<b>Sent:</b> Monday, May 29, 2023 4:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Cc:</b> Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;; Yang=
, Philip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: SVM flag error added at svm_range flags</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If a return error is raised during validation and =
mapping of a<br>
prange, this flag is set. It is a rare occurrence, but it could happen<br>
when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,<br>
the caller should retry. However, it is important to ensure that the<br>
prange is updated correctly during the retry.<br>
<br>
Signed-off-by: Alex Sierra &lt;alex.sierra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 2 ++<br>
&nbsp;2 files changed, 13 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index fcfde9140bce..96abae515bcf 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -756,10 +756,12 @@ svm_range_apply_attrs(struct kfd_process *p, struct s=
vm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_SET_FLAGS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *upda=
te_mapping =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value &=
amp;=3D ~KFD_IOCTL_SVM_FLAG_ERROR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prang=
e-&gt;flags |=3D attrs[i].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *upda=
te_mapping =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value &=
amp;=3D ~KFD_IOCTL_SVM_FLAG_ERROR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prang=
e-&gt;flags &amp;=3D ~attrs[i].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_GRANULARITY:<br>
@@ -778,6 +780,9 @@ svm_range_is_same_attrs(struct kfd_process *p, struct s=
vm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int gpuidx;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;flags &amp; KFD_IOCTL_=
SVM_FLAG_ERROR)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; nattr=
; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (attrs[i].type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:<br>
@@ -1657,8 +1662,11 @@ static int svm_range_validate_and_map(struct mm_stru=
ct *mm,<br>
&nbsp;unreserve_out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(&a=
mp;ctx);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;flags |=3D KFD_IOCTL_SVM_F=
LAG_ERROR;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; prange-&gt;flags &amp;=3D ~KFD_IOCTL_SVM_FLAG_ERROR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =3D ktime_get_boottime(=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
@@ -3674,9 +3682,11 @@ svm_range_get_attr(struct kfd_process *p, struct mm_=
struct *mm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_SET_FLAGS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs=
[i].value =3D flags_and;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value &=
amp;=3D ~KFD_IOCTL_SVM_FLAG_ERROR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs=
[i].value =3D ~flags_or;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value &=
amp;=3D ~KFD_IOCTL_SVM_FLAG_ERROR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_GRANULARITY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs=
[i].value =3D (uint32_t)granularity;<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index 7e19a2d1e907..2b6f68bd06da 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -1125,6 +1125,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {<=
br>
&nbsp;#define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY&nbsp;&nbsp;&nbsp;&nbsp; 0x=
00000020<br>
&nbsp;/* Keep GPU memory mapping always valid as if XNACK is disable */<br>
&nbsp;#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED&nbsp;&nbsp; 0x00000040<b=
r>
+/* Set during svm validation and map error */<br>
+#define KFD_IOCTL_SVM_FLAG_ERROR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x800=
00000<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * kfd_ioctl_svm_op - SVM ioctl operations<br>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D0EDD13421B5AC70F327F7489BL1PR12MB5144namp_--
