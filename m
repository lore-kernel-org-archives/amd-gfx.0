Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791FC35242
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 04:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3327620848
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lPXOd0J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3327620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023766E075;
	Fri, 14 Feb 2020 04:04:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04F56E075
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 04:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOcCMtG3BuSBqaTBITU0aY7g7yK/DmgZY0LIwPkzuWsQBusDgtcvLUj8dS0auE8H7uvMPiB6upQnfvKknI3NfoKAck8CFJpChUQh0deQcGQqmQk2O6P/k2QIiTcyxBVLiZMudLBQMqs90txBHeB+LRYOCF4o35jjOcfdsibYZ6QTrf3Mw83bHxYSS/Gj7EeeqmGHkgJC2/uDO724aIfyJ1a6IrLn7HZh+y+dSkO8Gv6NahO/orhvFMMrveZE0Ftj+HJAM0z9vlqmw+3tP/ql5hCngiYHPkYn6osUUkorX4efo7uNe/Mi8TjJuT8S1zqM/1gPiNUh0aLUv6dzELKcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0YcCcyZVzHtgnaZKm65ChNEyYVqOozdWhIZrF4f9w8=;
 b=aYAuiFOATHmkitlR/tNzSggQ6prCbgZZmM/ud2uIRDUOMIQdvEcpRq6ILy9HMWxUGpfqr/RcdVsV+URstIIEgZmCryRk8c2jvgVL1TZCHWctjC5r/vY8n86gq5bjOqV2aNB2Wt8N5c2kRV5S7YKbas8O3C2GqR5GN8sxPNOOzK5c2Uv8l+cE+abPmPLrT4qBlTgbkiPWCd8hNkH1382uSPbZT6weqDIfw7nKSWuAp2c0TzUMC4uMdgcR2TM0DduRTPeCZ/1QBRQTa6viG4lF05MKY5E7gh7MsvtpqpTO+t0vBhOHrxPvwTayl7jFA53smxtRx8KbjqV9EAzuOtkT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0YcCcyZVzHtgnaZKm65ChNEyYVqOozdWhIZrF4f9w8=;
 b=lPXOd0J+feasqSMKKyNckPsJZ6w6aHjRIdubRITr4n5X+mnMOnTVT99gdPS1BVDkAQJpt/CRVjEH7vIJaAFi+UNZGZXz2WztRl2TKYQB5j3+L/t90+IoS+bcQp382qiH386twbVtNlSCw43WqWnW+nofENbM2TQKmx4HHMoYJH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3456.namprd12.prod.outlook.com (20.178.242.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Fri, 14 Feb 2020 04:04:20 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::fc81:31af:b81a:1cc7]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::fc81:31af:b81a:1cc7%6]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 04:04:20 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: Ray.Huang@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1
Date: Fri, 14 Feb 2020 12:03:58 +0800
Message-Id: <20200214040358.27771-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0072.apcprd04.prod.outlook.com
 (2603:1096:202:15::16) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0072.apcprd04.prod.outlook.com (2603:1096:202:15::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Fri, 14 Feb 2020 04:04:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34b1d393-5c9a-4498-caa0-08d7b102f7a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3456:|MN2PR12MB3456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB345618EF8B37D43554D00E9AFD150@MN2PR12MB3456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(8936002)(2616005)(8676002)(956004)(36756003)(66556008)(478600001)(81166006)(186003)(16526019)(81156014)(7696005)(26005)(6486002)(2906002)(1076003)(6666004)(5660300002)(316002)(52116002)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3456;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKD3PtKtRcGzbhItYWynTzbpcvQuM60SSaSSnfWo7UN05a4pvUFF77WAguft98fHiGgVOgDwBksWpgy2AXZCgjXYgxDSupawgKhgWDZEmCYD441c7TijEbKXXBpTraxRkeqAVL0rP01cJWIKj51mbT6Y11hgiu10+wxczsWSkUAWxIP41uZIUqgVj6BEeo0BKn++jbpLfK5yxn7K8TpiOtZQ77sEzt80l7n0jWpmEGxzhnMFVG+3LL2uqi21EbqWu3J+wjY12ftWBAd0zqcI/srR7uIrye6v+MsmCXaBIGhGjetX+fMuMbBCnQVM0o+X3Bm4sM+vO20XNwn/BysqDhNGVtkiNlyzV3qcHUOj/5KtjlFGI5k90VMfJkKc34yiUXOlSKTFQ34XfopS7+veR3tfXCzPq3AvooC0iCOQHqgFQNHsBZ0TpV+2lWHjoXce
X-MS-Exchange-AntiSpam-MessageData: +KFvD/IlxM6RfzgnZcmtjtQF5BCem2xk25vMkQ0ZV7zWFD5SfLux+tHpp3f/TSeEiHUGHxekuZaFa9ZahEocbdU8uhAyoqlEw8Hmz1sVuN1r5yJb2oYH9HfOMV3OhyBzB5rSI/dIiwz7b38InDkUmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b1d393-5c9a-4498-caa0-08d7b102f7a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 04:04:20.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVR7JXGQ3PaNDjE1zQK8v7b6dF+/XRl1Rkap+xSVM1oYBblEjiXAXmhbYqZkwl0LdrJ0i0Vl+CoJZCE45V8cTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

The rlc version of raven_kicer_rlc is different from the legacy rlc
version of raven_rlc. So it needs to add a judgement function for
raven_kicer_rlc and avoid disable GFXOFF when loading raven_kicer_rlc.

Change-Id: I00d726cc39eae4ea788c1d5faeb8ce75ec0b884d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4d8b58e9d0ae..9b7ff783e9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1193,6 +1193,14 @@ static bool gfx_v9_0_should_disable_gfxoff(struct pci_dev *pdev)
 	return false;
 }
 
+static bool is_raven_kicker(struct amdgpu_device *adev)
+{
+	if (adev->pm.fw_version >= 0x41e2b)
+		return true;
+	else
+		return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
 	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
@@ -1205,9 +1213,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 		break;
 	case CHIP_RAVEN:
 		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
-		    ((adev->gfx.rlc_fw_version != 106 &&
+		    ((!is_raven_kicker(adev) &&
 		      adev->gfx.rlc_fw_version < 531) ||
-		     (adev->gfx.rlc_fw_version == 53815) ||
 		     (adev->gfx.rlc_feature_version < 1) ||
 		     !adev->gfx.rlc.is_rlc_v2_1))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
