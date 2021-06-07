Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C2C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 12:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637006109F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 12:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637006109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081FB6E8A8;
	Mon,  7 Jun 2021 12:46:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FEF6E8A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 12:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO9cH0xS3WBvjBQNF0ofK8hlmEKrSbz1mpcbNZcSFxi1XQb/0qHMgwPx/fvCavMLF4OpNQEdI3m5Pd88OhLQTYcPZbP+CrCeCa6C+3aQuHKbKRmRQxwAi8yAqpUDh9HdnLepH73YIH4efy9rba6Dg2MpByxu+OabIJ8ZZOm8R5YaPaY9oNNzPROSY3PRJZ2tCMR2X4xoLHjZ0JA6XmGHCfWoVcFryMnH3Zgfw956IdYgpsONl9NL076vg9SEmrsTt9Va8f6NWnaud8rq6nO0Eu2+cfJGFE/9pZsu0D34OdyrkpzPdtDh4IWq6pO2GERNJjwq4p2aBO0u6LIUzvLuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AKUqEM0ETC/565IDGkUpIQmhtLhPvTNYKNEqQKiQ5I=;
 b=DTI8o7NOvWFTjr+9+uVLc/1EMyIYU2yyEFFL5JpxYmFpVKHuIwsUJIeswk9gXSORjdIq4uN437LO+gNn9r5L/KGnberCycd7qicsCoT04oWvEoHnvq3H21gcv4gQA5kg+HFNZwsN4qo8GQgG+nR5vzpu36C3u4qm4fIqm76l3BR/HBx57GvqubWAszwHrIY6VR6I0jVVvuQP+IxHM4+KJgZ909218KlGZLuDrnzWVyTPMeSTwlbhvSEyvxN/gZ6d1krVHUI8nzodPAwTaW11T9MMZrRGBrM1RfGUIxK9j5QtXEQSlP7cL8bwsOpDkQRrsJ+3Qm1PU0QvJslPqwmarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AKUqEM0ETC/565IDGkUpIQmhtLhPvTNYKNEqQKiQ5I=;
 b=YHMjClVsFOLIXhyZrUtV5376TgVAGsATvgTM4SuaNYJSt365teoAqGitj6j2Drk81ovR+UWATAEiqIsMTAYmENAbw1axLz1v6/L1mHman+n6KKibj+2KHTxa+RBMRCxsDJ4CKoR0cId4c5Rx4F5WV/P6lkeHs7Zc1I5ZsI+w898=
Received: from MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) by BN6PR12MB1395.namprd12.prod.outlook.com
 (2603:10b6:404:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 12:46:22 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::9) by MWHPR1701CA0009.outlook.office365.com
 (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 12:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 12:46:22 +0000
Received: from code-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 07:46:20 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix warning reported by kernel test robot
Date: Mon, 7 Jun 2021 20:45:49 +0800
Message-ID: <20210607124549.9061-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087862b9-5ee7-47fa-de0d-08d929b2414d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1395:
X-Microsoft-Antispam-PRVS: <BN6PR12MB139553D79C679C6EEA7FA3F49F389@BN6PR12MB1395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:41;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ly8RP/Hufwg+bhwrKXbsPx+9OYWTKmhy34Uu1347duigv8+sa3xagPxbnRUzLY8jv3wT/ez2U74EWOjKh65WJ1dK0NPRXvkx/OwkmYOoYu4Gv/YxE7Z/xEK3kGiMyR9vdHug9OozDaGg1zCbAyaDn16FzJt1rPpn9jdBWAoupC6N+OoH0WVmZ8kfocpWzErByFguD9ARMSWnPDcrecnOXuBQByaoIpFDgqrbg+C9multZYjVDDnJKBdLds+6cixEAuuGKUIMc1DFTIJbCxDwD1a009oxrKZhAmHUS97N8q7K/B3gZhFLM8arUcTugkCAAuoTZEy2CkZtRfAkHllDt2CSw6+FQuG7474/6eqAha6C/+zHLxrCt6uPo0qRa+Cxst8BOhr6gB3yJtOO2Bb09MfMpm/gBp6/6Mouq/OP92Oih8PEc6nN/G8pmEFmhukNgAqCLQgr6ylk6sLSszmSPuOqliNeNkp6BfnRhtlcZB9CtkmX1QnXJT6mQBiKP65WMBT3T3cycdnsPiANcxopWFPh1Ouh0tbqaMf39Bt3mMnizqpRZRihYLyOWSfq5jF18Jp0cu5+4LleANuDcZPFGJRqj5Hxir9LeAUKiIP39FwcQOaT2bODJRyrMjv2N0/s/YSXcvUNsHuEzDk2J/Z4VDkf6ZtK9hP7rnqadv43ILkEkVKp43s6AK0itgVja2S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(70206006)(5660300002)(70586007)(2906002)(7696005)(82740400003)(36756003)(8936002)(54906003)(16526019)(47076005)(6916009)(186003)(82310400003)(81166007)(426003)(86362001)(6666004)(356005)(316002)(336012)(478600001)(4326008)(83380400001)(26005)(36860700001)(1076003)(8676002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:46:22.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087862b9-5ee7-47fa-de0d-08d929b2414d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1395
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
Cc: Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel test robot throws warning ->

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:483:2:
   warning: variable 'member_type' is used uninitialized whenever switch
   default is taken [-Wsometimes-uninitialized]
       default:
       ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:487:47:
   note: uninitialized use occurs here
       return yellow_carp_get_smu_metrics_data(smu, member_type, value);
                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:465:2:
   note: variable 'member_type' is declared here
       MetricsMember_t member_type;
       ^
   1 warning generated.

Fix this warning by return errno when the clk type is unsupported.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 031c49fb4582..0cd7902d5172 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -728,7 +728,7 @@ static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
 		return smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_GetFclkFrequency, 0, value);
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	return yellow_carp_get_smu_metrics_data(smu, member_type, value);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
