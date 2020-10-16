Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B156C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AC820E65
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="REjraS01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AC820E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB8E6EA7B;
	Fri, 16 Oct 2020 03:28:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B572F6EA78
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUimy4VJK4Kn2+WVF0cu3zZGZ5g8f6aHuH2u3dRLSYpTOD+AMvBjtTzR565FRSzwTN4nxJxSkIZt4VE0RDijUlIL8/Nx6R5KjgzL5M0i9l/w+h4c7vWg47j+hJ+ruTWLMepjQlRDhL/uoqae24EbUL+vVFX0eFHjViVQGcPOME3hrIbh6UFsz9T0go8TNZhHkH2lQo+HBMiwhucMjFvejAIOAn3fdOG/Ew1uVyxfH9E3jDgrORhDQgbqPzQRzO8i49nREJIxnqcN4pCGSu+5fb0G+fWp1ZK+ELEHdHhoksnq+c5zZQ7pZUT6TfZDRtpOhsGeesPwJN3U4EGF5wssCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHoc9pFuooIlEGRsGNzD+S9SAnBfgXPa/mr5BVbJhUs=;
 b=apxL9eMXYTP8zxE2vJPzJJMsGQcSjkvqIoyUXbCochXUE7hg8MRfRxxjyht4+3a75RNG1zrBNTAqt3Lkg1ILMS1VPn/rx+1kVjqd5YjoveS5uc9XSV2pMabaWh56V7HVsDGqnIiOyJLGKB7SHhdCaywgrH1/h/PuvIgE/EWr/ltOUCDammuq5AvpLS0llqiUaBHkj6wR7P5YsWhRajLmHQH5ISkphO7m790KZ9zfwoYAOek7wU6/YVuaE+GoeGBgn6KLgIr78FroitQni/2VYCLmcypnEl9A8GghlIolMjgucCyE1cwXrk9659+nYhcVZ35JsHDLXydDVrQ84j1wIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHoc9pFuooIlEGRsGNzD+S9SAnBfgXPa/mr5BVbJhUs=;
 b=REjraS01wZ3c0Gx0Ix5leLCnTgdzfZfxwTRNT881lXidlYkGGPgPkfrsvHGKDDtVu+4kaBUBxrfUXxZEAUNIaIYEwoaMomy4JGuyiJKFGCGFpVcNVaTukN4TZk/2yGcJFma4CwhtkeT/+jvvU/zpWoq94SZ/+E8Mai6/PmShRq4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:57 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/40] drm/amd/pm: optimize AC timing programming
Date: Fri, 16 Oct 2020 11:26:26 +0800
Message-Id: <20201016032652.507-15-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 673dac03-edb6-409c-dac3-08d8718379cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB468082BE0A95161306E9C9D0E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0DZ27ob5vt5+Ehe4v51e+qhpeNPOO/q84gNFC/UDg+NRGJaXQqS2iwc1waWYu67uiyTMMulAPtgFArpsTE4pSe6rA5wrtsuD3+EjCsd52De++aC1yzSMYVBY08eLKLDFaqAAOSfydlEvkVeZ2ePDlCwZBh7xCQu/k2QZKV/I9og8g0pkqgzY0Q/XcRRvO8TnuHDSr0iHt1PdkFOUCncAAPXY3M8usB7k9hSxHM0Sv2B9JhZbQZFStFjF9m9nB6P41DF4sVPCkUo98tDzAF853pGt4V+bRmhhirjN+wjDHC1Z9SOtfEjeJKNmHOg5SUE5awe9UOb2j942hGJtku4I4fTQP5XljHPaWUT2UfIKcRbbTeXAp6TwJT0e7xIsBzK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yhabX2xNSLz6iwO0C/8P4W2vkKaTMjwIt76nhMhh8R8pPcYUfuqDNmM+gruGE4GMMxRNNUcwiLN4J3VAXx3eoFqKN1R6J6LMgBSW4IQKXKVmcurzewvfswJv8quM+rQ+A7mWJh4FcoTU9QIb/1MdVfUkTXddoDstbTnSb5iYZNTXmsfBJmbktqNy8JAoW4n6VCtqFPztvXywUIczr4CG+vHNYZmsis2EKJlO4R3uMIgDcDaC/mOzGZSrTcr0H8yLj4HhxKVQRqNrCVhfvWjYL5ChTFXBRZbydodwq8XBxWASv9if/L4kFxecpdELmJLH65cWvW/VAflrqYK/3U0zVwrZqi+9K33WOO/P4BVwuDBBz9H8Vd0s444ShPGKwo2CDMyPsn+DHWWf1UP5oWY7ez350rSoq1FKbSBdAFMNjcdiVoAtCFkIhb2esVSJAm2Z5ZusycY892JuVDJO9/EU+DJKMXXhrdAHWprbOSbN9QQqy4154b8AQ13mOmQCDkO8k33hRizC79000pKW2vZcNMOP7d4ie9HnQRbnPAd7fp3bAJWAEFqNWGmSR/eO0NQwqR4GsjDtpmJzoRrhE1sK46O1QX4wCuBCHy3BRnu3TC3lMln+lr+HHEG9f3ElBrMJi6VYX/yD+2MATwz12Ol+RA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673dac03-edb6-409c-dac3-08d8718379cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:57.3956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amGWrmBafEPHu9B8MW0G+UqG5Keenyj8eroLEy3/7trZx2vCWgUUFX6i6KC+YUZc
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

Programming AC Timing Parameters is only dependent on MCLK.
No need to nest loop for each SCLK DPM level.

Change-Id: Ib6b84f758553b804a75b8ac64541d673fc090efb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index e6099c2d3c11..0c55574bff7a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1465,7 +1465,7 @@ static int polaris10_program_memory_timing_parameters(struct pp_hwmgr *hwmgr)
 					hw_data->dpm_table.sclk_table.dpm_levels[i].value,
 					hw_data->dpm_table.mclk_table.dpm_levels[j].value,
 					&arb_regs.entries[i][j]);
-			if (result == 0)
+			if (result == 0 && i == 0)
 				result = atomctrl_set_ac_timing_ai(hwmgr, hw_data->dpm_table.mclk_table.dpm_levels[j].value, j);
 			if (result != 0)
 				return result;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
