Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2DF606A319
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R0vC3wMy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB9110EABC;
	Mon, 19 Oct 2026 20:08:08 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74AC10EABC
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSzI8YxV8FmRTaPZmEqVDWdNubs5CkLk+eN8gc1itShzI0g2+tLSC2TYFgfD4BC89nrmBE/lTDXNHSWyyYkjeUqWP9JbNxosA3obdwB1nnMR6FX5L1ROcZJwMjA6b74n9abuhpYl69yMITtD87mjQn+binrp+utD+3XAww/DlaQv+6qeflk/KSaXbxIteuU0c914XqOSjM//xIWi1fDYFohQEZPuj15w86CNjp06L1pEFTrBBdCV90ai3UwyPZ14/RPt1QNgoHxo63O6BA29EbJZUexh/rJopXk/juJjQ26Em/jAQPY6CdlbV5Bp+mQQs7auom5vZY/2OgbzR3aDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/ET1lUUedKj1FpQSwliRvqhick3xXhcjOLPXJtnRtU=;
 b=iTbzJNk3NOk4sda1RlxArAQgbd/8/9ejPB1rOdqEzVD/pwnB1+9RlCPG3x3Y5No0kzooq0RqCVF6U0QgsmfXOmhjwdi3DGwINjPV3hPbLkxF5FTBBFdlaVSA4OQg2qnyqXOnrGByt7TJC1gqcP6jMlwU0e9c6JcojWlEcPDWT3Xt8sH6TvLkHTU4xuVafnmD86Sz8EKPaYJyRxq09vSa4QLRWBlQ6P2dHHvSieJJvOaC2jnHYyMgzNL7r9ifWsCzWxMfAbLIkR+DcFQ9umj/cokJ5nfesjjMYuZq8atHZqpsA5N/Qtafn4d5d+sTidbige1nQbEqmSOZvhsyVzbkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/ET1lUUedKj1FpQSwliRvqhick3xXhcjOLPXJtnRtU=;
 b=R0vC3wMyDtjKNh9AA1A1eSPq00yUyD/Ad8p7GxIj7r4q4uIIrngjfy0RBY4RBngOlpu1wVSA4xPXq8OBHi1l4+aaNKS+dFaCD/TJXa5gBEVcvM1fmwL0cpFjqf4JUykQosZAib7LYDNmJHBy9e2KAEWiOAaW0ojNXS48Gqxc0ao=
Received: from PH8P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::18)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 19 Oct
 2026 20:07:55 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::3a) by PH8P223CA0021.outlook.office365.com
 (2603:10b6:510:2db::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 20:07:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:07:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:53 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 15:07:53 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/jpeg: allow type 4 commands
Date: Mon, 19 Oct 2026 16:07:26 -0400
Message-ID: <20261019200726.15262-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019200726.15262-1-benjamin.cheng@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 220e6264-4b29-479f-0b6f-08df2e1ca9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: zqwkPk0ZXDajY49bsjDceX1+enastmyMIXGbFPpAh89daB/CaLGcBRmbqsYaL1P4CtKGLvJxvJDhketx/uv4KkeorsrJx6j9L6p/QG95FzG5onncfZ1P4gYDmEtf1KoYI7aF7F3K9dZ6cbEkhJ83XN1odaluIgB7S6br3PpOUkVNht0m+X31/zoCoxw0Yr3meXcU4AiDtay+rXg0AwRKfiuXh/d1l/sW+alO6Pj8T1EMkUIOvRSHiDcJR48sKBQePzQ5gkSsCW6B1BwuFYsL3v7SOTBkdA42ct5n9Qx84XwOXbTT2Lg99wJ77cG2iefWMGObUXHei1I8wamJHBhpdv97Asf6TsxIu8vCBScVEs9z8Q1zXQj+Cnf99+eBZV/AFJwkDj0De0+03c6Yemm7I7I6QNa2AB+TdNu8Ht2JIRVeciJQ5jEWYJd/3TDtixb7m01e046VVAy6sLddKBej7m1YQ50R131ycC8X1rnc5Czdwa8OsMnrFCqoDLrkhIm9rx3mAvZaFrVRkjqsX7HkSfzFiM3nL4Oiin7fGhAjhmToXFayox1tS/nBENoMMEsPQnpMh2HKFD/x3zHsiLhkug3sCxzFLfxmaKyB0M6/lq/TJo+2ihLVZnX7eKI6GxMLQA+IQ4+UMNpAJZOg5VtbURahMMC5KV1uBI9LuWHUqsXA4Qinv8ejqsOOfhcMPOqP5vogTbbwfrHXlKYmN5py8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RrRMHVWP4LHIC8ehw30qGcNJpz+mIpCBfRpMDv4zWQJIfGJ7WcziTEoC2yTGkSZ2f+X/w0Urg9EruzytXHq0cJgAZd+y0SgrD231/Hh2l8iXMx6mUg1kZZp/KikZz4SJTdU3i1hWXZtr030h5iygGxxCHTK37jb5Is0seFmOJ4fXhjNOs3GA+SAm9cq0rGkZo8cA4iW92gQirNZb/SAaGUmB4bjVzIxWs0kHzJlKrZKVIZ4mEl2bWZTbbVKS0ypEg4BBVRfTVV3JTF60g4JaLHLxTjNIuDdcAcl1w5tkh37qBGlOti1HA/LSqSwghx2+0P7L9FoNo1U/IxRYrDGwtLrTXar61AbGMDoI0JgjT4q/LYqQDt++/EUW+QlBW/qXp2z/sTzJ7GOQ9mLgS1JhytYbowGLcFizPNkp9jE+Lu+lxbr1PRwHFAQ8kDjppoRe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:07:54.9317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220e6264-4b29-479f-0b6f-08df2e1ca9ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

Packet type 4 is used for conditional memory write and can be used to
allow a memory write from within the IB. Now that the vmid's are set up
correctly (IB_WR_VMID is set to the job's vmid), we can enable this with
no issues.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 87f879a2e4f4..2b0e658b63b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -595,6 +595,12 @@ int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
 				return -EINVAL;
 			}
 			break;
+		case PACKETJ_TYPE4:
+			if (!amdgpu_jpeg_reg_valid(reg)) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
 		case PACKETJ_TYPE6:
 			if (ib->ptr[i] == CP_PACKETJ_NOP)
 				continue;
-- 
2.56.0

