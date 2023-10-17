Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33AECDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 04:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E30610E25C;
	Tue, 17 Oct 2023 04:44:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37EE10E25C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 04:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXpCdZIA0PFFarbgKrKowtzp8iW4u/f3+IDtab+xXnSUQaMgvHbZ7KxzKN7Usz4Wbje5MasPnF+tBVDIwQjE74WBoQb56saQgXHDdN+LU+K0EM3GnaxQhPiGfzq7thaSlmg9y0Rgb/5EfHENpK9r9gldLWRcJu5zIVZCddp86t9eOXF9vfbb7SC7ypiG1E5lmYbK2C0c2PHHe3RIHNxjYw6UR0autEufGZfV6YYl0X3ItEolFQcR+30M6t3o6m7YLvG/wJqQ8PY+JWPtqoUleGdSF0Ph16f4jCZhR754Yz8F9rEUoSRcGvfX3tUBCE8TLWwxIUoHd5EkfZ0XraZgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXjeAP7UFUWK+vcD7ezaNSMcpEDnfoL1jkfDzjLZDVM=;
 b=Kc0uK6iyB0wEmLWv2sik+na2TQi+Uf8kn9fUdc9Py+a2TQbHR62SZGuxqfxGQDfuUTVBPzN1dFjLRDtIiIwVb4J0gFYcm13G8nx6ayWRXXXmy2UUEKMDGcK/RvgmeIWMHJDylj0UU5C6AEAy0YGdCJqqy2E0FXX3Q7WuFF129gPjXcI2/2Jm9BvzTLk1YKSaYwLLl+C+sHE3YKVgTkJWJJe+BekHKf7lOii8iJOQDUlBXsHMLRgYjqTQP72G3PmP1flh23jrJMoJ5ytve9qSBxmP32Oxic1sWxR+YkuUR/BYq6nym5ZKjQxOMd5DsIkarRvh3cxJmSLGEOBEfOANpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXjeAP7UFUWK+vcD7ezaNSMcpEDnfoL1jkfDzjLZDVM=;
 b=mqHJNf2lD29T5Zcf8tqaV072b5LxhXTKmsy4GlcyDVvBxT+sAKRh4k+wwGwzMZudKX8KIzI0z18pknvEpEy+tH0l4qRmy8YEzBUvx3jzaueUWdNXxiFp23M1Y/5FyNdD3S3b8Cg9NUW3/QvksauAbH2vv4iTuHrPn8/hzvSrxbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 04:44:22 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 04:44:22 +0000
Message-ID: <19ba4edb-dc57-1c21-7671-5c666ba0eaff@amd.com>
Date: Tue, 17 Oct 2023 10:14:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amdgpu : Add hive ras recovery check
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231017042810.15675-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231017042810.15675-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dad137-9cad-4092-0631-08dbcecbbb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgI19dM3vgYC06Lft97jVYVEy7KinVV0ZNXvd0LmmHcnZSCUMoAcKj9Gbj8DoljzsI4oiX3zaHnHrTCQUO4dLRlywvtl6/oEe2L5PXCYtKTPcZHnCkVa6jZ3m9f5bTLGD0c6YSK7EymIdlw3pGGWlaV6s1d7k6+DlsxXqAfhuLcX/tD+gctlvMDVH0q0GfjIRuwkZ+CZgJnIwjF30WM5YEqhE8dCf3h9gXENZ2vriXh4+hOvNknqkT4uQG9DpfEzsHq6gRXcDy4oxGAmdYMgCyL7E9jzxozlJIaSrSj6WXHBdT6Grt8AsSbfVbX9IErq7I3udV9kOhPB9xvymPjEB7To4NeL6TavnxYnmFwLzSaQJQ0qetEXBu3GYE2svZkn8+2Xl5EN1fNuGJE5bmySeed7sWo2Bjk4NVqL/7/ilXshdYPG+dwL7ula7lrLYDdo/qfRe60om55Dxe3nsGzn5plJKTyodLeGVKQyVLByu0q+iYD3IWlcoHRGsmpJof2Pn1gSfjMPGVJEZ5ePqz56VwYO80ybnG9B6IYZaLrA8CdSktM4aCcmPWzw4BAvx2GR//P4pPO4C2sSvz6D1NYJ9j9xgqxQ22h68jaKrd7fyHGmr0O37W6HLElq/jCXepzvnW+U/OWGM0qoAfab67tmug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(478600001)(6486002)(66946007)(66556008)(66476007)(6666004)(83380400001)(86362001)(38100700002)(31696002)(2616005)(6512007)(6506007)(26005)(53546011)(41300700001)(36756003)(5660300002)(8936002)(4326008)(316002)(2906002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpGOVJERjc3cVNjQjdxdkVEQW5EMHpvcWtzbkNWdnh5bVB0SHdNMUYxc2Jw?=
 =?utf-8?B?elA1eFFwQUVUdkFtVWoxVGYzaGd1bWRFREdzY0xlNW95VXBEb3pCN2M0NDhY?=
 =?utf-8?B?SFlkNzNaNlFoN2kvYmU3SmFuV3BvRm51OWhhK2lkS09ENVI1a3UzbGY0Vlg4?=
 =?utf-8?B?YkF4dlNxQkloRytFc3o2R3RIM3JOWjNxcityT3Z1RldWdEY3SnBoWkdlUUll?=
 =?utf-8?B?TWlQTmppZTBPMENpcFNhR0o2YXN5VW5SVFZLUEo1blUrU0laeGpuanpxNmo3?=
 =?utf-8?B?NWRQT3JlQmJPUzMvbXc3WFNDblp3dkFOWkNHdnpEazhSb0JoV2hMVFdKQU01?=
 =?utf-8?B?T3p1RXVXZjdwM2VreDFxVGNqMFhhVVJQZFpBUit1QlFZSjk1cFRFRThVY0Np?=
 =?utf-8?B?VjgxWjJzaUoxaDgvaXRWNmtFUlhSNHlLRE81cFYvWUM5TkFqRlRuZ3RIZ3FZ?=
 =?utf-8?B?WldudTBjeUpQS1FseWZxQmZab2tYNDhzdEdFWXAzZTZLaVF3UFhURndsekJ0?=
 =?utf-8?B?NFBHZGRPSWM2bFVtR3IzdVNOUGx5dFN1SWwxaU5Ia1V1YXAvdkUzYUlENXVx?=
 =?utf-8?B?VDJMYzYvaER1VmUwcnNtcFFScHEvTllsbHlITkYxRUg2dnEzS3V4MEdMcnF5?=
 =?utf-8?B?S29nbU5PdnppNmJkK3NweEVtV2JUMU03RUJVSkYrMjQ3OEpCTlp2N1J4RVpo?=
 =?utf-8?B?THYzOGVmaXF3L0ZGejVTRmhxa3lZeThTQ2p2UTlKb3VraEswc3QwSzcvdG9m?=
 =?utf-8?B?dHo0cUF0SFB5MFlQWm5Yc2Zidkh2OTRHc2FEelMwNmFvNzhXRmZJTCtkZ2Vw?=
 =?utf-8?B?ZSsxL1lpdFdrUE9TYlJFc3BSMTFtZ0pacW5WalVaM0ZBak4vQkhLWFZUYUlj?=
 =?utf-8?B?WE81TWxGNjltamdwWVloTnVpdmcvMVNLTm94SXpoZkgxc0RhZnYvMnlqRG5W?=
 =?utf-8?B?eTVPdGo3VDRWdTN5UnVoaHJiblBZbHhsWFNNNWg3bFk5OWRhS3NZRDNGSG1S?=
 =?utf-8?B?ZStaa3AyYXQyd2I1SVhiNUZkTzZYaUY3M3AvK1haang3VTZEOXpXc2JrZ3Bz?=
 =?utf-8?B?ZmZLRGlhYXYrYVZORElkMlQvOWlvUGd0dXA3dDk3Z2lwMDNyRWNUL01TZ05m?=
 =?utf-8?B?cXh0c3RtTXBBOER0cjhwOTVNSEMrT09KRkU3eGFtYjR0bzV0bkc5YUZ1Y1lE?=
 =?utf-8?B?NmRSMWRQdFM4cWl0NTBLREdTTEl0bkRKUnNqc2pzbkVWbE90dG5jOGd1MWUw?=
 =?utf-8?B?YzJOdXM5WlFGM1c1SGJ4cXJiak9CbzY0bGxuR1MxZnAzcmxPVGIxdUxYWTdZ?=
 =?utf-8?B?cXViempUWnNYVmdvdU1oalpNRjJaMkRuU0RtbktZVFhFYTVtQ1Ewcms1QkZo?=
 =?utf-8?B?Ym9ZMXNPbkcvYkJuRlR1cE1kY3l5VnJrcms4NERidnN2bTc4ZVRjWFR3UU1S?=
 =?utf-8?B?bC9Dd0orWWhQdy9nRUhSb3BKOWIreWoxYzdIN2swbVVjbDNJaWxGaHUyd1hz?=
 =?utf-8?B?Y1dXZmdJS2lLckljbFlEb2JWcWcxSC9CQ2x1dWZ3ekVkYnRMV0lYQzhqNTVV?=
 =?utf-8?B?My82blNMRlhBVkNSbHNHTnFyUENCZHN4Zmsvb0JiZkhrOC9jaEVWOGNMOG1V?=
 =?utf-8?B?QXB1SmVucEZieEFSUXI0YTZua0hRSmlFclRySGltdjBjQTVaTnVHQkg1Sm5X?=
 =?utf-8?B?TDJIejkvTzN1WFo1SjkyalpKZS9KTWc1UVZoaDFvUHlsMEFXYnBOVHFFN2tF?=
 =?utf-8?B?WVFzdW54bnMrL1RxWGlXczcxaDdJM3hWUGloWGl3MnpDZkZjM0M5STVwLzVN?=
 =?utf-8?B?SFlCS3hMai81c1Y2RS9PSWVCRzBNaWxHdDF1d0FQRWVvMG9vb2lsb1NWMzBT?=
 =?utf-8?B?SWtwODVhaWdXS00vUkZYQTQwUVFEbGtQVFBkWUwzS1RYY25UdmQ2YThGbjc4?=
 =?utf-8?B?ZCsxNkcreURIL0dRNUhLQlBGUUdVY3VJOWJVSDNKOWd1Mk9odU1wMHFkM0Jt?=
 =?utf-8?B?QWc0dGdsTERPZXE2d0dyMjJvOUFWKzQ2eVZjMTQvUXlLRmxUdzhwZ2d4eEQz?=
 =?utf-8?B?ejlzck9Sb1l3dEJuYzBzdDkveTdwOGpSN0ZQaG1ySVdZMG1mRU93blBaMzhV?=
 =?utf-8?Q?UlxPpD8gZ9FlhWmfZjopmGu+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dad137-9cad-4092-0631-08dbcecbbb35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 04:44:22.1718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otBD/kFbGvJf5KovmtG/6KH+jbbiwJc8xgzwh72sAQ6q5zT59QqGt2DSWWB/Jd1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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
Cc: le.ma@amd.com, tao.zhou1@amd.com, stanley.yang@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/17/2023 9:58 AM, Asad Kamal wrote:
> Add hive ras recovery check and propagate fatal
> error to aids of all sockets in the hive

May be reword it as 'If one of the devices in the hive detects a fatal 
error, need to send ras recovery reset message to PMFW of all devices in 
the hive. For that add a flag in hive to indicate that it's undergoing 
ras recovery'.

One other comment inline.

Series is-

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c              |  9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h             |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 +++++++++-
>   3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5fb57419ef77..029871bfe714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2061,9 +2061,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	struct amdgpu_device *remote_adev = NULL;
>   	struct amdgpu_device *adev = ras->adev;
>   	struct list_head device_list, *device_list_handle =  NULL;
> +	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
>   
> +	if (hive)
> +		atomic_set(&hive->ras_recovery, 1);
>   	if (!ras->disable_ras_err_cnt_harvest) {
> -		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
>   
>   		/* Build list of devices to query RAS related errors */
>   		if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
> @@ -2080,7 +2082,6 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   			amdgpu_ras_log_on_err_counter(remote_adev);
>   		}
>   
> -		amdgpu_put_xgmi_hive(hive);
>   	}
>   
>   	if (amdgpu_device_should_recover_gpu(ras->adev)) {
> @@ -2115,6 +2116,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
>   	}
>   	atomic_set(&ras->in_recovery, 0);
> +	if (hive) {
> +		atomic_set(&hive->ras_recovery, 0);
> +		amdgpu_put_xgmi_hive(hive);
> +	}
>   }
>   
>   /* alloc/realloc bps array */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 86fbf56938f4..6cab882e8061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -44,6 +44,7 @@ struct amdgpu_hive_info {
>   
>   	struct amdgpu_reset_domain *reset_domain;
>   	uint32_t device_remove_count;
> +	atomic_t ras_recovery;
>   };
>   
>   struct amdgpu_pcs_ras_field {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8220bdcbd927..29bb2a3a3cb1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2184,13 +2184,21 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
>   	struct amdgpu_ras *ras;
>   	u32 fatal_err, param;
>   	int ret = 0;
> +	struct amdgpu_hive_info *hive = NULL;
> +	u32 hive_ras_recovery = 0;

Better to keep reverse christmas tree order for the whole set of 
declarations.

Thanks,
Lijo

>   
> +	hive = amdgpu_get_xgmi_hive(adev);
>   	ras = amdgpu_ras_get_context(adev);
>   	fatal_err = 0;
>   	param = SMU_RESET_MODE_1;
>   
> +	if (hive) {
> +		hive_ras_recovery = atomic_read(&hive->ras_recovery);
> +		amdgpu_put_xgmi_hive(hive);
> +	}
> +
>   	/* fatal error triggered by ras, PMFW supports the flag */
> -	if (ras && atomic_read(&ras->in_recovery))
> +	if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
>   		fatal_err = 1;
>   
>   	param |= (fatal_err << 16);
