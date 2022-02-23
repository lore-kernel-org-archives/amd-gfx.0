Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB99EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 05:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1494210E2BB;
	Wed, 23 Feb 2022 05:27:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C5510E2BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 05:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7d0zMEecuSYwK43ZwgEFQR0UlXYFkAdiooRliR3j14RTNCf8KyUab8ep8JnCiFBX5agCwY9KwRDgEBTj5W6adLC2B1AEpfKsJSKmN5Ppsqz2gO53W340FII54/fkRkxwzAozDg9BrhEYrGDyHpfIZ9Sk/8izfwvwhJBiS/ABY4giwEvTPW+E3D7147Uk1+UYzSIu4/3p82fw+o7iUCUsO66CEBGkYy0jPvHzvVQpbVItDqpgk1z+5NlVmwdsPdhD5wvdzZnjfsToQFQf6EbvofhYv9BCWA7YMOtBVlf4vn0j5M/T+UwLcS/OfPX9JVNlBUvRhOGYufVQutC+jks8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rORxtgsY7prRt/kU544vkC0b4yre+IpYF/oIoz0QKtk=;
 b=fVPEr0PwxiA8GFVtb+GkA/Ktr8HEA5Xn2ljM6spP1CFyumySlwaRBqbve8bIBLsAh5E7Ud2srPtSeQer0oDnxgSuAG4+Iwlx1eySsfgd+a4ZbCWBO5I7UTbRI1A1RP4lxik/pmc/W9HuQi60990Djx8IlfuctwFBqdknKccC4Dkre55hHMgSR+oPWywjZz5tP1eVuZTM0hq5ZpR3rcpyeJmr1nZR9D6G/swZAkpKTWzUh/TTuUTimBh9PgtgMTPFRMes7AlzyxiaJiSAegitQqlIwrTQ0ZqjwXCE58uvcgQYI7TabsvcZOUCQSS9hif2lEo7VwnqZBm4XLGL13p7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rORxtgsY7prRt/kU544vkC0b4yre+IpYF/oIoz0QKtk=;
 b=gNKPquAawPGFvc1APfQgiHzHGCvGkXdTeCsBomhte3CeXhRf/GlQGinuefLtiDd+YEHwy4cGcTGtmfsEN16Y8wx6q6X4heUFwX2/lDEc2w+NMoSAoJkp2H0/AiGujtCqkMDH0UD3jaxiqvSJ/ez+HUGYeD3mbMHcrNUzrBBZ3PI=
Received: from CO1PR15CA0057.namprd15.prod.outlook.com (2603:10b6:101:1f::25)
 by CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Wed, 23 Feb
 2022 05:27:32 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::8b) by CO1PR15CA0057.outlook.office365.com
 (2603:10b6:101:1f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 23 Feb 2022 05:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 05:27:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 23:27:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix missing prototype warning
Date: Wed, 23 Feb 2022 10:57:11 +0530
Message-ID: <20220223052711.621708-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6857000c-7e7f-4460-1ccd-08d9f68d30a7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1653456B2F8FCC3553DD0BD9973C9@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjgkhA0bfya1zqFJogcsl279WLjb2bCrYM6hiOAoBln99hR1IOyfX6rX5+Kxxu9tnAAVxMPW5runk5essJdBoASE6aAyF+zUILY/GGBgKeO5ZJKYltttToQZgNVzDgEdfMI1pMqXn2qnn2iCYwc9z+B5BwitEtoC7jCXFAsE8dhOHV0F4vkvcWLIZI1DLBCB0Ynco+cPJsMN+0GcvWaU0sXvNrQV4moQF4+t3vL5wI6IM5m1umU0YW6N9kd9h77xKUwUX8840G7ff8BfGlDANfZQOkyuGS2EIkUxzwK4i6nCSUrFHE9pzHu6Hc2XdcZTU+lzRzyVUf3wckjKp5hJ20rsMj41kuRTzH8IyWrtze4nnOkESEvgZta938HXGCbk4IlRPAXRqOzQ+vVYkqxJ33jERaD64m994bZujR2vMqAAS4xch9HXh6j2ELVzfwv9s6+tb3x162OeAnSBQxjzBF/hRJi6939c0zoaYUdcVPgvz/j2lQqSEfXPu+WhNupGkn2C9jByUy7+BwWhWzFb+WpaAFAmCy3MyP5SnVDM1AJ0V7ismFnd3duy+eDnNMh56PiHJxW++NiK4d5W3mtw4R7k5BT7tc1UwifDfjxGfz/vcr5zcgcdJg2MKWtlNETmH74NXH6hUe+SCcnpDNczs3jLdinzouB6jrQy4AE5MGQvQAAb/v2ZnpeL/Jtw+ufprE6rrncJJrIhnSzxvDMwBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(36756003)(8676002)(5660300002)(426003)(2616005)(1076003)(86362001)(26005)(16526019)(2906002)(4326008)(6666004)(70586007)(508600001)(82310400004)(7696005)(44832011)(4744005)(81166007)(70206006)(356005)(8936002)(186003)(83380400001)(47076005)(6916009)(316002)(36860700001)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 05:27:31.4684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6857000c-7e7f-4460-1ccd-08d9f68d30a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
Cc: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 kernel test robot <lkp@intel.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below warning
warning: no previous prototype for '__smu_get_enabled_features' [-Wmissing-prototypes]

Fixes: 716622108a9f("drm/amd/pm: validate SMU feature enable message for getting feature enabled mask")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 1bd6edf2be41..590a6ed12d54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -523,7 +523,7 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 	return test_bit(feature_id, feature->supported);
 }
 
-int __smu_get_enabled_features(struct smu_context *smu,
+static int __smu_get_enabled_features(struct smu_context *smu,
 			       uint64_t *enabled_features)
 {
 	return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_features);
-- 
2.25.1

