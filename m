Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44DBC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977A564E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977A564E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB1989E06;
	Mon, 15 Mar 2021 11:23:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A87789E1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY00m2k0BqMh14NGAROVUcNl75Ng3FzGfhNaZ9yCtKx0p4Xc3kw1GHoTeKE6taG/je1O6MhN65/LPYOfBpPpBe32eDKTI7vi6B516sWAAuCuIjrtEOsoUIrNgMgKtpHzlHQS1gI74hoBhR2BwtEDmunS4YqJMRROQ31NfMiKV5gt68kKyS/OfU8Od4Z0cPPrrY+1qfz1F7aYnx+932b/zUsG4TrFXTVwMxT/7YtkpBPp86M7OBaKySschGebJSn/dEn87483XAhudXRZDprsugsUWyVwW8eQiqETB20L0czXQ3IZ12vW/7y5CiBBKD4wmHYXOTTnJTD45RxaPj21mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyW0qJWLe+hhs4X3P4ZRs2ZLayKMroYx+Z94gSfPOVA=;
 b=MkcRIZdTW4uEdIKgmZHJvnt7xBjDNOIscH/DH4No7ntibCyFDQtnucepwhaOznGoJZn5UY1fLt960wbqir5i5iVnMyf5i/NIr4ewv0k9bIEDZcFR7GjMUjWLNkHon+LCt+ANt92OAbvzFfswptrOndvv9mR7BwBb/YQmpx95dAZpYbKVTZKsFjMHWqJmp46AfvYPrki2TPKg2w4SYWJgOF4Ify3oRgjlqmhIp9clXXSFKH2uH+EgUzdfLik8juJilMcYnI3Nf4Hf0nw9EV7aFzDsU3kxOK+gkpLkvWIj515g9fgG/WOaCGFBvSdvcPTlKvp2s8KTxzGaSCc6MPka3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyW0qJWLe+hhs4X3P4ZRs2ZLayKMroYx+Z94gSfPOVA=;
 b=H2nPSdJcn7Ye0rNP5ecUYqCNtKbyPa83+s2LiSinDd2JxCqb3js+ytU3fJqhyCkRrTJ7dhwhOAr3sfK14/FkHhe5cdKPAkrS76EbVmKrCDVrAbgQAs9nRUx+dl6J0qYbBsBQYVXZLHTdB1EjB0CJssjyM28pkW+1SthhflXJPTo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:34 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:34 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/23] drm/amd/display: DCHUB underflow counter increasing in
 some scenarios
Date: Mon, 15 Mar 2021 09:40:05 +0800
Message-Id: <20210315014010.16238-19-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2c24655-b5a8-472a-a8e5-08d8e7a4c4cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461720A65F6C1717F57BC8CD976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQfkVKwNMbZw5yMX4Ia9hYDJxU04PGCHpS5gtRznvVy61lPbxriUDdwyESsPdx2/zcLUwyb6B9RnwvC1nQTIsLjKenfVBBzq4M2IxRupK1hP1V2YqekPVYponvz466jK1CFGx6gabUnZytSn50MHGR5RM5rWkbGWQWovFM001nOFvytLrBka8YcrG06K8KhelQHbYIzkp2qIZvolp5khNWhZI+RPud3CcvJD23H4PmxDXXUAgQ27X1BiQCcmnwAj9HDGpR4AsxnJKZaEN2F0/EjBEZ+rwFYlq4g7CBbU9O4sGtnOhhSuoXY/7WyMs2mZUcb/ho2azIHe6eluIP1LHT8e5dCDA+Ssr2MxcYZQ075TWiTpB0neTcDBiRdm3gwr9TJFDlLb1ayQXZZ2kC+SZesYp8BYcIaHeCnIWC5gnRyBs1MgicPwr83wkExqQQhdmETEMhI9MZizoGXG6cghJITvfl/YZEU6Jx0bw2TjAP1fE2NfvO6PIKwSXFcw8xNizMkt7LwzhCbzS1kKkTyNK94amwINorEpkSpM3uEr1tX7gF74Z9lQwSsfWR1SlAgA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c4zrcx+nunJ1hk2/YWomFkR6Vlkyz00BIIaCdAod8QihNFT7/APWgvYefr6Y?=
 =?us-ascii?Q?KOMz51kPDjcEjc7G3dudDjeKvhe80vJ5UqUam6zJ3ns9aCyuSo67DFcfIxdH?=
 =?us-ascii?Q?Egkn9CpOiJn3/PA47CWWpDkPuE/TLNA+EmHa9bHGDqSW2wSOBPoNAjSq5ULQ?=
 =?us-ascii?Q?SfruZp/RwgqzIaJUQPoCiYkm2JWQGMo/EQOa1UPmeEc8o2Fwbs/NGhA+KpHv?=
 =?us-ascii?Q?AgHy5JEXKGwSFPwAdvPH5zi9RfsvjYZf4pLtkIFTMg85DikejAtEW/UOXJ5t?=
 =?us-ascii?Q?tpKlWtDKrzcpMSNA6af3jCC9A5DIk0+i73G8ghgCHu/IMp+eFwQ3WWiFp9+V?=
 =?us-ascii?Q?jfJCLv6Tyfh/rQiL+H8CdXwG2n0YV0OzkMsbthzP9ntAzCphxZd2N3p9N+QQ?=
 =?us-ascii?Q?oKbvnRbxq/kkq95/hVgJpc6LERYy9tJTwwTJmCMGcW9lPz+wn2aqawuFOz3j?=
 =?us-ascii?Q?W86Slt+j4mfoL2nEdaG3wq4oM78Wj6/M1fJMw3P9MGoYlDbHqIsu5dZzFjVv?=
 =?us-ascii?Q?vkGUgUusBOpRFiadIw6ELtZGe6Y11anUMjyH3wB0cLmU/AnfTEAS4b558rJX?=
 =?us-ascii?Q?fHAf+UnFhSjIk8p0tcqqjDSg55tOGyVeRmU76Eug+BorVaF76HyniQ70/yvN?=
 =?us-ascii?Q?fgLaKiOKhjUk4S1bDJmfpwMHEV4eMzdTb1b0/DH6DxdAbehEx+lDcGBGUBAR?=
 =?us-ascii?Q?cCTziVDMoAhQdJta44XQ4fEBFYotlO8n32Q4/SmjV1QSlpy9aOYcDt9spZy/?=
 =?us-ascii?Q?XUCP+IPoflyGN1s0xK2at9pSht7m2dochXvwWiCS8sieTuJ0Ym/5ecTuZKFu?=
 =?us-ascii?Q?ur1Bsj23QCOzW0yp7kK64o0ut15uiLBX6bfb4/bPFlbnAmRhyNgnIEIdsyZB?=
 =?us-ascii?Q?I0nG3jIljV3vfVjOF7iuV5M3AbI0MVwLga9JhTAeqKWxYHpjZM+epuZyjuRY?=
 =?us-ascii?Q?3nHlztN11ce+su+wFUVd1dxjSrZQKjDcDfa3UlVx8zLdThjLHgTMnhvxEC4G?=
 =?us-ascii?Q?MUAAxY/bZ82a3GemUDrcD8Ft614AKvrT5VsO2ql+a0Jnpoa68fqEJPcM3BSF?=
 =?us-ascii?Q?4YZ4tJhhpHHYLqUQUsaPPhTRgj0FeoXIWQNgypGb5owvqK75hO1XSnFtIDRm?=
 =?us-ascii?Q?gqu1KIWzmXyYZAuR1IITGLxjZVXHjak3VlXG2AF4kuRet7ZX+T09S0YnzSWH?=
 =?us-ascii?Q?VrwjOp+KqO33dEDSfjKdhghpC8sR7YrZAzkxPERsjGod2xhmxZ264Z2MGA/s?=
 =?us-ascii?Q?jCIeAeyuHtIwHSel6OexntCtDWr7eEmrVEP+H2JUSKm4NU+W4YfHdxp5xEYk?=
 =?us-ascii?Q?ZqoxG3pdOwbEoF+1aURT32HUTNejwHa8eTIV2EspqDmy5Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c24655-b5a8-472a-a8e5-08d8e7a4c4cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:33.8837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p58XVp8Jh+bhrY9S0K0uE1rtMNM3C33u8c4UZKnDLe8lBXiseFYgQTZo8zLBbInrKkl6yXHyF5xtpBzKSyh4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When unplugging a display, the underflow counter can be seen to
increase because PSTATE switch is allowed even when some planes are not
blanked.

[How]
Check that all planes are not active instead of all streams before
allowing PSTATE change.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index c7e5a64e06af..81ea5d3a1947 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -252,6 +252,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool force_reset = false;
 	bool update_uclk = false;
 	bool p_state_change_support;
+	int total_plane_count;
 
 	if (dc->work_arounds.skip_clock_update || !clk_mgr->smu_present)
 		return;
@@ -292,7 +293,8 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
 	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-	p_state_change_support = new_clocks->p_state_change_support || (display_count == 0);
+	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+	p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
 	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
 		clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
