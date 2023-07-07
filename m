Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0261C0015E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C93710E039;
	Fri,  7 Jul 2023 17:46:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9134E10E039
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrwhZRPVVQN1Q8FN3ItUE6umtxH6c3mJquOFm2Dbn1s/8lE1sRTG9JmZKIMRdg3hXkeU4bXn3yKmpVuWB9t18e4ZoFaCV2xc49GQfONAkmS4aVFGUcQDIPUG72f9+K8rFyrAw3GEwSRsfL3EK72Q+mHU22y94exwYJpTh27D30f3W7tekARazkcwojrpliavQwDkEhiYHvRCzrDrm7WObBfWJechguTX/pQV/1KOfoaWMzy1P4p1DWwFpuSrWifLmAuI3NgBsR/mOvtar8i0BVO6el2ImJzg9c6OfRnqCn4dfFt9CCnDmD6X7HUz9bu/8lO9U6+BlaHmp2CeJ38mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9btbbK+9I2y4F3Q++ob9Cp0zFnn+cleRgAKEEVBO62Q=;
 b=b9t5LEGF17WKZ18KJB4Bq6Q89JonoVkP6TP80Y8Gm9Kmx7FTeDVf/Phvtb7ju1mZDC8/1+JfpFjJXArTUgubcD1RVs0s0UJ10G9CkpsWSu3gAcsoscDAU7gY6Bqio1RD0s+C67X78XD2EpaKvBLdOC9ALZ6u7ufYaWtWgxpXUc1ABeFCg57OPI+XjWzEqx1zpBlhlMViZTz+ls8FquMmXKzgQbbDLdhp0XFZlECrq41lRiFIyN50e3zgAx7Vmcb8nPtu8bUmhoCYd27Gyn6F72hilIRvTD7LFdtlYSN3ZTABm03McYvGwJIWk/cnqg4DsPoAIZz5yYpmCXR/zpnkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9btbbK+9I2y4F3Q++ob9Cp0zFnn+cleRgAKEEVBO62Q=;
 b=wyHMjeFgOsyMwmYyhLhqvvpW0M9GDCagCWkG/CWeQMRj+9TTO9RrpC+EGcmW5jPnioy0rBZf39gU/oihdT1AYThOp7DTOaqOBPGKzsL7ej1cGCKmDA8nMxJe/wd1Zv3LWsSsoWaU6RCmKnLBkSSffqAXUzG3SqCxgQ3lvyMjjeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 17:46:00 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::4469:e2f0:3628:49f6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:46:00 +0000
Message-ID: <c7968f70-0bbc-815a-2af3-290542de775f@amd.com>
Date: Fri, 7 Jul 2023 13:45:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Increase soft IH ring size
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707154901.29568-1-Philip.Yang@amd.com>
 <2f659574-3ef8-fd74-33a5-9f7c7dac7a60@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <2f659574-3ef8-fd74-33a5-9f7c7dac7a60@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e8fe22-816d-4e83-2141-08db7f1206d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPbOUQC1s+t0zKAcI0EJlmruK5HVStUS8SYPyz9AVnwqyypbSUKFhdy5A41tzl2ZdHYGp0HhRU4hc+RkBQOsFproAYrfPV7jaQdtCYOAAKPbPbOj9inJAmKaeBOghBzRA9aPYJubqFd5+iQGneM+x57JwsVxbLBGgFJkkuEba3SbN/bJ0dF4LIoHbt0htjl5l8gytuYdnDNir5S4IpZL4czufRSkkoQS6l/6qfurDtFmRv5J7Az94Xq59bUkX1s54Wn2VKwZ+GljpPti2UXmXNNkjmERtJlKLfTN1j6kOl7xdcfS2pvUuLtmHR+JXyb4al4oxVsSRN+3vBFF2AUk7Q4adU+hLhaQL4xT1EYJQdrW0NvNFUOnPDWhUwlKdyquknkaU88SQlE7g2VBG+dJTQ46Zpu14wrnbC/3/vO16XnskQ/rg7neAZJhK8N/F4h6C+0w/x0NbWrnopKClGsXCBo2MPzBJtLNQ/Nhe/t7AXHVdQuOh/d1Ad8OiuHveW9EoS+aern9p+MW3WYkNw+BFFCHoLWDDhOyWrdg4E3cWwCvAa9ho6T0CYMup/OuWKghBZUl32xd5bRh1r3KIZNbQIGr3SFoEJjzcMtYZzpSpon/4gT8cfHH4zV6qwiY9KbSXVDmuTpgZPIDIxwhK6BsKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(6486002)(6666004)(316002)(8676002)(8936002)(41300700001)(186003)(36756003)(6512007)(6506007)(53546011)(26005)(478600001)(83380400001)(38100700002)(31686004)(66946007)(110136005)(4326008)(66556008)(66476007)(31696002)(5660300002)(2906002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJXMVpibUFDMzByVGhnN202NVpCZElTRjR4c2NoUWFldnNjaWlrR2Q0R3pS?=
 =?utf-8?B?dllPTythWDRvdHlHampZajRaSjJpOXM0MXpVTDgzRUdFdlJPdHMvcHVleHJP?=
 =?utf-8?B?NDFCOFJQd1AzM1Uvc2ZIbDRXeTd1blJreUFsMk5DUXBzdVIrSUE1akxDVjRw?=
 =?utf-8?B?RGdENW02QWFqM01HNTZXc1VINGJ6YnJOODJ5KzkzZ1lteW1ESkF1MEdVRjlw?=
 =?utf-8?B?VU9EZTVXelREVFNBNEtsSTNzbDd1OHNMck1OVzNXSWlkZGd5VkRmdGhVSGpq?=
 =?utf-8?B?TmtyRnF3UldpcDVnd3lpVW1qQ29WcXFZSmRVRCtvMmZ3S2cycERiY2g3UEtB?=
 =?utf-8?B?VXgrYnpRQ1k0bnNTSWt6ZURJcE96WCtDcWJRRWV4ODBSSDA2WTRMUTVIaGdm?=
 =?utf-8?B?Y3VSaGNhd3QwcTMzMEw2ZWtZbEpKL2VjRE1VUzh2MGV3WFZ6N3JZcXB5ZVZ1?=
 =?utf-8?B?Z1dQektuTEhPWFYrc25WTWpOVXFMaVgvVnR1RWxKOHlVVS9SWjFCamlIek1v?=
 =?utf-8?B?YlZSVUg5NnpGcGcvbGhtVUhuMmMwcWxOcFk4R0RtRkd3V3puUzZIOXZ2am9Q?=
 =?utf-8?B?TEdyM0pwYkF1NFJLdWZwUDJFYldYZmFYbFJLblJSYS9jNHU2eExEZVowcEV4?=
 =?utf-8?B?eUNWd2pqZ1lGOWhwVjdxZlNkTU9sa3dacmFYTkxMN1pTTC8ybHpEczgxcDhs?=
 =?utf-8?B?a05QUmFsZ2tvb2tic1dBQkJiMm0rTythVG9zY1VobTltS0J0RzZzY0pNenNm?=
 =?utf-8?B?VVY5OUxyL1ZQdHdjWTZiUDVqS2NSdXdQaEJ4czIrdkhqVXZ4R2Q1UFBDS0k3?=
 =?utf-8?B?THBuRnBLcDZZWDd4STIxZzdMdXN2NTZmMDdzR0VJcWtlLzJ4cVhWSWtRaEpS?=
 =?utf-8?B?ZnN0NStrZnNITWxSZGptOVN1enBPdDN2a2llVFpVdE1vdzY5Zk1oZ1JobmZo?=
 =?utf-8?B?UDhNaGxzc3pCZHlTSDZKZ3hDVHh3U2pZVThsUjV1TDcrR2swWUFjYTVaZzVJ?=
 =?utf-8?B?LzhhYUZXYVB4SG9BN1JPOVZhY01CQVJ2dFZCRks4YWxQdCt5MkVsTEx5dnM0?=
 =?utf-8?B?RXJKcFBONTB4dHZSOEtiNytLNlpiSStQbE1yNjVYY1ZHenduOXhWQk1KeVVW?=
 =?utf-8?B?M0xxR1RNQTA0d213SFhGcC84NTUyRHJNNVU4b2Vzblg4UXNIK2IzMUhkbTFQ?=
 =?utf-8?B?Y0t3VjJrKzRoeWpLR0MyeFNYclQ3S0oxQjllQVhwd1JsaURKSmZmTUNrVndi?=
 =?utf-8?B?ZXNLSGY1Zmw3K1cyWHFHNTNURk1aVExvYXpncFR1TlRDSlowMzloVVBBS2N6?=
 =?utf-8?B?STZxb25NOU5FMGhLVGpQN1VxQjYvYnZBQ3VpbUVhWHA0T0d6YkF3NEdCYm9F?=
 =?utf-8?B?Ny9sSUM1ZUR2QWtSWXhQNUZIVXRtUkREbS9vNWFlV1BkS1VjelFEV2VLMXU3?=
 =?utf-8?B?MXRRM2VXMTlJY2IxT1A1K2lIREpnZXdzbytpWFQ2UDdLOHEwTFhzZTZ3Qi90?=
 =?utf-8?B?RVZFK0Y4R2hGdmVZKzJHVFo0eWEvNzJOWWcvYUlHcGJaOVdRTk9UcnhkSEhR?=
 =?utf-8?B?a3E5MEVhT3BZOCs2MGF3UDR6MTNGZDRsZ082TGpDUVBGT1dnbytjK1I5Tmtn?=
 =?utf-8?B?K2JJUWlMMDVvOURnc3JFZm1UemRSZzlzZC8rcjJ0VDZJWHlYVFVVeVlxemg4?=
 =?utf-8?B?bEozSWdNQkJ3R0dRWDJycDVYSG1Cc2JuQVIxRVhrRUxWWnk2WWRpeUpkMWlS?=
 =?utf-8?B?c1haeWZGVW5xa3J2SnNEdXlTc05tL0N2VU1pbkIzZlhDeTdGTEZNOUlNdVVT?=
 =?utf-8?B?cHNuWW8rUUNXNmJtY20zNzJXRlRtKzRmaktvN1BXeVF4Z2huSWhqUkdvM2xY?=
 =?utf-8?B?S2I3T05sRVdJUVNkY3VRaWE1akNKRHQrTWdZSTlMbG41ZjEwU0RDaTVEVmhv?=
 =?utf-8?B?dncxY0NZV0Q3RDBTZWZxN0drNW12Vjk3b0xRT0xFRVowQUg4K2pJVmI5Vnp3?=
 =?utf-8?B?RnJMMTcza2k1VzVwL3gwMTYvcUlFK3JNTUl5VGtnMWdEcmZQOTU0R0NxU3Q5?=
 =?utf-8?B?NmNJYWhLZnNvRXE1a3g2eDBxa3JTZGI0L2VjVlpkS0cwT09Vb01JakZ1M0JE?=
 =?utf-8?Q?xEAk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8fe22-816d-4e83-2141-08db7f1206d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:46:00.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjNEnDqgRiMbAZBEPh3X0I1GKz2VmyU09PrP9l1bSz0STTIheUlW7aIDggR8+lWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
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
Cc: mukul.joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-07-07 13:15, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2f659574-3ef8-fd74-33a5-9f7c7dac7a60@amd.com">On
      2023-07-07 11:49, Philip Yang wrote:
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
      </blockquote>
      <br>
      It would indicate a problem with the CAM or it could happen on
      older GPUs that don't have a CAM. See below.
      <br>
      <br>
      <br>
      <blockquote type="cite">
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
      </blockquote>
      <br>
      If this happens, it's probably going to flood the log. It would be
      a good idea to apply a rate-limit, or use dev_warn_once. With that
      fixed, the patch is
      <br>
    </blockquote>
    <p>Will use dev_warn_once and if adev-&gt;irq.retry_cam_enabled
      because soft IH ring overflow is fine for older GPUs without CAM.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:2f659574-3ef8-fd74-33a5-9f7c7dac7a60@amd.com">
      <br>
      Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
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
        &nbsp; struct amdgpu_device;
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
    </blockquote>
  </body>
</html>
