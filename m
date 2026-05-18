Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50594CD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDED110E771;
	Mon, 18 May 2026 09:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3vkZhJX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30A210E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 09:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlBq9QfuLLRSVRD4pRSCGhjIn6RVC9NW/nkrKZG8UK7vbz/EfEuwny83Y5sZj7zS880yRoswIkEFs5AFhN4arCJE8jCC/E/BbIM4cNYSNUN+o1Em3LuRDXlJsOznTsWR2PY0IqN8acuRVvetgtIXVbk5K+cF7XoUpVBEcUkYIo+tvj+60CJXAShnEEDVTyj7iM4P0egOjTGsuUbyw27hERzdbVTYjpEi6koXrEDkBlfS1XHdpYQgGmyVza63JZ/lPCxCGeMT/XC4yBSi5zvWSLf3GfdxBRNxUNMXRoFU1DfmqK1C7dv/ryrwt4q6yFvpE9i+EKg5R+NuQS+Kl8EVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dc4fZ911oRwuUXkpwRBDHw6KPIyLOdhVe3Wf+DPaxU=;
 b=Oai0TDPWNJjVHJUJIVeMmkyghtlPIsWjn8nbYcvViXaZegBi2WhfuZmgFF/QScbLU1hB73JktbTdc+OuY44gda2CSZPRF13z+Ci9GH3tkyh750QRtUMVhH29b7fji8CtFeQwlZzRUXFKDAPUoOf7Kgs1Db1i+k5c1CK6nmx8ZMxSXO4SjUksAAdOK1dFZ0GYnBNlr2qxZMJeKsBY9Dei3WUFubHsXg8k+OV68YXZeLAAjezqUwUufhjIBTI4vsICvKAPNyDfenqO87Fg9RLl2Hqg+X+9nw4zM/iIqRDy56D278Q1PM5AiIFUeIvsX4NtqL4qeqZvCpsmGiywy1w9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dc4fZ911oRwuUXkpwRBDHw6KPIyLOdhVe3Wf+DPaxU=;
 b=M3vkZhJXBz5mI+YFQUGGqr576sFfk8dJwelBV3EEVypbxF6046pG3VuSzz/mDdjhssXl2afKJV8dRVCqaW70tQJILGh0JNL5ZkHc9qGhffX8Ux72CJZixlKnzDm5x8L2cUGKe8UBxS15xwlY/WYWCQJAVtXnX6l0prinDu1Dkis=
Received: from BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) by
 CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 09:41:46 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::50) by BL0PR0102CA0029.outlook.office365.com
 (2603:10b6:207:18::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 09:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:41:45 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 04:41:43 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: init locals in umc_v12_0_convert_error_address
Date: Mon, 18 May 2026 17:40:18 +0800
Message-ID: <20260518094021.280968-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518094021.280968-1-Stanley.Yang@amd.com>
References: <20260518094021.280968-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: e061b87b-c76a-4ec6-4928-08deb4c1ad2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KBkOuSB7hN2kTbNYs2/Wjijy2iyuxeP0BLGY5HKBepLG460rNM7zmdIrBuaw3fIqP3PMIotjGYB+crcSOU++8SSGia+elEMsqmDiHqpPXNio3VSQ0VcYo4Zj+P+r4oHf3pkPdpguAHQrwC0PXEBn3PeHy329/I+32J4i16ihHbiHNavDIOGf5KlcTc5s8/ajSDqSZIG41TlorEbZXvYEzTSqVKVT7WVh9pwiY47S3tSX3gMeaUWmqiz9jWUsuE85zB0rqtsM8LPicQENVAFuL/yG/soVh1wcNJPIEuqcI5vtd4D5xeumff9gd7G28fu/WV+FLjf9QASwO5xHPdEdaJl18UA30G+sA4bD0ZqgMbQwpV+ZgJGvY3Pumr/i+SfAOJXXOjp2GstNA2KKC8M6qs82lkvNW5y5VdDkw2w3xY0Dil7HH78ERHpjepzPZGbnVrOd9D9cAUklepG27pW0/GTQYUkMVYMXOFcP7fCsAKpk1j+Laz4SqyTQrbsZcpAQ46BK6gfSZxw1H3dOHhW45cw0FfIkC0GvQ3KSMajNLseiAjBoBEyCJBrzCwUbRIu1kEI/xqgLA0l7yJUcdd4zVzIb0vAp0lE4jQ09tGHPEiAeClOitqgCY+CLL4Rgs+saJXFEFQ37eC5ExtbqEi5TXxSm66Qd5+2vxPhs6TGY1UobHtla/Lp/CFSJ1g4VME66z1kPCSj/yQ0unYq5yMYt4KTjJJ1s/a02i7y5HaTuAiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fwGDLCaV+mhbnHyklzDKMlGfQFXx6xF0TlIB75cbOuV9MjiwjUkq6BXrPngCvrehCWPsx9AboM5oNFUZSPLdnMBKI8XUouVlwRYVd6K6UOUd4X1fssZkdJgwD4NjZB2ZKMApvjiZJsVnRuzi2Eyw2f4hmblx/32W/8be+iXMsL5MzamGRfTC0ihB2sE+0aizk5aGdY6kbKZVkyiBMwtN8zwPZMCVKy6NqqTEyMvI82FdepAcWfbmjWlCBdk4yUIW6l9szj9srrLh/3UdnJDtjQL8lQazNp8WTjyVUpnHmdfJEGv0LWa9vTn3Zk26gLWUax/7sKY9XBqgS1Ca4M6lwC9libFO86rObSv3DVN4Vp6JHWMIKSvfKpwZXKECIoLn7zdfHkLiXZrvqqhR/1gNrCxUMX9D6ceP9MYJEt61BD5MEHfEkt5IM9PqSSgbbvZy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:41:45.9872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e061b87b-c76a-4ec6-4928-08deb4c1ad2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

row, col, col_lower, row_lower, row_high and bank could be read on
code paths that never assign them. Initialize them to 0.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6cf674dfc8c4..a6df6a778f50 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -285,7 +285,8 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ta_ras_query_address_output *addr_out,
 					bool dump_addr)
 {
-	uint32_t col, col_lower, row, row_lower, row_high, bank;
+	uint32_t row = 0, row_lower = 0, row_high = 0;
+	uint32_t col = 0, col_lower = 0, bank = 0;
 	uint32_t channel_index = 0, umc_inst = 0;
 	uint32_t i, bit_num, retire_unit, *flip_bits;
 	uint64_t soc_pa, column, err_addr;
-- 
2.43.0

