Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3332C3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 13:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7481410E5F6;
	Tue, 20 May 2025 13:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHfU6OCE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D5310E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 13:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6HhaO9LPW+o37uCTxzQ8wCZkOXfwbTU2P4njxyTPbpVDo/WaNUX/KSCqUeb43vLdrTAIQDGg9RTXSP8xmdzj8iAidT0F/KtKPt59PPYIt8bL+qqu4D741IjrUiKKMxIus4TfGlI24PewGqbO+DeuqjIS/cW1bJ5TT5eQ67zs0eiYKnYynK1yRYkTfYU1FfqH+uHOII/L/QAMdcCh/w0W6Zx59FkfS8LLjGC6/Fu8IgKK6P6MobEsht/USK6krcAMg5s5BTYBpWsH1gfbSiLgnEe8SfggWgtB230j/VLbNmwNL852aGQsuvuHRl7SbeC0fHZJt2ZbPsv3Bzi8HpI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXAvtWAcYb8SsjZwhopJNLVP+T+QvFTBaLPRUqkDdwM=;
 b=R7Y4RGquFrHlqST2T2SNJ2zycL+lfGdI5mq6ZQfWz3lULTzBWcgA+cMBK31tl47BxE5bsPWSumYvSOSjkRXCLOy8EHqE+CCcopquuxOZ8mBNrn1UCFjEDcxdToYLN4stT2MRmBwYD/TNbuRDpRHqysoiliXSjEp6WZ8cVAC5lvchI28mMlhJXECsyO6gJBVY0ZK66et/y+hQoxzxzAp2GLQTqv1dU96qVA99H4Ev3K0hvJJYxz40tqou2fbkr23IfWk9KYI7VQrCcKHGVtMBs90fuQfC5ZHkAmKrK0FV3DSffGVlUuE3HvDQdIAQtVUj/FPui19PbfzmN8Ieh+ByEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXAvtWAcYb8SsjZwhopJNLVP+T+QvFTBaLPRUqkDdwM=;
 b=jHfU6OCEAviB6Ssj+pBHwk6T+cFoz+8U/CnyiO0d+DYOMZK9Q5TzdP+sduttM76eig1vJ/QhLVPX7MRE+CH6DLHkoqMZ9yx14VMOmNIZQAfiNJ4HJks23TVI3J//exvjsPHnzLn50P66XaxJdsIPlZf6pqneTrF3qIBSfaVcmBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 13:49:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 13:49:11 +0000
Message-ID: <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
Date: Tue, 20 May 2025 15:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
 <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3893fb-5191-4352-3fbe-08dd97a519c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEdBN1ZDdlhWMzNvV2lVQ2RqdW02Sng0VjhhVzlKK2JrUjNVR3ZraUVMTjM4?=
 =?utf-8?B?V1hYd3Vnb0dUNHNPN1I3cDIwMGEyOTVvNGxpbVd5UWpUOW1sZEUxdGJoQjBv?=
 =?utf-8?B?WmEzc2V0Z2cvOHdZanBvbCtvVEZBYlJONWJZNS9ITmVkdGRQR21YWDlVUG81?=
 =?utf-8?B?S3VLWG1yRGRTQTgrd3dlRkY4ZXA2Rm1zaVdEemdIS1JLQUJIQTBHNVljR0w0?=
 =?utf-8?B?MWhhYmZvbE1BSmNFYkhaRGZmUjFRQ3ZZUG9KOXB2SUdZSHZwVDdtRTEvbWJm?=
 =?utf-8?B?bHlOclV4a3BHSTlZdVJOb1hJcGo2VE1ab3pGVUVZSzFCa29HejA0aTFDOGx5?=
 =?utf-8?B?VCt3RWF3Z3BCUmFZTGZuVFZJVkhWOFp3bnhwWHlQR2VQTVJ4M2JiZURsQUxY?=
 =?utf-8?B?ZUNuVjBYMUpJd1lmTWhMMzlZallnSjYvOWlkeXM1L0YyUlAvS1RQM0t5TVF2?=
 =?utf-8?B?OWdneDhEaWFoM1lQRFNzRldYQW9jN0M1ZU02bG9MZTFQb3JmYmdEZGMyejl6?=
 =?utf-8?B?YzlNL1NDandBaExGUGN5NnQ0cVV2WlJYbWhiS2F5YXhKV2hMQ2I2SlA3c0xi?=
 =?utf-8?B?Vys2dnNVRDJ2L2pIR3ljako4cjFUSG5hNVJIK0VGUThsRkRCWnZpSGh5ZFE0?=
 =?utf-8?B?Vll5dHZpRU1XWjZVYUhQaUd1emZiOTFtZ1plK2NlaGpPS0l3a1pXUmpKaTZX?=
 =?utf-8?B?ZHU3bjdxRmNpWlFlL0JOVXNxdjVjTGlVeEV3QWJzcVBqVjRNeG5iNWFqZGV0?=
 =?utf-8?B?eEw2Z2I2TUZSQUVLSnlrT2pyVkc3Y0wvZWFaZEdtSkdTamlFNEpSb0dNemxl?=
 =?utf-8?B?THdXQXRySVdUZ0hidjFHMlNlU3kyK2Z1MmU1U2ZlMXEybVBnSlUrT0orYTRS?=
 =?utf-8?B?d01GUnk1M1ZFYnAzMk9OMCttSGNxVnRkSkpJSjVZMTVDdG9FUklBdWlzUWRY?=
 =?utf-8?B?bzExNkN3VldFZHJWajM3R3R6SUR3L25Zbnk2L2p1bGRIUWt3b1cvNjVIYW5v?=
 =?utf-8?B?dVBLTjZnVVlWTkphMXlZbXN0Y0FwV2NhbVJNQklMN1ptdC8zSWlHSThnVjRT?=
 =?utf-8?B?Q2xtZHgwVTAyd1QrRVlXWkE1cVVpQVpXYlhPb1BNc2t3YUd4UE10N1RLcEtP?=
 =?utf-8?B?WDM4WVNiNU4zTVpjeDRaSUNBVDZpN21jYWRLS2F4RlB5TEdobzdHWnlQTG14?=
 =?utf-8?B?NVRFVmxzTkFrK1ljV1lTNjZHUGprNCtvb3Vtd240WXFiM2xvMW9nTEI5dlVT?=
 =?utf-8?B?dSt0NElVeUpVNG5TRlZSV0FQSUpqOXVrYjFJRzFnTUd2VlF2c2xzWi9ZbTYz?=
 =?utf-8?B?UXRiS1ExRmx1T0pQeDlZTnNDekJNQ2NnVDNqK1R5OHRScm5XOTlCK3N1Y21S?=
 =?utf-8?B?R3VnZ1NiT3hpU3UvMldaTHhEcVArU20xS0pwT08rNXk0K2hncG5rMkR6T0RF?=
 =?utf-8?B?aXY4NEY0a3lhWG9wK0ZlaktOQXg5d2p2KzZJZTVTYkRWTFdhWEhDVVZpNDVx?=
 =?utf-8?B?aE11YlllWm5TN2EwL0hvM3ZZN2xyOWR6dWpVaXlMUW1OWFBycmJJZXQwNGFn?=
 =?utf-8?B?RWhKQ1NvR1B6QWc3bGpnRjEyNEtwNU83Sk1pWitFdDZveTFnV3huS252ZlRa?=
 =?utf-8?B?VmRuU1NhUkpUazlYdHQyUVgrQkQwVGV3N1Y4RjY0Tk9HOVFYWmRCeCs3WEh6?=
 =?utf-8?B?VU5SMERqeE1iSCsvZVFRblppclB0Tk1rOExvNXZEdzFjSlFzUVd4UTJhTzdh?=
 =?utf-8?B?a01LQStHTXMwaXorbkkwc3dnSTc3QkU2MmdPSzgxSGRDOW51TTQ0emtCdi9U?=
 =?utf-8?B?cG5FMUMzU0gxcFN3Si9DOGZRQURBQkdBdkNYTzlBeC95WlIxYVlRaUs0SkZk?=
 =?utf-8?B?OFV4ZlpmTWllbmJNdjdsVkVROGV5ZGJIRm5mTFhLTmxDNk5kclptZjhtVko1?=
 =?utf-8?Q?LJGFUsJEnuw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhLOXFyazBoNlR0WUNmNDAwZm1aaVdjUk1Ic0dOZjZaUkFMSk5vMmJPNUoz?=
 =?utf-8?B?Smx5bndvR2psd0hTWDFNcDB3aFQyQzJITDBrU0ltY285bTk2V09xZmNuWlRp?=
 =?utf-8?B?YmFxblFhdkNxUTdaUFBOek13SU1kSUlHV0w2K3FIdUNPN3oweFp5eFBEYjg2?=
 =?utf-8?B?VEd4TDl3MS93a2pudlhqT2FHNDQ4RkhSQjVqZFI2SnVRdTZFZXVjYkV5bFhw?=
 =?utf-8?B?VXhNeVJFa2hybmtzbm9CWlZPdkFBQTYrT3Z3ZXcxY1VWK3BMM1ZFdmMxVDdP?=
 =?utf-8?B?VUhjeW9KTURmckhFUUxpSUFzRlpPTldPZXU2VFBqRDlWTERnVGtSMnpLUDhL?=
 =?utf-8?B?T3lkNjI2b3NHU2s1RkJ6TTMwN1ZCSG54SmQ3K1BWTXkrcHFFZEVxcDRQL01v?=
 =?utf-8?B?bWM3T1N5cE5IZlliVHZDeFlteWo1dGhRdWdJdFd6RWJ5czBxSUlpZStHUEo4?=
 =?utf-8?B?eGdzbVdNMlRvZGN3VnVtZ2FpejVtbGJTTmsxREhvbmQrV3A2WmxDOStoM1pJ?=
 =?utf-8?B?bjdCOFZIV0ZPdWhsUjFRSWFsSVFwWG9NSkZVeHBUZG8zUlM5eklCdUpnM0J6?=
 =?utf-8?B?djJIRmJWYjRMWjdxVkdjWTE5U1NaaHN1NW5oVXdpVXR1eW5pdjE4VVlWVlRE?=
 =?utf-8?B?Z0xPcjNwMFVpNDN0U1kyUmQvNUJWUEs5UXZBM2pjQUVFYldiV21wejMwUUt5?=
 =?utf-8?B?Yk9FdmYvQ0Foa0RwMHg2OVBBcU1RakpwRnlwUURDWTlvZWM3RjFzTjVRQ1NG?=
 =?utf-8?B?NHp0c0NaaWg2eC9qVVVxRjFoSDRBMkZGVjh1THBDRHJZdDQ5YlNpRVBMUkc2?=
 =?utf-8?B?VitFWVgwVjFtbUdMU1RvN05LMWpDWGtFbHpqTERCNE00M2lzUFNZb3ZxT1po?=
 =?utf-8?B?OEUyQWpOOXYzSzYzNk1mNlVXVGRZU0I4L1pJOW1PVUVvNGFDNjIwa2RmNUcv?=
 =?utf-8?B?TUZJa0lCVDdML2pSU0ZzcU5hOFJNd0JETllpcERxZkZwZFpHM2dHQmF3a0NN?=
 =?utf-8?B?OUhrYWxhVGM5d1lzS3dseGFTUFdKMFRtR2lQNm1QdnlWY0tuQ2puU0k5Wk9J?=
 =?utf-8?B?SW5xZVIzdmZZOFU0VXA4RnBYMEZGekVBbkVKUUFoQ1ZUU1YwdkxYbGNCelg4?=
 =?utf-8?B?S2trd1BKTlZZZnJWK0J4QThZTEdaV2RQS2xFNkFsY092cndjMW5VYWFER1NG?=
 =?utf-8?B?dzY4V1lWMmdpM0pxZDhqZGRDZlZVWmlsUmlHcWYwSktQWnR0WllSYzRBWHpF?=
 =?utf-8?B?ZEtjOFlnSC9NK3ErNVZVVHhySjVVR1oxL0tzQmZXaGdadnhaNlFCeGEvMjZl?=
 =?utf-8?B?UjdWQVlxOXB2V01ZOE8yblJJRnVSOThueklQRjVlb2VzUy9pbUw3OFhEOEVB?=
 =?utf-8?B?QVA5ajlnZDNoVzJGdHcyT2EzVmJ2Yi9yY3JSU1dOY1UyZVlJUEJ2dDA1ODh3?=
 =?utf-8?B?QWZiSUNvcWhhSlpQTDFEdTRJRWh4TEFmelB5V0QxQXlaSUFPcjB3VTRKa0ZH?=
 =?utf-8?B?SjYrbGxOd2NtMW4wVDJOZC95Z0ZuUVVTcC9iYnpDcUVNeHhsSk5zNEllRGFw?=
 =?utf-8?B?SFJJeDdreUgwOWNtZnBOY3JkcWV2ajJqQ0tYeW0zY0p6Y1lVZzNhOWV1THZr?=
 =?utf-8?B?WENoeFIwNTd6d0ZlQk14K2dVcWEyYlAyUS9kQS8xNlF4bUZnZng3elNlMjBs?=
 =?utf-8?B?aUJjL2h5aE9pRzdZQVIvVGQ4ZWR1QWxuVW85dEVlV1RlTmxDRVQ3ME1aSlls?=
 =?utf-8?B?clBDazR1V1hZdUJNcW1maDF5Rm9OcUZJWkFjVk5COFR6UEhFaTBDYzNVYnVQ?=
 =?utf-8?B?am81SGtpSjNkSy85Z1dxMWxxSk5vRjRWdExYNjlwS3plKzVOSWdZUDQ2NmNq?=
 =?utf-8?B?K0wyQnpvR2ZvS3JYWDBFdVlLc1AySzNCSEgyT0VVN2tSRnkzTFZkTWo5V1pM?=
 =?utf-8?B?UkVYa3hTcDRoTXRic0pzRGk2bHRVZXQ1bWdkQ1BJbXlSWUNiU1BsUFJnMDNv?=
 =?utf-8?B?QzVsUjZtTnJmZ2pNSWorNUxxQnA3T1JKN3RKcjRPMFlrVjAwVkVkZmZ5R3o5?=
 =?utf-8?B?WE82ZUk2VTJuckNPTzljQ3hDZ203d29BT0llU203Q0E1MXIrczJ3a0FNczZ2?=
 =?utf-8?Q?HFmw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3893fb-5191-4352-3fbe-08dd97a519c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:49:11.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3JmVeVDqehSmcilWQRfTWy7lHy5Oi5k9AcH3DnKpVYtIlxVhka4hhVRYRbtydOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

On 5/20/25 15:09, Alex Deucher wrote:
> On Mon, May 19, 2025 at 2:30 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>
>> Stopping the scheduler for queue reset is generally a good idea because
>> it prevents any worker from touching the ring buffer.
>>
>> But using amdgpu_fence_driver_force_completion() before restarting it was
>> a really bad idea because it marked fences as failed while the work was
>> potentially still running.
>>
>> Stop doing that and cleanup the comment a bit.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index acb21fc8b3ce5..a0fab947143b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>>                 bool is_guilty;
>>
>> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
>> -               /* stop the scheduler, but don't mess with the
>> -                * bad job yet because if ring reset fails
>> -                * we'll fall back to full GPU reset.
>> +               dev_err(adev->dev, "Starting %s ring reset\n",
>> +                       s_job->sched->name);
>> +
>> +               /*
>> +                * Stop the scheduler to prevent anybody else from touching the
>> +                * ring buffer.
>>                  */
>>                 drm_sched_wqueue_stop(&ring->sched);
>>
>> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>
>>                 r = amdgpu_ring_reset(ring, job->vmid);
>>                 if (!r) {
>> -                       if (amdgpu_ring_sched_ready(ring))
>> -                               drm_sched_stop(&ring->sched, s_job);
>> -                       if (is_guilty) {
>> +                       if (is_guilty)
>>                                 atomic_inc(&ring->adev->gpu_reset_counter);
>> -                               amdgpu_fence_driver_force_completion(ring);
> 
> Do we still need this in the case of rings where we reset the entire
> queue?  E.g., compute or VCN?  In which case we should move this to
> the ring->reset callback.

No, it shouldn't be necessary in the first place as long as the rings still execute their fence packages.

And that should be the case at least for both graphics and compute.

Forcing completion only makes sense when the whole ASIC was resetted and nothing executed any more.

Regards,
Christian.


> 
> Alex
> 
>> -                       }
>> -                       if (amdgpu_ring_sched_ready(ring))
>> -                               drm_sched_start(&ring->sched, 0);
>> -                       dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
>> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>> +                       drm_sched_wqueue_start(&ring->sched);
>> +                       dev_err(adev->dev, "Ring %s reset succeeded\n",
>> +                               ring->sched.name);
>> +                       drm_dev_wedged_event(adev_to_drm(adev),
>> +                                            DRM_WEDGE_RECOVERY_NONE);
>>                         goto exit;
>>                 }
>> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
>> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>>         }
>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>
>> --
>> 2.49.0
>>

