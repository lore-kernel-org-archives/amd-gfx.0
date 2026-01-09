Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A78D232D6
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9C410E259;
	Sat, 10 Jan 2026 17:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=worksmobile.com header.i=@worksmobile.com header.b="StxEzt21";
	dkim=pass (1024-bit key; unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="fqt/80G7";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Fri, 09 Jan 2026 16:43:35 UTC
Received: from cvsmtppost104.wmail.worksmobile.com
 (cvsmtppost104.wmail.worksmobile.com [125.209.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765FC10E90E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
 s=s20171120; t=1767976411;
 bh=0va2tgAAsMwO4yDPzunWkCxxJ/P2wFfeepBcrAs+LcM=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=StxEzt21NiuSpb3kwIxE96edExwoJHCsbbyObHIwDyZacLwZCDVNbNG5n/B354Ql3
 lA+r+ibwB5XwmSfj/QEZVbZu70ArmYb2AJNYEHHq/vkOU4pPa+3NI6SgZTvlh0VCqx
 ktZXUX7eHivCxt3WTRSTW/o/1ZNhlKavy0b94/K+4z8nnMzyDoLD1Y7SvaGNYnXlE3
 0cVNJvvW0nacxyV3mZywHwe2L5slyUagflSRQpOt/hLQyXdgt9jPrkPKBiRgEpT2IR
 ciZHvLrQfGXCkJxCsfwhuHCFSyqjiUXZGW+3EfRLtESJIS28l/7Yo4ibg4Veo0mlvD
 L6bHiA3NgXSFg==
X-Originating-IP: 163.152.163.130
Received: from cvsendbo002.wmail ([10.113.20.164])
 by cvsmtppost104.wmail.worksmobile.com with ESMTP id SY0qEC8HRDKlPTVXB2Q5xw
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jan 2026 16:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
 s=naverworks; t=1767976411;
 bh=0va2tgAAsMwO4yDPzunWkCxxJ/P2wFfeepBcrAs+LcM=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=fqt/80G779cWWErBKXsSXKs5LBdGR3qH+5D95H+E9oLWC+PhCEK1F1yII+bDWZwfN
 6xoUbThBaNOT7cm6JUL4i+UiqM9fIlFayCGp28f8z3yeJGcZifHxWaqyheUAY/yN5p
 gq0XDIN4yqejOQk+0QrMDYacYLRHMLkjcldWWoGc=
X-Session-ID: KJwAwkv8QlW+PGVIgDKW+A
X-Originating-IP: 163.152.163.130
X-Works-Send-Opt: EenqjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: VmndaxbrFqJZ+HmwKxgd+6E=
Received: from s2lab05.. ([163.152.163.130])
 by jvnsmtp402.gwmail.worksmobile.com with ESMTP id KJwAwkv8QlW+PGVIgDKW+A
 for <multiple recipients>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 09 Jan 2026 16:33:31 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com,
 Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in smu7_patch_dependency_tables_with_leakage()?
Date: Sat, 10 Jan 2026 01:33:30 +0900
Message-Id: <20260109163330.3019080-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Jan 2026 17:58:19 +0000
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

Hi,

I noticed that in drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c,
the function smu7_patch_dependency_tables_with_leakage() checks the
return values of 12 patch functions:

  - smu7_patch_vddc()
  - smu7_patch_vddci()
  - smu7_patch_vce_vddc()
  - smu7_patch_uvd_vddc()
  - smu7_patch_vddc_shed_limit()
  - smu7_patch_samu_vddc()
  - smu7_patch_acp_vddc()
  - smu7_patch_limits_vddc() (called twice)
  - smu7_patch_cac_vddc()

However, all of these functions always return 0. They call
smu7_patch_ppt_v0_with_vdd_leakage() which is a void function,
and there are no error paths in any of the patch functions.

Is this intentional defensive coding for potential future changes,
or could this be cleaned up?

Thanks,
Ingyu Jang
