Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D14C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 14:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9F110E1D1;
	Fri, 10 Jul 2026 14:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeGHv30c";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B2D10E1D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 14:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/PQoykqU4UzfiNC8hsPQVW+j7Tt3XhiW9u6aN1awZ9RXobn4A3CZQuaRUzTpC/k4lPOMwPssGvRBEHx+iT/aNSRVmXZ2LzPGyM2MLOPApfmOx3uhMe36j4Th5gQo87Vy+kvNMj6C28moLvtw9tmEzOH1+drUop5CK9UcEzAb6MgVpfhAOwXL2VTX2n9TEKHm36gBnJ2f7S44JitWKgMAc2tyxi8YDwQiveM6wLLUfJ2U8yn0G+fthZad1ZLGWLX7ZiYojvYK7PmeQiUeIMyenOf0DrZzfU344Pm7Fwb5n2QM/PoQxsrdC2/SU8FuZ1FWgKGIlXGTbzvKNYv0n5qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzzrh6N++p9a75MRe03mjj8TH4ZK8Ir4ixUh3UvemlY=;
 b=q4q10qS0h3B7f1w6UJ5ElW7BQy0nCeElo3DpB6Tauq2kHvtz5A6J91fpw9IqfIL3U4DqKTtpAUi8h2t1S7F7SA05vsJ6Riju5Sy4URFErz+gRw9wE//qpyqIpH+EtYB0WIcffmPyUAxM8SSKdN8IXekY5iXPzKDZyK8bQNJFF4tSzcUUye0NOiVEZ2hWtUGG7Tyv2fUbk4N/qa4sXZ+fTu9D3cPovNOd0Fora1fQS5tun4TbxFj8hDwVqZgBdt4aEnCm0EG1E0LwLVS+Vjh2ZNT4mCpblMmdZiJ66usYN0lcJLAopAW6Uphb+vQ4rEeWNX4Y1+jSQkgSvDX0LA8OxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzzrh6N++p9a75MRe03mjj8TH4ZK8Ir4ixUh3UvemlY=;
 b=XeGHv30cLngNwCNUqz4eKJaXLwWMXTW5ykt8QTJS09aQYfnDCzfxBfLhpvbu3Qhx5UaMi6cKS6XaFXvwgnHyg7oWGQdVxS1vXIpLtMjEmRrW+iN/ih36tqtlCFG8E57FRn1yOLVGKbOKBENQ2vVk5DumA8U9bFPGSKVG1P3/Xro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Fri, 10 Jul 2026 14:42:54 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 14:42:53 +0000
Content-Type: multipart/alternative;
 boundary="------------vzU4FoZvf703irwevX02JiEA"
Message-ID: <7e7ba62c-93c5-4e5b-b123-db7c4c2d9f77@amd.com>
Date: Fri, 10 Jul 2026 22:42:45 +0800
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
 <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
 <alD9y0YBjo5_pJnh@stanley.mountain>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <alD9y0YBjo5_pJnh@stanley.mountain>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d320db-922b-4f7e-4fbb-08dede91861e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|13003099007|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: /AUPrvGwCslGJfzEIU4+jTOn9CbB9Wh0RGzMDaYkscLuh1l7jh5lPBtuSAkwwUPjXZUtJkEcrnCZSnnxHfKOLPevehvqzJh4M2xISJwtACUGhK7iQhHwldG8mBPEqCp7wwZDIp1ZwuJBdtDprFT24vIdD+ROC+3p9XB3w2IDg803OxmcscfOyDixrdSxdlxeoUjPc8LRbVSBLYCOUuqR1fdP3N6Wi/hDFC3L6kdqaCGmfpNlXjkKOVi9MHHM67zrX8kw1wKQFeKvMdKpWWhe4DlVJ7btETjOUubpdOJG/9PTfeu657sXlipxrINvDc6AZEJnhmsQeQSwRnqPIRc0ulFXYwbycCSdw/EsVmztdvwi97dDs2sViBAVMrg4Lt9VBawvc9bxNGfTCeWPyV5GNqg310QqYny9OfeflX7TkuPobRyFN6gYRFcO7V0PhpvTD5uk+/Bu9fGdaO0YEv9LKptlbbCbQjdZ15LLoNhHywFLQCgXEyb0l8qhflciczBRYuwwqirbS0vcM+tNJrBmQABLTjy1swV6ypo/GNe8mQ4lzRNoKzTnh9qZxfyA+Wi3YmAWfN/7dMXwzE89iXXaJXVA7oTNeDDSY3VJ+ehJApemi0Ug/WodAZDIBmLDtIO2UL89xtubuStBzslpLDe6+bkJiE73YcK6U0cR/HT0P6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(13003099007)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9zTUs5dEk1OHU0ZGo1dVZxSzhqeCtyUVlrb3BGL3hXRmpiVVpKNWRHc29k?=
 =?utf-8?B?MG5ZT3lWbG4rQmNrSVlwNkFVWTBFMnc2ZXFicXFxbEY2NmtiSmR6SzRPVVhD?=
 =?utf-8?B?SXp4b0E3KysyK2pFTDkyTWRMMzRGTElsZ1hDc055ZDBCL2RFUDZtcGd0UjBC?=
 =?utf-8?B?WXFlbkJzUXIrNjdoY3F0Z0YrNGI0ZVJacXl2VDc4bElxcWYvM3pMMCsvbmli?=
 =?utf-8?B?enlqbTg4VjFKSUVtUHJwZFZxNVQxUjgxeXBVU1ZzTm53TXp4dHc0U3Z2RFBW?=
 =?utf-8?B?Y3Zpcy9Zb3pEWlJjN004czc0WXN4cHBtcVA4S3pTbXlsVGNDdWh6NDB3NDBh?=
 =?utf-8?B?VmVlaEE3M0IvSkNsRWw5SVpQb0dFN1FDQTBpcE01cmJpNFZlR0dOU2t4bEhx?=
 =?utf-8?B?VnkrR0NnSXRtcnMzWmRFcUpISzlWWHd1clpUdnRKNjFPdWk2OVd3UUF4YWw2?=
 =?utf-8?B?Q0J6UWEyODM0RU04ZjRySnRDM0ludXlUaTB3eERRT245MHpONGZQNHNRZ1Q4?=
 =?utf-8?B?Skt5cVBKVU1FOTFkZTZ4Y2FIeEFaWWJNLzF1VFMwc01sU0M2NmwzdXpkL2Ix?=
 =?utf-8?B?dGpkdGZZWGFlRUx6MG1QZllpZnl3TzZhWTh0dUNUdGRyR2h1SjI1dExrUytp?=
 =?utf-8?B?T25naE4xblcxQjNZSFNMYVRjOXhCL3hWa1dETGZLVUJiR3FnK2VVUmUrRkFI?=
 =?utf-8?B?Y3IwM2lEdGF0c2FneVJLT3RvZGt4cXZQMHBsT0JqTVRUYUpIbDFMSUhSb0Nz?=
 =?utf-8?B?d3BnaktNcHg5dmFxUzJJVnVmM1FGMmRQYm5tYkN1cThySDVWeUI3TDRQMDJr?=
 =?utf-8?B?ei9PRDlSeDJNN001My81VHJURnV3SFczTFA3T2hNMTRSZXB1YmFscjVDbmVm?=
 =?utf-8?B?cUhRUytFSGFLdS9hbWtOUXhsN2RxaUVvaTVZME1tZ3ZGZkNPKzBmSFRBc3Nr?=
 =?utf-8?B?ZjZTcnpnSm94WTJXQlN1U0NVL3pYQW5RVUJIZXB4b3JheTJXV1NOYWpMSTNK?=
 =?utf-8?B?enRYVXBGdXJCZi81L0QrMUJYQW9YNUlRVitRdDdWaVNFUDRIMmt6YnNwSmZV?=
 =?utf-8?B?L2JqMEI1aW96c2pYamJKb2JmSHpFUlhIbU9wMWdKd2h6U0VFREIyYkNwTWZj?=
 =?utf-8?B?ZFpja1h1NXRiN2lOdWx4RGVXQk8zRzFTTThSYkZmelNGMjBKb3lmYWZPaElD?=
 =?utf-8?B?bHdRVUpYSy9WSzBxSUJTNkNlRTViLzg0N0M5OHIwTXI3QTJqbDFVc3NWOWZy?=
 =?utf-8?B?RlFPVm9YaWdNS3RWSmVid0ZYQklYQk9YSEZubjNqZzNQakhBbVlxMFM2Rjgr?=
 =?utf-8?B?THo3TkRTekRnZ2I2Rys1eXJFOVNUMVdURXNuanB2ZmRoQXBFT1Z1ZnRtcUsv?=
 =?utf-8?B?YStYWUlYNUZuZXRDeGEySEJ4RFRmWENMb1UrZzhyN0VWc0tMWUJoL3hzWnA4?=
 =?utf-8?B?YVFyUlNhelVCRXZsbk5ETEtpZm10VkorSTdCbU5TcHFZd29CRlpyQ3N0bG9r?=
 =?utf-8?B?YUpRem5LMTQ5Y283MFBockJablhuQ3JwaE5wM2dKa2VpeFlFY1BYSkVodnNC?=
 =?utf-8?B?SjlOM1U0UjdxNzdETjcxMzhQSFN4U1pCM0VMOTZwL25TNXk1b0hJK1RsT3VH?=
 =?utf-8?B?Z3VHY0FNd0Mybk9FZlVrakt2QTVaY2xpLy80L3UwZzV0NGZURVdIVFpGSlFn?=
 =?utf-8?B?N0hnOXcxUzQ1cnVuTEVIbG1aeEpzeGdZcmJZRUlXbFdqUUNwSHFFVVUxZnR6?=
 =?utf-8?B?VkhLemUrWS9YbGdxcHl3QUFiL0ljamEwQStwTjJ5VE5xamNzcyszTlB3ODRz?=
 =?utf-8?B?bGJhRVFVRTJnbWVZRjFaYlYrWlBNV3RuV3I3eVlOOXQvdTFvWHNOSFE5R05n?=
 =?utf-8?B?RnRaV3AyZ2Q4WWo5MndMdE5YRFBuam93RWMyS3lDRlJnVnZVTmVRUjN1azU4?=
 =?utf-8?B?MThvWklUenE0QUxhRnNaUm1yajRRRUp1OFNaaFFySE1nWHNIMjgzN0JEem13?=
 =?utf-8?B?MnZ5YW4xMDAvWWtCbHRmWUM1VjJnT1BKZU1lNkNXN2JDcTMzakxZNmVkZUpl?=
 =?utf-8?B?SXUrQ1VZZDJvaUxsZFNMb0VyR2ZISm45ZmtISDQ2ZDFqVHVCTjZ6ajhYK1E0?=
 =?utf-8?B?dVYydDJpcDZTNFprTFhqL09oam1wTWZtVjB2c000cFNXcE9FS3JXYW5YYThm?=
 =?utf-8?B?NGswYW5MZm5SKzYvNjR5cHpwbXFNNnBMQnp5RE9ER043VERURmlORmJhOEYr?=
 =?utf-8?B?L1ZsY2RhVytOMTRscnEwU3U5TVhmME45alhpQ3dzQUo0dnZubjNiQkdaTzdw?=
 =?utf-8?Q?0jL/+PXyyA4P5cRViV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d320db-922b-4f7e-4fbb-08dede91861e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:42:53.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srR7jraR1gP3wIy7wqdG7iCjSI7C6o0gV/R1z/npI6RQSP0uvJIS1NgKDL0uB8hPtl4YCzfsoqUaxgs2QjD7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

--------------vzU4FoZvf703irwevX02JiEA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/2026 10:12 PM, Dan Carpenter wrote:

> On Fri, Jul 10, 2026 at 10:08:11PM +0800, Zhu, Lingshan wrote:
>> On 7/10/2026 9:57 PM, Dan Carpenter wrote:
>>
>>> On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
>>>> On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:
>>>>
>>>>> debugfs is intended for debugging only, and failures to create debugfs
>>>>> entries should not affect normal operation.
>>>>>
>>>>> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
>>>>> If debugfs entries cannot be created, continue without them instead of
>>>>> reporting an unnecessary error.
>>>>>
>>>>> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
>>>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>>>> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>>> index 02673f01b448..7c5bc9c4559a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>>> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
>>>>>  		entry->proc_dentry = debugfs_create_dir(name,
>>>>>  							primary_entry->proc_dentry);
>>>>>  	}
>>>>> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
>>>>> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
>>>>> -		goto err_free_entry;
>>>>> -	}
>>>> We need this check because debugfs_create_dir() may fail.
>>>> Removing this check leads to entry leaking when fail.
>>>>
>>> Debugfs functions aren't supposed to be checked.  Drivers aren't
>>> supposed to rely on debugfs so it's not required.  If debugfs is
>>> failing then you are pretty much screwed anyway.
>>>
>>> I have a blog about the history of this:
>>> https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/
>>>
>>> This code is inside #if defined(CONFIG_DEBUG_FS) so the check
>>> isn't harmful except that it sets a bad example.  Back in the day,
>>> this used to be a source of pain for me so Greg made it hard to
>>> write a correct check unless you have the #ifdef.  It's to
>>> discourage checking.
>> Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?
> We just don't worry about it.  If that happens, you probably are going
> to need to do a kernel upgrade or replace your ram or something.  A
> small leak is the least of your worries.
>
> This is the answer that Greg told me back in the day.

Thanks Dan for the information!

>
> regards,
> dan carpenter
>
--------------vzU4FoZvf703irwevX02JiEA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/10/2026 10:12 PM, Dan Carpenter wrote:</pre>
    <blockquote type="cite" cite="mid:alD9y0YBjo5_pJnh@stanley.mountain">
      <pre wrap="" class="moz-quote-pre">On Fri, Jul 10, 2026 at 10:08:11PM +0800, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 7/10/2026 9:57 PM, Dan Carpenter wrote:

</pre>
        <blockquote type="cite">
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
            <pre wrap="" class="moz-quote-pre">We need this check because debugfs_create_dir() may fail.
Removing this check leads to entry leaking when fail.

</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Debugfs functions aren't supposed to be checked.  Drivers aren't
supposed to rely on debugfs so it's not required.  If debugfs is
failing then you are pretty much screwed anyway.

I have a blog about the history of this:
<a class="moz-txt-link-freetext" href="https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/">https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/</a>

This code is inside #if defined(CONFIG_DEBUG_FS) so the check
isn't harmful except that it sets a bad example.  Back in the day,
this used to be a source of pain for me so Greg made it hard to
write a correct check unless you have the #ifdef.  It's to
discourage checking.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We just don't worry about it.  If that happens, you probably are going
to need to do a kernel upgrade or replace your ram or something.  A
small leak is the least of your worries.

This is the answer that Greg told me back in the day.</pre>
    </blockquote>
    <pre>Thanks Dan for the information!</pre>
    <blockquote type="cite" cite="mid:alD9y0YBjo5_pJnh@stanley.mountain">
      <pre wrap="" class="moz-quote-pre">

regards,
dan carpenter

</pre>
    </blockquote>
  </body>
</html>

--------------vzU4FoZvf703irwevX02JiEA--
