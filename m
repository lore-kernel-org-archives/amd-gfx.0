Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C5AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6936502B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6936502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96ED76E3EC;
	Tue, 16 Mar 2021 13:53:19 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029826E2F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 10:30:12 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GA46gb184228; Tue, 16 Mar 2021 06:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8Likwmetuj1HQiuXdzd/gBV8nyUeGupi1mI+PQs6coo=;
 b=Ti02Cky/KiLuk0PVoJ53HMFTuXcVsTMjCaqkT2ZEeUWTajQ0l28lEImxFUqzzXl+615l
 bi9Rc3QdKbq84EFCBpEMdmMGWvrxKQ3EA8w/VTlPBf4tn1kiChIXKHD73E/zKlD4P/Ir
 iX8uxoThnfNv8IHSvJ+6FinkwNByXlnpnp+8rFm2qtZ/vZL7CE2v7BX3imdXsXHV2fjS
 T84RkDrJJI1y4UGDQPaFc8nEmUes0jiP/jYpQpBHBX5XJOhjugIpXKAJO36jakhSV74P
 w8F6hzobyRb+b+Q+MwIDX2/G1NYvftKrMGbrCOZ+b2igtUGWt3noi4MpVgAX8DoALC/3 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37arj1m7uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 06:30:08 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12GA5GPL188923;
 Tue, 16 Mar 2021 06:30:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37arj1m7tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 06:30:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12GAMoBc013084;
 Tue, 16 Mar 2021 10:30:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 378n189e8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 10:30:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 12GATkZG22413574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Mar 2021 10:29:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35B92A4080;
 Tue, 16 Mar 2021 10:30:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E8DBA4083;
 Tue, 16 Mar 2021 10:30:02 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.11.147])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Mar 2021 10:30:02 +0000 (GMT)
Date: Tue, 16 Mar 2021 12:30:00 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <YFCIqLmn3u1be1yo@linux.ibm.com>
References: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
 <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_03:2021-03-16,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160067
X-Mailman-Approved-At: Tue, 16 Mar 2021 13:53:10 +0000
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
Cc: "Liang, Liang \(Leo\)" <Liang.Liang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 16, 2021 at 10:08:10AM +0100, David Hildenbrand wrote:
> On 16.03.21 09:58, Liang, Liang (Leo) wrote:
> > [AMD Public Use]
> > 
> > Hi David,
> > 
> > root@scbu-Chachani:~# cat /proc/mtrr
> > reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
> > reg01: base=0x0ffe00000 ( 4094MB), size=    2MB, count=1: write-protect
> > reg02: base=0x100000000 ( 4096MB), size=   16MB, count=1: write-protect
> 
> ^ there it is
> 
> https://wiki.osdev.org/MTRR
> 
> "Reads allocate cache lines on a cache miss. All writes update main memory.
> 
> Cache lines are not allocated on a write miss. Write hits invalidate the
> cache line and update main memory. "
> 
> AFAIU, writes completely bypass caches and store directly to main mamory. If
> there are cache lines from a previous read, they are invalidated. So I think
> especially slow will be read(addr), write(addr), read(addr), ... which is
> what we have in the kstream benchmark.
> 
> 
> The question is:
> 
> who sets this up without owning the memory?
> Is the memory actually special/slow or is that setting wrong?

I really doubt that 16M at 0x100000000 in a system with 8G RAM would
*physically* differ from the neighbouring memory.

> Buggy firmware/BIOS?
> Buggy device driver?

[    0.000027] MTRR default type: uncachable
[    0.000028] MTRR fixed ranges enabled:
[    0.000030]   00000-9FFFF write-back
[    0.000031]   A0000-BFFFF uncachable
[    0.000032]   C0000-FFFFF write-through
[    0.000033] MTRR variable ranges enabled:
[    0.000034]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000036]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
[    0.000037]   2 base 000100000000 mask FFFFFF000000 write-protect

As we have the range at 0x100000000 write-protected reported that early in
boot I'd say it's BIOS.

The question is how to reliably detect that this is a bogus setting...

[    0.000038]   3 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
[    0.000039]   4 base 0000FF000000 mask FFFFFFF80000 write-protect
[    0.000040]   5 disabled
[    0.000041]   6 disabled
[    0.000042]   7 disabled
[    0.000042] TOM2: 0000000280000000 aka 10240M


-- 
Sincerely yours,
Mike.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
