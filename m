Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED82C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 22:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C356E61477
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 22:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C356E61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D066EA85;
	Wed, 30 Jun 2021 22:03:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D260E6EA85
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 22:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaYdC7i01hHT76rgoRVZEFjPNPohINj0QJlpN/43ETuWBUMWPJykTMZHApZL7ep9wVEOLS5vLhYAZ58Xa1H5BPfP2Y4hl+XqIL7ofUn8dS3JNoQKF6jJkPXfSdPDg5KsZnmwbDZb+5/6OXfzr7hVAo4DAXk61XrooolfImH2yHQjq8afD9QA2BvmVXhaD2gkkj8Z6Lg5HjFzArTz9Od3ZF3iTsnMYEDvy/836P08WgnyC5b4i5KiUleM7u7L04OPmrXL9/QnWDY74jlVaII8oxbB4XoxxFNJaVGaGqwGHZRkfLb0yvX0AK2wjQq/EHFIKlqZJ9fmplRoTFovLRZzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9ASeq4eCvQ/YkSIt8tre0kbheN7C4wbiikakdlcAnM=;
 b=Zghj4JGfByKn1yYupUFJ8UroM/HYepUxVGi1ESjquoMp8hAL+vXj78HgrPEuOhniVdjAG4pNKY71z8y/p4UbQCXx8QPvGE+btBx/qqttTOhGL1Vt0Ia/vBRrHxz4NNzmUf88L+hLVS5GHzr8Plcc1BEiRQVzF0szIDDYhvZwOpOJ+RZqMTS6Dqp9evArNcx0hlffU7VFM/OA1TccPU3INvDCoJujWdV9/0nLN+IxYoSZ9siJMG2INhYMhGr8pqQ8gMWwfUbwSDnZh7gZJrJrTv++nPWW6TQeL1OVQ9yT2/sM/VOrYML4fCgZVR1FMRD5cnbQPB0dY01wMUkvboT60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9ASeq4eCvQ/YkSIt8tre0kbheN7C4wbiikakdlcAnM=;
 b=gxGosMYWqnEUkHEehDx8nZzkpvtHhhLxGcYxkgzfG0tIx+AbygWUmVHnp1rxgH2k/eH/IWjMzFTcsgAVOTRcdoJZbAt22iMLfdlHd7BRbVYsDTLti7pkGM7AT7Jliio+X7pUEB8aJBbqu9GOcxTvtkqHCX09zu1qwRzUOQ6x0yw=
Received: from BN8PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:94::45)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 22:03:49 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::60) by BN8PR03CA0032.outlook.office365.com
 (2603:10b6:408:94::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 22:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 22:03:48 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 30 Jun 2021 17:03:47 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Only apply TLB flush optimization on ALdebaran
Date: Wed, 30 Jun 2021 18:03:31 -0400
Message-ID: <20210630220331.62246-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312d3bce-fb5f-4a5c-0b58-08d93c12f064
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53323A269E326F0361DD146582019@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8WyO/7gz46H7RxR6R3p1XTEr18TXubC9x6JDZWmyLiJl/rC3v9Ctuu74YeGXBZy4hJsGWakfQBHsK7z84rDtLx6Riv/MoS7MO2whtikSnrCW9ZCk386klgXprtbS1k2SgngdCTIOtDioNsmcfPS5jQb+5jaIDJgmjviFXKosAueaPf5dqfajDwxQ1GqJQAbAiKq42ZQQdJFHhAsGUSSKPvG7qNcHjTCCDnttG3eBxvEOmnF+rkJvuCWvBgGSmbx3cyDiUvRVzzpEqCQQ1G1JFhSMKKrg9o7zAQ6LT0Rq6I/1F5la9ZlMKlCB3a0GzUOAFHrJ3onHimzPBOmogk0chThlyD6fWAgRRARi0ksIBrDJjXE7yDizsDx7b2PCt9JoELl3FT4Yg8fjvJY+eF57y65fiuX0QZd7pRD9g7D110kwqY8eOcPJA8cF9pe9nbtN7950PvkWRv9bLTVkn/zvRMDb4FsB9aJTxDpdtAdKab6JovEA5ZsYut44jdhg4Lq//W14tTyyPOL9Kjcaa6oP+uB3qb2+oH2KiRQeqG8iafSKdSbCiOS74ut1b7KmHSYkfKtqLbU3DkkvE/Wk59zbkKJfCuvUNr5yX6pMY06egvBMNfI2d2TvKOpdiEYEGMK+MHS3fX89xGrkx6MD6jB/QLhEOCCpeAXw4Ya/eKkd6Ly6mqmp1BfSLBfH1DhyhqOtsyXPNS1fj22r5w4EyYl3lCGaS2K+52UDSuvQ/hwO+8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(2616005)(8936002)(426003)(8676002)(2906002)(82740400003)(36860700001)(70206006)(83380400001)(36756003)(7696005)(478600001)(70586007)(356005)(81166007)(4326008)(6666004)(4744005)(82310400003)(86362001)(6916009)(16526019)(5660300002)(336012)(186003)(1076003)(47076005)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 22:03:48.9272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312d3bce-fb5f-4a5c-0b58-08d93c12f064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is based on reverting two patches back.
  drm/amdkfd: Make TLB flush conditional on mapping
  drm/amdgpu: Add table_freed parameter to amdgpu_vm_bo_update

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cfaa5f88e630..f859ee7e8c13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1659,6 +1659,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		goto sync_memory_failed;
 	}
 
+	/* Only apply no TLB flush on Aldebaran to
+	 * workaround regressions on other Asics
+	 */
+	if (dev->device_info->asic_family != CHIP_ALDEBARAN)
+		table_freed = true;
+
 	/* Flush TLBs after waiting for the page table updates to complete */
 	if (table_freed) {
 		for (i = 0; i < args->n_devices; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
