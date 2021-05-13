Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61250C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F0A61404
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F0A61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B19588810;
	Thu, 13 May 2021 09:48:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792846E09E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 09:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjLl7NcB/g/XtDJhH5K4EXBzVGqCXidwO5f5vIc+ahFsKXczB3DK7h6Qn8dTGDvnPgWrJMh7c2ueBoTMYtlSQqY4WDXTDjVCqLnOXM3NV087E9NF+hvZ+2ZVGZ92c2h3CbcFjin5Oc94qki+KrpaTH9+XRjBLUo0cUCp0Z7znbABZwDPEvSD9DLEUYvu5n2T4uVqPeLTYs1YQpXpgWgO7HzsnoJFb4EvZIOryNGvkPwN+vrhUWsgqM4oaD+9ykLTSG1znedIuZaGXi1eeIiGhcUAh+d2bTrkUlM39xyOMRUXSUlb2REzctI/tttsLyfBIyiC+Wtc7rjAFmmN0QiBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxgvPJ7CrPPK4mqdlxMKAljnRFdXLFXWV7I7nhjvmZs=;
 b=VOznAqgG5ZXcvhHR7TFiQ3dw1WrBueUDA5/FSOQSk2CkbdQjgV6izwTRKGFJB44QG1A0RPZQ4Y9MS93NfO3o4KM8YOw7xZ+HEueESfMZ6yAtBdiM8fHR1bbilU1GkC+RoiUWpIGq+FtjaioklTI9Glr258Wgdqz2IDDXAoXiV4ojyvcDHzN2J+nLky4Sny+v4iu6Uu0F4SQ8jHfl4ClldLAfAwDJ5UeTjP8XIZ4mH3tPYknkJAdYxcr2NHdA2yLdct2X1lbFXoUqLw25pl8ZQg+NIhpU5gncs4njOuBi/xaUjv5oDqh4lR4CpYE5LrAv65tKc7Qpcv0UMDj7e1DRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxgvPJ7CrPPK4mqdlxMKAljnRFdXLFXWV7I7nhjvmZs=;
 b=V4B1bBVePMBa7DoB68i6NPIK7TGF++D1ftGB90eIRSJGhIjEpWpVkTkzid2Kd9wTWl1P/2JfTl96Jnz/K67BN6e4yR80vsP5y4xXj8i0wnvUVt7Pdq9lwbNIMHX4PVAJZRcHDdXgbSyKUjdYLVG+fekun611v9UlMmWa25QQqZg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 09:48:11 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 09:48:11 +0000
To: amd-gfx@lists.freedesktop.org
From: Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Reset max GFX clock after disabling
 determinism
Message-ID: <cb80cb90-a90d-3f5a-a072-d7062f14030d@amd.com>
Date: Thu, 13 May 2021 15:18:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.39.107] (165.204.159.242) by
 BMXPR01CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 09:48:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5229afda-74dd-4e0b-5079-08d915f43856
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5299D881CDE601D82F58838A97519@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuBdYbwgjbnzgoejDKTwU54emtDrzyp1hzMdurXyM/SMV6rGMO3MzmoAs96uPuaR3TO+B5aj+X8dectB7n30uMMcCwmdoREWAP2/KRXs7wwC839bFiSlVss2iBCdBnAPqEE4VFEy6VHZAmDsOYE0v5d/nba2D2S5mOSr0/SJJqNUBoBloQC9WlogfWHRDUrYZwshCP+d0T+l7o5dQ2VmnaZULQTMjcIVSnH+JZKyP8Yyu5tlH0NUo9XTGkpcXlQH5GIacoqfIvttCdzjIIGPmIJ6N7Cu5O0vIhfLi23cGldY819BvYUsci1PV1EnjYHA6Fj0p4fTICDmFELYxn+6TlO84JTDVveF+0mXvv0R/bUgK55KXP0IRK6B+sBOBt3lFsAOvneeZxSWK3d139KLDlPpnO+eSOSW7ttNcJCRS+6U3X+UURa9CfxbLA0GMY9sWcWAus6NOJC4Jni+KzimOGP9i7MFYCpiV68Ma6mvtyfqQ7VFdxtZsFyzFLN10SuqSs/HWzmlqvG1m48HyZaP19Mk85iVP7C6PLTZhRFOtT1ro8dBZYLwpRpncNnhjkQO+Xd159L1dUosAHTojOWJJ5tGg4SOLLHHgcMk8Q9q5YTVV4gUn7GmABb+brKGCtqH3co1j8bueNWCdYP0XO705TXTr2PirERqGXLCG/PPwsmQF24rS2eLhgzgVyjbQ7E09CrmE78uvpnFo+shd8s9bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(6666004)(86362001)(8676002)(26005)(38350700002)(66476007)(38100700002)(4326008)(83380400001)(8936002)(52116002)(2906002)(66556008)(54906003)(16526019)(16576012)(5660300002)(6916009)(2616005)(31686004)(956004)(44832011)(36756003)(6486002)(478600001)(186003)(31696002)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SFNKdjBZcWM0bHJLaUptdGNOOFFBT2NueXpVTGVIS3BkT0gxa2NTc2Jqa3VJ?=
 =?utf-8?B?Rjl4azBxNWpCWXBXR1JsWC90cURsYUlaL2dHcUo2MktCSHlnQXl3dzFCbk1j?=
 =?utf-8?B?OTV6dGx0N3RXY3prUXhGZmVibEVUcVA5VktyZWdPc3BYT2s2TjIwdkhTcGVO?=
 =?utf-8?B?VmVVQkF2TWJLangwNXovYm1OWUlWMlBsd0lmQ1hJeVB5Q1JvTGVxYUg0eFlr?=
 =?utf-8?B?MTJlQ2FPMjV2Vnl0QlhEdHphaWZ1dWFhcHovM3FPQUtrSHljL09PQzUxaUxw?=
 =?utf-8?B?KzRjaG01My81cTBqaWoydjVIS3BPOWl5dmNrN0Q3NkJvMUwrQ0tLRkFNUFFn?=
 =?utf-8?B?b1ZOZVlRNzZyaU5oWkhxK0xReHJFMXNjZ0p1Q0JhMk0zcGUvTmhOWHh2Slkw?=
 =?utf-8?B?MndDcklRd1Bxc2RUak8xRGhJTTdZdFZhVlJ3WXlCc3JsS2sxc2pERGpGRlpl?=
 =?utf-8?B?YmMzS29PVGxkUkRuZjZTbXV5eEREOWZoQzg1NGh1QTdOM3NTRmUyeWlZRUVi?=
 =?utf-8?B?d0I4emlqcm5qWmhQU0MrSzhPcXZtelZPSFRtL3ArWi9ldWVES1ZoMzZUN20v?=
 =?utf-8?B?VzVkbmhoZEJwSndpYVgwcmlCWnB0cGh2eFAzQlU2R1VjWmZPWFRUWGJGTWJQ?=
 =?utf-8?B?OEFFMjJCKzYrTERrbVM4bUs1QzBqVjkvOVVHS1ZJNy9JOFVOeDVMaVYrZlNK?=
 =?utf-8?B?Y1EyQlYvWS8vYkpVaUs5V2NSc1dMRklyUlA1WXQxTkgwWlRXUno3WlRNNytD?=
 =?utf-8?B?N0JkZEI3Q2RGRms4cUJYWjNRNlNIMkY0TzRJNVE4WVE0REEvc1JHdGNJL09W?=
 =?utf-8?B?cXlzNVZtcmRHTklsOUNLdFI2S0lmWWdYdk0vK0g0TXZmVnhDT2ZFZTQ1dFBn?=
 =?utf-8?B?THdVTHF2OGdCN2k1Z1ArWUYrZUpZMlhtK28rZG5TbGpDS2NnWkgrZzRMM2RJ?=
 =?utf-8?B?Ty82UmQ2cjlmUjJaZG5RSFpKbEVZcVFtSE5WUXVHSkIyUWdYelptZUVlL0Vx?=
 =?utf-8?B?YzFKdUFFM1Z4V1JkMzVydWprVzdXSnpWaDlEWjlsUFJVYU9aQkRzWTQrWmZX?=
 =?utf-8?B?SDRxanppQWVOT1U0S0VoTmZxODhuWWZLUjlPZlRVUXdYQlNtbi94OEhBMmtw?=
 =?utf-8?B?SnVnS0puMzYrWHVqZWcveVVvaVpnRUlvNC9wMFZFZzA4Q3ZuNFBSSUJBSzhO?=
 =?utf-8?B?MllITnk0TE8xQ2pOc28wYm1vYmUwbSt1L0V0WE93Q2UwMTJxa0FwSzNIejZm?=
 =?utf-8?B?N0h0SS9veTRLYW4zZ2R5UjlHYXVXMWNBNTNFK2VLcGVKZTQ5NjRtYkpxQWRY?=
 =?utf-8?B?bVNsb3VpT1BabGhTeGh5NklaZ0dFNXEwTGdmdXFXUi83ZjN6TDIzalpyZG1o?=
 =?utf-8?B?dk1oZktvc2o1S25XNi9XRzJMS3pJY0pvN1F0d2xHRXBibVJXKzZuajE0ZWxW?=
 =?utf-8?B?R0NJTXkwMmpyaW0yUWtPeEM1YUZZREZGSmpZMllZTW81alBTSjNjUGg2Q29w?=
 =?utf-8?B?ZW9qYVJNdXJBRU41NHpTWHI1OGkvKzBqcGhUc2hKQ2JzRjY5VFRUeU85MkRi?=
 =?utf-8?B?OXRlWGpyUmxkZHl6aURjd0IvVW1wam0wSzNJUlMvV05XeitTd1lVRlUzUDlW?=
 =?utf-8?B?ZXU3d2Q0NWlyQzd3cEY3bExua29NbE5TYXREa2ZjSkNjTlcySTZ0bGRZWkZT?=
 =?utf-8?B?emlpbUk0RTdPeXQ1T2t5SHVUUitrMHphSUViY2JDWHdiRWpoWEV5V2pCRmJh?=
 =?utf-8?Q?y/hHGvgF7Ac20v+rvxCzU+2fSc9e/Rx22MEoFDS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5229afda-74dd-4e0b-5079-08d915f43856
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 09:48:11.4196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op6jWF3QR+DOqA/bJAU6qYT2aaNUvSpq+KvvN4EVrSRI2CJeWTmxv35lHoQMphmI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When determinism mode is disabled on aldebaran, max GFX clock will
be reset to default max frequency value.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d27ed2954705..34afea71f1b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1129,12 +1129,17 @@ static int 
aldebaran_set_performance_level(struct smu_context *smu,
  					   enum amd_dpm_forced_level level)
  {
  	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_13_0_dpm_table *gfx_table =
+		&dpm_context->dpm_tables.gfx_table;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;

  	/* Disable determinism if switching to another mode */
-	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-			&& (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
+	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
+	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
  		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
-
+		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+	}

  	switch (level) {

-- 
2.17.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
