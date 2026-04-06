Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E45EF4ECA
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 10:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417118926F;
	Mon,  6 Apr 2026 10:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4f+eEd1f";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0658926F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 10:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxesYDMU3ipeS2DJFQKWG3ZrNYzfsDvXu1XIXtZ2RJXnGup4lpA88ChFgh9SEoyaJyGjjivg3Otc23LmpuvxQcNqZVakhUzT91YtD6x2Vmrg2dfnsx7V69rV+q8hIyNSKBTroDq8SXLlZuoEzImWEPG0ibR1UXPrpHYcLp17AOC6teFptv2HSXCqUDbARv4WD7mPffKfC+pGgoPsQfui+07GVC5UrxQNU/Pn/y9a2RXUUC4M8dgs0acYPeV2+7T4+pi60vibyofI4n5gXFIAbR1VccLwg1heJNjCz/uMcKxZ82hO7GwJ3FGit11KM1oiG+iOZ/V4NDKe37jTagD9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLLiKgadtO4rqcWtg2e+R2Svxe81ytgXWL8LuJFTeVQ=;
 b=rWpXbgClNPSWbgmul5S74L784VBKxYkQ7In2pM4c6ZSc4V8ZXRUtXstdJF70zsKaw8rRRc+2Y4Q80w/TbkQFKFwdoC8qooo37HEOqv93OdLoUKFXz1QON1EdcJVTnxV5Il/+05xDeMZZ3/oy1spdtOKQSBSwyZuj/SxQrCoy+1mhuyaft61LaA/+5b6fuDsOgCFa6NVjlqsyYstJkYEwOgCu1RggLLk9Mm+ogu+22Akpu/C5pzPCwGscr2hGVyUsfFsG1/wybqVbKecL0UPolM6q8SEkdBxd9h3QyjOxXoYhsbvJsl7F1WfvR9uKV8KpChrtyLLKa8DLqJABavHNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLLiKgadtO4rqcWtg2e+R2Svxe81ytgXWL8LuJFTeVQ=;
 b=4f+eEd1fjd2cvLcfwOWWwznFgm7aMAQAuQ5UIAS/pDfRwFvC9zKf/CgLv/kNNypkgoYK14e7awULHziHCaPkwp2e3Uim4cJxTQY39VFxZK97p9rXMQJVvzZpX7m/wq2WY8COzY7Ljfga6a8VOV+nAXjoRt6ndvGTi/OMrIDzjN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 10:08:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 10:08:47 +0000
Message-ID: <6891451b-9ae2-4db6-816e-7eec7e9b8aa9@amd.com>
Date: Mon, 6 Apr 2026 15:38:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for
 smu_v15_0_8
To: "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20260401163726.3811578-1-asad.kamal@amd.com>
 <DS7PR12MB6071B0FF7327B6FD3BDAAF988E5DA@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB6071B0FF7327B6FD3BDAAF988E5DA@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0226.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 299dd7de-4429-43f0-df46-08de93c47e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /+KYU05vKVZGabnl8jTqEDW5Yu0UiQ5qGWcSpYlT+GCpALV90fmnBPXNsCX3CmpYDitZloOi7XMw+VGxPUfR66+S8MUhihZ6le+YYbYwa8+PbsJdwiVrYbYRxqLAijUJl6H6Ynxfk4Yc1rn1dqIcgrdFaCWVMOeVvPUBfCxKgCZsNA1EPNWCSB6QLRzEOJG9t5WV8WKUl0Pw7s7mj1MNAgiTU5BC6RHtp4v4Jc99Ual2+K2zA24yuZAuCbMnia2WpiLPItFESBTRRQpeoAap6JiJlGEuei6d0czqptKfEjhwFaYpfZ4I8qT5Hx9xL9E3Sv/i9i5NNGNpnTCowkolFPmIxYj5cHIgAJ3lJyCUwllutagMJkI4YqJIdxtmT2bTVwXGed5nnMpYMM2xnKnNxf49mm5Yj8oH38w4VG4F09KADEX4oBkDE0eQyIDCLSVQDtJ6VDTQFfvvfw7S5wkZgnmRJAQslA9tLz0XVVIqIJ89W8gKtYbUklQl40YnGiBbjHqIT/tJg5rIeK01BjfHtU+3NXWkQJJgsewRZr2AZEzkBIsPghOK0XCFEuBYU8SqVwuvEOaX5op4pTWNasxVtZS1E1dEs95pRbdXPALnPmIjxAPKMUvbNho/a+Vqvxuse8ZB3XL29TT0h03/aUyv6l8vzphnsV++VEU8Boj9gAS0Jj9YN+VIR2cbUEEaPRnkVABN2HVgMSYdgU9oHCjdEhwmzB3h7+jnowG0KKgm4Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhFTnpXSWs4bjN4ckpEMjBCWEZKSThVc3ZjU0Y1dTRrM3ExRW5yN2hwaHd1?=
 =?utf-8?B?MmNxZXc0MW44WWM5REJEMC84SkRqaFRGbGJCMSsyTHV2UytJMFZKK2RrWWpW?=
 =?utf-8?B?V2R1UjY1RkJnaDJ3V3lZbFRVZHljbGpHb1VSaWVCdDZTcDBzdlJnVXBQSkNO?=
 =?utf-8?B?S0dhT1pDclZrMERBVlY4dkdSdE5rUVpKM2szYVNCdXdBRGYvay91UEdpRXZt?=
 =?utf-8?B?UVV3cm51dzhVOXFTRHJLMGlqcXZ4TTYzdDJuN28zUFFCczkzSUpjRm8vbFF4?=
 =?utf-8?B?VHV1UllvbjI0TEt1MERvSEtKcjloVHQ5bGlzK2NyRDgwS1FSUzdxYURDcGR3?=
 =?utf-8?B?WHVyS2pFbHBCUVFNcytwa3p6cjBQUDl1aVhCbEJVZVFVdVhEd2N4Zk5LeHdS?=
 =?utf-8?B?WHJvNU54Y21iU2M5Q3lQSGtPUUI3T3hwbVdHSHYzaXBaSEFtT3MwanYwQVZk?=
 =?utf-8?B?WlJlTTlFYmZkWXQ1TUl5WW00Y1BGMVd4MGR0MUFDcjF0Y05EWTNkUFVvMXVP?=
 =?utf-8?B?TXNJQm9WUDFZaVpKWmRydXBBajdhdWdYeXVNYTNtV2RmVCs2UERDSDZEWitL?=
 =?utf-8?B?ODhuYllzdXdKbHZxTEFpcURxRUhGWUlwSUkyY1FwdW5nSFhUc2JjSFpMTjQ1?=
 =?utf-8?B?QW5VU2IwbFNUU2tqVjFQa2o1MXhXUGNCQS81UnhyNnZKWS9JYXhaOHAzN2NJ?=
 =?utf-8?B?SmM0YmlEdU5POUV6THR0NUg0WlFDUVlYRG1tbkY5V0tOcnNaaEczNjRES1Nk?=
 =?utf-8?B?RklFTUdUMjcwQzVoVldqWTJJYm9kU1lZeHhXV1JLZVZXZ0ROYWJ0M1JOTklt?=
 =?utf-8?B?bXFvalVtV2k0UzV2VytESW11NEZOVzdnSU9FSVF5TGQ3Y0ZLSGxqSUJrNXN5?=
 =?utf-8?B?VzFvT2xVSDNEMkhHS1dsb0tZZXNCTFJ4NVkwcWkwblpkcW5EZDIxUXRQVkJw?=
 =?utf-8?B?Z1pJWGEvRVRvK2p4SzBzdW5JakZwUHpseUtZUjFuVFdTUGJzY1FlUitUQXN6?=
 =?utf-8?B?OFRJN2lOSTJJRmtvRlBBb1FzcWtkcXlQR04rUU9SNXlZNHlrTWRyOFhJUTNF?=
 =?utf-8?B?MzMvSFNzYUNtaGpjT0N3a3hKWWtlWkpmdG00cThnd25OYUF2L08vcUNscTY4?=
 =?utf-8?B?QnVUVFlWdzQwc1JvYlZjL09nUVgraFZDMU5HZ1FHNGRJOVFmWjBJOHV3N0pT?=
 =?utf-8?B?M1l2VlliZlNUY2QxM1BDeVU5VCt2QlluYWk4WE1LQnpub0d0RHAzNnk2SE5u?=
 =?utf-8?B?RUQrY1RHVnR1THFpQytlOWJZWDBwL0hIQnBKbEhkS2RMWWpWNWpNckxTU1VZ?=
 =?utf-8?B?bGtET0gxZW1tUmU4VUVveDBrYm9DdTExaWd5cjhKVjdtaE9ZOElOc1lPVjhL?=
 =?utf-8?B?MXdBWDh3SnBxcWFDOFR0REZKZ1M1SlBGZ2RSNE12alhxZFU1bVNXUzUxWlp1?=
 =?utf-8?B?Z2dQYldhZW5JWWE5b3liRElOQ1NDSkQvdllXV0RMTzlmbDhQWGVvU3Vlc2FJ?=
 =?utf-8?B?bFBHYUxpaHorZERPWjFJcDgrbXJGMXh5QlRIQWlFc0tZWHV3UXhzcmZEVWJy?=
 =?utf-8?B?ZDJhNlNDWGxNb0NPWjFzb2pERmI1WjM5eFlFRG5PSWxpRWVENzg1YkdBb21X?=
 =?utf-8?B?QlhBdExKSGUxUi9WSVRwS1R1clVlekVNUmo1RjVraGxLVkJ1citqRU95MEJy?=
 =?utf-8?B?ZzhNMGExdjlsVTF5QThESW1oVkExVlFzR2ZYWVZmendxRUxlZkx2V1pMYVdH?=
 =?utf-8?B?MDZYbkEzcmJHTFBURURwaEdWeTd0ckhDSTlCT0FkRnNMeVQ2UE85eTBLb0NZ?=
 =?utf-8?B?QWk3ZERVTHY5NStKeVlCZDJ0YlFMdnB1U3FmSERqV0h1ZTU1am5HMENVTGRE?=
 =?utf-8?B?S2pVVWVzZHBOYVVteGNEdWUwVk8zcDhpLzluRTVEakcrT2NpbEFSUVYyT2pI?=
 =?utf-8?B?aFIxUkFpb2J0VUh1V05MNDBqR3NYcGhaVVd6cDBVYlNyVU0zODNpeWlkdGJH?=
 =?utf-8?B?T0RIVnVWcXdhUnRoTFppbjJhSEV4QVhGQ0ZUMjdBb20xQjNZUFkvWGZMdmta?=
 =?utf-8?B?VzJYWHA2QTJHQnIwYzBvOG85TnEyZkJab0EwZm9pSG9oaXA2Snl3WEdFaUtt?=
 =?utf-8?B?UmxvWTFIWjlrVmxMa0hYdUV3U29sUjlNOGJZUzAxZUQ1cS9OdmFzSVpScVFh?=
 =?utf-8?B?VVJUVGpLNSt0Zll2V21xZkkyak5La3ArUWRyZEFjY0lHRExsSjJNd1lCNVRz?=
 =?utf-8?B?KzQ3UkdSMFdPUWN6bXFyUDF6M0tpRnY0SDNSRlNnaHh6REJxb2U1ZmllNmdi?=
 =?utf-8?Q?/9FNhWP1lLJCCU9Sfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299dd7de-4429-43f0-df46-08de93c47e08
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 10:08:47.4854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFoJr5YTCjf6QNRejASRdpyUgaw08ElGyt+l2yd2OqRfJqgnymfxEshZOH8q0Ndm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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



On 06-Apr-26 3:31 PM, Kamal, Asad wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> ping

Please hold off this for the timebeing.

Thanks,
Lijo

> 
> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Wednesday, April 1, 2026 10:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for smu_v15_0_8
> 
> NPM data is only defined for primary socket. On secondary nodes, return -EOPNOTSUPP instead of continuing, thereby exposing npm node only for master socket.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 756cf4ac00fa..b0faf57b0655 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -578,6 +578,9 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
>          struct smu_table *sys_table;
>          int ret;
> 
> +       if (smu->adev->gmc.xgmi.physical_node_id != 0)
> +               return -EOPNOTSUPP;
> +
>          if (sensor == AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
>                  /*TBD as of now put 0 */
>                  *value = 0;
> --
> 2.46.0
> 

