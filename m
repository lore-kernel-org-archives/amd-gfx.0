Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35899C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 22:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A2A10E7DB;
	Wed, 12 Mar 2025 22:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YK1vMeKE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D198A10E7CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 22:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/lCxwOpH7U4ovQyewy4z0jBuCT8sl8iF/utJTGMxCI0szcks9KZWoljD/WMKjVJ0rD0wSjLY+3JdHgfXp3WVcjwDoHVykMUwunTgyubI1xETeV9CaoDut1z6/Bs1Ucs9CyU6S53vKl9pdg8JL/LL1cHCVDwd0WVxC7lttiyyp+Bmmlye1FLeJ63QbJPqZUK3AnNJt0LoNXiCzScIxSFZa4k8/DJM8qNurUhb006F75O5LhlaJ3cjVjsf16XDdMWk8zQoG4xz/GLH5GGgmQUyuF0CBFl8RlG8wwg9GFODId26SKk396FjR1jr7TlIIVlnAGzmMrJ8kbd5pf7v9RPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn9Cy+23UaFBkWkX80p3BZcphilXENmwFJ1iPY/g/0g=;
 b=WdjB7PwPWbKf49H6lR6EPVccluiFJfy7Z9rBsxG8Tp6e3Vj+xezg0pWT5omEETtt+PYmHiU7BoPQ/z3NBY7BGWcDlnXDUgc8nHEWiY6w+qbU/ECe+D0/hHs9OxXvwUH1wyVENtRayJUJaS47Y5n4jt+PtOadoanDdL1idC6qO4DoenMBfnCGmGNzIOvXmkM1hY46EUU0S1TydDwcHyeBbd0rnjaIvI2w6xW4mJsosBVIZwLTbVkMZVp47JeCa0bfjz8hjWlMJP4qM2WL+Zr16Im3bGC7W9RYkeAMq439BR2JAGQ2Uz7kGfLL4Izick/xvxEDkkgyF41H213gTKsjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn9Cy+23UaFBkWkX80p3BZcphilXENmwFJ1iPY/g/0g=;
 b=YK1vMeKEWsBAZubb2cXRSMnS5eITG+pkOP5A9DMBXXlgdSTCSh+p8zPJVZuYwpuJGraw2PcXqygvvc5a7v2icg/g78B+9ov8EYeLJVhNIuVYRMOhGc07q2iLrM8qaEeQ6apFKf250JQmAWJjMCWxYicozzbsSv7XlQdmqWyR0Zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 22:40:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:40:27 +0000
Content-Type: multipart/alternative;
 boundary="------------HlivHbnNJKeC7vYgESULtAUS"
Message-ID: <932fd169-bae8-48dd-8fdd-656ea0683072@amd.com>
Date: Wed, 12 Mar 2025 18:40:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix the race condition for draining retry
 fault
To: "Deng, Emily" <Emily.Deng@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250306060309.3222693-1-Emily.Deng@amd.com>
 <b6c5ca92-b76e-4565-b96b-eaea9c6296f6@amd.com>
 <CO6PR12MB54114B136035E851F1C260058FD52@CO6PR12MB5411.namprd12.prod.outlook.com>
 <81d7d50d-4600-4afa-93de-56c00a59faed@amd.com>
 <CO6PR12MB541112593034D35359E030238FD62@CO6PR12MB5411.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CO6PR12MB541112593034D35359E030238FD62@CO6PR12MB5411.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0221.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6af4d4-f087-44ad-e9b1-08dd61b6e2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2pUbTI1dHc3aEZXektaaE1PSnlKMVhoVTdXUkZKbjI5dmR6ZHI5ZFRCY0E3?=
 =?utf-8?B?bVhuSlZTU1JqTkVwWmlDTWtGZDQ4Uk5nSTk0NTE2aDRLcmUwMDRMU3IwYVJT?=
 =?utf-8?B?YU55WXhlTEtQWERONVhLTVM3K2t6d3F1UEVmYWpFMkV1YlhaeWF2OHplS2pN?=
 =?utf-8?B?V21Ea3ptaG9sblpYREZYN1hqTy9zekViWUxYREs5dzJnRmtPLzVJM0FVTVkw?=
 =?utf-8?B?emdaTHgvNnRXUFVzUlJlVnk1VlNlYWlaWkRKNW1hS0xEUUFiOWgxeFhvZ0FZ?=
 =?utf-8?B?OXhxbVRVZ0Zoa0FHYXNvNEJ4dzR4cGlDRE1yV2pKM1RGYzFFaFhHTHVQV0hF?=
 =?utf-8?B?OWFGbjFxcnNMS1FlSXB2bzZxeUNjWTY0VEpTSnRsY3VzOUlFNU84OWQvc1Jr?=
 =?utf-8?B?L2lIYVZ1ZldoUkVsWUpxTW1xUnBLVm9wdGVqOTEvRFhXMjc5a3VUbmxoY0hU?=
 =?utf-8?B?VTd6RUZWU2h3NWhhMVdoZFZwcDEvMmZNOU5SYlFIWGdKRHhMc0E0bHZSbVRN?=
 =?utf-8?B?RmdsYXdHMW83VldkdmQ1VG9Lc0I5N08zVk8rNFFNNDZJRjBjVGp6cTRna2I0?=
 =?utf-8?B?NU9ZakNaWjFEOHhMUlNDYm5iWjZSQll5U3lGUmFzM2FkUkVDbTlReVpoZ09L?=
 =?utf-8?B?RmlYUGV3SzNZRktTeGxqZVdWK0JFSitJSVRQR0g5eVhXM2tsSUZudVJTMkZB?=
 =?utf-8?B?ZWhqSWZtZFNvNjhtb2dSdkREc09uWWxhZGxvN0ErVWhOWjYxZ2liR3FVdlVv?=
 =?utf-8?B?NHVMWjdsMDN3TGd4VWxiZWF0YXdxOTYzNzYwa05zVVd5cytYbWwrZ0sreVJz?=
 =?utf-8?B?ZXhCeFM2SlAvN0NNSWVJbFVBckJsdlF2SXEvUnlWL1l1emI5M1JidzYvVWow?=
 =?utf-8?B?b1Z2K2xEZ1pzTzhrYWxZTVI2UmdjQ1FCb09FaXNscTBPK09NVWtpNHhKOGtv?=
 =?utf-8?B?WlhrQUc0L1RzblljTzRZY21QcEx6bmdEeVR6NlR3czVQK09MVUJoK3V6VmJo?=
 =?utf-8?B?WTh2V1JmRXdFdStMYzFQOGF4TlpUTWxxVkk0NjhIWlpHSlFURGNVT0lvakdG?=
 =?utf-8?B?TFVMdUsrRjlKUk96c2o2cmY3ZitESHJpMW15TGtGcmZXdENYYk1aUzAxQjlW?=
 =?utf-8?B?bWErTTNZM3BqdXZiVUdJQW5BdGdDcUJsUWxFNkVoQ0VtUkFUeWJ1cUw1Zzh5?=
 =?utf-8?B?bERyOEtVa09ueFMxR0Fyd1FKQmMzaU1aOEs2MUtjVEhhQ3c5TmFqMlNNMWEr?=
 =?utf-8?B?NDhzMko3dmpUSDNIU0VZOVM0QTgyREYzcnRzcmJFdEVQL0xGclo3dndVWVIw?=
 =?utf-8?B?TnpvNTVjK1ZQQTkyWUM5WFQ4dlIxMmVHVFNmZjV5bTJkeWE4M1FYanBBV0Rz?=
 =?utf-8?B?SDFjU0tqQjJJbFpjaEVWVkFjc0lQbVV1QlluNUo5ZmdULzRNYVFHR3FtM0hJ?=
 =?utf-8?B?TnR3UHVWWDd3T3o3dUsweVI3Z09BYW5EZ0JkN0NkVi85bzMyYkFLWEcrUzR0?=
 =?utf-8?B?NkhYRExha2tHUGFBSW1aSHVPMnVnV0k2V1F0ZmZ5RUhQbVNXWUcrQmpxRnBZ?=
 =?utf-8?B?YVNUNWNtcXZMdUUzTXZ4bkpYcC9DbG1ONDBwOWxpZXo0dS9NT0Iwb2V6cGZq?=
 =?utf-8?B?dkZhREhXamZqVHprakhOUUxEekYrZzdKZHpRRzVaODdMTGNjbWtpNlhRM04v?=
 =?utf-8?B?WEtyTDVzaVNrY0syRXk2aGRrQWY2NFRBNWZnZUZKSU5IeVhTaTZCdFltb1VJ?=
 =?utf-8?B?cHZ4SGJwT2JQRHpTbUtyWDhaVVlwbmVldU1YblFaOHFROThBNXFqUG9yNEcx?=
 =?utf-8?B?ZUtsR09ENS9WY0VUcDhpb3ZrVEtsM2Y1akM3a1lWQ2RITXQvKzFwd0pLMi9W?=
 =?utf-8?Q?GFQ+NUVpe1urA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9KcVRhQUdBaXk1TmFGR2dvMzBGb1VtTjhMY0lSa1pPSmhOYmxqdWVtYzNK?=
 =?utf-8?B?T2NLNVQrTUNqMlIvWEswKzZTZzhUMU45MDV5K1k1TVNvVDRNdGRoeFUvM3NQ?=
 =?utf-8?B?REY3ai9KVmtMQklnTlQ5RFJZM1lmNDhONWg1eGpzTWlPVmFrMm1WVzI1M1BP?=
 =?utf-8?B?QVBSV3RrblBJNzlhOVdGekE4MVd5TjNsRG5aVjIvWW0wM3h0d01XSkc0QlFQ?=
 =?utf-8?B?L3h1MWxPVnZ5VWorWlN5ZXZwNTh3TW5Ha1E2Z2M1VUhLQ3l2YW1TblRtTFZG?=
 =?utf-8?B?Y1k5NTFteCtiSjdnZVNpa3EzRm1xN2ZBWWl2TUQvdzV3cDVISFhWcjE1V0Q2?=
 =?utf-8?B?VWFENXZsVXpyaDJwTTl0VVdOakpmSVNUbFJBMmNLczQxQTVLYlhOR0NwZ3Fy?=
 =?utf-8?B?WmRNMjdHd29uYVZUVWI0VEh3dysvRGlITVRwdHJxOWFxcE54TVZPTjZYMENa?=
 =?utf-8?B?QzFBTW5hdHdzdFBmUkpvcWNEY1I2ZEVxOTlyT0FGbW90RkRFSUgxVWZGTFR2?=
 =?utf-8?B?ZXB0QzZXaVVzRW5OQUNDZmJMTmpsRHhlSmJwNjR5d1FlSHZSS2ZoTFZFc08x?=
 =?utf-8?B?bERWdlJFWUlkNjlISFc2cHR6bExYdC9TZ2J5YkJNTlpVbFJCT2VORmh0WGdw?=
 =?utf-8?B?VVdQSHlXajdZVytNWWlLZjV6bVcvVlBuM2Q0allXWS93WGdOWDZ0T2Z4cnpM?=
 =?utf-8?B?SDNoT3JGd1k1TkhKUUJpNVhMYUFnZ3RmYTNwaEErUTFwa1V2YTdJcCtNV3g5?=
 =?utf-8?B?U2pGMThSRW1XSFFxTEM3SThHNlAwNjBEOWNBNjlQRUJSZy9uNmZMZjgrZERo?=
 =?utf-8?B?UVIraG0vcDBlVmdsV2YzSnpTK2x3aUNxdllwSXcycTNCQTVrT09BQUVmZ1NS?=
 =?utf-8?B?VkJ6VGYrM0ZpTnBRdFBEejJmTHRTWW9mVDhETm9LN1RRalY5WlFxT0o3V3l3?=
 =?utf-8?B?d2tsOWl1VEdqTEtwYUdVUHdnNGNWSW43cXRXeTRDWENwSWJscXoybFgwVEZs?=
 =?utf-8?B?ZVdhdXFPTnhHVzUvWHl0eWVWZThZNmQrcGFtbVBybHV0MTFVZUtxZm9keHAz?=
 =?utf-8?B?RENsVkxFMjdPTzdkcmNWTjB2eTNZWnpIN0NZS1IxVUpNaW5VRmlLVnlpa1J3?=
 =?utf-8?B?NXg2dE1xemNEMWYzV01leVpEOGo1N2N2aHRxcE9XMDA4YzhIWHQ0ejh5MDdS?=
 =?utf-8?B?UWtzR2V1WXRFdHIzZjRTOWJpN0RhODhqK2ZTSHliSCtub0V0NzRKbXFFKzg1?=
 =?utf-8?B?ZFV2Q2duM1pTanNCTWZwSVhDemZadzQzSS9LdEZXWWNPNnZNZ0wyNXRQekNi?=
 =?utf-8?B?bjFDTVFmbkpoZzhCaGpTSEJ5VWlXaUgvZEUyTGFGODVUREtqaGtHak15YldV?=
 =?utf-8?B?N3NIKzF1SDh0cnByZnF0ZVgrS1RtQ0dYQzRyNVNLR2N3bWdXRGtlRFUvUktF?=
 =?utf-8?B?RHNQQ1p4eEhOTCtUK2ZVVmZ5S0tPZUVjTFJyaWZXaXVyMXV6dDIrNWF6OHZn?=
 =?utf-8?B?UnlPOGRaMTZtcG5XZVpkQzMraFRDWGtJOUh3YXVxcENBQnM0dEdiaXYxMmV5?=
 =?utf-8?B?UEtibHRxVHY3MnRUM0lPeGtDdmJLai81djl2MjZaampiVGNvODZnQ25rKzYy?=
 =?utf-8?B?SDVlWVdmdzk0QjZGd1l5N2IxNG9uRC81d2xhaVNveis4Nlo3SGxQL2VubDY2?=
 =?utf-8?B?ZXZJQlp4RTdSdWpTSVlFc0ZGWXBMWmlMYjRjMitJOE9ua3lXTWpVN0hqUE4z?=
 =?utf-8?B?UVFscEpiMGMzTjIwQ2VWb0gwZFNJWURaamwzMUdPcU81ZitXN0M3MVRvdlc5?=
 =?utf-8?B?dEsrWE0xVzhSRnNDVDNyUllCR2NtZlNIdzFaSUE0SVNMeEx1cXBzam5PRmdQ?=
 =?utf-8?B?R2dtMldtUmFHODJnbmJRUk1NUHh4OEhtRy9EYXk2MHdKYWN3cWVjR1JaaFA3?=
 =?utf-8?B?ZHFFYWNwVGFLYVJaVGVJR2dCeDIvZ1ZOaEhJTmtEaXovNy91SDJIcnAxOSti?=
 =?utf-8?B?REhjS1FFRXFXUFRiYTZUVnQxNXMvcG9FSW9HK1FxQnRyNjh2dWIvUTExbUhs?=
 =?utf-8?B?b1FkZ3B5QXQvRllsQmFxeXEycXNnL3NpSHB3Mi8vK0ZXaEljNzdmUFZ5OXg2?=
 =?utf-8?Q?3AFicEDHgZqgszPDed1+iR7z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6af4d4-f087-44ad-e9b1-08dd61b6e2ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:40:27.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xwxa6BXU5ea52Q6FUbojLNPnqclGKiFGxMTSUpNmc1LYcdp3L0lLkTHM8tvIx2WnqCIbU73EXlPlbWpNL8nc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

--------------HlivHbnNJKeC7vYgESULtAUS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-03-09 20:51, Deng, Emily wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Saturday, March 8, 2025 8:38 AM
> *To:* Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v4] drm/amdgpu: Fix the race condition for 
> draining retry fault
>
> On 3/6/2025 7:27 PM, Deng, Emily wrote:
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>     <mailto:Xiaogang.Chen@amd.com>
>     *Sent:* Friday, March 7, 2025 1:01 AM
>     *To:* Deng, Emily <Emily.Deng@amd.com>
>     <mailto:Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>     *Subject:* Re: [PATCH v4] drm/amdgpu: Fix the race condition for
>     draining retry fault
>
>     Thanks for catch up and fix this race condition. It looks good to
>     me. One minor thing below:
>
>     On 3/6/2025 12:03 AM, Emily Deng wrote:
>
>         Issue:
>
>         In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>
>           has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
>
>         is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
>
>         continues execution and reaches svm_range_from_addr. This results in
>
>         a "failed to find prange..." error, causing the page recovery to fail.
>
>           
>
>         How to fix:
>
>         Move the timestamp check code under the protection of svm->lock.
>
>           
>
>         v2:
>
>         Make sure all right locks are released before go out.
>
>           
>
>         v3:
>
>         Directly goto out_unlock_svms, and return -EAGAIN.
>
>           
>
>         v4:
>
>         Refine code.
>
>           
>
>         Signed-off-by: Emily Deng<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>
>         ---
>
>           drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
>
>           1 file changed, 16 insertions(+), 14 deletions(-)
>
>           
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         index d04725583f19..83ac14bf7a7a 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>                          goto out;
>
>                  }
>
>           
>
>         -       /* check if this page fault time stamp is before svms->checkpoint_ts */
>
>         -       if (svms->checkpoint_ts[gpuidx] != 0) {
>
>         -               if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>
>         -                       pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>
>         -                       r = 0;
>
>         -                       goto out;
>
>         -               } else
>
>         -                       /* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>
>         -                        * to zero to avoid following ts wrap around give wrong comparing
>
>         -                        */
>
>         -                svms->checkpoint_ts[gpuidx] = 0;
>
>         -       }
>
>         -
>
>                  if (!p->xnack_enabled) {
>
>                          pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>
>                          r = -EFAULT;
>
>         @@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>                  mmap_read_lock(mm);
>
>           retry_write_locked:
>
>                  mutex_lock(&svms->lock);
>
>         +
>
>         +       /* check if this page fault time stamp is before svms->checkpoint_ts */
>
>         +       if (svms->checkpoint_ts[gpuidx] != 0) {
>
>         +               if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>
>         +                       pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>
>         +                       r = -EAGAIN;
>
>     We drop page fault because it is stale, not mean to handle it
>     again. if return -EAGAIN we do amdgpu_gmc_filter_faults_remove. If
>     after unmap, user map same range again we should treat page fault
>     happened at same range as new one.
>
>     Regards
>
>     Xiaogang
>
>     Sorry, I didn't quite catch that. So, you think we shouldn't
>     remove the fault from amdgpu_gmc_filter_faults_remove?
>
> I think return "-EAGAIN" means a page fault with an addr and a pasid 
> is not handled this time. Same page fault will come back again and kfd 
> will handle it, so remove it from filter to make sure it will be 
> handled next time.
>
> Yes, I also think we should remove it to make sure it will be handled 
> next time. From this point of view, it should be removed from filter.
>
I agree. Without removing it from the filter, we would ignore later 
faults on the same address, which would result in stalling the 
application indefinitely.

Regards,
   Felix


> Emily Deng
>
> Best Wishes
>
> In this case this page fault is stale and we do not need or cannot 
> handle it. There is no indication it will come back again and we need 
> handle it.  I am not sure if should remove it from filter. I just 
> concern if should return "-EAGAIN" in this case.
>
> Regards
>
> Xiaogang
>
>     Emily Deng
>
>     Best Wishes
>
>           
>
>         +                       goto out_unlock_svms;
>
>         +               } else
>
>         +                       /* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>
>         +                        * to zero to avoid following ts wrap around give wrong comparing
>
>         +                        */
>
>         +                svms->checkpoint_ts[gpuidx] = 0;
>
>         +       }
>
>         +
>
>                  prange = svm_range_from_addr(svms, addr, NULL);
>
>                  if (!prange) {
>
>                          pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
>
>         @@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>                  mutex_unlock(&svms->lock);
>
>                  mmap_read_unlock(mm);
>
>           
>
>         -       svm_range_count_fault(node, p, gpuidx);
>
>         +       if (r != -EAGAIN)
>
>         +               svm_range_count_fault(node, p, gpuidx);
>
>           
>
>                  mmput(mm);
>
>           out:
>
--------------HlivHbnNJKeC7vYgESULtAUS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-03-09 20:51, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB541112593034D35359E030238FD62@CO6PR12MB5411.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
          [AMD Official Use Only - AMD Internal Distribution Only]<br>
        </p>
        <br>
        <div>
          <div class="WordSection1">
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
              <div>
                <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                      Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                      <br>
                      <b>Sent:</b> Saturday, March 8, 2025 8:38 AM<br>
                      <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject:</b> Re: [PATCH v4] drm/amdgpu: Fix the
                      race condition for draining retry fault<o:p></o:p></span></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">On 3/6/2025 7:27 PM, Deng, Emily
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <div>
                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                  <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                            Chen, Xiaogang
                            <a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
                            <br>
                            <b>Sent:</b> Friday, March 7, 2025 1:01 AM<br>
                            <b>To:</b> Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                            <b>Subject:</b> Re: [PATCH v4] drm/amdgpu:
                            Fix the race condition for draining retry
                            fault</span><o:p></o:p></p>
                      </div>
                    </div>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <p>Thanks for catch up and fix this race condition.
                      It looks good to me. One minor thing below:<o:p></o:p></p>
                    <div>
                      <p class="MsoNormal">On 3/6/2025 12:03 AM, Emily
                        Deng wrote:<o:p></o:p></p>
                    </div>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <pre>Issue:<o:p></o:p></pre>
                      <pre>In the scenario where svm_range_restore_pages is called, but svm-&gt;checkpoint_ts<o:p></o:p></pre>
                      <pre> has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu<o:p></o:p></pre>
                      <pre>is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages<o:p></o:p></pre>
                      <pre>continues execution and reaches svm_range_from_addr. This results in<o:p></o:p></pre>
                      <pre>a &quot;failed to find prange...&quot; error, causing the page recovery to fail.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>How to fix:<o:p></o:p></pre>
                      <pre>Move the timestamp check code under the protection of svm-&gt;lock.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>v2:<o:p></o:p></pre>
                      <pre>Make sure all right locks are released before go out.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>v3:<o:p></o:p></pre>
                      <pre>Directly goto out_unlock_svms, and return -EAGAIN.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>v4:<o:p></o:p></pre>
                      <pre>Refine code.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>---<o:p></o:p></pre>
                      <pre> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------<o:p></o:p></pre>
                      <pre> 1 file changed, 16 insertions(+), 14 deletions(-)<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>index d04725583f19..83ac14bf7a7a 100644<o:p></o:p></pre>
                      <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                      <pre> <o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this page fault time stamp is before svms-&gt;checkpoint_ts */<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svms-&gt;checkpoint_ts[gpuidx] != 0) {<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,&nbsp; svms-&gt;checkpoint_ts[gpuidx])) {<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to zero to avoid following ts wrap around give wrong comparing<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;checkpoint_ts[gpuidx] = 0;<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                      <pre>-<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;<o:p></o:p></pre>
                      <pre>@@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);<o:p></o:p></pre>
                      <pre> retry_write_locked:<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                      <pre>+<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this page fault time stamp is before svms-&gt;checkpoint_ts */<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svms-&gt;checkpoint_ts[gpuidx] != 0) {<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,&nbsp; svms-&gt;checkpoint_ts[gpuidx])) {<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;<o:p></o:p></pre>
                    </blockquote>
                    <p>We drop page fault because it is stale, not mean
                      to handle it again. if return -EAGAIN we do
                      amdgpu_gmc_filter_faults_remove. If after unmap,
                      user map same range again we should treat page
                      fault happened at same range as new one.&nbsp;<o:p></o:p></p>
                    <p>Regards<o:p></o:p></p>
                    <p>Xiaogang<o:p></o:p></p>
                    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Sorry,
                        I didn't quite catch that. So, you think we
                        shouldn't remove&nbsp;the fault from
                        amdgpu_gmc_filter_faults_remove?</span><o:p></o:p></p>
                  </div>
                </div>
              </blockquote>
              <p>I think return &quot;-EAGAIN&quot; means a page fault with an
                addr and a pasid is not handled this time. Same page
                fault will come back again and kfd will handle it, so
                remove it from filter to make sure it will be handled
                next time.
                <o:p></o:p></p>
              <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Yes, I
                  also think we should remove it to make sure it will be
                  handled next time. From this point of view, it should
                  be removed from filter.</span></p>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I agree. Without removing it from the filter, we would ignore
      later faults on the same address, which would result in stalling
      the application indefinitely.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CO6PR12MB541112593034D35359E030238FD62@CO6PR12MB5411.namprd12.prod.outlook.com">
      <div>
        <div>
          <div class="WordSection1">
            <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
              <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily Deng<o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best Wishes<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p>In this case this page fault is stale and we do not need
              or cannot handle it. There is no indication it will come
              back again and we need handle it.&nbsp; I am not sure if should
              remove it from filter. I just concern if should return
              &quot;-EAGAIN&quot; in this case.<o:p></o:p></p>
            <p>Regards<o:p></o:p></p>
            <p>Xiaogang<o:p></o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily Deng</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best Wishes</span><o:p></o:p></p>
                </div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>&nbsp;<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_svms;<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to zero to avoid following ts wrap around give wrong comparing<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;checkpoint_ts[gpuidx] = 0;<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                  <pre>+<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_from_addr(svms, addr, NULL);<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find prange svms 0x%p address [0x%llx]\n&quot;,<o:p></o:p></pre>
                  <pre>@@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(node, p, gpuidx);<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r != -EAGAIN)<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(node, p, gpuidx);<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmput(mm);<o:p></o:p></pre>
                  <pre> out:<o:p></o:p></pre>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------HlivHbnNJKeC7vYgESULtAUS--
