Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5619B10F045;
	Thu, 12 May 2022 03:23:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87BB10EFCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ4pomKklN5I/wmj0H8On+VISpwmppTzeAIu/XOUypdzWoEPuWT5cGb/8cMpkZZL4mOfUSX03OX2eQUf2gu43UnkkdVahwKOSjvvjjFyTsZ+FBa9yEhqXXROvF8xzx0jJcSow2x0dCCTwl/DGLyyqWbu7jO63wJRwEDWNQCWB6j+3XShl92cZlsrjxjQCPEjXP/t67wuXVu+w9PvRxKzlfJhXKDNrJILGBmBLWspEuTGILwIoFoXvqcSF6TiyPSUs1/8o1OSH91JsbfapwoSgGe10pcdIZNpNRPRyr4Bc7xhaUDowPCgAhMzPbUUazXLeB5jSNtE6NYYURQdmTtOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfOtL0X5X4P29wNhYBEYM/o+RwZy0BKuww0JeBbfxJ8=;
 b=SflaSjI+IhnrFZc9D6FhZ6nEsiEqOSKauyOyOxhryQUs0e2G3ByIUV369UCCW8n3jvd4sz4Vb56ZggnZXku2S3VDzZhU1yUxl9fjZUlGY9Mffwa04O3yOD075MH82LxTJ+rGRN2FqL9lXauy2zxo3a8xSG7pPl17SgV09PBFdU4boHXoCR3YcrkPbefMFXXCbpfn4uSUqdG4j8c44pAA6orXzXj3i/wdb8Riu3G5dOU/iF2pDPd1k0HozKeN5YJM5CCJqrG/eegDd3gRq8BMsljeaXa52rdtBUsg5O5Gk8Ehxlaq+siRCEfv5UD4mxTF5w2NQyjAVYUfP21yFwHyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfOtL0X5X4P29wNhYBEYM/o+RwZy0BKuww0JeBbfxJ8=;
 b=qzVDAOyiQNxNCk4dsNUe7yQky8ljd8gpjQnxTU6UBFzt7oehpMJWQRz2Hdbqw+gLCnjMwPeLyzjs0WMtprPn+3RGpHycE3cFO9a4SAIy0kqd1y5bAlJIkON5Tzij7+ANLkOhNre6IVhGyrQ8KaGN4OIsgbE01ZApNGZfkcHG0Ys=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 03:23:07 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::80) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 03:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu/pm: add GFXOFF control IP version check for
 SMU IP v13.0.4
Date: Wed, 11 May 2022 23:22:45 -0400
Message-ID: <20220512032247.528556-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9776b73-0566-42e6-d4b9-08da33c6bbe0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4570:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB457029DF8E50CB9A9EFAB214F7CB9@MW3PR12MB4570.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvNN5pd4INbQcZ8aQqEVpsEIgdpVbIKcmHWPS31y85aybB7dUChNyYU90TVsQf48ImFxWwfKNKcncYf3gh08FTGun3bQPMQFM/6NLwuZWNkCFQo0XTxGY2wupI3aCjvl6utlLrjOEjT7ioYpfLRkQJ0fEnK+YNRq4iVhIKN5kjFugEvTVq6AMbVVpf88X+KqmwiDjydExrgl2MGeaWwon6AHFik9MMB4filkZ9vENKOKkDoyX62cvkZwPDWxZZH3ygOyxyD50xRzmAjnQZGD4kB7DZW90vsig5uwS5gurWEh96lnM0AH+D+RX75YUK9UawXqeYKH1wFwdYsWVjih/n4NZcPgKkcNo7aQYOm79WjPsoMBCQK90HY2qH4zj22MiI7ybRgZetYAqV2JkmR8dEMHLKsCd6YTy0h93ictPKyLwHZl7BdbdRkoMqBe3I4P9saVwCq0oz4gxqQteAyOqO0f5/OfCXb4AvScFbFJqNQeBegEsKKMTfGmKWxHI6cRj/Ownn4BpvrnA660Kd6FDZXb9CBmMcZggbqtZNguw342yS/RJO0tEASHsU7jFb+/utOcikarld1hHw2u8liIo1kyk4+M8LDR2QAOV0DS7sp5DfXGylwEjUuDvAiD98yemph+7mo8N683e0L2z++BOxI71kmluwUQDRLWqEUJrlj6EoXwPox81B984Q5fOzFAVVuxYDIsPBEEnMTLkyXjcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(6916009)(6666004)(86362001)(4326008)(2616005)(26005)(8676002)(7696005)(316002)(54906003)(508600001)(36860700001)(356005)(81166007)(47076005)(186003)(16526019)(1076003)(426003)(336012)(5660300002)(4744005)(8936002)(36756003)(2906002)(70206006)(70586007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:07.4024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9776b73-0566-42e6-d4b9-08da33c6bbe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Enable the SMU IP v13.0.4 GFXOFF control

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 14a7eef0b15f..ae6321af9d88 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -836,6 +836,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
-- 
2.35.3

