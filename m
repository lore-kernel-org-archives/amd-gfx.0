Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD41C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 09:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44FBC10E74D;
	Wed, 10 Jan 2024 09:40:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6575310E754
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 09:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei2YKHHIJ7gokVUHMX3ksJ+qXns/Zu2tdLtgKaVPyAEXRSwHGP6Yq3jn7N2PLFk4fZYzWklfkI6o+/HONQCri2Oa/TpXOKAeaqMVHBo54RKilmMnApiViH1KFJ7gcXv3nPDH0nBXiRnjG5oPrJstd0sllUVgCOs9TxDZ8KOb0nGf9WwmsAImNuErwqlK5Tvpegabxu1M46aLZDndN7DiWKmuylv6fwtllxt4OPnetiDXVVr9WXRAvN0nJVpq4B5qsG8yogPDIcL+kO+5IWvvDWLnl9YROLobNnNihtzo9QoM5bmDKKIwdjEyHt3ClorWTQC/mlSOawA+CrMTeiPujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCZKAeN5d0M/tRuLJsjsgzKyVEZG3YkFn7RtWGK/SNY=;
 b=Yq6Ix4FZyUWKEXzrkb4kC3dep1EaRKXRKwcIC/pdDlvbvpvVEKMjMhMor8c8rHW/DGmxo/7cktNm8udKGMt2MTL0NfcuBsUyPaN/VLlfkWp4mhEB5Wgn0BgRwJRnfIo9xJhWTQOeq8KuYpWytJy2HmyAT4YI6w2VlZlfo14ORLb8kJUNCDYaaHXsiZteRKKwPOZfBc2KB7d+Ew+7bCv1als4cQFcuwVRL8O5+WDy/btwEIozd0BYkwi0b7lNF9GTM99HK4GVl7fCa4OWfl74ykDc6PWYL1LohwMW6kFcbL74VAlA2RMnRUO+O1+hXfJldEhHkjmC/YALyr2jaZMbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCZKAeN5d0M/tRuLJsjsgzKyVEZG3YkFn7RtWGK/SNY=;
 b=u08kTh8q7UoJHg39bYtlIR6/6j6gE7krba3LdHdvQbGQLzPcFRwxg8HpkdXBdx4wKAo9oLa3Dtju0TP0yjWbxDjrJjz9FzqlFRPPGRf3guZHVJcFPSAqqq+Qi5a5PPbdkqbydQFROaO9FIoa3Pga8L5qLyuqtqUH2Ob+AVKYsok=
Received: from CY5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::23) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:39:57 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::5) by CY5P221CA0022.outlook.office365.com
 (2603:10b6:930:b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25 via Frontend
 Transport; Wed, 10 Jan 2024 09:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 09:39:57 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:39:55 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix the shift-out-of-bounds warning
Date: Wed, 10 Jan 2024 17:39:38 +0800
Message-ID: <20240110093938.684930-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 897dffa9-9631-4cd7-d123-08dc11c01b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9n5xyC35z7FMq3kGCmv1APd3GMqR429gkRo5ytm3VA6pxUwSg3Fd0NpOARu4HPpFe4W0GDu0xsjpYYlggQE2WOnj2S2WXx9BHvdc0hiNoPYXouE7ewPAJB8D7SuInuLKSn8vVCJ+S3hwcKEOMp3I2CCxPFboP90y+gv3HcB14MNSrjj2yzHNOQ4eUS1FdmFDUBHWzVNM1bklIjvMR9wMgw24YnxzjHRi85CEQoDZ8yhcaNrwaFEvF5cFFYd+jMIB5vq+axclnnZBGn4RWLtzdrZQhwZXjZLExxDGce0CA9NLfIeDG6HnjFUWxrDLA2RWBluJP4tPtt2mDEfxZMqnqTXdbT1lKM7n0YO19Qfr426TFUuwHn64s8f2IYHh3Hod80IohZl58Lwz7MMKpCz2XtV5NIKM6n2ew2nTVMYRK0/llx/ZQjYj2DkEbF0pIO/5FbbUJ21NzPWeS6y42PI3ibtGKXNCQRiG2oLvna966TnDqagTCZWYiYiqJK7gUKz0blAHhw6mhy/ZycgJnyqcjmNpdURACuzdqCu1DuZ9NttTGin1gMcCap03qMSDP/8bXcgmM+WjoYN0IDScE5nPC3W2suG+QxocrR5VFa/ttrd+W4JR6KLA5ZWx1WjjMaM/dOwlyFQElUKfBRT3OJsKnI/RV9ygat8Mjp3J0fztl7BtDb9fd/LMXC6QafdrLqv60/lPlgQp6mDfnFjpBKGjjEQPtQkn9CfWj+pz6HAnOFRcGbIHBP2v3Eu0mxx3BE5eu9oJm6ZjHNMAA2Bi4YEhRUN6NTdbLlURCpELnKWxtUghpJoF74APlL/W4tY2Wqm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(426003)(7696005)(2616005)(1076003)(26005)(336012)(6666004)(478600001)(4744005)(5660300002)(83380400001)(316002)(41300700001)(2906002)(36860700001)(6636002)(70586007)(70206006)(110136005)(4326008)(47076005)(8936002)(8676002)(16526019)(356005)(82740400003)(86362001)(81166007)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:39:57.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897dffa9-9631-4cd7-d123-08dc11c01b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is following shift-out-of-bounds warning if ecode=0.
"shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2aa88afe305b..129325b02a91 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1004,7 +1004,7 @@ enum kfd_dbg_trap_exception_code {
 };
 
 /* Mask generated by ecode in kfd_dbg_trap_exception_code */
-#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
+#define KFD_EC_MASK(ecode)	(BIT(ecode) - 1)
 
 /* Masks for exception code type checks below */
 #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
-- 
2.34.1

