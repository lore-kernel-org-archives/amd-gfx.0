Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEEBFD2D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D16210E6D2;
	Tue, 10 Mar 2026 13:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3KgANuCD";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B65C10E6C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOmbtuozqhBYGVS3CqOAeCy9A8d8JOkkOH/+GQ1lsKYaYZlCpKjwENWv7ew2Ef2mJb2MguVJiio0U59+EguHrY7zpxJfnu1+H0idRPCBdbMxdp4+3es4vzPwGG8cCPhi4rLG0P3cBZSw4LeUyqrFjH+ajAgxZ0Ely7eD+XLgX9xuBNreu4qcOsKKXTmLE5ywbCXGBa68pDi8QHNQnVCkTvN/J5DcIyDsWWC4KsLhdGdmgMOZWMTrULXNdJk+Tx9s9jN8HJUNuDJTOa+onDIwh3sZW66pr8qk7AaeSH9TNTI74Qxshv7DrzG4uVBZqBAuiwBg3yEr0bffkWSSKxOUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnJNl3SstGaZ1C7jC7TpM1Fro88CR85tT86zqQc8LDs=;
 b=krev1CSqQ2x/O5iM2PJsVLBmEJmT3i4CDY0NtpenW/GheUqWIviC2/DlsFpQkhTJZlOogVQfyNe8lDJTqUnFWLybUncljnCDO23y0rq1QGIcoeNtgUdIcR7vVPlpclAawCTm3ykUPrRYyf9b104aczcAfvoBCPqHLPfZbKh9JFmj6dSQJ2lbKRHqCKEo4BG457gukJuWXF4QQRAl6lm/rSju9ttV/yHyq+UtO6IuUqdUVwdhD2teaxxiAMc5meUw5OkZMAncuzciEWyMtAinXOvUfweqM4SwJDgEMMnDp/SNIcZ4Wj7R5wMo3i2ztYmfrQ/EFJFnLADDUm/D4djQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnJNl3SstGaZ1C7jC7TpM1Fro88CR85tT86zqQc8LDs=;
 b=3KgANuCDYXy0Qo9fXlfzvJPv9e0ZZ2/vZUl98LDKGry03E+1KOjnleJdm+wFJJC8xEu2NMBa4pAOk1Cm4az2t9gGDUUhGA6aJfdK0H8UbvzFl8KRkFaLk/eiGKNMHllXKu8F2duP86R3/BvjGBlXE0sEOJjSaKMpv0u2XLOy1SA=
Received: from CH2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:20::21)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:23:45 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::ee) by CH2PR07CA0008.outlook.office365.com
 (2603:10b6:610:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Tue, 10 Mar 2026 13:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:23:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:23:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:23:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:23:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Add mutex lock for metrics table
Date: Tue, 10 Mar 2026 09:23:31 -0400
Message-ID: <20260310132331.2867603-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132331.2867603-1-alexander.deucher@amd.com>
References: <20260310132331.2867603-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: bd53ba00-cdf4-4fd3-5522-08de7ea84163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099002; 
X-Microsoft-Antispam-Message-Info: hTFula7EVLoSOAkQXNKhpSDpgwhhjRDBVTaA+bOp5f6zNyAb7ZrsmNmrhAQR6Lp7Kv9IcTsdA70wdw0ZJeXg0aRrEzme6UBT8sR0Db/wTBBYIxL0vo8wu8Sy0Z19eh8CnYi3FDpPalTWJGX1EHWz6Hgu4AdzK2wdBm43/jh13bELEQOcCXvmNUm/AScmXnK2bU0z4KuRyCMSzzTlHTIfii3zhRCB94wkFpEEmQU45JlHMqD2I+BK1YON414j7pxAUiVbGH02fAYw95ntPjJINW6ASff+6j6pSo4QPOz7zfzyc3089XKlaQwRABqcE6K/RcsktKl/SjkK40CnPeEhtGqVRwAZqgYu43JswULXwHC6nd1bHTJJPKhjQJQMCb0fohCpNMynpxX93Ew0Acy7ZYY2hICRIdWFog+SVIH3a/R41ItR6C7HH7xjVjUA7YkL15UB/LZmrgeeZj8x/FL/xpgseKhh6CdKUPjyVqLsJimO6llm8KXPTBt72fF+nEofTcGdZqoZFgT5ULfWnoqqT4tPVtxj2yp+5LocJ4PiQIeO29HXJ+TBVDdLKWpE4nBeBPTdFZ6sQe3X8Txrq1YcwMgvpVofyllETRRPi8wAHzV8lN5fuBOEHkStLH3GkOHvXdrOMYh8q/9akYDv5EHMnrEChIOfxDzQxs8+iI8LBAFM058LHWdRui/oTBnZEpHr8Z/PiLYL2xFhcAQxqk/fFQk3coCOghjkw7XTF8oXLFWyawrA6zg//aWsORtttZqQ0njNaBBbt/ovES01VzQR7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q2bbvj22txLWwZb6EbbJHYZ/ypRKz+gS7j3JEYECffOAaqUizUflkKR05d5ZY0ahY2EaeX0O7tftaX68gxfwZfhTp34wQ15ahydwMBauAuBqYkc0fqW1qiQkLdB2cIeDkW7+IUhjUIUCP/b9I3vAgk8aWzSzY4bEjUpjWtgKEDON6AdgXNoGYWhTn1zu8GeOPoi72zCwi036BgW9W6Yxx6au9jbSGZ+jvFlRAKf0VygPKTm2TQykSSCPlhuVBO0o0qDpKW39rlWKBhpeepfKjDMGFrtKRc/aQowteSHGF7x8cVtqBKHlD5jEhznFSfYtx4aNw9jHQEkNuTkTjk1TDtjPeTdGdAzpEB0GHlj7a3u+Z64mpPa7Jq5zcDi9G15K8W90Z7r4qqEQso2CS2+BK9HIjTFGbG0rSJyVNVbODZ2zSEOfg/T/IciCGwux+cAP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:23:44.9548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd53ba00-cdf4-4fd3-5522-08de7ea84163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

From: Asad Kamal <asad.kamal@amd.com>

Add metrics table mutex lock in smu table context struct

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 90346e70a614b..609f5ab07d8a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -389,6 +389,7 @@ struct smu_table_context {
 	void				*metrics_table;
 	void				*clocks_table;
 	void				*watermarks_table;
+	struct mutex			metrics_lock;
 
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
-- 
2.53.0

