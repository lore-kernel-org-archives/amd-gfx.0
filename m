Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3092BC7EE29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3410E76E;
	Thu, 25 May 2023 21:15:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19610E76E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 21:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T28jS/At91Qw8CHUQexkAGBS+qboOLOfeQDtUtLcwi/lO/FR8FajmlkclTyIi94BtvNOXatlIpwzcKNUr/y1rmasSVtMHMUtVRsjHfNFiNTOVZ0DMUrw/xdqCITWaOHm0SBfH0h+wSK+MqtdYgpAh4zVF9Qce+V95aGAfH/suoZ8y0K8y6B4l0MIFc2MJ9RFIVnl+HoQSQidf/HMyj1706BZ+cNNRjeLScGMyk9WwbHLTudQ6DNZlYNJ/3IMsfvh5Tp81w5NFkRCHKRJOVxjfqV9zC7QRQPal9TKHsluNYbNsmduc+wDMiRO6J2Sv7IfMoK2auhbgfzrXEcRIlvv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxFxBUrd6dcqH3P5Bf58SFBm57mF7BudqxydfICEjI4=;
 b=ThvtvfupeKZZt98VoDESDgQaUVkKGjeBNTBa6vQj0AA67YXDfjevRgakdcIhMGjN+vqrlGkNOHT+Qbyge53C1XdFnPkr93tC1bXpP0CScn6hU1NLkhRV9r8ZRQ6Hfox/0oVUrGQNLiTv0F6R/9lyN4boMulBzVUAttMA9x992NiSl+y4McTeGSCcIBZh2fHvnWwX1Hv1oJB53ZMc/QV2GBwf8MxW3ocO+JYhbeY6rs+1yBUqJO2BzoCLb6qZEhYZKgxAOnfo5sqOKzE7FUxeIPfIQ5ubhFebNhDe0K3k3p4XfGBPc1oINe2k9Mb0AMUal51DOerTjBKqOyJiKdzE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxFxBUrd6dcqH3P5Bf58SFBm57mF7BudqxydfICEjI4=;
 b=lQkzpK4zyXKXadhCCUtYfWbwjdUEmq5zwOz3rOmONp0qlNkrK5xFfrXtl74a4e1WCp9NAd0P2Z0bdXp/zHwOT1EVggcF4m/CbikQMt9yvXobP1zB1e/StsevNcVQeaS+is0qDthDh5jYMVQpJompHatpwwR4CKiwCwxPsAiuL5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Thu, 25 May 2023 21:15:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 21:15:33 +0000
Message-ID: <5f75618e-ed88-24b5-dc03-1e209c4e5936@amd.com>
Date: Thu, 25 May 2023 17:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix gfx_target_version for certain 11.0.3
 devices
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230525201234.1138937-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230525201234.1138937-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: b873ed28-7ef4-4eaf-ec98-08db5d652d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtUroZ+qpBwOeBxfL2JWttZtK4vIWvBKYFYsiyb1g9XsEhO1IJKKpmRyZweLWf7qJYAb5ORYISJknzOJL3S9IvDW3ZaoSb7kzrLdRKgHreOOck+bufCc7tnXNx+LjOpTcuC7u2O+fYfaOrNVoNJCmJUgudus+0kJMmfT9cGjkzxqdgJDS8IUKpAZDDEaZU1Ul6k/X4KQajXmUCT44FW6+/nThEQgYCaJONVy/J0eaPNewmXAgCb9czJF85kUuOBgzxqrx4EVT0meDxRXxaJcUHePyPoNBAKPI+hUecVQbXzeOWZsjq6vnK5QsHofwItnDJLs7B6LeB/rkWmGicydsyURS3UK6D99AGuXQ8G1V00CSCwgL1wj6RFaXqsRu/ynSm4JyXBiknfOKZMuFrz90xeld8Z9HsAsoWkX2b5Ngt/rQ0LZDQ4JtGmd3AUagLD6ur/1SdNl9aaQfLDX47pL5EC3BUwaGUyFOyA5yDOuR013HF3F3sW3b48FcRZ7VQEofqz2OCDbG5cUghXuZfoLX3z5gChCIGIPnx+FgckIC5JvgXZNFbCTbpfAAB8jMDpR8V9OdmlgPagyFwQYHXCokqov9LETo6FwbI3QNUP7T3dNWRl0/nrUfgnMtD/PynacxgTHVvsaUNLM1/Wc6mWwJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(8676002)(8936002)(86362001)(31696002)(53546011)(6512007)(36756003)(26005)(6506007)(2616005)(83380400001)(44832011)(2906002)(5660300002)(186003)(66946007)(66476007)(66556008)(31686004)(478600001)(316002)(36916002)(38100700002)(6486002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJXTUVKUjQxVVdWVnQ4dnkxeFlEUndvSm01dFZveSswNlJlRXF6QXFjZnk5?=
 =?utf-8?B?Ykk4N1pBTmJWZm9QNGtrSU8yZWthNVUwSUlpcDRnLzVlK1lCR0NFWng4T05r?=
 =?utf-8?B?M0l2enZqMFZQZ0R5cGFvK0lqd3phSGMybit4QmhaaEMvSVN2RnB2cnZ1UEJl?=
 =?utf-8?B?U3VsRFUrcXZDNDVJbHlpTHplM3dxTG83amQ1S0cxUlk2aW9SeFlhcTdJWE9F?=
 =?utf-8?B?eDRGU1NyMEtpdGxVYkZNNDUrTVhCM2Nab2l1ZDd4NGtKOFRlODhuUXlORnU5?=
 =?utf-8?B?Q2ZQWlJIdjVtOTJFdndCelo3Wms0OXhycWJ6aWFXZ2RHTXY0MmswWVRoR1ps?=
 =?utf-8?B?RG1PS1hIdmJCU0NTS29idThyMWRNdVRKcTl2eldrUG1LN0MxNVFpa0JnYS9M?=
 =?utf-8?B?TlRZSjRDUFNxd29sMmpHcFNLZ1NjbG9GamF0SjhaeGdsbXV2YWcyS1oyN0w3?=
 =?utf-8?B?VVFuczNCV1VsTDJBV0RZNS9vS3pkZ3VFbGQ4RzF2UUYxSEIrbHhjRjBwV1pT?=
 =?utf-8?B?a2FzQkhlUzFiSXhnWVFSVEJqRHZmODM1MUtHTXRjUkVKeE5JQktzUDRBejFt?=
 =?utf-8?B?MHUxOWVOTTA1RHFROFhyY2dOYllGQ3k3Nk5UWjFqWnI4S2drL3NXRGNNQ1lJ?=
 =?utf-8?B?Si9CS3NKLzJiNU9FQjViRHN3Nmc4L1NFaVViRHdOaExOR1BJeUFTRzlDMm12?=
 =?utf-8?B?aGtUb0lrWktDNGhSM2NmRHZSTEFNMlNWeXNkbnhlNnBOc0VObDlQemNtN1M3?=
 =?utf-8?B?UXJBU0RZa0RSVzZseWFYVnoxU0xOSVJGSjVKTS9uTFdTMW5Dc3JEUmZIUERE?=
 =?utf-8?B?NUFUZHV1N0pudjRCRytadlRxTWNEV2ZsMHNpWUQxQlVuVzhUalFEOER2KzVv?=
 =?utf-8?B?WmxVOSttVldUcXZaRWNZWDgxUVFiZWhXSnFIaTBNRHJPRlhuWFZ0Sk5CUU1m?=
 =?utf-8?B?T2tQcE9samtLSWVqemxQVXFETTQ3dHZDcTQrR2d6aWpFT0FrdG5DNU1udXBX?=
 =?utf-8?B?UTFPVW1odW94NVY0a2xmM1F0S0plek1PR2sxTDNHVW9UV1I1R3BlZHVvVEhH?=
 =?utf-8?B?LzFYcW5GSThqM3lkamxMZnR5emt1ck1BZis0VG5Ucno4bG1sNUowNHpCdU02?=
 =?utf-8?B?bGFGS2ZtanR5Y0RhbmcxZ2Q1cXJhbUVqcEhNQzZhN1IraHIvbC9sV1FUZjZQ?=
 =?utf-8?B?ZlVvelZrSlRtb2wwaFc2Sm54U2RXWU94dElxSkFMa2lxdExqd3gzcDdlSmd3?=
 =?utf-8?B?ZEU5YXY0dHFZYTdpV05zRkh4cVhmbDhGMTVpaUZTckxoS0JqNmU3ME1OaFFx?=
 =?utf-8?B?Y05ML0J4TXBJcnJuK2dwS2FOUTAzVTdtS3JvK1VEd2JGZFlOK2Z1VFlaL1hx?=
 =?utf-8?B?aytRenAwemhRZ21uTlNpLzhrVENmWmxaNGV6VXhUTDhQTS9hTG9JNFRPamUx?=
 =?utf-8?B?S01SNlB4dy9xc2xOVjc0YUFrRkVhazlLK1hBZ0tVWUpxSmxuSHRMbWZBNkNP?=
 =?utf-8?B?YjNpYS9CRWowNHd3by95WEE5aE5ST1Q3bjJ2VlBUbU4vZGNycHdER1dKczFK?=
 =?utf-8?B?Ni9aS2dSa3UzRDhNTTNuenVrUWVNeTNIS0Y2bzNHZlFxVkp0aTE5NXF4NVZt?=
 =?utf-8?B?bnEzQ3FsRFN0QXUwVWVLYU9TVjlSVWN0TlA4V1JRUUlxTzFXVStFTkZGeWda?=
 =?utf-8?B?NGhEOGxLZWtOUWJzUnpqdHNIOWM2YThRQ1Y1MkMvQjQzN3dqcVpER3V4VzBF?=
 =?utf-8?B?TXBTQ04vUFYrcVpmNE83dUdKcDdYTFRKNFl0RGs4eEV3Q3E5dnZ5TzBDWXN5?=
 =?utf-8?B?emZsWXY5YWZlZTFkNmpMcWtiSkF4b0txL29yT3lKamdtVDRlN2xXanl0TEo4?=
 =?utf-8?B?M2VqTW5WcWpTbStodlVrdGRtVEJ5YVZmY3Z0dVlDVkxNeGNaZVhWZEpNZkNq?=
 =?utf-8?B?UGZXOEZFUDd1WXJwU2NsVEVUSjcyMTZuckNpbmZPUGh2WDJ5UkYyMUZCeHQ2?=
 =?utf-8?B?RG90TlY5SUxiYlk4cGNraWp2K2JDQ2Y5aHBqYk9YVzdOd3M5bTBlK0t1Rlpz?=
 =?utf-8?B?RDcxaytWOWp6RGJjNXJMMllyMnRSOEo2c0x2d010azRqMFpKd21DbldDdlUx?=
 =?utf-8?Q?7NTydcXZIYWBMvLAzs8qujZAg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b873ed28-7ef4-4eaf-ec98-08db5d652d29
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 21:15:33.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJFakojHp20kkXc/FArY1h17lRXj3B3FLI0oZ82eJ2AUgC5HmZGDQ5cZtqkio67bCewtxkORys2g3XHJsVNtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

On 2023-05-25 16:12, Alex Deucher wrote:
> Certain boards with GC IP 11.0.3 need slightly different handling
> in the shader compiler due to board specific bounding box
> optimizations.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 862a50f7b490..ebc3c3f965f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -411,8 +411,15 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
>   		case IP_VERSION(11, 0, 3):
> -			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
> -			gfx_target_version = 110001;
> +			if ((adev->pdev->device == 0x7460 &&
> +			     adev->pdev->revision == 0x00) ||
> +			    (adev->pdev->device == 0x7461 &&
> +			     adev->pdev->revision == 0x00))
> +				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
> +				gfx_target_version = 110005;
> +			else
> +				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
> +				gfx_target_version = 110001;
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
>   		default:
