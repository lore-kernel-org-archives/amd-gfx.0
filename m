Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BEBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 19:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B9210EAF9;
	Fri, 11 Feb 2022 19:00:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFAD10EAF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 19:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQDI2LhUXpqu8IiKW3JUXwZjwVaSv02+PYg1H1MzCmFVEF7Ziyi9bPJLqJUVGUt+SpxXCm8shHnUjwLS2i9KcCaagyStLYSVWgjv2fnYB49xfWkmTnWIxUHC8V+ZVlNincrOMt/+RlbYkajxkqvI3Mr9KNMvmu0N/BEieAZd6SutEbPE4LOgG4UAPKutGAy6Gy8Tu6jAm7ULi2wlIjP8Xh6TdV+zRwqhzj+SXiUZ47HWXGzIAAW5UMXnp44poDzvaItVxUpbzjEq1FY7uBlp7yN/T1z2nMrjrur3i/G7uvOMSSltfds89yZoWU0I8dRhXA2Fm3R8aMbLD1hf71jaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPs2h6XgYiBNzsGNDPF2JvTYD2p+PYTKtuhP8TNoYDY=;
 b=fe/bzHwtH9i0r+KJoaaTXTAGuhBET2NDHQ9dqeYkprqLvNbg3hosoT832JQ5V58PYTveIkD5gNYCGXC3XO9jPDxvHxcfO8q52vEpq7Kc6454IEnqiwqrm5SzmoSzUDxE5IZMRnMQNxx2qvLwnPnQtV2jg1341tjRqd9DBO7KoP3zvgWqX+ePn2b0g3886XS0Nv77wE6lrkt6TY3pC+TItu4dwHLUhjcypDJxor2caP3b6bjLm6wWdBD1vX2AK687VpnuyfBRcp1wNExHoMC3tWTOkI87erZZVQ6tM6Id1y56Ww0q66m/JEsQ5dXhQZaUCyDfrwMx1vYMswmh9EgEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPs2h6XgYiBNzsGNDPF2JvTYD2p+PYTKtuhP8TNoYDY=;
 b=rQRDzPl7cuas1VAdrqSSl//n3bb0LQOirrEJB595BHHyyMMzo9bzUSc4zGv4jRpcW9C4okHBywTjaGgSf4trkxIhJE6eljk+Z84NLTKKbLNSKRzyxHBjcRNbCJz074OTlGbHBsuhIqzT2FcSilEzcadSvdXUGPOXX7v3rQejo/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 19:00:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 19:00:50 +0000
Message-ID: <ccb9663d-ff66-d5ac-c7ba-923ffc7e8eb9@amd.com>
Date: Fri, 11 Feb 2022 14:00:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdkfd: navi2x requires extended engines to map
 and unmap sdma queues
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211171529.923453-1-jonathan.kim@amd.com>
 <20220211171529.923453-2-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211171529.923453-2-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f14a2e-b12a-4f9f-f97c-08d9ed90d1ba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2624:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26243E211CB51625C1042AB992309@SN6PR12MB2624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OrMhmeuDRavjC1kruUocj1wn/ualfKK/Jj+bzHvbIZQKk+PnHXEjofTYBLZXk17Snn0UdgXZFlTZTRJAihbhBDZ6VcNaA/ZICxISHwz5g6zFSdghNZvFAiOLcGAyhUn+y++q2mxPBgnvFwDan5qeyykocLJpce7v6imW8/HG7jTyBJNWyyszPl7RSgQlY4+0DLVrha6TeZAbVQIeL+I7sFUH9xFJaYrgSJfsLOoPZRyfsMSf0Da1c4GOyUTIJ+R6oAJmitG6YVadj7Og1zHofjUvL1wnjC9x9Yv7Rr+B/yusZzce5nZYzucjNOyfNtOmwD4pt3iHI2UN05huXOol594PTmTYwKacz/qYbqiRweENZROw+UMQLW+ciIQv32QbdBCh7VzZc0KylQcW79Mv5lGRTW+IUvWEVf6EmhRFljUdYYTSuHvosF2TbK/TFMe3AtJxm5jRMnb9dcj2SJQFBZOZPP8MRnyKdvioDW9QvfX39+cQVIKzCtkIN1r/oXn/OBwDX4TNer0KLEv5C6yWxK3ecNwRUie0aa/1zcspzeHhXfZzu2DDXBLXJ5MQCZWDfl+9hHvrn/Lzetp5S/23u8yJ8a7TwdYFCnSifg4LER2dwF9gFRNsg26h3LdUlBQ1o8OLkvXkEW0FC4oL7vmTSw2NPsqGNXskKQD8k7QyRVwTAT3pi4XgNz+vWd3yXenTqq4+/2Mg5TzcbJ9Sz2i1viydrcbGpSKgwrJxf7KIkOIuebU33719ZbzSzvEJ2vdD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(186003)(38100700002)(26005)(36756003)(2616005)(316002)(5660300002)(2906002)(6506007)(6512007)(83380400001)(44832011)(66946007)(6486002)(31686004)(8936002)(66556008)(8676002)(66476007)(508600001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5DeXRtcExrY2xhN0dzOGEwbVlIWllXQnJ6TVlpd1BPWENJV3NwWjR1TC9R?=
 =?utf-8?B?dHBWdlM5bmhVT0Q3VGlISjc0YjREajZLRzZza3RML1prNmlXWGlDUXFUVzdk?=
 =?utf-8?B?MzE1ZkdOTkozek9nd29iYU1oa3VFRlFZOUI1YVhpRnhiazBjV2swOXRWQmpN?=
 =?utf-8?B?ak5YQVJBUFVzYVJNbFVBMmhGaklVekhPV3VFMVdpWU13cVlESDU1enhCbXpJ?=
 =?utf-8?B?TkFHNGVZUjNmeDNYbEtuU2VXV1FBOWk5RkxlMzBLdlRIMk1tb3IybzBNMzBR?=
 =?utf-8?B?S2V3cWZSZFM5ZFZhRVQ1MkdKYXQ3OEhxUG1ySTBpRVZnWlRmYktGekNpVTQ3?=
 =?utf-8?B?QjlrbW9qR2hCd2ExelJzbmNIdVoyUTRWUjMrZnExN1ZYMlJ5Z3FyNkJRTHZN?=
 =?utf-8?B?Uys4TnVSc3hNaHNwK2lRWDJKdmh5dmZreFVHTTFKMjFtczkxSUJkQytXOWRx?=
 =?utf-8?B?S0pzWkRqR0NkMnRtTUtXWG0zOWV5TEtleCt5dzB6OXJCeGF6bll1Zk90dE5Q?=
 =?utf-8?B?VkhZWDJEUmtuTjQ5eUVLZno3Z3EzbWwrejdITVhtQTQ4Q2xYT0RJOTRhbmJZ?=
 =?utf-8?B?b0tDZldPc21oMTFJNXRSL3poVFZOeVpQcngrRjVrcGxNYkxqd1YwQUtNTzkv?=
 =?utf-8?B?TlZhbjQycWJ0S0NsYW16a055VlBzVVMrVWg2TEpVdk5ENjBPeURnK25yU09F?=
 =?utf-8?B?eE1kbERJZ0l0Tk1sSzVRS1JueDF3SGxGN1drbWRyamZsYjJ1eHk4SktLQmRo?=
 =?utf-8?B?TUdYQmdRUGRMcEpQKzcraExIMzhrTUJsNmJHSUVBVE9JRERXN3lKTVFzajA1?=
 =?utf-8?B?RWVWUkhCTndXdGgzbjg4WnFGUlRuRW5PRUFmOTd6bzN1cU1vRFhrdy8zTTR3?=
 =?utf-8?B?akFoS3AvRi9jRjQ4SFZIMVowWXRRdW1HSTJRMHZjUE5GUkFFZTVVK0pnSzNZ?=
 =?utf-8?B?STAwNEJzcUdqWW1LNS9kSXllWTJlUC91NmlUMEFoRWpBVWZ5Y3BBNGVhV00z?=
 =?utf-8?B?bFRZN2l4dmZ5ZStvK05DRFlTTUVXSTljZ1pFclNiUzdUSUF5bVd0STlIWXRs?=
 =?utf-8?B?ZlRveFIxOFJKRGx3SkRwSFg2QmpTbUNaK05qYUN0OVU1Uk90Wnh2ZjVnQzRx?=
 =?utf-8?B?d3Q2NVRPRGc2QU03Y1c4TExZNWN3QnRPMXVWTjRkckkrbDJBMWNpWnNKV3Vv?=
 =?utf-8?B?RmtYTkRWS3Ewd2lNOTlDRXhvYlQzV1JrK2dOUHM5a29VcDg2NVozQjQwRWNK?=
 =?utf-8?B?MXdWNEFILytnOGZhUEhIZGdpajQ0RzdkRlpEYVB2UkFGNk50TG8ranlCS0hT?=
 =?utf-8?B?ZlhiSTJjN085dkxMZUFVSERNRVFXNTdhUCtyVUVxcElPakNDaDN1aFNGa1pK?=
 =?utf-8?B?WUpPdlJpZU1pY2ZxMmFNa20xb09ZcnZOcEdaT053ZjdjQXFSb3NmYnExbG04?=
 =?utf-8?B?QWdSM0VwMlMwR2lQZWRSQ0NnUjFCc1g2WFJ3MS8wSDE5QklCS3RUZThYdkRq?=
 =?utf-8?B?YjRnbXVJVW5TaDNaY1NJZnh2dUtwbG5IZmJ1OG1TQzZ6a0x1NmZIK2ljNTBN?=
 =?utf-8?B?VkhrRVRqV3VnUzBEbk9qbm55bkVJaWVSY292dGIyMW9mb0FCdlVjNUZFNDk0?=
 =?utf-8?B?Rk5BNjJWZGZQUkJFd0ZvcFVvcjNYY3duNXNxMXl2My9jUGFta0dLOEZkSkpv?=
 =?utf-8?B?dm93cUtSVW1ySHp2UkdFRXJpWHZndlNSU3c5bHNOdk9vQ3lFelJaZ2t4TlZi?=
 =?utf-8?B?UDlJWUUySHhabC95SVQ3dVVmYUpSWEJPb1U0MEZwQml6bEJVd1lxalphQ2M0?=
 =?utf-8?B?RXpYRWp0Y2NsaVN0OUJVMDBOMG1HL1YzV3pJWGlwWDB1NVhlM1pVcnBTcDYv?=
 =?utf-8?B?c3cvRVNHNVhRaEQyMng0YmpYeXoydnE1R0FWanB2aDA0cXlYcFpBOVgwMkJr?=
 =?utf-8?B?K0lNMjRsZE90bURxZjkwQjhweVFkWm5DWFVyRUtsanU5aExwanQxdDdPYmIr?=
 =?utf-8?B?Qm5WVWFkQ1ZUZW1ZUGlvUTA4U1RqMlc1WjRqOHpnQ3dMWlI3d3pabGVVNTZ6?=
 =?utf-8?B?YUpTRTBIOXFncmJ5cUtUUXFsaExidkpqL2NYOWZjNzlnWUh3a2xoWXNrSmZM?=
 =?utf-8?B?WlpxbkJ5cVk5VlZ2a0l1V2JUa28vc0syT21yL1VpUjRoM0tOMWpQYUx6TW83?=
 =?utf-8?Q?iWXQO/tZpcH5FEU8NNCOJaQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f14a2e-b12a-4f9f-f97c-08d9ed90d1ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:00:50.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQC3Pkg+fGp5+yIYt8lEiJ2Ftv85FtfQBfx+OXqKouOgqel6ITyGePWKm00MfKplt7TlC0LtupaAnPW8XHZ/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
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


Am 2022-02-11 um 12:15 schrieb Jonathan Kim:
> SDMA 5.2.x queues are required to be mapped and unmapped from the extended
> engines.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index ed4f2d3c6dcc..645d42af8849 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -183,6 +183,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   {
>   	struct pm4_mes_map_queues *packet;
>   	bool use_static = is_static;
> +	bool use_ext_eng = q->device->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);

I'd put this in a macro or helper function to avoid duplicating the 
condition in case we ever need to update it. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   
>   	packet = (struct pm4_mes_map_queues *)buffer;
>   	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
> @@ -214,7 +215,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		use_static = false; /* no static queues under SDMA */
> -		if (q->properties.sdma_engine_id < 2)
> +		if (q->properties.sdma_engine_id < 2 && !use_ext_eng)
>   			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>   				engine_sel__mes_map_queues__sdma0_vi;
>   		else {
> @@ -250,6 +251,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   			uint32_t filter_param, bool reset)
>   {
>   	struct pm4_mes_unmap_queues *packet;
> +	bool use_ext_eng = pm->dqm->dev->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);
>   
>   	packet = (struct pm4_mes_unmap_queues *)buffer;
>   	memset(buffer, 0, sizeof(struct pm4_mes_unmap_queues));
> @@ -257,8 +259,10 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
>   					sizeof(struct pm4_mes_unmap_queues));
>   
> -	packet->bitfields2.extended_engine_sel =
> +	packet->bitfields2.extended_engine_sel = use_ext_eng ?
> +		extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
>   		extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
> +
>   	packet->bitfields2.engine_sel =
>   		engine_sel__mes_unmap_queues__compute;
>   
