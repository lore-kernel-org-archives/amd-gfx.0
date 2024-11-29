Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F2ED6EBE3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 07:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B60E10EDB0;
	Fri, 29 Nov 2024 07:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0JCTP50";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8817A10EDA6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 07:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glZDYiwJ5DDTF6vsQOP0HbRlAwOVvSFhCSwRQEOkjqXfKe5PuWRF9uL8X0I9l1v7JWZhcGQllkfFdeLN1PGV+0F+ulN4jBhbQAi87tsWDJLwUBP87fd7T/fK8kmng0KJXHlvkAfe7njT/jyLYtY50PPt49qAO0uDB2SDw8mj0F/Of5Y+0iREKjgjrRm2nYviKVeDSa2z3PazHDX/l4CMo1DA7EESze9f6FZ3KT93b8VuxNPSmuTybYBDhzCQ4WQw6RhiEa0mfPxf0R/Hs8YxD8CPy4lKW24vcFakwy43OMMGjsB3YJRQ3tZZ4n9FdtlHenFKJqp7COl/lJJbujfn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNAiLqVBgSe9pS1hv7Ocks/ZUx4cJWrtZjiIJ0EWaJY=;
 b=hTX2X3KN3CN10Sequ7KtOJS71kkbZ6W2YIYdH/8tB0n7CQiatIMHOKaTwXlm0P9tvK7N4IkPcR/MXtsv4RymhEhNvVnSt1vktEj3kCLk3ztdeG3h6N4wScaJendhsOuEZqKK5JFsTllTevEbshevbrTt8sYodg9nTHLW21W9OQr20eFpypRAVEK9ehQu3Td6e3ThESYXlphiOgMPtfj8iu0lzfdvywzzwRfuVRP8xvTZh6/+YvFBij3Vj5Bq/MhvjprZIhCOfFiJchBcguN+ktyKBrksvakpbrDrPYWIofWQ+HA9Z4ADvS+04DgZwvE2gzLK3STgIZaFQJi/9tjstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNAiLqVBgSe9pS1hv7Ocks/ZUx4cJWrtZjiIJ0EWaJY=;
 b=R0JCTP50lAAbTWo7x0EVN99T+ASObG0lXEosTWVeQt2uWsVPciAmhLjfAg9p2yC8x6wPs+t7NAtCsIwV7bIQqcasv58H1cz6fEQYcUiqJTQLa+jPc0FEw+toZ/2z14oPOx1Zvj2kHRBo6mhxzoErY2tInHONIxzlFsXsXuKIvnc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 07:13:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:13:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Simplify cleanup check for FRU sysfs
Thread-Topic: [PATCH] drm/amdgpu: Simplify cleanup check for FRU sysfs
Thread-Index: AQHbQgoNyrCNztSwcUG+Ym6NNJEZ+bLN17XQ
Date: Fri, 29 Nov 2024 07:13:37 +0000
Message-ID: <BN9PR12MB5257E4892BB420056D9EF25FFC2A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241129025425.3476192-1-lijo.lazar@amd.com>
In-Reply-To: <20241129025425.3476192-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=858a6da9-e8da-44b7-a980-3bfc949eadea;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-29T07:11:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6053:EE_
x-ms-office365-filtering-correlation-id: 87e849cd-aaaa-4bc1-3fdb-08dd10455845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IW5HsKK1H9yIBFmVucWlC8CuzkvfHut+ncMPqKuzFbflozkrNF84CdGn4xW0?=
 =?us-ascii?Q?a5LRuUNdsjNGL6smmaEr9HU/itbULM7+9Ss7sn6/mBP1ECBhkJ5YOlB/fWXe?=
 =?us-ascii?Q?7CBlZ2J289xjIfy/e7qWVSI5V6tPHYYLp6wqx3JHp0LNcB5HUM/5oekTY0lN?=
 =?us-ascii?Q?YyrlvvJXNa4JxoGBN+TtjpmR8oFpOigzD1Il8gxCI8/WOaIzGciNtKd15FWv?=
 =?us-ascii?Q?qw/h9vQEzOTyilknfuNl8uVG48ibEj/TtWamCkaO56lAulfZtAuo7cIx8SM/?=
 =?us-ascii?Q?Oolh4bDxKKtr9pzdqOcJT4Mf4+cQX5AAKmSycKTeUX/WhBNip3ze/lKMoJc0?=
 =?us-ascii?Q?w4l8niwEYRkP0PiFdT7BN+ALNKCxURQz9axVBx8TZlB+HSE9PpvU9IuCwSVr?=
 =?us-ascii?Q?fQcrPsgduUpulp6C624rf9QUR1U5nAYw8AO1R0a29jG5xp/xsuUx5sWQ7h9Q?=
 =?us-ascii?Q?jB66HyRpg49yJFuDbvAhOnNQRuldBhok63vQnjsW8XDJz7wK1yYXKHNbAHyV?=
 =?us-ascii?Q?6lMaRAxxQp1RVcpFyiOP/twt6BsMuhC8cIlkF6DfCKagIx8o+XspgHBotd+U?=
 =?us-ascii?Q?Jv7ojv7BZCpLTFF/DC/N1KJTsyOpcCZGhZEquODBY8rem96EKTnUSEbtBxZz?=
 =?us-ascii?Q?szlMztyvpSThtL3LeY3ATJHXl8SypeiHLhZGQLTMDxXQq8zkD3WTxD6E7GKT?=
 =?us-ascii?Q?g/BsXsXKUna14rR+hLCgdfTE1YpBoRFz/pNfsYOUVhONUN5MZrdQvABUQ/JE?=
 =?us-ascii?Q?MDAG9PT+A5/lS6GJlxWuVdhva6SZAJ72QcBwJNBbj5yqviBviWjM71bFqRW9?=
 =?us-ascii?Q?3XpYwbnQowxldgp+bms7FcdCTQnw2paSkmMGyaJDg+KdDwCVyGrmmqT0yMPy?=
 =?us-ascii?Q?9dyO7EM07H8gAw5Siqa1dYdpAHLGCzKo9OzPpkFczpWt5KSwAC3IBLjURnfE?=
 =?us-ascii?Q?qMc0zvpIc2gk8NH9rFt+KlUkIQR6+vqCwiST346k1zliqNrjL+vrQN64epAn?=
 =?us-ascii?Q?AYRndidYnbtSsijx7Eu8qaxjb3nlNzS0CPwASL0SzB0rsdFLo8IwZV2I7o8m?=
 =?us-ascii?Q?1sonUNDbDyLceBc2I00LS+PNSJypTfwl7x6jN1FIS5iUws0/MrnY6v9nn75r?=
 =?us-ascii?Q?PxnGPzCbP9J5afADN1W1k8cHWM1CNY68TjGyFRYaSSibfR7YV/+yeuR9pWXm?=
 =?us-ascii?Q?uMRgDajrjzWyzRYHl8VhRo6tLWVKkVAFgRNd33HMCeRX9wbMJpsCa04pRfGX?=
 =?us-ascii?Q?cML3OEHZSMVw0sYHP91tRKfmhDhAyeXREy49P1bV2X0ctsNb1iVDl8YkMlKx?=
 =?us-ascii?Q?ibqp2dFaHkuL+gVLaqAQ0HpF7IWPpitu0bV+PaTgJ4eoDdpDKkdTRiKCK4Tv?=
 =?us-ascii?Q?TV+BVAoFJ6lXofkjMNbNRp55DCvT0gTBWpIl11uwXpo9oW67fA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bdCGlFHxouhPsV8OSBHQ7/Zn4vPwYLLGGzMuYSW2HBP/nadxj2oLiob8NvcL?=
 =?us-ascii?Q?9ku3fysey2ljuXFUcjRiCr5gbzpP1KIzIMJXfGrTeGJAGniwPZqSL/o7gDrV?=
 =?us-ascii?Q?jSka8damHOTmRIatA2FZm/MoRJuYcCXgHDW8Zuz2v31CGYwzWweb5Q5Ntw/9?=
 =?us-ascii?Q?FgAV1I/fj/VKdToAeNgltnxIPTDzl7UVgIUDY5BuKw+/ucSmiccGf7EVWl4M?=
 =?us-ascii?Q?YDvx4frKns1zIk1B3zlllPT+VYU2zwgVBmYLk2jXO176j3zWEd9GX8wsQo9X?=
 =?us-ascii?Q?h3+Vlg9myxmjN1qya2dLGA0u14Ig/b2wlvMERqfx0pgy6gg06vUOkSwMmoxP?=
 =?us-ascii?Q?RUIM0vemmLDfNF02wj/1GIkdhXv9s6E/alU5aO2nTF4UNYA3eE7QIRBUm/tR?=
 =?us-ascii?Q?XL4vynHWJuyKMFOJksJzjtq8nqgq/yQX/15f836ZRegdWn8xwg0ivQn0ajMp?=
 =?us-ascii?Q?cf2V9yte+LqeRMPG5eyBOIIL+zT83HfooJmXuFvsJQCpucon44aAh02F5m2Y?=
 =?us-ascii?Q?w5PyNCnNh7fzUuhkCneBBqmRgDnta1RCywEZLTWPImE2mC0nYEB0MqC36AMJ?=
 =?us-ascii?Q?MrXWDu1qpSFs7GQH+NaGj61Fb6mOpp32cMVXcyz5PaSlrtYVgT8FPEbtIFzO?=
 =?us-ascii?Q?EtkcGH4n5egv73vXQ4edfu+EoxMHnpjpD1wdqMVjPRr3ea2fJHXGjp/VGc31?=
 =?us-ascii?Q?pzuyGLrhutTsXQqzgreFuXwponSLDNCtyNKAbCUswL1jIxmKA4PWRjQQm+44?=
 =?us-ascii?Q?/oaA4zNSEb4ouFOGSHVyvixFr7Maop1MJI5Z0PKiHbwhWd+W/J+MfgFQBkaa?=
 =?us-ascii?Q?nkUNeW6GfgXMC4fHPkkXNJu7EeNRmcmp1qE2ngCw6ExeJXJqK7qBrAFc7YIb?=
 =?us-ascii?Q?/ndRmQKQODMkEt9UYTCaqDsNrTXRoxaNxgXn24wmwcm3uad6iFiu3LoCpe/h?=
 =?us-ascii?Q?Ws9cl1A/50OTKcZAhumJ67Y8bejQMyyB2Q8TPSZbId5Tx1r1n5KHPPhgiOr0?=
 =?us-ascii?Q?D0mM6h4D9bhx7+5h0u8DLtD1blGlQ6uhdDm745McuZiqjQiLiM7p6QcJPIUw?=
 =?us-ascii?Q?a3WjHEZTfIMT8cWt/d6nEumGBTAZ/P7bOhju3MGMuRZMM6fUvgJx5frqbnek?=
 =?us-ascii?Q?r7iDe+DjwnsgZdaOLPf8xUhzVI1FKpa5iJ0+sIhmGA3XO+h8JSPC84XmyC9U?=
 =?us-ascii?Q?rxgQffLNztbnFEqM833UPYzbitMi7GfhAGX1QfjzL+z+U/ihLN+CYc+Bk4u+?=
 =?us-ascii?Q?jy2q2XfWj14evH12cUNxbQ0n8HFftrcAzjIdN9NxtSyR8asSYlXAT7vHtc6z?=
 =?us-ascii?Q?/8uEtOuhFI/Nlbe9AhQuTbp4xtFBETfexnfpCHrXa1OEFMss2clCgj7M0zLe?=
 =?us-ascii?Q?OvliXCPcGlFOsXJV2Kb1+rBLKbzQggcjlJup6kP/NSV1tOBw7LzZaG3UnRHN?=
 =?us-ascii?Q?96jlwdYumVpvVK0x/x+AY2Sc+Gh3DZbOqhS+PWrubo2jtOPbizROos0RnY/P?=
 =?us-ascii?Q?j02yJ+aULdGmgH3LkCYEPLmii/ZWtwV6/QSpLtd3QWCtXnxm4TTSjE3xID5p?=
 =?us-ascii?Q?3y+pN0mFh87s2MvfkiEDppjZLoS1QHKEd7yFtPMt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e849cd-aaaa-4bc1-3fdb-08dd10455845
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:13:37.6176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wVCofAJ9goSZSo+YNIV7LDPC2G0cC0qzwmTTP3sDR36CdidZYM6/UCZPDGG/cUoahe1EY9y5AhkSE4eiAYEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, November 29, 2024 10:54
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Simplify cleanup check for FRU sysfs

FRU info is expected to be non-NULL if FRU sys files are created.
Simplify the check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index ceb5163480f4..09c9194d5bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -384,7 +384,7 @@ int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)

 void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev)  {
-       if (!is_fru_eeprom_supported(adev, NULL) || !adev->fru_info)
+       if (!adev->fru_info)
                return;

        sysfs_remove_files(&adev->dev->kobj, amdgpu_fru_attributes);
--
2.25.1

