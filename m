Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80602C77B7E
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Apr 2023 02:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409FE10E1C6;
	Sun, 30 Apr 2023 02:03:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0EC10E1C6
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Apr 2023 02:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dccWjJK2IxQNP/4yQPpgPtRaahcpBDeVQdDhU1krVZOHAWKBBOCGL76I+SWT/EBYwdzv/T9UNaK9Q6J8tahS7qeEh0qBwKOgJMdpbA9j2dnHm9fDXqma2KJscRjtuY2qiT/xhOzIUMiYl92pjcIc20Wm7qAltCRforkuAY5dxbSrvVg1MWHkmavOWC25YfbU2C8oCvvKwpS21gLjatxPRrkB6LQPQF4YO4IllpnCIyWBiZC/l+8Am80SUgmfFN+pQAyPLOVn/jltfTGv3Sns7Wffi0548TO1DcVFzxN3rliSbwPFbZl3qbwcLFLe0/rH5epuAunj32wmKmhEFqBRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqSeSvRFqiKYNBxNqkV9tioNiRhR+hFFhyw0rJqnBkE=;
 b=m6p7bZ0/ec5RbRqAWcf/uRClh62his0UZnzF4233mCLoa4ad43pVv3wlihjw/+PYXo0kutzT+3nvWb5jjVDtuvXuQRwv/W2YO3i+zCFTy/WAD4VAzXGYJMeuAshllpD7dUzNKHS6exz0civln/52TSvPvF88h4T+ZGVzI7OQ0u6MtcmA+em2Rgt3PgG7p7/ca1D+6Gr0VhSGHbxHRldYT0JMvLTs9BHjbfw4MVvLoGhvOGlBOWZqnVOBJ5p0igHvIb3omPWcMlggfewgnbDBevsST3gboCmJPpyHyXsPEFiQvwTBIIPy7oJj+3o/1ceWx0eX38rP8C792dhmVOIk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqSeSvRFqiKYNBxNqkV9tioNiRhR+hFFhyw0rJqnBkE=;
 b=bYh7+jKTmr+V3j7qmMIgFmsMqClePDIeCKUDnrBD5Yb0iyCp6Vte/tueWWP0rtiTkfHiya/CV6pAfhrGN+FV8hpiT9hpmJuxWLgSPKYZvRNgtsSh0kIG4O8ZXsvJ9Jf+VEuMkZdT/o7B2721r678y4t0KomnkHL7I15Io1sUrYQ=
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sun, 30 Apr
 2023 02:02:57 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::1) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28 via Frontend
 Transport; Sun, 30 Apr 2023 02:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Sun, 30 Apr 2023 02:02:56 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 29 Apr
 2023 21:02:54 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set gfx9 onwards APU atomics support to be true
Date: Sun, 30 Apr 2023 10:02:20 +0800
Message-ID: <20230430020220.1266699-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ce98c7-fb78-440b-fc99-08db491f0417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHzyP2OM28ChwjzSSkVlmodX4nItmD0uvWS/JOIEfUEOSp00sS9D6T3jKdrS+AykdU9EJZlnnliKsocdE3BUECrFZiw8gFBpzFtozhfSWq2NBJWGPtPkwsh6jojJP7mTHAcnSXC4k273HzmEW3F++0rKA/FC9EV+nCeSGCEOaALXTsuJzYTnRdY6P7vmH0+bjvVdHZ0ee92vk+YQ+0oPHRAH1fphvhjNqObsCtSTJ8ZEB1OyDDeN1Z9ZGQw8HFL7TiYrfYY2YVFQclrJpkpfHeatMJQgjENUfVl2qMaCl/LBympOSZdmmjXiuNqOuG3lUuiugHkeK9US1szasKFMOMRn+HJ8dM90D9jYoqdEc/8ijf8azum7sV0ONkZ4MUjWujb6TYrxMtPCJ0Odj8Ar8MTQR+ekUwaAirruQk1kTHtz4YRYauNFU5ro0BZxqUJym4Jfv6C02ehJ2JK9McTLPi1PLxTuUlNaONfTLj5AMSG29vEJIjKVB9ofRIyy56kHcGSK4UnpX1ax+gn45M7l7abqyMoAnQv9RnR6f8IQNuJ4wA4JdByKzXuKEmir39lyx8py5hdB7d7yQ4NvglZMEvyc47XJrJdUvYRKOESHH38V+CHCKngxZYKImf/MIia0hq3fla9Up0zOHaBFQLk0W90x95UIsXgMJMqsAfXURLOBS4Beos1ETuERrdqt9hoIu+quTAXcwfYbR0sM+fl6uR//Z9zeLCSDCvaviBAyhiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(36756003)(5660300002)(2906002)(8676002)(8936002)(86362001)(316002)(40480700001)(70586007)(70206006)(81166007)(82310400005)(41300700001)(4326008)(6916009)(82740400003)(356005)(426003)(336012)(47076005)(16526019)(186003)(1076003)(54906003)(26005)(478600001)(7696005)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 02:02:56.3614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ce98c7-fb78-440b-fc99-08db491f0417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather
it is internal path w/ native atomic support. Set have_atomics_support
to true.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b57e7776055b..750eaffa81ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3757,6 +3757,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
 			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
+	 * internal path natively support atomics, set have_atomics_support to true.
+	 */
+	else if ((adev->flags & AMD_IS_APU) &&
+		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
+		adev->have_atomics_support = true;
 	else
 		adev->have_atomics_support =
 			!pci_enable_atomic_ops_to_root(adev->pdev,
-- 
2.37.3

