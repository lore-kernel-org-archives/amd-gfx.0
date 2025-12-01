Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EE0D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 21:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB64510E49A;
	Mon,  1 Dec 2025 21:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpGUtIbF";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFD310E49A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 21:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFk1K5Rft2Hu9biIxopEP1d0KBL9B0Nh53LkYuTd4tIdssm/zgcoMVxvuU3xEnjti4VNbXik/HGvaJdj5C5D6CenUCFmYhIYroiC5fI27Yz9Mv6lVxt7ZjNbGAIb+GeFegfsdHIbHHRRlKh5HsVlMdPg64/G3NUfonX9uwUTVGS9dnIc3VKIAwT3k5/aMwrN8q2qsa5QrN8VriZPfOy4aUzMTmu8/oY4cAOgnl7JVu53MptWLkxn5K58OZWrPKGkDRy9d9gdWIzZGxI0ZY0ucbN3PzAJOSqzrLTa/j22gx23JBt+H7TT3qDy+3nkGyCCcHKAbzmImJJFR8i0yBpXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoLnWYsW0xgwgTWS7CZtiVNc7g/v8bpiUNMp07tV5JU=;
 b=YRuIAib6oliX8ZdeQk5XWFVlDLkbNKsMhDOuraYx4V5aO1HvvvExbLI/l59z98WepY/bxSo7eH5Khi8o20FaMfs9vuOJLpDwOYYmDhWuDfvKrYKqPzYDvG0P01Aly44kUbvZeYzKdcM3c4LsexZjk6KhDHxoUcDnnT3WPa0R8xbhPcfHKMySX//8V5GIG/hMDs7d1HThkpsxRrpwztWluZ0mM3dH30w8vHSbt84JIAwMVKiBSi8nstTmA8iAeE3kSnpw6NimqvgG2C9+K8jOgbWni4Gihcxz4kvlRRBNtZ30BLPw45mGGS4oV/PfKElyZsu48188tKe4cVpL9C2N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoLnWYsW0xgwgTWS7CZtiVNc7g/v8bpiUNMp07tV5JU=;
 b=jpGUtIbFchiMPMBNmIOT0d+zcrWDHlehHh6z7XRK7IfWtpU/24dSVpsh1762lcDjmkeWFuTgniXGGJH/22INh4glktTotbf7FSvrI4SYP00dy1xXColNg2I/MicqdDW/RsFq7du8qVGbODgd+5fmyHbZk4feEv5oYSfteunj1d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 21:47:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 21:47:01 +0000
Message-ID: <80b9b439-20bf-464c-8a4e-e0bed18627a3@amd.com>
Date: Mon, 1 Dec 2025 16:46:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix improper NULL termination of queue
 restore SMI event string
To: Brian Kocoloski <brian.kocoloski@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, Brian Kocoloski <bkocolos@amd.com>
References: <20251201210008.40096-1-brian.kocoloski@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251201210008.40096-1-brian.kocoloski@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d99291-49d6-4422-d0bb-08de312328e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDlJVHYzMnY2dTJWYXZ2QlhwVyt1S0g2dWhoWStuaTlqWUltV25XUlowTjQw?=
 =?utf-8?B?MG0wUVovNEl2MFpMUVplRzBOTTlvUit1WXNydHNqeXFGOUpGTVRrSTdlY2FL?=
 =?utf-8?B?ZEF3YUJtSlF1S0FZSStjVzd4MXZYVTFzdGROWGFUN1NhZDhBQkVkMm5iQWJB?=
 =?utf-8?B?SU1HWHc4MHVKQ05pd2dzemxpR2VqUTAycUNpOG9lcmw3bHNVeTdaOFdDZk5E?=
 =?utf-8?B?b2FXMGJ1MVhISzNpV2FrcjVwV2ZpOE1Rb1NtVVY2VCtYcHlDYWNKOTU5clNE?=
 =?utf-8?B?YklHdUMvQU9rSER4ZUFrSjhmaXZrK3RPY2pseHE3WG51OFo2cU1nMERJL21B?=
 =?utf-8?B?eFJFL1JSYnBGOTRTaW1xVWlJZ3N4YlgwcStGYkhtTFZQMm1TMURTREFUSWRU?=
 =?utf-8?B?M1pRWmxZYy9pWWxibUViNUFrbU5UVEJPdCtucVl4QmJEYzRPazlydkxuZmMw?=
 =?utf-8?B?NTBlVklPemtVZlp4ZU5tTXc2ek9ka3hDTml1M25hNVM3VktEOU44dm5RaW9S?=
 =?utf-8?B?S1pVYXVGdDdQRVVlR3NvZllTV3FsOHgzWElnamJUMkxrS1RTOWxEZklSTlMy?=
 =?utf-8?B?RFUxZFA1aEplVjdRZEZBRVQvRWd5ckt0bWdVeWtjM1R6Tnl6K3N0c3M1ZFZv?=
 =?utf-8?B?TXFMRVNTQ3lsSEJaNHlkZWtYK3ZHcElyUENwdVk1UjBZZk5SeCt6YzEvUnpx?=
 =?utf-8?B?MGdTYjFOMG11b1J6Q29pQXA3djJZNkE4L3dJZW9BMzNwR2cxazFCT2lWOXlj?=
 =?utf-8?B?eWNEL3k5VlVmYnVNbnRnZk16SlRYT0F3TE9VdytBb2Y3MStvckxqV2lnSk4w?=
 =?utf-8?B?TWQxMytkOXBrSnFhTkIrTDcvR003UWNmeWU1UTk1WURsVVA1RkxvWTlnemdP?=
 =?utf-8?B?dFRzaUhocTNlMUtiOGsvK1RJSmFWaGVsTXVtZ1RJRWpsenAwcXNsZDRGMzFR?=
 =?utf-8?B?NER5QTBhRHdmVmI4NUwzMzlsRVlOQWFHR3FwMy91NlJZS0pUakJRUndtQ2pz?=
 =?utf-8?B?NHl0M09yWEJKZFN2YjF6ZFBPTjVFMk1OcmJGTUYxQVA4QTkyY0tMQnlMTmdp?=
 =?utf-8?B?L0s4bmFzNXJpbHdUSlBTRDl2U3czVWZwQkc4bEFpa2x5S0RySkYvaGJsSjNY?=
 =?utf-8?B?Lzc5cmxhNndtd1lXaTZVWjV3K0d0ZTByVVVMbmJHZTB0eHJZSWgxUW96Lzhr?=
 =?utf-8?B?TDVmUWVETkxSOE16U1ZjSSt2U3VlNHRFd1RzODhXOWVOajFaOE9zQUg0ckRN?=
 =?utf-8?B?c1pnY05DdFRvK0Zid0Jac1RWMmhmTEE1cXNzdHlaRldZQUx4M3gxVjR3MFJt?=
 =?utf-8?B?Q04wdEROa2ZsWXduQmRRY3p0NWpGRk14bnFBV0prWWhTOTkvMjM5aWJiSzE4?=
 =?utf-8?B?cC9ZaGxHS0xiSWdlMVBSRXZqZEk4S2tYYWV5T3BuVjVJSGNGaUR1Ky9KVnM4?=
 =?utf-8?B?ODZ2ZGVSRStta2pVTzNheFVMU2tMZ0JJMkJUUHgrbm53LzltRCtPSnpOaVBO?=
 =?utf-8?B?WW83QjI2M05UNlI5SW11emw1clBRa0p4bWY4TFR2TnYvWDJuSXJEWVA3cGUr?=
 =?utf-8?B?a0ZKS3J5U2NXQTdIL3ZGOExsbjlNU21pTDBvWTNVc2hKeUFaUDlpbmNGUG1I?=
 =?utf-8?B?eEZQNklING1MQjYzRkUzekZuNVhwMExwTml5cG43dkJPand6emhBRmJIdkhs?=
 =?utf-8?B?Uks5S3I0Yk5RcEkvRzJ0aHNKcm1QNzNWSk5FY2FxWStPOFZiMzFRMGNhbHlW?=
 =?utf-8?B?SFZCdjFOdEFoYlNmb1ZTR2M1bFJJcmJPZTU3M0t6OU5neHBhdkdtQ1Zvb2hL?=
 =?utf-8?B?ZVlYcWVaNlZtZHlHcmRjS1V5VzVWQzd2dlVRbXQ3R2xHQXBuTWxlT0ROMndy?=
 =?utf-8?B?OWtWR3pBM29kME84bVNwcVh4T2NRRHdGLzh0dEZWKzhNRm1ualRCOTFHdjFS?=
 =?utf-8?Q?kizT+tD+hsZYL1kgLzjX9ATY8DAQ32P/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pVbGFLV1pFQ3RZNjlZaFpGajZBcmtmM2NqZGlLMWNOQ09iMFNHK1M1c1hT?=
 =?utf-8?B?czN0aXdWUG83RFV4YlVtV0NLUkhBSnhobWx4cDRGbmxkQ2gwMHZvanlEYXVt?=
 =?utf-8?B?QzgyamdNQ3ZwZEJBMWpEQUtpU3ZvRHhOUC80TWdyYjlCdnE3WjBkeHF4UU1F?=
 =?utf-8?B?ZDhNd3c4b0hOMDZiaUZabFN5NFZNR3p6MzBlb29BQ2NUWGx1a1AzQ041UGVQ?=
 =?utf-8?B?b2xTVWhFb25sbFdsRTMzTlBoeVM0WUdrWjZ1WlZLZ0RqWlBnRVZLVk1pZk1C?=
 =?utf-8?B?YXZIVEdUSWtncGpGWGZoZzRkcUZBb3FOWUlkRHZ2OVk2dWc5SmlqNmgrNlRW?=
 =?utf-8?B?U3hDeWtTa1V0MVNVQ09NL3p6Zkd4Z2NkOWhseGw3Ynkzd3g4Rk90MGZmUGg4?=
 =?utf-8?B?dWpwakpqN0tONVNPTWJZTFNkcVB0dS9UdjhxeDI1UFJOd2V4VDcyL3Z5VkND?=
 =?utf-8?B?bHVTUW1HVUZVVTZkdGREZkZvcGl3L3htRzJZNEF4WkVaUVVneXRMcklOdTN6?=
 =?utf-8?B?aWJiR3g4aEJFUzEra0RFNkFsTnhCRkNHTW5FalRUWjJ6QlJWeVFZMHllYVpw?=
 =?utf-8?B?dU5ycFJMdkZFNXlQTzcrL2pxbWMzaEU0bVp0ajZMeXMvTlJIcEtPNzJHTnhl?=
 =?utf-8?B?a0FJWnBnemcxYTVEZ0J1OERXQU1lSVlOMldaMUZuc1ZnbW5qd2VHVFU2L29y?=
 =?utf-8?B?SVcrNzBON3htdEM4RjR5OGxJSHpCZmFMbjNEUWVja0J2MGNDZ01PMEh3Q2Er?=
 =?utf-8?B?SWkzZk9jU0xoMGh2YkxTS1RJRFNFMmlxTWtSRkVZa2xYZDJlQkRIMkUxamFv?=
 =?utf-8?B?a25lUDV1ekFIWEdVSFpzWEQ2dUM3K1kzcEJtNklmTVZpV3BtVnVUMmRIUi9i?=
 =?utf-8?B?MkpKYW9PWS9wdHpRajF0Q3NuZTlVb0NJUSs0OEhSQXo2eHgvNlJSRnVjVjQ0?=
 =?utf-8?B?WHJ3UjNDY0pJU1ExaFBpak9YZlo2TFNwdGVKUVlrckJMaGNKRW9tTHJOaXY2?=
 =?utf-8?B?NUJyME1GRkkxWmZPbmZ2MGxhL1FrMW13WFg0VCtsSEp4SEZLOXlBMG1PZHZT?=
 =?utf-8?B?SVI4U3g3V2dDQmpYSWpxWk9Sa2tMbWNycHYweW8xcDJuYnFKejRJMzZ4dXp3?=
 =?utf-8?B?OTFCa2o2cjd4d3R1aTZnSFpFeFk3dVJLc3pXb212MTB4SW5Xb3cveFBsNjI1?=
 =?utf-8?B?TEsvUEo2eXcza0hrKzJpZTJjQmVoeGpYYlk4Q1dPOEdFM24zdkt4SWZMaEZl?=
 =?utf-8?B?d3ovaDM3OVNzdVlhUktzenpCay9zbWZJRzY5VlBmNmsveGxCMGl4VWxja3ph?=
 =?utf-8?B?bmN0T3pjQW11dnFuQlhnbUJjdUk3aDZWenhYaDdjZW03TXY1OWQ1ZHRPVWNK?=
 =?utf-8?B?UklZVU5SZVRwQmQxRWlZRHQ5dVYvNUY5ZWZjVTdJTlZGUHN6cFBNajlpOXFa?=
 =?utf-8?B?SmhFNnR3RkxuZk4yNEtIWEFhVDFsaXQ5QUNwTjBjOVlkbEgxMjBmU3Nra0s3?=
 =?utf-8?B?SDdZaUdWd3ptZ0FmQ3J6S0w2cUVKMUtmWFF1TStnOWF3dnYzYnhydlVYN1Uv?=
 =?utf-8?B?Tkx1VjNreDFiM0dMK1ZIR0w2Q3RQTmNyVmxwMlFPaFlHek9sL0VERThSMURK?=
 =?utf-8?B?V0R0RGE2R0pUZm1LUVhEbmdUWGpIdUNoc3J0WW5FYldXNkVmcWx6T3Z2bnNi?=
 =?utf-8?B?ZzJBc3dUaXdmMk1xUzY1RVZUVXpHeWsvb2xjc1lCdmFVcDBZRWMrbHVod0lh?=
 =?utf-8?B?M1hibFVrUnJ6LzUzek9wR2NCQWNGbGNTOC9OanJCRE1Bd0RCVVpXU3VDOFBK?=
 =?utf-8?B?cVJWWUJMSXFpVkdobkdndW1TODA2ajVnUUpHcDVzdjJGNUZEMTVva0VwQkpp?=
 =?utf-8?B?emdSc2dkWDR5RzBrS1ZabWU1UTlweGZ4U1FKQ1JYd3hiY3IxSmVBMExaZTVG?=
 =?utf-8?B?L2xHRnRIczVRT1dkbytHb1F1eHFBbjZ1enBBaXJVQUtPOVRHU3NhYUxpbzFq?=
 =?utf-8?B?OFhWLzI0a1p0MVJuMWhYaDZWU2I5Vlc0QnBCL1ZMMWpad3pna1Q0SS9nTzRF?=
 =?utf-8?B?UTJkbnRXOS93d1RKTnRlMFFSNTdzVFpZSWs5NCtDMDBLbXdPWklKRVdiWEJX?=
 =?utf-8?Q?GQCY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d99291-49d6-4422-d0bb-08de312328e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 21:47:01.4098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqYbMCZPuNW7J7VQu/3Sfl9mgLQ+euANibCK8j33fq0or7Dlt7ch9UBTsGiwvzSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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



On 2025-12-01 16:00, Brian Kocoloski wrote:
> From: Brian Kocoloski <bkocolos@amd.com>
>
> Pass character "0" rather than NULL terminator to properly format
> queue restoration SMI events. Currently, the NULL terminator precedes
> the newline character that is intended to delineate separate events
> in the SMI event buffer, which can break userspace parsers.
>
> Signed-off-by: Brian Kocoloski <brian.kocoloski@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index a499449fcb06..d2bc169e84b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -312,7 +312,7 @@ void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
>   			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
> -			  node->id, 0));
> +			  node->id, '0'));
>   }
>   
>   void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)

