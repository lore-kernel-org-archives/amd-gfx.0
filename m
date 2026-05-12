Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54172CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC62210E2AB;
	Tue, 12 May 2026 19:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NwDfbXb8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753E610E2B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otR9ebEqh9hKgFHPvXtCvzS8VzmSTblxTWV3wzAcnx1HQ9ZdCRN53HKJXiear0k5bxZHbAmtN88mgJSkS/4e9Ch4TndV2z9SRLyAxf6ZrcHXe5MmQceceFma5w/5ElU5ByWaYIgQBG1IBDNeycZgUxDgzljKQ1GI5fslnVC5CYC0shs/oE4J+WCHJxftCS8sF0UWq6RCRwhv4s2NeIcpq6LOBSeFE44Vc8HXSWUzJy2AbJuRtdJWcmX+ToXw3zM4Ebjoj7t15qRQYMujGw8Aj7O/QPy9BFz2elyls7Ci6ArOfhTFC7ucwLYLysUSqhlIS3BypgDd9W6mbA4dlNwIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7uS8VC3tQZ3/NotRpJOqXeeBFooXzwCeaJk9A0Ga18=;
 b=gbqxpLOuR0pbbT3QHCL7D6zIsdTnsxHuFWmJe+EPqN12R2aiI9GbR3UxtR1RXO/5c9Pyj1NZIl23VEe3c2ewxgP6GkI4GucGlkU0ZST1nn4z0FpOpY6z2WvUAolUuhlcSclqoy+cBfNGvk3Rw8zc8QajM90tMyu28uPpGY6g5LUEcoqUWjkRWbMtZD6cx7hUxqUREHZNfzkJMwiSk5ufsq7qlNIECq4rNTO/CnAksl8gUYRfQdAhzkoPhKUwei2ngR32SvpWngN3G9DAru24aZciZEIva8NendZShAHZzyarUGCMFPcfmYDN+1NTabKiMu0hSbKEYUDGmiDlX4kEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7uS8VC3tQZ3/NotRpJOqXeeBFooXzwCeaJk9A0Ga18=;
 b=NwDfbXb8rGqR9qTrhmx4wWbxgjooVYxvmfQTYE1pE+ePj27WXmlHycdaKzJ5qga2RzuYNLxE+8Vg0O8qDXyz5YDGaR4OuVopKusgyMlQ0ITs+rE3x9Z2MLSDRUPFPCUxzOhRAliFF90Zf3NK+fh5XmLKvvFwKVDUGIOrL1F4lPE=
Received: from CYXPR03CA0065.namprd03.prod.outlook.com (2603:10b6:930:d1::7)
 by BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 19:06:40 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:930:d1:cafe::f2) by CYXPR03CA0065.outlook.office365.com
 (2603:10b6:930:d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Tue,
 12 May 2026 19:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:06:40 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 14:06:39 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Check bounds on CRIU restore event id
Date: Tue, 12 May 2026 15:06:26 -0400
Message-ID: <20260512190626.3538274-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa7a3e2-e6d0-4e40-ebe8-08deb059994a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 4SPBNbqnhFL+Ssi6gEGRmWTRxgYAuZ/2svu6eCN6GWTqDJxLqoSo27KcVDlB5YQXlHg/y5LS7YkjcC5wkkSNNYrbSCxGN3vqvxvyMvtEQtEQ2bnB8zrUA+IgESCUXBTMhDQUUQuJDzHJj1MinDAO5Bz0EDLuyMcc11L4MhUfXh9FAD8temFz/Jxmcu3u5Ml4c6+Zcl87T1EyOAOWqFwWR+NCWSJ6RYZ+jE8P7V7ErlZaNjBtxyzmzPqZgTk8W+zGxTq8k7sQA1BAZSqyG2VqIjGqEMe7p8fEBXWI4ENIhJz9nEXYCGyHDH6lmSWNhaSlgN96ETFbo/nwrsH6iiafObgMYDWOKLtSN65fVL2Fe+wJ8sTunU+eE1K9Sf9QW5uE3LzSUpEJ965bJdjcUKfkGQG3LazpVFqdF3zj+Nro2WcJbJ1k9cbSxccmc99RXsekBgTm57VyEN6evrvBIf2Gc+kMWeBM2YxcRbycOpI58+aDLHmA9H1phtzahd8cyS0bk88oGscfPfJm6WdkOTBd+cZfeUBmMEipDHQdmax0ZzOoS7veCE81PCDNtT9cEXfwAcK5ZUeFkG0jXvmAeiPcDVCOuWIKX4NG3/gZQhWXEs61A4TTuTj8IOQLnN5QdFj1hJOYo463V46Fh6sSGQZnWZiAw6IAuVXDIs4Ppse+BHIlSGdrNP9xmGbDIjGoFkrMIUQE4eDmDZjcSbqWntE45OqviOuJ0TkHdHkNmsozoBA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QiHoKDSP8J7cqEMS2CVs0gL1W3MxT2Y34PQDKmOAB9pMAOO0JoRIORdtKoitIv6+8hTtr4iBaI7qHvk7qaExWqECqAtdhO6FzufEXPXSpa3MbJZ43iEFNRr5wVm8e5EKzw/fqnY1xzyCWquvXKYj1C+n0U4pRVuYUdWrEKW94zc4eqUsGZybLSFX39FNyGjqH2cXD8Kt8ORlOtPXcslVgo9G7nr3N8eJxxgNLIbk3Zhl7BR0cxrYVgaGjKCt1fhwpWq4i/MQ0tg67HLx+PIzhVUI89K4vI+koNtCCtHq4U2jDhQU9UiHnsgpRK6KJ3du998g2JzKAeV2fxauawqJLpluZxD1VZBCzvwDMgWxDnDOYk5tZek+bOUwjvE29I+B3Wro/SNHvsZng86flAhSnzHRayx67zqNkLpXRS52We8Yn7h0K0Q75sojxEOwPfKX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:06:40.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa7a3e2-e6d0-4e40-ebe8-08deb059994a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
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

The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.

During CRIU restore, ensure that the provided event ids are
in that range.

(The CRIU input is a uint32_t, so it can't be negative, but check
just for the sake of the function being clear)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..2c63dfe8e189 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
+		if (*restore_id <= 0 || *restore_id >= KFD_SIGNAL_EVENT_LIMIT)
+			return -EINVAL;
+
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
 				GFP_KERNEL);
 	} else {
-- 
2.34.1

