Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C7C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8B26196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8B26196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C506EB23;
	Sat, 20 Mar 2021 04:19:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0C26EB25
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvTZ9pArFoTM1DwLiH1iufkwuv0oj4X9N5r1J0/59sbLpmv97/0gcCjD0Iq70rcOaxLZUgkRhh8Lyb8gW3F0JPqMjRqyG+AqYMT7+ysRNsFwwNktBqC2CaP4htFZc/9Ys6t7W0oIYXJt9tktGxlCZSaynZzMVo4T/1WebPjytklsCiRsC8uicYFelPQi7FNDHEEKB7L4mDfWSPy08dOYrQGGVkcomr/rKLKgTzMkdsNa2Wlsci4ej/z0U1EuULq/2h65l4uBSu29s8/4tjlgsoIOMqleZ6Tx0k6cEKYXFDwkIEO74tZnNyhTxNq7PLKg2jraabndMJ3ytB4OY+emSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWRqwhFR3K8SdWwRduGy8DDPZqxpa/QPVcsApKEMjAE=;
 b=HJU5j7lN4VeS1kkvH6HXOUF5xA3ShCZDfLfkWgyoiEsgz50ZodvK19xFIZZCS1YlR7IWGEV/Vf8QNyS8fR6AohsqXa4DSFpsQ0GnjcGsNaavcojFAfeE/wFjfj4iBAHR2wNMi029ItaJP5YuUIH1w3ZOoUYiAMLuONh/hETsjb+wnS8ouKZlnYvwL5W4mqqLDioBNf0amKebnEVp2tHvW5gC8iU+2HMN68lq2oBkdmfzb4S3HgW0nzEMJ+JadfMEbI1jlPzV6+DKCQaH+DVVzFKpTwBFs7gcjKtzcOPSUeVA+lnPCsoexqsZCeWccU+HIGbQaTxSquuFHkU0vKJKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWRqwhFR3K8SdWwRduGy8DDPZqxpa/QPVcsApKEMjAE=;
 b=HFdyh/Q931QjgmLpUgXQrwlWwvi8+2atv4TYZjzzhwcfQ2WUiKyHLXsg8KRTTwRjy2ZVVix5Ns96qU+vLgry9yHjJWV24KODZXVvaXG4J4lCZCmI5czhHIKzX8DznmQam78qLECM1mHR8e0vO7IjyBVgahA52B9FAACUjRDOvEw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:07 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:07 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amd/display: Fix debugfs link_settings entry
Date: Sat, 20 Mar 2021 09:46:48 +0800
Message-Id: <20210320014656.23350-7-solomon.chiu@amd.com>
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
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca483d90-77a2-4b5a-db95-08d8eb574d4b
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704394565FB2DBEA38C741597679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF/uQXY0yf9QozLLP3JAPKQ9sg+72DmiAbBXkD0c9dRsMuLCPVAKtmKQXx1wIourr1xYpCnvXRzbW8dDHqxZ/kHIOqc4EQrgvNnwGxW01OYNjQeSHR5FDqcXVJWgR/4CigwH3dPcNJ0lygZ8C4XLBRWxo5kGfgBSuK/egdjy70U8CRcS+roTH1AkY2DWzDA9b5IyDF0P4LalgQcdlR2lKHmY8fXTr0n68yxJL/s0wDsWS5Y7psYS7qZx7GqTNro9s9ZloUJ7xk3eCNJPqjEnFIaBfi922Uvm6AEzG7hNzj2j9vK6BNXMiO7i6ONQTwiy7gwiaPlkJYLL2vAw20dXrZ4MpxHNozn5WFnwQsoAllI05Nw2ast6M8DwLroY8Rwn0V+KJE9CpxTrAqQmCSUgLNKKBViT58RqsXgngHucEec7sbSqIug3GXp+KTNEPJXAwhWTyDPLCZWhtDRWvC6vcvc639N0h8ezbgPXrFFjwJdPcXefX6dUrcrLFuyi6IrQFeXGG9EIjjqyOcd8j57xGTQwM5Erm7YZcupEXA4MVCxoA46Xlrm8g4FLAM7xA8aRLqVd19J9JRpKneh/LtAr2c8NBDv1tItwQiPUWk5bFjF/a/PstQQd+M0rhGpW+RyZMGKAwHEy1hIVS7uyR9Dgzy98b9nEqKgsnlCxGT41+xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3md9Y+mjRR7KSacLMvddKdyU1Jm9Zkjvn32BYOuMIzz01OEKL72Uq+bWgluH?=
 =?us-ascii?Q?+DPSQJ8KrHLywJ0OaU456EggHMhfQ2gjeSwP6B/CzV0S9a5UZig8zhvHRnQO?=
 =?us-ascii?Q?BmkBviav3E3sbZ1c5gLDq2enWC0nrzvujtS3Bp+s4zuX20g/V84sbfkgHHwX?=
 =?us-ascii?Q?3QQDB8v0/zpXyZLtNfH/MpGEHF5bT9OEV02N//+bnoOQ37n1D1eLryjfMvlB?=
 =?us-ascii?Q?IvWFPf3kWAFGJLUJvypUTPLjBUMld/leH+GTGldWcdX9+6bvLzqYVl5eqdIj?=
 =?us-ascii?Q?JbtksfVp/jfdwb5f1UuVpE85z8/Q4EMeeY0KBiLl/7zbeNIYINCOr2FTBXHx?=
 =?us-ascii?Q?9gKvdbLZhRR9DbNf6vCE9gU297fUI2345WEITkEWJRt5ZF0kDYsJvRBIAE5K?=
 =?us-ascii?Q?6Py/WHAvFCJlqbikhFPQu3VgPHLaLJaDfEQrLR1Mi6qQgQl3Xpb/3JRP9cWX?=
 =?us-ascii?Q?nW76CFWBXGdk83BS+M0SBrXE/7coPVSuJ/29McHxEKoMqrsI2wvOdP8YTDVu?=
 =?us-ascii?Q?r9myPXPLZm+b7lEn1nSeYIj/WyBJm71SE2pzm82nEyKS+7JMxFCbc+45cff8?=
 =?us-ascii?Q?uA/Oq4RC+vX0EXwLshzi9m+4ufOZ62XOzTsQZtBaQbLda+aIrvHtqyW9eZzE?=
 =?us-ascii?Q?Z4uzRBbmJrcg6bLT7JCxX+1dacdws4fCBh2BpLVDn8QFXVGbFgBucdOEpMIr?=
 =?us-ascii?Q?uDitfR9FqHoBGkUDwLpbvc7RZJa8Z9QUNaf6dRrV2aTZdOUglbYtfpg6eZVx?=
 =?us-ascii?Q?C7ytlq0ea43tVgn6ImpcB6U3ul3KPuftQbgMCo8xKl1spZY+taLBLcVoHZ98?=
 =?us-ascii?Q?Ei1h87izrO1uFJ6WgXIwL/X0Ur7FBsmL3L0XssJHWz+io3r8L8dIETbXyazk?=
 =?us-ascii?Q?e0u2HkNWxrATpVp/Em78a4wQqg2e5TqJNGeDMpZZ+TWmLtXmLh30px6yqAvn?=
 =?us-ascii?Q?TzZd/UJZvjjyqIh049UrEz0BcTKnVnGCHSFWzrMe+4RMaHrtyw7TGXZc9Wh6?=
 =?us-ascii?Q?MgzCgKy4tfFQaBw6KexRfIfZykjCVspAUy1Js3oG97B2V9EKKbxRps9xPlF3?=
 =?us-ascii?Q?cRIil3vAXzbbZb2kM8xj1igRS4yE9xviwfyQX+pGZd1Fc1n3KqQMTdf3DPiB?=
 =?us-ascii?Q?F5I2aFrB0y87+jNYEMEPIYWAS0PAfyrI3T0qgnwHTnuQV6QugzQ8bJSyw4/G?=
 =?us-ascii?Q?726H5v1N7KzlXCZ+JJe1NEeW/qe0cwAFe4op3gsgztkVdh7nsquW7FdM+PVB?=
 =?us-ascii?Q?HTV/FUFP3lzo4H+rCisGj7lwB9W18HIqQ8S3fG2Q+T0rCrN682i5b8ir9Kp7?=
 =?us-ascii?Q?ruFnlgzABLPXBbYWggpMaDKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca483d90-77a2-4b5a-db95-08d8eb574d4b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:06.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jFxpcNDQkzGDOVeh+3Hk6GVe3PPi+7HDAx1JSWdRT69malHs+C+j2NFa7qvn5Z3zySEEu48niuXCRvrTA7aXA==
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

1. Catch invalid link_rate and link_count settings
2. Call dc interface to overwrite preferred link settings, and wait
until next stream update to apply the new settings.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 927de7678a4f..f6f10a8c3e43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -149,7 +149,7 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
  *
  * --- to get dp configuration
  *
- * cat link_settings
+ * cat /sys/kernel/debug/dri/0/DP-x/link_settings
  *
  * It will list current, verified, reported, preferred dp configuration.
  * current -- for current video mode
@@ -162,7 +162,7 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
  * echo <lane_count>  <link_rate> > link_settings
  *
  * for example, to force to  2 lane, 2.7GHz,
- * echo 4 0xa > link_settings
+ * echo 4 0xa > /sys/kernel/debug/dri/0/DP-x/link_settings
  *
  * spread_spectrum could not be changed dynamically.
  *
@@ -170,7 +170,7 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
  * done. please check link settings after force operation to see if HW get
  * programming.
  *
- * cat link_settings
+ * cat /sys/kernel/debug/dri/0/DP-x/link_settings
  *
  * check current and preferred settings.
  *
@@ -254,7 +254,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	int max_param_num = 2;
 	uint8_t param_nums = 0;
 	long param[2];
-	bool valid_input = false;
+	bool valid_input = true;
 
 	if (size == 0)
 		return -EINVAL;
@@ -281,9 +281,9 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	case LANE_COUNT_ONE:
 	case LANE_COUNT_TWO:
 	case LANE_COUNT_FOUR:
-		valid_input = true;
 		break;
 	default:
+		valid_input = false;
 		break;
 	}
 
@@ -293,9 +293,9 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	case LINK_RATE_RBR2:
 	case LINK_RATE_HIGH2:
 	case LINK_RATE_HIGH3:
-		valid_input = true;
 		break;
 	default:
+		valid_input = false;
 		break;
 	}
 
@@ -309,10 +309,11 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	 * spread spectrum will not be changed
 	 */
 	prefer_link_settings.link_spread = link->cur_link_settings.link_spread;
+	prefer_link_settings.use_link_rate_set = false;
 	prefer_link_settings.lane_count = param[0];
 	prefer_link_settings.link_rate = param[1];
 
-	dc_link_set_preferred_link_settings(dc, &prefer_link_settings, link);
+	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, true);
 
 	kfree(wr_buf);
 	return size;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
