Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F5FC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 14:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF0110F909;
	Fri, 10 Jul 2026 14:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mcpvP2T";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707BC10F909
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 14:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O612dqfiL3apRyRrcz1qJyw68N6vWfSDRLViFwcTWQhri5inxztuqm6WOWbG52OCbHM9F8VUqEWG2Zy4VdlWg493ft9FchT7TsoS17zqFw0j2sRYhkoL5XFnY8fp5ir8ChkaxgiSsFV5LfcpnvZVgW6lpWAycLvAuvQtw/5B9Dh37V8VIsRqGFkYlw+Q8s5SqUuxqUKgWQfGA8tE5j80KPippiUhGcvk5Iq8TcOaaf3Hg5Q78bDroWGswloNKEvvf0nDxQyo6Q7vTBwPm88+ygsBXFT6kvxE31UY9KLvJXWiFQa75iBJ8Dwxfd+OOeZo1ODFuoJPpQktjHDtkDlwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8DtX9huAnt7CI8UypTasTAhc5NIG2k4KfxqXp3KV+Y=;
 b=cxRD3cl8TU2xMS0oOaqBqaSC4F4intKEXfkr1T6N+ukdOCVpgBOmKXx21mQ41Schjm4CRNC9chOP7ilFyRqktvUzVyS69qUhhdFcxY2beAJiN8P4RzjIc7E/VufcDGGuCqfEhmYLG2lj3hJnBnM9S4r6XduKuPsc04+nNEibp/Bjc3sKmf9N++KqrluHdGLBrUryfTzGBHbr9/Z8w78RS5OKlj8KWmhceQNN6rKcK5EIG/NJsNlexdFiB9xo6CroyChyRNs1G7j4umkvP3FgA/aaSRgShTpi5fvYivvITQ2zHkAAunH6S6mCwb6wLkyITqV8GMHNZWvf5leZ9S5l/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8DtX9huAnt7CI8UypTasTAhc5NIG2k4KfxqXp3KV+Y=;
 b=4mcpvP2TquQ733zL+25sz6+/OzFjm0SocEQpkWvFZUvcf39JHup+GJ6/rhsF+uuogffQvv3ppSyk8hbMS5hen/7XkJCnvPF/7EbCH+1LlYb6X8H1DrQLK331iwDsx017ApgJnZcUmilX3I9shwEpYD7rk4Yb0wGMjmurjXPOb5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 14:08:19 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 14:08:18 +0000
Content-Type: multipart/alternative;
 boundary="------------2FDucAJaVGVaJHxWv1cdtx3f"
Message-ID: <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
Date: Fri, 10 Jul 2026 22:08:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
To: Dan Carpenter <error27@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
 <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
 <alD6PcLowqjVBnSl@stanley.mountain>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <alD6PcLowqjVBnSl@stanley.mountain>
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: c0959365-933f-46cc-3157-08dede8cb14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|8096899003|22082099003|18002099003|11063799006|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 9JoUjJ4bcNFA3k8sBDLQrGDK7JDcI9kQcaZlliiV8wwbabbse49nSdUceLenoKBjV7lnqEa0z82jQwJZpKbQcSyHCqlKERmFZFtPFDD4Xydai1wfdJpp+D1mOkcSUYdSlh2yP+ZIVY0fE8VFgRqOSQxrGDgYKtEiEOSPkIyINjSiZAsnQy52Boyi6QlrPvCIZmKZW+6pYHLioD5Ku9zwixvfoLYSLlWU+fiPD2+2IQMHImx+X5EABb6kwdKi9UbDyzPqngPmanTwGdCvgqpuuLF+TpeyQf1qIja/vFJB5pImlQRwhHinPxkHbVIfYH5zzLCRqIFvFNsugIBGrrrkSOGokdA5Z5JqnWSDFeVHtj4nKf13xN6VzzMtu68YkV5VWegMvz12RXjdQCdNkiqSyx1xJTtb2Dbpcu4NMYubtFCWm7CNv4OV2/6PTfQNyVw/9x9QXqf3rRWEIMV+3N79bhzgk5lD41lpzqtboRVhnQxikCh0Sy3FS1AOQhCDMISHUsRe4m0WhvzYp7GXRQHmslehclzA2Md610Fgyt8X76JGLlYU7DdhtSTOvQNBRnwxEkHVMnvwBuARa07dCPZv7YlEPLyp6cWJenT5nqPgFee2ChsAkegEL0hnvJxurgGENKWBnyCL6gwC+S7NN/Y29FHuuInS9pCxmL70AafiMKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(8096899003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRCckF2cmNDMkdxODF0c0tqcm1XTlFVYmRGSEJiKzJNa1krVzZpZWxoVVMv?=
 =?utf-8?B?RitxWWg3RmYrVzYyQjA2ampLZDExdExTYjUvTkMzNkM5ckIwMmUwYlR0bmNy?=
 =?utf-8?B?ZURNU2Z5b2hQVlFlUmJkZUJjakY5b2NPRGZtZUdMQ0NNMThQWHVQQ1NuZnc2?=
 =?utf-8?B?emJkcWJ3U2ZlaWlhUldKYXM0b21aUGpFakVKVm9xVDlOZTBxeDMxTWFiR0tM?=
 =?utf-8?B?d3doYWZlY3hzRUJncm91YWdKbndYRnBSaTZVUjZEa1pIUEEvZ0hvd0xRR3gw?=
 =?utf-8?B?MExFVFNtQm80V3RXelFuZm81K1BxN3h2N1F4L3hjcVVzdm84RHBaRU4raXhQ?=
 =?utf-8?B?SVEwVDdZdHg5RUE2dDJ6SnpVejB0WVFia1pEbkNLeUo3MjczcTU3cjlhQklN?=
 =?utf-8?B?V1B2N1ltRVdpNytjRXVQcWQydTFZNTZZT3NTa2ZveFZNS0R6azBQQlNoSi91?=
 =?utf-8?B?RU5LVTU1Rlo1OWlZV1dBRUtESTVSeWl5MTZCeWZTUSswaWJlalNiVTNaelZ5?=
 =?utf-8?B?cHlFOVlzUy94ZzdSSkcyV3dVQ2RKNmRnY0s5YmVmSCswWDJyMUxYOFFpVHpo?=
 =?utf-8?B?WHp6bXpHcjkvNzhyTmIwUTZKc1ZHbDJuelpUMWJ5M3ZvVm9xVXFFSHlpZHR3?=
 =?utf-8?B?YzRvQ3lYSk85NWhQSU5tV0hBS1ZaVnZ3RERMRG01SnVwQ2NFSFVZeUV0NEUw?=
 =?utf-8?B?ZlhEbFhLMW5pcHZyNmp6VURPclZZVGo4WWMxRDlaVUt0SnExSmhoL0pWM2Yz?=
 =?utf-8?B?dm1CamZCaTJWNzNOa211KzZnQzcvUFNHaXpGTGNsZVQxU3B2MHBKTzRJN3hy?=
 =?utf-8?B?TEErWXFIZ2taN2I0eW1SaVRGUVIyZkJkTnJaOW1sS3BtWElZVDY0UXB3cDJM?=
 =?utf-8?B?R1pCREh4VTNYckI0RHJSZmkxSFZaRGFnVkdxd1JDRUlJOUs1R2h4R2lZdmxZ?=
 =?utf-8?B?M2hmN05iQW5HSWpENXlpcmNyMGEycVQ1UXM0aEpDZTFpeHBDam1nbkFCamts?=
 =?utf-8?B?b2g2Q3ZBUXU5cDRQMUpBa3Frd2JpQkxKYm1kU0cvZzRGVHgwNkZHakdnRmps?=
 =?utf-8?B?YTNsYXZrNFhodGovd3gwSlBPZVhtT1NqNXh1bFlUZ2EyeC9xakdvem1WSWo4?=
 =?utf-8?B?Zmk5UHp0WUZmTkJKL3U4UjRUZjhjNm5PTWUxVzlEZ0JadzhnYnRZb2NuZkpz?=
 =?utf-8?B?N0gwQ2F1RmlOV2xPTUVCVTFVL0w4WVY5TGhxanJsQU1uTW5pbkFHUjBCcTVl?=
 =?utf-8?B?bGRDRkVHYmw2U1dZbXhFb0VvbUJDWlp4cTVZVXVqWEJhN2hoSVBMYnZPYzlk?=
 =?utf-8?B?WDg2dFcxZ3FHZGw3L3E1bk9SYzRXVDNsM284bGpMelJnSjA5NEtBRUxwcHdL?=
 =?utf-8?B?SUNrZDh5bTdSSUdwSDdPbStqM0JjdVlVaWwxbUtzUmpaQmVYWk90Y25LVzll?=
 =?utf-8?B?ajk0ekZRN1FMMzhsNkE5MFowSHVMcVcrUWJMMyt4RWcrZi9FbHo2N0U0K3lY?=
 =?utf-8?B?aFZJSTM5clkybHZKdGtJVlFFWEQ5ZnRYUk5TNEtldFE2OUhiZGVkZXRMTFFm?=
 =?utf-8?B?REZMZERYMFR1MmJxS3VVRnJsRFNrN2Y5SUhTZG44aXdWMzlxalBuRTQzZVZp?=
 =?utf-8?B?K1M1UDAzNjI5bHhId3Vhd1dyUkk4NjlhWnI4bDYzVGhCdFc3ME1aSjZWZkFN?=
 =?utf-8?B?cDVyamZod1pGcEorMXh4VVdPUjA2VEdNQzlrK3R5c0RGSWFyY1JBaVFyLzla?=
 =?utf-8?B?R3NpQ2IwOVVDZFBoYlFFUDFIaXA1WWhWY1N5WlRhYklIVmJhL0dlSzJWa28v?=
 =?utf-8?B?TmNMTjBmRy9iMldxZGY4K3lEazdCUEhHTVJRM2Q5d3dZWllhWU1mQmpNVDNR?=
 =?utf-8?B?dElhUmd4ZWRFcmtMa1Y4a1VHcG1NKy9QdVRSSHdDMzZpRkNZOEVuc3lSdVFP?=
 =?utf-8?B?VkZ5a1liTldMZ2kvKzRldHdFalpaTGcyNmdFK1BRY2p2VmlxMkFRUERkV056?=
 =?utf-8?B?QWQxYng5NFc3Y0dSWGpCaEFweW1TZnFJT1JETGNGT3BWemljdWE5VnhGT0ls?=
 =?utf-8?B?Z01LcElURzBlTGtoR1F0N2xHVWhwejh1YTZvNXZ4K3lJdUdONVdZREpXVzcv?=
 =?utf-8?B?ZzNKNVVFVlFhcURXYnpiZVdZQ3JJVytrM2FYb3JYVXorczRXVWhXUWJaYlFM?=
 =?utf-8?B?akJlTHdzOE5lSm1IdURxNTRXMmdTWG9CaFcvMTllQzBkZU1hRVJtWC82UGZ4?=
 =?utf-8?B?SXJBNTUwTjloWU02eWpoSGhSN2cycjBYNHdSd25hNlpDQkVTUElCMVcrOExT?=
 =?utf-8?Q?qycuRSCnPivow4zHKG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0959365-933f-46cc-3157-08dede8cb14a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:08:18.7813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/WLG0D6NuSnBwYHeAYEfyd+ioTVJFiZxyLV7z46Dyf9Qconb3ocm47sIM83MRRjFnltBskA86dRMjCg9O/trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

--------------2FDucAJaVGVaJHxWv1cdtx3f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/2026 9:57 PM, Dan Carpenter wrote:

> On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
>> On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:
>>
>>> debugfs is intended for debugging only, and failures to create debugfs
>>> entries should not affect normal operation.
>>>
>>> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
>>> If debugfs entries cannot be created, continue without them instead of
>>> reporting an unnecessary error.
>>>
>>> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>> index 02673f01b448..7c5bc9c4559a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
>>>  		entry->proc_dentry = debugfs_create_dir(name,
>>>  							primary_entry->proc_dentry);
>>>  	}
>>> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
>>> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
>>> -		goto err_free_entry;
>>> -	}
>> We need this check because debugfs_create_dir() may fail.
>> Removing this check leads to entry leaking when fail.
>>
> Debugfs functions aren't supposed to be checked.  Drivers aren't
> supposed to rely on debugfs so it's not required.  If debugfs is
> failing then you are pretty much screwed anyway.
>
> I have a blog about the history of this:
> https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/
>
> This code is inside #if defined(CONFIG_DEBUG_FS) so the check
> isn't harmful except that it sets a bad example.  Back in the day,
> this used to be a source of pain for me so Greg made it hard to
> write a correct check unless you have the #ifdef.  It's to
> discourage checking.

Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?

Thanks
Lingshan

>
> regards,
> dan carpenter
>
--------------2FDucAJaVGVaJHxWv1cdtx3f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/10/2026 9:57 PM, Dan Carpenter wrote:</pre>
    <blockquote type="cite" cite="mid:alD6PcLowqjVBnSl@stanley.mountain">
      <pre wrap="" class="moz-quote-pre">On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">debugfs is intended for debugging only, and failures to create debugfs
entries should not affect normal operation.

Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
If debugfs entries cannot be created, continue without them instead of
reporting an unnecessary error.

Fixes: 22ab1bb3994a (&quot;amdkfd: expose pasid of secondary contexts by debugfs&quot;)
Reported-by: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:error27@gmail.com">&lt;error27@gmail.com&gt;</a>
Cc: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 02673f01b448..7c5bc9c4559a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
 		entry-&gt;proc_dentry = debugfs_create_dir(name,
 							primary_entry-&gt;proc_dentry);
 	}
-	if (IS_ERR_OR_NULL(entry-&gt;proc_dentry)) {
-		ret = entry-&gt;proc_dentry ? PTR_ERR(entry-&gt;proc_dentry) : -ENOMEM;
-		goto err_free_entry;
-	}
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We need this check because debugfs_create_dir() may fail.
Removing this check leads to entry leaking when fail.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Debugfs functions aren't supposed to be checked.  Drivers aren't
supposed to rely on debugfs so it's not required.  If debugfs is
failing then you are pretty much screwed anyway.

I have a blog about the history of this:
<a class="moz-txt-link-freetext" href="https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/">https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/</a>

This code is inside #if defined(CONFIG_DEBUG_FS) so the check
isn't harmful except that it sets a bad example.  Back in the day,
this used to be a source of pain for me so Greg made it hard to
write a correct check unless you have the #ifdef.  It's to
discourage checking.</pre>
    </blockquote>
    <pre>Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?</pre>
    <pre>Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:alD6PcLowqjVBnSl@stanley.mountain">
      <pre wrap="" class="moz-quote-pre">

regards,
dan carpenter

</pre>
    </blockquote>
  </body>
</html>

--------------2FDucAJaVGVaJHxWv1cdtx3f--
