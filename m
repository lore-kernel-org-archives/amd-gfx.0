Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D6606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HMaeCTTV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6C110E292;
	Mon, 26 Oct 2026 04:51:39 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2086410E292
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 04:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oew/WbEp5FhjeNSd9h7LkoP70pwWnW4iEBmuGmxRkUIOm7TnLYNA/5rnEAoy9QhsJj3W/jLe8RQTOK4d3eQTATEimKe165eZl93cL5UbtPFygXNAN1uM+NecWHh278ox14Qwwe83ctKRZkB/4y2TvANj2dQrrXSTZYpAnKUTQu6HbaC/58jj+XoPPVH73v/CJn2miC+jNPJdcKeF3ZB4+zrTmG2EGuNs6QTHhIM+L6m5hhlcnj4I3bMOg8pVl9ziYaxu0y8HnFfbkRJIgn6fO/TeOW4Tef+4Iq4B8EDmmTKlIC3fCAnVKDMDKwjYa9CAYOtHXnVfYeXHJbSw+IB+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEOAN7waFo5Fb+//ftaukdIx1nHzVu9dPRvi1s5ZDsQ=;
 b=FeQBWuBxGwxQqab86/ZEoc2/MFqxz+Bk2Kl5PTpuKGS+sK5wd6BPEjJ+1VOADno/owt1zy3EpwfOhAuQqiPBPwixqUrzFDF1C88ZZ/xbn96iWJsnOHdB8bVoCR1Y4c1uX89zKy7ygxryVwQsPtK5wJB8d4HXSGvmcqrWE8qb05CFtvpXV/m5lYbue4B1oMcohH9+mMbwLF0bheCD7tYwAWjFTXLpBHfihRgaQ6BVLvAoKi97yrs7D/aqDI+jNh3JOGsyVQt6iGPqcrK6FNzr8paebBhVvk3pvC8wof5C9v5+Gb7g0ghnFpBRvF5pVHfZIqSduczcZ37gixEtGt5+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEOAN7waFo5Fb+//ftaukdIx1nHzVu9dPRvi1s5ZDsQ=;
 b=HMaeCTTVwJm6y8wvKY2D5xJacskD8/ksAucZ3e9pXdd/QxFw3S6oVqNgT0+9UNsHk276eUA/51N/HQo273qsligKdxc4DCYt66ux4kGQbfIol7OfbTufYKaEdfOUgtEeUDpe1VQDNwbGPOh1/XP7K0a/1Bxe+gUwmEGcQ1zPRvg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 04:51:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 04:51:29 +0000
Message-ID: <6dc37490-6a3f-4aae-b6dd-e8718e54afda@amd.com>
Date: Mon, 26 Oct 2026 10:21:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/amdgpu/gfx11: flush the scratch register write
 in the ring test
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Mario.Novales@amd.com, igocaike@amd.com
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
 <20261026032042.2266892-6-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026032042.2266892-6-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0167.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 123fb38c-7dee-48bb-e97b-08df331ccca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|5023799004|4143699003|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: X90++l3qYrxVHwlsxLnzsbCNoiutSPS3tLSUy/kPwUu8zw540+m8A+IAGECZP9GmUxSFBz7ahTg1DkVfWTkqdiLstNdK09o6PVD0l04U5+G4R95/M4q/g5UMrrfqkjsL4a9dVsiwsT9lJQOLM0fFPcJj+VTvV7UkShMqLmBIrLAf0/jngBu3EnB45GY1U30xBjEwgZUU1tShq+i/lEJORg4/Lv+4qSvFoKteUa0W5NNk4R8wr6+/MsGmyjKQZvFG0/eUnNWbJAxAfX+crkOG7qANKk9Ir+DvmBfAZKy+qgwDASHh/cu/dWJNegLNU69HuZ7xN/eRcNtz533BCsIVNZm5HgKq8CShW8HFmQi1F1jiiBh7jxIZrggXMAST+OR1AdZlIInj4Rw1W0S6E1reKaN02Y1PDVKQigBY1f2Ya2RyM6h/wCT4Rzd8rD01mRKAOam1cORLLcAcqUeCC1CBB5xwKg9pY4egO7+klkjF3UXqlJt8zC6+tF1hFP6pKHSc0cTHulEJJLwQC98SscSfrrwONGbQVABU7V8KkH+9vZVNs+8bX5WxeYXzu1nlGa8ZvcxFqHILKzoqQlqLxLVHYCMp8kKotFjOSUf3Nk8awI4qw/f0VRQ8WqJwYSLlRrNwD2SspQNBidQSHNMaFW0YzHLggJlLl2RZXMOVzJaCkTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJXUTErVGRFUGg5OUNFWTFJNnJ1bzR5b0lpcXhtOUhRWWJSTW94OFBTUVVt?=
 =?utf-8?B?T2EyMncvS3h1MWw3U3hRME91ODhxc3hiSXZQYmFOaDNPQ3Vua1ZRMjR4a0JO?=
 =?utf-8?B?VGcyci96UXJ6a2lyd1Rqa09RQzk3TlBIeEJ1eDNCVGJIbWZaMGhrekVnOURt?=
 =?utf-8?B?YStPUnBISUsydFUrKzUxbjNPQk53WUZob29kQ3oyNW5TQXlIN2lTOGdFM0NF?=
 =?utf-8?B?UWQ5dCt3M3pIdzZxQ2tRb1NXNjk0QlAvaHZBaGhWcUNsaDFIcGcwWmF2bzZP?=
 =?utf-8?B?SmZhOXp3eVppYVVleFBRcksvR3NKS3ltNE0xcjdyZ21nSVRGdHBra3ZTeVZ3?=
 =?utf-8?B?dWsyamMrOHliZlZoMGpac2Q0WUR2R2RrM1U4Y2RENmw5WVd6VVIySEtRMmNi?=
 =?utf-8?B?UExYODN1Nkp5bXBuMXFVa2VhZXhjaytsZlJjSnk3VHQ0V1RjS2ZUVGsrYWwv?=
 =?utf-8?B?dGt5NGRxRkcxTzAyakFRdEVNL1NVSHJCaFd2M0Jud2tkdUpqcExvbWdSNkxt?=
 =?utf-8?B?UGxKQkxoTlU0ZzA3bURhWXNZeFY5dmhXbHJ0Q2Exbm1uNzU1NytmdC93Uita?=
 =?utf-8?B?SUNKM0RzcWN0TVY2UG1UMXMreXhJdmVqazl2WmZjNU9DN1E3d2N3dEFzaXh4?=
 =?utf-8?B?TXhBSGxBVFU5cFdmWHZxamQ3N0NhV0lGaUhPWUdnRU8rUWE3c1RZeTRQQWlD?=
 =?utf-8?B?VVVMZjdsM3ZkWGxWQXpJWW1kU1ZSbG0xSUx4ZzNobVZjbWhOYUdPVlV2TDBC?=
 =?utf-8?B?RXc5NzM3SkR2eEROUUplUG10aWR1K3A4Q000QUZRbHFQejRmMXQ3cVduVzlP?=
 =?utf-8?B?aFBiWGx6Tk1CRjYyeWtRLzlVZXVtckt1YVQ5NStqWlF1VHpRRnoyZXIvajI1?=
 =?utf-8?B?Rk9TNzBIQVZZMG4wZEdzN2duaGlsbmFVRVlnZk1FQWZTVEsyQVh4ZnVXT08x?=
 =?utf-8?B?RytPL0t0WmhyNlV0RzdEa3RRZm96VDdWQ1lWNmlKQnB4Qi9nSjA2Wk03aTgv?=
 =?utf-8?B?YUhPQnlEZGxVVXRlaXJ0ZzAvWFpmTjdBVkFvV0dMUzBuSW1MbDNJck9FYURo?=
 =?utf-8?B?MVhDMlAzblhIZVJ2TkxuaDlJTElvbHBnUFREQ09BTzk4TGVXbk9sdldWZjB4?=
 =?utf-8?B?QTR4Z0d4TnpHampRakJwYVFTdUdTejkwbHByOU9SVGhXN3lNaHFGa2RqdjlE?=
 =?utf-8?B?RlZ1Y0JqeTN3ajRCUkxXbW9nQ01sUlFVZmRXVHJNUzhWZUtqOHJmaGpOenFP?=
 =?utf-8?B?cHlnTnBQNXRmbG85OGkvT2lERTZsaE5ZZ3YzM01uaFVwMWZQWUhDb05yU3dC?=
 =?utf-8?B?b0E0eXBHME90eklCVXYxSzhHcjVtVHcxS1BiNVBncVhIY2JBbzU4aFBldDhB?=
 =?utf-8?B?SGk4QyttZjFIRWRZbUpXTnRpN095a0NsR0h6N1p0cGZWTFV1TElDV0tuUzZV?=
 =?utf-8?B?ekZkaUU2cFlGa2pUWmE2SE9Gak5WVmtSQVp2K2hIWXU4L1RZa25SOXFKMFUr?=
 =?utf-8?B?RFp3QnpMeGtocmo4TzhTMGFCUi9uV0UxUjhmcktJdHlJSEpvN3NCanNzNjUy?=
 =?utf-8?B?L3U0NlZWVkVrbFV0Y1VSdjFYVy9tc0hvTFdOY3pUcS9Gdi8yS3FPb3pERmVO?=
 =?utf-8?B?NjIzUGZ0TkVidTlJMVpMTzI0a1lxNEcvKzNtandMa0RtUURxajk5VDZRZEdt?=
 =?utf-8?B?Nk1nc0JsTnlnbXZpQXpOWXdRYlBQdnJ0dCtJOVFYVmJsRGJjbzJIdEsvMUp1?=
 =?utf-8?B?ek9wNWFwcUx1dnNEM3prd25Xb2h1dStMTWVxQTdZcG5uMEs1aUpUUkdHRGV5?=
 =?utf-8?B?NXdGZHI0aURXdHNqcnhuME8rcW5JWUF3eXVILzBKTEVVVVdaTFF2cndKMEhD?=
 =?utf-8?B?bVpEMEhMVFVFUVB3MjlhQTIyV2FEQTFRWXlleDZpVGczNXhEcnAyVDNPSHY3?=
 =?utf-8?B?L1lKRFJqT240Q1FweGZqRGxvdkZvbUFrQU1wSTlLVHR5RFN6cXhhN3FsUms0?=
 =?utf-8?B?R1ZmU1YzSW1lLzlYWkVEMDNZVTJTS2cyNERXTUdhRzJsY2RCcE9PTWhOU2hI?=
 =?utf-8?B?SnFkaE9MY3JMNUZsN0ZZdjJ3eVV5OW1FSE1oVkZONFpNNEtPa0MyRHVzcUxP?=
 =?utf-8?B?SVJNRTJDZGU3KzVqby9mNEhlVlV0SkZyeGRERWQyR0NuYTZXeG5QYmptdkxQ?=
 =?utf-8?B?VStXN0J0WGxVb3pTSjAxcUhsQTFlY21CaitMWCtWQm5TaDFZdUJpUkhYTlow?=
 =?utf-8?B?T2NmczFaYnpXbnlpRjY0cXF5M3BGczZvSW9MbHRNR2p1V1l0eEI3MHVlcWdl?=
 =?utf-8?Q?9y9zN1d12wkUTwH7Tk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123fb38c-7dee-48bb-e97b-08df331ccca5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 04:51:29.6768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg2K37Gcz5lS7fhoukqCn2ZoS5vH1wE24lhjH3n1D6BpMQCETrwLHMiO9gBCgZWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 26-Oct-26 8:50 AM, Jesse Zhang wrote:
> The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, then has
> the CP write 0xDEADBEEF to it and polls for the new value.
> 
> Nothing orders the posted MMIO write against the CP's write, so it can
> land after it. The test then reads 0xCAFEDEAD forever and fails,
> although the CP executed the packet. A false ring test failure in a
> queue or pipe reset escalates the recovery to a full GPU reset.
> 
> Read the scratch register back before submitting the packet.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Patches 1-6 are

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 315dfd806d56..b7f9fa3cbd2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -587,6 +587,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>   	int r;
>   
>   	WREG32(scratch, 0xCAFEDEAD);
> +	/* Flush the posted write before the CP writes the test value. */
> +	RREG32(scratch);
>   	r = amdgpu_ring_alloc(ring, 5);
>   	if (r) {
>   		drm_err(adev_to_drm(adev), "cp failed to lock ring %d (%d).\n",

