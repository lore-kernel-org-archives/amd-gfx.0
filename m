Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78BCC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A4B10F56E;
	Thu,  9 Jul 2026 14:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oEQxT6wz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B964510F56E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 14:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVBIsS2T820f/NRHQj9jpDiwXZyUOfd9cXH4n2p6qcFQwggFuncTmDNmnB/ccbmi7nxfwuf6kK1fnN8T8uMy0ppmGMtcufoPW3OhLW+JQ3ror4YSrA1wDrca0rw/WjkNNEIOjLk/Pbv0Vy/jPM0z/AdZWAzH4ObXjMUXZHAnfAoAMu8SxuOm/a54Ut9QebHeEnosefDKjLI2ONBvYxQS7x4hUKd4HiQH+crUPaNdPyJ58mRd4QRfMdYbfl6/ot8GpxS9Ag1qnJq/DRWUVgohA8oZA/+4D+3qIEua5fExqsi2+7XK0jvOXmgu/bm7cIVBO0CLUnVomofOMx8a1JIjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svojBXe0YE/0E3gTCQ0vmArkVeJH5yjZfzMQ1U56ecU=;
 b=ySLyeFbe090i9imKAPv7Mf0Ikvsjwg6ys8j2eIsXlxCLMF/yFgaPRYM93ZqrAfthlm/8hgRJw9jcr4hxwwl3XtoPvhW9FlmShTQtcb9y7fNxbRol5LzOPBiFzmRi/SpxazYiELFA7+ktvgiMl3mN3A95e8SV5wLHKYCSPzvJ2+ivu1ON162mixEpspeO6e/LWOjUX6r3FhVivbID1u+672Ar0gfPiKhFQMQpZP/0UVaLJwUOgvRhF8ZA6vfs3wJV3wuHhOm8YZ0QxsLfzSUjFy10vG5vWuMvdE/4SDAUHOpR7boTIXHhdM8a6bl8aW3pCq0d5MOV3RSdvfJ+BMTZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svojBXe0YE/0E3gTCQ0vmArkVeJH5yjZfzMQ1U56ecU=;
 b=oEQxT6wzYWZDsIBWxX133ASa1Wk7g+81hGjmcHfiS19jHMyReTFiQAyle940Ne7cCQ0n4FVJtv9aMrzW2r/3UorTK5nNasSOsA5fKdZKS5nDuPcMTY7O3PCd9l0V0toiSNR2o8FPoDmUjk95aFHDIBPUzwLcztAI0zKEtWx3iKc=
Received: from CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::16)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 14:29:06 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::2f) by CH0P221CA0012.outlook.office365.com
 (2603:10b6:610:11c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:29:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 09:29:06 -0500
Received: from [10.254.93.144] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 09:29:05 -0500
Message-ID: <e45fed67-77ee-41db-ab51-99304aa059ec@amd.com>
Date: Thu, 9 Jul 2026 10:29:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix DM I2C teardown race
To: Alex Deucher <alexdeucher@gmail.com>, Geoffrey McRae
 <geoffrey.mcrae@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
 <20260628163239.1599449-1-geoffrey.mcrae@amd.com>
 <CADnq5_NviF+5uO_HQ_H+BTY+M1WNZcf5fynYxNXE_vsDMg0_eQ@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_NviF+5uO_HQ_H+BTY+M1WNZcf5fynYxNXE_vsDMg0_eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa39163-8dd8-410e-fd0e-08deddc66ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|42112799006|1800799024|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 33KfGovN0vrUE3x+XQlsKfcgU1+wR0IpOWzP2b5f4Js5iVDlP6EQDdkQUUXYftUzemup3hO+/BaZI7SultptuqFhGpIOTydu0Z7jmvo6TQuKsCSVQ5bbE8WO8PESQ7aP29XZM6aiitVRz8f9VnK2wUQaTOoP03ZSnawNBcBtjAd2AWmLrXczKXVWZBeXb0YVBZVghIO8r+qkMDYPn2MbQ32koMwblwQofDSR4JRRa/HhTrcRj5DUGtb15pMclZm3Z8o2GSi1Iao5nS07Jt/PhUhxKIaH3Qi1cVLwu71BdXwdy05KrFrKV7ngOtnHPe8UYCq1KXCBnwQcqCwiBN7MR+3e3lF6tzxj6FOtMtIW6D9zhz+3KBnUziK0lBFtVLjIR6FsMw3pDNW/o/g7ZEC5tgextnV74Pzbz02Fzrae5dlKvGOTgtTikBtma6DNGvtBWpYNz5zKd7x9TLMeBD+FSC58V7jRJ/30Z2kqeAC4lQKGEFcC9QWatMQwET0/IdmvHClHV+fG3ipB5oxYJBx2pe1105JUylNSW+EzkF0mwAvaDAYr14TkdKY8ezPwdpK2f7Yx8dhwXAclaQHKU1/6f9Z9lrWie6egbVmLe5gajdIvjlA6TCPB9tZ/azxbhifsLY7cWFRucfpO/7edrUdkNnGET6JfWYAY3ssDD9Q4f4n+GWLsm78qjYqAoxuuwdy8i7Yi6svmOICWWI6TMw4F6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(42112799006)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 27BM9fJruU99V3QtARK8CXZx5AGlp79FcG7920XYHjN+gKxdkei46PeisPQgyTULOfS7uX37oIy4Wnz+LimCMa2ilsFY4zXdUEyb5E9moHSPrAfNqRcA6ZYtLPiZVtrMNhhG1CZlAU3cwGEw22r1QX0qwtuae3fDinzaIZacdo3yG0fFboRjBGYdWDo7/i97Ld1BUpsi3J/juMMgxM9Y8oSlwhao4CIPGDbFAENdZFNdE74IBRswimT8o+iiNS12LQ1XPqHAKHKLkW6Sw/qn1UmjrqF7UY9yd2DFNFe6UMm+Axz3D+UvqUtopPYq3zdGyoFUzIBPGiNQ/+nqtvEgLBWgrocoJkq9HiMDhd5y+NZoh3bE8xqsX0d0ua9uZeAj93+Jr/Un+P0n9R6smNaMwju7k81k9G/STDExXvmsf4V9mTOEyQLM7yswccjOWgNQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:29:06.6736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa39163-8dd8-410e-fd0e-08deddc66ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
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



On 2026-07-08 09:30, Alex Deucher wrote:
> On Sun, Jun 28, 2026 at 12:39 PM Geoffrey McRae <geoffrey.mcrae@amd.com> wrote:
>>
>> DM I2C adapters can remain visible to userspace while DM teardown is
>> already in progress. A concurrent i2c-dev transfer may then enter
>> amdgpu_dm_i2c_xfer() after the backing DM state has been torn down,
>> leading to a NULL pointer dereference.
>>
>> Create a devres group around the DM I2C adapter lifetime and release it
>> at the start of dm_hw_fini(), before HPD, IRQ, and DM state are torn
>> down. This removes the I2C adapters first and waits for in-flight users
>> to drain before the structures used by amdgpu_dm_i2c_xfer() disappear.
>>
>> This fixes a teardown ordering race seen during device removal:
>>
>> BUG: kernel NULL pointer dereference
>> RIP: amdgpu_dm_i2c_xfer+0x122/0x1c0 [amdgpu]
>> Call Trace:
>> __i2c_transfer
>> i2c_transfer
>> i2cdev_ioctl_rdwr
>>
>> Fixes: 5b3eca05cfb0 ("drm/amd/display: Use devm_i2c_add_adapter to simplify i2c cleanup logic")
>> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> 
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b97ceabe6173..5613dc9903fe 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1496,17 +1496,26 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_block)
>>         struct amdgpu_device *adev = ip_block->adev;
>>         int r;
>>
>> +       adev->dm.i2c_devres_group = devres_open_group(adev->dev, NULL, GFP_KERNEL);
>> +       if (!adev->dm.i2c_devres_group)
>> +               return -ENOMEM;
>> +
>>         /* Create DAL display manager */
>>         r = amdgpu_dm_init(adev);
>>         if (r)
>> -               return r;
>> +               goto err_release_i2c;
>>         amdgpu_dm_hpd_init(adev);
>>
>>         r = dm_oem_i2c_hw_init(adev);
>>         if (r)
>>                 drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n");
>>
>> +       devres_close_group(adev->dev, adev->dm.i2c_devres_group);
>>         return 0;
>> +
>> +err_release_i2c:
>> +       devres_release_group(adev->dev, adev->dm.i2c_devres_group);
>> +       return r;
>>  }
>>
>>  /**
>> @@ -1521,6 +1530,9 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
>>  {
>>         struct amdgpu_device *adev = ip_block->adev;
>>
>> +       if (adev->dm.i2c_devres_group)
>> +               devres_release_group(adev->dev, adev->dm.i2c_devres_group);
>> +
>>         amdgpu_dm_hpd_fini(adev);
>>
>>         amdgpu_dm_irq_fini(adev);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 909ee71d6d59..13a18e1ed576 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -688,6 +688,13 @@ struct amdgpu_display_manager {
>>          */
>>         void *bb_from_dmub;
>>
>> +       /**
>> +        * @i2c_devres_group:
>> +        *
>> +        * Devres group for DM i2c adapter lifetime management.
>> +        */
>> +       void *i2c_devres_group;
>> +
>>         /**
>>          * @oem_i2c:
>>          *
>> --
>> 2.43.0
>>

