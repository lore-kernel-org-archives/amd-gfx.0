Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39647C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 21:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80A360FED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 21:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E80A360FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C8A88130;
	Fri, 29 Oct 2021 21:17:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF51F6EA85
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 21:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYK70hPQabhwTI6Yu5CsHPOb3PuMYzHsXjKmwrXbumxFXbJDMcWYIVpR1f7cpf8jcwHc1W/IzQKCAK8LLKXp+x6w94wqKorAAl/fJTh9jY2w3GItMnxnTSzXFeJfGGnxTkIMao9azcB+aCqlsC3KiulTqFeI1+AIuzHKI2O2NKvnWSa8lNiAwxVeMoL42Kd9X217DxFRaoMyewAF85QneX3U9wNlgP8+/kJ82IZ+TxMJCic/ui3q3afoNUf8tbnf8WTf/FDAlFV0wFY8SliTVcqs0WPl6l0eNqUVqU7YgN9MkqvOxj1k/IkVAOKYkQljWK3ql2f2ziW7WS8ZswIoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRn5LTjAUfEghgPZxxFqOmhv/bd82XMEXk8tSWXWSp8=;
 b=N5dILVZloOFzCY+94QCptumcJLtV/cxa4dRIMHWsDWo/7pYOukpLPjCyqJTrHz90srmddl8mFIAifeOIzYz7Rk43zz596KX9ISVJ2n2v/AIiS1TOFkjAObJF3F+08bqqtwcdqRWjo/rZxTc7pUz3FiyVPNxJTQDRn180lA1S1viP5TSkggBYTcYBc1YkN6+5mbK1YIU31Jd3PeZdFdD1LpBTKmDByLBzpBqEdF602IhjkIAP6RcjXkNS1T2udzzV9+vXhBfJfCbVRwQvrjIM6cWLBKzuYSfAPeCVTtp2zScvY8S5F3lfrMiXQ4Ss32GLVoKJcBwBa1wPkqNDoEzM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRn5LTjAUfEghgPZxxFqOmhv/bd82XMEXk8tSWXWSp8=;
 b=XkxuxHqXG1ay+bB4gW2xmirKhp2qs/zeOXDrpzDbt6iV+eXs2nfs6jtoSz05XyvcwXnyaC9hiTADS+4kCP/Dew7ClWa/aJui6NRWSSxywRmDe3/f8lwo4Td9Xq/SpCcMwigRuxNtnbGc2phjchwJQ4Nw2EiNmXq1FzfDKit6hI8=
Received: from MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 21:17:18 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::33) by MWHPR14CA0028.outlook.office365.com
 (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 21:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 21:17:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 16:17:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC and
 later APUs
Date: Fri, 29 Oct 2021 16:17:17 -0500
Message-ID: <20211029211717.28519-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd05a50-29be-401d-2776-08d99b217d1a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-Microsoft-Antispam-PRVS: <CO6PR12MB547488106BF07CF888D85B3DE2879@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKRckte5eS4bPb3bItHattFzNzKvNOLg71PQVCPfEV9BVtauoZFki9xy8VxoNdCDq6E2GiCEFultkzDMZEV+k6EhrG7GQDsEAOaALBfnhjDQqCkzHsFfZrMUlWnwEqd2FN1f9ov0DDA0ddjTT5Lu5aigVMWaIj/RBFOy+PSCAL+OO73CsJ07hEsgpTzF+vKEUSpeDO5W/qYOLocqawqEOZuuoKz71lQyko8L2SulXS55fmpckgmNTP0/NNF4Sz6zrBi9f8sRwCa8dmof3UgNMppXoBsdLwZV2NVLxK2RqeKezdlqI8tMnwTrpCtvjakTdCoextdc5wUUZ2nL6FLqMncGmVF+OgLyBFxLfuAUmfeZl6zIh/5M1+YIjKkv0P09PoqGJB005YqBQUSzlqCqMT8BaNyncxAwsHaS6aPo0pYgTn2OxoPFsu+wZVphWDjanhUZGWt/uBnsQsZMkpWOOKkPMTXtTiGj9X6deWeuW5Ms1NY+Tja233Ot4p63kyUnrZGg4IVhZXhH2rQwp5pv/9yKNpJu0g6Tv/1YTxDlhGoe2id3MWm5zpoyy7UKejHOiCbWBMSNq405MGDr66n/48pFfAHuI9RvIef4qVhLfi6wR3g7Ev2NZt88M2GWZ+Md6ZG0N8rGdn2Cn6fgU3DHzGcb6RR4P5nZlIRa06p9YFbtQ4+ZLGgIeSEd4mP3UXxwFwgJ/RWkDnKG1NbjtGl5RjYm+ynn0KfoGhXMATHifvQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(426003)(54906003)(4326008)(5660300002)(83380400001)(316002)(2906002)(356005)(508600001)(36860700001)(8936002)(2616005)(86362001)(7696005)(36756003)(16526019)(6916009)(26005)(1076003)(81166007)(336012)(186003)(70586007)(47076005)(44832011)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 21:17:18.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd05a50-29be-401d-2776-08d99b217d1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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

This command corresponding to this attribute was deprecated in the PMFW
for YC so don't show a non-functional attribute.

Since future APUs may be brought up using IP version checking also
disable it for future APU's.  If any do support the command then they
can be treated as exceptions.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 49fe4155c374..c7326f0ec517 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2094,6 +2094,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
+		if ((adev->flags & AMD_IS_APU) && asic_type >= CHIP_YELLOW_CARP)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (asic_type) {
-- 
2.25.1

