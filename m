Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B73C00140
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 01:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEEEB925C;
	Tue,  9 Aug 2022 01:31:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075C098F65
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 01:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr9iDD8E1noS2FNmvx7C62NfvD/fiE0GO2/+q8M1RAW8flhhc/4YLzJe9ucXKpoW0HyA29OtiHuiJ72rfVUydX0SPRrca3MGUO8pljQB9PBn7MIFJ3m1w7RmRwbDlzkZAKqgfibVJLM2xk7jHcqCXtR++0D3GwPjPSCWj3LH5Eh9m3vnacq9ZL/HBd5KUlbAgv0Qq/K9d43uDScjxKGngzJhQi1fjF1stuO1In/UjqfkS1oCo6L40vTSbDZbGJ1Jb/feh8kwKiVfdM4phe599sxrjIrhvSIZivRy8KQK/L3uGMqPDqvnOAXnhgzvqP4q06hMqogC6OBQdK8zyOWVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJqbUDIw/cmPthA6eacXVGrgfMtyafWH/RGzosDbD28=;
 b=E4N7m/Xy6Inj3UER7Zxo/fwFCAhbD3920eDvQkjuWhp3zhJdvdkUWw3ZUTepmBr0PKARxV5p9T6zkfgY5wgsMp6UE2aA1xK8mJ0e4pUEo2Riwr1T2dUgZ5YAq9BN7qvwKppvBxYmKhzZ5q/dFLfc2jcMUp6wXCrzYZHXkBe9tVK8J9MT10v6M2bdbemg/Z5Er8S7gIaUzck7JHmb4AxhRDI5IJhcqVKeV+/T4dKWHql13Zzrhj/wOUZxgyACSYgnMXQ0eNcplyLjGVuisy/09mbjLoWJYkG48VT+dGcYtK02jqFrJsrAaN8XVXbGD8mIMgGzfU0O4mTlp3CfGHxmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJqbUDIw/cmPthA6eacXVGrgfMtyafWH/RGzosDbD28=;
 b=Q+qqutn0kXyTJRaF6Hgcsvgfb/vGOOEAWD6oPG98TCg7ORxWE0gW5lChtnddKKAe32y7BnEBezj6QzPUKsBUB93i9nrpsbWuuO6yeRVL4nSC8n6qnwIKJeq4jfRw+Dz78nDOyl+pidGjijPwXKW0NtXMUz4SBBR5wDg11Lka9Pc=
Received: from BN9PR03CA0934.namprd03.prod.outlook.com (2603:10b6:408:108::9)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 9 Aug
 2022 01:31:27 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::4d) by BN9PR03CA0934.outlook.office365.com
 (2603:10b6:408:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19 via Frontend
 Transport; Tue, 9 Aug 2022 01:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 01:31:27 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 20:31:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add 3715 softpptable support for SMU13.0.0
Date: Tue, 9 Aug 2022 09:31:01 +0800
Message-ID: <20220809013101.1751952-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add03b2d-0811-4c42-c4f6-08da79a6e136
X-MS-TrafficTypeDiagnostic: PH8PR12MB6673:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yj7kFBQsjQsXbB5JKWQVo7eLIbWAWab5+0t1JgUX8/qYqFG7+/6hRh3E4yVV1vSeVONQ1UTlxbAcjJ3ityH5F8s0i8J09Qs/pC5g10rEc6lYpRVLbfy2bdAzf5Ur+BcpGXUQ6OTA/Jml3RPvaZlhR/xsgHDypE9fvFIUk43rT9CdGZDc4Ext9ZMcrYV+zJZpytrthTPiX2ySWc2LRbW+4JlHwL0XB9HkYVBkeECBWbhxf/0eq41sNQnAA/wV1buGRXaMePiUI3ImSdXfK7/+iCA6ysyFc6kU7HJTZ1KSpIyY9d62Ud6znxPQc7jGau7EVuHn2r3vESCKvaPXcqzxaXh65RnNUQ9GLuubQ5dwl+Du3dfjafE+W33BLfWnghTBNEJFjvHaBARVThVm+uGKYtWwEXw0PNHgHAruhSQgx8ru+NEII9qCB1wTpnsmCvwyjkqRvK3QbJ3AkD1IbfhXx0QH7L49S2jgzdeWUKsb5tBHm66tRwQAXipf4SgMirxXZOU6oCGerf8AZ8eUg76QOKYstbnCN0EjUZvau9wQ8cFyka5AfCmiFdUD1coa7LpAHJSy1mdT5BueHRpoF+Ma2+DLXU+I1TqlpbN6Vf5YIyNw9V08PSiqVrw7Rosmu7xJ75UuSIeSE3GFiZ/Lf7JLewdpATLJImjNo7xO/4+sqlJvHGC+8aJLJI+yfT7JHrI0iOBwURt8TiCKJ0eWxMs6uViYy6uwsAjQ+KJsKVSR/tgmL9P48e4mPEp7R+dcSaJ0VDieQG7bmps6EF2zWNDqDoBWTvSYCuU36ohrjowgaHS0SwLI1PAznNa4mdb//nVqkPwx/VcTnTvBxTfJ4a7PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(336012)(7696005)(41300700001)(426003)(6666004)(2906002)(47076005)(2616005)(1076003)(26005)(86362001)(82740400003)(40460700003)(40480700001)(81166007)(83380400001)(356005)(16526019)(8936002)(82310400005)(36860700001)(5660300002)(186003)(8676002)(4326008)(54906003)(6916009)(70586007)(70206006)(36756003)(478600001)(44832011)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 01:31:27.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add03b2d-0811-4c42-c4f6-08da79a6e136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for 3715 softpptable.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Iae7360ce853a6b5fde38025d528640c9b88fc54c
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0370482dd52b..cd159e240147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -229,6 +229,7 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
 		 *   - use 36831 signed pptable when pp_table_id is 3683
+		 *   - use 37151 signed pptable when pp_table_id is 3715
 		 *   - use 36641 signed pptable when pp_table_id is 3664 or 0
 		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
@@ -241,6 +242,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 			case 3683:
 				pptable_id = 36831;
 				break;
+			case 3715:
+				pptable_id = 37151;
+				break;
 			default:
 				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
 				return -EINVAL;
@@ -478,7 +482,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
-		 *   - use 3664 or 3683 on request
+		 *   - use 3664, 3683 or 3715 on request
 		 *   - use 3664 when pptable_id is 0
 		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
@@ -489,6 +493,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 				break;
 			case 3664:
 			case 3683:
+			case 3715:
 				break;
 			default:
 				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
-- 
2.29.0

