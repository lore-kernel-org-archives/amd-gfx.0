Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35932C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 20:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E867F61104
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 20:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E867F61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722216EC4F;
	Fri,  9 Apr 2021 20:06:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17AD6EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 20:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/WWrrDaNtSOP4LrwJxOSgoHJwEWdWOVxqHMZ4RDfJxEw57B5BPe7+qOzKzuxPnGhpazLuBk72DrkaKXIrz9T0AdLPesbNrVnkzKLcErE8OTcN7jhFIZmF0GBsMKV4G0385Zo9R5qk1RMU42cVAORtk3kD/hvAdSruujjIxcOwEM9bPBVXx/sDMqlb3kfvxpmL0dujZqNs9W9JI7AMvjn6N74thW50IgIhdJwN6hC7iyiTBC9pKaTFZSicJmZq4g8IxYO4ThpHzGZTQ9YttNmhKx7WAVhIZIm1g3nFHccTsFu7MUVg0nbBhyJRhF/5UhwFWigmmHRavjQNH+9ffYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nn1xxshizBWEKKpCfIYEdCmJHLWw5ftf2hHOOl/hYA=;
 b=bRb5bGKlnoZiYeMn/+Ngx3Grkds8xz7IK6Dy5tYy3Qu9/EKzxYW0+LgVMVW2+EEh3UvfaJ5cOnF7d5NW8MQfV6SvmyKhZgEnJTw2xrxAXgDq4Zjd6rQIKaB0ckZdx0ty63uyB2+wvsUAcaJ1/hleu05v3V13qGQ0QXY4KJzvuQkL/pDFMrYhyGghjncmZ6/zGG5TFSLsGQiVyP5KLQnyTXdiU6llN5GPWy0JnvvcyY+TnCwLCroKnTdnr+iMMZ+/yWwnb5ROum6+6RZPFa2OCtQ9MeATcrxft5uUOhrjiVo29AksuK0Qvo8FRB2tBTO4m1+mDHHig6++ELWdvUJMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nn1xxshizBWEKKpCfIYEdCmJHLWw5ftf2hHOOl/hYA=;
 b=sq+5WAi6Z2Ya+NoIEZaJTzEnGRgKrGYbrqDieIqH5980l7CPvfEBP9uYYRCwO87q9xqLS4KZB+r1izVECGW0fPBOR57kcKGUfWFsZC5+PqIie+pCdLWGfLcrlC6JSaCLl46ScSH50lK/avpyzJ+dIij6YkIg/7DxCBJzWc6lZ7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 20:06:01 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 20:06:01 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: change MTYPEs for Aldebaran's HW requirement
Date: Fri,  9 Apr 2021 16:05:26 -0400
Message-Id: <20210409200527.30234-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
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
 Transport; Fri, 9 Apr 2021 20:06:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59882816-9734-468d-500d-08d8fb92e586
X-MS-TrafficTypeDiagnostic: DM6PR12MB4091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40918A387C969DD9F97DB85F82739@DM6PR12MB4091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9/tJOuoXa1jlay+d9vHMW5x07xxo8udQ0CY8+rO/xsGUT9YyU57HRyNkj4K6PBI0PVzQNZln+4MChu6pSLfcOotSA6BqLNFxt5d59ThVDuiaeRsviWZgwjoOqVnNGAWYOj8T51asxy7bX6aTCf3lxbPjgrhiTc48H3ExN/yPUYX1M8Otboss1n1K11ax6H3TO3XRmtOuxyteGulz5tEGlTag0t7jRjFcYykHQi6jf6HkgAIHHotyYiU+gTU8f4MscJiu/3XPgFJVQTo0yVOj0N+Hr4ic+TnKsFLOx+MVvFlq6TF+aN2Be2d9Uhi1+E87WFyrP8q22mv8q0A8uuLWqGXWwbR/iC+7jmzfL5RoI69WUTzTC5kSgitCqvijnk+S8HM5XeF3F1ypVjfytRdIrMdq+2GHOyq5VjT0amSifA25S5kTH6jHs/d0NKSRqMsFxdh+MTJUbpKZMTchOAWik6ZVdbfCBBETApEttmEPcsGPSi4T92E2lGRKouGONKLYNHu0K5qMbt2P4JwpkUIcTTOulHSrUaP4Qt/lGwOjpTVpdYGT/+VuRTKJ8bhd3b2dSbIKSYsLZPNoJm3HRjOtPKlgfK0tRcg3XlKwqG8WvTHWD4rAszsuBppIGdWVEsLDqWaVOs1jWKH6uWZFxANFofnAc7qsES89T11H3QpUuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(316002)(8936002)(52116002)(7696005)(1076003)(6916009)(66476007)(66946007)(66556008)(36756003)(2616005)(4326008)(5660300002)(16526019)(6666004)(186003)(38100700001)(6486002)(2906002)(478600001)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+H5tmUJ2sr8Yx5qIACFVae12kFcfAFNppIJ4W3It22ksslwOabcSUMOx58Cj?=
 =?us-ascii?Q?Cv+TfKgljOnOzbI5MgX9NYdbZWVk+/T4NL/uTFeAq/pB3fgnaaVoE3g7UPZD?=
 =?us-ascii?Q?u/qCSMCkNltbKgJ4Y6tjfDGx5w0qo5hwr951hxeyJ7FjMaVx87xz9N0R7VUR?=
 =?us-ascii?Q?LhdIwAe9zqFZ9sfqSFAz7ynRgxdI8UcDOkyZNrxQe45EQaopDVtH5l0SaAG8?=
 =?us-ascii?Q?8HQxi2AVF/qxs7tWG0YhRVg8gFVvlJ25I/pr8R9vkgRPvGwzIWTIATZeVst8?=
 =?us-ascii?Q?eX8OmIDbW6dTQiOycOUIsxJUXumEsgQk6r3sW3SGi0rsoKCqsZNHp3u917EF?=
 =?us-ascii?Q?clg6/70wBR7tSpTw+FpL4TVHCf/iPpEpNwH0wAbs8ArAVv1O+Tt846nPUxA+?=
 =?us-ascii?Q?T4NKjvOz/bmeCp6jo6GefEl9Im04ZIPR+0sEI6bOjkEw9DG3OIn6YxwKaXOU?=
 =?us-ascii?Q?ZK+x1s59PEM7DMjj6YX5V+bdf38IVnFpxzPUpJWteT8GlTtr3Qz2Pnmp+wo6?=
 =?us-ascii?Q?6BNydvKWagbu8V9DSrQ0G2SOILkNz518J1Vcati/jzMIPFksg9nglgxH55bW?=
 =?us-ascii?Q?SuK/ECEK9iCfKu6XGereqhMx0Xnhpt7zxvc3V5WbYHoVFYwdjJFy1isX9s4y?=
 =?us-ascii?Q?hY7/7kDqcW922OHi+hvbV34AnblT9UbKLOkJTGOKDzLQydCGs6gvwK70thRG?=
 =?us-ascii?Q?7Rgm+E5nrl4UF5oHQknkuB/bWKByZ0tZKeAmLN9e7YC3PUAZGhHWlbStQHd6?=
 =?us-ascii?Q?UKBeSnLEK3beotaWp0Vfl6WifAQQc0cqkXHTPfixNyo+6ZS2EMKp9zDOXPrP?=
 =?us-ascii?Q?o1MooUVVxtouvQoZ/7DuGl8rkPHFBYF+tw3ACRWmsJGkryaThdgkar55sotN?=
 =?us-ascii?Q?eUFXiJ6aqBgpoITnn4gvAfI1zItsxKD+Aiii5BpLWzs/UodCFZG5HWO3ko0P?=
 =?us-ascii?Q?oDho6xyyfwJawe2t/zOisDdk1u7kQ3cJwRVad9VgHkj4MtyjB6qIgBO/StUx?=
 =?us-ascii?Q?NO7zQhbAtaBZOd6blaInbXpjDORXG6iUSEk+geO83S32cgxKvHGtG5Ts0V0d?=
 =?us-ascii?Q?Bl6YMM9UkOuzspvEyp6CxtoFm1plvKHjfn/odYwqd/O8CBPxatBvmsOQ2fzz?=
 =?us-ascii?Q?6oGazDgtq/q6sDEaRb1aZunqCHloD2C4rutwxJsGUcNWkoqUgPvDzPg83ZOV?=
 =?us-ascii?Q?1dUIUwWTd884jbNdNMsvIzi0f/aEQa4zUyuVHcPAxidgCxf3Ba7nGKYOflq+?=
 =?us-ascii?Q?bPdnIS9dcNl5uFCW4LVVZ/n6qZi0vRAumGF8Sdwe9yKaAbdew7/OXhhZ5tvb?=
 =?us-ascii?Q?WFhaEa+mOp9mjLab7YDCzUH5xvgP5S832V8/hPQChU461iF8+q1/emTRQKZI?=
 =?us-ascii?Q?Qk3eW9zIklPhZms6tVkFvI3JQniG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59882816-9734-468d-500d-08d8fb92e586
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:06:00.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvjMJqbWQ1M+ja1hOZrLkXSejY8WvVuEb3S+mW2vlhj6KjZJ0ND6qabSZNxD0w/6TShIdn17jiDPZZiqZg4LIA==
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to changes of HW memory model, we need to change Aldebaran
MTYPEs to meet HW changes.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7357c1e4d883..b6662f53c28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -439,22 +439,19 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
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
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
