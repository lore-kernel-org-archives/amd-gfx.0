Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75DBCD343F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5242410E5BE;
	Mon, 18 May 2026 06:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+SaoeuP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90E910E5BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD86fEJrr8aCbSyoXcnAsBlXpUDY2hX/EJIRJIUlZGfnetSMcBM3LS0sl/Yq3q6uWlAiNLdqwqu5iHuMb7BNha0/r7eKP9PAu2SgnZAuD8/XLrdVvKySqYnxaBKKr08CnRzphNWXURO4w0gQiNv00ex2jTGqWp4xusqZVkZqk1J7zFFiK0mqcJX0B1T5P2NZwCn6pQ3Jr6cYajtbywJByK2nboX3Uz1R8gMQ+gZ+nGAnCYT/IQx8jy6XybW55pqcznRAEDEErDL+rSgGzK7R6yv4aUZGdq1qNBRAFbKGANX9LZfRkpTH0iIVpl3pjmbw3us81CqjUgJkLIS09CANcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wihxQ7w+3fBoAvhkCLdcyA/B32Ccabu3rJf6aZw55qc=;
 b=nPmdmt5KiHWK4tYmGrYRgOzXqnXdIriPJ79EKzA08NGmnHTIDrIHic1X+o4XM/KoJcagIknmiWvrHjUdKL1pqgiSn2rD4pfvNULP2Yt5degNj9ARvzXgVOG71s8p0QyVGWmmOkY+V8t4Z7knugHtVSu0FeflwHoLdQJJoVHvhO8DcgO4Bdqgof+7yj7w2K0CZA1bidkS1QwHf9iEZsfAlE7ovgd9faNhIrirJHyGdtaDBJsCqvVOVmPr33qHffpvdtAGIjaSrLSIRMxwXQJuz5v0i7RBrQvo5aDlSMsLKH20OfETIB5OJP87oIQm1F9Vb7FfGGkRBckK3RwHdexBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wihxQ7w+3fBoAvhkCLdcyA/B32Ccabu3rJf6aZw55qc=;
 b=u+SaoeuPZoprM3pcCXYoNxGrFQ1UYwORONcCYkboUiPONM4ao7vkeRKmFP5WTong4PZHAyW456IAgz36koJ4iRngAeHtSgBOPXig2NNm5Oupq/HYtffk3GQXp0/eERiJXyA6cQxRwhbfHNY1bbtFUZfIE1jC8Xi3u8kCQYKjwtg=
Received: from SN7PR04CA0090.namprd04.prod.outlook.com (2603:10b6:806:121::35)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 06:41:39 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::95) by SN7PR04CA0090.outlook.office365.com
 (2603:10b6:806:121::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:41:38 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 18 May 2026 01:41:35 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: add first record offset check
Date: Mon, 18 May 2026 14:40:52 +0800
Message-ID: <20260518064053.2778626-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518064053.2778626-1-ganglxie@amd.com>
References: <20260518064053.2778626-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bce31a6-abd2-4424-9426-08deb4a88351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mRDSxfZpPJh8vhrCyewneJfmLJ4WVsg69BfM54wqie7TYken4JEIw7d3EQVh4fVbxR4glp1NEwvpu9UEUZ9y8MG1Eqxf7nWKJtVNgYvZmuvaNSHkswia67nTE553xJ8MIQP2pXTIzLa7mo/Pco8OC/fAi/dOASX8k78FjIlqcl4ayZjwbmkO5oIhGxikRtWJC+iHdG6pDKlCPA9A0YqpofmNHMi7nYjkgE8zMhcraJhB6Vxq/7AxGr9nNw3XF4cplthEekhVuofZkszsWYVQ1J7qdNUptUNJoXu/eH9xZChp0yjHyf+l2yzAJOkrwCGNVre7L9V2PCBQrqrm4Ay/mnZwVFCOamDlblRrq+qBldOWYtEzIZ+8KAsDaNoncUtVoNKKcRo+8KVMCIE5bVrKmCOoSWWCUEmwcQg72R6g9Gi0EmYLtC83bB46qJtA3pGzGGa2BUfx0uzsEuCEXZP76xld+VfyJfDT5tSEgwdG6igomZJriGDBXdc+halD0VbRMj+6r2TkLfpTJJxb8flp6J8oCpEOYpoxNigJewzhkGuQA8wjm6184Y5nZjThEdyU0HE5MBUrAIVjstu5wHbPc+/c2Uk76Vs8Rfvg0SJhm25ByawcEKZJ+g61Eds4kacmJNY1R+PetPZf+1gE/Z48rRUu3bh6WJ2ckNkt3oNJGLkEBY5Syrb0UjSImpHEwdnkdwkCnKqQA+MeiDOjayERtugOulbM+kjEZ5BK+/cJ+pU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lN7KjiQ7EOBIOH5cMhqQb78mnyZZF20rGpd0BTiRSn9nfcnWl9Xfo3UisjYaM9xXpGxbP69HjpT6S2cyj93UxAlYN0eHDKcXcOnfrxWFwLEn68dGudXAa7ctNeiXekV741hMm0lvE0DfykehfDDD0G0nTugfkW3Js3nS+DoNJGGCIJGKtJMLYzUMcqjN168AyHeRIXlrGd4zDr06VLAABN0XFO6EVqFegw8me1wUer4PLCHFpqBOc/EgGEIabccEVskuPBhZI6e/j0dIHOtQNcatwh/v59EcbiPyRzQ+Auk62231B5FKyZfePGTiNvUg9XmxhdkzgaIsrTDjybvVJV9b8LTjtFEEij2Dhuj0wu7hyRjQXfZrvr897sPbO5ni+I/yUzzxLSQdbLqKIhHoO+clgyUxb2zXl+Qdi3Vqn1WtkkXGPNGDE9G7ePqaLoL+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:41:38.3289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bce31a6-abd2-4424-9426-08deb4a88351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

check the upper and lower limits of first record offset

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
index 65c1812a10fb..34b798f45af2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
@@ -1163,6 +1163,13 @@ static int __check_ras_table_status(struct ras_core_context *ras_core)
 	}
 
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
+	if (hdr->first_rec_offset < control->ras_record_offset ||
+	    control->ras_fri >= control->ras_max_record_count) {
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS header invalid, ras_fri: %u, first_rec_offset:0x%x",
+			control->ras_fri, hdr->first_rec_offset);
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.34.1

