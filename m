Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC85E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D50310EAF7;
	Tue,  7 Jan 2025 15:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4q7KlILb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECE610EAF7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl6SYVUh50mhYa1mAyM3em0iR23oer/1zvo2yByIYNr04ZtPQzUmGtJqYV1JGLxmKHaLjMdzCxKIoJtvFGwbm9mPK4LT2t/Y4Wp4qdtjtic6SeDRnQN+vzIOFGXhWA15J4tgaGA4V+qtHoqc77+ImD70rkoAiYTgKRIpyeSZio9qEF0txSKC+7ETWxqElI+3vBL4s5Izp85hhkCStnPp96ve7j02Dl+WLQiH7DvilkviHFhTjB2WZrNnpG8/cAMV8vDIunLzFlV3Jv08t5Ap7Tny5/5hMHRghK2K7nYCb2cfF7RPUHDTiTvZZfICw9UJ+T6EIu6rUCSxTJEhf0SD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdCLe5uSpOJ+yHbDAT6ff3JPipX6mb+P3H6FQJfpxrI=;
 b=D3r0LBo+FKlqACqxRBilqqTxTAbCl6HyoJRTGnB5x9zCFwe4GuxTs00abV+B6FJjYXLxuE7uiNlGzjgDeHxxoqaPHJQYicFnqShYH9Llc9MYw2zAijGj9P26TaYQqKVzuMt+EtBoiPeHnTz/3rJKFL0hACu3VBQ/nGfOtB5SBU/kbY0kLMG53vNOr7hK7FNeHMZ44t0xrMuppH4Hl9JPathcSfIlUlCaK8UuoA4g7g6KfhDNFxUGtKMh8BZrEOAvS2P6nIURdKp+sMK7fhLfJOFFMlz/yADFZHLu0vT3n3/nbmvN5bLTAJ6ShwNoUzKlI8m2QO1FgJPGnI0H2eHmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdCLe5uSpOJ+yHbDAT6ff3JPipX6mb+P3H6FQJfpxrI=;
 b=4q7KlILboekfiJTW8Gowp/f5w81wDks3LgZkpyNXEo/j8E4SxDthDlurLOjXEGDxhru0ZGxvMteV/fsgxX1Kdstc/QrEsOuD1jtrDsNThSaRKWTgDvyyWLXNYVEqf/Zzx5l3QnkpKrudtzVvLwE/rtfX6eoi9uz4r8qN+hH3KxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:19:18 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 15:19:18 +0000
Message-ID: <22e5cee7-52f4-ef08-b44b-e4fb96027ea9@amd.com>
Date: Tue, 7 Jan 2025 10:19:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
 svm_range_restore_pages issue
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250103022615.1399054-1-Emily.Deng@amd.com>
 <62496e35-e23c-4d10-a5b1-99978665cebc@amd.com>
 <PH0PR12MB54177A7932BF4D91A8A41FE38F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417D0B508B3DECD240478E48F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0e2863-fd36-42f0-ec2b-08dd2f2ea76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDBuelU3WGo0ZHgyekdIRFM4bXRqU0lwN1RuRXBQTno0czhhYU83bGJNUHhN?=
 =?utf-8?B?N3Y3Y1lzTnJsUkVUNDJ6Qk9pVURzelBiaGtDMUxybnVBemNHUlk5NkdSaXhC?=
 =?utf-8?B?bkVPQjZpenJ3dkIxTkNNMWlwdlNhR3BFQytUNXFvdHdaQjQxdG5Za09DeEFw?=
 =?utf-8?B?NHR3LzQ5Rkt1N2p6dEJDVmR1N0F5TE9ocmJmdEtCU3ROMTdvMDFnaG9QOHEx?=
 =?utf-8?B?N1RpU0lEajJYd2Z6ajNvdzI0aU5BMzR1SmVDV291VGxZSnZsOFlXRUg3bzJD?=
 =?utf-8?B?SW9Rb3FmWUM0S09iRmxneG9yNWJlYkIxVk5oclE4TlEyUnZyblRjR1lXWEhH?=
 =?utf-8?B?dG15OHQ2SSs0aGNBTU5XbGgzc01MYmNQNVVqYXovbStiM2o1eEFIMEpqNVpJ?=
 =?utf-8?B?MU1wZXJoY1J0c2tyaVF6V3VyNHBrNHB2ZjZ3c0xrOTllSHl2RGdzRzdMOHZo?=
 =?utf-8?B?UDJlTndjZEpEU2FZOWNITlhzQnJxbjNaNGRIVzd4amNJSGpBLzlmb2pEUURV?=
 =?utf-8?B?RzI0UGxWN0M1S0VGNjZiZ0dpdTB0dHBqdnFsdlJic3hDZUVGcUJwNkpETTB6?=
 =?utf-8?B?SzNKeWNTRXhkdW56RHBGRzV6NmdnRytlOHJBOEtsajFuS0dkc0Z4VWtXcWtL?=
 =?utf-8?B?ZU1aOTh2UkhoVlM3REFNMkxYOVRHK3d5UGQrR1hQeUp5M094SVNKbFpWYm00?=
 =?utf-8?B?S2IvTkN5MHJWVXhTTWJUNE93TllNb1pOMzgwbVUycGo3dDFTWUJRd1dyTUxK?=
 =?utf-8?B?WS83a3NBVHNHOGZDQjJTTmFQMUdUWTRKZEp6SFRpMGZvK1g5U2VFWXNtNSs1?=
 =?utf-8?B?YStRSm12ZXI3a1lpaEh6RHJENnJPT0JidWMveVN2eVVuV1pqaDRDNThXaGhS?=
 =?utf-8?B?aWZjTTQ3Rlh4a1hjSXUyUzhnbFFkTjVwbGVCWXVWc2JvYUFVQkRRTmE5RFl5?=
 =?utf-8?B?RWxXY05MUjZkOGNIVzRFSkNGUkh0ZGF5L3NxNk1ubkVuY0V2N2VQNDlNYkFr?=
 =?utf-8?B?S0phbkM1QmF1dmQ2dENuK2JxMUJQY1YyeXpGMWcrVkNrenhqWTFiTXE4M2Q1?=
 =?utf-8?B?ZWFMNDFJUjZ2ZWxITU91MlVHNnpTTHlyZHJ4d0JMc2xaWGMwalN1VzBBVVhM?=
 =?utf-8?B?R3BKQUFQaTB5Um5kZnAwdXhrdkc2Nzh5OGFxa2J3TnNzVG9pcFIyVnFUL1hU?=
 =?utf-8?B?TVF0S2RrY0pMOE51RzdpaVRac1c3dWQ5NDlBNjBSMnpSRXZVeDROLzg0WlRp?=
 =?utf-8?B?TzJVZjE2anF1L3BrUDhSc2IvQUlkdlNMTzBPUjNTanNvRTdGdXpkZXdhT0th?=
 =?utf-8?B?VkNscU1PRjFHelJQK1NGOEFyTTl6OTVadGhUSmtuWnltNHJVMXBxOGZKVmRQ?=
 =?utf-8?B?ZGpSVEYrZDFFenorYU11MG8rYWlLVXdIRUkzaVlsQVVsekZXcUV4K3F1VHg4?=
 =?utf-8?B?cE82aVBRT2puT2g4QTlKS1UyNzlPekd4Nm9rbGhiYit3QUxKT01lTUNQLzBj?=
 =?utf-8?B?WmlIY1ZIdkc0dVcvdDlKZkxBWnRwUzlYTkJnWG81UjNKck1IQVVJUFBmUkk0?=
 =?utf-8?B?a2JTL1M4QlZ0b1drN1F6UFVIR2NDZW5OWXRYbmR1NVNVT2hVZURCenRuZVow?=
 =?utf-8?B?Sy9nbkZDZEU5dDVnMTljcVNiM2lNQUg3TVNKVDNwSnIvM0VNRmJOVGZqRU9v?=
 =?utf-8?B?VkxrRllzQkswRWsrck56Z2hNMThOcjYxYkVvRXI0L0U3eFRCRVp2R3NlSVFI?=
 =?utf-8?B?Z1E5alBHTUhtNyt0blhBTFlvclJKTWUxNGd0NE5qVFVBMjA4KzNoMzl6S3Q3?=
 =?utf-8?B?djREdk9UaVRMUUI2QnkzeDNLc3hzaW1yNGwvSHYwaWRjaDBid2pXWVJDT2pP?=
 =?utf-8?Q?3+PNqA08nLSai?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpxYzlSZGRDcXdOQjFIL2lEY21jTzBnTUJJNHpiK0tVQVFaNGJ3ZVg1enQ3?=
 =?utf-8?B?ZEZhZEYxL1Y1OG5QdXRMVEliczRSUkViNFBjS2Jqd2pJOUI4bmtCZ2l0OWRL?=
 =?utf-8?B?b25TWjJreXdJa2NFcXVqSHdwQjIxcDhNTjAyVW9XQ3hDOERXMEs1UG9NdjdZ?=
 =?utf-8?B?SmJNRmFVSjBBQUdWcVZYLzJLWnpVQWhuemVpTzFkV2sxOTRCWG50cDZXZEZr?=
 =?utf-8?B?YVJ5R21OWXZEdlU0MTVTRE9aY2Y5QWpSZEpQcHlRM0xFMFJ4OFBNTnNGWGZ5?=
 =?utf-8?B?Y2JmdG4vY0RiQksza2xoMUdnMzkyVm5BbGw4OFhzNzQrVEJyRFN6SXdiUUtm?=
 =?utf-8?B?QnE0K0x4eVB3VHIvV3oxV3dJQ3lEUVpLRjhoLzc5RUxoZVBudlREQ29Udzd2?=
 =?utf-8?B?Q3UwaXNvSzN2NzZXZ1BCY0VNdHV2Ujd0cElodU8yeWVVK1A4V3kzNTlPTU9k?=
 =?utf-8?B?RjZKdWFITmF0ZDY3cCt1dEE3bytOWEJ3ekZDc1RFZ1g4VkJIZXRYZ3BKbjRw?=
 =?utf-8?B?c3lzcE44akhyUjdmTzJnRzk3U3Zob3U0c1lDZW9VR0JJdHlNOEFLMTRtVXlV?=
 =?utf-8?B?TkRsNG9uZ2hpRlAyeWZtY0ExZks5ZUxkWmlrK2RZSUZIZFNZQ2VtbUtuTm5M?=
 =?utf-8?B?L2RSdUZYdGNOQ2krM2FwQ0x2MVRlRnBOZG9XZGk3VDhEVTRqcDd5ci9GMUta?=
 =?utf-8?B?bjBMOXEvRmJ6SkRKNHVJS2RmNzRHZmY1OTJ3YXFQTFk1QkZKOWtMRlhudW9M?=
 =?utf-8?B?ODJlSktEK3VPNEpSUGJjZHhoWW9KZXEvQmpYTFMxU3diZHBHNFFxVUhhYWlQ?=
 =?utf-8?B?Kzh0VXhPVVIzNWJYYkptc21PeWtHNXd1dCtkNE9SV09scnBSMDV4QkhiMVVt?=
 =?utf-8?B?L2wxRTNhUmhMVUYzdlZ2SmxGRkxYSUY4bDQ5OThIQ1ZOaFlHOEx3eitGWFNS?=
 =?utf-8?B?YUxIZW9OVjJMb2FCeDlLYm4vMFNvY2JkWWZyNVFzTFRFRm8xNDQ1WjVMMVVI?=
 =?utf-8?B?MTBiaE5ReFlJREQ1bEZtTkRlb3ZjekwzSEhaMmRLR3U1aU5nM0kzNEdaZE1B?=
 =?utf-8?B?TUM2Wm1yWWp0ODh3TmEwekN2M21MUzZ0djlmVkwvQUgzVFl6dTc0YjAreGU2?=
 =?utf-8?B?cEwxc1ZmcWFMRk91WjVTMi80bFRlT1JjMFV3cWZlTUN0ZURPV3lFOGhsbzlk?=
 =?utf-8?B?WE02N2taOEVsTUYwMFM1aDZ4eFVRQVlObEs3enB0UUR1L1pMRzllZzV0NUtG?=
 =?utf-8?B?UHg4SXBpbkF2a1lxbnE5RWgwa09qQzkvYWxmR083cjhuZXJma3k2UnpSNjJJ?=
 =?utf-8?B?TmdHcFE3RXZpdDhCUk1FWEVLOUZaUityZEFBRTB6RlE4eGtucGtwa0d1bHFm?=
 =?utf-8?B?RVFhTmFjL1N2WTN6SU1pcEp4WVAzRHZJR3U1K0x2TXVtaXk1RWNGb3JFbXNO?=
 =?utf-8?B?TGxGa3Q2Tm9JUG82VGt0bFlPV3U1UmNZOGcwMnduYVFpTng2Yi9weG1reGxJ?=
 =?utf-8?B?Zk5UVWQxa3UxTUgwdkJPMXJJMDViWXc0c0I2ZVhQM3lIRlZFcWgyVWVNTzlw?=
 =?utf-8?B?NmduZ0dsWFdWM0FZcWVIZldEazZrVHRTc29wTk9leXpiV0syVk1ud2ZSdklJ?=
 =?utf-8?B?M0IvOFVZYjhwN2pjSmlxeVJzRmlpdnpGT3EzNVpnNTl4YVpWWjYyL3FUV2Jv?=
 =?utf-8?B?cldrdUNCZlN3ZkVVcHJNemd0c0FEKzAwQjFBbFA0OEU5R2xXZWUxemNLdlZ1?=
 =?utf-8?B?K2pRNGFQZTFHWDBlYkZQMW4xSmduMUxmb2NGYWxYamI3QklUd1RTNGZDWkVJ?=
 =?utf-8?B?dXJleHFkV1NkK0JEUXA3Yy81ZUhMaWhjTk1HcUxGaDRRRnQrS1NLNzhUK3VQ?=
 =?utf-8?B?RUtKS25VMnhTV1ZYNDJ0SkNmek5ISHVXamt1T054SnJGeTZYbjJEV2NBSjgr?=
 =?utf-8?B?VzVmSDhUWmx4RWZDdzB1aVpUb0lXUE1zeEVXZERtWDZEdzF3Yml0Qkd2LzRO?=
 =?utf-8?B?VHlPcjA1OTAwb3hQTDFESVpXaFp0L1YxTDJib1VyaDhqM1V2WTkrNUVva2ow?=
 =?utf-8?B?YW85U3J6T3NxR1V0S0Q1ZmJPYkN3MkJ0eVNBSWN2dmxKNGpDNERZVmVZeUgz?=
 =?utf-8?Q?KxJEx6lF/Rx9wX5R2Dh+lwHKY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0e2863-fd36-42f0-ec2b-08dd2f2ea76a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:19:18.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UeXMexhkkJc3qJDtF1QK83dadebDaolHV7dqBru2Y3Qd27DzwLhs7+gQgwAbnhn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-07 07:30, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - AMD Internal Distribution Only]

Hi Felix,
    You are right, it is easily to hit deadlock, don't know why LOCKDEP doesn't catch this. Need to find another solution.

Hi Philip,
     Do you have a solution for this delay free pt?
</pre>
    </blockquote>
    <p>Thanks for debugging this case, I had a patch to not free PTB bo
      when unmapping from GPU, but it will waste VRAM memory. My test
      case also passed with the tlb flush fence fix, I don't see the
      no-retry fault generated any more.<br>
    </p>
    <p>The deadlock is probably from svm_range_unmap_from_gpu -&gt;
      flush_workqueue(adev-&gt;wq), this is from mmu notifier callback,
      actually we only need flush pt_free_work before mapping to gpu,
      please remove the flush_workqueue in unmap from gpu. If deadlock
      still happens, please post the backtrace.</p>
    <p>I think you don't need add new adev-&gt;wq, use default system_wq
      and flush_work.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
Emily Deng
Best Wishes

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
Sent: Tuesday, January 7, 2025 10:34 AM
To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Yang, Philip
<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call svm_range_restore_pages
issue

[AMD Official Use Only - AMD Internal Distribution Only]

Ping....
How about this? Currently it is easily to reproduce the issue on our environment. We
need this change to fix it.

Emily Deng
Best Wishes



</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of
Deng, Emily
Sent: Monday, January 6, 2025 9:52 AM
To: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>;
Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call
svm_range_restore_pages issue

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Sent: Saturday, January 4, 2025 7:18 AM
To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>;
Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
svm_range_restore_pages issue


On 2025-01-02 21:26, Emily Deng wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">As the delayed free pt, the wanted freed bo has been reused which
will cause unexpected page fault, and then call svm_range_restore_pages.

Detail as below:
1.It wants to free the pt in follow code, but it is not freed
immediately and used “schedule_work(&amp;vm-&gt;pt_free_work);”.

[   92.276838] Call Trace:
[   92.276841]  dump_stack+0x63/0xa0
[   92.276887]  amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]
[   92.276932]  amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]
[   92.276990]  svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]
[   92.277046]  svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]
[   92.277050]  ? __alloc_pages_nodemask+0x19f/0x3e0
[   92.277051]  mn_itree_invalidate+0x72/0xc0
[   92.277052]  __mmu_notifier_invalidate_range_start+0x48/0x60
[   92.277054]  migrate_vma_collect+0xf6/0x100
[   92.277055]  migrate_vma_setup+0xcf/0x120
[   92.277109]  svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]

2.Call svm_range_map_to_gpu-&gt;amdgpu_vm_update_range to update the
page table, at this time it will use the same entry bo which is the
want free bo in step1.

3.Then it executes the pt_free_work to free the bo. At this time,
the GPU access memory will cause page fault as pt bo has been freed.
And then it will call svm_range_restore_pages again.

How to fix?
Add a workqueue, and flush the workqueue each time before updating page
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">table.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
I think this is kind of a known issue in the GPUVM code. Philip was
looking at it before.

Just flushing a workqueue may seem like a simple and elegant solution,
but I'm afraid it introduces lock dependency issues. By flushing the
workqueue, you're effectively creating a lock dependency of the MMU
notifier on any locks held inside the worker function. You now get a
circular lock dependency with any of those locks and memory reclaim. I
think LOCKDEP would be able to catch that if you compile your kernel
with that
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">feature enabled.
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
The proper solution is to prevent delayed freeing of page tables if
they happened to get reused, or prevent reuse of page tables if they
are flagged for
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">delayed freeing.
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
Regards,
  Felix

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Thanks, already enabled LOCKDEP while compiling the kernel. The delay
work seems for other reasons, I am not sure whether it could be deleted completely.

Emily Deng
Best Wishes
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">
Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 1 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 7 +++++--
  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        | 6 +++++-
  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 +++
  5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93c352b08969..cbf68ad1c8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1188,6 +1188,7 @@ struct amdgpu_device {
     struct mutex                    enforce_isolation_mutex;

     struct amdgpu_init_level *init_lvl;
+    struct workqueue_struct *wq;
  };

  static inline uint32_t amdgpu_ip_version(const struct
amdgpu_device *adev, diff --git
a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..5b4835bc81b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2069,6 +2069,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
             if (ret)
                     goto out;
     }
+    flush_workqueue(adev-&gt;wq);

     ret = reserve_bo_and_vm(mem, avm, &amp;ctx);
     if (unlikely(ret))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9d6ffe38b48a..500d97cd9114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2607,7 +2607,7 @@ void amdgpu_vm_fini(struct amdgpu_device
*adev,
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">struct amdgpu_vm *vm)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);

     flush_work(&amp;vm-&gt;pt_free_work);
-
+    cancel_work_sync(&amp;vm-&gt;pt_free_work);
     root = amdgpu_bo_ref(vm-&gt;root.bo);
     amdgpu_bo_reserve(root, true);
     amdgpu_vm_put_task_info(vm-&gt;task_info);
@@ -2708,6 +2708,8 @@ void amdgpu_vm_manager_init(struct
amdgpu_device
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">*adev)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">  #endif

     xa_init_flags(&amp;adev-&gt;vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+    adev-&gt;wq = alloc_workqueue(&quot;amdgpu_recycle&quot;,
+                               WQ_MEM_RECLAIM | WQ_HIGHPRI |
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">WQ_UNBOUND, 16);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">  }

  /**
@@ -2721,7 +2723,8 @@ void amdgpu_vm_manager_fini(struct
amdgpu_device
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">*adev)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">  {
     WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids));
     xa_destroy(&amp;adev-&gt;vm_manager.pasids);
-
+    flush_workqueue(adev-&gt;wq);
+    destroy_workqueue(adev-&gt;wq);
     amdgpu_vmid_mgr_fini(adev);
  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..1204406215ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -554,15 +554,19 @@ void amdgpu_vm_pt_free_work(struct work_struct
*work)

     vm = container_of(work, struct amdgpu_vm, pt_free_work);

+    printk(&quot;Emily:%s\n&quot;, __func__);
     spin_lock(&amp;vm-&gt;status_lock);
     list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
     spin_unlock(&amp;vm-&gt;status_lock);
+    printk(&quot;Emily:%s 1\n&quot;, __func__);

     /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo is valid. */
     amdgpu_bo_reserve(vm-&gt;root.bo, true);
+    printk(&quot;Emily:%s 2\n&quot;, __func__);

     list_for_each_entry_safe(entry, next, &amp;pt_freed, vm_status)
             amdgpu_vm_pt_free(entry);
+    printk(&quot;Emily:%s 3\n&quot;, __func__);

     amdgpu_bo_unreserve(vm-&gt;root.bo);
  }
@@ -589,7 +593,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">*adev,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">             spin_lock(&amp;vm-&gt;status_lock);
             list_splice_init(&amp;params-&gt;tlb_flush_waitlist, &amp;vm-&gt;pt_freed);
             spin_unlock(&amp;vm-&gt;status_lock);
-            schedule_work(&amp;vm-&gt;pt_free_work);
+            queue_work(adev-&gt;wq, &amp;vm-&gt;pt_free_work);
             return;
     }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e2911895c74..55edf96d5a95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1314,6 +1314,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">*adev, struct amdgpu_vm *vm,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     uint64_t init_pte_value = 0;

     pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);
+    flush_workqueue(adev-&gt;wq);

     return amdgpu_vm_update_range(adev, vm, false, true, true,
false, NULL,
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">start,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">                                   last, init_pte_value, 0, 0, NULL,
NULL, @@ -1422,6
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">+1423,8
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">@@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct
svm_range
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">*prange,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">              * different memory partition based on fpfn/lpfn, we should use
              * same vm_manager.vram_base_offset regardless memory partition.
              */
+            flush_workqueue(adev-&gt;wq);
+
             r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
                                        NULL, last_start, prange-&gt;start + i,
                                        pte_flags,
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>
