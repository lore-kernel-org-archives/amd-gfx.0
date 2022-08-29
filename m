Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C24ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FF110EF81;
	Mon, 29 Aug 2022 21:16:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBDB10EF7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfrEcbP9rqaVzTrKdc4Emy3pJe3cnPClGncEthh4UOdAqmdT+L92nUqk2kY+URzV/I9rzXhH2a7GHrzHN2t6Tc0jnddaL6Cyzojshe95tK6MX5nPhIxfm5/AXUXiuzdLDvPXdFQ2iXRL/YsgteV6S3WCLtJ9G5J2OHkLw49wNsZaJK2pdmExqMCJXULwr76Y+x3RSD+V16bZFLu11BiALtmfPamB9tZuyvVojQLq9YEJkdAjhCZWp2HUcKlU9xAwUZL06p/0SekIicuq2TkKE8NLlRdDzUgIki4kvYDs5kJIfsppfdVByjIlsWS02KzhrMLpyfsVHJ6UIG7sqoZ9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YixNVC+j8hKMhpd7w1JJTDO4wW1H0sIOvetR/9JzWpA=;
 b=LqmdJslpunUfuffabz7Xd2eAVnc5utyvZNU2AB+SjRxShtPkKqGfm43zK595z0qgxbfkZVz9lxiEGn/PZORSrhg9AWphZaNcZ+43bIsc1mX0Z/85O3BJeePevOG/AJRu13bGW1iyVu5E20Z9gkEftzEeNNcbjavSsawjVXYEmKaqscXbjv8pwVBLkRqbEG79jpAQ3pD2daSkIt0U6ik6xBQSCVJk/ND4Tb4a4MdTkEDubc2Iq6d3F9BpvGivU8bNoL5xVcwyUqp5Xi2Qhgb/YXKjMM/j5xmz3iwI689bzMEHGKUMJYK/w/osFJMLSS6yV9QUYBU3ELttd6cw8Ik+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YixNVC+j8hKMhpd7w1JJTDO4wW1H0sIOvetR/9JzWpA=;
 b=k0+R7zsj33YbVA+YDcaChYwhyJg5y0AQ86WV6aBLC1evPY50KW6lNK7QIZyOqzlQ+xiGUIKUnRVxD1rqUB7oxqE0SDO5geeUGqGIOLi7HWNJoXwZBdzyg6v/IGZgSWLH43oYc+yTTNZvpyu45v4Ou5BKwWsNgw3LvVioF4z5LEM=
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 21:16:31 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::36) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 21:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Mon, 29 Aug 2022 21:16:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:16:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: initialize gmc sw config for v11_0_3
Date: Mon, 29 Aug 2022 17:16:14 -0400
Message-ID: <20220829211615.1152396-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211615.1152396-1-alexander.deucher@amd.com>
References: <20220829211615.1152396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1daa8220-a5d9-4a33-baab-08da8a03be80
X-MS-TrafficTypeDiagnostic: DM4PR12MB5889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSN+2zwIKhh6tJte73D3VJcahTzNtXLpcr7lbnaVN/SfzrtfhxLcMMo4MCLoG1ipog3/sRoLRAmQpE0FgeuPgBwkv79m56vUQpp899NoeRFknoqHriOoiA/1mZMwVh8ysukFPDGy3y3VZNhiV8SJjkol70llKqvWX5cj9/89VZwB7L+7k4lbJsN3VYFw34jxNa1XO9mJYbx+gKfVBGhbVg3Xlu5SlZHSnY0ykDHEq8+1Tig/VcT+KYS0+noJcgqdcP6nKh98BhgTcLhy2ZiGbmQwkzcklsjp4jAHkE68e8RgsDXBKt3xXFZywNbJdui9ULiL7eTyRGgV9BFvCSSiL2oKtILDImaV+ZhxWxGHVJvDMPPUb6fXERx33kIQhdQaKoBgPKY8lfxy1jQzO7fklmWOaSqWdbz1M7tR/PypM/Sy23XWZBgoIuLBrU/REiaj9K7HU0LBJRIwh3eCHJ9Zheo3eYMmb0N0l3AOY64ZhHihei4Bl2eMBNH7bNtr+f1CrHGBkJPpBHntPHyGndVmQAUEsIrIROpEU3FVLG7lt/8R1ltltxnzW3nNXAjG3HOnCur8NlO9EPxC8X0W3C5f9/DTZa+0i0DWaNXjM+tIQofXOxAF5UzJ7N1qUcB0WhBJhk1e0GY/w3gh46GOzFq3UbGIGUGEAjnJfjAoVnB27va3Lf+pbVDyLPLnvF8Sis1iPrxi39b1Kh16ZbPzAb5gI05NyEmshvaGPPofURWdlkSZmo7vjGWwh0Qk29Pp3QW4Bw4zps1VKgf6izdpOWeZRF1LqHt1rWb/QxdRwSKxK7p9wTB3WRrRt4bWNy3A0GAt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(1076003)(316002)(81166007)(6916009)(54906003)(8676002)(4326008)(86362001)(40460700003)(70206006)(70586007)(5660300002)(478600001)(36756003)(356005)(41300700001)(8936002)(4744005)(6666004)(82740400003)(2616005)(7696005)(2906002)(47076005)(82310400005)(36860700001)(426003)(336012)(16526019)(26005)(186003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:16:31.0895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daa8220-a5d9-4a33-baab-08da8a03be80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

initialize gmc sw config for v11_0_3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 89710a0effd3..497f52283a30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -740,6 +740,7 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
-- 
2.37.1

