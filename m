Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A6DE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 13:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2CC10E3F7;
	Wed, 11 Dec 2024 13:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFnRakuq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B55F10E3F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 13:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sodICXZOAb/9+qc27QikJSAOq8BwoX9HAN4rFyqDJz9k9yNsmlqXK0x0YRNKt9mfGjNjd5sZT+yU+X5KM0YAlyej+KKBkFzdPSoH2NQqt1V2llysFajqFq0zwaYax9ax+GlIvNqal3y4CJsHVq6yrt2xklBKvVYI+5cocYPeZBGn4MyM0HsO+3a9B9Gt4lzM/kfdj654ndA+9xSIHLIeMkVyWRXhwsnayd4OoouT1Yhs36M4jTPqIAnrUDJ14nqW/OGbrRa4tCdgCL/ti40Q07kv5ySObnpY/dqYFUsl9ZtC47zOszR+yGRnz8sZx6iDcJtQvpv88kmu5eTBcpYaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh4jgi5nN4ltz17LRzC3ZLv+KNqbJObFUqKszVQhzfU=;
 b=Scfc7Y0ItF0I9ky4lGlQnUphQWWSGqha/ZyeSJB2W72BgCs2f3qbFILmPm+IuZmsZMW5PBtMqHq2eOMhzAx8vcoAy3engn4MSq0FtS+1mMHDKOdo/C1tNQD0RRdM6mXA2JFV0eRapocpUlwiRSD/1fSK/I1DejGY36QEO7rkNrTjMdpHahy3gzS3R4wE8PBeJt6S4Un9yF9lfp8EQAhEGySWTed/86Wn7I//tkSfUvCzA8g6FgWeU2zyDhRI0Ly13HvtX5T5CT3qyjan96zw1cdcFm4Rv8Lue94KshhLEv0gmrpUs9iPNVfLr8nEktAHKuYjkAuXVqoxd0+3BUK6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh4jgi5nN4ltz17LRzC3ZLv+KNqbJObFUqKszVQhzfU=;
 b=lFnRakuq/b6r4TJggBZwxz5PqVd/6uGuuCK3ix//DGG6L+ih7iDWRY23Wxv1wV7pVjR5ax5oo0Ye4Eo0LEhbQrOlouNKuzBW3Y0ugVkBv+E3+Aq8sagf6b99kagozC1pioYh4I4qEnn1KdHcj/90GGSAeag7vw/tban3T4ke11g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Wed, 11 Dec 2024 13:07:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 13:07:06 +0000
Message-ID: <19650136-351e-4c37-bcd2-7d47ac2ea4d4@amd.com>
Date: Wed, 11 Dec 2024 18:37:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/48] drm/amdgpu/vcn: make powergating status per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241210225337.75394-1-alexander.deucher@amd.com>
 <20241210225337.75394-10-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241210225337.75394-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7627c2b2-8d5f-43af-ef5d-08dd19e4b65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clg1eXV5K1E2b3hCdGN2UEw3NlNWUTZQVDJibXVicll3dUJybDZMaXd1VmFZ?=
 =?utf-8?B?OFpQTkJLNjUyTFZJQkp3NklPYWNUL0puODR4eEY1NlNvUHY5Z2RWZC9NeXRo?=
 =?utf-8?B?anl0cEF3NUZLSktYNU9FSExxd3BiWnBkb1dZYVpmU0NtVnJUUzBJWHVZakU3?=
 =?utf-8?B?TCt6Zm1nOFZlT011R0pIVHZ1LzNrMzc0aFdIcWNpdDV2dmVjSHB6VC9qQlB3?=
 =?utf-8?B?SlVFRk9CNE5uUmwyVS80TXM3bUpGNU11TDJCRXZRaDJsbFh0WDY2S2dwWlR1?=
 =?utf-8?B?Szc4RzZRV0FFWE02TjZ5eFNSTTUxK25aYkQwQnpwY2gwK2Q5djQ5ellSd3VL?=
 =?utf-8?B?aDRXWk05Y0xpb1RkVko5TFlseGxmOWpxYlJRVUhBMmhseXQ0REFkUmJpOG1a?=
 =?utf-8?B?UFdxdUp4L3UvQlZKamFEMEFpY1dtMnUwQWFoL1R4cDhDQTNmNEVTbjN2WWdk?=
 =?utf-8?B?TlFxNWVrWWhrZ1JMalRPNWViNTNQMThTdkdyVXlUMXBWZzdYeFpRN2hNWnRh?=
 =?utf-8?B?L3VkVzYySXFMc2JaT1ZCcDlTVTFtNzEvVEJEWWt6eGMxRzJ2RitwQitDTi83?=
 =?utf-8?B?dmVoM1pRL0oxMnlydXYyRysvamw4YllnYTZzOHQ0ZU56akpnUWdIbXFFMFlS?=
 =?utf-8?B?ZkNFUVkrMzllRFVtelBmVGc5ZzZOM0t3YzI3Kzc0RTlyVWR0ZnVjUHl3NUVN?=
 =?utf-8?B?WVE3Q3AzM0lJZFFnQW9lUE8yM0pvSFRPRmVBcVE5L2RYRUlNaEdYczJ6Q3FT?=
 =?utf-8?B?cUhjZmd2M1VqM3RLOTBNREI4NERMZG40T1VQZDdxWUxKbUJzUjg2NnpHcWtM?=
 =?utf-8?B?RytXSDNRT3ZBVjQxYk1SWXpuVkMwREExU3VOS3hCT3d2VkgzMWlrUm9kYUd5?=
 =?utf-8?B?dE15cHNzR0h3NVdobitNMVQyOUY2UVlrMUw1bjZPSW1taG1YQ2hLNE81RTRF?=
 =?utf-8?B?SDAvamRqSWl1NE5kRURKckZ0aHAxcFB4cTVvVWxnK21TQndzZEh6Rk0zUStk?=
 =?utf-8?B?eTdxWmNocTBNTlB2dktSMWdhWm1YOS9NcTEydTZPQjN4Wkg5bDJBaDFNOWcx?=
 =?utf-8?B?ZXc5UksxUlRIWjc5bm5mYW11UTdEZXNlVUsxa1ZMK0RCN2tvakNnWVlRRWM0?=
 =?utf-8?B?cFp0UE9PeFBRQ3dUeGY0Z0ZCYTZSRFVmMjZYV0FYTytIaEdSUEl3R3pNNTJV?=
 =?utf-8?B?M2MyUWNTeUUwa2FFbmw1OUZvQ3dqTVcvRnI0eC9vU2xhanlCRmR4TStQM2Jk?=
 =?utf-8?B?SWdjaGNCelFqaytwSjE5T1pzYThiVUV5WHMzWmMrZElNTUJSWlZJK0YrUlJt?=
 =?utf-8?B?ZDlTSlpXdmFBTkEvc2dSK0QwWWJrQkkvU0FlM2poUThNMkpoMGtpSmphL1dx?=
 =?utf-8?B?dExnUm9PYnZQMWExTSt5RzNBVGNBZERoY2NYMDNUSThhdlRYWnZ3UE5JSE1E?=
 =?utf-8?B?MUhDeStOVVBWaW5MRTljVHA5S3BGcXA2bFlxTkxybWU2YzR6NHNPTVVocUZT?=
 =?utf-8?B?Q0ptVjROcmdJMndvcUJLdEVtMjFzRThxMjlRNnQxQ21kU1BRRW5RNDhWZktP?=
 =?utf-8?B?b3EwNlBxUVNHcGhXZ2ZiNHFFZk04Q01CUUJuUmlBa0hOVFNGNWwrWWdXNHZK?=
 =?utf-8?B?VEpBSkhET1VjZE9rdFRSSUw5enBjVlV5ZkNrMEdCaWRxOTlXaHNRVG5iWkdC?=
 =?utf-8?B?MkhqZFkyMVB2RjhxM3BkQXI4bTNDbWJvU05Dam1NSFhQZ0tWaE4vSGlydkQ0?=
 =?utf-8?B?c2ZHZWxXYmRXZTl5bE1zNGRIWURqWVRrNUtLUkJ6YkpaUXVIUWlNTXhLZjF3?=
 =?utf-8?B?Wk1iTURGR0lRa0psaC9Vdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJZVHdsTDNLOHNwTjRFN1N2VjJva1RXOGM4WWR1aGxvemVtOHIwWmRhc0Fu?=
 =?utf-8?B?UHpnaVUzRnU4NFE2dldWRW9jUVViU2daa2ZTRWVwRml0eGp3NlZkbytjTnNo?=
 =?utf-8?B?QytSVFZqaWhzVDNzeGtZa0NpUzZmU3BSbUVPTldDOWJhNitwcS9aNExpRUd3?=
 =?utf-8?B?b25FbXZyWkoxNzBiSm1JYXN3ZEFodzlKNjYzRWpiK3NraTRxcjI3Ky9RUzM0?=
 =?utf-8?B?bEV3VGZtWTdWQlFFcyt0U3RkTlBKNnB4VkQxMlkvd2IxVVJsYmYxVWFkbjFU?=
 =?utf-8?B?U1VvZEhtUkFGQXpReEpoSStjK2tuOWNvT3JZVUxCZWp5Nm1yaGZWTjcwWDBr?=
 =?utf-8?B?TGZzdmszNjJQajVnanFVVk5qVFd3V0YrajJNUDJPUWpGaXE1U1BCVTljcmV1?=
 =?utf-8?B?YW0yaUxCTEh0UXc1REJwNXdEQlczZUJyREY5SkQzZkEzdW5oRnFHUFlIN2hY?=
 =?utf-8?B?cFFmeXRsMkhDZ2hldC8zVkoxUVpUUDM2MFNYWllXOTQ1aTkwMVh3QWVpcGZk?=
 =?utf-8?B?MEluMStmc3JQd1ZidWkwanFwT1Vzc0I3NVFxMnFCOEllZ3RRUERDVjhBcDVC?=
 =?utf-8?B?b3BSOE1YWjVtVjV4bmVpS1RGVE9FNEdFU1NkbmhjMXVoT013WklHbDJuWnhs?=
 =?utf-8?B?dm1wUlBydDlGVDI3VldZZ2pvbXdiOTM2eW9hNzlyMXk1MnhFUGlqZVJpcjBn?=
 =?utf-8?B?U2cyb2ZLL1BOT3RoWTBGbjJaSDZOemxjNXNoZmdLVC9mNjhtTjcwL0ZKR1NJ?=
 =?utf-8?B?eTFTc2tsemtlOWpvbG95SnNBRk5qa0xqUzZqaWIzL21ERS9BcU9TWHhPOTZv?=
 =?utf-8?B?UWlqZWFabGNCZ084WVRlZ3Y2RGllQk1adnd5c3RsZUpQNkZQbWQ0MStMZEpa?=
 =?utf-8?B?MGsraFpmWTViaC9sdkYvUjZQUkhPOWlJeWJ2YnFXVDhhMGdNNVlqbVJPQ1Ex?=
 =?utf-8?B?YzA2bGl0MnJ0aUlpSGpxYkh4Z0pqclJjY2tBRjc5ZTdNYjhidlEvY1VQYWtL?=
 =?utf-8?B?ZmhKZlRCSnJtSkEvMUNPMWI3S3V3a2VqQnZTYnNVODJGRkVzaU5QZGIyTDd1?=
 =?utf-8?B?Y1VhTmF2ZktxVUFjTUp4ZU9wR0tUWExTM3FvbklKV3RxSXRTQmxTNTY4U1ZI?=
 =?utf-8?B?S3B5ellFd0lvdnRDNVRuVWs2Y0lsbHBhY1VFeFI3WVpUWmFFM0dLYXZYT3ds?=
 =?utf-8?B?RVFsQThCSDhudlEwVFVFNE9HWW1NTkdNRE1Sazk5YjZEdFZwZ3NIVnJQRE5J?=
 =?utf-8?B?UkxpZFErMWFuS3Z5VE1iVkw5cERKWDJJaXUzeGYwYVVpcEVJV2xTaWYzMEtl?=
 =?utf-8?B?VUdaMjAxckZnakdtL3EramhodzVWKzlHVyt0c08xSmtkTjg1MkN3ajBoUFJY?=
 =?utf-8?B?ZmtiYzZhM0JOSHJZM2NUSU8veVpyWFdlcnpuVXlCR2lHdmQ1Vk0zYTNiS015?=
 =?utf-8?B?LzhYYXd6RlduK25oYnZhTnFGeWpQdEJwQ2FoMWpkTTdhZ2dYaTJnRHFqMklw?=
 =?utf-8?B?Kzg4TnF3UHhkRkQrTVROQzF2aVJVeHhmTUI1VjluVlZFUGU1WFlmS3dsUHE2?=
 =?utf-8?B?WEtmbmhDbG1TLzE3bjhvMGhIT1lXUCtNdE1hazBDdlB5TVd2Tm1GbHZCR0lW?=
 =?utf-8?B?R1NLZnRlMHkrbjg3eDFLajNXUzU2U09uSjFnL0hUS3ZBZEpVUU5BNGMwNTB3?=
 =?utf-8?B?K0hYTXhSOUF1Skc1ODRHeFM0SmZodFQ0bnpJN2hLdDQrRG9VS3Z5YkZBQ0xZ?=
 =?utf-8?B?Y01DSTIyalRGaWM1SDkvZFo0TFhtc2xJMVhFVkRIUTRqZE80eHZjbnJKSnNT?=
 =?utf-8?B?Q3pua0hCYmluTG52U2RzRndTYW82anVxZjRwV0ZXNjFwYVBnZlJpbTFnbDgr?=
 =?utf-8?B?MjBDRU5PU043Y0k1Z3JRbDlXaVJlVjZrYW04Z051V0w1RmVVWXRKNTJFaFA2?=
 =?utf-8?B?YWxrckVnWFVTaFJtSGNQRGdud0tuUElqT05GMUdLUS9NWHZLcGhETVNiTXpI?=
 =?utf-8?B?NWlrYzJjZHd5enppTS9qU2xXc3hya3FKUGR6aVBaSkp1S0dHeDRKWkpZRFAx?=
 =?utf-8?B?aUFvZW04dU00K2l3QlJTNG9DczJxbEp3N0FxcmVKcVduN1l6SEl1M05RZUs1?=
 =?utf-8?Q?c2gTQhYRCaxSfSZYd0PZBrae6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7627c2b2-8d5f-43af-ef5d-08dd19e4b65b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:07:06.3211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MxAOtst28g3mBsU1eaZDQU+u2sTWG+58JdC1b0krNXN8U6fg0fSMDLxMreb7gf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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



On 12/11/2024 4:22 AM, Alex Deucher wrote:
> Store it per instance so we can track it per instance.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   | 40 +++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
>  11 files changed, 241 insertions(+), 137 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d020e9044c595..b83136451d674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -314,6 +314,7 @@ struct amdgpu_vcn_inst {
>  	uint32_t		vcn_codec_disable_mask;
>  	atomic_t		total_submission_cnt;
>  	struct mutex		vcn_pg_lock;
> +	enum amd_powergating_state cur_state;
>  	struct delayed_work	idle_work;
>  };
>  
> @@ -324,7 +325,6 @@ struct amdgpu_vcn_ras {
>  struct amdgpu_vcn {
>  	unsigned		fw_version;
>  	unsigned		num_enc_rings;
> -	enum amd_powergating_state cur_state;
>  	bool			indirect_sram;
>  
>  	uint8_t	num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 9ca964e115409..406886f13566a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		(adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
>  		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>  		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>  	}
> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	int ret;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst->cur_state)

Same comment as patch 8 - &adev->vcn.inst[0], here and at other places
below.

Thanks,
Lijo

>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> @@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		ret = vcn_v1_0_start(adev);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst->cur_state = state;
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 115f33c3ab68b..f445ae4013598 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
> +	    (adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
> +	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>  		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>  
>  	return 0;
> @@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	struct amdgpu_device *adev = ip_block->adev;
>  
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst->cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst->cur_state)
>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> @@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		ret = vcn_v2_0_start(adev);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst->cur_state = state;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 6fb08ed093101..1d3780a2d8513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
>  static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -				enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>  				int inst_idx, struct dpg_pause_state *new_state);
>  static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
> @@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> -			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  
>  		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>  			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> @@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v2_5_stop(adev, i);
> -		else
> -			ret |= vcn_v2_5_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v2_5_stop(adev, i);
> +	else
> +		ret = vcn_v2_5_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
> +							   state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 70a1b85a4efae..13b9ed96cccda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -			enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>  			int inst_idx, struct dpg_pause_state *new_state);
>  
> @@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> -				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				vcn_v3_0_set_powergating_state_inst(ip_block,
> +								    AMD_PG_STATE_GATE,
> +								    i);
>  			}
>  		}
>  	}
> @@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v3_0_stop(adev, i);
> -		else
> -			ret |= vcn_v3_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v3_0_stop(adev, i);
> +	else
> +		ret = vcn_v3_0_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
> +							   state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4a846c9a2b039..dbbeeffc90726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -        enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
>          int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>  				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -2032,41 +2035,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -/**
> - * vcn_v4_0_set_powergating_state - set VCN block powergating state
> - *
> - * @ip_block: amdgpu_ip_block pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_set_powergating_state - set VCN block powergating state
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index fb454c4687db7..1a939fdcc8fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -347,11 +350,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
> -	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
> -		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
> +			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
> +	}
>  
>  	return 0;
>  }
> @@ -1640,41 +1644,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -/**
> - * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> - *
> - * @ip_block: amdgpu_ip_block pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_3_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_3_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_3_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_3_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					    enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index e784f1457ee0a..f6b347fcdb7ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  
>  static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  	}
> @@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_5_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_5_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>  /**
>   * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
>   *
> @@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   * Set VCN block powergating state
>   */
>  static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0, i;
>  
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_5_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_5_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 03c7252e28ba9..c5d59edf3a482 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  
>  static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -288,9 +291,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  	}
> @@ -1260,6 +1263,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v5_0_0_stop(adev, i);
> +	else
> +		ret = vcn_v5_0_0_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>  /**
>   * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
>   *
> @@ -1269,23 +1293,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   * Set VCN block powergating state
>   */
>  static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0, i;
>  
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v5_0_0_stop(adev, i);
> -		else
> -			ret |= vcn_v5_0_0_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 582e1383fe634..259f2fdef8aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -40,8 +40,11 @@
>  
>  static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
>  
>  /**
> @@ -998,6 +1001,27 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> +static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v5_0_1_stop(adev, i);
> +	else
> +		ret = vcn_v5_0_1_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>  /**
>   * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
>   *
> @@ -1012,18 +1036,8 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0, i;
>  
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret = vcn_v5_0_1_stop(adev, i);
> -		else
> -			ret = vcn_v5_0_1_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff2..e5dd0bb31c386 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2051,15 +2051,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>  	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  		smu_dpm_set_vcn_enable(smu, false, i);
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
> +	}
>  	smu_dpm_set_jpeg_enable(smu, false);
> +	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>  	smu_dpm_set_vpe_enable(smu, false);
>  	smu_dpm_set_umsch_mm_enable(smu, false);
>  
> -	adev->vcn.cur_state = AMD_PG_STATE_GATE;
> -	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
> -
>  	if (!smu->pm_enabled)
>  		return 0;
>  

