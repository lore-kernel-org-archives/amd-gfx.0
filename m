Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C30C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 14:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B3E10E1D6;
	Fri, 10 Jul 2026 14:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wv/6zeZW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC010E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 14:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2eshj/bMLbsbBpIMFDpqSASNKcJtegUOcCd3QZrHNKrBBn/UHJ3/8vjIujNqxRwptZGEOC0zlliCCsh6hyBDkz2N+BcclBoo06LIwGhAz8YgAAgDMPrQ01yr1+7/UC8E/x7cKujB0zf9NDJGJZJpJ5xrR3jRsTnTAzphoEPSc9U4GMS+VmgPOEmZHYuqUCY9FweErNFb3eWpDz628qlG9I/9MzIygOWR7wE/grAz3COWp5pXtrKzM/oxwrrO6crNna/HXmbmEBr1zuFxB4Yjbitp2Jwln1EE08qWgD89O9s3aM/gtm8WmXjSK4css5+koijMKZRAUlK27xYngziwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xmTZFRK2H9enKO+855ze7PowR7uQX/PrznwyRLgkmA=;
 b=BsOwUzxx8FxHmyZFFivdl1nNX4/uJ3KbEPQ5K8jHnQrW3Slbuzv8NEkQDomj5EgEagFRjF2fLi/jA9AdMSNz6c8CrU/hQ6n5M0AaIK9FFeFF6sCFUFs/lufILdVkv6cCdUZMfqx/qNhZukYO94ZmsY50AFJk1FGHRx+U2KD7uE1FVdOdFByI2UDQxTwkZxTlWp7QJl9fUTUDFIHioxeWX6XCwn6sYcicISkMmXFp3Mg28PB2FYa2YnSsVV9i+ZoRsIj6+F/ydxfHKZ9JEvQlVcY2Yicz8afg+IkRKoHG8Jhg5yg+P+ezQjwPHS4v9qgm0cUDtz1NtN+0Vaj/EVjn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xmTZFRK2H9enKO+855ze7PowR7uQX/PrznwyRLgkmA=;
 b=wv/6zeZWWfgEXmHxgHVXiuC8ovcxY9Nv4AXIx8fYfDwKaLLHXdTHcAkCDnW9bGBNZHYdxjBl7Hq61irLwYUsQ9ZBStAn1t10xVZLpn3nwoSkv2WUpJ67xL2DxkF0Mww0k0NlYJOQzcjgvBj/aUXN2bn2N334CDNoVy+O+r7mkI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 14:45:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 14:45:44 +0000
Message-ID: <40d5345b-265d-4d27-9df8-c7f82cd95425@amd.com>
Date: Fri, 10 Jul 2026 16:45:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Dan Carpenter <error27@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
 <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
 <alD6PcLowqjVBnSl@stanley.mountain>
 <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a44c0a8c-e3b1-4013-8a36-4fa3f44d023d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: fa01059a-d3d6-4192-29f6-08dede91ebd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KvfXD5rnjCojg2h4awvRryWLIvZ0yDMV1/JistOHdO8rOwNpOSaHzd/p0+SuyC5pPi2UxgKYAz5HWDUOzTmE/XwcQe5wKuVLOAoS3Ys7eJoSCEcPrSxlWLTo11QQh8nZ0M6D3geiwIgvZoZiQSLfXH8y0H0ogOF8lCxG5f4C7q/DgkrxxFbEo1gk3OOrXSVgN8/hHXVln0xKLECnhvfZePaTszry0q+DVVKnEUh7P9kFyAnBkLBRi4ilJKRr/vLQc4GQfIbMMfbUaeLGRrT4+J5zMXy+rLLHK/mZrr3NoDHXajH8uPvDm0L3tjxfeMO7NyzXOzJWo3fb34YASYN3lyXkA28qsiP45/8xDdv3F4nNDcbeIt+nQ1JEg1/FgfketsPmtAwPmrUjxA0EG5QOfTLiiBGhTVZRHYjgbpk9SpM3ekPv7D2m0DNHaksZCLxVEPPp2J4LXxCS+rXce6hXb2Yp5oBZL0ksWBJMVwSzy6pMwgJ4N9csoo5nruc5RLRwBy8hT8ddRRhbDdziOwC47RYo5Zp8ZBxMtPfPuIEJcq1WxTctZsMRcOCe+Lng08dhG5bj4i24PQdTQlcMdDibtgBY+m6/AcWpfv26mXc2kSEWQLKVEVflaGILNvAe7exYreeExR9k21D6D3s81n/65byyTE88fGeUVLZ1Iwi/+S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU14ZDNlN3hxdWNhdjNNTTlaamU4c2NyMG5DSzdCRDY4ZUMxYnYvbklOa3l5?=
 =?utf-8?B?SWtQdm1uaXFXNjlGSDBZRVdnL2ZJMG54Tm4wVUJqVlpiV1JDM1VHNTM3Z2VY?=
 =?utf-8?B?eERiaThFelNGanZGVU04MzRzNXFPaTdqNnA2SnZaSzdDN3grWFBEeVd5VHdp?=
 =?utf-8?B?SHp4TEZKaVN0eDU2NVlKbXZ0NjhJZUF5dVBRUXpCUFR6cWZFaE9mYW1wUFN4?=
 =?utf-8?B?eDVQVC8zUlhLK3gzVVVSNlRxMHJLK01YNnlrYlpJQ1JXMWlQODJzRGNMRHBH?=
 =?utf-8?B?RUVjM3pwZW15K21DKzd1cFFZRWhXZ0VMY21HdzVyZUZ1WUJ4Z0gxYzhmOHB3?=
 =?utf-8?B?UUd4eThFQ2ZMYTJnVWE4ckNYakhuQWJTQ3M5cG5UbFlMT2F6V2tsT3o4d0xM?=
 =?utf-8?B?NWVIWC9XeUtuclBoOFh5blpIWDA2WTEvaUFYTGV6NGI0ckd0ZUJQMnlGMEQr?=
 =?utf-8?B?T0ZqMFZTOGE0blpJcjEzWGdlSU51bmN6RjdHeHF2cFlQaldQT04xZCt4QnFo?=
 =?utf-8?B?OE5nOXVOWVpLN2doMEo4WTRieHViUE1CeTdHWmluYmE5a085ak9VbEtlVUI2?=
 =?utf-8?B?elp5OEp2SUcwSlRiaUs4R3dNREdPSERsUkQxMXdsd1JxNi9RY0ZtK2NDZmJQ?=
 =?utf-8?B?U0dxRXBTMjVUMjRQZUhtaTVoT052UWpqd25xQzBvM1JtNStXMnBlZGpxa0p6?=
 =?utf-8?B?RnhWeXBvd2lsMWJMKzE4cjJiL21nU1ZOSDd3ZHByVjRTUVBUOElrNXBydDJs?=
 =?utf-8?B?S2g0ZXdYOTMxQ2E1QmwxQzZDRllhYXlwdy90N2Foc2pTSXZyRkdyZDZtcjVw?=
 =?utf-8?B?SjJWbVAxV3pLV0lwU3lPTjYybjJycEdiWklZUDJMVm8zZU5scXpONlQydURr?=
 =?utf-8?B?bU9mNkJObUQvY0J5WVhpZ2piMkN1WENGMW9tVGRzQmRmWFVlNXluQnozWkc2?=
 =?utf-8?B?S0w2OWZ2Nzh5QUVUMkszR3oycThkRXYvRnJ6K3RHKzJVaUFQRFBIZjV1Nkh6?=
 =?utf-8?B?emdHczNpTzFqMStqbSsvVThlMXJlaVpGVGd5M3MzdjhTeWxOYnRPQWkxaTR1?=
 =?utf-8?B?bGtYOGJ4Zk5PUjk4dGZxVWt0aGViakJKRnpSUXF4elF2bStZYTZHR1NOcTQw?=
 =?utf-8?B?em0rM1ViOE5MOFc4SGpEMmNLdXdBUWx0Mk5KcFlTNk9HVlRNZTFnS2ZQVGtt?=
 =?utf-8?B?VWpGUWphc1YzOHB2NXd6clZzcGlTWEIrZHpiK0llZ1VwUWtPazBqK2hzakV0?=
 =?utf-8?B?eUwycW1Qdmw2UEtXdEhEbC82cVdEQzRTQ3RmMWN1U3F4UmtxSWtCSk1Ja1Bv?=
 =?utf-8?B?bEM2dm12NWpYZnNEL25PSkI2ZUw1NHFkczVCTitoRnpIaGttbkZLK2o5NlNn?=
 =?utf-8?B?VGp1bzk4MWNvaERiWGc0OFJSTzhUbUZBQ21WZEFVazJkUWRkWTdZZFBXTzZQ?=
 =?utf-8?B?MFd0Mlh0aitQY0NUV0hkcGJxOUs2dGhCdDVocE5WVjdlZXhGdFJKVWVGQmxW?=
 =?utf-8?B?YXlDTGJLa2g4dHo0Sy9idDdUb2NIcHljeUJEbW9FNk1TbzBiOEtoTDlYRldv?=
 =?utf-8?B?NEx4eDgwY2QwaC94RjJZWXRRR29iaUNldXlmZ0NZdTAydUR3cHV1bW4vVjJ4?=
 =?utf-8?B?eW5lejBhempCNzRtZkFyVUNBUVNKdG1WN3NrL0orMTNhSk0ycy9LYmNTNUJq?=
 =?utf-8?B?UmRCSjgyMUJuZyt2SWpJYy95bEExVUtQdmsrUHFYZkRtOUx0RDN4bVVpdENt?=
 =?utf-8?B?ZVpyaTg3VmRMM3N1a2dYZEpWQnk5OE55Z2kvNHJFOUp0S3dPUUx6OVVkc3BE?=
 =?utf-8?B?TzJNaEk3dUVUeXV2WGIwNTVkZnZhOWI4Z1VMaGpLVlJ2V0JteGtjcE1YbGsy?=
 =?utf-8?B?Nm4wNDlPSzZmTktBUWx4K2VmeUZaVmlNR2tiVVdoQnRqSXZ4aFlraUoyMVBO?=
 =?utf-8?B?T2pORmpEb05pckZxdzBzaVpsZGdRQ3RUWHNRR3c5QlNRTGVqTXRtaGdsRFJQ?=
 =?utf-8?B?eEJEQngrSmpjNndZNmd4Mk9DK1dlazNiY2ZjTUZOTTNBL1UyWkN3RDVjRU1D?=
 =?utf-8?B?R3hOZ3Z1WmlWbU5pT0JTR0x5TThXNWk2cVNkSWE3eGRSeGV6SXFsY3FMVE5H?=
 =?utf-8?B?OVYrU0RtZ3RSVkFCakh0aXYwN3NVMFRSNC9WaWVHWTcrL2NmZXZNdEZXeCtj?=
 =?utf-8?B?MkIyUWI1dGRzemdicG1NWE9WRngzbVE1NnErL0FEQnM5QjVETWx4V2NOUGQw?=
 =?utf-8?B?MnpFaTlyZUFQMjVveWtqUFJ6dGZhdVZDTzhGRE16eG1tY3pWV0FvRTFxWGVh?=
 =?utf-8?Q?aqtUjSafqqtfUBlV0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa01059a-d3d6-4192-29f6-08dede91ebd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:45:44.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQwS+kN6/4l4bJGvGw/7tCDtoMlw5RCwcpWXDBw7/A2Q/OrU+RWjsJc31Jja/XTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

On 7/10/26 16:08, Zhu, Lingshan wrote:
> On 7/10/2026 9:57 PM, Dan Carpenter wrote:
> 
>> On Fri, Jul 10, 2026 at 09:47:32PM +0800, Zhu, Lingshan wrote:
>>> On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:
>>>
>>>> debugfs is intended for debugging only, and failures to create debugfs
>>>> entries should not affect normal operation.
>>>>
>>>> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
>>>> If debugfs entries cannot be created, continue without them instead of
>>>> reporting an unnecessary error.
>>>>
>>>> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
>>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>>> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
>>>>  1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>> index 02673f01b448..7c5bc9c4559a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>>>> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
>>>>  		entry->proc_dentry = debugfs_create_dir(name,
>>>>  							primary_entry->proc_dentry);
>>>>  	}
>>>> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
>>>> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
>>>> -		goto err_free_entry;
>>>> -	}
>>> We need this check because debugfs_create_dir() may fail.
>>> Removing this check leads to entry leaking when fail.
>>>
>> Debugfs functions aren't supposed to be checked.  Drivers aren't
>> supposed to rely on debugfs so it's not required.  If debugfs is
>> failing then you are pretty much screwed anyway.
>>
>> I have a blog about the history of this:
>> https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/
>>
>> This code is inside #if defined(CONFIG_DEBUG_FS) so the check
>> isn't harmful except that it sets a bad example.  Back in the day,
>> this used to be a source of pain for me so Greg made it hard to
>> write a correct check unless you have the #ifdef.  It's to
>> discourage checking.
> 
> Thanks Dan for the background, then how do we prevent the entry leaking if we do not check debugfs_create_dir?

As far as I can see you don't need to. When debugfs_create_dir() fails all following entry creation fails as well.

Or what exactly is the use case here?

Regards,
Christian.

> 
> Thanks
> Lingshan
> 
>> regards,
>> dan carpenter
>>

