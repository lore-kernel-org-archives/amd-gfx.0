Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AE7C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA9B10EF28;
	Wed,  1 Jun 2022 16:39:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CCF10EF21
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1yotNzq1uNYBxl/ibzEs5v6xYui6REj3q7P8aFVahZuGdRP/ge2zd076PJxhQll5D6DdrvgkCUl92W+FzAcEnNSqWklIk9M/hXjJ59sJB2b0LU9XCBggqE7bU+egGNcegCqK/k37+iZjjsvtbvLQ2sr2SnoxrwQotbRu4vIAte9d8LS6xuQn9YxRgA+Fu2RQt6HkzwaqyOY6HZL68afskkjtn5VI8fkzmrYKAsm4mPoyKVdRjtSWVLoJO1pQsJzkgqHtmJX1wTXInEiiqywG51JtCcSIzBDG1VyqOjMCO87yFq59QRWiulxSktcvyLJQfWhKCVw0dLk9EkpLimKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0o73RS9p5RQbwQz478MYoESvpoLFndaUe9T7AooYBE=;
 b=AwHZ385qhzJl4RjTBtYR8ddHkb4uHwyUyySNpGHb0ZhYH5HQtujSEqsHWaQVUVrPQsnLGuPkfA6qypL3AVF94Jv9uv1kXOx2je91S75zbjeoaqCnk4drBKcG323XnmKwFyn6pChHACC+kafN2Zg7V5gjP5h/UpG9KLg83Nu97fshFaQ3tXaTpnYNKKHCDWGqLXTsho8OxgrkDZYU5v+8YkDMqGB1QJTo5vD49yR/dq4zO/4sEdAX/b6TEdzZobTk991hSydwnh5LAC/UAOixEFLjadybqx1PrtgpmVbWi0V67pp/A63iEWN/Rm5WIWI9qqBBi5R49B5TQuKYsam7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0o73RS9p5RQbwQz478MYoESvpoLFndaUe9T7AooYBE=;
 b=Dl9oe9WGvhlQBcBCjKg4L1XEVleUQuszYeODhKfp8xvzlS0s5DFlu/b00q90mEaI3f8eR7wvoAsdvAJMeatAI3yCir/eNfViD/FGqqJ3Df/ZZj7yIsT9gYtTHpsA4M1gXgkcu8P5VEJ2x01dyjkMJajhfTZi1xOhY6Qq5KxVlhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 16:39:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 16:39:36 +0000
Content-Type: multipart/alternative;
 boundary="------------fR4H1lNtsKcarZm2SjeWWDN6"
Message-ID: <35d469ee-ef32-75a9-f391-019b4e31ba57@amd.com>
Date: Wed, 1 Jun 2022 18:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <CAAxE2A5Apz3u7cxCcpPuhYDj=s2Jg2vwd=2jhXbnR=3X8ZWxFw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A5Apz3u7cxCcpPuhYDj=s2Jg2vwd=2jhXbnR=3X8ZWxFw@mail.gmail.com>
X-ClientProxiedBy: AM6PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::39) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977a4de1-2034-4e72-2043-08da43ed50b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3465:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3465ED085ED4EE24070541B183DF9@DM6PR12MB3465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tx9tQ8h8p+m7FwXM+ccazott4n1K7ZQFdWrsPWr+V7Hm9kdRSnMcMSl10pMus5Yp7CGyibxWE0Kwo1Ty2G6mBr1moiwhZzObwxaYWhWkpyrqYLIzi8qwYRQl5h8xiDGXlO+1I5lB2r8bNefONpB8/y4IIm/y1cuC5+AEYAtm138fY9eTWuNf8NrN+Rp625RgzDz2xMrkwd42Zbi39WNKSF0kxOlmeefdEtoqC+g9LnVO5U+kD10rwCsaHDA/0C+4KkEG7c2pz0qOZfUXSAKmXecUltX/nQvRhKx1HOzW2zJRSSuy33/pbcnYkRDFGIItJeOn7eMlD/NJJH/efMz+Oky508eoJieqmfmzuhkJuRcdwTv09wpeCGmjFaa7JIdFhyRU6W4qja+n8H6nxFleFC96QfnwFkKORESqs4Rsv2yafD2yDv2Jwsp7ODDmHzBhjFwpqVKrqk72FREOEg4pIJTLqQ1NmhAgIBQRiT0CIVIjTKi4qFGQKnKmO2AH483hA5PEQLXXkmVwClNUGtQ74rkIM8qRk9xdYKxTciInQWRkaUiJPM7o/79jSrzM9+ae5g1jqxqEmkcqOopYjQOcdjs0SlMtbKGsJezePJRX/jaL2BQzjC9JnlYk69SEODOy6QwbFoCfXX+b0l+Fui35JWd3XePGzRoyi6ZAjGqPU2mL+tXUpNglbAB96m0QgOmR2haSl7FwRVhhmytNQE7OhBFNnXvGmArLAh3eRHDkOSXKi90GeWtlOqEJ+JLmKpXz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(3480700007)(8936002)(6916009)(508600001)(316002)(5660300002)(8676002)(38100700002)(66476007)(83380400001)(66946007)(66556008)(7116003)(6666004)(6506007)(6512007)(53546011)(4326008)(6486002)(66574015)(33964004)(31696002)(86362001)(15650500001)(31686004)(2616005)(186003)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRMWDB0ZWJhVWg5bll6bGJoRXd0VTNzYVJMTDdNb3kwc2pOVURIQWYrNFkr?=
 =?utf-8?B?NCt1UGEwRWhOL2tya0YySFJaWUxEWmk1MmZMQjZIcjFSWGRlcW9JcmVrY05n?=
 =?utf-8?B?eVZRMzRpb1ViUjYzS3VNZk5pMnRuWExXbXNhN2FuVWhUT3N6akR5TEQwTStv?=
 =?utf-8?B?SkV3d3c3UjZBVUhWWVpPdnJ1MHgvYitFcjIrKzFEMGFYSi9pOHRSQ3UydXNi?=
 =?utf-8?B?d08vT1Vya3VKRlZWb3p6eVc3R245ZjVSWEE2dnFZZkJEUEVjWkFMeU10Ulor?=
 =?utf-8?B?eTVMa1A1b0xHY2ZCTjZJdEVJWGN2S2xMUkV1V1NtR3YyNUdOaXJMNUx0TE4z?=
 =?utf-8?B?Tzk0NHFZREVuQi8xOWpjOXpYNkUvNGF0Smg5NXJOTTIwMUVVWElrMFdZVGVl?=
 =?utf-8?B?bUd0Vks0WDhsbDhsRngrRGVNeXdZZUMvYkdtY1FuSCs2QVAzck01blZTaG1O?=
 =?utf-8?B?RThRT2E1eEtpR3RZZk52STFEY3lOSmREd2FTNE4xa2t3Q2tEUFdmQUh0T28x?=
 =?utf-8?B?YjhFNVlISTNxWTRiUk51dnRxb003WnZ2SEY4a094d28rUWh3Vk5tcXBxOFcx?=
 =?utf-8?B?bzJsZkkxbzdaTjdtWlhDbFBaN1ltdTcyeGhWaVJvbnVTUWNtc21CRHA2YTZ3?=
 =?utf-8?B?ZlA4NjEvV3dmSUcwWC8rallQVnVDYjIreSt1aHNVUzBGVThTV0tDTy9LSW1u?=
 =?utf-8?B?dWl6dC9xNVkvVysrSjMwUWJVZHM5MUc1Wm1nbExtcEZnbmpmNGJzTjJDSGNJ?=
 =?utf-8?B?VFVCKzFTdGxjazhMeTBtaGV0SC9odFQ2ZnJMaE9aV2RHUXA3TWJudU16RGta?=
 =?utf-8?B?QnQ5aUVuNEZLaXJ6b3dVV0JBWkRCdGFYTEtvcm5hN3RPNTdrbUxLQW5rN2tp?=
 =?utf-8?B?M2V0dEJ6ME12OUJuSG9HZGE0ZVY2N0dJajd5T1N6T3p6R2JOdXd5YlJpTFlT?=
 =?utf-8?B?N1NoRmZVcDI1Nzh3T09qQnpLOTRCNzNnb2tLUGZWVkJvekxlTkRQVkpOZ3dV?=
 =?utf-8?B?L1h5QW1FbFlpbHB1T0wwYUJRN2ZXaHl1d1NpZVlXRXRoN1lIbzJvOTllMkxp?=
 =?utf-8?B?RkpnYlJnVnM4SXhVNkpQQUh1bWZkRUJPSnB4cHdhQ3VRZXF4Vm5FaTVFRnZl?=
 =?utf-8?B?OVl2VGNxbG5icGhkTFRJb0poL0pHVE5ZK0p1dGRkMFRZQjg5MVIxYnJydDhN?=
 =?utf-8?B?VHVTdmhVTnpGbEJQSXFpeHdtRWFPRjMyRWZhbzJSd2QvQkJZN0dVeGsrNnhI?=
 =?utf-8?B?MStzMmRQbkp2SzlQMDdZY2U1MDRwdzZwZXNLQ05Zd3lTaFZWUVB1SEJPeE5S?=
 =?utf-8?B?YmFyQk8zRndrNGc4RnJhSDh4dXM3eE5HU1dqZEJhaVorWlM3NHFtKzU2Q1hj?=
 =?utf-8?B?Ylk2Z28zd0ZNMm9Id3BqMkhuRDJCazlRaVRxME9ZUEJ5UzQrY3dXckN5TGZZ?=
 =?utf-8?B?ZUp6UXRKL2FMUUkrQlc5djdmL0VsbStNTGFPb25PcDV6U040aTkwOWYzWlN4?=
 =?utf-8?B?NENyVmxiNDQwNWZPeUV2bWU4SmpPd3BpbGxZa1ZhUEZuK1NQYmp4UVlPMWxO?=
 =?utf-8?B?R0ZNRkNLYlZONmZCOGh5QVlWdGpKa3FlbVh1NkI5NTBJb0F1NEN6TXJWY1B3?=
 =?utf-8?B?U3dRQ0crZjVWQ2lNaFRSTDV1YWtsSWU1dWU0OXUyRml1RGVxUndFQ0JaOW5t?=
 =?utf-8?B?V2tEKzJCZlJDZXhLM04ySmthYTRGUXNwbkhDbGNPdGpseDI0R1lXZmNnWW0y?=
 =?utf-8?B?NmcrZ3p1a25qVFZPV3ozd2k2blZJTktkUEYxc2R4U3k4Qlk1YnRETHJ2RENa?=
 =?utf-8?B?dTBpakl4N29OVWhwNXllZm9EZWRPQ1RCRWk3UVoxQjhLNDVCSlBUb3VLeGo0?=
 =?utf-8?B?Mi9xYyttQUJKdzJXV3BZdTE1eWhZSGVzZHJnZU4ySWttaWtjMnR5Y0diR255?=
 =?utf-8?B?ZENHZlZTNStzd2MvcDV2SGJ2SUtMZTArMlhrbktZWG1jdzAyOEVYSk96OTJ0?=
 =?utf-8?B?NTEwbkZhK0hheHlnZ0xuc20xTlVBNUMrUFFKOUR2cDhrYUVPU1ZoSjIvM2c2?=
 =?utf-8?B?b0pieG9tazRhcjFNeWxpNkx0WVZZNVJBbFJYdWlCN05CSTVPN0JXZnZwbU9p?=
 =?utf-8?B?RDJvNnRXa0p5dzVWckczemxVNThxN0xuSzU4Nm1zbCtlQWw3NklXdVhDTFpH?=
 =?utf-8?B?Zm0zWjB4dXZzenVLaTB2bXB5UjR4QVJMa0pIdHFUQldHREF2czV5N0ZGYW1a?=
 =?utf-8?B?akVoMXBTcHpJUGlVeE1pQ1hxTnNUUWgyU1NrYnhMSzdPRFlIV0FIOGxnRVBh?=
 =?utf-8?B?R01yRjNnRkpEZVJhUGVuSWhBa2o4NjlGUEVSTVZ6WmkySS9xNytwOENiQkdC?=
 =?utf-8?Q?oXjHZNsVlRY9fBB2RjV30kqWP2ltnBvclba1Hmm+AfDpg?=
X-MS-Exchange-AntiSpam-MessageData-1: oiRGA/EN/1K5qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977a4de1-2034-4e72-2043-08da43ed50b9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:39:36.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/r4c2ADecwoA0V4J4mqJ3d5RQJKJppgXf8UyN9B19xY96wZ9UtA00hylTf0UB8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3465
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------fR4H1lNtsKcarZm2SjeWWDN6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bas has the problem that CS implicitly waits for VM updates.

Currently when you unmap a BO the operation will only be executed after 
all the previously made CS are finished.

Similar for mapping BOs. The next CS will only start after all the 
pending page table updates are completed.

The mapping case was already handled by my prototype patch set, but the 
unmapping case still hurts a bit.

This implicit sync between CS and map/unmap operations can really hurt 
the performance of applications which massively use PRTs.

Regards,
Christian.

Am 01.06.22 um 18:27 schrieb Marek Olšák:
> Can you please summarize what this is about?
>
> Thanks,
> Marek
>
> On Wed, Jun 1, 2022 at 8:40 AM Christian König 
> <christian.koenig@amd.com> wrote:
>
>     Hey guys,
>
>     so today Bas came up with a new requirement regarding the explicit
>     synchronization to VM updates and a bunch of prototype patches.
>
>     I've been thinking about that stuff for quite some time before,
>     but to
>     be honest it's one of the most trickiest parts of the driver.
>
>     So my current thinking is that we could potentially handle those
>     requirements like this:
>
>     1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL.
>     This
>     way we either get the new behavior for the whole CS+VM or the old
>     one,
>     but never both mixed.
>
>     2. When memory is unmapped we keep around the last unmap operation
>     inside the bo_va.
>
>     3. When memory is freed we add all the CS fences which could
>     access that
>     memory + the last unmap operation as BOOKKEEP fences to the BO and as
>     mandatory sync fence to the VM.
>
>     Memory freed either because of an eviction or because of userspace
>     closing the handle will be seen as a combination of unmap+free.
>
>
>     The result is the following semantic for userspace to avoid implicit
>     synchronization as much as possible:
>
>     1. When you allocate and map memory it is mandatory to either wait
>     for
>     the mapping operation to complete or to add it as dependency for
>     your CS.
>          If this isn't followed the application will run into CS faults
>     (that's what we pretty much already implemented).
>
>     2. When memory is freed you must unmap that memory first and then
>     wait
>     for this unmap operation to complete before freeing the memory.
>          If this isn't followed the kernel will add a forcefully wait
>     to the
>     next CS to block until the unmap is completed.
>
>     3. All VM operations requested by userspace will still be executed in
>     order, e.g. we can't run unmap + map in parallel or something like
>     this.
>
>     Is that something you guys can live with? As far as I can see it
>     should
>     give you the maximum freedom possible, but is still doable.
>
>     Regards,
>     Christian.
>

--------------fR4H1lNtsKcarZm2SjeWWDN6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Bas has the problem that CS implicitly waits for VM updates.<br>
    <br>
    Currently when you unmap a BO the operation will only be executed
    after all the previously made CS are finished.<br>
    <br>
    Similar for mapping BOs. The next CS will only start after all the
    pending page table updates are completed.<br>
    <br>
    The mapping case was already handled by my prototype patch set, but
    the unmapping case still hurts a bit.<br>
    <br>
    This implicit sync between CS and map/unmap operations can really
    hurt the performance of applications which massively use PRTs.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 01.06.22 um 18:27 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A5Apz3u7cxCcpPuhYDj=s2Jg2vwd=2jhXbnR=3X8ZWxFw@mail.gmail.com">
      
      <div dir="ltr">
        <div>Can you please summarize what this is about?</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, Jun 1, 2022 at 8:40 AM
          Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hey
          guys,<br>
          <br>
          so today Bas came up with a new requirement regarding the
          explicit <br>
          synchronization to VM updates and a bunch of prototype
          patches.<br>
          <br>
          I've been thinking about that stuff for quite some time
          before, but to <br>
          be honest it's one of the most trickiest parts of the driver.<br>
          <br>
          So my current thinking is that we could potentially handle
          those <br>
          requirements like this:<br>
          <br>
          1. We add some new EXPLICIT flag to context (or CS?) and VM
          IOCTL. This <br>
          way we either get the new behavior for the whole CS+VM or the
          old one, <br>
          but never both mixed.<br>
          <br>
          2. When memory is unmapped we keep around the last unmap
          operation <br>
          inside the bo_va.<br>
          <br>
          3. When memory is freed we add all the CS fences which could
          access that <br>
          memory + the last unmap operation as BOOKKEEP fences to the BO
          and as <br>
          mandatory sync fence to the VM.<br>
          <br>
          Memory freed either because of an eviction or because of
          userspace <br>
          closing the handle will be seen as a combination of
          unmap+free.<br>
          <br>
          <br>
          The result is the following semantic for userspace to avoid
          implicit <br>
          synchronization as much as possible:<br>
          <br>
          1. When you allocate and map memory it is mandatory to either
          wait for <br>
          the mapping operation to complete or to add it as dependency
          for your CS.<br>
          &nbsp;&nbsp;&nbsp;&nbsp; If this isn't followed the application will run into CS
          faults <br>
          (that's what we pretty much already implemented).<br>
          <br>
          2. When memory is freed you must unmap that memory first and
          then wait <br>
          for this unmap operation to complete before freeing the
          memory.<br>
          &nbsp;&nbsp;&nbsp;&nbsp; If this isn't followed the kernel will add a forcefully
          wait to the <br>
          next CS to block until the unmap is completed.<br>
          <br>
          3. All VM operations requested by userspace will still be
          executed in <br>
          order, e.g. we can't run unmap + map in parallel or something
          like this.<br>
          <br>
          Is that something you guys can live with? As far as I can see
          it should <br>
          give you the maximum freedom possible, but is still doable.<br>
          <br>
          Regards,<br>
          Christian.<br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------fR4H1lNtsKcarZm2SjeWWDN6--
