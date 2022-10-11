Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 03:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BED510E79C;
	Tue, 11 Oct 2022 03:56:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C0210E79C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 03:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvOCmMHg2KWb2+T79FZqiLs9MhJjlmTLEFznNbJM3i0XEOj35kgLtE87nIdT0MR3grt4TYJJ8CdaoN5XPkbRs1N0yTK27JceqK0CBTkJ4q4aytngkG37lCEO0ZCkJKyDyLaJ4ibpBi+b+iww9H7Uy7oJFNTpUx9GrfYPn6jpkid0D49WZ+xn8t3cV9b5GqXbSTqKrA+FL7mW4L2LdNbcxRgIERaks0Mni2Df1eDvHC8xiWHD7WkahkCZeDuchDVuY8G7nQ0ShmFtvLZ89fkzZxhIaWH1SucMue/0LQSQguECCVw8xrMhFTivua85KbjPpNcpnNlrMxh41btvtEUJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLxqV0k6pNWzl6to+eIDv4BUJz5tpGwlTA+uXeTlwow=;
 b=oefVQbyxWmMJkeiK5RBkZSMc76bDAr8wJt85B+xvU4qJjITRwe93ixosTqgjohvENN+Hx8+OxclE4eUUwAqlGlRLNy/f+BQ5FBpDkpBVA6rib+JqjRai+u6g2XeTvMhdX0rPsbKL+KL9qoSMIw1XjbC78UvfpH6Iw36IRAZlzzHq2V2wNZHpvOjUgROiE1eoVMV6bnXW75BbnSs4eg54WEg1acigVAcRTv++08iZ545LTW5oORhe6b0lDkOCRw+bC3CsWVpvrDTwM5bbE07TpY8JpvFqXNFNPB49dnuRskEslQw+HWia+wloMLzZfyb+2CttcZtQsG0WD8gJcxfC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLxqV0k6pNWzl6to+eIDv4BUJz5tpGwlTA+uXeTlwow=;
 b=J6F8aJv4z6dsfN4jHjAaenDWdAUI6HRjZi2t11R4hXpRuCzFsGcyIV1IAwZ3XhP3NHeJEtbYNEbye7L84hTj81Dc1mjYPf16BQXu7BAWCqQoW4vyBgJKLvXF7LR7kTbZV1vqUqYxyDDx9HkV9/uOSXXFyrqBMpaUGO7CDK0O9L4=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 03:56:22 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 03:56:22 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary condition check
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary condition check
Thread-Index: AQHY3SQlhCh9Jq5yh06zhsiRfYbqQK4IkHBA
Date: Tue, 11 Oct 2022 03:56:21 +0000
Message-ID: <DM4PR12MB5181A0589C746E32A009DA41EF239@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221011034622.6725-1-Hawking.Zhang@amd.com>
In-Reply-To: <20221011034622.6725-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=732d236c-9794-479e-a93f-61638a5c9da8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-11T03:55:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|PH7PR12MB5656:EE_
x-ms-office365-filtering-correlation-id: fcf96511-a1ca-48de-e5fe-08daab3c8f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utlpcIlP1LDcPghfCv/nZOOTsPbmonWkJgkeV5dn5atWZ6PplB2vYP9a0TKU4Lb0oEdvW29vwaWobXvEP+Y3CJAMJe31dsA4495pCtPHfTyLg582+p1EhUkpP/PctC0vvj4IycUMIc6r7ImqopiSEMlRsYDvdIAvxHZGuBs7FHbPVFEL5S+F01rVMX4T0kZAnGKxOypi11vZFJ/BpXyw3aCueXj8U6ZFGKqmD2V8hovr5Gup7bdq/9SrUkXgXDlhqBxh/z0/jVmUkrWPQgleP7WYTdayLc+Po21736PUB4zusRA2MVm8apsg17YwXmK1ZBYUrnYNPeRL/13Lu7eJzqpofciCucj8oA/JqgQrZDFCN31qZTmhAUF8P9aToJrRKKweBs8LoSK4DqJtazrOeObJ28a+jvwLD5EY8Q1ZxB6TA2QqxVHlU4O2Tml+7qUtQOggpvVG20Dh/mtEW7haoxzr1oOZ7VbrkNqoujxfkT+r7WgWJLvWsgDVMjPOVI2JsvxnxylsKEKRxPly06kmSZStDkRqxnDIVhO9rLMeGCOOT+154ZrE0tyiBVlpBOpuWmRmm03j53zTiIlm7iXUf86DQUyJ+ISog1DsLzkHzNh0MJPnHDgYSrgntWDTaTcqb/KIbR4B8hbaBQ4BesyDHpstSisMTsLaF5MlwFriT+KyovDNFlTuXcbx8W9uZvwO3/eSgkJxA+dm5++3LENnl9CgCFI/uTvPXvE9M2h3835iHmGLKPkCBS3SecKrrDy7i2WHXEQffREeSzxn9EeRXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(122000001)(33656002)(86362001)(478600001)(71200400001)(52536014)(53546011)(6506007)(7696005)(316002)(8936002)(38070700005)(6636002)(2906002)(5660300002)(110136005)(41300700001)(38100700002)(66476007)(66556008)(76116006)(66446008)(4326008)(8676002)(64756008)(55016003)(66946007)(26005)(186003)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?94rfA/9YZE2hEWvVnR01Oo57FmmnmUolApTn49dxLzz6DmGcSSxGSJ5sVCmV?=
 =?us-ascii?Q?Cs2wwCT/SYMA0YODgsV2SbxdhsdyTkCoRlA31Bs0NrShJW+Ak1Q7yiCPxw0o?=
 =?us-ascii?Q?9cir/Tf8/B2t21YgFErrJiKF1iXoZDKhiliBCXcUnBR/RLAJW4A0PpswNNuu?=
 =?us-ascii?Q?gqqPEt0aRC4vPNzWcSLSZspstH9H3a9QSzUG07IBhM15tHzxDUYvAyCif4cp?=
 =?us-ascii?Q?V+Xo/nr7ob8g8ieaW7y/iJIbXboyeqJEcjSCbzkF2uO5GN9ovwUfTsLncFXN?=
 =?us-ascii?Q?i+w+zENuVStjBb0mLPtrRezoN/SGHorCXg6FpUmwZLU7khfg02fH3gGt0km4?=
 =?us-ascii?Q?zLB9PTaFoyDJGjY+ANl6NcjCMp5B5b8u64oOXfkXWoYJlLJSMEgdCHaKTcR4?=
 =?us-ascii?Q?COgxWBJFoAgZxZYdLBPfONflj/j9KygsvA4IV6k0uzIX+Ah+0acqzcOQvlJs?=
 =?us-ascii?Q?o1yilrivOo1/OvnGVTQskkqeY/wVKc7g71FMWZwPGWQA0ueXtYNFsHOYLqtu?=
 =?us-ascii?Q?2Kin4w1/9Dz4Lo6Os8IexOnr/tZzQo0pdifWoS2BjZVzeUxv+S+UHnBPqI9k?=
 =?us-ascii?Q?TofVYBvtc/OmhgRLYU/jcLs7w6pEUkxZYtSJwa8rSoRezoVWcPUONp1zbmQG?=
 =?us-ascii?Q?6eqNzjekE+ZsxcESY+Sfyi6t0Jvd18bS/r7fEhnM7p1o1uyaZHW/Kieh8lhO?=
 =?us-ascii?Q?PTmkeR5D8vajYBtq5z++XL/z7FLpugrZ1nLLa/y/ZU25CG3r7A2gu6//DvWy?=
 =?us-ascii?Q?A2z4709wdbEeLTCcWkmnlamXRod+Z7+S8MVU+8I1cjn4hHO9t9y9roLgRrvW?=
 =?us-ascii?Q?TCSbt4aL927LCxqZk5tvTdhI4GT2GGhVO/1YZJ6vKYWazyE9DZiQio4RC6S1?=
 =?us-ascii?Q?T8csmqi0j0t1eBTBoCQd1BDnMOM0RInwk1Ttj9rsdbNE1WlRVHKMa6lRP1GZ?=
 =?us-ascii?Q?e5wPBGxqnsFfZO5+UkJg5GYSfYhhRPXP/t2RTMaTo0VAkBWWYugnWqLd2h3g?=
 =?us-ascii?Q?oAmaeU47uzzxXnaAjF82iOW0xEhgL5Zo77muDdQhXIEmAXIr/joeCtm4yraD?=
 =?us-ascii?Q?F5vYDZecC7/wl1oMPuAV3E+HdD2sStrs6ZEQdxWGc9Ut013wssSGnQgEMe2i?=
 =?us-ascii?Q?iQvbzM+Aim7RqyyFQA8wILJ8Yo9G/vE+TQNYBeTMuYULqQLZp4rKPHhyJgnz?=
 =?us-ascii?Q?rexqYGpr9ZAnupJjEtsXmKuYoRi8GKps/YLDUZhl/o+zBBeFy2ft65LE2dh2?=
 =?us-ascii?Q?DWw/1VuDv2ZdCHzuZsrTw0vK4Efrm2n7oapATgbZndpDTBV3JGG8O8uJYIEK?=
 =?us-ascii?Q?vtGYKxJS4r7PZG5QsBX16B/l6l3i2DYsR8jF9D7DlMVoKunZPxzVx3dHICvZ?=
 =?us-ascii?Q?gJOFmjhq6ofqYc8VjVN8xDOQEH3LmdpGNDInYJNqKP2jGgvy6Ym0DQWcNQ4e?=
 =?us-ascii?Q?qHkJnAvGfzVyY7n4dD0UE0EozyLOftWHlOGtCJo5juxspXwjbh7jEWHIQasj?=
 =?us-ascii?Q?DkLfpXAlHRdz1rQMgx2ReMB8PY+Mnk73tNdrfT7gqn4xzEiX2AZDBTqHYbQ8?=
 =?us-ascii?Q?tmI8iGlX09kbq/RlKko=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf96511-a1ca-48de-e5fe-08daab3c8f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 03:56:22.0036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2Ke3ivnyHXU4onCCyfEDgjz4u9D4FHR4m/YcESnmicfntAWju+QnjrQwGAjNq/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Tuesday, October 11, 2022 11:46 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary condition check

version_minor>=3D0 is always true.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 012b72d00e04..128b65f500fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -526,13 +526,12 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_devic=
e *adev,
        if (version_major =3D=3D 2 && version_minor =3D=3D 1)
                adev->gfx.rlc.is_rlc_v2_1 =3D true;

-       if (version_minor >=3D 0) {
-               err =3D amdgpu_gfx_rlc_init_microcode_v2_0(adev);
-               if (err) {
-                       dev_err(adev->dev, "fail to init rlc v2_0 microcode=
\n");
-                       return err;
-               }
+       err =3D amdgpu_gfx_rlc_init_microcode_v2_0(adev);
+       if (err) {
+               dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
+               return err;
        }
+
        if (version_minor >=3D 1)
                amdgpu_gfx_rlc_init_microcode_v2_1(adev);
        if (version_minor >=3D 2)
--
2.17.1

