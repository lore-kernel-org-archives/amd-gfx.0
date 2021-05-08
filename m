Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F93C433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC9E613F1
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC9E613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09EE6E883;
	Sat,  8 May 2021 11:52:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939816E880
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrvD0uxagu81KvZPVCC1NKbEGf9HkJy5F636NiMJaFiiVQCc7Pc7Th74RU+ym94DoRGIPLeyZ4O5+VqpZcJ4yOaIYEd2SXDqcPZnkBm3v5tbdyMVIrgEgYpb2Mi+loPpMdTs1SVy9sLwQhK2cNLkfq7kSkZ2LUS3fSLsfaJ1KaGtd+i8ni15r9Tk27IpOIuVDmaoUzPbjl6HXSoIgpLjCs7l1Fa9nks45g4Xkltze0PGqzPjsJMS7c5MiykwV6ONwoh85I6K8cpXL/4XWEtRlrgm4MLq7orylWE9MCmMF1yCgusJVG+N4UBQYGpPix71wOGCOzn7EuMGRY86Gw45hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXqgSWNLTHd1lj8ji4rCYDySSC1b2OrwYNOuolfB3eg=;
 b=ecwLhwen3bzEjpTmA2IsYvQ0EfyIHkSekJFYWhOTn/swN3qHF+z3bECZ+qrBn7nd2VA6rWaKGCS4t78m25RXmMbuIUsM81PnUEB8s7JnEwFlvlk85rRh+x4CtLX488wn+GvE+Qt8X/71g1O0r45fFcwPJBUkllEfEEEHjpegcd8zHYs5wO6ofeGttRljKdOgC5cvge20PxHvX5a8mJaKdkNtL4Iv+0yMoYZwhV7/ZqIeEliYUAafhdLyHVpdCgX1ZRpKJ2vSCgWCyWmCSiniOm0UoeKM642W61O1nZVrGzUzcrcFZEmbo+E7TrX+Z+VcPVu7MAQDiU7FXJmHg7I67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXqgSWNLTHd1lj8ji4rCYDySSC1b2OrwYNOuolfB3eg=;
 b=qE7btI0pErlak+Nn0id3fakHdIb0AoV0Y3/B3IPukxcFYeQECjpPl3l9erTqbzznUg/tSBibctWVq67xoD5J2Ekno1IYi0K5j0TuBjW4kpazSLq+PawXF+NjBy/fRz0vWCsCuB6Sv82IL3avY/jA8dyEKI2M8f1mvPRxg2MIHQM=
Received: from MWHPR22CA0029.namprd22.prod.outlook.com (2603:10b6:300:69::15)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 11:52:07 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::83) by MWHPR22CA0029.outlook.office365.com
 (2603:10b6:300:69::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 04:52:06 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:52:05 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 12/13] drm/amdgpu: Refine the error report when flush tlb.
Date: Sat, 8 May 2021 19:51:44 +0800
Message-ID: <20210508115145.758-12-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc5319a-cd90-414d-41e1-08d91217b49c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4375B10C73929246A65A34BEF8569@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miUfFEb2hQsoi5UPntgGYsNAeS6fswaLf/g0joxguEW5PCscENIh2pw63auz1tvqXgE53vpGue5ny+URr5De8pD1cbW6kuTtHYjI6UrnMqgwgW6CRRfunAnTcI56RfSwOGmeOQiGNNZipxGtfG1GObL0hGhXhTUHTvc0WOGNPAmZ1iMBlCi9xpSN1qS+ySIlE7I9jC3rmUholezUCze5ebknOWnE+B244JdoSddehaMDeSNiY1k6dYQsCT7m6reAF/9xTNtNzeGRfSYUq3BCSNvE7xk8rkJvhLQpBRJnfZll4yfOG15bmnRZTiJtUG7WbCKZ1brlPPHtgPBUQtAxWH0IDhUp3W9O1kwTC1InknAIZV6FFt229ubO64cT0q/qQoE845zvKH0sm+SxvYq6CH+hm4az66KSocD6btTxzNwVcmWlf3tUem2aq1O2PqrDrV96UY7QE9RzTLSjtQigba6LhQXYZxF8PykKGU3CFxLvrnRYkMMyF7hb635lKLXUzjNH037GX0Q3cAQgBbD0IhQY/iVkP1ULmSu5m6FT/ubzg60n+gzduObolRQDX/swanhLTo8tVzKpgHJTm7yQRSZUo9pWnCf4anpGrMleYbIwXDUcfB/TNSwwPK5bAOzOC1GOaAeKpm4ybHApjWeoR+abpzYEviw9og3Ef3y8+XuEvoJP7K5n9iCuBJ48V6Hq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(36840700001)(46966006)(6666004)(47076005)(70586007)(2906002)(70206006)(83380400001)(186003)(5660300002)(4326008)(1076003)(316002)(8936002)(82310400003)(8676002)(86362001)(4744005)(81166007)(478600001)(36756003)(26005)(82740400003)(2616005)(426003)(7696005)(6916009)(36860700001)(356005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:07.1653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc5319a-cd90-414d-41e1-08d91217b49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there are 2 hubs to flush in the gmc, to make it easier
to debug when hub flush failed, refine the logs.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c25541112663..52eba885289d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -297,7 +297,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
