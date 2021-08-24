Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE1C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319061BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D319061BA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC4B89AAE;
	Tue, 24 Aug 2021 17:07:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F0F89AAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/AVkVNvCACRC8bMwitxJfPvrt4WW8AdB2//WF+WkF1ZSQTLdE1HVxZrM/N+juBRXX/rjqNXJPQv+CK03t6pTdCVeW+Z7BUSlZgVABukt5B9QMVOYaJmNuUjyoRBKFVRB3W/W75piDlmNwyyfRtqMX0v7SZOFleWV/3jU47DIUyxbQIIZUvt95an9IuYMPlj0TmKMTNDcW6dXa0/G+cAWzcuqfMBoUrtkMfYcjp2lIL3w5nQuUTIUdG/NPiOcg1rr+j6nNGfDP/q8sH2gMPfYdcnWNkqS6BTls2a3LIF2vNG/EGgiC1vytQyhenEkb7U0oo9CfJM/Pg4nKNCxE5E8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbWgDUAQToGbmbrD2rjC+nDCVNq9kAHuYncKG0oc3E=;
 b=GwSk6IgGg13XutS2uY/OSEWkzAJEvLECfByA1q/RoKWviJUTYplEAP4Hn1ldGF8H2BrRsHE/dhJz6LvgQl8ahN6YIlJzbmUSF0rZOWTS7rTBcFjIdauIiZsN0h/0R3XjN1lnLxd7veFuELZcs0SVZiPchgR5PsTfvtEGPYIE3RyRNo7u/I79XVOjPM7nuhunGlQNr3SjdFKNJXvQxt4JdyTH3q9zzJMOFUviNXJuGIAKd3WAUykodEHmjrHEPSPTVUaKUtMgtsssQeA/OILNpkGgwsPhct31zRbyhrXQRYS9X7/CM3N60Y4+ADv6wSpqvDZ24SVcSpEA/TsaxQW4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbWgDUAQToGbmbrD2rjC+nDCVNq9kAHuYncKG0oc3E=;
 b=glVHTrpktYpLFIVIwib35BC9MwR9x2FEwetFY4nNKnJbHDd/0wXCFp+iYd9d0UpnC26hGnuiYtFFiMK2rvX2+gr8ke2xtSQc2L2AFv7vy7h2VyFsCsi4+26ep2UA3TbGp5qFCyVH091k9VV1WTmS+9qqhlHv498yzSiLs0/t7sA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/display: remove unused variables in
 dcn31_hpo_dp_link_enc_update_stream_allocation_table
Date: Tue, 24 Aug 2021 12:51:04 -0400
Message-Id: <20210824165105.1913700-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4707fee1-15f4-4e27-58e8-08d9671f69d8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317628F9BDDFC5297BBAAB7F7C59@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymbnOpIytxpWFXryqxoYj9uGRRNAZJvF+SOSUxO+o2zEVSiDH+eRvHYZzT2zDBIT5GNGxTV/zfJ8+ZMrkZwtgnUgHUU0dQSWQd8HcSE3/I+vPwzQj+UtbaB4+TZQeNAfWkwqmeyR8wf5OIxSK8TimnebT3CyJP/7M0jbYEbPvtbMZDNNnFEjYm3kU+Z4RnnS7ryCUVqVQymQs6f6XgnLIlCrrZ1ugyIh6eJRgAuv1nNXl4OJmESRDwUw3PvBXuNtpji+wI6H/Bl4dpNG1dSixbrSG5KzdOg5KHZB+8gjY37UDZXNxwNilSQbc3S45SfadUc9abeLI0P4gQkY8k5dwH5hOACg6d5/88FPYi4Zc9R11WKLno8/Wk12uugXiG4I2fLGNHV5hM6ggBAnZX75rOLCq2lpj1MS/4ZcxgXHFtyLG2w3eWvljAosxWQjJeDKUdzONv1DSdjWnMCZMN0zGxjYbQqwXzOfF/dAd+XDsrhL0H6Ob8IqonftDt06nzH9i+8cG+6syctGBOPrM7wDbdqG9t1YUR5SA3EYAxC782Iax6oZ2A5V0KKe/tg/jVs3902igNFNUh+Jss2BsGe6JEmOE0nymzl8SNnIrwwsE/Xw3RldCj4QzxDjL5pzXSoU1OCnl1yz6KvcVncfWyemd39Q1X079N4CjoMa3wvnGijT1bOFD49U4pqFTEY1GPQbw9R8JqEDY1E4KeaZ3jB95A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(8676002)(316002)(86362001)(52116002)(7696005)(2906002)(1076003)(36756003)(6916009)(26005)(66946007)(66556008)(66476007)(8936002)(83380400001)(956004)(38350700002)(4744005)(6486002)(5660300002)(186003)(38100700002)(4326008)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DRXlCDzgeOeYQU6/CmXhOFgLpRf2npZaSxOExcxzUtRcO/elVMQQLWtl6MJ?=
 =?us-ascii?Q?zMuLO9Kqm0XJXPD9KAacEBGmNf7ilBSGPtvSKXMi9iKPskZVO+8PTj1xjMlO?=
 =?us-ascii?Q?J3PiiN/4bFzWJVhynOaK6Gi+Xr8d+2/ISWaBXxm/C/lTKfw1xuJwwrwCNmVn?=
 =?us-ascii?Q?M8ToLy2yV2v09ATHd+dqabdE6rhdxZHWf4SX5Jg86KuY32QFCdyeDJk5hKqj?=
 =?us-ascii?Q?6vEhYL8lVumDi467Or5NM+FGt7YKiRWeho59eX2EretQ0bfeKSqbnifkjE9f?=
 =?us-ascii?Q?jGxN+ovPC4qTMrtlGMMBr3cGbltBarehcbL6YVxJwvqSUFbXHmP9RiF1r1BO?=
 =?us-ascii?Q?Jb8BjO1B8RK0kekUhsJLvfKeJ5U1X+PaiWbL2nRvLjvyBz+6n2C52BI8sTtq?=
 =?us-ascii?Q?zyShPFjzOsi0fmqHjjWlrQiJMXwGxG7fjDv16I2Tlo/7OJQoQzmyNJG2EjIC?=
 =?us-ascii?Q?ixNZBBgcgeRAd+wEFUQq+0KQHpem85V5f+JqylqTShJ3MOPI2ImXNzJQ4fuT?=
 =?us-ascii?Q?SEM5OK92kTbv9NOKeD39XRJwh14JThV5kiRPoEDzVLTPBqlfPFJBnkKvqonA?=
 =?us-ascii?Q?Q3xEiPEDaf2V/nwMHywmauzIgj00L+TlPxnLLxXWpaI5t//skjjFaAk4zkRd?=
 =?us-ascii?Q?mUtVo+NdN5QbK4PFnQmbDgJ4Yc8ltJ7wDESgprQF7MYeV+CeMrYaZ4tL7eNY?=
 =?us-ascii?Q?8Qi6/JN4e1o1e/68VWAPCILd67LGw42wOcWUCeRCTtW0sjpcmA93QVhLPbL6?=
 =?us-ascii?Q?yUAP89dM2EdBSPFlZKn3ArSjHwPlMIFFk05nn1sQntEJb7ToRHl2ymyGFWkC?=
 =?us-ascii?Q?+SXo+507qSX4ps4HBT+9X6WeSC4/eFVFuiFkQX3TD/vbwUEGh/lhWL1EkECr?=
 =?us-ascii?Q?yP8W9bw7W4sZD0zaeSpTfV08BuPqfnfRbUgSygZ5FdEjBi2w8elsalNpG2Io?=
 =?us-ascii?Q?+/mwlRWWto5dTTbnDQ4PyV9qDNYHFf1h8SnTyuXB5Y3GFzuoMI8nR6yckjFI?=
 =?us-ascii?Q?Tye7q1x4udV3sT1FcKGDm0OB6zajnamVoEVo0nNUhYzE2o0+HfvpsZRq1EZc?=
 =?us-ascii?Q?3e9M2qtd9WJtwP5vrqaN/CfOi2JIwsxb2mluz00+31kR8kIz3yDS/7rIiaQy?=
 =?us-ascii?Q?/lMW6syxz2XBPrh48NyKXBgnrpSVKYjbt5Aa3skx6kdvjhTwL/4bRnhH0vtc?=
 =?us-ascii?Q?n1gaNwCcJrJDaaWEy+sCgOwuCR+8hr4YNfhZpDIuW1swAEjPOKH0FxtzsTve?=
 =?us-ascii?Q?lzTbm2y1zyKSntWhKYIMsFkv9UKGFcw+GQwasXNnUhpXQ6Q1RMRW2BY58M5T?=
 =?us-ascii?Q?7/zjwVKlwbwiIrYof+u9plSQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4707fee1-15f4-4e27-58e8-08d9671f69d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:26.8741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nErqmI39mHSKXhTmf4WTMQgjpLdz37HxPlwB+4wEXNXBiN7/YmwvkRavHAB8BtnI2rDZRkF2SUn43264l2v/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial.

Fixes: dfed73a863df ("drm/amd/display: Add DP 2.0 HPO Link Encoder")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index ee07a0bba12b..6c08e21bb708 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -282,12 +282,8 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 		const struct link_mst_stream_allocation_table *table)
 {
 	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
-	uint32_t value0 = 0;
-	uint32_t value1 = 0;
-	uint32_t value2 = 0;
 	uint32_t slots = 0;
 	uint32_t src = 0;
-	uint32_t retries = 0;
 
 	/* --- Set MSE Stream Attribute -
 	 * Setup VC Payload Table on Tx Side,
-- 
2.31.1

