Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE8C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 22:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F14310E465;
	Wed, 17 Jul 2024 22:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PNtNR0U2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9231210E465
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 22:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyQbqg0atcRdiKGBx6fu650fW+Jg0pGQRAZv/geCJKQr3W3ZjIeqptOauqZuddzjIZwLllcLPDJ/DjMNqVokORGh6YD5/iqZpbp4zW4UYPo6xyk3Xi+NqaMVPODpQeZ2tp65+7F2u9RWKU8p3uscc20/3iJ+OzHKaETVSH3k8B5aBIpxO7NE/9S+B7fDyjdgMz+c7XknHeQ3aB098pwk0qvWsXFsNN2bl/YpSts5d8L/80+sRHjAoStJ0zQDH8Id5neuHo91CI/zecwDx/cZjPzEWK22j/U4jqqnK9bfeNM1deqc9VH5G84wx/hqI4nQnOc+Yw5DdzbCY6opwAmNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBIEbi5popM1IE87ORBSTUJDSBD3Lrwe20E3CJO+qpE=;
 b=o9LAB/JVq3c0zCX5AjxjupH2sUaRXK1cTFWV6kuROMr/x9H6CZWQ2/2BHJACLGv2Cd2/Ji7gXNy/K4OzbuKm1W47NzZX3JE7Myn8uYV5j1scS6LgC9u2ccKj2z8pPHyP18DNj3Mf7evvpOedKzUZGg1VuE83UY/4z9p94JmyhTFfZBHHN3/DkJdRlxYWUBYSmSwyI0FHXANQi2K7dzo62cbHWDz48325k/amVPBofU+QKoHh1oi+gvMTS7E4B6V0gnkVQPzFoCpegj7A0kwoRz1vuR2CRrh2Fn8k8SQMThfEX5UwGkm993MrnKe+J7yllDKuKnq3szXtvwBrtFn5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBIEbi5popM1IE87ORBSTUJDSBD3Lrwe20E3CJO+qpE=;
 b=PNtNR0U2U44YAVKh/x1utId2+svDuBkFd2ykg1yPb3J49sVpw4nApYcxsj8nttWcAkzzDEay2Fwib2Q0QmOKaAk9RgjLOBZK/BSO/rB9xFoIiLTARCPPlwCwtyZ3co7jxU56fMCJh3Sr1e+7e+NOfA6CQe14J8zESm62GxTHFTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 22:04:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 22:04:04 +0000
Message-ID: <230ee72e-4f7f-4894-a789-2e1e5788344f@amd.com>
Date: Wed, 17 Jul 2024 18:04:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240717204011.15342-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240717204011.15342-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d496a4b-697d-44c3-2942-08dca6ac5ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0p4MlFYRWRKczZwK3FGRzl5TkhVV0xLQ0NESGNaUmFzMmtQMWtPMng1R3Ns?=
 =?utf-8?B?UXVqSE1uSWVPbTVTOEFlSG1lODVDUk1JQXk3MjZmeHRXbTNjTWwrQ1BaQ2E0?=
 =?utf-8?B?OTVKd3luaFdOOTZSQ3JvdXBUQkx1Y2l0SUpBczBMYkRIV0t6eUxyNWFIK0dp?=
 =?utf-8?B?YlRSZHA5RjlPWlNtbzdNZmkxcGJkK0JUMkE5cDdDcjFXZWlwNGpwMzNvbXRM?=
 =?utf-8?B?TmJ4MzRXNUxua2RwSE9kMTZ3QUhDSys4TllRK3EyTUJvTUVYeUFKb0JQSTBI?=
 =?utf-8?B?RTBGcWh1MGdKUGQ1Wm0wTTJvQi9FSTJ0Y0xIUkMwcE1kRTYyWVVBSHVlN2FU?=
 =?utf-8?B?YVArT2IwdkFOOUpkcXFzZmp4OWh3MXNqVFE4N2g0Vm9PM0p3WGRVVmZKQ0k1?=
 =?utf-8?B?YXNRVDh1TUxVVEdXcnkwYUFLNVdoM3pRY2ZUaTlTR0JiU2xIZ3ltZzE2b2Er?=
 =?utf-8?B?RmlnOFBNRy9ocWgvZlBnUE9CNGtjckwxM25mdlpzcHQyYjYraTR6UFRyUUFC?=
 =?utf-8?B?QXdFbStDY1VjTkFvUXExTTR4WDBnZDJyRWRBNDBpRjM4b1VuSnd1WGxJU1Z5?=
 =?utf-8?B?SFdxMDN4MTZNVnJjR3lnK01CcS96cGlxc1FKMGRkWmpjSlBReVQvTDlNenVN?=
 =?utf-8?B?R0dRU2FZWHFEVHA3c2lrWURVUHJ0RUlwNmlya0dpL3VXM3JEKytQWW95Tlg0?=
 =?utf-8?B?YUdUZ29NN0ZXWGFDN21TK29mZ000QmZta2ZmcHNSZmF6bGtnbkVhYWRQU0xU?=
 =?utf-8?B?eVFSQk40TVEvU2pWL3BKalBhZDBIWkdHSnc1UWdab1c1bVV6d1UwRzFFaHNH?=
 =?utf-8?B?OXQzdWRlMmd1ZTM5UHg4eDRzN2FiVFdtSWF3TnZGbzJab252UFIybHpucFVu?=
 =?utf-8?B?WnRFdnhjT2NJNE82MU1xbTN1aUFNdmw4cHp2MmcwdUxFaXROR3YvSVcwb0U3?=
 =?utf-8?B?Zm5uaVRsc3VSQjcwNTYyUm1KV00zRy9PNm16VWgzaUhYWXpkc1QzejZDTXFZ?=
 =?utf-8?B?YjhaZzc1WDZKOHVlakRsRVBDWUlUdm4vaTU1OFFFUUdCZ0psV0JBeXB6dWlZ?=
 =?utf-8?B?L0xDN1JVTVNOUnRVd1hpRDBYWVJ6TVFqWHVlTDN0cWR0NGhtdUVwS2prcWUr?=
 =?utf-8?B?UlNIUGhqSkNmcStORTNmaC9yaFhkc2dxZWNzd093ZndrL1o5U0hCcmVVaFN0?=
 =?utf-8?B?RnhLL01PWFlnQjBpN3VOUFZyOVlTS0ZrYzRONWlESmkzMS8vMXlJQnhVTFNG?=
 =?utf-8?B?WGUwYnhWSUZ6MThYc1dKQ3czMHhrdmVpTHpESGwwZWd0VTlDaTFmek01blRq?=
 =?utf-8?B?QmJ5ZjgxV1dzVy9HMWlVYmh2eGpGTVJrWTlnU3lBWjVoV25FdXcveXFMSzEz?=
 =?utf-8?B?NS9tVk1lZ21saEkzelZPMCtZTW5nSGs3Ly9SeWZMenNrZUFUNGZpa1Zwbno4?=
 =?utf-8?B?YkNUYmFYU09JSTVqejk0UHQ2RERxcEF6Mzh2cS8zd0ZhMWNISEcwOWxTdWdX?=
 =?utf-8?B?d0d2bnRBZ0JsN0c1ZFkrTmp6cHFiQ3pOa211TDJhaVBOOW9DRmkrZWdZU0FY?=
 =?utf-8?B?SmdOc3dWaThFaGl1RkErWk1LWk9RQ1VTYmM4OSs5NDhIN21NVHB6aGVzWmZG?=
 =?utf-8?B?cVU1YjdnMkdmUnlEWVBQZUQrc2g1TkdsYnNobmdveHI5UkZYNnpBanp5aGNx?=
 =?utf-8?B?VERDQnN3S0RrUzlOb1hkQzZqMkZBQUZESkRVcWJLdzE1VHV0Tm5sNS9tTmdI?=
 =?utf-8?B?aUUzQjZ4TndFS3FwVm1OSGw1TG9ETStJeWREb09LbTFmcGJQL1JYZkhRN0p1?=
 =?utf-8?B?Uk9hajJINmx1WjNHdjFjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J4Y1dOb2hLcE13c1JrQWFoQiszemNnY2dPeFFvVlJpSllpRXVLUjlTSVVh?=
 =?utf-8?B?ak1NTUdoOWRmQjZscW8yT0VFRHViemdsMENpRnBoK0Z1QS9qT1BJN0dhQ2xD?=
 =?utf-8?B?QzBWWlhrM1hQb0hGd2Voa3lrcDI0WmlHem1sZHdtVERFRDUwKzVuSGFDS2ZY?=
 =?utf-8?B?LzBXMDFLQUFBSlU0TlI2TGRVZllvL3UxSVIwR0E0UXpNcUR5bFJ4OHBCNnhN?=
 =?utf-8?B?U25jcklwUEdnZnl4TXM3WVY1ZHhTd2dpRFFXVTNLYjl2OXk0cC9ad3lCc1hV?=
 =?utf-8?B?OVVhQmluUnRXZU5qcUZHejJaYWZhU3hKVzB4b1h3dnZqZ2VLY0hTM21KVGVR?=
 =?utf-8?B?Z24wOUhoYkZSRzBKZWhzaG01WlBDSUExUlQrUElhVWcxeVc2ZVlrQXlIZTNB?=
 =?utf-8?B?RXlzZERXN01IMU9YYWZzWVptRnB5L1VWbWpoeVBNZ2t0OHBFMGI2ZXhyN3Mx?=
 =?utf-8?B?Z0ZQUHpFampzaHIyQTNKQ05qam1xdUcwQzM1TjE2WnN6WjZtTHVKQjc3d0hq?=
 =?utf-8?B?WXRuZEhPQWU0LzErYjRVTlpKL2krRnRTVjhwWENFdkNsQ2lEWDdoSHN5Z29O?=
 =?utf-8?B?cTRwKzRCekg2c3BhRTArR296U0RBYmpRWUV4Q0R5OUxFejJpVE52U01tWHJy?=
 =?utf-8?B?OXV0K2VLUnhTZ2FtRXRtUm5hTHpEUTVpblpzT1JrY2ZKalNDYWtlTFFwRXNu?=
 =?utf-8?B?a0ljbSszcEFtZ1FqZHE2Y0pjZVJrWmd5K2ZFaTdnMEtkb0RiT3c4NUVSSWlO?=
 =?utf-8?B?dzcxeTRRd2oxWm03QmUzNDQvL3h4ZWs3OVJ0WE1QNC9qcWEwSzdKV2VObE9X?=
 =?utf-8?B?VEpDcTJlSVBQTmJ3bVJSM1VPU1lseEptNzdxODVNTXJ2SFptZUtzcFVhMUx6?=
 =?utf-8?B?U1hQeTdkWXNIODQvQjdTY1hmWDVRMjVpeUtHSjRnRE93VnE2aFZybE9pYkF6?=
 =?utf-8?B?SDlGcnpaUVI2R211UXU1YVRNZkZnZVpyZ0NKUnc4WVMyMnZ3SGhSVzR6V3ph?=
 =?utf-8?B?YjIyZXpKZTFsbTJtaVVTME5XMG1uQnVpK0pVS0c5aFlKbEpJL3RHUG9oUklt?=
 =?utf-8?B?WHZIVnVJSUtlZEJsYlpFWjRvQUIxUkY3T1hIS0pPd0RSem80MDFPNzJsTk5o?=
 =?utf-8?B?KzBRMTJ4TkFkT2dCSVV0VTV4Y24yRHpPWGw1ekFHdi9tNlp3RzFMeEp4cHJR?=
 =?utf-8?B?bHRGdklEUFdyN01DSFcydHowNjVVaW9ZenZDc0NtbUFJN1FwcDhTREQ5Ym91?=
 =?utf-8?B?SWtHY3gvM3ZYZlBRQk5UUzNmUisxQ1krQ0lZV1FNNnRoNTVPL3VrMUtOcnB2?=
 =?utf-8?B?WWlKd2cvK2t2SjV6OUxDK2l1Q2JraVpzZjNsTldkMGgwQldHM2Z2UTIzVVh4?=
 =?utf-8?B?NUhGYlUzcTNCbTZWY0dnRDhuQWl4UFREWXJTajRmSnJ2aVh1L0p3TGp2bEV3?=
 =?utf-8?B?dUZ0ZXRZakVQRFpFOW5mTDZTRmI5UjliZjFsbnkvVGdhek5DcGV2d21mUHAv?=
 =?utf-8?B?elEyVDhZSWJ6cFVhQWJ2NEgzekNqdzhLeitEcDZDYjF4YlZQa0JCd1plcWZG?=
 =?utf-8?B?dm5lT2J2Q1JxVVVBTkFVUHViOWlYT2ZJYU9JaHpYeTY0SGg3cTM1Q2E1Rlo1?=
 =?utf-8?B?UTUyeVJnZ2dTTzFJcEcyRkQ3UmxHRGJTOXBsOXRiWFZnTHN0a0hkR1dzQ3NX?=
 =?utf-8?B?amFWNEtWVzB1OVJwK2x4Z0FtRnRIdTFhcGN3N25lc0RETEVqbUh2UDRuMzlo?=
 =?utf-8?B?c1JFMWhSa1UvcHQ2eGhnZUoxVUVucHFvU1NDcitGTG1tM0J3QUhFTjA0S2x1?=
 =?utf-8?B?YWx0bktEdlBQY1FZMTI1YkQrN1dtdGxGQWw2TjlNQktTMnlZS3hVRGRDK0ZJ?=
 =?utf-8?B?U0JiYU51dW5SMm9jQzVqQUlZMzJkbko4NkxTczB0WUV3LzBlRFlnaGFwTlhC?=
 =?utf-8?B?QzZzZzBwQjE4UFllRTk0aTN2QVNHTllIUW5FWnR6c0pTU0d5M3J6NHFKaXRO?=
 =?utf-8?B?dGY4NGV0MFd1Wk9Zb0xiWG1obGxXa2k3R0t3cUQzRHB5S1N1K3N5WDBuQnNw?=
 =?utf-8?B?RzIyZmZuaWpCbTU4aHBObXRlMTFDS3ordk1FblVBZlcwWTZFU1R3MEF3QzZr?=
 =?utf-8?Q?kX53es24GT6AO8gPJ0Pp+cGnY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d496a4b-697d-44c3-2942-08dca6ac5ef5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 22:04:03.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H/AsF63BRWZoquLww0/I49H/IyvJrV6VCvdGEMY0P8tNeTU+Y2YYM3pHEG30Ft+w9FNO5eoGkMdUendOEg9vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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


On 2024-07-17 16:40, Alex Deucher wrote:
> Add the irq source for bad opcodes.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Looks like all the error IRQ handlers return 0, which means the 
interrupts will still get forwarded to KFD (which is good). The series is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddda94e49db4..86d3fa7eef90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -391,6 +391,7 @@ struct amdgpu_gfx {
>   	struct amdgpu_irq_src		eop_irq;
>   	struct amdgpu_irq_src		priv_reg_irq;
>   	struct amdgpu_irq_src		priv_inst_irq;
> +	struct amdgpu_irq_src		bad_op_irq;
>   	struct amdgpu_irq_src		cp_ecc_error_irq;
>   	struct amdgpu_irq_src		sq_irq;
>   	struct amdgpu_irq_src		rlc_gc_fed_irq;
