Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B734606A32E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vah8krpe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D2610E122;
	Mon, 23 Nov 2026 19:17:10 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF9A10E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 19:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKU6BJ183VDV28MoqbLQKvnTA+zr+txFEDaW232sMlolbJg7jvMQbGUa/FeJ0jc0p/47f6fiRJiDst3x9b4usZmYFKnIlvrom35yMLNhZ6pk0NtslbMXLs3mhgLrplkXvPC6gcoNKZ+2zirTepKWaAzv7E2FyQZbpqP2irtBsOlAvEhgkxbS1BeQ8u8STRk3CcJNce2vxevvROy59o71HWNPS8EKPe8gO+5RcvqhrOiwcsXt5koQZ1fgyY+QY5IVaNTfv0ksmpUtES0V5oA/pZpGtkId2pkoSctvb+aRqTNF6I5uTLA4pksWwMyYISOoBjp7ktEcO9fFqDbFMfXJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB4LMk49T1S96vtQnoz5hl61BS0OyTu2GCSW0f87YHY=;
 b=nQ9CnQ4Q7WNY6OAIipzpu8hFACKQqcxq8l4av/ya5q6TdDIjT7ld7/G4HpHjACibY+ulsj0oiJm6GVfFmCz7criPeL1/Sg22MEJ/1o80XQWV0uRAcaX4ANH7ninYG7D+2RfyH7mfJYIbXRQP4DbRhCPBWgFCb8m21Al1Rpg4VEbwOk4gaZ26FMJk5MetvuOVBcjd/Iy3n+I5ECHCUyzcfTXSreSHzcTo/4i2BPqpIFCREZy94HR1BfJBw3ARBAwkzlkTBQTUkVdYqHsiXvghoIA7i9CKJGA6d1fQ+VHxhP/4PApIpO5/i9BucgYPwvoFMqK2mmQfYrNOBqDFUjKzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB4LMk49T1S96vtQnoz5hl61BS0OyTu2GCSW0f87YHY=;
 b=vah8krpebiYQxNHeQlh7S8Q8ViZridQsThXdHpUU8ePI25iVCVhpP7nzuqd1IyAC7WP2yQIu7SVPw5oCiPqgu6XCnVE0KoM2SbKx2f73aLxbFkk8GqdUjSK2yyqGOnT2qKhy5b4fXnGt3mQfviQKmJ4iD06D/uev/4aOZSPgW7M=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 19:16:56 +0000
Received: from PH4PEPF0000B60A.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::66) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 19:16:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B60A.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 23 Nov 2026 19:16:55 +0000
Received: from jiahao-li-HP-Elite-SFF-805-G9-Desktop-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 13:16:54 -0600
From: Jiahao Li <Jiahao.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Shravankumar.Gande@amd.com>, <Ahmad.Rehman@amd.com>,
 <Davis.Ming@amd.com>, Jiahao Li <Jiahao.Li@amd.com>
Subject: [PATCH] Revert "drm/amd/amdgpu: Use RSMU index and data pair in
 nbio_v6_3_2 get_pcie_index/data_offset()"
Date: Mon, 23 Nov 2026 14:16:33 -0500
Message-ID: <20261123191634.765657-1-Jiahao.Li@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60A:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 019e4cc9-3242-4252-bfc2-08df4996567d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: jyoEF2mmy9ESlk3EOAYXhR9vdUrl0m1ixuyUZHNel1IEz5QpkOkZPo3sye2GvcS3IMyYQTRgBs/ltsrP+RhExJEFRF/wa8wvTebONC4mfYxLdEkn41V9950ja7cUOgAux83Fa7H03WCO3aGZNnTyJ4bKW6wWz+s1y2vu/oEwSgNDRATjkV4QvZT6MoFTz5esA8sHvHak+o/lNDHSnfkIvWXcMXeH0EpmVW4QZ2FCHhwGQ/NSGyzAm7vs/Kjm+s9TDusvniz4dNKSwXHgrLStmlxMM6IfMffr1ca4UnbbAKM+SjdqQ6LSx0dacELwb9+CoDQVRJDwbPojZTQykxakz111DQmnU/39v+/b1hO8y12rQOvGmlLgFTi7Saahq5+wolTpnw1kA0LcNiKEN2VinS6CRnKVmkseEB2fEm2ZV+VPAktqHmdLO17/H/jySUjvM4uV/JREYpwMmDb8kuL8NneCHxVt4wGrlQeoTTucfLn/j2BXy5byTOdKe0YzWbErCCr3yQAmf9Z0bMH07CdfzqlP+XTVj588QljhJbqn8WkT8OLYNh2rbGEAKiyZiXNSmklzC8O9zQMDSM+b3TcctzbqIzWSfQdCG2qoufEa/T2SIwtU7cucmTit6p+8iD65HEmVrWhThjEtW0T9Wa+9uvcZDJdhpHb/nHTgplyszz4dEqBfrm5E/Pg9+CS+d2suYLVtw6AcgzCWbdFYY/kHKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WY56q71iQ7SoTwDYrkQQFZOcfivamg8B3PP6MldBRqW4/vIDTJ0WX6KGltVzx4/FcuMPqiSVKPZ0yIldbBqSqcD5yz0RASrKzy8KAHPPUaM3EcNtuL//mDHBVvNJVFgmZ+ksxaPgrKxiSUYSjCbIxClFTp7xmP98lI0h4jj+z/01NSIQYgz4gnQnSUlULuZZ8I7RBJB6RxkXtzuvviAfLuY3ChO6zyW1vxCahi98lRVmqF7YdXchE3VWIY0mDkyBDDDmJVS4JhoTWCg8Ehbz5BhLmC1oIFve+06RPKqmpq/upgqDxrf42hSCH5LMObBirhR78769Scoc9uMVLhnnwarSo8cUhOAynXQvjMMIEQqnf6tRzWHRZeUtYvWxIZUTzZyzcLhIHFizcA+MX6D2ZX5y0vFo1XMVyLNNzb7XZkFvkR7USJzNKms6QUwkz+4y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:16:55.3781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019e4cc9-3242-4252-bfc2-08df4996567d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B60A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit e61b299b866e4ff06145a87da304af9a169231f9.

Change get_pcie_index/data functions in nbio_v6_3_2 back to use
PCIe index and data pair because the RSMU pair is dedicated to tools

Signed-off-by: Jiahao Li <Jiahao.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index 9a5ccc976e11..75477951353d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -79,17 +79,17 @@ nbio_v6_3_2_doorbell_layout = {
 
 static u32 nbio_v6_3_2_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
 }
 
 static u32 nbio_v6_3_2_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
 }
 
 static u32 nbio_v6_3_2_get_pcie_index_hi_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX_HI);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2_HI);
 }
 
 static u32 nbio_v6_3_2_get_rev_id(struct amdgpu_device *adev)
-- 
2.43.0

