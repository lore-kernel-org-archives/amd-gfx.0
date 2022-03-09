Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72DDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 02:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA1A10E14D;
	Wed,  9 Mar 2022 02:10:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E5010E14D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 02:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb2vA0VWtkxA+NaR4BdsWn4oMg/HKe1n57rDMO++ZFvRXfDlPBXZBkapubEclObJuJWmy8yYKRBjEFnFi1//VLr4QVrim2Hy2LAodnrq7H/KGBJaK+/8raPi4grnWG527OLSzkxiRr/fEmB2DHLYJ5Qp9iFiKRdmibtVj+hAxJoRAfZkeHzAiriw8vCjT5YjnqjwTQn166YvJm6n6KbzGyZW24+sYLGc029FRbbWo0WYNAfLI2DIgGgbsAGc/R0BifQmPFJq0HquddnTx/5UZOCmjRRhRb0F8hPOYUs1ft9wIJkFZiUuqNxel88sMCPOl8lXjQ2tZsI2dI9iFYz50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK8perSZ+4QSuh68IzV4l8EY3BqaxpFENjoo3ZySTns=;
 b=F4MRNf6eIUKrBm6ID57h/LNwN6zCNQHmrVKZ25VcADOXU+HQ6uAnxGS+9piH8+OZh4vHnt8WqfKIhfrMXNPZtHgG7BQcgOhSdzT4HZUV10k+5cE9lj6pn3WE50Qtgz4376DbVnd3v8CHT7DMrax/yVIfH2N6jsZxbXQnYM0l5bF9RysHE9Nyo2wvEnePjuxN7eRqWJkl74DJ8kkmfPnGEJ/5a1JGGGjUlUAsDNoruq982IvClsjCbNhRCaja9Aln3UcvSrWgFyI8X4gL2XU1Yn24Wvu6/q8hRHmC2BMUo0bUGv4K/vHSwpbvB1g6sJujotSLgmvHmvsstgx/8ZMJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK8perSZ+4QSuh68IzV4l8EY3BqaxpFENjoo3ZySTns=;
 b=hFFlugrhZPamirXaJvSMcT6DlYdsAKkBTyPsf+QM8juSY//3+gOrGVwoNVtD6PxAmo/SR8+a40F2QtzB8Oen+I8tBicZwMRUqenbjTjOkIvEiTZvkQR7/mCcRSZ8GpMLv4o7QGEzT/THxkpDg/LS0yOofZ9U2WwGw0wJWC7bauA=
Received: from DM5PR2001CA0015.namprd20.prod.outlook.com (2603:10b6:4:16::25)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Wed, 9 Mar
 2022 02:10:12 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::52) by DM5PR2001CA0015.outlook.office365.com
 (2603:10b6:4:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 02:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 02:10:11 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 20:10:08 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Date: Wed, 9 Mar 2022 10:09:37 +0800
Message-ID: <20220309020937.2625238-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd5ebfb-5615-41c3-8c09-08da0171f14b
X-MS-TrafficTypeDiagnostic: DS7PR12MB5717:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57172B91C79AA01A77D0DF12C10A9@DS7PR12MB5717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLE/qnE9xIWgIO/bv4HGSw2PWzB5xhzcr79Mn1cT1H2pWfZxYC+HOlG5mfBgXci+9Byszg9P5228sCr4XU68UGiH5YbiUziDM6aZwuNi5sWMZiZjH3DOewD9rUVda1fnqo5PxJAhdlFV4YhLBtwBvbh/5dmVyix1hQCrblK/RdYoOYfzSebYDNhHbwVr4yJvr/HADiitbXkLHoqOiD4BOssnQZBtceU1qfHy/DZKL7WM2RLiRQUPuBJpQmXym0bXgoo9TBn4+4ulcgnduD8C6Mvtzf5iSuBbgJDz/CJyVCfNYBmPyEeVtDhOsEAsacQWKBVFY/eQSd1Mbk6ZhpkPcJIVZ//HuYNWjuM96xaMxQoeXizn5bkcicEnanEIB8NkywBlyNlVkf+ARJFVscSBpn//hwrD6LT3YFPQzZ36dMz1WscKvNOg8srmb+qjbpOmwNmBEwYLwAs+CVAJFPmX/XG8CI7Wby9WRQVuQwKDWEAAnwxlduq/r8kCDosM5gllOyO0V23rRPojK5Alqq01s9k/FqHDtWLDKVSRQnvA9nE+EssmrhFd9GfYUsWc9j+ZBJH5CRXd9Gl8lJmFKIVTQOyfiZjUw/AZdodG5HzysgJuxkVNHy0tZfwhBzKsNAR+PAJq1Xdb6hhOthz3JHxTu6+iPyxQmQMywkPLRq+tbPDeFzG62VZApep+HLQLx1RUSALFFnylnff0qX0mr3ratg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(8676002)(508600001)(2906002)(316002)(7696005)(36860700001)(83380400001)(70586007)(70206006)(4326008)(6916009)(86362001)(54906003)(6666004)(5660300002)(81166007)(356005)(8936002)(16526019)(336012)(186003)(426003)(26005)(2616005)(82310400004)(1076003)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:10:11.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd5ebfb-5615-41c3-8c09-08da0171f14b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
Cc: nathan@kernel.org, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it makes no sense to continue with an undefined vmid.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 77364afdc606..acf4f7975850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -500,21 +500,24 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process
 
 	pr_debug("Killing all process wavefronts\n");
 
+	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
+		pr_err("no vmid pasid mapping supported \n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
 	 * ATC_VMID15_PASID_MAPPING
 	 * to check which VMID the current process is mapped to.
 	 */
 
-	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
-		for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
-			status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
-					(dev->adev, vmid, &queried_pasid);
+	for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
+		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
+				(dev->adev, vmid, &queried_pasid);
 
-			if (status && queried_pasid == p->pasid) {
-				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
-						vmid, p->pasid);
-				break;
-			}
+		if (status && queried_pasid == p->pasid) {
+			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
+					vmid, p->pasid);
+			break;
 		}
 	}
 
-- 
2.25.1

