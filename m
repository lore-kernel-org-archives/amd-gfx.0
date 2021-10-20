Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7389460F6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7389460F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0800D89E19;
	Wed, 20 Oct 2021 21:54:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABAE89E19
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 21:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGTrp0E9tGLhZcs8bsl6cSCjbC54szyPjjxyKOu0+eEUyZ+jQ5U+tJkjBaY+vG2blrqB70+lIcbqBiZ3R1Ng0IueYXx2wfEisFw8LqhNkm6CX1Huio2gO6itaLFUFNtGWzR+wGi+PdXphfYj2FIDizG0AOs6pZV221lf0OHXqVW2or/INuKyBULgA26d8HZmYo95uV/wROE+BByl5QdqcSSnD53i4ONW45NIANO323ZVdjsSADAncWRMi0iXPYps79xwn+MMTko9NRVnQJhjAmbt+iR1ek5fsfcItsxMq5CxUXvu6yAMm6IKXTSQNphE+bwxB6kx3yVeb1IL8Lj58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAys3O7Ye5gWlyc5ZQCWXLpFO7nFoiRdB+//qZ08oaQ=;
 b=X0n6jDX+di8WxxUhIo2O8VpuZRGa7RbjW6gqXEbqAAACDSp2dGGfInLkxkRmTgEzTyZaFjjyIDmMeOmk4mpj1A1pdeg2gYR6wLOUu9zsQBldggWbDmn83xvYn780f4cPm9JSbiagCu/rfp19bRca0j79Nfi4yuSH7Uemc8e/aOL+ZwPwAtSUXNb5QDnU06857LltHwjBZ2BeOMdA44qs9XULqH1XoBRZ9xEUZlGW1VYdrPdt91a7bQ0akXEQEOCgpWD6+HUgYL+IzcHhdGD/RRPQ5X02yBFfKXcj+/erioEVk0F9IwX0gcdGIE0k8IeBHYboRx7R5uJB3CWqUvjXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAys3O7Ye5gWlyc5ZQCWXLpFO7nFoiRdB+//qZ08oaQ=;
 b=DAkNHT2akHeIvq1xfSPabGieVcbIR5nd5mXcRyDF6z/wteRM2nH8/rDWTmqy+sLFAwK/Igs4W/7sofPk1+r36MEbKN93zFCuoAqLObsndnK+26uOjEf4UONSh9LNR52ELCrY2YV36gzRg9Tzk88Uf7jSKIJy0dkljTGpJYxPckY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 21:54:12 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 21:54:12 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <42f538e2-22b7-7a74-7212-a6063694164b@amd.com>
Date: Wed, 20 Oct 2021 17:54:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211020163520.1167214-3-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: LO2P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::28)
 To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO2P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 21:54:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5120cad-fa5a-441a-134f-08d9941426a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB404159CE53D7826E99FC6D4692BE9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVLh+wG69CmGy/d53upUa6esiMppDQ0coCVFj10XtER0QrL5snztUDPHzCqNOlELntqM/72VM7oCjC3R+TW+HWqFHvel+fcvWAENb3J+MHSvI8WUzsBuKOx/5V+YxEMuOfuIMg9Ik2+DkvsfFpwCPvXKiYbKy+Bui6vUEZrCgKwtWJX1oy1I0Zjg0Nqpnz4KgaIR398cjjFo5H0zYeHYsBHRzCHVR9RM/U+X5BHOGzvk0OQxBzOO4e3Jme948gEJBfyUN0gGD+lqXPCzrHFgkpxnz6HrWzNNfkThz0Op9gUB16VeZnPqkrEcXroLPK58Gy5XPlDexDQedu3jmFBAv7JJx6dfiO2VwokJIYFzNgUpYRX3TLpRuX5I7r9dsmgS4afoCmm4bjZOqsPgHE2XK7DquQivge2FdJ4kvQ276jgXoJxswAGQdcvAhWQJaSHulgWkAeHOQbBAt45NgGK2ausLmKF/9aKcbiRTvPCIkwskP77epAZsaS1dFX9AUWt06529YW5rZWlvJb1YPg7DQmflrSWfEuRs/vEDhus1pBnx265/E0ZpcBYXpxPdj1ohDLnhc9k/5kME9hcHiy3t7GsT2Qbm1uB+p7MjLia38tsrwNarXB7xZCJXK5jouucTI3B+S+vHqIdsBzl2rL4jM1egepSqUWlIFkKpMpH/QV2l3ycA0nq8C+p1y2efugTTpHfwgOAoQTKBAgkCxk7PJTvTDkZEZzf8Vvdfo+5MXk+FC55+HuXGdp5hWyv+hwRG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(66946007)(36916002)(8936002)(508600001)(44832011)(66556008)(6486002)(66476007)(4001150100001)(26005)(2616005)(86362001)(5660300002)(2906002)(36756003)(16576012)(8676002)(31696002)(83380400001)(6666004)(956004)(316002)(4326008)(186003)(38100700002)(54906003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpwek4vdG9xbVlHYldVTGdXSHlRMndIYjlFSlRzYVFBdlliZmsxU2M0UHo1?=
 =?utf-8?B?UWZMTWFoWjlzcW10NFNsalp3VTJ1YVFUNm1zQkd1Qk0rTUpsd2pDZDBrSEx4?=
 =?utf-8?B?SHA5T1lsTGdWZEtvNS9YSkQzamF0alh2bEgwNnZZTGliT2g1bGhrQU10Y0xl?=
 =?utf-8?B?d3ZnQnQrSUhUTloxUUlJMUFVeXdSWUluN3Z2UnRveUpXZDU2KzZlS25QTVNZ?=
 =?utf-8?B?MGdqbWFjQzJVVm1tTldjdzUrWFV2M0RJcGVYZERLRE5hQ1c3WklSRm1CMDZF?=
 =?utf-8?B?dnRXVEdhNTZ6a0c4anFQcTBCWVFDQVE2RE9Kb3JCMlJVdklNOFcwTVF6RGtT?=
 =?utf-8?B?WlJ1U0lhV2x5VXdmNU9VanJzS0orOU5MUU9Oa3U0eHdValhueW9DOTY5RjNz?=
 =?utf-8?B?ZTBNWDZJSUdKVXk2bWFqaXRBYTVJU0tJQnJQWHJ4aFhKY3Q2LytMMGpxZGx2?=
 =?utf-8?B?SExKUHFZSGgxS045alhzUDlzOTNyMHJWa0lUVnpKcVllMWlZd0lEdE51VDhq?=
 =?utf-8?B?VGdpMURJZ05OZ1pNZ014Yi9XWnduaHVMT3c4eVFiT29TZGRtTjJQZ3grYzBv?=
 =?utf-8?B?OEMyL2IwLzhiemc3RWYrRmZQRGRMSUxjc0hLeTYzTTYvYlR3Q05NYUdxZktY?=
 =?utf-8?B?ZkswcG1YbWlZRkQ2ZVhvWXBaTlZlRDhIb2JTdm8wbXNJR2JrR1JPZUNuT0Vt?=
 =?utf-8?B?TUh5VHAyOWcxak1iNStkZlFZT2dLV2MxNC95R3pxbjNua1BBd09pZ3FaMWlS?=
 =?utf-8?B?dVpDNVYwbHFNZFlodHRvd001bitpYXRmVGFFazZ1ZFJWd3pWMjRQV0lIc0lO?=
 =?utf-8?B?dFdKVUdyS0p0RFE4VDM4aHp0dy92TGVsUmFQbHRBRzVlK09MRy9xMXU5V3Jv?=
 =?utf-8?B?RCtyOEsrQzVlQ01zdmU2cmxXb21JL01JV1BxWXJnWHdBMG1NbTVPRktGbDBZ?=
 =?utf-8?B?Qmg0R3ViS0tZc2FCc05DNW9KdkhLc3NSZzJJS0Q2SXExNE44cjViTEF0YmNO?=
 =?utf-8?B?YlNDTVYzNnE0aGd4U0xCRlNQWW1QbXE3cTAweWJvdVVmNmtLaW1PWTFFdjVS?=
 =?utf-8?B?RTdDSjRaaVZ4VVBvQU5vSXcxWGJ2eEVhdUhoQkk5bW9LRFlSVDJGV2xQbGx2?=
 =?utf-8?B?QXVuY1ZJbGVVc0pkZU9wYU9hNUlpNDhTUjlybE5uT0RvVkx3NzJlclpUdk5n?=
 =?utf-8?B?OThZTVROWmhHaklUL09mVnhBSUN1dURvVDRkTC9yWmRUckFmQmozMWRlQVIx?=
 =?utf-8?B?UnJCM2pYSkhKUHNSZVIxWWoxK1JrOFA5RFY4SEVWM3VpMUR2TnZWK3VYWU1w?=
 =?utf-8?B?eEVLOHVXWnQyODB5YTNZcHVmVGI3ZTh0dUhYTmJ4UUlNZFZKdUtoV0h2WCti?=
 =?utf-8?B?RThwQ0VlN05WYjBhOEJnb04zT01wZ0JSN3BhS0FITWZoRGw5VFZQeUhFNVdv?=
 =?utf-8?B?RDBSVmwvNmt4WnF2K3VsOXh6ZkF0N0plb0o3UEdERi9LMG9zRFUxVWt5bVVz?=
 =?utf-8?B?WXJUMXUrRVRYTWJuRVVZcTFveFlkeW1keWxhOUVVVXNZaVR5R2t6RXRhSmVE?=
 =?utf-8?B?ZlJXbWRPSG4veXVmQis3bDJwTWxKcUtoZXdVRGtweC9oUlNITUVjWDEzM3FY?=
 =?utf-8?B?SEE3TGNGeTJWZFBlZTJ5ZE1kUWFMcG83Tno5UW9oTjFyMDFPcWQ5ZUx6eDVu?=
 =?utf-8?B?MVZlRmt4M0RydmZCWjlxcFRQWE85WEdxSlROcjlEYld2Ui9pWVZFN3JWVUJ2?=
 =?utf-8?B?dGNWTEdCNldlSmUvWDh5RGRDWnpsOGo4SHFNWGhPTTE3eXAyZ0dhWkZjZ0tS?=
 =?utf-8?B?YVdycjlXYjBDZmxrUkRNdDl0Yk5tTE5CUGRWRExRblRlcGRmNnJsekFXTjFP?=
 =?utf-8?B?U3BwRDJmeXpYcGI0Rm1qQ3ZreVJHWGVZbmZtZDlibTc5UXBybytKM0ROZG9q?=
 =?utf-8?B?UWRSRTAva3pwWWFwUHZmVjJVNEp5bVJnaXF1WnJYbGZKYllYcmRwRUYyK0do?=
 =?utf-8?B?SFF6di9hS0VqK1NxYUwzbE9XWm5YSGZsZTRsMnJoV3dtSDVrV2M1aXNhdml4?=
 =?utf-8?B?MmpZTnpyR0hpVVdWN2hJc1c3WjdERk5YTTdRZ2J0dFUyZG9ITlBWaXBSM0pQ?=
 =?utf-8?B?ZXYwRW9CVHlyNmp3ZU5TelEyV0JuVjFmTmZUWDZSNTNCQjVwdUNjcmZiZk12?=
 =?utf-8?Q?ly9Dq+bvD80VAiOSWAWSAkI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5120cad-fa5a-441a-134f-08d9941426a3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 21:54:11.9503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2PJndDR+vST6eI4xQP0gSkbs7fYqSnoHTNM6OFpai6QGxDXENKlYK0C4z+13JfrgXH0CoWC6RNJJ2BmiE94iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

On 2021-10-20 12:35 p.m., Kent Russell wrote:
> If the bad_page_threshold kernel parameter is set to -2,
> continue to post the GPU. Print a warning to dmesg that this action has
> been done, and that page retirement will obviously not work for said GPU

I'd squash patch 2 and 3. The squashed patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 1ede0f0d6f55..31852330c1db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1115,11 +1115,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>   			res = amdgpu_ras_eeprom_correct_header_tag(control,
>   								   RAS_TABLE_HDR_VAL);
>   		} else {
> -			*exceed_err_limit = true;
> -			dev_err(adev->dev,
> -				"RAS records:%d exceed threshold:%d, "
> -				"GPU will not be initialized. Replace this GPU or increase the threshold",
> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>   				control->ras_num_recs, ras->bad_page_cnt_threshold);
> +			if (amdgpu_bad_page_threshold == -2) {
> +				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
> +				dev_warn(adev->dev, "Page retirement will not work for this GPU in this state.");
> +				res = 0;
> +			} else {
> +				*exceed_err_limit = true;
> +				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
> +			}
>   		}
>   	} else {
>   		DRM_INFO("Creating a new EEPROM table");
