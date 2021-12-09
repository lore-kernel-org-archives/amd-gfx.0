Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B166BC43217
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5D410E392;
	Thu,  9 Dec 2021 16:52:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68C189ABE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBvb5NFj/eNG0oXCSYpBJH9aY5koR3NKgbPt57CXaSnehEKqSIwVFUr2crPxhDH//I2f+sAYmQPztR6wGwrWBwXf9bWoCSGn85bwVVJvOPmAGVD07Qgouk2U/ehoVZwGwEOHy6rbbOJzaq9gFusiXDdGfNPj6aJmLLCaYrS/O84jqFYp74yl4bLLQ9MKy2PMg5WnfK/l33riWx9tTETf/pn0WzaYC0b+v2kfqg1SCboMSI/NgvkVjTmrZS4G2Z4K/dKQyXXgYAt6NptW7CUnqJzrFVcZjHeFR/vZ+9jVGk3AAsRaJdCiWIPd1nevsQBwRC6hb+AHrZojDWOQvsZpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/PckRmIX5hC4ucqVxLTSG8ppzq6OSKeCQOKGJNQHW4=;
 b=UP0W0Uvkb1vtLUx7ondRAaw1sseGjRebjrTsD/3G28AkhZp8PK99XydCCB3LPw/kkmwXB6Iw5I9WRv1IGgu18T5Xsv964O+K9A9JnOQhsX+fcsGoo2eaz/MHKTLl1WWcoVBTyqDCpFLCv85fueZAj7BVuqRhI9HWfPUjKyDctwrWYzzcOGl64pViwZ6r4NQg+U8oJjYpzRF5oEMHPVvnihFZZcWl8x42gKLBbBrS/8S1sVizEi/WafVxG1hYmnPAcudbCv6C9BxMap1vc79gvXmulQYHn1TZ/XoGN9F8I7mKdppFRW6bekzzCdSZ97Wltm07b3MAyehq1XofQ0Xkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/PckRmIX5hC4ucqVxLTSG8ppzq6OSKeCQOKGJNQHW4=;
 b=Mr2GqV8NLnOBJ/v+3oJJzOWpTusNr1NYvGAodl1UJfwWYH1Xe43BTGfvjHOzJVWHiHmqP9No/oqT1Yd/lJmpHqKn2N3hGd4L7/JWLEqNrUD6pwDKQYHFz7ppSori+KEg1J+vM14SpkZd6dNYt+aN9+oWGfL2GEZwJHNdVeKdBOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 9 Dec
 2021 00:41:45 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%5]) with mapi id 15.20.4734.024; Thu, 9 Dec 2021
 00:41:45 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Detect if amdgpu in IOMMU isolation mode
To: Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20211207145911.2690-1-Philip.Yang@amd.com>
 <4e277e05-4bf0-3f24-a28f-6ac7b33b45b4@amd.com>
 <CADnq5_NkeJsOC_bW2xW7V-aNKd3hhOZ-JmGz0-4gf6QZM2c-ew@mail.gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <9c4bf486-d977-9156-3a67-ef48194506ea@amd.com>
Date: Wed, 8 Dec 2021 19:41:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CADnq5_NkeJsOC_bW2xW7V-aNKd3hhOZ-JmGz0-4gf6QZM2c-ew@mail.gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 00:41:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9789448-a68c-4bd4-1f01-08d9baacacdf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52149064A8539569A554DD5BE6709@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVFhduDUDkSUgGu3omL28bmOrjLf0+w6ws1DwxqYQ2QnpLYJwHdt/zQMhP4NeJv9UDBRi5XsXWCIRPbT888y7O7qrFkzrjUZsH30e9EkK6xSiRC96QCX4bo3kk8fkHuV7A6HhodvN79xXSn/Hb4YQwa6FZ+OI0mpQCjQMjDlFic3w1e9GzKeuQG5gPZ4h8/r4/NqyRKkc5QEHBsMi14/FkrawwJmdKeOLKdvnkJAHVMYqhYkgodhUKeGT6DptFqYl5KMkg+Qa68ETaN5nBX0uQJpbWj0ARYqBKDf3HC29QRifb4WDQNSXTQZ2gIWPqM0TPUpwjlInHrkPnrakzJz9+qU4nbdnBxcCshLb87ADv1VlZ05PkhsiK649XTJriTD4AhPWwMaGZMIx8I3xmJmuhD/GXGGmgPpQ653dlhfnI3b5/yzx8Sk6bk00Uasv7JCjxcjvMIc80kelVRwen6bcl/1l2TCgdAsRnmXji8b+3FqbGuONELkGxA23JKhiKbD4uLPk1N3HX9e7d/oJsXnZTwn2tak21rUXGKvMKRng208/uvNT4g+WASHoHbRHP5ZkuEU0BgbAvXJrdYXOZyHZPWWr09fP0cXAQsC4IOvtU5jBLW7uGWwSwWvhG9MN7ATzBnaxaWOy1x5Z2y+Lc6tnkYxnAmuq1dJZ+eoFklvCOeAMcfoexC5qq+Z8Ue3nFAFrjHoOd6ShQa+Foe/8Y8CkxCegHOah0uj2qNZvz2On3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(2906002)(8676002)(5660300002)(966005)(54906003)(66476007)(45080400002)(186003)(38100700002)(31686004)(6486002)(316002)(31696002)(110136005)(4326008)(8936002)(166002)(2616005)(36756003)(53546011)(26005)(6636002)(508600001)(956004)(66946007)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlHWHd1eHBGS1RwWk1vRFlzTW45Wjk1SFllOVdMbElaT0FGV1FOdlhIbmFH?=
 =?utf-8?B?YUFMNjlrOG4vYTdEb0lzeWhsSmV3eUVmVFowQjZvM1BYekxsYmgwV2J3NVFT?=
 =?utf-8?B?MC9kSmFIUFZkRWRqVzVDSTFxaHcxTHlIMzNHMDRNRHhsZzlrSTg0MGV5WDFh?=
 =?utf-8?B?SGs4TkF3bVY4MVVudysvREhFNUxUZ20xSm5xZjhDNXcySVFtKzBLUitncUNx?=
 =?utf-8?B?a2NlUDc5UTVSWlRVcWM1c2RsMUNhQXI4SHN3ckt1TE11cmVFaFRSRUtBM1lq?=
 =?utf-8?B?NER4NmYvcG9FYlI5b2ZndEhpWXRReDUvVjdlQ3E3QXBJZUJNL0ZoUmN5b3Vl?=
 =?utf-8?B?eElXUW9jc2xKTEdMNXBXeW9KYjVYUFRmQUFYc284eHE2cVR6a0psNnNiL1hY?=
 =?utf-8?B?MkIzM0xYZWgwcktURkNpMklURHF3WlJ6YkF2NTlDdGEzb2drbHhWT3FCYXAz?=
 =?utf-8?B?cnFRd2lPOEJJdTErSzJzbExRMnN1YlM3YXQwVmdvLzdVc2V1bkJkdWhKN1V5?=
 =?utf-8?B?OUJKcTlIZGpsWmo3aTBxUFdySU5jVjBISHJjOFlrRGR2RHNTeVBJOFlMSWlZ?=
 =?utf-8?B?MGpjMFpnM1pjMzNsMHhMMG9mcno1dGVuQWd5VmtiaVNZeVl1L1NIbENxZ3Fr?=
 =?utf-8?B?cndObE1RVmtINUlVWkdoRVVQdHJsTGNtTjE1alpkQkdrS1g2SWFWNmM1K0R1?=
 =?utf-8?B?YnkyWUFSaGRqdkVZYlErWUY3WUttZUtsRGJDN2dlTFNabHg5ZmRNTFVQWm5K?=
 =?utf-8?B?M2YrOFd2QWN5WE16N1FWd1I1VCtEdXZjZ3l5V2g2R1NUdXVGaGFZM1F6WVBs?=
 =?utf-8?B?amRJNmV5aWdrS255SWVEMVg4OS9xZEdFZTZkbGVqcld0T2dnU3JpSVN4VkNM?=
 =?utf-8?B?YWVRdnVuekYxRTRCOHJUTVBJVW13a1dVbjRMS0x5My8vdmlILytlTGk4QkhL?=
 =?utf-8?B?bGZBaVpwSTVKWGxkRDc3YmdzVjFlVEhSQXhxV0gyRkpHbHFtcENsWDJGK1l0?=
 =?utf-8?B?M0Zzb0xJdHhjT2lDSDdKQXNReU16N0pIdUl0NmIzaFZ2aXE4ZkJPL0t4UGsz?=
 =?utf-8?B?ZXNUZWJsYzRxKzdwM2JHcktBUm1BMjZ3b0FnMDhMMG5aRFFNNkJqamw4T0w3?=
 =?utf-8?B?M240VXA4cUYyek44Vnc5ejVhYzZyOEdXeFFhODZWck1NZTJaSGQyZlZEVnVj?=
 =?utf-8?B?MEVyczlVUDkvdGxGVGpjWlNnOEZpaU9ZVmpUOWRDc3JtdVlXMmgrNWxoK0oy?=
 =?utf-8?B?RjVKMXN6b0hnd29CMTBjeXJjV2E5WXNGNHYxd3ZvclNjVkFBaWtUSDhhRmFE?=
 =?utf-8?B?SzdMcjFJSlNmTzFyR3NFVzdWY3pnUDJnWHRYdGxUK0t1c3ljdmY0bSsxZWRU?=
 =?utf-8?B?T1JrNVpreHozSkQ0VkYxRjZ0Nng4MmM0VFlpRXN3MC85ODNuWVlNMndDclZV?=
 =?utf-8?B?UlJEMjlnUVpPMlZkTDBGU2RBaEhyVnJNNGp6NkVvTUFGTG5FalJxNHliU0Mw?=
 =?utf-8?B?bG1kK1JpOGF1MlQ5eDdrcEg1U3JScjJuZU41WkZlckhQMVoxN0tEMzJ0ZlI3?=
 =?utf-8?B?MXdJRitTZGZJK0tWeUNYV3BBWUpRemF3V3gyM2x5WmdnZ211KzNIbk9BcEVl?=
 =?utf-8?B?cGtWdEsyQ2xqTExwenFFdEYza3RyT1Q5ODRTK3ZGVmV5UGJmRU84QTFMSVA3?=
 =?utf-8?B?TkZHZEtKcXl2RW1KNFh3Uk5yMlBTSXJKbUg5amhHRG9aZENFQ1NMQnU3S0o3?=
 =?utf-8?B?aFZaWUlSY3VzblRXZmZwME9rUGVFbTZtNS8wLy9PWWpESXlmNEZyUXJobUhI?=
 =?utf-8?B?TllLT0RzN1k3OENuSlgwbVJLMlg4U1JRbzFoNTQ3L21BdUE1d0xzZDhlYjdG?=
 =?utf-8?B?anhtREo3bFJ5MTJtMTk4MWV2RDFHbHFZT2JiQi9UY3BYMGdNL2hiczNiRzUw?=
 =?utf-8?B?MjdFOWQ5YkFQMU55aVFCVUpUVmRIMnIxZGxnOExVc2JuYUtIOVNtODhRb2pa?=
 =?utf-8?B?RXJydXVxSzJOS2dPb3RWaHh3azA3VUgxUGRVc3QrSHR3VTFiWVk2MUpuak9F?=
 =?utf-8?B?cTc1a3QxSWlmN2Z3MHZUZVRqaytLZWdscnZEakJNWW1yYkUvVTlxdk8zUUZx?=
 =?utf-8?Q?mwP8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9789448-a68c-4bd4-1f01-08d9baacacdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:41:44.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0A+2HfxTDeuVsSRo3pKaJF9WQ3vRtLD00wiBr2MoS+gTutAuMp81sw9KL0xYeso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: Philip Yang <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-07 5:16 p.m., Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_NkeJsOC_bW2xW7V-aNKd3hhOZ-JmGz0-4gf6QZM2c-ew@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Dec 7, 2021 at 4:59 PM Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 2021-12-07 9:59 a.m., Philip Yang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
dma_map_page return address is equal to page physical address, use this
to set adev-&gt;iommu_isolation flag which will be used to optimize memory
usage for multi GPU mappings.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
  2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..fbbe8c7b5d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,8 @@ struct amdgpu_device {

      struct amdgpu_reset_control     *reset_cntl;
      uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
+
+     bool                            iommu_isolation;
  };

  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c5afa45173c..6d0f3c477670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3364,6 +3364,31 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
      return ret;
  }

+/**
+ * amdgpu_device_check_iommu_isolation - check if IOMMU isolation is enabled
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * device is in IOMMU isolation mode if dma_map_page return address is not equal
+ * to page physical address.
+ */
+static void amdgpu_device_check_iommu_isolation(struct amdgpu_device *adev)
+{
+     struct page *page;
+     dma_addr_t addr;
+
+     page = alloc_page(GFP_KERNEL);
+     if (!page)
+             return;
+     addr = dma_map_page(adev-&gt;dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+     if (dma_mapping_error(adev-&gt;dev, addr))
+             goto out_free_page;
+     adev-&gt;iommu_isolation = (addr != page_to_phys(page));
+     dma_unmap_page(adev-&gt;dev, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This is a bit of a hack. Unfortunately it seems there isn't a much
better way to do this. I guess you could copy the implementation of
dma_map_direct in kernel/dma/mapping.c, but that's more brittle.

I think this hack only tells you whether system memory is direct-mapped.
The answer may be different for peer VRAM (which isn't supported
upstream yet, but it's coming). I think this can happen when the IOMMU
is in pass-through mode by default but still used to DMA map physical
addresses that are outside the dma mask of the GPU. So a more future
proof way would be to store a direct-mapped flag for each GPU-GPU and
GPU-System pair somehow. For the GPU-&gt;GPU direct mapping flag you'd need
to try to DMA-map a page from one GPU's VRAM to the other device.
Anyway, that can be done in a later change.

For now I'd just change the name of the flag from iommu_isolation to
direct_map_ram or ram_is_direct_mapped or similar to be more specific
about what it means.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This thread might be useful:
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Fdri-devel%2F2021-November%2F330557.html&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7Cfe724d9cbcd743c6156e08d9b9cf464d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637745122159896596%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=YW0Hxm8n5xONavU4skohVV3nbrDUEPn3ehX6f9hJe6M%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Fdri-devel%2F2021-November%2F330557.html&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7Cfe724d9cbcd743c6156e08d9b9cf464d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637745122159896596%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=YW0Hxm8n5xONavU4skohVV3nbrDUEPn3ehX6f9hJe6M%3D&amp;amp;reserved=0</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Fdri-devel%2F2021-November%2F330583.html&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7Cfe724d9cbcd743c6156e08d9b9cf464d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637745122159896596%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=ZaJgJPDa3akycHAob1y5OWr5iHMhHgqGZSijMDCpLbQ%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Fdri-devel%2F2021-November%2F330583.html&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7Cfe724d9cbcd743c6156e08d9b9cf464d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637745122159896596%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=ZaJgJPDa3akycHAob1y5OWr5iHMhHgqGZSijMDCpLbQ%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
    <p>Thanks for the helpful info, after testing on different
      platforms, I will send out v2 patch.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:CADnq5_NkeJsOC_bW2xW7V-aNKd3hhOZ-JmGz0-4gf6QZM2c-ew@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
   Felix


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+out_free_page:
+     __free_page(page);
+}
+
  static const struct attribute *amdgpu_dev_attributes[] = {
      &amp;dev_attr_product_name.attr,
      &amp;dev_attr_product_number.attr,
@@ -3767,6 +3792,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
              queue_delayed_work(system_wq, &amp;mgpu_info.delayed_reset_work,
                                 msecs_to_jiffies(AMDGPU_RESUME_MS));

+     amdgpu_device_check_iommu_isolation(adev);
+
      return 0;

  release_ras_con:
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
