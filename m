Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2E9C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 16:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47A310E049;
	Mon, 20 Jan 2025 16:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLJxapeD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465CB10E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXczmHFdKoW6LCZSWyQurVFMXIpwjX5xd1k2P8E/Eo5Yt5YK6wOXzxm5setbSeBR8I+95gKWr1GP09EQmODu9e/PlMJvTa4ODv5Tc8pZ3kWJUx3iS9n7deezv66mR5VxCPTM+h+xWTIsBPncC1dwOfMvnleC9n37NDieFJz9pQ3XI/jLRsAFVI5IpMbiGkvW+ApdhLjacIvP5BwCZZ4fILvM92sYu9hQCchJe4eRfuorqqJcVpqxNlHreD1YBSzSa/spWP1BMBM3D6rvscg3htukQULlJu5Bu9zOsvb00e9ldGHzZ5VJ556zjn4ciGomOV3oIAtWtao7dLsjVVkeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSF6gxD8OugwapVsg6DRd5uMkTqM3ambtAuck4HQsK0=;
 b=g5xTfZxtGbkF9BPCrrp3geE9OCEKQSIk3LjO+Mb9JRcUUhmiaqQ/s4qOXNwU5REWdhPQ3cHunPZTuIsvbxvCm1RQtzrUNVNBPlivV2TQGTtl6GcaPGSqWlIGHD9VPlFUrkUa4GTDROKbZ6riK1LvGXySd7kWedu++7PZDMDdm+DBirq9uzJ9szXr27y4zG/h8RMVcYrToFIBjBPhbZY7/LL0OD345bmG/GUOn//3VGcUag4+Z3DOhEzTWFJSUHTM2HSpz/ddJENhqgxUSNHLRn14Mq10e4WUIbENI5auEfVcZdEzoaSMVw6cA465mOMHTaHtiKl1Ib9QaEnVET0L8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSF6gxD8OugwapVsg6DRd5uMkTqM3ambtAuck4HQsK0=;
 b=LLJxapeDUJs8YZ4OO58mRAp/us/VdCDk+z/lheTPZuhoqyLLK035nVrZdiJnKw5Zd2hqj/dWvnzQyB9D11SMiyptTHfHgYQOf7PL/HcKds1K1PFoax0T6SDzGp0KK4rX7O4mzd69HDPcetpYGR+i949ZzLFZ7MqOMAWpg/e9D8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 15:59:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 15:59:58 +0000
Message-ID: <35670d39-0f91-29ab-e369-6e45b000d486@amd.com>
Date: Mon, 20 Jan 2025 10:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Unlocked unmap only clear page table leaves
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250114145314.4633-1-Philip.Yang@amd.com>
 <f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcd2d2d-420c-456d-974c-08dd396b7d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXJqME14L2NSbTFNdFRNell6dFV0aG5ENkRtQ0I2eXJtV2lRZG9mNWdFYlFJ?=
 =?utf-8?B?aTJJTzQyelgxellzdVpOVTk4dG5kaGVSaGcyaVNJT3ZFSWhWU1ZtQjN0Z3Nz?=
 =?utf-8?B?WnNOTllCL2ZjOFBmNzZiekNHeVF1cEc1TVJJQlJJQVN0eDZnUi82SzlUNU9h?=
 =?utf-8?B?eWhtUFdkYmsrdkhGTk96Rm5RdDVKZzMvczcrUENzNXRpdlhkOElXcjNVV2xY?=
 =?utf-8?B?cVBtQzNsTkdSNldwd0w3R2lnVkZDZXdOTExmWmtiNE93M2VuNkV5REx4OUU1?=
 =?utf-8?B?TTdMdzhmZCt1aDJwaUJ2V0pVWlNFT1dLaDFDaXJOZ2FOVGlUUFpKcTJQVVZL?=
 =?utf-8?B?RHFweXRwcmVRZmI4aE9icXJkZHEyWXZYVTNvd1hUaXZTY0szUnNyOXJNelhW?=
 =?utf-8?B?eXpCdGdFMW1uRVlNdWM5eFB4Z2svQUhKMVh3WjZUKzl6SlhNNHk3T2tuNytx?=
 =?utf-8?B?K0t6T1lXYUtuTkoxMW5tTkxxSWpOUGp2WjlLWEZjTS9kQnptRE00dE1MYUtl?=
 =?utf-8?B?dGg3VWY0MnpZQnVueE03S05QOS9vcndScVU1WGpCTStaQTBDTFlITkFOTlFX?=
 =?utf-8?B?eFdOdjF3ejlyYlF2eElnTmt4NXIyMG5pYS9OK1IxcmV4ZWViSFFNNDhheHBx?=
 =?utf-8?B?UnJmSHptVW9BU0ZmOUZEN25KYW90N09KcjFRc1lNL2MreGdEQm4zWHJETkI2?=
 =?utf-8?B?QkV4WGYyMTlsVlVzeG5QME5sL2NyWGdyM2toenhBRkpNME4wS0UzaVRtcG5T?=
 =?utf-8?B?bEpkODZYK1dhSkFNMHZDRC9aQmFCUURJYWRrZnl2S2JxOC9tMVUydk5UbU80?=
 =?utf-8?B?MjRxWU1tUWExUHdnS3R0eEd4eTRxSFBCY2pob3kxa3ZuMkJaOGtGdWRnbzN0?=
 =?utf-8?B?bWVJblJVa3FETDQrdFlRcnBRVzB1aDJPTDFkRE5jdHdIeEFaOVN1YVJsamVX?=
 =?utf-8?B?Nm1ibHYyN3QwSDQ3K1RIWG5sQUE3NjhhSGVpbzNRUmhuTE05bGV6eXkrL3VL?=
 =?utf-8?B?ZG9zcDR3RFNDdDlkRkswNHp1MWtaekFpUzRQcWhMQkNqMEp3cDcrRFlaMzE2?=
 =?utf-8?B?VzBhVmhPZHJzRTN5eURhZmdHTm9ERnNSMmRuNk81VmZDWkcvbGtnQ2lpMXJO?=
 =?utf-8?B?ckcyZ2ZsK0dPTjJoWVJSOXpCbnI1UVRHMnoxNlZmTVJMaHo0d0NqVGdWSUEz?=
 =?utf-8?B?TXZJcVBiT3hyb0lBYktiY3ZFV1FLRXJ2R08zWU9RNkNGUExmdEtZd3U5ZG1u?=
 =?utf-8?B?ODIyVTQwVk9Fc0lqSUxNd0orOVNjb3FKaXA4MDRId1NrRkFjVU96bmQ3djlW?=
 =?utf-8?B?NnhEU0dmTmxCcnN1NUgyZEhSd3NGWDZ0T2xaK0RvY2lVa3M2WTV1QnJ6TmRT?=
 =?utf-8?B?VmVxYW1lb0twMXJiM0VOMW8wV0FwdDNiRU9FWW1jMzl4WjZ0RUFRNWY3RytQ?=
 =?utf-8?B?ZGlZUzgyNTNsUUpVTHBRbXhCbWlMeEJjeUNEQkg0dUZ1dGZpNjNENkdYT0JF?=
 =?utf-8?B?cmJzckY1Y3BIaU51akZhS1VvMkpoc01mQjdGUmd1TlRLK1hRRXFFMllydW9v?=
 =?utf-8?B?NCtjUGRwdVhzbTk5VTUzYWQxTmNVKytrQ3VpcExyS1RXUGZHRk1aRGZnVm54?=
 =?utf-8?B?TlVtVUtMWnhUUmJXVGc1dTNkTHp4MVBxYU9SMkQ4RXRCdk5YSEhnR3RaUjk2?=
 =?utf-8?B?bHBJeUpYMmZQMFVGRk5oUFJ3UVNic0p1U1BWU29jdFdxaENVQkQ0MXVtV21D?=
 =?utf-8?B?dGNBbkxqREFoT1pJTzRUY0tsMXI0RnUya0E5OHloWGUzQWtHQjY1azZWdUhC?=
 =?utf-8?B?ckxkNEEwaUhWSVpFUmtpTXYvZ3RsczJzeUxGUnJPWHJEZkNpbW1WVUN5dWNx?=
 =?utf-8?Q?R70guz8KzIKlS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxFem1DazhEUVUzV3hzQ1E1SktOaHArd0dJbGk5Rk9Na3V0N3FIK0FoT1pM?=
 =?utf-8?B?TjZSdldqbHB3VnRwQVhiMytZUGI1STZUVUlReVBsNDZFMERBOE1IQmlqTGdr?=
 =?utf-8?B?dFh5REJTc25LN1Y1MzBVSjEwcGJsSGFrNFpoWmZTRFBrMUhNUFU5RzRSb0tX?=
 =?utf-8?B?dUNBNVRyQjFDRW4zN2hua0dzUGZEMXRLdHRDVEl2a0xtSHZ3OGJFaVA0R3Q1?=
 =?utf-8?B?YVpIeGxuUWlUbDJCYjgrcWhJeS96ZFp1OU1xRkJydnVMcFkxZGFGZzNZRFMr?=
 =?utf-8?B?bFVGQUZHcjV3MmFNcXQyYnBlajdHaGZyeHMybTFacndsaTBySFVlc0JIRThr?=
 =?utf-8?B?dHVRQ3hVenRETWFxTlhQaWYxQzAxRjBIWmE2WEJ4NzB2NlRWTUpsWnZDVnFv?=
 =?utf-8?B?c3FrS1RwRG5SVTA3U1VlYUxuelQ4K25SeWUvWnJLaTRYRWdlNmRaWXY2WlZk?=
 =?utf-8?B?YlNaQlg3YjFpeEQvT29sZG44ZmZaUzg5VURFUVhwQndKbU5NUVo3SGVsbGlW?=
 =?utf-8?B?Vm9uODFOd2UxOHlSc2FoQStNUjdXblVOVUEyS09SdHJnUENlUCs1bmZjT0Vn?=
 =?utf-8?B?NjBFVkZZUG42cXcrMmJESFRiVTdEMHFOWlJzUVBrTEs4V1JZVU0xQzlBdFll?=
 =?utf-8?B?My9EdVRoY2VTd1Q4NW9zVWVGVzlYT2FZVGQ0bWFzTnNDeVlCZjFJbWFGUzNs?=
 =?utf-8?B?djFoWENRaHZrSGhkUnhIUkdPRm5pWVFiTzJkeGxXWmQ2dEt6ZCtvdWpaQTVy?=
 =?utf-8?B?MjRvSnp0SE11VFk1cTJscmNqR0V3UmsrdnNwald0SHRWbTEwSTN1MXliTnlW?=
 =?utf-8?B?UlUxK3F4NVhHZ28vMFkwb01aNnMvNnlXZnhyaTd6NHNPV3Q1Q3psTmswUnpW?=
 =?utf-8?B?ZE5RR05wdDZDQjEvMzdYcjgrZHVnSW9YaldXS09tWW92WThGN29kL1B5dG8x?=
 =?utf-8?B?RXpyVVB5Zm1JMlc0R2F4WHUvdmF6TzNDclBxOWNLUGpyVmRiYllJNmk0MzQ3?=
 =?utf-8?B?UCtmaU9ocjFqRzlsbjJvQ2YwakdCMUxnQjJBaVFiMlVVbFpVQzNiT3F4aUV3?=
 =?utf-8?B?REpRZitQa0g0WlEwcklUeW1kMTAzenFZSWNYSVd0MllieXVUb2VIM2VVZ1Uz?=
 =?utf-8?B?OHhvRldiTzBIS0F1cnFpTzY2L2tGbUFKL2dQZlMwbWJDdFkrWjBkcDkwbDBV?=
 =?utf-8?B?dkkyQ05mdGFPb3JIRFFtL3NGNlZuTVJUaVcxd0FxTXEvbEhCWXhnalAvcjRr?=
 =?utf-8?B?cTlvWkwvVjlEUEpmWllETmRPYXVvTXl6L3M2VmdydG15ejVmS1hONkU0ZkFG?=
 =?utf-8?B?UTBLVThYQ2NrMUpLOE5ERkc2dFoxcjUyZHdybVVxYnF3TkdZRjlWM3lMUkdI?=
 =?utf-8?B?cDFPUFNMSnJ1RWlGNis0RnFpLzY5MXFZcnZoOFYvZW5VVmJZV2pIYXZYK3dX?=
 =?utf-8?B?aTgrMXl6OFc3RkhmcGtrREd0ekU0MHZFeGp4ejg0ZE1PRU8vSUh0TUhEMWNw?=
 =?utf-8?B?Q3RqV1g5eDFnbUN6RG1jdGN6NWhhZlFwUmVpUitBeGpxWmVud2U3aWo0QmN2?=
 =?utf-8?B?YXJYdDNFYnkxUjE3dFRESlJyOE9EM0xsNVl5N044YkpkaTlCTUtqbFRMY3o3?=
 =?utf-8?B?OFBIcnJXdkNTVG9CSkJhOW50OXNDc1g2SitIeXovNGtzb1JrWDZPclY0bTNm?=
 =?utf-8?B?MjNpdDVCd0Rycy9Ham9BOGlIK1p3QVJNdC8zN1M0S0Q3N2tYSzNmdmEva2FC?=
 =?utf-8?B?dWxrQkhvOTM3RCtTeUFhWXpSQ3d0TFgrMC95ZXVEM0paOHAyc2NmenE0Sm9H?=
 =?utf-8?B?YU9CTFIvOXJZRHJNcXlreGNVNVJUY3FOVktpbXBteTg4czB5NFl3dURQdnQ3?=
 =?utf-8?B?WEVXdmxhdlVVYWNEdWlaQ3l5R0VWbUVIeHlsRXhLNEIwRVorYXg3Rys0Wmxl?=
 =?utf-8?B?YUgvVGtZd1hPYm1IUkhjVVJYckFZOVF0MThRNUVUbW9oOHovOEFIVmgyZE4z?=
 =?utf-8?B?RW5vU1FIbjdDMDlRUUx2bHU2UEp2enl5NW1IdjJxd0N4RzdPb0VLSGZ2K3NE?=
 =?utf-8?B?Mk9IRjhuUi9PYWFpYi8wQUNBeGE3UVZJdldFSUtObk5wdkg0QUs3ZnVqeGxE?=
 =?utf-8?Q?k3UA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcd2d2d-420c-456d-974c-08dd396b7d00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:59:57.9271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLE5KRoKsTKylJkwKCBTuWtZeckuvu7GescXz1MIT2z8Oh+J2sNa92j6mCV68dcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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
    <div class="moz-cite-prefix">On 2025-01-15 06:01, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com">Am
      14.01.25 um 15:53 schrieb Philip Yang:
      <br>
      <blockquote type="cite">SVM migration unmap pages from GPU and
        then update mapping to GPU to
        <br>
        recover page fault. Currently unmap clears the PDE entry for
        range
        <br>
        length &gt;= huge page and free PTB bo, update mapping to alloc
        new PT bo.
        <br>
        There is race bug that the freed entry bo maybe still on the
        pt_free
        <br>
        list, reused when updating mapping and then freed, leave invalid
        PDE
        <br>
        entry and cause GPU page fault.
        <br>
        <br>
        By setting the update to clear only one PDE entry or clear PTB,
        to
        <br>
        avoid unmap to free PTE bo. This fixes the race bug and improve
        the
        <br>
        unmap and map to GPU performance. Update mapping to huge page
        will
        <br>
        still free the PTB bo.
        <br>
        <br>
        With this change, the vm-&gt;pt_freed list and work is not
        needed. Add
        <br>
        WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to
        free the
        <br>
        PTB.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43
        +++++++----------------
        <br>
        &nbsp; 3 files changed, 13 insertions(+), 38 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index c9c48b782ec1..48b2c0b3b315 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device
        *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;vm-&gt;status_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;freed);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;done);
        <br>
        -&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;vm-&gt;pt_free_work,
        amdgpu_vm_pt_free_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_init_entities(adev, vm);
        <br>
        @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device
        *adev, struct amdgpu_vm *vm)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; flush_work(&amp;vm-&gt;pt_free_work);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(vm-&gt;task_info);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        index 5d119ac26c4f..160889e5e64d 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        @@ -369,10 +369,6 @@ struct amdgpu_vm {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BOs which are invalidated, has been updated in the PTs
        */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; /* PT BOs scheduled to free and fill with zero if vm_resv
        is not hold */
        <br>
        -&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp; pt_freed;
        <br>
        -&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp; pt_free_work;
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* contains the page directory */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base&nbsp;&nbsp;&nbsp;&nbsp; root;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *last_update;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        index f78a0434a48f..54ae0e9bc6d7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct
        amdgpu_vm_bo_base *entry)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;entry-&gt;bo);
        <br>
        &nbsp; }
        <br>
        &nbsp; -void amdgpu_vm_pt_free_work(struct work_struct *work)
        <br>
        -{
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
        <br>
        -&nbsp;&nbsp;&nbsp; LIST_HEAD(pt_freed);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; vm = container_of(work, struct amdgpu_vm, pt_free_work);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo is
        valid. */
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo, true);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next, &amp;pt_freed,
        vm_status)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
        <br>
        -}
        <br>
        -
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_vm_pt_free_list - free PD/PT levels
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked = params-&gt;unlocked;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;params-&gt;tlb_flush_waitlist))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (unlocked) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;params-&gt;tlb_flush_waitlist,
        &amp;vm-&gt;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * unlocked unmap clear page table leaves, warning to free
        the page entry.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; WARN_ON(unlocked);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next,
        &amp;params-&gt;tlb_flush_waitlist, vm_status)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
        <br>
        @@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE &lt;&lt; shift;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pe_start = ((cursor.pfn &gt;&gt; shift) &amp; mask) *
        8;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = ((uint64_t)mask + 1) &lt;&lt; shift;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor.level &lt; AMDGPU_VM_PTB &amp;&amp;
        params-&gt;unlocked)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MMU notifier callback unlocked unmap huge page,
        leave is PDE entry,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only clear one entry. Next entry search again
        for PDE or PTE leave.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = 1ULL &lt;&lt; shift;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = ((uint64_t)mask + 1) &lt;&lt; shift;
        <br>
      </blockquote>
      <br>
      That here looks to much like a hack for my taste. entry_end
      basically denotes the end of the pages tables and not the updated
      region.
      <br>
    </blockquote>
    yes, agree.<br>
    <blockquote type="cite" cite="mid:f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com">
      <br>
      We already set frag_end to this here:
      <br>
      <br>
      frag_end = max(frag_end, ALIGN(frag_start + 1, 1ULL &lt;&lt;
      shift));
      <br>
    </blockquote>
    <p>Here seems the root cause, for example, unmapping frag_start is
      8MB aligned address, frag_end is frag_start + 8MB, but for
      unlocked update we want to do page walk again after unmapping 2MB.<br>
    </p>
    <p>Also the max(....) seems meaningless, as frag_end is always &gt;=
      frag_start + 1, this can be changed to</p>
    <p>if (params-&gt;unlocked)</p>
    <p>&nbsp;&nbsp; frag_end = frag_start + 1;</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com">
      <br>
      Which basically means that we should update just one entry at the
      time and then walk the page tables again.
      <br>
      <br>
      The issue is just that we immediately calculate a new fragment
      after each update:
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag_start &gt;= frag_end) {
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next fragment */
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params,
      frag_start, end,
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags,
      &amp;frag, &amp;frag_end);
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
      <br>
      And that looks like the place we need to adjust something to allow
      updates of the leave nodes.
      <br>
    </blockquote>
    <p>yes, also we should always break here to restart page walk for
      unlocked unmapping<br>
    </p>
    <p>if (frag &lt; shift || params-&gt;unlocked)</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
    </p>
    <blockquote type="cite" cite="mid:f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com">
      <br>
      Alternatively I wouldn't mind having a complete separate function
      for unlocked invalidations.
      <br>
    </blockquote>
    <p>A complete separate function will duplicate lots of page walker
      code. Alternatively we could change amdgpu_vm_pte_fragment, for
      unlocked unmapping, always return frag_end to 2MB (or 1GB), not
      4MB, 8MB.... <br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end += cursor.pfn &amp;
        ~(entry_end - 1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = min(entry_end, end);
        <br>
        &nbsp; </blockquote>
      <br>
    </blockquote>
  </body>
</html>
