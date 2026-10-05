Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB6CA5FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 18:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A39B10EE5C;
	Mon,  5 Oct 2026 18:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k6GCOawJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ED410EE40
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 18:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8HA34DA4EAZkbuWwWoydlGAUaohBlAU1SFR2s0ZDTd/ujz+SsQjpCy6rTw6Neb6zu9pHRGkQi87ek4+Yj1zVII+wSfl2iXaOQ3E85gwzdUHeXHYnwyiYRBlCXxAvCUUBA4EhD/sB1No5XeD6ZmiRW9nJwl6VB90+D1va8JsHLt4Aw6WNpoEpc9cq0Nq6QKKi++8tfKLJAk08zAJE+aojC7LQQyKH6Om7e+qKRUFOgculUe4BrJ6FwyLRbSebLGD7SDVcQP3bsmcR+fqFdAs38rXLcN/oNMljnDIskJ9EWYqmkFF9PJ8ZCFiI7C4WdTnW95WE3kGyC6IBB2nzGfobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vfHEH3AlJtt/0M9WYYyqNNb4CFrOJ4M4TY97T3IbXE=;
 b=cAxsMfmOqOS2QL0FhdDaWjl+slWfuPGCnMbadqYjok/rQh8DswEyd++Ckqyfcj49nPXPv7uRBWZT5QxoXAfTgxd9VkKRGtc8WZ/jw9ovpp4gA0G3EsF/09PAjMyYA/BnTw4d1f3xF26eREUJaPxUtklOY50p2Wqfn1qP/JBFL+7oaTzqj0vGgvinVI897k9P9vqpKgnV68qvxgcwb2lk+b74mt7HW3z8Diutz3ZPwcDMtcmSeQ1NEaKFqbu0N4BFhjb8OF6QaoGpj6vblBLXh9e8bSaFDtO5GJkPuRoo75kcfQ7cbUNN0tZ/+AeEvy23Z4YB3LivHp5B3hjmxggZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vfHEH3AlJtt/0M9WYYyqNNb4CFrOJ4M4TY97T3IbXE=;
 b=k6GCOawJrsGTo3WK7w3PyjCPjE6/trOXqoBhG5Mn3d8yyTW8sJ0IQoRqH0suIo9y5Tgwoel7hxwzAXmIfTIVsfHbznLzUVaDjZaadnHQezvWpVBN+IDZZb8Coff68QFIbNU53Vj3PnZB4yosGGILa+rwmrP/+Zh03ehmHIdw8ck=
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 18:33:12 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::93) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 18:33:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 18:33:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 13:33:09 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/psp: Fail on VCN firmware load error
Date: Mon, 5 Oct 2026 14:32:45 -0400
Message-ID: <20261005183245.432709-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5dfd7b-2492-45c9-bcf7-08df230f1bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|18002099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fJy+C3xPuo39f3OWDoUVrWNZiagPcpJpm7gPR+Xbc79zAIsl22XP5KleGEpCIEWHbeczPHZr4jwQnVPYyeBRe3H8lxiRdvNuUqWoUwD1Z7evGHk/60pg9/YpsaaogbJwIly9YxRoHR+ToKDsKK+nB9rZgYRY773O3Hiro3dN0TW80KpwkwIXlrzUHD7z2NXsgSBs7wRB0fSMImOPQAPoSZ8Qgjm/OxNcorqdaebFFb91KeM9r5pDt4BJiPj7R/CMNsbG1ZqkSDxjnFXwQsg50LaKkL6KPAu4gEX9bmHWo74Qub2IqeVrPZ4JYI1TpPDqqBAoiJADpjPobJbuBIziVH/gMn2MRtB5Fbr/xe2UNsnzKcu6jrnT4uDdq9hwRHijKlngMhx+bHDzdrC2N5mlBagP91ssJcn3yTfUjXzS67gTu8mhuBH/sWMlw+T02XyYVNab2FASF0mSGbmjhRBqsAc3tK+NuXqAvJAtWcAzeXBXGCiM/EsdKk8FxYtwIaxmibQ4VMwhCEEywJQs4WSxcBXSFYVFsP1fgpjp0n0cW4jEdK7+SUw74Tf/gsfNT461dcNPZXEacuQz9z8xQTb+QNFRDPNHjQnv87nU0VFe9BoumVcPQfkWfhG1KAwiVlG++bc4zwSbnQnxCCu1GgWJXmbet90hGtM0Qhu9rndmVIm4eElxA6alTd+07TP+a/9RmqwYFp2jzEfzV4LHQXRs1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(18002099003)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uKMJgh48CwRBbVmVGaFi8AbjEQVmt78uJINapny6JrYIhEv0hBxGdeDAWqLzDwa4417XVGBwkY8yY2QH0I9RDIfvR23JdoR5IemXrTTf31c4wHABleUDoNTB2qSkaoKUon2S0lOG4AKBAV2UB019HSlX9GgnXrStqGqLtrq+21Wg3tk8Zp1OjHsZzS9hRm1KhqKcZHv60NJ+xNuBm+XgwKo/JmesxP2nyXRlcBpc/hJta7xUDn+kEDBwKJWRdR5pHoLfRAaGcOHQ9bbyoxWiAASgSv0K7RYHlPOm9lhoAZ302Qoh5ikOMzBF5BCm26aJdOsXmTcW+0mz1JM20R+mPviMM9//heS+YSnyanmy+xPy0iQIdqSuy+E6VsYsDT/WU1cf/vJu3p2esFfoxZJqulSgghTqZaF5G+cGAvoqRiGdF2i3s7uQ4TvlLm4jPlkM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:33:10.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5dfd7b-2492-45c9-bcf7-08df230f1bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Return an error when PSP reports a failure while loading VCN firmware,
preventing GPU initialization from continuing with unavailable VCN firmware.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca..1d853d2e8cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -784,9 +784,13 @@ psp_cmd_submit_buf(struct psp_context *psp,
 				psp->cmd_buf_mem->resp.status);
 		/* If any firmware (including CAP) load fails under SRIOV, it should
 		 * return failure to stop the VF from initializing.
+		 * A VCN firmware load failure must also stop initialization.
 		 * Also return failure in case of timeout
 		 */
-		if ((ucode && amdgpu_sriov_vf(psp->adev)) || !timeout) {
+		if ((ucode &&
+		    (amdgpu_sriov_vf(psp->adev) ||
+		    ucode->ucode_id == AMDGPU_UCODE_ID_VCN)) ||
+		    !timeout) {
 			ret = -EINVAL;
 			goto exit;
 		}
-- 
2.43.0

