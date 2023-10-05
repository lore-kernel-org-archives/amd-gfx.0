Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0507E92728
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4849610E492;
	Thu,  5 Oct 2023 19:17:20 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69E610E169
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:17:17 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c49f781855so862028a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696533437; x=1697138237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqirAhdhlifzlWSmYkNBUWfnYzjdjuk6xxAE0rOCESk=;
 b=No+MVm5a/DY/xio4o7dfrIn4nROx4M15LzXVDNSwXhtjDi76M7D575QqAEzGD5m/E4
 9QQTAVfM0Wc054dO6gPkCUdnn7APPTgCdLjMyudOwJeiR/bL5SSsZVlrrGR/IH2S0sWN
 ZCfzuc//ol4r0aYirkROtySGOGojaps3UDK6sKCco6RRQf/VOPVhcZkPQAUYkQHVVOK7
 lJntnnlvHElyPbycXtyUg1sjpRTAWnA56q1Z0/3WZCbtTwzUAAOv8iquUNKmTR242roI
 bDAk7Gyh3pjMYMtXHkSGtfhIiqUS4DQNOMlDrCjsdodpGsNvDSRHjQcEgzcTDoKqMayS
 p4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696533437; x=1697138237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqirAhdhlifzlWSmYkNBUWfnYzjdjuk6xxAE0rOCESk=;
 b=eeZB86gbSeuXmsV/5NjlucD0r94VyKJ4rDXwffRi0JORt7lL1ceq63q9WGUsPC/Low
 7m9rzRPZBhI/+Af+qlPTmABsGdCrCR5RN3wMJiMvp2vuU+gp16wqa0eiBO5HUqG6Uv4Q
 qu5VS2BJndzXb/cgyPX7j8UI/2dirxQCnZ0TErfOErYcblwxsbST1cnEIWXFBdxXya3N
 LbGdOCVEg8X7rhRW9A/kaS38ObpjmPPRAmdqK/mZ3yF77EpbyKeNzK2ZMgkKKsyqj4fR
 07vHQUftNVuEHhv4xofe/4iPM7RGenosO4gJy7+oAReqOh/gBIQA2hOc14RZxAW+TE5V
 gIgg==
X-Gm-Message-State: AOJu0YwB3g/+rQe+EgR79ZTrHdpAACe3AldJNLwct6UpoXld49tECsEO
 xXaNOYELqBHF9b/Rs0INF0D9sDhdrmnYqM1VQLw=
X-Google-Smtp-Source: AGHT+IE9blaE8fKYMPW45SEpXrubpwaapIeDOKnbcoknHheWjAVJiN+4m5TQBB5p+A2vaUi+VAlbFj5qOlq3oinBPvU=
X-Received: by 2002:a05:6870:560a:b0:1d6:79e2:8484 with SMTP id
 m10-20020a056870560a00b001d679e28484mr6961566oao.22.1696533436945; Thu, 05
 Oct 2023 12:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231005175230.232764-1-mario.limonciello@amd.com>
 <20231005175230.232764-3-mario.limonciello@amd.com>
 <2023100547-vitamins-detergent-4d18@gregkh>
In-Reply-To: <2023100547-vitamins-detergent-4d18@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 15:17:05 -0400
Message-ID: <CADnq5_MDxwJBvxvy9AohKn+Nu4NPs2kQVS4AwYyscdV41KDoQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac
 power detection on smu 13.0.0"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wolfram Sang <wsa@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 5, 2023 at 3:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 05, 2023 at 12:52:30PM -0500, Mario Limonciello wrote:
> > This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> No explaination as to why this needs to be reverted?  And does this need
> to be backported anywhere?

This patch ultimately never went upstream, but there was some
confusion about whether it did or not.  It can be ignored.

Alex
