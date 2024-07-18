Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960DFC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 19:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C46410EA71;
	Thu, 18 Jul 2024 19:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSPPpyl9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFEC10EA71
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 19:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUQSKWpwZ5z9vEY6JGXHeBf1Eto70rJd78D02PMuIx/shYyTWpfemFc9KB4HooQB/vmsKrRODQrsUqpmK+5yOqutqAxa7/7EgCMs4elCUvPkmqwatMssyWLsVmcJghTI73VFX/cWKsx5Ek1V8sN2vgxOwf6c1Oia6WFziX6CZw5Zp2+rOiKO+Xvsl5wSpQ9VN3jGTmYbpgtbnQQG+NN6VRoK4zvKSiCd7PdMM9205XQX3vo5tzmjaLHQwukoyudi/slBMwiDVkh4qzwhN41pnGGaV+EAHLQh9W3x0GpPGktKOsEQt2ckun5LI5BvOjX4rKNN05y95LL7X9hPNk/91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67YK4Kif5Zy222AW8kKa2zZ4ztVayn8zElu9tytler4=;
 b=LReGd9r1UoVwpnbguTtkC6tRme+OTiGl5kxfe3m/FwV/nhpENl0xRivznNwEibz8RkMVMmqKL6qtz6AGkPsG9yCaVXLvNqqhQCq57Vfa19VDYhWUinaElslx24k2NKBUL5p7IPyDZ8xOcdrke7KA6MmWknGh/VFzAUPfYkbtnzXvEcNmPFuz2qTgD4801n4+MG/aUYjZmKboHUdG3WJzq1cnqtjAu3cL6wBaP22Br/r9XpjHVuoHomPFaMSz5cqHrPq/Zf9Y9Ms7opJaOi2H4rr/wStvZheCe2imE+q7/aL+FHwZ/mMRY8eQFa1kMdRvWSpxdUxoTntAWcwWMCOatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67YK4Kif5Zy222AW8kKa2zZ4ztVayn8zElu9tytler4=;
 b=BSPPpyl9oFca0qv5T4nWt1jo9MtLNIAU8Y48lwQ9EUfthFtQiQ+WpW6Kxq2J83LiNTRtw1dnlHj3SduwaBFOO+Gnkv2OyE2ZNSy79mPkus1CuvEsoRLitcewuy39/Y4a6XSqE5+ZuB+nSHjLwxWUdfxnoOTXWdFTulbRqxxGaKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 19:58:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 19:58:01 +0000
Message-ID: <7506ba1f-27c3-3868-3c42-64b3094a84ee@amd.com>
Date: Thu, 18 Jul 2024 15:57:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-4-Philip.Yang@amd.com>
 <478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b300d9-51d1-48e1-14f0-08dca763edb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnpnclpCcW40WUxubTZDbWFUYTNoNkZXa0hDU0xvSndFT3AxbFovckVSb3Fu?=
 =?utf-8?B?SjJrRlpvRm1uSjBiOHNSNE5GeERtaHA5b0d0emt3RmhtNWw1UFFnekc2dThh?=
 =?utf-8?B?S3lOUkw0WE91bytmcXVxRXNudDlGS2NVMnMxNDJldHpkTk9wUGV5ZjlhOHQx?=
 =?utf-8?B?czZhdWFlVlNRdGdNdnZFc1g3bkFQWVBqT2ZMUmhYNjUrazUrMGFyWnM4Zmh1?=
 =?utf-8?B?ZnZwTGI3Z1h4b01EUHVCSVdJRlkwaEhiYzB4b2NqT0ZqQWFqNnRSTlNqUHdi?=
 =?utf-8?B?c29EQzFWekIvRDkyYjRtdmduZ0VSMTJ4N1RaTWJZOHc5NWtmYXVreDdrcFVN?=
 =?utf-8?B?c0Q0YzBmYVpwcjZtUVRwVk5uM2pNeGdsM2sxWld5aUZJQm1HYmREMTJEdnRw?=
 =?utf-8?B?K01JdjFWYW5HVkowT2tpR0pzVDNPSmFCaWZOb2UwQmNFYUtZcFlsaVJITEk2?=
 =?utf-8?B?bll2dVQySkdQQ2xpamdNbDllZll1OHlXa011UGtiYktXeDY2a0lBYWR1WDJJ?=
 =?utf-8?B?eVhralhtWEtYVnAvQ3NWd2tMeFY1Z3Q5aGFEeGZHRlhMK3pORklqbmRLd0ZP?=
 =?utf-8?B?TFdUV3JHdytreXMrNWpmUkhJVUlmenNsanhpdlZGYSttYmd5MVhlbDVwQTBy?=
 =?utf-8?B?UCtLdFZybFlLajFOek5jR0huVUlKb2VMaXlTSDFsRHdyZFdPMDBVc0FFZGFN?=
 =?utf-8?B?VVB2SU5IZ1hESWFwVkMwVUFCWjdueVRJaVRpelkwYVlTUW00dzZyVkh3bzRa?=
 =?utf-8?B?UGRSdW1tc2tlVnE5cVJxZmN1NlBnSzR3Y1U5OEdVSlpOUDdQSlMvWURLK2Jm?=
 =?utf-8?B?cW8wT0I5V3hJNHpmVkwxcU1yK0lOSm0rbDJwTWN1djNyWmhmT01SdEUzako1?=
 =?utf-8?B?VGV1VXgwbEJDOVZYeXJmOHhRZGF5NmZIN0x0SHJlb1NZWjZUOXRrNFpaVVBQ?=
 =?utf-8?B?OGU0Wk5OUEtyTmkrT09CalY1L0pIOXFvUTcwQTRxdlVEcVIwSUFYbkdyclNp?=
 =?utf-8?B?NTMyNEFRWTQ4eWpTTStQc1VWQUpERnZMV1VDREdOeHp5S2NucjdWWk1Lbytn?=
 =?utf-8?B?NjYwVGZWd3BqL3J1cWsyYnp4Y1lOcFU0dTBMYzZZSmVPb2NyWmVBYjA0VnJR?=
 =?utf-8?B?Q1dDNXIySGt6a1RnaldxWTNHSnZYd3liUDlVSVZ5emwvNTRjcHMwVTlpYlND?=
 =?utf-8?B?UGdzOVdaYUNNK2R1SnRYWmdHUGZHSUdxV21NemhtOHRjdVd3RFU4MUdDWFc5?=
 =?utf-8?B?bnp4ZTVOcVFhbEFBZW9zYVZzYURFR2RCejRPTWwwZmU5WDZWNDZ1aXFtSzJ0?=
 =?utf-8?B?aEZPYmpiVmVWdXBEaHJSRWMzMFJhUG9tN2MvbTkzeWRtUGFqNTdpRVdJL0w2?=
 =?utf-8?B?Mk5IYWFEa0VCcUFzUmZTeHYzbkFIL1ZZK0dEdlZhTzRPRXczWkRmQnZhKzhX?=
 =?utf-8?B?K28wODlOUEgwbUNDalJjZmdqMHphNTB5a0k4VU8wY0p3UGw0YmY1SkNEYVZ3?=
 =?utf-8?B?N214VlY2aU5JTGJIdzY3dHJ0OGxTbjFzbzFMc3d0WCtvNnJxQ2dpSVVXZVdD?=
 =?utf-8?B?cDZzQyt6UFdWZzhTSFZhQlJsRGdOdER0bVIzRURyMWU2ZzM1aXAvanpDZTVt?=
 =?utf-8?B?Q1B1UzRERk45U25RTzc4SVk1WFpMaE82WHl6SjdDSU9XK1V0MG1YeCtYeXNE?=
 =?utf-8?B?V2Z1UTcvZWVKWlNQeW05Q1YzU1RZQzhKb3p5US9MT0w1RGNkejd4SlNxRHFo?=
 =?utf-8?B?NXJrOTlxV1poVVRZcHhQOXRnc1hRVHJUdUNDYlNhS0xWT0puUEVoc1lsL3gv?=
 =?utf-8?B?QjFFSCtWZVlEMHhuYmg0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cSthU0p1YjJLMHZwdTRqcllOZlVqTThYdXprbmNmVWRVamo1dGFia1VuTjNM?=
 =?utf-8?B?bWMwRmtPR2tWYk9pTTFGMTBxV1doUzJ4R0IyYkl4Q3dWSVZzdW5DejljemV6?=
 =?utf-8?B?OGNzOGp2VUYyYjM2SmdFWHNDUW9BYVBVa1hjdXBDOWdnL3JqbVJsV3lkZlVU?=
 =?utf-8?B?N3FZOVNMRzJTWkhRNzJrOWVORzN2WmNhSXNMTG9qWk56UEQ1Uythd0FmS3BM?=
 =?utf-8?B?T2w4U0VSeEhJL2JHbzZJN0VQOHRBZnIwaFJSMGpkaDREdnI3SUZKbjd5K09m?=
 =?utf-8?B?U1dYNHBGV1hCTExRYUJQSjFZb0x0ZGdKWDNYR0ZXT3BZL2RZTTlUNTNWMDVz?=
 =?utf-8?B?Q3FiSm9jM2Q3djZnZ1d2OGJBSVg5Mno5dXdXdW9kQVZ3VlJDeWJGRW1WSzJ3?=
 =?utf-8?B?R3pMMVBVMEVJaG1xMm40NkZvQUZ1cXdMN29zMzBmYmhMc3JPamJHalJtSlM3?=
 =?utf-8?B?YTR5eUttdkx3UWhESTFnK1dSWGdYUzdjclVqREhyVURoNjBvTUg5OWZBNlh1?=
 =?utf-8?B?akNMcDZsV1gzRnUwTmhWd2U5RFI5UndsbjljaGt2MTYxQThnQXAzVTlPaE1t?=
 =?utf-8?B?cUZrZ25rcW5ndytheWswbGFVeGs1OWcwMkJUMGVmNWpaaEJubkRZR0Z3NW1J?=
 =?utf-8?B?Uk9CVkZ6Z1pabURHZWx0NWgrRmV1VTJxZlp3UFVoOFVFNVBiNnN5ODJSZlI4?=
 =?utf-8?B?ZUorSkhNaTdBcVZpVm9xSEo2Nng0NEJ1MVVwUkcrS3k2Umd6OTJoZEZGSkM0?=
 =?utf-8?B?OHYzM25tNnAxcGU3M05DeW5ENWZxUFdCdEttdlN5K1plZ3lIc295REFINko4?=
 =?utf-8?B?OUo3VDRVU2Vvb2l6YTh6OWZ6MlFFOWxRUlZncllkZk5MdUZMUmRqUlZ2M2tq?=
 =?utf-8?B?M0ZiZzVDaXhhU05LdWw5TFZEM29qcFFlS29xU2VzYmt6WTQveVRwdllveDJN?=
 =?utf-8?B?eUtjR3NQWkZuc2Qzc2xVaWw1Y2hFL1QrK0ZYQUxXck5IVDFDdEZRbnF5cVB6?=
 =?utf-8?B?cWNmSmFLdDRsYXZ6ajAwSElLYVJaaGNqQVc0UDh0d3gxRU83YUN2OGoxNmlL?=
 =?utf-8?B?RmZzNmpQTC9obXFVellTeE13SFpoY2t6cHF5Y0Y2djVacy9oMXRjUzNZQWVl?=
 =?utf-8?B?ODRESXhlUytPakppZ2dWaXBoTUtrVHJPakxRcmVOS3FGcGFqUnFMMmdSWmtT?=
 =?utf-8?B?b2NVU0RVZElBUC9kcjVTWUFZUHlPQUFySHVsMVNEbEFPUEM0T2hGN1hUWUow?=
 =?utf-8?B?K29RNnI2cGZCcGdFREpFRnkycnFLOHZyOVM3YzBTUVNuc1VvMVdsZG5Ucnhr?=
 =?utf-8?B?SXNDYUlEZ1dPdXZjb3YzeGhaVGpVNVVnamVrb2IzVklDbHpVQ25GK0VvUXpD?=
 =?utf-8?B?bG1GYllINlJUcjdsR280cUhsRlJpUVAwSVhOYTZaQlZlY3dLb1hDZnNybkRX?=
 =?utf-8?B?c2R5ZlArb0piOVF6M2VzS3JuNW5xaERlcFFGWHE1SjFTZUVQVWFZNEpuUUZ3?=
 =?utf-8?B?ZEh0cW50RkNqZ2FTNXFDYUhBcXUwZHIwRmNWQWE4NDRSWkNjUVluYlk2UFhs?=
 =?utf-8?B?UTk0dXBqcjB4bHlSenJjVE5oaDNURXZzaEcwbjZ3WmZ4SlRGb2Nsd0VCYm9w?=
 =?utf-8?B?K3NiMmpDaEcyaERQVThwSTdrSWlEcDloZlgwYVVqSWFjb29yaHZBRXZmNjIw?=
 =?utf-8?B?dnFvb2Fnc0x1Nk1SVS92dFRlY0g3Rm1ZNTlGZ0JhMktQbTErSnpNcDhkaW43?=
 =?utf-8?B?cGJRNndKZGNKM0lTUzR0QVAvT2FES3RSdGpOcUUrMkVzcHloZnZxbk8xQ1h1?=
 =?utf-8?B?eTMveFQ0bmNsODVWajQwNVZVODlUU3JOVFlOTDdidUtwMmVVeWJsd2NYRmlS?=
 =?utf-8?B?bHI2cGJ0b0ZXemNndGhmWEREN0dOQVlEdGRiRzlrd2lCWDNDRlVFem5QQ1Ba?=
 =?utf-8?B?N3JPYXIwc2dRQjlNbW9zV3pORXFNd2YzdWkwd1hGYTZIRWg1MDI1SjEwTFBT?=
 =?utf-8?B?TVltVEVGN21wZUtPL1FYeEliOGQ5bnhzTTBKdGUvdks5UmdTanVqeGdYZVZs?=
 =?utf-8?B?Y3hNS1h6a2NQTGVpZ2F2bTlnYnY3UGtOTnVyK1I2SUNCQmljZTNpYldLVFpy?=
 =?utf-8?Q?v7q8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b300d9-51d1-48e1-14f0-08dca763edb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 19:58:01.2808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUsDBouT2BNogO3mKXx2sW60kgAUJP6wO48tnnjrbYc96PG+lWkz5YHyQ0RSxFaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-07-17 16:16, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com">Sorry, I
      see that this patch still doesn't propagate errors returned from
      kfd_queue_releasre_buffers correctly. And the later patches in the
      series don't seem to fix it either. See inline.
      <br>
    </blockquote>
    kfd_queue_release_buffers return value is handled in queue destroy
    path, to return -ERESTARTSYS if fail to hold vm lock to release
    buffers because signal is received. See inline.<br>
    <blockquote type="cite" cite="mid:478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com">
      <br>
      On 2024-07-15 08:34, Philip Yang wrote:
      <br>
      <blockquote type="cite">Add helper function
        kfd_queue_acquire_buffers to get queue wptr_bo
        <br>
        reference from queue write_ptr if it is mapped to the KFD node
        with
        <br>
        expected size.
        <br>
        <br>
        Move wptr_bo to structure queue_properties from struct queue as
        queue is
        <br>
        allocated after queue buffers are validated, then we can remove
        wptr_bo
        <br>
        parameter from pqm_create_queue.
        <br>
        <br>
        Because amdgpu_bo_unref clear the pointer, queue_properties
        wptr_bo is
        <br>
        used to acquire and release wptr_bo for validation, add
        wptr_bo_gart to
        <br>
        queue_propertes, to hold wptr_bo reference for GART mapping and
        <br>
        umapping.
        <br>
        <br>
        Move MES wptr_bo GART mapping to init_user_queue, the same
        location with
        <br>
        queue ctx_bo GART mapping.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; |&nbsp; 5 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 56
        +++---------------
        <br>
        &nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c |&nbsp; 6 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 +++--
        <br>
        &nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; | 45
        +++++++++++----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 57
        +++++++++++++++++++
        <br>
        &nbsp; 7 files changed, 116 insertions(+), 69 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        index 6e591280774b..4ed49265c764 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        @@ -322,7 +322,7 @@ int
        amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **kptr, uint64_t *size);
        <br>
        &nbsp; void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
        kgd_mem *mem);
        <br>
        &nbsp; -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
        <br>
        +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo,
        struct amdgpu_bo **bo_gart);
        <br>
        &nbsp; &nbsp; int amdgpu_amdkfd_gpuvm_restore_process_bos(void
        *process_info,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence __rcu **ef);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 199e387d35f4..0ab37e7aec26 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -2226,11 +2226,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and
        increment reference count
        <br>
        &nbsp;&nbsp; * @bo: Buffer object to be mapped
        <br>
        + * @bo_gart: Return bo reference
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Before return, bo reference count is incremented. To
        release the reference and unpin/
        <br>
        &nbsp;&nbsp; * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
        <br>
        &nbsp;&nbsp; */
        <br>
        -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
        <br>
        +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo,
        struct amdgpu_bo **bo_gart)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        &nbsp; @@ -2257,7 +2258,7 @@ int
        amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; bo = amdgpu_bo_ref(bo);
        <br>
        +&nbsp;&nbsp;&nbsp; *bo_gart = amdgpu_bo_ref(bo);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 823f245dc7d0..202f24ee4bd7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -247,8 +247,8 @@ static int
        set_queue_properties_from_user(struct queue_properties
        *q_properties,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;priority = args-&gt;queue_priority;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;queue_address =
        args-&gt;ring_base_address;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;queue_size = args-&gt;ring_size;
        <br>
        -&nbsp;&nbsp;&nbsp; q_properties-&gt;read_ptr = (uint32_t *)
        args-&gt;read_pointer_address;
        <br>
        -&nbsp;&nbsp;&nbsp; q_properties-&gt;write_ptr = (uint32_t *)
        args-&gt;write_pointer_address;
        <br>
        +&nbsp;&nbsp;&nbsp; q_properties-&gt;read_ptr = (void __user
        *)args-&gt;read_pointer_address;
        <br>
        +&nbsp;&nbsp;&nbsp; q_properties-&gt;write_ptr = (void __user
        *)args-&gt;write_pointer_address;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;eop_ring_buffer_address =
        args-&gt;eop_buffer_address;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;eop_ring_buffer_size =
        args-&gt;eop_buffer_size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_properties-&gt;ctx_save_restore_area_address =
        <br>
        @@ -306,7 +306,6 @@ static int kfd_ioctl_create_queue(struct
        file *filep, struct kfd_process *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties q_properties;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t doorbell_offset_in_process = 0;
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo = NULL;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;q_properties, 0, sizeof(struct
        queue_properties));
        <br>
        &nbsp; @@ -342,53 +341,17 @@ static int kfd_ioctl_create_queue(struct
        file *filep, struct kfd_process *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; /* Starting with GFX11, wptr BOs must be mapped to GART
        for MES to determine work
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; * on unmapped queues for usermode queue oversubscription
        (no aggregated doorbell)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;shared_resources.enable_mes &amp;&amp;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((dev-&gt;adev-&gt;mes.sched_version &amp;
        AMDGPU_MES_API_VERSION_MASK)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; AMDGPU_MES_API_VERSION_SHIFT) &gt;= 2) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *wptr_mapping;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *wptr_vm;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_vm = drm_priv_to_vm(pdd-&gt;drm_priv);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = amdgpu_bo_reserve(wptr_vm-&gt;root.bo, false);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_mapping = amdgpu_vm_bo_lookup_mapping(
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_vm, args-&gt;write_pointer_address
        &gt;&gt; PAGE_SHIFT);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(wptr_vm-&gt;root.bo);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!wptr_mapping) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to lookup wptr bo\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EINVAL;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_bo = wptr_mapping-&gt;bo_va-&gt;base.bo;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr_bo-&gt;tbo.base.size &gt; PAGE_SIZE) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Requested GART mapping for wptr bo larger
        than one page\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EINVAL;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;adev !=
        amdgpu_ttm_adev(wptr_bo-&gt;tbo.bdev)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Queue memory allocated to wrong device\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EINVAL;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to map wptr bo to GART\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; err = kfd_queue_acquire_buffers(pdd, &amp;q_properties);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to acquire user queue buffers\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_acquire_queue_buf;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Creating queue for PASID 0x%x on gpu 0x%x\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;id);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep,
        &amp;q_properties, &amp;queue_id, wptr_bo,
        <br>
        +&nbsp;&nbsp;&nbsp; err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep,
        &amp;q_properties, &amp;queue_id,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL,
        &amp;doorbell_offset_in_process);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err != 0)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
        <br>
        @@ -422,9 +385,8 @@ static int kfd_ioctl_create_queue(struct
        file *filep, struct kfd_process *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; &nbsp; err_create_queue:
        <br>
        -&nbsp;&nbsp;&nbsp; if (wptr_bo)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, (void
        **)&amp;wptr_bo);
        <br>
        -err_wptr_map_gart:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_queue_release_buffers(pdd, &amp;q_properties);
        <br>
      </blockquote>
      <br>
      You're ignoring the return value here. In this patch, the function
      always returns 0, but in later patches it can return -ERESTARTSYS
      and you never fix up the error handling here. This patch should
      lay the groundwork for proper error handling.
      <br>
    </blockquote>
    This is error handling path after acquiring queue buffers, but fail
    to alloc queue, or fail GART mapping queue wptr or F/W return
    failure to create queue,&nbsp; <br>
    <blockquote type="cite" cite="mid:478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com">
      <br>
      <br>
      <blockquote type="cite">+err_acquire_queue_buf:
        <br>
        &nbsp; err_bind_process:
        <br>
        &nbsp; err_pdd:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        index 420444eb8e98..fdc76c24b2e7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        @@ -208,10 +208,8 @@ static int add_queue_mes(struct
        device_queue_manager *dqm, struct queue *q,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.mqd_addr = q-&gt;gart_mqd_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =
        (uint64_t)q-&gt;properties.write_ptr;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (q-&gt;wptr_bo) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr_off = (uint64_t)q-&gt;properties.write_ptr
        &amp; (PAGE_SIZE - 1);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_mc_addr =
        amdgpu_bo_gpu_offset(q-&gt;wptr_bo) + wptr_addr_off;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; wptr_addr_off = (uint64_t)q-&gt;properties.write_ptr &amp;
        (PAGE_SIZE - 1);
        <br>
        +&nbsp;&nbsp;&nbsp; queue_input.wptr_mc_addr =
        amdgpu_bo_gpu_offset(q-&gt;properties.wptr_bo) + wptr_addr_off;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.is_kfd_process = 1;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.is_aql_queue = (q-&gt;properties.format ==
        KFD_QUEUE_FORMAT_AQL);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 2b3ec92981e8..c98ff548313c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -494,8 +494,8 @@ struct queue_properties {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp; queue_size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t priority;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t queue_percent;
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t *read_ptr;
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t *write_ptr;
        <br>
        +&nbsp;&nbsp;&nbsp; void __user *read_ptr;
        <br>
        +&nbsp;&nbsp;&nbsp; void __user *write_ptr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *doorbell_ptr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t doorbell_off;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_interop;
        <br>
        @@ -522,6 +522,9 @@ struct queue_properties {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tba_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tma_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t exception_status;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_gart;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define QUEUE_IS_ACTIVE(q) ((q).queue_size &gt; 0
        &amp;&amp;&nbsp;&nbsp;&nbsp; \
        <br>
        @@ -603,8 +606,6 @@ struct queue {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gang_ctx_gpu_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; enum KFD_MQD_TYPE {
        <br>
        @@ -1284,6 +1285,10 @@ int init_queue(struct queue **q, const
        struct queue_properties *properties);
        <br>
        &nbsp; void uninit_queue(struct queue *q);
        <br>
        &nbsp; void print_queue_properties(struct queue_properties *q);
        <br>
        &nbsp; void print_queue(struct queue *q);
        <br>
        +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user
        *addr, struct amdgpu_bo **pbo,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 expected_size);
        <br>
        +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd,
        struct queue_properties *properties);
        <br>
        +int kfd_queue_release_buffers(struct kfd_process_device *pdd,
        struct queue_properties *properties);
        <br>
        &nbsp; &nbsp; struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE
        type,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev);
        <br>
        @@ -1320,7 +1325,6 @@ int pqm_create_queue(struct
        process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *properties,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *qid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_criu_queue_priv_data *q_data,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_mqd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_ctl_stack,
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        index 36f0460cbffe..8552400d6d47 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        @@ -205,18 +205,21 @@ static void
        pqm_clean_queue_resource(struct process_queue_manager *pqm,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;shared_resources.enable_mes) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
        &amp;pqn-&gt;q-&gt;gang_ctx_bo);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q-&gt;wptr_bo)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, (void
        **)&amp;pqn-&gt;q-&gt;wptr_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, (void
        **)&amp;pqn-&gt;q-&gt;properties.wptr_bo_gart);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void pqm_uninit(struct process_queue_manager *pqm)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct process_queue_node *pqn, *next;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(pqn, next, &amp;pqm-&gt;queues,
        process_queue_list) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =
        kfd_get_process_device_data(pqn-&gt;q-&gt;device,
        pqm-&gt;process);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_queue_release_buffers(pdd,
        &amp;pqn-&gt;q-&gt;properties);
        <br>
      </blockquote>
      You're ignoring the return value here. In this patch, the function
      always returns 0, but in later patches it can return -ERESTARTSYS
      and you never fix up the error handling here. This patch should
      lay the groundwork for proper error handling.
      <br>
    </blockquote>
    This is called from kfd_process_wq_release kernel worker, to cleanup
    outstanding user queues after process exit, it is impossible to be
    interrupted by user signal, I think it is safe to ignore the return
    value here.<br>
    <blockquote type="cite" cite="mid:478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        pqm_clean_queue_resource(pqm, pqn);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(pqn-&gt;q);
        <br>
        @@ -231,8 +234,7 @@ void pqm_uninit(struct process_queue_manager
        *pqm)
        <br>
        &nbsp; static int init_user_queue(struct process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev, struct queue **q,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *q_properties,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f, struct amdgpu_bo *wptr_bo,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int qid)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f, unsigned int qid)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;
        <br>
        &nbsp; @@ -263,12 +265,32 @@ static int init_user_queue(struct
        process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((*q)-&gt;gang_ctx_cpu_ptr, 0,
        AMDGPU_MES_GANG_CTX_SIZE);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*q)-&gt;wptr_bo = wptr_bo;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Starting with GFX11, wptr BOs must be mapped to GART
        for MES to determine work
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on unmapped queues for usermode queue
        oversubscription (no aggregated doorbell)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((dev-&gt;adev-&gt;mes.sched_version &amp;
        AMDGPU_MES_API_VERSION_MASK)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; AMDGPU_MES_API_VERSION_SHIFT) &gt;= 2) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;adev !=
        amdgpu_ttm_adev(q_properties-&gt;wptr_bo-&gt;tbo.bdev)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Queue memory allocated to wrong
        device\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_gang_ctx_bo;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =
        amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties-&gt;wptr_bo,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;(*q)-&gt;properties.wptr_bo_gart);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to map wptr bo to GART\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_gang_ctx_bo;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;PQM After init queue&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; +free_gang_ctx_bo:
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
        (*q)-&gt;gang_ctx_bo);
        <br>
        &nbsp; cleanup:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(*q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *q = NULL;
        <br>
        @@ -280,7 +302,6 @@ int pqm_create_queue(struct
        process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *properties,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *qid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_criu_queue_priv_data *q_data,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_mqd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_ctl_stack,
        <br>
        @@ -351,7 +372,7 @@ int pqm_create_queue(struct
        process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * allocate_sdma_queue() in create_queue() has the
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corresponding check logic.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q, properties,
        f, wptr_bo, *qid);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q, properties,
        f, *qid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval != 0)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q = q;
        <br>
        @@ -372,7 +393,7 @@ int pqm_create_queue(struct
        process_queue_manager *pqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q,
        properties, f, wptr_bo, *qid);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q, properties,
        f, *qid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval != 0)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q = q;
        <br>
        @@ -490,6 +511,10 @@ int pqm_destroy_queue(struct
        process_queue_manager *pqm, unsigned int qid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = kfd_queue_release_buffers(pdd,
        &amp;pqn-&gt;q-&gt;properties);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_destroy_queue;
        <br>
      </blockquote>
    </blockquote>
    <p>if destroy queue wait for vm lock is interrupted return by a
      signal, here return -ERESTARTSYS, then user process could retry or
      exit.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com">
      <blockquote type="cite">+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm = pqn-&gt;q-&gt;device-&gt;dqm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm-&gt;ops.destroy_queue(dqm,
        &amp;pdd-&gt;qpd, pqn-&gt;q);
        <br>
        @@ -971,7 +996,7 @@ int kfd_criu_restore_queue(struct
        kfd_process *p,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_queue_properties(&amp;qp);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; ret = pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL,
        &amp;qp, &amp;queue_id, NULL, q_data, mqd, ctl_stack,
        <br>
        +&nbsp;&nbsp;&nbsp; ret = pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL,
        &amp;qp, &amp;queue_id, q_data, mqd, ctl_stack,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to create new queue err:%d\n&quot;, ret);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
        <br>
        index 0f6992b1895c..b4529ec298a9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
        <br>
        @@ -82,3 +82,60 @@ void uninit_queue(struct queue *q)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);
        <br>
        &nbsp; }
        <br>
        +
        <br>
        +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user
        *addr, struct amdgpu_bo **pbo,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 expected_size)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *mapping;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 user_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 size;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; user_addr = (u64)addr &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
        <br>
        +&nbsp;&nbsp;&nbsp; size = expected_size &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!mapping)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_err;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (user_addr != mapping-&gt;start || user_addr + size - 1
        != mapping-&gt;last) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;expected size 0x%llx not equal to mapping
        addr 0x%llx size 0x%llx\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; expected_size, mapping-&gt;start &lt;&lt;
        AMDGPU_GPU_PAGE_SHIFT,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mapping-&gt;last - mapping-&gt;start + 1) &lt;&lt;
        AMDGPU_GPU_PAGE_SHIFT);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_err;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; *pbo = amdgpu_bo_ref(mapping-&gt;bo_va-&gt;base.bo);
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +out_err:
        <br>
        +&nbsp;&nbsp;&nbsp; *pbo = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +}
        <br>
        +
        <br>
        +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd,
        struct queue_properties *properties)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
        <br>
        +&nbsp;&nbsp;&nbsp; int err;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; vm = drm_priv_to_vm(pdd-&gt;drm_priv);
        <br>
        +&nbsp;&nbsp;&nbsp; err = amdgpu_bo_reserve(vm-&gt;root.bo, false);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; err = kfd_queue_buffer_get(vm, properties-&gt;write_ptr,
        &amp;properties-&gt;wptr_bo, PAGE_SIZE);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unreserve;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +out_unreserve:
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
        <br>
        +&nbsp;&nbsp;&nbsp; return err;
        <br>
        +}
        <br>
        +
        <br>
        +int kfd_queue_release_buffers(struct kfd_process_device *pdd,
        struct queue_properties *properties)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;properties-&gt;wptr_bo);
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
