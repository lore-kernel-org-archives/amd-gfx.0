Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD24C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077CA10F41A;
	Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3063A10EB2F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACPJoakcfn2AGAwGGmFaZEN7NmmXnMVV2IdTQjBSSkiTbBmk38fGyfSiR/6iov3jwu6Cq8Q9E4NDz58W1oJT+h+p0oJNklE7W+35IKeu8MYc34c95gTiiYjF2lFkYYOjrIsEaPQq4bdEV9gz17WNrLKAzXnaa0jNiH8G3LChDgycJ3QNomEfecsgFwWfUtY0zGFXkBYZzeDfqojo1NgCS7qu7RCmGArVpBxfzFRgb2J+djiq9AVlG3LhFYNwKu1hqm/prxU9qLsKbOzreUip4+5boD6RJazwLoM7S3SVr0YnWIPHvdr+8MPqUGnwuzu0MG8zORYcnglhNF0fo7LOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBvfp5MUfNwgZLjC5LZ+bGkdsvJ7OEm2mo9D+BdSZAU=;
 b=D6gGI1LkNbIwNXKoQfcY6oA7D3KlhAjgYozvOkq6U5Dlp0Lc6YSMPt8OJl7vpj166PF3fEgpz7LcqaFTbc7L4Hj9eoiiKSsqotdkwf6atxN0c7nVq/k7vI1iapBUvkdaXUtZqsAK6cUfHQ/er6qA2vUEqas58K29wBCDv5fX7mbW3CRJn0/IzHGxicInQp/dgaIiKCGlW7obmbs/fkaoKaclCCjgKaRHNIi3WsYn3G/biioXLCuFJDgopNKnv40JoBvcyovk/oKbCxU9vg3aTMDdXTa4n5kNNB8emuWrOjvOMArUOcGppTHrheAhk4R4abv3GWsunIFQaqENn+ImiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBvfp5MUfNwgZLjC5LZ+bGkdsvJ7OEm2mo9D+BdSZAU=;
 b=em/qm2YaedIZTsNXRhXXq5Gdrvu8Spt6xqp7AogQO2vAKoTKRY+mEtjijo+phNIhSneZKdCaNXom06jBlbnpPB3/YSgcQ7Ftt+m8y7d+kz0oQcBoJTJrPQYLu5aBJVcUWuC00TMVjsGNZmEmK8BFeTLtrgjOAcXtxbtAzRN4pIo=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:37:42 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::23) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/26] drm/amd/soc21: enable mmhub and athub power gating
Date: Tue, 3 May 2022 16:37:09 -0400
Message-ID: <20220503203716.1230313-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c5edb46-cf11-41bd-7c96-08da2d44c59b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5265:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5265CBD5A7D43BAA329282B9F7C09@CH0PR12MB5265.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEwljCfsnBIwZ02t91iKeQSjrIxdMZNkVcMWIJUTVGX4Kt2Z2H4c67tDJ4T+grDEJwdTSO2M1Tt/MxLPalf+/+CZ7zNWETIaC11JgsG3az81yS04UtLpcXM82YqU0ulOQTl4iuok3zRFFckMrFVfP36DfK0qnGMBZ8yFYvpMnOhXEGAMmmDop5OEyfPncdYUS39v0cCZi3tRCGKvcs7XevmFVP6qzGlFEQhuakdF0jgpkv9DxS+WHqvpj5r7+oRMAqu06Nym69dg+krRHzd3C5Dj6UBgRkdGTIzKp/Owu/nBt2QX1hoh1kNSUnXLJfeFiPjxdCkt7klaGs7NfVxzjIrJ5YCepguyWQKMLcax4t0cIkRK1fTIJboDJyNQrCm5OwZuG+U0jqlsipPA9swEbrUrgn/zWCDXhRcLosBxwruHj0vN43JRqyCu1pI1qs4/yaAmSDgkykc5Kw/bCAqFr+BbbbjuDjSiMZ6XROjnLQ5MozD19JY7ThglAvE4h9mp/GwzFv0m2wvbYl1GkS+ZVdxUqrtzijvBL3J99WDW+RksJBcdVcrNswMyiyAnhmG67jHz6BrRzY0RAaDzxWsJWnip5PAQX/RBZ/eEYvnG/xAeJjcefGyYxxZdZ5dkm6TrfPxlX+EIXKKyE1hZ/0kuAtwb/XTZGWsLPSd6laAytpKU0sm1zXMSYJNokdop4tRctrXFYh7QcWS15WF1WNgyAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(1076003)(82310400005)(26005)(54906003)(83380400001)(6916009)(7696005)(5660300002)(508600001)(4744005)(2616005)(186003)(16526019)(8936002)(8676002)(70586007)(70206006)(4326008)(36756003)(336012)(2906002)(426003)(356005)(47076005)(316002)(36860700001)(40460700003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:42.0643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5edb46-cf11-41bd-7c96-08da2d44c59b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add the pg_flag for athub and mmhub pg.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5d359b768c57..307a1da13557 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -556,7 +556,9 @@ static int soc21_common_early_init(void *handle)
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
 	default:
-- 
2.35.1

