Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55323C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jun 2022 16:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2A910E341;
	Fri, 24 Jun 2022 16:03:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9446710E284
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jun 2022 16:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6sFo9qra4uQn8GS7m4u+ageUIPYqBoPrTLGcs6PK1sOiSJJ+CfY3CHWcEUQnetgCJlreRA9+npmTQFG3zZ7ZtAkvd/CoGXIX9YOLNBDMh46nYc3UnoXqg+6Gr5E8DTWbFr/zY7f7KX1osKMpr/nDTO/oLtOGLlpcUmXMToYU/lDDW6D/yfidvm/eZOv4cEGA/PBRW93NjPZvfUTigZ6jmwdwFdiVIKwHpprhCbP9+WT9DblbceBaV5yUEqJack40itOes/5RZSMWhiqFVTSpibMp8mp7gQZQuK1CLecWsM9rWoODAZ31wMmthNGSNNzmF5/YtYsm2QYuOFVYIQXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BymHIcY8CchHJYGaQdk9INQg2i2AeCtDmbyME890fWI=;
 b=SLfe8NqTFOpfJeLLcWRZA/iP4u9h4GeQpzBVeiUXlrGm1nJF1gAReRiFY4I7FOVeHepahggXlm5iXZ4gm03GNkowiQ+0bBllF6VG61Lu5vlmsXD3eyUcf6XzaxGrEKAeFNrrVQyKzQ67BwCx1nGBtX74oS+GXQP+EfwvVTMNu88H7reCSI3c6831o7JlCGLQWZGZ4F5F8kgeJXD82jpDbQNa8H1oUFiFjzkFoP2L1WFuKrCmRZ0EaW8U3L6N//4HLREuym9pr9VAtq9gcO1bLVUBsXYseDqq5essF04XFn+lo9nsm0Y3mBWwWDtE9OLM9LRzJXCKvgWWsJlBtq/YDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BymHIcY8CchHJYGaQdk9INQg2i2AeCtDmbyME890fWI=;
 b=zoh7jQ76dzDWwBwDeMwcQ33AUuRYZp1J1w4oghA1wgr7yO3njdH2skdVEbghZsyi2tKYqcEvazkmOYSXDMXu49VodrJ3hozEwSTwK68fTDgaBEDMLpgdg6JQRCu3Ki3KQgGLzL+MjoQxjCpRVr1AWxmBwUwHpdzz4e7MjBiDP/8=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by MWHPR12MB1774.namprd12.prod.outlook.com (2603:10b6:300:112::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Fri, 24 Jun
 2022 16:03:10 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::66) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 16:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 16:03:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 24 Jun 2022 11:03:09 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: add custom svm range flags setting
Date: Fri, 24 Jun 2022 12:02:43 -0400
Message-ID: <20220624160243.83693-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624160243.83693-1-jinhuieric.huang@amd.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2e3d94-6379-449b-8496-08da55fb0915
X-MS-TrafficTypeDiagnostic: MWHPR12MB1774:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvBgvkZidOBfI7oebdWlyLY/F2bbRLecat0k3yzYcicKzYY9t+5qTqRO8mT+L6E067/QQwOoxBSSVAcng8s9bXGXyIVaSEdauNq7IwQsLFuflxbNteEZQwwJvOGboLW/IqQOg1PuJM57aF7jWOsI16aIkM03+4mHxZTpk/eCoPNxXGhksz3cKjbHlDQFHA8mgk2PP1fS4+rq9apjHGs3UFMV6Egp86Yy2nFDc95UN883OtiDEpbvgQkJx13HDBngX5aZOq2GcAt3vGSiFE15TDmdv2RLTscAQfX1CZdC9T6qwPeWYLNv2vvVf3lBgzI1jTT1XQJyedWm1KjlVkug3BE9k/3i7Hdsg3+dC6LeFK/axSP5Xn54bPR1mvwVUylX+qMOth1SqhUmyapF0e22l2KTJByrTJ2XgN904sIxIjsIi9DuaCoOFFy6hSDXu67LmC6dXhEbd3FyURhiIG06gZjjuVV6EgZNsJg3E0054h2AbgpkIOHsMzaTt55AyEmjoWiyH0Ax7WNgZHl02BpNCbtLK5QPKKKvJ0NxQV20CZQmS3HYDtyn6gr9DYcg6rKlt9Jlnm5OagzqLfZnhqzfUfiRBhzqNdu7rkgaZZw2jl2GASFuUn+TIISn9GABWImxbYpUw5g+LmRGNUS36OsyRmTrbuPLeJzJcmlmscxk2sCDiLQ+9rsUuRPA4EBj5PJ9Qw2aJrK+i5lFQrCP/+74GYozIzHgZFeGt6pDjBUMgGk//719mKMK/s4FCfN8qcQihxkai5k3Glgw03t88AWYVP07eEju6MAY5ORx+sXyhqtXiD0ylCOhVTVoCmzqC14XKjOexg9PEBFDipt/WMHNtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(336012)(40460700003)(6666004)(478600001)(36756003)(16526019)(5660300002)(186003)(40480700001)(426003)(2906002)(47076005)(4744005)(36860700001)(70206006)(70586007)(6916009)(2616005)(8936002)(316002)(41300700001)(54906003)(4326008)(86362001)(1076003)(7696005)(81166007)(8676002)(82740400003)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 16:03:10.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2e3d94-6379-449b-8496-08da55fb0915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1774
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to give a chance for user to change default
flags setting, such as fine grain to coarse grain.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 353306037959..caadd18c447a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -722,7 +722,10 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
 			*update_mapping = true;
-			prange->flags |= attrs[i].value;
+			if (attrs[i].value & KFD_IOCTL_SVM_FLAG_CUSTOM)
+				prange->flags = attrs[i].value;
+			else
+				prange->flags |= attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 			*update_mapping = true;
-- 
2.25.1

