Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C84C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3D9206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t9KoNcpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3D9206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B43C6EC23;
	Fri,  3 Apr 2020 16:30:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F706EC23
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcCUm8Imk728BEnDICtNnZ+fzAb83C4CGJoA50jvdDErbN0GUt2llisbfj1dyTXyMRPsMXqUmHvRbbhNyBXmPph0sgqFk/F4di55awkLn7+tV/dzSzbqWwlBXloISOMKkP/FH5T7B6bpNOksKaEHJfl+fvbefLWXusww5SHAV19Xq2f/HKAURM6/btAUjRo+OeBRbqBOIFJeQCQ+luQXu+iw6f8WKrVIrxyY2BqioWaqmzYvHF3XtKearfV0/AQOhRxMYdIsdm06m392klVYoS1SXRXn/a5GxyVJCab6PB0Yj/NC1SYoVDkempAVxNb/58bewKuAjzHpxR6Kwadcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu1Fg4f6Ugu6Vvc/iPcwwKdVmpg3Z/MvRghCko/9NoI=;
 b=ZCvmQ7j9wd6nLdyEt7wsNli/aRFWjDmJzu/GsjlTk/XDx7Dmx4hTSfrmoJZU/CJkr5lMsMGrK/WhS4WG1rsBAoYN5LMmQ406QSHClEAkzRhiW1HoRUqU5NjEWwrF/1tX4ci59aC/3muAvZEeftg/77UKOglntUN+nySB1rfRO/2fv000CvgNKyJ0HtpuhiiDIjM8F+Hqu8pXnrGQdeLtzAu/2Mbs6pVcfmQHf7XPIGX+bKksgemLmcxbm4JSr+/m5aTNNQ0/g14DQhjobXFUMYHNoxdni6LNv/13E5U24zuIeN8m0rdaUhLcLrR6xPe/7BUVzWilKm6Dudv3uP+PeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu1Fg4f6Ugu6Vvc/iPcwwKdVmpg3Z/MvRghCko/9NoI=;
 b=t9KoNcpmJRMyCg27aZELrfGDhtE4OJFZVcNiJYkv7RlEfiBj+WFoVek1y366bV50zTU2NT6IAyUZBcfd5Kc5DoAUr0diKQYEKmAouEHv3+cPZ7qh1vUvWaG8pd86mb2SNQqPNSINYSyq25YWYXoO4AUqlzKfP5jL6pu1MjCblEA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 3 Apr
 2020 16:30:46 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:30:45 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Date: Fri,  3 Apr 2020 12:30:35 -0400
Message-Id: <20200403163035.19177-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 16:30:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ade3a77c-ffd2-4534-0d8a-08d7d7ec5bb6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:|DM6PR12MB4138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138D470C4351C640198715785C70@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(4326008)(5660300002)(8936002)(36756003)(16526019)(2616005)(86362001)(44832011)(6916009)(66556008)(956004)(52116002)(81166006)(66476007)(7696005)(81156014)(8676002)(6666004)(66946007)(2906002)(1076003)(316002)(186003)(6486002)(478600001)(170073001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAdhll6ZUw14z5/OWw9iQeOBA2CrwbyX0g79gw74ytQCwepAPJ/WGABAWPYnS7PvIb+jq4VLtifAdjH1TgYK5Tn7hm2HNmdKSOt22i0UxC/S/S7nTODNH95RKXDRURsUeQXtcJ90KGzbXhvY7fNl4ENPwUmxpaP2VZP4aCD04RBz7fQyVubbUt+blccHC9VF9ny01VQTw+CLTS59Zinyv73YpA9tVePPb8CnYb865qaOYFNOSYg1D+YLXHOuR2Ijm3zbTgkjgyj7VublgWvt2scVWnC+sEOjhYD/pHX5oLodCYul40anRebIND6wfDR+ElXpUXU2cQP5PpbYQJnn4Md+Wwoq+qsrJEDIosYQEmZyOi05UdjTZ/DCMa2aefbZMiCTIKugYEGxcYTZMf7EMs18VpRc6pQrkTfPFTe6/xyMv23ClUJkb8RIcrl0icKsbSUI4kaHjC0BmHnUHn5ySeq9a+iyGO8VoTakpv8C9Y2jB6SclaHDotcEsLwFrlH7
X-MS-Exchange-AntiSpam-MessageData: uLpcNpgZTbgwnt0Ynf7VxnLemE/g3o6obrfXB5hShHJLJhkWIeHJfKZdJpjz/6ZWQu9BNNlyiBP3OIlbrR3SsRtZvz70WKRKt82oQwZz6x5PQMObSASVfpCEw4eNeb+AYxS4d7rqo28oV3YrSIIG5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade3a77c-ffd2-4534-0d8a-08d7d7ec5bb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:30:44.9664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc1whCV510cDX4zry9Bp/5moqLBAq9hf1BUjS4KnA5/V88u+ALAFoBU0m+Hl/iPKGarhf2zM4HILRcVpwhbyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are 2 VG20 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..9582469a70cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,21 @@
 
 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Resolve supported ASIC type */
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	return false;
+	if (!atom_ctx)
+		return false;
+
+	/* TODO: Gaming SKUs don't have the FRU EEPROM.
+	 * Use this to address hangs on modprobe on gaming SKUs
+	 * until a proper solution can be implemented
+	 */
+	if (adev->asic_type == CHIP_VEGA20)
+		if (strnstr(atom_ctx->vbios_version, "D360",
+				sizeof(atom_ctx->vbios_version)))
+			return false;
+
+	return true;
 }
 
 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
