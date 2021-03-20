Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1BC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EC06196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EC06196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E016EB2A;
	Sat, 20 Mar 2021 04:19:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1E16EB2A
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgDOFCGJVmbSCLddrRQPen/828Ua3I6bVvi/Ai7/DvEzyyB4RUZv/zo5GE8/rfRVMlHoLteQ/jjYXIx1i5zgxTRSZqA89dyQktM0arT6/6NDBpw4N1egW1F1QHFrOq8KEfqLW/gV/DRcka1I+EUmzlGPhE4TlTc7vHI473Fx3wwXGEmeexik80Hk/q5YyyDuJ++po0/Sk2K5Y1wceGoc5oHRuiZnwMHUSZExFVXs3qM1s42qCbvMwNaA4HL/OEiDed7xbtFQfcuSCBVsDzNYGeGHPEeBCFbcWS/3t85QuapPWrjoMxwYzhclCJr4cfzUMCBlfJcvUqXqu9jL17yHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9S017FZ0VWG5787zRvHAvIa8eTZYYqPepQD7IMKYy8=;
 b=STqAK2RaPqJCYhV/zkJZxrUrlUfd2gZhHQim/RftmvzrTyrmjE9RZAda5ucLp6Qvxmzsdv8tyWpeWIdMveJYKWBpiu7rt4QwsYj/Val9jSBwjHGh0izwh2UmUTffywjQan3EqaYXA7+tL4OPvEdmfntLtKOHDWsltw+ZaTVhD4P3Av+rZzaRC4nV1qEVKWNSBTV2mYMypXXLK1WSnplKBzd5UC2YKg9+CnYgKLlu7y+gUMGgWXbNCb5KrjJXNrmz8cNWun9K40oma6bfYUnHNMgej5CYatPRB14BX3V/95w1co2mmEXNGZDkvaDl4ul9K/LEXI+TeMpADnptNuZCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9S017FZ0VWG5787zRvHAvIa8eTZYYqPepQD7IMKYy8=;
 b=GZDT1iKxe0BQEj9beUK/NQbiwINkVvlsRdYjtCat/oSAdHR9+R0R05MH4kmIHwryIuYxmFz/7CSeMyafVBx8AYE1W9ZZe7wQlJjNgZYX/Suln8VJIfwsZWoQew+e02duxDgsSJyoqEy0C09eeadQqXh3HAXTbzLCw5cIW4FqgJI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:20 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:20 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amd/display: Fixed Clock Recovery Sequence
Date: Sat, 20 Mar 2021 09:46:51 +0800
Message-Id: <20210320014656.23350-10-solomon.chiu@amd.com>
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
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71327087-2757-4c5f-75ee-08d8eb575544
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47041B21F698A7A2696A1C2D97679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cofOY3+zbmpuRK0vuAxwuEYyLzMeoOXavXWQ259I4JcNFLVGjvtDuOAqJGegkY8njBD6bZIyuJNlIiHeQAXLOFX7frhBkSCGTblQe+7tD8XwwNyD6HGLU0r33zjRheMgKGFya7AOtrf4DAovUwTIQwJhVcceEV2qQ4uO1WAyATE4IUF26gL8nQh6o5l+86/atJVTAFIWckKJ5XI5S+sEYorUpK1LQmznaRM6rrhXJhK88uC8VbAtI3p+Mfbp5ESbWid8Hw5Bs7vS3WwDGUd9PQo2NXDWMb8nbPF1m9CLOc8nmsqLxjby11UC6AfwBt3HebZEhDAdA89pdtQR82uP+z833cATXfTP5tJ7KTZt1/EpQRcw0hpTAmpYvfOM9Hxnk3pRoZRdq1C4RLwZwvZ1k78jMdOhFxsD5d/vt3z8xBZ1nWIegWc+dBSLW0DwKAQ9DV3OwYMh4o/Euv0qQ/b8O/ibPrQQh7Pev8iAXPHQ802XVOqfigVa2hffFjp6Va4gp5cF9i9t7MI+JwzqrpRFhsvgAwwax+qLTzPEn3eT9Bkx6jF1Z9osFMzdq+gDhtrQdPmD2U74+AeiLAnUeOlbf6/FKEJ0dSAG4R+eiNKD9WMm4XYFFPPBM5btQrjZSfCwYg8iUA8//K5J1L06QZKYumRbTvEEMdfVZLzKXVFkOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VzO5BH5vKl1XEKuTQxfek6rqPdl9t0gEB2VtK9c+pK5Fh9WE6AbhnoE3Xfmi?=
 =?us-ascii?Q?tQGEvKu4RjTQRP9qp1u4CMNIC6Xv/17kJeddkHadryxQ8/cJCyiaOeTbASs6?=
 =?us-ascii?Q?0vUac5x0grjavoC2QpuxUMlAgGpF0ihIsAblf2sEvYqqyfAtDV/CWPXz0/4s?=
 =?us-ascii?Q?fSCVMtFgx3ab4f1tisRdgytjNIzHkuewXQxeHMZ87KmLZZeHZnN8XtuXjD8O?=
 =?us-ascii?Q?Qb6a2h5xVG3npX4fV1ggs9LWAanE3WurgF6+/vr1M15CSMBJOWQpWkuNnS1p?=
 =?us-ascii?Q?SQDZL68JDreEp+okeZVenxexPm/OatoOalk76nEwVxkNmMWN1OeeZ7EM6wxA?=
 =?us-ascii?Q?4tommKs5qRtXx8GWLAJgVcKAiUk68frqjs23sTHB6tXNfVk9177qlOmyFeE6?=
 =?us-ascii?Q?SuvWu0+29YqcUr5Z3xoGgG9tMnyGDTJSbpCC/C/L3spIGc3MP0fM7PJl+mu7?=
 =?us-ascii?Q?dEwV6btFnmrH8ujFqAZ5FtLm08p0Zv/b8ilfYaJ/CKOUQVS/WFQNvmjLOpEh?=
 =?us-ascii?Q?3qog2pilTHYK8PWtxjObSqhCP1L9IAWVpWJpGU7PV8ATGdNLgQTfJnybKouJ?=
 =?us-ascii?Q?VEcWNhzSTg5XNIw9wFTDtoO9nXIR11CSl/PA9rdJxPHfU8tNYbb5iZIa7tbY?=
 =?us-ascii?Q?a9T4Ek+MlSlN1QelQxCGVho10SsMq/pebfS5J8f7q0EJFrfTkp5O+17TOJ/d?=
 =?us-ascii?Q?hbquvvYnlrUwdLOrifwSzbArfA5lSk7F71d98OjD6Szn4enByfUb86OD32YS?=
 =?us-ascii?Q?kJ76Y/WZF+jtK7CPm24c5SCHEh4+DNPd9OvOhTTM+6Qzd7RBvTNVPViyYG0r?=
 =?us-ascii?Q?c3qtsLydS4aybJlIqt68TRWfulyli+cN/R46jAGW1onptdijIs0honaDpKOU?=
 =?us-ascii?Q?16kB7K57lSCX9Y5LbWDpQ3Ya/MN2LSKIsmNWI5GSH/nUG3nD7ntH0n5/Pxb8?=
 =?us-ascii?Q?0WcglSuXSjAaKpFuDTcPsd/R6pI8eymRY5iJuXRj8PR1qvUi6jNXNmU1W7Wp?=
 =?us-ascii?Q?w0rvbzK06l4ArCOYz3I9dHrFkSoDZsFTg1emixs7N2jCwpnMxinNbQ96br/a?=
 =?us-ascii?Q?/1ulQVZh1JPBQnMAZO1Hvdi6/TNV0y4grWMghldY1AOx0Xu0evYXmkTH8u5y?=
 =?us-ascii?Q?gwux5S0tLlkn5VDr9mCve8dEghPDuU/SDJqfZDo4B9AjmzoODZ3uEvrSGorP?=
 =?us-ascii?Q?em09ie45+CzUotrBh4yiecM9AAA8m881p83PySU4vSwtsrGuUQOQXzDE2qHO?=
 =?us-ascii?Q?0+uNXlH2OZ4Oo6Zt7UIm1+mEx0aPP0DjdWNRGi5Hc1AuuQOiWaIR+SA5GYRh?=
 =?us-ascii?Q?jWWQoYspz8rs7B2/tbE5KIWc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71327087-2757-4c5f-75ee-08d8eb575544
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:20.0555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W54S/D5ysGKObqhZfDqFEIhJj5A44csZvANSNBTRtuJnIxTlR1lOvZbO+/iGFbphXQFJgXECbw4UyRSFFWtDxg==
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
Cc: David Galiffi <David.Galiffi@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Calvin Hou <Calvin.Hou@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
When performing clock recovery, if a pre-emphasis adjustment is
requested, but voltage swing remains constant, the the retry counter
will not be reset. This can lead to prematurely failing link training.

[How]
Reset the clock recovery retry counter if an adjustment is requested
for either voltage swing or pre-emphasis.

Signed-off-by: Calvin Hou <Calvin.Hou@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 47e6c33f73cb..484d96f78ade 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1098,11 +1098,13 @@ static enum link_training_result perform_clock_recovery_sequence(
 		if (is_max_vs_reached(lt_settings))
 			break;
 
-		/* 7. same voltage*/
-		/* Note: VS same for all lanes,
-		* so comparing first lane is sufficient*/
-		if (lt_settings->lane_settings[0].VOLTAGE_SWING ==
+		/* 7. same lane settings*/
+		/* Note: settings are the same for all lanes,
+		 * so comparing first lane is sufficient*/
+		if ((lt_settings->lane_settings[0].VOLTAGE_SWING ==
 			req_settings.lane_settings[0].VOLTAGE_SWING)
+			&& (lt_settings->lane_settings[0].PRE_EMPHASIS ==
+				req_settings.lane_settings[0].PRE_EMPHASIS))
 			retries_cr++;
 		else
 			retries_cr = 0;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
