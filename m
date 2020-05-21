Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D3C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2145820671
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SKhD9zXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2145820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50E06E936;
	Thu, 21 May 2020 14:43:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A846E936
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqoxR3rpwynzLd7p9Ejgd3FpBJxWtuB1K9dlBk/EJUg2Fb2IfVN/z5dMW3r2osLB2DapNZnsR7d8R8SsoDpNaDbIZgdtuIW0Gm0dGkSAg+lhUlmkMtQHCX/Phh/RwE0TjV8jF0hIdigVWrz13OZTqXWlyA7W37zMuN6i2RnIc8RiFIC0FSTZtNPMfBt+Fs00o3u+ZC2uqX/xCNe9rNR/fJLuewWXUiC9xHwKpFFSMu9vWFLLjk4WGqwb8JIGBCU4aameE5xVVkkCYxSHtzJBhfimdnqceqe2Aj6xPnJQefXJsT21Z2QlRS6jkeAgqujt3wmgDZQKwar1JUfhSXTZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ1kq68B5tnBgUmcuyDf+QaVRdxAB3mnpI8w1Pj1VcA=;
 b=fxKYLfEzYnKjpFO797rss8dacjBCNjPv++TweFjw8FkQe8QgDlvzKlwruENkBJdob+gukJyJHG+c4vjcsiuEFI+ir0wcFwyiqeKsZc5oPD2gIckWvJmlbZOxLWdZD/LzQbYv3o1Sms1FbNqDKEPJnlv6UlzSru/CsLop9EKabFu0BUc+IeHhRwgdXHC9uoRMmu05UrjBvuo4KyZDZedf5Wq8BXh9QYEOOWnZ4COXXTY0/yBrMp8dMTEpTTWjbv0fO2dhhUKzMrm3uVR5yft/+KbLuNr9q8Rvfaa/jlSUeU1Ny5RvFBFeOTpBBZLorU3TjB1vdhApVvNee2yYoVqbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ1kq68B5tnBgUmcuyDf+QaVRdxAB3mnpI8w1Pj1VcA=;
 b=SKhD9zXOpW6tmljDW9sMSVcwXOsZd/YuXA28SZXZI8weBpttwHTxuZK7NxTLpGy96exli3X4PkZD9Gn8fK0SSxzDkkmVrgFLSryOMvvxGKlZiEO+GvDFwC9OaftQsf9bRL72IIdmu+6fzOTqG5iCsUbIvSP+Dt2ak6Wp8TzSF0o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1404.namprd12.prod.outlook.com (2603:10b6:3:77::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Thu, 21 May 2020 14:43:07 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::413b:10ad:34ff:dd3c]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::413b:10ad:34ff:dd3c%6]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 14:43:07 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix restore worker race condition
Date: Thu, 21 May 2020 10:42:52 -0400
Message-Id: <20200521144252.28102-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 14:43:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6686ff7-ae58-4d77-6706-08d7fd954668
X-MS-TrafficTypeDiagnostic: DM5PR12MB1404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1404387B2EABF155B56CD7A9E6B70@DM5PR12MB1404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMXtSQQQMwdyvBhVJ7gZ61rj7sgtVIWbfFcWPfoyO3G+tZdHgdxkjhYSpU3ftg+fvCntRjXmBq20Orh9vSfKzzUbjtLwVUoLOrlZoykh1fTkdhPn/y9IuiPc3xoUg5nNtVXXkS/WiXXb463zTPzKqNvY0pUoX/D+UOUZ3GvQACgMpQLdiSSM05bNpitup/G3yQZntCH4FzZFM5CB74HoxQ/9Hm7OkWCMp/ARSr/Gm6+MgJfB8+ApDs+fCrHDohrX+Mu5ZdUiidbCxwLb27e7oKIB3OjBfvjzvu+ojT2sz58t5vQX3+F5nCPmjVWVXcj9s+Py07SHbqBOFGVJhuXhI/QzQg0KvAcHncXB1/Ic+ShgMGJB0nSlGD4+vRt2VGyvEt5JcWrbJ1pwFrkl/ujOdD6ltslkAyaUgr0yQBYqPM34YB/7nvOSqzBnH3lsn9Lb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2906002)(66946007)(36756003)(316002)(8676002)(1076003)(66556008)(8936002)(86362001)(478600001)(52116002)(5660300002)(66476007)(6666004)(186003)(26005)(16526019)(6486002)(2616005)(956004)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VYnw1l69g/PzvBzHTGvEaX3B5nUv7te3VRWrfo9c6H+i2M9DH4WOZTNcP7dnlFFCE+hUivk2gE7XHI344d9Uj6e569ELGE1H+wuDMbBQ7jJv7TLgILUpE4D38YiJBhpCgyzocn/Az3fhVck7QsBYr9a9LsbL7R0mrnsh/v9VZqSrQya8qTjzxgJxtrYUlTYu3JiYPeqV3u504dOVEXoM4pPnsa0TbXWZJpY+QHlz43D9AO606UQuEpToV6JPWwndyl7d7iuvAb/DvtK7AEiuyvJgudXloQR/R34nRjnrk/OBkiJYREYFfb+RVysk4KUvkQj63iBuwNXH1v2trSvBMOB+fDMRADYYu/62PNZItUx4kNZJ7nP5a7kxEPu9wzThpNDd+Ra7CSzaZJnv25VrMcf54MxZvLlUOYNw9nRnS4+iNoaWZU67v4Z3+vmkf9aS+ZrK40gs5TWLT4CTRGkpaBNLYHo6izNXb5zw0PEeUnCv3zvuximL216jUj8kLmgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6686ff7-ae58-4d77-6706-08d7fd954668
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 14:43:07.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3/lpDWxOq1mKBiPuTg/sZG0B6GOo/bOmMQ83gtWZ1k06xpBM4FC9zOBlVTgflGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1404
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In free memory of gpu path, remove bo from validate_list to make sure
restore worker don't access the BO any more, then unregister bo MMU
interval notifier. Otherwise, the restore worker will crash in the
middle of validating BO user pages if MMU interval notifer is gone.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index da8b31a53291..68e6e1bc8f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1302,15 +1302,15 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		return -EBUSY;
 	}
 
-	/* No more MMU notifiers */
-	amdgpu_mn_unregister(mem->bo);
-
 	/* Make sure restore workers don't access the BO any more */
 	bo_list_entry = &mem->validate_list;
 	mutex_lock(&process_info->lock);
 	list_del(&bo_list_entry->head);
 	mutex_unlock(&process_info->lock);
 
+	/* No more MMU notifiers */
+	amdgpu_mn_unregister(mem->bo);
+
 	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
 	if (unlikely(ret))
 		return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
