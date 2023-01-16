Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03A6C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 08:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EF110E135;
	Mon, 16 Jan 2023 08:46:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5BA10E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 08:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbT3N7uC353t0OQfMSB9f0L221iCfJ3/tU5HQrc8+ypT055Yz/oHcKZWV1XyN1f4uPi54osTdgkGEPY6IRrwIc/Pb0N7YZevjnrTSMfmCDcwIGHYjB4Q30nPMz5dfo3spebyaNqudDR0EzC7a8F/3V98UQhWwWteddOixyFM0NiWlk85vvyqS2zMJaEROxFZE8MfXFmew0U8y3UfR9CeHVtpW5le4icVxrEQa3qamU8pqFd5wo3lrsTx0cpC0TaFdFjg+0RwuaUoIRrM6p5vheZPuxtzdIlG1C8FMrk+D7hXQjv+Bi6A5/WcWIKMLBnSk8Hj3EEf6MNQ5NO3ojgl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsaQO28tUwrDVH2gqaULmMEW3cbF2f6czAwv/+l57vs=;
 b=OXUtPxXRHyk1US30ygXmOXKGmwnJqSusFPtmOJcqMKTU9tvBEbpGJK6xnfpSjMNVgIoV91T/TzNvbCcHRX3BB9z8Vw9jo141cxYtrArdjYcJ+EyLdSSfCXnElZmlGsl+GSXy5J42B3xzuIsImnA994QvyY+MjpCGFoUka/CLDyhYtViRRFlzINAngR8wgv60zSs6xF04CmWETLMZaTZAdBH4qTX6y90Ibvoj1LRwzq4NIMcdf7VolPfUWLUqdAs/uYigNSLkEetdB4gbEZlgIVJeQbjHPhTP1k7Qdm1A9GB+cdGfLmRlx9mb4LXsu9lhT0fZSxi2l4GwzfHO7tM6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsaQO28tUwrDVH2gqaULmMEW3cbF2f6czAwv/+l57vs=;
 b=PuYF/1Qpudmk5rG7+MJztW2AsiWsBFNQH7Csd+GjomY/OTKeUgbuf5YKKExV5HhaG7fBHaByW5rqEYy0oUd6zQ7hPmujsfFd1Hrh4bXHCJ5ZrboRg6gEzWqf3fm7QaVCV5iVx+yVDX7CmSkokvG1hGZlriX29rKBs6DVRQQhpgk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 08:46:34 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 08:46:33 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
Thread-Topic: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
Thread-Index: AQHZKYN//m9SL1mF6UOT3CC6uuSOlK6guIUg
Date: Mon, 16 Jan 2023 08:46:33 +0000
Message-ID: <CY5PR12MB636934BCADDA235BCB0720B1C1C19@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230116082025.2188409-1-Lang.Yu@amd.com>
 <20230116082025.2188409-2-Lang.Yu@amd.com>
In-Reply-To: <20230116082025.2188409-2-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-16T08:46:02Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0491aeb1-b041-488a-8492-f4f6ca328b96;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-16T08:46:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1a4e3d0d-e058-4fc7-8c53-0c4b4a2a15b9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ1PR12MB6100:EE_
x-ms-office365-filtering-correlation-id: 62c10096-23c2-475c-0a77-08daf79e2bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9689RlXPqYJKl5XXaqYJ+CWGoZWBlQdVQgDVRjgfJKBm/tSq08pdp50ndFfwhlNC0higCuImRN9dQF6eVBdBwhEpWG6Nigqvkzm+Df9Rhm2WHsHROEwUbAQphlLfmSJu6SDfkZPdpc/yr9+cx2+Ota7b8CYRS+4va6gxknEUHYd2PEH1w/2/dwneU5WbPMcAS9faZ0RDLAnVJ+7H+CvS+d7XbmdCJCsV2bVdEHyeCaMfjCM4+VI+T9qr5TmVNAxnOMQekUTJPux3CeFnZ1IFsKs1Q6NiHFHMAWQgWo1fs4KBFyY3sI0ZwXnIVhIAWrKIhLoNBWoLpc3YRQt6HF39zu5lIV9XJDI8zOLbeRLoO1H4wHK+Tz6V9Dcs4FZSpSqQDSZx096RnJiWb2mCxgitOhLEST7pqKZokQtEKNzOZ4m/GT1TeuSpqcZvLMQE2TYYc1v+KDRC/vLwuqTNSKRDuPJ0b0pTcSTFTdhaItSYBkrZErNaDxcOMjf94pelh/ykOh7DrnanaPBzMPiIah6KNE+MJ+QRuPK5aRifFLhA5Yu7s4/qjYNokKml5tQpvQLwZbqYZy1rZTjaZ+O4Ss8qpJG0AaxpSIXIfm0eNsVqDGor8FGx638A94+K07YOpaGegjIsCdP6eG5088lSxC1/sSEPjPSr9n5OcK3YJqp/ObR0zvwiSQ0Dgc6KX00FW56leKLRltA6bq8FggxXPu3Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(41300700001)(38070700005)(478600001)(33656002)(38100700002)(71200400001)(86362001)(316002)(110136005)(54906003)(186003)(66556008)(66476007)(7696005)(66946007)(55016003)(26005)(53546011)(5660300002)(6506007)(2906002)(9686003)(66446008)(4326008)(76116006)(64756008)(8676002)(8936002)(83380400001)(52536014)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XO0f+L/why72WRqmOlPdKYFH0Cyj0xNyHaEmSPGifeW42/vTiC0UCyjtvDHV?=
 =?us-ascii?Q?sTjmt5S0cUvn9efbEszBAd1PgatAJOsHir4H6Pq3q9fY1HNgVHPGlkxOLcS9?=
 =?us-ascii?Q?2oD+H3iDAHse7UBIIGCJVHm4BhrtJbEG0hwVL+tXEJfT3mli7umvU1kkqxL3?=
 =?us-ascii?Q?7zV8MaWKegNCoF0VCY5aHSfswxjHnMI0RDRN3rUaZdYtEUTyiiUFOfCkKQCM?=
 =?us-ascii?Q?TMh+KZ2tOg2cM4C1k611UjqyrpmZ9D27/Yfj+9qEQVMFjbt4yfju5TN4IflZ?=
 =?us-ascii?Q?ZoleADAs/RHVtiAa719n6gAtGHojlGPdyv1Ye7VY5Sx1O+lz8tSVr+WHC7DF?=
 =?us-ascii?Q?jmSJL5JojKuNtnRFtkd/Y36lY5lAI7oMB3nOJAykMVX0DUVv+LRGHjBd5LWW?=
 =?us-ascii?Q?XIWprHgMQqUti6GjKY5OjjSYjGd9E9JV550bWoVHHfMkYfLIJxRsq2vOqkvq?=
 =?us-ascii?Q?sjgQn1LODgs4B+iBXmFejKeSDkk9dzCi1oGUjN9rmikQjYA/Ux7wM8tI+3Lg?=
 =?us-ascii?Q?GgDKy9C1RJCGRk5vDkTM+M+400rK1Sf4cKU9AYDA/GmcgBNXVYyqPi0KZamT?=
 =?us-ascii?Q?VePmsutsnfPrN4TZfvKN6ET72URlmORDeqbPnkLZkCwi61k5OTpbfMQU2Z7+?=
 =?us-ascii?Q?sUXy4aOP1icl9qH02IQrvoNWvBfvouJYZdgkcGEDebPrDBTB2Z0prQDN8v47?=
 =?us-ascii?Q?YK0zk42pJqudRj9Di9NE8/ga+ueJPxFQHhjHBVOPwVQnmTV1/vreQcsdK3CY?=
 =?us-ascii?Q?Todj383f9vy3sKFERSTKi4C0rMS2ESUrlhy+bv+47yy3rldnGEuvjJviDurF?=
 =?us-ascii?Q?llGk8+XvGenW0H/SrD+kKdkOLZvDEcLZOsI7HuVLEZ/rIca7hfp/FizJjSEr?=
 =?us-ascii?Q?0IwfYbnADdFMcOFZHuFeY7amXte+0nriTgm2DGhHQrM5wvKA4PvtllB1Wo92?=
 =?us-ascii?Q?mACqQAwfxZBJ74Sv94E54J1KpkyQ/OOtjRYXYmKSHUpcOPrsMO9+U0jgvOUU?=
 =?us-ascii?Q?7g6nGJhvGF36C0pxtKXE6/rQ0vOMfggtPBYro3R6ctVJ7MQZuYr8buU/p9eb?=
 =?us-ascii?Q?dp8aZtMXm25jrM+XKNpMU+GDMcu4MDzaEv/xnCT7OP2z9j1LXJ7TXIw3KBWw?=
 =?us-ascii?Q?7uSeK63D9KrqJMxjmuTQum8VWZaP6oElWqIdah1UZPj1lYtBo5HljGrMFBY3?=
 =?us-ascii?Q?1rVmg5nmivxUMyv/6lJ5ditueoJB/sfo9goc5BTl13x5UrpmYy2gezRI+fyq?=
 =?us-ascii?Q?HtyoyE8UWMWdX9j/B8drCVbmYO+tKbXoxQ2M4bQ/vgl1HF9DbPFZrecq7vGZ?=
 =?us-ascii?Q?QD3FzQZ59ZH8xYTCITQ091e7MjVKZJicozVAettsohQ2MLs99XMHLFvNmUD7?=
 =?us-ascii?Q?0qcp3Me/RAj3CBm3S4Bhwy8GLsM0EoSuCKcvpqPpJEQjV29yd78v2c1Hg8Y3?=
 =?us-ascii?Q?Kau4seQMCUmwMnDbDfz8r+uRSeFFC5vw1zI6azB9qYLDu5AfqJdpStDNcnPs?=
 =?us-ascii?Q?U3u6OhIWnAoB/M1IrUW8u/VNUrfnN4q5/3S5CrfYAYKGDW6Omp5b5jhTQQES?=
 =?us-ascii?Q?brCOe6+R3OWu5ciMT/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c10096-23c2-475c-0a77-08daf79e2bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 08:46:33.8859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghCHSj7d5he25wkssuVTfL5RvHD6ktR/3gxWnjlhwvJ2qSej2zWvQgr0fQCH+Wsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>=20
Sent: Monday, January 16, 2023 4:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Du, Xiaojian <Xiaojian.Du=
@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs

There is only one MEC on these APUs.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 985fe704203e..dd4e0f337f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1251,10 +1251,8 @@ static int gfx_v11_0_sw_init(void *handle)
=20
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
-	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-	case IP_VERSION(11, 0, 4):
 		adev->gfx.me.num_me =3D 1;
 		adev->gfx.me.num_pipe_per_me =3D 1;
 		adev->gfx.me.num_queue_per_pipe =3D 1;
@@ -1262,6 +1260,15 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec =3D 4;
 		adev->gfx.mec.num_queue_per_pipe =3D 4;
 		break;
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
+		adev->gfx.me.num_me =3D 1;
+		adev->gfx.me.num_pipe_per_me =3D 1;
+		adev->gfx.me.num_queue_per_pipe =3D 1;
+		adev->gfx.mec.num_mec =3D 1;
+		adev->gfx.mec.num_pipe_per_mec =3D 4;
+		adev->gfx.mec.num_queue_per_pipe =3D 4;
+		break;
 	default:
 		adev->gfx.me.num_me =3D 1;
 		adev->gfx.me.num_pipe_per_me =3D 1;
--=20
2.25.1
