Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE818C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 20:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A3161104
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 20:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A3161104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EA96EC57;
	Fri,  9 Apr 2021 20:06:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BE56EC51
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 20:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYFotoQx9lcOaxVDrJgbwFBj5Dwg99u1/uI2cZfJu7A+I++avJFW8CRlT4sL/KUD0NKdeYT4v6BqaAFmV6VY0XzgDRsJKybba0rOqtXzuKO090vKucVzfbeo5ZeXZhtkfcOnieGPSrXJhixulAXUBfrb/g3v6vlGrbu4lUToJPVph0W2vZeHuDIcMVqAzXHn4ROd8aXUeZSDbUSJZUFN6K9BGzF/Y/qLMLt/cs48sleac7iU5o9nzHTF0lzOzE3NrWilfiapWxAwLVfGGGmbLFxbtl2In+to/8nmZo2xGz30bgB1UWhKBfP5oBCSXLTmpa5Z0mg4jft5vxTeB7AksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=non1KG8G0vWOFs3jezpFkTR8WrQZsU/EcaPpqDyT2Ms=;
 b=PTgna3k7ZmtScBDiBOV2IgMe/iGiU6ZOLnrg9Mh0nn2Chp1uLGnTd1s/2wdCVza7Y36P6J6S4Dg5ZI7rSVGFIxmX1K38Ux2RF8xvVxLIDuJNudEooYYQqX/dB3GlAMewtVPxAvpMrqUHXvAkHXwGFlbth4KALoFz7ZnhWgoqsqo46gJvvGVmG2GyhNOY3DXuBLrL2P4HNaoDdppMdogjnXM+oivKqttNy2jppPtxTz0TTLtlC7dNb+8C6EsnR+QdiwDoTA9zTZl+LZLi9rZBvXjm3oPujIKVD/eKsX7AMcpXJdHlLdfnyzQB49MBytmYWwPVf+YM6UkGDMp/Zl5R5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=non1KG8G0vWOFs3jezpFkTR8WrQZsU/EcaPpqDyT2Ms=;
 b=MXNSTmBWHQh7ix4m5iqy1grodCKhP+SQG7OFD372uo4QlAQ0CoSCAUxGzk/RWNriVsqQRWdDyBFUB2yNYr0p4y7GwLr10t0Wd+7LjRA1im7Mj45NmQ1JAFLqupsdrDjliGz1DcsYPM8nwdxNv21cnmCxv7z7QIyhLrhJHjnfdOY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 20:06:08 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 20:06:08 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: change SVM MTYPEs for Aldebaran's HW
 requirement
Date: Fri,  9 Apr 2021 16:05:27 -0400
Message-Id: <20210409200527.30234-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409200527.30234-1-jinhuieric.huang@amd.com>
References: <20210409200527.30234-1-jinhuieric.huang@amd.com>
X-Originating-IP: [2607:9880:2048:122:cc6:98b6:aefa:1bf0]
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:cc6:98b6:aefa:1bf0) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Fri, 9 Apr 2021 20:06:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a03ebdc1-14c5-40dc-de7b-08d8fb92ea01
X-MS-TrafficTypeDiagnostic: DM6PR12MB4091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40913B2F35075E668A23823682739@DM6PR12MB4091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtqRboh5BCL4ZRK/cYeLKXiANM/zTsE+qQ5kGg3Uwdtwzz48tH7olWTipr2cmiLy+2HwXaYp+DHJaFo/ghP15pNUVhW6wsglcDnPs3HISYFMgYtwghVoxt1cR1RQ9WYQezzV9yPCkHhoNT4lI1lUOmXllRMItyhPFLXG3L/wY792Rc0RAyU5mxsNAMZzGCcBZ9nLfb0UesFrL9sA1XUkQHgTzXQxoJOpK06XwKlFN7pr68qQ4JxhPdwH2dixuNDk4W2Aouf285G5lwbNsmA7LL4WVUHknLr9/WVU6WTPCeGjkOtK6lL1R6SOS+sMnzCZtWUzZHWXMHN9bw+Upwfs8nCeYj58fXOCXxFlyeWAfDUw0t3pCNlnhExIui68h4szDolEr7yJviik/LKRn8gFCZ9vewHqYiuhMwlvvqkbJ+YSAfbcQq1x2MvEKKbAS9ULQ5IFP/e1W3Jj6E8qxSfK2qfoBsCSbxWHhDwuR5u4hnd6nX/lkTY0uudLr3n2Jb0LnGbIOKaHcR56d7cdJgaV/gOa0/ELR3Sx9kBZEPO2KTNGE3WceQk7hTXMeq88L9Z+po038QaH8gRvJYBwirq15NnK/F2tioCHX7T4wc5zMWESQ95CoyY0lewF1g/dEZHk5h6lLRzrYBYI9lMYLoRdyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(316002)(8936002)(52116002)(7696005)(1076003)(6916009)(66476007)(66946007)(66556008)(36756003)(2616005)(4326008)(5660300002)(16526019)(6666004)(186003)(38100700001)(6486002)(2906002)(478600001)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xZHc5ohXJM8JQvN7eICDoK6hHxQK3I/Oem22zbERb3wZmgKEeYc0TEUeWNhU?=
 =?us-ascii?Q?zR/fjsK6h+TCcfxFCtxi1Hj35sBb3YMmIriSsfF9wxjS33fSRDRRoTde11Vf?=
 =?us-ascii?Q?vczB0xDWEtEl1eqTCIvRYXdbcolkZWoMsyELgeca8b6607EqyqIL2XvYePJr?=
 =?us-ascii?Q?Pd2UebkN4k6ortm9Vfayc/yyZFrvbo1URySGoLa0uDl8jBsMmT0ndIBH6R8R?=
 =?us-ascii?Q?admdwuWlRh1eEm5BEFjZEeO1Rg1Wj6hM7XUgsHc6I1o2XzZK3wnggVT+UBkK?=
 =?us-ascii?Q?t/BczbZBZuJi3OK6/+l+h8k4wxi2BnGSetr0goOR+pm7earRUIGg54MybwyN?=
 =?us-ascii?Q?ioknPIxBscSJv1kvNIoLXgioG3L7G3KanlI1wnnhWBYHhzWJJrk6xWLg5Lm7?=
 =?us-ascii?Q?w1F2/nbGCpjom/ej3Ez9AhCMCJV2xHvqDT24IRZS03zbgb7HdDmoz++RNUfy?=
 =?us-ascii?Q?kPzEHwfgdR3KXb1ucwEd5ruEC/7zLSXEjcSXMfLngjVserU95X+S0HU5VPMV?=
 =?us-ascii?Q?xOHrfLi9wUhF+4SQanyXzKAMGJtAUq31djVJJjRTQs2RTKDkEVCrjle34mH1?=
 =?us-ascii?Q?Eo5GrH3jivDV3dl/4TqbcVaYv63fL6IeTq1E0+PMbRSfzxvJCeG0nOQvsGUn?=
 =?us-ascii?Q?Wn1WHhp+ll6vGywoCQGBlxr6Dg0evIFla72GMR3B9+a5wjXMqw0DKU/++ofH?=
 =?us-ascii?Q?PgJ4E/1K/RtafmgiTHsRwdGL3x0DGz5Ni+FLVQfCEXzJAMsL1A32QZkAsuMA?=
 =?us-ascii?Q?XHyM+L/yRBq50u3cisaXLNf6zEhDe3yzhmBiOdHhXf6Vn0ngwA9fJFfW+790?=
 =?us-ascii?Q?/NXO2VyDmRQmzDECLmcjSwHaxwS4TNj44AOWZ7gIEiGSm2ZTn8196BYzAXsz?=
 =?us-ascii?Q?GJqqv3bOAih0xlwW27GwOHYCL7YqkRk3TtH0RlCQxNbv0/zZt+thNcsWVHHp?=
 =?us-ascii?Q?4k1MGiilZawnAYPhRMKA48FIND4o96IhGxT5D/1TuatZ8xlt67EnITFH1lj2?=
 =?us-ascii?Q?fNiG832dwpGWItw90MCn7WPBhh8oVEJdCuBbMQMCeUJBXYpM+xEkTxrqpXRx?=
 =?us-ascii?Q?RcoVUyv389Ru3Jc6Y0+pWkr/Ulsx8NwvysGyqDXME8BSeic5gWtxIAAngAhc?=
 =?us-ascii?Q?kAWKbrKfijn8mKp/5TOWWN5RvpicZKZ/uX2ysCoAE3N6byvYlnOdveC2WyZR?=
 =?us-ascii?Q?F6Op0a7mABLvaRK9TaozD0qvLgiNdY6+BXnq1n5VzzR72HuRcheXSmWw3gFP?=
 =?us-ascii?Q?4X7dNTWRnP/lwPOnDcShMRRMFZVU0LUKSpMn5S4xPuBQGJKVtYtneMLw7/f4?=
 =?us-ascii?Q?J1xWgQDNRus96U5ujL7jXJZqWYc5hiMZEAIzWPzJb0eEz9G9e6QfZmDIcjVx?=
 =?us-ascii?Q?+xUDLpMjMrqCzQJJMlmZaYo1j7Y0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ebdc1-14c5-40dc-de7b-08d8fb92ea01
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:06:08.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/6SvaitsGIoOOOPQ9cpOHZ5djP2jO9wjrSX+qE1OusIM4rqwdqdRdN8hKN6slh73Z1it/OK/Yme+roo6Fw2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: Philip Yang <Philip.Yang@amd.com>, Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Due to changes of HW memory model, we need to change Aldebaran MTYPEs to
meet HW changes.

Change-Id: I0b566ccd1d406abe93ee84da91216794fc650ed4
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e8a21ed3a361..a66d0a9dbd7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1066,21 +1066,18 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 	case CHIP_ALDEBARAN:
 		if (prange->svm_bo && prange->mm_nodes) {
 			if (bo_adev == adev) {
-				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 				if (adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
 		} else {
 			snoop = true;
-			if (adev->gmc.xgmi.connected_to_cpu)
-				/* system memory uses NC on A+A */
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			else
-				mapping_flags |= coherent ?
+			mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
