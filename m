Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B32C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 17:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4603910EB88;
	Fri,  7 Feb 2025 17:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0FwpoMEd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2013F10EB87
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 17:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhU6Y0pAd4B0Q9RxztcvC/KqJsGlHP9sTdSmAag269D5oozwF4BoAmDkQY48PdhpATcwLuz+tYH5dkxyuUaOPNxVBnQoSmNf9fb5lRfbvx60wYqgNrDy5ms2UZC5amgu6vfmZSGLPx4/U26rcwmtbjQZ3t1HPgFfwlD9Y31LAdfuAiE5L3qfUNquxK361P8a0fh6DuwpiUdqzLOVv0HICae/sHscH8NWh3cDLoh0SX0w8BKCmCLTBiAlN+ISZPjNvyURYnasoT3pRgoDLVzCCYXI5dKEKN9Sr2jhcqPlz3EZnenMFtsU37W07+pAMCEGYQpCquC9RT/TJdS9DivoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89lZE0nxc14e6g7G9XtIxcFPFSHQjIENK0Hnk21rXg0=;
 b=mBiIbV+XbkXLydOFe5m2cRYnVjEi3sdEyk5w6/KOe8ZUkpE190UwHqimJXDZWcmEQejhHqH2HgKjSY2UvubJjWHD98hFh5mLtBwUGbyMVn18daOACDTSuP06ngPaFvEaC/BeidAnt5LGNDH6y6AvDUEnJ2sL2RRo1+dyRii4AiLYglDupkZQRsDNDIWLcyXJSrAacKhlJh0jJHPwYtHVpXVAQQGLsVLqKhcfP/p+FRRfrOKuzS/aPjZ1PWlpFKRPTr5kb5ZP135xIbod7EN03SCzTPWA8zLjzJWkOAVo3447arPo5an667Vxi7eYB4PNc+vdvUHU6NOqLDxnCvQNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89lZE0nxc14e6g7G9XtIxcFPFSHQjIENK0Hnk21rXg0=;
 b=0FwpoMEdYRizpNtdqtOlGvQQCWmPQqXHgsJZkO1hpDi8NFhsr83rM6XOWtRFvaTzroaKa5akRw2rNUFUKHRsDKMdsO1v4nR5hUY0ZbG4lQvxY05FG0CYBf9ZFE7O3MBqRhEFqsvgLoOCWwvDFna0d1LSLYSCCahwpPyaMgVwasA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 17:34:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 17:34:08 +0000
Message-ID: <934e4a31-34bb-341c-fe4f-46277c2d4061@amd.com>
Date: Fri, 7 Feb 2025 12:34:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250206210721.200197-1-Harish.Kasiviswanathan@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250206210721.200197-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a27c23-908e-4cb8-95a8-08dd479da035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUJhRnZpNWwvV0RvOUFRWFY2R21WU01DR1Q2aUhDMDU2VGYwS1daaEFscXpJ?=
 =?utf-8?B?MWRvVURscW1YMzBKQnJsdlkwT2ZWcHExcTFnL2p1N2N3THBPN0o3Znl5QVFU?=
 =?utf-8?B?akJjbVRIa1gvY2plRW9WZmp4ckhLb1RYdThIWXAvRHNLS2szb20xVXpidHkx?=
 =?utf-8?B?WVUzQ0U1TE1QZ0IwcTN2bzVhWFdHaWxWSkZVbTY0UWtUTTA5U1hlNDdHZlFQ?=
 =?utf-8?B?R2lUMEJXMjVaUE8wemhLazZoVVN5TnFWeHFPc2YrQXpWVTVSUG5pK3ZpRUFU?=
 =?utf-8?B?ZzQyTXV1TUN6amg5MXlET3JGMnpIQXZGSHYwRlNiSm1NZThSZlVONzdoOWVv?=
 =?utf-8?B?cnhOMU9ZNGd5M0RIcmFPeXJUN2VkeHdseXJNYTlDM2NFRnJrQW1hNFpvT1ly?=
 =?utf-8?B?N29NaGhRSkl5UW1MTXprTHVld2Z2RzU0N2ZqL0NySGlTa1VwbHgzeUNNOUVn?=
 =?utf-8?B?QkdNRzcyRDVtdk5XdlJPaWtMaGQ2L3dSN0VmazFVVWlpNDZDKzJId1VhdCt3?=
 =?utf-8?B?V1VyWlJudUExbERLNUdLZndydXJ2aXIwd3hJaDg2R1ZFbWNGOENyMlYzSFZ0?=
 =?utf-8?B?d2tPTGwxdTFmUi9zZEtTUTBJS1NDcHdmaFRPZkZjOFQzU1k5NE9UazRNSEd4?=
 =?utf-8?B?YkpLVHRwd01TN3pnMUphdVRkcEk3YUV6b2lQb1JmRmFraVlhRTh1YjJuU2o0?=
 =?utf-8?B?ZjVEU1NjVm9PWXJMMy9xUnRsVnN0bnpZVEZqY1pZR3pBTUd3UmVaYVhveDcv?=
 =?utf-8?B?V2p5b2lYTERrSWE2d1pjeTVjWXFoaHVqSWtpQ1JKTjgwMWM5a2RGcmJVTFRL?=
 =?utf-8?B?YnRnMWhYM2RLOW9EWWNrQVNOSkMwMEovSmVJRndIVkxDQ0ZRcUI2a25oTE91?=
 =?utf-8?B?ck81bVZxdG9PYWFZZk9WS2lUVEw1cXh5VVRObStIUTVyUHF5aXpHZEpBNDZO?=
 =?utf-8?B?OHVDQm13dWdLOFlmNStNa2dDS3hvUmh6SGhPZzBUWHphYVVKUjZYY2s0VVpi?=
 =?utf-8?B?YzBuOTZNWWRFU3NIL3JUVWJOQzdidU5aUmhHa2tKaC9JcXBxLzBFbmxSZUdR?=
 =?utf-8?B?NFBtVlRlcllXRzA0dmxkWElaQm52U1FsUGIxSURNeGdQUUdZR1lrSElJOWRC?=
 =?utf-8?B?NWlsL3RSYmROcXlockNrQlhVME5Md3dWY0VxSjc2SzcyZUNlUENycmNhS29P?=
 =?utf-8?B?clJrcDA2V2EycmR5c2Z2b3FpeHd5bjl3cFZEczF0Q3NkbWw2SHhmZVhHV1hs?=
 =?utf-8?B?L2U2aVlYTjNjSVhkLzNUbytGM2RYaldxVjdXVTZ1VmJHN3doQm5mM3lJRm9Q?=
 =?utf-8?B?OHhmeDVTODZLMUxMZi82a3BrZnZaQ1VyRUxFWWRlSWFRUlZSb21NS1VLRjd1?=
 =?utf-8?B?VHFZUUxDQ2dBZWRPWHlhT2cvTmF5L3hGUWgrVXdtT2FFNlFnTllqemF2RTU2?=
 =?utf-8?B?QkM1TVFtU3VCaElFdGRZM2Q1OGltQ2JLSDlWYnRWM291dEwvdklmNjZSNm9B?=
 =?utf-8?B?b2RKY1FOTHBJdDFMdkwrMzh6QXI0NDVoaDBha3p2bGxwYm81NTFScjFTbDV0?=
 =?utf-8?B?TUprQmV3TFQ4bEt5N29iVjZRak10N3o0YVZrSXJ5aEM2aFVpZnhpYUNkcFJY?=
 =?utf-8?B?K3hkOUVMa1hBV05rYkFpMnpwYmRDQnl6VGdaWXFrSUgvYmlka2ZzOXBsS3Jt?=
 =?utf-8?B?SDA4K0VvOTlVUzU5QnV6bnBXdWYrUXpUc1c3ZHM0ZVVER2hJRWhsblRIbjZy?=
 =?utf-8?B?RW1WcGZBbnpreHdDQXZhOVVTRkNhaXA1cmp0STg2WnNvNDQ1TXpiM0dLMVI2?=
 =?utf-8?B?cy9ZUFlEVERpdkp6aTdvcGQ3UU9iQk5FU0I0VDNSWmlYNXVQaVg5L1U3SzNo?=
 =?utf-8?Q?K2pI8JjSSuQDQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFB4c3orM0RHMmgwOUFjdmF6ODhsamI5aEZONTZ1N2RpaVNxdFJvMnhyKzBr?=
 =?utf-8?B?aGpRV2ZJN2hFckc3T2NIbzh6SHlzRzl5T2Jla3ZOUmNhN0FrK2w0Q3pmc1NC?=
 =?utf-8?B?c1BoZUcrMWY2ZU1ZaEdmN1BLNUlCaDRlRFRxUmV5Y1NBcTB0b3FZVTZIU2Ji?=
 =?utf-8?B?bWVvNE40ZU8zZ2ViQjMrbjhXTk9GOHY4NHFhTHFhdHY2ZThyUyt1Uk5RWk8v?=
 =?utf-8?B?U0JHQ0drVXpwbVVROEJsVEdaS2VmSGNzVllqSHM5alJBTTQ1cE1MNzhVZ284?=
 =?utf-8?B?YVB6N2dUQ2ZxR0xCWjF4VTNPdG42WFNYaCswc1dKRjhENUxGYS9VbFRCWnJ2?=
 =?utf-8?B?dS9XYkw3b1krQWlqM1dpYTE0azNKZ0pWTWJjTW5Ydk5PTThJa2VrZ0d5d0Fu?=
 =?utf-8?B?SFVUYkFycnFwd1ZhWHpGbW40ejJKSE9EQzZKc1JjeURJeVZvMXJkSVlPMTlV?=
 =?utf-8?B?OVpweGFlR2s2VGdIbHZDOUhPUEFmQU82bnhGMkMvTEo1R1k5cmRDTytUSVM0?=
 =?utf-8?B?MFRUZnFIVkxEdnIyalhBVVAwYW95TEV3dDJRNitYcElHbm54dVI1M0dIK1ZB?=
 =?utf-8?B?VE9TK3o3VUE5S1EwV0JzbUpsekQ2dnNOWG1YbHpVV2E4SzFQTlAzcjhybmt1?=
 =?utf-8?B?aW4vb3Qxc3lpSlJuaFErQ2NMRUJ6azd4UDg2Q2UvOUdDeTROMHVya0taQklZ?=
 =?utf-8?B?c3ZaTm9mN0VRckg0UE1tVkEyM3pvWDZhNEdBaFZPbnQrMXhnTVl6eEprV1lO?=
 =?utf-8?B?MjVIY2VXa0l5ZUZPbWdtd0tLSW1GbmlsWFpmV0t5cTA1ZXBqK1Y3TGNDc011?=
 =?utf-8?B?SUM4Y09HWWpTbmhyZDVtb0h0Q3hiamwwNFpHa3hNNWtXLzBKc08xNGk0cXZ0?=
 =?utf-8?B?a1IvSkZxbUR3cWZ1bk5kbDR5Zm5GZlVxR3Mxb280bG9KcDQwSGtZWkpmUU9E?=
 =?utf-8?B?clZEYjh3Nko3VWtzL3p5YnZxTUFCZXpURVpHV3VOT0dvTm9jZGE5RmlvYWVL?=
 =?utf-8?B?Nnd1QmNCSFEwRDRQaVNRVVFTNWZUYUR1bkh1K1k3OUQvQWJYdURlcmtkcnRZ?=
 =?utf-8?B?dkt3dUdWY2FQUmU1Y1F4SjNBaG9qNFpLRmxpa2thdEF1ck16dHJ0SXJPN0RK?=
 =?utf-8?B?NDUrVmVNWUJ5d3hGeVdoTU5XdmF0OGw5cFh2Tm1iL0ZGQjZqZlJEdVptSFpq?=
 =?utf-8?B?YWRNQTlXR0MwK2JYS3FBSSt3OEJWNUo1V0l2Q1NOZG1MVnBObnVJanhDRkFJ?=
 =?utf-8?B?c3N0UUFZRXA1VDZqakhIU3BaTGQ1Y3VvNXlJaGU0eEJqRzlDdE5uRHRjMS9u?=
 =?utf-8?B?R2Ntc1cwNlIxVEEyak81cVR3Ung1ZUN1RjlJanFHcnkwTGVFcFJGS01RMlNz?=
 =?utf-8?B?d05KUzBaZTdoVVEyYTJRZFlkRE5VVkVFSXJJMjVIeWg4V2tpeTVLT0NROGlV?=
 =?utf-8?B?VWc2SHdlQk9nUWwyU3VsaVlLLzFoLzdkUDJtL0J5OEFsd1RQZGRmb1VYU1U2?=
 =?utf-8?B?UENLSkZ1eVU0RndLVWY0dXUyYU1jekI1ajlrRE1JaUtNekpHODYyTVhHOFNw?=
 =?utf-8?B?WnlzaXRKQkVnRGZvZmhrcHM4aVhtZDlyV1dwdjBXYk1HUG80SjlUd3pJSERK?=
 =?utf-8?B?RlR0dW1kcWtOd2t3UXphVmlMUEJSYk9WSFdzUE0vRUdXUG9PbFg5dWxKM2ZY?=
 =?utf-8?B?V0RVMFhTREk1bWJIQU1IYnNTTTdqdVd4U1pmUUY0RG1GaWY2RFNucVhaTzVQ?=
 =?utf-8?B?MklzZldyUVJtNnN6c1g5TmU4RExjcVRxaWV1MHphNjV0Y1RGZ3RYbWNaTU1V?=
 =?utf-8?B?SHh1TEE1K0hicTNFWUI2YzhJQnZJbEVQek9jRzd4OEVrRThvemhnMGZtZUZU?=
 =?utf-8?B?eWwyWXQ1WFZIT0cxZmRmVWpodGNKTGhCY3lvZ0Y2SmExZ3ltb09WS082ajNr?=
 =?utf-8?B?Ym1wbExwL01BbTlIZ1ljL01JYzZVM3VGWllrYXlzU20xRUd1cGxOd3YvRndk?=
 =?utf-8?B?VW1BMjl0d1RCcVdSVTNZV3l2eDJJR2E0RW1nM0p6YkpwRzRjalhCVHhWUkdV?=
 =?utf-8?B?V0F6eFNUc2p1Ylk4UzNDbm9udEloTktUb3UwQTZNRU9KQTdqc1QrNTcvcnBR?=
 =?utf-8?Q?Y2sU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a27c23-908e-4cb8-95a8-08dd479da035
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:34:08.1565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/32rzF6JDiNLDyOGBn2gr4P5ERvQEApjS1SZVH5gJYGizzsXD+FE4znmZbbKkcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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
    <div class="moz-cite-prefix">On 2025-02-06 16:07, Harish
      Kasiviswanathan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250206210721.200197-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
this to happen.

v2: Missed a few mmhub_v9_4. Added now.
v3: Calculate hub offset once since it doesn't change inside the loop
    Modified function names based on review comments.

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a></pre>
    </blockquote>
    <p>with one nitpick fixed, this patch is</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20250206210721.200197-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 31 ++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
 5 files changed, 163 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9689e2b5d4e5..1383acb5aece 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_7_init_snoop_override_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+	int j;</pre>
    </blockquote>
    <p>one level for loop, use variable i</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20250206210721.200197-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j &lt; 5; j++) { /* DAGB instances */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+		tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+		tmp |= (1 &lt;&lt; 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_7_init_system_aperture_regs(adev);
 	mmhub_v1_7_init_tlb_regs(adev);
 	mmhub_v1_7_init_cache_regs(adev);
+	mmhub_v1_7_init_snoop_override_regs(adev);
 
 	mmhub_v1_7_enable_system_domain(adev);
 	mmhub_v1_7_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..ce013a715b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp, inst_mask;
+	int i, j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	inst_mask = adev-&gt;aid_mask;
+	for_each_inst(i, inst_mask) {
+		for (j = 0; j &lt; 5; j++) { /* DAGB instances */
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+			tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+			tmp |= (1 &lt;&lt; 15);
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp, inst_mask;
@@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_8_init_system_aperture_regs(adev);
 	mmhub_v1_8_init_tlb_regs(adev);
 	mmhub_v1_8_init_cache_regs(adev);
+	mmhub_v1_8_init_snoop_override_regs(adev);
 
 	mmhub_v1_8_enable_system_domain(adev);
 	mmhub_v1_8_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff1b58e44689..fe0710b55c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -198,6 +198,36 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v9_4_init_snoop_override_regs(struct amdgpu_device *adev, int hubid)
+{
+	uint32_t tmp;
+	int i;
+	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+	uint32_t huboffset = hubid * MMHUB_INSTANCE_REGISTER_OFFSET;
+
+	for (i = 0; i &lt; 5 - (2 * hubid); i++) {
+		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			huboffset + i * distance);
+		tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			huboffset + i * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			huboffset + i * distance);
+		tmp |= (1 &lt;&lt; 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			huboffset + i * distance, tmp);
+	}
+
+}
+
 static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
 {
 	uint32_t tmp;
@@ -392,6 +422,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_init_cache_regs(adev, i);
 
+		mmhub_v9_4_init_snoop_override_regs(adev, i);
 		mmhub_v9_4_enable_system_domain(adev, i);
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_disable_identity_aperture(adev, i);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index c488d4a50cf4..b2252deabc17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -203,6 +203,10 @@
 #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
 #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
 #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
@@ -455,6 +459,10 @@
 #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
 #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
 #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
@@ -707,6 +715,10 @@
 #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
 #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
 #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
@@ -959,6 +971,10 @@
 #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
 #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
 #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
@@ -1211,6 +1227,10 @@
 #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
 #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
 #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
@@ -4793,6 +4813,10 @@
 #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
 #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
 #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
@@ -5045,6 +5069,10 @@
 #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
 #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
 #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
@@ -5297,6 +5325,10 @@
 #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
 #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
 #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 2969fbf282b7..5069d2fd467f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -1532,6 +1532,12 @@
 //DAGB0_WRCLI_DBUS_GO_PENDING
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB0_DAGB_DLY
 #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -3207,6 +3213,12 @@
 //DAGB1_WRCLI_DBUS_GO_PENDING
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB1_DAGB_DLY
 #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -4882,6 +4894,12 @@
 //DAGB2_WRCLI_DBUS_GO_PENDING
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB2_DAGB_DLY
 #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -6557,6 +6575,12 @@
 //DAGB3_WRCLI_DBUS_GO_PENDING
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB3_DAGB_DLY
 #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -8232,6 +8256,12 @@
 //DAGB4_WRCLI_DBUS_GO_PENDING
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB4_DAGB_DLY
 #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -28737,6 +28767,12 @@
 //DAGB5_WRCLI_DBUS_GO_PENDING
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB5_DAGB_DLY
 #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -30412,6 +30448,12 @@
 //DAGB6_WRCLI_DBUS_GO_PENDING
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB6_DAGB_DLY
 #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -32087,6 +32129,12 @@
 //DAGB7_WRCLI_DBUS_GO_PENDING
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB7_DAGB_DLY
 #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8
</pre>
    </blockquote>
  </body>
</html>
