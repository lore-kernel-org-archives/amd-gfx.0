Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F39CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC7510E441;
	Wed, 18 Oct 2023 17:42:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2EB210E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/VSo8VTK3YZSJMNGyLEOH1YxVRxNbsJl9UP66qd9b5m3FpHDsG45SRMy1QtUQ9heaFdKh1MNrUVx1xNpheNk3cUoVmxlahVkn6iVgVdZ46hOQ2jaQybgZvMoK4Od3TWNip55fKtByPyCoAV1x0qGMTud/71VSzgqHMEZHEUXHqN9+7BANtncLve/hmCSI5fsbzIXI03lgudO55IO72YwROAbQWOtXfdAD1TSs3Ln6Wb3G3PtYa+p/scegqnpsX1wyMP6NnYjnLdQGFLo7hfSw8CZz1dzhT5rUDjqLaasBfzWmErqiUFVWYGgWI1bixndD6WsvaFj3nuCbfsPs3IIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOR/Y5M4SsPq/uPyRAgLTgR3BSC6zYMhW+LdFYiKjhE=;
 b=XY/ixzJICjNNNMGhjz5VtVMEe3JiyXJ3X3tCuxqf1Hs+Emc4pSHC5ZC/kwbrp+eMpB9aDaOzFruVhygadirPzJ9U55HW4BqT7hQQqfBqEUsjfCKgOW/dbXTDwWxoKyjFhY51xAX4Cu3lk5KJDMc07jj7SJdKGlqbItLrTuMA5OipHCZjJw8VV7lEz5eGO5tVgp8Xgm+KGvwkXxtDLDee5s36TroVT73b6Toal3sAZAiHVzh9XGN/ORt6VxoM/k3X14xZbQPL3fROi0MTn7AVJqNq6avrYd8zJhndIv2b5Ef6o9THVTVnktPkcBtQdmwl15jisbzWAr7SeGKe0swg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOR/Y5M4SsPq/uPyRAgLTgR3BSC6zYMhW+LdFYiKjhE=;
 b=CbdpteJIB7sTyiR9gK9Fl8heG6DfOdALYX8pG58jxXTQIBUgUxXoZZGS8Xuca9YPKbrJxRESc0OzGxWBKie8E0FI4uuIqGlEu3AO6MHw2Q5vwt5PIWFZ9XTCXonnA3qKeI3t5kT2nA6k0sFPOdQrvHcx3Z+AtHYauXxJfj0JryQ=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:42:36 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9f) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:32 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:31 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/26] drm/amd/display: Revert "drm/amd/display: allow edp
 updates for virtual signal"
Date: Wed, 18 Oct 2023 13:41:20 -0400
Message-ID: <20231018174133.1613439-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdb0bd0-cb28-4ecf-815f-08dbd0019dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmZ5hKLp5lsm83tZZhB1Te4PY5ud7TI0GKiZ6jlhQF9dMqqJZk5+z8l+ocKJrZUHP4vOWRjiWhOzv0ED5Miz7oCRxrWNaytz2ChD7kd81ci7/B3W7B7Y15L6gs0rM2LYAU8MFpcDJ8ec71+wKsSIg1dhsbTOlY6nuG68Vd+JfbmNzhL9F7bBJG2MGrBKhgAa1eTcZlba49lsbUIkNiDZUHhjR4pWV+ynH7tkL/kLn+FQuktvIT+ttaS5QLn05DRik7Lo6jV2NOUIvUpQvHepAo7Ih9ra+59LxC5SFyXWttKt9SoMzjQhNRsZfJjusONmnSd8QXQpOYUQ06gjgUhst7BcNBga51sddRFA219DvZZ+jiKVXByIPXAhJco++o6vFDmYWiEK921QuH4OzBAqxolW0yjI/CZPPIQyZBGqGKNvJe/TNUlLgJw0/5kilcgDXfdbmJEQDqY23l7qnIDUdwqknJIb7nP7sW5hvW5tS3lVwT5QXCkEdFkM883yNO+HHAub8OtgWc/wUYy8WaykzsTkcm5wEc/mSo0L5VmpWyaPwjLejupAHQSKdawozfX/bGYLAINbS3GpPcKTalpoOi10cDuVw2EKVdcXnKc7U8F9RC4foYkRjynaq+fd8Sz3cSNXqIH7k8T862JEL1hBVmpQhkyIYgz6hB8sgmR6u8jI1sJXKgw0qnEiw+FJ95ldeUoPevESpDE4P/JXubBJ++ZddpcIhiHH5tiTItE1G9z47g7o4MrOVT+Ln7QxYcbObfRHdIjxUBmtVSyT9bSqLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(2616005)(81166007)(41300700001)(1076003)(7696005)(36860700001)(26005)(336012)(82740400003)(426003)(356005)(47076005)(478600001)(316002)(6666004)(40480700001)(70206006)(6916009)(54906003)(70586007)(2876002)(2906002)(36756003)(5660300002)(86362001)(8936002)(4326008)(8676002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:36.1768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdb0bd0-cb28-4ecf-815f-08dbd0019dbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

This reverts commit 4ad3ee5ccc77aa3f9d702f7b9ad4d9cfeca6c443.

[WHY & HOW]
Virtual signal is not supported as audio capable by DC.

Reviewed-by: Chao-kai Wang <stylon.wang@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/include/signal_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index 325c5ba4c82a..1b14b17a79c7 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -132,7 +132,6 @@ static inline bool dc_is_audio_capable_signal(enum signal_type signal)
 {
 	return (signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
-		signal == SIGNAL_TYPE_VIRTUAL ||
 		dc_is_hdmi_signal(signal));
 }
 
-- 
2.34.1

