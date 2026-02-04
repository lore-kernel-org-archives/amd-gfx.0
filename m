Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8CEE83EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 07:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAF010E444;
	Wed,  4 Feb 2026 07:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqTOoJvU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B624910E444
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 07:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5di956LN/gVY7cQeeTiKr41wEz17dNADiYYpydjUqk34Jhoyx5R8hCo4nxHL4548dRjXiKtix1Xjaar0+01M2YG9GgPhGL650Cqahw4iRQc2TSYYaisKOouT+8t55HAawL3DSLBcPdHM2LFPEXMcHsDeNSnLxgX6yVyh1l2O/hcGoeMdZkG7S3Mgzr+/4B2rXrPh3hfxO45IqMs1G+PaHSdYVVXjbYrThPq/9rSM3mn2/g05u18KBpOOXGLOTabPu758Srqr+JbOd04JF3kQ97f79k4tpYbAVmE+GlvXDqb4lEWU2F/z/TpLs7v71ANT/CRlsn3qvxwGTIwEURt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY34pOHLl9c1zIX8tB+2Ra1WugtJCso05vbixZwX4aU=;
 b=Een3ki/2HrRJ1JzIzLRLRAYwmTFLIR5AWA7iow0dE/8jibMH938Z73Y2T/PZB4gQbqozcKuMDqEOesFSlMLqfS2sfSrzjUmYrz8CHbUhbnFyI38FXS1+CigWDJaJtiPRYC7Av6rXQY6E/mdLrDFb22PGZUKVPEyQZkj8ZpwYmjTzCKdX60eeZt0OeRnJvLAuvtwloNwvoGkDTooJVKMIVFHTcHcqO5ADpyapjpl6Ins6nJ14EWzc5mZVfCGTFMmzfN1MNiigd7GWQi/0zaDS7TdTTsogFwq/1MzWLlVIHIsmyq3QgeFEY++CUgOHr3p04zG1KDHUWk65rOfWl7lsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY34pOHLl9c1zIX8tB+2Ra1WugtJCso05vbixZwX4aU=;
 b=bqTOoJvUyK6pvGGWV5Xytv3jhcsXbIzy6ViB9Jo197502+NbQjVIPb+bFR66wKsJ3R/T106hcKqzwmsXx7fL/puQ3JdQZRpizipvlPy/DrqHXdd/RvWO2nI4AixLZijCsZTRukCgIh2Jm85Q0wRvgXY5Jxj5lvopNWcmAtBIbCo=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by LV0PR12MB999093.namprd12.prod.outlook.com (2603:10b6:408:32e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 07:56:59 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::5d) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 07:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 07:56:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 01:56:57 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use correct check to skip setting in multi-vf
Date: Wed, 4 Feb 2026 15:56:38 +0800
Message-ID: <20260204075638.3797505-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|LV0PR12MB999093:EE_
X-MS-Office365-Filtering-Correlation-Id: 755c6bd1-9920-441c-6fda-08de63c2f97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QIk8r+RbfX6ARCqDjxpZ3VHcwRt3IBghRNlxnrmo8FSjgcKhlaJkoW7C3ZSW?=
 =?us-ascii?Q?j1QhSontO/JDva8Q+4tGDVkfGg4EtS6aKFLtcJcqBc4Uo28Eh8ityEZd3SpR?=
 =?us-ascii?Q?c4zhLOdZaTbyB0CWZamvFLT8ejRSfkRD7G0Z7rxnioXRgxg0BhWscR/FvuHv?=
 =?us-ascii?Q?DgtAObKGGCKRdISJ0OO4ifw5avoNK6RXjg8yGvClFPEMjlWeMHiv/iYCpY2L?=
 =?us-ascii?Q?JFOj7IsIMTgE/QJj08mR4rmfps4gKJ6mQhZBdKM+stU6GAx/sRDOeZ8ErqyV?=
 =?us-ascii?Q?XiCdwrmzhJNWsKGgVjXnoBbfNOB/8AVpiRuXZvNck7H15U0fogEOVaa7FxHn?=
 =?us-ascii?Q?ErbkyGOyz1A3CwK0zYYONSKZIGBH0djWLlFKxBiYyQrwpolnE9763e7hS0Om?=
 =?us-ascii?Q?4d/TKvG/Yo/lyBeOA4lJ6gKc9y3UEEn1jARzRXqZNjP9VBkb9muLHtuq3Uzm?=
 =?us-ascii?Q?apNKwc01TrAaddtlY7PuqUmZyCuci6u16vr+bpBy57hrPrFYVIFFPRIuVRis?=
 =?us-ascii?Q?ues0EZZZfNSurR/DRcsDNmZ290rkBeOVaogBklrXmJJtN9LoktyyXsybpxX3?=
 =?us-ascii?Q?CmmgNfm2wDIS+yxVeAd3A8mj43cxxjpNtgvwGNC1EZMV+CX2kVF/zmxicCwH?=
 =?us-ascii?Q?Pd5BryQTRFZRqWxM6RakR5ltUQQ2gI6+ILBuyYIp670tpKsM0nrJc3h7a1DA?=
 =?us-ascii?Q?vpjFQ58hN1oVS9FlQTutSOT9wSYgLJKvQ3NjmMDXM0XJGIWhcBXLKc++zQjt?=
 =?us-ascii?Q?Imu+Hjn6ISmpawzK+L+fk+dC2mACfg5VhyhTEzQNXEpDzTx0orWtR+pkZ4IY?=
 =?us-ascii?Q?6zDekSMA5R+RB/VxwzIAlZw/g9iKEo7IAHIZiBcYpfUiAkoZcfGWl5+jCzVT?=
 =?us-ascii?Q?PiD3D8MVFes2jPWwS/UTU+Rpz/75r76HEPdxRSbGcMnsh5x9XyKurrtbuj1x?=
 =?us-ascii?Q?/mKz/3qBJHzA1CbnsRdTHir7muj36ypKmGDTv3YArFSLDWVmRaGWFkpZ4g8S?=
 =?us-ascii?Q?I3uVrqX4d+gSLdgmgTFn7UuE47yF1kQ4uC8UNY8KLrcq2q7xGV/yRCN97kox?=
 =?us-ascii?Q?9Givd98qO3bPsukAfB6ujAVSrstV31SSP7+OA+zwm9IpnUZUR1vNYYGQkyUK?=
 =?us-ascii?Q?RgX0xDsSPxdwwNLGrYLQIXHWGtgVZRl+d9GmwDRQ/yiV2vd2MORe35+ez2M/?=
 =?us-ascii?Q?b4XnZG5hkKsndV4/4U1WtI3gPWynuK69cpSNkDCAfK/N/VBDqzCNwoaNworb?=
 =?us-ascii?Q?CgpIYoQIyiu9njulI+XdXnyT+QSUvP6kbjeqgZwbnagupEtaJCVt7UakRYbW?=
 =?us-ascii?Q?1006CakA9ZuID14zTmTdpIee3OY3hbqdBPkWKv4tTyaDHWAV9NoIyb9bpfAa?=
 =?us-ascii?Q?SkGiz2R48QL501behlmJzjmFEOTOq862R69xODPFZKMxXn0g8Ua5NkdnxMft?=
 =?us-ascii?Q?Se1R5lawLnh3WGIsLiSpE5xyUvSq3yeRK5B7udbmI6WJbCrNdBtB0s65d5rU?=
 =?us-ascii?Q?+CFnufZAfi2v0d3JTjfQ+Ngw/1YswVbfWrn6yX1mG1KZal9SX3mTMTk4qJXf?=
 =?us-ascii?Q?MD1XNF+faJWEsNiNgzdrIT+BmHz9QH7CM2hkvh9xUk8T3azWiLpsi8rw2G/x?=
 =?us-ascii?Q?qpu6BZNqctr9NkD0vy4KyALn6CK3JaHCUr5srQCRdZsFAheHQtrIVsVMN+M/?=
 =?us-ascii?Q?uXYHPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J2RAODyTZVfIhH8R2yyHnHqKyeqZka0n94PWuEdqML2nphS+vj51FQ3opt4qTvvdFZYeHWXroi9NjDA3CyHIm9OlAAL/Qs7fzqSRUSicohvaLWycFNKVmNaMXT7tMl8UdXekTJmsFKmFg3zqKJ/XzJMziSWyQxz00zQlkc7lMfPzuwZg16AOdNJPhKv/Lv+VITIJvgSCEeUT4A6uHPu0WfqaCR//fLYH7RpH1THfzkdWxzKa2vZqppU/kcY47/k1v3MKDb7KvAKiQtEQJZgbXpOQsLohTnZlOtyuUs7c8L8THe6DWsu3Ucj+25UxS337ND32nHfIz2YcFE/QlL7E3VOOdNuCWoPoDXMEiVjDjjybnLKPoAZx4QoMe7GW01VtMnHxrn3RA+6lrWx9C9lKwiuZn/RQ+DIE6m/P6c0YxIzgX038KGzngLjKh2rHum+q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:56:59.3183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755c6bd1-9920-441c-6fda-08de63c2f97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999093
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

Use correct check to prevent pp clock setting in multi-vf mode

Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute nodes update cb")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 07641c9413d2..6dac116eb492 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2058,7 +2058,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	}
 
 	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_multi_vf_mode(adev)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
-- 
2.46.0

