Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D3EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EF8613A9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EF8613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F416E8D9;
	Thu, 17 Jun 2021 14:21:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9406E8D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 14:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFL8/09OYrcSqPIXdPFR/cLj0V7oONWQJgSJRG7yjk5PcOQnaicEYu0by6tNeeqQInDjzba/PyAXAqN34Y8JXFm9XS0nJ7/wNV7kpB9Ug2imoMQ7OgwTuldIELjw1srb4FeTVxDveKKsPjJnn04PnD4Rwtxi8HJU7MJI6Q1A5sMnpS0cqI47LahorLUUjLexvzgNxuaSowGNuPW/hvQgcJwo+a1u2gDQbxbqJqGKkLE+t8HrTR9PQxfUxSVOizbilmvNvmCnHh38uM9VcGpv2i8flNJPLexuC/QxcBuern+3P9AXs40EAFoxua3h83GkM6gDo4OsWH75xnvuLVkWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aqYh/zGS6Qb/UJjMwbTSZhpnsLQnWLJj/pLRiGAvV4=;
 b=SsFwI7dDNd8XL/2RsrHZ0uazQOwFJ2cUFiQq7tQPip/cXHvmPBZu0jo9bHRSXr6NGWZUF7A7NcWuefQkQJlGS/sxdRFMLDcNR32t9ya3kg9e3WnZXOzWbeNkGGas8GD44/QDigcFLQGLzS4DoLcf31m2e6cwQOTE+e/g7OvCzj+Es5oEzVDow6YGYBxRrpVH2gwJcucrc03syoT9fhIEUNL75QXarOuXsoem3qZwN8gV8Hl6JzgzAOgXdUAqBeRXh8nKd3/bTi3TgIACcJFn/0W0enNEFpDoISzL00hw5DCcnS2ebzO/jG8HajoQnXLsjOo+zu2q85rj0yeTkdF1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aqYh/zGS6Qb/UJjMwbTSZhpnsLQnWLJj/pLRiGAvV4=;
 b=htxBRKDMNroHMQidGTGJL0SGf5TlbLw/gmvfzHMGXOQgV2A7puL54EC8rxBMroYbzAv6cBEBNkvSzCortXoBvLZYjNFkqfZtdmYROukqz07cmMyjhTYIjBRgStMDp1muos6QZg1evRgsMzTy9OCtZTsbcNHQaWovDgX8w5E0Sao=
Received: from MWHPR02CA0001.namprd02.prod.outlook.com (2603:10b6:300:4b::11)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Thu, 17 Jun
 2021 14:21:14 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::ce) by MWHPR02CA0001.outlook.office365.com
 (2603:10b6:300:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 14:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 14:21:14 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 17 Jun 2021 09:21:13 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Set p2plink non-coherent in topology
Date: Thu, 17 Jun 2021 10:20:59 -0400
Message-ID: <20210617142059.400829-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c5f49f2-2b3c-40a8-a434-08d9319b2a09
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3316CF7475F563D1BD7C3683820E9@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvF9WM4TNVXYG3b0lmxnAzrxjaBJ9QHILo98fqxUJLZV66EeXxtryBgpV1aS28FPz9onsVeADTavW5UES3zFaCJLfbGQCt4F2lQxYsgmkLdFEGxdVOGbtU8SmjgLyJFmtyrL1FDN4e8r7DzXZr7leLMSqDeUpK+0tfEB9jaGyiZTvGBLjmMf3VRcduMTlyKuWih2iwiu22vPZYUvelSgVIK0rQoWuBjZcUJKbJ0VFZMX+inC/qym5yIJXKjY3MNapNbqTu7nYufhbS/28Wegp1MZjqeCIVG+PdNbWI6siML9kLGg740o6C4E0jdtLN1fMxnc71h+v+N9t6vlwgoVKOcIRaEjZFKXiSKYVdlGguqZt9kj0f5e5bMK+8Cs1tOBsYm4rhu+uySFaVf5lrEraL3tMieU8fj2YQcYl9ZaRaqPdRQALtNyLA73JQ0ZdGwiXwYrpFYnBxEgH4vbGdVBvLZK1nJaV9fbuxW3OnfYnQrUCtvCXKa6LuQ0DkDSntheKrN5YOJ45bCYQJE7db/yG58vkcZosx1/2gtiqZdkOgrHQd8UVvJEQ8WduRp9UVf8YeAdUVagY+nRpNvESn2+hPE1HD+S+CjF9+oSepLiGYa48MmpoFgxFE+RcWgSxp7TEP7fdtZ/9m5l4jllmtg3AvduEeQk0dw45diC84/WqG8MvbLX9fOYjugWQPozgu49
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(26005)(336012)(316002)(5660300002)(82740400003)(86362001)(70586007)(70206006)(426003)(7696005)(82310400003)(186003)(81166007)(36756003)(47076005)(4744005)(356005)(36860700001)(478600001)(6666004)(16526019)(1076003)(8676002)(8936002)(4326008)(2906002)(2616005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 14:21:14.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f49f2-2b3c-40a8-a434-08d9319b2a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix non-coherent bit of p2plink properties flag
which always is 0.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index d390aa369f7b..0705ff5eaa26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1404,6 +1404,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
+			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
 		}
 	}
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
