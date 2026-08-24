Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE15C5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 10:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6D310E6D5;
	Mon, 24 Aug 2026 10:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ayz0Qwen";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B7810E6D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 10:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghdq8hq3Z0B5PRe66U5+8J2570ZP8Zg9LZnEuJ9CtzfzIGU79LiVr27QDKetaCcC4snWWIdCs3iUGgi9S5fGCsAZVCQwlobOOYGCu0ruv709R63tywE2/4LgFbHSB0qbq1liEuouh2/rxRlNOGwXITBQ81+YJLiu9N6zOBgyDbjLRSuOzqcDSTh2835Mb/ER8jWK/CfYDzKZrMvdevYFgsHcpNib00ZWHIK6FDXW6HC39AvlJroMo4Do4zpGO2tLVW2wPkoC8V3r4ymU6WZESQ3+n/g/8xPwEOwBrZbXRCk0bmHAVi288YMqD3R/s+hfROYd1fFVHqbTQKmRHShwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpzMuUay9lzRmSkKMxvWbLkCewxN8SW+TX3pvhMX5zM=;
 b=ys812lBqrkQiUualNHVwN//7vgyD9rBt/ZxdYqF7+tChGW5sxdi4Nj7q0Lk1heg1ErsHfJfIFZc4cNQMbix9nvu0K/Pk6WoCewEknazKIgRj6m0oanRYilbbf5Cu5FoOPlO6EogTBY9HgEwnEfA0yKWsgCM9R7qDn4itb4RuN0mtGxl64u71XHHRIOoJIOVmwa3JFkm8GgzA3UYCaMdmO4eIKz3SjGWguyVtwon79/H4rjGMt0AXx3vc+kKfT1DStzW3v89IH0h76/Gfx1K1lDGq3U/3dWgGnbpNUlLs+L3YXeozyJLcI/P2VnKDvcifRRfT5F/DOtaaz8kARcQXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpzMuUay9lzRmSkKMxvWbLkCewxN8SW+TX3pvhMX5zM=;
 b=Ayz0QwenHSlxGdzU+EdcmGO5H6bNNf29DbJ6y196lOTfhJtxswLdJ0o2am/N/XgmhcJRY96ilA+zm0LX3DIsauCMHnojQA2y6nPtuzKsRw+7jD/qspMxZkiTCvdIbh89NYlWj1G0jZtzD44xLWz5ezWlYselr77iBUxKgDSgcEg=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 10:22:04 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3a) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 10:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 10:22:04 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 05:22:01 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: record the fatal state on every device of
 the hive
Date: Mon, 24 Aug 2026 18:21:11 +0800
Message-ID: <20260824102111.264161-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824102111.264161-1-xiang.liu@amd.com>
References: <20260824102111.264161-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af67c2b-27e3-431f-bf12-08df01c98af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2MpQSrr0A9Bwq8eccvQv93dtA6lJVnf/tWPI86Ede0UUg2Gxv4HnXoigC75sD7S1WWCpy+slIzNrKLGoQZN33OH8CwY4QGD25Yj0uimuDG1icmFF+/mvuZkKjYdQTBhHliVwuUi1SkmonokumK8UodPIrjxeCMy9GHb0YnZoqjewmCMxRR1xxtdvhH5RNiDalzYYy4IeYEwNimEKnvHexvByBq+B2h9/4NzltAw2WA13qMVN2O9JOCfnGgqcgiR+KtkVzsy2bGMneU2J2yjcjveN7qphhm3qUkkoOWy+VHn7Sgvh5alulQ5JLKixj+8C55inrcVCtE7VUrFeClIRLhB1N9vFaDxFMJNRe/+NLHGLKnTxa1Id4Uc5sELSAQ2aP5raF29QOwAYlrRaHpDwbxrVKhgBJDJNvb3HwG/bkhFK3pY7uM49npPxmPZy6hslov4DV0i5kzERhkyNOPZ0pgV+L3zaFHpzs29Y4bwiQ/CHfZuR54Z2EQqxitRkXUwDecUuJRQkaBCcTpem6adVHuAdaiXH40hGlRRuLeQpeNzkVYhqvMwAYbWEHHSvLoE9UiqbOTwOcixbrFElIblp1q5MLwejPX+EOyFUCJfOaqE5oLhkH2A2byFMk2X9mVIPsC5Z8+OujBzljPzSzB5TEtlMY0RZmC3juKomh9LFXRanNdXOYN9FN0z4Tnysc0E/jco9zfCGzjUg+jSPzBI2wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UGPMt8Q70PNVdY37D4QGxLX2mu09BEiniXqcV39oKK9V+41xqfvz07LQKky71ZfWrT9arAiug1Yyg7xmIHyCefyK1jb6/MTqFcHmwla1lagJVPs60SpdVGcrHUyGiZyfKTVXmympae5KJ84SSBOJiPUDOnpkYTeGIO2jkMQ2HzBenRFjgtw2dhuVzlqqSGME8BTXXkdtd0vXOK2p1TvkrLY4KWxgWugyRxgvFZ38sdjMbFbCcaUrST/Ats2+nwgxFXGEmDKf4gn244m1bvFUHFxMk0KiR9LiFQMHmYbzUrHht2p0fb0eBuGA78yL01cJRD1FKjWcskfVU8gACB6ZZQFqzWN2gUEEVwEgI80Sy9aPeA7QNLW8dU1cIGx9Gme7DjNAhePN6jRiJqUff04hP+KRPwd+800WcKhi4zZuAGIRqZhqX2WV/vz6gdroJczK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:22:04.0857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af67c2b-27e3-431f-bf12-08df01c98af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
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

The fatal error interrupt is broadcast to every device of the hive and
they all race for amdgpu_ras_global_ras_isr(), which hands -EBUSY to
everyone but the winner. Treating that as a failure returns before the
device is marked, so seven devices out of eight are left without their
fatal and SRAM ECC state, the one that actually logged the error among
them. KFD then tells the processes on those devices that the reset was
a plain hang.

-EBUSY only means the reset has already been asked for. Record the
state anyway and leave the request to the winner.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 081516c46cf8..291b2a96cbb5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -33,8 +33,14 @@ static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context *ras_core,
 	uint64_t seq_no;
 
 	ret = amdgpu_ras_global_ras_isr(adev);
-	if (ret)
-		return ret;
+	if (ret) {
+		/* Another device of the hive already asked for the reset, this
+		 * one still has to record that it saw the error.
+		 */
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_set_fed(adev, true);
+		return ret == -EBUSY ? 0 : ret;
+	}
 
 	seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_UE);
 	RAS_DEV_INFO(adev,
-- 
2.34.1

