Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF659C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F3A60C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F3A60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB34D6E91B;
	Tue, 23 Mar 2021 17:06:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B906E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 17:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlEQS2VFncdPM8Zn+4wEP/mC3iPwI2h6oQinLtvY0RpMQF5cq+UX15Pr30p1BUTTzd/UzXBYHD/rb06dZT9fr76ZBjImcVV80q1AvNXMBmaTFU4ek6cksxeDg6G/m+be4skE029PypHqMkz0Yd42HdZrCp0KFnfmWeU9ipGlmPiU1H0HKjeJV9iWiPO/kwidVNn+k+HVI2UTEpurRFJkA8Wm4oS4cEoEIBBPgcNsxRBWQHlX3zKscjLAhh6qylvpOXATrJoXy357JhbG+pQQL8K8tKyUrAxYpu6lLJFWVFj8M6Nr2W4vAjGzWY5oDJeBPTfh9IxMuymtjhBdLvdplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OQq2/Q04K/Kk/GmPtyoz19JZbJu+6pwFrgTCKXwIW4=;
 b=Wc1L9mjw7eFJaxtQJxhmF3+l6OlMfto05IZ1DH0zpt/o7rI+543PdE1Ln3h0CVe9M0FAANdGtL+Gq1vdXUnJ6qRreKmvSr8CRbI4VTx1IaqmUObMAJvOM4RyFqaNW32xli5aU+3x79MCx/vnCAYCPqwHqNQ7Mks3ypO1kZ6CUIPAr97yXA+V6Iz6QRTLHsId6AIzR3FFXlM/gxo2b2ZEqudW8kiUCUZXnlBCtP0wJAPXsTHsKW8foOrTxOvD/UjJvb37HlVkgDhWrV7/Jgm961gKEByd0aOCq3rsJfMe/JpehdViiYKJSFDrdQvMrTL5RawjB8CgUU6cvcSHMTaWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OQq2/Q04K/Kk/GmPtyoz19JZbJu+6pwFrgTCKXwIW4=;
 b=GILkDOzpjyHskmqfdApTHal68bbeD0uC/L4Sv65M4QIk+bFVIt4i6YAEqeW1xkDQv3M8pUA7T3R8KRYgeOeVtGK55rXq8+eZSq1Dc70FBL86BwliyRVsgwo7lS3AwvYm67OeG5aGdL2MwYFUPTjvEigVBRgLNrtB9JmM8AI/xSE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:06:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 17:06:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove unused variables
Date: Tue, 23 Mar 2021 13:06:01 -0400
Message-Id: <20210323170603.1223424-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 17:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da4e61b3-3246-4458-91b7-08d8ee1dfb4a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4406FC1A4DE5E0BAA8ACD7E2F7649@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WEkS+SqCGgKSnnBVJBVndttVhMDwSX1FeqismW5/LzDYBh7vWV0vSpJ0XTJZz9bZQHTM5KvVOCyzsAsMyEQ14l2yQTZETxcaqec3ENhl4Ye6hG0rvIx2TKVwAcZGeXi4KlohqXmoxGULFTVTkMM6Fhga1LS/UH+3m7+DX5tGrmx9NiQ/rWMXiv9OQSJHZ+6l8+nHhaTM7vccKcfAZXRfJ22wsOkWPxv/X8+TKeol0YQ/INNiwa87e8v7XqfsWrtjJxNL0kSATXtddrdy3HX8mYsMb7ve0KlMZ4L/L7IInUMRQQBwiqwsYYe2SJkhsg/2ckNpieLQbIZIlS7XXdit2m74t9MwnS0hgHWrsvsmHKQRR0+poNw1vcVX2ptLusQcW4LRgugXHUhBeD7Dii//QXyt2xTjq89Wu0WEL+2OhBtBYbCeuHn3EkvQZVuqETEivEyoEOWLqbyB4DgD8RxYpTDZXC3BzMFvswj2xDcib2Og4IhrnzFUnFwOU7/HXs92n4vJsV+rV6RPwsSWcYu5m+p9HQUnfFNByTjyg+3DtChvoAZLcXqJu74uOjh+T0xPEfAE70HSLzLLJyZLQGVORN0NYVKiIS37q+1Pi++utiMh9/OtGciKYS+ZXytqRmBKJTFTm3wjGu9I/NQiGl3iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(16526019)(38100700001)(86362001)(7696005)(498600001)(66476007)(1076003)(8936002)(6666004)(6486002)(8676002)(66556008)(66946007)(4326008)(2906002)(6916009)(52116002)(4744005)(5660300002)(956004)(83380400001)(36756003)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?24j2yiccCYaFn5kvpcvHpAKgmP07ooXERHtkKGfmGSuAriTWSOO/WMCdvSXt?=
 =?us-ascii?Q?F80dt8MI4oQN9RBwb6EABBQhEusqDCxRSL7baSw3W5jr67e8hyIKPUKLdo6v?=
 =?us-ascii?Q?TuZZmzoP80OdIE+sIWcDJ9CXFmbhxXY5fBZwnwhrnghEeubbtTuPBrINO/FH?=
 =?us-ascii?Q?ye0RedgyKDU6kvfuficoAxmP5phuGRH665y0drvaVvHy2Jo3soeQBxnlb9lT?=
 =?us-ascii?Q?ZVZo4Svaf6NCLtPRhb+kXzn3a+2ipVeQWzQ+n1YYnx70TrUv7+eelZ0N79R1?=
 =?us-ascii?Q?YzQt1zu98JmC2I11qdScsvKQuh3f7GWDJ1hxHCR8ppnVFOSAyC6r4h+tbly5?=
 =?us-ascii?Q?vgOfhJaVfiEedjrYIICm3pJHQfAXvIvQYCk5DdnCORQtY6PnnEhNHRTyZOrC?=
 =?us-ascii?Q?ALvk008fnpLuIEvgaKkoLlbRsCL1LZq2IPb6BF0bQQOcC7qlpYMa96VT4GuT?=
 =?us-ascii?Q?Xa2RqQPFSffEl4DBbsfaMiQlcBN1vR/7Mb3ElS0oM2BTNIErDT/E4tRB9F/1?=
 =?us-ascii?Q?8TEadkESptW7/l3/waL4Y8zlxbr5AQYWVSSIdmdZgGpI5eU+in54Jb7Mpoat?=
 =?us-ascii?Q?K7ZdNpIceMloNoC7VVsQWgckzmD3+3kUk0Ehk596p0izGCzlre90mOIV023Z?=
 =?us-ascii?Q?trX6DwNYXpJAKtPzBUbkC8qYPYE7Q8iO+C2IIC2I29+cY9L3B22IA5gNDyht?=
 =?us-ascii?Q?i+epvK0cn6xrEyN6PdNKak6Zwua/p2M53N132VihplW5Bh9TQ+ZWp+SlTKCb?=
 =?us-ascii?Q?uDt6CpsAFDNZqfBblZdUVubtsj3Cr//2S8YH+H77FV7QeHYtAkAImjinH0CC?=
 =?us-ascii?Q?ygSYQfjA8ViTYEtyikODsFrKbhDjZQz+tgkXQxDfl9yZqA/S7Gta2pkGGEiO?=
 =?us-ascii?Q?lS/4iy3wDijEuaGvOHIh8+pZBqY77S/qS9KvHxmzffu0NRxiTL9JoKWtOKbo?=
 =?us-ascii?Q?nK/YpBc25i6orbjMYe7Kl/iKERQ13ncoSXi7ExVcjl1IEkxv0+kpd9sqJUfv?=
 =?us-ascii?Q?ijFPDBk1FDxqlydKlnBumtvPDybmrCfUnD1xu4f/fsrSlmla3frp/pUzQLdg?=
 =?us-ascii?Q?9Wfz4Arrn/4sbmIbvnmDzZgTmHG8j7+FdNnFh2bGa2tKc3JwAWA1P1Xj/ggy?=
 =?us-ascii?Q?YFZhT4mqdU7po/twB3FMQjZT98GxTwkssCbzdJ6m0o746Q6DQKdZY9Tk2CPC?=
 =?us-ascii?Q?U+3M+4j4SBP5t/2JDQdQhbeFRP3tibV8l82CFs6UgPkjAg9QNxJnkMLjGlqN?=
 =?us-ascii?Q?0nnZD3+hOgO2NAQymtDMWmWh778Qnp8mF+35HNlSqSc3ifwko/2tw8oG25bz?=
 =?us-ascii?Q?nUQzK4jJyCFdkMQJJw8wZHM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e61b3-3246-4458-91b7-08d8ee1dfb4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 17:06:21.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ipuwd5rXFbuQMcCJhrvRtillszcVouNZNti7WgW+adQnlNhD9QnvPUszjTtyYRZcCxt1FojX8Nql+jp+03qNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leftover from the GPU reset rework.  Remove them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 324b9e6b2965..5d73943797f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4694,7 +4694,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job)
 {
 	struct list_head device_list, *device_list_handle =  NULL;
-	bool need_full_reset = false;
 	bool job_signaled = false;
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
@@ -5234,7 +5233,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r, i;
 	struct amdgpu_reset_context reset_context;
-	bool need_full_reset = true;
 	u32 memsize;
 	struct list_head device_list;
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
