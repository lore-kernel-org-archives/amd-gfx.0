Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74638C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F48510EA6E;
	Tue,  3 May 2022 20:09:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F76C10EA33
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyPnXksuArnl/YP/katFd3+WOIAKWHXREFmNzG41jdSpEWwAe6rTwqNCVyMldhpzmHJ9DVY1g2lAidlYV16BUy+kZaJfZLzP3PS6UgGIGG/iLck6YIaDzwRrxPOkXkqlLaSsPjrfWWcO9UncLVhKA8y+YpzxBV8HfpjFkgFED53g6oZbNULSJNP3zKiRXcK+ut1rHJ+EkYqBa3XjArANPbs7rT9HRJFGXevR9qtYtZB9J5Kgd2ZhhYk0qqc8siofl7Kugn4BlkfCyUApHyAiJW/SSHPkZHXtIpe2bW6VX7V1MeeE9/5cdBK0Kp8P0BNL+H8k7mrTrbYPVqDn9BkaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHO6HFpfzENdCxybAhu8BcYhq9hhTij6iadKDvJKwPI=;
 b=hhrjnHRTnhQk0m9W6zranr/GydV9Ydh7JuIQhCtsbLzy+eS7m9TU5hvH39xMIGPmtUba1TnMt+vOJQhInRFo0VJwBEky09k6JUlOd5YTRTYerMQmk6hzQwhiYmwQKImP4xcJ99h+6o65UHRVPfk9z6wTkiLHr356xzBm3hqv+gp9SprGCtp4B/++zJm4yhzy463mrhoUd2ax6LFuWqgn2RnGlsGaRd6efa5XkP5i++vHaxrE9ht6+1Rzq2R0BNhVkTIyiITxd7DZCqVeraRuuZFTUn2OhG2JAsVxpS5svy5zvNIev2HPuyhLOHEI+6USO6vtlybz08zFUpVxaEsKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHO6HFpfzENdCxybAhu8BcYhq9hhTij6iadKDvJKwPI=;
 b=jUO/iNkY5wtqce6pDeysrjRh2BKNPLtnGLPDfYSNwWMFE4A52m+XQNOnpUq8axX5k9leiCjOpnrbBlWSd+HyBLcP0BDF0mazK5Kaqkuo8WFVsktRJSxMtTce65VG4F5rOp0/RzbdTgrf+4bfUDyBsVj0a40fbJ8yeYkJD1/3Q5k=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Tue, 3 May
 2022 20:09:21 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::8f) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add nbio 4.3 support for NBIO 4.3.1
Date: Tue, 3 May 2022 16:08:53 -0400
Message-ID: <20220503200855.1163186-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc6f84e1-a64b-4733-d768-08da2d40cf7f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0206829D7F75A5266F5AA66FF7C09@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LyK2lONcYGmcAHn3gTm/X0y6AC92lPrT+dgtSyYszT78yBoim8kYFBVTJX3W0arRwHJpaTFmXseP5dt7R9qnG7zUSV8vYL+K0GLrhnp1zLzqqpDfxWLlTNeGzZFfi8TBId9CQj+bwSgLQ4ohGt8nFHS+aT6pYvBlPyVlE+wTmbKN0qLAo+ZiJL3PHJs8bqeVcRYYCzyCBo3cYG+ZcJXvnSMaRD6lCso1y198k++d9GBT55KVDPit4yUJQyobzj+LtwI8EcdmdGK9lIF1M/pipM1Eotkm7pLLwovNcCNHdw/ranZwyKW8vyv44u725fhU3KG1jgukTzQRVxIcvO5ucodeCWWYpxxwPWHcXH/O6akT5nh/GkOK+UY22v9C2s8dCUnca1A+Dvhqb1ABAW6g5SZD6mfMcpOlP0YaVmfJ/dP9IqbRgs4oOHGtICCFgXShAuoo7quDsKO7aDMsdbrSujgtBOP4wfMlKeBiOb1RfP/1eyqwv0PTjfZ1CqdQnD40XHaVNIBhBtURAKGCaq20yLY63xJgYArcwm4AwHaIlwXCQ/6WdRwdqT2Gucny53l0oIRFbtxBzNeZA6XKFAJrCshzungKoEww0UPWwkzlCWbAOKeRr/3A/wzt3NfgaJP88z7CwGtrkFD+z285JtKu4fIIisOjxSJLYsjW0JB7wU33eEJHxqr2052N213M6WmnXoXIXcdxzKhG9NbplyeLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(54906003)(4326008)(8676002)(6916009)(81166007)(5660300002)(4744005)(82310400005)(70206006)(70586007)(8936002)(316002)(86362001)(36860700001)(40460700003)(47076005)(426003)(336012)(26005)(1076003)(186003)(16526019)(36756003)(2616005)(2906002)(356005)(508600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:20.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6f84e1-a64b-4733-d768-08da2d40cf7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable nbio 4.3 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5263f94ff182..26ed3ff8e7d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2189,6 +2189,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg_sc;
 		break;
 	case IP_VERSION(4, 3, 0):
+	case IP_VERSION(4, 3, 1):
 		adev->nbio.funcs = &nbio_v4_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
 		break;
-- 
2.35.1

