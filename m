Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3ABD49C7B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F28510E977;
	Fri, 30 Jan 2026 08:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMqB3A5S";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501E410E973
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7E3Ij/nmhjlmvbMitqYY39bv142HdsoZXzf1QrRiXT+bSHR+fbGHbuQDWBTqrivIo/xDN0jjOzf/KVqp8xvT1gQz1Ma3aPyH6ABqrdVzsCilAB4nduZjdPNdJnSBm0Cbk/qWW+49VbVb8TOZnakBWyYyI6oVgkSHOy5LtM/tql7GbRTAaaEmBwUQA9fE96A95iQG6ibloAs/wjH+KB56SSB4sUn0/Ke36kn9lzOJ1lGhc/7VZNyNn/xtQHrSCsNldSZjXzttsSSse4P3YBe+3j+QtoQ1n7uBiaB33gWN7AmYbR6HaOrDa0uqzlLeoRoW+l7MR64Mf+uqxmPM3QLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMac2naIxxkyfKqEicC6ZWJmgoapvt6LiSMY6ppjMEE=;
 b=eeEJqviLOU07oxWjySOc72giL7BNMT4SM/eqIKh1QC2Myw7JUeRVvdFx60qTUVM/cIVTZcg5KA6G2ud1K1Aph2f/G/h8dXSMzsUnCKkfFfgGNtcCgpCNFmv5v0ylQk1OXr377xSDHpeK8x9xEzvn80ZJ4b98tFqQPJ+lE3R+oP+Ys5BwxtTbfgvNN8YUSSaFZTnbAK09DKGSRzKTSE0h2pzfRb2MnWOMabxEMFC/TxpbnT68STQ6Dp61TMksc3NXFfwtIc6JLr4B4wPvPwrw2uo3DUHF16iBCO6+LpV0awO+NRvAPqd6yKLx1jksQz7oX34zXSWhtCvvZWQ5zLAk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMac2naIxxkyfKqEicC6ZWJmgoapvt6LiSMY6ppjMEE=;
 b=SMqB3A5S6lH9WoUZgg8ErvE9fuVJnEOuTD30y+XCVC43lWQeZpMMTCKL5kG+ERjDmDR/qxFwEDEIDGidNrgfPh29rEX+KoDUecgQwudMJzv7gwZtDFn9MWl7KvYYHYJCKLP+SENy1F1XB6IXism/Ue8tonHK2QVC52WveIM03+s=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:08 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::6b) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:03 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 01/11] drm/amdgpu: Add helper function to get xcc count
Date: Fri, 30 Jan 2026 14:07:55 +0530
Message-ID: <20260130084137.2906792-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf19d0f-2e65-400e-eeed-08de5fdb73bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mW7laMOTaaYVLcGjItN1iOABaPy6isPrLrF0O2HA0/27JrqkrSjjwHLTy0An?=
 =?us-ascii?Q?yCBcnj9PicdjZPIV2G/mfOKxxXsgcfVwIQW+9iptAgAlIO4M2uqltas+yVof?=
 =?us-ascii?Q?mTxs9a5LCqsvlUp4G2IAs0Amvs0wdDgIJyl7DD4eGfenHALAnG0un9UDwiWv?=
 =?us-ascii?Q?Rk4nvoGNL3XUmhJ00ArVrQqrXxz3ff9q2OJkOcLwZhjv3WJ1Y5sZCqAv3hcG?=
 =?us-ascii?Q?PB3rTbB9YmhEYLskjSp5gsJcrjOODiA1yd7yYkxioSmyCpfnBDq6krwn5sk/?=
 =?us-ascii?Q?Qwt00qtWEc1LsydzPOPNEKekbrWK2kntYf8Cj0iujhPngmEkbY3touC9q/Cq?=
 =?us-ascii?Q?yk8WxE8ZNDPRoAlDuUkxA6XSHsaRrm/vEnF7GiQFa+Jx7ae62WdC0y7bkrVS?=
 =?us-ascii?Q?P4HQB4GC8wrW58CrMD6uuil+cAEoJfUoRecOGwS6L1oozF4YoaZqaM+TOHBo?=
 =?us-ascii?Q?KFZ5/Ykk4paI3INTA2Mp9wOLsED9oKgf7sJKgIWvdrtRFGYT2nc0RUvOaTfD?=
 =?us-ascii?Q?LvZ/1R3eNBZ3IPh9iOPAVJt5o9OP+i3hgpUynOaVgkOkDkjZmo9MMMKQZ1Hf?=
 =?us-ascii?Q?ujtRfVgcqNCRxLjsR9jYTgKD8FI8nSPjGzc1MH7wv/l0XwMNH0oocT3Foe8s?=
 =?us-ascii?Q?RAuMw3qeVPQBswaOXKy2DhYhc8JrTju/kNBmliAtGUdtXelyyvJ/c59XhWcI?=
 =?us-ascii?Q?rEwCCyRndzo2dXGOthwpttrgi5IoZcQdeOcN4jLEc5Ad+ToKzg3kpcxGLM7d?=
 =?us-ascii?Q?cRN/HwH44rHgeo+KFcr/xLIk2UM3QIGo6xR3bXUqLlNr5m50U6O0qiPHLuRv?=
 =?us-ascii?Q?AmCUtgSDyMaRqoxD2Yzk+sqZquF1K9WirQrz9tYWqn/OcSvqjhTqcYqJFfDy?=
 =?us-ascii?Q?/ad1FAZPrwwdEinEUg7KND8ukttft/igCrSXhI9qYeLeSyhoZ81uPo09VWY7?=
 =?us-ascii?Q?E/WKhfFCRLzYaWwCMuefR6mPR/ZB2yuRcre2y+jAB6ULtHvyJr/ESOkiPEAf?=
 =?us-ascii?Q?EolLK0SAf19mWEkraSJwDDWAaNry0Mz9hFU5z7qwnuutbRq4SFp1BsJEJ3RF?=
 =?us-ascii?Q?cHDnCKbEol3G+AOLQb6ov3YMdDT1DV5KojJHAOF9Ih4UCVyyjLrovalefY57?=
 =?us-ascii?Q?EpLnAZ5CEP8FNDROjcpI8D40P39SSrhZYYh7E6lFSlf/elYzkv5l+fhX4E8D?=
 =?us-ascii?Q?oG0bYSAZVMrlWCQSzu3uQefjqt1Y4He0i6Zickj4BAv9p+wvTh8OLHZ3vwlh?=
 =?us-ascii?Q?/1KABo/5CqhebF5OdL9JpyA0TcSnEmr3fEAShM66KzoPUKw2mva8N5SXGylK?=
 =?us-ascii?Q?bUKg1BxJKut9sK2r6x6XDFLUGvfgxr6C5icp/woKNLrbcc+pYPnn8j/aE3Ww?=
 =?us-ascii?Q?CSpcvMwNxmqwHVOfTgQ64B6m7jCS89q/wP6goBBDxcBicUpHRhMV1mUKvSr0?=
 =?us-ascii?Q?HSPc29Yw5T0OUIo6k5NhxVD24+DkgWJRwviIY3D8sfofv5RkpfUbaSsCeX6p?=
 =?us-ascii?Q?dmER1B7PUgvbMFp204HQcJgUuleuRckKA12fUEEPEv7lwyTTjNHovFpnlk73?=
 =?us-ascii?Q?0VEkd8qO2L7br4mtJ3wIm6t3nYR/XR7DQRjqBeP3eVbGCgaoP5oUbNYBzlmh?=
 =?us-ascii?Q?lzJXL7UskNLrqPBGbI2jV02buznpxavq46cQgRvzRbi5ssjgcLVJnVfSyoVV?=
 =?us-ascii?Q?TT4fbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o/xle6xUPnxNDMj9uks/mymFIboueRXCmUBulqZ9b+m3c/s5P6/aL2fPkDNR02/lzplY8xfxjOPG/zlm+i74xajhw7OqcwEu1cr22BfFdY8ojioS4eeyZVIW3erKPyNdZLMU9dmd5zzHl1peHikRyLjF1eyYirB2Pz95McFqYSa8LGLtkEZvnXwcjH3y+on1jZ6YVNCqq3bkIsXAdQGLrVAkLbAzRoTrGelmMX/aF2nLLeGC6JO991/O7N86Ed90mbqWqzt7q12xn+g+wBTGJsFcGFepG+LFTM1kmXTaScvWHHrhIxktWaSmQLCUP5tDvOjVTxsivuDVko4H109UW/CECmHkJIoNMmiHDPhSgeSkqeR7P1JOqF49LZiXUyJdFv5VQnlwtEqCQg5Tf2pcZvMOQVYsI5ZfRX/yJRejo1tPi+lwO/upub0bTb+e2UaZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:07.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf19d0f-2e65-400e-eeed-08de5fdb73bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

Add a helper function to get the number of XCCs given a parition id. If
there is no partition manager, return 1 as default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..b780c12b07e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -217,4 +217,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
+					 int xcp_id)
+{
+	struct amdgpu_xcp *xcp;
+	uint32_t xcc_mask;
+	int i, r;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 1;
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id) {
+			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							&xcc_mask);
+			if (unlikely(r))
+				return 1;
+			else
+				return hweight32(xcc_mask);
+		}
+	}
+
+	return 1;
+}
 #endif
-- 
2.49.0

