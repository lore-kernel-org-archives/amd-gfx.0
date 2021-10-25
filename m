Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E380960F4F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E380960F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F0989D56;
	Mon, 25 Oct 2021 02:56:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C386389D56
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 02:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLfH6vd0qCICRb7FJDRNzAChOBFScttFgyYI3OXU0y9qhX+vKPGOES8XvefsFr6x+xb9vc+4PW735I9JP+JPTTq/oxN+Vil1COsipV1jPTDQSHEpCDiNiWwmnkDt7gYH0Fufttz3PBBKq8ScXCaBETknn1aFetpF3zmzT7RI9fWYTXF7dGFBD1QEAaD0bih9M4YEyDMePvg2bfqsBEU+IQZjRxHGegaCoOwjwhuZDl7VAtO5RZAf2Xxvc8NYsMWXbU+699uk5/QP7+aevwBXevx/ncJ5Uqi+AlgyG5GzqzQo+UTV2VH2qoe3/g4Stbj1LRMngNmQOIptqxBWgjFz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4T0wk5Cdi6PRD5rGEgW8WaYhUPQGEgoYvkvVE7igs=;
 b=KQJ4bHSnjUVyhX+gPJrLwYVn0sxiR+QkTgJZgOrtBafF5Lnee49OegRBBPHYi9eHcigh3mKuQS1r2V8gOMT3BV+4kN5fTVCZ8iXSuicMFRLrOee2QygZBv0T1I661TCO2A1wAR9AxGSYiF2rnbaS+P/O1uVNhg7nPx0uy03PCil/KsvyU406LsHDafUje7aVTv1+PahDAVJOG0cgrEgoeYFxRebUGzdWfcf+3MSPutxm3lUT8Tz3R/NPns24JL0sM3AnBRH0ofPUiNvbp4DriqeY7HQdqPgWHq8E9ocu7jiIyDwOerVDVpRON2P8HUlGW/O1XHCwaxctyxPEJ40Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4T0wk5Cdi6PRD5rGEgW8WaYhUPQGEgoYvkvVE7igs=;
 b=WIoMAmGWcb2h9Mf4wNf3o5ho5SiSlSrI0VSpu4M5QqDPCSZoBMev0ElVUBaavfD9d4C+OaBLNDAv7ZKAe2D0jvv6kOO+D4eCxU8WKCmhgV1/t/0FQFWYsbGTOCFvzwGW4kDOUM7qZFAk09LMbR5+ek0oblBCD9OFq8ZkzWrAA5Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 02:56:24 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 02:56:24 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, jingwen.chen2@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
Date: Mon, 25 Oct 2021 10:56:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To DM4PR12MB5232.namprd12.prod.outlook.com
 (2603:10b6:5:39c::16)
MIME-Version: 1.0
Received: from [10.65.96.204] (165.204.134.244) by
 HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 02:56:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af52a678-dc0c-4863-a445-08d99763082a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51360EDD45D6C50BEEBDBB45B7839@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqOxOa2z0K1BuUp7StYOFW0A0qPWh1NI5jgRPPyJqb7nTh6eCmqOQF45xIb+SrLUSX8BY744PpSR/RFra4CkkfLytChL7yW5loo8omJwlEkjUVAEDJyDjyKoEKXnSA4+CTQYyLNB64KQhIqGcqg7ymmXECZzmCuNlOdS0GUNFPjh4J0t2Wr743n48p5npqkSTgmODGqmm8KaJQt24CKfhStFh81nhYqwrp8F+TFIDz/uT+EDSf581u/Z4MtyyBoI1Qu1B76i4sYiuyZjgu97efoLxhkcxlW7ND7SBJr5f6VBEp0/6fV8C6kccMPXifCip0JXjCO7aBLH3EQ1v3H+IkOK50ibdL893oJM1Y70rlgPlCBERUeTtAjJu0kqMOWhtBUqVGdcXttwgAYtHwQdrwBWyasU/XUgGDXgxvjrAGaCUBEfRZNvyOc2cLJdViI+7runBOodRStX6sStYBO5zK+r/U8H6R6FoZsGXoi46Matw38QEYNDQ6bxNjQyyyB80Cr7dDmny8b+jFZJTPNco1DhNvKMVh+oE0N1Wj+6cx8/tQqwwc1dsYJmePGP7NA7wYopd3mH0tEPgOMK2OWmxgFw9VGsDjGVxudElA5Q/sHa8IP7gEIM1HjmeTOoIWeNrS/Z1Bbd54135LQmZP62htm4wfP+D7gdinQkbKbdqZhxu7nOvVhO13r2afF+jC/m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(31686004)(6666004)(38100700002)(36756003)(4326008)(8936002)(316002)(8676002)(2906002)(66476007)(66556008)(66946007)(6486002)(53546011)(26005)(186003)(2616005)(5660300002)(16576012)(4001150100001)(956004)(508600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpTN2Q0OWE1MXNnT3paZGpReWlaQ3cwVXgrVWljR3diK1B1YUUrMkg2RTBz?=
 =?utf-8?B?SjhBbzZZZHBFUzFTSmxNUnFDMTMrZ3IrQ3JibFhLRndGbEtrVnRZVlNENzkr?=
 =?utf-8?B?cW9wVnF0d2xRaFY2bFZWZngrdFI0VEo5ZUgwUDZJZ2l1RjdSSyt4L1VSV2ZV?=
 =?utf-8?B?NHJhc04vcnB6ZDE1Y3ZxSnprcHRFK1pFU1UyWkQ1c1ZoVnAyWHdjOEFvNUpC?=
 =?utf-8?B?R0dwZmpoZk9QZStmNm9ma016YTlDTDRNT1lIV1M0ZE9VV0EzQ3RSVk11MVhI?=
 =?utf-8?B?eVhmY0JsYnh2QWs5NE44VUpGOHJlQ1RuVFZodzg3WUFXK2l5TnA0N0duOThi?=
 =?utf-8?B?QS83QWJjU1JQbUdHd3BLb2VkRDkrNXhYaGNNMzNuTlJhUU14NTlRMlF0bmZq?=
 =?utf-8?B?eDllc2FzN0hxWG5WdEJ5SVJvNkRhcXpuMFpiVExYd0JyR0JZSFlzRjQzaFBB?=
 =?utf-8?B?cnNLL3BvUHZic0FSUkN1R3BNNElTZDd5RFFORUpWZmZjL2QwM0JaSXNDSFlX?=
 =?utf-8?B?WnUxOUt3RHZyaEFiRnZOTTlNdWxsdjlEMmIzUHY0UDNHNUJGWHh5alpXVFBa?=
 =?utf-8?B?aXk0Rk04cm83bTBQaDVxMVY3OXJucUtPaGQ0YkYwWUVJKzNlamUxYktLbzEv?=
 =?utf-8?B?Q0s4SGRPS3V6a3VMTEErS3dMaVhSdXFVdXZ6Y0wvUHZReW9PRjRoNXloNDBv?=
 =?utf-8?B?MW9naWxLVEVVLzFvZW9Xc3FNV1ZuS01jcEQvd0JiWGxCSFEvV29FMkNvck9n?=
 =?utf-8?B?b1ROZUtCY05rQzVOQjltb01LZUxqbTNSbW1aMFpTRTAxRGdrbXVwU0w4bUUv?=
 =?utf-8?B?NnhDR0VpZUNiaWNWNE5ZN0ZOOUtnelV4S2h5NFRUZEM4WjFDQlU5VDgvZERW?=
 =?utf-8?B?WkdsaG9RZ3NIWWxJbFU5VFF0YVhrZEZOSE04N0krUnlHNzhwNnpnV2JubFR2?=
 =?utf-8?B?MzRqYkYyVk4vc01DZUNZYlpOKytSUlNTK3M3QjRweWE2cnVOeGZBSVJPQVpE?=
 =?utf-8?B?OUJtNlpvTlIwTjBmL3dNZkZ3Ti9MUkRabmJPSmpWODhqemtLK251aUFPWFdU?=
 =?utf-8?B?NmFrbTUzMSs2TkxiQ1lkMGF6dnNHUCtMa2d5K3lyOGV3YkFjUGlWYk8yUFp0?=
 =?utf-8?B?aHZYTzIrNGtoWk5nTHB5OEd6WG9xYTFJeUlyaDZJdmowemcyVEcvMVBFYlM2?=
 =?utf-8?B?amZ1Q3BqdDk2eWs0V0J1VE9ZekFPdnJ1dlhtK040WE93aW52MDBUYk1DOHFW?=
 =?utf-8?B?NFVqNm9rdFJNeXBKbGFSUmgveE1KNUFxSWJCUVJTcUNFZmNFSEFmbWZNWjJ0?=
 =?utf-8?B?VG1ITHFHckliektnYVNEOVZ1TDliSUdPRG1xWWswK09BdE1WZFN0K1JXUVQ5?=
 =?utf-8?B?UzlRMXRMOFd4cCtqQ2RZWmhVZEdjN2hnYTNmMXBlcDJjdlQ2QzM2cy9QekdS?=
 =?utf-8?B?OFRBYThXQm5NekFLYkptK2ZsaU1wR1RLZHNnMlYyakxTS05UcnUraFFLd2wz?=
 =?utf-8?B?UmJvaENIU0xMUEliRlYxTTFvQ3AvMXcxOTVwVUdyLzNnc0dkYmMwbExEcFBo?=
 =?utf-8?B?aWl3VmROSWlTKy9PK05IbFc0VnFscWpFd0pGRjd5a3RHbGIyV0sxMXZ5d29O?=
 =?utf-8?B?NnBoVkxKRllaR2RVMjFBYU1xYis5bkdha3NzOFpaOVZlcDdvTVNqRkNRV1hZ?=
 =?utf-8?B?ckxaaHR0VXFJVURyM0FsVnlVQ2wyZmtOQmxJWUt6a3J5ZEVhWkt1bmR1SitO?=
 =?utf-8?B?VUVsUCtsNEZTazRhTXZydGtONlk0TytJdVNMd29CSkg2Qm5ac1I2RmZjZjlV?=
 =?utf-8?B?VjBiL3BWZkx1S3JKeEhTaUJVVTBOeFdwWkZFZzRFeTFhMytHUzR3OUVLUGV1?=
 =?utf-8?B?WmQ1MjdNUE1BQ1FtZzU1ekJsQUJibk8vQkhaMGVvREdjUDlVOWNMWWU0Y0tW?=
 =?utf-8?B?ZTVud241T0tuTGJFcGdzL1RiWkp3NGh3aVMrQUYxVWxHcVlINW80WXFHaXpJ?=
 =?utf-8?B?dndsM3NWV0pUTVQ4UDRQZ3JWTFNRYnk2VXYreWdiWC93L2cwR09PRUtzMk5F?=
 =?utf-8?B?TjlxVEtZNnVORUd4cGlSVlBQSlR6QXZkNjh6RTFtWXlraWxoWmZiR0hOaDNv?=
 =?utf-8?B?MEJHYUZPMWIvS05TSFE1RFRpZDEya2tvalovN3k3WVIzakRIeThLMkw0eGdN?=
 =?utf-8?Q?KsjuS/YdtiAxsCYMHxM9BQg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af52a678-dc0c-4863-a445-08d99763082a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 02:56:24.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RLPlEQPd90nGG3V6C/7wPXI5FAnU8Uhmp49YsS46yEw2GZ47GbdJwBtWEHTb4kBD3RXBF0D/vLS/1E+Ekwz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Reply-To: jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>
> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
yes
>
> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>> ping
>>
>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>> [Why]
>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>> is put one more time than other jobs.
>>>
>>> [How]
>>> Adding dma_fence_get before resbumit job in
>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>
>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 41ce86244144..975f069f6fe8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>             /* clear job's guilty and depend the folowing step to decide the real one */
>>>           drm_sched_reset_karma(s_job);
>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>> +         * to make sure fence is balanced */
>
>
> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>
> Andrey
>
>
Hi Andrey,

If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.

>>> +        dma_fence_get(s_job->s_fence->parent);
>>>           drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>             ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>             /* got the hw fence, signal finished fence */
>>>           atomic_dec(ring->sched.score);
>>> +        dma_fence_put(s_job->s_fence->parent);
>>>           dma_fence_get(&s_job->s_fence->finished);
>>>           dma_fence_signal(&s_job->s_fence->finished);
>>>           dma_fence_put(&s_job->s_fence->finished);
