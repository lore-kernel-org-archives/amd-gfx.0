Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3894ACAC598
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 19:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAF310E586;
	Wed, 17 Sep 2025 19:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=windriver.com header.i=@windriver.com header.b="dIytc7/v";
	dkim-atps=neutral
X-Greylist: delayed 514 seconds by postgrey-1.36 at gabe;
 Wed, 17 Sep 2025 15:53:28 UTC
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567AB10E0A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 15:53:28 +0000 (UTC)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58HAc8np576337; Wed, 17 Sep 2025 08:44:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=content-type:date:from:message-id:mime-version:subject:to; s=
 PPS06212021; bh=MwCVnLkaJuJn+/oTD40cPN1ZJYGNcbPbODJdAHlLpzo=; b=
 dIytc7/vUxnb/9/jkmMnmxEkTdkYGWgO1ScZCy7LPmafO5dfSn6NPzzXdS8ELlPs
 XIjt53/Ohd0IfMsGuNNq8Noao2TLMCXxPzTseElFxQQ0mJC8s+dIwHwDdcp7BsEr
 BoQyl/4Nl0ejENiFT2Cw3qAKV1JJDM0gqeVtBwjREQ2f0SO8CepEvfrDm142BwwW
 1I8RyevASHF6Dc7Fqm/LM6ew+LguKtSzL9WhMB/3m2BIeEr2xvR9hOLzJqxPZtfc
 yswhL7FwoOqTEHrM9XeXOp+jG5ONdJjU5qJjqZGL6+iizWlfDyi6pv0Ut6N9/Fu9
 7hzoenhnMgDGYBUUe6Yd+g==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 497fwr0w7c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 08:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0oYJ0+fu9n83SzQdQMWKvBdxbukZv+4548p2WnEvJU1uMYJYpq0uPGBvXYUxwc0YSp3HNgdDvjdT2iUGFYCDMMdD/yUdGpWE6TgjXyIyaLioPRXgVH7Of6k/KIRRuLlyILuh5C86txTZpFLbdi9zcwEsfqUx2vXChqJCSE8xqxop93Er9/VSbRe2TlF4WpUgO7SkkA1w+CfQsokl/2owUySFxux2094IfA+fkS+0DZBTFEng1nIRqZ32Emn0TOBUh4y5X7Pk/w4afN9jKzjNPTU+BYtvSIHyixsRoqw56VI6D2Nh0uWoOyw1lx+0SJ6z/V6SpPO0aMC7whCaARnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwCVnLkaJuJn+/oTD40cPN1ZJYGNcbPbODJdAHlLpzo=;
 b=SnIzhl0lCn7YSAgcIYBjqu+W6DkF7vKLgXrStlcquRc+DCh+MJzYwhytGdnelxRlq1IYnueAEb447SVxJOhFHft4lN8y2cGOAFyBWKtqIR9UsDnOCS3h2JfdJpJ+LJwSpUC22/JBq9sWWpGkRAGmbB+dIHr74aAogZTfd5R6jl4Go1ShQvxPf1wjTtXDy855e9nFyw7pBFBqfiMPEFCcedvh3UXemf0GcUEiWFAKfXLsPVOETK5iecwFmWrldvkCUW1W1WuhWiXUNyHE591wiUawytcnXJ8amwY74eraJPDsV8tBFD9aWb7mbPMnFoktAebR1sG2Jpb6kz7lIQwUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by DS7PR11MB8808.namprd11.prod.outlook.com (2603:10b6:8:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:44:49 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 15:44:48 +0000
Content-Type: multipart/alternative;
 boundary="------------URJS0Cggna0F4SqfCkz1zKs4"
Message-ID: <5e751340-24f5-4542-a340-df622d64bba6@windriver.com>
Date: Wed, 17 Sep 2025 09:44:45 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: questions around driver for AMD Instinct GPUs (for AI/ML)
X-ClientProxiedBy: BN0PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:408:142::8) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|DS7PR11MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 284bf4df-1b35-4bf9-ef0d-08ddf60121bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1RFVFRxYkhERzJnZXpJUFZiZlZIN0VVSTNzV2ZGTFllNVEzMFJweE9YNEtZ?=
 =?utf-8?B?UWhsUHh6ck9FY0tSQmJOOHdjUzlmc0o3VEdydExSZkNDbXRqellWclVIM1B3?=
 =?utf-8?B?TjdVbTZua2J0VjhZSGZvNTNjUnhPOVZHVjMwTERoeWpqOWZQb1Y1UzF2eXV1?=
 =?utf-8?B?NGFkRDlXVmorSG1oSkhkREprU2pzZDdSV25EVGlyb2xndzZnaGxNNERUYkN1?=
 =?utf-8?B?d1Z1WTU2RWwrQXVWWXVxZCt3MjloZGxXS2NiSzFTSGh1ZWZNNit6YlNkbHRz?=
 =?utf-8?B?NW9wMlNHa2pWOVdsYkdJZ3F6UFFNR3ZiT3pYbkhDeU90bmRkQWNxMEJjdUU5?=
 =?utf-8?B?VTc3cld3cFFkUWozc0tCRnNRQnl0NHhSTG03MWJUSXN6am51dlhBY0pwMUcy?=
 =?utf-8?B?OXFZT3NpNXpVRFoyMkJ3bWVvMHNKOStoU2cxUEJaS0lGK3c1WEJmdjB0aUpa?=
 =?utf-8?B?dFJadDA2WERLdnhFeDR2L2U4UW4zcFpDVVJ0TWZCbVYzSVhtbFRmNDdBVkpR?=
 =?utf-8?B?RHRKamUyRTdzbzl3UHFaWm1xbGVpT3RuTFRlRHZtbURDbDN1dUNVdUJoclBy?=
 =?utf-8?B?THRKMFV1SzM4TFpJTU45bTVzdys3UG51ei9xUTcwOUZMcEpzNjJ4K21GU3N1?=
 =?utf-8?B?RFVFWDNLY1VVR1d6QU1ZZDhjTGlkRWNqUEVsaW9wcUdLU3R3LytuOG5FTTlu?=
 =?utf-8?B?UzVFYThPQWt5Q2M3RmxxQ2ZIVTUxZ2RkQytGN2hIOW5wSzhJS092dXgxMGR2?=
 =?utf-8?B?Qm4yaDNSeWg0STdCcGpXUVlXcGNTa0lhWTJDaWZpRnRwV2haTHo0TTl5WWt6?=
 =?utf-8?B?NzRBVlhBQUNLRFZvK0J4M1BDZ3h5d1ErV3IxaVdvVm9VRWtUeW9maVU5ZDhE?=
 =?utf-8?B?MDd3Ny9nMkhqU2Z3UkhaUkxiM2RHQmF4SVJNSGovYTJ3QXdOQ0tWdjgxNExQ?=
 =?utf-8?B?ajFyQVBGZVQxOE9xZSs2aHEzOWFaVE4zQXBPbldjMkVSSVBFSG5kcUZobEha?=
 =?utf-8?B?WXFkcW9mQ3k1dHNjSUtYdVZxQzUzdkkvUDdhQTd3d0ozenJVNXZyUy8vU05U?=
 =?utf-8?B?UFRISmpWdC9DVUdZbkc1Z1ZhQVQrdWdMZDh2TjN3YVB0YU1XT1NPdjdDS1pl?=
 =?utf-8?B?aTNmMzRNeHRaem9ITElMQjBSSjM2S2FXYlNzRFVJVytUeUhvQklLV1F1TStP?=
 =?utf-8?B?RWV5ekNjTXdZMVc2d2xoQVZpM0wzMTlNU3VwSmFpbFBhV0ZIN1FDa1RlNU1Q?=
 =?utf-8?B?SGFCQWFGbWJ3RjJCUE80NGEraWJ0RWZ6NEt3ZTFFZU02VXhhUEpYeUJ1RW50?=
 =?utf-8?B?cjljbjdFMHZRSVZmL3RobWoyZG9NdnhycWQ0bGhGRHdDWlpqRlZ2cEJVTG90?=
 =?utf-8?B?STZQdk5iYkFvU1JnaTZpaGhhR01pQU9rQUJDMUhaNmFnMFlodi9LKzBrQS9u?=
 =?utf-8?B?dmdGWlRodHZBRjgzeEFybExuWHRlOUVPNklvdTFjK0UwSmpMYnc1UHoxbFFU?=
 =?utf-8?B?bkxhOGh6cjVYR00xZjRiSHNvZHNZcXN0SDVoNVd3WVBaN0srY2I4SnhDUThs?=
 =?utf-8?B?dGlDNnU1ZXJRY3VKYUxqVHdOWjNDV29NSG4rVy9rMVNLYmR6WlB4ZUk0NUJW?=
 =?utf-8?B?enl5bDJyK0tMankrS0pGZmhVN2g1ZmttcTBZOFlaWWNxZkh3S0hYVzdXQWFI?=
 =?utf-8?B?aUlKeEw2ZStaWk15TEdoeFRES2RIRjlZblBJVXJxbWpWbTd1c0dXanNrT1Zs?=
 =?utf-8?B?OTh4UUp4Y2JReStFbnBINjV0R25CTFZENEM5MmpVTWFoUFp0NnE1Z3JLTmZp?=
 =?utf-8?B?aTlzd0p1cVpZQWg5ZXdoY0NaUjFoZ05XeWhoZFIwR243QTdNOFIvNWk2dlBN?=
 =?utf-8?B?ek05aklzaE5TVURaRGJyeTdKT0gwM0tiUXJjZDJaVk92c0RNellieUJEL1VS?=
 =?utf-8?Q?gCk4Kju9ADc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB8806.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5PRnJSaXNNNE1TSlVYQzNDRWpNVGg3eW9uNGZWNTlsaXp1eDEzS1Z0SVcv?=
 =?utf-8?B?VkpHNHZUSHBJWTBsNTZSbjR5ZHo1TWpWa2k0Zm16N3VLQ3k5QVdWeHg5VlRU?=
 =?utf-8?B?bEtndC96cWJxcnpFZlRWVkl0RGVWUzhqVWJsdTJia09uYVB6TEh4Nko4WHQ5?=
 =?utf-8?B?bXE5TlVUYmdURWQ4YTNjUzl2OS9wOWg1TC8vQ3NQY2k3UStLWlAyMzlwc0FE?=
 =?utf-8?B?bnVkZHJJSkM2NEdkbWFxMFk2T1F4bW5SaGM2d1hjMWd6T29ubmFxU3VjOWlB?=
 =?utf-8?B?Y2hiS3Y0QUdxaVNkdEp4VGlzRFkyUUp0WWJJQ2VxSENabXNvM2lBZk4rS0d0?=
 =?utf-8?B?YkVzUXlKYVZRRi83Z1Y0Q2tuZ1pMOEFQdlZISnJXbkRPTER1MnQ3NUdYejd0?=
 =?utf-8?B?UGNJLy9uOGZBSCtQVGZoNHp6YnN3NG1xb2ZpWkVPK1hEd2hYdFBFdEhwUEdz?=
 =?utf-8?B?Q2lvV2MrNkpLU0RLM2RjYUxtZVhPa2drd0hDQWpHNG5zU0k4RkxBZVoyMTR5?=
 =?utf-8?B?TEZ3WEQ3RUxiU3RLRGI3MjhHWmdBTlNXVkdMWlE3VEZ5SThTWW5INWRTbzhE?=
 =?utf-8?B?Tk82R2FMb0NMdERUdUtqNHJLVm80Y2pwR00vcW80L1gzYmtjSll6eFNQbHlP?=
 =?utf-8?B?eVhyNVE0OUZoZ1Yra3pkSTRYK0IzTG9xTEVwN2xHdjBoa1hNd01GZ2pkUm5i?=
 =?utf-8?B?SElWQS96TXU2N1h5SnF6WnJGWUlJMk5obUhWZXBxVFpCOXF4VG5TbHpBaWZC?=
 =?utf-8?B?SkgxRjY3QUlQbC9ScE80ajNHa3hvODNJUlRCNFlNbjJITGV0MkppWW9VS0d1?=
 =?utf-8?B?LzdxNE1zOXE1SEFPUzA2dG1CWFFORHlIcjVPd1ZmQ3ZCcW5DdlNJaHlmbVB2?=
 =?utf-8?B?SmRRZkZFbzBWcEI2RWpFOVRVTS8rVnFLdXo0TVNlVFdNdFZib2s2TzRoRU4r?=
 =?utf-8?B?dWlGckxVTnRoNXZhcXozd3I4REoreHRYdEtpZkIza1dRdXUrTWFrSTBkTUl2?=
 =?utf-8?B?blNXd3pWeUo1RXlZVGRZc3IxQW1GVW5hR3Z1S0F1TXJnb05vdE8rZjdOQTFE?=
 =?utf-8?B?cm9QTXNSSVQvb3ZlRDZmNlpycTB3VmN0RzJJaGxqM2t1Q2djdEJ3MVh5M0gx?=
 =?utf-8?B?QUdFdlFHS25zZDkzZTlHRkxaVWZtRWwyMTBtVC9hQk00M1ppc09oVjlzVlBz?=
 =?utf-8?B?SEtrMitka1BRaVRLemwvTkhjWjEwcm5kVFhFU2o1Q0M3RThKUnhiK0paWFVu?=
 =?utf-8?B?RHVJYkNUcXBFWkVxM3NiRHpaaGV4bjdNek5lUHg4RWY1UmNTbHhHeHRSNHl1?=
 =?utf-8?B?NnpTN0hJOVNMb2JQRmdpRHdBL25nRzRBV2dEQ25WWmFPU1Bvd3BGNTkwNjFi?=
 =?utf-8?B?Z1Uyc0FzVW43b0pxNUZveDdPY0ZLZ09KOVNEYlR2L0NkZDN6WHZzcXNqbits?=
 =?utf-8?B?OXpkN2lPMFRIV0JJOXV1ak8weUxtY1RoYVZ4bk5KMnRDMXpYM3JMSUtHS2xv?=
 =?utf-8?B?MnUxcFZoYUp0SHFJWlVGaC9LRTk2NnFFNWNlQzRWaml1UzQvVDJwY3NMdGVq?=
 =?utf-8?B?Q1JkZ2ZpSkpHN21TdDZOZ2syVGJab0kvbXhtNFd1RC92cXliazVjNEtKS2dU?=
 =?utf-8?B?U0FxRHdJcnRGYmwwemMwS3FJRkxpaTNQeDJqWHduZ21Bazk4Mmpod1Rna0RM?=
 =?utf-8?B?N1Y0UXNIaWFLdlhQcEY3a3JFR0lnQkVBNTNYaG1xeFhQNnpKbGlQclM2SEtR?=
 =?utf-8?B?d0M0aXU0Y3VXRGwxcFhHSXl4Q0tSTFJDMUt6WkJxYS9RK2ZxNDRCYkNzQlhV?=
 =?utf-8?B?YThqa3VXOEQ2M0FlZndKVnJGd1psRzJ4V2ZzUTBtY1JvUHc3RFBTbmZzWm1o?=
 =?utf-8?B?azhqc2ZhT3IybVlKS1JHSGNjSTFTNFJmRS9TdGZnU08yc01MVldjYjA3SE9I?=
 =?utf-8?B?UGovMHgwSVJZSTBlRU14ZDRJbHlWT3hGM2lBOGh6eThNMThqaTk0WWhPU0Rx?=
 =?utf-8?B?dWdBWHRRQ3JEZlNlbC9zaWE5d1dJZ0pLVjZ2ZGM5TzREK1ozak1wNldVRnBu?=
 =?utf-8?B?RlRsdnlOTDJzN3Q1M1BnQUEvRmVEMGNWc2U0QWhack5pdWd4a3RDTk1vQnJD?=
 =?utf-8?B?UkJWWDBNUWtpN2k2My9tdFJaSVo0N0JIYnRHOTh1VzdEUEo0SG9KUFhQaVor?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284bf4df-1b35-4bf9-ef0d-08ddf60121bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:44:48.8576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8NlbnjT4yXtmMsbt9b7DHqVvMvWlRnV0aSmMMSJ2sJ4tklz1VzR0bRB8NqZw9Asfbch38VcYMrmkaEdSBUEEc8yiHlOGf8S2zRmqMOxET4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8808
X-Authority-Analysis: v=2.4 cv=Jay8rVKV c=1 sm=1 tr=0 ts=68cad773 cx=c_pps
 a=W7vQ9/Pp6pMPjVhEX4N8+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=zd2uoN0lAAAA:8 a=9nuoZwFb9SCXz4p33PgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-mYYMuPxZR8A:10
 a=-UC-E6RliN4zp7y7KOgA:9 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE1NCBTYWx0ZWRfX1MfYxnSExi/k
 A6tY+Fo0rMuuPCTJbRzHo+tWSxneEB5GvdjxQW+DKYUWmXbrty1Lnw3eMdZRBSlTDM3e0U5T+4Z
 /Ob94aBQOHX29wf04GqFC1AIXUOMv9tjrYUtCAmeVm1N641mO65hrn8Xj5yCpFNTSNC1YxJAR7a
 rp0RlKaNROeClP5+b8ymDpDOpWDebkCFqq6jss9gL81L0dovhc8aH75Spm8grHe2r+vPCObEdua
 0wIfR3bCRwOm5MP+uLMXNZfGbYlYfIQcCQp0WW9JhBUQvo5KaU9JB8x8pIRPSFsKZC8GdZk6ZYi
 ZGWnRzNQREQPRg9d3ER6O7CMAVecl7bj7xJG+cRYdWOkeT879+gktWw3et5gTw=
X-Proofpoint-GUID: YZkxWoJIPYK5pNwNFfxrL8vOCssB48mX
X-Proofpoint-ORIG-GUID: YZkxWoJIPYK5pNwNFfxrL8vOCssB48mX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
X-Mailman-Approved-At: Wed, 17 Sep 2025 19:27:07 +0000
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

--------------URJS0Cggna0F4SqfCkz1zKs4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I'm wondering if you can give me some guidance.

 1. I'm just starting to look at the use of AMD GPUs for AI/ML
    workloads, and I'm wondering if there is any documentation available
    on the tradeoffs between the in-tree and out-of-tree amdgpu
    drivers?   For commercial use should we expect to use the
    out-of-tree driver?
 2. Are there any known issues with using the amdgpu driver on a kernel
    with PREEMPT_RT enabled?
 3. What's AMD's policy on backporting in-tree driver improvements to
    LTS kernels (6.12 for example)?   It looks like only around 10% of
    the amdgpu changes going in to mainline are being ported back.

Separately (and I'm not sure if this is the right place to ask), do you 
know why the ROCm compatibility matrix[1] indicates that the  
MI355X/MI350X/MI325X are not supported on Debian?

Thanks,

Chris

[1] 
https://rocm.docs.amd.com/en/latest/compatibility/compatibility-matrix.html

--------------URJS0Cggna0F4SqfCkz1zKs4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi,</p>
    <p>I'm wondering if you can give me some guidance.</p>
    <ol>
      <li>I'm just starting to look at the use of AMD GPUs for AI/ML
        workloads, and I'm wondering if there is any documentation
        available on the tradeoffs between the in-tree and out-of-tree
        amdgpu drivers?&nbsp; &nbsp;For commercial use should we expect to use the
        out-of-tree driver?</li>
      <li>Are there any known issues with using the amdgpu driver on a
        kernel with PREEMPT_RT enabled?</li>
      <li>What's AMD's policy on backporting in-tree driver improvements
        to LTS kernels (6.12 for example)?&nbsp; &nbsp;It looks like only around
        10% of the amdgpu changes going in to mainline are being ported
        back.</li>
    </ol>
    <p>Separately (and I'm not sure if this is the right place to ask),
      do you know why the ROCm compatibility matrix[1] indicates that
      the&nbsp; MI355X/MI350X/MI325X are not supported on Debian?</p>
    <p>Thanks,</p>
    <p>Chris</p>
    <p>[1]
<a class="moz-txt-link-freetext" href="https://rocm.docs.amd.com/en/latest/compatibility/compatibility-matrix.html">https://rocm.docs.amd.com/en/latest/compatibility/compatibility-matrix.html</a></p>
  </body>
</html>

--------------URJS0Cggna0F4SqfCkz1zKs4--
