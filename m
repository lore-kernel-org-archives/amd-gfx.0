Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11ACC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 06:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8EE61422
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 06:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8EE61422
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F1C6E06D;
	Thu, 13 May 2021 06:41:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C03F6E06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 06:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo5zkLQaLBTTl4IrCqRhp2RFfuLUdngIpD5DWzOpEMwTjO8KK/XRuIKsckRrHcfOE6pd5j4+rEFQEUXb9lhsM6WPqV+9sLyH7XMHFJmrB2t1BdoBBHLp/yO0iZqKKjSsUmI59WwEAaKrve7B+lsz4u/UbjkkBCtBEeugx9F9TWXn8xfDcXuDx0AVW3xXKE8j2H6PJstHgqAQLYpMWr2xvvkCxpxm08jjXMwAw7ruMI8mKrPzzB+DzF7t74Prn4XCxyZ7AK8ArVU5TEyIdZrggaNb0pUPY6oTZH0symQz2/FlyysOVhPOQ12r1nT3ByfakLaLIrRiWQEl756jRzd1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrw7V17YrUdcwVrPkHHq9wStX+e2TN46R2VG87ihRwE=;
 b=FYF0AuOGT8EGTyFkbgSRQbbr8/HBYshHv4txu1ePFUfMRqPQGPbDvWvwlGQSYaP/IzoY0uKEZjodhE3YhtD3yj5NSe0Bjz9+nLv0ftzFaiuskCFCJ55mPKmRDppUxRBDBqxgMxnuBwcYTV+9l6/pl9B2hHGijTmhfRUAPj+zZucuPVZNxodwzMT6TdtZTcJ/YteMWFt216U8EN/oy/K8vXweEK6anRoa60Ln/58yr5gTlo0TFIFavd/xd20Mk8F8/10rI0YW/GjZZO/KSF0rs8C9us33RlzyZAeCaxlQPU4U3PW69O6vX+FFgdtwej6UzfHLHoDbu0iGUOcaGicBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrw7V17YrUdcwVrPkHHq9wStX+e2TN46R2VG87ihRwE=;
 b=p/MZJATAKYyp8BrUoEk9hsMtpd3d1OWfyXYUytQdz4cJtnCl6SPR/BAYGpz/yJO3bb9st9ftHVdleO66xEfHCogcIkcCMmvVYWj3/83YOwtr074Y/Vh9LRt56MhP3PRXU1QXsMMhTy1qywDEcOLlfAzR08kkOIi9KRIed14gh6k=
Received: from MWHPR15CA0033.namprd15.prod.outlook.com (2603:10b6:300:ad::19)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 13 May
 2021 06:41:08 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::9d) by MWHPR15CA0033.outlook.office365.com
 (2603:10b6:300:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 06:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 06:41:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 13 May
 2021 01:41:07 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 13 May 2021 01:41:06 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Date: Thu, 13 May 2021 14:40:51 +0800
Message-ID: <20210513064051.12930-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb50fc8-2f8a-464b-398f-08d915da1728
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1881EB480D45655011F99BE9F8519@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/R/gDjwSKAxbBHID/4y4T/rQpK3qX3JzzQJ5F/+Bq3rjf/euNdgyCL66HFkaaQUProLF5zILQhFkAcaeEp3BHt6v/HaFzQI20sdcy/JexHadPhhg1PKS6/tqNIEdMhsQklJSo4rF4PWL9kYpYK9UuwnDG3vPAgZF+QG7ha197M/cQCcYLarfYF/WrEVlX77agxlKU3xUKqTSzKnDOK8cF7D6peWOYz+/cTHSabQeMKZpwb6962xfdk3ki7vVeHh4TWHmWJ1rFPih1VzpWt83gHY07NZuLz5UdiCaaXN0iPMZuVj43u+ifzIZAO96BoEjCIjVIQJlYyIlre9oN0nnRl616hJLrmuepGRRYLu/5t1Cxl1ow/pS9Y5vOpVDwX7iI4jPc3JfWbQFcWzdwVhzq0jISB55tB3AJYcFqxDRZcXB7cpQf8mn7e9lTxiqsjGebqzw0HQ1Y1NCzqJyGMQeDvAU+zT76IyaF+DF2LzbWCzfDi1xd7cTyPK5moFs/pPBH2NGKY4Ry/kiF4VRSsaWRCalOLQq5z1vdBM0+frNgPiChJgRenp3P7P1g+UgptQQ0p+cfBQ7vKm9RXSVhrNSnjH959YBYtHiPPiFHSQI/vTDBrxYD5qfBezZlqY0vjEWI9XJEY0UuJoJ60Jl+hxEIjMtAtfcNqi/iQcGjnSHLf4lwEmEuHhPfmdZ3RuWvH+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(81166007)(82740400003)(86362001)(70206006)(54906003)(336012)(4744005)(5660300002)(6666004)(6916009)(8936002)(8676002)(4326008)(47076005)(426003)(2906002)(70586007)(1076003)(82310400003)(36756003)(478600001)(356005)(7696005)(26005)(36860700001)(83380400001)(316002)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 06:41:08.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb50fc8-2f8a-464b-398f-08d915da1728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize unique_id from PF2VF under virtualization.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..96e269cbe326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
+		adev->unique_id =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
