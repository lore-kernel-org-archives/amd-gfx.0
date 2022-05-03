Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB21310F537;
	Tue,  3 May 2022 20:51:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160D110F48F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbNF/Ee+qWwE+49gVSrWp01bxnZaQsRhyo5HnFBVICuD/hNtnj2F3xcb/GC0OmY4EIIWKaNx6qWT1U4+NMX6Bj83u5RRAlMMezKGb7/y4xyPS8AxUgKJTxOm333i8qarb2YFzunbsDyvAkJfYBpqNU2PtIJq5+ewNsS/Z85xDuDAUyoNcOfxiESbpDOaxd39wj/OVJOoL7jiUuddAO7pxYzOCcpjBsm44i/ihRGVI+tzKREn/56fmeFz76TaW6jq3sDwhTNqL/xpVQjWuZlTc3HemZWAkM3mqRHD1w9QpZIAB9sLNeDt33Ofq3eau9E2ib7tmXa2W1d9LKs6jshkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p+a09fpiCRlZDzDpc1dMDV7jjYWKG4jZOXXkvcCaGE=;
 b=BcXQgUxdsD8/t0VL7eOsMpZ5Q9e3jPmoEj1FZdOse9XbqDrSiavznuTBzc+eSd0Y7Wf2WBtTGLjp4Hp3k5opWXoa8sbJfjqpUDrvuGVHfN4e291W5ZCwt1k8Lv2B3brnnSh4TH85QkKYS4jmde1TpvpoUiQ2q9WoWo87XvVj4FAhkHxe+vKviKHtyGgbF8OYmB1CcvFz/mwlfHcWyRpyYCbcj2/iow+Kb4aIK7DW6NmHxikoA2dzu2dwiePfYlm3Kl5sCa96alUOul3WZ0hROhI2j2N+SNwJmfg1CZtuCO/5JqtLHa9bi/nqpQaclcIt+fMBKrVBL1t5pluQlIPp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p+a09fpiCRlZDzDpc1dMDV7jjYWKG4jZOXXkvcCaGE=;
 b=JXiwvhouzohvcOqYWDJ9+irC5qmJBwWcUnJP6MxdAm/DW3Nf6rK7IIUNCTQt47lG4p30alkiaTaMeDSVXK+f69WuR93yYBLQzZyMVbLjnWnZKk64dnwmQ1pwD6npI6ETxJpKaNWX5XR3uBthdjCVeWh86F/HohXpbwFiMzizLZY=
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:51:25 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f8) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:51:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add soc21 common ip block support for GC 11.0.1
Date: Tue, 3 May 2022 16:50:56 -0400
Message-ID: <20220503205112.1285958-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad338df-80c4-483f-32d8-08da2d46b01b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4937:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4937069B5B420C6128BF7BD9F7C09@CH2PR12MB4937.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyWVX2d5ycPSCfxs/auS+jmehAV5mvOWQE6JawfOwC1mqbVsb2/tJPpQ+b4k42htppzpbXhqkxQpVmuWghPiq+a/0C4jClENlDerP5jzeIOJLhfsyRjA+i3F3/da6948xCX5QICb8kcTtZhfpXBDkjwqx/QCUrwWvSIeXR6SYc+9OUOnahhTyMOawaJSJzEvwsqdLYYrphtaS62GYX1i6Pul/wgkEntoHmxT2MHV5EC365R2l4F62WYffgp4JSRGBevEf6Isbhp6/lpjOxq7LH5qm/xcuUmXSun9NSrPqUHivfce2iKK1TZHHZtaAuBNaEPXoHP1D/UN1CeP4hNRQUwnENXQj0xzfGVXfdwWM3umrlq2o2ZSCDohhsMUrS8a6GAeS2fsIBipHqz+7XSElZ0dKu3fhkjTtKVbS1TkTqagzXBQCSBJAugbq5uF4uDgxA63pyMLb+1lDn/JUh0VXE5OeBWT/2cKiVlto0Ev1I4+ZbCWRmxQBqMiDPNLf7zcY5gfiE0TVJnIGa7c87oMSnLjm2xe81tkI/JvlGN3HczM4VendZhuTvuc1XpZcuhh9yPVt2R2KIafhPxl0cbp8MTb/3a+RclRLGtNx9MdEotaUcNwdAt3g5mBdjulpmd3Pd6FA0AfN/6mcP7/few+Y6jdQ64SRFHGmR84a82wZ26Ho99A/NlPp8VZke06fqOToIMwTjbuSo2nrTzW899ddg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(508600001)(82310400005)(40460700003)(8676002)(2616005)(426003)(336012)(1076003)(26005)(47076005)(356005)(81166007)(6666004)(2906002)(70206006)(186003)(7696005)(316002)(36860700001)(16526019)(36756003)(5660300002)(4744005)(70586007)(54906003)(8936002)(4326008)(83380400001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:25.0785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad338df-80c4-483f-32d8-08da2d46b01b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add common soc21 ip block support for GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9424020c0634..cfe5d12b180b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -564,6 +564,11 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
+	case IP_VERSION(11, 0, 1):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x1;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.35.1

