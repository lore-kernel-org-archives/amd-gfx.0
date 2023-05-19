Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1EAC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 12:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0D210E2BB;
	Fri, 19 May 2023 12:03:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FBB10E2BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEKeiypIX5MdIYZzMzfDoVeU0voIV91jzmc7VTXAiFlAnXiHAoOa7oTVykF/OCQOz8aWSRxoyYDGIioWRoL/Mr4174AveqB6oSgNxv0iRHHS6kwvBep+vD0qSmtH6xXFB+2ovYuWHfah1g+pSJECzPQbGBF96BoKX8HwB0V7ff2yfrQcEwGDq8cO2WotV2bQC6a8wix+3AAYOM8buQXpe2NmGLYLKtYH6hky5qnh81vBl63KHA7DPAkOsjn3nxurcZtSQx7wzOsMopR85UoXomH1uxq5gGiCEtBJTjSNLBTFoJLjaWrHYbtSvIgQgt271JxY1DpQu3E2J2uPqyJZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zGQ3uq8he1BJFF96VazrnIJzO+K3Ub1KPFC9UM+Wbc=;
 b=W1YmAR5onzCHeSXjtM/wAik2hbE0ezlnt3v/HV6C6rjUbcqx6S3UppQDWLNoQqBz7LSfHKtxO9YEDK48wKdIvRL4cgPwx50H9tNp2Gj56so14zUgU5ghucCN2PYsAhuywa6LFONpswvLArXndUbsg1wlNbMT/dOK+lTdy07E9eLthQVkCr2LK11Z7vpZSxyXGPTr26t/HpfB2nS8QXZcmhTcFiFen0/t1SD2eknc39Jdiydw3wlcRKBDimdpatEJ9vElU+48NlMBF09ulHALphjZNk9lkuYpAv3CsNzeA55ZS6wQ9KIs78YRhfuN0IyAgyiN+VHwxitIW5h8fJLjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zGQ3uq8he1BJFF96VazrnIJzO+K3Ub1KPFC9UM+Wbc=;
 b=qD5K57OoZHGZVcij9oGUxifeyiUnAkMtKHEE8Zcb4nz8I/Fh4FZjKqTJdEv1LF/bxBFvDtsJqXSUZn+b1WTnDfIRk89AfI9I50rglnxhsBzNy3VCo2rcZDqtQlQlM/CQVslhmRcoetrapD08daw/GNHROAysF8DsItu7sCTTTvQ=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 12:03:42 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::cf) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 12:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 12:03:42 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 07:03:39 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix the EPERM error when get user pages
Date: Fri, 19 May 2023 20:02:51 +0800
Message-ID: <20230519120252.3383090-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 617bfeaa-e4dc-4e9b-8d94-08db5861172e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsA9xMOaM2bizYwTSqVxxABf3gUQLK84K5dSgVmI0i+YmngyS7c3kJC4T+MwuWV974uGV7JKJT4p2Z2jMtwA759Sz11BDIJf7/NniSiK+ME9YxTsBHC6NQfVU+HzZyj34KChOhsajgmtEfGNCIOOwm/fmLdnDLPd7B0z9b0YvgO7iszjDKd6IWfGDDSvxuSzfYMPQJXmR1inoh02YiiC/k8ImDX0/oomavTqRf5RLA7YrsvDfdCchajK5+TiLg4oCQ2eljGK3mz4ohs1DI4KckkSqhiW0+sPHy6r4UJJ1A7+2VllEKtwGk+G1xbYnUeTDE/FQxM0aPIe7IyoK4RCBgooWqDJcX2RUrO+VYz0itsQcdNeoxlSLEg2s5i8F8DM7o6PXxp693GJpm5Z68WLln3Mpfp44Ye51Q/6ZVF7KXzQPSYbzdeEmNcKejmXiwZFZSy801lPk96vj/tQNzHeHKnPz467WPTmPT5m+zG2npkm+Ov6MNSa7hIptkgRAvoDZPSfpliZfrZzVLpiW9jJVqmtjUvjKH3xssGWgrhVCQeBqCcjEWxgsCMRxgXuE8ZExp6yehER6kY+Bd8p59EF94a76jSZF1l0gtPy8tHLNwDPkNDSKRpxJn6Lb5rXMk3TSwG4mTcZu2olqhJ1u4PPjwWknVh5RubpavFNsgFsssjxjVxaXopGe6t0CdzzADU+MpEEi0IJ0oepCrrkTL29Q/W/VsLtWRX24Ya6ox4Zph0gC9ffb5GtjdqdHV1ZNo/g1nckTo3kJYOpkYzFjp4alg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(6916009)(4326008)(54906003)(82740400003)(8936002)(8676002)(40480700001)(478600001)(316002)(16526019)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(81166007)(356005)(26005)(83380400001)(2616005)(47076005)(1076003)(36860700001)(186003)(336012)(426003)(36756003)(5660300002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 12:03:42.6274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617bfeaa-e4dc-4e9b-8d94-08db5861172e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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
Cc: alex.sierra@amd.com, felix.kuehling@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and pass the readonly flags when set amdgpu_ttm_tt flags

for readonly ptr pages. Otherwise, there is EPERM error returned

during the KFDExceptionTest.PermissionFaultUserPointer test on

ploaris10.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d426333e865a..85d1087439c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1036,10 +1036,17 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	struct ttm_operation_ctx ctx = { true, false };
 	struct hmm_range *range;
 	int ret = 0;
+	uint32_t tt_flags = 0;
 
 	mutex_lock(&process_info->lock);
 
-	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
+	if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE))
+		tt_flags |= AMDGPU_GEM_USERPTR_READONLY;
+	else
+		tt_flags = 0;
+
+
+	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, tt_flags);
 	if (ret) {
 		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
 		goto out;
-- 
2.34.1

