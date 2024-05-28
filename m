Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96526C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FD11123E5;
	Tue, 28 May 2024 17:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exF4hk3R";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B2E1123E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h888ofZYjKXH4PAxXRL5UpcuOIP1D+2YnH9QWklxKZovhMJy0IgekNdcT0lDZtrkhvBZsjnEhAynjkSYaxdEoYyNlB4rx5GtyvWVDmdLSobUN6Leaj7s7m/t/X4IH0OO5NZ16qZ870w4PGKU6bZfKvVrhxuLGpAOIFh3Q/Ly+dZu4WqGWS5aNitaOgUou2K7YXXSoAmMwarjyW8ZJAlPVvSmZn1/8WCEzHbaEqbFOAdvaohKTiWLnh5W1NS4gGG6REzkv6x+9tJ4wKZgfyGdpzkG46TRk+UBiqFjZx08G/VmYo+09YhYMCj5Mds1TB0VT/3FJ+2aW3y1nh/O2Y4spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rWbwila6i4rI9BeQ8BsQkk7lbrv1SeeaUh2sJQhTAI=;
 b=I3uCQY9lGIo3m7UZCrO1dDnXWU5OYS1apnfs6kJaQdqzzGAQrC3PmFUE7VhPd+AuLk0SpRPqO80Oy3DzYLWxlN8Cuqa+qKGmN3mbvKa62CpQ3aZu774ksbCDNkpdR7lc624JJMQ4MNAiqqK9nxWNJWiDpMQ2+U9HYFTHMg060TFUTHl+dWzm7iUejsiq4a5qHQ2shAMG2lf4uirLEArxWnHcvDeCLh5NHpK0an262gzKaVkOkbnC4DBiK68gmhmC0COo/TiWK9cfuBzSIXM0jCaDjyy/R8CnrEWnhcEMH9BysAmQ3PTIvSQDLY8fZVjfntNp2CcAljuIF47SfOd9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rWbwila6i4rI9BeQ8BsQkk7lbrv1SeeaUh2sJQhTAI=;
 b=exF4hk3R2dnSCEQsWUNmtu8ebYEIuMw9S+8r7ORUK0n0HHArh/3ixREjY8yoALxQ5U1nGuf+vFjRlslHk18FJPHoa5AJZlGaGTZBTRnWf/ydR0veiF/xCChw+G37ZUHh8Li3GzFOy60QdCS6lDLU30lxG3QnLDsfpJr/U69Yn6E=
Received: from PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2c)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 17:24:17 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132FB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:17 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:12 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 06/10] drm/amdgpu: remove tlb flush in
 amdgpu_gtt_mgr_recover
Date: Tue, 28 May 2024 13:23:36 -0400
Message-ID: <20240528172340.34517-7-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eabbbf-cc95-4b64-28d9-08dc7f3b00df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E/20kdys7hS1SV5vH0IjHLO8JZN5CeIYsIKukVQvpqNH+xi041kc8yJ0OLOf?=
 =?us-ascii?Q?E0aRd94gO+XNDF5EbCtfes4q6RW+ei/+GaF41y2d+q3s1jNa9wsh7MYN62rJ?=
 =?us-ascii?Q?kr7dg58ydDW8cgu9PMCiRUJf3+tNwDVOQQXkDNtT4JX9z/zVnt1PGQRg+fB7?=
 =?us-ascii?Q?0nYAbljv2i/xzLPEEYjFnzZGXQGjg07gmJfNiWY7g00nFreIFSc5HuQQRA3K?=
 =?us-ascii?Q?sxFy4fwD0QYRBDvO2NNN3pGd4gGpmnLZH4R/xXDbtGPXWPEDubPM+7ESsAzW?=
 =?us-ascii?Q?KddokjXbROcINEjsr02nFgcLoNMh3U5vIJEJFtqIayd6YFPYA6in3JOoaJY6?=
 =?us-ascii?Q?3cA1gSNWvRH0SPWP2gHN1sXLjS6HHDrvsWj41YcYqowDncbbK5vYbrVQYQoa?=
 =?us-ascii?Q?WkX8liEzrHykG658wBlSTCTlUJYRhe8z4EV7cVld8l738U5ltHA24zUrZt+T?=
 =?us-ascii?Q?JcT0pavo1Sr65noKWywPSQkC57ioAjDtfsem/kr11KEWWz9j7U20eJ38aDvk?=
 =?us-ascii?Q?6C98XPoEclv991wp1Ljmbh6RIfaQkBwMLy+h9cW3ED1TL/t8wp3bm0Lrrdft?=
 =?us-ascii?Q?w6xf1zmuYSt2CJeGk6zCTsOkWaPvoPGIKzyzzKY0XkqiPVk4Ni7FFZ132xq5?=
 =?us-ascii?Q?VzKQsh6EEurDdyd7RPE86KwxaU+jTH4XLaUijFrc64wqiXF/O161aEinuKH/?=
 =?us-ascii?Q?lS9PDXPP+K+02bjjdTqpPY99dZhCqswy1Sg3vx4ywDKzoxeXJj2Kev1RUkk1?=
 =?us-ascii?Q?hvbBbiVsTmMK0A1mGkHZLUOZasULRHHdk7+Frsg7wNXkuCFjiq5xC6xEedkO?=
 =?us-ascii?Q?pu2Gpox3C/cUWzljxeAFn7zfiMP7d2PJloQUjPg+nG3+EFPjdj7oZnm/0pa3?=
 =?us-ascii?Q?/m2SDhBu33WzttSdiKOeMiqErPUFqo3aUx8rZlHIZK7LoVB71IJsrywU9JTW?=
 =?us-ascii?Q?p2+pT22sdPZjgId+H5qzohy2HUujkUxilrQ51YlWxGeGRGTvMr/1yKFLSdCp?=
 =?us-ascii?Q?9oDf6AxdlC+FULhLnr6xT9kCYrQ9Lq3bqLofUPKNsLIrDZ+AM81fOalUSkvX?=
 =?us-ascii?Q?PnqLmugHEywMB/7Q9vBj4S2gCRnqoIiqh9MIaiC65ppJC3zFJC/2XvR4qJLv?=
 =?us-ascii?Q?Jb06ElBTMFdN0fWEop2KaR4CvkeMEWyh40mE+7N01/6T5aa12ArrB8Pt7Dys?=
 =?us-ascii?Q?pAMbiEcf+nL/Rl6Iom6H15znruqEuoLsFodKEkr7thgEJwwhIupRtkCvnv34?=
 =?us-ascii?Q?d/IuZPEq7ognug/y2djc4F/m05PxTtJf0ult5M/GiaKh6t+awJpYRvWZfOAI?=
 =?us-ascii?Q?lLiTJ/qQoTyHmKJvUxVBT8WzzLqFY4qsW3rbLBF+R/CVPPfKsMHQGDa5Sz+M?=
 =?us-ascii?Q?+E9P8pzw2Pmcft+EOI5Cs8Uy9irZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:17.3253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eabbbf-cc95-4b64-28d9-08dc7f3b00df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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

At this point the gart is not set up, there's no point to invalidate tlb
here and it could even be harmful.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0760e70402ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -200,8 +200,6 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 		amdgpu_ttm_recover_gart(node->base.bo);
 	}
 	spin_unlock(&mgr->lock);
-
-	amdgpu_gart_invalidate_tlb(adev);
 }
 
 /**
-- 
2.34.1

