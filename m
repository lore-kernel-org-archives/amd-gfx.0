Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132FC6152B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 132FC6152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD086E96D;
	Thu, 18 Nov 2021 15:55:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EDA6E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 15:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ7BLXdx4896z73q22nAuW2fWiCMT4LpS17t9u0gCR+NGjEYNSoHbzB0G0WaTba+FgK+9fiFCbb54tNG/FLqfgzLDNIRIaVryTL6pYNg07DmCubx6I66oNv7y1Aprdk3xOlmOzDCX1+Qb0XborTKbB9TvFF1eWqBd8I6DyQGReiu2Fz9WKVUn3QP7QdcbqLFrHp9M/Vjr5/nmiJ7BC0dE48e14rV350ZP1gBn5X0IZRRuMwEbvs+z1tN4NsEAfjOyzvgSXZlNvW35Z9GE3gsocM7e4sTMXVp64biyi6arXnoi0sDhRNFxY51yB5Va8gbAGCpT5sGEy0klohwhL56qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCbtujcdFYHbPUk1ukcTG5y0bppDQFaN2SWFq9vM8RA=;
 b=QZPQn1MBbVeEFd+U99r6yR5mzs1Zkt9LcbCNsP+QVRH9vMUL8oc8/TTdlE+BeGv+T2TG+0x5dam0yClhwn7vPDtDNWJfhRacnQ7dRYnY1rQwyC6PEPEbYWtFc8paFAwwquvNCQWvO75ObP5J3tA9ytcBXhaaLR+Ln3AyxLvEsSQ2yTeOEXpCZ9V+F6hzk8GWEXEFIk/lhpj4fFG2RLa63qqPhBFqpp4OogAA2VHBwo71lGpggQ+v+IP7QEvhGIhkbbu87CbuIdlhNzNZYA3FCuZZ6W2cSA2nJ/c5SkFh3yceXFHWouzeSkzTSMfVPJuMHt8oNWoYGZ/a8mvzZx8WvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCbtujcdFYHbPUk1ukcTG5y0bppDQFaN2SWFq9vM8RA=;
 b=PHK0AA7+aYSRoKVBik1Rl8VyCgfm1rn7OL//0bt2LWlt94D5dIeTWEzzO2cwdLkduQ8dxACVpI3IH+b1xCkTZDk8UNCv8hZBhWI+84hhOj0EmZlU1o2hBOUGRwHkh5y4W+QgHDLXxHzwS6uBXEuF2yAqr+kxwK6Q5MYzKiQTJDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Thu, 18 Nov
 2021 15:55:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 15:55:28 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: handle VMA remove race
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-2-Philip.Yang@amd.com>
 <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
 <5162a906-2f1d-bf1d-8313-62105e8f618e@amd.com>
 <f751ec08-d21b-819a-528d-65511095602d@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <6e00cc95-a6bb-0abd-36b9-96b4248d6aac@amd.com>
Date: Thu, 18 Nov 2021 10:55:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f751ec08-d21b-819a-528d-65511095602d@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:2d::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 15:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042ae5d0-1292-42e5-98c0-08d9aaabd78f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5344E150885386C72E5F5FBBE69B9@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKr10RkHpgz8aJ0/reWlBzc7jf5bgCrTEfEYQj5/uxfdPT+qMlmTJkaMB0/eXLifcfN73SUL32eS3zzDGAi7vzUfd6tfgm97sEzBqXVoDcnNedplcBEof1OVAXuiqOXXsnGlaYn8ENSeUQ44UMWwmRBMrxk35chvGU7xvJeiH16cRG22gmiDxN3cT5Ptoa6t08VRYjSrO4Ouf5y9lMhObsDSgvM8xYpp3dapOYFDCMGpKlObWl0+kvomKvMS7WhP2BepY1/QaTuJcs8gBwifa3bu/65e2rbiTgpzoDjbJvvruK0RRMBixiDRbzWDanQ5kBdPkIcEXJbP2Ylw7daq9wffER6oZ2lC7SWQiM5Vw4Jb93gVSuWY+nTUZ+ESKiKwrtooyblLSZwAq5qG3qOoYCk33p9x3/4DLYGOjzhTrtgzOBRf6jX62X04umnWuMhGKfM30WIT4R9tkQX2yeUKEtxF+0mOzPW9kgQ8Ra/P+wAq2EajbjzCBBFT9A7FinkuGivPE8b/c8n8VziwPjEk1mnB4KsNtyrnLqsxlgLqw4qETzQcF+kD0FBdVFHEnbY1XTQ80dfMIf94ioydOTYyY3ecRzGxWQDG4mtesPPajJK924P3KegaAqauiy8SPz4lxQ5mo37xfGdLd/g2GiQ2LQ1A0q2aclsVHSZ48bA88wmf6gqL3nN1Zn5WU0WLnUvHQtHupIn9FNXYvMljSATX7yTsuYY2K4Xkh/PyEHmkeKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(186003)(956004)(5660300002)(508600001)(83380400001)(53546011)(26005)(8676002)(31686004)(110136005)(2906002)(16576012)(66946007)(31696002)(4001150100001)(66556008)(8936002)(2616005)(66476007)(6486002)(38100700002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBuOEdJQ21DUXVYbE54cnJYclNtV2pjSmVrT1YvcXlLMWJjc0FVNS9ORHFY?=
 =?utf-8?B?RVVyb1hkS2JJVVFsZk1Bc1ZIN21aRWJZQkVZWXV0dCtQY1YyeUFieTRUckps?=
 =?utf-8?B?R2JLV09xc2NUQXRjTEpYcnA5SnpnUVJYdmp1emNVR1pudmJWNmdKWjU0b0ZU?=
 =?utf-8?B?ZE9iS2dSUzhmT3owc0grUDFJZHZkU3VLcHlWQzdkTENianJQcnVxM09xRUJK?=
 =?utf-8?B?Q1JlSFRpUXpBR2N0TmRLRWhmYm50L1FUZjZ2M0l1TFJUUGEveUMyMEFTcHRj?=
 =?utf-8?B?NzBuTXRWcW5KVC93azk0ZVpPRXNBVmRsRS8xWE5NaVBoUWpYcFg2NHorbzU0?=
 =?utf-8?B?Mzk2UmFIeXFsNHFOeHcyanJ6cDNON20wSHRSOEZvMHN0OGRETlFoTEJicTBM?=
 =?utf-8?B?TUUybjFmSHJWTVptU0pPSUc2cmpxdUVnR01uSFlHcnQ4QVMveEdsZXg2b2Ix?=
 =?utf-8?B?WGJxYTlNVUpDNjUvcGhaVjF1Nm1YWnE3Yng5WGcrT1czb2VoVjJ2c0M5QWNT?=
 =?utf-8?B?Z2FaOXUyUEhGT3RpK3YvWkNZU1pzY1QyRTdHbTc0UnkyOEJRZW9WU3NFU3I2?=
 =?utf-8?B?RVJlQzFBWk84ZVY0cmdQZElMUE9UelNsMWxPb2dCbU9XRER0WVh2N1hsaDky?=
 =?utf-8?B?OEJRZyszK3NLWkxUemFzZUh2bTV1QVVXRk9MQ1lBV25OV0QvTkhTSTkvbmJm?=
 =?utf-8?B?bE5KMlFwS1lBbkpNSEkzNFd6K2c4NzNPVWRvc2VqOVBCSVBnb2VrdTZRamwv?=
 =?utf-8?B?bnBUYmVReDlyaU4zSGcvK2J5UDU5c1Q0UnNiZkxVMWhjTDd1UzFaYTNlam1z?=
 =?utf-8?B?U2ZTbzlHNXJGNU9zMjhkTG1GbU5COU5HSk9tUFBEeHYrd04yUytSbjY5WHhJ?=
 =?utf-8?B?enY5QWVPOWRZQVR0cXhCd080aTM4M3dlRUJsRUpmWFRpOW9lV0U5T2NhV3Vn?=
 =?utf-8?B?dExjSTFSdnQvdEpncFMzY0djcnBNb0JrNDN6c2d4TmxtZ295SERQMGs4TkJn?=
 =?utf-8?B?cXI1R2EzUmp4dEpGN29YN0R1c24vUVJBTng0VW5JMkluNjdnVFhLaU04d1FZ?=
 =?utf-8?B?UzVMa2FLYUtlVVFMbmQ2cDFSTFkxYTAybWpmVFlSVUpOSTVMTFVaS0RPeFFs?=
 =?utf-8?B?SmQ1QW1uNHFSQzVyZE5ZdTE5RFdybFBpWmRlRkNpeXJabEVFcEdvSFRWVnBi?=
 =?utf-8?B?UzNPaFBvMGdCZlJJL1hkdXVUTnpWWkhob3ltd2VzSjk0WFltSzVzaG41N0Qy?=
 =?utf-8?B?OXdSNjN0Q3dVRHFyRDI1cm0yNXhGcEg2K0xjSmlIckVlakovUUR0Z1haOWxD?=
 =?utf-8?B?cXFpQ2lMRWRMRHhKUzlTWTdmTytOM2MxR2VXdHdSSnozOGUrSDM1L2dkaUVx?=
 =?utf-8?B?VVBYVVNlQmMvQTc4dmRsbUFLOEhYRHcrN2kwU0MrczZDQnh4MTZ3b3pqb3R1?=
 =?utf-8?B?OU9PMW1iNjR5VnJQS3ZCamdobC9FTVlFbUhTUTdXVi9UNzE5S2J3aDhOMTZv?=
 =?utf-8?B?TkxMWVNEclZodm1FUGhpUDZRc005UkZ5eHFXMEpIUWZ1Sk5BeEs3Y0QyWWJ6?=
 =?utf-8?B?Y3g2L3RGM0tPVzFkVnpwNDRzTEhtTjVsck1YMnR3WGNTQlI2ODF6TXFiOVB6?=
 =?utf-8?B?TzdadjBrUTlONmdNNzJhQnZrNFRWNlJqcHQ3RWhwSmdJaWdSUjZRRTJLeDV0?=
 =?utf-8?B?WjdTM1JrY3JCamcwd2E3L3FtM3k0NE1PcFNRMmFWTFFqUlhSMzE2bjR3Y0Ro?=
 =?utf-8?B?NDZQSDZ0LzdxWFJkNGNtTDZ1UlFSdWVDSnIxNHFFTDBRTUgybUhkdUY5YjFI?=
 =?utf-8?B?ekZNMnBEZHl3bU41YW5KOWIzVDI4bTl1c2tpaXR4cnhHeUZibWdoVEJvUnM2?=
 =?utf-8?B?ZmtMWGdZWnhVL3hkOWhWUHJSQkhRQUhOSGZBVXJNcHROcjV3QmVNZ1VZMDk0?=
 =?utf-8?B?K3NmRDNJQ1JXUmdYZHgwYURUKzdvSGVhaEN3Z2gxM2x6RWZaZklldXAwTUR1?=
 =?utf-8?B?TUJaQ2tKQWZ3aUNVeWYxSXRpRWFhbFNwZnEybnZsZ0crWHhrVkIrT2JtaC9q?=
 =?utf-8?B?MC9EdWRhNExLbkdZblhPMW8xWE5qSEl5OFZiZEc3Y1NHdjQvU3ZTWFJRVFkv?=
 =?utf-8?Q?z4fs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042ae5d0-1292-42e5-98c0-08d9aaabd78f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:55:28.3283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F71aHGbVnY47s0s8y+q0X9mwrEYiJgAeT04kFEGfFxbYEX/ooGYBZJS0xGTmSCrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-18 10:07 a.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f751ec08-d21b-819a-528d-65511095602d@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-11-18 um 10:00 a.m. schrieb philip yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2021-11-17 7:10 p.m., Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 2021-11-16 10:43 p.m., Philip Yang wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">VMA may be removed before unmap notifier callback, restore pages take
mmap write lock to lookup VMA to avoid race,
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
The old code looked up the VMA after taking the mmap lock (either
read or write) and kept holding the lock afterwards. I think even
with your new code it's possible that the VMA disappears before you
take the lock the first time, so always taking the write lock only
reduces the time window in which things can go wrong, but it doesn't
remove the race.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Take mmap write lock will serialize with __do_munmap,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
__do_munmap runs with the mmap write lock. Taking the read lock should
be sufficient to serialize with it.
</pre>
    </blockquote>
    <p>__do_munmap takes mmap write lock to remove vma, then downgrade
      to read lock to call unmap_region.</p>
    <p>static int __vm_munmap(unsigned long start, size_t len, bool
      downgrade)<br>
      {<br>
      &nbsp;&nbsp;&nbsp; int ret;<br>
      &nbsp;&nbsp;&nbsp; struct mm_struct *mm = current-&gt;mm;<br>
      &nbsp;&nbsp;&nbsp; LIST_HEAD(uf);<br>
      <br>
      &nbsp;&nbsp;&nbsp; if (mmap_write_lock_killable(mm))<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EINTR;<br>
      <br>
      &nbsp;&nbsp;&nbsp; ret = __do_munmap(mm, start, len, &amp;uf, downgrade);<br>
      &nbsp;&nbsp;&nbsp; /*<br>
      &nbsp;&nbsp;&nbsp; &nbsp;* Returning 1 indicates mmap_lock is downgraded.<br>
      &nbsp;&nbsp;&nbsp; &nbsp;* But 1 is not legal return value of vm_munmap() and
      munmap(), reset<br>
      &nbsp;&nbsp;&nbsp; &nbsp;* it to 0 before return.<br>
      &nbsp;&nbsp;&nbsp; &nbsp;*/<br>
      &nbsp;&nbsp;&nbsp; if (ret == 1) {<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret = 0;<br>
      &nbsp;&nbsp;&nbsp; } else<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);</p>
    <p>}<br>
    </p>
    <p>int __do_munmap(struct mm_struct *mm, unsigned long start, size_t
      len,<br>
      {</p>
    <p>...</p>
    <p>&nbsp;&nbsp;&nbsp; /* Detach vmas from rbtree */<br>
      &nbsp;&nbsp;&nbsp; if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; downgrade = false;<br>
      <br>
      &nbsp;&nbsp;&nbsp; if (downgrade)<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);<br>
      <br>
      &nbsp;&nbsp;&nbsp; unmap_region(mm, vma, prev, start, end);<br>
    </p>
    <p>}</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:f751ec08-d21b-819a-528d-65511095602d@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">to ensure vma remove and unmap callback are done, because unmap
callback set drain_retryfaults flag, so we can safely drain the
faults, and it is app bug if vma not found after taking mmap write lock.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
I still struggle to understand the race you're trying to fix. The
only time the svm_restore_pages can see that the VMA is gone AND the
prange is gone is after the deferred worker has removed the prange.
But the fault draining in the deferred worker should prevent us from
ever seeing stale faults in that situation. That means, if no prange
is found and no VMA is found, it's definitely an application bug.

The only possible race is in the case where the prange still exists
but the VMA is gone (needed by svm_fault_allowed). We can treat that
as a special case where we just return success because we know that
we're handling a stale fault for a VMA that's in the middle of being
unmapped. The fact that the prange still existed means that there
once was a valid mapping at the address but the deferred worker just
hasn't had a chance to clean it up yet.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Yes, that is only possible race.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">One more comment inline.


</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">&nbsp; and then create unregister
new range and check VMA access permission, then downgrade to take mmap
read lock to recover fault. Refactor code to avoid duplicate VMA
lookup.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65
++++++++++------------------
&nbsp; 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c1f367934428..3eb0a9491755 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct
svm_range *prange,
&nbsp; }
&nbsp; &nbsp; static int
-svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *start, unsigned long *last,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool *is_heap_stack)
+svm_range_get_range_boundaries(struct kfd_process *p, struct
vm_area_struct *vma,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr, unsigned long *start,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *last, bool *is_heap_stack)
&nbsp; {
-&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct interval_tree_node *node;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start_limit, end_limit;
&nbsp; -&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
-&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt; vma-&gt;vm_start) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA does not exist in address [0x%llx]\n&quot;, addr);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
-&nbsp;&nbsp;&nbsp; }
-
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack = (vma-&gt;vm_start &lt;= vma-&gt;vm_mm-&gt;brk &amp;&amp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_end &gt;= vma-&gt;vm_mm-&gt;start_brk) ||
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vma-&gt;vm_start &lt;= vma-&gt;vm_mm-&gt;start_stack &amp;&amp;
@@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct kfd_process
*p, uint64_t start, uint64_t last,
&nbsp; &nbsp; static struct
&nbsp; svm_range *svm_range_create_unregistered_range(struct
amdgpu_device *adev,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange = NULL;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, last;
@@ -2449,7 +2443,7 @@ svm_range
*svm_range_create_unregistered_range(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bo_l = 0;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
&nbsp; -&nbsp;&nbsp;&nbsp; if (svm_range_get_range_boundaries(p, addr, &amp;start, &amp;last,
+&nbsp;&nbsp;&nbsp; if (svm_range_get_range_boundaries(p, vma, addr, &amp;start, &amp;last,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;is_heap_stack))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
&nbsp; @@ -2552,20 +2546,13 @@ svm_range_count_fault(struct amdgpu_device
*adev, struct kfd_process *p,
&nbsp; }
&nbsp; &nbsp; static bool
-svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool
write_fault)
+svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long requested = VM_READ;
-&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write_fault)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requested |= VM_WRITE;
&nbsp; -&nbsp;&nbsp;&nbsp; vma = find_vma(mm, addr &lt;&lt; PAGE_SHIFT);
-&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt; vma-&gt;vm_start) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;address 0x%llx VMA is removed\n&quot;, addr);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
-&nbsp;&nbsp;&nbsp; }
-
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;requested 0x%lx, vma permission flags 0x%lx\n&quot;,
requested,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_flags);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (vma-&gt;vm_flags &amp; requested) == requested;
@@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t timestamp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t best_loc;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t gpuidx = MAX_GPU_INSTANCE;
-&nbsp;&nbsp;&nbsp; bool write_locked = false;
+&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma = NULL;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev)) {
@@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mm is available because kfd_process_notifier_release
drain fault */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
+&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Always taking the write lock is unnecessary. I think we can keep the
old strategy of retrying with the write lock only when necessary. I
think this should work correctly as long as you lookup the VMA every
time after taking either the mmap read or write lock. The vma you
looked up should be valid as long as you hold that lock.

As I pointed out above, if svm_range_from_addr finds a prange but the
VMA is missing, we can treat that as a special case and return
success (just draining a stale fault on a VMA that's being unmapped).
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
ok, I will change svm_fault_allowed to return success if VMA is
missing, it is simpler to handle this special race case, without
taking mmap write lock.

Regards,

Philip

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+
+&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
+&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt; vma-&gt;vm_start) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA not found for address 0x%llx\n&quot;, addr);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_mm;
+&nbsp;&nbsp;&nbsp; }
&nbsp; -&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);
-retry_write_locked:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_from_addr(svms, addr, NULL);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find prange svms 0x%p address
[0x%llx]\n&quot;,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, addr);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!write_locked) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Need the write lock to create new range with MMU
notifier.
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Also flush pending deferred work to make sure the
interval
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * tree is up to date before we add a new range
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_locked = true;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry_write_locked;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_create_unregistered_range(adev, p, mm,
addr);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_create_unregistered_range(adev, p, mm,
vma, addr);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to create unregistered range svms
0x%p address [0x%llx]\n&quot;,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, addr);
@@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_svms;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-&nbsp;&nbsp;&nbsp; if (write_locked)
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
+
+&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
&nbsp; @@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; -&nbsp;&nbsp;&nbsp; if (!svm_fault_allowed(mm, addr, write_fault)) {
+&nbsp;&nbsp;&nbsp; if (!svm_fault_allowed(vma, write_fault)) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;fault addr 0x%llx no %s permission\n&quot;, addr,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fault ? &quot;write&quot; : &quot;read&quot;);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EPERM;
@@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
&nbsp; out_unlock_svms:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
+out_unlock_mm:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(adev, p, gpuidx);
-
&nbsp; out:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
&nbsp; 
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
