Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A222C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57C1610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B57C1610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C926D6EAAF;
	Mon, 18 Oct 2021 23:49:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3496EAAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DThZ/3/phgbPyDDjmqnoaOD3gqPn8zXRSmNdY9FD1ZjI2GPtz1IP4/o6JYyhAR9vVkn+t80TQym1P5xxuxSLqlOV/gQI/KY7bT+DAcyv0Tq3BFBTvMeb1Khj8xeUmtXgNlNWjWDuepLch3Fd/uhlVzHletxkWFYEq25zfKh5BeTJp+SEBR6JpRM0qMfiDrY8Vyrba3npPYFwlA9YIIbnJXHc4TevINCv0KDCzn7MQtjrMaScNlMuctmm/6vdXOH5OnpDqopzAqxyRMG0oIjTo7IH+frQOeZsR42KiLkxOiAmsBKgByCec+gu4B87yk/II04XmLA3kttA52ZfxPozDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY0Z93Aw546QtLZwrdMDIRKYzz7zkTbTGpaYgZvr9CA=;
 b=TIMUm9+bInjf8X50UuzEGPQgTC6nYReyME8cw3yLdqfMfUf2rTA1Av6wv5RdJwiFm1y+vTZURY6KBLDe6yPMLYmFFJAJ6mW1XjjPTNU4CksPV+/fxy/dRAKt87/+fAqh8xX0Sec/HTu/Zou7JqJZevy+kBAvMUkbJPG8uHKUR9EInz6uKRx0Bh3F0Q9d1Tu+9ZWakuCiPGIUDEdCsY2OOzrvQwcgr0EHA0n9+IIq1MzSC+p0ko5khuD4JH4T/kPyiGlWvuXDbsMZKMxoDhaxzj2FoW+SJ2eanh+63LDjcRJ6edlmnZTM1tgqGBXDhmcMt/uB6Y5zlbJVmeyOxXOK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY0Z93Aw546QtLZwrdMDIRKYzz7zkTbTGpaYgZvr9CA=;
 b=RIzxe8MkfLlqAdbtll/6X0jBhtrvT92CYFf1D6Sg/BrLFcistAGpZFowquRPOdQNBJEc5m6REtB2ZlaIeNDCcI1OzsTKGWvBca1RjjlnBdk8/JOAmnhe4O03jDfJ9nbrafYhwARMW1/p8KIE/HJpSbhnPEwvxPcbhgF5V5DCjjI=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by CY4PR12MB1480.namprd12.prod.outlook.com (2603:10b6:910:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 23:49:30 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::30) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:29 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:26 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH 0/5] Remove 0 MHz as a valid current frequency (v4)
Date: Mon, 18 Oct 2021 19:49:08 -0400
Message-ID: <20211018234913.42349-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f6448e6-c33e-4761-3c66-08d99291ed2a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1480:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1480BF3BD93CF14F6925C93999BC9@CY4PR12MB1480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7n2/yL2TgrlcrIyqie+YS9LaODJnyxFJx3ZyryJ3YDvsL99M0Lvw6VfxUXUrYapyKZpb93X8bmTRW/rF/ixm2UVEbaITL/AA5CK3wh0VOvtUfi2lu1fQS4f9rCtrIP9jgsYJee4wwzoG727kqs7YmqZRWaNc8cyvLjydpchiSxVRULbS59hbQ6fMi3W6eJAJnzk6aKcbfNDj+2yQC1p3F7PiJoWiUhO0BkH4ew0MOpz7TsGtQ5YuH75JgXVgrzjJYkgrQPAgLOuVFH3Hs0sTUjfCkE65IJhsiXKB2Tgkb6v85NQeDtMMOuiXK5LxQsX7Q87lNb+KXMKuO6zufrTclqWZoTHBbjqiXvAIyTq70CgpO5fyFO2FB/2cQXZPDZcLJJVUF2lFyf1uH8n9uF0wTeL9WWtWp20kBzJpIBHDpP9cfwsew2PsNMv87IJoH5yBDOav/AFfXwc12Gy5ummM6cPdP+e37i9MdkkJgwE8fheMsPFmDY+AghYd6yALV67Kj5HIV1A+W4A6K5+WK0PP0GVQX0cJB38k+edydLrwC8s/HgdSqYxyJTyA0DB78so7M5t6w+QTRJLKM9Fa4BUc1I5RAuX1yQ3nNDREdfcty6lk5OosipbpJSyPvcbvJcIYEK+y3rwC80r0jLGYhiy2+2Qhf2ZZth/JL7v3tESR9ErHmTNzjRWzfYuLQ8LUO1K/Agx7MBS978Pu2nTD9DX31TqzD5f12F1h4fJccDrLDc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(6666004)(356005)(186003)(26005)(6916009)(36756003)(8936002)(2906002)(82310400003)(2616005)(86362001)(81166007)(70586007)(4326008)(44832011)(36860700001)(7696005)(8676002)(5660300002)(47076005)(1076003)(316002)(426003)(83380400001)(70206006)(336012)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:29.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6448e6-c33e-4761-3c66-08d99291ed2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1480
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some ASICs support low-power functionality for the whole ASIC or just
an IP block. When in such low-power mode, some sysfs interfaces would
report a frequency of 0, e.g.,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz 
1: 0Mhz *
2: 2200Mhz 
$_

An operating frequency of 0 MHz doesn't make sense, and this interface
is designed to report only operating clock frequencies, i.e. non-zero,
and possibly the current one.

When in this low-power state, round to the smallest
operating frequency, for this interface, as follows,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz *
1: 2200Mhz 
$_

v2: Fix description to reflect change in patch 1--add an 's'.
v3: Don't tag a current if current is 0.
v4: Verbalize some subject titles.

Luben Tuikov (5):
  drm/amd/pm: Rename a couple of functions (v3)
  drm/amd/pm: Rename cur_value to curr_value
  drm/amd/pm: Rename freq_values --> freq_value
  dpm/amd/pm: Sienna: Remove 0 MHz as a current clock frequency (v3)
  dpm/amd/pm: Navi10: Remove 0 MHz as a current clock frequency (v3)

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 57 ++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 74 ++++++++++++-------
 2 files changed, 83 insertions(+), 48 deletions(-)


base-commit: d1065882691179f507a7c6aba0477eb7d1935ebd
-- 
2.33.1.558.g2bd2f258f4

