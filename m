Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB8FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0838720720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a6z+xim8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0838720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEC36EB61;
	Fri, 10 Jul 2020 04:48:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCA26EB61
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWhhP8dur2JWyFoO2Oj3DXB/p2Wfl3kmJfNLsfhOfOK0bqngZ9QkdreHTdNo+VUfINX+vUyLxv0/lwKrEgwYhfqqitE9aucCdzYBz39eImX2J1huOsKZ0By2+IgXP760lPLrtGs5QHouwAkXtCf10VjJGTRRhVQ8VwDtSsatSuhErb93P5BQQb8icpgiQY2UeVm9LZAilHf82Y0wpo6dsjSbDHviB78z3QUMmpmOdnXBS8Xz60RoQHirI+6NcLP7+ghFuuYyIWRYHfz9ucPViQrgxxVmE3krDQ0iVIfqarNE7pmZ1trIEJ5+TPndmE5wb7hV/0Py+EdVEtLqcWPfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+gNKHvagOKquC/hsXAt3fwRdGuHCLazA6y+TzuTIsk=;
 b=SwJBMpc4xCzWdBqHwZSQlRmljIgHhDGGo6iV6ZOMljBA2sGhCV8yBl5/qbxUkf+Bz7b7x5upa6xQVFHUljIj555Xr945gsurwyXsGKzwOXOTXNaTG60cUDTOi/UWGWRE++FJgT9rViMLC+pVGis3x8+BlIGGq7zLQHJ2BRaY+fyCiWmiLLBqrmVFWYd0GVZ3rbi4sDrqYiCkhmDYokI/09JT7A+jECBo9ir0uR+gvR/Q1peUyNqPWBWIkcTEFJoOZT2gNG44zo9fe1AYScG6j7ZiFjJJSkeKG/qJ90rOZ/Td8/pCCFuCwNt2e+ybd2dK8jd+WRsk5gqx9uJOECbePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+gNKHvagOKquC/hsXAt3fwRdGuHCLazA6y+TzuTIsk=;
 b=a6z+xim8Dj7Vxqb1U0y15YNy9+A8WaKV1j1bPkpaLj55oeiwPZ/F39b5zPJNhlpiW+tATAPceMZJxBMAMqNjLlQSY6hn8G32Ouv52AboGuPM8A50oXLexr0NdmREFP9Z3k7L5UdqRHiHQCz8aUKKAVQVxLIiRiA4IliC2NxKJY8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/16] drm/amd/powerplay: add more members for dpm table
Date: Fri, 10 Jul 2020 12:47:31 +0800
Message-Id: <20200710044746.23538-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c826f14-1266-4393-f896-08d8248c6fd1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360F997A2D9BE7D3B878DE2E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0oo9cPFSf5CwlSG4M28BBaB5Y9JJpgVcZ46sWlmpu+DCyPedEbR8XUK4RJ1RA9HjPEHwnYqSK9uLGs+BSeZG6IoAlevql/OkToEo50/8zhySxMwFepQ15Xz87nOOiyN7Pud6XON1evhHtAi33FNM28xdI3sxop91KnxC2xKq9JyQf7ZmX4yEGKbQge9/FgdqvK2tLN4HLh1sp2d1QskE55Fdgj5jUuTOUEUpK4bz0ZL8sRK1NRncnn5Ams/QmMACigxESBc324NVSRUIJyIowXO59QPDhy8D7edHj0D5Qsd+XU0wvRE9r38SkMpmCw7aiUU6jVCzQPPg/2cuqBx6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WkFMtuGiU719PdaHEj7NRT+XxZHowBko8TZucB+UuViod2OvUkz6u8AHcgmcsXMCOXKRxa2y9ao7NZAOExJwBbYlO6/FV+0itoM8r/DSBmExl/qAy3Vi0nWp/aanp+AGHI0/Jjd46Ro5plUEP4p+T/lyy6yFHUTlFtHLnofpJs6kN99+pXngQIMC+mNFDPAkvS+9fCGA5wFPbpOadHhl1LOdvFpvIdL+pfx2zVnW3A9wI57B+DU2fEevAXFhdMvx/YlqVDTwSXj8vrOtzFAeqlkpa8fEwFirJa00Scg9gslUKZLTjn0Igurge0ouop8NXU5CqNTVELFX8WcU7oJpUKrKLXpS5giuW1csYWFUtizGGjCQuvXvMBzoc78VKjfh8rHCSXxVAfCdNWrkBSoJTE5pDX3yov9f+w2VW0VLarRhv0rC6oXSs0ordid+Ncz8mIN7lXDVkUT+GAP3T7LK1eNMgv+mDTIDPHj085ab1u4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c826f14-1266-4393-f896-08d8248c6fd1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:06.4987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlGbOJMfsl08ZJBsf81QJG59rxgYTgTs7tog7TxFVrH3Tc3X+RYApCT6ptlxulJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These members can help to cache the clock frequencies for all
dpm levels. Then simplifying the code for dpm level switching
is possible.

Change-Id: Ic80359adb8c0e018f306782f24e3f8906436f5e2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 3d746b75396e..289c571d6e4e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -48,6 +48,7 @@
 
 #define SMU11_TOOL_SIZE			0x19000
 
+#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 2
 
 #define CLK_MAP(clk, index) \
@@ -91,9 +92,17 @@ struct smu_11_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
+struct smu_11_0_dpm_clk_level {
+	bool				enabled;
+	uint32_t			value;
+};
+
 struct smu_11_0_dpm_table {
-	uint32_t    min;        /* MHz */
-	uint32_t    max;        /* MHz */
+	uint32_t			min;        /* MHz */
+	uint32_t			max;        /* MHz */
+	uint32_t			count;
+	bool				is_fine_grained;
+	struct smu_11_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
 };
 
 struct smu_11_0_pcie_table {
@@ -107,7 +116,9 @@ struct smu_11_0_dpm_tables {
 	struct smu_11_0_dpm_table        uclk_table;
 	struct smu_11_0_dpm_table        eclk_table;
 	struct smu_11_0_dpm_table        vclk_table;
+	struct smu_11_0_dpm_table        vclk1_table;
 	struct smu_11_0_dpm_table        dclk_table;
+	struct smu_11_0_dpm_table        dclk1_table;
 	struct smu_11_0_dpm_table        dcef_table;
 	struct smu_11_0_dpm_table        pixel_table;
 	struct smu_11_0_dpm_table        display_table;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
