Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2388CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204B210E091;
	Wed, 13 Aug 2025 23:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dzUxfWT9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261E210E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM5Sdt2T5rNXeImDDg/RqCZysXuzhhPLB6J6vACz7Jyxmy/nGv7WfheZWEROWFBYg9EVozHVMD3A254JCsem9OOc97/EkUmNIunAhIJnZpkL02Bn6c0z5EMiL6vA/DDMAWAFxYmziuG5CfhCIIK3yMWBP3RbQe6iE+YFVOZADsVUAp4Ygly6ruJzTh0a7r8IybXCwrOhlSEammlatpQPmakNALaXl2MDWggwAbD9NeJiOOLQCJ5SUnT2ZyOqto+CIMZ7GCee38SDMhRQegUd1wxfHQqL0DdTnM4/bluRjJ33qhAdR1Mw6MNsHDUWEihI/TTneNvAWe21LlmBSWVJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CUq6O3R2yDZ0pKj4wQEL4XCIyKKLHtiZIRXEohJVCM=;
 b=TzVKchV8r/M2hlKHlzbASWGm+o5lTX8xWnBkID4aoO9aZXolSEUauSpPBSaeKQYk5DbXUsk6FQIp/tc6cVt0FGAJMEUEmAzBU9uKxiH/K+jngjOpsWRxA8UBxyzRHe3YZA07qmW858bBFI1VD1mkbGWori/IRnhKv4RuJdrPDrfI30H0DV/ilGDzE6RiMAzE3ZRYwo+0Gv+oZE51HcRnzZ7gdJ4CG/pjbqWsPnoZ7A6s6Ix44x8Tc0XqCeMxbHqoeVkcRe4RfD1dhrLBkK7wgzfLBaM5oYcZ5m91x7+ofni3up7i3w6JXopVzZmcKI2keFNAsPz177tIWJBGsxY/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CUq6O3R2yDZ0pKj4wQEL4XCIyKKLHtiZIRXEohJVCM=;
 b=dzUxfWT9x47M9Sg71H5k3ADGQHPA1SWP9uLysbP4PV93xhHqvFStGjeZwCJtWkjp/xAQ/O++KjS+lElYBApKKXWqhdhzk9Q2y31qcTIXS4SA/budlmNorNe+0Qttz08cmrBRzW9WPjcFp8uIxolHYZNSioGJ6JfmggvFvbIFOVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 23:13:26 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 23:13:25 +0000
Message-ID: <422ce379-1a56-de36-c040-6da658dead63@amd.com>
Date: Thu, 14 Aug 2025 04:43:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 30792cba-c135-4b71-630d-08dddabf017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlJRMm5lSGtmSFV4SE91cUNESG10dk1FNEIwV1JHa1k0czV5bVJSbE91WGpV?=
 =?utf-8?B?TVVtSlVKMU50UnVQQ1lHNlp6ZVlqYmtDc3hBcjJTdjYwR0I2a2lxdWpwRGpK?=
 =?utf-8?B?alVCcFlwazNDeU5zbFMyaGRPRG1RcDNDNGV5QXVheGppRVh5aDZOMTRZMjF2?=
 =?utf-8?B?TXdGTk8zNHoycG5YN0l6MzRxY0ZESWlSQ3Y4bHdnZ1pmWXhlbUpOS1k3UnRQ?=
 =?utf-8?B?SnFCb2Fwdit5citRV0R6MDhBWExPSm9nWkF1RG1GWVp5YjVJWURMVjNQbEd5?=
 =?utf-8?B?RjBhSDkzTnBWQURyd0dTaGZJRjIzTUdxUjlML1B5M04wdlFNVHk2M2R0YmJF?=
 =?utf-8?B?eTdVclZSSllqYmtUekF1YS9TRm52L0ZIdHJsWjd1QVFyRGkvRnFGN2JSQU9h?=
 =?utf-8?B?dlZDb21STjFHWFFkeGx6a2FxQlVOaDNyS1RYTElrNnlvRGM5MDJNRmJZUGhM?=
 =?utf-8?B?TXE2U0lNQU52T21FTWJvd0V2VmVzY0Y4N0JtdDRZeFVNWWFjT1oxRmkzT0tV?=
 =?utf-8?B?RTEvQzR4UGliTG9ZN1dXU2p3eWhTR1pNMVIrakMyZ2lGZ0RHeThkaWFlZmlX?=
 =?utf-8?B?ZmMwd1dWRG1jL1VVdFdoN0c2VWN6MHRzMG5aa1g1T1NQR2UwOUNPZEJTam5a?=
 =?utf-8?B?VlV3M0k5dFU2Y2R2NE5YMkR2L2xGblpGdWlyMUpIWXFUKzB1TTgxenZqTVdv?=
 =?utf-8?B?R0tIcHNkc21Ua1dxMGhud2M4NUNVMGxyamlDaDNseEp3eWhmcTFiWmNONGRT?=
 =?utf-8?B?QWRITnRNM0gwOGlmV3dSazNxNzYwTjkrM3ZRcm0wbTlpV2RlRTA5NHpXcExS?=
 =?utf-8?B?aE5PeGFnZy9NKzFsNVhRTy9aMWdQQWt1Q0Z1UWdqUjFTYnJ3SmpjaDlXRWRw?=
 =?utf-8?B?MDc4cXNMcjl0R1c1ZnBlTDcyVnJnMFNOZnBkdDNlTVV2V0dtbk16UWh3bWZD?=
 =?utf-8?B?YXZHM1VXVjRiS1F2U0JpaFRsTXZObG1yN1Y0N3hMK0w1S0tobDBlMGc1Nmxr?=
 =?utf-8?B?V0R4b0pIVzltVlRPcmZtcVluMWRUeG9BUTlYVWRYK3V2dDBYS1lka0JpQ0NH?=
 =?utf-8?B?c2d5dW9NNDIyMExrZGFVcG9uclBGNGt1SGpDcm5rMURiR2pQZCtqY2tIWHpY?=
 =?utf-8?B?ZDhSMmM2YUJaTUh1OHBCZjREbVRpWjZXRXlhQy9xVE5INXByZHFHRzJPNEUv?=
 =?utf-8?B?U0l0bmVsNG5PNTZ2STdRQkdZSUhVRXFWRVhOZCtHY3REU2QyTkV3NUNuL1dk?=
 =?utf-8?B?NE1JTVltdVA4bEFrU3hsUlVEd21GeGp5SE9DOGZIczAxbVBrcml2bVVwZ08z?=
 =?utf-8?B?NFN0Nk9KMXlnR2U3dTc0R1NnNlNKVU5rRUM5djY2cHVxUmcwVzBFL1QweHJr?=
 =?utf-8?B?d1lDUWpkZmRhU1ZNZ0tXcW5LTVNEbUlndkdUd2VXN3hRRFBqMmxtSXBmd3ZJ?=
 =?utf-8?B?ZVg5blRZd0ErSjBRR1h6TzJhVlV5bTE2QzBsWSsvaVF6OTA2SWR2L0l2ZHZ1?=
 =?utf-8?B?Tys4d2RQRVlLd0pGbGdFSnVKQXdsU1JidmtOSjJxOWJuMTBUOHRKOEVWNDFw?=
 =?utf-8?B?NlFYN3NWLzNac1prWTlpZGM5eHpzcUVlV1lyeFRsUGtseUVYSER3TUtCa3Zj?=
 =?utf-8?B?NGQ1LzR2SVFRMmhsL1UxMElyM01OY2Q2T3I3eUVYQWVOb2dHcXN6bG5TQ3Iw?=
 =?utf-8?B?UVB0VWc5bGR2aFNZcWZsRVN3ak9hbUZHUFhqQTZvcktIaXNQekthd0lsRnFK?=
 =?utf-8?B?QUhjL2R2aXNhdFFBanZJMzNyWU5vQlRwL0Z5L1A3U1ZxeUtWN2dDT1loOHFy?=
 =?utf-8?B?ckdNc1Jxa0VMcVBsVFBORFRuUGNOc2VmejNDSEdvL0czNHJOc2U0eUtlZGNs?=
 =?utf-8?B?MnJDY3g5SVcxSlI2S0pzRVlFYlEvMkRBdXdWbVh5K052Tnpwck0wMEJ0YWFi?=
 =?utf-8?Q?HQKnAl2Z/Bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU05bnFiaWtxejd5UFgwNkYra3Y1OFo1cGI0eEJGK2ZWQ3BNMU80L2kwdGhL?=
 =?utf-8?B?M2p2Qm5CR1M2RGVSQmRIOWlhUGJwVU93aTdOOHBudnRDS3V2TXNBUjBGNncw?=
 =?utf-8?B?WXpxT0tURXRaSjZ4S0JmRVJkTUtXYTdjUWNvWUJXUHgxd011Wm1ISXFwNkxh?=
 =?utf-8?B?a3RiQ2ozUVhrd2VDV1NRWUZHb29DZ0dwdDc4ZWpieTR6a3RVb2NpTFBJa2wy?=
 =?utf-8?B?MVluR1lqcmRyRE9OV20yR0Z6NlVMRkdpTDBDc1d2dm5URnZ3MExjVS9vb3Nr?=
 =?utf-8?B?QlkvZlF4UFdsclVQU1lSRUlGM3VCU2hXa3NpYzN4cVNsK2xLSW01RUZteEFq?=
 =?utf-8?B?OVpEZldsYjhGTVFlR2xxOXFGZERrZEhhSE04eWtjVlQ0WTJmMWhQVURGZlJN?=
 =?utf-8?B?MGE5ZWl5b1FQa3V3ck1PR1M4TkczWU1rMkhvb1Y5Ym9iNHcrdXRsQUw0VzYy?=
 =?utf-8?B?ZlBPWDE4a1V5UmRGUjIwc0VVV1BFZU1PNks4Syt4aHN1SlM2cWtVQmRCbWZK?=
 =?utf-8?B?cFRsRjM4bWRxWjI0aytBQm9iNVdDODdjTzZuenE4N1RJL2tnTDVpZUtiQjNU?=
 =?utf-8?B?MjJRUG5wZ2N5TFM1Uk9OdFozVmM2WEIwWkRaTHB6ekU0RHpFYk85eGNRZndz?=
 =?utf-8?B?MkVUL1V1TmZwM2pzVkJXWmhERTJBUmRqM0RndTRQY3VBR0tHdmZFc3pPd0NT?=
 =?utf-8?B?Nk5WYkpKR3N1dDVKelc1TEp6aXhUYUpCL3FiYmNZRXV1WnI0VHYzWTdHbUMz?=
 =?utf-8?B?dEFvUlB6WUFTUDRTcDAzN2k5alpHYzBsQmJYU2QrOGZoeFgrRTg3VmhheTFY?=
 =?utf-8?B?N0UwaTd5RVVhVDBTdWl0cGN3alVGY3QvVUI0eHhGYXR6Qlk2cW9NeloxWW9n?=
 =?utf-8?B?cElmQWpaeGpidTFXS2VPUS84czJld1FlRnN1QVdrQy84cWIzS1FRU1M4dmxM?=
 =?utf-8?B?T3didUJ3b0MyUVpqRnNjVHZVL1pNU1lkbjR1SHFOWDFNVERodDZ6MlRXYm5U?=
 =?utf-8?B?QjFyeEFuUXhzSThUdFlJMnJaOE9aRlNyVkNwNmVpWkVJRWl2RnlyZ0paZ0JE?=
 =?utf-8?B?NksvTjE1SjJYdHowaTRTd1diWS9sQWVxUXg0aFFKSE4wYU1xSmFvS05IaVZt?=
 =?utf-8?B?QWhrcVFXdlhHNUtiMTQ5T3QvbjN6RVJEc09YWGZPd1ZMbXM3T3hXR3lFa2V6?=
 =?utf-8?B?eHYzblJUYXBRZDRKQ0JhdW04MW4zVVJ1QmFrc3V0RlZDbk5JOThsV09pTmlv?=
 =?utf-8?B?ektDSE0zTis2OFdDTDhqTjdjSXRCTlRIb1F4V3psYkdtOWRkS2tkd3h3a3R6?=
 =?utf-8?B?MFhQM1hmL25CVkNvajVyUlhBdVdHMnZnR2Y0VUkwL29JanBYWm9IemF3MktU?=
 =?utf-8?B?M2s1Z1ZZSVFaQWUzMjhlUXI5NHlQRTVXb3JwVTFQdDZIYjJPbUtISGh0dWlR?=
 =?utf-8?B?WnlPNHlrSjVNc24vUU1UUHNITHlKWVdoOHE1L01LRExlb2FBMnBhUDNGNHJw?=
 =?utf-8?B?SVNNbXFzalI5NHNkcUFUa201UjFpdWo3a3NYV2IydUxBdGN1QWpPeksyMFkz?=
 =?utf-8?B?aTZuQkJrQ3hvZ25XQTM2UVc2NjlTM2NtY0hHRjVaUlFsRDNxRXdYTldMYlNX?=
 =?utf-8?B?QXFJSVhueC83akRid3dKMTdUZ0twbVFObzU1M0ROcWdjU2VxMk9jR0dSZzNW?=
 =?utf-8?B?VkdXV3Y1SVRVMFo4VXVFRjhEMWlIZUtIb1VKZmJ2M1J3a2JaL0dVNlR0eCtP?=
 =?utf-8?B?YVVmd0hBNDRpM0JwTDZHam14TXBNNnZGQkN5QWF6RVlwRlhiamp5QmRkK2RO?=
 =?utf-8?B?RUdKSWFnamFaY1JFdXZEeFpNNUlDT2NrUmxiZDF3NXBaSWcvVVEzVUZQZnJU?=
 =?utf-8?B?YUJIMmdac0w3YTEzRGdIUWhZS0ZKNkJtUHRQTFJzdDhqRndjeFY4R2hiS1ZC?=
 =?utf-8?B?WHJrYVQrZnpxZlBGUVNSNk9LOUxrNU5tRlRjeHVvTVNRV0RWM3VDbENjV0Zl?=
 =?utf-8?B?NXd2akpiTVFMNWUrenc0TUV6emdjZE1TL2xsL3RnWWMwOU8zQ3NQOWRwYTlS?=
 =?utf-8?B?NzhWNWNuNUZ0eTBDS29MQjdDNWJTQ0JGbDJ0SmdNRjNFRjVROStsc2Q5SUZV?=
 =?utf-8?Q?O9clNaM7jE4xqUPQmVIHMnvSc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30792cba-c135-4b71-630d-08dddabf017f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:13:25.8347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YYDGWcMPf5AkaavZBOQjqWeDS3Le9RDLUpECctmRP8NO3WMxEyhRZKf8RlG6hHtLzgrTcyTEJv+Ducix6LC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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


On 8/14/2025 3:38 AM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 5:16 PM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> Hi Alex, Hi David,
>>>>>>
>>>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>>>> neither the current form , reason :-
>>>>>>
>>>>>> The emitted fence count and total submission count are fast transients
>>>>>> which frequently become 0 in between video decodes (between jobs) even
>>>>>> with the atomics and locks there can be a switch of video power profile,
>>>>>> in the current form of patch that window is minimized, but still can
>>>>>> happen if stress tested. But power state of any instance becoming zero
>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>>>> completes, delayed idle work starts.
>>>> inst0 idle handler can read 0 total fences and 0 total submission count,
>>>> even if inst1 is actively decoding,
>>>> that's between the jobs,
>>>>     - as begin_use increaments vcn.total_submission_cnt and end_use
>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>     - if outstanding fences are cleared and no new emitted fence, between
>>>> jobs , can be 0.
>>>>     - both of the above conditions do not mean video decode is complete on
>>>> inst1, it is actively decoding.
>>> How can there be active decoding without an outstanding fence?  In
>>> that case, total_fences (fences from both instances) would be non-0.
>> I mean on inst1 the job scheduled is already complete, so 0 outstanding
>> fences, newer job is yet to be scheduled
>>
>> and commited to ring (inst1) , this doesn't mean decode has stopped on
>> inst1 right (I am saying if timing of inst0 idle work coincides with this),
>>
>> Or am I wrong in assuming this ? Can't this ever happen ? Please correct
>> my understanding here.
> The flow looks like:
>
> begin_use(inst)
> emit_fence(inst)
> end_use(inst)
>
> ...later
> fence signals
> ...later
> work handler
>
> In begin_use we increment the global and per instance submission.
> This protects the power gating and profile until end_use.  In end use
> we decrement the submissions because we don't need to protect anything
> any more as we have the fence that was submitted via the ring.  That
> fence won't signal until the job is complete.

Is a next begin_use always guaranteed to be run before current job fence 
signals ?

if not then both total submission and total fence are zero , example 
delayed job/packet submissions

from user space, or next job schedule happens after current job fence 
signals.

if this is never possible then (v3) is perfect.

Regards,

Sathish

> For power gating, we
> only care about the submission count and fences for that instance, for
> the profile, we care about submission count and fences all instances.
> Once the fences have signalled, the outstanding fences will be 0 and
> there won't be any active work.
>
> Alex
>
>> Regards,
>>
>> Sathish
>>
>>> Alex
>>>
>>>> Whereas if instances are powered off we are sure idle time is past and
>>>> it is powered off, no possible way of
>>>> active video decode, when all instances are off we can safely assume no
>>>> active decode and global lock protects
>>>> it against new begin_use on any instance. But the only distant concern
>>>> is global common locks w.r.t perf, but we
>>>> are already having a global workprofile mutex , so there shouldn't be
>>>> any drop in perf, with just one single
>>>> global lock for all instances.
>>>>
>>>> Just sending out a patch with this fix, will leave it to you to decide
>>>> the right method. If you think outstanding total fences
>>>> can never be 0 during decode, then your previous version (v3) itself is
>>>> good, there is no real benefit of splitting the handlers as such.
>>>>
>>>> Regards,
>>>> Sathish
>>>>> If it is possible, maybe it would be easier to just split the profile
>>>>> and powergating into separate handlers.  The profile one would be
>>>>> global and the powergating one would be per instance.  See the
>>>>> attached patches.
>>>>>
>>>>> Alex
>>>>>
>>>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>>>> my patch was using per instance mutex, I should have used a common
>>>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>>>
>>>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>>>> track power state could help us totally avoid this situation.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Sathish
>>>>>>
>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>> Hi Alex,
>>>>>>>>>
>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>>>> someone
>>>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>>>       - up to you to decide.
>>>>>>>>>
>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> David
>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>>>> we may end up switching the video profile while another
>>>>>>>>>> instance is active because we only take into account
>>>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>>>> outstanding fences for the video profile.
>>>>>>>>>>
>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>
>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>>>> handling")
>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>       2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>           struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>                   container_of(work, struct amdgpu_vcn_inst,
>>>>>>>>>> idle_work.work);
>>>>>>>>>>           struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>           int r = 0;
>>>>>>>>>>
>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>                   return;
>>>>>>>>>>
>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>> -             fence[i] +=
>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>>>> +
>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>> +     }
>>>>>>>>>>
>>>>>>>>>>           /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>>>> be handled by FW */
>>>>>>>>>>           if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>                   struct dpg_pause_state new_state;
>>>>>>>>>>
>>>>>>>>>>                   if (fence[i] ||
>>>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>                   else
>>>>>>>>>>                           new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>
>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>           }
>>>>>>>>>>
>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>> -
>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>                   mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>                   vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>                   mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>> !total_fences &&
>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>                           r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>> false);
>>>>>>>>>>                           if (r)
>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>           int r = 0;
>>>>>>>>>>
>>>>>>>>>>           atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>
>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>> -      */
>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>> -
>>>>>>>>>>           mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>> move to here:
>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>> I think this should work for multiple instances.
>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>> David
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> David
>>>>>>>>>>           if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>                   r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>           }
>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>
>>>>>>>>>> -pg_lock:
>>>>>>>>>>           mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>           vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>>>
>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>>>> *ring)
>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>>>
>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>
>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>                                 VCN_IDLE_TIMEOUT);
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>
>>>>>>>>>>           uint16_t inst_mask;
>>>>>>>>>>           uint8_t num_inst_per_aid;
>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>
>>>>>>>>>>           /* IP reg dump */
>>>>>>>>>>           uint32_t                *ip_dump;
