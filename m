Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C10C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB4764DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB4764DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFB26EE6E;
	Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3541F6EE6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmXmpBpqdssRpqYyo2aMIW+HA4lTCCJqtO9SbL8GyK1XT5v8ThPb8mjJ3wmlyXGW9Bp3RHVGjpYCWey0rGlHK8X32E9inAEERzP4JYW3RZQjMwe9hbNjFUSq8b+L9SprAvL58KmdVQwdwMX1dhV9ppebT1Miwb7kZxyfnZVV5bkM+Z8bnTtYgssOu+8qK8hca+rLo8ejDNiYjwyBRyRldz/Bq80iyFPG6qQ2NAZjszYumy1Muq3SCjJcZ5ZwWHZ2RAPISIA/x3s5C869cjECt7DQgqAVuSan11RCCZeQD+wb8Te6k2W+mlwKCe/+4CBaNTUyKov0anQYnLaDoxoZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+QI87nOfy6b16zYVcPTVJT3IJgt7Z3zCJMK37yFdiY=;
 b=cZVdDwKqMWlzFlQhdiYrVM9TlrkMi+lxYRPKlcV0AlR/cl8NZ4lse7qLiJNu48gBbIAojDVxeh2tSRL1WJ/mMeugYmCXoblkkEuaYm3mbChxasuY/S4UONzfpX1o1OXg8da/1kDQi84bg2JMK+L4JVtFaQS2S9p8X9vxadz1pDZOzDz0AiPbTG/LUkIRvhJCglWmKPHquSPw2rVxVlco88EIDNNt3wnqbRrHXtOuf5AT5ZoN2IByGoEMRzM3DHYTJ1D7q0GxSox5BEYPJElupdYipFrPnqfZPB3mqjhylHH7XkbkOJGBab1w6E30wxpbOZ4CVonjcqtF1xrS9C6xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+QI87nOfy6b16zYVcPTVJT3IJgt7Z3zCJMK37yFdiY=;
 b=uyNIJ4VVkVoob8IdjZGLrLh8ycQWyBHlMu+iHHQVHSf5Bk5SIKAdTgtbVBYeCFLcfS5h1efziGKrNkNeDGROoSedduLFrd37G+H5foiSxgaorg303XPYsyv0hdxZdMK7H5dU0dhmylYqrwGFchKnZbBB46T0ZAWEAYgGM8uwEMI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:05 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:05 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/14] drm/amd/display: Fix MPC OGAM power on/off sequence
Date: Thu, 11 Feb 2021 16:44:37 -0500
Message-Id: <20210211214444.8348-8-qingqing.zhuo@amd.com>
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
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d88b23f5-1200-4871-24d7-08d8ced64ae7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235B9B88621C45E8480010FFB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opRO2Mj2YuWqSFyh55KyvYaZQtD3KcCoNnvOvt72T7G7MsokuLUQtYy4SjjeXhIc/KVGL3O9Yl2PKJ4ZtdlXP7/mXDznv1icIug5OK0gv6BQ+IppejLPDl4tu5x2rUqolaCF6wWgKRnfBqNUJ4B0+VYQz7X159XmGf9wbd1ygZt5NoA8mT3A6YBLRf5MjTTjfACs0AQY2ccfXthaGBPRpCrcxeIuf3cue+u7VgFO7SOyCZ0G77yqw9ZDbLpJLipNa2l8wSvKZTDuN6AzvLJseVfVkI2GQTvGxin6vyUMs5ahe0RAc/qoTS+xrFZgr99cJ5VBc3GQ0HSuMsIhBm+P23uXhxAqul8coBVPDymL/zaf7uOdVuPnQkEllAlki6I306IO4JDdX8jmBULOTJW24MURNC9wjZ008afIcxllYaGeUcOPeRKyysx8H56XXUMx3Wtq3HmStUTlXMLG4vy8ul8CEgvKW+cY9uVA07XRJPup/BLSABUaoPK4y5pKJB5xTTZNMOxigKmOh2zsslD6OY/m9GG2ujj7/2voMj6yJ/jUQgmKns16bAlt93GtwExtcHPMwonSydA/Dqvez5WX3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SZ7XTGo09our2/8cgSdrNZoVnLouHkJXcK2W1kCu4h4NZMgm1mHg2lXojYcI?=
 =?us-ascii?Q?sxrfG43Zw7L0MwmWkZQ6+C8VCc1BW8lcamWDKwO3CLk45a1RZY917Hq2LVRl?=
 =?us-ascii?Q?CSttygY/A6ghZuh9UvhKh2UHTFlLQ1vSSrBr+huhPtUtYxcHetDh8GJcQb7n?=
 =?us-ascii?Q?EgUSgBBiagzwLcOzyEB02Pxxo/exxDFzkHUuSEbcjDMEK8s8837KzR5rt+He?=
 =?us-ascii?Q?UpFVv/X1C2fKgcqqp1Z731Oc5M+gBfIpNcC9MMiCVQ7UV11cloMtQf1GnFfv?=
 =?us-ascii?Q?Sn0FpcVqefh/Jgn0yUmYY1DtVg9Ju7pq3T9OzqB4bqdLsfVHrXeKjQqCPr5s?=
 =?us-ascii?Q?audoEgbn6Wg9UFiY6nNkwe7TJs8jmqaKyLpBLgBL4D2Btug1yRE9uGZA3Bn4?=
 =?us-ascii?Q?dQbB/LMKbMiEad+vDajA8QKTWar31UHTZ3FQJCsKOxkvywMIKXAmk5y3wckY?=
 =?us-ascii?Q?sGVdUGGCv9I+P+l8ElGMtkBKjnp6pDbED83eHQniVgF6kD3QTnEMgjp9eaZx?=
 =?us-ascii?Q?jsax06iZJMB0k0d2Gd0HPcmAlkKqhCcJrO3EmVRuLbMvWrgqLUSFTqbdGuDv?=
 =?us-ascii?Q?FPKI4q6icR0AjcCeHOG2NpjcEAhZZhQ17EIsE/ILbgLIz9GfUrv/ji9r2qNv?=
 =?us-ascii?Q?SzgImyhdyK2zFup0t6iFxWoHJPpxHC6KbqAVUa1VPOujB28NAY7N6RMMlUfR?=
 =?us-ascii?Q?qzi/sk6/+lxZCQckLbJsyrkadE2tNoY/pc6rjcxnUwGEm5LArUr8G1EJWQWj?=
 =?us-ascii?Q?DHpUPed0I4CO2tfmSQUz8UYid+AgKXQ1PtjpF9B8RCrstB2WtWIrUgRdfa+9?=
 =?us-ascii?Q?DMy5pYNxkFfx5Qta0mfjxtVkGvOBBYvNANro0z7Z1G+rxMqoN4dpIfFxlYrH?=
 =?us-ascii?Q?ed0u3YqPH96CAgHOCNCVjaeoZozKvjnu2VfkD+6OKODPnTSXx4EzCIegVnIE?=
 =?us-ascii?Q?4lQGHl47Bx99rXx8U66MYPoGtEpZcUBjXRem1Yekn1zfjqLCwfVy0IUHUjPx?=
 =?us-ascii?Q?O3HfNZF9+dU8BoCuBZQqR69PA5BeuOaFRwjhYOLgzq4IA6e+YQ4Qe5W31cuj?=
 =?us-ascii?Q?6scpZ+oZ+ml+Bw3n3l5kzwxTGGp53GcM+cxE937fOb6jOs5UgSrQ80C/9G6+?=
 =?us-ascii?Q?blSX4gB7oL7XLVqb0//JE2MF8jROd2669B6wUlWCHlcPqt+I913b994GHuwi?=
 =?us-ascii?Q?GvEji6E0uEblYNr7NVu9otJgDaamz7j5EaK7eR94xjyiuDY2YCzFmuTToav/?=
 =?us-ascii?Q?gyjsZnGk9TO7WffiJ4kx6W8nhAdwc2l/xRSvGiPjDlewZLZ6NMrbEbby39NQ?=
 =?us-ascii?Q?IdOv63I/c2PWjGQYhQftuDD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88b23f5-1200-4871-24d7-08d8ced64ae7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:04.9459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6PoQcvwZ21B8RbNTLi+Hy5jqH0a7lV+zOFmimvgMqhvPoN7x4M2CGhKA8V8DFaY
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Color corruption can occur on bootup into a login
manager that applies a non-linear gamma LUT because
the LUT may not actually be powered on before writing.

It's cleared on the next full pipe reprogramming as
we switch to LUTB from LUTA and the pipe accessing
the LUT has taken it out of light sleep mode.

[How]
The MPCC_OGAM_MEM_PWR_FORCE register does not force
the current power mode when set to 0. It only forces
when set light sleep, deep sleep or shutdown.

The register to actually force power on and ignore
sleep modes is MPCC_OGAM_MEM_PWR_DIS - a value of 0
will enable power requests and a value of 1 will
disable them.

When PWR_FORCE!=0 is combined with PWR_DIS=0 then
MPCC OGAM memory is forced into the state specified
by the force bits.

If PWR_FORCE is 0 then it respects the mode specified
by MPCC_OGAM_MEM_LOW_PWR_MODE if the RAM LUT is not
in use.

We set that bit to shutdown on low power, but otherwise
it inherits from bootup defaults.

So for the fix:

1. Update the sequence to "force" power on when needed

We can use MPCC_OGAM_MEM_PWR_DIS for this to turn on the
memory even when the block is in bypass and pending to be
enabled for the next frame.

We need this for both low power enabled or disabled.

If we don't set this then we can run into issues when we
first program the LUT from bootup.

2. Don't apply FORCE_SEL

Once we enable power requests with DIS=0 we run into the
issue of the RAM being forced into light sleep and being
unusable for display output. Leave this 0 like we used to
for DCN20.

3. Rely on MPCC OGAM init to determine light sleep/deep sleep

MPC low power debug mode isn't enabled on any ASIC currently
but we'll respect the setting determined during init if it
is.

Lightly tested as working with IGT tests and desktop color
adjustment.

4. Change the MPC resource default for DCN30

It was interleaving the dcn20 and dcn30 versions before
depending on the sequence.

5. REG_WAIT for it to be on whenever we're powering up the
memory

Otherwise we can write register values too early and we'll
get corruption.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 3e6f76096119..a7598356f37d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -143,16 +143,18 @@ static void mpc3_power_on_ogam_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
-		// Force power on
-		REG_UPDATE(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_DIS, power_on == true ? 1:0);
-		// Wait for confirmation when powering on
-		if (power_on)
-			REG_WAIT(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_STATE, 0, 10, 10);
-	} else {
-		REG_SET(MPCC_MEM_PWR_CTRL[mpcc_id], 0,
-				MPCC_OGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
-	}
+	/*
+	 * Powering on: force memory active so the LUT can be updated.
+	 * Powering off: allow entering memory low power mode
+	 *
+	 * Memory low power mode is controlled during MPC OGAM LUT init.
+	 */
+	REG_UPDATE(MPCC_MEM_PWR_CTRL[mpcc_id],
+		   MPCC_OGAM_MEM_PWR_DIS, power_on != 0);
+
+	/* Wait for memory to be powered on - we won't be able to write to it otherwise. */
+	if (power_on)
+		REG_WAIT(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_STATE, 0, 10, 10);
 }
 
 static void mpc3_configure_ogam_lut(
@@ -1427,7 +1429,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.acquire_rmu = mpcc3_acquire_rmu,
 	.program_3dlut = mpc3_program_3dlut,
 	.release_rmu = mpcc3_release_rmu,
-	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
+	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
