Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CAAC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457C56191A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457C56191A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53026E9AF;
	Tue, 11 May 2021 03:52:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8EF6E9AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 03:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiyfFsGNBfrFjV0PWbwfEbeE9Y+BERapxsPeXCPJ6tw12Rgv3r2OH4Sp5sl42oUxScUzRN5Sny5sGC0GSxIAjr7K3F0r6mMc717vxIDobZ9MH8Lw1MWSb+ZRlAMJkN45Lwem3G+UnvfO1f6W/6b2iIt2pk29U/RGWP4rjJNowcSYItDbfbHb80ecbtfiwrYmRig9WTaeTSGUq/rhpdCSr3+/kqW1ATE3KCwT1amcy+rqN2gtbDoGu0H8XTVtO35tbATPt/Dh9987BiJbmCbpvvC7mXfgWJI8nZSH04neHgreLsYCQKV3hRzLQEE2Gn6McYC5ID+QRR6BFsDygD3DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C466+UaJ7VQcB0OUFFyBlCFeNvWCGYRPxfA9tYSXWSM=;
 b=QF6UkNAfdWEzPSXn0vF9TzeiR7nuN2CapJcReyQE1zF4pxxqraKVYKN8j+n+v12JA9ZB5fJHQ+m0QCLUWxFb5q/e+s6/xeqFBmaAZJYRt5WrHLSaS6JSa9VQ83wna4neQUoh7UdKvNxoj+KY37UzUn2KyU9tAXfPlfO8NkSGiiv8l2YUoNbQGzIsb+PQRPZXTMh8oDIlKX9bPmc9n2PWp2BDbbLB4U7AjGpQiFN6kfeZQbUISpBh5v9IH7MXzmLO+ovoKYSjrn+BoC/0QsRIDWkb16YR+ZYJb/8JMaqdWcLo8WhAuk0/7cZx/6fbaGXiniFu1QNRTHKSPXlQtifJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C466+UaJ7VQcB0OUFFyBlCFeNvWCGYRPxfA9tYSXWSM=;
 b=UTgRZMIWzSbwp7p6IWmffp5rc65OP9AjsOlBBb5fbI2y75LpRKDs1eGT7RpuSXtzAH/4Ecbi+P9G/nRUAFKvLQtJalsojtawLrgODyEIX1IItrAkSSSBsqZ11H1vpFwV7vAxRrJb9glkgk3bxE9P6Et+ubMZWz8na10/T5OqrEI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Tue, 11 May
 2021 03:52:41 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1%2]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 03:52:40 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: update the method for harvest IP for specific
 SKU
Date: Tue, 11 May 2021 11:52:19 +0800
Message-Id: <20210511035219.2291350-2-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511035219.2291350-1-likun.gao@amd.com>
References: <20210511035219.2291350-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To DM4PR12MB5181.namprd12.prod.outlook.com
 (2603:10b6:5:394::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 03:52:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7137a455-c8d1-44b0-6ac2-08d91430397e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5198D8B7CE09B2357B939CBFEF539@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVv/hljMfuU1Gvi99mrExXGsrGI5LpQK2/ykmtLjeorpW+zJEy2cF2KQ5s++wq4VWv2AuabQeNq+1jVJRun7u3H8/2KySkWCN0dm4QDKdmnA+94vxSgQ41VYZtlQU23POW6/+ZYkSLhHoSzZWWpWcYcEBX3OGi1J+aAOOBh2LsTiuqT4kpVqFdUnf1OMXKkOKx8OWkb223HaHedNHSTkCkmZVXgoRDjdTU52ZgH6iy5hVSnQ+8NaQu//r4dZJSMPHttFvJDz5knSxeTYsKsKUYLe9L51JnP+yoXDxYD0VDRQwI+SPQ6Z2cPqS9et65NCxyRwFiBMv9sCLCUfyjRjt9y1PJvlRknUiurfxyejJCqE8073jdle6kQpdiX5TMwymVYJPjy7NJW7RSYVVmI0phLjrldB3tu9QXvFpNXdxvcnXPE7oaO/ZciTRh2UcrIWHqog9f5V9XbnHImS7n8MB0c11K6SluFh85Q6rRSAOiy4YKaexeP7enJsFyklhc0n0O4/Ias4GnLdNz/Yz8peLYw3U/mt52gpo+RpxLSD9m6XOBLzWZyUzVeFLl6Bu+bVLBwlZzWlOG3uw3S/2xoI/CK0t8NuoPKsj9ZFZAi+8N0TKVsBlNo4YjKHZKLig7Z4Kcc11UspNHr4LIYL3rZltd63/DHb6DeSIAOE/ncdyvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(6916009)(316002)(2616005)(6666004)(86362001)(6486002)(7696005)(44832011)(8676002)(83380400001)(5660300002)(478600001)(52116002)(54906003)(26005)(1076003)(186003)(2906002)(8936002)(956004)(36756003)(4326008)(15650500001)(38350700002)(66476007)(38100700002)(66946007)(16526019)(66556008)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d3OZnb/4yOHwutPlLqwiOAJ4NBZ63V1mH/aaIc7d0D+VjHblQr0zmh/YDUTl?=
 =?us-ascii?Q?ZovkYHLQybp+IPF1M6a8Ns+e9EjvCSxrw/rc7W8b3cQLGfuvRopT/cOF2jmP?=
 =?us-ascii?Q?cf7hrEYy0qWyv4MERSXuGvq/cAU90393wjFjLcKpfc/mXsO4Io137bdRQPpI?=
 =?us-ascii?Q?VtjuQjgM9walhXEZNLCyuknqIQ+5q6PfswJupZ3c1KEUMGHA+W46fx4MRLww?=
 =?us-ascii?Q?qus5LVHv6a6eidJO3PjHVNa6nPE0sXt0EwSte0Pzi3f2FI3qBEixlqlisuoz?=
 =?us-ascii?Q?qfdNu2D8yZBClioTcKvq3eGs38nKhugGHxZ1iLlX4lyqYhMGkEo1V3/b2vre?=
 =?us-ascii?Q?bSRf51tNDbLE+N6BrW2IpjOlImVuzz9TSw6l2LAOvraOKu8Cj76j/qWU8S3Z?=
 =?us-ascii?Q?57dFODLo3roeSebkiRTzWLb5IN6rAhc5oM8ab1DbsS+ww7DkZIvvw896wjLE?=
 =?us-ascii?Q?5/24ELK71V7+6RYJY585H9C4TPyMxSzKgAzvlbr5bf81DYgF/3u5bP0ijTrH?=
 =?us-ascii?Q?tu+gTmeZOf+fnDnA+tHXuHjmegYeJNJU3wTTFpvrvR8TxK0zAsQ7mFtKZYG8?=
 =?us-ascii?Q?cs2ndc5WRWxv7Y6iKst1/wbGt1goyMuKizpIK+vFvD5DQRCTb7JUm1esag3h?=
 =?us-ascii?Q?DKlThBqAMLqqdif3R1zFf8nLveHqKevWLFtEj1CVNBJSOCUdh8ZDFBpKnrRZ?=
 =?us-ascii?Q?k4elAVCSnqrGI1hwNvCQhDFfymfgqqyBjPIpDLUNqseY+wVMOC6w87px4Iu6?=
 =?us-ascii?Q?PZp859B3qosuhDeCzsjhlXz835WpG8+CvQR7FFIHFQ0Sio1JQc6yZT/ND9D0?=
 =?us-ascii?Q?omwPn22aqDLesVLYkqOl68YVu+rSpPPoddPjoUylgw30v548gs5PrrRNZsPL?=
 =?us-ascii?Q?gxYyMSH8DyOr7BqcPOUPbYQD2V9aXmOyzrr7gZ/W72XnxIAfajrCObtfSwSc?=
 =?us-ascii?Q?aozesRucmjJaTxHcUBMXDTEZhk8dB9Q1QpUahLOLJZvsDMUtDVPZH9nKWyGg?=
 =?us-ascii?Q?i8HuuhsvT1sqeeJhY/aMnqTAdzWi7MOCIVDWrgc8N1QzRC7//ZM5wK8dCzTf?=
 =?us-ascii?Q?nqW/BAuYmIiyQKcCMWuYKVH+tsFXVVBqG3DgumvF+AdU1lW34+E7wbA31uNA?=
 =?us-ascii?Q?qJnkRzRKfVpvixw5DaS1h1qlwrihhX8UgbVZ2CUrgdAYH65kSY5HHZdiBX2l?=
 =?us-ascii?Q?vLd/Efya06xmvtLX346fOoH44zxjhYAEMQjucCIRlfpdFYdLav0Me8JRQDP3?=
 =?us-ascii?Q?S0bUwbzvyJbXT+OPLyLamp+jhfZSpDc7+QwfItHsCPG06n/x3D6lOk3HfAEl?=
 =?us-ascii?Q?ggP9EgajcICQMortfJEjqMtt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7137a455-c8d1-44b0-6ac2-08d91430397e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 03:52:40.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u94NaI9NZivD4y74u+RgoEuJzkO3/mip5hUaZyvwMta8O/kwDlXlPRig/lruAqcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Asher Song <asher.song@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update the method of disabling VCN IP for specific SKU for navi1x ASIC,
it will judge whether should add the related IP at the function of
amdgpu_device_ip_block_add().

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d261f459c982..0be9038fa350 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -623,6 +623,16 @@ static const struct amdgpu_ip_block_version nv_common_ip_block =
 	.funcs = &nv_common_ip_funcs,
 };
 
+static bool nv_is_headless_sku(struct pci_dev *pdev)
+{
+	if ((pdev->device == 0x731E &&
+	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) ||
+	    (pdev->device == 0x7340 && pdev->revision == 0xC9)  ||
+	    (pdev->device == 0x7360 && pdev->revision == 0xC7))
+		return true;
+	return false;
+}
+
 static int nv_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -636,6 +646,10 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 		}
 
 		amdgpu_discovery_harvest_ip(adev);
+		if (nv_is_headless_sku(adev->pdev)) {
+			adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+			adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+		}
 
 		return 0;
 	}
@@ -673,16 +687,6 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_is_headless_sku(struct pci_dev *pdev)
-{
-	if ((pdev->device == 0x731E &&
-	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) ||
-	    (pdev->device == 0x7340 && pdev->revision == 0xC9)  ||
-	    (pdev->device == 0x7360 && pdev->revision == 0xC7))
-		return true;
-	return false;
-}
-
 int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -730,8 +734,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (!nv_is_headless_sku(adev->pdev))
-			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
@@ -754,8 +757,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (!nv_is_headless_sku(adev->pdev))
-		        amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
