Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1886610A6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1886610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3B16EAE1;
	Thu,  8 Apr 2021 13:13:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977AB6EA2C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 08:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icx2mTRFm4z90VoeSUDx1LW/XX6jBzTJB9PGfu+aWIjzebqrycSrbzJzax3cVYNdRgrzAO4eQ/gyAjydq9nwmbx3RN5+CcmYPgCurtCxyb9u/ZkMe4hqGQmzlUhRVMZemH4gT8AmmdBtGF8biql7SYNifou4gWG3WacGpXi1CXmKHf5fU/K6niqtV3ITo9zfTQ3kwnmArT6RnJLwfQcg2TadDhAKe6USNdb5hKLEt0gCGiixGRrhDz6j4OCqqxtMkvG3xRjfnNmT5he/arQ4Gy3/jftVar4zWvf9jR+loKAni87NoMlQ66ERiO9zhR1KLq8gQcDGkuk+nF9IFMj1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGQRUzUgRradEhh/rD0bBqBFvBuzQh1TgyT+ZXW3VA=;
 b=kIsBoaOYwvo2L27CN5E8ZZKOk9jX0nxOmXKReFtNFGPpZNiNLLiNm5OHfwfm95KqxrPA3pPswfE6GfRdDGo4whf2CdGgqH6iaW2fhwFYDe8rXfqxdQ7ArivOrt36lo2J7DOA6xfiAWMLSuzIauqQy5DsIxUmyd/XpM5BPeRwFafxBrjhTsA5t/C3BX9TzW4SymKL2Coe9V31jvYjbNEydw4DLLjEY4NUb/+IOZnP/0BZpsS+1HzqmIjmXmaZ2gLIJy1juV/zd3+v8LjNBB55PShNFRH3ZHrXmcuL0EDTJGoDxr+zhcAXoavuEd28rJF7JXiqvBmfWiVFGLHKzuPFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGQRUzUgRradEhh/rD0bBqBFvBuzQh1TgyT+ZXW3VA=;
 b=ZRS1lh6KwUNq5TuBgK6s/ZnMVSFkYcOuAOssAA3dr9uwbcPwljk+KdXImmscyYh3aAJJr6rW+7sI9uKpnnfP+KuN/kwsqPJE01h0FWF3guCtvXDqS2YOBjedZlSHV6EFoMgpv0JMhHd8uTXCuyldwi0aJXxeP7WWK+xtZJolAPI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4757.namprd12.prod.outlook.com (2603:10b6:a03:97::32)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19; Thu, 8 Apr
 2021 08:36:31 +0000
Received: from BYAPR12MB4757.namprd12.prod.outlook.com
 ([fe80::78ad:8c8c:13a5:3c3f]) by BYAPR12MB4757.namprd12.prod.outlook.com
 ([fe80::78ad:8c8c:13a5:3c3f%7]) with mapi id 15.20.3999.033; Thu, 8 Apr 2021
 08:36:31 +0000
From: jianzh@amd.com
To: Emily.Deng@amd.com
Subject: [PATCH] drm/amdgpu/sriov: Add MB_REQ_MSG_READY_TO_RESET response
Date: Thu,  8 Apr 2021 16:36:12 +0800
Message-Id: <20210408083612.3034171-1-jianzh@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0153.apcprd02.prod.outlook.com
 (2603:1096:201:1f::13) To BYAPR12MB4757.namprd12.prod.outlook.com
 (2603:10b6:a03:97::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (180.167.199.189) by
 HK2PR02CA0153.apcprd02.prod.outlook.com (2603:1096:201:1f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 08:36:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f875f231-3b61-402b-3dbc-08d8fa69692e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB432292246BB4945458C35CBFE1749@BY5PR12MB4322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BuxtR26DbZcsasTrAIUVQKiaogEX7d5vz2RMdK5VyqKWre/+s2XVmWlX+ZGropYAobTJFghhqQqNmSCZTFRi9aQUxERZeFoOMa17HTBUbQybI1JFBxkhuBBWcJ3vLNBfQeHBuRkevmdXDgX6QPs7IpyD3Pd5zlUMEpKmPJTI/+HdSnvmXwn0pHFvLJnvdx0mKfEAr4nDBbtSAQmjNQFu78EuOaxrCfpVmCSzJQRXY0l8+ShwTL09sa+4tF9kGMeEMLREq46slcM+IxFctohBncgBVo+1sXQD3uZn6hDZPfAMGNsvsbEBgsLtJ0ss1FvwKfwzSlKUMGSeZTUxu7FXE7lKcETL8WLf7eUPC6LzhptIgv0hFSczdfLJHKLJqXuYz1cXForEyF93D7QRclPeFXkRBX4Y1SmI0C1MJASSVKy6Otazd9MFsYS2zQhJmYX9hu+cebvIh47ZX1/+lmShODhtLfTfztDFW+V00KQi4UfaYMSZJrioxKTZ6gagfuOX8Nz1XD71dVj+fy/HE2aJX3/DKj4K7OgEHB/Nv0jqmFDSepIIG0oQbauueqBEMm6iImfB4GVHa0Un+qxxUInUm76xo3Y75qIzI8ir1HmKLZ+M+YFGh/eTZurtW85GHFu0ZaaXH/Jx4uyNnqhk3stLThTWC4Aqfqdl8gok53+XqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(316002)(37006003)(66556008)(5660300002)(66946007)(66476007)(2906002)(36756003)(1076003)(34206002)(956004)(6666004)(7696005)(38100700001)(52116002)(83380400001)(2616005)(4326008)(186003)(8676002)(26005)(6486002)(9686003)(16526019)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Mf/E1zS5AuzURNWGUJG6/TM6A9wfc7Mu3GFGBDEcDUmk9MdNDRShWCiDX10V?=
 =?us-ascii?Q?wqRviZd2BwYs/Jzcp9QhQlE2DNX20R9nGsOvT57F8fgU8tHraBLOp2yXHyuD?=
 =?us-ascii?Q?//0/ke1dkKH4Rq3qpOlXsiiO6VnV8oWJaBrQW9oppYm/Myo0E21+aNr8g1PJ?=
 =?us-ascii?Q?cul9WKKlSN7nh8E7q4kP1TlRcOACafLW+LCruVGAcqIHvN2AQZO8ffCE5Ggs?=
 =?us-ascii?Q?4jXeyu43WntZPfGFJIK1Y16ePwLUhI8/F9EBshrRpU8XjuOnfIFMteKkDYj3?=
 =?us-ascii?Q?k7M80MMD+zc+GeREMzJjM0EzyHtU8jL8feUzFgrcqcCdPMYwJszB7z1Ts/RP?=
 =?us-ascii?Q?HWAvCbmj9Mh7A96grFt/3Fj4aYVakUhWNJUPZoHAio9X1TmArPloAQDNHzc1?=
 =?us-ascii?Q?0cMCWold6K9d7TaeOkxl/LVxv5zkJpy4QK4wc8BAyoBGjh1mTQ4fuky/SJOU?=
 =?us-ascii?Q?oTv5i6Ks6ZXsoa7IgPj9jcsYzdgXESgQd6eulkUn34znmBIIkqd7t9zzJNkN?=
 =?us-ascii?Q?du8zWr1Vzi3cFl0wH2fJ3BAzdUKfUGzqRC+vjvocE9WCFhg5kYI572Hqeow6?=
 =?us-ascii?Q?BW5Z5R/p8MBauSHwoVQZ6lz6mCs3DpMh7lbLlj2xoIUVmzimIMWrEFDzGI64?=
 =?us-ascii?Q?vcs1WmpmEKgx+a0XMZd6V5sncaXXJ/ardg7FbG14f/1/V8sNQX/8IjlWEDLw?=
 =?us-ascii?Q?6eTcsKA/ciLZelqZGM9uMUjjPKMah0FdpY8fX3TjLYLwbdvhuOsXaHf0N9Qv?=
 =?us-ascii?Q?wnG7uFW+7d/xsQeMEuq6STN5/12xO9QQ/FKsVNsCdIpFyr50F3741C3Leoyn?=
 =?us-ascii?Q?LrVyxNkK/41VhYz/6jf4Z2AqSpKxUfy+z2ND9NV1pf1ddhJhcCujg5HgC/Jg?=
 =?us-ascii?Q?y/t/VZvejI6UWjw+OM5dkkhq9BZrV2KQq+Z0GWJFaaZmmwbGlFtH3aQa1Pld?=
 =?us-ascii?Q?xcHPzH07GZBGVSRdtCn6OQXA9BMQpSrfmjbmmmM6Br9Cj/uEeLEAXVal+RMm?=
 =?us-ascii?Q?8bq5644o86515ExMhsn2HvDVODtV0W4YQGwNalf0hTLjj8UUEjou80TAKX/R?=
 =?us-ascii?Q?JpEp4Bf1ja+CZF3ICXrmR05mfyidjrqB1ZlcCrrFDR0j7H+J+tis7aR++Na3?=
 =?us-ascii?Q?//agM/AGAOFrcL5d3gzbHIhT7hwD171nxzknraq9OTG5N16lVvxAJdU5qANB?=
 =?us-ascii?Q?1YKP+pu5ZgnCd+Uwxul83NnP5bwthLdLDcnjDA/6r9+zpyWO7h7XGWfDkxcT?=
 =?us-ascii?Q?wlR0KToskZ48kviFSuZlCtlNaU+GcV52uicUPEIvyR/NLFsXmHUnNF4AfiQF?=
 =?us-ascii?Q?77BwQOD7wfvVigTvXbLKOd0N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f875f231-3b61-402b-3dbc-08d8fa69692e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 08:36:31.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URB2iH+Oebnhrws/g/+IshlI1H1K8Nn0enOHRitJbhgv8FB/PRQP7Yu4imgNQcQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Mailman-Approved-At: Thu, 08 Apr 2021 13:13:52 +0000
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
Cc: Jiange Zhao <Jiange.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

Add MB_REQ_MSG_READY_TO_RESET response when VF get FLR notification.
When guest received FLR notification from host, it would
lock adapter into reset state. There will be no more
job submission and hardware access after that.

Then it should send a response to host that it has prepared
for host reset.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 48e588d3c409..117d22848ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -277,6 +277,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
+	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 9f5808616174..73887b0aa1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -37,7 +37,8 @@ enum idh_request {
 	IDH_REQ_GPU_RESET_ACCESS,
 	IDH_REQ_GPU_INIT_DATA,
 
-	IDH_LOG_VF_ERROR       = 200,
+	IDH_LOG_VF_ERROR	= 200,
+	IDH_READY_TO_RESET 	= 201,
 };
 
 enum idh_event {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
