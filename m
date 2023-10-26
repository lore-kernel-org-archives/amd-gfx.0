Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3589C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDB610E817;
	Thu, 26 Oct 2023 14:21:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D5010E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDYw9hjiWkVDOsYQGPyf/AbXs/AF/Q/w6n3EO5fu9DqpY50X5qrcd17yh7lpZ7AJy/zo/Rlwt2Y/KBt7aZqcvBuJXlIkLD7XeFpsyS6GQguA0Fxb8k8Z4fYlNV6sgwvAfeGVjd7qcX5A8UCdm+eOazu6q7YUCrtVqIyi1fB4zZ2qw13WwupZDLXf9JCWZ2oexPChreKVq5RoYmjqvAjYpdzBPZNHN/OKe6rxrsE0ZB2he/HZBkBbWeQikBr36N8Fr6KuQzXtYnJhICi4t41kMvLi8BURYxVkS47uWKE4FljLStovBztQDCOnWZeA4tph6fmMVCa6wmI5FTBkWH1Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnvaTSRxMplEbqiM4Y39+Cke6SfMEyhGWVSD3/XfImk=;
 b=E4kZhBqkG75PNTDHNHQzCpIGO0P9+EvIpejkoI8w3y1FrIwiEe3p/+HsNjmR7IagOYUAGQNE9Ju9Pd3jZHth2TSmB25+E1XnhATwRhKsv15IpALwVQoEma/OxwrOGHNql1wDm9byaRA1GP12pxUgOszOcK7ri4FL2Fboxnbzp2mOww4WQTvxkOGG0BR0jch8oriWDYMSvmLKh5axoRVRDLw6BtgwyUnJ+23Uoo25oUKw/A1BJfLKF0yltZ7fb29I3TSadU8ulxMZnhBaTFAHA4tsFV/Kdh7hxUutKG5TUMgpmKIp/19FdCRZP7JX3rC2gLYYCnZHOPXgpCSyG8h+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnvaTSRxMplEbqiM4Y39+Cke6SfMEyhGWVSD3/XfImk=;
 b=dp4Y2l3kNGD9bw/q4VcdXLQCpcJdIaLbCsEKxyikJ1wU2oUShjjUH33ULRqDDdb4p4Ew3s47TF1g+k97YjKs+T06awhsSZBA19pk6+U/3yhQeMgH/Qvj1fxcRV4XRYHNVTATQEwzYCBnETruMLD+q3XKBJcdxZxrj+XXt+vAPtM=
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:59 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::fe) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:56 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:55 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/25] drm/amd/display: [FW Promotion] Release 0.0.190.0
Date: Thu, 26 Oct 2023 10:20:15 -0400
Message-ID: <20231026142020.67861-21-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6721ac08-5149-4898-423f-08dbd62ec652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK2l1JMrp5Fqn5//ED9N1wWmeoeoFHBZDjCiTa4JQwAV4lmmRsa5UJsyTFY9NTE8PSeFkMCdR7ktN12CLo4L5KAO0h5ryBHMyGGAAIMh0Zq12uGB4OBeXKlpZmXf7sXMHSVtkcoF54ddAd9pqWMidUJaDC1ZV+/yEQY3Jtd7RdMxost9uPcwznMyIwJj7O3lj2vcXyap6A7KNJQc0sFF4mfGoSfFxajYUQ0wFhWuAXmkfGhgd+fAr1pkZz2CVyS5QdLU/7u3Khc2SZT0i6sAxGXSpA69VMaX/tG8zCd84TwPtVuLXk9meDl+8TDk+ESQZ4LtmDhhFn3gg3Cg81DhvgGWcgyhuSYiOnzmTrRY01/Eqzyn+xw7WfvqfSOYjLfd35HV9aE1/PF+X4KRoAAsqjQ8GD3F1rBLAompDEt23RZI8kBlYtR5LcZzQVWLfnHoP0wrjjoIlvxYxNV+5mY3mG2e8NjVPVbdL69H9pdMvFqjVm/KvJNaB7d7FsWgNHFiWjfMqwpBSLzSD7TIjHZfCuKdRTIpzaABRALAQZQjcq4PXScJV3KRMzzspe0hAan2pUxI4as5Mylg3tw8FSiXRXuik3q6VHvhpHpdhRLr2cQ/4cNMBPChOF8vousmr9g0D/+7S9Lol8oXSCVIwfJHQLcpQWRBLjghony3PMGW1+IZpMjWUJsK3ikyFbeLVhpaNG6GunJaew1MCwRbWvh+IkdWpCimU3k8IU5KVOsXmDvu5K3UfU5z00q4B+SG1qUjmW9XmsslPwUvy23ksjmiKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(36860700001)(2906002)(86362001)(41300700001)(54906003)(316002)(70206006)(70586007)(6666004)(478600001)(1076003)(81166007)(6916009)(40480700001)(336012)(426003)(356005)(83380400001)(47076005)(36756003)(5660300002)(2616005)(8676002)(4326008)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:58.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6721ac08-5149-4898-423f-08dbd62ec652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Anthony Koo <anthony.koo@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Increase number of bits for IPS boot option

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 61b4009c3b76..648a6e484523 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -655,8 +655,8 @@ union dmub_fw_boot_options {
 		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
 		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
-		uint32_t ips_disable: 2; /* options to disable ips support*/
-		uint32_t reserved : 10; /**< reserved */
+		uint32_t ips_disable: 3; /* options to disable ips support*/
+		uint32_t reserved : 9; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.25.1

