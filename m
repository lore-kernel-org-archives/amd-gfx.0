Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAED2CD68F1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 06:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7842310E317;
	Tue, 10 Oct 2023 06:42:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE82410E317
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 06:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyg9ssBYoUsSicPtzzrxV3SNwotlIj4mozDR4uo5nFFcT63OOyYsU27wtpJ2rhda1TbFAUI4/KrudIYYMeUCgBjR55hTe/e+lJhaTWm3SlymKX3g1AIGsD+l/ay8ZugKEuQN0O2b+Hg/AHeQYHsTzwrda7Tb5q0un64ioSgCdni+hIzQK+BM/swCMDM+zCaLEwrVqzve33aSWa0dyL+Llysosm0OJgLpcjihrjwAM31+sAjZszcVlDnLFM+E3tOgwebMr9Fi43FVhmfL9ibZcqXzdSr9pzsA5ohW0zeRZl/LCoLfDEEWAbq9M1zq50z+mBID7fveKqFFoMfWq2VDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5kkbYCay4Xi3fQGN3zYkoSWDx02e9e6wjlhNzUEARk=;
 b=DMplgO5jw/P8fB4HEr4RIxHOVtOuCJFhg4N/cq9tnvPS2Qhnkuh6bXnNXmHsq7GgJIZaDltD0oWGeFSGfQgB7Aj0RNSDmrcHWWE2/avDyS/WUJeBN+W0cEimTA8dwgt5DvgSLtXHXjSbS+0+D6BrfeL5u3xiPEnywiI2cq4U9uQ9J4Po9znlyINocLaYnOlrkTXqN+f45BNR+rE6jeYhx7lt5Qvq2qCTdgutKPBkBv1WyiyUSRI8y+n7n8LyBcF5To5FHtk+pmJRH8MrVl2TASttUo9fCGnmpYA8aiwh/Gwtz1pGv8wPW1QQ1IsVHpi+o9fy4knpO9a9tUEw1Lk2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5kkbYCay4Xi3fQGN3zYkoSWDx02e9e6wjlhNzUEARk=;
 b=FGZy1yEJ53C79yM0uf1m8yBXHeJl2vSVe/ukkB9qJ9nzDXUTpLGO8FSNKxxASdkS+mrOpwV99x4H4Yi2n6w9obJl1+lFmh2Kb7NtPp/xqGrrzLOpvRlHI4SosCa2v5B8M4koI9Esgv2oKhJd7+VfyDhhCWmjqOJrhEo1UsQ/BfE=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 06:41:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:41:57 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Topic: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Index: AQHZ+zUQMe7CTb/kAEuDw6eCVSAk+7BCe3fQgAAWr4CAAACIkA==
Date: Tue, 10 Oct 2023 06:41:57 +0000
Message-ID: <CY5PR12MB6369AE4E32016634071E6110C1CDA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231010044637.3211216-1-Tim.Huang@amd.com>
 <CY5PR12MB6369E34EA2E32E802309309DC1CDA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BY5PR12MB3873406458CB02C0F2BE9A8CF6CDA@BY5PR12MB3873.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB3873406458CB02C0F2BE9A8CF6CDA@BY5PR12MB3873.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=926efb18-cbd6-4b00-ba32-46bfd43f94bd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-10T06:39:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB6869:EE_
x-ms-office365-filtering-correlation-id: e9d6870f-d2fe-43d8-d36b-08dbc95bffe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfSL4mXmwmiOYsYo6K5UHF866yrISusECJaFn9mxbEIXmBX4tMn3rEgViZZQTbrEb1586ENLtbV9q45M4rCsP8MtLK12fVaFsrxqWSdJUtlWbWQBnTAeUL7kW4WPaAGA1JSBotLJbx3CFurAlscKaDcShIBBfIaOebP3bdm8FKBAkuRVx290Yt2gm7J/L0E3rSoFIeDhyzluWawtbE8+uobretPE2405MkjXlkDGyJTygcx2PAR3FnYOfweeYfA5aWAuVW//QNGpgjl4R0LYysiD2ZdJaWV0UrVQwtW6ov3J9kxPW7RL0IVtrVtB/HwPQ81e1EuumQ/y7jkZqWnmNyUhJG3Od5Wy81jXLy78v8n2uMtMl3VPUr5/dPgGiR+LIjeavN//+NI1Chp09D++CYXNJ1Ae+cYkHfZ5gXp7YYRRAEwfKeR63hYkrEaFMzOzKVC4qP1PolWWe521wC+YbTFxCDMt/Fth6O6pYtSH9/rbfiD/SL65TAVoL7dwtYCaWTKjTtFbwRPchc9DUioi5yhTkWLYP4BE7WtVllcTh51fN0wvSYs3PV8via3ooPaSQGXbbirAaXJgc39qr5lA8CXgoTrGj/bYOhI9ICgAVP16Et7eUSmwztgDb3ZbUMe0aTS35ermc4V7FFt5c9qllWPmN9G0HxbiyqzGQSxt/GM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(71200400001)(8936002)(316002)(64756008)(83380400001)(26005)(110136005)(66556008)(66476007)(8676002)(76116006)(66946007)(66446008)(5660300002)(7696005)(6506007)(4326008)(41300700001)(53546011)(52536014)(9686003)(2906002)(478600001)(33656002)(38100700002)(86362001)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4/C4Rmex+EXogEuT/272Ifs95kVLguwor8eJwmDOQl5b49TT5Gp3k7FolPDE?=
 =?us-ascii?Q?1oFqoDTYgy59/Jxpe7BFq3puyCcu/f+UjvsazOe/npUPvzFVieyWhKi6Lryn?=
 =?us-ascii?Q?b1Zeeh3bwrQPx2niAs5j3Y43SixXMu2iiBRiZ6Q4e+F6uyXX6nwu0jNWvdUo?=
 =?us-ascii?Q?whuErCQFucyEUk26Ph4PbmyiO3oIM0H5Gnj4amlp3IqjEWPGfccmtfv0sJnm?=
 =?us-ascii?Q?1+9WXzi6H0zGAYxjFm6K/R+r/yUZNZQ4QHKWeAPLNSpnrNEEiMeSml2N6oia?=
 =?us-ascii?Q?VyKkdNAl/Dc1Blcwiheep43y3v/SJzL3gqIaSKyP2Jr1Lk8a1o3mrx2qHyke?=
 =?us-ascii?Q?sJwM70VITV1VD6XBu04gLZrCqYwHkWe7kzhybdkWY9LFqSrb1ApjjgpkqojV?=
 =?us-ascii?Q?szcWJXypGcyUSER5RKnHVgN7CGd3egw9VZDV+stC/bt0PYZkNaF34tpwMFOK?=
 =?us-ascii?Q?mgWxFxjOdkfaThEEb53hu//V8Ngo+WjhZLuCY5YrXAmzxOZ67bmOQO1mUjDi?=
 =?us-ascii?Q?kVjOE65CWTG+TJTIm9ANiIx9pERC8MdWhHzHR1OJaKzoC6wf419iFiEKPBiU?=
 =?us-ascii?Q?OPeoQ3OeBNah501PtblVq3luk0i1B59JHhD0xneCsUlLGJ3i8GosuagD0Cu9?=
 =?us-ascii?Q?UbLI5+V5MWiiPMvof7bWj38bma/YjV1k1lb5GF3HPZhxNZTubeLFYfVpOXN+?=
 =?us-ascii?Q?shgrPG1ZgOmvbl8jC5b0ihkgsQB0aT6aUM4jwwADYrJXcQPDGn1lxfqBDIzK?=
 =?us-ascii?Q?o0G7ZwDLp+7YS8fY7VPIdXB1Q8KZp6mnQWWxQRNn62W6EyoGBDL5gi9XwbiE?=
 =?us-ascii?Q?pHA+vNW3D6AZurJ//96YbH31GRTmj7C2Qg+4vazfEhf/vWZkW72dZH4KCJ7H?=
 =?us-ascii?Q?XwgbWfCsGLJKNUsnESjnfV9bIks8ij+7L+0d26ilpXNZfIF2AlTIHSxSf6fY?=
 =?us-ascii?Q?xuV1drRNaFRh/zYtARCdYB3wKbSo32Z7ybKQaO+o7/MVfgKlNWZqVW3NhUA3?=
 =?us-ascii?Q?PlKG5j2FpJVqzNmloDRKtYO+QY7Wh4aRMuShsun/Ecy7PwuLsTumvH37rjgs?=
 =?us-ascii?Q?wn9BRPjsY2wF1VhrMgqrtdpvlNg09NfDpC0q49vzmj4ipUTj+jW4PFicigL9?=
 =?us-ascii?Q?e5EWE/XwYEwkIUzTWJakPFZQdCYpYSVKFYalGWJ6EGbwyg9jhyHPhZW2kPbh?=
 =?us-ascii?Q?gHirjFOcpXTIQHPuY209qTPaNL2eEQgFNl/+X/OpoHYdF/btppvBss/HIZT3?=
 =?us-ascii?Q?965g6cKM9GZ0sBhUCQ9KMZLjIDWc/peIya0NdYlw1peM+L9Wr7lg6Q4zjl6a?=
 =?us-ascii?Q?MlXTo6kHK4FwWKDPm/SZMLfOJhgOSk7qubvuxhLTH0Vh54ELiWZZH8sho9r3?=
 =?us-ascii?Q?nIDdzqdcTvfFH1odO10g8VmO59D7kjFDt0VD1x4pr3i5FbFffmdyAH47O7qk?=
 =?us-ascii?Q?NTsrJZ0j3ii6jz9JYLUORGZQud5jz83okLH3WLZ2IaRoeKbiRzMeoVFJXgG5?=
 =?us-ascii?Q?MFVJ/r0GJNj7OcBxGoknLAyjq8zrq5go5sn8nMlHGLF+Jxe9KrqzZ+h1fcYv?=
 =?us-ascii?Q?2aFGkCTJY2LtBz5verc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d6870f-d2fe-43d8-d36b-08dbc95bffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 06:41:57.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BzIyWAhey/g4TkEW20978JIemi7Z5KGfqCtZy7T6BfZtMOYzOCSPKg9sIew1Qwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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

[Public]

Thanks for clarification.  This patch is

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, October 10, 2023 2:38 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu co=
mmand

[AMD Official Use Only - General]

Hi Yifan,


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, October 10, 2023 1:31 PM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu co=
mmand

[AMD Official Use Only - General]

> I'm wondering why it is "without waiting" in the first place ? It doesn't=
 make sense to continue driver loading if power up GFX fails. Can we apply =
the change regardless of load types ?

The "without waiting" is only for ASIC bringing up. Because of some reason,=
 the SMU can't response to driver in the GFX powerup stage if use FW backdo=
or loading, It may hang the system if driver try to read the status of the =
SMU. So, drive will wait a regular time to let SMU powerup the GFX but not =
by polling the response of the command.

Keep this "without waiting" for FW backdoor loading, maybe new ASICs bringi=
ng up need it as well. It will never be used for the normal case (AMDGPU_FW=
_LOAD_PSP).


Best Regards,
Tim Huang



-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, October 10, 2023 12:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu comman=
d

Wait for completion of sending the EnableGfxImu message when using the PSP =
FW loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8dc683c02a7d..bcb7ab9d2221 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -82,6 +82,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000  #define PCIE=
_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE

+#define ENABLE_IMU_ARG_GFXOFF_ENABLE           1
+
 static const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};

 const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5}; @@ -2301,11 +230=
3,17 @@ int smu_v13_0_baco_exit(struct smu_context *smu)  int smu_v13_0_set=
_gfx_power_up_by_imu(struct smu_context *smu)  {
        uint16_t index;
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableG=
fxImu,
+                                                      ENABLE_IMU_ARG_GFXOF=
F_ENABLE, NULL);
+       }

        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                               SMU_MSG_EnableGfxImu);
-       /* Param 1 to tell PMFW to enable GFXOFF feature */
-       return smu_cmn_send_msg_without_waiting(smu, index, 1);
+       return smu_cmn_send_msg_without_waiting(smu, index,
+
+ ENABLE_IMU_ARG_GFXOFF_ENABLE);
 }

 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
--
2.39.2



