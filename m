Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53703C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 05:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB15110E0FE;
	Mon,  6 Nov 2023 05:11:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA3F10E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 05:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5mghocQXRIYIJg/MZfr6/V9QJO0Bj1UCuyXncLBl85o5efk6NLSC8/wE6ASa+BFilc7OrBVrutU+Y2nO83er1vRfAuCW8oTy2rA2M12XOd8O5BKP7JGvp7JTGZSUdOlaj+C2orPaZi3OINQHq0G1SWbjvT9g0wgkuMrQLj7nAbobuecnr1KKISEq3cfgMFV+KfJ6fuucqUV/32fRlcS56uEt9ls4HHZE4xj7knnadGflpUyBvhRcQYtOxopkbjk//LDbXyRpXFtxCX4pUYLUWFR8sw/h9Ke6F6yARZJAWucPmVBI/T/XpqbjuXMtnpRB1FTFcP7vfCNy8eDYNwXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0faQURabM6vvFW+n+OqqfHn50m8kD14pZtXLTo1uBXs=;
 b=n3EwVdfQBriBHyKQWzdfq3ZD2Hkotx5NCBQjiwqljyh02YOJJSlSe8xVPPOCoWsiTjnrNrXsu1Scuy3HdQdZMNqEMyzDkJxzsxo69ZIpd+fMbsQjtPixzuGhgixkHLg3qKxROUyWs8cj2xTHM8vos98K1+5JPeTgo6xK5KfWP6pwP/VrfiRITCuNlxoYgOCTeok1et0jZ5q8Zx8z+ZgK/LXOfs7xNUuiSi7OWnvzBmUW6dtrvKZZIxrnDCDiejKZ0e0HDqwnK2AzynSDN7dYvlzeQLf49USBvWPXSOdJYrK5vdqLuZZbTHuu3XhzUm/U+WGnJjKqQCPzfO+toco3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0faQURabM6vvFW+n+OqqfHn50m8kD14pZtXLTo1uBXs=;
 b=5Qvo/nfURhEZxkaldn2okI9epv8Sa+OohQUWi6N1b4MNHR23VyI8xOfzmVWj/6HZzSNYbFMcGZXx1EMXA6YaZ1uVBR0iCWuk3aa27EXVInOmduE2+FzNIDmHJIOeXNEiPA3RUfo2qxc+uQyW+lpofuvl/wqOC+Dz0z/e4oa2EKE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:10:59 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 05:10:59 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: Move some functions to smu_v13_0.c as
 generic code
Thread-Topic: [PATCH v2] drm/amd/pm: Move some functions to smu_v13_0.c as
 generic code
Thread-Index: AQHaEFTk6rEU3g3tk0K31aOo8kPIGrBsvky9
Date: Mon, 6 Nov 2023 05:10:58 +0000
Message-ID: <PH7PR12MB599781F87DA574AC77BE081082AAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231106015914.3426076-1-Jun.Ma2@amd.com>
In-Reply-To: <20231106015914.3426076-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-06T05:09:55.6682953Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7611:EE_
x-ms-office365-filtering-correlation-id: ae6cbdd6-395d-4820-c2a0-08dbde86c322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKlWqqc47TMQ9DQAfQfxdfJ+KQCOj3dTDsQnzk2gtyKJX4x6IBFDNmx9zlbVdnnJ+zO2aymio4esMivhuVejtMpeqZ4WnxKLkELRnszKoaalZzqxtqgWUSBCWEnTgWgciF4R4MX1lF2R1Pp5rkEn5d1LHHiz5BkWk28x+v/HObYaIDS7wrrxyOaPr/VO3JWArehDm4utNsUjLZQ74p2pA31FHGlsvmWiTwBjnQqO4LBdkuUWK4RA7CtKYm0enZ0MCwU1GtbNdnWSga84MaauWuHYYTTZqsG56wVuO4dEJMjAi0l23pGPsH9ERXiuHGLhrnBdyA6pp8oW45CVr8zZPtw8pfkjY6NMsvG9il9LGr4vBLYNNREKoZhpirF6dByl8L9UbzD2rB3t935eHHPnsT96r4YTqZ8VulbronBe87wcxz/f+nnLl5rxMihmt/zUKyw8fm1sxnbppdnJDAtNXq6SGm3/+0qXcUer7kHNtvNUBn07tjEzBO7YDEyqaOsCMyKHZ4UWspuz83fKp6sa8y0+wDW5ic26NgP/R8Q0gNfn3O9N1Fhf+BQrMbpySHYuAgi3EJroeQtkrT1nlwzcpBKJgE+s+B1OL0Wd6KtIr9olSKyaKiww89sAszLqoUlya1Itj1hSEyh6rQW+23eAhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(316002)(38100700002)(122000001)(53546011)(71200400001)(478600001)(6506007)(7696005)(110136005)(66556008)(66946007)(66476007)(64756008)(26005)(9686003)(6636002)(66446008)(76116006)(2906002)(8676002)(5660300002)(33656002)(41300700001)(52536014)(86362001)(4326008)(8936002)(38070700009)(55016003)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3KpzRF8n8QiIJRJKPQJ4GzKhF8xrUIF58ob+VSURaVrx+4gsJhL+76n1JikY?=
 =?us-ascii?Q?HqniGT3zUSHq7yGpBy94BOEx3oi/DjEDhXkYpPP3UYJ9B6TyL4prcRwNnvCF?=
 =?us-ascii?Q?BxOYS1mq+RwMNuF7VhVD6vFMB+lkEaovxhZSKoXO5w40v1PhCVe254x+CFEk?=
 =?us-ascii?Q?vxTbr0MgUA6F8QhyaCoXNHuXwtD1nG8C12tAZCe3w9QgmWLQEQDHpPg6lonG?=
 =?us-ascii?Q?YBzmNvAPMWIa2cTcyVOjW8ZP2/KQBoZ9xjLlOqexQWyc4OWTgNuF+3aCKCFx?=
 =?us-ascii?Q?0JwWeCDKQl8LHgSCKLBRMfZc2VDJP06BX/WWuhBFcR33kK0Gm+OuYRQ7Xp4o?=
 =?us-ascii?Q?szksMNQqgQdSLel0SoBzkovYR3Vcrf2j3Cre1v+Q2irXgrf/4DKAMhxIQX88?=
 =?us-ascii?Q?cF+qZorNYxI3+3o3ibiGG+HfHFZmyKIwk+DqIztcnwrG2Kid0ZgLwzXXkBc4?=
 =?us-ascii?Q?uSnyNfzlMJWxLkcFj58xr4V/zqbdHM/zwmdd7O7qqR0b9Xi9ww7wrhqLT8P5?=
 =?us-ascii?Q?SO4bcXAmTF76IMHeT3/vwoSGSbH9eiGFIHrEbFWRPKaaT2Q27wG14oSUZhNv?=
 =?us-ascii?Q?GBu9TiYYLm0Jlq+YCytJhsrYiH3BNfqRxSuSGh8RGbfVUmyXBp7krZI7btcM?=
 =?us-ascii?Q?UkxmRlPu0xvuXM8KZrR3XrJfKz/dHJCnoUv6CffLB6dEG0Ia9DB++fG74QB9?=
 =?us-ascii?Q?SF3/I+NNQzsBkcHAVg3jE7ahRh3X0RntIp1/5rdunLWrA539+EsyjzOaaKwS?=
 =?us-ascii?Q?PCQA9mUDzfH1I4qr0LqVCUtblF0kYWL8piMcZuFiMF67qEdM48T8sGNaDdU5?=
 =?us-ascii?Q?tA5i2ZsSeEDLe5ZYzvulrtYAqCtdAAh92u1vPlVbvD1MYo9v4OFwvCIDJP9y?=
 =?us-ascii?Q?Cr2mf8SIwCAmexPiPRDvgOVe+3bzwklgp7zOz8rd3uYoU84FTYvjvxYr0OSE?=
 =?us-ascii?Q?Czo/m20UcCur8Ehu87cC19g/8cCLF5eEYwNa6kZBzkMrz/2BGkQTkd0VjytI?=
 =?us-ascii?Q?jGhYKnVsdIhKCZUpO+b+nQy+rSIVNefUY4yb/XuTFOeqzPSq+L7NS3XZoerP?=
 =?us-ascii?Q?I7AoxV9eWJ3hoBE+4BplVmT8QNqirM4nKLiakHh0JTg2tssWIs/Yi71ncPps?=
 =?us-ascii?Q?8P9C+wsHBdnDkKery0q+kEwwVstUdZbyuI6ahT4c52glqHyXRNBeTeu2CdhO?=
 =?us-ascii?Q?FdbDkKENa4nRduhSV4q7yvZ3WzA4z5PFeZyIbUwP1moTAmTOyNLzthAt3gAI?=
 =?us-ascii?Q?cuQoYu8yN/q7tzbj3/Bc8ZmwYNx3bnbnj4RqXjn4rgRfB//nEZnuVf8Bp0u7?=
 =?us-ascii?Q?VQJham5mmXZ05ra+gMucKqsd32xfB4+NIVpHqpzMvKU3Fbzj6MfjKEbNH6D9?=
 =?us-ascii?Q?uA5ayM3Yspfy/VZ9nXBYCOntcnA6KEzxHGM3xCGyhixUOVlk8x4CHz23SYRr?=
 =?us-ascii?Q?oALBSwftzUp0Z/PFras1Avck4zi2vlsm73579R0Ik1pQsvAjM4pMintZFWk8?=
 =?us-ascii?Q?vGUG32tE+w2nGilDmLbgYd5ck0Z+Srx9Ni/YzArBvvr0+Yo6vqxkzIkNi5Fy?=
 =?us-ascii?Q?iYVrQHfDUYerbnysqYAJYO0g1MIo6VR/9+zfluyP?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB599781F87DA574AC77BE081082AAAPH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6cbdd6-395d-4820-c2a0-08dbde86c322
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:10:58.3363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4+sc84BkQDex36c4cGJH5tVXZHKJNS+wi8OKu5Rhp63bNCvUDkVoWWp+YGhhXTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB599781F87DA574AC77BE081082AAAPH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Monday, November 6, 2023 09:59
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Feng, Ke=
nneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amd/pm: Move some functions to smu_v13_0.c as gener=
ic code

Use generic functions and remove the duplicate code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 38 ++++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 36 +-----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 36 +-----------------
 3 files changed, 32 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 281c3cb707a5..438fd5d3ede2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *sm=
u,

 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-       int ret =3D 0;
-
-       ret =3D smu_v13_0_baco_set_state(smu,
-                                      SMU_BACO_STATE_ENTER);
-       if (ret)
-               return ret;
+       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret;

-       msleep(10);
+       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+               return smu_v13_0_baco_set_armd3_sequence(smu,
+                               (smu_baco->maco_support && amdgpu_runtime_p=
m !=3D 1) ?
+                                       BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+       } else {
+               ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER)=
;
+               if (!ret)
+                       usleep_range(10000, 11000);

-       return ret;
+               return ret;
+       }
 }

 int smu_v13_0_baco_exit(struct smu_context *smu)
 {
-       return smu_v13_0_baco_set_state(smu,
-                                       SMU_BACO_STATE_EXIT);
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret;
+
+       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+               /* Wait for PMFW handling for the Dstate change */
+               usleep_range(10000, 11000);
+               ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULP=
S);
+       } else {
+               ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+       }
+
+       if (!ret)
+               adev->gfx.is_poweron =3D false;
+
+       return ret;
 }

 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a94b57e7c509..9be41a2b8659 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2558,38 +2558,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
                                                NULL);
 }

-static int smu_v13_0_0_baco_enter(struct smu_context *smu)
-{
-       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-       struct amdgpu_device *adev =3D smu->adev;
-
-       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-               return smu_v13_0_baco_set_armd3_sequence(smu,
-                               (smu_baco->maco_support && amdgpu_runtime_p=
m !=3D 1) ?
-                                       BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-       else
-               return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_0_baco_exit(struct smu_context *smu)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int ret;
-
-       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-               /* Wait for PMFW handling for the Dstate change */
-               usleep_range(10000, 11000);
-               ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULP=
S);
-       } else {
-               ret =3D smu_v13_0_baco_exit(smu);
-       }
-
-       if (!ret)
-               adev->gfx.is_poweron =3D false;
-
-       return ret;
-}
-
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
@@ -3036,8 +3004,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
         .baco_is_support =3D smu_v13_0_baco_is_support,
         .baco_get_state =3D smu_v13_0_baco_get_state,
         .baco_set_state =3D smu_v13_0_baco_set_state,
-       .baco_enter =3D smu_v13_0_0_baco_enter,
-       .baco_exit =3D smu_v13_0_0_baco_exit,
+       .baco_enter =3D smu_v13_0_baco_enter,
+       .baco_exit =3D smu_v13_0_baco_exit,
         .mode1_reset_is_support =3D smu_v13_0_0_is_mode1_reset_supported,
         .mode1_reset =3D smu_v13_0_0_mode1_reset,
         .mode2_reset =3D smu_v13_0_0_mode2_reset,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81eafed76045..f5596f031d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,
         return ret;
 }

-static int smu_v13_0_7_baco_enter(struct smu_context *smu)
-{
-       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-       struct amdgpu_device *adev =3D smu->adev;
-
-       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-               return smu_v13_0_baco_set_armd3_sequence(smu,
-                               (smu_baco->maco_support && amdgpu_runtime_p=
m !=3D 1) ?
-                                       BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-       else
-               return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_7_baco_exit(struct smu_context *smu)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int ret;
-
-       if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-               /* Wait for PMFW handling for the Dstate change */
-               usleep_range(10000, 11000);
-               ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULP=
S);
-       } else {
-               ret =3D smu_v13_0_baco_exit(smu);
-       }
-
-       if (!ret)
-               adev->gfx.is_poweron =3D false;
-
-       return ret;
-}
-
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
@@ -2628,8 +2596,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
         .baco_is_support =3D smu_v13_0_baco_is_support,
         .baco_get_state =3D smu_v13_0_baco_get_state,
         .baco_set_state =3D smu_v13_0_baco_set_state,
-       .baco_enter =3D smu_v13_0_7_baco_enter,
-       .baco_exit =3D smu_v13_0_7_baco_exit,
+       .baco_enter =3D smu_v13_0_baco_enter,
+       .baco_exit =3D smu_v13_0_baco_exit,
         .mode1_reset_is_support =3D smu_v13_0_7_is_mode1_reset_supported,
         .mode1_reset =3D smu_v13_0_mode1_reset,
         .set_mp1_state =3D smu_v13_0_7_set_mp1_state,
--
2.34.1


--_000_PH7PR12MB599781F87DA574AC77BE081082AAAPH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;<br>
<b>Sent:</b> Monday, November 6, 2023 09:59<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt=
;<br>
<b>Cc:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: Move some functions to smu_v13_0.c a=
s generic code
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use generic functions and remove the duplicate cod=
e<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 38 +++=
+++++++++++-----<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp; | 36 +------------=
-----<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp; | 36 +------------=
-----<br>
&nbsp;3 files changed, 32 insertions(+), 78 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 281c3cb707a5..438fd5d3ede2 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *sm=
u,<br>
&nbsp;<br>
&nbsp;int smu_v13_0_baco_enter(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_baco_set_state(smu,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_BACO_STATE_ENTER);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D=
 &amp;smu-&gt;smu_baco;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v13_0_baco_set_armd3_sequence(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_baco-&gt;maco_support &amp;&amp; amdgp=
u_runtime_pm !=3D 1) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; BACO_SEQ_BAMACO : BACO_SEQ_BACO);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usleep_range(100=
00, 11000);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v13_0_baco_exit(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v13_0_baco_set_state(smu,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU_BACO_STATE_EXIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Wait for PMFW handling for the Dstate change */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(10000, 11000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.is_poweron =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index a94b57e7c509..9be41a2b8659 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2558,38 +2558,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v13_0_0_baco_enter(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D=
 &amp;smu-&gt;smu_baco;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v13_0_baco_set_armd3_sequence(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_baco-&gt;maco_support &amp;&amp; amdgp=
u_runtime_pm !=3D 1) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; BACO_SEQ_BAMACO : BACO_SEQ_BACO);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v13_0_baco_enter(smu);<br>
-}<br>
-<br>
-static int smu_v13_0_0_baco_exit(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Wait for PMFW handling for the Dstate change */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(10000, 11000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_exit(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.is_poweron =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *=
smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
@@ -3036,8 +3004,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v=
13_0_baco_is_support,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v1=
3_0_baco_get_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
3_0_baco_set_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_0_baco_ente=
r,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_0_baco_exit,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_baco_enter,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_baco_exit,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =
=3D smu_v13_0_0_is_mode1_reset_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0=
_0_mode1_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D smu_v13_0=
_0_mode2_reset,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 81eafed76045..f5596f031d00 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v13_0_7_baco_enter(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D=
 &amp;smu-&gt;smu_baco;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v13_0_baco_set_armd3_sequence(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_baco-&gt;maco_support &amp;&amp; amdgp=
u_runtime_pm !=3D 1) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; BACO_SEQ_BAMACO : BACO_SEQ_BACO);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v13_0_baco_enter(smu);<br>
-}<br>
-<br>
-static int smu_v13_0_7_baco_exit(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_runpm &amp;&amp; smu_=
cmn_is_audio_func_enabled(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Wait for PMFW handling for the Dstate change */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(10000, 11000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_baco_exit(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.is_poweron =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *=
smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
@@ -2628,8 +2596,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v=
13_0_baco_is_support,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v1=
3_0_baco_get_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
3_0_baco_set_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_7_baco_ente=
r,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_7_baco_exit,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_baco_enter,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_baco_exit,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =
=3D smu_v13_0_7_is_mode1_reset_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0=
_mode1_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_v13=
_0_7_set_mp1_state,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB599781F87DA574AC77BE081082AAAPH7PR12MB5997namp_--
