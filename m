Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17312C001B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FA710E9D9;
	Fri,  3 Nov 2023 13:12:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797CC10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwcJO4iMl8oc6N2CqBQ5/nQ6rSBsIMs1Hy5YU9yI3uK/X2gQfjdMkV+xssb19TsLhau2ib+f8JPUConr7Mxnt0utNf859IR0V+gl0Hw2oDwoNUXmw8ZdhZReaZZKqs1ntk/0HK0LJEWdJumMMicSfgQw0Oot877sr8gEEjnasKiaSI0U74N4JWNLs8Qyk7IT1CT+eAygkQh6rq2fLyQV9aSlifTyVl5Y9fPzQEBPuxL1aF1BmrA1fCODALbpk9G83+TpiyjnrYAX6mx/2ZA5zUSi2LXm4e7ch4hjxlsGosDjZKC3Q4jExBaKM+Hy4Tnd8MjqHlEtoMSp14XfNY3ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTyJwm7UsH3GoDCRvgCXGg4B3kiltnBFkczyC4BboeY=;
 b=BX5scMgyS3vVRWelHxkVY+kZJELrg+WGxPaneAmlP5MGsvzDYoa5S8/A1yFcHSFhVy+V9YKh7v5BjNZih06OPBQ3TQkxsV5hzeyk0aMDxHFVqg8lRY47aEzmS5DohIG5tj+Ihuft03H4GbH/Z93iygciDSQp5KmFBZ0R3qfh0lBQ2RhUSMtl/Fx66BzCJcxzYQ7m2eziE9UXOA+TwnhB1dkw3SCYNWGa9KrrvciKpyPGE+DfbT7b6ToR0JkFLSN/oZnwb8D6003c415OkEH54xzJdYmiygO4TrUxB0yuvj0XxZk57n5OPJWRQFSS+uXQE8OfNC3eoFvCSjRrvWs8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTyJwm7UsH3GoDCRvgCXGg4B3kiltnBFkczyC4BboeY=;
 b=TBy7UP7B9xuWORVznhYvLA+AWeYKEEJaJXE615JKXt/z1dlC4sEr6A3ZqxgvP1V+zXNnJqZIzU9YkrqSft8Y/Nm8mGjA7x+3UAJMOQCkHq+nDRCtNFcGNJvvI8uJaX5EZ3gtgEl5biWfy6UTNVBghWWQVqbULqBu0sGpSvj9TCg=
Received: from DS7PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:3b7::15)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 13:12:09 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::6a) by DS7PR03CA0100.outlook.office365.com
 (2603:10b6:5:3b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:09 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:07 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/24] drm/amdkfd: enable pc sampling start
Date: Fri, 3 Nov 2023 09:11:33 -0400
Message-ID: <20231103131139.766920-19-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: a20e9d98-e7e2-46e0-1b2c-08dbdc6e7c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9grQUSNEUjjKi9bRPj6Yoq/rZ1KDjzisrdjGKLFob45QUPdoo8p+3Q9tZH7QaYm+doBcl1glcZLuvy+eVYESSDbZHZFv92BKva8w62avAMSV+bf7I/JawvuHALwccfpOtp4m9G4eD0y5Ab/7Ww23so4+rhiATEuQjft+eoQC0x5NfP6m+fj6P3NS4/fpng+6zU+QneEe3ncR5OqBaSeG4yke/Nuo2FcN+wSXcnvpCw1NkikpClu2UGO/Jhotd8+eaIUQZxYrJY+Q1qJlfVyW73lnyB5EhU1CCqEDSs63E1VWfMWkhLbZp2lM5Bt3DdXFXC6RX4zMJfiypGousRi8xK3iGOan5VZ5iOKqOdjzqf9on4QfcXLus/i5W8o1j0/zzKFerRj7L2WAmGhFZQCXlrp7Gflkp7ZVtuOzDis2bogeNYg0d09u6VHD3tYmStV14p+YMOPBtmqfEAaAdEVkftH5ZMBzRyUck/rAVyizfW4mE4roHFbAoVj5uXBFi2syBRWcK47pGNu5rQK6SgWRiA9AS615OycKtAZaI4AWfXlY/M+wp1K0GGh7S5Htols48GJqw57dbSXQrpyBLf7ZOmdmcRhwh/w5LoXqCMuu5zFhxZo4VDYmRj/PvEmNwTiqIsqsccmclgHduZq1vva5s+WIFalN4R8OEDwHR1ko3IC7GdgUb1ZCQrUe1l8rMVkpRF9FV09F7vUha0Qmu0fTocTZm7jsSwr9NmSDE5LrH8nRdEvXzuREpxSNjiad9YItsUR2LvvhlBPbzfBu3Wxowg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(40480700001)(336012)(1076003)(16526019)(2616005)(40460700003)(426003)(81166007)(356005)(82740400003)(86362001)(36756003)(83380400001)(2906002)(5660300002)(478600001)(6666004)(36860700001)(47076005)(7696005)(4326008)(8936002)(54906003)(70586007)(70206006)(6916009)(26005)(8676002)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:09.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20e9d98-e7e2-46e0-1b2c-08dbdc6e7c9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

Enable pc sampling start.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 60b29b245db5..33d003ca0093 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -83,9 +83,29 @@ static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_start(struct kfd_process_device *pdd)
+static int kfd_pc_sample_start(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_start = false;
+
+	pcs_entry->enabled = true;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
+		pc_sampling_start = true;
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	while (pc_sampling_start) {
+		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
+			usleep_range(1000, 2000);
+		} else {
+			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+			break;
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
@@ -225,7 +245,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_start(pdd);
+			return kfd_pc_sample_start(pdd, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_STOP:
 		if (!pcs_entry->enabled)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6670534f47b8..613910e0d440 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -258,6 +258,8 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	uint32_t active_count;      /* Num of active sessions */
+	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
-- 
2.25.1

