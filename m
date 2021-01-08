Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFCC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAF622248
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAF622248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98816E817;
	Fri,  8 Jan 2021 08:55:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB166E7E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+VjBBU2Y325bEKzNtzK7T6C55+z2gdbHZmKsxQ2mt3WjqUqYreyPq7dfvliR7FxAkiEof19NexuLGAWSqbk8X3UJ5VKbT6oUk3Q9wkI7NpOQp9j4EuBNMJh/vCvGpYBEv+yEp8WU1AMdw5vkdM7jf6EP81h0lKJVczfy4PLiDgiEnQBH6/aSoLHh+vjGizAH2m8fFVNVAcIWpAUJbg6Z1jdMhFmFn4dEnKv4YlpDLwJsTG5VRXmfmKc/mFpqc1DuhBJbNYoSnLQ4ux0iSvbCAx8IiYSimHfVPQsRXa3a4iwpVmSX2iMy6STwZ6WBJaOve1kXJ9l3l9QYQS3KI02UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MfOg1wkSG/+kafiNhbHAjFZnAyucYlNUHfDFX03TpY=;
 b=gA6ZQ4cmaN7LD1HxG0cLF4cC8qohoel3T0qtDW8xfh1DOmz5yr8WZi7Q7XhedXv9z4IxXUsYK8LH0dspWcSvY17WuGn4vz/W4hKaRQD0K2QxIxp31SvltqBumCO7thOhOhb4lyM+FmqT6r395MwUkuzz/rE6/evwCF35VgWkxEtSaF+U16jFg31BjZxffFE5/OTyJ0XZ2YjxCwpt7CaZNxLfOeVske9jHJJHdMYS/Iz4QMzbd36tOoxVsC5TpCfRbYP8znITxTQQe7xuInnNgNiYwnuoeeEAlfFR5fXt+SRnSvX3A0rQetefj9++XHlSFbcYm9nXRd5VndAFfs2Ang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MfOg1wkSG/+kafiNhbHAjFZnAyucYlNUHfDFX03TpY=;
 b=Pg0113ZiNDkO2R3CIvreefOmdHSbTmbj4VbKW+x+ZM5MgzcV4f6rfiEoogkNlHr885ZnnJYxu6I5BHDyQmSXb5yvSL4F26eiMB0g3AM9EAGLnGEBS5bMQZz/FqijUqKOJ4orikkNyEgi5hqNHKkBhzE2SqZCVIX0sp8ezMm79C4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:34 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:34 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amd/pm: enhance the real response for smu message
Date: Fri,  8 Jan 2021 16:55:02 +0800
Message-Id: <20210108085507.1164588-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a9d1222-dfaa-4eaf-88bd-08d8b3b3290e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24582DA3392B9BE53568932BECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UWt/iX4T0teANjtVBDrpLHL2iMJlkEP3smH6Ie0+FRYylyo+9uGkJhCiiKHhb7IurG5t66WLVcAge6/B0ri7mINBf7FdExjB3fO3Z7yi4whvVblhWtAuL/5Pw2jMzZ9AutSfsfU7VzkPh8LY8E0Asrun3cYSwrss81W5+uxTnnNB2RTGPY/fNsYfqWAqLfRE3u2EPm1HCA1X6yA/pa2hosGVe15iuqjTaXmOhVLEr7WeexbMSMEuuErlaFFglltDhpjea6INJ5i4RsL/TXC/HSOfCG37Bk774eVqT6MOGtToaswKdzpOw8dmtCNVNxidO5MMi9KcRTC48mR7MPWYFWfRlOeUZqd5CqOVmsx0YXZ1n6mFY00tFOyCquHzQC+jefG93aff2W8grHqzMyTkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(15650500001)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U8dqjWR2LM1d7rRiiSRks+CtaYKhgFPogE6seyaEjFrLsf9AaUcLaOKkDEgD?=
 =?us-ascii?Q?2xpnFffkyc8+c0K+NoRl320E75fmH2w7NuVXbggXQEgWon7WKwPT2TZRASTM?=
 =?us-ascii?Q?0b9xXE9nKJxoMy48L2vZxOCGd79V/bc9gAtJrkWdba5zmUR4nYfUX2rqjC+H?=
 =?us-ascii?Q?jdUAO+bSkPg8kmE7dM4Dp0y6Vaoyd83lqPok97zfdFVynPUfZY4FbXvqPy8x?=
 =?us-ascii?Q?EQYVxbQ+SdzMcWi4RDvYkUFbhQdqqTel3Ii1Vi1IrSmf/S4SLi1XlbNsIIzX?=
 =?us-ascii?Q?eztawsdQF4/UcsK21yYPXT+ocevHj3iWESDBFi3hi08abdVlia9qyWYfLOuF?=
 =?us-ascii?Q?8IZ9pgby7oL8JXCH9uTF48A1Lbueevp4vs6VthVeNu+AB/YSHzxMJPImyjr1?=
 =?us-ascii?Q?AhJ3+E4/yZLJGd7njvvtGj+OlEGxuKe9gHfhJi5QsUhEAcxIbpAwLYo6UHgp?=
 =?us-ascii?Q?c0L+8iH+ZfKR4d2ehY5ibynAHq2Vy75I505yDXm1x3WJDaCHUigYlx9AGSQs?=
 =?us-ascii?Q?oyrUwdN7AAC9HhuQeI/6I81J/o5tYosZcLbnL6ZOpjwCP5yDZmq9uo38LtLH?=
 =?us-ascii?Q?3+I67DscR+SWMVtPyK9LXGMaSbZxFB9sp/jYCL9qGbATvVRbJVnqhIF8XjLn?=
 =?us-ascii?Q?Ajmv9ZZCTEBiHuqExZfUxlM/UUoXUWFC7J4EVt9JOpWxcT4IkBuhGEzNV1mg?=
 =?us-ascii?Q?Fsf0vpwqyrq5kH3XksuFvUDMe1nFeNitjUajmtP9N6nHm50SQdR38//f6YXs?=
 =?us-ascii?Q?1euMurwy1XJqBj2KeYA29OnL1igztejDMUShaOwVsvsiu7CcmkFBJSmd3FkK?=
 =?us-ascii?Q?Xun6jUAZvqG9bQL+uiGidh7Q+ewQ2NWrCxURSD7DfzVRVeSKYcViM0Rvxjlk?=
 =?us-ascii?Q?oAMIpO3AvWCp1qsDYGrWvTensRTthcXZ/uaT0jwwarZBo7QyLkWMNDAYAOri?=
 =?us-ascii?Q?xCBOw7XpoR/vx7mw+MXyMeD99OWxH5ONxIeFPLXQ9ER/WtlxnEY/lj4XIORa?=
 =?us-ascii?Q?Iq+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:34.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9d1222-dfaa-4eaf-88bd-08d8b3b3290e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCfpuv91JLmxnr9/yaAccjLSW4326qzl2WAQP34Oq3tYinXyFGZbH+540NhwkVYH5BePve1q+C/0gH7fUqNzhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The user prefers to know the real response value from C2PMSG 90 register
which is written by firmware not -EIO.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f8260769061c..42b125701436 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -111,6 +111,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
+	int response;
 
 	if (smu->adev->in_pci_err_recovery)
 		return 0;
@@ -137,8 +138,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 
 	ret = smu_cmn_wait_for_response(smu);
 	if (ret) {
+		response = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-		       smu_get_message_name(smu, msg), index, param, ret);
+		       smu_get_message_name(smu, msg), index, param, response);
 		goto out;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
