Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E85C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 14:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AB410E194;
	Wed,  7 Feb 2024 14:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBRLSExI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB63A10E194
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 14:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9Acdw63M8bUXOJDV3HY5YEvyaGEnWcv2lqb73yXOsWPMRuX//YauPGPfDzUD1pmnAAciJWSg6FlRQvBRpkbdMo1QDbsekIbmcu6bC/9Fo6v5Aqyd6QNuB1U3RHyuBkbQqGms9K8LGR62uHIZLFO3VFlSH7JKFYVoGtOh3uQwNcYeAZtDSVDREIFM31tBu/wc95Mht1GRvM2Q36x5o2M8oEquy+2+JsLZ2T5h91ONWA4gqDnWGxNqh0shJVLlQomdeWxKj7O6B1NU5VXSaiiU8I8F+Duplc7X82fQYLAxTk0jULbcQt2NQl5AnrZMcqWxxgoRwA4JcE3o/4IBIKHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD34Wjs7/s0wJIvvVglF9OrS66O9PfhpFokUvVOJwVE=;
 b=ZQVxufIZAyXhsyOgrVoMqMM2yIVzfAmSfgK0cWtgPlKBLUG4Pc1eHKRAqIk8RwTxIvoHF3k+U1+g7mtVufpSi/rqpsBbt2mLa8gm42m4uLvqi7DHYw2Uzn2H0NR6vVrLJiU6YBUuFWJRkDhWfuggbvT/hmXcXpKMSHD3U1toU5j5ZtTQgedia5eDEjQiFFDs3iLmsUk51RR8J9rWc36LLQS0X0rjn766w0UrcQTuEUznfW15rkm8xNDHjRJvd4CYyKT5r97OlhToueRIqebJHsf+bJQCCJcrlq8BLMBM7RE8YyYx9yxKsaOwGiE06LRg6/OeXvrsDdCBcMZPcyj/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD34Wjs7/s0wJIvvVglF9OrS66O9PfhpFokUvVOJwVE=;
 b=oBRLSExIbeCJXyGu8mGOYgOCB+iB/mYCuDRd2YtMEU1bYB8n1VyHwopuVVRHUdbhk52VrSEr5uWZt28tOYnSlJZttJZy5fJlj8gvSSdz1+SvpmhFugteCs8Ib+Pr3Id4Pp2864FD0rH+Y4vi9kIyePmBZ6hLgdHg67d7afrh+GM=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 14:39:26 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::d767:4e15:1725:35ee]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::d767:4e15:1725:35ee%6]) with mapi id 15.20.7270.007; Wed, 7 Feb 2024
 14:39:26 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Thai, Thong" <Thong.Thai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Thai, Thong" <Thong.Thai@amd.com>
Subject: RE: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding
 resolution
Thread-Topic: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding
 resolution
Thread-Index: AQHaWVRCEUlP0F4HN0W7qF4dHUXnKLD+9CtQ
Date: Wed, 7 Feb 2024 14:39:26 +0000
Message-ID: <SJ1PR12MB619458B1696D59C33D4A92EA95452@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240206232828.21053-1-thong.thai@amd.com>
In-Reply-To: <20240206232828.21053-1-thong.thai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62431cd8-617b-481c-ad30-32aa8855beff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T14:39:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|PH7PR12MB9102:EE_
x-ms-office365-filtering-correlation-id: 2bb8137f-f3d6-4c63-22e6-08dc27ea9567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EArRwKVTQVRkK35HEGzf4OmHhOyJlkBSWKup0dB6Uo0RpT+PgojvpgjAqjORuT3YwYQOMbIHQtTHBE9Gq1OPHyQ5na9Yw3rNAjaY+If+loSs+1aOtJVdC6IQyEbcILMgjR3gmVOXoj7tjvoTPz1xHFPjyZ3FKi6KVUuqPc7RUjwTY9EAAXk7N+vj/8769Uvdz64gzteKxKvyxHkMLQ6lnGmVrI2kkqbR5N8EpJZiHjx0hz55Bb92+x+wzFHbk3OFx7fxhACaRz85flagCxxgVc8tgBVBDCg1eK8P7CSVsvF5TyUmoJID3T4yXjE5p4tGlDCWmeA3f/bChq3gI9nkMFgLdL2xaZieUB3EOPKHt3QcrlAW3i8M4d9hBpfzrFZbNZNmJtN0HwsjJA7SCni4H4QAqVwrG6mQ9SxtaDPFvGYYPb5zOu4vdXfuKH2irsNI6aXdlbcuvMi9H7NCVWgDsfKBjiQvyarISO+XxHWYxzaMGvJMR+HqiNlVDTpUVzcJZQKG7GCEgy66zWRVb6bfL+RhkhGbx8gqSb83RlpDW27PgowxDl9OX42zVaAZUeK9Ju0XRYU7StXVg1RR35CMBGmG2y/H4scqzJ9cib9iEUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(110136005)(316002)(4326008)(38100700002)(122000001)(26005)(9686003)(66556008)(64756008)(6506007)(7696005)(53546011)(86362001)(5660300002)(15650500001)(478600001)(55016003)(66946007)(52536014)(71200400001)(8936002)(66446008)(8676002)(2906002)(66476007)(33656002)(76116006)(38070700009)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0VHrnSxDbGlNTitom37j6aTnSBHoj2IOuua2VC3eAnaCn+h2wrJraLtRPd8e?=
 =?us-ascii?Q?uiEm9gT5RmvrADpdygQjvbXlTw3xvirNvVe08goUOfhEGJg9KR20yoPvH0rm?=
 =?us-ascii?Q?Js0oO90KqaZj3x38KBcUDLTUWkmQ9+Seys38rnCRIe0ZTPwaERL+C14xPRJ2?=
 =?us-ascii?Q?e+YoYzZMTDlUY5rYY7XCgGdq0C3OMPZFtX6WYdyAs2+Z1TDOGFB4vj9n/oLT?=
 =?us-ascii?Q?PuWB7OQDX8atKbCJrovObHPgzpgByrm2PkyAeuWaneA6sHtoZyHO1/MB7+8r?=
 =?us-ascii?Q?BaoG4kGE97EEjSIBIxAFr3plObRLDT0Psat7NucqRsDjJbA3E/cOM7ZMsaOc?=
 =?us-ascii?Q?zTro0GaBCOaeU1P5Ge4VNrKUUCaIHBNujWyS6Elrdz3PrEMl0d3ORS00J0CA?=
 =?us-ascii?Q?m7WKPGffCHip4RUpDXNAaCp1X3SgamdkbCHiDDR+nTnY+k1i8FuXi+jDJnLv?=
 =?us-ascii?Q?vQMMz1uyrHxuhvTmSpnse2vT6guXe91mArC0wvmoSLVFO4cV1Rl5O1xRJwoa?=
 =?us-ascii?Q?MdAMfsRy0IaOnUMqLnEmnyYH9BkNNORV95d1+6qGv4lrgI+l1Q0pZz8nxlxh?=
 =?us-ascii?Q?GR0f9aPGmXrcU/TIu4Xk01HFpZ/5/QKe/oJxW/r2boNgLx+9A8Qd5qWS3bVx?=
 =?us-ascii?Q?xJhTfsskynMGx+q1zA8CcbS4HFmYJAspz6kWgYEfSSFCYJwmhdIt5SSLOxrW?=
 =?us-ascii?Q?6yqtblNQ/8h/ib9S3Ejcn6LIzX7+UsTPh1N4gVLLFqLlRqXgbFK8e/YwQJ44?=
 =?us-ascii?Q?L9iX9szQXgxn1rjPJvRnwwvEBZVoBtFJMOIsUUfM1ngp+QUK3WBywC4A558q?=
 =?us-ascii?Q?2szqNiP0GWvLV0r7Gknq8m+Xns0dmFO+E0GVF/moXqZwFmUKYzPexu2pNek3?=
 =?us-ascii?Q?qdEaRfOXiG+u/90bTZoDEZByAhNomPM6jbcJlvSoRC1E2ylZebnF3LQFF+P0?=
 =?us-ascii?Q?IcYhHsPfR9rGwT2gMGoZXQVs5bMNdkDzP9qFHbpF0jsgH5kq4QJnUKCCbCNq?=
 =?us-ascii?Q?EfzDG96C7eT8LcDOh5GFjl/0lkjBz3MgSDZJllz5IuX6sm5hxizJQH+M/pkp?=
 =?us-ascii?Q?HUqF8Wj0n13Uz/FvmBfiC+ZzKocTHlHO4NhMLZSPi25v7uVeEHy+LStMfyUV?=
 =?us-ascii?Q?YPGKqe7/aTpLfEblqQ3KTeRcKfFKXP2yRRlMIK2xlMKUdUrdO0NBCVO2qeCV?=
 =?us-ascii?Q?/wrO0QHbB9gyGJTrzqYkSSJ0ltLAAwa7777KBY+DWpTBEwh2EEpw+yMIrefF?=
 =?us-ascii?Q?gcWcnRydzwrkSwGSxUXNJvxpiODylqtwA2K0qg9E8jWuZtPbl57HJSy/nLIU?=
 =?us-ascii?Q?h/gxH0Jh+hGQv1d8HsTgj1KkPDJgNKpCMNzwugthf5tZUrymx5ci3qLT8xhN?=
 =?us-ascii?Q?NBLJI9ympczf92GvJJiRJ8UDXQbdZucbAqxHr6PcMeh/fnAMS9xcj/PyIOwq?=
 =?us-ascii?Q?TAWIilB94Utg/DemsjPkCJiDuZ16cCdQSxR11Z36Qk2YdFf08qoEwXCDmpP4?=
 =?us-ascii?Q?90l478hZH4ecVTGvqw9oYeXIHGcwOApo+mR+Ri+JOm0ZxBFgkEKuxk1pCNzd?=
 =?us-ascii?Q?YVi5PQKhex33m6TO8pE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb8137f-f3d6-4c63-22e6-08dc27ea9567
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 14:39:26.1888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUz9D0M4iK/Tii/pZjWCL+6V7QM5xPIDWdd89Q1Xc3p9KmH5cX1EhXn1R/uAFd2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

[AMD Official Use Only - General]

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Thong
Sent: Tuesday, February 6, 2024 6:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Thai, Thong <Thong.Thai@amd.com>
Subject: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolutio=
n

Update the maximum resolution reported for HEVC encoding on VCN 4 devices t=
o reflect its 8K encoding capability.

Signed-off-by: Thong <thong.thai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 48c6efcdeac9..4d7188912edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -50,13 +50,13 @@ static const struct amd_ip_funcs soc21_common_ip_funcs;
 /* SOC21 */
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_=
array_vcn0[] =3D {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 2304, 0)},
-       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
,
+0)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352,=
 0)},  };

 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_=
array_vcn1[] =3D {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 2304, 0)},
-       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
,
+0)},
 };

 static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn0=
 =3D {
--
2.34.1

