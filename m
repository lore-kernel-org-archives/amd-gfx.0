Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CAAC3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 07:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EFF222C2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 07:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aiBVkc5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EFF222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BA66EE0A;
	Fri, 28 Feb 2020 07:39:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63226EE0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 07:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR1Ei+EuFLaZIBDsx5PpEnMMjQhN63xkB8ukpZJ69lNyvpFKplatnB+/KSeJGVJG1aUpMZD5l2h9rmaJi89S+sXgbQuZDDZGD2p9U1XVUB8CSeejWrZ7Og/PfFS8jwXUECkjF9tXsz2xQqpBM4qYXSIQuW7BBJW+cGhFTVc8hZTf+Bk3fRWqHQYcwxYTZbxUeojV4G0J3IenTitFDyopTKJaU/SLVn3GBMR+FWMW1giz2o8Pglaj675WzFy5puokxf6rnYBjFzdbLDVnIzB1S233dTgxygSK+r2QvFq0BN0s04T84iMRPEoqeGMJaq0b25MhXlJn8f1E8KeJcebH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX1t/p57O9+Ywe1LKzN5yfRsxGuegEcS7y6WuYUjQ2I=;
 b=K+yNRvzHsKXuszqIy+xQJKsj+AMBoVe8nZvDKa9G82TfPlBykeIxiExnFrNmvpVAPYTCizBO1JeegO9c4PGgSjBYJ3sSkMFZ5Nm9EyLKx0EmRlzHX/3I/JX3MyfWsu7J3tcEanH1YRdnx4ovoOU0wWg769n66ItXTKxmCzsXTQVcOl0YvjtU6ggG4PBAISJMnNzFeehxCX+0p6aJd5DQ95R7GnpwG5qzlGh02cNYI2ofUWV1pPkDriSBYD/WXl/IwBqBEufmSTvekA2Mci1h1npmS8cuDbaxoEb0riYpOD2348qmjaL/aulmUVJHEbrKs6FWxDYKDKqkmMDirvXzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX1t/p57O9+Ywe1LKzN5yfRsxGuegEcS7y6WuYUjQ2I=;
 b=aiBVkc5t4rOpWq32zLr1FhbTLqONupQ0+GHQ89HbdjHMsm2XMwmebUB/n8QTpXSjZHFXXdmqeQlIjsngnfI+KFCSIlQrQhsJxGqaBs9oQFW6VRVHZofQiJl/Nzx7MQVawRd9qtfdmwdmAB1VzQA7WWUcRXEj2vWmXMVpSZPJovs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 07:39:02 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.012; Fri, 28 Feb
 2020 07:39:02 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
 <d76bc281-31e5-d0e2-47a5-6c41bc05c401@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <de34385b-8e9a-93d0-389d-7875d380293e@amd.com>
Date: Fri, 28 Feb 2020 08:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <d76bc281-31e5-d0e2-47a5-6c41bc05c401@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0102CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::22) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR0102CA0045.eurprd01.prod.exchangelabs.com (2603:10a6:208::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Fri, 28 Feb 2020 07:39:00 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60ed9da8-55b2-4f28-4afe-08d7bc21479b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2392:|DM5PR12MB2392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23923F9A281C6E0EC8F7BE9283E80@DM5PR12MB2392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(66946007)(316002)(86362001)(110136005)(478600001)(2616005)(45080400002)(2906002)(53546011)(6666004)(66476007)(186003)(6486002)(36756003)(66556008)(966005)(52116002)(5660300002)(4326008)(81156014)(31686004)(31696002)(16526019)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2392;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MOslLlcDOq43cojwBHYUkID5xlHpHaYVdTgMjVEnLCOff7lI2oW0iEBW4WaAEgy4EFnm5w8OpY89u5Sv3mkcJVqcfZF9Wc9V1pC0oY7A6GBj+DpbRlWvdQgnoPS5xw2or+pPTwDZXWCYXjHSK8yA7y9BkjLEEi/yN2/FJczjGwmucaVuitY0nD/Pjlb/S9Hs7w+nIAd/P2IhGXxKHedi0lnqIUUUKDWNJXFJZF/tLTqKDXAezu0hFrn7sLzSlEg5pqZzXuOsd8T5qI8rxnlhT5oBpzABNzmmGEsj8KAdmV6jYVjr54VjrWF0HqOMzk+zYxTID4vNwleFmbGWolqJQfTe/MZIiHDD/C+k8VUDKgRmYV5va3S7y3nAPzBWc3t3tk6HuOZ9CWpwkY2igH0qgzsuqctsvTCSRwtUQ4Ha3BdfruELtINDCxpDsSvOgj++XspRU04nCLZDWYQM0Tr3ZFAnz/oqU3O2AtpGVytJY0=
X-MS-Exchange-AntiSpam-MessageData: mYHlgOaHYYUxk/YyNqcQgIMWeiS4A3hhgeyZFWbhK1RZgPgZL5bjJBzQWhtaj3+9n0sF8mIe2XqBZwUBegbk1TGiux6MLi2p3RDxLwEON31Gx9tl3DSM7KTKRpEqIhn665gRVDHtOAGSPKzYGkSkCIXyVX0kRzPB0ldPUAILE43jZHM53u3V2KZj9O4qMxVQTio/yMomg2swG2shMXv1EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ed9da8-55b2-4f28-4afe-08d7bc21479b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 07:39:02.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAgKS1t/0XQx196s2j+ffWkbopKdF3M6HgfwhBSsxdvzSRvscImqyfWHHSHJgqQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.02.20 um 04:29 schrieb Luben Tuikov:
> On 2020-02-26 3:37 p.m., Nirmoy Das wrote:
>> init_priority will set second compute queue(gfx8 and gfx9) of a pipe to high priority
>> and 1st queue to normal priority.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 24caff085d00..a109373b9fe8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -170,6 +170,7 @@ struct amdgpu_ring_funcs {
>>   	/* priority functions */
>>   	void (*set_priority) (struct amdgpu_ring *ring,
>>   			      enum drm_sched_priority priority);
>> +	void (*init_priority) (struct amdgpu_ring *ring);
>>   	/* Try to soft recover the ring to make the fence signal */
>>   	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>>   	int (*preempt_ib)(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index fa245973de12..14bab6e08bd6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -6334,6 +6334,19 @@ static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>>   	gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
>>   }
>>
>> +static void gfx_v8_0_ring_init_priority_compute(struct amdgpu_ring *ring)
> Why two verbs in this function: "init" and "compute"?

Compute is not a verb here but rather the description of the ring type.

> Certainly there is no need for "compute".
> Just call it
>
> gfx_blah_ring_priority_init()

I would call it gfx_*_init_compute_ring_priority().

>
> Putting the object first and the verb last, as is commonly done.

We need to make sure that we note that this is for the compute rings.

Regards,
Christian.

>
>> +{
>> +	/* set pipe 0 to normal priority and pipe 1 to high priority*/
>> +	if (ring->queue == 1) {
>> +		gfx_v8_0_hqd_set_priority(ring->adev, ring, true);
>> +		gfx_v8_0_ring_set_pipe_percent(ring, true);
>> +	} else {
>> +		gfx_v8_0_hqd_set_priority(ring->adev, ring, false);
>> +		gfx_v8_0_ring_set_pipe_percent(ring, false);
>> +	}
>> +
>> +}
> Again. Notice that the only difference between the two outcomes
> of the conditional is the last parameter to both.
>
> So you could write your code like this:
>
> gfx_v8_0_hqd_set_priority(ring->adev, ring, ring->queue == 1);
> gfx_v8_0_ring_set_pipe_percent(ring, ring->queue == 1);
>
> Further more if "priority" had to be variable value,
> I'd parameterize it in a map (i.e. array) and use
> a computed index to index the map in order to retrieve
> the variabled "priority". This eliminates if-conditionals.
>
> Note in general that we want less if-conditionals,
> in the execution path and more streamline execution.
>
>> +
>>   static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
>>   					     u64 addr, u64 seq,
>>   					     unsigned flags)
>> @@ -6967,6 +6980,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>>   	.insert_nop = amdgpu_ring_insert_nop,
>>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>>   	.set_priority = gfx_v8_0_ring_set_priority_compute,
>> +	.init_priority = gfx_v8_0_ring_init_priority_compute,
>>   	.emit_wreg = gfx_v8_0_ring_emit_wreg,
>>   };
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1c7a16b91686..0c66743fb6f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5143,6 +5143,18 @@ static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>>   	gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
>>   }
>>
>> +static void gfx_v9_0_ring_init_priority_compute(struct amdgpu_ring *ring)
> Ditto for this name as per above.
>
>> +{
>> +	/* set pipe 0 to normal priority and pipe 1 to high priority*/
>> +	if (ring->queue == 1) {
>> +		gfx_v9_0_hqd_set_priority(ring->adev, ring, true);
>> +		gfx_v9_0_ring_set_pipe_percent(ring, true);
>> +	} else {
>> +		gfx_v9_0_hqd_set_priority(ring->adev, ring, false);
>> +		gfx_v9_0_ring_set_pipe_percent(ring, true);
>> +	}
>> +}
> Note how similar this is to the v8 above?
> Those could be made the same and he vX parameterized to
> the correct implementation.
>
> For instance, if you parameterize the "gfx_vX_0_hqd_set_priority()"
> and "gfx_vX_0_ring_set_pipe_percent()". Then your code becomes,
> like this pseudo-code:
>
> ring_init_set_priority(ring)
> {
>      map = ring->property[ring->version];
>
>      map->hqd_priority_set(ring->adev, ring, ring->queue == 1);
>      map->ring_pipe_percent_set(ring, ring->queue == 1);
> }
>
> Regards,
> Luben
>
>
>> +
>>   static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>   {
>>   	struct amdgpu_device *adev = ring->adev;
>> @@ -6514,6 +6526,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>   	.insert_nop = amdgpu_ring_insert_nop,
>>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>>   	.set_priority = gfx_v9_0_ring_set_priority_compute,
>> +	.init_priority = gfx_v9_0_ring_init_priority_compute,
>>   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>>   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>> --
>> 2.25.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cfb0f769b48da4c3c390108d7bafb4e1b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183460845495056&amp;sdata=qqzOg3W%2FvkOrG2eglBM7NmByS1ZreZAfigOJWFgA1Hw%3D&amp;reserved=0
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
