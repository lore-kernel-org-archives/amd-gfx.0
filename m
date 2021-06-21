Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23FC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700CB60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700CB60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 168B86E237;
	Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE4F6E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsqFclPGPqpdgu7qD7oSSAFvAxgSG1feka7Pe9LUQkZHjTvTab5ScnRO/t+sGIJXZQomz7Q6hfNJ2H8fDR2QV7MWB9RvHNCTBX05lHDVna/XPJSgOYhY575fOVmlygQZqvb+2lZ7B3PgRJINeZErvnlCL9oIAUiPK8vv/fppaACsB84kq38Z0wrCk3S9gh8F0woLJyYvrUPfFOW2SO/DzEweZqE2EFlfsaNaFq1CDjosFl1HHqAqwfYoeRP9n/msj7R+0TLfj2hF2zkyd2xwmo5op8XN18Ygl8r2lFG7BdNaitXSGvkDPvMcnACBRd4t0f1mSoVtNyzwgCypKGJGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPwmmZBdTj+AQ90/xOm4Gzhg4Zy6sToctTbRv0i+ydY=;
 b=XVOtBNWMl2l3C2H0i4HVtKsFKxtNsBJtAh+2AILMhSA/oaYszN76OPd3AqwtryXgoXv8J9GylWK/I3jJlHu9SKVl753EZ1yORRQKmh5oldr9tqinvNl5bU4MiYuEXow42tNRKWLpSwWYX+0xF3MQlYU8Ohnlp5Hk3v0RMZOnMRZHABtf2qSz0YOuUwLX7nO+sUB9VoNF01Up9+NsSlofWOo0GNM/4s9iTsaJetUNpVXjBmRTbrG97thITDmA+0VfIUx3CPXrkM7Qi4FUi8tnUUvKp5cXjW6Of7ByH8L4KzIaivYrai+92A+dqo7GXwbjuALQvCLkLwuJJcbnFGqJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPwmmZBdTj+AQ90/xOm4Gzhg4Zy6sToctTbRv0i+ydY=;
 b=JY+NRlvpuaCzZuBw1c0GrWEMEER1Ok2kBHDWZiJJkBLDh/M12elLNqlxTgARVGm3YQYKSkfHOuhVvIlFE6o4b3i01TKkRegHjNnB1GiQr0lj0I7xDJWySliHzM57R61MJwPBzNZY8aV29tt81MF4AMAvxse6kLipSJ3nxNGnVz4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:59 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:58 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/43] drm/amd/pm: Extend the I2C quirk table
Date: Mon, 21 Jun 2021 13:12:07 -0400
Message-Id: <20210621171221.5720-30-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22650602-1fe7-4e0f-d6a8-08d934d7d174
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12586E8C36193508081C931A990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UllTvsan8cqUNpjGeRYVsFWS/66uu8U6zuZ43dgi2hEzu6sG4KwcEcc4suM5AtONajSuG9Z8dZwFpmz4DOyfllTGgjqCYTFVCjxQPL9s/OuAqjtnLOvVWhpKmhK5NZOOaLenPnpgXaP6dt5jujRQiJStas/nmhhGskjgXPL1fMbcq13imhuA5u9pinO3Cac5fjxFIHAzhKO9nDJpseJXOyXDiAadFV+jgIHlVdMkl8bCzBdpQUozUwrXMCZ5D7mV0hNu0rk3Uh42bNEpU3OipNBpL0JzjfRsdkLkzEVUBOL95YZeWK6TbrMYAf3n0DNXgFafBK12LEXNHR96c8EsJT3tRSHgvutgJel6RiaNRw6IIMB2uWdr9LdtBwUD+QH6ClUTndBNBRSGG/FJWM3NnJ40koLDg7yHqU93TGAHYnLAjK8WVj/Six9OaWaUuXwbLYeT51+bzq3qc709gT80LRgLAO+E3v5fE9OzRszQvXI0FKC5Zp0Qi+IEnVFCOOazX8IsDDEcc7SVwojLBcsIFu9HUyeiOL9MfUxvIt2wCbhPkhRHFXBzOlEQBLVYCJf7U/3YEYXuR6ZdGrPxeArcnNDZKJUFm+v9O+1nl3vKvhz1tS/mgtFHjYYKpFPNzJvONwbI9IXC+L7Zx7MtsTMulHwFzSfmJPUJITSvDpCy3D/x5lezSSBajF7T6SUWJiKv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l7dP1FTWuJPQ+GZRhThSKUMdDFCt6KbpCVCpMUafS+gcjmOyWlsnZ7kCXbBc?=
 =?us-ascii?Q?LPSt8S2Hkqgpf0V6eZVpSRFrRPZbj9G85g9V93tq0AVo71WyEb66HcqIZ4xr?=
 =?us-ascii?Q?PaIFozWyyrDnD9k8n2krchAA8gpiMhuUc9tjs1j7HpdT+VldQ8lfuicQX7QW?=
 =?us-ascii?Q?V8/xc1zCiV/cLsv2tUJR/bRn8yRS8ty7JtewgxaouJvKC/Srz/5JfwHs5SXW?=
 =?us-ascii?Q?yfayAsNdTqAVoG2Wh/iFxqBUy/yP6WWRr0kdrniG4/9aJfbj3eC2ov5NCKip?=
 =?us-ascii?Q?/dlodQ1jP7HpJug3Ay9AvhZLxgJFOQmIJrFV3zuNyLlm/rFwdV1t2F+9JTHf?=
 =?us-ascii?Q?DWZ004afM8Qc0LPfjOPIQN31iwM3hmEFQtz3M5S/mJCZKsBKNbqgsTpST+dk?=
 =?us-ascii?Q?yM1sswwggg131rRAXF06cw8Ncvk1vkdE7HJcD8C/T7ELMmegaZZ6/MqTSvKy?=
 =?us-ascii?Q?bJ2L3hb9JVBcpIGlmDUW/ISqxfhmyJm3rlQ2bXYegw5QB/HAOIDV9z4w98qo?=
 =?us-ascii?Q?40D/YNpzwy4Ues1p3S+gYerSBAcoYiG/q3374e+Xt8+6J8X5bviI9GO7WxdR?=
 =?us-ascii?Q?G7SuogKy1FYGe6GFZYPSCMbqBvoAAOMZPJtYr7xDEsvgNeHX95L46s62ta+3?=
 =?us-ascii?Q?MISW7vaz69JSCR1FWS91gjez7SseRcNZdAG2EXRvQE+KSvftqeh8hk4tIdBY?=
 =?us-ascii?Q?NCpIggoATKfDg3ppLKJZEKchHxxZgMl8EK+E5t8k8TKH85By9OFxQhWQEr5+?=
 =?us-ascii?Q?zMEhfY3ZcZ/lo7YBLpfI5J+FabM2iTztfg8J3pFhIQWPj0KRljTtsjm3hGGh?=
 =?us-ascii?Q?HMkbZtjUci9OPjzMB7J2Iy8fQSgXaxvwurjtcysFVd98QcfI2SQ8RBiRdFgm?=
 =?us-ascii?Q?9HKK5CxZzT7fFPgzGYJ/iRtW+voVD3/+gBBbkKRZX/Uhm7hu4c8jGMA09o/f?=
 =?us-ascii?Q?/TO2y2ra3+EXwlKqkOOur9krt7dqfSklJRKP8AOtmIo5t7N4aSZHwlp4kfF0?=
 =?us-ascii?Q?2x8JjeRK7UPWQBtJB91wyxL2qo2mgsRpEcPCIQdZVQBPK4r5xyVfvMb4K4tF?=
 =?us-ascii?Q?/SpCrGjZ4bwUfdhngk7EU5weLLGg4q9KsNdV680A1qzGPuLsH66r+KmRmFMW?=
 =?us-ascii?Q?JKYWl1U73IlgE8z/iYcNozPrQ7C2fehxi5oZcqtlkxARthCJIVby4t4zQbll?=
 =?us-ascii?Q?6sEnznjoL6aGKqPyND5nIq/aJ3oVGM6Rg4QVS1DLwesN4CR/+sDz0hU2DmUE?=
 =?us-ascii?Q?j+yMH/VlDldP0//tw1qHB2ypx0iThR699jAVvwloWgeBpGHVMGKJLuTlJ2fu?=
 =?us-ascii?Q?7YfEjDdz1HgqMvEo/0hxP20U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22650602-1fe7-4e0f-d6a8-08d934d7d174
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:58.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOCT45iV7/XdK3/t9lCCnZsuVZ7D2tEK3zb8/7V6iLoO/u527FamCYszaEABoCyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend the I2C quirk table for SMU access
controlled I2C adapters. Let the kernel I2C layer
check that the messages all have the same address,
and that their combined size doesn't exceed the
maximum size of a SMU software I2C request.

Suggested-by: Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9fccdd2d3e73ec..3286c704bd08df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2036,8 +2036,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 
 
 static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5cecb4be57c554..9c171122384336 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2834,8 +2834,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2444e13c4901b3..37cfe0ccd6863b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3541,8 +3541,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
