Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A1C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACBC61432
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACBC61432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1126589F97;
	Thu, 13 May 2021 09:46:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FD789F97
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 09:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfGC6r7rMxLOpiJm5eaDTUzQ9xR6JB/meeslhtaUcSn9Tjyxtsx2TNrxtbwn6uKV/GTc0Y6rYiyrBiPYstZsJpdlCdkHWL9x7aANUMhlyZKj3H69G+bLfK+TdJt/CaQW9z64hNglA0lEhT2hh2UZ4HWKNHylWvmugADFTQGyyEg9pjExyO+3PKnSy4fBlbtya2oEslYsQSWKonWF5JincDmHdC1WaVgM3Lb897pJOprwzaftwBKFdUhMa3+vr0Mt+9yKoNw/EFzv5DPYvY9RCS7s4y99OE/duwzf4DBLBR9AS2sxU8zjx/0DpDwQ/j0YHYeaC9lILpF6OE4TMvFdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H216mrbGMkU18WD6UN9r+1Yfa0JyBXuNCQ6XGi/PSKU=;
 b=g709i30tn9fMlWK6Z9wKmRz0ClYGaXyrgmVOcMcpXZ2KMr34WTyTyAJl3eBYE/GPRReYo4J+Cbm+sygSf0GcXIZXDKVfMz72lLq2flvkD4yX2Zy+jugQmygjZrI91hK3jkHRcYvMzzV41S9qdKAo0tlKVxLqKgvpGmDi9nf1NiZN/rBfxw18O3abExqlcuZgRQHqkp7qiCspJWO4T9vekuuRJZBSH2ZuUwikHhLbh2La5Drm0FL5bPVFeJ90TJt8vy4/6XoXVyO1nWRMWOZTpclEQr/UMJfc3WZWZVdXY2pAwEkXzZmylcSOmqD2NtppqVRMBYdmi6L+A7tqpG1mMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H216mrbGMkU18WD6UN9r+1Yfa0JyBXuNCQ6XGi/PSKU=;
 b=ZrYqrIEco7WU6tW4DwYTp2UL/iwDO28nyT3ZmQiIk2epe1zOig3hnQaPF0WQqGq8IAACa25QV3TrQlrtATzjbo2MNPeX/nVvl8Bhso6yh2rpts65FoAYcHoHM7Pjkl+zfGeDZvCkbFfT71i6sUDsAx28tsNkTDvHctkocuk8A+I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 09:45:59 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 09:45:59 +0000
To: amd-gfx@lists.freedesktop.org
From: Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add custom/current freq to pstates
Message-ID: <55b61528-e73f-9b3c-94c8-376a0a54bfb9@amd.com>
Date: Thu, 13 May 2021 15:15:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.39.107] (165.204.159.242) by
 BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 09:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1346a188-4d72-449d-78d9-08d915f3e9a7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB529935E46CFAAA557974782797519@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oYsu6EUgYzrgPiD1qCpUihmfpEQUIh77la+SjEuhX1Clal7wej2U8xITjSxu1e13iGAd5OSga1L62YgtdxxUx1SQIEVeU85XdDGiZ3iYM6d33pSyvYuw1QnRubKPJRNIJwiUmslUraYRJAuRM4xD8hN/M5eT0uu6uB+tIYPRk0k4mRC/YAkJXSb4CBy3OtUHV7rjC5hnqktRva8eRZDZNmMZ4iH+wjykQ0MTpkBdlycPslS1VLHq5RnI4r2AwaeAUdWMFfWKw0WSdhGnSzVv70aq1h/UwpEJ54NqUwX1rLclhyvOukxYv+ho1E5x4JfRQrmlclP6CM1IxR1baBSyKQGfEVEQBq4GnmYJ2MpA0Mht3g8BkG95qi3TRE9t+e8Fam95wj7lR+boVl9N6Rj22DduAdjBjVonnbnZ3rNuyAR2Mt4KURINtwm902JklehOMfyJIEtXWhQ9ZwIuZbaQqfMVoztmvH3EMyEvsj/PYNg+n8lTqMMyZwLEj76YI/HhxW9R1c9AYbusqP9/DblT9x0dx6CM5gDo66CHceGibxwLa9d5PEOCnensKzg2siQRf/qYEZp+lk3L4H51/FQz2AEaRdawLqZX/aD9XjAK2x3PtZguk144akRJXMOsw4b4uYc7X6KsUAJV3kCyUDcLbvRpUte+f3zViuC7eSoq216r4LWLm4rOBMz5JN3KHGASUyV9mVux7cUWm183Lntq8xYmcCSKHtUdnjwo1bCU8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(44832011)(4744005)(956004)(2616005)(31686004)(36756003)(6486002)(5660300002)(16526019)(16576012)(6916009)(478600001)(186003)(31696002)(66946007)(316002)(86362001)(26005)(66476007)(38100700002)(38350700002)(8676002)(6666004)(2906002)(52116002)(66556008)(54906003)(4326008)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjhydFBqNlhpU2ZpeXFiNWNabGprczhNdEtjMWVheTJvNkRLMjVBcVluZVUv?=
 =?utf-8?B?TVJmUVZ3VkJzRjcvWi9TMDdpTnFhZjNiNXo3TGduZDhpcXV2WUFESTRRWDY2?=
 =?utf-8?B?SzNEVHN5NjFQZjJHdGdwTFhjR1B2VU5YNUlRQWFhaFcvVUc3Yit2c0piQzVZ?=
 =?utf-8?B?R0xma2dyNW5tQkZwa3cxb1F3cm5iRUxyZU0vR2o4SDRrMWw1cGwvaUZrNDZZ?=
 =?utf-8?B?eERvWHRRVnRSR0Q2VlF3S05uQUc1RUJTa1ZnT3p4bFVDZzl4TUk1MzB4TnhH?=
 =?utf-8?B?ZDBiWmRQTXpEcWthTWdCQ25Pa0RRT0ZkOXFzN2lHU2Q4MEVoUGJCbjNxQVdR?=
 =?utf-8?B?OUdZWm5Ydk1WREhwWTlrRmh1VWk4bzJucGZCdDlKSG9qcUJ4RjFQVFpjWFdr?=
 =?utf-8?B?czJPaUQ3SU42OUszUjNuL1hLYlQ1UmxTc0J2NUtLTG5CNnFHSDlmcE04Szhj?=
 =?utf-8?B?WDd5bFhyaFdZUUFPMEFQR05rWlFUYktKNHlUSkNuejZZLzY3RWVUVXZCM3VV?=
 =?utf-8?B?OUZPMFZGcmVoWi96L0RsNnJ2TTFKWjMyTHRwVVNKRVNFV1pYWXBLN0hIM01t?=
 =?utf-8?B?NUNxM3hxWWdhL21xcC9Hb3IwSTNyUXJQV2RrbDY0dXkyTFh3dGxpUkZ6dWxM?=
 =?utf-8?B?QVByL0RKZjd3REgzZXRCWU5oZ3I3bGtReHdMT0tseDRxRW01KzUwenNVWUZt?=
 =?utf-8?B?K0N1MlNSTHBKKzlVTk91WDZYOUVZQXNJcWxvSVpXWW5aN2VYalRvRnlqUlNN?=
 =?utf-8?B?TjRjaGhxTEVvVDNnTlplVjZUQ2FYdlUyRXJvSkdNNkROY2QwL1Nza3R0ZFlS?=
 =?utf-8?B?UkcwYVNIS2JwVEZpY1JzS0JReEhBM2U0WmlVTWFLNUg5OUNWM2tyM0piSkhE?=
 =?utf-8?B?bWd0bHJoWDZxZVl1Z1hESmk5bmJhUlJWRzAwWndIOU1GblIvSGRrRVRWOTVT?=
 =?utf-8?B?MFZoRGhKSUgzenBaNituTWJCV0c4TGd5bE8vcmRGU1ZqNmdUc2ZaRVQ5TVFC?=
 =?utf-8?B?NW1hZzc4SXlWR2FVR3E4clNSWENqTGVGNms0VVNQRmFGc0VGU016ZnJrNWhO?=
 =?utf-8?B?UWhHVHh2STgrTnlsNUZ2WFJjN3Y3TnNjUGsxVlc2OUZWeGRSVWpLODVXN0tV?=
 =?utf-8?B?N240YUZTTFNoeUNjbGZpTm5GYUlOeEQ4T2pPaWZ1cXh4N0dXU001NUNCYVZY?=
 =?utf-8?B?VENjVTN3ZHVEeVFVektvdVVjaHZVcHZyV2FDejVwbmhodWdxd2JkeWEyeTVm?=
 =?utf-8?B?bmM0bHhTSzFvYlFjMENBWDVhUDMva1IrNjhkVzMvQWZvcUc4U2VOVk5oRWRJ?=
 =?utf-8?B?NUZkaThqejdwVkdSUEltNmxWdkk0dHlZMy90UVlZZkEreVpWWFhWc1Q3U1Jr?=
 =?utf-8?B?Z2l5NXZra1pXaWtJSlN3Q2tKM05WaE84OXRwbHp5Z2ZTMXhWdlpmeUkyWUI3?=
 =?utf-8?B?bEJIZGxPZVJtZFdVSFpyYUpFMTY4VjRUMVJsci9CemY4MEp5c2xlNnNOemZ5?=
 =?utf-8?B?L2xPakxkYUVBNWRpM21PUDdHTTJxaGNIdnJISGVuak80Uy9GNFFGaCtvVDJI?=
 =?utf-8?B?eWpHdUQ5WlpZYVZpY2xxK0pweVpoOFRnTGc5aVVuQTA1MHZOMHBqQmxPcC9F?=
 =?utf-8?B?TmxadHhrNEFINmN4bHBEL21VUlpYTHRzS2VJZFZPRmdjaWthZFhxOTlhK3d1?=
 =?utf-8?B?V0NXSk1HR1FXQkVRengweHc4ODNDUk05b1k2VnVrd2dUdE9udjdkeXJIWnJS?=
 =?utf-8?Q?gFhhbudkMwCgL/1ecMYP6kNS6fPM2dRzPvtLzzF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1346a188-4d72-449d-78d9-08d915f3e9a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 09:45:59.3348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/cheoHIsu7+UTrsaeFFS3nGlUWbLA4lOno5P00fSM1VvytPFA8jUtxOnXv95/eu
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

Add custom member for user requested custom frequency, level mask
or min/max frequencies. Add curr member to keep track of the current
active values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h 
b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 8bb224f6c762..76d670bd6440 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -392,10 +392,18 @@ struct smu_baco_context
  	bool platform_support;
  };

+struct smu_freq_info {
+	uint32_t min;
+	uint32_t max;
+	uint32_t freq_level;
+};
+
  struct pstates_clk_freq {
  	uint32_t			min;
  	uint32_t			standard;
  	uint32_t			peak;
+	struct smu_freq_info		custom;
+	struct smu_freq_info 		curr;
  };

  struct smu_umd_pstate_table {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
