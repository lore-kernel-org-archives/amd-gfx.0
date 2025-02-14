Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD2C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 19:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C46810E02D;
	Fri, 14 Feb 2025 19:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGFP4z1W";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A045E10E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 19:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By4MSa7rrml+af9Pf/W10USd2qSrPhlOAU6MGNJ9FMp672a6CZRwl+tQ0a5EAy8hc87Na4v25nx93arCiLdibUyUP+IfnSkpo3kq61nHxfVAlSwZYTDd39AHnTlpHQN0Binp1OX3ipsknTbs/i7WHjm833B71TQ9dWXT+tlhV0BNIXU1Jw5f7FkUtcZMozHUFEhfsjeWCKFAzIoyfb6I8EWboUf808mPoX2bUGKEUPmwFPPAgerTmWkIan0w2P69T4gKMQ6fI/GCqPfNJi4QIB5eBme28uqNH9SySyirQLC4S0XexHT2iDk9soZMO14CmJ4U/lK2Rnwy/tq7u/ytuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTN9mpIjTtglGLLDqu+vgZixs90dhOU2Y8trYS+jc4U=;
 b=ozqAvqZzZttbP5QJMwWy2Sq9+x7L9dWPulwb6iUonJx0trs3z+9DTSM1XozSIpmZo/E4pbHU8nJEEPNzRaInKITkf+8GSz/C3st9awIbktvHIJF4TAaeud5PDbwb96jh3CqEDbLbOJRcu/YKXxqz9BPAfpKjZlDXIV7ZP7GG47gKrCeNx582408F5V1MUIfw1wlUxYGiCrOfJXXbxc/homhVTLTxgohIsBtW+2JUMhMNsfXp1wyOkf1ExHMEdc/AqZunTw0hYV+kTtY5yHHy2mRq/mb/nPufu85UEw1deQzq9EA+nHgItOU/5U2K6munBDFUp9u2AATGYH4qrXlTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTN9mpIjTtglGLLDqu+vgZixs90dhOU2Y8trYS+jc4U=;
 b=hGFP4z1W6eSk1ED8kBGS68PYYxnXy13jGOatciaAIiKs3s6OJ5+nNUaqOe8cvJxhng8oemr6+s4VFsx9XAgy9xMG5gd6n8BHxjEAAmOnSGdz2BkXQzir/S6XENxlMWsWdsZt7jboVQ77HA1nWSShW+mxCJBh4Fdhg6SUQoGlSFQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:49:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 19:49:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "hoarce.chen@amd.com" <hoarce.chen@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Do not program AGP BAR regs under SRIOV
Thread-Topic: [PATCH 1/3] drm/amdgpu: Do not program AGP BAR regs under SRIOV
Thread-Index: AQHbfnViShCdPDhRAkORE9RT8PlIq7NHNe2W
Date: Fri, 14 Feb 2025 19:49:15 +0000
Message-ID: <BL1PR12MB51448FD52B07D849949660C1F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250214001348.4767-1-victorchengchi.lu@amd.com>
In-Reply-To: <20250214001348.4767-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-14T19:49:15.537Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW6PR12MB8663:EE_
x-ms-office365-filtering-correlation-id: a5e7e348-69bc-42df-37a6-08dd4d30a9d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3E6x4yMj1cKU5HFPK+yCPHmtyxt2SZwE9lwnQYNZFJp7akvHPAhkDLevkL?=
 =?iso-8859-1?Q?He0kyMarKfvA7w6Yr0JC1008pv69lMkwlWQFS5JW75NeETgr5E2uxW6Fb4?=
 =?iso-8859-1?Q?Sflj6WigNngP+7z7TVBEI4v1QgZ98KgAE11vraauMRndO36Ge1wQEWDOWP?=
 =?iso-8859-1?Q?kUu3SfKpcbwq49OWu+V0RFTHSGazsEUco6MITkLC0OrX7oZGEg2M9SUORx?=
 =?iso-8859-1?Q?vmGka9+uY0h9ST3wJE61pnHcaZY/duT5xhQ0D/oC7aBv2oEJAhIoZoJzqU?=
 =?iso-8859-1?Q?lWYKEOEBRN7l2vR2VlrF0oNC+7RoxXBgK60lssgFRD8SOPK2TYX2+fY95u?=
 =?iso-8859-1?Q?ulttCD3QyvILVvTuFyHC2EjGcw9JtYEdaprW7KAi/g3ahZbjnA3Bdg9y4K?=
 =?iso-8859-1?Q?+8UskyyWOvWHjCSofL5jvBOZTdXHfu0IwzVh2MgREK7+Vcq9a9xI/Fwavc?=
 =?iso-8859-1?Q?K6oZf/lhuSpDhp8Tc8EXfEQ4rfgnkTy3LUSb9b9y+x1pCykKirWgzxLwsY?=
 =?iso-8859-1?Q?frKUOBz5zkNtzBYk7YLrFw+udHKInXVp/NLwiENZf+Jb8IQVcCA4shHU/q?=
 =?iso-8859-1?Q?wKJR9hhySUa3mCl/67AzMFnjTaAdikWOufgrgEtdd0fsFSyS0NbK2ZEdPQ?=
 =?iso-8859-1?Q?Bc8K8+w+a7mpcSYVC6tHwFbsGhs5+rKaoyvbU3qSkOuRHm57GjPMKlLJDH?=
 =?iso-8859-1?Q?0uO6SKmrkVT/KZBhTWMt/i3tMl1Tx+596rUVMIrPg1/rgc74McAEgCtKoV?=
 =?iso-8859-1?Q?NEnultpCbc4t+SeE/15J/8aJklQeDSPcRYtkFmwhvpF8EvyYfM8LSsaAax?=
 =?iso-8859-1?Q?FvE3VhtbWnOgIT1Ln00+jqmYSgGEPIzCKVE6NKUVZOF4VKQ2mycVi+RXG+?=
 =?iso-8859-1?Q?pIHxBaS3Pyophkatpp8B+NUh7fUbgMIcPQenvEwQ0/fWuiZSNepqAtBfkx?=
 =?iso-8859-1?Q?FlJfAIfvnrGgi1BmynfqTSNjZAKbMjvt//+eOR4LnBmacqd1I0Ta9pwJXx?=
 =?iso-8859-1?Q?JRtQ+52A1TeEBR5bZBChJwyjZdXnKDchX+rlAeilpGkEhsaVec7kjabQIo?=
 =?iso-8859-1?Q?ek7o5SJii47xZTjG2txpYWKRqVO5GbW9sCVE7BkDP/1j26BTRpEq7qT21m?=
 =?iso-8859-1?Q?b2Bk20VJWxrwmtVzAg/ZqpGomJphaz7+v4OvAWGtYSb/KulkfIUQKn8QKO?=
 =?iso-8859-1?Q?jbwTb/QifsTMljG5oa/lM/HMqusDPAa6Z6St9Ly4B97qTYkSVNoOPPpZRf?=
 =?iso-8859-1?Q?Ywxvydsc6XhmSSG2pJhQOKUS/qTwAjl4S9SeItHoqngVAYJ1EU5l7A5Vb1?=
 =?iso-8859-1?Q?qK17b0lfccR3uBGZuM3f+3CtBuvIs5Jrj8zMkkcbk6/5skMmOeoInERr7W?=
 =?iso-8859-1?Q?l3bqdsj/IpuBFvJzRhwYq+z9G/FdwK4WQBOTzbxHVNy+f9tNFzYmhv1euE?=
 =?iso-8859-1?Q?gr6TM1OijQces/ZvS2eW2cxqwUpFm9pftJ33lZ2j7GZi7Xk8/K6ZJ8gNbZ?=
 =?iso-8859-1?Q?btMUAa08Ec6pyCS/UYaqqQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xVL28seTieJ0IhwCTGca4/NqMKz4Eygw3uulpE9gihgszvz8drk1MwMGcc?=
 =?iso-8859-1?Q?pLYhe7ew/DVF4xv0uTIgRBCw4Snr3enKmtVtFQ1U56l2SNH6FbZGDrpbYN?=
 =?iso-8859-1?Q?CsBxtQLxTV+2h1MnxUiOYGNjZd2ScSMfvmd6lkm9Z9DGCAV9RgcKlTEcTy?=
 =?iso-8859-1?Q?frIe51OHXRY21GLG2GpdkgQAwynyiwSvvhz6YJT2bPZA8aW20Gk2Qzb1rh?=
 =?iso-8859-1?Q?2qAynTKu1yp0qKqm3T5uvE/8xc3rj3WwNOsdtdCsvvsB6CI8vCF8jPCStM?=
 =?iso-8859-1?Q?tlKr6yc4SLiMENSy6niLC2FIjePKBJJ7/dZLgSuj5E0VdbvleXW23DApoi?=
 =?iso-8859-1?Q?frwFYnbdXjYd833mh/iVKzJwGJcWr0Q0HxuC65wh5gtErjYHuAAAMUc6is?=
 =?iso-8859-1?Q?RYU7ste3eT+qnWukrVLv/D4Zolo4cYlhIJQGKGt4cfrH8GTKOTqaqjuOxE?=
 =?iso-8859-1?Q?PQ8/dwiqbr8FApnCpXD0FlLCyvWYszIPWkwM9PajYZCtOKfNmz2TH8DoNe?=
 =?iso-8859-1?Q?fpxHHevk99QmfdI+44DW8CNt7rDtHcUrrVW5UICskqc5UifJh92XTc8lkX?=
 =?iso-8859-1?Q?z3C6U2L/kVSX7FpGNfshI5oW8p/Thnr5gAcX4/DC+OjQ/D5vOMyWBbmvHX?=
 =?iso-8859-1?Q?JlimL5IqkF1ynZXfNzLE9GHXne4w4axdBiAAiC+9i7qwjkd0iycT7Gggco?=
 =?iso-8859-1?Q?lZfGHR8VWBTGcC5gNG4Kz3ezUdireUM9acRwsWL8rY+HCFNRsOI/KO9e9K?=
 =?iso-8859-1?Q?ZzyvD8QL8QpMHEYj25WY/IkMbqmv4Vk2wEQczVuY5EZQKKS0rC0lVSXCHD?=
 =?iso-8859-1?Q?08a9oA7QSaBHEQ3AyJ+3c4UCDbgwMupspWfL2P1khiTA1T5Esp3GhFp809?=
 =?iso-8859-1?Q?oyLBHhH9NLRjkotzEHN/qd5yyhW60BUfD6Z9Dxy9NhVaMoz/wzxIAV0adv?=
 =?iso-8859-1?Q?W1UVJmYLgUmmI2licrKSzqwctPsrYCTja6A7UhRQZDsxOv1mqh+Rs+/c9l?=
 =?iso-8859-1?Q?3TRDy9S6BIsxj0Yd8TAcJNcFqKzPzrfpWu/O5YhUMe1CPUJxrb75B7k9Sk?=
 =?iso-8859-1?Q?WR565MRKixFbp/kRcZ912SyXVzDuohGJpoUpjxMlpyGMRGsemfrl3Z8c41?=
 =?iso-8859-1?Q?fYV3kU3p/wdxS5v6tmtKvX39fcGUi+pcLnTwkCcIQ1sVkt0B8FfFs0Cn0m?=
 =?iso-8859-1?Q?tFIGMOMeM5PpARPGPiad2li6qCqoAv761Ig4NTyG+JdHvz6im6GZ1ZuaKc?=
 =?iso-8859-1?Q?k7Yf4b6sqIpV6hrIZrzJxJxJAMkM/KCAN+R9MYt0A9J4PpfpieinW7460d?=
 =?iso-8859-1?Q?/gnghWPTPPQuY+YHpBxlud8zreVgUFeTD9AbE+3Vxd1wYe2S9+5O7eCKoe?=
 =?iso-8859-1?Q?eQBKTxkY2WY2V67Gv7TX8kyeECIO86wtLEmGXQIPlynBKG43Sv0CYSokE2?=
 =?iso-8859-1?Q?z3vWu2XoRy5kfppY7WEcDThxvhGqiWjtkwivYHV8ZU6SMMC307NaaaJBhP?=
 =?iso-8859-1?Q?cPJYzI++uNnscEc4Qfpbvv5KcIFTd4jtX/AMg8LDJILUBiW+gXr8Zxuz+X?=
 =?iso-8859-1?Q?sH8yN6ndQfic323PvOwY66Y6fn74KRx/HmoXLR/Yy8HhjlRirwfr80Lo64?=
 =?iso-8859-1?Q?uJ4g8ONphWY8Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448FD52B07D849949660C1F7FE2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e7e348-69bc-42df-37a6-08dd4d30a9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 19:49:15.8785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76n9LeigXYoEHfBN8KQ3NBLAvDxy2JSfutMzqnO0BMvJxpqVyxFrJhWVPQHILt/k8+pZ3VDXfpusDjLZjInP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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

--_000_BL1PR12MB51448FD52B07D849949660C1F7FE2BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Are there any cases where the asic_type check would cause this register to =
fail to get programmed?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor L=
u <victorchengchi.lu@amd.com>
Sent: Thursday, February 13, 2025 7:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>; hoarce.chen@=
amd.com <hoarce.chen@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Do not program AGP BAR regs under SRIOV

SRIOV VF does not have write access to AGP BAR regs.
Skip the writes to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c
index 0e3ddea7b8e0..a7bfc9f41d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)
 {
         uint64_t value;

-       /* Program the AGP BAR */
-       WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-       WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24)=
;
-       WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
         if (!amdgpu_sriov_vf(adev) || adev->asic_type <=3D CHIP_VEGA10) {
+               /* Program the AGP BAR */
+               WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+               WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_star=
t >> 24);
+               WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end =
>> 24);
+
                 /* Program the system aperture low logical page number. */
                 WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                         min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18=
);
--
2.34.1


--_000_BL1PR12MB51448FD52B07D849949660C1F7FE2BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Are there any cases where the asic_type check would cause this register to =
fail to get programmed?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;amd-gf=
x &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behalf of Victor Lu &lt;=
victorchengchi.lu@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 13, 2025 7:13 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Lu, Victor Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com=
&gt;; hoarce.chen@amd.com &lt;hoarce.chen@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 1/3] drm/amdgpu: Do not program AGP BAR regs un=
der SRIOV</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">SRIOV VF does not have write access to AGP =
BAR regs.<br>
Skip the writes to avoid a dmesg warning.<br>
<br>
Signed-off-by: Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 10 +++++-----<br>
&nbsp;1 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c<br>
index 0e3ddea7b8e0..a7bfc9f41d0e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the AGP BAR */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_B=
ASE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_B=
OT, adev-&gt;gmc.agp_start &gt;&gt; 24);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_T=
OP, adev-&gt;gmc.agp_end &gt;&gt; 24);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 || adev-&gt;asic_type &lt;=3D CHIP_VEGA10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Program the AGP BAR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev-&gt;gmc.agp_start =
&gt;&gt; 24);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev-&gt;gmc.agp_end &g=
t;&gt; 24);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Program the system aperture low logical page numbe=
r. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_A=
DDR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(a=
dev-&gt;gmc.fb_start, adev-&gt;gmc.agp_start) &gt;&gt; 18);<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51448FD52B07D849949660C1F7FE2BL1PR12MB5144namp_--
