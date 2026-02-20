Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9413DC561E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276E010E82A;
	Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brYRzfjh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9831110E82A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNnvqMRuaB4Ve2UlG0e1J6ZeeiIWOTPiowy+p1mHGBhhP3K/QjLIB007Z15icSJ71HfbV1WoU+2KUbltEc8cIbEFXuRosVSKByY1AS0+Q/d6rYlQXzSAV++lAxXKpconi6T48OBqzWUfSui0mxWUPtG5nu504ck1fQF5dwxJVBx+Qu2eWVSx9qKMAeZbwC40wuLDmxAH4PjvCcR99mYFZQfMNzhGJ97fiXNTT4mAA8g0wdalm+JShv1TcW0b5+Y/vfBxQjk2mv4ltZWsOJFfUXlN70vknlGy4MI91cMStEi3vSECkweTA0FUERox42r9uz3r/nKCCUZPQ92jDTrwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL2V+oZFM5xH0vOWNIRNiG5E0vmqXFhd6wd/FuOJbts=;
 b=GL4zyvzg2Qqexv7KiQ7417GhmDtKBJ0pE6SXGF/XRRSAikee3vmivdtKAt8iRQ3ohGRkutR582aJoz+kXZtihSstnkH8UrCJoAsd2I4cDA/5pGaAsh8yH9JySZ5eXokOvnq5EeKc9KjkhDGmDaa+/U0sMk64Kif4XPT9eZeaPfHhJPwtR2MLnFx0Xzv6tkrNROg0P1NqF+gRkvxtTzgtv0I8+CEUk0Vtbhenl2Ah0Pf9yReQRKwB2MAJ2NpnrzDD/8sTXTX2eS+ZnubG4MG8m04XCiBvCzPuDdNHIK7skpTADjZtKQEmM5Rms35EunLMoNYHUBHa1Q8XlfgKlerTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL2V+oZFM5xH0vOWNIRNiG5E0vmqXFhd6wd/FuOJbts=;
 b=brYRzfjhPUr26CvL8P9iznm9tLMVTb/rWqRyzGYphOi7myE6rRb7jFR5LrQEUqLHewlmPBSPiAzWgkxXhI9Rn3STrvjx2pP8N8Chn5+kCxJsgf+D7nj7zWg7lJmX/zeO4+g8N+kcc+fK8qds6d7rO47qa+piJ177w1jdZx77FiY=
Received: from PH8P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::26)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:08 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::b4) by PH8P221CA0011.outlook.office365.com
 (2603:10b6:510:2d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:08 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:55 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 13/17] drm/amdgpu: implement data dump from spm ring buffer
Date: Fri, 20 Feb 2026 14:22:32 -0500
Message-ID: <20260220192236.3121556-13-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d39e05-93d2-414d-4a5b-08de70b57ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sozASywQKtWcXE814oIC9+PUOf/FkQmPZgMjNBSN5zTTwD3YrSgoWhV/ZDlr?=
 =?us-ascii?Q?vYZccUQZknW3LigCp4M3RscaH+QBUtamdpciBuuSYpi0oUp960ddC9EewZHx?=
 =?us-ascii?Q?USmgIfPUS+eWSCaj5xLYIHh4uGGlm7kFBs96J3QRxKo09XqP4GCKDqsslQrz?=
 =?us-ascii?Q?Ry+LvpHaS+Nbk6aTdYrc0C4P/lSIKvI1JtQtxhU3YYJgPiM6N6mEbwKo/Kdb?=
 =?us-ascii?Q?Z+khQTizrgw36ARcBVNED59bdIR2lfKFgQ8anioLWgX+EeiTcdQi7mo5NFG8?=
 =?us-ascii?Q?xI1SGBeJrTUkGw9bvw0ibwNLt6uoCWD1dUit57NIxbhvczJSnVkGdDl8GTLM?=
 =?us-ascii?Q?pJJB6gNhMQICsMr9dTMF/VD4OvY5e7bRlqRKODTmvhOmubBsVtcg8Sopm3Ce?=
 =?us-ascii?Q?T26seYDOjSP6F9uJ+Lg5xoP2JLKo3MBYx/i6UzFF33YdwBu8rBn2Si/xqfkm?=
 =?us-ascii?Q?ggzBUKrbzBgEwZrdbp9Vn/eNIjYVhR7xEnde+95nblgf5zeVBu3AAfQ3abvf?=
 =?us-ascii?Q?lpRYHzjG+Uuh47yVUqhBGwl4hZjLkoStZtavFAVJraL8ZXQjwT04Oufdgtgi?=
 =?us-ascii?Q?RN8GppFEy9rUkhl0yksJTxfHfNAWN+wecHkMq8Ij/d8YpDemcRwlodwLI+hC?=
 =?us-ascii?Q?3ZbeDY5swAagxWMX3qojQYyFgB3WoMk+3ElGtJ+muWMRm7kaediODSSatVUW?=
 =?us-ascii?Q?3fEExjROHdSkBtIMB6bHtpqoxRPYpQAYE6zq4R/CqBjIjAwYQ21k6Cz4nKWL?=
 =?us-ascii?Q?ImlJsjgxz/TQR3D4ZP/wT7Hf7fpFz7MdWiaTgsQw9YrfO0NJR+D/Dr/0IteQ?=
 =?us-ascii?Q?z9mUjodJYcxKZd61SH5XLqlvWV+3XE6mYCL24s0ItfrhtpYys+BH05tTfPYs?=
 =?us-ascii?Q?ehL1I/69Ua46grS618zxC8qJPfJJTkhTRswR7l2D+TYbQkI7IUD2+aXrKWeu?=
 =?us-ascii?Q?V9iwwnK3pj5NrwnaoZXsdqRgCVRPGXCV7T3R1Ag92DuiI79xT8N6XPdeMOE4?=
 =?us-ascii?Q?NyOwplzyOHLkPLrAgtprddXuTl/OSr3fOIaPqRDY8w1JHNAyrgkyebDirCEp?=
 =?us-ascii?Q?MRrPtksvDvaK92DLvPXCP9xHJB9QIfk+DnKTY3P7V67DZaKSgQh0TcvbZMXE?=
 =?us-ascii?Q?S8Fuq0y/t3Xb7eGXlkcb3m0sbeWWxk54kE9teErk4v6N8QK/Gv9FKubJPO2a?=
 =?us-ascii?Q?jAWGXWKgGRi/41VOQfOf9/ZGh4Mf0V2DhSWVFe1Y5Lx/gjhEyVczDEV9DUhS?=
 =?us-ascii?Q?RbwcowJP4R5UQ6A9FiRBAzV7DaPz0xHM/xL4rfUQjsjfC3HF4baB7wKJQYGn?=
 =?us-ascii?Q?byIFx0Rni7QAg9gokd5/bkAlFqA1EASAWdRmRO7WDDxWvVxMaaU5VoLTFMWI?=
 =?us-ascii?Q?B4efCWwZEbtivIrI+cjtlf80n/LffKmOmMZWTBZ879hlzsGVoJ45L4kZtFcl?=
 =?us-ascii?Q?l4rCtKH0oz8hw6KzDbpxDWDQbXwoMnj1tvHq11NpYzcuh4zSpQGow7GHDDZ0?=
 =?us-ascii?Q?OOEGg2SNuv/ksXQL5fa7HIJcQalaFbTgbcdnLSJOJ8fEhlJib1668Yx3Ds1X?=
 =?us-ascii?Q?jsU0M4gS29W3GX8dgas4oIhG+jWUh50SqDuqDsSmBcJsJfQkhRikVJF4C/2f?=
 =?us-ascii?Q?YrnEyr2pvbCcR1o4P12N0B+i8IhhiGLzgFeWz8Ga+ey3FVPeWLettLnAXnN4?=
 =?us-ascii?Q?617qqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: llT/rVIf/18KWUVjEyCZ6rzD/cs78jhPYV1kgxEr2LzNK7R5JuPxd4FfjvCixzl5RlxrDz7X6p7iRXDB9Ikuz8EKsEo8/AluXQXNLGX+y5axGRCa6Ep2pcX/+YN9d0Bc+yutfY6jq1b1tK16U2MUpM00nEd+Ws6RP4Bp8fwjX+jL2jFl/t9S6o/wrfy/4sobx/TOzoQP9Ly5OHYBCEDSrrqpOrTzV337Y0UYOFztjto43u59PRcINxNmDvPYKuKs7LOGMEj6iDxPTy4EuxX2lQl8O+i+RmW3d4pdqkAA8BVxms99Zro5q0pxnwWTKEGnNuSQfLzCmRPqkP+kYhfY7G8irG0IPG5QEdXh78TuEYDgc/0JNRXikofTmPsJNRkrMniGkDICkhFD6DD/MQw48351DwmlFSJGo9F2982pnSHQjxlI7B8yasX0FGaD6SHv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:08.2417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d39e05-93d2-414d-4a5b-08de70b57ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

to user buffer, wake up spm buffer waiting queue to return
data to user.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 118 +++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index d84814069846..7acbd966cd3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -59,20 +59,136 @@ struct amdgpu_spm_cntr {
 	u32   have_users_buf_cnt;
 	bool  are_users_buf_filled;
 };
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr, u32 size_to_copy, int inst)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	uint64_t __user *user_address;
+	uint64_t *ring_buf;
+	u32 user_buf_space_left;
+	int ret = 0;
+
+	if (spm->ubuf.user_addr == NULL)
+		return -EFAULT;
+
+	user_address = (uint64_t *)((uint64_t)spm->ubuf.user_addr + spm->size_copied);
+	/* From RLC spec, ring_rptr = 0 points to spm->cpu_addr + 0x20 */
+	ring_buf =  (uint64_t *)((uint64_t)spm->cpu_addr + spm->ring_rptr + 0x20);
+
+	if (user_address == NULL)
+		return -EFAULT;
+
+	user_buf_space_left = spm->ubuf.ubufsize - spm->size_copied;
+
+	if (size_to_copy < user_buf_space_left) {
+		ret = copy_to_user(user_address, ring_buf, size_to_copy);
+		if (ret) {
+			spm->has_data_loss = true;
+			return -EFAULT;
+		}
+		spm->size_copied += size_to_copy;
+		spm->ring_rptr += size_to_copy;
+	} else {
+		ret = copy_to_user(user_address, ring_buf, user_buf_space_left);
+		if (ret) {
+			spm->has_data_loss = true;
+			return -EFAULT;
+		}
+
+		spm->size_copied = spm->ubuf.ubufsize;
+		spm->ring_rptr += user_buf_space_left;
+		spm->is_user_buf_filled = true;
+	}
+
+	return ret;
+}
+
+static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	u32 overflow_size = 0;
+	u32 size_to_copy;
+	int ret = 0;
+	u32 ring_wptr;
+
+	ring_wptr = READ_ONCE(spm->cpu_addr[0]);
+
+	/* SPM might stall if we cannot copy data out of SPM ringbuffer.
+	 * spm->has_data_loss is only a hint here since stall is only a
+	 * possibility and data loss might not happen. But it is a useful
+	 * hint for user mode profiler to take extra actions.
+	 */
+	if (!spm->has_user_buf || spm->is_user_buf_filled) {
+		spm->has_data_loss = true;
+		/* set flag due to there is no flag setup
+		 * when read ring buffer timeout.
+		 */
+		if (!spm->is_user_buf_filled)
+			spm->is_user_buf_filled = true;
+		dev_dbg(adev->dev, "[SPM#%d] [%d|%d] rptr:0x%x--wptr:0x%x", inst,
+			spm->has_user_buf, spm->is_user_buf_filled, spm->ring_rptr, ring_wptr);
+		goto exit;
+	}
+
+	if (spm->ring_rptr == ring_wptr)
+		goto exit;
+
+	if (ring_wptr > spm->ring_rptr) {
+		size_to_copy = ring_wptr - spm->ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+	} else {
+		size_to_copy = spm->ring_size - spm->ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+
+		/* correct counter start point */
+		if (spm->ring_size == spm->ring_rptr) {
+			if (ring_wptr == 0) {
+				/* reset rptr to start point of ring buffer */
+				spm->ring_rptr = ring_wptr;
+				goto exit;
+			}
+			spm->ring_rptr = 0;
+			size_to_copy = ring_wptr - spm->ring_rptr;
+			if (!ret)
+				ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+		}
+	}
+
+exit:
+	amdgpu_rlc_spm_set_rdptr(adev, inst, spm->ring_rptr);
+	return ret;
+}
 
 static void amdgpu_spm_work(struct work_struct *work)
 {
 	struct amdgpu_spm_mgr *spm_mgr = container_of(work, struct amdgpu_spm_mgr, spm_work);
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
 	struct mm_struct *mm = NULL;
 
 	mm = get_task_mm(spm_mgr->lead_thread);
 	if (mm) {
 		kthread_use_mm(mm);
 		{ /* attach mm */
-			/* TODO: dump spm ring buffer to user buffer */
+			int inst;
+
+			mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+			WRITE_ONCE(spm_mgr->spm_cntr->are_users_buf_filled, false);
+			for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+				struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+
+				amdgpu_spm_read_ring_buffer(spm_mgr, inst);
+				if (spm->is_user_buf_filled)
+					WRITE_ONCE(spm_mgr->spm_cntr->are_users_buf_filled, true);
+			}
+			if (READ_ONCE(spm_mgr->spm_cntr->are_users_buf_filled)) {
+				pr_debug("SPM wake up buffer work queue.");
+				wake_up(&spm_mgr->spm_cntr->spm_buf_wq);
+			}
+			mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
 		} /* detach mm */
 		kthread_unuse_mm(mm);
 		/* release the mm structure */
-- 
2.34.1

