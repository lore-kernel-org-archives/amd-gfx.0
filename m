Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057CC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4356206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1GrSNWZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4356206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9320089F08;
	Mon, 10 Aug 2020 05:23:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F3289F08
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdEJh8Um8/hQmrQ38M0PJZhZx808kUQUH9coWQhPe6wKELqt+uo53NqqZHme1ClcibiVvNCy9BGztNd2EahInQuBs8jEdYx+RhPn7Fde1kHs8qqB13hknpifHUkyuiBqLrvbOqZYiataLXqibYmIA3B+2JXh0bR8pxTdEobx5IUi4nPtm2Bd4OWTeHb8YpkSLWqSaUGZxi0wPMJr4G1DDIczl4hMzId/r7uJ7Hsh/XexGhODPcd6B0M4haIFLIdjhmtBSubESUE/nBjjDGIfMkY/0BStWmHFfE3dNlLYfbOe8MvWU4CPXJDpPKeoAKlbtX1oQma/MNgz1KGcxlyLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odrZa/8q8+2OU92gIDQaDpxGOQ7DLYjk9HYCNsJrFeM=;
 b=Gof/+UBo1hbKOKYCGt6BnmnPWrjpN4EHh4qeQXODUHYVjScHHD4xCpVaV1in3Csy09z/xCUe9A2SPNQPGuM86rTmBUMD1ovbTGiXUHCyhs2m0bgwiGALvH7NmrnVw/WMAtvfO2C4BkxBi8innRZcVXfrQQOi4mZ9OKwo+uE5rOHcXCCwThKr3SSIhy0miSpZvVBdrPUuVA8zbSvS0TevSSheKQf9OhSJZK2OcGhrk8tm3JsmOTojWyIEhFIqNfYABgb6C1k2TVBsHZ+ot6GNcRBAECkbbj2opSfiAg8nge8LdNvBN2baWyCy/FB7eAezO4tjW/ijrN6AgpOOTpdXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odrZa/8q8+2OU92gIDQaDpxGOQ7DLYjk9HYCNsJrFeM=;
 b=1GrSNWZytiDkl+L9vmv4Cn++QM8h/YMs7luljj2LtqR9e8Mzyw9jSBuqbWx2OjFf2SVZzwO0V4MU2ub+AoTtnx8PYXrAkoYVv47K041/ZPwBA1U2LWEPp2hPK0NRAcq/+V0wGaQ7Ho54F9/r50MnUnDbcj/Y0ijTvCbO7GaAFJo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1574.namprd12.prod.outlook.com (2603:10b6:910:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 05:23:51 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 05:23:51 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 lijo.lazar@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt
 harvest
Date: Mon, 10 Aug 2020 13:22:58 +0800
Message-Id: <20200810052258.27961-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810052258.27961-1-guchun.chen@amd.com>
References: <20200810052258.27961-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.6 via Frontend Transport; Mon, 10 Aug 2020 05:23:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1278f46-b49c-4ccf-a133-08d83ced90d2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1574AB7DABC19C85BC529734F1440@CY4PR12MB1574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Q2/ZZtvt6frHobSJm8S/g56MjIsg3D4ITkwyiKabN4YxwQEC+0hB22cMTbG28FmVpUomgHMEk9SpELsYndyp6MNsKfHyfsU8NiuK8vXmsjuPHBwwcGCAz/JVg728+CMUGWM0I88Hsssmnli8qU+ji0lLmjTlJltyr468SDUUvGz3hpEa7RqoCmdhUXc18YvsDhCIcEUcIdYDIrk0xM4MDTB4s6/PB6KR8cuC4xeeKsMHz/NK1wHp4j2JE2RdWcFfz1czMs1q3Qltmln28e0u3J0Z4O3gTrp0hUvJT/+sd+wl0qUuAb+z5Ba2Un2rnKuyHtI4hnGvkUc1Q4eHCKceg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(6666004)(2906002)(186003)(1076003)(6486002)(16526019)(956004)(8936002)(52116002)(7696005)(478600001)(4326008)(6636002)(66946007)(2616005)(66556008)(66476007)(8676002)(5660300002)(44832011)(316002)(86362001)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: phzsJC4Gv2JE1BWCmg/WGokRT1U0vPRLzaxsqsJNFdI6E5uEUPqf33Hc70W8pI/1Lxe1jyvlA4bGau7nRQ4eOKDsl+9HEAyD9Gr4sJAkk1nNaIReepdHb7pUvvVpDufqOPZ4PX2UmamVxU/OywnheFIHtjln16nGurAaOPBd/QNJwJ2WQweeBrS4OoLHF3V+4xQHInyni8purKWyuHtLT8UUmcah0Wh11B6QRiqgfxKcp/BI+Gx5euR2PjgDypNVVtLlkzKEpGTLCw7k0nD7wl2lUJprgXQPrGwJdyiTJshdAT6P7ITliol1QY+OClh/us+KeQSSdTLcY8jjW1mKlTBYwUttETHx8vmkbmXVrQXJDFEP8uJCTjTprqNl4NfR3B39lTEAnSyBw03DvYklIYE7ffG33Cqs1b3FibygY9LnHzw+QWfx677zi/GplTYsKFEurkm8znXxzT0Lq5GqscJ6VdJI7yKv0cftcDvmuIscDSwgOmwngIz9UcBH5hHldMlewc5QvZQns5wLpUnYEDjxgnSOr9Mtay8RSuS1Ko7plh024sPrAkrrvEICkN8voksbzTMkOWCBD2sAkQBhVk2PtscpkIZnKeui2Yr7ioNpFsHh+00JRBFsVmIlM+XVw62+q09tzBIUtRfsUNkxUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1278f46-b49c-4ccf-a133-08d83ced90d2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 05:23:51.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXFBxeOEPaOlaNx8kqP1/9e7liSlMWRfp9fhMBYJyJTtMQBeGR1ItlKDejAULKvfGTsVZaAmb4rkM0oIqUNZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1574
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before ras recovery is issued, user could operate this debugfs
node to enable/disable the harvest of all RAS IPs' ras error
count registers, which will help keep hardware's registers'
status instead of cleaning up them.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e6978b8e2143..31df6bf2dc1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1215,6 +1215,13 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 */
 	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
 				&con->reboot);
+
+	/*
+	 * User could set this not to clean up hardware's error count register
+	 * of RAS IPs during ras recovery.
+	 */
+	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
+			con->dir, &con->disable_ras_err_cnt_harvest);
 }
 
 void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
