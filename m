Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E09ED6DDF2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 12:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC1210E854;
	Fri, 15 Nov 2024 12:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEb6P00l";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA37C10E854
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 12:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZKy5k8w7Rn59B5JXK/FNhfz9f+ydzSdZFZLUkd8R7tDI9xBSJ4hgaF4X5z//2aeDisC8NsQi7dK1dTnqN/ZegfZ2/WE5ybKFzxU3mjuzFiXmAe0ONTCK7sPGagPw3gQPtX8equGpfU5IvC8K0kJ5vfTZbkUw+LHZC+LAlt9Lek8o4CPLR5ztnRxRhoiEz50Cq5hEvgMvcmPsP7/tO4+lXhgeMFr8yYiesyEec5bEACE+BOBKVmyHLpOCvDZujamUSqWiwDG15nq1deSD7wCqQMPF8e7lvY8ZVKvSyvwjMFXbOF1K7+14zRQZpV+sKyjPkKIIvmeQ0DU0lMwop1uAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CvpueUNbWK+YMyvHidUMWf806y0zrCjVqGzZCfQQ1k=;
 b=jbDdmXXL9koVdg3fCbcGdf/7Kt0qQijBIOXqZa4CQmObRAHQA1AIbEH5n0Kdpo535MQqKkSOdXaRABomONDCRDzCqBF3Mh/kEHGhMxyaG4FJt5zW+HO0hO0rrgnibtDdU52a6TKFynNzOFRNoK2uc7egHHhp1JMkkSr7XWLgyGzlnfjd42JkKtwEmqsbiMiN6C8RfKBYQU6jEBQx6+X+YKS5LtxLjwimKzMenMYJRfmgFxuN/302KluuTd1MIKBkrzskBj/fIFuXDSGVf0bi84/11D/zSGKC5Sas02iCCKIXUL7CGCXZ21Qfy5WHqARKVo5LbgUqk63kL5RPYa2sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CvpueUNbWK+YMyvHidUMWf806y0zrCjVqGzZCfQQ1k=;
 b=iEb6P00l/K7iFQ3jjPfG0pkNg8KyK1Br7ZVSmkMWMzKv74WNJSmellz9l4yro/xHfyEW2ReiGsZdWFJnMq+cDj6QIYPu0EeaWybSaz3zIXLPY0tZenMg/aXmrW4N2nAZw6t9991sxC+sPENrG4QYHGjcWezkej/n2qvAl/E1jw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 12:08:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 12:08:32 +0000
Message-ID: <729d465d-2e91-4225-bf05-38fc9a13ae7e@amd.com>
Date: Fri, 15 Nov 2024 17:38:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: make sure ring buffer is flushed before
 update wptr
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, christian.koenig@amd.com, philip.yang@amd.com,
 felix.kuehling@amd.com, alexdeucher@gmail.com
References: <20241115095844.1487807-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241115095844.1487807-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 288af297-425d-4ba6-963c-08dd056e3977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXhiR3RDQysrL2J3YzlYMnpLekxpKzRVQThsOEhyeUpEUDA3MVVxdk14WVpJ?=
 =?utf-8?B?d3hQaVRZOWh1WUw4R2duMUpjVmN0YnZIWTNWQU9qTVp3ZWwxQXk5M2NVWHE2?=
 =?utf-8?B?TWdGQjhJV3hPMWxRL2N5cGNSUFFnd1cwdlN4QWpFRFRRZkI0Y0t4SjZFK2xL?=
 =?utf-8?B?WlhXNmhpZVVQRHI4YUgvcU8yQUJnWEh4aUVIeXNubTdSWjZ1Tm9oVmZsWG14?=
 =?utf-8?B?VGN2MnpBQmVybE5BYXVvc2o1MVkrZFc4TE1BQUIzYWVIL0pjRHBHVzVmRXh0?=
 =?utf-8?B?TGRwWG55ZW1oRWxUcTcxTDdhUVNvaE1MMzJ6VGdhejZKZEJESkpVT1dNVmZ1?=
 =?utf-8?B?OVRtcGMvdVhrcUhFcmQwMDZmYXZsNkVXd21PZlhkSisweW5mclNJVkxqSWVE?=
 =?utf-8?B?aEU5SnBUY050Yy9ReEppc0h5c3BZNUhtSGcxVHpmN0hQaml6NGxuZGpPa3Nv?=
 =?utf-8?B?SFZWMW1yc2J4RUJnN3l0MllVSmxUaUdHVTNvQnpvWHRic3puRXpSZUVuWjRP?=
 =?utf-8?B?cUJ2RHhFcVh4K24vQUI1cFFRSUgrVWFUdHJhUmh1YXNZdEJQL01hdlpVQ3lj?=
 =?utf-8?B?MlNCcXJuYnVPbW5URWdJTUpGMDhSdzl3M0NsaTVIakl2QXgxYURWdzduQWx0?=
 =?utf-8?B?dm95QzVsR1c0Q0pCeDkrZlNWM3pGNzF4V3R5N3E5ckdRdTFNbFJ2YkVrV2lm?=
 =?utf-8?B?czFjQXFKWXRBTzVyWDJQRmQydTF6T0pHYlprbjF1N3RNbmNCZjh3YUMzWWo5?=
 =?utf-8?B?VER5YXNxT01JME1VaEI0Z05rcG52eThZeHFaOXVPelo4OUdNTG9ocE1lWWVo?=
 =?utf-8?B?WXlGc3lYZXRHWFBYdWF1dStqeVZRdUdKSmcyZU1xNjIrR1dseEN2cnlzQkxw?=
 =?utf-8?B?SldyckV3VjJrYXE5RXVicmdYV2lUWDVqQWc5NEhwcENYN1VhcEhvL0FtRlhG?=
 =?utf-8?B?YzEwZnpLQlg2NDlKSy9HYnVKNnlUbHp2N0pzd3hDUmppVXorbjJaMGxpTU1T?=
 =?utf-8?B?SThLWmJxQUdCSjNkMEpuMTU2YzY1SjNPWGlEcEJSYnFlU0syaUo0a3R0M0Y5?=
 =?utf-8?B?ZzRxZ3lrZjJkNU5hQ2ZqVzdBQTFWeVZ4dFZtakVsNTRPTHB4SWhPdkpmRGhJ?=
 =?utf-8?B?cHlIV0tQbmViMU9MU1FQRzAyV1d6YVBUYWN2WVFkdkhOMjljWitJUUVSOWEz?=
 =?utf-8?B?UWplU05GM1RaNGtqMEZYQ2pjUkozOXd3cnYwVXhoSEJtTUQzVUZGY3dJTzJI?=
 =?utf-8?B?bjY2cnpMRXJxZEI1L0JGQXhlRmF4NzROcWdhdTE2VXIzelFwcHB0SGhLMDRN?=
 =?utf-8?B?S0tIeloxa1lrVGQ0MDdjbzdneWxZQzJNRUJySk15TWwyRWYxa1pXbGFsUGdW?=
 =?utf-8?B?ZmRiQXNmR3ZyMHpwS0pkM2lnbDdWZU1sTlgwa2VhZCtncGJVa1I5aU5Rc2dJ?=
 =?utf-8?B?eWd0T3daOFgxNzhya1RPbllzeWNOQTVsdTh1WmZWRzRaVjN4VE1LdWxVcFZ1?=
 =?utf-8?B?RnN4OC9TYWJ1SmRzTUpkdnlsNHV3bytXSy9jc0x6c3RvMEg3RDBkVHZoUzAv?=
 =?utf-8?B?dzhDZnRYQXZOK01mS2JwdzJrS04rQ0VNSXpZYUZQNS9nKzBnOVY3ZjdDUmt3?=
 =?utf-8?B?b0NGQXhRQnYvVGp2bVk2SlBwZFpjcngzM1FGQ3BXTWFBTE1iRnZtS0ZjVjlZ?=
 =?utf-8?B?TkZrZElQK2ppUS9SbzNaZzVJMW91Ymw1SWN0QzR5MFIwQXgrcmhTaDMrT1Fo?=
 =?utf-8?Q?2+F9ZsllhVFcxsZG+G9lBDa4EF2zHjPeERVhh2H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVJNGhxem9ybm1iY0k0NFcweFl0dDhzcWZ1WFMzV3RtUGVmQ1JMZlFGOE9W?=
 =?utf-8?B?QlV3ZXNrMkhhdjhXdWJMSkhVbVFmZHh0N2pUSThnN1ZOdGsyOUpYRnNobEV0?=
 =?utf-8?B?ZVFXREhsbStyWGh3bGRRSjFkQzlSeTZiNmVNZ0cvY0wrTXFIblBoOXQxTU9Z?=
 =?utf-8?B?ZXBheVRIMjZZVlRkYmpteWFTeGlzUjI2NGYyTm15OG54OSsyRDhPYTJNYURj?=
 =?utf-8?B?RCtIdTU4OCtDUnZucml6QnIzWjdKWG1scHFaMmVQUElha29nU2VDMWN2MDRy?=
 =?utf-8?B?cUUwQU1rdFF1b3BYOC9rYThacGNscTczSjdFWHVkN0N1N044SkV2alZXKzh3?=
 =?utf-8?B?Y2ZscWpxb1hsRXlOdTcwTjBQbXpKSjAvRDg4WFRqQUgxbVNpWVluZGh0Vmhn?=
 =?utf-8?B?ZkxlRzMrQ051VU9ray9wUXIvSlh5MnFzdS9vaDNvQnd5QjRhZEVPTEQ3ZXF1?=
 =?utf-8?B?cVBINzBpQXdvMnhXTUJnMWY5bFBIeitIMEJONDQxcGZlUWJIQjhyYXBnWi9B?=
 =?utf-8?B?OTUwNWQzb1RJQ0xKR1hhUG5yNkVmSjNtL3ZrZjBnOW96TmVWT2xwWUZiVE10?=
 =?utf-8?B?MWVTMklaZi9rd1I0TW1GZVJkOGM4NDZURjNwcWxNMC9sMDd0eGZjSEFFV3l1?=
 =?utf-8?B?NTdZTzZiZWF2VEdLQVU5NXZ2ajY2Wnd4YTlOcmdOU2l1eE5xNENSODhzN0Zl?=
 =?utf-8?B?SWdlRURSY0NENERBTFkvb29KZURmVVVWTkxncW5BaDVTOVpSZ1Z0dHZxWDhG?=
 =?utf-8?B?VzZ5MHljRWpJVlR3NFQ3MjdHblF5ZmRnWDFNSWJzRHppYkpTY0szOHZMZnRZ?=
 =?utf-8?B?bWFJQXNPdHQzVFRrNE4zbEQ5RzJ0V1NydXlnclRud01BcWg1aUhKQ0ZwWVZ5?=
 =?utf-8?B?SFhYemNkblpxZVBDMnpnQjRReGFwZGgrY0dQek1jNjRCcC80d1cxcVdNOEZ3?=
 =?utf-8?B?SGVxdFpZMFEzbVJhK3p1N1ovdjdZa1JoWC9INGo3ajB4T29KZWlwa3B1N2pa?=
 =?utf-8?B?VU1ZbFNsbEVERWpoT2M5bmlWNmJ0aW1Ja3ZvVXBCZytiR3ZWQks0R2dVeHJt?=
 =?utf-8?B?cWlaeHhQN3dXaHNHKzYyandYMWxhSzFjLy9SZDJNczVQSXIrTEdwbWl5Ny9M?=
 =?utf-8?B?cXEyNXAvcVRZeTlnTGg3Q3dYdTI0RHEwWTEvN3VEWVV2c1dHY2FqUXJ5YlhM?=
 =?utf-8?B?dUFWNDhzek84OHBETVA3Wm52SkVrK1dPSWVaeGdyNm40ZEh0RUFZR3ZiRENJ?=
 =?utf-8?B?VHdOT3ZISTQ3SDdyZTE2Sm43cmMyVVlUQWJRUjFhb1JRNlk1eVduZ2MwU1N4?=
 =?utf-8?B?cEhVM203MXJjV2MvZXlhVnA2WDJSZnlLNEtLS0svQXlVcHltbkZjUS9WRzBT?=
 =?utf-8?B?WnRrcFJGSDNpVTM0ZGNacURWdEtzMEM1eWk0c2Q0eVJSSUpmeU5UNTBwSlJj?=
 =?utf-8?B?WW5aNnR1cmNhc1l0ZnlXRGYydzQwa2RrVktiVTExeXdmNjdWeFRQc0RnN0ti?=
 =?utf-8?B?ZE8rNGwySWR4NFE4TGdOM3JxU3Z0MExyREgvUDNNTDdXRnVVcldqYlhWTDVU?=
 =?utf-8?B?TjM1QlcyNHl3cDRjZ0VkOTRjZm43SGhRemJEalNlUFhGMWh4VjFpVU16UStV?=
 =?utf-8?B?OGtYbXBtQjFZaTB4VDhoK3JiMUF2cXFaNENYV1doRUJkTGlTUllmMWdxSE9K?=
 =?utf-8?B?cFJaQW9YZ3hYaEVLQzNOS3dkR0Q2d2plcldRdXp2cHlDVnY4ZmpJeHRENVVD?=
 =?utf-8?B?N2prUDZqZzV0MVNicG94bnpOc2FzRTRKdkVsT1lxUDl4UlVabzZTTTAvTUda?=
 =?utf-8?B?VFlxdnViVTZRYkFTYjdLVXhueXRFSVlEZTZ6ZTRPMXZCOFNkZFI2UTVqUWEv?=
 =?utf-8?B?cXN0bVFDQzNPNXhOSHhOZE0vcWJEajhQZGxMbXV6VFFsR05wNExUMEpMazQr?=
 =?utf-8?B?Mi9nZjYyZE5ndGk4M1JHRTRQdmI4WTc5Y1hrdzFsNXNvVVIrWG9CSVZ1N2pZ?=
 =?utf-8?B?T2oyRjVHZlMwQU9uK2RDZG8ycEN3LzhFNTBPT0ZWV3BlUzhBajh0dEpSNmRL?=
 =?utf-8?B?a3RnV2N1Ti9wNkRqRGNiMzNEUjE0YmUrQUkxRVJoTEY2SExaZ0Q2N1dSUFFH?=
 =?utf-8?Q?Qo2blU726E/7FIfc+IjRy3D5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288af297-425d-4ba6-963c-08dd056e3977
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:08:32.8805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzlZfzX99oxkfRLHUP9Q7S0wnxnTpAJLkyZCNqHOvv1n7yBE6eINGQf/Y9kcAsCl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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



On 11/15/2024 3:28 PM, Victor Zhao wrote:
> In a consecutive packet submission, for example unmap and query status,
> when CP is reading wptr caused by unmap packet doorbell ring, if in some
> case CP operates slower (e.g. doorbell_mode=1) and wptr has been updated
> to next packet (query status), but the query status packet content has
> not been flushed to memory yet, it will cause CP fetched stalled data.
> 
> Adding mb to ensure ring buffer has been updated before updating wptr.
> Also adding a mb to ensure wptr updated before doorbell ring.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 4843dcb9a5f7..55d18aed257b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -306,12 +306,17 @@ int kq_submit_packet(struct kernel_queue *kq)
>  	if (amdgpu_amdkfd_is_fed(kq->dev->adev))
>  		return -EIO;
>  
> +	/* Make sure ring buffer is updated before wptr updated */
> +	mb();
> +

Maybe add a specific comment here to indicate this is especially needed
in DOORBELL_MODE=1 when CP fetches value from WPTR memory instead of
doorbell packet.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
>  	if (kq->dev->kfd->device_info.doorbell_size == 8) {
>  		*kq->wptr64_kernel = kq->pending_wptr64;
> +		mb(); /* Make sure wptr updated before ring doorbell */
>  		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>  					kq->pending_wptr64);
>  	} else {
>  		*kq->wptr_kernel = kq->pending_wptr;
> +		mb(); /* Make sure wptr updated before ring doorbell */
>  		write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>  					kq->pending_wptr);
>  	}
