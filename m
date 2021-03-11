Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D6C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DE064E87
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DE064E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2476A6ED08;
	Thu, 11 Mar 2021 14:20:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EACB6ED08
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 14:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOT/Ry+PD6JW1A8LCLm+E1coetTE5uJoe4TUJB/ic7CEewd2AGVZ3yhDkiZSaEDqBQ0VlazWZtAm7WKJBTMcSlxpQ96EIpxOBtP/6RagrbGEkEO7wD4xhacTtdgc17AjuyblepCPP7e6/lIXYB/dTrMn5Qr1IEH5XYUjadtgMfgql26hnu+7KFSq5cJoCljZrgPUfG/4H9oYwmSQAC+3shQayh8Ukgh+2fXQMBkGyV7Xn/R+ozTrAosijZPeRf8BWlV0NXYTJGPIjppzDGTAMwbnQvsVThpuWqGC7prKTVRWHPV+EauK4l7df8V7s9MQVYlkNEFzOGmdWFxa6XphAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM8Voyt+nigOE1pbZB7/PcwHA88nQGY1sc9N3GIcJCk=;
 b=lrvs+hnGoZsmPeOm4QTQ1PtbBrPdUhfeLOQWYo8HTxx4rBeRx/iLq8RxGJwOv1FU9SdGssLWX+PqeBzBLoigIg5sl+Dy9Df2msGCv/HWWtWbMGeyIXsIIfy5qQPtEbxIByCTB//rLX+46klzePmItLgS+II7glho8v/5IT+KQlmfvLallz19/ucrZT0Oe9oHDebNh15++3rtNQiyJnK0G0qAsekvZkoHbmwYi5ijAplNEaOfQgfVKBlxN9ubXPTIuVyO/hOUwmYPA+PCLs5tpfEdsFQRdPNx8IjFif/3N/Gwsi6EYZYDK3j4VsLVu0Ty3mnPNuNaSYlHcBpAUw9EHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM8Voyt+nigOE1pbZB7/PcwHA88nQGY1sc9N3GIcJCk=;
 b=0terLUt76UdfkmLxn/klM//ro9eAP2fdlejD5kMYdV8hz3N+nPPyK6fzavC9xykNkv46ROb3Sazh6IUBdjh1TaDM/clDXr47XaECqMgoREfKVvcK9ccfa0BUsEc4n+hUGgH13UWQ4aVmYDcTfqYcf/yTs6+ntQ6OTqoT7CelgBs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 14:19:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 14:19:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "amd/amdgpu: Disable VCN DPG mode for Picasso"
Date: Thu, 11 Mar 2021 09:19:42 -0500
Message-Id: <20210311141942.44342-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 14:19:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef694523-d6ff-4ec0-8cdb-08d8e498bfd7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4453:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4453638B7F6F8197F6964885F7909@MN2PR12MB4453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cG2MqEr1BPgq7x095FIHxkyJBW0u2Wy0VIM7OFP8PVA8UGtL+WE3S6Y3DX1DarWesm5WLFRjfVXZwcLwJh86vETBmQQX3HgUv6BWrWw+HShWCd7xud4NSU+4rkjDgPD9mPtuR+QuZQKl4YzXvQLMCP8ZfgqFBFTcRZQ4aIWw6+B2L6KAdsBzDh/W3eRxcV8CPaHdsO+7ZS7SS0G6eD3T7tt9FGBeweCyOaiTY00I6SstNOF/CGDkYrais+ybSWsyy8/O2/4epe9pddmv3QJDC9NcFJWL1U0VjUZl6WtLu76yWpBB6TdVV8HCk3SmQfvFMaXszuvGZXyYDmvGxf/a/ujIPFXKu1h7rc2oHxxiv+4l3/0XBTdoZzivRcz8Iy7VR+AKBdeM0I5xXw7RsAxC/bUloAU8PQQJ/i2hb2CkFjJoy+rly34wcb0b5qiVArQqk/+Ja1FRLCRyWmXVFdbNu3J8aijdRvev8xTMrJZMMONzlU/RLt4Itor7RvPjuq+VJwDTseHK2eA5i3z41FBri4/G9YodW9a3g9L9vWgsbjYttWl3x8IvLTn+5HhA1NHcR1uGyv4lBuMlx8SaVQmv8XN9OjZhdtTsdi/LqcL2pApqIY80UWPq2JoFCUyb6NqfkJzKmMlFtgZCD04qface2H0Lme5wKr7Y5rjOKxhrCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(478600001)(16526019)(4326008)(6512007)(66556008)(66946007)(2906002)(66476007)(2616005)(186003)(956004)(54906003)(1076003)(966005)(26005)(83380400001)(6506007)(8676002)(8936002)(316002)(6666004)(52116002)(69590400012)(36756003)(6916009)(5660300002)(86362001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HzX9Arl4uW/mkiUu6H7eoFOwDiPN0GZd0D+iUjg0NA9of3wUerfrqntU8/gs?=
 =?us-ascii?Q?SVcjSP/L0r17wI95F3AE3oLsZditcjFgGIR3FObg+GKRNq0YjOoV2KALSg8K?=
 =?us-ascii?Q?2DZatClAjxixagPuryo0ykIQoQpiZF9iPdEG69jT8QyqRrvhx8Vg/QeXCchl?=
 =?us-ascii?Q?pe5Gtj2bs3JN6iqTyCTfwKsmcUd2U0q7ewcrmtDL2OEpbp/2QZYI6A/mS4Hy?=
 =?us-ascii?Q?HMhmTA4dCRJf54n+2OW9Cz07bszoxNtOf1F7bYOI0OT2bZYERgiSmHG5uFsP?=
 =?us-ascii?Q?OIVz+5vTCMBLLqzb32yOf9Ld+qsDVqzCDxwExruqPjz00h5roYttIfqx9oup?=
 =?us-ascii?Q?sPUBTwUykGZhIZ5qz8a8C9zjCHvITBXSJTW0EyBDx2oyUK0dmzWi5jKXntap?=
 =?us-ascii?Q?mO+ecSZygYQU7KM6Ou6r/bCFJJsLS+EdjYuQYC6YSxRFF6TV0t/h/fXhBN/K?=
 =?us-ascii?Q?C3mF7aq4YlGBKU3k5E4KHNrN0oE00wWhXEbh3j+E97J0vnqPBLEHf/+aDf5I?=
 =?us-ascii?Q?GOt7RS8cKrbIhc5sVRCvg3pUgWcXSkAkXB5pb1YSA/ZZKsmEYblxYZSms2oi?=
 =?us-ascii?Q?5G7Kq6I9YyonuRiW+neFVAiU2oFfpNq5dsSDyWZqGr+KD9UoC0RZ6WzYTeWE?=
 =?us-ascii?Q?0rEW9zZ+CNIKxKJIBwLEBXnLp4AByADc4TCOTsuqfO2TIrRU4OrhzVWMKBaf?=
 =?us-ascii?Q?3skM2SjD7nTMhj/zhpXYwJSczWXAPo2xNp6oAeJ7IhMnSn2+FjxVzDeoSzmK?=
 =?us-ascii?Q?Dpmy12B+8wJGAB/pFsw+MRRytbGvZmBKtEGGiTwyZGOD34t4guwFR6CQ2mni?=
 =?us-ascii?Q?i2xYCddat5rWLqyOdh3S8Y4NJMs0/Q2xAP2qALgupImmAWBKFWRiZaAyxSbe?=
 =?us-ascii?Q?ZwuVpRoqIDJLjUnKvtowKt2uXmlhiS2mh5sZlFonif1JJLs9Dmf1nlffJmsc?=
 =?us-ascii?Q?FeBRY69C0RXWIRMQSi9jyz9ugUPojc7EpQYcyDPNu5pZ1QB0FUF8RyMfoNY+?=
 =?us-ascii?Q?i/n+9xb0cUkkBRoviPlYGNs2wzIqMKX0dayJaboXv/wrrn5wjYwKLwpG3Tra?=
 =?us-ascii?Q?nxWRuWAqeQqcTn38uCEjOrHGXVOAKZeccVz8/FcXciZLV+MAVusO04ZMIy1N?=
 =?us-ascii?Q?VOmDfifadha355/IIlF8wfaQTPnJAlwmDLx0okg5/lqFqA5eO0WcFtX/uIV6?=
 =?us-ascii?Q?JxLb1sbS8IMzjM26JnRwNoOUKiz2qFX2hfLrHaD4NuiWm0MuwllBl0APGFE5?=
 =?us-ascii?Q?ZLDXcP9/evnbuohQu4NQaJFtjLB+WvIUovFv8CQkAXzPwKw/r2kwBb6ntHjw?=
 =?us-ascii?Q?OzqY4gBzf8YrJi3/I+ON+vdB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef694523-d6ff-4ec0-8cdb-08d8e498bfd7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 14:19:57.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJOgbMrV1qew2BE/FZmJ4dJ5nm+JggkVyJ8g/M4SFYMeLP5J2Mq/flsggl3agZMoDRAZibTyY3Jk9snIhYK/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit c6d2b0fbb893d5c7dda405aa0e7bcbecf1c75f98.

This patch is a workaround for a hardware bug, but I don't
know that we've actually seen the hw bug triggered in practice,
meanwhile a number of people have reported that this causes
suspend and resume issues.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=211277
Cc: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3808402cd964..1a0c3a816863 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1405,7 +1405,8 @@ static int soc15_common_early_init(void *handle)
 
 			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
 				AMD_PG_SUPPORT_MMHUB |
-				AMD_PG_SUPPORT_VCN;
+				AMD_PG_SUPPORT_VCN |
+				AMD_PG_SUPPORT_VCN_DPG;
 		} else {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 				AMD_CG_SUPPORT_GFX_MGLS |
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
