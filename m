Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73258C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B8910F2BE;
	Fri, 21 Aug 2026 09:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRs4hj+e";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611B610F2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgvfAoXg162yfFcjHI5UgAnnxqz45bVMuB7CSt0xtOiT44LPJC56QaQbybj74P3AYcAAEUt6Ya/+H9I5BxY9E7n/5tShHi27IAPnxc/2PYXoezV9A4N3wV/9CS/wMLmzomJfLduGUiYE8TeD3CAcJJ471WhzKfNyjshfm6ufmTNpL451XQ+Inhr2QhIrtXnM8Xi4jd0Fk5vjiul+4A/JASgtDSIPduBXXwjhwczoTD4Q7cRncAvOWQD9gt90cplhPgk75lN2B0fP/BWIPf3j6eZnGRrpFm71+0e+0XfdiauyO52EYITM3D8VRjzy18MQaeiJDBc8Lu0r6xyKgS9t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkJoMMh8fZe9/qeFzI0pJqDfcr5efaO5D/7mePV/DmE=;
 b=zP2spqPc0v2eCcLm+8Xu6kgrneNPIlc9IdVE/r3ngi9wIRzZZAdW6zizclZ5OVEO0Ke0Sea2JI7epFasV/vekpicfuwd9pTnSUexDv39+q7uAeOumwynooKJIUgk5ClzJwwPYJ1WAxTgWsB1kL1RSt29ivcHuzdEMhxJVCgIX+JWJi3cYtCV/CfRrnlg4mI3Tqg8lI6SNXpzg4lyVQUvgB7fpLzzas1/Vunx7qOAK2AiQgCrvUe9d7CE6j4bFdaTliQv9L+m0BVARFsQVV2GW1EYVx8Jy7nY0lO1SVHrJ05A/IkZGzggm2kxtiZfxV4Qnfd8MYUmRhlnE+xNQExUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkJoMMh8fZe9/qeFzI0pJqDfcr5efaO5D/7mePV/DmE=;
 b=oRs4hj+ehC7Dwx4ukbXSlEtsYGHwkNN0JosfQfUk/5HnmJPVSRMcZh+mvc7jZf0dVAnv4sof96zs9YBEuik4AEsD/Oh2rJu4x7n43szdVtL6XD/YWL/9Jrc/OwrpR5FKkkpHW2elkCQxMwc+SOgrq8dSQAyy4QSsi7RAP9oThTA=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 09:54:31 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::5a) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 09:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:30 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: add update_mqd callback for queue MODIFY
Date: Fri, 21 Aug 2026 17:52:11 +0800
Message-ID: <20260821095427.2361126-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 06be351f-32aa-411d-87d3-08deff6a32c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ho5xO44xWoI7GN2k/3B3hMNczWDmsffiDpWsabOReMdSuoEJXpEV03oEbzOjpTPMNUJMlQGYluTjVN4pKxg6yQ7TTFyWuAVtN6Odo8f8jwVus/i1yJm9BqNJEs6PC+Life+Ize0KUcZbzUB3u9rPGDdlMrzczNa72jdoEOnbIcHGPk0v4RrjHW6B4Whl05j6DgBe+IbSb1xRI+aZM7uldeWZfOgR2I3ap+RjpSe/Wq3LxGrglNPIt9IWnhCB3VsSe6KhEQPlKMc322Au2/z4ziiks2EomLZKNHyOtvXZckpWZOSwlTXUSc2S8XeQv3eIDZNGa7QBIoQa5hHTyISUPXHujPUev2sm3cduUtM8zutGkNYi+digXmIot1QhTh5RF5axwexK3w/z9hjqL0mUXA3UiJzXDqy+0phxZTFl3xtgUnd7aj7MfiRIwwVaNEDFkLsKXdPDAF9K2rSMARXXbIwn53Nqh2O8r7OPiWQvDjs9e5h5lAiD8nhT1/zaDfJ5EcQgh/LHGHN2sKPB9XJFRtJgwZEUgheoYAOuSL7hcCWko3InGUuc0zTV/6oL7EhdbEmxOVWt1NmbWX1iEF+BbmZe0p60Xupmoapav9DwsZYjggguZMY2hF2S5brjJp1txgdNJ4rmm2YPSpAW8ccx6YoVYrxx1JBpxTBMAaPFKKPDjGxH+b+W0oIuZWGdf4ZcbBz4wpD6L4Z3bVpNhlqdLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 26+hKr4HVagrJh9L6wGvojNseLCn/7tl77OA/Mvs87XthDGyIcH8SUcwnV7KMSRRT8U+TdXuDelMq7q4CDQhMV9Eb1ZWz228jmN1XO3ibsi+UidHJG+7ypS96ZvktnqoAXxx4vYRuAYOfYvsnbFe3Jbtmub9LycrfVDFCn/w/lwPD+vd7nrshWM+4VFKwpVRYSLmHyPg0Bvm+2D5E0KW9A7vPEhNq/8aGG61TXWrMxoMvFfPxz1VojWCMaiqLrxRFkZX96+UBAD2GaHNPiW1dUcgDSbqQSmH7BJGsLI0azuSzxoyFJeoaP3z9PsswHBnfW4PUqzNdsNeKtnEzhWQ4DD0qKS+ygIdq4ARSqaaF/oQtbBKH3Mkv0LvB494vGh7x675BxYnDTpE9tWEaj5qhhQKqdzThZxGZUORqIGPqe6svAENC7Aja8Iba1tWo44h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:31.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06be351f-32aa-411d-87d3-08deff6a32c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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

A queue MODIFY (e.g. re-enabling a queue after a queue_percentage == 0
disable) must not rebuild the MQD with init_mqd: init_mqd rebuilds the HQD
from power-on defaults and zeroes the ring pointers, discarding the state
firmware context-saved into the MQD on unmap. The re-mapped engine then
comes up idle, drops the packet queued while disabled, and wedges into a
GPU reset.

Add an optional update_mqd hook to struct amdgpu_mqd for IPs to patch the
MQD in place instead - preserving the saved ring/HQD state and forwarding
user_wptr into the MQD write pointer. KFD already handles the same
disable/re-enable sequence by patching the MQD in place rather than
re-initialising it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 63670b41c26c..2f73eceea57d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -500,6 +500,12 @@ struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	/* Patch an MQD in place for a queue MODIFY: keep the ring/HQD state
+	 * firmware context-saved into it (init_mqd instead rebuilds from
+	 * defaults) and forward @user_wptr into the MQD write pointer.
+	 */
+	int (*update_mqd)(struct amdgpu_device *adev, void *mqd,
+			  struct amdgpu_mqd_prop *p, u64 user_wptr);
 };
 
 /*
-- 
2.49.0

