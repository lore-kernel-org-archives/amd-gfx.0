Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0398BC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC02961DBC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC02961DBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770DC89A57;
	Tue, 29 Jun 2021 07:56:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C5889A57
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPxrLsxqLrLcgG/+TqRhwYgL3G2HfFERtVNfiUgNXTpkXPf/ocQj4g/GsvTT8clrBnx1cQiW2hMHzNJ2ABaIUFk13Bk8PYY6rgDWr7qAALqAl8wAyfOZxvuSQg1jUfQP+QqcZzB169uD/ZlKbIOAl+coyKA+jVMj6S+z2AZ4RjUmxpazb6D+bwBqmMO0XWpWQVj6qcQ9dRpX+zJj7MydZPzU3LJuSSeZ2147l84oz43KlgavkWbKkM9PhCIpUoLYFPPH7kI4e/H9NBJXx4MhgZz2K1Vl101XTOzCewzhrg+HIGZr9oRToWudxHpMfmY18GBY+9xP+0BOuY68JvoQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVw4FKGSt0MnZO4Y54bCwYWED8HeB9XbXP3CmZDDvoo=;
 b=fpGJnSOMQtC8lNbRdJi58OYY/TgKoxVisjCPekO75wVVPAxP91SmsDEG3QiSxhJR9Vf9ivynLmLoGym1SvoQr6GoOgfYcuEtpu/2F2q2wqSWe3kcb2hT4qjYIfEFYIbbDNcrP8kf5u8FWn822t3FIhxDYUAMlF0KANXbZ2FxNi8gn2HP7tFmyR/NJtJU4WjPsBKpZYqpdnOpAxRpAI4WIIr+xFXvzKAvY3dE6ihWKIh2cw08LQH82NEw+8ejq7dPeqxM/qssKKVIhqeAQH6P24VLp1PzXBgE0DcaGnxPDVF3lMEKio42lzMbT/5i2H3b9NnzBhyzHpQKNkzRRCVEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVw4FKGSt0MnZO4Y54bCwYWED8HeB9XbXP3CmZDDvoo=;
 b=Rmd+vxpD8bUpoEjRYjZo338apQJwEgdoTmkz1T5L7yz85y4tQuAeVJk9kTAfLsYKnnfb2/j2P7exIoeJPvryhLfa/ktfE6dedhXrlpDpp3Tr2TpYDoCwoSzetBspphz255dsPRDIMzgE1Zw7qS4/cFrf/9V8STYK6+n5x7XZye4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 07:56:09 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:56:09 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: free pasid early before converting a vm
Date: Tue, 29 Jun 2021 09:55:56 +0200
Message-Id: <20210629075556.12090-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629074914.4114-2-nirmoy.das@amd.com>
References: <20210629074914.4114-2-nirmoy.das@amd.com>
X-Originating-IP: [217.86.118.245]
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.118.245) by
 FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 07:56:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c445442-6b87-4a41-9353-08d93ad35b0c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5149711EDAABE52578C0E7AA8B029@DM4PR12MB5149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUcjmYazgwsc0Mz5hTVm6aZ3kW39x8dLMiOqp0bGHBbmi7y+NGS/vdw25CvPDcBIDFVVxCB1QJyXazQYJZEErMOnyx9zAl2k3VtVnZi32Q/yg0qsEySPtXPr5/j1qYYSL0KLu0vWjdPK+mxjlTv+QFNUCHUBOtBUcYkjHGeNp/Yqif6Vw+2mEe5nEZ+6cL1nz+DVw5e5A3gGHj6Y5l+RlEiqLBXaZVL/TdpzOE/xzo9Z7fdr5gNa/7qBqlsHDqD3+21Lnsh1f/d2b0TyKLNFn4ovHXylehysRW3Hw0XWb7pXM0x1dtw84jQr/wdD4M6zq6DXhw5wHtO/Rjmw03287zNwzsJjO0C3e+EsZnFRWH3fxqT9RZ8vVDKP9FmjG2P4b6Cs4dqXxQyfCL8Ks9fjLgm8kXGz//p020OW+zbMePeGiXlMmWfPyTB95leiCtXMWc6MDQ+XsdygdGM9c41HnvKhSlaZdj1zKlf0eb8S24QP/OXids00t9uiN4L/hwoOPAlpm5HaXnL3rEW2lyhOcqKS+JWBO7RGtJX2gmhocvi8KLV/5COExiDvdAmwwTne5mFygXArdFp8BUn9WkGWWoHWltt1NNqmaVSztvpl9YfP1jfFApq1XuXoxjvPl6JB28ylgEpnnEll4dHdpJ7kuzGj6Ay52UF1kxY1MfbC5qIw/pqnZpvQNxbVi5LuAIjmeo0So0zUF438+ZmvSgN06A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(6666004)(44832011)(478600001)(8676002)(6486002)(5660300002)(2906002)(16526019)(1076003)(6512007)(86362001)(26005)(6506007)(186003)(66946007)(316002)(6916009)(66556008)(36756003)(52116002)(2616005)(38350700002)(4326008)(8936002)(956004)(38100700002)(83380400001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYvHoQQftzOFQsnQdyKlM/kahbAMbVjqSHwe8TcXR51WCvm79/3Rvr0H3wsG?=
 =?us-ascii?Q?Scoyv05dXnbVEbsrU3uCZG9lVMoyZm/pQIT2pzvry/lKC/ZKXmRYmNyNIStH?=
 =?us-ascii?Q?XT+eWGAsOkW4fYkWQuqPba/1L7QvREDwC3GGOUgWYRhpBoXTZiOjsex/1LhZ?=
 =?us-ascii?Q?MhCJ8Wg7r8Gzm14OUK0SZU2+QMNBHfunrFxVCQQrr5P9PB46EUh7b5lAx0Ff?=
 =?us-ascii?Q?txeigkgATVoWusS9teNIMGDlXdgJ4EuPddthFa7QJUwNb4LkP73bK8KQIPAY?=
 =?us-ascii?Q?9njyYxj/1LjP5VETE7nAI72+5UaxrEV/RFt84LNAxvgXoHDkZP8yNP4RNook?=
 =?us-ascii?Q?Zd7bbp5edUMXktqgFqLRyhUREEUYDtIzknpRJrY1drnyOdrt/XzfrtCcAW2o?=
 =?us-ascii?Q?dxZsw0bsMZhUJL6zBrU84FjGLubEaU2UC5qlkIxdYUi/GywAa+Xb+zZEp3ZG?=
 =?us-ascii?Q?oiHk7i3ykZs7Bf7bCYIYtVbzGbuxjmfUC7+2Po84AkET0vfgNYsY0G7LDAJC?=
 =?us-ascii?Q?5wpc3JvTH8AbEPNAvKqKZa32D0cL923FvO5CQa88PAaW9ywyJnr++9FB0wdc?=
 =?us-ascii?Q?F7rZkJX/dL0sh7ZA7hgObdz4ahg01nU9+KVPwUKMLYZVvIDySJHXl8Q347rF?=
 =?us-ascii?Q?AwHqU5acdKQ5IMHECZ04DQkA5M7o8S5yAUqDk0530ZOl0RdasHwI/CkhNw5c?=
 =?us-ascii?Q?aV//N1MZvU/0p85GhDAEZvVlfdEyC/ORtM6lFnCCdM1Z42tcGdwPfuITSXoo?=
 =?us-ascii?Q?b+p6t74OXxnkcjqu+xxSq5EN9t9j0CPZhdVBpX5LpIHC6THE5ahTLibqzWG3?=
 =?us-ascii?Q?LGK7Dp/QpRkHNVcIU7Nkpu/ZCmxH7aYpIp13fXhs8XqXfL8mzvK8j/LM21Hh?=
 =?us-ascii?Q?BR6xqHiXZqDYBYCtme3oG5WmKKhtdSbsnN8aoVsUfdXyTl/JIgokk74QOddU?=
 =?us-ascii?Q?u/kyRgPOlbJhNOGcxf3nyd3lrczO6JwHsnirY443Cxlhm2r1ug1CkET2jleX?=
 =?us-ascii?Q?SNaQ0ugQFp4+hXwFRmAr50QBgzJfCRICiUs8cR1uyStRKE7sjlNtbT1ZgGSj?=
 =?us-ascii?Q?dBkPE0ZSrxzMv4ma3hkZbRyUsnyKkvrZqwm76eLvbyqhwvJ02wLBHiaBLHs4?=
 =?us-ascii?Q?T0+S11NPXXHBPnozNDVs8AQ0DNhPuV1JyZBITgjHpHbk0c/7mG6WkzEeQdNq?=
 =?us-ascii?Q?pTvSRwuG0dS/nV8BR9ky1anU1Ghy9FQKLWfCN6VEM5QludqpBRQG2O5SUtfq?=
 =?us-ascii?Q?+ejMCvVr6JFyOt/sKaGhGbtjY5j4bU0mo7HVHKPEg97Qbt5brXm8ceHYFdMt?=
 =?us-ascii?Q?MeXLDcSCDGRlylasBZKQNc1O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c445442-6b87-4a41-9353-08d93ad35b0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 07:56:09.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IECOuKd4+aO22NlVqNrwRV8h+VCWIEF2iQ+8xrZWT522Xx3hr3QjpDFXl2XWqhaHCA5pwaHDf7FvrIcVewL4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VM code should not be responsible for freeing pasid as pasid
gets allocated outside of VM code, before initializing a vm.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f96598279593..5a9006aabec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1287,6 +1287,14 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 	if (avm->process_info)
 		return -EINVAL;

+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid.
+	 */
+	if (avm->pasid) {
+		amdgpu_pasid_free(avm->pasid);
+		amdgpu_vm_set_pasid(adev, avm, 0);
+	}
+
 	/* Convert VM into a compute VM */
 	ret = amdgpu_vm_make_compute(adev, avm, pasid);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9b0e8a9d7f86..0bd9575b0872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3057,12 +3057,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;

-	/* Free the original amdgpu allocated pasid,
-	 * will be replaced with kfd allocated pasid.
-	 */
-	if (vm->pasid)
-		amdgpu_pasid_free(vm->pasid);
-
 	r = amdgpu_vm_set_pasid(adev, vm, pasid);
 	if (r)
 		goto unreserve_bo;
--
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
