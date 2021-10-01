Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0838C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39F961381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B39F961381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A7E6ED82;
	Fri,  1 Oct 2021 14:41:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A751F6ED8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxgMbUdKp1MX2gID3todyrqsB0doDysxZbEL14kTo0S2DCn5KVt/5HCDtipRknRmvnrqZwg8YwnxpuhNgIRVaLsp+ovM32yAcKIP1Av9qrLkDXVfVRbnvqj+AbsVjfa0Onx+iiOVt8P5nxe/TOdVfKHrZ0gLfA57JNoPJjcx1fJ+rrK7jZKdeZKzEd+kLtSMvJH06JpRUXk8ni2cudXB1NvNx+7ASQ+mlOaKHvnfKxpoVQe3QRB4RJxbsLzsoA4T6J8Tyjkjb0Y5nw5dvxFpAh3s8GYjf3w97xd+ng1eamoHS60iE7cZTc9Y/mP6MVU37DtWsewTLtFvJ2G4K6mzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SZrxy1fAb1UnPR2KCxndG6Sz1OpRv11fdbLGXDBlpc=;
 b=l6B2K+wH8iYHhy1SHMyPK+3yM10YpOpkof8B98lXsrX9nMiwacNAKdu42w/6OkVHwyXcZEFUP3njeg7+E2PutFH/czxWxX7CtbUZH4nV8sY0WSSopDJwPlliVvqi8rdcmrPv+d6Q9V7PmzeaXltZc1d9y+FigaHi6BQd9vEVyCnNf9KM7XiwL8SMA0c7OtqAKyNfTmQ1wDWQwXYXImd6PLdQJuCUdmTQQxGY8XcH8tqZf/1xoUTpx0n/r3PLdQMdVPA2PdDMzCO1z7iRNmzUVCGf2OdVquFjYS4/1IXACiOF7n4IWkcE44x5oZjZ8+WJAZ3GVEGPc7i8bJ3VgVqAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SZrxy1fAb1UnPR2KCxndG6Sz1OpRv11fdbLGXDBlpc=;
 b=YQh9s6sNAAwMHOivhKcqmCpIVhV3b5sRVkmBKSq6eI+OaNAndDnuFNhtNHhl46fkdr+j+KoKVCGB8YdV2f85WPAEJvMnMMg21/b70V3QpuWW5klvyhVHVH6OXaWk7Zx163ux4ygR39KbRcItuTkTHzxSWZTbJEwTIlh5w0L7qp0=
Received: from MWHPR04CA0057.namprd04.prod.outlook.com (2603:10b6:300:6c::19)
 by BN6PR1201MB0082.namprd12.prod.outlook.com (2603:10b6:405:53::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 14:41:47 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::c8) by MWHPR04CA0057.outlook.office365.com
 (2603:10b6:300:6c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:46 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:42 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 10/14] drm/amd/display: [FW Promotion] Release 0.0.87
Date: Fri, 1 Oct 2021 22:36:16 +0800
Message-ID: <20211001143620.192679-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df5a7b7a-ad07-48c9-5f48-08d984e99867
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0082:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB008200007D137C14D0B0DB0797AB9@BN6PR1201MB0082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3K3OVgdNRrwZoK1+8m7PMwo0CiHAY75QZgb0uir18ld1/4+tBKqrXdxgPi/+5zrD5znnz8sugYUUvWSwc3q7NUiFE3fpSk7ho9zlim10lIGTWlz5b6Fa0hz40MMp0zDfVdF61k5svi6DXOPfzq1PmyHME1lG71Gby+mouarsTabw4jRsFnKunqpgGIFgKjoygX0FplPnqjqOVcDjFRFUCEF2SmayDLKxbKlKk0nQXbfBLxLBEPLIGbcjiR7vf3VTcKEGuQA7fuA9kv1FAeoqEdzO1m69ebn1JU+vXI9OR8h5UZyjllCj0rV7WttWq1/UVOJaXtjT9jF0G8DRlcaGbn42z5nOWEgRS8pEMDIR+DwRKf4DBfVj7Uo4QIoOUMCg390+NkabH3Vs7YG5qnvMV4Lucdk7DU667QhDQIo0Hk9EQdo1MKCL2EqBCRtu1+4dRCjKjq2rrjA3TcOGueVxnoa47hbKdOilo5QJs5C0qXAffkn2oz/O7LQ6JgwfVkZguKl7LvG6eCtoPik1zNIWunccZQy0dlr4Twhuh1iQlcgIvEBeagrBth4rMWqbhX+qj+gGhW6sr7z5h1kk6TaRyBix1z2bLav0Mc3OgARa5KLwBLE0/yZQcjWlUhkBRqLjO9MYa9A9JQP3YHKCwbVkoCZO2ho5BdHFRECtriGm9A4LyKtjryEHCUSDFVp33wIvu7jvzPvelWV+EB65H08PDCxtTogYQeqgUpV5+sOcKX8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(44832011)(54906003)(426003)(36860700001)(70206006)(4326008)(86362001)(356005)(6666004)(186003)(26005)(2616005)(336012)(81166007)(2906002)(82310400003)(83380400001)(16526019)(8936002)(47076005)(8676002)(6916009)(70586007)(36756003)(1076003)(508600001)(4744005)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:46.7016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5a7b7a-ad07-48c9-5f48-08d984e99867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0082
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

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f5974562aa23..42956dd398f3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x42c0e74b
+#define DMUB_FW_VERSION_GIT_HASH 0xf0c64c97
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 86
+#define DMUB_FW_VERSION_REVISION 87
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

