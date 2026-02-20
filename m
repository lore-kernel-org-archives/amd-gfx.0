Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25387C5B560
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 20:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B970A10E83E;
	Fri, 20 Feb 2026 20:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WeaUTsB8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AA110E83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 20:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzbEIgfwKSb9AL9aqv7TxlyCEFV6EWqdiy3LIU/1ynRuB69ry62l2zSC9PsOSIjV3VQtsopq9Np6lpNpDqh1gl0DHNQYn/WJucly2QddGq3PpMXTmp9SxKub4UkB3DX90a1vhoLgncDu95SCXbCPjC0XIeFdjtHgJKY5d/5KevRi5tDYFlmmUuK6bT+e31nLkp/N7Bmf5aFtnJR+IHrRtdRyoCW0ke/ZeNkftcuQEG8NPAZdEf/nhDJJCSNGHSfJMM+oTGD3uc1HnWAOr7dFrh0iyoVxbIob/J3TIFPZ3AXUz4JQbtUHkp8RS9F8UWZ5DqaI3qeUFwGCQWmrnujEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65y18zIPQeBcEVTs4z+rdvRMj671em1lf5VP3x7lfUU=;
 b=CGXYAHFlxStIi3OmzrCErS6RIl6WsmYv2lTxtK7XIIn7Oyk0gHkF9k61y8sdDImBnBhChOKTCTD58dDqGF7nD6MShYtHO+RjS4o/uWDqbjDDMdKaBcqghC2Azy7pwyXXMuzBdGSL4mtp9XWaAmvr5ISeGs6Pv17rtmZ7YFQw2aS2xGAs4f5qeLcTWVnIHzEYOhdBwGH5kJo/gTHmyXaCnME9uI6eIuo6V2vE0lVvDdoio+FcyE5+5FKpu4PVpv5VeX9Yb0ty4jHn3UngrdMuaNLvANmVB1StbN1IcLAIsSQEwfnUFeyYfCS9ZtEqrJGs1qO3vPZh50MBif5qGkfXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65y18zIPQeBcEVTs4z+rdvRMj671em1lf5VP3x7lfUU=;
 b=WeaUTsB8TZG93yUi8NjhekoWN2Lv7KqdqspJKA2xAKVG9PWDgRTbJdIz76KHNkGhfUSveQDEACC/JeEqERPP02hoV8hU0OKJfvc3vcbQV1tMwoNbSZM5bIHRUM/89JZ+/8EqmZo+Nm9F6VtDp6pAHSd0xs/YKf3z4CXjRKKpwzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 20 Feb
 2026 20:49:14 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33%4]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 20:49:13 +0000
Message-ID: <4797f29f-9ea1-468b-a769-122f0bbb0ea1@amd.com>
Date: Fri, 20 Feb 2026 14:49:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add an option to allow gpu partition allocate
 all available memory
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260217162424.991875-1-xiaogang.chen@amd.com>
 <840ac8de-f27f-438c-ad45-bcd0c76dccfe@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <840ac8de-f27f-438c-ad45-bcd0c76dccfe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd203e8-d620-4f11-4cf4-08de70c1813d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2kzaTBnejBkT3VSV045emY2TEtzNkRpRk4xY1pIL0licWwvdW1vSzR4dFhp?=
 =?utf-8?B?NDcwZ1JSYy9DRHpjQmRhY3l4dSs2WjcyOHVmRnNjd3loWFVOdytyRWsrUzdZ?=
 =?utf-8?B?SVdyVUE4YTJPcUdtbjYrcDYzWHRzV0E3UVEybGcvRUc0U0dISWpuRUlIR3hN?=
 =?utf-8?B?TlFJYytSSVh2bWllT0c1VzY3dlc5Z3BsQUFYU2NaL1VpenV5ZXZzRko0emVZ?=
 =?utf-8?B?bHRkZkVRWTV2eXZOUXR0YUZsVk1lTVB5R0g2L0NPVXhRcExaMnBkSTNuZ01w?=
 =?utf-8?B?dU5qZUFSSnpyd3Y4cnNwejE3WklUZkVYaFVZOGZDWDlpeUFBUmYya3RZQ04w?=
 =?utf-8?B?REVJSDlrZUpTWUlCQVFQckNBWVhoWFZzbVdqVzV5QW9lcmhTd2xNV1lKMWYy?=
 =?utf-8?B?RG1ablJxQUtDay9hRFFMN1VaWlhtc2RMNXRKMlBqRUFwdG1OYWRzMVppK1cz?=
 =?utf-8?B?TlUwWHZ5L1E5TnljcFJCVkdZb3hpRjhxTytrTUtEbmVpdWJtTnp0aE9JcnUy?=
 =?utf-8?B?RU9VR1VFa1dwbW1IQXVseDdyVVhlOVhhRTdGMkN2eTF4ajFhR2dmMzViZm4z?=
 =?utf-8?B?RFBJSGNEMmdNY0MrcVBhMGFtazY5U2ZBbWxjZnhhZVVaUWp5VFNjV1EyakdU?=
 =?utf-8?B?c1lZc3QzNmtIQ1prdHRSRjh3ajY1cHpncFNOZ1dNOFd4eU5lcXFnUHRqdUZ6?=
 =?utf-8?B?bFFTcDZuUitFVVBURTBVNnhrMitrdVdMcTdRUGFQelBmL0pEOGhXWlJvL3Zj?=
 =?utf-8?B?NmxEc3BoL0h0SVNGeWVRUVdFbStCZzVNam9tT3FIKzB5RS9kemQ3em82RGQ1?=
 =?utf-8?B?aUx0bUx6ZURNQTk1YkJhU0JOUGFmLysyeHFlSmVFK3Fsc0ZpaHFHVUQyWisr?=
 =?utf-8?B?RjhtdWJnM0lGMXRRaGhtTWZxNTZ4bFBNV0MvRnk4VS9NSU5MMVlsazB0VDlW?=
 =?utf-8?B?T3JINFdtSitSOGNkTjBWNGZDcmNFQjN3Z0xMWnZwaTFlR1k5WFY2ZWljMTRt?=
 =?utf-8?B?dFVFaTlLQUM0SCtMUWpsS0xFVS9KR25lMEk4SFRFQjRIS0IvWjVSTGJoblVO?=
 =?utf-8?B?Tmh3Szc4K0JHTjlhcDUvYTJXNjNRRHc0QVpabmhvcWtBQXh4OUphRTcvdFJr?=
 =?utf-8?B?UDRHVVB1cDE0RndiL2dsMVZETGRUYzNNdmUzTGlXZFNoSmlidXIxalBDZUU3?=
 =?utf-8?B?TCttWlVMNHVZOHZVU2hwNHpFZ1piZDJDUC9KbEQwODVIU3VQVHVid3pPMDR1?=
 =?utf-8?B?Vzl3RmtLUjhmSnNRTlJDa1R2K1pTZlJ0M0tVQlRWUFFtN0xCQ2N5Umh2MG5J?=
 =?utf-8?B?ejVWNmROWEZhYWoyUUFMYldMbFpKU2NTSk9yTkNtVDZmWStjcUtoa0l2aDZO?=
 =?utf-8?B?VU44MGRnK3lsL095TWVRNjdtMVRCaHh0T25TYzc5YU11cmFVSVNwSUoyK29Q?=
 =?utf-8?B?eEhZaWZqMSs4VUd0STk3ZTFJSkprZ2hxL05SUjBTZCtZQzduZ0NCQTc5Vit1?=
 =?utf-8?B?QktrdzVoR05GME8zbGNkaEp6eVhHbGJoRTlMRm5vUGdhR1ZpRUkrUGRyQnVu?=
 =?utf-8?B?MkNqdFdBbWRTOTIwRVRYSmlITGlrMHg0MFRKMVR0Uk80VmFpUUk1VTRMSXht?=
 =?utf-8?B?VDNIb2RYWUtkUDNrbmx6ekxwSWhSSHJ1dmpiY1l1dVhJQVVzVGN1K2QwOVVa?=
 =?utf-8?B?SDZ5S1Rhc1RaaW1oZzk3MmRRUUdLY0hmZzRpdDRmQXo2ZHRLWHVpeVM4OTRW?=
 =?utf-8?B?dkNvTzZ4aE4zM0lTcHFOMnRMWnFjRXp2NzZmRmJzeHZvTVUzR2xmTDZKVjU1?=
 =?utf-8?B?UXRCb2ZPNmo0KzJyTDhpZzV2MTBldEpBMjJRajFRcUZZV2cvd3dPTm9POVRE?=
 =?utf-8?B?SWxEREkrNUh1bmVlUUhTUEhZYjd2dmlKL3Z5cEFwR0Y0TFZmNGRMRkF2b0h6?=
 =?utf-8?B?VFI0YkhFbUUxZS82NGEyanl5eHFSam1aSU5KWW1QeXZKMENaUU5XNzJickN1?=
 =?utf-8?B?UDNwT1EveUQ1cnoxZWdSbVFYc2htTGJwU3I0bmZUQXBqb203cEltMS9oUWF4?=
 =?utf-8?B?UUpDUHY0Z0ZCdHI4ZTBGODRQWmFMTHRuQkZYUldQUUhlVXRzSVlmZ2FzRG51?=
 =?utf-8?Q?Mabk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJibWY2WWZzWEZyVHhXMEpQVWdqc3NEVi9xQmFRSnlNdEhZWWhpcUk2NXow?=
 =?utf-8?B?TWJ4VDkxTzBMLzNIbDBzSFNJRWc0anBWUFJkUnMwRGMxYXo4Z1RKeTBkaDBQ?=
 =?utf-8?B?ZHRMcG5DVWZKTCtkZkpXSmhOYVlHUjFtK0xzWTRZd3RISVZGU3U3TjFZRjJu?=
 =?utf-8?B?UDRJcW5qN25lQjBZcEpMalVTZ2owMEZUNHhNN0xOenppc01vUSt6bHFTOVFh?=
 =?utf-8?B?c3ZLMVNTUklZMm9TcmNHd3lCc2xIK0dBK3dlVnBkSWVBVHhLdDZFTC9kMzZn?=
 =?utf-8?B?ekpNelBIMlhMK255UTZMcHRMcTB4dDlGOHkrNFlwRmpiZi82dzFNeFZUeEFz?=
 =?utf-8?B?Qy9HNVg5bEF1SklpcC9lYWZMUmV1TEJ5V0VVWjFqTE4ySG9CdC9wRWJlblVS?=
 =?utf-8?B?b0dDd3M5VHZMcU1WMkxGWGdxclA5ZThCekdnRENOb0laZXI3SGk3dVlmL0I5?=
 =?utf-8?B?dndyWHQ4dnQzZzdDb1VBeWt2b3ZxS05LVlUzeE15MG0wTXN5ZVRKTGd1d2ZE?=
 =?utf-8?B?bU9TNUlsNm1OWkN6NkI0UTUxdUtHWTYzK0Z4TmwwT3BKVVVHc1V4eFNGc2NC?=
 =?utf-8?B?WU1SZ0xTMGpPeHluQW9uQW9xaHFKNElnTWl0SndaU3dZR3F5RStjQUFjTng5?=
 =?utf-8?B?WkxNbFhEYjZ4SHJmdUxVWHZPLyt6aC8rSHVzUklSOFpoeW1aOFFWRWc4dS8x?=
 =?utf-8?B?Q2dkc0w3UndUdnB4WDkxazhvUHhsNjFFd09JWVJYcTlXeE5GaVRqdlV6eXF4?=
 =?utf-8?B?Y1VnaTJVUldlYjFmU3RJanFXTDJrS0FRMmZjYitRTUl6WWtuL3dtdHEzRzRh?=
 =?utf-8?B?ekI5dmQ3M0RBY2I2RDJrZWNXdkNQQ2t5SnZlVG9EeGJwRUZOc2JlbGRVMThI?=
 =?utf-8?B?bVV2bElyM05UejcyVnRJRk5UMnZLOFZXWFBldUU3cDF4Q0hzMnU3OWdmZ2p0?=
 =?utf-8?B?dW1XM2pjYmhlWnhQWmxvK1VNVTcyTHFnWjZwNDBOcit0Y1kvN3hSbjVBelMx?=
 =?utf-8?B?OWRGRGcvWGRXbENvS3c3YVQ3K3NhM0YrNkh4cmk4UGJWSE1GRU1yYUl2M0g3?=
 =?utf-8?B?NHk3Rmo3bTJ2OUpZSXg2QnJ5YWNtbTdGVDlsUlZpTi9CQXJPTFI3WnZzRWZ5?=
 =?utf-8?B?NHdwZkh6UStOdmh5aURZV3ZLTnlIbXJVWDdMU3BrbUsvSHpJZFpmL0NNYVdI?=
 =?utf-8?B?S09hMzYvSWZiTm1oK1p2NHRZTndFZFVqanR4c1pTTTQzaXBqSSttN3dqOEp1?=
 =?utf-8?B?UEVCUU80aVBsZHY3amxtNjhZOXJaY2dIM2hXMjFZd0VxQTZuemNsekFDMEdw?=
 =?utf-8?B?N1liOUFXVkVhVGNsdjNnTUQveG9GMkdVZkJFNWVkMjJXSVhQdGpWT3ZZUWVH?=
 =?utf-8?B?L2dRMlhJbmlUWVhFRWtHRTFueWliRTF6TW1oY0JKMlBpZithTDU5MS9EeWQw?=
 =?utf-8?B?TVRyYk1wWjlmdjhEU1h1UUJZNmVPUTJYUnd1SXJXVjJjOGRLb0p2aTJiM0Qv?=
 =?utf-8?B?aGhRL3M0eFNuL1pUYzZKVytkVzJ5akZKYWVNKzllN3RBN0xJcVlBOVFZYWN6?=
 =?utf-8?B?WkE3ditXalJkWUdZWGw3eWtJcURqSnVjQ1oxZWFoay9qS25wMTZ4SEUwZVhx?=
 =?utf-8?B?Z3EyZk5VeWR4c2syVlhmNkVhY3lXMUI4a3lWNVQ0c29mMUFnYkVuNlhBaVVy?=
 =?utf-8?B?Y0hqR1JqbVhDT2NWZ2lleFhxTkFLK3ptSEltb25kTU9SZWxnWnRKNWpzQ1g0?=
 =?utf-8?B?djhQQkt2OUFQU3VQRjZ5VW9xaHdZVkdGR1ZhcVhrT2dTUXRVV1JPMEw3b2ln?=
 =?utf-8?B?NW5pYmtpOFhlR29wTnU5bmRHbXVZY1ZtZTNlaTNyamd4SzNxMGliWDRZbXN5?=
 =?utf-8?B?dmN0KzlwcG5CeFZybmNuZWlOd3NkVStlZ3QwQkk4dU40dm0yZHVGdis5MnQ5?=
 =?utf-8?B?Z2FEYVVLQzYrOWd1QlJFL0JwbldyWlQzbGU4bUVjb1BRSEdac3Q2emxMS2Yw?=
 =?utf-8?B?Q3JNa2IvTmlVMWhzWktseGJzektITXFUZmFGclo2aXpsdHAyZVhiY01GSW9v?=
 =?utf-8?B?QXRsby8rc0hEUGVoSmJ5Q0U5YXlIR1VabG5kOTlqQXl0cEUzWCtqaXFBeVhp?=
 =?utf-8?B?UnNrNGZmWlZFRld0MExLK0s1Y0ZTU0tiWnRDaFZHZTVrcWY2d3YvZkM2Tmhk?=
 =?utf-8?B?S3lUSFNKL2NCSjlERldlZDhYQmM5ZEVkQitTQ3BjZUx6dEhBMW91a1BidGNI?=
 =?utf-8?B?cUFWT2l2Y1V6azZ3MXo0RUNXSTlYb3UxKzZLV3JhWmNNNzFtbjArN2VpbTZ0?=
 =?utf-8?Q?GA2cFSPMtZB67dV/CS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd203e8-d620-4f11-4cf4-08de70c1813d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:49:13.4053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y69kyyfLXPA6GoTGU1LgpEj1KmaS56L3u6ddVaedrtzeepFdP7b8mr5I2AgHzFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
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


On 2/20/2026 1:51 PM, Philip Yang wrote:
>
>
> On 2026-02-17 11:24, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> Current driver reports and limits memory allocation for each 
>> partition equally
>> among partitions using same memory partition. Application may not be 
>> able to
>> use all available memory when run on a partitioned gpu though system 
>> still has
>> enough free memory.
>>
>> Add an option that app can use to have gpu partition allocate all 
>> available
>> memory.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
>>   5 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3bfd79c89df3..006883c31342 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct 
>> amdgpu_device *adev, int xcp_id)
>>           } else {
>>               tmp = adev->gmc.mem_partitions[mem_id].size;
>>           }
>> -        do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>> +
>> +        if (adev->xcp_mgr->mem_alloc_mode == 
>> AMDGPU_PARTITION_MEM_ALLOC_EVEN)
>> +            do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>> +
> I think amdgpu_amdkfd_reserve_mem_limit should change to account total 
> vram used, to prevent vram
> over-commitment for not ALLOC_EVEN mode.

I thought it. The customer wants this knows there is OOM risk if they 
keep allocating more than system has. If we put limitation I think we 
need decide how many percentage of ram reserved for system. It applies 
to APU. For dGPU the allocation would fail or cause eviction if vram ran 
out.

>>           return ALIGN_DOWN(tmp, PAGE_SIZE);
>>       } else if (adev->apu_prefer_gtt) {
>>           return (ttm_tt_pages_limit() << PAGE_SHIFT);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index cab3196a87fb..1da46eeb3f2c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1580,6 +1580,40 @@ static ssize_t 
>> amdgpu_gfx_set_compute_partition(struct device *dev,
>>       return count;
>>   }
>>   +static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
>> +                        struct device *dev, struct device_attribute 
>> *addr,
>> +                        char *buf)
>> +{
>> +    struct drm_device *ddev = dev_get_drvdata(dev);
>> +    struct amdgpu_device *adev = drm_to_adev(ddev);
>> +    int mode = adev->xcp_mgr->mem_alloc_mode;
>> +
>> +    /* Only minimal precaution taken to reject requests while in 
>> reset.*/
>> +    if (amdgpu_in_reset(adev))
>> +        return -EPERM;
>> +
>> +    return sysfs_emit(buf, "%s\n",
>> +              amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
>> +}
>> +
>> +
>> +static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
>> +                        struct device *dev, struct device_attribute 
>> *addr,
>> +                        const char *buf, size_t count)
>> +{
>> +    struct drm_device *ddev = dev_get_drvdata(dev);
>> +    struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +    if (!strncasecmp("EVEN", buf, strlen("EVEN")))
>> +        adev->xcp_mgr->mem_alloc_mode = 
>> AMDGPU_PARTITION_MEM_ALLOC_EVEN;
>> +    else if (!strncasecmp("ALL", buf, strlen("ALL")))
>> +        adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
>> +    else
>> +        return -EINVAL;
>> +
>> +    return count;
>> +}
>> +
>>   static const char *xcp_desc[] = {
>>       [AMDGPU_SPX_PARTITION_MODE] = "SPX",
>>       [AMDGPU_DPX_PARTITION_MODE] = "DPX",
>> @@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
>>   static DEVICE_ATTR(compute_reset_mask, 0444,
>>              amdgpu_gfx_get_compute_reset_mask, NULL);
>>   +static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
>> +           amdgpu_gfx_get_compute_partition_mem_alloc_mode,
>> +           amdgpu_gfx_set_compute_partition_mem_alloc_mode);
>> +
>>   static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>> @@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct 
>> amdgpu_device *adev)
>>       if (r)
>>           return r;
>>   +    r = device_create_file(adev->dev,
>> + &dev_attr_compute_partition_mem_alloc_mode);
>> +    if (r)
>> +        return r;
>> +
>>       if (xcp_switch_supported)
>>           r = device_create_file(adev->dev,
>> &dev_attr_available_compute_partition);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 720ed3a2c78c..f5713891f205 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
>>       AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
>>   };
>>   +enum amdgpu_gfx_partition_mem_alloc_mode {
>> +    AMDGPU_PARTITION_MEM_ALLOC_EVEN = 0,
>> +    AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
>> +};
>> +
>>   #define NUM_XCC(x) hweight16(x)
>>     enum amdgpu_gfx_ras_mem_id_type {
>> @@ -676,4 +681,16 @@ static inline const char 
>> *amdgpu_gfx_compute_mode_desc(int mode)
>>       }
>>   }
>>   +static inline const char 
>> *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
>> +{
>> +    switch (mode) {
>> +    case AMDGPU_PARTITION_MEM_ALLOC_EVEN:
>> +        return "EVEN";
>> +    case AMDGPU_PARTITION_MEM_ALLOC_ALL:
>> +        return "ALL";
>> +    default:
>> +        return "UNKNOWN";
>> +    }
>> +}
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index 73250ab45f20..a2d50f90a066 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr 
>> *xcp_mgr, int num_xcps, int mode)
>>       }
>>         xcp_mgr->num_xcps = num_xcps;
>> +    xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
>>       amdgpu_xcp_update_partition_sched_list(adev);
>>         return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> index 8058e8f35d41..878c1c422893 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> @@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
>>       struct amdgpu_xcp_cfg *xcp_cfg;
>>       uint32_t supp_xcp_modes;
>>       uint32_t avail_xcp_modes;
>> +    /* used to determin KFD memory alloc mode for each partition */
>> +    uint32_t mem_alloc_mode;
> rename to mem_capping_mode?
>
I thought this name is more general as the modes are declared at enum 
amdgpu_gfx_partition_mem_alloc_mode which indicates meaning of each 
mode. If new mode needed we can add it at this enum.

Regards

Xiaogang


> Regards,
> Philip
>>   };
>>     struct amdgpu_xcp_mgr_funcs {
>
