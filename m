Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48627C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 17:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F394710E1FD;
	Tue,  2 Jan 2024 17:30:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4533110E222
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 17:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfj9VMMM4XFC3irgnWw3HG6bY2+FLah5L8fVK5SPNvyzoLXQVhzTezME1tC5NwJFFqvWzvYepICBOsFMe2SenKab0MBAexoL2W++H39Ox+C38hEUz60IOcAS73tIluuyi9ALCpdyKDyROqaL4A7TjGsNS5PnCAMOk7goMkxK+Dg1pOArG2Q1ZYkQ4P4739CweMd5pu5ZYi/Q5rhzZorIkuQW5+jdyNPIXYbuOCPflwJ3uc5Qe7xFZZXSuIwmCoEIYPAOWC8WCrHwtgBAJlZ+C+R8ULwzywy0sDTGyJeTUctQuRRreIPSoiez7Szq4kpFhgJ2FJZRpYgLk0vkVlbdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLQF1yqE378loMlINts/ztCaceGeoEW0C8Q8/WDikRQ=;
 b=PWUGTdhvXv3sw85Q0TGKdM+HiEiCljCOjILSaZRyxWPOAhxS1YI7TMEdBcgmltrBgPKIkewkPxv7ddmBnui6+oI37jwx9WD81sQK5NlbQyWPNRd4QCNF77xiPNNdoQ/dEaMKw6fQmBTf54haY9gozG8PxPkpdbkMJq92Htp2Kb3tTuyJRsr1I61nlvY3lR22sC66W1tBVm4DP6DA9i0tOiqK0cMPPdJxR+Rg+Ye2+53DYy7Dnpm6qsfHQoCBgBWUUyHT9mDdXA9ggVM87pPevkuCF37NT5jEbN4hbRb8TQV9hgfotRRHhWZe9wzoyFaj0WR/rdzTEh2bGWg3/sO9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLQF1yqE378loMlINts/ztCaceGeoEW0C8Q8/WDikRQ=;
 b=QHpT1ZA8t89Ln4wtLtWYK2/dDVEc6/yOTEBtLW1+P36Fg/QfkYZ3zwMVM9o7z+d89kTu3LkWwMgzbUztbruSDSua7HoSQLbH4cgFmqjvfy516wJzLzumI/cw63sDhW9M5EK+oeZmgfL87mEA1qOAuo3TZfIMWbah3yYIJDU0oj4=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:30:35 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::45) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23 via Frontend
 Transport; Tue, 2 Jan 2024 17:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 17:30:35 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 11:30:34 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for
 gmc_v9_0_vm_fault_interrupt_state
Date: Tue, 2 Jan 2024 12:30:12 -0500
Message-ID: <20240102173013.5543-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102173013.5543-1-victorchengchi.lu@amd.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 7944af50-8eeb-4740-8e7f-08dc0bb88756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcxWucG5p45CgyLVapwf+t9b3vwztTUuZQGKV4deYfHWRWnTgSl09eOlPQ3v8mlwiA3/tQsgpJCztFbamZQ1rH6X3EENBX5dFmdmT5GaEpKU/qkp3h+BCpeZ2Pzjrd0byawH+oHDGh9IWB4W3vpmj4hHGbdQ2o4YpNJ6J/OJryfOs94OB0sxONivOge4n5e272Eani4k4hVflK8HlpdQq0L9X1LJFp6ZwYoaCwzaF3a/pMqNJJ/eGvTGrqsC4X05J1NVPaRRFl5bpQFVw0LK8SRJPAKetTRppaJ/gwSpGekX5GMHh0VOUYuMrF13q03CvoGawBikDOQDq+1t78npGTKLkD6r3C3yYjkibVavtZOtQrj4R3oS/C1OwoH9lxQuk1ASugldzcRFEHtuHgGmV4NU2wUq8DU0E4PmnKrky+Ma62YlW+M5NJFsAzoSqLkQsxOZC5QCCmAcGI5Aim3qcw+rzBMNyB+uMQMLCFIIli4Vbje2M9rGFDt8i7c6/g5Z2KBGXger9TcbHwbV495CmOem0MVh6pZ4l2xkOMMwVKXK9+2+eQAGsYSePIvNScWtNF/NB23inXDnOKUxZgMDaV07Y8naY0zIEdGUUW5TI6Auqx+WeRmEzaUzvCZK2iQ/uZ/ukmXWxgsDKALGZ7Xa7dEIOYK4J6uz1+s/RZABBDcMPuI4dpyi4Wv2YGSoMIJg3QRpfknt9KrYxrVuMPLS5ljuzXD31DNqBb5SEA/MCsHc6pkhiT+fMxasTjjnaNBV3qBAJ0m26+nACofSJuH2ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(47076005)(1076003)(26005)(82740400003)(83380400001)(336012)(16526019)(81166007)(356005)(36860700001)(8676002)(5660300002)(54906003)(41300700001)(8936002)(316002)(2906002)(4326008)(6666004)(6916009)(70586007)(7696005)(70206006)(478600001)(426003)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:30:35.1471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944af50-8eeb-4740-8e7f-08dc0bb88756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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
Cc: Vignesh.Chander@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under SRIOV, programming to VM_CONTEXT*_CNTL regs failed because the
current macro does not pass through the correct xcc instance.
Use the *REG32_XCC macro in this case.

The behaviour without SRIOV is the same.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 473a774294ce..e2e14d40109c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -496,14 +496,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
 				else
-					tmp = RREG32_SOC15_IP(GC, reg);
+					tmp = RREG32_XCC(reg, j);
 
 				tmp &= ~bits;
 
 				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
 				else
-					WREG32_SOC15_IP(GC, reg, tmp);
+					WREG32_XCC(reg, tmp, j);
 			}
 		}
 		break;
@@ -524,14 +524,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
 				else
-					tmp = RREG32_SOC15_IP(GC, reg);
+					tmp = RREG32_XCC(reg, j);
 
 				tmp |= bits;
 
 				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
 				else
-					WREG32_SOC15_IP(GC, reg, tmp);
+					WREG32_XCC(reg, tmp, j);
 			}
 		}
 		break;
-- 
2.34.1

