Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD94C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 06:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E424061053
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 06:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E424061053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FD76E9FE;
	Fri, 20 Aug 2021 06:05:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B606E9FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 06:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZhmCi/C+rj4CldlrEMVcUgbcuMBJoSPakCRD+yb5HFOLVoXuuJ21D8HXsVtaPs19TO0UWHaw+Fbzz0TB9BaFYo7h1BXPLcjhNmsF84WU7hCs0fO00icP9/PPsWYESmSkT6xQS/wDjnPk8JHFKNOUFPyhTL2oPL+Eiftp8b2wBGEtWWQf++a4oomtCWIcSbtMQjjXk4RcJFj6Qc6pYhKTAMOIkP3/XwLNNbMpp1oTL5a4iBKCp1zjSEelf7Ep/v8jQB++krEXtiGPZeS092CGFIOx/bxX7E2kTVi0mdtPr2CQ/h57QWoCaHaHNsbdFqbtnM77egWInx9nc0q3+Sz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJSICixLYp5ch1pgjKWLvvLy6ZFV/gCtOCfWhOIUjdM=;
 b=OxiPVw+Bv9hdc70/mlISz995/R3ftznJZ3ghIv7FB+ViBMy8nYnT8BVM0uRDaDIVCmfOC6+EVmJPsX1L57JKKXeXII3jvfR7sJxaOUHv1YUQti1x75I+GAXWN4+W7WBsQlteNer5Hwi8tFe0Lej57UVz7qukrknVmjwa/qCiF1+lAo2d4vVgl67covioxXJWwAir21QcF9fIh5k6FjXGOuDRhz3LaKqtkRjm0bJLWCenDK5G4/JKzdGcYMG9hWpIUdmJcIqYHz6l9YwFXlER0s7jAmu1WKJ+8W41IDS1fXxjNsrCnN80At8MgrqF+aQWq3b+gCSufC9u0cA211UuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJSICixLYp5ch1pgjKWLvvLy6ZFV/gCtOCfWhOIUjdM=;
 b=p3cNHhGuhqQ4mXBQAxdz7thQKOdqT5CavjGLKFXIkNG4Eq78aEuz00+DGwyTMCJ+V5c8HI2DDeomkTR7fU2oVpBV2DVYt2p0pfQ/XJ7E7BMG5yPd5KbWHjnqH/BaiPfvc3Fty66d4XCn+/SGXTPZZM/qo19xMC1z/a05734nG2s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 06:05:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850%9]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 06:05:31 +0000
To: amd-gfx@lists.freedesktop.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Christian.Koenig@amd.com
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Subject: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
Message-ID: <1d64e5d6-8981-3bc2-21dd-b8eaf7a9333e@amd.com>
Date: Fri, 20 Aug 2021 11:35:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.83] (165.204.158.249) by
 PN1PR0101CA0030.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 06:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ebd462-6998-454f-1165-08d963a0843e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54622229E14503BED482C9DCF2C19@DM8PR12MB5462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxf1pH6RcWEKSLdaDneJobF/4UVxpU9qrAKf9DsIFSWl+3rVIVp6ON/XpyZbjfRfN9LXHvQx1fRefFJFBT619JRzredTBDDHpnLWf5E30Jn9oEc5aP/Wv7G/EJ2rUcCL/FWUrnB/y93F0FOgnHo1InoIQCf9kbLASquGfFY4s7YBpiH3hBAdqE6cECbnOWzz81EtXe4XPB8cPj1UoS5NAdctXnFtaCAtMp/aGWGx07yQ2dhhgofAoRT6A6RybGK0RrjQikGIuy+TMdjt91JEZBkQfCIP6CGICZ/HdBHL0iy3raBmcg1D0grR+oXZ5uAOFTT77GeT80h5ps8xqz+rRvNIawc3bwLQo2hA16+PrD046TNUllMYhe+c+ALePO5s3GVEg8HU9YTvBojIu5d+0lMVo2UQWLcaChLvxqn+WNzT99dcEYel2dJWZJ0NRnA9YRtDOX7IXO791x0fC0Kh6EpJIUEqxKIONr5A+fXQzwtYJAKrmfO6rEjYX4Hu2gD7913CBBpdvIptA9D0uhJIXQmJ/VXfR3VA6pViaFpNPGn/C8uPmJI70mgmMIdv3RF1/11+ryOks44GMvXr9Msr1ob+RlHUxN92T9Si0Ah6ZlS5Y0fE64hsUWi3emjviXkWWzi5laB0E0YuKITgfEqf/HzkFxbcJvpTxUlRj+Fd0BwfTEnS7LfJHdDq/shk8a4kDTvJ2TSi2qwrbbLBiGT1LpVNDOal/WcB4vnJXAhWbp3coUnzt79blQ/3hh6QAgRkyw04FewmMufXXaYQuu5JeN4yUFc/1MB663mDQloDHgcB6N18O7k1PAu3BgksiqeM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(966005)(26005)(478600001)(186003)(31686004)(2906002)(16576012)(83380400001)(316002)(6666004)(38100700002)(66574015)(66556008)(66946007)(2616005)(36756003)(66476007)(8676002)(53546011)(31696002)(956004)(86362001)(8936002)(4326008)(5660300002)(6916009)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWN1amIrcklKT1BEc2x5NFY0R2lCM3pKM3htQjB5cUdMSnBFSmxrQTl0Y0RL?=
 =?utf-8?B?YVp6V3UvWHRkY0hyZkZpT08zMmVSYm9xeTAybjVGQWtMc1BYakpWTkF1dSs3?=
 =?utf-8?B?R0pZbTVSY0hiSWdHWTVEZlhtVDkzOGJFZWFxU3RoYk90czQ1RjdpYXpDanF4?=
 =?utf-8?B?WjZXdXhxOGV2cFZ0L2lXSm03V1dvT1gySDdyQjRhVlhIcjNpSGZGVWRtaGxI?=
 =?utf-8?B?dFpFZGZlQkxpNXh0OGhvOVJhdEJuSllhbUNYeDZXWUtyZ2lIMWgrMncydWR3?=
 =?utf-8?B?S3Q0bFNDbnpJb2FzejMva3pzTUx4bDZDR1RxUC9tNDlBR3RHaGtqb0Rxbmg2?=
 =?utf-8?B?YkFiRFMrazQwQjJvSVBiMENXdGlrSTZ2Sk1VeCtCK09lUWtCREVaNCthODdE?=
 =?utf-8?B?bk82aTQvcXFKdGx0dFo3dTg4R09jWFlpZHdsd2JUaFRhN2hEY09KQ3J1R2pj?=
 =?utf-8?B?em5wVVNqQkVzeDdJeUJjY21DaFJyUlVxQjFERTM5d0dOZVVVVzFtemxVZ1lk?=
 =?utf-8?B?ckt5bVlnQTRNUUJ6NUtyTE1EUjZRMFhKQTgyejJ4cndFdnpEVlVqYXR6Tnpz?=
 =?utf-8?B?MFk0aFNZK3haaElCU1dmMFJRNzRLbEtlZzROUnJ3VWxFUzN6U2RJck1HSmpl?=
 =?utf-8?B?K0M0VVVYU1F4MHpNU2kyS2Rab2dCUmJuMlpJS1YwN2oxUjlUejN3SXZJdmlZ?=
 =?utf-8?B?TEZ2MVZ3SlRHZHQwci8ySVJGWUlVSVhBZWpBdVY0Y1hCeUpabWZlZ2lNZ0Vi?=
 =?utf-8?B?WlZRWkNFbWk2bDMrTDRqN28waGRPMTBsU2ZCMDZrcE9XdW5VTUZHTDhsRW9E?=
 =?utf-8?B?eVdZV1ZIeE5QZmhMM2grSXZBRTBBVWcwN0psRFByT1kvbVRiK2EvZnBiVjVT?=
 =?utf-8?B?YkRvMjR6d3FuWlhlUHloRkpZbWU4aVp3ZVJPWFVQRFRGL0ZVUExNb29HKzdl?=
 =?utf-8?B?R0tENmJaVmxibkcyTndMWUFQaDQrVXUzeGdISUVaeWJvUVJVOHFiYndlM1Nq?=
 =?utf-8?B?Z1BHQTdsL3Z6NDhRY2ZkZXZCRUdzK3MvTVNSdklvZHVpZ0NBbXFXMC9xLzRS?=
 =?utf-8?B?bUE4b2hoazVsRldmejdtdWQ5ZDAwL0lZbVFSOXNWSUFPeHV0cUhIV0pjTjFZ?=
 =?utf-8?B?a2RVaXlxT2phUG1DRXJ2Y05NTDdvS0xORnZiYXF0YUoxbHREZ05GNExINHUx?=
 =?utf-8?B?cGFETTQ2QSs4cENDN3JzR1lkZEJPNWhMdTlsd3RLdG1YSUNqYS8zMXRyQ1R6?=
 =?utf-8?B?TWFmYkhuRzNXUWFwV0UyaTRYdmVVaXJDNzRQMkdMcnZkMkllSTE0a1FvaHRM?=
 =?utf-8?B?RXZOeGlGL1ZuR3N2dlYrM1JsbUl6U1Z0TnFxWjlXM3NTLzhrM2JHZXhZRVll?=
 =?utf-8?B?alUzYUYxNHVSQklVd01VZDBnME95T3dMSWpYVEtMOTZJMzZTSXBTOGVjdTdW?=
 =?utf-8?B?OVpoNm1CaWFKYk5Kc0RrWjFnaXV0R2R2WUhyM29uOVYwV2xIa2NJcDlUNGF4?=
 =?utf-8?B?WVdTeVZoSlB1UlIxaDVUc05ZMXphcnpoWERkdjVYSkxmWGV5RWJXS0ZHWWFV?=
 =?utf-8?B?QmI0bWZuZFlWeWU0ck94eDZHdWFQb081R3VFdHEzV1huR3RaaHR2Q1FyVmxH?=
 =?utf-8?B?SGVHQis4alZuc0hjNWoxV2pkVFp3NG1DRWkrbG1IUW9xTkdZOE40MHp6Mk5L?=
 =?utf-8?B?TURqd3ZRc3RXd1Qwa0VGUEFRY29KNEtHRzBML0dYYmdVRGJIZExwVDJiQ2NW?=
 =?utf-8?Q?uz4T90S9xU7EoDE8/aj8d2g282h6Og6KmpaXv+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ebd462-6998-454f-1165-08d963a0843e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 06:05:31.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XThB9ZDT9LFVWZkoEHEcg3IfvP6jDza4uj1V5G5m6k4cMKaUXMLKXsf4U2GSVBJ2knVWxSVj2CtgHrG+DrZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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

 From 4841e5ba60e33ff798bde6cb69fbd7e137b6db9c Mon Sep 17 00:00:00 2001
From: Shashank Sharma <shashank.sharma@amd.com>
Date: Fri, 20 Aug 2021 10:20:02 +0530
Subject: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch limits the ref_div_max value to 100, during the
calculation of PLL feedback reference divider. With current
value (128), the produced fb_ref_div value generates unstable
output at particular frequencies. Radeon driver limits this
value at 100.

On Oland, when we try to setup mode 2048x1280@60 (a bit weird,
I know), it demands a clock of 221270 Khz. It's been observed
that the PLL calculations using values 128 and 100 are vastly
different, and look like this:

+------------------------------------------+
|Parameter    |AMDGPU        |Radeon       |
|             |              |             |
+-------------+----------------------------+
|Clock feedback              |             |
|divider max  |  128         |   100       |
|cap value    |              |             |
|             |              |             |
|             |              |             |
+------------------------------------------+
|ref_div_max  |              |             |
|             |  42          |  20         |
|             |              |             |
|             |              |             |
+------------------------------------------+
|ref_div      |  42          |  20         |
|             |              |             |
+------------------------------------------+
|fb_div       |  10326       |  8195       |
+------------------------------------------+
|fb_div       |  1024        |  163        |
+------------------------------------------+
|fb_dev_p     |  4           |  9          |
|frac fb_de^_p|              |             |
+----------------------------+-------------+

With ref_div_max value clipped at 100, AMDGPU driver can also
drive videmode 2048x1280@60 (221Mhz) and produce proper output
without any blanking and distortion on the screen.

PS: This value was changed from 128 to 100 in Radeon driver also, here:
https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8ececc891fc3cb806

V1:
Got acks from:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>

V2:
- Restricting the changes only for OLAND, just to avoid any regression
   for other cards.
- Changed unsigned -> unsigned int to make checkpatch quiet.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Eddy Qin <Eddy.Qin@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20 +++++++++++++-------
  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
  3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
index f2e20666c9c1..6d04c1d25bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
@@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom, 
unsigned *den,
   * Calculate feedback and reference divider for a given post divider. 
Makes
   * sure we stay within the limits.
   */
-static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, 
unsigned post_div,
-				      unsigned fb_div_max, unsigned ref_div_max,
-				      unsigned *fb_div, unsigned *ref_div)
+static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, 
unsigned int nom,
+				      unsigned int den, unsigned int post_div,
+				      unsigned int fb_div_max, unsigned int ref_div_max,
+				      unsigned int *fb_div, unsigned int *ref_div)
  {
+
  	/* limit reference * post divider to a maximum */
-	ref_div_max = min(128 / post_div, ref_div_max);
+	if (adev->asic_type == CHIP_OLAND)
+		ref_div_max = min(100 / post_div, ref_div_max);
+	else
+		ref_div_max = min(128 / post_div, ref_div_max);

  	/* get matching reference and feedback divider */
  	*ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), ref_div_max);
@@ -112,7 +117,8 @@ static void amdgpu_pll_get_fb_ref_div(unsigned nom, 
unsigned den, unsigned post_
   * Try to calculate the PLL parameters to generate the given frequency:
   * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
   */
-void amdgpu_pll_compute(struct amdgpu_pll *pll,
+void amdgpu_pll_compute(struct amdgpu_device *adev,
+			struct amdgpu_pll *pll,
  			u32 freq,
  			u32 *dot_clock_p,
  			u32 *fb_div_p,
@@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,

  	for (post_div = post_div_min; post_div <= post_div_max; ++post_div) {
  		unsigned diff;
-		amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
+		amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
  					  ref_div_max, &fb_div, &ref_div);
  		diff = abs(target_clock - (pll->reference_freq * fb_div) /
  			(ref_div * post_div));
@@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
  	post_div = post_div_best;

  	/* get the feedback and reference divider for the optimal value */
-	amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max, ref_div_max,
+	amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max, 
ref_div_max,
  				  &fb_div, &ref_div);

  	/* reduce the numbers to a simpler ratio once more */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
index db6136f68b82..44a583d6c9b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
@@ -24,7 +24,8 @@
  #ifndef __AMDGPU_PLL_H__
  #define __AMDGPU_PLL_H__

-void amdgpu_pll_compute(struct amdgpu_pll *pll,
+void amdgpu_pll_compute(struct amdgpu_device *adev,
+			 struct amdgpu_pll *pll,
  			 u32 freq,
  			 u32 *dot_clock_p,
  			 u32 *fb_div_p,
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c 
b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
index 159a2a4385a1..afad094f84c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
@@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc 
*crtc, struct drm_display_mode
  	pll->reference_div = amdgpu_crtc->pll_reference_div;
  	pll->post_div = amdgpu_crtc->pll_post_div;

-	amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
+	amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock, &pll_clock,
  			    &fb_div, &frac_fb_div, &ref_div, &post_div);

  	amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE, amdgpu_crtc->pll_id,
-- 
2.30.2
