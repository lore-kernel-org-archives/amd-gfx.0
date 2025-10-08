Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0633ACCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 05:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6530610E040;
	Wed,  8 Oct 2025 05:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wmFmPtc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D4310E040
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 05:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjDfLiLvw0wPOcFMWvZHcqL24k2FYNd/SYekdqXZkZc1oA7FEdFC9A8ZEDPt7xzjWTla8WbmqrjvlJeR6XChGkfukYnfsg0a2+zmXphIXDVfzDoNlTm4R9W6kn50IArhhSNxAUn+yFOhhS0GJOJreFOCcSJ6hNkfW5ijrrB4JPmCPkwm3TP+K7l15rrSamJA/FrC4QSBDHSp2xbVO66mC8lLMFyVnHR41RdSUpJkC/W9Qq9z9KYcgdNRMK2V43Ve1VyOBCrOryJlVbQYBGj4TpaKg/P6MRZA+dAfZCoGBJFs1PEksXUYUoxr4aU1Y/a2zSo/bvMHeNxErSHCf+pKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29JK7Cd8APeS6BFFO2j3+W4JExgBF0Et23jbkzTxF1Q=;
 b=koJeY8Ww9y/QruS6CLkj72hndr+u84UtTIw4Q6NCjK0V/cgAhcWzGGsj/256L+c+znuJ1OcmyuiWBPL34mgshLwubKMpl+lfGYGoILoONC5APKnBlBbBEGRPjwyZek0KnSagNtXFbEXutAAwKw4kGd1T2RR0e6il4zMUfhaZP08phkdLJf8pVshjSDDG3FMfKj+cep3HyeOBpzxWQkVpKds1JHyoN7UkoK0QLhUiHDyVQdFRlx9iwdeWNiN8kAJP8PGMZsya2N4GSvJPIqYaQsjomeF6cWHpo4rwpX23wCKuyX84SrGNL8evaLs+l2Z3mTJdxr4kJrHv497ln6drww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29JK7Cd8APeS6BFFO2j3+W4JExgBF0Et23jbkzTxF1Q=;
 b=0wmFmPtckNhG3a5cP+mCGTa+2nnrxV82F+A8NEiyknJZqKgU3NV+kEtjL6mdCE3npOrSih6bzADjxC7V2coOpmeVkyFSKYRn+oBWvLP7PmpcXywWm4rn/0V9wXRtgW9lal8MhUWDoqWzJjCnP1rWT+Oes7ZDeoE5l/DDEctj4Jk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 05:54:42 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 05:54:42 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
Thread-Topic: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
Thread-Index: AQHcOBEY/6/UCDsFvE2Q5+/cmNvY+7S3v38g
Date: Wed, 8 Oct 2025 05:54:42 +0000
Message-ID: <DS7PR12MB607106FF830947FC304CD9E88EE1A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251008050418.3399656-1-lijo.lazar@amd.com>
In-Reply-To: <20251008050418.3399656-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-08T05:53:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB9276:EE_
x-ms-office365-filtering-correlation-id: a1ce16fe-ad9f-4e5e-ae6e-08de062f2d4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zRBTcAvWDVfyhN7hVZ12oheVXmiHgBTQR75WQD0bPnxPqnV2DQ1gVHQdWmvA?=
 =?us-ascii?Q?epXsOBRvUkUSDW189D0bPH5Fdn2INzpezmjPSgfT/BMer9rNtbywWLp9wXMN?=
 =?us-ascii?Q?GDMN6YDpPxL6KVPxvtzUQenut/BZd+Fb5p3fim2CRqK7vuYHFTyuBKK7R5Hn?=
 =?us-ascii?Q?4Vkt2wo6UXjALCohUOPU8dHqOV+xTHMah97TekaEw9qpL88LGqy3IT9zYBT8?=
 =?us-ascii?Q?fODm1oh2/jU/Q3zxXzYQKVWCFSqpxgSM40QENOA1i8i/K/auSV9+LD/raPb5?=
 =?us-ascii?Q?wR18JWCpE2x34w8cSoaP/dZfVESSkY+JYD5U1eKmoA2JP0hb5EVoI5XFGpP0?=
 =?us-ascii?Q?r9g7onyS9zV0niOgxToIeOhR97UmlJobONuMrZmVHwsHmMhABaWAWEtwfb6G?=
 =?us-ascii?Q?xz2hYkSv28uyFRhDLMhLAHSJXkUmwtHD4UQ19zJfOu5sZBNZhbLe8muK2fhh?=
 =?us-ascii?Q?ogNf6ZoDhXwwK5VhnQtv6ERwLN+MvWy3AEEYmly/kkGBEtGILZ0s/+BXJ1tX?=
 =?us-ascii?Q?RU8nEBWNku4hTAg/wuOlYWloEWS8LmL2dVUxrtD9bkr8McfdyVWuCRvvPfNu?=
 =?us-ascii?Q?yMWt9XpgH31pnfiH3xvJs3TCMOgByduqk054MWMMV1GHOZ4P5IjaJ83X+Hr3?=
 =?us-ascii?Q?xl1745Wm1XNj39Qi+tObzzA5MLz0e4zbCW3ZST8sywA7UhwuqDFSOt5DRriN?=
 =?us-ascii?Q?9DFjXFdkpGz7/clJxvv2myswAlf5cS72yrvKvPbVJsVmGx+drYZpv1rkX4DM?=
 =?us-ascii?Q?RG0/mMjvDPHBg106pHqB4hxxy/DoYLfonJKLJKoEpxlAsueZnhg7S1wDNx7r?=
 =?us-ascii?Q?disHXmlW2qVJhW/t0wB1emYhsOH8ew8zG2AZ2TfhPsAsSp7ZqjD/sJQpCSxF?=
 =?us-ascii?Q?pjLth1VX4FjBnzJUcUq1huqMIx/QRAgb01qKv86yOxdeZF0FG2G21STrHBJi?=
 =?us-ascii?Q?2U6aTbebn7cVz7MQalFrUXXt9r5EdW1o32eFoZk0K+Bz7vg8uf3TC++UGkJ5?=
 =?us-ascii?Q?8NyjINgWPbn2P+79UBJLvIV7/UFl3LNDy0aOgEk8wGlgy/wCMdsGFV/umygG?=
 =?us-ascii?Q?NwU5d4dvtx5ZhZLuaWqyM3lb0frWSIYWhDqaQEBELjZWAfIsqQ9r4ZzH/Jrc?=
 =?us-ascii?Q?0Xn/bmIBJogxxuJIeiOvX9nK0tmlSgN7UnBLLDhDgfQZyjdhsIUwDYpLfsC0?=
 =?us-ascii?Q?Kk7mizvbzSEXASenxLGyMwzb/XA/QyQOOsAbshV/+A1szwsnMV888hSY7bpE?=
 =?us-ascii?Q?44SvGNins7dKwOTKZ6U26GV9yv9TMNyYR9cFV2DxVWOiBw258o8Mj0Iw+pyC?=
 =?us-ascii?Q?XqcPzvzgoOuDxpV3Jn+XaBJHiBVL0klKwkJ24twDkpsg9xvE/CzynOYgEa4T?=
 =?us-ascii?Q?KoGQw2BZcXEawGffjgIAqs+fGW0Dn3bC5bkOfTO/YQUrtciRaD+cMOf2/oQK?=
 =?us-ascii?Q?7TD9092EGbRdSWs7r/nXger9dRZX9EaW1x4iRm0ww7JrLwd0Z++ki95e9zFI?=
 =?us-ascii?Q?OK/SasP0mN07vA/JcCkU5Y4c/yhd7Me2jnno?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1yDDY6jPFIAE4wWpogGi3bC/khWlvuI9kG6LLmAqCwQ0j/39fEFqcUPFVOn?=
 =?us-ascii?Q?vd9t3yKFjYogePBusZaM/9CmZ/SNjL2fLNn06zQePY7Yz2OW45fCTWVetKTt?=
 =?us-ascii?Q?eJXjA13RJm2pcVEE4NynqXKseABzErXWNi2DMubtdQndn/8p2lMgObk1RHg6?=
 =?us-ascii?Q?YlWJNbscTWfWzx1wZeQA9G2y//jTQ2yBG2jglcxXHY+gOcnAAOCSf8MQ02M6?=
 =?us-ascii?Q?s9KP+y0p24zu6AUhs/WVKQoWeJx5KCnNyX8eQ7Bi9ZkDm6yZrDP5rYse0QBN?=
 =?us-ascii?Q?0pQ1HCC7zzT9/tp1GNLbv/YCa6jMt7bqFUsb7/Kny4avkG8LBGAEphIp5+oE?=
 =?us-ascii?Q?O6rCHvX5lw4LkhZ8bt3lrGuTbScTiGYZS+6ieCao1zDzTtSEc3f5S3E5dW34?=
 =?us-ascii?Q?eum0SfX0SWWzbEWayhbNwzR+tO2MGX5vKbNnmBIkAlspxun8vh4MzwPGTsmW?=
 =?us-ascii?Q?CcaQfq/OQCNqIwZVY1CpEhTh8FRboxmfWg4pPhiDaUbcFm0xomMcGeKg7mDT?=
 =?us-ascii?Q?gt9SpgwdhQHUWMMzl7L5b03sF1RVEsrayztqZnySkbUMaDKWk/yUkUYZzvkd?=
 =?us-ascii?Q?m+ImSm81akQvQPHZDdJYOMdaHQffhIddxacMGDAg0c9RBG2VWd5sC7Nk+1oe?=
 =?us-ascii?Q?UpiCLI5V/LM66CKH3kKT6FkW7TQINuu+aof93lLKopaVFfUvky/cIASDlTSh?=
 =?us-ascii?Q?cOwjVd7yOX5fLr05PvvV+C9bQQv7a1ZYonvqXahzX4FqreEIiOqM/zxgKdQ7?=
 =?us-ascii?Q?e4X9dp86hGUaOwT8ATLmdi1susX1Elg6/L9jubHxaM7oljGsUqMcVquzBjsq?=
 =?us-ascii?Q?zl3SSP/shCtaUdsJzcKHqNhjXQQ/wRP2SJ/L1QEMF5Vsn/R/k83yFzq3f4Kz?=
 =?us-ascii?Q?g2j0wFfsGWsEzHtxog3nsfeaFL8YWw3byE09daKJsWZ4GifaPpaVcAWUxn8O?=
 =?us-ascii?Q?eR1+pHtzDqdl3MtPd9LlVqkcpZ92sy4WuUTle0i9Q8aBcKthl6pN1nVl9irZ?=
 =?us-ascii?Q?Pk3zktUOuMIEgWKVptj/MDOhklZHLyFQF8dNp+/cc09wJinehq9c8wrAQUIR?=
 =?us-ascii?Q?0+tE/G66s7B6u/t5GIvAguA/CKcfuQZUeRG9Zr74fMUeRhDUBcmfhGjrTRYo?=
 =?us-ascii?Q?9dE4osVSQf0d/7mOl9KvI79ONZZvJ7xocHfRUqVt80C7pnLOH9RgOafJn+24?=
 =?us-ascii?Q?3fH9PQimRzS4xlwz2Or7cIdxYllqphzjeMetm45x3timp0Ker9E8AFkjPkOm?=
 =?us-ascii?Q?N+A0umdruBw7bc4HJSyzm39wa7a31YD15Vsq4sdEceG6PWn86aOG2UYQ4ilE?=
 =?us-ascii?Q?GH5+HwVzWxo/moV3Ht9rJGH0tKCuDNVpvgGwnE6/Rriib4k3zunQnGqB6Yrr?=
 =?us-ascii?Q?VE7ccB57Ttrj92Wf3vFGFI9jqxjQSR6X4msk7ByI7+vyB7FVyySkNsHtJo74?=
 =?us-ascii?Q?gfzdz5cYD2OiQEYwX4tXJ1wpkUQ+SKtsk8c4igIiWZQn0+rTNMCj5U3OIS+w?=
 =?us-ascii?Q?y9e3DHp/j5imUEgt8QFrElI/wm1nFM4x95W9S5I7FHP2LN7LPieudDfDkmay?=
 =?us-ascii?Q?iArLRc0O2SuTRzf3ww8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ce16fe-ad9f-4e5e-ae6e-08de062f2d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 05:54:42.6381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjT1Bi9xcZ2sSct4jIcjN3uxM4G0BCKdCxk2cqApte1TUPWBzaDuKvpI5lgAs1JVIUEshfArfgfAYZKtXkPL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

With minor comment and patch description changes

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, October 8, 2025 10:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset

For SDMA IP versions > v4.4.2, firmware will take care of quiescing SDMA be=
fore mode-2 reset.

AK: Please change it as >=3D 4.4.2, same for code comment below

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 9569dc16dd3d..0007d00b9e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -88,6 +88,10 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_devi=
ce *adev)
        uint32_t ip_block;
        int r, i;

+       /* Skip suspend of SDMA IP versions > 4.4.2. They are multi-aid */
+       if (adev->aid_mask)
+               ip_block_mask &=3D ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
+
        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

--
2.49.0

