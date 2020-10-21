Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047FC561F8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 09:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4BA221FC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="THH9zxua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4BA221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6902A6E415;
	Wed, 21 Oct 2020 09:32:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66A86E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 09:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkwwMU9eGSdB7uMpXzdIa2waBlmdozOKMLch5AGujGJeBDoDYjVn64vAuStXIbgB/L8BFxamkbBrz3j5OgaS/txEDzWrSMUZXezYfy5Yee5VQITSnEQJbf8iBJlNW9RNLKbFwXaUtRJAXVTcDCxlakCNnEnIYfjF4g8OB5OynPZNCcxSGeBvysl8rtVXmKOguSdDHdo/vs/O3x2xPP9ljPSBq4pA3T8XpavwK7C9UY230rfdzoHRM1QoljgwGg/fRVTjp6iNM1/6767iu3p9eTBjKU/Ngxisn+AOThUD1YsSNIZaXmZ2EPzN0zs/q2JkMP7sLrjLXmDlpcm5SarzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGKatUKEdS/YeMpTzkPzIMHzrcJTOYPLZJakVH/8bS4=;
 b=cRY37x+UjYH+e7NdlSZ+8IqU6JhIjgHRRZEz/+AEsq8qgAVX6KYeMkDrLjtZHoHPm6ojTmfnP8nSJtwYcMc+61Y0GFD6sNo/VUdVs+UZfHs3SKd8wSO2ABIHe1NIsPNPQOdBUSnBqHp/Vp52O9jcD029Uz2nWH5yVJx5qtLZFOS47otoLGNubN0jdPxbfcn3+mqi6oI+3KF1Cfd5xkp7GGOVNsQzxsK0oJ+EMtaajrxkoNJWcwpJBbmyMN9a803Z8pyC8LUrdbW4SLQofxfbtifaNNtMnHvkPTa3H/BnpiIIyIja9hm0UseowQUuWI8oaSSUPE5ijhMt/i+IfpLK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGKatUKEdS/YeMpTzkPzIMHzrcJTOYPLZJakVH/8bS4=;
 b=THH9zxua+5926LGVtZsdP4kPnFSETSoZPOVP3NsVTx58hhMXaej02KIs7WZ2i37vI/0Eb75dDfKR3jKr13s++aVRm550m3mMFDfTSXirf0j4ir2dJWun6hm9gEsmH7doYiXL11lnCrhZ9Va1dYoihM/nG5B5/bOdrt61IGJju6c=
Received: from BN4PR11CA0012.namprd11.prod.outlook.com (2603:10b6:403:1::22)
 by BYAPR12MB2855.namprd12.prod.outlook.com (2603:10b6:a03:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 09:32:54 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::45) by BN4PR11CA0012.outlook.office365.com
 (2603:10b6:403:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 09:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 09:32:53 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 04:32:53 -0500
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 04:32:52 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: remove the average clock value in sysfs
Date: Wed, 21 Oct 2020 17:32:49 +0800
Message-ID: <20201021093249.16119-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd75acfc-1d7d-4682-18fc-08d875a44967
X-MS-TrafficTypeDiagnostic: BYAPR12MB2855:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2855E2A5E2643580E0A6AC418E1C0@BYAPR12MB2855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSZQnt8j75Qw8Qu+MXUd4IaH0kc/3iJexr+YQzn5TW3EUBYxwYyaDJUzHZFblG9BJevAc5noA3ZqvXoxipTeXKFX1MEPgkscSw5VTnO+6rN27C0UPKMS6p2N1W0P67VIBnMzBiVJ4wCnTGO1ZMXw/pb2MKAg628fsennOD4tbEJ8VrbeyAfPRVPozr0c7k4avIHe9wv7GVxfeUu7ygon7upq6qbSdnrrEsT9jxW5AHBTJYED2aKDjU4RR0Ve1aqhnE51hKTqmUF+s0vCPa/nR6STWxN4hMoH3Avep04GMfdOvcVOJSl480wq9d/qOmMDL7fYjqHYFUcbHysSxsoJNBB6pLBrX11G6y55HN7e7Q8E/5L8O5wEyMqz+nUKazzWp7dfGICMsMVSj11u4Ay9Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(4326008)(82310400003)(8676002)(5660300002)(83380400001)(6666004)(1076003)(86362001)(82740400003)(2616005)(47076004)(356005)(81166007)(2906002)(26005)(478600001)(426003)(70586007)(70206006)(44832011)(36756003)(186003)(54906003)(8936002)(6916009)(7696005)(336012)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 09:32:53.9055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd75acfc-1d7d-4682-18fc-08d875a44967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2855
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
Cc: likun.gao@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if it's fine-grained clock dpm, remove the average clock value and
reflects the real clock.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2851f8e9c11..fa3842f460fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -955,12 +955,16 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
 				     cur_value == freq_values[2] ? 2 : 1;
-			if (mark_index != 1)
-				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
-			for (i = 0; i < 3; i++) {
+			count = 3;
+			if (mark_index != 1) {
+				count = 2;
+				freq_values[1] = freq_values[2];
+			}
+
+			for (i = 0; i < count; i++) {
 				size += sprintf(buf + size, "%d: %uMhz %s\n", i, freq_values[i],
-						i == mark_index ? "*" : "");
+						cur_value  == freq_values[i] ? "*" : "");
 			}
 
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
