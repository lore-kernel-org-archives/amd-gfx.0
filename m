Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CEEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99819610D0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99819610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CE16E2D8;
	Thu, 11 Nov 2021 21:31:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70C16E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 21:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsoTZX08IS7ogPha/XrN0UvQv/Pt17RByjjVnW5cco1rJ6Pt4IZQPY7i9h0XzhJEX2xGQasLp6ael5cCc6RR8AaGtzq1B4xWyOLIbjzRiszpvIUXdFqbE2GdOwJNn/ukKAhe3hwRvP00VFBsH1JE+XbVovuibmWJcsXDRRa0FMjlTC3CAhTnjoMeIW2iyADfUJznumMfTpzWkcCVjMM+7+7oibaueuCWYTZwoETanByejHqamAWdbD93GPjFj0rkTe7tgl7FZ6RZv61WfiYRcnBp9CD0PFMhDLHnyjnkaz8qdLCH+0tqfjRUxb/tOjadd4Bl2DxPzHDvCsPJnRs0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M62PvKkiS7qxvO6zZamnminYwy54A+ukfN6vptnrn1s=;
 b=bhrbEEgCjfRz5WeJztd64Qt90aIJn0qH87kOAh9jVnKSKu29j07q1KbeVmx+f0RL2bUf7z8A/vtzPf1ocv+T+q7DcEI4D+YKMJzqJ0aoGN0xVHBIZ/c6ntsS/fBVjnn2js4TKLS2COPK2HE9HmMeWasDZPUC+LcGZS2RNP+uPzU6WUCDNl8uzpTk/CyUypjDvtnwRGDgIIuWd7rlvd84bYsoZkbkzP6p2WUfKOKoSJarw0WtMbB78/KvSWz+ll4BW1paRgwCRil1oRYrkIYqGjmSvknIXlf2nri3P0uOLBL0Oam3m36Ndov6IlXBrlRTNlMObiDYihY5RpFYsd31BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M62PvKkiS7qxvO6zZamnminYwy54A+ukfN6vptnrn1s=;
 b=SeNzxQ8g9ew3cLz+vZMX50K8suQH2zAEBJAGPYGxeHMoTQnzeOlQ2eUhMKYKRbWql304crnDOF1b5GD+Y5bxl1N90xxXgcnV0oZzXd3mS1OVi1zlA9WX0eNJqxkmFiMIL2gGeUrpdNBAMJ5SDKRxFTKHyM/Fze4jzF3gl5Nfg/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 21:31:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 11 Nov 2021
 21:31:22 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <5e646384-ce7a-9a80-f97c-ae9592e39bbc@amd.com>
 <6e566851-0372-b33b-011b-197d8321b875@gmail.com>
 <865585bf-84ac-ea2b-7e1d-a13aca7e4caf@amd.com>
 <f2005799-7371-9cfd-d3bb-7a531914175e@gmail.com>
 <8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <2bf3ceff-6dcf-ec27-e21f-f64995d0b969@amd.com>
Date: Thu, 11 Nov 2021 16:31:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:208:15e::36) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 MN2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:208:15e::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 11 Nov 2021 21:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f32bd1-9821-4e50-8072-08d9a55a9b22
X-MS-TrafficTypeDiagnostic: DM4PR12MB5310:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5310F06CE9AB3893D03C56FBE6949@DM4PR12MB5310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rob2lUGuskTmXIFPYwXSTKMMbYRcgP94G1zcKE320cBmgm5i1mLFL4IDpSuPWwxLN0gRO1DiblTjvMqivexJBLfEkDrsV2ef7sZNVHRMUoe/l/B8WlsCUPmTc2VwzpdCjYl8w03w8ETf9dVgrEszaoRBsCkhGMEDC6izO7EivJ7kqCKP2UB/jz+M1bH/mZ9V/z31GFVZkxcqqItsCv9UzW1mUzUQt6w25Icye6A2xWgspeE3Urypt6q1y7L6cNz3F+0pW6oXQC9HwMMhrMqkOIH17qii7repppa91c2H7AdzWkSjGmALvAICZYLCt7c41mSvVAQIqYhMsNCKeISoQdo7brLVihfYlv0Bw/gBzDerXbENv7nZ0fbxowIh/ZNWCJ6rCFyPivrFz4J8PfzGiE3quIalOl3yi9ewBAkdY1egtzu0GwHkYSMrZvAIdTmF3aH9F36vk20W2Wj9GZkzmSExBf3qG4t91k8cdjuRNENwhCvGbKsTK8kEodht0pHrFStHvFvI7nxQkT12OFPo06goyRHmQYrRlgOuhwa2QkogSfMll3iZuQj+9VkyKVVEQ8E91c6uV/x3E9sjAONILmO7+ouRCUVBvFKxfFKGLXLBcqL/FRHV19DorP0f0LIuwUoYG7kaWb8GYOeRk5oUDrGfla+FxTDijbrzebsudXL7K5T/mqmGR2e9pAiv8OObjeDDTjUV7+6nfQzfVsgIj+TwdTggimYbdm9fIkMOmMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(38100700002)(2906002)(186003)(26005)(66946007)(508600001)(66556008)(4001150100001)(66476007)(6486002)(31686004)(316002)(53546011)(110136005)(5660300002)(2616005)(36756003)(83380400001)(16576012)(31696002)(956004)(8676002)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVSampqNUJsUkNJL1VVc1dOdkV3V014alFJSEVIb3REZm5nMmJ1R0ViSWZM?=
 =?utf-8?B?RnpxVWtrWTNuVDZtd1FOM0lETEJIRitFSmIrM1grM3ptTXNJMUV6a3RCUmZv?=
 =?utf-8?B?V1I0VDNBd0FBQlBZVmtHVGNZVnR3eG41MENMZFdMNC9XTWxVNlRLQnJvazRR?=
 =?utf-8?B?TCticXhvUEdGTUtlM3BlcDcyaHZCSGQ5dUNMeUo1YU5RUm9wc3Z5eFNaTE9H?=
 =?utf-8?B?RFJjT0dvWFRNQXBCdjJyRzJaa1lsdU1qOVR4Z0p4WThCd3pkSUoreTFjZWNQ?=
 =?utf-8?B?SlNiUlhlZkJoT3JYWjAxTFVzQnQ4Q1l3NzlSenh5dG9sV2hrRm50czU2R04v?=
 =?utf-8?B?QWEraGpOQXpqb0ppTjFXL3JNYm9KSE5MNFhtSjBRRHRpNGs5QlY2L1luMHVr?=
 =?utf-8?B?b0hvMW9HMFBJQ1htcUNpRFpiMnhjQSsyVVgremlGZ3pKcU1mdkR5U2k2QTV2?=
 =?utf-8?B?Tm53MFd3Rjd0YlMyclJKVldWRW0zWGl4bmFWb2hXdUpCb1BtTmVqMjFOa0M3?=
 =?utf-8?B?SzhBa0tQSXBlek0rU0FESnZuNGFhdkNnUTVGTk9JQ3hERVVHWDdibElGQWk5?=
 =?utf-8?B?ZCsvcG5zRk5lRzhLR2g1R2FjeUNaWDl2Y0c1bWpoZk81QlBPS2ViQTE3Y3FO?=
 =?utf-8?B?KzlTWUhxZUFIVVNXTUI0a29wWCtuTjhaYXRJeUNNM0NNdVBqQ1NQN0g4N1R6?=
 =?utf-8?B?Sjd5ZmRlZXdINjhWYW5yQmorak5lTWpwdnhzS0VNOG1VU2VFbEpnM3hxRkZV?=
 =?utf-8?B?UHl5YnlPUWY0VnVmL0kwb0FqUkhidmZJanc2bDRGWHVmZmZscDlqWWovNVJJ?=
 =?utf-8?B?TDgvRzBrbDJJNGJkRHRKSk1YdVlza21rUTBVYW05MmxPWEttcFQrZFRxUURu?=
 =?utf-8?B?cXpqVk1vZ3BTOS8reENXckRhcmNTZzE1NDdKYlM5YW1rWDhLTzB0eWhJaDR4?=
 =?utf-8?B?V3lwMWNwRC85U2cvOW5UNzdjVG0xTEZmOUtpOWlQdDlZd1ZCUldETkZPc2Z3?=
 =?utf-8?B?OWx6aUQwSWhtTnAreVR6ViswbzREVzlOVzBVWnhtWGszQkJGbnpTTGdyVm1S?=
 =?utf-8?B?VzYvRC9XTmo5ODNYTDllVFZSN1JtSE9nSmh3UWt5TWxOTTF5LzVYRzZ4WjRl?=
 =?utf-8?B?aWdpK1Badm9kek5aSVM5Mm91ZlpJbXpBVjRpcWgybVNFWXcxRHhrcmhtcFgr?=
 =?utf-8?B?eGQ2a3ZNOFlzb2N0cis3cThhY3lHcFVmd0U1NC9iazdFRjNsZW84aWpVbHp3?=
 =?utf-8?B?NUhraXVObXpiNU04NUhVcWQvS2NHTXJQd1VlQ1kyRUpUTEtYK0xLZXZVZ2Jm?=
 =?utf-8?B?cGFyMXljMVUzUnVtNVdhMWtCZHF4ZWV0L3JtQ0h6b0o5Wmd6bXhURWUrdngw?=
 =?utf-8?B?NDdTazExeXZoUDhPVCtGNHpBKzd0bVk1bUd0d1Q4dDQ1ZThpalFyem81OXNT?=
 =?utf-8?B?V3NzR0s0cUV1Zjlma1FyWkFsUXVNcEJzTWFXSUx1bjJkMUVjNzg4eXFjdTgz?=
 =?utf-8?B?djRkbHhSZnhOcG5wRVAyMGFDK1RxWmUzb2NpQXR4RUw5Rkptck5PUUFaVnRI?=
 =?utf-8?B?OE42MnBPWkJmdlVLR1FYK3FjeWlHSVFwb0d3RWgxSkdCU0hzUmlWZWJ4VnNi?=
 =?utf-8?B?c3BpSkhtN0JZdStCQmZ3eVp4RTNnOVhrWkxTYnVFcVBBWG8vQ1ltOXNpVUVx?=
 =?utf-8?B?YlAxQld1dzBXRjJzT3NucU1YTG1xZ3BjVWlxd0UzUlhqVmI5M0hSZzgzT2RT?=
 =?utf-8?B?UmxMUUhwdzlmQ1ljelhGOExaOFI4L1g5V0Q4c3RVeWt1dHZYVjEzb2JQNE1H?=
 =?utf-8?B?ZUVybHR4U0tkdk5aeWtidmRKNWpBR2VNbkJzZmZpVGNwLzNWVG90azg1Ylhx?=
 =?utf-8?B?YldLM0UwcmNMeVVNZjQ3cExPSjhvWEo3eUdhUzVIQjA3d2RkUUQrajRnMENH?=
 =?utf-8?B?eXJUVCtaVEJSVkdldjRyTnEwVy9EOFBadXZrYXFzbDkyRWNyaGNPZ1RkSG5Z?=
 =?utf-8?B?aTVuVy9NdjI4RmI5alVTWE1LcWdiRy9KOHVOZEJ4SGcyOTJ2VWRoWmpZY1VG?=
 =?utf-8?B?cUlZTUdjVlRFb0l6MXFHMGl1UzlCN2Q2UW1mam13MDJ0ZkxxTmloMk84L1pF?=
 =?utf-8?Q?eSqQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f32bd1-9821-4e50-8072-08d9a55a9b22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 21:31:21.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUV10mZPN1gIJW9PXDgSyr0ARtdAPYv82ed8K7SBj++R9+4GhrZGYGminN0IBWw3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
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
    <div class="moz-cite-prefix">On 2021-11-11 8:57 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-11-11 um 8:43 a.m. schrieb Christian König:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 11.11.21 um 13:13 schrieb Felix Kuehling:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Am 2021-11-11 um 2:00 a.m. schrieb Christian König:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Am 11.11.21 um 00:36 schrieb Felix Kuehling:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On 2021-11-10 9:31 a.m., Christian König wrote:
[SNIP]
Aren't we processing interrupts out-of-order in this case. We're
processing newer ones before older ones. Is that the root of the
problem because it confuses our interrupt draining function?
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Good point.

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Maybe we need to detect overflows in the interrupt draining function
to make it wait longer in that case.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Ideally we should use something which is completely separate from all
those implementation details.

Like for example using the timestamp or a separate indicator/counter
instead.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Even a timestamp will be broken if the interrupt processing function
handles interrupts out of order.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
We can easily detect if the timestamp is going backwards and so filter
out stale entries.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I think we need a different amdgpu_ih_process function for IH ring 1 the
way we set it up to handle overflows. Because IH is just overwriting
older entries, and we can't read entire IH entries atomically, we have
to use a watermark. If IH WPTR passes the watermark, we have to consider
the ring overflowed and reset our RPTR. We have to set RPTR far enough
&quot;ahead&quot; of the current WPTR to make sure WPTR is under the watermark.
And the watermark needs to be low enough to ensure amdgpu_irq_dispatch
can read out the next IH entry before the WPTR catches up with the RPTR.

Since we don't read the WPTR on every iteration, and out page fault
handling code can take quite a while to process one fault, the watermark
needs to provide a lot of buffer. Maybe we also need to read the WPTR
register more frequently if the last read was more than a jiffy ago.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I think trying to solve that with the IH code or hardware is the
completely wrong approach.

As I said before we need to something more robust and using the
timestamp sounds like the most logical approach to me.

The only alternative I can see would be to have a hardware assisted
flag which tells you if you had an overflow or not like we have for IH
ring 0.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The *_ih_get_wptr functions already do some overflow handling. I think
we'll need a function to read the overflow bit that amdgpu_ih_process
can call separately, after reading IH entries.</pre>
    </blockquote>
    <p>Tried to increase ring1 buf size from 4KB to 256KB, overflow
      still happens, seems watermark is not feasible as recover fault
      takes longer period sometime. We already have 48bit timestamp in
      IV, I will try use it to check overflow, and update rptr to try
      catch up<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
E.g. something like the following:
1. Copy the next N IV from the RPTR location.
2. Get the current WPTR.
3. If the overflow bit in the WPTR is set update the RPTR to something
like WPTR+window, clear the overflow bit and repeat at #1.
4. Process the valid IVs.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
OK. Current amdgpu_irq_dispatch reads directly from the IH ring. I think
you're proposing to move reading of the ring into amdgpu_ih_process
where we can discard the entries if an overflow is detected.

Then let amdgpu_irq_dispatch use a copy that's guaranteed to be consistent.
</pre>
    </blockquote>
    <p>In amdgpu_ih_process (may add new function for ring1), after
      reading wptr, check if wptr overflow and update rptr<br>
    </p>
    <p>if (ring[rptr - 1].timestamp &gt; ring[rptr].timestamp)</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp; rptr = wptr + 1</p>
    <p>This may still process retry fault out of order, but drain fault
      will finish correctly with condition rptr &gt;= checkpoint_wptr,
      we will not process stale fault after range is freed.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
The down side is that we are loosing a lot of IVs with that. That is
probably ok for the current approach, but most likely a bad idea if we
enable the CAM.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Right. Once we use the CAM we cannot afford to lose faults. If we do, we
need to clear the CAM.

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Whenever an overflow (over the watermark) is detected, we can set a
sticky overflow bit that our page fault handling code can use to clean
up. E.g. once we start using the CAM filter, we'll have to invalidate
all CAM entries when this happens (although I'd expect overflows to
become impossible once we enable the CAM filter).

Thanks,
&nbsp;&nbsp; Felix

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
