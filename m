Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7014DCA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 19:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFCA10E545;
	Mon, 25 Aug 2025 19:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yI/ifzSH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A770110E545
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 19:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzQ+piptYIah6ilf7YBxdpIHHp1YpNQuLR6O90tfA/mXTsEe0p42UfZfBh23nEfdPAKBBLA6oZuOctVgdGE00f+oF2c/iIR12jyq/9G9KD2+f7GMspxoBzwzkoJHqKNsDUd2noxDHMhieE3mUb5BSlylF6vYoTBs3pBFN40q38gZYUMTSW2rmC9zVrH5oHgjAscQVN2sdjY5wC3GtQlxprK3+EZrofyjNj/6PUR/ktEnmBxKd2Fh85hk/5V/9zPPjqbLwp0r/bgVgFSug+w2UPcxQehoWMVdHo8QMago1x75h3r0aDcv/OEXjZQspQxGPPgR+cd9ywFcVXvgCVaL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=AB45u0QBJwkBwe/CBbW00wdCzx6A+5cAVcjhpADZCfnXMVbqcKzfIKDwR8OsYKwZcFuGGjOy7CIQ8yk67U/S47kACMKPemf68k1+EuP2C0Kqz6VZ4SYVcCn7u4nKTEIMLf9PqyM5EB0DNgkD99HDOwsKLURXkbO0x/P6n+fqMx+aVHTlWzsfoBgf2oY0GP67dKHecyqXce5p86UguAj8h/mD9ifxlsnmDyIQ3Lu2+WLISVjpXz5bKKo2torFe52jPXGWzgp3sKo+YvbXrh/FX6mVQhk5En7O/uSfMoS10cyrj5QBIXp4aNNzGQVblrwJqW+iiFio6UqyLubVinv5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=yI/ifzSHb0F90swWD0qb3KEG9O5adGoC3m3wyHzb0T687h67R7kc4q//Ol6wDkdRhVl0Ifx40QoTqkcJJohf5XCv6qLdxDjE65CbWxd/FHj1Ql2lJexcULL1Uy87hxJdxVqC7dQYLyq6jlY0zRtLw+JVJjE4HoaG5Ma0ZYYCC2E=
Received: from BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43) by
 SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 19:50:01 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::b5) by BYAPR01CA0066.outlook.office365.com
 (2603:10b6:a03:94::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 19:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 19:50:00 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 14:49:58 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v16 4/4] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Mon, 25 Aug 2025 15:49:36 -0400
Message-ID: <20250825194936.899825-5-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825194936.899825-1-David.Francis@amd.com>
References: <20250825194936.899825-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: dff593da-9c5a-4ee1-a839-08dde4109400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J2VK1HeABqc17H5SiY3bc+yJxiNhrjoh0gJSbSoEo/HZGgMr8Ftm6B+e+gSq?=
 =?us-ascii?Q?eiqrk+gWwJVBSL/YZzx2l+VtG/xCTRFCw+6J4dMXkSOYmoUfeHOUTYjPIkn6?=
 =?us-ascii?Q?I8YJfKcfur3efieFBlp/XgoHKGybSPUsGnefpro6/i3WF8mZ3vIXTkObnj6b?=
 =?us-ascii?Q?8XbguwhPmPUYeKo+nsTpYv2I6sxjmvvehBSEYI+1EtFZ++RueqAhflhpvqDM?=
 =?us-ascii?Q?AWr2tnAeEd4z2vwDq/uzX2w1uHXR2YeSefKWSz9EWihvIal75LRDXxil7RUM?=
 =?us-ascii?Q?iciZhD9TKoUfoDVsTe/xip+eG5zprbdmM/Ukdxcf1keAtsksqKp5ganOgusi?=
 =?us-ascii?Q?Qh3U55FOwObNbdHHRFTTJ8JGtH3owsjm5i8tcBPDRIuJCAf3hTT50/EhML7J?=
 =?us-ascii?Q?TQJZWCHLUt479hAeTnBsp5rwXrpFDIO4ASXmdCcNWcZUwSGvPARYBOuh42h9?=
 =?us-ascii?Q?VyXKbfqku3atl53RUxj0MIiJnALZP5IfC741SC1Ezwi081b2P4NEmJo5RuKh?=
 =?us-ascii?Q?hwWW4VbrKOCxERLXLFIAFUs3GhuWmsvgd2e1wPNCPbStjoSJMvQq169joTYc?=
 =?us-ascii?Q?jCkn8vWqq9lGKxrX91LZlmQeE//FLrxbgoxHtr5VETuSk+Nbp/oUzRatnHut?=
 =?us-ascii?Q?lxhbR/XTRw73Nrhe3FsT12tiluzzDA4iGGpNqOq8ZYby7TaiupfKS2vFVOjL?=
 =?us-ascii?Q?/JKCJsa7/mvtPsJ+GxJcL+7DoBizWgTxumOs5V5adpoObyQEcUpptpHjbEGR?=
 =?us-ascii?Q?OSUXGOM6NTuD3oI6yCEHFpoKEj9a1csmDNj0iZ8CFJgC+v0+wW/zcyfaJNzg?=
 =?us-ascii?Q?zg11scLwX3M9iXGVLuRkSO77iOIz37DkMvPmV1RdFLxHGuNRaCp5R1TbiqGT?=
 =?us-ascii?Q?nPUj/1M6C8McE26xvZRN9rQCSdSeQJZUwGpriPYOY8Iz5LccXSXT+IFYMTEY?=
 =?us-ascii?Q?SuRRaLAH8Fmoxw6ms9t3YgfcQwsYmY/PMaUplfJjsheaN03vNXi+5dlTkHV2?=
 =?us-ascii?Q?cIj8lv+k8MmgDDEDP/jWKVuFkp5Bj2y/EAto/ZD2Jd2gDYXjLBXYgBITISrf?=
 =?us-ascii?Q?eM+oJtK6ljbFQNA3/OhlqOXSIogrJISsTtdIiEsEPeIBVjqO309VB8/vKMVK?=
 =?us-ascii?Q?XtXEhpwWC58GamgN2NdOTs1BLIrCDDYmnZwJ9T1ZuItUR8EmirNFKbkqD2Gz?=
 =?us-ascii?Q?CU8Uif05fX/n0svZY/01BuJP9QwwcUq79QcBXW+/hrzSJKAYjVANCI8tCMaR?=
 =?us-ascii?Q?2kcq+IMEVYkCng079ABLEMvllESypNTe2hMJxrSr9N3/aFIf+WkfjR6cCGW2?=
 =?us-ascii?Q?ad3ojMcz3QyioR5KHLazj0+O91rWY2zRt05UneCLIXTKvY1dXYy++SjWow63?=
 =?us-ascii?Q?T179zEb6arQNOeoBM56sQXwjm8eW05mSXObE3i8I3eEosDyRYTq2kHzICrN5?=
 =?us-ascii?Q?syPuo+QnRINOzJiFZ0Nqy+0Wbaj1uv+4//IxcarYMjsGFAGB4/o26bfFl+V4?=
 =?us-ascii?Q?iICe/uZGUOjm4EA02Zl0pRgUpLyHL4sf3+vE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:50:00.8816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff593da-9c5a-4ee1-a839-08dde4109400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

