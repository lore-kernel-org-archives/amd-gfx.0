Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B795C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223A761928
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223A761928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42196EB17;
	Sat, 20 Mar 2021 04:18:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B546EB17
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMAT5XgX+e2yREYrdykT2oYHpJbe5q5vOjLiBMhscIQ0ORTxfgS5idM51WEBfPt7eS3kGYwfnji8fj5kFrcAIsrfxVpXEJWraztSxDGnSB9Sxuu1A+Iz14Ry2Lxlc1FtZIxQJgZgmQU3LEcn6GRyCiHp/Gk6qoF5HMaDNvdf+gKpJAFpB/WsCMsd6BNrmdtCIhPqs/o9XjjJ33AO0/jwxEVttS16BJdlpyXOM7yRJsVzo2lW2cKMf59m0HD/5eq4aEgMCHkJr3c0gXrznT8jlT74hfP1qYQYCi0OEkYNYvpkmZFk472me912hsD0LKVGs27kfmMx/S917rTjKYtu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCG4A1/6D6ngILePAcgdwVU0VTbPKCLJlelnkylQNzI=;
 b=HcQ0GDVbSHloLtCKYyBzURy2Hu5n0fgqOQHa8yX0Xo5JvUxPoa9/MZ3vYhbqA6eRheZgX+LE/oCRv+E0VO+mRj3aZ47oDXb5oJWLR7KUKOSo6ZfxypgLMFFo0ONZ8peZFFJ4gOZd5sGZNf82HieToe0qbsgAUmiOhWLH62icQKSmnDbA4P1q8RReybzEp+K++712cRfQVsbq7OD3ioZFLcmWH/4sbzd41dLWeqExjyCKSlLmz6AxyE9tpB14S5JF+Y+p/2J87LZchh57Ky7YLX5qHVpqG3HtUXRaPmIwo1VbT7F7gIleJZ1yNItHVDBtVPAnRbDFzFyeLwtTLC71Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCG4A1/6D6ngILePAcgdwVU0VTbPKCLJlelnkylQNzI=;
 b=1Jtrb1ZevKlTUOjInIxYNUh+YWWXuIEsIBM3IyG7O/E1vaLK0Vs4M44VHafHeLLuu3PWSC/Iylc9afbmFuB1F+inxtShLml4lw8U1eAIrVC9LX2eyDrITIyKm63RINpAwx9fFqWPAB++otvQA4EhPSkNNEv95aCk0xYM6zeVzZo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:18:44 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:18:44 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amd/display: Populate socclk entries for dcn2.1
Date: Sat, 20 Mar 2021 09:46:43 +0800
Message-Id: <20210320014656.23350-2-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09e98c35-7d4c-48a0-d840-08d8eb573fe3
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704ADA7CF815920FFC9ACC897679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh65m9+76JLmsA4a/IIv4Yxlzpeg3ML1dE/TLTLru9KinjmGDjTUEWwCGjwXNNmgPwuPZzHs2AqK/47rsZXqZbZGbaP791lbIrAzjrFpiK09wG30zZxdXWxfkZ8TXZYHsRZFMyDCf295vArfpNtCrbHawQzd84TFcA94VyBhKN3znXzMZkPHyqAwS7ENf5l7qm42YryVqmqBTcT/pEDJzzv+ZOf1HfSqrNx3SJYySgy2C6Sw53alZQlv7fR7TXoYpIlIv4dQJ9DSwqDJr12hofd6g2snZHJYTk9YeJKoLRcu/DUHUC+ww/33uhXYcL8k3cKxspZApAYO65m5f7Sijjjx143DbRzmLAz3MVATBpan/+HusIRHxAkZjQAWryYG3fiqWgEvzyyQikaC8S1muZ39eovdLQfBCPD0UMYHpsWGZ2aLb3yRVMvpGosxaxQNESwBS/SUpnwub//KhYnxsbTiINmoQwWAlfJwc074JAAEeoV1msgv/S4yVvG4Q6d9nZv/08tbXo8RSl7s4wh88lUSxndcQkM1Jcw+J4AeQPXQ0uTCvw/KLLHszWp2v3oILlvw+FCVTz2AY413aGHH5xiFt61ainTe/AHcg/aB5Fth6pbBOdqnDeZOm/05z27ufUXAy0CwM/Kk07eGTVIrBlZUvoNxJYuOZbcNcGcEv/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bf10qvoGVwXuLKhO5v3fbGPDQD+9r/lz3qlJGF2On87Xb5hNSq58FLnyndWm?=
 =?us-ascii?Q?6hV0jc6MFBkiZnc11qfwvK+LI+byYH9qnviOC7NJwmRuIMseVOMZ7O1Nz47y?=
 =?us-ascii?Q?4zo+ZF4cuqoQT08LCgsgBV9OWB58dH5scC9acyi9ntVeC/r9NzYcu5LKJ4F4?=
 =?us-ascii?Q?sPC6fVSqL7W1U4k3aTU+xxeRiBoodbHE7TQ5VkBXSdGrDNNAtFCD5ZM0K1T3?=
 =?us-ascii?Q?31hmNwvfYmznQQezYwgUdoDLqAH/zYHtC7p8PyI9SHaB7YXrZeLVnN7gMpz5?=
 =?us-ascii?Q?tFa1te3H+YAd0d6pNuCyZgz6nhvwk4TlJ9fZyCoGK8P06oTcapU1RP3hFvHa?=
 =?us-ascii?Q?sqWXbIgoGNywlF/hL56veGPnCyE1yeEvJAlit01J2Yw9qTkQEaaHzFzzLNGA?=
 =?us-ascii?Q?eapwmdLEnYL+y+a7wzucMgL4DRFxdWwrhZgWgXHDeJb8TbLOJwA3h8lxfJZw?=
 =?us-ascii?Q?vdC7+bsM8NbN9EHp87O8SUot+5eLH6FNmAP4YSIKy1Whb5n6xUTQBJUtIg3E?=
 =?us-ascii?Q?FW5sFafzJIaUIVtHYLg1GBT2dBPGrcswH09YXCDy8P1YyN6vB+cIOSHkIflJ?=
 =?us-ascii?Q?pkJycHdp6TI+MKJut95M2Dltuji8Qmfkc9BL5OR5jm99PxLYPmioEfm/42OC?=
 =?us-ascii?Q?GMmXOU3idfG4LVaOPBUeDZkIq241dDCqPy1gMu2qjQUSkrBkn6dNvD4h9oCf?=
 =?us-ascii?Q?RxYgqNyHii4OJqeRlCEoWh8kG+36d4eMtdjlnOa8u4k9fPaQYMD1J2YcmhX5?=
 =?us-ascii?Q?CJ6am/zhpji9Q9qTjUXXp8zi7uVzmJ8im05CGgyEdRxXWuimnCULcYAmKHU+?=
 =?us-ascii?Q?VrKj+5S0WxaaA4D7WS/Rg86Z/ns1z/retl+b9zqakDebu7NodfL1Y+9W2aVW?=
 =?us-ascii?Q?3ZPStCsMFI7a8EMWkHdDpotSl8EqPkNksDMSe5G7G2ljoCqLRKCKJeginE0z?=
 =?us-ascii?Q?oZ2KLfM8a+SnhITS6RNf+Wf8wV2Y/sFGclmOmDiH5hD+IMupTUjOgxhTSFi1?=
 =?us-ascii?Q?D3kPWn1jimI1pXeK2r+H0seXumZzqflySlSl3y0NG+PCy31MYdvY+Z+urn3N?=
 =?us-ascii?Q?lU7aItra9L7BLccLw4uvtCKIeufUFVudhKVmxTn7N+AVWU8ltstzzRVbsfIM?=
 =?us-ascii?Q?T+LcmER8dT5a8t1w2RZmzZUqFm3x/99FFOc30mmTP/5frFUEQZbmg0m6ISuu?=
 =?us-ascii?Q?gxTwFzHky9dYKUZCxRMbZd2SIs5uDLZ45DwFNqlwgKX+43d01d5fJWai5Esp?=
 =?us-ascii?Q?Qclczqg6w+zUoUunqKzD8j7x7XwScrR/zdSUr1jVoXJnVpzlDJ69DcdJyyfQ?=
 =?us-ascii?Q?jTLyMBkRnYnJIhMaM9HC5aUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e98c35-7d4c-48a0-d840-08d8eb573fe3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:18:44.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dpzbj6AzUunbwSLi+WOUQ7OScmWEEF7nY2CP2/x6ddzMQp3KhYnuBHfuLjz1N9YolAqqkQJlwe7p+tmqRH39pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <roman.li@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Dcn2.1 socclk entries in bandwidth params are not initialized.
They are not used now, but will be needed for dml validation.

[How]
Populate socclk bw params from dpm clock table

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 01b1853b7750..887a54246bde 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -797,7 +797,18 @@ static struct wm_table lpddr4_wm_table_rn = {
 		},
 	}
 };
+static unsigned int find_socclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
+{
+	int i;
+
+	for (i = 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
+		if (clock_table->SocClocks[i].Vol == voltage)
+			return clock_table->SocClocks[i].Freq;
+	}
 
+	ASSERT(0);
+	return 0;
+}
 static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
 {
 	int i;
@@ -841,6 +852,8 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemClocks[j].Freq;
 		bw_params->clk_table.entries[i].voltage = clock_table->FClocks[j].Vol;
 		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->FClocks[j].Vol);
+		bw_params->clk_table.entries[i].socclk_mhz = find_socclk_for_voltage(clock_table,
+									bw_params->clk_table.entries[i].voltage);
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
