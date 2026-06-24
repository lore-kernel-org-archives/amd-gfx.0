Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367B6CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 19:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68E010F026;
	Wed, 24 Jun 2026 19:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqpx+wvE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B3B10E122
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 19:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK4u5g5dgsjuRH0xPfpa/RrH64WLLtRVuzm7LIb1oufSqnYhnEgnAF1ce2zS+2Ev4UhHcK6RVpaVT/vYduxHvP6k8KH8bJaLAcqrL4qamQIMive6RbYhWU4cHNQGjWInSzmOBm8wIw4H0ShY8YfA4MtNWDK4NXs63gFjCgU7JqE2hvEi0eLFuN6VdJs6n1gZoIqE/e3o1RVW1wN/p1MkfwsdbiKl+fVNFgRgaHB/2YklYe9Q1M1fGhqasMvrhCe9ZrMePmedkxJCTJuc9K/L4Rya2zRrY2LEfIRUFGuOB0g3YfVYWT+YJlQUywRinSKMjWPZeS4fH6PKuUgDe18CuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRZKZmkYSt6Q0Cid3BWhnD0WMxEidt4xKc8ygIYrpUc=;
 b=Jz6SwlrwlUCEV2C6puQjE+3rW5UdSuxJyiMkzVZg+twdIX92DBYAZ+T3MR1qX4ldoVidgp+gDkK2Vkrd1s1C9kgQPlBW5cWdbQwLpYiNnd1jZWbRvFvW3HCbZebH7Cc9DeMbPK1BNRT72vXsBqSAKD45QNv0thrQ6zGPyxXPZvZ3Dtl3xVHf3OL/gh18O+8vyBvSU1nntfJtYTESY5zwzKPVW5DxqJq6zEFHjWF76uysqSvpN6XTcN6sBKaxwPzNBs7dwnhKQhIxIyGTcCOVfdWe4ArBEwGf+VUS8QGFMDGAIvxkB3D/MWQ0OK8G1Oy4+Y1VmxBFRrTlb13VzCFHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRZKZmkYSt6Q0Cid3BWhnD0WMxEidt4xKc8ygIYrpUc=;
 b=xqpx+wvE+WmDQ98kG4DUUCJVVVJQZSly6Vu08swklaAV+9CdULSMRX/JU1gcGgiI/Au43fM8D6TI1CFJ87dsxKQBn6ISsMVuH5Rcs1axhkdExR6xLFMIOnLvJVQ4ZR6l+lH/FioCFJsrvDIxTIGOl5t/XNQZjQSSs04iOI5vzuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 19:10:03 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 19:10:03 +0000
Message-ID: <1779c5ef-d0ce-43c3-8cb0-94fb2d08fb2f@amd.com>
Date: Wed, 24 Jun 2026 15:09:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix atomics on gfx1301
To: amd-gfx@lists.freedesktop.org
Cc: David.Belanger@amd.com
References: <20260624190702.596001-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260624190702.596001-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:52::28) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b4f330-1ff2-473c-3e2c-08ded22431a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sF5ahwrxavUPA8JlBAo9uakYCgeAhXOw2kOHrNl55x+h/JPdKIUllC04nzJ3nMqNgaP3flZaFxvyuhF2wbQL71TUYOVxxETGSFYE3Zn81yhITm7CzS98CCxfB4dU3GD9qc2BA29LRbkBA06FoJqJMvx7eDlr6lxb4CHOpu54BxHNbNXmwiPNoX7FkWWYNEK/2xqrqddmI+LRy0lt2RmvC3R0Bj/EDI/Gchez9WKKF+qzv31kmBgmAhQFO4i18Un+EtuJmCc4OcLxS6i4dVSJxMdfu2cTGM1pDqm74/Uh3fZlP7IP4hg5ekR4/HH2CsBdgEm4nG0X3lFXJbIlEhIW5NDpD6kWcSF2kMkw0vG5hByFKts6CXWgFpKzOaFnDtQdccNvU2d4+gYB9uNBKOXtl9MIg/JdMgvlHcxT3ZqabXnNgmnvIh6+uTyUTlo3pzjEu1EB7+gkHS3zA/dytHV6/0qvpfLjnVEpu0wWbl/XyXucH9wsS5tuajvdLyW9ESijaOr5poHFsL8KXJB47WmJVaagEdXt4PRskOhNQ/EFAqFplRsGh+ISSipF0cvMHjmdMk22eFxrh1b1z+bPRxTCq05/i4E4F1iMCtsFdTgBJGtGBt5/wPGPxpRtmdeBsQRzbEDqcco/6tZILGaLq8kpolOdPWlO2nEy/0PaG6ZTTG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Uva0svRzFnbGljS3lrbzZncFhYV2RvNXpnN2xPSytyei80MzNsZlFjNW4w?=
 =?utf-8?B?WFA4ZGNXR0hXRUxldWwzSHVXb0NHK3pwVG5TaHpqb1lKSVd2eU5yV1EvN0NO?=
 =?utf-8?B?eHZQMWRoU1dRQWRNQnYrVU85cWJDNXdWSUY5SldtbXlmYVVvTUR2TDRCTWhm?=
 =?utf-8?B?WkxaUHVHbTZUUm8wWjh6dlhUQUhYZ0ZsamhmaHJCM2dpbC9ObkVGa0dzWHEy?=
 =?utf-8?B?R2oxMkJ4S1Y5dVJJK0gvazBGM3ByMUxLRXNmV3VLdTYvUi95bWZFWnI3c01B?=
 =?utf-8?B?Mm81M2hmSElJWStrak1WRFNidmFBMHFmbks1NVNOa0lCUW5hdDlwcXdRODRN?=
 =?utf-8?B?eWpjOWtTRThBektqRmlQZWxjZEVFTS9BT0Y3RFVBN0taVk1lWU52cUxNS0pF?=
 =?utf-8?B?SHNWcEsrMUdyS294akgzUkkzRlphemFOaDNRMGw0RnRuaDVnU0lMK0pUWmps?=
 =?utf-8?B?c2NzLzFsWGx6SFZsNGhtaHRkaXQ0bzFPYklMV3UzazFnV2c3MG1LYkVuY1BI?=
 =?utf-8?B?YlFXemg5N3MvdFJWeEJCaThwdmtZbFQ4bGl5QllLeFhyRktZZVcxVVNUTmJn?=
 =?utf-8?B?NldiSjVpU1NLNXJwditncENxdVNFZU50cjZoOEJCQitqTmFZaVRCNDZKYWVj?=
 =?utf-8?B?bnBhNHlpMVN6RlRWYWxmZlV5c2V3QzhyVUtGOFNMckltenhtQTIwS0tjTy9G?=
 =?utf-8?B?bEJnSXlpNVBBRzdjdm1sNVBZOVdYc0R1eWVqR2NFNDc2Q2NnUkRkbUhucmI2?=
 =?utf-8?B?UFFPTG1VK2lLSWJQVCsxT3JhQ1grZkM3UXJoWXhGZXROOElpazBKQ01YWmhW?=
 =?utf-8?B?M1k3NWNEQlUxenY1TGovbjUxK3RVelJIdFMvdXptR0NYdHFaNHFicXYwREY0?=
 =?utf-8?B?TWhmNGxuWTM0bk5CU1E1dFFlUnZnRnd5T1lqc044MDVtUUZDQnNvcEN3d2xU?=
 =?utf-8?B?YkZPTmp3Wkt0Z1R1QW9xMzMzbjc3VFBLRDk2bzR0VkNTUjZnRWV5a3VwbmlQ?=
 =?utf-8?B?eUdWOVR1cjc3QnpFdE5LT0xlUDFzWlRKZGVyNnQzWThCTFRJOTFmYjNKcys0?=
 =?utf-8?B?bjMrQXZVSlNyNDhWbGRaZEZhK05OSURQdmh6WTdLZ0tkaGpzWGxuTGpRRERz?=
 =?utf-8?B?eGh4Y1hqeGtyYVhNRVZvUGQvZStNSXp5TDhFMWw0WkVwN0tVampNRW9wNVBZ?=
 =?utf-8?B?dFdJUXFHNlRscVRXZWNtUVFqaVVFT0VFNS9ueU1Pbit3REl4M2NwTnJpZ3Js?=
 =?utf-8?B?MldmdWNUSmtNZjRBQnVZMCthZ01RNFFjbk5Fb1VlQW1UbzJpZnVzeERkQWR1?=
 =?utf-8?B?SEFrbTRRSm9TaDF1YmVmL0F3RjgzR2NJeE9lbDlFSUdsZUxWR3V3NUI1VUQr?=
 =?utf-8?B?RW8wYUk5cTBYa1g3NFgxOEg1TmJqdVBCSjExYTBBWW52WkJBdjRvQXJoUXAy?=
 =?utf-8?B?cXZ2MzVyU1ZMU1Vnc1B1TThRT1lveWtxeko4Yk11ZzNENGR0RHBzdHF4MjFk?=
 =?utf-8?B?SUppU29SMXprM05kVTJsaW9WZDJSdlNDL0xRMHZqbTY2TGE4ZS8xN3dZbE14?=
 =?utf-8?B?ZGdxdHNYczA3SmNvZzllUDd1Ynp0YkZ0cjFYMEVYMndsclpPZFhuNy9nYTRC?=
 =?utf-8?B?bFA2RGthcUVzVXg1K2x0UkhzMTg3R0pnYWtCejZVc3F5S3UyNG5PcEk3dHRT?=
 =?utf-8?B?UzJJN2hBK2FMM2hneWMvVW5ib3FBWHY5b253ekFGSkQ0QVJHVzdyMlp3Qmpr?=
 =?utf-8?B?ZU1USHkyTFdnSXVUcTZ0UUlyaWk0WFRaWVBHUEhQTlIrN1ZOM0RWQmlSbWNs?=
 =?utf-8?B?SWJLWElsNUNEZ2tjN2FPTnkwNXkrMnhVNW5XV1dDeDQzQ3UySkVXQUlxS2V2?=
 =?utf-8?B?N2ZGQXhXVDRld3FhaWYxeWVFbVQ1anJleDJGcXVLT3JGYnJ2ZlpqQVlyR090?=
 =?utf-8?B?ZnMydUN3R01oQngyanR6V1paelF6TlNvVUVKckwwQ0pSbkhRMFAvSjJXZlcz?=
 =?utf-8?B?aWhlRGxVbkg5NnVjUURpbm9CU0ZXQUQ3MWdvV0UvZzhxOTYwb3J4V1E2MU80?=
 =?utf-8?B?cXR6NGJNWmpucXAyZ2VYOUI3anBQMzdDRzFZbGFaTU53WU1TclRmZlUyRUcr?=
 =?utf-8?B?ck0ydjJDU2JXUWpIK2tiV1dMVFdsckN2S1NFWjFydU9IaEdvckErS2NnZTN4?=
 =?utf-8?B?NVF3UVdxM3FGNkJzbkpYaXhMelEzUk1YVWMyTWJrekdHTC9TVjZSNk9qVFdk?=
 =?utf-8?B?VWZJOTdsaEZtek1rNTlIWVk5bEg0bUhkRTcwcEo3aGcyMUlOTW5KRXFNTm0r?=
 =?utf-8?B?bTRET2d5TFRtOVBZQnR0VHRrcXQrMHNHRWQ4dWlvaVNHanYxekhNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b4f330-1ff2-473c-3e2c-08ded22431a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 19:10:03.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QICjFyluTNkpPimVD24FGxM89LWxt4GSRpzq2HjIfkzgnsiGxJfwOr2ONWA6TdTFN4gnoWI4TMlA0lB7YLT//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

please ignore it.

On 2026-06-24 15:07, Eric Huang wrote:
> gfx13 needs to program DF config register as gfx12, so
> share the function of gfx12, they have the same register
> layout.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 055cc4f1c861..56a7764f3f8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3385,6 +3385,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case IP_VERSION(4, 15, 0):
>   	case IP_VERSION(4, 15, 1):
> +	case IP_VERSION(5, 0, 2):
>   		adev->df.funcs = &df_v4_15_funcs;
>   		break;
>   	default:

