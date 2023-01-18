Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB0DC38142
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 01:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE32710E61B;
	Wed, 18 Jan 2023 01:09:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AD610E61B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 01:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu2aWfYrv5DMlRZ/qhohjo6L5H2lEHZptYHBV/WWkEPYAQzvXNxxpWoqDUHTath8V/7srS8umCRHob8gB22ieftCOHMlF/Bu6c3GEzOzB0UKZlKi1KYA+t58bJK8oITz6lrOceb4GYbKjt0rTksiIh4HpmOpLApbbUSIaxuzzytSvqkaO9glyC0ouOONZeo12JvVwL6lsJlfVH0u2pLRxpaCGx4Fmg0ia14c063MAXleGeK4W3I+jBAP3sPmuEjFhsZ8uSsmHuF9PlVsJPWdnPmZfWaLcKBlpVu+w55gWVNqkCwtgYF1+ot7NCUaUjqZvjwaOctY4LahKItqGIfgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jij+K51agKaLrsf2/En173sdgRsQ6+RUULBEOdYUWr4=;
 b=F0vjrzVsGq1u0cWRqsad09Tm+p5OZXCHQYB97X/NA7luZKcdIGUzT0+wIQefoC6o3zA0L17Y5NUjBHKmvAWl9/lRazd1Wro04cJNWJR+AstKvWMblr2kqCVBh6t7fzTyZSaQ5yLn6WG7UziQbr+WrDozOixzcpSZI8ZjurA9Xh7beTyhMQ5skjjpn3tQLR3H5yIFUd5FXU8HqrRwjTXMMnbBEDf7DTO2PXEAolX/QZFBrf6ItBo1GjMf/7e2feiLCF5OYMFtFZeSrR4soclxKLiDMoqk0ZLvCFlQhhZVxdk2tGgaL26ND6MqfGGC20iIplNos+FRHcJGVWy77S56Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jij+K51agKaLrsf2/En173sdgRsQ6+RUULBEOdYUWr4=;
 b=OSYDl23s8k14T3OJbIJH1ZgNCttauM9VrR7+xrBy6/Klw9rg7eXnS+6/oD9Sm8HIUt/LD89FctRONhI3nNcx6tLVEy3mfS4NSA5lx5HVQqRzZYPAH1tlX9wm/5e0wDkUu5JyLqQ6JDtszUYbryErdfj9yKIDzp16rd6gn8DB1sk=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Wed, 18 Jan 2023 01:09:53 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261%2]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 01:09:53 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested
Thread-Topic: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested
Thread-Index: AQHZKq5QwLBclA9H60y5iGp+vZarGa6jXY0A
Date: Wed, 18 Jan 2023 01:09:53 +0000
Message-ID: <DM8PR12MB5399565D89E1995B46AFC760E5C79@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230117195949.1729608-1-alexander.deucher@amd.com>
In-Reply-To: <20230117195949.1729608-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4cb8b300-2da5-4e51-92a3-09c6857861dc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T01:09:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS0PR12MB7971:EE_
x-ms-office365-filtering-correlation-id: 25460420-160e-4fdf-9c5b-08daf8f0b4b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b71ViMfH6omZyTJ04hC+Z45vzTq2zFz6FbGlz0qZy+yT3g3ZZLiM4aRzDKMeB5Wz8pXhIDiZFrP43cJtzEWQponXjMS0jX/TN+xgJ6eosWTNjXx+dGQDTGF0Qfal0qfjPgXmgNud2UqpCLhD+cAFuNH6FEqzXHnafmOQrB/h1ptqmDIT83DUIMnKMUMmGxR34TSYDr7qjIrQs8zYvDOTxa74UZeASJXywHTmUkK/Ixka3xVfq7sHqjVex0X/MJCTHo+enITGv3PaFBNkOdWyzVLVVtLmkUKwNbhsBEGfcyu4h/xISY2m245FVz4xwBrX+igXVzErmScx2p6j50Com2aHo9LQgawKvCYgtSVGJl+MEnHVuEa7Ug2iDWyQwdWjyqetRF/u9lz+HPfVHWu5I/+9fefSW+AM318SwfQJraL6QZie+1PzTOt2FcsfB12Opd5jNjteSTJSvg48xyMHHI33r8sTtufgfsG5NgQ6mbKsq9eRKkEOVi+SkSiVKV+h3TxIYVYgHGpIK/2HHKURg7lhUkTENNZUgSb2q/oiM3TfrFmiiXQmAA5GLOQUX+qObQg8Cun9SJBXCRtPcTfhIn/pJc3BmRDHbB+nsxoxobKG0o/p4VcfacRF3XT2/PiwZvetFsuMSkJGyEtgwZS1c/S0ojMW+67NGrVHFj06mb7e+fBbkrmFJoU3veRO1M0GoG+zP/ZyNNaG/aSVOmn3XQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(38070700005)(86362001)(2906002)(64756008)(52536014)(8676002)(8936002)(66556008)(55016003)(66446008)(66476007)(4326008)(76116006)(66946007)(83380400001)(5660300002)(33656002)(122000001)(38100700002)(71200400001)(7696005)(110136005)(316002)(41300700001)(478600001)(9686003)(26005)(6506007)(53546011)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LdcpgU7UhdftV9MwvQFOukEOOkHN75LqeV6/h7eAYK26Ik8S7IN6xC3boRRr?=
 =?us-ascii?Q?i/XM1kXdN4Ya1gnO4Eiv0OxS8nA/HFVIEmMqWIi93QWO/e25Pvn8WbMkOLpT?=
 =?us-ascii?Q?TzBXcosCz7j4QnU2SoIx6H4vIZBtzNs8Dgc5n5DIgzaYYPbEtWcY24ouaBML?=
 =?us-ascii?Q?hGJQfbFQbBBVJcYWo+YdzHObt0fXNvkU6VU+VrdyA9ZHWXnhO3TZlcNwF0Zt?=
 =?us-ascii?Q?HfegI6xm0iCrcnimmopGVfQ2C1FM+y2n0EhAw8/9v5Usg5nNJ4ogVDGQECIt?=
 =?us-ascii?Q?EhusSEEc0pnUVBVwYfb5z3nXfFzoqIVWaEw+ede4u9vt2dweURttlubO5YM0?=
 =?us-ascii?Q?wnwznSkgH3RulvbWQyk8P4Ewvp5DvPh55kw/vohQ092IisvNIMQhItecHveG?=
 =?us-ascii?Q?4wnPy16QdLzUwQklYOpOBpBhAY/XQlkz6+3NFIOaNgArxulnUTSLgbpMsWFO?=
 =?us-ascii?Q?tdoZ08UmBo51NTNNqQ5gnxYSN6hhCNjugJf/zyTCcsfk/koytzXay1k/zlrK?=
 =?us-ascii?Q?N3ybQnn/qIu6nV9cce7oUYinCudxU6/y2qAcSby/yxJCCOegY17+RtUWvYk5?=
 =?us-ascii?Q?VpkSfM17LlKdLQSzcUUGBh/6oAQGt9iB+oJKWvGsclMfDTyu2MESlk5sAe7v?=
 =?us-ascii?Q?+Z309CgjC1fNbi+H5lPZaI6cavTrJDbLVj9S1sXCeBdK8/ux+Gx4AXUFahU8?=
 =?us-ascii?Q?bfx6MLbCqSjUImMelbjmMz5ZTpsCpcxwzEgDHUypZPbOz2mJQ4qR7xy/iXk7?=
 =?us-ascii?Q?mmLz5ha85Z3Qk9wCckaO26mPk/tRIhV5grJPO2m9sy3POZr3bgAEs0Mm/GCn?=
 =?us-ascii?Q?FtZLg/ajev2in0s6Cn1VGrH7LTQo3W9reatcnQOtl1PaIF1yMSlzZy4JwODa?=
 =?us-ascii?Q?7EckOBvb9PC++a1kS5Imm54xoDqsQifUUhgNoL4XQw1/gsuQf6vltIYhLT31?=
 =?us-ascii?Q?DS0JQI31ASo02Tz8MWDIAILkp4sqpUPk9WKhSCu5F09Cpf/5ECb/2DnB4zYv?=
 =?us-ascii?Q?sL+P3kFEfyt/Tf8vK7x9+v2Nl3k+ajYnuF557YBW+mEgtko+jj4nP0bYVgbS?=
 =?us-ascii?Q?YPZvB/x8tgSZZhRQnmTQEZtF1416nyOIn7N1nNDaTRznITcsL7QbX1jcE+Bv?=
 =?us-ascii?Q?QvnVGKC5h+nUhN7tZlqonKLKkOOFmZlCFdKgKNJ+JH2E/r9Q1dnj7jVO3vMf?=
 =?us-ascii?Q?vuLxSqrlpTJnTy3wp8UG6/ujoqIWV+KDzDVZ5CXQCpfSTwhRVXTl3fxs0btA?=
 =?us-ascii?Q?1wacSw13e2YU27wBWQg2AetP+n3kkNiBqjGFUo4gHPro3qdrmt+QnIGCSl/t?=
 =?us-ascii?Q?ySJW/Ch0HUxHkL44Nfs3kKyv5vS96yXRmASuCzlYst/PKfR+JotDdOmRbLYH?=
 =?us-ascii?Q?Vx6eS4QnTWFUwGO7xEshdh2TpDSvcVCJDBG5UnopWzmXN2z5A5heVcqMQLrq?=
 =?us-ascii?Q?zJMwHWxyet2EiOU04pLDWSOITnhk3NsBlLKvB1vwS8U7bqF4PJNGXmwqkEmi?=
 =?us-ascii?Q?H68qqBGXD+Y6NkLoUEBvEO4kr2TuxK3NMkD9fKwTqp52OgSpryM0sBjFstQI?=
 =?us-ascii?Q?OEjjmK8FJJ8TPmblsr0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25460420-160e-4fdf-9c5b-08daf8f0b4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 01:09:53.3347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxDyKYfYTpJ9QNcdK/GKnpyTXZIzS93gTZtDXMY9qBvNvgjuwkqHZzgAzX8Q801t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series are:

Reviewed-by: Leo Liu <leo.liu@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: January 17, 2023 3:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested

Only VCN0 supports AV1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 101 +++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 6853b93ac82e..d972025f0d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -98,7 +98,7 @@ static const struct amdgpu_video_codecs nv_video_codecs_d=
ecode =3D  };

 /* Sienna Cichlid */
-static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[]=
 =3D
+static const struct amdgpu_video_codec_info
+sc_video_codecs_decode_array_vcn0[] =3D
 {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 409=
6, 3)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 409=
6, 5)}, @@ -110,10 +110,27 @@ static const struct amdgpu_video_codec_info s=
c_video_codecs_decode_array[] =3D
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352,=
 0)},  };

-static const struct amdgpu_video_codecs sc_video_codecs_decode =3D
+static const struct amdgpu_video_codec_info
+sc_video_codecs_decode_array_vcn1[] =3D
 {
-       .codec_count =3D ARRAY_SIZE(sc_video_codecs_decode_array),
-       .codec_array =3D sc_video_codecs_decode_array,
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 409=
6, 3)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 409=
6, 5)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 4096, 52)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096,=
 4)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
, 186)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,
+0)}, };
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn0 =3D {
+       .codec_count =3D ARRAY_SIZE(sc_video_codecs_decode_array_vcn0),
+       .codec_array =3D sc_video_codecs_decode_array_vcn0,
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 =3D {
+       .codec_count =3D ARRAY_SIZE(sc_video_codecs_decode_array_vcn1),
+       .codec_array =3D sc_video_codecs_decode_array_vcn1,
 };

 /* SRIOV Sienna Cichlid, not const since data is controlled by host */ @@ =
-123,7 +140,7 @@ static struct amdgpu_video_codec_info sriov_sc_video_codec=
s_encode_array[] =3D
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304=
, 0)},  };

-static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[]=
 =3D
+static struct amdgpu_video_codec_info
+sriov_sc_video_codecs_decode_array_vcn0[] =3D
 {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 409=
6, 3)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 409=
6, 5)}, @@ -135,16 +152,33 @@ static struct amdgpu_video_codec_info sriov_s=
c_video_codecs_decode_array[] =3D
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352,=
 0)},  };

+static struct amdgpu_video_codec_info
+sriov_sc_video_codecs_decode_array_vcn1[] =3D {
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 409=
6, 3)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 409=
6, 5)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 4096, 52)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096,=
 4)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
, 186)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,
+0)}, };
+
 static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =3D  {
        .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
        .codec_array =3D sriov_sc_video_codecs_encode_array,
 };

-static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =3D
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn0 =3D
 {
-       .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
-       .codec_array =3D sriov_sc_video_codecs_decode_array,
+       .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0=
),
+       .codec_array =3D sriov_sc_video_codecs_decode_array_vcn0,
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn1 =3D {
+       .codec_count =3D ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1=
),
+       .codec_array =3D sriov_sc_video_codecs_decode_array_vcn1,
 };

 /* Beige Goby*/
@@ -181,20 +215,37 @@ static const struct amdgpu_video_codecs yc_video_code=
cs_decode =3D {  static int nv_query_video_codecs(struct amdgpu_device *ade=
v, bool encode,
                                 const struct amdgpu_video_codecs **codecs)=
  {
+       if (adev->vcn.num_vcn_inst =3D=3D hweight8(adev->vcn.harvest_config=
))
+               return -EINVAL;
+
        switch (adev->ip_versions[UVD_HWIP][0]) {
        case IP_VERSION(3, 0, 0):
        case IP_VERSION(3, 0, 64):
        case IP_VERSION(3, 0, 192):
                if (amdgpu_sriov_vf(adev)) {
-                       if (encode)
-                               *codecs =3D &sriov_sc_video_codecs_encode;
-                       else
-                               *codecs =3D &sriov_sc_video_codecs_decode;
+                       if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_V=
CN0) {
+                               if (encode)
+                                       *codecs =3D &sriov_sc_video_codecs_=
encode;
+                               else
+                                       *codecs =3D &sriov_sc_video_codecs_=
decode_vcn1;
+                       } else {
+                               if (encode)
+                                       *codecs =3D &sriov_sc_video_codecs_=
encode;
+                               else
+                                       *codecs =3D &sriov_sc_video_codecs_=
decode_vcn0;
+                       }
                } else {
-                       if (encode)
-                               *codecs =3D &nv_video_codecs_encode;
-                       else
-                               *codecs =3D &sc_video_codecs_decode;
+                       if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_V=
CN0) {
+                               if (encode)
+                                       *codecs =3D &nv_video_codecs_encode=
;
+                               else
+                                       *codecs =3D &sc_video_codecs_decode=
_vcn1;
+                       } else {
+                               if (encode)
+                                       *codecs =3D &nv_video_codecs_encode=
;
+                               else
+                                       *codecs =3D &sc_video_codecs_decode=
_vcn0;
+                       }
                }
                return 0;
        case IP_VERSION(3, 0, 16):
@@ -202,7 +253,7 @@ static int nv_query_video_codecs(struct amdgpu_device *=
adev, bool encode,
                if (encode)
                        *codecs =3D &nv_video_codecs_encode;
                else
-                       *codecs =3D &sc_video_codecs_decode;
+                       *codecs =3D &sc_video_codecs_decode_vcn0;
                return 0;
        case IP_VERSION(3, 1, 1):
        case IP_VERSION(3, 1, 2):
@@ -993,9 +1044,19 @@ static int nv_common_late_init(void *handle)

        if (amdgpu_sriov_vf(adev)) {
                xgpu_nv_mailbox_get_irq(adev);
-               amdgpu_virt_update_sriov_video_codec(adev,
-                               sriov_sc_video_codecs_encode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_encode_array),
-                               sriov_sc_video_codecs_decode_array, ARRAY_S=
IZE(sriov_sc_video_codecs_decode_array));
+               if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
+                       amdgpu_virt_update_sriov_video_codec(adev,
+                                                            sriov_sc_video=
_codecs_encode_array,
+                                                            ARRAY_SIZE(sri=
ov_sc_video_codecs_encode_array),
+                                                            sriov_sc_video=
_codecs_decode_array_vcn1,
+                                                            ARRAY_SIZE(sri=
ov_sc_video_codecs_decode_array_vcn1));
+               } else {
+                       amdgpu_virt_update_sriov_video_codec(adev,
+                                                            sriov_sc_video=
_codecs_encode_array,
+                                                            ARRAY_SIZE(sri=
ov_sc_video_codecs_encode_array),
+                                                            sriov_sc_video=
_codecs_decode_array_vcn1,
+                                                            ARRAY_SIZE(sri=
ov_sc_video_codecs_decode_array_vcn1));
+               }
        }

        return 0;
--
2.39.0

