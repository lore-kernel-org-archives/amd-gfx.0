Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22550C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 18:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06B561156
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 18:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D06B561156
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A736E1EC;
	Thu, 14 Oct 2021 18:46:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54DE6E1E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 18:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBPNnkrEg7qyuqRrBNnUdvWeN7vpem9NgwYVx0TRMhjws3Oj+lIrjrgAhfMUquzMnZIemJiLV328vm438EN/5vu0f99FRSdRObN80OgC23DP/1DYdHWriCVcDmZRB3x9EGcYqDVJZ+SrUH4s35xfTIlSMkLs9AcYAcVFvKFps1yIwVXysGh2FocKM5fTT63fjKa8+QG4FUQK2Amh9+rCYPLXQA+GaaKgkPxsvOQHX3yJhdk2++lpanuf6HNVzPVv9jJn6jCq+3Sqcq8ZeMPm8D8xlISqBF4OaxieEHCg18e5O9ZUM8mvNG1Pz7mt295ZFEHFbLUH12TMJBBnb8nrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/s8PtEhyFBrmxo//F2JaFQDh89pLNYCoy2BjDm5/Us=;
 b=EeyC/D/4WQx3L0E2i7M1kPY6/o9lq2wZdC8BnnwYnSO9WiChziIuivbN0tYh8h983JobD7Dnvqk4ZomRF/nUbQv37PxfRiurc3qzi4cYyM462PFXC2rl0ijeFN3fuacEogPVB0GGAKLQ3X3sfDtrbRpxoZ1Fzf28Pa8OlNTwze+JWn4/0Bj9JVUICt7mwRNJBI48WIMjCtCQ8k3nqkyGMhLkNsm1v9jWtStjYvr5YPbxGsoiCmQTIV5mZ9dy0jDdCrZB5z78mOnxBcOQw6rPQcM69kCcZ+VNQ9BMrKpRB5qXOUWbV5gWT2lrgwhY9Ra/bO46t/kDEL9NgoH6tVW6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/s8PtEhyFBrmxo//F2JaFQDh89pLNYCoy2BjDm5/Us=;
 b=cBzBFQuMksn/lSX5zqWQu9t3mBF5aLUgx28juTVQalOLUMcfILpNnn99UNlPvABkJUck/EM+nFGwPdkPwCayRa7A5ZwJRxF6ngTRlMdUQD6dHygW4h8muPCHmCBlOENE4BCQY671vxxQJ0NfKJV+/0tvhMSNOl+017Hu/z2Fip8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Thu, 14 Oct
 2021 18:46:14 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 18:46:14 +0000
Subject: Re: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sean.Keely@amd.com
References: <20211014181243.3343339-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <baa53b49-84f9-7a7e-2451-4bdef72aa789@amd.com>
Date: Thu, 14 Oct 2021 14:46:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211014181243.3343339-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 18:46:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac44ec5-aaa1-4b01-4be1-08d98f42e5f3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241E0A372B1E4A69DE47A7C92B89@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyjWt1f41rDj5jzW1VRhzFEBlkR7+Vshy98dGPlLtr/wOF1RYVfuX1uKLB0kVZYUmBIXwm3orJTx3Xf8g4btAR94MSoSRsmn+ao0ABTkrtP/4cI5GudOJ2nqK0WB2rodNKKP9Hc8zB/jFQblLle1RRTN1uV79uSYA5GdF4450HGdH/GFB/CfAJhN7AZzB1oJ2ldXvKEw7yS8uFmR2kWDrVMKYMwE8rdo6ocMftppzLr8pwIpuwwAq8KYOMZ8MKbgVprv4N50hkeoP5/PIpiM1TZtppyfOQ1V9kR7rz/CJ1j6RYmoLYj66/TcoQ9I9mMN2uRmG/dsKAU+Ir2l7MWVkEonq6etwqIOLe+AVEa7xa1yQjLgBw/18Md03oJMQkP1g0GrGwfxJo8MnLk6ud4qcg0Mtlksy8n97lFRcqXHOK/MJ5Yw591GwElJR6SpilH0bdEa2XkRc9AYUx/8Y8Kk+ShrC+Z1kSzsrXTUv+qOAM5mviVpIrxVXsoxAHrvO0/B3X/Rx3FOPK0nb+6CVi2T89yllmt/vYwLJnJjLf5jy9YLNaX/6y1FJ9dg75rpBx8BtzIfMg960SfSv45irFyREFv8dbzm6VBNeu8091Jfndp4fLyp74tS6ycwyNIkqaFMFXiXSfcULX0LL6gFcp8iftB4I+KQBv+OFXpknyKXhBxWI9J0Q6Ts0S7bGqF8uWdzzekwuh/WYSBZ4fzo4VOftP1PAU+Fz2PhYb6NigjUChZYonXxc5VwzW9WoobyaZoJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(316002)(16576012)(8936002)(66556008)(26005)(4001150100001)(5660300002)(66946007)(86362001)(31696002)(186003)(8676002)(83380400001)(36756003)(38100700002)(956004)(2616005)(66476007)(508600001)(6486002)(4326008)(44832011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdtaHp5aWV4WkxxMG1rWjNJTm1WT0FXNDNLMHdReURjTCt5aU5tQlFhS0x4?=
 =?utf-8?B?aHI2bnZpeHh0THo1THI0M0p5d3l3elRLdmpBQSttMUdyRHRYN3BORTNXS2JI?=
 =?utf-8?B?N2phZkdMeXQ2dTFYL2ppOGFQV1QxYjQxUkp4RGh4eVVLQVpCN3pGUFpHa0hS?=
 =?utf-8?B?aTNxL0RhSVBuTm54NFRieTRtOTVJU0ptWVI3cm5FOWNRSHF2OWprRXBnaFFU?=
 =?utf-8?B?MWttbjYvZXhMdE8va0xmcnJkVjlMU3JtTGsyMWwvYVMrWThPSXIrdVZEVU5j?=
 =?utf-8?B?bnBKWjdYazJ6YVhZa1pGTWxFdjdhclBZMDF1a2RZMlI0WXVSYVloQi9hM1J0?=
 =?utf-8?B?WmVybFZQYllPY2hMZU03dGs5bWE3aXArejY4TG5HVTIxNW1xUXoxT0lkZE8w?=
 =?utf-8?B?NmJiVHdvZHhvM3YzMHUyc3o2aEVKbG5IWWg0cEpDUVB4eVpPd3VRNXJPeks3?=
 =?utf-8?B?SnRLajVBSzVqZlZHaVFOZGZmZkY1MW9UaFUxNjltV2Nxd2h0TVNxdCtTcFM1?=
 =?utf-8?B?UEJwV0ZldllURmVydFFMNTdKQjhIbmJCQVMzUFJseHA0ZC8xOGgyTFYwa3Br?=
 =?utf-8?B?TldpSGFYK0Q0OFMyV0R6SFpjeVFzdUdFcVAybmNXVkZvSSt4Y2xlOU1KMWpM?=
 =?utf-8?B?aTNuODRVdVdzdklJVmRvZ3p2ZjBSNXZINDJxOWRMZitib0hzZytsVkNSUmJ0?=
 =?utf-8?B?U2J4ZVluckhPUHIranFHN2tsY1BlaHhXclV4RFBacXJBYnZiV2J1anJSV1VS?=
 =?utf-8?B?RU5NdUFiR3lJUEV6V09tYkxVVm5KYXlvUVdMYVpMbWxlQXpmVzllZDJaVXJR?=
 =?utf-8?B?TmhoSjVTTG00MFB0d3RUZ0tQV2tDa0kxNjNVQnlPRUZaelhzWnNCbzhsSXpY?=
 =?utf-8?B?bnFHdTU5MExpNGhVMzVrNzNmRWRrbm1aRDUzQ3RWQjYydko3ZTYvNXAyNW9h?=
 =?utf-8?B?RVo0Z2pOSk55UEljOWh5bUhoUEFLSlFVRnFIWXBVOXRhajBrMFNoK3pyK1V6?=
 =?utf-8?B?WnNNRE1kbWliSjE3R1Zyb0FuRTRPQlI1WGN3dW5ORzRzb3VWT3dvZTcwYi96?=
 =?utf-8?B?c1NaazR1TWFaZ2sxMGU0bGdZWXVXdk8xT0l4TXRveU05VHlwajEyemtpL1M2?=
 =?utf-8?B?bzVLQlIwb3dNSEJ0TlRXZlpRM25HMjdsTmNKVDFDbEhKeVRla0dXK2JMakpX?=
 =?utf-8?B?Y1NteVViQUNucUw5aEJBTm5oc0haRE5SSDdEZXRncUMrSnpQdDRsemJabHZR?=
 =?utf-8?B?N3FZUHFYRS9ScUxmdGY2U1F5OFJNNzR4Ym5zM1FnSVoxRFVqVlU1b1hrak1o?=
 =?utf-8?B?Y1BQYzdiVVV2ZVJxUWJ6ZWp0RDR2Wjc5QmM5N1lHUGc0Mmg1MTVrTURFN0sy?=
 =?utf-8?B?dm4rNGJXOGlLYVN2UEVnQkI1bndoYmJKT3J2YkFReXA1TnVyaTVweWpxSFBu?=
 =?utf-8?B?dEdIZGIrQjRqeTEyRGJwKzZVYUNXYWRoQWtiK2pEVytVenJNdU5zQzZubmti?=
 =?utf-8?B?Mjd2K095b0t0eXBNcUVIcUJYdWJGUnBkMTlPcUVMVVhBVVBTdE0ra1NTbmF5?=
 =?utf-8?B?NjN5a0dXNjFjQVFiUEZab0xEaUdobFh4djhpWU80dEtxVUVJTmNxeHBsTFEz?=
 =?utf-8?B?bnVNZlBoRnoxL29OekhsYlpmYlhNSGJNN0loMTc5RWJJSmZCTWRsK21Qa0V4?=
 =?utf-8?B?N2xtcWpkVis3SmdYcWtHdmxRQmhYTkhUSWV6Z1UwWEY2eXJiRGhUUkN5WHBK?=
 =?utf-8?B?OUxOeFU2Z3JNcmpNYzNkK3pScXZiaUJSd24raDR2bmp5T2laZ2JjUUpESFJp?=
 =?utf-8?B?bVMvL0RObkdRWTdmc3hRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac44ec5-aaa1-4b01-4be1-08d98f42e5f3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:46:13.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MNtwC0YV7N8O8lYcTjb2XlX0LQNxDe0RqVyg5zZLQCv7Us7o8330IfwjBMKfiTic8YWHUTCkE/tgRZ829a2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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

Am 2021-10-14 um 2:12 p.m. schrieb Jonathan Kim:
> ROCr needs to be able to identify all devices that have direct access to
> fine grain memory, which should include CPUs that are connected to GPUs
> over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
> CPU is part of the hive.
>
> v2: fixup to ensure all numa nodes get the hive id mapped
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 98cca5f2b27f..9fda4ee03813 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1296,6 +1296,26 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  
>  	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
>  
> +	adev = (struct amdgpu_device *)(gpu->kgd);
> +
> +	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
> +	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
> +		int i;
> +
> +		for (i = 0; i < proximity_domain; i++) {
> +			struct kfd_topology_device *to_dev =
> +						kfd_topology_device_by_proximity_domain(i);

Sorry, one more nit-pick. This loop is pretty inefficient (0(n^2))
because kfd_topolody_device_by_proximity_domain does a linear search
itself. It would be more efficient to just loop over the
topology_device_list directly here (while holding the read lock):

>         down_read(&topology_lock);
>
>         list_for_each_entry(top_dev, &topology_device_list, list) {
>                 ...
Regards,
  Felix


> +
> +			if (!to_dev)
> +				continue;
> +
> +			if (to_dev->gpu)
> +				break;
> +
> +			to_dev->node_props.hive_id = gpu->hive_id;
> +		}
> +	}
> +
>  	/* Check to see if this gpu device exists in the topology_device_list.
>  	 * If so, assign the gpu to that device,
>  	 * else create a Virtual CRAT for this gpu device and then parse that
> @@ -1457,7 +1477,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		dev->node_props.max_waves_per_simd = 10;
>  	}
>  
> -	adev = (struct amdgpu_device *)(dev->gpu->kgd);
>  	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
>  	dev->node_props.capability |=
>  		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
