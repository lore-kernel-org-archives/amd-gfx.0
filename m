Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FEC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E8461175
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E8461175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D7A89BF4;
	Fri, 23 Apr 2021 11:18:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B48897BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO4lmg1+qUMFQ2pzpbUdmVRw7y0+7CbKhIRwBlNcD8N2vcr2lodVUWd6CAn8cnBDdw8554750K2lokiDZoSdW1cwr9in+XQvPoyqQUBK0pFzrYP4K6xcPpUm721MT7Fb6kZlainNMLhcu2xxTW2ElmJJ9OB20EZS3J8xbSYnj53xB7SBPJvMEZ/iPLP1dxdVPZXwxLT17+3TwPncwcxP6JbJM0QjcXGJHg4RtJ394E9AePSPEzloouVeZ7gJyVz8Ejv23E7/wh690lWHCPFgThFf/k3MEL5nj4zlLSS5dgENiX9hBdQwau2uoG7XNn16M1doSW+QLQlG6GXB5IeMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEBIfuHMKmfkEDCc1PoAPfmtHRvNC66DAtFzfZBhNY=;
 b=OVNOXVb4p+BCGBPHcLqhP7mtX2UCGOeZiYmN67OZYeqh73vCX+WvNvYyoi6rVZAY+dmuKQvc1dByULsZgrm9Y9h0QwC/wehzTh5SduFmuwWzydRymeLrk5YcBXss43ZHRAXjgdvWRQh7AbRTB8n6JH5a4++N3aQsFZhGBNRnIl+jJoF+S6TJ7H13U5rMd918iv1NRgqNQ2hR3u5PECNB0SUy/JdA1JHJFux0hx9kloLhKKlc3frkWp+5v09+95CKQbky7OmDLG8wLadjjz64toNq7GDt6QfP9AO/pO/uP+D+LODcUeLKO85eCHWeNuAEnIM2me347RO9UxgY1aAOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEBIfuHMKmfkEDCc1PoAPfmtHRvNC66DAtFzfZBhNY=;
 b=oC1Ftd6Q7kEoMNQeaF3kwhOm12m6EqunuBkV67TdRCPsisRs0J6fp+CGkL/2WvwUGPWW4DNgkiw++gTqb7MeN8IYQwXsUzeAQGnI1M9hY/AfWIBIwVXRs2ShQ35N3dHVHrVSXFG8mH1BBnEI3S+CPCXBn+eOM9EKC8rUS7s1X1Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:18:03 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:18:03 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/6] drm/amdgpu: remove unused vm context flags
Date: Fri, 23 Apr 2021 13:17:27 +0200
Message-Id: <20210423111730.2345-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:18:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0426e1c8-5014-4aa2-e8a5-08d9064975a8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1462787FCC61462FFE75D2218B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ohap+iA4Jge+9TXgabKiahsUUgoPIMAodth/XflzSr3SzHAR+4jlWPDkuHTMbVLnoFkzcsRwSMPiMuRTDL/LpprHZ91mRQ8nH0MJt+roDT7cjA2bB+ugz+wbE9gnVuspFAISSH32lJ/rL32gO/Uz2tpr4Vmbx0+HarFeyrrAcaq4qwPf3ysLdOYd9JzI92A4lRjcwI/qhGHZhPZk+WNSBvXHVw1zOva7Mx5I9H2cPW/JHMondk/F1s4S1GJQPp4uzUnyL14LdAqZ4cJREikQsSO/UhcEHCV/uI0Ug6Uw5XIxNvg+atE/sKSKXlRSUex7+JWh+tVlvKAbBMhKnDCi9vsvWovk/7LuNapFF0rXG/qVIe9oOdZ/KhhYZvpFJROFczyxJJ8ewB99yFTEJn2rp5KXyYYLYiU3ziSBQk91QU9n4WJ1FI8EjgYELTESXLzFuxM99z0uLl4ZjEL15ea1oOqenxm2c9zfAnTPKtLz9eyxnJdjI8MZDEAUrsGFDkEnXoOb5Ooj+Co8GUvO/wH7JiV/tgLKJxgD9Sj2QihtJZ7yJni3jKgfuviho13IF3Vw7Let/DBPJx3rTFk8hluJeAAFJF8M+1WbdvRbBIe+2jW03vWyCB5JjcXSz0vabFBcua3uh9jySsOsbSyQqoZ5rxH8SNlhpU6KwHwQctWRY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(54906003)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(4744005)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OkYsWb9dMQKLi/4DESZtAguWErFI3YZxYRs7ZmP+J3uTbF4QMUOjWXNJ8vRI?=
 =?us-ascii?Q?PLvcDqgpSzHTDdoe1jhfFuiSJ3gQb6B/4iNn1JBSu4QgGPoVEFg2Bt8leqdP?=
 =?us-ascii?Q?qcfnFVY/47fwrnrZrpOdeD+PG9fo8ONlWPo5K6hyoWOTJlNyJIpTGKQ4sa+m?=
 =?us-ascii?Q?/HB77kG8+QNHBchDMcNYukVytLqzmzed+UdAy3+mB5Y/gx0EIgDwbZktHSsG?=
 =?us-ascii?Q?0EvB4RFyo5OIjJ+6LK7z1aTI2m0LdPMS+PMXlbiwmixpAaXrofwrfBuGX8Tl?=
 =?us-ascii?Q?4j/WnAcVNly1J7bzWQDZ1+3pAKChFMGlTSgVi9qA3idQ1mPog/dCPLU+vThJ?=
 =?us-ascii?Q?mm/hRl6KOXDn+QwE5zTTa50HgDW40Q5MVwXSBAUtbkr/Qg31fvgVVyATXd1R?=
 =?us-ascii?Q?e68XwzeqUKy2PraD9hog3FqIGyNMs8uEznBeShKzFTBUzjStUsP9X/XMKS8I?=
 =?us-ascii?Q?q7a3hyyZLjzRPoYldEUs4v28fgcTb/qn+PfKWFgkRPIMHh5SNnYcK2V6iyG7?=
 =?us-ascii?Q?hjS4Dc3/YF//7PKxGOk9zN7/C0AZuXCQtkCMQOZTCXLdjw+vCJ10j7uldqza?=
 =?us-ascii?Q?CPch7NrZH3XSCOiRWb+MFfOqMsSwGJeT79ljTxDHC7Yl4mbB+GFQAeEE8jAc?=
 =?us-ascii?Q?bJuZHwGjmI8qI3NRKWr2ccUvbyLyw+VeV+cwgginQ401nofuH8S6gQGcLUeC?=
 =?us-ascii?Q?tDfcGHZrwgHCF1WCa3qU6SCrq3C1ZnXO54/HOfxS1Daz0pg2RoVnsotPFE2h?=
 =?us-ascii?Q?hqlO91FgcljCkCO0eyedSccFfd60c6fgfCllKfmQ8C5A+PjjU6dVNZRYNxCk?=
 =?us-ascii?Q?Rkf9ucDHSI+J+cTW5NLgOFlTrc91QtowP2G971AuUSL1zpVi5Nsm3ei44ExU?=
 =?us-ascii?Q?Zy6FMNsNiJUTa7Y9gf6+W2cPbJCBHixKPDTyuMsniKYJ0uXBEg76ULp+2G3D?=
 =?us-ascii?Q?mFPAvmQd9u/wyu/f3/YhiOakoH6XowAd28MWz6NqSvXOrVF4bLkKdjLE33F5?=
 =?us-ascii?Q?gxIi0XplYYZB53OluNeTbR6azKrwtjVWx60IF0zxlDxLnDtKSaEx3BefUof8?=
 =?us-ascii?Q?sVOHC8YiTrVWLQffZW6JEWqctTniXUaMfIEJaFLClQNYqH6Hb94iwCmzSYIu?=
 =?us-ascii?Q?AmyvFJrMR3n+QBJhkHHuJ0RZsCVMtDSt6Wli6cgF4WjEH4S1zyTCGklBO96x?=
 =?us-ascii?Q?guFmVBTIrwyGVG7pqrQJOvVdjQ9PDOKrim4arldMeMaEdtm8lSfEjFaLqFcR?=
 =?us-ascii?Q?mC9Qhr10jwWq00/SJQ9XDMUadELoKp9QHdVGXiPuw3sUOpDkJVi49kVsndlu?=
 =?us-ascii?Q?CZDmkC2Cmonw4QN0giKanIZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426e1c8-5014-4aa2-e8a5-08d9064975a8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:18:02.8497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HoSpdbYB7ysoaF/9RL/JlEMJ6IUTxg7da1pQ1KLXBrxCOZTMY8jO3xZLpBZ24Uw9WgqiHp/kUpYwLKIJqH9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused AMDGPU_VM_CONTEXT_GFX and AMDGPU_VM_CONTEXT_COMPUTE
flags.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7f07acae447b..6a9dcedfcf89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -121,9 +121,6 @@ struct amdgpu_bo_list_entry;
 /* max vmids dedicated for process */
 #define AMDGPU_VM_MAX_RESERVED_VMID	1
 
-#define AMDGPU_VM_CONTEXT_GFX 0
-#define AMDGPU_VM_CONTEXT_COMPUTE 1
-
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
