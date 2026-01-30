Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C0FD73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FF010E8DB;
	Fri, 30 Jan 2026 02:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="27KAPpph";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB2110E8D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly61efe5Yba9qO62DkWA8L85LbZlVsSIi6vx8pzTyXGaXEX189rj1y1AlLgi1D4DUHf1eURdt3bHi9gwOtjAzxUyJsnLKapH5gMc1bPML5xjZ2VJ6SuSmabbKh/JzzQF7Iq+t6G7wI1pov0S1dncV3QI0WADsCLJ3v3kQH0eroxmJDRbTe6SpYXOMsKbzWz58pfqai5sodVEYwi2xSuttdNHiwBeesTgU1sa/7djxqRBMjo+LEidKTmEjX6e5Xg4mKLWznp4ZzSwFz2K0mJivNQXGD7jlzmZ96EhrAmlynVZHUW8qYxiQkMrzVMat+e+3GjMGp5ZuS20sYR8aKJPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re1ds1vlFPHla3WDJFARGxInplvlNgOR7UJX24mHAoU=;
 b=R9nWcqYE9gb7JTrk8zigvP71HW8rSE0ml+ZiAVFQBL6i/BmL6koPwb8ygaSdaJzVWBAIyd2LE73TryaaJAi8PgQkH48kex8+1HayUuyld0EjeOoJldNcfB9HZDewzht39m53TLWZad9z5CBuG42oFUssDEpPl0aRrJvRyImlK4mZwi9GYYNfPaf/YXCyhzovP8zZ+u2yAIgUSP7JYZa3Y98vUQKIfZrB3SoYPgDvFxG0DnZM/cM3+E8N7MdUr5Xp6IBdJ+LMRQHx+bwHaaiKSNFIzqMitZkI89brPkXlhNsDgrqoLk8cMGvmfjXlEDQFXYELGPrhyTYbG2AfgGXL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re1ds1vlFPHla3WDJFARGxInplvlNgOR7UJX24mHAoU=;
 b=27KAPpph/I70KUxQXcTfiPRKO3qGzjTv+6/94q2Gi6QHerff1yTasBfyyew5m0ua7ngfyBEbHAsExO8f4CxTPeGdLq5LqZSjJ59lg2wia/Uy33BqlRoJ/Ta7HWU3mYXfHlgh82oBOjP6XnXvSnpT3bW60vx++S0cSxQeH+vOpmk=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 02:30:49 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::57) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 02:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:48 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:46 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 14/14] drm/amd/ras: adapt syc info func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:50 +0800
Message-ID: <20260130022950.1160058-14-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 421c5cc6-f5fd-4ac0-a16d-08de5fa79448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GW8Ti4TfQmqgOk1VrTKfbzTgtbCg6IG3VM03/pBS8t4w0luUW++KdRRgSiG7?=
 =?us-ascii?Q?6xsrMnzm9GlgRKcwoy8CXi1vpUaPCvQjAvdSjEYoNG0IHpIf37VAOja0kLFu?=
 =?us-ascii?Q?s76UEZ2c2UNG8Ig/TLA69m3ZMUHLiJZ6OMJ6LqtDZ8YcyxJ+zIJVZmDcoEYr?=
 =?us-ascii?Q?wE04HN4lWep7ZLAs9kVtRxqRhiLtghucTqsZPcN6IxYuf6+ebkW0rsdiQJqg?=
 =?us-ascii?Q?VkotR45hBo1d8LKHqnMx4agiYB7Ed4bKhW8CtuzYQ9Pp1aAgUFhdPULBDwXm?=
 =?us-ascii?Q?HlkKreq2StFD+GeVWEkIKsHlimrA3CP87xvCxPvLWoUvEB4daRueBjS4MT6n?=
 =?us-ascii?Q?ktQWpFOTu/7ZqEpoENhJ8xwgB/JCfxPctFkBMh+xOu0/7aW7z1mNA8ENRqzx?=
 =?us-ascii?Q?kvTQ7KhguhrkIyGyivh4YNW8nIcxgX4v72BJGNBZ3Z8pjjbHxFdRYGxGhWHS?=
 =?us-ascii?Q?lExo4p/4/X4yfq6iQ9X0xXgzrVSSSXHTOpB5K6oIpf8LcRitdoQTO9xdtyX1?=
 =?us-ascii?Q?ogMbPDpoNtwRZ5l89onXk4lleI0bhsm5qE5u2Qwnn9/Fm0RAPlFIJxDHiWsk?=
 =?us-ascii?Q?wd70tzrTwrLnYdCyjPe9VAylwAzCYACA9U0EpJC0xPGWcD+E/UmYJhG+v8AK?=
 =?us-ascii?Q?s35n/VnrLtO/zxm4jtG+BJ+UnqE7UGgxpoukzpEqexfz6inqZWQOQzyVT8/h?=
 =?us-ascii?Q?I/wPLSGKjo550dzm+GS+WMiwE5dnSztUvAx7qYYowTsbmF0Y+RtF8bQbyF3P?=
 =?us-ascii?Q?ESLfSA83EXn2BIZTmMcS7b92tn+8Ogb+h/5xtWVAEAsCHcgE53RyJUtwI2ZP?=
 =?us-ascii?Q?baKJkOsNZlhGrLrDR6EIMHK3vni6G32M02Pxb5KqCvVI5ezdh1JsrITfq1J2?=
 =?us-ascii?Q?3yx8KCkpSBiEXhmGgjPxiJgUZ8UCHFQZzo0pBlxzHnaU3meOBsHoxGwQ1gzW?=
 =?us-ascii?Q?ewMUVN+XF+msFijqLDlStGjqRiTEB26nvtkjhPmfdZFJzvJ+WPcPx5TgliAh?=
 =?us-ascii?Q?CJCstN9brsC6JE24yRB2CcO5qjfgivfnk4HLGd3h/7nT+xv7T7gqyt3dvBVm?=
 =?us-ascii?Q?/4/zsY9HMOrQFfX1c4Hi4iQnnrMWc70gZIKrfnSHFCVQuw3B4iDg7QFX218M?=
 =?us-ascii?Q?1JT5RV9EuYLLWHbM6UM5+fPHuV5JwK7fzv2S7cA1MpxpoLCOrAfKqKm1lyqb?=
 =?us-ascii?Q?L2e4CZ92new0b889/+dHpRZZnVQ8KwNR81kiEGn43UV6LredTmYw6K04eRA+?=
 =?us-ascii?Q?+tMoGudAZ9yRibWHcIXDAVTsngC89Q5TW9SnAnS0MklknC5kdobOymAtP9JT?=
 =?us-ascii?Q?p3xWJ49bZccUFgK/mLLGQk54fq81fCtXkPtgI+AqRWkZ13vwLlZokR45vJPI?=
 =?us-ascii?Q?rFMHiVFpcaXnWJKPDQc//cD9UWSvOjax8KazHiOP+K9IzxgCqAgelnNHived?=
 =?us-ascii?Q?yKBbnUlZlb4BBTS2WJMPF5ql2ps0YtF+A/mrE3fwMSOH9KgOkjo3eQywpja5?=
 =?us-ascii?Q?xbx1YdZ1Vnae0ey75+KWWidToB7QWjbL+64tKYO6uK14zkJKIY8ZMmIi0ciL?=
 =?us-ascii?Q?BJqyISL7VolVULwvhawqZJjB6ETdsxBhEg4qijuUW3U2JvzorlpVWpWT5re2?=
 =?us-ascii?Q?C1k4I0drAADilZzs3LfuROhLPKhd4nhvN8gXLPtQpwbt0UjFn+aI6xdD/0pS?=
 =?us-ascii?Q?hfUdyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4dNp0Fper7gHhLyw6k3utg8lG/eBQYfgIDYgKI/JfH7k1j/omG6fgdz4nVP0IyxexcHmcuT4w/fi5S3FUp4ysNzjjDicHhRTdxHkVJpIePa9lyGMwLW3TP7YL1i0niQP7z52WT/3X6JU1uy1fOvqk7V+gbGuvNdrxAynajK++9EmPYLelBpvb+osaKv6cTzf71oAXGqrT+W7tg3+bc8E79hg5L2Kb+Zw9Dh8TgisUifGKEnoCvzqlvNs+5gXDgf+AJ2eJ4IrSL79f5HxwhFHJBPAXHljdJDHaTY4z7DYlLzOTV6xRt4WW3/5ex5fv+mpvKQjpspFL5eag09bAzjIBPc/AAlmQffaPzoX/fK4VJyUtf5F1S0TxDtosAkV5y8pSuNveXXOXPYIxC2XZmHY9i1sp6oTJZi9pjA8SNLhXzQswUSEuf2DtaCxkF9yvJPv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:48.3762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421c5cc6-f5fd-4ac0-a16d-08de5fa79448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
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

adapt sync info func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c      |  5 ++++-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index a4e2ad6a159f..6a39e5499c5d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -256,7 +256,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 		return ret;
 	}
 
-	ras_eeprom_sync_info(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_sync_info(ras_core);
+	else
+		ras_eeprom_sync_info(ras_core);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 70bbf1334c4f..29001e606d1b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -504,3 +504,17 @@ enum ras_gpu_health_status
 
 	return RAS_GPU_HEALTH_USABLE;
 }
+
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return;
+
+	control = &ras_core->ras_fw_eeprom;
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+		&control->ras_num_recs);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+		&control->bad_channel_bitmap);
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 75d8b95c6923..762345be075c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -82,5 +82,6 @@ int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

