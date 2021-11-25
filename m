Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D4DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 20:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8ED76E247;
	Thu, 25 Nov 2021 20:29:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4EC6E247
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 20:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv9i+Pmyz1lmsthLe3RUT8U/+wXa9N/gcccwg0JS0YfYKjc4cKKjS6MyNMZ0Uv66AeUnAgCIg2GsZS+vT16a+lrtGkItx6cLT7zdPiqIohySgbk43PJOwYS77HG4YbgVkR4QmWrto166WCxP5b56O29jfisoGhde4Jrsnbvbh/aWDShRXv/urvq31aRLzbRZ55guN9EGdIbLGW9OskkUXxAJLENSRa3HnqiGF7TbeU08bg4yEkQBYQlTImb+JRfw8Erybg/DMA1QC+M8XyPOgzP9iXT/qtR8rKev8fRyNsxe/iGO6eSd8BlYitEEbNnFKJMZFSjuDxl+Jl7bKHryBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS0QUCmKnceLgKcwfnPh0TIzyr75TFMbGlBLWoltd3Q=;
 b=Iqj1SG6t7dtd7enOomZn8L/zFEux8eLskQF5n7o3SjcpCDeNrdU6ahplsX3L+vXJ9WjFTLor/+U6HIgP22itOT3DXrzDS72vPMmhu6udKth0HVbjaFhAIa3y4D6FC7OmM+vWHjq7Mn7UwtjrSAB/+080bgdsJZCwF59BW9qhioBbhJkOKYcBkdnloWnXknt8r72NaEC1ADsNys2YbaeqMIOOoJGtdxsoxTgUFnb1/m0zTQDLna03AZoBBTN6HutT6wZmyYIjTbVSic0mHz9WYvu/R5dDYvkYvPltgENb5o2GyGzkmTPVBndtvgaARA14qpiwpqqjCI+hs550QFko1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS0QUCmKnceLgKcwfnPh0TIzyr75TFMbGlBLWoltd3Q=;
 b=qDoUUUC4uQJ5zCR3t3MWhOaU4YrYm/r6c260NZ79+0VsdkUUUF2bGpFMCDWHPXVsP7NLn1d9VN7TKRrqsQXAL/WW/Gh8ZSIyqblBmwETNXjdVbiBYZQlwdSG71MdB00XuZVCHekN1D1ACbBnd6Xq4ysnyQUfMWc0bD/PMZX5IeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 20:29:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 20:29:43 +0000
Subject: Re: [PATCH v7] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125151656.30514-1-Philip.Yang@amd.com>
 <3730450a-1efe-4dcf-d785-1c24100b1c01@amd.com>
 <a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <c27ea6b0-dbde-41dd-7b57-8e5fb4f08c4d@amd.com>
Date: Thu, 25 Nov 2021 15:29:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.8 via Frontend Transport; Thu, 25 Nov 2021 20:29:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50291784-d5c8-4a9b-8870-08d9b052504c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB539123C323A598047145A5E1E6629@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqotnc80Q4YlPePMI9EUPP+60NgNgs6PlQStgjOLv8rCGX1yZDPjrdk8v/elLIyXgF74ITiurcTpI2KofvseXv4orgDdO2W2wrvxUmiKFMMK922cuklkPmkgVABpNS7CzFcueBkF1Wsi5qIsycveyAtTJMilXvY3m/JAcLUZC9EQ2/bQ+vftS1ynHRtUzFZRC5WSqldwZN7aM6bZPmT4kOOkfypKbDpzcyMvDk3W8df5wJllOok72lIz+xd7XhPmuMoL/v4ZO4y40z9mfmlbl8lmyEppR9V9SU7OgTukuhiWIVcgCc1WJschDuAGU+f+67l9AsSzIfYMDKeXtTyTU9pv0gZOQZAS7uiFExRbV7i/VLqA/alaLnPMhb9Af+8dfY4IO9x0RHpyAljWHQZINW7M7gvLzkeeIEJavYrQTWcoblWEmpokbg2qsFiid2R8p87dPItT5JalepBHECeqOVZdWriPBS8nELz4Evx85wYA2CSB4Di/NicmEj/+zS3zDU/tPpCZpGyAOQPKA7SOzZyNTJ2bo1wdcNgYiKExIiCRWH9avCz6r7jUkRujkbBW43ZdqImflZpZDApOfmtrHcGFFrauThfP5z34R8fXwmxGnyBNgfnYh6pO5Yp6YFA542M12QVd3BnJ37U+xWrjEK0seZHl93wCoy5pKl95Qz1CWFlAWdbf83Xb+OHH8gngZHfBjlr805V0AZhOFGaevW11P0Rh2vVPyebZGcKWItk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(4001150100001)(66946007)(66476007)(66556008)(186003)(30864003)(36756003)(83380400001)(4326008)(53546011)(26005)(2906002)(31696002)(31686004)(2616005)(5660300002)(508600001)(956004)(316002)(16576012)(8676002)(38100700002)(110136005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlqN2xzc2xadUZIbzN5dW95ZmhSOG53M1pPbUdsc2pRb3VlajlyeFhmUnM2?=
 =?utf-8?B?MmZEYXRvZktxY0NrZFFEaEZOQ1hld0pnSElVWEtFOVVFMjEvTVVaN1A3Y0c2?=
 =?utf-8?B?QThIc3VZbUh3VjUzWjBxZzV3ay85M3l2OXBQQUs5S0Z5QkxvcXRlakdPRUZk?=
 =?utf-8?B?N2Q3dFVGcGUrVVRpYW02QVpud3F3OHkvSldKaTdLZ2t0RlpyL2FpdzZPRTgr?=
 =?utf-8?B?bW9nWTlidncwMzhvMnVUcFc2ODJkQXBnR1IxRk9aa2cxdXdqV2o1UXJ4VGd6?=
 =?utf-8?B?dm5Pb3h0SnlIVUVpYjNXZjVKYkI0N3pZMVNXZ1hFRjNkMmV2RW5KcHZ5SUhV?=
 =?utf-8?B?cUdsNVpQQzRYMjM0ZkxySG8rOGE1VGFHS1Uvb2lxY0xNTG9FLzIrQmJqYi9h?=
 =?utf-8?B?TjlacmpwS3F1SXI1NENhNWZSeEFlMnkzdEhiS1AxOVJBTEc0eDdMS0prZTBO?=
 =?utf-8?B?bS9MRHNrZGJpTjA0a0xhc3c2RFJRckRrSC82WTJZWVQ1MWVIOU8xL1NjVk12?=
 =?utf-8?B?aFdSK1E5ZUFPN1N3RkZEdlVTVUIyY3ZpMkM3a2tjR1FOL0w4TUFnNVEwOGNx?=
 =?utf-8?B?NmNKYW1yZnc0REswU0Vya3V2dDhTejlaaGd6WEtOR1BSNVo0dDJYKzBwRkRq?=
 =?utf-8?B?QU85ZjlUZVBZWjR5ZHcwK3FVd3ZxZUdlZlhVUVVHRmNVN1JWbWplZXVQZjNV?=
 =?utf-8?B?b0wyckVxNEhkeHZBVGVEMFlVR29iOFdwUHFva1VpY1Jrc3BzRkQxK2gxdmF5?=
 =?utf-8?B?dkIvbk5mRm1ZVFkwYk1kU0hkcUVNZEVmU0paaHBFVXNHVFJDNGFjTW1EbUFx?=
 =?utf-8?B?NURrWGN4bEk4c0VxSzFNeFozWXYwVFc5SWVGc05Lemx4OEtaRnA4QjJQK3NH?=
 =?utf-8?B?dnBPbXozc2FTZTMrZExOMDNxRlZkZGZZLytRQjlsUitqbENhZ2JFdUdiYnRj?=
 =?utf-8?B?azdhOG1EN2tLdGIvZlBKVzl0eG50YWIxdDd3djZkMFJnMllDSHdZQXhMUXQ4?=
 =?utf-8?B?aFpnTjI1R3d0UVhFMWRCTXFZZVRvUk15Q0Zwa3JaVFRCUHRYdWc2ZTREV1B4?=
 =?utf-8?B?aFdFTDYzbEkwT3NKeFYyZzFOUXArV2JYdW1KeStNdy9ZaUxnU0RPS3o0SEFT?=
 =?utf-8?B?OVIyOFQ0QzAxZjU4UlJ4d0drRmJVaFZyR2Q2Y1ZwaDlvb2IvUkhtWmhWTlZw?=
 =?utf-8?B?c2Z4SllnNWVLbUU2R1hPclpHWjRYRFk1VEdGOURuMDM4MHRlUW1VMmRQa3d3?=
 =?utf-8?B?bjF2aFRneTJNV3g3VUhGamVmVVp6UFdPaXRIT1VRWWkvVDZ3ODRxc3hLdGwy?=
 =?utf-8?B?V29kT3QrektBV1k1VkRCUVRUNmVvNEkxYXl1R01iaktPbHdhU2NxUkJ2RTlV?=
 =?utf-8?B?VnZnRjg5aGtzQ2Z1YUM4UmU0dlFDamhCdlpmSWRqd1g5YUZWNnZkRDdqV28r?=
 =?utf-8?B?QUZsL1VuZEpkOHQycXp0SXRnZ3BySzNZaWt1c1lGOEJ3elJ1NW9wWUpHTUth?=
 =?utf-8?B?RDdzcDl2alh0Q1pFbzdYRWZSTXVRYXR0QS9FVVBUQVlnMDlJYUtlbEh6dTFa?=
 =?utf-8?B?NjNuSFVmdEFIN0dhemVPZ2V5aWRSNUhSQlNQbHlMTXd5cjNKV0ZPTDdtY20w?=
 =?utf-8?B?NlJJcDkrUDdiSkhoRVIwR0l0K1BMSWhGVUx5YWp0M1IyTUxrS2xpcWYyRDBt?=
 =?utf-8?B?Wkx2dll0SkI3QTNPV3hBcFlsSmpFOEdjdDFvSTRVQ0RBelpyNzFtYVp1OG9v?=
 =?utf-8?B?Rit0MHRuV0V2aXQ1c2NPZDVUdWdva282UUwrUTgzMDFVdi94b2J5WStpMnND?=
 =?utf-8?B?cVlPY1dlZ215OGRZTUpXVktuWUdYU0xlYXl6V1NaUjZlNmREMWpvOGZ1RTIy?=
 =?utf-8?B?OUZRZW5ZL0ZrYVArbk9XV05rL3hTdTRrYzc1SFFuQ3VYcFdVK2ZlWnpNTDhH?=
 =?utf-8?B?NCtzSGM0QWd6c3JLamhwb1BZSmNZYTU0bk56SmpiM25Ha2ZRN1o4NEVzTGR0?=
 =?utf-8?B?anhPMDVaSE9KbDl0dWFpZ3I3TkZ3bjQ4cHhWb2JUaHo0K0pWQmVyQUlEc0w4?=
 =?utf-8?B?d0FpeVVtczV4bTcwTDhENFV1NVBqOERFWjBsNjBUU2VWSzc4VnkrcCtWS2RN?=
 =?utf-8?Q?9lUY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50291784-d5c8-4a9b-8870-08d9b052504c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 20:29:43.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8UGwHNQb+Kpmw0YFfXul4xxlf6u3frTq9sXZvfdxPfD0RTXp15SdDp8AiB5w4mU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-25 1:03 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com">
      <pre class="moz-quote-pre" wrap="">
Am 2021-11-25 um 12:52 p.m. schrieb Felix Kuehling:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 2021-11-25 um 10:16 a.m. schrieb Philip Yang:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">IH ring1 is used to process GPU retry fault, overflow is enabled to
drain retry fault because we want receive other interrupts while
handling retry fault to recover range. There is no overflow flag set
when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
and drain retry fault.

If fault timestamp goes backward, the fault is filtered and should not
be processed. Drain fault is finished if latest_decoded_timestamp is
equal to or larger than checkpoint timestamp.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">If there can be multiple faults with the same time stamp, then this is
not sufficient because it would allow a stale fault with the same
timestamp to sneak through.

For example there are 3 faults with the same timestamp in the ring:

    ...     &lt;- rptr
    ...
    fault1
    fault2
    fault3  &lt;- wptr

The timestamp is taken from fault3, the current wptr.
amdgpu_ih_wait_on_checkpoint_process_ts returns when the rptr reaches
fault1 because it has the same timestamp.

    fault1  &lt;- rptr
    fault2
    fault3  &lt;- wptr

At that time fault2 and fault3 are still stale faults that could lead to
a VM fault.

You would need to wait for latest_decoded_timestamp to be truly greater
than the checkpoint (or the ring to be empty) to be sure that you've
seen all stale faults. Other than that, this patch looks good to me.
</pre>
      </blockquote>
    </blockquote>
    fault timestamp keep increasing, never see the same timestamp,
    probably because the timestamp clock is faster than the HW fills in
    IV speed.<br>
    <blockquote type="cite" cite="mid:a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Add amdgpu_ih_function interface decode_iv_ts for different chips to get
timestamp from IV entry with different iv size and timestamp offset.
amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 57 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 16 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
 10 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 45761d0328c7..45e08677207d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -350,6 +350,7 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
  * amdgpu_gmc_filter_faults - filter VM faults
  *
  * @adev: amdgpu device structure
+ * @ih: interrupt ring that the fault received from
  * @addr: address of the VM fault
  * @pasid: PASID of the process causing the fault
  * @timestamp: timestamp of the fault
@@ -358,7 +359,8 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
  * True if the fault was filtered and should not be processed further.
  * False if the fault is a new one and needs to be handled.
  */
-bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
+bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp)
 {
 	struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
@@ -366,6 +368,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	struct amdgpu_gmc_fault *fault;
 	uint32_t hash;
 
+	/* Stale retry fault if timestamp goes backward */
+	if (amdgpu_ih_ts_after(timestamp, ih-&gt;latest_decoded_timestamp))
+		return true;
+
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e55201134a01..8458cebc6d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -316,7 +316,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
 			      struct amdgpu_gmc *mc);
 void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
-bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
+bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
 void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 				     uint16_t pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..8d02f975f915 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
-/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
-static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih,
-					uint32_t checkpoint_wptr,
-					uint32_t *prev_rptr)
-{
-	uint32_t cur_rptr = ih-&gt;rptr | (*prev_rptr &amp; ~ih-&gt;ptr_mask);
-
-	/* rptr has wrapped. */
-	if (cur_rptr &lt; *prev_rptr)
-		cur_rptr += ih-&gt;ptr_mask + 1;
-	*prev_rptr = cur_rptr;
-
-	/* check ring is empty to workaround missing wptr overflow flag */
-	return cur_rptr &gt;= checkpoint_wptr ||
-	       (cur_rptr &amp; ih-&gt;ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
-}
-
 /**
- * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
  *
  * @adev: amdgpu_device pointer
  * @ih: ih ring to process
  *
  * Used to ensure ring has processed IVs up to the checkpoint write pointer.
  */
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					struct amdgpu_ih_ring *ih)
 {
-	uint32_t checkpoint_wptr, rptr;
+	uint32_t checkpoint_wptr;
+	uint64_t checkpoint_ts;
+	long timeout = HZ;
 
 	if (!ih-&gt;enabled || adev-&gt;shutdown)
 		return -ENODEV;
 
 	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-	/* Order wptr with rptr. */
+	/* Order wptr with ring data. */
 	rmb();
-	rptr = READ_ONCE(ih-&gt;rptr);
-
-	/* wptr has wrapped. */
-	if (rptr &gt; checkpoint_wptr)
-		checkpoint_wptr += ih-&gt;ptr_mask + 1;
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
 
-	return wait_event_interruptible(ih-&gt;wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &amp;rptr));
+	return wait_event_interruptible_timeout(ih-&gt;wait_process,
+		    !amdgpu_ih_ts_after(ih-&gt;latest_decoded_timestamp, checkpoint_ts),
+		    timeout);
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Your code actually does this correctly (waiting for a timestamt that's
truly greater than the checkpoint), only the commit description was
wrong. But I think you have a chance of getting a timeout when IH never
sends an interrupt with a larger timestamp, e.g. because you've already
handled all the faults before calling
amdgpu_ih_wait_on_checkpoint_process_ts and no new faults are generated.
So it may be good to add an extra check for the ring being empty to
avoid that.
</pre>
    </blockquote>
    <p>Will update ih-&gt;processed_timestamp at end of
      amdgpu_irq_dispatch to ensure entry is handled before draining
      fault returns.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> }
 
 /**
@@ -298,4 +278,21 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 
 	/* wptr/rptr are in bytes! */
 	ih-&gt;rptr += 32;
+	if (amdgpu_ih_ts_after(ih-&gt;latest_decoded_timestamp, entry-&gt;timestamp))
+		ih-&gt;latest_decoded_timestamp = entry-&gt;timestamp;
+}
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset)
+{
+	uint32_t iv_size = 32;
+	uint32_t ring_index;
+	uint32_t dw1, dw2;
+
+	rptr += iv_size * offset;
+	ring_index = (rptr &amp; ih-&gt;ptr_mask) &gt;&gt; 2;
+
+	dw1 = le32_to_cpu(ih-&gt;ring[ring_index + 1]);
+	dw2 = le32_to_cpu(ih-&gt;ring[ring_index + 2]);
+	return dw1 | ((u64)(dw2 &amp; 0xffff) &lt;&lt; 32);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 0649b59830a5..322e1521287b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
 
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
+	uint64_t		latest_decoded_timestamp;
 };
 
+/* return true if time stamp t2 is after t1 with 48bit wrap around */
+#define amdgpu_ih_ts_after(t1, t2) \
+		(((int64_t)((t2) &lt;&lt; 16) - (int64_t)((t1) &lt;&lt; 16)) &gt; 0LL)
+
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
 	/* ring read/write ptr handling, called from interrupt context */
 	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			  struct amdgpu_iv_entry *entry);
+	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
+				 signed int offset);
 	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)-&gt;irq.ih_funcs-&gt;get_wptr((adev), (ih))
 #define amdgpu_ih_decode_iv(adev, iv) \
 	(adev)-&gt;irq.ih_funcs-&gt;decode_iv((adev), (ih), (iv))
+#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
+	(WARN_ON_ONCE(!(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts) ? 0 : \
+	(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts((ih), (rptr), (offset)))
 #define amdgpu_ih_set_rptr(adev, ih) (adev)-&gt;irq.ih_funcs-&gt;set_rptr((adev), (ih))
 
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
@@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih);
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
+					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
 				struct amdgpu_iv_entry *entry);
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..d696c4754bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		/* Process it onyl if it's the first fault for this address */
 		if (entry-&gt;ih != &amp;adev-&gt;irq.ih_soft &amp;&amp;
-		    amdgpu_gmc_filter_faults(adev, addr, entry-&gt;pasid,
+		    amdgpu_gmc_filter_faults(adev, entry-&gt;ih, addr, entry-&gt;pasid,
 					     entry-&gt;timestamp))
 			return 1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..7490ce8295c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -523,7 +523,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 		/* Process it onyl if it's the first fault for this address */
 		if (entry-&gt;ih != &amp;adev-&gt;irq.ih_soft &amp;&amp;
-		    amdgpu_gmc_filter_faults(adev, addr, entry-&gt;pasid,
+		    amdgpu_gmc_filter_faults(adev, entry-&gt;ih, addr, entry-&gt;pasid,
 					     entry-&gt;timestamp))
 			return 1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 38241cf0e1f1..8ce5b8ca1fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs navi10_ih_funcs = {
 	.get_wptr = navi10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = navi10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index a9ca6988009e..3070466f54e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega10_ih_funcs = {
 	.get_wptr = vega10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index f51dfc38ac65..3b4eb8285943 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega20_ih_funcs = {
 	.get_wptr = vega20_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega20_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10868d5b549f..663489ae56d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms %p\n&quot;, i, svms);
 
-		amdgpu_ih_wait_on_checkpoint_process(pdd-&gt;dev-&gt;adev,
+		amdgpu_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&gt;adev,
 						     &amp;pdd-&gt;dev-&gt;adev-&gt;irq.ih1);
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
