Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC602CD98F6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 14:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550DE10E076;
	Thu, 18 Jun 2026 14:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKiKTNxs";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9FE10E076
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 14:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+mwJX/ObBQLC51Yh3ZOWiFdEZgipg22mM1BsJJ9fvfb4ak4qTHdbDSdGAXivDD/IgLwoYlUhWpu+YclS61cGjfCdoZTZCJMCVMmKtVS+vNA8Khzoq7Lq91ePWEluPrbE6h1yHqsJChjpGkcOQiOpSV6Y5Qn0tRLxL3YBFO1uDfR1VEUs0sX8bna2sImFVACb/ofiky0S1lhGnFr/aWZbdiyPRAcTB4mZejcGoKdzZ5F5ouM3SwxefxxFPMjXWJg2Fl50hnS+DN4zElkk0JRWVdfKci2RMcVHik+5sLXYaGw/T8En733k8cp68O7Uj0GJCbAJn7gerr27p87+kEhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIzoqDsMsU5z6pab1TLMOynca2mVq4XkX/jt9H5i0OM=;
 b=VhWW7LtpAoi+72xIUPoXpJ4QxLCd8fxgmatNwcMJt6zrKI6nIlFzmgRayi6NYHXztqt5/GibbNsAeixaHX/O3xxNPxRN+QR24IRzfRxiPR1K38C/ArKIxQq96zaleszUXPCwOvXBkgOQ/WmN9tfAMhsw5O78lwqEjXC7lZPv3jOQGmkG41nnO4AsnOYtXby7GGephGH+2kmbmBeLirsjRoM0DfrIrKbI+KMhbhiNOIrpijCHgGrA8gqVo5UbSnw5VXliU3Qra4Kld3f9oX7vW+ORyWvQke5U9jzWhVKW/CfKwtE9o2sFJ6CKwemo8MPq8rOfoVZZcTVTo9v8IdUuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIzoqDsMsU5z6pab1TLMOynca2mVq4XkX/jt9H5i0OM=;
 b=nKiKTNxs7m3soYbg11nMH7/MmFgV8Tzrpit3sserYlY/IKUttzHNWwVY2n+FI4mhLJmr9L8UMQCzH4hxCb/KIuP0K4D6eHh0BG3vNtdNbB3owR6mlZayudv0V2bim9fofUwIUGrfKxd01ST3y5rC1XOVKaBEOGR5cUm6FKToDx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by DS0PR12MB7898.namprd12.prod.outlook.com
 (2603:10b6:8:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 14:52:13 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::3f27:84ef:8979:ce50]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::3f27:84ef:8979:ce50%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 14:52:13 +0000
Message-ID: <ef3e6975-bce8-40d5-ba82-7062bd0d122f@amd.com>
Date: Thu, 18 Jun 2026 10:52:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdkfd: use pasid to drop non KFD irqs in v12
 for sq intr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260618121109.2794537-1-sunil.khatri@amd.com>
 <20260618121109.2794537-2-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260618121109.2794537-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::6) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1927b96a-54c2-4e3b-2c7c-08decd492e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|5023799004|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lc461WDt+KRcYCz2g1t0Pp84gMtWxBTKYBPRP2EY/H98u0pOGbPNSDXHsKgZNymwpeq+N5HC6YZWFRQwjVr2cZWjk0s6jc0sGAdfv3YE33D+Biy6+j43h+VqArZTbSioSd3wp0690ykeqUX0NOgn9WNWromonopVHt3xnuyuhPC1Lzo4MhOgp3w0O0qHmw+q/a8auky7uQ8D8LRtWtQrdgrlZst1vUAo+hngRGbUb2a7leu4wBqzChoq+cFktDIWN4GfzOcZ9lwmRK6Lcnm/SXp9B8cOElUNyxibWxwmnDzb6hqbkIt4lfay6ou0ZOEsZ1T6L/wnhqExkNGs3xZ92ZVOKr3AuECMK9RUIwYLiRXCJXHtMlyM9HeRZ4CGRWWjT4I2cIxH6fvOB5px8cUm9fhW2SmvUL8lMorl9uK5SVTNIE8kwqPvsplWn5HThWT6A5BSlUUSWZk/9MgI8Bwuyq3swcRNDj6bd/AFtIc4MzSh/D5YhhR53f7eL6yOtdxmwW+7EbZGyfFOowT7c5TNFUfxL4rIYc3Wt9ouou2D49pgFSXUGzCxUPMM5LZrmzshx+Nt7W1Np3GzkUkn4/fyeOtTllNmUwC0YIUqKGO6fOhXUzulg7zp+8cM2MOBwq4X70L3vktSeXFKGWGlCe+LyaboXiTCfvB2EwKHWbhYmbZLkZuc1URUPin9aDV2Hn3A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStmZWR5WU9qUktuUHpYbWE1M3paYi9RNWZheU1tR2RiTndQY2VqbGlEckRw?=
 =?utf-8?B?OUtSRUNMS0pPOXJvSGQreGdIalJmbUNQM0hiTTF1aUM4aXZJT0Ixd0pyMlhK?=
 =?utf-8?B?eUlaUXE0dDFoQzA5bEJldWVxN3FGY1VPemE3d2hWNmo0NjFlaFE0aTl2VC9E?=
 =?utf-8?B?ZzIvaU1ZdkU0cHZuNlZIendGTVJIalB1TWt2TlRlTFp4a3FUU3lBUi9qakI5?=
 =?utf-8?B?SGFiMlkrVVRVamhlaEdrQkR3aTF6dDRrLzVVZjVqQnFsYkJDR1RKaU5MK0pQ?=
 =?utf-8?B?R2NwODBFZXZZa3VoUk5OVXNmQmx6NzV6cTB1dHlCVGVQSHMzYXZNL2k5M0VC?=
 =?utf-8?B?RnZPMWJ6UDE3TXR0bHlESHJnNW1DN1lJdk0xK1A1VnBTQTVESmpEZ2ZGZWhB?=
 =?utf-8?B?VDlCSmdDeHVPWTNZSGtiV2laU2UvV3U4WjRiZ0E3ZzhrNlNOUHZVS3hWY2RF?=
 =?utf-8?B?L3lnSVFEZkhydWszVzVvK0NtWG5YYkhuMlRlMmVrWFJCQlYzM08wV0JhaDZy?=
 =?utf-8?B?RDQxRHI1VDkrVEEvdzJLUkIyS0RjUk8wZ0RoTStsOG9ZYnRPNDZyWXN6VUVt?=
 =?utf-8?B?c3dvNjlrUWtNV2Rta3pOSWdQMUxWY2Q2UmxlWGJ5WUZEUFNjTXVRVVhIK3Bm?=
 =?utf-8?B?b3FrWWg2czdKMFEwbktBdDRuOFlrSzBTbU9EdGdwUzd5R2xKKzE1cHo1WTVj?=
 =?utf-8?B?WDRSbnFDN2ZsbG1QblQwRnpRT1VuVEdWTitsTnlDeEZ6YkYwYXNaS0x0Z2pr?=
 =?utf-8?B?YmhDRDFFS2JqclBoM0RsMHFzaUJKbGxxQll5ZlpHNmUzQ0Q2YytpVXQybUlB?=
 =?utf-8?B?L2VkNDFqQlVVSjhET2piWEFOQ0NHaUVjV0FMMUpSODdabC95SmhnWVU0NDZ5?=
 =?utf-8?B?WkM4MGJST1VJcGlKLzhQSGNLM0l0azBmdkw2dHFmZnpTZTRhaXZDSDdmRFpq?=
 =?utf-8?B?YzBvWXkrOXhKbzdqdEFoanIxbTdUcTRjTWswaW41djUra2xyVWtORGxFRklM?=
 =?utf-8?B?QzRsZEs5Q1FlYW04WDJFU0ROWUJiS0hkcVRXeVRsZmdPcGRBbE1xR1hRV0Jq?=
 =?utf-8?B?V2dhR25kNGptRFdUbUpmaDQ1L3ZjUHpLaW9NcnU5eDdQbkdhanRXZzYwVjVX?=
 =?utf-8?B?YitIQy9lSUJ5b0N5bVdLeTZBMHFoYVliMmk1dzRvQUJ4REl3bHFKZ3BrcitV?=
 =?utf-8?B?WXlUUnZQeGNvVWNUeUIxZzYxekFIaVR1eFRsUVhjWEtlSGc2TkllZUY4aCtY?=
 =?utf-8?B?MXNtTXJGTkloV2tXek1QVGpKTkk3TXZJZGhmWE8vQjNhanlNQitWaWtlRzRm?=
 =?utf-8?B?c0NZeWFiYW45UlR1c0wzZmFsQjJ3QWUySi9vOVltN2F0NjYrbzVYdVBtSllM?=
 =?utf-8?B?VXd4bHZQMmMzV3lhNXpKUENjSWFTVlhzRzB4TkFUSzBwcWZYSTBLbzBTL29Y?=
 =?utf-8?B?b2tjeURqZklTaDFKdFlZYjNXd2ZsakdvRzZTTnVtYXlWSnBwV3pOaVJOSnJV?=
 =?utf-8?B?dmljamt1dkhvdEdMNThCb1B2QTBybks3Qk9WRGlGSXVmeUY0eEZUZ0JITEVD?=
 =?utf-8?B?TWtQQ2hldUFZckpnSU81YngyNEFYNjJYZHYzeDZ2SUZLVkw4NFFTbFFLcGtV?=
 =?utf-8?B?cXBkUG1UU0lQMFVoRTJIK0Q3di9pWDFFRTBtNWowc2UyelNJa2diVEdtcnVC?=
 =?utf-8?B?T2FGRFVkbEZCbk9jNHgvRHMycVhTZkcyOURzdXNKMi9nZjNVU0w5aXhTWG9h?=
 =?utf-8?B?WkRMUENQWUMwT1JuRjRUZjF1QUM3QWY3ODJxN3BmdXdEZ28zdlJublNrejNx?=
 =?utf-8?B?RXhZRUo0K3ZzU2NyY2ZmSHRKdHZpSnRjbkkxQWpsSVdBNUFwL1YxeFA4aVQ3?=
 =?utf-8?B?VUtrTld1NE85dXVqOHlrVnB5cS9WemxxeHdCTTZPWkxOSW9oMFVmRHdoWE5X?=
 =?utf-8?B?UWVzMnVab2E0UXRJemxTemgvNzFGd0RRWGRRNjJBVXdsOCs5dFIyNXhqWjQy?=
 =?utf-8?B?TjJHTVRmWEw2QytFbVVDRnJJZjRpbTU3SEsvd1E4NStuS2g4YW9XN3FCZGJE?=
 =?utf-8?B?eFM1bjFacmRFY1dsN3FiVVhjMDlVTU5BSUZEbGUzNFFoZ0ZYQkd5NTZlM2Vn?=
 =?utf-8?B?c3FYakVNSUdPSVNDdlhRVk5pSy84L1RjeWMyeFdwTlZDTExMeGRLTGRON0dn?=
 =?utf-8?B?ZFh2UlVhbXRkT1oweG1WY0I0bHJSVHhaYnFJbWFEbTBMSWF5SlRmL1JvOVNV?=
 =?utf-8?B?VGV4NjA0ZGpjUUZVVFVlVytTa2dyZXl6T1ZpSjdzcjFoa2F1QVkyOWJKRCtQ?=
 =?utf-8?B?YThMa2phRzBZUm8wT2pOYTBNblBaQlk5M3VsV2FmOUIrQmlHcXlvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1927b96a-54c2-4e3b-2c7c-08decd492e45
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 14:52:12.9498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1KgWoee4xgrdC2QQbzQwfqY6DFGX3mD1JU7Pt+4krl7lOca7pLBLDk5RAToQOvsiDHQLYe5AO1JObtCgrYx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

On 2026-06-18 08:11, Sunil Khatri wrote:
> With KGD userqueues the VMID's could overlap for userqueues
> and KFD queues and due to which SQ interrupts of KGD process
> are routed to KFD interrupt handlers.
>
> To avoid Noise of SQ interrupt for KGD user queues use the pasid
> id's to identify the non KFD processes and return without any
> interrupt processing in WQ.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

The patch series looks reasonable. But now every interrupt needs to look 
up the process from pasid twice. It's not very efficient because that 
lookup is currently a linear search. A bike-shedding suggestion:

Keep the kfd_process reference for the whole interrupt handling function 
and pass it to the different signaling functions instead of the pasid so 
they don't need to repeat the lookup.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> index 0da7e1db55c9..e02f63c0c845 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> @@ -296,6 +296,7 @@ static bool event_interrupt_isr_v12_1(struct kfd_node *node,
>   static void event_interrupt_wq_v12_1(struct kfd_node *node,
>   					const uint32_t *ih_ring_entry)
>   {
> +	struct kfd_process *p;
>   	uint16_t source_id, client_id, ring_id, pasid, vmid;
>   	uint32_t context_id0, context_id1;
>   	uint8_t sq_int_enc, sq_int_priv, sq_int_errtype;
> @@ -310,6 +311,14 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
>   	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
>   	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
>   
> +	if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
> +		p = kfd_lookup_process_by_pasid(pasid, NULL);
> +		if (!p)
> +			return;
> +
> +		kfd_unref_process(p);
> +	}
> +
>   	/* VMC, UTCL2 */
>   	if (client_id == SOC21_IH_CLIENTID_VMC ||
>   	    client_id == SOC21_IH_CLIENTID_UTCL2) {
