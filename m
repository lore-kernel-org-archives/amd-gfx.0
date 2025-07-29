Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E735C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 04:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96B810E5C0;
	Tue, 29 Jul 2025 04:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ag5GPZ3r";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E48910E5BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 04:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpim8p4X4JIrEQdhVzzxi3mzCROWoagQdQL8gBOQESG2dZX/gjXfAgkn6EeGmBkEZR2vZv7nbW0LJiyaIDnn/kCPq1PJZWSdmAx1JOfaYzka/h2f7+kYXSsOdP+tdWbXoCQ2METq5hm/MrHuRgx4X7tNX6mhu/IunlADxSuVsjcmSWj7i6/j+VSDTXGSd05DPAR9wEFAMbFQcyPguyAu9cqRqlkwS8m5cgSpau12UWRAYHJViQndoz9g/9QsuT03Ebjkzu/sZS+2S+jBnmLEHF0LC13TnnrO2bvqxL4O3mKnclij6i/irv6l/dhCVHjX/QPdwQLnB16u9d6eYLfa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dACL6/oFMLkxmTrc67FTyW5Bt8CAXakNdIqT02y7OB4=;
 b=KNNCt4nauOttbiuvGFI2xwZGSo5tDgxbUgpmX6G7dzg1uJpdwVzN+rXA2jK6a60dyQhcY+fa5Q8wnlzqU2X23dAlgw6PqE2LY4wU7DUWID+BLeo4InEO6y0XGGdepcijTLAM+atSX/oUR6Ive8XInfUaSccie7sCZrTAvP3CQqJjjiqXDXIIHF/EPCjS97cvwr4bQPycWFXyAzX2AlAf7JfUFVBhsHnjI+5+YzzHr9ScjhnPP/L/WIAcYILYCxlb9XrFI94AXG7x69lS/4VnvUfrMYaJ0dcJVPXXjfoj+oVURcw/uFaCCUe2kdFXlyLkz9xZi3WybaWVbRW+H6pY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dACL6/oFMLkxmTrc67FTyW5Bt8CAXakNdIqT02y7OB4=;
 b=ag5GPZ3rcKpuiserQKIfroMrlnijEHRXOFN2F2c++pLm5ec6TOBJFkbeE0NmNYzlMhzWnckjXnLdJjxpU7H5cnIfTqvWExBueU3DEC7Rdk7GAz0whF31kjmxP+cSsaBmdg95RdWuQOnNuP7A/myX9Rx414wYraTh2KOQw1aWFrE=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 04:20:14 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a2) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 04:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 04:20:13 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 23:20:09 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, "Stanley . Yang"
 <Stanley.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Initialize jpeg v5_0_1 ras function
Date: Tue, 29 Jul 2025 12:19:51 +0800
Message-ID: <20250729041951.1487367-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dab8a8-dac6-426f-cfae-08ddce5736c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xDKcC/YvyhU9EVmozq52bGRwgrTIkpDEOdvRSdhCHkG7Qr+2Y+UbtlibQy6?=
 =?us-ascii?Q?U+6vF0f5NOAVaobEsg0TqwAK+OaC7KkovgIZHVQLsHXxhHEtIEIHhIA1uPov?=
 =?us-ascii?Q?tw5eE5ewmL+kw8RZWRDNhoLY2AfDJBoa6MAuYneUvzGd+TUyULCMCjOaks3Y?=
 =?us-ascii?Q?kOciQ9sQYHPSYpxG5aqmDZel3YOKk8LEvgqXu+wjgKovwf/MfJikkhFzFOw/?=
 =?us-ascii?Q?AFL3UU8TSAfthBrGel3Ig3po26LGYk0C0JoYc7KRnxknJVj6lZ7geOt6+eHE?=
 =?us-ascii?Q?l5Hk6rUdxCTfM1ExL4Mg3iLvwFmf50pw70F3ThN6p0TZAiS3hoef/edYYRxL?=
 =?us-ascii?Q?G7WNkIxIsntOhq+CrUlgBpno7RQ+USssxE/QF5GSy3mzXvy+KOO70y8n032o?=
 =?us-ascii?Q?0cmnNS2wkrlGPkATP21SDQVvVcHRCqMy7RWwsEXOjXGmawUf+Zm1K/RxOpxR?=
 =?us-ascii?Q?HfJPNwKYmp9cyHqSaG5janR8bZREDtok1dpyxyFO6rWztHFo3+UuP78xrPMM?=
 =?us-ascii?Q?4+rcYg3nH84eqfp5e0QZL2CPiJiMUzIxpdFLXkuAXMz4n4qbs6yRx/wObxhn?=
 =?us-ascii?Q?qhArApjKMUP91MctRcdLceqqSTpRwN+lVrzox1f2hT+ToG8Oxt0Bwk2t1ku+?=
 =?us-ascii?Q?26hQ7YAsUEAJAEqYmv3dP8VAGjoQ4MMhdr9Yr4P0xDm+9MDCYFH1A1XOFJNU?=
 =?us-ascii?Q?ZgnKTe3JcA2cI6eCuHjrDGJmXbT9xYSEvHvAxIxn8dOgsm0a4Uf/q86g6DgO?=
 =?us-ascii?Q?UKr6wJrmFb3Ixya8RC6Dgn5kmuR0X4AHmcMJRJLRjYnis323arbZJ6zEZ4Go?=
 =?us-ascii?Q?Yz2jR3woedo9Ekv+dFvJ94z1d3n+V2UByJcNyj4hqxAmCC5ipJujEl80EsGp?=
 =?us-ascii?Q?wTB9dEFbBo2PSdAoMD0K2peiXG438bk+Cb6himXy7vUf6fuiHqPKK5lG9Uwn?=
 =?us-ascii?Q?LwG2pW7Y3hD2//EuE0ztvUnSMTQ2B86mMn7ERcmk//ZDof5D/OWsbco6EiRe?=
 =?us-ascii?Q?K2A/MZcXtytezKkPyP7sqbKoGWruQ/NLI1mPNp+b712du04Oc9RAMpq+dGur?=
 =?us-ascii?Q?q9GBPLyeekOmrfteYJXenBt2i9nzCVQySLlmMCceOLNmwFmRCpN74TmPlSka?=
 =?us-ascii?Q?rmagyOMaM9Vceh/gUv2qcGZBeFqukA8IFzZCRomaSmYyWV5r9SSC5olMpo2x?=
 =?us-ascii?Q?N1GtLvCy02/BalHmeS8uxYL3ORja1r1y76WOxV8p4t8H2HDwHvpGl3sLjJ0w?=
 =?us-ascii?Q?caNFXMOYRg4BXqBFRIQ3fu/lUluAxG1vfltyaI6yBWhZYxtVQAkvPyAkk0DP?=
 =?us-ascii?Q?P5ty/wH+raY/Pla4ohiGWhTzBTLx/laV39ZYKCEkelfKFZi83FMLRhRhia40?=
 =?us-ascii?Q?X1cUBdqXNhGGm69G/jq7nNHcDVFpaV3iwmFl7PuIR/TC4ADlLxp0w+E7X42p?=
 =?us-ascii?Q?Hg44vACAcN8IqJUDtnWgN8RAllN1k+c5+nJtSqr4E02AXhP057Ji6LWaIxGd?=
 =?us-ascii?Q?hfk7ad+7nWp34Dizy6Kk65EF5oAMeG9Q0M6x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 04:20:13.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dab8a8-dac6-426f-cfae-08ddce5736c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

Initialize jpeg v5_0_1 ras function

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index e622db1f818b..af4f562db32b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -196,6 +196,14 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		r = amdgpu_jpeg_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize jpeg ras block!\n");
+			return r;
+		}
+	}
+
 	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0_1, ARRAY_SIZE(jpeg_reg_list_5_0_1));
 	if (r)
 		return r;
-- 
2.34.1

