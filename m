Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C36C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC126103D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AC126103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09DC6E1A8;
	Tue, 19 Oct 2021 17:51:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4856E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 17:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7S2eq1XS+DXziDUjVeL4Hz3ADkE2iIo6D06uU0+GLku+PZ6eJijBLloBmUvr36eiKrsROdjF6GwcfiaQM/SSw9gQciwplbq2Ga418Y9XiAgW3TZKIxuTiIEgmG+sfIc29SO+hJX0jBUZbzmi1l/k91Nbur29rmI7MW7XVHalSlcdP1sDDK6q1hsAa5H9qTavMUUin+r9M2OFAEnEXLqU72dfuA0JtPlXde03Prrh1LymE5nkdyWrVN3+tQalhb5pHJC6AQOnvwhOuPKWx5jCKBUQWAPNCbNHzDBAwDLwR9nPfMNWPoikd1VMh9c3dZzei5NqZ60r4CjWT2N/ozOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH6gIZVFXBIl3xmXcEXdbybhpYYCPwQjdt6JyJImOao=;
 b=QPbyoHhs2mMx6JZ1EbZgxCMsPjbP7Goh6HINqKSksDFLgMKJq1ZAzThCoCTuIHYH2vonhtpUFlPq7pTSNEBB9PXlj0yGfbe+93XIM4ov72oHiPb0r0UXE7/n2c6G4ekriarcWmaYt5qEJurlyQSN48TkqOSTz2ZGNtqP9KDuo0VEtAwjNnaHc82XUEOMhHFQ6uqrDo+AS0OnA6xQY303vtCOCAIeUgV0FNdGm4hqbFFfgCmJwiv6JPtMpumeLM6E0U6Tvlp/QvAoBj0ZDwy9Rj6bk0F2eANodHkkkr4IyBqx1FNNe8kDm6pSKenwKmVs16fIGg5VWIPkvfJBp5yk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH6gIZVFXBIl3xmXcEXdbybhpYYCPwQjdt6JyJImOao=;
 b=SgTZy9OzgDn7yGKsMI3YSlE+mg8WZg5OMspVlCXuiu5B+/WGe6CIn5wCdvVjPPxqbnFsQxHgWSOryUEJfYve96G33mBsrZzh3ex6R2mmcWDupAeB3F+H/nM3NLe+Wx8IoK/wPyr9cr5YJE7rcEp99gwbwGzsMlN4zdJr698zsGw=
Received: from DM5PR1101CA0006.namprd11.prod.outlook.com (2603:10b6:4:4c::16)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 17:51:06 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::6a) by DM5PR1101CA0006.outlook.office365.com
 (2603:10b6:4:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 17:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 17:51:06 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 12:51:04 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Clarify error when hitting bad page threshold
Date: Tue, 19 Oct 2021 13:50:48 -0400
Message-ID: <20211019175050.934527-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019175050.934527-1-kent.russell@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c246e015-5b9b-4bc2-2d25-08d993290692
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-Microsoft-Antispam-PRVS: <DM6PR12MB266894C94B21ED77BE28D15185BD9@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0Te1v6MDNiVFiT5qJl/LXvaREvupZT+WbSHj9IEqkdV4+aMqBvGfqD2KM+KjVxZ50FQvn/OAekgPLj0LzpM7Xi4a3GvClxvyo4MaJhpQhZ7xNMJRczaogWi0UoBCwmC/233mKfgxIipivNWu8LBLpy7TpplSgJb4hUZgI6pr7nytBpTphe65kXusvTzvnmMvATqLCcSaznGamLCe7NcRV0uFmZUvbd99yOfNvCT9q1zdR72kC474l6/eJuEg/ZNXVZJxGF1rC6hlgI77X+4cnoRgH2KZzeylH3rImKoDQcOtD4GbYZziFYO3Y7pBSFbZ06pLWbTWKMqRY9U9FNpn6tfEgXiKdTKUJdr+VM6zDlIgkqUl5rc4FG5QOe4jVC0eXqrVNzIqq8dj3cI5bcjeeJpVWGFA6mGNsoGYi4pAUIDcen9AWjHYcFr7XQxsvbrHfoBBmnRvku9jd7+NhEDAfwEK7MPvm9WimzX/AIUBtdBosvb9YRsYexC8xbZmda7zU5xIIAK+lB4hffIsqKpvUcQ8Ypdha2denyeM1g7jyLruOf/IrNB7XSP/VQ8juilvxK0i9Ctske4xlgP/4iRgSwp8O7U4TmDB2Pl0Wm9yCZs7d/dzyW2mJtZfw56q+oUG02AbSEAksIjOyklwJ6xmA/MbiYs4bDcT8XbNfmf0k7d0W7JkZC1yZcuxeEEo/Jqpus20YyKu7lHUxLOf4KruNsbUZ51D2YVLKnUL16HiII=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(81166007)(47076005)(316002)(2906002)(7696005)(83380400001)(86362001)(426003)(4326008)(336012)(356005)(5660300002)(36756003)(1076003)(8936002)(16526019)(186003)(26005)(36860700001)(6916009)(70206006)(70586007)(508600001)(6666004)(44832011)(82310400003)(8676002)(2616005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 17:51:06.1971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c246e015-5b9b-4bc2-2d25-08d993290692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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

Change the error message when the bad_page_threshold is reached,
explicitly stating that the GPU will not be initialized.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8270aad23a06..7bb506a0ebd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1111,7 +1111,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			*exceed_err_limit = true;
 			dev_err(adev->dev,
 				"RAS records:%d exceed threshold:%d, "
-				"maybe retire this GPU?",
+				"GPU will not be initialized. Replace this GPU or increase the threshold",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
 		}
 	} else {
-- 
2.25.1

