Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A27FC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 08:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E581310E17C;
	Tue, 23 Jan 2024 08:16:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBFF10E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 08:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJmBGR40GqEXc0keZv6A0QWFQEXpP5xw468g37HD/EjZ4oH/7+lUooyXmHJ7Y6IhIKGk6XqS/tvRVCv5O9ccrvwFifl8Z6pMx2UaHtrFYumMYBhyVynkBTRT62Ya9P1LDieevHAuxoUbD0zv7GRbmfk2wj5AiS3f+EQN6iI0EdtcCXLtgEkI2j6hJUTBQwYxTWmzzQxwABEgux+dYfBW+b4pc3aT8lPUnttRt1SwOv4zmP3Wdqm6cyqFZvgaLpC7N96oWjDQfDMABxod2UHWOdPSC6xLTCnAPG2ha8Aa4rPtAXo8OTt9yKFbmbPkiSLf8ADaDiYuEYRi1RiNJ6ygVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP3LoSef5CdaZ+8zYhbSK6FKK8i5p3syHfJbFh39kV8=;
 b=oS5Yt9YB69Ld34cxx3P3feunMFi20ozAdmw53A+CDhWid4ntggJJS0ubb6cxMs7SsMdvMcdAvsVh1OB8GN1b5HlvCrVX1QuagdQng74hU0iRo2JoRBQUwqEw6t05R/MbRBUizw/f+mUyQ9k4eQSg4u8pyz9AdWZSXt3bwRPyr1ai9B2IfxiXwmjNiizl7sTajt0XvbuC7UFdbStDh7SrvpYZaewgJPy2kutw7LyUeXU6ZD8Cu71EaKBuNLLaty2jRI9oWeqOzQydD4CVD37r15+f/cNmfHkeV5aWCXPlqjACmrCaFeqMFfzrHd9NbQFbR4hNQneYdU1uFKNIeckbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3LoSef5CdaZ+8zYhbSK6FKK8i5p3syHfJbFh39kV8=;
 b=hgNnLVZan9TX22bHiz2sKA3/dQukLj9VoXMrvn8ojLt/uzvLx+0qhD9s1RZr9/bUsxD1do7qOw/JznOQr6zge7veYshhY3rEJxJTtpRUxGCpsTtCSq5pZdh0L5fFyAhF+5zNz+F86tDHpPWWD8w6vafq/NAJz8tOHg7mjZ1N818=
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 08:16:40 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ba) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Tue, 23 Jan 2024 08:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 08:16:39 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 02:16:34 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu/pm: Add default case for smu IH process func
Date: Tue, 23 Jan 2024 16:13:25 +0800
Message-ID: <20240123081326.1066121-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5989b166-c98f-4d68-cbce-08dc1beba00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNo4d544gFU5eNp1jsdbm2M4j+LrTYWvxJg0du9P90EcdZ19MK/r4G5tkaS0389YUeYYrSh7HkHDKlmnLVhLXxvsEsunjXtYIN6DCiiSIeT7A/fEy8Cbe5vWb5YJu5dFUwF4yWcYHCU5Us4xjy/c4ueqOGkPICZWbIaQhNVrtXTV0prjCrs6okOLUUPJgV0pjF+jKVK1KDiXAzgDfA4GaWGOWrG86oe7BsRJXQfF/N6BOeyffYJEXBG2Z4Ia1KQssypL8wUJnogs+GoV6hGPsgKk921IWicyW6VdQBU56qTG9aOJN0hPyG2ORKsShW+axdX1260FgPmzW84+rGgg3USChlPlCiVtDD2d022Gla1wPN1iYjN2yyGoEuwPeoTnOWkd22Vhmmst+zwj/Y4MlDRMdPCahVtF3dAcZQdKu3A/VkxhT/IVzSEy/x9xYFcCmhx23AJW7u/SrBc2IQcRjuDY+Ow8dau98T7lZ+21ohJaiE5Nc/kS94ozDpk52u7ZMz0j4HhlvVSt7zFiDhyVL7FjcTqi4oXBrNDjGvKJVUNl9jpkME2VOKQvXZILdDGQzvY+wlMhjJ0QgolFG1k5il0HniMR3eLbGZkRVcQPo5XJibaWO5Z7/MBzgKR9jhfK2uAUGkNPa/OFYK5SCIzGKLqhYkRTZR5QaOaFR2YeO0+dVFBBdaiHe3vpy5VE8LMUnp0z09tCehug8FNlZdLH+6B/WNBc7c2kXjOArEULipH3jvqb4eXDqkD/GTnV1ywdFfqwWypswtWtAuZrI9MTTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(70586007)(7696005)(426003)(26005)(336012)(16526019)(83380400001)(2616005)(1076003)(41300700001)(36756003)(4326008)(8676002)(8936002)(86362001)(316002)(54906003)(5660300002)(6916009)(2906002)(70206006)(478600001)(6666004)(40460700003)(36860700001)(40480700001)(47076005)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:16:39.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989b166-c98f-4d68-cbce-08dc1beba00c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 lijo.lazar@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add default case for smu IH process func.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c       | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8047150fddd4..fbeb31bf9e48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1462,6 +1462,10 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled context id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ff1f35e823a2..1db74c0b5257 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1428,6 +1428,10 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled context id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..1fdee3c603b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1439,7 +1439,10 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 							entry->src_data[1]);
 					schedule_work(&smu->throttling_logging_work);
 				}
-
+				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled context id %d from client:%d!\n",
+									ctxid, client_id);
 				break;
 			}
 		}
-- 
2.34.1

