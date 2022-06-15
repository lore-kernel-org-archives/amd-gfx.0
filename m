Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4326C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 21:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDDA1138B8;
	Wed, 15 Jun 2022 21:57:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8330113882
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 21:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9XZ+q6eNkt3kXgWtcUR7larAJObF6Z25t+g/n7n2LzpZztn9QG2rePqDM1e78LYZQ0EDJF78qVS3r8Dle0PXgRhD8SFoQil8eIetprb+edfRhZifKujPOGo8froDg4gFIpzmZiqbfo6/Msm8q5JTEOvRmJszJwVsVqrxPetIrg7J1oS8/feMc/Bs3v7ugHuQRUk/0QSnS3n5nDh013yteOutC1ACKdz2aQ1xaBKDxUgkM9fY6OW3frnDzo1vMEXgT7/cjgJLCbKxt0pJnlYsGFt1hiC4eQRDiEBEJd1llMUMawRmsT6GMCBS9urLbxEfXo2XEGmz/NFQIU37iaN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xf3EiWMRC4Aj4kADtJ7HrjIsDQAa8TUgl1sXp4RQ5Q=;
 b=jz7ooBNg3D29muD0LDTBInHRSuq4EcOtigzBXessAN0ciXl+OyLO/IKXfkKrDwaLdMzvePPSnhTRtdJkQjxsrCU7q1kfQgZqRQX0jgIpeD/6l5HcH/3ApgmA68bh0jQrlLvw1h8KlLm2vX5+6D9SCwF4zMgHYNt4H+fK30JA8QyHPuAkkG/HccponNdNcaQiXJxzgW0SeMVwOUcE7rwpVQaKSV1FRGQMjYu5R+TK3+UFo/gmOUu/o01eEoq4UI25+jLzqm3bXjIskXE6JLGDTn1VTGzucSQybCCF+B3/MnLe7lmUHcNCs2pDyc8IQU8NW9rwCg/FCAweWuqg7yfHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xf3EiWMRC4Aj4kADtJ7HrjIsDQAa8TUgl1sXp4RQ5Q=;
 b=b6RqFCg/C7vS62rpX2/ERj7rm0BmziSJUaIeTxe+Y2OsqUYsrUDEHxl4Rh2x2wv2hkjlXV9UMLMwnWVgRsOudRYKpC0MNpufhTw6SZitM+6eLLpmbRiBZObiWxYvHxbgwxo3G6BOV9Uti3sZraWaC293u5EF93OvVO13nHim8Nc=
Received: from DM5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:3:12b::16)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 15 Jun
 2022 21:57:38 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::66) by DM5PR04CA0030.outlook.office365.com
 (2603:10b6:3:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 21:57:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 16:57:37 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
Date: Wed, 15 Jun 2022 17:56:50 -0400
Message-ID: <20220615215651.14502-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d6b32f7-f025-4a4f-6a94-08da4f1a1004
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279663F0D3F6A1C3E669615E6AD9@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQ17wDMdcv4/guvEUnVXoVMHHxIZbu/Ab8BzoFrb5tJ0yC3ccLeJn1cwyv2B81maMFUgII65JVzVQkrobUHf3nsTtX+pDyfIXrhd7Z0ddduolFYd4DyCM4eE4Vy4rXVZb/wZsEStdqO86IDYvg+NjUCtVKnEjWEWXr6G1reR7mxov8FFI383DUsYwUKNfAYMa0F4kK/8+tTSdFptRvVQbDRgegDlNTuubipwyI/T3ELLLBbqa83Gs93LIYmhw9ZjGgju00fFO1rb+9057fvPdNNYv7vdBmyA4JW+QUG2/8tnmZyNiXBU6DI3YNxGIf3517mQwy/brO9kfThG20u2U9tZEtJ8gKxIm96X2s4QBU6k5BZInTfd343FHlRfvqi0mRrHztTOlX9R+jLkQC2zr+JjbaymDL/c7xyCroHGeXvqe7p6J3x7RA6mv9TbsYmrpKO/vXLMdwxVymYI9GpbhH2zE5mB+kk6PipQksjvw1A14V0odi0n1vQbza83iINSi623ylLXJo1G2YyVNOvB1Wunbjf0du0riyT0xDHH8rULJKbYQO9vY/RdMvgKK8Lb80Cnob5jMiUtGd+pUPGgbwVRQpFlIjYnarErmPac6M3Xy8AeNvE+y+JfyOqKlIAnr/Ozl16IwZWDG7+at5orn+drFBSwSVSmeBUmfM6vVKwhdzI84kX7OVg8dS1kV+ktODWRkVA34dEnqy2x5InOnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(16526019)(508600001)(186003)(8936002)(7696005)(86362001)(83380400001)(2616005)(26005)(1076003)(336012)(47076005)(54906003)(81166007)(6666004)(2906002)(6916009)(70206006)(316002)(70586007)(426003)(36860700001)(36756003)(82310400005)(8676002)(356005)(40460700003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:57:38.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6b32f7-f025-4a4f-6a94-08da4f1a1004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham.Sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We remove the user queue from MES scheduler to update queue properties.
If the queue becomes active after updating, add the user queue to MES
scheduler, to be able to handle command packet submission.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e1797657b04c..67ae5b6385a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -866,8 +866,10 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	 * dqm->active_queue_count to determine whether a new runlist must be
 	 * uploaded.
 	 */
-	if (q->properties.is_active && !prev_active) {
-		increment_queue_count(dqm, &pdd->qpd, q);
+	if (q->properties.is_active) {
+		add_queue = true;
+		if (!prev_active)
+			increment_queue_count(dqm, &pdd->qpd, q);
 	} else if (!q->properties.is_active && prev_active) {
 		decrement_queue_count(dqm, &pdd->qpd, q);
 	} else if (q->gws && !q->properties.is_gws) {
-- 
2.35.1

