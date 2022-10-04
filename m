Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D34C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 16:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CA010E03E;
	Tue,  4 Oct 2022 16:42:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8525610E03E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 16:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7nJvMYtvIGDxdY1zNtgXDTETV8cFy6thZzMaCfR8wAhmrkLV+RF3LE0DlRqG2redZkqs22C6piXt6HYwsQngS9Xklmrtwa66rjizSctoqKgi75Uo8mWFVqsQ/l0e3Hu1LbPP7XkXHsJYKKG4FOfatP0YLAG4eOfWtL/WNjCfEZcDWzZi8+sd1gwAHtlX0jtf92lBOQgQsww7hNr0E9+ZSTQjN7UNMU7NzTtTsidAR1pfejAHxcPETa98V05UCperdzd4JJHe4m1bA/2W52sbCVjTcYbcDKcwCdGuh7knL13qRizenR3fGvoTr5ismnMmY9V9G/5yZGjqnx1M+Ek6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpgjsYEZYLvdfLqxgKRQTBJzovV67hCgz9NMiHCb1fk=;
 b=ff7szkt8e7FOv6yGZ40WexLQpVXTsImw3iByR8VnfqnYPnWB5ZQOp7JSF6B7SSBFGjr+9RAr0IWPhvI7STuWTD25yvE12HDQa7x1imcAPpkaWNr+yPQOw6+Xrk2O1qbYOryocCD+CeZ6zLpn+LHUQJbh7EjkFKlgx+HVdLpoH46t6MSjpiOfzOuytxWzYyfYLRTUcmHeHrrU/1b+iM9WK0iml6JIMrGPDflxdxcBtyKuMt9/ZuSRimUQAoGf+MEpITaqCz5sdfbEjiXP8KDT2cA4K42pfdR29oXnGAdyks9+RCskAmqRe0D7wKJxE7HJME8IApT2i9YdgVPZwZXNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpgjsYEZYLvdfLqxgKRQTBJzovV67hCgz9NMiHCb1fk=;
 b=2VyHX2VJvlc6CRVrQ2P3W74DfUI/MxmqPWcxIvn6qaH2xiCuU5y+68AO/m7aDv0ZyGI0pDUrPahjYITdw2MqMjrKRrQjhMKXHOcwsgu+MOojcfCPKlLsrJUz/XzuO6G79cg8UJrpThK6BIOVkqkTNETCTvNaTe0sV5koaVnzdC0=
Received: from BN9PR03CA0355.namprd03.prod.outlook.com (2603:10b6:408:f6::30)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 16:42:14 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::78) by BN9PR03CA0355.outlook.office365.com
 (2603:10b6:408:f6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Tue, 4 Oct 2022 16:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 16:42:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 11:42:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Correct amdgpu_amdkfd_total_mem_size
 calculation
Date: Tue, 4 Oct 2022 12:41:54 -0400
Message-ID: <20221004164154.9021-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: b26440d0-ead5-41f7-b9d2-08daa62763f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5ZRdEcOlKoI244yeDyw1+dtnQuURR8y5CNLfR/GRM1QDUPTDZoESi83L225QUvZ9cn2uTWo+VyQm/GZg7Hk59WjLHATeja/z6/vZN5XeYU+87a/JLvY9f2w/tPUzFJooiNkZxz132189V7cQV5dA8+77/9no5JPeLP7aFWY1aN4rK61dmSx7Mx7+UvI4Epp5kC0OQb/MxYiRu12biLrOOsDrS+EC4/jnwcYwtIbuQTTh3PebG7JvwH3G8EpbAFXO3zfjUhne9jGyhAaQIo+QSkOJp+lsmmUviDcsn77S4y3l4FxLUBeiG/vxWC7+2g2d2AJ0vXFqPO+uXjxiBIYstgqZEOa9CJzt8YTj1ur985dZ/qKNIjgiboVmDVRtwul/Ck3z8M6QyBtMqhQAKe5uY8RwDR3Xq0MHBS4G+IlVvHXrguqCGXExE7VVoltBAhQPNdELW9mt+e3i8YWjd0XZjq1cy9e/FkWBFwfyMfLdBKNgaQ40uf9G3bluGKkjXDhtB29i0Bv3Jc6+4tl9XlM3maKnupTd0nyxFE6ltDIHB7G0XZdS7mWjogC7rvqTInKklbEsY5Kw9t5eLs1W+gXAyMiQ3NYlz2+f2QtDxH8DJqwV8Z04lELxwmDTg/klZjczaDGbtiYhj2t55tVDaBVKtJFMOEvx7ZdZXrwH5Sx/fWIGTqbhw84BDHqWSpy7mtHnhLWAHSCCOe7utVldBw6m5ifMY10FUT5wBvxWqiBjAFqtLjR+/NBPsqhkwRZDAjqizYowF+UxvJPCwfveWKDhNwbAEVaKaHPw8h+XckK8JBlFw/5ooHPeyLzj30BfK88
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(16526019)(186003)(83380400001)(336012)(426003)(82740400003)(70586007)(47076005)(478600001)(70206006)(6666004)(4326008)(6916009)(81166007)(316002)(40480700001)(54906003)(36756003)(8676002)(356005)(40460700003)(2616005)(7696005)(8936002)(1076003)(41300700001)(5660300002)(26005)(36860700001)(86362001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 16:42:13.6811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26440d0-ead5-41f7-b9d2-08daa62763f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdkfd_total_mem_size is the size of total GPUs vram plus system memory
to estimate page tables memory usage and leave enough VRAM room for page
tables allocation.

Calculate amdkfd_total_mem_size in amdgpu_amdkfd_device_probe is
incorrect because adev->gmc.real_vram_size is still 0 called from
amdgpu_device_ip_early_init. Move the calculation
to amdgpu_amdkfd_device_init to get the correct VRAM size.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9e98f3866edc..049d192c7cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -75,9 +75,6 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 		return;
 
 	adev->kfd.dev = kgd2kfd_probe(adev, vf);
-
-	if (adev->kfd.dev)
-		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 }
 
 /**
@@ -201,6 +198,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 						adev_to_drm(adev), &gpu_resources);
 
+		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
+
 		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
 	}
 }
-- 
2.35.1

