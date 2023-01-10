Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F2C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 13:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE5B10E5CB;
	Tue, 10 Jan 2023 13:57:16 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBFE110E5CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 13:57:14 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id b192so6109741iof.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UT34ycz2Un3+8J14Tmau7N9ghmUu6a/NAM2acr9G+M=;
 b=DFRjQxRSpVEqe9MhLIO245Dg7DzGPBL8E17BY3kUtosFsEiIeQvx/g9r43Qhp3u1oB
 xC2GIiY+aGL0lEOYB06j/NYXfs5MDgPIO50Ib/wFVqFb7ZD/2NXVtY+HzW4Sn3NnNeNb
 z0BCqjDoJ9B25ROEO7TyCLwfPMNu30A7tkQWaFroBYakzzYf4ZYfpLI5ZurtgdmEVJZL
 5padwUgOqKNFrbk42E15M6hyy111xMoZVCDIRK9J2X+IKF9OBQ6YBuCrOCM9rUDDAWfN
 gUQWc7xZipRVJ1kIAMrDSkT5fF4HOzOl8xBJZyG4b6TBu8VywwwdSUH6FW9fhPTnwYXE
 FqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UT34ycz2Un3+8J14Tmau7N9ghmUu6a/NAM2acr9G+M=;
 b=mhLgHi3pfTndraO9Z5seYs+xtBSuwi2e8dq4maT+cTGL5o75t5YbgQOMgzEYmNvPFg
 4CwWoJtPsr8IAXe9zbH0I1I4b7iQ4/Hh0iNl3AhPzadgUDHO2lJl2weuS81ScT2qyFGq
 3lUivbD2G6UqSdm923BE00+awT0QC/9DUP5VasxAxJqNz2qUi0xxw6FYT7TgImi62QHj
 7SQj+KOUQGoBYRiGUCISU3584hWmQ6Q4mSgvAEMBCTvnD08kEsTQ1vHv1lEZ0uAkpWbs
 ZPDZgfTx1sRWJUv/ekH19ghZsSwrjrEaqYBnk6nRw+k0WifwIBFYrmFBx/6V6bA3qd9J
 HFrw==
X-Gm-Message-State: AFqh2ko09sDNie9auTzdxrua6egi4CzTR2n7Err1ZmIt3J6NC79I+miL
 lCOfyO2qDtfL80caBdvPkncwV7h6PRQ=
X-Google-Smtp-Source: AMrXdXvnHVyp/JJG7V0l4DxEtUy3KtlkUjn/UhizhHIm1bIlCgRaHBBKC7U4nZNm6PrwtPd1eI85tQ==
X-Received: by 2002:a5e:a609:0:b0:6e4:2893:2b33 with SMTP id
 q9-20020a5ea609000000b006e428932b33mr44331645ioi.14.1673359033689; 
 Tue, 10 Jan 2023 05:57:13 -0800 (PST)
Received: from ?IPV6:2602:47:d3e7:3200:aa5e:45ff:fed0:7395?
 ([2602:47:d3e7:3200:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a026641000000b00373aa370dc4sm3562933jaf.137.2023.01.10.05.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jan 2023 05:57:13 -0800 (PST)
Message-ID: <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
Date: Tue, 10 Jan 2023 06:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
 <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Matt Coffin <mcoffin13@gmail.com>
In-Reply-To: <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/9/23 23:48, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> We need these to address the fan speed setting failure reported for the new SMU13 asics.
My opinion shouldn't matter much given sparseness of activity, but, 
despite his... short tonality, I agree with Lijo's assessment there.

As someone less familiar with the code base, the use of "multiple 
sources of truth" contributes to making it harder to understand and ramp 
up with.

As for the sysfs fan control issue itself, this won't really "fix" the 
issue, but rather just remove write permissions from the hwmon files (if 
my testing+understanding is right), so it wouldn't seem to be a 
hyper-critical deliverable to me as a random outsider looking in 
(despite being effected by the issue personally). Even with that 
interface removed, there isn't another way to control the "auto" fans, 
as the FW reports it doesn't support that capability in the OD table, 
and ignores anything set therein for that purpose. Hopefully that's 
temporary until FW gets fixed?

I also think the behavior of the other proposed solution (removal of 
interface functions from the ppt_funcs), is objectively a better 
experience w/r/t outcome. If the functions are NULL, then the hwmon 
device files go away *completely*, instead of just being masked from 
write permission, which would make the message clearer to the end user 
that it's not an error, but an actual lack of functionality.

Cheers, sorry I couldn't help, but wanted to at least have something 
come of the last few days I spent implmenting OD on SMU13 for nothing!

~Matt
