Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D7606A31F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ob/9gUJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E7010E3B3;
	Tue, 27 Oct 2026 06:48:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B5910E3B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 06:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiZzxMI/8XBjXKns9NN+Dmnvb8ENKIEeWqPwkGy5RSYO1fL9YVq/Lyigvk9XQ5iofTu/G1S8lz10xBSXFG2uNUioXBLm5HQ2S3UQX1cU5vTJiy3JFGI2HT1sh5kvQOYPiOIZkHNnzwOWXS3mjx2fgIgLONljedxAnmMyITItWsvpQy9nfSif1u7zdV1Qj5pm1y3+Y7PRF8gWIcr3pogys5GZy9MX3VCBIJt+df/5cOHMLX24JJU+vDIgyz/U3dODLHsl51XFszzNPFtRJcPLKt1tZpmXrRaB2ZUEDXhV7ijfpkEIfNz3+Qvw3NRqFIKZy+55qUKkGZFBtAxBhibHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckU9140i+LOzCVUg1E9u48bavpE2P1ZoNG3Cjh6+XwY=;
 b=sOpRzawFxgBeKcS1nQh2286YrlObn5/flrOqcf2DzxDnXYp4AedXfdf9Lb0ctZKKIM3d+HIgDpR4dXwGxFavPjnHTRZRtwiQjnSRDpXtrTpzh0HhC9z06uAldrkvtTVP4SSt3bItFLNsH0fuCamoptWr41TEunxAXU5jaJqcndiwT9OgY0PiZumOg8Mns+4TzA5n/YzCfIQ9AmxcvOcQihdOPhOo6jXnAZgH82okNldzoP7J4oFAgcp0N+h6WKgYSnD5MAQlgZfkMM48BBWG6xCfmMWSt0r31/9nd3gmZtXOBQbXx97qnS+Ee0iqfQzMENdqqMHT2vb2Mx1D1qlhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckU9140i+LOzCVUg1E9u48bavpE2P1ZoNG3Cjh6+XwY=;
 b=Ob/9gUJrbhWvqrR+DskeEuktHIzSrX4iT9b8ngiz+f3Lru0VF/Jerrhd+7NcfJlvDlkTTojeSUYjxxTRlhkEimoDtX/fcoVNuV1Fw/kaoopjQsIyzSCIYznjY69b/mtnM2gKkjkodcFFFzHghhqsT6lwuH57S9XtzEs9Yf3Zr94=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:48:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:48:10 +0000
Message-ID: <d20bc68f-ae6b-483d-922c-151ca3cf6876@amd.com>
Date: Tue, 27 Oct 2026 12:18:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: Reject config updates in UALink loopback
 mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-8-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026230248.1597606-8-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0271.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f945684-253d-46e7-1fda-08df33f6438e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 4FUPsJQq6SX05Qp/A8Qqd8+zrEVvflpGad5ffdLvODbTGUFRf6tWYIK7zjfE2FVzeZCoKQhKpL0mBczcv7mj/gSQL3FMNo1yFkC9va0Hu4wjTsRLI87WNGqTrCHmOM+BildVnFjg+en00QJigsKYnbBw9L4iLtn6rMIz0ttkie02vOHn50hgr6bmfSeM+4Bv5ipww/UEe2CYdsce8MiD9EgD0kY851l1iPreoQrxjr6FwdhuTxgmtFyC58wkIR1u49SYvVkdOz3sry9MJCdtJZq4c3KaPjQh0Ukgn6CMgyoMrecJwrVCo7Nz1U2QqolV44tGixZOfN6ZbXCIIbT1I3qjpeFgM+bOtq9QHT2grwg3Fgf+gEuQh9ZlQxd2bJ9YQKLRHsMgmyV12WdVPWm1zK1oN6bGxj6+f/XwLKM7GFo+oQ+JWZNTamzRAWCXfGsCTAXcwzRQQcC/4Gk3npI9OYRvTSZ7X1ubc0hB9PsCUbs0iARCR8q5dPN/Xn5Gd319jUKDX8BB2nqSvE+vd3Vvy5u9i7ZXgJ8aKUO/YaTkCXzmUNj3jANQV4rItustPK5wRYYBXe/tlfobe2/6Dk96Xy/ZRodhbIGKSakySsPtRDq0quzOxVGsdbg8XzAzZxF12nBMs3eFjC4MKFa50i013IFJzs/T/lmGGSSBARHUiVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021121427099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVsT3RjREJJSjV3VzdURUtzQkdHR1N3NnVWUnQ0RTdyM0FxWHlvNzQ3V3hq?=
 =?utf-8?B?dHhiUUp0emVBbHpGNnVQTmZNd2JEQXRFQmFvbStTMWRsclMyWVp6ZTd0RUhS?=
 =?utf-8?B?QStTWkNROHFrWmgvQStvamxEUzUvN20xRGtVaE9NemxoTEtJQzRLUVNuQ0pp?=
 =?utf-8?B?N1RZLzZ6eDhKQlcxL0hUdm9aOXF5THI1V0tOMTE4WGplODZtNk9INkVnR1ZK?=
 =?utf-8?B?SWN2UENISVRBRzlZMzhQUkdsNUkvS1pPN1R3TnRUWmtFVnBOSXJNK0Exam5T?=
 =?utf-8?B?UEh2d2x6cGpPaVE1dVNEZ1ZWZDM5V1NCTUZuVWNMdXM1ZFlTT2hGL01iV1Ri?=
 =?utf-8?B?eHliWnRyQVVnbnhLT2NlTitCcGlCM3RPNnM1MzhxYVh3czQ1dzQvcFJrSEx0?=
 =?utf-8?B?UkhEK1J1c3dTUUhDb2o2ajRKZzVKNk85OVQvbmlCb0w2Q2svVHJGb1EzZk1a?=
 =?utf-8?B?T2pobElhZEcrQWVWczVCcEJuanpmRWtxdklTOU5GK3R6V0NicHlhdGdrRGF0?=
 =?utf-8?B?cHhiQ2pvNXFoT1pTc21iVGdIYmRSR0luWjZ2c1hXS0dBTTRPK044Qmp4NXEy?=
 =?utf-8?B?WHpOdzkwbVplRGUvMXBXWGNNYS8yMWUxcCt6T05HN0czUjFBTkxEM3F2Rmx5?=
 =?utf-8?B?WDZxbWFsOFlaVmNWdFVyeFA1aUNWMjRpbnM5Y2F3dmhBNkdYUkpkcEJSeUkw?=
 =?utf-8?B?R2RoMEtvZ0xhUEVIYW9xdDIwQ2lBUngwZ0hjeHFIcURrTWZKT2g0cXFibGFD?=
 =?utf-8?B?UjZYNi9LMzZ5bEQyK3J3Vk5sSzRxclVFS3FNcDNHL1dXVE1kUmJPZnZFVGdX?=
 =?utf-8?B?NjhUN3JJNFE4ZnZxV1dMeXJTOXMwdDNwSU1wVE5ZUVhnejJrU0tLSVdBWmZt?=
 =?utf-8?B?QkNBa29WK3BJdlhNaHpIYlFuNGh4b3FHamxKMmwzVmRBSGpzaXpjeDk0WVdJ?=
 =?utf-8?B?bjBoZHpMS3k5aHFxWGNPZiszV1owUVF2WktTcFpTS3dmZlZOTHJvdXJCS1N1?=
 =?utf-8?B?ZVRzbnVNaUNuMWlqcjF0aGZMQ0RnZ2dPUUU3Wml3eFNPRjVqWTFFanpSWTR2?=
 =?utf-8?B?RGFwQUlMOVd2TUNjbVJ2QlBtbXBLcEhXajhJNnpCWXA2M0RleWkwd3BHSy9o?=
 =?utf-8?B?ZVYxbEpVaGVhandDeGM2anRCY01Ec2tVbWkxZTZJd2NGVmNtMGY1UW9Wcm5w?=
 =?utf-8?B?YmRVR2lWQjVVOWEwUmRFSFlMNjZBdnBCQm5VcU5qTkxUa0REYTcvV2xOTlFJ?=
 =?utf-8?B?UzBsY3hFT1JQODIvTjcxbW00Slh4ajl6R2JkS0hqR0lsMGYxMThoajJTMUwv?=
 =?utf-8?B?b0kwQjM4dFVBYUx1dFhBYmcrK0sxNEI3TEVtWHoyc0hyVzY2WkF3R1R6QU9Q?=
 =?utf-8?B?Vm1LWnIwaUNvaUM1cTRNRnJQeGM1ZUxDb1JRSHZyckd1cW85ZTlsRDh0YW0z?=
 =?utf-8?B?eFRnc1VMbWV4TG5mUlM5blNPR3llRGxhOWJRSUpPeTNtMW1nckRzbi90TmFX?=
 =?utf-8?B?SFQ2UXplUTNtbUd0aWVYcDJBanpiVUFpMk5id3JNU3ZUUkFzQ21lUnNtRCtF?=
 =?utf-8?B?bGVRZWJBTmRMdGVhYm92N2d4YzA3QzRTbjRWQSt3RWhucWIrOFJhck1SelhV?=
 =?utf-8?B?RjNTaWtleE90ZmhoS3lWalpwaVBlaHFFZTlvUzM4dVVMRDZ6OW55bVk5UGlz?=
 =?utf-8?B?SjJkeFFubkliZnhmaGl2NmVDaEk1REpVNlY0N1RjOHJyVDczK2Y5SW1XQ1NZ?=
 =?utf-8?B?eGhlaDZSVTNZWEFuS0g3TTlyVlg3L0xId0RrQkMralpQMWZVbXFpTUlqTlNl?=
 =?utf-8?B?b0syeVlHb2VnOUwxM1d6VVpoeHNGdElmN21GQUF1SlJ1YnY3cnZUR0hhUVcv?=
 =?utf-8?B?cE5qc2lzaDVNallFK01XME5KVUUxU1JTdFJ4Q2RIUk1aNEM0WmNpdXlNTktG?=
 =?utf-8?B?REt5eG0zNlJMVk53RmRNNVdxbUZRQlFMTUh6WnFjNFF3ZVVoeFJ5RjFIcWxk?=
 =?utf-8?B?akFIUVE5UnlidUcwanJYZnFFVVFiSjNwU3pwVUZPVytVT2JUYSt5Nlg3ckFi?=
 =?utf-8?B?WmpyY0xzQWxxT1Zjb0prVllDenBoNFhzb2hRa0pvNGpLaUs3WFpManVpREdy?=
 =?utf-8?B?eUsyT0xxSW1CNWI2eGw4d1pmNTlNYzNCZ3VGQXZCbW5yZEJCZ2x0RU5IMnh1?=
 =?utf-8?B?dUljellaWktPcmNrVys0VkRUU2locTY0bXZwdGx1T3MzTzY1dG02SGxIdGZm?=
 =?utf-8?B?UlhZelpuQUt6bFFJSnFGU1FvQXRobTVKVk11Wk9Rb0FMTTdJM3U2NXdRT243?=
 =?utf-8?Q?LiGmnkxI3i09vcsrZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f945684-253d-46e7-1fda-08df33f6438e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:48:10.1491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhav8gcneJ1WyWSqokyNiZ1xIE9tDlSmf5QAiygOK8ETKyPWV1Vo/Z7G2ohgIQpg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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



On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
> In loopback mode the driver synthesizes the pPod/vPod configuration,
> since there is no user-space agent to configure the pod. Keep anything
> else from overwriting it.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 26 ++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 1e30391e2e18..204758c0fd50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -483,6 +483,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
>   			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
>   	}
>   
> +	/* The loopback pod configuration is synthesized by the driver, so
> +	 * re-querying it from PSP would overwrite it.
> +	 */
> +	if (adev->ualink.loopback.enabled) {
> +		dev_warn(adev->dev,
> +			 "UALINK: config update ignored in loopback mode\n");
> +		return psp_ual_send_completion(&adev->psp,
> +					       adev->ualink.psp_if_ver,
> +					       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
> +					       0);
> +	}
> +
>   	prev_state = adev->ualink.info->accel_state;
>   	prev_vpod_id = adev->ualink.info->vpod.id;
>   
> @@ -1128,6 +1140,13 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
>   	if (!sysfs_streq(buf, "true"))
>   		return -EINVAL;
>   
> +	/* The loopback pod configuration is synthesized by the driver. */
> +	if (adev->ualink.loopback.enabled) {
> +		dev_warn(adev->dev,
> +			 "UALINK: ppod-commit rejected in loopback mode\n");
> +		return -EPERM;
> +	}
> +

Instead creation of any config node may be skipped in loopback mode.

Thanks,
Lijo
>   	r = psp_ual_set_ppod_config(&adev->psp, adev->ualink.psp_if_ver,
>   				    setup);
>   	if (r)
> @@ -1552,6 +1571,13 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
>   		info->accel_state, config->vpod.id, config->vpod.size,
>   		config->vpod.addr_mode);
>   
> +	/* The loopback pod configuration is synthesized by the driver. */
> +	if (adev->ualink.loopback.enabled) {
> +		dev_warn(adev->dev,
> +			 "UALINK: vpod-commit rejected in loopback mode\n");
> +		return -EPERM;
> +	}
> +
>   	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
>   		dev_warn(adev->dev,
>   			 "UALINK: vpod-commit rejected, ppod not configured (accel_state=%d)\n",

