Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB41C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 02:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A9888161;
	Tue,  1 Mar 2022 02:50:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4906288161
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 02:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKc+QbkB31R+P1upwPSF3tqPdB0lnooCptQ3/gv5i14O6UTfwkw8Y3sk7ZelxnH/NYpXsgBBHtyDygnV5kW0L+1I/5CGTzSDM9UTiS2IrqsCRh5lJqJ5Sx1iGvEvP8go/ELp2jW7cpjbH3VBZRu70jIm0a7tDNs3cNuAO4SmszQaUEgX8WEqvEP90p0W7DfGVBuU1Wt9Z6KmMQJoPIsZS8VYkbTys/Hn93gLDKYYK6VcYJeUZmtetuxdXfO1G4xRcnhRhtWe3jB6EHnviv2r6QYTQp03FlEApTpyomimQ9EIp7byt/wYPw37rnPQvnYhS0sTGeSQBCX4mztGRWq9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDVvmJprpTlmxUYyqz7tvnfSqJsEFguAKBosNi+FIeo=;
 b=SzYyA/EO/w9iznILYleawqFiXEp6WrH0SSj+tu/3YVnyMPy5JXkOLXFiu8MJ90bkizwRMEjUnCclIknxiRTa38aEjONxHovcCixkpQPUVd5TKk5b7HnWHIAzFCbviC7r9bWlH8NvcQw7Sn6PHugMx4/EtMkV9PbHWBsfOncOckKmfMyBNn/AgloFVsnoh56/bmpPE5w6jaHX65B1ozIS9mWD7Mo6XCFL6DtVZchV9eU97BEaBa0Ontj1SII4PUkg+qDwBzLsq7OOPu2xijz14XFvQfGv+TE67/AMkQP7gFwJpQtH9vnkdGuJSibVoXD6lTVx7X/XW+NVg5AeCIZBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDVvmJprpTlmxUYyqz7tvnfSqJsEFguAKBosNi+FIeo=;
 b=WAJ5SvvFWiFErFDsSKW/njBLPTNh9Ll+peEoHLxVXirfyL9BCQDeqwOvRiLzKmefqcUyp95aLEZLwMOHAclZl6m+M6CCn7ywYlDMitksICpnzvIDJZu8VlD4JjPhg3q7VYEJiHAvrFjcDLQpQs84LJS9GN1toKZfGaa5v7aVBm8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 02:50:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 02:50:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use IP versions in
 convert_tiling_flags_to_modifier()
Thread-Topic: [PATCH] drm/amdgpu: Use IP versions in
 convert_tiling_flags_to_modifier()
Thread-Index: AQHYLPDJP6bWGW8rJkCfn5R20mnv4qyp1EMQ
Date: Tue, 1 Mar 2022 02:50:36 +0000
Message-ID: <DM5PR12MB246942527A1C2EBDDAD3DBFEF1029@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220228221532.1002763-1-alexander.deucher@amd.com>
In-Reply-To: <20220228221532.1002763-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ba5c6d-efa4-4ffe-2a1b-08d9fb2e439e
x-ms-traffictypediagnostic: MN2PR12MB4238:EE_
x-microsoft-antispam-prvs: <MN2PR12MB42380D5BD71EFFEB3752B574F1029@MN2PR12MB4238.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZ8t4T+HIaJK3qACoQGtEMaGx/suwDGrxBy9yOaNrC7/MEG39hXrOE9V3asQGtYU+BelZvasc0cN0MFUBuYmOvB0vp7j5ZQ/zwV/kFOi85iTVriUZ/rcDzEhffjRKKluJTvbnO6j9Eks4cm2BeuHp/JGMNrvdNtayssCYYSHFkxlwvxJtcx1nFV4vJ5CrC7phYZFvNlk1y9Xcs4JmzIk7eF2t3jHfLNlJFPJxJCZtc9r0cNLiwVlpdOAPlOKXZ4el9Y/EMbVsgBliq+3s6sCFrLXWS5Vqn+kysC3TYF4O8kxNQOKwJePvQyUQ69PEFlt2apGg0rcrHHCFipnDg7UL9CCE1Vs2TLf1+aWPLgSs53J2m4d6iD9+uK+ugptnyXgKjWxf9fmQ8Y7/n3vtS3aN37MUW0DyFr8ChHhM2SfzkVf1B7fl9vs+2jpToRbPOgIgBu5pfta9/Jo6h3ZKrMLaHXYopgzUdNKaZ0tCk8WSVpmXRaN4cpPoUaAaGXA0niMTbUz6BZOegIXW6s4L2FSFEIygSwKt8izHhBo80vmwPia738rn9Uz3QmoEtSmWD1UnT2MkNIYR1iKewcJsFg5Nl/s2KKgIi6s8vmMWZIuSwMMLNEnE8T31jfumo9krMwDbvaw2/C5nM0LUjLMGRZfASZZx686O7JgbnSfESbzCChubcxNYWWRYh9Ce2xReGAK8I2U4JR42yUE7Q0rxSVZmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(38100700002)(86362001)(52536014)(53546011)(6506007)(9686003)(71200400001)(122000001)(38070700005)(64756008)(4326008)(8676002)(55016003)(8936002)(33656002)(66476007)(66946007)(66556008)(66446008)(76116006)(5660300002)(7696005)(2906002)(508600001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cGUnNGVuU3FdKfW2wn+uhYN9LMXL5fmebEVT4GatC1AXVxm6HXV8HNDe2I8E?=
 =?us-ascii?Q?tLhny2ToX5V4dDH5ImwKp/fPE3iti8OS4RM0V1/5lvZ5nyHLwxSDHo83sMCG?=
 =?us-ascii?Q?wgh1rhTw2VHYaJz3PObPmnffkq2fdTArq92CEJXV1zMwGwNd2rHC/tsNysOD?=
 =?us-ascii?Q?jbLUdaXq++zO62OgbFxp1A1Ysep3/wQHqELkWzb05yTKP4wwKs4sCUQodm3+?=
 =?us-ascii?Q?QI54+Tu3yXtmGIbeGYMzkCabeKdcgufPKZML1010hraCIidQ4TmEic/KxvBg?=
 =?us-ascii?Q?rJ9fEzIqizFfAi9B0LYiAgkxn9Y8lTUID7BZu6QYXByZb1ktiIGQNJYUidGo?=
 =?us-ascii?Q?PpIDB4FU7STVNydh7HhtfkkBtA3ts3bhYaoN4HsZhtM0GFZ50qig44ATRQ2d?=
 =?us-ascii?Q?hXEW+vV8AMhA+3jVa+68/W/Q+QwUluIIhiiYaWHieRkxSF1veouXJVwQ+YVE?=
 =?us-ascii?Q?rcUjlyQ6N0Eaw+m+HTI/lnQ8a+uGN4qF3yO1bmbP6SAG165Wb7RyNkiuPDmR?=
 =?us-ascii?Q?Pu+qxs6g9qlz4vu+T7wXTDcMRemm3tRdMS4WDncEj5Siq9g5iSSHs3O81ZTF?=
 =?us-ascii?Q?0Wtmek1sUrL9xbGzv5lmCK+NkgOPM/MV2If13DCSwxhE+2JGT2nsILcN+T2a?=
 =?us-ascii?Q?BfBEFujdIJ4ey+bPuJlLpzBGC2ZDcd80fXFPHjIz5WZFcdf1mAc83+g0w+Q8?=
 =?us-ascii?Q?GRxES6/QknxtMVxZwvi9JI4cEK6344ao3F+TDSkhUuwcVmIwKdfvz5H+IZ4y?=
 =?us-ascii?Q?GNfVVa7u2jU8zyl1O+H9ykMrbgBhJ2LCFPqUbwZnIi0G7CQo73ito3JCRUwd?=
 =?us-ascii?Q?uVFNwvclU7onpnWsRml2QQ7zy1AqekMD+I7lSzHadU4NNjio5SQA6frWl14H?=
 =?us-ascii?Q?d0EDnudcIhZiLKkte3YdMeXAtTj9qwW1S5rWcF+Fvo944CAM185WVmbCxH4V?=
 =?us-ascii?Q?4R1kGX4jx1ydW59VkK+3sSs1WYGNI9iaPM9syT3v9yZLbfrJfLW4XxMPEAtx?=
 =?us-ascii?Q?kMtbw6ppuqzJYEXeG5X0XlgKMBSYc/n4wBzUtDLPPbanun5uR6TSTvRByCU/?=
 =?us-ascii?Q?VRQIsfCwuDV+WSKyo6hWT/tyL3xSc+MRbM2Khwy3mhLmjooKcS9zsY5Hb4al?=
 =?us-ascii?Q?U3lEJhgx1fCuR1F3ltVuRDOR9My4hWY0/UC/P87mcmi5CUhuCOQcV1s0+BDb?=
 =?us-ascii?Q?aZRN/ug9Iq1jnYbVwGVkEKrg5lLUCNCuJETBTD/VcdPxT5Pols5de4ZkEjzZ?=
 =?us-ascii?Q?96c8sXhXBMOldY6uXpef1PIGcVPRN1tt+z7GdjnsKPtw5diAxvVI0K0/c4p1?=
 =?us-ascii?Q?bkNIhka2glrFuHCgKIhOihKP6/pYhe8+FQhuHNWI4pcztOxcYmY6hFfxHsmC?=
 =?us-ascii?Q?6L4i6TGROWliNpH70r25y1Jc1I4bVHb8m0aOiRtm6RH8Q1AsWVO2iDkapLdV?=
 =?us-ascii?Q?ZkLQHXEZ33NBxdHTd4W62vttMQJGeroIdztZrPqzIfmBaxi56A4NYB9FzMBT?=
 =?us-ascii?Q?wTVR1TWlld57uE35hytapyGVlG1oruvqSeIeSPzVKT7bnl+Zz81ch322HDQV?=
 =?us-ascii?Q?BMP74RjYLBHUeXD0N0M2bXUpz9dzeXOO08HhgsWOUanWNJVzLPwSON7WKY7n?=
 =?us-ascii?Q?4s9a5vxfxrOBvtEnSrMm2T4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ba5c6d-efa4-4ffe-2a1b-08d9fb2e439e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 02:50:36.9892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GoVEhSWWQyIMxMejDbaeS0H9zV2UFzO/nzkSh0uIQJhKnpKXdmCnW0h7kltxN/UcC44/2XXq046CM1ChNc/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, March 1, 2022 6:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use IP versions in convert_tiling_flags_to_mod=
ifier()

Rather than checking the asic_type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 448e9b46417c..dd70c85b8205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -691,9 +691,9 @@ static int convert_tiling_flags_to_modifier(struct amdg=
pu_framebuffer *afb)
 			return -EINVAL;
 		}
=20
-		if (adev->asic_type >=3D CHIP_SIENNA_CICHLID)
+		if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0))
 			version =3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-		else if (adev->family =3D=3D AMDGPU_FAMILY_NV)
+		else if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
 			version =3D AMD_FMT_MOD_TILE_VER_GFX10;
 		else
 			version =3D AMD_FMT_MOD_TILE_VER_GFX9; @@ -787,7 +787,7 @@ static int c=
onvert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 				if (adev->family >=3D AMDGPU_FAMILY_NV) {
 					int extra_pipe =3D 0;
=20
-					if (adev->asic_type >=3D CHIP_SIENNA_CICHLID &&
+					if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0)) &&
 					    pipes =3D=3D packers && pipes > 1)
 						extra_pipe =3D 1;
=20
--
2.35.1

