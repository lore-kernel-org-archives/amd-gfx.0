Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428DC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 08:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FEA20873
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VPfH1X7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FEA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C786E554;
	Fri, 14 Feb 2020 08:26:13 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A886E554
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 08:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvYTseASTJ5DnMbwTSSiMjG4ltriIbzjHcXh3KqvFkZXpHJItLsee4LEd3Vxy1iPtMN19zMQOWA+ClB8tzCoaogtc3lymn3u8PFwZts172om7iKxpQ6/CLjwFxPvs508P4oPXys5w48+ndSPf9rl9HV877ftzwqLtwj0IlxoX0Y/8ZRfQTQxeHxWMeh2YAOFiF08vbWdnaRK4LGpKK8pHlwIcjEJMQnYZp30ckHD9f43m/cuvkCH3guqc0vi8D9GIYK5SNVKtOZTQoZYr1Om1We05BfhzMvYSsj+CZmr0T+X5mb2AkSXegau+UxRMh7cp16x0EhT+d1ajUtjDp/2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiHm6ts5PuYWPASQq5ItPGJHIegAeQRLu8aRWoX/ZVc=;
 b=LQ3g7Ox7rLVl+SxJ6+l7gOL6cYcp3BGU+s0D357jQfSAcAO0OJLn12Qt05yBhy2+bTiOYKyttMRyWOyp4ZAsVispa5kUYMYmUOMrJW9tS0/TdD/xpS4b8gndtgUb0aLgMTxXSPFWVhXjFYN5wPnt2nl/k5vtWocHGFmrhPNZbxly2esD43bwoguxdN4MbBqiDwlmvldg9GsY5g7YM665k5inT4+lW+AnRdIwo89oGqGrkvpAw2zze2pxUjG2Fes173M+GRqTikxOebNK8hTTz/qR97NeMQ7WdK9qKvzK7YwDQ32C/xJlIg+Ds7M4waV7/27kc3OPaGOkCCmAycYyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiHm6ts5PuYWPASQq5ItPGJHIegAeQRLu8aRWoX/ZVc=;
 b=VPfH1X7rg8jK4f0pCLdWdNZ77D2kgrX5JSjGIeuZWlArCpwHa+7Gs+IQj3klihVHUVIHfibTL+QywxmYKNk2/ySE1EHyk5/dckDFtuzQqYD5sAxqrc+7QgHMzXqKBet6qs5RgYrjyawxM+DONt/f2YYObygbJNBdrYshFE5/8lg=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by BY5PR12MB3652.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Fri, 14 Feb
 2020 08:26:11 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Fri, 14 Feb 2020 08:26:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 08:26:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 02:26:10 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 02:26:10 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 02:26:09 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] avoid to use NULL pointer
Date: Fri, 14 Feb 2020 16:26:07 +0800
Message-ID: <1581668767-7168-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(199004)(189003)(316002)(36756003)(478600001)(7696005)(336012)(426003)(186003)(2906002)(26005)(2616005)(4744005)(356004)(86362001)(81166006)(5660300002)(70586007)(70206006)(81156014)(4326008)(8676002)(6916009)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3652; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44a16712-46e2-4161-fac5-08d7b1278c6c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3652:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3652080E7E224F3F716E0CEA84150@BY5PR12MB3652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ8UXwDIb+/tugaDDez3IqcbEoRRoodG2o3LllED3cHuEdkiLBE+ZAiWmCrxNr8kDyrNICP6jMHnyIdmrcu5YyKz/QuARLSNl30oHYzghpEfMYjZ4X0t7XBjyWSZd2Zr6RVww51n9bf7p21/HDDuF7nPf8jUKl11U3n/QdTab88VuanftWRYnmL5S9+0L7iG+ok5QvE+W/fYjRdG30YukKlG4hN9ijbc6X9RZ8eMEWxiOJeFeHRIhPk/WJvngb//PrgFQi0Jyn8Org0pEyiVygEIwls/L4FMmsYtckLtVKIAlO6KVoraXp9rwAFZCkmG/ROtKduPutZe6xav4c7tuMbLm6zdyZhi0RffPvsWV7PGFxQYI19qW1ehZaJbZy3mQSuFeIAROlcZrKmN2yiIFx5MpnraG/XSCYiC6N8UNGWi0VLeIO4u5fjJJzvKGOL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 08:26:11.3577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a16712-46e2-4161-fac5-08d7b1278c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 src/lib/umr_read_pm4_stream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/lib/umr_read_pm4_stream.c b/src/lib/umr_read_pm4_stream.c
index 60bea49..317b638 100644
--- a/src/lib/umr_read_pm4_stream.c
+++ b/src/lib/umr_read_pm4_stream.c
@@ -325,6 +325,9 @@ int umr_pm4_decode_ring_is_halted(struct umr_asic *asic, char *ringname)
 	// since the kernel returned values might be unwrapped.
 	for (n = 0; n < 100; n++) {
 		ringdata = umr_read_ring_data(asic, ringname, &ringsize);
+		if (!ringdata)
+			return 1;
+
 		ringsize /= 4;
 		ringdata[0] %= ringsize;
 		ringdata[1] %= ringsize;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
