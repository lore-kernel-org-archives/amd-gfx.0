Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5103AEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3AF10E5C6;
	Fri,  7 Jul 2023 17:47:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D1810E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ8VISuYHAh2DjHVKctodp1Qo1ad+/Oc0v1EABBBKAjmvtEE+OM+D4DLvUmO7R7h29OeWOAMBbt8Zc/lKsuvWc7qOye0h6ufx4URK7f8BS5NTlnx5sXaYGoB+Jepxt6c5y7OmAIzgnmk2R8+3T0PI5YNlb/lUukrJ4rlRsjq7QprEXs5VzvrAnBHsHPY6CYygPyJ7t43eUsVoUXLCGzUi1xGYZ2gm7BXx8/qu5z1E+Oc2K8pYNvfrTJCnhtMseYkH333ywGzhFpceljFnDSXBIRGfSVt9bKsUavNvGI1LCsTmqKT61UavnJqbUIxzI6065i6ohOyG75ToIgKCFi7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d4GzL+rYFx9DNEQhhKPp1zEbDfHd8p/BI3HrrdZRKc=;
 b=mjoxObExM5ZaPgRMUhgwRPJan3Rd/gAwjRntD8tZFhF2S/thZa6CiKI/eCYxaLTaikn9xlVOaZmto7SbpTDRF4vy2FrQ4v5lhCYqzHHCpMfYReUegmbbNsMW3ppfPdNTb5WVqb6l6H6Rw+vi4o5XFPSzkzzuAu3HxxSRvhS588qjAPSk6FL9SilfcEgWd+VPMi+FwqggpBMLauxwrF3j8sOhrk3PZUWgU0IIX12PJfvOrpgWA/SRuHSmz3YZ3HK8M5+r6EngIOlI5MGDKJjWg60oJVINMl4hg+FAZF0C1xWpgsnhgYxTFGHjYv6qpnPFdRCX1SQjuY3KeV6Y1GgIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d4GzL+rYFx9DNEQhhKPp1zEbDfHd8p/BI3HrrdZRKc=;
 b=E6OEMzF/EixKjXLX5gCOU3MEZ0tI398q7D+HJiiEEzGbCg8aqCdtBZMg++QQXDc3PD16FWtGTCpMvLg0ODLeUHoSwsPnfdarjpoTMVFe/Z/mDcv7S/xz6UWK/bBYDNuwGgDuFPOXSYdYle9OIiV2NbP2ikLNWOH9yY06ZLOEO1c=
Received: from MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38) by
 SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 17:47:10 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::46) by MW2PR16CA0025.outlook.office365.com
 (2603:10b6:907::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 17:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 17:47:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 12:47:06 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: enable watch points globally for gfx943
Date: Fri, 7 Jul 2023 13:46:47 -0400
Message-ID: <20230707174648.146441-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707174648.146441-1-jinhuieric.huang@amd.com>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a0b37e-080b-4f00-9c20-08db7f1230b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHP0gH3UzPiXh/BZ7dXYIbD5wJ0BoGSPbNavsGT2I0sP2GP6qjw5ypC0PiEVf0/TTXfWl8yRoVQVPOorW0BY8eDdc5JRu8OxOq56+YETIR4EtpnVtS52WwTp92iJG0MW7Ug9UPEQC2/FW/fNP9ff69yS2gNwivWt1lxvxc1JrKltKYIqBIFxUUX3J1V5jypSd70OpmZXZJObKKH3d1t7QKfinVjgDTcWJP+pIkU6AeaF2n8/IyVpE2EmTablIjgMGHq0ZnRKVHuOL+hGtKEPE4rL4svGoacrj51C7nRL6wG1ZVPED4b2mHZE2CtUWprHpyR1lrS49yg2alWwnLawzcFRgHt/bc5OkoolK0uafbVwhqrZ/T5yRhkIi9GCleRsLPt1SmcX19RCpIHjlwnpFm5GADcJZc1U8l6hecKZvL3jPs0asNyuaRFdtMoA/RDX784R5/i2tnl+F4fP/RQ2YwbdItEtpdx0hNCudewsSB+x/ctN626v1LhG3MrcTHUQ0A85AtjuLavANk4h32nkZP8EJ+BQwvpRX/svwkO1ecncECfjrYCIoZ1W9aLAlcibsc5COc9JANpcuJEkKNq6zp1rWr7CE8fJQ5VhjjpwAURHNIM77rBrnEt914y7UGYxMQfb+qtvXennDZenXrF/5JcVRmv/Uj2quHU/sg6+6pMF+2f/Vntou+sC4THKbpVNWDzjyyxIVTkm8HFJZ9wb6T69eQXx2u5oVSFEkgk3tA0/klE/f51MXDxVklq6L70go+gQylVN91JQT8BPTrBEJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(41300700001)(5660300002)(82310400005)(36756003)(8936002)(8676002)(40480700001)(86362001)(7696005)(36860700001)(426003)(6666004)(83380400001)(47076005)(336012)(478600001)(186003)(2616005)(1076003)(356005)(26005)(16526019)(81166007)(6916009)(70206006)(70586007)(4326008)(316002)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:47:10.5260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a0b37e-080b-4f00-9c20-08db7f1230b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Set watch points for all xcc instances on GFX943.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 24083db44724..190b03efe5ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -446,7 +446,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t *watch_id,
 					uint32_t watch_mode)
 {
-	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	int xcc_id, r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (r)
 		return r;
@@ -460,14 +461,15 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
 				watch_address,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
 				pdd->dev->vm_info.last_vmid_kfd,
-				0);
+				xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
-- 
2.34.1

