Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD721C6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 14:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E0910E916;
	Fri, 10 Mar 2023 14:53:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8C710E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 14:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2vLHOYsE+TP0HhMLro9tZTNMtNwoVxxJzXas11JG9rU/QxKMMdJADqmbmjZU30j4H6zl7H1qkzujWDaQbLlkOzUT9fNpDfrGB5HcqDcX3Q++BwleLla5QMO64aD9FjIpmiA0/8l1a4Xmf8d55FQ1us3B7odotYqQGSOSQMtlyh4ZNrzJTKG71kYVL2E8thUCjm1LmadE7JIj6k5fHnV5CfEqB7MeXkIi0E19+IWyO9oh6/nM/daBQtBepZmQjAh4DqzKqzHUvhpoJRrIV8tCJWHozvLn+z80QlWNrr+YQ6voHL3pJ/pA+oMkmON3raQO13f8RyP4BrCUDGm69cGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7ib2laBxuGttNqljX8MuBl+Q+cLlDR4RjvY4pOUOvY=;
 b=UQVWOBzNzQvyn0oeHA+6+RPoq9h7f67weDIrOwbA97501o7arYXJ/o7w2P7wbg2/wL8OD+wkCW6VEtwPR63JKTChW6i6IIivzeUnP814hSk1+ZSs5tPia5iJmnfiaqkqAZLYkj/W9WkNko8mJxjHXN5KFaGn+qOZP2lfaB3Tz5UEIMnaEGSpU30QvqOnK4MZSDWUyJzn6JNbckUx6BHMlrydXDtmo7xM6xM5E/88hbk+YOwWOlV4AQWjlYRz9TZwPYp5PE9A2xjMNHohIZYNuuzJYY40VGjmECCClXIzrIUKNzEVhhhUJRFWZg1pAJnQSwk1n5AVqUELU+p7vMAFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7ib2laBxuGttNqljX8MuBl+Q+cLlDR4RjvY4pOUOvY=;
 b=Y6waCyUVLIKLUCkZIaponMjzU91Jhq6j1bB2Qb3c289WFh04/3PZU9vXRY1JuD1aIP1bjNO8K4/LHcefoMhxMg1UUkz9tIiUTwOH8d18PmJ3EIuvYBhanqk4+dVEIGhQNtnkRw8n/5rlupLglnUv1GXe5QcVkcI5x8+lqZX1RAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 14:53:32 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 14:53:32 +0000
Message-ID: <76c2f411-5a82-f7bc-e185-fb6023c8fc61@amd.com>
Date: Fri, 10 Mar 2023 09:54:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] amd/display/debugfs: add sysfs entry to read PSR
 residency from firmware
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230310064312.17127-1-shirish.s@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230310064312.17127-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::28) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfd3840-cef7-4d03-e1dd-08db2177376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K73d8c9780Eodc4r7hrCM0mxs4ov4XgcWV2KPKQ1SyKnfDD3ttIOJ12/zC2XM4cxP6TmnEACKotesU2ZbJA4m1SwykjPvlFxgJxnp0gODDuDkQazyjsTEsrJJuk6KINmU2jtWi4YgpiQMPb65iL8tv+bsPnZFxE17CRlyBGhofydmy9YKnsAsqkD7cAJNgNGfOpl5lTzEYSeJSxjP58OmlnZJfvHvUcePyBZUMQi2DaUJhTnU6Qtdbtv5F1uUysEIgDzBRg0XtzAZI/qK+N7U2nXZNp2lufp2SLolMj5GXwoKEuEY+tTmiwgvGP7gUANB3krZhcKGBHI+pgFSn6S2hiC5uos37C5IHEaLOid9uaEgLZHPvRFD67jBvBZKS/F/DOHNIktCh+aB5knXySIIvrYpytxL990RNc5CAJCnAhH/OQR5da+C7HJi5KW/eqv634pL+oARj+ZyJFZ/DJr/U3oWWB2gzpab29CqX7gRuvxiLRt5EmkJlrEsDzUqTkXLQn3j+662BVU4ZEh4M/IplEIiy4EkBJ7dniPhrD7AFCURG9G5vlo7UVhq4tMR631iesWPbuS/4RnSuHU/4gPDNRen1rTDX5Bh/R/lbuRKV819jXXbbLve7IzXgTs5rjZ4gtA8tHjH2QJxQ2Pe2wfi82DdrQCUU11QDiqM326g0LeYBQxMY19CNZZNkAJOHThIznzoUIV1xgaBd/y5g6+IFT58vfU+5JswTz6NuJ+8xXL6I6jyGAqjKo6jyhlunYDJAF0g8MbAmdKtu8DDDEuQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(31686004)(44832011)(2906002)(5660300002)(6512007)(66476007)(26005)(8936002)(36756003)(110136005)(8676002)(41300700001)(66946007)(4326008)(6636002)(316002)(86362001)(66556008)(478600001)(31696002)(6486002)(6666004)(38100700002)(53546011)(6506007)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hKNzNiekF3NDhlM25qTlNYRlRKTmduSVZsSG05dUJKdnN6NWVLUjlONFNj?=
 =?utf-8?B?R0NTeTBwN09LSGQ0b2NtejFkM1ZOOVQzWFNxUkxWZFd0WlhNdmQwSmFNUDFF?=
 =?utf-8?B?dUhsWUMwanRzbEFqZnhUdlU1LzRqcU13ejZCT1JOaStvelJFSE8yUzZ0cTB1?=
 =?utf-8?B?K1YyMDVPaktNdEYremVDUUtBS2g2N0tyV3p4cEFhbWFlWkE1MEIvUmc2Qi85?=
 =?utf-8?B?ZldSaG1FVUxiWnNDTzlrY0ViRHBOb2tsQ0svM2NHZFdSR0lYOHlDdVRjdWhp?=
 =?utf-8?B?dExnK1BoUkg1eUlqa0l1TXBmUkpFT2lsRXJNOUdMNVBiOEVaY2JWbjhhTGJq?=
 =?utf-8?B?d1UxNW1UdFZWdnc3OTZMTGxMYkpvSUZvZytWOUhRZVFuOHFFVEhxcWh2R3JZ?=
 =?utf-8?B?VUZRa3dFN3g3bWJkS01CQ1VWa1VCaGRzMHIvTXZ2YnprVXNJYnEzSjdEYlJN?=
 =?utf-8?B?ZzZ2Q24wOTFSbVRlNTVDQkVISTMzalovSFd5dGVKYlpYN0ZXSDlyTE93Z0Jq?=
 =?utf-8?B?aERzWHBVV3hDem9DaGhUNnJsL0ZoWHY3ejFETmwvRUxZUFB0UThSdzVWOGJS?=
 =?utf-8?B?cmNWZHJjeXV6N3pUWW41Unh5RUNzc3cxWWZiSG1zV3FxVTE0cnZiVVd5NVRk?=
 =?utf-8?B?ZVJid1liOUZUN1dJeXA2Z3JnYUlSd1FvVFhYMmNZa1dYOWdvZUFiUGl2Zmwr?=
 =?utf-8?B?UHg3RXF0SmJ4NERDdzZObzYxS0xoWTRjRHN5eDFuUStBMHk1K25QalUyVDdQ?=
 =?utf-8?B?b3gvaWJKYVR4YWJJWGNhM24yb0RTVk10ek1sZjBWR2kwbHFBcmQ4RHpLNy83?=
 =?utf-8?B?ejZWM01kYnU2S1JESDhYTEJaV21DOXoxejR1M1NVOUZkWGtuZEhvbC9IM1Vv?=
 =?utf-8?B?cUhYOEQwbzRPckwwa2dBdnRQSnZrZ05TcHl5dXdCVzBWa1MwU3FKZTZzTHZh?=
 =?utf-8?B?WXNZRml2VXRRb2wrL052a3NwL1I5d1pwWkpFVk9ZZWx3dDZPVzd4MCt0N1Vj?=
 =?utf-8?B?aXlCODM5RVkzWmJncmVINWJMdlpYREpKNnhQaEdLMXUvRThXMzl5NVRDQzZi?=
 =?utf-8?B?UWVlWTF1MkVqMVplV1lrKzlhRDZqQUdkT2ZzSEp6Z1hrK1VDWUorNFlEaXht?=
 =?utf-8?B?V3poa2xVYTNTSDNrcU1MaHNqWDBtcGM3aCtyTi8xS1FxZ20rTjY0MWpyeE02?=
 =?utf-8?B?a2NCMVJNUFlqSDd4ak5tYVEwZ210QUoxMWgxM1VlTUxaTDJBRWR6SUtNczAy?=
 =?utf-8?B?bjR4ZDE5K1EvcktQeHFMVE0rWmVJclBuWCt4WVB2R3BENDQzeHRZamF2dlM0?=
 =?utf-8?B?RytSaklPT1V3cFBmclp3K1JXRHRBTjc5blNxeVgrOWRKeG5iZlVLV21LdGl6?=
 =?utf-8?B?OG51NW1mL2swb2cxVEU2T3hBZ1RpOHpJanI4bzI4TnlrRFRmMGIvOFl4SzEx?=
 =?utf-8?B?RUQzWW5YVkFvVkNxdDJBd1RraW51dHhxK05sS3Z5NXpXT0FaaHY3QXRzL0tn?=
 =?utf-8?B?WDQ0aEMxWEVDNm9GMjUzb05RSTNIU1hLWVd3ZXEvU1dhTHFhWXQ3b2l3MVZx?=
 =?utf-8?B?eVMrTllTTm8yN2RCUmdLbEhNZHg1WS9QMktqaTdHM09Md0JuNDhwWVNjUS9D?=
 =?utf-8?B?bXlRUXVhMEtYSVk5dm1pVUVVY1E4ZEpsLy9xUngyR0IyNk5IZzM5alFCVE9v?=
 =?utf-8?B?QXpDaStiVDV1eldBR0pDUHdxQ3p0Z0FHZkFtRmVlT2R6TUV3LzFXeHppN2xj?=
 =?utf-8?B?VDFyeWhOeUNOWCtTSGJqRnNDNzVRTUdLeUt4MWh0d2xxb1hFTStFd0NTMFgz?=
 =?utf-8?B?dXNJMHM3YlVKTFNGNVVwZWt2MjlHajMwOWZJOHY3MEdrc1g1Sk1CRGhIWnRl?=
 =?utf-8?B?YndXN3JyaVFuZVRGZUJheEY5TzF0Rlh0QTBvdXI3dEVXZ3RFcDArTWIrQ0Qw?=
 =?utf-8?B?UlhkcHQ0VTJNaUkvVng2RGgwZlowQ211Mm1xNHB0Unp5ZEhLRExWNnhLdFNm?=
 =?utf-8?B?OTBhVTlycXBTVTg1ZkU5QmVBVkNiUXB6SURVRTZCRldtYWNrRkMrUGJ2MlRy?=
 =?utf-8?B?TDd2ZU0zTDlYOTdjeWd0NFJrLzhmKy9ROW81M0h2Wmg5SnhzdTd6emxGSWs5?=
 =?utf-8?Q?CVaF/4pSSezM6n8gEI6fspci0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd3840-cef7-4d03-e1dd-08db2177376b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 14:53:31.9417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R44OTuMl9pOXUAUxS+OU014FAcyCspSlJ7TnFIGlxw/s6jdB744mZqJersDmx9ura0PB8SZlNlptHRxh58ggHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/10/23 01:43, Shirish S wrote:
> [Why]
> Currently there aren't any methods to determine PSR state residency.
> 
> [How]
> create a sysfs entry for reading residency and internally hook it up
> to existing functionality of reading PSR residency from firmware.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>

Applied, thanks!

> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index abf7895d1608..d8a5cde2b06f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -35,6 +35,7 @@
>   #include "resource.h"
>   #include "dsc.h"
>   #include "link_hwss.h"
> +#include "link.h"
>   #include "dc/dc_dmub_srv.h"
>   #include "link/protocols/link_dp_capability.h"
>   
> @@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
>   	return 0;
>   }
>   
> +/*
> + *  Read PSR state residency
> + */
> +static int psr_read_residency(void *data, u64 *val)
> +{
> +	struct amdgpu_dm_connector *connector = data;
> +	struct dc_link *link = connector->dc_link;
> +	u32 residency;
> +
> +	link_get_psr_residency(link, &residency);
> +
> +	*val = (u64)residency;
> +
> +	return 0;
> +}
> +
>   /*
>    * Set dmcub trace event IRQ enable or disable.
>    * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
> @@ -2828,6 +2845,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
>   			 dmcub_trace_event_state_set, "%llu\n");
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL, "%llu\n");
>   
>   DEFINE_SHOW_ATTRIBUTE(current_backlight);
>   DEFINE_SHOW_ATTRIBUTE(target_backlight);
> @@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>   	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
>   		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
>   		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
> +		debugfs_create_file_unsafe("psr_residency", 0444, dir, connector, &psr_residency_fops);
>   		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
>   				    &current_backlight_fops);
>   		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,

-- 
Hamza

