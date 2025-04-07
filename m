Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD12AC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 08:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DA610E3E2;
	Mon,  7 Apr 2025 08:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="L7H5B2qE";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="pENCprZ7";
	dkim-atps=neutral
X-Greylist: delayed 465 seconds by postgrey-1.36 at gabe;
 Mon, 07 Apr 2025 08:59:03 UTC
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E762210E3E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 08:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1744015823;
 bh=FBxNdb3HLrC4QCyP3ozxU4W
 FQwYr1gUSw11DMHYxubY=; b=L7H5B2qEkDkD3v1uqH3BRo1FZuUWOBoj9DfwrA7ZnIHIQjI5r0
 a16DF8cHMtUuFy3hkuDCCuhdXW7+dL3/u3uidrKcAYlvpkE3yzROwyeTqFlaZQlWKuwpomh620I
 WUmI/cW6J1BonOSj2thsfTSvB/QNkeSweDW8jIoMnM35WJ0uKCY+TGroD3c8cUVyLO5DBV/9AYz
 QECiXCCtRmX7wueRT9QSpgHNIkK/7U4qy/oY/d/4z9rfiF7LvQcb7nQs9fsPnReguo/wP6dMYWJ
 VbCw0Raczp20pCL7+IET6gHg4V4uL0VVQTSM3UQfP2Qcizk2tQ0eEvuaKrNTveendGg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1744015823; bh=FBxNdb3HLrC4QCyP3ozxU4W
 FQwYr1gUSw11DMHYxubY=; b=pENCprZ7eyfKPQsOxMuSxOMK8dkjiF4VtQvdzyFatLk1k/OQEm
 S+6c4w92+OWDeFCeiwwzUEsVPI4JUn9vhhDA==;
Message-ID: <e94b2e41-a3a3-40d5-ac2c-42e3a406b79e@damsy.net>
Date: Mon, 7 Apr 2025 10:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Le 24/03/2025 à 20:48, Alex Deucher a écrit :
> ping on this series?
> 
> Alex
> 
> On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> In dev core dump, dump the full header fifo for
>> each queue. Each FIFO has 8 entries.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index f4dfa1418b740..64342160ff7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> -       /* cp header registers */
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>>          /* SE status registers */
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>> +       /* packet headers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
>>   };
>>
>>   static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>> @@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
>>   };
>>
>>   enum ta_ras_gfx_subblock {
>> @@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
>>                          for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>                                  drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       drm_printf(p, "%-50s \t 0x%08x\n",
>> -                                                  gc_cp_reg_list_9[reg].reg_name,
>> -                                                  adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          "mmCP_MEC_ME2_HEADER_DUMP",
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       else
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          gc_cp_reg_list_9[reg].reg_name,
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>>                                  }
>>                                  index += reg_count;
>>                          }
>> @@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
>>                                  soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
>>
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       adev->gfx.ip_dump_compute_queues[index + reg] =
>> -                                               RREG32(SOC15_REG_ENTRY_OFFSET(
>> -                                                       gc_cp_reg_list_9[reg]));
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
>> +                                       else
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
>> +                                                                      gc_cp_reg_list_9[reg]));
>>                                  }
>>                                  index += reg_count;
>>                          }
>> --
>> 2.49.0
>>
