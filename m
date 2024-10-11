Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8328FD0EE34
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 20:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0AA10E06B;
	Fri, 11 Oct 2024 20:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di/g85kJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089CD10E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 20:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muQ+a91/3mI8gy3Io3gK+jPFK2ZVMU+byEqfTNrCY1vKonEiFnutur8NZCT9BFYqmZSb11xbwt9hFbZeFCkgS393+IjHTrpC1oCELxMft7PTCQp9OCuubtnAqaiC6UrDgKNsWWuvg4QzMpVT5Q2q7NNJXy4lxpPEOVzTLdjsnCvoNFnXDNn1n8LIHX1eCJ36kTLF2uTtFMMzEYwlMusFT0eWe044WxVJAOXc3Lwrlxzi09m93UOBDsFGswVALWHsRGmasVhUycqy7QK1bYGiE7IQQb2QIxR1L5C196MgSVO3IPJdTFp3kUuxGBE/VBT9+5uH1asrlnRKsoyc8fbB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlP8PgtmQIUhkC3LQwvmSu2dtqLogdDetUR8lXgPypA=;
 b=Wyhe4btfTI7rlXJ1mtQ2rQ3Y6OEU759Hg9mbgjY5OuwIiZZhp6jOZxqx9EHzZFlWSgGuTVwY794uucSqrxgvqQcok+kRSfeFBGu5bVp5R7PPqqYq8pRKx2IFA1XxvGRQIWIxn89ZNAuySKUR8vCZOdurgeF9k33Lj5OFUSwG2L7quDJvS2EWCCMlCPwJb2qS76V0HV2Y1p4ostjW/X6A4Cx0XJ9n/ScAlc8rml9jvG2ztJDTZSzgQY1ZAOKSBoazz3s3GRuhYcpoPGg/cYJWNG7gJfIQXmVeENbulJliklwNikzZX7+/bAdKAOPFBdlxvw1X9OUmjFZFd/N/RU2K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlP8PgtmQIUhkC3LQwvmSu2dtqLogdDetUR8lXgPypA=;
 b=Di/g85kJQC2DhwvBhPjf4C64E4hO+/eHRewU2zzCC4z2x5ZjcODsuTXA3BXFi3tr36JCYppQq3s1qiDfW2FNFLdMRG0wuewMf1SoA0tGrgipLjIUrIEqs17ERYB4xvHDEUrXWa9xd6etf2BYfFPp+DuH1y1y/sgPC/tL05kJvxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 20:27:33 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 20:27:32 +0000
Message-ID: <4d88a7e2-26b0-d20b-de47-437e1055549e@amd.com>
Date: Fri, 11 Oct 2024 16:27:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Save pdd to svm_bo to replace node
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20241011150007.26310-1-Philip.Yang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20241011150007.26310-1-Philip.Yang@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: a261e105-0912-48da-c027-08dcea3322a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWRWaUpmaDFrb0Rub0xlWjA0Uko0SVgxamFSMVZ1ZU53Q1lHbG5ZNEtjUW83?=
 =?utf-8?B?WkpVTHJuekc3Unl2UWJnTHh6RlRLVlVnV1JpUEdVTkRsOG4xWDJvbURZdUhp?=
 =?utf-8?B?M0J1SGZUdnRTTTdLbmdJMVlSNXFtMzc1cnN4c040Q3ZzQi8yUDRZR0JVdW96?=
 =?utf-8?B?NVVvMTJDa0V4clBUMlBVaGRtNStvUFpIcTVJd0VPaGV6Ym9pMDZYZW54UE8v?=
 =?utf-8?B?dU1oZ1JSYi9pMFBsSzREN2FreG5yMERlSDVhdGZWc29XREpZREdUQldGZ1Rh?=
 =?utf-8?B?cXVPWGpZWUhqZ3U5N3ROYXVrNkNkVCtVUm93dUZwYXpOL1BqV0JuWFVFcWV1?=
 =?utf-8?B?TUlBU3hITGx1aVVUWi9RNUp3cDdMSmF6aGVQOWZyVkYwOXJvSEtqZTAxWlFU?=
 =?utf-8?B?ZmxuaXFnRXk2M0VmRnQ1Q0JrYS9mQmlDMTNob1VuVjArNGZMR29yKzRGL2Fn?=
 =?utf-8?B?YVloVjJudk5WUU1uSEorY2ZBMzc3eFN6VEdYWjFRbUI0Ylo3RCtCSEJxUjVP?=
 =?utf-8?B?djNhdzFKQlYrbE8vMUY5a2s3MkozbXdFUUc5bFErbERCQjZSNC9Xakw1Nlo5?=
 =?utf-8?B?cXZPei82a1lpNkl6ZFJPMndDeUJZUTdwZlJSVXBLRFhVZEZhME1OZ0ZOaDJT?=
 =?utf-8?B?RGZ3K3VuWWZxajFVZVRRMDR0VHY4T3ZtY0RKQS9BV1hxSU9FOW9FUnhIVWpp?=
 =?utf-8?B?eEdMeFZMeHNLZ1BNRDlyZkZxcFBXOFpldGFlekdZbUVvVElNYWlRKytlMElK?=
 =?utf-8?B?RXVzZDlMaXNCbFZldW1ZQ3ZmRHVmRmxvVlRyVmJzajZDZDRJdGZ6b0ZEU1Jr?=
 =?utf-8?B?THh5eEdGYWsrZzZZTnQzb0VkeEdmOEhIcGg4MmhvUHVlSTJlTGoxZFlmUVM5?=
 =?utf-8?B?dW5qWVpTN3NGWERaSU90VGhURjEwQVVveWdFbUp5TDlMNXJwOEduS3hFbTZv?=
 =?utf-8?B?Q2dlVGpqU3h0MytVcHhORmlWbzcrTmRHUWUxZkRYcGl3TVZwWVZQS2lCZXRU?=
 =?utf-8?B?MHcxM3I1VElDdzduQzhhdjd2VWFvMHpqWWJYM0F6ZVFqd2VKNmNpakVGbTM3?=
 =?utf-8?B?NkJoWThBNHRCVGlKaUphSWwyUVRzaDdqYlpkRFVvL1hNbndpdVlpL3FsVk5n?=
 =?utf-8?B?VVl6TXRYM0laN3kxck5ZaGJVOXhsaC9pS3Y4MWplWXJ6WFVpV2RHckEycnFT?=
 =?utf-8?B?N0J3dUFvM3Q3REVSQzlMVVhiWEpzSUphSTU0TTNab1F5cTAxYkw4bDV3Rzg5?=
 =?utf-8?B?bUlKSU01RVU0QzFCV3VkNkNCdlVTQWgwcGVEbG9vdFhTUFdjc2ZaVDhWOVlw?=
 =?utf-8?B?WnBJWE96QkJCVFFJemNEVFB4ejYydkI4aDc1SnhtMTVJbTlnY0dJRkJqajgw?=
 =?utf-8?B?VDd3dDFDTjFpRWVqdEZNNGxod25nRXI4MWhNK0VYZ1QzMm91QzU3R0VrNE12?=
 =?utf-8?B?REFkeW1Kcmd2ZHpQMk5hM0hMV1JXZFJtdVdKMVJTR3JiSmZWOTgySHB5RWtS?=
 =?utf-8?B?UnZEblFlcjJOT3p5NTlQT21YTnRPQkJTYkdncXRLUFA3QnFPeVc0S0ZBMmlV?=
 =?utf-8?B?S056UWZVZmh2cVdXNUhVMzBBcFRJOTcxUjhPbVo3d0htQWorTlJhYmwvQk4x?=
 =?utf-8?B?NTNnUmhzVERCTStZaHgwZDdjN2pvSXRWOUR6RnZGckJYUzNBL2dWWlFGRk4y?=
 =?utf-8?B?bUFGTHVOVHd1MUtqMGVKRXpqUVNTUmFtTUJMemJpazNuaVRpb1FudS9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JzZkdtTVNYWVNQQW1wZUEyTEwyQlpieUtVOWZxeTc3eXdka0w1UlByOUhN?=
 =?utf-8?B?djJqMlVXTUtVSzNKRDc0aFE5L2pqemRGeEhvdkVlc1BsYWt0UGRtVkh2Ujhk?=
 =?utf-8?B?OFdHTHJwMUlmSlgzSjVGRFdXVmZGVnloeEVKeHlZZ2U2M3RjWmtsVk9tdVhJ?=
 =?utf-8?B?MzdRM0Y2SWdsVFJxYk9laDMydGM5L3RWTzJRK2t4eVBiYUR1bVdLWmRTRysz?=
 =?utf-8?B?ZDZaWHR2aFQvQnpsb0dITUVaalhaU1pnT2VXd1ZxbCs4OVVQbFdXdDJMeWwr?=
 =?utf-8?B?US81WGtaZTF4OGtzMVZUK2lIUURyeW0wN1NNcmRKdHJDWmVLWkxxQTZDZVJ6?=
 =?utf-8?B?dWRkK041SGFBUWh6TlFJZmJpZGpkdW9iaG5kR0JUV0t5RVdKSGdFanlQUnp2?=
 =?utf-8?B?Y2JGdWV2Sm95UE83b01BMkpKSnp4eUJLaVNKdVhuMkVCbTdSalBOR3luZjdG?=
 =?utf-8?B?ZDBCaHBuclFZdXhZdmhTSUNMUWNrd1lxUHZ5VWpNQWhWNUtLNzFvbnZibUlQ?=
 =?utf-8?B?VGRkL2F6VlhMOG94MWlkNDRQMWt1cDBzRHRQc1FicjJUbytYNTlnd1crSTY5?=
 =?utf-8?B?YlBMR3pnTjdQKzM4TXRac2ZjQ2lCeHRVcXRTY0lxNnpvSjN2ZWFjMmpUMWZJ?=
 =?utf-8?B?Q3E3V29qeU9uS0dWajdZYkh3aXJXS1h2Zmtzbjhpc3FmaTkxZEZaSGtpNCtB?=
 =?utf-8?B?ZkJPdS9hWVJWWFJCc05yNjlyTzhkSnpFbzc1dCtlSUdsTUJNOW1nMmxjWkht?=
 =?utf-8?B?Z0RBWmJ5MVFsci85Y0NaQ1BLZjZrYmJDQWJNa2VRNlFtakdRaUVibWd6SnFt?=
 =?utf-8?B?NWt3SUtLNjJFdFlxbWNkaHhyN2ZoeFdMSStyeE1uaXFCUStUM3NMTHMzdVNT?=
 =?utf-8?B?NThnUVdzcmFtTWV2emFLVXNQK0gybUFPT2hYWkNkQXVVZi9jQ1BaMitYb0pq?=
 =?utf-8?B?eFNrWERoUytPUkhNQThvMlhQYTE4cWdIZVZMUVphVmFJY2srUzRRdXJLaDl3?=
 =?utf-8?B?TFZiTzdBM0dGbHNiWTB3cmhuREtwU0tQOTE4bmp2eERkUHRDTzRPUS82TndC?=
 =?utf-8?B?ampMa2NVUzRKNDUvbWZZV1E3UjFUOFBjMTN3M0Zxbjh2cTB2M1BzMkcwUFB0?=
 =?utf-8?B?cGIrTnJCTHp3aURSZjRyb3IzeXMrVkI3T1kyWjdLQVJnekJIOG5XbE43ZzZ0?=
 =?utf-8?B?MUtBUVgyWVl3Nk9PYVVoYmM5WHpRQWo4MDgwLzJFV2djbTBTdW16cHB2eVM2?=
 =?utf-8?B?YjU1eEFZMG5JbDNtZlBUM01KbVhkL05iOWo2Ylpua3JmWkVVb1RkbHFiVkVJ?=
 =?utf-8?B?WUtDcHBMQlI3SWhEMzJ5NkYrbDVndzBaUGtlYWJkRFJGM1FucDM1WTVud2VC?=
 =?utf-8?B?cGtTSkpqblV5MW04NVhUMWhLMnljTFNlckkrNnl2MS8vMWVOWXZiam9mY0p4?=
 =?utf-8?B?bU14Q1h3bDhTTkQvblhWOFdybHAwcGxScFpaUTgyTHFObUk1VWhKUHpaanZl?=
 =?utf-8?B?dFE3ell2bE4zNkVNc1FoWFhtZFdJN0o5bXNleHgrbGV5TlBGcHRsT0d4M0FR?=
 =?utf-8?B?RUJMUmNmZ1p6TjRUMlM5TEE1eHFoMjE5dDB3NjJFWDMvY0VLazZtd1MrUXEv?=
 =?utf-8?B?cy9pSlhScEtRTHhzY2VoVEhxYmJUQTZaY0tZUi9RZXVEdlpBWG0yUTNkZjdT?=
 =?utf-8?B?M0ZtQ1FlaHVXQUVCN2lyS1lkSmdYZGxVRVVTd1pIU0grSXdyaFN1b0MwNHJa?=
 =?utf-8?B?TWQ2bzV3Z3UrOVVOWU5HbXQvWTd5bTBkbitUSDd6ZXh6T25EV3M4YVRMQ05x?=
 =?utf-8?B?ejVpQy9wdkh5R3ZZMFNTUEJpL3NYNDgyT1N1d3ZhMXZiYkFvYjNYYnUvQU1p?=
 =?utf-8?B?ZDNucGgvTjJtYTBlV0ZZV2hoUEdreUhEdXBsQUJRY0JYajVsbE1GOTFoTVNO?=
 =?utf-8?B?dE00UVRhaTkvdk93eHV0TnZOaFB3cnRCdzMrWjA1V25kU3E1Nm0yOXc1TklI?=
 =?utf-8?B?R085S0p5QU9sT2lCZ0hDNlUwMHBZcVZ1clVtRk1oRXp6VnBFTUp4NnV1dDJy?=
 =?utf-8?B?aDFlVkVrN05vK2RPZFJtblhwMk5XTGNLWFo1TnNHdmIyTEtSZ2lCdzE1T2hG?=
 =?utf-8?Q?a4/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a261e105-0912-48da-c027-08dcea3322a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:27:32.6669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMmV6ER1U03MgOGnxKfLKeth69kz4XzCjZWRbnHgMQvBovQus5dbQF7yKiYvLH61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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
    <p>Drop this patch series, as Felix pointed out, the forked process
      takes svm_bo device pages ref, svm_bo-&gt;pdd could refer to the
      process that doesn't exist any more.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    On 2024-10-11 11:00, Philip Yang wrote:<br>
    <blockquote type="cite" cite="mid:20241011150007.26310-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">KFD process device data pdd will be used for VRAM usage accounting, save
pdd to svm_bo to avoid searching pdd for every accounting, and get KFD
node from pdd-&gt;dev.

svm_bo-&gt;pdd will always be valid because KFD process release free all
svm_bo first, then destroy process pdds.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 857ec6f23bba..d40f6fb803df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
 		if (is_zone_device_page(page)) {
-			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
+			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;pdd-&gt;dev-&gt;adev;
 
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
@@ -457,11 +457,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 	}
 	if (svm_bo_ref_unless_zero(prange-&gt;svm_bo)) {
 		/*
-		 * Migrate from GPU to GPU, remove range from source svm_bo-&gt;node
+		 * Migrate from GPU to GPU, remove range from source svm_bo node
 		 * range list, and return false to allocate svm_bo from destination
 		 * node.
 		 */
-		if (prange-&gt;svm_bo-&gt;node != node) {
+		if (prange-&gt;svm_bo-&gt;pdd-&gt;dev != node) {
 			mutex_unlock(&amp;prange-&gt;lock);
 
 			spin_lock(&amp;prange-&gt;svm_bo-&gt;list_lock);
@@ -532,6 +532,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -548,17 +549,22 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 		return 0;
 
 	svm_bo = svm_range_bo_new();
-	if (!svm_bo) {
-		pr_debug(&quot;failed to alloc svm bo\n&quot;);
+	if (!svm_bo)
 		return -ENOMEM;
+
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (!pdd) {
+		r = -ESRCH;
+		goto out_free;
 	}
+	svm_bo-&gt;pdd = pdd;
+
 	mm = get_task_mm(p-&gt;lead_thread);
 	if (!mm) {
 		pr_debug(&quot;failed to get mm\n&quot;);
-		kfree(svm_bo);
-		return -ESRCH;
+		r = -ESRCH;
+		goto out_free;
 	}
-	svm_bo-&gt;node = node;
 	svm_bo-&gt;eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
@@ -629,6 +635,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	amdgpu_bo_unref(&amp;bo);
 create_bo_failed:
 	dma_fence_put(&amp;svm_bo-&gt;eviction_fence-&gt;base);
+out_free:
 	kfree(svm_bo);
 	prange-&gt;ttm_res = NULL;
 
@@ -1176,7 +1183,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
-		bo_node = prange-&gt;svm_bo-&gt;node;
+		bo_node = prange-&gt;svm_bo-&gt;pdd-&gt;dev;
 
 	switch (amdgpu_ip_version(node-&gt;adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 1):
@@ -1440,7 +1447,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 	int r = 0;
 
 	if (prange-&gt;svm_bo &amp;&amp; prange-&gt;ttm_res)
-		bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
+		bo_adev = prange-&gt;svm_bo-&gt;pdd-&gt;dev-&gt;adev;
 
 	p = container_of(prange-&gt;svms, struct kfd_process, svms);
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bddd24f04669..fad2d6d2223a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -48,7 +48,7 @@ struct svm_range_bo {
 	struct work_struct		eviction_work;
 	uint32_t			evicting;
 	struct work_struct		release_work;
-	struct kfd_node			*node;
+	struct kfd_process_device	*pdd;
 };
 
 enum svm_work_list_ops {
</pre>
    </blockquote>
  </body>
</html>
