Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6870C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 05:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A051139F2;
	Thu, 18 Apr 2024 05:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SX71b7SC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63481112D43
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 05:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnxp1QdAFblkBWoh8pU33WjlhLDjsP5EAWmEjl06uvg7eFnsQbSNCMXMqwr9eMmWaMeL2OvQV6G4IjbmyN80NE00YEmDvVibMFr2fhOqrqcnkubUCqA68rlpHA33gt3Cp0XiFMMPqqyKFWtCvVyB3Ft0F/Tdwe+NR4jIDuKt604E4ABWc5VUW+f/jRbH/114mDxjql9mI8PlHYhD7MVaBa8zU5mxcnWlmvmuRo2csT8QGsvjQ7Wi44ACWkVC025mHh2JHtthUeF41vnrUkcn6AMkcqyICsm1B7tvEAOGEYItaV18jUDvC2ivfdXmzzoYBM+GfVMVOhM21oX9oGZRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B/6IvpAipHfRbZdA1AIOfWCTF+C/U7F3jDcElT8fz4=;
 b=V/XhXJ75AfOIX2vcSKIMKFMzCyfpAd5xUkuPiKzmFLoeKxSBmqbWaWHyBzoDIlRjER2ivSla6U+WBLhjCugSSPIV9zJuZc0xYotCsa32YKgulrZn3xvVmEVBfStqIKfjzS5OwHQMV2PLe2iWjUgWuTKxeCDazaSK3xxM1CuOMFXcjqDlQtrm3SzFRBe6zyXMjoGeNtMBbgTK7hpEEnA1kr35cZvXu4Q5efcS+OrvOj3oLG1uTbxJE+o5sFEV4dN/6LOKJpvgw+4KQDx2Ui0tLjWEUWuSu/m9rZMh+rB0OR65yob1ViZ+yTRcFutuc+fRXUfPaLKLwixxTLLqrZm/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B/6IvpAipHfRbZdA1AIOfWCTF+C/U7F3jDcElT8fz4=;
 b=SX71b7SCAtFX81SNTq8ccEwQF4YKOCgjM2E0Fzp2vCWK+J1ZTaeUNcWuWGuHounOevDGFTA8W8w27J5i3EQRHkBlOuqHcyIrzNKtBNjqlna7RsIq/pE+wD6KpY/BWgBvXO39jA3TEP4V/8LKOgjrQXghGBPSDiGGD7k4Y/htKLc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 05:43:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 05:43:48 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: add if condition for smu v14.0.1
Thread-Topic: [PATCH] drm/amd/swsmu: add if condition for smu v14.0.1
Thread-Index: AQHakMYA3VfqyFkN+E2lFeT/BiV9xLFthNQg
Date: Thu, 18 Apr 2024 05:43:48 +0000
Message-ID: <CY5PR12MB6369BAE4DF1E7262D4BD0B09C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240417125132.306112-1-li.ma@amd.com>
In-Reply-To: <20240417125132.306112-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=125858a1-bf5f-4df0-b635-53a353bbb345;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T05:42:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: 731a79ec-0f25-4c54-3306-08dc5f6a8531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sb9X0S3UhxmrLGoWfbob+n4MqMgdpE+3nCGa08nG3HtxZuqBJ+Dd7XzgKYGw32FGqc4GxQgvY8Z7vH5gT2FzQnXDKGpqgY0wUAtRctRgCQ3mvEk65aGoCrAGUa2ug07gxyCjvSvNgoR5QFdI9wgsuFzjzCsxrt80tbpT3dVowslYNM/QEUgXNiS3cAY0IT64X48Q2LBYXz01MGkfMCQ0iocyphMZA+N/Guq6TOcXMvkACOA0rjVhsjx8EzV5Ds3KRLBUAiDHebf76Qat0OfnYf5KoepyDeGw9Pl4n5JrkIqXMtMOgDjmAjAJmg3GPKUFGve82hXl74MGqJvPdXC2lqLILf/Ok3y1CeHj9zhHkjIf6tqr/mXBxeItsXeP0viAwvhOcxtZ0WUm4rz6T/aI/+r+3Zeb83YEPEXNTciSViHzPiKVMWj4b2RD68aZtVxPK/PkbEy3HW+8tOVrgYMGfjgzxCJb2DVb5uMT9nEUaw12gV1m8Wdv8eqWIaQaI4K/B6kZd1dgJsPfu8C/fvWLlovhoi13rCzafBqRoRZ85hoJAodqbOJc3nMC4Mm9Hg280CXJQcni3EVcp6DM2Kf6zMcNNmzKEC5RIO+6+7SGMT74G44lQ+GJ7gXxPuVo8uI+MOoyfh+rIbfq7vGhB7gWq4m0u5RehTaJLHFA61jXqcg2oEY1gF+9wpGFgxwIsDxXhm1g78DO4y3EoWIisx0WbS9dMAd3e+HhZ46Djvr3jdQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YZD5iqqCpPOKyTfypuz7csPkmfolUxIPHp+3fHsQQOha/LonP1igdDtaKFFD?=
 =?us-ascii?Q?V1gnZigeJ2RQZ2KoYQMjaSsljmvMpbMn2NaxhbRBXxD9O+6OstODo1k09hXL?=
 =?us-ascii?Q?/IsWmD+3no+8KVZZhsFK5sx1X8Vt4qumerk43gs1nkdqjF9ZR7bmHsIHGu/a?=
 =?us-ascii?Q?2L0g5OuTaYa54g0bC4yn7t9S+yC+HW29NyZAfP3CY1TV1Ro+cqlpOy+mKCzC?=
 =?us-ascii?Q?k/yh/ohbjzKl69It6WD/CS/J/Vld63MnuVoJGZ2wKAPkTd06HyxzJWXq/+jq?=
 =?us-ascii?Q?lHlKkuD1RO4ozUJZPfLwdqDq211s5936KbdT/d8nyk7jl85kay1CD65AC/Jt?=
 =?us-ascii?Q?YwlGKGbzGvIbsmG0AsbWFBml01ES/jObzfwWADaMu4xUK7P1gZ3CzrTdW2ff?=
 =?us-ascii?Q?lucK9+Wg/zZWp9RC1XbRwoiyJ+I27wTIBl2J2cj2EJF+wczGazyciv1cruVj?=
 =?us-ascii?Q?X8GIQN51UxGIl2iLi4EkpNuDCHwF8OV5IvExcerKEMgrdxn63+fwQ7TbHPyA?=
 =?us-ascii?Q?PSO8A+myWSr8on3iZ3g/h3KhK17A75nvctEt0sgVov9BeCemXBxYmNzdkOHK?=
 =?us-ascii?Q?b9T+8OjhfuzxM7KH9GTnajT8SV2+M9zpYLa0UG1K7BfltdL8l9pGcZw6qaTB?=
 =?us-ascii?Q?30Bvuxu0MCgH3WEoYuHMitDo64nIIntSN5oMRreE/4Nq5rWjY3YniRUEyER0?=
 =?us-ascii?Q?qVtlt8MMuXrDlmrWxauqDunl5A7/pzBpLmwqxaZnsyw0sFY8B/zwyz+X5Uer?=
 =?us-ascii?Q?HRfqjCYYnaH9Mz4teUymMrE96Y7KArmc4ZJgayKp9T2Qpkk/Lb7eEjdWsdSL?=
 =?us-ascii?Q?H9PNvlZ54SQ7eYwxGqgNf9AvDP3xZ409N6HGmh1gk8W4RYxODPSTan3+YFr9?=
 =?us-ascii?Q?sL47ynyMVqhNxO2NlcSpBQAsf4XVBONjENRAlJ9Y5ALuJWMdkgqsOYL3jfKY?=
 =?us-ascii?Q?bAelMh0QKjJRM2T+oP+tW0VsZnjZKa2a4n6577zOJk4ai1BM4SEV1OuE5kpb?=
 =?us-ascii?Q?yLp0bxCKSSU5Mc/fv5wNp8EqyfTQ9MbVBtvCSJBakmj5QO4RFgN/Ow3q2ZDa?=
 =?us-ascii?Q?BgDEzD0dqIXobDaJLqcIFElvVq/R7Wi0CwBlWUgjMgYONy9OTs9dMGENEOTO?=
 =?us-ascii?Q?mfP1MfMOTXph8cNZT7caspIAq+LFFpzA+jdEND2neZ/qmyVO1il4kco3wCTV?=
 =?us-ascii?Q?aXEux59kcVn34ZkJQisIjBEOmVNey6VW++JnluAzpexdaSAnXB9P185/FvpZ?=
 =?us-ascii?Q?5Llg867w8Ju013t4kmzARDtKjMn/djuYbKGDGuh3f7ngFJqu7C65yUzX+L+h?=
 =?us-ascii?Q?gD7PH5Czsn5fnpFKsoSGsUCiansY5WW2c71OuauhENt0cqEio75uw1zTpUuS?=
 =?us-ascii?Q?U3+Zq5/XLoeWr9QfRtQqYYr5mAKs/PFVxFtK0xY8dvVoi5Cix50tptssck04?=
 =?us-ascii?Q?HmNfvkK/duThStuB4Ap0YlMI6gobqxCC3oV4nvuNO9DEvrVYZitCGy2vludF?=
 =?us-ascii?Q?XWakksbvMfeM5k7aqGsUhN1zO1k2x5PXpPhORlweNpK2PduE9zjVbvbPwhLR?=
 =?us-ascii?Q?jO+sUzv0Q4ecGDI2Cx0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731a79ec-0f25-4c54-3306-08dc5f6a8531
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 05:43:48.5422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRFECtA181jbpc57Ne34LzDJKcvD4zWrFv2O2wjdiRlTn8q7MtyBKD5ITYrS8g0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Wednesday, April 17, 2024 8:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@a=
md.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: add if condition for smu v14.0.1

smu v14.0.1 re-used smu v14.0.0

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 3bc9662fbd28..3ad3d20830fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -136,7 +136,7 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
                    1 & ~MP1_SMN_PUB_CTRL__LX3_RESET_MASK);

        for (i =3D 0; i < adev->usec_timeout; i++) {
-               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0))
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0) ||
+amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 1))
                        mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
                                                   (smnMP1_FIRMWARE_FLAGS_1=
4_0_0 & 0xffffffff));
                else
@@ -209,7 +209,7 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t mp1_fw_flags;

-       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 0=
))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 0=
) ||
+amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 1))
                mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
                                           (smnMP1_FIRMWARE_FLAGS_14_0_0 & =
0xffffffff));
        else
@@ -856,7 +856,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device=
 *adev,
                // TODO

                /* For MP1 SW irqs */
-               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0)) {
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0) ||
+amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 1)) {
                        val =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_C=
TRL_mp1_14_0_0);
                        val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, =
INT_MASK, 1);
                        WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_=
14_0_0, val); @@ -872,7 +872,7 @@ static int smu_v14_0_set_irq_state(struct=
 amdgpu_device *adev,
                // TODO

                /* For MP1 SW irqs */
-               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0)) {
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0) ||
+amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 1)) {
                        val =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_m=
p1_14_0_0);
                        val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0=
xFE);
                        val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID=
, 0);
--
2.25.1

