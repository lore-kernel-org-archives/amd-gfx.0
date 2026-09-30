Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EC8CA5FAB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 06:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB6710F1DB;
	Wed, 30 Sep 2026 06:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gt/gg1Zz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAFA10F1DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ako0lSQJTktI4pMxHfHghJYvnidck49TygIMFyhA5vIfnvin3ICEjjJngQ5AApoRhJt001u4jjtQq06YeFLwcp7O1EjtC2/JDmPrqUvyIX+ImW4O9huuKRd3DUEErl53aePZunxwXqFhQLkRP6E4j7nPxR7sMHiOrJ+sWqxipmq72+Ib+jUuG20NMGY/A/FZrySb+lGpkzloAa6HckGoNZUX8UD6ydgReZjP+Qu6se+vvyIKXsb9dI1piIkwvbczvjhWRIaFSo+Xa5X+pBc/qJaj6ISJlVTldHGQqNAR9y7UwBzHAOx0kTeUbRq03TdnyI6vVqlNN7Sbhj3UeOVNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un+a52pLP7VyUpzDtxTGRdaQkqPAGJ5Zryoq/BIPWQA=;
 b=x3sHsiQ4VUaQ9CVDtgECbMO/Gizu/34PughHHH6IBpgXN3im+91msG53IbcT1OTKlK9EIsFLtU1uLkfbE+4nV1DB6oHgzDgV9qK4oXLDfqrYBmWpOtujd+8N7w9KpOou1vad7Z0Hcx41g85XZs4AT+SPHr/Hb+0MBX7osWU2l17LVAULbi7sxgJGVrulgfik5Fe7Nl3kCn2y9AGMPSw8vgVy3NiHT50bAUjesfgigE4DzeE+BjJq4/ECyrB/4A7fxRSdSMblndiSVl9qcVkgdyX7Mksg/7UGy6hMpwdzuqtYDDzy3oK6DlsmhaA+BM4D9VTCjAYoRmPB73r7Z2ymOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un+a52pLP7VyUpzDtxTGRdaQkqPAGJ5Zryoq/BIPWQA=;
 b=Gt/gg1Zzt6e1W+Qisv86BOFysdFKMA0c0m3PzbVkQFvaJdjqtggp8xCDH0ApoyGY27TDxmyukshP4jwEywOxRTuc1RBec5KDhZ1W5WvEwEoY9RkzhdBIE3ibY8xZdP0cXhCqlQaUJJ9OCHWKZEVZu3yW+L+U6ScI+ZEKwFpNowo=
Received: from PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:32:43 +0000
Received: from PH0PR12MB7010.namprd12.prod.outlook.com
 ([fe80::dd46:c4c5:9616:daad]) by PH0PR12MB7010.namprd12.prod.outlook.com
 ([fe80::dd46:c4c5:9616:daad%7]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 06:32:43 +0000
From: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
To: "Hong, Chi" <Chi.Hong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Topic: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Index: AQHdTxBHfNaTUsoRCkidkpaFmONe/rblI/3wgAGIlbA=
Date: Wed, 30 Sep 2026 06:32:43 +0000
Message-ID: <PH0PR12MB7010F3C6EC07687DAB2E0CB8898B2@PH0PR12MB7010.namprd12.prod.outlook.com>
References: <20260928061148.117428-1-Chi.Hong@amd.com>
 <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-29T07:06:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7010:EE_|BL1PR12MB5705:EE_
x-ms-office365-filtering-correlation-id: 1c79a435-1d12-4fec-ab18-08df1ebca268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: CXBsDyr5rPpEA33bvVr96iu/O9v9tIkA0r4DndWuSYVYKkoq8NWIXjlHvXcCy+qru/R7BglKw2I7YaPFqO/Hgag4pYERyUUbec0Ct+bSL3RPiF5gJ0Z1IJ9iAeBcs32du0C5SUjHpzjTbPLjruF326xpz3mR5MAf+v3GdyzRxU7SpMC+oHSfh0p+zWR2phIH3ARrrUJ+MG5Pmhde21WU6OyWD9xlN0jcCmGyFT111bg9DAh8U9JMlQVgPUYRWe1IGoy9BKaQzcXOVI0vbDGSSanSxi86uli6USf1Pymnz1Pf/tAt+hl9xyfgUyRi02+eaoHNtmd604CNocH7zJZbvLH0EFHdKiiGWSPr8czxMyWxl3d+LJRMpI7HgwCeWI/PZW0pXwSc5uzqr850AAucHpitKvwVEV0AZkQwHUYwXbYcNQiAfIgZohx1V/Gn4wBK3olM8GyQmYIAB4grdsx3hf0cjTRIPD8OdZiBI3kdRGTCinp718LXWkHpcRgZIaVZxUcpQgHuhiIbI+1UahMfavBAId4vFOtYme/WB8VtizrxxUVPRdnYdh9nD+kjCHWzB6C2wRcerYdQr6S9hP3nTTqCojgos/YJuCPXRsszWABcio2qix3gv0AqFMAa8vhF1LLaR/NsI32b+dbkVTQuck84Yo01169ZNoJ4T7x5RftcMO/VUA2z7n+ULIRd5ylI/oK6oG9NOjfmZFYwkdJrjmCUQisXX/KM96uTtk0aDXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7010.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lYHiWVDhuWEJhBCmaYluAUlbqm7qG3gXpthI0S84W4u2SB7DwRbYrlu52BC0?=
 =?us-ascii?Q?7SI+p5SSIA3M84TLHBuCKLqWrgWvLzYqh2mokn3D8sYzhf0cTA4Ye6AdeZNK?=
 =?us-ascii?Q?8lvDFLHU8RQTo/Ymq4lLVIchjdRBaUF+c/VmRGyZPm/afU/nuNxmcV8ZW9xW?=
 =?us-ascii?Q?w3SYCN02kWbYIRkemrFnEUJLu8AyG6ffqZk8vUIiOoAMjgHxuUTA/zxbSkqc?=
 =?us-ascii?Q?7hR2HzkuxE4VDwcYkRnbibvuqW7a44uRq1haXnlwSNuZD4EafHcRN4WwX7yq?=
 =?us-ascii?Q?gRt6pk5EFXwB8Pvd0pdOdMnbvKcwRposCg8QTt25mFwF/jhv5Xz7kXwldz8n?=
 =?us-ascii?Q?M79nGg2KczW+2oJvLwrN32ygnDXKqtHSWzEV87TPVvqTIADDszj8ZK12FM6B?=
 =?us-ascii?Q?QC38huhVbqR92n0X58H8g5p6miW6IsKzmmyMpV0o5LIm5uHQyy6NKF69ktOg?=
 =?us-ascii?Q?gYG8oGoDl/20u51k40lxkqFoSoxYYwpASYvePVi3KCDs1OEj8t9pCYwmrzBy?=
 =?us-ascii?Q?hf5ShCvrnBzQjGmWic+Ek/a9MgsB+yDmYFrfrdfCHLt+z0YRCuUG/yVgU49M?=
 =?us-ascii?Q?flhtl7blZSJGTXGYKZ0Xd+1i8AOFhfcX93wa5s2jL5YViU2gxPU1zw9H5181?=
 =?us-ascii?Q?MNbauR2cPAWNmExkvuOt644JLh0XJBC2aRSycUYBisBZQr5Q6bdtv7x3oeW0?=
 =?us-ascii?Q?aW6xKRWMeZcXJUuh0vt9ts8NYk1gQZNpS7dzPo/eEcjVixtOmfEwt5E5Txgw?=
 =?us-ascii?Q?Em6W6hZZcqLZKg4LD4gOlIxsU4H3v35U8m2F+9xm79o0KbUXKfl1GihVzLW8?=
 =?us-ascii?Q?xQAdij48nfRUuyhHFnVZJhlLNY4SkuD1wU2Yf36MWaF2ic0cBzh2Y5WIedAE?=
 =?us-ascii?Q?loHnbLYb9cAYr8nI0OAqbDDtheKjIhEOfB6DEmAhAnQv/+TI2wxaiZca2Ud6?=
 =?us-ascii?Q?bzlTnWprsNCQTJvfiUuMgI8tP6DlzMeQPDY/Mad2cA7vIdwMCAXL9zbeRSOa?=
 =?us-ascii?Q?nhRz1sUaU3zUbKPAzzDdL0tnhiD7SRcIobyfItjG0WLObS9Pa97jCZj+tThS?=
 =?us-ascii?Q?3niDC2OLPRQrVUL61P3gSuad3GbZQ0bm7vlTeGPlaFPC0vK5eY1qAVF0xrrZ?=
 =?us-ascii?Q?onjJpmErme4G+Sy/n/BmPn/wCmNwTU0/Azh9aOj24ZQ8hw0HvszO1aq5+jWz?=
 =?us-ascii?Q?tUNy2+785uWz0HL2ftwLrXYDJRRtGSDOSOEtrhyok6Xl3mcfFf/ILkzgf39d?=
 =?us-ascii?Q?DwK/41HbbUpPyEwlzVw0sc/hRhRLkzY7qXQ3AQy/FDPS/UMV6q+C0G1+MRhf?=
 =?us-ascii?Q?ial/5YOKRU53nmWCWmMXtuvT2JGKSWl3ReQXIv0rDPt6Y2heS9ECUtYzzIUQ?=
 =?us-ascii?Q?g2wk5prZzytFKCId/jz/QMk+lw7x8po+hX3ae864CMGo6DwOrP57n/ORZVem?=
 =?us-ascii?Q?0xSUbGnF1yQ6DWrPojLZZrMm7VXYw81PGTBCWbjODYXawLpVwoKlj4YWK/Fp?=
 =?us-ascii?Q?HquXOk5vKMR/ZZLo+8MF4YZkz6BUP4/LdS8J3VmZEyk8WyXY0lRKJF/IxrMW?=
 =?us-ascii?Q?5UgBlEhXOp1O6hBfyYRz4aefY31COGcEhabNk6+0FXXEvxsxHkdjf0atdmRH?=
 =?us-ascii?Q?ahvr9TOVgMmzSntSwHEkfEN6yUH+fSi007BcQ0iwRgLhR909Bch/xuKJ444w?=
 =?us-ascii?Q?BFQUUeOesTaAwDqzlNH5osCslqSH1uFQFABjIGavoycRvcqd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c79a435-1d12-4fec-ab18-08df1ebca268
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:32:43.6840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SBkh9cT+7iCo7qwimrd8Nqu2ELirze6valmgmA2ut9E8NVnLJa3+JqWsQvHElI5nCEfH751Of6EpERu1TCPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

AMD General

Hi @Lazar, Lijo,

Could you please help to review the patch Chi provided?
You can contact Chi directly if you have any questions, thanks.


Best Regards,
Celine Zhang
-----Original Message-----
From: Hong, Chi <Chi.Hong@amd.com>
Sent: Tuesday, September 29, 2026 3:25 PM
To: Hong, Chi <Chi.Hong@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for=
 SR-IOV VFs

AMD General

Ping

-----Original Message-----
From: Chi Hong <Chi.Hong@amd.com>
Sent: Monday, September 28, 2026 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Hong, Chi <Chi.Hong@amd.com>
Subject: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for SR-=
IOV VFs

SR-IOV VFs use amdgpu_virt_ras_hw_init() which skips ras_core_hw_init(), le=
aving fw_gpu_mem unallocated. ras_psp_reload_firmwares() then hits the NULL=
 buffer and returns -ENOMEM (-12) for every VF on resume, aborting
ip_resume_phase2 before amdgpu_fence_driver_hw_init() runs. The next hibern=
ate double-puts IRQ refcounts causing a WARN storm.

Skip the reload for VFs - there is nothing local to reload. The post-reset =
path (amdgpu_ras_mgr_resume_after_reset) is unaffected.

Fixes: 5e5be56a5b76 ("drm/amdgpu/ras: reload RAS TA from ras mgr resume")
Signed-off-by: Chi Hong <Chi.Hong@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..5bac792554f5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -529,6 +529,9 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block=
 *ip_block)
        if (!ras_mgr->ras_is_ready)
                return 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
        ret =3D ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
        if (ret)
                RAS_DEV_ERR(adev,
--
2.43.0


