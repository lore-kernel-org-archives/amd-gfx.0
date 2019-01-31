From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Fwd: Bug#921004: downgrade to firmware-amd-graphics_20180825-1_all.deb
Date: Thu, 31 Jan 2019 17:02:34 +0100
Message-ID: <4808c53d-927e-71a7-62fb-af46f9e87efc@daenzer.net>
References: <1c2b5af4-ea57-0b07-723d-cb4ccb760219@free.fr>
 <2e69cb23-06ee-5bcd-4feb-0eb88c0f4143@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C37E1A9BB389FD91016C9032"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2e69cb23-06ee-5bcd-4feb-0eb88c0f4143-GANU6spQydw@public.gmane.org>
Content-Language: en-CA
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------C37E1A9BB389FD91016C9032
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Bad news I'm afraid, looks like the latest firmware (based on
linux-firmware commit bc656509a3cfb60fcdfc905d7e23c18873e4e7b9 from
2019-01-14) broke some RX 580 cards.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------C37E1A9BB389FD91016C9032
Content-Type: message/rfc822;
 name="Bug#921004: amdgpu: The CS has been cancelled because the context is
 lost_.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="Bug#921004: amdgpu: The CS has been cancelled because the co";
 filename*1="ntext is lost_.eml"

Return-Path: <bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
Delivered-To: michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org
Received: from localhost ([10.192.2.31])
	by localhost with LMTP id 6BmPLTr8UlyOPgAA0J78UA
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 14:46:34 +0100
Received: from mx2.mailbox.org ([80.241.60.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	by localhost with LMTP id OM9QKjr8Ulw22gAA0J78UA
	; Thu, 31 Jan 2019 14:46:34 +0100
X-Virus-Scanned: amavisd-new at heinlein-support.de
X-policyd-weight: using cached result; rate: -2.5
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
	by mx2.mailbox.org (Postfix) with ESMTP id DDACCA1C02
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 14:45:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by netline-mail3.netline.ch (Postfix) with ESMTP id 62FD52A6056
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 14:45:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
	by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nQsH45hgHCit for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Thu, 31 Jan 2019 14:45:21 +0100 (CET)
X-SMTP-Auth: no
Received: from bendel.debian.org (bendel.debian.org [82.195.75.100])
	by netline-mail3.netline.ch (Postfix) with ESMTPS id 18F602A6055
	for <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Thu, 31 Jan 2019 14:45:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by bendel.debian.org (Postfix) with QMQP
	id DD3002051A; Thu, 31 Jan 2019 13:45:20 +0000 (UTC)
X-Mailbox-Line: From debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org  Thu Jan 31 13:45:20 2019
Old-Return-Path: <debbugs-YC79CPGmv2CR0YJzq4vVu2D2FQJk+8+b@public.gmane.org>
X-Original-To: lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org
Delivered-To: lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by bendel.debian.org (Postfix) with ESMTP id 9675E2048B
	for <lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org>; Thu, 31 Jan 2019 13:45:13 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank en-lt
X-Amavis-Spam-Status: No, score=-4.297 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
	RCVD_IN_DNSWL_MED=-2.3] autolearn=no autolearn_force=no
Received: from bendel.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id ReykJB85eX1D for <lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org>;
	Thu, 31 Jan 2019 13:45:10 +0000 (UTC)
Received: from buxtehude.debian.org (buxtehude.debian.org [IPv6:2607:f8f0:614:1::1274:39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "buxtehude.debian.org", Issuer "Debian SMTP CA" (not verified))
	by bendel.debian.org (Postfix) with ESMTPS id 2652E2048A;
	Thu, 31 Jan 2019 13:45:10 +0000 (UTC)
Received: from debbugs by buxtehude.debian.org with local (Exim 4.89)
	(envelope-from <debbugs-YC79CPGmv2CR0YJzq4vVu2D2FQJk+8+b@public.gmane.org>)
	id 1gpCeQ-0000eC-Ot; Thu, 31 Jan 2019 13:45:06 +0000
X-Loop: owner-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Subject: Bug#921004: amdgpu: The CS has been cancelled because the context is lost.
Reply-To: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>, 921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Resent-From: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>
Resent-To: debian-bugs-dist-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Resent-CC: Debian X Strike Force <debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
X-Loop: owner-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Resent-Date: Thu, 31 Jan 2019 13:45:02 +0000
Resent-Message-ID: <handler.921004.B.1548942047751-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>
X-Debian-PR-Message: report 921004
X-Debian-PR-Package: xserver-xorg-video-amdgpu
X-Debian-PR-Keywords: 
X-Debian-PR-Source: xserver-xorg-video-amdgpu
Received: via spool by submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org id=B.1548942047751
          (code B); Thu, 31 Jan 2019 13:45:02 +0000
Received: (at submit) by bugs.debian.org; 31 Jan 2019 13:40:47 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
	by buxtehude.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <jd.frattini-GANU6spQydw@public.gmane.org>)
	id 1gpCaF-0000B9-9T
	for submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org; Thu, 31 Jan 2019 13:40:47 +0000
X-Originating-IP: 37.168.209.195
Received: from [192.168.1.16] (unknown [37.168.209.195])
	(Authenticated sender: jd-UQVQ0zbOCkFWj0EZb7rXcA@public.gmane.org)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EE3532000A
	for <submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>; Thu, 31 Jan 2019 13:40:41 +0000 (UTC)
To: submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
From: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>
Message-ID: <1c2b5af4-ea57-0b07-723d-cb4ccb760219-GANU6spQydw@public.gmane.org>
Date: Thu, 31 Jan 2019 14:40:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Delivered-To: submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
X-Mailing-List: <debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org> archive/latest/133170
X-Loop: debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: <debian-x.lists.debian.org>
List-URL: <https://lists.debian.org/debian-x/>
List-Post: <mailto:debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
List-Help: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=help>
List-Subscribe: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Archive: https://lists.debian.org/msgid-search/1c2b5af4-ea57-0b07-723d-cb4ccb760219-GANU6spQydw@public.gmane.org
Authentication-Results: mx2.mailbox.org
X-Rspamd-Queue-Id: DDACCA1C02
X-Spamd-Result: default: False [-8.71 / 150.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 GENERIC_REPUTATION(0.00)[-0.96773150020218];
	 HAS_XOIP(0.00)[];
	 MX_INVALID(0.50)[cached];
	 FREEMAIL_FROM(0.00)[free.fr];
	 REPLYTO_DN_EQ_FROM_DN(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_TWELVE(0.00)[13];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SENDER_HELO_REPUTATION(0.00)[-0.97742503407542];
	 HAS_REPLYTO(0.00)[jd.frattini-GANU6spQydw@public.gmane.org];
	 IP_REPUTATION(0.00)[asn: 24940(-0.81), country: DE(-0.65), ipnet: 148.251.0.0/16(-0.92), ip: 148.251.143.178(-0.97)];
	 NEURAL_HAM_SHORT(-0.98)[-0.985,0];
	 MAILLIST(-0.10)[generic];
	 FORGED_SENDER(0.00)[jd.frattini-GANU6spQydw@public.gmane.org,bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FORGED_RECIPIENTS_MAILLIST(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
	 FROM_NEQ_ENVFROM(0.00)[jd.frattini-GANU6spQydw@public.gmane.org,bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FORGED_RECIPIENTS(0.00)[submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org,michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org];
	 ARC_NA(0.00)[];
	 NEURAL_HAM_MED(-0.30)[-1.000,0];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000,0];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_REPLYTO(0.00)[free.fr];
	 DMARC_NA(0.00)[free.fr];
	 HAS_LIST_UNSUB(-0.01)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 AUTH_NA(1.00)[];
	 BAYES_FI_SPAM(0.04)[53.76%];
	 IP_SCORE(-2.85)[ip: (-6.87), ipnet: 148.251.0.0/16(-4.77), asn: 24940(-2.28), country: DE(-0.35)];
	 R_SPF_NA(0.00)[];
	 SENDER_MAIL_REPUTATION(0.00)[-0.98636363636364];
	 FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: scan05.antispam.heinlein-support.de

Package: xserver-xorg-video-amdgpu

Version: 18.1.0-1

Severity: critical

Debian: Stretch amd64

Regression: Yes

Graphic card: AMD Radeon Rx 580


Good Morning,

since the latest update of xserver-xorg-video-amdgpu and 
firmware-amd-graphics, most GL applications do not display anything and 
display this error message in the console:

amdgpu: The CS has been cancelled because the context is lost.

This makes Debian unusable for developing and running GL programs.

-- 
Jean-Dominique Frattini


--------------C37E1A9BB389FD91016C9032
Content-Type: message/rfc822;
 name="Bug#921004: downgrade to firmware-amd-graphics_20180825-1_all_deb.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="Bug#921004: downgrade to firmware-amd-graphics_20180825-1_al";
 filename*1="l_deb.eml"

Return-Path: <bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
Delivered-To: michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org
Received: from director-04.heinlein-hosting.de ([2001:67c:2050:104:0:2:25:2])
	by localhost with LMTP id MDwLH+QFU1wu/wAA0J78UA
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 15:27:48 +0100
Received: from mx2.mailbox.org ([2001:67c:2050:104:0:2:25:2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	by director-04.heinlein-hosting.de with LMTP id UOiWIeQFU1xQQAAAgupzMw
	; Thu, 31 Jan 2019 15:27:48 +0100
X-Virus-Scanned: amavisd-new at heinlein-support.de
X-policyd-weight: NOT_IN_SBL_XBL_SPAMHAUS=-1.5 CL_IP_EQ_HELO_IP=-2 (check from: .debian. - helo: .netline-mail3.netline. - helo-domain: .netline.)  FROM/MX_MATCHES_NOT_HELO(DOMAIN)=1; rate: -2.5
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
	by mx2.mailbox.org (Postfix) with ESMTP id A992BA1BCF
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 15:27:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by netline-mail3.netline.ch (Postfix) with ESMTP id 277B52A6056
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Thu, 31 Jan 2019 15:21:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
	by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yHfyXHB9yrkh for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Thu, 31 Jan 2019 15:21:19 +0100 (CET)
X-SMTP-Auth: no
Received: from bendel.debian.org (bendel.debian.org [82.195.75.100])
	by netline-mail3.netline.ch (Postfix) with ESMTPS id AB0702A6055
	for <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Thu, 31 Jan 2019 15:21:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by bendel.debian.org (Postfix) with QMQP
	id 47F352052F; Thu, 31 Jan 2019 14:21:19 +0000 (UTC)
X-Mailbox-Line: From debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org  Thu Jan 31 14:21:19 2019
Old-Return-Path: <debbugs-YC79CPGmv2CR0YJzq4vVu2D2FQJk+8+b@public.gmane.org>
X-Original-To: lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org
Delivered-To: lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by bendel.debian.org (Postfix) with ESMTP id 65D2520529
	for <lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org>; Thu, 31 Jan 2019 14:21:12 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank en-lt
X-Amavis-Spam-Status: No, score=-4.297 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
	RCVD_IN_DNSWL_MED=-2.3] autolearn=no autolearn_force=no
Received: from bendel.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id GQWnNQYosuJW for <lists-debian-x-vau6KT9ihO/yUObV3Cmqeti2O/JbrIOy@public.gmane.org>;
	Thu, 31 Jan 2019 14:21:08 +0000 (UTC)
Received: from buxtehude.debian.org (buxtehude.debian.org [IPv6:2607:f8f0:614:1::1274:39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "buxtehude.debian.org", Issuer "Debian SMTP CA" (not verified))
	by bendel.debian.org (Postfix) with ESMTPS id 1C2F92052A;
	Thu, 31 Jan 2019 14:21:08 +0000 (UTC)
Received: from debbugs by buxtehude.debian.org with local (Exim 4.89)
	(envelope-from <debbugs-YC79CPGmv2CR0YJzq4vVu2D2FQJk+8+b@public.gmane.org>)
	id 1gpDDE-0004Bn-Vt; Thu, 31 Jan 2019 14:21:04 +0000
X-Loop: owner-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Subject: Bug#921004: downgrade to firmware-amd-graphics_20180825-1_all.deb
Reply-To: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>, 921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Resent-From: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>
Resent-To: debian-bugs-dist-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Resent-CC: Debian X Strike Force <debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
X-Loop: owner-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Resent-Date: Thu, 31 Jan 2019 14:21:03 +0000
Resent-Message-ID: <handler.921004.B921004.154894434415409-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>
X-Debian-PR-Message: followup 921004
X-Debian-PR-Package: xserver-xorg-video-amdgpu
X-Debian-PR-Keywords: 
References: <1c2b5af4-ea57-0b07-723d-cb4ccb760219-GANU6spQydw@public.gmane.org>
X-Debian-PR-Source: xserver-xorg-video-amdgpu
Received: via spool by 921004-submit-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org id=B921004.154894434415409
          (code B ref 921004); Thu, 31 Jan 2019 14:21:03 +0000
Received: (at 921004) by bugs.debian.org; 31 Jan 2019 14:19:04 +0000
Received: from mslow2.mail.gandi.net ([217.70.178.242])
	by buxtehude.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <jd.frattini-GANU6spQydw@public.gmane.org>)
	id 1gpDBI-00040I-K0
	for 921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org; Thu, 31 Jan 2019 14:19:04 +0000
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow2.mail.gandi.net (Postfix) with ESMTP id ABD463A94C4
	for <921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>; Thu, 31 Jan 2019 15:08:08 +0100 (CET)
X-Originating-IP: 37.168.209.195
Received: from [192.168.1.16] (unknown [37.168.209.195])
	(Authenticated sender: jd-UQVQ0zbOCkFWj0EZb7rXcA@public.gmane.org)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E9EF91BF20E
	for <921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>; Thu, 31 Jan 2019 14:07:45 +0000 (UTC)
To: 921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
From: Jean-Dominique Frattini <jd.frattini-GANU6spQydw@public.gmane.org>
Message-ID: <2e69cb23-06ee-5bcd-4feb-0eb88c0f4143-GANU6spQydw@public.gmane.org>
Date: Thu, 31 Jan 2019 15:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
X-Mailing-List: <debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org> archive/latest/133171
X-Loop: debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: <debian-x.lists.debian.org>
List-URL: <https://lists.debian.org/debian-x/>
List-Post: <mailto:debian-x-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
List-Help: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=help>
List-Subscribe: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-x-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Archive: https://lists.debian.org/msgid-search/2e69cb23-06ee-5bcd-4feb-0eb88c0f4143-GANU6spQydw@public.gmane.org
Authentication-Results: mx2.mailbox.org
X-Rspamd-Queue-Id: A992BA1BCF
X-Spamd-Result: default: False [-5.76 / 150.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 GENERIC_REPUTATION(0.00)[-0.96770799611525];
	 HAS_XOIP(0.00)[];
	 MX_INVALID(0.50)[cached];
	 FREEMAIL_FROM(0.00)[free.fr];
	 REPLYTO_DN_EQ_FROM_DN(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_TWELVE(0.00)[14];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SENDER_HELO_REPUTATION(0.00)[-0.97741220593249];
	 HAS_REPLYTO(0.00)[jd.frattini-GANU6spQydw@public.gmane.org];
	 IP_REPUTATION(0.00)[asn: 24940(-0.81), country: DE(-0.65), ipnet: 148.251.0.0/16(-0.92), ip: 148.251.143.178(-0.97)];
	 NEURAL_HAM_SHORT(-0.99)[-0.993,0];
	 MAILLIST(-0.10)[generic];
	 FORGED_SENDER(0.00)[jd.frattini-GANU6spQydw@public.gmane.org,bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FORGED_RECIPIENTS_MAILLIST(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
	 FROM_NEQ_ENVFROM(0.00)[jd.frattini-GANU6spQydw@public.gmane.org,bounce-debian-x=michel=daenzer.net-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FORGED_RECIPIENTS(0.00)[921004-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org,michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org];
	 ARC_NA(0.00)[];
	 NEURAL_HAM_MED(-0.30)[-1.000,0];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000,0];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_REPLYTO(0.00)[free.fr];
	 DMARC_NA(0.00)[free.fr];
	 HAS_LIST_UNSUB(-0.01)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 AUTH_NA(1.00)[];
	 BAYES_FI_SPAM(0.00)[37.30%];
	 IP_SCORE(-2.85)[ip: (-6.87), ipnet: 148.251.0.0/16(-4.77), asn: 24940(-2.28), country: DE(-0.35)];
	 R_SPF_NA(0.00)[];
	 SENDER_MAIL_REPUTATION(0.00)[-0.98648648648649];
	 FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: scan01.antispam.heinlein-support.de

Good Morning,

downgrading to firmware-amd-graphics_20180825-1_all.deb seems to fix the 
issue.

Please let me know if I should report this bug directly to 
firmware-amd-graphics.


--------------C37E1A9BB389FD91016C9032
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------C37E1A9BB389FD91016C9032--
