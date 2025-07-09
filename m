Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C0C83F09
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 06:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E19610E28F;
	Wed,  9 Jul 2025 06:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKUPjvZo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD8A10E28F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 06:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLvtX9vyJUR0FZyELyMnkREqo6D+bOPWzeJyenK2X0LijOsSWRm5C+NGWrm34xnW2GqaIowh7TdzxgNXaLjJf7Nt0s599ESJqP+xnenJBb2rfdQc10pfxyuuE2f7NDSFEMakzPKh4tbbhbgSL3+dFuQgTbQ+eR6wv7GeTFqAH57CPHwhGbNVE7gUeuD0vQu1pbZZDKfk+twBnOfcJw2psybWdcqRGy7qCV8861NIGR45JlZ+KAWhot/evF4tvXNJSATxjkq4/0Wmmk/uhir4Q2d6O7Jfgj7ewvCP4gbjgAsAXyBnRaiiHYNrK5sbMS4zR8+mkeOOQDrOMvlyW3EPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdJgDV4iFN/rEt12FKkaGPYE3DvMTlajvFlaogJ49bE=;
 b=B4OL2RGjR2oUZuxHhUOjKCupU30qA0NNCxfAJT0bcVutVDpHH5iWjPLaMI3Lc6zFxf1jdiF9lzpoi5x/suckKG98/qOwlPci/E81DMqqsvGd0MAcDW5XRvIjAFU/zOvPNpgDwIcfS6bhT3V+kZXwyygrrGfweS9AyqtbIez8Xnbfj5/Wn1pLXDkBwSrcEm93C+VoqBCA4MGE4nWb6ZJp1Rt6AFYofEI00aHYV3FFoD5/FhI7mCEwJYVDVoZf9UwtT3CEhNHIcabmqQZ28x33T5XrrAFz4qOWYz8ADwdAmx0V3RjKwnSCaq8wen5YFgu+pQaQqElpeVg2DHag+1Ks7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdJgDV4iFN/rEt12FKkaGPYE3DvMTlajvFlaogJ49bE=;
 b=KKUPjvZomqBal5PNZgaBiJjnZHtPnmXFWUrAbIHZDInLBE8j4zKa7hWMj4bBmqyPLFT/d+8gMemmvKx9RiBfqOPbmmd09IU9b4WHjPaI6erhoxLlqtHlGaDtUFPQDZ10Gk7l97D2zVNmHCQiUTYvfWdBceQRB1qUPPdngnHiBjY=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 9 Jul
 2025 06:03:59 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::8d) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 06:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 06:03:59 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 01:03:57 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>
Subject: [PATCH V5 0/1] Release xcp drm memory after unplug xcp device
Date: Wed, 9 Jul 2025 14:03:39 +0800
Message-ID: <20250709060340.2365660-1-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fee5d93-135b-4ab0-a2fe-08ddbeae6598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k1ZGJkOB1oXji2MZJVtw+lYq8+gnKAx9N2K7se9gdenE+5m5JSZsTSlooEk/?=
 =?us-ascii?Q?7KTg8HVYRage36giykS3wbzbVdfJOwDXWtFXy/9C96hGDHvxOxPVdTYMoU8l?=
 =?us-ascii?Q?XZ51VynAhLeUNeDrH2nDFjopdWaxAK01tBO6EiVK/k4UlwI3vzQ/g3/QbHYA?=
 =?us-ascii?Q?p0MR0yn1MHeTfqnmzhm2+ZICb3jkCeWBX5bVr2bimDZY+ZgXeHogDrxsOm+2?=
 =?us-ascii?Q?SrphkfFRjuxTuJK3YtZiCnR1xCbA4Ta2jhna/TEWwUpDSnqoBgrV1XaXKiwd?=
 =?us-ascii?Q?Fpr1z76x0QcrcN1047q2wLrgRw0dN/VVAshMrgK3tBoFGX2lhqAFlGjsGD12?=
 =?us-ascii?Q?J9qanvpYPEcicZimEwtCU8mP3USoSnhxJtmiLbv3rmP738cW3ZK1qN+LB68H?=
 =?us-ascii?Q?aQttEfYa2lVe4ZXKIinOeOoNE2zQCrS6XylX1msH3Z+63nqbEInyXwkoXYdG?=
 =?us-ascii?Q?M0Kht3OwWWJp6Ze0c4Vd876XQwGj9Ff6w7+W1inJltSkfBzrEgh2lqiOuaST?=
 =?us-ascii?Q?zgj+HjpiPMamcMxABuTaVHA/vV/mFIg0TMwLJybxd/zg2cbEgR5Nh74XRoWi?=
 =?us-ascii?Q?psNWiUiOprCgD1iipzutGzBZLbUrBBc34Ice33ak+ZSFM0b2VT/LADCjOnJ9?=
 =?us-ascii?Q?pyl2iXhmJHlBxW3MAKuJ6gwIhpczVugWjAr9v69Het7F4LH8PkQjtQkgCi5M?=
 =?us-ascii?Q?Gd8O810C8MKjnKt/oMyZjioYBRmqluJ/31Iq3jOvVT7ZUxsVpQpgAY6RFK2p?=
 =?us-ascii?Q?dafi1dUvjllyi4gu91KwsM/w7//xRZSpfHPUs0ReYhzwXgZCPkRmjuf8PSMJ?=
 =?us-ascii?Q?IxBVdYlVOEg8aa1xwlxnwmhjzz66WDI9momhRt2k1LSfR7nZTopVIIMS6IDZ?=
 =?us-ascii?Q?2a/6Vhmeolt136eRPgvqxWugA6IMXKNJYp4/7hcsaCwoVeeA7mOQzERGl8oV?=
 =?us-ascii?Q?RBfLXFOO1dm3QUtBlvtN2hJJewtpkIVnVzVRmqB2drqeLdWCpQlltxuNfoqw?=
 =?us-ascii?Q?17lCNz8y7HGit7bFfwlwhttpUBY3Eqv1lJYpmEpXj7vRYjfHYWg7uFACz7ix?=
 =?us-ascii?Q?lHWFxYdD+RKac+yzI++eFJexRLiy2FRCfRz3fL3EQ9ROF8Ba6IPX3WitDMSk?=
 =?us-ascii?Q?tTaIjgorfDqJ6qhUnYhIFiFLaC3xElfLFhk/lAgG477QtCjyDIJ6qGOqtGEN?=
 =?us-ascii?Q?60OynyOP8a3g8xkdEWjG4lSngn+DZ1VGLy/SIqzpXQKg2sp/JGPT4MguCyUP?=
 =?us-ascii?Q?H1lQIdIP9hWm3RJtUie+RhqpJBqXF0An8TBTv/2GIv8RSdkluytBz1JKgLb1?=
 =?us-ascii?Q?1FtdBdQ34RcpiIx1Z5DEwuy3UukNRh6fDwwrNMsy/2N9OjOp2Ac8S6+kw7gi?=
 =?us-ascii?Q?nQOUbt+Ie82tjhOB6ySHDoZp0Kc5aUEk0z27NVxklmNU1Eq5weu5i2OA9uAX?=
 =?us-ascii?Q?Hw1c86UJICDu5B8cRdYZWkAEh9BDicbDiXEiJpVpYNfSqVtMcEVi1tQYES51?=
 =?us-ascii?Q?t/d5ON0hgiA4F+hnW/oaZfROw15BppiAvNbd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:03:59.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fee5d93-135b-4ab0-a2fe-08ddbeae6598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

Fix xcp drm memory release after executing PCIe remove.
Fix xcp drm memory alloc after executing PCIe insert.

Changes from V4->V5:
- amdgpu:
- - Delete "if" check in the loop.

Changes from V3->V4:
- amdgpu:
- - Remove redundant initialization for "i".
- - Simplify checks.

Changes from V2->V3:
- amdgpu:
- - Add Gerry as a Signed-off.
- - Unified commit author.

Changes from V1->V2:
- cover-letter:
- - Revise title version number.
- amdgpu:
- - Remove // comments.
- - Add Gerry as a co-developr.

Meng Li (1):
  drm/amd/amdgpu: Release xcp drm memory after unplug

 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 56 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.43.0

