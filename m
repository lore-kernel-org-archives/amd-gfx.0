Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E4FC77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863FF10E73D;
	Mon, 27 Mar 2023 19:46:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3E510E736
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciuUsUDONour13kGhGiy4Mnh8MdZaoMALhzRBN33dqcSeF78zywkD4qgLF4289ecrL+cYr5mDPN8zhFnWf2MIHu1RNC+k1XK7PvdhQ6zI6oXNGF4UsZFlctHoEtJnYydDsDGEireozF2dQ6kLcyqtqnkYRzVa0DEvQJ97hXw66KBSyX3vNgELl8s3kbRqwyf2/+pIssfEOFcQG5hNFACaDNlXQJ9oc58jY0CQiAG1+dbvmaXlkq/qm0HoR5U2Ve6E78bz9wUhoq22gzXI6O7IiPB4GhR4Egp6ol0zIDJR+l72VQrmRrxPXU1as5+Z4ZpV+jQuGG1VCykBfBVNCQs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC6nhulaaxw0bwHKk5BEdNx5z2YFnT4EWnDQXucZiKg=;
 b=SgadgppdnXTMDo5fFfVm2GqRO6agZyEEPrvMS/JY/PRCwGpiylioxtz3Cn3vtuMiSHBtroeqDsTi+LiAhID88lghlebA3KPRsUOzZihRYebtyD9sv4YIBenvwN+CplMofdnUCbotT7JtodzPH8aU9J8mLl/2V4qe5BYI5rISoerPzdCobMSViELoVyzg+MATrcDCZhEzI9FxUdCNlXxb5GTwk4culXB1Fj5v967begkNIkqrbHHfFNTFrIWHeBrRjAiGMy0EeY4NACNmaeBpmMHeLsyAulE2quYMTN/TNCUxbBhHv9jkUsoWCqmxMWNpkEj4iaeN3BWE4c5YKm9wSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC6nhulaaxw0bwHKk5BEdNx5z2YFnT4EWnDQXucZiKg=;
 b=aMRW2Db+sCGCTUReXSg+8XNiOehu7r47GpBoUEed5hVueXSBUtM9NHdYwL59W/qcLN5Ugb9/JgZKNm77ARArPMLFjlBG9mAEd40XQ8TDPQo9of7KoVm8XEuw5W7DZAYj+sUwzMxlK9CuvrtS3/XaI/mTxWn1xA2w0+7ycDPHukY=
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 27 Mar
 2023 19:46:43 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::1e) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu/vcn: enable vcn DPG mode for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:20 -0400
Message-ID: <20230327194622.8109-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a4822f-e42f-4d03-35b7-08db2efbfdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTbl0Nh7CjtyxNw6Pu0DGil05T+Fhhoe5IAIYxbhrQnmWIyUMYUIjJlbJlrOx5plIJqxEnM1vbRamhPX4CYZw+mdAwpvjN/mluJPXbwJBi91GPNhhA9kPclwaOSfuHTp0pPSBSgUuDomVLEAo+cG2XwDiWZK/ERIcjNZjQeWbp2tEm3dbMQ02ZLB8M2C4OmkFy/DJErr94yGJEZyPLjbfLa859mkAhlqdxCMog6GnhEoD/p+vjrKFEP8lvpIsdUfqHfeY2FSlD9mpLxaBYJ6V8KioGSFCuDCpSIQNK0GqIdnhRkWK4tB30L5APX4fvBR5I/7rO+MtRrnTJJ7Y5Xi6yyJ+fGwRtrv0MMdFMFvYdBQV0Z/+iY2pOW11mc5ACMXQ+z9T8h4V815U0y9b+YK2N+GJ9YImQAjdLdhPsxkrYQKP7FVGXZydsEu8TCWVEYPoMhXA3ddMrbhzHFRNYT/Kn5I6Nt/Cofcn5EqKFFcgOvK13veVA+MvwPFxSk8WMXgsfdHQJYHVNCZ3xl3NqFB7nA6xV5o8xO9UWXnwKYSKDBYdEmFhb7zrqCbxzW/97+NqOnnb//WHC90EdVNtDSl7CuIRdzH2ka91+yMQq8GpQusk7MDzpjVfqcMA0TmBY5Wn+q7/Q/DIvDSrPJz1C6u900Gf2phtC7wEv+ZCv6ZtOFtjTgcUoEQbShljf4JW4qv2Oxnomu6pgVS1g8+K7TF77BZJIa8VAmTze04gYsZHO4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(8676002)(36756003)(426003)(4326008)(1076003)(7696005)(6666004)(2616005)(40460700003)(186003)(478600001)(336012)(82310400005)(86362001)(26005)(8936002)(70206006)(54906003)(4744005)(40480700001)(316002)(356005)(41300700001)(70586007)(82740400003)(81166007)(2906002)(6916009)(5660300002)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:43.1636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a4822f-e42f-4d03-35b7-08db2efbfdc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn DPG mode for VCN4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 881e015881e9..81c2150eb374 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1108,6 +1108,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		break;
 	default:
-- 
2.39.2

