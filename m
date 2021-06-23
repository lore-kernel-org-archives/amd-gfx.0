Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85190C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543026102A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543026102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7706E8CF;
	Wed, 23 Jun 2021 12:25:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CC06E8CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 12:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEL7H6iFrO4fQBiCrkZR1VVKufk+5KLwMftkYgBK3pIaovGzvSr+QcMHCqs98Jfr0vrF0GPHxznCOCEK52iQ0TadVtOXNJhbrIkf4jPx8iRHK+aZPXorHUVg0voPjN73wsKImYoUA9A1GdS2dvXufHzPF6lsRR6se9c6f7skhxdf1JeNF+CVjI5ov2rSrxtTdXd2WaTjlJKS+sxeF/jQjHY22VDNv2/6ZB/EY9FWPAYaUtcXl0r+YiDCAMgrl6JLwMQrgLDpD/RWMUDJZYACFHPzntNhcoF2DVgS7wS4B8XmtSkFRTH/+1kLRMpo+PPuYfXWzr64Fqa1BVWWAx5xMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLOm522SfTyLxx0dEHPY90BjsysUiKFdFO4Skfx22Tw=;
 b=Dmv31yTseFo0Mzdh5K5i1uX0ly/eTlyMJ1si8GOsseXNU2FbMRoFvHMqRkB0JLAsHglUVR/0uY37uUrExamIbOetKIJqRvGj7t6D70IPSn8e9PtdmLQeGnghdMcIYOtfb4CuFfktWp4w3S2ORWFx+XiAUrWeC6jsX28Or05McCQaduVt2zxpDb9hGeKC6XMNj51f2fvEjWDa/HyAxyPTlNyN0xTu6+gBLOaN3a5DsPaw8drq+nJh3kmVVjd9RjnxEyl16Tw45qJuuXPa39NC8c5FAHOCtyBMRGFoE+OG6sYpa3vUyHjW5XK0lPSdy2vuRofhDTHrXbHq93yiAPVf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLOm522SfTyLxx0dEHPY90BjsysUiKFdFO4Skfx22Tw=;
 b=R29/MMvx5R+TjKCTlPpR5aZLUD03jLfkmK+Hoo/S22P/zIUiEwNl6O4EyyJ4SteNpGJeWcL0LI58Uo5sVdh9S8MTw+wlCAe6z/NbPjegw7CVBnt+rhqPjiPcKrVBo22lj3KG93wG/P1dumQ4f9B82EIUVM/6pDb6Kdwe2h2yhFE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 12:25:22 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 12:25:22 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free pasid early before converting a vm
Date: Wed, 23 Jun 2021 14:25:05 +0200
Message-Id: <20210623122506.7397-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.115.200]
X-ClientProxiedBy: PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.200) by
 PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 12:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23053ad-0d08-4593-df86-08d93641f8a5
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5477502B51E9A83AC72F663C8B089@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZG9/gEvWOpcJ6q5OU/87RHpOABsj4EHorobB/VGwc2lrvUN3aPt/8sK97ASOE0ulk11IYD57YRwRn58Fd10IVhzGd3E98XgFCUXiMx9pyU6reSSdMUwE1IR3y760fMYMqWei0mVkT+PzN2jtpDLnC6eJ6AfFlMdGJQKroC2XdhDb8JdOgEyU7+42han0H6Ow1BjU8wWMIDljnKEUnbBYI7RJBIFIqhzvrwwQLA1SoPlDNV3Pre5xQTB3lDhiQ0vkLOMm+AsHS/hBurau7jtnFx+buBcxTS8501K3FRsfURXkhbc43nPpZbr2XeHIYxiU5jlf3BIKFYf95TXF3to2QavPWC+A3IDog4PX2S5sxS5A1gF4KKD16dRyFLbiYdghL3VrMtBmSBIQ8uxwITns4dPO3lyLZY6seaeggPfQbnVnX4lrfYq33WYuyHIHD/ulobhXZRUvu2Bpe3UX4HGMIgilo+8fjmH5AXw7L4FBS2cwKtM3Qb9uS8vv8/WSq5ic8un8aKnhI6bW0aRjoOhUlQVg+mil7i0Uebc082BdQs5rLIxsbhHyhF72zjnTGPjBEkBl++hAzEZ4f40kVkvVnOhHgpzf6pXexOPpQd/PbCCyOOR9Leuhbupdw+c7OjPwkOILeJLepPtHdqLeIQLvyEbj898MEs9DdG1xJePPuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(366004)(346002)(396003)(66556008)(6486002)(66946007)(66476007)(44832011)(956004)(8676002)(8936002)(316002)(6916009)(2616005)(2906002)(6666004)(1076003)(6512007)(6506007)(36756003)(186003)(26005)(16526019)(52116002)(4326008)(83380400001)(38100700002)(38350700002)(5660300002)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x5T9e3XQrWijywJY0i3cINJZqk3/ahx02lBvKgcPu1qIJNmfisBNv7xQoEsX?=
 =?us-ascii?Q?4kR3ij+wgs32mwUthV9+guxkpMlY9gvxZIhkmptRciyuWC7lOL3Wg5RWJ4XJ?=
 =?us-ascii?Q?EvnTQQmc4izts2ar2JDHnPfN+PIOfvG+HHO0LbX5m38ua1HyU1H75FtRZOF+?=
 =?us-ascii?Q?csINxRntQlHC2Ii3LgQKzys8ird7sgptKMf6GAC877yq2y6eBrKOmXt9gWBm?=
 =?us-ascii?Q?mon0UWi/OlOhmdf+VAzaq/mYFQZ/F1DrCuQ2DF+yTyHeh0hXI87a2vfblAHX?=
 =?us-ascii?Q?8cjqH3nyH9k/5YLWcHroBSrvEv+AMKihXf/3v0j7+Qvfm5uzgiu6ZmdSh1uz?=
 =?us-ascii?Q?KGe7dK2I5lJkpQf0q165bsjWD6+THI6Xifyxw8F+phBgKUKHSHZkLzUj0cSm?=
 =?us-ascii?Q?g/nLC4yqysrJzn8jHrhTVMFFaGaL6Okqzw7SRiYaNK6mjgcDdjXQHaC6apLL?=
 =?us-ascii?Q?d3Zv/I2rk1oDk+04ZiPw78YdiaFgIkQ9d/21M+H2/Yzk14//ZniIbxKMZbCF?=
 =?us-ascii?Q?TPmeo6BysxdisOa0DtmpVntCsqAviCQHtDHXoUlZAhFqQa8dL7aWm6pdjpe8?=
 =?us-ascii?Q?BIbNpP+01gBdLAhzpS1tjn6uUldel40AZl6Da8deFRCPHZBjefsimj2uOKEq?=
 =?us-ascii?Q?4/tapRXhicg0pjJ3e/Wto3oE4FRxYtkhypZs9JfOEv4nPOrEa6XYsnpWpjFa?=
 =?us-ascii?Q?lIK1lKnatJS046R9V1B3TuzekdfpUgIfrAbNSTU1SKHKxLenHxlKaZAnMlsS?=
 =?us-ascii?Q?8eRaCYF2u7ugxALu1Jlb5oIagOei0H70nwV53gy0+J9MG5hDLmcwrz5+O6d2?=
 =?us-ascii?Q?DsdP26eMFk7dntLX4gvPFQvm7zBpCNfzFeV1Ui4mwQUU27dNw5KiAY9ia0c/?=
 =?us-ascii?Q?tpCEW/bUbO3z7on/SJ3Q2O/HrgG5YqkAZkDBbtgliBlobowizmM81qR9W0tC?=
 =?us-ascii?Q?FpILjY6Ai57PmyZ15rLlAMWRgdvY5dNLBfbE61r3730Lh/VDeXqvEX0kFlRj?=
 =?us-ascii?Q?ruB7CkA2eLSwOL2qgONSazRiab1xPYyFWyT11z9qa8qbEhUQ1u5tUvBC8MTA?=
 =?us-ascii?Q?fOQg37X+ef22aCL75hvOQLQtzOB3RpHeEBlKCBtqa7uGv+VIoleS4By4Tew5?=
 =?us-ascii?Q?ccUj6jiCGj9QEtkrLYyBhfhZy9G0bP4J7A9YoHVxm7WBMTuvHtLXoM9mxO7U?=
 =?us-ascii?Q?7mtAq8xm+ZNUiAtHV5vslKgg4fUoYWfDlc3J1tA/mVHx1460HP2pHaAMdfId?=
 =?us-ascii?Q?0c7JMRhMhgq187z1Pi4K1Sl4zioRo/QzRDyjh+DkX556J3aSUFoIXOg+bPm/?=
 =?us-ascii?Q?SdubWK3EmuHPaxlXvzGhViag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23053ad-0d08-4593-df86-08d93641f8a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 12:25:22.4479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrpENiTD5Sy4R1Be+dh5FshgCSIEqg/TUowljNdxJSlMAEdCzAKGrbDsQJeNZ8wW/5pNalBx4W9XpMR7Y7LCDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f96598279593..42e22b1fdfee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1287,6 +1287,12 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 	if (avm->process_info)
 		return -EINVAL;
 
+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid
+	 */
+	if (avm->pasid)
+		amdgpu_pasid_free(avm->pasid);
+
 	/* Convert VM into a compute VM */
 	ret = amdgpu_vm_make_compute(adev, avm, pasid);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..be841d62a1d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3094,11 +3094,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
 		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
 		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
-		/* Free the original amdgpu allocated pasid
-		 * Will be replaced with kfd allocated pasid
-		 */
-		amdgpu_pasid_free(vm->pasid);
 		vm->pasid = 0;
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
