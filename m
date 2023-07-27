Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A384C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DCA10E5E3;
	Thu, 27 Jul 2023 18:11:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5710810E5E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh9+tm6cod1hgVKFEh2t9EGqoDz45xiEFCLK8YmvqJotCyf8U/xd3ME1jLX4RE1rVBhoe3IrcQGpSMGimj7M1vZag4kjWQkYIJySL8au6vpJU+kwPBP/Q3feo6LpW+zFaLW5TNEHbsjkRYOQ+Es45uNywBOM0x7NNvSgyvEHZkJyUEHgWPC2cVGsTV4M1DM5NHu5sRbTd8mMBV0Ct6FYEkVm+Y/Xo7ae0bIVY+JWgzK5dv/oy1u42ecI/IRoL0fg1H+3q9Uako46ksotC221l3Kh8AnIgMLrRtSpOlxEEt0E29JeljfhIrAn3+hwBTzwbhpMVOGxQu4v8NIoAajCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRv2KozPMyFPhmXMWQ5nII2t+wLM3Oxw02AN3liyjLY=;
 b=DNCPF0s2KQLP4+iXjQ+8qzh3ew9iDzZPywf12phFyuLjApBChRqkizEr6H+pgVsaWl0qJva8T5SS22/fdXOoZtwjg+Ulmoydje2c6ZQiE5ym8YBf7mlaCUix2kq4xt+0OHCGmep60NDHHJKeFdcbAYXbofdZHXWz5xcu1QOJcj/CFWftqvFg/4F3q3WJ9PU6Wsn1uPYXgk4bFCjht3Qni92o0tjNGoDRsQaVCcW+aQkepbzcXOmu+ZV8nxAcQ+/+2H/GryzpSZ/Ck6p1ToCAgmZ92KqrDasuVnzrDsIdp4CdB+TLIOufpoYW29TVtVsvob90pujFBaS8KmdLglJvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRv2KozPMyFPhmXMWQ5nII2t+wLM3Oxw02AN3liyjLY=;
 b=a2JxC1XNojMeOzPrw6EGRMgQCcVE9OCcPY1GeyPNpzopANnw4pXkSYzMLT0FBYnOGRNtpkRdded2ZaDifG/CagZqX8Qsx1pFRbpVKxJbCXiUxEPs+mJMRCNjUcLVXfSzNGZaPU+ka4xq4008FAvMNBP6vDOR/or6K4Eilqv29yI=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Thu, 27 Jul
 2023 18:11:21 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::b7) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:11:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:11:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: refine fault cache updates
Date: Thu, 27 Jul 2023 14:10:48 -0400
Message-ID: <20230727181048.1222388-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727181048.1222388-1-alexander.deucher@amd.com>
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ed177c-dd45-405f-4101-08db8ecce197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHbkxx6MQ1X0RNkQ1wGGlu9F3Zk+g0293NK4oTXJRpRWwYJAiMy7xlci7GRAvTJlrdZViAzUVsnrVwQIbp9NmDeEPeMAxt3+IxmMn8aXam3c2h7iMjfPGSqL//GigrTapqIe8Ih9NImADcs2w9DtfJSW2iIQetQ738fBnrfXZ44RX5fxyr6JeaCyTNfDqmUOfF5jeeMHcZ+0uKFO03Y+qu8yKY/iwjrhTiubV8M9k3Rt+NHVS+DTRI58hx/KgOwuV0cPB2JwYbtTfcojz/ZuDxkLSBUlgw3ykiflUaAU0RO/udEKnGv8TiQA5/ATDCAd4/YFNjSxYR+Eh+voCibMc5RHcsvyQz6Dee4/dpbFHi7Ub7SXuSvvL5dr9xjHuH9YjkTEAPFfN/pSraaANq+OOfVdncBN04czwHhHpzVhcTYJ0deObRAitDjQeTgnEBHbHjLv+ihg3yHeDaUCJd9TmYW0oa2fw9lzNSwawcEVEd3ByGObh2LGAs0DsUXtndQZrZ1iZddC6F/nTAqenPSO0GPKu2uI9JSnAVncsuiOcBjgYqKtQU3vuQjw1XYZQAxopytoCA78EWMLGZlCb+TOwFDGeTy6fNtf/+kGG9/B0BBc0rCvJbti7Fox11+n/HhBjrOJOKuWRPDQCQ1h9LytYKn1GgSCJRrj6hlC3baluo6+MhS+VIKWyDpU8wfc7jbft4ZmeCUsQMJktd8PYrK3UODqj0SwS4bERsom9XkwJzfO49uoqm8wCOWOCi6pT+a4cTSUw9KALZGeYr6pkfwdPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(70586007)(70206006)(16526019)(1076003)(15650500001)(81166007)(4326008)(6916009)(316002)(6666004)(7696005)(478600001)(40460700003)(40480700001)(82740400003)(86362001)(5660300002)(8936002)(26005)(8676002)(36860700001)(36756003)(47076005)(426003)(2616005)(356005)(186003)(41300700001)(83380400001)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:11:21.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed177c-dd45-405f-4101-08db8ecce197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't update the fault cache if status is 0.  In the multiple
fault case, subsequent faults will return a 0 status which is
useless for userspace and replaces the useful fault status, so
only update if status is non-0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9294264b15745..39ea2404f38aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2757,7 +2757,12 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm) {
+	/* Don't update the fault cache if status is 0.  In the multiple
+	 * fault case, subsequent faults will return a 0 status which is
+	 * useless for userspace and replaces the useful fault status, so
+	 * only update if status is non-0.
+	 */
+	if (vm && status) {
 		vm->fault_info.addr = addr;
 		vm->fault_info.status = status;
 		if (AMDGPU_IS_GFXHUB(vmhub)) {
-- 
2.41.0

