Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE6E8305F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0253B10E283;
	Tue,  3 Feb 2026 08:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZs/JD6T";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3918E10E269
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 08:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDndbjibp7p/QWxaALdGHlJqP7WsRE0FefUb6WGogDtaBpgr3Ub208fGk6xHxF3EY7QK+dMOdxUYccO7kVpLwCMw9ig8O8aMxb0104Qd22bf0GIn3tRgxrCIuJLrlGAt+Q4pW0klx36tYQ9y419hxYOiatx2MwkMQRwzfei6vO8X3auFJllpZC0udLj9L6dJ/yKwLFNH3n4Cu9ZSh6tq5UvRSNocygUOC4gzkDpKxwqzoXqTbSOY9CPiw307LFzwDgnYirCHKzSz0oI+wgyU+XvTwbblxp6158NpO1S8c/cGOCxbcT2smsSdVAuj2ntvbjgIWEBYKH4FA30NLvMesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OntFOxf1TxmbiDuVrye9Ym1WvGwqUVZYUQu4xdbJkA=;
 b=M1XcrsInejGVgKP0DbzBqb7xUO7CvKovvRxMHsslOekkh8s91Aj05c60b0l6FjiLWMw/3sQ5ugStsZQSCG4V8iB0uD4kZCRu+izGx0kMl0+TutUcaJU7JnCVa06or/9DgYPnXDYJPMPLoktQaiNkPZMT7Ibr5JsrXcHns0xZnsIzPytgfJ1z2cTc3xOMDNOzfd4Yy10sIqpbZuBSASmuymUTn0TzlU/4ktezlJXWfGi+NONHFBYWWKREn+lXwsY7Q9L72dXwxim0ADd3ukFrMD4dn+zClVRxgnngRAqMyMrEqBc7b7dMn59g+0PKLVXkErn/jkTU024yLa3OTKPxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OntFOxf1TxmbiDuVrye9Ym1WvGwqUVZYUQu4xdbJkA=;
 b=xZs/JD6To+XxAEwq7xZqrS7qzeDhRdr7/z81RzxsaFrEHOGRJTc3OqlYb7bfh9MpYud813epIscIGVxzZnbgKiNQRK18eRdXBPFikazMW199XcAnSqheBZbOsfzm/MfcepxOrloBkcovy7DtjsnouqiA6F7yi6lEQ1D6+JoZ/BM=
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:57:33 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::c0) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 08:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 08:57:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 02:57:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 02:57:32 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 3 Feb 2026 02:57:26 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse.Zhang <Jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/sdma_v5_0: Update per-queue reset fw version
 checks for 5.0.x ASICs
Date: Tue, 3 Feb 2026 16:56:12 +0800
Message-ID: <20260203085706.450079-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203085706.450079-1-Jesse.Zhang@amd.com>
References: <20260203085706.450079-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f97e8d8-e94d-4f33-e7a5-08de630244f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1+9oi1xoGNY7sj+VJbKNkQM7zbDICKBYIQBSCQCTbfumFsWCBK9K5joIdckA?=
 =?us-ascii?Q?BZ0R4UvOY/MzdZo1FZ6MY0pBOk7uJleUlTJungU/gpxNXhdIYqtI0qEvaNFd?=
 =?us-ascii?Q?RUMFQG2ca5qqWmoCTSFEQDFq8pDvDFajcsTYfnls2/+PUM2fbMvLxfDAJkyX?=
 =?us-ascii?Q?mZEpT62cAGg+PROIkcoXxffRUu7f2nfaekq0V84h/RM87wEych0ONaQbtx2t?=
 =?us-ascii?Q?5VxiLGbApnDyHvoT6fUozKb5w2KIjdn+7cCiw3SKC4UXHX6S33BHKeAbyyz8?=
 =?us-ascii?Q?TQtvn8v7iOZT/SE0be0mMVfDcwX/b4xuq2sg9a5ubjf6WX0NoPNE+FeMlUQU?=
 =?us-ascii?Q?AnlUIKdw49t6DJtjjQG1zF7cXJ8K0vLW1WXjRZ0kYgiHHIy/9nAdPjZRmsW8?=
 =?us-ascii?Q?oDoFVIwiYZ49wwz0I2TGGRKfieO8h0NjHW2rmRFCf5lSBh9NzT1/F92+l/du?=
 =?us-ascii?Q?9RrFomUCUbO0I+7rNy7vWildr3LwkohHl6AyyYXHYwv0wv6WaL75wz6Ym5uP?=
 =?us-ascii?Q?uUrdN01sif6Um4gUoEQxy+NEu3xHr1UtBaYVhnqs7jYGQVKVkBwDL4IK//wy?=
 =?us-ascii?Q?K5a7qkatFOMbmfaGIaXBpaU987FXoeVgxLxIsO2qpJbBFeE30H/68gUU2xUG?=
 =?us-ascii?Q?HC4FIfWjaCb1+1oEIhuaKYEpOGanCpF1UfD++Ca61sONYKDEW9ztHIoj7R5V?=
 =?us-ascii?Q?ghChnBNByU8s4JbGD2amuYapQOMntc+vUQRdm4WVZfy4vH50dO7wpEY3gvG9?=
 =?us-ascii?Q?01/kJJonbOJd71HsvvS+ZBKQaHgV81r+XK8aWJ86EfbRFggzKkrl5WTgvoIg?=
 =?us-ascii?Q?5QXo+qKMZV3xcVY4HTQglo4VPZ4o57i6zgkY0OWWzmp8axoxrAruSUaBdDhb?=
 =?us-ascii?Q?HErQZFhZ28CGs/eYC/Tpg01+79CuAhSG1tJHRoGK2gJZ2qRQFkNIsnER5YE4?=
 =?us-ascii?Q?KjR9mMUZ9lCBXeDATKJ/N4TUWdmv1IyNsOQj9lQB1MNNa2USgXmWXvMAINnk?=
 =?us-ascii?Q?sXCzgtd+WeHnP0vDHrs5ntq/RVRbIEaHI6/NvO8tGc/GpgXXEBYecTVF4JFP?=
 =?us-ascii?Q?2gkw/zONzxabPTkENNgcdJd1u61pQAe4jYkSmgomttsEYtBz4nCSgLeKDLVZ?=
 =?us-ascii?Q?Uwia6A0GLc3bVggElOt3XPi26o9T/aWQdLLMxiK8NN6+CgcFTCz0hylq60Z8?=
 =?us-ascii?Q?bmYerHbrjHPG36wK6pS2PGgECJCTeOgxOUxPxQN4Yl0RQAtrPuwJC6SXItUL?=
 =?us-ascii?Q?o9LBobTJwlnOG+BACxlG8d4/BhIOoxpbCFUEk/im9/EzRBi/EwBK7u8MkBzK?=
 =?us-ascii?Q?7v/CcHGxABnYF46q7Ll1mSZnYTPP2y6A+5qcx4Ab1+3iuNf/sPrwVKbGWpzf?=
 =?us-ascii?Q?l488liAlN4qUKN7H8yfWpgJJllvWsIlBejfCeAhDwxDRcOuHyl+l03nZBmFL?=
 =?us-ascii?Q?06BoKA2W5/1EF7xTw3p/zF8eZsh7n8EagDAFyoW57rO6dy4n/7MMZWHfZZ+8?=
 =?us-ascii?Q?/W81xKwxbT+39xq01xvGaFlcBkwnF0mYsNMAIsNy9PXYV1aMoeL/uoKWBCbP?=
 =?us-ascii?Q?Da9qbT6TMcUP5r1iJCEYWueMZAHrbvSuAmcjRexWGnZqciwfa8UXQvW+qedv?=
 =?us-ascii?Q?zHKdK9hRtgahpM/QCpfroCDsKnCRVvSVJFePU0AEbJSqS4ozsbQuhj/zUKGU?=
 =?us-ascii?Q?JsKf4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLpXwELj7V4FS73Vxl3tgupOlltuGybidfjnIHnWcsaZWUAiNal4qsczMjtMgmJPcU1VPnF7xuLmJSkRs2tzHCyeppPmNY/cnzJQGljuUAdGbMbIDUxcdGJhF5EUC5I4FrdUD8J4ddLUz1S7yfw48qYB8U4ACY7RV/0xhazv1eAr/xQaGrteUqeSI0iChkRLMW1k2xxO4of5vqLG8zDZJXTaQxzHgph0Mvq8t74mKa8gnFaQG6yEJZ0fdjNMvHPgm1tC4DqfrydOEPDahlKEWGGtPZ+PPTX0zbLcp2I0RNZdpK+UpZja1c6kjh8uRdhQ2fWNmAdSEW7q4S7RanqzQoBT5wRqdrt2zfsFlytmg7t0uaeZFAvtwZWiU160pPehHYmOHH3j1h5rHp2uLtxOBxxcgJ7VLtxfT1GFRAHFWNT6mB2VNorY7r51WeKVbJqI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:57:33.0943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f97e8d8-e94d-4f33-e7a5-08de630244f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
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

Tune SDMA 5.0.x per-queue reset firmware version thresholds for specific ASICs:
5.0.0: Require fw >=24
5.0.2: Adjust fw threshold to >=30 
5.0.1: Add new check with fw >=38

Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d72bd3adfccf..72492692f680 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1432,17 +1432,32 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(5, 0, 0):
+		if ((adev->sdma.instance[0].fw_version >= 24) &&
+		     !amdgpu_sriov_vf(adev) &&
+	             !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			break;
+	case IP_VERSION(5, 0, 1):
+		if ((adev->sdma.instance[0].fw_version >= 38) &&
+		     !amdgpu_sriov_vf(adev) &&
+	             !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			break;
 	case IP_VERSION(5, 0, 2):
+		if ((adev->sdma.instance[0].fw_version >= 30) &&
+	             !amdgpu_sriov_vf(adev) &&
+	             !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			break;
 	case IP_VERSION(5, 0, 5):
 		if ((adev->sdma.instance[0].fw_version >= 35) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
+		     !amdgpu_sriov_vf(adev) &&
+	             !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
+			break;
 	default:
 		break;
 	}
-
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
-- 
2.49.0

