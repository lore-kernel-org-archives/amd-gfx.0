Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B8C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F62F61249
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F62F61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492E06EA9A;
	Tue,  8 Jun 2021 04:35:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6E26EA9A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgUMdJycIiX8s8yHdym2ExNx/CgbVJXoyfCp8w7a1R6S8ohCS8/O4aULTBK6tzHWIYmhXaNclRDYTF5sy/Lq+6W5TXS0+b6C/39xj3+Lh4PhkQb3mnAeq/Vm/Uf1F3h+7UCQ04QNRSCB4UlxEFX+y5zAWGH06Oo41Nkh9ALrYglP7HeXLY84bziiUuc0gA7NC0T0ZAuP3AFg03HQfEvND4Yucmm0ln+QpDgotDTLObenC0prM6VexQx+oPYD6JnD3al2vjHxV7WPsK3LfuqiEZieOlc0s+n4yZFco7/dq3UG0UY1DGL9zcbihzjCBalVyDXeG/FqCENXswT6VpFDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4I1LJMKgSIzNcR6qI+YbT3hu0hiJRUAGVVqJISAZNo=;
 b=UZtYbTpUh5J3h7PYCVuAQBwoCUPqLMDBpRhIV+r4NgsyaQS1q2lWWJ3dMENWUFUr2ipur+mwIi8wlXxTzoK+pnwh/by7GwPOsol/8O4pZTw7i6LZBKLC4bhwJGKKUa9WY/WsNJtJAtWQHun7tJBIpCJBmjiU3PTCCxUAA08OqIsWDt18a8jCZXY/y1NV5ZgoUfE/hXVau+rObpst56cXoOKW02dx4g6CKEudQwP1mOa+ghP/o5qZgrwIpXsBP24v3ySsviwIWz56ER01CLoQvAHP+60WRBZzwHpFmYVN8hxq2kIaQUQtwSJm7qdGFH0JnwQbs0wZWdO797+xWJSNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4I1LJMKgSIzNcR6qI+YbT3hu0hiJRUAGVVqJISAZNo=;
 b=Yz48Gg+UiLPR+uen7oORQivXATA4FmUtJpekd/SSm73NVpzX49S+GuJ4P+85CpjJ4A4AfIEJw86mBZkGWupUR/SW5CXC7Y2t+umeDPvDkV/lpGJh/5MPZr83P3faUGz0DKiwO/Fpa2rTfPrBBi3Qrs/IeJfdsatnMxe1B5W8wwM=
Received: from BN9PR03CA0280.namprd03.prod.outlook.com (2603:10b6:408:f5::15)
 by BN8PR12MB3009.namprd12.prod.outlook.com (2603:10b6:408:42::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 04:35:03 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::23) by BN9PR03CA0280.outlook.office365.com
 (2603:10b6:408:f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 04:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 04:35:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 23:35:00 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 5/5] drm/amd/pm: correct the dpm features disablement for
 Navi1x
Date: Tue, 8 Jun 2021 12:34:31 +0800
Message-ID: <20210608043431.1855151-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210608043431.1855151-1-evan.quan@amd.com>
References: <20210608043431.1855151-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5400a0b-ca4a-4464-6e39-08d92a36c834
X-MS-TrafficTypeDiagnostic: BN8PR12MB3009:
X-Microsoft-Antispam-PRVS: <BN8PR12MB300901719EECCC147AAEF697E4379@BN8PR12MB3009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Jpke6YvfRhofX2tJZ1TQK6v/+fFYimUtus042/LwY8v4AiNqpqz0hosYkjbegTcq4kBX4ym+cVXcqkbORTVhxo7qP95FOYVInVr9DFI5s+3AXocYrtH8SqdCzTEqvjTK26/GRRaInd6L8AbUHORQ6CK21FBeKjPe/rgfhjmfBiJ0jlHUOOul+czvnvfaA0ykRa8bJOqTtZw907JjRXbExrQxkZWGqTsdDNYwrPMJv49wrMOxNHOjIjziih/L80yHyPAn9FpartioZSNcCEp1NrKkCQ0rEtBjJA56Ys3WkVLqzXZcdbYUpAJP6lhQj7jA7rjq3BENM3j9f1AoNvyoYRN59qfyqTanv61sBKcOKs+XMeS8l6Ejp6cfe9tP5H/GC72MTBp/Vwc8Z82W1RMEGrB+9S1a7W73ZIKFCalWnKfqXDmA0UTlQMpS/XDtd21OckpnepCN68qeQ9RA6Iy7NIjz1/s3dgnRKgmulDqdSsFCcEYcso2YA5GqPQLU4x/nhtdtkiayTmVX/p5tpzcU+Anzwcgl2x7nZ+dRmZclXXXdkg4f+MZ/bF9xxEPp193bVKODJIF6j5A5XT+rrsRv6n233S9IlWouhXWRur8oivjGUPBz0xjOV/Veyq0gfBqtaQhmrlbMMD5bj7hXlwch0ZP+VDw8VlrtIgVrO25gMm/ZiOsGkFKio1RJWUgUrvmJJbyVknNfZ31507nwEiR/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(7696005)(86362001)(426003)(36860700001)(8936002)(478600001)(336012)(44832011)(36756003)(5660300002)(2616005)(82310400003)(6916009)(47076005)(8676002)(1076003)(70206006)(26005)(70586007)(186003)(81166007)(83380400001)(6666004)(4326008)(2906002)(316002)(82740400003)(54906003)(356005)(16526019)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:35:02.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5400a0b-ca4a-4464-6e39-08d92a36c834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3009
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For BACO scenario, PMFW will handle the dpm features disablement
and interaction with RLC properly. Driver involvement is unnecessary
and error prone.

Change-Id: I19363fc08568be4b7d3f2ec6eba21ccf8fff6c37
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ae337eb41ffc..48c2854ea411 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1390,7 +1390,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
-	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
+	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
 	     use_baco)
 		return smu_disable_all_features_with_exception(smu,
 							       true,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
