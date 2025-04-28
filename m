Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2CCC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 18:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F179710E231;
	Mon, 28 Apr 2025 18:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAAMp2Wd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ED710E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 18:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeyyJ1UQtxbXvR48S+A/9WpDkUua2NKzNXSIqrjCm64PfRyoIcmvI2HhYy9SLOgth8DnMP1W5n8oZLXiaDqunajjX9uy+QlSWSETH19xAZNqQPofashDGVjsCo7HB0n7Ct3/ynO5KpSn21La8Jcg+WYPcu2dgDS3+jLYsegO5CdWt6cz1FORUPWSKnEgAufkUM02JatTyREIrJ0kxV2JYsvGHGLCBb5V7xk4kl9b0chlGAPmPl6e7+UnT7T+KWKHyea3LEUd7ZWThfDfPZsAGvpB5WaJIS3bA5INHN0gqaODwK15iq0v2CcghM1hpdd1zF22av7u6sfv710FN+wO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9c1v7HVZTM6rvEs5/U12x4taWIOlpbnYRdZW9buupY=;
 b=pV1/UjoDwPrtgjX5IoLiZN0U3CnyPfgfCB1n7a0vKi1QLxTttQOCjOMmdgTyVCG7wv/ctyaNEgq2Iy6BJGaS/wjwPhGayn7R/89fpx3m1/ZDG15d3UVqsEiJ4Ce1OtjELXjCogFQvYQqm0qMlU0hk/ul+zWOSXIUCLFnSL6QfXyIp4q+lO8YD7P2jKt9tC3FOo7HCxeHpRzIbKdRouc1EyDrsJhSv/mdTNSGkspZs08hliEgP8DKfue1GTeNGnFA6+lQN+CQgi9vAlNpoynN59zXCeOwISo7rAwuwR7g7qb+FqG+Wbx26wCVGI/fqqflRKxVAWB2aJpg6FTqkSAx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9c1v7HVZTM6rvEs5/U12x4taWIOlpbnYRdZW9buupY=;
 b=wAAMp2WdBwlhJpVmvDFvo5mTciVsIWFnIpZ3kiHePOthvCvY1OLz5qqtRgHK6wyYwQaYlpVmOA424uWilJtvzFEwwOlluBYYCOPQ4Sgi/bCgKrk/8jwSxxp4MrxxYPzRwTSYepbLZ/Ehk8zi0T8S66k960qJiNsQwYAkX7vqj9g=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::993) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 18:30:53 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:30:53 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
Thread-Topic: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
Thread-Index: AQHbt+bvloPXbtWON0y6CO6m+8bu+rO5Z0pg
Date: Mon, 28 Apr 2025 18:30:52 +0000
Message-ID: <CH0PR12MB5372AAC37A9D12702BA93F37F4812@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250428024010.1330997-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250428024010.1330997-1-Jesse.Zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=95cdf012-0ec5-45a1-87c0-49158ff01c4f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T18:29:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SJ5PPF4D350AC80:EE_
x-ms-office365-filtering-correlation-id: f20576b5-d1a9-4e2c-e35d-08dd8682ced6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0Al/RWbDncf8HfpNQUXIoMZoHPDElqAB4lrQMiUeB+wqS/L9Cx5UijHzy1IX?=
 =?us-ascii?Q?QPYPgoSHQH28JHz9bTtgnUkUABOIeMQD4H1Kb6zHsF3gxrrHxzTJR1Tv3ioF?=
 =?us-ascii?Q?rdsFUPp9Yu+qiIb/pN6IOD2gbVCr5sAlJodO1s6NXWdMbyjMqElYTw3kqAYd?=
 =?us-ascii?Q?DZdrPRSMS2s8SKC2oLt1OIefUbUimafbvxdYJtpsViKWBywzd72D0wFB4g7V?=
 =?us-ascii?Q?I1DKmxuuobSNmxeXsXn/RwCR6VNp6uyq1GUxoNWSn/F6xJDsir593hUTbYUJ?=
 =?us-ascii?Q?mV6ihNiflY4ED9g5dS1tkjnhPDvG1GEsoGjkaEMqYKiskL69xKiJBFOEojad?=
 =?us-ascii?Q?vU9Qzxj8hqj1VPDrQCOLd8pw4dJVzz+k2VizFVbNFLhmce2yARTHRcMA0wWB?=
 =?us-ascii?Q?3FQxMaoodWtY9ze/p75aknWQObbyZWltBtuoPnB+Khs0OKVGSg85dNRg1+Na?=
 =?us-ascii?Q?JUg3LoRUwNzsmCOlZ5xJPXlebe0L+kwPjARftsiDMDG5dEXm4jOgja2dOjoI?=
 =?us-ascii?Q?WURzV5f3iNUXEM6x+TV9AzwpJ060ldgAvHulRbZHpcPamzFlePW8p5KwCTAR?=
 =?us-ascii?Q?8IDjSeC1CZfgb9WUCAlfPLoz3YjdMxv4ekhcnvmaSm0XxCtUuGOikn4bRprR?=
 =?us-ascii?Q?fghnstP7WfxTa6GYihxP1mA3/7bVn9gAK5E19DQ8Whv/3YIk4etlQDIHEIRq?=
 =?us-ascii?Q?J6SVQTnFBaY8KhKnTSzXGPlQ5qkwOOXZ97Qpt19DwrX1khrNgmHqb3cDDDkw?=
 =?us-ascii?Q?fKjQwLzbRyarWs7Y/Pt/osTqxCJ27/TS1IzhOgZInw7AoMSlWThxwznVyCSr?=
 =?us-ascii?Q?sjdDlHp9aNQmRWt6cEq6f2Jy6PDlfVY6STu7r0o6pS+sYG/l5Mh6Tq/wxANe?=
 =?us-ascii?Q?wnL+7dVXbUMkdxN8hH8BLBwYRst9DTtpzLfqvsDV9A0q584LGOccHO2dhsRY?=
 =?us-ascii?Q?YPFWZJTGmijQSZZbzxuLOtxUycpYf7FcDfwv5gf6QYRHYOrHyhoHXDCjeIVC?=
 =?us-ascii?Q?MCY4AA8uu23EkVAt34S92Or1fnKv49GSSf2UA+temLzFQngOagQN+ofGypti?=
 =?us-ascii?Q?ocTX3T2IbGbu6aYzRB3jjLh/JGAD+1ZcE69quUrq9o+m/VQ4qZNCTsl9aC8n?=
 =?us-ascii?Q?1o9tUG5XnPDsxjf+m1Q0nzq/wIbF1phtjZS2JRZlV8dyWNs4nKELDMZOBIlk?=
 =?us-ascii?Q?ax2yexm03HIXT9omyPMswdOh/xh78KwHdlM/43uBCTpg2VQafqI3oKMWdrh7?=
 =?us-ascii?Q?PFyqswuNRxv591AoDair48Zz6B/y9xOU6M7P2EAK2JuUCHl1WZRI9OogHFEg?=
 =?us-ascii?Q?uWjUxdUyEw+5Id1sFS173jD4a8a47Jpn+/yg6JnZvZW6kqsxtybsMPMnY/re?=
 =?us-ascii?Q?imeCTeLSH1oflq3FKh0Hta7Vdi7DQ+D/2hB6hgPMiL3+sdnVZ9JnQufV6EJo?=
 =?us-ascii?Q?ow+RPeywuqUWbO/2Zz8F5AJZAifVolyc/93kMDrBZwfJEGLELLk/qGzVvN6U?=
 =?us-ascii?Q?DNBh90y6Z3lompw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yuIKOYVJYe/i54zXTQuzJKZp5kc9o1FG1qw/oYt1V/IOOSUaQ61zpXmtAM1H?=
 =?us-ascii?Q?KanRR5+iJwBxfnIr9LnPbca8UWSd+zzY4NlxbheZWyd/nV7JuFxedoA6V6h1?=
 =?us-ascii?Q?K58Aip+Y1UrmVVFfX9KX/11YbiUzycLRlfnjkP9pnX4+eq5p+1wOrY6IA3Ur?=
 =?us-ascii?Q?cJxpQ5mAdfAb5AHM6IWoSe5Q3jUir0sx2+CaecdovVfhkr8voRwd2Og26gpQ?=
 =?us-ascii?Q?MazfqGNlUAPEGUFNh8gZKaEOCRpqRAjZOb+RijgxAB0wUWUUZZv4o/Wd+nRR?=
 =?us-ascii?Q?Lw1FRKPYA5RITTtI/kBj3+ym6yoG6+aZT2QXq+txdAeEzOYbBoXpZNHa6hvX?=
 =?us-ascii?Q?znrvyuNEK59f4UBuAasEeF17eMgQtObSLlMCsmkdYed0DVwds/TZzLGrj8at?=
 =?us-ascii?Q?221uLkBYLT1Ak5bUFn1jKBFdoWA1DXrhlJ6o9yBq3grq4z/IjUMhdc+XG0aN?=
 =?us-ascii?Q?awPavtnMXwlZoB2gRDsgDMRSQd/shKKNYvQxOkgVUk1M7pCiF0Id8LSWj7BK?=
 =?us-ascii?Q?xqQv54UTMfji9Pu08grwmHzOZlHA08Imjqm7Ai8/RGg4JvfpyEAui6cPhBbY?=
 =?us-ascii?Q?Ys4Nj8VDS2WaedmCFlM24+HUx8g989fPjF4bGBODeH9UvvtBizCxJaIAoVT3?=
 =?us-ascii?Q?7AF9zTqCDfCt8kSCI3M5L9lu/MqXND3Sbn1qGmQaxz8fnfnahL0g55BYXeCh?=
 =?us-ascii?Q?znu0BUfhuepdOoNAf4ODlyIYgGfsisRjiw7KgK0F1HgfdQekqxXVU2EAcq14?=
 =?us-ascii?Q?31UmXRzspNIRGx/5WVpgS/qK48mZNgxAzk0A8COaywafc+KwZv/kH9ulztS8?=
 =?us-ascii?Q?z5rgE+AVZL9GDTEvyrl/dosqH/WWRaKjuUMjoPi0ovM1eNnV0LVgPDehDBYE?=
 =?us-ascii?Q?eput73tQh4uqU+XSKYbD/27NmpWyGjT/Xzmvjx/iYPg3kUCzXdVTTXjh54mB?=
 =?us-ascii?Q?MGaa63k6E1O05sF5D+/ZnA3C/M6W1P2n0ojb+NKM51sVbq5U1wUaMhCm4wXN?=
 =?us-ascii?Q?Kueji5BRAGm4rmJ1h42r7R5efq9xZa1kJkuyEXwBqPpWPz336y2amAXCNhlU?=
 =?us-ascii?Q?JKe7NFhBHddmjXy96i1IkmuABlaZlsrLXYt19o4scGeHFX8rRvhPzgZ6MYhr?=
 =?us-ascii?Q?DnNm3hQ/VF661lAfSQDLi+KqIDcuijPeIjxdzdaPH23su9gRsypov7Us4LR5?=
 =?us-ascii?Q?dqQ3M/k04aulxdI6c+dkQkomi4yTIlItQaaleFseRbXknPvKPLE95RpT+3Hm?=
 =?us-ascii?Q?1TV6ER1AlLHUq1EyQMLuLzlaByWExvZ7pHrB8Rh6e5dr58l5gAel5trKH/sO?=
 =?us-ascii?Q?Kj96ZWjxnjgvj//1ms0XrT4iM5m26JeTKNco1VJCHiYWr6o6KqBCqLIR2sS+?=
 =?us-ascii?Q?RCcJUVXWHGOPpzl9xMMMFGst4X2yq1F8SmFR8gPHG585UrwLdwBLMmTNCsOP?=
 =?us-ascii?Q?8Bw1g4BJzfQ6bMx71iDj5IBHKD1xOgAmKplTsjEqbPGdiLAIlCuWWbg/C2TV?=
 =?us-ascii?Q?r43wv/aQ0nEvQWrusAJ4x0HU2FrOa1kxj7A3gqP8w3itlyBeZYxr/fDDJkqD?=
 =?us-ascii?Q?trPrqfSOx5IWVrLRE6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20576b5-d1a9-4e2c-e35d-08dd8682ced6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 18:30:53.0165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5rKZRTh77B4F/eSlRA1mkTGvOtyKCSz3lYB6FD/JQA57775uSJy7tESUJ8RjKxlH+9LBmyTjGuCHlPBGJojKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
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

Looks good to me .

Reviewed-By: Shaoyun.liu < Shaoyun.liu@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse.Zh=
ang
Sent: Sunday, April 27, 2025 10:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jess=
e(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset

The mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue functions were us=
ing the wrong union type (MESAPI__REMOVE_QUEUE) when getting the offset for=
 api_status. Since these functions handle queue reset operations, they shou=
ld use MESAPI__RESET union instead.

This fixes the polling of API status during hardware queue reset operations=
 in the MES for both v11 and v12 versions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-  drivers/gpu/drm/amd/amdgpu/=
mes_v12_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 0a5b7a296f08..b34d7bedc317 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -497,7 +497,7 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *=
mes,

        return mes_v11_0_submit_pkt_and_poll_completion(mes,
                        &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-                       offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+                       offsetof(union MESAPI__RESET, api_status));
 }

 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes, diff --git a=
/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v1=
2_0.c
index 1f7614dccb00..ee8b531b713d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -517,7 +517,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,

        return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
                        &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-                       offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+                       offsetof(union MESAPI__RESET, api_status));
 }

 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
--
2.49.0

