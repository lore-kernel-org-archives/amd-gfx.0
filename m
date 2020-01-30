Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27B1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A5120658
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RyZi9ZeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A5120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD786E8C3;
	Thu, 30 Jan 2020 18:22:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF7B6E8C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 18:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX/bD6xCrUri4kMKbwK/goz1siE4VsvKVn2uhBFINQVhk220bTGBj3Ga1b1bSV1KlYglSidfSgwSC/F2P10Vof++/+/Nfnpod3WFHbD+R1OBASNfSt5XZpmbbDajxI1eKQDmkRI4TFV2gcdlj2yk7f30Z7R6XQy5bH9V4P9aBQQGN29XYcWZsZsqObZa3B/PXZLWE9OWcFijyjB9ViTWO09aihLB6KN+Qhlo+06WVQEK7R+4CEoCpTJ/cq7dnDnrEo2WTrtpfEzvd5sm/8tz7cbvsd4hhlvl8VujWhClvmY3nyjLnQOi5kgLmNkS0phFh8SwXyOhUBQVPTAhw4Acmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQSizNGu+X/QY3qN1Eg0V9xjwN8/xnPy52VlhLWVeWg=;
 b=ViIWWEMqQEuPqJEZAObcCOHOgKcFTBFoVbEmFN5AHYRyRrYI5MhiEtmWkwAQBBUTHEeKnE/RNzNDWHC/BqWVakv760wXtW2papxy2fzscB6cN3kMf//mQR4JYJtYJJlR95Zq7QPi/W9OhS+AGeh52vx4UKnvD27LZqH82bNmn324NV6jvLlFUTZmJHnC1aA/gLiQ0buX8fexfzNTJSPzNY94KIS04SLux7L+WUcv8KIfnICt4MVzcRYllNRrITB4xrG4TQEUJgyMIc/F4QhD0AZD5YPNURA65+jOi6TO8cD7ia1XZNpJfjafcdSeOfhpJwdIUldoZr2iEYbICdtnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQSizNGu+X/QY3qN1Eg0V9xjwN8/xnPy52VlhLWVeWg=;
 b=RyZi9ZeXtCPYRWmKuooQTnPncQpHscbwT/lFqYPXFkGOxJfF34fODNxclbmxmXvDbXlAAN8QM7QQK6vHzJ17Y4E3sXNko44H/vUQ1mNjfnnkBCRAAhpm7+RG/4jNDiE5wA539rutSIiM4fZZZEjZEcNdCGhoOc9tDxvPBEN6Jvk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 18:22:36 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 18:22:36 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: leave all dpg mode unpause in idle work
Date: Thu, 30 Jan 2020 13:22:27 -0500
Message-Id: <1580408547-6466-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.20 via Frontend
 Transport; Thu, 30 Jan 2020 18:22:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b2ce909-1685-430c-60d6-08d7a5b16164
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:|BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3525A6F79A4FA22DD0CE86D0E4040@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(52116002)(7696005)(5660300002)(36756003)(2906002)(478600001)(2616005)(956004)(86362001)(66476007)(316002)(8676002)(81166006)(6486002)(6666004)(66556008)(81156014)(186003)(16526019)(8936002)(4326008)(6916009)(66946007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3525;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qW+LGKebUlRrQFJmFbSCo29FShPb37s/lGvH7kunfinuumHCOGZV3+1m8DBx1q0Rf/AbXDEToHm947x+CLdE7xX9u0N3lVEgtA16BBzQ7Oool5oGSxQ/9KuF7mJFO+2rWAQP243Q/odhM+rOUnFeVIU2GRC5ZD04gmuq7h7WxPtFNo5II+yh9Reqx6XXnDxOUh/BdPDSBaI4KktOclaNOOz1F2pTVhkMDF/8PyATMmKMRlO3S1G3l0JWotwQNp6JoVApnYAmRnS0rwvw1QnqvjqWzrJ1g4mGI6v/NOJHlflqlgu9EFTEA90/LQbKBTqt2/lY9p6g0v/mwYwuiMGrn5jGRJ5C02O1siF2GcjlLus/ppmwXACMm3tIZNRC/zwIjOoLSsnQO0P3ngAPqvxf9EKZDpIBZUw7vRSenhd+t1dE/peb2d5ue5WSyfxtY51V
X-MS-Exchange-AntiSpam-MessageData: DSq1A1n874uAyKw6/EV46GeoFWnBjMROtLGkWbWUc+aU2y9bvE7gd6ZmVSmUjaewCpBaQczdAWWRi4Q4Fdl/jQ6Cg770M4o9Mf6QN7h/BPevV4RhflR9Jp8URq/O+sy3bYeXh7wF0d5o/0CmMEMOMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2ce909-1685-430c-60d6-08d7a5b16164
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 18:22:36.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6UIjG/sgDIsSsfP69sLCs0TV8m57hIr25rjAKDgOcwlpX3SqMyjOH3ywwzeexzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leave all dpg mode unpause in idle work to fix VCN2.* timeout issue
during transcoding.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f96464e..ed4b753 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -329,20 +329,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-		unsigned int fences = 0;
-		unsigned int i;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
-		}
-		if (fences)
-			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-
+		else
+			new_state.fw_based = adev->vcn.pause_state.fw_based;
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
