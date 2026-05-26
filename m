Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA128CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 21:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6BA10E53E;
	Tue, 26 May 2026 21:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXAmKdQh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5D910E53E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 21:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyfaZsfN7xSRSm7G/CEueuKrR+gQ2wy/RtFuXaAdtQBS0MftZmdWFWwYL9Jy/k429X6qNw1OPEznXvaWa77Wys2HZRTzHvKjMIaT5S1KWGUUttNU2dzszlJKqShr7zGN4bCFUS9ujHJaLs/zTj4sTvqLSXWLglLclzgpFByc2iJNEV6jjRjUEm5OISoOqouXn7N7441xXql6XgmL6bdWOSssbseoCHb8jnLLjbWwhAZpk0Pki6ol0W0I18nawvj+lkQQijdFdFMZyDFo6lWIbzmot9eWTRxGpt6DZPucr/RD/moZL/C23nSkmLBnEDDrBhRel4fkgINFpHbCKLzmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7fKg9jaXB5dRDHUTjVFDxCeTO/B+7tSbJTasHe3V+A=;
 b=H1MXhkmi09RLqsurqdXZQZUb6IYE/kgK4ezkom4q6nnzcHJZ8Qmxa3rA8EofjduGurcArHubV0XGPHNwnvymnvqDdpHlp5YDRfSCdzWWAN8qRURpAGdrx2gAm1yPLe4mJJQqlBTsLacULvEICHZWwJpyo2g1fHU8yE2hvWVsdPHf/loChxli10dUlF020B1CVE80qPvm4DuD/xGXHWQfQtmLYT6joT0u9yT1seArL6N08R7+tzdGC+M8vUCgsz/9OFVIou/MBlDtrU0pYFcvNpq0t7bMX8QezyDPdrUc9AO0Y9EMqMZ23L9l310MLnCh7s8Ar63zBKKVltsB0cDTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7fKg9jaXB5dRDHUTjVFDxCeTO/B+7tSbJTasHe3V+A=;
 b=qXAmKdQhN8n9lsD5hey+6BNF41l+nVlO4cXRhUEsMEo8Qqh+tYi8UeFRX6qz71llsciL+sYECl9hME2N2/e4RKr1lg2MVFnJJPIRFMF791onJreAiiM/PAbQYR1MeNpMe/wEsCtIZTPUr7qJnb49BhEaNrjuh/7l23cLqdfZG+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:00:19 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:00:18 +0000
Message-ID: <207d45ad-623c-448c-b20d-5612953b5a05@amd.com>
Date: Tue, 26 May 2026 17:00:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/42] drm/amdkfd: split out mes queue reset sequence into
 standalone function
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sunil.khatri@amd.com, Jesse.Zhang@amd.com,
 Shaoyun.Liu@amd.com
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-35-alexander.deucher@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260522002048.98506-35-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5952e8-0a42-48a0-419c-08debb69cb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: R7epzdxmOBw6mfDCApOhFDh7TWyt4F58nahUYlnflwnEr3yHYwg1E+WUq+JCzWqzrRXzC9F1GIsYTg/AYiXjOs/9IQ/30ULEjBpJWpoNEJ+dOWY+zvvobWFniQvFqUWE0tyS1NQc+t43d67x0JqnJ72z2WIQbtABzlIyx+qGoMJS+4jpYq3MBnle5t4hVXJNutZY5WE64W8mVvvQw5giyABQrirZWSR5oGP9FMC0z/U5vcXa7pv3UHfP/QNUVYFbmqct4QfdlouhvGEZJvGkwJVfCKrh0eBTNi8DOZtlB5ywllgw5AxZMXXItg2mfdF95Ioj7zrT55lAfSH/WFh4tEFZ4IGsBYYBF0qKHpaGBmZObpA5cVSARyyjtE9MnpqKNyR9tCJDgl1H7bEzE1ZMF430DE0bDXSgf2exhfQ7Kj+tz/q8vMrgcz2tWWEGOQh6qa0mBd8PdbBIQIFS/QeIezyxC0vuXmZsAT1xDRc5sk8zuP2Vln0z+hWuSGIP7zNej+NmXKqKLuBBQRj5NHU5p2Z7+0BQxe8Y78DKhx6S0vuChkiaTiRS/tMZ2E/vdQiFJ5qHuknZhEAszcg2E3yfdsMJPNZ3pNUmZ06EbiplI6pW0zEJfgz7FZUxebyT/9yoBydx0M8ohUf6BlmFOXkponW+9FecGo4YvUxI0GRRP1/fkXwLLNgImh7S8S5vBC+G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5qWW5SamhUZjQ2a0d1cG5la2pIbDNnS2x5N1VvTG5HRFRTVlRodGh4bmRC?=
 =?utf-8?B?R3lWLzZ6NFE2UWtVYm9IekV3ZEtCTjZ2N0lXbHozZ2hrcFRqTnN6dmJTbGNS?=
 =?utf-8?B?VjR1Ti9CaFRFZzdvencwYjYwKzlSbFl0aEpTdVVha1pmWDBFWGszMmx0cis1?=
 =?utf-8?B?YjRlaXpUZEEwN3FTSmtnM1VYTUhsMCtueDRyeVFRZS9MenQ3M0sxbnhNWnR4?=
 =?utf-8?B?NC9VUU5JTzhvRmE2cUVJTFExNEJoL2RIV2NtZFFyUTdCU1NXRHdpTGo0K0pC?=
 =?utf-8?B?TjYwenkrUzk4OEFJbUlNYzJ5Vkk3UktOK0Z6aFFkZlVOb0pxWWwyaFV3enM1?=
 =?utf-8?B?RGNmV2R4aWd3VktwSEN1YlA1RG52dGtnWE1JTjNXclEwRlJiTmhyYmZLbWsx?=
 =?utf-8?B?VnJwZHBjUkdkVlhUeG9YTkR4b00rVFp4dys5Q3hLWkpYRkJUOXVHUS9QQ3BX?=
 =?utf-8?B?Y0pkS0VUcTVnNU9Td1hSaTlqOEk4TVFqYUo3SHEyUUZzSVhlYWpxTkltbnIr?=
 =?utf-8?B?dmpJbGh1azBkZTc3SWlFcmkwVGtMY2YxRHlQOURYUDRsamwvWmY5Ty9ZMGM0?=
 =?utf-8?B?cWduUkFGdnFrbUVMZFdGUjlXVUlIbkZGMHdFT2w2K09ydkNFN2NIZE1sb3Y2?=
 =?utf-8?B?Qk8wN3hlSjVGQ0o0cDgrWHBESW8zekFnNlZQMXpvcE9sRHJoVFlIWjdWOFY2?=
 =?utf-8?B?Y000NU5PdXVjNC9KNzRYeU9yeFBxaDlHWFY3WFlqUzl1VnpJbzNaeW9iSjFY?=
 =?utf-8?B?RzVqUWJocmp6VnRzNURYVmRIc1I5bWxMTTVGdHdqb3lUY1RUb0dkZC93Tlgv?=
 =?utf-8?B?Uk9uUmFjblpGdEpVU3FlS2dmbU8zUkZBRzkzRUZFdjVDdnczc2YxNkdDU1Ra?=
 =?utf-8?B?Znp6d1ZYd2RUWklEam5xKytKeWk0VzByUmViQ0FGclUzWm9QSTlrMU81bzkw?=
 =?utf-8?B?eWFkZFF0djFSNXZYV3gxU0JqSDd0aWJkN21JdlV3UnlzTmZSWGIvaWI3VU9U?=
 =?utf-8?B?N0pXdkcrTTY3YW1yTVNKNzNMS1FXZFplVDkxTnVVRnZFSFkxMkhnbkRQM1pN?=
 =?utf-8?B?alVLMjNERE5Jck9iNms1clY2ZVFXcnJwUVBJK3pGYmErckhsSk9QSTNhbUFz?=
 =?utf-8?B?Y2F0ak9vbHJERitseEMwOGI3SGNMUi9YMWJWdDJIQzBhTzJjNW05QTFIZ2p2?=
 =?utf-8?B?ejdrTVpvVjRCemY3VFVucEM4b2xDYmFoS0VCMFZHRnpmemptMTFyWE9OTUlk?=
 =?utf-8?B?VjlSY1ZqTURzc29Yd0Ixemhnc1doZFdTOVJKM0NyNncrQVcxczVlbDVIbWdB?=
 =?utf-8?B?R0pHTWZvQW9iMXFNYzk2SHJrR200OE4yZmUyTExZUFlhNGNvdGFNQWM3cTNF?=
 =?utf-8?B?Z1FkWlZ5aTdnTHNkTXZEQlNvQVhCNVAyY3Q2bkU5NGxTeWdiSDZZQVVCZlkr?=
 =?utf-8?B?c2t0Sml0Wnh4ZnpRZEFWZXdXamhweVFlQnhGRzkxYlRHZTFtS0VQSDhMVTda?=
 =?utf-8?B?OXhGVnRiekxQVzNDNG9VUWtVOEVwb3E3amRWOVhJN0YvbkRQaG8vYmtMbTdo?=
 =?utf-8?B?enI4Q2ZWM1ZVVkk0SENPSUJHTW1ldnB0M05SakdaZ1JVS3VGMmx6OVdKRndV?=
 =?utf-8?B?OVExaitidGg2Z0o5SytSWWorZzV1ck94RjM3bDVHNzdvNnBBblJOUkNGcU96?=
 =?utf-8?B?UlFnWUdoaStFVlNyRjJ0YUkvVjJnQ3NCUkxxSUFOd3ZhY0tUTFlpK0k1MmFW?=
 =?utf-8?B?RVFRY0Z4eEU0WjNLTmpvQ3ZaRG95NVlxODFzalBMdFUwa0xoNG1iUCtBRWZD?=
 =?utf-8?B?RFRIREp5WGNNSmhwREMyWlBkZjc5TUNPVi9XTThtcjQwaGNTWnlrWktreEQr?=
 =?utf-8?B?Mm9rbnI0ODJiVEs2d0hOclhKS3czVnBlTUZSckc2UktUMDlRNVRTOG56dVJs?=
 =?utf-8?B?ZGFNbzViMTRjZ0ZIaUVtMXFYM1JGRllNbnNTVXYydHdDQmM4RzVoaWpaSDJO?=
 =?utf-8?B?K2k1QzFQbzJnZEdRaC9rRXZQOWc1TmFvTnpVZU5uQ3NJeGp2Zk5rbWw2RUY3?=
 =?utf-8?B?NU1pSkNuY2lNTWk3cEpwZ1IydnpFaUtUTVpKenZRNGdHM0lySnYzRG4xMXJt?=
 =?utf-8?B?Y1FPYXJVQUlleEdIc0ZLUGpwM2JOeG5QOVBaTmFBdXhyUzVKK3FVZmROYmNm?=
 =?utf-8?B?TDgzdEtCZWFkcnZSVHJPWmZ3ZzFuZlhEdC93YjJ5RC9vVDZWcDRGMXN0ZW1O?=
 =?utf-8?B?UGo0ZEpPT1dMS3AvdmtRUkVPdUhxb1h1TmtISTNJSFoyL2Y1Nkd1VG9vSWVv?=
 =?utf-8?Q?bhQa6S51ze+ufT7rjV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5952e8-0a42-48a0-419c-08debb69cb1e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:00:18.8588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJMLkiK+Jk5q+jkQAOWwcP0aWuywgpX6ra8SPmG1LMqXwd1483mhWPo3uJN2k7lZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

On 5/21/26 20:20, Alex Deucher wrote:
> No intended functional change.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 48 ++++++++++++-------
>   1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e323658f972cd..0a59a79ee28be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -407,6 +407,32 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
> +			   int queue_type, int pipe, int queue, unsigned int db)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	struct kfd_process_device *pdd;
> +	bool use_mmio = false;
> +	int r;
> +
> +	pdd = kfd_get_process_device_data(q->device, q->process);
> +	if (!pdd)
> +		return -ENODEV;
> +
> +	if (use_mmio)
> +		r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue,
> +						ffs(dqm->dev->xcc_mask) - 1);
> +	else
> +		r = amdgpu_mes_reset_user_queue(adev, queue_type, db,
> +						ffs(dqm->dev->xcc_mask) - 1);
> +	if (r)
> +		return r;
> +	/* Proceed remove_queue with reset=true */
> +	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
> +	set_queue_as_reset(dqm, q, &pdd->qpd);
> +	return 0;
> +}
> +
>   static int reset_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> @@ -414,7 +440,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
>   	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
>   	u32 *hung_array = dqm->hung_db_array;
>   	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
> -	struct kfd_process_device *pdd;
>   	struct queue *q;
>   
>   	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
> @@ -468,24 +493,13 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
>   
>   		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
>   		/* skip queues not owned by KFD */
> -		if (!q)
> +		if (!q) {
>   			continue;
> -
> -		pdd = kfd_get_process_device_data(q->device, q->process);
> -		if (!pdd) {
> -			r = -ENODEV;
> -			goto fail;
> +		} else {
> +			r = reset_queue_mes(dqm, q, queue_type, pipe, queue, hung_array[i]);
> +			if (r)
> +				goto fail;
>   		}
> -
> -		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
> -				hung_array[i], pipe, queue, queue_type);
> -		r = amdgpu_mes_reset_user_queue(adev, queue_type, hung_array[i],
> -						ffs(dqm->dev->xcc_mask) - 1);
> -		if (r)
> -			goto fail;
> -		/* Proceed remove_queue with reset=true */
> -		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
> -		set_queue_as_reset(dqm, q, &pdd->qpd);
>   	}
>   
>   	dqm->detect_hang_count = num_hung;

-- 
Regards,
Amber

