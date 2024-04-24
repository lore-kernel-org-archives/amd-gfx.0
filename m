Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369C6C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 13:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB43010E7FB;
	Wed, 24 Apr 2024 13:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRD6QhfU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E7610E808
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 13:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhbFOKli5rlBGIf90fu6gXpUlcBzS9yh83SpW1O8APyC+N7jceJiPol07FHnNwg3Mc2uh3g8L8dofZDWN13vheaIy/qLcy+O7AjPE/dfmiZksDdt/z7BZJM0xWJHOXriWcYGgUxSZOzDjvGJ41tGl5OXCW4Tb8GYGvnAApV/ghOb9mRxZsnRD6JdYDiJ65RKVSAVoTuZvXOYUARQfgzulg7zbIRHIzpVHqEffrUWOSKepKMyHOFXZLFbO0CfZvDTUf9bQTbF8oQALyfTzfaEF3cMQxBuLFbarrIggRfbWgRRdbsQEgSUGXq0VScfClRXcd3NHm4CFqHCOg3vOc6unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4diAn0CYVxqM90EcnQcqAOIvM0/BS4ysmSLagdz3AA=;
 b=iJYc7qHBh//CX5+LUVK8WhMiZU67GBWY+647n4GZLaRpkAX4vS8TYyHNcGuAabGHj/V/FBm6k+E6UWwuu5pVhjatb6dcn7pN0A4bI69088v4hCX/UTFxXG4uOBgtVWyM+HC9OnqnZpn4tYGW6+56M27bACYZvVT/F2grZsKIe7OQng/Xi2iN5Pr5RxLI0dO/eeN726QE+zETO49GvKbjzNGhYgvelhaju/a1J71T2U9ipUZPrnd6+UEdhhm+u6Ex/Lij0mQYOhMg0KusJrSw/IXWmgMGv4baeyb0GPYpw+6+GsGvGlu7zBK5bgKUZ3SJmwEFuIseLA7Aruixc5oX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4diAn0CYVxqM90EcnQcqAOIvM0/BS4ysmSLagdz3AA=;
 b=gRD6QhfUU0pMKAQvfsxaC/fhBMM2iPPgacpOdbZ3fZLLA2gQtt8QxisarkWHvAR+z/+7tHASAGKtgcEYHE86yRWkECKro2hRWyDeqV1cZfoDrkTh4bV/Y78oLvzSGS8VMRQ8ZMAEdznBGCM6c342X+CotdVs1NhtMm98hIJI7X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 13:58:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 13:58:35 +0000
Message-ID: <a7604c70-ffcf-b828-f1d7-eb27d10f1bcd@amd.com>
Date: Wed, 24 Apr 2024 09:58:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/6] drm/amdgpu: Support contiguous VRAM allocation
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-2-Philip.Yang@amd.com>
 <00003b2f-5f31-4bf3-828a-8d7eea792563@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <00003b2f-5f31-4bf3-828a-8d7eea792563@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: c943d91a-352e-4c7b-8cf8-08dc6466a25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnpNQUhERE5UZis3Yk05bW9tSGdkL2MvNjRDTnZIbjRMTmh6bnNFVlpBL2Vt?=
 =?utf-8?B?TGhpVW1HY3g3UFhiVlpSNmNBdG8xbFdQSnB5eCtKTHBkRXMydFR3bWhXV3Bu?=
 =?utf-8?B?eHVhUWp6NFNVK09Vb25CUytYU2JXdmJMeVdrNzZ4Sk81cUN5L1pjMTBEeGZ0?=
 =?utf-8?B?Y2drLzQwZVJlZzNaUjZLblJJeUhGQmhERnNQbldLWUl3RHRycWlXaExka0dk?=
 =?utf-8?B?TzhJa0RsSHRGRkVlQXZWNGtSRXNzQlZocjMyK1M0RFZjZjJieENlNXZZdkox?=
 =?utf-8?B?VFJBTjIzRHgxMUU1QUJ2NU9wY05iWDNIamRBZEFrTVZtUUE4SFJid1lQTWsx?=
 =?utf-8?B?YjYxWmpXc3YwNmQvbG9IcDZMZkFzcWE4K1JDcEJFcXVOU0t5UW1mVzF0Q1hR?=
 =?utf-8?B?bVZCVTM1ZFZLdE9NSU1iamNRZlRiSHAyVkdjZm1KOTlaVzh6OVNIUDNKQnZW?=
 =?utf-8?B?ZGRCVUJqcTl6TDcrRXV4Y2dzMjVWaFdGYlNHOC9haThuY25OaXFvM2JKb1Fj?=
 =?utf-8?B?S0hBalVSSU5xZzJHSlVadVJjWHA5aDRMcnQ1VGQyV0k5eWFxNzdXOEtja1c3?=
 =?utf-8?B?TWx3MDBITXVxV2xwS1NkM2prR0lVNFlybWFPekRQakJ6VTUvNDdOWGdjWFU0?=
 =?utf-8?B?OGNEL1ZYTHpGeklGVFh0L21FbjZKanBnQWNPR2NOWTdVWFBXREZ5aTVxdlFm?=
 =?utf-8?B?ekt4aC9aN1RCTlFmdnJqbE9yYnBURWREdzdXeWZScit4Q3lMNFlLWEJZRVhp?=
 =?utf-8?B?VmZWYU9xSVd1Y01VUDZ4MElUamdKT2M0akVoWHp2Sk5vZDVZOThWZHVJbGV2?=
 =?utf-8?B?YVlMT29UNUJTT2x5R1MwYTdtSGtlcmorTnNOV0lYRDZJOEJmZEw0QWM3Y1Aw?=
 =?utf-8?B?YU9iUFBqcmRVQ256R2wrMDVpUTEzdVZadlp6RWh2WGFoaGpPM0dZWkZWWTJW?=
 =?utf-8?B?dHdRMFdyeXlCendtOGh3NktPWHZIM3JQNEgreFcyM3J6Z2tZbHdJanNseTVm?=
 =?utf-8?B?emkzMVdtNWVRVHl1OWYyWFNJMks5RXg3SW9SMUdvSUhFME1rTzZsUm9SMTlq?=
 =?utf-8?B?SVdDaTh2MnVlT0ltdXpBLzZxc1h1NFk0YlhnY2NSZm82LytwamF4V3pJMEtu?=
 =?utf-8?B?MUpBYUovdzR1L3VnSis2cCswZ1ZZc0Rua1lQRXg0NitkRUx2dW93d1FhNmtS?=
 =?utf-8?B?WUZWWWxoWjdIMW9Lck1qZ3lUcHVscnJ6OFpTMVVLRG11bU5JakZ2RTRycUVR?=
 =?utf-8?B?VW1DU3ZkZnovWmZXdFNYMVMrWmV6OHFVSmlJYk9Ja0doV09wdVRnOTBreTR6?=
 =?utf-8?B?c1QvdXhyOXVIdi9rb214ajZzYStwNHQ4UVBEcHo4NktHdjFrYUdORENkT3M2?=
 =?utf-8?B?b1VxL1AvKzFRUjB2WDZrQncrQ1JCaEFNcU9sK0dmWER1ZHMyb2NOM29oTXRh?=
 =?utf-8?B?MVBkekZyc1lYOTN5dFRDc3kycnFYcHdxUDRMcUZ2eXcxbGdjZDIwbEVxSnVP?=
 =?utf-8?B?YlFIMjZSOU9jaFhpZU1qREdsdzdJYkw5RFRxa3ZUaUJSL1FLeDhYTFRWdElQ?=
 =?utf-8?B?TTByTlFOTXZqTFFrVDZWWmdnSXNoYjBuZm9qN3RETlJaZ1VQbkYwUmtlTks5?=
 =?utf-8?B?WW41aDVRRzF4SUxXTkNqTDlyVzcrZFlheGkzYVZxbG9pUmhXSWZMVW56NjZI?=
 =?utf-8?B?SEJCMDU5Q2ozQzNUcUlTWGVKN2ZhcXRLVnFDTUh1OE9UTlgxK0F1cDF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVppRFdPTHBMckFwV0lqZjduK0xCcjJLN29CU1UzY2RYdXNSQUxEK3I2OFJ0?=
 =?utf-8?B?cVlVTXRkMnlwbG80dmJMUWdzbEg2aHBSbGxpQm9HQWlSNFlaSGV3NjBQQ0pR?=
 =?utf-8?B?eFdiSXlYNzVxbVRPckdHZ1krRG0xUkpJR3JzSXpIQTNBMkJBRzNNcVFVK2hI?=
 =?utf-8?B?dW1FblpZSFgzUkZUT29BQlRERVI0Z0FKT0h0YkpncVgwa2lGVVhRQjExNS81?=
 =?utf-8?B?clM3MllqcW95Smdsb2k4ekVTeDFHYVh2NFFMUUQ1R1hHMEFBQnpqdG1Gc1J2?=
 =?utf-8?B?V2Y1bnk5ekM2eGhuVFlDUjQwdHRCWjAzcmRxVXJhY1dsZjJ6bWg4S1NuUVRr?=
 =?utf-8?B?d04rb05UZGhHTW5pT21lRy9aeTVSQUpzc0tuQXBHZWNFb1cvOHc0Nk85R3Fl?=
 =?utf-8?B?TC8yZ3ZaczlnMXI5MHBOSU1PRXo2M1VNcWx0YWpTSkRXU0pwR3RuRTV3UUIw?=
 =?utf-8?B?eGduNlpzY2hqSmJXUDEyUlNXL01MbWRrWUZ1eURndi9yMEtsdzNqejNwWDlk?=
 =?utf-8?B?eERkRDBncHR5S0FJR0drdmpQbjYvSitwWDBabUhKRFpuTnIxMGVsUm9XZHNO?=
 =?utf-8?B?dmlQZjh6MXU5SWxIYlM3OEU5a1dteXJ2dDFKNEpJMU5wdUhITDZFeUM3NmlT?=
 =?utf-8?B?Um04c1REZjZSWjFPb3FyQXdSTWdzd3lGQ1NNeWhndGlWTnNSU1NqQ3JFU3Rm?=
 =?utf-8?B?U1RiQTh1dVpwVVVPYlZBYnI1QitlaUI1MGU0SzEzOEtHYU1pUURYQXVjWXBt?=
 =?utf-8?B?eXJCeE1hRVVmSkw4SjBlR1JIYzlNUG9pR2lPSG81V1hGeE5LWWtQcmdCejNz?=
 =?utf-8?B?Vit2WC9MaXVueWdxeWhyRTdnUHBNVm56czdRcXhWQmlUdEpSWmJndU42SGM0?=
 =?utf-8?B?TWI1d2dMbDNrazdXZXFQWks5cEFodUd5dTcxSkp0b21GK1FtZUJIcmhHVXlK?=
 =?utf-8?B?K1ArajhPUWxMRzMwSU1sTVdpeWdvNllCWFRiREZ4TnV5Vk5Bbi84UGFyczBh?=
 =?utf-8?B?ZjFseFZHOE52THN1N2tuRkk4a0plVFVVZUt3TXVGMDY5c3BkT0k4Rit4eUVw?=
 =?utf-8?B?dzVZNDBQUmhLWG5ZU1JJUnZBOTc2ZkNhRFFyZkhpU0p2M09UTm01b3NNVmli?=
 =?utf-8?B?YllPSEFHQWZEWldpOVhhWGNzUDJmeFFWYnNyZC9HbXBKUWs1WE9NTy9xZTRZ?=
 =?utf-8?B?ODBpbHJFclFIaDM3ZDdBVEhJSWRsOHZoRmZ2RnNOM0pHWEpiZktsVkFnS21D?=
 =?utf-8?B?YjVsSnBiR3haY3NaalRRd0ZXVThzWmt6TnhvV21pOStwSmtiVzFGZzRYSHRi?=
 =?utf-8?B?Rm1zVG83d1V4K1o5aytiY2VIOGhVLzFPWXhVRndkODhlUHdyelFpdy9mZUkr?=
 =?utf-8?B?eFh4RXlHSFd6VVBkeHJTbVVFNWE0THFLcXFldHRuREZzQVM1QW9QMzF2VHRX?=
 =?utf-8?B?YWNMWVdkdDhELzBidGUvRUVLN2RaQ1dqZ0pKSjVMbW5YQUIrcWk4S2RGQVNU?=
 =?utf-8?B?eVdSSkJjdVFpSzFZbk0yU28yQUx4Z0xyMkd6MTEzczV3T1VVbDFWeHp5RG03?=
 =?utf-8?B?ZGtnR3lYdmJZMXpLYUs1c1EyRm9tNUdicFA5c0ZFWWliOWJqZWtWQ3hBTzVr?=
 =?utf-8?B?dEhkQVBTOVNHT2dORXA5d1lvZjFWWnF3NkhFZFhybFJvQmpIaG9pMHV0VGtE?=
 =?utf-8?B?amNCdFUxaHVDTE90UFY4a2I1WUhvZmE4YlEvZEhSV3BKbHIxamhZeTRxOUpC?=
 =?utf-8?B?WkNPSUZZSThFU1p1N1MxZVJMUElEK0N4U0dNZFFRMklmMTAzajVBTDZ1MWpN?=
 =?utf-8?B?QUdjSUQzTkk0VVhTY0xyN0ZFLzJSemFlNWFWSFh5RkRQVVMvV1VRNG1vN0N5?=
 =?utf-8?B?S056bFlSeU5IUEtJckYzU1RhWkcwN1c1cTFDN1pVVlJ3WXN2bGJIVE9jbnYv?=
 =?utf-8?B?VEN2YXN2cks0Z1d5WFVDYVB5Q1BIVmhlTFZHYnBVa0pBaEJQR3VJa1RTUTFB?=
 =?utf-8?B?WEg1ZnFYNG5nWXk2STNucHVaVGlkSzU3VFVJbXR5MFF4ZkdUdjNqa2VpemJo?=
 =?utf-8?B?MHVLajJtek9DajJQNHdFMWtKdGFLWXVKVk5zdjI0UkR4UFl5TWhlL0x2OWpC?=
 =?utf-8?Q?5IdrCbslzCIvdNs82AcxYnaAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c943d91a-352e-4c7b-8cf8-08dc6466a25e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:58:35.4619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDMkdLUry1e1oXVVB1XD0VaUGGl/fOheIEn4R/H9SGTtM5NxnbPlVDE27l54V0uH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
    <div class="moz-cite-prefix">On 2024-04-23 18:17, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:00003b2f-5f31-4bf3-828a-8d7eea792563@amd.com">
      <br>
      On 2024-04-23 11:28, Philip Yang wrote:
      <br>
      <blockquote type="cite">RDMA device with limited scatter-gather
        ability requires contiguous VRAM
        <br>
        buffer allocation for RDMA peer direct support.
        <br>
        <br>
        Add a new KFD alloc memory flag and store as bo alloc flag
        <br>
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export
        for RDMA
        <br>
        peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag,
        and ask
        <br>
        VRAM buddy allocator to get contiguous VRAM.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +
        <br>
        &nbsp; 2 files changed, 5 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 0ae9fd844623..ef9154043757 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1712,6 +1712,10 @@ int
        amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags =
        AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |= (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For contiguous VRAM allocation */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |=
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_id = fpriv-&gt;xcp_id == AMDGPU_XCP_NO_PARTITION ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : fpriv-&gt;xcp_id;
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 2040a470ddb4..c1394c162d4e 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 26)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 25)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt;
        24)
        <br>
        +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT&nbsp;&nbsp;&nbsp; (1
        &lt;&lt; 23)
        <br>
      </blockquote>
      <br>
      If I understand it correctly, AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
      was redefined to mean &quot;best effort&quot;. Maybe we can drop the
      explicit &quot;BEST_EFFORT&quot; from this flag as well to keep the name to
      a reasonable length.
      <br>
    </blockquote>
    <p>yes, AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is redefined, to implement
      &quot;best effort&quot; without adding new upstream GEM flag, so we may get
      scattered allocation if contiguous allocation failed. If we drop
      the &quot;BEST_EFFORT&quot; from flag name, this may mislead the users.</p>
    <p>Regards,</p>
    <p>Philip&nbsp; </p>
    <blockquote type="cite" cite="mid:00003b2f-5f31-4bf3-828a-8d7eea792563@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp; &nbsp; /* Allocate memory for later SVM
        (shared virtual memory) mapping.
        <br>
        &nbsp;&nbsp; *
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
