Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C389C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565DF10F375;
	Fri, 21 Aug 2026 16:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXoV2j48";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C11910F375
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YePA0BCjldtAaXEtdRdD984ABwVwvKEp+IB2/tpzXj7hqRPt/iwQvh2Yq6lSfo8MrqITQhmH56OtMg2siH1C/BxtfQAmRNCaKKgD4jDnKcJtHHOywT3g8ACSy4kFpDW8h1zJVOK4+8katcySQlCh3GF2uLNEp2U3vgdkAdF3smMzHmb43kwPzFVVJ/cytYlw2693SDA9odv9ri/teUV7x0lgws2xFcsgQOR6jwW0CYBRJZ5wt05CODNVRx6ml6QtAPvNdeWbXY9WWNt3XwSFQNSJR51SrY0SN0LXTVgJ09hdbnpcxg99NCcL4uaHXuEk13XP6Z+fSOXhmJCsSkvVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36W5j6sflIZ30NHsefGVJ9Ko7hmquWDz2puJnXMF1Z0=;
 b=k5FAqsffn5xjDXH1aB+bbf2dNLqHdvn7WhdEOTmpM8Nr0cr8BAFbG+A9ZgzkDYg69dD39wEOYdmfSgxTRLfq9fctvLssT1t03Wzd1bOPDIC2tg94C9rZ8sJ6y7SM4mGqNLblO88557O6gGf5123M7RwFyqcfQPakY7mQDuhqEzbsqDcg8giLakTJRitRRDn5qT0VIOhZjUZCUiKbGMluF2Njl+KnmdMNNDeXR4Vej/OApl+GQE03dEKHr+WQdVY6iFqkWp93TmsqffvSe/TOIL1pRHy4aqxZTCUE4MDjLtjVQYP7n5HtI6TruKNlNWKUjaU3sKOH8zGZFDonBbTwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36W5j6sflIZ30NHsefGVJ9Ko7hmquWDz2puJnXMF1Z0=;
 b=qXoV2j485lWZL8ZhnnJynu44SGq0jY5wAUADavZcjrbBKqtLBYiOX/t0/m+UwaGsHEOva00jM2vGzDcKQOM8RGtuOb3EaaOZ+7/GLXGGeEkSQt/QnsoNTnCFknKFFQ8dPRTC7E+QHagu31Dx7uk1wzHGiZuJphsulPlq8vp326g=
Received: from MN2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:208:23c::13)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 16:14:17 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::75) by MN2PR18CA0008.outlook.office365.com
 (2603:10b6:208:23c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Lijo
 Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/14] drm/amdgpu: Add NPS_INFO case to
 amdgpu_discovery_table_check
Date: Fri, 21 Aug 2026 12:13:50 -0400
Message-ID: <20260821161401.754042-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b561b8-28f0-4c51-7f47-08deff9f4008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: UhNEbNhh0czlPyk0zQL4TACwxqbaA2n9R6365PU0gikH6/Bn05WrDtLV2b1t1SPN81TT0vCMWRO5HLInTK1d+cohmwjKJGuxfjoV4Y1FL82WxV8Gs77j3uhHqC5YhyDKFhqJQTrP3+EtMfxgs3lfld46GCiXMt8bIqlhL1+tv6rwcMhPcsCcN04olF7GRrnwJ6AUH7o4z6j+CLNEXmXaU5yNJyeOn+TG/DPXkQL004MDeiki0dkGsPX6ckewChvmKMMMMcKv70dsHwnY3duYxGCMcksn3hSgpHJOf7keQOw/sHjDkPEM0aYFgYcMuOM/HBleJidYx7estKlX4AA1qFeReFZ9Kfcb58Sd/C4jomChfFvatFaQ+k3v037xvVxuDChodbrvNi6tI9t6e/YhBVWIR72hV1wdZmfs2Ghu48sTJTRtbMYB08TtfnRMM1NSzQ5vFKAJHMPMOCeabv/nWO5sn5TCFBAvBZbKdE9Dm7AeMRAFQQqCUI+PdgHdkhx+WnWatw/qAchL3/vCkWtlgMTZNIeB/GH/WqxPE0J68aN129RupS83aaDQxUjQ3WlcOzH1Jlil7Q5e6L8txs9eV5Pj6Et97Yad44oIQDGsm/fs/BUtUXbZzohMql8P67COxxwkFwG2CmYigLwAVYqLbs8NaG+w677FN8KpbYxh2g75j2JJyh+CauXwsoKzc5r1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KtZXvg/LcZlvovEOnuepAP3K4G5BRGvixGvyFpMrX10eLeY0Orv5LkrmOL65mDbipgFwfAK9DbaZ/fchac8d45v8k+yadBvUAa7bPr1WWIGP9xO1Vok/Nk2uXMKGxP81J8qDVjMGIAEuEp+RPDr4dD/wlr47a5uu644m+yVJ8PLuPnpg028EKjPIMk/6rJHs427RpWHltki6Y/4sZd1zVqOCaZ38py2BKzt4jhAShuJQzN2sW/WXUP0tEbKYnDAKc+/C8OSWkJ/W17gP58CHyfVerG0oSHIiEFyt4s5U+X54YUyC/7iyvgmkrcPOSRfwXzN/7wMOZ/NTzbetG/QZzHE8BQCPvJXVpzddS3kE0BRPaHYsITHPvz/Fb7L7VX37Qyj4FsfFr56LwOcVLv8PJ9kBoJs9iQEvd4bALV2rqcBGdcZ1fp0yUhU4Bcwq+hPt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:16.7082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b561b8-28f0-4c51-7f47-08deff9f4008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add a NPS_INFO case with check_table=false to skip annoying
"invalid ip discovery table id" error.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e7d40afac6432..af1404ae2b70c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -679,6 +679,11 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		check_table = false;
 		break;
 	}
+	case NPS_INFO: {
+		table_name = "nps table";
+		check_table = false;
+		break;
+	}
 	default:
 		dev_err(adev->dev, "invalid ip discovery table id %d specified\n", table_id);
 		check_table = false;
-- 
2.55.0

