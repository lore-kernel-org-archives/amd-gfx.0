Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A53C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 17:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C038411382C;
	Thu, 28 Jul 2022 17:06:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDF610F820
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 17:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgTKErabOv89rRQkCJAuwSAr/lV2wBzYoxYeOnaNIt/vyEUdwOG9bGTcreXP83YS1ituivX86ZhXfejkN1TuprWUou1kCGRudfjHZO0r63UW1of9IiJgvixmhqr+2lq7/pN+35zjxH1dNRFH0I+BhzqBxAmtQ/yEdjucRwcFkaZUuHbkFp/tdbhQgWhqK+aaDA024C7NfoXJuPLPeXDlNti6MCxfKY+6OSf+ZzAyXZauah7nSGX051jjN/d18napxKgeX2MoSbJcVJdMP6LZfF7oZtN7rLWccOhLCRFeISTph/0l4kITrMIX0xP/ysf+A8NjupPEHucfB0sXlX+23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXKdD5WiygQv3MNiXQqUkhpZGBc4u7DsUTQ6MJg+Xsw=;
 b=JnTD1pC+MZPeaObOjdRlwp+PLN6ppnDCLUkhrjHXLffPB3DXYS44zfXgf1JI1aRs7PdNbPEiiuh84VNj7/Qflt1vokiv/4TvSZf/+nU82+G9qIv2jTg510gKZV/8OupnnLR/zKYk8AGAiriAtKnJmN3+byeA4PuVa7k4erDTZd6hcTRZvkj54yE6YCte0oRQgLN1owIAMPwTC1gvM/rWu/6Y90dEgYbN8gkhfw4daXMdKp8cr/zQE/Wlhn4k7amf63bBluTryLgrgpbrwUlPmng6FK63ETeOJvQG4/O9ZbR1IF3+GJgBuC63Hgb320vHAJZwxff4sJpbL69AA9bPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXKdD5WiygQv3MNiXQqUkhpZGBc4u7DsUTQ6MJg+Xsw=;
 b=BCLO0+Eo5vxBA9Ck0NHKB6voqpHWuE3QQ9roGy8zpNNE8nc338T6XUEKCU3iPEwIUN0EH6/746PJPVK4Meq88tvw0F/dB/zNo+dV9hEbU69XoU0DtLzdYZC3eS3vwq3IpbaadtnjJeByDDN3UvNFop7kSejbL/nlQPLLTtiGOaA=
Received: from MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::25)
 by BYAPR12MB3544.namprd12.prod.outlook.com (2603:10b6:a03:131::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:06:37 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::b0) by MW4P222CA0020.outlook.office365.com
 (2603:10b6:303:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Thu, 28 Jul 2022 17:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 17:06:37 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 12:06:35 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
 topology info
Date: Thu, 28 Jul 2022 13:06:25 -0400
Message-ID: <20220728170625.2724081-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b743bb-291f-488a-064c-08da70bb8864
X-MS-TrafficTypeDiagnostic: BYAPR12MB3544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88+IMqWW1lsgXNHH57F3TMBMlRVylRYSpp7Ok+IfsGA4MmeF9rM59B0PXxE51UaY0mvHH9cMOG5yHah4B+pjOBQyLCH7Z3cXoVb+yVZ9Q0ouANzlaHTBVxDq0HlFuM5+1nS5AmxPrlS2IBPaiBeA4bkeb7G6HuNXjwYfW53UhI2COCO9wZ0CdiqGN1QKdUhNDJmFzpmgDjeYkcPt139HED3P+LcMbSMJ893IyoML7OU9FyZuyhXaKG6+nn3kqCxsvxHvrfZW4J9V2qXdX9nafnpgi3hhMfwmGx4JcTne2Uu5dey8aAydFGko7YAUp3KHSgvrwIbbFRgCx8vK5sczu2Pk+bct9vJiGoZqsGi1tFf+dYgY/bub4a3rPgMTjtZCtAmoEQ+gDDdHLzaRGCHIuk70CW9Uf5hIcCA/C9diO4htYKPcy4Kez4TG6aFQnL8kcdFq+OTlSGiJb7oWrmZDURPxhJ71a99J6o7EZS3wwucvfyCsBnGNJ9/q4hPVdCtDZX+glS9XGtHf5Uedd67rCHYi94J6uuoVAn0X2BbqQTyH+Dge8Qe0tF+Gue4ydJaSfaD9CFSuogfUEU8L2OMR+XyMO+Y1JG5bER4vRg2huN+i7Ea9D9//7yzQ6FAqskigKGH9DnCmUXOaAeaQ46ueqCyzGBvuR6FjPEadh/4qD/6/YKUJr5qCPtzzs1gpAZxDK1jW24Uvv9O+T6iZqH36piy9J44tpBKFc9rKrYEv1zCpe71qRnklDmqOp6h5kBZCIWVT3nud+JoGh4+ZA0R0o1zqR+KIpwdkynYhmLt76ZcwTKzASsBUNt4Z7+MFWd3Pdf6doRdsHxs4Tl3nfYBkYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(82740400003)(356005)(41300700001)(5660300002)(8936002)(478600001)(81166007)(70206006)(70586007)(2616005)(8676002)(4326008)(316002)(426003)(47076005)(186003)(1076003)(336012)(7696005)(6916009)(6666004)(16526019)(36860700001)(26005)(86362001)(36756003)(40460700003)(44832011)(40480700001)(2906002)(82310400005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:06:37.3923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b743bb-291f-488a-064c-08da70bb8864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
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
Cc: Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hives that require psp topology info to be reflected will leak hive
reference so fix it.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ee363bfbac2..6c23e89366bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1292,6 +1292,8 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 
 		break;
 	}
+
+	amdgpu_put_xgmi_hive(hive);
 }
 
 int psp_xgmi_get_topology_info(struct psp_context *psp,
-- 
2.25.1

