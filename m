Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC2C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 08:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7451910EB73;
	Mon, 22 Jan 2024 08:43:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D9E10EB6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 08:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAEBNgfQvxIwrEG6/XIMjt2SVcIH0ALUwYL2DUKuDE95zVVKIcqOQnGdXtjKl69RCuqITnlwVhXFIsMZHTe/o2UroiKHa/bj5eBh5f7ye4HDeak9af7cSJ+E3XvKahJrcQd2wNxpoFWS5CyzszcrQS0FlV9eaM4JqenxypvA+3oLqng63ETwuTLZ/uraHIJlF1Kqaoi2V0bAyWSerD3hFLmCoGRjMuXbIwST8A3y22p76dlwa2DBOS8dYPZLYfaetnbnD+Jf9glf2P32I9AXyg8NIDcf7Jpu3JrJQZHfMqJYQDLAZ70oX42HRurqWIzto6Cmgs1owv+8cG+/OfWe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJyf8yQZCaFF4jsY5HxoOHEE4i5KQMyg/YxnDRiANdk=;
 b=GVcp/B5LZK7YdPArc1fpIuLFeL7wP+aPXP0HzssTHdFsjVi0KeT00vH5Inn1x2bHJrhXbi2cF/ys3tNt3bVUb24BKxAq/iZW0QGKIUGPW2TXiTv0IPI056qbDuYOwq5CCD4LoFTjfsW0zM+wj8JIc2+DA3efXSZ3pNDvU5D8Gvpbjaq1EywK0Uj3xYewHYOEeYIyen1bRHDSig/n3mUZEiTKyFlsHE5al+HxLdAs8AOw+AHuBH/qWDd0NJswhPIKPE6bevGsiiNvaMEzQQha4Ou1wQ3igVhBaoAQFG9t6ydLejiShtB6Z1evouovVxtC4qjDvvMIc3XRHEAv2BOebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJyf8yQZCaFF4jsY5HxoOHEE4i5KQMyg/YxnDRiANdk=;
 b=jF+6+6AR8yZQcCAMiKvCL+BV685pmwFkXhJbdlXLfBQdcIUh4ZIbcmdmt/7C84Wr1k1PXSM2q/J1t/3CFah3GUz5wUAC2r7+oDK37qPe1WPO57aSkxOn8XO40xlnZlvuK0zcPbCFAMWRo1LyqDTKPEQAT2VVSCAsV0MYXey07sk=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:43:17 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::95) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 08:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:43:17 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 02:43:15 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/pm: Add default case for smu IH process func
Date: Mon, 22 Jan 2024 16:42:39 +0800
Message-ID: <20240122084240.1053190-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: e41cf970-dd1a-410b-721a-08dc1b262e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk/hLbANKXXvWSzndZ4wm8HHwzSL0dEu5p4enayM40jpiehCLiwaBXpLuX+v3kD4/2ZJ+6uUzqVUef8P9TJLpDNH7vBga9N6thLUqVJtWi9ixP+tk6AK+1O1b6UMHQohOdH3sflIDDzHii45Q8U2Krgl38y2JobvXU/QwyjsI+B98f+zQgorsp1fCmNaRQG2Cg7Xtj1y7GLc1GwEAG4+QZerT6Ojwjl+hmLmFti10QYqSWTyy5I/Tzkz9vg2xu8qmbvfshRA/7lkz+lE0AMnNvckjeaTosGNFR5WnoeBvMt54j9joOeSlmvLg8ET6tdinDcvmYwAT20uIdq806Gx3UuTljgJqAQnrrrx6clc5DKiyJHJed9px2Khz4X8rl/+h3R3W0WKwOrOayHffo0H8pabLekwkUWoV9JyQ98hxLUROdMCw4oSKr+SK4lkvUdILj7i2pnneVta82yE3gRi/4EruLK/nysJY07NnvFifxrUTS3BIP7KUj+G5uZUfob8N70/6FJxdRgXJs+nwaxe8nG5ZwjqgCHvKOb8LDJQSb63MKmgsdswiFgzSt82vQwye68U7yuwW31jGD1488drPnVXiueWlWeTaxHOb+w8HKkTOx/Fwpd44gQVP1X+tFByLpCSfYHZDJNYshkfU/Nbcx450dG7br+EJSdv5MXyn4NZwwkVylaBRgyOjzCrXP+TBlVb5XQ8JzosqGBN/mCJNGnuunrac5vkx98Dmh1DBT0r93BCw/knQqDzVx7SnpIIgd/Xtnn4QSB9io2DdQXr0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(41300700001)(336012)(16526019)(1076003)(426003)(40460700003)(40480700001)(26005)(36756003)(47076005)(36860700001)(478600001)(2616005)(7696005)(6666004)(83380400001)(81166007)(82740400003)(356005)(6916009)(5660300002)(316002)(54906003)(70206006)(70586007)(86362001)(8676002)(2906002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:43:17.7785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41cf970-dd1a-410b-721a-08dc1b262e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, lijo.lazar@amd.com,
 Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add default case for smu IH process func.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c       | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8047150fddd4..d74343adaa5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1462,6 +1462,10 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled contxt id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ff1f35e823a2..fc7c04e19b18 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1428,6 +1428,10 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled contxt id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..bc1242477002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1439,7 +1439,10 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 							entry->src_data[1]);
 					schedule_work(&smu->throttling_logging_work);
 				}
-
+				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled contxt id %d from client:%d!\n",
+									ctxid, client_id);
 				break;
 			}
 		}
-- 
2.34.1

