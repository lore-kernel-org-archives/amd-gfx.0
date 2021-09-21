Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D95C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0E760527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D0E760527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57936EAC3;
	Tue, 21 Sep 2021 18:08:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585C26EA9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOX2JUN21l3Tfq76H4lqn4VBORYB5/5mTDTCPeeGy9MIImlsU+hcpJYy7K4e6jseyVxuU7YdoaPtNg99junUAcRdFWpAS5/E2Eo9iUT2CZ1a62JOyWV/kvUy+4WlFdlnr5HxD1UnGOH4HcEWN4EfEVb89WQKyaVPcO9NKI0DcMK8LsvLRdjiiEhV17oKBbvrxD4ou5LyE0KAZERrn/O+PpsLwxFUbPZDhYPnE0ytBq1AJSmIB/JqHa2KnNh9PTBR91SWZA1LWYC0ToVvTiDHpqYd0K6t3aeh1l/HRQZOUr8+eLE0luNNoSM/fkLaRvmETy0qWWVRLj7gUiW9YrcomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fFUnYRAzF2zibGPoEGVQNntSxs6L0tK9ycc9otAtokA=;
 b=R5Q1NCTfOvL6ff80xwcF4yKq5mqJ/4L4H3PQwkk5hDZ533i2fWXLhUpKYQz/I72KhsOOzYXr1h5G9F1V23ZNytj+4HxHrKzaQQ7+oa09OYQmoj8qH8MRoFZfx51hNUm7ih3gnZiBlJz4n5+Lz/w4M1hjshOnI3cDA/XNwDTZxZ3Pb1uwNUbJMGzM2+dy0DbrfZ5NlTGxNyfmAqBEQOOeZ58yoOsaSFJXXptWKxLJRX6EIN6XkkJgHlZ6SrDsMxLQx5Dq5fsZcA9xPXWZoSx5yBVLjIk8oqnsPrdFq8a49hPCHWfDgRkxFcXbVGVyPA3i1flfVZAWRzoEfJ/yqn+M7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFUnYRAzF2zibGPoEGVQNntSxs6L0tK9ycc9otAtokA=;
 b=ispBoILdPQzXlVIKb3ZMCC1MK9fm68+Hy18u+W7BCfQWTCM+v56wG7JP8tWz+1AqhCEh6yq2J2B6sxs2JUoGxeSucIKQirzKG9nZMDZRVCDIFShjzgYf4cPaq29kBCzcI4cBtGofjfq6Vn9hU9/cYjSpGjQoDoz9QpM5UT5OIUo=
Received: from DM3PR12CA0056.namprd12.prod.outlook.com (2603:10b6:0:56::24) by
 BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Tue, 21 Sep 2021 18:08:08 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::e5) by DM3PR12CA0056.outlook.office365.com
 (2603:10b6:0:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 57/66] drm/amdgpu: get VCN harvest information from IP
 discovery table
Date: Tue, 21 Sep 2021 14:07:16 -0400
Message-ID: <20210921180725.1985552-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d928ba18-cf20-4e1a-6382-08d97d2ac3ff
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:
X-Microsoft-Antispam-PRVS: <BN7PR12MB270870E3A7DA765DC970190DF7A19@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gUwWoghkKaMvpVwAP/zw5uqKh9tIx/jZiLwNx3+ngpPo22/tUFuA21Ryea5YnmbCkynGlxYxZ0GBCdF8gdfXvAXcEOupSOMXs6UYP6oxzI2QDhS2yaDBpvi75agsh0UzgOs0G8HtnkY+Vw2KAYzLiKHOvljWmgqIMEPED9lfKVld89WtNG3erEiQ8E3jmeXehf0/W69oalirRzo7sdiSOQIlsv/i7YZE1zO0W7n67bc70nDHdjLI0zDYSkFRw0Sgtd6sRTlMWQ/Dq3KTKoOIO6djVV+tHK+AG0dl8TZk7LdLXmz+n1zkVKBUFR6vP2dJiZLKE2jj1OyRTYJ0vPlDCGNu0+wX6TuupdHESaGrv9Pq5KIYUEnbpqemnb21Hw9AiGCaiOoxvzAqKwc6BvNNtA79SqtuJ2TMHr+HwEFCLIYYnC/gtnzDP4QANWWxHC1UA47K4U7VDCiD4WVuZR4UCswPZiYcYa/X8KTfXR7xv9ZkOs+IRVN7lw/iumSeIXdUiJ4HyBjdgnYUa9ou+2j/v2zvjOJQq37Gv3ro2ah7ptvHsq0kG4sfcLQmfIEw/wBDelZUOcTJoJJVx2XunoSlJJZf4fN19w5MAkadFnz3jkih/gtaohq9IqD+ohCCeKYhDQce7AIVrd8D5/JIVtTNP5a3kKy3DmddWFFUnZdDXZ/AbKMCwnACwbPjNV1e4dM2tlP5W84u3dz0EiqNCDwbzRXU1z6EvjFK3983Hh9StA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(8676002)(2616005)(47076005)(6666004)(2906002)(26005)(70586007)(7696005)(5660300002)(4326008)(86362001)(6916009)(508600001)(82310400003)(70206006)(8936002)(16526019)(81166007)(356005)(1076003)(4744005)(426003)(36860700001)(186003)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:07.9159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d928ba18-cf20-4e1a-6382-08d97d2ac3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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

Use the table rather than asic specific harvest registers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9e59fb792643..9d8aea39f36a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -456,6 +456,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
 			vcn_harvest_count++;
+			if (harvest_info->list[i].number_instance == 0)
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
+			else
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
-- 
2.31.1

