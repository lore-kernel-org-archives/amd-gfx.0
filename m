Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F216CED63B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 13:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5D710E056;
	Tue, 18 Nov 2025 13:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0slBRld";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF7F10E056
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 13:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8GKQADekPTPfu034hrFmG7Hj7QIfNbMiSG1bB+04LIj00BqoO9brqWNKhjx+k4CCrw/DJ8np4nnJ8Ut3HtMiFYtx/x2kO6Y1CRc/7amTaYtpZk/v0fH0UhNUrIsa0PHj1F0hQL/AV0LI16LsPABpZ/n8XFkqv7etEVw4YiewpMF9WFH8YiQzYvu5eaLkZLolXSlKgEDTiy5MQvh8RTukNvvWZQPPeMMCN2iW7jOWdesa69IWOqgnnjm4kAYqx6nyLB3pKO9OeVGeczBxwtGGMOckoBMppxOEMs6zjk1wqOUOAgahwGjxnDxTcxlQe2TluzYasfCxfsBHf93ETMzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDTqCsCvpVKrMJI2dHkZ2W5IkSE7UMHQ9yNGFijJlyI=;
 b=K9ewtmB/3OLIWg2j0VbqHCDF3If1tyiVORrCT9UtGV6fUngmvcxLbh2uxI02hTOUf7B6Gh6ty2RObedkGU6ROhTb+oanrKi5iHXsrCtwutcSEd/WbzhNH4lWNQ3SElurHNJrn96zH8By3nyRz/J4AsvCPtpmgZ5OSztscVpjk+w9BbYGVSUPB2Fatcw/zgPokAxuAZfAqR3IBCSDzTjtWfguKNd2nSUAhMCj+lUrB6fjdVYH7vsUbFa+RMplCENZa6hPWszoiIUVtJnF0lIyz1oMVnEhJ2+BLwWijtvlPaS79JYjIIZQ5xPp1Xgb7M9Wih9bmipx9aFmtw+m1Sr72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDTqCsCvpVKrMJI2dHkZ2W5IkSE7UMHQ9yNGFijJlyI=;
 b=f0slBRldrzweUZO4dGW/2gkpuHt8LwmaLc1XCt6DCYDNF1aG2m2kGmR/Q9BKf+HGTveQOL33RfxrwMPC1EnmjFgXzE5hrVt5dvjCldzXRdde8nZDNhlT3LM2EIyS2r1EV+kmsUKyhUh4mOotB2GqTw7kqa+rtmiRKnp2CViKIc4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 13:48:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 13:48:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Lee, Peyton" <Peyton.Lee@amd.com>
Subject: Re: [PATCH] drm/amd: Skip power ungate during suspend for VPE
Thread-Topic: [PATCH] drm/amd: Skip power ungate during suspend for VPE
Thread-Index: AQHcWI3WSF5jths4BkSf5qrycT1UgrT4cmB3
Date: Tue, 18 Nov 2025 13:48:46 +0000
Message-ID: <BL1PR12MB514420A6D3532C15355970FEF7D6A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20251118131810.163680-1-mario.limonciello@amd.com>
In-Reply-To: <20251118131810.163680-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T13:48:45.786Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA5PPF6407DD448:EE_
x-ms-office365-filtering-correlation-id: 6576a24f-c194-40cd-50f2-08de26a9322f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?unnJ6FpExVqRcieuGvrRGkKJe8TGe5jikUDMGHaSx+R6kZnmFTG6Gamtc5OK?=
 =?us-ascii?Q?rsazUPVFFPe1DaCt5QDmjx19Vrq+/DzsokrcbPMKazEnTFQ0mhoO9SjfCMTB?=
 =?us-ascii?Q?6GRXtbM8AiswpYx98bwPXclhUpo0ts2ORKW8Z4AnoRotdzPwXKCakDPdsExS?=
 =?us-ascii?Q?jsHuR0p+9gdK3mMwLss1zqWojd28/ULH+0bdLBO22inx4/2yDZkirH68rrBU?=
 =?us-ascii?Q?wsyq6Vdip8F/BU9CCzruovKEeGH6Hqm4zXiI+nP5xPVv+pa5ZAvPek3s36Ce?=
 =?us-ascii?Q?1JsOqsSnTdg1iDZKaNIPF+aksKMEifWeEGwObEBCPgOQwWRnormhPLDBSCAi?=
 =?us-ascii?Q?pinmK0sqduhcQVU6Lno4dTai80y+rQFeBh/Scqldz0SEqrR+mdAsY1rzRUWL?=
 =?us-ascii?Q?0BgoaPqd/TSveKZ5nD7o0gYGf3qNXwJQ/cMbItzvks3mnbGGwUBvrVEynq2i?=
 =?us-ascii?Q?iALkrSBjk/vrNfdnSZGYhTzCWiDGU+DCAstGwyCBnRj1GNsShfOlC9JBmN9y?=
 =?us-ascii?Q?JSOc5JiQtnLlpU5BBVjLW5nFsgwMWc8Bl6GdKmaDJcO9h4JDnMxrZqnrlGbL?=
 =?us-ascii?Q?tGav514OcaVomqKwvHA6qSPccbfyaPF8lEmQgzJbciguFMBuj3eRQ1NtYEw3?=
 =?us-ascii?Q?q+HfpUsiUG18avLo4q1G/hoK55MJWf0yY45fqVwks97W55yWSJ3+oUXl93Xa?=
 =?us-ascii?Q?//ZBxKZgX2ejSZ8SaejI2ctwEOFlXhKY44H6BCfi+eKumEP0HiUl697fFzGT?=
 =?us-ascii?Q?eI4C5uyTTqGY6Yiux/2fafapPzgQB7DWT4x5gfb2ykZ9GRgmKo8dZJRpUbpl?=
 =?us-ascii?Q?lBDrqdqVrgr5+ZTdZBlLTDhs2Lx/sV+vqy3qYUUAW9Js8ZaCpgx00HAPWoMG?=
 =?us-ascii?Q?Dz9fumpxpMRmB5hvdohWZ3X4tasppEpM4EceuK4CbBobCpkrt4MHWgvKqi7j?=
 =?us-ascii?Q?zMNz6jzyMebBrI3jsWIVDFlzwv3vAuWsDvRM9A3+WPk/HhrFRN1VjdIw05u4?=
 =?us-ascii?Q?20NcaVGj+uaNQhFgmtmpTijx9BujMQ90VJwPLEL4/Ow1MbhuatkkW5/H+Nq5?=
 =?us-ascii?Q?0E2RZrc4WRcNaXnH5Oo2UOC/J7llujFe5psIrM30CuyPVVIPXEuXv2Mw4K77?=
 =?us-ascii?Q?t7bv6SnYQmkB4vs1SRwQpJHpH3x3JOFIeBB7UL8cQrOwQvhRZbQJD18RYg/y?=
 =?us-ascii?Q?j6QMvDLpQfLJve8KpyS9Qh1S716msGOs3jDTw2fbdO/w/Mx0UmvnSwJk36OV?=
 =?us-ascii?Q?JqD++JYCPpNefMZ48NHarniNRd7EQuzSOEbK0eRxFVVNHkE0+PfV1kIVsfxT?=
 =?us-ascii?Q?BK611/dTQ/K4GldofVP82ROb9g2OFpX4xxAc4o4S5ngsHi3S8gGs7VwAnMul?=
 =?us-ascii?Q?dFCrASOc/Ju1LRJCQb4J7lwKZoH+s2hk7zEYVwxtZWzsFg4sJIEJvj+Wtryv?=
 =?us-ascii?Q?P/4GuWJLk06DmQKicuZ7j4NGTDUXVhQIdPCsTKHDzq7ZwRlBR5QeevwroSI8?=
 =?us-ascii?Q?vPingAr/VKK3vb361Fk+8bAi+dMDgXJqHPUc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KkmeWLNM+jvC+0ghEe/yYpSRD0v2GNkAMIMjZzLpgtttr4FOvSP64hIHK1nj?=
 =?us-ascii?Q?WzO7omPEctpDZhYUmrGax6SvO0YURSdjdwMUJ5/2v/OQugFSGe5RtLSkUSdx?=
 =?us-ascii?Q?j7EGJ8Wl66uLTMr+Zi/qJ4K0ZlUdBDSIvo1J/m6O5n6CvAsmQdBuPL1IbpJM?=
 =?us-ascii?Q?ewNQ275KIALJMw7AMGG4zuPl82tgCW9HqIv6uRnUAmlpItj1d8GmHzSjCnuJ?=
 =?us-ascii?Q?Van0qi0NhiOzSHdjjCeC99zpKliwRcJmVpeMkTXGbMvS8lts9yIGfY5oy5PN?=
 =?us-ascii?Q?ybOdiK6E010qAJ2YDUxlPxnp4Hx3hc+PWyueVfHalnBD4aV2m50awuoHDXqt?=
 =?us-ascii?Q?MtOJeIvZUIL5Y7mx1FrCqqAoH1QliMPvuNAHiPDBYXQa8oI12oyktFjkvgng?=
 =?us-ascii?Q?okW74P7BEjSMywIniphztnclno5kCP3/CuxMKb3dpmIEKtEC0YDpznHC2gXT?=
 =?us-ascii?Q?4WCgbigT25a3dy79aT8WdTSktxfz6By7j7mNmbWKd2VREcCvvbASXEjm0xjj?=
 =?us-ascii?Q?GwzD/kHQIAStqGDwVzyxdd53EYTOccFiad4FBQqrOtY739ZDxiSCj7u38m+i?=
 =?us-ascii?Q?+XlJK3o/wDoV/mnO5YQdXoWPJHirxQGiQ0KesVGvUtmgoX79edBUAGRlOw3g?=
 =?us-ascii?Q?CZgNFz8JbuVSn6+V7+p/efcAr3JnTbvgqNzbTEQiDqiblDeaqv+ELDV8FT29?=
 =?us-ascii?Q?9IyxP2Iuk+vmrEgYMn+K2QlEZ9+dExKzWM0DTtvrNq4DM7+YxbTASqJ4+wja?=
 =?us-ascii?Q?zwKF+Zo+1U3D/mAD12NoAoNBNDg6EEzqCCPzTckJhwf7H+YiKTVHJdKZtao5?=
 =?us-ascii?Q?owqtPADtGO30cObSzyCR/ShHUjyrPQSNM3ZKeA8H9LYKCAo5iCCopSGuMwjm?=
 =?us-ascii?Q?21E5vHTsAiuMAaRjrn8ZA/knP9xmliX3HaCxpj4llB/Wb+WNWlS0aE8ARyiR?=
 =?us-ascii?Q?niEIZVd59PlhrUcqBbNxtSbrMeJYfhOzoi+AJKbXaci6Nn4Dupxo0wRf9oOX?=
 =?us-ascii?Q?N6/IHSiq5p6XR6Ub5SoppcvLw15tqOUavXun9QnWbDa9p/bMgibEHLs6Lckh?=
 =?us-ascii?Q?KhBJ0Kw4pAMNXl2QAZQsbEuNopxAf03d71e9s08tt4igBVmTzWyxVc9LSiEF?=
 =?us-ascii?Q?vHQ36WInapdQYoPKRgRoxwcWPYwwMrcAUWLWbOhz14hUYRj+jCnp3gtw/MLl?=
 =?us-ascii?Q?GJ84bBeV31o1bM0ysGVVHOLeAct/UC81C+n7MUAOiB04wtVRO3OrRn/9TVqc?=
 =?us-ascii?Q?pGwcDShWU5DEASWv7uoHdUgNHdK4xswkBIjEb0j+gsluc1Ey27uyHXjZKB9T?=
 =?us-ascii?Q?Ws7fvNKXiNQbpDoT68e8eeQiqFiiZu2GIohw/K3ngitY2mXmNM15C9gKfswC?=
 =?us-ascii?Q?91EkS6b43NELamfbL2KaCJy5RC0HytGSOVEq6tL07JdzYX9kEKP5Byjs8zWa?=
 =?us-ascii?Q?haN2mrYBylpay0T5j/8V4yrB3jbRnp47vIz6mtWntxBriEE35Fz9RP028S4U?=
 =?us-ascii?Q?DzS+Y5R1UoPTg3qpM0PCA1dxnjDpoYvwbdzWlwsZf/9WOp57Z5jJ5hB8W02X?=
 =?us-ascii?Q?7+PPf29litWq4O6rMKI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514420A6D3532C15355970FEF7D6ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6576a24f-c194-40cd-50f2-08de26a9322f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 13:48:46.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oigRAKCb4I/Sk+Lco4Je4nSPea1k0H+C/jA/zAovuEwm3PoBOYJs2phP1s7BZKb9zzM7kxbYEWLoSnhBhh8RVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

--_000_BL1PR12MB514420A6D3532C15355970FEF7D6ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Tuesday, November 18, 2025 8:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello (AMD) <superm1@kernel.org>; stable@vger.kernel.org <s=
table@vger.kernel.org>; Lee, Peyton <Peyton.Lee@amd.com>; Limonciello, Mari=
o <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd: Skip power ungate during suspend for VPE

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

During the suspend sequence VPE is already going to be power gated
as part of vpe_suspend().  It's unnecessary to call during calls to
amdgpu_device_set_pg_state().

It actually can expose a race condition with the firmware if s0i3
sequence starts as well.  Drop these calls.

Cc: stable@vger.kernel.org
Cc: Peyton.Lee@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 81587f8d66c2..22db0e4154e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3419,10 +3419,11 @@ int amdgpu_device_set_pg_state(struct amdgpu_device=
 *adev,
                     (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_GFX ||
                      adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_SDMA))
                         continue;
-               /* skip CG for VCE/UVD, it's handled specially */
+               /* skip CG for VCE/UVD/VPE, it's handled specially */
                 if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_UVD &&
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_VCE &&
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_VCN &&
+                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYPE=
_VPE &&
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_JPEG &&
                     adev->ip_blocks[i].version->funcs->set_powergating_sta=
te) {
                         /* enable powergating to save power */
--
2.51.2


--_000_BL1PR12MB514420A6D3532C15355970FEF7D6ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 18, 2025 8:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Mario Limonciello (AMD) &lt;superm1@kernel.org&gt;; stable@vger.=
kernel.org &lt;stable@vger.kernel.org&gt;; Lee, Peyton &lt;Peyton.Lee@amd.c=
om&gt;; Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Skip power ungate during suspend for VPE</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Mario Limonciello (AMD)&quot; &lt;supe=
rm1@kernel.org&gt;<br>
<br>
During the suspend sequence VPE is already going to be power gated<br>
as part of vpe_suspend().&nbsp; It's unnecessary to call during calls to<br=
>
amdgpu_device_set_pg_state().<br>
<br>
It actually can expose a race condition with the firmware if s0i3<br>
sequence starts as well.&nbsp; Drop these calls.<br>
<br>
Cc: stable@vger.kernel.org<br>
Cc: Peyton.Lee@amd.com<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 81587f8d66c2..22db0e4154e4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3419,10 +3419,11 @@ int amdgpu_device_set_pg_state(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].versio=
n-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_GFX ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].v=
ersion-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_SDMA))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* skip CG for VCE/UVD, it's handled specially */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* skip CG for VCE/UVD/VPE, it's handled specially */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type !=3D AMD_I=
P_BLOCK_TYPE_UVD &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_VCE &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_VCN &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;type !=
=3D AMD_IP_BLOCK_TYPE_VPE &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_JPEG &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;funcs-&gt;set_powergating_state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* en=
able powergating to save power */<br>
-- <br>
2.51.2<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB514420A6D3532C15355970FEF7D6ABL1PR12MB5144namp_--
