Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE6BCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2302D10EB78;
	Fri, 31 Oct 2025 13:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isDJmcd/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC66D10EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiVQJv/dbWtvksSjwVQr12GZ/8+dJ6mk3AKazvlhft0csDBM3n+75EaQYh5pFs8cSGA6S6ux+YnhUVW0ee1sGG6adXjOSrUaiuKJOhYQcUss02QM7VLnNdeONoEJTJkeVZvCsC6L3Jj7XcIT90BXfwHatkbuf1UAXuH8TOBfhcwvfiWBsJi2JQgcqBKrQnWSSDIyheuTTHA+3u5UBqIki2rX+lkX18OyR2Ynb0CitsJ9BCKPvy4C2FbN4kfJlodGleFjsqRSGYRBvzKk9wYRpNFZQ4TQHDiyn9BI4jDgWMVfhgcg58PnIZqCHNhnoL9vO0sbf+7849F4ImbLfzK31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYFe7eheze2hbsflNYrP0/LUZ5eeAxcV5itv1CAV7BM=;
 b=J/404VdPoupQbXdhokRI0lWtf0FJqdSWkY2E+P1IvS3WYpW+wK46shyCFoRp4rW0jJl9zz4y4qI7LNwUlyZWgLFfmxKxXo2ZCdfV+LpS1tq0RZIw6VnPAxZDtHcEPhuWdgQtT6x24EWu2ky5E8jMu1bOTC1Jvc1Du4ILVB2nQ8Hyr0aq+xke8PPgBFq+rh8JST/m6ydMvtvxQDJx3D3+BqBEkFAPA6j+wpbtK+E7/38hDxmv5MSpf6tioERj8g+mJFvvpsvzX/0++tWv7x+s+cLqgwzqK33XLk4x9wHHLGG2/HyqhHY3CXmazf3mt7y0ZFYvn75fPhqgMGQsS+tmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYFe7eheze2hbsflNYrP0/LUZ5eeAxcV5itv1CAV7BM=;
 b=isDJmcd/JPD/7KUpPBQ03fzIq99d3AEym0D/mXnh3peKRM4k8jCWfwsYgv4+3JKy0Q8kewkuhYx2hGRMdUwmabVV+9UWIxcdDr488ng2c7xOIxE7/bJfIanuuex8RnNnVED3V5lUYKBszoIP9ozFZEtJCUDNlrC/25BCwZUQX/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Fri, 31 Oct
 2025 13:44:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:44:03 +0000
Content-Type: multipart/alternative;
 boundary="------------nLJbvh9Qp0EaiIBGJXCjDrDm"
Message-ID: <76206ad7-3da6-4afd-8e6d-3844dd1a3df1@amd.com>
Date: Fri, 31 Oct 2025 09:44:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com>
 <0f9ae20e-0e0b-4b59-9d79-f291ec4ef7c0@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <0f9ae20e-0e0b-4b59-9d79-f291ec4ef7c0@amd.com>
X-ClientProxiedBy: YQBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 517a240b-0681-47c3-0a64-08de18838def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MksyYTZlaDF6L1VSUWE5ZjU1TmplYW9tbGpQTFljWUhpdjd4QnhxbFZpTmpo?=
 =?utf-8?B?Tm9hc1BJS05vVW5ncVgyQlpWREltUnJ3bFBFbHB6S2l0bnBLak45L3p0V0pj?=
 =?utf-8?B?SWx4REFncjR5MFpjTEFSY0lFbTh4Nk94bmZOa3kxR1VtTEJsVUE2cnFNTkV2?=
 =?utf-8?B?MzQzL0djblZpb0dXZjIveGplcXpvSVgyR2t0Y3grOUdlSUJYOWJjd3NEWHdy?=
 =?utf-8?B?YmhkNld6aUhYNU5NZzJ4aGtHVTY0Q1VpY3J0SjVjd0JMcVlJN2NzbWdsY0I5?=
 =?utf-8?B?NVI5eVdkWHcwRHJFY1FScjdURTdiWW03ZUVZT1BaWkdFWG9iYzIxcVIwekU1?=
 =?utf-8?B?TmdUUnpiTmhvbXZKNzhKL1h3UFgzM0NIb3ZsMSt5Mlp1NDhZcXZsTlF4OHFt?=
 =?utf-8?B?eXhINFRMeHZFdTlDR0E5NkVPK2dJN2ZTUjV2YkQwbWgvVmUxUUx1dkJnazhQ?=
 =?utf-8?B?MnYxbFNMazdPUW9ESlRmTmU5ek8wYzVLQ21INzlmRDNlMzlNRGwveXBOYStE?=
 =?utf-8?B?bWZsdEZNb01GUnhDUHNVT2hWd0E5ZTdDZEJiZ2ZBMThKYUNNYjkvRWxZOTZN?=
 =?utf-8?B?QUs2N09MM0VqQk5DaWV1Y3JmZTRrNGNxbDVNUGk0MkZyb1poR3Z0VXNNdmdF?=
 =?utf-8?B?Y0trdHlmOWdSbWw5RmM3cnBkSkZNZWI2bjJTRld3UzhxclNwQ0haUHVnK2ps?=
 =?utf-8?B?a2ltcHFvb0VlTzNnMXdvN0hsVHdyRHhzanVwcStxU1FaNDMrbW05WUdCZ09q?=
 =?utf-8?B?Q1FoV09Yek9UakFYYmNSd2tDYzhMSUVZbkVobE5LZXgySDlOTFdYdExQelRL?=
 =?utf-8?B?TnA2YnpFd0Y1cWZaQi92R0RDczdYUk5BNVdBRVJHMTdqRSsxaFgzcVhRVkhW?=
 =?utf-8?B?NE5MZTlHaXRlMmttdmJ3ZU5kSk1mVWZKUUxMSmVhcVl1TnNHd1ZDUThqU2p5?=
 =?utf-8?B?bzlBNExldW8vVXlpWXpxQTkxYmJxYkdybTNPL0k4cjlyU2VNdERrZWRxNTFH?=
 =?utf-8?B?eStYZzEwelY4a2htR0NKbkphSDdZdDc2TGVPNVJza3JsaG5ZbmZqTEYzOUpR?=
 =?utf-8?B?bHoySDVSN0duZlJVY0x2WUZmSmNGSURFL2pUeThmRFRTMytGcENkVGNCTlJk?=
 =?utf-8?B?K3FIV1V2Q2lvU1FUUlViaFJ5cElzSXFxQnZEQ1ZVTkthajhXaHFBdmNJSk1k?=
 =?utf-8?B?TGJ0ZXIrblAzM1A1WFRkbm5paFYwNC9pREc4akpsQkRsK0RDRTUyeStWOXBm?=
 =?utf-8?B?czNBcnR4QlVYNVV1RktyUFBEcVEwdVlnVWRKTVN5Q1VOZGZ6VzhSTUlUOWM2?=
 =?utf-8?B?VDczeXBjUVd3V0FhQ0t5Tm9jNitIczRlK2lGa3pkTWkydVgzVVM1eHBhcXdm?=
 =?utf-8?B?SUllWWxVME1TbDBhNHVoZTBidlZTV2cvYXM0cjFPQVFHalkvS2ExdzZET2xD?=
 =?utf-8?B?bmpqeDY5MXVPcS9QVk1BK1VMZm9pRHJ2UHRJZEVUSU5IcTlxeUxjOXduUU5L?=
 =?utf-8?B?aTZ2YUZhM3BRVjNxcWNWRDkxUHM0YUJDMHA3bjN6Q0s0Z05rQTYvb3hkT1NR?=
 =?utf-8?B?MUdSMnJyeWNXdmlJcWhhMThTR2EvSFAxOFdIdVc4cVZrRFFGQTB2Z3YvT3Mx?=
 =?utf-8?B?QWVkTGdNT3BTdURDQzFnUWl0S3BCWkd5T2UwYisxRWVkRkZUZld6NGVvaGhZ?=
 =?utf-8?B?bTBHZUpNQlFZUFZFVTBYeDhpRmtGRko2R1ZyaUNwZmVmdlIxWEFrdElqTlR5?=
 =?utf-8?B?T3dMdmNnSkR2MkJjK3NZRXUwTzI4akZUZ2hwclBidFk3TCtCeWpsSHQweWVX?=
 =?utf-8?B?bFJ1TzU4NW1rV0ROUHZtOUJTYUc4SFY1MFFLS0lQK1o3V2hpMytpOElyRjJW?=
 =?utf-8?B?Q05RQk94djFEbFM3MmdHUHc2cVJ2ZzM3UStZTFZ5bXl3N2hjN04wVUdyMFpo?=
 =?utf-8?Q?KCQpy0zYKB7Maz2RZVuWugTrSKxf9Oi6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCsrM3JKT1ZCMVBXME0wdVdGQ3JRVW5mendVdVg1Wkc1UytXcDliWElvS05Y?=
 =?utf-8?B?RU9qbnp2bjRCajBuTFJXSUVoUGFsL0RBQVVjZ3huQmlZS3ZlcTRZR2NUQnhK?=
 =?utf-8?B?bmQzeDM5THlQcElWMVY3b0g5REt4SlZGQkx1dnA2TStjbkZBekZmaUhvQnU0?=
 =?utf-8?B?Z01tUTRjYTQ5VzVwK25IUmRSRUQrK3EwRWludFRBVTBUeGJWMzZWRE5RT2Jp?=
 =?utf-8?B?TDRaczVMeDRJSFg4Z0VUeXBjNEVxeWljVmhMNlRtazQydnRObWNjaG5ua3RP?=
 =?utf-8?B?bFdkRys1WFJZaGg0TG1VYXZaWnFCTHR4cWd1bXdqZkZoRE5ES3ZxUUdUd2hr?=
 =?utf-8?B?SGo0ZDdpZ29TUDdxYitXOVVhZHRFeDJKbTJLY3k1TmVzaUNnUXEwMng1bUVD?=
 =?utf-8?B?TUpQZjYxUm05eEtTbnd2cmFmN0prdHlJTmtFWTg5Sm1nNyt2b0RCK0dpRmM1?=
 =?utf-8?B?ZjJpMUU4S3FQM0xSL1FSTFBDVU1JSGRZMUlObU0rZ2pZVkprbmx5YlRtOUgz?=
 =?utf-8?B?TitwY1lEUXVnbTB2NFArcDBBOW1mbWhyMHlDUlZxelNlai8xWHJUMDJiL0tT?=
 =?utf-8?B?Znd5Tk1zdmprTUJCR3IzbG9aMVRLUnp5djNXSG00RERmOVg1UG1KalVaUkJy?=
 =?utf-8?B?M1VCd242UmFwMmVNVStjNGg2cFF3cHVaSHk2TGdoZmhZODQ1clhOZXhqcUJM?=
 =?utf-8?B?YnFlM1RUU2dFSUJOT3RHQ1ZpTVRobGxnSUVOQVl0eG5PK1dWL3VZdFZmaGQy?=
 =?utf-8?B?SUxJNzR2QmkyZ1NjZnV5c3Z2OENYaXpuV0lWOVo5YVI2V3A0UUdiVTdLZTBW?=
 =?utf-8?B?NkhYUkl1amIxYmU4SFFOaDlDbjRON2wyRmZXRG0vSllJbnozU2o0b1c0dStW?=
 =?utf-8?B?UzRpTU1nL1RFM0s0dFRwTzY3cmJmaXlucFg4YkgrYnN3YmorM0tsZ0xreC9D?=
 =?utf-8?B?NU5UdW1Ba0pxeVVBVzQvVEFnb3NIcktHOXpqZEFTaXgrWTdoNzM2d3NqWHI3?=
 =?utf-8?B?QnE2V3VDMDhzTHFjdVRpZHZ6aGVRTjV2WWZyY3lJanlyV2NOLzNidUtqb2Vm?=
 =?utf-8?B?T1RWbG9hRW5rVCtHeldWVlh0YVdlVkQwc3RnRUhLSVo1c1JHL0FrSEJIZ1VL?=
 =?utf-8?B?UjhEZ2pXWWtld1ZIK1pJZ3huOUw4bWc3QXZUUmtubktxM005cUlRRjNFQ0lx?=
 =?utf-8?B?UlA0NzhSU2l5bmhVVUIzajNMV0tRdXRkTDZlQVZ3WUxnKzJKUGRLdGhlRGN0?=
 =?utf-8?B?MDN2TjQxU3Vua2pCdFpnMVV3Z0NadFVadk56MmVOYzcyV2VhQzY4bGlkdjk5?=
 =?utf-8?B?Q0F0VnJXbTZBTkV5ME9LWFdLT2xrMXExTExjMG4zMlNybW8reHZwcEFEYnFC?=
 =?utf-8?B?UTBhVzBlVDFwajVGVTFUclZSUWdkSFhWa1JGWkl3UVpsVnZWajRLb3JGdy93?=
 =?utf-8?B?UHVLckFIaUc0dSt2VG5yOTgrMU5QRHR3MUJpSVpEU3BOajRwY3V1WlhXd04x?=
 =?utf-8?B?QmovRkQxcmNpVVhsUi9JZXdtUHdHNGtQV0tIT0NnOEx3NVNWWllBM1FndFRI?=
 =?utf-8?B?N0tUZWVhbUNZREQwaE8vODRmUVhQb253OTlxamcrdnN3aDdmdGJpSkVUSlBL?=
 =?utf-8?B?WTMzOFJDQXNEOEVlOUZ1VUsxMWdhZCtJRlR1dUZBTm5DQ3FPS01TUDBPTDNB?=
 =?utf-8?B?eTVTejkvY0JyajdOK0Ewc0ZNYy9yN0dIOUxaRmJueW5CbFdTUkFOczM5ZERM?=
 =?utf-8?B?U2ZKYWduYzRySFk3OEhubnczNjBQSnk0cDBZSGM5OTZTUDFKSzhpOXV1M1A1?=
 =?utf-8?B?akpxVjhBbi9KYmlGTnZ4VHg2YVZGSDJybm9mc0ZyamdVYUlOMEFlRC8zQUV1?=
 =?utf-8?B?UVRoTXFESUxvWkpYem92VnFFK2w3L3lZNDZPNmFIYnVpZ3NpVXkyWS9rakZ5?=
 =?utf-8?B?aUlWOFlXRW9heUZ4dUhwaGFZdG5tQlZFdVBkZmdHUmRmTGY1bzdVNnhvekww?=
 =?utf-8?B?MlVWM2x5YmF4TVJ2Ty9HbkVsVWYyTldpdldnc1dkK2VueVBXQlJOVWlab3pa?=
 =?utf-8?B?WnBCR1RHZHEyRmlRdVV3eXBFellRQ05hUTFHM3NxL0J3Q2tWNENYeDdnbjVy?=
 =?utf-8?Q?LtoZpflDkoU34voVjT7NCbdEB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517a240b-0681-47c3-0a64-08de18838def
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:44:03.6655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq9MS2fEinFAzTjyIXeKL4qnyzRKnG+eE0sFti5O2lP7B3rziOvMobOIBXdoE4avEsN9oL6ohAo180JRHsX63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

--------------nLJbvh9Qp0EaiIBGJXCjDrDm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-30 22:46, Zhu, Lingshan wrote:
> On 10/30/2025 11:05 PM, Kuehling, Felix wrote:
>> On 2025-10-29 23:45, Zhu Lingshan wrote:
>>> The pasid is a per-process-per-device attribute,
>>> therefore this commit implements per
>>> struct kfd_process_device->pasid in sysfs
>>
>> Does anyone in user mode actually need this PASID? When we changed 
>> the PASID allocation to be per-process-device, we changed a bunch of 
>> our dmesg logging (and I think debugfs files, too) to report PIDs 
>> instead of PASIDs. So there should be no good reason to know PASIDs 
>> in user mode.
> Hello Felix,
>
> This patch is to fix current buggy pasid in sysfs which is hard-coded 0,
> if we don't need to expose pasid to user space, I think we should remove it from sysfs.

It's not buggy, it's there to avoid breaking old user mode tools that 
expected to find a PASID per process. Take a look at this commit for the 
history: commit 8544374c0f82edb285779f21b149826fe2c2977c

Author: Xiaogang Chen <xiaogang.chen@amd.com>
Date:   Mon Jan 13 17:35:59 2025 -0600

     drm/amdkfd: Have kfd driver use same PASID values from graphic driver

We used to have a PASID per process and reported it to user mode. We had 
to change that to fix some issues related to multiple GPU partitions. 
That broke reporting of PASIDs to user mode. We kept reporting a 0 PASID 
to avoid breaking existing user mode tools that expect to read a PASID. 
But because that PASID was never that useful to begin with, reporting 0 
doesn't do any harm here.

Adding another interface to report per-process/device PASIDs to user 
mode is pointless if there is no user mode client that needs that 
information. And we don't want user mode to use PASIDs to refer to 
processes or VM address spaces.

Regards,
   Felix


>
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 70ef051511bb..6a3cfeccacd8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>>       bool has_reset_queue;
>>>         u32 pasid;
>>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>>> +    struct attribute attr_pasid;
>>>   };
>>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, 
>>> qpd)
>>> @@ -983,7 +985,6 @@ struct kfd_process {
>>>       /* Kobj for our procfs */
>>>       struct kobject *kobj;
>>>       struct kobject *kobj_queues;
>>> -    struct attribute attr_pasid;
>>>         /* Keep track cwsr init */
>>>       bool has_cwsr;
>>> @@ -1100,12 +1101,6 @@ void 
>>> kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>>                       int handle);
>>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>>   -/* PASIDs */
>>> -int kfd_pasid_init(void);
>>> -void kfd_pasid_exit(void);
>>> -u32 kfd_pasid_alloc(void);
>>> -void kfd_pasid_free(u32 pasid);
>>> -
>>>   /* Doorbells */
>>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ddfe30c13e9d..24cf3b250b37 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct 
>>> attribute *attr, char *buffer)
>>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct 
>>> attribute *attr,
>>>                      char *buffer)
>>>   {
>>> -    if (strcmp(attr->name, "pasid") == 0)
>>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>>> +        struct kfd_process_device *pdd = container_of(attr, struct 
>>> kfd_process_device,
>>> +                                  attr_pasid);
>>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>>           struct kfd_process_device *pdd = container_of(attr, struct 
>>> kfd_process_device,
>>>                                     attr_vram);
>>>           return snprintf(buffer, PAGE_SIZE, "%llu\n", 
>>> atomic64_read(&pdd->vram_usage));
>>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct 
>>> kfd_process *p)
>>>        * Create sysfs files for each GPU:
>>>        * - proc/<pid>/vram_<gpuid>
>>>        * - proc/<pid>/sdma_<gpuid>
>>> +     * - proc/<pid>/pasid_<gpuid>
>>>        */
>>>       for (i = 0; i < p->n_pdds; i++) {
>>>           struct kfd_process_device *pdd = p->pdds[i];
>>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct 
>>> kfd_process *p)
>>>                pdd->dev->id);
>>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>>                           pdd->sdma_filename);
>>> +
>>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, 
>>> "pasid_%u",
>>> +             pdd->dev->id);
>>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, 
>>> pdd->pasid_filename);
>>>       }
>>>   }
>>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread)
>>>               goto out;
>>>           }
>>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>>> -                      "pasid");
>>> -
>>>           process->kobj_queues = kobject_create_and_add("queues",
>>>                               process->kobj);
>>>           if (!process->kobj_queues)
>>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct 
>>> kfd_process *p)
>>>       if (!p->kobj)
>>>           return;
>>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>>       kobject_del(p->kobj_queues);
>>>       kobject_put(p->kobj_queues);
>>>       p->kobj_queues = NULL;
>>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct 
>>> kfd_process *p)
>>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)
--------------nLJbvh9Qp0EaiIBGJXCjDrDm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-10-30 22:46, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0f9ae20e-0e0b-4b59-9d79-f291ec4ef7c0@amd.com">
      
      <pre>On 10/30/2025 11:05 PM, Kuehling, Felix wrote:</pre>
      <blockquote type="cite" cite="mid:24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com">On
        2025-10-29 23:45, Zhu Lingshan wrote: <br>
        <blockquote type="cite">The pasid is a per-process-per-device
          attribute, <br>
          therefore this commit implements per <br>
          struct kfd_process_device-&gt;pasid in sysfs <br>
        </blockquote>
        <br>
        Does anyone in user mode actually need this PASID? When we
        changed the PASID allocation to be per-process-device, we
        changed a bunch of our dmesg logging (and I think debugfs files,
        too) to report PIDs instead of PASIDs. So there should be no
        good reason to know PASIDs in user mode.&nbsp;<br>
      </blockquote>
      <pre>Hello Felix,

This patch is to fix current buggy pasid in sysfs which is hard-coded 0,
if we don't need to expose pasid to user space, I think we should remove it from sysfs.</pre>
    </blockquote>
    <p><tt>It's not buggy, it's there to avoid breaking old user mode
        tools that expected to find a PASID per process. Take a look at
        this commit for the history: commit
        8544374c0f82edb285779f21b149826fe2c2977c<br>
        <br>
        Author: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a><br>
        Date:&nbsp; &nbsp;Mon Jan 13 17:35:59 2025 -0600<br>
        <br>
        &nbsp; &nbsp; drm/amdkfd: Have kfd driver use same PASID values from
        graphic driver</tt></p>
    <p>We used to have a PASID per process and reported it to user mode.
      We had to change that to fix some issues related to multiple GPU
      partitions. That broke reporting of PASIDs to user mode. We kept
      reporting a 0 PASID to avoid breaking existing user mode tools
      that expect to read a PASID. But because that PASID was never that
      useful to begin with, reporting 0 doesn't do any harm here.</p>
    <p>Adding another interface to report per-process/device PASIDs to
      user mode is pointless if there is no user mode client that needs
      that information. And we don't want user mode to use PASIDs to
      refer to processes or VM address spaces.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:0f9ae20e-0e0b-4b59-9d79-f291ec4ef7c0@amd.com">
      <pre>

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com"><br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++------- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18
          +++++++++++------- <br>
          &nbsp; 2 files changed, 13 insertions(+), 14 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          index 70ef051511bb..6a3cfeccacd8 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          @@ -864,6 +864,8 @@ struct kfd_process_device { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid; <br>
          +&nbsp;&nbsp;&nbsp; char pasid_filename[MAX_SYSFS_FILENAME_LEN]; <br>
          +&nbsp;&nbsp;&nbsp; struct attribute attr_pasid; <br>
          &nbsp; }; <br>
          &nbsp; &nbsp; #define qpd_to_pdd(x) container_of(x, struct
          kfd_process_device, qpd) <br>
          @@ -983,7 +985,6 @@ struct kfd_process { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues; <br>
          -&nbsp;&nbsp;&nbsp; struct attribute attr_pasid; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr; <br>
          @@ -1100,12 +1101,6 @@ void
          kfd_process_device_remove_obj_handle(struct kfd_process_device
          *pdd, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle); <br>
          &nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid
          *pid); <br>
          &nbsp; -/* PASIDs */ <br>
          -int kfd_pasid_init(void); <br>
          -void kfd_pasid_exit(void); <br>
          -u32 kfd_pasid_alloc(void); <br>
          -void kfd_pasid_free(u32 pasid); <br>
          - <br>
          &nbsp; /* Doorbells */ <br>
          &nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd); <br>
          &nbsp; int kfd_doorbell_init(struct kfd_dev *kfd); <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          index ddfe30c13e9d..24cf3b250b37 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct
          attribute *attr, char *buffer) <br>
          &nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct
          attribute *attr, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer) <br>
          &nbsp; { <br>
          -&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0) <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0); <br>
          -&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) { <br>
          +&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;pasid_&quot;, 6) == 0) { <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
          struct kfd_process_device, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_pasid); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%u\n&quot;,
          pdd-&gt;pasid); <br>
          +&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
          struct kfd_process_device, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
          atomic64_read(&amp;pdd-&gt;vram_usage)); <br>
          @@ -662,6 +664,7 @@ static void
          kfd_procfs_add_sysfs_files(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create sysfs files for each GPU: <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/vram_&lt;gpuid&gt; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/sdma_&lt;gpuid&gt; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/pasid_&lt;gpuid&gt; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i]; <br>
          @@ -675,6 +678,10 @@ static void
          kfd_procfs_add_sysfs_files(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_sdma, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_filename); <br>
          + <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pdd-&gt;pasid_filename,
          MAX_SYSFS_FILENAME_LEN, &quot;pasid_%u&quot;, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_pasid, pdd-&gt;pasid_filename); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; } <br>
          &nbsp; @@ -888,9 +895,6 @@ struct kfd_process
          *kfd_create_process(struct task_struct *thread) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj,
          &amp;process-&gt;attr_pasid, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;); <br>
          - <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues =
          kobject_create_and_add(&quot;queues&quot;, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues) <br>
          @@ -1104,7 +1108,6 @@ static void
          kfd_process_remove_sysfs(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL; <br>
          @@ -1114,6 +1117,7 @@ static void
          kfd_process_remove_sysfs(struct kfd_process *p) <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_vram); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_sdma); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_pasid); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(pdd-&gt;kobj_stats,
          &amp;pdd-&gt;attr_evict); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd2kgd-&gt;get_cu_occupancy) <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------nLJbvh9Qp0EaiIBGJXCjDrDm--
