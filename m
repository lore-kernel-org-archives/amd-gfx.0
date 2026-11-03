Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEB606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fusUoI88
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7144B10E357;
	Tue,  3 Nov 2026 22:30:33 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D87C10E3C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 22:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpMlkQUzCsiIyUo+Fdiv+FqFrltjP+5n2T5HFSNIa39NeMq+jF6cH1YDvGh2dRd9cKuxetdle111ouDdudVbXzZlF+Z1T6EoQceZ1tzWSoP/R2/nBN7iFoN32854RzYl1MFxeFGPCFoCH+s5e8SG2QoUFpXaDaBuMfQn21zBWwjFraU1D1Z9WRlNTsKKgfwU6XQF45Bz/GyZW/he+RQvhF2WWeONAl7qbwRIJdbIFOELIti5V9MPrPO4b8h5Pzjf9ge3hpkVPbcZEUKWqc/tb7m8AXxbc8tXRzxJJBdVAF9yFxlOwkZIT2b4HHYqch+HsvNWXg0docwT0u232TXBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV747uM0MU0bTTywjUF9z3FIWq28w9DqWq5Lmnt07zM=;
 b=f/N0p+XjLv2GnEXw8sWmFrEkGPfk3omE4StPFJeo3F2J1zUfqqno0YFl5BCVmwk13rUDAgLEerDqvbUOPQ4ZicW33/hMiB2ScoXdboj4mMewKQ5CSjq9XMdbw2qzMTkyMfnTtjmvnRGfgqmM2Fu+/6w1Atkez2+0YYxxEteRrtIGsIv8RsHUd3GQ5c075OU7akmRwolggBfl6DPIzKj5R46rfTCi7ZJo1JXtneRo7gfD+xhvZ/ahGb3dn5VUVH/qKX1oR6xBxgYzjX7jsLwpVS9QFF2YYyUW6nrcicftUm2zm+U30XD+DZSIZ3CusK10xsxEc3LYCtKZZoFsZfv50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV747uM0MU0bTTywjUF9z3FIWq28w9DqWq5Lmnt07zM=;
 b=fusUoI88gsiZ6KsPuXzetyaTV6+oN+9UcS48h+kb48QutO5q/1sp6cMvXFJkpfT9vEQ2Joo5AcEaup546ht/I8nafocEs6F5oINemVmtIHuEA1Adm9q98ZMT95+FqPhnz3mpyzZL3L2tpK7mz0vg17lmj0lA/VAo21gPSfgIfcU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 22:30:19 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::3889:6812:bb6d:7411]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::3889:6812:bb6d:7411%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:30:18 +0000
Content-Type: multipart/alternative;
 boundary="------------kGR2wqWYgrlRERQ9O0pQ8wO3"
Message-ID: <bac8a9bf-7511-454f-b1df-99b7f0583a23@amd.com>
Date: Tue, 3 Nov 2026 17:30:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-4-mukul.joshi@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261102160125.2743750-4-mukul.joshi@amd.com>
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To CH0PR12MB5156.namprd12.prod.outlook.com
 (2603:10b6:610:bb::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5156:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 35368f5e-edee-4d23-0c33-08df39fa09eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022105027099003|261021121427099003|261021123027099003|261009223027099003|11063799006|261102123227099003|261102130727099003|261026140227099003|261026121527099003|261028144727099003|4143699003|10067099003|56012099006|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: NlfyzRK81aShX/BXkQZc2jJ2LoH4L0NwkxL1Inujh9NoeSJ1D0z5b9yHKYco3ofKTMf8X/BH48keZWjkhG7ShJh/YMD5wepsJUhEu+/3l14BCkdvqr5uUbieWkFwpNWjWdkGYx2ShJgIrZLN2Uw8xY6dpBI2nwh5TCRH+s6Td96mDp1Dux0o3Ex9xHlEFPsOkMAHLr76sSSKiWJtka0RuVtsqfhhOUdZzUr3HPMdvBRgTsAaZf6hfg2TOwfwId2YV+ME6+vDSnOOxAJBPjK8+86PuGp7gr4gvWLxALkn1Y1clXjPy6z3AXfa4n5tx+ZspsrVkYBvSY1jMG1QSlyMCSUhN8P94gd+KwU2x2jJCO6rLcG3M3Fjvui8hW5m6U+ZDbbWxyOF0J3+Za7mYzv2cuLn9k5C9sG/b6FV5dciH6+0FHpTeJkyUkI79/Ohbiud2B70JLQljKRrnLRwAfFh6DYhVuJgKCwidN+rBS+ZKdHc421u8skuOhd5IGH21Jb1THRSCchno8x5METxWB+xGAFF/V37gStJdHYcREfM+/ECyKhiQb3opk6bxBK7kgksbrpKguQekBf3GoLyGTfBXxBrH9UaGsk1tTTqy2Hxm4LRdRrR0/XUKrBsXoYUVFGlapDt5Ung/9doRR92sp4IiwGFi2YC2Gb1iriHgWv84TM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(261102123227099003)(261102130727099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVliWGJTKzFvcWdwRGEyTlVHUUV0S2JiTTlhZ0VhUkh5Yk9vVVpZcXRia2Qv?=
 =?utf-8?B?WnVjdkZhOGNQbStDcnZ2OHhEUnZ6Ri9DUmlpVGFkMGkvVnB4d2NkeE1kNTJl?=
 =?utf-8?B?K2RjMEdKNmtpMzUvNjA1RlRnb3htMU4wdFdoS1FDVlArWDQ0SUJyQXRzQm5i?=
 =?utf-8?B?dkhIN3ZNMTZBcEJXTDdKd2Jza1UxWnRGYTM2Q1hSd0dBbVVqZkY3eDZUSnk4?=
 =?utf-8?B?RFdBWXc0czdJQS9QVGVEcGpkK2pYcGhQWXNHTWQwdC9aVmpacEUxVndXS3cw?=
 =?utf-8?B?VGhYMEZ3VzU3YTFIcXRkQWVSeFZQNWhsNXdIMVZNWGIyQTB1ekNYYWh3QU1G?=
 =?utf-8?B?UWpXMzd0bG1rNTNLTzEzUVM5RXZ5RU9oaGtkdFpKZWRjOUVKQnJSZi9ScGs4?=
 =?utf-8?B?SGk2WlRPaU8xMElKdURPYVI3KzJubHpjRjRFc01ZUUl2eU1jaXJNWTkyL1hq?=
 =?utf-8?B?MVU1MlFnZFl6YXpYUjA5dnpVL1gzY25PSEJpUTVPNmxlOW9mOWxnc1dYeHFT?=
 =?utf-8?B?aVQrYmpqa210cUQ0WExNM2NOdENadGlpalptZHhjSzFXbHc0UHlROFRLd2ZJ?=
 =?utf-8?B?VGduM2s0SVFCOFl6cFNqN2NWVk9TdlB2amRGZTliZWhzdFpJZTExK3VUWlhy?=
 =?utf-8?B?SFk3TytuRVdrTnd1cXZmMGtPQ1ZrdDdnYU94a0Y2c1pjS2Q2dGxqUVdVT2ZK?=
 =?utf-8?B?OTBzT3N3S0hZc21PVExNSStCQVJPTDRwNTFPaFZNbFpMZUZmUk9jNTQyVVJK?=
 =?utf-8?B?NTVWUHZzcGpoWFY4TE5iK2tCSnZ1LzJoYVNKNzNUaTdTbVJJVU9sYzhYRVN5?=
 =?utf-8?B?SWRaM0NtYzdGNUhsYXhhZXl6ckREWndIWXphN1FWSy9hQmNPV3BzeVlMaU5q?=
 =?utf-8?B?dmtvUFpWUmJ1eDVuTUs2ZGFzbzJ5TFBjckNuVGpEalR2Mlk3K00vSmJqdmlI?=
 =?utf-8?B?d3JtL3VNMGJSZVBXNk1PRnREa1pJRWNDVWIxNzRzbmtPb1FFbTI4SWdrS1ZT?=
 =?utf-8?B?VXFTTDIwSTdnL2NoWkY4MnFJWUxDVzg5WGtTN0dqRVJ3V3Z6QlA1Tm1yQm95?=
 =?utf-8?B?Y1Z2L2tlZ0xvSVNMK1lFUm5qbndtbWltendsdUNaSzNYRkIraDB5T09nSjBJ?=
 =?utf-8?B?NWEwSGd3U202cXgzcFZHN2prbXNuR1F2b0kvb0hXR3U5cGY1K3VvanFVRklY?=
 =?utf-8?B?Y2JaUVVsYnpGV3FEeWw4UFRoYjd5SnlGUmo3d0xYVG9RV1AramY1ZVZ0Q3Jw?=
 =?utf-8?B?SUlaTElkeVgzaUpQRVlTMCtpRGNrVFI3dTErRGExWnBlTThzbVFVbjlpc0Jj?=
 =?utf-8?B?Y0E2ZEREQlNjV1VPRkZtaS9PZUVNOURwUDRFNUJqbVUwbTBxaGFoSm9hbEox?=
 =?utf-8?B?SDVmb25PNjZ1OXVxMWFleFBHUC9QRHpsWkJ1akpZZTZZbFZmNjU2TnNvT1F6?=
 =?utf-8?B?RGlVeGhhamR0N0xmWE9zR2l1VEVtOUphaHNvNUhNa1phMDZuV2dZd3htK1Vi?=
 =?utf-8?B?TU9mdXN2Zk52b2ZkZTREN1UzUTMxcTdEQVhuQTRrVGpWMHZLOXpKMFd2YnZY?=
 =?utf-8?B?Qkt2aER2dFRrSENvK3p5VUxwWU10ZWgwa0gwS0FkQS9BaVdBS1ZSS3lQejE1?=
 =?utf-8?B?bjMyUUl2NHVSNEYrUkVVbmdjNElEdldxUE8zOGlobENJemp1a01WazA4WEZ5?=
 =?utf-8?B?bVhIUGtCNW9PWmlQYVo1MXE4anluSjl4YzFnWm5wQVUrbUtLT28wVVk3VGxj?=
 =?utf-8?B?aVhRdkY4TlM1MitHMWQrRGIvTG1JQk5PUEhPYk9RSFh0SThzbGdscTZyR2hS?=
 =?utf-8?B?MDl5cm5wZ3FLSGUwM2hGTnpmZ2k1RnBLT2VVMGxWWHlSNXEwUEpISXRvUnVE?=
 =?utf-8?B?eW84U0pCYkh4dlJmTEhpdDdkdU9CdEZienNRcUI0eXhMRFovVytRUmJ2RU44?=
 =?utf-8?B?WVdEUmZvclB6Yy9UeGJJNmFCRmMxL0lFOTBOL2EwZVVuc21SK0Q4NVVZU2dB?=
 =?utf-8?B?elNCZUJFZ1o1WVZuSGFxNjBYbnVFbFArQzVoUDZEVjYrQ3QwM0NPcEdBY1Y0?=
 =?utf-8?B?ektvaVlJaVNrclhHZlBSZmhJZC9nZ0FHRnRNYTdCZHcyL0RMU0hsZEI0RjZ1?=
 =?utf-8?B?SmZJcmZtMkZFb0pXUjBNd2JLTjZjWXlpMW82cis3S0p0VmdwMnYyQVZTOTFy?=
 =?utf-8?B?dGhoUXlKNVhqWnpKcVZuZ2lZKzBRaUhBSzBsME9Eci8rdXo1bjFoQ1Q3TFFN?=
 =?utf-8?B?Z05BaFI2YXdRTE0vbnJuTCtkejlWM0twZWlyODNESENsa1dTNnhMdjBVM2xQ?=
 =?utf-8?Q?uSsXJaTF9JjwVFI4Eq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35368f5e-edee-4d23-0c33-08df39fa09eb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:30:18.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiK4+DJ2lXuuy60CDIlN+ow1HqcrXs4alsGCGSQMZaWZ6Asrj0r6flOs6QGFYPvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------kGR2wqWYgrlRERQ9O0pQ8wO3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer. The exporter is the one physical station, so the only path
> the HW serves is importer -> exporter. A message the exporter sends to
> the importer cannot be delivered by the MP nHT.
>
> Emulate that direction in SW: when loopback is enabled and a remote
> interrupt is addressed to the importer, queue it on the loopback
> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
> as if the exporter had sent it. The ordered workqueue keeps successive
> messages in order and runs the (possibly sleeping) handlers outside
> the sender's context.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 29a787979af2..ef133c60bb9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>   					   u32 remote_accel_id);
>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   					  u32 remote_accel_id);
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
> +	 * to the exporter accelerator. Messages addressed to the importer
> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
> +	 * them by feeding the message back into our own IRQ handler.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    remote_accel_id == ualink_imp_accel_id(adev))
> +		return amdgpu_ualink_loopback_self_interrupt(adev,
> +				ualink_exp_accel_id(adev),
> +				dw0, dw1, dw2, dw3);
> +
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
>   
> @@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   	return handled;
>   }
>   
> +/* Work item used to emulate an exporter->importer UALink interrupt in
> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
> + */
> +struct amdgpu_ualink_self_irq_work {
> +	struct work_struct work;
> +	struct amdgpu_device *adev;
> +	u32 sender_accel_id;
> +	u32 dw[4];
> +};
> +
> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
> +{
> +	struct amdgpu_ualink_self_irq_work *job =
> +		container_of(w, struct amdgpu_ualink_self_irq_work, work);
> +	struct amdgpu_device *adev = job->adev;
> +	struct amdgpu_iv_entry entry = { };
> +
> +	/* Build an IH entry as if the message had been delivered by the MP nHT
> +	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
> +	 * the sender accel_id from entry->pasid and the four context dwords
> +	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
> +	 * the message is processed here instead of being delegated to the
> +	 * UALink soft ring.
> +	 */
> +	entry.ih = NULL;
Setting entry.ih to NULL goes straight down to UALink soft-ring path. It 
might be worth making the comment clearer about that.

Other than that, this patch is

Reviewed-by: Philip Yang <philip.yang@amd.com>

> +	entry.pasid = job->sender_accel_id;
> +	entry.src_data[0] = job->dw[0];
> +	entry.src_data[1] = job->dw[1];
> +	entry.src_data[2] = job->dw[2];
> +	entry.src_data[3] = job->dw[3];
> +
> +	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
> +	kfree(job);
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
> + *
> + * Used in loopback mode for the exporter->importer direction, where there is
> + * no HW path. The message is processed asynchronously on an ordered workqueue
> + * so ordering between successive messages is preserved and the (potentially
> + * sleeping) message handlers do not run from the caller's context.
> + */
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3)
> +{
> +	struct amdgpu_ualink_self_irq_work *job;
> +
> +	if (!adev->ualink.loopback.wq)
> +		return -ENODEV;
> +
> +	job = kzalloc(sizeof(*job), GFP_KERNEL);
> +	if (!job)
> +		return -ENOMEM;
> +
> +	job->adev = adev;
> +	job->sender_accel_id = sender_accel_id;
> +	job->dw[0] = dw0;
> +	job->dw[1] = dw1;
> +	job->dw[2] = dw2;
> +	job->dw[3] = dw3;
> +	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
> +	queue_work(adev->ualink.loopback.wq, &job->work);
> +
> +	return 0;
> +}
> +
>   static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
>   					u32 type,

--------------kGR2wqWYgrlRERQ9O0pQ8wO3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-02 10:47, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261102160125.2743750-4-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">In UALink loopback mode a single GPU acts as both the exporter and the
importer. The exporter is the one physical station, so the only path
the HW serves is importer -&gt; exporter. A message the exporter sends to
the importer cannot be delivered by the MP nHT.

Emulate that direction in SW: when loopback is enabled and a remote
interrupt is addressed to the importer, queue it on the loopback
ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
as if the exporter had sent it. The ordered workqueue keeps successive
messages in order and runs the (possibly sleeping) handlers outside
the sender's context.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 29a787979af2..ef133c60bb9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
 					   u32 remote_accel_id);
 static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 					  u32 remote_accel_id);
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) &amp; ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	/* UALink loopback: the single MP nHT can only deliver messages addressed
+	 * to the exporter accelerator. Messages addressed to the importer
+	 * (exporter-&gt;importer direction) cannot be delivered by HW, so emulate
+	 * them by feeding the message back into our own IRQ handler.
+	 */
+	if (adev-&gt;ualink.loopback.enabled &amp;&amp;
+	    remote_accel_id == ualink_imp_accel_id(adev))
+		return amdgpu_ualink_loopback_self_interrupt(adev,
+				ualink_exp_accel_id(adev),
+				dw0, dw1, dw2, dw3);
+
 	peer = &amp;remote-&gt;peer[remote_accel_id];
 	ring = &amp;peer-&gt;interrupt;
 
@@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	return handled;
 }
 
+/* Work item used to emulate an exporter-&gt;importer UALink interrupt in
+ * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
+ */
+struct amdgpu_ualink_self_irq_work {
+	struct work_struct work;
+	struct amdgpu_device *adev;
+	u32 sender_accel_id;
+	u32 dw[4];
+};
+
+static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
+{
+	struct amdgpu_ualink_self_irq_work *job =
+		container_of(w, struct amdgpu_ualink_self_irq_work, work);
+	struct amdgpu_device *adev = job-&gt;adev;
+	struct amdgpu_iv_entry entry = { };
+
+	/* Build an IH entry as if the message had been delivered by the MP nHT
+	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
+	 * the sender accel_id from entry-&gt;pasid and the four context dwords
+	 * from entry-&gt;src_data[]. entry-&gt;ih must differ from adev-&gt;irq.ih so
+	 * the message is processed here instead of being delegated to the
+	 * UALink soft ring.
+	 */
+	entry.ih = NULL;</pre>
    </blockquote>
    Setting entry.ih to NULL goes straight down to UALink soft-ring
    path. It might be worth making the comment clearer about that.<br>
    <br>
    Other than that, this patch is&nbsp;<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <br>
    <blockquote type="cite" cite="mid:20261102160125.2743750-4-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	entry.pasid = job-&gt;sender_accel_id;
+	entry.src_data[0] = job-&gt;dw[0];
+	entry.src_data[1] = job-&gt;dw[1];
+	entry.src_data[2] = job-&gt;dw[2];
+	entry.src_data[3] = job-&gt;dw[3];
+
+	amdgpu_ualink_process_irq(adev, &amp;adev-&gt;ualink.irq, &amp;entry);
+	kfree(job);
+}
+
+/*
+ * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
+ *
+ * Used in loopback mode for the exporter-&gt;importer direction, where there is
+ * no HW path. The message is processed asynchronously on an ordered workqueue
+ * so ordering between successive messages is preserved and the (potentially
+ * sleeping) message handlers do not run from the caller's context.
+ */
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3)
+{
+	struct amdgpu_ualink_self_irq_work *job;
+
+	if (!adev-&gt;ualink.loopback.wq)
+		return -ENODEV;
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return -ENOMEM;
+
+	job-&gt;adev = adev;
+	job-&gt;sender_accel_id = sender_accel_id;
+	job-&gt;dw[0] = dw0;
+	job-&gt;dw[1] = dw1;
+	job-&gt;dw[2] = dw2;
+	job-&gt;dw[3] = dw3;
+	INIT_WORK(&amp;job-&gt;work, amdgpu_ualink_self_irq_worker);
+	queue_work(adev-&gt;ualink.loopback.wq, &amp;job-&gt;work);
+
+	return 0;
+}
+
 static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					u32 type,
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------kGR2wqWYgrlRERQ9O0pQ8wO3--
