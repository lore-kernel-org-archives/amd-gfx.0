Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF89E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 09:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B9710EF6E;
	Fri, 13 Dec 2024 09:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YTolhmq6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EE810EF6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 09:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3Vxo40wXIknTzS1X3wU2S6VV9srQYqwmTUgfLps5Wam/j/aoX4owEYoj6XYQLsI3yGtKjx0ym1XjX9XatGXIGWB67NR6ywk3rCHp25JE/ZQmQ1WzSpeX+3Rur9G6GTx+0Hte8Z+rviLQWI1PM9RiOYvQ5nI27JyuCxurP7dVMIhaCuLMDGvXdCOTzMRVI3bLarX4BFZOEnHyeSy8pJ2me9JAGx+nc2MJbY+ZtOHVxKxriPIeMwvIk9TsqAGPotifJrxZ4v5nf8iqHJ9+D/IZ9iF8oRaX39jzCibqI7xvTJRV/HFfX5bEYqTMJMrKuZ+8v0m1HZdBFtjc+K/dXzi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9Lrd5aAnEj1o63Nwk2vDEZGhTClNp9eJmTiltxZv80=;
 b=jbuTUcuo+0OPIZ9JGMjP+SDjqJh19nAQsgLp+EwleuvP5Dds2XCKzyFIYl/SiYWRDA3lPCHjQk6iKjf2eVqKq/7z6M4/HOkAv2IcEAYl8Rwq7JLmWNZggIvf6szfi4jd7Wn/XRMP2NFuhQgrB3foy0AOIxTTKa0p31P4SyF84NSCzR9GFBVC46HrEHm3wivFH7sHmJPCKHqxufa+KE5dB2jw+uUrCX68XAjkJEZeXf3zIahzW5avBtpgYbGYtxfgctLiuzmL8UXQe+1xheLoJf0QJA7qASO5RhRi1ChiX3a1BwM8VsWHHpqYYJojecqDxGKza2IDDDpERXjoaq0Aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9Lrd5aAnEj1o63Nwk2vDEZGhTClNp9eJmTiltxZv80=;
 b=YTolhmq6MmIZsnBP5E+c9V8Bla2JVkXuqEnRpnu/kbW0kWH27A16zwGiFIrNKGVd/V2BlqjdJIwnDlL8LBPUfJGT5IivpsJ2+e+2Ei1wTnqq+DzsjgS9icoizXurG/ddMvRThmz+1B8Ah66nRN+rc/8KMINEpG3uJHtQW4iMIRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 09:03:13 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 09:03:12 +0000
Message-ID: <ecdece2e-3a6a-41ee-8384-7b37a600e114@amd.com>
Date: Fri, 13 Dec 2024 17:03:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
 <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
 <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
 <d3771cb9-124c-409b-afc5-1e6db3714504@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <d3771cb9-124c-409b-afc5-1e6db3714504@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b5159d50-b8cd-4022-eae0-08dd1b54f8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?encxVVlxK05QcG9kVGl1eGh0OUlQcDdtRGhKWnZIcEoyaEgxL0VUbzFpeVpL?=
 =?utf-8?B?SkloV0xjd1EremJJaVlrU3JmbUJpTFVqeTFZOWtFTTZiUndBTnIrYmdBSWty?=
 =?utf-8?B?VkpBRGdqYjZtVW1HSGtBRjZiS2ZZM25waEZnNTN2bEZpMkZrVVpzTmxGOWRv?=
 =?utf-8?B?NzdSYXFIQSt1SzR2NXp4SnFJV0RKenlPR1gxOHRiZDhWdmRQYmwvMnd5bEdD?=
 =?utf-8?B?anVlSjBOeCtuazVwblV0N1ZLRFZqRXo5WHZMZWVHS0draGdTZkg4cDdVdXNq?=
 =?utf-8?B?OEpCUzd4T1pxTmNJa1B6WU5vZEYvdVRUdEozVFlYRzNSUEhIQVozWkVJSVpx?=
 =?utf-8?B?WERlWTJHWlRrelRUYWZjZklVck0xQWNwSXMxaFBXaG9LdVJDM3JhQmZyajFE?=
 =?utf-8?B?TEwzdFEzNXhEN3NQTFM4TnRqRjVMOFNrZkwveS9IVThDbU5DTWxtRTFjOEFr?=
 =?utf-8?B?Yk54TzIwKzdxY2ZNbzM5UkdzTVNFNnJIdHE0TE1ZK0VWZ09EemZsNFd2a2xO?=
 =?utf-8?B?NjNSaXNoM2J2RU54ZGxERTlPbHRZbmkxMDhSNVk3cC9pdTJKZjljeHQ2VXBY?=
 =?utf-8?B?L0QxNmI3RDNCSm1tQXR3RXZhMk9KL0cxQXRYeTZnS08rZC92SFFlYjdUQVZ4?=
 =?utf-8?B?SndSamxLVGt5SGlMYVVNckNYd25XR1lLRUE2enRvOS9lSVFGS0ZSREc0Y1M1?=
 =?utf-8?B?d3h3bmZpaEFTSk1TZmtFOEdEeDZSQlBXY3VWR1JOWkVEWkNuc1dacElqZlNL?=
 =?utf-8?B?VEt2OXIzNVd6bVF4by8xQVpZd3JYWUI4WjRxbkVBTCtHNzZWYXNEOHNzWWdU?=
 =?utf-8?B?YkYyNHYvZUZaazFUZnVNdmt1UWpkVkdmMGxQbEViSy8zNVpYaHlRRTJaYkRJ?=
 =?utf-8?B?UmM3WFA1UzBTMjU1dWZSM2MyTEczdjhTZ0w3c2JhK240T1owdzl6eWtRY2Zw?=
 =?utf-8?B?aXM2WEZldzBNN3VEZGtoYXpmYWRTNmZNUG5RNC9yTnIvZ1NmcTM4YUh2TDFl?=
 =?utf-8?B?VlRCSFpwOTF4R0o3djVYQU9GYW9WT2c1NGZ3VXV2QkRIeVBjQ0tieFBjc1Ir?=
 =?utf-8?B?Yjh0d3JkZWFJUEVOMTY0NVoxUjR6cFVDeXc4L21GczVBZ041MTV3OXhrK0pX?=
 =?utf-8?B?Z2dEU1Eyd0xuQVVYUlNpQnU1ZnlzTmhIZ2tDc0FyaGZYRG5yRStrc2xnTVlR?=
 =?utf-8?B?bWdLbFVpZlF0dmFWeS8rSnpZVmF1UkpaRkticHl6ZURhR2FQSWJnYk42aVh3?=
 =?utf-8?B?OU5zYXVtdXVpTTc4UUhwbklJdGphOHdPTEdadTE3UDJ0Q0xPUWdTb29MNlJQ?=
 =?utf-8?B?Z3VDNWNMb3NMdnlKREg4SXlBbEtxcjF2djc5aDJFQktrSmxFS1ZMRjU5R1hz?=
 =?utf-8?B?ZjM1QmkzaU82WVFEQkpIdmxCRHlDb0prdzhDRWdrTUN3QTd3alFMZlF6VEkv?=
 =?utf-8?B?S295bUxzTkt0bGl5cWN6am4ySnFxcENVR0ZJK3ZIeDVDYnZpWDV6TkYxSnpR?=
 =?utf-8?B?aWgvT1FSS0U1QnMvSzNHWXdtZE5XTUYvdWpJb3RkMDRhYzlDZmF5Mk5vaXhP?=
 =?utf-8?B?Z0IzbHVBVzEvMFpWQ0lsZXZMQkNGZHU2cnhiamE3RDJpeUp2NmNkb3Z5WXpz?=
 =?utf-8?B?bVJTOWVIcUFTOTNTVTUxSk1FR3dZNnBrVUk1T3FrZTVwQUE3REpoTWh2Mk5l?=
 =?utf-8?B?dUpkeWxZTGhXcnVCdWNsdmt4MWlmdjhVZmgzTkw0b1BtQnVmRzcwVGtQVlB4?=
 =?utf-8?B?Zlk3YUhORkhJMmtyd0ErR1J3T0lVaU83b2FkSktHSVcxaVFhd01lbDZOWmZl?=
 =?utf-8?Q?CEVgkPvh3DZEXYKRICtw9wRfay9zmbo270ddA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09YZEc5YjJ0R3JWdVUyTTdzR2FPZ01hUFdEbUJmRG5iQ3VvbzhOVE80Z2po?=
 =?utf-8?B?bENhVVd3cGRpVUJCSEhlZFpMaWZaM21sc3RnaTNaaVR1TE0wMzRLQVl2aVg3?=
 =?utf-8?B?b3BMaXVKS09Ea1hCdHpYUFA5c1dqNkdSOXVsNTc1MFIwT1d2VGRXNmMrKzZh?=
 =?utf-8?B?TjhPUDFWWGdEbHZDcUI5b2V4QlBlMm1Gb2FFSXBWcTZld3RxQllBRFVDVE5Z?=
 =?utf-8?B?QnRhV0xCbWJFNlYxQlFKMHJ6TThLVElnZkJtYUl4a0pWZWwrcUJPb2hUWm1p?=
 =?utf-8?B?ejNYMEVnM2tHVVl4UkdHVmcxRUJxbk81REJ6cnhJS2FycVF6V1hDak1wSlc0?=
 =?utf-8?B?NVErK1A0VFhLWERBZFMyUDF3YWxTVWdpSnN5Q0RiWFp1WWxSQlgrVlNVUkUz?=
 =?utf-8?B?ZTZmZzBSUjNINTEvQkxCRXJrUVJNZk41azNSZDB4MWRxdmdJa0YrOGgzL1JE?=
 =?utf-8?B?cUJpNDY4WXU5WGlDVFhUTEp0eUlQdmNDVWFNaStoNTNWdTNJME5jVWlTaDVG?=
 =?utf-8?B?MmVUZXl1ejF3WTJ6MnFIT0pxSW15bFpjTkRKZG5KcG9WTWVOaUhpYXhFODg1?=
 =?utf-8?B?NERiK1lmU1dTcy9yK1hOR1FEdDhSYjBWYW9ReTlCT1VNUmdOL1ZBSFdwNXpl?=
 =?utf-8?B?a2JTK2ZpTUFyMjh4SUtQNFpFc0NxcFhpTUdyVEhTUTN2WFNkTzF0OHpyL2tv?=
 =?utf-8?B?a0RYblF6VXdzc3JveEZOWllEWVlpS1pHRVB3eHk5cU5MalNLTlNDOFVXN0h2?=
 =?utf-8?B?N2RkbHFYQUJNKytDdHlWeHJ1QU1wZDE1ZVdHM0NvWUUyVWVyQmxnQ1RUOHpt?=
 =?utf-8?B?eVBpcU9aVUE4YktVOTBCckpZa3FzMVhVQ01oYi9XcWd5QTdlMk5wM2wycVJD?=
 =?utf-8?B?SThWcWpRODdUcHI0Y3lsMXhtc2M1QXBPS3NVVjhldmhRekFOVThQVS9pc2J4?=
 =?utf-8?B?UCtRSkw2Zks4cXF6MGRGT0NNVm9jLzBSUnhWaU1ubXJVeGZ6Q0pBcVBTbGZr?=
 =?utf-8?B?K3QyZDZmTEU1UTAyd201RVgyV0N6Q2J1YktoMWFydmpvbW5jV3Bwai9OMzRx?=
 =?utf-8?B?aVNCRFU5b2VxMjNES1pUbFNEdmpIc2l5SWFtTVBzb0M4TWF0SmdzTEx3VXho?=
 =?utf-8?B?T2w3MXR6SDBEdlE1UjVQSjZGRjV3eVZSUnNxSnh4WTZkQ0RSTDR3NkNwR3oz?=
 =?utf-8?B?bnpnM29DNkMvbFlvdHFJWFRBbm5LMHM1UVBNamNGc1VFK1FlWVdVUENGRk1C?=
 =?utf-8?B?OTZSL0p1Zkw4TUpVeHFDbXNBNE9ER002Kytna0dZbi9vNVBqWGVkajV2RVFV?=
 =?utf-8?B?WHZtSmFMNWdDK3hsVDVOcFdUZmhMUklHZThWdkk4ZEV2ak5SdG1KK3VBV0dJ?=
 =?utf-8?B?VGE1dysyWTR6SG90YnVUZnRSems5ZDA2V1pNVFJ2aElqWDl6RWRKU3dTTEtn?=
 =?utf-8?B?MUM2Zys4V0cxYUE3M1M0SVNEeXJ1bmxkREZWNHlhZHJtVGlhODllcXY4Nk9U?=
 =?utf-8?B?TEY3UlNscUoyeSt1SWdrcHV6UVNoc3pFck5jM3d2TUczWTFFS2lTc3B3dnRL?=
 =?utf-8?B?RWlPK2piK1FhVnRmZXJZRDZyR1pGWTZzTlQ2N3pSYWg1blhwTWZleVlNQkty?=
 =?utf-8?B?Y0YzUFZxdUVISW0reHd0aVpIelI1M0xDZjZJOTFBL2hWMTV1ZmVIdDBYZ1Ir?=
 =?utf-8?B?L0NKZEFaTElwQWYwSXJZTzN5OXhTMSszdnZtQkJQSzBwbFNKVkRpaWl4VXdS?=
 =?utf-8?B?OGI1T1c3ZnlNRjEzdlhKYS94LzJJZTJFaWc2akREL1pGeGVNZkZsOFYzQ0lh?=
 =?utf-8?B?Nzg3ZmNZSzkzZ0d4YnFIQ1NrWTFrZkcxNHRWVHNhM2piOEVNYmFLYWVwZkE2?=
 =?utf-8?B?cjJEdk8rRFd0dmlJRmNyV0NvSi92d1k2ZEdleXJENUFhS3VNZmxkb0dlcFo0?=
 =?utf-8?B?cHJiemttNE9QemowVkE3anJVZU5OSUoyV0dpN2NhVCtTWW10aXZpTlEwZG5k?=
 =?utf-8?B?aDROb2V1ZDMxTWZQTVNhaWxjamVRRlBicjRtT2dMSW9EVEljL0U1eGZyRHZC?=
 =?utf-8?B?QjNzaWtEVS92NmhtckRsRnlBZ2p0OFlrSEh3YlgvZzZSWStvSWJ2am02N3Bw?=
 =?utf-8?Q?puc1/P4qgnzASWq4K68IWbG4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5159d50-b8cd-4022-eae0-08dd1b54f8f5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:03:12.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPGNmNZ0pz4VJtSsMY1fiEp7d9bAulHCJtSXkz7OOYHobUsdQ/pcsW7ahOCaV6msVtWPWbuisMPlU5UNuFJsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

On 11/5/2024 6:35 PM, Lazar, Lijo wrote:
>
> On 11/5/2024 2:13 AM, Felix Kuehling wrote:
>> On 2024-10-31 22:15, Zhu Lingshan wrote:
>>> On 10/31/2024 11:27 PM, Felix Kuehling wrote:
>>>> On 2024-10-31 6:47, Zhu Lingshan wrote:
>>>>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
>>>> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
>>> The mainline master branch:
>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
>>> #include <linux/kfd_ioctl.h>
>>>>> And it is actually not a file in the source code tree.
>>>> If it's a file that only there on your local working tree, maybe just clean up your working tree.
>>> Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
>>> The is even no folder usr/include/linux before building.
>>>
>>> For a quick verify:
>>> 1) it is not a source code file from mainline:
>>> $git blame ./usr/include/linux/kfd_ioctl.h
>>> fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD
>>>
>>> 2) it is generated when build:
>>> remove usr/include/linux/kfd_ioctl.h, then build.
>>> If we remove a required header, kfd would not
>>> build and there will be error messages.
>>>
>>> but here we will see these lines:
>>> HDRINST usr/include/linux/kfd_ioctl.h
>>> HDRTEST usr/include/linux/kfd_ioctl.h,
>>> no build errors, and usr/include/linux/kfd_ioctl.h is
>>> generated by duplicating the uapi one.
>>>
>>>
>>> 2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
>>> add random characters in usr/include/linux/kfd_ioctl.h, then build
>>> we will see errors like this:
>>>
>>> In file included from <command-line>:
>>> ./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
>>>    65 | abcd1234
>>>       |         ^
>>>       |         ;
>>>    66 |
>>>    67 | struct kfd_ioctl_create_queue_args {
>>>       | ~~~~~~
>>>>> Ideally, the usr version should be updated whenever the source code is recompiled.
>>>> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
>>> the usr one would be installed to the system when run make install or install_headers,
>>> it is for user space, we should include the uapi one instead of usr one in our source code files
>> I did not see the folder in my tree because I build with O=... so usr/include/linux/kfd_ioctl.h shows up in my build output tree.
>>
>> The extra copy of the user mode headers seems to be an artifact of the Linux kernel build system. The fact that the build picks up user mode headers from <OUT>/usr/include/... seems intentional. If your tree has an outdated version of kfd_ioctl.h there, it's probably something broken with your build tree. Maybe broken file timestamps. It should be easy to fix with a "make mrproper" to force it to update all the build artifacts.
>>
>> I still don't think we need to change the code to fix a problem specific to your build system.
>>
> Looking at the number of occurrences with "#include <uapi/", it appears
> like explicitly mentioning as uapi/linux for header location is a better
> practice.
Gentle ping, Felix

Thanks
Lingshan
>
> Thanks,
> Lijo
>
>> Regards,
>>   Felix
>>
>>> Thanks
>>> Lingshan
>>>> Regards,
>>>>   Felix
>>>>
>>>>> However, I have noticed a discrepancy between the two headers
>>>>> even after rebuilding the kernel.
>>>>>
>>>>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>>>>> the latest changes are reflected. We should always include the source
>>>>> code header other than the duplication.
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 26e48fdc8728..78de7ac09e8a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -32,7 +32,7 @@
>>>>>  #include <linux/atomic.h>
>>>>>  #include <linux/workqueue.h>
>>>>>  #include <linux/spinlock.h>
>>>>> -#include <linux/kfd_ioctl.h>
>>>>> +#include <uapi/linux/kfd_ioctl.h>
>>>>>  #include <linux/idr.h>
>>>>>  #include <linux/kfifo.h>
>>>>>  #include <linux/seq_file.h>

