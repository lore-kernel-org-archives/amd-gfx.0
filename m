Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCCFEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 05:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477CD10E065;
	Fri, 21 Jul 2023 05:59:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8274C10E065
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 05:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA+ggW78JKDB8CWAq02Y4zIcBi7y8TDKbNp4mZGp2HRjFnOd64gQYCrsmgYhDWQ6judVly9UA1kziQ9jP9++dKgU0bpVHP7ZkUEwBL7IHgxHrsW6YSd7u2j+azQVcMscgcHBpq+Qapv1qLJxIuFo0e+glmFeyR/DTfsStjSLeLWRPXNPL4EoX53qgS7HckvkFnvoSZ5272GH4HEliBsY8C5IJ+Pnmp7eViqoo3I/iS4X76b9W5RZY0IaQfoZ6Rm1g5QwodC3uECCqDWCSZMFSiMwS49xbEpLKV1DFJUz3G+jiOA/HufUCWWbTzQkxuia5JmYW1hw+qcULfayd39Kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+DTw73Cw5vmBavkLkA+H1WSKdn0RWYoFTWm0nG6Eas=;
 b=mYuqUDx2LjcKQnglkESVHO/2r/hze3Fk0slzo3C1GwNUp84AkSNi+FPt+uf/uMi2yLk93cMVH4NgNBzWu11vZMmyYovIi4Za/rWamC23gAskzf6fGMCshWf9UkPiTy0U81kDfkcsdq/7jYrfD3s37pR1cuEWvW55RHVJjvE7TAI4oJvemRPK9p4oAbgvwPwZqOp43ZF0HCfiesh0JuFnHQN/nEwRd1a53dHoY5A8sYQsSQkm1y/lPU2yGjIyQEVfjNYGM9BgsuuYeFrw5EMidtaVcUned5PUo2p6Rk64rZykHG329zep4Kqf31CagnS1zAqjU/+djgE4A5xnrvCVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+DTw73Cw5vmBavkLkA+H1WSKdn0RWYoFTWm0nG6Eas=;
 b=ni89xd+QZ5SV4VRaCQW9AGv5j+QQ95etXdnnCPpxNnbbf/3x7uRrytnQXHqcCEJDYoqCcCuIpyzbDpNvSVnKFdda/Jfv99+j0SJsVN7Ol9YHbipqzp+6dJxLJnGyugB66J/Xjf3WhD1MrmYxtiq66KZmxSQMJx4cAh/im+RDWPg=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 21 Jul
 2023 05:59:24 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::1bb6:2726:5311:9c79]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::1bb6:2726:5311:9c79%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 05:59:24 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: load sdma ucode in the guest machine
Thread-Topic: [PATCH v3] drm/amdgpu: load sdma ucode in the guest machine
Thread-Index: AQHZuVIxqWetrnVBNk+MnMuGyB+5ra/DvekA
Date: Fri, 21 Jul 2023 05:59:24 +0000
Message-ID: <DM4PR12MB507284500A81ED8DEDA354E4E13FA@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230718083050.5417-1-YuanShang.Mao@amd.com>
In-Reply-To: <20230718083050.5417-1-YuanShang.Mao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=729d13a7-77cb-42b2-809e-2b44a8e7f7ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-21T05:57:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|MN6PR12MB8491:EE_
x-ms-office365-filtering-correlation-id: 87b1c2a8-6961-4435-2752-08db89afa2a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DluTdK1Hgy3E+NGpZ+5YL836cJ7BLxqV+ngpcGgpByHEpyHY+ZdgG11KkYURFL0Mwv4r8KYBPHAFu9X8oOkaSYQWEF0AV+UYMQ/1Wz8ZAgYLSkVWZS/47qNFdVMdqX8aZhI0VVd3SIk2OF1Zwtwln5p8kS5S/EwVkidwG4faHf1stwvRfNKrkDCzMNVG8vSBHNf//QepZpq39Ch65SSAqF1dmhqtnm0eNq61kSGNgWHX8uma1KvJ1k63J9JCBV8S4vZmtAECELADqmSGQUDVFcrGkQ0DLdjsP+c9uqR2jesff4NeNt4hBf2Jnbj0tWAP6K26jt9HBqtYH2QMkeVdj2O/wPdFH1oFBd8E++uoNd927MHso0NMHg3gTfhdsQqIzgMhXDzAC8o97EXP5hXsoINFxgPmjZhzYFineLlXhdcp3Qj883k1BBQM6CId5nYmGc1BFaSXAFFqSUicdUqsEdAIzjCo7FOyuv8Q35vFPL2LQOsH0m/rGpQ113BYBK4uEZXarBIbQYeWeXjsDciz0BEus8efmYFaGOY5FegWy9SsMrG2nnHAwvk3asL52VIc7d0Ucsa1MWiH3MoU7wxZkZid1QjTHu/1P6dYAg6WhrcFcTB3Zr5byx2xm1loYkz8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(8936002)(52536014)(316002)(8676002)(76116006)(41300700001)(110136005)(66446008)(66476007)(64756008)(2906002)(478600001)(9686003)(83380400001)(26005)(6506007)(7696005)(53546011)(186003)(66556008)(71200400001)(66946007)(38100700002)(55016003)(122000001)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a7SkYzRdMZf2tIj1zIi2wn0UfkGaqZ4Spbyehz8wEg9o+5R+wQoNSMCjp6yQ?=
 =?us-ascii?Q?A5fBk6upQApwgGBAqZJnQEyf01WLnu0f29q6spjZfCuZ2Cc0Set5sqRu6YzM?=
 =?us-ascii?Q?jnVuUeMWEU6iiQ8cQFudX3tWTl8Z/HzI9+oplnUAq8pg35z4s8y128U9PVjl?=
 =?us-ascii?Q?OV7cLwzU3TgHSxUfX5qXHvPxElMDMhRkmtui8G9GJMjOnoPPrsazfgPCg7go?=
 =?us-ascii?Q?eEquAMKo68PPB6LM0jEHqmPZ+955bp+iKtmQfpAv8IXud0N8+1PFt+fBXq88?=
 =?us-ascii?Q?SDshIgKcROBup6fzGozEriPXXKLU7fLsNa/+r8vabT+TY4m2C+dmFI2MSqwW?=
 =?us-ascii?Q?R9WKpLnRH3Ul4f/ilJKAkC/IHuCftTQgw41+Wj/bQpwEiA7dEgv/Cz9N/mid?=
 =?us-ascii?Q?FtdAlkfhdURLrQrt8jC0OxrG2ADSyrVgOODOUe0GnsVrd/oFNbcl0Zu9TaXu?=
 =?us-ascii?Q?AODEl+q1UQBwX/RNwqaCZN9FdAq6PTgipCg0HbzXd+ySJAAdt+NUqx4zvFKq?=
 =?us-ascii?Q?Uik9FVntl7P20gWlH+ZcUPnIdoDuzG9cO9sI8+9bWLHA8XajQkcRI8fr0OU0?=
 =?us-ascii?Q?NHQd+bUzlLMjp3qSIs3l7iAd/g1WaPeVNGYYYLaYttcL4yx1LnXNXsOyAGxu?=
 =?us-ascii?Q?0RcvS5Ef3ApMh23u4z1+I1BTC7teUacRljli/RnOqsXUvdD86MIyh0r32ap/?=
 =?us-ascii?Q?Ll5T7HIq+mmJf0L+ZwhTMoUbUIGi7M1rY77tAMea4NEqPnzyf+NYmqBD25mU?=
 =?us-ascii?Q?WhalszbtTRKVlp+zSWJHf4Z0e9vumD/mtQPRkgejV9lXYZOQMBJ+PaE0ZZHZ?=
 =?us-ascii?Q?PmPeV5mYkUIFe56brANEPNNdEU5NsOqIieE01P7bee8R/bu5eGutUmynKqR9?=
 =?us-ascii?Q?H9XeKTwJadvJDhgq+eCmDHeKXkQyiWnsLcXGlvAGFKvWjfDFWF9t1Xrt0fYx?=
 =?us-ascii?Q?BMZIKmCx1Ok2v3sLYEeP7GD2FGSNDKnXLRcYG6iznt4tDYC9M/d5RQmyafGo?=
 =?us-ascii?Q?48+b8FZU9dm0LDDysYWaAwp5cx5l613X87ladyXXaKyhFtkp/bbW6y2PLxeA?=
 =?us-ascii?Q?moop0zQjT3YSFD1SdywadMT0UIJ4dPOBQQf8+4oVuP4X3U3NQdCQKPIf+SaS?=
 =?us-ascii?Q?MZIHe+0KOogYgFPvcvayGo8ikFccAr1kQjknVOtIsGNNiupZWTuKxpwlNfnH?=
 =?us-ascii?Q?NroanyeIw4pF4JJazAD35saAiMfkRWFWrVth6O0Aj3hoRKeFQ02srGt5kcn7?=
 =?us-ascii?Q?M/mKnG0gVR58x8wzcybeOoZmE+UjaoeCJBHE6/DDKzFSR85FDENNqIJzGV+2?=
 =?us-ascii?Q?i9moU9kT6yZJKlk3n3wfdy5PlmAv06X1wA46sSC+50ikrkLYvahF6UYKZzXu?=
 =?us-ascii?Q?cuWUmmWzLDoenLFTTgg9QVjJx1O1oqTRCOVRhzCUH0tYghXaNLaa/j3EA+K+?=
 =?us-ascii?Q?WeDgonHKShOXN+BYzDIWKyUpLrbQ82L4DHnDKpCK64G0B1LbhdQK4mYg+DYp?=
 =?us-ascii?Q?xjB6WV1k3U4RcHp9aqfWIFN2AB0+G0d2yAFgVb3atWNioCNP2XoeNe/qxdJq?=
 =?us-ascii?Q?0XbJg/k7/oGJI0GvvhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b1c2a8-6961-4435-2752-08db89afa2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 05:59:24.3799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h29KFTgDrX6gIl42Ab38B3wLYT1VJLDVGQAqFUrysPpsQP9k9Oc9CTkTCUbIo9aT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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

Reviewed-By: Horace Chen <horace.chen@amd.com>


-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Tuesday, July 18, 2023 4:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; Chen, Horace <Horace.Che=
n@amd.com>; YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH v3] drm/amdgpu: load sdma ucode in the guest machine

[why]
User mode driver need to check the sdma ucode version to
see whether the sdma engine supports a new type of PM4 packet.
In SRIOV, sdma is loaded by the host. And, there is no way
to check the sdma ucode version of CHIP_NAVI12 and
CHIP_SIENNA_CICHLID of the host in the guest machine.

[how]
Load the sdma ucode for CHIP_NAVI12 and CHIP_SIENNA_CICHLID
in the guest machine.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  8 +++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index dacf281d2b21..e2b9392d7f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -239,9 +239,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *ad=
ev,
                               sizeof(struct amdgpu_sdma_instance));
        }

-       if (amdgpu_sriov_vf(adev))
-               return 0;
-
        DRM_DEBUG("psp_load =3D=3D '%s'\n",
                  adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP ? "tru=
e" : "false");

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 41aa853a07d2..3365fe04275a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -845,6 +845,17 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_devi=
ce *adev, uint32_t ucode_i
                        return false;
                else
                        return true;
+       case IP_VERSION(11, 0, 9):
+       case IP_VERSION(11, 0, 7):
+               /* black list for CHIP_NAVI12 and CHIP_SIENNA_CICHLID */
+               if (ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G
+                   || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNT=
L
+                   || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM=
_MEM
+                   || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM=
_MEM
+                   || ucode_id =3D=3D AMDGPU_UCODE_ID_SMC)
+                       return true;
+               else
+                       return false;
        case IP_VERSION(13, 0, 10):
                /* white list */
                if (ucode_id =3D=3D AMDGPU_UCODE_ID_CAP
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 5c4d4df9cf94..1cc34efb455b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -237,17 +237,15 @@ static void sdma_v5_0_init_golden_registers(struct am=
dgpu_device *adev)
 // emulation only, won't work on real chip
 // navi10 real chip need to use PSP to load firmware
 static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
-{      int ret, i;
-
-       if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP][0] =3D=
=3D IP_VERSION(5, 0, 5)))
-               return 0;
+{
+       int ret, i;

        for (i =3D 0; i < adev->sdma.num_instances; i++) {
                ret =3D amdgpu_sdma_init_microcode(adev, i, false);
                if (ret)
                        return ret;
        }
-
+
        return ret;
 }

--
2.25.1

