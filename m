Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93338C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6010E8A2;
	Wed, 12 Apr 2023 16:26:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2F510E87F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGZ1XiGuoJXEO063/b2vtfTNKRKuymuGi4mH8zAijLWrW0evH4gMK/0RLdHYCfJ2wg66jkOuEjsAK7jbYXxginCIGZE0FWXVx72xaQrM12RrUnbXLfl9fusHUjnPsxejcQXDZDAa3HEMQFaDjgeSivNn3C4MV7bhFEJLaH9EMIxVgs9r4sxl9abSrLazhipldUHixo1sxzK1Kwb9QinGw97LAqtnXXIqWccTtNxKpYjnM8r5qqvHZlG6kMb6Fy8qvZKIeg+Oiet9gnJhQ7rMQ3yFq9goSo99G2cW+8lCXCibTmGgbr/Rw8dB3YHPklETObVP0JDNSSQ0Etj3C/4rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3TAc0WIzAa6i5czwX5ijRKqA6TUbV+LCuZulOqWbSI=;
 b=jJVzNOjq3WI5XK/WvooIrzQ/FDqqOKsRo1JcVgjBaJDvwy5a+kkoLGzvHC7A5/1I+Dgc8HNelUfiCclg4ouwHSjCZyJIAHGdWpV7kIGsg3yjQ1ZOFwMPBVV6FHt3Uh+PqlfWVWOIFdWenu6y84s52q3H85k5oxqiYgpoOL0bgZWGK9mwPrrhFWNFyRPAhZ95i/Xr1qkAFDWfamiqh8wlh3knMA+t66SzfsFTjTjYQOJvgAeRC7Wdpgo8ii54b6fnQz+lLD9vROolnstF+TtPPuDqa/IMHI/ytSwvdZXOPba+tuo0N+Wfsadxr/kwhyY+p2uAaOAKV/7tGpAB1v7Pbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TAc0WIzAa6i5czwX5ijRKqA6TUbV+LCuZulOqWbSI=;
 b=eyDXzVl7qPmdwlCdlShnXYEClAifKBQoUXHQuQeG2nWsJuCF31eCmoc1p/aJkbhdgjgiUc+VwuEZdo+EC5YzgYRfmhQcjEdCCp1omKHFQyxQzb0JytKYVinEmshtUfGU85KcJZe1vUcnLWP5XVZhPviP8CoSxrwvakGJwOG0hhk=
Received: from BN9PR03CA0442.namprd03.prod.outlook.com (2603:10b6:408:113::27)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 16:26:30 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::5c) by BN9PR03CA0442.outlook.office365.com
 (2603:10b6:408:113::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:28 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/12] drm/amdgpu: initialize ttm for doorbells
Date: Wed, 12 Apr 2023 18:25:29 +0200
Message-ID: <20230412162537.1357-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a1ba31-8e63-442f-4434-08db3b72ac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQwbM+EASjpG9IzK1EH1Cz9+8qJp5LNVVDxuZCTZVhO1EzZj2JRgiqcc55QeO6BJPlUFDet3M6/184dF3hJQTU6ccdiFIuwtR36uWQcDuaSBpbLbv7td3LrIrEdlrf2qYGb77qj3Bcmd0lvu0kK6MG7pvhrD/UGtCRKScLPfbgfbVveq/CzHNundJxZrRokPQ0bsVa3qR6CkVd6YntHePS+vgRwuLmUjoj5wjwZmLL/337zuAKtYXYBWXjQnU5XasCqWlndShH2+4GQ8hICSy6llMhblREqTItKeutiWZEjbkQ00nOF3ADiSJ9Et8fsBXHo4OhNTt7nHpmRRZqmNZgGQLCnSc+GeKF8iERbMX5laV8hcYqBsKVjAkRDADit8n5RRrk2NM5Oq7LlW27z2orzzDaGHogPqQarQJyGDNQjwviHHAJdtrjbysVP6WBfjK1MO0Yu7334kZG3BE12M+soNkkb/H8mRSYpdm4dGPR9JYaaXV0dRAR5PSxYmM9kJiz60pyWdee5c5HKAr1eP0L3um3wAr88OzBhmz8Ma6XzrXPDEIV9jBXgS5anDezxzmMvueuujnxyFpkqeekZAXESYs7NT830I6JKlWUn/Ardzg9/J4vfrIyepQPgq6YnUJVdUqF/Q0jIZ+QkCLNCrY+oxqs9NoaygPb7RC+ynwA9q3c+jLnnwOYUJFpljNFjoJyjcUulfXjZw8EO2wiPTT7fJOCEtqQv+tjcfvtH5TJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(40480700001)(8936002)(44832011)(5660300002)(86362001)(4326008)(6916009)(70206006)(8676002)(70586007)(478600001)(16526019)(316002)(82310400005)(36860700001)(81166007)(82740400003)(356005)(54906003)(2906002)(1076003)(2616005)(186003)(336012)(426003)(47076005)(36756003)(41300700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:30.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a1ba31-8e63-442f-4434-08db3b72ac52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch initialzes the ttm resource manager for doorbells.

V2: Do not round up doorbell size (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6f61491ef3dd..da65b72cba77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1858,6 +1858,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned)(gtt_size / (1024 * 1024)));
 
+	/* Initiailize doorbell pool on PCI BAR */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
+	if (r) {
+		DRM_ERROR("Failed initializing doorbell heap.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-- 
2.40.0

