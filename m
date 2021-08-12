Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621AAC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81A060E78
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E81A060E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EE96E237;
	Thu, 12 Aug 2021 04:01:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A496E237
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaoEcG1LOSKzK5MNQAitIUF1lilCQzJAm1PhiSjbJIJ7SRNbCmBd45jC1yZTuhxogZG4IXUvSceEfSvE0dSdW8v4A26XcbtzzrVlWSHiLZOOL4suE3Kx61XE20w+H3holzEWVwa7kCx87B+tllA4CBgRUSp9R58LRt5B18C1z848yIlqo4qTdApqgI7tnQpXrGlptlOUxXTkxC4RvP4g9k/GZkqxM1YMObSEfaFBNV+fA2kJxnI51gzrZf+pZXAZWCe9qmwp2QGCqHED25D2UX5R3GPgTvHyB/zoHRv16DGTIaGIlA57qu0YnjL97m2tEMRqcRPpfIaEQ2KZcvMZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b29ady3b/t8/q25Q21G9nO3RSoUFVJL2OUaTSNrMfzA=;
 b=H9/ZlnazD0HhncX1VMio7GPr1pHTlNC71/Dt9fq3BLr2BGcopWpZy85ET6910l4JjT19c3uS2K3LPg/ZaWtMuHVVx0DEguXeodkxv0HwhTNWd2jP/+iZmiqgWVX9eJIvD7Q7NgYsZIdVXgV0WIkyKU0lxtkjIyvmEG4RkVSX0QXSjoB4eRwFug4PwymoO1R2yLwqeNBb7yBIyEmjJkgzqEce7p7nZ/45cJCDdl5uvLwUE8/h/PGWWbqCG7l5SKzG5drFxScCadZ0hDD4hgTf6AszDj3LRrFxxMXJoLRUtavAy/nfew9FC8MmDQRXmRb6HQEBtkpsD9qXFZULYePzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b29ady3b/t8/q25Q21G9nO3RSoUFVJL2OUaTSNrMfzA=;
 b=pa+l97f96FkUvjVSqnQouJU0CCFxFjr+HVNmwushGz4jmQJeSVD4MRgXbMO9IeIwG+DFx40TJFJQ62dE4N/Et9A5U76iP20tXkx7uglHOvMdP93SRjKdKS4z9PCXU46lsioYJ2llqZFb1Wv/HmtCizBiqh9ZgPbbbo//dEaomdk=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 12 Aug
 2021 04:01:22 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb%3]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 04:01:22 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov
 for aldebaran
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov
 for aldebaran
Thread-Index: AQHXjys1bEHz1qX6p0qnzF7zJVVoAqtvPtnQ
Date: Thu, 12 Aug 2021 04:01:22 +0000
Message-ID: <CO6PR12MB5473E0156D60AB4EDC0F1F32A2F99@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210812033627.1241847-1-kevin1.wang@amd.com>
In-Reply-To: <20210812033627.1241847-1-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T04:01:22.592Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 041a3951-2d77-464d-81d9-08d95d45d909
x-ms-traffictypediagnostic: CO6PR12MB5410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5410D601D3431335022C1406A2F99@CO6PR12MB5410.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR/2+NUD/mLDIF9FlOFGcVYW9M+znHKtqjbB6aWZwzEnWzhu3eB3MmW6hI3RqcQc3wnbybMAWFpLLFOJJVR36dNkvTtRkuV5nPH/1qJrr/smzgdTFx5IrF9fjhJ7kU47ZMn+lO+OY642UQE/6nlG9H4g1B7o0/mejmH/74EkGx/YAy8oE7bFGUzRL2Cuq98NJqZ7kUkg/zn3NAjvmIsm1YwbTWKGloog92ytkqUKQQd1j79GbycdgeczqFOTT53Cel5x+61rq3funCBo7tj9VcmT6D6Sqy02Zr6+jXdn/etuA9NGJ17zmT6DcfuP5WtTvlo4h5UhpgnGbutuM6U5kR74sxXJx7cEZDXgJ6kREjdj19JO3imzlyH8QXMuT/qXr11887IV0v77OvFktYGVX0bVaDJ4VyUn49FwZr+4xzSTauzxjxsx503+EfBrIRckf7rXBVgFqqaagB0Qw+wmkA7bQH3BZAhqoWkboDOmh+i6osU0KJJAPgRM6eUvMCc+O7A5xPfIBef8dY2b8RdP5fIOKNSZuPt7jd2vSUrU+V9sq8zZTT035ZRExsPz2nQCn5iuiyZQkGO7N8k8TshQmHV6Uhj7q5UneDyXZIFEbbKjq4mlq/Ko7iNX6RsEfXR6JjZlxYtRFgdVu7iZ5/0q5uYXpm0N10oN9mIdPFkdRfISGEtJqpcrDfliLGKEQy1IhjymOfzgd6TX0DmU6qsYTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(7696005)(76116006)(66946007)(8676002)(66446008)(55016002)(64756008)(8936002)(9686003)(33656002)(38100700002)(91956017)(66476007)(52536014)(83380400001)(66556008)(19627405001)(71200400001)(4326008)(86362001)(316002)(478600001)(26005)(186003)(6506007)(53546011)(5660300002)(6916009)(38070700005)(54906003)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K7ohyz2NB5cHLTFuf0CJsgl27nMpli+NJbNMuZXHs3b3l2TQ4r7KFRAbBb?=
 =?iso-8859-1?Q?KcXqMCRuDLoQREnJf3laeCoTJqnBuDX3ty2mJL9YE8GEDyKTT6SvzMbaJC?=
 =?iso-8859-1?Q?l9qbTxx/O2UybcT/iNIx0D+VpRU5O94Ii6CJhOldoJmFSLxcYElQMLf7/K?=
 =?iso-8859-1?Q?7GA+tBT/oVt8FBc+X7BAX1QCWa3rw196VVX89+qnRbfM3yo1FZsAmy3+eG?=
 =?iso-8859-1?Q?xIpb550MjGV6P85SRCfRO0xgzmz32Mm6F+cRdYYBpruNvzlhXtLs/Q1GLA?=
 =?iso-8859-1?Q?uw86BdIYqYCDrED8/jq8sDrH8S+75javbvdV2NIjh6egfjrRjm4iSKdRFJ?=
 =?iso-8859-1?Q?MG9A/i66UEQpq2EXtS6VRxngnqHaYnQU6+o0pc9bKQtwOIDI+nDGj7FLBw?=
 =?iso-8859-1?Q?m5NSYy8XnVRePzlDwNXE0NsmL3Kzst9anlMz0T8jh9nayojJOJkysnEoGS?=
 =?iso-8859-1?Q?lfcWaA2Gp7WYpzD5BngWV3LuItBSa54AE/61hh4kZywzmKjrmmTjSrQPD3?=
 =?iso-8859-1?Q?y/ZdeibmcpC1MhjfPSZuR8dXWgaXyiMgTAhptmDxakySMgwWGIEfFDo9tY?=
 =?iso-8859-1?Q?HmdVR66x/GZRJDitS4Xi8KXoqa7lswriWQ7H1HYylOmZSlgEN7kf+L00+U?=
 =?iso-8859-1?Q?4jbpnd/zi3f4UlxJLYQRCsWd+UTkQ5hmOkxXoImmv+G25nszYCj7phhjke?=
 =?iso-8859-1?Q?9M59Wll/yUn2IVGOktYJ05if7p3GC30unHDnCUw6pV0iNXxMjTkcNlR1x8?=
 =?iso-8859-1?Q?mlkQsA/cv7K1paS6bhcA0o7GtZUCSRqvkBQVvdc7CCxT71tx5f/j82aLAO?=
 =?iso-8859-1?Q?ZXCKI0SH06Vdcad+mlstGgXfwR9dD51ejVlBnJILKrOhsnKCG8By0/V5vu?=
 =?iso-8859-1?Q?GityeUgDK0Ab7TL0lui3UR2z2m+PNRr0t/mnv1ZBAYpciuruYcOsL4/KnI?=
 =?iso-8859-1?Q?VVmkxpQS3bbt6umWwEHHJp/m4E07FHjF3+7K6azulbS+MwuQtXLOyXAutQ?=
 =?iso-8859-1?Q?P+BhjpnuUVZVFutXLlKHpc8XVUsZSpRz974eF2KEoXwRYKKg8n5UYPkyJU?=
 =?iso-8859-1?Q?JjmfNe4srNPM2nrRVxwp0eIoiYqa3xAyy3OU67RUXDGsw6oWm4YFUq+BBK?=
 =?iso-8859-1?Q?uvQTe7yMi2Z9CGWADnAllkiMFUXT72P+uJqX5lJ5y+0NGvuFYCzQ88Vxva?=
 =?iso-8859-1?Q?vpeFOFAaHPQq4iBHi4BsGB80WlXP2vxZ01ElZCDlFxR6YcefqQ+tJOFIM+?=
 =?iso-8859-1?Q?xXxq4rvq+GRy3YtScjRLKm0OHqTAXBx1jBO5oFsqeY0OxAhc8Y5Ro7nw2v?=
 =?iso-8859-1?Q?i3UtWcIItXwg1ZYOH1DihHddCJf0HmoewnvLsLzBYXVgXddnYH5R1zVv2M?=
 =?iso-8859-1?Q?KKRsWtHwdZ?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473E0156D60AB4EDC0F1F32A2F99CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041a3951-2d77-464d-81d9-08d95d45d909
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 04:01:22.3169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4niypxZc622II3dg/eTSfM1nLWVWH3L4+aIBHimRPlMz+aRdVzP3Xw6/Nea0y87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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

--_000_CO6PR12MB5473E0156D60AB4EDC0F1F32A2F99CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

please ignore this patch, there some errors in here.

Best Regards,
Kevin
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, August 12, 2021 11:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;=
 Min, Frank <Frank.Min@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wa=
ng, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov for=
 aldebaran

v1:
1. skip to load smu firmware in sriov mode for aldebaran chip
2. using vbios pptable if in sriov mode.

v2:
clean up smu driver code in sriov code path

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..ebc081dc01cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
         const struct common_firmware_header *header;
         struct amdgpu_firmware_info *ucode =3D NULL;

+       /* doesn't need to load smu firmware in IOV mode */
+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         switch (adev->asic_type) {
         case CHIP_ALDEBARAN:
                 chip_name =3D "aldebaran";
@@ -273,34 +277,38 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
         struct amdgpu_device *adev =3D smu->adev;
         const struct smc_firmware_header_v1_0 *hdr;
         int ret, index;
-       uint32_t size =3D 0;
+       uint32_t size =3D 0, pp_table_id;
         uint16_t atom_table_size;
         uint8_t frev, crev;
         void *table;
         uint16_t version_major, version_minor;

+       if (!amdgpu_sriov_vf(adev)) {
+               if (amdgpu_smu_pptable_id >=3D 0) {
+                       pp_table_id =3D amdgpu_smu_pptable_id;
+                       dev_info(adev->dev, "override pptable id %d\n", pp_=
table_id);
+               } else {
+                       pp_table_id =3D smu->smu_table.boot_values.pp_table=
_id;
+                       dev_info(adev->dev, "use driver provided pptable %d=
\n", pp_table_id);
+               }

-       if (amdgpu_smu_pptable_id >=3D 0) {
-               smu->smu_table.boot_values.pp_table_id =3D amdgpu_smu_pptab=
le_id;
-               dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_=
pptable_id);
-       }
+               hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.=
fw->data;
+               version_major =3D le16_to_cpu(hdr->header.header_version_ma=
jor);
+               version_minor =3D le16_to_cpu(hdr->header.header_version_mi=
nor);
+               if (version_major !=3D 2) {
+                       dev_err(adev->dev, "Unsupported smu firwmare versio=
n %d.%d\n",
+                                version_major, version_minor);
+                       return -EINVAL;
+               }

-       hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data=
;
-       version_major =3D le16_to_cpu(hdr->header.header_version_major);
-       version_minor =3D le16_to_cpu(hdr->header.header_version_minor);
-       if (version_major =3D=3D 2 && smu->smu_table.boot_values.pp_table_i=
d > 0) {
-               dev_info(adev->dev, "use driver provided pptable %d\n", smu=
->smu_table.boot_values.pp_table_id);
                 switch (version_minor) {
                 case 1:
-                       ret =3D smu_v13_0_set_pptable_v2_1(smu, &table, &si=
ze,
-                                                        smu->smu_table.boo=
t_values.pp_table_id);
+                       ret =3D smu_v13_0_set_pptable_v2_1(smu, &table, &si=
ze, pp_table_id);
                         break;
                 default:
                         ret =3D -EINVAL;
                         break;
                 }
-               if (ret)
-                       return ret;

         } else {
                 dev_info(adev->dev, "use vbios provided pptable\n");
@@ -309,11 +317,12 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)

                 ret =3D amdgpu_atombios_get_data_table(adev, index, &atom_=
table_size, &frev, &crev,
                                                      (uint8_t **)&table);
-               if (ret)
-                       return ret;
                 size =3D atom_table_size;
         }

+       if (ret)
+               return ret;
+
         if (!smu->smu_table.power_play_table)
                 smu->smu_table.power_play_table =3D table;
         if (!smu->smu_table.power_play_table_size)
--
2.25.1


--_000_CO6PR12MB5473E0156D60AB4EDC0F1F32A2F99CO6PR12MB5473namp_
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
please ignore this patch, there some errors in here.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 12, 2021 11:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Feng, Kenneth &lt;Kennet=
h.Feng@amd.com&gt;; Min, Frank &lt;Frank.Min@amd.com&gt;; Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sr=
iov for aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">v1:<br>
1. skip to load smu firmware in sriov mode for aldebaran chip<br>
2. using vbios pptable if in sriov mode.<br>
<br>
v2:<br>
clean up smu driver code in sriov code path<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 41 +++=
++++++++--------<br>
&nbsp;1 file changed, 25 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index a421ba85bd6d..ebc081dc01cd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *ucode =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* doesn't need to load smu firmware =
in IOV mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;aldebaran&quot;;<br>
@@ -273,34 +277,38 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smc_firmware_=
header_v1_0 *hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0, pp_table_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t atom_table_size;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major, ve=
rsion_minor;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table_id =3D =
amdgpu_smu_pptable_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;override pptable id %d\n&quot;, pp_table_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table_id =3D =
smu-&gt;smu_table.boot_values.pp_table_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;use driver provided pptable %d\n&quot;, pp_table_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0) =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D amdgpu_smu_pptable=
_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;override pptable id %d\n&quot;, amd=
gpu_smu_pptable_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hdr =3D (const struct smc_firmware_header_v1_0 *) adev-&gt;pm.fw=
-&gt;data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; version_major =3D le16_to_cpu(hdr-&gt;header.header_version_majo=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; version_minor =3D le16_to_cpu(hdr-&gt;header.header_version_mino=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (version_major !=3D 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Unsupported smu firwmare version %d.%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_major, version_minor);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct smc_firmware_he=
ader_v1_0 *) adev-&gt;pm.fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cpu(hdr-&gt=
;header.header_version_major);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cpu(hdr-&gt=
;header.header_version_minor);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_major =3D=3D 2 &amp;&amp;=
 smu-&gt;smu_table.boot_values.pp_table_id &gt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;use driver provided pptable %d\n&qu=
ot;, smu-&gt;smu_table.boot_values.pp_table_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (version_minor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_=
0_set_pptable_v2_1(smu, &amp;table, &amp;size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_=
0_set_pptable_v2_1(smu, &amp;table, &amp;size, pp_table_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;use vbios provided pptab=
le\n&quot;);<br>
@@ -309,11 +317,12 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_atombios_get_data_table(adev, index, &=
amp;atom_table_size, &amp;frev, &amp;crev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (uint8_t **)&amp;table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D atom_table_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;smu_table.pow=
er_play_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.power_play_table =3D table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;smu_table.pow=
er_play_table_size)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473E0156D60AB4EDC0F1F32A2F99CO6PR12MB5473namp_--
