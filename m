Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B57C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 05:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851C210E118;
	Tue,  2 Jan 2024 05:50:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C9510E118
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 05:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7ZI8uu4t76vpMGru/Yj4BvDdoo4xgREpv3HstzYZZwgwTBHOWdoGiPVhhaVmKILa57CqEwjrrVAYHL+Axyo4lKDlYNnls4ZUVH906ozvV2k1cHGpUTSnoBvOyyz6+gaL1UP3kfVC6Wj0PsuQM3uYewkhqsmjgGYznKuqq4bbGBjYuUAGzmVXyMtE/rJAcldYLZCmOkoNrejPT+HR9cjG5XNtr+XEQrhwHArOlp0gCtr4XM2+tItw8T0avVqdZJOET9NdD1pyN//9rLPobR08YM/TpNOxTXVNMx01BUTU2Jir2cpz4kYhT+y1q6q4UlWznede0OqFdBdnp9xE8LJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQE9VKYZhydj/9eoMnIlGLoXKhhmkIT8yhID6MYHAAQ=;
 b=DJRs70a3qFtgRAZuiFyZ7FvpPJ43zfmxVTSLKcsMzGev4FcyEenIyh47utS4ObTZfPSuIe4j0GKMN+jyUwU0Xx/3KyLzWwDqdV8zU7MQIAEU4a40FNhB+AsSH9gMBxYbICJgbFteXUMia1KgIM6233di3N8ICdokGecqs4ndgrPStcChI8M0T7cKPxPXRq8plyu4tuALHXmNCnUru/5e417+Y1tcfayEEMXU+MZi4PvHoGEzSSque4KugapRvc0uSrDT6wCoIg0SIbW40Cspb7ukaq/jcQ/7+nVBBvmEOd7CYo33DConI7nlv1bslU8GuTaT17HRnqkJu+wO5nmdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQE9VKYZhydj/9eoMnIlGLoXKhhmkIT8yhID6MYHAAQ=;
 b=clgr70GdtfZyQuKKx+t0RB+/07Dx1Jr0DWM/5mtCe/EcvecPyXeOGBY8dOoDG1YO9SvuB3eMfIBqhaEW/BMNYI+DTjrclZn9iuqZ7XvZ9YkWXWDYBDbqipeEwR60WaOzMSk0CMIJzCf0dvw/KSeroF1roPQtq7pPdz2dWIqloHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 05:50:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f30a:6bac:245b:4219]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f30a:6bac:245b:4219%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:50:40 +0000
Message-ID: <46e5065c-8b9b-41b3-891e-386c5dd1cd8f@amd.com>
Date: Tue, 2 Jan 2024 11:20:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add mem_busy_percent for GCv9.4.3 apu
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231222172238.412001-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231222172238.412001-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fae08a1-82de-45d1-dab5-08dc0b56c016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81+y/n/N3Xj7PWeLRI9b1/T1+2Zr+Iky1ahoRHEcUPyoBXbB8w3pEYokZ2p9eDjABiGdTXS1jGofZcROQ3HCtCn+Qy1CTNJDk42n0nOxvQwJn3ehe3R8bd7NnJ+2ZvpHc+1e7bolzbWrQmsMW7V8JhceNqpT8GtCvzbHjVLbxzZwoMA6e/K/S9ekrlak559WufobazWiuwLj8sK0vXzDhuVE7GyJM5ij0Vccl8VSxdeEn452AH7r3cYYJgBZhZB6cHSt6XHKGgDdPiBqIHzKPRnGX4wEmg02O3bRX3X+6phyNVQORSAeWFlV//TWGveFKbLdzA1M/TEn5ytN3PsxfrctvPiZwKmrkPK4KnpwYQJht0rM+sZ99bxorFsKvDBOIoF5UfxInwXQYw923XT69ab7WdJybUFCFXbuMPNyhfAKsF6CTbgzeD6VBGYC1PNA+IRVAKkgwE12GVSQh4lf3cu1id8rqXo4ZGbdUOYh7RLdahkDZd0vzg4ln8ATmQSWlg8gxTBZc7LAJcWx966eKQGlJXAeswaop3OeiWejqIcJftZd3ty7hCoJnWz9uWz3RFd65ljmbW2LuhI4xGzNQLCFI0k7+Vjg4nr25l8sSryzTMOOoAZ+EuqGK2bv0PmjH90AZIMo3mhZHUzBgP5iHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(2616005)(6512007)(6506007)(53546011)(478600001)(6666004)(6486002)(41300700001)(316002)(4326008)(66556008)(66476007)(66946007)(36756003)(8936002)(8676002)(31696002)(31686004)(86362001)(38100700002)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENvZm5LOWN5SDROSElvbThMclE0RFkzQ05vRkZxZlpsT2tQSnJ5QnZiRHEx?=
 =?utf-8?B?UzlabFBYbVVFYmVveUtxRzk3dCtka2VUeXdWL25TZm4rU2h3L1lQc3RVNWlH?=
 =?utf-8?B?YkpUS0VLMDFxQytET0xBM2RFS3FRa2tQN2NEc1VSRkpOSVlzTUtxOEM4K0h3?=
 =?utf-8?B?azNPWEJMVlMrMjc5WGxjY2t2VlY3bTFWYlNaUUJrUVRrSHp0bVorUVYyWDND?=
 =?utf-8?B?T3V2WmtySkp4OXgvcndTNVpOSEVtS1RWMlJXTWlaTnR5ekJSeTJLOTVONUtn?=
 =?utf-8?B?Mlp1Y3N2dFQwb1ZHb0FVMCsvcXlLRm12enJjMGRZZjNpQ204dWh0dkoybmtR?=
 =?utf-8?B?YjlvZzV3eVBCUTlZVG1pdm12cUVXVmJ1YVhhN2V2OWdYS010RUt4aWJqeldY?=
 =?utf-8?B?Y2R3azdRMGRYb2NJWVpRTmxpR29reCtlYVBPWlZZelg4RFBKUFp4d1BsT2Fi?=
 =?utf-8?B?akNMWGppb1BsYjYvNzJSeUpranp2ekRWOGFrd0VYMTBTOWMzRGRYVEo2a3lM?=
 =?utf-8?B?Q052NlMwTjN2SFJGd0ErSHdML3lMdlNrRTRBY0pNZVN6YlhTRWZ1LzdxbXJh?=
 =?utf-8?B?WEZlR3VxN2RlcitjTjI0MkRjWUhiTis2R3FubFQ3M0Irdlhlb1Uzb3ZjMTdm?=
 =?utf-8?B?OWRPMnNEMXdTNEhWeHN1cStVQUV2eVlYclYrSjhuSHF1L0dQa0lZbW5wZFUx?=
 =?utf-8?B?TE0rVVQyWUk2c21wb0pVbk5lamo2L2lKV1JDVmQ0bDVOdnFRSzYxaDZpdkp5?=
 =?utf-8?B?NTFYK3JWTFd2clU0WWpVejdlcE84a3pkNUhPRzZVb1Y4dUpZRlE3N2JMd1ZG?=
 =?utf-8?B?MkVNOWFHNUh5OWdvcE9kdDlFekpEdS9hOFZlbEVKK0xpamc5VzZlSjZ4a2F1?=
 =?utf-8?B?cm0wNGRpcUpIbUNMT0UrdU9GbENkd2QvQ0R5SS9yeGpNRE5UMXBNTzNINWdh?=
 =?utf-8?B?UWVlSjhENHVSc2ROeVFqRVBKbWRZV1FMSUVVVHpQZTlIQTBEbWtxTndtUkxS?=
 =?utf-8?B?eEQ5Y1o5Q1RHU1JPTitPRzgvN1JTUG9xRSt6d0NBS0o5TndYV2dqeFBic1Vo?=
 =?utf-8?B?VzZaVDZBbHByR1FjSkRNSDlsTms0ODlJaDVPNmloZGw3b2RwUkhPS3JIb3pm?=
 =?utf-8?B?UmdxNjNCcE45T3lRWFUvOUp6Y2ViOGI4N28vcnBHTHlQdk50ZXdwUUVVSVdv?=
 =?utf-8?B?c3g2Wit2ZG82YzBzNVVUYndHUFNXa2x2Q0VvOGNpVmV1ZEM4RTVQS1NMNmJM?=
 =?utf-8?B?cWY3OG1BU2FBSVR6SGM5YjQ3QVpCeEg5dktHS2lhYWRLTmIydG9PQUdmWTBj?=
 =?utf-8?B?a2VoUUZibGg0U3crMk8xc3VZcFhMQUU0ZVU1bkxlR2t0cy9lSFlXcEE1bzhi?=
 =?utf-8?B?ZTRjR1o2WUhvWHlDcE1CZjlPT2NDUkJIeVRqWHlvc0lGZmtFWnZreG8wMklO?=
 =?utf-8?B?UzFJM1JaME1VNU1mR3h2cXU4Rm9aTDFNQXo5dTN6TWJaY1NQZk9DVkhIb3Qr?=
 =?utf-8?B?R3ZwdE9LSlQ5YXVmRG5GM2N2V2RrMVRSMWRRQnZhOGZXYUJiSFlzbFMzWGdO?=
 =?utf-8?B?d1NxaHNNNE5sNHBNVHZ3U3ZETzNPcExZU1p0TUZKTU9oaW4ybjVWSmlKeWtW?=
 =?utf-8?B?elZBN2grcFBMMHRGZmVMelRiNzVieVVpcUxyVFB3d2svM1MxNGRYM1pFZ0tL?=
 =?utf-8?B?b2ppRGZUdHdTd09PL014SmRCbmh5R3hyazJyZGhxQ2pNTXB1ZWJzb2tyL3VR?=
 =?utf-8?B?cmJSOEgvV3QxbUNucWg0eEgxSmNCRkpDZmdKRWFBRGlTTDIwWlJKZUhZWVFq?=
 =?utf-8?B?OWsrQUtvazhhZnVtTEZuYmkxaWNUR1JwZWordzQ2L2F6bTlvQ082UXZPV2ZE?=
 =?utf-8?B?RERsR29hK2dPUkV0aTVGVlZMTUowSlVZbUMveTE3Vy9qd1lHNldvRzJGeEJ0?=
 =?utf-8?B?RlZ6SDNVQjZla1h4OTQ0dUJSVmVqb3dLcWpEM3dpenFBcHFiNmMvcmZyVGNi?=
 =?utf-8?B?Z09vSGFaQVNKSHA2K2pSdXBEeWZaYlBIcXJWU0RZNnBSNmdsMlE4MmhVbXJt?=
 =?utf-8?B?TUMzcVE5UkNMb0M2MU0yZksrUjlIc2I3aFZ4dEFiZkM1MktjUGZBNm1jMGJa?=
 =?utf-8?Q?vjVrirK+uOjAQ2+G3yhtdhpyg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fae08a1-82de-45d1-dab5-08dc0b56c016
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 05:50:40.1288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGTKnfswygPJaHGYcHJbp4UKpLt/LrltJ4gvnoMvdD8Ezr/AxtbocIPnh9M6p5rj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/22/2023 10:52 PM, Asad Kamal wrote:
> Expose sysfs entry mem_busy_percent for GC version
> 9.4.3 APU system
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 2cd995b0ceba..f3cb490fe79b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2168,7 +2168,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		if (amdgpu_dpm_is_overdrive_supported(adev))
>   			*states = ATTR_STATE_SUPPORTED;
>   	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
> -		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
> +		if ((adev->flags & AMD_IS_APU &&
> +		     gc_ver != IP_VERSION(9, 4, 3)) ||
> +		    gc_ver == IP_VERSION(9, 0, 1))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>   		/* PCIe Perf counters won't work on APU nodes */

