Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6E6D46C16
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 02:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0929510E7AB;
	Thu, 29 Jan 2026 02:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdN6mAt3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E05610E7A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 02:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyR1PWLu6zLeYfUEwsWHev6w0ZMbowJLSh8PuckpPTlPA7CchCtc1//S+1XSYF6492wS1jPZrxlmkG3bS62BWbDwa3BQoT+6JVS1vXYqGgAIaZJQBaqMz8bg9488Mbo2wpawVhQGOfMUjpf+lTTf7cVhb1dGSKuJFSmwaBynNNlrDAiCDMfNzVCUGePJjpuTTTe8ujYa+4yewgJFbQX+/Vk+S1AWPLhqrjNc23tppKZL5msRP4FQexiQrfVdUtky6Gg1IxHgPU4FbjOpBCCQ5Fe3AU6OYIvKWXMLZctEnUa2G0sdRNb/SmmQfB1EMIau2dk/lX0ZRu2mNyt6uqeSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YHtQr0bs+mIrB2zNaXmDUzl8RFu1LbxKGjk6aOyz7Q=;
 b=vi7scoZYUy2usRi/krFc2LSoiHpi2g7CWUbmtLMd36/wxa4Zy50WSyBxN+matHLqxbzbcaBb67CU14D9m/OFg1fgBviM8RrxacXTd4CPbJr/Oy6OS5wJYGXobUEZSTgopo/ob0sI34VpPr1lvV2tI6e/DpuoEQGQuDu395HK4VJ5V4vj1HG3W8tKfKEMDk03tvj2FhCl5rqg14OwiQbP2wTVSNLI6aPQ3xqpOWHu9nwaBIjgfZ7Z69ENDg5IJEELeKEZ9R78If7EU9mKbWEfnIuiEqwR2vZalMwnUd9kYJs9NPb6wwJc0yKQkls6vax7u5/XyWECkUEVoNMCXuQ/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YHtQr0bs+mIrB2zNaXmDUzl8RFu1LbxKGjk6aOyz7Q=;
 b=RdN6mAt3Z6UYXbIz+8+XVW1Rsix8fkjTCtdVyPyZBM/31I01I3yb3sHAvcZTPh0QD7Kwob7gV6tQBnCGrAzWAAAylEhG/K98niiNcWfeHQ0pSz+8pDSRYiBwlRqcg+cDJmg2KoeU+yAyP67zOb05sDsx2rx8CTGK+Nu1el1xqTU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 02:32:25 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 02:32:25 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Thread-Topic: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Thread-Index: AQHcjneuSJtxiAFxOkOMl7WpU+BzDLVocXrg
Date: Thu, 29 Jan 2026 02:32:25 +0000
Message-ID: <PH7PR12MB59975DF0C09788ECA4FF7357829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T02:30:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7371:EE_
x-ms-office365-filtering-correlation-id: 59de57f8-bb61-4154-3901-08de5edea375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KvBUtwvK2e710T8UYAkmtYzlItuhO/6SmGALlJClIJB4uvtTjVuBQAoG8VPU?=
 =?us-ascii?Q?OTH1cKKRHml1qOXxCeBTuua6ZZmeS5yjOqtNAwv3A+wEb2IUvlOV7uE1RktW?=
 =?us-ascii?Q?8wXZd+AiL3vHthvNRUB6ljm4k/YYimqq/JVHL8DlF4dFUlGdYl408xOv7fEt?=
 =?us-ascii?Q?+2x9w8coDL2z9wcio2lzuQLkBHe3mZ2nSrODsn1mtnI/UKkFpLNjH4it3/Oh?=
 =?us-ascii?Q?oAElxjpEfAg4Zv1KZH5ZO4ruXhmvbxLQs5Do/H1JpjvJeLe3cqEklykzBKFR?=
 =?us-ascii?Q?MwTP2Ys0O5BtN3LAotPuGJnR7wy3ruaphDO3u4vLDb9GknxrGTvMm2Fmg/If?=
 =?us-ascii?Q?ZfrKs3NYdrAPsh7DJlgTpbey9ln+Fr1Cdhq7PbIre8kQQPvgSxkqhwigZ+JU?=
 =?us-ascii?Q?gfwB6woPz722/EKT5PZNjbo35dyFPg+/k7NvWUIRY1oaH5sjJ/5zG7MgJxNA?=
 =?us-ascii?Q?nRmnGg0bp/P+aKCWu3Dp0VfKt0MaJ46sKFj5k86my8EFKlL+eDhOaSNpBCib?=
 =?us-ascii?Q?a115brX28Ic30CYp9g+Q7WGANGuLSbwhY9nnYm1Nn1nX72bLLXx9QiOr2Fjx?=
 =?us-ascii?Q?QWHEahIeNZWoyTJAhvy3JGf3oYM8pqBwlkAWPFSx2SmfHnD/LFH/99/O8g4y?=
 =?us-ascii?Q?zgN5mbrx4zgW8f1ErRN9HdJsgwDT0oMUMB6gz8C6H5Jm5o0DuV51b7A3iGER?=
 =?us-ascii?Q?7rZP83xpqWB1GBkLiiOyUbVapt+SYhUTGby8j/lKkPPv4AyJzOZGzClPHCFV?=
 =?us-ascii?Q?FdksqInSP76TzB1X4drp8+iHkXp3bPGYgZR/NDW65B8sfJv1iOK2ZD4kKPRW?=
 =?us-ascii?Q?OayCcTo+L5LWpeJj+N9JXU6owdpjj+Nd7E4vqnmiSOSAY7BtPpQgUgu5HtI1?=
 =?us-ascii?Q?wfIxmq8yB3h32EWtlf7jwVXQ/VL5iIaOouXFfrfhOa5BhijWJV+2X2c1N5a2?=
 =?us-ascii?Q?G0YKiAJRvmFlrsCPqbP409RIkai5HXiOkesDmBOTFBUsE4p4VJPVOBlPW0fU?=
 =?us-ascii?Q?bt55j+EOatp7pze0+G9JZ+xe37a3+vX2nkPM/LOS344dq4uS6wWRY0NCXZLZ?=
 =?us-ascii?Q?c/cDbvljpYXuYIO1cCdIOHp0zr28XbgX/dNZljFmhS/SmRtHgCRm9k3+t0hq?=
 =?us-ascii?Q?Dz6vkLFEsbz3lfltc5SGNKaTqAQqDutqn9etWUGATevI44n1HkxrCzsMBgeu?=
 =?us-ascii?Q?FX1855RwT1H20GjzHWMiJHECSolH+Irf6908bQWIBaXzTakiOYm3UcPOP1YK?=
 =?us-ascii?Q?VY1LK5XbbiIW8nmsoob7TIGwtP9tN9npP+gYE75OCF/4kLkhMPZKeF17iW9y?=
 =?us-ascii?Q?Vx37+xBAtyFFr+cK7MvkMfnaXRKvJMsmTrI34D1cLG/7agBAJNLJmcgEldur?=
 =?us-ascii?Q?cKOG97Yei9Nbu5fPlKdhwh2lAx0XIo3pKLCpc5N8cPJqSY89uy8beXueV7+/?=
 =?us-ascii?Q?eedTpef+K6+usPmGBybY9HUK0PQVEkMqCaD/ZuHXIlMjd50tsZFPRDp4xi+q?=
 =?us-ascii?Q?rkSpbwf3L36wKZ0WPR7l4ZH6MVTZcAN5hg2AQpk1PKLpFAv3yCSz6IwY9k9o?=
 =?us-ascii?Q?J0Ksz6t7VLbQpSUe0Quqcd4oPDhfF88JjqahXgmXpubJFH04jtWllg7zjEUL?=
 =?us-ascii?Q?ahCotAZ+F6NGsjlzR0k83HA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DTC2RKjZnwFd9WtkuSp8FTIcRVfyvpY9cROw48skeMiq1kEO5uLnuJEIPzl?=
 =?us-ascii?Q?5OEX/yYNIYTY02/JvqOTTEwx5WuI3x0b0myhRO/1hV073EN+ivimyCxXBM/a?=
 =?us-ascii?Q?i7Y0oFhfGCM4JArcSvu07xKY/+DvpwTYlUESn6iz6hVGb1dJ/I/5H2+e/a/R?=
 =?us-ascii?Q?mxsX3cNrJwiiIZ6xGP84QLIvQnQ/z5bSvKH1qrBzCBLJkHOz6ngDeUbag+aD?=
 =?us-ascii?Q?Efv9aWHffHYZ6VDwcSw5l52tVFu29MZ+2mou2QEzy7EId3sDaT05rEWII/Rj?=
 =?us-ascii?Q?nODlN9Sq1/nKWbthaHbun3pPCFesVO7YjKIIF5Rs2FbmjGdH4wR5iCjdUB0J?=
 =?us-ascii?Q?cWSfzDFMrLLPnQ2DHVwGG1pRTiHyu4NwE1JmbquOommXgchDNpiIhZg+xLcC?=
 =?us-ascii?Q?068nz3kIOL0oYu5jxhjDC54VrDrtZ3lCYCSnRLn4YbuvvHfSObCss1EMfvWD?=
 =?us-ascii?Q?xQ+e2JkaUl+ewmFrlnR0KlPReV69/RS6z5DqQBZhFAvGwnOgsoyVv4FrhMIS?=
 =?us-ascii?Q?3uwsUx24wJ4P/7w0N3+QzISvQfc9UFiPIlUJtRfKOVnZ7DBLayqV2hg3qGXO?=
 =?us-ascii?Q?8t8Hx1s0t0MIvOuwfmiqPgt5kvjP5h3j1DxJ2WlEF24Gdafak6Cpgz9JK1Vy?=
 =?us-ascii?Q?l/f016Tyc0oEuU8xguMAMCzolax/cNv2U8FtP8xvgcwteOBj6WxgqpZgnNDr?=
 =?us-ascii?Q?P6GF0Thi2eO6uD9cZpxBrRoqdijsGpgc7B+j2SEOeireLtK4ktefYGxUmEqu?=
 =?us-ascii?Q?koyjpQnDEks93xAK4wkwWH/xCyxOxFg4YhxHXf622bcdqs0dLN02MD/Gc1XY?=
 =?us-ascii?Q?+9eAxhQD8Raltd+PwqXWL7412roGnCACbDc1C45r9fAYYOUNi9GJBdNnGsYr?=
 =?us-ascii?Q?TALlChSRUrJY4ctfhnHW6Gd7kK3bZBwgCEmzUPoLxz4c8ODThv9MVkcHBnz3?=
 =?us-ascii?Q?spJJXs8OA1dO5TyhPbgy32S4fGZlcVnr+irdwVe6feYkdcQgEIswNDxPsAE2?=
 =?us-ascii?Q?LG5/ephC5ZHzc+O43D+KXtUAW6sYetJFxTtib2Nj3rsTC7TJLLd+p9DfG5tv?=
 =?us-ascii?Q?zJ07V6u/MyJNlrbpkICVActbPRee8mHOjeFQohigsOUqJo8Q6qzDVGZ8qtBt?=
 =?us-ascii?Q?4CydEfQjWn+qQzfW+I9n7fiom7mriHUh9Q4L/kIdj0wPzSyhMkENgX84g0Bs?=
 =?us-ascii?Q?kRjFnaKPikscS1aC9VrRmx/Qh/uLNf/ai8xXyme43B05pcp4eT+qho7/PuiL?=
 =?us-ascii?Q?KDajKDEdn9nOS+wStUniSE2L9N51rZSmeciAsF9M/CprpR+w0xf9DoHq9kda?=
 =?us-ascii?Q?ptcDdVMeNPT0ngS+j3OCDPI7yiLYvFgEGSTql2O6gf7wZrwEytFzzUA7tkGV?=
 =?us-ascii?Q?XQ5WpA20Sb2G/tE9OWSrrisGrRX43gm515CSLzIC+8uhYDJiL+qaQZRfoDJ3?=
 =?us-ascii?Q?nFmP/WsA5NOKK+/2hNWG+gzMx25i5uo0D3UFev9H5KA6/voNO1gxe+omF1Yc?=
 =?us-ascii?Q?zGGhcXj5IW8jGpDWGTly9rqltAaCza9RjfratAO09I445Lz1/tBdVqfoZ5Yy?=
 =?us-ascii?Q?K4ZyPFe7dAwxMNR2XU41wmWv2LFqEF0ZmCn7EPEc1RDiJDaKH0QTAISNpdpD?=
 =?us-ascii?Q?pk3toEQdAAfnjxDGLhAO+W6i0gTpxCfL0iIudxLvGsnwRgobeEgTVJuol1UG?=
 =?us-ascii?Q?eFEiC4GfpyPFGp0WiKUOfuS0sZF0G1dZWI/qL20b+TmmkUyF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de57f8-bb61-4154-3901-08de5edea375
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 02:32:25.0745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2q4L0Q/UYaqeowmxrq0mYusW6BMLYphUj5DUja6/yk73XT3bNQGLOxorudStvI/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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

Reviewed-by: Yang Wang <kevin.yang@amd.com>

Btw,
it is better to add sriov check inside, what do you think?

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Monday, January 26, 2026 11:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras int=
erface

add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 57f4069bc827..81b7fafa1817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3505,6 +3505,13 @@ static int smu_v13_0_6_ras_send_msg(struct smu_conte=
xt *smu, enum smu_message_ty
        case SMU_MSG_McaBankDumpDW:
        case SMU_MSG_McaBankCeDumpDW:
        case SMU_MSG_ClearMcaOnRead:
+       case SMU_MSG_GetRASTableVersion:
+       case SMU_MSG_GetBadPageCount:
+       case SMU_MSG_GetBadPageMcaAddr:
+       case SMU_MSG_SetTimestamp:
+       case SMU_MSG_GetTimestamp:
+       case SMU_MSG_GetBadPageIpid:
+       case SMU_MSG_EraseRasTable:
                ret =3D smu_cmn_send_smc_msg_with_param(smu, msg, param, re=
ad_arg);
                break;
        default:
--
2.34.1

