Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A867C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 16:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0580695281;
	Tue, 12 Jul 2022 16:02:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6433089354
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 16:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpwItw481JLVq2V3YMDHsyRdsJHm6khcTq+X8J8wxZr2j/ORrsNd2z2ebDAffjsbfWm/xD/D24pO1BeFFaUm+5rqJVqCXx2XcnFzTR7B1PwzHS1vGMmEB9wgYlTnzkwovqiGYt/NUMPGEmlmvgEF9VzKiCaROlpu9fr0LVB894fFZ0HbPQm26HJWmqVnxTDvTtUhjKVTvxbIbLo9LWjADh29E4C+GnBQ/yI0lYkzTXVugwVPhA2a+P+C/JtRETtZ//NY4B38rCdJOLleVCyJ2bSQ7uJF5Z9NJ4lb9VmImVQNgZNW8PLMwkHfDrRQjNpmc3hh5DQ9+Tqcqek6MheWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rx6QKFweFDIRg1D+cOWxtHlOu4XzCaGb8IOgSib5JM=;
 b=kSdf+tV3jfbq73QG4Rd8pJ6d+yZXRI6L9e5mVzWCRfyO7qn9BtY8CGZ6X3G1Z0zdGbOifxCZjp7ixW1cjgZZT0XTqrkpb/fAY9pEGdKf9kJD7UnRi+62REMHDGxLOi0eQbI7GmuE38tqa1C18+c9ktgluOxmw9Xce0C06CnDvM/rktqXEVPUijzlR9iwgxcEDvFZIm/3npzUBdBR6JmcDgHIxJ2A6nrr8B3vt+UZLAbDt+IXymRk1xacegSkgyx0MPaCqdI8HzkNUo2d7xy18oTZiO2wMnqietbCmLLyuuG23GMwAYgo4Bx0QO0RdunIKdmjFGoFb/lTvmTzXSAy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rx6QKFweFDIRg1D+cOWxtHlOu4XzCaGb8IOgSib5JM=;
 b=jFaeXoMbkkP9468jEoV8Zi2t4402uUeMlXJ2/OHUrE4xb1LPOp3Oui46/XOMo1A+Xanp4UZaRQpcdi8vruBF1tROmtc+hJ+wK1nJEiZPg/FiA/+sPR7oxQIFbf0FtHK9vZGEN6LyUJ23rwcXp9T7JdB6ikjKo3aqqzrTGO8/dDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 16:02:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:02:38 +0000
Message-ID: <94af9dab-951d-d426-b8cb-7f313189448f@amd.com>
Date: Tue, 12 Jul 2022 11:02:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: Add a proper DMI match for Precision
 devices
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712155936.1700339-1-Rodrigo.Siqueira@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220712155936.1700339-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0111.namprd11.prod.outlook.com
 (2603:10b6:806:d1::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d2ab6e-8584-4b76-e836-08da641ff1b0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OAJPQWScseCPaIll7+i9vQ+D2FbNHtnngR9mWUnOG5CUDUU1RmYrqh3Mwy3M2qf8WRM3szXL5c7p/nXJDZuBpzs0rhdNL/dn9fwGiqWvh1WVC+aYKZwa3lM1of54IAY7sc23RNTmL6wvWTdlZ0g9T6SE6hZMdE8vhWv7irO++2YaIqdd7Zidk0EYAC/wCShfPE5kPvS1/qr0eA6dYaKj5oQ3YQkvpfu5LzAPIK52zjmzboTe47WV4qvdXiNjQD9Fd/uK6YgP575NBsQTvi+YflBaW/gevgPFykNIvEBfNc38ceBiEBIwNXfF9n/4oOwtgwoPLB8eQ66pztRoIKyOeAn052pjkhK63jt+DCrV8Gutle0FoR00llMEt4zZFelxZ+Pprga5c7AE0xEKGp9JnDlaTS8RRQvjx3qRErUf8suxvJfPUa4Tz1MHkhh0n3+rg/wHwnPCjSoKyfbx/tviHWllURAnVMYkdrPCcMGEjYFsiSVovkTrNNchbxZdJEQZTvAwgyeJDPdskmUpHF9eHGQJASfPPtM/SK9QGwn5SOiI8huYp4LIAGY+1iX8tCYg4NkZR0z5c6IQ/HVRq0swQhqoV/ZvQ8Ytdrzie+m/EbI2g3hOtiM9HheHEgPYWX2rnN6b2UqT/1az22u9104iq8oE8UWnXgBQdPazH3yL2ZvoMs9Je1mXVDFMUmbRPdx0QTqOUawyRVt+uIk3p1ZP5oH32hmXr5L3k/bgLP0pgEibJazoTABunjg/gz9A9Pqwpg4kifxgviW9r0x/iHV14uE7q4uehKFHYe4rZpJAmBCFZi878D8spLPcyznLRnvQtmiuVrVCaVsLdnBOnMVVXXhALllCSGHrI9MprSVEz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(6512007)(26005)(41300700001)(2906002)(6506007)(478600001)(86362001)(6486002)(53546011)(31696002)(5660300002)(8936002)(2616005)(38100700002)(83380400001)(186003)(4326008)(66946007)(316002)(66556008)(66476007)(54906003)(8676002)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJyeXBrTGIvbVpEOGJPRThEaml0WHNFVVN4MEk0ODF0eXVINTVYR0dQTkFk?=
 =?utf-8?B?TUpPYk03a0pwS2ljQmNTa0tlM1cxS0JJcWxXM2RhWlhSaWV0WTlkdXgwOWhP?=
 =?utf-8?B?UWpPSEMzUUVCZTkrZ1o3bFJ5a1JZTDVYRE1mejBtSzBoTDhKWjZGUzJCN09Y?=
 =?utf-8?B?RTVGcHk0dlZEbnZic2VKZVF3TnAwRHFaK1dZREZoU0szakRaYU1GNUJDNFB6?=
 =?utf-8?B?UkdEZXcya0x0N2M5Q09DVWxOVk4vdlZRTHQ2TDc1R3JzSDJmWnNacmtCdVRK?=
 =?utf-8?B?aHVYajV1S2h2bXdxQThwSTZjZXN2TDVaU2c3TXFBYW0rRm1oVi9TV0hoaUY5?=
 =?utf-8?B?eDNYQ054OTNYMnF0WnBSSW41Qkt1dko1NTNlZUVGanlqVTV0TnVMd0ltaFht?=
 =?utf-8?B?REpZV3N4Ri9ua0ZOMlM3UjI4VHhlM0w0NTJhYWpQeDNsUmVxaVIyZ1pYUnBH?=
 =?utf-8?B?Zk1Id2MrVkhLUFdDVFNPVjZSR1JJRFlmbnRjY0cveFVIRm4xTGdWQWVlcjMw?=
 =?utf-8?B?cGdyMXprVEs5WlRhNmkvTkZ1Tkk1Tk5CRHM5Q0JMeEZqUkVueDVJVjNrSkto?=
 =?utf-8?B?M09WVlVUMGpSQTlFbnlEL3pQem9naXNVVVlnVGdvby9LWHJwT3dVYzRvd1Iw?=
 =?utf-8?B?cndVbXpqMTVHTkl1RGFnU2NXWUhXZ25RZi8rU1R4K1FELzRWOS91SU1sLzNh?=
 =?utf-8?B?NmI3ZDRBOVF1VGU1RXYvZWVZdVc5U1pkdEE4NUgwNzV0blFXczBMRGRVQWcx?=
 =?utf-8?B?ZkRJbFFid0NjY2MwYmE4aTNWdG1XTVRsbXpBM20waVZhRGtLcGJXUlEyVTZE?=
 =?utf-8?B?S3RHZ1JNREhkT2NPdjVscURBby9QYThCUWR3ajk3cjlhQzZnNVJxRU5ibEcy?=
 =?utf-8?B?bWxBQXZDdnZ0bHUrYkpEdW00ZXdhcG9ySlhOQnFoTWVmaEZMMTNrVlZGOFFR?=
 =?utf-8?B?RGwrM0Y4Lzd6eStxV0FHYW1iV1RYY0J6dHlCM1BXbXhTMVphV1FLVk5nL05q?=
 =?utf-8?B?Q1FmQUxqOTFaY0lVRWllOERQbTNiVWNMVlR4L2RIU0tydGNpNGhoY0JINjlQ?=
 =?utf-8?B?Nmt4UDZpQ1lCK3pBREM0eFRpN1czb084cGxQOXVzYm82VmZUbkUrOWp6Ty8z?=
 =?utf-8?B?WWdYY3lzQkpzeit2aytCc25PN3B6N0tkSnhwSlJCbHdFUVNqa1FOWnVoeW50?=
 =?utf-8?B?M3JzdzBKelYxSGExUHEwNStjZHZLTDl3ZGZzQ3REc2JBaGZVQ2JhN2pkL3RG?=
 =?utf-8?B?N0padXVuYVRtRWU5ZnphamdtU2ZKMWVUNVU5Y2puVlB0TENGRWRJV0NXRDFk?=
 =?utf-8?B?SFhjRXlzMUVlNXF4T2NqZ0hSa2RVYlpkSWxyeW5ZUnRJZXJvRnhnOUpHNEtO?=
 =?utf-8?B?UEhETk5jVWRmdUM0WmFNSkdBTTlILzNLcWV0OElySTU1WHhLbWpRWjd0VEpv?=
 =?utf-8?B?bDZxbUd0VjdtSWhjOFNDMVVFZW5xcitzODdKd0l4a28yeXVmVlF4VUsyL2Jl?=
 =?utf-8?B?S1dGVk8xbDBxYlpJTHJhOXJWemJUMVc2NVRDMVBndWlpVTNTZUJZRHo3TWcy?=
 =?utf-8?B?QTBmQVZaSWV1bUpTR2tqTnRFRG9LT2J4aVRjWGFDTXQ4R2ZNdzY0bDRtTTg2?=
 =?utf-8?B?UVpxdlRYZU00N2hPaHZFYVhPSDdja3VtMjY3ZXo4cVk4MGJyZ2llbnA0RG9X?=
 =?utf-8?B?ZUswSnNEcFdFQzhkYUx1dTNqZzNWMEtmY1pIODU0RytsWHFJbEZZWjhXeDJW?=
 =?utf-8?B?MGRFUDZ6citVYmJYZU52Y3ZQaEJXUjZ3clNJUlEzb2IxTXVkeG5sbW9FdUJt?=
 =?utf-8?B?YUVRQTRyelB4Q1Nqek1WM0kycGs1OWFZQjlza0ExdTU3TC84OXVwM3dLd21x?=
 =?utf-8?B?SkVob2JWakROM0grTFdkaktMNGNuWXhmamw3ZXJKTzVHMWdJL04xZXBpcHhk?=
 =?utf-8?B?SGFhSXBwekpMZmVkTUZ1M2loL25Wd214WGt5M0VNQXlUK25iUFhBOXozNU11?=
 =?utf-8?B?TENSc0hiejNYZjZTMm5uNWtSVnVESWFGUzdhaDJVRmpjY3F1UjhZeGRPL0sz?=
 =?utf-8?B?R2lHS1BSQVBqdUVpUjBDRnhBWHJHbW56S3hLZEhnaUlPK2g2d1p5VEJPcStL?=
 =?utf-8?Q?q2gE3g3L/sqaht4OgocOoeQ7k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d2ab6e-8584-4b76-e836-08da641ff1b0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:02:38.9262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+zl+myQY0uMisPLhcjJcUc3ZnfOyWhYcthgxlVSw30c5UN162CxWsPhuCfAV0bJyfd14rRyNc/MFpirnyQNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
Cc: Qian Fu <Qian.Fu@dell.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jerry Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/12/2022 10:59, Rodrigo Siqueira wrote:
> We had an MST fix for some DELL devices that got merged, but we missed
> other products. This commit adds the other missing Precision devices.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Qian Fu <Qian.Fu@dell.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Fixes: 9fcd8af669d7 ("drm/amd/display: Ignore First MST Sideband Message Return Error")
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e203d75834de..96a0be8508ce 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1408,6 +1408,18 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
>   		},
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
> +	},

Just a nit here, the "}," should be indented one tab to the right.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
> +		},
> +	},
>   	{}
>   };
>   

