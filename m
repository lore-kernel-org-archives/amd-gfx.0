Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DFC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 14:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AFB10FB39;
	Mon, 27 May 2024 14:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="biuotxQC";
	dkim-atps=neutral
Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0752510F9D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ES8eOa15WPyzIXTD7Km0uxp8XZfucVCV/uYJ9KoA8CM=; b=biuotxQCRvBk/s2Y/GDeiQGLrY
 Wcl1pY5n8+LsNkLegYbRluBazuzfyHbqJ0oJH7wTeSvBzpSAK1lcyHbaxL2EdwvVmqgjrphKXRupn
 ld7SkDDB++KQZGwJwt5diauiNBwsLV4EnaFJfrgyLaEOMOqu/avnQpQCBA/bV5cg9BLs=;
Received: from [2a02:587:6a04:fe00::298]
 by devnull.tasossah.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <tasos@tasossah.com>)
 id 1sBWsH-0037Yd-Mi; Mon, 27 May 2024 12:42:37 +0300
Message-ID: <d064e35f-4990-485b-9426-a4f5ab9f3375@tasossah.com>
Date: Mon, 27 May 2024 12:42:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240523071637.1114898-1-tasos@tasossah.com>
 <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
From: Tasos Sahanidis <tasos@tasossah.com>
Content-Language: el-GR, en-GB
Autocrypt: addr=tasos@tasossah.com; keydata=
 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
In-Reply-To: <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 14:40:35 +0000
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

On 2024-05-23 17:52, Alex Deucher wrote:
> On Thu, May 23, 2024 at 9:05 AM Tasos Sahanidis <tasos@tasossah.com> wrote:
>>
>> Dyanmically sized arrays used [1] instead of []. Replacing the former
>> with the latter resolves multiple warnings observed on boot with a
>> BONAIRE card.
>>
>> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
>> ---
>>  drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
>> index 2e8e6c9875f6..d1dec880d2d6 100644
>> --- a/drivers/gpu/drm/amd/include/pptable.h
>> +++ b/drivers/gpu/drm/amd/include/pptable.h
>> @@ -480,7 +480,7 @@ typedef struct _StateArray{
>>      //how many states we have
>>      UCHAR ucNumEntries;
>>
>> -    ATOM_PPLIB_STATE_V2 states[1];
>> +    ATOM_PPLIB_STATE_V2 states[];
> 
> Can you add __counted_by(ucNumEntries) to the end of the line? E.g.,
> 
> ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
> 
> Same comment for the other changes below.
> 
> Alex

Sure thing! I have the v2 ready and will submit after testing it on
hardware. I do have a question though. The following already uses [].
Would it be acceptable to also modify it in the same patch?

@@ -658,7 +658,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
     UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
+    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table

There's also this, which I think __counted_by can be used here as well:

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index febc853d2a07..341d4a4e8d98 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -497,15 +497,15 @@ typedef struct _ClockInfoArray{
 typedef struct _NonClockInfoArray{
 
     //how many non-clock levels we have. normally should be same as number of states
     UCHAR ucNumEntries;
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
+    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 {
     USHORT usClockLow;
     UCHAR  ucClockHigh;
     USHORT usVoltage;

All the other ones are UCHAR, so __counted_by can not be used on them.

Please let me know what you think.

Thanks!

--
Tasos
