Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCC9C48BF6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 01:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7845111268C;
	Tue,  5 Mar 2024 01:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ilD8QPcd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD1810E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 01:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Odl04DTVYjHlDrQJ4nAmo9/rfEbTiIYNKQalCbDVzM8Y0SXnclPm5o3PqpdGxGPuRrgi6FHsvzt1JfK9QenyDr2kF6yFNKAnjIEIGRLoBnrXiFf4cLjb8kPMgNwYQvBrX7OGeSV21NImBgFFW8ztmJz0sThCtW0DnVGVwYl/LKacq+TM0vjG9MuC4QyGBlY/Jn0obPjuw5+VZK3+npydzX903o9q8qekD7OI8sefAJJsBdpUf8qUfozqp/r5M09XOtJuOONsVSliia2l5r9ptBeuzoxvqFEBhqaB7wfQKjj9d2LxYx1XAVHOoszdSdNg/sZ54Dv7yDVUmUiAD08GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0MmRCB2yi0egU3dUQTuuYZ5jP3RFe++Su/ptH0sCSA=;
 b=RJqJv3EaclElZ0WkoAJq8d+IAKPoxgfw7aZVud+tW0MNYXPOnh+S4rMWLKwr5ehB/aCmFrvEnsQYiWxYdTZy/Rct7xUkUV3lr3JCgm1Ja59pNR1NLp95KExWuT0R50i1jm+59X5ayVB/hqOqKvnGPJKigxN89GALoWFqoLnOq35j/9oowgIDQyMdvcVecr8155cwLiP1F141QrgKejC4AL0aa9QNlCgkFJI/2meOWhXImtbEpWWwj8d8Tzct8WSrhjL/QVW9E/WUgnWU9hoJ8+VaCMB24XSE8ldZXs//mSvtQaII9JWHU2ONRjIlQCr/8HuP7FzYHdz9HwNdi3n1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0MmRCB2yi0egU3dUQTuuYZ5jP3RFe++Su/ptH0sCSA=;
 b=ilD8QPcdtoEAv8QyGejST5EJGXjD+BQ7yK9rLtpRWqPENK385sYfODny7rHBHA/89ip3bXfQneu1aDt/Bc7dKEKJOZVli2yY9Ww5IFs3CgADmxJoAYInx7CdgV+/QAN6xFGwi5XuQbEZInuL62AR6nG1fs4JFBKlT/1m2ayCdMY=
Received: from BN8PR15CA0031.namprd15.prod.outlook.com (2603:10b6:408:c0::44)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Tue, 5 Mar
 2024 01:19:59 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:c0:cafe::c7) by BN8PR15CA0031.outlook.office365.com
 (2603:10b6:408:c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Tue, 5 Mar 2024 01:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 01:19:58 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 4 Mar
 2024 19:19:56 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hamza.Mahfooz@amd.com>,
 <Harry.Wentland@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add dcn3.5.1 support
Date: Tue, 5 Mar 2024 09:19:26 +0800
Message-ID: <20240305011926.1518752-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c077a05-b2fe-498f-7b8e-08dc3cb25fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjrcwH54q9qI9afpCLjDnx1rKjBDK6vOhcpBOL/kLTDZvtm0Z2G8d47ElGbmDrcdjp8qNZHM8ZzCaCDsa8WhqXcaV0qoEY5lis7yn0iwJ8dWBTzHDHueggOEyksCehtF0jwFKUZ6CSccpFCQXA/nKbKxTqBZHNkfBLqukFIlhM3ntMCUCvGtAl24H11yIFdHD07DNIpuNA2XnFL57a6k6BSlVPnlERe3MMJTDA4qWi9iRdI+2aivzZs+lDrntRmHAggA6zKdQ0yTknPujVrDhOYGuRvjy+tnFEFzH01Ml9k1cBpN3xHNE/NrA1Pmywkp+bHTuBlB/sAieaIvH30kv54xmkQXZH9hylKUlSUKRCVHzGwQRs3wAEE1jWwOb8ttmzV4xZby+dZeIAWx3TCY39nb5xdBZNy1tULWqXQmC8yu49wIzRIBM9mnmFqym4gQ1IEIiyYioqEf1oMqa/efcN1DJxwXKtB2J6LNhJg6E4kz9yehczcy8T4B5ZiBt5bWSqYbAbC56WTO2C4i/QoETmiP6V4A9iQRUJEYmzsXhUpodCO5lSxSgpvxRFoSsmSCssaIKKHAlwyeM8BWDAxvRnSxFN1NXs4X4IczfAmsbjIbfECbzvwBYcmYrajqaoCVovV4lfARS5Tduk/8h0AH6SSRR83yk6GxqzxZLMpN/4hPo/MAMRqroxivELtdr2lIE8AAVhrs7f1pnh0ZM5SS3Affqtq2lo0nb1L8wyhx2A/Zof25F30h5bDIcJPh99//
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 01:19:58.7291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c077a05-b2fe-498f-7b8e-08dc3cb25fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to add dcn3.5.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 502333725b49..72701e7f09fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1936,6 +1936,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
-- 
2.37.3

