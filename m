Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F5C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 08:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761846141C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 08:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761846141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0420A6EB50;
	Fri, 23 Apr 2021 08:30:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D146E156
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 08:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LagQdK67BbVkrBy9bgjsXNhmyUdJWTThq6S17ikjdTPCMZy1faHYmn9B2bdIj9P/3dUYMOrcWxd4+7QSHol6k2FSe30e9W5fIozvzCY3X3pJS9LvtTU2XiiRzy1ryyYlO3oswSmQTJnsdyTcDzLM+SGUVIdrXNBP47QMJjGrzk3+eZiVExRfkqvQdcUgMECSy6yVhWvjXG1QfIdoRUEpHJKUcEVcBuJI9AoDePZX/eSPMVYGFCiPJUI+9O3xOtXyAiTQawlWgo+oxmrbJWtyuUAGM6X51jh1l15f0x9CWBZJB71T0A5VL/uf2gw0Erf9sXltcOb42kkv8tA+l+zeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYQi9ayz8dCm1qF8KJDAqIsRmv2TeY5rZU5QpSyXdMc=;
 b=dyCh4Hv2gcuO2TREAxZdsWXvqIGaMGuFofSIwyLjXcdO0USeI4PfoDotV+5ZR00icVE1+tZhaEyfM09J5dZw9ecWbsvlDKvj2FWdE8QR4TmBbHkmGAkdUDpQ56vDuiZ32kw0YvT7/lsP43Bkjopo7y+sXXI8/50aMMZnFjFhQ0qxC5/Bu7g9DyXIt4kSbDOW9SibXgP+BYWk4micdnaLCMALiDJrCuRvB38Idi5o6tAsht6wDu5SMam5bY2ojxJmRQvwZQNaWUjTP0j4KZ15ZiasUxv5ettMzZvUKfsqApaTjVuOK3GO1Kb0GnyciOL3BbK+ITtyEb7uYbI9cSyCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYQi9ayz8dCm1qF8KJDAqIsRmv2TeY5rZU5QpSyXdMc=;
 b=Y7iIa4CUb9lSJ9RQjX3xOU/vsagrqX/N7AmW1w50SgQZVIMoXnsVjSV6jk/MOYwEIUqfiUsz6ywC5STjGxR2F2WVEPrGjTuzbC5kwDapv+5utNlQSKkEqBScKT91r8gHBODxnBSTf+dvF2h/CjmRjDscSv9D3lPGjdc0j9u1fnY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Fri, 23 Apr 2021 08:30:29 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 08:30:29 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable SDMA LS for Vangogh
Date: Fri, 23 Apr 2021 16:30:10 +0800
Message-Id: <20210423083010.185478-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 08:30:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adb3b8e-a326-4558-fed3-08d906320d48
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105B792B3A81F59876DC85D90459@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pra6zL2WGQqVPJia+b577n+t0BBUiQ/xMLOMEisTIrDQBGfi8sqmO2bP9wSySxXlJSTYiH7AMGBYbJWkTSrz+1YZAc/9qunrupS1kGtCca++aM7LZU+FzSB+DnaedtrsiU8SUrPv4ZNhUjmtBRUvZ2RYDBA9YaYio45FJZ/kIZKg/w55Z7P0nQyzNSuWsdfLQhxdplyPy2QNcOneWTG1i2n4V3BHPsU276RwH0OR2uOBMJVLEYn4eLpkfzUPZBT8h5WYZ3YUfGAQsA5WfCxKz2iOd0yurufMADxm+WGl5uX0z8TaAnaNE5+ZocigIwAo1MDP8R3wXDSXPDMhnYBZM32DlLE9OjLY8VVzP0vvIFKBGl7Ne+xyX3JpIuyj3tUbz3534etW/1dCDka2QoMZE6I1WlKTcZdniQVf469HqD66JyqPs+miPqLoQM8/ykhrVPN0qWfIT3vu/hPssB5XKksexDuxohzO5YuO/VAs13IRkaVa7Deoa1DHg9do4Vrany5vseUVCODnDEj/QSLYjDZVinkD+SjCS+GRH68zM8938qAh0mt1i0dy9fDxRYqqSYFYse5P5mQ1xnwmxaIx56VAlSWm2JPhSYBu7Jbz5PlEQglQtWOcM9p92DuIrbUb4WGDOxdaN8HDHEpldt9uD/nDV0ESGFqL47F+FOiTF14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(186003)(4326008)(956004)(36756003)(38100700002)(316002)(478600001)(6916009)(83380400001)(66476007)(38350700002)(6486002)(1076003)(2906002)(8676002)(6666004)(86362001)(66946007)(52116002)(5660300002)(16526019)(26005)(7696005)(66556008)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/R8nMzNiFLyOtSd3bVSwum7e09Isq0Ew+IP7wih9PHSv7b1fuO/xnirX/HJE?=
 =?us-ascii?Q?wQMEk4qY8Zvg0weqcUJuZMMqUPr3AM+fDGIMmYKPXVPi4iS37/pzyNZ9onRI?=
 =?us-ascii?Q?PVG97fvzLfgkxNqpmzp2DqwSPZoCTim4/gMdah4Vn7VmBCTi/lkK1aowhulN?=
 =?us-ascii?Q?hNJ35VAqPSaGcayiMlS1/1BQBMI2E9jjEZIw05fLrIJlTmR+o3Jk96OLzHqA?=
 =?us-ascii?Q?4vpAJq7BaAVN0s0H25tprNpy0qIUI6fJeqxccXS1pgc+/hPvDvpbGStU+Zuz?=
 =?us-ascii?Q?D3Sb9xzT8/tbppadBqdyYowrpyNx2ZUuZ8H1dDACic35WV3mdsnFgVj1KCsZ?=
 =?us-ascii?Q?S6+sBC8UK+VEtEBUzb5BymvWD1jPBYHIKoaUFjtmYC8SFjmLOrGfaw69QlEM?=
 =?us-ascii?Q?mOteJg5Xkyr25IlAaqJUSbVzvspNgWruY/M4RPJ7BYJbq7U9WW2UToc7Q7dF?=
 =?us-ascii?Q?QUbjGdV3HRpWB5X2NsZBz3L8Jn0IXv0ggWSMGUNIWgr4rBPjhHJllSGnqfDx?=
 =?us-ascii?Q?B2RaM3dD1NszjRFmaN6AcuINMwYgXL52hCdxhNh3QBL4HqULyu/IeeskJPoL?=
 =?us-ascii?Q?U+VhgYP+f/q6TZmwx1hmwyxjNkW2FBy7ih2SwVxm4W4p6nD9+AsniMTrtRdE?=
 =?us-ascii?Q?dt0uzaYeZTIokBWcaLnThi7utxUwCEc1KyYGiZoOZy4TPbeJfPkWO/I+v4ck?=
 =?us-ascii?Q?mEVkS411AcEQI2zUegmkncfid4mOKbaydaAJ5MKiWdf30UVW+A8NHp1pZ7mp?=
 =?us-ascii?Q?yAa4aETXhoXSbYndhyaHnkNcYeCDF6dwQgHqYXFQgabP9QQ0QZOaHwf6DNN0?=
 =?us-ascii?Q?mcXrhWHdSkiB/73J/7K8TqNichm7InC93hy5LGtVOqu8iPsZ6GjW8hp+Toqy?=
 =?us-ascii?Q?fAAFtkFOypH9jm5WJF0pmESmTsoEdSZhb1xir+tRdl0zikwI975YyQ6j/L3T?=
 =?us-ascii?Q?Ga6j5M9Txh226LfaXX35/q74rxjlnhSxuG621yW8MxgFBaDl4Nj1I/J73e/N?=
 =?us-ascii?Q?q8pIAexXf01YDAiowkHuFW9gDl4mkm/HBPmkLMVSMfnmD2T619MP7NJVqQGQ?=
 =?us-ascii?Q?kcf19oDzsVzyAe9tFuuW961E2602XCnUUQpEl7Dyfbaew0/Pt9MVjnPSLsRN?=
 =?us-ascii?Q?OlLWrmSRcmPnzocx/gHbN0VytzCkhgfeM4a4tqGzJXBCzgNpjxCyiAfCzaAV?=
 =?us-ascii?Q?vOslh2SjTZJyQvqIB7486dLmRCg+fgFSGtng0h+9EdW3GYb6ZwrNsMtugKCw?=
 =?us-ascii?Q?8tycc25kDm1WzgHPiKBv3XM4IWbh5O2PzoFXNoMZpVhlHIYtavs0My8rtXCn?=
 =?us-ascii?Q?xlPsbreeFsAnGS8JrrmyMujO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb3b8e-a326-4558-fed3-08d906320d48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 08:30:29.2753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vlz18mvQiyxdtV7wkUj3VbF00kPByUCUvupK0xH7c/sIFmmr4F3HaRiEdmcw9LikdAYIvc0tDglrZr1FGE0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add flags AMD_CG_SUPPORT_SDMA_LS for Vangogh.
Start to open sdma ls from firmware version 70.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9c4f232e81c0..82a380be8368 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1121,6 +1121,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_VCN |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4ba7fce4c0b4..7c4e0586e26d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1593,6 +1593,10 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+
+		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
+
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
 			/* Enable sdma mem light sleep */
 			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL));
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
