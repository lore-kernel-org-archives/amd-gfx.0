Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5CC5478A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 17:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532A210E139;
	Wed, 21 Feb 2024 17:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzcMN0FH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A8F10E139
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 17:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/gooE6LQFY8vGvEObxuG6W7XhYSS1XrF/VNJpk5zNAMKzJOqbnoaExbhdYO8a9jVmNEm6wa/2IJ5DwdThXVdkxIIuriP41R9H0JSGsTjn9gWesPqP6h9VDCaoeguAmR4s0EIdrA+dhmAr0JGPinMrqkM+O6FhC/23tfhqK5fHUQ6GmpQlHixu6mDF3zSuz1gGWghtrpvozAOKXmi0x/JZlkm5WLloDpmT1YG1Oq0qn0dBE1/iUK7klXygwcmIc0eqav3hopBJbjna95QQ2V18iNJ/09sLkKjxkCZMb/DbPEqdNsD7UBq4HFP/r9CgUoCI07N+PCmSwXfBLLJ3rOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnE+attE6Jh8F3WQtzco0SiRYMzBBobN8WKmysphEgM=;
 b=nIaqbasmvLvFffhErPu09rBsP3Sv5J1eI/99vj/D5HD9OmyiT0vDzJBVlvSjNQMLz76fw4vn9Cc9vmwjloXLuOfXEhKE6T44l8IHppsbaRuavzGSopcH7zo7j6jowvVwNYlRpNZ4zsX+XosnWkVkG/q8RNCyTDYPBx8n77BP2FToBhPynL8H8qyCW7oyK8tvsBcT++aqFm4svCckAd6tfuJGE+yZDu0vEEPYUCe6FUz9NsEQfAH1OuBkAXW8DoFo7oOaqPTEVEACcRHoq/3pXT9vFDnHD1qpQEfptjpX3cRqIYxoyRyyY8j5bzttSvN7N7YmhFQgUMV28mZO+ssQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnE+attE6Jh8F3WQtzco0SiRYMzBBobN8WKmysphEgM=;
 b=tzcMN0FH4O6t8T0qlQhuL2v7wyc6VC1fa7IQlWz3SXmScj7OfN1xH0YK7h6PzGJXitquycNJZ4yzF7w/HWA7vHZ2TdpeR6M36YdvC0lNZajnozovXuXIHk87PHaVq0VMeD7/vLXVXrUrL6WSAOw8oeGYVKQJhnR73OLg22d7uj0=
Received: from CH0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:b0::28)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 17:00:33 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::7d) by CH0PR03CA0023.outlook.office365.com
 (2603:10b6:610:b0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 17:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 17:00:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 11:00:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/soc21: Added Video Capabilities for VCN 406
Date: Wed, 21 Feb 2024 12:00:13 -0500
Message-ID: <20240221170015.8866-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221170015.8866-1-alexander.deucher@amd.com>
References: <20240221170015.8866-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 57692e2f-4b88-49e5-f59a-08dc32fe9bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRaMg14G3TjaAtxlwYH5q4IKulr3gO9EA9s027UstZZM2kgdbvuBxgRqiQfpt1fwzEOBYNCJd6OkZBrB8fdGFkOZKvrl0weMZzmQ6Rgzj1q/ZjMCJbrfM9VhZ0QrbEwBv3WeHxGIcD6DgmleDzWnf2gx79OjdhTitaogqiKFO7tQFostSTj/Ox4Cr8NJLcuzuJL+iU4j6lXvyjaozioLZKUy+B5L99ibRVlsicUSAq3rF7C0H34DySmtlxDJdXcCHcfT7vlJwiz2xd5VVxzXZzeRwfAsiVwdM9jarxGfRdDMstQxLJWo5i7Seht82HWCReVDUIAfbr+BBsIjct3Gxlldyiuw5QoZPLYx+lw3R1DSdy1o1UDeYcgX2s0Uad1kJTlaI8PwlzwovgvUJHKrk2ZWsvCxP7wlI4VRrW4a5J0fPOIYxFcoXoQMbGFr+OuZnsjzLgZUR4aYz3GzKeWjC978VmSZ1N0GyX7Kq0JQo5p/0IZRHelc+/J0ezaEFTCCAf5/d1YllddgjOmYmZN5/mo3AuVppB9Rr8CI0P8w/JxPvZyghrixI4/q69oW0kP9yiVdOgszppp7mx52P6kakfnluLYgy0DqlgL9PF1wRJl+mY5t5/TZ4M0FRUrVxftu2C4jph/gk5nUAjRtULDCMxan9K/qfDUAFL6W8+BDeDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:00:29.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57692e2f-4b88-49e5-f59a-08dc32fe9bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Updated Query Video codecs for VCN 406

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2c812701592b..c663cf3a169d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -185,6 +185,12 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 			}
 		}
 		return 0;
+	case IP_VERSION(4, 0, 6):
+		if (encode)
+			*codecs = &vcn_4_0_0_video_codecs_encode_vcn0;
+		else
+			*codecs = &vcn_4_0_0_video_codecs_decode_vcn0;
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.2

