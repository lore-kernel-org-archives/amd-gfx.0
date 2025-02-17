Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74EC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 06:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CD510E31A;
	Mon, 17 Feb 2025 06:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLVoXMig";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883CC10E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 06:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfNjkh3Wy+KlmPQ7XZF+re7guFZK83iwO+n7ELrB/VfWTTRXJftP5+z1xchbA7dv+L7JoxrJCrTfe84qDqaqvWScwLWPagarbZOePozdvuYdpBQYiV9fBTsGv2mfqZtnyvfu6xwN0RlPEqbCFA/wG4yCfoLVfM/QNGYBlf7SmQV7kYQdvCFLyt9wke3v6L5Vr2P8U3QCpFM47EgfHijCTRcUIlxQK3q3uaMSWQbXHNHLV8IOIs3+G+LdAGezBRF0GWDxTV0maC2eh6F8/XPFi4eZC07nIKjSgycIRGeRxq4BQYSpXRFxVnofK8hM+M3CrG06TXotTEEl+k/o8YUWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4RFvqrRX1VmE3s1+Ro9iNeWPtyDlZ5x6aHKCkT53A4=;
 b=HMSNen2uM2iuwnfxD5wYWQqrSAz4+b0VxSZ7mM+ZoHnIJvssFawYSFS8XKt0qyUL6V942v3oGMwCtJqqym8jhLmu+A1eFAa0BEU6cnYo7DR3MLTT36pwkdBzpQYhbvAsaAteSCpVUgzKkMoIgKOQMTjJfJByDJBtW/h46eCjY1fvMORyBDzRbiAIq6O/y4TD2dBCuxxF+m9flNjSy/ZbA5kwYh4uZCDjZewK08nuVMnLTIjShxjbsvODfuMMs2gkZ0dDQZKHMTE6pmI7ElIW8kM0il0vrHs+2U+RQd3Ki0VP6Hzk3g1SjvsZYSoM6EntwIQMxWAw/Mg4n1mHmyFNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4RFvqrRX1VmE3s1+Ro9iNeWPtyDlZ5x6aHKCkT53A4=;
 b=hLVoXMigDRvawxc7MVBAbj7WafDqF3OtSVWF41EDfPN0DlZRjKAal4HCvCLutzP/PPZqqNFA+tgqVrBGtG2eaDhR0odmh7W3hGH2AcScbYKmYvrSqNCm6Y44an4w4GL8DrgSOgQa1RFtrjjnIEBxH98c748U/KapcY0O+Ak8cPg=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 06:39:27 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::2) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Mon,
 17 Feb 2025 06:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 06:39:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 00:37:52 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Xiaogang Chen <xiaogang.chen@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdkfd: Fix error handling for missing PASID in
 'kfd_process_device_init_vm'
Date: Mon, 17 Feb 2025 12:07:22 +0530
Message-ID: <20250217063722.705772-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4ba31f-cbb4-4310-469b-08dd4f1dd2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am1jVVcvT3VCV1VoZEhRbDk4MWdHQS9KZTZGRFBxei9FNmw2ODZQRW9kLzNQ?=
 =?utf-8?B?QWJGajU1Vkl1R1dDYUQ2akdnTEhFeFR3NldlMWVIS3U4bDlaL2xOTXpUNDVp?=
 =?utf-8?B?a0JaNnNFdnM4djFKRUc1NE5JOHp0RjE0a0laRkh6SXFRZTNpVG1VVksxWmpM?=
 =?utf-8?B?NkNGQnlGekQrTCtKK1JQR3psVFFZa3FsUlB1Q2ZtUU5mT3B2QUFVZk9GMmJz?=
 =?utf-8?B?Z2tOTFR3alA3TFJxT2UwMTBXcTJnVmdkT0RtdDB5RVBDMjQ4SDMzTlM5bWlO?=
 =?utf-8?B?VFZVL1ExRXlaSXVVMVdEVUwyRjRlcmxVT1NTYTBzT0FETzdMeW1mbWQ2SEQ2?=
 =?utf-8?B?S0lXMHBTUGlyUG1SMkhuQm1ZOEVDS3RyT1lZRndmL3NwQ1FvUzJTU2lBK0dP?=
 =?utf-8?B?MmVPYXdCMXNoY2VmOXZuT2hvejR3UHdIZkRuSCt4UXpSVTdBcEE2MGo4RDVs?=
 =?utf-8?B?Zjl3MEsycG5aN0pjMXlxUnFRQ29mSjlZK3dsanNTamxjdldWUzNQbUdyanNZ?=
 =?utf-8?B?Mm5VS0UxSEJQM08yenUxQ2RJMFUwd0lKQlJleGpiZ2dFbGhlYzUxYnFUcHBR?=
 =?utf-8?B?ak42djlwaGZyeWhxaDg4WDNSdENVRDZrMi9sL2ZmcEdBblp4UnNCUHBlc01q?=
 =?utf-8?B?c3BGNDZSZHM2ZlBYb1c4NHJQNkFmMzUrWHZXVVQ1ZUJwWXorREVJd3c1VjVV?=
 =?utf-8?B?dFJEWjBFZFpaS3VkZ1NPZmIxcEZLZTV0a1pTcHU5U3NrTmthQ2RqOTU5SjZD?=
 =?utf-8?B?bFlpRW5CdEY0R2RFUnFzTDBid0Z2bytnazhuSFRrSUd2R2dsOUoyVkQ1Rmdh?=
 =?utf-8?B?SEpRSTNabmNQQUI4SjFxOWorY24zalVLSXM3T3NlbG1kL3dWKzg2ckZZd2tI?=
 =?utf-8?B?NWRFNHBva2JnYUlGYldkbWFJWC9IcVBGQkhFZ1JXOE1NL1lxelBmSU5NQkJD?=
 =?utf-8?B?T2VLKzk3VVNUc01mSnFwck5XQklJTmxxZGRILzJFUFZTdUIrUm11ZndHSTlh?=
 =?utf-8?B?Z0g1eWhtZkdEZjNxdWVEWjFlTUlsaDRmUU5OeGNzeDlnVUxnS1VoZDNMSld5?=
 =?utf-8?B?bEdsNnlCVGV4VFR4M2J1MTB1MjM1ckcvWjZPTS9ETWNXd213bG5ITmZ2Ynhs?=
 =?utf-8?B?UldldFRhZDZ5aHQ2eStQZnEwUExiajZibkY0cjdDaW1BTkcrWlZlU3h2RWRo?=
 =?utf-8?B?TXZST3Bqdm1iZWx4Q2pTL3Zia1NQM1JFOStUYi9WRmIxYW9kYnZGTndGUC9v?=
 =?utf-8?B?ZkRmdnExZHRXNFBTakdocW5TeXljMndjOUhaakY0cHZITnZlY1liQ0xkMkVH?=
 =?utf-8?B?VnZGVktFMk5GL0dlZ1pUY2J5Rk1BOXhhZjJWL21zaGFoWnE1ays2SWMzQTRL?=
 =?utf-8?B?K2VKY0syd3NaVFRsNEFhbkQ1U056NVJLd3VNbWtMeFFQT0FhT3NaWktveUg3?=
 =?utf-8?B?Q21ZVHBZNVZqS2kwakxpZVhZamlJeGZYSGFJYXVMNlpibHNYQWpQNlRIUktB?=
 =?utf-8?B?TExoemxXQ3pxWDJkSUdkdFpxTlJCK0Zid2VLb2xrTWxETGRPUjdNdUpPay9r?=
 =?utf-8?B?UUNRbjl5ZDFJZk9YZWFPMTZadjZpdVp1cmhjM1BHTTJJS0ppaWFaTk56cE1z?=
 =?utf-8?B?U290RWRJK21NcnlyVml0aS9UVGhUMnljOVYyZHlEbVllNTFDSi9XNDliSGxx?=
 =?utf-8?B?a1dweElZMWZDNnVBeFA1eWRxbkFGeFhqNHZKSTRmdmRzL0VvWEtXNGg2dXFq?=
 =?utf-8?B?RUE3VjRPQ2p0R1htUE45VGdTOVpUMitIdGt6c2E0VVdPM2JKVTE2eWZmYlZX?=
 =?utf-8?B?Q0JqZjlMTlU0VEFvZHpidzdGcDhUNUxZNkNJc3MxdG5TeXFCb2g3cnVseHU4?=
 =?utf-8?B?S0xrUVkxU1NzeXRwclhDRy9oa0toY3VoUHloczdlSnlTeHZtVkVIeDN6akpm?=
 =?utf-8?B?TCsrWTFRZm5DWnREMzU4YkFucUxMSjFHTjlHNmN0MER1d2wvdkxybUpDcksx?=
 =?utf-8?Q?Bs5DZ4ZW/1/DQp1Z04ZUi8OCA/oaUM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 06:39:26.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4ba31f-cbb4-4310-469b-08dd4f1dd2fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

In the kfd_process_device_init_vm function, a valid error code is now
returned when the associated Process Address Space ID (PASID) is not
present.

If the address space virtual memory (avm) does not have an associated
PASID, the function sets the ret variable to -EINVAL before proceeding
to the error handling section. This ensures that the calling function,
such as kfd_ioctl_acquire_vm, can appropriately handle the error,
thereby preventing any issues during virtual memory initialization.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1694 kfd_process_device_init_vm()
warn: missing error code 'ret'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    1647 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
    1648                                struct file *drm_file)
    1649 {
    ...
    1690
    1691         if (unlikely(!avm->pasid)) {
    1692                 dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
    1693                                  avm);
--> 1694                 goto err_get_pasid;

ret = -EINVAL?

    1695         }

Fixes: 77b5e447427c ("drm/amdkfd: Have kfd driver use same PASID values from graphic driver")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f45e33f79d36..1067afdb456e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1691,6 +1691,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (unlikely(!avm->pasid)) {
 		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
 				 avm);
+		ret = -EINVAL;
 		goto err_get_pasid;
 	}
 
-- 
2.34.1

