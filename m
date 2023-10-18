Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E6ECDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 09:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E5310E07C;
	Wed, 18 Oct 2023 09:17:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54FB10E07C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 09:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4nBAQp6FbRzBimoFkfWosOn9uyEp/KJT9izYeO4Le8idO3yVwFbW9olk+HJrEReg0/sRDOlty7mFSHO2DwYw90AdrA9to2n/YT7LNXhLw2IdjG8BdcspPMXN+YFmdqVoUcaqKstdgtfcj3d1IQEINWn+6Lzt0DDFVEA9lAjim6ibkgNxS0f5BAPduJVzo5nshfLnsD/rWpZRC9GKP+HFfM57oQ8s7dApBg0OzGn9NVc2x6mQX9h5AQxCv4lavcwWRL2LUC4BywgNmyqIXCjl2fqNb8ig7S6xRqDk5B1FrOh6lz0pPTx6UT0bd6J7vL1aifZvH6Y8kj94NUsVH0SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2zXTuiuDR7JBqTFhxIDOuPQx4oVbnOtnbTOln2N2Jw=;
 b=Nr4ovOZ3+p+lePS2NRPgnflhFTc53p8EIOAi1g2BNvgBri664qkU/TDpELVEPR16JSAe/16hnPtW7ByA3BYWSoZDwHb2iBclAPFzSa7seADQubN4p+MVCKXv/NKumnPcvg9jnt1igLbLNjez4yhKr6b5WbcKr1vRNRjSjrN1L65VambcxIei6EA3YRpqR8y1q79W+G/8qhBjyZNW1p64tqVcW/DXonyLK6zrjPApKvDmaRbSamei2BnKiAlt1gTJDIlwlUZCRPfxDHezcdgCVCsSsjuwWaZXgDcxmsK7WaCUP0r9zMRd4wYownIOZMTEJHETJ3st7kvIeWB10OvXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2zXTuiuDR7JBqTFhxIDOuPQx4oVbnOtnbTOln2N2Jw=;
 b=RBgDANRGrkX8f+hR2KjqVnwAXGbuzzqWpAqFirJH2ilUf24HbaloS7itkYbUveJoUt3mKESwKMfNy3urkEQpGKF+s7oKLyLekBG64IFvf9wXDeNYdK31D2DUpmsJ5mnxJt+XEAfKe7BHLWW9YGEcBli9jEP92WCgewpPo4bbW7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 09:17:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 09:16:58 +0000
Message-ID: <5d55b49a-a768-4cd7-8ee3-dc1e18e7d341@amd.com>
Date: Wed, 18 Oct 2023 11:16:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove redundant call to priority_is_valid()
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20231018010359.30393-1-luben.tuikov@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231018010359.30393-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d770efc-ffac-4e63-d954-08dbcfbafb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPJ0GxV2XU2fALYklEDGI1edEB6tkMYttEJ+ISVxfIRBOeknakv0M/mrxPE0G2003W+CbCIUm3ek1mDBAivCEv+JUxFvoxcxvKeL/9vftDraXx8ozXxA2DSuY5HfaySfQTqXYI84StcHg4BjlTw/1fh+8ugOD7tZuuYJFqeUAfhdVlCqbfgWsobYJFLS1O6LPGPBJLd+T2hMI+kqtK6qQ6jvzMs1M3crtKkgRDP1IsNz5RV/7TNmoEJycFJfyNIy94Nq6AnZU9CP6hYsl6dRtJcb+GLFnJU+Y+UIcuQutJw1oJpjETFVaKhXhQqnQ2PEClh/p7DnUykpt7Mc+bFuJGzt6PR5l5Td4dphikzgnKktHZt0VByCEtCk1VU22U6D8XD8mMZjWz7XGRdTaYT3qYiqqDHziDmr2Ih78FTLUaBjkJpM+uRmO4BSb+26KCD1tS3GWdGUhuIUWF3wKr8RS0WrNZ8XrEsS/POV6ikyNKpt5lHkGZrZcDFy4XyzVXCTylGYOLWf1wNeLxjFalv8STeZL9H/ldbzQPmV18Zw9oG1dt5eIP4ldfjN9/LR5ykD+VzkIQpoMQDJj8OtIbqynrLIbiKBILCDKsT59Uht96QKtU1RJZiOKwc45LIfcnGi2PkW+f1UwJ0B6R5OiKh4Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(5660300002)(6666004)(2906002)(36756003)(83380400001)(26005)(2616005)(38100700002)(6512007)(86362001)(31696002)(478600001)(6486002)(41300700001)(110136005)(316002)(66556008)(66476007)(66946007)(31686004)(8936002)(4326008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a285MkpUUUQ4YTRIN011VTNTTnFvQVhlNGZJc1hva3E3VGtGcVljMTZ1MXBW?=
 =?utf-8?B?VjJoZVo4TEFvUkhIOEtFeGlmWHRRYUkxc2Y5cVB3MXh2NDIxK0NWNGdMeks5?=
 =?utf-8?B?V09vWTRkdllwUHpDMEcwT0hjU2tDMkxhZFpUYUpiREQxdEZJRWdDbDRzNnBL?=
 =?utf-8?B?MUNDdFlXUHpvL2ZKREFuTlR4d2lSMU54VXF6MEtEa2RXbjJHYlNZeGloNmt0?=
 =?utf-8?B?OEJ1UU9rUC9UTzZDTStWTUZtZzdmdE9IVjhza2V0eGlNZkFpNzRCNFhLSFdX?=
 =?utf-8?B?Y3JqclNMZmlhU3BNaVNmRDAvbjB6VENZMnBmVkUvdWcwRUFPWjdRSDZPN3pH?=
 =?utf-8?B?SXVCMVlPdUxiRVkxcHNjdmpEWlhVMmtSQ0pRMlZZRDYrd2tISEUveC9Dd3hU?=
 =?utf-8?B?RDIza3E0bDZTZndodUM5RVV4SnR6cG5KWTlyNGErZU9XampXNHJWR0VYY3Nm?=
 =?utf-8?B?RnJBbEp5eFcwK2VoYS9nMkVLakpVaXNROTA0ZlJnN0sxZ1I4M2tSaTM4NmJv?=
 =?utf-8?B?SVBLbHVuL3N1d1BwR3F2VC9FaW1nUk1oaGVRTnVramRIMWtSeHFoTk1pVnpR?=
 =?utf-8?B?U0hGWlVIaTduVDh0WUJ1YzQ1eStSVWZWc1hwQkdNTE9PL0JUN01ScXFVY2cz?=
 =?utf-8?B?blg3MlpZeW95Um5lS3o1WlB3bjlHdDFZY1hOZGZTbUhMcEx2U09oRmM4Uk0r?=
 =?utf-8?B?N2NpQ3NFWnNGYTFma1M2bGtIeFVLV2dEbmJ6VE0xV0lHdVFjZGJvV0MzUldp?=
 =?utf-8?B?YUJuUXJpNVNvR2VzbW9SbE1aMXJNQThzRFlXRVBHU3QvZXhDOEVQNzFUYno2?=
 =?utf-8?B?cUhpSEJPbW5vWFQ2VGJhMnY1TUJ4ZTBoWEVtSlQxSTZJd2ZwNHlINTZ4aERv?=
 =?utf-8?B?My9qZGRBNVdWY2k2T1BpQ21UeVRPMCtQemg1aGM5Z1BwUGZmMHRXYmFWazI1?=
 =?utf-8?B?WTNrREtuSWFuaVNvTDFkdmdiRk9obTd6MEIvWjdrcHN1WDZmZXdiZitZUlVn?=
 =?utf-8?B?d0tVZzB6aExDaFVWaFRrRGZybTdFQkdxaFlvb0Zkeml4ekwyYzZFaDhnKzVh?=
 =?utf-8?B?VnBqTmltS2pzNUVMWWlIQVc4NFFWQ3hKM0kvRFRQaWRpdHdCeWlWcVBRQ05i?=
 =?utf-8?B?SXBjSEVkdHc2dkRnZ2dnaXZrM1NXWHo2ZVpsdHp4SDBOMFhpai8waFpqc3Fm?=
 =?utf-8?B?cmp0MTVpcGFKei9STGNTczlZQVhVdkZEcHZNZXNtYVJZUTdrY1o1MG4wNlFt?=
 =?utf-8?B?U0lkbjlSbHVMZ2JsRkhLdnQraC9LZ2V0SWc3VE1lbXJUNzZWdmFzeHhpKzFU?=
 =?utf-8?B?UlNRMXM0TFN6VVJiUVlnU1BReE4xaXhTWUM4MURLcFczdkZYN2lHOWNNVzds?=
 =?utf-8?B?TWVqNTg0WTBaYkx6bkxXYzVJS21OZ1lGNHpXdGMxRmlldEcxTkJJcmVNWXVS?=
 =?utf-8?B?a1Z6aGVkMkRlUXpxT0J3Nkd4VDZyYmdOYnJxM1ZkVVM4bnR2bm44YjNLd0hY?=
 =?utf-8?B?U0ltc1liTlVRYWlZeUlyYkROcjZMcyt5UkNGNHYvVXptcC90SUE4NHRWcjVn?=
 =?utf-8?B?anphc3ZrdjRJaDBibDBSMTA0TklrRFdTTGJUOGEwVHVJckdFNmNwbVo4ZXZH?=
 =?utf-8?B?SldEbGkzZnE5b1NBUWhmQ1JiOVZONVJNQ0dBWloxTnZ6K0x2ZVZ4b1pTRElk?=
 =?utf-8?B?UGU1OGhJWisrdkpFM0l6azFSZlErYXRTMnA1TkR2L1RCWlRYbmZobmVpZDUv?=
 =?utf-8?B?K1M3S1R5dk55Nk5xQUE1YmVhZlNmWXVIOWgvU2hoMXJqM1hLUHl1ZUdLc3lz?=
 =?utf-8?B?SCs4L0R4MklzNmtmRmNtaWFGWmttNGZlMGxuNUdDdzNCMElHQVJzZDA1L0Jk?=
 =?utf-8?B?TlpCQ25aOUxsQXFodVV2dlYwcDJaUkFSSE1wdmd5RGtOcEgxQjVuOUQ5MkU3?=
 =?utf-8?B?ZEJocWxSaENFNGRkVmRyRkV4OEwzcHBHRVNuY25HY3lFTEJXeFhGbCtKd1pC?=
 =?utf-8?B?b0NnOS9nWmdoZ3djQ3NsT21LNGJTUHJPM3hiME1tTzd2T1hmS3B2Qmt1RXJq?=
 =?utf-8?B?OCtKalV0eUdPUjVoQWZjaW8vTEFNYy9lL0l4VDBnanBqR3VMKytaenI4SEEw?=
 =?utf-8?Q?BtdKCQcY3Ktqo0x4/jyW7rsmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d770efc-ffac-4e63-d954-08dbcfbafb15
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:16:58.8608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHBzjCLxq6IWMljFXkiufhiov5AEGVBjReGiVKZcy2DGIP8pqf4QJctLJnIbcAN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.10.23 um 03:03 schrieb Luben Tuikov:
> Remove a redundant call to amdgpu_ctx_priority_is_valid() from
> amdgpu_ctx_priority_permit(), which is called from amdgpu_ctx_init() which is
> called from amdgpu_ctx_alloc() which is called from amdgpu_ctx_ioctl(), where
> we've called amdgpu_ctx_priority_is_valid() already first thing in the
> function.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 68db924161ef66..4c6ffca97c4512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -56,6 +56,10 @@ bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
>   		return true;
>   	default:
>   	case AMDGPU_CTX_PRIORITY_UNSET:
> +		/* UNSET priority is not valid and we don't carry that
> +		 * around, but set it to NORMAL in the only place this
> +		 * function is called, amdgpu_ctx_ioctl().
> +		 */
>   		return false;
>   	}
>   }
> @@ -96,9 +100,6 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   				      int32_t priority)
>   {
> -	if (!amdgpu_ctx_priority_is_valid(priority))
> -		return -EINVAL;
> -
>   	/* NORMAL and below are accessible by everyone */
>   	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>   		return 0;
> @@ -625,8 +626,6 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -
> -
>   static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>   				    struct amdgpu_fpriv *fpriv, uint32_t id,
>   				    bool set, u32 *stable_pstate)
> @@ -669,8 +668,10 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   	id = args->in.ctx_id;
>   	priority = args->in.priority;
>   
> -	/* For backwards compatibility reasons, we need to accept
> -	 * ioctls with garbage in the priority field */
> +	/* For backwards compatibility, we need to accept ioctls with garbage
> +	 * in the priority field. Garbage values in the priority field, result
> +	 * in the priority being set to NORMAL.
> +	 */
>   	if (!amdgpu_ctx_priority_is_valid(priority))
>   		priority = AMDGPU_CTX_PRIORITY_NORMAL;
>   
>
> base-commit: 915718484b8fa1eede4499a939e2e4fc0d85caa4
> prerequisite-patch-id: a36f628997d923f66da5342e760e8b45ff959fb8
> prerequisite-patch-id: f15148c302329c0c60d86040571c61d367bd05e7

