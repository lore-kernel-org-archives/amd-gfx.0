Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABA5E81815
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 03:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A39810E347;
	Tue, 26 Sep 2023 03:09:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F3910E347
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 03:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpDmlPB9tD1o7DaPB5ZpVRZzrVKMoxM6fTp4dkPPqsdEwl4UKcxYEzlCbDilfoGocpp6fah6KfOLejcnmig6aVo4j2ax+DwiiSnEl4Fot8BJwh5+Qj/Rd5D0bGBF0yx9cm5VxH18pev2amBp1E2RMV9gNI8GLBy6SlX0BSGWR9kyykjt3YbLqm930uzFpcxQqSFxNd5iVmVz9dWO0aX0Gdg33o2m2AXEUw87BJ0+8P3oZgpctAVYNHk5nwCyoNyNsQvNkt0zM9wkiz+3XwJJMW3/MxMr22DTR3JC6ctl/SR7jtNjnJAXnGODYKlUtD6kuzVRJ24qzRYqGpOfjwldiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXsZPlweduXtwqLxr76KwHfXoOsDlhw4in8aQ3R+YKo=;
 b=fXDN56E0WpTFbaHOx+lcQ7P8s9QLgQ/aw9dPN8OTplEzbHCXbtkI0e+bEPMdC83JJHUDfbHuK/McOmVsWuXZbo+83qme5qrq/vgEj7XwsZx+T0y1SZybzUkEyEyyIRWrarCzHAiLxBaJ7DrmxztmETC6+fGAYUl0CBvpjuNy056XKlt7w3gh99khVyciPiQlvXCBxr2mCO+u74QjIwL4b9XKL7NPEuTzlHVFc85GQw7Oo9U2rmKF0tyxP6JdQP/Jyohjpq2pnAAYJn+eETGKr1H8uUVNy0zKPcWCmgIzcYzDjjaPWrG7xr4ZRc2OnCqSBAgolB/7yxd3dHiev++2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXsZPlweduXtwqLxr76KwHfXoOsDlhw4in8aQ3R+YKo=;
 b=3S/AJFMCT1nRQw12CmSTFXN1RfLQj1aeC1D9PbvIuAqvBYX04e9kxQVs5ipcCl/SkVXxd2MhaN+VuSXGE5t58STVpcUTK9p6RiZ4Nmgpxi/4wX0PnjM65y+CoTNxemp6DeFSnNsGzCZQXg0kPqJFKO2QRDCC2WR9lRF6D/L0FP4=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.21; Tue, 26 Sep 2023 03:09:33 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::1a) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 03:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 03:09:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 22:09:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 20:09:32 -0700
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 25 Sep 2023 22:09:31 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV for
 gc11.0.3
Date: Tue, 26 Sep 2023 11:08:59 +0800
Message-ID: <20230926030859.3046382-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd83906-3400-42ad-8268-08dbbe3e0206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNbbWVypWJs8RbwhCY3Dt3ABQjhH33MHDfpCm71aiovtkZUS0tK++yIet+eyArhYgMqu/FhLZicK4dyofozWKe0CdSocvRIbEYUIzZ0Trh7K3Cx9zmfX/6K9Dz00/0gMoXB6ZySVzqAPZS+FHnbdbJ+1XRyGfXms9E0oqxx1inxet1Y6ydig3VsGtBsNB/9EO/qhEQTBESHkjVMIkRUCI+PLyoxchedR+drI6FFUuaN4fVVl3UXHXKPsrJaEWM8OQoOH0COAD0+MbDAnaeE7DDn7Qs3dN32unv8vH9CGqLyjsC1iDo3C87yAz8cePzOcKgHdq6F16v20rt6EWv0X+AE6cikJ0/5wjfN91nuu59KrIDyhqS7eK1M7m9PGfIc4IOZ8YhwmN+5fAqUzedjCP3jY550k8b4tO+t7ZTC6F5d+12nuJkuKkgvEUR38SHQsPIQG7+zkB1O6ub5n4qlgFD/HfhW1LEVqjT6zronegApgCzZAcKCBh65Vd3mvIMcoMebZKBjDKFZDt8q+rhfr6y7I8TOYc86YTHTDnZ8HU38r23QiL/UjXXVqfFTVD3hIqZusJoNGqOnScys/ozAa96JwGl2wvbogdCVpTlROxgTajT3Hw23x995I3bo1qjxW96MP6uOhHrWXexcW2Qj629z/CXbozj61TDZi+iA9KzmfwwVypqLUKYr79AlLzuk6vyPqDkYAdsH/banJG+ErTLDGTrrTJRnpsVKZsg0FQr/XIONC9ygiFpS4jUUsD0T6Vih8qsfYHZ3I9z6vkyw79A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(316002)(478600001)(4744005)(2906002)(5660300002)(8676002)(4326008)(8936002)(70586007)(70206006)(6666004)(7696005)(1076003)(2616005)(26005)(40460700003)(6916009)(426003)(41300700001)(83380400001)(86362001)(47076005)(82740400003)(356005)(36756003)(40480700001)(81166007)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:09:33.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd83906-3400-42ad-8268-08dbbe3e0206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

disable pp_power_profile_mode for sriov on gc11.0.3 as not supported
by smu

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2d19282e4fbe..b6f32d57b81f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2122,7 +2122,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
-		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
+		else if ((gc_ver == IP_VERSION(10, 3, 0) ||
+			  gc_ver == IP_VERSION(11, 0, 3)) && amdgpu_sriov_vf(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
-- 
2.34.1

