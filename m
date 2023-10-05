Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CD0E92723
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 18:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF53D10E427;
	Thu,  5 Oct 2023 18:25:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D1410E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 18:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5GidRHEnnsHhntPp6YDfaiN1VqdmUPpLc6/XRdvZKGhU8jM5n4cK48EA9yNlY0b66PSZeQo5XFTBS5D5qxAou/E3jlQUe7HrfCoLSLY+petKxXL2Ely3dOauEecmLjcmeNT3obw4udIJH+LZIaD4sBNrNtdV8rZ7B/UDpEOKYtmn5FHiR0nQCQYzcRSucPLTGehotMa/9wkcyZToAxI2zHsvqeo6wZK4bbhxnDPPHt2bmQTVHLgOeQoS+hjbMT8JUaS5anN4UhATrvZ/6O4VYl0nkfdxczssGy9tqmkfK8ZRjRpuDgE19UmLIM03HhEOaOH2Iw7dBCXTrfZvdjviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6/2IIAAyUhoedpbKIS/fvW7N8lAn633qErD4iTsaM8=;
 b=S3Pb3NatlJSo+e5fyVe2ldvM1D+dlY8qq0zv3HoV/O/FmGW61JIk4emdww8xlGI/E4RlGR3jziiXuu0+NlWU/QQIO9rCz051PVlnX8JpvCt0mU170ATnE+oNhSo9DFgDPZFoIyfKC95Mrqebmvp4h+bfcm4lR5LV6O5vehBkz9Q4Y59c0Jvq4q5xwD3W7lZz7HMZGIYuEnKVrIvTi0hwLuMp/+B2swN7BBACSW0h6bqoWd2r6zNdw5p6pvvMT4I2PZjDssn0/oHSe180dCLyAb2SyHK8ILfeO9nGHZ04fm79qM3n9+THWL9jUTtwmnV+i2fitdqTvxOkTPTZ2q0GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6/2IIAAyUhoedpbKIS/fvW7N8lAn633qErD4iTsaM8=;
 b=jk7uNqvFQ50RdBSlqDoxeo/ndl/kR0K2qsIt+akpvSdv9fhmHQ/7EfPTguMSgNBvzyF8bi3Z2c3KKMuXBflL67BxCwP8Kz9qrXBZYKFJMTjrtkzm0bd4A511jD4pAj3JqxGA0yldbvt7KqiogTLLhqQObZTqP5scHG5i3iAAdnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:25:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:25:12 +0000
Message-ID: <7c6638db-758a-b71a-cae8-aab61e7e8821@amd.com>
Date: Thu, 5 Oct 2023 14:25:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c47915d-0942-48be-faf9-08dbc5d069ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYYkbixzgmfErJxm1g6GAwKV5J83w3IbVMGkE1fpJCBB8yGZizH4q6Xm2WSOTrZuG8asDskj38AECNv4YyL0IXQd1ay6b1t2eU7GnI/phBkYI6eb3CI+g2+weHbqLQywOLVIAnWRFKLUDfP6o9zfLnZODStyNSPw2tMMIRwm2GjEaKEhuvhG05qQPhZYRi7r+57MKg+2jC+s7V9gQTzui3FE/3iCvXmx5mbk+QJ9y7TZtXLzmKzbpKtTcgnxOHXEwTHr1rIRxgpCzrPE9ujEBAYuVlnN1K6DDH6AV6EIzIngLS6sVK3KO+CoCMaNiFeAD1NdXQTRvN/P20MqwIJyjnklA+3qVR8JB6VRk76blng6azF+/mP3r3b7AkEGIWe+X56GGbTl9H5Lppo7RnpZYG9x9P2Gm+1P/OdPw6gEbcMOsi71v/r/2Eau6YFyerKgtWsL7fPgNl8HNDzvRsR2AOCDntbynm+4BdPmC/J9PuuIrvEQsnE+0hGhFUZH2JyR6nAivYa5Pp+Xg4TxbdAXEq+6B3zHEzO/TD0/M9tkjSZ8/UQDA2MjfZHHZ2B50y37V+uutZ+C2eQT/D9SuGGT66Sy5YYJd4wT8ZpYV12BDOPpoTKK11OLiuwGw/ZEbmfO3zZ58fqzuRWRgNeXmRms+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(8936002)(4326008)(8676002)(6486002)(6506007)(53546011)(110136005)(6512007)(38100700002)(2616005)(41300700001)(31686004)(478600001)(83380400001)(66476007)(316002)(66946007)(66556008)(5660300002)(31696002)(2906002)(30864003)(36756003)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnR1UDdXazhYdUxOTTh5QUw5YzZvSVM4RHB1ekQ5YjJ0VU13bGQ2aVN1ZTdu?=
 =?utf-8?B?Wm0zR01qNVA3bmJzdHB5SzVCdjE2cUxtZ3kzdkJLblBWaFgyR0szYjV4cVc2?=
 =?utf-8?B?TEgreC9RanNMQWh1Q1Vlby81QWF6eDhnRkJWbW5rUjRoK0lBYnhpR1BDcUlt?=
 =?utf-8?B?RHo5R1RlV1RWTFRjK2dwVGVJNVFWTlVXZ3BPZ3p6K1lpa21CT0xlYTRuK1hk?=
 =?utf-8?B?ZkJKci8yaWJWUkZsVWFpSHBTdXFpS0lsVjNEUjcyTTlMQWhiMTVEOVk3NHdK?=
 =?utf-8?B?WE52clRlRjBUZGRiUFF3TitFTXlTbE9sdmxtWWdqcUNiOEc4RVpYV00yZkp0?=
 =?utf-8?B?Wng2OUZFN2UwWXpxM25vTXNQZmgweWdxZ04wR1ZwMlJLc3E3NkF5eVljMjRG?=
 =?utf-8?B?bUVxdnc3T25vQVV5Y2Ira1MwSStGenhHcThkZnptZjR3czdKc1JQTTJZeXli?=
 =?utf-8?B?eDVZWHBtSjFaTE5nMFFQT0IzSjFiWGtpZEltVkx5dmRRaDJJaE90YnhmZmYx?=
 =?utf-8?B?RHdnOGpFK21VUXJqd0t4OEw2cXpDaWs4SGVKcVo0V2VtMFVZaVRlYVk2Q1Iy?=
 =?utf-8?B?ZitiNmxlbXF6VDc1dnFNMzkxa2ttN2tKdFUvSERHQk9sUzB2MXVjd21vUENL?=
 =?utf-8?B?REFsRTRPd1pkRVFJQ1FPeE1jdTVRemZ4eW9iMzA0Z0ZGMEJTRXA5eW9ZMi9x?=
 =?utf-8?B?QWJqWXNuK3ZNSW55QnRLMXBVMjRLZmNiMHczTkZ5ZTVWMUdPR085NjhueUVY?=
 =?utf-8?B?ZVZpbGxYak5LeHc1ZDhwbmliNjNtTWF0MTN0RUpocDhmRWU1cmNmd3JVSWU1?=
 =?utf-8?B?MzZxbWFZUVJ0L3NzUnllUzhhcW9lSkJsS0F3OWx0V0RpbjVPV3U2S1A2azNT?=
 =?utf-8?B?SzV0aC9aSEtaNG9rdzQ0LzdVTVg0UTZ5NTlDOFQrdnVRMmRJYW1WRUVDNnls?=
 =?utf-8?B?Z2lwa1lYWmN1cEFhYTZHV3ZVZEc4cmhReWtnTk5oSnlHZHpjYlFmalkrMURv?=
 =?utf-8?B?SHkzZFFSWmluL0VNTzE2TUtIZGVTZDR5MVUzWXlUVFJ1VFo1VTNDYitxNDBy?=
 =?utf-8?B?SGhSWGNUNmVzQXpTMkI0ZHdpQU1uYnNrUTFlNUdqaUwvbzYyamtrVFR2NGow?=
 =?utf-8?B?NXQvMEtVRllqWEJkYXZmZElGaEJ3MnBIcHJ0WHl4QVliZ05Nc0JsdmtJcU5J?=
 =?utf-8?B?M3FMNmxWaGo1eU83c0pzdVcvVTByanhqOFM1UGJmR1NJQk5Dd2xWS29UMytX?=
 =?utf-8?B?M2tSUTRZZjVZNHpGaGJlSGFDZEU5bDFkaHl6a0tSd0l3UUlvQjhKOUt3TlVi?=
 =?utf-8?B?YWUvZ2NZNGs4SGUzVXBGdWYwZWhEWDBkTVltNWcxRzcybzRMLzBkZFhpZ0pE?=
 =?utf-8?B?ZW5ra3gzRGNnUzI1U0ZKTFVFd2lHU1FrU21qK0x0czcrdmlQdWQyTzgzL1E2?=
 =?utf-8?B?SS9pVU10YUY0c1RsaUZJN21wQW4xSUxLVlpPWWpzdVlKdVpzYlVrZmhKZ0Vi?=
 =?utf-8?B?c0E4SStmZnRWdkRKWXVxa2tRNytrYWg5WjFYWDdocHRORVpNVCthMWR0dUlZ?=
 =?utf-8?B?VFd3RTBCMG5VcklleTVXTGNCNlgvRTc4bWVvdWJ6Vnp1ZFNmaXpuSld2NzIv?=
 =?utf-8?B?OVk4NDZGMmZOeFFsenFMTi8yRUJUUmQvWVJpQUdmeVVuZWhEZmhoTzl0QmNn?=
 =?utf-8?B?QlF4U3FIL2FoNG5HR1N3RGh3S2xtSUZta2U3QWlTdmZIZCs1WGc5MWlQaFBW?=
 =?utf-8?B?SWtWU0c5cmhscmFDZURhSGh0d2l0YUxFeUZKc1hMVGZ1RjA1eHdSbmZRQzZJ?=
 =?utf-8?B?K2daYU5CbHBxMHBFaWY5ZFFqYTVud3R3alo0TkphaXJRQ1lGbUNvZ0R2b2tX?=
 =?utf-8?B?NGdVb0VjNytIUkVJVWptMHorTlJ3OXRnMFhnN1B4R2lrUFgzb2tvZjVCSHAx?=
 =?utf-8?B?eE9tNGIyOXZFSDJEME1aVVdEWnhNb1Z5UjZnbVlMdWJOcDlqYUlVZlJUdTVi?=
 =?utf-8?B?NStaSDZPMzRtK3MySWl1ZDNkT1pHTllmYjNKclEvSW5zWjF6b1loQzU3eFp0?=
 =?utf-8?B?T0FFamtuTW5zSnY2ZGNtZGJ0TDhEdDJBNklyWDhDUDVtQ0NBVTZoTStpYTA5?=
 =?utf-8?Q?k4Pk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c47915d-0942-48be-faf9-08dbc5d069ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:25:12.6352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di6wD/Aq8OnQ6XGvlKhN+TrnzpydyM//tgTZC49xoRo0u3cvdZ+1/Jrlj7hzR8tB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-02 13:02, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com">
      <br>
      On 9/29/2023 9:11 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Replace prange-&gt;mapped_to_gpu with
        prange-&gt;bitmap_mapped[], which is
        <br>
        based on prange granularity, updated when map to GPUS or unmap
        from
        <br>
        GPUs, to optimize multiple GPU map, unmap and retry fault
        recover.
        <br>
        <br>
        svm_range_is_mapped is false only if no parital range mapping on
        any
        <br>
        GPUs.
        <br>
        <br>
        Split the bitmap_mapped when unmap from cpu to split the prange.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218
        ++++++++++++++++++++++-----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h |&nbsp;&nbsp; 4 +-
        <br>
        &nbsp; 2 files changed, 184 insertions(+), 38 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 040dc32ad475..626e0dd4ec79 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -292,12 +292,12 @@ static void svm_range_free(struct
        svm_range *prange, bool do_unmap)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free dma_addr array for each gpu */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free dma_addr array, bitmap_mapped for each gpu */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (gpuidx = 0; gpuidx &lt; MAX_GPU_INSTANCE;
        gpuidx++) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;dma_addr[gpuidx]) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;dma_addr[gpuidx])
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(prange-&gt;dma_addr[gpuidx]);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;dma_addr[gpuidx] =
        NULL;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;bitmap_mapped[gpuidx])
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;prange-&gt;lock);
        <br>
        @@ -323,19 +323,38 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size = last - start + 1;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = kzalloc(sizeof(*prange), GFP_KERNEL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int nbits;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpuidx;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled &amp;&amp; update_mem_usage
        &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt;
        PAGE_SHIFT,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;SVM mapping failed, exceeds resident
        system memory limit\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = kzalloc(sizeof(*prange), GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;prefetch_loc,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbits = svm_range_mapped_nbits(size,
        prange-&gt;granularity);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;prange 0x%p [0x%llx 0x%llx] bitmap_mapped
        nbits %d\n&quot;, prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;bitmap_mapped[gpuidx] =
        bitmap_zalloc(nbits, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;bitmap_mapped[gpuidx]) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (gpuidx--)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(prange);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;npages = size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms = svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start = start;
        <br>
        @@ -354,10 +373,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access,
        svms-&gt;bitmap_supported,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;prefetch_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start,
        last);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return prange;
        <br>
        @@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        <br>
        +static int
        <br>
        +svm_range_split_bitmap_mapped(struct svm_range *new, struct
        svm_range *old,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(new-&gt;svms,
        struct kfd_process, svms);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int nbits, old_nbits, old_nbits2;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *bits;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpuidx;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbits = svm_range_mapped_nbits(new-&gt;npages,
        new-&gt;granularity);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_nbits = svm_range_mapped_nbits(old-&gt;npages,
        old-&gt;granularity);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_nbits2 = svm_range_mapped_nbits(last - start + 1,
        old-&gt;granularity);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;old 0x%p [0x%lx 0x%lx] =&gt; [0x%llx 0x%llx]
        nbits %d =&gt; %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old, old-&gt;start, old-&gt;last, start, last,
        old_nbits, old_nbits2);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;new 0x%p [0x%lx 0x%lx] nbits %d\n&quot;, new,
        new-&gt;start, new-&gt;last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbits);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bits)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start == old-&gt;start) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        bitmap_shift_right(new-&gt;bitmap_mapped[gpuidx],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        old-&gt;bitmap_mapped[gpuidx],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_nbits2,
        old_nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_shift_right(bits,
        old-&gt;bitmap_mapped[gpuidx], 0,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_nbits2);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        bitmap_copy(new-&gt;bitmap_mapped[gpuidx],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        old-&gt;bitmap_mapped[gpuidx], nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_shift_right(bits,
        old-&gt;bitmap_mapped[gpuidx],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbits, old_nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_free(old-&gt;bitmap_mapped[gpuidx]);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;bitmap_mapped[gpuidx] = bits;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * svm_range_split_adjust - split range and adjust
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_split_bitmap_mapped(new, old, start,
        last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;npages = last - start + 1;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;start = start;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;last = last;
        <br>
        @@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access,
        old-&gt;bitmap_access, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip,
        MAX_GPU_INSTANCE);
        <br>
        <br>
        @@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence);
        <br>
        &nbsp; }
        <br>
        <br>
        +/**
        <br>
        + * svm_range_partial_mapped_dev - check if prange mapped on the
        specific gpu
        <br>
        + *
        <br>
        + * @gpuidx: the gpu to check
        <br>
        + * @prange: prange to check
        <br>
        + * @start: the start address in pages
        <br>
        + * @last: the last address in pages
        <br>
        + *
        <br>
        + * Return:
        <br>
        + * true: if any partial range mapped on gpu based on
        granularity boundary
        <br>
        + * false: if the entire range not mapped
        <br>
        + */
        <br>
        +static bool
        <br>
        +svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range
        *prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long
        last)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long index, off;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mapped = false;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start = max(start, prange-&gt;start);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last = min(last, prange-&gt;last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (last &lt; start)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (off = start; off &lt;= last; off += (1UL &lt;&lt;
        prange-&gt;granularity)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index = (off - prange-&gt;start) &gt;&gt;
        prange-&gt;granularity;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_bit(index,
        prange-&gt;bitmap_mapped[gpuidx])) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped = true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] mapped %d on gpu
        %d\n&quot;, prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, mapped, gpuidx);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mapped;
        <br>
        +}
        <br>
        +
        <br>
        +static bool
        <br>
        +svm_range_partial_mapped(struct svm_range *prange, unsigned
        long start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(prange-&gt;svms,
        struct kfd_process, svms);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *pchild;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpuidx;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild,
        &amp;prange-&gt;child_list, child_list) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_partial_mapped_dev(gpuidx,
        pchild, start, last))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_partial_mapped_dev(gpuidx, prange,
        start, last))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
        <br>
        +}
        <br>
        +
        <br>
        +static bool svm_range_is_mapped(struct svm_range *prange)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return svm_range_partial_mapped(prange,
        prange-&gt;start, prange-&gt;last);
        <br>
        +}
        <br>
        +
        <br>
      </blockquote>
      I think svm_range_is_mapped actually means if there is any
      prange-&gt;granularity range inside prange is mapped to any gpu,
      not prange got mapped. The name is confusion.
      <br>
    </blockquote>
    Yes, agree, will add comment with detail description to clarify
    this.<br>
    <blockquote type="cite" cite="mid:a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com">
      <blockquote type="cite">+static void
        <br>
        +svm_range_update_mapped(uint32_t gpuidx, struct svm_range
        *prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long last,
        bool mapped)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long index, nbits;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index = (start - prange-&gt;start) &gt;&gt;
        prange-&gt;granularity;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbits = svm_range_mapped_nbits(last - start + 1,
        prange-&gt;granularity);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mapped)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_set(prange-&gt;bitmap_mapped[gpuidx],
        index, nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_clear(prange-&gt;bitmap_mapped[gpuidx],
        index, nbits);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] update mapped %d
        nbits %ld gpu %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, start, last, mapped, nbits, gpuidx);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_range_unmap_from_gpus(struct svm_range *prange, unsigned
        long start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last, uint32_t trigger)
        <br>
        @@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct
        svm_range *prange, unsigned long start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpuidx;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;mapped_to_gpu) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] not mapped
        to GPU\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, prange-&gt;start,
        prange-&gt;last);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;start == start &amp;&amp; prange-&gt;last
        == last) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unmap svms 0x%p prange 0x%p\n&quot;,
        prange-&gt;svms, prange);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = false;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_or(bitmap, prange-&gt;bitmap_access,
        prange-&gt;bitmap_aip,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(prange-&gt;svms, struct kfd_process,
        svms);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unmap from gpu idx 0x%x\n&quot;, gpuidx);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = kfd_process_device_from_gpuidx(p,
        gpuidx);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find device idx
        %d\n&quot;, gpuidx);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_range_partial_mapped_dev(gpuidx,
        prange, start, last)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx
        0x%lx] not mapped on gpu %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms, prange, start,
        last, gpuidx);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_update_mapped(gpuidx, prange, start,
        last, false);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unmap svms 0x%p prange 0x%p [0x%lx
        0x%lx] from gpu %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms, prange, start, last,
        gpuidx);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_unmap_from_gpu(pdd-&gt;dev,
        p-&gt;lead_thread-&gt;pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last,
        trigger);
        <br>
        <br>
        @@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range
        *prange, unsigned long offset,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_update_mapped(gpuidx, prange,
        prange-&gt;start + offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start
        + offset + npages - 1, true);
        <br>
      </blockquote>
      <br>
      svm_range_update_mapped set the mapping bitmap with
      prange-&gt;granularity, but the gpu mapping is for
      [prange-&gt;start + offset,&nbsp; prange-&gt;start + offset + npages -
      1]. The mapping bitmap covered range maybe bigger then the range
      that got mapped.
      <br>
      <br>
      In following gpu page fault handler you use
      svm_range_partial_mapped_dev(gpuidx, prange, addr, addr) to check
      if addr is mapped. Is there a room left that addr is not mapped,
      but the mapping bitmap covers it? </blockquote>
    No, this case should not happen because offset and npages are based
    on vma. <br>
    <blockquote type="cite" cite="mid:a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com">That would
      cause the page fault at addr never got handled.
      <br>
      <br>
      Regard
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = dma_fence_wait(fence, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(fence);
        <br>
        @@ -1648,7 +1789,7 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(ctx-&gt;bitmap,
        prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;mapped_to_gpu ||
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_range_is_mapped(prange) ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_empty(ctx-&gt;bitmap,
        MAX_GPU_INSTANCE)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_ctx;
        <br>
        @@ -1729,9 +1870,6 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange,
        offset, npages, readonly,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ctx-&gt;bitmap, flush_tlb);
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; next == end)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unlock(prange);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;
        <br>
        @@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (prange-&gt;flags &amp;
        KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int evicted_ranges;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mapped = prange-&gt;mapped_to_gpu;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mapped = svm_range_is_mapped(prange);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild,
        &amp;prange-&gt;child_list, child_list) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pchild-&gt;mapped_to_gpu)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_range_is_mapped(pchild))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested(&amp;pchild-&gt;lock,
        1);
        <br>
        @@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange,
        struct mm_struct *mm,
        <br>
        <br>
        &nbsp; static struct svm_range *svm_range_clone(struct svm_range
        *old)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(old-&gt;svms,
        struct kfd_process, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *new;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpuidx;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new = svm_range_new(old-&gt;svms, old-&gt;start,
        old-&gt;last, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new)
        <br>
        @@ -1988,7 +2128,11 @@ static struct svm_range
        *svm_range_clone(struct svm_range *old)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_mapped[gpuidx],
        old-&gt;bitmap_mapped[gpuidx],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_mapped_nbits(new-&gt;last
        - new-&gt;start + 1,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        new-&gt;granularity));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access,
        old-&gt;bitmap_access, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip,
        MAX_GPU_INSTANCE);
        <br>
        <br>
        @@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr,
        attrs) &amp;&amp;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_is_mapped(prange)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start ||
        node-&gt;last &gt; last) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range and
        its attributes
        <br>
        @@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migrated &amp;&amp; (!p-&gt;xnack_enabled
        ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (prange-&gt;flags &amp;
        KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &amp;&amp;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_is_mapped(prange)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restore_work will update
        mappings of GPUs\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        @@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = !migrated &amp;&amp; update_mapping
        &amp;&amp; prange-&gt;mapped_to_gpu;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = !migrated &amp;&amp; update_mapping
        &amp;&amp; svm_range_is_mapped(prange);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
        MAX_GPU_INSTANCE,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true,
        flush_tlb);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index d2e94d8fb4be..10c92c5e23a7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -132,7 +132,7 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; child_list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        *bitmap_mapped[MAX_GPU_INSTANCE];
        <br>
        &nbsp; };
        <br>
        <br>
        &nbsp; static inline void svm_range_lock(struct svm_range *prange)
        <br>
        @@ -163,6 +163,8 @@ static inline struct svm_range_bo
        *svm_range_bo_ref(struct svm_range_bo *svm_bo)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        &nbsp; }
        <br>
        <br>
        +#define svm_range_mapped_nbits(size, granularity)
        DIV_ROUND_UP((size), 1UL &lt;&lt; (granularity))
        <br>
        +
        <br>
        &nbsp; int svm_range_list_init(struct kfd_process *p);
        <br>
        &nbsp; void svm_range_list_fini(struct kfd_process *p);
        <br>
        &nbsp; int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op,
        uint64_t start,
        <br>
        --
        <br>
        2.35.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
