Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151CAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E9C10E943;
	Thu,  9 Dec 2021 16:53:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B36810E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqRaPbZN3tn4Twwh8+OHvzdszZxT7749dogizP69EMoVx/LYG1rLN1xIUG/6MimwK5ZgMEv8z8OTKdgc6NeNe+hudEqET896S7fGRTNzWF3YM3+Xe6c4CxXIbdqKyLEQFDryMypfMVXdIX2ha+S5ggrhoDKqCL5Y+6NEGWWy5exZaUvhJy0MpyCw3MgZiV/3j0nL8OOQARn1gNZ8UiForXaDEOq6d5aLCWv98f9xr54Amy1NHGXsaDIH87xAZtDZWQkkQOUP3mWx/IY189Ca8AdrvYe9y0gbaLXpQZ1fLBnfXi25d5jVMgXraSnIgyijRz3FQYiMoMuZlO9Z+bmYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfVrPEkol7yabXm6JbdJCG3zKyb+ZYlLwolHqIvfQZg=;
 b=J5A1rUm7Hm3cWZmJ4cpxVlWlcGEMI+x1oPVbYNTge/W968pX6NE9ObisHneWWcGYmfV4H8TKfklrxn7B0sxL0eocYhW12cYnZvP562jDjKMEAPGmwxq+7SmOsTRcG9VuQimzWEThoAZl4DoRbhbgGX0dXujDVKOzquzp9ped7vf+hWz6Q0S+2zQLKU+eWHvRce4daS8TEeWjMVN9RtJjvem/IQt23ZBDj3yeIEV7zMyIAi/gu9IlwU6z5FsOvKKXrOXprI66GbzBXt2ggGU7U/rDG6fcoZnLnIcjWQxQwjcgwr9b5uxnYHEgmCRWzRt2vS0I7hWHeN4j22jOg9eYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfVrPEkol7yabXm6JbdJCG3zKyb+ZYlLwolHqIvfQZg=;
 b=I+1nQil5Vxfd0cAPnJ1r42tnCOfot/cQFyV7ijcGx4S07mtc/cN1RKhidptqP9/GSUX6OmVJGmgFI9OM/14pxlGvuOITkg6+OIklTnQtwhq1WxHIOZ3MgTk75sB9EICM/9sItuCOy/3J5LiInC70jIsVQUGVp3uDBexJPIo9Ihg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 08:53:33 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 08:53:33 +0000
Message-ID: <ca6f5212-05d2-2a18-c951-a296723f5a72@amd.com>
Date: Thu, 9 Dec 2021 14:23:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] drm/amdgpu: fix incorrect VCN revision in SRIOV
Content-Language: en-US
To: Leslie Shi <Yuliang.Shi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209082639.1296627-1-Yuliang.Shi@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211209082639.1296627-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::31) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a676c38b-32b5-462b-ff72-08d9baf160fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39327FB14E00DCEFFC2C26E497709@DM6PR12MB3932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVlhyJdwwIpF5+qJJo+kDVd/DTUryf/ZBV14H8ZK3+LD8mpq9JRRm5gTtfLTImV4TN1kwkVPjnampwf8mtUwD/qcoje22ANPG4qRPaTU2dDmRtPfqareeoL/kKn2KvF6ROJr64IbwZ9QDbIu4tpC7SABdGCXxEwAjjMEEy789ZlR80Fostyf8Zznz6UXrgJwgmHucI4kLBrgaUw2AuDDJbEh97DGta6SzHjFCaC3VKu2IMml+VZCiScq5Ln2puhEHpAyYEzS70QCqzNPVFDixWzxSjYzg/+jIZBl1WXWMqW9L/kacvcKFYKErK8xfTIPDI8E6caWwkA+n7tPQoVc7e0U8sYqnamm/pD5gefaEj9H12vbKOfiLwP7hNCM+k+7sjNW2mm7gTgSK9qrjCWfXaRx9rHZ4gqIVIERXlV+tDBoBa3FmGSkLf9BAvU4h/ZZlp+t2IqtT8g78CCQjKsBJjE4DbYrQI4F6GW9qE71qdybUBHTcHHXqUOraY3Tqbg8te630CgvpDBjF7/XQ+itk/U400LqlGZmFHnuTo7Qr1cPtaajsRP/qeVLj5c6EeoHymB+/yfnhbaoww/bNiwy3CcJavn+YQa/aCsZqxbsyJzyFvMRjbzJKOphH/XXKCgTQEPNpdhepjKO8L1OAgm8E2MarVC89dchNX85pCRiGBafIyJgUZTu/OzbTwm9Jnq7s0YtcbT95vyFQO4V/Nyz0E6kn6zbtqa6Pimw2/VN05M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(186003)(6486002)(66476007)(4326008)(66556008)(31686004)(6512007)(5660300002)(31696002)(8936002)(38100700002)(8676002)(26005)(2906002)(86362001)(36756003)(508600001)(53546011)(6666004)(2616005)(316002)(6506007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxBNHZ5aUJCRHUzNzIzdzRhVEg1ZzBna0o2OStkZWgyY3o0dUZGV3RVbkNm?=
 =?utf-8?B?WmwrL3BmQmUwdndhKzMxaE5DK1dSMUlxdHk5WktrYkk1citpSjBFOE83Rm5K?=
 =?utf-8?B?UG95dnR0dDZSUk9vQzVXRTN5MzJpZUZLRkxXelp2NlYzWFlYcS91ZkFicGs3?=
 =?utf-8?B?UWp3c3plTVlycWFDV0FjajNLUkxubWYzVW5xUFRtT0h6ZzN5QkFPQjRtNXBQ?=
 =?utf-8?B?a0lTcmRtWGFBa1dkQzQ0cEFJNTgxUG1vMWIyRnFMK2dCYkJPYTE2ZENPN3pq?=
 =?utf-8?B?ZDlWditKUHBMZzlpRmorckVWZjRRSWF1b0NXOXpwSGZsdHp6anZpcSthcGlR?=
 =?utf-8?B?c2c5SS9ZWkwrdjhGc0xqZUJqaHF6YUFEb1lxeWNTcXArK0xyZGV0Q0tsa2lD?=
 =?utf-8?B?SzJRYlpzWE45TEZreWgxUzZFNDk4K1A5K3ZaREM2UkdVaklIMnViVTJuK21t?=
 =?utf-8?B?L3djZU91QmtLVGVvZm9OSyt4NlUrbHNNc1BrSmFzTlpab203M1Z6VXJiSWFT?=
 =?utf-8?B?SzJRV2xCOUNwdFNIY1dQaUk1akJmaUtxdTJPMlJyRUJQWlg0RVhrZXd1bUR6?=
 =?utf-8?B?bDBOd0lsSHdRYlJGSTU5Z3B5SGYrN1E2cHBvdjZLamg3UE8zVVFYRm4wWkVm?=
 =?utf-8?B?TTZiWmZtdW5GM1BLTWRRc1h0NDFXRTB6VU5OV01PUU1tSy9BQ1VQRnZzSzg1?=
 =?utf-8?B?NjJLcyt5SVpGY2hGdXh2NE56UCtwTFkyak9iNlpXZGxDZXBvbWlQZFdrbUJt?=
 =?utf-8?B?TFRubVVqMHZFOWp3N2E5Y0pLUFlLWGpiQ3RHdnFlYVJEQlpJNkVsbTBIc2N0?=
 =?utf-8?B?cUR3bElJbk8zekFXYmdSaDJxZUZhOEJwckUwKzFFenEyN2pLc0JmY0E1M3Bu?=
 =?utf-8?B?dFQvTHBRZjdQTXduVDdFeDBqSEZ1dzVnWTkwd3VDeWl4a2NjeGI3bEZaNDFW?=
 =?utf-8?B?QXJCT2JsQTRicEdrWU9pay9mcm5rVGN1bEJvd3RCYlJneCt1RzVia2dvcHZn?=
 =?utf-8?B?MWNhTVVqZGpmMHU2UFJ6VGoyWGRLYktaRklmRlBIZ2ZIaytaRUhoSmhRaTgr?=
 =?utf-8?B?cG9xb3B0aHhFcWxxSEJhU2xBclNuNUdpQis5WlpaZWtLRGJrUDBpK2d3ZWhM?=
 =?utf-8?B?TDBZakIrVUx2V0s4ejc5WmF1ejk4M2NRTUhvUHRrZDM3Zm9MekdLWUE4UTJq?=
 =?utf-8?B?cXpjVmNxeWRsclMzS04yQmhmYmtqNzF1TUd6Q1R6eHNEZDdrVWdzZ1dSUVdO?=
 =?utf-8?B?QWI1L0ppNHJnbWgxYVhUZENHWk4yRXdTM25ybWQzVnk5VVloTHd4bittNFAz?=
 =?utf-8?B?R1dLV2NDQitzMUxaRlUwT3ZPTEhRa0krVEpmVTRFOHZRcUx5RTBBNWxWaHlu?=
 =?utf-8?B?KzA5bG9JM3h3WGs0a09STGhNSVlscElzZGFFakJSRjN0ZTIrMExoTUZzRjVt?=
 =?utf-8?B?Y05SVG5hVTVzWDh1K1lGejV6dUQzcWpNVk9UemNhNko2QndDV1BFRzZLRko1?=
 =?utf-8?B?UVFBK25TYXlpNXpiZURyVUxoV1B1YUhCWjZXN2h6ZUhuVmU5djczNFFSSmJs?=
 =?utf-8?B?RGhCZG1Lanc3QU00YmxlbkpJVzVpZzNHaDU3cHc1NFF5UmhsWFhhTSt4dWZY?=
 =?utf-8?B?MG5ManBZZ3hFYjNPa1B3bG9zYU9KNUdzK00xbFduRDduME1aY1VMbGlWbzRQ?=
 =?utf-8?B?amVyNDFMVFU0eXAwYldjL1VZOVpmWGVLN2VCa3ZXMUJDVnkzY1J3Tm1ONzlt?=
 =?utf-8?B?cVV3Wnd5YnhUKzJuOUpVdG13WEpsZ1dHbmkvaUgreGFpUGFNNlNvSVZWdHps?=
 =?utf-8?B?dlcvMEhEdEN3R2FnWTBaVnA2UUcvcDdWbWxXSlp2bWdtRWlZV3dMMENwZDZR?=
 =?utf-8?B?TlVjU09uTEJLWDMvd1lheEp1TE92bE9pbmhLRlR6VlFQZmNxeVROczV5bk1x?=
 =?utf-8?B?UE83SnhuSVVBZnhUc0k1NGxCZ0ZTTjJmNTRpeWdQTDBVbTUxNUFwWnhRWXdS?=
 =?utf-8?B?REw3SWx4NnY5SjBIS0ZaT2h0c0RpWXlXQ0xPVGFFMTB4VEt2MU1GSHR6UFA2?=
 =?utf-8?B?K0paaXNFUlhiQmYzbm8wUmhWNCs3VFJjdXZLUHl5a3QzQ1ZibzVWU1pyY2Zt?=
 =?utf-8?Q?BD2I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a676c38b-32b5-462b-ff72-08d9baf160fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:53:33.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K66F1rUq/KviTAsk7Ofj0niWRP+noLNtUkNlQblLs5aV1epyGTOdduoyZ4obn5WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/9/2021 1:56 PM, Leslie Shi wrote:
> Guest OS will setup VCN instance 1 which is disabled as an enabled instance and
> execute initialization work on it, but this causes VCN ib ring test failure
> on the disabled VCN instance during modprobe:
> 
> amdgpu 0000:00:08.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 5 on hub 1
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_dec_0 (-110).
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_enc_0.0 (-110).
> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).
> 
> v2: drop amdgpu_discovery_get_vcn_version and rename sriov_config to
> vcn_config
> v3: modify VCN's revision in SR-IOV and bare-metal
> 
> Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 29 ++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 +++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
>   4 files changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 552031950518..f31bc0187394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -380,18 +380,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				  ip->revision);
>   
>   			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
> -				if (amdgpu_sriov_vf(adev)) {
> -					/* SR-IOV modifies each VCN’s revision (uint8)
> -					 * Bit [5:0]: original revision value
> -					 * Bit [7:6]: en/decode capability:
> -					 *     0b00 : VCN function normally
> -					 *     0b10 : encode is disabled
> -					 *     0b01 : decode is disabled
> -					 */
> -					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
> -						(ip->revision & 0xc0) >> 6;
> -					ip->revision &= ~0xc0;
> -				}
> +				/* Bit [5:0]: original revision value
> +				 * Bit [7:6]: en/decode capability:
> +				 *     0b00 : VCN function normally
> +				 *     0b10 : encode is disabled
> +				 *     0b01 : decode is disabled
> +				 */
> +				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> +					ip->revision & 0xc0;
> +				ip->revision &= ~0xc0;
>   				adev->vcn.num_vcn_inst++;
>   			}
>   			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
> @@ -485,14 +482,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>   	return -EINVAL;
>   }
>   
> -
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> -				     int *major, int *minor, int *revision)
> -{
> -	return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
> -					       vcn_instance, major, minor, revision);
> -}
> -
>   void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   {
>   	struct binary_header *bhdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 0ea029e3b850..14537cec19db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -33,8 +33,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
>   int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>                                       int *major, int *minor, int *revision);
>   
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> -				     int *major, int *minor, int *revision);
>   int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2658414c503d..38036cbf6203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -284,20 +284,13 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
>   {
>   	bool ret = false;
> +	int vcn_config = adev->vcn.vcn_config[vcn_instance];

Missed it. I guess there should also be a check for valid instance, 
otherwise it could return false (by default nothing is disabled for a 
non-existent VCN instance).

If the check is not there in the caller and assuming instance is 0 based 
index,
	vcn_instance >= adev->vcn.num_vcn_inst
		return true;

Thanks,
Lijo

>   
> -	int major;
> -	int minor;
> -	int revision;
> -
> -	/* if cannot find IP data, then this VCN does not exist */
> -	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
> -		return true;
> -
> -	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> +	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
>   		ret = true;
> -	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> +	} else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
>   		ret = true;
> -	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> +	} else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
>   		ret = true;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 938a5ead3f20..5d3728b027d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -235,7 +235,7 @@ struct amdgpu_vcn {
>   
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> -	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
> +	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
>   	struct amdgpu_vcn_reg	 internal;
>   	struct mutex		 vcn_pg_lock;
>   	struct mutex		vcn1_jpeg1_workaround;
> 
