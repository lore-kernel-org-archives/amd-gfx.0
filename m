Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B9864E81
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B9864E81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21BC89DF9;
	Mon, 15 Mar 2021 11:23:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E862B89DF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwbX9i51OwbVCcCdUgrbqItA46hLUAZpnxzxdBu0LHGZ/Sd3tH6ATNfq3M9zCkDoHVKykgPcXcYDAbYl6t5apbaBMEW3fAy18qATukll+R8V72pFFDDk0SaE5GfE08d/gS70iAn7DbNWaPn8w+8vn+e4cmcQz5JN3WXyTqDKO8bR8qWCMFaGQ+aqQHJ3gPJk/Lr9h/sdkRHBMWplsckY40DNiyvXvYklRLCVKPXfLDOYv5/O8wTK2pV35U0Bj4pOZNYCcncXVLgnr1diZb6KY+eQF93YK/ih7ArHByH3naqD2dWqbrZ/EGiAQE8Auqk0E7ukQIYgaKBVyh6GDZS51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjIphVUPrSsIeL0M1UF5D1Dm6nJksia2AK2MgWdRRx4=;
 b=QNKBPu1YvFFXrVmlBn+jiWrYeJoAZh6IH160RIaYQ+TFq50GmMeglyx1U+WiyeXg63pO8IVsm9eyfIt0BxNPjY4OGnbiR09Cu8WnMaVnDL+SjEwug1ofDpGbHOoJHooyZBXsdRn125oydEykxp5GWMfQiG3gQXRHJE5lLrACHZBNFJKEG29EbeSwg80EEmZMdapLLRv9dlzAVK5rsli82uBFInrObztmMBVUa7rHmSb7R7DATydVXHiIDDRNYKEr1etR3dmmosjF66WF8KkcmKoj1JVWnz49PSME/pOQXHVEP87BL7yH2yXwa/szxBSuNCVb+7BM8xt71UbAyBf4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjIphVUPrSsIeL0M1UF5D1Dm6nJksia2AK2MgWdRRx4=;
 b=vhQhf2KvZYyCI0sEBCISudT4CMotUgxD+d+uB94wAKInTwqLf3IGHULr3ggEMZk7voJiqkzDQKE7UBTVuImKc4rQxuFEfWlCobjOM2nbltZ7eP2tfSihTfS9I555H0e1pQxqO9rPx+HpPL99lxRsT3YTaBIr+DMHOIbuCCCD670=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:08 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:08 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/23] drm/amd/display: Fix typo for helpers function name
Date: Mon, 15 Mar 2021 09:39:59 +0800
Message-Id: <20210315014010.16238-13-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2d9092e-9d34-4378-6631-08d8e7a4b597
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37408CC961894701FC06B5B9976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Om3WM6DOQqIAc5z8Upa42y4QwV14Mah2YZZezRGRcXqwPWaRBqNH7rs0iNtYpOGehVNpITqEaF9mBJVrPUyUvNqq7E5meOE4w3CgFo9c9waeSEu69bUgYlM7p2CYktChH5iuzdSY/dqq/VdJyHBcJwtE0dsql/YJfj5zfXoE3oAUp6Q5sDFXjGK0qDre8JCtYC2SKh+SSFEnsIxgOEOrBEykL0cYHv28EB/jUb7KgLyNGjEx56opQaxMa6vZvLCxZhR1ZmAEzLOMQ8O7NGfIji6zgAV6NZT0v6HGktoqyF8rtmsrtzRsLT2jorHx5niMAOwYm5XXSo/eMpNuSTsx0R9A/jArxMX3ErQTAZwpSE+9Uywz4or88XeF7TM/4T4Qx2mHomv5rllte5ic7IJUaheXPBPiWT0BPwxeVDXkqBvWD5p75Utf52URYnqXA/6EzvwfKt5MnUg22I8Q93QRIZteM6wEepSRfT6++Nf73BRSANGys4L9l6DgenXRZ/awceXudTjZKDx61jrc7BaNZiwq/omgeTVTGtBIO7q9G7HPDuqHk6ta6n273PkpIgzn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(6666004)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1qUrB45HqoSOWSU1TRa7Fe/ETlUjIRHLMaCWsdNO95zT/nmzyPtvkXzsi8U8?=
 =?us-ascii?Q?2yS4z00zeRvDREQIG2glhGX5mWfP7XsKW+MrTpOke4XmyH2hQMq1OJWfFYEU?=
 =?us-ascii?Q?N6riIoxTs60aqzH1VjggEyhNBxXVIk5ZE7auVGiNbSUDeIpOhj0xXYwY9PV1?=
 =?us-ascii?Q?Wl3Yo3HP3fw8cmi+4vBtUKg2w6grvF9z7PUU0h5iy27oDFvz3O6quC3xiG4j?=
 =?us-ascii?Q?ObAhXZX1RTG+0Am5CTcHZon/sFtOKuxGuy9pq/EknZVFKDYAFJFFONmDgQDQ?=
 =?us-ascii?Q?ub/r9ASvYr5pyN4f/i8DMo1VD90HpldnOupTO4uCW+01+qigzzl8wMjMjKxA?=
 =?us-ascii?Q?OMIvL/GlhhJfrpIkd1pfapEgeFxUUwk0qZ6TOO/6XJRSanRIEjN0SQkBaUGB?=
 =?us-ascii?Q?KRCGRWHHqURHRrKHbNtCxeUZxVeeVw8uWPM46lb3NbB2iE8mFyqOZEfwAaDc?=
 =?us-ascii?Q?nBTNT87ZJl9gDABdh5+mYfyOCp/60fpUkkJzSZMTJF3buRHcduhiyBmpeNeO?=
 =?us-ascii?Q?Ggpi8sZC+AhXs69WNCHS4q/HZoINrcfZjq+D1ZwZmIG6cxo8jYlEk2ThBE2m?=
 =?us-ascii?Q?zULd9TNvWYTgpTeCSnUgqWymmcr2l2RG+FfWxk8LjuiDTtCMTTOa7NwfDHo7?=
 =?us-ascii?Q?HNyKwcoTct/GbwlzNe+OO+Iyq/i1WP/c9eajhOzubKqk/Et7YhpTcITYstRm?=
 =?us-ascii?Q?4DtfOgDT3xswiYY77OErF8uiiX3K7XxbXG1H+z9JWa1huldP+go56sl4YISl?=
 =?us-ascii?Q?Et1KDmuWxjXenF7za7ivweDi3kRy6NdzxmApsVmv4GQCmK4Vhmhyas0B0qjo?=
 =?us-ascii?Q?/cAYCn6MAxRNK+E7lQa1fYmeFj2SdjhA1m53pS/EMwKAIOerRh4EReplheX3?=
 =?us-ascii?Q?yM/wJAjom+BCoM/FelJ2JCBfY6AmHnBGEXTFowhVwaV+xBeMvpqOPTj/TRzL?=
 =?us-ascii?Q?hSe/LLgZc+UjghIUEW/mK2I3V8zKF23r2eYL8RFUtZ8A7k8kPrmPe0PW0Qpv?=
 =?us-ascii?Q?hg/GoS7IDzxpHmXO3CccmNwTV2qJZ5v9vwO9yFJ405tkYARMetwbEyDb4J+5?=
 =?us-ascii?Q?kJtaxy9UADqY9iGv843yEMH6m/J6/KdL82qa0Gb3jBmjjg547LWRHllm/fMK?=
 =?us-ascii?Q?yRY4KcPCjEVNP2sM2Eha0ZzknQJ5ol7WsRC2IsdW+Rou/pUWCOh3p/Y3kS5S?=
 =?us-ascii?Q?vw0YjEajweu+hHCZQcqlV8SuL4FY1TLoQP1ZzjQ2J1Dwi5UDjdM5vbhXB/Z8?=
 =?us-ascii?Q?az7qk8na34huDkfCCKvVFzchrEpMUP5Kw9IrDDRESHFx4sy1HxmmlNFL2zB9?=
 =?us-ascii?Q?93j0IaHxQxc4oioPos/vu54QB+HYxE/3I3cQytXlzQ36SQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d9092e-9d34-4378-6631-08d8e7a4b597
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:08.2674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLKwXrhP+QgeK8wlgPZidaOeucQ7TlhkLuFVtz7TScySMHCNE60K/1782CcWAmc3XUGSCSrS/bukpGSe98Uy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[why]
Word "helper" was misspelled as "helpes" in
dm_helpes_dmub_outbox0_interrupt_control function.

[how]
Fix the spelling.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b0e49d01c206..09bdffb3a09e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -698,7 +698,7 @@ void dm_helpers_free_gpu_mem(
 	}
 }
 
-bool dm_helpes_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable)
+bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable)
 {
 	// TODO
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 68453c29c617..6b72af2b3f4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -180,5 +180,5 @@ bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_bu
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable)
 {
-	dm_helpes_dmub_outbox0_interrupt_control(dc->ctx, enable);
+	dm_helpers_dmub_outbox0_interrupt_control(dc->ctx, enable);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 65704f46c79b..f41db27c44de 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -156,6 +156,6 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
-bool dm_helpes_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable);
+bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable);
 
 #endif /* __DM_HELPERS__ */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
