Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40DC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1001206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YUNjtZEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1001206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862646E9B9;
	Fri, 16 Oct 2020 03:27:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D726B6E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePFoJv7HaNVC7oxD7bp0ELemwXF5A3fHM/Il5Tb368mW48wuY6Jv2P+kR4H+oEJ5sBrsD4wKEEEpgRXD8O6B74W2xkvwipq5+t9XDywB+hh55LDFQqfAaAVkoOhDpsDntIqijkqdZHgLK9CKqjC8uTn5RRJPHPKQuD+fB0nlR4FoMutAoyx3cK3s0CHIf7UIyqFRqr7JbodiHP9gczuJuUunbsR+uIyRZbU/LOdgWJy/XeDP2tVMrEGiqpBRTpoo+9JQuIf7Q6SFK2HHrrSXRx/BTFz4dmZ5ENN38VIjoHdoFtIn+BsXHKVQdGrpDPW4peZqpVyvB/+djqwiSWafPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVu6ePxul83x7stE1ptpeR4z45Bb/GKAei5W1TlIISs=;
 b=JLwU8saALK9qkcYrxC9tVeGAH10Tt5/j4Q3dJLCZ2pMAXQaG1LEQ/juoGpZRK0NsIV8ihHGTJekh1iW8dZwj107qxjwO7pqFn1pbOtJReS93Hm+sZFuVNW20NCYmt73GSAuLXxGqLJQp/OOXAVm++lUYIYEy1VKnZa6yVsbTmHt6KMS3oO8TPLly8YP94kmaK17F4IvYFTgYffTxjgB1gsc9wbEcULB2C6a+8OFYDhOeVwWyDJ2oAGumki8CZGu04ELrvDkZJPOXn2B2GHWVxuPZQX1suSiuXZB23NOEiS+87RrXa743JxhwIMaValaammHOqMtPQuvk60twOziang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVu6ePxul83x7stE1ptpeR4z45Bb/GKAei5W1TlIISs=;
 b=YUNjtZEyxsl7FXCfRjlXBuKDs3x/VdhLWj1NqbvD7Rwk6MGf0TifgkijavVs8m0afXiCU7SDNNMbZfZoa9Ts7Rry8ggCHqVP450uopHGufYm3/qkvWPuc/eN6QbLauTiDc22UszyrhF9tp8miBOlo6LzUP7UU8X2CR18ui6N/+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amd/pm: add pptable VRHotLevel setting
Date: Fri, 16 Oct 2020 11:26:21 +0800
Message-Id: <20201016032652.507-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e6ac3b2-9f48-47f3-0a23-08d87183746e
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680ECAD3D5F04C988BDD266E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lYY318UsiRMyVWR/NyHOIZNbmanTaJiSZPB8YkIfRfRc+MTYemj6pIJUVoqCpLfXQ3U+GF7gDF7T22gvixVo11+eOBT7HSGbtG659L+sh4TUGhhHiEB0/924p3pNah7mM7T0WNexWtXyRpUr37QgS0e4rtFwPh26HTp+2/vSDrCeoByNrqzn/ueP46CBxCO1d2JoJZ956QiVq9eL13v7SZgQQ98bj2F3axoO2mYWY8c/2rr7+p1p4pVSebpGqYLjShDr2zOW5qJMbiDJFHtq+0wh1cernCzVW6aCZ8S1ZLvHApgtFyKrsk16JykEoepCrtCHgndDLKSxa8n3wUAlfdV+zNgL79ZYd9QfVzPZ/0Ifq7efwilksYZQxH88gwp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: isx9PMY804a1RtVuPlUmIL37XrvwNiOihhgec2Xm5l2Ft5pHRej4wXjhoBn0vlxzS1QYTUItteEQWmxBC6jz4Jc1R7LtWFBzgtBvJAMReAD7ViqlroiIHUAZO8k5vPO82acHiUJ5k/Wn1gr0a2GCzUCGzEcvzsTkj4fQ3akiNVF/1KRXfWgebBLTE9lufXsmeDy/cXCeSvz0HfpsL2tTelfQb0VhV9wXHdt0M2ariF9x2ZzH4sJPB8ZzQnNFXJLn1guigxOrwlvkKcGjQL3AJzaxsRuH52jJnMnr51kHo3nNwO/p5Q9Mu1OFdFPNa4Q+eIoP+cIk5Iw1GaYZ29ooCORMDTj3VnjGYmTy0PVcg5lShF+6tm7D3JJ05q3En1iXGPfJm6xUiK8ovEfVd/XnSeyuDZXS+qlJBMDaE2ZTNixkWH1W7m9kP8hcMNGw18TW2YfYQAGR1dBdAkPg0ij/RF7gQKO9xY7FaVB6ddUN3sST8Noh3ktlkbZmyGpSWHRG8W6SqoR3lSybPO6GLs5MsfJtaz/jxLx5mTCfFuzvJQHkZEpHTzOkkUexHgmPioTtsT5kjIqK7ItSuSnexy96zAo4BL05dqcpD7HY1AKnjvcwps7ZZ5GOzI1uJUW54f2E2bD84/bogManjqTOyE3zHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ac3b2-9f48-47f3-0a23-08d87183746e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:48.4136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m71dfwAsFGU00mjyrB79HdP1wIUChBuPPhMkM+DGzPq6Yd2RCFdkqdsC7/MkMcQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing VRHotLevel setting.

Change-Id: I5d70599f49469f920e01d38791fbe6466a4f47b2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index d9d53fbd438d..5a0c227f652b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1921,6 +1921,7 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	uint8_t i;
 	struct pp_atomctrl_gpio_pin_assignment gpio_pin;
 	pp_atomctrl_clock_dividers_vi dividers;
+	struct phm_ppt_v1_gpio_table *gpio_table = table_info->gpio_table;
 
 	polaris10_initialize_power_tune_defaults(hwmgr);
 
@@ -2036,6 +2037,8 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 
 	if (atomctrl_get_pp_assign_pin(hwmgr, VDDC_VRHOT_GPIO_PINID, &gpio_pin)) {
 		table->VRHotGpio = gpio_pin.uc_gpio_pin_bit_shift;
+		if (gpio_table)
+			table->VRHotLevel = gpio_table->vrhot_triggered_sclk_dpm_index;
 	} else {
 		table->VRHotGpio = SMU7_UNUSED_GPIO_PIN;
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
