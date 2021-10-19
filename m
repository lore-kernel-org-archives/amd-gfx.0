Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8744C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7821860F02
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7821860F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C495D6E89E;
	Tue, 19 Oct 2021 04:15:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F064A6E89E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 04:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7pXp43zsOruMD1fXi7bmqMxIwaDP4yU8GeOscTbOVvIUdJlgDH2s0GqAkQad1qzsJ1T4O6r04XM4EabacFP3wCyu8Z4KJQde22voZMbf+l0zlPMHBDHlIt1llqkETrMLy+xw2RUYHHAa0Ss/GGYz+ZqJu2FpmBGSdrYcah0SI/diR14nzgbnDxShjbJDHlIpO9ot+uYLxV0Y6+qKB+Myudu67/aCzFK0DfTRupXwOjzpGFylvKHhaWNI+S3V14OL7KAa6STuTpmrZnGimebCTmTnf67XA+5A8GcQDklJ9iuleBtYY1evYwIWVr2Vy2XL+scf5hFF0m43xMIZFdyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1oaU4YSEV3QLRHWucLTxNoweSeBcWb9xuj0HjKP/zA=;
 b=Q8RiNaeD8on/SOQzJBfrphixy6tQo74BlGxcdp9euarbTGnZA5P+lWpTjqOYWO2Hg/LB4GFcfkth8fIzTUf/eJykds63+uqyDSIJkSpkNJEV7ShX4DrxFSby25yNTGxuI2f11mv+s9DUDHZxAu8C0L/Aa3dapJWDzNPLW4V/p8UOy82czwRuktslM5KSWTH9GhHIb1eVwgPoM65BGYvk6AOwmh+3CiNhKM1AMh216kGdX7BSm1ZwwEFVqEigjd4p6ZlJoiSbg32WAlyhiv9edKrfpb5JSNqkweWQSf6LzutAUqwkJxcm2F1KPVjNnkshq6VcRqbtbYu7n0zc+qNYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1oaU4YSEV3QLRHWucLTxNoweSeBcWb9xuj0HjKP/zA=;
 b=vAyxYf849cmr2sCVcPjMJzPYeR1x4iembOnqKOIAutLI/jp9jQ0YEpYfrhE2YmuPLTFLAKizvzlICyzIJMEO81GOtcW9VBjhQO+QcnyPUFDW3855yF2nMRGH+Lm6sN0BD25JO+2E2NUzjYI2Hr/B5oUqclQjjq8v63SXw82lxyM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 04:15:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 04:15:23 +0000
Message-ID: <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
Date: Tue, 19 Oct 2021 00:15:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3)
Content-Language: en-CA
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
 <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 04:15:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dae7e29-66db-4461-5642-08d992b7123d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435E98567FC321668222E5599BD9@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4ML7710zLs1inALvnF4rr9izUIwf0sS72Bh0zDn5ECFLTb0BMtvZL5BBaxqikbVsJm16VBstdhjz9C58cpllnSO9PYBuYJdiiTjgBAAT9hkodRJWmnQv3tG2O1fw2ztfOjDNitxuts+eW/iNtO2JdD6pNjhKvByUeEK5c7vhIkW/rVztf7pd1wYRzdkN7cNfcqEnZAHhM4gyR7uTHfcuhsx//NhV8pGCor7mqdMhpmdGBwLce8zcs2s2aktMOUopZzIGWfeXpA8rdPza11khgOTFmyETierE87axBbCJVrQErA4v6oEFdJKOifjgwkq1sfbM6xwMg8RoMEOqu5xSkfpJEzXhyhezkiTAGbAmJ07KOXMMiWbL6kM8q2SdVzJkdDPOxsYI7Esvme/1e/yeOARG9Nd9szsdSeexM//zkeH84892J03gd6FRknVKeTTpfKHpHKcM4W0L1KuGwx6q644WawuXGGVzbaBFzNjPXb+JNrByCdVsu50GRQNRcoNe0Gz/byuiVOEyaNcxrAdgMUmwMv4ckL8cF0/+b4yPa+ipRoQ2PGLab8gZCtzwgf1mw9asbUGZCmnagGkQ17gnFSpzagaCOhHaYP18roQ8EgaLRcjkozdvPJ75Cbb6JG6SJjb9KJul25xoTgpWEktSpXolVclzIlsCm9nsAnQ8Hjx/2CEQQfY6AcW+kEQy+QH/WjYRcfr8c4CevW5ps289onf4wCQyBwBdm820NID/u0JyhHFe3olZE17sRzWMxWPiGLEwSLsVhklbwlRdzqrLSlL8TqSfrZK7w4uVH7jG31cx2aySZnKGK9QkLJSCUQ+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(21615005)(956004)(186003)(8676002)(2616005)(508600001)(66946007)(66476007)(2906002)(5660300002)(4001150100001)(66556008)(966005)(316002)(8936002)(36756003)(53546011)(31686004)(38100700002)(83380400001)(6486002)(86362001)(16576012)(44832011)(4326008)(166002)(31696002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1Ldi9EUVp0L2E0ekJaZVIwU0pITGF6UUMraW8zVVlRNUo0dFcrcHNPS0dE?=
 =?utf-8?B?NHBuUmxsaHV2ZVFBK0hWcnNSeEt1bzFBc0o5VGhzMjRwZzYzWGovWTI0V0h1?=
 =?utf-8?B?MWlQZTI2VnJZcldia1d2WWJ2cGd6QXRDNEVSNGI2b2tHTnBxVFJiS01OYkl6?=
 =?utf-8?B?OHdXMDBGTWJxT1hsZGpmTHdjd3hFMjRDdmdTYUhiaVlGUGxmejd3YlR2WUVu?=
 =?utf-8?B?dkJpajAvWEZXR25FVmRrNlJ4bEI3MmdMM2wvK0dZYllySC9qSm5oWEdWcHlr?=
 =?utf-8?B?VENGWEZjd0NyZit0Nk9aWmw0TFNnSndQTDZKc3E1SHc3dGRnaWd5aDZJdjZ2?=
 =?utf-8?B?b2d6U2VMczRteXRHV3FlcDB4VFZMbXQxRkZZT3ZhVTJxbWlQcmtZVkovbmhv?=
 =?utf-8?B?K0sxR2RzZXBIMzQxeVV4WUZJTDdPNUNJaklMaFVrNUxCdnVDbGx5eWkzcjky?=
 =?utf-8?B?L3NBVmNHYUhLYk4rK291NkxxK3B4YzRha0syajJrL1BoZ3lrSTZuS3JoaTRT?=
 =?utf-8?B?M3JiVnZWVTNzN3dyNnR5Z2dOcU5PY1pqOWpEMHNYY0VLVlNDU0VjeERtZDM4?=
 =?utf-8?B?a0l5Qnc5TzE4bG1zV3Vqb01jSnBZRXdHUElndzlFN2h3SjhuWVpDRHJFanpI?=
 =?utf-8?B?TEdlajRmcjl5TVlSODhDWk9sLzJVNmx3d0RXcStZVUwwRTlGTi90TEp1VzN3?=
 =?utf-8?B?cVVaL0F1alVQaVJORXJ2L2g2aGpWREhqbVRRR0tTYlZDV0FCTm5jajBWakdG?=
 =?utf-8?B?bU1sTVBxMzZEZVB1c1BKRFpJYlNTWUVTK0NMQzZ6TE9NaFVldTdBQjhzWVVt?=
 =?utf-8?B?dXJsZGtwcFE1ay9yY0V6bEd6Mm9DYXRlZzFQRzA5S2pDOGZFeUlmU3J3bCts?=
 =?utf-8?B?eVRpNE1HUnk3a1BaYlNlUnRpMlNEOWhGZVRJVjNNb2Zobkw0WmtKc1p6b2FR?=
 =?utf-8?B?WVdKMlg5Q0VhTVJDNXdteEp5L1ZBdXQydE5CTkhMelR4d095YUNxMjljdU5O?=
 =?utf-8?B?RWRISjlpd3NtTkxTZFRySXl0dis4MkZFYkEwTjZaTXUvWnA1RGFkbS96ZjVk?=
 =?utf-8?B?ckcrUTZaZGZwRzU4Njlrb21TTVQ3RUdqVDZFdUlJOU1BeXhMN3EvdnhIQXd4?=
 =?utf-8?B?OU5sMno3RXBHTTlmd3U1aisvbWd1Q1pGdUpuZnM0NFFwYVl3aHExSzZHM3ZV?=
 =?utf-8?B?RUJnWGJydGFLMy9UbDVxSk9Vc1JqcXFUdDF4T2xuQmFzOU95bEJ0ZGphYUFZ?=
 =?utf-8?B?TklRRGhKZ3VNVnEvR2NDUVhaRDZ3bE1NckV4VlFKVy9YekVIalNRN2VnVHlt?=
 =?utf-8?B?V3JtT2dpLzZnTGNhVHRGYjA5cnArUjUvZDE4U1pDZWZwejZ3RXh2SHcwT2Vw?=
 =?utf-8?B?dnB4eGJFWGlwUitNSnl6dEN4WWplQWtQOXBOUDl4TE9jOEZyZ1FuZ0NoMmxP?=
 =?utf-8?B?V1k2ZWJ4TEpEUE9hRDBabHFscHFub0dQcmpKU3ZKd1REd0ErUWEyYUp4VTdx?=
 =?utf-8?B?ZXhGeWd6S09IUVlOZmluQjdlaitVdFE0UzVTVWQ2eXl2QWhJR2ZYaGExMGd4?=
 =?utf-8?B?N1d5ejZwWW13QUE3ZzYweGdmRkVmY2xvZWdGS2dGTGR1NHlxOWJzT2ZaclA0?=
 =?utf-8?B?R0s5VmRBRzk1KzVDY2RXMDB3c2E5dFJvVHY3M2dUYWUwaVhoYVhrbEpFWXNT?=
 =?utf-8?B?WFROb2tHZ1hMU3pVRW83TVBGdHFHcVA0eGpldFN6d200K2RDY0J4ZlBYSFQ4?=
 =?utf-8?Q?nx1OgPbSmyKMAGhHvIaZ9ZvkButnt3mwMnuH3pc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae7e29-66db-4461-5642-08d992b7123d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 04:15:23.3685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVG4F4Tetz+sDHSZgtBkJZcOwzZwoq3zYf9TimrG7WBRnqphTvz2YtlTzWLORTf7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2021-10-18 23:38, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 10/19/2021 5:19 AM, Luben Tuikov wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">A current value of a clock frequency of 0, means
that the IP block is in some kind of low power
state. Ignore it and don't report it here. Here we
only report the possible operating (non-zero)
frequencies of the block requested. So, if the
current clock value is 0, then print the DPM
frequencies, but don't report a current value.

v2: Don't report the minimum one as the current
one when reported one is 0, i.e. don't add an
asterisk (Lijo). LT: It is conceivable that this
may confuse user-mode tools if they scan and look
for a current one, i.e. look for an asterisk, but
they'll have to adapt and use other methods for
finding power states of the chip--we can't report
0 as current.
v3: Start the subject title with a verb. (PaulM)

Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>
Cc: Paul Menzel <a class="moz-txt-link-rfc2396E" href="mailto:pmenzel@molgen.mpg.de">&lt;pmenzel@molgen.mpg.de&gt;</a>
Signed-off-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
---
  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 ++++++++++++-------
  1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f630d5e928ccfe..6fe792be77dbbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1040,7 +1040,8 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
  }
  
  static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+					   enum smu_clk_type clk_type,
+					   char *buf)
  {
  	struct amdgpu_device *adev = smu-&gt;adev;
  	struct smu_table_context *table_context = &amp;smu-&gt;smu_table;
@@ -1052,12 +1053,12 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
  	OverDriveTable_t *od_table =
  		(OverDriveTable_t *)table_context-&gt;overdrive_table;
  	int i, size = 0, ret = 0;
-	uint32_t curr_value = 0, value = 0, count = 0;
+	uint32_t curr_value, value, count;
  	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
  	uint32_t gen_speed, lane_width;
  	uint32_t min_value, max_value;
  	uint32_t smu_version;
+	bool     fine_grained;
  
  	smu_cmn_get_sysfs_buf(&amp;buf, &amp;size);
  
@@ -1077,6 +1078,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
  		if (ret)
  			goto print_clk_out;
  
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
+						      &amp;freq_value[0]);
+		if (ret)
+			goto print_clk_out;
+
+		/* A current value of a clock frequency of 0, means
+		 * that the IP block is in some kind of low power
+		 * state. Ignore it and don't report it here. Here we
+		 * only report the possible operating (non-zero)
+		 * frequencies of the block requested. So, if the
+		 * current clock value is 0, then we don't report a
+		 * &quot;current&quot; value from the DPM states, i.e. we don't
+		 * add an asterisk.
+		 */
  
  		/* no need to disable gfxoff when retrieving the current gfxclk */
  		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
@@ -1086,38 +1101,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
  		if (ret)
  			goto print_clk_out;
  
-		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i &lt; count; i++) {
+		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
+		if (!fine_grained) {
+			/* We already got the 0-th index--print it
+			 * here and continue thereafter.
+			 */
+			size += sysfs_emit_at(buf, size, &quot;%d: %uMhz %s\n&quot;, 0, freq_value[0],
+					      curr_value == freq_value[0] ? &quot;*&quot; : &quot;&quot;);
+			for (i = 1; i &lt; count; i++) {
  				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &amp;value);
  				if (ret)
  					goto print_clk_out;
-
  				size += sysfs_emit_at(buf, size, &quot;%d: %uMhz %s\n&quot;, i, value,
  						curr_value == value ? &quot;*&quot; : &quot;&quot;);
  			}
  		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &amp;freq_value[0]);
-			if (ret)
-				goto print_clk_out;
+			freq_value[1] = curr_value ?: freq_value[0];
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Omitting second expression is not standard C - 
<a class="moz-txt-link-freetext" href="https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html">https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html</a></pre>
    </blockquote>
    <br>
    Lijo just clarified to me that:<br>
    <br>
    <blockquote type="cite"><span style="color: rgb(36, 36, 36);
        font-family: &quot;Segoe UI&quot;, system-ui, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, sans-serif; font-size:
        14px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">well, i had to look up as I haven't
        seen it before</span></blockquote>
    <br>
    I hope the following should make it clear about its usage:<br>
    <br>
    <font face="monospace">$cd linux/<br>
      $find . -name &quot;*.[ch]&quot; -exec grep -E &quot;\?:&quot; \{\} \+ | wc -l<br>
      1042<br>
      $_</font><br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Lijo
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &amp;freq_value[2]);
  			if (ret)
  				goto print_clk_out;
  
-			freq_value[1] = curr_value;
-			mark_index = curr_value == freq_value[0] ? 0 :
-				     curr_value == freq_value[2] ? 2 : 1;
-
-			count = 3;
-			if (mark_index != 1) {
+			if (freq_value[1] == freq_value[0]) {
+				i = 1;
+				count = 3;
+			} else if (freq_value[1] == freq_value[2]) {
+				i = 0;
  				count = 2;
-				freq_value[1] = freq_value[2];
+			} else {
+				i = 0;
+				count = 3;
  			}
  
-			for (i = 0; i &lt; count; i++) {
-				size += sysfs_emit_at(buf, size, &quot;%d: %uMhz %s\n&quot;, i, freq_value[i],
-						curr_value  == freq_value[i] ? &quot;*&quot; : &quot;&quot;);
+			for ( ; i &lt; count; i++) {
+				size += sysfs_emit_at(buf, size,
+						      &quot;%d: %uMhz %s\n&quot;,
+						      i, freq_value[i],
+						      curr_value == freq_value[i] ? &quot;*&quot; : &quot;&quot;);
  			}
-
  		}
  		break;
  	case SMU_PCIE:

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>
