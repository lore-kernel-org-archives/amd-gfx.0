Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57622C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222E36186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222E36186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79556E247;
	Thu, 11 Feb 2021 21:45:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E69B6EE6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/eCrc7vyua5QQeo6AQLTf4sfqIWZSglRdGU4cKQbF6aXa5F/O5/1IFpJZdgQ6qxrO8/lx6+i6EMDdYjZJhB/rgdIeyR9PUzNV3j3ZRWDMWj9yQS68RaInav5mz9iU8CbWkX2pB8yozhk4jnR5Gz8eWjnVtSnOXkSNJXDW8VRd/9SQzlJqfwGrzLatnVN+3zIz1N7a6FR2iMmrAc3VDdUiobzFu7EMewNpDr7F2v8/tnVVBBksNJkViTmLH5EcdW2cvVWCvHtJg2mLPIUe5N7ifYaE2V9vsvCKPbumn+vYMpeylVfbzra6rlnnaV0Cv02VlnDb4AEEOL4thzc4hA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K0IsDnjtWIodUOwSe4GhzvWISUa79Iysv/O71Sy9es=;
 b=hwPsbnyK4UyGjH3/5P1S1kzH9IC4Vi427G9gBKArwSC14tXwskJaMea9nJNCsXmgJ7PQRi/IZ6TInlDIH86gbnnMClnLVCFcIXyfVEBZF8SNO6uxGT9c/wo4j6u3tjp+XwuiOqlIoSdS8nx7VlNmlu5AaXRpXdAOs4X5Fwv+LlmwIKznHjTi2h+iZx8/9dpT0H2HJ1iNWPvUcvJ7bMfOxpj3iFg6+ZiKDPfgX1wkX9iLGBOV/MVWN/mtSgzgzIiD83MGUgLOYEzFsrF6itfLyKp6I8MFaJM3GDd8kxtuVjcACHdh06tVFX/C3DQkTvymhDbi05JyulRw46G4malmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K0IsDnjtWIodUOwSe4GhzvWISUa79Iysv/O71Sy9es=;
 b=I5WbyIgo+lYC2foFkBu931EtTX5EPZczguxdicL1fbErXmXFcSHvFnJbC6uDCkS8FBPDw9FPkVtKrxUKbZ1sqDLAe+04LzOlkSL2qvMg4y0TEm+N9/LUEwoOocOCalLCPR+jV+sohz3fgMpLcyaiJjxzB7m3kk+5KKkyRkijvAQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:06 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:06 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/14] drm/amd/display: Populate dcn2.1 bounding box before
 state duplication
Date: Thu, 11 Feb 2021 16:44:38 -0500
Message-Id: <20210211214444.8348-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60aa7677-98b2-4ba8-5f55-08d8ced64b7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB423574117DF1428539500378FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6Z19ADWltKF01dHX8RQJsmpbnT6NxVFd6TmAE0nazrIR0LQgEXdXfe+vPUtiI2HVArKZ+KUcA3/UXfPFefYBLx73en+X16wI7UC+FiEZWDEcKKq8DLfEPGsplf7CxihD6CzW8iX1unQodaMa9W5BlpH9lhhRkO8UK5NB/Y/3KMhZO2rzHAxzCjD9MdCwoytBeKEWVCLuHxxr6FnuEQrfK0VRDY/Hz8xCI4aeLXqZ8ycGl0HP6jAD8vtYRcXzgCadsjTQjwM5fAY3sd1b4xxj1ycnoyKuuYra5dJP6JJxCWubrSbdG2dw9mTjzYXZJRtaZExjC/KesqN2n5O4nLFXJNoWpWx5ASA5hs9er2MEeIicJhQWxnxAqWe+7mW2i918xg2E32FHx2G6eUPpB/le6+0E1BbUa2Tl0JcCHPoP80ZgXu1OFrPDtoRXtL3Oy8PGoKbbfOuxijTl19Iq/o9n38qo4RAeQ7wM+XcOJeZrre6+PAu7GQHbuJZG6HziwWUZJ49gwt+V2/JoqQyB3QeCEAkuUB5LPrTNyEQRT3MCshPZh0OGi93OkCPJ6l6yudanqdYgi/l8J0bw9e7auWN9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y6hBSCC5cUKA0l2eQCKGrSL6pqR+pv6PDnoscK+5lpACdgANnECj/2QnFd9B?=
 =?us-ascii?Q?x2dqL/wshHA+AJV0TUcHhh7TCsJgwbowzlF6ms0mw4tYToBUKSqWUYiO6CEz?=
 =?us-ascii?Q?K5JeNF43rsTmD60Eavtcnal0TyXQlcSVSQ2Q7av60VIqdN1B+v1vfmXqLlvV?=
 =?us-ascii?Q?RMqie4zDcKPs6klhrCxwcVYhrxPTBs3wZ0/HsvBkCZzq91RSdDMsugK3vW+i?=
 =?us-ascii?Q?mxeXq9nKP+smcyvd42cIpepc4bbRaflo/1U8cVjyuFj2THNGDaZVUsxT9RnC?=
 =?us-ascii?Q?Ee64rZqcpnQqarYKsj/58fwr9Ni2aTlZUbUqInZ0xm+xsjboxflruZktqhpT?=
 =?us-ascii?Q?EOO0VB40WBHqu4icUAmRGISDitv9XAkBiqaXGUkBBEM+E9fRcGrNZLNPBvVv?=
 =?us-ascii?Q?rG0ry1QrsQsvHDPCSthJLKn5SqiTHo0znO9UqzmDWdyoBrHneR5mGuxs9kpZ?=
 =?us-ascii?Q?RHGw/jGH35lBDQUhImRruuQz8Gt+rTYlHzfHIzpTns76MB+TqP95oV8obvCW?=
 =?us-ascii?Q?JXapMs2qH/tcna2jgGAO2EdZ+RWQcAOfGdqU2PwA3+AZj0q+mvpeLV0dsHNv?=
 =?us-ascii?Q?SHiKiABqHv35M8X38OP9H13Nsulnd/336Wca54zC6mzqOfodInGx8Hj001xy?=
 =?us-ascii?Q?OjNMmV2BV0VeAP/xJjAhYnZLyBPoDLoUciDIlQxvwpnN/Nyp8BwFQ+d+c5Bv?=
 =?us-ascii?Q?jNSr7mGkaIumnN8atbT1bt3elw5jdd9fRPlMilOslEgWfayrecm5zHjSJbwF?=
 =?us-ascii?Q?/Pw7aJKT97vDD16X7zQ0yhLSlStptf0rSXMlSo1n17BxKYFF288f3GmK3VmR?=
 =?us-ascii?Q?QLvyPoC9GRVmSDyIhYT1oRhisXxO5LrpsyjacLOZ8nPcJLCiuoo/CIX2RLY/?=
 =?us-ascii?Q?8nmP8oddPTsGU5iPq65xLFco76ayVuzKbZ7lnCQUcmle5DdAmTRDUXzxLAGz?=
 =?us-ascii?Q?iiDtaVxzWE2eS+EL6Kh1Bb6l01IQmJf1/xnLD92NIh3wTPHNIIhfDsUXR0hI?=
 =?us-ascii?Q?Ik6nu5XN3I2I7RmHs6TLk9ct/akeLUkaop4ot0yQcFaXoszRfkQSVhSEAYGh?=
 =?us-ascii?Q?2S/i2OaPxtN1lxjIKAo/VmLVs3bPulO5BxzjFjqH7IjSQnOC1rkNxc9k2AXY?=
 =?us-ascii?Q?vi8NHslx/Qc7SjvXElhepcu8AkqF26TeX/gxjZv6m80azI0z2WVV60MB/32C?=
 =?us-ascii?Q?Nn68rsW3cJ4CdtUk0SWJU3Cvv7II0zvkk22hhruuLbBg0qJEokHXhhp5RQrP?=
 =?us-ascii?Q?ETXdvS4AbawOiFqDjd44k6CZ5igI9KwhH4N9SMiE12Iz8xuxe5mcEcQ/JvSe?=
 =?us-ascii?Q?HmqGZISZbSng9R8Ls2/I2bDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aa7677-98b2-4ba8-5f55-08d8ced64b7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:06.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQpnHYsys9tYmUUcDOmR4n2m451b6HjYT0ZzDa/g6uM02AsnM9kFsdU653tzyBnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
If system is overclocked, only 1 bounding box state will
be sent by SMU. This results in an empty state being copied
for DML calculations causing black screens and corruption.

[How]
Fully populate bounding box before duplicating last state.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 674376428916..d6d78438ea08 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1616,11 +1616,11 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn2_1_soc.clock_limits[i] = clock_limits[i];
 	if (clk_table->num_entries) {
 		dcn2_1_soc.num_states = clk_table->num_entries + 1;
+		/* fill in min DF PState */
+		dcn2_1_soc.clock_limits[1] = construct_low_pstate_lvl(clk_table, closest_clk_lvl);
 		/* duplicate last level */
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
-		/* fill in min DF PState */
-		dcn2_1_soc.clock_limits[1] = construct_low_pstate_lvl(clk_table, closest_clk_lvl);
 	}
 
 	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
