Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AE3C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 19:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53C010E045;
	Mon, 31 Jul 2023 19:25:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9572B10E045
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 19:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHwcBLmnkNlHWcS7JW10tUkafSrwcjZUsk/TZOJClrVECQ7/uWGj4YW2eNJ04E5WGWjbXt7fPwVn9KcNKj31tx6nc0HIRT/ySIEonrPsXNNEAsH7akAaFsgAfwpSrVfqt0D/w/yDGo972z91xTb6/Gpq6qO8Vp9Cj1sAP+BInLwqbdWWm0GT034C60pN5391Aijm0AsM4rfFvvJOePgjo2EcHi6oL0xHo79ndUPeg+Z2kuLy9OOc+FTB0Sv/sjBk3v+zzdaLH5EaVChahUO9b1dV32ayhmlhnD+rH/rkRD5anyL0kONVjOiDMJHLAa2ZnDT2zoCta6X++1rNV43P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VVIWKxoT/IN0dQbXwbWfWht4A6whgEsJprFSS3XqaA=;
 b=FhBhnAcSPlFDkk3gRJE4rewy25rdhNk0gbEzzwgicw5QhoO9SKfGzJ4cUieUs0qD1WVSM6u2e0YxeTQlZNfPAKm7LmyWMCPPX2WFaW3Gl8vifZL55l9uUPfpBAPRr45W/PKYZMXMKEmuOlwwQDvFKPkp6s493koTE3Gp5PUlp+eui9+MxvIBi7gviBoy8ghgpyxCkL5bZw6/HnoG7KQxGhgvndEyiazfRae4rESNsgGdykGz34e9JwBGF5rUfLgO4YmXfwdR/tBviFoNe/rFFJnquIDkSFc5sUfD64aHf88uoAKIPyGqKkeeddZ1886QocNTS5tgoGVYhLB+vJogsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VVIWKxoT/IN0dQbXwbWfWht4A6whgEsJprFSS3XqaA=;
 b=mmD1CMVbIk4Pp86Rp5BZiP7jbJ05KVU3KjpaCMj70OHyKYyAFbgyOkJm87tTsuAZ+vPcVzxZoZLH3lxwPl/mv5R1O3EpBd24nynFzFpNqIIXAoSb/9HJ5YbQjBMwmEI6TcRVzfCImxxSMd6pELl30S9EBSRR6YI0mfJYyJF68h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 19:25:38 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 19:25:38 +0000
Message-ID: <bb2ba23c-d733-af68-6b21-33218c2522c8@amd.com>
Date: Mon, 31 Jul 2023 15:25:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Don't show stack trace for missing eDP
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230731180214.18121-1-mario.limonciello@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230731180214.18121-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::47) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b652292-77f0-42a6-a621-08db91fbeba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJ0WVYroFUKlByKgc3OB36A8qsS6HYTqYlo6wwmI9ljnAK9UlTAZKADuE1GXUoXoB4CYKBqnayqlvBvZuDAFztzQ4w0DD6W0vx6VnEUE5OwhcN8W4knqfOVFEnffdsEi/Q78s2uN8B6E4WCyGdGWusMrAGD+w5PkmuNEVTQO7Mpjj4ydDihqaO4OOcC7SOkEbYCSGSAGAjWrBAbUAdwJbYN94fkLBO4t4MssBljBNXaJiet3YRt670OP4emGTtXLD4EGJdoyRDIRqxLbomXgLl68BAQG/iPuwQNE2rEwzeoo3d+phSmWV1MQt6npbWThMYU0D9vlMqIFcZjErGlg4cGVU7ETyntKWcZWQyIfmrLEuPDvnH8aTAOozZSvpLbQfY7woVKEIGZFpNoSntLThPrkAiQ0TD1AiNVeLwA6TPNJZGQmVB8dxlO2IHaat8UEFqXD9q41MCQxb2IIGA0jb3JGWDmj2wv1Y0jVDbUEDQqbZ1QIjTXbPrbqsbmKMb/Dn9xsc9Kq15GC2iwViWcuB1Csi2iFab3/SHF+tpa0Ktf9YQVAJC6sJjk8vwcrz0bYwD/XGQcOQHqsVddIylZehb2NjlwROHlek+h8a8DcyGRnsX5eUySFKNB0nTm7raZ+Z+iDL92N4/v+VwLjZjdC4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(6486002)(6666004)(6512007)(31696002)(86362001)(36756003)(2616005)(186003)(83380400001)(6506007)(53546011)(26005)(38100700002)(5660300002)(8676002)(41300700001)(8936002)(31686004)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRaanBhSlZVNEIzZVF6SFNYU1B3TVB6NUl5aURqbFZpUTRDLzA3akxGZDJs?=
 =?utf-8?B?Uk9KOGF3aFUySWFsUnJDU0p0UzUvM2JvNkY5UTFBY1I5U2JHNmFJcmFLSDBG?=
 =?utf-8?B?LzZ3REZ1cXh3emtNcXFRQUhkanZGdjNFcURXc0o3SEtlbUtoWmgyQUhib1dK?=
 =?utf-8?B?RGVYQlg2SEo3Y2ZOcCt5U2pIL0JFVnpWQ3dNMi8wSFptY2FGb09Bd3JUM29h?=
 =?utf-8?B?dm5JMXRqSEc2Q0NpVVFhbXhOeWw3cUxXdjIvaGk0TjF0elBvZ0Y5eGcyUDJN?=
 =?utf-8?B?aWJPOWI2V1pXalRLcXFuWnBnbGxTYVQ1RTFvRUxHZXFtNTBYT3BTNGxqclNT?=
 =?utf-8?B?ZWE1aWUwcXZLdGNlaHRTVUVxZkZBaXBJY01OTHVaYlB5RXF5NkhqZFdBT21I?=
 =?utf-8?B?SzE1N0JyUHZjYUlnNy9FNjhPbkpiSDd6SnVOa2pkU2ZxLzl6V2NHb3FyUlRQ?=
 =?utf-8?B?czZONGwyVTd5dGo3RWZuVDNQSUtPblBjeDkwWE4vd2l1SFFOVUFLL1ZTZHRJ?=
 =?utf-8?B?bGlYeWhOK0Rva1h1dFZYdVNtNnlIM2hOM2ZlN3NlQ0Z4NjJxR29jWnBLZmp6?=
 =?utf-8?B?UFd0S1VIaW9VcUVVU3hINVN1Z0NzN1JraFBEQVRPQjJiL1h1YytNNmF3UTJv?=
 =?utf-8?B?cXQ0VTJOR1pqRGlSSFZIaGxsU2ZyOWNtM0NFMVJCUGc3cXNXQy9FU3g0Uncw?=
 =?utf-8?B?ek1YTGRhWllHTUVGU25PbHJ6N1dvalBIR0FDL3hyWllWMEJLWWR5THZWNy95?=
 =?utf-8?B?OEFZUDEwZHZjb3kxQUgzUUVTK2dOVElkOHJpd2VFWjBNOVhlVEpHTE4ySFp4?=
 =?utf-8?B?bUJOb05HdW1NUTJxRHNBNDRidlJVeTYwK2J4bmlVV2RZZ3Q1enBaamgzTVV1?=
 =?utf-8?B?SDFoUzIrclYyRVF5dnV3cmppYlNtd2xEOEozVnFya3hxSFJtaDZ3b2p4Q1h4?=
 =?utf-8?B?WEJINnFMRzN2OUp0RUJFZWZuRmlOSHk5cWM4OFkvR0FJaXBEYXhVUXd3NElU?=
 =?utf-8?B?aDZPOTBXdW5wWUpIZ0p3Nis2ZUhjRitXS3NCVFZuWXJQakJpTmsyT2hZcjI5?=
 =?utf-8?B?SU1HeWtmOEdXQ0tGOXdIRFQ2a2VNempyMkhiQ0UxeG1Va0hxWVVsZjRzWHcz?=
 =?utf-8?B?UGl1RGVDd1Z5NHpFc3FEbHNtV2laWnFCS3VjS0RZK0FDU0U4SmoyOWU1THFI?=
 =?utf-8?B?ZEJWNm5pRUVscFFUeDJidmxLRzlhMGNwY0hCeWdid3Z5Y3pYREVwcWFRc05x?=
 =?utf-8?B?cC9tdE9mRXB2QzV1ZVBFSlFvZlFTVlUrQ2grVXlzUnhIUXpZSXJMNUxHaVpF?=
 =?utf-8?B?a2R6citjeE15U2o5VHRXRlNBOXh6TE0wck1hSEhYbXVjU2tRM3BPYXMrbGgx?=
 =?utf-8?B?K0pIV01JdjlrVWpoNmZ5akhFRzdCYkhhcjBQZENtZE5ZekFSUERCZXZxcHVN?=
 =?utf-8?B?bG1WRVdOZmxVNy9MVjJlMXpFMjhWazcxcVRHMmxBbjE0RTJYWFFkc09qalFO?=
 =?utf-8?B?QmxWdUxFLzN1dEZxV3BVY2Z6VGVyNkgwQVBmQ0MvV05lQVBsVlJGUnd2Ni9q?=
 =?utf-8?B?NWJwNVNiSUtoOHNyQ04xcFlZMGxqckZVOWY4VElJRTVRNExxaFBvM2FhZmF0?=
 =?utf-8?B?OC8xejlGK2Vac2p4MEdLV0ZNanhYUHhuWHZvOGtvZXBMdmFUZ0dROEw1bUdz?=
 =?utf-8?B?OEtFOGQ3RWpYNkNpRkhEMFBod0RlaVowbHpuRlVGUWpuclNjc2lobWFQRVlk?=
 =?utf-8?B?eXFYSmtpV1ZMZnZsM0tEVVdVeFg2S2N5UUVQdVY4VU5xaDVhN2g3Ri9xSFFF?=
 =?utf-8?B?UzN3dE5rZkV4aUFqM20rZ0tGd1FXRVlIU3oxQ3N2VXJvNUI1UkN2WFh5TTc1?=
 =?utf-8?B?MXR4VHBNWEpxbW95Nk9jOExNNXp1VVlqQ3R0Sk1keHE0d1o2NXZkcDd2Ukcw?=
 =?utf-8?B?ZmtKL1VwVW1BZVFoNTBFUHd0eFZqNEI0NlFwSmVNS1FiNjg2K0JGWEZpaVdu?=
 =?utf-8?B?czg4d3ZjSGV2YmFEaGs5TFhmcThXSlRXVk5pcDFNOHJydlE5bHFXVGxEYXNs?=
 =?utf-8?B?T2g5ZE45cDg4aG41dWRKUmJITVAvY1VSYzhBdTBMUzRxSUxrWUNLNTBzQ1Jo?=
 =?utf-8?Q?DcAusrravX3h+WBf0UC99Sfg9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b652292-77f0-42a6-a621-08db91fbeba7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:25:38.1058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3ziiXsz1hPNwvJP/Xdbo72Ye0cGTw94FYjLZPM52cHwq20W9oy+TyWM4zSzT05bFLpLpF2IQrAKcmhdZIC8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Mastan.Katragadda@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/31/23 14:02, Mario Limonciello wrote:
> Some systems are only connected by HDMI or DP, so warning related to
> missing eDP is unnecessary.  Downgrade to debug instead.
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Fixes: 6d9b6dceaa51 ("drm/amd/display: only warn once in dce110_edp_wait_for_hpd_ready()")
> Reported-by: Mastan.Katragadda@amd.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> v1->v2:
>   * Use DC_LOG_DC instead
> ---
>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 20d4d08a6a2f..6966420dfbac 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -777,7 +777,8 @@ void dce110_edp_wait_for_hpd_ready(
>   	dal_gpio_destroy_irq(&hpd);
>   
>   	/* ensure that the panel is detected */
> -	ASSERT(edp_hpd_high);
> +	if (!edp_hpd_high)
> +		DC_LOG_DC("%s: wait timed out!\n", __func__);
>   }
>   
>   void dce110_edp_power_control(
-- 
Hamza

