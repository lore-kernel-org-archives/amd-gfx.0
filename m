Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D35C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 05:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABCD6E8D5;
	Wed, 24 Nov 2021 05:30:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CAB6E8D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 05:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvJVsdnNA0dPMF55x0jWsg1uX6OGqrI8wOibPSOa/NxnDmD0n7D8AN9yTM78bJQfWlCntID6fHuEDogyRm4e+yFPotV/+769rwWqx95bSWRH980tmpaBnvrgk4ZFHtqJxjWdgHTFG3hZC2aZ99eXCJ2vcMw+lHU8gBg1CUUlf5YkiDvAsKFuwb66uFtLiUWGDDFwXvsYLsV2MgqwIHlp9P6LWhMJIR0KnvegciB8QSpCKPQl47KlrsXS86lFCdL61xu++K/HpPFoFugnLzzp2reQx8gY/OWh/tqnQkgq9hpm1GH8KuDtwUPLDvixQp+HAia1bNZePvczefu4it4VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9ysmmeVHo4Sx6VznTEx9yQ30Rl6EqHHOELvwRPi08E=;
 b=JReblYigutpGs9rrLPs3XoAqOHOKLDEajmY0VlhkezXgwPRaRnGYWP0Mc5VMzVETPNJdZdn4tzcDt/QdEEEu77jGvtozMu4EG1/CKtQG1DOiAt8hGcQbj5cc1JJhPkWGv7dqCCuMLAZe9cMUO/5851cWI5UHjjLAHVdsJbsH4N5rqIwSqX6NiZpQPka/v/uF3rGy34GJ/hPJkea5ToelJunlC0cJlr1qac2z7UJt7nQaOn12UkQ5Pl7nPHH3ZJITKAPGNlDdvx3moY8LPHJ9fDJ0nKTNXVeIDfMvDgciSZwWtJpdkLaHh3ezq3lYYhHT+ghX4SHr17ujIUl5OK7bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ysmmeVHo4Sx6VznTEx9yQ30Rl6EqHHOELvwRPi08E=;
 b=QzmWi6lY4XQxgpvcgrn+exQQEsm6IgE7TB9Lnn163w9wBirDeEZBFxueV5qrTValhknxdpNr5tDAWdI/PEDDrCQVhtty6CRT0ZEjXszJHqrgHA5w/Qws3DCKlKO2kNENJdGBR1Tmmxe2l3hM7ZVaNPpbwNo2AsgAP+uJuXCwJNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 05:30:35 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Wed, 24 Nov 2021
 05:30:35 +0000
Message-ID: <87497643-9f32-51c6-6490-d14755495802@amd.com>
Date: Wed, 24 Nov 2021 11:00:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: fix byteorder error in amdgpu discovery
Content-Language: en-US
To: Yang Wang <KevinYang.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124043709.2651699-1-KevinYang.Wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211124043709.2651699-1-KevinYang.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 05:30:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb4cd71f-bf4d-4864-0b34-08d9af0b8a7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43563CFF6C8CA2E0AA55A36797619@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adSbInyv5nvfhQMtuOjqm+VMAH25ZjhHLMITjcWWq9iwRzGXPd98lbHJk+pNiloun6YUvMPrv0Ik2KfArrp/tTE2N5HI7liu3YEbF4hYK5Wx8/fkIpLoUDcqqlraCVZ7IIj/fsDv/LH5MlY/RbNWTRxdxQFx5aRDLP7bSZ7Mq9cfH3KJ+dYbIQG5v9f4LVjZ07D955HhBQI4vDsbTO1zjdXmV9mBegxczOtAxl1aCRx0CHmFdeWgmUCgqnWngZjgatXLXvzv9S/fZBjhc4Q/TsTh2i6GsZ2zad7kua5dgHv8VnVpFxu5t4p4Sqbt42QpG30YoKuwyMsohyzq+cjXky4qSPsPOKm0AVud6oT+Uie6OxwHSpAIhb2FtJCnJ/Io36U1fIH4OIvLomYZm1to68M1dR2NolYmNSrn05H+LzUaGbnsEw1+5aA9ExczgI/Qd8n7UEPrSI40EH37M/XD9i5rY0EGkmJOSLKRE3d8LFrx7Sc6jfuLcSpg8/QHPrvuFNZ1CAQXNkFeGNf57VTbqnqFw10943PbdcipiLwPCz3GVBjdkNDSDfSGxHK5B8dYY0HNA/ddp4vf3H3G9UBFlAHsEWGdMGThz3oLeV3579L6/lcweoK0cS3LG9TmA+oekeO4VwT9PBbvYGRN0d4a6FPf8x+1Il7IUzRjcutxQKBhnwEYmsPoC0acgLBSGDha3WrmXEBMRZuRZzdvKeebcBJJuQhpkpvF4VNGR6Hq7dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(38100700002)(8676002)(186003)(2906002)(6486002)(66556008)(31686004)(26005)(8936002)(36756003)(316002)(956004)(16576012)(66476007)(66946007)(2616005)(5660300002)(508600001)(83380400001)(86362001)(4326008)(53546011)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUptUDU1c0tXaXdoR3lXWDNSa1RSTUlscDFhY21WMEUwRWdrM2RzRU1JbWNy?=
 =?utf-8?B?VVdKcnpYTHh1S0I0Sm1vbkhValB4dkQyNHRwbldUVmZvcCt4OXpzb201cTgr?=
 =?utf-8?B?cnNDRmNpcEZ4akNmWG5QZ2F4SFFjT0FUVmhKbWQvcjdMYTlObnhyaHRZbFVj?=
 =?utf-8?B?OUVxSnJmTVZBbmYrL3gxR1VZNDZ1ZWg0eHNBTmJGditoRFlndEJUbkR6eE5Z?=
 =?utf-8?B?d1VTUUpGVjIrS2RlRTdYa0lYZ3dwM2RTVy9YOUVwQnp4Q0ZDWjBDbmJTN0FN?=
 =?utf-8?B?OEVrclFHTU5SeWtQL2ZXU2JuUVh1elNLeHRoRXowalp1ZS95RWxybE5QZDBq?=
 =?utf-8?B?ZC9la3RiRytKL0RxbGpaZTd6VmJrMlQrNS9lN01GeFhkWXZNZG80blI5aXFu?=
 =?utf-8?B?a08zdmFMenlZRUlUVFJCdVVTcXBpRjU4S3ZTTmdtTUx2WGMyRncvQk1vZkVa?=
 =?utf-8?B?bzg1d0lSdmNGTVl6Ynh6ZXhlTUI3ZDNoTFI3cDlySE1kUEJ6Y3I0UDdsdjRp?=
 =?utf-8?B?QWdhN0U1VkUzL2VVU3dBQVRCVDVUSnNDWkExY3BHZFpKa0JVaStsQWNZdm9C?=
 =?utf-8?B?WGRCeDZBdWZuZHdxdDE1bE50NzFoei9iUG9uVzJlVjcvdlhPaEhoTjVrS0Zk?=
 =?utf-8?B?Zlg3R3hwUDRjOTE3VmhYUDFlRGZVVGd3endhSmx4eVRyMlJqYU42cTZWTFJq?=
 =?utf-8?B?M0xFa2Q0ZjZFRU9ITFViSzA2V2c1dkZXcXllTkxxSXQ5d0RFSkFpbUFHQm1r?=
 =?utf-8?B?UC91WHM2WE8wR2Vqc0t5NjFoTE9TN3I5VU96dkdnY0dUb3JLbVRXdFhFeUJN?=
 =?utf-8?B?WUJ4VTUrQUlac3VvbHYxSENBbW11QzZQeTRLT2RtTHc0N0FSdDFXbEErOE1P?=
 =?utf-8?B?VlE3NExnQkJWKzBhc09JT3IvdVhJeC90Q0M5NkRJUGpxenlLN0VuSGNhYUVB?=
 =?utf-8?B?QjN4T0NzMnFVdVIrRFdHLytCSVZpbGZPZ21VY0owY3QydFQ4QnQ1TlpMaTZH?=
 =?utf-8?B?bmdydkNNRWZPOG9mZ3FrSDRTNi83VDQ4UzhzaFZCOHRJeVN3eHFOemU2SEcv?=
 =?utf-8?B?SzJSUFV4dHc5Z1pLcFZDR2FDTXREdy9vOEtsaERQRGp6Rk41S2NPVk9Cc2VO?=
 =?utf-8?B?cFF1R3dRUFJzYWRMd2Z0OUdEMmpaOTRUZndiYTVSNkZOWVdUcVBLK2c0eHlR?=
 =?utf-8?B?aElPNWNDWWdZVzhNYVVQay8rd0JjTnZOakpuT09yRWdKb1M4YVphNWNqRTht?=
 =?utf-8?B?WHhsRjY2VS9zdVk3OXV6L2lWMHN0cm4xTHhYR0h3U0NIamJxSnRMUm0wU0Ey?=
 =?utf-8?B?Qnh6Ym1WaVRSeFhpbklaUjY2TXZ5UEhLOEZZd2NHbk1PWE9QZk9vdmRiQW56?=
 =?utf-8?B?SFRVMmxWVHFCanhlVnlkeDJ6UGc4ZnBIYmNEYS82L0hkV1hPdTJZUlF3UEhi?=
 =?utf-8?B?RStJc1BMVDBZZlVrbG9DOFd1SVltS3ZuZzVXYVkxMi8zNy8vU1loeHVPMmFC?=
 =?utf-8?B?YVJNakZRbk9MTWdSTWpJeng0VWpYZWZKeUdJK1VYcFQwb1FBdlVLU21UaEFL?=
 =?utf-8?B?dUpWU0pWZ2daN2E1RTN5U1V4cTN4dUFKZEdOMnFua2JOb2VVcGxWcFMzdmtm?=
 =?utf-8?B?WkMwMytMSHFaYnAyVytEWXBPelhrQUtJWmZzWU9OWXV0TGZ2cXJ4Zk11M2Zk?=
 =?utf-8?B?UmROOGtReTNUYWZiOEVSNDZQUU54Q01sRDJtRE1TNlhNU1VObitIOC9KeXR2?=
 =?utf-8?B?anpQTUE3b2V0OTZqUmRTMzFidDBnZ1pQR0tBSDFoOHVlMnVmV1pZdjJabTB4?=
 =?utf-8?B?dFZsSTgvSUQ3WGFWVTN1b2xiaDhscjFrVXJZQ3B5WldpVE82QXM1dTBkbFNG?=
 =?utf-8?B?emNCeWVWK3dTYjk2QzI1QzZJV0RucFdYS2hnZ3J2ZU5SOHpnTThxbUFmRmNu?=
 =?utf-8?B?MVZCN1FlWjFraTVPajUya29JSlFkNUtMZXFlQVo5U1c2M3lSWEVlaDliUmVu?=
 =?utf-8?B?QjhPa0ZYYlAyOGxZTkE4Y2QrSWdUeTFINHdURFhFZnlCZzVzckVEZ0tYS3BN?=
 =?utf-8?B?Y0pPdWVKU0lzc0pieDNtVkJFQVE3cU1WUEIyTGhKR1lzcVM4WnhpRWF6Slpt?=
 =?utf-8?Q?G/iU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4cd71f-bf4d-4864-0b34-08d9af0b8a7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 05:30:35.6306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY6tgXa2epwH6MNlm6TtfNgb3yobQg/aKQVxtsEjmtJBOu0XuZTIKykpRtsY9M3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/24/2021 10:07 AM, Yang Wang wrote:
> fix some byteorder issues about amdgpu discovery.
> This will result in running errors on the big end system. (e.g:MIPS)
> 
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4e3669407518..503995c7ff6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -248,8 +248,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   
>   	offset = offsetof(struct binary_header, binary_checksum) +
>   		sizeof(bhdr->binary_checksum);
> -	size = bhdr->binary_size - offset;
> -	checksum = bhdr->binary_checksum;
> +	size = le16_to_cpu(bhdr->binary_size) - offset;
> +	checksum = le16_to_cpu(bhdr->binary_checksum);
>   
>   	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
>   					      size, checksum)) {
> @@ -270,7 +270,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
> -					      ihdr->size, checksum)) {
> +					      le16_to_cpu(ihdr->size), checksum)) {
>   		DRM_ERROR("invalid ip discovery data table checksum\n");
>   		r = -EINVAL;
>   		goto out;
> @@ -282,7 +282,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	ghdr = (struct gpu_info_header *)(adev->mman.discovery_bin + offset);
>   
>   	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
> -				              ghdr->size, checksum)) {
> +				              le32_to_cpu(ghdr->size), checksum)) {
>   		DRM_ERROR("invalid gc data table checksum\n");
>   		r = -EINVAL;
>   		goto out;
> @@ -489,10 +489,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
>   
>   	for (i = 0; i < 32; i++) {
> -		if (le32_to_cpu(harvest_info->list[i].hw_id) == 0)
> +		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
>   			break;
>   
> -		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
> +		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
>   		case VCN_HWID:
>   			vcn_harvest_count++;
>   			if (harvest_info->list[i].number_instance == 0)
> 
