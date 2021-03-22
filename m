Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2006188B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2006188B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D843189F6E;
	Mon, 22 Mar 2021 02:55:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E03389F99
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaYBHJw1vxI4ps/mehv3guPr9Z3hikIkmhWh3TwNYNXtD7mytUz//TkF9cWX/hqy4OoqtH7qAeKsqMUFI+0DAxTppDvLbCkIHgnAmUiQb48+Jp13Idi12poi1gZpAn4pVxGBDdNDwofwtZQ9CMtBa1IFWLHVWZwPRsZiGIaTm/v8AoBjEPO8KkgPjyK+z+w/p5hu6HxpAkzxWbWJsDATeNzZNO+H4aIR1yZkUqAEXoUcyt2zDcX2amUMUuaMUSOCtACmOCeIEh79ESlSExepcqzNENHoVNZ5sIhOOKUuTFnLqAZgF/uU8gGybXs8O/DTi5tdenQn+fxNxONfvBX8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSc+3RP9oaK9LxjnuxTTCJAPOSVsmkGr3CXtuxxLvjc=;
 b=RUclCizl9jv1HN5NbghizLoTV6jVFzbwAWVao/emN+B3TAimtfYaZYfNA/C4lRsOp20FALurEjmne9mRgQDKXmg2Jkiz5MkNz4NNPjg0jbZzkgbwBoqVx/XcwbsYHSn3gsI4n0XbqWS3qbvNGeE1ht6wYikHQxBItnzpz7r/mJncnuhQGhXGSgLMfppQ3vZNf+5XECCEkJJCJaV0DGE587608qZ393FqI17sTHdYytBmZ0cpf3x3VkDWQRSwCNPbqUaPHZzG1+WlmLzMzSWXWBi3uPzAJniWVgtSb5OanhCrFf09LqcHGVhGl/QosIHwiL4gpiLae3oivWucopzKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSc+3RP9oaK9LxjnuxTTCJAPOSVsmkGr3CXtuxxLvjc=;
 b=FEIkWqYMNilzaKsl54r9DBW52zbjFnSax4dTKTnxU+Ivv5V7CHdcjJc091+g4MBVML+xladEdGKBvF+NnunpKF/g77TmMcs70iRtONGiXVZ+fEe0zpuIBOTYI2yUdbtba/COrSMEgc1kAPLxy13EuVhJtlcrXDSIgErhC4zG0fQ=
Received: from MWHPR04CA0071.namprd04.prod.outlook.com (2603:10b6:300:6c::33)
 by BN8PR12MB3491.namprd12.prod.outlook.com (2603:10b6:408:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 02:55:05 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::f2) by MWHPR04CA0071.outlook.office365.com
 (2603:10b6:300:6c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 02:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 02:55:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:55:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:55:04 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 21:55:03 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] SWDEV-275015 - drm/amdkfd: Add fence tracking
Date: Mon, 22 Mar 2021 10:54:10 +0800
Message-ID: <20210322025410.30570-6-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322025410.30570-1-Roy.Sun@amd.com>
References: <20210322025410.30570-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f010e27d-db7c-4ef4-c485-08d8ecdde544
X-MS-TrafficTypeDiagnostic: BN8PR12MB3491:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3491F0B84E0612A91F015ED5FF659@BN8PR12MB3491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LD6YsI+60fACvXwUO0/F3kfLMPHEiWiQyCfr0xDBiigKZ3WQXUZUps+mJTCc8Az8otAZXKwuGOdxvgLfDunOa4wum+n5JJuRVo+MB3cRt6tmf3qvomdVlVga4nB/mxcOdJ3I+L2r6BWto8JR14O/F0eLprxSaaTkS3CX6mGl6wNR4T/ICsw2Ru6zd8+fSYig1Ta1sWEhpFnRyENey1dCVSGw9NQaoQUSmgMSYu2+HYD3c4WLdnfFKpBimkac4Fr+GXnTRmdBTo6ym6qugDGNvC0AF7EXWRTXRBlGn9KpB3HATLsQc88znpEVQSqbHsBQn26P2G1cKK968vjC3wssmcWzamM8+wXVjYyyMbhpzMP4QvoirrRcfFPY6XELnom7HzeCnXlKp534rYv0nWh40FxwYj7h3zLJAA0ZaAAogDb/4fjcNV578odRhFRM4F47/4ovChsOVYQpz8a4versGetq3gTg+ySgOMDCpBq1Lj3PlCiQfYnp5iNNYYfvsPfH08PDrPI2T9NLUpWGebNC1ZwvK0Ds284mxCbs+zshfvf6cJnUOrn58xnJ/K+uIgCt4veohRpCf1TK2hL8avPaMEiFZR/2+hEuQidYZ9DC3gTVzKv/2B6pp9Yv78tg7JEOOvTUTuWH8s28W8O1UPnh3bMWoFWPcYzMiyqW2JB60XzRpovgdDJVnZsXqnlbsMCT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(70586007)(82310400003)(36860700001)(70206006)(316002)(36756003)(4326008)(478600001)(6666004)(86362001)(186003)(26005)(82740400003)(81166007)(2616005)(8676002)(336012)(8936002)(6916009)(426003)(7696005)(2906002)(356005)(47076005)(83380400001)(1076003)(5660300002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:55:04.9812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f010e27d-db7c-4ef4-c485-08d8ecdde544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3491
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
Cc: yehonsun@amd.com, David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add fence tracking for amdgpu resources on gpuvm creation

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e93850f2f3b1..26e84c2d6316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1042,13 +1042,16 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 					  struct dma_fence **ef)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *new_vm;
 	int ret;
 
-	new_vm = kzalloc(sizeof(*new_vm), GFP_KERNEL);
-	if (!new_vm)
+	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
+	if (!fpriv)
 		return -ENOMEM;
 
+	new_vm = &fpriv->vm;
+
 	/* Initialize AMDGPU part of the VM */
 	ret = amdgpu_vm_init(adev, new_vm, AMDGPU_VM_CONTEXT_COMPUTE, pasid);
 	if (ret) {
@@ -1063,12 +1066,14 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 
 	*vm = (void *) new_vm;
 
+	amdgpu_smi_create_proc_node(adev, fpriv, pasid);
+
 	return 0;
 
 init_kfd_vm_fail:
 	amdgpu_vm_fini(adev, new_vm);
 amdgpu_vm_init_fail:
-	kfree(new_vm);
+	kfree(fpriv);
 	return ret;
 }
 
@@ -1142,6 +1147,8 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
+	struct amdgpu_fpriv *fpriv =
+		container_of(avm, struct amdgpu_fpriv, vm);
 
 	if (WARN_ON(!kgd || !vm))
 		return;
@@ -1149,8 +1156,10 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 	pr_debug("Destroying process vm %p\n", vm);
 
 	/* Release the VM context */
+	amdgpu_smi_remove_proc_node(adev, fpriv);
+
 	amdgpu_vm_fini(adev, avm);
-	kfree(vm);
+	kfree(fpriv);
 }
 
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
