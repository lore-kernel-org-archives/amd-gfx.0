Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC6C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 22:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51F510E22A;
	Mon, 13 Nov 2023 22:46:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6544A10E1A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 22:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2VLb0NXyPw/TVvzht40MWdSqIq4nGvPInTcgtZHcNtkLwpdKy4MiXZmEzo4xvBfe/tbHgVkG9x/BcVos+rTVyb8uZn0kNOEfb5D2P5r8UH/O9DV0yYIadHpiAbB5mv+1DSA65WdMRvapJpffVC3wZj4WnZUX7wMqGRjeYQ+Me4jcvv3bVd6/MTf8ffPr31XoFtGtd8rFQv0TimNNzc3vsLIBywEMjMZe7rJAOex7oMk4BCenTeDIHZsG6NXZ+eFQjFg2H8bIp6cGCsstF9IG0wglay17NFky1+N92re8S9SfBwlnUkU2bSM6NH1EGnznv3QX3uiz/w90ZS2ri+JjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfN+DRScpPGXkA2uat4yCAdyy4Rv9MQVcwV6eR9ip2c=;
 b=U7VPPUTNHNOnLtBfqdBS2mZFozkQ6RCnA4oD5A4kWb64w6qvav8fwlU8BhUg9vEceizhCrnyzPuPEyLWoP9KZXNhNXnGh1Yvdijp4AYjTgFofYQ2AQoW2ns5X4DL3bskSAFlV7orECLOAGYVddrCJTIkVj+gbRGdFxL081MjVAl3sV8NNzXaYjMPvpmzWxaubiNrhiN66cs/31ivDEMQUO1py+oxRZ6w31AFCfspBdO0cjBqF2sDrwqEi2i4tVtOiF6K5MziEkwm/qKloubnme8WgjV63VeVIeYmiC2D3y1f74nmrDIZjVYP9g7e6Wb+wmQtdm11x6ES9UdunwAV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfN+DRScpPGXkA2uat4yCAdyy4Rv9MQVcwV6eR9ip2c=;
 b=bfiWC5zTfkOq1poi6Sy51eBDwwYCbQKjyAm4EV8LJeLp/2VaURSIa2CLdOVmI1FmwnTuNcrVCNNGrfzT8VLNz1WD5T1SMk/CRUElhnrvHjneZunsY/ekgxE5qj2k1nhkcu/hLjDNfv0WEgUpeSyKWt5YDGmnheXn0zbXpgwT5j8=
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 22:46:01 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::fa) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15 via Frontend
 Transport; Mon, 13 Nov 2023 22:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.17 via Frontend Transport; Mon, 13 Nov 2023 22:46:00 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 16:45:59 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix sq_intr error typo
Date: Mon, 13 Nov 2023 17:45:46 -0500
Message-ID: <20231113224546.23519-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: ae250567-6330-44fc-8bc1-08dbe49a4f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLWefFQ6n9ofHxbInigsWawSAEP4j/VXJ5VpV8Terz7oqHl5+LMTsBTm+tQSDDz5jVjiIz8NDrxY5M4IRqXqhs17XMxgjlX5QNqncSD7ZvmzkIWMoR0TZtiyRASy3RJty/7l91RprxbOVEkDN/FqL271FcED1lq1UD8yNwrEcBJFzxGzbOTUOGBrHzLgZvGSnQDRKH0lKI3WkjHwqeQ6B8izWgdK8s2laDRUw6qCsywPnUNYaDrlBXrZmjNL0Eaz3xyX3ghcj/l7S2eenuhstOzDfxzGxnABCjME+RcPWVA1JiIioXEx/ORiksm+EomDEWZ5nhuJgZ9B8XfoyAGnFPy2VH/pkzAOP3YInCWGO9WmR+wU6l0AIlFojQlFUsrHQhvMdPjXFVOAdaXvkz64m/sZtvlt6jleQCkwdY2vFTLZN/+2CTZYPFD8WXYZXbcTqR3RqhwPeJ4MXB307diJqmqwEVmYLvziQdlwJARgD0GciQ52o47cE+IgDCkkAtRn/rUjQ6Ekdad0JhDDrQ99GznSmQwo7NWIm3owBzgaYr+uV129N6qQEmXXUiklmOTssZHIkBCJ8qYJlyXhf8deHvO0gv1lvl2w28NYcmQy4QT8e2rqND+yDph+7uB2IiruPRXWZyIouTtL02CB8m+fAFvcV0LOWaEct67NI0fwp79ahVi9SiERJPqSKzs0HpViYwxqrd8Dc7C8g/rxR+GMJ0NNZSeq11ywXRzpE/WXbJu2YOnsBwlGs5uxxbXjr5tYCexOjgxslD8J0keO0g8TuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(83380400001)(426003)(336012)(6666004)(2906002)(36756003)(40460700003)(47076005)(36860700001)(86362001)(82740400003)(478600001)(316002)(356005)(6636002)(41300700001)(70586007)(54906003)(110136005)(70206006)(81166007)(4326008)(8676002)(8936002)(2616005)(1076003)(5660300002)(7696005)(26005)(40480700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:46:00.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae250567-6330-44fc-8bc1-08dbe49a4f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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
Cc: Alexander.Deucher@amd.com, Yunxiang Li <Yunxiang.Li@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here the register field should be read from context_id1 rather than 0 as
indicated by the macro name.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 2a65792fd116..41fa85cfe2d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -184,8 +184,8 @@ static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, SH_ID),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, PRIV),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, WAVE_ID),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, SIMD_ID),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, WGP_ID));
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_ERROR_CTXID1, SIMD_ID),
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_ERROR_CTXID1, WGP_ID));
 }
 
 static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
-- 
2.34.1

