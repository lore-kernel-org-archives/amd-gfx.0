Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF699CD484D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 14:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE5610E7DB;
	Wed,  4 Sep 2024 14:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQjFZBpe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B62F10E7DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 14:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=razNf+Gnzi4x7EsDt0vbj6fGupRa7YTeJk0WJcJbZF7xynE6qCfnmC+H0CaXu1Ns5EeRJ02TTp3tsQiToNBoJBphTr1gtu8/sKIV6fIw9+Mq0nqxLpvcqvVjgwF1oREMz4P0gZjQVsFXYS6P/mdeb7Wf5/NzJIVtXcskMBueIPeDrU+Jvr6B+0gF3GoJdZaRx7z0ZykiVJWTcS24njlv2eFIacBWV9ijdBG3STosbwW5SBOWCYzbTukGDROS2G0Gepl9YT4ZeETpbcJijYF8CtU4Yh9D813Np9w39bXH6jm6MoNB4oyAWCsIjcaND9nCvps1PU8xV7lpvc5DllcZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5uUQ7OdLyvun+2AkYX6eoQF4a6DBLTcX4HJ9+TC47w=;
 b=M8+ZN74/xjaAm7JNAe3fg6BdSG8OZQS0iqpPyYDAhfRSfaPpD30vAySbIQzsd+HF9KERBituXv6Xlysj9Bg4aw6d7DjE8+r0a+kXOADJpb0ToO7GeG7y3sLvWZUuCRSsDpDDJ0ROeGZv4ZxdO+ffIce62+EHc+C5nFkbBek2HflJaWr+7L3WN/c4/5ZUkTecP6Gyk2fb/BFlEq3V0bPFoFBPYnA/MgGpY5HjFs8nxUMyn7OMt92dulv3b9dlLHGdn91ZOX0+wFjS7zuNUJ+fFwbZCmsQDktFFTVXKIRR4Ma8Nn21X1vilTaZ+xaW1Py7FgELl6E87h/wWqCDFIWX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5uUQ7OdLyvun+2AkYX6eoQF4a6DBLTcX4HJ9+TC47w=;
 b=iQjFZBpe+N36wOjMWfJ9nxtGTAYY/frYdxmSyPp73eED+31+GN7ORyCbOAyIwuaBukUdZUseIHUwJ6FhYOvcqlyg6bSsk6/Tp7NPhChHrCTqiidPQAv3Tas/nzRvmrtczg/dYGPGWaYw2tKuGnhESBSVSj5Fa7sJxPzoZv9vu0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 14:38:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:38:50 +0000
Message-ID: <1f702f8b-d454-d806-af9e-32c469280652@amd.com>
Date: Wed, 4 Sep 2024 10:38:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: fix a call trace when unload amdgpu driver
Content-Language: en-US
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com, felix.kuehling@amd.com,
 lijo.lazar@amd.com
References: <20240904080420.559277-1-Asher.Song@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240904080420.559277-1-Asher.Song@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aae4753-ad48-4643-9bff-08dcccef4a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UCtZN3lUd1kzNElrL1kvY1NmZ0lScVl4WmJ2c1hDaitQbm5SN3BSejdoSXNo?=
 =?utf-8?B?RHE5UFRHNkxsTWpxT0dhd3VEUjRtZ2F4eDB6bk5SOHo1Y3NuK3libzNFM1ZP?=
 =?utf-8?B?MXN6Sld3dDQ0K0NHOXlNV1dUbVRrazJoMFRRbVVWbFhJSjBLYlVGL1lxZktm?=
 =?utf-8?B?eklaT2NpY2IrYnpxc3RXNWlpbnN2TWRlb0szSnRHNWVqNzl1L1hmN2ZaVGhx?=
 =?utf-8?B?dGJabUNFMTEvYVFVclNleDlBWmlaajdDV0gySXN4RGRvRnVZSjJpaldPQ3dP?=
 =?utf-8?B?Sit6SmhsTjRvYy9NMGt2eXN3OWJxTG5JeEdiS3JpRTNIays3R0FkVDFPOUxx?=
 =?utf-8?B?a0p1bjJoUVUwd2pNYVFZRUQ1cktRS09nb2Y3QmM3eldXYUlTOXp1Szc2NzJo?=
 =?utf-8?B?S1RNQnQ5N3VYTFVYNi81ZGNENUI0cHlockkybnhlUmlnWDlKVHJaQlBhWVVS?=
 =?utf-8?B?YUhHV1d3VU9UN1AxQ05wRC9tblViblpJNGFheFd3ME9zcmF3VzlYTnJuaGlk?=
 =?utf-8?B?TzNaVlpIa0xlQll2MUlMSFFUQ1FPYW5OMnVwUUZxWklGZGxEUjFNa0JSSFFo?=
 =?utf-8?B?YXhpVXdhTmJKQjhjOFp3ZmNTc3ZLa1BFMHZXR1RvQWYvUE9EQnYwNUM0SnBw?=
 =?utf-8?B?TkNtbHRNSHBEOVBTN0gzKzZaR0JtWThGR244cjJXaGZDb0ZuZ3h5QnB1TEo0?=
 =?utf-8?B?dzA4Yyt0Q1lqQ0x0SjlsNy9ibDVmT2hWbU5XZUVMQU9kMVlyTGxKc3c1MHc3?=
 =?utf-8?B?bEZGSnhpLzBQKzBIZmhud0tOMStDZUpWNVJRaExBRDNtak9lbTBIV1F3T01i?=
 =?utf-8?B?ZDErekgrT1dmcmNPOHYvNjlVWjlnQ1g0dkprekNEVytuUDR6WXI4RTMra2R5?=
 =?utf-8?B?SG0yeFl3NEZpMWhubUI2VFd2WFR3bXJpc2doUDZ6aFEzdy9TV1NSQXQ5MkY5?=
 =?utf-8?B?cDkrY0tBN3RDSUVvV1RyNkxSKzFRWmRCb2djb2oyRnExdjFwcmpsdTZPcFFB?=
 =?utf-8?B?QmlsSFZjdFlaemp0K29UR25OMzNXRXhKZnpBeG9ScUJ3aVZpZnZNUVNkVTVQ?=
 =?utf-8?B?K3J4LzdSamtCVjErU005Yk9kMWpuMHIxMzBuQzdLdkVGeEYrMXZtdjI3eGlP?=
 =?utf-8?B?WjZlbXhIRVh4WVBZN202SmdHVVVhdzRrd2FENnpndVV3ZkNDeWc2L1Q5UWsz?=
 =?utf-8?B?eXp2cEpNYWhnOFE2RUo0Ti90MjRXV2U4R0RobW9TbDhabzVzWHA3VWdtQzJk?=
 =?utf-8?B?YkR6dFdNRHFGUGl1Vit2L0tCaXY4SkhPQURwWGRrNnlmcWxqVWhacVh0WDcv?=
 =?utf-8?B?Um53Y1pjYTNWc3I5Z0pMcnpXVmlLRlhtQ1VDUkI0NzkxTXVFcnlMZkJNTGk0?=
 =?utf-8?B?dEx1VzEzeUJZUDVaSzNrQngxYjF1bC9pNTJxeFJqRmo1VWJ0dFJBNTAwV2Jv?=
 =?utf-8?B?UHVHbVhOU2FPQ2RDcE8zSFg3eWduMk1qNnpPcnplTVFQbktPVENvV2NPYzRJ?=
 =?utf-8?B?b0N5Zm5jR0wza0xML0h5YUdtL2JPMnNGWEoyMEdPV3dmcm9GaVBTK0xqSEZC?=
 =?utf-8?B?KzN0UEtLbzhQUDAzWGdhSUJHYUYycEZiK2VoeDN5WkRlT0lJWjFsdklUbkxZ?=
 =?utf-8?B?ekpmLzNIQ1RkMTYxQjlvRi9PdG10cnRvRHdNQnorTHg4Z1ltVmd0eUVBK1FG?=
 =?utf-8?B?QXFKNGtSZEpSZG9HUklGYzVKSzJ6dlR1SEVNOWh5cjhZWVZvRXZ1QjZYTktC?=
 =?utf-8?B?cmdVQVFUZE40SE12QUFXb3M0bnh0RDQyYmtORjdORTRDbG5pU2R0UHFIT3Fq?=
 =?utf-8?B?dlFURzVpa3lRY3dCQmZzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BQZDMxSm5kYkhFTms0bzgydkJqc205bVdxVDBCWW5kd2l5N3VuZWRiVzND?=
 =?utf-8?B?SnNOTStGSTZvczFPUGxLdUFnMHpHZlFWd2RMQWJQVENHblJhajBoamhxTjBW?=
 =?utf-8?B?bFc1a3dqc1VBdTFyc1FneGltM2tzS2IvMVVXTm5MLzBaVk5VVEZQM0NseFU1?=
 =?utf-8?B?SjVoK0cxaWt1aE9BcWlNSmdKTGZzazhPeXBwOExnOExnalZoNmdUb29rS1ZR?=
 =?utf-8?B?b3FLVDJZYW5DQWh4MldWUkFGMFFnd2ZESlRsUnF6enlod0xDTG5xODNZNWRk?=
 =?utf-8?B?dHd3WC9pL2Z3bS95U2xSLzFJNjhSUzJ1K1NNVFRoRHhGb0paeUxoS0tRaHYr?=
 =?utf-8?B?dGc3b3JieUlmZUNkTjB1cFg5YW1PR2JuWWppVndWaFNzNWdTM1B2S1hJYi93?=
 =?utf-8?B?bmpySlBoMkNySXVGT25ONlFxK2RNY2ZqSVc4Q2wvVkVhWnlQcm81NUpVTUsr?=
 =?utf-8?B?KzNhb29ubmIwVEhBYnIzQldUSkpFa3BtVG5xVXYyZ3ZuT3VMT2VuOG45d0dv?=
 =?utf-8?B?V2pwM2swcWNUSkUwNzY4M0F4V3lDWGJUNlpqVzBkcEsvaUNLbnhkLzlyNGkw?=
 =?utf-8?B?M3czVkI0OU81bVpsVmNXeDg3aHRsbHE1c2ZKdTAxRmRtY25xUTN3aTFWbGNC?=
 =?utf-8?B?b3ZIR2ZPQzltVWRLNFlZVEl1MzJGQTl6N3lkZFRkS1ltMVhXWlUzMi9TNnZj?=
 =?utf-8?B?SXBEVEIvMGtyR25ncjkvV3pKZHVvbXFzRFlLa1BvaWJCN1JJbFM4TjVUdzFB?=
 =?utf-8?B?U1RSeVppekhFK1ZDMWZvT2c1TFg3L2xhWnp1L0pZcGZmZGdnS1N2VFM1L1pa?=
 =?utf-8?B?YmNJNDZqZW5DUzU0VVB0WGk2cFdaVUJsUytSZENEUWU0d3ZlRm9tQXVDSTQ2?=
 =?utf-8?B?QnIyOWtBVUFueGE4N1JyU2hqbVNtVHpLY3B4U1pDMWhSWHFpUTVlU1JEL3lH?=
 =?utf-8?B?MmlPMlNjdUIvRFhVSURVdHl2bTN5bHFrSytwTUlBSmJEM1NJdGYzbFhrMHJM?=
 =?utf-8?B?MzlweUN1Z25IM21STnFtTXJrZ0VzTTlpRy9NaGlHVEtnZ0M3bTVCbnJ1d2da?=
 =?utf-8?B?Z1RHR09Ja1lPWDVLcE9rZmRDbXhXaHljL2tWemU4VkMwcHI4Q21IZzF0UllK?=
 =?utf-8?B?dTU0N3VyTXdjY1hIWm82a0dKMzl0ZnZrczBLSHVwY05YMGJiUUwxeVdTZ0Zv?=
 =?utf-8?B?Wk80S2NKbUV5Y0MvZ2V4R1I3cDlITnRycDZMcFpXYzBKTDVFUVZIQW8xVHQ4?=
 =?utf-8?B?dzZhTTAyalN6bkx6dllWdFJqajNReUFEZ1p6c2pDL2NOcUQ1Qzg4WHlmYjFN?=
 =?utf-8?B?RURQRWhrcHFYT0RrU3AzbGExeDI1S2xwVCt1ekJQbGpRamZHYWNOTzhSemYv?=
 =?utf-8?B?RG95NWJuZndETzJNRXRpS0dFWXl5M2tnSnd1bnEwTm5wdnR4TUVzMDg3SThW?=
 =?utf-8?B?dkZzbzdwUUZZQnRLK2xvQmFLakxNRkFzY0xYMzRLRjEwQlE4TjZuU25Ba296?=
 =?utf-8?B?QzhtSk1BOVRNZE93NUtFMzI4ajJwM0VZeUt0S0k1RDBucmdObUZtaDBuU3Jt?=
 =?utf-8?B?M0w5WlBhV1Z4VEhOaGRMTXN3WmpJM2tLYlc1RmlVaUtaUzBxemxGUGY1eGVF?=
 =?utf-8?B?bjBNbkxyRXEwd2pEV2VpaWFVQ1RON044VlJqelVmMjNadGx0NDcxZkNRVTdk?=
 =?utf-8?B?SHdsS2h0dDBMUm5KT0dHUitYTFg3Z2x0TDRaYWNkQkQxNVpqYjFwZDNmWDBh?=
 =?utf-8?B?L3N3WVlqZ0U2OFBWVmd3QXNMcTg4L0NQbWxIOXdRVVpIa1pjNHJtdGxpdXJ1?=
 =?utf-8?B?blhMdjYwU1QyTGF1R1kvZWtRVUxoT0RXQXBoMk9MKzFmQ1lBV2xEck9vRVNL?=
 =?utf-8?B?SEdJZEpDejVXcnYxV1M1SjMydkozWllDNW1GbG5nZGJ3QllPa0hJbGRsQUpB?=
 =?utf-8?B?bFpNNkhjSW42YVYrYWtGWk1TcGJENVYwMktXMkU2TGNGUkZ3em00ZzRWZkFQ?=
 =?utf-8?B?YXVDbGpzZC9lTDdqbHkyQ1ZzeFFCa0RNVkRUR2VteDVOb3JlcytaSE9IV3Nn?=
 =?utf-8?B?Vlp0M0Izd2RLb1QrTlNEWkJtaUpkSE1nckdtWnVpUFJLT0Z3dUdnUk93Uy9s?=
 =?utf-8?Q?7P2ozUQBTjhydABKn7RIO77Wn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aae4753-ad48-4643-9bff-08dcccef4a54
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:38:49.9853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiW51yMID861fiYsdXFR358ZQvFyi2R1CgUG/ufcqCeBgtjCldx00dqABammnzsn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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
    <div class="moz-cite-prefix">On 2024-09-04 04:04, Asher Song wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240904080420.559277-1-Asher.Song@amd.com">
      <pre class="moz-quote-pre" wrap="">In some APUs, the bo type of GART page table is ttm_bo_type_sg.
Those type BOs is released by bo-&gt;delayed_delete which is added in ttm_device-&gt;wq, not released immediately.

To make sure all the ttm_resource is released before ttm_resource_manager is finilized, drain the workqueue in ttm_device.

v2: move drain_workqueue to amdgpu_ttm.c

Fixes:d99fbd9aab62 (&quot;drm/ttm: Always take the bo delayed cleanup path for imported bos&quot;)
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Asher Song <a class="moz-txt-link-rfc2396E" href="mailto:Asher.Song@amd.com">&lt;Asher.Song@amd.com&gt;</a></pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">Acked-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>

Most likely this will fix another bug caused by race condition b/w GPU mode 1 reset and delayed bo cleanup worker.

Thank you.
Philip
</pre>
    <blockquote type="cite" cite="mid:20240904080420.559277-1-Asher.Song@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5c938ff0bf48..cbac21df5c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2461,6 +2461,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		drm_dev_exit(idx);
 	}
 
+	drain_workqueue(adev-&gt;mman.bdev.wq);
 	amdgpu_direct_gma_fini(adev);
 	amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
</pre>
    </blockquote>
  </body>
</html>
