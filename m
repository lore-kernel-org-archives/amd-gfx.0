Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E8C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 03:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DCF10E15B;
	Sat, 29 Jan 2022 03:53:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DFE10E15B
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 03:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPTGBt7ePxxBtTZR6cwblpOGcFmpqh0uCuR4WBjBfSvl8iXFamqX7LuO9+OCUmW9neUZay2841rhiOact0sksrp7/R5d/Fu3vBVTExgqgbJjydbauqtD//6n9hlJt864bAtLAlo7txJWnWtAYxRD0OsC2eWJVjzwQEvfPhqGn+QqztgMaLlIZcNbyPTjH8vPdXxC6dPW3sWocanDJVN5ZqMe3fnh9/vX2ivfVQhvNqyLPTuNA2l3FaRDYWh6moHaheZNM2PwhBsJHIBEWtYrkgnzHSsmAoSl2yD+Px085oPLU7bLfxvN0MfC8Jq9SaJs5b/Psxhe03BYd/6O5kIt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k6g2MKrmRR6QsNFLmi22SCajO2BKTpQdx72lR0WALk=;
 b=PVO4iReadk4oRcIJEubnij+4pLlEO8CGT1j4Fad7U3Ad8YYDC9joXA6LjHdJTPKqskRWimjWtP3DvAqpdPHmfAOfjyBeKZoT3m7BFIWAz5Dqy2ekgiJKVNdXTzJfl/oNtY6bSs7XmVA/LT4dOVEouSFez/44si9t3MYysIrzr8CcJ2uYiLW2gphkSj70qrYwTf6hOI1/SLrXbTv+vNw5AnEDbwEU70YOv2aDyGqZPqaPMqP6GgNhb3YBNhkE7WoFV9PEmtx37zV3m8oGQ+22k9N0LIHqbnJWAzMLcdr/EU+pouqK+p85FyKGATfY/p1F8r3DrXyfdPmexsESNpTD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k6g2MKrmRR6QsNFLmi22SCajO2BKTpQdx72lR0WALk=;
 b=0datFJNzNneB0Q/F0ENwQwoB+gDtjmLgg34fZ5BKFoTqiV6dCO7V8WRxjCxR23vkEDgSTdGQGYTvqrozd5HdHmqOnzc4fenx8+Y8/8Sfxg6CYtObv2bFzQT8MDdFp5KLm8jMkx1e3X9vnY2TPn2RtIgAZNVJzgXBqvUayMlJjGY=
Received: from BN6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:404:121::26)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 03:53:41 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::7d) by BN6PR18CA0016.outlook.office365.com
 (2603:10b6:404:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19 via Frontend
 Transport; Sat, 29 Jan 2022 03:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 03:53:41 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 21:53:38 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Date: Sat, 29 Jan 2022 11:53:11 +0800
Message-ID: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1c06d4-9db4-412d-76a8-08d9e2daf053
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB532967C38AE8BE05BFF4506AFC239@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1Qs39OQsY2KBQHKc4zGf42nJWmBchLL3HktF15TerLhfK1IVAnIjaPa6I9kB2MRX52kkBBs4JzJLamqZVbi6Z575t9zgvjRnLO+btTRoUJEqwZKBanReUxuiHFcR0yKzveW8Q6B3xy0bVo9yEy7hFi3tyFNnZSb7C48H4yVHHx9CWana1HnMBWYlWIdKQyvQOKDMbyH0t6sOWz/dLUHkIMolI73GUw7L9zeV5+JEtagVVIgtBarrhN/Vf0j8rzAeGmjnTKSX67Ec85Z26qUJjqdPRTG7bysnKdz3GEaWVtr0eQ5TELdjder5FRPpK5ixnUbmLNojwc/rZ6C++Uzre9gLeX9Gz0bOSD2xjJcPsoQBDsGUBFC1KhWOe0Kr26GCT84FQ4KEJrrKaW5vJRVvmAlc6oE8DZFB3ZoZSchfvEnVVNaL+mtX7hQxtati3eYERkg2bUxxgeY8T1Gn2NCHIGnfuJ+oAyFGudWo2EdW6if05w4NDAb5I/IhHta+29onxBJ5lsgLsv5fWPT2H5btku7/us8san5HuIRHAvlH1wLZJZym1fFqAqF+a2zxx3wzcmYzGQKAZQ3pJT+8S1IMXKPZ4cLleIId2Z2GvNRucc+gziJGHx3L1bw4cCzqNAZrkTvIf1qEs957loszXE2/L6tQ12IHFHdThKsJP7JDZC1FXvSH6FYUYcY/t/1LMSTkFcldoYxjBtv+q7WCAZ7N8812fAYW4YGv08fzbazPFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(86362001)(2616005)(83380400001)(36756003)(2906002)(7696005)(508600001)(6666004)(40460700003)(36860700001)(26005)(6916009)(186003)(336012)(54906003)(70586007)(70206006)(16526019)(356005)(1076003)(8936002)(5660300002)(426003)(4326008)(8676002)(316002)(82310400004)(81166007)(43062005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 03:53:41.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1c06d4-9db4-412d-76a8-08d9e2daf053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. The infinite loop causing soft lock occurs on multiple amdgpu cards
   supporting ras feature.
2. This a workaround patch. It is valid for multiple amdgpu cards of the
   same type.
3. The root cause is that each GPU card device has a separate .ras_list
   link header, but the instance and linked list node of each ras block
   are unique. When each device is initialized, each ras instance will
   repeatedly add link node to the device every time. In this way, only
   the .ras_list of the last initialized device is completely correct.
   the .ras_list->prev and .ras_list->next of the device initialzied
   before can still point to the correct ras instance, but the prev
   pointer and next pointer of the pointed ras instance both point to
   the last initialized device's .ras_ list instead of the beginning
   .ras_ list. When using list_for_each_entry_safe searches for
   non-existent Ras nodes on devices other than the last device, the
   last ras instance next pointer cannot always be equal to the
   beginning .ras_list, so that the loop cannot be terminated, the
   program enters a infinite loop.
 BTW: Since the data and initialization process of each card are the same,
      the link list between ras instances will not be destroyed every time
      the device is initialized.
 4. The soft locked logs are as follows:
[  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE     5.13.0-27-generic #29~20.04.1-Ubuntu
[  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS T20200717143848 07/17/2020
[  262.165698] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
[  262.165980] RIP: 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu]
[  262.166239] Code: 68 d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48 39 d3 74 25 49 89 c6 49 8b 45
[  262.166243] RSP: 0018:ffffac908fa87d80 EFLAGS: 00000202
[  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20 RCX: ffffffffc1394248
[  262.166249] RDX: ffff91e4aa356e20 RSI: 000000000000000e RDI: ffff91e4ab8c0000
[  262.166252] RBP: ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
[  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12: 000000000000000e
[  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320 R15: 0000000000000003
[  262.166258] FS:  0000000000000000(0000) GS:ffff92238fb40000(0000) knlGS:0000000000000000
[  262.166261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  262.166264] CR2: 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
[  262.166267] Call Trace:
[  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
[  262.166529]  ? psi_task_switch+0xd2/0x250
[  262.166537]  ? __switch_to+0x11d/0x460
[  262.166542]  ? __switch_to_asm+0x36/0x70
[  262.166549]  process_one_work+0x220/0x3c0
[  262.166556]  worker_thread+0x4d/0x3f0
[  262.166560]  ? process_one_work+0x3c0/0x3c0
[  262.166563]  kthread+0x12b/0x150
[  262.166568]  ? set_kthread_struct+0x40/0x40
[  262.166571]  ret_from_fork+0x22/0x30

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d4e07d0acb66..3d533ef0783d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -884,6 +884,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_
 static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
+	int loop_cnt = 0;
 	struct amdgpu_ras_block_object *obj, *tmp;
 
 	if (block >= AMDGPU_RAS_BLOCK__LAST)
@@ -900,6 +901,9 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) == 0)
 				return obj;
 		}
+
+		if (++loop_cnt >= AMDGPU_RAS_BLOCK__LAST)
+			break;
 	}
 
 	return NULL;
-- 
2.25.1

