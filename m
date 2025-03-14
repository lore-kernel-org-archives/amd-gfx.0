Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30D5C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 07:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8610E976;
	Fri, 14 Mar 2025 07:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BlJuggKp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9FB10E976
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiget0vNOOv9BqRbLbpYUrk6uZ45D47PtGOborTAQNBcwRLa3DM47L0WBo8ZQOczQpIaiZ4t+m8tlST/tY8g/SlWF9uQoVihnoB12l0yABHfn5VyuUC4uAAlVzZuwH+L6euEE/uKLb4ZzgxxfxCvAKN+mZTSPDbhYLcynqlvGsk8lVjScwW88Xr6fBwdvzUgrZVLARnvx6p0Tc4mpqvRuXiXMj/OCFiSvm53YXVwRRoguhukzZTNv86avpAitfXd/5Y4gPF2kGRKW1eww/oa/Tp5wvmfe8mfygqKdyOmLtBhrpojrrzNnmIzJ9GmHH4JTTYL3RGxYEPSPYz9oFkTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epOCPDCbAt8XjhSdkq10s2kOeIclIh7dWuklQVaM2vg=;
 b=JS/uWkFoirLVEcKOKg1UcKtLA3K59EFbIxUdcB/DkZSPm5Sw2nwQlQxp+T9N+Jg8Pfw4VB4C0SWyo+qk51gH974+W7m0TQnj0lLRUOdtjLjHlfnKxpIl81vtRDFAFeHHjjJHrGGWxz3o2z+FRUYZ6+KC+L80B5KJsNxpYEiTpJvMsD7k/+MrJtZTrsheVx6UcxGU1lsvXYe0WY8Hx40exUlL6VTrOP9vELoEfHpRGY3g8enQJpphGWe+1a3T3RcH1t9JDDIv0iBRkOK79lxtB0B/9fAytLcabhJ3Sjz4boQh/Q5m42TJZ7b4GPsdcytbCajt2CvFe1/FmZB6iTOzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epOCPDCbAt8XjhSdkq10s2kOeIclIh7dWuklQVaM2vg=;
 b=BlJuggKpVuqaZM+M6BaJai950fnvXlhOenWO6gA/3D5oOTHamXt9dFOXSJipTEwNs4Hg03o8Dgd+MArAxnrjEPaXoMge8trPTLQbxUUZCWmQlYKbWT/GAo6RieMDNU+jlumL/hFLOWGNV2dMnQQQkgJebfWh/dG+aBCtNRAWpms=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 07:36:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 07:36:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add EEPROM I2C address support for smu
 v13_0_12
Thread-Topic: [PATCH] drm/amdgpu: Add EEPROM I2C address support for smu
 v13_0_12
Thread-Index: AQHblLNaTiwgmbIQdk2gjvBuGhynJLNyPgPw
Date: Fri, 14 Mar 2025 07:36:11 +0000
Message-ID: <BN9PR12MB525775A12A78391968512A15FCD22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250314073240.641799-1-candice.li@amd.com>
In-Reply-To: <20250314073240.641799-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=faa81ac0-59ea-43f9-87d6-c188ad4f0703;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T07:35:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8584:EE_
x-ms-office365-filtering-correlation-id: 4a3b74de-53cc-4595-7a9a-08dd62cae4b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ueJ4Jr/hGqxHH1FpeP/jCB3i/MD4Idu9oW40SRa+Ewm7CUqaGUKktdJILrsE?=
 =?us-ascii?Q?KlReIHYofUGGM/gY8qAjF7YdsJH2jt/cjE/n0y1zG+g7MQTfvowJWR6EiXK4?=
 =?us-ascii?Q?QlPUDcIPeeFMNudMRMR6EebAmrBsUkNHzbjv7cwQCN18sz7BqO0lKMobd/cc?=
 =?us-ascii?Q?xJvTt6QSapWGcF8/1JkndXg7TD+YU9oawP1I+0nbMzmwxfq7Ik7XQXVm8zwQ?=
 =?us-ascii?Q?9VzdV7M4iU2c1+slc06+Z7nbyX75Xnp7zl0u4Yq+BlVHQrJExK/59ke67DJ2?=
 =?us-ascii?Q?vvY49nClVMRC3V8EKHtQTfwx6v5LtSd6bIMNAzqLx4S6/LX8TKhhgtDJEh5W?=
 =?us-ascii?Q?6nVj33BdaI7QLjKuVJSaO0k89MWrIEf7npMtXxQ7KWW6UiUia7h8lzVPK6IW?=
 =?us-ascii?Q?ZAsr6jF2FqRN5ZIEXCFR+oCtRdEZNCUvr//3fc11E6HfTVd0lw7ysy4jBqI9?=
 =?us-ascii?Q?jz2Fhncf6YsrVMBeH9TaEpQBQoo6Rp2rMPA++VZGGzzR7lpGByzZqbLM1uKU?=
 =?us-ascii?Q?fIIVUzNiENge1RIyYxgQeXR/lw3aPz4+Za/6WoG8qwBOVAwU5Yz2lbXEaFTU?=
 =?us-ascii?Q?DLHwQErifFoFHFbUaK2Ewfkmc4nfVvl872OYCbHDw+dVgztYMrcpw07UcART?=
 =?us-ascii?Q?4RW0bz8dbFGzE6SuCMxrFzD0f09gEx3NHMjV0sZ7WyeA+L8Wn2qGiECF80VU?=
 =?us-ascii?Q?Jo7MhpNG3uwJrFC20XIi7Sj7W6xr4PYX6DU/TgWE2h/XUxiE4MxVevR39U+F?=
 =?us-ascii?Q?DewMwQ3s5FVXIILME9wsUCOWLSbn7YaTLG+JctYrGGAdcu/dPl9KCCkx5ygg?=
 =?us-ascii?Q?5MxW1MAXpBYcPhMooyn6WPC7cxJNspyo4WxrA/eIaSMr4QFOYhAR6ZRTYSXo?=
 =?us-ascii?Q?31IVzrM1otSnRVBIDG23iO2ryMh6uMjI/2ebQ4NXYyFM8TZcAVD8QBTMAZwb?=
 =?us-ascii?Q?W6U+ka8MEkBpRtxaJJAgZ7fXe6dVR1qkg5B+rHn2UxfFdCsXbBf56XoupMPl?=
 =?us-ascii?Q?3dJC99OaUpPCc3bYuulGlxr+BaoSWpB2onc9cocuZcq+Ie5mNPIgYm3tEEOF?=
 =?us-ascii?Q?VjZIu6WVmtH4vXO0a3Ef9AJ96q8pM+vmIxd0B8oOAad3oj5Ec1tRVOjU/dze?=
 =?us-ascii?Q?mLxkE/6BmGyCeGclmTOOTInEsB8OU1uFBbFi/hI+ND39U1fksMMCmgunOL3z?=
 =?us-ascii?Q?vfdyVnNJj2g29JmgWcq1LXURRWi0W2MCn72Z5gIJgDyxg8AGLojJjQL0s/rg?=
 =?us-ascii?Q?DH9Du7qkqbvHnjiWP8oAF+TRhuj6/KhDZZbQ7pqjdK+zG7nD87nXIn5qKt/N?=
 =?us-ascii?Q?L/zeApAcn7V+4ogXdY2LCYFjTh4e8W5wHygAJTK5AnUuxmNn/hUT1gMRr23Y?=
 =?us-ascii?Q?RHWO3KJofGIM4vFw0pJDtg7ie2iJ6fTzLERWwOrJq1XAbLUEeNXNE1IG4+QB?=
 =?us-ascii?Q?yTYYLUWFxdo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UPEva3tzxlbZpjUO+b08KXk09rjRjfXu58V8iq4/QUXN+FD1XAKanXc22MHS?=
 =?us-ascii?Q?Ta7sQpZqF3+woCeGHa2gUaxNh93h/fE3ebln6V8iZEJwBW1xs0g+vslPJpwr?=
 =?us-ascii?Q?Sm5Wfif8/JQEbqv1I8hPVcxyT5qUbzQfeBpCF4hZXggSxEXgi62OZgntmc2C?=
 =?us-ascii?Q?+mWz34mMM09rwAwlvILxL4k23zlkoG19iEGqgENqJjLDLke0paKkqKaTFPMR?=
 =?us-ascii?Q?ht05B7QNK3X+WJbi7yHcfg+LlaC4g82Jkp6ELcVuDsSUjEk+9QF4RVsR9J2x?=
 =?us-ascii?Q?klvjixkFnWfWeLlzxL8w6665xnDMfTsoJ+G5F+q8CpAorxDcOWUDhT8tc3ki?=
 =?us-ascii?Q?Qg9oSicVvAJeSYDhuT0wzisBeaJYpDo+VL0vamWGEGGVPfdRF9ZWLDm8WSwE?=
 =?us-ascii?Q?VzlwVnsYxwVodlujS6PzQC84eHfF0r88nRP+XIrKHzADlwmLT9uGkR4tdXLZ?=
 =?us-ascii?Q?37aXrzy6H3sfnSu/XwJYUXyrukRKYUup/BXz8zXxhlaNTQfz+O6X2Dc9defJ?=
 =?us-ascii?Q?nQxjI0aFHbotxK/HAhs++ss/yRY3E+NChvg5q80hslyKDQ1M3jpPufgMVN+V?=
 =?us-ascii?Q?Nlr7pY/5qGr11cnJZcYKqQE+T0e+/ypt2/AqwefGS9PEjdXUaf+yynO5uKLD?=
 =?us-ascii?Q?ip1fC7NrVf2cXZg/wnIMCv4+o6gSSYzKtecNZEyx6AKFSV8ZSj6JCOHriIWR?=
 =?us-ascii?Q?oa+kSYXwmEpN3lbKffyJGOAtZIWRENCrRcS7bjvcWztyNLugzLB9FiXfodf1?=
 =?us-ascii?Q?ALupz8KVHe8+2GNRtL+5u3u8DESeZBvxu4rfPM0fM1feK2aE6BDNIlCMYUux?=
 =?us-ascii?Q?7r889mkUQ70t8a9tgMU1yl28uqXYcqbb+W34RVKLyEwMG1OuSt/ynpWEgDTH?=
 =?us-ascii?Q?7IqSMqFFV01B4OFutV9vRvyIuQIrxBVq/LTNze0giQPU2guGCRuy474Hu6Bl?=
 =?us-ascii?Q?0Spd/0Cm7SOOCMMBaHirfu98nEqR+WIQhqQPEQYdfloHZxDpExFuwZpk+Fxk?=
 =?us-ascii?Q?QUemM5mdkXQdNr4RBPF/eBRS6xYYMhWqQdEslCmy4JThrGeRXhY1ICZW0xUj?=
 =?us-ascii?Q?+ESk4enVcK/eSWiIZ8+EOWre0lLVP1kl7hK5EkIvPfEoBCYsNrgu4mC3O5qB?=
 =?us-ascii?Q?LRGSzELlpWLZcf0xodDqa//4mqU7Tybh3U5/Hq2nerMOVE7pFloj4lJ0AXN/?=
 =?us-ascii?Q?jdupGPOevedmBtXtFoF3OKGpp64D3EEaQwXacXS2En8vaHD6ycbmsj0hSXgZ?=
 =?us-ascii?Q?VAkwwWxl/4922efdg5LXUtwvednjhArY+dMU3/mT5JhYzzrjDsGPULZ13Xw0?=
 =?us-ascii?Q?qALaWZ7tGJkNhCj/BTUJEt7YG0qmfupiEBBlpbOw9PlQMzlYZfwnhzpRHckH?=
 =?us-ascii?Q?L779oG/lhJ7r6n12hk0ZeiNaE1AwZGl70VMQaL0LO3HqZ2/1lDKdidhfGwka?=
 =?us-ascii?Q?+F+SjDX0rnc79heJ2oGgoAZCKjHzayKD/NbOltNVVYEdUi7hyBygnTDWoTdA?=
 =?us-ascii?Q?SnRgCNTo1pdpnqHGuMKyx/uGFucFSZuxujQhEL8SIr+dVYdd42M3ZsKnC/le?=
 =?us-ascii?Q?99mRCEWXxRfCthxe+XzxNInehy9W2JgxnI75nOgR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b74de-53cc-4595-7a9a-08dd62cae4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 07:36:11.5918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcnbeCfsHEM848VF74Uz/MXtNV4s7c/LRUl9xOezO6IyIOYa70RECVQlnuLs/Bw67WTKqWTAwJiEpFcOLC+tVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, March 14, 2025 15:33
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Add EEPROM I2C address support for smu v13_0_1=
2

Add EEPROM I2C address support for smu v13_0_12.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3597ecd9baca34..3de89e95a636c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -161,6 +161,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_dev=
ice *adev)
        case IP_VERSION(13, 0, 10):
                return true;
        case IP_VERSION(13, 0, 6):
+       case IP_VERSION(13, 0, 12):
        case IP_VERSION(13, 0, 14):
                return (adev->gmc.is_app_apu) ? false : true;
        default:
@@ -223,6 +224,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device =
*adev,
                return true;
        case IP_VERSION(13, 0, 6):
        case IP_VERSION(13, 0, 10):
+       case IP_VERSION(13, 0, 12):
        case IP_VERSION(13, 0, 14):
                control->i2c_address =3D EEPROM_I2C_MADDR_4;
                return true;
--
2.25.1

