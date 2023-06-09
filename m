Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF47C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 05:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774CE10E0DD;
	Fri,  9 Jun 2023 05:52:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B2A10E0DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 05:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZBt/Fl8jnrpuWnN0xv2hqbocloDtDCh9Y/3n+zC8rDDwd/yiJPBckDWJCiXj4cbPlpeEdUeaiAr4dbKo7gK+mHDcCaPliiPQu0KVxGo7R4jyt8uS9wWbn34Sdw0MLVFlgQ1CGdbRN1Uic5oemwSqDB0WQg6bah3yMyTYEM6Yw16UyI6JJKU5u5nSzV6sY29uH/WE+CgpYAcMMVHw5dFvWfW2JW+pixI6IqcwLdpLLR8k19q+FRXoOi4nQjzaUCxIiAsIjhXgzzS7EL7evsuT9AOh8b0BWx8bJlY36X8WrMgJ+YZ3PazzCEcFSgcA4u4DDM4xA+QCZGhhEsmpErScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5N+sIAxFlfdfXxqYTti9I/lToat4LdGQ4f8MsjHKLI=;
 b=NyhUdq4XWraptMIznxKS/D2O0ANbQUrishKMp2sCDvfWMUbdYUy6nsyB0rRtnUeWhRqHZW9lJeoITXUr6vicwB9nGjhE4ebjsSQJxaZkCCFXdriH2dlLJ8DOmh7h8b/VNNzc7uoZysVfokAiRXTg0wtVLocDmqiyQyZdn1J7amac7TjpisEPI4KMlWmVU4jYdrsViT9tyh2z1qIdFthqb/6EOZ9fPh7vcMUSGTYvtSNx99gQPxRL7rc9gG1OyJK77LO2FHDuswzA4+CZur+m6ExcwTdWtCDIop7993MFNyL3qmldAzxgsKWiayOCBItsjAeUWRJCxYROVgRxkk9blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5N+sIAxFlfdfXxqYTti9I/lToat4LdGQ4f8MsjHKLI=;
 b=QLs9vg3uP3ulskf7ENgwyq9UnQgrogZqKhyciP1K51I3mCSxSXbnBTnr+PvDMbdrWozsyisI9rKeAzS/p6lWB08hxCH+dEAu68MyUnUxf5q8cEKoEjuRNJyekVVcjde5Yc9bHh/0gaW7YTzY4ab6E9sWBlEivNWjpF4QP4BwCz8=
Received: from SA9PR10CA0005.namprd10.prod.outlook.com (2603:10b6:806:a7::10)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 05:52:45 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::e3) by SA9PR10CA0005.outlook.office365.com
 (2603:10b6:806:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 05:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Fri, 9 Jun 2023 05:52:45 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 00:52:41 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Print client id for the unregistered interrupt
 resource
Date: Fri, 9 Jun 2023 13:52:25 +0800
Message-ID: <20230609055225.3531614-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0352fa-e802-4e44-1bc2-08db68adbf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e97gx1YHq6qQ+W6MAYCAaxLKUMo5F0HLvtdck8HUfGmvGyMxfLRLbYiUDKW7pEEk/Q9zDfcuvc0B6dSt5OEMDMhiy3th+o1Q2qZYJHoxA6I8ATlNKMFsGiQKK9v7442q9M8Ah8oqw32Ryke7PDBYElXkS1qQEqiHEMEP9jzACaRNtV5dp57djw1jM3nclYVikt/lb5BhLic3HU5P/7VVtEAnC59ITOuEAnvLIHuobmYZ7AJ78zz559FzKs3IFbhoDDJNrp1M3SvEZwEtsdYAxormS225ViIY6/A/c8qASB0pXvejbrP5sWIavCM8dHihBH8ys3YnRogH/Th52OfeVBcj0+WA9xqQm0UjmtozCFbIBa621qNZXhOSGswCod96x73pCW62MBuXF6SG9GjIcNYbmiZYGwRTOFJcdpK7sIRIoJzGV4uwlIGff4gTDxL3oraPLrR12lyuiAksVUm2X+mx7sJMAMBtHOMc+Ce1prlVgRZdfS1DpMyFJWOfDybfMhoGzhrxCrayZ5EcvgEllS4jj9ZxZjwHaryUy/WkaDBhkoIdeLbxImrnEBaG3X1gKpF0zMX+hkD6jTFM+qHaJeyj8PEjUVCdfPhMzBiFhidkEa1Eh4a70Q4YxmLCqVJvUDv6pIGybq4Y6Lc1hgbb/i338X9188xGPYmwsXefYrtkJHJBVFC7UVdY5ouAGONdbgqa+Kws+ctaVUyJ+5OsDi5LbR9l2GVijsahonjkCh4nrpHbhenzcVQbQzDpIsV/dKTlWar/YJIn1owJoUQaDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(70586007)(6636002)(70206006)(316002)(5660300002)(110136005)(40480700001)(41300700001)(54906003)(2906002)(4744005)(478600001)(40460700003)(356005)(1076003)(81166007)(26005)(86362001)(16526019)(82740400003)(186003)(36756003)(7696005)(336012)(36860700001)(47076005)(83380400001)(426003)(2616005)(82310400005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 05:52:45.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0352fa-e802-4e44-1bc2-08db68adbf58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify the debug information and print the clien id for these
interrupts as well.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index b0808c1be013..e6edc67ef010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -486,7 +486,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 			handled = true;
 
 	} else {
-		DRM_DEBUG("Unhandled interrupt src_id: %d\n", src_id);
+		DRM_DEBUG("Unregistered interrupt src_id: %d of client_id:%d\n",
+			src_id, client_id);
 	}
 
 	/* Send it to amdkfd as well if it isn't already handled */
-- 
2.34.1

