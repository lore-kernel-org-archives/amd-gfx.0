Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528D606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4V8IHk9o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884B510F834;
	Tue, 27 Oct 2026 21:38:20 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F55F10E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpvbkxZABGDbVrlg6v7SnV9laBuWR4lw3A0udood5/HVny/oHyUKX864smqWVx/7DdyrxcXogqw3e9nXzac098kXtaMS2Uwb0kxUnbSUb68TDY4j2O9VlWnEReMk9d8dzrb+ZLKENNsJJLIXdElO0aU2PcW72Aul9dbjNKO2Q0DDBAtr3q/yF46s86VW7R1OkOPvl6cUr42PYZj4neKV7jMw8TWc7VR8sTe+OeIAQAmKhg2LGaxNx4Sin4MlQ0JE0RtTdmxHNW1qReDQWJ0e9PbvChfdqOocbnmViID7pUMKGLrjKL31A3sNsWpCIvEh40cA2nxF3W4xAewm69zL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2VKdXyB/7OepO3OzWIzC/rgNNgpQDK9YBF6SOqnzZY=;
 b=L+BoM1R6xxYCrqwRBqlbRiZdFVR1KYup2b8lzdteCyCpiM4kFmEC4D7MLkF8ciEhCS86afyVX0zH9MhHc9zCPwKZerjKB88Ymp6Dy2sruqg4dD2M4x9vGHABpqhhJWLFlOixDjHMLlMccrVXzXxdGVmLgioT50usF6/4nv4b5NZcU9TIkbWN6dTSOJPsS78jAme8ysQDPTu2WkJMjRUxZEzMS0gnUg0bZLERUV0OeeCtIMIs6LyVBTBJ2iNxUh1Z1Z2MhKTWxMXuvT+mBo9cG/o3X2pOatuHbPfyeHa0Pls/MMwS9bvrs/kqH/bJEYII8wAGtGiqOfkrMDCgaLqcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2VKdXyB/7OepO3OzWIzC/rgNNgpQDK9YBF6SOqnzZY=;
 b=4V8IHk9oJ6xHtt87Lxez9ZfUJa5VHG3N8cTXjp8x3VdsDSYrxAagk2rpvzINWIK5y4+/9g6C8deICKhpJ0VKMROHs/kycianhvyV9/rkxhZxtCxESBkmNXzGKoEOUCRdYh/sz8DgdSkLCdwwQ6ET0YdblfVJjqm8fZsd0C/SR+w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA1PR12MB6702.namprd12.prod.outlook.com
 (2603:10b6:806:252::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:38:10 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:38:07 +0000
Message-ID: <d75c2c85-3464-4cb2-a6db-ec31ff5e9ee1@amd.com>
Date: Tue, 27 Oct 2026 17:38:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-5-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-5-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7dcc8c-27c7-406c-c605-08df347296d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|261026121527099003|56012099006|261021123027099003|4143699003|11063799006|10067099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: pmdIC0Wd2lUPGExI8o6U49x8ioWVPFV4wWGyO8TtTCrxOYMW/QPUU01Am82JD488bgmYq29WKrNbAXHYYzUFBbrUMmMKI7Kp9lHoMLeq+ktX0jnee+gx+Y6Y51aGL6xMozpXK/FLE+ohbNFCWErrVdZeAy7GGgDHn/m6VrQqvQEQtAr4Z9EDLuEt21j0LeCBx05kiZWafqVxQcZMH947I0Jf5gyjbswByYaS+Dha6EsSX2p5GkkRLATGJtP8xF56Rg+xzjTmJ3wxxK3EP2vvfaHH043jJ53HQVmqi54OIftj4Scx7ZsUsqcjHMSCDKbXiIQzJ0mCvhPjT9Z0TapTjsYo97EJiFOgSQQC6SM+PLxE1Nx0pXaqKpUe8CSn76qzZq1L1Vdsak3GndPnYDL38n+Z8dxEoL0plBSUrnvotz0qbnON1+W28TFnVQT5JYJWDlFpcx007YwHRmFHpz5/TkEV/om1tWYa+vue3boiTxc4L2vU5S6xWe5R27lCp6QpX45boIgEza6zIHhOR7VMrSAi/yaqrF+/5+KrJTFPs8r+BB0aP1lJiDDvXU8MT4jkVHB6TB2lkcfvGPtdGoaL5BT5ERn3fxiEHnACLDx5V0tPooIQvFh6UPuaA1iQPvUaD7xbPeCl8RSl9Zj9UlQwYQqHaI0gAdy5uCBzJZbyNLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(261026121527099003)(56012099006)(261021123027099003)(4143699003)(11063799006)(10067099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTluZFQ1RnJNS1FHcWtBTDFxNmVRRnJWWnAydU9mZytDSDV6b2pLekFjY0tW?=
 =?utf-8?B?a0pYNWJYTEd6cVgrUDdhM21JK3F3dThwUHBvVjRvNlVUTDh0NTg4c3VYRmlS?=
 =?utf-8?B?eWNNSTY0Wkl5L0hteDNsdTlXQzk4YkluOERXUkNlSGtSYTlITHVSMUdQTlR5?=
 =?utf-8?B?ODR6cUVwaTh4SGx6aVpVN3MzVXdlOTVOandnQ2ZwTUUxRlNtclh3UDVlMTN3?=
 =?utf-8?B?TTU0bStTcFh6RFRBNDQyMDgvMHdaeUJRbzh0MGdid2tZYmZWNWhDelRPRGZK?=
 =?utf-8?B?SndUaEt2Yk80QkFnU0VVaGpvS2FCWjVITGpocmRoeU92d0dYVzZBRnZ5UHpY?=
 =?utf-8?B?enp3WTlwNUp2Q0dBNFRzc0lxamlzTDY0K0FZOEZtaHhmTDNyUmExQk1Oa2Y2?=
 =?utf-8?B?VjRzS09vVjFOOEUyNFJRZ1JNRW4wek1nS2xNWkpUR3JvQUJ3amNzTi9qWGFY?=
 =?utf-8?B?d24xUHlRNy9oU2RYRTVQRFRjeFl5R3dMd3BIT3dQMXQ4ZitLZldjN0JZS0hi?=
 =?utf-8?B?R1NXM29GYUtvSlRYZjZtUElGRmh5NCs2a1ZwdU9JdE9GUGhTMVNzU0J4Kzly?=
 =?utf-8?B?MG9FbVNHSlV2UVEyWk5ETkRqZFo2TXpHN1B1TXR6QTU1bzJEZWhFQlNrQXdq?=
 =?utf-8?B?UG43V0hOM3daSk1kU3lveER4VDdNN3pOTVhacVpTRGUzenNUVk9hWm54VTJ1?=
 =?utf-8?B?OFNBOERKVldnMnk0U1VEcGxtWWdOQkVEQmE5S3RCQm1ORWlMWlFPanQ0dHVx?=
 =?utf-8?B?MGJhaEF2MkNkSTlrbzRYV3hHdGRGV1NSQzBnbHBpRDBDRVNEZUF0bVFrMW1n?=
 =?utf-8?B?SkZCVEFZK0oyMGFyTitFNVZlTXIyaXhMK1Ivb29lZ0dBRGhMRmFGdjAvQWc0?=
 =?utf-8?B?M0pURDFNZm1lUjZDNUhGV1J4VXprZEdWK1lYOGlSeTRWaHRLS0xLWFMxZURw?=
 =?utf-8?B?Nm5nZVpVMm52SDgxcm1UNXpiSjVOU3J2VlJIZ2Q1Ni9pRm4wWU1zbUxnNVVZ?=
 =?utf-8?B?RU1RNExzWHEvN3BVYzVNcnZROVUxbUVKSVhNR3ZRSk81NTBUd2cySlVHR0pj?=
 =?utf-8?B?cjFUc2RLeXJ1aFhRUjdXNXNKL0hpa0pFdW85cWdHUzZMVmZlMG1NT3cvRGN1?=
 =?utf-8?B?Ung0WW1EVzJZZHdMc1djNWw4NWVGakQ0M0VjazJTeE9zVzRIM3d0MXBGZmUy?=
 =?utf-8?B?K3VYZXVONU04aGhYRGo4VE1kM1pmSjM4anpDamViU1NKQys0d2lpc3pjYlZu?=
 =?utf-8?B?TVJZUE53b1BwVlVYOWY4OXZhcjdSRzQwOGtwRkt0cGM4VnJ0Vy82c2lCYUs5?=
 =?utf-8?B?Mzh3VzJXQmZYZXJ0RDBMOFR6MW1tVTVmZlFNeXE1ZEJMWksxbi9rK0thNTI5?=
 =?utf-8?B?akpUOGwrUkxvNnBFaGU1QllvaTVxVjVYd2pOYWFmUFpzS2M2OGt0cllnYTRn?=
 =?utf-8?B?by9XRHY0eUQxeUdNYm1GcCs5elRBd1QzTDY0ZG9pV1Q4Skk5dzZiV2M0UDA5?=
 =?utf-8?B?YzFFdm84QzZvM25XcUM3U09xdnRSUVdXeElSc0VXTXo5d01KbWN3ckU0TjhL?=
 =?utf-8?B?RVBZNDVNdHZqei9zRVcwcjhsRW51bTkzMU4zQ3dpVlhwcnhjK1FsWWVkdkkz?=
 =?utf-8?B?d0RLMEpaZGRrMGt3OG42ZkpQUDdqZzl5dURkOE5sZlI3OUIzNjV4SUJEdlFi?=
 =?utf-8?B?VmlxL3NMWkFrNWsrMWlCWGd0cCthVTYzT3FPWnFySmNWVEhIYmZ3N1ZWZk9E?=
 =?utf-8?B?VGpPcmZlV2VvdExJc1h6c2VTUkQ2LzNqUG12MDIzKzhZS00vb2hNQ3RFQ3pt?=
 =?utf-8?B?Z2txTHZNYmJadGJrLzFkdEtHUHROVmtKUHhpcFZwZktUcmpXb0NKWkpxR2Ey?=
 =?utf-8?B?U2FNa3RnbTg1WDVLaWFmUE5ta2F6MEZIbmtHSnhxam95R1ovQ3VTOExob1Jl?=
 =?utf-8?B?NlNBZUF5RnJyb2JWRFVjMTRNYTY2RjV0Y0kxMnFNYytIcmVKcktEUENkTEZK?=
 =?utf-8?B?UVRWaUxWOUJxL245UEZMSEZQa1hPWnNNTitEK0x5NXg4eGNpUWNQTy80QTJ4?=
 =?utf-8?B?Ymx5Z041VmordlFCaXVFSUpEUDZ6M1NhUjhyK1ZGTHJwZDNiT0oyZEZTUWh1?=
 =?utf-8?B?WjVDUnk0VHI0S1NHaEtnOElzTFZVYktVendMUXRVeEdJeDFNUThkaHMxbngx?=
 =?utf-8?B?NjRNM2d6Q3dMWHViTlE0KzNtbUtSVTUrVkltVDZOaDBBVVdBdzdkai9Benc2?=
 =?utf-8?B?WUdYV1RJM1AwOWxzYU5lMWI3aWE1aFZPNGNQUG9nazdSb1RTVUVVK3F0eVZh?=
 =?utf-8?B?SU43NGFtUTdOdnZlZCtjcE5TUGgvZFd6b0ZFZ0gvWjVGSldmMmhrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7dcc8c-27c7-406c-c605-08df347296d8
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:38:07.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7IXIQN9rcqjb41RjBUldjk3vjfMSkZewS80/wT+ifpqYSF4wtUU9vH4QWz2Bs2CYwZ80EBM3jpfWwK9g/1X7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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

On 2026-10-27 15:54, Mukul Joshi wrote:
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

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


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
