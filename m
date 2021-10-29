Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99AA610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E99AA610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A25D6E110;
	Fri, 29 Oct 2021 15:12:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CF96E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvDtlTvvkaQ0Wc08sqgsm5EMfqhZgfYTYTEnwH9K6mhLAGqLsydHmP1Aus85Xp9F5Eo0YFDxqHsXKZUzZGxHWdlIRq+5a36F1HE01hcPWBlFJbaBUCneoxQqVdljtzN5T6/qaWA7A+urSlt+8t4gWh9KtkYiMIz2VyKnsDrPbvYk8TAESjT6Zx7SpTPHxP2/0jYB96pGdXH93QCPvF7ZeUu03J8AOkQr4j0TVgfvwNWw3OvJ5n0KTLTMHKsVirMJQmVfFo0T8OlzS8dExPV+vF2VZdqu5tm8+HTqNimvB3TRZIceV5SdNI+/CgVJiMoxIYcYm9dFpi7K8RTz/AKkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3zO8fU9uLWfy2TN+AptKcMUHbera9NLsgdoSiQGd84=;
 b=gGzfwiNnczASDbw/Qwa2epvr4Z+gkbTL4UzM6aUX9+quWYVp+QrNM5oJ52ZkB/zm7V5fN7At0TnNWsQAHDjJfNbqqHqh9FFcIdse6fd7Yi20tGsLuHAlACo9Y5AVFHBhUEQJlXcrqBJTexa4SBvBsF3LS4hbwZ+vZEUwwVBxzFfhC5FosTGqL3KNiYrnW7iXkVC1jrC52HDntNaJzmS+6DK/6z1Z46hHWUIcCwIxIETBDgRuubRPveUFQXE7uECZ6t39TqujRzva4AnEmi6lTnhNFIOyrQGJXivMJSmMRVFmxo8NmuoI04MykanoyU8vvaxuy/tkcN4i/wrX6EyArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3zO8fU9uLWfy2TN+AptKcMUHbera9NLsgdoSiQGd84=;
 b=SOoiEy81sjQVKkeksg8Gih38GWIimfkmcf94UzWRa9m8mmWepks/tECAl/BOSp43o0VkvXmlYYrKp3qr9/bjVe5BklcKvdtPn4CGGe7lgKaxTe7fjBqLL9SB88cPRwQd5l7RbHXeVRXeUftEshZoa8GckK06MnfMkrfUoAMcVdI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:12:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:12:50 +0000
Message-ID: <3e29cfff-748c-76e0-1f76-1ca75945f6aa@amd.com>
Date: Fri, 29 Oct 2021 17:12:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] drm/amdgpu: remove unnecessary checks
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211022110311.128971-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <20211022110311.128971-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0023.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::28) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.122.116) by
 AS8PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:20b:311::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Fri, 29 Oct 2021 15:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e219bdc-23c9-400b-5ab2-08d99aee928c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-Microsoft-Antispam-PRVS: <DM4PR12MB519823C7151263896513A3FD8B879@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvxATjPwAxkEbP3auQ5c2w32lSc/c2XWxL10dEFzxbIPuGJzx7MQwx1KCWs5E14W8OAXjLyHsbu6rf/DEYpz3oD8q6o4txRNrGoQG68+VsXZXpvIoeFG5Ba9nBkr5LPKPOK2MNUe7/CehHsrm7OfdQX0gIipkwesL5I0ZNtDo01jBEFNqdBNC8jsOUFaixo7dO8qtx1zJK+WZrP+fCkRFdBhnxQdUdKwMPE081a0wwx9wbqNO4vv2LrFjE6Wb18I8bdOreAHjtyCp/ayI+5vxvLlaJjWc3c9wY7/3GjJ31qkXT+ps56MhUcTmFdHVtusD8DhLLDPEaMu9BL21mVXE2QI9uPwfyOX+ycsU9DOHe08lKhSY2x+FkIsILmVCXbSWmXSU/cJChG0q4zFoycwrQrQ4RB6HnZjuGYsI73e6PvzGmL/aHlqiuctICY8qiClDQG5oD7AQS1OJwOuZrEokePy/dOud3U3PtwdJCl2rS4io5AfHcwstaGvx/wPA80VSe9sPe/hB9WwrpFoIzkSPZEZB/GkzKSa9dnbRosI+f8CRq6hPvJe1HRcy/TybKaR8RhpoYKghOVR/aeoTBC2ZluPuNTAlIVd1m0Baao+lGCnjrpvzRimNDkgswMW3NG2+OHeo53nHdyLVHhGvm/o8osFeXVxglXksuFcnsscUh0rmgB0ikU3ZzqNz56T3IZBZYNcFQWdlV2bzN9bo3p1AHE7lpr9wnR+vaqL2RwQ6QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(508600001)(6916009)(31686004)(5660300002)(4744005)(2616005)(83380400001)(6666004)(8936002)(4326008)(186003)(66476007)(8676002)(16576012)(26005)(36756003)(66556008)(2906002)(316002)(66946007)(956004)(31696002)(6486002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dYbTIzQzRPYWFLcndyNi80WWJlQk93dXg3bWhTQUowMUZ3dVpGV0hGZkxQ?=
 =?utf-8?B?VDVWaHIvcW16NXNHNXZBWjVML29XZTdMMzNUdUNRVjZHZGU2ZDlCWnZQSkJh?=
 =?utf-8?B?RlNrVGNTclcwVlBFcnVvbEd2cFU2KzlvdlZBb0ZwWk5ZZ0IxWjRCdnJXK1c4?=
 =?utf-8?B?dEZGZDF2MWJqYlBzbDNJcGxRY1NuaGE2NWtkdWlua3dzUmkvalR5S0xJcVFG?=
 =?utf-8?B?ZXFJaHc2Nzc4bzh6OFQzK2YycFQ5T2tGUThLZlhmbzRlZlowTUFkMUVTY2Jn?=
 =?utf-8?B?SGU4Z1lTMDZVM0s3ZkxHYWdFaTg2TzZnYnNxRGhxUW1vNHhuQU9WSlMydTF1?=
 =?utf-8?B?elNpNGhhZ1ZoaEgvT1Z1dG85dm5ML2sxbTNiRGxaMWZWUk5pT29jRTJ2elV6?=
 =?utf-8?B?VllaeVM1YVBidjRaN2liazJVQmJHdS9kM3FxWllsS0RMcGlSR1RvMGN4bVRD?=
 =?utf-8?B?eXRFSWZLbEZNdEN0STFhcmN6eHRBZkU2cSt4a2diOEJ0bEJ0NDc1ejdMZ1lZ?=
 =?utf-8?B?UXZ4U3VKbUh3RHlwYlZjZ0ZqWnNFTUlSSUZQM2hoaDE5MllKbU1zU0pYblpv?=
 =?utf-8?B?MDQ0U1BXVDM1Z3cvUDQ4alE1akF5QWZXckEwSHhDbGRKUlNGTTJucVZGR0NK?=
 =?utf-8?B?NFg2YnMzS2Y4NWJrd2pwN3ZTSDAxYmE3WUpCdE5FUkJrV0tibmVQSkUyNGJr?=
 =?utf-8?B?aXFENGRRWDZ1Vkp1bS9KejY3VklrVFNaTEhHaGNoS3VZVTVhb2hLcU5hdGRO?=
 =?utf-8?B?S09YemtDKzJHUjg0QWpQWVZibWFYNTQ4bk1OWGxiZ29YeTVtU1YxUnlOeE9I?=
 =?utf-8?B?L0R5NHc3WTVyZEVIS0VsMU9PTURrSU1veGoyOTRpVlJuQWhTNmlQMnN3U1BR?=
 =?utf-8?B?Zy9QY2g4VHVzLzIwcTMyb0Jqd1BXTmxCYUpkYU5mMEsrYVRyK3N4WDdpcWJ2?=
 =?utf-8?B?Y3E0bVdiTHA1RXNaMFQwZGpzMXlxdW41L0ErRk9TQ01NUjBzZU1YZHhXSW5W?=
 =?utf-8?B?Q2xrRFJtakREVWRuNVNIUE8yenE2dHZ2V2dab3F0SzhTNHdnSWVoTlE1NHB4?=
 =?utf-8?B?MWlpWVFXMlJTbEJ3Z1pVWFFuK3RQaEx6K0RCZUNYcENzNjdOcFRKNk4weU5p?=
 =?utf-8?B?VEdad1dLZk9TWmJ5dGdaUzhkbVRyWDBqOGxCSjE2dkVuR0hrcWVHOGNGTGxv?=
 =?utf-8?B?VzNDZW00cUxxYlJ6cWNVQTlwSUVWZjEwQkNZQU1PTmxZVGVzWlZPemw4UzlY?=
 =?utf-8?B?Tmw0UDg0MlN2UVN5ZkhSSGVXTVA5eURVQTdwdmxOVm1oVkFKTk9Jem9YbzI3?=
 =?utf-8?B?VzBqSlNvNE5hMHZpeHRvaVZsN2swZWU1MCtaUTFPRko0RDJhU3JObTk0NWU4?=
 =?utf-8?B?WkQrR3dqMXhudURyWklwL21ZMWF1T0FsKzJnc1JNUFd3Z3lBb0c4WFNVVThm?=
 =?utf-8?B?amdBSm5EdmVxSGlsS0hleFEvanA3ZW9NUnYrTEtGN2lNNlQyRGFadS9KOXFF?=
 =?utf-8?B?NVZEZGltT29yWHhjVUlnMW9pV1VKQ2xkZno0ajdRRXVpTkdHNUdqNU9kZzQr?=
 =?utf-8?B?alhsaDA3T2FUdGwxUEVkZ0I4MFg4R3FoN3ExZjBXQksvNnRyNlMzaWNISFBm?=
 =?utf-8?B?REtwMGd3UFhYd21tRmlPWTlON2kyUnJBOStidm50NW1RWkkvTTk0YVlNYkpL?=
 =?utf-8?B?MCtWcFlpanc4dFpJMWowRnV4a3orTzZoMFBGRkljV3prYzVGNGU1djNaY0dk?=
 =?utf-8?B?ODEvOEV4S0VTOHVlQkxZSURCOFJ1THAyMk5pM0hSOEVIUU5pbGhQR3NPNGdE?=
 =?utf-8?B?NnRpQU0rajZXdDl0TmIrV2t3TVlPT0NHdytwdStjMXYvWHloUEtGTkNZQ0xi?=
 =?utf-8?B?NCtKck9nQzJGRDBpMzdYK0JGZmxLUkdsZ1AvNjV3aHN0ZERBUGFjMnVPdkh2?=
 =?utf-8?B?a1AydmlBWGZ6cVo1a1BvbENlRFQ2Vy9UL01YQWFTaE9ZOFhVNVB2UEd1czBO?=
 =?utf-8?B?NkE0eU1ZQUVzSFF5ai9NZG9ZMVRhQW1ud1lPQXJXK0dDRDV4N2JoZ2FWNS80?=
 =?utf-8?B?Z0Y0cDdoQklrcGFITlh0UFB4R2NrRlRQaWdmYWFIN3Z2RW5pUlZNMzRsaXhx?=
 =?utf-8?B?WEc3L2hTalpMd0w5RXZjb2JwQ3RWZ3F6TnE2dzNCZTlhMjNzOXVtM1dmZ2Jp?=
 =?utf-8?Q?gvHZeKxiIoc4cRdXFdngFxA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e219bdc-23c9-400b-5ab2-08d99aee928c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:12:50.3571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB04N0tfm6YQDfgH65B3mb13GmrEnQustqkNp0HLNV6rrC0KzG9KyJdNu4RouopVvYrqWZ93FZu0qopHug/E0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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

ping!

On 10/22/2021 1:03 PM, Nirmoy Das wrote:
> amdgpu_ttm_backend_bind() only needed for TTM_PL_TT
> and AMDGPU_PL_PREEMPT.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d784f8d3a834..eb872fc4ad92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -914,11 +914,6 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   		     ttm->num_pages, bo_mem, ttm);
>   	}
>   
> -	if (bo_mem->mem_type == AMDGPU_PL_GDS ||
> -	    bo_mem->mem_type == AMDGPU_PL_GWS ||
> -	    bo_mem->mem_type == AMDGPU_PL_OA)
> -		return -EINVAL;
> -
>   	if (bo_mem->mem_type != TTM_PL_TT ||
>   	    !amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {
>   		gtt->offset = AMDGPU_BO_INVALID_OFFSET;
