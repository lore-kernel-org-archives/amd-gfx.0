Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56986C48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61EC10E3CD;
	Wed, 14 Feb 2024 21:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvkQEI75";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34E010E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf+fv20pga+QdvaxvCgPWmlu/Ul+2iKJYlaORA316q9vfWRvApyOpi/3unEuXFamxu+5f+MJqO4OMdKNwQzdw2MKSUnjt6/nnf7PhROW7asA1fWRN+QwqtA14ISyAD/c7D2H0catn3wF4zqdtuMPGkhdZ4KYe/lLEmZsb0TAUnvlh1qlLJlOy9+nxWtgqqHUEbBg41SXzQWoXYOVfwl5s9p20QhxZZffuh2np8Jj/cMCgOW7t05/6XqKfuQE137hkwLLYE/RlgHR8SdifgriFjnz8o0ECBC0v+KTkdDxVE6ZE8t7gon++m2fqAo0NYuvmDYml+dGEt6qkmQo6JW3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7yfQr3wEjfOybhbhB2RNbbFRiDx19N2phNYhti5jww=;
 b=MerhdnlZVCpeKLgSCTK498CKVtcF+y/2x49m030DuJl9VGIUVdCSfjqj5sI/mmY9F34vhbdDROdfs7315HqjBYWpB0mp9Ug05zdNjXebpajJTCIwbDPZamV1zXOrsyPvtZV60o51vTNW/MfXsNPi846RPzH+CWyhdI8fM06v/xBdS07/t/XOcCchs38c01MjkFH+X3A1x8WIVTZidJ1uWzpSsm78TyYVn8nmvCZwJrXBCbKlq4So1oeL1+YRhqQJ9GAm8nOZzjIwB66E3nbaHnPbOHkG9E/qFITRS3FqZBGTC71v2VC1abVqdwFMfxqt3TqnNU1n/Mna8C41YERYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7yfQr3wEjfOybhbhB2RNbbFRiDx19N2phNYhti5jww=;
 b=rvkQEI75cbtpyk+YfNIEsoy1oy9A0DJ10jiZVr2w++4/wqenm7Szc6iJVOFy7hc+sx29Df6rmszrd3upa8QXJQqQWm930bEON45rMUC7Pm7KSiflgGtGLgo/Nbpx+iWbLv6PpkY+Df3FDqHUUAZHOD9EYJf7sSgoiA+17ye9Jr0=
Received: from MN2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:208:1b4::28)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 21:32:07 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::fd) by MN2PR15CA0015.outlook.office365.com
 (2603:10b6:208:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 21:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:32:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:32:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add nbio 7.11.1 discovery support
Date: Wed, 14 Feb 2024 16:31:49 -0500
Message-ID: <20240214213149.2591914-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240214213149.2591914-1-alexander.deucher@amd.com>
References: <20240214213149.2591914-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ed5f73-05b3-4726-6173-08dc2da464d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UI/jAh6deZLrgiI1RlHN9P5HOw+505RIHUJxX7qRH3xwxirmdk0VRDsqbbC3H64/f3PYVoqc5f5U09uX6fAWyRqQAm60hpe8CpkIWF0G6BrEnQGibtRfZ518gPbS5ZiScuGjprbTXqET9sQTHGghZGWbsrbBNMC7KG+dvtCDY15m7UrGdJ8D2Ui3to9hRlNphw0XvtwFKaQEM0IRKLoHvkj0QL5k01uHFMXhWc9OjMFAfFrzBfCNIk8iJM1sb3WETnBHbu/A2Saquiny+tQgBO8MlL2xfaEAsDJjTsNYmNbXiPCHGzhw6p+zcR0IpyXgu4iXZoDSWcAanyevsweUNFkndJvgdNyR0so2pT9JMEGl1AzxMRL91e0K+2MApCJ+7vJYNljAERS1ZswmJ1SEjtSjNGM0vx0qxZaWOWfvK+A3CRQoAQ5v/FzBjbQuk0ACmQ7Zi35co6kUsuDQThrhbEPGPEhlEukJ/mCJzsqALlcy1vuGmIlE0l/yllFQiqtRp5QtfJh8j0EcL508/MxgRYvFl86gOzubcPqx/Ws8n1Ko+2hTZ4LDBhx/CsiTwFE4qOSVxv5gKnaRA/udTE69R44WTC92yfIPqA6RBlvlW/N8UCVbIFzjMyFFS3ojGtNbFA5I32u5iPpUdYo9VtmOMSbEOk/RLshfmeURkQm+yJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(36860700004)(64100799003)(46966006)(40470700004)(4744005)(5660300002)(2906002)(7696005)(2616005)(6666004)(81166007)(36756003)(478600001)(356005)(16526019)(86362001)(83380400001)(82740400003)(26005)(4326008)(1076003)(8936002)(426003)(8676002)(336012)(316002)(54906003)(70206006)(70586007)(6916009)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:32:06.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed5f73-05b3-4726-6173-08dc2da464d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add nbio 7.11.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5256df93a68b..f6bd8a57f1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2513,6 +2513,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v7_9_hdp_flush_reg;
 		break;
 	case IP_VERSION(7, 11, 0):
+	case IP_VERSION(7, 11, 1):
 		adev->nbio.funcs = &nbio_v7_11_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_11_hdp_flush_reg;
 		break;
-- 
2.42.0

