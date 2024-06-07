Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F7C27C6E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 13:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8F210EC57;
	Fri,  7 Jun 2024 13:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EWBYApEd";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C6910E284
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 01:57:39 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6ae0adfba9cso8681916d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717725458; x=1718330258; darn=lists.freedesktop.org;
 h=mime-version:to:from:importance:subject:date:savedfromemail
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ApNTmtHveiZjchKgdyua6C+qMcpNaEeGcBk9BNztyok=;
 b=EWBYApEdqIuG5BNTt8WmCvZ0vXYFWPAOguehF+l4WR+Mo2hRP70Pndx/Ac/UwR0HeJ
 waOzu2R6qGOHBL2RgqtC5z5EAbX65be8+jj7YsgucCJm5jUtuzySh6E6EpjEhnUWf/s2
 qC3e+34e7j8a2egyLJQfNgRUUWmEWbwGhgt0fJTPfGF3nYXbTiQSTsiGynK5rio4mnkJ
 nJpHA+BEg4PWdlcVfGum67VFF3V1xBhbQTXbJKkPtFHIO+37Sexa4OjLjS1zf42jiYxs
 /xb+hDZRhnp4rb6tWNdEFd2m7H2NBIK+wFCMGk29mrNAaHhA6MGsqrkGYGFltNPl3qZw
 FHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717725458; x=1718330258;
 h=mime-version:to:from:importance:subject:date:savedfromemail
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApNTmtHveiZjchKgdyua6C+qMcpNaEeGcBk9BNztyok=;
 b=K6GUXhZQO+oXGZW/k+Qm0KLnEduycAKOSbeEjSbg4NEC6F2D+haXPV3MlvR/xVLzJK
 Qa1ac1fjHKjnrc4LlCdjc1zmzfz4y4/2hAot1t2QXGylEdSXeIKzRn61OzXL7riEE+UU
 t+7f4CdcDhaqd7W52trdTy0vVLZllKP9CPs7E5yF8JRLEKthW1wPhFi0jg2NSVKCw6j6
 daUnldRf+l/QnhGlhxKLhbcVFEvTrER+Rwi92H+7fB48dUinSJzzDFWfwd+lYHcbqJ+V
 Jhi+BtAZUeI9hlJ6tNK+Eip+SP7EzS2R5dX/GWWwkO1d2DmoS9vy65Wqf6KaZwk7P++D
 78uw==
X-Gm-Message-State: AOJu0YxDTE9xjrvnXz/Z47ALi+Bfus33dOAq1lv9F5Y27hs7/T/SlTZq
 /txLSnKhnzv3BOPSzR37IRMIKqvVcq8tch3ZMgHUroPa881hvhlqnVYbLQ==
X-Google-Smtp-Source: AGHT+IF6q4P8J5B7Ye7Y8JI2nSkvufwE7pebNXXia3Qesj35ppCzYm/p6mBCvfmrfhPo/1COr3vjCw==
X-Received: by 2002:a05:6214:3f83:b0:6a9:8226:266c with SMTP id
 6a1803df08f44-6b059b73b95mr15353286d6.15.1717725457386; 
 Thu, 06 Jun 2024 18:57:37 -0700 (PDT)
Received: from ?IPv6:2607:fb91:2137:4ff3:3815:90dd:2e1d:2679?
 ([2607:fb91:2137:4ff3:3815:90dd:2e1d:2679])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b04f7406a8sm11828786d6.65.2024.06.06.18.57.36
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 18:57:36 -0700 (PDT)
Message-ID: <66626910.050a0220.24aff9.5431@mx.google.com>
SavedFromEmail: svicenty@gmail.com
Date: Thu, 06 Jun 2024 21:57:26 -0400
Subject: Re: Page fault storms and IH ring overflow
Importance: normal
From: svicenty <svicenty@gmail.com>
To: amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.samsung.android.email_3050885707480940"
X-Mailman-Approved-At: Fri, 07 Jun 2024 13:46:34 +0000
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

----_com.samsung.android.email_3050885707480940
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

QW1kIHVwZGF0ZcKgU2VudCBmcm9tIG15IFQtTW9iaWxlIDVHIERldmljZQ==

----_com.samsung.android.email_3050885707480940
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPjxkaXYgZGlyPSJh
dXRvIj5BbWQgdXBkYXRlJm5ic3A7PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2
IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBpZD0i
Y29tcG9zZXJfc2lnbmF0dXJlIiBkaXI9ImF1dG8iPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxMnB4
O2NvbG9yOiM1NzU3NTciIGRpcj0iYXV0byI+U2VudCBmcm9tIG15IFQtTW9iaWxlIDVHIERldmlj
ZTwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PC9ib2R5PjwvaHRtbD4=

----_com.samsung.android.email_3050885707480940--

