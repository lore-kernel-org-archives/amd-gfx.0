Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8003AC54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 12:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B0B10E972;
	Thu, 21 Mar 2024 12:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMDd0gCn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199810E9B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 12:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm8/uM5523uIsY8DwI980wHP48GJBdxTG0zHHoLn6c4Lf7bNsI+61ITlv/pNkKDub72BPfqk5hd652qPvRoEI0IOhcBDTIFtdorQhFOajULoru6zIdvi9tw37W6hO0j7BCyuKsrZXtOPJkVSme+q+/eBqBe3aYbdPp5bbVt5Nlm2CeQ8z+QeX9q/w3T0oMN7o6skwMLmP/hvud+ErmjGLIW8oI83uaNvYV3hk8ErW6+CoonLXilsD7yf4Gbama1LBIQjf4EQCiZqChJARTouS7B/4iaAQwT9MJbuA1IDQTnfJH0ew1ECJuJ2Jr43yfdiqS7+V5Y6VVyXgqGIZEw0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPPHdBdVSOc690X2Nzskke7dHZZf6ZtHWbgiRSDgt6E=;
 b=aT07WKXUABPXEHKzIPrzK3LFOuoVZB5RIgaJSCXaztaG/CEKGNFsDS3yEpwhJMqFY/XATLM5gwVZwmOYkYQej89e7fSjJvxRuJIzQdDe5qERgQc9FKTnEFaUQVB28RcsbWeylfmwNCKQfmyh1H8w9EJs5BKOON08HrLhgKbNmGo/hQKGBOsUY0TYmhCg9NMObyY2Cy8dnnu5PCCYlZz4o7EXoEnGLAwdKpxzlhqr/hS6Zf+6uGzZcC5FU424H1Ycl04tWYAF8Kia7KNcNQElHadMwNSoBV80bYelYr3HjFTqfppQmCjiGZoESA+jZ7iiSdkztZUqjjiFYUSWQWE8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPPHdBdVSOc690X2Nzskke7dHZZf6ZtHWbgiRSDgt6E=;
 b=QMDd0gCn1ROWg/b3+PGjWyEfkrlrhbs7Jml18igIQXmqq67t2XFkP7GS1hy5BAmWM6oOYAGcnInkKscI8L4gFsbXZI2hq4emo89HxMnzTLTTytNMUUpRDhqYtKeGOVRZvZjoE7ugxe6+/ns2geqyr0HFxpXAYafHLszyJca5E5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 12:41:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 12:41:30 +0000
Message-ID: <fa45856a-cab9-46c1-85e2-1277fc956c70@amd.com>
Date: Thu, 21 Mar 2024 13:41:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Refine IB schedule error logging
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20240321123606.764092-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240321123606.764092-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 82749748-370a-4611-a84c-08dc49a43b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlXs6gqexIupmho9WEDENn4ro6T63lZIl08sbNC90IWii30Doc9vd5JHnCYtWrjZyxTjQ0G7E+EZRazbBcDS7dxhCBSOgDDr/4LwOgZ4M7GVI3RWeLC4mQvBG3gX9OahJwy724vC69b69OJWLQ93eZUejo7H9td9vgh3e+F1bYAWLHKetZZH7WreV5NMq/S4QZA+fqjvi/ummo+5p/M3fR3wGEEJ6L7gtlm8T16xJ0oVrRHgqkQEbitiRqA/rLodKN81WKk9hom5Md6I2rwVM6Kwtgz5mui/sL56V9PIdh9obyFB5lvPCSKsvmc9RAMbKCR9F64zOLikVSNjeWtgCuKwyRXV5Ob0eYbWNcwLk+40XsZmrrqHSCS0z3imPnF7T7yeXHXDivkn5rQe575E1hqFYkn06TO8CX2NX7EsckgT0hr/ca413LgvVTEJr2uVu2STeit079AQ8gMxShXTh29t9ArvqsqvkFb9vGVXvsENRZ8o/+CEcbBiXCQTfPsf4i44b4I9XqElN77Sdol3qrcBLJk2M1mc90wHA947O219KYbJgxeDKYhRyUUX6affCVjBKgseQj8iRslKQ6lhrx2def9J78LWPBvLuwTyhQ0fQSMWpvuc/QGblnbP3n9JiUNJebYr2gqrU9y9Y32VLF1h5T/oFyvfEYvcsNLqyys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2cvZUhoWTFTWGpDQldkK3R6THNoVWRKc1VoVW5BN2RSQ3ZKaG5DYkxqME9G?=
 =?utf-8?B?NWIyNDJKR2I1M0ExYW9mK1ppeDFUNHV6Szh4TVhNSC9FOGJoS3RaN1hzYnh4?=
 =?utf-8?B?YXk1cDZOYTZNcGo2bm5jSjVKRmpOK2NIV1lLbUVDSSs5VXZ4ZEpMRlF2ZlUr?=
 =?utf-8?B?Y0VXSUtEVmllV2VCR2FhRWh6RDc4eW9BTEZTU3FOblpVNjFWVGZvbG5uZHJv?=
 =?utf-8?B?N3VMWEc2ZDduUld6WERkUGt5eHVBSFdRZkV3M1hxdnljejhwVVRpSGdSOVZ1?=
 =?utf-8?B?YmxLVVB0LzhTc1pwYTQzcDN1cDY3WS9NUFRzQVAvaUFXVEw2dHlXTDZPcUhU?=
 =?utf-8?B?RHFRVUFCa2Izd2tHU1N0VHBLdFNpbW9LMjdSMUZoZ2xJMjcwdXBFOHFwTWRN?=
 =?utf-8?B?QjArKzFSbDdXbEZKSFlBNVJ1UERxR3JtT0JLSFRWdFhKcTM0STRxdUlWNDNs?=
 =?utf-8?B?L0lQa3FyZWRXOUl4ZHJ1dWpyc0lMNGRWUUpxSzNiTHRONlZyZFdzR1FSVjh2?=
 =?utf-8?B?YlA0VktadEtyVVZQU0NBM1pTcDYxTk1qSFIzekI0RWpGNVZvRFlRMXBYTzBK?=
 =?utf-8?B?TU1GMHNxZTJ1U0RjdkpuL1NpeDZiNHEvaXc4ZXlTRzJ3OWo5VWZCYTVKS2dr?=
 =?utf-8?B?d2tKZDliejVKdTdzczlDQ1p3bVFRdlZaODlvUjJNeG1tL0p3aEliS2JMZmZs?=
 =?utf-8?B?T05RR0VKbXo3bGZRNElsMWRTd3hiL3RkeW4yZUxYVy81b3VWNDhVNHV5bFA5?=
 =?utf-8?B?QTF5NHM0MWFtQmJpOEJNV25mcVk0ZWNoSE5zKzJHVyt2TFNxQnBJdWF2QzFI?=
 =?utf-8?B?UURIR1A5dlVwYWRrY1h0N1VsWDRCQ04zdVc0Q0kySmEvNHZZS0VGQlkvWWVt?=
 =?utf-8?B?SzVGaFhBdytUMHhMdUQ4d25vVDR1Z2RSa0g1dnRCdGFFOG5laW45V3pNeEJ0?=
 =?utf-8?B?Y0ppdmp2N2xtUkw5azd0ZEtJL3pGYzlqaU84S0pEQzIwd0RTbmlZYkl6ZkZv?=
 =?utf-8?B?YXlXUjJQN3dtcTBzMDV1RmZjSVVHUXg5aVVWUy9DRzN6aGxPYjhjSTV6WEI5?=
 =?utf-8?B?MG9USW9RdmdjU3JyRWJQQmw2bmYrbWl0d2VFbmRyNzQrWnhQVU1KMFcyeXli?=
 =?utf-8?B?ekR5ZlFsZjYrV0pVTDNTbTNxM0RSOWNBUEoyOE9jZnd2TUQ4NCtZcExORDJN?=
 =?utf-8?B?SUVCWlNxN2tKdkJFeUlyb0pLc1RIa1o3dzJJSjlJV1huN24rYS91RUc3ZGpE?=
 =?utf-8?B?aGptYWloTXozMDE1UnFWcnpqazJkaTJIREtVQjVzNXAwQVowUDlUU2FXWmtk?=
 =?utf-8?B?djJSWkJnTkkwL3NBRFBTNW9TV2FwSXlxMms2K0hwOVRIZHdySC9lMFFiY3ZF?=
 =?utf-8?B?YzYrQWtsaEpvQzN1MVFoUzNieC9oTjJQaDRXRkdFTGtMVEI2M0UrcjZ3OVQw?=
 =?utf-8?B?clNYRHdDSXBCRmJ5T29ZMVVEemZBelJadXpWZDc0WWJQWjUrZ1o4OFpBT0Fn?=
 =?utf-8?B?SFNLMTZPaWxkR01FR3B6OEJYc1BpU2xDUlpYUjhoakRmdytvMDNCcHhMcmZv?=
 =?utf-8?B?MDhNRVFidXF4Q2hiWXVwSWJqK245U1BMVWNzREQrelorM1krbkp3bkluc3Jo?=
 =?utf-8?B?c1plRVpoWHJDWk1TRXNvenhZOUpCSGxpR1hWUmpYZk1ucjhWckFLTlZhNXRN?=
 =?utf-8?B?eDVUNmJlME1NVzAwdzVhSTdhT3dwMHd3TG1oc2lscHk0ZVFCRjBYVDgwTGRO?=
 =?utf-8?B?UkU4SklLTTVBaTZBY1N6aTRjU1o4VEdGK2FoYVdkQlVNb3Z3YUdrM3V4VUFP?=
 =?utf-8?B?RlpmRSt4czIybWZWdUtOcXlXZ2tidmZuQm5IYjdSRjJmSkhzZWR1UVI1RU9y?=
 =?utf-8?B?eEpoclB3QnZQdUt0TXc3NHpYZnpKM0tCVGtSYXM3YnhhRjQzRVpDcktGZnZz?=
 =?utf-8?B?MjVBWTVEUGVXY0NrejIxcnBpMElTb0dNaWh6UnIzQWljcjByWWhzY1Z2VmpN?=
 =?utf-8?B?N3B2TGNqcUtjelBOQ3NwMEVIMHB2Uno1UWxMZU9zWlV3SEJscE1KVEo5Z053?=
 =?utf-8?B?cTJoc1ZlTmV6WUZFZlo5MzFybksxRGhwV0hkelpnMGRkbDhvaWFpbTNaRnZD?=
 =?utf-8?Q?1fZhMJwngQAk2aWjksxj87JI6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82749748-370a-4611-a84c-08dc49a43b59
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 12:41:30.1822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syBXHbT0nJAEXz6WRi+ByyFyrqYKgsCSe9jzRny4MI9ejdbRC60+0wY1+UmZp2zD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

Am 21.03.24 um 13:36 schrieb Lijo Lazar:
> Downgrade to debug information when IBs are skipped. Also, use dev_* to
> identify the device.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4b3000c21ef2..e4742b65032d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -304,12 +304,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		dma_fence_set_error(finished, -ECANCELED);
>   
>   	if (finished->error < 0) {
> -		DRM_INFO("Skip scheduling IBs!\n");
> +		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
> +			ring->name);
>   	} else {
>   		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>   				       &fence);
>   		if (r)
> -			DRM_ERROR("Error scheduling IBs (%d)\n", r);
> +			dev_err(adev->dev,
> +				"Error scheduling IBs (%d) in ring(%s)", r,
> +				ring->name);
>   	}
>   
>   	job->job_run_counter++;

