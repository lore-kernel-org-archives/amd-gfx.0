Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3751606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IL/iW9Np
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5DD10E52B;
	Wed, 28 Oct 2026 06:24:06 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F2010E52B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 06:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5AQ2iqbmVghqmwK+51MaN0zD1rL9U+2D7M0WSwmUHLlRRgvjR4JbTgB6Na2NmdD8Wn91B1jw1j+EjYC2LL9arCNlTXM/efV+lOUUMVR4DO5kKYw3J4y8eQU5ChhMUiRTI2dznxdovdfY0TOlvVcpLn+KfaUTcbX7lbjhLKrLuPT9G+V6hxTzj2icCkRE7HR0B/2hGtUcCMB9vywOOpI9hQOD5UQtldRs7FExjcPgoOgPBoR7TXd7AqVvG+KTGDuDJcaFU/y8PfZvNbo8/gjqS6tvr2GoFdfWA+netRFN/YC1D13Oj/TmESOQ7DnLpPgTcOUFGA6Tm80yU6llPWEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5id2YdcLdhktLGGYD+X80uAwALZKNpLN1Bvod0eaH0=;
 b=P+MdSWP++AFvNhuLGhzCItJbPe4gukr6Mgh8zOXpKGNsPhYCg6H8dNXE5XlDhbi1bkaCeyFq1QpsOjiODCO6l3NIuHvB6csTg7gWgLCp09llILTWKTaRbideEGL0Wv3wbH1EbELaW1bQdjuRU2XjXkgj+nU5uel+/XQbvrrjJ5UEWGOoJ91SSrqUV5V+WM+TW2nBh+dbU7+D9ydf905/YeezzlFnEDUeg6qHnwnWkl1EPKrFklz7mW9RgX7qeiThdHvYE65h85gFtm7D9R/jcHKltM09MQt8znScPlScVkbXZfKuMPL7aUfZFH3HRPAZHa4yhjJxo6sPJ5dYZkDE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5id2YdcLdhktLGGYD+X80uAwALZKNpLN1Bvod0eaH0=;
 b=IL/iW9NppUC96KLUydGYuPWLfbB9DcvryFsPTq4vDopaxIFnanx+Z5qvtu6YZE4EVGm96QbK/Iwkx3aB79VZBl94p60z4RCd7D7budWbPXMxXpZjOLO5ft4EjAerkls2wEaONmf51ucsQYEl9mzCCR7k04RAmwiEMrUIv1V+Rgg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 06:23:53 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:23:53 +0000
Message-ID: <0b9b80f2-58ab-4113-b308-562697650afd@amd.com>
Date: Wed, 28 Oct 2026 11:53:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-5-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261027195913.1794477-5-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::6) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c47d42-2abd-4cc5-9af2-08df34bc09e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AfShe72sVAdjVXmGhi3gXEzECs88X0qLYnyqfI8Or/h7kLx0BNsAKA+Ydf6sDehpB4sSqauJgefQ5e+wO9totoyQmuenDun1wosiHOx/OziX1MokN6W+Iawaj19Yv7W4oO1ePcWOqq9VS4QuTzl4VqyJ6P71FHd1ykG85NWeqo9TiEv3Gd6pnGrQKSogOstGPyu/ILcmGpsHhGcvWmuSBHu4uc0aT8f9KQRJ14/b2XeALqwrKJTQAV6ZfjEoGG0AgC24YFZtq2jZEchAmzPgqp9teW52X77BxuCm62l3mgJ2zrowB+zWjL1tW1R8ZT19twuhm/1QTcVAP16EDw1VnCgI3ULEqpbltoVI7RCXvOywFYMw1Lx/BiesxHaejzqoykdavYTPuZ3Yht8BCwnVhbbt1PInC58FYZCk1Fy1EVhhLuT1/7UEaPtBdGn/t1OkWS2dVZ8+UXReoiGFQO4inoms/KKqMicrANimgYVPn4EjYRHJ+Hc2Lb3oVsFFh40tMtA2PXsL04VW90msSaDA5vQwk5yc7W6aJS9QPDcv2elbJlXh8y4yo0wMkduNEB1yoPsaRp87LBKrdnEVaEVpTLndu0npCYdTrES/YCdXUfNadB7FovrQXSvuADzruOaKoKRPVWCnsfSWx8pfUFO3EzMM2KiJ7cJkj4XbqkKfVi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFp1dnhKTWRaZzVGOWV0eEhoRzJYNWNrdFhNcFhNZk5uTWN4a0dOWEV4WERr?=
 =?utf-8?B?WDM3LzIzL2RHQ0hTdU81U01kVWg5VGo2QzM3NW96WlVicy9CZWJ4b1Qwb2sy?=
 =?utf-8?B?OVRrb1N5bVFqbUhhbjhsckdWZGRFeTlURnRwVGxyOThSY0VoWC91Z005bTNK?=
 =?utf-8?B?VEsxNlREditJbnFEUjE3VFJMU0JBbFFiWjZjUWY3MlpBOElLcHZtRG5nRGtq?=
 =?utf-8?B?dVBnYWgxVkhMYXp3SzlTeUFhakxYVVNjTVZQL1BKOXlnNGJDb3o4U05Bb00z?=
 =?utf-8?B?SzViQngwSzVyTTNMVXR2RnFkNHl2eW5SMEdXR2Q1T0VKVllLN1AvdDhxUjNQ?=
 =?utf-8?B?ODZlUnFZNFVqdjdrL3RUdVBTOUloM2pRK1JheWxOL0VxQnlaWXpYeTNVZWJQ?=
 =?utf-8?B?aU9aanRCU0RTZWFtbGNEckxpWUlOaUdUQmZ2SXZWREUzSW5PaWhCcnlkenR6?=
 =?utf-8?B?U1hldVJmQmlGcVd1Z3ZsSnZqSmczbXRhOVR5Sm1qcFZlaEU4UzlGZnJsOGd2?=
 =?utf-8?B?THh2MkdhUHRtZkRFT0lyajF4MEU1QTNiekZaRnM4eGVnSEJHOWdzYVh6Sm9j?=
 =?utf-8?B?UzVaSHlJRHFrNWxnTlR6S0hnUzJLWldpMWhjUE1oOWxnd0wxRi9hbWhRdDFw?=
 =?utf-8?B?U3RhbnNPcE5xY2tlYnFINWx1S3kwMVVGMzFhYy9xRVZNS3g0dUttK2kwL09a?=
 =?utf-8?B?VEZOSUVlOEk3UzdDZy9MRldubjV5cDNQVlRSbVdWRTkxUDNsczc0WW9EOTdp?=
 =?utf-8?B?RGQ5S0kyMWovVGJGVmhPZGdkVGtmd2FXOFdvVjFoV2ZFODFxUjl4VkEvLzFX?=
 =?utf-8?B?Q1lIUmw0ZThXU056TGVSQU1HeGRnYUhOb21WUllCNXQxb0NtZloxYzUvZnlx?=
 =?utf-8?B?dDRTSWJKVHROd2pxOC9KbUYzUU5CNU5vM1hpemVKcWFEeVBZakh6ZDRGcEV2?=
 =?utf-8?B?Tk5Melo0L0NvbUR4YkllOUF5VGxSc2VxRC96Y1hPcGRPc2lHaE01Y1JpUWJl?=
 =?utf-8?B?QnNqeGt2V0kxQjlXa21TcWdxV24wdG9mcUtHVUFxV0FsZ0hSOU9CaXlVT1V3?=
 =?utf-8?B?TmxDd0xrKzZkMDVVZVZ1MFRLbzY0WSszUmlQc1NDd0YrZlc4TUNpRVg5a3Z2?=
 =?utf-8?B?S1hlbm10aFpzSFg2aCtEZThyTVZZN2ZPaWxySWpIUjRUVWVXSlZYVkdWcTc0?=
 =?utf-8?B?WkxCWW55RWVNSVBjVENGTXpZWC83ZXpJd2NGUW5EaEhFTndpaXUycWsrVHNH?=
 =?utf-8?B?dTNZZnhLNVRXZG5OU2I1NHFsV2pabThpRkRmL0tyYzlleU1lcVZZeGxGaGhz?=
 =?utf-8?B?WTl0SFJEUTBBby8zcUZWZmxxU1dXUWNhWVVRT0pyc053NXdwRmJUdmZ5bkVo?=
 =?utf-8?B?ckRSSWwvckcrUStMN1RTelFiQ1dpMmk1ek9mdk9NaXlMQUpSOEc0a1Z5WDV3?=
 =?utf-8?B?ZVljc24vVmpoK0ZFS0VEV2RMQS9YK2dOb01RTTdpSkU4SDhMeS9vZFJvb21L?=
 =?utf-8?B?dFpMK0FpVGk2UGtvaWNxZVE2KzdqU2JDWE1DRDBGRTlUMW9ldEJ3QTJYRlJN?=
 =?utf-8?B?WnNHcG1qU2JWWVVHNXhPc25ZbCtvbytDcjNWQlRQUC9MNjcxYnBlTUx6ZHRu?=
 =?utf-8?B?RnNteFVxWE5jQXBDd2lHclBoWkJxbWsrc2pxWjd0dUpaaWNxTndFemJJMGp6?=
 =?utf-8?B?Z21La2Q1WlUvNXY4SE9sUVBRMnVpbWpMRHArN2Vwc1RNRjR1eWJCWHhTZ1FC?=
 =?utf-8?B?djVDYVNPWFZWaGdVRWhvaVgyRFpOQ2g1bTNTRUpOSG80aVUzdTIrSGpYY0Js?=
 =?utf-8?B?c2FzUGNzTW9ZOTZoRklqNU5CM0FxbVQ1czQzSHdSUnpPZjVuL2JaY0dic3dn?=
 =?utf-8?B?S0V2d1NDM3JLSUdBMS9SbTVLZ0JzMXZRaUdITDZRTElwUk1QNElTYnI4VDhv?=
 =?utf-8?B?RGpFbkdMUk1vVGVCUE03Y3ZMaHZvWEJzOUp1RmpQWDlURE5BY0JxYXhxUWJI?=
 =?utf-8?B?Nzh1aU1vWWRFMDZ3YU9Qa01SUTdnK3d6SjVSTXVwNFIwdGlQL0U1QzhCeVlR?=
 =?utf-8?B?YlBaczh5azNGZEhkSkJYMlpkQ2FQSSswWmI3bm1QN1I0MW9OMW9zN0xzZ2pY?=
 =?utf-8?B?L2MzZFFETFNhUzZ1TEhHTktuRkZYQ3YxblVuSklYUTM1elpjbXVqVzl2M0kv?=
 =?utf-8?B?Z2V3ZGhxbEV4QUluRXcrMjRxc0VyR01nTCs4MGZyV2ZMcmh2bGZpWFF6NVJ6?=
 =?utf-8?B?Mkt1OVpBaDFiK3NCZk5ndU5KbmpkeGRDRUlPZytWOEJTcE14Z3EycnFodDZ5?=
 =?utf-8?Q?cT2h0ORjPZHmLsPDUL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c47d42-2abd-4cc5-9af2-08df34bc09e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:23:53.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3PfLjXvfm7fGNakuGq2ekzyyLxOa7HGxbBUg/S5Q6QYWlrxWGOF4n/F+iYmblQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28-Oct-26 1:24 AM, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer, so the sender accel ID of a message depends on its direction.
> 
> - Send HELLO as the opposite role of the destination: a message to the
>    exporter is sent as the importer and vice versa. Outside loopback
>    this is still the GPU's own accel ID.
> 
> - The MP nHT stamps the IH cookie of every HW-delivered message with
>    the GPU ID of the single physical station, the exporter. The only HW
>    path is importer -> exporter, so attribute these messages to the
>    importer. SW-emulated exporter -> importer messages carry no IH ring
>    and already name the exporter as the sender.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Use ualink_exp_accel_id/ualink_imp_accel_id() wrappers in
>    amdgpu_ualink_process_irq(). (Lijo)
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 6c70be7badec..96a6023f51c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1090,6 +1090,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>   	return adev->ualink.info->ppod.accel_id;
>   }
>   
> +/*
> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an outgoing message
> + *
> + * Normally a GPU sends messages as its own (single) accelerator. In loopback
> + * mode the same GPU plays both roles, so the sender identity depends on the
> + * destination: a message to the exporter is sent as the importer and vice
> + * versa. Outside loopback both roles collapse to the GPU's own accel_id.
> + */
> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device *adev,
> +					       u32 remote_acc_id)
> +{
> +	if (remote_acc_id == ualink_exp_accel_id(adev))

+#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1

1 is a possible id in a regular vpod config also. I think a check of 
loopback mode also is required here.

Thanks,
Lijo

> +		return ualink_imp_accel_id(adev);
> +
> +	return ualink_exp_accel_id(adev);
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -2238,7 +2255,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
>   
>   	dw0 = AMDGPU_UALINK_HELLO_MSG;
>   	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
> -	dw0 |= (adev->ualink.info->ppod.accel_id <<
> +	/* In loopback the sender is the opposite role of the destination, so
> +	 * the exporter side tracks the connection under the importer accel_id.
> +	 */
> +	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>   		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>   
>   	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
> @@ -6548,6 +6568,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   		return handled;
>   	}
>   
> +	/* UALink loopback: the MP nHT stamps every HW-delivered message with
> +	 * the GPU ID of the single physical station, the exporter. The only
> +	 * HW path is importer -> exporter, so the real sender is the importer.
> +	 * SW-emulated exporter -> importer messages carry no IH ring and
> +	 * already name the exporter as sender.
> +	 */
> +	if (adev->ualink.loopback.enabled && entry->ih &&
> +	    src_acc_id == ualink_exp_accel_id(adev))
> +		src_acc_id = ualink_imp_accel_id(adev);
> +
>   	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>   	local_acc_id = adev->ualink.info->ppod.accel_id;
>   	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",

