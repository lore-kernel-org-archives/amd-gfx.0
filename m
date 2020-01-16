Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D99C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790552073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="deP9ihZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790552073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473C56E218;
	Thu, 16 Jan 2020 10:01:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AE76E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 10:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JydZMZnarxuHq1+s2DvodPO5Epn1L3zEgjugPSmCy18NakT2Uveo5OZ8lIBUg4BKcDqEndPny4M82xKbaVlEi/F7q5TD7ejZYGFpJ+GOLIBRRLX7x4Y13/Ht/z9MjSHLyQ8QoTkWfuWYV6LXW6mOQ8iBlXTpE+kcgTVRBqMbflYkwNyQsj8Vp3/chfNTcF+VmOdLtKh1JF0vARRyKZnCIWVJYGk/uoO08Va4XFaxVXVcKxA2Lv0Kn9uRVsNELFerM2anFy399vo2mtM2rQo37PxnHc9aJAJEFBqQT/2JhIDPJl1Rse1j7W6W8Gc3khzCX3FMqu/pEKQSKlb+3SVtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4carQZLbOvQqucOYhS75Nd8bF0Ffib1L55/lUz+yAw=;
 b=mTCadwTKE1RKJquqIxKO3B86l5yG7gKhxpj48y3ElzRJP6CldKbfxG3BFlZjVU1xqxY7iba7Z0q31LD0tPVj/rV9z5CADSsYWcGvjye1zaVcx0yRCtGSFwpw8kGAP5kiR/jMakiSaAAMHdEIf3FiuxW49Vbd4h+drqyo7v/kqvgrNtt6pajL5X10BjTnIsInaDcYWXWo1aaKkM7MR0I9r83ePIR1CNAR5M8isPSNRXqwLR7tT3eE4OmUVwXN05m97K9D8gPdqN9COF0MDYvHOx1wayTZlAzh7Tj3vfF/eQfm2xeMAp6haf0fsq8UkJ60MUc1O/Snp75gl1EvD6d4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4carQZLbOvQqucOYhS75Nd8bF0Ffib1L55/lUz+yAw=;
 b=deP9ihZMrkaDkqSjD3cCrs+UbTrZxM/DVAHza0O4CvbGuD4CR6FEn+oC5vglCBp71hM6eg42h9Y/JlgERuDyf96TeQoZbGNGwlQChbfXSDNzmp6T32XI57kjl6iKqx/ErO9R5Q2YA0nRZRDfAX9PtzDvCQ2u5pK1/tKEgOWDnMk=
Received: from CY4PR1201CA0013.namprd12.prod.outlook.com
 (2603:10b6:910:16::23) by DM6PR12MB2796.namprd12.prod.outlook.com
 (2603:10b6:5:50::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.16; Thu, 16 Jan
 2020 10:01:06 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::209) by CY4PR1201CA0013.outlook.office365.com
 (2603:10b6:910:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 10:01:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 10:01:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 04:01:05 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 04:01:04 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jan 2020 04:01:04 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: read gfx register using RREG32_KIQ macro
Date: Thu, 16 Jan 2020 18:00:56 +0800
Message-ID: <1579168856-6437-3-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
References: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(428003)(199004)(189003)(356004)(7696005)(6666004)(336012)(6916009)(426003)(5660300002)(70586007)(36756003)(316002)(86362001)(2906002)(26005)(81156014)(81166006)(478600001)(8936002)(2616005)(8676002)(186003)(70206006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2796; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b830edf7-59ed-402b-9f86-08d79a6b0095
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2796EB309E5ADDD1C1DD2F339D360@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kt+c7h9WXUeJ8gtRrTWmnfQnUstVmT5CcOHMa+MEWOaEzbRDU0769j2HksRujPxDZpxeIBvjd5XnVtEoLqItYtsALj8orchpH5YmPihfTJ2HMcQ3fxySaQz47qkUga8lzaXEVjFRg1ZO1nlCt63G3eH/kc4uq7Bs3VZw0lIPP6ZpLrB8sOeke2vCWb7rdSJ/A8nBlLX5ZCmWn9VUL9E59G6setWgyGJAJML5BYNUFfDkiHg1VXEs9u/uNIx5Rts8T7Ae4hbV+d4E7jywakJCZkgKJorIXRPY2AdgnnsYl1e94LQ28ygw+s91N3NOE1GPNiqCt9FTcDxR+wwwMgkKNmcJftGhmOPuOSdSw7y6lxs9uaU0kG6YVMIbUZCEJsOOtLhlNn7PsPT++PNwJVKPXB2ou/cLSElMD3Ay1wkuVUAxmA0O2n8AiofRsQHXscTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 10:01:05.7356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b830edf7-59ed-402b-9f86-08d79a6b0095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
hang when GPU is in "gfxoff" state.
I do a uniform substitution here.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d9d7ee9..03f4dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4717,12 +4717,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -4731,18 +4731,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-		data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 		if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 			*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
