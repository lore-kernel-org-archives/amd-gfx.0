Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90585C5AD69
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7DF10E82E;
	Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di2fjqrJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C35610E82A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNgGF/9l7sj2hcn6BVhxYCCL3pw21nBC4iwS48KX+8i0ng0twzjhrSzD0fD1lFJ4I/HAAsqy1oZmwE/d4WVWWPVJwxNcxH0WjQqvh0ZuL4L2iheYyj0yp1l1ff/dnT/dytoTPoLgjDXtTykp03Ot1A3FV+WKukUojnmQQ1ngAdEaXVfOi8sSKB/MTfTbqGAaOeHJVoqyJaOQvARM0fMfbH61735tIPmwXOnokys3ntu61nmK+RMS/Y9ZJI5DSiI2PpsuPlIw2gEQoGi0y88VfT5WSKokSI35zhQ0FINeLwbkS5W4sf8iZRQjK5CGc4hFeQX96JUOmhXbYOpZ/NKi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tClS+YGz/JtJeG8F52WPByvaCja29ML2MAnYJKMABqU=;
 b=yIhhfBMmRkINzcHPsCAS1y+NKD7qoVN4UlzEYOWBGAMVupmW4bmLcx7rG7bw/1adX/jgfzEvhPQec7qvR62gvQwlvLCBYhXBaQplMoXLghYrnN7qEopxRurgo/9XLcjYggq3ihcFSbUFeHoy/sSNgJHlqZRycVud61wkR1g54k74mEPaLdN4RdjxoLfPjjmGH8eHUb6ad602iy3b8cG9ggJAAuEjmLFt2X0xaiLWD2CQUGJcTIBXbbOwKP/u6K7TFhKVhttjFxUcSVtxBIhdorJrC+cetS3FHEUkefMQHRQ02SE2wwAPtbX+a/+c6TzU4+UtLlnTLi5OOk+oRnNBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tClS+YGz/JtJeG8F52WPByvaCja29ML2MAnYJKMABqU=;
 b=Di2fjqrJVBqDuYA07GRfqwG9XsC7OpnhVLMHjQKMz9mYy4wHDFpTrUNkQkquvDhphWUsk39WIxC4/16m3de/rpwQKUTsTAw/sS+Fw8MCmjBqSV/5t+ypcmK5DYyOMRDK2GkMiMjT5bw+WL/jd4AicUpEstqYMtdLjtJCTRT9JTw=
Received: from PH8P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::26)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:07 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::d3) by PH8P221CA0011.outlook.office365.com
 (2603:10b6:510:2d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:07 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:55 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Date: Fri, 20 Feb 2026 14:22:31 -0500
Message-ID: <20260220192236.3121556-12-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: fca799da-98ea-4f11-8fe5-08de70b57a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Skxooals1tL2V34FTyrAUawkjaTbz90V+uFTQ9aNNqN2SyhkU0NaJypHsUJZ?=
 =?us-ascii?Q?88an8mEHKLDM1xKDsHXJuOg497Vn+IvAOv4nFf1SVtC/b7lN0ExWv1mQL+b2?=
 =?us-ascii?Q?BhvDMZGuLFxdkxgHkGIc67jjpNnhf07SkL2y3/A9ZDb1AhcNg1w6qAfaRBVH?=
 =?us-ascii?Q?1eePXVdGPvj7wya3GIvOjlCynoV/uTGbk1unBbxnt0IyKvwzSGLbzQFWNmtk?=
 =?us-ascii?Q?SnVbpwi8gaW4V+hcn+jgyWbzhzhFk93sfr2PqO32TwS9wgH3x6PrbAN7YhKr?=
 =?us-ascii?Q?Fta+NxI6t2TRWRrHL0NLUDCaLio3XSZ53rXl1E13T6cAVkGPSAL+ItjRAFVk?=
 =?us-ascii?Q?B5TVsyIZ+yaZOK7AEKHxJStSfTUqlY1JfKomLyr85ByqAP+/foHEd8O6DPSi?=
 =?us-ascii?Q?C8KIZitcykvua+D76xT0iTC431dC9C9Xy/in9/gIDJQvcuEOV8SrSM/P/ZMs?=
 =?us-ascii?Q?7J7gtK4tMvhWazczxwEWkIcYiRmV2a7Rlg14i0zXGSgrjnB2HWsHMLpwu+D5?=
 =?us-ascii?Q?2FMTwsP8c+/K8OinhrgCfKlbVm0RuZ/UkCb2j2a6O/OhKr8MPgC3nMIkvU49?=
 =?us-ascii?Q?JUYfdFecnm76KCKdM+3jWy4QpxZoZjvxUe3e7Mbg5mvhoRpJ3xp80bHv/15A?=
 =?us-ascii?Q?TwmGVzZu7ocKIsRld3aLYUv9FIoQF0PYuxbEaNf8d6bwqxkbjTW9I4OSxkNF?=
 =?us-ascii?Q?x8yaceMB47PWzRgCbjhc0TPdpYdZjsJUd90eVRyXXqS0gTK8H4YXiQgGVanT?=
 =?us-ascii?Q?mO7HzQ5MVu/gbmV3TVj5FByXoeJ5Qb+neFptGr/U8Pis88krM94705EsH+NG?=
 =?us-ascii?Q?udPGhMF6MztiwKKe2CBZ/va/2zKD/ggPOTIioCGSimgYYuIbixtpVbRlWhuV?=
 =?us-ascii?Q?j8lPOP24hV8hRkPyXOjQNhuZ9fnzv3MfqaIlIPivMqyMog61NzJ6EQAz2szv?=
 =?us-ascii?Q?eemSxPwszNXY3NWALWDfGmoB6SiQa6LE8N72yQFQ9lT/R2Sqar/2H2H1fm53?=
 =?us-ascii?Q?tm4n5oS/HtLZuKcAqTfaJkmllxxlnj1xPg9ZD9xmzGGnfuzanuXLJuvN8X2Q?=
 =?us-ascii?Q?W6Q1jy1iYLbYvCWYf9DMN+gwjUvvTciMe9WVhX1luAzTVlYWtAWlDdEr0du0?=
 =?us-ascii?Q?0w6i6zbLqDPUiGG8ycHVcEvDhTQ2HOCyT8VOAl8VJRzG6o+XInschBEv9Vec?=
 =?us-ascii?Q?6P+TqsjB0T57VimiVjVs6nIp0/FcRX7vPthNX6bPEpqpSz5ahUrmRWuAEsPR?=
 =?us-ascii?Q?pY5Jmvf9jc00yIBZAQg+lG5eiaAYsI01JYjO/scZzYzNtgTY2vHt0Mz8UX2H?=
 =?us-ascii?Q?2eaakGaewcVwgfp3JySOnx3KvvRCvFzG0ppFxzYftxmZ31ALW3cvAtup06UL?=
 =?us-ascii?Q?/t7lw5kD1Aeqrp1eJaWV1cAbc1J+yvnRSVQ7v0iyyy8MX3Fl1nYPn8PV1Wqs?=
 =?us-ascii?Q?3qa2NnW5n3dY+Al+W8LFMJmBG13vsAPTafn/skhX6py1iz9ZF5rP1twqXrba?=
 =?us-ascii?Q?i7P8mItcQhouEMvQbiR8iwPyY321lWyCcdbFlzuXGNdoikCU11QLJ0kv8ioM?=
 =?us-ascii?Q?YINQ0VUSNIHCAM2B+tzk7cawkDpiuN9lFNr9Yff9z9dAX2WWCXpcHnNV41Wz?=
 =?us-ascii?Q?4GCQbeG97Erlz3O9lTacXatPUZJ+4ZAp4sukCgJgEoXgyUW3LYwvN6QUQFSM?=
 =?us-ascii?Q?NxLQog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g7rwx58HWvM/UaYlD+XdQ5AOHlgRVxsvi8AcZOfWONvpygkOVG2d8n/FHbipplokAhKxbCpPpjObXQLyRta/Y+bmmR2Ng+8H/qPkI19O2YXckojRGlA/cFugCKlLTUJs4AhGksKUfL4UseBqf3z6xEe1h5EENSPgIEq/lDTaYufzXanp9XwzG8Rhw6T44CwstWyKn58Vt526oqzLMYJ2KGU2CP3wgdxOIu/uLEmrKu/tsSZmG5sOcBERx/zikdi/FTaRlvhteEvbAluzFk5hH3u1mxiBycQ/TPsqqLseFLd5/uKSw87Q5btWtjj83ueeRTlVwMC36kF9vtaJq3V+rAVbxe7L//faxE2LuNz+qlytoEfyORO/2dBFGLs2RKN7XcU+DAPOAi+423O9neitaN1jp+6r8zCX2YHK0ZnjEap6M/IhtnJwgw123CJ4FfyT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:07.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca799da-98ea-4f11-8fe5-08de70b57a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
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

to stop SPM HW, flush SPM work queue, wake up all waiting queue
and free SPM ring buffer

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 52 +++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 4b2c7f7b494b..d84814069846 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -180,14 +180,57 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
-	/* TODO: */
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	unsigned long flags;
+
+	if (!spm->ring_size)
+		return;
+	amdgpu_rlc_spm_release(adev, inst, drm_priv_to_vm(filp));
+	amdgpu_vm_free_gtt_mem(adev, &(spm->spm_obj));
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	memset(spm, 0, sizeof(*spm));
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 
+	--spm_mgr->spm_cntr->spm_use_cnt;
 }
 
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
-	/* TODO */
-	return 0;
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	unsigned long flags;
+	int inst;
+	int ret = 0;
+
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	if (!spm_mgr->spm_cntr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		amdgpu_rlc_spm_cntl(adev, inst, 0);
+	}
+	flush_work(&spm_mgr->spm_work);
+	wake_up_all(&spm_mgr->spm_cntr->spm_buf_wq);
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	amdgpu_vmid_free_reserved(adev, drm_priv_to_vm(filp), AMDGPU_GFXHUB(0));
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	mutex_destroy(&(spm_mgr->spm_cntr->spm_worker_mutex));
+	kfree(spm_mgr->spm_cntr);
+	spm_mgr->spm_cntr = NULL;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	return ret;
 }
 
 static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
@@ -394,6 +437,9 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
 	case AMDGPU_SPM_OP_ACQUIRE:
 		return  amdgpu_spm_acquire(spm_mgr, filp);
 
+	case AMDGPU_SPM_OP_RELEASE:
+		return  amdgpu_spm_release(spm_mgr, filp);
+
 	case AMDGPU_SPM_OP_SET_DEST_BUF:
 		return  amdgpu_set_dest_buffer(spm_mgr, data);
 
-- 
2.34.1

