Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F757C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D82161994
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82161994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7653B89C29;
	Tue, 30 Mar 2021 19:35:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C506289C29
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 19:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfMoTxgstAgtGABn8JEPoF3QsByeLfqOC3515YbWnD7tzm0x5B57MKy8IHG22RzV/krpWUQqwDh/gGLRZjABfsOB6ylFY905xTMxcyRqr4F1zmuRXp633uV2FlcCS0mLskThq3GFqMvBJG0SdgQJEDHoGfzLz43nWrlxVranq8fLJDD1FnW7S9H3Jhk6VScVV/7bSCZcQl4vNqTOu2tSfbbFIgmYr+T0PtKzNz5VgyQfrGLsM5IX9267dDq2NYtvYubuXUDFGlRqRaocdNGJyWpLXwONuuDeEpLKs5xXbWnRXDTpigZQxIlmwJr8wC23NEVywRiTJYpNap/SX3tVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5BZTPdqFBvZCs8LYbkP7uVTTOF3Q1DQybNeZio/wMs=;
 b=ULV3vk00EtMffO6j6vGj7X80H6Zs8ycypQKqYdWHbv6CWq+6q6ZiVe0sQle1gmv7myP37oCE9YhpDK8ZTdR1HB2uSWwgYJujF5Dn9kvW8r1y5lghlx8iki4g9acpl5huGaJf9CXGddMrjugmE9WYCqYpWdbqvdkx0DS4zdv6ASc+Md4ECcuasAUTQrTDOFmceVoEaqgP+8WzUOHy8yXdNxEKuW2LZlkcwGS/SiiA34me2LIRogK46rb2eTqiz+OcrVnsy8mUYzU9FWtxK6+jNWWK9yNsmV4Pt092WvfhuaybgL6Nn9lfuR2qwnHzj2GNEMsJWqGvrD0FhNArmOvz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5BZTPdqFBvZCs8LYbkP7uVTTOF3Q1DQybNeZio/wMs=;
 b=gKOUbRf+uPy5+Y8v+s90DOpYVM6j8Q8IBatBu2Wadx3XL+7MFEzyd7heyPG7qp37dBEPQ5qUivq2BEhzGEcJJXU+PEtLtFA5NbwdxdI0pIH1aRvACa2ahQKnAC7Z59TCL9+eGGT5oIUa7Z1tx8NE12p6TN6LD6U3Sv68ryUn9k0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 30 Mar 2021 19:35:40 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:35:40 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
Date: Tue, 30 Mar 2021 14:35:30 -0500
Message-Id: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.32 via Frontend Transport; Tue, 30 Mar 2021 19:35:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ae75d08-564d-457f-b00b-08d8f3b3004f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33564A595BD888F10C1C2358807D9@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcsowPsc6k4P1KwS5j6ezXLl9xaH/J4+DeTv+CFoOoC9MOr7E8PNsk7b3Tml9H5m/WYB5Yu2agvieSbqRxnnfbrAIjgZlXHO/C2EgobSWCBUgn0+mfxxRpNRjpsDi0gn/ZV4/dOBAER9TIMCIFYQApGosODNWUuFzfICgFmMv5leNMFNNL2I0js9c9fFbuAK+nB6WtWfqOrjdbFAc3YqCJEOxiLnLl28BQnhOkPRm0HEk4KQX5WeutTirL1Xy8+PLNgurZrnkKmvTPZMz8UPDhOGhW+3HcDDMxEz2JyARyz0M6qrkw5+RMA6jirfcRJtCAsDWbuOAVYfhxLWmnOCVo9YPC0egB59QgsKidXMBPgT5PW5lcxdznebDxv4o/OOcfWz6n53Yi74BPRG4d/CEA5szQLycXwpbkK8/Ddo/UxB/JgqTMsXAn4n0ztym8hz1v0QjRchdj+3ynYqeLzqTbx7WMqyo4NFAqDn6xAusF/6xRUcT6rYRExentoHDp+R24CHQNFnwen0by9vZR2gBUQ2eoKzgaGfd4pgX+4giCFE3Vm/+ojwBXOyCXksT7YxO6wrOgXSshhzl7v/XET+OwPi7D/P4R+NfyQIW7QwEJ7hKqJxqeEgWEUPLrEDTRTsYAPiZA/pHmuJt9dTQeYCiIo9/JXbm+cCaBNDuFEFf/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(366004)(376002)(396003)(86362001)(4326008)(5660300002)(6666004)(2906002)(66946007)(66476007)(7696005)(52116002)(36756003)(38100700001)(26005)(16526019)(186003)(8936002)(2616005)(956004)(6916009)(66556008)(478600001)(6486002)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S6vEH79N8xlY9rjTDMOTOdvaGGp90iVxoTkKfrUVRu0KON5jp6XCBGRv/BgZ?=
 =?us-ascii?Q?z1VwxfmY4nzpKlrObcrj/ZjHOdR3i9ndn7GvW+KfkZH4t3fouSk6SoKAiS0D?=
 =?us-ascii?Q?/L+qSP6CKQEIqXZRdrQXcnfrRoV0fv6vnYDz5MYneSInU+tlv5/YN7fu4+yh?=
 =?us-ascii?Q?+U2rKm/0zlSV6VL5cRVxSswRhDjN4ICZbuPmV5pL98pJe5aIkLh+cQInZZQJ?=
 =?us-ascii?Q?Y2qNds1CP2DkSWvzozkRWcpD4hc7OuTVXOp/aOKK6P0waqsAj7oaYdU/dSUN?=
 =?us-ascii?Q?XKoEMxAKB0COAhkHaZMf3xIbDGpuNGbinq+0SSGM8sbpVmZCub44oP3WyZJN?=
 =?us-ascii?Q?NZltpYLn6zWohNjgegP9WNo8Zsok3BGynrO77/g0gRVDQrUhpPZC5jzxlVk3?=
 =?us-ascii?Q?wYuqRcrIdjJbBXsh7cfDfM6OM8c9UWp0F+FEwoizcFFba3TVyT1SbhiM5WML?=
 =?us-ascii?Q?mPuXzsNINC1vfFBlp7n3lFd/dd5ek3KCSgmvC/r4dvYLNbq5LvbaR1Zo+Clv?=
 =?us-ascii?Q?y+jMrnCX29RZnOczV/cbiTb7BZp7+sYk/aSZHvhihWd1ZhnPYIrgcvfcQ7o9?=
 =?us-ascii?Q?IdZAUko6EMmyIfW4DTZTFgG7twqVzZT4bm40FNMW2XycHeGzxTVv/deLRcXc?=
 =?us-ascii?Q?+e+GuoiybH5G0ZBea61SMAhL5ZXiy2kquSvS/g4dQsWfpAScdiKeruqv7MEN?=
 =?us-ascii?Q?5YVfkP1WszImWyDlW9MU/hTzU+3UPK8rVRjOtBp1XIspaFIpFaiag/oh9G26?=
 =?us-ascii?Q?irKawY53J2tOspEEt0ymujW8ZkINrrjWZn1znlv5cixWUhRnlnvXDqKOb0fc?=
 =?us-ascii?Q?A5VeJ0ZHT8F1fZ5sdtmADPAqII7KzXnRXMPjfXTRWMBltF+Zo5SgDmDlVOb+?=
 =?us-ascii?Q?J25gK31bkInE0gNITeMwohvpZRm7zTFo/a8AsrTDt6BhNDuxrpiOMRcADxxU?=
 =?us-ascii?Q?Ibint5DDvKmiXF8Uu87Qx1ZrNiRIIDH9XlY/XDhyhWezD+2YYzuTUhQJvdlA?=
 =?us-ascii?Q?2oPjoP8qZCITpbsDpU/4VcrrdFogvamXLpt8KKHyEAJwGogQj/3hRuMsny+g?=
 =?us-ascii?Q?fbn4+cvVklZDhUwEeM8ekevbalqutImM2xPiy702T8YBJlBEr7uDTN3sd/Jt?=
 =?us-ascii?Q?BKRVaKd9dsFjsrC7yg6JvnfDMzXVa3X+pMa56ZLdg2ZaAWQCzQSgvWXjMVOD?=
 =?us-ascii?Q?ScLehbCEmW0Ekw1VAzkly95r/VEmkxGT5Y9GPYR8ge0vF0OfzKDQbHIslGEa?=
 =?us-ascii?Q?CUbNJ5FshfD4sHMzFvqhlww5qLyywBtZ5hHiL5KZkxci8VusONbOp98lz8/7?=
 =?us-ascii?Q?/kzZK1mPF6QeByEYMC9ya8mU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae75d08-564d-457f-b00b-08d8f3b3004f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:35:40.5511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cGdQrtETuztRvki0dTqDRyxYiPWiDS2qG6ciyxrEoxsV2K2aBBUlLHN0/qPS6GL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add one macro to calculate BO's GPU physical address.
And another one to calculate BO's CPU physical address.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 7e248a4..b244298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -272,6 +272,9 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
 #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
 #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
+#define amdgpu_gmc_gpu_va2pa(adev, va) (va - (adev)->gmc.vram_start + (adev)->vm_manager.vram_base_offset)
+#define amdgpu_gmc_gpu_pa(adev, bo) amdgpu_gmc_gpu_va2pa(adev, amdgpu_bo_gpu_offset(bo))
+#define amdgpu_gmc_cpu_pa(adev, bo) (amdgpu_bo_gpu_offset(bo) - (adev)->gmc.vram_start + (adev)->gmc.aper_base)
 
 /**
  * amdgpu_gmc_vram_full_visible - Check if full VRAM is visible through the BAR
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
