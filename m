Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ADEC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 07:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751AC10E9BD;
	Fri, 16 May 2025 07:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uTJJs33q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D3910E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 07:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsFehnUnAOB2yem8dVDEuYeOy3vbJ1prKG1Ps88Lg/b4db1ubHeIYLtxbG2v6qOJGtJC0Bfb69BHAG+f2QA3fcMhawMERaMO86yjgFn0k8rC44fug4l0v9eK83ouasErNDCRn3XLG0sil/J4JShsi7L7mK0gpDj7xq0mhpZvsrsRpLViDLw2G7rLGnK6AUBB3HVpn/WCOjqHFpKjV+joqxF11nYMDyS7C+fodQaQ7WY+whrQRR09kzxD0JHys0JmBAHfkSB3hLGosWL3BifuU+V7NPd54JWXh4Jbqm5WFTW9fYp8MBsIp2PP7+vds83+Ru4NTQVbaH34q7xaHqYUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CNgK04Z48vVXxKglsnFBa+xpYBumPyfJ1fBwlDpw7Y=;
 b=MQfGa3ddrHk4JIXTHyxKV3r8l0ropJKXynO7jqrcUp+b0w1vLHByhbcdWJpdmQUyvyGW4SyzNs3a/FWkOqVlezmKSZzi9wdLmNp2xQFm2cbN5OXYOPxy00cSH118JezaLvEqKqht0o1ljPQgvwE9c7yXy9Ir9WXcaz78Z43TxgqXVAKwuAWgAmFfyASFydjMFNHJdubB8FicOvIhpk8tKX2eqH1JREqWmcOelbyCf+kmQy5R9r1LEdemQ/1hBF/aZ1Fs+NVODN0mMjpVMRR/RmlQjIDs6OM5f6C1Z90Im3RmIJZEEyWHckupnA+o81eBdI2/pPb8X1lt4ghnmXBX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CNgK04Z48vVXxKglsnFBa+xpYBumPyfJ1fBwlDpw7Y=;
 b=uTJJs33qWQG2GQTwn8G3UpC4QA9SS45ADxGWdPfrNkCgKxiRO4kjB3mjeJ5AHANbQxtT+6v518sGy2anbgVf+jyfpr1hWqCctODfVZVlVJspZ1LF2mJw3GlYVjqa+eKvANeH4E+VfaQOS4dCKB/8UbCE0/RX+2JDAJV3JEk1jZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:09:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:09:20 +0000
Message-ID: <83bcb526-78ae-4fd2-93a9-5a2809e64364@amd.com>
Date: Fri, 16 May 2025 09:09:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] drm/amdgpu: read back register after written
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 37359c1e-6898-40a9-f685-08dd9448943f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXVTNEVyQmZMMXVjQ0NpelRYamJYZDlnMVdDS0djRVI1bDB2WEFDTzA1NFJu?=
 =?utf-8?B?MVhtc1VLdXFRNHVnVFdhSm94MW9OTTlYQXluQldQTFBpd3BjT05hZ3dFcmJL?=
 =?utf-8?B?TExUeFVHeXROVUhKYnJYRUxYNWxqVUhwMUd3RzRickE2K3Z4WmEwVWFpWThq?=
 =?utf-8?B?RmgrTVRmaHYwazlnNFp2ZksvUEFzU2lUWW9aQlo3SUVTeGU1aVZGeUUxZHlB?=
 =?utf-8?B?MDdiWjlFVWU2ZVh5cTlFdy84M1FLQUFQZTEwdGhBaVNtejNIaUpkOGxzRXpu?=
 =?utf-8?B?dUxMVXF5YjBkVGZ5U0NSZDhmcXczTlc5RVhMY0NpZVBKbXRZOFdVczZJTWpC?=
 =?utf-8?B?cHR6M0ZXV1NpcHhiWFFYL21ZNzFoaVQ2ck9FdDRKaS8vMlk5ZW80QUlhNWd5?=
 =?utf-8?B?KzNHYXpEcm9Sak1VNy90UGpQVTVFSEZQb05RbDZVNU5sUVVFTGpBUlJVWXow?=
 =?utf-8?B?NGZrUW94dDFXVkkrM3pPeGlRTmZZZ1UxcmpqUkhzRE5kL3BvTWhKd1M0VFd4?=
 =?utf-8?B?V0h3S1VZS2tUWldBR1k3TCtxMGtmaFA0eFR4a25xWjZjR0FyQWQrYlE0bkh1?=
 =?utf-8?B?M3YwdnM3TENGZ2dyd1lTcTdnWGRUcUM2WnlLOHFEQlN4TzN0bXl3QmdBWjQx?=
 =?utf-8?B?SGI2eGxzVUtROHdodWR6UnozbDM1K00zNFhoV1Jxam9vWXdOK01Bc1FyMHd5?=
 =?utf-8?B?YW5OaHZPUGtxTlFNZFhpdFFlMCttU0lLOCttcFp5T3NOeDRaZlNhMXduRlJR?=
 =?utf-8?B?ZnduWndETnhyNG15WXk3TEFSOUZLUFAyaEJ3ZWdYVVRrTE1ESnZhcUk4MUpX?=
 =?utf-8?B?aG5ZS2NYalVyMEFxMGR6dTd6V3lrRXJDU0p5WFJmTkZtOUxzMFlUSnpnc240?=
 =?utf-8?B?eHFZeXBvQUhDZ04xSjROU3Z4UExLKy96R0NGdG1qL1dqTkJaVWZDZlNDSjJw?=
 =?utf-8?B?U1VqajhxZzgzKzVHanpNc2pSTDlJOXpBQzNicmdzakdDYUhXb2hJZHBpSTA3?=
 =?utf-8?B?UExZVEsxa0haRWRNSnp1VCtWd1dBTTFTNkpDVkg1ZUVmd3JPOHRuUTR0UGJO?=
 =?utf-8?B?czVOQ241STVLVmduZGRoU3Y2VHZGWTZkVm4wQ00xT1d5OGJPTUlRcnRSVitk?=
 =?utf-8?B?WWdMTHJPMVZDdTFEVnZlSzNXdkJNZWg5WG92T0NYNVdmMHpXeVJZbzVTWWox?=
 =?utf-8?B?RzN3RUsxUi9iNEpQK0REanIwbEVQVFRLWjl2S0QxZ0xQVVBiNFhBTG1UN1Zh?=
 =?utf-8?B?MldGUG9JSW5RWjVtcWE3SGZqY3VSakJaRE9haWZlSFBDWmkyOWoxNlhQVU9v?=
 =?utf-8?B?dkxCcittOTNiamRtWUNacjJoZTV4NUR1c2FUR3ZDN21MZ0xhek5SVGc2b0VM?=
 =?utf-8?B?a1lNZWF0R1ZWQk93Q01JNkNma3Y1ci90WXNhdlRENXpoN1FOc0JWTERKdDVO?=
 =?utf-8?B?S04yaFRUbnpUd251aWNyTzFuWTJzNnBHanhGWFBCbGtPTVJhSStneCt2SWN6?=
 =?utf-8?B?N05RcGc3aE1CTnZZYVJha0h6NC9rcXJJQWdsYUc3NmxRTGpqamZRTTh3ajZm?=
 =?utf-8?B?MzB3ckVtMU5xcGpyU05zNXZLT2xGd2N0UkpIcm1qMkRadGFQcG5rNEFVeFlI?=
 =?utf-8?B?dkJDTWlPZHoyNmJBeVltVit3LzJJWTdpeTBGS3BiRWhKWlE1ZGkrUWI2OFRP?=
 =?utf-8?B?K0NvVGV1RW5SMmdEL0E4ZDlNUVRKM2o0Qy9VaUdEaHU1NzFZdkxpRUtsNytQ?=
 =?utf-8?B?czhaU0YwaHN5N25yYVdhZExaYm4wdzFnZnhmUTFqRUJ2SEVhcGpjY2VlbnQ4?=
 =?utf-8?B?Y2xvQmRXK0tQeXlsUW1Kd3FiejY5cXRSbEsydFgraTZNeFp6UHFPTW5NVEYx?=
 =?utf-8?B?eW1lTG1JV3F3QTA2UUpiNG00ekI2MFQ2elhhdWtYNnFnZVhSTFprQ0N2eUZB?=
 =?utf-8?Q?7YQbJ7sei1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVaOEdaenI4c3RkeWpFS0ZXSUsxYlI0VTlrVFRKdGR2eGY3Y1NGSFNndFF6?=
 =?utf-8?B?eDl4ZFF3RUh6YWpsRncrYnMxZFNhcU4renI0RjlLcGZSL0hTQ0NuazNxMDVJ?=
 =?utf-8?B?NHBtZkRyMWI4dVVycm5keXdENTVwaHJlMDhyemVoZzNJRElUU2toMFh1M3dx?=
 =?utf-8?B?QW1iUnA1NjdBcFNuNHdUWDRlWUFVRTZVYzBpcUhDTUZRWmxvY3NJWDJ0Qm9P?=
 =?utf-8?B?L3dCaWpUNENZL0ZiUTB3aTN2amVwd2plYzAvYjZqaXZKa2Nqc2VDQmVJbmc2?=
 =?utf-8?B?WG51NENFUFN4V2NHcGh0R2liL2hveU9zTFVSNmtTekE2cktDamVDbjdEYzVh?=
 =?utf-8?B?di9FM3VNNlJpQWwwam9GZGEwbHAxZFhHYXFSZ2xlaGhhQm4xRm83SkY2VUkv?=
 =?utf-8?B?WDY3eS8rQzZuMVM2RzJ4L2ZZMk5OYUh0TjVoYTVwVUJReEYxRTVHbG1QNUFJ?=
 =?utf-8?B?djNWYjY0ZnF4WFY0VWpyZ0R2VDRuL1kvbDVQT2FEMTlKWWtsZE15MXJzMVVQ?=
 =?utf-8?B?Q2hBajRsaURIRkF1WTBuS1gyS2tGVkUwNHNtdXErOUpyUStuRGFEeXhBbDc3?=
 =?utf-8?B?ekw1TG1SNmQvOWJtb3RZeWJjeEx3TGRaY1dlWlZKa0MwYkZZTTdrWFh1cHVk?=
 =?utf-8?B?M2YxY0lFa2lzUjJXckwxT0ZjenBTeHV0R1A1QjVXc1Iwa2tZa1VzaFRHMy95?=
 =?utf-8?B?SnB2QTB2aHN3YlpqZGREM2FhR1F4WEZtbkdJdVFpTk1ES3g5WXdKRW9Pb1JZ?=
 =?utf-8?B?SVJOS0VuQUg3b1E2N0JCUk4xYUFvRHlMTUJoYTJ4RDZWWlU0RVc1S0ZLRGVU?=
 =?utf-8?B?c0F5UmR4dmMxcWNhL0VzQk9BbHZ4QmoxSjFoOFRZSytqYitBWkFVNWowTGwr?=
 =?utf-8?B?dkZCMHNvYnRNQnRpc3NRTGNRTTg2NDRpNkVqRjhnWGFxWHdRUFdlMERzNmFy?=
 =?utf-8?B?blFjZUZyWnF4Sm5sN3JyRmtua3JnSjVJNzZVL1hyQ2kzd3RIRU1SYkJGcW9Q?=
 =?utf-8?B?VEVjbzN6OHMxZHN3WnY3RWVZbjlQcExORjMyMnZPVlREbm1RZGxDK2dreWJr?=
 =?utf-8?B?ZWg4bmxOdnpKOHc2ejNXSzl1VVEzbmJCaS9FQ1lmOGdHcytPdHBLUVhabVlU?=
 =?utf-8?B?d0kwY09pZWI5UnJWNXl4SkRTMFlBTHBPRU8xTHJtVlAvK1dMSGZLQXZBY3pp?=
 =?utf-8?B?ZURPNUJnNFVhWFF6ajVUZ3FZYjJpQnJLN2RhdWVZSmFSSERhaTF0YWIzMCty?=
 =?utf-8?B?RmZYZjV3VnQ4ZmVlSnNzRFd6Wk4wNEw5TkJaQTIzc09IR0puQ2haUnI3Ty94?=
 =?utf-8?B?L09JeFZDRmJoUjZKa0piRXZ0M1hyQ1Y4ME1ETWFyeTVJSzQ4OHN0VGkxdmtq?=
 =?utf-8?B?bU4xRWdKZ2dJQzZhSXBPRVlzMkFXQ29ZRmxVVXgxdGhiQWpZZEFPNUhLU3Z3?=
 =?utf-8?B?RGhMZUpPZS9hSEJORldpbzRlanpDeGtLeU9EeTB0UGJ5N3pXNEhZb1B3KzlR?=
 =?utf-8?B?U0J2QWRrVHZJQm8rbnlXUFBPUUVHSjBXVU1ETDNkTlFjbFEvdklLZDViOUNJ?=
 =?utf-8?B?cllFbHB1WURjUEFqd0ZiY1hsUlhhNjRyZStFNDg4a1VIR2FMQmxnZXV3bWFX?=
 =?utf-8?B?SGhlaDl4WjBkRXpsckVSZlc4YzNGdWhTSWt3UkJYMkYyRFNubXV4YUhPMmxz?=
 =?utf-8?B?UlBUSjArc05VZTBpODFLY0I2U2tuSzc1ajliRG56OFdqWVkxMUxobGlHNnBj?=
 =?utf-8?B?b0pTNnBVbUx1R1VseDZkQ2JSQk5QRHRUNHdyWnBGelZwKzRVZVNMc1RWL2dx?=
 =?utf-8?B?cjVVU1dJRnU0dTIyMmxyWXRDdEpSc2pKdW1hUGhNVE1NUWlrdmh2a3QrYVVE?=
 =?utf-8?B?YmtJQmxBWUZtcXpNMjJXa3gwd2h0N21jZmZEdjFtcFU5ZjdZcTYrRFMxZkZI?=
 =?utf-8?B?N0kvVkl5amRSS0tPbWoxdWlZcHVNZlFmSVpHMkJSZjVsc25yR3lMWmlKdldx?=
 =?utf-8?B?VWg2NFl1Wms3VUVmZnVPOUNtdjBhQnc1ZGtjNmlYTzJCK1VQNEZBV1dpSElu?=
 =?utf-8?B?QzhhL1AyZ1VBWmE2bHEzSVdWV3VDQlEzOHFjdzNWd3Z1S3lQUG56RXNRckJl?=
 =?utf-8?Q?/HQQHIId0koW4V7vQTljdogcv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37359c1e-6898-40a9-f685-08dd9448943f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:09:20.3915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfrv+1URzcbcJypaqvmW9vCkvuJ1HkR2qICfHqomRmtYumOvA5R8WItC9Wrzdr8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

On 5/15/25 18:40, David (Ming Qiang) Wu wrote:
> V2: use common register UVD_STATUS for readback (standard PCI MMIO
>     behavior, i.e. readback post all writes to let the writes hit
>     the hardware)
>     add read-back in ..._stop() for more coverage.
> 
> Similar to the changes made for VCN v4.0.5 where readback to post the
> writes to avoid race with the doorbell, the addition of register
> readback support in other VCN versions is intended to prevent potential
> race conditions, even though such issues have not been observed yet.
> This change ensures consistency across different VCN variants and helps
> avoid similar issues. The overhead introduced is negligible.
> 
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Exactly for the comment on patch #9 this looks good to me.

With my comment cleared up feel free to add Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.


> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 21b57c29bf7d..c74947705d77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
>  
>  	jpeg_v1_0_start(adev, 0);
>  
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
> +
>  	return 0;
>  }
>  
> @@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
>  
>  	jpeg_v1_0_start(adev, 1);
>  
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
> +
>  	return 0;
>  }
>  
> @@ -1216,6 +1226,12 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
>  
>  	vcn_v1_0_enable_clock_gating(vinst);
>  	vcn_1_0_enable_static_power_gating(vinst);
> +
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
> +
>  	return 0;
>  }
>  
> @@ -1250,6 +1266,11 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>  	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
>  			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
>  
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
> +
>  	return 0;
>  }
>  

