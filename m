Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA7BC4167D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AC710E9C4;
	Fri,  3 Nov 2023 13:12:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A0210E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7d/ED+p6R3n4hZqZZf0N3iXYzJo6gdXRkjyxeBgYzaN/8yQUyDQDkmfTduezCpMVKN0lywiJCDlmkklGpEO3NBQ9MpUfO7RUzOgHmhj/0Qdwt6uwdZm8Ooq+s2eBf/tfRAoTah5k+P+Hq232k1s3wpiI+AMrj+dRJTofve2AvUew6mwJ5Q9tQjavso9450Q+nwKPVpZ4huxN3lnkw7wCQMl+tQ56fKU+6RxavgTRUMAH8oVtpfBouMRyuG5UTvVeFFx+9WysU08MvLjUub7XmSvF/Bt8wop694Oc+qDDryA52EgUutqlcaeV4VGmYAsVpnJ20Yc7/Ul5CRmDfZ7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SDyqEFTnyJilBaR9aL+FK0LpDH9AK/VmaN0dMtfilE=;
 b=Rr1sv62H2SSJT8wYyKkaKgwFNM0jhGJw0fCqAMgOptxEl2D0Yqgp8nYXPKf8+RkhvGfhR/Ri3p7MRify+aRhBFQtwT/S1JyPJX1i4Kcb79fu4rJ7HdLs7TfwletAIrudlIHgYsMdFRiu2bHoZBBlw3tejs/Jet4V/hrnEi0ISljT6zPorj3Hh9GYCG/MBHG2eafvJSkmWqJUMtWrdmupifBQsY+gha4/8NaX7n6HbbwM6NEBM8b1107SuZQMb0IYHGwfD1f+oF6UyaHbbYwP4hSelzI8NiibJPPoX1w23l+4hMsVWErtkPxxS2XVzsnoc73Z62KrAavJ/sdzKdAv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SDyqEFTnyJilBaR9aL+FK0LpDH9AK/VmaN0dMtfilE=;
 b=yX5E/utWrk6V2bLRXSyW3x7mWVz0wiRc3YU7ivvZ+fFfsakICUMvVO4XmzpxQiEcalFIFqkgZQcCneTFpShyShMRHs167QAbE6kM4xNA86fly0INvWcwouwmauZVZGU6TjFws4S1wQ3lXUULGIaofZ8ApcQ6NXeHgyhStSOPv84=
Received: from DS7PR03CA0119.namprd03.prod.outlook.com (2603:10b6:5:3b7::34)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:01 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::70) by DS7PR03CA0119.outlook.office365.com
 (2603:10b6:5:3b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:00 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:59 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/24] drm/amdkfd: add pc sampling mutex
Date: Fri, 3 Nov 2023 09:11:19 -0400
Message-ID: <20231103131139.766920-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c34c715-1a38-4497-957a-08dbdc6e7761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31lDJw/+PD8w8mbEFwtTNR9NFvwSBQA2NvgsfNU2pe2p0WBd4q/rcHUOPwluwruV24BpxCCpibhAjZfioWQhSt+dBgsx6RBKq8rs88tKA5FUzrfjVTTXOyaydwVoSaZU1j3Djyjhf/bMvlWhNkeWvO5LWEJ8PuO2wKNrwlky/2LZI8Dqq8ijubEhXQNDlq0zdvFTGFuQQUv66OGOsZC8dQzly962DGBiQgWCmKM7295bml+IpkHq45C2E7em0+h5vKk2XI0HszsloihWx4d3uEftRCm8emDYWBPJ2oLk+5IViGi6BTtEEwHoa+1kRnjH++tJa0FLAH7mfLkGJu5EnhiRTqmjJaZtty016Axf/FjsiP+6TErVW8g8zdr16VWkjc8moxsxBrOQ99Ii4ElGZU5IIaKIjHTyQG2VGS1EqkgaLz9iCSjqua3E0aPqgmw7+lMQcMEwJMyqQuYr0JZ8wdjhV72Pw76KeeHNjmWybOsL6UfhfD/DSgWF8dbBJDvafTnYxsH+4soJm7vk6NXs5SiWiQWHkIJsMif3MuOywggh40dUeMUeuj4scEAdRl9vu1dBapDmzxjhp8YaBJ/lZ86RKUwDaQivI5+cnVPZS89dTnWRivN7I7IoBtTRdCVdLJEZ8sWTtHoTzoerbaNy42MA1w70II+Crk3zsxq2LVAkjckqD/DqcX4bqEiV8g03EHFyyHRDAmiRjFFObBfz+B4+TKcu346RLAuOn6PxG6arbOtE9sErmGSN0RrW6/ZpjlpJ8WKKFOFLws8CAKyQvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(5660300002)(40480700001)(40460700003)(7696005)(36756003)(16526019)(26005)(86362001)(426003)(336012)(2616005)(1076003)(6666004)(36860700001)(82740400003)(83380400001)(356005)(47076005)(81166007)(478600001)(2906002)(6916009)(54906003)(41300700001)(316002)(70586007)(70206006)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:00.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c34c715-1a38-4497-957a-08dbdc6e7761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add pc sampling mutex per node, and do init/destroy in node init.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0a9cf9dfc224..0e24e011f66b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -533,6 +533,16 @@ static void kfd_smi_init(struct kfd_node *dev)
 	spin_lock_init(&dev->smi_lock);
 }
 
+static void kfd_pc_sampling_init(struct kfd_node *dev)
+{
+	mutex_init(&dev->pcs_data.mutex);
+}
+
+static void kfd_pc_sampling_exit(struct kfd_node *dev)
+{
+	mutex_destroy(&dev->pcs_data.mutex);
+}
+
 static int kfd_init_node(struct kfd_node *node)
 {
 	int err = -1;
@@ -563,6 +573,7 @@ static int kfd_init_node(struct kfd_node *node)
 	}
 
 	kfd_smi_init(node);
+	kfd_pc_sampling_init(node);
 
 	return 0;
 
@@ -593,6 +604,7 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 		kfd_topology_remove_device(knode);
 		if (knode->gws)
 			amdgpu_amdkfd_free_gws(knode->adev, knode->gws);
+		kfd_pc_sampling_exit(knode);
 		kfree(knode);
 		kfd->nodes[i] = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9cc32f577e38..4a0b66189c67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -256,6 +256,11 @@ struct kfd_vmid_info {
 
 struct kfd_dev;
 
+/* Per device PC Sampling data */
+struct kfd_dev_pc_sampling {
+	struct mutex mutex;
+};
+
 struct kfd_node {
 	unsigned int node_id;
 	struct amdgpu_device *adev;     /* Duplicated here along with keeping
@@ -309,6 +314,8 @@ struct kfd_node {
 	struct kfd_local_mem_info local_mem_info;
 
 	struct kfd_dev *kfd;
+
+	struct kfd_dev_pc_sampling pcs_data;
 };
 
 struct kfd_dev {
-- 
2.25.1

