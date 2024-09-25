Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B92C369A9
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E62C10E7B5;
	Wed, 25 Sep 2024 07:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XHRLVCP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B307310E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJeMrkavh2ROgOsf8b51mBupqQFKLkSoBUNVEttVWw2BDIYmPm1kAlVwtPuLn1EM4aBEkUbVkZYc+wVJVAvp2/nrndWKm0X4y0pqsFfVa9/s/02d6n6sLpQE0MPUiKnzKj4RYGu77YPsvcW1bclAUkrjJAbWMV6fvcEWOwqNDvA62Kq32q0XV6QDBx7uSVDFQNYnhqjwxqYjdn3SzNMo7V9hAMJ93YEer3PUpEgCMXEUsEjeyKvASN1BGevv+u3EhXqM4z02IAy15mjQr1/X0BC2SpRRbvJ0fhw4KPRT/MOaBCKiuceMUstUCJJTAVJOCrb9SgaeOqTrGC3LgHGy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8RIbNI8IbQJMrhcD8u5Ls+WYYBF4ykrdJl/y6bGwwQ=;
 b=wgnHAwZ0af7veSWWoO6O4NdTGlKpQ8dw1ypUM9J3tqa0XFVHRX/S2mErYKd2XWPi+0eFm4ENcmst9ca7PZvOnlp//WsvXjrc7j+Vb3bVQSi2w+ucvjoehmGd3F3cJ20k3ACfJLqrxKyUqPeasywD+biHyXbb5rzHixIPAUgkj6cIRen6162rVIaGBlujb9HPeniyzVmnD4wt1On2fIHEOKANfx7WCYSBWNjbC3qICQeXijt89TJvwf6nN/MNGZDHJD1E7QkGlUfxe8UBz3RbQNJVlcx8Oci7+XWHr8ssJyfhWWnLXjvPEMnS1vR/p4v6SsDICiG9Jz14KwviSsBjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8RIbNI8IbQJMrhcD8u5Ls+WYYBF4ykrdJl/y6bGwwQ=;
 b=2XHRLVCPkUq6hYHZgr6RoQX6mM6sp0qm5LhHEQ76yZ1mWZFQ1dbeJxn673+VMlVJyeXp/TvvDC2ubNxZLi/oLvW8D7TnAlyGqopq23HDergmG/m09AiEDRi0OeJdqVzBbst+3jiDzTWLbIYfbTr2mInnmcxWfc7t2M1E8JgW2iE=
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 07:57:16 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::db) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 07:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:57:16 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:57:08 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 9/9] drm/amd/pm: use pm_runtime_get_if_active in
 amdgpu_debugfs_sensor_read
Date: Wed, 25 Sep 2024 09:54:33 +0200
Message-ID: <20240925075607.23929-10-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: fbec75e5-bf25-4b49-c171-08dcdd37ac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FWdWQ9Za8OWAgIq8rp3JKeLwL1ub+wFbIpNYKqucB55PnMFdcnc5snJZzpV4?=
 =?us-ascii?Q?9gNsRbWias1oOObiflWG58R47Kp1VYmHrO+lw/CzV8MjLex669FY6BXDEGa6?=
 =?us-ascii?Q?zHWs1oatXLExDtRZELF9zPp88jPVWMmmjBhICsOmRCaPkcQIOPxCtjSN9l59?=
 =?us-ascii?Q?2+9yaDKECLeqD6f3sE96z6/oiD3HzWoDufz5zRMFdSRjiYOU5mIMaccthMFC?=
 =?us-ascii?Q?C4S1XGFZ8jc88mCBxuXKIuPf9LirR9plCFqmSjchyudmwkc5/gTmlDcAhM9+?=
 =?us-ascii?Q?IiCl7P885Iiue6zPBp09o/kzDx1pB3e+fQRMC6enJi2PO9+k8zEY+HPmT6Pz?=
 =?us-ascii?Q?p5KxLeSC03J0KE8RFzv5tZ6Tyvh/VlmNfu0lgtwoDxNoCrfGyb0U4HpspSa0?=
 =?us-ascii?Q?ibduXOPrXx4Bm5lWiXwNH2Zf1O/DTKGlLWmvb5BurTHrysI77tvzPgLKaV5G?=
 =?us-ascii?Q?8JCSVdzEGztw3zLB967pkPwbI74jv5/rYL50DyXl0+spqWnsfpqfr3C5GGpV?=
 =?us-ascii?Q?nSKV4ad6UiRhOhWmG3FqXTt9+4fmrCRmmyU3K5fN74pC4V5/YesfgvJeeu71?=
 =?us-ascii?Q?qv5rBnpAAcgDnWyuqvVvQ9lmL/9KCzThnVI8JOgrYX2nrUXkPeM5ly+9wStW?=
 =?us-ascii?Q?Y2haAr3uwrZNTmchrtrjZ9+U6FCZwmmyiXdo1fgeVfDIYfjYVvBZmGJMffJ7?=
 =?us-ascii?Q?afTcxczqA3zUJreyZaQavRsxQ0bPdBW0dZgspW5uBluOxk/Fd9QeVWkiSJ1j?=
 =?us-ascii?Q?KlbXT5j72f6mTnTC4G1CPgvhEOcZ3KuPT8FQ+Z0zH1uUarR728+UP2E3lq+l?=
 =?us-ascii?Q?PeZmuuXCFrtqOlrrjIpwLV+k3IMABgNKmva+b7Bp1/NExcoqkKbKGw9vvMRC?=
 =?us-ascii?Q?+uGNlWEFQ/jSzkzJuhltkypjlv0gNEyzkoD2eW84jgz8PpD+pouoKCwYnbLd?=
 =?us-ascii?Q?8a3Yg7TZTs3BQBqazE7iJLijCyXrFxFIGoTDL755wZqlRT0T0NGQ81Ek5ILf?=
 =?us-ascii?Q?lTxZ4Bsn47tIxF8+yzXxG2yY7EVggi43Q+5nhUWj5JUqeGabisCwZAvU3PPU?=
 =?us-ascii?Q?2S/Fe903nmQBCgD7L5uNnU79oc5InUm2TQFhcEik1Wh0AGZabqAzZHlufNXj?=
 =?us-ascii?Q?NdL651uY1FkIADFwB2H/R2v+V5PE7NqL9PWQs2eCkzQWpOS0tC5JBRuBzp+o?=
 =?us-ascii?Q?Y1hdRfsf56V3HqM2v/gN2Qf+Iwkh7HBOKBoAqSzs+LTWd6ngCD0/gsr4C9A1?=
 =?us-ascii?Q?PzXJ8xVrUtlKmqTyY7zC4CeKowEpRI7Nq+M4Yivgyj1UeIFgn2vZsZmqiqlL?=
 =?us-ascii?Q?irndOoVAfrI0xzrnqZNHqWrYRPumfeiER5mp+bra4S8IwNnIoOIieW2g1K9k?=
 =?us-ascii?Q?Yawg0vfJYuivmVVBP5lkcQWOTxdSoWHHdpkKuxApM03tQxQzDvJ7zpdt5xYG?=
 =?us-ascii?Q?5MoT9ZzwkFrjW9fVORTkOzVZ2PXFboLe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:57:16.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbec75e5-bf25-4b49-c171-08dcdd37ac2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

Same logic as the previous commit ("drm/amdgpu/pm: use
pm_runtime_get_if_active for debugfs getters"): debugfs accesses shouldn't
wake up the GPU nor preventing it to be suspended.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 37d8657f0776..af31e94c3eb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -989,11 +989,9 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 
 	valuesize = sizeof(values);
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
+	r = pm_runtime_get_if_active(adev->dev, true);
+	if (r <= 0)
+		return r ?: -EPERM;
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
 	if (r < 0) {
@@ -1003,7 +1001,6 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 
 	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (r) {
-- 
2.40.1

