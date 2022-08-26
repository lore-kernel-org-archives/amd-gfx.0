Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B5DECAAD7
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9DC10E276;
	Fri, 26 Aug 2022 18:45:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165AC10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg81/33wRIuRhVnrkEGrtY9mj8JaKWLiQauCAhdANchRQczCBeXasiH65lvPO3lEAK5LNN6NqJvqsb+q8ONDs5pgsDY62ksUfchz5xC05MoND8tZJR13qHXjEON38Xhh2zOWRWCQy6z8I6QEZwfUBJWOdjCYoMvq44Gjxnr5Mx3tGDM+zvhBdyJN6ITgtVni2QwRapRxxDcBDbaFTDoayNcKeYYkrMYB9ZP74hyOgJ7GWbXpkiDPOhXMbUhua8cmGlVqnjIsZsvg2aFnX9wjKejBDBdxBmicYTh9VYDeRfDTdSw/RL4iUZdnQnC1IBGW0N8JzuU1eUwxpWvsJ29vZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLUMkxb3SPPnNv6Ssty4cl5aSyOQp/wKjvuIQY7SSSU=;
 b=VToT9QuABxmkComIp7vMCQ+Puc3LdKKjbnglD/n5UrFsQ2WqpefY3CYRhTnqrB7IkSMikJUtIreKoRfGIn10Fo18C15oKsoSw41XeGKJMknoeu+bMlCvWtU0+rjW4NJnGRX9SI2Ffynzr0GUZsAWIIBHcUFFgLmkiktxY9ZqovRplX224QGVv+IcQcKXQO27ze+cEEMg/MhnVcv54Kx3Ki7FgubwWCkQcb/inxSaDeql+xgYjRWfzHg2a6/lnVv5cjPbRDyZXxjsgM3ASBmNNncq7/pUHyv34TdrDy1ZEptqzMcq+fbQNDsLFujyFslPpB8ISGFv94Xi4CMpqkOzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLUMkxb3SPPnNv6Ssty4cl5aSyOQp/wKjvuIQY7SSSU=;
 b=L0q3FLy7HqmHcMB+Us9W+oVCQWp30ZBH19ryfAzSKkfIIGZAhXqw2ohWL3a2VuL0y+WrhFtP9FG67KRKOvjTT2pM4qGmSdET3Zc5xrvjf4XXz6sdRlYLxEv0EiI8zXx+25cor9BwU/8cJCvYjaTn4b68UQc6SI8Dwyz+9sQVmOE=
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 18:44:58 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::72) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:44:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:44:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: enable smu block for smu 13.0.10
Date: Fri, 26 Aug 2022 14:44:40 -0400
Message-ID: <20220826184440.855532-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184440.855532-1-alexander.deucher@amd.com>
References: <20220826184440.855532-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22278727-98bd-4ea8-337a-08da879313bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BqpXugTyuU1SPKOTj1fV8OlFjU+5ujwPte1lo70Ucy9qLI+bLZu19E/urLVwN/+tNkbomo+opLwWc52WMXvAWYePjEi1WYhKQ3wZemLA4m28Udqx+/yPt53M7LzFBQi778gWXAqcBNZKpWtDdEE/bYlBVCC3WlE/Lf8acswPsvkuaCEfUbiiSJRbEaSnFwZKin1hinQ2mv9SvdxfSR7ZedeFpcpCodJgCw6UvyKL3+f4EDAh9Y7wyDOPEqdHcqIaOJTmlSihS8jtTzd+SrTwfi2G72moE4IFHS1LhIM0jVBNXanV3CWYQIF0LU7QbO/057AJ/htimEKBD25k5IyyjdEfXUJRhPgswtwd2i6f+MyH3iph1ej/3mD76p5YW2ZlOzHxE//OHyhcsDWnd7cywyM1j2K+qMs5bYjxG0Bskg+Tts3MvisvLtZQy+Lwc0ZvVyQM8aPaavgem2hTiC/fmGb47cRa5tGdxmoNpp+YazMic4dDCBBuW4OmuOpaCP+iTdubjcjShqn7JgmgMbto3Ve4nc8hRBwwCX6O496ADND9xEhBGdokoPVkIXeHuPENYxLtiCN7/YBPmdB0Rx16YINNuhdWag5mDjKKvCXBypV0YFWal5iZcOsLbGQ6PZc+Joy/ldrLSNWwukOTpc12q7fNi6RfvrPG0gmoo1vNGzV5D7VgcfJtsIMpL4ibIVZi1/7J/j10cRP4+2nRd6L52ZY0zQUfEQiv6my6LnKAZm5L5rt4ZIoQfc1ym9DcZH6Pn2ABJgUbljR10DqKFhcAA+f/NSKurpRnfc1vcpJxWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(2616005)(1076003)(426003)(186003)(336012)(16526019)(47076005)(2906002)(41300700001)(7696005)(6666004)(26005)(36860700001)(5660300002)(83380400001)(40460700003)(478600001)(36756003)(40480700001)(54906003)(6916009)(316002)(82310400005)(70206006)(8676002)(70586007)(4744005)(8936002)(4326008)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:44:58.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22278727-98bd-4ea8-337a-08da879313bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

Force to enable smu block for SMU v13.0.10

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 533e40dea5c5..27b0f7facb8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1684,6 +1684,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(13, 0, 10):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
-- 
2.37.1

