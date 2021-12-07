Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE77DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 22:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0459D6E877;
	Tue,  7 Dec 2021 22:07:38 +0000 (UTC)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0A96E877
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 22:07:36 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp3-g21.free.fr (Postfix) with ESMTP id 6A5E413F86E;
 Tue,  7 Dec 2021 23:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1638914853;
 bh=kAQfm+rqWgZPyNz3eil+TO1ETWxGh3ScWr76Jm0zrak=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=uX2lraxAFiDDkxBOQQ08fmIpn36PPCuK0jD5HyQ5M12V78SLZJ/v7gbOj4sl4SZJ4
 p9JWv/9D+JC6fX6hVU8xWl+1Ed3XQiuiLC31QWJsH3tLN9MAiRjwztKHieYGixLQwP
 D2R9vb6AgNbM7U1QMDah9VkE5TtZi/NYy+4wEe7G7C+9q2rCaALKIbFoXtNn+gZ4+G
 2yRF6QDK2jacc4BSyEMXPtkSxyRXgTFqgXjQ9ZImq3Ek4ioasPPtSrkQTrpwIEn28Y
 3E+i8r0fbkmzh6jF2WHuu9R91g/5jRuQxPX2MHZimEqhGRhyKzPee4AGh15sECY9iG
 V/ppKA3dek6zg==
Date: Tue, 7 Dec 2021 23:07:33 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <662096311.37428400.1638914853388.JavaMail.root@zimbra39-e7>
In-Reply-To: <CADnq5_MQnX6dRJ4-YHjWaSS5PYb1f6BQ4FXNkw9wzDmwQarkrA@mail.gmail.com>
Subject: gpu block diagram
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the details Alex!

Here is an attempt to formalize the decomposition of a
(mostly Renoir) APU, using plantuml.  That's highly preliminary,
focusing on blocks/sub-blocks/firmware, based on my current
partial (and surely incorrect at places) understanding.
I focused on getting contents quickly, so the formalism itself
is shaky.

Can you spot any error ?  Fill those holes (usually marked with
"?") ?  What additional blocks would make sense (caches at least,
I guess) ?  What additional information would help understand how
they work together (control/data flows, busses...) ?

Indentation is shaky too, better format it to read (e.g. by
pasting in http://www.plantuml.com/plantuml/uml/)

------ >8 -------
@startuml
package "APU" {
 package CPU {
 }
 package GPU {
  package common? [[{"GPU Family"?}]] {
  }
  package GFX [[{Graphics and Compute Engine}]] {
   package CP [[{Command Processor}]] {
    package PFP [[{MicroEngine Compute}]] {
      package "pfp fw" #cccccc {
      }
    }
    package ME [[{MicroEngine ?}]] {
      package "me fw" #cccccc {
      }
    }
    package CE [[{?}]] {
      package "ce fw" #cccccc {
      }
    }
    package MEC [[{MicroEngine Compute}]] {
      package "mec fw" #cccccc {
      }
      package "mec2 fw?" #cccccc {
      }
    }
   }
   package RLC [[{RunList Controller (pm)}]] {
      package "rlc fw" #cccccc {
      }
   }
  }

  package '"management"'<<Cloud>>  {
  package MES [[{Micro-Engine Scheduler}]] {
  }
  package SMU [[{System Mamagement Unit}]] {
  }
  package PSP [[{Platform Security Processor}]] {
    package "asd fw" #cccccc {
    }
    package "ta fw" #cccccc {
    }
  }

  package IH [[{Interrupt Handler}]] {
  }
  package GMC [[{Graphics Memory Controller}]] {
  }
  package SDMA [[{System DMA}]] {
    package "sdma fw" #cccccc {
    }
  }
  }

  package DM [[{Display Manager, link to...}]] {
   package "DMUB? DMU?" [[{Display Micro-Controller Unit}]] {
    package "dmcub fw" #cccccc {
    }
   }
   package ... {
   }
  }

  package multimedia <<Cloud>> {
   package .... {
   }
   package VCN {
    package "vcn fw" #cccccc {
    }
   }
   package JPEG {
   }
  }
 }
}
@enduml
------ >8 -------
