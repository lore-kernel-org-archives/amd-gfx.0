Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBAC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C7461354
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C7461354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749636ED06;
	Thu, 13 May 2021 14:35:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232636ED06
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 14:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVQ3j0y+8MpgmfcjID/G2TLdQk43udf+JVN2fiUlhWXw62ZZKsImomypuyUpugk1PFaG1TyY+RyCagAMGPA11DW36jeOYfoMywgP7JlkQwVpPxtXRcJnpOFKnRCZRtIKYBpiTLCHiJH0XxZlRGY9bt+QXyu0uWl4Q70Cu6vaClAQ6BOk2qmRTXplEKnDVvtu0hnL9XeUvKIYSBEaWGE5cQOynhQTr3kQe2RZdIgqkptqVMSE89fC05NczHb1Ee23jvJBHZma17MKWSWCxKXIccRM5XrSdGss1ymlC2fxe6UBuWhgBQJ9xsB76QGR77UuFgFdyngyj3AJBuk3YLSiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3kg0RDFTT/cjbFbHLgs4mbjl43aSpSoqS/sDMWQJkw=;
 b=eim0XU4uA4ImWQQ57uhQbhBAgl1P6/8FOFTm4+cH52YqHEdTHTMqI3bjdMuilsx5+WkAoKmXm1R8XnwkGOSJzUc6boIgSAGiLvjVdUlI4C09UmYeKTf3Q8sDuAm+ghcc76JqS1aOj7skhwE1pLbMNKiMfcrXGGLceel4uPOvVhxrsqbeaHBCj1sRqDSWZUUq9v0SPxwDTBxOuMmbRht0yhpESvAjyv8IsnZlPE18y40xex+D/iVHGlWLu2CpyMsdUdQHfcXDmCcHrQ3I0VkoPO1G3lHt3COVn1Xuea+iXI2iF+65pf6uc9VYjMgi7h//Ju3RnyExonGD06ymz4CtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3kg0RDFTT/cjbFbHLgs4mbjl43aSpSoqS/sDMWQJkw=;
 b=qGuPTYxb9ZN/ROVJmQsM0LlLdKV4xhzDrbsoRYGueuDmXiDZ25BKqFJK/Lb3K7EiY/7LC0MDCXsA05rfbMPIwrWm5lPVJoGHx3rJD3hYn66N61hhykzkYz/3nQwt0OxIYptOaFQ8EewpCh1+Nj8euGcPuONH4PsQlg5lOUFf/iQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 14:35:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 14:35:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Bokun" <Bokun.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface
Thread-Topic: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface
Thread-Index: AQHXR7iZrKFgEavr6U+hh3cJyy5aRKrhTPmAgAAuABE=
Date: Thu, 13 May 2021 14:35:36 +0000
Message-ID: <MN2PR12MB44889224FCEC0DA2C8C8D733F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210513051949.6846-1-bokun.zhang@amd.com>,
 <DM5PR12MB170882F26F15E2B7E67ED10884519@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB170882F26F15E2B7E67ED10884519@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T14:35:36.472Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5cd6c9b-c4b7-420e-3524-08d9161c5fb8
x-ms-traffictypediagnostic: BL0PR12MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB48521B99B16CFFDE070547F5F7519@BL0PR12MB4852.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkHYlYLYgbY8iTnGtSUn+9muElrM4egAARhn1VCacH97Ew7gUeJ2XT/1Eas4Lgafpq3uwcmP4XEaTUzjMfPU/rDbM77B35u/rG6Unz5DhNsdhEJOaAsy0ANiR53/9caXe6oh7iTQVTXZNEBXlhFYQ2bsI3md8fa31YPJJ8iLjfhn+Lkz1XhH4xHBss0lMWFJjCoeMhOaca3jy9ERoyrXLOUza75EVqemA8D8k7aM3+ZY6H8yvs9f6GJPchOZ7pWGmrCGdF2BzePwakJH01BIMl90dhpEV6zcR4Xf2kuppm38JnCs0wDpMXMcs6w4L4gI6v4JpBLlY+JNy9seyt0fXNW1yIppugX2X3Xm2Gm2hzddFwpKzrxRWVoOqfUbWbj46IwrfLIP6fS1qd6kQKh4kuvozzXobJHHHwmajCPcys4r6D2Mek+9p+Kx3eRkfQbgqPfiZVkIeakIpOd6WQO1gtlTeAFMO5K3NCTLsA/q9L2TurbBOlxUVTOWgPasV1vMLII9qvl4izTeCWvG/4aqdl/LmB+pNC0i27GuUy3pJoW8R8VwK0zMiedz0hPmS0DZlzcSVeYDqt81i3x9/LkWUsBbI4N71cNYQWi0hbwevNGIld/gFqvBJ7Tha7OPFH0koTc4FUjAZPDmKEEFg1insA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(966005)(26005)(5660300002)(76116006)(33656002)(53546011)(66946007)(122000001)(2906002)(110136005)(186003)(7696005)(316002)(52536014)(66446008)(83380400001)(45080400002)(71200400001)(9686003)(478600001)(66476007)(8676002)(6506007)(55016002)(64756008)(30864003)(38100700002)(166002)(86362001)(8936002)(66556008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iZn68dtPGwXj8vPvyE9coQH0YKft/GOMSXvBrW1kpJYNv+JV9Gbqdw9JwZ/+?=
 =?us-ascii?Q?+cfpuJsCFfWK812wJAaAqeVVF0m3kn6xlSO2wy51o8L74prQpUKFXtSCIUwI?=
 =?us-ascii?Q?sd7SmaZBiXu2RBHonrTrV5ZESAIH+FqaKJLAnWljc+JFkwTeRVGngZ9f7IQo?=
 =?us-ascii?Q?p34Vlau8E3La9lPXCaDjTSkWEic0R5oyiWUXzFfgngTdv08Vua33ZsQS1Mvd?=
 =?us-ascii?Q?zwmG8tqQv8XtqzDJGm71nkcW8LaHtPXdyxY2ugUq4I3qN9BRxVWhtLNF9go0?=
 =?us-ascii?Q?c/Lk2Th1QC81SOmD2zXSrYmk+r9vAcPGFDgJT5dCKe+vDYQN7U1QB+XDpxMc?=
 =?us-ascii?Q?XnAi4lKPwAPCLjHH3neK7rcVAuMiIT6UTsUcC8CXpZNb1EMQJYnXpZ5tmmMq?=
 =?us-ascii?Q?RMfUYJnWORZ1rrjrrXQa3Lg6rwjNxZ95lhUnbY5OgxaYBDiB2gZn7IM10wsl?=
 =?us-ascii?Q?IgmiHOXvfw/SAx8OX/WxbtPA1PWR2ULshkrD/d+NytzWoiJey6Fyz9UvxmX3?=
 =?us-ascii?Q?Z6cFYuSgf04Bz7UsxyV9Jyfw5KBWdAh7jMd8A32a8adcAoDqdef20SAagPIj?=
 =?us-ascii?Q?lPifEJjRGQixym3CQP41Q4nKWnp1is4knXCMGqDY5GvqP2WEnLNuvnFbZRdq?=
 =?us-ascii?Q?C5rBasvhnF3pta0gAaAQUbsyXSZ0Z2sA+SV9v17JAozJcYX5hymNhJM3noyd?=
 =?us-ascii?Q?VwdA/yo06l7f/NlUrvjlokD+9NjmvVeddaYZp+H3Ye21O9PM8gSW3dX8HoSV?=
 =?us-ascii?Q?jXEcwa6s5JCa2eZ/SIzOSd8xWDqXdoNTUHtU63KuPgiqVt3z/IqdwFLUGJ+L?=
 =?us-ascii?Q?uRs5bNW8c2d6Ql0JI1V+8uP8AznqKGUS9TbsA1QzyyUOKnH82HgwPEuoWjyZ?=
 =?us-ascii?Q?eh/8ZmvKhYzqgnnJtq0iApuW6VyBzBv46KMbmkrRj6cajRFV9QqoZuwGr8To?=
 =?us-ascii?Q?2DYPypEkOdMljoZApwBO+7e0nM22eaKsAt7wvjQUEEJFxF9hPD2Q1CuZK8Fd?=
 =?us-ascii?Q?BC80IG6jzRYj1IDpf8IfIMYuZZ17oniWijqtEGgUaM8amObDNFvlsO7aXd4g?=
 =?us-ascii?Q?OVQXVbfW1JgHLmo09hTocN088W6tAHSxV92k9CXPFtbxxmc/TW/l7VAd42AM?=
 =?us-ascii?Q?igaFYNK1ooHIAlyyE9gygog2dkp07Uzduxp7wDVQaZdcFpbm90y8X0KKosGl?=
 =?us-ascii?Q?H1MGpTuQL3rs+kZfbvJmWyr8OZpdjWQ85FYwYlkFB8CeLS55xmYmrMzeF77o?=
 =?us-ascii?Q?xwSzUY1k1AkSj6DMqOAl2JCuXIZmXwOece/4j/dSOWfJOoCv0/A6gs8zrP8N?=
 =?us-ascii?Q?C+/0x5N1f/4fRk22eMGrj63L?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cd6c9b-c4b7-420e-3524-08d9161c5fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 14:35:36.9712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lL0UG1mPJ3T30r6fs9F6kmG5kvrIeeTKSl3Xf3gAWfC24yRuFH8/EkPczF5L1DNkPsIwVQhcDoLIORu3DHmnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
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
Content-Type: multipart/mixed; boundary="===============1020848231=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1020848231==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889224FCEC0DA2C8C8D733F7519MN2PR12MB4488namp_"

--_000_MN2PR12MB44889224FCEC0DA2C8C8D733F7519MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Mon=
k <Monk.Liu@amd.com>
Sent: Thursday, May 13, 2021 7:50 AM
To: Zhang, Bokun <Bokun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk liu <monk.liu@amd.com>

Better get  open source team's RB as well

Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zh=
ang
Sent: Thursday, May 13, 2021 1:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface

- Update SRIOV PF2VF header with latest revision

- Extend existing function in amdgpu_virt.c to read MM bandwidth config
  from PF2VF message

- Add SRIOV Sienna Cichlid codec array and update the bandwidth with
  PF2VF message

Change-Id: Id0cfa2e1adb7a097997d53b34d41a6d36a390c00
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  56 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  54 ++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c             | 110 +++++++++++++++++++-
 4 files changed, 226 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index a57842689d42..c64e583347c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -432,6 +432,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
         uint32_t checksum;
         uint32_t checkval;

+       uint32_t i;
+       uint32_t tmp;
+
         if (adev->virt.fw_reserve.p_pf2vf =3D=3D NULL)
                 return -EINVAL;

@@ -472,6 +475,27 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_d=
evice *adev)
                 adev->virt.reg_access =3D
                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->r=
eg_access_flags.all;

+               adev->virt.decode_max_dimension_pixels =3D 0;
+               adev->virt.decode_max_frame_pixels =3D 0;
+               adev->virt.encode_max_dimension_pixels =3D 0;
+               adev->virt.encode_max_frame_pixels =3D 0;
+               adev->virt.is_mm_bw_enabled =3D false;
+               for (i =3D 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
+                       tmp =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->mm_bw_management[i].decode_max_dimension_pixels;
+                       adev->virt.decode_max_dimension_pixels =3D max(tmp,
+adev->virt.decode_max_dimension_pixels);
+
+                       tmp =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->mm_bw_management[i].decode_max_frame_pixels;
+                       adev->virt.decode_max_frame_pixels =3D max(tmp,
+adev->virt.decode_max_frame_pixels);
+
+                       tmp =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->mm_bw_management[i].encode_max_dimension_pixels;
+                       adev->virt.encode_max_dimension_pixels =3D max(tmp,
+adev->virt.encode_max_dimension_pixels);
+
+                       tmp =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->mm_bw_management[i].encode_max_frame_pixels;
+                       adev->virt.encode_max_frame_pixels =3D max(tmp, ade=
v->virt.encode_max_frame_pixels);
+               }
+               if((adev->virt.decode_max_dimension_pixels > 0) || (adev->v=
irt.encode_max_dimension_pixels > 0))
+                       adev->virt.is_mm_bw_enabled =3D true;
+
                 break;
         default:
                 DRM_ERROR("invalid pf2vf version\n"); @@ -744,3 +768,35 @@=
 enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_devi=
ce *ad

         return mode;
 }
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+                       struct amdgpu_video_codec_info *encode, uint32_t en=
code_array_size,
+                       struct amdgpu_video_codec_info *decode, uint32_t de=
code_array_size)
+{
+       uint32_t i;
+
+       if (!adev->virt.is_mm_bw_enabled)
+               return;
+
+       if (encode) {
+               for (i =3D 0; i < encode_array_size; i++) {
+                       encode[i].max_width =3D adev->virt.encode_max_dimen=
sion_pixels;
+                       encode[i].max_pixels_per_frame =3D adev->virt.encod=
e_max_frame_pixels;
+                       if (encode[i].max_width > 0)
+                               encode[i].max_height =3D encode[i].max_pixe=
ls_per_frame / encode[i].max_width;
+                       else
+                               encode[i].max_height =3D 0;
+               }
+       }
+
+       if (decode) {
+               for (i =3D 0; i < decode_array_size; i++) {
+                       decode[i].max_width =3D adev->virt.decode_max_dimen=
sion_pixels;
+                       decode[i].max_pixels_per_frame =3D adev->virt.decod=
e_max_frame_pixels;
+                       if (decode[i].max_width > 0)
+                               decode[i].max_height =3D decode[i].max_pixe=
ls_per_frame / decode[i].max_width;
+                       else
+                               decode[i].max_height =3D 0;
+               }
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 383d4bdc3fb5..8d4c20bb71c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -233,8 +233,17 @@ struct amdgpu_virt {
         /* vf2pf message */
         struct delayed_work vf2pf_work;
         uint32_t vf2pf_update_interval_ms;
+
+       /* multimedia bandwidth config */
+       bool     is_mm_bw_enabled;
+       uint32_t decode_max_dimension_pixels;
+       uint32_t decode_max_frame_pixels;
+       uint32_t encode_max_dimension_pixels;
+       uint32_t encode_max_frame_pixels;
 };

+struct amdgpu_video_codec_info;
+
 #define amdgpu_sriov_enabled(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)

@@ -307,4 +316,8 @@ int amdgpu_virt_enable_access_debugfs(struct amdgpu_dev=
ice *adev);  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *=
adev);

 enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_devi=
ce *adev);
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+                       struct amdgpu_video_codec_info *encode, uint32_t en=
code_array_size,
+                       struct amdgpu_video_codec_info *decode, uint32_t de=
code_array_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index befd0b4b7bea..a434c71fde8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -56,6 +56,8 @@

 #define AMD_SRIOV_MSG_RESERVE_UCODE             24

+#define AMD_SRIOV_MSG_RESERVE_VCN_INST 4
+
 enum amd_sriov_ucode_engine_id {
         AMD_SRIOV_UCODE_ID_VCE =3D 0,
         AMD_SRIOV_UCODE_ID_UVD,
@@ -98,10 +100,10 @@ union amd_sriov_msg_feature_flags {

 union amd_sriov_reg_access_flags {
         struct {
-               uint32_t vf_reg_psp_access_ih    : 1;
-               uint32_t vf_reg_rlc_access_mmhub : 1;
-               uint32_t vf_reg_rlc_access_gc    : 1;
-               uint32_t reserved            : 29;
+               uint32_t vf_reg_access_ih         : 1;
+               uint32_t vf_reg_access_mmhub : 1;
+               uint32_t vf_reg_access_gc         : 1;
+               uint32_t reserved                : 29;
         } flags;
         uint32_t all;
 };
@@ -114,6 +116,37 @@ union amd_sriov_msg_os_info {
         uint32_t      all;
 };

+struct amd_sriov_msg_uuid_info {
+       union {
+               struct {
+                       uint32_t did    : 16;
+                       uint32_t fcn    : 8;
+                       uint32_t asic_7 : 8;
+               };
+               uint32_t time_low;
+       };
+
+       struct {
+               uint32_t time_mid  : 16;
+               uint32_t time_high : 12;
+               uint32_t version   : 4;
+       };
+
+       struct {
+               struct {
+                       uint8_t clk_seq_hi : 6;
+                       uint8_t variant    : 2;
+               };
+               union {
+                       uint8_t clk_seq_low;
+                       uint8_t asic_6;
+               };
+               uint16_t asic_4;
+       };
+
+       uint32_t asic_0;
+};
+
 struct amd_sriov_msg_pf2vf_info_header {
         /* the total structure size in byte */
         uint32_t size;
@@ -160,10 +193,19 @@ struct amd_sriov_msg_pf2vf_info {
         /* identification in ROCm SMI */
         uint64_t uuid;
         uint32_t fcn_idx;
-       /* flags which indicate the register access method VF should use */
+       /* flags to indicate which register access method VF should use */
         union amd_sriov_reg_access_flags reg_access_flags;
+       /* MM BW management */
+       struct {
+               uint32_t decode_max_dimension_pixels;
+               uint32_t decode_max_frame_pixels;
+               uint32_t encode_max_dimension_pixels;
+               uint32_t encode_max_frame_pixels;
+       } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
+       /* UUID info */
+       struct amd_sriov_msg_uuid_info uuid_info;
         /* reserved */
-       uint32_t reserved[256-27];
+       uint32_t reserved[256 - 47];
 };

 struct amd_sriov_msg_vf2pf_info_header { diff --git a/drivers/gpu/drm/amd/=
amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 75d1f9b939b2..9f7406020=
7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -218,11 +218,114 @@ static const struct amdgpu_video_codecs sc_video_cod=
ecs_decode =3D
         .codec_array =3D sc_video_codecs_decode_array,  };

+/* SRIOV Sienna Cichlid, not const since data is controlled by host */
+static struct amdgpu_video_codec_info
+sriov_sc_video_codecs_encode_array[] =3D {
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+               .max_width =3D 4096,
+               .max_height =3D 2304,
+               .max_pixels_per_frame =3D 4096 * 2304,
+               .max_level =3D 0,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+               .max_width =3D 4096,
+               .max_height =3D 2304,
+               .max_pixels_per_frame =3D 4096 * 2304,
+               .max_level =3D 0,
+       },
+};
+
+static struct amdgpu_video_codec_info
+sriov_sc_video_codecs_decode_array[] =3D {
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
+               .max_width =3D 4096,
+               .max_height =3D 4096,
+               .max_pixels_per_frame =3D 4096 * 4096,
+               .max_level =3D 3,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
+               .max_width =3D 4096,
+               .max_height =3D 4096,
+               .max_pixels_per_frame =3D 4096 * 4096,
+               .max_level =3D 5,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+               .max_width =3D 4096,
+               .max_height =3D 4096,
+               .max_pixels_per_frame =3D 4096 * 4096,
+               .max_level =3D 52,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
+               .max_width =3D 4096,
+               .max_height =3D 4096,
+               .max_pixels_per_frame =3D 4096 * 4096,
+               .max_level =3D 4,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+               .max_width =3D 8192,
+               .max_height =3D 4352,
+               .max_pixels_per_frame =3D 8192 * 4352,
+               .max_level =3D 186,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
+               .max_width =3D 4096,
+               .max_height =3D 4096,
+               .max_pixels_per_frame =3D 4096 * 4096,
+               .max_level =3D 0,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
+               .max_width =3D 8192,
+               .max_height =3D 4352,
+               .max_pixels_per_frame =3D 8192 * 4352,
+               .max_level =3D 0,
+       },
+       {
+               .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
+               .max_width =3D 8192,
+               .max_height =3D 4352,
+               .max_pixels_per_frame =3D 8192 * 4352,
+               .max_level =3D 0,
+       },
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =3D {
+       .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+       .codec_array =3D sriov_sc_video_codecs_encode_array,
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =3D {
+       .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
+       .codec_array =3D sriov_sc_video_codecs_decode_array,
+};
+
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
                                  const struct amdgpu_video_codecs **codecs=
)  {
         switch (adev->asic_type) {
         case CHIP_SIENNA_CICHLID:
+               if (amdgpu_sriov_vf(adev)) {
+                       if (encode)
+                               *codecs =3D &sriov_sc_video_codecs_encode;
+                       else
+                               *codecs =3D &sriov_sc_video_codecs_decode;
+               } else {
+                       if (encode)
+                               *codecs =3D &nv_video_codecs_encode;
+                       else
+                               *codecs =3D &sc_video_codecs_decode;
+               }
+               return 0;
         case CHIP_NAVY_FLOUNDER:
         case CHIP_DIMGREY_CAVEFISH:
         case CHIP_VANGOGH:
@@ -1173,9 +1276,14 @@ static int nv_common_early_init(void *handle)  stati=
c int nv_common_late_init(void *handle)  {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       uint32_t i;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                 xgpu_nv_mailbox_get_irq(adev);
+               amdgpu_virt_update_sriov_video_codec(adev,
+                               sriov_sc_video_codecs_encode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_encode_array),
+                               sriov_sc_video_codecs_decode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_decode_array));
+       }

         return 0;
 }
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C9be40f22588749e14c8608d916055a9d%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4su4V30%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C9be40f22588749e14c8608d916055a9d%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4su4V30%3D&amp;reserved=3D0

--_000_MN2PR12MB44889224FCEC0DA2C8C8D733F7519MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liu, Monk &lt;Monk.Liu@amd.co=
m&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 7:50 AM<br>
<b>To:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Complete multimedia bandwidth inter=
face</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
Reviewed-by: Monk liu &lt;monk.liu@amd.com&gt;<br>
<br>
Better get&nbsp; open source team's RB as well <br>
<br>
Thanks <br>
<br>
------------------------------------------<br>
Monk Liu | Cloud-GPU Core team<br>
------------------------------------------<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Bo=
kun Zhang<br>
Sent: Thursday, May 13, 2021 1:20 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface<br>
<br>
- Update SRIOV PF2VF header with latest revision<br>
<br>
- Extend existing function in amdgpu_virt.c to read MM bandwidth config<br>
&nbsp; from PF2VF message<br>
<br>
- Add SRIOV Sienna Cichlid codec array and update the bandwidth with<br>
&nbsp; PF2VF message<br>
<br>
Change-Id: Id0cfa2e1adb7a097997d53b34d41a6d36a390c00<br>
Signed-off-by: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp; |&nbsp; 56=
 ++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp;&nbsp; |&nbsp; 13=
 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |&nbsp; 54 ++++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 110 +++++++++++++++++++-<br>
&nbsp;4 files changed, 226 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index a57842689d42..c64e583347c6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -432,6 +432,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkval;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;virt.fw_reser=
ve.p_pf2vf =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
@@ -472,6 +475,27 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.reg_access =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((str=
uct amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;reg_access_flags.all;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.decode_max_dimension_pixels =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.decode_max_frame_pixels =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.encode_max_dimension_pixels =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.encode_max_frame_pixels =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.is_mm_bw_enabled =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D ((struct=
 amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;mm_bw_management[i].decode_max_=
dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.de=
code_max_dimension_pixels =3D max(tmp, <br>
+adev-&gt;virt.decode_max_dimension_pixels);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D ((struct=
 amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;mm_bw_management[i].decode_max_=
frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.de=
code_max_frame_pixels =3D max(tmp, <br>
+adev-&gt;virt.decode_max_frame_pixels);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D ((struct=
 amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;mm_bw_management[i].encode_max_=
dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.en=
code_max_dimension_pixels =3D max(tmp, <br>
+adev-&gt;virt.encode_max_dimension_pixels);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D ((struct=
 amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;mm_bw_management[i].encode_max_=
frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.en=
code_max_frame_pixels =3D max(tmp, adev-&gt;virt.encode_max_frame_pixels);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if((adev-&gt;virt.decode_max_dimension_pixels &gt; 0) || (adev-&=
gt;virt.encode_max_dimension_pixels &gt; 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.is=
_mm_bw_enabled =3D true;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;invalid pf2vf version\n&quot;); @@ -7=
44,3 +768,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(str=
uct amdgpu_device *ad<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mode;<br>
&nbsp;}<br>
+<br>
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vi=
deo_codec_info *encode, uint32_t encode_array_size,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vi=
deo_codec_info *decode, uint32_t decode_array_size)
<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;virt.is_mm_bw_enabled)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (encode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; encode_array_size; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encode[i].max_wi=
dth =3D adev-&gt;virt.encode_max_dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encode[i].max_pi=
xels_per_frame =3D adev-&gt;virt.encode_max_frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (encode[i].ma=
x_width &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encode[i].max_height =3D encode[i].max_pixe=
ls_per_frame / encode[i].max_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encode[i].max_height =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (decode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; decode_array_size; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode[i].max_wi=
dth =3D adev-&gt;virt.decode_max_dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode[i].max_pi=
xels_per_frame =3D adev-&gt;virt.decode_max_frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (decode[i].ma=
x_width &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode[i].max_height =3D decode[i].max_pixe=
ls_per_frame / decode[i].max_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode[i].max_height =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h<br>
index 383d4bdc3fb5..8d4c20bb71c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
@@ -233,8 +233,17 @@ struct amdgpu_virt {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vf2pf message */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work vf2pf_=
work;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vf2pf_update_inte=
rval_ms;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* multimedia bandwidth config */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp; is_mm_bw=
_enabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t decode_max_dimension_pixels;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t decode_max_frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t encode_max_dimension_pixels;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t encode_max_frame_pixels;<br>
&nbsp;};<br>
&nbsp;<br>
+struct amdgpu_video_codec_info;<br>
+<br>
&nbsp;#define amdgpu_sriov_enabled(adev) \<br>
&nbsp;((adev)-&gt;virt.caps &amp; AMDGPU_SRIOV_CAPS_ENABLE_IOV)<br>
&nbsp;<br>
@@ -307,4 +316,8 @@ int amdgpu_virt_enable_access_debugfs(struct amdgpu_dev=
ice *adev);&nbsp; void amdgpu_virt_disable_access_debugfs(struct amdgpu_dev=
ice *adev);<br>
&nbsp;<br>
&nbsp;enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu=
_device *adev);<br>
+<br>
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vi=
deo_codec_info *encode, uint32_t encode_array_size,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vi=
deo_codec_info *decode, uint32_t decode_array_size);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h<br>
index befd0b4b7bea..a434c71fde8e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
@@ -56,6 +56,8 @@<br>
&nbsp;<br>
&nbsp;#define AMD_SRIOV_MSG_RESERVE_UCODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24<br>
&nbsp;<br>
+#define AMD_SRIOV_MSG_RESERVE_VCN_INST 4<br>
+<br>
&nbsp;enum amd_sriov_ucode_engine_id {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_UCODE_ID_VCE =3D=
 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_UCODE_ID_UVD,<br=
>
@@ -98,10 +100,10 @@ union amd_sriov_msg_feature_flags {<br>
&nbsp;<br>
&nbsp;union amd_sriov_reg_access_flags {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_psp_access_ih&nbsp;&nbsp;&nbsp; : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_rlc_access_mmhub : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_rlc_access_gc&nbsp;&nbsp;&nbsp; : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; : 29;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_ih&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_mmhub : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_gc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 29;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t all;<br>
&nbsp;};<br>
@@ -114,6 +116,37 @@ union amd_sriov_msg_os_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; all;<br>
&nbsp;};<br>
&nbsp;<br>
+struct amd_sriov_msg_uuid_info {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did&nbs=
p;&nbsp;&nbsp; : 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn&nbs=
p;&nbsp;&nbsp; : 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asic_7 =
: 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t time_low;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t time_mid&nbsp; : 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t time_high : 12;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t version&nbsp;&nbsp; : 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_=
hi : 6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t variant&=
nbsp;&nbsp;&nbsp; : 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; union {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_=
low;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t asic_6;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t asic_4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asic_0;<br>
+};<br>
+<br>
&nbsp;struct amd_sriov_msg_pf2vf_info_header {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the total structure siz=
e in byte */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size;<br>
@@ -160,10 +193,19 @@ struct amd_sriov_msg_pf2vf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* identification in ROCm =
SMI */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t uuid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn_idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flags which indicate the register =
access method VF should use */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flags to indicate which register a=
ccess method VF should use */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_reg_access=
_flags reg_access_flags;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MM BW management */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t decode_max_dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t decode_max_frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t encode_max_dimension_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t encode_max_frame_pixels;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } mm_bw_management[AMD_SRIOV_MSG_RESE=
RVE_VCN_INST];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UUID info */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_uuid_info uuid_i=
nfo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-27];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256 - 47];<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amd_sriov_msg_vf2pf_info_header { diff --git a/drivers/gpu/drm=
/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 75d1f9b939b2..9f74=
060207a4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -218,11 +218,114 @@ static const struct amdgpu_video_codecs sc_video_cod=
ecs_decode =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_array =3D sc_video_=
codecs_decode_array,&nbsp; };<br>
&nbsp;<br>
+/* SRIOV Sienna Cichlid, not const since data is controlled by host */ <br=
>
+static struct amdgpu_video_codec_info <br>
+sriov_sc_video_codecs_encode_array[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 2304,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 2304,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 2304,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 2304,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+};<br>
+<br>
+static struct amdgpu_video_codec_info <br>
+sriov_sc_video_codecs_decode_array[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 52,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 8192,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 8192 * 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 186,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 4096 * 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 8192,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 8192 * 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_width =3D 8192,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_height =3D 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pixels_per_frame =3D 8192 * 4352,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_level =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+};<br>
+<br>
+static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_count =3D ARRAY_SIZE(sriov_sc_=
video_codecs_encode_array),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_array =3D sriov_sc_video_codec=
s_encode_array,<br>
+};<br>
+<br>
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_count =3D ARRAY_SIZE(sriov_sc_=
video_codecs_decode_array),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_array =3D sriov_sc_video_codec=
s_decode_array,<br>
+};<br>
+<br>
&nbsp;static int nv_query_video_codecs(struct amdgpu_device *adev, bool enc=
ode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_video_=
codecs **codecs)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (encode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp;sriov_sc_video_codecs_enco=
de;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp;sriov_sc_video_codecs_deco=
de;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (encode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp;nv_video_codecs_encode;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp;sc_video_codecs_decode;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
@@ -1173,9 +1276,14 @@ static int nv_common_early_init(void *handle)&nbsp; =
static int nv_common_late_init(void *handle)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgpu_nv_mailbox_get_irq(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_virt_update_sriov_video_codec(adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sriov_sc_video_codecs_encode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_encode_array),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sriov_sc_video_codecs_decode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_decode_array));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
--<br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C9be40f22588749e14c8608d916055a9d%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4su4V30%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C9be40f22588749e14c8608d91605=
5a9d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4s=
u4V30%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C9be40f22588749e14c8608d916055a9d%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4su4V30%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C9be40f22588749e14c8608d91605=
5a9d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637565034521071448%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3D6raS%2BZy0ngarsgVcG4NBkmH5Ym0%2BuyD7GCXo4s=
u4V30%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889224FCEC0DA2C8C8D733F7519MN2PR12MB4488namp_--

--===============1020848231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1020848231==--
