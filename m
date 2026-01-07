Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83010CF6C1F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8DD10E0AB;
	Wed,  7 Jan 2026 09:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjOQ5u5m";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A896910E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoHDt+dPC6+0X030nZkdEEg6duslaCGst3SHDWptyac9FNv5g7OOqPbQsXpEf8in4fxhSv1jR0AbwAXM01Y5Iov0AFtJyHZD4SWRGAvchIimOIB1O1DoeaMbd2mgW1vfkv2rW+NY8hDpU1pOXBjgUQQFkGZPv5Y4hDjD/cXSZcFhVCd0Vcdj6xEsf1t1r2dsOMSJB9b8UduwL1aoEuc3k4GFZRMD60FWZEtTi5Uxf2FCuRmAI1iylnG+7KDM9UQIPNjQx4cnrKLl2K/nobwmYt3Zu1dZ4xZQgGIG4h/zSfKs6gO1W6UB4Gp4/gZJtqipfQS/Aqx1xnTLT5jCfkkEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeBqKp+YyWCvi4AlS0WCHf4yzro+BkkJQ6swbHsUvIc=;
 b=xoFJQMymWjM/49fQAKmMC3Fh9gng6jTdHCITsILBRrEOLMHLHamEiWnfVNitViUuHUMJfy70NaiLSj1FA/QF9k5Hgt7IkJtqAul1gcx+TugJygQ/rkEnhpHguMWpp01k/v6YNQZxqWdTtSH09nbogtRJiVwhktzVbr60UN34ONZrLqLCknb3v+hirwxFg3gKHPOm6o9t1a0SIFEVgeSaeLA/3wIxBxWEK8UCerA/CmN0E7ktsJhMfyGTJhvfhen1Qm1flxAR7kbWuAGX3RNRTPlr9FxFb1FGi49W0aBtTAIl4TIB9EfVa8WF6FftLg41hcWyElNoAJsOqi/myoimCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeBqKp+YyWCvi4AlS0WCHf4yzro+BkkJQ6swbHsUvIc=;
 b=BjOQ5u5mKpr4RO+UWjwje+7SJX/4hbeKXQ6PeCerRKMWo5cjrRxqnLhYx+5IeBkFFV3rwR79iTNX7wV2i4pZc2CAj9bAMUWKCz2xp5enwTUFZKB4Y1Yr0rzSvIDnAaSIYv9wtDIRXpUNWTJ3mF7yhL31vuDf5BALPqs6pUmeXZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:50:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:50:32 +0000
Message-ID: <5c8ccd03-9a3a-47c0-9a89-be0abf6c1fb5@amd.com>
Date: Wed, 7 Jan 2026 10:50:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
To: Mikulas Patocka <mpatocka@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0497.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 55823367-c864-4a73-2083-08de4dd232ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXNWVTVCS2JzYTd5MFdKME5wd2p0MmhLL2xWd2dqNVBkMUFTOFg5WTRjWXMz?=
 =?utf-8?B?RnF3K3ZRTktMWmxKWE45ekY4N3l4UlZqL2l0Z0xjUXk1bXZob0tMd3FWMUJx?=
 =?utf-8?B?eVRNbThlRmZWWTh1NTJMMjFFSUx1a0RpUEJacm9HcFg4Z2twQVFBN1BBR1Fm?=
 =?utf-8?B?UVVqTnVpYjN3WjdWQ25GM3hkY3N2UWoyYWx2ZitITTZtbWtwMFZ5TUlWQnpL?=
 =?utf-8?B?REM5SVQzOVViRi9ZN1lsRmlpdlpHV1hITE5IdkhzSHlpOVNZVU0xSDR0TVNN?=
 =?utf-8?B?eklKZkZvbDc1a2V0VGNEcWh5dW85OG05SkZWTnJmcm0xb2h2ODdBeHVXM3NN?=
 =?utf-8?B?cmlPT01EN2xrNWwzQVIvWitNWXE3bFBxWVlIYmcxWkxvOFR2eXIwTmRKcEZW?=
 =?utf-8?B?SE9kL2EyVXh1dk94Z1orL0IyYWZoQ3hsbW4vWGZmSlJLVVlUK3FpbDI5eXJI?=
 =?utf-8?B?dFRScGRrbFNVUEZTTmxrSmRxM0hiSVlDZkVHb1dvMG12VmNVUGhFTjEycmtX?=
 =?utf-8?B?Nk9Ja2RUUkw1UHA3WU9MUkxVaFBhU2hUbHQ5eGJsREpZcmFIMzJiN1BZUXBI?=
 =?utf-8?B?Z3lMcHB3UGt4Qmt6cjBpMGlEMzRXTWdNaDBtT29HaldrNjNrNXVITmErajhl?=
 =?utf-8?B?WExnNW94VWJPa2U0SUtHRkRJVHFxaU02dG1ZZkxKWTY3dTVMT3ZhTzZ1V2Rz?=
 =?utf-8?B?RmFjOXZtTnRyN093T0JESDdlSW9OOFlkeWRRRGVLMm0vM1dSdHpmakZNUjFD?=
 =?utf-8?B?L2FsWUpJVm81cm9hb0YzU0ZxVUFkNVM2ZmtSOW9uSlBmNU8rbitQc0ZVejdP?=
 =?utf-8?B?QUdNQ2VIeDlIMTFOeWJpaHBHdC9SK29CMFNpSFlBWUNRdk1ZZ3ZTSmhVTTVY?=
 =?utf-8?B?Q0dBaGZjOUh3WDZLblMrSXVTK0xEdzNoQnRuMmFMVitsbXlFUUtOcjdUZy9y?=
 =?utf-8?B?LzhHYkNwOE1ySkRGMklWWHpva24wSENEOVkwYjZieTBPaC9pQjhkTm1KMVRa?=
 =?utf-8?B?Z2QzTzQzTlFlM1JTRk1xTUg3bkpHVmN5MWdkRXdNTi9iM0kyb0JlOGNFUVp0?=
 =?utf-8?B?bERDMnNCdlZQSHJSb3NPV0cvR3pvdk9YNHBiRThXVnJ4Yk1TRGdjeEVlVDI3?=
 =?utf-8?B?cXBuYnhFM3psdUJLWmpnMmdvZk1jeG5YUkpWWm0xaFNWdlZ1NEFaS1QrWXpS?=
 =?utf-8?B?WExBRXZXUklXNUJ6TWRqRDVVRmtBYmw3QmVvU1NZNTRabWpmVGR4SlljaFlL?=
 =?utf-8?B?Y1daWXN2eTlCL3lOT3ZxUVJlVlZGeXE3TmFTU3d6Wis2Mm1oemlCQ1ZGUHo5?=
 =?utf-8?B?cndyd0FHVXRrQVI1UVBUcXcveXkvYTFQTkVWNzR3K3BZUkJUUUREWVZoTy9r?=
 =?utf-8?B?UEFYdGhCdllycXlpMnV1a1B5d1MvNlJjOVZ0ZE10bzc4L1A2T3VvTXUzM2F4?=
 =?utf-8?B?RmZNUXFMQ3FsOUk2d3JTcUJDNnhUenQreHVhZUQvZ1lHMDRSMVF5S05FNzh5?=
 =?utf-8?B?M21CQ3k1eFNHbi8wa1hWcTZYbW5JYzFCV1BocWlsU0xGd0RNWW9EOERjNGo1?=
 =?utf-8?B?aytnQTNJUTN0a2lqUTdKdm5sZ21OOVJiZDRURkdjZzZHZlIxV3Z5dFE1U0t6?=
 =?utf-8?B?TUdwUlBvTWxCdzZSN2V3b2ljYXJiWjQ1eWdaNzNDbnNqczdUTFhDeU5mb1l5?=
 =?utf-8?B?UlhQTk10UHBrVHRyYUZ6YklERjlvVGRUbnhtN2g5aFlmLysvdEUrTnQwL3VT?=
 =?utf-8?B?RkhpSU1SNC9UMmJ1dzZ5NUIrRGNXVm9EY0I4VEh1K0ZYUXZZM0d1N3F5eEVy?=
 =?utf-8?B?U2dHM21TOW5WQlpudkJnVDlGRjV1RnFDbk03ZytxQW95TVFzZmNQNGIreGFq?=
 =?utf-8?B?UDdsblpIMVhTME5aUlpWajhjWFBsejc5MmM2WGkwaEUyM1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZPK3d2S2VWUS8zMEpmeEdrOHllaXJURG9LR25rNmYycTB0d0JXYmR0d3lh?=
 =?utf-8?B?SGpKd0lERU5ORHliVG5obDVaT0h6MTNqODdCeklsazlZSXZjVlJlSkx1QmUw?=
 =?utf-8?B?KzNvVjg4WDBzUDNoMXg5WDFMaGVpL2JwV2JreXRPTjFRa1llQ3FYWlFlVlUv?=
 =?utf-8?B?Q0t0MUFCcU5Fb2RkVGJRc09HeU1ST0FSSFBTN1B4cjRZVXRMcWhaSTV3UVBu?=
 =?utf-8?B?TlVqN2ZJY0NxWEhxVkhUMkhmY1M5bEQ2MndtUXh1UzdTY0lnc1JwT0dUSnVs?=
 =?utf-8?B?UWluZDIxMXFTZmtrNW1nMlZ4SHdza3JvTTh5T2dta2RzeDZnaCsvZ3ZSdm0v?=
 =?utf-8?B?T3VPRWtyMDFES1QxS1MwMkc0a2dnTnZyS28yOTJ0T1B1YThMTlVRYStzbDg5?=
 =?utf-8?B?SlJCaDY4ZXExWVlabFVFQ0FqdW9mS0p6S2hCc2VwQTFJaGRCWVJzTm5kcVNH?=
 =?utf-8?B?ckF2eFZmcG8ySndRZ1hvQURXa3VKTm1ta0R2dzV4REdTWS9kaFhYV3ptLzli?=
 =?utf-8?B?VVJTSUd3cXBpQ1pKWnNkeGlCRlVTMkpqWENJNHlnY0R5dTl6NjZ5Q3IyTmFE?=
 =?utf-8?B?b3NKYmpZQWJNZWF3SGlNRUJkTU9ONUI0a0VoZnZydDNwKzdvcjhSa2pGZWRn?=
 =?utf-8?B?bWpPQlNlVFV5ZFFtV211c2hFQ3RTZ2J4ZVlQWTQzUktaSUwvTG9oQlRUT1J6?=
 =?utf-8?B?ZXhsVXk4NmRrZmFLZ0U0SXYxVkErMHpnNG5lNEdtdkxmV0tMSmpUVXVYUjJu?=
 =?utf-8?B?UDFMTXU5MkpEdEJxM3pLdkJRV3NyR0d6N0lESjJ4djBUNzluL05iYzNLdVZu?=
 =?utf-8?B?Z3hDU1NHWGp2Z1hFRmowOWFXUWxnbkNtczlsS2U4cUhKdXEva1ZHVDk5cTg4?=
 =?utf-8?B?bjczZ2sxTEVMaVI3bHFYZzdYY1pLTFBpemx4NTRVeXpLMWZTbC82bHlIZ0c4?=
 =?utf-8?B?RDQvTEVuNC81MnZFVHJCSG4zeFdMWGFZcSs0cURORllDc093SWdnQThmUkpD?=
 =?utf-8?B?ODNKWThLN1J0eFFjVnI0VFk2OGJJQzFzQXN5N1ZVY0FLbDV4ZTRqaElid3Bv?=
 =?utf-8?B?NXFjRXIvRGxhTjdoV21KZUdXMnc4NkpBRUNHSVQ0Q3lISDJpYkVpbHg3eGRQ?=
 =?utf-8?B?NlFRcEVKcjgzdER3bUE4S3lNTm5xdE1vajRPaHFVN0ZwTFpDVldFTFlYN1kz?=
 =?utf-8?B?VWI5bStqZ1pRbUZuZWd2L0cxRmEzVVI1eG9JMEJPdnBhcm1wc0ZpeGExOXh4?=
 =?utf-8?B?YlNoVjRvUm55dlJZVGZIK3JnNXVnbGM4N1Q3MjNzS0FTODJPcEdxOUNqUUlS?=
 =?utf-8?B?N2JvcGxCYVllQUFhNFU4YTNIWjkxUjZUSVpKYnNwWmxnTjhteHBDcXdaaU80?=
 =?utf-8?B?Ly9SbzJIMXFrNmw3SUdZVElzcm5FSldzTXNzcFBKT29xcE82YkpVaWo0Mldz?=
 =?utf-8?B?WVZ5N0tLRTAzb0FrVGl3WHNweE85VTFBcDdNUWQwWHFCRklKT1NWMUNhcVNQ?=
 =?utf-8?B?S0JKYUhjanNsSlM4SWVid1gzMFJCdGRIM0xOWW4weXBpZkIzWE0vQitaSk1u?=
 =?utf-8?B?dzJla0VXVXZwTE40WTRMWEhGU25ZZkxrVnVEdUpEYWRDdzc0bklhbzFudkU2?=
 =?utf-8?B?UUhkYmVWT3c0cnkyTnFWUmQ5VTBTaExNQzl4N1RQMXNWMWxBaDlRNHRKUzEx?=
 =?utf-8?B?VTdhZGJkNXBmcEw3QTNreXZLbW1mbEdFaThkOGozUTU5RVliaU0ydklHS1Bs?=
 =?utf-8?B?WjdPb2ZWUTVjVVVQZGJMTldpYk1rZTJoMG5WdjF3aGpXVkNSeW5rZUpLUHpq?=
 =?utf-8?B?OWdCcTFtckhUZFYxOE40cmczOTlDUmVCSzRnOCt3SmFaazd2TkJKSkhVY0Zr?=
 =?utf-8?B?VnAxK1Jhc0hZbHlWWjlTdkI3a3Y1RUViU1NKN2hyUTNmanhNSytrS3pzUDJY?=
 =?utf-8?B?NE5wRjNOQnFxZitkSzNqU0YyZXpHZVB3bnBLYjR0VUZsMk5qdGtlbCtmYVVl?=
 =?utf-8?B?SmNLbjRzQVRUYkNNbmRCcHhHVWIxM25XTHRHZkp0UWVlNVI5bW0xZ0ZFTXB0?=
 =?utf-8?B?bFFQOGM1ckxFcDRKUXhzeTBjOGZLTEdNOTk3bDUzaE1ZaHA4R01pa3didDdY?=
 =?utf-8?B?ZDNWaHlPT1c4Ty9VNkxHSkQyVkpySi83QXVUbFhMcno0eXpnL3dKRmlFU29r?=
 =?utf-8?B?TDAxelpvcXRMQnZrSWZnWmdhMkY5VGxrNWt6WEJGRDJyZkp4YVlTUVUvUGtL?=
 =?utf-8?B?WTlyMUZqWUptVzhOdVYvT2h2SytRakY5VnVPZDNZaDZ3YlRVS3BhTTVxaXE0?=
 =?utf-8?B?TEtGeHhySXVkZ0E2OG9yWEJmUDI1dHByaEp4YTVDZzJ0QktuNXFsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55823367-c864-4a73-2083-08de4dd232ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:50:32.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocTJsko3LTp1Nca1uplRorCjoHQsrou5TOeQq+U1JnVYMrEhF3ALmHQKTiiq7b3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

On 1/4/26 22:17, Mikulas Patocka wrote:
> If a process sets up a timer that periodically sends a signal in short
> intervals and if it executes some kernel code that calls
> mm_take_all_locks, we get random -EINTR failures.
> 
> The function mm_take_all_locks fails with -EINTR if there is pending
> signal. The -EINTR is propagated up the call stack to userspace and
> userspace fails if it gets this error.

That is perfectly expected behavior.

> In order to fix these failures, this commit changes
> signal_pending(current) to fatal_signal_pending(current) in
> mm_take_all_locks, so that it is interrupted only if the signal is
> actually killing the process.
> 
> For example, this bug happens when using OpenCL on AMDGPU. Sometimes,
> probing the OpenCL device fails (strace shows that open("/dev/kfd")
> failed with -EINTR). Sometimes we get the message "amdgpu:
> init_user_pages: Failed to register MMU notifier: -4" in the syslog.

Yeah, that's because the ROCm userspace components doesn't work well with signals (and that is documented) but that is not the fault of the kernel.

Could be that the kernel driver prints some incorrect error messages, but that's about it.

So as far as I can see you try to work around problems in ROCm userspace libraries. Please don't do that!

If you find an issue like this the correct approach is to fix ROCm libraries instead, most likely the thunk component.

Regards,
Christian.

> 
> The bug can be reproduced with the following program.
> 
> To run this program, you need AMD graphics card and the package
> "rocm-opencl" installed. You must not have the package "mesa-opencl-icd"
> installed, because it redirects the default OpenCL implementation to
> itself.
> 
> include <stdio.h>
> include <stdlib.h>
> include <unistd.h>
> include <string.h>
> include <signal.h>
> include <sys/time.h>
> 
> define CL_TARGET_OPENCL_VERSION	300
> include <CL/opencl.h>
> 
> static void fn(void)
> {
> 	while (1) {
> 		int32_t err;
> 		cl_device_id device;
> 		err = clGetDeviceIDs(NULL, CL_DEVICE_TYPE_GPU, 1, &device, NULL);
> 		if (err != CL_SUCCESS) {
> 			fprintf(stderr, "clGetDeviceIDs failed: %d\n", err);
> 			exit(1);
> 		}
> 		write(2, "-", 1);
> 	}
> }
> 
> static void alrm(int sig)
> {
> 	write(2, ".", 1);
> }
> 
> int main(void)
> {
> 	struct itimerval it;
> 	struct sigaction sa;
> 	memset(&sa, 0, sizeof sa);
> 	sa.sa_handler = alrm;
> 	sa.sa_flags = SA_RESTART;
> 	sigaction(SIGALRM, &sa, NULL);
> 	it.it_interval.tv_sec = 0;
> 	it.it_interval.tv_usec = 50;
> 	it.it_value.tv_sec = 0;
> 	it.it_value.tv_usec = 50;
> 	setitimer(ITIMER_REAL, &it, NULL);
> 	fn();
> 	return 1;
> }
> 
> I'm submitting this patch for the stable kernels, because this bug may
> cause random failures in any code that calls mm_take_all_locks.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Link: https://lists.freedesktop.org/archives/amd-gfx/2025-November/133141.html
> Link: https://yhbt.net/lore/linux-mm/6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com/T/#u
> Cc: stable@vger.kernel.org
> Fixes: 7906d00cd1f6 ("mmu-notifiers: add mm_take_all_locks() operation")
> 
> ---
>  mm/vma.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: mm/mm/vma.c
> ===================================================================
> --- mm.orig/mm/vma.c	2026-01-04 21:19:13.000000000 +0100
> +++ mm/mm/vma.c	2026-01-04 21:19:13.000000000 +0100
> @@ -2166,14 +2166,14 @@ int mm_take_all_locks(struct mm_struct *
>  	 * is reached.
>  	 */
>  	for_each_vma(vmi, vma) {
> -		if (signal_pending(current))
> +		if (fatal_signal_pending(current))
>  			goto out_unlock;
>  		vma_start_write(vma);
>  	}
>  
>  	vma_iter_init(&vmi, mm, 0);
>  	for_each_vma(vmi, vma) {
> -		if (signal_pending(current))
> +		if (fatal_signal_pending(current))
>  			goto out_unlock;
>  		if (vma->vm_file && vma->vm_file->f_mapping &&
>  				is_vm_hugetlb_page(vma))
> @@ -2182,7 +2182,7 @@ int mm_take_all_locks(struct mm_struct *
>  
>  	vma_iter_init(&vmi, mm, 0);
>  	for_each_vma(vmi, vma) {
> -		if (signal_pending(current))
> +		if (fatal_signal_pending(current))
>  			goto out_unlock;
>  		if (vma->vm_file && vma->vm_file->f_mapping &&
>  				!is_vm_hugetlb_page(vma))
> @@ -2191,7 +2191,7 @@ int mm_take_all_locks(struct mm_struct *
>  
>  	vma_iter_init(&vmi, mm, 0);
>  	for_each_vma(vmi, vma) {
> -		if (signal_pending(current))
> +		if (fatal_signal_pending(current))
>  			goto out_unlock;
>  		if (vma->anon_vma)
>  			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
> 

