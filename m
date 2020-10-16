Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE47C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2E7206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tFsKoOOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2E7206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27D66E9BD;
	Fri, 16 Oct 2020 03:27:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25ECA6E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqOLYyQT5NEruk3CzqvfN1/X5bQrOmuDfHD7lRoTwjBxKkND6Lt8rzgwPKgHRLMATIFIZVUoYmuRaHxZOE/tUAUDh5kvb1i1i5YByilRa7EOoHAoGaIZMv5e5RvS4JFNK4WsFsLAMM5OVvEeBofxGsxM4mP74c81zVhyfSAFwIr2FQ8/wHhY0DCKWuli3mFuILpUUEixWk0KToxPxtEsQUR2sHWEnlKIzyNoNxavLcHctt85Aj2nP6oDi2gULI4I883cfwhHLOP8Vhf2k6fvXEHQsINyNZarifjz2jdyQ2JHJ3YtMj3HrBk/GOtrdsM3QRZPfx3u258tyGXJ9XCkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rrFcrxe5cQoPOFhAhk0/+eo9ePvHWJnIWTwyLW2+Zg=;
 b=YIXRfaSk1/6B5m6psBQo3mkEDwDa54JNVLDmw0SCFYP4r2oufXMzbPWAVSjyc5lYmVx7p2ZvuujhvXcgTUXCMFguM8o+wf6ntxXXrJPhr9Zgy2TLizlXXMbKKxQnLD0Yn+D5tMFTQtqkl65i/Xp274GwOpoA3oJvXvgf9NOP58GZrP4s7ULDe9rrpdEPPeFZGkOW4roMaVN2KnfBXPjl4pBb7oZJotxgB1jUA4n2kVTuZltRGzeCzFL8gS2bmc+bOiU2NUwN01eZ3ANuy2mZTDqF+Z0qmkd3g9BWqkpiXdQ9jz1+16MJWrrrChdFU9QxWIqYNWSY0iP8kEKA7N5hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rrFcrxe5cQoPOFhAhk0/+eo9ePvHWJnIWTwyLW2+Zg=;
 b=tFsKoOOB3zgzDzqsADKcSmoi5xzsvl3BU2+tortLUElyDQphD9e/Jve2qYGe8j2DUqa4l0AHosJXw/ZpSP9LYPctdCdgPx0mlRDR6ytB/z7L12CAAbcWjYoHdsH7Aw/WQ6hFQEKU9u9LlyjNZdvhFZRWylloa98mD8pLkzCHjwM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/40] drm/amd/pm: add PWR_CKS_CNTL setting
Date: Fri, 16 Oct 2020 11:26:24 +0800
Message-Id: <20201016032652.507-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a0e0fb1-53ee-427b-5190-08d8718377a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46802BE4C4E0822EE9453509E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BxWAWNtPMZHGW6fvrTpuPBzbrRWuxT7PDInkpLWE4YhltvqPxatUepLn591vgDIuaB5AAg1mywD1qdLDBnG2PuUKeIsxllnIJqWDQBkdVP7QND9pkbimKFto/2NshiZjSPpiDLFy9XXED8Lrvqj+QdOG9JVGtaJosHdwlc6SAjVVJFwHNbmO/Y10UsoviE3uIqbBXWXpTP3oal8+8TfJqWKqVbwtNXatBaHiTH3/8M0DOC2bGilofs+3WnLcsp+RAlWg8TpQApo39ckc4G8ztMBeT4WluKnmZPLub67R5Ub2wBaX7Wu+gu6I7I0Pon2fsEOqMERgWIYY17iQoFvPfij7GBAj0bO6GRPmIw8vr102dUC4DNQOnCQFym+N5rL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9xyFEQmprjkHF9/273jZo3CRYihjKIvqbPzJf8wzSzLK54w6e8arFTsO3MCHWwuBbHt2K300NRgzfLguqno0iVE8yzJuUNMDHhBUjFy8PM8tzcoJyojDKj3uXVDvnTFQJQRUo3ArkpYytHDlZCUpOgbBurzXCoLzRN7g3Ym6GDoVUseLB22nvzg6sjo0DUAxfkPYbGf1RIbchymjkKUkJVcpGcrmGh1s7DP5I+wvQPGkuo8EwsyY82p8nGhkjGk0tHrV91Zr22OjrXyHuXxF+nUqJ2LYTYFA751H9/UGkNx7b0Ot/v1LsBEG3x88KD47QEMa37b4S+KLwPwGTdvJgwf/hKfdOFwUUUbVWU6oQX/2bTikEnzrSqf7Of2pb6mT8BvpFzXs5wastjuTbATDlMU6Ur23ykwk9QfoGgIZNtkD5xFFcc7o/ubbB3YjkRZBx5PRFz3Uj72v7ch56HnpZjURtXbaJN7TqSSUN+1FPkV2LJrL5xTxgqTaZkyz6RRkfaOQGHyaGddWiaEP9FVTnBjiXdvYkLx0Nd2Ij7l62iYX/XMr3pi5/xZ7cOH9hKvMXM2zEejvCM8rFKwlUqqaY6tX1sE9X4ueeUaRoHT5S+xb+CTAJjVU2OOnDIYQF2VPfB3uIB3xiiEfDpiGCtm1cg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0e0fb1-53ee-427b-5190-08d8718377a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:53.6297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNvfXXQpo3ru+K89CVLI6z4d67eEbfxYIpCuaKU9sE+UQE4rhURua3O+mM66EwMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is for some special Polaris10 ASICs.

Change-Id: I4d949d32de0f66f4b34c8aaac1b95f7c5288b121
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1e8919b0acdb..5a812f170eb0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2138,10 +2138,17 @@ static int smu7_patch_voltage_workaround(struct pp_hwmgr *hwmgr)
 	sub_sys_id = adev->pdev->subsystem_device;
 	sub_vendor_id = adev->pdev->subsystem_vendor;
 
-	if (hwmgr->chip_id == CHIP_POLARIS10 && hw_revision == 0xC7 &&
-			((sub_sys_id == 0xb37 && sub_vendor_id == 0x1002) ||
-		    (sub_sys_id == 0x4a8 && sub_vendor_id == 0x1043) ||
-		    (sub_sys_id == 0x9480 && sub_vendor_id == 0x1682))) {
+	if (adev->pdev->device == 0x67DF && hw_revision == 0xC7 &&
+	    ((sub_sys_id == 0xb37 && sub_vendor_id == 0x1002) ||
+	     (sub_sys_id == 0x4a8 && sub_vendor_id == 0x1043) ||
+	     (sub_sys_id == 0x9480 && sub_vendor_id == 0x1682))) {
+
+		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device,
+					      CGS_IND_REG__SMC,
+					      PWR_CKS_CNTL,
+					      CKS_STRETCH_AMOUNT,
+					      0x3);
+
 		if (lookup_table->entries[dep_mclk_table->entries[dep_mclk_table->count-1].vddInd].us_vdd >= 1000)
 			return 0;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
