Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A42E77173
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Dec 2024 14:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BD910E070;
	Sun,  8 Dec 2024 14:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHgCiSOh";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A8410E070
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Dec 2024 14:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz/6nZQ1vcPk6RyKM3uT55YKAL2Ma5+W/WTBMGDRT0jGuBztOcw8wk0O1pLtgG8CjhkA0nsQ13Wx5uR1ECdGit60k5UYDGmGNeNCCa94Fn3nKQpRDNRNOuBBnRzbL4y8EU/25BcMu1qQq1+sGMQtsrbU1751ehwPAphS70ygpT0si/9rBAQQqt7Jp8jq1HwCPh3fwtdP+rIoSeEu35X0OxPgtVasF/aqM5ZXJhLvmkG0sGa+j74pdZ/ncC6WIfGR6Dcq+wTHrlgA3voqhE2s3ee/yE5RkhiykSxI+nkmcsV94hgAgx9rlDPNqPclOHE937TD12Erv4boumXg5+DWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjXwhBscKgfR8qvk5S7yRyelcn1DAKgEIBdxjpvwmmI=;
 b=sQaCCXU5Ptj58UbyiVbi7nvxXlajnjf1sDB1Mbngn4PBFRhmegxyJt9brYxyDY2RA9iMGo5z3cBRmeG0JIc2XcsXbbxfe7uWaEhZU8xKlkhoQjtgYedueG6rgYaazP3mgFO1QMwgM1lxW65pE9APidg85fzGLh3yBDwuiZCgmILfPMUCEGEcCxE9/laFvvg5beH97OUzsCxLKo1TzF4cApCDW0e7ip805JucObEs51JV3LdnKAg14Fqvq4m9gj+Rnb4N+572PQC/Lci74GSz/IUwoIRCGDgNfBK+JyGLdJrvxPvZE4Qpr6K84VBcZjszYg/YWlEsfqVMBkD+8JiZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjXwhBscKgfR8qvk5S7yRyelcn1DAKgEIBdxjpvwmmI=;
 b=cHgCiSOhqQ6AC6nl8k95sODohVKYQFmHZS6BagGj3XKONSq6my1qggjdPxZltW/33Ubgzl0ykpURNCZqSfi+6uZ0LeVrRREj/zzUDR7ernDgxL8YZZpngI3rf3cEzVvAPzReKcZTAEfq+9Amh7ZUzrmtFSMITMfNSH1P3E6o/H8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Sun, 8 Dec
 2024 14:27:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 14:27:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Revert state if force level fails
Thread-Topic: [PATCH] drm/amd/pm: Revert state if force level fails
Thread-Index: AQHbR97UagDyn7966E6IFFYUjE3cLrLcatUQ
Date: Sun, 8 Dec 2024 14:27:36 +0000
Message-ID: <PH7PR12MB599716DCD314E0CE3748197D82332@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241206125955.3516880-1-lijo.lazar@amd.com>
In-Reply-To: <20241206125955.3516880-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=12b21c21-4d74-40bb-8e45-5b5773a4ed2e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-08T14:27:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB7293:EE_
x-ms-office365-filtering-correlation-id: ee192e86-a338-4569-1ea1-08dd17947629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RssX92EAZyJQpVei+aXAM02R2GBNnpjPVSq2K/NTQ0NveWUIPfzFkYHwQ2v3?=
 =?us-ascii?Q?PsWt61Mw4LQz2lvuQImaFTO29kbViMcVFSce1fjEikgoS40dC/EoBTJtpqt7?=
 =?us-ascii?Q?qB0qWUk1slU5MGGAAzO/7assqEAzRWpfi+NWw8VElZOoxgCPpM/N1Z2ABgx2?=
 =?us-ascii?Q?1xsZqSHZLZtAreeNNx0G7h8sJakAzn4IzExuyDGB/zHf6pO19/dTj/paBxj5?=
 =?us-ascii?Q?joX5KfM2jbC4odLN8K7yX0M+umxUuaIL1wVDgtaYRyOOXrRQVx0pLr5BOuCn?=
 =?us-ascii?Q?c0kl+5JXBoxGS6IsL4LDjE6EqAocuboAyADEnA78KNpM6rr3DErjJTEfn3Vj?=
 =?us-ascii?Q?hTvGeBogH3iEnqAYdZDPDdUhCmamvfpHhTXvAd23K+v7K5uw3osAqoGoQjf5?=
 =?us-ascii?Q?8ZEg6yLKmrnRSbUBxO6fKHEli8S9mhOHcv1lloBMmrk3KRhlxRkIHVl9/RZT?=
 =?us-ascii?Q?iColmwsMwYtcdcO1Dt3aJpxivZtJbCzCzQzVDa9x3mJVCKK/YarpYRnkxrkX?=
 =?us-ascii?Q?+2SzouIUXSJSjfec7VswXFundUxHhP6FyrS1gK3KOY3c0nbSFn1UkIS3ZAIM?=
 =?us-ascii?Q?3QHoryNM3EBPs8M1khz5BrN8/sLmHP2Vm6/Sz7MMGsuBd72kn4AW6HyzLIXR?=
 =?us-ascii?Q?czivziaqS3bFKZITQ9Z2e6PlKkJbqYHbU2npWDR13ZJhri/SWxZcSV8vRoVD?=
 =?us-ascii?Q?M0n6sHD5mGMFTUANKpokIF+69vrZaIGceeuLCKfvksTZie1OuVjte6PLEWqj?=
 =?us-ascii?Q?hqbQ7CDLaapqCWLQOiDzOHZbpcfZ0ub9X19arlPtaE2gV+bWWMJkgZlSY2U1?=
 =?us-ascii?Q?Igs2mNCpvuCOQq+bn0fQXMkYF4ZQ7F1Nnxf7wTRIppEIfARjuhwEQZezVSO5?=
 =?us-ascii?Q?TzOO6BBpGZgIxtfdq7hpACVtJOXYsU9w/MjGLk8ipKEIAAyELg5WyTXv5ZrF?=
 =?us-ascii?Q?CkwrKS5nl3PgCdyGn38rB/XGadrbyXI8RPm+MceeSWA8pqGFSz6eBD/HfpX8?=
 =?us-ascii?Q?n7MYfEhAUR7tIaAza21+04zWg55tC+NyhyxdeHw9NrzxvM86v1jjuCNKbp2S?=
 =?us-ascii?Q?OZhaxHhCdiI8UF/JGZqzXXeprVUrWFn0YS+a49Z35tWkVqmqyhyPkKmbBr6w?=
 =?us-ascii?Q?fSj/vz+/c6jzGtxEDyQsdOjTdtnpX44m3eU7BBzMTe1Ktl7NkcguY/sRIw2Y?=
 =?us-ascii?Q?EPshxcvAxExnbKwRaNM8/NlUocNW9bPRzyt+qaJxjZ90JjIbZd+TSfeL61a8?=
 =?us-ascii?Q?gMvn74GxPCCrKQWdyFYC2qLvgyNgxNSf3aV6yEw7BdbxmRyxgZVNjGsRAWH2?=
 =?us-ascii?Q?lbKBcAORurMQawDeD4GLBqasc3ZjUqYmCDNXfvAqZhd9oXEtnuV6qHUSJpL4?=
 =?us-ascii?Q?3/KLjZvH+9iwLoUe3Yw7ce2KyPAkMRmkS8sk6DExYHb22oVQwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aZftLmicpSbCVl6MjcKA4eE+6u5LpMX0z552HexY8T4HvFjwaEI8gImQhrF6?=
 =?us-ascii?Q?pd3PnB2F6YUqb7oLGUr9mJ3fQl6jMf8BqmRDVNuH9lP4UVP9LgVnpqOxacRV?=
 =?us-ascii?Q?AcGmvVCY5nB1M9xuNAp73SCOAVq1edeAs06iUx16XAz6oTbROuefdfzE4rAY?=
 =?us-ascii?Q?5ntAii9WVjKslqN1w1Ob0enYu0uLgXRfixRbfntVgzqnZ0faJwrM1PJsUJPt?=
 =?us-ascii?Q?5jObljRq6zTKhNVMvvuxa4TKV5vMnuHNRyFMjfwyhkqwI36I3rJSR600l35W?=
 =?us-ascii?Q?S/cE0ltLvghFNs5HbDDB4F8K/eaj8tsq+pQM0zhJLL8YLqgrTtL8/utUhvV1?=
 =?us-ascii?Q?xkZNCQ5pVdOI21RiFSTgU3ISU/hnVDpfM3E0zosM4FGQhgJILSFQWp0jcawP?=
 =?us-ascii?Q?EV36DH/xjn8zIBAYJ/izYM45MMkWsDv9am+oLurzy+xzRmWQTIjJMSP6YUwg?=
 =?us-ascii?Q?xRVNXN2bE1mSzX3qN7mjOQ1R8FNBSoukhMRYdC6HXowRg0In9DEJNY2ixpny?=
 =?us-ascii?Q?2VsHndBBB7zU9qwyH18d53ldlG+bTSs8AtlMDmDvWMYMpbKg/O5/87XSkqsR?=
 =?us-ascii?Q?6HcVCSoi358iAJxe9UHMzpFWJp6izwTn/xsjqTOjNwFOUPs5/67o8Gqx+G5e?=
 =?us-ascii?Q?ITnwumAAUgPPRvq2LOGJ6bKF3+UCR2ikX6l2s84h160WJoWEjkVEgEG7OaPc?=
 =?us-ascii?Q?Yap7FvkelNCaxmXpgGp6oQbsisvJ/uOcrREMQe6Ber3+sWk2UaNyP1vzLOz3?=
 =?us-ascii?Q?SuN9kdo4FQQRCh2i7XGelBmfSDnqLyJNhdTzA8cSUGSeLjsVt/Zx168hNN8y?=
 =?us-ascii?Q?4c2lM9lg7XqrvOMI3eJoA9UAZQoGG7J5VZRhZ6LJC6OXrVRWAViRdkI6y14H?=
 =?us-ascii?Q?BEcJpFlP4Z0jBmkMA7Vm9bO3c4diU7ibPRFL44nOdh2VOTaS4OO5rdlPcKMB?=
 =?us-ascii?Q?M/TSi7Tx3oOsr4dFRGqM+4dGRF9tlJzyGo0z/dl4wYy50dJapc21M29TUFE4?=
 =?us-ascii?Q?Cz2rQRxYYEiNQ+Eve2si8buwohxdGmooTB44QXBNhtlrSAxveUkbYaWnBN9W?=
 =?us-ascii?Q?odPzA0uFRppC09R2mq430vKK/DvV3IBGFMXHpyZ7hBFxVnM20n6EZwr6+xc2?=
 =?us-ascii?Q?pJ2B3XczCbrZGMGGY+QOlTMRA9UNhjTFNnZDWAq1SXvFEZYkPZHZKFYlFFcQ?=
 =?us-ascii?Q?WjhZBRTIWRKGmqG2wZhj13lFIdL+bLxYYqRpg1TAKUZbj+GBISm6iJ0NBMLI?=
 =?us-ascii?Q?1EtdPH3s41JbrahMyAH1bAWMq9Q6evfnEF0eh1mnPazVIb/THcTgxGgB9qRL?=
 =?us-ascii?Q?jTzfg2AB0uGJIwX/9HGH3aYu0Xe8axR//gb+QiagPVLn98+qDuQ3GpZc+pqo?=
 =?us-ascii?Q?npkw0YwHinOqO2iJiF0W3RG6vNzsB/5ctWSDQVG8fURExWzW6MSw1yUdrgd1?=
 =?us-ascii?Q?eZky61Jt6YwkBy6KeLmVBZXt7EwCzBxdf1t1/UWk56ZJLG61gvfm9UHtv8nU?=
 =?us-ascii?Q?fyjaXMGjme9EJuq34CKN7eBuN3JaJy4vUM0xENQWxpz1EUcHycA5B+FnSpSo?=
 =?us-ascii?Q?irTLwb7ffi6Cm2JidLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee192e86-a338-4569-1ea1-08dd17947629
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 14:27:36.1025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRbOvT/FAa3nzy9EVmDXua/GhjlAKxS3B7JqZqeL50+xQ8faNyYlWy2xcBveORrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, December 6, 2024 21:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Revert state if force level fails

Before forcing level, CG/PG is disabled or enabled depending on the new lev=
el. However if the force level operation fails, CG/PG state remains modifie=
d. Revert the state change on failure. Also, move invalid operation checks =
to the beginning before any logic that could change SOC state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 58 +++++++++++++++++------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 4d90e3f0bd17..6a9e26905edf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -987,6 +987,24 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_l=
evel(struct amdgpu_device
        return level;
 }

+static void amdgpu_dpm_enter_umd_state(struct amdgpu_device *adev) {
+       /* enter UMD Pstate */
+       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+                                              AMD_PG_STATE_UNGATE);
+       amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+                                              AMD_CG_STATE_UNGATE);
+}
+
+static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev) {
+       /* exit UMD Pstate */
+       amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+                                              AMD_CG_STATE_GATE);
+       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+                                              AMD_PG_STATE_GATE);
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
                                       enum amd_dpm_forced_level level)  { =
@@ -1007,6 +1025,10 @@ int amdgpu_dpm_force_performance_level(struct amdgpu=
_device *adev,
        if (current_level =3D=3D level)
                return 0;

+       if (!(current_level & profile_mode_mask) &&
+           (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
+               return -EINVAL;
+
        if (adev->asic_type =3D=3D CHIP_RAVEN) {
                if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
                        if (current_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL =
&& @@ -1018,35 +1040,25 @@ int amdgpu_dpm_force_performance_level(struct am=
dgpu_device *adev,
                }
        }

-       if (!(current_level & profile_mode_mask) &&
-           (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
-               return -EINVAL;
-
-       if (!(current_level & profile_mode_mask) &&
-             (level & profile_mode_mask)) {
-               /* enter UMD Pstate */
-               amdgpu_device_ip_set_powergating_state(adev,
-                                                      AMD_IP_BLOCK_TYPE_GF=
X,
-                                                      AMD_PG_STATE_UNGATE)=
;
-               amdgpu_device_ip_set_clockgating_state(adev,
-                                                      AMD_IP_BLOCK_TYPE_GF=
X,
-                                                      AMD_CG_STATE_UNGATE)=
;
-       } else if ((current_level & profile_mode_mask) &&
-                   !(level & profile_mode_mask)) {
-               /* exit UMD Pstate */
-               amdgpu_device_ip_set_clockgating_state(adev,
-                                                      AMD_IP_BLOCK_TYPE_GF=
X,
-                                                      AMD_CG_STATE_GATE);
-               amdgpu_device_ip_set_powergating_state(adev,
-                                                      AMD_IP_BLOCK_TYPE_GF=
X,
-                                                      AMD_PG_STATE_GATE);
-       }
+       if (!(current_level & profile_mode_mask) && (level & profile_mode_m=
ask))
+               amdgpu_dpm_enter_umd_state(adev);
+       else if ((current_level & profile_mode_mask) &&
+                !(level & profile_mode_mask))
+               amdgpu_dpm_exit_umd_state(adev);

        mutex_lock(&adev->pm.mutex);

        if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
                                              level)) {
                mutex_unlock(&adev->pm.mutex);
+               /* If new level failed, retain the umd state as before */
+               if (!(current_level & profile_mode_mask) &&
+                   (level & profile_mode_mask))
+                       amdgpu_dpm_exit_umd_state(adev);
+               else if ((current_level & profile_mode_mask) &&
+                        !(level & profile_mode_mask))
+                       amdgpu_dpm_enter_umd_state(adev);
+
                return -EINVAL;
        }

--
2.25.1

