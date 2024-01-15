Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B46AC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 18:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EF610E349;
	Mon, 15 Jan 2024 18:08:30 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8955410E349
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705342093; x=1705946893; i=friedrich.vock@gmx.de;
 bh=Qk9n4IyBd4dfhdKZi8rQqbtAi/fg/cU3tIi4+mBfQuQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=auK9yhEUcGHp+czVnBqbfkP+b/E6fyDI04sbYmg1CKlvYoWC4wCO7BHc/tmW/Esw
 0zKVLwepgY3qBdvhQK2FU9AWeIDjT0tpEzhVxuFCZZ5b/jKFb9ZgrbZQRFEhg9zzf
 sxqyuvwlR2cnnaWG+zRHQZFZr2eVrsw8Q4j74qFTiaB2nZEymHB6s1bywg4wFNrxY
 zJU0jOpx59b6jHefqOoAbKlS1ZjLIAMbUws7NvZnwuPWDXdPqbTQVkBmdDyTFmAaG
 KH8DubCh7q5+t4DK9uvMa1RhXuuWLmC5uWPQqqyDqhqzBWnoMfrXFJj2m6gUjGWhw
 iIHGQNNlSbz2xuM/HA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1qpH9F1iSK-00aUXb; Mon, 15
 Jan 2024 19:08:13 +0100
Content-Type: multipart/alternative;
 boundary="------------zn1UVTH60JxsYtjpg6AJANLk"
Message-ID: <15b124bd-9855-4ecd-895f-763ce2833883@gmx.de>
Date: Mon, 15 Jan 2024 19:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
X-Provags-ID: V03:K1:jXKs0Xxj8Hvw3GoZ4rd0vuFyjIK2Tvm6xocyLPWkkTFI4IKR/ud
 4xgi39e3kSy8NsemeFdqcekHIdHjDlkifIkjLcGH8C0GNXUQHBZFtC+IjkhHX89k3Wsc/cx
 A1aNE5TL8mCQi38ps/LOj3LNsZLkCMZrVA31KNlu1vPdHCKVCapXatiBmy6W0W1P4c3M8zB
 sYdomKgnrrTVGLlNhaYjQ==
UI-OutboundReport: notjunk:1;M01:P0:B0ELEr1WVFg=;axZRINS8yS5wOZ8h5lGXkQr7IVU
 GfcVTlY0BNP2Gj3xBymzDonOwmS2Lo96tpoeKn/9HRGU3f90pBGKtvSJt13OaUudQUb1cKhFX
 NPcPyk2nPiZ1w887ZJlCXI1FnCXx0a+E4zCegriydBv3D3uUKWaZJn9RT46T6T1caBG+KOija
 n6baqhZfQgPzVVtsQU4E4W4tCaU5RNf/HaVGy9c2MMkLO+arD9u7JEep20j1EyX9OAehqGTud
 CfNEJ9BMux8RaH4Yoi6iwXnhCHARN3J8cbgQ3XDbJf8thAQ05tdXg3tP77tToLxmAegUufWF6
 6+zKLqwT9UskJvcGYSBN7qqP1ye9CsybUKYkWIaiRwkybw6ll29iLioATc48n+oAygtuYuTrw
 NI93C1KgwNkv3b0ww2LrgEKwZaAaJadEAV/SPsbzMAdgCGu2+6XllFN9zwblJG8iirQWNsumj
 ubuCp887UNFLuSlKCa5l3uxPG3NOWNRFBEk330X1FHpcx0E/32c/P9Y250GleoYz0TeOV72Gl
 F4h4jMuNCH2BtV9L+l1Y1lN3JXrPia6bqSa/sXBS27azhpPnGwDz4VA0HEkr8Y7VMC5flA8fH
 iHFs751V8eXL0PU8uaP9mLkv3ag8Id/CTRxY2pfedtp28isws2A9XyyJmT7nZgyBVFwLPRIa5
 10206hhYNhJrGvC8nxBc9AXq73fxWidSer0CEUoN51a8dhaytDVxSSbPnjBZ4xrWWuKrcU2VR
 2GizNbCqwVopzJ74MsiB4FLHTlvizJVdkUHtX/drD7ojbmPBb1BYni4Oy8QzYpjP89n7cZLNB
 909FHtDFnjaN8tdPDrb/DA1YkJyFpyLDQ2eSAMxKpi54eXpIArkCzvU0F/t5nzWlITwY3QI9b
 NAWDFzYYn0s3bpl76BzkbaCojZ5B7ESayWgxqo9AS8ngbXcpQS+2bgoVHlWhljkfzUnBMstGo
 RA6SmdGZZxUb89Qej923UOZyrmk=
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------zn1UVTH60JxsYtjpg6AJANLk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 15.01.24 18:54, Michel D=C3=A4nzer wrote:
> On 2024-01-15 18:26, Friedrich Vock wrote:
> [snip]
>> The fundamental problem here is that not telling applications that
>> something went wrong when you just canceled their work midway is an
>> out-of-spec hack.
>> When there is a report of real-world apps breaking because of that hack=
,
>> reports of different apps working (even if it's convenient that they
>> work) doesn't justify keeping the broken code.
> If the breaking apps hit multiple soft resets in a row, I've laid out a =
pragmatic solution which covers both cases.
Hitting soft reset every time is the lucky path. Once GPU work is
interrupted out of nowhere, all bets are off and it might as well
trigger a full system hang next time. No hang recovery should be able to
cause that under any circumstance.
>
>> If mutter needs to be robust against faults it caused itself, it should=
 be robust
>> against GPU resets.
> It's unlikely that the hangs I've seen were caused by mutter itself, mor=
e likely Mesa or amdgpu.
>
> Anyway, this will happen at some point, the reality is it hasn't yet tho=
ugh.
>
>

--------------zn1UVTH60JxsYtjpg6AJANLk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 15.01.24 18:54, Michel D=C3=A4nzer w=
rote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">On 2024-01-15 18:26, Friedric=
h Vock wrote:
[snip]
</pre>
      <blockquote type=3D"cite"><span style=3D"white-space: pre-wrap">
</span>
        <pre class=3D"moz-quote-pre" wrap=3D"">The fundamental problem her=
e is that not telling applications that
something went wrong when you just canceled their work midway is an
out-of-spec hack.
When there is a report of real-world apps breaking because of that hack,
reports of different apps working (even if it's convenient that they
work) doesn't justify keeping the broken code.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
If the breaking apps hit multiple soft resets in a row, I've laid out a pr=
agmatic solution which covers both cases.
</pre>
    </blockquote>
    Hitting soft reset every time is the lucky path. Once GPU work is
    interrupted out of nowhere, all bets are off and it might as well
    trigger a full system hang next time. No hang recovery should be
    able to cause that under any circumstance.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">If mutter needs to be robus=
t against faults it caused itself, it should be robust
against GPU resets.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
It's unlikely that the hangs I've seen were caused by mutter itself, more =
likely Mesa or amdgpu.

Anyway, this will happen at some point, the reality is it hasn't yet thoug=
h.


</pre>
    </blockquote>
  </body>
</html>

--------------zn1UVTH60JxsYtjpg6AJANLk--
