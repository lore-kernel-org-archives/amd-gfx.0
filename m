Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7624C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 06:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590CF10E5CD;
	Tue,  8 Apr 2025 06:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqeRkCZc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105F910E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 06:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6v/nFAz1hs5kxT65jFq+QgttVs/vOrKkoEENeDSiypuiBqiyg41ucT/x8DNtBzTsPPW3Rs80qeRqFzNszV3a/EDkQ8s6I+jGRnVlmu3mgyjfOEr5K8xWGGWWA/IY2HvqsyANV5yzu9tV2XdJa+f7Fpad3QE8Mmk4pS5l+cTWIoD1kURavpTHRJYaQGS3N6vyfx8JEuhI8op6+GiS20eLSTHDDZWlUg3xMLbCA+LGV0vnsP1OvtwOYzkoSOtpq4UhlwEBw/4EjwxmqxA1DjtAoFhK28wg/esNRFCCZmlggjkV7NWD064OmTJrLfiNFHaa8kHycsT5dAuDF4GXhzmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT6gRC0LlJAy8qkAXdjyeIiwzsZvHnq0JFwFirMcoDs=;
 b=GinQN+tDmXp8Dn1FJFjRTr5XbuwNmotn2S7IzEtjwaV7lakCOJytIeBV7AUBHVLtiJDDPzjGgfT7Uzbv3wFb2Fw2hz75othalfPgVXXk1EU48a9uuCQOEAd3KRtVFw8rIe61E4SBkB1FMXPKvQuPXobLaJc4rrGIdxgFVkSha4EI6ett7YSqgUP364cqWS2HEdpdj5/kTPHVmoZsj4IDSif/VvfBYHNFBaL8mi/Ob0+lq3B3MnxhV8Hlptw815nHgvF+DogMwZ0LLPGGwpnpIR5BoFaYB1SoUn68xWAlgc5AfeNTWzXCj70skLRLqFlm78S7UKG5ouY7FE3K1Qd8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT6gRC0LlJAy8qkAXdjyeIiwzsZvHnq0JFwFirMcoDs=;
 b=YqeRkCZcdGWIDN/z3C5EHKgnUCZB39esszpcqwZNG6UH3j792l0qDn5HkiuC1+edGB7SofQXWVTGuVAA+zyh+imHX+y+PJTY+jvoaDsG41Du4HFp66NQ1eJ+y+tkMone8HcbmcdJVhQzRtYbqqQdVM/uADrobYYaG3sDyxy7nGk=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:13:59 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::bf) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 06:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 06:13:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 01:13:56 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <candice.li@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Reset RAS table if header is invalid
Date: Tue, 8 Apr 2025 11:43:39 +0530
Message-ID: <20250408061339.526898-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 1766c2b7-88b4-4ed8-a5c1-08dd76648d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJryyaxpgr657tFOhyb2N15IQN5GkbysytxuoAZPj71CgiRYHC1Tle9qT0xM?=
 =?us-ascii?Q?ED+iOE7SGCOZ2iLyIPMFo3y0ZcBxbxBcTzfYkjwy8VJq+0GayaKPTpPI8xcY?=
 =?us-ascii?Q?UZLSMPmCA1g1NMnNM5L9NrAbE15scGUj2CGDhiBaqN3Hp3Cv2/YhYrrRyZaB?=
 =?us-ascii?Q?2JkSEc+Wm1MOpl7W/lKCaeA4jrWF13yXF/1ihVGeU3hZ0TffruABHFlvb4ko?=
 =?us-ascii?Q?iOP99sVXbwDLeMHKI27VZopthdA4LlsuOOa26gihZ3UxKWSx12zoVZVBeety?=
 =?us-ascii?Q?fwnXps3J/jXCxnVayO094LGsQa813jYRG5dOzBQRFhpdBbLvSNJM4I+50k94?=
 =?us-ascii?Q?nedaK4KoK4orL2BSg1MZ/EUTBtmgEthfINtGnJiGPXL434R6MFuBskZCeEte?=
 =?us-ascii?Q?7G4iSqRCysI2oQ1RLgEAJaHr8iSacA+HEnQQxZVbwsxdtNZ0ngt209RtkfXS?=
 =?us-ascii?Q?rGP7P3eMEqtxwbfcsYHa+4vckoDFd9ByHeVOBirp6GuCeRPXrHbdZ8G5Ubmh?=
 =?us-ascii?Q?4xIz59A0wToPO/L8/EAGN8OoTvvj5/zwGHkDurb00mvR9SDP8YKMzXrqOkDh?=
 =?us-ascii?Q?hcvFQ6F4GbskSMDksQT7JSUumZ3qOJ+meUizLBTqLE8dZtSzdlJDPIx46GGV?=
 =?us-ascii?Q?T9vay3WpqiB3sxynVteq0gQmGg5Tel4EWIrjTZL87IUYhpyClwvT0fysrw0B?=
 =?us-ascii?Q?wtv8ZcXOZ05UkJYOyqVMOUTThgCELJPXispmLtgAvSMm9pbKQe4g1opJEVUb?=
 =?us-ascii?Q?/1FlQV3EmY6Nk18hzwxisDiwqkfiWmBRc50aRM8lzoPyE+1kaRq1U5IfBq4m?=
 =?us-ascii?Q?qy3AIx8pMWmuVqvWoKGWUzYxjH+teTiGQjTF5jXjm9Ps8WKmporNOsR5efng?=
 =?us-ascii?Q?GuGx3vu1uWkYuEjUU25YolCpEIlbT8x/qSkEAAPj9jA5HNunhF4cex8rj+T9?=
 =?us-ascii?Q?QdLWUH/nKRxBQwZqy3C7dURuomzGkzWgmDOVtAw6mpPpdnbtKO8PW0REmc9c?=
 =?us-ascii?Q?o6309D1N8Oc1kMsDmCLvELaMSNTU2VvT5oJZxTXWDXjpU2kjnRMQouWRS8uX?=
 =?us-ascii?Q?vrEc9is8h9XnVl8UQRbRBvBd34UpbRgrDwTFuK+6isfMYS267BCxuhdi0Nik?=
 =?us-ascii?Q?LclSVUM+qLIG9rSalT1QM1v+ESrFemXJ3UeSI37buAAO6n7zo4GBC9AOEjCV?=
 =?us-ascii?Q?wt5qEivi/hHIJQKYUz5ilkpczXXwfO2O4/NN079tTOsBuZSCYpEPDqEwfXoE?=
 =?us-ascii?Q?D9uqD5/is3XPda8cIZBoeppai7z4VJMxxmJH4YFHDfnUlb8kwwQK/iEnj65S?=
 =?us-ascii?Q?TLDlsaGvceQQESaBJ9+L3lM4/JYeiW61YhFLmi44X+9UIWRPWYSXN9Le7Jcr?=
 =?us-ascii?Q?YLs9ON3FFV3nVOlLwB+5qCEhZwmdqfDG+aT2/jjKcKbiJac8IQRKNDpXb3e1?=
 =?us-ascii?Q?DaqiGBw6NEdS85nZKdDMbt45QxqE9lhIdmUtke2Xi4OM9NzgN1Wxhy6ecr23?=
 =?us-ascii?Q?29xyxBVwie1N360=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:13:58.9574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1766c2b7-88b4-4ed8-a5c1-08dd76648d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

If a valid header is not found during RAS eeprom init, consider it as
new and reset RAS table info.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e979a6086178..bb767fc20242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1392,6 +1392,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 
 	__decode_table_header_from_buf(hdr, buf);
 
+	if (hdr->header != RAS_TABLE_HDR_VAL &&
+	    hdr->header != RAS_TABLE_HDR_BAD) {
+		dev_info(adev->dev, "Creating a new EEPROM table");
+		return amdgpu_ras_eeprom_reset_table(control);
+	}
+
 	switch (hdr->version) {
 	case RAS_TABLE_VER_V2_1:
 	case RAS_TABLE_VER_V3:
@@ -1510,10 +1516,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 					 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
 			}
 		}
-	} else {
-		DRM_INFO("Creating a new EEPROM table");
-
-		res = amdgpu_ras_eeprom_reset_table(control);
 	}
 
 	return res < 0 ? res : 0;
-- 
2.25.1

