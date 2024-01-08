Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18880C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 23:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B89910E344;
	Mon,  8 Jan 2024 23:36:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C1410E344
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 23:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX2yXcseX0IegH4mrgC4DzKDcvXG8nlH5juXt2rplTZBHMesjj9yWM1L2EITWkWvUuLs6H/VZPU26JV5rZlEd3NpxLImLinIX7POKvVj64rnIVJf5lF9KjJKeAiUou8ZqHLMJqy9zRlZe8Ehg27woJ9Q+t5enRiUopKrmfDS/3DFxu9KhyCB6Actp/S6XkQi9XVHJgJp1e7ncEoCGgCfWZtmf0kaptKVH5EbBHuwpOoAOV5FhjeZqBkC5AK86wYlDHg7mex7bdiJxgBjQRXCngfwqBRV1cpuFx2j4ZNjnJZbg34/37sPNVc3ERTdPqiixA+ruTFfp3ok8NaSa8HUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT8dFwF8CXGmHScZ7JXHKCDEtAW3nQOawofshPbGYXM=;
 b=eKnX172YqsQfh1Ef8/jZkJCh6rHF/2u/eSDsFkLzCg7/RWnQ8I4R6mq4ftcK2PLpEJb3ydBQnUECQTyxMEN/mpEA3acOpZ8Z+1u0K1qlZHf710PgpwFT5zzWdC0SfTqMiCAOGqUYt93GX6AwozGeEqAVSvOWm+nkr8GYtaRUwAMZdhgw4k0up82uCXRkzy5zI5NvMSPXtCNLe8vZDUGnFkxS/54nLkOidHngbdSVuZQ6L/FvSKVywzL7FV7HqqRCIyeou9TUR2SA8t2N+p4Lh0jbk1klqz+4OmSR8ZgeRIWH+lB5ASw+gGly5Ogts5U5hOW/q9XsO2gZzOfF8s9SNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT8dFwF8CXGmHScZ7JXHKCDEtAW3nQOawofshPbGYXM=;
 b=kNNCnAB0z8ty63tkEjdr4D2PVMTQe8EbdsZIaIbg6PxrhVa6M4uBhqeXE+V2b1ryh7ey80BjPhPo+epyTYS9l9iW3+LV4Kf5YkfbHxT5MWqtpx9Q1DiFiBOBFQEGM/1K8mE105Idj1dJ75OM2WBSCxFPt1kfobu1CYuih+hpsuA=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:36:26 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::3140:40fa:8279:f51c]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::3140:40fa:8279:f51c%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:36:25 +0000
From: "Chander, Vignesh" <Vignesh.Chander@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV
Thread-Topic: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV
Thread-Index: AQHaPaFn2W9ub0Uz9UCXiTo61HxreLDQm2TQ
Date: Mon, 8 Jan 2024 23:36:25 +0000
Message-ID: <DM4PR12MB5055D133B869BD584CAAA650EC6B2@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240102173013.5543-4-victorchengchi.lu@amd.com>
In-Reply-To: <20240102173013.5543-4-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6a98991-f7c0-47fa-9f18-2f20a049488d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T23:35:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|LV8PR12MB9112:EE_
x-ms-office365-filtering-correlation-id: ffc747ce-d8e0-4484-0f58-08dc10a2a178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ty9bRdIuJHQWBhWfhhAmXIERYAqoDzL7XVq0hKlnZ2Ro/rDcNAI0E/IMQG5QYzsYUth8t+qBGpdKVXJpXnyjWkYeTh3mJ/jSrxSVMu2WwNeh59U0ApTKvcHCg7MIRtLpHOT0MejkGkR9sEGXmC8INIKHG634fiM8VVE2Sztsp05k9loGyUFtrgzTh8yCf5d4ow4gCbVi272dndbcYP/uPL7MUAXs7coxbsO5oUdhFd5rrePZiLkNUC0THoO3dLupgWKrZG5qRq/N/4QenN23yhaH3GLzKJ7TyBX5hV/Az+tEoMsCNkGPMqVmzzpYSvM7tImWsUsAD10Z8JhjifmnGnZFRqMsE9MAk2vG+m4azO2YYda7YaKHxKAQI2DpBkSoI5CjE/OdaFsRtf+82xmpR8vTKYiAgiI0ptVSBXqPjsd0fVnnqOZAupOdN7rSlbVkuj2vujDYvoZnmeXM7O5IhkUtPxCiD1F0/ycWbU1n3mjYVDvAwiLPqpr9LDLPRPkEK6qef3UARGQwcFLnXDOBAsbAbph4kU3YUpDD6VjaG6T4XH0MK4jxwRwceNkW0fN9IdOyPw4cmLBYbWGaOY97FNJh/w+nFhjPrORw75MTotJ2aNB7TlKczc4WJlwUMGHk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(9686003)(55016003)(6506007)(53546011)(33656002)(83380400001)(8676002)(52536014)(316002)(66476007)(4326008)(66446008)(64756008)(76116006)(66946007)(478600001)(66556008)(71200400001)(8936002)(122000001)(110136005)(7696005)(86362001)(38100700002)(38070700009)(2906002)(5660300002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ElEeG4/ygdG/etzhjPlSQfdYB64nC93YUHTD8oIfuUTvdXFSnumaOQPHQtQ9?=
 =?us-ascii?Q?RYymz0hx+qbCJdaVodPY50D8ZKvuqzMWgzF+mqD3oB3XXWqPzt64LLxyQJ4+?=
 =?us-ascii?Q?crmr2JvoybmrDTLT/v0Ct8lEIHvkEWqxO8ThYzdUeCoYYJSQeznwe51TvrEb?=
 =?us-ascii?Q?D7IR9n1S+xSmHvpu8osmbjK7GvAabNjYcrRTTKjksCyV90HVrpZMTBnV8cLM?=
 =?us-ascii?Q?zMAuFsZSo37jCUOpkZtoXJt2v51kvncAtEPevCliRGpfPmknFIGJUGwx8R9U?=
 =?us-ascii?Q?9mgcGQLTDa6FhRJD466ggA937oUtc/8jnVrjxZls7Obz69aq3llP6zTHT1EI?=
 =?us-ascii?Q?NBKKJj+5XP89FYbepLeAj94b4cFxp4LfDJFV+dpLaJM1h80hXYJ45bfbYG9f?=
 =?us-ascii?Q?mHSm63YG/mdoMUAyQvHYYYdKFAebXd8d+NgqU3i3IxNt+bbiVWtV95Hrk2UC?=
 =?us-ascii?Q?i/AuMlPawzK5Y7skdQAScRTBdPJ5fTzUdBcpd9z8O7RdpRCEsxkVmqTMF6Cw?=
 =?us-ascii?Q?1MfoXdKg0nCPw3n95DB79GARH6f5a2JeiJkUB3xZ5CnPyCi4DP4Os1K1mPy3?=
 =?us-ascii?Q?3rALASiDcbkP/n6I0QV4fFOJPxDNjG2gIy/uwdB6hnh7ekfyOQfXXDR4VnsM?=
 =?us-ascii?Q?BFknrZfZvf0zkYcVTRQadu36bg0dqvhKQeBsd2etAAIrnSJxOgPOgyds2aCB?=
 =?us-ascii?Q?0UQyiN+DSHA+Bg5iHTpAvVrq/DCzddP/822LpDDScYP4rS0pbqkLtvHMKMSE?=
 =?us-ascii?Q?un3u0gDdKfSkM2ACBYv1EZjMgj9n1ukqLxVXxugWgNWJ3ZxBjybR1duPW+GI?=
 =?us-ascii?Q?2xM50tURleOiyA+ZkFqJww6OvQ80tLyBjrDzfr7TUK+Vk0IOcB6vi9vAD+ii?=
 =?us-ascii?Q?KfKAqWdbvNpL/5gQkyl33YEuB/W+SHxP0H70cdOQ7uCMi8askTDypIlSfgMu?=
 =?us-ascii?Q?5zXysx3ZyhN3GU14V13M226uEoQHFC98asy8EiBIYhmf1MTLpUeI4DVrlF6U?=
 =?us-ascii?Q?y+qgsn3P7eygjsIMoQihgwWedeVxDKs/pX3D0zdr2MlGX0O89HuhyrS5w9oO?=
 =?us-ascii?Q?D0ojBkPsL3ASIUSTbO76bU9VzC+6Tr1aWDWDusao64aS7BRb8d+gGWWJpH10?=
 =?us-ascii?Q?pgodAIu7VWsK+7RyTNfvKeGDPbsVMlyZmhtf3wfhLU0FDbJsJ7jERz11YeMO?=
 =?us-ascii?Q?R5ggirvwCEKpzvW/2bcO5J2LyZb17OBBJ1gvmeVq83de8jkNQ5OqmGcQwJZx?=
 =?us-ascii?Q?a3SP4bZzagVjuM47hMk3blDCBva8p2bpEthkZWcSBLdJrc0MlKyJPY9HpYv5?=
 =?us-ascii?Q?4lisPsePmrEb1u6pDG6F0QenykmNOuHKGaUq8vKfRQ1spBqBNsnPDJWjhEGL?=
 =?us-ascii?Q?8TArPnAAMj8aFlQtR3lTcIe+y7bwwV7q4gXhdWa2TKMWKZH1MAqJznqJJiLg?=
 =?us-ascii?Q?FagyAIqrnUInL05LzukjjNIIhKhR1b2iXls5Ad7JTHfGBJ+DY+uV7Clwr707?=
 =?us-ascii?Q?b+hRbn9w6OYJ7ud6RYMM2ZSYtIyeni8XGaRN9tP1zcnvw3MbnuYphIyQy/R2?=
 =?us-ascii?Q?hxgocjjDrtzAqCR2owk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc747ce-d8e0-4484-0f58-08dc10a2a178
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 23:36:25.8983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lI9Fs/D7mHLZSsv/yHf8vCbQWsDZ4omg+TUy5I8ykcZhxWgUzSkqXR4jKCtC4Uid7NZvyNtU4CNGM4qKLD23sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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
Cc: "Lu, Victor Cheng Chi \(Victor\)" <VictorChengChi.Lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Vignesh Chander <Vignesh.Chander@amd.com>

-----Original Message-----
From: Victor Lu <victorchengchi.lu@amd.com>
Sent: Tuesday, January 2, 2024 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chander, Vignesh <Vignesh.Chander@amd.com>; Lu, Victor Cheng Chi (Victo=
r) <VictorChengChi.Lu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV

VM_L2_CNTL* should not be programmed on driver unload under SRIOV.
These regs are skipped during SRIOV driver init.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..20e800bc0b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -454,10 +454,12 @@ static void gfxhub_v1_2_xcc_gart_disable(struct amdgp=
u_device *adev,
                WREG32_SOC15_RLC(GC, GET_INST(GC, j), regMC_VM_MX_L1_TLB_CN=
TL, tmp);

                /* Setup L2 cache */
-               tmp =3D RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL);
-               tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-               WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tmp);
-               WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0);
+               if (!amdgpu_sriov_vf(adev)) {
+                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_=
CNTL);
+                       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CA=
CHE, 0);
+                       WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tm=
p);
+                       WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0=
);
+               }
        }
 }

--
2.34.1

