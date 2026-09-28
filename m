Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A59C9833E
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 06:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C1B10E794;
	Mon, 28 Sep 2026 06:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIDHo56c";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BA010E794
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 06:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxbFZSLmYC8EJAA8gkY6AEJAIeiAtqcjsHfse+EJtlXZ25wP8kaNoG47AoerZC/wb15jFP9rZt2yVgaSgog5geO49a2bjO5Y4XHnxKyPiHkp4c260PyzpcFqMWQWqvdQ4ge4qmojlg/g4fXrH/gQBQ7HkMire5nCFAkSjEnha2h8oYWQSUuB0g4Wk5C5T3APRx75FswDclNau4KVTk4jn4QsQEyG4uWwfizeBz07LpmSlvudF6Z7Wq3viKGP3+cSgPfRu0wuHlwJY55XK+20FN9PH3at54dBM2mmcPTTHZXDB3vBq+bYxh3P2MAwnk7EMAujTC94eg/n2JLCWcgZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiOKGQrBK5b+z1tpouEl5IUfI/b6b1dHsnEOlSd8V00=;
 b=P6eGg5X8SD5WlZOKR0JSGFqP+ukMEkg5y2BwR3D9Dw6Zufq/b0HPZTwtxUca6Zjzyy2Eew7ow+BmAupUEoxsI8ZfB0fuuM+v+WZhssOUMwRtyplafWUoLEoRv1TFJXeKUR0bHnJB7ikrKdEIjLhjpSsu6o5MkvgBNV/Rni66JHyDMO1erg8qoPk6qKp/0e5GARWujVHA58t5XrtwET8YCtaB50b/PjbuFwdUj9aCMkFDLn5ZBd/F8OLAwku17w8r5hTZxTrZaPgOttM4ZJmC5oZ77HRq0pvO7J3Zh15rCREjMmkDgKJEGjctwEPgoswPMktwHyHoIoDd6J/rsPiaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiOKGQrBK5b+z1tpouEl5IUfI/b6b1dHsnEOlSd8V00=;
 b=EIDHo56cD/FTQ1CJChi+BHSQvcvSfiQy94vI1EX0DWO9OzH93PkvXtXv5jgQP50P8IHo4MXWYJe5hZ625F5VR3qg54D5iKr54OsMSMURZTC5EJh7fLnMWPmGPOPckv8FmJph7TN8Q/wX79rb/71n6h6bat/DFzgtBGkVy2ml0fA=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:11:56 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::59) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 06:11:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 06:11:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 01:11:51 -0500
Received: from chhong-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Mon, 28 Sep 2026 01:11:50 -0500
From: Chi Hong <Chi.Hong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Chi Hong <Chi.Hong@amd.com>
Subject: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for SR-IOV
 VFs
Date: Mon, 28 Sep 2026 14:11:44 +0800
Message-ID: <20260928061148.117428-1-Chi.Hong@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9655e3b6-3b60-475d-8f7b-08df1d276595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|5023799004|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Doo1o89eQYG90ynpiMwhamlSmek/JqScOQjnsm1LhqyhIc3O/DVRKlTpAB3tGCpjLcXp0wYEyEKrlLPQUFS3gLD1LRZJoqV0RZNKnX91kiCiTrxx+6fN1rYWGuL4BaZRBgAQHeCwDIUc1ZvAX9it2l5BfYkN01eLoicWPxI2kzr7AZ5T5pobWYa6DS9idBXkHXvBPq30dYkEmRn9YgUO7Ye8/08mORvStEKCivp3YP2F9IETsWca0UxwTF9lQH6xouhBrAM4U0+lBwixP6ZSr51Kf5F2nQSGBdKb5fTtwYuTJDJjH6caTBCwI9VKbEBdzkkEkQQQSwzL6SW7feNk6dnoZblR1F+G4UTmjGdvxLYShm6C9mm/CA5jpHiYI6hBkREv4n1hD7mRe384Z6OirrBlgUqQE8Un+K78nbl74YzqVbtmX28wH442ELl7OAQsxuHROmsZXbrvwbI/lWx+pO+DbVqZhuELu+htoIIsURCPPXm1oWN1viRe9+07DcnAz6otURzqa3RT2SDX60u05veCGGBQfnQtbxJ1fzzUmpQSQu7wwWLGhiOJJBPtftyDF1MkxO9XVV0PDSh3ypnrFF9dLR1CgEn2kSOyCmvcJA1m4qlZ3KIb0SdmVDaDtAbxWa1U5aO1Rfso+80gAuNk4NsO9Pa8celoQZyv3Ibp07UOJFgxxbgiEwzWcsFIp/nROydTgcBczc5AvIEPc7ySTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kY+bxMobZhAxjTQM6cSO9sI0qldA5XGjm4TvirnjnwsE2w7YeZbPFTf2iFz8fb14I5W0A0P9umQCiKk2qpnznUCKZ2PEWJbE/lJsEEJmerXs4wNyq9ignaiz6WIdIAfpfqh4awHgbHkfNFoMgF4rvhVLRTZWGnV4Uh5yW6o7SRVHbivOXAzoCmApEhRfBr1YScpm/hgxFkSz1qf9Lztv5ikJGXk3yl7ifi/U6D1pIZH9Tv6ms1nmo/ajGmVIBNNGn4JYO2n/XfAtatQrs4+O5hbLr1heAX5l/OZixt3nX58NdL1soNo/mXj5ZWHe6sOMNuCjsFqq5eLy3PjK2/6qGZUDopx4XbO9vvfbFArj/lUTPlCEAz0klrjUJdSfyj3n2Cr2fFjnmMZd/yga7mMvgWv2BPak44K5qDCBTxqbspljIGUbZCKhMQ/krXAySb2w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:11:55.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9655e3b6-3b60-475d-8f7b-08df1d276595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

SR-IOV VFs use amdgpu_virt_ras_hw_init() which skips ras_core_hw_init(),
leaving fw_gpu_mem unallocated. ras_psp_reload_firmwares() then hits the
NULL buffer and returns -ENOMEM (-12) for every VF on resume, aborting
ip_resume_phase2 before amdgpu_fence_driver_hw_init() runs. The next
hibernate double-puts IRQ refcounts causing a WARN storm.

Skip the reload for VFs — there is nothing local to reload. The
post-reset path (amdgpu_ras_mgr_resume_after_reset) is unaffected.

Fixes: 5e5be56a5b76 ("drm/amdgpu/ras: reload RAS TA from ras mgr resume")
Signed-off-by: Chi Hong <Chi.Hong@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..5bac792554f5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -529,6 +529,9 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr->ras_is_ready)
 		return 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
 	if (ret)
 		RAS_DEV_ERR(adev,
-- 
2.43.0

