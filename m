Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6711CEC144C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 14:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032E710E81C;
	Tue,  3 Mar 2026 14:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RrTsWrdx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CBE10E826
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 14:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyeq62PmTtgdslmfTxxe+kQUQ3xGZRo9a4SBN0pFUMBiaO/RgwHWyU0om0tS9Y0YeqY09qPudfGSV6ntoU1sGEqtNETwuNiTJGTWE4zt5lblc21vEeWA5UqwlcIwthPtkAmVuQ60+dM2MThwg60hiRZjHXuGVjogZo3kogcKiaAXB9kmTFMnJjSS0ptgQAHzLP+rBorqzQH5lrOvEGnzGVS10yZJ4xnxO30Rmm2scAeMRvxPULSzHOPfaJAL0yOu4ybCoo54dgdKXbnXILT+4ORkZ/zNw4bhSCzznnIcy+vSWOqZM6PlhFEEuIrW+cCrgNTR1xQNej/K3tiuSapBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUAsLB+9i95Gfl727tpe6daiDQ9V1Jqp6A+hHLXA9AU=;
 b=i/WToEUEJpp8IvJK3suOY6E3IkxHrawOgyGi15vBWEnDNDeodkzqvmCVpfRM1Sb4b9RLHueEzXAZ4mqGcMsqmuVLxNDXd0pCcGiYASwViyARLyXMzBkpmz+o//Q9L4Io8S8MuuINiuX+quTd+5NEKrrZCyMQJHt/MBgoHPL8CEIjTjrwdwM1kkMc6GIOhqvSl2sXFEVB/LxgKOrXAAM4ETp7+NiJLC7Yvyg+4kYb2ZVwM5klo6UhSiUEmXdGS6RCjKiIcNOp2PCCQIVVXVfLXrfbBCBPgwOEh1wa/xf39TmgHPRcTp7ljbl9kZrMp0iebqpjzSsztLImoCZjdQUSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUAsLB+9i95Gfl727tpe6daiDQ9V1Jqp6A+hHLXA9AU=;
 b=RrTsWrdx2rwtfN54BYtIEQbBvy8wJ7/94kF115XxuflDBwWLWk/x3lKg3T5Gc4U01vatsatX412O/WyKCiCT6IiR542a4M3KvOdclDcNS1uqqSKFXiyQebqygf+qGqSsRsgKtTCLBOkJsuQTY34agnE28i1qvJO8C/0zDPqHL6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:06:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:06:19 +0000
Message-ID: <e7b07f6f-c90c-4b78-910e-860c36280ced@amd.com>
Date: Tue, 3 Mar 2026 15:06:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303120654.2582995-1-sunil.khatri@amd.com>
 <38ec1a98-d112-4345-9711-d023a3e10da9@amd.com>
 <aeafbd1a-49a4-4049-8523-b29f78344fd3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aeafbd1a-49a4-4049-8523-b29f78344fd3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0908.namprd03.prod.outlook.com
 (2603:10b6:408:107::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2f3bea-e223-42c9-d80b-08de792e0a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: DoyQxXJko0aN2RfuTF36uz52ZWF9l/fnMDnPhkmF8knKrSVH3cvxN31T2DTRh2/dUUDankc6oRUfMhvd1Pq0HskP2rsmZKLkBpF0QhK4OaF6wFLsoRcWb3CRKh8PZvOuXVtgKvn0ORL1+OI5awJsClo75PbcuoQRDT1qWekWGk/JdjLFUH9PL2HvKoI/u0SMuzxTQpzs+koNOq07T+5cmo4j2ial9ygp6DknOCxqUQDqjYdEyOlAOQ96ysqs8F1HkYm9wTXmT1Rfrw5fwPhT8iovBCnewZPztplJUHVOeslwkBMT5Ps/tR6RaWUS6z1R0Pxy/Tcanhvim0RZgC1c/NYwt+Y5auJqGLd1O+USeXeN0FbSPiXUfxsKLz4BM4geHMgwXc/2xWl+ftMUb2Ev2BlHj/Hg8MyiAKhXTNZQubzEWu0ZpjOv+yP2/IPsOQfnWRluE86IwsUMl67hQ8RAElP8EpsspeTSye6/QnJ3UeykKMXzVOrFqPO8FfCJ+KO3EGyxh2oTqtGJG/VmZlpZNpmEeN/ce9D5nSRhBiljtl7hs2ZoThneWGppzY9T+Mc1MPL/igLSTKItm/F5z9CFxXzLJ/SRVHEi4CtDUaehK1sm5qp6dgiporppAqRg8Wq+RcceIhXHc6IuEiJB4OIaCcQjnoUw3JTWDkQrbGh1NGfacGGWrjOqpQV6UJZWF2szu7J5v3uq/mZgZbMu3HSD4Ik2UOTQrG/7B9FzS5mKuzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNRQlBrZWpIaEdVc0dwS1ozUUpmN1g3d0M2N3k1WFFvVzNmVVhCZHBzRHlH?=
 =?utf-8?B?TFBrd2F4Y016NnN1Z3ZzUVVQeG4rM2cxZU1hYmZGOUxSdHlXNDdjUWxud3px?=
 =?utf-8?B?WlJzdFZiNW1VY1ZDZk5RTmdtSW1GWktjYkNESkFmOXNOanYyT3Mrb0Y1OStO?=
 =?utf-8?B?Z0pUNTc1SzJ0WFlZcHpEWFdLaW9RUE9BMTBvTFNkeUpIZEZQN0gzdXBWbkdC?=
 =?utf-8?B?WE9WZVZuOW1QZ3ViMDhrTWgyTm1KM0JrVGZWWi9tbGFEdllaQzhnZ3M5d3lK?=
 =?utf-8?B?RDNsVjYzYnpQZm5hYWRHWWx2ZFg1dDRKTGRmanhxRXRqMEo1MnJGYUFSbEhL?=
 =?utf-8?B?Vy9Ta29kRzd2MVBmZ3NSak1KKzFoYm1WS3N3T1BUZzZyR1Vlc1h4N3hFVFBC?=
 =?utf-8?B?YlQxdEJ4ejRvUVcrbXZRaGwyakZXb0NEVzdNWHFZWEhYUURsbFVnYmt1dW1n?=
 =?utf-8?B?OTdlRGNOZ1dmZ0pnVTQ2WjJBcllCdGo2M0dKeXl1UitQc05uUEgxOTd0a2x0?=
 =?utf-8?B?SGV5V01zQXVZQlpLdFV3dUVFNHgvRExHYTdYSXVXcEpsYXVDRjdJdzA0T2to?=
 =?utf-8?B?clFzUGF6TkRqRGdxRlY0R3VOWksyWjNZaXEwUnJOMkE3K21NV1JGcGtTblNv?=
 =?utf-8?B?TFVqV0NkT1NyR1hLRGFUMCsxZ1hhTXd3azBjNzczbk1DeE1xVXZxbDcxcDBI?=
 =?utf-8?B?VWM2b2RXZVgzVndNM0diUkFLNmFiTXM1eWlRRTJVM1l1UTZMUE5SMDVmWjJz?=
 =?utf-8?B?b0x0YzRrQzVFb1ZZTi9sSVh1RFZodW14TXZ4SnFuNFVEazY2N0JSbUVtM3Fl?=
 =?utf-8?B?MUZKdUQ3VXFWNXZDZUVXTWExQ25LZ1hOdnN1ekxwbWJOOUNXSnJDcmdieWhP?=
 =?utf-8?B?ZU4ySkJQRk00bGdNdzZGeE1JVHJJOGFmWmNFY1FpUnNJaGU4ZHAyM0VoMW5M?=
 =?utf-8?B?SjlyZiszR2hzeG8wSXR5U2dWWWs3NlhXbGxTbmlSRjJKakN2NlowSUhHQXE2?=
 =?utf-8?B?YVNOSVAwZ0JzTERmWWJqbFVKSmlFUUF2YkZKRXFLZk5nZ1B4RGtkZUI0Tk9B?=
 =?utf-8?B?TXd2Qi9zeTYxTEgyNkNwVTFwcTlkVGQvUmYzZFZrcXEyME1NOXNURlJaa3Zx?=
 =?utf-8?B?ZDZ4QURUc09uK1FneU1Kd003ZFVIdnFDcW55UmRZMVFvZ2d2V2xNMjcwbjly?=
 =?utf-8?B?ckFiOXFCMzloMzlCQ0pHdDQ4aC9jaDNqS1h6c3VxWUljMm1USzAvMlJqM3JK?=
 =?utf-8?B?ZFRRZndkM0kxaGFlcjJPVENXa3pFZjhXYUYxUkhUV0hSZ2swdHp3MkhhMEw4?=
 =?utf-8?B?UUF0bEQ2cmdNRks0bjFnM3FVMHcxUXdCRWRXSkV4RVR4aThZSnBqakZ2WTdF?=
 =?utf-8?B?dU44U1E2WU0xcEN0c3ArclFxdmUrUU14TXpTbDBGd09xZDRzNEQybXpCYXUz?=
 =?utf-8?B?a3JiU2tvSWlIbEhCYmx2bzFGdU84SEYzVzhLeHdMUU1odlBCRUI5Z3lHQlVa?=
 =?utf-8?B?NU9yWTlFcjNjWkRsRCtyS3ZvMFRyaEpoazlBUnNsUkJLblhUdDdqcHJRdU9M?=
 =?utf-8?B?YUhSSzhHVzEzMmF0b0pYUEN2Y1ZDcWl4RStISDJqaWZLaTdSNnBqcnZlUlAv?=
 =?utf-8?B?MUxGUDYySEV0WlNTWWpyMStwS3IzT2lBQmZQampIcnRWWnV5dCtDYVhIWjEr?=
 =?utf-8?B?RUp4d1JZak5BRE1tcDNaKzBCejZ0cTFVdVA1enRKZm9yeU5pSDZmUDBYUGZK?=
 =?utf-8?B?a0xsenhRZ1o1MC92ejZwdk1tcml6YzhUUHJudzl1VlRnUUZKNXNxc0REbXdO?=
 =?utf-8?B?LzNzSnFpcnVjbk1tMGJJaFJrc2V4U1NwYU94eCtXK3grQUdYTlFxTjNGNFlV?=
 =?utf-8?B?bFRhRFR2SWhpb0Y1OS95WGJLaE95NEFDR3Nvdk9NNGswVDFrSUErSnUycUI3?=
 =?utf-8?B?d3I3V1dDc1BvcC9EZ3ltVnVTbSt4eXo3YmZJY0UrZk9PV1B6cEhiL2pPY08x?=
 =?utf-8?B?dWtCeUN1M0dJTUoyYkxkcXVVY2NSQW1UbkEra1FPUXFwYmp2OWdhaVNpSVRQ?=
 =?utf-8?B?Wk1zSkp6UjF4K0dDSnhEQUxnNVpORlVyYTE1SWkrcFVPbVhpZ3hQamRiN1J3?=
 =?utf-8?B?L1FmSVNGUER0OU5tN3o2NDB0YnRjb2FtMVVMWWNzT0Q0UUd2d3QvSG5WZDJT?=
 =?utf-8?B?ZjJRcmd2Q203ZmpaZ0hhWjNLcUV6MHd1NXZ3V2tDVkNzM3AwSE9hK0luV2pu?=
 =?utf-8?B?WE1QZkdHQUZ2Sy9BbW95ZVdpeTJZQkw2bndhYm9xVzY1cW42UmZJWGtCcjQ1?=
 =?utf-8?Q?FTcYa23R3vugoOqKoK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2f3bea-e223-42c9-d80b-08de792e0a86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:06:18.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXtTGTACQLONp/Xgcx1885R9z7rlIcl2hCR7Fs/cDIlor3aixSdYlGvSxC79wofF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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

On 3/3/26 14:49, Khatri, Sunil wrote:
>>> @@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>               drm_file_err(filp, "Failed to create usermode queue\n");
>>>           break;
>>>   -    case AMDGPU_USERQ_OP_FREE:
>>> -        r = amdgpu_userq_destroy(filp, args->in.queue_id);
>>> -        if (r)
>>> -            drm_file_err(filp, "Failed to destroy usermode queue\n");
>>> +    case AMDGPU_USERQ_OP_FREE: {
>>> +        queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>> You need to have xa_lock around that or otherwise xa_load/kref_get can race.
> __xa_erase is unlocked version, but xa_erase internally does have xa_lock, since there is nothing else but just erase here to it made more sense to have clear xa_erase.

No, that doesn't work like that.

The problem is that xa_erase() takes the lock only optionally when it can't exchange the entry with NULL atomically (e.g. because a full page needs to be freed up or similar).

But in our use case taking the lock is mandatory because kref_get otherwise doesn't work.

Regards,
Christian.

