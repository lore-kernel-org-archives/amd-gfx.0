Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511AC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 10:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718362222C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BrV/qKbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718362222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB386E4D7;
	Wed, 28 Oct 2020 10:12:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFF66E4D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 10:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF+VTiCr7V01pf8u80NkdK/91xDEHI0OAGfD3Q3X8axLf8uBYGYh0WdGRO+KxixliKmZPQqsZXLGB2XIjaeCvPYNH/I41IMcDWYWSnUHrX2eELmFN7OdOq2UsKq0NXx/QDZDnslxZafGkArtfejWmgKL2Mde/y9XWTl/jNeAZE8Ncqu3StlaTQbVAWCrR6mtVkH30zQZEJDd+e9mkBIk/1mAUEPxNU3Wk56v2vHVbbd8kRK3y6MDF1C/Az6N4LU84A33SWncAng53m33L1cet7hK3yZRQ+NG+uRXV7DsGEIaU2ZmA6TPxGtJBXnOSpS/69tjctjui0TlNvdiX8EeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZQzfNMCFg7tJipZAebeeRtLCVmq26pcttpDw5A569U=;
 b=CJF9bV1NE5og9Ya0ixXVYNWWCuWKC8F7Gj61Nd5xSci9a5dKlV5rBCV3Sod/lTya5Ny7TiqMIehQ0DTrBoc5zcOuC8hKUF1KB8/w9C5B/SlQbrAtyvVUQCIWkQtojqF8OdMFptAC/EwDnMDCY7vxtEwAmkjXdNDdB7inArm6ScpTndIjFon4nnfXpK4DmUKEKfO8tedQglfRHbc+lbKLWTclXqZv1fYX7qGxFOwcUo063T3IzjpxPJOdEAYkrBNlQDGepNBcBWis/L4WiMyhegFbtjqbXMaAdv5eE3lnIKYQdJcka5tPbs9MtcLK3n45HjcSb0zxo9Ld7YqVjxC16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZQzfNMCFg7tJipZAebeeRtLCVmq26pcttpDw5A569U=;
 b=BrV/qKbktf8OQ4/10X27xELvLkKSfpnrzBXOqztHTRi6kSEbSxe6KWI4O5e5of3xLmP2roQBmlMglrlLAv7eCgVt4V8JW2pTnX+nb82oZY288EjKuvHbI33B4U1/gDmiZEiZxt6ORGcR6KfJM9b5BUcPLU2sCk/KS9hzUeWAppY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 10:12:54 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 10:12:54 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu:Add flag for updating MGCG on GFX10
Date: Wed, 28 Oct 2020 18:12:36 +0800
Message-Id: <20201028101236.2941-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 10:12:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72783548-327a-4be5-8b0e-08d87b2a08f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33717E307C7B7FEDA114B6BC90170@DM6PR12MB3371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG3sn8yNDNgOoLrzCdtV9ICf2yLHBiJ4DxxhHvZk2by+67sVR6ARbTH1+sFdMsaNycX8suNs84FuZZjNoNtGtYXSrfYfloRp777klMHAtZT0XE7pjtWVsuElodezLnOlo9kdqpgGzewb4GqZtM/2QftIT4xZoeQKf3CIInL2IToM6jAhsasbGgwZme9sIWmhHjRh7a0EtAgoia5RHzkfFJPm9Ho/ziICQE+3gUONeCXbtNmCYMEaa8UyE3rGQq0ftdl610B6cv1ahOXirz1FjfVg0804SAqqn3P+SqEdEQ4D9ilX4DvjAHQSw9mL4bQt6RXEUUnGVUsqfB5AEclafg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(6666004)(8936002)(478600001)(66476007)(66946007)(66556008)(2906002)(7696005)(52116002)(86362001)(4326008)(6486002)(4744005)(8676002)(5660300002)(1076003)(83380400001)(6916009)(36756003)(186003)(316002)(16526019)(956004)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jDnpiKN2/YxUjG2jwwIPpz9Jd0/9ufu8C+3+W2gjXlneQK36J98FhKdtoKHaLbQ5GqLCeo56Cg5nZorR2Dq+5QfiF4pvIlLcXIfSGZ7aPNe79VrhlSFIYMxtLxNgN64YCN56LrxuG9AmEZqvzg2DhvTIacfijU1Cpd7BW6tZuBPpyewWmg4rn3ahjka6MXp75Kk9sH0X9dCU4IWRAZSImoWtNbCz+RqcIoAxKvOs39K/wBfQ6eKX+znku97WDndAkgz575Yc+ONLaLq70rLJssov+Q2NdJQNcvnPy5J429bPmYx2Ke4FUSjnHryIDB9lbHPNeKPcVzUPRudQYHa6p2zdvvPOwmFwbSKfRdfekas8zohNcu9n+PgiKasYh4dprW8k8BLM6v3rxpfKJr5QvOkfWvqLkAdo3Hb90tUOra7Y476/RcnhXkFPj+z+UsjBuKQ6QCU/5caLxKLzpqhQaBmHqwV/a3juhrUiYfnHb9I0RnCXuQWh21kUacwF8uRJ0VZorEwLUWxR8IusiGzesW6L2zovwPSf4CMRFT3iZ334gHSrNx+ERHHjjyRd4IafThhnz9ZrNSbRtIrt5cVTvGWN95v+wJ6JqT4udQSsGBuPvtNWnQs4ODofczYfELLoYte3jYI9vtDRHTKlwA5OHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72783548-327a-4be5-8b0e-08d87b2a08f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 10:12:54.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVDK0g2gbg7JHdGOkYAbqvX5noNhukPJqGJJ1mcrP86eXnMHe6noZcWbl/0Z+6UF87B/Drb3t+SQyMb19OSVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK

Change-Id: I4c1cc30bec81953d29c86d0fd9b5d7cff15a8cb0
Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3256d6b368c8..e4c69125805d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7520,6 +7520,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
