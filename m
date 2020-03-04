Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0935C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2F520848
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v79NIGiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2F520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF9D89F73;
	Wed,  4 Mar 2020 15:17:44 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A273389F73
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFVRqhJSuSsSWX26vz0Bvcon83A1p2fOvyFHLV8oFLz7bXlRnd3glmN6rSmzuGPzjhvEY73b9RIcrVZ8apLZV7KCSSzXE67nAM1jXqJuBWyueD0rq7ARUlXyhEj5Kt+EvslWdMT5HzKnondvCESJdVK9P6dx/WL3ZQ+bHr2XGfpGI0RwR5CMyIbj0fS9q6luiCG6muwJyHxyeCVtAjirOQM/3tz7h/FXQOI1uosxsWoZE4jIZsILeHAq8m38gawN2zHGPbiqXaL+LPL8dtZCO2P0c77St3auWXlJl79ipsNSNeKI2f8+sObXA9Inkb/Yg9eOqZkyXH0aDaDjYwBJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lVxaaqmWEpBUpWEZuJZk6Lc99k3eww4871KlJGRbKU=;
 b=lmPaqK6V0e6wKZsiha40JpK0t0Qm/4PD6HiJj0sShV67aT0AEJVW7gKFPjkt+h4LXct1t4Ad9pnGsamj7HHIYq6Zzi+BEjNjIasoTWEwKpDkB0lkQfFQ0MVIhfh4nu72uI2/NFvhovC1n67uGqln4RmPpY07CTCyTUogpPgDhLnVby6Vcxr8gyCP3HZSqCcmiFbqmfivGoY/tnNJ4wDgwy8xpFWHOR/1i76RrI6oPH2wTcIeE0BfmGApSk1hHYEG8cMND7y3Giqm3Vxyz6kB78eGvp+OXB6I5o/Com0B05n+N0QJ9qupfEL0aWyALpv7M2HKXwHjWmo2BuVM+e9k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lVxaaqmWEpBUpWEZuJZk6Lc99k3eww4871KlJGRbKU=;
 b=v79NIGiQFE9BOHdh8qdkZUFkkLgo1Le6ewyQav4T2uabqtDtsBaT+Ph5ZzBhnQlCtJhQ7zAO7Wnb3toreyVPnxNHb8DzIu8fd8JzcJqUCYHklpcc/ytHqzjEsQq78544ksJ8QX2fjfcMlqdnWnwXtpi8K5X+lFLezdgI6v4OhfU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 15:17:42 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 15:17:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fine-grained TMZ support
Date: Wed,  4 Mar 2020 10:17:27 -0500
Message-Id: <20200304151727.221032-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Wed, 4 Mar 2020 15:17:41 +0000
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e8a9db1-4f7f-41fb-d139-08d7c04f2ef6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:|DM6PR12MB3402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402580869B596D28DFE19D999E50@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(66476007)(6916009)(66946007)(4326008)(66556008)(6486002)(478600001)(5660300002)(316002)(36756003)(7696005)(26005)(86362001)(2616005)(52116002)(81166006)(2906002)(54906003)(8676002)(81156014)(6666004)(186003)(1076003)(8936002)(956004)(44832011)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3402;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8N+S6vuK5ClMXnlPyzdzeHWM5i3kb4cZDfZWxa6o7WVDJcfr49z1Ylm2laXj4vcC9z84LcdhVXt2a8Qwml0kLEiScvHnogd7TCAzvQmZ+DGcGc2Kjri+SyicKCm+dt6/zkFY9Kuav7pmTfGkTAQ4mOmElKRdT/1++AKw/zymkgLWodmM9emS4ESVMS4J4aSBSUccflKRUOH8Q8ZDTu32hd2k01+h7Qb8GR3/0LznWKOlurpq4m9FSN+NXKdeoOWiHt/ORyFaL8B6YtBIcF/loLDq4X7BeLtn0QbnPBxwmE3oDqfT/9hWgIUEZT2jUMsp8ktBMtVJMoamyz4kuNaWFWoX0Fvg7bgMda4hYm46L/IwyaHGXmEvbqhWUb65Isa8zUbrt+8gdvHJf4+7f42GB4KgttmXUARGJkp7y/8bOFXHmKA6CEN4DxcO3NbgK6Z
X-MS-Exchange-AntiSpam-MessageData: 2MkANAe/HUSmJRzye1AuPGbMcgNm70sr8KGOlHuz75Dxj4ixw4NGgWMEfqUY1WnOrwM2z+VCReYkGrfAUZkx5hMVkfN1hTLmmvp54zLeDBSlWy/hbqjiMZzHyY5liblb8FgBeGAe7vnqERxBHvdsCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8a9db1-4f7f-41fb-d139-08d7c04f2ef6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 15:17:42.1290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8AwULOcH7qnY/I5vrjjbFfexTp0cxr9RvsqbAAWH1HlY7HR202QPea4ectPWz0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add fine-grained per-ASIC TMZ support.

At the moment TMZ support is experimental for all
ASICs which support it.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 61a743368302..4f8fd067d150 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -383,18 +383,28 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
  */
 void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
-	if (!amdgpu_tmz)
-		return;
-
-	if (adev->asic_type < CHIP_RAVEN ||
-	    adev->asic_type == CHIP_ARCTURUS) {
+	switch (adev->asic_type) {
+	case CHIP_RAVEN:
+	case CHIP_RENOIR:
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_NAVI12:
+		/* Don't enable it by default yet.
+		 */
+		if (amdgpu_tmz < 1) {
+			adev->gmc.tmz_enabled = false;
+			dev_info(adev->dev,
+				 "Trusted Memory Zone (TMZ) feature disabled as experimental (default)\n");
+		} else {
+			adev->gmc.tmz_enabled = true;
+			dev_info(adev->dev,
+				 "Trusted Memory Zone (TMZ) feature enabled as experimental (cmd line)\n");
+		}
+		break;
+	default:
 		adev->gmc.tmz_enabled = false;
 		dev_warn(adev->dev,
 			 "Trusted Memory Zone (TMZ) feature not supported\n");
-	} else {
-
-		adev->gmc.tmz_enabled = true;
-		dev_info(adev->dev,
-			 "Trusted Memory Zone (TMZ) feature supported and enabled\n");
+		break;
 	}
 }
-- 
2.25.1.362.g51ebf55b93

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
