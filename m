Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52050C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 14:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F344310E6D2;
	Wed, 30 Jul 2025 14:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VoniheMV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3472410E6B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 14:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVQUH90Haq8ev8x4zmgzupqMI0T+dGmGIXz79poZsy4LQ9dySfhb7P8K9IVcNKBI0uq/WTSM0p+reGk29ftJN1d3BAZYFjN/SsvfmCa8gsfMGl6Jwyf3dXuMj98s+B5hk24CYgi/41XdwFIjL07DCWJ4jXchnUXTeFvUL0LolwcGU+Im24mvE2KyfIt4GoQqDRz/0Xd+uuak02PoVyUgneFdHD8UaAqIng4YKOVzmRIHrNKfJhBn5kj5vc1fjDxFGHD89Xh4qEIhr8OQPlOrjxDF6ASL1IjuL/PKZx1QjGzxOOy0wg4gRRhhkyrVG70ROYybhREmt9uk9P3BS5+JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDwL+MoRO+Gst5a33SKpzSpFYZ7SgV1sNIzu9IIS7Wk=;
 b=S9X3ViWXqewybYb+ghnoOr01/85xo9gJMaZwh33OVvXy63J7CPkx0WHebzqm7kVAkcxCi6k/GEEAXAOTRkOiusQ+VNXdnsXwSQSpUgzv3KMgKwRp7b2VrSbW+2H81Ez7AxV1QbvW23m5xBCpOabfZNcbRcjXWbh2Ycx4tCYYmOs90ifARUl/S/3oFxhpb9tqQKPDnj/78xoJCc3MZp3fwtf6yAlb/+JX47m+SmvWV3/7V2v+KMts+o32WMTN8Ei5+qKM0rzsZOoWNtl29/K5NyWCkVLu3bMVY6UMmbfiyrbKE2bEnSKhweVC5UfAbw54Gj88vtWJuaxCkerKJWHdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDwL+MoRO+Gst5a33SKpzSpFYZ7SgV1sNIzu9IIS7Wk=;
 b=VoniheMVylQslrIDuTwZvagwjCU+ve1gfNvPwe8Y6JBla3Qvm/lTzmF3ayE/l7+pMXATbAdoSGcP+M7jrZIXbuMOvqwS6UYO3A1hf5edS1JyBt86IiqIDT8jVQgNZ+knFcgEA6jslnnD43I2+4joQqijidxVCHtDWFz6Wln7UAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:30:21 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 14:30:20 +0000
Message-ID: <a2c6a809-183e-443e-b10f-a271c0e89058@amd.com>
Date: Wed, 30 Jul 2025 10:30:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
 <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 54512c5c-b34b-433c-b8a5-08ddcf759cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEVkTjNPanlNM1JwYzJnMHBxdGkzSXVseUkrVGtzby9ub0RrazhpS28rcHFv?=
 =?utf-8?B?ZVBJMjloYk1xS0U4TUJKNEt4RFpMTWMramhoUVpPVVgzZlJXbnhtRVptdUQ5?=
 =?utf-8?B?VnlrQ09GTmFjOHUzSXFUWXk2YjQ4b2hOYjJPODRCSmE4ZmhHTGlaR2tHelhu?=
 =?utf-8?B?WjZJUXYzS0RKYnZObjE5blJnMUs4R3duSmh6VFBUWGpWakFMKzJlajV5ejNj?=
 =?utf-8?B?NzhaQXlodVNjMDhBWGlzeG9SUU5Kb2NmWTJnR2M5S0c1NHBWdTU5YmN4SjlH?=
 =?utf-8?B?QUhUV2puUWVETnREc2wxYzI1RURpY1JjU3hKMTl2azN5RlJzWW1jcitNUzgr?=
 =?utf-8?B?L2IzWnROK0N6MWxTUlh0UU5iNU9pSWQ1Zm55RG1YeDRjVHRQMTlNVmIrL0VH?=
 =?utf-8?B?c0dJYnkrUUkrMFJMN0dkWXo5WFlSOU5ZZzdzOFo0N2Mvb3dvWUhXdFpHUWQ2?=
 =?utf-8?B?aHIrVjVOcTlveEhWUlVzQnJNVVJoc0t6eW4wQjFRQzk3MldmY3k4cmFtZ0Rs?=
 =?utf-8?B?dDRrT09FZndEbVZCTTNkQzRrZC9UK2xuQUlWOHlIWjFRZ2FheGRpcGxzWnl4?=
 =?utf-8?B?Z2RKSk8rTkdtZzRKQmliZ2RmMjJZOGdSNzJiQ2pSY2VjNDlYZnBuVWpJelZm?=
 =?utf-8?B?b1R3VVYvUzBIbzdWWDVSWlBiRndsbjFTMVlaU2kyTUtFbi9VRGNUUFIwU2pO?=
 =?utf-8?B?aDJzUGE0cXB1Z3dJWEkremtaZ2JXM2YvWlVnckM4VGRiTDlBUGl3Q0cyZ0dM?=
 =?utf-8?B?OW1TalNrclhlZldKTkF4VCtZSUlRMjdTZ2htUjRIVXZOYy8wYUNEc0E0Mnhm?=
 =?utf-8?B?U1FpbGVBN3dHVWtkWXZsQ0t3U2o5YkhkWVlYQTFlakgrdlFkSnVyOVRaYW12?=
 =?utf-8?B?dUZJRVIxbE96bXNDSkVQRmwraUJ0L0I5b1dGaUxmZmtlcm5aVExUeVpPMGxV?=
 =?utf-8?B?SndVSUIxK3BFbzVQL3dTdy93b2R0ZTI0VHZkeE0xaUh5RkdiVTQwdU5OWnRm?=
 =?utf-8?B?NDJwcWNxK0p0Mlp4dHBPMkpVVCt5RHBqWENNcjZueGVpOHdlUkRPOW5EZEhy?=
 =?utf-8?B?cWp1R2VucTFkZWlxdk1QQkZqV0J3NCtTQ25NV0VvTXlpeVhiNjZpeHJPZUkz?=
 =?utf-8?B?VVdBcW5jek1BSEhpejdzUHJmbXh4L3dncDRxdWpPMzd4OXhIUmJrd0I5Qy9F?=
 =?utf-8?B?K09oSi9HSkpCa05jcENxNmljR1JYWWd0ek1OODFMV2xGdXNpUWFLQjdEeXVS?=
 =?utf-8?B?YmY3TkdvdEFqYXZmMHRLZWZ1Vnl1UmlZV3RZQXNLYThQY2s5OWx1allWOWMy?=
 =?utf-8?B?Qk5Bd1RLTkJ1MjltcXRxYVRRU0psS0xNMW83dUlpQWNWMDVnbEFTUWsvbWFN?=
 =?utf-8?B?LzRiZHlSSmRvaVpEa0VIVmNtNW9vbVN0cldaTDRpWTFoNlZ0SCtFWEVyTWFk?=
 =?utf-8?B?cGZBWFV4UEZOYjBwZnNOUEZ0M0k0RHN5ODQ4dkV5ZGpKRDB6bll5Y1Ria3JV?=
 =?utf-8?B?akZSaVpqS2dtNllzVWVxYkhxeVV6NFFtVjFWQTZHc3g4L1ZPQ1NiUE5yNzBU?=
 =?utf-8?B?YzNGc0Y2NDl4TVpjRXR4MjlkTlEzUmJjWU9ySzJhUTFyMTY0b2swbVFEb1Rj?=
 =?utf-8?B?bGpzOGJsN05HWVdNaVl1OVhiTlZqVDZ5M05STHM0eVRsdzF0blJ5bExCVGpN?=
 =?utf-8?B?eUs1NWNybjNKSHZGbEhmODV5T0c5MU1RNzlXckVjRFhRRzJqNmhSNm0zbXUz?=
 =?utf-8?B?NGk5eTlHSmk3OHBXNmlobzdvRDFmOVdiSzMxOGxMazNPc3JUaFErMU9HZk1H?=
 =?utf-8?B?TVdZSW1NbHAvVG1sZzdZZnhDZ2Jwd0hVV2RDc2xCaXl4djFRdDFCaTc1RVZL?=
 =?utf-8?B?OVhUd1Z0ZmVUblBucE9GYmVNc0l2Z0FNcmRXckdoR0VNdHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmY5eDd3SkZpTmZlNFduSlA2dmlvMGw5OUtRZndRdnE5ZTEwZmFua29vVVBE?=
 =?utf-8?B?VVV4U1dwa3VFakxmeHhCWXZ6WVBVeE40NDlLVEZybG1jQmwxNnduRTdTZ2ZD?=
 =?utf-8?B?eGNJQVZYTVgxaFNPTldrUmVWbUlkcTFxeFM2RHk3MkRza2FSd2V5Nk9sOG1L?=
 =?utf-8?B?Y3pDNmR6ejhUSUtOMWp5citKcHU1SXYvblM5dWo0eEVTRm5sbVlzSWdLRnVG?=
 =?utf-8?B?UzlSeTBVNU9SL0FOWDVOelNjbDRneExENWUwTHN5Q3ZPWWFpWW0vUkRrVTBa?=
 =?utf-8?B?ZXJHb3JNRDk0WWpwYWcycGhMUXlUSFlUZlBTekFqZXRGekQ2NVl1TzMwamR6?=
 =?utf-8?B?cVpDbEtiMGJnTG82bWV2N2NWYlFMbVdOeWFWbDFhbFhQNGw2NWx6RzdXd2d5?=
 =?utf-8?B?RStDdjlNdlQ5elc5R3FmWkdBU0hMcXlpdnB4N20wQzEvRzNIR0tRWDhOeDdN?=
 =?utf-8?B?R0lWZWFXbExZTERXaVc4RmNLdU9vczRocVZsZXFyNFJEY1oweDlkcFlNcm45?=
 =?utf-8?B?NXMwTGd1NVZUU0xvYXhBdkNiQ29hZDJVNEh5SkxhVTVaR1IxSEZNZXJXNVA3?=
 =?utf-8?B?SEgwTTJXekZkMm52ZlZGa29vcTJTc21IZUZNcW8vVmV2SHdUY0MxUkIwRGVF?=
 =?utf-8?B?SlkxSnBQb2YyKzVYODdBZW9ydFFXZm4zcVMzQ3Frck55UmRaTVdEdEIvSUNn?=
 =?utf-8?B?dlYvSVU4cko4bzIrWXZpZGp4bkpQRHFCYnp3WkQrTkNKMUZ6NlhjTHB2ckJX?=
 =?utf-8?B?ZVB4TzNJQkk4Witsc3NwZWRoUnZMbmRVS3IrSktpZ0diRkJFYmZDVUJKRlRZ?=
 =?utf-8?B?NVVEemcxUUZEOUVMUzRDYlRGNmJYbGFTUGVkaExqckVnL2tlQXRSUTQwRms4?=
 =?utf-8?B?QW1JeXhJdUgzSWVhdXpteEt0S3hGc2JYYjVEQTFTQUZBM0Q5amRUZXZkOWVk?=
 =?utf-8?B?UXNCUFhxeS9NL1ZPb3B2b3RlSTNwRWNlbGhiU1FIY3lRajgvMnFMaitqU3hZ?=
 =?utf-8?B?aktRaEI2YytHSFJZY2dLVGtoNC8zbmpkeTR1TEsxRnFnRm9nZWREeTRkQzFL?=
 =?utf-8?B?U0R6cFJzYnFYUS93eGp4R2MrSkQwWmYwa09JeXhxSGdLdk9IK3htTk44VW9M?=
 =?utf-8?B?SXd1eHRqMUE1TUpLamVPNEh1QmlZU0U3VUFLRE1GYkpHSDZCOHZ3SGM5eWlJ?=
 =?utf-8?B?VFhkU2YyNnRwM04vcnljT29pWVJMSjFYb3lFRHcySTZ2L0pQQ1N2dTd1dWRs?=
 =?utf-8?B?a0F2cXZrMm5hZllzZXVtbXBBN0FqSjZsK2JLS2dmYWN0VEJBZC9lWGdzdGpq?=
 =?utf-8?B?OTdPMGRaS3grVnN0cEppbS81Y3dTVTQwZGtKU1A3MG1ZNXlORzh6eDFTSFFH?=
 =?utf-8?B?MTUzNWh0eGE2VGhWVHJYR1d0UXJDZUNFaFliZmhFcFRCSHR4WTJ3Njg5UmJx?=
 =?utf-8?B?UDRRVUlFQ25QaWxsTk1yWDQ3VnBBamxoUFJ6VWtERGlqRkR5dWFqRWJtY0RY?=
 =?utf-8?B?bFlRNWJhY2lDaVRDNVFYL2ZrTDFHalFmZm9QU0U1WE1VYTFrM2ZZN2x5NmxP?=
 =?utf-8?B?bDFQRktMS0ZqeTdwbzBrTG50WVFjS0dSQytNdG9EZlk2VjhsMjJiMSs4ZFYz?=
 =?utf-8?B?ZTlEeHpMcmM4LzQwOU93cUFjMVVWNmZKMXZOMDk4K3UzZEw5OEo0eVRZZXBF?=
 =?utf-8?B?TGhIYmFYSUhYRDZadkUzdjdXREJtM0w3ZGR1bEdPZksvRTNOL005M0s2NmFk?=
 =?utf-8?B?MnJPNVRZNTJDMjNVMXJNcVk0UHhHclg0bWlBeDk3aUpsblRtenBKT0lKWXJh?=
 =?utf-8?B?UEZYTmZoSjFoSUZwNTF6bVpZNjZYWmYzOVJuUVJld29EWDd5OWdGdTNSRTd2?=
 =?utf-8?B?RHY3ZXo2T1FWNlhDdEx6MjRNUnRsekUvQkxzNGI5YlI0ZERYYVZBUVNtQnFB?=
 =?utf-8?B?d1ptMDFwUWQ5NTQ3RlhkUDB0SS9GUk4vSndpUGpRSzRHUTVGMEE3NDRxSGJh?=
 =?utf-8?B?UWpialM1dStHWCtKUS96dmNiYTZQVTR0d0tTL21ZZjJrNC90RTUrWXg5QkRm?=
 =?utf-8?B?M2ZBaEg5T2t2YWFKQ25DWFA3eHJibHRWM2xWSHIreVZOc1lWMFpUOGVFb0tM?=
 =?utf-8?Q?yf3UCeFAeJOeIrh041DK1SVxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54512c5c-b34b-433c-b8a5-08ddcf759cd3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:30:20.8542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+9VHE5uSwduEZZkluQvzOy1+Dk38ahUqOKSIhRn5EUtLF7Y+FmbFQBTll/FYJYzsa7EdOn3tpKACxGqz2Ycxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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



On 2025-07-30 03:40, Timur Kristóf wrote:
> On Tue, 2025-07-29 at 14:03 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-07-23 11:57, Timur Kristóf wrote:
>>> Previously, DC determined the DRM connector type based on the
>>> signal type, which becomes problematic when a connector may
>>> support different signal types, such as DVI-I.
>>>
>>> With this patch, it is now determined according to the actual
>>> connector type in DC, meaning it can now distinguish between
>>> DVI-D and DVI-I connectors.
>>>
>>> A subsequent commit will enable polling for these connectors.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++----
>>> ----
>>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 096b23ad4845..c347b232ae06 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -8038,24 +8038,26 @@ static int
>>> dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>>>  	return 0;
>>>  }
>>>  
>>> -static int to_drm_connector_type(enum signal_type st)
>>> +static int to_drm_connector_type(uint32_t connector_id)
>>>  {
>>> -	switch (st) {
>>> -	case SIGNAL_TYPE_HDMI_TYPE_A:
>>> +	switch (connector_id) {
>>> +	case CONNECTOR_ID_HDMI_TYPE_A:
>>>  		return DRM_MODE_CONNECTOR_HDMIA;
>>> -	case SIGNAL_TYPE_EDP:
>>> +	case CONNECTOR_ID_EDP:
>>>  		return DRM_MODE_CONNECTOR_eDP;
>>> -	case SIGNAL_TYPE_LVDS:
>>> +	case CONNECTOR_ID_LVDS:
>>>  		return DRM_MODE_CONNECTOR_LVDS;
>>> -	case SIGNAL_TYPE_RGB:
>>> +	case CONNECTOR_ID_VGA:
>>>  		return DRM_MODE_CONNECTOR_VGA;
>>> -	case SIGNAL_TYPE_DISPLAY_PORT:
>>> -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
>>> +	case CONNECTOR_ID_DISPLAY_PORT:
>>>  		return DRM_MODE_CONNECTOR_DisplayPort;
>>> -	case SIGNAL_TYPE_DVI_DUAL_LINK:
>>> -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
>>> +	case CONNECTOR_ID_SINGLE_LINK_DVID:
>>> +	case CONNECTOR_ID_DUAL_LINK_DVID:
>>>  		return DRM_MODE_CONNECTOR_DVID;
>>> -	case SIGNAL_TYPE_VIRTUAL:
>>> +	case CONNECTOR_ID_SINGLE_LINK_DVII:
>>> +	case CONNECTOR_ID_DUAL_LINK_DVII:
>>> +		return DRM_MODE_CONNECTOR_DVII;
>>> +	case CONNECTOR_ID_VIRTUAL:
>>>  		return DRM_MODE_CONNECTOR_VIRTUAL;
>>>  
>>>  	default:
>>> @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct
>>> amdgpu_display_manager *dm,
>>>  			link->link_enc-
>>>> features.dp_ycbcr420_supported ? true : false;
>>>  		break;
>>>  	case DRM_MODE_CONNECTOR_DVID:
>>> +	case DRM_MODE_CONNECTOR_DVII:
>>> +	case DRM_MODE_CONNECTOR_VGA:
>>
>> This seems unrelated and would do better in a separate patch.
>>
>> Harry
> 
> Keep in mind that currently DC recognizes DVI-I as DVI-D, but after
> this patch they will be recognized correctly as DVI-I. So without this
> part, the patch will regress the hotplug capability of those ports.
> 

How will it regress when your patch series introduces analog support?
Without that there shouldn't be DVII or VGA connectors.

Harry

> That said, sure, I can move this part to a separate commit before this
> one, if you prefer.
> 
> Timur
> 
>>
>>>  		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
>>>  		break;
>>>  	default:
>>> @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct
>>> amdgpu_display_manager *dm,
>>>  		goto out_free;
>>>  	}
>>>  
>>> -	connector_type = to_drm_connector_type(link-
>>>> connector_signal);
>>> +	connector_type = to_drm_connector_type(link->link_id.id);
>>>  
>>>  	res = drm_connector_init_with_ddc(
>>>  			dm->ddev,

