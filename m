Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E141E9128F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93D110E8EF;
	Thu,  5 Feb 2026 14:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKRUhA2D";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCE310E8F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiLmXL7FwFZU7mmFcMsElM0PMujEN8C+fTOR0h1FjE7kDgDV3gXxyMB7ACTvTq0R5j5es8cAA/Rymc1v9n9u3L+KH0JQ7TG2VTSuJzLBpeC5AQ6f98IQy7SXPNRtx1cSYYC3fgpvYGthN0K0Lnqq6Azyy6T+H8bjTIcOKHIxvNX8J6K7cyz2JPvsmKCzbgKj5TYtYVxZFG9zPT4+h0mcDhz10qL+KR3nrOwd1xWInZyAJWKCqcwlwJS+tjRanVdeXX/hS2obC3Eq3gwLaR6wF1+2CNtgBWqEbKViI+hLmuIPiYQ9yYyTgzgKBg2n8M/Kp+oY9bP1TnCcEIbDlxnlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY3hvnbJ0aCVViUNvPoU0DPN5qin8fCI4+A6kdBRQLc=;
 b=i+5X7UkwwKh7Q9Ltrkv/kpP6tNPfBxqdakwA92D+3/H9UrQTtoNNvkvL1nYoQhdwZLGY4wIneIUdQ1b22bpwGhnlh95Kcc+q6ncBy65BDc1rbfqlNq6y+l6DXbF10FdFI7+vhIkoB3at+31DuDC/sgfx8XxYnIl00hfdhlioH5i5sDzU8gto3fzWyfa4Wdv80lMFpPhTbTWv/kCluQadegYhWXNqoa9MbOHnyitfFyBZX1tp7nf2msSpn2GfBwZ+dDJJbHuXMUmvhPqZLyXx3ULQ7+8C07+kUd4HkUl0OIcqAWEicFL0+JgmbrR8HA7QS67r9ZP2wcUN1kiEIWWlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY3hvnbJ0aCVViUNvPoU0DPN5qin8fCI4+A6kdBRQLc=;
 b=tKRUhA2Dwl8xdTy0/o0+FralWNAzGVVgoFN62O46he1UOI6EPClxPFIbG9YiY4zEc9NHO71qhtMH+gXygaqcY7L2QWiIVIUmQ9kX/hjOr2dfO0qdTKfNcjFkOz3o6afhlOpox/e1czzCt0tMvwEfJTNcCoxz4/gBBbKX4RoRSWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 5 Feb
 2026 14:45:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:45:48 +0000
Message-ID: <128edefb-a0da-47ff-b7d8-b3ed81b785a7@amd.com>
Date: Thu, 5 Feb 2026 15:45:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure v4
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>
References: <20260205143238.288961-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260205143238.288961-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0966.namprd03.prod.outlook.com
 (2603:10b6:408:109::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: bc770bf2-8e50-4044-cb7a-08de64c54009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aC9sWEJWODdHNVpacklSa1VieFlUOG5uQXJHQWpETE9GaytwZWNBZXptdHpD?=
 =?utf-8?B?L3FmOHAvUkk0MFlXbzErakcvK3F3aEZHejlkWDh6M0VkN2dPaFFZd01TL2NV?=
 =?utf-8?B?ZmkyOSsrTDJmZ3ZtMmdXcFk3aHR2Zmo5Z21yR2lZQWF2elVCeUxrQ2ZqMklp?=
 =?utf-8?B?NklvM0dxZEU4ZEdpOU1pWFZPYmFnWmNXbmVBNzZNdlZIOGk5TXZpaHBGYTQ0?=
 =?utf-8?B?Q0J4KzFTZndJTUluWHBpc3pVbUtTQTQyWjF0cjJpM2djK3dRcnlCZWJLQ1Q4?=
 =?utf-8?B?TG9SanhVNlJCR2V2ZVI3OWFYQWFrcFJaYm4zZGpDMlQ3U2VFNkRDdHVKaVND?=
 =?utf-8?B?cHgrQURxdUxxK1l4SGZlbkhOblFkUmw0cFlnb2dETTJYQzdkelkxdEUrNlpk?=
 =?utf-8?B?TXdCVWd6cm5PbWxWZjhlalhIQkJIcVc1QkZKMEhNT3lsVzN0djd2Mk50S2d3?=
 =?utf-8?B?MFp5UGRoOHkxTU1XdGNUblZyZ1B1andHZWRlY2diS21obHNLUWVFMk05OVJx?=
 =?utf-8?B?NUZDSEFKZWI0dCtvcFN2WnNGWXRkN1JZNmhYOEhHQmw1eEd3eTV1czZGSnQ3?=
 =?utf-8?B?cXNKUjNvd1VNcldlYkoxRDU3Q1RoUWF1RUNDR0JZbTRQQXJBdVh6RThtMm5J?=
 =?utf-8?B?UGlnajNGeXVDdDhRU3l3dEJ5Vm5UMjdab2ptSVVSR2Iyd2hQYW5HTm9XYUd3?=
 =?utf-8?B?VEVBbG9CUWdFdmlSYzRtMWs3RTY0M3pKM25CKzdTcGtISTc5ajRmdjlTKytD?=
 =?utf-8?B?TkRHbXp5ME5oR0R6azh0TkhFVG9sdi9nQWNLU3A0eVo2TDdERndnVGFHRmgv?=
 =?utf-8?B?Ky9uSFZVM2xCTVRlWTE3OWVQekpRMzhUVEtyQitEYk9RUkNNbVNUZ3ZnRGo3?=
 =?utf-8?B?THR6M2xnU096SWxYdTlyRjZlRnhTaEdlS1o3b015VmZTeUtHZWlCL1J4WGZD?=
 =?utf-8?B?RXY3ckF0anUzcWlrbzlDYjRlNDJuSXJucGo1WDM1dk1IOGNnSW9WUW90Um1O?=
 =?utf-8?B?VE43SXBJNStIcVE5T28zQnU2dEQ2ZGliUDl1aldJcDRQSUFIcXhuMnhONnUv?=
 =?utf-8?B?LzcwVjI0TFp3Z05FRFZySG1lNGdmMm45YWJadDljRkFhZXdwN1c3ZXE4VTg5?=
 =?utf-8?B?cUVjUnA4TjlLQmwxcTk5dkxuVzVUcXRFdHRBUmdZcWRWZVJmN2hBTkVncEZm?=
 =?utf-8?B?cHRmM2tmSDBDVVpCbWx4N3laZWhEVFZ2QUFEZW5jWnIrUE9QRWNpKzJ0WTlD?=
 =?utf-8?B?aGZjNXVPc0cvb21jNjFrWlF3VzdsdU02bEFiZ2xHMy90c2pHT3JsSEtKS1dT?=
 =?utf-8?B?QzJDMXZwUFFrNWpGNG9VLzlFVFUzRFYxMEZYYU5FY2dNTDV2Nm1JbG03Vlgw?=
 =?utf-8?B?WTg1ZlZwWU1WblhlS3EzQTUwbHlOM0pqN2JOMnBvenFiWXJXYkd0RHVadjdj?=
 =?utf-8?B?blo3NU1iNE9rbThNSTJUMkVoZWg4SEUvamhwUisreGFLbEVpNmMyZllDamZZ?=
 =?utf-8?B?T2hkQmVZSlZxNjVlQ1Zwam1EYjU1MS9aYkdLcHJNWkdUTEJoWUUyT1k5eXBP?=
 =?utf-8?B?d2w3emRsMG5aZGpaK0JOZjRITWV3ZUpFWFN2WFVtOThadmZkM3hIYXY2UmlF?=
 =?utf-8?B?VktVazQzRUJScWFiclFBT0M3US9mYlVoWGtWbWk1dzZLN1BXMjhVMFBBWTNo?=
 =?utf-8?B?ZENnUVluaERiTnhreCs4bWJXZm81dmVMWng3VXhRWCs3NXZHWlh5aWdIL3pj?=
 =?utf-8?B?K2xqd2VodjBrdnJZYTdtZjRaUFV6NnlQc1k4cStrV3ZWNjdNLzc5aWhhYmlx?=
 =?utf-8?B?dm0zbEk4Q25CajNYM2syVzlJWDVvWGJaZHI3N2FkRDVQMDFqN2dUMi9ZZzdr?=
 =?utf-8?B?ZktDcGQvNEZFSjkrKzljZjYzNWplZ251SStnU08vRUZLY3JhdUsrTlpQaHhy?=
 =?utf-8?B?Q00ra25SNnBjMkRNK1dVdkMwVmR1YnFZZ3drSHZxYTRBRmdIREw1dTdWZWdY?=
 =?utf-8?B?RkJtdUtJZ01ZQ2IvSTg0eXdNWmxQSTJ1bnp0K2xmN0hoZ2UrZmwzU3dlRjhK?=
 =?utf-8?B?ZXZURGFlRGFIRzIxV2hPOGNOQTNWK012eW5UaFd1VGZMeU1Ibkh0TE5xRUxp?=
 =?utf-8?Q?+MjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdWREsyZUZOS3JXWUNNL0JlRGpwd25vU1JPNTFoYzA0TzRqV3pqN0Y0bENs?=
 =?utf-8?B?MHQ1cVJBeVdGTFZJVllqVktHRjJDQnNMdWsyTHp6QVJIT0xGRWh6d09NS0cy?=
 =?utf-8?B?YXFGUHByL0MvT0dIQWhKY2FQWEVUVkZqNlp0NTNxT0JXa1BZS3YxbnNaUjVh?=
 =?utf-8?B?Ym9EV1NMUHJlZGJCaEFsU01zVklVaENTNXptWDVmZ0oyM0Q4ZHZEczhuQ3VX?=
 =?utf-8?B?OTdzSG1LN0RERzd0U0llY1R2enBvNGNkWE45QTRtZlJWR3hUMVlvQmNSTXBi?=
 =?utf-8?B?Um90RnBPd29GNVRkZyt4dnBpRFVGTC82aU9PcGZRR0NLelBLM0tLNWtLSjE4?=
 =?utf-8?B?ck5nbkR3TS9BZklPZFI2M0dkLytCOEdIbm9ES3FFclk3VjQrQ1hyd0Y5VmNz?=
 =?utf-8?B?NjRLbW40ZXJkcGlYV2g1aE90LzJkSTN5UFY2U1JWN3VsOXVJMDVzaVVMN2cr?=
 =?utf-8?B?dzJuQ3YyMkNqZGxGMTBPeUNEZklONlNwYklpOTRkT01SRnB6T0c1NCtwVVo0?=
 =?utf-8?B?c21XT2htRVZGenFLUXNZVS9nbm11TlNKcXB4Wjd3T2o1ejNMOFVBOUhxQjFi?=
 =?utf-8?B?Q29IOEN3K3NEbHVrODhUMnVCU2FScGNobndDdUdTZkk4ZVA1U1hwemdaZFd4?=
 =?utf-8?B?akRqQ1pXdndDU3hyRXh5SStOTkU2cW96cG5Zdk5KRHVMaWxKZFc2NkVrQVdC?=
 =?utf-8?B?Qkh6b0hCRWJvZXZDVnNyekRLN1hqQ0YwaFJYcVRXUFdPUHkyVE0raTNEcXRv?=
 =?utf-8?B?UVUybGFocnBtUzIwUGE5aUl1eWF6Wis1cXJLMHlON3dTcTNhWG05UkR1T3M1?=
 =?utf-8?B?bUljZmFLRlpLaXhrelhkMnRTd1FhZklYa0pxOHZiZVhqSmsxTjEzVHFZdVN2?=
 =?utf-8?B?NnRKQVNnZGtmVUMrcjVCRDAyNkRlN3lUT2NKSi9Kb21jMUJxd0ZaTWNzQThC?=
 =?utf-8?B?eWhvQlNhcHV0SDM3UTg0aDFjZmRrYURJQkVocWtocVFWVG81MXBCbkZaSGll?=
 =?utf-8?B?cm5WZngydHp4L0w1OEJzNG8wRlh2aDAyamJEdy9sOEVmcWdMSS9ybzMyVnYw?=
 =?utf-8?B?K1hBOW9RU1ArTGFERld6MldYYnVoY2xIQ1kvT2lxcG80OGhlNVU2bHI3WDBG?=
 =?utf-8?B?R2h0YzdQNU5PbGZEbnd1RXJBSXJZazd4VjVRcFNXRDVyeFB1M3lBUUU4SlNs?=
 =?utf-8?B?N3h0YzRNTjliaVB3VndRU2hxSExkVWw3cEM3c1EzSFdVQm5BOWIwSXVXRHBm?=
 =?utf-8?B?OTVLcndFL1dkUFFLZTlWTG9NbTZzYjkremZBbjFsSm1LZGFOcGxjbmJhdldS?=
 =?utf-8?B?Q3h3dUF0QVBoMzQvY3p6YVZCd3JqcUNYM3FGdmNoMVNmNER5d0dNb3hpT0Z1?=
 =?utf-8?B?RzM1RlFYdVdZTFFVenVhTHkyMWtjeG0yT3lBeXI0OUgyWTBFNU56eTR5VCt0?=
 =?utf-8?B?ZkROaCt1eVEva1Q2TTVuVmZTanNiK3ducWE4cDd4QXZJNW83MFdacEdtR1JM?=
 =?utf-8?B?Qm1sZ1ZkUVJuL1lIQlI2dERHdkYwSlFFMEppS2pJYWszOGRrNWIzRjRRTjlC?=
 =?utf-8?B?M2tFcG1yS21JNjNWQVVGdytHaENGWHRZSStMaXE5RU5INVVCUXFOcDd3MUZB?=
 =?utf-8?B?eDVCM0NDdFE2UUVpYVU5bWhPNXZvK0d2TWFuOGRseDZmVXpKMFo4TXVnUytt?=
 =?utf-8?B?cmhNaGtka2pqaXlyQkI3NlhHZ3hoSkY3cWNKVDJNOFgweHlUeUdaQWRLSno0?=
 =?utf-8?B?SUg3N0dGbEtOYTFrVXkvZHl5alAxMFJ1S2Nub2VjMnhabTVqc0xtcG1WSy81?=
 =?utf-8?B?SUlaS29CTThnUTBmSHdDQ0JUQW5BY0hCQ1dtMENGdVhMUUViMW1acFI2MnpE?=
 =?utf-8?B?NTVSNm5nSHlMQXNvMklXVzE5cU5KdTZSOWZEM1FWMUhrMG1ueEtOWms4MUlX?=
 =?utf-8?B?UzBSZmt2Y1Rham5kRmFIRldiOGQzbU5DMTI4T0tQUGpaaFg3VkdCeXFBT2sy?=
 =?utf-8?B?WjByTU9IU0hlRHkvK2d1bjdpSW95eUhBb3BYbVpzd1VkSnpRQ3BMU3RjYkkx?=
 =?utf-8?B?dkJDL1F1eFJmdWdDYk5mK3FmMjBXUEYwRXdRZjVtQVlWL1ROTXdsbURxOStm?=
 =?utf-8?B?ODFqU3FpMnZSTnZBUzVyY2hVc0M3bzdiRkxrS3Rod0tlQWZ1b0hOSmV3N0Ru?=
 =?utf-8?B?aExneXhTSTM2ejFLQmExSVFCTlJIaHdGVHMxSmh2QlFqay9xR21QcVBZTk1H?=
 =?utf-8?B?TVp2WlYvQkMxZG1vK3BTM09kMU9IdWhKdnFDeHYvTGF6dmFSU0lTdVVvaEhM?=
 =?utf-8?Q?c3yhOr34GecnGA57w6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc770bf2-8e50-4044-cb7a-08de64c54009
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:45:48.0582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfAs14QGuZaUE2yTiV3QcX+BXRHUZWaiFpL8j0C9kwC6MucH1bB6k7DgsUTsiTes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

On 2/5/26 15:32, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() can allocate the output array and take
> references on GEM objects before it fails.
> 
> If an error happens part-way through, callers previously had to clean up
> partially created results themselves. This relied on subtle and
> undocumented behavior and was easy to get wrong.
> 
> Make drm_gem_objects_lookup() clean up on failure. The function now
> drops any references it already took, frees the array, and sets
> *objs_out to NULL before returning an error.
> 
> On success, behavior is unchanged. Existing callers remain correct and
> their error cleanup paths simply do nothing when *objs_out is NULL.
> 
> v3: Move partial-lookup cleanup into objects_lookup(), perform reference
> dropping outside the lock, and remove reliance on __GFP_ZERO or implicit
> NULL handling. (Christian)
> 
> v4: Use goto-style error handling in objects_lookup(), drop partial
> references outside the lock, and simplify drm_gem_objects_lookup()
> cleanup by routing failures through err_free_handles as suggested.
> (Christian)
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 48 ++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a1a9c828938b..e1218728352d 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -750,14 +750,22 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>  	for (i = 0; i < count; i++) {
>  		/* Check if we currently have a reference on the object */
>  		obj = idr_find(&filp->object_idr, handle[i]);
> -		if (!obj) {
> -			ret = -ENOENT;
> -			break;
> -		}
> +		if (!obj)
> +			goto err;
> +
>  		drm_gem_object_get(obj);
>  		objs[i] = obj;
>  	}
> +
>  	spin_unlock(&filp->table_lock);
> +	return 0;
> +
> +err:
> +	ret = -ENOENT;

I think you can now also drop the ret local variable.

> +	spin_unlock(&filp->table_lock);
> +
> +	while (i--)
> +		drm_gem_object_put(objs[i]);
>  
>  	return ret;
>  }
> @@ -775,9 +783,11 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>   * For a single handle lookup, use drm_gem_object_lookup().
>   *
>   * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need to be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop the references with
> + * drm_gem_object_put() and free the array with kvfree().
> + *
> + * On failure, *@objs_out is set to NULL and no further action is required.
>   *
>   */
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> @@ -785,36 +795,42 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  {
>  	struct drm_device *dev = filp->minor->dev;
>  	struct drm_gem_object **objs;
> -	u32 *handles;
> +	u32 *handles = NULL;
>  	int ret;
>  
> +	*objs_out = NULL;
>  	if (!count)
>  		return 0;
>  
> -	objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
> -			     GFP_KERNEL | __GFP_ZERO);
> +	objs = kvmalloc_array(count, sizeof(*objs), GFP_KERNEL);
>  	if (!objs)
>  		return -ENOMEM;
>  
> -	*objs_out = objs;
> -
>  	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);

As pointed out by Tvrtko as well please rebase that on top of drm-misc-next. This code here has changed there.

Regards,
Christian.

>  	if (!handles) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_free_objs;
>  	}
>  
>  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>  		ret = -EFAULT;
>  		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
> -		goto out;
> +		goto err_free_handles;
>  	}
>  
>  	ret = objects_lookup(filp, handles, count, objs);
> -out:
> +	if (ret)
> +		goto err_free_handles;
> +
>  	kvfree(handles);
> -	return ret;
> +	*objs_out = objs;
> +	return 0;
>  
> +err_free_handles:
> +	kvfree(handles);
> +err_free_objs:
> +	kvfree(objs);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_gem_objects_lookup);
>  

