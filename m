Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CF3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 05:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744E310FF8D;
	Wed, 13 Apr 2022 05:09:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F6410FF8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 05:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV9GtvBi38Spiw+8q0Pu7wDzwlNDYgbZmoWTg2+tev32Y4z9s/qyi/H7J0n/xvkkaYOaNL7ci88u4KIjP9LXHxpjkF9wvEvpf22sIGskCfpXJG1tX6jgiS315wIqx0GOn848Z/EhcuWzaHapGlIVLvcPH/JJCQqxM0eWhA4dBX33aB4G0QOgPsawFs4nqdmbPJTEgxQ2dNoveFJhSobkrFlX3n3pDfSU9jgkF9sZRH8fZVV2XtzlWeQGzmXfZM6gOWb2XZz6c3sjAlPrMwVb+z0ZWjPM6com2dAd9698lcJqWfeQZ/8q61uM3nhUJkarT6aVUxTdpLR3xMpFnIHuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtXzDxZhssOZdceRqF3n6gae25v0HQcMqxWXvKTJVFE=;
 b=Pg+IPdZM/Wq14PfJqZi8pskge7dsyBoH6Ko6MAREezKCKM+VlQeeOmu33rqRL14eUIBrEbvN29jDgTz0DefYv3lMD/q9e4bLOX5UsuOKMZ6zaL94MtwwJPqreOwHtI1tT5xS+dhxlHTSJ11ZgXJbhqX1npzsrUVLkVZdODqqzwfpqObdWKi8yUijMl4M/0543EF5eXkj9vAESvsyFRklEM7/6rTvIIqd9D3tE0Jzo6NEO8jboGTlr4O48AE91FMDcU3QOoW8b/JvLDRgxIwODAzukcuxx0LjJidSJ7KOtKGQ0F/Ovov3qyETFjl+NS7t5c8tmfmgjC1jm4+w+ZfbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtXzDxZhssOZdceRqF3n6gae25v0HQcMqxWXvKTJVFE=;
 b=VbDZC6EJco47Ab5r5kSDl9Y3RkCRDoAwIw8r8kN2qnvOiXlrHJWxmhGYKGKeOD7dYpyYpBqHMPRnjBN0N25Lkov6mSiumtDf/ocU6TZaDtWI5aMneOoJpw4BR9gnat4lheDRDNV5QujgkH3ApHew6Xv8Iz3K65ChC4kTYc1nA5E=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 05:09:06 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d6) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 05:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 05:09:05 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 00:09:03 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Date: Wed, 13 Apr 2022 01:08:45 -0400
Message-ID: <20220413050845.24499-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ce1017-f9a1-46a3-fc13-08da1d0bbb60
X-MS-TrafficTypeDiagnostic: CH2PR12MB4184:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41842A8AE7B7E5C16F3CC15AF0EC9@CH2PR12MB4184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkmtH0E4vpGrIU9jB5cmojx+3YzWiaAjEr/KWGw9NibEFyuiPEi+q2jJOyFOh6t1K3Uf6NRIQTDs8smNJ47jQTGc21m1ImflH3qHGBLIuO7kgx/QFLEzE9TCEtPWLl2UkYAzDYmzfNoAqVIMSA/bmXBxXSEDwK+C0j5/wZj+lTgtTWG6HzcK/2pldzjvPqjmnLFs3JagG/KAykosMSvH5zHskrrSmxPH7znMsEGf2Gur9LWtSk6kek0Dy3Xi3RTsDxHIdI06Tg1BAnvn7ufwZ/zBGZipS5FgCMn7MoKzJGthCK4FBM0AZ1d1pNyNWJ9p/Cv3QSQA/5GlGm5Rl21mMMienmDWXNlzsH8sxIRl5jUjqwDel/tsFdoyPfxGJ0UmSB9MsEBE8zBmCN9Iqz/AcHJ8gm3uAHzSQMxJRbJTijkV0pbAzyyWeTBFxI+yQDyWSJcMf1k27Hlr64r1z0OxGg4gXyygkRtvggijWpY152IxItA0vNsBDuQBgO9xtyExYiKrME0PFrl8YieDd8cl6vzewBNk6qyYBkRF9Piy+qJOJaazx4Ac7uERl0NHlplgzaH7Mb0i1dbeGanIGsqp4/FuQq0p490PSEGernOgMWjmi03poAwDxMg/LIKvHHGtlGBfiqqM8qjgaSIrBRqrJtDQ7IB1dEsC0G/AKMQc59DOgl23WWGAd8nuHyIpe/PI4uwQStTYOC9reIJ51cEShA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(316002)(70586007)(86362001)(54906003)(426003)(83380400001)(508600001)(81166007)(356005)(6666004)(7696005)(2616005)(4326008)(6916009)(8676002)(70206006)(1076003)(8936002)(2906002)(36756003)(40460700003)(36860700001)(82310400005)(5660300002)(26005)(47076005)(16526019)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 05:09:05.0168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce1017-f9a1-46a3-fc13-08da1d0bbb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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
Cc: andrey.grodzovsky@amd.com, pmenzel@molgen.mpg.de, lijo.lazar@amd.com,
 luben.tuikov@amd.com, Darren Powell <darren.powell@amd.com>, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clarify the smu_cmn_send_smc_msg_with_param documentation to mention two
cases exist where messages are silently dropped with no error returned.
These cases occur in unusual situations where either:
 1. the message type is not allowed to a virtual GPU, or
 2. a PCI recovery is underway and the HW is not yet in sync with the SW

For more details see
 commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
 commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")

(v2)
  Reworked with suggestions from Luben & Paul

(v3)
  Updated wording as per Luben's feedback
  Corrected error stating all messages denied on virtual GPU
  (each GPU has mask of which messages are allowed)

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b8d0c70ff668..f12319883a80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
  * completion of the command, and return back a value from the SMU in
  * @read_arg pointer.
  *
- * Return 0 on success, -errno on error, if we weren't able to send
- * the message or if the message completed with some kind of
- * error. See __smu_cmn_reg2errno() for details of the -errno.
+ * Return 0 on success, -errno when a problem is encountered sending
+ * message or receiving reply. If there is a PCI bus recovery or
+ * the destination is a virtual GPU which does not allow this message
+ * type, the message is simply dropped and success is also returned.
+ * See __smu_cmn_reg2errno() for details of the -errno.
  *
  * If we weren't able to send the message to the SMU, we also print
  * the error to the standard log.

base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7
-- 
2.35.1

