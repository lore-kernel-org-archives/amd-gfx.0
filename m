Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6D8C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A4F20857
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LErKR4fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A4F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FDE6E33A;
	Thu, 16 Apr 2020 16:25:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1426E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 16:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+vyKI7GKr1MQg07tczqs2aOevZ6VoLvsxIT5+RlQaCGeqVWXGRmWEAPEz2vZjvq0vpzdo4MAzOYdsjOW2cWEtdAY3SOeWMC7pkdiI1gIL24M7uZRfSQpEd4iN2f36j0MYu9UCwv2zfe6a7RKHSNbGjAgK932BpmuXWgo9jVQxKNQTD3Lgj/1IqCpS15BG+8UtYKK0k1LuSZHPg5Ai4KXJCitW3xBwLR0pk7tJLzRox2PGTrd18+heFlLBalKjr4I738bjPW3iz4PzqNRvxAaE+Casqrr3zqKC453UbPkIwk4MQGSz+SwNX29KHqKrK6Z0qhbGKVWPZnG1liBXmsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObGMsIFyg19gAzRDUHwmn8C0A2C7oXXNoZ8LQMP3W68=;
 b=iUzLNDJnxraT0bjeZZqNYzSrMRUUMPQnboXUy+TolWlsLQGPFW3W9BrnAu+V6O0+Bl14JCgFtFXzkemoYpny1mhe3FQdCYLLIKHTFSXBX8eaIqRSg6q3sRwo7mpXtuYHoPmP9rWAcWMcRi61rKM/RE6KOKAG05cbVK/Y8lzBwavEgaSUERND9ZYKtSqq4lsh+rS17GiA3NMUO5ojgtRhFE8/ow84eZ6hpUD6AXs3DqovqYtQ9DF7gPtLHzFjyuRt82zK1Vo6xSXMALhA6PuztabjC4Y1KxDNvn321JqmoSMMkH8wHE1TCaOLCJb37NoV3OejNtV4tfcllANem6p4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObGMsIFyg19gAzRDUHwmn8C0A2C7oXXNoZ8LQMP3W68=;
 b=LErKR4fIIgTvp9mFs1Oljc9zaA7do9IQQJRISfLBCj7zVxJoNF9aiISKn6rTNV8DwO+IP7PCOmrGIZ0QyVepwQ88ZAn1FBgVUYmILPUJfJTLO8vvHQd5vne1f625uGuBWWvbyltmga3//j4deRec6YGLO3a19W2moaL164+LjbQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2453.namprd12.prod.outlook.com (2603:10b6:4:b5::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Thu, 16 Apr 2020 16:25:05 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 16:25:05 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: Disable gfx off if VCN is busy"
Date: Thu, 16 Apr 2020 12:24:58 -0400
Message-Id: <1587054298-8076-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 16:25:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebb70518-ad71-49ba-b786-08d7e222b86e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2453:|DM5PR12MB2453:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2453A848D3D98FC9E050A7E5E4D80@DM5PR12MB2453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(8676002)(5660300002)(6486002)(66556008)(66476007)(6666004)(8936002)(478600001)(2906002)(4326008)(66946007)(86362001)(81156014)(186003)(16526019)(6916009)(7696005)(52116002)(26005)(316002)(36756003)(956004)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIL0DTzRPg+MK6SPVz6XFuJLLFEEb/uxdlAOc/UWfXexvx+cQhS9ePjx7jbnbuoTWr8w9vhzEWaPbjwXBSF0NaZuosH5EwEjHVhuREgexfWnIlkvAz4LdF4pgFEEGtHNRVCoRVNmcxUH/LUMBO3518tzpJJSepfFnWbGGlLCVpFLZ/44S6LhL4JIb0T2bc29Y2r6hMrczf7GCXPLC+bePf2qMOQyWA0pFSxTHOgiqa6g4A3skX3m4LjvzFHdvHruy1YdLRSPdSi1Qp1Wkkls93e+vez1YN6dWMDZmJBrY6f/j77nth9IUk8xHQPM9O4srIt6uoQxUU2ObF1L+GZLCh+BRZPuupetbE86AdR2PbgdaGb7yM4U4SUlmZl3jXaoq+ak9EYDgGko11EClOH1hOE8dtt/p061VxQ4sxSBvl0N5EPUNlusjp6/ssItoVM5
X-MS-Exchange-AntiSpam-MessageData: JXCQ8dQH6MjxUyo+Yg54TMBSv1hZCEuyPmBlG2i8KgtGKC9TQht5tvH7c9qZ+TdyD3fA7nXYWJ/seX/x09jA9uNGi3xxB2h0MnAVuv5U5ySmQU3CbSwJ9p0aa6yRcm0LG3dnx+ycZIbbJ4iKHTCcvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb70518-ad71-49ba-b786-08d7e222b86e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 16:25:04.9902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQSgIcNR2fEfgr/ql44m2EgTtn6GVN1jFuEpTt90rgZGJ+K83YcXSUHp/wjVCvrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2453
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
Cc: jamesz@amd.com, Changfeng.Zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3fded222f4bf7f4c56ef4854872a39a4de08f7a8
This is work around for vcn1 only. Currently vcn1 has separate
begin_use and idle work handle.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Tested-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dab34f6..2de99b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -353,7 +353,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 	} else {
@@ -369,7 +368,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_gfx_off_ctrl(adev, false);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
