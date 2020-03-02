Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDBCC3F2D8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D31221D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3yBZ+K5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D31221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D516E5BF;
	Mon,  2 Mar 2020 16:48:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B576E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfsbG41bASGo0CLp+fJ0HkCxl4+y37QqpOQPmGr6i/W8fK2DRrODgod7mq4a2Z4bMBppfs16eQZPUg0MnqhY9DLxEvobcp/g78Jf01beYPvNllLwSEkIXeGlP4ahytQH7ek2s+9+ko7vNUBOGYuKVepIHPNcol1ZQVPs0jfDSkzqVvh6NyuUdB/lMkkzyOgD7c4z+EF0OfjkGo6219/4/m+ZPasFJ38j1WmGd903U9rzoWC4KgTN2QbqGkIc9CHOh59L3/yvKZLk7Yd72sIzgofcTR0UVr9FHiCmLaYjCrajPGbqMcAN/vM96obuZ4GoEtyi8oV99yYaWsBsFIMZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIUf9NfDfc85hIyxl2ySh3TCieOiiblSpIH8gDcUR/0=;
 b=HAiuLWjp6+0DwoVBC+kHbe9vr2N1+7BHmTS7/WpZnGzbsaqL78Y/4uE7fyMW1JBjxCbSqvwUz8wsJZOfkVpCIJnB1y39YUuiTGXOFqD7Brhs+EYjC7xIx7i1PAVx/1XZ8uKgOImcRAcPUErEBPL/o4rvs/fvyuUsC5AR1efRIkJr9D999K5adqq+yFCC6zHHk7uf9k1i8UCFZnk6ACWV3+juhXy5CpNcxiGLSXmNtAJvL6Dmbw/n4zxpKwnl9tUolNfrwTpEJG84Mkqh/AAKJPW9UpaCZ/fJQ7qscRHctgShF78492srpfC/nCIAD//j7WZUaWFmp1zK56YHgtZkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIUf9NfDfc85hIyxl2ySh3TCieOiiblSpIH8gDcUR/0=;
 b=3yBZ+K5x/lUDRG1gjjLwf2TYxxZZDXBe/tjC+4v4kABQujbCJZGgt1bCpfcMgJwG+f0i1cuRZrCtJaASaJdQ0glCr6bJlHjcUI6HTO/u11P6CYiPaua+GBRltutke/kmNFVOSo7OWmiEadxzIkNVL9iDsbaPpKgrTQIO/S9WlPU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:01 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/22] drm/amd/display: Remove DISPCLK Limit Floor for Certain
 SMU Versions
Date: Mon,  2 Mar 2020 11:47:26 -0500
Message-Id: <20200302164736.89429-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e1b6131-274f-46d3-666f-08d7bec97837
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB241173F5499B7AB4291CBCD898E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnVbajjZ45utq4AP9nYo7WVZ2nFsM+rUBuS18knez9Of24sL5Zmbhi7xd11yafppWflSCXy4ep+swIFl+Nh+s2q11yzR0ar+5doklMnVznuf6ZwtF8XFvcdZ0sD5kRABzTLSbHxNBrJZoRJmiBKiE8mncjk2JjJ1tOu33W5HDl2qBD6IPP0MbcM2vPVkgCKhLgtfITx2u2ZEm+GaievTDo568odYdN67t7KCNHZwNpnBEx09FXMvEHNq3QMVJW58SrIDYH4QIVbRYzw7V8D7yH0/6lyPbxqgvLXInSjVPyXT885Wga4KpDH34zyXePLRbMCUmz1mrt1f0XMaRgM8Whn5OCT6RQ50FYCz33msiGLjhzStRfP93/ti96nsNoossBGa4gaNtqUcH9oFIb9y2J8bfjMZRvSLMsb4LwpOflokLQrV7ZHnkSwRedhCOA5P
X-MS-Exchange-AntiSpam-MessageData: 1P5BLE8X8kBLOtIAeT05e6ztkt/uKSjevG8HbEF2Qg0Qxz8iVtoN54B8oT8Z/HlCP7MzMREnQ9ejxc6PqZk4hG8jClMGZ5jubFEjwJDki4o5bnane0a2TR4v1kXL7LLtPcKb8J4Ezldkj5TOHWbbnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1b6131-274f-46d3-666f-08d7bec97837
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:01.3793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKxoASTvcAMdFY877xc90jCMK7vN2A9QWPB9p9Ol64GMB2itaWq4zSY9RRWCSLC81OpRQFhfIk3BP48nGxuMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
SMU FW previously had an issue with lowering display clock to below 100
MHz, and a workaround was put in to limit it.  Newest SMU FW does not
have this issue, and no longer needs the 100MHz cap.

[HOW]
Remove the 100MHz cap based on the SMU FW version.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 64cbd5462c79..ab267ddd4abe 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -46,6 +46,7 @@
 /* Constants */
 
 #define LPDDR_MEM_RETRAIN_LATENCY 4.977 /* Number obtained from LPDDR4 Training Counter Requirement doc */
+#define SMU_VER_55_51_0 0x373300 /* SMU Version that is able to set DISPCLK below 100MHz */
 
 /* Macros */
 
@@ -720,6 +721,13 @@ void rn_clk_mgr_construct(
 	} else {
 		struct clk_log_info log_info = {0};
 
+		clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
+
+		/* SMU Version 55.51.0 and up no longer have an issue
+		 * that needs to limit minimum dispclk */
+		if (clk_mgr->smu_ver >= SMU_VER_55_51_0)
+			debug->min_disp_clk_khz = 0;
+
 		/* TODO: Check we get what we expect during bringup */
 		clk_mgr->base.dentist_vco_freq_khz = get_vco_frequency_from_reg(clk_mgr);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
