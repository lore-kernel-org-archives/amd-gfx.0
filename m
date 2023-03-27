Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71584C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87A610E73B;
	Mon, 27 Mar 2023 19:46:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA7610E72E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdUh2gC3CU96YQvDicIwbjzER/qQe1RuULDoYk0fHYcs7JV/OLBTvHtpwGk122rDYuNqBRK6E8nyVsfU1HlHl8o3ju6nSpljl+Kt97QqIN/0oBAikN7gnk30IVf922A0IB6et3qLtaBa1ZctZ7XyvlosMj+wh6p0ybiKypP90nPGgPOM7Yr0F+ALxUN/oeSoB0Ymsj/l+R/3ICe/amzko8zvK0Ty6UoNKPqX2KYrtBmndc+JX8ABvgsb+7IC7co3EmgMOtuX9fNu56ejs2bswQVht+LzdNcr8E32z0q3vuT5ROuEcrvm2ESpBS6KP+pYXfL4lzwm7gCxofwtUbmvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvXFZLKo5tnuERndDS4Dnx1yHl89h3awhpnZlIg5+3w=;
 b=SC2c/zIFSi2uAjlqqk5z+qgsZQwT2vO6MY9XaavWYpxhbay8wRy795+OCi50oldMqn36oHXg9VohygXHYEL3cE68j5vZU1RFLm8slIbiqMwRcr7GgKnOVg2INw4WqhA0+wxCil+YUy2b4FeQPubqxa2KVR2JJLCm26ZDlAdfLVrrtgHIaMHW/CI6vCuRBwpakS8Dt/sZiRZxhII/H8mUikQ7Bbj7RQXvnJ7lbLXuPcCrTPQOQveW+ndPY71NJMxVJEjw31aK46THkGgNZMDLpy4qnlqBkGUXoJLAJGfuQ0X+DNCfAVkP9pZhGox3eQy9jDevBGEtzevo7TCPEX1zXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvXFZLKo5tnuERndDS4Dnx1yHl89h3awhpnZlIg5+3w=;
 b=PWlSyLqyou2DLVNQL4KvwjGRZOaCnZW+MMabvwqx0oc3/LKydYeSWBYSXzObkdV1g1EiTcdn4PHAuJysz+9SNpzvMQXWqD0x2Hk7MPW3D4TW9pv1SV08/n1I+lW8x6LGaOVy4XovNa66IAqyUAcAEOufwJ4UbtUVEHCvwoWTNiE=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 19:46:42 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::a) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu/vcn: enable vcn pg for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:19 -0400
Message-ID: <20230327194622.8109-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6a18c9-7cbf-4fb1-8221-08db2efbfd4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvgICPJeaCk8m+24mQP9CIYtqM9HZJ5uxsL+5L7UqH8hJNiex+o/F97M7IwHMo3NGL022qe/s8SAIKM5LDN8TEmel7FmK6uD1EjbvqAIZ61i6DS8d5zQko1Qh5C5DU/vdxRbdk/XJHkqa7VtBZaplsAmHmVIJXI4XKbooU+4UDjq24amjsKJSN7iIo4Jv8eE0Kv35ZkTATBUz6ihTJrsmMeb+zrc9KYovdeogGOipwoMpvKO6Du/it5ym96Y1MrrM9+1aKz8fISIOkBGQt1gl5HyLi1V/hmFKAwO2ikV6vZDCIHQ2ZmKu0nFeMmlj0I3awKvrEwRLeBA7gqtlQ9uoP9yRrn/OfnfQXnOJB/VGGxlam5cpXF6eAK4s9cltNK3zQGSehrMEUy2J+JRQ6ya5fLDhbBFt2cCM0CP5gzPsAi6oHqfbIF9AEqNAtlrNgKtJ/rr/RFSXabQxX5hGhbQMAYwDAEqFQ5qsZB8pvE4vkD91Une8LOPK7fEOSG0TGj+/uLhSVFaXksgvBzVbmL2wWR7EZA7qfi/wH96yDLvJ4erZ4EiqE+pINYG4C2gTEo6DzgwRFdjBjvnnkDJ9Ik+fqnOJnFDPFrq375AgwYHbCUYOUKi3oQa1hy6ZR8ssXkvzFgmoz5Fr4VlORdvh3/r2FegTHmQPxXp09ViZMXPnI3vNMrkrff9ar410czCY1C+naZxuQCG3EYJTvG9G3fH97yidAgz36pnSOlFgIxLv3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(86362001)(40480700001)(2906002)(426003)(54906003)(356005)(478600001)(36756003)(70586007)(7696005)(316002)(16526019)(6666004)(40460700003)(4744005)(8676002)(36860700001)(2616005)(1076003)(82310400005)(81166007)(82740400003)(4326008)(8936002)(5660300002)(41300700001)(336012)(6916009)(26005)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:42.3635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6a18c9-7cbf-4fb1-8221-08db2efbfd4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn pg for VCN4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5ccdf874da14..881e015881e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1107,6 +1107,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
+			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG;
 		break;
 	default:
-- 
2.39.2

