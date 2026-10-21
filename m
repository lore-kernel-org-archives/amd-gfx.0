Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A82606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oKePZe9a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBDA10F968;
	Wed, 21 Oct 2026 06:28:12 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D2E10F968
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLDWWnDIZDuQrZzogoFEoGbJBXaPRsKtApRUeWK/qycXgSgZhLb4KsVxdb3bpoaurHz4eFVM9k39WRAAUl/nX4hcfthY+aXONgzFClfgqxHxKtXKTY9qAFkJerm39rhf6o8qWSqiIDJ45LTL+6kAMT9q3DMPg3GpWIfK9pXUBeyKKP+qL6xuE86NGFYIjKAMPXAl42ZQv8MsJJx/HFMs7XTsUBkpiRuaGrx+cHW7VZQ2oTADts/UVtz0pFguuBmI6nqm1uLAOFxHM+0b+JTuSqguqTEQa4Hb3LoywqdJa2f+Ap1Wm6pKN1pVFTQnrvCCcAJ0p/sGpFj1Do8NaytjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUOfwSJz90Rwl5S7eQZG3OKi0VDUYXYKZTygHjdP2jw=;
 b=n5LUvoHbyFP9F/brxRmgWCZ1vzRYrgteSHKTx/RFAHrXpNTw+h5VS6FENeouagJOIJ4GWeE7cqdPAa1Yrt2HWetb98Bska0wY/EqpudKTp2huoLJUruRZQ6Pt0v+V45yG4L1T3Y8L04qRsyu3QLAtMAkm81d0+JEnfVTrRIbYARLKwcXcZgRVCxW8MAxgAz1ovjkYTg4XVNZU/u3uuG+tOUSd6adodoN3HTAmLlKsrSPg6uo2nAex6UPdSABkFAh96aJomyqWtYJMUsfLSLsqc8fq9+q6JsFW1pT4MgKsKFpX/c+R18sZv4bZwpzVWBAIARICTHKMXes5fEzlyGB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUOfwSJz90Rwl5S7eQZG3OKi0VDUYXYKZTygHjdP2jw=;
 b=oKePZe9apqaveT3FIjCN48H19zhzAOjg9s5yc3OoDAV0R+SosvDuSTWHQVq21KbKKkBnc8pA7//hP+JPJvGybXSWNzpaX5qW2w51Y5AiYWsK0lgvkt08k26GOCbB59+Tg7/QvD+2oar0Zha4P28pxIM21VGk4pRlaosGkSOuPD4=
Received: from SJ0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:a03:33e::12)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:28:01 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a7) by SJ0PR03CA0037.outlook.office365.com
 (2603:10b6:a03:33e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:28:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:59 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 42/49] drm/amd/display: Destroy dup connector state
Date: Wed, 21 Oct 2026 14:22:48 +0800
Message-ID: <20261021062519.674697-43-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a2a5cd-3c49-49f3-2f69-08df2f3c7492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eRO4buWAigbQYnZZaLgL3I+v2Y3t3TNczokrsQB+S9ap8rfEFsI8H1BdvHtbBPDK74Eji0MU7r+goVwUIMfj+lJ8pIMCbPudBk6VHnTb/QUyd6O9VOs85PLxes5s67c7vDTZc1JRTXan01FweXEVU2ZwhOS/2fWD3NMg8sFhOdi5NzbrCFQ4Z6/IqlmqaC1qixC3EINfATndJlrXRkVX7Ox7gu6VfQQyBHxZ0+4ccHdw2JjjDjN10JvSsF6IufCXpIjmPrrEnH4cRjDN8CSrp+pkG1s+YFRsUTC3RYhjSd6C2K1BUz5QT69uZmNehERtoxbfh8sTbFJmqoa5kuEPGX1DBnR+SqxyWkM8g8SgfoBe0bEO/DrZkH/Qd7LhH4PJEQBzrCNOPmXP92adygkRGat802UwdKB1uXzcT3ayfig1f2/q+/5oDolcnCFrp3aXuBgUHwTISB+t62WkI5SuCPijBC0IA6sbLjRMr0JuuQNy3i4RXmC6a3oL4o6n59Op2O80aFaDW5+OOz+ZhD60lDqT23EhRRzM2S4DOfwcL+BOQKh10aRYZno5yimYJUxe5AMwKbltbN01hd7t6lzXjUFG5n+pcn5790R/JTLbkXl3qyLEtcsN79yKgYx7NSCtVwNytScKVlxwTPv5B02RotDdWz4+B4zQN2ylqVUlcL/f6Lef1e4XdZofhdfk/WgddEpM06g9gCZMNXIlE783SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: axHqrnp5Tn7LwoPlcFJqgbu7DuXegWB6+zMqUsG/r/Rzu5GibHyg2vnGm3SY4LqRZsdaidDIb+AIqdYeFFFoktWoVQt6mMPXDQ9cFmxqrPQtLf7DQCTQ8QETNss2kOhAiA+9kQWNk0d7Q61Md/IArrw3lEKrISMKLSAs4aAYXyoDvezszfQW9iIgUxzZAOPpgYyG2qHnZakComPkIVbUxwmesGZlFAdjJPVFviBpf2oRWA/aRkxL/EkxmXMagqVm7Vb6kvnL92u9laeQ2ybTxzvHZpx+jknCe9neDHOLVi1APa30Jggch3jSNyOIREsqezUys5u80SlfvVdP8ajWiRqnNvB5+T9qFuO8SCdVr3sz2YXklKKOt2ZFpkqyIL5TD/vZI0osy0lcb1dd1PVSBuIAk9yFYfaXwPV9TqkuuMbak6DcB0b6Blpt+msOWs3v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:00.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a2a5cd-3c49-49f3-2f69-08df2f3c7492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
dm_test_atomic_dup_state_copies_fields() frees the duplicated state
with kfree(), which skips dropping any references the state holds.

[HOW]
Release it through connector->funcs->atomic_destroy_state() instead.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 242a18f9fcbb..0c678471142b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1799,7 +1799,7 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, new_dm_state->vcpi_slots, 4);
 	KUNIT_EXPECT_EQ(test, (int)new_dm_state->pbn, 1234);
 
-	kfree(new_dm_state);
+	connector->funcs->atomic_destroy_state(connector, new_state);
 }
 
 /* Tests for amdgpu_dm_fill_hdr_info_packet() */
-- 
2.43.0

