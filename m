Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9A1608FB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF9A1608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1136FCB6;
	Tue,  2 Nov 2021 08:01:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAA46FCB4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 08:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TphL00Xi2gQzp1yDUCpvF4LOdma0kqnOhQBMMH0+DMjZmFowCKF4eqSGRGc6EpB2kCP3cfKpIM/NxCK05HvfLtjsNirXEF2pL4UhI1qxeo64H/ZGnuCzfugzIZWTJ0g2OebqwWFkXqSkr7p1RnKFRuhWEcEoZUSQdcQsNmrZPzglKgZG1gZwb9lfzuoNQB2nG6i0VNzd05c4/FZZfc/CJinxNlS27qwCAcu2uwsNA5QXY8c+3oJycgMEuxO/pyUlHGS17TEjRyX8g1VHbuz/bOSXlzsq2EJ1Khzcao+3zlAL3IY5DQBbI3KRyXO5QOz3z91+ldXW5FI75fB8e6ftrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpcqC9jibDE2MP87faWVqWZhSfjaiTr4hi7h2nMCMuI=;
 b=ChDoL8MIWcYLc4i5UY3gG9SgJtrqjYiWuflNwBRgSZajYRn2/m/WniO3EhdrDYk9kX4J9GA9QlRCxkJ9/vmS1hN9qBCaA+rl7ikaaZDdBtOMTv6RSIwzFXgDXUMCzFItzJyOmCAP2zFIR4zz2Hwyt8fwPMXTZlSZUkegtCjEseuju1zIRNo6CMfuWIT8FKPiI3jQo4/RtPJznsnSEeWDy8FTjsquxjUbzWuyKrct1GAmpVNAkNsC/AQlYP+jUthGajeNYsjHRMIpELgoqzoLrL6zP+NDuE6w6SDMe3ZWwiYvwvws+zv23AE/98MZ8iST597O71mZyL4TPg/blPXbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpcqC9jibDE2MP87faWVqWZhSfjaiTr4hi7h2nMCMuI=;
 b=Na7+T2cKHhWwNlUvb72gNaTWXLjd/HW4QyE1EL94pueYC5EJBL87IzcY6jLeFm0t4sIZAvoSvZhDW79nZlNVSxy4RRTSOYaedKb5Wgs0Yru6d1znGkt2kRdO0Jv+bGoaD3slTANpMOXsdJ8pExACqmL7G1WnnEWp6hHxpPHISmk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 08:01:00 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 08:01:00 +0000
Message-ID: <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
Date: Tue, 2 Nov 2021 13:30:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
Content-Language: en-US
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211029150917.4462-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::8) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 08:00:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6f6a82-0205-4bcc-492a-08d99dd6e880
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40118D0C9ECB6DAF5FCE0A8E978B9@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAMwiAI2KwrQGclBNkkeck7rhHcH7xl/k6bQrdp0q//MuGNoz3XfSrmJHR/X/ENJTjJCqX12Eod3TUBqp+W+N2f945U4JNEd5sm6xg4ryLabTfWUyxeFJBH6kkOBL9nXyNA+2mKkJ1Q7K+cuCnfwYgIbxivkbKnS0QCdl6ruJsXSJjQBFJ3PXVL5IHoSX/1hnP5fS7rRb69scXVfRWIwfyKrsWNuJ1zmBmC7W72REkHCGdQyjhp2D0WbSCari9Z4X9emm16X68f0EV1CR8ryaMHHz7SdmYs3OEi1Sd4TmVvByLMb2bzzl/JQSLwgm2UnQZCknTFYcz8OEQHN4+/hFym/2JVCXpFrdEQ49Hie4nwM7UdKKJVwzRyxxe+kzMK5t/i3me1wx4kwI6uxTuXeLnf/1wy1BxZS3FR1UPk/pzZ5HVoM7obnqW2iWJCWBfPR0v/uMoT9cx4jP5mL8AUNnMMVVhxA7g/5NE5WOoH85daXGYc7ob7lf6ALs5o9M4t6Ys7HP+AhxAMRf0ZxVC8CWyB/NCD9FvwAD+7T34Q1Y6WycxL8tRXSmgD5iNQJn80s6TtGyiumlV73+3UxXPBuUHowPmmfpSbj+ScItfc4cizU2Wam+ZbtzCm6/+7ZumxqjB3uVisUHmsgEJ0kGtVnFZ2e6IG3Zz3/hsEl6Gk+tlhgvjhjmTWSjSay0tPZzi+CUvOcQ4koFKoF7fR1ZgzOJOBBafnZSUx+bfQJNWmfpC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8936002)(186003)(956004)(8676002)(2616005)(66476007)(66946007)(26005)(66556008)(38100700002)(31686004)(6486002)(36756003)(316002)(16576012)(5660300002)(31696002)(86362001)(83380400001)(508600001)(53546011)(2906002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amIwVTd5ZTBHRkhab1ZPTU9mWDZnTk1EZ05KVUM5NGllYWJxM2YyNHdlTVBv?=
 =?utf-8?B?bjhCNXR5eVVXVXg1VU1iS2RESDB1QXRmRWRDaWxGK3ZHcnhRYVI2aFQvZjlr?=
 =?utf-8?B?bDkyWnJDRmZrdWd0UGdXZUh2RDNKMVpaelRpdFdLQXpLcEM2d2p3WUZocWZE?=
 =?utf-8?B?Zy9Xc3M4TWxETUJzakNyeDFhZDJZRjZlam9DeG4xMnNaNDBQSURRZ0hxdi8v?=
 =?utf-8?B?aXhwd3JyVzFYTjVkMXY4ejNBMGxldU5UY3VsVll1alpiMllUSE1iaEZjU0pz?=
 =?utf-8?B?d0VnMUM5MjhQZWgyZ3ZMalFnNk5mUTh3VDhOREErU2ZXRmd2Z3EvWjNlTXBP?=
 =?utf-8?B?c1B4N2NHa2pmTXVsWjZ2N0VzcnFWMkVWajNUb3BZMHVtT0ZwcUFQRXdOL3dP?=
 =?utf-8?B?eUtjQ2dKRmpkTnF1SWJFUXVwT3U1T1JYNitpN1BIZEpCUVhpMjBuL1orTDgr?=
 =?utf-8?B?ZGF4OHNYN1lJREtyQng2dUlKOWhNTkIxRy9jV2JPMTBCeko5eWdNTlFLdVNm?=
 =?utf-8?B?R3RYaFFlMlV3bHN4WnU3ZGswYTRGVFJvODc5elpxLzMyYnYrc2FJeEl0VVJx?=
 =?utf-8?B?cTJHMGU1ZllpcTFPSXFXdFc5WUtDUE0rQWFPVHBwbmpnYlU5RGNoM004Yk1P?=
 =?utf-8?B?NjRwaEpxQ0JOWjR6cFQrWGt3N2VBOFc0S05MWVBWUzVISi9GMDlQdjNWaHJw?=
 =?utf-8?B?eUhvNXlCYkhRSkhhSmh1R3YzUWdYYVlQamk2VEFBOTNFMkdmeG4wOFBteDB1?=
 =?utf-8?B?cDMxbjBKWkEzNXNOQzQzSWtnUktqQkZBWDF4VTV2cEZDWk5XSFJreWI0UlJE?=
 =?utf-8?B?TEpxNlRkRGxIMzJtblpXUlY4eXU0R29RZ2VXUTFkbWwvWTI5Tm5sRlJPMGVJ?=
 =?utf-8?B?RGZXRi9oWHczdXpJYXN0K2M5anB6d3JLTGcxdGRHc2xwTDFaZ2JwMmpLQmIw?=
 =?utf-8?B?MGNIb3hRNiszTXZLbmN0SHo5NWsyRlRzNWh1UEhvcm4rVGNtb0lRNnJvWFBL?=
 =?utf-8?B?UVNxODNkQ2N6TjJ2aHNHUU8zQTZDY2ZnbDlRN1hscEJvdVdnR2RjM3dBRkk5?=
 =?utf-8?B?TkYvaHh2dnV2U1dlRnJWcnRsb0NPNjQ2YTFTek1QU0Vza05SWm9EOWVpZXJQ?=
 =?utf-8?B?TDYxVUtTY05ia2ZiNU9hUGprRmN3V1Z3aFBSeHlWZ2VLQzNLV1dRVUpobzkr?=
 =?utf-8?B?Nmt2Mmp2cytVU2E5a284c1R0cUszWTNDSm4yS0V5K0RQVVpXdFVLUjdmRW83?=
 =?utf-8?B?cHZJbWxFdk9uZXBWOHVVM1c0YzNQMmtXUVdLVEtkNDdOUGNHS09pNXRGODlw?=
 =?utf-8?B?WXVNTG5Cby9ScDY1Wk53NWZDSjk2UElkaVJKK0NQUnh4K2VlSExkVTlzNlJS?=
 =?utf-8?B?Z2VUUERuZFJtTEtMaU1GelBDRUJpdlF2VU9Ga21JQTFMcWxVMlZUaG1mRnhD?=
 =?utf-8?B?L3JIK2loWWFCakRWV1h5bmluaXExN25LZ3JTb0JCRG1oRkUvYnhLK3FwQVlD?=
 =?utf-8?B?R1JFcjE0VlRTUVV0dTZ6ZnpVMVUyRi9Va2w4L0ZhZXVaQ2srT2pvTEFjY0lh?=
 =?utf-8?B?S1ZrMENhQ2ZhWkNiTDh4UDgyWTAwVW5EQnJPMC82bzJWL0Y5THZrMlZlNUk3?=
 =?utf-8?B?RDZRVk5wbmpxSUpnUUk2bWtCSWpuM0NLV05tK2hwRzBoN0piWjM3a1gyMk91?=
 =?utf-8?B?SWMyVlpjMGJ6WlZCUGszN21TZ2krY3grYlc0SjZuTEtoUlVXN0lJbDI4OHFu?=
 =?utf-8?B?MGtwNzlqT0EweTkyb3ZrUG5xNXoxYkVyTVYreTF6VFE0dHk0RzdyaE4yQS9M?=
 =?utf-8?B?V3I5dVUwaFVjd2l3clpPQ2tOZXEwTXpmQW9GVzhzajBFTkRUaTJoS3UzY0NW?=
 =?utf-8?B?aFlQc0tRcGJCSkN1YmZjZk01dTRVQ1hPbHpLWlZkNFhLLzhZeHpmV2RmNGhT?=
 =?utf-8?B?cjE2SnRvM0NYdllrQXdmQnNsL3RYQWZJTzQ2NzJzVHRhb2pJZUh3bE56U3or?=
 =?utf-8?B?NEQyVWY5VGx5YnlaOTNOS3BvZDQzVWhhemdDdFN0ZFE4Y0c4emhtMXQwM0o2?=
 =?utf-8?B?QlZkRWFWNG9wYjJVeEE0TDZwM1cwbU1MMzExbGdzOTF2L2RicWJ3ZkRIOGFi?=
 =?utf-8?Q?r3rk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6f6a82-0205-4bcc-492a-08d99dd6e880
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 08:01:00.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KH+S13g4XKvxALx7xqk1tJ5LXOdiqaJa+3nZ+gG8RKpllfmMKFtzhWT4aiCeYy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/29/2021 8:39 PM, Nirmoy Das wrote:
> We set WC memtype for aper_base but don't check return value
> of arch_io_reserve_memtype_wc(). Be more defensive and return
> early on error.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 073ba2af0b9c..6b25982a9077 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		/* reserve PAT memory space to WC for VRAM */
> -		arch_io_reserve_memtype_wc(adev->gmc.aper_base,
> +		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>   				adev->gmc.aper_size);

BTW, isn't it more appropriate to use visible vram size? There are cases 
where pci resize rounds aperture to the next higher size > size of 
actual VRAM.

Thanks,
Lijo
>   
> +		if (r) {
> +			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
> +			return r;
> +		}
> +
>   		/* Add an MTRR for the VRAM */
>   		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>   				adev->gmc.aper_size);
> 
