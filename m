Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DD1C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 08:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8CB10E1FF;
	Tue, 18 Mar 2025 08:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VU+j3K6x";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6A810E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7LtRkTMEDO/+yhIR/zAhSDwfee8IA7s8zN+7WMHpW3Y9jFm2nJTxm1msPMJV5Om3N1NujYO2lvXh1Kyhc8dCjobOfGo+9WwQZsB3CFQIt2MtDRdsz88xnXwgzvDciKSQsO5rRdCu6KLVaDtNyYOGRmZPiC1V3CXjjKsR6qdhnQ8YDdfBKxKAlTqLxOyppqQY3GJiiXV6DVlp+1m4nj+XbhXZm+q2h5xINWO47J0uFRXM1K7aHi59TYnVhcVpGhN8PZH/Y/5slX7u8zcF6GLDdWiOlXrvWOJ5JQQ/eMMYej2+8g1ojXsvfcvDppLpM+EH5cVGIZcxwDG7W1J0nyaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF/BU2lfaIJ0iUh4evlPu59dsPxzZqabmlgsgMqSLzI=;
 b=ywBB+ljDlRYnnQf/6zlUG07Ge8/iO4FeA248mtBgfjrglVsMYsWC/uPQx0C63lwHOzNj+4SOziXOro2RWZ+37fxM4RjbMM+hKvsUoF849lmTR/IeKnYw+JKh0SzjgBs2BW704wAQHRiKp7iOmjSd5AGIQ9l7r4oAENuGZNtntGd28nNg/cNcjYWFd6UfJhLZ9TdTvFC4NMNRt3wa98YcLO3+H6GlWTpqQUyljWSnOmnPPK3opMWFSLhjDpl+DF5FG0WRo/ef9yediuOb8xsIfiL/M1/7oaAPJURXUNGieQmJSmMdogohLHF1VbvAAkMr3iHeyjXUffWucp7UaweHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF/BU2lfaIJ0iUh4evlPu59dsPxzZqabmlgsgMqSLzI=;
 b=VU+j3K6x/MUubaqoDSRtbVBIF/QDVD94moeAySnRHKIuPpE6UcWWPeT8QX8YhyZN7ANXAZd+UZKg0Zv6lYD4rOm67/ONCwQliQeE1Gv+B/v0fo/L04r4PNXdxXfOe87nIRksHlKiuh0xu0hznluAsK8sPvZeCkAH3HxxlrFkw+A=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:05:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:05:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chander, Vignesh" <Vignesh.Chander@amd.com>, "Rehman, Ahmad"
 <Ahmad.Rehman@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
Thread-Topic: [PATCH] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
Thread-Index: AQHbl7jg+jy2qIKkZkaK3wB3DVpw87N4iILg
Date: Tue, 18 Mar 2025 08:05:22 +0000
Message-ID: <DM4PR12MB5152B617CE8136469F6F11D0E3DE2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250318034933.115123-1-Ahmad.Rehman@amd.com>
In-Reply-To: <20250318034933.115123-1-Ahmad.Rehman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7aa38616-64ff-46a2-865e-3e7b5612c26e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-18T08:01:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 8ddf47fe-fa97-46b9-7086-08dd65f3a1fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?07xivJqTGehXmGx5UFbUbuhoOYeEh4Klphf5kbpgJeQ3hjEdWRWualJgQGcR?=
 =?us-ascii?Q?34RkcH8FjKqnoHUBIYfBzAKBnA+UvVjp+WTgV7AB+lAdL3q2VE+lunTYRHex?=
 =?us-ascii?Q?Lz82FicMJYmqJMR0aaHHRjPabHSFpnYxyU8m2snsNPl7vdkfVm4hOW65ym4r?=
 =?us-ascii?Q?p66zkYeI4PJ/IAIonja6mJ9MRkdbAXlIbUHA3yUXDNJKdl3D0Tnp2WKa++sL?=
 =?us-ascii?Q?onlZtipM5a/xINk3+eFWh630c9px2V4/R0pPc5YrBFDWXH+UWMk9tp+1gEjn?=
 =?us-ascii?Q?UvGBpC8CQsE+vuQrTAFFCwlO7ZJ+CI/e93hFjARw+4ECphiyw2VKx0qKY9dr?=
 =?us-ascii?Q?pVR3QPcw6KyBrf1s2gGsgu5EDTUew0glIWZtieVmX8YTZ6ag1dRO/Qq1dzgt?=
 =?us-ascii?Q?mOvSPbx2i/GvXJ6N96vXhRk0npvxI82PRs8B19J0rzYzAOqZPN/pMYS/4rlr?=
 =?us-ascii?Q?5SxHIoiRT3aLuA3rGWiBZm0gJg1FXCmK1r2inGNWFtLxp+20yBnTMaadNqrC?=
 =?us-ascii?Q?YvdGO5KtsX+B/63zZi7fL7URwlIrRagjcOrgqOy3qnPyCNdtSFE3MqDJf/kj?=
 =?us-ascii?Q?8nDwVkTTl3WU07EO6AUlMfcGqOlh6BSkkfRDOX4Q3hOoa/IfZuUvbNqyFKyY?=
 =?us-ascii?Q?hJf5E6wUv3ENfkO3BgVYuYfNw6ng8R+TfrGAqWyXC2NwJVSUQcJN3OsKozAH?=
 =?us-ascii?Q?YwNa5Gd+ubRvU+Qa5zzzKtmcNeshJs5Prxb0gOxdgPw5psXgu8xSARXol+9v?=
 =?us-ascii?Q?rXHKK8P79V6VkKisGXjSr18IOdWnwTuwpKqDsG/Jp97iMuAg64e3l1p3XJDK?=
 =?us-ascii?Q?874bZK5Rrvdue9zbxdWMliwW96DHmKeaQ6lPAfNcIbv+3KFG2YkBzCKFYhip?=
 =?us-ascii?Q?NtoI1HPxN78nuwbwyR7bU/1Z9QkofkiNjmQglboV2Z7z1jmTDq/Ty/HwGm2V?=
 =?us-ascii?Q?fCUi2LXCz7PYbe23VxIFgRoBvCAwBAYy2p5myrqUWLmjyF3Qck9LCadlNuv8?=
 =?us-ascii?Q?oMOZv6jU/dDpN05VBT82QOseQ7HbWORUy4aOQ4vyjXatB66j3OU3S/YiOx49?=
 =?us-ascii?Q?X76tTGOVAaIj3uzMY+MMeUZ2pQwDLpEL6TErT8opxz0QFYJI3lboCmImpd3r?=
 =?us-ascii?Q?uak6TU+CGivYeYoF7nBLLHGXrJgNSJ3J4FQkn+Y+/kTpGIoUE+NLn3SdCPyZ?=
 =?us-ascii?Q?/YhmT6bPvV8dHHoqkO01+V5+cbqoEiAg8VRdRdUzHSwuolO+Fhm3AQzyfMmk?=
 =?us-ascii?Q?BbnG3bzwrK94J+ftnCKAEeRDwmAxl3WStxkuoa+CKTr6IMYKIdDvua4bY0A6?=
 =?us-ascii?Q?Clml62BE1XJ149gMKVSzWgG3QdTWaZkEWw7GgrJjJysyjmrBupS279dRoEZ2?=
 =?us-ascii?Q?Kp0VBri64poReSeh0MoHIOVbUa3mUR200WPB94fM2n60+IlGNaHVyeZrpnWs?=
 =?us-ascii?Q?RRUxWvnGd76NCqGLACkpE8XRa0xnkMuG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?133MJpPuU8fzi8f490qiKVmsBv1MVUe7TRplrGTxavUn/c0+yMXxDIQeGq3t?=
 =?us-ascii?Q?lhF7WVHVJrrYFb3FjwWLlveX3MyY4MhTJ3aH9Vtgf+Tddd7VGX7Hwvv83eYU?=
 =?us-ascii?Q?3u8mtTPwZds386/HTZOj2MOriYlWOdZngNkFELv+fm7subij3Lm5KngGforB?=
 =?us-ascii?Q?TOAPIK5IgFdR2iWNO2wBeuVBCvWzMACFjd9iCIgHLkKXJyAvw+ASpnXxXfES?=
 =?us-ascii?Q?2eHPskmyv7VSIUC9Vx7GiMwy96qZhfBXUOwWdvX1oCL36zBeWJcC/LopdjaH?=
 =?us-ascii?Q?mDuQFqcHkyt+9p3gLmTSkL5XJ60NMXKEt7fIGl4AcFBlVmtU2LnCdGrXKmyZ?=
 =?us-ascii?Q?EFB/x59EF4wTRE7c90uLVQC+ZsXx1qRiUh9Y20QIhB/JOHdd4AZE5UYkdwJ0?=
 =?us-ascii?Q?TBHqsElkB6tHz9EDcVDFJE5oKPZZ0G7rMFH6qW4u0/y/2qwifaAnUEdqlfy7?=
 =?us-ascii?Q?kwU1S0bvpo4d9I7sUd6CdWf1bZDszGA20KCLpcCgNAlzBv73tkFW7WosN5sc?=
 =?us-ascii?Q?yO+eBWnsiNdOsdNJEpS8ew/bABspHvGEeLDpISfHAHrCSuWrnQ9hR4Ooql8f?=
 =?us-ascii?Q?2G47q/5dop+2iuHoHomyVGUm5u1BUr48tSH2CpKqghYgNITzRXMrEJ1XwHwl?=
 =?us-ascii?Q?ja2sQj0/z+TPNmwn6vsnwkIJNn3gTj4M1/7y5gL4cqs5waFAq16k1GVCk0lu?=
 =?us-ascii?Q?KP8gEDyotvxu6v72F3zJRms+99kdolOWoVf1Tdo8FvL825h1UX1CX23GZnsZ?=
 =?us-ascii?Q?P2cLfVVxKcmA+Rl1/ZiFwCtlbt96K8jxksSUdrLJsdX40cfhuDQS1pOsOMyK?=
 =?us-ascii?Q?28ak5npFqDh63zUhhVwA1ndhTHC5li91I2xqsohP3aqsCO4frpAaMCRGbtFn?=
 =?us-ascii?Q?zQbmBcZDWq9Z6G3Sq3RHZrlWz3mAV/gZ+epz0MC93/0ZZ0Qw/b160x+hzVTR?=
 =?us-ascii?Q?7GsPNIkpL0xhreyughl+xZ92Dhvrb+UtGiPYk8CwKubUjVaRR8ZGrWHKLwNy?=
 =?us-ascii?Q?GwbezQGkRBOApPg9TQMeSHR4yrbHPG0AUgugxhouLETr95zv654fyoHhlc6P?=
 =?us-ascii?Q?jHgmRnHczMGGlsMCpGovLDFO2Cwmbay9o1SFIayS6EiYHzv/RjgllJQN+qQJ?=
 =?us-ascii?Q?BpoTBxFXUJCrLC1zByvdhk4kjii0b+Ytl+Jv2hbST/xWenuf5bi06bKK9Lwc?=
 =?us-ascii?Q?a/Niu7MI/f5hzPpk3rb6+EXDRLOS72RAmJz8bLqaLV6jGrWeN5GOzbNuof1E?=
 =?us-ascii?Q?OVcai7ksRDnnCuV3LOmD70UoiAVNCppgIcPDypRyIhbm/IzfpCOp+Du48pE+?=
 =?us-ascii?Q?MuArXQeKBcD8SQEnwlCRxmh2009Gn0LJB/NkffjeeklfSaZBcVQ+7si+rC0T?=
 =?us-ascii?Q?8qj6mUuwLef6OVXyd6lOWrI7X5H3w/260n0cpf12E7aPggreQWsC2M+24faC?=
 =?us-ascii?Q?hjoOojOsk5fs6jAkw8LzUvXIq4xdFxcRsJIbsSrZ+TKldHYhRCKh6nRa7NmN?=
 =?us-ascii?Q?13xQv1paF6V6OoCDi1M/FpJOnTs1EBC3UVWMxhxYgk47X/EjmNEW0SPXZVnP?=
 =?us-ascii?Q?JIOmewx4QfBx9mVo46Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddf47fe-fa97-46b9-7086-08dd65f3a1fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 08:05:22.5150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OC/xCoPWOw3nTxH3+5gPGxNEmjkkSM7MCLsKjeM+qALUGivJwf1gVLbjneDC57h3EGE3x8qTqH2hYdHklnl8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

[AMD Official Use Only - AMD Internal Distribution Only]

In the reset queue, the check for sriov already exists.

static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t inst=
ance_id)
{
 ...
        if (amdgpu_sriov_vf(adev))
                return -EINVAL;


Thank
Jesse


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ahmad Re=
hman
Sent: Tuesday, March 18, 2025 11:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chander, Vignesh <Vignesh.Chander@amd.com>; Rehman, Ahmad <Ahmad.Rehman=
@amd.com>
Subject: [PATCH] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV

For SRIOV, skip the SDMA queue reset and return error. The engine/queue res=
et failure will trigger FLR in the sequence.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fd34dc138081..5b2d4ca92c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1666,6 +1666,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_rin=
g *ring, unsigned int vmid)  {
        struct amdgpu_device *adev =3D ring->adev;
        u32 id =3D GET_INST(SDMA0, ring->me);
+
+       /* Return error for SRIOV will result in FLR */
+       if (amdgpu_sriov_vf(adev))
+               return -EINVAL;
+
        return amdgpu_sdma_reset_engine(adev, id, true);  }

--
2.34.1

