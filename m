Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F85106ACD2
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 17:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF5510EA81;
	Thu, 12 Mar 2026 17:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="an8pUQ2Q";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF6510EA81
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 17:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1nTZkn5s1LuCt2TtyVzupL6n1PNjPYfcln5BCBh+3R6xnh+R5Nv1EOAELkm3eeb4wcEhJQyitCkQPRggXVw31R5lACcpAYECjl0F28jCdJLYGhdRn7O/SwDe5dInqhaNuDPKuAnhIp5NRf9RDpt5PcNXfa1k6+RPPcJHZ2ruUzdJuQKjUiQD54XghmC+ZIjQe2YUR9ZBIVGtsBNyysyofl40AzBkJf7b0hTCeErfYghWWq55rNI1dIXOkhi25kzWDkUYDgrNc3zRu+g8OHKGdFxJsAS9oAyWUbNpXmnIRu5LPj3rqeCubdK9uA5MkC4uRKgF3+QoSWP87QQrnoXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJm0L7PauFMZNKLLiBMWP6gpfxYLkYr/9DPDs3A/eLg=;
 b=NXc6JAGT+t3X7P7SeM+OsAKgk1rQSyWhy2lvowICxRprFb0bZwjHFAzcJW+IwoS6ANrFog0NzVGbeYorC3VbNLCBoT0Q1HGTlYQk8THJObFzhwdc2uoGgWfc8WSiIUEKedHbI6i05Fvx9KhGtNrcMQ5AqE21v5F/AwGGiYOLct2pteway0czbohgTQoAruLCt7jpHgJM3Yk0eb1AJ0nKCXwQgJ3F00g1BSIOhxAOusGY8a2WgBC7ePPQO9CcuGK7m046po7C5HA9blAawVrkkW0JXbzLSSXJ4Utww8sY+Zw3CTTYA++MgT2z2Hh7pBGUHJfpWl8qrZZyGp9/ohMpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJm0L7PauFMZNKLLiBMWP6gpfxYLkYr/9DPDs3A/eLg=;
 b=an8pUQ2QMbWEMsyxO2bYKRiKNFdmMOmxJPJzWxrusCguaGPpXfONnua3cF6UaB9ePY87XPZRsmScex+BVfy48596tdOWcOXOgRR/hSum8u6z6he1suGW2dX4SvUxpVQDcyTwnezQXtOe+JattfokGrvdpvAMzIq3aaFk+zOy5CI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 17:48:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:48:42 +0000
Message-ID: <d1ef0e7f-ff3f-4012-9074-b87425fa2fc2@amd.com>
Date: Thu, 12 Mar 2026 18:48:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
To: Alex Deucher <alexdeucher@gmail.com>, "Jesse.Zhang"
 <Jesse.Zhang@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
 <CADnq5_PXhLYs85cU2FZ6ZYtBBtv1wOmwiJL-rDbYsCFXpTL_cw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PXhLYs85cU2FZ6ZYtBBtv1wOmwiJL-rDbYsCFXpTL_cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f7333-9073-4021-485d-08de805f9986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: EzWfNFPz97XjEg432ljWNkx6Sj+XhQRHzDtnodVjysSF+GVIqUoJvfxo5AN/fNYpAtW5dQnH7Q69JjNVrT0VT9MzoteuHFeBPO7IvqayTrZcb7UOqMkl63JpaidyziIs6NR+43V6dVF7o3iViCxn0Htn0kT8n/iw8yVsoI8Nq1yLMLR4PxvU/6ZTcrb9VabCIG1C2Xtu9VZbKp69L30t9gYUhX6ZY5lONZ5up6uSU7sPIvFw6ZnF4YRUxJQTfye7yqF2eAe65wBWd9maqrKjRSUvtTqSJf1lqG0hfgr0OtpY1EC7tpLaV/xYluWhDBIP27Zk2QiplgFNaliwPfI+ISOlVap5f2Gzlv30PzHi7BPCQTXi8QDl1OwhsglPOalLc7W3n2Hi0S/O4dSmC2jUADKZ81dvzPPRaOfnMwqFZVLLtRa6qwRT3JovhgUN5plCPmzsp0aa+af8ezNGO3I7Ltke8r3FSdjmSN7N7J+rQCUcdNWNR/9lAJtGRqvX1/EbTi0v2Mgw4H2QmcfFtiHYYHoLLrdgLPn4a/emVNSqeM90sMp73hwDhtBOxGmkAMYeSNnJK+0iltdPG7hYuduk+bxm74EqcA2WPhmIEz/s2lFJ8kks2NxW/LA7knRvZxIxAGBvcvgJV4lGr20shRN3Q63RFJY6FwvxsdImWkYayZBjuCNMXaiOv2GNWWJFnEKxH5io5WiFQUG/Po1YX9SSJnqA32C6b6/PagOmGeVW85U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21FWUtKczFGczhGMWhHNldoaHpGb3NrbDRwcTVENG9YbWVUUENjVW5YellB?=
 =?utf-8?B?K1lVaXBjUHhNOHI1TkEyVXNzUC8xeGRzNERsQWMyTjFzcWFIMXRaQUxXNjNV?=
 =?utf-8?B?WHdtaHpaOUZEaUw3MWc2ODdxOTQzWk1ZME4xYWtyaUlFaTNiZUF3dUFZT2xO?=
 =?utf-8?B?dzZ0aXBlR084cjE1VmFsVm4yOWcrMTkzRGxjK3FFTU83OENyWkZwWSs5R3Na?=
 =?utf-8?B?WXI0NnZLelYyMFpsM2Mra0d2TEMzcHlVc0ZwY3dINUI2T054UkhCQzJwekd6?=
 =?utf-8?B?ZFRIUUdaRFNyek1uU2FQRkwrOEdWNytPcy9abHdaT0cyM1FKaG5PeHFtVHhX?=
 =?utf-8?B?T1h3WjhleVoxcEF2alFOamRFeEdJemlNUEJtcnZoV1FQWW5vaUtMS3BwM0Za?=
 =?utf-8?B?dzVNOW5BZDl3Mzc1czdwb1F0akhrQWNoN3d0RVl4SkJZWHRTZEMweEhwUFox?=
 =?utf-8?B?aXkrY09MLzkrWEoyRVB2MmpIOXdFbll4aVJnYlBMZG10d1lnWUZCSWJZWkpU?=
 =?utf-8?B?MUg0MUtSSFpHbEVJRVg1NDMrRDFrV1hTcnBLSWphQVRaRWt5elpwRHI5M0JH?=
 =?utf-8?B?cmxNWG1Ga0ZqZ0hyZERWV1o1S1lLdzJoVnVnSS9MWTQrVGUxdFRSbEZ0TXdC?=
 =?utf-8?B?RFF6dUVWck9RSERMblF2SmUvNXA3R3p4dm5ldUxJYzBsdnRrODdSTWg0Ukt5?=
 =?utf-8?B?SUM2ajJkSEkwSDNZOUF6VzVCOTF4OUlNWVg2N3krbDlpS3hQSjNjM2FYZTYy?=
 =?utf-8?B?S1QrclhpRzJjTkFyRVgrSHVVOHlMcnlQRCtQbVIzd2Q3My8rZmFmcDJLbDJC?=
 =?utf-8?B?V3ZFaGtRTFZ1ZGNmSGRsMnE4QUsyUUc3YVpaWk9sV1VrcDhtQmNTeGxYcXRD?=
 =?utf-8?B?N0ZlcEUvWHFjY1poZUxudmc3UG5NL1lnQU54U3RsVjB5bTlLRldQOXNHcDhh?=
 =?utf-8?B?eHNwZFg0SzVOVWsvRWY3VUx1U3o3akt6cDhsMEVCQ1NNZnlET3RrQk9ZN2ZK?=
 =?utf-8?B?OTAwdlplb2pLYitZWWlpUy81bDAycXJvVzRwUlQ3YXJtMlpVVFJ3N0R6QkN6?=
 =?utf-8?B?ZHhEZExyTExTQXp4eUpGRFFVUWhvS1JDNzZTcWVGZFpycThPdWt1WllTczU2?=
 =?utf-8?B?a2Z1eEh0dExGeFpGRnZGQnZ2N2kzU1ZrQW5SNkNaYXpSRFRUNjExNjJsM21w?=
 =?utf-8?B?YlBLb3hjOFpVS2NYeTlJY1liUzN1QUY1WjBKd05Kc28rejNhcjBhVmYwNVp6?=
 =?utf-8?B?Wi9yQVN5ZS9jbmVkcVpZUWhYRzQ0TWhheEEwMzJ4ZWJzNWNzY3o4N1VEQndO?=
 =?utf-8?B?UCsxNW1HSFhuYTdlTU9POVI0Zkc3YVJHUlgyR3htSWIrK3E0em5kU3Q4U1Ir?=
 =?utf-8?B?OTN4L3hTMFBZK01qejFKNGNDQ0lGZGhXNi94bmthOVVhSmFSbjlsajZFZzFS?=
 =?utf-8?B?cmpFcDY4aG5ScVR3TnVJdHo2UGJTUnFNMFpUN0pxMjJJeWNpWUg1ejN5amdZ?=
 =?utf-8?B?bEFyV3pLRjV5M3NGOFZQZ0pFRlh5TXFLNzllVDIwZ3N2Z1Y4SzF3TjQxTDg0?=
 =?utf-8?B?NFZ2RjcxaTNDKzlIUElmZ3prTmNwSUFiWFZRNGQzRjBwNFVndXJoYlVLdEdV?=
 =?utf-8?B?VFZ0cnhkMDdneEw0RU03NUZsYkVIc2NqTWRXbG1adHhVK0NsRjY4WDdiNmQx?=
 =?utf-8?B?UFFFT3l6eGNVWFNnL3RZdXkvSXFuSzVwaFlxZ3FpeWJTVk5xcERKZWFHZUR0?=
 =?utf-8?B?UnVmM2YyQ3RjN1Y5RmFna0YxVkFjSTA4aXFiRmtGRmFRcit3c2ZjUnh1Y0c0?=
 =?utf-8?B?TlAzdzRmdE9CekdOZ0NjdW9SSFdVQjJ2ckpyVmdRa2lCdUZYb3c4NTRwYmFw?=
 =?utf-8?B?dDdZcWZBYnVOMm1xY0RMOUd3MkxpUXkrOU5DaDRpU3FSaWtLSGVzeVlxN0pM?=
 =?utf-8?B?U2RLMXF4WTNqdGZLdmpEMWNZRzA2YXZROTVvekY5VVFjU3RuajEzREZuam9F?=
 =?utf-8?B?RXl0eWtGTlNLWmpzQkE3V20yVHZsakYwZmV1cWV6bmQ1eFIrTjN0MEc2V0JS?=
 =?utf-8?B?TU5zNTBKa2MzZ25IYk9UOEtqSzU0bEFvZlIwK3M2cS9TZW04bFFoMFpURTBm?=
 =?utf-8?B?b1ZxRDRyZWxVU2c3RG5LUlZ4Vng2YmZEaXBtUDdUK3BOV0lmNEJkakFYNWdW?=
 =?utf-8?B?YzFpRTNJQU5Oc1h2Mm9KZlg2R1pBV0FZSFFvL3V2bi85QUpUaVphZHlPaEN0?=
 =?utf-8?B?TEtjaTZrQWEvdzQrTDNzTGVKR01kYjJSbVdaRmF2RzFLWnRaWlNOUkJLbGhT?=
 =?utf-8?Q?fUfuEjljAhQsLJVIKH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f7333-9073-4021-485d-08de805f9986
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:48:42.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FxWFtVzcM2iLeHTTAPV1liHUVvUXDNSQFfwCjrtWhGC+LQYBrzWgkwiBK2hGjT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

On 3/12/26 18:44, Alex Deucher wrote:
> + Marek,
> 
> This was the feedback from Marek the last time this was brought up:
> 
> "USHRT_MAX seems too low. Traces for workstation apps create 20-30k
> BOs, which is not very far from the limit. RADV doesn't suballocate
> BOs. Neither GL nor VK has a ilmit on the number of BOs that can be
> created. The hypothetical maximum number of BOs that can be allocated
> on a GPU with 32GB of addressable memory is 8 million."
> 
> Does 128K sound more reasonable?

I think so, yes. Event 64k seems reasonable large to me considering that only BOs which are not per VM need to be in the list.

E.g. RADV barely uses this feature as far as I know.

Regards,
Christian.

> 
> Alex
> On Thu, Mar 12, 2026 at 6:13 AM Jesse.Zhang <Jesse.Zhang@amd.com> wrote:
>>
>> Userspace can pass an arbitrary number of BO list entries via the
>> bo_number field. Although the previous multiplication overflow check
>> prevents out-of-bounds allocation, a large number of entries could still
>> cause excessive memory allocation (up to potentially gigabytes) and
>> unnecessarily long list processing times.
>>
>> Introduce a hard limit of 128k entries per BO list, which is more than
>> sufficient for any realistic use case (e.g., a single list containing all
>> buffers in a large scene). This prevents memory exhaustion attacks and
>> ensures predictable performance.
>>
>> Return -EINVAL if the requested entry count exceeds the limit
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> index 87ec46c56a6e..3270ea50bdc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -36,6 +36,7 @@
>>
>>  #define AMDGPU_BO_LIST_MAX_PRIORITY    32u
>>  #define AMDGPU_BO_LIST_NUM_BUCKETS     (AMDGPU_BO_LIST_MAX_PRIORITY + 1)
>> +#define AMDGPU_BO_LIST_MAX_ENTRIES     (128 * 1024)
>>
>>  static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>>  {
>> @@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>         const uint32_t bo_number = in->bo_number;
>>         struct drm_amdgpu_bo_list_entry *info;
>>
>> +       if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
>> +               return -EINVAL;
>> +
>>         /* copy the handle array from userspace to a kernel buffer */
>>         if (likely(info_size == bo_info_size)) {
>>                 info = vmemdup_array_user(uptr, bo_number, info_size);
>> --
>> 2.49.0
>>

