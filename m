Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F65606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3p/rWbzU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6636F10E04E;
	Tue,  3 Nov 2026 18:17:28 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8D310E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 18:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfnPEUI35UdcSCJdTu3hFM4GedQItEZiuigyVQPgs72xF1A8jpt25VJa3GTnc0r9WuUfIzc7A6Xev5nCL7WZ52Z5GP8Vk6Dr/PWSQAVwwz2wOR9jI/JdjS7jO5bAIn08w1DRkQDeoE04BQ9/ikcKR9Gj0vgipu0OhSKQKP0XQ7m4EYpBadt44lVAWDRKnYiEVg91q4vOt8aD4Rftq9HsAOi3IK46hGuaI5KeROmFrSc1kfvHUaiVSmFrDe3yLyiG7BwbJRRR0EeNpJYI2DvN6yg8l/L3APq2mvBPjWGOviCY9PqPAtNq0koGtMfK92VP/4k0VXxJ5yP3k1wEti389A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzRD+kZoDTjLcV2T3idz/In35OTR33akkNl560jyKB0=;
 b=Fyi2QqqdLktGMJiyZjE1v76fzjdVv4Awvabx1B6SimIal0Yq73/GIQt78JOxr9Nn3oPow2Db/eivjoUsp9dT6Y70raIVQF8ofdByz3BA9h/swVKbNizo5sfl2txm4cn8Tq9VFcQYDVBQsegaPiJuTsWVxIgFRxlVb2HxOYFtSpvMAIf0ZE3y2qczOunXXfQ0UQ9/QwS7f2dongd4RYbizSxJGHcE5BdHRf7zQ6jIOaYHomSYV09DVuHvgtIgY2VRyxr2Bkqy9Da9oGNpXp5s1rXz9z3ykJVpTN5He4ZS2ObqjTAZPycrACB1dHgiKS+n+LYJGnKjXc4f+jO2qezFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzRD+kZoDTjLcV2T3idz/In35OTR33akkNl560jyKB0=;
 b=3p/rWbzUDUeY1XYHvT4eStiB+dIpv0EUWSGKkv+1TjygYcDiPvCVRveXahfuPJpsjD6x6dHpwhcBQkoMiJLe3m5Q0HTEbwcq4onjhD3jvlQXkc3sQAeolcfbv76QvAzTti2x3BLLYcNmvKFrw8vKKTsz1I6Xu9xAEq8oYosdFDk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:17:07 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 18:17:05 +0000
Content-Type: multipart/alternative;
 boundary="------------OPfnF89H390xQZcx79v7BG0M"
Message-ID: <619d73b1-6dc9-4945-b711-db8c34f379f8@amd.com>
Date: Tue, 3 Nov 2026 13:17:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261102160125.2743750-2-mukul.joshi@amd.com>
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 5426baf2-579a-41a1-6778-08df39d6aa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|261102123227099003|22082099003|261102130727099003|8096899003|56012099006|11063799006|5023799004|4143699003|261022105027099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: +oeBBJDwD8ZshZvTBF/RjXVr7fcryG0VZGZgL2DyojymwHOQQkhuY7k3ag+Yz3qp3dSoTchUO92i0Y9tbDcXQs2GxtafYyFrQt4pJ3f9R5WsyAROHefVA4syMnRYjnh0saxw+0rdI7h+4Ynj60QN5fX9dj3keTtzMdxKTkafgrX0V/DRXKDr9OWbZiR22oqMnjPcE8pDbl8zDDIQLu1owpL2OTiKsYFOevM9J1ceZx3V8vf8lVzvo20gcGftprYLvOV3x6NJZkDvZrGWY5McrA7xtB8BWcCjINuuq2P7/hLYQ5BO3OX60MNqO3sWX9Sae0HzK8qUN7H8sX504j0pdXp+5Jk+fIjuWK6JoHyQVCXQjbzWEGwCIli321nIaRT14O/g6zHdeGyWYUIbQNSXLWH5iHS7s1g07aweNlVRaJrKUzkQ59YGZGm8nRdoqlJ88nBzwBLMla5qKJQ4AVFSp0jpCja633+wUjOAVipGwBnT8zpAPy6Sug/tca/rdPlNp3ECrQdKpgynbe8aiN6jgODmnac7mB97jCnrDBM2X0lbi4ykSjehw/tKWIFQ0kNlAhZW4REkf1p6TTOn2LrpGBI96NgKe/dZdlW1PvtrQKC2ZzzjymEkovaNZQk5sDeL/6c72ZG26c4uz8/WxDPc4gHwtoOYD8SPWXIDLWO0nhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(261102130727099003)(8096899003)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhXUkM5WnQ1cHo3c3FvK1oveDhjQkhONUZMQStDdlVsU0FlVy90K1pCODcw?=
 =?utf-8?B?L3RoY3JwTWFia2pWVjc3dEtOR0p2YzN5eS9BRFpVZnZMVUt2UHo3dlhnSkd2?=
 =?utf-8?B?SGFsdU9DdW1XOUtWN1VSUGZVbVp4U0xkcGFXMDZJQ2dGM215b3p2c2VVSEg5?=
 =?utf-8?B?WjlPeXExQmRlZlVTSy94YUp1c0xYTktsV040Qmhyc0Ywa1dMNmN5YkdKU3I0?=
 =?utf-8?B?WThtTXhmZ0lRVXRDaEdHZUV6ZEl4djZDbzR0ekUyb01rUjNIZHo4ZnVwL1hJ?=
 =?utf-8?B?eUEzNmhkU05FRGlHWXhZTzJQUDdwSGZLYXIxRGVzcm50cTJ5YXNIS3JDaVJZ?=
 =?utf-8?B?cnVLSXFzMGNXenF2Q3RwcGg0Nmx1S2ROWWx6S0Z5WWZhZXA0V3gxbVA5MnJz?=
 =?utf-8?B?d2ZZMHdMOWYyYU9WRUVEWThnbVR2SDFmcS82alVVNHNLTlcvMkI1WEV6bGxG?=
 =?utf-8?B?aWVWcWYxLzBJTVJrVHhkZGwxTmNtQ3Erd0wzbzliblRVWjVXZGtnVE9YeXYw?=
 =?utf-8?B?U05lOU1HR3VHNGMwQUE1ckY1V3VuQjJFY2FWcE4rKzZCeGpiaGdoeG8rMmZi?=
 =?utf-8?B?dHJrUHl2dUowYmsveTVNcUduSEt6ZmhoK2IxVmdPMC9ZT0lrNzhncFYzNUZa?=
 =?utf-8?B?MU9UNkNlcnJ2MXEyYnpqSCtEMmtvQnQ1OXFHSUtoVUZTdk1oMWovSFlkQ29L?=
 =?utf-8?B?TkhwZGxVc0p6RmdweHU0elE0RC9GQzR5WkdyRlo5Tyt5RVo4c2JlbDUvQXJN?=
 =?utf-8?B?YXo5Z0JQN09ZMEZOWEpGWmc3Q3Y1eGhFQkZFd0VOUmxxRmd0RnIvWmRrU2JV?=
 =?utf-8?B?U0RrZGZkVm9kRDdSaWc1LzFFUzJNZ0FrUlJ1S0xvRTkzZkNMYVoxZm1ITTkw?=
 =?utf-8?B?eHN1NCtyL2QyRFVtQjZQUkx5bTgwNUVDUlNaTGpDTUZwU0h5ODhreDJKTkNI?=
 =?utf-8?B?MjZ1cU0rT0Ewak84U2Nib3dPTUliWldpT0NmR012UEp6akE4K2J3M2tiMVFR?=
 =?utf-8?B?QnVpOFE3UlpTaHJUT0NmcU82V3VIMzU4cFM5bnFZTVFCeER1SHJuTFlWeUNy?=
 =?utf-8?B?SERzajJhcWxqVGFldk5vSUduUVRaMnd5U0s5ejVnQ0V1TjVuMnE5OWZGZk9R?=
 =?utf-8?B?THErMGZ0eTFVb3l2bTRMQ2FRMlMzVENTRUQyMVQzTlR3VzN6eVY1b0pMTzlw?=
 =?utf-8?B?Ymx3eklhVUYxK0h5WFN5dlVwSzB6aU9od0NIMFg3Q3AzVVUvUGVoaTFEZm9H?=
 =?utf-8?B?ZmRCbVJScXAzb0NqTytOR2hLUkpqYUdxMXFwZ1dFTDNwMVRZbHc1VXR5YmI5?=
 =?utf-8?B?d3VlbUdaRWRibU5EWExXMUJXdXVuLy95YlE1SmI0VWUrZU5CR3RYeW1IMSs5?=
 =?utf-8?B?OEw5QkQwRHoybUhLQXo0YzlLcWQxK2dPa1hyUENxZ0dydExibktxYXdGTU1q?=
 =?utf-8?B?UU1FcTIyaTFYY3VrVUtteEJ4YTFvRUMyblNUQ3VxSEdIM01BeUZzajAvVlVq?=
 =?utf-8?B?WHNQeG1jSXpZbnM1L3Q0VExGODZianJoNkV0MHpycHVjSUFXanBjc3oyMUo3?=
 =?utf-8?B?YkdCL1FuM1k1eG5UZkRqQVZIdkNLTUFaaXgxZElMaVhaVEJBTnpKT3E5NG1O?=
 =?utf-8?B?RytTeFgvSXB1UHNObGdxM3ExQyt4K3l3Q0NlbDliQ3hoNDBDdytkczVXQTNv?=
 =?utf-8?B?TlFSSDAxYUF6dk4xNnExRWExOHgrVWtyNmVkN25RanB2U0pvV3hQQnV2WUtn?=
 =?utf-8?B?d2lZL1dLcytlQUVpTm5JQjVGdm12MVBndVhvM3Z0VVZFZnB3aXBzOTJubDZC?=
 =?utf-8?B?enlDakxNaWQ0YkFRN2ZqVk9jWjZBWUNZOW50cnNWZ3NYdjdpeWp6RzNmVXNE?=
 =?utf-8?B?cEtMUUZsTjBob1dHOTlZNnNoQkpLQVM4WXFXRlV4S0N2MEUxSHdBT2gwSm0x?=
 =?utf-8?B?Y0tDUmRYY3RGWG5HVjk1bmV4cHhwWjhiWHB4REIrTEhET3cwVlprMHBPTXJW?=
 =?utf-8?B?NGdTK0Zlcis2clpyNFlDWmYxdHpDK2ZyekNKN3pVNmpuczRQQU96b1c1MCtu?=
 =?utf-8?B?dk5HWnp6NVR4a1VMZ3YrN1o5TGJ3NXR6QlRoaHNiMExFZFN0QTc2NDAvV1dB?=
 =?utf-8?B?bWF6TFlRcXJadFpOcXpsazhHWHE0WEF5Zm9tTFRJRXI0ODU4Y1Qzc3grbDl3?=
 =?utf-8?B?NEIrK2VFclZyWTQybk05U1hBbC9Xc2xTaDJQZG1uMmQyZDloWVNTcWI2SkFO?=
 =?utf-8?B?OVE2aVJ5TlRJd2YxV1lTbnlKYVpsYXR1OEV4dUxLK3ZhNXRjQjh4dmhKRFM3?=
 =?utf-8?Q?rrK6F2u3b+a0eznZGG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426baf2-579a-41a1-6778-08df39d6aa36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:17:05.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQV64nyFMBLLs5S9BNV+uNWRhV8RhU+IZnIZ66mpIOVOPm8fYyc/KO91H1p14Wpg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

--------------OPfnF89H390xQZcx79v7BG0M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-02 10:47, Mukul Joshi wrote:
> Add the infrastructure for UALink loopback mode, where a single GPU
> plays both the exporter and the importer role under two fixed
> accelerator IDs:
>
> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>    with the fixed exporter and importer accel IDs.
>
> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>    ualink_imp_accel_id(), which return the exporter and importer accel
>    ID in loopback mode.
>
> - Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
>    workqueue used to emulate exporter->importer messages from
>    ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
>    destroys it from ualink_ip_sw_fini().
>
> Loopback is not enabled yet, and outside loopback both helpers return
> ppod.accel_id, so there is no functional change.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
> v1->v2:
> - Drop the change in find_peer_adev() as its not needed.
>
> v2->v3:
> - Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
>    and amdgpu_ualink_peer_remote_fini().
> - Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
>    through ualink_ip_sw_fini().
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
>   2 files changed, 133 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ca6432610f71..a98d5bbf0622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
> + *
> + * Allocates the ordered workqueue used to emulate exporter->importer
> + * interrupts in SW. Does nothing unless loopback mode is enabled.
> + */
> +static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
> +{
> +	if (!adev->ualink.loopback.enabled)
> +		return 0;
> +
> +	adev->ualink.loopback.wq =
> +		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
> +	if (!adev->ualink.loopback.wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
> + *
> + * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
> + * destroy_workqueue() drains any pending self-interrupt work first.
> + */
> +static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->ualink.loopback.wq)
> +		return;
> +
> +	destroy_workqueue(adev->ualink.loopback.wq);
> +	adev->ualink.loopback.wq = NULL;
> +	adev->ualink.loopback.enabled = false;
> +}
> +
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>   {
>   	if (!adev->ualink.info)
> @@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
>   	return NULL;
>   }
>   
> +/*
> + * Physical accelerator roles.
> + *
> + * Outside loopback a GPU owns a single accelerator, so both helpers return its
> + * ppod.accel_id and the exporter/importer distinction collapses. In loopback
> + * the one physical GPU plays both roles: the exporter owns the MP nHT and
> + * receives all HW traffic, while the importer is the (virtual) HW sender for
> + * the importer -> exporter path.
> + */
> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.exporter_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
Replacing ualink_accel_id with ualink_exp_accel_id is misleading for the 
non-loopback case, since each device is both an exporter and an importer 
at the same time. I'd prefer to add the loopback-enabled check inside 
ualink_accel_id() instead.

It also looks like ualink_imp_accel_id is only used by 
amdgpu_ualink_process_irq and amdgpu_ualink_remote_interrupt under the 
loopback-enabled condition, so it could be removed as well. That would 
simplify the patch and drop all the ualink_accel_id renames.

> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.importer_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_ualink_ppod_setup *ppod_setup;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ualink_info *info;
> +	int r;
>   
>   	info = kzalloc(sizeof(*info), GFP_KERNEL);
>   	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
>   	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
>   	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
>   	if (!info || !ppod_setup || !vpod_config || !stations) {
> -		kfree(info);
> -		kfree(ppod_setup);
> -		kfree(vpod_config);
> -		kfree(stations);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto err_free;
>   	}
>   
> +	r = amdgpu_ualink_loopback_sw_init(adev);
> +	if (r)
> +		goto err_free;
> +
>   	info->ppod.accel_id = 0xffffffff;
>   	info->ppod.bandwidth = 0xffffffff;
>   	info->ppod.latency = 0xffffffff;
> @@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->ualink.stations = stations;
>   
>   	return 0;
> +
> +err_free:
> +	kfree(info);
> +	kfree(ppod_setup);
> +	kfree(vpod_config);
> +	kfree(stations);
> +	return r;
>   }
>   
>   int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> +	amdgpu_ualink_loopback_fini(ip_block->adev);
>   	amdgpu_ualink_object_fini(ip_block->adev);
>   	return 0;
>   }
> @@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>   			     AMDGPU_UALINK_ACCEL_MAX);
>   }
>   
> -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
> -{
> -	return adev->ualink.info->ppod.accel_id;
> -}
> -
>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
>   {
>   	return adev->ualink.info->vpod.addr_mode;
> @@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
>   	struct dma_fence *fence;
> @@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
> @@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   
> -	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
> +	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>   	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>   				      &remote->rptr_cpu_addr);
>   	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
> @@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> -		ualink_accel_id(adev), ualink_addr_mode(adev), status);
> +		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>   
>   	/* Alloc metadata structure for all GPUs */
>   	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
> @@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
> -		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
> +		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>   
>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>   
> -		if (accel_id == ualink_accel_id(adev))
> +		if (accel_id == ualink_exp_accel_id(adev))
>   			continue;
>   
>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
> @@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   						     ualink_tlb_wptr_offset(adev, accel_id);
>   
>   		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
> +			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>   			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> @@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   				      u64 *wb_npa, u32 type)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 accel_id = ualink_accel_id(adev);
> +	/* The GPUID encoded in the write-back NPA address is the routing target
> +	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
> +	 * physically-owned accel_id: outside loopback that is our own accel_id,
> +	 * and in loopback it is the exporter (the only id the single GPU owns
> +	 * and can receive on). The importer is only a logical source id for the
> +	 * forward path and must never appear as an NPA GPUID.
> +	 */
Maybe move this into the patch comment.

Regards,
Philip
> +	u32 accel_id = ualink_exp_accel_id(adev);
>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>   	uintptr_t wb;
>   	u64 npa;
> @@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   						   &peer->shootdown, &tlb_wptr);
>   	if (r) {
>   		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
> -			ualink_accel_id(adev), remote_accel_id, r);
> +			ualink_exp_accel_id(adev), remote_accel_id, r);
>   		return r;
>   	}
>   
>   	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>   		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
> -			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
> +			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>   		return 0;
>   	}
>   
>   	dev_dbg(adev->dev,
>   		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
> -		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
> +		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>   		remote_accel_id, int_wptr, tlb_wptr);
>   
>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> @@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *interrupt;
>   	struct amdgpu_ualink_ring *shootdown;
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	/* This sets up the send rings (local sender -> each remote dst). In
> +	 * loopback the HW-served direction is importer -> exporter, so the
> +	 * local sender is the importer; the skip below then skips the importer
> +	 * and sets up the peer[exporter] ring that the HW path needs.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);
     if (adev->ualink.loopback.enabled)
src_accel_id= adev->ualink.loopback.importer_accel_id;
>   	u32 dst_accel_id;
>   	u64 npa, flags;
>   	int r = 0;
> @@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>   {
>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	/* Mirror peer_remote_init: in loopback the local sender is the
> +	 * importer, so unmap the peer[exporter] send ring that was set up.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);
>   	u32 dst_accel_id;
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
> @@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   {
> -	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
> +	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
>   		ualink_addr_mode(adev));
>   
>   	adev->ualink.msg_ctl->send_halt(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..0b1e8dd38666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
>   
> +/* UALink loopback support.
> + *
> + * In loopback mode a single GPU loops UALink requests back to itself for
> + * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
> + * as the exporter on one and the importer on the other. Loopback is enabled
> + * with the amdgpu.ualink_loopback module parameter.
> + */
> +/* Fixed accelerator IDs used by a loopback GPU. */
> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
> +
>   enum amdgpu_ualink_conn_state {
>   	AMDGPU_UALINK_CONN_NOT_READY			= 0,
>   	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>   	int (*send_halt)(struct amdgpu_device *adev);
>   };
>   
> +/* UALink loopback mode state.
> + *
> + * When @enabled is true this single GPU acts as both exporter
> + * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
> + * physical GPU, so exporter->importer messages cannot be delivered by the
> + * (single) MP nHT and are instead emulated in SW by feeding them back into
> + * our own IRQ handler via @wq.
> + */
> +struct amdgpu_ualink_loopback {
> +	bool enabled;
> +	u32 exporter_accel_id;
> +	u32 importer_accel_id;
> +	struct workqueue_struct *wq;
> +};
> +
>   struct amdgpu_ualink_mgr {
>   	u64 npa_size;
>   	u32 psp_if_ver;
> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
> +	struct amdgpu_ualink_loopback loopback;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   

--------------OPfnF89H390xQZcx79v7BG0M
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
    <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">Add the infrastructure for UALink loopback mode, where a single GPU
plays both the exporter and the importer role under two fixed
accelerator IDs:

- Add struct amdgpu_ualink_loopback to track the loopback state, along
  with the fixed exporter and importer accel IDs.

- Replace ualink_accel_id() with ualink_exp_accel_id() and
  ualink_imp_accel_id(), which return the exporter and importer accel
  ID in loopback mode.

- Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
  workqueue used to emulate exporter-&gt;importer messages from
  ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
  destroys it from ualink_ip_sw_fini().

Loopback is not enabled yet, and outside loopback both helpers return
ppod.accel_id, so there is no functional change.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
v1-&gt;v2:
- Drop the change in find_peer_adev() as its not needed.

v2-&gt;v3:
- Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
  and amdgpu_ualink_peer_remote_fini().
- Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
  through ualink_ip_sw_fini().

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
 2 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ca6432610f71..a98d5bbf0622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
+ *
+ * Allocates the ordered workqueue used to emulate exporter-&gt;importer
+ * interrupts in SW. Does nothing unless loopback mode is enabled.
+ */
+static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;ualink.loopback.enabled)
+		return 0;
+
+	adev-&gt;ualink.loopback.wq =
+		alloc_ordered_workqueue(&quot;amdgpu_ualink_loopback&quot;, 0);
+	if (!adev-&gt;ualink.loopback.wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
+ *
+ * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
+ * destroy_workqueue() drains any pending self-interrupt work first.
+ */
+static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;ualink.loopback.wq)
+		return;
+
+	destroy_workqueue(adev-&gt;ualink.loopback.wq);
+	adev-&gt;ualink.loopback.wq = NULL;
+	adev-&gt;ualink.loopback.enabled = false;
+}
+
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 {
 	if (!adev-&gt;ualink.info)
@@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
 	return NULL;
 }
 
+/*
+ * Physical accelerator roles.
+ *
+ * Outside loopback a GPU owns a single accelerator, so both helpers return its
+ * ppod.accel_id and the exporter/importer distinction collapses. In loopback
+ * the one physical GPU plays both roles: the exporter owns the MP nHT and
+ * receives all HW traffic, while the importer is the (virtual) HW sender for
+ * the importer -&gt; exporter path.
+ */
+static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev-&gt;ualink.loopback.enabled)
+		return adev-&gt;ualink.loopback.exporter_accel_id;
+
+	return adev-&gt;ualink.info-&gt;ppod.accel_id;
+}
+</pre>
    </blockquote>
    Replacing ualink_accel_id with ualink_exp_accel_id is misleading for
    the non-loopback case, since each device is both an exporter and an
    importer at the same time. I'd prefer to add the loopback-enabled
    check inside ualink_accel_id() instead.<br>
    <br>
    It also looks like ualink_imp_accel_id is only used by
    amdgpu_ualink_process_irq and amdgpu_ualink_remote_interrupt under
    the loopback-enabled condition, so it could be removed as well. That
    would simplify the patch and drop all the ualink_accel_id renames.<br>
    <br>
    <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev-&gt;ualink.loopback.enabled)
+		return adev-&gt;ualink.loopback.importer_accel_id;
+
+	return adev-&gt;ualink.info-&gt;ppod.accel_id;
+}
+
 static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 					 u32 accel_id)
 {
@@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	struct amdgpu_ualink_info *info;
+	int r;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
 	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
 	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
 	if (!info || !ppod_setup || !vpod_config || !stations) {
-		kfree(info);
-		kfree(ppod_setup);
-		kfree(vpod_config);
-		kfree(stations);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_free;
 	}
 
+	r = amdgpu_ualink_loopback_sw_init(adev);
+	if (r)
+		goto err_free;
+
 	info-&gt;ppod.accel_id = 0xffffffff;
 	info-&gt;ppod.bandwidth = 0xffffffff;
 	info-&gt;ppod.latency = 0xffffffff;
@@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	adev-&gt;ualink.stations = stations;
 
 	return 0;
+
+err_free:
+	kfree(info);
+	kfree(ppod_setup);
+	kfree(vpod_config);
+	kfree(stations);
+	return r;
 }
 
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
+	amdgpu_ualink_loopback_fini(ip_block-&gt;adev);
 	amdgpu_ualink_object_fini(ip_block-&gt;adev);
 	return 0;
 }
@@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
 			     AMDGPU_UALINK_ACCEL_MAX);
 }
 
-static inline u32 ualink_accel_id(struct amdgpu_device *adev)
-{
-	return adev-&gt;ualink.info-&gt;ppod.accel_id;
-}
-
 static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
 {
 	return adev-&gt;ualink.info-&gt;vpod.addr_mode;
@@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u64 timeout = msecs_to_jiffies(2000);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
@@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 
-	dev_dbg(adev-&gt;dev, &quot;accel_id %u\n&quot;, ualink_accel_id(adev));
+	dev_dbg(adev-&gt;dev, &quot;accel_id %u\n&quot;, ualink_exp_accel_id(adev));
 	amdgpu_bo_free_kernel(&amp;remote-&gt;rptr_bo, &amp;remote-&gt;rptr_gpu_addr,
 				      &amp;remote-&gt;rptr_cpu_addr);
 	amdgpu_bo_free_kernel(&amp;remote-&gt;ring_bo, &amp;remote-&gt;rb_gpu_addr,
@@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw status 0x%x\n&quot;,
-		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
 
 	/* Alloc metadata structure for all GPUs */
 	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
@@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
-		wptr_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * ualink_accel_id(adev);
+		wptr_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote-&gt;active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev-&gt;dev, &quot;init for accel_id %u\n&quot;, accel_id);
 
-		if (accel_id == ualink_accel_id(adev))
+		if (accel_id == ualink_exp_accel_id(adev))
 			continue;
 
 		rb_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * accel_id;
@@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
 		dev_dbg(adev-&gt;dev, &quot;init from accel_id %u to accel_id %u, rb_size 0x%x\n&quot;,
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
 		dev_dbg(adev-&gt;dev, &quot;rb 0x%llx tlb rb 0x%llx\n&quot;,
 			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
 		dev_dbg(adev-&gt;dev, &quot;rb wptr at 0x%llx tlb wptr at 0x%llx\n&quot;,
@@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u64 *wb_npa, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 accel_id = ualink_accel_id(adev);
+	/* The GPUID encoded in the write-back NPA address is the routing target
+	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
+	 * physically-owned accel_id: outside loopback that is our own accel_id,
+	 * and in loopback it is the exporter (the only id the single GPU owns
+	 * and can receive on). The importer is only a logical source id for the
+	 * forward path and must never appear as an NPA GPUID.
+	 */</pre>
    </blockquote>
    Maybe move this into the patch comment.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
 	uintptr_t wb;
 	u64 npa;
@@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 						   &amp;peer-&gt;shootdown, &amp;tlb_wptr);
 	if (r) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u read remote %u wptr failed %d\n&quot;,
-			ualink_accel_id(adev), remote_accel_id, r);
+			ualink_exp_accel_id(adev), remote_accel_id, r);
 		return r;
 	}
 
 	if (peer-&gt;interrupt.wptr == int_wptr &amp;&amp; peer-&gt;shootdown.wptr == tlb_wptr) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n&quot;,
-			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
+			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
 		return 0;
 	}
 
 	dev_dbg(adev-&gt;dev,
 		&quot;accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n&quot;,
-		ualink_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
+		ualink_exp_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;int_wb, NULL,
@@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* This sets up the send rings (local sender -&gt; each remote dst). In
+	 * loopback the HW-served direction is importer -&gt; exporter, so the
+	 * local sender is the importer; the skip below then skips the importer
+	 * and sets up the peer[exporter] ring that the HW path needs.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);</pre>
    </blockquote>
    &nbsp; &nbsp; if (adev-&gt;ualink.loopback.enabled)&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="white-space: pre-wrap">src_accel_id</span>=
    adev-&gt;ualink.loopback.importer_accel_id;
    <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* Mirror peer_remote_init: in loopback the local sender is the
+	 * importer, so unmap the peer[exporter] send ring that was set up.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
@@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	dev_dbg(adev-&gt;dev, &quot;halt accel_id %u addr_mode %d\n&quot;, ualink_accel_id(adev),
+	dev_dbg(adev-&gt;dev, &quot;halt accel_id %u addr_mode %d\n&quot;, ualink_exp_accel_id(adev),
 		ualink_addr_mode(adev));
 
 	adev-&gt;ualink.msg_ctl-&gt;send_halt(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..0b1e8dd38666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
 #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
 
+/* UALink loopback support.
+ *
+ * In loopback mode a single GPU loops UALink requests back to itself for
+ * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
+ * as the exporter on one and the importer on the other. Loopback is enabled
+ * with the amdgpu.ualink_loopback module parameter.
+ */
+/* Fixed accelerator IDs used by a loopback GPU. */
+#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
+#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
@@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
 	int (*send_halt)(struct amdgpu_device *adev);
 };
 
+/* UALink loopback mode state.
+ *
+ * When @enabled is true this single GPU acts as both exporter
+ * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
+ * physical GPU, so exporter-&gt;importer messages cannot be delivered by the
+ * (single) MP nHT and are instead emulated in SW by feeding them back into
+ * our own IRQ handler via @wq.
+ */
+struct amdgpu_ualink_loopback {
+	bool enabled;
+	u32 exporter_accel_id;
+	u32 importer_accel_id;
+	struct workqueue_struct *wq;
+};
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
@@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
+	struct amdgpu_ualink_loopback loopback;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------OPfnF89H390xQZcx79v7BG0M--
