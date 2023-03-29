Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3BCC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D45310EC3C;
	Wed, 29 Mar 2023 20:09:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5397410EC11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmhKlL1hXvsOXZ5Lpehbpc27LBUXD5yU5gDsyVZC4YoKOaXCzSRVbyhzsHzta8KyRr34WuCGHEE+2r9ltVqnGk3aQqkYxsjHMQ0hhGbNZjAKBv2FaBuaJNiUtdVdBtkSAq8xyW7JSuTHFlfkiuL29xawzg6l416hYffXXgXx3ef1MFGB0/8pA5QYRNCvshHM1efDG/qf4DjTM0HFdYTd9rEpoxy6UQgcVQJIT/y6/HvFx4aSy6lhgGfd744GdAS0QYuaDd1tiivjS5tnBnuKFJ+p4oJsjX/vzoO1vUYtKzgQthaCKNmKm6lEe8wQ+WNCbgBIyXAZZQulCrnvySlF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbwXZnlIfndWEeIExIsIO0sZdLKz4w6zLfhQwTnB3PE=;
 b=VzMlYKXO2JPhYHKIyqQ0Y/iJbxrfBOZMVz2ipZE2FmqCj7qJxe/xfCepZTelI7M39fShbpARsv2HfrmPrPwNphe8DEAtRhQJC9X8xDyLXQiSo63tErfmuVWuMPCxHq1PbWQo7B7b+tMHWU/cpGliPhyLF844V9zXMTwdNMus+X/Pi79n4/RfrdLKJ0ZZvyiXHAJfxr/LGHTVlEmGklYx8ch67hZCC+MOO/TIlyJkG2WjfZjxH1EguQNaNwhhVg9Q7mEWBC2j7CBP8LIp+dtThEV0mkFHSmzuApilm0l47R1b0F6EprY3GsOXEYNoEBX+0zGh2sZw1bkZzQD2dtSzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbwXZnlIfndWEeIExIsIO0sZdLKz4w6zLfhQwTnB3PE=;
 b=2GmHq/3ILe+AKoEDEu+qmJj+cqJSJwpEtO0v+IAIQagungz4za3zzHcvnO21FLn/ZNg/socGK0xgtaxfCabrdwia5fZgJfb0aiJgmcQN10OltmJ80MFJK7Js7SRhDXxf+LW7IbIdyY88X9awV9Jg2bdu0C6FPRWld82t5Wromg4=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:09:52 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d7) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amdkfd: EOP Removal - Handle size 0 correctly
Date: Wed, 29 Mar 2023 16:09:20 -0400
Message-ID: <20230329200930.1982035-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fad5aa8-7db7-4e7e-99c8-08db30918eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ1wC4QDYPWlGVLsmqqGMqoaB+XZmnwqkw04OSYM7EARbINTI2glfhcf+GWis/K5Gy1lIOHmM5Waiq0f8PDnAfHPkJFVyN0+9yVQiTw8WOXT92SZVPMgBHPmTY559yjbq9zJoH3dhRhLD8f6n1sbfqCjnAay65Hygva2FYombs+SSRRkPfPAOsp4Zf16sC43NL4C0PzfSNHEonUIxQa1AWBoJpTiTbnL4Wqr+fEH4/mczioDlJzdw0rrKHXX5T0FBfueVj3RTnwKkhSddHk+yvrGnnKFgb8OMzk/4xmlpuVD+wrGGWZeHue+Y2dl+YNHC5HG64+7h4nwGpMgmfmNIXeT3jzOKX8/CzKYFm6TDIH4Ey9CNldk+xf2GqXOJFKsjIvRNYY3wlJqIGXPn5ZY8Gn3EijyEazOkXVjFBhU56mwpfXNBhKmmPuSHSmdJgYLN4uozsRymnLreJcocCY02vcKTCAaQ4y5oUI6J/H1vP58TQbgjZosd5h5pS3h/OZhmGLj8zAFm3waESn55KwwZ1FzDsHZkXV+Sz6Weruz5n3u+RTE9HVxBStMqy5YSbBT5iN9L3BEUdUiHK3N5g1mpxUt6+JO/F+xsswmffvNr/+GW8j0GRgRVu5D9c4G4LxFqc/9f1gQALjl+BmdbDaLzSpdVl4Mpe/FxfL+XSAjrao0Bg1Jr7HBwWb8H81y1PmR4iHQsbEbFqa4QDa6lZd5mB1q7miJSJF8P5QG03su1jI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(4326008)(70586007)(8676002)(6916009)(70206006)(41300700001)(356005)(81166007)(36756003)(2906002)(36860700001)(5660300002)(86362001)(8936002)(478600001)(40480700001)(82310400005)(82740400003)(316002)(1076003)(26005)(6666004)(16526019)(54906003)(186003)(2616005)(83380400001)(47076005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:52.4277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fad5aa8-7db7-4e7e-99c8-08db30918eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 David Belanger <david.belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Belanger <david.belanger@amd.com>

On GC 9.4.3, we are removing the EOP buffer.
If we specify 0 for the size, CP_HQD_EOP_CONTROL ends up with
incorrect value as order_size_2 calculations does not handle 0.

Fix it by using zero for the MQD entry for EOP size 0.

v2: Reworked code with a conditional assignment and fixed style issues.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 09083e905fee..2085054be3be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -256,9 +256,14 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * Limit is 0xFF EOP entries (= 0x7F8 dwords). CP will not submit
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
+	 *
+	 * Also, do calculation only if EOP is used (size > 0), otherwise
+	 * the order_base_2 calculation provides incorrect result.
+	 *
 	 */
-	m->cp_hqd_eop_control = min(0xA,
-		order_base_2(q->eop_ring_buffer_size / 4) - 1);
+	m->cp_hqd_eop_control = q->eop_ring_buffer_size ?
+		min(0xA, order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
+
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
-- 
2.39.2

