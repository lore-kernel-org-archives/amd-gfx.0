Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB796D10F5D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7203A10E642;
	Wed, 26 Nov 2025 14:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irLvhbId";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237D910E59C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 10:01:13 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so62047695e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764151272; x=1764756072; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EuQTSlC1V3ysNRSciHYYbSy34OAON1m05+dgRUEuvU=;
 b=irLvhbId9dMHwg5u3WevwFR0L8EJw5sVFB5fla/Gu/W7oxDQhSefXTQY7BVPHciH1c
 E2Rp5OInwfW6lem1WKbGQAk/95sgUKDAhJjPL2+VE5khg2fmyHYuuzVcg5G6FVmaMQT6
 0cyNTOvweEHeD7urDwJ6eeT4Rbzh3U4suDnsk7km8Xaz92hBVDa+i7ni+1XWkh4s59IZ
 brF2OaB5RwaccDpTPldLFOE6V+gY4suIPC/16GHZJhpmEPleGyQRgAJ3z4TPyK/7P2oj
 EraMiDLIQZEP9aCeiSZkLbhu75/Kmiem6FHAsVFvJlrk2DzXoLzJspm9Cl5XtCnsv4cg
 d/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764151272; x=1764756072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8EuQTSlC1V3ysNRSciHYYbSy34OAON1m05+dgRUEuvU=;
 b=a8cnBfXJizws8bTgE9QSjVyyIpZk4DPtrgoD7D9Ba4gH5lpG2RL4Qfh6dEXTT5Gdvt
 KM20zTOFfCDQH0D0gPoyxPr2foZy3GdhXpKgKuOlbsCZj0Jv9HWyMMsDA9VZ/MoWPlcF
 gSluuAYKL5VjXONTR262W57qbGbvMdkEkxW5O+3Xc0c/eg5AzMsRXGABNvNQRkb/KTOz
 qOGph2g7n2SLE+2o7TKs7hbXcLrXBGFQZASgPZfe6JXk7X07FsfHBdQAwLU2R0ZeMq2b
 onF7v7xYFtREprQlQGJsZpi1c60vTml2UgnPXIVCkFmXSl/X3CLdzLkvHAwU/lY8SxLm
 LAvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGIMaTGL354Z4HGjpdebm5j/8/UHrJ3tReobNHS016ZT+uq3kIADBZROf+szt38ggHjGd7qg1W@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ0kGMeGU9BdJQAmHZktGIYNLLN4X/3v5dR7FoevDAwnjEhEq/
 e6kmNq5lB2wUq6JIvGaQVFUWttiZ2lqUEk/mIvgoj6Rc69lpmYoI/Ujdv6mdUpY1
X-Gm-Gg: ASbGncvL/UDM7tVKkY3askIZzh+QrAvI2UmDclW379VWyt5JBXf5vO02xlYjSQtfgZn
 d1zAT03zVATnpDux21V7rtUUG+Zd51jXmd0yEnPe2Q8yUw2TfVqChjGVU93KC0vMCl4ufqSuUSv
 i1wHs1bziSAPL4SFYVNqD3gOrMBXvGYMdmKx6XwtoWrljtzJx8eXloW33uE4JChexzcNzPlEVR8
 p0hVW2VjTTUVVE/9p3Jf+SJ8CtWQKwbkHaYDN5x7LCQhKEtQfPbB+l+JEznYIe2wrdOkv42FXOU
 YJo2Tfwy9FNw2YoMfOXZKUg2bktfdlqQ5LFDgfIIQn1fZIZ94g605GNCKBnwThQmja3CB/tQQp/
 jNBdpvELpNVZ8Gdcb2eJdz+A84PfizwLCDHsa8hF5mREkjDaqnXidOZNvKIY2zYIryJc1bu3SbZ
 x6BuC4WP9wmRreSlKSEYVPIcYhA3PtVRRl4BP6aTZLALLlaXpF
X-Google-Smtp-Source: AGHT+IFQ7Y+/iucuPS7hcif8QC/3hqv+kgRq4Vk/Dy+WiVhClQNpb5CU1Zy+aAtgmp1MSPC7AA7ctA==
X-Received: by 2002:a05:600c:5252:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-477c110328amr190471855e9.4.1764151271264; 
 Wed, 26 Nov 2025 02:01:11 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch.
 [82.192.244.13]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790addeeaasm34696135e9.7.2025.11.26.02.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 02:01:10 -0800 (PST)
Received: by eldamar.lan (Postfix, from userid 1000)
 id 0CA44BE2EE7; Wed, 26 Nov 2025 11:01:09 +0100 (CET)
Date: Wed, 26 Nov 2025 11:01:09 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Roman Savochenko <roman@oscada.org>
Cc: 1118349@bugs.debian.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <aSbP5WIKFt_07WMi@eldamar.lan>
References: <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
 <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
 <aSa1ECXKTkjM7_uv@eldamar.lan>
 <3c673963-72f3-4054-be21-a5709154bf9d@oscada.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c673963-72f3-4054-be21-a5709154bf9d@oscada.org>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:30:52 +0000
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

Hi Roman,

On Wed, Nov 26, 2025 at 11:15:32AM +0200, Roman Savochenko wrote:
> 26.11.25 10:06, Salvatore Bonaccorso:
> > On Sat, Nov 22, 2025 at 07:40:33PM +0200, Roman Savochenko wrote:
> > > Hi, Uwe Kleine-König
> > > 
> > > 22.11.25 19:22, Uwe Kleine-König:
> > > > On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
> > > > > 21.11.25 10:35, Uwe Kleine-König:
> > > > > > On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
> > > > > > > 20.11.25 10:38, Uwe Kleine-König:
> > > > > > > > On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
> > > > > > > > > 19.11.25 19:05, Uwe Kleine-König:
> > > > > > > > > > On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
> > > > > > > > > > > 12.11.25 17:03, Christian König:
> > > > > > > > > > > > On 11/12/25 15:28, Roman Savochenko wrote:
> > > > > > > > > > > > > 12.11.25 13:14, Uwe Kleine-König:
> > > > > > > OK, and what do you want from me?
> > > > > > Quoting an earlier mail in that thread:
> > > > > > 
> > > > > > 	Can you try which Debian kernel was the last one working fine
> > > > > > 	respective the first being broken in this regard? You can find
> > > > > > 	all kernels onhttps://snapshot.debian.org/. Please ask if it's
> > > > > > 	unclear how to do that.
> > > > > I have told that as the kernel in Debian 11.
> > > > Is that the last working or the first broken?
> > > > 
> > > > The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
> > > > the last in buster-security which would be 5.10.244-1? Or do you mean
> > > > the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
> > > > think)?
> > > > 
> > > > The kernels before and after that are depending on what you meant above
> > > > 5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
> > > > 5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?
> > > > 
> > > > The gist to take away here is: Don't specify kernel versions as "the one
> > > > in Debian 11" or "kernel 5" but use the proper kernel (package) version.
> > > > Everything else is too fuzzy for me to work with.
> > > And what that about when I have said that precisely???
> > > 
> > > > Kernel 5 what? E.g. which concrete version number? (output of uname -a).
> > > user@debian:~$ cat /proc/version
> > > 
> > > Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
> > > (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
> > > #1 SMP Debian 5.10.223-1 (2024-08-10)
> > > 
> > > > > > Parts of the misunderstanding here might also be a language barrier. So
> > > > > > maybe try to get some help in the kernel community that speaks your
> > > > > > native tongue.
> > > > > So, English isn't native one for you? :)
> > > > Right, and I doubt it's yours either. Or you would be the first native
> > > > English speaker in my career that I fail to understand when
> > > > communicating about Linux topics. (The only other explanations for that
> > > > I can come up with are a) you suffer from dyslexia; or b) you write
> > > > glibberish on purpose to annoy.)
> > > > 
> > > > PSA: This is my last mail to you for this bug until you come up with a
> > > > statement like:
> > > > 
> > > > 	I tested Debian kernel image package version a.b.c-d and its
> > > > 	broken with the following symptoms: [....]. The kernel image
> > > > 	that occurs in the list on
> > > > 	https://snapshot.debian.org/package/linux/ directly after that
> > > > 	(i.e. version e.f.g-h) doesn't show these symptoms.
> > > As if I need your messages with your dyslexia... :)
> > I'm closing this bug along. If you can provide the above version
> > please respond to this message with the required information and a
> > control message to reopen the bugreport.
> Are you read the post in the middle or only the end with the trash from Uwe?
> 
> Then read the part to which I have nothing to add!!!
> 
> > Kernel 5 what? E.g. which concrete version number? (output of uname -a).
> 
> user@debian:~$ cat /proc/version
> 
> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
> #1 SMP Debian 5.10.223-1 (2024-08-10)

Yes. And so you have then the last working 5.10.y version and knowing
the next one released in Debian does not work. That means you can
bisect now those two upstream stable series versions to identify which
is the breaking commit with the described procedure to identify the
breaking commit.

Once we have those biection results we might get a better idea with
upstream's help on what do do.

Regards,
Salvatore
