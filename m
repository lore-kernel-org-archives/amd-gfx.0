Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B35ACA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B642084C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B642084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF836EBAD;
	Fri, 25 Oct 2019 21:35:01 +0000 (UTC)
X-Greylist: delayed 2577 seconds by postgrey-1.36 at gabe;
 Fri, 25 Oct 2019 21:32:40 UTC
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997446EBA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 21:32:40 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9PKgEZh070156; Fri, 25 Oct 2019 16:49:41 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vusu9hsan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2019 16:49:40 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9PKj9xM027809;
 Fri, 25 Oct 2019 20:49:40 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 2vqt48bqmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2019 20:49:40 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9PKndh715926120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2019 20:49:39 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FD8828058;
 Fri, 25 Oct 2019 20:49:39 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2178D28059;
 Fri, 25 Oct 2019 20:49:39 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Oct 2019 20:49:39 +0000 (GMT)
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
To: Greg KH <gregkh@linuxfoundation.org>
References: <1570736672-10644-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
 <20191011042734.GA939089@kroah.com>
From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
Message-ID: <0064d9ea-4749-0129-05b1-99697fb58730@linux.vnet.ibm.com>
Date: Fri, 25 Oct 2019 15:49:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191011042734.GA939089@kroah.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-25_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=691 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250190
X-Mailman-Approved-At: Fri, 25 Oct 2019 21:35:00 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0540271174=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025204938.17GTn1vvs0NafS6Ci-K6xXT_80562I3n4Cj73y6s1nA@z>

This is a multi-part message in MIME format.
--===============0540271174==
Content-Type: multipart/alternative;
 boundary="------------761D57267238DBBF77BF895E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------761D57267238DBBF77BF895E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/10/19 11:27 PM, Greg KH wrote:

> On Thu, Oct 10, 2019 at 02:44:29PM -0500, KyleMahlkuch wrote:
>> During kexec some adapters hit an EEH since they are not properly
>> shut down in the radeon_pci_shutdown() function. Adding
>> radeon_suspend_kms() fixes this issue.
>> Enabled only on PPC because this patch causes issues on some other
>> boards.
>>
>> Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
> Real email address please, with a '@' sign.
>
> And your "From:" line did not match up with this :(

Greg, thanks for your help, I've resubmitted my patch.

>> ---
>>   drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

--------------761D57267238DBBF77BF895E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">
      <pre>On 10/10/19 11:27 PM, Greg KH wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20191011042734.GA939089@kroah.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Oct 10, 2019 at 02:44:29PM -0500, KyleMahlkuch wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.
Enabled only on PPC because this patch causes issues on some other
boards.

Signed-off-by: Kyle Mahlkuch &lt;Kyle.Mahlkuch at ibm.com&gt;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Real email address please, with a '@' sign.

And your "From:" line did not match up with this :(
</pre>
    </blockquote>
    <pre>Greg, thanks for your help, I've resubmitted my patch. 
</pre>
    <blockquote type="cite" cite="mid:20191011042734.GA939089@kroah.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
&lt;formletter&gt;

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    <a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html">https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html</a>
for how to do this properly.

&lt;/formletter&gt;
</pre>
    </blockquote>
  </body>
</html>

--------------761D57267238DBBF77BF895E--


--===============0540271174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0540271174==--

