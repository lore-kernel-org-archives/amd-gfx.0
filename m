Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36AEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 16:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6E510E2A3;
	Mon, 10 Jul 2023 16:36:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DAF10E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 16:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXchCo/qdp8Weq6z3LkOlbYafLPycmnWbkjk7fRC5mbKKn5s14kr7yUFYQTW17nlwynOr0LQGcwkiM6zXk3B8qOoge/jDInM46Dv8sycEhFQl8MLE/+fHZD5ZdNvk5n5xuBfN4zI22ckjU8IzjIIpY7UrieLKYRpvv8fv+KAzU9l4BqK59q6NPRpod8TjHoTjyeDjZV+jgGxIj2X8QfpkgR7CzFp0lQOr6PpJEcbISSIUjai9pjSgIdyHts05bgHZIfWUckX6waV7IbHjwpJs/hfIJ2miVARYcK194YK+K1xsnkGkw1zEecAJ/vP1Z9CbrH522UQ0QQMeFwNqYRRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD5ABm5BK2wkABjm0IKhdEdobNFZ6CEc4oEx8SV3ju4=;
 b=DqpmMljuZ72KOIuv/raU/Bsv7mCW1z0DD+qjlPDrNnUUxdVBw6jrnFa5rJmiu2HjkcTa3aCdZmbkOB82VgNBYSg9wytVvVMFvwb0ihUximGSsXKvXTzy/bCqvpBqcK8OeJ7cWtQUw7I/h6LKhe1y6oBj9MBCQnj6FP7ZpaE9Hb3Y31L0rm7HV5TRMteqBpfct64F4bWti+2j/ss2zG54G6g6hqyMM2Nu+GZrfCYmULBHwsdcjV/53BetoOB1Ij8ryDI5g0xFitVR2P41aYzCxhEy3WQMvcDQhUlUbT7XlzQLNh9F3GIR9r/P04U6kAZwP8NI9YUe4dLFQrvnNEMHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD5ABm5BK2wkABjm0IKhdEdobNFZ6CEc4oEx8SV3ju4=;
 b=LRQNRm1i4nJiqtgTe3+gQgmykfSIWqeDtSFamawVWhn112BAVwY/yw802LLS+mNBMEc0SoAiau20oV78RuqHTsCDCVXMo/t6OEYh4H1DZHkE4p9gvaU/VPlZtWHqKe6cTy1ynYKOj3/eHscyybPd0DY5uYXTz8MgSmrKUyQ29Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:36:02 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:36:02 +0000
Message-ID: <c210c321-fa69-c0ae-504e-e457ddac98c4@amd.com>
Date: Mon, 10 Jul 2023 12:36:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Increase soft IH ring size
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707154901.29568-1-Philip.Yang@amd.com>
 <6ca6ce34-df6a-884a-0ab7-8fe9e3033f3a@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <6ca6ce34-df6a-884a-0ab7-8fe9e3033f3a@gmail.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0193.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fc2dea-674a-49d0-6043-08db8163bfe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV1KY03wHRzBApUR3pY9LIMwVbjxTQ5wj+AeVqGWdUmD5nX+quuUv4JCq6c90UCkKhf8W8KCgnK/qwmj95Bwx1zYAV8OX6uSU798YVaZW0a3PotpmL0wN0x1AaRjdpK5ApuBTrXpq04piOerKtZQVA0VWFF71bv2gM57nXnEir8Pp7PSjxb6B/TimzX5mi5sglWa1M6zSQVWbiVWJ4Q0NFcddIBD1QTW86HF3i1pE6Vi4cSPswC21fC9T7NDXxJL/fystxSsj+sfoOYJlEZBFhmP1XvnA165ypyCyO06WIEMuAuqMnkcBthX0GZLDyocuOO4GSBV1/epWdV0fbdPMJaF0JhjvN/u/LSY0ZjOd62ESohBQs0uSw/6j8Cq8VK+fN0u2FL20X1dqMJ9VonA0IXdXEuveDK4eUMPuUqAu9LZKmX94RhAPKa0n5LhfyfwzyumONtuWOYMrVmW00dBNw+nuREW8y3kMTZhpEb/jTJoK/cZEU4wRqy1Kcd1Tpz71gh3ReoalP8JlM5VExcvOlRfduqqI+s6LNoGOY1JSUx0Y+x94sc1xGSgZQ4enzqB38p2QSa2OLinBFK3yzo7PICxIAk/32ySybJ97vaNQ18bwY4K/uEYGLgz1XNnVlMEuUfh7CGVuOt5czL0a2v7iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(6506007)(53546011)(186003)(26005)(41300700001)(6512007)(66574015)(83380400001)(31686004)(2616005)(6486002)(478600001)(110136005)(4326008)(66476007)(66556008)(66946007)(38100700002)(316002)(8936002)(31696002)(5660300002)(8676002)(36756003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm43ZkhOSWJWUFBtYUd6V0FiN3RsNStpWDZVSlU3R05YRzk1V3lnSGZJRFA1?=
 =?utf-8?B?N085WUtlSVFTL2k0Sk5DUlFaQWZ1cUFIYjhOQVRPQ21QZ2NDNFRVLzJIZGRx?=
 =?utf-8?B?ZHVQOHV2K1dkaVptVmFUL0NxTUQxTThvUkJFc2V2UDNtWFlkZHkybmRmdmVl?=
 =?utf-8?B?NkNWZW9xVHppcDlQYVFsTDE4Y0FnTUpEcFNERDlsL0xJODlkd0xCL1ljV21K?=
 =?utf-8?B?NW1JcDBlM0VRdk5kbVllTnR0WjJXaUF0b3MwTkVLVkZNbjhGbzR5Z0c5TmRP?=
 =?utf-8?B?eWF2VkM1enZpQkk0YjNMYUdKUk82OFI3VVkyWm5nVUZSTTY0ZWRwZTRxUWlx?=
 =?utf-8?B?ZjFkd0hmUm1NeHl4Qk1PZkNZTVZUZGJBanMyUDNldFNsMDlXWkZYRDA5YkJz?=
 =?utf-8?B?T3hGN2FhWEdFYlNpWVEyeUFoaWlBVTJKVU56TVdFdE9zQ3JZa1N3MndyQVJH?=
 =?utf-8?B?R3lXQXFxSEI4R2hNS1o3cnhaTXRQaGo2RWp1NlphTFQ0SVd3UUhZN2RtdFJ2?=
 =?utf-8?B?Y3BlbEtkUFRUSTRyYytoVGpwM2pUWHZyVkpvcy8xZkM1Mm0ydUNMODJ6Ym01?=
 =?utf-8?B?SW5vQkk4RlNOL282Z21YQ0pDU0FseEdOYzgzK3N4UDdrRkVCTXU3bnRmM0tB?=
 =?utf-8?B?b2NyOUoxYnErRXQ2MHByU3N6Y2dMekdHTVhnV2c4OTQvU0hTWndQbUo5d0RT?=
 =?utf-8?B?b0NlQUR3OGN2L3Z1V2N0WTJWWSs0eVJsQk1xN0hONHFOOFdmZ3U2UlBYQmNJ?=
 =?utf-8?B?Z3FLTE9LL205S2JmbVNreDNhVEw4WGhkazhINGJhelUxRi9qUFNUVXFtaits?=
 =?utf-8?B?Y3VHWFlkSCt6M2ZtcFBnSTdYLzVjRXJ3TkJuNi9Bb3BTRjVlbmZ1Y3d2aC85?=
 =?utf-8?B?VXplMzYvdkpDaWV1aTNCQld4WVY2NzhiQytIWGROVXQyOG4wb1NmY0VSYVdN?=
 =?utf-8?B?cStjNDNnZXFOTTlRSnRrTFh5Y3MwWTAvdTMxN2tBNG42SDd1VDZNY3ZPKzF2?=
 =?utf-8?B?MEpRdW1zU2hvREVRZnd4cXJWWlNGcDltR1BCWHozcXR2ZkVNZTlxUjFxTDhq?=
 =?utf-8?B?aGUwSjlTZWlYb2N3Y01hNDIzcExvVVNSVW11QnQxZU1uanlLYU43K1BmYWpq?=
 =?utf-8?B?dDdmR3ZaWWdMRjl5ZGtCd0ZUSmhqKy9hRVEzRmNGVng3Zi9ucCtMcGg1djBS?=
 =?utf-8?B?SkNLeUd0RHh1QlMvRWoycTFrSkxPZ1l2b3paYUpzMXNKKy9xOThpVjVXWnBW?=
 =?utf-8?B?L2JDb3BGdUs1WlBocnlvRWkvRU9hUVFxbXhlMHd1aGFBcHI3UWpoaE9TdlhK?=
 =?utf-8?B?L3dXYXRCallHeE53T0lHQWhab0ZNWDZZM2dFaUppeEUvN1pHZlN0ZDM1ZzJK?=
 =?utf-8?B?UERrWTBYbGRSdUcySzJrNWZYZndJWlg3TlJYNDdrbjY3MnN2aFo0UjNMSjZh?=
 =?utf-8?B?NzFDaG4yNWdTK055dFVlRktINHN6TFRHWUppQ1MwSzRpMmdLTjYxSmVHcGhG?=
 =?utf-8?B?bC9WejNWRngrWjFkNzZIZW9ndVNUTnZnQ1N1ZW04SlpYenlUOVJ4bUZjb0Fa?=
 =?utf-8?B?dTZBdHdwTzFzWVRUY0NGTDZrSUZBS1NYaHVxMEVudzRlZEV0UEppdkZIMm5P?=
 =?utf-8?B?bVJvdjlGZy8wbjUxRFROUm5ueW9VOUxvOEs0emErcE1NWnVUaWNxdGVFOFF5?=
 =?utf-8?B?MStQRFB0blRIVzhCT1FrUFlnWWI4KzRmeURpRjNJaFIwcU1LZXp6WUZhL3ZS?=
 =?utf-8?B?SVlxSDFobndiVGdiUUx1R2Foa2lBbHk1bnhIZUVCb1J3WERoelBVOXZKdHpJ?=
 =?utf-8?B?QlhUS09CdDFUN292ZDFEaG15VGRMOFlZdkhZMHpOU3Y5NlZqY1RaYlA2SlFr?=
 =?utf-8?B?WnNLS2JrOEFsakkxTXJOUU0vYUpOVjU5M1lQYlFpTmlPUGNxSHB0TmtNUmlK?=
 =?utf-8?B?OEpnRW9rTjdoZlU2RTgyc1RMaHJaUm5wTlJYbDQ0OXVQSHIxekdiUlcyVWVL?=
 =?utf-8?B?ejVkb0RpNWpZNG5IN0t4WU9Qb3VNbVBrZXp4UkhGeU9PbVVFNE1pUGs2TWc5?=
 =?utf-8?B?bXhOcGREQ25yU3REeWFGSUZNV0J3K04vczhMMk1BNGltbHVxNDdpVW0wdE9U?=
 =?utf-8?Q?aR/M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fc2dea-674a-49d0-6043-08db8163bfe4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:36:02.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0joE4O6TWWyY28mHP2OZ4MGo9xsfiWgjHRly5Poz85mWfeOyc+BIb89PGcqa3W7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-07-10 06:54, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6ca6ce34-df6a-884a-0ab7-8fe9e3033f3a@gmail.com">Am
      07.07.23 um 17:49 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Retry faults are delegated to soft IH ring
        and then processed by
        <br>
        deferred worker. Current soft IH ring size PAGE_SIZE can store
        128
        <br>
        entries, which may overflow and drop retry faults, causes HW
        stucks
        <br>
        because the retry fault is not recovered.
        <br>
        <br>
        Increase soft IH ring size to 8KB, enough to store 256 CAM
        entries
        <br>
        because we clear the CAM entry after handling the retry fault
        from soft
        <br>
        ring.
        <br>
        <br>
        Define macro IH_RING_SIZE and IH_SW_RING_SIZE to remove
        duplicate
        <br>
        constant.
        <br>
        <br>
        Show warning message if soft IH ring overflows because this
        should not
        <br>
        happen.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c&nbsp; | 8 ++++++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp; | 7 +++++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/ih_v6_0.c&nbsp;&nbsp;&nbsp; | 4 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/navi10_ih.c&nbsp; | 4 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/vega10_ih.c&nbsp; | 4 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 4 ++--
        <br>
        &nbsp; 7 files changed, 20 insertions(+), 13 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        index fceb3b384955..51a0dbd2358a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        @@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct
        amdgpu_device *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_ih_ring_write - write IV to the ring buffer
        <br>
        &nbsp;&nbsp; *
        <br>
        + * @adev: amdgpu_device pointer
        <br>
        &nbsp;&nbsp; * @ih: ih ring to write to
        <br>
        &nbsp;&nbsp; * @iv: the iv to write
        <br>
        &nbsp;&nbsp; * @num_dw: size of the iv in dw
        <br>
        @@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct
        amdgpu_device *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp; * Writes an IV to the ring buffer using the CPU and increment
        the wptr.
        <br>
        &nbsp;&nbsp; * Used for testing and delegating IVs to a software ring.
        <br>
        &nbsp;&nbsp; */
        <br>
        -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const
        uint32_t *iv,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw)
        <br>
        +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint32_t *iv, unsigned int num_dw)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wptr = le32_to_cpu(*ih-&gt;wptr_cpu) &gt;&gt; 2;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;
        <br>
        @@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct
        amdgpu_ih_ring *ih, const uint32_t *iv,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr != READ_ONCE(ih-&gt;rptr)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wmb();
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(*ih-&gt;wptr_cpu, cpu_to_le32(wptr));
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;IH soft ring buffer overflow
        0x%X, 0x%X\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr, ih-&gt;rptr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        index dd1c2eded6b9..6c6184f0dbc1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        @@ -27,6 +27,9 @@
        <br>
        &nbsp; /* Maximum number of IVs processed at once */
        <br>
        &nbsp; #define AMDGPU_IH_MAX_NUM_IVS&nbsp;&nbsp;&nbsp; 32
        <br>
        &nbsp; +#define IH_RING_SIZE&nbsp;&nbsp;&nbsp; (256 * 1024)
        <br>
        +#define IH_SW_RING_SIZE&nbsp;&nbsp;&nbsp; (8 * 1024)&nbsp;&nbsp;&nbsp; /* enough for 256 CAM
        entries */
        <br>
        +
        <br>
      </blockquote>
      <br>
      Please add an AMDGPU_ prefix to the macro name and don't put
      comments on the same line as the macro.
      <br>
    </blockquote>
    <p>I have pushed this, will wait longer for comment in future.
      Thanks.<br>
    </p>
    <blockquote type="cite" cite="mid:6ca6ce34-df6a-884a-0ab7-8fe9e3033f3a@gmail.com">
      <br>
      Apart from that looks good to me,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp; struct amdgpu_device;
        <br>
        &nbsp; struct amdgpu_iv_entry;
        <br>
        &nbsp; @@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
        <br>
        &nbsp; int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned ring_size, bool use_bus_addr);
        <br>
        &nbsp; void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const
        uint32_t *iv,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw);
        <br>
        +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint32_t *iv, unsigned int num_dw);
        <br>
        &nbsp; int amdgpu_ih_wait_on_checkpoint_process_ts(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
        <br>
        &nbsp; int amdgpu_ih_process(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        index 5273decc5753..fa6d0adcec20 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        @@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_write(&amp;adev-&gt;irq.ih_soft,
        entry-&gt;iv_entry, num_dw);
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_write(adev, &amp;adev-&gt;irq.ih_soft,
        entry-&gt;iv_entry, num_dw);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;adev-&gt;irq.ih_soft_work);
        <br>
        &nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
        b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
        <br>
        index b02e1cef78a7..980b24120080 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
        <br>
        @@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * use bus address for ih ring by psp bl */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_bus_addr =
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) ?
        false : true;
        <br>
        -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih, 256 *
        1024, use_bus_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih,
        IH_RING_SIZE, use_bus_addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; @@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ih control register offset */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_v6_0_init_register_offset(adev);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        PAGE_SIZE, true);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        IH_SW_RING_SIZE, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        index eec13cb5bf75..b6a8478dabf4 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        @@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_bus_addr = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_bus_addr = true;
        <br>
        -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih, 256 *
        1024, use_bus_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih,
        IH_RING_SIZE, use_bus_addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; @@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ih control registers offset */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_ih_init_register_offset(adev);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        PAGE_SIZE, true);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        IH_SW_RING_SIZE, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        index 1e83db0c5438..d364c6dd152c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        @@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih, 256 *
        1024, true);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih,
        IH_RING_SIZE, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; @@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ih control registers offset */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_init_register_offset(adev);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        PAGE_SIZE, true);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        IH_SW_RING_SIZE, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        index 4d719df376a7..544ee55a22da 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        @@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4,
        4, 2)))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_bus_addr = false;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih, 256 *
        1024, use_bus_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih,
        IH_RING_SIZE, use_bus_addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; @@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize ih control registers offset */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_ih_init_register_offset(adev);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        PAGE_SIZE, use_bus_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih_soft,
        IH_SW_RING_SIZE, use_bus_addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; </blockquote>
      <br>
    </blockquote>
  </body>
</html>
