Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4175C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 02:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5303110F0F8;
	Thu,  5 May 2022 02:58:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C2610F0F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 02:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pftjs0TskKv45Hh5jvCoby2YnpDKbRHCiwLjxFrFC0yd5jkF+aAezMmclX8MJSPe4WEYxx5RrnZc9h2WqQWAfkcZ0+lWopAGa6Sc/7HFtMhMnI+f3l9KF7UVa8ESMSsUv0j6EQboJR9Ol+owP4rg39aBtfo76Nnaj9WfFmx7YcH3VvDwFwZE1if2IWAfOYLPfSdjt1vOyIchMdP8YL/0SwZo0CPtw4GTGpxVgo2+lmvON1ey2i1w4T3eUrGO3/YoQRmcIAxF3JYMM+yGnNF7I2YPZxhGI+pH2zQKOXatGm02rE43wbhv5korfPpFIeG/5YQFj1Rr/i0KOYy2DY2HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DK/V2DTRAU9s9R9K5vifOoiMPENlVBA4IOEv62q5u4=;
 b=HYBBxSCkfFdXdHJvIXXAVrtbSpwpt2JvSYgDfJR3PlndWDCDAHb0YWrviu+KbIG8FIlj8tl9l1eAcv/oj8nPtfE6xlRx5pCZU9VED8mmWtAstcqQA8PZVA+HGTn3PWuBUcHlzRlzjCst6Gy5ab+A13Q52rzeIzcdDZHQIeIYMD5Fdmv1XV8NU9BIeQP+EKX6ct6BM30EPdc2+efg6rvqrerGUpCehNLbV37RfX6u4yJjbdl0jSWW2PP39QDX5hCPuNuka9gF1lHCQ/PBPA1ciFRalop1+iKgWaxfxLCxZ4+MRBc1h09vYqEnprQEmSbjTlck5LGWr3TpJmYNdNe9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DK/V2DTRAU9s9R9K5vifOoiMPENlVBA4IOEv62q5u4=;
 b=hQglpiyrsbmkj/2CDq5pdU6iVhfA+vkMJIminYD5+aOWPwjh1URlwFrbxqTemIHnbGRPHHHeWn05nOafq65C/lJ7XsT/0k4tKBeXvlXAo/ulsAVWZakz+/qn6rET9tR+/XkpyA95J8WuTSc+YO6Czywplpd1/oxD3Xy328aoDKg=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by MN2PR12MB3184.namprd12.prod.outlook.com (2603:10b6:208:100::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 02:58:45 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::8d) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 02:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 02:58:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 21:58:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify nv and soc21 read_register functions
Date: Wed, 4 May 2022 22:58:31 -0400
Message-ID: <20220505025831.403497-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8378cff-9e77-4f5f-3f2e-08da2e432b93
X-MS-TrafficTypeDiagnostic: MN2PR12MB3184:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3184B733546BD836DC31682AF7C29@MN2PR12MB3184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h6GepAO2U32qXt50+HNDOlfYlGgHUU8vmy0I9ZYJ1cmYPWQwabl4ZvDjxjtY8uisn3ayJnqD3kOJ3rYXDBL34nSuhG5kYl0sMvc6MrCT2Iva+WgmEvAtx1ZAD8ouRvvyfb9UOANWgSC0VPtD4SFw/G75HC6oObP5sNWmwt3UJgkGnlL2yV7Ln4mCJL25ViAgz9L/zDd00HUMjE7yHQ88B9q1CeWePFLSsO0AERghIJ5bckFCqYdF9azylvPNpi1iCPp8qb30n7zT8l0S6sdySdjMlCmo3DXnfAlrrds01szbA/h0eE4DLdqULwRUtoiCncUUY/IvCFt2jgsFkp97kuSNIfuXk5m5NvZ/eRqW3XzhcJ7ygJ5KU5PlkE4HnsJRYPb7J4azFbesFTRCnPD8j2B1W4/nh/uB8gIybzkSD8dXFqGuMw/JP4EdxeguQ3fZZXknqsiNrEq8Xykuq7qNXUmTz1B7UHTRdTvY8j2oHB89DZAXGeJesUMUnccARkGPhRJEnTJ/yZ/oJ+4f3f4D8qee2vXLwnPzVenl/fOP8IQvLlt7r7w3qyzDempHdZdDbVJvkiC5qRTKkclEyTuQ8TiHC89BIhHm1eSc9lIsSZHyJMakyJkqdFr5zq8Gu/03cA74SpZaPd+E/6CwUQZImYGTdBM5dG6SDM7aiCn/N1kr2sk0XGNPAo84S/DpZqvZI37n1kHP/xdqSnebPXcJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(26005)(70586007)(82310400005)(70206006)(316002)(86362001)(508600001)(81166007)(356005)(6666004)(8676002)(4326008)(186003)(426003)(336012)(47076005)(16526019)(5660300002)(83380400001)(2906002)(6916009)(7696005)(36860700001)(1076003)(8936002)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 02:58:45.4478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8378cff-9e77-4f5f-3f2e-08da2e432b93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check of the base offset for the IP exists rather than
explicitly checking for how many instances of a particular
IP there are.  This is what soc15.c already does.  Expand
this to nv.c and soc21.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8ecfd66c4cee..d016e3c3e221 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -392,9 +392,9 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
 		en = &nv_allowed_read_registers[i];
-		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
-		    reg_offset !=
-		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
+		if (adev->reg_offset[en->hwip][en->inst] &&
+		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+				   + en->reg_offset))
 			continue;
 
 		*value = nv_get_register_value(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9e689a1f2ea4..2f23cb8cd6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
 		en = &soc21_allowed_read_registers[i];
-		if (reg_offset !=
-		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
+		if (adev->reg_offset[en->hwip][en->inst] &&
+		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+				   + en->reg_offset))
 			continue;
 
 		*value = soc21_get_register_value(adev,
-- 
2.35.1

