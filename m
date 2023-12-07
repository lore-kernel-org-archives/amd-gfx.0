Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63812C10F04
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C91C10E99C;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9CE10E151
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARngCOijWf90pP3vZM8OjitkAcURplwWjsORGK40fDO/VIkhoyKxoJ3QeCzjsQle3dr7QdhoztK51A1INIAdvpQFzTbh5f3tIyw2b5UMiWBnWGSlPqee9HXZm8ECZb7aSOQiW4RxQqyH9Gtx9lp1P6/rzT1lMtayFnp/VZv5zasGCgm8kdqY3mw/GFjNLtMvL5nGQGykbS2IOmIr7wweRKFVQqXTNxYNH25MPaYOGdwy/p9pOXlPp6EU0QgUzVDgGy97Wl6m6ut2fTvJWBDM5fKUpN97j8T9PeFqkQyEphNwBms27NbfsDx+5K8A9Wll0r7wALGNnyiI0RrBhGKblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfJJtxlaWx78I3m2maJ589MApU12YuPe74DKm35qw50=;
 b=FyU5NCSGd7tGM7iG0Qw0Kt9KO3FYA3Gg1GeRQ6Z9VeBrQ/1HKpvebW0XDuVe4yctAoJoeT03+EDMiuIHS7/u6He5Zx7TIG3Q0SiE5k7rkbZyLf3hwrLLvS7Pl5FuGNgxkP1arZIEjd1NlmeZcwj/KmkI+8iIxfUslM+1G0Pe5KCpcZXcQuMSKL7fOXjqGOYYT82rx0bho2oXwpOIxNrnk8dmnGDZEL40F3Dq6Li1bZ8mmEzLuj3KFEBydmeTLKsy22adke7o/iG4yo5km7dHYLfS6ic41hOjrVUJTnz8gkkDWWKlJqJazAbd9m6b6aIYqHlU8zvKT7ZIOfwamzCNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfJJtxlaWx78I3m2maJ589MApU12YuPe74DKm35qw50=;
 b=xy18g3kqKtUn2NxaKndbIUyi8fwgyQub/c7V81KE8DzurWMfBSaOBOl49HtBou98/xvEZtgjAq+5nadYol5oi2mQz3u2n0U/agqztqpVLGGJ66cL9eyx01jURdBuDCTEBJ4DUjqxKu8/rhx9wWQT902O4rOx6udGRY0RFykIFwk=
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:46 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::e4) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:44 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 17/23] drm/amdkfd: add setting trap pc sampling flag
Date: Thu, 7 Dec 2023 17:54:16 -0500
Message-ID: <20231207225422.4057292-18-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH0PR12MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: a62a3f8c-c006-4cee-bdd8-08dbf777825b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c21oQ5mAtRJnr2Vc88z6KdEEtwUyOiC/Tm05uUSYp8+FEoXBxieqacvtGLE0yVkATQ7sOMtPWyclifTqdQ7TU18ajGylbjg171hD6NZzg4xMJjqJSs3/4IzPlyDHgYLlv48zLRkqAdwDHfSsZDqalNVBWdsGam1p2VAD5yaSDPwYkyCQ8feO4KmtxT+gJvw6pNvnWQNVSB47vpinM51zb+yO7yIBcDH6Pa9RBlSdz9PAA3B01s1Tek/IMJfQn1C4zOAjqEzMGaDiJ8DTBG0otxg8aJygPZ7lX/92Ch3B6iv91jsqH6r2MXmXK7/YLyVNNfaf5zGmJ2MFUs2UsOChNwPq2dbhpt6kogCSd5Yo9MAu4zRRPHSRD34VakhQh759DGdDFa6C4iMJZ2Cbaxw64ali2+8kfQL1H2SlCXs7qUNYzo2MBPdRGhWYsm+1tuNpf/ngNA+2QxfbwfQyXz1nHnhj/+dUKaFEM7Zqo3rx76+DXWfUGhkU4CgqF3IRFySrVR6r8pJnvARf1QRcXDoVISw/B9U7N3Q065fYLROWViQJ/IhRW1JMhfBTW5JUHQcpEww3fnignEdJfrVAItfDp84hs/yg9L5BGatMvnTXGcg2tAmF7Pd6LRVpTDVz3szu5Q0Bk+7aY2BHZvzpFDBn+lW1YYkkzujPeRljnwB9YO1y5HguA1olkdZ0kCUXAzYzm1XbEv1OHMTd6+pLfJJD70rrTx2hP1TC13TL8qKIy3Up4ec6tRYK2bUlwJyAZUjL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(336012)(478600001)(426003)(16526019)(2616005)(2906002)(36860700001)(26005)(47076005)(1076003)(6666004)(7696005)(356005)(4326008)(8676002)(82740400003)(86362001)(8936002)(5660300002)(54906003)(41300700001)(36756003)(6916009)(316002)(81166007)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:46.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62a3f8c-c006-4cee-bdd8-08dbf777825b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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

Add setting trap pc sampling flag.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7ca7cc726246..b9a36891d099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1198,6 +1198,8 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tma_addr);
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1a31b556a5ff..6bc9dcfad484 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1460,6 +1460,19 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 	}
 }
 
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled)
+{
+	if (qpd->cwsr_kaddr) {
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(method, &tma[2]);
+		else
+			clear_bit(method, &tma[2]);
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.25.1

