Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 09:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6129610E1F5;
	Tue, 18 Oct 2022 09:19:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FD610E512
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 09:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfWUZ93aKqR9sIIwrGsZvz66R91VVtgiy7QictAI6O+7kagMTO+Zt69nDRZx7bu4tsPL1l6z0ZVnjT6A6I34J3tq0d0X4TtTEKnMYdTkFT+MBaMHAT5n+2pGQq/EXTJseVB+hd7thOnjexFKJ+hFfhnDEB7sIIRWWEFTpLZlY66l9gX10I7+UcAh66Ji3Smh64mOj5knay1CpkYrZZGGT1qOnJwFMSDDAkTc9yS/hXg1Yhqmr6dgKXo5g+jDQMwxc0DCuFcHH3QqH8jTJFFME6Ih/Vp9sfCNS1nfGSeBPDn6UCDAiMAz81brrbNpX5Mn+MwapZE5iLEXHB0i/u3MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAY8idWBhFiwqi6q1f4ZtTfSfg1ojjxFn694y6s3wL4=;
 b=eXu7eWP4bsTX95/Ugy09WXqTPu33F+dU2Xz0N0+jvtuUWuWZjh6hWKlk+pgGP0+p+F6GdKLciwUQEYWus3F0VZ3SY3uL7zBsCkwxx37/SLcfJOoJ+YQFiLRDRwORjMMIBXNgP+ugBisyLhfN4+DiFVZrRrJY0dULrT5D7428qooIO8NyoLILIRjWKhBtlo5SS/Dk8PrsA5gLs+LgjfV5E/T76LIY4A0kz2QkxQt0fPiIPVjIc7Ap/hX612v2/bhEtaZZR3Cah2dnvZWL3yeJKmhW8faAqyL1AdwmH3UamQ8IqgUZ4D81sjt+Td41/nD25iPwqBmOPEV+kDhE6J0jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAY8idWBhFiwqi6q1f4ZtTfSfg1ojjxFn694y6s3wL4=;
 b=AEsOd2tPJw3RSxaGnnu/Ozwg7usiEGQl+uA9DJgYutiP41/Mk63GABX19iwtmZkNevwDzALITRGVUZ6GmztG98Gkq4VgK9FgXV5jLtJSBNw0X9J5zu9CAL+gOHDsUHofePzNBzCThyTOYvqLHGQkpDODfdgmvQG6MBIhuYfDJSM=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 09:19:26 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::4e) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 09:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 09:19:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 04:19:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 02:19:15 -0700
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 18 Oct 2022 04:19:14 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] Adjust MES polling timeout for sriov worst case
Date: Tue, 18 Oct 2022 17:19:09 +0800
Message-ID: <20221018091909.923288-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dac1d8-ac35-43ea-da63-08dab0e9da1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7E7A//4DnDDiIkvLeLlxkRxdPm2EoQgvkgIbMtUBBXU7fzgeDTuGXf4y3freySGl76pVIg/GQSAntus3ogPB/i/dIRw8AYRS9wYuoZCRZzF/8/9wDZ6tDHBFP60mLGrOaeLamp/IhDK9+Nau8GvqKYfLyx6pklZhw2LK/Og4d1NTmfIXUpIIGTm8A+F5JJ1Xs4WLzJlD744OcRlP188LULnANQzNK9pkLIfRkalgUE/ah2ZJbRARzdomDFb4pwu8hWEen0L/ZT23yZTF59ri/cakR3tqsjd5pOt8liP3ag2WFAhAVrUIcLILBk9GUPZfB61aDyCynalgyp+9Ps2Zpz0wkX5JCoTPTJ4jsJWQOFTDhBXvdpu5zdUhTOcKeMOvbI5hhupNbYuECCuEbJl51h6SsfNxyYXWtGuGa/1Pwwk7igCtYy9S/wt51Y6hcOCqVbxWDuY+53aP5PjIm4IjCX2WwMEVrEoMrvHJ9D7G1+kDuOVCwVX459kUFlCFv74KvT4sOFi7FmGLIXZRzDcbMrohSgxdQbkwP62BkQM6wihgkfqfXyxI5S2BXtryGvDA6Knko9k2YeoRF8tznzLhOkOr/bF4owJ0fH1Zt2qW+383YpHQuuhnJC4w9md30jXIhqyv7ysvWK4XGaJGpw7glT5FjTpcgrvF37FCDCmxP9OyF+3KycTdubK5RSbjaJ/pSjYpDUEmnfQpYXEkZlWwm92moOET9b6aq/11xFfssdOLXxnA86NLUbefGJkP+YcY0UFvUDkHnPv30mfTY45gtr0IVWx2lyJnesYzfTuwJaN6gmdX6Fl8g/IGks0Jvycf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(82310400005)(81166007)(356005)(47076005)(426003)(83380400001)(6916009)(54906003)(82740400003)(40480700001)(44832011)(316002)(1076003)(186003)(7696005)(4326008)(8676002)(70586007)(70206006)(86362001)(36756003)(336012)(2906002)(8936002)(36860700001)(2616005)(26005)(41300700001)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 09:19:25.7754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dac1d8-ac35-43ea-da63-08dab0e9da1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com, hawking.zhang@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
MES response time in sriov may be longer than default value
due to reset or init in other VF. A timeout value specific
to sriov is needed.

[how]
When in sriov, adjust the timeout value to calculated
worst case scenario.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1174dcc88db5..8d265598d4b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -98,7 +98,14 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
+	signed long timeout = adev->usec_timeout;
 
+	if (amdgpu_emu_mode) {
+		timeout *= 100;
+	} else if (amdgpu_sriov_vf(adev)) {
+		/* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
+		timeout = 15 * 600 * 1000;
+	}
 	BUG_ON(size % 4 != 0);
 
 	spin_lock_irqsave(&mes->ring_lock, flags);
@@ -118,7 +125,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
-		      adev->usec_timeout * (amdgpu_emu_mode ? 100 : 1));
+		      timeout);
 	if (r < 1) {
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
-- 
2.34.1

